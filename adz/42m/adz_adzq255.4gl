#+ 程式代碼......: adzq255
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzq255.4gl
# Description    : 檢視伺服端設計檔
# Memo           :
# Modify         : 2014/07/10 by Hiko : 檢視設計資料SQL改成Table呈現

IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE gs_prog STRING,
       gr_dzaf RECORD LIKE dzaf_t.*
DEFINE gs_module_dir STRING
DEFINE g_god_mode BOOLEAN
#Begin:2015/07/10 by Hiko
DEFINE ga_data_sql DYNAMIC ARRAY OF RECORD
                   data_table LIKE dzea_t.dzea001,
                   table_name LIKE dzeal_t.dzeal003,
                   data_sql   LIKE dzej_t.dzej004
                   END RECORD
#End:2015/07/10 by Hiko

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS FIELD ORDER FORM, INPUT WRAP    

   CALL cl_tool_init()

   OPEN WINDOW w_adzq255 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET lf_form = lw_window.getForm()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzq255_init()

   LET g_god_mode = (UPSHIFT(ARG_VAL(2)) == "DEBUG")
   DISPLAY "g_god_mode=",g_god_mode
   IF g_god_mode THEN
      DISPLAY "grid4=FALSE"
      CALL lf_form.setElementHidden("grid4", FALSE)
   END IF

   CALL adzq255_ui_dialog() 

   CLOSE WINDOW w_adzq255 
END MAIN

PRIVATE FUNCTION adzq255_init()
   DEFINE lo_combobox ui.ComboBox

   CALL cl_set_combo_scc("s_qry_type", "114")
   LET lo_combobox = ui.ComboBox.forName("s_qry_type")
   CALL lo_combobox.addItem('', '')

   #Begin:2015/07/10 by Hiko
   #CALL cl_set_combo_scc("s_data_table", "255")
   #LET lo_combobox = ui.ComboBox.forName("s_data_table")
   #CALL lo_combobox.addItem('', '')
   #End:2015/07/10 by Hiko
END FUNCTION

PRIVATE FUNCTION adzq255_ui_dialog()
   DEFINE l_qry_type LIKE type_t.chr1,
          l_prog_tmp  LIKE dzaf_t.dzaf001
          #l_data_table LIKE dzea_t.dzea001 #2015/07/10 by Hiko
   DEFINE ls_tsd_file TEXT,
          ls_tap_file TEXT,
          ls_tab_file TEXT,
          ls_4gl_file TEXT,
          ls_4fd_file TEXT

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT l_qry_type,gs_prog,  ls_tsd_file,ls_tap_file,ls_tab_file,ls_4gl_file,ls_4fd_file
          FROM s_qry_type,s_prog_id,s_tsd_file, s_tap_file, s_tab_file, s_4gl_file, s_4fd_file ATTRIBUTE(WITHOUT DEFAULTS)
            ON ACTION controlp INFIELD s_prog_id
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = ""
               IF NOT cl_null(l_qry_type) THEN
                  LET g_qryparam.where = " dzaf005='",l_qry_type,"' "
               END IF
               
               CALL q_adzp063_a()
               
               LET gs_prog = g_qryparam.return1 CLIPPED
               DISPLAY gs_prog TO s_prog_id
               NEXT FIELD s_prog_id 

            AFTER FIELD s_prog_id
               LET gs_prog = gs_prog CLIPPED
               LET l_prog_tmp = gs_prog
               IF NOT cl_null(gs_prog) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = gs_prog

                  IF NOT cl_chk_exist("v_dzaf001") THEN
                     INITIALIZE gr_dzaf.* TO NULL
                     CLEAR FORM
                     DISPLAY l_prog_tmp TO s_prog_id

                     #底下只能這樣設定才有機會清空檔案資料
                     FREE ls_tsd_file
                     DISPLAY ls_tsd_file TO s_tsd_file

                     FREE ls_tap_file
                     DISPLAY ls_tap_file TO s_tap_file

                     FREE ls_tab_file
                     DISPLAY ls_tab_file TO s_tab_file

                     FREE ls_4gl_file
                     DISPLAY ls_4gl_file TO s_4gl_file

                     FREE ls_4fd_file
                     DISPLAY ls_4fd_file TO s_4fd_file

                     NEXT FIELD s_prog_id
                  ELSE
                     #依據程式代號取得相關資訊
                     CALL adzq255_get_dzaf()
                     IF gr_dzaf.dzaf001 IS NOT NULL THEN
                        DISPLAY gr_dzaf.dzaf002 TO dzaf002
                        DISPLAY gr_dzaf.dzaf003 TO dzaf003
                        DISPLAY gr_dzaf.dzaf004 TO dzaf004
                        DISPLAY gr_dzaf.dzaf006 TO dzaf006

                        LET gs_module_dir = FGL_GETENV(UPSHIFT(gr_dzaf.dzaf006))
                        
                        #資料都取出來後才可以繼續
                        IF gr_dzaf.dzaf001 IS NOT NULL AND gs_prog.equals(gr_dzaf.dzaf001) THEN
                           CALL adzq255_read_file("tsd") RETURNING ls_tsd_file
                           DISPLAY ls_tsd_file TO s_tsd_file
                        
                           CALL adzq255_read_file("tap") RETURNING ls_tap_file
                           DISPLAY ls_tap_file TO s_tap_file
                        
                           CALL adzq255_read_file("tab") RETURNING ls_tab_file
                           DISPLAY ls_tab_file TO s_tab_file
                        
                           CALL adzq255_read_file("4gl") RETURNING ls_4gl_file
                           DISPLAY ls_4gl_file TO s_4gl_file
                        
                           CALL adzq255_read_file("4fd") RETURNING ls_4fd_file
                           DISPLAY ls_4fd_file TO s_4fd_file
                        END IF
                     ELSE #有註冊資料但沒有版次資料.
                        CLEAR FORM
                        DISPLAY l_prog_tmp TO s_prog_id

                        #底下只能這樣設定才有機會清空檔案資料
                        FREE ls_tsd_file
                        DISPLAY ls_tsd_file TO s_tsd_file
                        
                        FREE ls_tap_file
                        DISPLAY ls_tap_file TO s_tap_file
                        
                        FREE ls_tab_file
                        DISPLAY ls_tab_file TO s_tab_file
                        
                        FREE ls_4gl_file
                        DISPLAY ls_4gl_file TO s_4gl_file
                        
                        FREE ls_4fd_file
                        DISPLAY ls_4fd_file TO s_4fd_file

                        NEXT FIELD s_prog_id
                     END IF
                  END IF
               END IF
         END INPUT

         ON ACTION btn_read
            ACCEPT DIALOG #2015/07/10 by Hiko:為了觸發AFTER FIELD s_prog_id
            #資料都取出來後才可以繼續
            IF gr_dzaf.dzaf001 IS NOT NULL AND gs_prog.equals(gr_dzaf.dzaf001) THEN
               CALL adzq255_read_file("tsd") RETURNING ls_tsd_file
               DISPLAY ls_tsd_file TO s_tsd_file
            
               CALL adzq255_read_file("tap") RETURNING ls_tap_file
               DISPLAY ls_tap_file TO s_tap_file
            
               CALL adzq255_read_file("tab") RETURNING ls_tab_file
               DISPLAY ls_tab_file TO s_tab_file
            
               CALL adzq255_read_file("4gl") RETURNING ls_4gl_file
               DISPLAY ls_4gl_file TO s_4gl_file
            
               CALL adzq255_read_file("4fd") RETURNING ls_4fd_file
               DISPLAY ls_4fd_file TO s_4fd_file
            END IF
             
         ON ACTION btn_show_sql
            #Begin:2015/07/10 by Hiko
            #IF NOT cl_null(l_data_table) THEN
            #   CALL adzq255_show_sql(l_data_table)
            #END IF
            CALL adzq255_show_sql()
            #End:2015/07/10 by Hiko

         ON ACTION CLOSE
            LET g_action_choice="exit"
            EXIT DIALOG

         BEFORE DIALOG                
            CLEAR FORM
      END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

PRIVATE FUNCTION adzq255_get_dzaf()
   DEFINE ls_sql STRING

   TRY
      LET ls_sql = "SELECT *", 
                   "  FROM dzaf_t af0",
                   " WHERE af0.dzaf001 = '",gs_prog,"'", 
                   "   AND (af0.dzaf002,af0.dzaf010) = (",     
                   "                                     SELECT CASE WHEN afc.dzaf002 IS NULL THEN afs.dzaf002 ELSE afc.dzaf002 END,",
                   "                                            CASE WHEN afc.dzaf002 IS NULL THEN afs.dzaf010 ELSE afc.dzaf010 END",
                   "                                       FROM (",
                   "                                              SELECT '",gs_prog,"' dzaf001",
                   "                                                FROM dual",
                   "                                            ) afo",
                   "                                       LEFT JOIN (",              
                   "                                                   SELECT af.dzaf001,MAX(af.dzaf002) dzaf002,af.dzaf010",
                   "                                                     FROM dzaf_t af",
                   "                                                    WHERE af.dzaf010 = 's'",
                   "                                                    GROUP BY af.dzaf001,af.dzaf010",
                   "                                                  ) afs ON afs.dzaf001 = afo.dzaf001",    
                   "                                       LEFT JOIN (",              
                   "                                                   SELECT af.dzaf001,MAX(af.dzaf002) dzaf002,af.dzaf010",  
                   "                                                     FROM dzaf_t af",
                   "                                                    WHERE af.dzaf010 = 'c'",           
                   "                                                    GROUP BY af.dzaf001,af.dzaf010",
                   "                                                  ) afc ON afc.dzaf001 = afo.dzaf001",    
                   "                                    )"
      PREPARE dzaf_prep FROM ls_sql
      EXECUTE dzaf_prep INTO gr_dzaf.*
      FREE dzaf_prep
   CATCH
      DISPLAY "adzq255_get_dzaf ERROR : ",ls_sql
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
      INITIALIZE gr_dzaf.* TO NULL
   END TRY
END FUNCTION

PRIVATE FUNCTION adzq255_read_file(ps_file_type)
   DEFINE ps_file_type STRING
   DEFINE ls_file_path STRING,
          ltxt_file    TEXT

   CASE
      WHEN ps_file_type.equals("tsd") OR ps_file_type.equals("tap") OR ps_file_type.equals("tab") 
         LET ls_file_path = os.path.join(os.path.join(os.path.join(gs_module_dir, "dzx"), ps_file_type), gs_prog||"."||ps_file_type)
      WHEN ps_file_type.equals("4gl") OR ps_file_type.equals("4fd") 
         LET ls_file_path = os.path.join(os.path.join(gs_module_dir, ps_file_type), gs_prog||"."||ps_file_type)
   END CASE
   DISPLAY "adzq255_read_file:",ls_file_path

   IF os.Path.exists(ls_file_path) THEN
      LOCATE ltxt_file IN FILE
      CALL ltxt_file.readFile(ls_file_path)
   END IF

   RETURN ltxt_file
END FUNCTION

PRIVATE FUNCTION adzq255_show_sql()
   OPEN WINDOW w_adzq255_01 WITH FORM cl_ap_formpath("adz","adzq255_01") ATTRIBUTE(STYLE="openwin2")

   CALL adzq255_data_sql()

   #Begin:2015/07/10 by Hiko
   #DISPLAY p_data_table,ls_sql_txt TO s_data_table,s_sql_txt
   #MENU
   #   ON ACTION close
   #      EXIT MENU
   #END MENU
   DISPLAY ARRAY ga_data_sql TO s_data_table.* ATTRIBUTES(UNBUFFERED)
      ON ACTION close
         EXIT DISPLAY
   END DISPLAY
   #End:2015/07/10 by Hiko

   CLOSE WINDOW w_adzq255_01
END FUNCTION

PRIVATE FUNCTION adzq255_data_sql()
   DEFINE ls_sql  STRING, 
          la_gzcb DYNAMIC ARRAY OF RECORD
                  gzcb002  LIKE gzcb_t.gzcb002,
                  gzcbl004 LIKE gzcbl_t.gzcbl004
                  END RECORD,
          li_idx  SMALLINT
   DEFINE l_data_sql   LIKE dzej_t.dzej004,
          lbuf_sql_txt base.StringBuffer

   TRY
      #Begin:2015/07/10 by Hiko
      LET ls_sql = "SELECT gzcb002,gzcbl004",
                   "  FROM gzcb_t",
                   "  LEFT JOIN gzcbl_t ON gzcbl001=gzcb001 AND gzcbl002=gzcb002 AND gzcbl003='",g_lang,"'",
                   " WHERE gzcb001='255'",
                   " ORDER BY gzcb012"
      PREPARE gzcb_prep FROM ls_sql
      DECLARE gzcb_curs CURSOR FOR gzcb_prep

      LET li_idx = 1
      FOREACH gzcb_curs INTO la_gzcb[li_idx].*
         SELECT dzej004 INTO l_data_sql FROM dzej_t WHERE dzej001='adzq255' AND dzej002=la_gzcb[li_idx].gzcb002
         
         LET lbuf_sql_txt = base.StringBuffer.create()
         CALL lbuf_sql_txt.append(l_data_sql)
         
         CALL lbuf_sql_txt.replace("$PROG", gs_prog, 0)
         
         IF la_gzcb[li_idx].gzcb002="dzbb_t" OR la_gzcb[li_idx].gzcb002="dzbd_t" THEN
            CALL lbuf_sql_txt.replace("$VER", gr_dzaf.dzaf004, 0)
         ELSE
            CALL lbuf_sql_txt.replace("$VER", gr_dzaf.dzaf003, 0)
         END IF
         
         CALL lbuf_sql_txt.replace("$IDENTITY", gr_dzaf.dzaf010, 0)
      
         LET ga_data_sql[li_idx].data_table = la_gzcb[li_idx].gzcb002
         LET ga_data_sql[li_idx].table_name = la_gzcb[li_idx].gzcbl004
         LET ga_data_sql[li_idx].data_sql = lbuf_sql_txt.toString()

         LET li_idx = li_idx + 1
      END FOREACH
      #End:2015/07/10 by Hiko
   CATCH
      DISPLAY "adzq255_data_sql ERROR"
      DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   END TRY
END FUNCTION
