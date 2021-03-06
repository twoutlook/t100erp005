#+ Version..: T100-ERP-1.00.00(版次:1) Build-000720
#+
#+ Filename...: adzp169
#+ Description: 自定義欄位開通作業
#+ Creator....: tsai_yen(14/10/07)
#+ Buildtype..:
#+ Modifier...:
#+ Modifier...: No.161220-00051#1  2016/12/20 By tsai_yen 相對欄位的開窗支援資料表出現在多單身

IMPORT os
IMPORT util

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp000_type.inc"

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_master_multi_table_t    RECORD
     dzebl001 LIKE dzebl_t.dzebl001,     #欄位代碼
     dzebl003 LIKE dzebl_t.dzebl003      #欄位名稱
     END RECORD

DEFINE li_step              LIKE type_t.num5
DEFINE gwin_curr            ui.Window
DEFINE gfrm_curr            ui.Form

DEFINE g_gzza002         LIKE gzza_t.gzza002   #程式類別
DEFINE g_sql  STRING
DEFINE g_dialog      ui.DIALOG

#+ 作業開始
MAIN
   DEFINE l_win_curr      ui.Window             #Current Window
   DEFINE l_frm_curr      ui.Form               #Current Form
   DEFINE ls_cfg_path     STRING
   DEFINE ls_4st_path     STRING
   DEFINE ls_img_path     STRING
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz","")
   CALL cl_tool_init()

   #LOCK CURSOR
   #LET g_forupd_sql = "SELECT dzfq001,dzfq002,dzfq003,dzfq004,dzfq005,dzfq006,dzfq007,dzfq008,dzfq009,dzfq010,dzfq011,dzfq012,dzfq013,dzfq014,dzfq015,dzfq016,dzfqstus,dzfqmodid,'',dzfqmoddt,dzfqownid,'',dzfqowndp,'',dzfqcrtid,'',dzfqcrtdp,'',dzfqcrtdt FROM dzfq_t WHERE dzfq003=? AND dzfq004=? FOR UPDATE"
   #LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   #DECLARE adzp169_cl CURSOR FROM g_forupd_sql   #cursor lock

   IF g_bgjob = "Y" THEN

   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzp169 WITH FORM cl_ap_formpath("adz",g_code)

      #LET g_hidden_4tm = TRUE     #是否不載入TopMenu TRUE:不載入, FALSE:載入
      #LET g_hidden_4tb = TRUE     #是否不載入ToolBar TRUE:不載入, FALSE:載入
      #瀏覽頁簽資料初始化
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

      #程式初始化
      CALL adzp169_init()

      #進入選單 Menu (="N")
      CALL adzp169_ui_dialog()

      #畫面關閉
      CLOSE WINDOW w_adzp169
   END IF


   #離開作業
   CALL cl_ap_exitprogram("0")

END MAIN


#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzp169_init()
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED
   #LET ms_cust = FGL_GETENV("CUST") CLIPPED

   IF ms_dgenv = "s" THEN   #標準環境不可以做開通
      CALL cl_set_comp_visible("step_next2",0)
   END IF

   LET g_erpalm = "N"
   LET g_gzza003 = NULL

   CALL sadzp168_1_cb_dzfq005("dzfq005","adzp169") RETURNING g_udset.dzfq005   #程式類型
END FUNCTION

#+ 進入選單
PRIVATE FUNCTION adzp169_ui_dialog()
   DEFINE l_chk               BOOLEAN
   DEFINE l_result            BOOLEAN
   DEFINE l_str               STRING
   DEFINE l_gzze003           LIKE gzze_t.gzze003
   DEFINE l_dzaf010_old       LIKE dzaa_t.dzaa009   #客製標示
   DEFINE lo_program_info     T_PROGRAM_INFO
   DEFINE lo_DZAF_old         T_DZAF_T
   DEFINE lo_DZAF_new         T_DZAF_T
   DEFINE lo_DZLM_T           T_DZLM_T
   DEFINE l_msg               STRING
   DEFINE l_dzfj006           LIKE dzfj_t.dzfj006
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_check_out         BOOLEAN              #是否簽出
   DEFINE l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE l_vars                DYNAMIC ARRAY OF STRING
   DEFINE l_fields              DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak        DYNAMIC ARRAY OF STRING


   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT g_udset.dzfq005,g_udset.dzfi001,g_udset.udtable,g_udset.udcol,
            g_udset.dzebl003,g_udset.dzfj006,g_udset.dzfj005_rel,g_udset.rel_position,
            g_udset.dzca001_i,g_udset.dzca001_c,g_udset.dzcd001
         FROM dzfq005,dzfi001,udtable,udcol,
            dzebl003,dzfj006,dzfj005_rel,rel_position,
            dzca001_i,dzca001_c,dzcd001
         ATTRIBUTE(WITHOUT DEFAULTS)

         ON CHANGE dzfq005
            LET g_udset.dzfi001 = NULL
            LET g_udset.gzzal003 = NULL
            LET g_udset.udtable = NULL
            LET g_udset.udcol = NULL

            DISPLAY BY NAME g_udset.dzfi001,g_udset.gzzal003,g_udset.udtable,g_udset.udcol
            NEXT FIELD dzfi001

         ON ACTION controlp_dzfi001
            CALL sadzp168_1_prog_qry("i",NULL,g_udset.dzfq005,g_gzza003,g_udset.dzfi001,g_udset.gzzal003,g_gzza002) RETURNING g_udset.dzfi001,g_udset.gzzal003,g_gzza002
            CALL sadzp168_1_gzza002(g_udset.dzfi001,g_udset.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_udset.gzzal003   #程式類別,模組代碼,實際模組,程式名稱
            DISPLAY g_udset.dzfi001,g_udset.gzzal003 TO dzfi001,lb_gzzal003

         ON CHANGE udtable
            LET g_udset.dzfj005_rel = NULL
            CALL adzp169_cb_udcol(g_udset.udtable,g_udset.udcol,g_udset.dzfi001,lo_DZAF_old.DZAF003,l_dzaf010_old) RETURNING g_udset.udcol,g_udset.dzebl003
            DISPLAY BY NAME g_udset.udcol,g_udset.dzebl003,g_udset.dzfj005_rel

         ON ACTION update_item   #欄位多語言
            IF NOT cl_null(g_udset.udcol) THEN
               CALL n_dzebl(g_udset.udcol)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_udset.udcol
               CALL ap_ref_array2(g_ref_fields," SELECT dzebl003 FROM dzebl_t WHERE dzebl001 = ? AND dzebl002 = '"||g_lang||"'","") RETURNING g_rtn_fields
               LET g_udset.dzebl003 = g_rtn_fields[1]
               DISPLAY BY NAME g_udset.dzebl003
            END IF

         ON ACTION col_location1   #挑選相對欄位lo_DZAF_old.DZAF010
            CALL adzp169_sel_dzfj005(g_udset.dzfi001,lo_DZAF_old.DZAF003,l_dzaf010_old,g_udset.udtable)

         ON ACTION act_dzca001_i   #編輯時開窗
            INITIALIZE g_qryparam.* TO NULL   #161220-00051#1
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = g_udset.dzca001_i
            CALL q_dzca001()
            LET g_udset.dzca001_i = g_qryparam.return1
            LET g_udset.dzca001_i_desc = g_qryparam.return2
            DISPLAY BY NAME g_udset.dzca001_i,g_udset.dzca001_i_desc
            NEXT FIELD dzca001_i

         ON ACTION act_dzca001_c   #查詢時開窗
            INITIALIZE g_qryparam.* TO NULL   #161220-00051#1
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = g_udset.dzca001_c
            CALL q_dzca001()
            LET g_udset.dzca001_c = g_qryparam.return1
            LET g_udset.dzca001_c_desc = g_qryparam.return2
            DISPLAY BY NAME g_udset.dzca001_c,g_udset.dzca001_c_desc
            NEXT FIELD dzca001_c

         ON ACTION act_dzcd001     #校驗帶值
            INITIALIZE g_qryparam.* TO NULL   #161220-00051#1
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = g_udset.dzcd001
            CALL q_dzcd001()
            LET g_udset.dzcd001 = g_qryparam.return1
            LET g_udset.dzcd001_desc = g_qryparam.return2
            DISPLAY BY NAME g_udset.dzcd001,g_udset.dzcd001_desc
            NEXT FIELD dzcd001
      END INPUT

      BEFORE DIALOG
         LET g_dialog = ui.DIALOG.getCurrent()
         CALL adzp169_set_step_img(1)   #設定左方的流程圖

         ON ACTION step_next2
            BEGIN WORK   #transaction
            IF cl_null(g_udset.dzfi001) THEN
               LET l_chk = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00255"   #此欄位為必填欄位
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               LET l_chk = TRUE
               #程式代碼基本資料檢查
               IF l_chk THEN
                  CALL sadzp168_1_prog_chk(g_udset.dzfi001,g_udset.dzfq005) RETURNING l_chk
               END IF
               #判斷是否已經簽出 for Hiko
               # Input parameter : p_prog 程式代號
               #                   p_type 程式類型(M/S/F/G/X...)
               #                   p_role 簽出角色(SD/PR)
               #                   p_popup_err 彈出錯誤訊息窗(1:彈窗,0:不彈窗)
               # Return code     : STRING (成功:NULL,失敗:錯誤訊息)
               #adz-00314 規格沒有簽出,請透過設計器的[下載規格]執行簽出
               #adz-00315 程式沒有簽出,請透過設計器的[下載程式]執行簽出
               #adz-00351 SPEC已經被02097簽出, 請查明後再重試.
               #adz-00313 規格與程式都要簽出,請先簽出規格,再簽出程式
               #IF l_chk THEN
               #   LET l_str = NULL
               #   CALL sadzp060_2_have_checked_out(g_udset.dzfi001, g_udset.dzfq005, "SD",1) RETURNING l_str
               #   DISPLAY "l_str=",l_str
               #   IF NOT cl_null(l_str) THEN
               #      LET l_chk = FALSE
               #   ELSE
               #      LET l_chk = TRUE
               #   END IF
               #END IF

               IF l_chk THEN
                  CALL adzp169_get_curr_ver_info(g_udset.dzfi001,g_udset.dzfq005) RETURNING l_chk,lo_DZAF_old.*
               END IF

               #判斷是否為freeStyle或打開section，是標準產生的程式才可以進行開通
               IF l_chk THEN
                  ##########################################################################
                  # Access Modifier : PUBLIC
                  # Descriptions    : 判斷是否可以執行自定義欄位開通
                  # Input parameter : po_curr_cus_DZAF 目前DZAF_T資料
                  # Return code     : BOOLEAN TRUE:成功;FALSE:失敗
                  #                 : STRING 錯誤訊息
                  # Date & Author   : 2014/10/14 by Hiko
                  ##########################################################################
                  CALL sadzp169_02_continue_flag(lo_DZAF_old.*) RETURNING l_chk,l_msg
                  IF NOT l_chk THEN
                     #for sadzp169_02_continue_flag()
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00008"
                     LET g_errparam.extend = NULL
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] =  l_msg CLIPPED
                     CALL cl_err()
                  END IF
               END IF

               IF l_chk THEN
               #是否簽出,沒有簽出才可以往下執行
                  CALL adzp169_alm_get_dzlm() RETURNING lo_DZLM_T.*
                  IF lo_DZLM_T.DZLM008 = cs_check_out THEN   #SD狀態 I/O
                     LET l_chk = FALSE
                     DISPLAY "規格已被簽出"
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00351"   #%1已經被%2簽出, 請查明後再重試.
                     LET g_errparam.replace[1] = lo_DZLM_T.DZLM002

                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = lo_DZLM_T.DZLM007
                     CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
                     LET l_str = g_rtn_fields[1] CLIPPED,"(",lo_DZLM_T.DZLM007 CLIPPED,")"

                     LET g_errparam.replace[2] = l_str
                     LET g_errparam.extend = NULL
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     IF lo_DZLM_T.DZLM011 = cs_check_out THEN   #PR狀態
                        LET l_chk = FALSE
                        DISPLAY "程式已被簽出"
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "adz-00351"   #%1已經被%2簽出, 請查明後再重試.
                        LET g_errparam.replace[1] = lo_DZLM_T.DZLM002

                        INITIALIZE g_ref_fields TO NULL
                        LET g_ref_fields[1] = lo_DZLM_T.DZLM010
                        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
                        LET l_str = g_rtn_fields[1] CLIPPED,"(",lo_DZLM_T.DZLM007 CLIPPED,")"

                        LET g_errparam.replace[2] = l_str
                        LET g_errparam.extend = NULL
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                  END IF
               END IF

               IF l_chk THEN
                  CALL sadzp168_1_gzza002(g_udset.dzfi001,g_udset.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_udset.gzzal003   #程式類別,模組代碼,實際模組,程式名稱
                  IF cl_null(g_gzza003) OR cl_null(g_gzza003_module) THEN
                     LET l_chk = FALSE
                  END IF
               END IF
               DISPLAY g_udset.gzzal003 TO lb_gzzal003

               IF NOT l_chk THEN
                  LET g_udset.dzfi001 = NULL
                  LET g_udset.gzzal003 = NULL
                  DISPLAY g_udset.dzfi001 TO dzfi001
                  CALL g_dialog.nextField("dzfi001")
               ELSE
                  CALL adzp169_set_step_img(2)   #設定左方的流程圖
               END IF

               LET l_dzaf010_old = lo_DZAF_old.DZAF010   #dzaf010 識別標示 = dzaa009 客製標示
            END IF

            IF l_chk THEN
               CALL cl_set_comp_visible("grid2",1)
               CALL cl_set_comp_visible("grid1",0)
               CALL adzp169_cb_udtable(g_udset.dzfi001,lo_DZAF_old.DZAF003,l_dzaf010_old,g_udset.udtable) RETURNING g_udset.udtable
               CALL adzp169_cb_udcol(g_udset.udtable,g_udset.udcol,g_udset.dzfi001,lo_DZAF_old.DZAF003,l_dzaf010_old) RETURNING g_udset.udcol,g_udset.dzebl003
               DISPLAY BY NAME g_udset.udtable,g_udset.udcol,g_udset.dzebl003
            ELSE
               CALL g_dialog.nextField("dzfi001")
            END IF

         ON ACTION step_next3
            CASE
               WHEN cl_null(g_udset.udtable)
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00255"   #此欄位為必填欄位
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL g_dialog.nextField("udtable")

               WHEN cl_null(g_udset.udcol)
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00255"   #此欄位為必填欄位
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL g_dialog.nextField("udcol")

               OTHERWISE
                  LET l_chk = TRUE
            END CASE

            IF l_chk THEN
               DISPLAY g_udset.udcol,g_udset.udcol TO udcol_v1,udcol_v2
               #自定義欄位名稱
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_udset.udcol
               CALL ap_ref_array2(g_ref_fields," SELECT dzebl003 FROM dzebl_t WHERE dzebl001 = ? AND dzebl002 = '"||g_lang||"'","") RETURNING g_rtn_fields
               LET g_udset.dzebl003 = g_rtn_fields[1]
               DISPLAY BY NAME g_udset.dzebl003

               LET g_master_multi_table_t.dzebl001 = g_udset.udcol     #欄位代碼
               LET g_master_multi_table_t.dzebl003 = g_udset.dzebl003  #欄位名稱


               #控件類型
               #CALL cl_set_combo_scc('dzfj006','167')
               CALL adzp169_widget(g_udset.udtable,g_udset.udcol) RETURNING g_udset.dzfj006
               IF g_udset.dzfj006 = "DateEdit" THEN
                  CALL cl_set_combo_items("dzfj006", "DateEdit", "DateEdit")
               ELSE
                  CALL sadzp168_1_set_combo_scc('dzfj006','167')
               END IF

               CALL cl_set_comp_visible("grid3",1)
               CALL cl_set_comp_visible("grid2",0)
               CALL adzp169_set_step_img(3)   #設定左方的流程圖
            END IF

         ON ACTION step_next4
            CASE
               WHEN cl_null(g_udset.dzfj006)
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00255"   #此欄位為必填欄位
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL g_dialog.nextField("dzfj006")
               WHEN cl_null(g_udset.dzfj005_rel)
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00255"   #此欄位為必填欄位
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL g_dialog.nextField("dzfj005_rel")
               WHEN cl_null(g_udset.rel_position)
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00255"   #此欄位為必填欄位
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL g_dialog.nextField("rel_position")
               OTHERWISE
                  LET l_chk = TRUE
            END CASE

            IF l_chk THEN
               #日期,時間 的資料型態,一定要使用DateEdit的widget
               #非日期,時間 的資料型態,不可使用DateEdit的widget
               CALL adzp169_widget(g_udset.udtable,g_udset.udcol) RETURNING l_dzfj006
               IF l_dzfj006 = "DateEdit" THEN
                  IF g_udset.dzfj006 <> l_dzfj006 THEN
                     LET l_chk = FALSE
                  END IF
               ELSE
                  IF g_udset.dzfj006 = "DateEdit" THEN
                     LET l_chk = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00078"   #日期的資料型態,才可以使用DateEdit的控件
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL g_dialog.nextField("dzfj006")
                  END IF
               END IF
            END IF

            IF l_chk THEN
                LET g_sql = "SELECT COUNT(*) FROM dzfj_t",
                            " WHERE dzfjstus = 'Y' AND dzfj012 = 'N'",
                            "  AND dzfj001 = ? AND dzfj002 = ? AND dzfj017 = ?",
                            "  AND dzfj005 = ?"
                PREPARE adzp169_dzfj005_rel_cnt FROM g_sql
                EXECUTE adzp169_dzfj005_rel_cnt USING g_udset.dzfi001,lo_DZAF_old.DZAF003,l_dzaf010_old,g_udset.dzfj005_rel INTO l_cnt
                IF l_cnt = 0 THEN
                   LET l_chk = FALSE
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "lib-00070"   #欄位不存在此畫面中
                   LET g_errparam.popup = TRUE
                   LET g_errparam.extend = g_udset.dzfj005_rel
                   CALL cl_err()

                   CALL g_dialog.nextField("dzfj005_rel")
                END IF
            END IF

            IF l_chk THEN
               CALL cl_set_comp_visible("grid4",1)
               CALL cl_set_comp_visible("grid3",0)
               CALL adzp169_set_step_img(4)   #設定左方的流程圖

               IF g_udset.dzfj006 = "ButtonEdit" THEN
                  CALL cl_set_comp_entry("dzca001_i,dzca001_c",TRUE)
               ELSE
                  LET g_udset.dzca001_i = NULL
                  LET g_udset.dzca001_c = NULL
                  LET g_udset.dzca001_i_desc = NULL
                  LET g_udset.dzca001_c_desc = NULL
                  DISPLAY BY NAME g_udset.dzca001_i,g_udset.dzca001_c,g_udset.dzca001_i_desc,g_udset.dzca001_c_desc
                  CALL cl_set_comp_entry("dzca001_i,dzca001_c",FALSE)
               END IF
            END IF

         ON ACTION step_pre1
            CALL adzp169_step01()

         ON ACTION step_pre2
            CALL adzp169_step02()

         ON ACTION step_pre3
            CALL adzp169_step03()

      ON ACTION step01
         #CALL adzp169_step01()
      ON ACTION step02
         #CALL adzp169_step02()
      ON ACTION step03
         #CALL adzp169_step03()
      ON ACTION step04

      ON ACTION step_finish
         #AFTER FIELD 檢查
         #編輯時開窗
         IF NOT ap_chk_isExist(g_udset.dzca001_i,"SELECT COUNT(*) FROM dzca_t WHERE dzca001 = ?","azz-00159",0 ) THEN
            LET l_chk = FALSE
            NEXT FIELD dzca001_i
         END IF
         #查詢時開窗
         IF NOT ap_chk_isExist(g_udset.dzca001_c,"SELECT COUNT(*) FROM dzca_t WHERE dzca001 = ?","azz-00159",0 ) THEN
            LET l_chk = FALSE
            NEXT FIELD dzca001_c
         END IF
         #校驗帶值
         IF NOT ap_chk_isExist(g_udset.dzcd001,"SELECT COUNT(*) FROM dzcd_t WHERE dzcd001 = ?","azz-00160",0 ) THEN
            LET l_chk = FALSE
            NEXT FIELD dzcd001
         END IF

         #檢查開始設定與設定完成期間的版次是否有改變,若改變表示剛剛已被修改過畫面或程式,需要重新設定
         IF l_chk THEN
            CALL adzp169_get_curr_ver_info(g_udset.dzfi001,g_udset.dzfq005) RETURNING l_chk,lo_DZAF_new.*
         END IF
         IF l_chk THEN
            IF lo_DZAF_old.DZAF002 <> lo_DZAF_new.DZAF002 OR     #建構版號
               lo_DZAF_old.DZAF003 <> lo_DZAF_new.DZAF003 OR     #規格版號
               lo_DZAF_old.DZAF004 <> lo_DZAF_new.DZAF004 OR     #代碼版號
               lo_DZAF_old.DZAF010 <> lo_DZAF_new.DZAF010 THEN   #識別標示

               LET l_chk = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00187"   #剛剛已被修改過畫面或程式
               LET g_errparam.popup = TRUE
               LET g_errparam.extend = g_udset.gzzal003 CLIPPED,"(",g_udset.dzfi001 CLIPPED,")"
               CALL cl_err()

               ROLLBACK WORK   #transaction
               CALL adzp169_step01()   #從步驟一開始
            END IF
         END IF

         CALL cl_progress_bar(7)

         #產生客製設計資料並簽出
         LET l_check_out = FALSE   #是否簽出
         IF l_chk THEN
            CALL cl_getmsg("adz-00427",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)   #產生客製設計資料並簽出

            #開通前要先自動簽出,並產生規格樹(dzaa_t),UI樹(dzfi_t,dzfj_t,dzfk_t,dzfl_t),程式樹(dzba_t),SECTION樹(dzbc_t) :
            #參數 : lo_DZAF_old.*當下客製dzaf_t物件
            #回傳 : BOOLEAN TRUE:成功;FALSE:失敗 成功/失敗只要判斷這個即可
            #     : STRING 錯誤訊息
            #     : lo_DZAF_new物件成功就是新版的dzaf_t物件;失敗就是NULL
            CALL sadzp169_02_before_opening(lo_DZAF_old.*) RETURNING l_chk,l_msg,lo_DZAF_new.*
            #CALL adzp169_alm_get_dzlm_test()   #test
            IF NOT l_chk THEN
               ROLLBACK WORK   #transaction

               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00008"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  l_msg CLIPPED
               CALL cl_err()
            ELSE
               LET l_check_out = TRUE   #是否簽出
            END IF
         ELSE
            CALL cl_progress_ing("")   #產生客製設計資料並簽出
         END IF

         #產生畫面
         IF l_chk THEN
            CALL cl_getmsg("adz-00428",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)   #產生畫面

            #更新資料表欄位多語言檔,n_dzebl()只會更新開窗輸入的資料,在主程式欄位輸入的多語言資料並沒有更新,因此在此更新
            LET g_sql = "UPDATE dzebl_t SET dzebl003 = ? WHERE dzebl001 = ? AND dzebl002 = ?"
            PREPARE adzp169_col_name_pre FROM g_sql

            IF g_udset.udcol = g_master_multi_table_t.dzebl001 AND
               g_udset.dzebl003 <> g_master_multi_table_t.dzebl003  THEN
               EXECUTE adzp169_col_name_pre USING g_udset.dzebl003,g_udset.udcol,g_lang
            END IF

            LET g_dzaf003 = lo_DZAF_new.dzaf003      #規格版號
            LET g_dzaf010 = lo_DZAF_new.dzaf010      #識別標示 s/c/m
            #自定義自動配置4fd 設計資料
            CALL sadzp169_01() RETURNING l_chk
            #產生配置自定義欄位後，新版的4fd檔案
            IF l_chk THEN
               #p_form_name：畫面檔代碼
               #p_ver：規格版次
               #p_dgenv：識別標示
               #TRUE：固定boolean值，要編譯畫面
               DISPLAY "g_dzaf003=",g_dzaf003
               DISPLAY "g_dzaf010=",g_dzaf010
               CALL sadzp168_5(g_udset.dzfi001, g_dzaf003, g_dzaf010, TRUE) RETURNING l_chk,l_msg
               DISPLAY "sadzp168_5() l_msg=",l_msg
               IF NOT l_chk THEN
                  ROLLBACK WORK   #transaction

                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00008"
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  l_msg CLIPPED
                  CALL cl_err()
               END IF
               #傳入參數如下所述，回傳成功或失敗、錯誤訊息(這個function的錯誤訊息再麻煩你幫我彈窗提示使用者)．
            END IF
         ELSE
            CALL cl_progress_ing("")   #解析設計資料
         END IF

         #產生程式
         IF l_chk THEN
            CALL cl_getmsg("adz-00429",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)   #產生程式

            #CALL adzp169_rc3(g_udset.dzfi001, lo_DZAF_new.*,"0") RETURNING l_msg   #產生程式並compiler + link
            #產生程式並compiler + link
            #Hiko:此FUNCTION除非tab_gen發生錯誤, 否則就算編譯/鏈結錯誤, 我還是回傳正確(TRUE), 但是會列印錯誤訊息…
            #0:全做/ 1:做到產生和組合,不做編譯和鏈結/ 2:不做產生,只做組合,包含編譯和鏈結
            CALL sadzp060_2_rc3(g_udset.dzfi001, lo_DZAF_new.*, "0") RETURNING l_chk,l_msg
            IF NOT l_chk THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00008"
               LET g_errparam.extend = g_udset.dzfi001
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  l_msg CLIPPED
               CALL cl_err()
            END IF
         ELSE
            CALL cl_progress_ing("")   #產生程式
         END IF

         #自動簽入
         IF l_check_out THEN   #是否簽出
            CALL cl_getmsg("adz-00430",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)   #進行簽入

            #自動簽入
            # Input parameter : p_action 執行動作(o:check out/i:check in)
            #                 : po_old_cus_DZAF 舊的客製DZAF_T資料
            # Return code     : BOOLEAN TRUE:成功;FALSE:失敗
            #                 : STRING 錯誤訊息
            CALL sadzp169_02_check_out_in(cs_check_in, lo_DZAF_new.*) RETURNING l_chk,l_msg
            #CALL adzp169_alm_get_dzlm_test()   #test
            IF NOT l_chk THEN
               ROLLBACK WORK   #transaction

               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00008"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  l_msg CLIPPED
               CALL cl_err()
            END IF
         ELSE
            CALL cl_progress_ing("")   #進行簽入
         END IF

         #解析設計資料
         IF l_chk THEN
            CALL cl_getmsg("adz-00016",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)   #解析設計資料

            TRY
               #解析4fd畫面成設計資料工具
               #參數: 畫面檔所在模組, 畫面結構代號, 規格版次, 客製標示:s-標準產品, c-客製
               CALL sadzp168_3(g_gzza003_module, g_udset.dzfi001, g_dzaf003, g_dzaf010)
                  RETURNING l_result, l_str

               IF NOT l_result THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00008"
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  l_str CLIPPED
                  CALL cl_err()
               END IF

               IF l_result THEN
                  #取得畫面欄位資訊(含tsd資料與產生器資料)--取得欄位tab資訊
                  #參數: 畫面代號, 規格版本, 識別標示
                  CALL sadzp168_4(g_udset.dzfi001, g_dzaf003, g_dzaf010)
                     RETURNING l_result, l_str

                  IF NOT l_result THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00022"
                     LET g_errparam.extend = NULL
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] =  l_str CLIPPED
                     CALL cl_err()
                  END IF
               END IF
            CATCH
               DISPLAY l_msg CLIPPED,": SQLCA.SQLCODE=",SQLCA.SQLCODE CLIPPED,", STATUS=",STATUS
            END TRY

         ELSE
            CALL cl_progress_ing("")   #解析設計資料
         END IF

         #成功或失敗
         IF l_chk THEN
            COMMIT WORK   #transaction

            #因rc3會重新產生各語言42s並將客製檔案cp到"42s/畫面名稱/*.42s"
            #但檔案還沒完全複製完成,會導致接續執行程式開啟無42s,所以再次adzp169_42s避免時間差
            CALL cl_getmsg("adz-00431",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)   #產生多語言檔(42s)
            CALL adzp169_42s(g_udset.dzfi001) RETURNING l_chk
            LET l_chk = TRUE   #即使42產生錯誤,也要試著執行程式

            CALL cl_getmsg("adz-00217",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)  #執行成功

            IF l_chk THEN
               CALL adzp169_step01()   #從步驟一開始

               #執行程式
               CALL adzp169_exe(g_udset.dzfi001) RETURNING l_chk
            END IF
         ELSE
            ROLLBACK WORK   #transaction
            CALL cl_progress_ing("")   #產生多語言檔(42s)

            CALL cl_getmsg("adz-00218",g_lang) RETURNING l_msg
            CALL cl_progress_ing(l_msg)   #執行失敗
         END IF

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      #ON ACTION accept
      #   DISPLAY "ACCEPT DIALOG"

      #ON ACTION cancel      #在dialog button (放棄)
      #   LET g_action_choice=""
      #   LET INT_FLAG = TRUE
      #   EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG=TRUE
         LET g_action_choice = "exit"
         ROLLBACK WORK   #transaction
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG=TRUE
         LET g_action_choice = "exit"
         ROLLBACK WORK   #transaction
         EXIT DIALOG

      ##交談指令共用ACTION
      #&include "common_action.4gl"
      #   CONTINUE DIALOG
      ON ACTION about
         CALL cl_about()

      ON ACTION controlg
        CALL cl_cmdask()

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
      #交談指令共用ACTION --- end
   END DIALOG
END FUNCTION

#+ 設定下拉式選單內容-資料表來源
PRIVATE FUNCTION adzp169_cb_udtable(p_dzaa001,p_dzaa002,p_dzaa009,p_default_1)
   DEFINE p_dzaa001     LIKE dzag_t.dzag001   #規格編號
   DEFINE p_dzaa002     LIKE dzaa_t.dzaa002   #規格版次
   DEFINE p_dzaa009     LIKE dzaa_t.dzaa009   #客製標示
   DEFINE p_default_1   LIKE dzag_t.dzag002   #Table編號-預設值
   DEFINE l_dzag002     LIKE dzag_t.dzag002   #Table編號
   #DEFINE l_dzag003     LIKE dzag_t.dzag003   #識別碼版次
   #DEFINE l_dzag004     LIKE dzag_t.dzag004   #使用標示
   DEFINE ls_values     STRING                #ComboBox values
   DEFINE ls_items      STRING                #ComboBox items
   DEFINE l_default_1   LIKE dzag_t.dzag002   #預設值
   DEFINE l_ret_1       STRING
   DEFINE l_find        BOOLEAN
   DEFINE l_i           LIKE type_t.num5
   #DEFINE l_str         STRING
   DEFINE l_sql         STRING

   LET l_find = FALSE
   LET l_sql = "SELECT dzag002 FROM",
               " (SELECT * FROM dzaa_t",
               "     WHERE dzaastus = 'Y' AND dzaa001 = ? AND dzaa002 = ?",
               "       AND dzaa003 = 'TABLE' AND dzaa009 = ?",
               " ) aa",
               " LEFT JOIN dzag_t",
               " ON dzagstus = aa.dzaastus AND dzag001 = aa.dzaa001",
               " AND dzag003 = aa.dzaa004 AND dzag006 = aa.dzaa006",
               " ORDER BY dzag005 DESC"
   PREPARE adzp169_cb_udtable_pre FROM l_sql
   DECLARE adzp169_cb_udtable_cur CURSOR FROM l_sql

   LET l_i = 1
   FOREACH adzp169_cb_udtable_cur USING p_dzaa001,p_dzaa002,p_dzaa009 INTO l_dzag002
      IF l_i = 1 THEN
         LET l_default_1 = l_dzag002 CLIPPED
         LET ls_values = l_dzag002 CLIPPED
         LET ls_items = l_dzag002 CLIPPED
      ELSE
         LET ls_values = ls_values CLIPPED, ",", l_dzag002 CLIPPED
         LET ls_items = ls_items CLIPPED, ",", l_dzag002 CLIPPED
      END IF

      IF p_default_1 = l_dzag002 THEN
         LET l_find = TRUE
      END IF

      LET l_i = l_i + 1
   END FOREACH

   IF l_find THEN
      LET l_ret_1 = p_default_1 CLIPPED
   ELSE
      LET l_ret_1 = l_default_1 CLIPPED
   END IF

   CALL cl_set_combo_items("udtable", ls_values, ls_items)

   RETURN l_ret_1
END FUNCTION

#+ 設定下拉式選單內容-自定義欄位
PRIVATE FUNCTION adzp169_cb_udcol(p_udtable,p_default_1,p_dzfi001,p_dzaa002,p_dzaa009)
   DEFINE p_udtable     LIKE dzeb_t.dzeb001     #資料表來源
   DEFINE p_default_1   LIKE dzeb_t.dzeb002     #自定義欄位-預設值
   DEFINE p_dzfi001     LIKE dzfi_t.dzfi001     #結構代號(畫面代號)
   DEFINE p_dzaa002     LIKE dzaa_t.dzaa002     #規格版次
   DEFINE p_dzaa009     LIKE dzaa_t.dzaa009     #客製標示
   DEFINE l_default_1   LIKE dzeb_t.dzeb002     #預設值-欄位編號
   DEFINE l_default_2   LIKE dzebl_t.dzebl003   #預設值-欄位名稱
   DEFINE l_ret_1       STRING
   DEFINE l_ret_2       STRING
   DEFINE l_dzeb002     LIKE dzeb_t.dzeb002     #自定義欄位
   DEFINE l_dzebl003    LIKE dzebl_t.dzebl003   #
   DEFINE ls_values     STRING                  #ComboBox values
   DEFINE ls_items      STRING                  #ComboBox items
   DEFINE l_find        BOOLEAN
   DEFINE l_i           LIKE type_t.num5
   #DEFINE l_str         STRING
   DEFINE l_sql         STRING
   DEFINE l_spos        LIKE type_t.num5
   DEFINE l_epos        LIKE type_t.num5
   DEFINE l_str         STRING

   LET l_find = FALSE

   #排除已存在於此畫面的欄位
   LET l_sql = "SELECT DISTINCT dzeb002,dzebl003 FROM",
               " (SELECT * FROM dzeb_t",
               "   WHERE dzeb001 = ? AND dzeb022 IN ('cdfUserDefineDateTime','cdfUserDefineNumber','cdfUserDefineVarchar')",
               " )",
               " LEFT JOIN dzebl_t",
               " ON dzebl001 = dzeb002 AND dzebl002 = ?",
               " LEFT JOIN (",
               "     SELECT dzfj005,COUNT(dzfj005) AS dzfj005_cnt",
               "     FROM dzfj_t",
               "     WHERE dzfj001 = ? AND dzfj002 = ? AND dzfj017 = ? AND dzfjstus = 'Y'",
               "     GROUP BY dzfj005",
               " )",
               " ON dzfj005 LIKE CONCAT('%', dzeb002)",
               " WHERE dzfj005_cnt = 0 OR dzfj005_cnt IS NULL",
               " ORDER BY dzeb002"
   PREPARE adzp169_cb_udcol_pre FROM l_sql
   DECLARE adzp169_cb_udcol_cur CURSOR FROM l_sql

   LET l_i = 1
   FOREACH adzp169_cb_udcol_cur USING p_udtable,g_lang,p_dzfi001,p_dzaa002,p_dzaa009 INTO l_dzeb002,l_dzebl003

      IF l_i = 1 THEN
         LET l_default_1 = l_dzeb002 CLIPPED
         LET l_default_2 = l_dzebl003 CLIPPED
         LET ls_values = l_dzeb002 CLIPPED
         LET ls_items = l_dzeb002 CLIPPED,": ",l_dzebl003 CLIPPED
      ELSE
         LET ls_values = ls_values CLIPPED, ",", l_dzeb002 CLIPPED
         LET ls_items = ls_items CLIPPED, ",", l_dzeb002 CLIPPED,": ",l_dzebl003 CLIPPED
      END IF

      IF p_default_1 = l_dzeb002 THEN
         LET l_find = TRUE
         LET l_ret_2 = l_dzebl003 CLIPPED   #欄位多語言用資料庫的,避免傳入參數是舊值
      END IF

      LET l_i = l_i + 1
   END FOREACH

   IF l_find THEN
      LET l_ret_1 = p_default_1 CLIPPED

   ELSE
      LET l_ret_1 = l_default_1 CLIPPED
      LET l_ret_2 = l_default_2 CLIPPED
   END IF

   CALL cl_set_combo_items("udcol", ls_values, ls_items)

   RETURN l_ret_1,l_ret_2
END FUNCTION

#+ 設定下拉式選單內容-自定義欄位
PRIVATE FUNCTION adzp169_widget(p_tb,p_col)
   DEFINE p_tb         LIKE dzeb_t.dzeb001     #資料表來源
   DEFINE p_col        LIKE dzeb_t.dzeb002     #自定義欄位-預設值
   DEFINE l_sql        STRING
   DEFINE l_wg RECORD
      gztd005       LIKE gztd_t.gztd005,      #azzi090的widget代碼
      dzej003_t1    LIKE dzej_t.dzej003,      #widget類型
      dzep010       LIKE dzep_t.dzep010,      #adzi150的widget代碼
      dzej003_t2    LIKE dzej_t.dzej003       #widget類型
      END RECORD
   DEFINE l_dzej003    LIKE dzej_t.dzej003     #widget類型

   #r.t欄位屬性->資料控件
   LET l_sql =
         " SELECT gztd005,t1.dzej003,dzep010,t2.dzej003",
         " FROM (",
         "    SELECT * FROM dzeb_t",
         "    WHERE dzeb001 = ? AND dzeb002 =?",
         " )",
         " LEFT JOIN (",
         "    SELECT * FROM gztd_t WHERE gztdstus ='Y'",
         " )",
         " ON gztd001=dzeb006",
         " LEFT JOIN (",
         "    SELECT dzej002 ,dzej003 FROM dzej_t",
         "    WHERE dzej001 = 'GENERO_WIDGETS'",
         " ) t1",
         " ON t1.dzej002 = gztd005",

         # adzi150的dzep010會有NULL
         " LEFT JOIN (",
         "    SELECT dzep001,dzep002,dzep010 FROM dzep_t",
         " )",
         " ON dzep001 = dzeb001 AND dzep002 = dzeb002",
         " LEFT JOIN (",
         "    SELECT dzej002 ,dzej003 FROM dzej_t",
         "    WHERE dzej001 = 'GENERO_WIDGETS'",
         " ) t2",
         " ON t2.dzej002 = dzep010"
   PREPARE adzp169_widget_pre FROM l_sql
   EXECUTE adzp169_widget_pre USING p_tb,p_col INTO l_wg.*

   IF cl_null(l_wg.dzej003_t2) THEN
      LET l_dzej003 = l_wg.dzej003_t1
   ELSE
      LET l_dzej003 = l_wg.dzej003_t2
   END IF

   RETURN l_dzej003
END FUNCTION


#+ 挑選相對欄位
#自定義欄位若不屬於單身Table,則不可挑選單身ScreenRecord的欄位
#自定義欄位若屬於單身Table,則只能挑選同一個ScreenRecord的欄位
PRIVATE FUNCTION adzp169_sel_dzfj005(p_dzaa001,p_dzaa002,p_dzaa009,p_dzfs004)
   DEFINE p_dzaa001     LIKE dzag_t.dzag001   #規格編號
   DEFINE p_dzaa002     LIKE dzaa_t.dzaa002   #規格版次
   DEFINE p_dzaa009     LIKE dzaa_t.dzaa009   #客製標示
   DEFINE p_dzfs004     LIKE dzfs_t.dzfs004   #資料表編號
   DEFINE l_sql         STRING
   DEFINE l_dzfj005     LIKE dzfj_t.dzfj005   #欄位
   DEFINE l_dzfi006     LIKE dzfi_t.dzfi006   #ScreenRecord
   DEFINE l_where_m     STRING
   DEFINE l_where_d     STRING
   DEFINE l_cnt         LIKE type_t.num5      #161220-00051#1

   LET l_sql =
         "SELECT dzfi006",
         " FROM",
         " (",
         " SELECT *",
         " FROM dzfi_t",
         " WHERE dzfistus = 'Y' AND dzfi001 = ? AND dzfi002 = ? AND dzfi009 = ?",
         "   AND dzfi007 IN ('Tree','Table','ScrollGrid')",
         "   AND dzfi006 NOT IN ('s_relateapps','s_queryplan','relateapps','queryplan','s_browse')",
         " ) ",
         " LEFT JOIN dzaa_t",
         " ON dzaastus = dzfistus",
         "    AND dzaa001 = dzfi001",
         "    AND dzaa002 = dzfi002",
         "    AND dzaa003 = 'TABLE'",
         "    AND dzaa009 = dzfi009",
         " LEFT JOIN dzfs_t",
         " ON dzfs001 = dzaa004",
         "    AND dzfs002 = dzaa001",
         "    AND dzfs003 = dzfi006",
         "    AND dzfs005 = dzaa006",
         "    AND dzfsstus = dzaastus",
         " WHERE dzfs004 = ?"
   PREPARE adzp169_sel_dzfj005_sr_pre FROM l_sql
   ###161220-00051#1 mark START ###
   #EXECUTE adzp169_sel_dzfj005_sr_pre USING p_dzaa001,p_dzaa002,p_dzaa009,p_dzfs004 INTO l_dzfi006
   ##不屬於單身Table
   #IF cl_null(l_dzfi006) THEN
   #   LET g_qryparam.where = "dzfs004 IS NULL"
   ##屬於單身Table
   #ELSE
   #   LET g_qryparam.where = "t1.dzfi004 = '",l_dzfi006 CLIPPED,"'"
   #END IF
   ###161220-00051#1 mark END ###
   ###161220-00051#1 START ###
   INITIALIZE g_qryparam.* TO NULL
   #一個資料表可能出現在多個單身，或同時出現在單頭和單身
   DECLARE adzp169_sel_dzfj005_sr_cur CURSOR FOR adzp169_sel_dzfj005_sr_pre
   LET l_where_m = ""
   LET l_where_d = ""
   FOREACH adzp169_sel_dzfj005_sr_cur USING p_dzaa001,p_dzaa002,p_dzaa009,p_dzfs004 INTO l_dzfi006
      #不屬於單身Table
      IF cl_null(l_dzfi006) THEN
         LET l_where_m = "dzfs004 IS NULL"
      #屬於單身Table
      ELSE
         IF cl_null(l_where_d) THEN
            LET l_where_d = "t1.dzfi004 = '",l_dzfi006 CLIPPED,"'"
         ELSE
            LET l_where_d = l_where_d CLIPPED," OR t1.dzfi004 = '",l_dzfi006 CLIPPED,"'"
         END IF
      END IF
   END FOREACH
   IF NOT cl_null(l_where_m) THEN
      LET g_qryparam.where = l_where_m
   ELSE
      #假雙檔只有一個資料表時,再開放單頭可以加欄位
      LET l_sql = " SELECT COUNT(dzag002) FROM",  
                  " (SELECT * FROM dzaa_t ",
                      " WHERE dzaastus = 'Y' AND dzaa001 = ? AND dzaa002 = ?",
                        " AND dzaa003 = 'TABLE' AND dzaa009 = ?",
                  " ) aa",
                  " LEFT JOIN dzag_t",
                  " ON dzagstus = aa.dzaastus AND dzag001 = aa.dzaa001",
                  " AND dzag003 = aa.dzaa004 AND dzag006 = aa.dzaa006"
      PREPARE adzp169_sel_dzfj005_dzagcnt FROM l_sql
      EXECUTE adzp169_sel_dzfj005_dzagcnt USING p_dzaa001,p_dzaa002,p_dzaa009 INTO l_cnt
      IF l_cnt = 1 THEN
         LET l_where_m = "dzfs004 IS NULL"
         LET g_qryparam.where = l_where_m
      END IF
   END IF
   IF NOT cl_null(l_where_d) THEN
      IF cl_null(g_qryparam.where) THEN
         LET g_qryparam.where = "(",l_where_d CLIPPED,")"
      ELSE
         LET g_qryparam.where = "(",g_qryparam.where CLIPPED," OR (",l_where_d CLIPPED,"))"
      END IF
   END IF
   ###161220-00051#1 END ###

   LET g_qryparam.state = "i"
   LET g_qryparam.reqry = FALSE
   LET g_qryparam.default1 = g_udset.dzfj005_rel
   LET g_qryparam.default2 = NULL
   LET g_qryparam.default3 = NULL
   LET g_qryparam.default4 = NULL
   LET g_qryparam.arg1 = p_dzaa001
   LET g_qryparam.arg2 = p_dzaa002
   LET g_qryparam.arg3 = p_dzaa009
   CALL adzp169_01()
   LET g_qryparam.where = NULL
   LET g_qryparam.arg1 = NULL
   LET g_qryparam.arg2 = NULL
   LET g_qryparam.arg3 = NULL
   LET g_udset.dzfj005_rel = g_qryparam.return1
END FUNCTION

################################################################################
# Descriptions...: 設定左方流程圖片
# Memo...........:
# Usage..........: CALL apmp490_set_step_img(p_step)
# Input parameter: p_step：第幾步驟的圖
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION adzp169_set_step_img(p_step)
   DEFINE p_step     LIKE type_t.num5

   CALL gfrm_curr.setElementImage("step01","32/step01.png")
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   CALL gfrm_curr.setElementImage("step04","32/step04.png")

   CALL gfrm_curr.setElementStyle("step01","menuitem")
   CALL gfrm_curr.setElementStyle("step02","menuitem")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   CALL gfrm_curr.setElementStyle("step04","menuitem")

   CASE p_step
      WHEN 1
         CALL gfrm_curr.setElementImage("step01","32/step01on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step01","menuitemfocus")
      WHEN 2
         CALL gfrm_curr.setElementImage("step02","32/step02on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step02","menuitemfocus")
      WHEN 3
         CALL gfrm_curr.setElementImage("step03","32/step03on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step03","menuitemfocus")
      WHEN 4
         CALL gfrm_curr.setElementImage("step04","32/step04on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step04","menuitemfocus")
   END CASE
END FUNCTION

PRIVATE FUNCTION adzp169_step01()
      CALL cl_set_comp_visible("grid1",1)
      CALL cl_set_comp_visible("grid2",0)
      CALL cl_set_comp_visible("grid3",0)
      CALL cl_set_comp_visible("grid4",0)
      CALL adzp169_set_step_img(1)   #設定左方的流程圖
      CALL g_dialog.nextField("dzfi001")
END FUNCTION

PRIVATE FUNCTION adzp169_step02()
      CALL cl_set_comp_visible("grid1",0)
      CALL cl_set_comp_visible("grid2",1)
      CALL cl_set_comp_visible("grid3",0)
      CALL cl_set_comp_visible("grid4",0)
      CALL adzp169_set_step_img(2)   #設定左方的流程圖
      CALL g_dialog.nextField("udcol")
END FUNCTION

PRIVATE FUNCTION adzp169_step03()
      CALL cl_set_comp_visible("grid1",0)
      CALL cl_set_comp_visible("grid2",0)
      CALL cl_set_comp_visible("grid3",1)
      CALL cl_set_comp_visible("grid4",0)
      CALL adzp169_set_step_img(3)   #設定左方的流程圖
      CALL g_dialog.nextField("dzfj006")
END FUNCTION

FUNCTION adzp169_get_curr_ver_info(p_dzfi001,p_dzfq005)
   DEFINE p_dzfi001           LIKE dzfi_t.dzfi001
   DEFINE p_dzfq005           LIKE dzfq_t.dzfq005
   DEFINE lo_DZAF_T           T_DZAF_T
   DEFINE l_msg               STRING
   DEFINE l_chk               BOOLEAN

   CALL cl_adz_get_curr_ver_info(p_dzfi001,NULL,p_dzfq005) RETURNING lo_DZAF_T.*,l_msg
   #dzaf001 建構代號  #lo_DZAF_old.DZAF001 = "asfr340"
   #dzaf002 建構版號  #lo_DZAF_old.DZAF002 = "5"
   #dzaf003 規格版號  #lo_DZAF_old.DZAF003 = "5"
   #dzaf004 代碼版號  #lo_DZAF_old.DZAF004 = "3"
   #dzaf005 建構類型  #lo_DZAF_old.DZAF005 = "M"
   #dzaf006 模組     #lo_DZAF_old.DZAF006 = "ASF"
   #dzaf007 產品代號  #lo_DZAF_old.DZAF007 = "T100ERP"
   #dzaf008 產品版本  #lo_DZAF_old.DZAF008 = "1.0"
   #dzaf009 客戶代號  #lo_DZAF_old.DZAF009 = "DIGIWIN"
   #dzaf010 識別標示  #lo_DZAF_old.DZAF010 = "s"

   #display "建構代號=",lo_DZAF_T.DZAF001
   #display "建構版號=",lo_DZAF_T.DZAF002
   #display "規格版號=",lo_DZAF_T.DZAF003
   #display "代碼版號=",lo_DZAF_T.DZAF004
   #display "建構類型=",lo_DZAF_T.DZAF005
   #display "模組   =",lo_DZAF_T.DZAF006
   #display "產品代號=",lo_DZAF_T.DZAF007
   #display "產品版本=",lo_DZAF_T.DZAF008
   #display "客戶代號=",lo_DZAF_T.DZAF009
   #display "識別標示=",lo_DZAF_T.DZAF010


   IF NOT cl_null(l_msg) THEN
      LET l_chk = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00008"
      LET g_errparam.extend = p_dzfi001
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_msg CLIPPED
      CALL cl_err()
   ELSE
      LET l_chk = TRUE
   END IF

   RETURN l_chk,lo_DZAF_T.*
END FUNCTION

FUNCTION adzp169_alm_get_dzlm()
   DEFINE lo_program_info     T_PROGRAM_INFO
   DEFINE lo_DZLM_T           T_DZLM_T

   CALL sadzp168_1_gzza002(g_udset.dzfi001,g_udset.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_udset.gzzal003   #程式類別,模組代碼,實際模組,程式名稱
   LET lo_program_info.pi_TYPE   = g_udset.dzfq005
   LET lo_program_info.pi_MODULE = g_gzza003
   LET lo_program_info.pi_NAME   = g_udset.dzfi001
   CALL sadzp200_alm_get_dzlm(lo_program_info.*,cs_user_role_all) RETURNING lo_DZLM_T.*
   #CONSTANT cs_user_role_all      STRING = "ALL"
   #CONSTANT cs_user_role_pr       STRING = "PR"
   #CONSTANT cs_user_role_sd       STRING = "SD"
   #CONSTANT cs_user_role_registry STRING = "RG"
   #display lo_DZLM_T.DZLM001,":建構類型   "      #M:建構類型
   #display lo_DZLM_T.DZLM002,":建構代號   "      #azzi930:建構代號
   #display lo_DZLM_T.DZLM003,":建構名稱   "      #客服人員設定作業:建構名稱
   #display lo_DZLM_T.DZLM004,":模組       "      #AZZ:模組
   #display lo_DZLM_T.DZLM005,":建構版號   "      #2:建構版號
   #display lo_DZLM_T.DZLM006,":SD版號     "      #2:SD版號
   #display lo_DZLM_T.DZLM007,":SD工號     "      #01101:SD工號
   #display lo_DZLM_T.DZLM008,":SD狀態     "      #O:SD狀態
   #display lo_DZLM_T.DZLM009,":PR版號     "      #2:PR版號
   #display lo_DZLM_T.DZLM010,":PR工號     "      #01101:PR工號
   #display lo_DZLM_T.DZLM011,":PR狀態     "      #O:PR狀態
   #display lo_DZLM_T.DZLM012,":需求單號   "      #140812-00067:需求單號
   #display lo_DZLM_T.DZLM013,":產品代號   "      #T100ERP:產品代號
   #display lo_DZLM_T.DZLM014,":產品版本   "      #1.0:產品版本
   #display lo_DZLM_T.DZLM015,":作業項次   "      #          1:作業項次
   #display lo_DZLM_T.DZLM016,":客戶代碼   "      # :客戶代碼
   #display lo_DZLM_T.DZLM017,":簽入時間   "      #          :簽入時間
   #display lo_DZLM_T.DZLM018,":SD GUID   "      #D494B5E2-E1DE-4193-AF72-066FDE561A57:SD GUID
   #display lo_DZLM_T.DZLM019,":PR GUID   "      #C0C802CB-1A7E-4E74-AFEE-FCE2C0AF01CC:PR GUID
   #display lo_DZLM_T.DZLM020,":SD 已下載  "      #Y:SD 已下載
   #display lo_DZLM_T.DZLM021,":PR 已下載  "      #Y:PR 已下載

   RETURN lo_DZLM_T.*
END FUNCTION


#FUNCTION adzp169_alm_get_dzlm_test()
#   DEFINE lo_program_info     T_PROGRAM_INFO
#   DEFINE lo_DZLM_T           T_DZLM_T
#
#   CALL sadzp168_1_gzza002(g_udset.dzfi001,g_udset.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_udset.gzzal003   #程式類別,模組代碼,實際模組,程式名稱
#   LET lo_program_info.pi_TYPE   = g_udset.dzfq005
#   LET lo_program_info.pi_MODULE = g_gzza003
#   LET lo_program_info.pi_NAME   = g_udset.dzfi001
#   CALL sadzp200_alm_get_dzlm(lo_program_info.*,cs_user_role_all) RETURNING lo_DZLM_T.*
#   #CONSTANT cs_user_role_all      STRING = "ALL"
#   #CONSTANT cs_user_role_pr       STRING = "PR"
#   #CONSTANT cs_user_role_sd       STRING = "SD"
#   #CONSTANT cs_user_role_registry STRING = "RG"
#   display lo_DZLM_T.DZLM001,":建構類型   "      #M:建構類型
#   display lo_DZLM_T.DZLM002,":建構代號   "      #azzi930:建構代號
#   display lo_DZLM_T.DZLM003,":建構名稱   "      #客服人員設定作業:建構名稱
#   display lo_DZLM_T.DZLM004,":模組       "      #AZZ:模組
#   display lo_DZLM_T.DZLM005,":建構版號   "      #2:建構版號
#   display lo_DZLM_T.DZLM006,":SD版號     "      #2:SD版號
#   display lo_DZLM_T.DZLM007,":SD工號     "      #01101:SD工號
#   display lo_DZLM_T.DZLM008,":SD狀態     "      #O:SD狀態
#   display lo_DZLM_T.DZLM009,":PR版號     "      #2:PR版號
#   display lo_DZLM_T.DZLM010,":PR工號     "      #01101:PR工號
#   display lo_DZLM_T.DZLM011,":PR狀態     "      #O:PR狀態
#   display lo_DZLM_T.DZLM012,":需求單號   "      #140812-00067:需求單號
#   display lo_DZLM_T.DZLM013,":產品代號   "      #T100ERP:產品代號
#   display lo_DZLM_T.DZLM014,":產品版本   "      #1.0:產品版本
#   display lo_DZLM_T.DZLM015,":作業項次   "      #          1:作業項次
#   display lo_DZLM_T.DZLM016,":客戶代碼   "      # :客戶代碼
#   display lo_DZLM_T.DZLM017,":簽入時間   "      #          :簽入時間
#   display lo_DZLM_T.DZLM018,":SD GUID   "      #D494B5E2-E1DE-4193-AF72-066FDE561A57:SD GUID
#   display lo_DZLM_T.DZLM019,":PR GUID   "      #C0C802CB-1A7E-4E74-AFEE-FCE2C0AF01CC:PR GUID
#   display lo_DZLM_T.DZLM020,":SD 已下載  "      #Y:SD 已下載
#   display lo_DZLM_T.DZLM021,":PR 已下載  "      #Y:PR 已下載
#END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 程式重產與重組sadzp060_2_rc3(p_prog, p_dzaf)
# Usage..........:  CALL adzp169_rc3(p_prog, p_dzaf)
# Input parameter : p_prog 程式代號
#                 : p_dzaf 版次資訊
# Return code     : 錯誤訊息
# Date & Author   : 2014/10/08 by Hiko
##########################################################################
#PRIVATE FUNCTION adzp169_rc3(p_prog, p_dzaf,p_c3)
#   DEFINE p_c3   STRING           #0:產生程式,compiler + link; 1:只產生程式,不做compiler + link     #todo
#   DEFINE p_prog STRING,
#          p_dzaf T_DZAF_T
#   DEFINE l_type LIKE dzaf_t.dzaf005,
#          l_spec_revision LIKE dzaf_t.dzaf003,
#          l_code_revision LIKE dzaf_t.dzaf004,
#          l_identity LIKE dzaf_t.dzaf010
#   DEFINE ls_cmd STRING,
#          lb_result BOOLEAN,
#          ls_err_msg STRING,
#          ls_err_msg3 STRING
#
#   LET l_type = p_dzaf.dzaf005 CLIPPED
#   LET l_spec_revision = p_dzaf.dzaf003
#   LET l_code_revision = p_dzaf.dzaf004
#   LET l_identity = p_dzaf.dzaf010 CLIPPED
#
#   #要做4gl重新產生的動作(不做編譯..)
#   IF l_type="G" OR l_type="X" THEN #報表元件設計資料的版次是屬於"程式"
#      DISPLAY "adzp169_rc3 ... sadzp060_2_rc3 : call sadzp030_tab_gen(",p_prog,",",l_code_revision,",'',",l_identity,")"
#      CALL sadzp030_tab_gen(p_prog, l_code_revision, "", l_identity) RETURNING lb_result
#   ELSE
#      DISPLAY "adzp169_rc3 ... sadzp060_2_rc3 : call sadzp030_tab_gen(",p_prog,",",l_spec_revision,",'',",l_identity,")"
#      CALL sadzp030_tab_gen(p_prog, l_spec_revision, "", l_identity) RETURNING lb_result
#   END IF
#
#   IF NOT lb_result THEN
#      LET ls_err_msg = "ERROR : call sadzp030_tab_gen fail!"
#      RETURN ls_err_msg
#   ELSE
#      #編譯錯誤沒關係
#      LET ls_cmd = "r.c3 ",p_prog," ","''"," ",l_code_revision," ",p_c3 CLIPPED," ",l_identity   #todo
#      DISPLAY "adzp169_rc3 ... sadzp060_2_rc3 : ",ls_cmd
#      CALL cl_cmdrun_openpipe("r.c3", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg3
#      IF NOT lb_result THEN
#         DISPLAY "adzp169_rc3 ... WARNING : ",ls_err_msg3
#      END IF
#   END IF
#
#   RETURN NULL
#END FUNCTION

#+ 產生當下的畫面多語言
#因rc3會重新產生各語言42s並將客製檔案cp到"42s/畫面名稱/*.42s"
#但檔案還沒完全複製完成,會導致接續執行程式開啟無42s,所以再次adzp169_42s避免時間差
PRIVATE FUNCTION adzp169_42s(p_prog)
   DEFINE p_prog      STRING
   DEFINE l_cmd       STRING
   DEFINE l_buf       STRING
   DEFINE l_chk       BOOLEAN           #檢查是否執行成功
   DEFINE l_str       STRING
   DEFINE l_sindex    LIKE type_t.num5
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING

   LET l_chk = TRUE

   IF l_chk THEN
      LET l_cmd = "r.r azzp191 ",p_prog CLIPPED," ",g_lang CLIPPED    #執行程式
      CALL cl_cmdrun_openpipe("r.r",l_cmd,TRUE) RETURNING l_chk,l_str
   END IF

   RETURN l_chk
END FUNCTION

#+ 執行程式
PRIVATE FUNCTION adzp169_exe(p_prog)
   DEFINE p_prog      STRING
   DEFINE l_cmd       STRING
   DEFINE l_buf       STRING
   DEFINE l_chk       BOOLEAN           #檢查是否執行成功
   DEFINE l_str       STRING
   DEFINE l_sindex    LIKE type_t.num5
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING

   LET l_chk = TRUE

   IF l_chk THEN
      LET la_param.prog = g_udset.dzfi001
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun(ls_js)
   END IF

   RETURN l_chk
END FUNCTION