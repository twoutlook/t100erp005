#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/27
#
#+ 程式代碼......: adzp064
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp064.4gl
# Description    : 標準與客製程式段相互還原作業
# Modify         : 2015/09/01 by Hiko : 修改清單殘留的問題.
#                : 2015/09/09 by Hiko : 清單改以客製為主,這樣可以避免標準add-point原本為NULL的情況而導致清單沒有列出的問題.
#                : 2015/09/11 by Hiko : 增加M/S類的section還原標準功能
#                : 161017-00009 20161017 by Hiko : 1.增加diff功能, 以協助追單.
#                                                  2.因為移除的控件比較多, 所以這些移除段落就直接刪除不保留, 以免程式過於混亂.
#                                                  3.移除'標準還原客製選項'.
#                               20161125 by Hiko : 隱藏:多選,取消多選,補缺漏,還原缺漏.                     
#                               20161129 by Hiko : 隱藏:功能選項(gs_option),改成用Button來處理'還原標準'即可.                    
#                               20161202 by Hiko : 1.清單有修改時會變成紅色,並且會有'*';還原的時候得考慮這個部分,所以暫時取消'還原取代'功能.       
#                                                  2.chk_sel改成Edit控件,改用來標示是否有修改(*)             

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"

TYPE T_LIST DYNAMIC ARRAY OF RECORD
            sel         LIKE type_t.chr1,    #20161202:改用來標示是否有修改(*).
            revert_std  LIKE type_t.chr1,    #建議還原標準
            done_std    LIKE type_t.chr1,    #真的執行'客製還原標準'
            name        LIKE dzba_t.dzba003, #add-point/section名稱
            diff_sc     LIKE type_t.chr1,    #標準與客製內容有差異
            diff_ss     LIKE type_t.chr1,    #Patch前後的標準內容有差異 #todo : 暫時隱藏
            std_ver     LIKE dzba_t.dzba004, #標準識別碼版次
            std_flag    LIKE dzba_t.dzba009, #標準'下方的硬結構代碼整段註解',或'使用標示'.
            std_content LIKE dzbb_t.dzbb098, #標準內容
            cus_ver     LIKE dzba_t.dzba004, #客製識別碼版次
            cus_flag    LIKE dzba_t.dzba009, #客製'下方的硬結構代碼整段註解',或'使用標示'.
            cus_content LIKE dzbb_t.dzbb098  #客製內容
            END RECORD

TYPE T_DIFF_4gl DYNAMIC ARRAY OF RECORD
            no         STRING, #為了變顏色,所以改成字串型態.
            sel        LIKE type_t.chr1,
            left       STRING,
            l_diff     CHAR(1),#+:左邊多的;x:左右不同
            right      STRING,
            r_diff     CHAR(1),#+:右邊多的;x:左右不同
            identifier STRING, #add-point/section
            fill_gap   CHAR(1),#補缺漏:Y #20161125:隱藏:補缺漏功能.
            orig_line  STRING  #單行複製:舊資料
            END RECORD

TYPE T_DIFF_NO DYNAMIC ARRAY OF RECORD
               diff_no  STRING, #差異行號
               left_no  INTEGER,#來源實際行號
               right_no INTEGER #目標實際行號
               END RECORD

DEFINE g_prog        LIKE dzaf_t.dzaf001, #程式代號 
       g_cons_type   LIKE dzaf_t.dzaf005, #建構類型 
       g_std_dzaf004 LIKE dzaf_t.dzaf004, #標準程式版次
       g_cus_dzaf004 LIKE dzaf_t.dzaf004, #客製程式版次
       gb_auth       BOOLEAN

DEFINE g_date    DATETIME YEAR TO SECOND,
       g_tempdir STRING,
       g_dgenv   LIKE dzba_t.dzba010,
       g_cust    LIKE dzba_t.dzba011

DEFINE ga_apt_lst           T_LIST, 
       ga_apt_lst_color     T_LIST,
       g_jobj_apt_a         util.JSONObject,
       ga_section_lst       T_LIST, 
       ga_section_lst_color T_LIST, 
       g_jobj_section_a     util.JSONObject 

CONSTANT cs_apt = "add-point"
CONSTANT cs_section = "section"        
CONSTANT cs_append_line = "append_line"
CONSTANT cs_modify_line = "modify_line"
CONSTANT cs_delete_line = "delete_line"
CONSTANT cs_do_copy_line = "do_copy_line"
CONSTANT cs_no_copy_line = "no_copy_line"
CONSTANT cs_digiwin = "DIGIWIN"        

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING,
          ls_4ad_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    

   CALL cl_tool_init()

   LET g_dgenv = FGL_GETENV("DGENV") CLIPPED

   IF g_dgenv="s" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00644" #'客製還原與協助追單工具'僅限定在客製環境使用.
      LET g_errparam.popup = TRUE
      CALL cl_err()
      EXIT PROGRAM 
   END IF

   OPEN WINDOW w_adzp064 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   #CALL cl_load_4ad_interface(NULL) #為了改寫Enter的功能,所以改用自己的4ad.
   
   LET ls_4ad_path = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("ADZ"), "4ad"), g_lang), g_code||".4ad")
   CALL ui.Interface.loadActionDefaults(ls_4ad_path) #解決control-f與正常顯現開窗的圖示.

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_leftogo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET g_date = cl_get_current()
   LET g_tempdir = FGL_GETENV("TEMPDIR") CLIPPED
   LET g_cust = FGL_GETENV("CUST") CLIPPED

   CALL adzp064_ui_dialog() 

   #Begin:2015/09/11 by Hiko:最後再次提醒.
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = "adz-00698" #再次提醒 : 異動更新後請記得要重新下載程式,以查看完整程式是否正確.
   LET g_errparam.popup = TRUE
   CALL cl_err()
   #End:2015/09/11 by Hiko

   CLOSE WINDOW w_adzp064 
END MAIN

PRIVATE FUNCTION adzp064_ui_dialog()
   DEFINE lb_continue             BOOLEAN,
          ls_err_msg              STRING, 
          lo_dzaf_t               T_DZAF_T,
          ls_replace_str          STRING,
          lb_has_apt_lst          BOOLEAN,
          lb_has_section_lst      BOOLEAN,
          ls_apt_a_left_path      STRING, #a情境:比對前合併左側add-point所有內容之後的檔案路徑.
          ls_apt_a_right_path     STRING, #a情境:比對前合併右側add-point所有內容之後的檔案路徑.
          ls_apt_a_diff_path      STRING, #a情境:比對add-point後的結果檔案路徑.
          ls_section_a_left_path  STRING, #a情境:比對前合併左側section所有內容之後的檔案路徑.
          ls_section_a_right_path STRING, #a情境:比對前合併右側section所有內容之後的檔案路徑.
          ls_section_a_diff_path  STRING, #a情境:比對section後的結果檔案路徑.
          ls_apt_name             STRING,
          ls_section_name         STRING,
          jarr_apt_a              util.JSONArray,
          jarr_apt_a_color        util.JSONArray,
          jarr_apt_a_diff_no      util.JSONArray,
          la_apt_a                T_DIFF_4gl,
          la_apt_a_color          T_DIFF_4gl,
          la_apt_a_diff_no        T_DIFF_NO,
          la_apt_a_temp_no        T_DIFF_NO,
          li_apt_a_curr           INTEGER,
          ls_apt_a_curr_name      STRING,    
          jarr_section_a          util.JSONArray,
          jarr_section_a_color    util.JSONArray,
          jarr_section_a_diff_no  util.JSONArray,
          la_section_a            T_DIFF_4gl,
          la_section_a_color      T_DIFF_4gl,
          la_section_a_diff_no    T_DIFF_NO,
          la_section_a_temp_no    T_DIFF_NO,
          li_section_a_curr       INTEGER, 
          ls_section_a_curr_name  STRING,    
          li_curr                 INTEGER,
          li_curr2                INTEGER,
          li_i                    INTEGER,
          lc_diff                 CHAR(1) 
          
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT g_prog FROM txt_prog ATTRIBUTE(WITHOUT DEFAULTS)
            ON ACTION controlp INFIELD txt_prog
               LET lb_continue = TRUE
               IF ga_apt_lst.getLength()>0 THEN
                  IF NOT cl_ask_confirm("adz-00939") THEN #此動作會清空目前所做的任何異動, 若要保存異動結果, 麻煩請先更新到資料庫. 請問是否要繼續執行?
                     LET lb_continue = FALSE
                  END IF
               END IF

               IF lb_continue THEN
                  LET g_prog = ""
                  LET g_cons_type = ""
                  LET g_std_dzaf004 = NULL
                  LET g_cus_dzaf004 = NULL
                  DISPLAY '','' TO edt_std_dzaf004,edt_cus_dzaf004
                  DISPLAY "" TO lbl_check_out_info
                  CALL ga_apt_lst.clear()
                  CALL ga_apt_lst_color.clear()
                  CALL ga_section_lst.clear()
                  CALL ga_section_lst_color.clear()
                  LET lb_has_apt_lst = FALSE
                  LET lb_has_section_lst = FALSE
                  CALL la_apt_a.clear()
                  CALL la_apt_a_color.clear()
                  CALL la_apt_a_diff_no.clear()
                  CALL la_apt_a_temp_no.clear()
                  CALL la_section_a.clear()
                  CALL la_section_a_color.clear()
                  CALL la_section_a_diff_no.clear()
                  CALL la_section_a_temp_no.clear()
                  
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = ""
                  
                  CALL q_dzaf001_1()
                  LET g_prog = g_qryparam.return1
                  LET g_cons_type = g_qryparam.return2
                  
                  #取得最新標準程式版次.
                  LET lo_dzaf_t.dzaf001 = g_prog
                  LET lo_dzaf_t.dzaf005 = g_cons_type
                  
                  LET lo_dzaf_t.dzaf010 = "s"
                  CALL sadzp200_ver_get_max_pr_version(lo_dzaf_t.*) RETURNING g_std_dzaf004
                  
                  #取得最新客製程式版次.
                  LET lo_dzaf_t.dzaf010 = "c"
                  CALL sadzp200_ver_get_max_pr_version(lo_dzaf_t.*) RETURNING g_cus_dzaf004
                  
                  DISPLAY g_std_dzaf004,g_cus_dzaf004 TO edt_std_dzaf004,edt_cus_dzaf004
                     
                  #順便檢查是否有程式簽出權限.
                  LET gb_auth = TRUE
                  CALL sadzp060_2_have_checked_out(g_prog, g_cons_type, "PR", 0) RETURNING ls_err_msg
                  IF NOT cl_null(ls_err_msg) THEN
                     LET gb_auth = FALSE
                     LET ls_err_msg = cl_getmsg("adz-00827", g_lang) #您還沒有簽出程式!
                  ELSE
                     LET ls_err_msg = cl_getmsg("adz-00831", g_lang) #您具有異動程式的權限!
                  END IF
                  
                  DISPLAY ls_err_msg TO lbl_check_out_info
               END IF

            ON ACTION btn_get_lst
               LET lb_continue = TRUE
               IF ga_apt_lst.getLength()>0 THEN
                  IF NOT cl_ask_confirm("adz-00786") THEN #此動作會刷新所做的任何異動, 請問是否要重新比對?
                     LET lb_continue = FALSE
                  END IF
               END IF

               IF lb_continue THEN
                  LET g_jobj_apt_a = util.JSONObject.create()
                  LET g_jobj_section_a = util.JSONObject.create()
                  CALL ga_apt_lst.clear()
                  CALL ga_apt_lst_color.clear()
                  CALL ga_section_lst.clear()
                  CALL ga_section_lst_color.clear()
                  LET lb_has_apt_lst = FALSE
                  LET lb_has_section_lst = FALSE
                  LET ls_replace_str = ""
                  
                  IF NOT cl_null(g_prog) THEN
                     #取得add-point清單.
                     CALL adzp064_prepare_apt_lst()
                     IF ga_apt_lst.getLength()>0 THEN
                        LET lb_has_apt_lst = TRUE
                     ELSE
                        LET ls_replace_str = "add-point"
                     END IF
                  
                     { #todo:暫時先提供add-point的比較.
                     #取得section清單:只有M/S類的程式才有section調整功能.
                     IF g_cons_type="M" OR g_cons_type="S" THEN
                        CALL adzp064_prepare_section_lst()
                        IF ga_section_lst.getLength()>0 THEN
                           LET lb_has_section_lst = TRUE
                        ELSE
                           IF NOT cl_null(ls_replace_str) THEN
                              LET ls_replace_str = ls_replace_str,","
                           END IF
                        
                           LET ls_replace_str = ls_replace_str,"section"
                        END IF
                     END IF
                     }
                  
                     #組合檔案路徑: 
                     #1.左側檔名為 : $程式編號_$還原選項_apt_left.4gl
                     #2.右側檔名為 : $程式編號_$還原選項_apt_right.4gl
                     #3.比對結果檔名為 : $程式編號_$還原選項_diff_apt.4gl.diff
                     
                     IF lb_has_apt_lst THEN
                        LET ls_apt_a_left_path = os.path.join(g_tempdir, g_prog||"_apt_a_left.4gl")
                        LET ls_apt_a_right_path = os.path.join(g_tempdir, g_prog||"_apt_a_right.4gl")
                        LET ls_apt_a_diff_path = os.path.join(g_tempdir, g_prog||"_diff_apt_a.4gl.diff")
                        
                        #todo : 情境2第二階段實施
                        #LET ls_apt_b_left_path = os.path.join(g_tempdir, g_prog||"_apt_b_left.4gl")
                        #LET ls_apt_b_right_path = os.path.join(g_tempdir, g_prog||"_apt_b_right.4gl")
                        #LET ls_apt_b_diff_path = os.path.join(g_tempdir, g_prog||"_diff_apt_b.4gl.diff")
                  
                        CALL adzp064_merge_content_to_file(ga_apt_lst, ls_apt_a_left_path, ls_apt_a_right_path)
                        CALL sadzp064_diff_4gl(ls_apt_a_left_path, ls_apt_a_right_path, ls_apt_a_diff_path) RETURNING g_jobj_apt_a
                        #設定:建議改成標準.
                        FOR li_i=1 TO ga_apt_lst.getLength()
                           LET lc_diff = g_jobj_apt_a.get(ga_apt_lst[li_i].name||"_diff")
                           IF lc_diff='N' THEN
                              LET ga_apt_lst[li_i].revert_std = 'Y'
                           END IF
                        END FOR
                     END IF
                  
                     IF lb_has_section_lst THEN
                        LET ls_section_a_left_path = os.path.join(g_tempdir, g_prog||"_section_a_left.4gl")
                        LET ls_section_a_right_path = os.path.join(g_tempdir, g_prog||"_section_a_right.4gl")
                        LET ls_section_a_diff_path = os.path.join(g_tempdir, g_prog||"_diff_section_a.4gl.diff")
                        
                        #todo : 情境2第二階段實施
                        #LET ls_section_b_left_path = os.path.join(g_tempdir, g_prog||"_section_b_left.4gl")
                        #LET ls_section_b_right_path = os.path.join(g_tempdir, g_prog||"_section_b_right.4gl")
                        #LET ls_section_b_diff_path = os.path.join(g_tempdir, g_prog||"_diff_section_b.4gl.diff")
                        #End:20161129
                        
                        CALL adzp064_merge_content_to_file(ga_section_lst, ls_section_a_left_path, ls_section_a_right_path)
                        CALL sadzp064_diff_4gl(ls_section_a_left_path, ls_section_a_right_path, ls_section_a_diff_path) RETURNING g_jobj_section_a
                        #設定:建議改成標準.
                        FOR li_i=1 TO ga_section_lst.getLength()
                           LET lc_diff = g_jobj_section_a.get(ga_section_lst[li_i].name||"_diff")
                           IF lc_diff='N' THEN
                              LET ga_section_lst[li_i].revert_std = 'Y'
                           END IF
                        END FOR
                     END IF
                  
                     IF NOT cl_null(ls_replace_str) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "adz-00938" #找不到符合條件的客製 %1 清單,所以不需要處理 %1.
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = ls_replace_str
                        CALL cl_err()
                     END IF
                  END IF
               END IF
         END INPUT

         #----------add-point處理區域----------#
         DISPLAY ARRAY ga_apt_lst TO s_detail1.*
            BEFORE DISPLAY
               CALL DIALOG.setArrayAttributes("s_detail1", ga_apt_lst_color)
               CALL DIALOG.setActionActive("btn_edit", FALSE)
               CALL DIALOG.setActionActive("btn_update", FALSE)
               CALL DIALOG.setActionActive("btn_cus_revert_std", FALSE)

            BEFORE ROW
               CALL la_apt_a.clear()
               CALL la_apt_a_color.clear()
               CALL la_apt_a_diff_no.clear()
               CALL la_apt_a_temp_no.clear()
               LET li_curr = 0
               LET ls_apt_name = ""
               LET ls_apt_a_curr_name = ""
               LET li_apt_a_curr = 0
               CALL DIALOG.setActionActive("btn_edit", FALSE)
               CALL DIALOG.setActionActive("btn_update", FALSE)
               CALL DIALOG.setActionActive("btn_cus_revert_std", FALSE)

               IF ga_apt_lst.getLength()>0 THEN
                  LET li_curr = ARR_CURR()
                  LET ls_apt_name = ga_apt_lst[li_curr].name
                  LET ls_apt_a_curr_name = ls_apt_name||"_curr_row"
                  IF g_jobj_apt_a.has(ls_apt_name) THEN
                     LET jarr_apt_a = g_jobj_apt_a.get(ls_apt_name)
                     CALL jarr_apt_a.toFGL(la_apt_a)
                     LET jarr_apt_a_color = g_jobj_apt_a.get(ls_apt_name||"_color")
                     CALL jarr_apt_a_color.toFGL(la_apt_a_color)
                     IF g_jobj_apt_a.has(ls_apt_name||"_diff_no") THEN #有可能沒有差異, 所以這邊要特別防呆.
                        LET jarr_apt_a_diff_no = g_jobj_apt_a.get(ls_apt_name||"_diff_no")
                        CALL jarr_apt_a_diff_no.toFGL(la_apt_a_diff_no)
                     END IF
    
                     IF g_jobj_apt_a.has(ls_apt_name||"_temp_no") THEN #有可能沒有差異, 所以這邊要特別防呆.
                        LET jarr_apt_a_diff_no = g_jobj_apt_a.get(ls_apt_name||"_temp_no")
                        CALL jarr_apt_a_diff_no.toFGL(la_apt_a_temp_no)
                     END IF

                     IF g_jobj_apt_a.has(ls_apt_a_curr_name) THEN
                        LET li_apt_a_curr = g_jobj_apt_a.get(ls_apt_a_curr_name)
                     END IF

                     #僅客製add-point才可以編輯程式,更新資料與還原標準.
                     IF gb_auth AND 
                       ((NOT cl_null(ga_apt_lst[li_curr].done_std)) AND
                        (ga_apt_lst[li_curr].done_std<>'Y')) THEN
                        CALL DIALOG.setActionActive("btn_edit", TRUE )
                        CALL DIALOG.setActionActive("btn_update", TRUE )
                        CALL DIALOG.setActionActive("btn_cus_revert_std", TRUE)
                     END IF
                  END IF
               END IF
         
            #編輯add-point內容.
            ON ACTION btn_edit
               IF g_jobj_apt_a.has(ls_apt_a_curr_name) THEN
                  LET li_apt_a_curr = g_jobj_apt_a.get(ls_apt_a_curr_name)
               ELSE
                  LET li_apt_a_curr = 1 #這是為了setCurrRow防呆.
               END IF

               CALL adzp064_apt_a_input(li_curr, ls_apt_name, la_apt_a, la_apt_a_color, la_apt_a_diff_no, la_apt_a_temp_no, li_apt_a_curr) RETURNING li_apt_a_curr
               CALL DIALOG.setCurrentRow("s_detail1_1", li_apt_a_curr) #讓編輯畫面看起來比較正常.
               CALL g_jobj_apt_a.put(ls_apt_a_curr_name, li_apt_a_curr)

            #將最新客製add-point內容更新到資料庫.
            ON ACTION btn_update
               IF adzp064_update_to_db(cs_apt, ga_apt_lst, li_curr, la_apt_a) THEN
                  #識別碼標示為'未修改'.
                  LET ga_apt_lst[li_curr].sel = ''
                  #識別碼名稱顏色維持原狀.
               END IF

            #執行客製add-point還原標準.
            ON ACTION btn_cus_revert_std
               IF adzp064_cus_revert_std(cs_apt, ga_apt_lst, ga_apt_lst_color, g_jobj_apt_a, la_apt_a, la_apt_a_color, li_curr, la_apt_a_diff_no) THEN
                  #識別碼標示為'未修改'.
                  LET ga_apt_lst[li_curr].sel = ''
                  #識別碼名稱變成紅色.
                  LET ga_apt_lst_color[li_curr].name = "red"
                  #只有客製add-point才可以進行異動.
                  CALL DIALOG.setActionActive("btn_edit", FALSE)
                  CALL DIALOG.setActionActive("btn_update", FALSE)
                  CALL DIALOG.setActionActive("btn_cus_revert_std", FALSE)
               END IF

         END DISPLAY
          
         DISPLAY ARRAY la_apt_a TO s_detail1_1.*
            BEFORE ROW
               LET li_apt_a_curr = ARR_CURR()
               CALL g_jobj_apt_a.put(ls_apt_a_curr_name, li_apt_a_curr) #為了下次再度進入編輯狀態的時候,可以預設正確的編輯行數.

            BEFORE DISPLAY
               CALL DIALOG.setArrayAttributes("s_detail1_1", la_apt_a_color)

            #編輯add-point內容. #for doubleClick
            ON ACTION btn_edit
               CALL adzp064_apt_a_input(li_curr, ls_apt_name, la_apt_a, la_apt_a_color, la_apt_a_diff_no, la_apt_a_temp_no, li_apt_a_curr) RETURNING li_apt_a_curr
               CALL DIALOG.setCurrentRow("s_detail1_1", li_apt_a_curr) #讓編輯畫面看起來比較正常.
               CALL g_jobj_apt_a.put(ls_apt_a_curr_name, li_apt_a_curr)

               IF g_action_choice="exit" THEN
                  EXIT DIALOG
               END IF

         END DISPLAY

         #呈現add-point標準與客製的差異起始行數.
         DISPLAY ARRAY la_apt_a_diff_no TO s_detail1_1_no.*
            BEFORE ROW
               CALL DIALOG.setCurrentRow("s_detail1_1", la_apt_a_diff_no[ARR_CURR()].diff_no)
         END DISPLAY

         #----------section處理區域----------#
         DISPLAY ARRAY ga_section_lst TO s_detail2.*
            BEFORE DISPLAY
               CALL DIALOG.setArrayAttributes("s_detail2", ga_section_lst_color)
               CALL DIALOG.setActionActive("btn_edit2", FALSE)
               CALL DIALOG.setActionActive("btn_update2", FALSE)
               CALL DIALOG.setActionActive("btn_cus_revert_std2", FALSE)

            BEFORE ROW
               CALL la_section_a.clear()
               CALL la_section_a_color.clear()
               CALL la_section_a_diff_no.clear()
               CALL la_section_a_temp_no.clear()
               LET li_curr2 = 0
               LET ls_section_name = ""
               LET ls_section_a_curr_name = ""
               LET li_section_a_curr = 0
               CALL DIALOG.setActionActive("btn_edit2", FALSE)
               CALL DIALOG.setActionActive("btn_update2", FALSE)
               CALL DIALOG.setActionActive("btn_cus_revert_std2", FALSE)

               IF ga_section_lst.getLength()>0 THEN
                  LET li_curr2 = ARR_CURR()
                  LET ls_section_name = ga_section_lst[li_curr2].name
                  LET ls_section_a_curr_name = ls_section_name||"_curr_row"
                  IF g_jobj_section_a.has(ls_section_name) THEN
                     LET jarr_section_a = g_jobj_section_a.get(ls_section_name)
                     CALL jarr_section_a.toFGL(la_section_a)
                     LET jarr_section_a_color = g_jobj_section_a.get(ls_section_name||"_color")
                     CALL jarr_section_a_color.toFGL(la_section_a_color)
                     IF g_jobj_section_a.has(ls_section_name||"_diff_no") THEN #有可能沒有差異, 所以這邊要特別防呆.
                        LET jarr_section_a_diff_no = g_jobj_section_a.get(ls_section_name||"_diff_no")
                        CALL jarr_section_a_diff_no.toFGL(la_section_a_diff_no)
                     END IF

                     IF g_jobj_section_a.has(ls_section_name||"_temp_no") THEN #有可能沒有差異, 所以這邊要特別防呆.
                        LET jarr_section_a_diff_no = g_jobj_section_a.get(ls_section_name||"_temp_no")
                        CALL jarr_section_a_diff_no.toFGL(la_section_a_temp_no)
                     END IF

                     IF g_jobj_section_a.has(ls_section_a_curr_name) THEN
                        LET li_section_a_curr = g_jobj_section_a.get(ls_section_a_curr_name)
                     END IF

                     #只有M/S類的程式才有section相關功能.
                     IF g_cons_type="M" OR g_cons_type="S" THEN
                        #僅客製add-point才可以編輯程式,更新資料與還原標準.
                        IF gb_auth AND 
                          ((NOT cl_null(ga_section_lst[li_curr2].done_std)) AND
                           (ga_section_lst[li_curr2].done_std<>'Y')) THEN
                           CALL DIALOG.setActionActive("btn_edit2", TRUE)
                           CALL DIALOG.setActionActive("btn_update2", TRUE)
                           CALL DIALOG.setActionActive("btn_cus_revert_std", TRUE)
                        END IF
                     END IF
                  END IF
               END IF
         
            #編輯section內容.
            ON ACTION btn_edit2
               IF g_jobj_section_a.has(ls_section_a_curr_name) THEN
                  LET li_section_a_curr = g_jobj_section_a.get(ls_section_a_curr_name)
               ELSE
                  LET li_section_a_curr = 1 #這是為了setCurrRow防呆.
               END IF

               CALL adzp064_section_a_input(li_curr2, ls_section_name, la_section_a, la_section_a_color, la_section_a_diff_no, la_section_a_temp_no, li_section_a_curr) RETURNING li_section_a_curr
               CALL DIALOG.setCurrentRow("s_detail1_1", li_section_a_curr) #讓編輯畫面看起來比較正常.
               CALL g_jobj_section_a.put(ls_section_a_curr_name, li_section_a_curr)

               IF g_action_choice="exit" THEN
                  EXIT DIALOG
               END IF

            #將最新客製section內容更新到資料庫.
            ON ACTION btn_update2
               IF adzp064_update_to_db(cs_section, ga_section_lst, li_curr2, la_section_a) THEN
                  #識別碼標示為'未修改'.
                  LET ga_section_lst[li_curr2].sel = ''
                  #識別碼名稱顏色維持原狀.
               END IF

            #執行客製section還原標準.
            ON ACTION btn_cus_revert_std2
               IF adzp064_cus_revert_std(cs_apt, ga_section_lst, ga_section_lst_color, g_jobj_section_a, la_section_a, la_section_a_color, li_curr2, la_section_a_diff_no) THEN
                  #識別碼標示為'未修改'.
                  LET ga_section_lst[li_curr2].sel = ''
                  #識別碼名稱變成紅色.
                  LET ga_section_lst_color[li_curr2].name = "red"
                  #只有客製section才可以進行異動.
                  CALL DIALOG.setActionActive("btn_edit2", FALSE)
                  CALL DIALOG.setActionActive("btn_update2", FALSE)
                  CALL DIALOG.setActionActive("btn_cus_revert_std2", FALSE)
               END IF

         END DISPLAY

         DISPLAY ARRAY la_section_a TO s_detail2_1.*
            BEFORE ROW
               LET li_section_a_curr = ARR_CURR()
               CALL g_jobj_section_a.put(ls_section_a_curr_name, li_section_a_curr) #為了下次再度進入編輯狀態的時候,可以預設正確的編輯行數.

            BEFORE DISPLAY
               CALL DIALOG.setArrayAttributes("s_detail2_1", la_section_a_color)

            #編輯section內容. #for doubleClick
            ON ACTION btn_edit2
               CALL adzp064_section_a_input(li_curr2, ls_section_name, la_section_a, la_section_a_color, la_section_a_diff_no, la_section_a_temp_no, li_section_a_curr) RETURNING li_section_a_curr
               CALL DIALOG.setCurrentRow("s_detail1_1", li_section_a_curr) #讓編輯畫面看起來比較正常.
               CALL g_jobj_section_a.put(ls_section_a_curr_name, li_section_a_curr)

         END DISPLAY

         #呈現section標準與客製的差異起始行數.
         DISPLAY ARRAY la_section_a_diff_no TO s_detail2_1_no.*
            BEFORE ROW
               CALL DIALOG.setCurrentRow("s_detail2_1", la_section_a_diff_no[ARR_CURR()].diff_no)
         END DISPLAY

         ON ACTION CLOSE
            LET g_action_choice = "exit"
            EXIT DIALOG

      END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

#取得符合條件的客製add-point清單.
PRIVATE FUNCTION adzp064_prepare_apt_lst()
   DEFINE ls_sql  STRING,
          li_i    SMALLINT

   TRY
      #以客製資料為主,這樣才能取得目標清單.
      CALL ga_apt_lst.clear()
      CALL ga_apt_lst_color.clear()

      LET ls_sql = "SELECT '','N','N',ba1.dzba003,'N','N',ba2.dzba004,ba2.dzba009,ba2.dzbb098,ba1.dzba004,ba1.dzba009,ba1.dzbb098",
                   "  FROM (SELECT dzba003,dzba004,dzba009,dzbb098",
                   "          FROM dzba_t",
                   "         INNER JOIN dzbb_t",
                   "            ON dzbb001 = dzba001",
                   "           AND dzbb002 = dzba003",
                   "           AND dzbb003 = dzba004",
                   "           AND dzbb004 = dzba005",
                   "         WHERE dzba001 = '",g_prog,"'",
                   "           AND dzba002 = ",g_cus_dzaf004,
                   "           AND dzba005 = 'c'",
                   "           AND dzba010 = 'c'",
                   "           AND dzbastus = 'Y') ba1",
                   " INNER JOIN (SELECT dzba003,dzba004,dzba009,dzbb098",
                   "               FROM dzba_t",
                   "              INNER JOIN dzbb_t",
                   "                 ON dzbb001 = dzba001",
                   "                AND dzbb002 = dzba003",
                   "                AND dzbb003 = dzba004",
                   "                AND dzbb004 = dzba005",
                   "              WHERE dzba001 = '",g_prog,"'",
                   "                AND dzba002 = ",g_std_dzaf004,
                   "                AND dzba005 = 's'",
                   "                AND dzba010 = 's'",
                   "                AND dzbastus = 'Y') ba2",
                   "    ON ba2.dzba003 = ba1.dzba003",
                   " ORDER BY ba1.dzba003"
      display "dzbb_t SQL=",ls_sql
      PREPARE dzba_prep FROM ls_sql
      LOCATE ga_apt_lst[1].std_content IN FILE
      LOCATE ga_apt_lst[1].cus_content IN FILE
      DECLARE dzba_curs CURSOR FOR dzba_prep
      
      LET li_i = 1
      FOREACH dzba_curs INTO ga_apt_lst[li_i].*
         LET li_i = li_i + 1
         LOCATE ga_apt_lst[li_i].std_content IN FILE
         LOCATE ga_apt_lst[li_i].cus_content IN FILE
      END FOREACH
      CALL ga_apt_lst.deleteElement(li_i)
   CATCH
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
      DISPLAY "ERROR : adzp064_prepare_apt_lst : ls_sql=",ls_sql,"<<"
   END TRY
END  FUNCTION
 
#取得符合條件的客製section清單.
PRIVATE FUNCTION adzp064_prepare_section_lst()
   DEFINE ls_sql  STRING,
          li_i    SMALLINT

   TRY
      #以客製資料為主,這樣才能取得目標清單.
      CALL ga_section_lst.clear()
      CALL ga_section_lst_color.clear()

      LET ls_sql = "SELECT '','N','N',bc1.dzbc003,'N','N',bc2.dzbc004,bc2.dzbc005,bc2.dzbd098,bc1.dzbc004,bc1.dzbc005,bc1.dzbd098",
                   "  FROM (SELECT dzbc003,dzbc004,dzbc005,dzbd098", #因為標準有可能是's'或'm',所以'下方的硬結構代碼整段註解',改取得'使用標示'
                   "          FROM dzbc_t",
                   "         INNER JOIN dzbd_t",
                   "            ON dzbd001 = dzbc001",
                   "           AND dzbd002 = dzbc003",
                   "           AND dzbd003 = dzbc004",
                   "           AND dzbd004 = dzbc005",
                   "         WHERE dzbc001 = '",g_prog,"'",
                   "           AND dzbc002 = ",g_cus_dzaf004,
                   "           AND dzbc005 = 'c'",
                   "           AND dzbc007 = 'c'",
                   "           AND dzbcstus = 'Y') bc1",
                   " INNER JOIN (SELECT dzbc003,dzbc004,dzbc005,dzbd098",
                   "               FROM dzbc_t",
                   "              INNER JOIN dzbd_t",
                   "                 ON dzbd001 = dzbc001",
                   "                AND dzbd002 = dzbc003",
                   "                AND dzbd003 = dzbc004",
                   "                AND dzbd004 = dzbc005",
                   "              WHERE dzbc001 = '",g_prog,"'",
                   "                AND dzbc002 = ",g_std_dzaf004,
                   "                AND dzbc005 IN ('s','m')",
                   "                AND dzbc007 = 's'",
                   "                AND dzbcstus = 'Y') bc2",
                   "    ON bc2.dzbc003 = bc1.dzbc003",
                   " ORDER BY bc1.dzbc003"
      display "dzbd_t SQL=",ls_sql
      PREPARE dzbc_prep FROM ls_sql
      LOCATE ga_section_lst[1].std_content IN FILE
      LOCATE ga_section_lst[1].cus_content IN FILE
      DECLARE dzbc_curs CURSOR FOR dzbc_prep

      LET li_i = 1
      FOREACH dzbc_curs INTO ga_section_lst[li_i].*
         LET li_i = li_i + 1
         LOCATE ga_section_lst[li_i].std_content IN FILE
         LOCATE ga_section_lst[li_i].cus_content IN FILE
      END FOREACH
      CALL ga_section_lst.deleteElement(li_i)
   CATCH
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
      DISPLAY "ERROR : adzp064_prepare_section_lst : ls_sql=",ls_sql,"<<"
   END TRY
END  FUNCTION
 
#為了加快比對速度, 會再合併內容後才會開始比對.
PRIVATE FUNCTION adzp064_merge_content_to_file(p_content_lst, p_left_apt_path, p_right_apt_path)
   DEFINE p_content_lst    T_LIST,
          p_left_apt_path  STRING,
          p_right_apt_path STRING
   DEFINE lch_left_apt  base.Channel,
          lch_right_apt base.Channel,
          li_i          INTEGER,
          li_j          INTEGER
   
   LET lch_left_apt = base.Channel.create()
   DISPLAY "merge_content_to_file:p_left_apt_path=",p_left_apt_path
   CALL lch_left_apt.openFile(p_left_apt_path, "w")
   FOR li_i=1 TO p_content_lst.getLength()
      CALL lch_left_apt.writeLine("#name_identifier:"||p_content_lst[li_i].name)
      CALL lch_left_apt.writeLine(p_content_lst[li_i].std_content||'\n')
   END FOR
   CALL lch_left_apt.close()

   LET lch_right_apt = base.Channel.create()
   DISPLAY "merge_content_to_file:p_right_apt_path=",p_right_apt_path
   CALL lch_right_apt.openFile(p_right_apt_path, "w")
   FOR li_j=1 TO p_content_lst.getLength()
      CALL lch_right_apt.writeLine("#name_identifier:"||p_content_lst[li_j].name)
      CALL lch_right_apt.writeLine(p_content_lst[li_j].cus_content||'\n')
   END FOR
   CALL lch_right_apt.close()
END FUNCTION

#客製內容還原成標準.
PRIVATE FUNCTION adzp064_cus_revert_std(p_revert_kind, pa_content_lst, pa_content_lst_color, p_jobj, pa_content, pa_content_color, p_curr, pa_content_diff_no)
   DEFINE p_revert_kind        STRING, #add-point/section
          pa_content_lst       T_LIST,
          pa_content_lst_color T_LIST,
          p_curr               INTEGER,   
          p_jobj               util.JSONObject,
          pa_content           T_DIFF_4gl, #為了前端顯現使用
          pa_content_color     T_DIFF_4gl, #為了前端顯現使用
          pa_content_diff_no   T_DIFF_NO
   DEFINE ls_sql     STRING,
          ls_err_msg STRING,
          li_i       INTEGER, 
          ls_name    STRING,
          lc_dzbf003 CHAR(1)
   
   CALL sadzp060_2_have_checked_out(g_prog, g_cons_type, "PR", "1") RETURNING ls_err_msg #double check : 檢查是否為本人簽出.
   IF cl_null(ls_err_msg) THEN
      IF cl_ask_confirm("adz-00645") THEN #請問是否要將客製程式段還原成標準程式段?
         LET ls_name = pa_content_lst[p_curr].name

         CASE p_revert_kind
            WHEN cs_apt     
               LET lc_dzbf003 = '1'
               LET ls_sql = "UPDATE dzba_t",
                              " SET dzba004=",pa_content_lst[p_curr].std_ver,",",
                                   "dzba005='s',",
                                   "dzba009='",pa_content_lst[p_curr].std_flag,"',",
                                   "dzba011='",cs_digiwin,"',",
                                   "dzbamoddt=?,",
                                   "dzbamodid='",g_user,"'",
                            " WHERE dzba001='",g_prog,"'",
                            "   AND dzba002=",g_cus_dzaf004,
                            "   AND dzba003='",ls_name,"'",
                            "   AND dzba010='c'"
            WHEN cs_section    
               LET lc_dzbf003 = '2'
               LET ls_sql = "UPDATE dzbc_t",
                              " SET dzbc004=",pa_content_lst[p_curr].std_ver,",",
                                   "dzbc005='",pa_content_lst[p_curr].std_flag,"',", #標準有可能是's'或'm'.
                                   "dzbc008='",cs_digiwin,"',",
                                   "dzbc009='Y'",
                                   "dzbcmoddt=?,",
                                   "dzbcmodid='",g_user,"'",
                            " WHERE dzbc001='",g_prog,"'",
                            "   AND dzbc002=",g_cus_dzaf004,
                            "   AND dzbc003='",ls_name,"'",
                            "   AND dzbc007='c'"
         END CASE
      
         PREPARE upd_prep FROM ls_sql
         EXECUTE upd_prep USING g_date
         FREE upd_prep
      
         #紀錄異動資料:dzbf_t(客製還原紀錄表).
         #dzbf001(程式編號):PK
         #dzbf002(識別碼):PK
         #dzbf003(還原類型):1.add-point;2.section
         #dzbf004(還原前設計點版次)
         #dzbf005(還原前使用標示)
         #dzbf006(還原後設計點版次)
         #dzbf007(還原後使用標示)
         #dzbf008(客製程式版次)
         
         DELETE FROM dzbf_t WHERE dzbf001=g_prog AND dzbf002=pa_content_lst[p_curr].name AND dzbf008=g_cus_dzaf004
         
         LET ls_sql = "INSERT INTO dzbf_t(dzbf001,dzbf002,dzbf003,dzbf004,dzbf005,dzbf006,dzbf007,dzbf008,",
                                         "dzbfcrtdt,dzbfcrtdp,dzbfowndp,dzbfownid,dzbfcrtid)",
                     " VALUES('",g_prog,"','",ls_name,"','",lc_dzbf003,"',",pa_content_lst[p_curr].cus_ver,",'c',",pa_content_lst[p_curr].std_ver,",'s',",g_cus_dzaf004,",",
                             "?,'",g_dept CLIPPED,"','",g_dept CLIPPED,"','",g_user,"','",g_user,"')"
         PREPARE ins_dzbf_prep FROM ls_sql
         EXECUTE ins_dzbf_prep USING g_date
         FREE ins_dzbf_prep
         LET ls_sql = NULL
      
         #左右兩邊的資料與顏色都設定為:比較結果完全相同.
         FOR li_i=1 TO pa_content.getLength()
            LET pa_content[li_i].l_diff = ""
            LET pa_content[li_i].right = pa_content[li_i].left
            LET pa_content[li_i].r_diff = ""
            LET pa_content[li_i].fill_gap = ""
            
            LET pa_content_color[li_i].left = ""
            LET pa_content_color[li_i].right = ""
         END FOR
      
         LET pa_content_lst[p_curr].revert_std = 'N' #取消勾選'建議還原標準'.
         LET pa_content_lst[p_curr].done_std = 'Y'
         CALL pa_content_diff_no.clear() #清除差異行數.
      
         #將最後結果更新回JSON物件,以免BEFORE ROW呈現舊資料.
         CALL p_jobj.put(ls_name, pa_content)
         CALL p_jobj.put(ls_name||"_color", pa_content_color)
         CALL p_jobj.put(ls_name||"_diff_no", pa_content_diff_no)

         RETURN TRUE
      END IF #要還原
   END IF #有權限

   RETURN FALSE
END FUNCTION

#執行挑選取代/還原取代.
PRIVATE FUNCTION adzp064_copy_line(p_action, p_name, p_jobj, pa_content, pa_content_color)
   DEFINE p_action         STRING,
          p_name           STRING,
          p_jobj           util.JSONObject,
          pa_content       T_DIFF_4gl,
          pa_content_color T_DIFF_4gl 
   DEFINE li_i INTEGER

   CASE p_action
      WHEN cs_do_copy_line #挑選取代
         FOR li_i=1 TO pa_content.getLength()
            IF pa_content[li_i].sel="Y" THEN
               CASE pa_content[li_i].r_diff
                  WHEN '+' #右側補空白.
                     LET pa_content[li_i].fill_gap = '+'
                     LET pa_content[li_i].right = pa_content[li_i].left
                     LET pa_content_color[li_i].right = "darkGreen"
                  WHEN 'x' #左側複製到右側.
                     LET pa_content[li_i].fill_gap = 'x'
                     LET pa_content[li_i].orig_line = pa_content[li_i].right #暫存舊資料.
                     LET pa_content[li_i].right = pa_content[li_i].left
                     LET pa_content_color[li_i].orig_line = pa_content_color[li_i].right #紀錄原本的顏色
                     LET pa_content_color[li_i].right = "darkYellow"
               END CASE
            END IF
         END FOR
      #todo:清單有修改時會變成紅色,並且會有'*';還原的時候得考慮這個部分,所以暫時取消'還原取代'功能.
      #WHEN cs_no_copy_line #還原取代
      #   FOR li_i=1 TO pa_content.getLength()
      #      IF pa_content[li_i].sel="Y" THEN
      #         CASE pa_content[li_i].fill_gap
      #            WHEN '+' #原本是補空白.
      #               LET pa_content[li_i].fill_gap = ""
      #               LET pa_content[li_i].right = ""
      #               LET pa_content_color[li_i].right = "lightGreen reverse"
      #            WHEN 'x' #原本是左側複製到右側.
      #               LET pa_content[li_i].fill_gap = ""
      #               LET pa_content[li_i].right = pa_content[li_i].orig_line #還原舊資料.
      #               LET pa_content[li_i].orig_line = ""
      #               LET pa_content_color[li_i].right = pa_content_color[li_i].orig_line #還原顏色.
      #               LET pa_content_color[li_i].orig_line = ""
      #         END CASE
      #      END IF
      #   END FOR
      
      #   #重新設定外顯顏色.
      #   FOR li_i=1 TO pa_content.getLength()
      #      IF NOT cl_null(pa_content[li_i].fill_gap) THEN
      #         LET pa_content_lst_color[p_curr].name = "red"
      #         EXIT FOR
      #      END IF
      #   END FOR
      END CASE

   #將最後結果更新回JSON物件,以免BEFORE ROW呈現舊資料.
   CALL p_jobj.put(p_name, pa_content)
   CALL p_jobj.put(p_name||"_color", pa_content_color)
END FUNCTION

#將最新客製內容更新到資料庫.
PRIVATE FUNCTION adzp064_update_to_db(p_update_kind, pa_content_lst, p_curr, pa_content)
   DEFINE p_update_kind  STRING, #add-point/section
          pa_content_lst T_LIST,
          p_curr         INTEGER,
          pa_content     T_DIFF_4gl 
   DEFINE ls_err_msg   STRING,
          li_i         INTEGER,
          l_content    LIKE dzbb_t.dzbb098,
          lsb_content  base.StringBuffer,
          lb_null_line BOOLEAN,
          ls_sql       STRING,
          li_cnt       INTEGER,
          ls_where     STRING,
          ls_update    STRING

   CALL sadzp060_2_have_checked_out(g_prog, g_cons_type, "PR", "1") RETURNING ls_err_msg #double check : 檢查是否為本人簽出.
   IF cl_null(ls_err_msg) THEN
      IF cl_ask_confirm_parm("adz-00803", g_prog) THEN #請問是否要將%1所做的異動更新到資料庫?
         #組合內容並更新
         LET lsb_content = base.StringBuffer.create()
         LET lb_null_line = TRUE
         FOR li_i=1 TO pa_content.getLength()
            IF li_i>1 THEN
               IF lb_null_line THEN
                  CALL cl_null(pa_content[li_i].right) RETURNING lb_null_line
                  IF NOT lb_null_line THEN #遇到第一個不是空白行的字串就不能增加斷行符號,以免多空一行.
                     CALL lsb_content.append(pa_content[li_i].right)
                     CONTINUE FOR
                  END IF
               END IF
               
               IF lb_null_line THEN
                  CALL lsb_content.append("\n")
               ELSE
                  CALL lsb_content.append("\n")
                  CALL lsb_content.append(pa_content[li_i].right)
               END IF
            END IF #跳過第一行:原本是為了diff而硬塞的識別碼名稱.
         END FOR
         
         LOCATE l_content IN FILE
         LET l_content = lsb_content.toString()
       
         CASE p_update_kind
            WHEN cs_apt     
               LET ls_sql = "SELECT count(*) FROM dzbb_t",
                            " WHERE dzbb001='",g_prog,"'",
                            "   AND dzbb002='",pa_content_lst[p_curr].name,"'",
                            "   AND dzbb003=",g_cus_dzaf004,
                            "   AND dzbb004='",g_dgenv,"'" #一定是c.
               PREPARE dzbb_prep1 FROM ls_sql
               EXECUTE dzbb_prep1 INTO li_cnt
               FREE dzbb_prep1
               
               IF li_cnt=0 THEN #資料不存在就新增.
                  LET ls_sql = "INSERT INTO dzbb_t(dzbb001,dzbb002,dzbb003,dzbb004,dzbb005,dzbb006,dzbb007,",
                                                  "dzbbcrtdt,dzbbcrtdp,dzbbowndp,dzbbownid,dzbbstus,dzbbcrtid)",
                                          " VALUES('",g_prog,"','",pa_content_lst[p_curr].name,"',",g_cus_dzaf004,",'",g_dgenv,"','",g_cust,"','','',", 
                                                  "?,'",g_dept,"','",g_dept,"','",g_user,"','Y','",g_user,"')"
                  PREPARE ins_dzbb_prep2 FROM ls_sql
                  EXECUTE ins_dzbb_prep2 USING g_date
                  FREE ins_dzbb_prep2
               END IF

               UPDATE dzbb_t 
                  SET dzbb005=g_cust,
                      dzbb098=l_content,
                      dzbbmoddt=g_date,
                      dzbbmodid=g_user
                WHERE dzbb001=g_prog
                  AND dzbb002=pa_content_lst[p_curr].name
                  AND dzbb003=g_cus_dzaf004
                  AND dzbb004=g_dgenv 
            WHEN cs_section    
               LET ls_sql = "SELECT count(*) FROM dzbd_t",
                            " WHERE dzbd001='",g_prog,"'",
                            "   AND dzbd002='",pa_content_lst[p_curr].name,"'",
                            "   AND dzbd003=",g_cus_dzaf004,
                            "   AND dzbd004='",g_dgenv,"'" #一定是c.
               PREPARE dzbd_prep1 FROM ls_sql
               EXECUTE dzbd_prep1 INTO li_cnt
               FREE dzbd_prep1
               
               IF li_cnt=0 THEN #資料不存在就新增. #因為section已經是客製了,所以這段和sdzp060_1不太相同,比較簡單.
                  LET ls_sql = "INSERT INTO dzbd_t(dzbd001,dzbd002,dzbd003,dzbd004,dzbd005,",
                                                  "dzbdcrtdt,dzbdcrtdp,dzbdowndp,dzbdownid,dzbdstus,dzbdcrtid)",
                                          " VALUES('",g_prog,"','",pa_content_lst[p_curr].name,"',",g_cus_dzaf004,",'",g_dgenv,"','",g_cust,"','','',", 
                                                  "?,'",g_dept,"','",g_dept,"','",g_user,"','Y','",g_user,"')"
                  PREPARE ins_dzbd_prep2 FROM ls_sql
                  EXECUTE ins_dzbd_prep2 USING g_date
                  FREE ins_dzbd_prep2
               END IF

               UPDATE dzbd_t 
                  SET dzbd005=g_cust,
                      dzbd098=l_content,
                      dzbdmoddt=g_date,
                      dzbdmodid=g_user
                WHERE dzbd001=g_prog
                  AND dzbd002=pa_content_lst[p_curr].name
                  AND dzbd003=g_cus_dzaf004
                  AND dzbd004=g_dgenv 
         END CASE

         FREE l_content
           
         CASE p_update_kind
            WHEN cs_apt     
               LET ls_update = "UPDATE dzba_t",
                                 " SET dzba004=",g_cus_dzaf004,",",
                                      "dzba005='",g_dgenv,"',", #一定是c.
                                      "dzba011='",g_cust,"',",
                                      "dzbamoddt=?,",
                                      "dzbamodid='",g_user,"'" 

               LET ls_where = " WHERE dzba001='",g_prog,"'",
                              "   AND dzba002=",g_cus_dzaf004,
                              "   AND dzba003='",pa_content_lst[p_curr].name,"'",
                              "   AND dzba010='",g_dgenv,"'" #一定是c.

               LET ls_sql = "SELECT count(*) FROM dzba_t",ls_where
               PREPARE dzba_prep1 FROM ls_sql
               EXECUTE dzba_prep1 INTO li_cnt
               FREE dzba_prep1
               
               IF li_cnt=0 THEN #找不到目前的更新紀錄,就用現在的使用版次來更新.
                  LET ls_sql = ls_update,
                               " WHERE dzba001='",g_prog,"'",
                               "   AND dzba002=",pa_content_lst[p_curr].cus_ver,
                               "   AND dzba003='",pa_content_lst[p_curr].name,"'",
                               "   AND dzba010='",g_dgenv,"'" #一定是c.
               ELSE
                  LET ls_sql = ls_update,ls_where
               END IF
            WHEN cs_section    
               LET ls_update = "UPDATE dzbc_t",
                              " SET dzbc004=",g_cus_dzaf004,",",
                                   "dzbc005='",g_dgenv,"',", #一定是c.
                                   "dzbc008='",g_cust,"',",
                                   "dzbc009='Y'",
                                   "dzbcmoddt=?,",
                                   "dzbcmodid='",g_user,"'" 

               LET ls_where = " WHERE dzbc001='",g_prog,"'",
                              "   AND dzbc002=",g_cus_dzaf004,
                              "   AND dzbc003='",pa_content_lst[p_curr].name,"'",
                              "   AND dzbc007='",g_dgenv,"'" #一定是c.

               LET ls_sql = "SELECT count(*) FROM dzbc_t",ls_where
               PREPARE dzbc_prep1 FROM ls_sql
               EXECUTE dzbc_prep1 INTO li_cnt
               FREE dzbc_prep1
               
               IF li_cnt=0 THEN #找不到目前的更新紀錄,就用現在的使用版次來更新.
                  LET ls_sql = ls_update,
                               " WHERE dzbc001='",g_prog,"'",
                               "   AND dzbc002=",pa_content_lst[p_curr].cus_ver,
                               "   AND dzbc003='",pa_content_lst[p_curr].name,"'",
                               "   AND dzbc007='",g_dgenv,"'" #一定是c.
               ELSE
                  LET ls_sql = ls_update,ls_where
               END IF
         END CASE
      
         display "update sql=",ls_sql
         PREPARE upd_prep2 FROM ls_sql
         EXECUTE upd_prep2 USING g_date
         FREE upd_prep2

         RETURN TRUE
      END IF #同意進行資料更新
   END IF #有權限

   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION adzp064_append_line(p_name, p_jobj, pa_content, pa_content_color, p_content_curr, pa_content_diff_no, pa_temp_diff_no)
   DEFINE p_name             STRING,
          p_jobj             util.JSONObject,
          pa_content         T_DIFF_4gl, #為了前端顯現使用
          pa_content_color   T_DIFF_4gl, #為了前端顯現使用
          p_content_curr     INTEGER,
          pa_content_diff_no T_DIFF_NO,
          pa_temp_diff_no    T_DIFF_NO
   DEFINE li_i       INTEGER,
          li_diff_no INTEGER,
          li_ins_idx INTEGER

   CALL pa_content.insertElement(p_content_curr)
   CALL pa_content_color.insertElement(p_content_curr)
   #左側補空白的相關設定.
   LET pa_content[p_content_curr].sel = 'N'
   LET pa_content[p_content_curr].fill_gap = 'a'
   LET pa_content[p_content_curr].l_diff = '+'
   LET pa_content_color[p_content_curr].right = "red"
   LET pa_content_color[p_content_curr].left = "lightRed reverse"

   #將最後結果更新回JSON物件,以免BEFORE ROW呈現舊資料.
   CALL p_jobj.put(p_name, pa_content)
   CALL p_jobj.put(p_name||"_color", pa_content_color)

   #重設快速導覽行數.
   CALL adzp064_reset_diff_no(cs_append_line, p_name, p_jobj, pa_content_diff_no, pa_temp_diff_no, p_content_curr)
END FUNCTION

PRIVATE FUNCTION adzp064_apt_a_input(p_curr, p_apt_name, pa_apt_a, pa_apt_a_color, pa_apt_a_diff_no, pa_apt_a_temp_no, p_curr_row)
   DEFINE p_curr           INTEGER,
          p_apt_name       STRING,
          pa_apt_a         T_DIFF_4gl,
          pa_apt_a_color   T_DIFF_4gl,
          pa_apt_a_diff_no T_DIFF_NO,
          pa_apt_a_temp_no T_DIFF_NO,
          p_curr_row       INTEGER 
   DEFINE li_apt_a_curr    INTEGER,
          ls_apt_a_cus_old STRING,
          ls_apt_a_cus_new STRING
   DEFINE ls_text   STRING,
          ltok_text base.StringTokenizer,
          ls_tok    STRING 

   IF pa_apt_a.getLength()>0 THEN #防呆.
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #呈現add-point標準與客製的差異結果.
         INPUT ARRAY pa_apt_a FROM s_detail1_1.*
            BEFORE INPUT
               CALL DIALOG.setArrayAttributes("s_detail1_1", pa_apt_a_color)

            BEFORE ROW
               LET li_apt_a_curr = ARR_CURR()
               LET ls_apt_a_cus_old = pa_apt_a[li_apt_a_curr].right
         
            AFTER FIELD curr_cus_apt
               LET ls_apt_a_cus_new = pa_apt_a[li_apt_a_curr].right
               IF adzp064_after_field(p_apt_name, g_jobj_apt_a, ls_apt_a_cus_old, ls_apt_a_cus_new, pa_apt_a, pa_apt_a_color, li_apt_a_curr, pa_apt_a_diff_no, pa_apt_a_temp_no) THEN
                  #識別碼標示為'已修改'.
                  LET ga_apt_lst[p_curr].sel = '*'
                  #識別碼名稱變成紅色.
                  LET ga_apt_lst_color[p_curr].name = "red"
               END IF
         
            #add-point挑選取代
            ON ACTION btn_copy_line
               CALL adzp064_copy_line(cs_do_copy_line, p_apt_name, g_jobj_apt_a, pa_apt_a, pa_apt_a_color)
               #識別碼標示為'已修改'.
               LET ga_apt_lst[p_curr].sel = '*'
               #識別碼名稱變成紅色.
               LET ga_apt_lst_color[p_curr].name = "red"
               #清除勾選.
               CALL adzp064_clear_sel(pa_apt_a)
         
            #add-point還原取代 #todo:因為有顏色的關係,暫時不做.
            #ON ACTION btn_no_copy_line
            #   CALL adzp064_copy_line(cs_no_copy_line, p_apt_name, g_jobj_apt_a, pa_apt_a, pa_apt_a_color)
         
            #新增下一行(Enter):同accept
            ON ACTION btn_append_line
               #這段和AFTER FIELD curr_cus_apt相同,這可避免編輯後馬上按下Enter掉了編輯內容的問題.
               LET ls_apt_a_cus_new = pa_apt_a[li_apt_a_curr].right
               IF adzp064_after_field(p_apt_name, g_jobj_apt_a, ls_apt_a_cus_old, ls_apt_a_cus_new, pa_apt_a, pa_apt_a_color, li_apt_a_curr, pa_apt_a_diff_no, pa_apt_a_temp_no) THEN
                  #識別碼標示為'已修改'.
                  LET ga_apt_lst[p_curr].sel = '*'
                  #識別碼名稱變成紅色.
                  LET ga_apt_lst_color[p_curr].name = "red"
               END IF
      
               #接下來才做真正的新增一行動作.
               LET li_apt_a_curr = li_apt_a_curr + 1
               CALL adzp064_append_line(p_apt_name, g_jobj_apt_a, pa_apt_a, pa_apt_a_color, li_apt_a_curr, pa_apt_a_diff_no, pa_apt_a_temp_no)
               CALL DIALOG.setCurrentRow("s_detail1_1", li_apt_a_curr)
               LET ls_apt_a_cus_old = "" #非常重要
               #識別碼標示為'已修改'.
               LET ga_apt_lst[p_curr].sel = '*'
               #新增一行得讓識別碼名稱變成紅色.
               LET ga_apt_lst_color[p_curr].name = "red"
         
            #多行貼上
            ON ACTION btn_ins_multi_line
               LET pa_apt_a_color[li_apt_a_curr].right = "red" #解決focus當筆已經有資料再貼上要呈現修改狀態的問題.
               LET ls_text = ""
               CALL ui.Interface.frontCall("standard", "cbget", [], [ls_text])
               LET ltok_text = base.StringTokenizer.create(ls_text, "\n")
               WHILE ltok_text.hasMoreTokens()
                  LET ls_tok = ltok_text.nextToken()
                  LET pa_apt_a[li_apt_a_curr].right = pa_apt_a[li_apt_a_curr].right,ls_tok #有可能focus當筆已經有資料,所以直接加在後面即可.
                  IF ltok_text.hasMoreTokens() THEN
                     LET li_apt_a_curr = li_apt_a_curr + 1
                     CALL adzp064_append_line(p_apt_name, g_jobj_apt_a, pa_apt_a, pa_apt_a_color, li_apt_a_curr, pa_apt_a_diff_no, pa_apt_a_temp_no)
                  END IF
               END WHILE

               CALL DIALOG.setCurrentRow("s_detail1_1", li_apt_a_curr)
               LET ls_apt_a_cus_old = "" #非常重要
               #識別碼標示為'已修改'.
               LET ga_apt_lst[p_curr].sel = '*'
               #新增一行得讓識別碼名稱變成紅色.
               LET ga_apt_lst_color[p_curr].name = "red"
               
            #挑選刪除
            ON ACTION btn_del_line
               CALL adzp064_del_line(p_apt_name, g_jobj_apt_a, pa_apt_a, pa_apt_a_color, pa_apt_a_diff_no, pa_apt_a_temp_no)
               #清除勾選.
               CALL adzp064_clear_sel(pa_apt_a)

         END INPUT
         
         #呈現add-point標準與客製的差異起始行數.
         DISPLAY ARRAY pa_apt_a_diff_no TO s_detail1_1_no.*
            BEFORE ROW
               IF p_curr_row>0 THEN #這只是為了每次進入的時候所做的判斷.
                  CALL DIALOG.setCurrentRow("s_detail1_1", p_curr_row)
                  LET p_curr_row = 0
               ELSE
                  CALL DIALOG.setCurrentRow("s_detail1_1", pa_apt_a_diff_no[ARR_CURR()].diff_no)
                  LET li_apt_a_curr = pa_apt_a_diff_no[ARR_CURR()].diff_no
               END IF
               
               NEXT FIELD curr_cus_apt #瀏覽過程當中隨時進入編輯狀態.

         END DISPLAY
      
         ON ACTION btn_close
            IF li_apt_a_curr>0 THEN
               #為了因應編輯後馬上按下離開按鈕,所以這塊檢查同AFTER FIELD curr_cus_apt
               LET ls_apt_a_cus_new = pa_apt_a[li_apt_a_curr].right
               IF adzp064_after_field(p_apt_name, g_jobj_apt_a, ls_apt_a_cus_old, ls_apt_a_cus_new, pa_apt_a, pa_apt_a_color, li_apt_a_curr, pa_apt_a_diff_no, pa_apt_a_temp_no) THEN
                  #識別碼標示為'已修改'.
                  LET ga_apt_lst[p_curr].sel = '*'
                  #識別碼名稱變成紅色.
                  LET ga_apt_lst_color[p_curr].name = "red"
               END IF

               LET p_curr_row = li_apt_a_curr #這是為了下次進入編輯的時候的預設編輯行數.
            END IF
      
            #清除勾選.
            CALL adzp064_clear_sel(pa_apt_a)

            EXIT DIALOG

         ON ACTION CLOSE
            LET g_action_choice = "exit"
            EXIT DIALOG

      END DIALOG
   END IF

   RETURN p_curr_row
END FUNCTION

#清除勾選.
PRIVATE FUNCTION adzp064_clear_sel(p_content)
   DEFINE p_content T_DIFF_4gl
   DEFINE li_i INTEGER

   FOR li_i=1 TO p_content.getLength()
       LET p_content[li_i].sel = "N"
   END FOR
END FUNCTION

PRIVATE FUNCTION adzp064_after_field(p_name, p_jobj, p_old_text, p_new_text, pa_content, pa_content_color, p_content_curr, pa_content_diff_no, pa_temp_diff_no)
   DEFINE p_name             STRING,
          p_jobj             util.JSONObject,
          p_old_text         STRING,
          p_new_text         STRING,
          pa_content         T_DIFF_4gl, #為了前端顯現使用
          pa_content_color   T_DIFF_4gl, #為了前端顯現使用
          p_content_curr     INTEGER,
          pa_content_diff_no T_DIFF_NO,
          pa_temp_diff_no    T_DIFF_NO
  
   IF adzp064_check_text(p_old_text, p_new_text) THEN
      LET pa_content_color[p_content_curr].right = "red"
      #將最後結果更新回JSON物件,以免BEFORE ROW呈現舊資料.
      CALL p_jobj.put(p_name, pa_content)
      CALL p_jobj.put(p_name||"_color", pa_content_color)

      #重設快速導覽行數.
      CALL adzp064_reset_diff_no(cs_modify_line, p_name, p_jobj, pa_content_diff_no, pa_temp_diff_no, p_content_curr)

      RETURN TRUE #有異動
   ELSE
      RETURN FALSE #無異動
   END IF
END FUNCTION

PRIVATE FUNCTION adzp064_check_text(p_old_text, p_new_text)
   DEFINE p_old_text STRING,
          p_new_text STRING
   DEFINE lb_check BOOLEAN
   
   #需要檢查的情況:
   #old:null     vs new:null --> no
   #             vs new:not null --> yes
   #    not null vs new:null --> yes		
   #             vs new:not null --> difference : yes

   LET lb_check = FALSE
   
   IF cl_null(p_old_text) THEN
      IF NOT cl_null(p_new_text) THEN
         LET lb_check = TRUE
      END IF
   ELSE
      IF NOT cl_null(p_new_text) THEN
         IF NOT p_new_text.equals(p_old_text) THEN
            LET lb_check = TRUE
         END IF
      ELSE
         LET lb_check = TRUE
      END IF
   END IF

   RETURN lb_check
END FUNCTION

PRIVATE FUNCTION adzp064_section_a_input(p_curr, p_section_name, pa_section_a, pa_section_a_color, pa_section_a_diff_no, pa_section_a_temp_no, p_curr_row)
   DEFINE p_curr               INTEGER,
          p_section_name       STRING,
          pa_section_a         T_DIFF_4gl,
          pa_section_a_color   T_DIFF_4gl,
          pa_section_a_diff_no T_DIFF_NO,
          pa_section_a_temp_no T_DIFF_NO,
          p_curr_row           INTEGER 
   DEFINE li_section_a_curr    INTEGER,
          ls_section_a_cus_old STRING,
          ls_section_a_cus_new STRING
   DEFINE ls_text   STRING,
          ltok_text base.StringTokenizer,
          ls_tok    STRING 

   IF pa_section_a.getLength()>0 THEN #防呆.
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #呈現section標準與客製的差異結果.
         INPUT ARRAY pa_section_a FROM s_detail2_1.*
            BEFORE INPUT
               CALL DIALOG.setArrayAttributes("s_detail2_1", pa_section_a_color)

            BEFORE ROW
               LET li_section_a_curr = ARR_CURR()
               LET ls_section_a_cus_old = pa_section_a[li_section_a_curr].right
         
            AFTER FIELD curr_cus_section
               LET ls_section_a_cus_new = pa_section_a[li_section_a_curr].right
               IF adzp064_after_field(p_section_name, g_jobj_section_a, ls_section_a_cus_old, ls_section_a_cus_new, pa_section_a, pa_section_a_color, li_section_a_curr, pa_section_a_diff_no, pa_section_a_temp_no) THEN
                  #識別碼標示為'已修改'.
                  LET ga_section_lst[p_curr].sel = '*'
                  #識別碼名稱變成紅色.
                  LET ga_section_lst_color[p_curr].name = "red"
               END IF
         
            #section挑選取代
            ON ACTION btn_copy_line2
               CALL adzp064_copy_line(cs_do_copy_line, p_section_name, g_jobj_section_a, pa_section_a, pa_section_a_color)
               #識別碼標示為'已修改'.
               LET ga_section_lst[p_curr].sel = '*'
               #識別碼名稱變成紅色.
               LET ga_section_lst_color[p_curr].name = "red"
               #清除勾選.
               CALL adzp064_clear_sel(pa_section_a)
         
            #section還原取代 #todo:因為有顏色的關係,暫時不做.
            #ON ACTION btn_no_copy_line2
            #   CALL adzp064_copy_line(cs_no_copy_line, p_section_name, g_jobj_section_a, pa_section_a, pa_section_a_color)
         
            #新增下一行(Enter):同accept
            ON ACTION btn_append_line2
               #這段和AFTER FIELD curr_cus_section相同,這可避免編輯後馬上按下Enter掉了編輯內容的問題.
               LET ls_section_a_cus_new = pa_section_a[li_section_a_curr].right
               IF adzp064_after_field(p_section_name, g_jobj_section_a, ls_section_a_cus_old, ls_section_a_cus_new, pa_section_a, pa_section_a_color, li_section_a_curr, pa_section_a_diff_no, pa_section_a_temp_no) THEN
                  #識別碼標示為'已修改'.
                  LET ga_section_lst[p_curr].sel = '*'
                  #識別碼名稱變成紅色.
                  LET ga_section_lst_color[p_curr].name = "red"
               END IF
      
               #接下來才做真正的新增一行動作.
               LET li_section_a_curr = li_section_a_curr + 1
               CALL adzp064_append_line(p_section_name, g_jobj_section_a, pa_section_a, pa_section_a_color, li_section_a_curr, pa_section_a_diff_no, pa_section_a_temp_no)
               CALL DIALOG.setCurrentRow("s_detail2_1", li_section_a_curr)
               LET ls_section_a_cus_old = "" #非常重要
               #識別碼標示為'已修改'.
               LET ga_section_lst[p_curr].sel = '*'
               #新增一行得讓識別碼名稱變成紅色.
               LET ga_section_lst_color[p_curr].name = "red"
         
            #多行貼上
            ON ACTION btn_ins_multi_line2
               LET pa_section_a_color[li_section_a_curr].right = "red" #解決focus當筆已經有資料再貼上要呈現修改狀態的問題.
               LET ls_text = ""
               CALL ui.Interface.frontCall("standard", "cbget", [], [ls_text])
               LET ltok_text = base.StringTokenizer.create(ls_text, "\n")
               WHILE ltok_text.hasMoreTokens()
                  LET ls_tok = ltok_text.nextToken()
                  LET pa_section_a[li_section_a_curr].right = pa_section_a[li_section_a_curr].right,ls_tok #有可能focus當筆已經有資料,所以直接加在後面即可.
                  IF ltok_text.hasMoreTokens() THEN
                     LET li_section_a_curr = li_section_a_curr + 1
                     CALL adzp064_append_line(p_section_name, g_jobj_section_a, pa_section_a, pa_section_a_color, li_section_a_curr, pa_section_a_diff_no, pa_section_a_temp_no)
                  END IF
               END WHILE

               CALL DIALOG.setCurrentRow("s_detail1_1", li_section_a_curr)
               LET ls_section_a_cus_old = "" #非常重要
               #識別碼標示為'已修改'.
               LET ga_section_lst[p_curr].sel = '*'
               #新增一行得讓識別碼名稱變成紅色.
               LET ga_section_lst_color[p_curr].name = "red"
         
            #挑選刪除
            ON ACTION btn_del_line2
               CALL adzp064_del_line(p_section_name, g_jobj_section_a, pa_section_a, pa_section_a_color, pa_section_a_diff_no, pa_section_a_temp_no)
               #清除勾選.
               CALL adzp064_clear_sel(pa_section_a)
         
         END INPUT
         
         #呈現section標準與客製的差異起始行數.
         DISPLAY ARRAY pa_section_a_diff_no TO s_detail2_1_no.*
            BEFORE ROW
               IF p_curr_row>0 THEN #這只是為了每次進入的時候所做的判斷.
                  CALL DIALOG.setCurrentRow("s_detail2_1", p_curr_row)
                  LET p_curr_row = 0
               ELSE
                  CALL DIALOG.setCurrentRow("s_detail2_1", pa_section_a_diff_no[ARR_CURR()].diff_no)
                  LET li_section_a_curr = pa_section_a_diff_no[ARR_CURR()].diff_no
               END IF
               
               NEXT FIELD curr_cus_section #瀏覽過程當中隨時進入編輯狀態.

         END DISPLAY
      
         ON ACTION btn_close2
            IF li_section_a_curr>0 THEN
               #為了因應編輯後馬上按下離開按鈕,所以這塊檢查同AFTER FIELD curr_cus_section
               LET ls_section_a_cus_new = pa_section_a[li_section_a_curr].right
               IF adzp064_after_field(p_section_name, g_jobj_section_a, ls_section_a_cus_old, ls_section_a_cus_new, pa_section_a, pa_section_a_color, li_section_a_curr, pa_section_a_diff_no, pa_section_a_temp_no) THEN
                  #識別碼標示為'已修改'.
                  LET ga_section_lst[p_curr].sel = '*'
                  #識別碼名稱變成紅色.
                  LET ga_section_lst_color[p_curr].name = "red"
               END IF

               LET p_curr_row = li_section_a_curr #這是為了下次進入編輯的時候的預設編輯行數.
            END IF
      
            EXIT DIALOG

         ON ACTION CLOSE
            LET g_action_choice = "exit"
            EXIT DIALOG

      END DIALOG
   END IF

   RETURN p_curr_row
END FUNCTION

PRIVATE FUNCTION adzp064_reset_diff_no(p_action, p_name, p_jobj, pa_content_diff_no, pa_temp_diff_no, p_ins_no)
   DEFINE p_action           STRING, #cs_append_line
          p_name             STRING,
          p_jobj             util.JSONObject,
          pa_content_diff_no T_DIFF_NO,
          pa_temp_diff_no    T_DIFF_NO,
          p_ins_no           INTEGER
   DEFINE li_i       INTEGER,
          li_diff_no INTEGER,
          li_t       INTEGER,
          li_temp_no INTEGER,
          lb_exit    BOOLEAN
   
   IF p_action=cs_delete_line THEN #todo
      CALL adzp064_delete_diff_no(pa_temp_diff_no, p_ins_no) RETURNING pa_temp_diff_no
      CALL adzp064_delete_diff_no(pa_content_diff_no, p_ins_no) RETURNING pa_content_diff_no
   ELSE
      #新增暫存'導覽行數'.
      CALL adzp064_append_diff_no(p_action, pa_temp_diff_no, p_ins_no) RETURNING pa_temp_diff_no
      CALL adzp064_append_diff_no(p_action, pa_content_diff_no, p_ins_no) RETURNING pa_content_diff_no
   END IF

   #剔除連續行數紀錄:只保留連續行數的第一個行數紀錄. #todo
   LET lb_exit = FALSE

   FOR li_i=pa_content_diff_no.getLength() TO 1 STEP -1
      LET li_diff_no = pa_content_diff_no[li_i].diff_no

      #從最後面往前開始逐筆判斷是否為連續行數.
      FOR li_t=pa_temp_diff_no.getLength() TO 1 STEP -1
         LET li_temp_no = pa_temp_diff_no[li_t].diff_no
         IF li_temp_no=li_diff_no THEN #在暫存表找到比較標的,則直接取得下一個暫存行數:若是連續則刪除比較標的.
            IF li_t>1 THEN #防呆.
               IF (li_temp_no-pa_temp_diff_no[li_t-1].diff_no)=1 THEN
                  CALL pa_content_diff_no.deleteElement(li_i) #砍掉目標行數.
                  LET lb_exit = TRUE
                  EXIT FOR
               END IF
            END IF
         END IF
      END FOR

      IF lb_exit THEN
         EXIT FOR
      END IF
   END FOR

   #將最後結果更新回JSON物件.
   CALL p_jobj.put(p_name||"_diff_no", pa_content_diff_no)
   CALL p_jobj.put(p_name||"_temp_no", pa_temp_diff_no)
END FUNCTION

#新增'差異導覽'行數.
PRIVATE FUNCTION adzp064_append_diff_no(p_action, pa_content_diff_no, p_ins_no)
   DEFINE p_action           STRING, #cs_append_line
          pa_content_diff_no T_DIFF_NO,
          p_ins_no           INTEGER
   DEFINE li_i       INTEGER,
          li_j       INTEGER,
          li_offset  INTEGER,
          li_diff_no INTEGER 

   LET li_offset = 0

   FOR li_i=1 TO pa_content_diff_no.getLength()
      LET li_diff_no = pa_content_diff_no[li_i].diff_no

      IF p_ins_no<li_diff_no THEN
         CALL pa_content_diff_no.insertElement(li_i)
         LET pa_content_diff_no[li_i].diff_no = p_ins_no

         IF p_action=cs_append_line THEN 
            LET li_offset = li_i + 1
         END IF

         EXIT FOR
      ELSE
         IF pa_content_diff_no[li_i].diff_no=p_ins_no THEN
            IF p_action=cs_append_line THEN 
               LET li_offset = li_i + 1
            END IF

            EXIT FOR
         ELSE
            IF li_i=pa_content_diff_no.getLength() THEN #最後一筆.
               CALL pa_content_diff_no.appendElement()
               LET pa_content_diff_no[pa_content_diff_no.getLength()].diff_no = p_ins_no
            END IF
         END IF
      END IF
   END FOR

   IF p_action=cs_append_line THEN 
      IF li_offset>0 THEN #若新增加的'導覽行數'比原本的行數都大,表示前面的行數都不需要再重設過,此時的li_offset會設定為0.
         FOR li_j=li_offset TO pa_content_diff_no.getLength()
            LET pa_content_diff_no[li_j].diff_no = pa_content_diff_no[li_j].diff_no + 1
         END FOR
      END IF
   END IF  

   RETURN pa_content_diff_no
END FUNCTION

#挑選刪除.
PRIVATE FUNCTION adzp064_del_line(p_name, p_jobj, pa_content, pa_content_color, pa_content_diff_no, pa_temp_diff_no)
   DEFINE p_name             STRING,
          p_jobj             util.JSONObject,
          pa_content         T_DIFF_4gl,
          pa_content_color   T_DIFF_4gl,
          pa_content_diff_no T_DIFF_NO,
          pa_temp_diff_no    T_DIFF_NO
   DEFINE li_i INTEGER

   FOR li_i=pa_content.getLength() TO 1 STEP -1 #由後往前砍.
      IF pa_content[li_i].sel="Y" AND 
         pa_content[li_i].fill_gap='a' THEN #只有真正新增加的行數才能刪除.
         CALL pa_content.deleteElement(li_i)
         CALL pa_content_color.deleteElement(li_i)
         CALL adzp064_reset_diff_no(cs_delete_line, p_name, p_jobj, pa_content_diff_no, pa_temp_diff_no, li_i)
      END IF
   END FOR

   #將最後結果更新回JSON物件,以免BEFORE ROW呈現舊資料.
   CALL p_jobj.put(p_name, pa_content)
   CALL p_jobj.put(p_name||"_color", pa_content_color)
END FUNCTION

#刪除'差異導覽'行數.
PRIVATE FUNCTION adzp064_delete_diff_no(pa_content_diff_no, p_del_no)
   DEFINE pa_content_diff_no T_DIFF_NO,
          p_del_no           INTEGER
   DEFINE li_i       INTEGER,
          li_j       INTEGER,
          li_offset  INTEGER,
          li_diff_no INTEGER 

   FOR li_i=pa_content_diff_no.getLength() TO 1 STEP -1
      LET li_diff_no = pa_content_diff_no[li_i].diff_no

      IF p_del_no>li_diff_no THEN
         IF li_i<pa_content_diff_no.getLength() THEN #不是最後一筆:最後一筆不處理.
            LET li_offset = li_i + 1
         END IF

         EXIT FOR
      ELSE
         IF pa_content_diff_no[li_i].diff_no=p_del_no THEN
            CALL pa_content_diff_no.deleteElement(p_del_no)

            IF li_i<pa_content_diff_no.getLength() THEN #不是最後一筆:最後一筆不處理.
               LET li_offset = li_i
            END IF

            EXIT FOR
         ELSE #小於
            IF li_i=1 THEN #最後一筆.
               LET li_offset = li_i
            END IF
         END IF
      END IF
   END FOR

   IF li_offset>0 THEN
      FOR li_j=li_offset TO pa_content_diff_no.getLength()
         LET pa_content_diff_no[li_j].diff_no = pa_content_diff_no[li_j].diff_no - 1
      END FOR
   END IF

   RETURN pa_content_diff_no
END FUNCTION
