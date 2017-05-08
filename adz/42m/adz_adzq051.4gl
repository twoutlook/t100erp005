#+ 程式版本......: 
#
#+ 程式代碼......: adzq051
#+ 設計人員......: Hiko
# Prog. Version..: 
#
# Program name   : adzq051.4gl
# Description    : 查看程式修改歷程
# Modify         : 20160504 160504-00011 by Hiko : 新建程式

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE m_dgenv STRING
DEFINE m_prog LIKE dzaf_t.dzaf001 #程式代號
DEFINE ma_prog_info DYNAMIC ARRAY OF RECORD 
                    req        LIKE dzlm_t.dzlm012,   #需求單號
                    reqno      LIKE dzlm_t.dzlm015,   #需求單項次
                    cust_flag  LIKE dzaf_t.dzaf010,   #客製標示
                    cons_ver   LIKE dzaf_t.dzaf002,   #建構版次
                    spec_ver   LIKE dzaf_t.dzaf003,   #規格版次
                    spec_modid LIKE dzlm_t.dzlm007,   #規格修改人員
                    spec_moddt LIKE dzaa_t.dzaamoddt, #規格修改日期
                    code_ver   LIKE dzaf_t.dzaf004,   #程式版次
                    code_modid LIKE dzlm_t.dzlm010,   #程式修改人員
                    code_moddt LIKE dzba_t.dzbamoddt  #程式修改日期
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

   OPEN WINDOW w_adzq051 WITH FORM cl_ap_formpath("adz", g_code)

   CLOSE WINDOW screen

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL) #為了使用原廠預設的搜尋工具, 所以將此段移除, 但會影響accept的功能與開窗的圖示, 所以暫時先用.
                                    #若仿照adzi151.4ad的設定, 雖然可以有搜尋功能, 但因為txt_code是唯讀, 所以還是無法搜尋.

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET m_dgenv = FGL_GETENV("DGENV") CLIPPED

   CALL adzq051_ui_dialog()

   CLOSE WINDOW w_adzq051 
END MAIN

PRIVATE FUNCTION adzq051_ui_dialog()
   DEFINE l_prog       LIKE dzaf_t.dzaf001,
          li_arr_curr  SMALLINT,
          ls_modi_memo STRING,
          la_apt       DYNAMIC ARRAY OF RECORD
                       apt  LIKE dzba_t.dzba003,
                       code LIKE dzbb_t.dzbb098
                       END RECORD,
          la_section   DYNAMIC ARRAY OF RECORD
                       section LIKE dzbc_t.dzbc003,
                       code    LIKE dzbd_t.dzbd098
                       END RECORD
   DEFINE l_curr_ver  LIKE dzaf_t.dzaf004,
          l_curr_flag LIKE dzaf_t.dzaf010
   DEFINE ls_run_cmd    STRING,
          lb_run_result BOOLEAN,
          ls_run_msg    STRING

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT l_prog FROM btd_prog ATTRIBUTE(WITHOUT DEFAULTS)
            ON ACTION controlp INFIELD btd_prog
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i' #開窗單選單回傳
               CALL q_adzp063_a()
               LET l_prog = g_qryparam.return1
               LET m_prog = l_prog
               DISPLAY m_prog TO btd_prog
               NEXT FIELD btd_prog

            AFTER FIELD btd_prog
               #不論存不存在, 都先將畫面資料清空.
               CLEAR FORM
               INITIALIZE ma_prog_info TO NULL
               LET m_prog = NULL
               DISPLAY '' TO txt_modi_memo
               INITIALIZE la_apt TO NULL
               INITIALIZE la_section TO NULL
               DISPLAY '' TO txt_code

               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_prog
               IF cl_chk_exist("v_dzaf001") THEN
                  LET m_prog = l_prog
                  CALL adzq051_get_prog_info()
               END IF

         END INPUT

         DISPLAY ARRAY ma_prog_info TO tbl_prog_info.*
            BEFORE ROW
               LET li_arr_curr = ARR_CURR()
               IF m_dgenv="s" THEN
                  CALL adzq051_get_modi_memo(li_arr_curr) RETURNING ls_modi_memo
                  DISPLAY ls_modi_memo TO txt_modi_memo
               END IF

            #查看程式異動清單.
            ON ACTION get_ver_modi
               IF ma_prog_info[li_arr_curr].code_ver<=1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00845" #第一版次屬於新開發程式, 所以沒有差異清單.
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
               ELSE
                  INITIALIZE la_apt TO NULL
                  INITIALIZE la_section TO NULL
                  LET l_curr_ver = 0
                  LET l_curr_flag = ''
                  DISPLAY '' TO edt_code_ver1
                  DISPLAY '' TO edt_cust_flag1
                  DISPLAY '' TO txt_code
                  CALL adzq051_get_apt_list(ma_prog_info[li_arr_curr].code_ver, ma_prog_info[li_arr_curr].cust_flag) RETURNING la_apt   
                  CALL adzq051_get_section_list(ma_prog_info[li_arr_curr].code_ver, ma_prog_info[li_arr_curr].cust_flag) RETURNING la_section   

                  LET l_curr_ver = ma_prog_info[li_arr_curr].code_ver
                  LET l_curr_flag = ma_prog_info[li_arr_curr].cust_flag
                  DISPLAY l_curr_ver TO edt_code_ver1
                  DISPLAY l_curr_flag TO edt_cust_flag1
               END IF

         END DISPLAY

         DISPLAY ARRAY la_apt TO tbl_apt.*
            BEFORE ROW
               DISPLAY la_apt[ARR_CURR()].code TO txt_code

         END DISPLAY

         DISPLAY ARRAY la_section TO tbl_section.*
            BEFORE ROW
               DISPLAY la_section[ARR_CURR()].code TO txt_code

         END DISPLAY

         #檢視程式組成結構.
         ON ACTION view_structure
            IF NOT cl_null(m_prog) THEN
               LET ls_run_cmd = "r.r adzq052 ",m_prog," ",l_curr_ver," '",l_curr_flag,"'"
               CALL cl_cmdrun_openpipe("r.r adzq052", ls_run_cmd, FALSE) RETURNING lb_run_result,ls_run_msg
            END IF

         ON ACTION CLOSE
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

         BEFORE DIALOG                
            #標準環境才顯現修改說明.
            CALL cl_set_comp_visible("lbl_modi_memo,txt_modi_memo", m_dgenv="s")

            IF NOT cl_null(m_prog) THEN
               LET l_prog = m_prog
            END IF

      END DIALOG

      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

#取得程式版次/簽出相關資訊.
PRIVATE FUNCTION adzq051_get_prog_info()
   DEFINE ls_sql STRING,
          li_i   SMALLINT

   #ma_prog_info DYNAMIC ARRAY OF RECORD 
   #             req        LIKE dzlm_t.dzlm012,   #需求單號
   #             reqno      LIKE dzlm_t.dzlm015,   #需求單項次
   #             cust_flag  LIKE dzaf_t.dzaf010,   #客製標示
   #             cons_ver   LIKE dzaf_t.dzaf002,   #建構版次
   #             spec_ver   LIKE dzaf_t.dzaf003,   #規格版次
   #             spec_modid LIKE dzlm_t.dzlm007,   #規格修改人員
   #             spec_moddt LIKE dzaa_t.dzaamoddt, #規格修改日期
   #             code_ver   LIKE dzaf_t.dzaf004,   #程式版次
   #             code_modid LIKE dzlm_t.dzlm010,   #程式修改人員
   #             code_moddt LIKE dzba_t.dzbamoddt  #程式修改日期

   CLEAR FORM

   INITIALIZE ma_prog_info TO NULL

   LET ls_sql = "SELECT dzlm012,dzlm015,dzaf010,dzaf002,dzaf003,",
                "       dzlm007,'',dzaf004,dzlm010,''",
                "  FROM dzaf_t",
                "  LEFT JOIN dzlm_t ON dzlm001=dzaf005 AND dzlm002=dzaf001 AND dzlm005=dzaf002",
                " WHERE dzaf001='",m_prog,"'",
                " ORDER BY dzaf010 DESC,dzaf002,dzaf003,dzaf004 ASC" #順序為s1,s2,s3...,c1,c2,c3...
   PREPARE dzaf_prep FROM ls_sql
   DECLARE dzaf_curs CURSOR FOR dzaf_prep
   LET li_i = 1
   FOREACH dzaf_curs INTO ma_prog_info[li_i].*
      #以dzaa_t長樹那一剎拿當作是規格修改日期, 所以單純就取得MAX的建立日期即可.
      SELECT MAX(dzaacrtdt) INTO ma_prog_info[li_i].spec_moddt FROM dzaa_t
       WHERE dzaa001=m_prog AND dzaa002=ma_prog_info[li_i].spec_ver AND dzaa009=ma_prog_info[li_i].cust_flag

      #以dzba_t長樹那一剎拿當作是程式修改日期, 所以單純就取得MAX的建立日期即可.
      SELECT MAX(dzbacrtdt) INTO ma_prog_info[li_i].code_moddt FROM dzba_t
       WHERE dzba001=m_prog AND dzba002=ma_prog_info[li_i].code_ver AND dzba010=ma_prog_info[li_i].cust_flag

      LET li_i = li_i + 1
   END FOREACH
   CALL ma_prog_info.deleteElement(li_i)
END FUNCTION

#取得程式的ALM修改資訊.
PRIVATE FUNCTION adzq051_get_modi_memo(p_arr_curr)
   DEFINE p_arr_curr SMALLINT
   DEFINE ls_sql    STRING,
          #l_dzla011 LIKE dzla_t.dzla011
          l_dzla011 LIKE type_t.chr1000 #避免客戶環境沒有這個表而出現錯誤.
         #dzla002=dzlm001 #建構類型
         #dzla003=dzlm002 #建構代號
         #dzla007=dzlm012 #需求單號
         #dzla010=dzlm015 #作業項次

   TRY
      LET ls_sql = "SELECT dzla011 FROM dzla_t",
                   " INNER JOIN dzlm_t ON dzla002=dzlm001",
                                    " AND dzla003=dzlm002",
                                    " AND dzla007=dzlm012",
                                    " AND dzla010=dzlm015",
                   " WHERE dzla003='",m_prog,"'",
                   "   AND dzlm005=",ma_prog_info[p_arr_curr].cons_ver,
                   "   AND dzlm009=",ma_prog_info[p_arr_curr].code_ver
      IF NOT cl_null(ma_prog_info[p_arr_curr].req) AND 
         NOT cl_null(ma_prog_info[p_arr_curr].reqno) THEN
         LET ls_sql = ls_sql,
                   "   AND dzla007='",ma_prog_info[p_arr_curr].req,"'",
                   "   AND dzla010=",ma_prog_info[p_arr_curr].reqno
      END IF
   display "ls_sql=",ls_sql
      PREPARE dzla_prep FROM ls_sql
      EXECUTE dzla_prep INTO l_dzla011
      FREE dzla_prep
   
      RETURN l_dzla011
   CATCH
      DISPLAY "ERROR : ls_sql=",ls_sql

      RETURN NULL
   END TRY
END FUNCTION

#取得第二版次(含)以上的本版次異動add-point清單.
PRIVATE FUNCTION adzq051_get_apt_list(p_code_ver, p_cust_flag)
   DEFINE p_code_ver  LIKE dzaf_t.dzaf004,
          p_cust_flag LIKE dzaf_t.dzaf010
   DEFINE la_apt DYNAMIC ARRAY OF RECORD
                 apt  LIKE dzba_t.dzba003,
                 code LIKE dzbb_t.dzbb098
                 END RECORD,
          li_i   SMALLINT

   DECLARE dzba_curs CURSOR FOR
           SELECT dzba003,dzbb098 FROM dzba_t
             LEFT JOIN dzbb_t ON dzbb001=dzba001 AND dzbb002=dzba003 AND dzbb003=dzba004 AND dzbb004=dzba005
            WHERE dzba001=m_prog AND dzba002=p_code_ver AND dzba010=p_cust_flag AND dzba004=p_code_ver
            ORDER BY dzba003

   LET li_i = 1
   LOCATE la_apt[li_i].code IN FILE
   FOREACH dzba_curs INTO la_apt[li_i].*
      LET li_i = li_i + 1
      LOCATE la_apt[li_i].code IN FILE
   END FOREACH
   CALL la_apt.deleteElement(li_i)

   IF la_apt.getLength()=0 THEN
      LET la_apt[1].apt = "no change"
   END IF

   RETURN la_apt
END FUNCTION

#取得第二版次(含)以上的本版次異動section清單.
PRIVATE FUNCTION adzq051_get_section_list(p_code_ver, p_cust_flag)
   DEFINE p_code_ver  LIKE dzaf_t.dzaf004,
          p_cust_flag LIKE dzaf_t.dzaf010
   DEFINE la_section DYNAMIC ARRAY OF RECORD
                     section LIKE dzbc_t.dzbc003,
                     code    LIKE dzbd_t.dzbd098
                     END RECORD,
          li_i       SMALLINT

   DECLARE dzbc_curs CURSOR FOR
           SELECT dzbc003,dzbd098 FROM dzbc_t
             LEFT JOIN dzbd_t ON dzbd001=dzbc001 AND dzbd002=dzbc003 AND dzbd003=dzbc004 AND dzbd004=dzbc005
            WHERE dzbc001=m_prog AND dzbc002=p_code_ver AND dzbc007=p_cust_flag AND dzbc009='Y'
            ORDER BY dzbc003

   LET li_i = 1
   LOCATE la_section[li_i].code IN FILE
   FOREACH dzbc_curs INTO la_section[li_i].*
      LET li_i = li_i + 1
      LOCATE la_section[li_i].code IN FILE
   END FOREACH
   CALL la_section.deleteElement(li_i)

   IF la_section.getLength()=0 THEN
      LET la_section[1].section = "no change"
   END IF

   RETURN la_section
END FUNCTION
