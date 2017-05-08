# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : s_daooi110_ins.4gl
# Description    : aooi110单身资料准备

IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE g_wcb                 STRING

PUBLIC FUNCTION s_aooi110_ins()

   OPEN WINDOW s_aooi110_ins_w WITH FORM cl_ap_formpath("aoo","s_aooi110_ins")   
        ATTRIBUTE (STYLE="functionwin")
        
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
      CONSTRUCT g_wcb ON ooea001 FROM ooea001
         BEFORE CONSTRUCT
             CALL cl_qbe_init()

         ON ACTION controlp INFIELD ooea001
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001() 
            DISPLAY g_qryparam.return1 TO ooea001
            NEXT FIELD ooea001
            
         ON ACTION accept
            ACCEPT CONSTRUCT

         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT CONSTRUCT

         ON ACTION about
            CALL cl_about()

         ON ACTION EXIT
            LET INT_FLAG = 1
            EXIT CONSTRUCT
      END CONSTRUCT
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CLOSE WINDOW s_aooi110_ins_w
         RETURN ''
      ELSE 
         CLOSE WINDOW s_aooi110_ins_w
         RETURN g_wcb
      END IF 
      
END FUNCTION 

