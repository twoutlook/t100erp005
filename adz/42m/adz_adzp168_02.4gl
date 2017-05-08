#+ Version..: T6-ERP-1.00.00 Build-000014
#+ 
#+ Filename...: cl_auth
#+ Buildtype..: 應用 p00 樣板自動產生
#+ Memo.......: 
#+ 以上段落由子樣板a00產生


#add-point:註解編寫項目
{<point name="main.memo" />}
#end add-point

IMPORT os
#add-point:增加匯入項目
{<point name="main.import" />}
#end add-point

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

#add-point:free_style模組變數(Module Variable)
{<point name="free_style.variable"/>}
#end add-point

#add-point:自定義模組變數(Module Variable)
DEFINE ms_detail_auth       STRING
DEFINE mc_detail_auth       LIKE type_t.chr1
DEFINE mi_show_msg_method   LIKE type_t.num5
#end add-point

############################################################
#+ @code
#+ 函式目的  檢查ACTION的權限.
#+
#+ @return   NUMBER(5)  是否有權限
############################################################
PUBLIC FUNCTION cl_chk_act_auth()
   WHENEVER ERROR CALL cl_err_msg_log

   RETURN TRUE

END FUNCTION


############################################################
#+ @code
#+ 函式目的  檢查是否允許在單身中有insert或delete的權限
#+ @param    ps_act_type  STRING  insert/delete
#+
#+ @return   NUMBER(5)  TRUE/FALSE
############################################################
FUNCTION cl_detail_input_auth(ps_act_type)
   DEFINE ps_act_type      STRING
   DEFINE li_act_allow     LIKE type_t.num5

   LET li_act_allow = TRUE
   RETURN li_act_allow
END FUNCTION






