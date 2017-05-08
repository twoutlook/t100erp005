#+ Version..: T6-ERP-1.00.00 Build-000000
#+ 
#+ Filename...: azzi000
#+ Buildtype..: 應用 n00 樣板自動產生
#+ Memo.......: 
#+ 以上段落由子樣板a00產生
 
 
#add-point:FreeStyle

#+ Version..: T6-ERP-1.00.00 Build-000156
#+
#+ Filename...: azzi000
#+ Buildtype..: 沒有樣版 手動產生
#+ Memo.......: 12/03/01 by Saki
# 裡面需要含哪些功能，必須再討論; 關係到系統整體功能的也未定案, Ex. 帳密, SSO, Logistics...
# 函式都要提供close功能

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

GLOBALS
DEFINE   g_tryerr            LIKE type_t.num5
DEFINE   g_validate_err      STRING
END GLOBALS

DEFINE   gwin_curr           ui.Window
DEFINE   gfrm_curr           ui.Form
DEFINE   g_sql               STRING
DEFINE   g_cnt               LIKE type_t.num5
DEFINE   g_adjust            LIKE type_t.chr1
DEFINE   g_cmdtype           STRING
DEFINE   g_search            STRING
DEFINE   g_toolbar_idx       SMALLINT

MAIN
   OPTIONS
      ON CLOSE APPLICATION STOP,
      INPUT NO WRAP
   DEFER INTERRUPT

   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")

#  CALL FGL_SETENV("MDI",1)

   CALL azzi000()

END MAIN


############################################################################
# Descriptions...: 首頁主畫面
############################################################################
FUNCTION azzi000()
   DEFINE   l_windowid    STRING
   DEFINE   l_wcpath      STRING   # WebComponent路徑
   DEFINE   ld_start      DATETIME SECOND TO FRACTION(5)
   DEFINE   ld_end        DATETIME SECOND TO FRACTION(5)

   IF FGL_GETENV("MDI") THEN
      CALL ui.Interface.setText("首頁")
      CALL ui.Interface.setType("container")
      CALL ui.Interface.setName("azzi000")
      CALL ui.Interface.loadStyles(FGL_GETENV("ERP")||os.Path.separator()||"cfg"||os.Path.separator()||"4st"||os.Path.separator()||"mdi.4st")
   END IF

   # webComponent需在開啟視窗前設定路徑
   LET l_wcpath = FGL_GETENV("FGLASIP"),"/components"
   CALL ui.interface.frontCall("standard", "setwebcomponentpath",[l_wcpath],[])

   # 放入ap_init的架構中
   LET g_adjust = "N"

   #畫面額外初始化設定 ( 首頁特殊處理 )
   CALL azzi000_init()

   CALL azzi000_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_azzi000

END FUNCTION

FUNCTION azzi000_init()
   DEFINE   ls_tmp        STRING
   DEFINE   l_wcpath      STRING   # WebComponent路徑

   OPEN WINDOW w_azzi000 WITH FORM cl_ap_formpath("azz",g_prog)
   CALL cl_ui_init()
   # 首頁的style setting
   CALL ui.Interface.loadStyles(FGL_GETENV("ERP")||os.Path.separator()||"cfg"||os.Path.separator()||"4st"||os.Path.separator()||"homepage.4st")
   CALL cl_ui_wintitle(1)

   # 設定哪些搜尋或執行元件可以放入command line使用, 先寫死啦...都沒有資料結構可用
   # 可以用gcn_file來延伸
   CALL cl_set_combo_items("formonly.cmd_type","1,2,3,4,5","執行程式,單據搜尋,客戶搜尋,料號搜尋,廠商搜尋")
   LET g_cmdtype = "1"

   # 2012/05/24 應用決定增加User UI Setting畫面, 將佈景主題選擇移進去

   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   # 資料準備
   CALL azzi000_start_menu()                 # 整體目錄
   CALL azzi000_show()

END FUNCTION
############################################################################


############################################################################
# Descriptions...: 用StartMenu產生目錄
############################################################################
FUNCTION azzi000_start_menu()
   DEFINE   ls_smpath    STRING
   DEFINE   lnode_root   om.DomNode
   DEFINE   lnode_sm     om.DomNode
   DEFINE   lnode_smg    om.DomNode
   DEFINE   lnode_child  om.DomNode
   DEFINE   lr_gzzo      DYNAMIC ARRAY OF RECORD
               gzzo001   LIKE gzzo_t.gzzo001,
               gzzol003  LIKE gzzol_t.gzzol003
                         END RECORD
   DEFINE   li_cnt       LIKE type_t.num5


#  LET ls_smpath = FGL_GETENV("ERP"), os.Path.separator(), "cfg", os.Path.separator(), "4sm", os.Path.separator(), "t6.4sm"
#  CALL ui.Interface.loadStartMenu(ls_smpath)

   LET lnode_root = ui.Interface.getRootNode()
   LET lnode_sm = lnode_root.createChild("StartMenu")

   LET g_sql = "SELECT DISTINCT gzza003, gzzol003 FROM gzza_t ",
               "LEFT JOIN gzzol_t ON gzza003 = gzzol001 AND gzzol002 = '",g_lang,"'",
               " WHERE gzza003 IS NOT NULL",
               " ORDER BY gzza003"
   PREPARE module_pre FROM g_sql
   DECLARE module_curs CURSOR FOR module_pre
   LET li_cnt = 1
   FOREACH module_curs INTO lr_gzzo[li_cnt].*
      LET lr_gzzo[li_cnt].gzzol003 = lr_gzzo[li_cnt].gzzol003,"(", lr_gzzo[li_cnt].gzzo001,")"
      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL lr_gzzo.deleteElement(li_cnt)

   FOR li_cnt = 1 TO lr_gzzo.getLength()
       LET lnode_smg = lnode_sm.createChild("StartMenuGroup")
       CALL lnode_smg.setAttribute("text", lr_gzzo[li_cnt].gzzol003)
       CALL lnode_smg.setAttribute("image", "16/module.png")
       CALL azzi000_create_start_menu_child(lnode_smg, lr_gzzo[li_cnt].gzzo001)
   END FOR

END FUNCTION

FUNCTION azzi000_create_start_menu_child(pnode_item, pc_gzzo001)
   DEFINE   pnode_item   om.DomNode
   DEFINE   pc_gzzo001   LIKE gzzo_t.gzzo001
   DEFINE   lc_gzza001   LIKE gzza_t.gzza001
   DEFINE   lc_gzza002   LIKE gzza_t.gzza002
   DEFINE   lc_gzzal003  LIKE gzzal_t.gzzal003
   DEFINE   lnode_smc    om.DomNode
   DEFINE   lnode_child  om.DomNode
   DEFINE   lc_text      STRING


   LET g_sql = "SELECT gzza001, gzza002, gzzal003 FROM gzza_t",
               "  LEFT JOIN gzzal_t ON gzza001 = gzzal001 AND gzzal002 = '",g_lang,"'",
               " WHERE gzza003 = '", pc_gzzo001, "' AND gzzal003 IS NOT NULL",
               " ORDER BY gzza001"
   PREPARE program_pre FROM g_sql
   DECLARE program_curs CURSOR FOR program_pre
   FOREACH program_curs INTO lc_gzza001, lc_gzza002, lc_gzzal003
      LET lnode_smc = pnode_item.createChild("StartMenuCommand")
      LET lc_text = "(",lc_gzza001 CLIPPED,") ",lc_gzzal003 CLIPPED
      CALL lnode_smc.setAttribute("text", lc_text)
      CALL lnode_smc.setAttribute("exec", "$FGLRUN $AZZ/42r/azzp000.42r "||lc_gzza001 CLIPPED)
      CASE lc_gzza002
         WHEN "I" CALL lnode_smc.setAttribute("image", "16/prog_i.png")
         WHEN "T" CALL lnode_smc.setAttribute("image", "16/prog_t.png")
         WHEN "S" CALL lnode_smc.setAttribute("image", "16/prog_s.png")
         WHEN "R" CALL lnode_smc.setAttribute("image", "16/prog_r.png")
         WHEN "Q" CALL lnode_smc.setAttribute("image", "16/prog_q.png")
         WHEN "P" CALL lnode_smc.setAttribute("image", "16/prog_p.png")
      END CASE
   END FOREACH

END FUNCTION
############################################################################


############################################################################
# Descriptions...: 主畫面DIALOG - 需包入首頁所有操作指令
############################################################################
FUNCTION azzi000_ui_dialog()
   DEFINE   g_plant_t         LIKE type_t.chr20
   DEFINE   li_result         LIKE type_t.num5
   DEFINE   li_tree_idx       LIKE type_t.num5
   DEFINE   li_open           LIKE type_t.num5
   DEFINE   li_function       LIKE type_t.num5
   DEFINE   li_cnt            LIKE type_t.num5
   # 搜尋用
   DEFINE   lc_gzza001           LIKE gzza_t.gzza001
   # 行事曆月曆模式
   DEFINE   ls_sel_date       STRING
   DEFINE   ls_year           STRING
   DEFINE   ls_month          STRING
   # 跑馬燈
   DEFINE   ls_marquee_wc     STRING
   # 程式集
   DEFINE   ls_apps_wc        STRING

   DIALOG ATTRIBUTES(UNBUFFERED)
      # 首頁上整體欄位
      INPUT g_search, g_plant, g_cmdtype
       FROM formonly.searchstr, formonly.logistics, formonly.cmd_type
         ATTRIBUTES(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL azzi000_marquee()

         ON CHANGE logistics
            CALL azzi000_dbchange(g_plant)
      END INPUT

      # 系統跑馬燈
      INPUT ls_marquee_wc FROM marquee_wc
      END INPUT

      # 功能集 - 程式集
      INPUT ls_apps_wc FROM cprogs_wc
         ON ACTION prog_remove
            CALL azzi000_custom_program_remove(ls_apps_wc)
            CALL azzi000_custom_program_list()
      END INPUT

      ON ACTION userprofile  # 使用者設定

      ON ACTION execute   # 任何一處的執行程式
         CASE DIALOG.getCurrentItem()
            WHEN "formonly.searchstr"
               CASE g_cmdtype
                  WHEN "1"    # 程式執行
                     CALL cl_cmdrun(g_search)
               END CASE
         END CASE

      ON ACTION exit
         IF ui.Interface.getChildCount() > 0 THEN
         ELSE
            EXIT DIALOG
         END IF
      ON ACTION close
         IF ui.Interface.getChildCount() > 0 THEN
         ELSE
            EXIT DIALOG
         END IF
   END DIALOG

END FUNCTION
############################################################################


############################################################################
# Descriptions...: 顯示udm_tree上的 TopBar & SystemBar 基本資訊, SystemBar之後會取代為跑馬燈
############################################################################
FUNCTION azzi000_show()

   # TopBar 公司logo圖
   DISPLAY "logo/TS.gif" TO formonly.company_logo

END FUNCTION
#############################################################################


############################################################################
# Descriptions...: 跑馬燈, 重整時機在操作點, 不在ON IDLE
############################################################################
FUNCTION azzi000_marquee()
   DEFINE   ls_value   STRING

   # 組出訊息列表
   # 到底要去哪裡撈資料呢?
   LET ls_value = "現在時間是", TODAY, " ", TIME,",",
                  "暫時版首頁"

   CALL cl_marquee("marquee_wc",ls_value,"700","16","left","20","#A4BFF5","color: #325685; font-size: 10pt; font-weight: bold; margin-top: 2px;")

END FUNCTION
#############################################################################


############################################################################
# Descriptions...: 首頁主畫面 - 切換DB
############################################################################
# 2012/05/09 這裡還不確定User的資料庫要如何預設與改變 (切片方式)
FUNCTION azzi000_dbchange(pc_plant)
   DEFINE  pc_plant   LIKE ooaa_t.ooaa001

END FUNCTION

# 書豪建議DB轉換後, 要有明顯的切換顯示
FUNCTION azzi000_dbchange_topBar()
   DEFINE lnode_root om.DomNode
   DEFINE lnode_tb om.DomNode
   DEFINE lnode_tblist om.NodeList
   DEFINE lnode_item om.DomNode
   DEFINE lnode_itemlist om.NodeList
   DEFINE li_i SMALLINT

   CASE g_toolbar_idx
      WHEN 0 LET g_toolbar_idx = 1
      WHEN 1 LET g_toolbar_idx = 0
   END CASE

   LET lnode_item = gfrm_curr.findNode("HBox","topbar")
   IF lnode_item IS NOT NULL THEN
      CASE g_toolbar_idx
         WHEN 0 CALL lnode_item.setAttribute("style","topBar")
         WHEN 1 CALL lnode_item.setAttribute("style","topBar1")
      END CASE
   END IF
END FUNCTION
############################################################################


############################################################################
# Descriptions...: 程式集
############################################################################
# 使用者的預設程式集
FUNCTION azzi000_custom_program_list()
   DEFINE   ls_progdesc   STRING
   DEFINE   ls_progimage  STRING
   DEFINE   ls_data       STRING
   DEFINE   ls_value      STRING


   LET ls_value = "{'prog_id':'adzi140','prog_name':'表格設計器','prog_image':''},",
                  "{'prog_id':'adzp168','prog_name':'畫面設計器','prog_image':''}"

   IF cl_null(ls_value) THEN
      # 目的是為了要清空畫面, 不然會殘留已經刪除的program
      LET ls_value = "{'prog_id':'','prog_name':'','prog_image':''},"
   END IF
   LET ls_value = ls_value.subString(1, ls_value.getLength()-1)
   LET ls_value = "[", ls_value, "]"
   CALL cl_set_property_comp("cprogs_wc", "values", ls_value)

END FUNCTION

# 增加程式到程式集中
FUNCTION azzi000_custom_program_add(pc_progid)
   DEFINE   pc_progid   LIKE gzza_t.gzza001
   DEFINE   li_cnt      LIKE type_t.num5


   ERROR "尚未產生規格"

END FUNCTION

# 從程式集中刪除
FUNCTION azzi000_custom_program_remove(pc_progid)
   DEFINE   pc_progid   LIKE gzza_t.gzza001

   ERROR "尚未產生規格"

END FUNCTION
############################################################################


############################################################################
# Descriptions...: webComponents用函式(日後需搬到lib元件中)
############################################################################
# Descriptions...: 跑馬燈顯示
# Input Parameter: ps_wc         STRING   webComponent ID
#                  ps_values     STRING   值組合 (Null則退出)
#                  ps_width      STRING   跑馬燈寬度, default=600
#                  ps_height     STRING   跑馬燈長度, default=32
#                  ps_direction  STRING   往哪個方向捲動, default=up
#                  ps_speed      STRING   速度 (值越大越慢), default=150
#                  ps_bgcolor    STRING   webComponent背景顏色, default=#000000
#                  ps_style      STRING   跑馬燈style設定 (html標準), default=color: #FFFFFF; font-size: 10pt; font-weight: bold;
# Return Code....: void
# Usage..........: CALL cl_marquee("wc", "12點關機,12號放假", "500", "32", "left", "100", "color: #FFFFFF;")
FUNCTION cl_marquee(ps_wc, ps_values, ps_width, ps_height, ps_direction, ps_speed, ps_bgcolor, ps_style)
   DEFINE   ps_wc          STRING
   DEFINE   ps_values      STRING
   DEFINE   ps_width       STRING
   DEFINE   ps_height      STRING
   DEFINE   ps_direction   STRING
   DEFINE   ps_speed       STRING
   DEFINE   ps_bgcolor     STRING
   DEFINE   ps_style       STRING
   DEFINE   lst_values     base.StringTokenizer
   DEFINE   ls_str         STRING
   DEFINE   ls_property    STRING
   DEFINE   ls_value       STRING

   # 解析值, 組出Components需要的格式
   LET ls_value = ""
   LET lst_values = base.StringTokenizer.create(ps_values,",")
   WHILE lst_values.hasMoreTokens()
      LET ls_str = lst_values.nextToken()
      LET ls_str = ls_str.trim()
      LET ls_str = "{\"value\":'● ", ls_str, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'}"
      LET ls_value = ls_value, ls_str, ","
   END WHILE

   # 沒值就不跑 marquee 了
   IF cl_null(ls_value) THEN
      RETURN
   END IF
   LET ls_value = ls_value.subString(1, ls_value.getLength()-1)
   LET ls_value = "[", ls_value, "]"
   CALL cl_set_property_comp(ps_wc, "values", ls_value)

   # 設定跑馬燈其他屬性
   IF cl_null(ps_width) THEN
      LET ps_width = "600"
   END IF
   CALL cl_set_property_comp(ps_wc, "width", ps_width)

   IF cl_null(ps_height) THEN
      LET ps_height = "32"
   END IF
   CALL cl_set_property_comp(ps_wc, "height", ps_height)

   IF cl_null(ps_direction) THEN
      LET ps_direction = "up"
   END IF
   CALL cl_set_property_comp(ps_wc, "direction", ps_direction)

   IF cl_null(ps_speed) THEN
      LET ps_speed = "150"
   END IF
   CALL cl_set_property_comp(ps_wc, "speed", ps_speed)

   IF cl_null(ps_bgcolor) THEN
      LET ps_bgcolor = "#000000"
   END IF
   CALL cl_set_property_comp(ps_wc, "bgcolor", ps_bgcolor)

   IF cl_null(ps_style) THEN
      LET ps_style = "color: #FFFFFF; font-size: 10pt; font-weight: bold;"
   END IF
   CALL cl_set_property_comp(ps_wc, "style", ps_style)

END FUNCTION

FUNCTION cl_set_property_comp(ps_comp, prop_name, prop_value)
   DEFINE ps_comp STRING
   DEFINE prop_name STRING
   DEFINE prop_value STRING
   DEFINE win ui.Window
   DEFINE l_ff    om.DomNode
   DEFINE win_node      om.DomNode
   DEFINE l_nl   om.NodeList
   DEFINE l_wc  om.DomNode
   DEFINE l_dict    om.DomNode
   DEFINE l_prop    om.DomNode

   LET win = ui.Window.getCurrent()
   LET win_node = win.getNode()

   LET l_nl = win_node.selectByPath("//FormField[@name=\"formonly."|| ps_comp ||"\"]")

   IF l_nl.getLength() > 0 THEN
      LET l_ff = l_nl.item(1)
      LET l_wc = l_ff.getFirstChild()
      LET l_dict = l_wc.getFirstChild()
      IF l_dict IS NULL THEN
        LET l_dict = l_wc.createChild("PropertyDict")
        CALL l_dict.setAttribute("name", "properties")
      END IF
      LET l_nl = l_dict.selectByPath("//Property[@name=\"" || prop_name || "\"]")
      LET l_prop = l_nl.item(1)
      IF l_prop IS NULL THEN
         LET l_prop = l_dict.createChild("Property")
         CALL l_prop.setAttribute("name", prop_name)
      END IF
      CALL l_prop.setAttribute("value", prop_value)
   END IF
END FUNCTION
#end add-point
 




