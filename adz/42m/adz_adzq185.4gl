#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1)
#+ 
#+ Filename...: adzq185
#+ Description: 憑證報表樣板(4rp)差異比對
#+ Creator....: 04010(2016-11-21 09:46:52)
#+ Modifier...: 04010(2016-11-21 09:46:52)
# Usage .........: 
# Input Parameter: g_argv1    新4rp檔案路徑 
#                  g_argv2    舊4rp檔案路徑
#                  g_argv3    報表樣板ID
#                  g_argv4    語言別
# Return code....: none
#+ Modifier...: No.161130-00066#1 16/11/30 Cynthia  提供報表樣板merge功能


IMPORT os
IMPORT util
DATABASE ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/adzq185_module.inc"

DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_browser_cnt        LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx        LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_current_idx        LIKE type_t.num10
DEFINE ga_file_info         T_FILE_INFO

PRIVATE DEFINE g_sr_field DYNAMIC ARRAY OF RECORD
   chkall       LIKE type_t.chr1,
   ###新值
   seqn         LIKE type_t.num10,       #序號(新)
   gzgg001n     LIKE gzgg_t.gzgg001,     #報表欄位代碼(新)
   gzge003n     LIKE gzge_t.gzge003,     #報表欄位說明(新)
   gzgg019n     LIKE gzgg_t.gzgg019,     #區塊類別(單頭/單身)(新)
   posxn        STRING,                  #定位點X(新)
   posyn        STRING,                  #定位點Y(新)
   gzgg005n     LIKE gzgg_t.gzgg005,     #欄位寬度(新)
   gzgg027n     LIKE gzgg_t.gzgg027,     #行序(新)
   gzgg004n     LIKE gzgg_t.gzgg004,     #欄位順序(新)
   l_fontn      STRING,                  #字型(新)
   l_sizen      DECIMAL,                 #字型大小(新)
   l_boldn      LIKE type_t.chr1,        #粗體否(新)
   colorn       STRING,                  #顏色(新)
   lblwidn      STRING,                  #欄位說明寬度(新)
   lblfontn     STRING,                  #欄位說明字型(新)
   lblsizen     DECIMAL,                 #欄位說明字型大小(新)
   lblboldn     LIKE type_t.chr1,        #欄位說明粗體否(新)
   lblcolorn    STRING,                  #欄位說明顏色(新)
   l_wrapn      LIKE type_t.chr1,        #折行否(新)
   vcn          STRING,                  #隱藏否(新)
   lblbvcn      STRING,                  #欄位說明隱藏否(新)
   agln         LIKE type_t.chr1,        #欄位對齊(新)
   lblagln      LIKE type_t.chr1,        #欄位說明對齊(新)
   vcrtln       STRING,                  #控制欄位隱藏公式(新)
   lblvcrtln    STRING,                  #欄位說明隱藏公式(新)
   drawn        STRING,                  #物件名稱(新)
   lbldrawn     STRING,                  #欄位物件名稱(新)
   ###舊值
   seq          LIKE type_t.num10,       #序號
   gzgg001      LIKE gzgg_t.gzgg001,     #報表欄位代碼
   gzge003      LIKE gzge_t.gzge003,     #報表欄位說明
   gzgg019      LIKE gzgg_t.gzgg019,     #區塊類別(單頭/單身)
   posx         STRING,                  #定位點X
   posy         STRING,                  #定位點Y
   gzgg005      LIKE gzgg_t.gzgg005,     #欄位寬度
   gzgg027      LIKE gzgg_t.gzgg027,     #行序
   gzgg004      LIKE gzgg_t.gzgg004,     #欄位順序
   l_font       STRING,                  #字型
   l_size       DECIMAL,                 #字型大小
   l_bold       LIKE type_t.chr1,        #粗體否
   color        STRING,                  #顏色
   lblwid       STRING,                  #欄位說明寬度
   lblfont      STRING,                  #欄位說明字型
   lblsize      DECIMAL,                 #欄位說明字型大小
   lblbold      LIKE type_t.chr1,        #欄位說明粗體否
   lblcolor     STRING,                  #欄位說明顏色
   l_wrap       LIKE type_t.chr1,        #折行否
   vc           STRING,                  #隱藏否
   lblbvc       STRING,                  #欄位說明隱藏否
   agl          LIKE type_t.chr1,        #欄位對齊
   lblagl       LIKE type_t.chr1,        #欄位說明對齊
   vcrtl        STRING,                  #控制欄位隱藏公式
   lblvcrtl     STRING ,                 #欄位說明隱藏公式
   draw         STRING,                  #物件名稱
   lbldraw      STRING                  #欄位物件名稱   
END RECORD

PRIVATE DEFINE g_diff DYNAMIC ARRAY OF RECORD
    check       LIKE type_t.chr1,        #使用舊值
    column_id   STRING,     #欄位代號
    type        STRING,       #類型(Label/Value)
    property    LIKE type_t.chr10,       #屬性
    new_value   LIKE type_t.chr1000,     #新值
    old_value   LIKE type_t.chr1000,     #舊值
    diff        LIKE type_t.chr1,        #是否有差異(Y/N)
    column_name LIKE type_t.chr500,      #4rp記錄的欄位名稱
    tagname     LIKE type_t.chr300,      #tag的名稱
    lineno      LIKE type_t.num5         #來源陣列的行數
END RECORD

DEFINE g_lang_now LIKE gzzy_t.gzzy001 

PRIVATE DEFINE g_wc                 STRING
PRIVATE DEFINE g_sql                STRING
PRIVATE DEFINE g_rec_b              LIKE type_t.num5     # 單身筆數
PRIVATE DEFINE l_ac                 LIKE type_t.num5     # 目前處理的ARRAY CNT
PRIVATE DEFINE g_msg                LIKE type_t.chr1000
PRIVATE DEFINE g_jump               LIKE type_t.num10
PRIVATE DEFINE g_no_ask             LIKE type_t.num5
PRIVATE DEFINE g_argv1              STRING
PRIVATE DEFINE g_argv2              STRING
PRIVATE DEFINE g_argv3              STRING
PRIVATE DEFINE g_argv4              STRING
PRIVATE DEFINE g_gzgd000            LIKE gzgd_t.gzgd000
PRIVATE DEFINE g_gzge002            LIKE gzge_t.gzge002
PRIVATE DEFINE g_4rppath_new        STRING
PRIVATE DEFINE g_4rppath_old        STRING

DEFINE g_chk_err_msg                STRING   #檢查報表命名規則的錯誤訊息
DEFINE g_ac                         LIKE type_t.num5


MAIN
   DEFINE ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   DEFINE l_gzgd012   LIKE gzgd_t.gzgd012  #中越文樣板
   DEFINE obj_file_list util.JSONObject,
          ls_prog_list  STRING #為了JSONArray傳遞陣列參數的過渡變數
 
   OPTIONS                                 #改變一些系統預設值
   INPUT NO WRAP,
   FIELD ORDER FORM                        #整個畫面欄位輸入會依照p_per所設定的順序(忽略4gl寫的順序)
   DEFER INTERRUPT                         #擷取中斷鍵, 由程式處理

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
   #WHENEVER ERROR CONTINUE

   IF NUM_ARGS() < 2 THEN
      DISPLAY "請指定4rp路徑，或執行adzq186挑選檔案"
      EXIT PROGRAM -1
   END IF

   LET ls_prog_list = ARG_VAL(2)
   LET obj_file_list = util.JSONObject.parse(ls_prog_list)
   CALL obj_file_list.toFGL(ga_file_info)

   LET g_4rppath_new = ga_file_info.left_orig
   LET g_4rppath_old = ga_file_info.right_orig
   DISPLAY "g_4rppath_new:",g_4rppath_new
   DISPLAY "g_4rppath_old:",g_4rppath_old

#   LET g_4rppath_old = "/u1/t10dev/erp/axm/4rp/zh_TW/axmr400_g01.4rp"
#   LET g_4rppath_new = "/ut/t10dev/tmp/axmr400_g01.4rp"
#   LET g_4rppath_new = "/u1/t10dev/erp/axm/4rp/zh_TW/axmr400_g01.4rp"
#   LET g_4rppath_old = "/ut/t10dev/tmp/axmr400_g01.4rp"
    
   LET g_gzge002 = NULL
   IF NUM_ARGS() >= 4 THEN
      LET g_argv4 = ARG_VAL(3)
      LET g_gzge002 = g_argv4
   END IF


   #畫面開啟 (identifier)
   OPEN WINDOW w_adzq185 WITH FORM cl_ap_formpath("adz", "adzq185")
   CLOSE WINDOW SCREEN

   CALL cl_tool_init()

   CALL cl_ui_wintitle(1)            #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)
      
   #程式初始化
   CALL adzq185_init()
   
   LET gwin_curr = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL gwin_curr.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")

   IF NOT cl_null(g_4rppath_new) THEN
      CALL adzq185_query()
   END IF

   IF NOT cl_null(g_gzgd000) THEN
      SELECT gzgd012 INTO l_gzgd012 FROM gzgd_t WHERE gzgd000 = g_gzgd000
      IF l_gzgd012 = "Y" THEN
         MESSAGE "中越文樣版只能維護越文欄位"
      END IF
   END IF
   
   #進入選單 Menu (="N")
   CALL adzq185_ui_dialog()
   
   CLOSE WINDOW w_adzq185

   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN

#+ 畫面資料初始化
PRIVATE FUNCTION adzq185_init()

   LET g_detail_idx = 1
   
   #設定語言別選項
   CALL cl_set_combo_lang("l_lang")

   CALL cl_set_combo_scc('l_property','247')
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
END FUNCTION

PRIVATE FUNCTION adzq185_read4rp(p_4rppath,p_loc)
   DEFINE p_4rppath  STRING
   DEFINE p_loc      LIKE type_t.chr10
   DEFINE l_doc      om.DomDocument
   DEFINE l_rootnode om.DomNode
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_j        LIKE type_t.num5
   DEFINE l_sql      STRING
   DEFINE l_found    LIKE type_t.num5
   DEFINE l_lastidx  LIKE type_t.num5
   DEFINE l_gzge003  LIKE gzge_t.gzge003
   DEFINE l_field    DYNAMIC ARRAY OF type_g_field
   DEFINE l_flag     LIKE type_t.chr1

   IF NOT os.Path.exists(p_4rppath) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00676'
      LET g_errparam.extend = p_4rppath
      LET g_errparam.popup = TRUE
      CALL cl_err()
      DISPLAY "File not found: ",p_4rppath
      EXIT PROGRAM -2
   END IF
   LET l_doc = om.DomDocument.createFromXmlFile(p_4rppath)
   LET l_rootnode = l_doc.getDocumentElement()

   CALL l_field.clear()
   
   LET g_chk_err_msg = NULL

   #讀4rp到陣列
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"WORDBOX",g_gzge002,g_gzgd000,'1',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"WORDBOX",g_gzge002,g_gzgd000,'2',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"WORDWRAPBOX",g_gzge002,g_gzgd000,'1',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"WORDWRAPBOX",g_gzge002,g_gzgd000,'2',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"DECIMALFORMATBOX",g_gzge002,g_gzgd000,'1',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"DECIMALFORMATBOX",g_gzge002,g_gzgd000,'2',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"PAGENOBOX",g_gzge002,g_gzgd000,'1',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"PAGENOBOX",g_gzge002,g_gzgd000,'2',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"IMAGEBOX",g_gzge002,g_gzgd000,'1',p_loc)
   CALL sadzq185_01_readnodes(l_field,l_rootnode,"IMAGEBOX",g_gzge002,g_gzgd000,'2',p_loc)

   #顯示檢查命名規則的錯誤訊息
   IF g_chk_err_msg IS NOT NULL THEN
#      CALL cl_err(g_chk_err_msg,"!",-1)
   END IF

   IF p_loc = "new" THEN
      #將新資料新增到SCREEN RECORD
      FOR l_i = 1 TO l_field.getLength()
         LET g_sr_field[l_i].seqn = l_field[l_i].seq CLIPPED
         LET g_sr_field[l_i].gzgg001n = l_field[l_i].gzgg001 CLIPPED
         LET g_sr_field[l_i].gzge003n = l_field[l_i].gzge003 CLIPPED
         LET g_sr_field[l_i].gzgg019n = l_field[l_i].gzgg019 CLIPPED
         LET g_sr_field[l_i].posxn = l_field[l_i].posx CLIPPED
         LET g_sr_field[l_i].posyn = l_field[l_i].posy CLIPPED
         LET g_sr_field[l_i].gzgg005n = l_field[l_i].gzgg005 CLIPPED
         LET g_sr_field[l_i].gzgg027n = l_field[l_i].gzgg027 CLIPPED
         LET g_sr_field[l_i].gzgg004n = l_field[l_i].gzgg004 CLIPPED
         LET g_sr_field[l_i].l_fontn = l_field[l_i].l_font CLIPPED
         LET g_sr_field[l_i].l_sizen = l_field[l_i].l_size CLIPPED
         LET g_sr_field[l_i].l_boldn = l_field[l_i].l_bold CLIPPED
         LET g_sr_field[l_i].colorn = l_field[l_i].color CLIPPED
         LET g_sr_field[l_i].lblwidn = l_field[l_i].lblwid CLIPPED
         LET g_sr_field[l_i].lblfontn = l_field[l_i].lblfont CLIPPED
         LET g_sr_field[l_i].lblsizen = l_field[l_i].lblsize CLIPPED
         LET g_sr_field[l_i].lblboldn = l_field[l_i].lblbold CLIPPED
         LET g_sr_field[l_i].lblcolorn = l_field[l_i].lblcolor CLIPPED
         LET g_sr_field[l_i].l_wrapn = l_field[l_i].l_wrap CLIPPED
         LET g_sr_field[l_i].vcn = l_field[l_i].vc CLIPPED
         LET g_sr_field[l_i].lblbvcn = l_field[l_i].lblbvc CLIPPED
         LET g_sr_field[l_i].agln = l_field[l_i].agl CLIPPED
         LET g_sr_field[l_i].lblagln = l_field[l_i].lblagl CLIPPED 
         LET g_sr_field[l_i].vcrtln = l_field[l_i].vcrtl CLIPPED
         LET g_sr_field[l_i].lblvcrtln = l_field[l_i].lblvcrtl CLIPPED
         LET g_sr_field[l_i].drawn = l_field[l_i].draw CLIPPED
         LET g_sr_field[l_i].lbldrawn = l_field[l_i].lbldraw CLIPPED

      END FOR

      CALL l_field.clear() #Free Memory
   ELSE
      #將舊資料新增到SCREEN RECORD
      FOR l_i = 1 TO l_field.getLength()
         LET l_flag = "N"
         FOR l_j = 1 TO g_sr_field.getLength()
            IF l_field[l_i].gzgg001 = g_sr_field[l_j].gzgg001n THEN
               LET g_sr_field[l_j].seq = l_field[l_i].seq CLIPPED
               LET g_sr_field[l_j].gzgg001 = l_field[l_i].gzgg001 CLIPPED
               LET g_sr_field[l_j].gzge003 = l_field[l_i].gzge003 CLIPPED
               LET g_sr_field[l_j].gzgg019 = l_field[l_i].gzgg019 CLIPPED
               LET g_sr_field[l_j].posx = l_field[l_i].posx CLIPPED
               LET g_sr_field[l_j].posy = l_field[l_i].posy CLIPPED
               LET g_sr_field[l_j].gzgg005 = l_field[l_i].gzgg005 CLIPPED
               LET g_sr_field[l_j].gzgg027 = l_field[l_i].gzgg027 CLIPPED
               LET g_sr_field[l_j].gzgg004 = l_field[l_i].gzgg004 CLIPPED
               LET g_sr_field[l_j].l_font= l_field[l_i].l_font CLIPPED
               LET g_sr_field[l_j].l_size = l_field[l_i].l_size CLIPPED
               LET g_sr_field[l_j].l_bold = l_field[l_i].l_bold CLIPPED
               LET g_sr_field[l_j].color = l_field[l_i].color CLIPPED
               LET g_sr_field[l_j].lblwid = l_field[l_i].lblwid CLIPPED
               LET g_sr_field[l_j].lblfont = l_field[l_i].lblfont CLIPPED
               LET g_sr_field[l_j].lblsize = l_field[l_i].lblsize CLIPPED
               LET g_sr_field[l_j].lblbold = l_field[l_i].lblbold CLIPPED
               LET g_sr_field[l_j].lblcolor = l_field[l_i].lblcolor CLIPPED
               LET g_sr_field[l_j].l_wrap = l_field[l_i].l_wrap CLIPPED
               LET g_sr_field[l_j].vc = l_field[l_i].vc CLIPPED
               LET g_sr_field[l_j].lblbvc = l_field[l_i].lblbvc CLIPPED
               LET g_sr_field[l_j].agl = l_field[l_i].agl CLIPPED
               LET g_sr_field[l_j].lblagl = l_field[l_i].lblagl CLIPPED 
               LET g_sr_field[l_j].vcrtl = l_field[l_i].vcrtl CLIPPED
               LET g_sr_field[l_j].lblvcrtl = l_field[l_i].lblvcrtl CLIPPED     
               LET g_sr_field[l_j].draw = l_field[l_i].draw CLIPPED 
               LET g_sr_field[l_j].lbldraw = l_field[l_i].lbldraw CLIPPED 
               LET l_flag = "Y"
               
            END IF
        END FOR
        IF l_flag = "N" THEN
           LET l_j = g_sr_field.getLength() + 1
           LET g_sr_field[l_j].seq = l_field[l_i].seq CLIPPED
           LET g_sr_field[l_j].gzgg001 = l_field[l_i].gzgg001 CLIPPED
           LET g_sr_field[l_j].gzge003 = l_field[l_i].gzge003 CLIPPED
           LET g_sr_field[l_j].gzgg019 = l_field[l_i].gzgg019 CLIPPED
           LET g_sr_field[l_j].posx = l_field[l_i].posx CLIPPED
           LET g_sr_field[l_j].posy = l_field[l_i].posy CLIPPED
           LET g_sr_field[l_j].gzgg005 = l_field[l_i].gzgg005 CLIPPED
           LET g_sr_field[l_j].gzgg027 = l_field[l_i].gzgg027 CLIPPED
           LET g_sr_field[l_j].gzgg004 = l_field[l_i].gzgg004 CLIPPED
           LET g_sr_field[l_j].l_font= l_field[l_i].l_font CLIPPED
           LET g_sr_field[l_j].l_size = l_field[l_i].l_size CLIPPED
           LET g_sr_field[l_j].l_bold = l_field[l_i].l_bold CLIPPED
           LET g_sr_field[l_j].color = l_field[l_i].color CLIPPED
           LET g_sr_field[l_j].lblwid = l_field[l_i].lblwid CLIPPED
           LET g_sr_field[l_j].lblfont = l_field[l_i].lblfont CLIPPED
           LET g_sr_field[l_j].lblsize = l_field[l_i].lblsize CLIPPED
           LET g_sr_field[l_j].lblbold = l_field[l_i].lblbold CLIPPED
           LET g_sr_field[l_j].lblcolor = l_field[l_i].lblcolor CLIPPED
           LET g_sr_field[l_j].l_wrap = l_field[l_i].l_wrap CLIPPED
           LET g_sr_field[l_j].vc = l_field[l_i].vc CLIPPED
           LET g_sr_field[l_j].lblbvc = l_field[l_i].lblbvc CLIPPED
           LET g_sr_field[l_j].agl = l_field[l_i].agl CLIPPED
           LET g_sr_field[l_j].lblagl = l_field[l_i].lblagl CLIPPED 
           LET g_sr_field[l_j].vcrtl = l_field[l_i].vcrtl CLIPPED
           LET g_sr_field[l_j].lblvcrtl = l_field[l_i].lblvcrtl CLIPPED     
           LET g_sr_field[l_j].draw = l_field[l_i].draw CLIPPED
           LET g_sr_field[l_j].lbldraw = l_field[l_i].lbldraw CLIPPED
           
        END IF
     END FOR

     CALL l_field.clear() #Free Memory
   END IF
END FUNCTION

#查詢語言別
PRIVATE FUNCTION adzq185_lang_curs()             # QBE 查詢資料
   CLEAR FORM                                    # 清除畫面
   CALL g_sr_field.clear()

   #取所有語言別
   LET g_sql = "SELECT DISTINCT gzzy001 FROM gzzy_t",
               " WHERE gzzy001 IS NOT NULL AND gzzystus='Y'" 
 
   IF NOT cl_null(g_gzge002) THEN
      LET g_wc = " AND gzzy001 = '",g_gzge002 CLIPPED,"'"
      LET g_sql = g_sql,g_wc
   END IF

   LET g_sql = g_sql," ORDER BY gzzy001"
 
   PREPARE adzq185_lang_pre FROM g_sql           # 預備一下
   DECLARE adzq185_lang_curs                     # 宣告成可捲動的
      SCROLL CURSOR WITH HOLD FROM g_sql
END FUNCTION

FUNCTION adzq185_count()
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE l_gzzy001  LIKE gzzy_t.gzzy001
   
   DECLARE adzq185_count_curs CURSOR FROM g_sql
   LET li_cnt = 1
   FOREACH adzq185_count_curs INTO l_gzzy001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET li_cnt = li_cnt + 1
    END FOREACH
    IF li_cnt >= 1 THEN
      LET li_cnt = li_cnt - 1
    END IF
    LET g_browser_cnt = li_cnt
END FUNCTION
 
FUNCTION adzq185_ui_dialog()
   DEFINE l_filename      STRING
   DEFINE l_chk_buf       LIKE type_t.chr1
   DEFINE l_chk_t         LIKE type_t.chr1
   
   WHILE TRUE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT ARRAY g_diff FROM s_detail1.* 
             ATTRIBUTE(COUNT = g_detail_cnt,
                     INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=FALSE)

            BEFORE INPUT
               LET l_filename = os.Path.basename(g_4rppath_new)
               DISPLAY l_filename TO FORMONLY.l_file_desc
               IF g_ac > 0 THEN 
                  LET l_ac = g_ac
               ELSE
                  LET l_ac = 1
               END IF
               CALL FGL_SET_ARR_CURR(l_ac)
               CALL cl_navigator_setting(g_current_idx, g_detail_cnt)  
               
            BEFORE ROW
               LET l_ac = ARR_CURR()   #取得現在所在行
               CALL cl_set_comp_entry("l_check",TRUE)
         
               CALL cl_show_fld_cont()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_diff.getLength() TO FORMONLY.cnt
               
            ON CHANGE l_check
         
            ON ACTION btn_sel_all
               LET g_action_choice = 'btn_sel_all'
               CALL adzq185_sel_all_diff('Y')

            ON ACTION btn_cancel_all
               LET g_action_choice = 'btn_cancel_all'
               CALL adzq185_sel_all_diff('N')
               
            ON ACTION btn_save4rp
               LET g_action_choice = 'btn_save4rp'
               CALL adzq185_save4rp()
         END INPUT
   
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)

         ON ACTION first                            # 第一筆
            CALL adzq185_fetch('F')
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(1)
            END IF

         ON ACTION previous                         # P.上筆
            CALL adzq185_fetch('P')
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()               
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(1)
            END IF

         ON ACTION jump                             # 指定筆
            CALL adzq185_fetch('/')
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()  
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(1)
            END IF

         ON ACTION next                             # N.下筆
            CALL adzq185_fetch('N')
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()  
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(1)
            END IF

         ON ACTION last                             # 最終筆
            CALL adzq185_fetch('L')
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()  
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(1)
            END IF
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
            
            CONTINUE DIALOG            
      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
   END WHILE

END FUNCTION

#+ 資料查詢QBE功能準備 
FUNCTION adzq185_query()
   #MESSAGE ""
   LET g_current_idx = 0
   LET g_detail_cnt = 0
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""

   #清除畫面及相關資料
   CLEAR FORM                #清除畫面
   CALL g_sr_field.clear()   #清除單身
   CALL g_diff.clear()       #清除單身

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL adzq185_lang_curs()                       #取得查詢條件
   IF INT_FLAG THEN                               #使用者不玩了
      LET INT_FLAG = 0
      RETURN
   END IF
   OPEN adzq185_lang_curs                         #從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.SQLCODE THEN                          #有問題
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'adzq185_query'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      INITIALIZE g_gzge002 TO NULL
      LET g_gzge002 = ""
   ELSE
      CALL adzq185_count()
      DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
      CALL adzq185_fetch('F')                    #讀出TEMP第一筆並顯示
    END IF
END FUNCTION
 
FUNCTION adzq185_fetch(p_flag)                  #處理資料的讀取
   DEFINE   p_flag   LIKE type_t.chr1           #處理方式
 
   MESSAGE ""
   CASE p_flag
      WHEN 'N' FETCH NEXT     adzq185_lang_curs INTO g_gzge002
      WHEN 'P' FETCH PREVIOUS adzq185_lang_curs INTO g_gzge002
      WHEN 'F' FETCH FIRST    adzq185_lang_curs INTO g_gzge002
      WHEN 'L' FETCH LAST     adzq185_lang_curs INTO g_gzge002
      WHEN '/' 
         IF (NOT g_no_ask) THEN 
            CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0
               
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         FETCH ABSOLUTE g_jump adzq185_lang_curs INTO g_gzge002
         LET g_no_ask = FALSE
   END CASE
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'g_gzge002'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      INITIALIZE g_gzge002 TO NULL
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_detail_cnt
         WHEN '/' LET g_current_idx = g_jump          --改g_jump
      END CASE
 
      CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
 
      CALL adzq185_show()
   END IF
END FUNCTION
 
FUNCTION adzq185_show()                         # 將資料顯示在畫面上
   DISPLAY g_gzge002 TO gzge002
   LET g_lang_now = g_gzge002
   CALL adzq185_b_fill(g_wc)                    # 單身
   CALL cl_show_fld_cont()
END FUNCTION

FUNCTION adzq185_b_fill(p_wc)               #BODY FILL UP
   DEFINE p_wc         STRING
   DEFINE l_i          LIKE type_t.num5
   
   LET g_ac = 1
   CALL g_sr_field.clear()
   
   CALL adzq185_read4rp(g_4rppath_new,"new")
   CALL adzq185_read4rp(g_4rppath_old,"old")
   LET g_rec_b = g_sr_field.getLength()
   DISPLAY g_rec_b TO FORMONLY.cn2

   CALL adzq185_move_to()

   LET l_i = g_diff.getlength()
   #比對結果一致
   IF l_i = 0 THEN 
      CLOSE WINDOW w_adzq185   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-01024'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #離開作業
      CALL cl_ap_exitprogram("0")      
   END IF

END FUNCTION

#將原陣列轉到新的比對陣列
FUNCTION adzq185_move_to() 
   DEFINE l_i,l_j       LIKE type_t.num5
   DEFINE l_line        LIKE type_t.num10
   DEFINE l_fieldname   STRING

    CALL g_diff.clear()
    LET l_line = 1
    FOR l_i = 1 TO g_sr_field.getlength()
        IF NOT cl_null(g_sr_field[l_i].gzgg001n) THEN
           LET l_fieldname = g_sr_field[l_i].drawn,"+",g_sr_field[l_i].lbldrawn   #物件名稱
        ELSE
           LET l_fieldname = g_sr_field[l_i].draw,"+",g_sr_field[l_i].lbldraw   #物件名稱
        END IF

       ###欄位增減
        IF cl_null(g_sr_field[l_i].gzgg001n) OR cl_null(g_sr_field[l_i].gzgg001) THEN
           LET g_diff[l_line].check = 'N'      
        
           IF cl_null(g_sr_field[l_i].gzgg001n) THEN  #新值沒有,舊值有
              LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001
              LET g_diff[l_line].new_value = 'N'
              LET g_diff[l_line].old_value = 'Y'
           END IF

           IF cl_null(g_sr_field[l_i].gzgg001) THEN  #新值有,舊值沒有
              LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
              LET g_diff[l_line].new_value = 'Y'
              LET g_diff[l_line].old_value = 'N'
           END IF
   
           LET g_diff[l_line].property = '24'
           LET g_diff[l_line].type = 'Label+Value'
           LET g_diff[l_line].lineno = l_i
           LET g_diff[l_line].tagname = l_fieldname
              
           LET l_line = l_line+1 
           CONTINUE FOR
       END IF
       
       ###Label+Value屬性
       #1.報表樣板區段(gzgg019)
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label+Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '1'
        LET g_diff[l_line].new_value = g_sr_field[l_i].gzgg019n
        LET g_diff[l_line].old_value = g_sr_field[l_i].gzgg019
        LET g_diff[l_line].tagname = l_fieldname
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN
           CALL g_diff.deleteElement(l_line)
        ELSE 
           LET l_line = l_line+1 
        END IF #只保留新舊值有差異的
       #2.定位點X(posx) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label+Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '2'
        LET g_diff[l_line].new_value = g_sr_field[l_i].posxn
        LET g_diff[l_line].old_value = g_sr_field[l_i].posx
        LET g_diff[l_line].tagname = l_fieldname
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN#只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #3.定位點Y(posy) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label+Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '3'
        LET g_diff[l_line].new_value = g_sr_field[l_i].posyn
        LET g_diff[l_line].old_value = g_sr_field[l_i].posy
        LET g_diff[l_line].tagname = l_fieldname
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN#只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
        #5.行序(gzgg027) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label+Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '5'
        LET g_diff[l_line].new_value = g_sr_field[l_i].gzgg027n
        LET g_diff[l_line].old_value = g_sr_field[l_i].gzgg027
        LET g_diff[l_line].tagname = l_fieldname
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #6.欄位順序(gzgg004)
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label+Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '6'
        LET g_diff[l_line].new_value = g_sr_field[l_i].gzgg004n
        LET g_diff[l_line].old_value = g_sr_field[l_i].gzgg004
        LET g_diff[l_line].tagname = l_fieldname
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 

      ###Label屬性
      #11.欄位說明寬度(lblwid) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '11'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblwidn
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblwid
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #12.欄位說明字型(lblfont) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '12'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblfontn
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblfont
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #13.欄位說明字型大小(lblsize)
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '13'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblsizen
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblsize
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #14.欄位說明粗體(lblbold) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '14'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblboldn
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblbold
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #15.欄位說明顏色(lblcolor)
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '15'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblcolorn
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblcolorn
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #18.欄位說明隱藏(lblbvc) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '18'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblbvcn
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblbvc
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱                
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #19.欄位說明(gzge003) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '19'
        LET g_diff[l_line].new_value = g_sr_field[l_i].gzge003n
        LET g_diff[l_line].old_value = g_sr_field[l_i].gzge003
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱                
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        LET g_diff[l_line].column_name = g_sr_field[l_i].gzge003n #記錄4rp中的欄位名稱
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #21.欄位說明對齊(lblagl) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '21'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblagln
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblagl
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #23.欄位說明顯示公式(lblvcrtl)
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Label'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '23'
        LET g_diff[l_line].new_value = g_sr_field[l_i].lblvcrtln
        LET g_diff[l_line].old_value = g_sr_field[l_i].lblvcrtl
        LET g_diff[l_line].tagname = g_sr_field[l_i].lbldrawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 

       ###Value屬性        
       #4.欄位寬度(gzgg005) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '4'
        LET g_diff[l_line].new_value = g_sr_field[l_i].gzgg005n
        LET g_diff[l_line].old_value = g_sr_field[l_i].gzgg005
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN#只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 

       #7.字型(l_font) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '7'
        LET g_diff[l_line].new_value = g_sr_field[l_i].l_fontn
        LET g_diff[l_line].old_value = g_sr_field[l_i].l_font
       LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱        
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #8.字型大小(l_size) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '8'
        LET g_diff[l_line].new_value = g_sr_field[l_i].l_sizen
        LET g_diff[l_line].old_value = g_sr_field[l_i].l_size
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #9.粗體(l_bold) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '9'
        LET g_diff[l_line].new_value = g_sr_field[l_i].l_boldn
        LET g_diff[l_line].old_value = g_sr_field[l_i].l_bold
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #10.顏色(color)
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '10'
        LET g_diff[l_line].new_value = g_sr_field[l_i].colorn
        LET g_diff[l_line].old_value = g_sr_field[l_i].color
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #17.隱藏(vc) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '17'
        LET g_diff[l_line].new_value = g_sr_field[l_i].vcn
        LET g_diff[l_line].old_value = g_sr_field[l_i].vc
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱                
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #16.折行(l_wrap) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '16'
        LET g_diff[l_line].new_value = g_sr_field[l_i].l_wrapn
        LET g_diff[l_line].old_value = g_sr_field[l_i].l_wrap
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱        
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 
       #20.欄位對齊(agl) 
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '20'
        LET g_diff[l_line].new_value = g_sr_field[l_i].agln
        LET g_diff[l_line].old_value = g_sr_field[l_i].agl
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱        
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF         
       #22.欄位顯示公式(vcrtl)
        LET g_diff[l_line].check = 'N'
        LET g_diff[l_line].column_id = g_sr_field[l_i].gzgg001n
        LET g_diff[l_line].type = 'Value'
        LET g_diff[l_line].lineno = l_i
        LET g_diff[l_line].property = '22'
        LET g_diff[l_line].new_value = g_sr_field[l_i].vcrtln
        LET g_diff[l_line].old_value = g_sr_field[l_i].vcrtl
        LET g_diff[l_line].tagname = g_sr_field[l_i].drawn   #物件名稱        
        LET g_diff[l_line].diff = adzq185_chkdiff(g_diff[l_line].new_value,g_diff[l_line].old_value)
        IF g_diff[l_line].diff = 'N' THEN #只保留新舊值有差異的
           CALL g_diff.deleteElement(l_line) 
        ELSE 
           LET l_line = l_line+1 
        END IF 



    END FOR

    CALL g_diff.deleteElement(l_line)
    LET l_line=l_line - 1
    DISPLAY l_line TO cn2

END FUNCTION

FUNCTION adzq185_chkdiff(p_new_value,p_old_value)
   DEFINE p_new_value  LIKE type_t.chr1000
   DEFINE p_old_value  LIKE type_t.chr1000

   #兩者皆為空則回傳N
    IF cl_null(p_new_value) AND cl_null(p_old_value) THEN
       RETURN 'N'
    END IF

   #兩者其中一個為空則回傳Y
    IF cl_null(p_new_value) OR cl_null(p_old_value) THEN
       RETURN 'Y'
    END IF
    
   #兩者不同時回傳Y
    IF p_new_value <> p_old_value THEN
       RETURN 'Y'
    ELSE
       RETURN 'N'
    END IF

END FUNCTION

#161130-00066#1 add(s)
FUNCTION adzq185_sel_all_diff(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   DEFINE i       LIKE type_t.num5
   
   FOR i = 1 TO g_diff.getlength()
      LET g_diff[i].check = p_cmd
   END FOR
END FUNCTION 

PRIVATE FUNCTION adzq185_save4rp()
   DEFINE l_gzgd001    LIKE gzgd_t.gzgd001
   DEFINE l_gzgd002    LIKE gzgd_t.gzgd002
   DEFINE l_gzde001    LIKE gzde_t.gzde001   #報表元件代號
   DEFINE l_cmd        STRING
   DEFINE l_4rpdir     STRING
   DEFINE l_4rppath    STRING
   DEFINE l_result     LIKE type_t.num5
   DEFINE l_delete     SMALLINT              #刪除檔案返回之參數
   DEFINE li_mkdir     BOOLEAN

   LET l_result = FALSE

   LET l_4rpdir = FGL_GETENV("TEMPDIR")||os.Path.separator()||"4rp"
   IF NOT os.Path.exists(l_4rpdir) THEN
      CALL os.Path.mkdir(l_4rpdir) RETURNING li_mkdir
   END IF
   LET l_4rppath = os.Path.basename(g_4rppath_new)
   LET l_4rppath = os.Path.join(l_4rpdir, l_4rppath)

   DISPLAY "l_4rppath:",l_4rppath
   #檢查來源與目的檔是否相同,不同才複製
   IF g_4rppath_new != l_4rppath THEN
      CALL os.Path.delete(l_4rppath) RETURNING l_delete
      LET l_result = os.Path.copy(g_4rppath_new,l_4rppath)
      IF os.Path.chrwx(l_4rppath,511) THEN END IF  #修改權限
   ELSE
      LET l_result = TRUE
   END IF
   
   IF l_result THEN
      DISPLAY "adzq185_modify_4rp"
      CALL adzq185_modify_4rp(l_4rppath)
   END IF

END FUNCTION

PRIVATE FUNCTION adzq185_modify_4rp(p_4rppath)
   DEFINE p_4rppath    STRING
   DEFINE l_doc        om.DomDocument
   DEFINE l_rootnode   om.DomNode
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_item       STRING
   DEFINE l_j          LIKE type_t.num5
   DEFINE l_session    STRING
   DEFINE l_str        STRING
   DEFINE l_parnode    om.DomNode
   DEFINE l_node_list  om.NodeList  
   DEFINE l_curnode    om.DomNode
   DEFINE l_curname    STRING
   DEFINE l_filename   STRING
   DEFINE l_dst        STRING
   DEFINE l_cmd        STRING
   DEFINE l_flag       LIKE type_t.chr1   #是否有勾選

   LET l_flag = "N" 
   IF NOT os.Path.exists(p_4rppath) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00676'
      LET g_errparam.extend = p_4rppath
      LET g_errparam.popup = TRUE
      CALL cl_err()
      DISPLAY "File not found: ",p_4rppath
      EXIT PROGRAM -2
   END IF
   LET l_doc = om.DomDocument.createFromXmlFile(p_4rppath)
   LET l_rootnode = l_doc.getDocumentElement()
   FOR l_i = 1 TO g_diff.getlength()
      #使用舊值
      IF g_diff[l_i].check = 'Y' THEN
         LET l_flag = "Y"
         IF g_diff[l_i].property = '24' THEN   #增減欄位
            LET l_item = g_diff[l_i].tagname
            IF g_diff[l_i].old_value = 'Y' THEN   #增加欄位
               #取得區段名稱
               LET l_session = ""
               FOR l_j = 1 TO g_sr_field.getlength()
                  IF g_sr_field[l_j].gzgg001 = g_diff[l_i].column_id THEN
                     LET l_session = g_sr_field[l_j].gzgg019
                     EXIT FOR
                  END IF
               END FOR

               IF l_session MATCHES "[12345678]" THEN   #單頭,Label和Value一起
                  #Label
                  LET l_item = l_item.subString(1,l_item.getIndexOf("+",1)-1)
                  LET l_str =  adzq185_get_addnodes(g_4rppath_old,g_diff[l_i].column_id,l_item,l_session)
                  CALL adzq185_insert_node(l_rootnode,g_diff[l_i].column_id,l_session,l_str)
               ELSE
                  #Label
                  LET l_item = l_item.subString(1,l_item.getIndexOf("+",1)-1)
                  LET l_str = adzq185_get_addnodes(g_4rppath_old,g_diff[l_i].column_id||"RH",l_item,l_session)
                  CALL adzq185_insert_node(l_rootnode,g_diff[l_i].column_id,l_session,l_str)
                  LET l_str = adzq185_get_addnodes(g_4rppath_old,g_diff[l_i].column_id||"PH",l_item,l_session)
                  CALL adzq185_insert_node(l_rootnode,g_diff[l_i].column_id,l_session,l_str)
                  
                  #Value
                  LET l_item = l_item.subString(l_item.getIndexOf("+",1)+1,l_item.getLength())                     
                  LET l_str =  adzq185_get_addnodes(g_4rppath_old,g_diff[l_i].column_id,l_item,l_session)
                  CALL adzq185_insert_node(l_rootnode,g_diff[l_i].column_id,l_session,l_str)
                   
                END IF
            ELSE   #減少欄位
               #取得區段名稱
               LET l_session = ""
               FOR l_j = 1 TO g_sr_field.getlength()
                  IF g_sr_field[l_j].gzgg001n = g_diff[l_i].column_id THEN
                     LET l_session = g_sr_field[l_j].gzgg019n
                  END IF
               END FOR

               #Label
               LET l_item = l_item.subString(1,l_item.getIndexOf("+",1)-1)
               LET l_node_list = l_rootnode.selectByTagName(l_item)
               IF l_node_list.getLength() >= 1 THEN
                  FOR l_i=1 TO l_node_list.getLength()
                     LET l_curnode = l_node_list.item(l_i)
                     LET l_curname = l_curnode.getAttribute("name")
                     IF l_curname = g_diff[l_i].column_id THEN
                        LET l_parnode =  l_curnode.getParent()
                        CALL l_parnode.removeChild(l_curnode)
                     END IF
                  END FOR
               END IF   
               
               #Value
               LET l_item = l_item.subString(l_item.getIndexOf("+",1)+1,l_item.getLength())                     
               LET l_node_list = l_rootnode.selectByTagName(l_item)
               IF l_node_list.getLength() >= 1 THEN
                  FOR l_i=1 TO l_node_list.getLength()
                     LET l_curnode = l_node_list.item(l_i)
                     LET l_curname = l_curnode.getAttribute("name")
                     IF l_curname = g_diff[l_i].column_id THEN
                        LET l_parnode =  l_curnode.getParent()
                        CALL l_parnode.removeChild(l_curnode)
                     END IF
                  END FOR
               END IF   
            END IF    
         ELSE
            IF g_diff[l_i].property = '2' OR g_diff[l_i].property = '3' THEN
               #Label
               LET l_item = g_diff[l_i].tagname
               LET l_item = l_item.subString(1,l_item.getIndexOf("+",1)-1)
               CALL adzq185_set_att_4rp(l_rootnode,l_item,g_diff[l_i].column_id,g_diff[l_i].type,g_diff[l_i].property,g_diff[l_i].old_value,g_diff[l_i].new_value)
               #Value
               LET l_item = g_diff[l_i].tagname
               LET l_item = l_item.subString(l_item.getIndexOf("+",1)+1,l_item.getLength())
               CALL adzq185_set_att_4rp(l_rootnode,l_item,g_diff[l_i].column_id,g_diff[l_i].type,g_diff[l_i].property,g_diff[l_i].old_value,g_diff[l_i].new_value)               
            ELSE
               CALL adzq185_set_att_4rp(l_rootnode,g_diff[l_i].tagname,g_diff[l_i].column_id,g_diff[l_i].type,g_diff[l_i].property,g_diff[l_i].old_value,g_diff[l_i].new_value)
            END IF
         END IF
      END IF
   END FOR

   CALL l_rootnode.writeXml(p_4rppath)

   #有異動才下載
   IF l_flag = "Y" THEN
      #下載至client端
      IF NOT os.Path.EXISTS(p_4rppath) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00339'
         LET g_errparam.extend = ''
         LET g_errparam.replace[1] = p_4rppath
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF

      LET l_filename = os.Path.basename(p_4rppath)
      #選擇本地端下載資料夾
      LET l_dst = cl_client_browse_dir()
      IF cl_null(l_dst) THEN
         #取消或離開,沒挑選
      ELSE
         LET l_dst = os.Path.JOIN(l_dst, l_filename)

         #下載檔案至Client端
         IF NOT cl_client_download_file(p_4rppath, l_dst) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00329"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            CALL cl_ask_confirm3("adz-00330", l_filename.trim())
            #下載成功後,從Server端刪除相關檔案
            #刪除4rp檔
            IF os.Path.EXISTS(p_4rppath) THEN
               LET l_cmd = "rm ", p_4rppath
               RUN l_cmd
            END IF
         END IF
      END IF  
   END IF
    
END FUNCTION


PRIVATE FUNCTION adzq185_set_att_4rp(p_node,p_tagname,p_fieldname,p_type,p_property,p_old,p_new)
   DEFINE p_node                om.DomNode
   DEFINE p_tagname             STRING      #物件名稱
   DEFINE p_fieldname           STRING      #欄位名稱
   DEFINE p_type                STRING      #類別(Value/Label)
   DEFINE p_property            STRING      #屬性名稱
   DEFINE p_old                 STRING      #屬性值
   DEFINE p_new                 STRING      #屬性值
   DEFINE l_node_list           om.NodeList
   DEFINE l_curnode             om.DomNode
   DEFINE l_curname             STRING
   DEFINE l_i                   LIKE type_t.num5
   DEFINE l_att                 STRING       #XML中屬性名稱
   DEFINE l_value               STRING       #XML中內容值
   DEFINE l_doc         om.DomDocument

   LET l_att = ""
   LET l_value = ""
   LET l_doc = om.DomDocument.createFromXmlFile(g_4rppath_new)
   
   LET l_node_list = p_node.selectByTagName(p_tagname)
   IF NOT cl_null(p_type) THEN
      LET p_fieldname = p_fieldname,"_",p_type.trim()
   END IF

   LET l_value = p_old
   CASE p_property
      WHEN "2"   #定位點X
         LET l_att = "x"
      WHEN "3"   #定位點Y
         LET l_att = "y"
      WHEN "4"   #欄位寬度(X-Size)
         LET l_att = "width"
      WHEN "7"   #字型名稱
         LET l_att = "fontName"
      WHEN "8"   #字型尺寸
         LET l_att = "fontSize"
      WHEN "9"   #字型粗體
         LET l_att = "fontBold"
      WHEN "10"  #顏色
         LET l_att = "color"
      WHEN "11"  #欄位說明寬度(X-Size)
         LET l_att = "width"
      WHEN "12"  #欄位說明字型名稱
         LET l_att = "fontName"
      WHEN "13"  #欄位說明字型尺寸
         LET l_att = "fontSize"
      WHEN "14"  #欄位說明字型粗體
         LET l_att = "fontBold"
      WHEN "15"  #欄位說明顏色
         LET l_att = "color"
      #WHEN "16"  #折行
      #   LET l_att = ""
#      WHEN "17"  #隱藏
#         LET l_att = "rtl:condition"
#      WHEN "18"  #欄位說明隱藏
#         LET l_att = "rtl:condition"
      WHEN "19"  #欄位說明
         LET l_att = "text"
      WHEN "20"  #文字對齊
         LET l_att = "textAlignment"
         CASE p_old
            WHEN "L"
               LET l_value = "left"       #靠左
            WHEN "R"
               LET l_value = "right"      #靠右
            WHEN "C"
               LET l_value = "center"     #置中
            WHEN "J"
               LET l_value = "justified"  #左右對齊
         END CASE            
      WHEN "21"  #欄位說明文字對齊
         LET l_att = "textAlignment"
         CASE p_old
            WHEN "L"
               LET l_value = "left"       #靠左
            WHEN "R"
               LET l_value = "right"      #靠右
            WHEN "C"
               LET l_value = "center"     #置中
            WHEN "J"
               LET l_value = "justified"  #左右對齊
         END CASE            
      WHEN "22"  #能見度條件公式
         LET l_att = "rtl:condition"
      WHEN "23"  #欄位說明能見度條件公式
         LET l_att = "rtl:condition"
   END CASE

   IF NOT cl_null(l_att) THEN
      FOR l_i=1 TO l_node_list.getLength()
         LET l_curnode = l_node_list.item(l_i)
         LET l_curname = l_curnode.getAttribute("name")
         IF l_curname = p_fieldname THEN
            IF p_property = '5' OR p_property = '6' THEN   #行序攔序
               CALL adzq185_moveline(l_doc,l_curnode,p_fieldname,p_property,p_old,p_new)
               CALL adzq185_movelinecol(l_doc,l_curnode,p_fieldname,p_property,p_old,p_new)
            ELSE
               IF p_property <> '24' THEN
                  CALL l_curnode.removeAttribute(l_att)
                  IF NOT cl_null(l_value) THEN
                     CALL l_curnode.setAttribute(l_att,l_value)
                  END IF
               END IF
            END IF  
         END IF
      END FOR
   END IF

END FUNCTION

#單頭變更行序
PRIVATE FUNCTION adzq185_moveline(p_doc,p_node,p_field,p_property,p_dst_lineno,p_src_lineno)
   DEFINE p_doc          om.DomDocument
   DEFINE p_node         om.DomNode
   DEFINE p_field        STRING
   DEFINE p_property     STRING
   DEFINE p_dst_lineno   STRING
   DEFINE p_src_lineno   STRING
   DEFINE l_gzgg019      LIKE gzgg_t.gzgg019   #區塊類型
   DEFINE l_tagname      STRING 
   DEFINE l_lbltagname   STRING 
   
   DEFINE l_src_lineno   LIKE type_t.num5           #舊4rp的行數
   DEFINE l_src_colno    LIKE type_t.num5           #舊4rp的欄位順序
   DEFINE l_dst_line     om.DomNode                    #新行節點
   DEFINE l_src_line     om.DomNode                    #原行節點
   DEFINE l_level        LIKE type_t.num5           #欄位與單頭區段的層數
   DEFINE l_i,l_j        LIKE type_t.num5
   DEFINE l_cur_node     om.DomNode                    #欄位所在的容器節點
   DEFINE l_str          STRING

   IF cl_null(p_dst_lineno) THEN LET p_dst_lineno = 0 END IF
   IF cl_null(p_src_lineno) THEN LET p_src_lineno = 0 END IF
   
   FOR l_i = 1 TO g_sr_field.getLength()
      IF g_sr_field[l_i].gzgg001n = p_field THEN
         LET l_tagname = g_sr_field[l_i].draw
         LET l_lbltagname = g_sr_field[l_i].lbldraw
         #新值沒資料,用舊值
         IF cl_null(g_sr_field[l_i].gzgg019n) THEN
            LET l_gzgg019 = g_sr_field[l_i].gzgg019
         ELSE
            LET l_gzgg019 = g_sr_field[l_i].gzgg019n
         END IF
         EXIT FOR
      END IF
   END FOR

   IF l_gzgg019 MATCHES "[123456789]" THEN
      #單頭行數需要修改
      IF p_src_lineno != p_dst_lineno AND p_src_lineno > 0 AND p_dst_lineno > 0 THEN
         LET l_dst_line = sadzq185_01_get_dstnode(p_node,p_dst_lineno)
         LET l_src_line = sadzq185_01_get_dstnode(p_node,p_src_lineno)
         LET l_level = sadzq185_01_getlevel(p_node) #取得欄位層數
         
         IF l_dst_line IS NOT NULL AND l_src_line IS NOT NULL THEN
            IF l_level = 2 THEN #兩層
               #搬移節點
               CALL sadzq185_movenodes(p_doc,p_node,l_dst_line,l_src_line,NULL)
            ELSE #三層以上
               IF l_level >= 3 THEN
                  FOR l_i = 1 TO l_src_line.getChildCount()
                     LET l_cur_node = l_src_line.getChildByIndex(l_i)
                     IF l_cur_node.getTagName() = "LAYOUTNODE" THEN
                        IF sadzq185_01_findchild(l_cur_node,p_node) THEN
                           #搬移節點
                           CALL sadzq185_movenodes(p_doc,p_node,l_dst_line,l_src_line,NULL)
                           EXIT FOR
                        END IF
                     END IF
                  END FOR
               END IF
            END IF
         END IF #搬移節點
      END IF
   END IF
END FUNCTION

#單身變更行序及欄位順序
PRIVATE FUNCTION adzq185_movelinecol(p_doc,p_node,p_field,p_property,p_dst_lineno,p_src_lineno)
   DEFINE p_doc          om.DomDocument
   DEFINE p_node         om.DomNode
   DEFINE p_field        STRING
   DEFINE p_property     STRING
   DEFINE p_dst_lineno   STRING
   DEFINE p_src_lineno   STRING
   DEFINE l_dst_line     om.DomNode                    #新行節點
   DEFINE l_src_line     om.DomNode                    #原行節點
   DEFINE l_dst_col      om.DomNode                    #新欄位順序節點
   DEFINE l_src_colno    LIKE type_t.num5
   DEFINE l_dst_colno    LIKE type_t.num5   
   DEFINE l_i            LIKE type_t.num5   
   DEFINE l_gzgg019      LIKE gzgg_t.gzgg019   #區塊類型
   
   FOR l_i = 1 TO g_sr_field.getLength()
      IF g_sr_field[l_i].gzgg001n = p_field THEN
         #新值沒資料,用舊值
         IF cl_null(g_sr_field[l_i].gzgg019n) THEN
            LET l_gzgg019 = g_sr_field[l_i].gzgg019
         ELSE
            LET l_gzgg019 = g_sr_field[l_i].gzgg019n
         END IF  
         LET l_dst_colno = g_sr_field[l_i].gzgg004n
         LET l_src_colno = g_sr_field[l_i].gzgg004
         EXIT FOR
      END IF
   END FOR
   
   IF l_gzgg019 = "9" THEN   
      #取得舊4rp單身欄位的行序及欄位順序
#      CALL sadzq185_01_getlinecol(p_node)
#         RETURNING l_src_lineno, l_src_colno

      #單身行序及欄位順序需要修改
      IF (p_src_lineno != p_dst_lineno OR l_src_colno != l_dst_colno) 
         AND p_src_lineno > 0 AND p_dst_lineno > 0
         AND l_src_colno > 0 AND l_dst_colno > 0
      THEN
         LET l_dst_line = sadzq185_01_get_dstnode(p_node,p_dst_lineno)
         LET l_src_line = sadzq185_01_get_dstnode(p_node,p_src_lineno)

         IF l_dst_line IS NOT NULL AND l_src_line IS NOT NULL THEN
            #找出要變更的目標節點
            LET l_dst_col = sadzq185_01_get_seqnode(l_dst_line,l_dst_colno)

            IF l_dst_col IS NOT NULL THEN
               #搬移節點
               CALL sadzq185_movenodes(p_doc,p_node,l_dst_line,l_src_line,l_dst_col)
            ELSE
               IF l_dst_colno > 0 THEN
                  CALL sadzq185_movenodes(p_doc,p_node,l_dst_line,l_src_line,l_dst_col)
               END IF
            END IF
         END IF
      END IF
   END IF
END FUNCTION

#搬移節點
PRIVATE FUNCTION sadzq185_movenodes(p_doc,p_node,p_dst_line,p_src_line,p_dst_col)
   DEFINE p_doc         om.DomDocument
   DEFINE p_node        om.DomNode
   DEFINE p_dst_line    om.DomNode
   DEFINE p_src_line    om.DomNode
   DEFINE p_dst_col     om.DomNode
   DEFINE l_vars        DYNAMIC ARRAY OF om.DomNode   #變數節點陣列
   DEFINE l_tnode       om.DomNode                    #暫存節點
   DEFINE l_vtnode      om.DomNode                    #暫存變數節點
   DEFINE l_i           LIKE type_t.num5

   IF p_doc IS NOT NULL AND p_node IS NOT NULL AND p_dst_line IS NOT NULL 
      AND p_src_line IS NOT NULL
   THEN
      #取得需搬移的變數節點
      LET l_vars = sadzq185_01_get_varnodes(p_node)
      #搬移
      LET l_tnode = p_doc.copy(p_node,TRUE)

      CALL p_doc.removeElement(p_node)
      
      IF p_dst_col IS NOT NULL THEN
         CALL p_dst_line.insertBefore(l_tnode,p_dst_col)
      ELSE 
         CALL p_dst_line.appendChild(l_tnode)
      END IF
      FOR l_i = 1 TO l_vars.getLength()
         LET l_vtnode = p_doc.copy(l_vars[l_i],TRUE)
         
         CALL p_doc.removeElement(l_vars[l_i])
         
         CALL p_dst_line.insertBefore(l_vtnode,l_tnode)
      END FOR
   END IF
END FUNCTION

#增加欄位,取得舊檔值
FUNCTION adzq185_get_addnodes(p_path,p_fieldname,p_tagname,p_session)
   DEFINE p_path        STRING
   DEFINE p_fieldname   STRING
   DEFINE p_tagname     STRING
   DEFINE p_session     STRING
   DEFINE l_rootnode    om.DomNode
   DEFINE l_doc         om.DomDocument
   DEFINE l_node_list   om.NodeList
   DEFINE l_curnode     om.DomNode
   DEFINE r_str         STRING  
   DEFINE l_tmpnode     om.DomNode
   DEFINE i             LIKE type_t.num5
   DEFINE l_j           LIKE type_t.num5
   DEFINE l_curname     STRING
   DEFINE l_prenode     om.DomNode   #前一個節點
   DEFINE l_parnode     om.DomNode
   DEFINE l_chinode     om.DomNode
   DEFINE l_chitag      STRING
   DEFINE l_pretag      STRING
   DEFINE l_chiname     STRING
   DEFINE l_tagname     STRING
   DEFINE l_chi_cnt     LIKE type_t.num5
   DEFINE l_con_flag    LIKE type_t.chr1   #容器中是否包含同名稱Label/Value
   DEFINE l_str         STRING

   LET r_str = ""
   LET l_doc = om.DomDocument.createFromXmlFile(p_path)
   IF l_doc IS NOT NULL THEN
      LET l_rootnode = l_doc.getDocumentElement()
      LET l_node_list = l_rootnode.selectByTagName(p_tagname)
      IF l_node_list.getLength() >= 1 THEN
         FOR i=1 TO l_node_list.getLength()
            LET l_curnode = l_node_list.item(i)
            LET l_curname = l_curnode.getAttribute("name")
            IF l_curname = p_fieldname||"_Label" OR l_curname = p_fieldname||"_Value" THEN
               LET r_str = l_curnode.toString()
               LET r_str = adzq185_get_rtl(l_rootnode,l_curnode,r_str)

               LET l_parnode = l_curnode.getParent()
               LET l_chi_cnt = l_parnode.getChildCount()

               #檢查上層容器是否包含其他物件
               LET l_con_flag = "N"
               FOR l_j = 1 TO l_chi_cnt
                  LET l_chinode = l_parnode.getChildByIndex(l_j)
                  LET l_chiname = l_chinode.getAttribute("name")
                  LET l_chitag = l_chinode.getTagName()
                  IF l_chitag = "WORDBOX" OR l_chitag = "WORDWRAPBOX" OR l_chitag = "DECIMALFORMATBOX" 
                     OR l_chitag = "PAGENOBOX" OR l_chitag = "IMAGEBOX" THEN
                     LET l_str = cl_str_replace(p_fieldname,"_Label", "")
                     LET l_str = cl_str_replace(p_fieldname,"_Value", "")
                     IF l_chiname.getIndexOf(l_str,1) = 0 THEN
                        LET l_con_flag = "Y"   #包含其他物件
                     END IF
                  END IF
               END FOR
               IF l_con_flag = "N" THEN
                  LET r_str = l_parnode.toString()
                  LET r_str = adzq185_get_rtl(l_rootnode,l_parnode,r_str)
               END IF
               EXIT FOR
            END IF
         END FOR
      END IF
   END IF  

   RETURN r_str
END FUNCTION

#插入欄位
FUNCTION adzq185_insert_node(p_node,p_fieldname,p_session,p_str)
   DEFINE p_node        om.DomNode
   DEFINE p_fieldname   STRING
   DEFINE p_session     LIKE type_t.chr1
   DEFINE p_str         STRING
   DEFINE l_node_list   om.NodeList
   DEFINE l_curnode     om.DomNode
   DEFINE l_chinode     om.DomNode
   DEFINE l_tmpnode     om.DomNode
   DEFINE l_curname     STRING
   DEFINE l_tagname     STRING
   DEFINE l_con_name    STRING
   DEFINE l_i           LIKE type_t.num5

   CASE p_session
      WHEN "1"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "ReportHeader"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "2"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "RHMasters"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "3"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "RHMasterAs"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "4"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "RHMasterCs"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "5"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "PageHeader"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "6"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "PHMasters"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "7"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "PHMasterAs"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "8"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "PHMasterCs"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "9"
         LET l_tagname = "MINIPAGE"
         LET l_con_name = "Details"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "10"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "RHDetailHeaders"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "11"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "RHDetailHeaders"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "12"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "PageFooters"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "13"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "ReportFooters"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
      WHEN "14"
         LET l_tagname = "LAYOUTNODE"
         LET l_con_name = "GroupFooters"
         CALL adzq185_append_node(p_node,l_tagname,l_con_name,p_str)
   END CASE

END FUNCTION

FUNCTION adzq185_get_rtl(p_node,p_chinode,p_str)
   DEFINE p_node        om.DomNode
   DEFINE p_chinode     om.DomNode
   DEFINE p_str         STRING
   DEFINE l_prenode     om.DomNode   #前一個節點
   DEFINE l_pretag      STRING
   DEFINE l_tmpnode     om.DomNode

   LET l_tmpnode = p_chinode
   WHILE TRUE
      LET l_prenode =  l_tmpnode.getPrevious()
      LET l_pretag = l_prenode.getTagName()
      IF l_pretag = "rtl:input-variable" THEN #補上變數值
         LET p_str = l_prenode.toString(),p_str
      ELSE
         EXIT WHILE
      END IF
      LET l_tmpnode = l_prenode   #繼續查看前一個節點
   END WHILE

   RETURN p_str
END FUNCTION


FUNCTION adzq185_append_node(p_node,p_tagname,p_con_name,p_str)
   DEFINE p_node        om.DomNode
   DEFINE p_tagname     STRING
   DEFINE p_con_name    STRING
   DEFINE p_str         STRING
   DEFINE l_node_list   om.NodeList
   DEFINE l_curnode     om.DomNode
   DEFINE l_chinode     om.DomNode
   DEFINE l_tmpnode     om.DomNode
   DEFINE l_curname     STRING
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_tmpname     STRING
   DEFINE l_chiname     STRING

        LET l_node_list = p_node.selectByTagName(p_tagname)

         IF l_node_list.getLength() >= 1 THEN
            FOR l_i=1 TO l_node_list.getLength()
               LET l_curnode = l_node_list.item(l_i)
               LET l_curname = l_curnode.getAttribute("name")
               IF l_curname = p_con_name THEN
                  LET l_tmpname = l_curname.subString(1,l_curname.getLength()-1)  #去掉s
                     LET l_chinode = l_curnode.getLastChild()
                     WHILE TRUE                     
                        LET l_chiname = l_chinode.getAttribute("name")
                        IF l_chiname.getIndexOf(l_tmpname,1) > 0 THEN
                           EXIT WHILE
                        ELSE
                           LET l_tmpnode = l_chinode
                           LET l_chinode = l_tmpnode.getPrevious()
                        END IF
                     END WHILE  
                  LET l_tmpnode = l_chinode.parse(p_str)
               END IF
            END FOR
         END IF 
END FUNCTION
#161130-00066#1 add(e)

