IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

PRIVATE TYPE type_g_detail RECORD           #單身資料
       sel LIKE type_t.chr1, 
   locked_owner LIKE type_t.chr20,
   locked_obj   LIKE type_t.chr20,
   os_user      LIKE type_t.chr10,
   gzwl002 LIKE gzwl_t.gzwl002, 
   clientpid    LIKE type_t.chr10,
   gzwl003 LIKE gzwl_t.gzwl003, 
   gzwl007 LIKE gzwl_t.gzwl007, 
   process      LIKE type_t.chr50,
   machine      LIKE type_t.chr50,
   terminal     LIKE type_t.chr20,
   inst_id      LIKE type_t.chr10,
   sid          LIKE type_t.chr10,
   serial_id    LIKE type_t.chr10,
   serverpid    LIKE type_t.chr10,
   status       LIKE type_t.chr10
                  END RECORD

DEFINE g_sql        STRING                   #將此程式對應的版次資料呈現在畫面上(dzaf_t)的SQL
DEFINE g_final_idx  INTEGER 
DEFINE g_gzza001    VARCHAR(50)              #程式代號
DEFINE g_gzwl DYNAMIC ARRAY OF type_g_detail # 單身
DEFINE g_wc2                STRING
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5 
DEFINE g_detail_idx         LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num5 
DEFINE g_sql1       STRING

MAIN
   #Begin:modify by Hiko
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   #End

DEFINE    ls_msg     STRING

    WHENEVER ERROR CONTINUE
    
    CALL cl_tool_init()
    
    OPTIONS FIELD ORDER FORM, INPUT WRAP    

    #開啟畫面
    OPEN WINDOW w_adzp146 WITH FORM cl_ap_formpath("adz",g_code)

    CLOSE WINDOW screen

    #Begin:modify by Hiko
    CALL cl_ui_wintitle(1) #工具抬頭名稱
    
    CALL cl_load_4ad_interface(NULL)
    
    LET lw_window = ui.Window.getCurrent()
    LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
    CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

    LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
    LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
    CALL ui.Interface.loadStyles(ls_4st_path)
    #End

    #CONNECT TO 'ds'
    CALL cl_db_connect("ds", FALSE)
    CALL adzp146_init()
    CALL adzp146_ui_dialog() 
    
    #畫面關閉
    CLOSE WINDOW w_adzp146 
    
END MAIN

################################################################################
# Descriptions...: 初始化所有變數
# Memo...........:
# Usage..........: CALL adzp146_init()
################################################################################
PRIVATE FUNCTION adzp146_init()

    
    # 將此程式對應的版次資料呈現在畫面上(dzaf_t)
    LET g_sql = "SELECT 'N'", 
                ",SUBSTR(dba_objects.owner,1,16)",
                ",SUBSTR(dba_objects.object_name,1,16)",
                ",SUBSTR(os_user_name,1,10)",
                #",DS.GZWL_T.GZWL002",
                ",CASE WHEN substr(gv$session.program,1,6) = 'fglrun' THEN DS.GZWL_T.GZWL002 ELSE ' ' END",
                ",gv$locked_object.process",
                #",DS.GZWL_T.GZWL003",
                ",CASE WHEN substr(gv$session.program,1,6) = 'fglrun' THEN DS.GZWL_T.GZWL003 ELSE ' ' END",
                #",DS.GZWL_T.GZWL007",
                ",CASE WHEN substr(gv$session.program,1,6) = 'fglrun' THEN DS.GZWL_T.GZWL007 ELSE ' ' END",
                ",gv$session.program",
                ",gv$session.machine",
                ",gv$session.terminal",
                ",to_char(gv$session.inst_id)",
                ",to_char(gv$session.sid)",
                ",to_char(gv$session.serial#)",
                ",gv$process.spid",
                ",gv$session.status",
                " FROM gv$locked_object,dba_objects,gv$session,gv$process,DS.GZWL_T",
                " WHERE gv$locked_object.object_id=dba_objects.object_id",
                " AND gv$locked_object.SESSION_ID=gv$session.SID",
                " AND gv$process.addr = gv$session.paddr", 
                " AND gv$process.inst_id = gv$session.inst_id",
                " AND DS.GZWL_T.GZWL008(+) = gv$locked_object.process",
                " AND gv$session.type != 'BACKGROUND'",
                " AND gv$locked_object.inst_id = gv$session.inst_id",
                " AND gv$locked_object.process = gv$session.process"
    DECLARE adzp146_read_gzwl_sel_cur CURSOR FROM g_sql    

    IF g_account <> 'tiptop' THEN
       #CALL cl_set_comp_visible("b_os_user,b_clientpid,b_process,b_machine,b_terminal,b_serverpid,b_status",FALSE)
       CALL cl_set_comp_visible("b_os_user,b_clientpid,b_process,b_machine,b_terminal,b_serverpid",FALSE)
    END IF
END FUNCTION

PRIVATE FUNCTION adzp146_ui_dialog()
DEFINE ls_msg           STRING
DEFINE l_chk            BOOLEAN                   #檢查是否存在
DEFINE l_index          INTEGER                   #index

        WHILE TRUE
            IF g_action_choice = "exit" THEN
                EXIT WHILE
            END IF
   
        CALL adzp146_fill_array()
        
        #顯示單身
    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        DISPLAY ARRAY g_gzwl TO s_detail1.*
            BEFORE DISPLAY
                CALL cl_set_act_visible("select,refresh,query", TRUE)
                CALL cl_set_act_visible("accept,cancel,delete", FALSE)

                
            ON ACTION select
               CALL adzp146_select()

            ON ACTION refresh
               CALL adzp146_fill_array()

            ON ACTION query   
               CALL adzp146_query()

            #離開程式
            ON ACTION CLOSE
                LET g_action_choice = "exit"
                EXIT DIALOG
                
            #離開程式
            ON ACTION EXIT
                LET g_action_choice = "exit"
                LET INT_FLAG = FALSE
                EXIT DIALOG

        END DISPLAY
        END DIALOG
        END WHILE      

END FUNCTION

################################################################################
# Descriptions...: 根據條件取得資料填充單身ARRAY，以備顯示
# Memo...........:
# Usage..........: CALL adzp146_fill_array()
################################################################################
PRIVATE FUNCTION adzp146_fill_array()
DEFINE l_index          INTEGER      # 單身index

    CALL g_gzwl.clear()
    
    OPEN adzp146_read_gzwl_sel_cur 
    LET l_index = 0
    FOREACH adzp146_read_gzwl_sel_cur INTO g_gzwl[l_index+1].*
      LET l_index = l_index + 1
    END FOREACH
    CALL g_gzwl.deleteElement(g_gzwl.getLength())
    LET g_final_idx = l_index

    CLOSE adzp146_read_gzwl_sel_cur

END FUNCTION

PRIVATE FUNCTION adzp146_select()

   CALL cl_set_act_visible("select,refresh,query,accept", FALSE)
   CALL cl_set_act_visible("cancel,delete", TRUE)
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_gzwl FROM s_detail1.*
          ATTRIBUTE(COUNT = g_final_idx,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = False, 
                  DELETE ROW = False,
                  APPEND ROW = FALSE)





          ON ACTION CLOSE
            LET g_action_choice="exit"
            EXIT DIALOG            
           
      END INPUT     

      ON ACTION DELETE      
          CALL adzp146_delete()  
          EXIT DIALOG

      ON ACTION CANCEL
        LET g_action_choice="exit"
        EXIT DIALOG          

   END DIALOG 
   CALL adzp146_fill_array() 
   CALL cl_set_act_visible("select,refresh,query", TRUE)
   CALL cl_set_act_visible("accept,cancel,delete", FALSE)   
END FUNCTION

PRIVATE FUNCTION adzp146_delete()
 DEFINE li_idx          LIKE type_t.num5
 DEFINE ls_erpuser      LIKE gzwl_t.gzwl002
 DEFINE ls_sid          LIKE type_t.chr10
 DEFINE ls_serial       LIKE type_t.chr10
 DEFINE ls_inst_id      LIKE type_t.chr10
 DEFINE ls_cmd          STRING
 DEFINE ls_status       LIKE type_t.chr10

 
    FOR li_idx = 1 TO g_gzwl.getLength()
        IF g_gzwl[li_idx].sel = 'Y' THEN
           LET ls_sid = g_gzwl[li_idx].sid 
           LET ls_serial = g_gzwl[li_idx].serial_id
           LET ls_inst_id = g_gzwl[li_idx].inst_id
           LET ls_erpuser = g_gzwl[li_idx].gzwl002
           LET ls_status = g_gzwl[li_idx].status
           IF g_account <> 'tiptop' AND (ls_erpuser <> g_account OR cl_null(ls_erpuser)) THEN
              INITIALIZE g_errparam TO NULL 
              LET g_errparam.extend = "" 
              LET g_errparam.code   = "adz-00649"
              LET g_errparam.popup  = TRUE 
              CALL cl_err()
           ELSE
              IF ls_status = 'KILLED' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "Unlock program already in progress, please be patient.\nOr can be used to delete the root account execute kill -9."
                 LET g_errparam.code = "!"
                 #LET g_errparam.code   = "adz-00699"
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
              ELSE
                 PREPARE stmt FROM "begin system.top_sp_kill_session(?,?,?); end;"
                 EXECUTE stmt USING ls_sid IN, ls_serial IN, ls_inst_id IN
              END IF
           END IF
           
        END IF
    END FOR
END FUNCTION

PRIVATE FUNCTION adzp146_query()
   DEFINE ls_wc      LIKE type_t.chr500

   CALL cl_set_comp_entry("b_locked_owner,b_locked_obj,b_os_user,b_gzwl002,clientpid,b_gzwl003",TRUE)
   CALL cl_set_comp_visible("sel",FALSE)
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzwl.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2   

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc2 ON owner,object_name,os_user_name,gzwl002,process,gzwl003
         FROM s_detail1[1].b_locked_owner,s_detail1[1].b_locked_obj,s_detail1[1].b_os_user,
              s_detail1[1].b_gzwl002,s_detail1[1].clientpid,s_detail1[1].b_gzwl003

      END CONSTRUCT

      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

   END DIALOG      

   IF INT_FLAG THEN
    CALL adzp146_b_fill("")
   ELSE
    CALL adzp146_b_fill(g_wc2)
   END IF

   CALL cl_set_comp_visible("sel",TRUE)
   CALL cl_set_comp_entry("b_locked_owner,b_locked_obj,b_os_user,b_gzwl002,clientpid,b_gzwl003",FALSE)
END FUNCTION

PRIVATE FUNCTION adzp146_b_fill(p_wc2)
   DEFINE p_wc2    STRING

   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF

    LET g_sql = "SELECT 'N'", 
                ",SUBSTR(dba_objects.owner,1,16)",
                ",SUBSTR(dba_objects.object_name,1,16)",
                ",SUBSTR(os_user_name,1,10)",
                ",DS.GZWL_T.GZWL002",
                ",gv$locked_object.process",
                ",DS.GZWL_T.GZWL003",
                ",DS.GZWL_T.GZWL007",
                ",gv$session.program",
                ",gv$session.machine",
                ",gv$session.terminal",
                ",to_char(gv$session.inst_id)",
                ",to_char(gv$session.sid)",
                ",to_char(gv$session.serial#)",
                ",gv$process.spid",
                ",gv$session.status",
                " FROM gv$locked_object,dba_objects,gv$session,gv$process,DS.GZWL_T",
                " WHERE gv$locked_object.object_id=dba_objects.object_id",
                " AND gv$locked_object.SESSION_ID=gv$session.SID",
                " AND gv$process.addr = gv$session.paddr", 
                " AND gv$process.inst_id = gv$session.inst_id",
                " AND DS.GZWL_T.GZWL008(+) = gv$locked_object.process",
                " AND gv$session.type != 'BACKGROUND'",
                " AND gv$locked_object.inst_id = gv$session.inst_id",
                " AND gv$locked_object.process = gv$session.process",
                " AND (", p_wc2, ") "    

   PREPARE adzp146_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adzp146_pb
   OPEN b_fill_curs
 
   CALL g_gzwl.clear()   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
   FOREACH b_fill_curs INTO g_gzwl[l_ac].sel,g_gzwl[l_ac].locked_owner,g_gzwl[l_ac].locked_obj,
                            g_gzwl[l_ac].os_user,g_gzwl[l_ac].gzwl002,g_gzwl[l_ac].clientpid,
                            g_gzwl[l_ac].gzwl003,g_gzwl[l_ac].gzwl007,g_gzwl[l_ac].process,
                            g_gzwl[l_ac].machine,g_gzwl[l_ac].terminal,g_gzwl[l_ac].inst_id,
                            g_gzwl[l_ac].sid,g_gzwl[l_ac].serial_id,g_gzwl[l_ac].serverpid,
                            g_gzwl[l_ac].status

      LET l_ac = l_ac + 1                            

   END FOREACH
   CALL g_gzwl.deleteElement(g_gzwl.getLength())     
   IF g_cnt > g_gzwl.getLength() THEN
      LET l_ac = g_gzwl.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac   
   ERROR "" 

   CLOSE b_fill_curs
   FREE adzp146_pb   
   
END FUNCTION   
