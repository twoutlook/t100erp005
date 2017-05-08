#adzp152 副程式 - 開窗相關處理

IMPORT os
SCHEMA ds

GLOBALS
   DEFINE g_properties   om.SaxAttributes
END GLOBALS

#+ 生成controlp元件
PUBLIC FUNCTION adzp152_create_controlp(p_node,pi_lv,p_loc)
   DEFINE p_node        om.DomNode
   DEFINE pi_lv         LIKE type_t.num10 
   DEFINE p_loc         STRING
   DEFINE ls_return     STRING 
   DEFINE lchannel_read base.Channel
   DEFINE ls_mdl        STRING
   DEFINE ls_read       STRING
   DEFINE ls_text       STRING
   DEFINE ls_mdlpath    STRING
   
   #若無開窗代號則直接返回
   IF cl_null(p_node.getAttribute("form")) THEN
      RETURN ""
   END IF
   
   #取得所需參數
   CALL adzp152_get_para(p_node)
    
   #讀取小樣板
   IF p_loc = "construct" OR p_loc = "query" THEN
      LET ls_mdl = "a08"
   ELSE
      LET ls_mdl = "a07"
   END IF
   
   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_mdlpath = FGL_GETENV("T100TEMPLATEPATH")
   IF cl_null(ls_mdlpath) THEN
      LET ls_mdlpath = FGL_GETENV("ERP")
      LET ls_mdlpath = os.Path.join(ls_mdlpath,"mdl")
   END IF

   #定義取用樣板檔案
   LET ls_mdl = "slice/code_",ls_mdl,".template"
#  LET ls_mdl = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),ls_mdl)
   LET ls_mdl = os.Path.join(ls_mdlpath,ls_mdl)

   #開啟樣板檔
   LET lchannel_read = base.Channel.create()
   CALL lchannel_read.setDelimiter("")

   CALL lchannel_read.openFile( ls_mdl CLIPPED, "r" )
   
   WHILE NOT lchannel_read.isEof()
   
      LET ls_text = ""
      LET ls_read = lchannel_read.readLine()
      
      CASE 
         WHEN ls_read.getIndexOf("#args - Start -",1)
            CALL adzp152_make_args(lchannel_read) RETURNING ls_read,lchannel_read
         WHEN ls_read.getIndexOf("#rtns - Start -",1)
            CALL adzp152_make_rtns(lchannel_read) RETURNING ls_read,lchannel_read
      END CASE

      #行代換/ 對 ${} 置換
      IF ls_read.getIndexOf("${",1) AND 
         ( ls_read.getIndexOf("${",1) < ls_read.getIndexOf("}",1) ) THEN
         LET ls_text = adzp152_line_replace(ls_read)
      ELSE
         LET ls_text = ls_read
      END IF
      
      LET ls_return = ls_return, ls_text, '\n'
      
   END WHILE  
   
   CALL lchannel_read.close()

   RETURN ls_return

END FUNCTION 

#取得必要參數
PRIVATE FUNCTION adzp152_get_para(p_node)
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
   DEFINE ls_str          STRING    #add by joyce 14/03/14
   DEFINE ls_page         LIKE type_t.num5    #YSC-E30002
   DEFINE l_location      STRING              #YSC-E30002
   DEFINE l_form_field    LIKE type_t.chr50   #YSC-E30002
   DEFINE l_sql           STRING              #YSC-E30002
   
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
   CALL g_properties.addAttribute("mdl_args",li_cnt)
   
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
   # 由於部分樣板畫面代碼會加上b_，所以先找出之前處理好的欄位對應關係，取得正確的畫面代碼
   # YSC-E30002 ---start---
   LET ls_fields[1] = g_properties.getValue("column")
   LET l_form_field = ""
   IF g_properties.getValue("location") = "head" THEN
      LET l_location = "head"
      LET ls_page = 0
   ELSE
      LET l_location = "body"
      LET ls_page = g_properties.getValue("general_current_page")
   END IF
   LET l_sql = "SELECT form_field FROM adzp152_form_tmp ",
               " WHERE type = '",l_location,"'",
                 " AND page = ",ls_page,
                 " AND var_field = '",ls_fields[1],"'"
   PREPARE adzp152_get_para_curs FROM l_sql
   EXECUTE adzp152_get_para_curs INTO l_form_field
   IF NOT cl_null(l_form_field) THEN
      LET ls_fields[1] = l_form_field
   END IF
   # YSC-E30002 --- end ---

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
   CALL g_properties.addAttribute("mdl_rtns",ls_vars.getLength())
   
END FUNCTION







