#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/02/27
#
#+ 程式代碼......: adzq620
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzq620.4gl
# Description    : 預覽行業同步清單
# Modify         : 2015/09/09 by Hiko : 修正欄位離開帶版次問題

IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

PRIVATE TYPE TYPE_DZAR1 RECORD #程式同步清單
                        dzar003 LIKE dzar_t.dzar003,
                        dzar004 LIKE dzar_t.dzar004,
                        dzar005 LIKE dzar_t.dzar005,
                        dzar006 LIKE dzar_t.dzar006,
                        dzar007 LIKE dzar_t.dzar007
                        END RECORD
PRIVATE TYPE TYPE_DZAR2 RECORD #規格同步清單
                        dzar003 LIKE dzar_t.dzar003,
                        dzar004 LIKE dzar_t.dzar004,
                        dzar005 LIKE dzar_t.dzar005,
                        dzar006 LIKE dzar_t.dzar006,
                        dzar007 LIKE dzar_t.dzar007 
                        END RECORD
DEFINE g_dzaq001 LIKE dzaq_t.dzaq001 #行業程式代號
DEFINE ga_dzar1 DYNAMIC ARRAY OF TYPE_DZAR1
DEFINE ga_code1 DYNAMIC ARRAY OF RECORD
                dzar011 LIKE dzar_t.dzar011,        
                dzar012 LIKE dzar_t.dzar012        
                END RECORD
DEFINE ga_dzar2 DYNAMIC ARRAY OF TYPE_DZAR2

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    

   LET g_dzaq001 = ARG_VAL(2) CLIPPED

   CALL cl_tool_init()

   OPEN WINDOW w_adzq620 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzq620_ui_dialog() 

   CLOSE WINDOW w_adzq620 
END MAIN

PRIVATE FUNCTION adzq620_ui_dialog()
   DEFINE lb_result BOOLEAN,
          li_ac     SMALLINT

   IF g_dzaq001 IS NOT NULL THEN #由下載畫面開啟程式
      LET g_chkparam.arg1 = g_dzaq001
      IF NOT cl_chk_exist("v_dzaq001") THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00282"
         LET g_errparam.replace[1] = g_dzaq001
         LET g_errparam.replace[2] = "dzaq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   
      WHILE TRUE
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
            DISPLAY ARRAY ga_dzar1 TO s_detail1.*
               BEFORE DISPLAY
                  CALL adzq620_get_code_sync_data() RETURNING lb_result

               BEFORE ROW
                  LET li_ac = DIALOG.getCurrentRow("s_detail1")
                  DISPLAY ga_code1[li_ac].dzar011 TO dzar_t.dzar011
                  DISPLAY ga_code1[li_ac].dzar012 TO dzar_t.dzar012
            END DISPLAY

            DISPLAY ARRAY ga_dzar2 TO s_detail2.*
               BEFORE DISPLAY
                  CALL adzq620_get_spec_sync_data() RETURNING lb_result
            END DISPLAY

            ON ACTION CLOSE
               LET g_action_choice="exit"
               EXIT DIALOG

            BEFORE DIALOG                
               CLEAR FORM
               CALL adzq620_show_prog_info()
         END DIALOG

         IF g_action_choice = "exit" THEN
            EXIT WHILE
         END IF
      END WHILE
   ELSE #自行開啟程式   
      WHILE TRUE
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
            INPUT g_dzaq001 FROM dzaq_t.dzaq001
               ON ACTION controlp
                  LET g_qryparam.state = "i"
                  LET g_qryparam.reqry = TRUE  #預查詢
                  LET g_qryparam.default1 = ""

                  CALL q_dzaq001()

                  LET g_dzaq001 = g_qryparam.return1
                  CALL adzq620_show_prog_info()

               AFTER FIELD dzaq_t.dzaq001
                  IF NOT cl_null(g_dzaq001) THEN
                     LET g_chkparam.arg1 = g_dzaq001
                     IF NOT cl_chk_exist("v_dzaq001") THEN
                        DISPLAY '','','','N','','','','','',''
                             TO dzaq_t.dzaq004,dzaq_t.dzaq005,dzaq_t.dzaq006,dzaq_t.dzaq010,dzaq_t.dzaq012,dzaq_t.dzaq007,dzaq_t.dzaq008,dzaq_t.dzaq009,dzar_t.dzar011,dzar_t.dzar012
                        CALL ga_dzar1.clear()
                        CALL ga_code1.clear()
                        CALL ga_dzar2.clear()
                        NEXT FIELD dzaq001
                     ELSE
                        CALL adzq620_show_prog_info() #2015/09/09 by Hiko
                     END IF
                  END IF

              ON ACTION btn_qry
                 NEXT FIELD dzar003
            END INPUT

            DISPLAY ARRAY ga_dzar1 TO s_detail1.*
               BEFORE DISPLAY
                  CALL adzq620_get_code_sync_data() RETURNING lb_result

               BEFORE ROW
                  LET li_ac = DIALOG.getCurrentRow("s_detail1")
                  DISPLAY ga_code1[li_ac].dzar011 TO dzar_t.dzar011
                  DISPLAY ga_code1[li_ac].dzar012 TO dzar_t.dzar012
            END DISPLAY

            DISPLAY ARRAY ga_dzar2 TO s_detail2.*
               BEFORE DISPLAY
                  CALL adzq620_get_spec_sync_data() RETURNING lb_result
            END DISPLAY
             
            ON ACTION CLOSE
               LET g_action_choice="exit"
               EXIT DIALOG

            BEFORE DIALOG                
               CLEAR FORM
               #CLEAR dzaq_t.dzaq001
               #CLEAR SCREEN ARRAY s_detail1.*
               #CLEAR SCREEN ARRAY s_detail2.*
         END DIALOG

         IF g_action_choice = "exit" THEN
            EXIT WHILE
         END IF
      END WHILE
   END IF
END FUNCTION

PRIVATE FUNCTION adzq620_show_prog_info()
   DEFINE ls_sql STRING,
          lr_dzaq RECORD LIKE dzaq_t.*

   TRY
      LET ls_sql = "SELECT * FROM dzaq_t aq",
                   " WHERE aq.dzaq001='",g_dzaq001,"'",
                   "   AND aq.dzaq007=(SELECT MAX(aq2.dzaq007) FROM dzaq_t aq2", #STD_LIST:dzaq007變成PK
                                      " WHERE aq2.dzaq001=aq.dzaq001)"
      PREPARE dzaq_prep FROM ls_sql
      EXECUTE dzaq_prep INTO lr_dzaq.*
      FREE dzaq_prep

      DISPLAY lr_dzaq.dzaq001,lr_dzaq.dzaq004,lr_dzaq.dzaq005,lr_dzaq.dzaq006,lr_dzaq.dzaq010,lr_dzaq.dzaq012,lr_dzaq.dzaq007,lr_dzaq.dzaq008,lr_dzaq.dzaq009
           TO  dzaq_t.dzaq001, dzaq_t.dzaq004, dzaq_t.dzaq005, dzaq_t.dzaq006, dzaq_t.dzaq010, dzaq_t.dzaq012, dzaq_t.dzaq007, dzaq_t.dzaq008, dzaq_t.dzaq009
   CATCH
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "!"
      LET g_errparam.extend = "Get dzaq_t failure!"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END TRY
END FUNCTION

PRIVATE FUNCTION adzq620_get_code_sync_data()
   DEFINE ls_sql STRING,
          li_idx SMALLINT

   TRY 
      LET ls_sql = "SELECT dzar003,dzar004,dzar005,dzar006,dzar007,dzar011,dzar012 FROM dzar_t",
                   " WHERE dzar001='",g_dzaq001,"' AND dzar002='CODE'",
                   " ORDER BY dzar003,dzar005,dzar004"
      PREPARE dzar_prep1 FROM ls_sql
      LOCATE ga_code1[1].dzar011 IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.
      LOCATE ga_code1[1].dzar012 IN FILE
      DECLARE dzar_curs1 CURSOR FOR dzar_prep1
      LET li_idx = 1
      FOREACH dzar_curs1 INTO ga_dzar1[li_idx].dzar003,
                              ga_dzar1[li_idx].dzar004,
                              ga_dzar1[li_idx].dzar005,
                              ga_dzar1[li_idx].dzar006,
                              ga_dzar1[li_idx].dzar007,
                              ga_code1[li_idx].dzar011,
                              ga_code1[li_idx].dzar012 
         LET li_idx = li_idx + 1
         LOCATE ga_code1[li_idx].dzar011 IN FILE #設定陣列第二筆之後clob資料的LOCATE.
         LOCATE ga_code1[li_idx].dzar012 IN FILE
      END FOREACH
      
      RETURN TRUE
   CATCH
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00583"
      LET g_errparam.replace[1] = "CODE"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN FALSE
   END TRY
END FUNCTION

PRIVATE FUNCTION adzq620_get_spec_sync_data()
   DEFINE ls_sql    STRING,
          li_idx    SMALLINT

   TRY 
      LET ls_sql = "SELECT dzar003,dzar004,dzar005,dzar006,dzar007 FROM dzar_t", #和adzq620_get_code_sync_data()差了dzar011,dzar012這兩個CLOB
                   " WHERE dzar001='",g_dzaq001,"' AND dzar002='SPEC'",
                   " ORDER BY dzar003,dzar005,dzar004"
      PREPARE dzar_prep2 FROM ls_sql
      DECLARE dzar_curs2 CURSOR FOR dzar_prep2
      LET li_idx = 1
      FOREACH dzar_curs2 INTO ga_dzar2[li_idx].*
         LET li_idx = li_idx + 1
      END FOREACH
 
      RETURN TRUE
   CATCH
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00583"
      LET g_errparam.replace[1] = "SPEC"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN FALSE
   END TRY
END FUNCTION
