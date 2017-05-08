#+ 程式版本......: T6 Version 1.00.00 Build-0009 at 13/03/18
#
#+ 程式代碼......: adzp610
#+ 設計人員......: elena
#+ 功能名稱說明...: 跨行業規格與程式產生工具
#+ 修改歷程......: 2016/08/30 by elena : 建立程式


IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp270.inc"


DEFINE ms_dgenv             LIKE dzaf_t.dzaf010,       #環境變數DGENV (s:標準/ c:客製)  
       ms_erpid             LIKE dzaf_t.dzaf007,       #環境變數ERPID(產品代號)         
       ms_erpver            LIKE dzaf_t.dzaf008,       #環境變數ERPVER(產品版本)        
       ms_cust              LIKE dzaf_t.dzaf009,       #環境變數CUST (客戶代號)         
       ms_topind            STRING                     #環境變數TOPIND(行業別)  



DEFINE g_main_or_sub_prog     STRING,              　    #類型:主程式和畫面/子程式和畫面/子畫面
       g_source_prog          LIKE dzaa_t.dzaa001,       #複製來源
       g_source_ver           STRING,              　    #來源建構版次
       g_source_spec_ver      STRING,                    #來源規格版次
       g_source_spec_ver_col  LIKE dzaa_t.dzaa002,       #來源規格版次
       g_source_code_ver      STRING,                    #來源代碼版次
       g_source_code_ver_col  LIKE dzaa_t.dzaa002,       #來源代碼版次
       g_source_module        LIKE gzzo_t.gzzo001,       #來源模組
       g_source_identity      LIKE dzaf_t.dzaf010,       #來源識別標示
       g_source_prog_name     LIKE gzzal_t.gzzal003,     #來源程式名稱
       g_source_4fd_path      STRING               　    #來源程式的4FD檔的檔案路徑       

DEFINE g_gen_prog             LIKE dzaa_t.dzaa001,       #複製目標
       g_gen_ver              STRING,              　    #目標建構版次
       g_gen_spec_ver         STRING,                    #目標規格版次
       g_gen_code_ver         STRING,                    #目標代碼版次
       g_gen_module           LIKE gzzo_t.gzzo001,       #目標模組
       g_gen_identity         LIKE dzaf_t.dzaf010,       #目標識別標示
       g_gen_prog_name        LIKE gzzal_t.gzzal003,     #目標程式名稱
       g_gen_4fd_path         STRING,              　    #目標程式的4FD檔的檔案路徑
       g_gen_topind           STRING,                    #目標程式topind
       g_gen_role             STRING                     #角色(SD/PR/ALL)

#作業開始
MAIN

   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING

   OPTIONS
   INPUT WRAP

   CALL cl_tool_init()

   #此支程式只能在行業環境執行
    IF NOT sadzp060_ind_check_area() THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00811"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF


   #畫面開啟 (identifier)
   OPEN WINDOW w_adzp610 WITH FORM cl_ap_formpath("adz",g_prog)

   CLOSE WINDOW screen

   CALL adzp610_init()

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   CALL adzp610_input()

   #畫面關閉
   CLOSE WINDOW w_adzp610

   #離開作業
   CALL cl_ap_exitprogram("0")

END MAIN

#初始化變數
PRIVATE FUNCTION adzp610_init()

   LET ms_topind = FGL_GETENV("TOPIND")
   LET ms_dgenv  = FGL_GETENV("DGENV")
   LET ms_erpid  = FGL_GETENV("ERP")
   LET ms_erpver = FGL_GETENV("ERPVER")
   LET ms_cust   = FGL_GETENV("CUST")

   LET g_main_or_sub_prog = "M"

END FUNCTION

#資料輸入
PRIVATE FUNCTION adzp610_input()

DEFINE lb_result   BOOLEAN,   #回傳執行結果使用
       ls_result   STRING,    #回傳建議複製目標程式編號
       ls_err_msg  STRING,    #錯誤訊息使用
       ls_sql      STRING,    #SQL使用
       ls_str      STRING,    #字串處理使用
       ls_str1     STRING,    #字串處理使用
       lo_DZAF_T   T_DZAF_T,
       ln_cnt      LIKE type_t.num5,
       ls_trigger  STRING     #紀錄目前執行階段

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

     INPUT g_main_or_sub_prog, g_source_prog, g_source_ver, g_source_spec_ver, g_source_code_ver, g_gen_prog, g_gen_topind
           FROM
           s_main_or_sub_prog, s_source_prog, s_source_ver, s_source_spec_ver, s_source_code_ver, s_gen_prog, s_gen_topind 
           ATTRIBUTE(WITHOUT DEFAULTS)

        #複製來源開窗
        ON ACTION controlp INFIELD s_source_prog
           CASE
               WHEN g_main_or_sub_prog="M"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_source_prog
                  LET g_qryparam.where = "gzzastus = 'Y' AND gzza003 <> 'ADZ' AND gzzb002 in ('",ms_topind,"')"
                  CALL q_gzza001_01()
               WHEN g_main_or_sub_prog="S"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "gzde003 <> 'ADZ' AND gzde009 in ('",ms_topind,"')" 
                  CALL q_gzde001_03()
               WHEN g_main_or_sub_prog="F"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1 = ms_topind
                  CALL q_gzdf002_4()
               WHEN g_main_or_sub_prog="B"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1=g_main_or_sub_prog
                  LET g_qryparam.where = "gzde009 in ('",ms_topind,"')"
                  CALL q_gzde002_1()
               WHEN g_main_or_sub_prog="Q"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "dzca006 = 'Y' AND dzca007 in ('",ms_topind,"')" #只能選hard code=Y的資料
                  CALL q_dzca001_03()
               WHEN g_main_or_sub_prog="Z"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_source_prog
                  LET g_qryparam.where = "gzjastus = 'Y' AND gzja002 <> 'ADZ' AND gzja006 in ('",ms_topind,"')"
                  CALL q_gzja001() 
           END CASE
           LET g_source_prog = g_qryparam.return2
           LET g_source_prog_name = g_qryparam.return3
           DISPLAY g_source_prog_name TO s_source_prog_name
           CALL DIALOG.setFieldTouched("s_source_prog", TRUE)
           #LET g_copy_source_data = g_source_prog," ",g_copy_source_name

         
        ON CHANGE s_main_or_sub_prog
           LET g_source_prog = ""
           LET g_source_prog_name = ""
           LET g_source_ver = ""
           LET g_source_spec_ver = ""
           LET g_source_code_ver = ""
           LET g_gen_topind = ""
           LET g_gen_prog = ""
           NEXT FIELD s_source_prog           
           DISPLAY g_main_or_sub_prog  TO s_main_or_sub_prog


        AFTER FIELD s_source_prog
           IF NOT cl_null(g_source_prog) THEN


              #取得來源程式的模組代號
              LET g_source_module = sadzp062_1_find_module(g_source_prog,g_main_or_sub_prog) 

              #取得來源程式的建構版次
              CALL sadzp060_2_get_curr_ver_info(g_source_prog, g_main_or_sub_prog, g_source_module) RETURNING lo_DZAF_T.*,ls_err_msg
              IF cl_null(ls_err_msg) THEN
                  LET g_source_ver      = lo_DZAF_T.dzaf002
                  LET g_source_spec_ver = lo_DZAF_T.dzaf003
                  LET g_source_code_ver = lo_DZAF_T.dzaf004
                  LET g_source_identity = lo_DZAF_T.dzaf010

                  #LET g_source_ver      =  g_source_ver.trim()
                  #LET g_source_spec_ver =  g_source_spec_ver.trim()
                  #LET g_source_code_ver =  g_source_code_ver.trim()

                  #DISPLAY g_source_ver,g_source_spec_ver,g_source_code_ver TO s_source_ver,s_spec_ver,s_code_ver
                  DISPLAY g_source_ver TO s_source_ver
              END IF

              #顯示程式名稱
              LET g_source_prog_name = adzp610_get_prog_name(g_source_prog)
              DISPLAY g_source_prog_name TO s_source_prog_name              
 

              #檢查複製來源是否有設計資料
              IF g_main_or_sub_prog MATCHES "[MSFQ]"  THEN
                 LET g_source_spec_ver_col = g_source_spec_ver
                 SELECT COUNT(*) INTO ln_cnt FROM dzfi_t WHERE dzfi001 = g_source_prog AND dzfi002 = g_source_spec_ver_col AND dzfi009 = g_source_identity

                 IF ln_cnt = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "adz-00144"
                    LET g_errparam.extend = g_source_prog
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD s_source_prog
                 END IF
              END IF
              IF g_main_or_sub_prog <> "F" THEN
                 LET g_source_code_ver_col = g_source_code_ver
                 SELECT COUNT(*) INTO ln_cnt FROM dzbc_t WHERE dzbc001 = g_source_prog AND dzbc002 = g_source_code_ver_col AND dzbc007 = g_source_identity

                 IF ln_cnt = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "adz-00144"
                    LET g_errparam.extend = g_source_prog
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD s_source_prog
                 END IF
              END IF
           END IF 

        AFTER FIELD s_gen_prog

           IF NOT cl_null(g_gen_prog) THEN

              #檢核命名規則
              CALL adzp610_check_gen_name(g_source_prog, g_gen_prog, g_gen_topind) RETURNING lb_result, ls_result

              IF NOT lb_result THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "adz-00907"    #複製目標程式編號命名有誤，ex:
                 LET g_errparam.extend = ""
                 LET g_errparam.popup = TRUE
                 LET g_errparam.replace[1] = ls_result
                 CALL cl_err()
                 LET g_gen_prog = ""
                 NEXT FIELD s_gen_prog
              END IF



              ###設定目標程式的行業別，供後續新增註冊檔使用
              ##LET ls_str = g_gen_prog CLIPPED
              ##CASE
              ##   WHEN g_main_or_sub_prog = "M"
              ##      LET g_gen_topind = ls_str.substring(ls_str.getindexof('_',1)+1,ls_str.getlength())
              ##   WHEN g_main_or_sub_prog = "S"
              ##      LET g_main_or_sub_prog = ls_str.substring(ls_str.getindexof('_',2)+1,ls_str.getlength())
              ##END CASE          

              ##如果複製目標沒有輸入包含'_'的名稱，提示複製目標不可為標準程式
              #LET ls_str = g_gen_prog
              #IF ls_str.getindexof('_',1) <=0 THEN
              #   LET g_gen_prog = ""
              #   INITIALIZE g_errparam TO NULL
              #   LET g_errparam.code = "adz-00095"    #複製來源為非強制引用程式代號，複製目標請輸入非強制引用程式代號，例如 biti001_%1。
              #   LET g_errparam.extend = ""
              #   LET g_errparam.popup = TRUE
              #   LET g_errparam.replace[1] = g_gen_topind
              #   CALL cl_err()
              #END IF
              ##如果來源為引用，目標必定為引用，且名稱須與來源相同(除行業代號外)
              ##如果來源為非引用，目標不可輸入a開頭的名稱
              #LET ls_sql = "select count(*) from gzzb_t where gzzb001 = '", g_source_prog ,"' and gzzb001<>gzzb003"
              #PREPARE gzzb_cs FROM ls_sql
              #EXECUTE gzzb_cs INTO ln_cnt      
              ##來源引用
              #IF ln_cnt > 0  THEN
              #   LET ls_str = g_source_prog
              #   LET ls_str1 = g_gen_prog
              #   LET ls_str = ls_str.substring(1, ls_str.getindexof('_',1)-1)
              #   LET ls_str1 = ls_str1.substring(1, ls_str1.getindexof('_',1)-1) 
              #   IF (ls_str<>ls_str1) THEN
              #      LET g_gen_prog = ""
              #      INITIALIZE g_errparam TO NULL
              #      LET g_errparam.code = "adz-00095"    #複製來源為非強制引用程式代號，複製目標請輸入非強制引用程式代號，例如 biti001_%1。
              #      LET g_errparam.extend = ""
              #      LET g_errparam.popup = TRUE
              #      LET g_errparam.replace[1] = g_gen_topind
              #      CALL cl_err()
              #   END IF
              #ELSE
              #   IF g_main_or_sub_prog = "M" THEN
              #      LET ls_str = g_gen_prog
              #      LET ls_str = ls_str.substring(1,1)
              #      IF ls_str = "a" THEN
              #         LET g_gen_prog = ""
              #         INITIALIZE g_errparam TO NULL
              #         LET g_errparam.code = "adz-00095"    #複製來源為非強制引用程式代號，複製目標請輸入非強制引用程式代號，例如 biti001_%1。
              #         LET g_errparam.extend = ""
              #         LET g_errparam.popup = TRUE
              #         LET g_errparam.replace[1] = g_gen_topind
              #         CALL cl_err()
              #      END IF
              #   END IF
              #END IF

           END IF

        ON ACTION btn_begin_copy

 
          TRY

             LET ls_trigger = "insert dzaf_t"
             DISPLAY "insert dzaf_t : BEGIN"
     
             #新增複製目標資料到dzaf_t
             LET ls_sql = "insert into dzaf_t (dzaf001, dzaf002, dzaf003, dzaf004,  dzaf005, dzaf006, dzaf010) ",
                          "values ('",g_gen_prog,"', 1, 1, 1, '",g_main_or_sub_prog,"', '", g_source_module, "' ,'",ms_dgenv,"')" 
             
             PREPARE dzaf_cs FROM ls_sql
             EXECUTE dzaf_cs
             FREE dzaf_cs

 

             #程式類型為M類的話，新增gzzb_t
             IF g_main_or_sub_prog = "M" THEN
                
                LET ls_trigger = "insert gzzb_t for type = M"
                DISPLAY "insert gzzb_t for type = M"

                LET ls_sql = "select COUNT(*) from gzzb_t where gzzb001='", g_source_prog ,"' and gzzb001<>gzzb003 "
                PREPARE gzzb_cs FROM ls_sql
                EXECUTE gzzb_cs INTO ln_cnt

                #ln_cnt>0表示引用，ln_cnt <0表示不引用
                IF ln_cnt > 0 THEN
                   LET ls_sql = "insert into gzzb_t (gzzb001, gzzb002, gzzb003) values ('", g_gen_prog ,"' , '", g_gen_topind ,"' , '", g_source_prog ,"')"
                ELSE
                   LET ls_sql = "insert into gzzb_t (gzzb001, gzzb002, gzzb003) values ('", g_gen_prog ,"' , 'sd' , '", g_gen_prog ,"')"
                END IF
                 
                PREPARE gzzb_i_cs FROM ls_sql
                EXECUTE gzzb_i_cs

             END IF

 
             #依照複製來源類型至各類型註冊表註冊基本資料
             IF adzp610_prog_register() THEN

                #複製設計資料到DB
                IF adzp610_copy_process() THEN

                   #匯出設計資料
                   CALL adzp610_export_design_data() RETURNING lb_result
                END IF
             END IF
             #刪除設計資料
             CALL adzp610_delete_design_data()


          CATCH
             IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ls_trigger, " " , cl_getmsg(SQLCA.SQLCODE,g_lang)
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
          END TRY


        ON ACTION btn_cancel     #離開
            EXIT DIALOG

        ON ACTION close          #在dialog 右上角 (X)
            EXIT DIALOG

        ON ACTION exit           #toolbar 離開
            EXIT DIALOG
        
 

      END INPUT        

   END DIALOG


END FUNCTION


PRIVATE FUNCTION adzp610_prog_register()

   #(M)主程式：gzza_t
   #(S)子程式：gzde_t
   #(F)子畫面：gzdf_t
   #(B)應用元件：gzde_t
   #(Q)開窗 (Hard Code)：dzca_t
   #(Z)服務：gzja_t

DEFINE ls_sql      STRING,
       ls_str      STRING,                 #字串處理
       ls_gzdf001  LIKE gzdf_t.gzdf001,     
       ls_trigger  STRING

   LET ls_str = g_gen_prog CLIPPED

   TRY

   LET ls_trigger = "insert register data"
   DISPLAY ls_trigger 

   CASE 
      WHEN g_main_or_sub_prog = "M"
         LET ls_sql = "insert into gzza_t (gzzastus, gzza001, gzza003, gzza015 ) values ('Y', '",g_gen_prog,"','", g_source_module ,"', '", g_gen_topind ,"')"
      WHEN g_main_or_sub_prog MATCHES "[BS]"
         LET ls_sql = "insert into gzde_t (gzdestus, gzde001, gzde002, gzde003, gzde005, gzde006, gzde007, gzde008, gzde009 ) ",
                      "select gzdestus, '", g_gen_prog ,"' gzde001, '", g_source_module ,"' gzde002, gzde003, gzde005, gzde006, gzde007, gzde008, '", g_gen_topind ,"' gzde009 from gzde_t ",
                      "where gzde001 = '", g_source_prog ,"'"
      WHEN g_main_or_sub_prog = "F"
         #除複製子畫面註冊資料(gzdf_t)外，也要複製子程式的註冊資料(gzde_t)
         LET ls_sql = "select gzdf001 from gzdf_t where gzdf002 = '", g_source_prog ,"'"
         PREPARE gzdf_cs FROM ls_sql
         EXECUTE gzdf_cs INTO ls_gzdf001 #ls_gzdf001在此是子程式代號
         
         LET ls_sql = "insert into gzdf_t (gzdf001, gzdf002, gzdf003) ",
                      "select '", ls_gzdf001 ,"' gzdf001, '", g_gen_prog ,"' gzdf002, gzdf003 from gzdf_t where gzdf002='", g_source_prog ,"'"
      WHEN g_main_or_sub_prog = "Q"
         LET ls_sql = "insert into dzca_t (dzca001, dzca002, dzca003, dzca006, dzca007 )                         ",
                      "select '",g_gen_prog,"' dzca001, '",g_source_identity,"' dzca002, dzca003, dzca006, '", g_gen_topind ,"' dzca007  ",
                      "from dzca_t where dzca001 = '", g_source_prog ,"'"
      WHEN g_main_or_sub_prog = "Z"
         LET ls_sql = "insert into gzja_t (gzjastus, gzja001, gzja002, gzja003, gzja004, gzja005, gzja006, gzja007, gzja008 )                             ",
                      "select 'Y' gzjastus, '",g_gen_prog,"' gzja001, gzja002, gzja003, gzja004, gzja005, '", g_gen_topind ,"' gzja006, gzja007, gzja008  ",
                      "from gzja_t where gzja001 = '", g_source_prog ,"'"
   END CASE
   DISPLAY "ls_sql=",ls_sql

   PREPARE register_cs FROM ls_sql
   EXECUTE register_cs
   FREE register_cs

   RETURN TRUE
   
   CATCH
      IF SQLCA.SQLCODE <0 THEN
         DISPLAY 'ERROR:insert register data fail.'
         RETURN FALSE
      END IF
   END TRY

END FUNCTION



PRIVATE FUNCTION adzp610_copy_process()

   DEFINE subPara type_para,
          sub_dzag DYNAMIC ARRAY OF dzag_type,
          sub_dzeb_stored DYNAMIC ARRAY OF type_col_relation

   DEFINE lb_result   BOOLEAN,
          ls_cmd      STRING


   #設定要傳遞給sadzp270的參數
   LET subPara.ms_dgenv = ms_dgenv
   LET subPara.ms_erpid = ms_erpid
   LET subPara.ms_erpver = ms_erpver
   LET subPara.ms_cust = ms_cust

   LET subPara.g_gen_prog = g_gen_prog
   LET subPara.g_copy_source = g_source_prog
   LET subPara.g_source_ver = g_source_ver
   LET subPara.g_source_spec_ver = g_source_spec_ver
   LET subPara.g_source_code_ver = g_source_code_ver
   LET subPara.g_source_identity = g_source_identity
   LET subPara.g_use_table_replace = "N"
   LET subPara.g_not_copy_appoint = "N"
   LET subPara.g_source_type = g_main_or_sub_prog

   CALL sadzp270_copy_database_data_ALL(subPara.*, sub_dzag, sub_dzeb_stored, g_prog) RETURNING lb_result

   IF lb_result THEN

      #產生4fd
      LET g_source_4fd_path = os.path.join(os.path.join(FGL_GETENV(g_source_module), "4fd"), g_source_prog || ".4fd")
      #產生的4fd檔的檔案路徑
      LET g_gen_4fd_path  = os.path.join(os.path.join(FGL_GETENV(g_source_module), "4fd"), g_gen_prog || ".4fd")


      #只有SMFQ類有4fd 
      IF g_main_or_sub_prog MATCHES "[SMFQ]" THEN
         IF adzp610_gen_4fd() THEN
            LET lb_result = true
         END IF
      END IF

      #只有SMZBQ類有tab、tgl、4gl
      IF g_main_or_sub_prog MATCHES "[SMZBQ]" THEN
         #產生tab
         IF sadzp030_tab_gen(g_gen_prog,g_source_spec_ver,"",g_source_identity) THEN
            LET lb_result = true
         END IF

         #產生tgl,4gl
         CALL os.Path.chdir(os.path.join(FGL_GETENV("g_source_module"),"4gl")) RETURNING lb_result

         ###### 產生tgl檔和4gl檔(執行r.c3)
         #不自動r.c及r.l 因為預期可能仍會有錯,參數四給1
         LET ls_cmd = "r.c3 ", g_gen_prog ," '' 1 1 s" #程式版次固定為1
         DISPLAY 'RUN:',ls_cmd
         IF adzp610_run_cmd(ls_cmd) THEN
            LET lb_result = true
         END IF
      END IF
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

#+ 產生4fd檔
PRIVATE FUNCTION adzp610_gen_4fd()
   DEFINE ls_sql      STRING,
          lt_4fd_str  TEXT,
          lb_buf      base.StringBuffer,
          lb_flag     LIKE type_t.num5,
          l_i         LIKE type_t.num5,
          l_old_str   STRING,
          l_new_str   STRING,
          l_4fd_doc   om.DomDocument,
          l_4fd_root  om.DomNode

   LOCATE lt_4fd_str IN FILE

   #檢查來源檔的存在和檔案權限
   IF os.Path.exists(g_source_4fd_path) AND adzp610_chk_file_permisson(g_source_4fd_path) THEN

      LET lt_4fd_str = adzp610_read_file(g_source_4fd_path,lt_4fd_str)
      LET lb_buf = base.StringBuffer.create()

      LET l_4fd_doc = om.DomDocument.createFromString(lt_4fd_str)
      LET l_4fd_root = l_4fd_doc.getDocumentElement()

      CALL lb_buf.append(lt_4fd_str)

      LET lt_4fd_str = lb_buf.toString()

      CALL adzp610_write_file(g_gen_4fd_path,lt_4fd_str)

      #檢查檔案是否產生成功
      IF os.Path.exists(g_gen_4fd_path) THEN
   　　   LET lb_flag = TRUE
      ELSE
         LET lb_flag = FALSE
      END IF

   ELSE
      LET lb_flag = FALSE
   END IF

   FREE lt_4fd_str

   RETURN lb_flag
END FUNCTION

#+檢查檔案權限是否能讀取
PRIVATE FUNCTION adzp610_chk_file_permisson(p_file)
   DEFINE p_file      STRING         #檔案路徑
   DEFINE l_ch_in     base.Channel   #Genero讀取的檔案物件變數

   LET l_ch_in = base.Channel.create()

   TRY
      #指定來源的的檔案路徑
      CALL l_ch_in.openFile(p_file,"r")
   CATCH
      IF STATUS THEN
         #對此檔案的權限不足
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00156"
         LET g_errparam.extend = "ERROR:permission"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_file
         CALL cl_err()
         RETURN FALSE
      END IF
   END TRY

   CALL l_ch_in.close()

   RETURN TRUE
END FUNCTION


#+ 取出檔案內的字串(使用TEXT的內建FUNCTION讀檔)
FUNCTION adzp610_read_file(p_file_path,pt_str)
   DEFINE p_file_path   STRING,
          pt_str        TEXT

   #讀取檔案內容
   CALL pt_str.readFile(p_file_path)
   #DISPLAY "pt_str = ",pt_str

   RETURN pt_str
END FUNCTION


#+ 寫入出檔案內的字串(使用TEXT的內建FUNCTION寫檔)
FUNCTION adzp610_write_file(p_file_path,pt_str)
   DEFINE p_file_path      STRING,
          pt_str           TEXT,
          lb_chrwx_return  LIKE type_t.num5,
          lb_del           LIKE type_t.num5

   #檔案如果已經存在則先刪除
   IF os.Path.exists(p_file_path) THEN
      CALL os.Path.delete(p_file_path) RETURNING lb_del
   END IF

   #DISPLAY "pt_str = ",

   CALL pt_str.writeFile(p_file_path)

   IF os.Path.exists(p_file_path) THEN
      DISPLAY "檔案存在:",p_file_path
   END IF

   CALL os.Path.chrwx(p_file_path, 511) RETURNING lb_chrwx_return
END FUNCTION





#+ 進行 command line 的程式執行
PRIVATE FUNCTION adzp610_run_cmd(p_cmd)
   DEFINE p_cmd          STRING
   DEFINE l_msg          STRING
   DEFINE l_chk          LIKE type_t.num5

   #DISPLAY "l_cmd = ",l_cmd
   CALL cl_cmdrun_openpipe(p_cmd,p_cmd,FALSE) RETURNING l_chk,l_msg

   RETURN  l_chk
END FUNCTION

#+ 匯出設計資料
PRIVATE FUNCTION adzp610_export_design_data()
   DEFINE ls_cmd STRING,
          l_ch   base.Channel,
          l_chk  BOOLEAN,
          l_msg  STRING,
          l_buf  STRING,
          li_pos LIKE TYPE_t.num5,
          l_str STRING
      
   LET l_chk = TRUE

   LET ls_cmd = "r.r adzp990 exp ",g_gen_prog
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   LET ls_cmd = ls_cmd CLIPPED," 2>&1"
   CALL l_ch.openPipe(ls_cmd,"r")   #執行指令

   IF STATUS THEN
      LET l_chk = FALSE
   ELSE
      WHILE TRUE
         CALL l_ch.readLine() RETURNING l_buf
         IF l_ch.isEof() THEN
            EXIT WHILE
         END IF

         DISPLAY l_buf   #顯示背景訊息


         #有錯誤訊息
         LET l_str = l_buf.toUpperCase()
         IF l_str.getIndexOf("ERROR" ,1) OR l_str.getIndexOf("CP: CANNOT" ,1) THEN
            LET l_chk = FALSE
            LET l_msg = l_msg CLIPPED," ",ASCII 10,l_buf CLIPPED
         END IF
      END WHILE
   END IF
   CALL l_ch.close() 
   
   RETURN l_chk 
END FUNCTION

#+ 刪除設計資料
PRIVATE FUNCTION adzp610_delete_design_data()
   DEFINE lo_DZAF_T   T_DZAF_T,
          lb_result   BOOLEAN,
          ls_err_msg  STRING,
          ls_trigger  STRING

   TRY
      
      LET ls_trigger = "delete register data"
      DISPLAY ls_trigger
 
      #依程式類型刪除註冊資料
      CASE
         WHEN g_main_or_sub_prog = "M"
             #刪除註冊資料
             delete from gzza_t where gzza001 = g_gen_prog
             #刪除gzzb_t
             delete from gzzb_t where gzzb001 = g_gen_prog
         WHEN g_main_or_sub_prog MATCHES "[SB]"
             delete from gzde_t where gzde001 = g_gen_prog
         WHEN g_main_or_sub_prog = "F"
             delete from gzdf_t where gzdf002 = g_gen_prog
         WHEN g_main_or_sub_prog = "Q"
             delete from dzca_t where dzca001 = g_gen_prog
         WHEN g_main_or_sub_prog = "Z"
             delete from gzja_t where gzja001 = g_gen_prog
      END CASE

      LET ls_trigger = "delete design data"
      DISPLAY ls_trigger

      CALL sadzp060_2_get_curr_ver_info(g_gen_prog, g_main_or_sub_prog , g_source_module) RETURNING lo_DZAF_T.*,ls_err_msg
      CALL sadzp063_1_del_design_data(lo_DZAF_T.*, '3') RETURNING lb_result,ls_err_msg

   CATCH
      DISPLAY "delete design data exception:", ls_trigger
   END TRY


END FUNCTION




##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 檢查複製目標命名
# Input parameter : p_source_porg  複製來源程式代號
#                 : p_gen_prog     複製目標程式代號
#                 : p_gen_topind   複製目標行業編號
# Return code     : lb_result      TRUE/FALSE
#                 : ls_result      建議的複製目標程式編號
# Date & Author   : 20161011 by Elena
##########################################################################
PRIVATE FUNCTION adzp610_check_gen_name(p_source_prog, p_gen_prog, p_gen_topind)
   DEFINE p_source_prog  STRING,
          p_gen_prog     STRING,
          p_gen_topind   STRING 

   DEFINE li_total  INTEGER,
          li_count  INTEGER,
          li_cnt    INTEGER,
          li_length INTEGER,
          ls_char   STRING,
          li_begin  INTEGER,
          li_end    INTEGER,
          li_source_pos INTEGER,
          li_gen_pos    INTEGER,
          ls_str        STRING,
          lb_result     BOOLEAN,
          ls_result     STRING

   #取得分成幾段
   CALL cl_str_sepcnt(p_source_prog, "_") RETURNING li_total

   
   LET li_length = p_source_prog.getLength()
   LET li_count = 1
   LET li_begin = 1  #紀錄第一段的第一個位置

   #一個一個字元與"_"比對
   FOR li_cnt = 1 TO li_length
      LET ls_char = p_source_prog.substring(li_cnt,li_cnt)
      IF ls_char == "_" THEN
         LET li_end = li_cnt - 1
         LET ls_str = p_source_prog.substring(li_begin, li_end)
         IF ls_str = ms_topind THEN
            #LET li_source_pos = li_count
            CALL cl_str_replace_by_index(p_source_prog, li_begin, li_end, p_gen_topind) RETURNING ls_result
            EXIT FOR
         ELSE
            LET li_begin = li_cnt + 1
         END IF
         LET li_count = li_count + 1 
      END IF
   END FOR

   IF cl_null(ls_result) THEN
      LET ls_str = p_source_prog.substring(li_begin, li_length)
      IF ls_str = ms_topind THEN
         #LET li_source_pos = li_count
         CALL cl_str_replace_by_index(p_source_prog, li_begin, li_length, p_gen_topind) RETURNING ls_result
      END IF
   END IF

   IF ls_result = p_gen_prog THEN
      LET lb_result = TRUE
   ELSE
      LET lb_result = FALSE
   END IF


   #LET li_length = p_gen_prog.getLength()
   #LET li_count = 1
   #LET li_begin = 1
   #FOR li_cnt = 1 TO li_length
   #   LET ls_char = p_gen_prog.substring(li_cnt,li_cnt)
   #   IF ls_char == "_" THEN
   #      LET li_end = li_cnt - 1
   #      LET ls_str = p_gen_prog.substring(li_begin, li_end)
   #      IF ls_str = p_gen_topind THEN
   #         LET li_gen_pos = li_count
   #         EXIT FOR
   #      ELSE
   #         LET li_begin = li_cnt + 1
   #      END IF
   #      LET li_count = li_count + 1
   #   END IF
   #END FOR 

   #IF li_gen_pos = 0 THEN
   #   LET ls_str = p_gen_prog.substring(li_begin, li_length)
   #   IF ls_str = p_gen_topind THEN
   #      LET li_gen_pos = li_count
   #   END IF
   #END IF


   #IF (li_source_pos = li_gen_pos) AND li_source_pos > 0 THEN
   #   LET lb_result = TRUE
   #ELSE
   #   LET lb_result = FALSE
   #END IF

   RETURN lb_result, ls_result
END FUNCTION


#取得程式名稱
PRIVATE FUNCTION adzp610_get_prog_name(p_prog)

 DEFINE p_prog      LIKE dzaa_t.dzaa001,
        p_prog_name LIKE gzzal_t.gzzal003,
        ls_sql      STRING

    CASE
       WHEN g_main_or_sub_prog ="M"
          LET ls_sql =
              "SELECT gzzal003 FROM gzzal_t
                  WHERE gzzal001='",p_prog,
                 "' AND gzzal002='",g_lang,"'"
       WHEN g_main_or_sub_prog MATCHES "[SBGXW]"
          LET ls_sql =
              "SELECT gzdel003 FROM gzde_t
                 LEFT JOIN gzdel_t ON gzde001 = gzdel001
                WHERE gzde001='",p_prog,
               "' AND gzdestus='Y'
                  AND gzde003='",g_main_or_sub_prog,
               "' AND gzdel002='",g_lang,"'"
       WHEN g_main_or_sub_prog ="F"
          LET ls_sql =
               "SELECT gzdfl003 FROM gzdf_t
                  LEFT JOIN gzdfl_t ON gzdf002 = gzdfl001
                 WHERE gzdf002='",p_prog,
                "' AND gzdfl002='",g_lang,"'"
       WHEN g_main_or_sub_prog ="Z" #Web Service
          LET ls_sql =
              "SELECT gzjal003 FROM gzjal_t
                  WHERE gzjal001='",p_prog,
                 "' AND gzjal002='",g_lang,"'"

       WHEN g_main_or_sub_prog ="Q" #20150701 hard code qry
          LET ls_sql =
              "SELECT dzcal003 FROM dzcal_t
                  WHERE dzcal001='",p_prog,
                 "' AND dzcal002='",g_lang,"'"

    END CASE
    PREPARE prog_prep0 FROM ls_sql
    EXECUTE prog_prep0 INTO p_prog_name
    FREE prog_prep0
    RETURN p_prog_name
END FUNCTION
