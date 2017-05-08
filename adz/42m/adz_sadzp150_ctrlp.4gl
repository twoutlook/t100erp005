#adzp150 副程式 - 開窗相關處理

IMPORT os
SCHEMA ds

GLOBALS
   DEFINE g_properties   om.SaxAttributes
END GLOBALS

#+ 生成controlp元件
PUBLIC FUNCTION adzp150_create_controlp(p_node,pi_lv,p_loc)
   DEFINE p_node        om.DomNode
   DEFINE pi_lv         LIKE type_t.num10 
   DEFINE p_loc         STRING
   DEFINE ls_return     STRING 
   DEFINE lchannel_read base.Channel
   DEFINE ls_mdl        STRING
   DEFINE ls_read       STRING
   DEFINE ls_text       STRING
   
   #若無開窗代號則直接返回
   IF cl_null(p_node.getAttribute("form")) THEN
      RETURN ""
   END IF
   
   #取得所需參數
   CALL adzp150_get_para(p_node)
    
   #讀取小樣板
   IF p_loc = "construct" OR p_loc = "query" THEN
      LET ls_mdl = "a08"
   ELSE
      LET ls_mdl = "a07"
   END IF
   
   #讀取子樣板
   LET ls_return = adzp150_make_slice(ls_mdl)
   
   RETURN ls_return

END FUNCTION 

#取得必要參數
PRIVATE FUNCTION adzp150_get_para(p_node)
   DEFINE p_node          om.DomNode
   DEFINE ls_fields       DYNAMIC ARRAY OF LIKE type_t.chr500
   DEFINE ls_vars         DYNAMIC ARRAY OF LIKE type_t.chr500
   DEFINE ls_descs        DYNAMIC ARRAY OF LIKE type_t.chr500
   DEFINE ls_arg_descs    DYNAMIC ARRAY OF LIKE type_t.chr500
   DEFINE ls_var_title    STRING
   DEFINE li_idx          INTEGER
   DEFINE ls_sql          STRING
   DEFINE ls_tmp          STRING
   DEFINE li_cnt          INTEGER
   
   #取得開窗代碼
   CALL g_properties.addAttribute("mdl_form",p_node.getAttribute("form"))
   
   #取得變數title
   IF g_properties.getValue("location") = "head" THEN
      LET ls_var_title = g_properties.getValue("master_var_title"),"."
   ELSE
      IF g_properties.getValue("general_current_page") = "1" THEN
         LET ls_tmp = "detail_var_title"
      ELSE
         LET ls_tmp = "detail_var_title",g_properties.getValue("general_current_page")
      END IF
      LET ls_var_title = g_properties.getValue(ls_tmp),"[l_ac]."
   END IF
   
   #撈出arg的說明
   LET ls_sql = " SELECT dzcb004 ",
                " FROM   dzcb_t ",
                " WHERE  dzcb001 = '",p_node.getAttribute("form"),"' ",
                " AND    dzcb003 IS NOT NULL ",
                " ORDER BY dzcb003"
              
   PREPARE dzzb_desc FROM ls_sql
   DECLARE dzzb_desccur CURSOR FOR dzzb_desc
   
   LET li_idx = 1
   FOREACH dzzb_desccur INTO ls_arg_descs[li_idx]
      LET ls_tmp = "mdl_arg_desc", li_idx USING "<<<"
      CALL g_properties.addAttribute(ls_tmp, ls_arg_descs[li_idx])
      LET li_idx = li_idx + 1
   END FOREACH
   
   #確定共有幾個arg
   LET li_cnt = ls_arg_descs.getLength() - 1
   CALL g_properties.addAttribute("mdl_mdls2",li_cnt)
   
   #第一個欄位名稱
   #LET ls_fields[1] = g_properties.getValue("column")
   
   #2-N欄位名稱
   LET ls_sql = " SELECT dzcc003,dzeb003 ",
                " FROM   dzcc_t ",
                " LEFT OUTER JOIN dzeb_t ON dzcc003 = dzeb002 ",
                " WHERE  dzcc001 = '",p_node.getAttribute("form"),"' ",
                " AND    dzcc005 = 'Y' "
              
   PREPARE dzzc_field FROM ls_sql
   DECLARE dzzc_fieldcur CURSOR FOR dzzc_field
   
   LET li_idx = 1
   FOREACH dzzc_fieldcur INTO ls_fields[li_idx],ls_descs[li_idx]
      LET li_idx = li_idx + 1
   END FOREACH
   CALL ls_fields.deleteElement(ls_fields.getLength())
   
   #第一個欄位名稱
   LET ls_fields[1] = g_properties.getValue("column")
   
   #組合1-N變數名稱
   FOR li_idx = 1 TO ls_fields.getLength()
      LET ls_vars[li_idx] = ls_var_title,ls_fields[li_idx]
   END FOR
   
   #加入g_properties(field,var,desc)
   FOR li_idx = 1 TO ls_fields.getLength()
      LET ls_tmp = "mdl_field", li_idx USING "<<<"
      CALL g_properties.addAttribute(ls_tmp, ls_fields[li_idx])
      LET ls_tmp = "mdl_var", li_idx USING "<<<"
      CALL g_properties.addAttribute(ls_tmp, ls_vars[li_idx])
      LET ls_tmp = "mdl_desc", li_idx USING "<<<"
      CALL g_properties.addAttribute(ls_tmp, ls_descs[li_idx])
   END FOR
   
   #確定回傳幾個欄位
   CALL g_properties.addAttribute("mdl_mdls",ls_vars.getLength())
   
END FUNCTION
