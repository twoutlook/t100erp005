SCHEMA ds


GLOBALS "../4gl/adzp168_global.inc"

MAIN

   DEFINE p_prog_module   STRING
   DEFINE p_prog_form     LIKE dzfi_t.dzfi001
   DEFINE p_prog_ver      STRING
   DEFINE li_i,li_j,li_k,li_l LIKE type_t.num10

LET p_prog_module = ARG_VAL(1)
LET p_prog_form   = ARG_VAL(2)
LET p_prog_ver    = ARG_VAL(3)

   CONNECT TO "ds"

   display '調整前:'
   SELECT COUNT(*) INTO li_i FROM dzfi_t WHERE dzfi001 = p_prog_form 
   SELECT COUNT(*) INTO li_j FROM dzfj_t WHERE dzfj001 = p_prog_form
   SELECT COUNT(*) INTO li_k FROM dzfk_t WHERE dzfk001 = p_prog_form
   SELECT COUNT(*) INTO li_l FROM dzfl_t WHERE dzfl001 = p_prog_form
   LET g_gzza003 = p_prog_module
   DISPLAY "dzfi_t:",li_i,"筆"
   DISPLAY "dzfj_t:",li_j,"筆"
   DISPLAY "dzfk_t:",li_k,"筆"
   DISPLAY "dzfl_t:",li_l,"筆"

   IF sadzp168_3(p_prog_module,p_prog_form,p_prog_ver) THEN
   END IF

   display '調整後:'

   SELECT COUNT(*) INTO li_i FROM dzfi_t WHERE dzfi001 = p_prog_form 
   SELECT COUNT(*) INTO li_j FROM dzfj_t WHERE dzfj001 = p_prog_form
   SELECT COUNT(*) INTO li_k FROM dzfk_t WHERE dzfk001 = p_prog_form
   SELECT COUNT(*) INTO li_l FROM dzfl_t WHERE dzfl001 = p_prog_form

   DISPLAY "dzfi_t:",li_i,"筆"
   DISPLAY "dzfj_t:",li_j,"筆"
   DISPLAY "dzfk_t:",li_k,"筆"
   DISPLAY "dzfl_t:",li_l,"筆"

END MAIN




