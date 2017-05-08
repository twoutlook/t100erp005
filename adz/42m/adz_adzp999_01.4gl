#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: adzp999_01
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp999_01.4gl 
# Description    : patch包匯入
# Memo           : 
#                  2016/02/22 by ka0132 排除adzp888相關動作
#                  20160223 160223-00028 by madey :patch優化專案
#                  2016/03/07 by ka0132 行業別主機patch後行為增加
#                  2016/06/28 by ka0132 例行性patch包連續檢查
#                  2016/08/16 by ka0132 快速更新調整
#                  2016/08/31 by ka0132 Patch完成時間顯示
#                  2016/09/22 by ka0132 adzp888進行bar顯示, 
#                                       調整diff呼叫規則 , 
#                                       merge預設為N 
#                  2016/10/21 by ka0132 調整Patch完成時間顯示
#                  2016/10/31 by ka0132 merge預設為Y 
#                  2016/11/30 by ka0132 已簽出/客製/且非元件的項目不允許merge
#                  2016/12/02 by ka0132 增加T100PATCH環境變數
#                  2016/12/13 by ka0132 增加-v功能
#                  2016/12/14 by ka0132 調整G,X類不進行merge
#                  2016/12/29 by ka0132 增加參數決定是否merge
#                  2016/12/30 by ka0132 多語言打包機制調整
#                  2017/02/13 by ka0132 引導式Patch串接

#版本資訊需連同修改

IMPORT os
IMPORT security
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzi888_global.inc"
&include "../4gl/sadzp200_type.inc" 
&include "../4gl/sadzp000_type.inc"
#&include "adzi888_global.inc"
#&include "top_global.inc"
#16/07/18
&include "../4gl/adzq991_module.inc" 
#16/07/18
#設計資料執行結果記錄表
TYPE type_g_detail4_d        RECORD
       dzye001          LIKE dzye_t.dzye001,          #匯入包編號
       dzye015          LIKE dzye_t.dzye015,          #執行merge否
       dzye002          LIKE dzye_t.dzye002,          #程式代碼
       dzye003          LIKE dzye_t.dzye003,          #建構類型
       dzye005          LIKE dzye_t.dzye005,          #模組
       dzye012          LIKE dzye_t.dzye012,          #目的程式客製否
       dzye022          LIKE dzye_t.dzye022,          #目的程式簽出否
       
       dzye006          LIKE dzye_t.dzye006,          #no use
       dzye023          LIKE dzye_t.dzye023,          #patch狀態
       dzye004          LIKE dzye_t.dzye004,          #已執行項目
       dzye007          LIKE dzye_t.dzye007,          #錯誤訊息(簡單)
       dzye018          LIKE dzye_t.dzye018,          #錯誤訊息(完整)
       dzye016          LIKE dzye_t.dzye016,          #執行階段
       dzye017          LIKE dzye_t.dzye017,          #執行日期
       dzye024          LIKE dzye_t.dzye024,          #執行使用者
       
       dzye008          LIKE dzye_t.dzye008,          #PID
       dzye009          LIKE dzye_t.dzye009,          #目的建構版次
       dzye010          LIKE dzye_t.dzye010,          #目的規格版次
       dzye011          LIKE dzye_t.dzye011,          #目的程式版次
       dzye013          LIKE dzye_t.dzye013,          #順序
       dzye014          LIKE dzye_t.dzye014,          #來源建構版次
       dzye019          LIKE dzye_t.dzye019,          #來源程式客制否
       dzye020          LIKE dzye_t.dzye020,          #來源規格版次
       dzye021          LIKE dzye_t.dzye021           #來源程式版次
       END RECORD

DEFINE g_work_dir           STRING              #目前程式執行路徑
DEFINE g_patch_tar_path     STRING              #patch執行patch/入時,tar放置完整路徑
DEFINE g_write_log          LIKE type_t.chr1    #開啟log是否成功
DEFINE g_log_file           STRING              #log file name
DEFINE g_channel            base.Channel


DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_forupd_sql          STRING
DEFINE g_sql                 STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500)     #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500)     #同步資料用陣列
DEFINE g_insert              LIKE type_t.chr5                  #是否導到其他page
DEFINE g_cnt                 LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_bfill               LIKE type_t.chr5                  #是否刷新單身
DEFINE g_aw                  STRING                            #確定當下點擊的單身
DEFINE g_current_page        LIKE type_t.num5                  #目前所在頁數
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
DEFINE g_export_flag         LIKE type_t.chr1                  #是否已匯出adzi888維護作業上所填寫的所有資訊    
DEFINE g_order               STRING                            #查詢排序欄位
DEFINE g_default             BOOLEAN                           #是否有外部參數查詢
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                            #單身CONSTRUCT結果
DEFINE g_wc3                 STRING                            #單身CONSTRUCT結果
DEFINE g_browser_cnt         LIKE type_t.num5                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5                  #Browser目前所在筆數
DEFINE g_detail_cnt          LIKE type_t.num5
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_state               STRING
DEFINE g_current_row         LIKE type_t.num5                  #Browser所在筆數
DEFINE g_page_action         STRING                            #page ACTION
DEFINE g_pagestart           LIKE type_t.num5
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5  

DEFINE g_patch_m             type_g_patch_m
DEFINE g_ddata_d             DYNAMIC ARRAY OF type_g_ddata_d
DEFINE g_dfile_d             DYNAMIC ARRAY OF type_g_dfile_d
DEFINE g_dtool_d             DYNAMIC ARRAY OF type_g_dtool_d
DEFINE g_detail4_d           DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_d_t         type_g_detail4_d
DEFINE g_rec_b               LIKE type_t.num5 
DEFINE g_detail_idx          LIKE type_t.num5                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num5                  #單身2目前所在筆數
DEFINE g_detail_idx3         LIKE type_t.num5                  #單身3目前所在筆數
DEFINE g_detail_idx4         LIKE type_t.num5                  #單身4目前所在筆數(g_dzye_d)
#DEFINE g_patch003            STRING
DEFINE g_patch003_t          LIKE type_t.chr100                #patch包來源路徑(舊值)
DEFINE g_patch006_t          LIKE type_t.chr100                #patch解包檔路徑(舊值)
DEFINE g_patch007_t          LIKE type_t.chr1                  #是否gen 42s(舊值)
DEFINE g_patch008_t          LIKE type_t.chr1                  #merge
DEFINE g_patch009_t          LIKE type_t.chr1                  #是否為快速patch 160816-00047
DEFINE g_finish_flag         LIKE type_t.chr1                  #是否完成patch
DEFINE g_tmp_folder          STRING                            #patch解包路徑(tmp) 16/07/18
DEFINE g_start_time          DATETIME YEAR TO SECOND           #patch解包起始時間  16/08/31
DEFINE g_finish_time         DATETIME YEAR TO SECOND           #patch解包結束時間  16/08/31
DEFINE g_merge               LIKE type_t.chr1                  #預設是否merge  2016/12/29

#+ 瀏覽頁簽資料初始化
PUBLIC FUNCTION adzp999_01()
   DEFINE l_win_curr         ui.Window             #Current Window
   DEFINE l_frm_curr         ui.Form               #Current Form
   DEFINE ls_cfg_path        STRING
   DEFINE ls_4st_path        STRING
   DEFINE ls_img_path        STRING
   DEFINE l_cmd              STRING
   DEFINE l_msg              util.JSONObject
   DEFINE l_tmp              STRING
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_idx              LIKE type_t.num5
   DEFINE l_pid              STRING
   DEFINE l_time             STRING
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #CALL sadzi888_01_create_temp_table()
   
   #2016/12/13
   IF ARG_VAL(3) = "-v" OR ARG_VAL(3) = "-version" THEN
      CALL adzp999_01_version()
      EXIT PROGRAM
   END IF
   #2016/12/13
   #2016/12/29
   IF (ARG_VAL(3) = "-n" OR ARG_VAL(3) = "-N") AND NOT cl_null(ARG_VAL(3)) THEN
      LET g_merge = "N"
      DISPLAY "INFO:預設全不merge!"
   ELSE
      LET g_merge = "Y"
      DISPLAY "INFO:預設全merge!"
   END IF
   #2016/12/29
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_adzp999_01 WITH FORM cl_ap_formpath("adz", "adzp999_01")
   
   ##瀏覽頁簽資料初始化
   #CALL cl_ui_init()

   #adz模組採用的畫面風格
   #關閉Genero預設的視窗
   TRY
      CLOSE WINDOW screen
   CATCH
   END TRY

   LET l_win_curr = ui.Window.getCurrent()  #取得現行畫面
   LET l_frm_curr = l_win_curr.getForm()    #取出物件化後的畫面物件
   
   CALL cl_ui_wintitle(1) #工具抬頭名稱
   CALL cl_load_4ad_interface(NULL)
   
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL l_win_curr.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
   
   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   #檢查是否還有patch正在進行中
   #ps -ef | grep '/u1/topprd/erp/adz/42r/adzp999.* 4' |grep -v grep |awk '{print $2 "|" $5}'
   LET l_cmd = "ps -ef | grep '"
   LET l_cmd = l_cmd, os.Path.join(FGL_GETENV("ADZi"), "adzp999")
   LET l_cmd = l_cmd, ".* 4' |grep -v grep |awk '{print $2 ""|"" $5}'"
   LET l_tmp = sadzi888_01_get_command_msg(l_cmd) 
   LET l_msg = util.JSONObject.parse(l_tmp)

   IF l_msg.getLength() > 1 THEN
      FOR l_i = 1 TO l_msg.getLength()
         LET l_tmp = l_msg.get(l_msg.name(l_i))

         #取得process ID
         LET l_idx = l_tmp.getIndexOf("|", 1)
         LET l_pid = l_tmp.subString(1, l_idx - 1)

         IF l_pid = FGL_GETPID() THEN
            CONTINUE FOR
         END IF
         
         #取得執行時間
         LET l_time = l_tmp.subString(l_idx + 1, l_tmp.getLength())
         EXIT FOR
      END FOR
      
      #IF l_tmp.getIndexOf("|", 1) > 0 THEN
      #   #取得process ID
      #   LET l_idx = l_tmp.getIndexOf("|", 1)
      #   LET l_pid = l_tmp.subString(1, l_idx - 1)

      #   #取得執行時間
      #   LET l_time = l_tmp.subString(l_idx + 1, l_tmp.getLength())
      #END IF

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00626"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_pid.trim()
      #LET g_errparam.replace[2] = l_time.trim()
      CALL cl_err()
      DISPLAY "r.patch is work. cmd:", l_tmp
      RETURN
   END IF
   
   #程式初始化
   LET g_bgjob = "N" #2017/02/13
   IF NOT adzp999_01_init() THEN
      RETURN
   END IF

   CALL FGL_SETENV("T100PATCH","Y") #2016/12/02 
   DISPLAY "T100PATCH:",FGL_GETENV("T100PATCH")
   CALL adzp999_01_ui_dialog()
   
   CALL FGL_SETENV("T100PATCH","") #2016/12/02 
   DISPLAY "T100PATCH:",FGL_GETENV("T100PATCH")

   #離開程式時,刪除暫存表
   #CALL sadzi888_01_drop_temp_table()
   #DROP TABLE tmp_dzye_t

   CLOSE WINDOW w_adzp999_01
END FUNCTION

##+ 建立temp table
#PRIVATE FUNCTION adzp999_01_crate_temp_table()
#
#   CALL sadzi888_01_create_temp_table()
#
#   #建立dzye_t的temp table
#   SELECT * FROM dzye_t WHERE 1 = 2 INTO TEMP tmp_dzye_t
#
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "create tmp dzye_t:"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN FALSE
#   END IF
#
#   RETURN TRUE
#END FUNCTION

#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzp999_01_init()
   DEFINE l_sql             STRING
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   LET g_show_msg = "Y"        #GUI模式操作
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx3 = 1
   LET g_detail_idx4 = 1

   #2016/06/28
   #關閉dspatch輸入, 改由資料庫撈取
   #LET g_patch_m.patch004 = ""
   LET  g_patch_m.patch004 = sadzi888_01_get_db_connect_string(g_patch_schema)
   IF NOT adzp999_01_test_connect(g_patch_schema, g_patch_schema, g_patch_m.patch004) THEN
      LET g_patch_m.patch004 = ""
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-xxxxx"
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_patch_schema
      CALL cl_err()
      RETURN FALSE
   END IF
   #CALL cl_set_comp_visible("lbl_patch004,patch004",FALSE) #2017/02/13
   #2016/06/28
   
   LET g_patch_m.patch005 = "N" 
   #CALL cl_set_comp_visible("lbl_patch005,patch005",FALSE) #2016/08/31 #2017/02/13
   LET g_patch_m.patch007 = "N"
   #LET g_patch_m.patch008 = "N" #2016/08/31
   LET g_patch_m.patch008 = "Y" #2016/08/31
   #CALL cl_set_comp_entry("patch008",FALSE) #2016/08/31
   #CALL cl_set_comp_visible("lbl_patch008,patch008",FALSE) #2016/08/31 #2017/02/13
   LET g_patch_m.patch009 = "N" #160816-00047
   LET g_quick_patch = "N" #160816-00047
   
   #CALL cl_set_comp_visible("dzye015",FALSE) #2016/08/31
   
   LET g_patch003_t = ""
   LET g_patch006_t = ""
   LET g_finish_flag = FALSE
   
   LET g_curr_tasks = 0
   
   #2017/02/13
   #IF NOT adzp999_01_ddata005_items_fill() THEN
   #   RETURN FALSE
   #END IF
   #2017/02/13

   #設定dtool003(工具類可過單模組別)
   #CALL cl_set_combo_items("dtool003", "adz,azz,lib,sub,oth", "1:adz,2:azz,3:lib,4:sub,5:other") #2017/02/13
   
   #2017/02/13
   #背景模式判斷
   IF g_bgjob = "N" THEN
      CALL cl_set_comp_visible("lbl_patch004,patch004",FALSE)
      CALL cl_set_comp_visible("lbl_patch005,patch005",FALSE)
      CALL cl_set_comp_visible("lbl_patch008,patch008",FALSE)
      CALL cl_set_combo_items("dtool003", "adz,azz,lib,sub,oth", "1:adz,2:azz,3:lib,4:sub,5:other")
      IF NOT adzp999_01_ddata005_items_fill() THEN
         RETURN FALSE
      END IF
   END IF 
   #2017/02/13
   
   #依據[程式代碼]取得所有相關註冊資訊作業的主要資料表名稱
   LET l_sql = "SELECT DISTINCT dzyb001, dzyb002, dzyb003, dzyb004, dzyb005, ",
               "                dzyb006, dzyb007, dzyb008, dzyb009 ",
               "  FROM dzyb_t LEFT JOIN dzya_t ON dzyb001 = dzya002 ",
               "  WHERE dzya001 = ? AND dzyb003 = ? " 
   DECLARE adzp999_01_dzyb_prog_cs CURSOR FROM l_sql

   #依據[日期]取得所有相關註冊資訊作業的主要資料表名稱
   LET l_sql = "SELECT DISTINCT dzyb001, dzyb002, dzyb003, dzyb004, dzyb005, ",
               "                dzyb006, dzyb007, dzyb008, dzyb009 ",
               "  FROM dzyb_t LEFT JOIN dzya_t ON dzyb001 = dzya002 ",
               "  WHERE dzyb003 = ? ", 
               "    AND dzyb001 NOT IN ('design_data')"
   DECLARE adzp999_01_dzyb_date_cs CURSOR FROM l_sql

   RETURN TRUE
END FUNCTION

#+ 功能選單
PRIVATE FUNCTION adzp999_01_ui_dialog()
   DEFINE li_idx            LIKE type_t.num5
   DEFINE ls_wc             STRING
   DEFINE lb_first          BOOLEAN
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_tar_file_path   STRING
   DEFINE l_cmd             STRING           #2016/02/22
   DEFINE li_cnt            LIKE type_t.num5 #2016/02/22
   DEFINE li_chk            LIKE type_t.num5 #2016/08/16 
   
   CALL cl_set_act_visible("accept,cancel", FALSE)

   WHILE TRUE 
    
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         INPUT BY NAME g_patch_m.patch003, g_patch_m.patch004, g_patch_m.patch005, 
                       g_patch_m.patch007, g_patch_m.patch008, g_patch_m.patch009 ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
               #CALL cl_set_comp_required("patch003", TRUE)

            AFTER FIELD patch003
               IF cl_null(g_patch_m.patch003) OR (NOT os.Path.exists(g_patch_m.patch003)) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00586"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF

               IF g_patch_m.patch003 <> g_patch003_t OR cl_null(g_patch003_t) THEN
                  IF NOT adzp999_01_cp_pack() THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF

            AFTER FIELD patch004
               IF NOT adzp999_01_test_connect("dspatch", "dspatch", g_patch_m.patch004) THEN
                  LET g_patch_m.patch004 = ""
                  DISPLAY BY NAME g_patch_m.patch004
                  NEXT FIELD patch004
               END IF
            
            #2016/08/31
            #AFTER FIELD patch008
            #   #改變此欄位時連動可merge否欄位(dzye015)
            #   IF g_patch_m.patch008 = 'Y' THEN
            #      #更新客製標準段
            #      CALL cl_set_comp_visible("dzye015",TRUE)
            #   ELSE
            #      #不更新標準段(隱藏dzye015)
            #      CALL cl_set_comp_visible("dzye015",FALSE)
            #   END IF
            #2016/08/31
            
            #patch上傳,解析patch包基礎資訊
            ON ACTION upload_pack
               LET g_action_choice = "upload_pack"

               IF NOT adzp999_01_upload_pack() THEN
                  NEXT FIELD CURRENT
               END IF

            #160816-00047
            ON CHANGE patch009
               #再次確認是否進行快速更新
               IF NOT cl_ask_confirm("adz-00897") THEN 
                  LET g_patch_m.patch009 = "N"
                  DISPLAY BY NAME g_patch_m.patch009
               END IF
            #160816-00047
               
         END INPUT
         
         DISPLAY ARRAY g_ddata_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1
            BEFORE ROW
               CALL adzp999_01_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL adzp999_01_idx_chk()
               
         END DISPLAY

         DISPLAY ARRAY g_dfile_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
            BEFORE ROW
               CALL adzp999_01_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               CALL adzp999_01_idx_chk()
               
         END DISPLAY

         DISPLAY ARRAY g_dtool_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
            BEFORE ROW
               CALL adzp999_01_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx3 = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx3)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               CALL adzp999_01_idx_chk()
               
         END DISPLAY

         #patch程式(dzye_t)清單
         INPUT ARRAY g_detail4_d FROM s_detail4.*
             ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, INSERT ROW = FALSE, DELETE ROW = FALSE, APPEND ROW = FALSE)

            BEFORE ROW
               CALL adzp999_01_idx_chk()
               LET l_ac = ARR_CURR()          #DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx4 = l_ac
               LET g_rec_b = g_ddata_d.getLength()

               SELECT dzye001, dzye002, dzye003, dzye004, dzye005, 
                      dzye006, dzye007, dzye008, dzye009, dzye010,  
                      dzye011, dzye012, dzye013, dzye014, dzye015,  
                      dzye016, dzye017, dzye018, dzye019, dzye020,  
                      dzye021, dzye022, dzye023, dzye024
                 INTO g_detail4_d[l_ac].dzye001, g_detail4_d[l_ac].dzye002, g_detail4_d[l_ac].dzye003, g_detail4_d[l_ac].dzye004, g_detail4_d[l_ac].dzye005,
                      g_detail4_d[l_ac].dzye006, g_detail4_d[l_ac].dzye007, g_detail4_d[l_ac].dzye008, g_detail4_d[l_ac].dzye009, g_detail4_d[l_ac].dzye010,
                      g_detail4_d[l_ac].dzye011, g_detail4_d[l_ac].dzye012, g_detail4_d[l_ac].dzye013, g_detail4_d[l_ac].dzye014, g_detail4_d[l_ac].dzye015,
                      g_detail4_d[l_ac].dzye016, g_detail4_d[l_ac].dzye017, g_detail4_d[l_ac].dzye018, g_detail4_d[l_ac].dzye019, g_detail4_d[l_ac].dzye020,
                      g_detail4_d[l_ac].dzye021, g_detail4_d[l_ac].dzye022, g_detail4_d[l_ac].dzye023, g_detail4_d[l_ac].dzye024 
                 FROM tmp_dzye_t 
                 WHERE dzye001 = g_detail4_d[l_ac].dzye001 AND dzye002 = g_detail4_d[l_ac].dzye002
                 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'sel tmp_dzye_t.', g_detail4_d[l_ac].dzye002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
                  
               LET g_detail4_d_t.* = g_detail4_d[l_ac].*   #BACKUP

            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_detail_idx4)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               CALL adzp999_01_idx_chk()
               LET g_rec_b = g_detail4_d.getLength()

            ON CHANGE dzye001
               
            ON CHANGE dzye015
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET INT_FLAG = 0
                  LET g_detail4_d[l_ac].* = g_detail4_d_t.*
                  #CLOSE adzp999_01_bc4
                  #NEXT FIELD CURRENT
               END IF

               #標準程式預設不需做Merge,執行標準patch流程(Merge程序只會發生在客制程式情境)
               IF g_detail4_d[l_ac].dzye012 = "s" THEN
                  LET g_detail4_d[l_ac].dzye015 = ""
                  NEXT FIELD dzye015
               END IF
               
               #2016/12/14
               #G,X類不進行merge
               IF g_detail4_d[l_ac].dzye003 = "G" OR
                  g_detail4_d[l_ac].dzye003 = "X" THEN 
                  LET g_detail4_d[l_ac].dzye015 = ""
                  NEXT FIELD dzye015
               END IF
               #2016/12/14

               #客制程式建構類型為是(M:主程式, S:子程式, F:子畫面, Z:服務, W:服務元件),才提供客制Merge選擇功能
               #其餘客制程式之建構類型皆一律執行Merge程式
               IF g_detail4_d[l_ac].dzye012 = "c" THEN
                  IF NOT(g_detail4_d[l_ac].dzye003 = "M" OR g_detail4_d[l_ac].dzye003 = "S" OR g_detail4_d[l_ac].dzye003 = "F" OR 
                     g_detail4_d[l_ac].dzye003 = "W" OR  g_detail4_d[l_ac].dzye003 = "Z") THEN
                     
                     #LET g_detail4_d[l_ac].dzye015 = "Y" 
                     #NEXT FIELD dzye015
                     
                     #2016/09/22
                     LET g_detail4_d[l_ac].dzye015 = "Y" 
                     NEXT FIELD dzye015
                     #2016/09/22
                     
                  ELSE
                     IF g_detail4_d_t.dzye015 = "N" THEN
                        #2016/11/30
                        IF g_detail4_d[l_ac].dzye022 = 'Y' THEN #目的程式為簽出
                           LET g_detail4_d[l_ac].dzye015 = "N" 
                        ELSE
                           LET g_detail4_d[l_ac].dzye015 = "Y"
                        END IF
                        #LET g_detail4_d[l_ac].dzye015 = "Y"
                        #2016/11/30
                     ELSE
                        LET g_detail4_d[l_ac].dzye015 = "N"
                     END IF
                  END IF
               END IF
               
               UPDATE tmp_dzye_t SET dzye015 = g_detail4_d[l_ac].dzye015
                 WHERE dzye001 = g_detail4_d[l_ac].dzye001
                   AND dzye002 = g_detail4_d[l_ac].dzye002

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "upd tmp_dzye_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail4_d[l_ac].* = g_detail4_d_t.*
               END IF
               
               #2016/09/22
               LET g_detail4_d_t.dzye015 = g_detail4_d[l_ac].dzye015
               #2016/09/22

            AFTER ROW
               LET l_ac = ARR_CURR()
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET INT_FLAG = 0
                  LET g_detail4_d[l_ac].* = g_detail4_d_t.*
                  #CLOSE adzp999_01_bc4
                  EXIT DIALOG 
               END IF

               #CLOSE adzp999_01_bc4
               
         END INPUT
         
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()

            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_row = g_current_idx #目前指標
            
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            
            IF g_patch_m.patch001 IS NOT NULL THEN
               CALL adzp999_01_show()
            END IF
            
            CALL adzp999_01_ui_detailshow()

            #筆數顯示
            LET g_current_page = 1
            CALL adzp999_01_idx_chk()

            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD ddata002
            END IF

            IF g_finish_flag THEN
               CALL cl_set_act_visible("exporttoexcel", TRUE)
            ELSE
               CALL cl_set_act_visible("exporttoexcel", FALSE)
            END IF
            
         #取得所有patch資訊
         ON ACTION get_pack_list
         
            #2016/06/28
            #檢查是否需要做cp
            IF g_patch_m.patch003 <> g_patch003_t OR cl_null(g_patch003_t) THEN
               IF NOT adzp999_01_cp_pack() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            #2016/06/28
         
            IF NOT cl_null(g_patch_m.patch006) THEN
               IF NOT os.Path.EXISTS(g_patch_m.patch006) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00328"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_patch_m.patch006 CLIPPED
                  CALL cl_err()
                  NEXT FIELD patch003
               END IF

               LET g_action_choice = "get_pack_list"
               CALL adzp999_01_get_pack_list_pre()
            END IF
            
            #CALL adzp999_01_prog_diff("Y") #16/07/18 #2016/09/22
            
            #2016/08/31
            #如果adzp888已完成則關閉該選項
            LET li_cnt = 0
            SELECT COUNT(*) INTO li_cnt FROM ds.dzyg_t
             WHERE dzyg001 = g_patch_m.patch002
               AND dzyg003 = 'Y' 
               AND dzyg004 = 'Y' 
            IF li_cnt > 0 THEN
               SELECT dzyg012 
                 INTO g_patch_m.patch008 
                 FROM ds.dzyg_t
                WHERE dzyg001 = g_patch_m.patch002
                  AND dzyg003 = 'Y' 
                  AND dzyg004 = 'Y' 
               DISPLAY BY NAME g_patch_m.patch008 
               CALL cl_set_comp_entry("patch008",FALSE)
            ELSE
               CALL cl_set_comp_entry("patch008",TRUE)
            END IF
            #2016/08/31
           
         #patch解包程式
         ON ACTION import_patch
            LET g_quick_patch = g_patch_m.patch009 #160816-00047
         
            IF cl_null(g_patch_m.patch003) OR cl_null(g_patch_m.patch006) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00328"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = g_patch_m.patch006 CLIPPED
               CALL cl_err()
               NEXT FIELD patch003
            END IF

            IF cl_null(g_patch_m.patch004) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00597"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = "dspatch"
               NEXT FIELD patch004
            END IF
            
            #2016/06/28 - start - 檢查包號規則
            IF NOT adzp999_01_chk_routine_num(g_patch_m.patch002,TRUE) THEN
               CONTINUE DIALOG
            END IF
            #2016/06/28 -  end  -
            
            #2016/03/07
            IF FGL_GETENV("DGENV")="s" AND
               FGL_GETENV("TOPIND") IS NOT NULL AND
               FGL_GETENV("TOPIND") <> "sd" THEN
               CALL FGL_SETENV("TOPCHKOUT","N")
            END IF
            
            LET g_start_time = cl_get_current() #2016/08/31

            #2016/09/22
            #開啟進度列
            OPEN WINDOW w_adzp999_01_s01 WITH FORM cl_ap_formpath("adz", "adzp999_01_s01")
               ATTRIBUTE(STYLE = "openwin")
               
            #初始進度為0 
            LET g_adzp999_01_s01 = TRUE
            LET g_curr_tasks = 0
            DISPLAY g_curr_tasks TO FORMONLY.progs01
            DISPLAY g_curr_tasks TO FORMONLY.dummy01
            CALL ui.Interface.refresh()
               
            #進度列控制
            IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
               CALL adzp999_01_refresh_tasks_progressbar(gc_empty_dspatch, "adz-00605")
               CALL adzp999_01_refresh_sub_tasks_progressbar(1, 3)
            END IF
            #2016/09/22
            
            #2016/08/16
            #等候adzp888完成
            WHILE TRUE
               IF adzp999_01_adzp888_chk_run() THEN
                  #還在跑-休息5秒
                  DISPLAY "INFO:等待adzp888完成!..."
                  SLEEP 5
               ELSE
                  DISPLAY "INFO:無adzp888正在運行, 進行下面步驟!..."
                  #已完成(跳離)
                  EXIT WHILE
               END IF
            END WHILE
            #2016/08/16
            
            #2016/09/22
            #進度列控制
            IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
               CALL adzp999_01_refresh_sub_tasks_progressbar(2, 3)
            END IF
            #2016/09/22
            
            #2016/02/22 by ka0132
            #檢查是否執行過adzp888
            LET li_cnt = 0
            SELECT COUNT(*) INTO li_cnt FROM ds.dzyg_t
             WHERE dzyg001 = g_patch_m.patch002
               AND dzyg003 = 'Y' 
               AND dzyg004 = 'Y' 
            IF li_cnt = 0 THEN 
               DISPLAY 'Info:未執行adzp888, 重新執行!'
               #LET l_cmd = "r.r adzp888 ",g_patch_m.patch006, " '' ",g_patch_m.patch008
               LET l_cmd = "r.r adzp888 ",g_patch_m.patch006, " '' Y"
               DISPLAY 'Info:開始執行,',l_cmd
               LET li_chk = sadzi999_01_run_command(l_cmd) #2016/09/22
               SELECT COUNT(*) INTO li_cnt FROM ds.dzyg_t
                WHERE dzyg001 = g_patch_m.patch002
                  AND dzyg003 = 'Y' 
                  AND dzyg004 = 'Y' 
               IF li_cnt = 0 THEN
                  #2016/08/16
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00899"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  DISPLAY 'Info:adzp888執行異常, 請參考背景訊息!'
                  #2016/08/16
                  EXIT DIALOG
               END IF
            END IF
            #2016/02/22 by ka0132

            #2016/09/22
            #進度列控制
            IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
               CALL adzp999_01_refresh_sub_tasks_progressbar(3, 3)
            END IF
            #2016/09/22
            
            LET g_action_choice = "import_patch"
            LET g_finish_flag = FALSE
            CALL adzp999_01_import_patch_pre()
            
            #2016/10/21
            #2016/08/31
            #LET g_finish_time = cl_get_current() 
            #DISPLAY "Patch起始時間:",g_start_time
            #DISPLAY "Patch結束時間:",g_finish_time
            #DISPLAY "Patch花費時間:",g_finish_time - g_start_time
            #INITIALIZE g_errparam TO NULL
            #LET g_errparam.code = "adz-00900"
            #LET g_errparam.type = 2
            #LET g_errparam.replace[1] = g_finish_time - g_start_time
            #LET g_errparam.popup = TRUE
            #CALL cl_err()
            #2016/08/31
            #2016/10/21
            
            CLOSE WINDOW w_adzp999_01_s01
            EXIT DIALOG

         #16/07/18
         ON ACTION prog_diff
            CALL adzp999_01_prog_diff("N")
         #16/07/18         
            
         ON ACTION exporttoexcel
            LET g_action_choice = "exporttoexcel"
            CALL g_export_node.clear()

            LET g_export_node[1] = base.typeInfo.create(g_detail4_d)
            LET g_export_id[1] = "s_detail4"

            LET g_export_node[2] = base.typeInfo.create(g_ddata_d)
            LET g_export_id[2] = "s_detail1"

            LET g_export_node[3] = base.typeInfo.create(g_dfile_d)
            LET g_export_id[3] = "s_detail2"

            LET g_export_node[4] = base.typeInfo.create(g_dtool_d)
            LET g_export_id[4] = "s_detail3"

            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
            
         ON ACTION CLOSE
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION EXIT
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master", 0)
               CALL gfrm_curr.setElementImage("controls", "small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master", 1)
               CALL gfrm_curr.setElementImage("controls", "small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
  
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG 
               
      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF  
   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

#+ 設定patch類型所屬維護作業有那些
PRIVATE FUNCTION adzp999_01_ddata005_items_fill()
   DEFINE l_sql             STRING
   DEFINE l_ddata005_value  STRING
   DEFINE l_ddata005_label  STRING
   DEFINE l_gzzal001        LIKE gzzal_t.gzzal001
   DEFINE l_gzzal003        LIKE gzzal_t.gzzal003

   LET l_ddata005_value = ""
   LET l_ddata005_label = ""
   
   LET l_sql = "SELECT dzyb001, gzzal003 ", 
               "  FROM ((SELECT DISTINCT dzyb001 FROM dzyb_t) UNION (SELECT 'adzi140' FROM dual)) ", 
               "           LEFT JOIN gzzal_t ON dzyb001 = gzzal001 AND gzzal002 = ? ",
               "  ORDER BY dzyb001 "

   PREPARE adzp999_01_ddata005_pre FROM l_sql
   DECLARE adzp999_01_ddata005_cs CURSOR FOR adzp999_01_ddata005_pre

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE adzp999_01_ddata005_cs:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   OPEN adzp999_01_ddata005_cs USING g_lang
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "OPEN adzp999_01_ddata005_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzp999_01_ddata005_cs
      RETURN FALSE
   END IF

   FOREACH adzp999_01_ddata005_cs INTO l_gzzal001, l_gzzal003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH adzp999_01_ddata005_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF

      #維護作業程式代號
      IF cl_null(l_ddata005_value) THEN
         LET l_ddata005_value = l_gzzal001
      ELSE
         LET l_ddata005_value = l_ddata005_value, ",", l_gzzal001
      END IF

      #items說明
      IF cl_null(l_ddata005_label) THEN
         IF l_gzzal001 = "design_data" THEN
            LET l_ddata005_label = l_gzzal001
         ELSE
            LET l_ddata005_label = l_gzzal001, "(", l_gzzal003, ")"
         END IF
      ELSE
         LET l_ddata005_label = l_ddata005_label, ",", l_gzzal001, "(", l_gzzal003, ")"
      END IF
   END FOREACH 

   #設定維護作業
   CALL cl_set_combo_items("ddata005", l_ddata005_value, l_ddata005_label)

   RETURN TRUE
END FUNCTION

#+ 單身資料重新顯示
PRIVATE FUNCTION adzp999_01_ui_detailshow()
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1", g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2", g_detail_idx2)
      CALL g_curr_diag.setCurrentRow("s_detail3", g_detail_idx3)
      CALL g_curr_diag.setCurrentRow("s_detail4", g_detail_idx4)
   END IF
END FUNCTION

#+ 單身筆數變更
PRIVATE FUNCTION adzp999_01_idx_chk()
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_ddata_d.getLength() THEN
         LET g_detail_idx = g_ddata_d.getLength()
      END IF
      
      IF g_detail_idx = 0 AND g_ddata_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF

      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ddata_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_dfile_d.getLength() THEN
         LET g_detail_idx2 = g_dfile_d.getLength()
      END IF
      
      IF g_detail_idx2 = 0 AND g_dfile_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_dfile_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 3 THEN
      LET g_detail_idx3 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx3 > g_dtool_d.getLength() THEN
         LET g_detail_idx3 = g_dtool_d.getLength()
      END IF
      
      IF g_detail_idx3 = 0 AND g_dtool_d.getLength() <> 0 THEN
         LET g_detail_idx3 = 1
      END IF
      
      DISPLAY g_detail_idx3 TO FORMONLY.idx
      DISPLAY g_dtool_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 4 THEN
      LET g_detail_idx4 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx4 > g_detail4_d.getLength() THEN
         LET g_detail_idx4 = g_detail4_d.getLength()
      END IF
      
      IF g_detail_idx4 = 0 AND g_detail4_d.getLength() <> 0 THEN
         LET g_detail_idx4 = 1
      END IF
      
      DISPLAY g_detail_idx4 TO FORMONLY.idx
      DISPLAY g_detail4_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION

#+ patch檔上傳
PRIVATE FUNCTION adzp999_01_upload_pack()
   DEFINE l_pack_dir        STRING               #打包檔置放路徑
   DEFINE l_src             STRING               #來源文件
   DEFINE l_dst             STRING               #目的
   DEFINE l_work_dir        STRING               #目前程式執行路徑
   DEFINE l_folder          STRING               #匯出檔目錄
   DEFINE l_tar_name        STRING               #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_cmd             STRING
   DEFINE l_msg             STRING
   DEFINE l_result          BOOLEAN
   
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)

   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE
   END IF

   #Client選擇上傳匯出檔案
   LET l_src = cl_client_browse_file()

   IF l_src.getLength() < 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "lib-00123"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   CALL adzp999_01_get_pack_name(l_src.trim())
      RETURNING l_result, l_tar_name, l_folder

   IF NOT l_result THEN
      RETURN FALSE
   END IF
   
   #檢查目錄是否存在
   IF NOT sadzi888_01_delete_pack(l_folder, l_tar_name) THEN
      RETURN FALSE
   END IF

   #Server上傳檔案路徑/檔名
   LET l_dst = os.Path.JOIN(l_pack_dir, l_tar_name)
   
   #上傳檔案至Server端
   IF NOT cl_client_upload_file(l_src, l_dst) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00332"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(l_tar_name) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00328"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_tar_name.trim()
      CALL cl_err()
      RETURN FALSE
   ELSE
      CALL cl_ask_pressanykey("adz-00333")
   END IF

   #當重新上傳patch包時,預設自動所有Patch資訊皆要重新取得
   #先備份一些必要資訊
   LET g_patch_pwd = g_patch_m.patch004
   LET g_patch007_t = g_patch_m.patch007
   LET g_patch008_t = g_patch_m.patch008
   LET g_patch009_t = g_patch_m.patch009
   
   INITIALIZE g_patch_m TO NULL

   #刪除所有temp table內的資料
   DELETE FROM adzi888_master WHERE 1 = 1
   DELETE FROM adzi888_ddata WHERE 1 = 1
   DELETE FROM adzi888_dfile WHERE 1 = 1
   DELETE FROM adzi888_dtool WHERE 1 = 1
   DELETE FROM tmp_dzye_t WHERE 1 = 1       #因為這個tmp table是針對patch(或程式設計資料匯出入)運作時所需要的,因此命名與其他temp table不同

   #透過Client本機上傳,預設patch包來源和解包路徑一致
   LET g_patch_m.patch003 = os.Path.join(os.Path.pwd(), l_tar_name.trim())
   LET g_patch_m.patch006 = g_patch_m.patch003

   LET g_patch003_t = g_patch_m.patch003
   LET g_patch006_t = g_patch_m.patch006

   LET g_patch_m.patch004 = g_patch_pwd
   LET g_patch_m.patch005 = "N"
   LET g_patch_m.patch007 = g_patch007_t
   LET g_patch_m.patch008 = g_patch008_t
   LET g_patch_m.patch009 = g_patch009_t
   
   CALL adzp999_01_show()

   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      DISPLAY "warning:adzp999_01_upload_pack.sadzi888_01_change_work_dir()" 
   END IF

   RETURN TRUE
END FUNCTION


#+ patch檔已存在server上,cp 至解包時工作目錄
PRIVATE FUNCTION adzp999_01_cp_pack()
   DEFINE l_pack_dir        STRING               #打包檔置放路徑
   DEFINE l_src             STRING               #來源文件
   DEFINE l_dst             STRING               #目的
   DEFINE l_work_dir        STRING               #目前程式執行路徑
   DEFINE l_folder          STRING               #匯出檔目錄
   DEFINE l_tar_name        STRING               #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_cmd             STRING
   DEFINE l_msg             STRING
   DEFINE l_patch003        STRING
   DEFINE l_result          BOOLEAN
   
   #切換到$TEMPDIR工作目錄下
   LET l_pack_dir = FGL_GETENV(g_pack_dir_env)

   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN FALSE
   END IF

   LET l_patch003 = g_patch_m.patch003
   LET l_src = g_patch_m.patch003
   
   CALL adzp999_01_get_pack_name(l_src.trim())
      RETURNING l_result, l_tar_name, l_folder

   IF NOT l_result THEN
      RETURN FALSE
   END IF

   #刪除目錄
   IF os.Path.EXISTS(l_folder) THEN
      LET l_cmd = "rm -rf ", l_folder
      RUN l_cmd
   END IF

   #patch在$TEMPDIR目錄下為標準解包路徑,即不做任何處理
   IF os.Path.dirname(g_patch_m.patch003) <> l_pack_dir THEN
      #刪除原patch包
      IF os.Path.EXISTS(l_tar_name) THEN
         LET l_cmd = "rm -f ", l_tar_name
         RUN l_cmd
      END IF

      #檢查環境是否已還原
      IF os.Path.EXISTS(l_tar_name) OR os.Path.EXISTS(l_folder) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00595"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_tar_name.trim()
         LET g_errparam.replace[2] = l_folder.trim()
         CALL cl_err()
         RETURN FALSE
      END IF
   
      #Server上傳檔案路徑/檔名
      LET l_dst = os.Path.JOIN(l_pack_dir, l_tar_name)
   
      IF NOT os.Path.copy(l_src, l_dst) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00589"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_tar_name.trim()
         CALL cl_err()
         RETURN FALSE
      END IF

      #檢查tar是否存在
      IF NOT os.Path.EXISTS(l_tar_name) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00328"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_tar_name.trim()
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF

   #2017/02/13
   IF g_bgjob = "N" THEN
      CALL cl_ask_pressanykey("adz-00596")
   END IF
   #2017/02/13
   
   #當重新指定patch包路徑時,預設自動所有Patch資訊皆要重新取得
   #先備份一些必要資訊
   LET g_patch_pwd = g_patch_m.patch004
   LET g_patch007_t = g_patch_m.patch007
   LET g_patch008_t = g_patch_m.patch008
   LET g_patch009_t = g_patch_m.patch009
   
   INITIALIZE g_patch_m TO NULL

   #刪除所有temp table內的資料
   DELETE FROM adzi888_master WHERE 1 = 1
   DELETE FROM adzi888_ddata WHERE 1 = 1
   DELETE FROM adzi888_dfile WHERE 1 = 1
   DELETE FROM adzi888_dtool WHERE 1 = 1
   DELETE FROM tmp_dzye_t WHERE 1 = 1       #因為這個tmp table是針對patch(或程式設計資料匯出入)運作時所需要的,因此命名與其他temp table不同

   #透過Server cp方式,可能會patch包來源和解包路徑不同(預設patch包在$TEMPDIR下運作)
   LET g_patch_m.patch003 = l_patch003
   LET g_patch_m.patch006 = os.Path.join(os.Path.pwd(), l_tar_name.trim())

   LET g_patch003_t = g_patch_m.patch003
   LET g_patch006_t = g_patch_m.patch006

   LET g_patch_m.patch004 = g_patch_pwd
   LET g_patch_m.patch005 = "N"
   LET g_patch_m.patch007 = g_patch007_t
   LET g_patch_m.patch008 = g_patch008_t
   LET g_patch_m.patch009 = g_patch009_t
   
   CALL adzp999_01_show()

   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      DISPLAY "warning:adzp999_01_cp_pack.sadzi888_01_change_work_dir()" 
   END IF

   RETURN TRUE
END FUNCTION

#+ #取得所有patch資訊前置作業
PRIVATE FUNCTION adzp999_01_get_pack_list_pre()
   DEFINE l_pack_dir        STRING               #打包檔置放路徑
   DEFINE l_tar_name        STRING               #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_folder          STRING               #匯出檔目錄
   DEFINE l_cmd             STRING
   DEFINE l_result          BOOLEAN
   
   #切換路徑至patch包解包的所在路徑
   LET l_pack_dir = os.Path.dirname(g_patch_m.patch006)
   
   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN 
   END IF

   CALL adzp999_01_get_pack_name(g_patch_m.patch006)
      RETURNING l_result, l_tar_name, l_folder

   IF NOT l_result THEN
      RETURN
   END IF
   
   LET g_tmp_folder = l_folder
   
   #解包成tar檔範例:tar xvf $FOLDER.tar
   LET l_cmd = "tar xvf ", l_tar_name CLIPPED
   RUN l_cmd

   #切換到新目錄下,準備讀取匯入檔
   IF (NOT os.Path.EXISTS(l_folder)) OR (NOT os.Path.chdir(l_folder)) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL 
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_folder.trim()
      CALL cl_err()
      RETURN
   END IF

   IF NOT adzp999_01_get_pack_list() THEN
      DISPLAY "adzp999_01_get_pack_list() is error."
   END IF
   
   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      RETURN 
   END IF
END FUNCTION

#+ #取得所有patch資訊
PRIVATE FUNCTION adzp999_01_get_pack_list()
   DEFINE l_cmd             STRING
   DEFINE l_file            STRING
   DEFINE l_sql             STRING
   DEFINE l_cnt             LIKE type_t.num5

   #因採用temp table運作,所以每次先清空temp table裡的資料
   #刪除所有temp table內的資料
   DELETE FROM adzi888_master WHERE 1 = 1
   DELETE FROM adzi888_ddata WHERE 1 = 1
   DELETE FROM adzi888_dfile WHERE 1 = 1
   DELETE FROM adzi888_dtool WHERE 1 = 1
   DELETE FROM tmp_dzye_t WHERE 1 = 1       #因為這個tmp table是針對patch(或程式設計資料匯出入)運作時所需要的,因此命名與其他temp table不同
 
   #匯入[patch包主檔資訊]
   LET l_file = "Temp-", "adzi888_master.unl"
   LET l_sql = "INSERT INTO adzi888_master "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "LOAD FROM ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
      
   #匯入[設定/設計資料匯出清單]
   LET l_file = "Temp-", "adzi888_ddata.unl"
   LET l_sql = "INSERT INTO adzi888_ddata "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "LOAD FROM ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #匯入[檔案匯出清單]
   LET l_file = "Temp-", "adzi888_dfile.unl"
   LET l_sql = "INSERT INTO adzi888_dfile "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "LOAD FROM ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   #匯入[IT工具類匯出清單]
   LET l_file = "Temp-", "adzi888_dtool.unl"
   LET l_sql = "INSERT INTO adzi888_dtool "
   LOAD FROM l_file l_sql
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "LOAD FROM ", l_file.trim()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #匯入[程式(dzye_t)相關資訊]
   LET l_file = "Temp-", "dzye_t.unl"
   LET l_sql = "INSERT INTO tmp_dzye_t "

   IF os.Path.exists(l_file) THEN
      LOAD FROM l_file l_sql
   
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = "LOAD FROM ", l_file.trim()
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   ELSE
      DISPLAY l_file, " doesn't exist."
   END IF

   #先備份一些必要資訊
   LET g_patch_pwd = g_patch_m.patch004
   LET g_patch007_t = g_patch_m.patch007
   LET g_patch008_t = g_patch_m.patch008
   LET g_patch009_t = g_patch_m.patch009
    
   #清畫面欄位內容
   CLEAR FORM
   CALL g_ddata_d.clear()
   CALL g_dfile_d.clear()
   CALL g_dtool_d.clear()
   CALL g_detail4_d.clear()

   #取得[patch包主檔資訊]
   SELECT COUNT(*) INTO l_cnt FROM adzi888_master
   IF l_cnt <> 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00587"
      LET g_errparam.extend = "cnt"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   
   INITIALIZE g_patch_m TO NULL
   
   SELECT master001, master002
     INTO g_patch_m.patch001, g_patch_m.patch002
     FROM adzi888_master

   IF cl_null(g_patch_m.patch002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00587"
      LET g_errparam.extend = "patch001"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   #取得patch包路徑
   LET g_patch_m.patch003 = g_patch003_t
   LET g_patch_m.patch004 = g_patch_pwd
   LET g_patch_m.patch005 = "N"
   LET g_patch_m.patch006 = g_patch006_t
   LET g_patch_m.patch007 = g_patch007_t
   LET g_patch_m.patch008 = g_patch008_t
   LET g_patch_m.patch009 = g_patch009_t
   
   CALL adzp999_01_show()

   RETURN TRUE
END FUNCTION

#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzp999_01_show()
   DEFINE l_ac_t    LIKE type_t.num5

   CALL adzp999_01_b_fill() #單身填充
 
   LET l_ac_t = l_ac

   DISPLAY BY NAME g_patch_m.patch001, g_patch_m.patch002, g_patch_m.patch003, g_patch_m.patch004, g_patch_m.patch005,
                   g_patch_m.patch006, g_patch_m.patch007, g_patch_m.patch008, g_patch_m.patch009

   DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY

END FUNCTION

#+ 單身陣列填充
PRIVATE FUNCTION adzp999_01_b_fill()
   DEFINE p_wc2             STRING
   DEFINE l_gzza003         LIKE gzza_t.gzza003     #模組代碼
   DEFINE l_str             STRING
   DEFINE lo_DZAF_T         T_DZAF_T
   DEFINE ls_err_msg        STRING
   DEFINE l_dzye_d          type_g_dzye_d           #設計資料執行結果記錄表 
   DEFINE l_cnt             LIKE type_t.num5

   CALL g_ddata_d.clear()
   CALL g_dfile_d.clear()
   CALL g_dtool_d.clear()
   CALL g_detail4_d.clear()

   #設定/設計資料匯出清單
   LET g_sql = "SELECT ddata002, ddata003, ddata004, ddata005, ddata006, ", 
               "       ddata007, ddata008, ddata009, ddata010, ddata015 ",
               "  FROM adzi888_ddata ",
               "  WHERE ddata001 = ? "

   LET g_sql = g_sql, " ORDER BY ddata002"
   
   PREPARE adzp999_01_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR adzp999_01_pb
   
   LET g_cnt = l_ac
   LET l_ac = 1
      
   OPEN b_fill_cs USING g_patch_m.patch001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "OPEN b_fill_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
 
   FOREACH b_fill_cs INTO g_ddata_d[l_ac].ddata002, g_ddata_d[l_ac].ddata003, g_ddata_d[l_ac].ddata004, g_ddata_d[l_ac].ddata005, g_ddata_d[l_ac].ddata006,
                          g_ddata_d[l_ac].ddata007, g_ddata_d[l_ac].ddata008, g_ddata_d[l_ac].ddata009, g_ddata_d[l_ac].ddata010, g_ddata_d[l_ac].ddata015 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH b_fill_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      LET l_ac = l_ac + 1      
   END FOREACH
   
   LET g_error_show = 0


   #檔案匯出清單
   LET g_sql = "SELECT dfile002, dfile003, dfile004, dfile005, dfile006, dfile007 ", 
               "  FROM adzi888_dfile ",
               "  WHERE dfile001 = ? "   
   
   LET g_sql = g_sql, " ORDER BY dfile002"
   
   PREPARE adzp999_01_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR adzp999_01_pb2
   
   LET l_ac = 1
   
   OPEN b_fill_cs2 USING g_patch_m.patch001
 

   FOREACH b_fill_cs2 INTO g_dfile_d[l_ac].dfile002, g_dfile_d[l_ac].dfile003, g_dfile_d[l_ac].dfile004, g_dfile_d[l_ac].dfile005, g_dfile_d[l_ac].dfile006, 
                           g_dfile_d[l_ac].dfile007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH b_fill_cs2:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1      
   END FOREACH

   
   #IT工具類匯出清單
   LET g_sql = "SELECT dtool002, dtool003, dtool004, dtool005, dtool006, ",
               "       dtool007, dtool008, dtool009", 
               "  FROM adzi888_dtool ", 
               "  WHERE dtool001 = ? ",
               "  ORDER BY dtool002"
   
   PREPARE adzp999_01_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR adzp999_01_pb3
   
   LET l_ac = 1
   
   OPEN b_fill_cs3 USING g_patch_m.patch001

   FOREACH b_fill_cs3 INTO g_dtool_d[l_ac].dtool002, g_dtool_d[l_ac].dtool003, g_dtool_d[l_ac].dtool004, g_dtool_d[l_ac].dtool005, g_dtool_d[l_ac].dtool006, 
                           g_dtool_d[l_ac].dtool007, g_dtool_d[l_ac].dtool008, g_dtool_d[l_ac].dtool009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH b_fill_cs3:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH

   
   #patch程式(dzye_t)清單
   LET g_sql = "SELECT dzye001, dzye002, dzye003, dzye004, dzye005, ",
               "       dzye006, dzye007, dzye008, dzye009, dzye010, ", 
               "       dzye011, dzye012, dzye013, dzye014, dzye015, ", 
               "       dzye016, dzye017, dzye018, dzye019, dzye020, ", 
               "       dzye021, dzye022, dzye023, dzye024 ", 
               "  FROM tmp_dzye_t ", 
               "  WHERE dzye001 = ? ",
               "  ORDER BY dzye002"
   
   PREPARE adzp999_01_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR adzp999_01_pb4
   
   LET l_ac = 1
   
   OPEN b_fill_cs4 USING g_patch_m.patch002

   FOREACH b_fill_cs4 INTO g_detail4_d[l_ac].dzye001, g_detail4_d[l_ac].dzye002, g_detail4_d[l_ac].dzye003, g_detail4_d[l_ac].dzye004, g_detail4_d[l_ac].dzye005,
                           g_detail4_d[l_ac].dzye006, g_detail4_d[l_ac].dzye007, g_detail4_d[l_ac].dzye008, g_detail4_d[l_ac].dzye009, g_detail4_d[l_ac].dzye010,
                           g_detail4_d[l_ac].dzye011, g_detail4_d[l_ac].dzye012, g_detail4_d[l_ac].dzye013, g_detail4_d[l_ac].dzye014, g_detail4_d[l_ac].dzye015,
                           g_detail4_d[l_ac].dzye016, g_detail4_d[l_ac].dzye017, g_detail4_d[l_ac].dzye018, g_detail4_d[l_ac].dzye019, g_detail4_d[l_ac].dzye020,
                           g_detail4_d[l_ac].dzye021, g_detail4_d[l_ac].dzye022, g_detail4_d[l_ac].dzye023, g_detail4_d[l_ac].dzye024 
                           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH b_fill_cs4:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #完成patch後,只依目前tmp_dzye_t內資訊為主
      IF g_finish_flag THEN
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      
      #取得程式代碼匯入端所屬模組
      CALL sadzp062_1_find_module(g_detail4_d[l_ac].dzye002, g_detail4_d[l_ac].dzye003) 
         RETURNING l_gzza003
      
      IF cl_null(l_gzza003) THEN
         DISPLAY "   warning-", g_detail4_d[l_ac].dzye002 CLIPPED, ".", g_detail4_d[l_ac].dzye003 CLIPPED, ":", cl_getmsg("adz-00012", g_lang)
      END IF

      #取得程式碼版次及客製標示識別
      CALL sadzp060_2_get_curr_ver_info(g_detail4_d[l_ac].dzye002, g_detail4_d[l_ac].dzye003, NULL)
         RETURNING lo_DZAF_T.*, ls_err_msg

      IF NOT cl_null(ls_err_msg) THEN
         #todo:標準產品所patch出的"新程式",在匯入目的端還沒有任何版次資料(因為此時還沒有倒入任何設定和設計資料)
         LET l_str = "    ", "warning-", g_detail4_d[l_ac].dzye002 CLIPPED, ".", g_detail4_d[l_ac].dzye003 CLIPPED, ":", cl_getmsg_parm("adz-00303", g_lang, g_detail4_d[l_ac].dzye002), ". ", ls_err_msg.trim()
         DISPLAY l_str

         #取不到版次資料,也取不到模組資料時,認定為標準新程式
         IF cl_null(l_gzza003) THEN
            LET l_dzye_d.dzye005 = ""
            LET l_dzye_d.dzye006 = ""
            LET l_dzye_d.dzye009 = ""
            LET l_dzye_d.dzye010 = ""
            LET l_dzye_d.dzye011 = ""
            LET l_dzye_d.dzye012 = "s"
            LET l_dzye_d.dzye015 = ""   #預設不需做Merge(標準程式)
            LET l_dzye_d.dzye022 = "N"
            LET l_dzye_d.dzye023 = "0" 
         END IF
      ELSE
         #取得匯入端程式相關資訊至dzye_t表中
         LET l_dzye_d.dzye005 = l_gzza003 CLIPPED
         LET l_dzye_d.dzye006 = ""
         LET l_dzye_d.dzye009 = lo_DZAF_T.dzaf002 CLIPPED
         LET l_dzye_d.dzye010 = lo_DZAF_T.dzaf003 CLIPPED
         LET l_dzye_d.dzye011 = lo_DZAF_T.dzaf004 CLIPPED
         LET l_dzye_d.dzye012 = lo_DZAF_T.dzaf010 CLIPPED
         LET l_dzye_d.dzye015 = ""   #預設不需做Merge(標準程式)
         LET l_dzye_d.dzye023 = "0" 

         #建構類型為是(M:主程式, S:子程式, F:子畫面, Z:服務, W:服務元件),才提供客制Merge選擇功能
         #LET l_dzye_d.dzye001 = ""
         IF l_dzye_d.dzye012 = "c" THEN
            #2016/12/14
            #LET l_dzye_d.dzye015 = "Y"
            #G,X類不進行merge
            IF g_detail4_d[l_ac].dzye003 = "G" OR
               g_detail4_d[l_ac].dzye003 = "X" THEN
               LET l_dzye_d.dzye015 = ""
            ELSE
               LET l_dzye_d.dzye015 = "Y"
            END IF
            #2016/12/14
            #IF g_detail4_d[l_ac].dzye003 = "M" OR g_detail4_d[l_ac].dzye003 = "S" OR g_detail4_d[l_ac].dzye003 = "F" OR 
            #   g_detail4_d[l_ac].dzye003 = "W" OR  g_detail4_d[l_ac].dzye003 = "Z" THEN

            #   LET l_dzye_d.dzye015 = "Y"
            #END IF
            
            #2016/09/22
            #預設不勾選merge
            #2016/10/31
            #IF g_detail4_d[l_ac].dzye003 = "M" OR 
            #   g_detail4_d[l_ac].dzye003 = "S" OR 
            #   g_detail4_d[l_ac].dzye003 = "F" OR 
            #   g_detail4_d[l_ac].dzye003 = "W" OR  
            #   g_detail4_d[l_ac].dzye003 = "Z" THEN
            #   LET l_dzye_d.dzye015 = "N"
            #END IF
            #2016/10/31
            #2016/09/22
            
            #2016/12/29
            IF (g_detail4_d[l_ac].dzye003 = "M"  OR 
                g_detail4_d[l_ac].dzye003 = "S"  OR 
                g_detail4_d[l_ac].dzye003 = "F"  OR 
                g_detail4_d[l_ac].dzye003 = "W"  OR  
                g_detail4_d[l_ac].dzye003 = "Z") AND 
                g_merge = "N" THEN
               LET l_dzye_d.dzye015 = "N"
            END IF
            #2016/12/29
            
         END IF
         
         #取得程式簽出資訊(無論規格或代碼簽出都視為簽出)
         LET l_dzye_d.dzye022 = "N"
        
         SELECT COUNT(*) INTO l_cnt FROM dzlm_t
           WHERE dzlm002 = g_detail4_d[l_ac].dzye002
             AND (dzlm008 = 'O' OR dzlm011 = 'O')

         IF SQLCA.sqlcode THEN
            LET l_str = "    ", "ERROR sel dzlm_t-", g_detail4_d[l_ac].dzye002 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
            DISPLAY l_str
         END IF
      
         IF l_cnt > 0 THEN
            LET l_dzye_d.dzye022 = "Y"
         END IF
         
         #2016/11/30
         IF l_dzye_d.dzye012 = "c" AND #目的程式為客製
            l_dzye_d.dzye022 = "Y" AND #目的程式為簽出
            (g_detail4_d[l_ac].dzye003 = "M" OR #非元件類型
             g_detail4_d[l_ac].dzye003 = "S" OR 
             g_detail4_d[l_ac].dzye003 = "F" OR 
             g_detail4_d[l_ac].dzye003 = "W" OR  
             g_detail4_d[l_ac].dzye003 = "Z") THEN
            LET l_dzye_d.dzye015 = "N" 
         END IF
         #2016/11/30
         
      END IF
      
      UPDATE tmp_dzye_t SET (dzye005, dzye006, dzye009, dzye010, dzye011, 
                             dzye012, dzye015, dzye022, dzye023) = 
                            (l_dzye_d.dzye005, l_dzye_d.dzye006, l_dzye_d.dzye009, l_dzye_d.dzye010, l_dzye_d.dzye011, 
                             l_dzye_d.dzye012, l_dzye_d.dzye015, l_dzye_d.dzye022, l_dzye_d.dzye023)
        WHERE dzye001 = g_detail4_d[l_ac].dzye001
          AND dzye002 = g_detail4_d[l_ac].dzye002

      IF SQLCA.sqlcode THEN
         LET l_str = "    ", "ERROR upd tmp_dzye_t-", g_detail4_d[l_ac].dzye002 CLIPPED, ":", cl_getmsg(SQLCA.sqlcode, g_lang)
         DISPLAY l_str
      ELSE
         LET g_detail4_d[l_ac].dzye005 = l_dzye_d.dzye005 CLIPPED
         LET g_detail4_d[l_ac].dzye006 = l_dzye_d.dzye006 CLIPPED
         LET g_detail4_d[l_ac].dzye009 = l_dzye_d.dzye009 CLIPPED
         LET g_detail4_d[l_ac].dzye010 = l_dzye_d.dzye010 CLIPPED
         LET g_detail4_d[l_ac].dzye011 = l_dzye_d.dzye011 CLIPPED
         LET g_detail4_d[l_ac].dzye012 = l_dzye_d.dzye012 CLIPPED
         LET g_detail4_d[l_ac].dzye015 = l_dzye_d.dzye015 CLIPPED
         LET g_detail4_d[l_ac].dzye022 = l_dzye_d.dzye022 CLIPPED
         LET g_detail4_d[l_ac].dzye023 = l_dzye_d.dzye023 CLIPPED
      END IF

      LET l_ac = l_ac + 1
   END FOREACH

   IF g_ddata_d.getLength() > 0 THEN
      CALL g_ddata_d.deleteElement(g_ddata_d.getLength())
   END IF

   IF g_dfile_d.getLength() > 0 THEN
      CALL g_dfile_d.deleteElement(g_dfile_d.getLength())
   END IF

   IF g_dtool_d.getLength() > 0 THEN
      CALL g_dtool_d.deleteElement(g_dtool_d.getLength())
   END IF

   IF g_detail4_d.getLength() > 0 THEN
      CALL g_detail4_d.deleteElement(g_detail4_d.getLength())
   END IF

   LET l_ac = g_cnt
   LET g_cnt = 0
   
   FREE adzp999_01_pb
   FREE adzp999_01_pb2
   FREE adzp999_01_pb3
   FREE adzp999_01_pb4

END FUNCTION

#+ 取得程式(dzye_t)相關資訊前置作業
PUBLIC FUNCTION adzp999_01_exp_get_dzye_pre(p_master002)
   DEFINE p_master002       LIKE type_t.chr50

   DEFINE l_cnt_ddata       LIKE type_t.num5
   DEFINE l_errcode         STRING
   
   SELECT COUNT(*) INTO l_cnt_ddata FROM adzi888_ddata WHERE ddata005 = 'design_data'

   IF l_cnt_ddata = 0 THEN
      DISPLAY "design_data of ", p_master002 CLIPPED, " num is 0."
      RETURN TRUE
   END IF

   ##建立dzye_t的temp table
   #SELECT * FROM dzye_t WHERE 1 = 2 INTO TEMP tmp_dzye_t 
   
   #IF SQLCA.sqlcode THEN
   #   LET l_errcode = SQLCA.sqlcode
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = "create tmp dzye_t:"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET g_error_message = "BREAK_ERROR-create tmp dzye_t:", cl_getmsg(l_errcode, g_lang)
   #   CALL sadzi888_01_log_file_write(g_error_message)
   #   RETURN FALSE
   #END IF

   IF NOT adzp999_01_exp_get_dzye(p_master002) THEN
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 取得程式(dzye_t)相關資訊
PRIVATE FUNCTION adzp999_01_exp_get_dzye(p_master002)
   DEFINE p_master002       LIKE type_t.chr50
   
   DEFINE l_sql             STRING
   DEFINE l_ddata006        LIKE dzld_t.dzld006
   DEFINE l_errcode         STRING
   DEFINE l_dzfq005         LIKE dzfq_t.dzfq005     #建構類型
   DEFINE l_str             STRING
   DEFINE lo_DZAF_T         T_DZAF_T
   DEFINE ls_err_msg        STRING
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_dzye_d          type_g_dzye_d           #設計資料執行結果記錄表 
   DEFINE l_cnt_ddata       LIKE type_t.num5
   DEFINE l_cnt_dzye        LIKE type_t.num5
   DEFINE l_module          STRING                  #160223-00028

   LET l_success = TRUE

   LET l_sql = "SELECT ddata006 FROM adzi888_ddata ",
               "  WHERE ddata005 = 'design_data' ", 
               "  ORDER BY ddata002 "

   DECLARE adzp999_01_exp_dzye_cs CURSOR FROM l_sql
   
   FOREACH adzp999_01_exp_dzye_cs INTO l_ddata006
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH adzp999_01_exp_dzye_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-FOREACH adzp999_01_exp_dzye_cs:", cl_getmsg(l_errcode, g_lang)
         DISPLAY g_error_message
         CALL sadzi888_01_log_file_write(g_error_message)
         RETURN FALSE
      END IF

      INITIALIZE l_dzye_d TO NULL
      
      #取得畫面所屬類別(M:主程式畫面, S:子程式畫面, F:子畫面)
      LET l_dzfq005 = sadzp060_2_chk_spec_type(l_ddata006)

      #取得程式碼版次及客製標示識別
      CALL sadzp060_2_get_curr_ver_info(l_ddata006, l_dzfq005, NULL)
         RETURNING lo_DZAF_T.*, ls_err_msg

      IF NOT cl_null(ls_err_msg) THEN
         LET l_str = "    ", "ERROR-", l_ddata006 CLIPPED, ".", l_dzfq005 CLIPPED, ":", cl_getmsg_parm("adz-00303", g_lang, l_ddata006), ". ", ls_err_msg.trim()
         DISPLAY l_str
         CALL sadzi888_01_log_file_write(l_str)
         LET l_success = FALSE
         #CONTINUE FOREACH
      END IF

      #Begin: 160223-00028
      #取得程式碼模組:目的是健全dzye資訊，以供後續打包source時用                                                                                          
      LET l_module = sadzp062_1_find_module(l_ddata006, l_dzfq005)
      IF cl_null(l_module) THEN
         LET l_str = "    ", "ERROR-", l_ddata006 CLIPPED, ".", l_dzfq005 CLIPPED, ":", cl_getmsg_parm("adz-00012", g_lang, l_ddata006), ". ", ls_err_msg.trim()
         DISPLAY l_str
         CALL sadzi888_01_log_file_write(l_str)
         LET l_success = FALSE
      END IF
      #End: 160223-00028

      #新增程式相關資訊至dzye_t表中
      LET l_dzye_d.dzye001 = p_master002 CLIPPED
      LET l_dzye_d.dzye002 = l_ddata006 CLIPPED
      LET l_dzye_d.dzye003 = l_dzfq005 CLIPPED
      LET l_dzye_d.dzye014 = lo_DZAF_T.dzaf002 CLIPPED     #來源建構版號
      LET l_dzye_d.dzye019 = lo_DZAF_T.dzaf010 CLIPPED     #來源程式識別標示
      LET l_dzye_d.dzye020 = lo_DZAF_T.dzaf003 CLIPPED     #來源規格版號
      LET l_dzye_d.dzye021 = lo_DZAF_T.dzaf004 CLIPPED     #來源代碼版號
     #Begin: 160223-00028 modify
     #INSERT INTO tmp_dzye_t(dzye001, dzye002, dzye003, dzye014, dzye019, 
     #                       dzye020, dzye021)
     #  VALUES (l_dzye_d.dzye001, l_dzye_d.dzye002, l_dzye_d.dzye003, l_dzye_d.dzye014, l_dzye_d.dzye019, 
     #          l_dzye_d.dzye020, l_dzye_d.dzye021)
      LET l_dzye_d.dzye005 = l_module CLIPPED
      INSERT INTO tmp_dzye_t(dzye001, dzye002, dzye003, dzye005, dzye014, dzye019, 
                             dzye020, dzye021)
        VALUES (l_dzye_d.dzye001, l_dzye_d.dzye002, l_dzye_d.dzye003, l_dzye_d.dzye005, l_dzye_d.dzye014, l_dzye_d.dzye019, 
                l_dzye_d.dzye020, l_dzye_d.dzye021)
     #End: 160223-00028 modify
        
      IF SQLCA.sqlcode THEN
         LET l_errcode = SQLCA.sqlcode
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins tmp_dzye_t:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_error_message = "ERROR-ins tmp_dzye_t.", l_dzye_d.dzye002 CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
         CALL sadzi888_01_log_file_write(g_error_message)
         DISPLAY g_error_message
         LET l_success = FALSE
      END IF  
   END FOREACH

   SELECT COUNT(*) INTO l_cnt_ddata FROM adzi888_ddata WHERE ddata005 = 'design_data'
   DISPLAY "design_data cnt:", l_cnt_ddata

   SELECT COUNT(*) INTO l_cnt_dzye FROM tmp_dzye_t
   DISPLAY "tmp_dzye_t cnt:", l_cnt_dzye

   IF l_cnt_ddata <> l_cnt_dzye THEN
      LET g_error_message = "ERROR:ddata_cnt <> dzye_cnt"
      LET l_success = FALSE
   END IF
   
   IF NOT l_success THEN
     DISPLAY "BREAK_ERROR-UNLOAD dzye_t is error."
     RETURN FALSE
   END IF

   #將tmp_dzye_t資訊UNLOAD file
   UNLOAD TO "Temp-dzye_t.unl" "SELECT * FROM tmp_dzye_t" 
   
   IF STATUS THEN
      LET l_errcode = STATUS
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = STATUS
      LET g_errparam.extend = "UNLOAD TO dzye_t.unl"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "BREAK_ERROR-UNLOAD TO dzye_t.unl:", cl_getmsg(l_errcode, g_lang)
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#+ DB測試連結
PRIVATE FUNCTION adzp999_01_test_connect(p_gzda001, p_gzda003, p_gzda004)
   DEFINE p_gzda001         LIKE gzda_t.gzda001
   DEFINE p_gzda003         LIKE gzda_t.gzda003
   DEFINE p_gzda004         LIKE gzda_t.gzda004

   DEFINE l_gzda006         LIKE gzda_t.gzda006
   DEFINE l_gzda007         LIKE gzda_t.gzda007
   DEFINE l_db              STRING

   RETURN TRUE
   
   SELECT gzda006, gzda007 INTO l_gzda006, l_gzda007 FROM gzda_t
     WHERE gzda001 = 'ds'

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel gzda_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   IF cl_null(l_gzda006) OR cl_null(l_gzda007) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00593"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   LET p_gzda004 = cl_hashkey_base64_encode(p_gzda004)
   
   IF NOT cl_db_test_connect(p_gzda001, p_gzda003, p_gzda004, l_gzda006, l_gzda007) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00594"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_gzda001 CLIPPED
      CALL cl_err()
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION



#+ patch包匯入前置作業
PRIVATE FUNCTION adzp999_01_import_patch_pre()
   DEFINE l_pack_dir        STRING               #打包檔置放路徑
   DEFINE l_cmd             STRING
   DEFINE l_result          BOOLEAN
   DEFINE l_error_message   STRING
   DEFINE l_folder          STRING               #匯出檔目錄
   DEFINE l_tar_name        STRING               #匯出包名稱
   DEFINE l_cnt             LIKE type_t.num5
   #2016/03/07
   DEFINE lb_sadzp640       BOOLEAN
   DEFINE ls_sadzp640       STRING
   #2016/03/07
   
   IF g_patch_m.patch001 IS NULL OR g_patch_m.patch002 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   #檢查是否重複執行patch包匯入
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM dzye_t WHERE dzye001 = g_patch_m.patch002

   IF l_cnt > 0 THEN
      #2017/02/13
      IF g_bgjob = "N" THEN
         IF NOT cl_ask_confirm_parm("adz-00601", g_patch_m.patch002) THEN
            RETURN
         END IF 
      END IF
      #2017/02/13

      #刪除已保存的patch記錄(dzye_t)
      DELETE FROM dzye_t WHERE dzye001 = g_patch_m.patch002
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del dzye_t:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END IF
   
   #2016/09/22
   #開啟進度列
   #OPEN WINDOW w_adzp999_01_s01 WITH FORM cl_ap_formpath("adz", "adzp999_01_s01")
   #   ATTRIBUTE(STYLE = "openwin")
      
   #初始進度為0
   #LET g_adzp999_01_s01 = TRUE
   #LET g_curr_tasks = 0
   #DISPLAY g_curr_tasks TO FORMONLY.progs01
   #DISPLAY g_curr_tasks TO FORMONLY.dummy01
   #CALL ui.Interface.refresh()
   #2016/09/22


            
   #切換路徑至patch包解包的所在路徑
   LET l_pack_dir = os.Path.dirname(g_patch_m.patch006)

   IF NOT sadzi888_01_change_pack_dir(l_pack_dir) THEN
      RETURN 
   END IF

   CALL adzp999_01_get_pack_name(g_patch_m.patch006)
      RETURNING l_result, l_tar_name, l_folder

   IF NOT l_result THEN
      RETURN
   END IF
   
   #檢查目錄是否存在,準備讀取匯入檔
   #IF (NOT os.Path.EXISTS(l_folder)) OR (NOT os.Path.chdir(l_folder)) THEN
   IF NOT os.Path.EXISTS(l_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL 
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_folder.trim()
      CALL cl_err()
      RETURN
   END IF

   LET g_batch_flag = TRUE
   LET g_patch_mode = TRUE
   LET g_unload_file = FALSE     #是否在export data過程中UNLOAD TO FILE
   
   #是否先import dspatch dmp檔
   LET g_import_dapatch = ""

   #2016/09/22
   #進度列控制
   #IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
   #   CALL adzp999_01_refresh_tasks_progressbar(gc_empty_dspatch, "adz-00605")
   #   CALL adzp999_01_refresh_sub_tasks_progressbar(1, 2)
   #END IF
   #2016/09/22
      
   #只有當g_import_dapatch="N"時,才不做import dspatch的動作
   #2016/02/22 by ka0132
   #IF g_batch_flag AND (cl_null(g_import_dapatch) OR g_import_dapatch <> "N") THEN
   #   #先清空dspatch的所有table
   #   LET l_cmd = "emptydspatch.sh Y "
   #   DISPLAY l_cmd
   #   RUN l_cmd
   #
   #   IF STATUS THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = STATUS
   #      LET g_errparam.extend = "emptydspatch:"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #      RETURN
   #   END IF
   #
   #   #進度列控制
   #   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
   #      CALL adzp999_01_refresh_sub_tasks_progressbar(2, 2)
   #   END IF
   #
   #END IF
   #2016/02/22 by ka0132

   #執行patch包匯入
   CALL adzp999_01_import_patch(l_pack_dir, l_folder)
      RETURNING l_result, l_error_message
      
   IF l_result THEN
      DISPLAY "patch_import_success."
      DISPLAY "adzp999 success."
      #2016/03/07
      #呼叫hiko提供sadzp060_4_batch_ins_dzaq_t
      IF FGL_GETENV("DGENV")="s" AND  
         FGL_GETENV("TOPIND") IS NOT NULL AND 
         FGL_GETENV("TOPIND") <> "sd" THEN
         DISPLAY "INFO:判定為行業別主機!"
         CALL sadzp060_4_batch_ins_dzaq_t(g_patch_m.patch002)
         RETURNING lb_sadzp640,ls_sadzp640
         CALL cl_cmdrun('adzp640')
      END IF
      #2016/03/07
   ELSE
      DISPLAY "adzp999 BREAK_ERROR:", l_error_message
   END IF

   #已完成patch,重新取得patch後資訊
   LET g_finish_flag = TRUE
   DELETE FROM tmp_dzye_t WHERE 1 = 1
   INSERT INTO tmp_dzye_t SELECT * FROM dzye_t WHERE dzye001 = g_patch_m.patch002

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT TEMP tmp_dzye_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   #CALL adzp999_01_show()
   
   #切換回正確程式執行路徑
   IF NOT sadzi888_01_change_work_dir() THEN
      DISPLAY "warning:adzp999_01_import_patch_pre.sadzi888_01_change_work_dir() failed." 
   END IF
   
   #2016/12/30
   #若為例行(月)包才進行多語言打包
   IF l_folder.getIndexOf('TSD-3',1) > 0 THEN
      LET l_cmd = "unpack_lang ", os.Path.join(l_pack_dir.trim(), l_folder.trim())
      DISPLAY l_cmd
      CALL sadzi888_01_log_file_write(l_cmd)
      RUN l_cmd
   END IF
   #2016/12/30
   
   #刪除目錄
   LET l_cmd = os.Path.join(l_pack_dir.trim(), l_folder.trim())
   IF os.Path.EXISTS(l_cmd) THEN
      LET l_cmd = "rm -rf ", l_cmd
      RUN l_cmd
   END IF
   
   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_tasks_progressbar(gc_gen_final_patch, "adz-00615")
   END IF
   
   #2016/10/21
   LET g_finish_time = cl_get_current() 
   DISPLAY "Patch起始時間:",g_start_time
   DISPLAY "Patch結束時間:",g_finish_time
   DISPLAY "Patch花費時間:",g_finish_time - g_start_time
   #2017/02/13
   UPDATE dzyg_t 
      SET dzyg006 = "Y", 
          dzyg022 = g_start_time, 
          dzyg023 = g_finish_time
    WHERE dzyg001 = g_patch_m.patch002
   IF g_bgjob = "N" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00900"
      LET g_errparam.type = 2
      LET g_errparam.replace[1] = g_finish_time - g_start_time
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   #2017/02/13
   #2016/10/21

   CALL cl_ask_pressanykey("adz-00615")
END FUNCTION

#+ patch包匯入作業
PRIVATE FUNCTION adzp999_01_import_patch(p_pack_dir, p_folder)
   DEFINE p_pack_dir        STRING               #打包檔置放路徑
   DEFINE p_folder          STRING               #匯出檔目錄
   
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_str             STRING
   DEFINE l_success         LIKE type_t.chr1 
   DEFINE l_cmd             STRING
   DEFINE l_temp            STRING
   
   LET g_show_msg = "Y"     #前景UI模式操作
   LET g_gen42s_flag = TRUE
   LET g_patch_pwd = g_patch_m.patch004
   LET g_patch007_t = g_patch_m.patch007
   LET g_patch008_t = g_patch_m.patch008
   LET g_patch009_t = g_patch_m.patch009
   
   #patch模式下,一律不做產生42s動作
   IF g_patch_mode AND (g_patch_m.patch007 = "N") THEN
      LET g_gen42s_flag = FALSE
   END IF
   
   CALL sadzi888_01_init()

   #LET g_bgjob = "N" #2017/02/13
   
   #開始記錄匯入log
   CALL sadzi888_01_log_file_start(g_run_mode, g_patch_m.patch002)

   #[設定資訊]+[設計資料]匯入作業(含進行Merge程序)
   IF cl_null(g_patch_m.patch005) OR g_patch_m.patch005 != "Y" THEN
      IF NOT sadzi888_01_import(g_patch_m.patch001, "", "", p_pack_dir, p_folder) THEN
         DISPLAY "sadzi888_01_import is error."
         RETURN FALSE, g_error_message
      END IF

     #Begin: 160223-00028 註解段落
     ##[qry link]
     #SELECT COUNT(*) INTO l_cnt FROM adzi888_ddata
     #  WHERE ddata005 = 'adzi210'
     #  
     #IF l_cnt > 0 THEN
     #   DISPLAY "adzp999_01.s_azzi070_gen_qry() is start."
     #   LET l_str = "s_azzi070_gen_qry start:", cl_get_current(), ASCII 10
     #   CALL sadzi888_01_log_file_write(l_str)
     #
     #   CALL s_azzi070_gen_qry()
     #
     #   LET l_str = "s_azzi070_gen_qry end:", cl_get_current(), ASCII 10
     #   CALL sadzi888_01_log_file_write(l_str)
     #END IF
     #End: 160223-00028 註解段落
    
   END IF

   #進行4fd/4gl 組合及產生
   DISPLAY "sadzi888_01.sadzi888_06_after_imp() is start."
   LET l_str = "sadzi888_06_after_imp start:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)

   CALL sadzi888_06_after_imp(g_run_mode) 
      RETURNING l_success, g_error_message

   LET l_str = "sadzi888_06_after_imp end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   DISPLAY "sadzi888_01.sadzi888_06_after_imp() is end."

   #執行組合程式失敗時,將失敗原因寫入log檔中
   IF NOT l_success THEN
      DISPLAY "after_imp error:", g_error_message
   ELSE
      DISPLAY "after_imp success:", g_error_message
   END IF
   
   CALL sadzi888_01_log_file_write(g_error_message) 


   SELECT COUNT(*) INTO l_cnt FROM tmp_dzye_t
   DISPLAY "tmp_dzye_t cut:", l_cnt

   SELECT COUNT(*) INTO l_cnt FROM dzyd_t WHERE dzyd001 = g_patch_m.patch002
   DISPLAY "dzyd_t cut:", l_cnt
   
   #todo:為了測試程式,暫時先塞入dzye_t的資料
   #INSERT INTO dzye_t SELECT * FROM tmp_dzye_t
   INSERT INTO dzye_t SELECT dzye001, dzye002, dzye003, dzyd004, dzye005, 
                             dzyd006, dzyd007, dzyd008, dzye009, dzye010,  
                             dzye011, dzye012, dzyd013, dzye014, dzye015,  
                             dzyd016, TO_DATE(dzyd017,'YYYY-MM-DD HH24:MI:SS'), dzyd018, dzye019, dzye020,  
                             dzye021, dzye022, dzye023, dzye024
                        FROM tmp_dzye_t LEFT JOIN dzyd_t ON dzye001 = dzyd001 AND dzye002 = dzyd002
                        WHERE dzye001 = g_patch_m.patch002


   
   
   #整批處理程式相關檔案產生
   DISPLAY "sadzi888_01.generator_program(FALSE) is start."
   LET l_str = "generator_program start:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)

   #進度列控制
   IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
      CALL adzp999_01_refresh_tasks_progressbar(gc_gen_final_prog, "adz-00614")
   END IF

   IF NOT sadzi888_01_generator_program_batch(g_patch_m.patch001, FALSE) THEN
      DISPLAY "sadzi888_01_generator_program_batch is error."
   END IF
   
   LET l_str = "generator_program end:", cl_get_current(), ASCII 10
   CALL sadzi888_01_log_file_write(l_str)
   DISPLAY "sadzi888_01.generator_program(FALSE) is end."

   ####解包成功後,從Server端刪除相關檔案
   ###IF NOT sadzi888_01_change_work_dir() THEN
   ###   RETURN FALSE, g_error_message
   ###END IF

   ####刪除目錄
   ###LET l_temp = os.Path.join(p_pack_dir.trim(), p_folder.trim())
   ###IF os.Path.EXISTS(l_temp) THEN
   ###   LET l_cmd = "rm -rf ", l_temp
   ###   RUN l_cmd
   ###END IF

   #結束記錄log
   CALL sadzi888_01_log_file_end()

   ####失敗時,一樣切換回正確程式執行路徑
   IF NOT l_success THEN
   ###   #為避免g_error_message受到change dir的影響,因此先記錄起來真正錯誤訊息內容
   ###   LET l_str = g_error_message
   ###   IF NOT sadzi888_01_change_work_dir() THEN
   ###      LET g_error_message = l_str
   ###   END IF
      
      RETURN FALSE, g_error_message
   END IF

   ####切換回正確程式執行路徑
   ###IF NOT sadzi888_01_change_work_dir() THEN
   ###   RETURN FALSE, g_error_message
   ###END IF
 
   LET g_error_message = ""
   
   RETURN TRUE, ""
END FUNCTION


#+ 取得patch包檔案名稱和解包時的目錄名稱
PRIVATE FUNCTION adzp999_01_get_pack_name(p_pack)
   DEFINE p_pack            STRING               #patch包路徑
   
   DEFINE l_folder          STRING               #匯出檔目錄
   DEFINE l_tar_name        STRING               #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5

   LET l_tar_name = ""
   LET l_folder = ""
   
   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(p_pack)
   
   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tgz", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF

   IF cl_null(l_tar_name) OR cl_null(l_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00331"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_tar_name.trim()
      CALL cl_err()
      RETURN FALSE, l_tar_name, l_folder
   END IF

   RETURN TRUE, l_tar_name, l_folder
END FUNCTION

PUBLIC FUNCTION adzp999_01_refresh_tasks_progressbar(p_progs01, p_gzze001)
   DEFINE p_progs01         LIKE type_t.num5
   DEFINE p_gzze001         LIKE gzze_t.gzze001
   DEFINE l_gzze003         LIKE gzze_t.gzze003
   
   LET l_gzze003 = cl_getmsg(p_gzze001, g_lang)
   
   #2017/02/13
   IF g_bgjob = "Y" THEN
      #背景解包模式
      DISPLAY "INFO:目前步驟為",l_gzze003,"(",p_progs01 USING "<<<","/",g_all_main_tasks USING "<<<",")"
      RETURN
   END IF
   #2017/02/13

  IF p_progs01 <> 0 THEN 
     DISPLAY (p_progs01 * 100 / g_all_main_tasks) USING "###&" TO FORMONLY.progs01
     DISPLAY (p_progs01 * 100 / g_all_main_tasks) USING "##&.&&%" TO FORMONLY.dummy01
     DISPLAY l_gzze003 TO FORMONLY.lbl_main_message
  END IF 

  CALL ui.Interface.refresh()
END FUNCTION

PUBLIC FUNCTION adzp999_01_refresh_sub_tasks_progressbar(p_prog_num, p_prog_cnt)
   DEFINE p_prog_num        LIKE type_t.num5
   DEFINE p_prog_cnt        LIKE type_t.num5
   
   #2017/02/13
   IF g_bgjob = "Y" THEN
      RETURN
   END IF
   #2017/02/13
   
  IF p_prog_num <> 0 THEN 
     DISPLAY (p_prog_num * 100 / p_prog_cnt) USING "###&" TO FORMONLY.progs02
     DISPLAY p_prog_num TO FORMONLY.lbl_prog_num
     DISPLAY p_prog_cnt TO FORMONLY.lbl_prog_cnt
  END IF 

  CALL ui.Interface.refresh()
END FUNCTION

#2016/06/28
FUNCTION adzp999_01_chk_routine_num(ps_patch_num,ps_pop)
   DEFINE ps_patch_num      STRING
   DEFINE ps_pop            BOOLEAN
   DEFINE ls_patch_info     DYNAMIC ARRAY OF STRING
   DEFINE ls_token          STRING   
   DEFINE lst_token         base.StringTokenizer            
   DEFINE ls_patch_code     LIKE type_t.chr3  #T100Patch包代碼(TSD,TPH,TIC...)
   DEFINE ls_patch_type     LIKE type_t.chr1  #T100Patch包類型(1-小包,2-專案包,3-例行包,T-測試區包)
   DEFINE ls_patch_time     LIKE type_t.num5  #T100Patch包年月份(1601,1705...)
   DEFINE ls_patch_num      LIKE type_t.num10 #T100Patch包流水號(000001~999999)
   DEFINE ls_patch_ver      LIKE type_t.chr5  #T100Patch包版號(1.0~x.x)
   DEFINE ls_patch_pre      LIKE type_t.chr50
   DEFINE ls_patch_num_pre  LIKE type_t.num10 #T100Patch包流水號(000001~999999)
   DEFINE li_cnt            LIKE type_t.num10
   DEFINE li_idx            LIKE type_t.num10
   
   #未啟用
   RETURN TRUE
   
   IF ps_patch_num.subString(1,1) <> "T" THEN
      DISPLAY "INFO:舊規則Patch包,不做管控!"
      RETURN TRUE
   END IF
   
   #開始解析資訊
   LET li_idx = 1
   LET lst_token  = base.StringTokenizer.create(ps_patch_num,"-")
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_patch_info[li_idx] = ls_token
      #2為類別碼
      IF li_idx = 2 THEN
         #不為3代表非例行性patch包, 不做檢查
         IF ls_token <> "3" THEN
            RETURN TRUE 
         END IF
      END IF
      LET li_idx = li_idx + 1
   END WHILE
   
    
   #開始組合資訊
   LET ls_patch_code = ls_patch_info[1] #T100Patch包代碼(TSD,TPH,TIC...)
   LET ls_patch_type = ls_patch_info[2] #T100Patch包類型(1-小包,2-專案包,3-例行包,T-測試區包)
   LET ls_patch_time = ls_patch_info[3] #T100Patch包年月份(1601,1705...)
   LET ls_patch_num  = ls_patch_info[4] #T100Patch包流水號(000001~999999)
   LET ls_patch_ver  = ls_patch_info[5] #T100Patch包版號(1.0~x.x)
   
   #檢查是否上過例行性Patch
   LET ls_patch_pre = "TSD-3-%",ls_patch_ver
   LET li_cnt = 0
   SELECT COUNT(*) INTO li_cnt 
     FROM dzyg_t 
    WHERE dzyg001 LIKE ls_patch_pre
   IF li_cnt = 0 THEN
      #無上過例行性patch, 不須檢查
      RETURN TRUE
   END IF
   
   #上一個編號
   LET ls_patch_num_pre = ls_patch_num - 1
   
   #組出上一包的代碼
   LET ls_patch_pre = ls_patch_code, #TSD
                      "-",
                      ls_patch_type, #3-例行包
                      "-",
                      "%",           #月份-未定
                      "-",
                      ls_patch_num_pre USING "&&&&&&", #流水號
                      "-",
                      ls_patch_ver   #版號
   
   #確認是否有前一包的資訊
   LET li_cnt = 0
   SELECT COUNT(*) INTO li_cnt 
     FROM dzyg_t 
    WHERE dzyg001 LIKE ls_patch_pre
   IF li_cnt > 0 THEN
      #有前一包
      RETURN TRUE
   ELSE
      #沒有前一包
      LET ls_patch_pre = ls_patch_code, #TSD
                         "-",
                         ls_patch_type, #3-例行包
                         "-",
                         "YYMM",        #月份-未定
                         "-",
                         ls_patch_num_pre USING "&&&&&&", #流水號
                         "-",
                         ls_patch_ver   #版號
      IF ps_pop THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-01013" #未定
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = ls_patch_pre
         CALL cl_err()
      ELSE
         DISPLAY "ERROR:請先匯入",ls_patch_pre,"!"
      END IF
      RETURN FALSE
   END IF
   
END FUNCTION

#16/07/18
FUNCTION adzp999_01_prog_diff(ps_ask)
   DEFINE ps_ask             LIKE type_t.chr1
   DEFINE l_source_folder    STRING #來源程式原始檔所在目錄
   DEFINE obj_prog_list      util.JSONArray,
          la_prog_list       T_DIFF_PROG_LIST,
          la_param           RECORD
             prog            STRING,
             param           DYNAMIC ARRAY OF STRING
             END RECORD,
          ls_js              STRING
   DEFINE li_idx             LIKE type_t.num10
   DEFINE li_idx2            LIKE type_t.num10
   
   #確認是否要詢問
   IF ps_ask = 'Y' THEN
      IF NOT cl_ask_confirm("adz-00882") THEN #請問是否要預覽程式差異?
         RETURN 
      END IF
   END IF
   
   IF (NOT os.Path.EXISTS(g_tmp_folder)) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00340"
      LET g_errparam.extend = NULL 
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_tmp_folder.trim()
      CALL cl_err()
      RETURN
   END IF
   
   LET l_source_folder = os.path.JOIN(os.path.JOIN(FGL_GETENV("TEMPDIR"),g_tmp_folder),g_tmp_folder||"-source")
   
   LET li_idx2 = 1
   FOR li_idx = 1 TO g_detail4_d.getLength()
      
      #patch008 = N, 客製程式不做diff(dzye012=Y)
      IF g_detail4_d[li_idx].dzye012 = "Y" AND g_patch_m.patch008 = "N" THEN
         CONTINUE FOR
      END IF
      
      LET la_prog_list[li_idx2].prog = g_detail4_d[li_idx].dzye002
      LET la_prog_list[li_idx2].prog_name = cl_get_progname(g_detail4_d[li_idx].dzye002,g_lang,"1")
      LET la_prog_list[li_idx2].cons_type = g_detail4_d[li_idx].dzye003
      LET la_prog_list[li_idx2].auth = "N"
      LET li_idx2 = li_idx2 + 1
   END FOR
   
   LET obj_prog_list = util.JSONArray.CREATE()
   LET obj_prog_list = util.JSONArray.fromFGL(la_prog_list)
   
   LET la_param.prog = "adzq991"
   LET la_param.param[1] = cs_only_query
   LET la_param.param[2] = obj_prog_list.toString()
   LET la_param.param[3] = l_source_folder
   LET ls_js = util.JSON.stringify(la_param)
   DISPLAY 'INFO:開始運行adzq911 - ', ls_js
   CALL cl_cmdrun_wait(ls_js)
            
END FUNCTION

#檢查adzp888是否還在運行
PUBLIC FUNCTION adzp999_01_adzp888_chk_run()
   DEFINE ls_cmd       STRING
   DEFINE l_chk        BOOLEAN        #是否執行成功
   DEFINE l_msg        STRING         #截取的錯誤訊息
   DEFINE l_ch         base.Channel
   DEFINE l_buf        STRING
   DEFINE l_str        STRING
   DEFINE l_cnt        INTEGER
   
   LET ls_cmd = "ps -f|grep adzp888"
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   CALL l_ch.openPipe(ls_cmd,"r")   #執行指令
   LET l_cnt = 0
   WHILE TRUE
      CALL l_ch.readLine() RETURNING l_buf
      DISPLAY l_buf
      IF l_buf.getIndexOf('adzp888',1) > 0 AND 
         l_buf.getIndexOf('42r',1)     > 0 THEN
         LET l_cnt = l_cnt + 1
      END IF
      
      IF l_cnt > 0 THEN
         RETURN TRUE
      END IF
      
      IF l_ch.isEof() THEN
         EXIT WHILE
      END IF
   END WHILE
   
   RETURN FALSE
   
END FUNCTION

#2016/09/22
FUNCTION sadzi999_01_run_command(ps_cmd)
   DEFINE ps_cmd       STRING
   DEFINE ls_cmd       STRING
   DEFINE l_chk        BOOLEAN        #是否執行成功
   DEFINE l_msg        STRING         #截取的錯誤訊息
   DEFINE l_ch         base.Channel
   DEFINE l_buf        STRING
   DEFINE l_str        STRING
   DEFINE l_cnt        INTEGER
   
   LET ls_cmd = ps_cmd
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   CALL l_ch.openPipe(ls_cmd,"r")   #執行指令
   WHILE TRUE
      CALL l_ch.readLine() RETURNING l_buf
      DISPLAY l_buf
      LET l_buf = l_buf.toLowerCase() 
      IF l_buf.getIndexOf('error',1) THEN
         DISPLAY 'ERROR:匯入資料過程中發生異常!'
      END IF
      IF l_buf.getIndexOf('adzp888 success',1) THEN
         EXIT WHILE
      END IF
      IF l_ch.isEof() THEN
         EXIT WHILE
      END IF
   END WHILE
   
   RETURN TRUE

END FUNCTION
#2016/09/22

#2016/12/13
PRIVATE FUNCTION adzp999_01_version()
   DISPLAY "r.patch 版本為:1.01.05 build-20161214 \n"
END FUNCTION
#2016/12/13

#2017/02/13
#+ 瀏覽頁簽資料初始化
PUBLIC FUNCTION adzp999_01_bgjob()
   DEFINE l_win_curr         ui.Window             #Current Window
   DEFINE l_frm_curr         ui.Form               #Current Form
   DEFINE ls_cfg_path        STRING
   DEFINE ls_4st_path        STRING
   DEFINE ls_img_path        STRING
   DEFINE l_cmd              STRING
   DEFINE l_msg              util.JSONObject
   DEFINE l_tmp              STRING
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_idx              LIKE type_t.num5
   DEFINE l_pid              STRING
   DEFINE l_time             STRING

   IF (ARG_VAL(3) = "-n" OR ARG_VAL(3) = "-N") AND NOT cl_null(ARG_VAL(3)) THEN
      LET g_merge = "N"
      DISPLAY "INFO:預設全不merge!"
   ELSE
      LET g_merge = "Y"
      DISPLAY "INFO:預設全merge!"
   END IF
          
   #檢查是否還有patch正在進行中
   #ps -ef | grep '/u1/topprd/erp/adz/42r/adzp999.* 4' |grep -v grep |awk '{print $2 "|" $5}'
   LET l_cmd = "ps -ef | grep '"
   LET l_cmd = l_cmd, os.Path.join(FGL_GETENV("ADZi"), "adzp999")
   LET l_cmd = l_cmd, ".* 4' |grep -v grep |awk '{print $2 ""|"" $5}'"
   LET l_tmp = sadzi888_01_get_command_msg(l_cmd) 
   LET l_msg = util.JSONObject.parse(l_tmp)

   IF l_msg.getLength() > 1 THEN
      FOR l_i = 1 TO l_msg.getLength()
         LET l_tmp = l_msg.get(l_msg.name(l_i))

         #取得process ID
         LET l_idx = l_tmp.getIndexOf("|", 1)
         LET l_pid = l_tmp.subString(1, l_idx - 1)

         IF l_pid = FGL_GETPID() THEN
            CONTINUE FOR
         END IF 
         
         #取得執行時間
         LET l_time = l_tmp.subString(l_idx + 1, l_tmp.getLength())
         EXIT FOR
      END FOR

      DISPLAY cl_getmsg('adz-00626',g_lang)
      RETURN
   END IF
   
   #程式初始化
   LET g_bgjob = "Y"
   LET g_adzp999_01_s01 = TRUE
   IF NOT adzp999_01_init() THEN
      RETURN
   END IF

   CALL FGL_SETENV("T100PATCH","Y")
   DISPLAY "T100PATCH:",FGL_GETENV("T100PATCH")
   
   #g_patch_m
   #patch001 GUID
   #patch002 patch號
   #patch003 patch包來源路徑         ###patch包所在路徑
   #patch004 dspatch user密碼(Oracle DB User)
   #patch005 只重做程式patch(不做設計資料匯入及合併)
   #patch006 patch解包檔路徑
   #patch007 是否gen 42s
   #patch008 是否merge標準程式
   #patch009 是否為快速更新 160816-00047
   
   #指定patch包
   LET g_patch_m.patch003 = ARG_VAL(4)
   IF g_patch_m.patch003 IS NULL THEN
      RETURN FALSE
   END IF
   
   #複製包到指定位置
   IF NOT adzp999_01_cp_pack() THEN
      RETURN FALSE
   END IF
   
   #取得所有patch資訊
   IF NOT cl_null(g_patch_m.patch006) THEN
      IF NOT os.Path.EXISTS(g_patch_m.patch006) THEN
         DISPLAY cl_getmsg('adz-00328', g_lang)
         RETURN FALSE
      END IF
   END IF
   
   LET g_action_choice = "get_pack_list"
   CALL adzp999_01_get_pack_list_pre()
     
   #patch解包程式
   LET g_quick_patch = g_patch_m.patch009
   
   IF cl_null(g_patch_m.patch003) OR cl_null(g_patch_m.patch006) THEN
      DISPLAY cl_getmsg('adz-00328', g_lang)
      RETURN FALSE
   END IF
   
   #檢查dspatch密碼
   IF cl_null(g_patch_m.patch004) THEN
      DISPLAY cl_getmsg('adz-00597', g_lang)
      RETURN FALSE
   END IF

   #行業別用
   IF FGL_GETENV("DGENV")="s" AND
      FGL_GETENV("TOPIND") IS NOT NULL AND
      FGL_GETENV("TOPIND") <> "sd" THEN
      CALL FGL_SETENV("TOPCHKOUT","N")
   END IF
      
   #抓取開始時間
   LET g_start_time = cl_get_current() 
 
   LET g_action_choice = "import_patch"
   LET g_finish_flag = FALSE
   CALL adzp999_01_import_patch_pre()
   
   CALL FGL_SETENV("T100PATCH","")
   DISPLAY "T100PATCH:",FGL_GETENV("T100PATCH")

   RETURN TRUE
   
END FUNCTION
#2017/02/13