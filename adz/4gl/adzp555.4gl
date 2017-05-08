IMPORT os
SCHEMA ds
GLOBALS "../../cfg/top_global.inc"

DEFINE CheckBox_cldb,DBbackup  LIKE type_t.chr1
DEFINE Edit_dump_path,buttonedit_db,Edit_sdb_passwd,Edit_tdb_host,Edit_tdb_conn,Edit_tdb_passwd,Edit_sdb_conn,Edit_sdb_host STRING
DEFINE checkbox_clap,apbackup LIKE type_t.chr1
DEFINE edit_sap_top,edit_tap_top,edit_tap_host,edit_sap_host,sourcenode,targetnode STRING
DEFINE g_adzp555_1    VARCHAR(50)
DEFINE apbakdf  STRING 
DEFINE sdbexpdf STRING 
DEFINE tdbexpdf STRING 
DEFINE g_pid STRING 
DEFINE g_cnt         LIKE type_t.num5
DEFINE g_time STRING 
DEFINE g_date STRING 

MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING,
          ls_4ad_path STRING
   WHENEVER ERROR CONTINUE
   CALL cl_tool_init()
   OPTIONS FIELD ORDER FORM, INPUT WRAP
   OPEN WINDOW w_adzp555 WITH FORM cl_ap_formpath("adz", g_code)
   CLOSE WINDOW screen
   CALL cl_ui_wintitle(1)
   CALL cl_load_4ad_interface(NULL)
   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)
   CALL adzp555_init()
   CALL adzp555_ui_dialog()
   CLOSE WINDOW w_adzp555
END MAIN
PRIVATE FUNCTION adzp555_init()
   LET g_cnt = 4 
   CALL cl_ui_init()
   LET CheckBox_cldb = '0' 
   LET DBbackup = '0'
   LET Edit_dump_path = FGL_GETENV("TOP_BACK"),'/clone' 
   LET Edit_sdb_host = FGL_GETENV("HOSTNAME")
   LET Edit_tdb_host = FGL_GETENV("HOSTNAME") 
   # get O/S variables
   LET checkbox_clap = '0'
   LET apbackup = '0'
   LET edit_sap_host = FGL_GETENV("HOSTNAME") 
   LET edit_tap_host = FGL_GETENV("HOSTNAME") 
   LET g_action_choice = "clone"
   LET g_pid = FGL_GETPID()
   LET g_time = cl_replace_str(time , ":", "")
   LET g_date = cl_replace_str(TODAY , "/", "")
   LET apbakdf = 0
   LET sdbexpdf = 0
   LET tdbexpdf = 0
END FUNCTION

PRIVATE FUNCTION adzp555_ui_dialog()
   DEFINE  l_prog_name     LIKE type_t.chr100

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME CheckBox_cldb,DBbackup,buttonedit_db,Edit_dump_path,
                    Edit_sdb_passwd,
                    Edit_tdb_passwd,
                    checkbox_clap,apbackup,sourcenode,targetnode
      ATTRIBUTES (WITHOUT DEFAULTS )
         BEFORE INPUT
          DISPLAY by name CheckBox_cldb,DBbackup,Edit_dump_path,
                          Edit_sdb_conn,Edit_sdb_host,Edit_sdb_passwd,
                          Edit_tdb_conn,Edit_tdb_host,Edit_tdb_passwd,
                          checkbox_clap,apbackup,
                          edit_sap_host,edit_sap_top,
                          edit_tap_host,edit_tap_top,sourcenode,targetnode

         ON CHANGE CheckBox_cldb 
            IF CheckBox_cldb == '1' THEN  #資料庫同步，預設目的端備份exp
               LET CheckBox_cldb = '1'
               LET DBbackup = '1'
            DISPLAY by name CheckBox_cldb,DBbackup
            END IF
            IF CheckBox_cldb == '0' THEN  #資料庫同步-同步取消
               LET CheckBox_cldb = '0'
               LET DBbackup = '0'
               DISPLAY by name CheckBox_cldb,DBbackup
            END IF

         ON CHANGE checkbox_clap
            IF checkbox_clap == '1' THEN   #程式同步，預設目的端tar備份
               LET checkbox_clap = '1' 
               LET apbackup = '1'
               DISPLAY by name checkbox_clap,apbackup
            END IF
            IF checkbox_clap == '0' THEN   #程式同步-同步取消
               LET checkbox_clap = '0'
               LET apbackup = '0'
               DISPLAY by name checkbox_clap,apbackup
            END IF

         ON CHANGE DBbackup 
            IF CheckBox_cldb == '0' THEN  #資料庫同步-同步取消
               LET CheckBox_cldb = '0'
               LET DBbackup = '0'
            DISPLAY by name CheckBox_cldb,DBbackup
            END IF
            IF targetnode == 'topprd' AND CheckBox_cldb == '1' THEN
               LET CheckBox_cldb = '1'
               LET DBbackup = '1'
            END IF
         ON CHANGE apbackup 
            IF checkbox_clap == '0' THEN   #程式同步-同步取消
               LET checkbox_clap = '0'
               LET apbackup = '0'
               DISPLAY by name checkbox_clap,apbackup
            END IF
            IF targetnode == 'topprd' AND checkbox_clap == '1' THEN
               LET checkbox_clap = '1'
               LET apbackup = '1'
               DISPLAY by name checkbox_clap,apbackup
            END IF
         #設置來源區域
         ON CHANGE sourcenode 
            LET edit_sap_top = '/u1/',sourcenode
            LET edit_sdb_conn = sourcenode
            DISPLAY by name edit_sap_top,edit_sdb_conn 
         #設置目標區域
         ON CHANGE targetnode 
            LET edit_tap_top = '/u1/',targetnode
            LET edit_tdb_conn = targetnode
            DISPLAY by name edit_tap_top,edit_tdb_conn 

         #頁簽切換還原初始值 START
         ON ACTION clone 
             LET g_action_choice = "clone"
         ON ACTION backup_reduced 
             LET g_action_choice = "backup_reduced"
         #頁簽切換還原初始值 END

         #選擇要同步的DB
         ON ACTION controlp INFIELD buttonedit_db 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE 
            CALL q_adzp555_1()
            LET buttonedit_db = g_qryparam.return1
            DISPLAY BY NAME buttonedit_db

         ON ACTION batch_execute  #執行
            IF g_action_choice = "clone"  THEN
               CALL adzp555_clone()
            END IF
            ACCEPT DIALOG

         ON ACTION CLOSE  #離開
            LET INT_FLAG = TRUE 
            EXIT DIALOG
         ON ACTION EXIT   #離開
            LET INT_FLAG = TRUE 
            EXIT DIALOG
         END INPUT
      END DIALOG 

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE 
      END IF
   END WHILE 
END FUNCTION

PRIVATE FUNCTION adzp555_clone()
   DEFINE p_user,p_psw STRING
   DEFINE l_source STRING
   LET p_psw = edit_tdb_passwd
   LET l_source = targetnode
   IF  adzp555_validation() THEN
      IF  adzp555_dfck() THEN
         IF targetnode == 'topprd' AND g_cnt != 1 THEN
            LET g_cnt = g_cnt - 1 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = "adz-00911"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         ELSE
            CALL adzp555_clone_createshell()
            IF checkbox_cldb == 1 THEN
               CALL adzp555_checkin(l_source,'system',p_psw)
            END IF 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = "adz-00910"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT PROGRAM
         END IF 
      END IF

   END IF
END FUNCTION
#刪除DB
PRIVATE FUNCTION adzp555_dropdb(l_source,p_user,p_psw)
   DEFINE p_user,p_psw STRING
   DEFINE l_source STRING
   DEFINE ls_cmd        STRING
   DEFINE ls_sql        STRING
   DEFINE ls_sql2       STRING
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   #cmdrun使用的陣列 
   DEFINE l_len         VARCHAR(128)                 #cmdrun使用   
   DEFINE l_len2        VARCHAR(128)                 #cmdrun使用   
   LET p_user = p_user.trim()
   LET p_psw = p_psw.trim()
   LET l_source = l_source.trim()

   CONNECT TO l_source USER p_user USING p_psw

   LET l_token =base.StringTokenizer.create(buttonedit_db,"|")
   CALL l_arg.clear()
   LET l_cnt = 1
   LET ls_sql = "select DISTINCT OWNER from dba_tables where ",
                "OWNER = 'DS' OR OWNER ='DSDEMO' OR OWNER ='DSDATA' OR ",
                "OWNER ='DSAWS' OR OWNER ='DSAWST' OR OWNER LIKE 'DS%'"
   WHILE l_token.hasMoreTokens()
      LET ls_next = l_token.nextToken()
      LET ls_sql = ls_sql ," OR OWNER ='", ls_next,"'"
      LET l_cnt = l_cnt + 1
   END WHILE
   CALL l_arg.deleteElement(l_cnt)

   PREPARE drp_pre from ls_sql
   DECLARE drp_db CURSOR FOR drp_pre
   FOREACH drp_db INTO  l_len
      LET ls_cmd = "select table_name from dba_tables where owner='",l_len,"'"
      PREPARE drp_tabe from ls_cmd
      DECLARE drp_tab CURSOR FOR drp_tabe
      FOREACH drp_tab INTO  l_len2
         LET ls_sql2 = "DROP TABLE ",l_len,".",l_len2," CASCADE CONSTRAINTS" 
         EXECUTE IMMEDIATE ls_sql2 
         #DISPLAY  "DROP TABLE ",l_len,".",l_len2," CASCADE CONSTRAINTS"
      END FOREACH
   END FOREACH
   DISCONNECT CURRENT
   DATABASE g_dbs
END FUNCTION


PRIVATE FUNCTION adzp555_clone_createshell()
   DEFINE ls_cmd        STRING
   DEFINE ls_sql        STRING
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   #cmdrun使用的陣列 
   DEFINE l_len         VARCHAR(128)                 #cmdrun使用   

   LET ls_cmd = "mkdir /u3/clone/",g_date,g_time,"_",sourcenode,"_to_",targetnode,"_",g_pid 
   RUN ls_cmd
   #Backup
   CALL adzp555_backup_reduced(targetnode,"system",edit_tdb_passwd)
   #目的端清除
   CALL adzp555_dropdb(targetnode,"system",edit_tdb_passwd)

   #預設建置
   LET ls_cmd = "echo 'cd /u3/clone/",g_date,g_time,"_",sourcenode,"_to_",targetnode,"_",g_pid,"' > ",FGL_GETENV('TEMPDIR'),"/clone.sh"
   RUN ls_cmd

   #程式同步
   IF checkbox_clap = '1' THEN
      LET ls_cmd = "echo 'rm -rf ",edit_tap_top,"/* ; cp -rf ",edit_sap_top,"/* ",edit_tap_top,"/. ' >> ",FGL_GETENV('TEMPDIR'),"/clone.sh"
      RUN ls_cmd
      LET ls_cmd = "echo 'rm -rf /T100_gr/",targetnode," ; cp -rf /T100_gr/",sourcenode," /T100_gr/",targetnode," ' >> ",FGL_GETENV('TEMPDIR'),"/clone.sh"
      RUN ls_cmd
      LET ls_cmd = "echo 'mv  /u1/",targetnode,"/www/entlist/",sourcenode,"_website.txt /u1/",targetnode,"/www/entlist/",targetnode,"_website.txt' >> ",FGL_GETENV('TEMPDIR'),"/clone.sh"
      RUN ls_cmd
   END IF
   #DB同步
   IF checkbox_cldb = '1' THEN
      LET l_token =base.StringTokenizer.create(buttonedit_db,"|")
      CALL l_arg.clear()
      LET l_cnt = 1
      LET ls_sql = "select DISTINCT OWNER from dba_tables where ",
                   "OWNER = 'DS' OR OWNER ='DSDEMO' OR OWNER ='DSDATA' OR ",
                   "OWNER ='DSAWS' OR OWNER ='DSAWST' OR OWNER LIKE 'DS%'"
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         LET ls_next = l_token.nextToken()
         LET ls_sql = ls_sql ," OR OWNER ='", ls_next,"'"
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      #DB EXPORT
      PREPARE csh_pre from ls_sql
      DECLARE csh_sdb CURSOR FOR csh_pre
      FOREACH csh_sdb INTO  l_len
         LET ls_cmd = "echo 'exp system/",edit_sdb_passwd,"@",edit_sdb_conn," owner=",l_len," file=",l_len,".dmp log=exp_",l_len,".log' >> ",FGL_GETENV('TEMPDIR'),"/clone.sh"
         RUN ls_cmd
      END FOREACH

      #DB IMP
      PREPARE ish_pre from ls_sql
      DECLARE ish_tdb CURSOR FOR ish_pre
      FOREACH ish_tdb INTO  l_len
         LET ls_cmd = "echo 'imp system/",edit_tdb_passwd,"@",edit_tdb_conn," fromuser=",l_len," touser=",l_len," file=",l_len,".dmp log=imp_",l_len,".log' >> ",FGL_GETENV('TEMPDIR'),"/clone.sh"
         RUN ls_cmd
      END FOREACH
   END IF
   LET ls_cmd = "echo 'mv ",FGL_GETENV('TEMPDIR'),"/clone.sh /u3/clone/",g_date,g_time,"_",sourcenode,"_to_",targetnode,"_",g_pid,"/clone.sh' >> ",FGL_GETENV('TEMPDIR'),"/clone.sh"
   RUN ls_cmd
   LET ls_cmd = "sh ",FGL_GETENV('TEMPDIR'),"/clone.sh"
   RUN ls_cmd 
END FUNCTION
PRIVATE FUNCTION adzp555_backup_reduced(l_source,p_user,p_psw)
   DEFINE p_user,p_psw STRING
   DEFINE l_source STRING
   DEFINE ls_sql        STRING 
   DEFINE ls_cmd        STRING 
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   #cmdrun使用的陣列 
   DEFINE l_len         VARCHAR(128)                 #cmdrun使用   
   #預設建置
   
   LET ls_cmd = "echo 'cd /u3/clone/",g_date,g_time,"_",sourcenode,"_to_",targetnode,"_",g_pid,"' > ",FGL_GETENV('TEMPDIR'),"/clonebak.sh"
   RUN ls_cmd

   IF apbackup = '1'THEN
      LET ls_cmd = "echo 'tar -zcvf T100_",targetnode,"_bak.tgz ",edit_tap_top,"' >> ",FGL_GETENV('TEMPDIR'),"/clonebak.sh"
      RUN ls_cmd
      LET ls_cmd = "echo 'tar -zcvf gr_",targetnode,"_bak.tgz /T100_gr/",targetnode,"' >>",FGL_GETENV('TEMPDIR'),"/clonebak.sh"
      RUN ls_cmd
   END IF
   IF dbbackup = '1'THEN
      LET l_token =base.StringTokenizer.create(buttonedit_db,"|")
      CALL l_arg.clear()
      LET l_cnt = 1
      LET ls_sql = "select DISTINCT OWNER  from dba_tables where ",
                   "OWNER = 'DS' OR OWNER ='DSDEMO' OR OWNER ='DSDATA' OR ",
                   "OWNER ='DSAWS' OR OWNER ='DSAWST' OR OWNER LIKE 'DS%'"
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         LET ls_sql = ls_sql ," OR OWNER ='", ls_next,"'"
         LET l_cnt = l_cnt + 1
      END WHILE
      CONNECT TO l_source USER p_user USING p_psw
      CALL l_arg.deleteElement(l_cnt)
      PREPARE cur_pre from ls_sql
      DECLARE cur_sdb CURSOR FOR cur_pre
      FOREACH cur_sdb INTO  l_len
         LET ls_cmd = "echo 'exp system/",edit_sdb_passwd,"@",edit_sdb_conn," owner=",l_len," file=bak_",l_len,".dmp log=bak_exp_",l_len,".log' >> clonebak.sh"
         RUN ls_cmd
      END FOREACH
      DISCONNECT CURRENT
      DATABASE g_dbs
   END IF

   LET ls_cmd = "echo 'mv ",FGL_GETENV('TEMPDIR'),"/clonebak.sh /u3/clone/",g_date,g_time,"_",sourcenode,"_to_",targetnode,"_",g_pid,"/clonebak.sh' >>",FGL_GETENV('TEMPDIR'),"/clonebak.sh"
   RUN ls_cmd
   LET ls_cmd = "sh ",FGL_GETENV('TEMPDIR'),"/clonebak.sh" 
   RUN ls_cmd
END FUNCTION

PRIVATE FUNCTION adzp555_validation()
   IF checkbox_cldb == 1 THEN
      #確認system密碼是否輸入
      IF adzp555_db_psw_check("system",Edit_sdb_conn,edit_sdb_passwd CLIPPED) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "adz-00905"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
      IF adzp555_db_psw_check("system",Edit_tdb_conn,edit_tdb_passwd CLIPPED) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "adz-00906"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF


   IF sourcenode != FGL_GETENV("ZONE")  THEN #登入區域需與來源區相同 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00901"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   IF checkbox_clap == 0 AND checkbox_cldb == 0  THEN  #請選取要執行的動作 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00909"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   IF cl_null(sourcenode) THEN  #來源路徑為空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00902"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   IF cl_null(targetnode) THEN  #目的路徑為空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00903"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   IF sourcenode == targetnode  THEN  #禁止同區
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00904"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF


   RETURN TRUE 
END FUNCTION

PRIVATE FUNCTION adzp555_dsdatack()
   DEFINE p_psw STRING
   DEFINE l_source STRING
   DEFINE ls_cmd        STRING
   DEFINE ls_sql        STRING
   DEFINE ls_sql2        STRING
   DEFINE l_len         VARCHAR(128)                 #cmdrun使用   
   DEFINE l_len2         VARCHAR(128)                 #cmdrun使用   
   LET p_psw = edit_sdb_passwd 
   LET l_source = sourcenode 
   CONNECT TO l_source USER "system" USING p_psw
   LET ls_sql ="SELECT  round((A.total_size - B.total_free_size), 2) FROM (SELECT tablespace_name,sum(bytes)/1024/1024 AS total_size FROM dba_data_files GROUP BY tablespace_name) A, (SELECT tablespace_name,sum(bytes/1024/1024) AS total_free_size FROM dba_free_space WHERE tablespace_name = 'DSDATA' GROUP BY tablespace_name) B WHERE A.tablespace_name = B.tablespace_name"
   PREPARE dsdatack_spre from ls_sql
   DECLARE dsdatack_sdb CURSOR FOR dsdatack_spre
   FOREACH dsdatack_sdb INTO  l_len
      LET sdbexpdf = l_len
   END FOREACH
   LET ls_sql = "SELECT  A.total_size FROM (SELECT tablespace_name,sum(bytes)/1024/1024 AS total_size FROM dba_data_files GROUP BY tablespace_name) A, (SELECT tablespace_name,sum(bytes/1024/1024) AS total_free_size FROM dba_free_space WHERE tablespace_name = 'DSDATA' GROUP BY tablespace_name) B WHERE A.tablespace_name = B.tablespace_name "
   DISCONNECT CURRENT   
   LET p_psw = edit_tdb_passwd 
   LET l_source = targetnode 
   CONNECT TO l_source USER "system" USING p_psw
   PREPARE dsdatack_tpre from ls_sql
   DECLARE dsdatack_tdb CURSOR FOR dsdatack_tpre
   FOREACH dsdatack_tdb INTO  l_len2
      LET tdbexpdf = l_len2
   END FOREACH
   DISCONNECT CURRENT
   DATABASE g_dbs
   IF l_len2 > l_len  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "DSDATA空間太小 : 缺 ",l_len-l_len2,"  GB"
      LET g_errparam.code   = 'adz-00907'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   ELSE
      RETURN TRUE 
   END IF
END FUNCTION

PRIVATE FUNCTION adzp555_dfck()
   DEFINE ls_cmd STRING
   DEFINE lc_channel base.Channel
   DEFINE ls_result STRING
   DEFINE ls_apdf STRING 
   DEFINE ls_dbdf STRING 
   LET ls_apdf = 0
   LET ls_dbdf = 0
   LET apbakdf = 0

   IF apbackup = 1 THEN
   #目的端空程式間需求
      LET lc_channel = base.Channel.create()
      LET ls_cmd = "du -sm ",edit_tap_top,"| awk '{print $1}'"
      CALL lc_channel.openPipe(ls_cmd,"r")
      CALL lc_channel.setDelimiter("")
      WHILE lc_channel.read(ls_result)
         LET apbakdf = ls_result/1000
      END WHILE
      CALL lc_channel.close()
   END IF

   IF checkbox_cldb == 1 THEN
      IF adzp555_dsdatack() THEN
         IF dbbackup == 1 THEN
            LET ls_dbdf = (sdbexpdf + tdbexpdf)/1000 
         ELSE
            LET ls_dbdf = sdbexpdf/1000
         END IF
      END IF
   END IF



   #系統剩餘空間
   LET ls_cmd = "df  | grep /u3 | awk '{print $4}'"
   CALL lc_channel.openPipe(ls_cmd,"r")
   CALL lc_channel.setDelimiter("")
   WHILE lc_channel.read(ls_result)
      LET ls_apdf = ls_result/1000/1000
   END WHILE
   CALL lc_channel.close()
   IF (ls_apdf-apbakdf-ls_dbdf) < 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "空間還缺 : ",(ls_apdf-apbakdf-ls_dbdf),"  GB"
      LET g_errparam.code   = 'adz-00908' 
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#DB SYSTEM密碼確認
PRIVATE FUNCTION adzp555_db_psw_check(p_user,l_source,p_psw)
   DEFINE p_user,p_psw STRING
   DEFINE l_source STRING
   LET p_user = p_user.trim()
   LET p_psw = p_psw.trim()
   LET l_source = l_source.trim() 
   TRY
      CONNECT TO l_source USER p_user USING p_psw
      DISCONNECT CURRENT
      DATABASE g_dbs
      RETURN  FALSE
   CATCH
      DATABASE g_dbs
      RETURN TRUE
   END TRY
END FUNCTION
PRIVATE FUNCTION adzp555_checkin(l_source,p_user,p_psw)
   DEFINE p_user,p_psw STRING
   DEFINE l_source STRING
   LET p_user = p_user.trim()
   LET p_psw = p_psw.trim()
   LET l_source = l_source.trim()
   CONNECT TO l_source USER p_user  USING p_psw
   DELETE FROM dzlm_t WHERE (dzlm007 = 'topstd' or dzlm010 = 'topstd') ;
   UPDATE dzlm_t
   SET dzlm008=DECODE(dzlm008,'O','I',dzlm008),
               dzlm011=DECODE(dzlm011,'O','I',dzlm011),
               dzlm017=sysdate 
   WHERE(dzlm008 = 'O' or dzlm011='O')AND dzlm012 NOT LIKE 'C%' ;
   DISCONNECT CURRENT
   DATABASE g_dbs
END FUNCTION
