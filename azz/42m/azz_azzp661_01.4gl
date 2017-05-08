#+ Version..: T100-ERP-1
#+ 
#+ Filename...: azzp661_01
#+ Description: 
#+ ID.........: whitney.yen
#+ Time.......: 2016-08-22 15:18:53
IMPORT util
PUBLIC FUNCTION azzp661_01(lc_name,ls_js,p_req)
DEFINE lc_name      STRING
DEFINE ls_js        STRING
DEFINE p_req        DYNAMIC ARRAY OF RECORD 
                       arr     DYNAMIC ARRAY OF VARCHAR(500) 
                    END RECORD 
DEFINE l_arg        DYNAMIC ARRAY OF RECORD
       param        STRING
                END RECORD
DEFINE l_return     DYNAMIC ARRAY OF RECORD
       param        STRING
                END RECORD
   CALL util.JSON.parse(ls_js,l_arg)
   CASE lc_name
      &include "erp/azz/azzp661_01.inc"

      OTHERWISE EXIT CASE
   END CASE
   LET ls_js = util.JSON.stringify(l_return)
   RETURN ls_js
END FUNCTION
