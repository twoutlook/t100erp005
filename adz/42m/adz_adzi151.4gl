#+ 程式版本......: 
#
#+ 程式代碼......: adzi151
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzi151.4gl
# Description    : 簡易程式編輯器
# Modify         : 20160408 160408-00033 by Hiko : 新建程式
#                : 20160621 OTHER_FUNC   by Hiko : 解析section id內的'other_function'/'other_dialog'/'other_report'.

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"

TYPE T_FILE DYNAMIC ARRAY OF RECORD
            no       STRING, #行數 #為了變顏色,所以改成字串型態.
            line     STRING, #程式內容
            modify   CHAR(1),#異動標示:*,N:代表不可以編輯
            apt      STRING, #add point名稱
            section  STRING  #section名稱
            END RECORD

TYPE T_APT DYNAMIC ARRAY OF RECORD
           apt_name STRING,
           apt_no   INTEGER
           END RECORD 

DEFINE m_dgenv    STRING,
       m_date     DATETIME YEAR TO SECOND,
       m_customer STRING,
       m_topind   STRING,
       m_erpver   STRING

DEFINE m_dzaf     T_DZAF_T,
       m_prog     LIKE dzaf_t.dzaf001,
       m_json_apt util.JSONObject,
       mb_auth    BOOLEAN

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING,
          ls_4ad_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    
   
   CALL cl_tool_init()

   LET m_dgenv = FGL_GETENV("DGENV") CLIPPED
   LET m_date = cl_get_current()
   LET m_customer = FGL_GETENV("CUST") CLIPPED
   LET m_topind = FGL_GETENV("TOPIND") CLIPPED
   IF cl_null(m_topind) THEN
      LET m_topind = "sd"
   END IF
   LET m_erpver = FGL_GETENV("ERPVER")

   OPEN WINDOW w_adzi151 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   #CALL cl_load_4ad_interface(NULL) #為了使用原廠預設的搜尋工具, 所以將此段移除.
   #CALL cl_load_4ad_formlevel(g_code) #只有這樣呼叫, 才可以正常accept.
   #上面這兩行的load會影響find按下Enter直接搜尋的功能.

   #adzi151.4ad的內容 : adzi151.4ad.bk2
   #<ActionDefaultList>
   #  <ActionDefault name="find" defaultView="no" acceleratorName="control-f" />
   #  <ActionDefault name="findnext" defaultView="no" acceleratorName="F3"/>
   #  <ActionDefault name="controlg" defaultView="no" acceleratorName="control-g"/>
   #  <ActionDefault name="accept" acceleratorName="return" acceleratorName3="Enter"/>
   #  <!-- Qry Window -->
   #  <ActionDefault name="refresh" image="tb/openwin_refresh.gif" />
   #  <ActionDefault name="reconstruct" image="tb/openwin_reconstruct.gif" />
   #</ActionDefaultList>
   LET ls_4ad_path = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("ADZ"), "4ad"), g_lang), g_code||".4ad")
   CALL ui.Interface.loadActionDefaults(ls_4ad_path) #解決control-f與正常顯現開窗的圖示.

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET m_prog = ARG_VAL(2) #可以傳遞程式代號, 例如 r.vi axmt500.

   CALL adzi151_ui_dialog()

   CLOSE WINDOW w_adzi151 
END MAIN

PRIVATE FUNCTION adzi151_ui_dialog()
   DEFINE l_prog        LIKE dzaf_t.dzaf001,
          l_temp_prog   LIKE dzaf_t.dzaf001,
          lb_get_file   BOOLEAN,
          ls_file_path  STRING,
          la_file       T_FILE,
          la_file_color T_FILE,
          la_apt        T_APT,
          la_apt_color  T_APT,
          li_curr_no    INTEGER
   DEFINE ls_temp_line STRING,
          li_new_no    INTEGER,
          li_idx       INTEGER 
   DEFINE ls_go      STRING,
          li_i       INTEGER,
          lb_cont    BOOLEAN,
          li_go_no   INTEGER,
          lb_find_no BOOLEAN
   DEFINE la_multi_line DYNAMIC ARRAY OF STRING
   DEFINE ls_temp_modify CHAR(1)
   DEFINE li_j,li_k       INTEGER,
          json_modify_apt util.JSONObject,
          li_temp_j       INTEGER, #for li_j的起始索引
          ls_update_apt   STRING,  #需要更新的add point名稱
          lsb_code        base.StringBuffer,
          l_dzbb098       LIKE dzbb_t.dzbb098,
          lb_upd_success  BOOLEAN,
          ls_cmd          STRING,
          lb_result       BOOLEAN,
          ls_err_msg      STRING,
          ls_4gl_dir      STRING,
          lb_start_flag   BOOLEAN, #OTHER_FUNC
          lb_null_line    BOOLEAN

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT l_prog FROM bdt_prog #這裡若用m_prog的話, 則會導致BEFORE DIALOG內的m_prog變成NULL.
            ON ACTION controlp INFIELD bdt_prog
               LET l_temp_prog = l_prog
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               CALL q_adzp990()
               IF cl_null(g_qryparam.return1) THEN #表示開窗按下取消.
                  LET l_prog = l_temp_prog
               ELSE
                  LET l_prog = g_qryparam.return1
                  IF l_prog<>l_temp_prog THEN #表示開窗選擇不同程式代號.
                     IF la_file.getLength()>0 THEN
                        IF cl_ask_confirm("adz-00829") THEN #此動作會清空畫面, 請問是否確定要更換程式編輯?
                           INITIALIZE la_file TO NULL
                           INITIALIZE la_apt TO NULL
                           CALL adzi151_change_col_title("")
                           DISPLAY "" TO lbl_info
                        ELSE
                           LET l_prog = l_temp_prog #不換代號就還原.
                        END IF
                     END IF
                  END IF
               END IF

               LET m_prog = l_prog

            ON ACTION get_file
               IF NOT cl_null(m_prog) THEN
                  LET lb_get_file = TRUE
                  IF la_file.getLength()>0 THEN
                     LET lb_get_file = cl_ask_confirm("adz-00828") #此動作會刷新所做的任何異動, 請問是否要重新開啟程式?
                  END IF

                  IF lb_get_file THEN
                     CALL adzi151_get_file_path() RETURNING ls_file_path
                     IF NOT cl_null(ls_file_path) THEN
                        CALL adzi151_get_file(ls_file_path) RETURNING la_file,la_file_color,la_apt,la_apt_color
                     END IF
                  ELSE
                     LET l_prog = l_temp_prog
                     LET m_prog = l_prog
                  END IF
               END IF
               
         END INPUT

         INPUT ARRAY la_file FROM tbl_file.*
            BEFORE INPUT
               CALL DIALOG.setArrayAttributes("tbl_file", la_file_color) #為了變顏色.

               IF m_dzaf.dzaf005="M" THEN #主程式才需要測試程式.
                  CALL DIALOG.setActionActive("run_test", TRUE)
               ELSE
                  CALL DIALOG.setActionActive("run_test", FALSE)
               END IF

               IF mb_auth THEN
                  CALL DIALOG.setActionActive("save_compile", TRUE)
               ELSE
                  CALL DIALOG.setActionActive("save_compile", FALSE)
                  CALL DIALOG.setActionActive("del_line", FALSE)
                  CALL DIALOG.setActionActive("ins_multi_line", FALSE)
               END IF

            BEFORE ROW
               LET li_curr_no = ARR_CURR()
               LET ls_temp_line = la_file[li_curr_no].line
               LET ls_temp_modify = la_file[li_curr_no].modify
               #以上程式段不能放在最後, 要不然會跑不到.
               display "BEFORE ROW:apt_name=",la_file[li_curr_no].apt 
               IF la_file[li_curr_no].apt IS NOT NULL AND
                  (la_file[li_curr_no].modify IS NULL OR
                   la_file[li_curr_no].modify<>"N") THEN 
                  CALL cl_set_comp_entry("edt_line", TRUE)
                  CALL cl_set_comp_entry("edt_modify", FALSE)
                  IF mb_auth THEN
                     #IF la_file[li_curr_no].modify='*' THEN
                     IF cl_null(la_file[li_curr_no].no) THEN #真正新增加的行數才可以刪除.
                        CALL DIALOG.setActionActive("del_line", TRUE)
                     ELSE
                        CALL DIALOG.setActionActive("del_line", FALSE)
                     END IF
                     CALL DIALOG.setActionActive("ins_multi_line", TRUE)
                  END IF
                  NEXT FIELD edt_line
               ELSE
                  CALL cl_set_comp_entry("edt_line", FALSE)
                  CALL cl_set_comp_entry("edt_modify", TRUE)
                  IF mb_auth THEN
                     CALL DIALOG.setActionActive("del_line", FALSE)
                     CALL DIALOG.setActionActive("ins_multi_line", FALSE)
                  END IF
                  NEXT FIELD edt_modify
               END IF
          
            AFTER FIELD edt_line
               IF ls_temp_modify="N" THEN
                  LET la_file[li_curr_no].line = ls_temp_line #不能編輯的程式要還原
               ELSE
                  IF adzi151_chk_line(la_file[li_curr_no].line) THEN
                     IF NOT ls_temp_line.equals(la_file[li_curr_no].line) THEN #要改成equals,不然的話會判斷失效.
                        LET la_file[li_curr_no].modify = '*'
                        LET la_file_color[li_curr_no].no = "lightRed reverse"
                     END IF              
                  ELSE
                     NEXT FIELD edt_line
                  END IF              
               END IF              

            #modify識別欄位不可以編輯與異動
            AFTER FIELD edt_modify
               #可以編輯的情況一定不是合法的, 所以直接就改成NULL即可.
               #LET la_file[li_curr_no].modify = NULL
               IF ls_temp_modify='*' OR ls_temp_modify='N' THEN
                  LET la_file[li_curr_no].modify = ls_temp_modify
               ELSE
                  LET la_file[li_curr_no].modify = NULL
               END IF

            ON ACTION accept
               IF ls_temp_modify="N" THEN
                  LET la_file[li_curr_no].line = ls_temp_line #不能編輯的程式要還原
               ELSE
                  IF la_file[li_curr_no].apt IS NOT NULL THEN
                     IF adzi151_chk_line(la_file[li_curr_no].line) THEN
                        #要補上AFTER FIELD edt_line的程式段.
                        #IF la_file[li_curr_no].line<>ls_temp_line THEN
                        IF NOT ls_temp_line.equals(la_file[li_curr_no].line) THEN #要改成equals,不然的話會判斷失效.
                           LET la_file[li_curr_no].modify = '*'
                           LET la_file_color[li_curr_no].no = "lightRed reverse"
                        END IF              
                        
                        LET li_new_no = li_curr_no+1
                        CALL la_file.insertElement(li_new_no)
                        CALL la_file_color.insertElement(li_new_no)
                        CALL DIALOG.setCurrentRow("tbl_file", li_new_no)
                        LET la_file[li_new_no].line = NULL
                        LET la_file[li_new_no].modify = "*"
                        LET la_file[li_new_no].apt = la_file[li_curr_no].apt
                        LET la_file[li_new_no].section = la_file[li_curr_no].section
                        LET la_file_color[li_new_no].no = "lightRed reverse"
                        
                        LET li_curr_no = li_new_no
                        LET ls_temp_line = la_file[li_curr_no].line
                     END IF
                  END IF
               END IF
             
            ON ACTION controlg
               CALL cl_ask_prtmsg("adz-00825", g_lang) RETURNING ls_go #請輸入您要前往的指定行數 :
               IF NOT cl_null(ls_go) THEN
                  LET lb_cont = TRUE
                  #判斷輸入的指定行數值是合法的數字.
                  FOR li_i=1 TO ls_go.getLength()
                     IF ls_go.getCharAt(li_i) NOT MATCHES "[0-9]" THEN
                        LET lb_cont = FALSE
                        EXIT FOR
                     END IF
                  END FOR

                  IF lb_cont THEN
                     CALL adzi151_get_real_no(la_file, ls_go) RETURNING lb_find_no, li_go_no

                     IF lb_find_no THEN
                        CALL DIALOG.setCurrentRow("tbl_file", li_go_no)
                        #因為setCurrentRow不會觸發BEFORE,所以這邊就自己補做一次.
                        LET li_curr_no = li_go_no
                        LET ls_temp_line = la_file[li_curr_no].line
                        #以上程式段不能放在最後, 要不然會跑不到.
                        
                        IF la_file[li_curr_no].apt IS NOT NULL THEN
                           CALL cl_set_comp_entry("edt_line", TRUE)
                           CALL cl_set_comp_entry("edt_modify", FALSE)
                           NEXT FIELD edt_line
                        ELSE
                           CALL cl_set_comp_entry("edt_line", FALSE)
                           CALL cl_set_comp_entry("edt_modify", TRUE)
                           NEXT FIELD edt_modify
                        END IF
                     END IF
                  END IF #lb_cont
               END IF #NOT cl_null(ls_go)

            #單行刪除
            ON ACTION del_line 
               #有修改過的那一行才可以刪除, 可以避免ctrl-g行數對應不到的問題.
               #IF la_file[li_curr_no].modify="*" THEN
               IF cl_null(la_file[li_curr_no].no) THEN #真正新增加的行數才可以刪除.
                  IF cl_ask_delete() THEN
                     #可以刪除的地方一定不會是第一筆與最後一筆, 所以就單純處理即可.
                     IF la_file[li_curr_no].apt IS NOT NULL THEN #這裡只是防呆, 實際上不會沒有apt.
                        #判斷要刪除的是否為add point的最後一行.
                        IF la_file[li_curr_no+1].apt IS NULL THEN 
                           #若是最後一行, 繼續判斷此add point是否只有一行.
                           IF la_file[li_curr_no-1].apt IS NULL THEN
                              LET la_file[li_curr_no].line = "" #清除程式內容
                           ELSE
                              CALL la_file.deleteElement(li_curr_no)
                              CALL la_file_color.deleteElement(li_curr_no)
                              LET li_curr_no = li_curr_no - 1 #表示刪除的行數剛好是add point最後一行, 所以將ARR_CURR往上移動一行.
                           END IF
                        ELSE
                           CALL la_file.deleteElement(li_curr_no)
                           CALL la_file_color.deleteElement(li_curr_no)
                        END IF

                        CALL DIALOG.setCurrentRow("tbl_file", li_curr_no) #li_curr_no此時不會變, 所以不需要重新設定.

                        #要補上AFTER FIELD edt_line的程式段.
                        LET ls_temp_line = la_file[li_curr_no].line
                        LET la_file[li_curr_no].modify = "*" #強制變成修改狀態, 這可以避免更新資料的時候出錯.
                        #以上程式段不能放在最後, 要不然會跑不到.
                        
                        IF la_file[li_curr_no].apt IS NOT NULL THEN
                           CALL cl_set_comp_entry("edt_line", TRUE)
                           CALL cl_set_comp_entry("edt_modify", FALSE)
                           NEXT FIELD edt_line
                        ELSE
                           CALL cl_set_comp_entry("edt_line", FALSE)
                           CALL cl_set_comp_entry("edt_modify", TRUE)
                           NEXT FIELD edt_modify
                        END IF
                     END IF
                  END IF
               END IF

            #多行插入
            ON ACTION ins_multi_line
               LET li_new_no = 0
               CALL adzi151_multi_ins() RETURNING la_multi_line
               FOR li_i=1 TO la_multi_line.getLength()
                  LET li_new_no = li_curr_no + li_i #多行插入是從ARR_CURR()行的下一行開始插入.
                  CALL la_file.insertElement(li_new_no)
                  CALL la_file_color.insertElement(li_new_no)
                  CALL DIALOG.setCurrentRow("tbl_file", li_new_no)
                  LET la_file[li_new_no].line = la_multi_line[li_i]
                  LET la_file[li_new_no].modify = "*"
                  LET la_file[li_new_no].apt = la_file[li_curr_no].apt
                  LET la_file[li_new_no].section = la_file[li_curr_no].section
                  LET la_file_color[li_new_no].no = "lightRed reverse"
               END FOR

            #存檔並編譯.
            ON ACTION save_compile
               IF mb_auth THEN
                  LET json_modify_apt = util.JSONObject.create()
                  FOR li_j=1 TO la_file.getLength()
                     IF la_file[li_j].modify='*' THEN
                        CALL json_modify_apt.put(la_file[li_j].apt, la_file[li_j].no) #這裡只是要利用JSONObject的put的唯一Key特性來暫存有異動的add point名稱.
                     END IF
                  END FOR

                  IF json_modify_apt.getLength()>0 THEN
                     IF cl_ask_confirm_parm("adz-00803", m_prog) THEN #請問是否要將%1所做的異動更新到資料庫?
                        BEGIN WORK
                        LET lsb_code = base.StringBuffer.create()
                        LET li_temp_j = 1
                        FOR li_k=1 TO json_modify_apt.getLength()
                           LET ls_update_apt = json_modify_apt.name(li_k)
                           CALL lsb_code.clear() #OTHER_FUNC
                           LET lb_null_line = TRUE
                           LOCATE l_dzbb098 IN FILE
                           #取得目前畫面上的add point內容
                           FOR li_j=li_temp_j TO la_file.getLength()   
                              IF la_file[li_j].apt=ls_update_apt THEN
                                 #Begin:OTHER_FUNC:主要是為了取得第一個非空白行所做的判斷.
                                 IF lb_null_line THEN
                                    CALL cl_null(la_file[li_j].line) RETURNING lb_null_line
                                    IF NOT lb_null_line THEN #遇到第一個不是空白行的字串就不能增加斷行符號,以免多空一行.
                                       CALL lsb_code.append(la_file[li_j].line)
                                       CONTINUE FOR
                                    END IF
                                 END IF

                                 IF lb_null_line THEN
                                    CALL lsb_code.append("\n")
                                 ELSE
                                    CALL lsb_code.append("\n")
                                    CALL lsb_code.append(la_file[li_j].line)
                                 END IF
                                 #End:OTHER_FUNC
                              ELSE
                                 IF lsb_code.getLength()>0 THEN #表示已經開始逐行收集程式了.
                                    LET li_temp_j = li_j #給下個add point比對時使用.
                                    EXIT FOR
                                 END IF
                              END IF
                           END FOR 
                  
                           LET l_dzbb098 = lsb_code.toString()
                           #將程式內容更新到資料庫.
                           LET lb_upd_success = TRUE
                           IF NOT adzi151_update_apt(ls_update_apt, l_dzbb098) THEN
                              LET lb_upd_success = FALSE
                              EXIT FOR
                           END IF
                           #CALL lsb_code.clear()
                           FREE l_dzbb098
                        END FOR
                  
                        IF lb_upd_success THEN
                           COMMIT WORK
                           #程式重組合.
                           LET ls_cmd = "r.c3 ",m_prog," ","''"," ",m_dzaf.dzaf004," 2 ",m_dzaf.dzaf010
                           DISPLAY "adzi151 : ",ls_cmd
                           CALL cl_cmdrun_openpipe("r.c3", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg #有錯誤就忽略.
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "adz-00830" #%1 已經更新第%2版的程式設計資料, 並且已經重新組合4gl.
                           LET g_errparam.replace[1] = m_prog
                           LET g_errparam.replace[2] = m_dzaf.dzaf004
                           LET g_errparam.popup = TRUE
                           CALL cl_err() 
                        ELSE
                           ROLLBACK WORK
                        END IF
                     END IF
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00802" #沒有任何異動,不需要更新到資料庫.
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               END IF
            
            #測試程式.
            ON ACTION run_test
               LET lb_result = TRUE
               IF cl_ask_confirm("adz-00843") THEN #請問測試之前是否要先進行編譯?
                  LET ls_4gl_dir = os.path.JOIN(FGL_GETENV(UPSHIFT(m_dzaf.dzaf006)), "4gl")
                  DISPLAY "adzi151 : change dir to ",ls_4gl_dir
                  CALL cl_change_dir(ls_4gl_dir) RETURNING lb_result
                  IF lb_result THEN
                     LET ls_cmd = "r.c ",m_prog
                     DISPLAY "adzi151 : ",ls_cmd
                     CALL cl_cmdrun_openpipe("r.r", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
                     IF lb_result THEN
                        LET ls_cmd = "r.l ",m_prog
                        DISPLAY "adzi151 : ",ls_cmd
                        CALL cl_cmdrun_openpipe("r.r", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
                     END IF
                  END IF
               END IF

               IF lb_result THEN
                  LET ls_cmd = "r.r ",m_prog
                  DISPLAY "adzi151 : ",ls_cmd
                  CALL cl_cmdrun_openpipe("r.r", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg #有錯誤就忽略.
               END IF

            #程式資訊
            ON ACTION prog_info
               CALL adzi151_prog_info()

         END INPUT

         DISPLAY ARRAY la_apt TO tbl_apt.*
            BEFORE DISPLAY
               CALL DIALOG.setArrayAttributes("tbl_apt", la_apt_color) #為了變顏色.

            BEFORE ROW
               CALL adzi151_get_real_no(la_file, la_apt[ARR_CURR()].apt_no+1) RETURNING lb_find_no, li_go_no #OTHER_FUNC:指到add point的下一行可編輯行數上.

               IF lb_find_no THEN
                  CALL DIALOG.setCurrentRow("tbl_file", li_go_no)
                  #因為setCurrentRow不會觸發BEFORE,所以這邊就自己補做一次.
                  LET li_curr_no = li_go_no
                  LET ls_temp_line = la_file[li_curr_no].line
                  #以上程式段不能放在最後, 要不然會跑不到.
                  
                  IF la_file[li_curr_no].apt IS NOT NULL THEN
                     CALL cl_set_comp_entry("edt_line", TRUE)
                     CALL cl_set_comp_entry("edt_modify", FALSE)
                     NEXT FIELD edt_line
                  ELSE
                     CALL cl_set_comp_entry("edt_line", FALSE)
                     CALL cl_set_comp_entry("edt_modify", TRUE)
                     NEXT FIELD edt_modify
                  END IF
               END IF
         END DISPLAY

         ON ACTION CLOSE
            IF cl_ask_confirm("adz-00261") THEN #是否離開程式?
               LET g_action_choice="exit"
               EXIT DIALOG
            END IF

         ON ACTION exit
            IF cl_ask_confirm("adz-00261") THEN #是否離開程式?
               LET g_action_choice="exit"
               EXIT DIALOG
            END IF

         BEFORE DIALOG                
            CLEAR FORM

            IF NOT cl_null(m_prog) THEN
               CALL adzi151_get_file_path() RETURNING ls_file_path
               IF NOT cl_null(ls_file_path) THEN
                  LET l_prog = m_prog
                  LET l_temp_prog = l_prog
                  CALL adzi151_get_file(ls_file_path) RETURNING la_file,la_file_color,la_apt,la_apt_color
               END IF
            END IF

         END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

#取得實際的檔案位置.
FUNCTION adzi151_get_file_path()
   DEFINE l_cons_type  LIKE dzaf_t.dzaf005,
          l_module     LIKE dzaf_t.dzaf006 
   DEFINE ls_sql       STRING,
          ls_sql_base  STRING,
          ls_sql_cond  STRING,
          ls_err_msg   STRING,
          ls_file_path STRING 
   DEFINE la_dzba      DYNAMIC ARRAY OF RECORD
                       dzba003 LIKE dzba_t.dzba003,
                       dzba005 LIKE dzba_t.dzba005,
                       dzba007 LIKE dzba_t.dzba007
                       END RECORD,
          li_i         INTEGER,
          ls_modi_flag STRING 

   INITIALIZE m_dzaf TO NULL

   #取得建構類型與對應模組:有客製就以客製為主.
   LET ls_sql_base = "SELECT distinct dzaf005,dzaf006 FROM dzaf_t WHERE dzaf001='",m_prog CLIPPED,"'"
   LET ls_sql_cond = " AND dzaf010='c'"
   LET ls_sql = ls_sql_base,ls_sql_cond
   PREPARE dzaf_prep1 FROM ls_sql
   EXECUTE dzaf_prep1 INTO l_cons_type,l_module
   FREE dzaf_prep1

   IF cl_null(l_cons_type) THEN #找不到客製再找標準.
      LET ls_sql_cond = " AND dzaf010='s'"
      LET ls_sql = ls_sql_base,ls_sql_cond
      PREPARE dzaf_prep2 FROM ls_sql
      EXECUTE dzaf_prep2 INTO l_cons_type,l_module
      FREE dzaf_prep2
   END IF
   
   IF cl_null(l_cons_type) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00832" #找不到建構類型!
      LET g_errparam.popup = TRUE
      CALL cl_err() 

      RETURN NULL
   END IF

   CALL sadzp060_2_get_curr_ver_info(m_prog, l_cons_type, l_module) RETURNING m_dzaf.*,ls_err_msg
   IF NOT cl_null(ls_err_msg) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00833" #取得版次資料過程出現錯誤!
      LET g_errparam.popup = TRUE
      CALL cl_err() 

      RETURN NULL
   END IF
    
   IF m_dzaf.dzaf005="F" THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00834" #子畫面沒有程式需要編輯!
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      
      RETURN NULL
   END IF

   LET ls_file_path = os.path.join(os.path.join(FGL_GETENV(m_dzaf.dzaf006), "4gl"), m_prog||".4gl")
   DISPLAY "ls_file_path=",ls_file_path
   IF NOT os.Path.exists(ls_file_path) THEN 
      DISPLAY "找不到檔案:",ls_file_path
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00835" #找不到檔案 %1 !
      LET g_errparam.replace[1] = m_prog
      LET g_errparam.popup = TRUE
      CALL cl_err() 

      RETURN NULL
   END IF

   CALL adzi151_change_col_title(ls_file_path)

   #取得資料庫可編輯的add point清單 : dzba005(使用標示),dzba007(引用)
   #DGENV=s,TOPIND = sd : 可編輯dzba005=s的add point, 但不可以編輯客製的define段落.(名稱最後為define_customerization)
   #              != sd : 可編輯dzba005=s且dzba007=N的add point, 但不可以編輯客製的define段落.(名稱最後為define_customerization)
   #DGENV=c : 可編輯所有add point, 但不可以編輯標準的define段落.(名稱最後為define)
   LET ls_sql_base = "SELECT dzba003,dzba005,dzba007 FROM dzba_t",
                     " WHERE dzba001='",m_dzaf.dzaf001,"'",
                     "   AND dzba002=",m_dzaf.dzaf004,
                     "   AND dzba010='",m_dzaf.dzaf010,"'"
   #IF m_dgenv="s" THEN #不能事先就將add point清單過濾掉, 以免從4gl取得的清單無法辨識出是否真的可以編輯. 因為不存在於dzba_t內的add point通常都是可以編輯的.
   #   LET ls_sql_cond = " AND dzba005='s'"
   #   IF m_topind<>"sd" THEN
   #      LET ls_sql_cond = ls_sql_cond," AND dzba007='N'" #行業環境只能編輯'斷開引用'的程式區塊.
   #   END IF
   #END IF
   
   LET ls_sql = ls_sql_base," ORDER BY dzba003"
   PREPARE dzba_prep FROM ls_sql
   DECLARE dzba_curs CURSOR FOR dzba_prep
   LET m_json_apt = util.JSONObject.create()
   LET li_i = 1
   FOREACH dzba_curs INTO la_dzba[li_i].*
      IF m_dgenv="s" THEN
         IF m_topind<>"sd" THEN
            #行業區域若是引用, 則不可以編輯.
            IF la_dzba[li_i].dzba007='Y' THEN
               LET ls_modi_flag = "N"
            ELSE
               LET ls_modi_flag = "Y"
            END IF
         ELSE
            IF la_dzba[li_i].dzba005='c' THEN
               LET ls_modi_flag = "N"
            ELSE
               LET ls_modi_flag = "Y"
            END IF
         END IF
      ELSE
         LET ls_modi_flag = "Y" #客製環境原則上都可以編輯.
      END IF

      CALL m_json_apt.put(la_dzba[li_i].dzba003, ls_modi_flag)

      LET li_i = li_i + 1
   END FOREACH
   CALL la_dzba.deleteElement(li_i)

   #順便檢查是否有程式簽出權限.
   LET mb_auth = TRUE
   CALL sadzp060_2_have_checked_out(m_prog, l_cons_type, "PR", 0) RETURNING ls_err_msg
   IF NOT cl_null(ls_err_msg) THEN
      LET mb_auth = FALSE
      LET ls_err_msg = cl_getmsg("adz-00827", g_lang) #您還沒有簽出程式!
   ELSE
      LET ls_err_msg = cl_getmsg("adz-00831", g_lang) #您具有異動程式的權限!
   END IF

   DISPLAY ls_err_msg TO lbl_info

   RETURN ls_file_path
END FUNCTION

FUNCTION adzi151_change_col_title(p_file_path)
   DEFINE p_file_path STRING
   DEFINE lwin_curr   ui.Window,
          lnode_win   om.DomNode,
          lst_item    om.NodeList,
          li_i        INTEGER,
          l_item      om.DomNode,
          ls_col_name STRING,
          ls_text     STRING

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
   LET lst_item = lnode_win.selectByTagName("TableColumn") #這是以42f的角度來查看的.
   FOR li_i=1 TO lst_item.getLength()
      LET l_item = lst_item.item(li_i)
      LET ls_col_name = l_item.getAttribute("colName")
      IF ls_col_name="edt_line" THEN
         CALL l_item.setAttribute("text", p_file_path)
         EXIT FOR
      END IF
   END FOR
END FUNCTION

FUNCTION adzi151_get_file(p_file_path)
   DEFINE p_file_path STRING
   DEFINE lch_file        base.Channel,
          ls_line         STRING,
          ls_line_trim    STRING,
          ls_lowercase    STRING,
          la_file         T_FILE,
          la_file_color   T_FILE,
          li_idx          INTEGER,
          li_section_idx  INTEGER,
          li_identify_idx INTEGER,
          ls_section_id   STRING,
          li_end_section_idx INTEGER, #OTHER_FUNC
          li_apt_idx      INTEGER,
          ls_apt_desc     STRING,
          li_apt_name_idx INTEGER,
          ls_apt_name     STRING,
          li_end_idx      INTEGER,
          la_apt          T_APT,
          la_apt_color    T_APT,
          li_j            INTEGER,
          lb_set_color    BOOLEAN
   #Begin:OTHER_FUNC
   DEFINE li_dot_idx    INTEGER,
          lb_other_func BOOLEAN,
          lb_other_dialog BOOLEAN,
          lb_other_report BOOLEAN,
          li_increase_idx INTEGER,
          ls_key_prev     STRING,
          li_f          INTEGER,
          la_func_no    DYNAMIC ARRAY OF INTEGER,
          li_f_no       INTEGER
   #End:OTHER_FUNC

   #TRY #OTHER_FUNC
      LET lch_file = base.Channel.create()
      CALL lch_file.openFile(p_file_path, "r")
      LET li_idx = 1
      LET li_j = 0
      LET lb_set_color = FALSE
      LET lb_other_func = FALSE #OTHER_FUNC
      LET lb_other_dialog = FALSE #OTHER_FUNC
      LET lb_other_report = FALSE #OTHER_FUNC

      WHILE TRUE
         LET ls_line = lch_file.readLine()
         IF lch_file.isEof() THEN
            EXIT WHILE
         END IF
         
         LET ls_line_trim = ls_line.trim() #OTHER_FUNC

         LET ls_lowercase = ls_line.toLowerCase()
         #IF NOT lb_other_func THEN #OTHER_FUNC:改用別的方式判斷
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
                     #LET lb_other_func = TRUE #OTHER_FUNC
         
                     LET ls_apt_name = NULL
                     LET la_file[li_idx].no = li_idx
                     LET la_file[li_idx].line = ls_line
                     LET la_file[li_idx].apt = NULL
                     LET la_file[li_idx].section = NULL
                     LET la_file[li_idx].modify = "N"
                     LET la_file_color[li_idx].no = "lightGray reverse"
                     
                     LET li_idx = li_idx + 1 
                     CONTINUE WHILE
                  END IF
               END IF #li_dot_idx>0
               #End:OTHER_FUNC
            END IF #li_identify_idx>0
         ELSE #OTHER_FUNC
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

               LET la_file[li_idx].no = li_idx
               LET la_file[li_idx].line = ls_line
               LET la_file[li_idx].apt = ls_apt_name
               LET la_file[li_idx].section = ls_section_id
               LET la_file[li_idx].modify = "N"
               LET la_file_color[li_idx].no = "lightGray reverse"
               
               LET li_idx = li_idx + 1
               CONTINUE WHILE
            END IF
         END IF #li_section_idx>0
         #END IF #NOT lb_other_func
         
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
                     LET li_j = li_j + 1
                     LET la_apt[li_j].apt_name = ls_apt_name
                     LET la_apt[li_j].apt_no = li_idx
                     LET lb_set_color = TRUE

                     #將function name之前的行數重新設定其add point.
                     FOR li_f=1 TO la_func_no.getLength()
                        LET li_f_no = la_func_no[li_f]
                        LET la_file[li_f_no].apt = ls_apt_name
                        LET la_file[li_f_no].modify = "N"
                        LET la_file_color[li_f_no].no = "lightGray reverse" #function name之前的範圍在此工具都不可以編輯.
                     END FOR
                     CALL la_func_no.clear()

                     LET la_file[li_idx].no = li_idx
                     LET la_file[li_idx].line = ls_line
                     LET la_file[li_idx].apt = ls_apt_name
                     LET la_file[li_idx].section = ls_section_id
                     LET la_file[li_idx].modify = "N"
                     LET la_file_color[li_idx].no = "lightGray reverse"
                     
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
                  LET la_file[li_idx].no = li_idx
                  LET la_file[li_idx].line = ls_line
                  LET la_file[li_idx].apt = ls_apt_name
                  LET la_file[li_idx].section = ls_section_id
                  LET la_file[li_idx].modify = "N"
                  LET la_file_color[li_idx].no = "lightGray reverse"
                  
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
            
                  LET li_j = li_j + 1
                  LET la_apt[li_j].apt_name = ls_apt_name
                  LET la_apt[li_j].apt_no = li_idx
                  LET lb_set_color = TRUE
               ELSE
                  LET ls_apt_desc = ls_line_trim.subString(li_apt_idx, ls_line_trim.getLength())
               END IF
               #End:OTHER_FUNC
               #add-point標示本身是屬於SECTION的內容, 所以要剃除.
               LET la_file[li_idx].no = li_idx
               LET la_file[li_idx].line = ls_line
               LET la_file[li_idx].apt = NULL
               LET la_file[li_idx].section = NULL
               LET la_file[li_idx].modify = "N"
               LET la_file_color[li_idx].no = "lightGray reverse"
            
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
         
         LET la_file[li_idx].no = li_idx
         LET la_file[li_idx].line = ls_line
         LET la_file[li_idx].apt = ls_apt_name
         LET la_file[li_idx].section = ls_section_id

         IF NOT adzi151_can_modify(ls_apt_name) THEN
            LET la_file[li_idx].modify = "N"
            LET la_file_color[li_idx].no = "lightGray reverse"
         ELSE
            LET la_file_color[li_idx].no = "lightGreen reverse"
         END IF

         IF lb_set_color THEN
            IF la_file[li_idx].modify="N" THEN
               LET la_apt_color[li_j].apt_name = "lightGray"
            END IF

            LET lb_set_color = FALSE
         END IF

         LET li_idx = li_idx + 1 
      END WHILE
      
      CALL lch_file.close()

      IF la_apt.getLength()=0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00842" #此程式(4gl)找不到add-point名稱, 請透過設計器重新產生程式, 或確認樣版是否正確.
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
  #CATCH
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code = "adz-00339" #%1檔案不存在.
  #   LET g_errparam.replace[1] = p_file_path," " #空一格訊息比較清楚.
  #   LET g_errparam.popup = TRUE
  #   CALL cl_err()
  #END TRY

   RETURN la_file,la_file_color,la_apt,la_apt_color
END FUNCTION

#判斷當下的add point是否可以編輯.
FUNCTION adzi151_can_modify(p_apt)
   DEFINE p_apt STRING
   DEFINE lb_modi_flag BOOLEAN

   LET lb_modi_flag = TRUE
   
   IF cl_null(p_apt) THEN
      LET lb_modi_flag = FALSE
   ELSE
      #可編輯的add point清單 : dzba005(使用標示),dzba007(引用)
      #DGENV=s,TOPIND = sd : 可編輯dzba005=s的add point, 但不可以編輯客製的define段落.(名稱最後為define_customerization)
      #              != sd : 可編輯dzba005=s且dzba007=N的add point, 但不可以編輯客製的define段落.(名稱最後為define_customerization)
      #DGENV=c : 可編輯所有add point, 但不可以編輯標準的define段落.(名稱最後為define)
      IF NOT m_json_apt.has(p_apt) THEN #若不存在於可編輯清單, 則幾乎都可以編輯.
         IF m_dgenv="s" THEN
            IF p_apt.getIndexOf(".define_customerization", 1)>0 THEN
               LET lb_modi_flag = FALSE
            END IF
        #ELSE #m_dgenv="c" #客製環境不控卡, 都可以編輯.
        #   #最後7個字元為".define"才是關注目標.
        #   IF p_apt.subString(p_apt.getLength()-7+1, p_apt.getLength())=".define" THEN
        #      LET lb_modi_flag = FALSE
        #   END IF
         END IF
      ELSE
         IF m_json_apt.get(p_apt)="N" THEN
            LET lb_modi_flag = FALSE
         END IF
      END IF
   END IF

   RETURN lb_modi_flag
END FUNCTION

FUNCTION adzi151_get_real_no(p_file, p_no)
   DEFINE p_file T_FILE,
          p_no   INTEGER
   DEFINE li_idx     INTEGER,
          lb_cont    BOOLEAN,
          li_go_no   INTEGER,
          lb_find_no BOOLEAN

   LET li_go_no = 0
   LET lb_find_no = FALSE
   #先粗淺判斷輸入的數字是否大於實際資料數, 以節省比較時間.
   IF p_no<=p_file.getLength() THEN
      FOR li_idx=p_no TO p_file.getLength()
         IF p_file[li_idx].no MATCHES "*[0-9]*" THEN #p_no實際對應到的no有可能是NULL
            IF p_file[li_idx].no=p_no THEN
               LET li_go_no = p_file[li_idx].no + li_go_no
               LET lb_find_no = TRUE
               EXIT FOR
            END IF
         END IF
      
         LET li_go_no = li_go_no + 1
      END FOR
   END IF
   
   IF NOT lb_find_no THEN #這情況通常就是輸入的行數大於紀錄的行數
      LET li_go_no = 0
      FOR li_idx=p_file.getLength() TO 1 STEP -1
         IF p_file[li_idx].no MATCHES "*[0-9]*" THEN
            LET li_go_no = p_file.getLength() - li_go_no #找到最大的p_file對應的no
            LET lb_find_no = TRUE
            EXIT FOR
         END IF

         LET li_go_no = li_go_no + 1      
      END FOR
   END IF

   RETURN lb_find_no,li_go_no
END FUNCTION

#檢查程式內容是否合法.
FUNCTION adzi151_chk_line(p_line)
   DEFINE p_line STRING
   DEFINE lb_legal BOOLEAN,
          ls_key   STRING

   LET lb_legal = TRUE
   LET p_line = p_line.toLowerCase() #先轉換成小寫再來檢查.

   LET ls_key = "section"
   IF p_line.getIndexOf(ls_key, 1)>0 THEN
      LET lb_legal = FALSE
   END IF

   IF lb_legal THEN
      LET ls_key = "add-point"
      IF p_line.getIndexOf(ls_key, 1)>0 THEN
         LET lb_legal = FALSE
      END IF
   END IF

   IF lb_legal THEN
      LET ls_key = "function"
      IF p_line.getIndexOf(ls_key, 1)>0 THEN
         LET lb_legal = FALSE
      END IF
   END IF

   IF lb_legal THEN
      LET ls_key = "dialog"
      IF p_line.getIndexOf(ls_key, 1)>0 THEN
         LET lb_legal = FALSE
      END IF
   END IF

   IF lb_legal THEN
      LET ls_key = "report"
      IF p_line.getIndexOf(ls_key, 1)>0 THEN
         LET lb_legal = FALSE
      END IF
   END IF

   IF NOT lb_legal THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00841" #異動的程式存在不合法字串 %1, 麻煩請修正.
      LET g_errparam.replace[1] = ls_key
      LET g_errparam.popup = TRUE
      CALL cl_err() 
   END IF

   RETURN lb_legal
END FUNCTION

FUNCTION adzi151_multi_ins()
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   DEFINE ls_code       STRING,
          la_multi_line DYNAMIC ARRAY OF STRING,
          l_token       base.StringTokenizer,
          li_i          INTEGER,
          lb_legal      BOOLEAN

   OPEN WINDOW w_adzi151_s01 WITH FORM cl_ap_formpath("adz", "adzi151_s01")

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   INPUT ls_code FROM txt_code ATTRIBUTES ( UNBUFFERED )
      ON ACTION confirm_ins
         LET lb_legal = TRUE
         LET l_token = base.StringTokenizer.createExt(ls_code, "\n", "\\",TRUE) #這種方式才會保留空白行.
         LET li_i = 0
         WHILE l_token.hasMoreTokens()
            LET li_i = li_i + 1
            LET la_multi_line[li_i] = l_token.nextToken()
            IF NOT adzi151_chk_line(la_multi_line[li_i]) THEN
               LET lb_legal = FALSE
               EXIT WHILE
            END IF
         END WHILE

         IF lb_legal THEN
            EXIT INPUT
         END IF

      ON ACTION exit
         EXIT INPUT
   END INPUT

   CLOSE WINDOW w_adzi151_s01

   RETURN la_multi_line
END FUNCTION

FUNCTION adzi151_prog_info()
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   DEFINE lo_prog_info  T_PROGRAM_INFO,
          lo_dzlm       T_DZLM_T,
          l_code_chkout LIKE gzxa_t.gzxa002,
          l_code_ver    LIKE dzaf_t.dzaf004,
          l_module      LIKE dzaf_t.dzaf006,
          l_cust        LIKE dzaf_t.dzaf010,
          ls_sql        STRING,
          l_freestyle   LIKE dzax_t.dzax003,
          li_cnt        INTEGER,
          l_section     CHAR(1)

   IF NOT cl_null(m_dzaf.dzaf001) THEN
      OPEN WINDOW w_adzi151_s02 WITH FORM cl_ap_formpath("adz", "adzi151_s02")
      
      CALL cl_ui_wintitle(1) #工具抬頭名稱
      
      LET lw_window = ui.Window.getCurrent()
      LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
      CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
      
      #取得程式相關資料.
      LET lo_prog_info.pi_name = m_dzaf.dzaf001
      LET lo_prog_info.pi_type = m_dzaf.dzaf005
      CALL sadzp200_alm_get_dzlm(lo_prog_info.*, "PR") RETURNING lo_dzlm.*
      IF NOT cl_null(lo_dzlm.dzlm011) AND lo_dzlm.dzlm011="O" THEN
         LET l_code_chkout = lo_dzlm.dzlm010
      END IF

      LET l_code_ver = m_dzaf.dzaf004
      LET l_module = m_dzaf.dzaf006
      LET l_cust = m_dzaf.dzaf010

      #取得Free Style紀錄.
      SELECT dzax003 INTO l_freestyle FROM dzax_t
       WHERE dzax001=m_dzaf.dzaf001 AND dzax006=m_dzaf.dzaf010

      #判斷是否解開Section.
      SELECT count(*) INTO li_cnt FROM dzbc_t
       WHERE dzbc001=m_dzaf.dzaf001 AND dzbc002=m_dzaf.dzaf004 AND dzbc007=m_dzaf.dzaf010 AND dzbc005 IN ('m','c')

      IF li_cnt=0 THEN
         LET l_section = 'N'
      ELSE
         LET l_section = 'Y'
      END IF

      DISPLAY l_code_chkout,l_code_ver,l_module,l_cust,l_freestyle,l_section
           TO edt_code_chkout,edt_code_ver,edt_module,chk_cust,chk_freestyle,chk_section
      
      MENU 
         ON ACTION cancel
            EXIT MENU
      END MENU
      
      CLOSE WINDOW w_adzi151_s02
   END IF
END FUNCTION

#+ 更新程式到資料庫
FUNCTION adzi151_update_apt(p_apt_name, p_apt)
   DEFINE p_apt_name LIKE dzbb_t.dzbb002,
          p_apt      LIKE dzbb_t.dzbb098
   DEFINE ls_where STRING,
          ls_sql   STRING,
          li_cnt   INTEGER,
          ls_table STRING 

   TRY
      DISPLAY "adzi151_update_apt:p_apt_name=",p_apt_name
      #更新dzbb_t
      LET ls_table = "dzbb_t"
      LET ls_where = " WHERE dzbb001='",m_prog,"' AND dzbb002='",p_apt_name,"' AND dzbb003=",m_dzaf.dzaf004," AND dzbb004='",m_dzaf.dzaf010,"'"
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
                                 " VALUES('",m_prog,"','",p_apt_name,"',",m_dzaf.dzaf004,",'",m_dzaf.dzaf010,"','",m_customer,"','','',", 
                                         "?,'",g_dept,"','",g_dept,"','",g_user,"','Y','",g_user,"')"
      END IF
      PREPARE dzbb_prep2 FROM ls_sql
      EXECUTE dzbb_prep2 USING m_date
      FREE dzbb_prep2
      LET ls_sql = NULL      

      UPDATE dzbb_t 
         SET dzbb098=p_apt
       WHERE dzbb001=m_prog AND
             dzbb002=p_apt_name AND
             dzbb003=m_dzaf.dzaf004 AND
             dzbb004=m_dzaf.dzaf010 
      
      #更新dzba_t
      LET ls_table = "dzba_t"
      LET ls_where = " WHERE dzba001='",m_prog,"' AND dzba002=",m_dzaf.dzaf004," AND dzba003='",p_apt_name,"' AND dzba010='",m_dzaf.dzaf010,"'"
      LET ls_sql = "SELECT count(*) FROM dzba_t",ls_where
      PREPARE dzba_prep1 FROM ls_sql
      EXECUTE dzba_prep1 INTO li_cnt
      FREE dzba_prep1
      
      IF li_cnt>0 THEN #資料已存在.
         LET ls_sql = "UPDATE dzba_t",
                        " SET dzba004=",m_dzaf.dzaf004,",",
                             "dzba005='",m_dgenv,"',",
                             "dzba007='N',",
                             "dzbamoddt=?,", 
                             "dzbamodid='",g_user,"' ",ls_where
      ELSE
         LET ls_sql = "INSERT INTO dzba_t(dzba001,dzba002,dzba003,dzba004,dzba005,",
                                         "dzba006,dzba007,dzba008,dzba009,dzba010,dzba011,",
                                         "dzbacrtdt,dzbacrtdp,dzbaowndp,dzbaownid,dzbastus,dzbacrtid)",
                                 " VALUES('",m_prog,"',",m_dzaf.dzaf004,",'",p_apt_name,"',",m_dzaf.dzaf004,",'",m_dzaf.dzaf010,"',", 
                                         "'','N','",m_erpver,"','','",m_dzaf.dzaf010,"','",m_customer,"',",
                                         "?,'",g_dept,"','",g_dept,"','",g_user,"','Y','",g_user,"')"
      END IF
      PREPARE dzba_prep2 FROM ls_sql
      EXECUTE dzba_prep2 USING m_date
      FREE dzba_prep2
      LET ls_sql = NULL      

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
