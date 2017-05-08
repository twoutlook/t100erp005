#+ 程式版本......: 
#
#+ 程式代碼......: adzq052
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzq052.4gl
# Description    : 檢視程式組成結構
# Modify         : 20160505 160504-00011 by Hiko : 新建程式

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE m_prog      LIKE dzaf_t.dzaf001, #程式代號
       m_code_ver  LIKE dzaf_t.dzaf004, #程式版次:這只是為了接受呼叫端的參數而設定, 要在一開啟畫面的時候即時帶出結構清單.
       m_cust_flag LIKE dzaf_t.dzaf010  #客製標示:理由同m_code_ver
DEFINE ma_prog_info DYNAMIC ARRAY OF RECORD 
                    code_ver  LIKE dzaf_t.dzaf004, #程式版次
                    cust_flag LIKE dzaf_t.dzaf010  #客製標示
                    END RECORD

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    
   
   CALL cl_tool_init()

   LET m_prog = ARG_VAL(2)
   LET m_code_ver = ARG_VAL(3)
   LET m_cust_flag = ARG_VAL(4)

   OPEN WINDOW w_adzq052 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL) #為了使用原廠預設的搜尋工具, 所以將此段移除, 但會影響accept的功能與開窗的圖示, 所以暫時先用.

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzq052_ui_dialog()

   CLOSE WINDOW w_adzq052 
END MAIN

PRIVATE FUNCTION adzq052_ui_dialog()
   DEFINE l_prog       LIKE dzaf_t.dzaf001,
          l_temp_prog  LIKE dzaf_t.dzaf001,
          li_arr_curr  SMALLINT,
          la_apt       DYNAMIC ARRAY OF RECORD
                       apt       LIKE dzba_t.dzba003,
                       apt_ver   LIKE dzba_t.dzba004,
                       apt_flag  LIKE dzba_t.dzba005,
                       code      LIKE dzbb_t.dzbb098
                       END RECORD,
          la_section   DYNAMIC ARRAY OF RECORD
                       section   LIKE dzbc_t.dzbc003,
                       apt_ver   LIKE dzbc_t.dzbc004,
                       apt_flag  LIKE dzbc_t.dzbc005,
                       code      LIKE dzbd_t.dzbd098
                       END RECORD,
          li_i         SMALLINT

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT l_prog FROM btd_prog ATTRIBUTE(WITHOUT DEFAULTS)
            ON ACTION controlp INFIELD btd_prog
               LET l_temp_prog = l_prog

               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i' #開窗單選單回傳
               CALL q_adzp063_a()
               LET l_prog = g_qryparam.return1
               LET m_prog = l_prog
               DISPLAY m_prog TO btd_prog
               NEXT FIELD btd_prog

            AFTER FIELD btd_prog
               IF l_temp_prog<>l_prog THEN
                  #不論存不存在, 都先將畫面資料清空.
                  CLEAR FORM
                  INITIALIZE ma_prog_info TO NULL
                  LET m_prog = NULL
                  INITIALIZE la_apt TO NULL
                  INITIALIZE la_section TO NULL
                  DISPLAY '' TO txt_code
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_prog
                  IF cl_chk_exist("v_dzaf001") THEN
                     LET m_prog = l_prog
                     CALL adzq052_get_prog_info()
                  END IF

                  LET l_temp_prog = l_prog
               END IF

         END INPUT

         DISPLAY ARRAY ma_prog_info TO tbl_prog_info.*
            BEFORE ROW
               LET li_arr_curr = ARR_CURR()

            #取得程式結構清單.
            ON ACTION get_struct
               INITIALIZE la_apt TO NULL
               INITIALIZE la_section TO NULL
               DISPLAY '' TO edt_code_ver1
               DISPLAY '' TO edt_cust_flag1
               DISPLAY '' TO txt_code
               CALL adzq052_get_apt_list(ma_prog_info[li_arr_curr].code_ver, ma_prog_info[li_arr_curr].cust_flag) RETURNING la_apt   
               CALL adzq052_get_section_list(ma_prog_info[li_arr_curr].code_ver, ma_prog_info[li_arr_curr].cust_flag) RETURNING la_section   

               DISPLAY ma_prog_info[li_arr_curr].code_ver TO edt_code_ver1
               DISPLAY ma_prog_info[li_arr_curr].cust_flag TO edt_cust_flag1

         END DISPLAY

         DISPLAY ARRAY la_apt TO tbl_apt.*
            BEFORE ROW
               DISPLAY la_apt[ARR_CURR()].code TO txt_code

         END DISPLAY

         DISPLAY ARRAY la_section TO tbl_section.*
            BEFORE ROW
               DISPLAY la_section[ARR_CURR()].code TO txt_code

         END DISPLAY

         ON ACTION CLOSE
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

         BEFORE DIALOG                
            IF NOT cl_null(m_prog) THEN
               LET l_prog = m_prog
               LET l_temp_prog = l_prog
               IF (NOT cl_null(m_code_ver) AND m_code_ver>0) AND NOT cl_null(m_cust_flag) THEN
                  CALL adzq052_get_prog_info()
                  CALL adzq052_get_apt_list(m_code_ver, m_cust_flag) RETURNING la_apt   
                  CALL adzq052_get_section_list(m_code_ver, m_cust_flag) RETURNING la_section
                  #指到對應的版次紀錄位置.
                  FOR li_i=1 TO ma_prog_info.getLength()
                     IF ma_prog_info[li_i].code_ver=m_code_ver AND 
                        ma_prog_info[li_i].cust_flag=m_cust_flag THEN
                        CALL DIALOG.setCurrentRow("tbl_prog_info", li_i)
                        EXIT FOR
                     END IF
                  END FOR

                  DISPLAY m_code_ver TO edt_code_ver1
                  DISPLAY m_cust_flag TO edt_cust_flag1
                  ##初始化, 避免被誤用.
                  LET m_code_ver = 0 
                  LET m_cust_flag = ''
               END IF
            END IF

      END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

#取得程式版次/簽出相關資訊.
PRIVATE FUNCTION adzq052_get_prog_info()
   DEFINE li_i   SMALLINT

   CLEAR FORM

   INITIALIZE ma_prog_info TO NULL

   DECLARE dzaf_curs CURSOR FOR
           SELECT dzaf004,dzaf010 FROM dzaf_t
            WHERE dzaf001=m_prog
            ORDER BY dzaf010 DESC,dzaf004 ASC #順序為s1,s2,s3...,c1,c2,c3...
   LET li_i = 1
   FOREACH dzaf_curs INTO ma_prog_info[li_i].*
      LET li_i = li_i + 1
   END FOREACH
   CALL ma_prog_info.deleteElement(li_i)
END FUNCTION

#取得第二版次(含)以上的本版次異動add-point清單.
PRIVATE FUNCTION adzq052_get_apt_list(p_code_ver, p_cust_flag)
   DEFINE p_code_ver  LIKE dzaf_t.dzaf004,
          p_cust_flag LIKE dzaf_t.dzaf010
   DEFINE la_apt DYNAMIC ARRAY OF RECORD
                 apt      LIKE dzba_t.dzba003, #代碼設計點
                 apt_ver  LIKE dzba_t.dzba004, #設計點版次
                 apt_flag LIKE dzba_t.dzba005, #使用標示
                 code     LIKE dzbb_t.dzbb098  #設計點內容
                 END RECORD,
          li_i   SMALLINT,
          ltxt_code STRING #為了判斷內容長度是否為0, 所以改成STRING.

   DECLARE dzba_curs CURSOR FOR
           SELECT dzba003,dzba004,dzba005,dzbb098 FROM dzba_t
             LEFT JOIN dzbb_t ON dzbb001=dzba001 AND dzbb002=dzba003 AND dzbb003=dzba004 AND dzbb004=dzba005
            WHERE dzba001=m_prog AND dzba002=p_code_ver AND dzba010=p_cust_flag
            ORDER BY dzba003

   LET li_i = 1
   LOCATE la_apt[li_i].code IN FILE
   FOREACH dzba_curs INTO la_apt[li_i].*
      LET li_i = li_i + 1
      LOCATE la_apt[li_i].code IN FILE
   END FOREACH
   CALL la_apt.deleteElement(li_i)

   #移除沒有資料的add point清單.
   FOR li_i=la_apt.getLength() TO 1 STEP -1
      LET ltxt_code = la_apt[li_i].code
      LET ltxt_code = ltxt_code.trim()
      IF ltxt_code.getLength()=0 THEN
         CALL la_apt.deleteElement(li_i)
      END IF
   END FOR

   RETURN la_apt
END FUNCTION

#取得第二版次(含)以上的本版次異動section清單.
PRIVATE FUNCTION adzq052_get_section_list(p_code_ver, p_cust_flag)
   DEFINE p_code_ver  LIKE dzaf_t.dzaf004,
          p_cust_flag LIKE dzaf_t.dzaf010
   DEFINE la_section DYNAMIC ARRAY OF RECORD
                     section  LIKE dzbc_t.dzbc003, #section編號
                     apt_ver  LIKE dzbc_t.dzbc004, #section版次
                     apt_flag LIKE dzbc_t.dzbc005, #使用標示(s/m/c)
                     code     LIKE dzbd_t.dzbd098  #section內容
                     END RECORD,
          li_i       SMALLINT

   DECLARE dzbc_curs CURSOR FOR
           SELECT dzbc003,dzbc004,dzbc005,dzbd098 FROM dzbc_t
             LEFT JOIN dzbd_t ON dzbd001=dzbc001 AND dzbd002=dzbc003 AND dzbd003=dzbc004 AND dzbd004=dzbc005
            WHERE dzbc001=m_prog AND dzbc002=p_code_ver AND dzbc007=p_cust_flag
            ORDER BY dzbc003

   LET li_i = 1
   LOCATE la_section[li_i].code IN FILE
   FOREACH dzbc_curs INTO la_section[li_i].*
      LET li_i = li_i + 1
      LOCATE la_section[li_i].code IN FILE
   END FOREACH
   CALL la_section.deleteElement(li_i)

   RETURN la_section
END FUNCTION
