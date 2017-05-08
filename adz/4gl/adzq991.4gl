#+ 程式版本......: 
#
#+ 程式代碼......: adzq991
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzq991.4gl
# Description    : 預覽Patch或過單的程式差異
# Modify         : 20160112 160226-00010 by Hiko : 新建程式.
#                : 20160226 CUST         by Hiko : 支持客製程式段merge功能.
#                : 20160308 FILE         by Hiko : 支持檔案比較功能.
#                : 20160309 AUTH         by Hiko : 增加權限控制.
#                : 20160314 MERGE        by Hiko : 將有異動的apt寫入資料庫.
#                : 20160318 SIMULATION   by Hiko : 自動執行模擬合併.
#                : 20160325 ATTRIBUTE    by Hiko : 檢視4fd屬性.
#                : 20160331 OPTIMIZE     by Hiko : 優化架構.
#                : 20160422 160422-00026 by Hiko : 補上dzba_t的INSERT段落.
#                : 20160620 160422-00026 by Hiko : 增加第三個參數(m_source_dir), 讓Patch/匯入更方便.
#                : 20160624 160627-00017 by Hiko : 1.BEFORE_IMP:匯入的情境不需要原始4gl畫面, 只需要diff即可.
#                                                  2.補上function/report/dialog的add point名稱:OTHER_FUNC
#                                                  3.最後的diff結果檔名改成.4gl.diff/.4fd.diff
#                                                  4.移除OTHER_FUNC的ON ACTION程式段, 追單功能改其他工具處理.
#                                                  5.客製環境下, 差異導覽特別標示屬於topstd修改的差異, 可防止忘記回追標準的問題.
#                : 20160722 160722-00008 by Hiko : 1.抑制錯誤訊息彈窗, 改成DISPLAY即可.
#                                                  2.修正行業程式對應不到模組的問題.
#                : 20160729 160729-00028 by Hiko : 支持多行挑選複製功能
#                : 20160819 160818-00042 by Hiko : 修正topstd的呈現問題
#                : 20160913 160913-00057 by Hiko : 改為不分大小寫來判斷是否為topstd的修改

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/adzq991_module.inc"

#diff來源:adzq991_module.inc
#cs_after_cus_patch  = "AFTER_CUS_PATCH"  #客戶Patch並merge後:由adzp050單支觸發,可以進階合併追版.
#cs_after_ind_patch  = "AFTER_IND_PATCH"  #行業Patch並同步後:由adzp050單支觸發,可以進階合併追版.
#作廢:cs_select_ver  = "SELECT_VER"       #不同版次比較:改成adzq993自行產生兩個不同版本的4gl,然後變成cs_file_diff再傳入.
#cs_only_query       = "ONLY_QUERY"       #行業Patch前/客戶Patch前/adzp640:多支,只能查看,會做模擬合併.
#cs_before_imp       = "BEFORE_IMP"       #過單匯入前/設計資料匯入前:單支,只能查看.
#cs_before_ind_patch = "BEFORE_IND_PATCH" #當比對情境為'行業Patch前', 則adzq991會自動從cs_only_query轉成cs_before_ind_patch.
#cs_file_diff        = "FILE_DIFF"        #指定檔案比較:adzq992呼叫使用

DEFINE g_diff_src     STRING, 
       g_left_4gl_dir STRING,
       m_source_dir   STRING  #20160620
DEFINE ga_prog_lst DYNAMIC ARRAY OF RECORD
                   has_topstd   CHAR(1), #160627-00017
                   left_prog    LIKE dzaf_t.dzaf001,
                   right_prog   LIKE dzaf_t.dzaf001,
                   prog_name    LIKE gzzal_t.gzzal003,
                   cons_type    LIKE dzaf_t.dzaf005,
                   right_module LIKE dzaf_t.dzaf006,
                   right_auth   CHAR(1) #AUTH 
                   END RECORD
DEFINE g_has_topstd   CHAR(1), #160818-00042
       g_left_prog    LIKE dzaf_t.dzaf001, #左側(來源)程式代號
       g_right_prog   LIKE dzaf_t.dzaf001, #右側(目標)程式代號
       g_right_module LIKE dzaf_t.dzaf006, #右側模組
       g_cons_type    LIKE dzaf_t.dzaf005, #建構類型
       g_right_auth   CHAR(1)              #右側(目標)的權限 #AUTH

TYPE T_FILE DYNAMIC ARRAY OF RECORD #儲存diff的解析結果.
            line            STRING, #程式內容
            diff            CHAR(1),#差異標示:Y,+
            belong_apt_desc STRING, #所屬add point說明
            belong_apt_name STRING, #所屬add point名稱
            belong_section  STRING  #所屬section名稱
            END RECORD

TYPE T_DIFF DYNAMIC ARRAY OF RECORD
            no     STRING, #為了變顏色,所以改成字串型態.
            left   STRING,
            l_diff CHAR(1),#+:左邊多的;x:左右不同
            right  STRING,
            r_diff CHAR(1),#+:右邊多的;x:左右不同
            cite   CHAR(1),#引用否(行業專用)
            merge  CHAR(1),#合併否
            apt    STRING, #add-point名稱
            orig   STRING  #右邊原始內容
            END RECORD

TYPE T_DIFF_NO DYNAMIC ARRAY OF RECORD
               no              STRING  ,#差異行號
               left_no         INTEGER,#來源實際行號
               right_no        INTEGER,#目標實際行號
               belong_apt_desc STRING,  #差異行號所屬add point說明
               belong_apt_name STRING,  #差異行號所屬add point名稱
               belong_section  STRING   #差異行號所屬section名稱
               END RECORD

TYPE T_BREAK DYNAMIC ARRAY OF RECORD
             break_apt LIKE dzba_t.dzba003, #行業斷開的add point
             break_no  INTEGER #行業斷開的add point對應的第一行數
             END RECORD

#Begin:ATTRIBUTE
TYPE T_ATT DYNAMIC ARRAY OF RECORD
           att     STRING,
           l_value STRING,
           l_diff  CHAR(1),#+:左邊多的;x:左右不同
           r_value STRING,
           r_diff  CHAR(1) #+:右邊多的;x:左右不同
           END RECORD
#End:ATTRIBUTE

DEFINE g_dgenv         STRING,
       g_date          DATETIME YEAR TO SECOND,
       g_customer      STRING,
       g_erpver        STRING,
       g_tempdir       STRING,
       gb_enable_merge BOOLEAN

DEFINE ga_file_info T_FILE_INFO
#Begin:MERGE
DEFINE g_dzaf004 LIKE dzaf_t.dzaf004,
       g_dzaf010 LIKE dzaf_t.dzaf010
#End:MERGE

DEFINE g_topind STRING #行業註記:SIMULATION
DEFINE gb_simulation BOOLEAN #沒有上過Patch/已經做過客製合併/行業同步/沒有上過Patch/挑選檔案都不需要模擬合併:SIMULATION
 
MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   DEFINE obj_prog_list util.JSONArray,  #外部參數只能用JSON來包裝陣列傳遞
          obj_file_list util.JSONObject, #FILE
          la_prog_list T_DIFF_PROG_LIST, 
                       #DYNAMIC ARRAY OF RECORD
                       #prog       LIKE dzaf_t.dzaf001, #在AFTER_SYNC的情況下是行業程式本身, 其他情況是指標準程式.
                       #prog_name  LIKE gzzal_t.gzzal003,
                       #cons_type  LIKE dzaf_t.dzaf005,
                       #auth       CHAR(1) #AUTH 
                       #END RECORD,
          l_gzzb003     LIKE gzzb_t.gzzb003, #FILE
          ls_prog_list  STRING, #為了JSONArray傳遞陣列參數的過渡變數
          li_i          INTEGER,
          ls_sql        STRING,
          la_gzzb       DYNAMIC ARRAY OF RECORD
                        gzzb001  LIKE gzzb_t.gzzb001,  #行業程式代號
                        gzzb002  LIKE gzzb_t.gzzb002,  #行業別
                        gzzal003 LIKE gzzal_t.gzzal003 #行業程式名稱
                        END RECORD,
          li_j,li_idx   INTEGER

   OPTIONS FIELD ORDER FORM, INPUT WRAP    
   
   CALL cl_tool_init()

   LET g_t100debug = FGL_GETENV("T100DEBUG")
   LET g_date = cl_get_current()
   LET g_customer = FGL_GETENV("CUST") CLIPPED
   LET g_erpver = FGL_GETENV("ERPVER") CLIPPED
   LET g_dgenv = FGL_GETENV("DGENV") CLIPPED
   LET g_tempdir = FGL_GETENV("TEMPDIR") CLIPPED
   LET g_topind = FGL_GETENV("TOPIND") CLIPPED   

   #Begin:SIMULATION
   IF cl_null(g_topind) THEN
      LET g_topind = "sd"
   END IF
   #End:SIMULATION
   
   #todo:單支測試要註解整塊
   LET g_diff_src = ARG_VAL(2)
   LET ls_prog_list = ARG_VAL(3)
   IF cl_null(ls_prog_list) THEN
      DISPLAY "INFO : The new verision 4gl file list is null."
      #Begin:160722-00008
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = "adz-00752" #呼叫 %1 缺少第 %2 個參數
      #LET g_errparam.replace[1] = "adzq991"
      #LET g_errparam.replace[2] = "3"
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      DISPLAY cl_replace_err_msg(cl_getmsg("adz-00752", g_lang), "adzq991|3")
      #End:160722-00008
      EXIT PROGRAM
   END IF
   
   LET m_source_dir = ARG_VAL(4)
   
   IF g_t100debug="9" THEN
      DISPLAY "ls_prog_list=",ls_prog_list
   END IF

   IF g_diff_src=cs_file_diff THEN #FILE
      LET obj_file_list = util.JSONObject.parse(ls_prog_list)
      CALL obj_file_list.toFGL(ga_file_info)
   ELSE 
      LET obj_prog_list = util.JSONArray.create()
      LET obj_prog_list = util.JSONArray.parse(ls_prog_list)
      CALL obj_prog_list.toFGL(la_prog_list) 
   END IF
   #整塊註解結束
     
   ##todo:單支程式測試
   #LET g_diff_src = cs_only_query
   #LET la_prog_list[1].prog = "aapt560"
   #LET la_prog_list[1].prog_name = "aapt560測試"
   #LET la_prog_list[1].cons_type = "M"
   #LET la_prog_list[1].auth = "N"
   
   #LET la_prog_list[2].prog = "aapt300"
   #LET la_prog_list[2].prog_name = "aapt300測試"
   #LET la_prog_list[2].cons_type = "M"
   #LET la_prog_list[2].auth = "N"
   #
   #LET la_prog_list[3].prog = "aapt560_03"
   #LET la_prog_list[3].prog_name = "axmt500測試"
   #LET la_prog_list[3].cons_type = "S"
   #LET la_prog_list[3].auth = "N"
   ##單支程式結束

   OPEN WINDOW w_adzq991 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   #CALL cl_load_4ad_interface(NULL) #為了使用原廠預設的搜尋工具, 所以將此段移除.

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   IF g_diff_src=cs_file_diff THEN #FILE
      CALL adzq991_ui_dialog_for_file()
   ELSE
      #Begin:SIMULATION
      IF g_diff_src="adzp050" THEN #'adzp050'是專門給下載畫面呼叫時傳遞使用.
         IF g_dgenv='s' THEN
            IF g_topind<>"sd" THEN
               LET g_diff_src = cs_after_ind_patch
            ELSE #以目前的流程, 這段不應該發生, 留著是為了防呆.
               LET g_diff_src = cs_select_ver #標準環境的標準區域就是比較不同版次.
               #Begin:160722-00008
               #INITIALIZE g_errparam TO NULL
               #LET g_errparam.code = "adz-00805" #溫馨提示 : 比較不同版次之間差異的功能尚未支持.
               #LET g_errparam.popup = TRUE
               #CALL cl_err()
               DISPLAY cl_getmsg("adz-00805", g_lang)
               #End:160722-00008
               EXIT PROGRAM
            END IF
         ELSE
            LET g_diff_src = cs_after_cus_patch
         END IF
      END IF
      #End:SIMULATION

      #此段是為了簡化呼叫端的判斷.
      IF g_diff_src=cs_only_query THEN
         IF g_topind<>"sd" AND g_dgenv='s' THEN
            LET g_diff_src = cs_before_ind_patch #在行業Patch還未做同步前開啟diff功能.
         END IF
      END IF

      #準備程式清單.
      CALL ga_prog_lst.clear()

      CASE 
         WHEN g_diff_src=cs_after_cus_patch OR g_diff_src=cs_only_query OR g_diff_src=cs_before_imp #160627-00017:BEFORE_IMP
            FOR li_i=1 TO la_prog_list.getLength()
               LET ga_prog_lst[li_i].has_topstd = 'N' #160627-00017
               LET ga_prog_lst[li_i].left_prog = la_prog_list[li_i].prog
               LET ga_prog_lst[li_i].right_prog = la_prog_list[li_i].prog
               LET ga_prog_lst[li_i].prog_name = la_prog_list[li_i].prog_name
               LET ga_prog_lst[li_i].cons_type = la_prog_list[li_i].cons_type
               LET ga_prog_lst[li_i].right_module = sadzp062_1_find_module(ga_prog_lst[li_i].right_prog, ga_prog_lst[li_i].cons_type) #取得目標程式所屬模組
               LET ga_prog_lst[li_i].right_auth = la_prog_list[li_i].auth #AUTH
               #Begin:160627-00017
               IF g_dgenv="c" THEN
                  IF adzq991_modi_by_topstd(ga_prog_lst[li_i].right_prog, NULL) THEN
                     LET ga_prog_lst[li_i].has_topstd = 'Y'
                  END IF
               END IF
               #End:160627-00017
            END FOR
         WHEN g_diff_src=cs_before_ind_patch #AUTH
            LET li_j = 1
            FOR li_i=1 TO la_prog_list.getLength()
               #依據標準程式代號找到對應的各行業程式代號.
               LET ls_sql = "SELECT gzzb001,gzzb002,gzzal003 FROM gzzb_t",
                            "  LEFT JOIN gzzal_t ON gzzal001=gzzb001 AND gzzal002='",g_lang,"'",
                            " WHERE gzzb003='",la_prog_list[li_i].prog CLIPPED,"'",
                            "   AND gzzb003<>gzzb001",
                            " ORDER BY gzzb001"
               PREPARE prep_gzzb FROM ls_sql
               DECLARE curs_gzzb CURSOR FOR prep_gzzb
               LET ls_sql = NULL
               LET li_idx = 1
               FOREACH curs_gzzb INTO la_gzzb[li_idx].*
                  LET ga_prog_lst[li_j].left_prog = la_prog_list[li_i].prog
                  LET ga_prog_lst[li_j].right_prog = la_gzzb[li_idx].gzzb001
                  LET ga_prog_lst[li_j].prog_name = la_gzzb[li_idx].gzzal003
                  LET ga_prog_lst[li_j].cons_type = la_prog_list[li_i].cons_type
                  #LET ga_prog_lst[li_j].right_module = sadzp062_1_find_module(ga_prog_lst[li_i].right_prog, ga_prog_lst[li_i].cons_type) #取得目標程式所屬模組
                  LET ga_prog_lst[li_j].right_module = sadzp062_1_find_module(ga_prog_lst[li_j].right_prog, ga_prog_lst[li_j].cons_type) #取得目標程式所屬模組 #160722-00008
                  LET ga_prog_lst[li_i].right_auth = 'N' #AUTH
                  LET li_j = li_j + 1
               END FOREACH
            END FOR
         #Begin:AUTH
         WHEN g_diff_src=cs_after_ind_patch #每次只有一支行業程式要比較. la_prog_list[1].prog只有這種情況下是表示行業程式代號, 其餘都是標準程式代號.
            IF la_prog_list[1].cons_type='M' THEN
               #由行業代號取得標準程式代號.
               LET ls_sql = "SELECT gzzb003 FROM gzzb_t",
                            " WHERE gzzb001='",la_prog_list[1].prog CLIPPED,"'"
               PREPARE prep_gzzb2 FROM ls_sql
               EXECUTE prep_gzzb2 INTO l_gzzb003
               FREE prep_gzzb2
               LET ga_prog_lst[1].left_prog = l_gzzb003
               LET ga_prog_lst[1].right_prog = la_prog_list[1].prog
               LET ga_prog_lst[1].prog_name = la_prog_list[1].prog_name
               LET ga_prog_lst[1].cons_type = la_prog_list[1].cons_type
               LET ga_prog_lst[1].right_module = sadzp062_1_find_module(ga_prog_lst[1].right_prog, ga_prog_lst[1].cons_type) #取得目標程式所屬模組
               LET ga_prog_lst[1].right_auth = la_prog_list[1].auth #AUTH
            END IF
         #End:AUTH
      END CASE
      
      IF ga_prog_lst.getLength()=0 THEN
         #Begin:160722-00008
         #INITIALIZE g_errparam TO NULL
         #LET g_errparam.code = "adz-00800" #找不到對應的程式,請查明後再重新執行.
         #LET g_errparam.popup = TRUE
         #CALL cl_err()
         DISPLAY cl_getmsg("adz-00800", g_lang)
         #End:160722-00008
         EXIT PROGRAM
      END IF
      
      CALL adzq991_ui_dialog()
   END IF

   CLOSE WINDOW w_adzq991 
END MAIN

PRIVATE FUNCTION adzq991_ui_dialog()
   #Begin:FILE
   DEFINE ls_left_file_path  STRING,
          ls_right_file_path STRING,
          ls_diff_file_path  STRING
   #End:FILE
   DEFINE la_diff T_DIFF,
          la_diff_color T_DIFF,
          la_diff_no T_DIFF_NO,
          la_diff_no_color T_DIFF_NO 
   DEFINE la_diff1 T_DIFF,
          la_diff1_color T_DIFF,
          la_diff1_no T_DIFF_NO,
          la_diff1_no_color T_DIFF_NO 
   DEFINE li_curr_prog INTEGER,
          li_curr_diff_no  INTEGER, 
          li_curr_diff_no1 INTEGER 
   DEFINE la_break         T_BREAK, #行業斷開add point行數清單
          la_break_color   T_BREAK, #OPTIMIZE
          la_multi_break   T_BREAK, #行業斷開add-point多行合併使用
          la_break1        T_BREAK,
          la_break1_color  T_BREAK, #OPTIMIZE
          la_multi_break1  T_BREAK,
          li_curr_break_no INTEGER 
   DEFINE li_curr_no      INTEGER,         #行業斷開add point合併行數
          json_old_right  util.JSONObject, #舊版程式合併前的原始內容
          json_merge_apt  util.JSONObject, #有執行merge的apt名稱, 這是為了快速將add point寫入資料庫.
                                           #因為目的是為了取得需要異動的add point名稱, 所以設定方式和json_old_right剛好相反.
          ls_curr_apt     STRING,          #游標所在add point名稱
          li_i            INTEGER,
          li_break_no     INTEGER,
          ls_temp_break   STRING,          #這是為了加快合併速度
          ls_check_apt    STRING,
          lb_remove_apt   BOOLEAN,
          li_j            INTEGER,
          li_temp_j       INTEGER, #for li_j的起始索引
          ls_update_apt   STRING,  #需要更新的add point名稱
          lsb_code        base.StringBuffer,
          l_dzbb098       LIKE dzbb_t.dzbb098,
          ls_cmd          STRING,
          lb_result       BOOLEAN,
          ls_err_msg      STRING,
          li_4fd_arr_curr INTEGER    
   DEFINE la_att       T_ATT,
          la_att_color T_ATT       
   DEFINE lb_null_line BOOLEAN, #OTHER_FUNC
          li_m         INTEGER  #160627-00017
   #Begin:160729-00028
   DEFINE li_c         INTEGER,
          lsb_sel_line base.StringBuffer
   #End:160729-00028
                    
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY ga_prog_lst TO tbl_prog.*
            #差異比對
            ON ACTION btn_diff #此段同BEFORE DIALOG
               IF cl_ask_confirm("adz-00786") THEN #此動作會刷新所做的任何異動, 請問是否要重新比對?
                  #以此程式的觸發時機(由adzp050觸發)來說, 底下程式段不需要重新取程式資料與設定顯現與否, 只需要重新diff即可.
                  #但若以後有機會擴充為多程式呈現的話, 則底下設定段就是必須要的, 所以就不取消設定段.
                  LET li_curr_prog = ARR_CURR()
                  
                  LET json_old_right = util.JSONObject.create() #行業同步還原使用.
                  LET json_merge_apt = util.JSONObject.create() #MERGE:更新資料庫使用.

                  LET g_has_topstd = ga_prog_lst[li_curr_prog].has_topstd #160818-00042
                  LET g_left_prog = ga_prog_lst[li_curr_prog].left_prog
                  LET g_right_prog = ga_prog_lst[li_curr_prog].right_prog
                  LET g_right_module = ga_prog_lst[li_curr_prog].right_module
                  LET g_cons_type = ga_prog_lst[li_curr_prog].cons_type
                  LET g_right_auth = ga_prog_lst[li_curr_prog].right_auth #AUTH

                  #Begin:160818-00042:這段和BEFORE DIALOG相同
                  INITIALIZE la_diff_color TO NULL
                  INITIALIZE la_diff_no_color TO NULL
                  INITIALIZE la_break_color TO NULL
                  INITIALIZE la_diff1_color TO NULL
                  INITIALIZE la_diff1_no_color TO NULL
                  INITIALIZE la_att_color TO NULL
                  CALL DIALOG.setArrayAttributes("tbl_diff", la_diff_color) #為了變顏色.
                  CALL DIALOG.setArrayAttributes("tbl_diff_no", la_diff_no_color) #為了變顏色.
                  CALL DIALOG.setArrayAttributes("tbl_break", la_break_color) #為了變顏色.
                  CALL DIALOG.setArrayAttributes("tbl_diff1", la_diff1_color) #為了變顏色.
                  CALL DIALOG.setArrayAttributes("tbl_diff_no1", la_diff1_no_color) #為了變顏色.
                  CALL DIALOG.setArrayAttributes("tbl_attribute", la_att_color) #為了變顏色.
                  CALL DIALOG.setSelectionMode("tbl_diff", TRUE)
                  #End:160729-00028
                  CLEAR FORM
                  #預設隱藏.
                  CALL cl_set_comp_visible("edt_original", FALSE)
                  #End:160818-00042

                  LET gb_enable_merge = FALSE #MERGE
                  IF g_diff_src=cs_only_query OR g_diff_src=cs_before_ind_patch THEN #160627-00017
                     LET gb_simulation = TRUE #SIMULATION
                  ELSE
                     LET gb_simulation = FALSE
                  END IF

                  IF g_cons_type<>'F' THEN #非子畫面(F)才要比較4gl.
                     CALL adzq991_diff_before(li_curr_prog, "4gl")
                     #Begin:FILE
                     LET ls_left_file_path = os.path.join(g_left_4gl_dir, g_left_prog||".4gl")
                     LET ls_right_file_path = os.path.join(os.path.join(FGL_GETENV(g_right_module), "4gl"), g_right_prog||".4gl")
                     LET ls_diff_file_path = os.path.join(g_tempdir, g_right_prog||".4gl.diff")
                     CALL adzq991_diff_start2("4gl", ls_left_file_path, ls_right_file_path, ls_diff_file_path)
                          RETURNING la_diff,la_diff_color,la_diff_no,la_diff_no_color,la_break,la_break_color,la_multi_break #OPTIMIZE
                     #End:FILE
                     CALL adzq991_change_col_title("edt_left", g_left_prog)
                     CALL adzq991_change_col_title("edt_right", g_right_prog)
                     CALL adzq991_change_col_title("edt_original", g_right_prog)
                  END IF
                  
                  IF g_cons_type MATCHES "[MSF]" THEN #只有主程式(M),子程式(S),子畫面(F)才要比較4fd.
                     CALL adzq991_diff_before(li_curr_prog, "4fd")
                     #Begin:FILE
                     LET ls_left_file_path = os.path.join(g_left_4gl_dir, g_left_prog||".4fd")
                     LET ls_right_file_path = os.path.join(os.path.join(FGL_GETENV(g_right_module), "4fd"), g_right_prog||".4fd")
                     LET ls_diff_file_path = os.path.join(g_tempdir, g_right_prog||".4fd.diff")
                     CALL adzq991_diff_start2("4gl", ls_left_file_path, ls_right_file_path, ls_diff_file_path)
                          RETURNING la_diff1,la_diff1_color,la_diff1_no,la_diff1_no_color,la_break1,la_break1_color,la_multi_break1 #OPTIMIZE
                     #End:FILE
                     CALL adzq991_change_col_title("edt_left1", g_left_prog)
                     CALL adzq991_change_col_title("edt_right1", g_right_prog)
                  END IF
               END IF
         END DISPLAY
 
         #比對程式內容
         DISPLAY ARRAY la_diff TO tbl_diff.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff", la_diff_color) #為了變顏色. #160729-00028

            BEFORE ROW
               LET li_curr_no = ARR_CURR()
               #BEFORE DIALOG就已經確定是否需要顯現這些Button, 所以此時只需要在行業程式的比對過程中判斷是否可以觸發即可.
               IF gb_enable_merge THEN
                  CALL DIALOG.setActionActive("btn_multi_merge", FALSE)
                  CALL DIALOG.setActionActive("btn_multi_remove", FALSE)
                  CALL DIALOG.setActionActive("btn_line_merge", FALSE)
                  CALL DIALOG.setActionActive("btn_line_remove", FALSE)
                  #行業斷開才可以進行合併.
                  IF la_diff[li_curr_no].cite='N' THEN
                     CALL DIALOG.setActionActive("btn_multi_merge", TRUE)
                     CALL DIALOG.setActionActive("btn_multi_remove", TRUE)
                     CALL DIALOG.setActionActive("btn_line_merge", TRUE)
                     CALL DIALOG.setActionActive("btn_line_remove", TRUE)
                  END IF
               END IF

            #Begin:160729-00028
            ON ACTION btn_multi_copy
               LET lb_null_line = TRUE
               LET lsb_sel_line = base.StringBuffer.create()
               #FOR li_c=1 TO DIALOG.getArrayLength("tbl_diff")
               FOR li_c=1 TO la_diff.getLength()
                  IF DIALOG.isRowSelected("tbl_diff", li_c) THEN
                     IF lb_null_line THEN
                        CALL cl_null(la_diff[li_c].left) RETURNING lb_null_line
                        IF NOT lb_null_line THEN #遇到第一個不是空白行的字串就不能增加斷行符號,以免多空一行.
                           CALL lsb_sel_line.append(la_diff[li_c].left)
                           CONTINUE FOR
                        END IF
                     END IF
            
                     IF lb_null_line THEN
                        CALL lsb_sel_line.append("\n")
                     ELSE
                        CALL lsb_sel_line.append("\n")
                        CALL lsb_sel_line.append(la_diff[li_c].left)
                     END IF
                  END IF
               END FOR
            
               CALL ui.Interface.frontCall("standard", "cbSet", [lsb_sel_line.toString()], [])
            #End:160729-00028
 
         END DISPLAY

         #程式差異行號
         DISPLAY ARRAY la_diff_no TO tbl_diff_no.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff_no", la_diff_no_color) #為了變顏色. #160729-00028

            BEFORE ROW
               LET li_curr_diff_no = la_diff_no[ARR_CURR()].no
               display "diff_no=",la_diff_no[ARR_CURR()].belong_apt_name #todo
               CALL DIALOG.setCurrentRow("tbl_diff", li_curr_diff_no)
         END DISPLAY
 
         #斷開/客製行號清單
         DISPLAY ARRAY la_break TO tbl_break.*
            #Begin:OPTIMIZE
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_break", la_break_color) #為了變顏色. #160729-00028
            #End:OPTIMIZE

            BEFORE ROW
               LET li_curr_break_no = la_break[ARR_CURR()].break_no
               display "break apt=",la_break[ARR_CURR()].break_apt #todo
               CALL DIALOG.setCurrentRow("tbl_diff", li_curr_break_no)
         END DISPLAY

         #比對畫面內容
         DISPLAY ARRAY la_diff1 TO tbl_diff1.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff1", la_diff1_color) #為了變顏色. #160729-00028

            #Begin:ATTRIBUTE
            BEFORE ROW
               INITIALIZE la_att TO NULL
               INITIALIZE la_att_color TO NULL
               LET li_4fd_arr_curr = ARR_CURR()
               IF NOT cl_null(la_diff1[li_4fd_arr_curr].l_diff) OR
                  NOT cl_null(la_diff1[li_4fd_arr_curr].r_diff) THEN
                  IF adzq991_chk_attribute(la_diff1[li_4fd_arr_curr].left, la_diff1[li_4fd_arr_curr].right) THEN
                     CALL adzq991_get_attribute(la_diff1[li_4fd_arr_curr].left, la_diff1[li_4fd_arr_curr].right) RETURNING la_att,la_att_color
                  END IF
               END IF
            #End:ATTRIBUTE
         END DISPLAY

         #畫面差異行號
         DISPLAY ARRAY la_diff1_no TO tbl_diff_no1.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff_no1", la_diff1_no_color) #為了變顏色. #160729-00028

            BEFORE ROW
               LET li_curr_diff_no1 = la_diff1_no[ARR_CURR()].no
               CALL DIALOG.setCurrentRow("tbl_diff1", li_curr_diff_no1)
         END DISPLAY

         #Begin:ATTRIBUTE
         DISPLAY ARRAY la_att TO tbl_attribute.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_attribute", la_att_color) #為了變顏色. #160729-00028
         END DISPLAY
         #End:ATTRIBUTE

         ON ACTION btn_hidden
            CALL cl_set_comp_visible("tbl_prog", FALSE)
            CALL cl_set_comp_visible("btn_hidden", FALSE)
            CALL cl_set_comp_visible("btn_show", TRUE)

         ON ACTION btn_show
            CALL cl_set_comp_visible("tbl_prog", TRUE)
            CALL cl_set_comp_visible("btn_hidden", TRUE)
            CALL cl_set_comp_visible("btn_show", FALSE)

         ON ACTION CLOSE
            LET g_action_choice="exit"
            EXIT DIALOG

         BEFORE DIALOG                
            #Begin:160729-00028
            CALL DIALOG.setArrayAttributes("tbl_diff", la_diff_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_diff_no", la_diff_no_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_break", la_break_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_diff1", la_diff1_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_diff_no1", la_diff1_no_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_attribute", la_att_color) #為了變顏色.
            CALL DIALOG.setSelectionMode("tbl_diff", TRUE)
            #End:160729-00028
            CLEAR FORM
            #預設隱藏.
            CALL cl_set_comp_visible("edt_original", FALSE)

            #一開畫面就diff
            IF ga_prog_lst.getLength()>0 THEN
               LET li_curr_prog = 1
               LET json_old_right = util.JSONObject.create() #行業同步還原使用.
               LET json_merge_apt = util.JSONObject.create() #MERGE:更新資料庫使用.

               LET g_has_topstd = ga_prog_lst[li_curr_prog].has_topstd #160818-00042
               LET g_left_prog = ga_prog_lst[li_curr_prog].left_prog
               LET g_right_prog = ga_prog_lst[li_curr_prog].right_prog
               LET g_right_module = ga_prog_lst[li_curr_prog].right_module
               LET g_cons_type = ga_prog_lst[li_curr_prog].cons_type
               LET g_right_auth = ga_prog_lst[li_curr_prog].right_auth #AUTH

               LET gb_enable_merge = FALSE #MERGE
               IF g_diff_src=cs_only_query OR g_diff_src=cs_before_ind_patch THEN #160627-00017
                  LET gb_simulation = TRUE #SIMULATION
               ELSE
                  LET gb_simulation = FALSE
               END IF
               
               IF g_cons_type<>'F' THEN
                  CALL adzq991_diff_before(li_curr_prog, "4gl")
                  #Begin:FILE
                  LET ls_left_file_path = os.path.join(g_left_4gl_dir, g_left_prog||".4gl")
                  LET ls_right_file_path = os.path.join(os.path.join(FGL_GETENV(g_right_module), "4gl"), g_right_prog||".4gl")
                  LET ls_diff_file_path = os.path.join(g_tempdir, g_right_prog||".4gl.diff")
                  CALL adzq991_diff_start2("4gl", ls_left_file_path, ls_right_file_path, ls_diff_file_path)
                       RETURNING la_diff,la_diff_color,la_diff_no,la_diff_no_color,la_break,la_break_color,la_multi_break #OPTIMIZE
                  #End:FILE
                  CALL adzq991_change_col_title("edt_left", g_left_prog)
                  CALL adzq991_change_col_title("edt_right", g_right_prog)
                  CALL adzq991_change_col_title("edt_original", g_right_prog)
               END IF

               IF g_cons_type MATCHES "[MSF]" THEN
                  CALL adzq991_diff_before(li_curr_prog, "4fd")
                  #Begin:FILE
                  LET ls_left_file_path = os.path.join(g_left_4gl_dir, g_left_prog||".4fd")
                  LET ls_right_file_path = os.path.join(os.path.join(FGL_GETENV(g_right_module), "4fd"), g_right_prog||".4fd")
                  LET ls_diff_file_path = os.path.join(g_tempdir, g_right_prog||".4fd.diff")
                  CALL adzq991_diff_start2("4fd", ls_left_file_path, ls_right_file_path, ls_diff_file_path)
                       RETURNING la_diff1,la_diff1_color,la_diff1_no,la_diff1_no_color,la_break1,la_break1_color,la_multi_break1 #OPTIMIZE
                  #End:FILE
                  CALL adzq991_change_col_title("edt_left1", g_left_prog)
                  CALL adzq991_change_col_title("edt_right1", g_right_prog)
               END IF
            END IF
      END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

PRIVATE FUNCTION adzq991_ui_dialog_for_file()
   DEFINE ls_left_file_path  STRING,
          ls_right_file_path STRING,
          ls_diff_file_path  STRING
   DEFINE la_diff          T_DIFF,
          la_diff_color    T_DIFF,
          la_diff_no       T_DIFF_NO,
          la_diff_no_color T_DIFF_NO 
   DEFINE li_curr_diff_no  INTEGER, 
          li_curr_diff_no1 INTEGER 
   DEFINE la_diff1          T_DIFF,
          la_diff1_color    T_DIFF,
          la_diff1_no       T_DIFF_NO,
          la_diff1_no_color T_DIFF_NO,
          li_4fd_arr_curr   INTEGER 
   DEFINE la_break         T_BREAK, #行業斷開add point行數清單
          la_break_color   T_BREAK, #OPTIMIZE
          la_multi_break   T_BREAK, #行業斷開add-point多行合併使用
          la_break1        T_BREAK,
          la_break1_color  T_BREAK, #OPTIMIZE
          la_multi_break1  T_BREAK,
          li_curr_break_no INTEGER 
   DEFINE la_att       T_ATT,
          la_att_color T_ATT       
   #Begin:160729-00028
   DEFINE li_c         INTEGER,
          lb_null_line BOOLEAN,
          lsb_sel_line base.StringBuffer
   #End:160729-00028

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #比對程式內容
         DISPLAY ARRAY la_diff TO tbl_diff.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff", la_diff_color) #為了變顏色. #160729-00028

            #Begin:160729-00028
            ON ACTION btn_multi_copy
               LET lb_null_line = TRUE
               LET lsb_sel_line = base.StringBuffer.create()
               #FOR li_c=1 TO DIALOG.getArrayLength("tbl_diff")
               FOR li_c=1 TO la_diff.getLength()
                  IF DIALOG.isRowSelected("tbl_diff", li_c) THEN
                     IF lb_null_line THEN
                        CALL cl_null(la_diff[li_c].left) RETURNING lb_null_line
                        IF NOT lb_null_line THEN #遇到第一個不是空白行的字串就不能增加斷行符號,以免多空一行.
                           CALL lsb_sel_line.append(la_diff[li_c].left)
                           CONTINUE FOR
                        END IF
                     END IF
            
                     IF lb_null_line THEN
                        CALL lsb_sel_line.append("\n")
                     ELSE
                        CALL lsb_sel_line.append("\n")
                        CALL lsb_sel_line.append(la_diff[li_c].left)
                     END IF
                  END IF
               END FOR
            
               CALL ui.Interface.frontCall("standard", "cbSet", [lsb_sel_line.toString()], [])
            #End:160729-00028
         END DISPLAY

         #程式差異行號
         DISPLAY ARRAY la_diff_no TO tbl_diff_no.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff_no", la_diff_no_color) #為了變顏色. #160729-00028

            BEFORE ROW
               LET li_curr_diff_no = la_diff_no[ARR_CURR()].no
               CALL DIALOG.setCurrentRow("tbl_diff", li_curr_diff_no)
         END DISPLAY

         #比對畫面內容
         DISPLAY ARRAY la_diff1 TO tbl_diff1.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff1", la_diff1_color) #為了變顏色. #160729-00028

            #Begin:ATTRIBUTE
            BEFORE ROW
               INITIALIZE la_att TO NULL
               INITIALIZE la_att_color TO NULL
               LET li_4fd_arr_curr = ARR_CURR()
               IF NOT cl_null(la_diff1[li_4fd_arr_curr].l_diff) OR
                  NOT cl_null(la_diff1[li_4fd_arr_curr].r_diff) THEN
                  IF adzq991_chk_attribute(la_diff1[li_4fd_arr_curr].left, la_diff1[li_4fd_arr_curr].right) THEN
                     CALL adzq991_get_attribute(la_diff1[li_4fd_arr_curr].left, la_diff1[li_4fd_arr_curr].right) RETURNING la_att,la_att_color
                  END IF
               END IF
         END DISPLAY

         #畫面差異行號
         DISPLAY ARRAY la_diff1_no TO tbl_diff_no1.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_diff_no1", la_diff1_no_color) #為了變顏色. #160729-00028

            BEFORE ROW
               LET li_curr_diff_no1 = la_diff1_no[ARR_CURR()].no
               CALL DIALOG.setCurrentRow("tbl_diff1", li_curr_diff_no1)
         END DISPLAY

         #Begin:ATTRIBUTE
         DISPLAY ARRAY la_att TO tbl_attribute.*
            BEFORE DISPLAY
               #CALL DIALOG.setArrayAttributes("tbl_attribute", la_att_color) #為了變顏色. #160729-00028
         END DISPLAY
         #End:ATTRIBUTE

         ON ACTION CLOSE
            LET g_action_choice="exit"
            EXIT DIALOG

         BEFORE DIALOG                
            #Begin:160729-00028
            CALL DIALOG.setArrayAttributes("tbl_diff", la_diff_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_diff_no", la_diff_no_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_diff1", la_diff1_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_diff_no1", la_diff1_no_color) #為了變顏色.
            CALL DIALOG.setArrayAttributes("tbl_attribute", la_att_color) #為了變顏色.
            CALL DIALOG.setSelectionMode("tbl_diff", TRUE) #為了多選複製
            #End:160729-00028
            CLEAR FORM

            LET gb_enable_merge = FALSE #預設不允許做進階合併.
            LET gb_simulation = FALSE #SIMULATION:挑選檔案不需要模擬合併.
            #隱藏不需要的控件.
            CALL cl_set_comp_visible("btn_diff,lbl_prog,tbl_prog,btn_hidden,btn_show", FALSE)
            CALL cl_set_comp_visible("tbl_break,edt_original", FALSE)

            #Begin:160913-00057
            #ga_file_info.right_4gl="/u1/t10dev/erp/axc/4gl/axcp120.4gl"
            #os.Path.rootname(ga_file_info.right_4gl)="/u1/t10dev/erp/axc/4gl/axcp120"
            #os.Path.basename("/u1/t10dev/erp/axc/4gl/axcp120")="axcp120"
            LET g_right_prog = os.Path.basename(os.Path.rootname(ga_file_info.right_4gl))

            IF g_dgenv="c" THEN
               IF adzq991_modi_by_topstd(g_right_prog, NULL) THEN
                  LET g_has_topstd = 'Y'
               END IF
            END IF
            #End:160913-00057

            #一開畫面就diff : 4gl或4fd是二擇一的比較.
            IF (ga_file_info.left_4gl IS NOT NULL) AND
               (ga_file_info.right_4gl IS NOT NULL) THEN  
               LET ls_diff_file_path = os.path.join(g_tempdir, os.Path.basename(ga_file_info.right_orig)||".diff")
               CALL adzq991_diff_start2("4gl", ga_file_info.left_4gl, ga_file_info.right_4gl, ls_diff_file_path)
                    RETURNING la_diff,la_diff_color,la_diff_no,la_diff_no_color,la_break,la_break_color,la_multi_break #OPTIMIZE
               CALL adzq991_change_col_title("edt_left", ga_file_info.left_orig)
               CALL adzq991_change_col_title("edt_right", ga_file_info.right_orig)
            END IF

            IF (ga_file_info.left_4fd IS NOT NULL) AND
               (ga_file_info.right_4fd IS NOT NULL) THEN  
               LET ls_diff_file_path = os.path.join(g_tempdir, os.Path.basename(ga_file_info.right_orig)||".diff")
               CALL adzq991_diff_start2("4fd", ga_file_info.left_4fd, ga_file_info.right_4fd, ls_diff_file_path)
                    RETURNING la_diff1,la_diff1_color,la_diff1_no,la_diff1_no_color,la_break1,la_break1_color,la_multi_break1 #OPTIMIZE
               CALL adzq991_change_col_title("edt_left1", ga_file_info.left_orig)
               CALL adzq991_change_col_title("edt_right1", ga_file_info.right_orig)
            END IF
      END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

FUNCTION adzq991_change_col_title(p_name, p_value)
   DEFINE p_name  STRING,
          p_value STRING
   DEFINE lwin_curr   ui.Window,
          lnode_win   om.DomNode,
          lst_item    om.NodeList,
          li_i        SMALLINT,
          l_item      om.DomNode,
          ls_col_name STRING,
          ls_text     STRING,
          l_gzzd005   LIKE gzzd_t.gzzd005

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
   LET lst_item = lnode_win.selectByTagName("TableColumn") #這是以42f的角度來查看的.
   FOR li_i=1 TO lst_item.getLength()
      LET l_item = lst_item.item(li_i)
      LET ls_col_name = l_item.getAttribute("colName")
      IF ls_col_name=p_name THEN
         IF g_diff_src=cs_file_diff THEN
            CALL l_item.setAttribute("text", p_value)
         ELSE
            LET ls_text = l_item.getAttribute("text")
            IF NOT cl_null(ls_text) THEN
               #Begin:160627-00017:BEFORE_IMP:這邊就簡單轉換即可.
               IF g_diff_src=cs_before_imp AND p_name="edt_right" THEN
                  SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
                   WHERE gzzd001='adzq991' AND gzzd002=g_lang AND gzzd003 = 'edt_right_prog' AND gzzd004='s' 
                  
                  LET ls_text = l_gzzd005 CLIPPED
               END IF
               #End:BEFORE_IMP
               #BEGIN:160818-00042 : add by elena
               IF ls_text.getindexof('(',1)>0 THEN
                  LET ls_text = ls_text.substring(1,ls_text.getindexof('(',1)-1)
               END IF
               #End:160818-00042
               LET ls_text = ls_text,"(",p_value,")"
               CALL l_item.setAttribute("text", ls_text)
            ELSE
               CALL l_item.setAttribute("text", p_value) #MERGE
            END IF
         END IF
         EXIT FOR
      END IF
   END FOR
END FUNCTION

#檔案比較的時候不需要呼叫此FUNCTION.
FUNCTION adzq991_diff_before(p_prog_idx, p_kind)
   DEFINE p_prog_idx SMALLINT,
          p_kind     STRING
   DEFINE l_gzza003 LIKE gzza_t.gzza003, #歸屬模組
          l_gzza011 LIKE gzza_t.gzza011  #客製否
   DEFINE lc_flag CHAR(1) #SIMULATION

   CASE
      WHEN g_diff_src=cs_after_ind_patch #4gl路徑同目標程式模組.
         LET g_left_4gl_dir = os.path.join(FGL_GETENV(g_right_module), p_kind)
      WHEN g_diff_src=cs_after_cus_patch #找到標準程式的歸屬模組.
         CALL sadzp062_1_find_belong_module(g_right_prog, g_cons_type) RETURNING l_gzza003,l_gzza011
         LET g_left_4gl_dir = os.path.join(FGL_GETENV(l_gzza003), p_kind)
      WHEN g_diff_src=cs_before_ind_patch OR g_diff_src=cs_only_query OR g_diff_src=cs_before_imp #行業Patch/客戶Patch/過單/匯入解包後的路徑預設為TEMPDIR. #160627-00017:BEFORE_IMP
         #Begin:20160620
         #LET g_left_4gl_dir = FGL_GETENV("TEMPDIR")
         IF cl_null(m_source_dir) THEN
            LET g_left_4gl_dir = g_tempdir
         ELSE
            LET g_left_4gl_dir = m_source_dir
         END IF
         #End:20160620
   END CASE

   DISPLAY g_right_prog TO lbl_prog
   
   IF p_kind="4gl" THEN
      #Begin:SIMULATION
      #IF ((g_diff_src=cs_after_ind_patch AND g_dgenv='s' AND g_cons_type='M') OR
      #    (g_diff_src=cs_after_cus_patch AND g_dgenv='c')) AND 
      #   g_right_auth='Y' THEN #AUTH
      #   LET gb_enable_merge = TRUE
      #END IF

      #cs_after_ind_patch和cs_after_cus_patch都是由adzp050觸發.
      IF ((g_diff_src=cs_after_ind_patch AND g_dgenv='s' AND g_cons_type='M') OR
          (g_diff_src=cs_after_cus_patch AND g_dgenv='c')) THEN 
         LET lc_flag = NULL
         IF (g_diff_src=cs_after_ind_patch AND g_dgenv='s' AND g_cons_type='M') THEN
            #判斷左側程式和右側程式是否相同:相同就表示可能要查看不同版次的程式差異.
            IF g_left_prog=g_right_prog THEN
               LET g_diff_src = cs_select_ver #SIMULATION:留著是為了防呆.
            ELSE
               #行業Patch後且同步後才有機會人工合併:adzp050已經有判斷,留著是為了防呆.
               SELECT dzaq010 INTO lc_flag FROM dzaq_t where dzaq001=g_right_prog
            END IF
         ELSE
            IF (g_diff_src=cs_after_cus_patch AND g_dgenv='c') THEN
               #判斷歸屬模組和目前模組是否相同:相同就表示可能要查看不同版次的程式差異.
               IF l_gzza003=g_right_module THEN
                  LET g_diff_src = cs_select_ver #SIMULATION:留著是為了防呆.
               ELSE
                  #客戶Patch後且merge後才有機會人工合併:adzp050已經有判斷,留著是為了防呆.
                  SELECT dzap010 INTO lc_flag FROM dzap_t where dzap001=g_right_prog
               END IF
            END IF
         END IF

         #Begin:SIMULATION:留著是為了防呆.
         IF g_diff_src=cs_select_ver THEN
            #Begin:160722-00008
            #INITIALIZE g_errparam TO NULL
            #LET g_errparam.code = "adz-00805" #溫馨提示 : 比較不同版次之間差異的功能尚未支持.
            #LET g_errparam.popup = TRUE
            #CALL cl_err()
            DISPLAY cl_getmsg("adz-00805", g_lang)
            #End:160722-00008
            EXIT PROGRAM
         END IF
         #End:SIMULATION

         IF cl_null(lc_flag) THEN
            LET gb_simulation = FALSE #沒有做過Patch就不需要做模擬合併.
         ELSE
            IF lc_flag='Y' THEN
               LET gb_simulation = FALSE #已經做過客製合併與行業同步就不需要做模擬合併.
               #Begin:160722-00008:已經沒有人工合併的功能.
               #IF g_right_auth='Y' THEN #表示有簽出.
               #   LET gb_enable_merge = TRUE
               #END IF
               #End:160722-00008
            END IF
         END IF
      END IF
      #End:SIMULATION
 
      #Begin:160722-00008:改成只有做過模擬合併的情境才可以打開edt_original.
      #IF gb_enable_merge THEN
      #   CALL cl_set_comp_visible("tbl_break,edt_original", TRUE)
      #ELSE
      #   #Begin:SIMULATION #只有FILE_DIFF和cs_before_imp才要隱藏edt_original.
      #   IF (g_diff_src<>cs_file_diff) OR (g_diff_src<>cs_before_imp) THEN #160627-00017:BEFORE_IMP #AND改OR
      #      CALL cl_set_comp_visible("edt_original", TRUE)
      #   END IF
      #   #End:SIMULATION
      #END IF
   
      IF gb_simulation THEN
         CALL cl_set_comp_visible("edt_original", TRUE)
      END IF
      #End:160722-00008
   END IF
END FUNCTION

#開始檔案比較.
FUNCTION adzq991_diff_start2(p_kind, p_left_file_path, p_right_file_path, p_diff_file_path)
   DEFINE p_kind            STRING, #比較種類:4gl/4fd
          p_left_file_path  STRING, #新版程式檔案路徑 #FILE
          p_right_file_path STRING, #舊版程式檔案路徑 #FILE
          p_diff_file_path  STRING  #diff檔路徑:$TEMPDIR底下 #FILE
   DEFINE la_left_file  T_FILE,
          la_right_file T_FILE
   DEFINE ls_err_msg STRING,
          ls_sql     STRING,
          li_idx     INTEGER 
   DEFINE la_diff          T_DIFF,
          la_diff_color    T_DIFF,
          la_diff_no       T_DIFF_NO,
          la_diff_no_color T_DIFF_NO, 
          la_break_temp    T_BREAK, #行業斷開add point行數清單
          la_break         T_BREAK, #將la_break_temp經過add point的順序重新排列過.
          la_break_color   T_BREAK, 
          la_multi_break   T_BREAK  #行業斷開add-point多行合併使用
   DEFINE ls_tempdir         STRING,
          ls_diff_file       STRING,   #執行shell之後所產生的diff檔案:需求單號_程式代號.類型+diff
          lb_result          BOOLEAN,
          ls_cmd             STRING,  #shell指令
          lch_diff           base.Channel,
          ls_line            STRING,
          ls_diff_info       STRING,  #為了取得比對資訊所保留的上一行字串
          lc_char            CHAR(1),
          lc_diff_flag       CHAR(1), #比對結果識別符號(a,c,d)
          li_flag_idx        INTEGER,
          li_n               INTEGER,
          ls_diff_left       STRING,  #比對結果左邊數字字串
          ls_diff_right      STRING,  #比對結果右邊數字字串
          li_left_from       INTEGER,#由數字字串拆解出來的左側差異起始行號
          li_left_to         INTEGER,#由數字字串拆解出來的左側差異截止行號
          li_left_cnt        INTEGER,#由數字字串拆解出來的左側差異行號數
          li_left_increment  INTEGER,#左邊遞增差異空白行的索引
          li_right_from      INTEGER,#由數字字串拆解出來的右側差異起始行號
          li_right_to        INTEGER,#由數字字串拆解出來的右側差異截止行號
          li_right_cnt       INTEGER,#由數字字串拆解出來的右側差異行號數
          li_right_increment INTEGER,#右邊遞增差異空白行的索引
          li_diff_c_cnt      INTEGER,#diff標示為c時, 要計算哪幾筆資料是要變黃色
          li_insert_idx      INTEGER,#插入索引值 
          li_update_idx      INTEGER,#異動索引值 
          li_no_idx          INTEGER #設定diff識別顏色的陣列索引值
   DEFINE ls_break_apt   STRING,
          json_break_apt util.JSONObject,
          li_i,li_d      INTEGER
   #Begin:OPTIMIZE
   DEFINE lb_line_is_diff BOOLEAN, #左右字串確實不相同
          lb_has_diff_no  BOOLEAN, #是否已經設置過diff_no
          ls_left_temp    STRING,
          ls_right_temp   STRING
   #End:OPTIMIZE
   #Begin:160818-00042
   DEFINE la_topstd_apt   DYNAMIC ARRAY OF RECORD
                          apt LIKE dzbb_t.dzbb002
                          END RECORD,
          json_topstd_apt util.JSONObject
   #End:160818-00042

   DISPLAY "p_left_file_path=",p_left_file_path
   CALL os.Path.exists(p_left_file_path) RETURNING lb_result
   IF lb_result THEN 
      DISPLAY "p_right_file_path=",p_right_file_path
      CALL os.Path.exists(p_right_file_path) RETURNING lb_result
      #Begin:MERGE
      IF NOT lb_result THEN
         LET ls_err_msg = p_right_file_path
      END IF
      #End:MERGE
   ELSE
      LET ls_err_msg = p_left_file_path #MERGE
   END IF 

   IF NOT lb_result THEN
      DISPLAY "INFO : 找不到上述檔案, 中斷比對."
      #Begin:160722-00008
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = "adz-00804" #找不到檔案 %1, 中斷比對.
      #LET g_errparam.replace[1] = ls_err_msg
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      DISPLAY cl_replace_err_msg(cl_getmsg("adz-00804", g_lang), ls_err_msg)
      #End:160722-00008
      RETURN la_diff,la_diff_color,la_diff_no,la_diff_no_color,la_break,la_break_color,la_multi_break
   END IF

   DISPLAY "p_diff_file_path=",p_diff_file_path
   CALL os.Path.delete(p_diff_file_path) RETURNING lb_result
   IF NOT lb_result THEN
      DISPLAY "INFO : 無法刪除 ",p_diff_file_path," !"
   ELSE
      DISPLAY "INFO : 刪除 ",p_diff_file_path," 成功!"
   END IF

   LET la_left_file = adzq991_get_file(p_left_file_path, p_kind)
   LET la_right_file = adzq991_get_file(p_right_file_path, p_kind)

   #DISPLAY p_kind,":la_left_file.getLength() 1=",la_left_file.getLength()
   #DISPLAY p_kind,":la_right_file.getLength() 1=",la_right_file.getLength()
   IF la_left_file.getLength()=0 OR la_right_file.getLength()=0 THEN
      DISPLAY "INFO : 程式內容是空的, 中斷比對."
      RETURN la_diff,la_diff_color,la_diff_no,la_diff_no_color,la_break,la_break_color,la_multi_break
   END IF

   INITIALIZE la_break_temp TO NULL
   IF g_diff_src<>cs_file_diff AND p_kind="4gl" THEN #FILE
      CALL adzq991_get_break_apt() RETURNING la_break_temp #取得客製/斷開add point清單.
   END IF

   #Begin:160818-00042:取得topstd有修改過的add point清單
   INITIALIZE la_topstd_apt TO NULL
   LET json_topstd_apt = util.JSONObject.create()
   IF g_has_topstd='Y' THEN
      #不需要判斷版次的原因在於topstd屬於標準段落, 而Patch的時候是將標準段落都覆蓋(刪除), 所以若有存在topstd就表示是最新的且未上過Patch的.
      LET ls_sql = "SELECT dzbb002 FROM dzbb_t",
                   " WHERE dzbb001='",g_right_prog CLIPPED,"'",
                   "   AND dzbb004='s'",
                   "   AND (   (LOWER(dzbbcrtid)='topstd' OR LOWER(dzbbcrtid)='topdev')", #201607的出貨片才將topstd對應的員工編號改成topstd,原本都是topdev.
                   "        OR (LOWER(dzbbmodid)='topstd' OR LOWER(dzbbmodid)='topdev'))", #160913-00057
                   " ORDER BY dzbb002"
      #display "start2 ls_sql=",ls_sql #todo
      PREPARE prep_dzbb5 FROM ls_sql
      DECLARE curs_dzbb5 CURSOR FOR prep_dzbb5
      LET li_idx = 1
      FOREACH curs_dzbb5 INTO la_topstd_apt[li_idx].*
         IF json_topstd_apt.get(la_topstd_apt[li_idx].apt) IS NULL THEN
            CALL json_topstd_apt.put(la_topstd_apt[li_idx].apt, li_idx)
         END IF

         LET li_idx = li_idx + 1
      END FOREACH
   END IF

   LET ls_sql = NULL
   LET li_idx = 0
   #End:160818-00042

   LET ls_cmd = "diff '",p_left_file_path,"' '",p_right_file_path,"' > '",p_diff_file_path,"'"
   DISPLAY ls_cmd
   RUN ls_cmd
    
   LET lch_diff = base.Channel.create()
   CALL lch_diff.openFile(p_diff_file_path, "r")
   LET li_no_idx = 1

   WHILE TRUE
      CALL lch_diff.readLine() RETURNING ls_line
      IF lch_diff.isEof() THEN
         EXIT WHILE
      END IF
 
      LET lc_char = ls_line.getCharAt(1)
      IF lc_char MATCHES "[0-9]" THEN
         LET ls_diff_info = ls_line

         #a : 表示右邊多餘左邊
         #c : 表示同一行開始左右內容不同,右邊多於左邊.
         #d : 表示左邊多於右邊
         
         LET lc_diff_flag = 'a'
         LET li_flag_idx = ls_diff_info.getIndexOf(lc_diff_flag, 1)
         IF li_flag_idx=0 THEN
            LET lc_diff_flag = 'c'
            LET li_flag_idx = ls_diff_info.getIndexOf(lc_diff_flag, 1)
         END IF
         IF li_flag_idx=0 THEN
            LET lc_diff_flag = 'd'
            LET li_flag_idx = ls_diff_info.getIndexOf(lc_diff_flag, 1)
         END IF
         IF li_flag_idx>0 THEN #到了這邊其實應該就找到了, 這只是防呆.
            #1.先處理左邊的數字.
            LET ls_diff_left = ls_diff_info.subString(1, li_flag_idx-1)
            CALL adzq991_get_diff_no(ls_diff_left) RETURNING li_left_from,li_left_to
            #2.再處理右邊的數字.
            LET ls_diff_right = ls_diff_info.subString(li_flag_idx+1, ls_diff_info.getLength())
            CALL adzq991_get_diff_no(ls_diff_right) RETURNING li_right_from,li_right_to
            LET li_left_cnt = li_left_to-li_left_from+1
            LET li_right_cnt = li_right_to-li_right_from+1

            CASE lc_diff_flag
               WHEN 'a'
                  LET lb_has_diff_no = TRUE #OPTIMIZE
                  LET la_diff_no[li_no_idx].left_no = li_left_from #紀錄左側原本的異常起始行數.
                  LET la_diff_no[li_no_idx].right_no = li_right_from #紀錄右側原本的異常起始行數.
                  LET la_diff_no[li_no_idx].no = li_left_from+li_left_increment+1 #紀錄左側異常的起始行數.
                  IF p_kind="4gl" THEN
                     #所屬add point/section都是以比較多那一側的資料為主.
                     LET la_diff_no[li_no_idx].belong_apt_desc = la_right_file[li_right_from].belong_apt_desc
                     LET la_diff_no[li_no_idx].belong_apt_name = la_right_file[li_right_from].belong_apt_name
                     LET la_diff_no[li_no_idx].belong_section  = la_right_file[li_right_from].belong_section
                  END IF

                  FOR li_n=1 TO li_right_cnt
                     LET li_insert_idx = li_left_from+li_left_increment+li_n
                     CALL la_left_file.insertElement(li_insert_idx) #左側檔案補上空白行
                     #空白行也補上對應的標示, 可讓畫面處理比較簡單.
                     IF p_kind="4gl" THEN
                        LET la_left_file[li_insert_idx].belong_apt_desc = la_right_file[li_insert_idx].belong_apt_desc
                        LET la_left_file[li_insert_idx].belong_apt_name = la_right_file[li_insert_idx].belong_apt_name
                        LET la_left_file[li_insert_idx].belong_section  = la_right_file[li_insert_idx].belong_section
                     END IF

                     LET la_left_file[li_insert_idx].diff = '+'
                  END FOR      

                  LET li_left_increment = li_left_increment + li_right_cnt #左側遞增行數
               WHEN 'c'
                  #只要是'c',則兩邊(from+遞增行數)所在的行數都設定diff='x'.
                  #先判斷左右兩側有幾筆資料是不需要補空白.
                  CASE
                     WHEN li_left_cnt>li_right_cnt
                        LET li_diff_c_cnt = li_right_cnt
                     WHEN li_left_cnt=li_right_cnt
                        LET li_diff_c_cnt = li_left_cnt
                     WHEN li_left_cnt<li_right_cnt
                        LET li_diff_c_cnt = li_left_cnt
                  END CASE
 
                  LET lb_has_diff_no = FALSE
                  LET li_n=0 #處理左右兩側不需要補空白的資料:第一筆是自己, 所以預設從0開始.
                  WHILE li_n<li_diff_c_cnt
                     LET li_update_idx = li_left_from+li_left_increment+li_n
                     #Begin:OPTIMIZE : 去除空白還有差異的, 才是真正有差異.
                     LET lb_line_is_diff = adzq991_line_is_diff(p_kind, la_left_file[li_update_idx].line, la_right_file[li_update_idx].line)
                     IF lb_line_is_diff THEN
                        IF NOT lb_has_diff_no THEN #這裡為FALSE, 表示前面的c所標示的差異, 去除空白後其實是相同的.
                           LET la_diff_no[li_no_idx].left_no = li_left_from #紀錄左側原本的異常起始行數.
                           LET la_diff_no[li_no_idx].right_no = li_right_from #紀錄右側原本的異常起始行數.
                           LET la_diff_no[li_no_idx].no = li_update_idx
                           IF p_kind="4gl" THEN
                              #所屬add point/section都是以比較多那一側的資料為主, 但這裡都可以.
                              LET la_diff_no[li_no_idx].belong_apt_desc = la_right_file[li_update_idx].belong_apt_desc
                              LET la_diff_no[li_no_idx].belong_apt_name = la_right_file[li_update_idx].belong_apt_name
                              LET la_diff_no[li_no_idx].belong_section  = la_right_file[li_update_idx].belong_section
                           END IF
                           
                           LET lb_has_diff_no = TRUE
                        END IF

                        LET la_left_file[li_update_idx].diff = 'x'
                        LET la_right_file[li_update_idx].diff = 'x'
                     END IF
                     #End:OPTIMIZE
                     LET li_n = li_n + 1
                  END WHILE
                  
                  #Begin:OPTIMIZE:改在上面一起處理.
                  #LET li_n=0 #處理右側不需要補空白的資料:第一筆是自己, 所以預設從0開始.
                  #WHILE li_n<li_diff_c_cnt
                  #   LET li_update_idx = li_right_from+li_right_increment+li_n
                  #   LET la_right_file[li_update_idx].diff = 'x'
                  #   LET li_n = li_n + 1
                  #END WHILE
                  #End:OPTIMIZE

                  #處理左側需要補空白的資料.
                  IF li_left_cnt<li_right_cnt THEN
                     FOR li_n=1 TO (li_right_cnt-li_left_cnt) #前面已經做完li_left_cnt的設定, 所以這裡要扣除.
                        LET li_insert_idx = li_left_to+li_left_increment+li_n
                        CALL la_left_file.insertElement(li_insert_idx) #左側檔案補上空白行
                        #Begin:OPTIMIZE
                        IF NOT lb_has_diff_no THEN
                           LET la_diff_no[li_no_idx].left_no = li_left_from #紀錄左側原本的異常起始行數.
                           LET la_diff_no[li_no_idx].right_no = li_right_from #紀錄右側原本的異常起始行數.
                           LET la_diff_no[li_no_idx].no = li_insert_idx
                           
                           LET la_diff_no[li_no_idx].belong_apt_desc = la_right_file[li_insert_idx].belong_apt_desc
                           LET la_diff_no[li_no_idx].belong_apt_name = la_right_file[li_insert_idx].belong_apt_name
                           LET la_diff_no[li_no_idx].belong_section  = la_right_file[li_insert_idx].belong_section
                           
                           LET lb_has_diff_no = TRUE
                        END IF
                        #End:OPTIMIZE
                        #空白行也補上對應的標示, 可讓畫面處理比較簡單.
                        IF p_kind="4gl" THEN
                           LET la_left_file[li_insert_idx].belong_apt_desc = la_right_file[li_insert_idx].belong_apt_desc
                           LET la_left_file[li_insert_idx].belong_apt_name = la_right_file[li_insert_idx].belong_apt_name
                           LET la_left_file[li_insert_idx].belong_section  = la_right_file[li_insert_idx].belong_section
                        END IF

                        LET la_left_file[li_insert_idx].diff = '+'
                     END FOR

                     LET li_left_increment = li_left_increment + (li_right_cnt-li_left_cnt) #左側遞增行數
                  END IF

                  #處理右側需要補空白的資料.
                  IF li_left_cnt>li_right_cnt THEN
                     FOR li_n=1 TO (li_left_cnt-li_right_cnt) ##前面已經做完li_right_cnt的設定, 所以這裡要扣除.
                        LET li_insert_idx = li_right_to+li_right_increment+li_n
                        CALL la_right_file.insertElement(li_insert_idx) #右側檔案補上空白行
                        #Begin:OPTIMIZE
                        IF NOT lb_has_diff_no THEN
                           LET la_diff_no[li_no_idx].left_no = li_left_from #紀錄左側原本的異常起始行數.
                           LET la_diff_no[li_no_idx].right_no = li_right_from #紀錄右側原本的異常起始行數.
                           LET la_diff_no[li_no_idx].no = li_insert_idx
                           
                           LET la_diff_no[li_no_idx].belong_apt_desc = la_left_file[li_insert_idx].belong_apt_desc
                           LET la_diff_no[li_no_idx].belong_apt_name = la_left_file[li_insert_idx].belong_apt_name
                           LET la_diff_no[li_no_idx].belong_section  = la_left_file[li_insert_idx].belong_section

                           LET lb_has_diff_no = TRUE
                        END IF
                        #End:OPTIMIZE
                        #空白行也補上對應的標示, 可讓畫面處理比較簡單.
                        IF p_kind="4gl" THEN
                           LET la_right_file[li_insert_idx].belong_apt_desc = la_left_file[li_insert_idx].belong_apt_desc
                           LET la_right_file[li_insert_idx].belong_apt_name = la_left_file[li_insert_idx].belong_apt_name
                           LET la_right_file[li_insert_idx].belong_section = la_left_file[li_insert_idx].belong_section
                        END IF

                        LET la_right_file[li_insert_idx].diff = '+'
                     END FOR      
                     
                     LET li_right_increment = li_right_increment + (li_left_cnt-li_right_cnt) #右側遞增行數
                  END IF
               WHEN 'd'
                  LET lb_has_diff_no = TRUE #OPTIMIZE
                  LET la_diff_no[li_no_idx].left_no = li_left_from #紀錄左側原本的異常起始行數.
                  LET la_diff_no[li_no_idx].right_no = li_right_from #紀錄右側原本的異常起始行數.
                  LET la_diff_no[li_no_idx].no = li_right_from+li_right_increment+1 #紀錄右側異常的起始行數.
                  IF p_kind="4gl" THEN
                     #所屬add point/section都是以比較多那一側的資料為主.
                     LET la_diff_no[li_no_idx].belong_apt_desc = la_left_file[li_left_from].belong_apt_desc
                     LET la_diff_no[li_no_idx].belong_apt_name = la_left_file[li_left_from].belong_apt_name
                     LET la_diff_no[li_no_idx].belong_section = la_left_file[li_left_from].belong_section
                  END IF

                  FOR li_n=1 TO li_left_cnt
                     LET li_insert_idx = li_right_from+li_right_increment+li_n
                     CALL la_right_file.insertElement(li_insert_idx) #右側檔案補上空白行
                     #空白行也補上對應的標示, 可讓畫面處理比較簡單.
                     IF p_kind="4gl" THEN
                        LET la_right_file[li_insert_idx].belong_apt_desc = la_left_file[li_insert_idx].belong_apt_desc
                        LET la_right_file[li_insert_idx].belong_apt_name = la_left_file[li_insert_idx].belong_apt_name
                        LET la_right_file[li_insert_idx].belong_section = la_left_file[li_insert_idx].belong_section
                     END IF

                     LET la_right_file[li_insert_idx].diff = '+'
                  END FOR      

                  LET li_right_increment = li_right_increment + li_left_cnt #右側遞增行數
            END CASE

            IF lb_has_diff_no THEN #OPTIMIZE
               LET li_no_idx = li_no_idx + 1
            END IF
         END IF #li_flag_idx>0
      END IF #lc_char MATCHES "[0-9]"
   END WHILE

   CALL lch_diff.close()

   #DISPLAY "li_left_increment=",li_left_increment
   #DISPLAY "li_right_increment=",li_right_increment
   #DISPLAY "la_left_file.getLength() 2=",la_left_file.getLength()
   #DISPLAY "la_right_file.getLength() 2=",la_right_file.getLength()

   LET json_break_apt = util.JSONObject.create()

   LET li_i = 1
   #將處理後的兩個陣列寫入la_diff內, 最後在adzq991_ui_dialog()內呈現.
   FOR li_n=1 TO la_right_file.getLength()
      LET la_diff[li_n].no = li_n
      LET la_diff[li_n].left = la_left_file[li_n].line
      LET la_diff[li_n].l_diff = la_left_file[li_n].diff
      LET la_diff[li_n].right = la_right_file[li_n].line
      LET la_diff[li_n].r_diff = la_right_file[li_n].diff
      LET la_diff[li_n].apt = la_right_file[li_n].belong_apt_name
      LET la_diff[li_n].orig = la_right_file[li_n].line
      IF p_kind="4gl" THEN
         #Begin:SIMULATION #忽略key的不同
         IF adzq991_is_line_key(la_diff[li_n].left) OR
            adzq991_is_line_key(la_diff[li_n].right) THEN
            LET la_diff[li_n].l_diff = NULL
            LET la_diff[li_n].r_diff = NULL
            LET la_diff[li_n].apt = NULL
            #若此行是key, 則清除原本設定的diff no.
            FOR li_d=1 TO la_diff_no.getLength()
               IF la_diff_no[li_d].no=li_n THEN
                  CALL la_diff_no.deleteElement(li_d)
                  EXIT FOR
               END IF
            END FOR
         END IF

         LET ls_break_apt = la_diff[li_n].apt
         #End:SIMULATION
         IF (ls_break_apt IS NOT NULL) THEN #break在此程式代表行業斷開或是已經客製.
            FOR li_idx=1 TO la_break_temp.getLength()
               IF la_break_temp[li_idx].break_apt=ls_break_apt THEN #行業Patch來說, 引用是以右側程式為主.
                  LET la_diff[li_n].cite = 'N'
                  #快速導覽只需要設定第一個add point與行數即可.
                  IF (la_diff[li_n].l_diff IS NOT NULL) AND (la_diff[li_n].r_diff IS NOT NULL) THEN #160722-00008
                     IF json_break_apt.get(ls_break_apt) IS NULL THEN
                        CALL json_break_apt.put(ls_break_apt, li_n)
                        LET la_break_temp[li_idx].break_no = li_n
                     END IF
                  END IF #(la_diff[li_n].l_diff IS NOT NULL) AND (la_diff[li_n].r_diff IS NOT NULL)
            
                  #這段是為了行業斷開的add-point多行合併使用.
                  LET la_multi_break[li_i].break_apt = ls_break_apt
                  LET la_multi_break[li_i].break_no = li_n
                  LET li_i = li_i + 1
            
                  EXIT FOR #找到就離開.
               END IF
            END FOR
         END IF #(ls_break_apt IS NOT NULL)
      END IF
   END FOR   
   
   #DISPLAY "la_diff.getLength()=",la_diff.getLength()

   IF p_kind="4gl" THEN
      INITIALIZE la_break TO NULL
      FOR li_idx=1 TO json_break_apt.getLength()
         LET la_break[li_idx].break_apt = json_break_apt.name(li_idx)
         LET la_break[li_idx].break_no = json_break_apt.get(json_break_apt.name(li_idx))
      END FOR
   END IF

   #設定diff結果的背景顏色:Y.淡黃色;+:淡綠色.
   FOR li_n=1 TO la_diff.getLength()
      LET la_diff_color[li_n].no = "lightGray reverse"
      IF p_kind="4gl" THEN 
         IF NOT cl_null(la_diff[li_n].apt) THEN #SIMULATION
            IF la_diff[li_n].cite='N' THEN #以cite來當作行業斷開和客製識別.
               #由於Genero目前無法同一個cell可以設定底色和前景色, 所以暫時就將'no'欄位底色設定為淡紅色.
               #LET la_diff_color[li_n].no = "lightRed reverse"
               LET la_diff_color[li_n].no = "magenta reverse" #160722-00008:避免和客製混淆,所以改成紫色.
            ELSE
               #Begin:SIMULATION #標準段落的程式都需要做模擬合併.
               IF g_diff_src=cs_only_query OR g_diff_src=cs_before_ind_patch OR gb_simulation THEN #SIMULATION
                  IF la_diff[li_n].r_diff='x' OR la_diff[li_n].r_diff='+' THEN
                     LET la_diff[li_n].right = la_diff[li_n].left
                     LET la_diff[li_n].merge = 'Y'
                  END IF
               END IF
               #End:SIMULATION
            END IF

            #Begin:160627-00017 : 客製環境下要特別標示topstd的差異.
            IF g_has_topstd='Y' THEN
               IF json_topstd_apt.get(la_diff[li_n].apt) THEN
                  LET la_diff_color[li_n].no = "lightRed reverse"
               END IF
            END IF
            #End:160627-00017
         END IF #NOT cl_null(la_diff[li_n].apt)
      END IF

      IF la_diff[li_n].l_diff='x' THEN
         LET la_diff_color[li_n].left = "yellow reverse"
      ELSE
         IF la_diff[li_n].l_diff='+' THEN
            LET la_diff_color[li_n].left = "lightGreen reverse"
         END IF
      END IF

      IF la_diff[li_n].r_diff='x' THEN
         LET la_diff_color[li_n].right = "yellow reverse"
      ELSE
         IF la_diff[li_n].r_diff='+' THEN
            LET la_diff_color[li_n].right = "lightGreen reverse"
         END IF
      END IF

      #Begin:SIMULATION #有模擬合併的行數強制換底色為紅色
      IF g_diff_src=cs_only_query OR g_diff_src=cs_before_ind_patch OR gb_simulation THEN #SIMULATION
         IF la_diff[li_n].merge='Y' THEN
            LET la_diff_color[li_n].right = "red" #為了要和合併的底色有區隔, 所以模擬合併改變前景色為紅色.
         END IF
      END IF
      #End:SIMULATION
   END FOR   

   IF la_diff_no.getLength()>0 THEN
      FOR li_n=1 TO la_diff_no.getLength()
         LET la_diff_no_color[li_n].no = "lightGray reverse"
         #Begin:160627-00017 : 客製環境下要特別標示topstd的差異.
         IF g_has_topstd='Y' THEN
            IF cl_null(la_diff_no[li_n].belong_apt_name) THEN
               LET la_diff_no_color[li_n].no = "lightRed" #若有差異的地方沒有add-point, 表示舊的樣版, 就將字體變成紅色來標示.
            ELSE
               IF json_topstd_apt.get(la_diff_no[li_n].belong_apt_name) THEN
                  LET la_diff_no_color[li_n].no = "lightRed reverse"
               END IF
            END IF
         END IF
         #End:160627-00017
      END FOR   
   ELSE
      LET la_diff_no[1].no = "No difference"
   END IF

   RETURN la_diff,la_diff_color,la_diff_no,la_diff_no_color,la_break,la_break_color,la_multi_break
END FUNCTION

#Begin:OPTIMIZE
#+ 逐行比較4gl程式, 判斷去除空白後是否不同.
FUNCTION adzq991_line_is_diff(p_kind, p_left, p_right)
   DEFINE p_kind  STRING,
          p_left  STRING,
          p_right STRING
   DEFINE lb_is_diff BOOLEAN
   DEFINE obj_left_attribute    util.JSONObject,
          obj_right_attribute   util.JSONObject,
          li_l_cnt,li_r_cnt     SMALLINT,
          li_l,li_r             INTEGER,
          ls_l_name,ls_r_name   STRING,
          ls_l_value,ls_r_value STRING

   LET lb_is_diff = FALSE
   LET p_left = p_left.trim()
   LET p_right = p_right.trim()
   IF p_left=p_right THEN
      LET lb_is_diff = FALSE #字串完全相同就是真的相同了
   ELSE #不同的話就繼續判斷4fd的屬性.
      #檢查4fd的屬性是否全部都相同:有不同才是真正的不同, 和順序無關
      IF p_kind="4gl" THEN
         IF p_left.getCharAt(1)='#' AND p_right.getCharAt(1)='#' THEN
            LET lb_is_diff = FALSE #若兩邊剛好都是註解, 就當作相同.
         ELSE
            LET lb_is_diff = TRUE #4gl字串不同就是真的不同.
         END IF
      ELSE #4fd字串不同, 有可能屬性其實是相同, 只是順序不同而已.
         LET obj_left_attribute = adzq991_parse_attribute(p_left)
         LET obj_right_attribute = adzq991_parse_attribute(p_right)

         LET li_l_cnt = obj_left_attribute.getLength()
         LET li_r_cnt = obj_right_attribute.getLength()
         IF li_l_cnt<>li_r_cnt THEN
            LET lb_is_diff = TRUE #屬性數量不同就一定不同.
         ELSE #屬性數量相同才繼續比較屬性是否有不同.
            #判斷左邊的屬性是否完全存在於右邊.
            FOR li_l=1 TO li_l_cnt
               LET ls_l_name = obj_left_attribute.name(li_l)
               IF NOT obj_right_attribute.has(ls_l_name) THEN
                  LET lb_is_diff = TRUE #左側屬性不存在於右側屬性.
                  EXIT FOR
               END IF
            END FOR

            IF NOT lb_is_diff THEN #表示左側屬性都存在於右側屬性.
               #繼續檢查右側屬性是否不存在於左側屬性.
               FOR li_r=1 TO li_r_cnt
                  LET ls_r_name = obj_right_attribute.name(li_r)
                  IF NOT obj_left_attribute.has(ls_r_name) THEN
                     LET lb_is_diff = TRUE #右側屬性不存在於左側屬性.
                     EXIT FOR
                  END IF
               END FOR
            END IF

            IF NOT lb_is_diff THEN #執行到這邊就表示左右兩側的屬性完全相同, 繼續檢查屬性值是否有不同.
               FOR li_l=1 TO li_l_cnt
                  LET ls_l_name = obj_left_attribute.name(li_l)
                  LET ls_l_value = obj_left_attribute.get(ls_l_name)
                  LET ls_r_value = obj_right_attribute.get(ls_l_name) #左右兩側的屬性名稱都相同, 所以這邊直接來比較兩邊屬性值即可.
                  IF ls_l_name<>"fieldIdRef" THEN #忽略fieldIdRef的差異
                     IF ls_l_value<>ls_r_value THEN
                        LET lb_is_diff = TRUE
                        EXIT FOR #確定屬性已經不同就離開迴圈.
                     END IF
                  ENd IF
               END FOR #li_l
            END IF #NOT lb_is_diff
         END IF #li_l_cnt<>li_r_cnt
      END IF #p_kind="4gl"
   END IF #p_left<>p_right

   RETURN lb_is_diff
END FUNCTION
#End:OPTIMIZE

#+ 取得比對雙方的程式內容陣列
FUNCTION adzq991_get_file(p_file_path, p_kind)
   DEFINE p_file_path STRING,
          p_kind      STRING
   DEFINE lch_file     base.Channel,
          ls_line      STRING,
          ls_lowercase STRING,
          la_file      T_FILE,
          li_idx       INTEGER
   DEFINE li_section_idx  INTEGER,
          li_identify_idx INTEGER,
          ls_section_id   STRING,
          li_apt_idx      INTEGER,
          ls_apt_desc     STRING,
          li_apt_name_idx INTEGER,
          ls_apt_name     STRING,
          li_end_idx      INTEGER
   #Begin:OTHER_FUNC
   DEFINE li_dot_idx         INTEGER,
          ls_line_trim       STRING,
          li_end_section_idx INTEGER,
          lb_other_func      BOOLEAN,
          lb_other_dialog    BOOLEAN,
          lb_other_report    BOOLEAN,
          li_increase_idx    INTEGER,
          ls_key_prev        STRING,
          li_f               INTEGER,
          la_func_no         DYNAMIC ARRAY OF INTEGER,
          li_f_no            INTEGER
   #End:OTHER_FUNC

   TRY
      #Begin:OTHER_FUNC
      LET lb_other_func = FALSE
      LET lb_other_dialog = FALSE
      LET lb_other_report = FALSE
      #End:OTHER_FUNC
      LET lch_file = base.Channel.create()
      CALL lch_file.openFile(p_file_path, "r")
      LET li_idx = 1
      
      WHILE TRUE
         LET ls_line = lch_file.readLine()
         IF lch_file.isEof() THEN
            EXIT WHILE
         END IF
         
         IF p_kind="4gl" THEN
            LET ls_line_trim = ls_line.trim() #OTHER_FUNC
            LET ls_lowercase = ls_line.toLowerCase()
            LET li_section_idx = ls_lowercase.getIndexOf("{<section id=", 1)
            IF li_section_idx>0 THEN
               LET li_section_idx = li_section_idx + 14 #包含字串'<section id="'的長度
               LET li_identify_idx = ls_line.getIndexOf("\"", li_section_idx)
               IF li_identify_idx>0 THEN
                  LET ls_section_id = ls_line.subString(li_section_idx, li_identify_idx-1)
                  LET ls_section_id = ls_section_id.trim()
                  #Begin:OTHER_FUNC:尋找$程式編號.other_function的section id.
                  LET li_dot_idx = ls_section_id.getIndexOf(".", 1)
                  IF li_dot_idx>0 THEN
                     #IF ls_section_id.subString(li_dot_idx+1, ls_section_id.getLength())="other_function" THEN #OTHER_FUNC
                     LET lb_other_func = (ls_section_id.subString(li_dot_idx+1, ls_section_id.getLength())="other_function")
                     IF NOT lb_other_func THEN
                        LET lb_other_dialog = (ls_section_id.subString(li_dot_idx+1, ls_section_id.getLength())="other_dialog")
                        IF NOT lb_other_dialog THEN
                           LET lb_other_report = (ls_section_id.subString(li_dot_idx+1, ls_section_id.getLength())="other_report")
                           IF lb_other_report THEN
                              #找到其中一種,就將另外兩種的flag還原.
                              LET lb_other_func = FALSE
                              LET lb_other_dialog = FALSE
                           END IF
                        ELSE
                           #找到其中一種,就將另外兩種的flag還原.
                           LET lb_other_func = FALSE
                           LET lb_other_report = FALSE
                        END IF
                     ELSE 
                        #找到其中一種,就將另外兩種的flag還原.
                        LET lb_other_dialog = FALSE
                        LET lb_other_report = FALSE
                     END IF
                  
                     IF lb_other_func OR lb_other_dialog OR lb_other_report THEN
                        LET ls_apt_name = NULL
                        LET la_file[li_idx].belong_apt_desc = NULL
                        LET la_file[li_idx].belong_apt_name = NULL
                        LET la_file[li_idx].belong_section = NULL
                        LET la_file[li_idx].line = ls_line
                        
                        LET li_idx = li_idx + 1 
                        CONTINUE WHILE
                     END IF
                  END IF #li_dot_idx>0
                  #End:OTHER_FUNC
               END IF #li_identify_idx>0
            ELSE
               #Begin:OTHER_FUNC
               LET li_end_section_idx = ls_lowercase.getIndexOf("{</section>}", 1)
               IF li_end_section_idx>0 THEN
                  LET lb_other_func = FALSE
                  LET lb_other_dialog = FALSE
                  LET lb_other_report = FALSE
                  LET ls_apt_desc = NULL
                  LET ls_apt_name = NULL
                  LET ls_section_id = NULL
            
                  IF cl_null(ls_apt_name) THEN
                     CALL la_func_no.clear()
                  END IF
            
                  LET la_file[li_idx].belong_apt_desc = NULL
                  LET la_file[li_idx].belong_apt_name = NULL
                  LET la_file[li_idx].belong_section = NULL
                  LET la_file[li_idx].line = ls_line

                  LET li_idx = li_idx + 1
                  CONTINUE WHILE
               END IF
               #End:OTHER_FUNC
            END IF #li_section_idx>0
            
            #Begin:OTHER_FUNC
            IF lb_other_func OR lb_other_dialog OR lb_other_report THEN #進入.other_function/.other_dialog/.other_report的範圍.
               IF cl_null(ls_apt_name) THEN #還沒找到function name.
                  LET ls_key_prev = ""
                  IF lb_other_func THEN
                     LET li_apt_idx = ls_lowercase.getIndexOf("function ", 1)
                     LET li_increase_idx = 9 #包含字串'function '的長度
                     LET ls_key_prev = "function"
                  ELSE
                     IF lb_other_dialog THEN
                        LET li_apt_idx = ls_lowercase.getIndexOf("dialog ", 1)
                        LET li_increase_idx = 7 #包含字串'dialog '的長度
                        LET ls_key_prev = "dialog"
                     ELSE
                        IF lb_other_report THEN
                           LET li_apt_idx = ls_lowercase.getIndexOf("report ", 1)
                           LET li_increase_idx = 7 #包含字串'report '的長度
                           LET ls_key_prev = "report"
                        END IF
                     END IF
                  END IF
            
                  IF li_apt_idx>0 THEN
                     LET li_apt_idx = li_apt_idx + li_increase_idx #OTHER_FUNC
                     LET li_apt_name_idx = ls_line.getIndexOf("(", li_apt_idx)
                     IF li_apt_name_idx>0 THEN
                        LET ls_apt_name = ls_line.subString(li_apt_idx, li_apt_name_idx-1)
                        LET ls_apt_name = ls_key_prev,".",ls_apt_name.trim()
            
                        #將function name之前的行數重新設定其add point.
                        FOR li_f=1 TO la_func_no.getLength()
                           LET li_f_no = la_func_no[li_f]
                           LET la_file[li_f_no].belong_apt_name = ls_apt_name
                        END FOR
                        CALL la_func_no.clear()
            
                        LET la_file[li_idx].line = ls_line
                        LET la_file[li_idx].belong_apt_name = ls_apt_name
                        LET la_file[li_idx].belong_section = ls_section_id
                        
                        LET li_idx = li_idx + 1
                        CONTINUE WHILE
                     END IF
                  END IF
            
                  #在還沒有找到function name前先記錄行數, 等找到function name之後, 這些行數都要重新設定其所屬add point
                  IF cl_null(ls_apt_name) THEN
                     LET la_func_no[la_func_no.getLength()+1] = li_idx
                  END IF
               ELSE #已經找到add point
                  IF lb_other_func THEN
                     LET li_end_idx = ls_lowercase.getIndexOf("end function", 1)
                  ELSE
                     IF lb_other_dialog THEN
                        LET li_end_idx = ls_lowercase.getIndexOf("end dialog", 1)
                     ELSE
                        IF lb_other_report THEN
                           LET li_end_idx = ls_lowercase.getIndexOf("end report", 1)
                        END IF
                     END IF
                  END IF
            
                  IF li_end_idx>0 THEN
                     #這邊的設定是為了最後初始化ls_apt_name而寫.
                     LET la_file[li_idx].line = ls_line
                     LET la_file[li_idx].belong_apt_name = ls_apt_name
                     LET la_file[li_idx].belong_section = ls_section_id
                     
                     LET ls_apt_name = NULL #初始化function name用以繼續找新的function完整範圍(包含函式說明).
                     LET li_idx = li_idx + 1
                     CONTINUE WHILE
                  END IF
               END IF
            ELSE
            #End:OTHER_FUNC
               LET li_apt_idx = ls_lowercase.getIndexOf("#add-point:", 1)
               IF li_apt_idx>0 THEN
                  LET li_apt_idx = li_apt_idx + 11 #包含字串'#add-point:'的長度
                  #Begin:OTHER_FUNC:為了讓解析更精準,所以ls_line改成用trim過的line來取得add-point名稱.
                  LET li_apt_name_idx = ls_line_trim.getIndexOf("name=", li_apt_idx)
                  IF li_apt_name_idx>0 THEN
                     LET ls_apt_desc = ls_line_trim.subString(li_apt_idx, li_apt_name_idx-1)
                     LET li_apt_name_idx = li_apt_name_idx + 5 #包含字串'name='的長度
                     LET ls_apt_name = ls_line_trim.subString(li_apt_name_idx+1, ls_line_trim.getLength()-1) #去除字串兩邊的雙引號(")
                     LET ls_apt_name = ls_apt_name.trim()
                  ELSE
                     LET ls_apt_desc = ls_line_trim.subString(li_apt_idx, ls_line_trim.getLength())
                  END IF
                  #End:OTHER_FUNC
               
                  #add-point標示本身是屬於SECTION的內容, 所以要剃除.
                  LET la_file[li_idx].belong_apt_desc = NULL
                  LET la_file[li_idx].belong_apt_name = NULL
                  LET la_file[li_idx].belong_section = NULL
                  LET la_file[li_idx].line = ls_line
                  LET li_idx = li_idx + 1 
                  CONTINUE WHILE
               ELSE
                  LET li_end_idx = ls_lowercase.getIndexOf("#end add-point", 1)
                  IF li_end_idx>0 THEN
                     LET ls_apt_desc = NULL
                     LET ls_apt_name = NULL
                     LET ls_section_id = NULL
                  END IF
               END IF 
            END IF
               
            LET la_file[li_idx].belong_apt_desc = ls_apt_desc
            LET la_file[li_idx].belong_apt_name = ls_apt_name
            LET la_file[li_idx].belong_section = ls_section_id
         END IF 

         LET la_file[li_idx].line = ls_line
         LET li_idx = li_idx + 1 
      END WHILE
      
      CALL lch_file.close()
   CATCH
      #Begin:160722-00008
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = "adz-00339" #%1檔案不存在.
      #LET g_errparam.replace[1] = p_file_path," " #空一格訊息比較清楚.
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      DISPLAY cl_replace_err_msg(cl_getmsg("adz-00339", g_lang), p_file_path)
      #End:160722-00008
   END TRY

   RETURN la_file
END FUNCTION

#Begin:SIMULATION
#+ 判斷是否為section/add-point這些key word
FUNCTION adzq991_is_line_key(p_line)
   DEFINE p_line STRING
   DEFINE lb_key BOOLEAN,
          li_idx SMALLINT

   LET li_idx = p_line.getIndexOf("{<section id=", 1)
   IF li_idx>0 THEN RETURN TRUE END IF
   LET li_idx = p_line.getIndexOf("{</section>}", 1)
   IF li_idx>0 THEN RETURN TRUE END IF
   LET li_idx = p_line.getIndexOf("#add-point:", 1)
   IF li_idx>0 THEN RETURN TRUE END IF
   LET li_idx = p_line.getIndexOf("#end add-point", 1)
   IF li_idx>0 THEN RETURN TRUE END IF
  
   RETURN FALSE
END FUNCTION
#End:SIMULATION

#+ 取得比對資訊的起迄差異行數
FUNCTION adzq991_get_diff_no(p_diff_info)
   DEFINE p_diff_info STRING
   DEFINE li_idx  INTEGER,
          li_from INTEGER,
          li_to   INTEGER

   #找看看有沒有逗號隔開的數字, 表示有多行差異.
   LET li_idx = p_diff_info.getIndexOf(',', 1)
   IF li_idx>0 THEN
      LET li_from = p_diff_info.subString(1, li_idx-1)
      LET li_to   = p_diff_info.subString(li_idx+1, p_diff_info.getLength())
   ELSE
      LET li_from = p_diff_info
      LET li_to   = p_diff_info
   END IF

   RETURN li_from,li_to
END FUNCTION

#+ 取得客製/斷開的add point清單
FUNCTION adzq991_get_break_apt()
   DEFINE ls_err_msg STRING,
          ls_sql     STRING,
          li_idx     INTEGER,
          la_break   T_BREAK

   #可合併清單以右側程式為主即可.
   CALL sadzp060_2_get_code_curr_revision(g_right_prog, g_cons_type, g_right_module) RETURNING g_dzaf004,g_dzaf010,ls_err_msg
   IF NOT cl_null(ls_err_msg) THEN
      RETURN
   END IF
   
   LET ls_sql = "SELECT dzba003,0 FROM dzba_t",
                " WHERE dzba001='",g_right_prog CLIPPED,"'",
                "   AND dzba002=",g_dzaf004
   IF g_dgenv='s' THEN
      IF (g_diff_src=cs_after_ind_patch OR g_diff_src=cs_before_ind_patch) THEN
         #取得行業的斷開add point清單.
         LET ls_sql = ls_sql,"   AND dzba007='N'"
         CALL adzq991_change_col_title("edt_merge_apt", "Break add point") #MERGE
      ELSE
         LET ls_sql = ls_sql," AND 1<>1" #正常的標準環境不需要斷開清單, 因此讓此SQL找不到任何行業斷開資料.
      END IF   
   ELSE #客製
      #取得客製add point清單.
      LET ls_sql = ls_sql," AND dzba005='c'"
      CALL adzq991_change_col_title("edt_merge_apt", "Customer add point") #MERGE
   END IF
   LET ls_sql = ls_sql,"   AND dzba010='",g_dzaf010 CLIPPED,"'"
   IF g_t100debug="9" THEN
      DISPLAY "可合併欄位SQL=",ls_sql
   END IF
   PREPARE prep_dzba2 FROM ls_sql
   DECLARE curs_dzba2 CURSOR FOR prep_dzba2
   LET li_idx = 1
   FOREACH curs_dzba2 INTO la_break[li_idx].*
      IF g_t100debug="9" THEN
         DISPLAY "可合併欄位=",la_break[li_idx].break_apt
      END IF
      LET li_idx = li_idx + 1
   END FOREACH
   CALL la_break.deleteElement(li_idx)

   RETURN la_break
END FUNCTION

#Begin:160627-00017
#+ 判斷是否為topstd的調整.
FUNCTION adzq991_modi_by_topstd(p_prog, p_apt_name)
   DEFINE p_prog     STRING,
          p_apt_name STRING
   DEFINE ls_sql STRING,
          li_cnt SMALLINT

   LET ls_sql = "SELECT COUNT(*) FROM dzbb_t",
                " WHERE dzbb001='",p_prog.trim(),"'",
                "   AND dzbb004='s'",
                "   AND (   (LOWER(dzbbcrtid)='topstd' OR LOWER(dzbbcrtid)='topdev')", #201607的出貨片才將topstd對應的員工編號改成topstd,原本都是topdev.
                "        OR (LOWER(dzbbmodid)='topstd' OR LOWER(dzbbmodid)='topdev'))" #160913-00057

   IF NOT cl_null(p_apt_name) THEN
      LET ls_sql = ls_sql,"   AND dzbb002='",p_apt_name.trim(),"'"
   END IF

   PREPARE dzbb_prep FROM ls_sql
   EXECUTE dzbb_prep INTO li_cnt
   FREE dzbb_prep

   RETURN (li_cnt>0)
END FUNCTION
#End:160627-00017

#+ 更新程式到資料庫
FUNCTION adzq991_update_apt(p_apt_name, p_apt)
   DEFINE p_apt_name LIKE dzbb_t.dzbb002,
          p_apt      LIKE dzbb_t.dzbb098
   DEFINE ls_where STRING,
          ls_sql   STRING,
          li_cnt   SMALLINT,
          ls_table STRING

   TRY
      DISPLAY "adzq991_update_apt:p_apt_name=",p_apt_name
      LET ls_table = "dzbb_t"
      #更新dzbb_t
      LET ls_where = " WHERE dzbb001='",g_right_prog,"' AND dzbb002='",p_apt_name,"' AND dzbb003=",g_dzaf004," AND dzbb004='",g_dzaf010,"'"
      LET ls_sql = "SELECT count(*) FROM dzbb_t",ls_where
      PREPARE dzbb_prep1 FROM ls_sql
      EXECUTE dzbb_prep1 INTO li_cnt
      FREE dzbb_prep1
      
      IF li_cnt>0 THEN #資料已存在.
         LET ls_sql = "UPDATE dzbb_t",
                        " SET dzbbmoddt=?,", 
                             "dzbbmodid='",g_user,"' ",ls_where
      ELSE
         LET ls_sql = "INSERT INTO dzbb_t(dzbb001,dzbb002,dzbb003,dzbb004,dzbb005,dzbb006,dzbb007,",
                                         "dzbbcrtdt,dzbbcrtdp,dzbbowndp,dzbbownid,dzbbstus,dzbbcrtid)",
                                 " VALUES('",g_right_prog,"','",p_apt_name,"',",g_dzaf004,",'",g_dzaf010,"','",g_customer,"','','',", 
                                         "?,'",g_dept,"','",g_dept,"','",g_user,"','Y','",g_user,"')"
      END IF
      PREPARE dzbb_prep2 FROM ls_sql
      EXECUTE dzbb_prep2 USING g_date
      FREE dzbb_prep2
      LET ls_sql = NULL      

      UPDATE dzbb_t 
         SET dzbb098=p_apt
       WHERE dzbb001=g_right_prog AND
             dzbb002=p_apt_name AND
             dzbb003=g_dzaf004 AND
             dzbb004=g_dzaf010 
      
      LET ls_table = "dzba_t"
      #Begin:160422-00026
      #更新dzba_t
      #UPDATE dzba_t
      #   SET dzba004=g_dzaf004,
      #       dzbamoddt=g_date, 
      #       dzbamodid=g_user
      # WHERE dzba001=g_right_prog
      #   AND dzba002=g_dzaf004
      #   AND dzba003=p_apt_name
      #   AND dzba010=g_dzaf010 

      LET ls_where = " WHERE dzba001='",g_right_prog,"' AND dzba002=",g_dzaf004," AND dzba003='",p_apt_name,"' AND dzba010='",g_dzaf010,"'"
      LET ls_sql = "SELECT count(*) FROM dzba_t",ls_where
      PREPARE dzba_prep1 FROM ls_sql
      EXECUTE dzba_prep1 INTO li_cnt
      FREE dzba_prep1
      
      IF li_cnt>0 THEN #資料已存在.
         LET ls_sql = "UPDATE dzba_t",
                        " SET dzba004=",g_dzaf004,",",
                             "dzba005='",g_dgenv,"',",
                             "dzba007='N',",
                             "dzbamoddt=?,", 
                             "dzbamodid='",g_user,"' ",ls_where
      ELSE
         LET ls_sql = "INSERT INTO dzba_t(dzba001,dzba002,dzba003,dzba004,dzba005,",
                                         "dzba006,dzba007,dzba008,dzba009,dzba010,dzba011,",
                                         "dzbacrtdt,dzbacrtdp,dzbaowndp,dzbaownid,dzbastus,dzbacrtid)",
                                 " VALUES('",g_right_prog,"',",g_dzaf004,",'",p_apt_name,"',",g_dzaf004,",'",g_dzaf010,"',", 
                                         "'','N','",g_erpver,"','','",g_dzaf010,"','",g_customer,"',",
                                         "?,'",g_dept,"','",g_dept,"','",g_user,"','Y','",g_user,"')"
      END IF
      PREPARE dzba_prep2 FROM ls_sql
      EXECUTE dzba_prep2 USING g_date
      FREE dzba_prep2
      LET ls_sql = NULL      
      #End:160422-00026

      RETURN TRUE
   CATCH
      DISPLAY "ls_sql=",ls_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00089" #更新表格%1失敗. %2
      LET g_errparam.replace[1] = ls_table
      LET g_errparam.replace[2] = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END TRY
END FUNCTION

#Begin:ATTRIBUTE
FUNCTION adzq991_chk_attribute(p_left_attribute, p_right_attribute)
   DEFINE p_left_attribute  STRING,
          p_right_attribute STRING
   DEFINE ls_key  STRING,
          li_idx  SMALLINT,
          lb_cont BOOLEAN

   #左右兩側若其中之一是結尾符號, 則不需要檢視屬性功能. 在BEFORE ROW控制enabled.
   LET p_left_attribute = p_left_attribute.trim()
   LET lb_cont = TRUE

   LET ls_key = p_left_attribute.subString(1,2)
   IF ls_key='</' THEN
      LET lb_cont = FALSE
   ELSE
      LET p_right_attribute = p_right_attribute.trim()   
      LET ls_key = p_left_attribute.subString(1,2)
      IF ls_key='</' THEN
         LET lb_cont = FALSE
      END IF
   END IF

   RETURN lb_cont
END FUNCTION
#End:ATTRIBUTE

#Begin:ATTRIBUTE
FUNCTION adzq991_get_attribute(p_left_attribute, p_right_attribute)
   DEFINE p_left_attribute  STRING,
          p_right_attribute STRING
   DEFINE obj_left_attribute  util.JSONObject,
          obj_right_attribute util.JSONObject,
          obj_all_attribute   util.JSONObject,
          ls_attribute        STRING,
          li_i                INTEGER
   DEFINE la_att       T_ATT,
          la_att_color T_ATT       

   LET p_left_attribute = p_left_attribute.trim()
   LET obj_left_attribute = adzq991_parse_attribute(p_left_attribute)
   LET p_right_attribute = p_right_attribute.trim()   
   LET obj_right_attribute = adzq991_parse_attribute(p_right_attribute)

   #合併左右兩邊的屬性.
   LET obj_all_attribute = util.JSONObject.create()
   FOR li_i=1 TO obj_left_attribute.getLength()
      CALL obj_all_attribute.put(obj_left_attribute.name(li_i), li_i) #這邊主要是name的設定, value設定沒有意義.
   END FOR

   FOR li_i=1 TO obj_right_attribute.getLength()
      LET ls_attribute = obj_right_attribute.name(li_i)
      IF NOT obj_all_attribute.has(ls_attribute) THEN #判斷是否不存在屬性.
         CALL obj_all_attribute.put(ls_attribute, obj_all_attribute.getLength())
      END IF
   END FOR

   #依據彙總的name再重新跑一次value的陣列設定.
   FOR li_i=1 TO obj_all_attribute.getLength()
      LET ls_attribute = obj_all_attribute.name(li_i)
      LET la_att[li_i].att = ls_attribute
      #同一個屬性有三種情境:1.左邊有,2.右邊有,3.兩邊都有
      IF obj_left_attribute.has(ls_attribute) THEN
         LET la_att[li_i].l_value = obj_left_attribute.get(ls_attribute)
         LET la_att[li_i].l_diff = 'x' #左邊有先預設和右邊不同.
         LET la_att_color[li_i].l_value = "yellow reverse"
      ELSE
         LET la_att[li_i].r_diff = '+' #左邊沒有就表示右邊一定有.
         LET la_att_color[li_i].r_value = "lightGreen reverse"
      END IF

      IF obj_right_attribute.has(ls_attribute) THEN
         LET la_att[li_i].r_value = obj_right_attribute.get(ls_attribute)
         LET la_att[li_i].r_diff = 'x' #右邊有先預設和左邊不同.
         LET la_att_color[li_i].r_value = "yellow reverse"
      ELSE
         LET la_att[li_i].l_diff = '+' #右邊沒有就表示左邊一定有.
         LET la_att_color[li_i].l_value = "lightGreen reverse"
      END IF

      #最後再判斷左右兩邊的value是否真的相同:覆寫r_diff和l_diff.
      IF NOT cl_null(la_att[li_i].l_value) AND
         NOT cl_null(la_att[li_i].r_value) THEN
         IF la_att[li_i].l_value=la_att[li_i].r_value THEN
            LET la_att[li_i].l_diff = ''   
            LET la_att[li_i].r_diff = ''   
            LET la_att_color[li_i].l_value = ""
            LET la_att_color[li_i].r_value = ""
         END IF
      END IF
   END FOR

   RETURN la_att,la_att_color
END FUNCTION
#End:ATTRIBUTE

#Begin:ATTRIBUTE
FUNCTION adzq991_parse_attribute(p_attribute)
   DEFINE p_attribute STRING
   DEFINE lc_slash CHAR(1),
          om_doc   om.DomDocument,
          om_node  om.DomNode,
          li_i     SMALLINT,
          obj_att  util.JSONObject

   LET obj_att = util.JSONObject.create() #至少回傳不會是NULL

   IF NOT cl_null(p_attribute) THEN
      LET p_attribute = p_attribute.trim()
      LET lc_slash = p_attribute.getCharAt(p_attribute.getLength()-1) #取得字串倒數第二個字元是否為'/'.
      IF lc_slash<>'\/' THEN
         #若倒數第二個字元不是'/',則要補上,這樣才是合法的xml格式.
         LET p_attribute = p_attribute.subString(1, p_attribute.getLength()-1)||'\/>'
      END IF

      LET om_doc = om.DomDocument.createFromString(p_attribute)
      IF om_doc IS NOT NULL THEN
         LET om_node = om_Doc.getDocumentElement()
         FOR li_i=1 TO om_node.getAttributesCount()
            CALL obj_att.put(om_node.getAttributeName(li_i), om_node.getAttributeValue(li_i))
         END FOR
      END IF
   END IF

   RETURN obj_att
END FUNCTION
#End:ATTRIBUTE

