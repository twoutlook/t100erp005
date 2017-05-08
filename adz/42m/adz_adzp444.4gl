IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

PRIVATE TYPE type_g_detail RECORD
      gzwl008 LIKE gzwl_t.gzwl008
                  END RECORD      

DEFINE g_hostname   LIKE gzwl_t.gzwl015
DEFINE g_pid        STRING
DEFINE g_sql        STRING
DEFINE g_gzwl DYNAMIC ARRAY OF type_g_detail
DEFINE g_final_idx  INTEGER
DEFINE g_zone       LIKE gzwl_t.gzwl010

MAIN
    
    WHENEVER ERROR CONTINUE

    CALL cl_tool_init()

    LET g_hostname = FGL_GETENV("HOSTNAME")
    LET g_zone = FGL_GETENV("ZONE")
    
    IF NOT cl_db_setconnect("dscom") THEN
       CALL cl_db_connect("dscom", FALSE)
    END IF

    LET g_sql = "select gzwl008 from gzwl_t where gzwl015 = ? and gzwl010 = ?"


    CALL adzp444_fill_array()

    CALL adzp444_check()
    
    IF NOT cl_db_setconnect("ds") THEN
       CALL cl_db_connect("ds", FALSE)
    END IF

    DISPLAY "CONNECT TO DS"

    CALL adzp444_fill_array()

    CALL adzp444_check()

END MAIN


################################################################################
# Descriptions...: 根據條件取得資料填充單身ARRAY，以備顯示
# Memo...........:
# Usage..........: CALL adzp444_fill_array()
################################################################################
PRIVATE FUNCTION adzp444_fill_array()
DEFINE l_index          INTEGER      # 單身index

    DECLARE adzp444_read_gzwl_sel_cur CURSOR FROM g_sql
    
    CALL g_gzwl.clear()

    OPEN adzp444_read_gzwl_sel_cur USING g_hostname,g_zone
    LET l_index = 0
    FOREACH adzp444_read_gzwl_sel_cur INTO g_gzwl[l_index+1].*
      LET l_index = l_index + 1
    END FOREACH
    CALL g_gzwl.deleteElement(g_gzwl.getLength())
    LET g_final_idx = l_index

    CLOSE adzp444_read_gzwl_sel_cur

END FUNCTION

PRIVATE FUNCTION adzp444_check()
 DEFINE li_idx          LIKE type_t.num5
 DEFINE l_pid           LIKE gzwl_t.gzwl008
 DEFINE li_result       LIKE type_t.chr1
    
    FOR li_idx = 1 TO g_gzwl.getLength()
        LET l_pid = g_gzwl[li_idx].gzwl008

        #RUN "ps -ef|grep fglrun|grep -v 'grep'|grep "||l_pid RETURNING li_result
        RUN "ls -d /proc/"||l_pid RETURNING li_result

        IF li_result = '0'  THEN
           DISPLAY 'PID:',l_pid,' COUNT:',li_result
        ELSE
           DISPLAY 'NOPID:',l_pid,' COUNT:',li_result
           DELETE FROM gzwl_t WHERE gzwl015 = g_hostname AND gzwl008 = l_pid
           IF SQLCA.SQLCODE THEN
              display SQLCA.SQLCODE
           ELSE
              COMMIT WORK
           END IF        
        END IF
    
    END FOR
    
END FUNCTION
