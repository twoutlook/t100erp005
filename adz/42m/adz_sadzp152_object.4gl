#adzp152 副程式 - 元件產生
# Modify........: No:YSC-E50003 14/05/19 By joyce 單頭串查功能調整
# Modify........: No:YSC-E60003 14/07/16 By joyce 增加資料遮罩功能
# Modify........: No:150529-00031 15/06/03 By joyce 調整FUNCTION adzp152_make_mdls()的回傳參數

IMPORT os
SCHEMA ds

GLOBALS
   DEFINE g_properties   om.SaxAttributes
   CONSTANT li_space = 3
   DEFINE g_component_list DYNAMIC ARRAY OF RECORD
            comp_id    STRING,
            action     LIKE type_t.num5,
            standard   LIKE type_t.num5,
            including  LIKE type_t.num5
            END RECORD
   DEFINE g_update     STRING    #YSC-E50004
END GLOBALS

DEFINE g_dzbb RECORD 
         prog_name    STRING,
         point_name   STRING,
         point_ver    STRING,
         addpoint     STRING
         END RECORD


#+ 生成reference元件
PUBLIC FUNCTION adzp152_create_reference(pn_node,pi_lv) 
   DEFINE pn_node         om.DomNode
   DEFINE pi_lv           INTEGER
   DEFINE ls_input_field  STRING     #所有傳入欄位
   DEFINE ls_output_field STRING     #所有傳出欄位
   DEFINE ls_output_var   STRING     #所有傳出變數(承接變數)
   DEFINE ls_input_def    STRING     #所有傳入欄位定義
   DEFINE ls_output_def   STRING     #所有傳出欄位定義
   DEFINE ls_sql          STRING 
   DEFINE ls_ref_show     STRING
   DEFINE ls_ref_name     STRING 
   DEFINE ls_return       STRING                      
   DEFINE ls_page         STRING
   DEFINE ls_title        STRING
   DEFINE ls_title_t      STRING
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_token        STRING
   DEFINE li_idx          INTEGER
   DEFINE ls_tmp          STRING 
   DEFINE ls_tmp2         STRING 
   DEFINE ls_idx          STRING 
   DEFINE ls_prefix       STRING
   DEFINE ls_postfix      STRING
   
   LET ls_input_field = pn_node.getAttribute("ref_field")
   LET ls_output_field = pn_node.getAttribute("field")
   LET ls_sql = adzp152_replace_var(pn_node.getAttribute("ref_sql"))

   #組合傳入ref變數
   CASE g_properties.getValue("location")
      WHEN "head"
         LET ls_ref_name = "master_vars_reference"
         LET ls_title = g_properties.getValue("master_var_title"),"."
         #LET ls_prefix =  "("
         #LET ls_postfix = ")"
      WHEN "body"
         LET ls_page = g_properties.getValue("page_location")
         IF ls_page = '1' THEN
            LET ls_ref_name = "detail_vars_reference"
            LET ls_title = g_properties.getValue("detail_var_title"),"[l_ac]."
         ELSE 
            LET ls_ref_name = "detail_vars_reference"||ls_page
            LET ls_title = g_properties.getValue("detail_var_title"||ls_page),"[l_ac]."
         END IF
      WHEN "browser"
         LET ls_ref_name = "browser_vars_reference"
         LET ls_title = "g_browser[g_cnt].b_"
      WHEN "tree"
         LET ls_ref_name = "browser_vars_reference"
         LET ls_title = "g_browser[l_ac].b_"
   END CASE
   
   #傳入參數
   LET lst_token = base.StringTokenizer.create(ls_input_field, ',')
   LET li_idx = 0
   LET ls_title_t = ls_title
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      #判斷該欄位是否出現在單頭
      LET ls_tmp2 = g_properties.getValue("master_vars_all")
      IF ls_tmp2.getIndexOf(ls_token,1) > 0 AND g_properties.getValue("location") = "body" THEN
         LET ls_title = g_properties.getValue("master_var_title"),"."
      ELSE
         LET ls_title = ls_title_t
      END IF
      LET ls_tmp = ls_title, ls_token
      LET li_idx = li_idx + 1
      LET ls_idx = li_idx USING "<<<"
      LET ls_input_def = ls_input_def, (pi_lv*li_space) SPACES, 
                                       "LET g_ref_fields[",ls_idx,"] = ", ls_tmp, "\n"
   END WHILE
   
   #傳出參數
   LET lst_token = base.StringTokenizer.create(ls_output_field, ',')
   LET li_idx = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_tmp = ls_title, lst_token.nextToken()
      LET li_idx = li_idx + 1
      LET ls_idx = li_idx USING "<<<"
      #IF g_properties.getValue("location") = "head" THEN
         LET ls_output_def = ls_output_def, (pi_lv*li_space) SPACES, 
                                             "LET ", ls_tmp, " = '", ls_prefix, "', g_rtn_fields[",ls_idx,"] , '", ls_postfix, "'\n"
      #ELSE
      #   LET ls_output_def = ls_output_def, (pi_lv*li_space) SPACES, 
      #                                       "LET ", ls_tmp, " = '", ls_prefix, "', g_rtn_fields[",ls_idx,"] , '", ls_postfix, "'\n"      
      #END IF
      
      LET ls_output_var = ls_output_var, ls_tmp
      IF lst_token.hasMoreTokens() THEN
         LET ls_output_var = ls_output_var, ","
      END IF
   END WHILE
   
   #組合ref段落
   LET ls_return = (pi_lv*li_space) SPACES, 
                   "INITIALIZE g_ref_fields TO NULL\n",
                   ls_input_def,
                   (pi_lv*li_space) SPACES,              # YSC-E60003
                   "LET ls_sql = \"",ls_sql,"\"\n",      # YSC-E60003
                   (pi_lv*li_space) SPACES,              # YSC-E60003
                   "LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料","\n",   # YSC-E60003
                   (pi_lv*li_space) SPACES, 
                #  "CALL ap_ref_array2(g_ref_fields,\"",ls_sql,"\",\"\") RETURNING g_rtn_fields\n",    #YSC-E60003 mark
                   "CALL ap_ref_array2(g_ref_fields,ls_sql,\"\") RETURNING g_rtn_fields\n",  # YSC-E60003
                   ls_output_def

   LET ls_return = ls_return, (pi_lv*li_space) SPACES, "DISPLAY BY NAME ", ls_output_var,"\n"
   
   #判斷是否已產生過
   LET ls_ref_show = g_properties.getValue(ls_ref_name)
   IF ls_ref_show.getIndexOf(ls_return,'1') = 0 THEN
      LET ls_ref_show = ls_ref_show, "\n", ls_return
      CALL g_properties.addAttribute(ls_ref_name,ls_ref_show)
   END IF

   RETURN ls_return
   
END FUNCTION 

PRIVATE FUNCTION adzp152_object_reference(pn_node,ps_var,ps_title)
   DEFINE pn_node         om.DomNode
   DEFINE ps_var          STRING
   DEFINE ps_title        STRING
   DEFINE ls_return       STRING
   DEFINE ls_var          STRING
   DEFINE ls_name         STRING
   DEFINE li_idx          INTEGER
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_token        STRING
   DEFINE ls_tmp          CHAR(50)
   DEFINE li_tmp          INTEGER
   DEFINE ls_loc          STRING
   DEFINE ls_page         STRING
   
   #先確定目前所在
   LET ls_loc = g_properties.getValue("location") 
   
   #帶入function名稱
   LET ls_name = "mdl_func"
   LET ls_var = "cl_ref_val"
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #檢查代碼
   LET ls_name = "mdl_chkid"
   LET ls_var = pn_node.getAttribute("chkid")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得傳入欄位名稱
   LET ls_name = "mdl_field"
   LET ls_var = g_properties.getValue("column")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得傳入變數
   LET ls_name = "mdl_var1"
   LET ls_var = ps_var
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #傳入變數數量
   LET ls_name = "mdl_args"
   LET ls_tmp = pn_node.getAttribute("chkid")
   SELECT COUNT(*) INTO li_tmp FROM dzce_t 
    WHERE dzce001 = ls_tmp
   LET ls_var = li_tmp USING "<<<" 
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得傳入參數2-N
   FOR li_idx = 2 TO ls_var
      LET ls_name = "mdl_var", li_idx USING "<<<"
      LET ls_var = "'參數", li_idx USING "<<<", "'"
      CALL g_properties.addAttribute(ls_name,ls_var)
   END FOR
   
   #呼叫子樣板
   LET ls_return = adzp152_read_slice("a23")
   
   #將資料寫進對應的show add-point
   IF ls_loc = "head" THEN
      LET g_dzbb.prog_name   = g_properties.getValue("app_id")
      LET g_dzbb.point_name  = "show.head.reference"
   #  LET g_dzbb.point_ver   = g_properties.getValue("general_prog_ver")  #YSC-E60004 mark
      LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")   #YSC-E60004 modify
      LET g_dzbb.addpoint    = ls_return
   #  CALL adzp152_insert_addpoint(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint)       #YSC-E50004 mark
      CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))  #YSC-E50004 modify     
   ELSE
      LET ls_page = adzp152_create_name(adzp152_page_trans(g_properties.getValue("general_current_page")), "body", "<<<")
      LET g_dzbb.prog_name   = g_properties.getValue("app_id")
      LET g_dzbb.point_name  = "show.",ls_page,".reference"
   #  LET g_dzbb.point_ver   = g_properties.getValue("general_prog_ver")  #YSC-E60004 mark
      LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")   #YSC-E60004 modify
      LET g_dzbb.addpoint    = ls_return
   #  CALL adzp152_insert_addpoint(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint)        #YSC-E50004 mark
      CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))   #YSC-E50004 modify        
   END IF

   RETURN ls_return

END FUNCTION

#+ 生成object元件
PRIVATE FUNCTION adzp152_read_slice(ps_slice)
   DEFINE ps_slice        STRING
   DEFINE ls_return       STRING 
   DEFINE lchannel_read   base.Channel
   DEFINE ls_slice        STRING
   DEFINE ls_read         STRING
   DEFINE ls_text         STRING
   DEFINE pi_lv           LIKE type_t.num10
   DEFINE ls_mdlpath      STRING


   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_mdlpath = FGL_GETENV("T100TEMPLATEPATH")
   IF cl_null(ls_mdlpath) THEN
      LET ls_mdlpath = FGL_GETENV("ERP")
      LET ls_mdlpath = os.Path.join(ls_mdlpath,"mdl")
   END IF

   #定義取用樣板檔案
   LET ls_slice = "slice/code_",ps_slice,".template"
#  LET ls_slice = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),ls_slice)
   LET ls_slice = os.Path.join(ls_mdlpath,ls_slice)

   #開啟樣板檔
   LET lchannel_read = base.Channel.create()
   CALL lchannel_read.setDelimiter("")

   CALL lchannel_read.openFile( ls_slice CLIPPED, "r" )
   
   WHILE NOT lchannel_read.isEof()
   
      LET ls_text = ""
      LET ls_read = lchannel_read.readLine()
      
      CASE 
         WHEN ls_read.getIndexOf("#args - Start -",1)
            CALL adzp152_make_args(lchannel_read) RETURNING ls_read,lchannel_read
            
         WHEN ls_read.getIndexOf("#rtns - Start -",1)
            CALL adzp152_make_rtns(lchannel_read) RETURNING ls_read,lchannel_read
         
         WHEN ls_read.getIndexOf("#mdls - Start -",1)
         #  CALL adzp152_make_mdls(lchannel_read) RETURNING ls_read,lchannel_read     #YSC-E50003 mark
         #  CALL adzp152_make_mdls(lchannel_read,1) RETURNING ls_read,lchannel_read   #150529-00031 mark
            CALL adzp152_make_mdls(lchannel_read,1) RETURNING lchannel_read,ls_read
      
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

#+ 生成mreference元件
PUBLIC FUNCTION adzp152_create_mreferance(pn_node,pi_lv,pi_id)
   DEFINE pn_node         om.DomNode
   DEFINE pi_lv           INTEGER
   DEFINE pi_id           INTEGER
   DEFINE ls_col          STRING
   DEFINE ls_var          STRING
   DEFINE ls_tmp          STRING
   DEFINE ls_name         STRING
   DEFINE ls_loc          STRING
   DEFINE ls_return       STRING
   DEFINE li_idx          INTEGER
   DEFINE ls_token        STRING
   DEFINE lst_token       base.StringTokenizer
   
   #先確定目前所在
   LET ls_loc = g_properties.getValue("location") 
 
   #取得該欄位變數名稱
   LET ls_col = g_properties.getValue("column") 
   IF ls_loc = "head" THEN
      LET ls_var = g_properties.getValue("master_var_title"),".",ls_col
   ELSE
      LET ls_var = adzp152_find_page(pn_node.getAttribute("field"),""),".",ls_col
   END IF
   CALL g_properties.addAttribute("mdl_var",ls_var)
 
   #取得table名稱
   LET ls_name = "mdl_tbl"
   LET ls_var  = pn_node.getAttribute("table")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得wc
   LET ls_name = "mdl_wc"
   LET ls_var = adzp152_replace_var(pn_node.getAttribute("wc"))
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得mdl_field_list
   LET ls_name = "mdl_field_list"
   LET ls_var =  pn_node.getAttribute("field")
   CALL g_properties.addAttribute(ls_name,ls_var)

   #取得mdl_field_list
   LET li_idx = 0
   LET ls_tmp =  pn_node.getAttribute("rtn_field")
   LET lst_token = base.StringTokenizer.create(ls_tmp, ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET li_idx = li_idx + 1
      LET ls_name = adzp152_create_name(li_idx, "mdl_rtn_var", "<<<")
      IF g_properties.getValue("location") = "head" THEN
         LET ls_var = g_properties.getValue("master_var_title"),".",ls_token
      ELSE
         LET ls_var = adzp152_find_page(ls_token,""),".",ls_token
      END IF
      CALL g_properties.addAttribute(ls_name,ls_var)
   END WHILE
   
   #取得mdl_mdls
   CALL g_properties.addAttribute("mdl_mdls",li_idx)
   
   #呼叫子樣板
   LET ls_return = adzp152_read_slice("a25")
   
   RETURN ls_return
   
END FUNCTION 


#+ 生成mcode元件
PUBLIC FUNCTION adzp152_create_mcode(pn_node,pi_lv,pi_id)
   DEFINE pn_node         om.DomNode
   DEFINE pi_lv           INTEGER
   DEFINE pi_id           INTEGER
   DEFINE ls_return       STRING
   DEFINE ls_var          STRING
   DEFINE ls_name         STRING
   DEFINE li_idx          INTEGER
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_token        STRING
   DEFINE ls_loc          STRING

   #先確定目前所在
   LET ls_loc = g_properties.getValue("location") 
 
   #取得id
   LET ls_name = "mdl_id"
   LET ls_var  = pi_id USING "<<<"
   CALL g_properties.addAttribute(ls_name,ls_var)
 
   #取得table名稱
   LET ls_name = "mdl_tbl"
   LET ls_var  = pn_node.getAttribute("table")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得wc
   LET ls_name = "mdl_wc"
   LET ls_var = adzp152_replace_var(pn_node.getAttribute("wc"))
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得mdl_mcode
   LET ls_name = "mdl_mcode1"
   LET ls_var =  pn_node.getAttribute("mcode1")
   CALL g_properties.addAttribute(ls_name,ls_var)
   LET ls_name = "mdl_mcode2"
   LET ls_var =  pn_node.getAttribute("mcode2")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得傳入變數(1-N)
   LET lst_token = base.StringTokenizer.create(pn_node.getAttribute("ref_field"), ',')
   LET li_idx = 1
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_name = "mdl_var",li_idx USING "<<<"
      IF ls_loc = "head" THEN
         LET ls_var = g_properties.getValue("master_var_title"),".",ls_token
      ELSE
         LET ls_var = adzp152_find_page(g_properties.getValue("column"),""),".",ls_token
      END IF
      CALL g_properties.addAttribute(ls_name,ls_var)
      IF lst_token.hasMoreTokens() THEN
         LET li_idx = li_idx + 1
      END IF
   END WHILE
   
   #傳入變數數量
   LET ls_name = "mdl_args"
   LET ls_var = li_idx USING "<<<" 
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得回傳的欄位
   LET ls_name = "mdl_var_rtn"
   IF ls_loc = "head" THEN
      LET ls_var = g_properties.getValue("master_var_title"),".",pn_node.getAttribute("field")
   ELSE
      LET ls_var = adzp152_find_page(pn_node.getAttribute("field"),""),".",pn_node.getAttribute("field")
   END IF
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #呼叫子樣板
   LET ls_return = adzp152_read_slice("a25")

   RETURN ls_return
   
END FUNCTION 






