#adzp150 副程式 - 元件產生

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
   DEFINE g_update       STRING
END GLOBALS

DEFINE g_dzbb RECORD 
         prog_name    STRING,
         point_name   STRING,
         point_ver    STRING,
         addpoint     STRING
         END RECORD

#+ 生成component元件
PUBLIC FUNCTION adzp150_create_component(p_comp,pi_lv)
   DEFINE p_comp         om.DomNode
   DEFINE pi_lv          LIKE type_t.num10 
   DEFINE li_cnt         LIKE type_t.num10 
   DEFINE ls_id          STRING 
   DEFINE ls_para        STRING 
   DEFINE ls_field       STRING
   DEFINE ls_into        STRING
   DEFINE ls_file        STRING
   DEFINE ls_wc          STRING
   DEFINE ls_re          STRING
   DEFINE ls_name        STRING
   DEFINE ls_des         STRING
   DEFINE ls_src         STRING
   DEFINE ls_return      STRING 
   DEFINE ls_memo        STRING 
   DEFINE ls_prog        STRING 

   FOR li_cnt = 1 TO p_comp.getAttributesCount()
      #先進行屬性擷取, 不同屬性以不同的變數承接
      CASE DOWNSHIFT(p_comp.getAttributeName(li_cnt))
         WHEN "id"        LET ls_id    = p_comp.getAttributeValue(li_cnt)
         WHEN "parameter" LET ls_para  = p_comp.getAttributeValue(li_cnt)
         WHEN "field"     LET ls_field = p_comp.getAttributeValue(li_cnt)
         WHEN "file"      LET ls_file  = p_comp.getAttributeValue(li_cnt)
         WHEN "into"      LET ls_into  = p_comp.getAttributeValue(li_cnt)
         WHEN "wc"        LET ls_wc    = p_comp.getAttributeValue(li_cnt)
         WHEN "retrun"    LET ls_re    = p_comp.getAttributeValue(li_cnt)
         WHEN "name"      LET ls_name  = p_comp.getAttributeValue(li_cnt)
         WHEN "des"       LET ls_des   = p_comp.getAttributeValue(li_cnt)
         WHEN "src"       LET ls_src   = p_comp.getAttributeValue(li_cnt)
         WHEN "memo"      LET ls_memo  = p_comp.getAttributeValue(li_cnt)
         WHEN "prog"      LET ls_prog  = p_comp.getAttributeValue(li_cnt)
         WHEN "mode"      
            IF p_comp.getAttributeValue(li_cnt) = "bundle" THEN
               #display "附加:",ls_name,"元件進程式中" 
               #CALL adzp150_append_list(ls_name)
            END IF
         OTHERWISE  
            DISPLAY "ERROR:tab設定不存在的元件Name:",p_comp.getAttributeName(li_cnt)
      END CASE 
   END FOR 

   CASE DOWNSHIFT(ls_id)
      #CALL cl_cmdrun_wait(...)
      #WHEN "link"
      #   LET ls_para = adzp150_parse_para(ls_para)
      #   LET ls_return =  "CALL cl_cmdrun_wait('",ls_prog,"'",ls_para, ")\n"

      #return ...
      WHEN "return"
         LET ls_return = "RETURN ",ls_re,"\n"

      #select ... into ...
      WHEN "select"
         LET ls_return = "SELECT ",ls_field," INTO ",ls_into, " FROM ",ls_file, " WHERE ",ls_wc, "\n"

      #display by name ..., display ... to ...
      WHEN "display"
         IF ls_field = "by name" THEN 
            LET ls_return = "DISPLAY BY NAME",ls_para,"\n"
         ELSE 
            LET ls_return = "DISPLAY ",ls_para," TO ",ls_field,"\n"
         END IF 

      #call ...(...), call ...(...) returning ...
      WHEN "call"
         IF ls_re.getLength() = 0 THEN 
            LET ls_return = "CALL ",ls_name,"(",ls_para, ")\n"
         ELSE 
            LET ls_return = "CALL ",ls_name,"(",ls_para, ") RETURNING ",ls_re, "\n"
         END IF 

      #let ... = ...
      WHEN "let"
         LET ls_return = "LET ",ls_des," = ",ls_src, "\n"

      #...
      WHEN "print"
         LET ls_return = ls_para, "\n"

      #update ... set ... = ... where ...
      WHEN "update"
         LET ls_return = " UPDATE ",ls_file," SET (",ls_field, ") = (",ls_para,") ",
                         " WHERE ",ls_wc,"\n"
      #define ... ...
      WHEN "define"
         LET ls_return = "DEFINE ",ls_name," ",ls_para,"\n"

      OTHERWISE  DISPLAY "ERROR:tab設定不存在的元件功能(id):",ls_id
   END CASE 

   LET ls_return = (pi_lv*li_space) SPACES ,ls_return
   
   RETURN ls_return
END FUNCTION



#+ 生成operator元件
PUBLIC FUNCTION adzp150_create_operator(lnode_oper,pi_lv)
   DEFINE lnode_oper           om.DomNode
   DEFINE lnode_child          om.DomNode
   DEFINE pi_lv                LIKE type_t.num10 
   DEFINE li_cnt               LIKE type_t.num10 
   DEFINE ls_type              STRING 
   DEFINE l_cond               STRING 
   DEFINE l_name               STRING 
   DEFINE l_para               STRING 
   DEFINE l_begin,l_end,l_step STRING 
   DEFINE l_return             STRING 
   DEFINE ls_tmp               STRING
   DEFINE ls_id                STRING
   DEFINE ls_memo              STRING   #註解

   LET l_step = NULL 
       
   #operator規格
   #   上層外框
   #       中層內容
   #   下層外框(不一定有)

   #確定該operator為何種類型, 並擷取參數
   FOR li_cnt = 1 TO lnode_oper.getAttributesCount()

      CASE lnode_oper.getAttributeName(li_cnt)

         WHEN "id"   #元件種類
            LET ls_id = lnode_oper.getAttributeValue(li_cnt)
            LET ls_id = ls_id.toLowerCase()
            CASE ls_id
               WHEN "if"         LET ls_type = "if"
               WHEN "case"       LET ls_type = "case"
               WHEN "function"   LET ls_type = "function"
               WHEN "while"      LET ls_type = "while"
               WHEN "for"        LET ls_type = "for"
               WHEN "menu"       LET ls_type = "menu"
               WHEN "sub_action" LET ls_type = "sub_action"
               OTHERWISE  DISPLAY "ERROR:tab設定不存在的操作功能(operator id):",lnode_oper.getAttributeValue(li_cnt)
            END CASE 
               
         WHEN "condiction"   #條件
            LET l_cond = lnode_oper.getAttributeValue(li_cnt)

         WHEN "name"
            LET l_name = lnode_oper.getAttributeValue(li_cnt)

         WHEN "parameters"   #參數
            LET l_para = lnode_oper.getAttributeValue(li_cnt)

         WHEN "begin"
            LET l_begin = lnode_oper.getAttributeValue(li_cnt)

         WHEN "end"
            LET l_end = lnode_oper.getAttributeValue(li_cnt)

         WHEN "step"
            LET l_step = lnode_oper.getAttributeValue(li_cnt)

         WHEN "mode"         #狀態
            IF lnode_oper.getAttributeValue(li_cnt) = "bundle" THEN
               #display "附加:",ls_name,"元件進程式中" 
               LET ls_tmp = l_cond.subString(1,l_cond.getIndexOf("(",1)-1)
               #CALL adzp150_append_list(ls_tmp)
            END IF

         OTHERWISE
            DISPLAY "ERROR:tab設定不存在operator中的項目(property):",lnode_oper.getAttributeName(li_cnt)
      END CASE 
   END FOR 

   #上層外框(根據不同類型給予不同的外框)
   CASE ls_type
      WHEN "if"
         LET l_return = "IF ",l_cond, " THEN \n"
      WHEN "case"
         LET l_return = "CASE ",l_cond, " \n"
      WHEN "function"
         LET l_return = "FUNCTION ",l_name,"(",l_para,")\n"
      WHEN "while"
         LET l_return = "WHILE ",l_cond, " \n"
      WHEN "for"
         IF l_step.getLength() = 0 THEN 
            LET l_return = "FOR ",l_para," = ",l_begin," TO ", l_end, " \n"
         ELSE 
            LET l_return = "FOR ",l_para," = ",l_begin," TO ", l_end, " STEP ", l_step, " \n"
         END IF 
      WHEN "menu" 
         LET l_return = "MENU \"\" ATTRIBUTE(STYLE=\"popup\")"," \n"
      WHEN "sub_action"
         LET l_return = "ON ACTION ",l_name," \n"
   END CASE 
   LET l_return = (pi_lv*li_space) SPACES,l_return

   #中層內容(除if,case為較特殊的物件,其餘皆使用同樣的產生方式)
   FOR li_cnt = 1 TO lnode_oper.getChildCount()

      #抓取子層的 node 與說明部分(memo)
      LET lnode_child = lnode_oper.getChildByIndex(li_cnt)
      LET ls_memo = lnode_child.getAttribute("memo")
      IF ls_memo IS NOT NULL THEN
         LET ls_memo = 10 SPACES,"#",ls_memo
      END IF

      CASE ls_type
         WHEN "if"
            IF lnode_child.getAttribute("type") = "true" THEN 
               LET l_return = l_return, adzp150_parse_element(lnode_child,pi_lv+1)
            ELSE 
               LET l_return = l_return, (pi_lv*li_space) SPACES,
                             "ELSE\n",
                              adzp150_parse_element(lnode_child,pi_lv+1)
            END IF 

         WHEN "case"    #此處處理 sub-operator 元件
            LET pi_lv = pi_lv + 1
            LET l_return = l_return, (pi_lv*li_space) SPACES,
                           "WHEN \"", lnode_child.getAttribute("condiction") CLIPPED,"\"",ls_memo,"\n",
                           adzp150_parse_element(lnode_child,pi_lv+1)
            LET pi_lv = pi_lv - 1
             
         OTHERWISE 
            LET l_return = l_return, adzp150_parse_element(lnode_oper,pi_lv+1)
      END CASE
   END FOR 

   #下層外框(根據不同類型給予不同的外框)
   CASE ls_type
      WHEN "if"
         LET l_return = l_return, (pi_lv*li_space) SPACES,"END IF\n"
      WHEN "case"
         LET l_return = l_return, (pi_lv*li_space) SPACES,"END CASE\n"
      WHEN "function"
         LET l_return = l_return, (pi_lv*li_space) SPACES,"END FUNCTION\n"
      WHEN "while"
         LET l_return = l_return, (pi_lv*li_space) SPACES,"END WHILE\n"
      WHEN "for"                  
         LET l_return = l_return, (pi_lv*li_space) SPACES,"END FOR\n"
      WHEN "menu"                 
         LET l_return = l_return, (pi_lv*li_space) SPACES,"END MENU\n"
   END CASE 

   RETURN l_return
END FUNCTION 


#+ 生成reference元件
PUBLIC FUNCTION adzp150_create_reference(pn_node,pi_lv) 
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
   LET ls_sql = adzp150_replace_var(pn_node.getAttribute("ref_sql"))
    
   #組合傳入ref變數
   CASE g_properties.getValue("location")
      WHEN "head"
         LET ls_ref_name = "master_vars_reference"
         LET ls_title = g_properties.getValue("master_var_title"),"."
         #LET ls_prefix =  "("
         #LET ls_postfix = ")"
         CALL adzp150_reference_join(pn_node,'master')
      WHEN "body"
         LET ls_page = g_properties.getValue("page_location")
         IF ls_page = '1' THEN
            LET ls_ref_name = "detail_vars_reference"
            LET ls_title = g_properties.getValue("detail_var_title"),"[l_ac]."
         ELSE 
            LET ls_ref_name = "detail_vars_reference"||ls_page
            LET ls_title = g_properties.getValue("detail_var_title"||ls_page),"[l_ac]."
         END IF
         CALL adzp150_reference_join(pn_node,'detail')
      WHEN "browser"
         LET ls_ref_name = "browser_vars_reference"
         LET ls_title = "g_browser[g_cnt].b_"
         CALL adzp150_reference_join(pn_node,'browser')
      WHEN "tree"
         LET ls_ref_name = "browser_vars_reference"
         LET ls_title = "g_browser[l_ac].b_"
         CALL adzp150_reference_join(pn_node,'browser')
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
      IF ls_token.getIndexOf('.',1) THEN
         LET ls_token = ls_token.subString(ls_token.getIndexOf('.',1)+1,ls_token.getLength())
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
                   (pi_lv*li_space) SPACES, 
                   "CALL ap_ref_array2(g_ref_fields,\"",ls_sql,"\",\"\") RETURNING g_rtn_fields\n", 
                   ls_output_def

   LET ls_return = ls_return, (pi_lv*li_space) SPACES, "DISPLAY BY NAME ", ls_output_var,"\n"
   
   #判斷是否已產生過
   #LET ls_ref_show = g_properties.getValue(ls_ref_name)
   #IF ls_ref_show.getIndexOf(ls_return,'1') = 0 THEN
   #   LET ls_ref_show = ls_ref_show, "\n", ls_return
   #   CALL g_properties.addAttribute(ls_ref_name,ls_ref_show)
   #END IF
   
   RETURN ls_return
   
END FUNCTION 

#+ 生成check元件
PUBLIC FUNCTION adzp150_create_check(pn_node,pi_lv)
   DEFINE pn_node       om.DomNode
   DEFINE pi_lv         LIKE type_t.num10 
   DEFINE l_bt          STRING
   DEFINE l_st          STRING 
   DEFINE l_bt_type     STRING
   DEFINE l_st_type     STRING 
   DEFINE l_field       STRING 
   DEFINE l_table       STRING 
   DEFINE l_errno       STRING 
   DEFINE l_sql         STRING 
   DEFINE l_ow          STRING 
   DEFINE l_var         STRING 
   DEFINE l_var_tmp     STRING 
   DEFINE l_return      STRING 
   DEFINE l_returnitem  STRING 
   DEFINE l_getfield    STRING 
   DEFINE l_returnfield STRING 
   DEFINE l_title       STRING 
   DEFINE l_tok         base.StringTokenizer
   DEFINE l_ref_field   STRING 
   DEFINE l_tmp         STRING 
   DEFINE l_idx         INTEGER
   DEFINE l_rfield      STRING
   DEFINE l_ref_vars    STRING
   DEFINE l_chk_id      STRING
   
   CASE g_properties.getValue("location") 
      WHEN "head" 
         LET l_var = g_properties.getValue("master_var_title"),".",g_properties.getValue("column")
         LET l_var_tmp = g_properties.getValue("master_var_title"),"_t.",g_properties.getValue("column")
         LET l_title = g_properties.getValue("master_var_title"),"."
      WHEN "body" 
         LET l_tmp = g_properties.getValue("general_current_page")
         IF l_tmp = 1 THEN
            LET l_var = g_properties.getValue("detail_var_title"),"[l_ac].",g_properties.getValue("column")
         ELSE
            LET l_var = g_properties.getValue("detail_var_title"||l_tmp),"[l_ac].",g_properties.getValue("column")
         END IF
         
         LET l_var_tmp = g_properties.getValue("detail_var_title"),"_t.",g_properties.getValue("column")
         LET l_title = g_properties.getValue("detail_var_title"),"[l_ac]."
   END CASE
   
   #若該欄位未輸入則不進行校驗動作(上層)
   LET l_return = l_return, (pi_lv*li_space) SPACES, "IF NOT cl_null(",l_var,") THEN \n"
   LET pi_lv = pi_lv + 1

   CASE pn_node.getAttribute("id")

      #輸入值是否在範圍內(校驗物件)
      WHEN "range"
         #LET l_return = l_return, adzp150_object_range(pn_node,l_var)
         CALL adzp150_object_range(pn_node,l_var)

      #輸入值是否符合特定值(校驗物件)
      WHEN "match"
         LET l_return = l_return, adzp150_object_match(pn_node,l_var)

      #輸入值是否存在於資料庫中(校驗物件)
      WHEN "isExist"
         LET l_return = l_return, adzp150_object_isExist(pn_node,l_var)
                        
      #輸入值是否重複於資料庫中(校驗物件)
      WHEN "notDup"
         LET l_return = l_return, adzp150_object_notDup(pn_node,l_var)

      #校驗後回傳指定值,把校驗用的SQL同時當作帶值的SQL
      WHEN "chkandReturn"
         LET l_return = l_return, adzp150_object_chkandReturn(pn_node,l_var,l_title)
      
      #根據當下欄位值, 帶出其他欄位的內容
      WHEN "reference"
         LET l_return = l_return, adzp150_object_reference(pn_node,l_var,l_title)
         
      OTHERWISE
         DISPLAY "ERROR:Check元件",pn_node.getAttributeValue(1),"目前尚未支持該元件,請檢查元件名稱"
   
   END CASE 
   
   #若該欄位未輸入則不進行校驗動作(下層)
   LET pi_lv = pi_lv - 1
   LET l_return = l_return, (pi_lv*li_space) SPACES, "END IF \n"
   
   RETURN l_return 
   
END FUNCTION 

PRIVATE FUNCTION adzp150_object_range(pn_node,ps_var)
   DEFINE pn_node         om.DomNode
   DEFINE ps_var          STRING
   DEFINE ls_return       STRING
   DEFINE ls_var          STRING
   DEFINE ls_name         STRING
      
   #取得參數&設定參數
   LET ls_name = "mdl_field"
   LET ls_var = g_properties.getValue("column")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_var"
   LET ls_var = ps_var
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_min"
   LET ls_var = pn_node.getAttribute("bt")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_mintype"
   LET ls_var = pn_node.getAttribute("bt_type")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_max"
   LET ls_var = pn_node.getAttribute("st")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_maxtype"
   LET ls_var = pn_node.getAttribute("st_type")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_error"
   LET ls_var = pn_node.getAttribute("errno")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_ow"
   LET ls_var = pn_node.getAttribute("ow")
   CALL g_properties.addAttribute(ls_name,ls_var)

   #呼叫子樣板
   LET ls_return = adzp150_make_slice("a15")
   
   #因應資料不存進add-point
   LET ls_name = g_properties.getValue("column")||"_range_chk"
   LET ls_var = ls_return
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #RETURN ls_return
                        
END FUNCTION

PRIVATE FUNCTION adzp150_object_match(pn_node,ps_var)
   DEFINE pn_node         om.DomNode
   DEFINE ps_var          STRING
   DEFINE ls_return       STRING
   DEFINE ls_var          STRING
   DEFINE ls_name         STRING
   
   #取得參數&設定參數
   LET ls_name = "mdl_field"
   LET ls_var = g_properties.getValue("column")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_var"
   LET ls_var = ps_var
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_sql"
   LET ls_var = pn_node.getAttribute("sql")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_error"
   LET ls_var = pn_node.getAttribute("errno")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_ow"
   LET ls_var = pn_node.getAttribute("ow")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #呼叫子樣板
   LET ls_return = adzp150_make_slice("a16")
   
   RETURN ls_return

END FUNCTION


PRIVATE FUNCTION adzp150_object_isExist(pn_node,ps_var)
   DEFINE pn_node         om.DomNode
   DEFINE ps_var          STRING
   DEFINE ls_return       STRING
   DEFINE ls_var          STRING
   DEFINE ls_name         STRING
   DEFINE li_idx          INTEGER
   DEFINE ls_tmp          CHAR(50)
   DEFINE li_tmp          INTEGER
   
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
   LET ls_name = "mdl_mdls"
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
   LET ls_return = adzp150_make_slice("a17")

   RETURN ls_return

END FUNCTION


PRIVATE FUNCTION adzp150_object_notDup(pn_node,ps_var)
   DEFINE pn_node         om.DomNode
   DEFINE ps_var          STRING
   DEFINE ls_return       STRING
   DEFINE ls_var          STRING
   DEFINE ls_name         STRING
   
   #取得參數&設定參數
   LET ls_name = "mdl_field"
   LET ls_var = g_properties.getValue("column")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_var"
   LET ls_var = ps_var
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_sql"
   LET ls_var = pn_node.getAttribute("sql")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_error"
   LET ls_var = pn_node.getAttribute("errno")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   LET ls_name = "mdl_ow"
   LET ls_var = pn_node.getAttribute("ow")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #呼叫子樣板
   LET ls_return = adzp150_make_slice("a18")

   RETURN ls_return

END FUNCTION


PRIVATE FUNCTION adzp150_object_chkandReturn(pn_node,ps_var,ps_title)
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
   
   #帶入function名稱
   LET ls_name = "mdl_func"
   LET ls_var = "cl_chk_exist_and_ref_val"
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
   LET ls_name = "mdl_mdls"
   LET ls_tmp = pn_node.getAttribute("chkid")
   SELECT COUNT(*) INTO li_tmp FROM dzce_t 
    WHERE dzce001 = ls_tmp
   LET ls_var = li_tmp USING "<<<" 
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得傳入參數2-N
   FOR li_idx = 2 TO li_tmp
      LET ls_name = "mdl_var", li_idx USING "<<<"
      LET ls_var = "'參數", li_idx USING "<<<", "'"
      CALL g_properties.addAttribute(ls_name,ls_var)
   END FOR

   #取得傳出變數(承接)
   #LET ls_name = "mdl_var_ref1"
   #LET ls_var = "DB讀取"
   #CALL g_properties.addAttribute(ls_name,ls_var)

   ##傳出變數數量
   #LET ls_name = "mdl_rtns"
   #LET ls_var = "DB讀取"
   #CALL g_properties.addAttribute(ls_name,ls_var)

   #呼叫子樣板
   LET ls_return = adzp150_make_slice("a19")

   RETURN ls_return

END FUNCTION

PRIVATE FUNCTION adzp150_object_reference(pn_node,ps_var,ps_title)
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
   LET ls_name = "mdl_mdls"
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

   #取得傳出變數(承接)
   #LET ls_name = "mdl_var_ref1"
   #LET ls_var = "DB讀取"
   #CALL g_properties.addAttribute(ls_name,ls_var)
   #
   ##傳出變數數量
   #LET ls_name = "mdl_rtns"
   #LET ls_var = "DB讀取"
   #CALL g_properties.addAttribute(ls_name,ls_var)

   #呼叫子樣板
   LET ls_return = adzp150_make_slice("a23")
   
   #將資料寫進對應的show add-point
   IF ls_loc = "head" THEN
      LET g_dzbb.prog_name   = g_properties.getValue("app_id")
      LET g_dzbb.point_name  = "show.head.reference"
      IF g_properties.getValue("type_id") = "i07" THEN
         #i07使用的add-point名稱不同
         LET g_dzbb.point_name  = "ref_show.head.reference"
      END IF
      LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
      LET g_dzbb.addpoint    = ls_return
      CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))     
   ELSE
      LET ls_page = adzp150_create_name(adzp150_page_trans(g_properties.getValue("general_current_page")), "body", "<<<")
      LET g_dzbb.prog_name   = g_properties.getValue("app_id")
      LET g_dzbb.point_name  = "show.",ls_page,".reference"
      IF g_properties.getValue("type_id") = "i07" THEN
         #i07使用的add-point名稱不同
         LET g_dzbb.point_name  = "ref_show.",ls_page,".reference"
      END IF
      IF g_properties.getValue("type_id") = "i02" THEN
         LET g_dzbb.point_name  = "detail_show.",ls_page,".reference"
      END IF
      LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
      LET g_dzbb.addpoint    = ls_return
      CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))        
   END IF

   RETURN ls_return

END FUNCTION

#+ 生成mnemonic元件
PUBLIC FUNCTION adzp150_create_mnemonic(pn_node,pi_lv,pi_id)
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
   DEFINE ls_page         STRING
   
   #先確定目前所在
   LET ls_loc = g_properties.getValue("location") 
 
   #取得該欄位變數名稱
   LET ls_col = g_properties.getValue("column") 
   IF ls_loc = "head" THEN
      LET ls_var = g_properties.getValue("master_var_title"),".",ls_col
   ELSE
      LET ls_var = adzp150_find_page(pn_node.getAttribute("field"),""),".",ls_col
   END IF
   CALL g_properties.addAttribute("mdl_var",ls_var)
 
   #取得table名稱
   LET ls_name = "mdl_tbl"
   LET ls_var  = pn_node.getAttribute("table")
   CALL g_properties.addAttribute(ls_name,ls_var)
   
   #取得wc
   LET ls_name = "mdl_wc"
   LET ls_var = adzp150_replace_var(pn_node.getAttribute("wc"))
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
      LET ls_name = adzp150_create_name(li_idx, "mdl_rtn_var", "<<<")
      IF g_properties.getValue("location") = "head" THEN
         LET ls_var = g_properties.getValue("master_var_title"),".",ls_token
      ELSE
         LET ls_var = adzp150_find_page(ls_token,""),".",ls_token
      END IF
      CALL g_properties.addAttribute(ls_name,ls_var)
   END WHILE
   
   #取得mdl_mdls
   CALL g_properties.addAttribute("mdl_mdls",li_idx)
   
   #呼叫子樣板
   LET ls_return = adzp150_make_slice("a25") 

   #將資料寫進對應的show add-point
   #IF ls_loc = "head" THEN
   #   LET g_dzbb.prog_name   = g_properties.getValue("app_id")
   #   LET g_dzbb.point_name  = "show.head.reference"
   #   IF g_properties.getValue("type_id") = "i07" THEN
   #      #i07使用的add-point名稱不同
   #      LET g_dzbb.point_name  = "ref_show.head.reference"
   #   END IF
   #   LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
   #   LET g_dzbb.addpoint    = ls_return
   #   CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))     
   #ELSE
   #   LET ls_page = adzp150_create_name(adzp150_page_trans(g_properties.getValue("general_current_page")), "body", "<<<")
   #   LET g_dzbb.prog_name   = g_properties.getValue("app_id")
   #   LET g_dzbb.point_name  = "show.",ls_page,".reference"
   #   IF g_properties.getValue("type_id") = "i07" THEN
   #      #i07使用的add-point名稱不同
   #      LET g_dzbb.point_name  = "ref_show.",ls_page,".reference"
   #   END IF
   #   IF g_properties.getValue("type_id") = "i02" THEN
   #      LET g_dzbb.point_name  = "detail_show.",ls_page,".reference"
   #   END IF
   #   LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
   #   LET g_dzbb.addpoint    = ls_return
   #   CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))        
   #END IF
   
   RETURN ls_return
   
END FUNCTION 

#+ 結合reference到sql
PUBLIC FUNCTION adzp150_reference_join(pdn_node,ps_loc)
   DEFINE pdn_node               om.DomNode
   DEFINE ps_loc                 STRING
   DEFINE ls_ref_field           STRING
   DEFINE ls_map_field           STRING
   DEFINE ls_display_field       STRING
   DEFINE ls_all_display_field   STRING
   DEFINE ls_fetch_field         STRING
   DEFINE ls_field               STRING
   DEFINE ls_sql                 STRING
   DEFINE ls_join_sql            STRING
   DEFINE ls_table               STRING
   DEFINE ls_table_pre           STRING
   DEFINE ls_wc                  STRING
   DEFINE ls_value               STRING
   DEFINE ls_name                STRING
   DEFINE lst_token              base.StringTokenizer
   DEFINE ls_token               STRING
   DEFINE li_idx                 INTEGER #reference table編號
   DEFINE ls_tbl_idx             STRING  #reference table編號 EX:t1,t2...
   DEFINE ls_tmp                 STRING 
   DEFINE ls_table_name          STRING 
   DEFINE ls_page_idx            STRING 
   DEFINE ls_chk_tbl             STRING 
   DEFINE lb_return              BOOLEAN 
   DEFINE ls_prefix              STRING 
   
   LET ls_prefix = 't0.'
   
   #樹狀的先不處理
   IF g_properties.getValue("type_id") = "i04" OR 
      g_properties.getValue("type_id") = "i05" OR 
      g_properties.getValue("type_id") = "i08" THEN
      LET ls_prefix = ''
   END IF
   
   #i02,t02以外的單身不處理
   IF ps_loc = 'detail' AND 
      g_properties.getValue("type_id") <> "i02" AND
      g_properties.getValue("type_id") <> "t02" THEN
      LET ls_prefix = ''
   END IF
   
   #如果是單身須確定所在table位置(編號)
   IF ps_loc = 'detail' THEN
      LET ls_page_idx = g_properties.getValue("page_location"),','
      FOR li_idx = 1 TO g_properties.getValue("detail_tbl_cnt")
         LET ls_name = adzp150_create_name(li_idx, "detail_tbl_pages", "<<<")
         LET ls_value = g_properties.getValue(ls_name),','
         IF ls_value.getIndexOf(ls_page_idx,1) THEN
            LET ls_table_name = li_idx USING "<<<"
            EXIT FOR
         END IF
      END FOR
   ELSE
      LET ls_table_name = '1'
   END IF
   
   #被參照的欄位-畫面欄位名稱(ref_field)
   LET ls_ref_field = pdn_node.getAttribute("ref_field")
   LET ls_ref_field = adzp150_ent_filter(ls_ref_field)
   
   #被參照的欄位-實際欄位名稱(map_field)
   LET ls_map_field = pdn_node.getAttribute("map_field")
   IF cl_null(ls_map_field) THEN
      LET ls_map_field = ls_ref_field
   END IF
   LET ls_map_field = adzp150_ent_filter(ls_map_field)
   
   #如果被參照的欄位非主table欄位, 不做處理
   CASE ps_loc 
      WHEN "master"
         LET ls_chk_tbl = g_properties.getValue("master_tbl_name")
      WHEN "detail"
         LET ls_name = adzp150_create_name(ls_table_name, "detail_tbl_name_by_tbl", "<<<")
         LET ls_chk_tbl = g_properties.getValue(ls_name)
      WHEN "browser"
         LET ls_chk_tbl = g_properties.getValue("master_tbl_name")
   END CASE
   
   LET lb_return = FALSE
   
   #檢查該欄位是否存在於對應的主table中
   LET lst_token = base.StringTokenizer.create(ls_map_field, ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF NOT cl_getField(ls_chk_tbl, ls_token) THEN
         LET ls_tmp = g_properties.getValue("genereal_error_message"), '\n',
                      'WARNING(18):',pdn_node.getAttribute("field"),'對應傳值設定欄位(',ls_token,')不存在於畫面欄位或主要table中, 將不進行SQL組合處理!'
         CALL g_properties.addAttribute("genereal_error_message",ls_tmp)
         LET lb_return = TRUE
      END IF
   END WHILE
   
   #檢查該欄位數量是否一致(依附控件名稱-ref_field,對應傳值設定-map_field)
   IF adzp150_getField_cnt(ls_map_field) <> adzp150_getField_cnt(ls_ref_field) THEN
      LET ls_tmp = g_properties.getValue("genereal_error_message"), '\n',
                   'ERROR(19):',pdn_node.getAttribute("field"),'欄位參考設定"依附控件名稱"與"對應傳值設定"設定數量不一致!'
      CALL g_properties.addAttribute("genereal_error_message",ls_tmp)
      LET lb_return = TRUE
   END IF

   #回填到畫面上的欄位(field)
   LET ls_display_field = pdn_node.getAttribute("field")
   
   #如果已處理過
   LET ls_name = "general_all_reference"   
   LET ls_value = g_properties.getValue(ls_name), "(",ps_loc,"),"
   LET ls_all_display_field = ls_value
   LET ls_tmp = ls_display_field, "(",ps_loc,"),",ls_ref_field,","
   IF ls_all_display_field.getIndexOf(ls_tmp,1) > 0 THEN
      RETURN
   ELSE
      LET ls_value = ls_all_display_field, ls_tmp
      CALL g_properties.addAttribute(ls_name,ls_value)
   END IF
   
   #參照的sql(ref_sql)
   LET ls_sql = pdn_node.getAttribute("ref_sql")
   
   #先取得該table編號
   LET ls_name = ps_loc,"_reference_table"
   LET ls_value = g_properties.getValue(ls_name)
   IF cl_null(ls_value) THEN
      LET li_idx = 1
   ELSE
      LET li_idx = ls_value + 1
   END IF
   LET ls_value = li_idx USING "<<<"
   LET ls_tbl_idx = "t", li_idx USING "<<<"
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #接到sql的left join
   #先截出table
   LET ls_table = ls_sql.subString(ls_sql.getIndexOf('FROM',1)+5, ls_sql.getIndexOf('WHERE',1)-1)
   LET ls_table_pre = ls_table.subString(1,ls_table.getIndexOf('_',1)-1)
   #再截出wc(並將table做取代)
   LET ls_wc = ls_sql.subString(ls_sql.getIndexOf('WHERE',1)+6,ls_sql.getLength())
   LET ls_tmp = ls_tbl_idx,'.',ls_table_pre
   LET ls_wc = cl_replace_str(ls_wc,ls_table_pre,ls_tmp)
   #將wc中的?取代為ref_field
   LET lst_token = base.StringTokenizer.create(ls_map_field, ',')
   CALL cl_str_replace_once()
   WHILE lst_token.hasMoreTokens()
      LET ls_token = ls_prefix,lst_token.nextToken()
      #判斷是否設定過少的"?"
      IF ls_wc.getIndexOf('?',1) = 0 THEN
         LET ls_tmp = g_properties.getValue("genereal_error_message"), '\n',
                      'ERROR(20):',pdn_node.getAttribute("field"),'欄位參考FK數量過少!'
         CALL g_properties.addAttribute("genereal_error_message",ls_tmp)
         LET lb_return = TRUE
      END IF
      LET ls_wc = cl_replace_str(ls_wc,'?',ls_token)
   END WHILE
   #判斷是否設定過多的"?"
   IF ls_wc.getIndexOf('?',1) > 0 THEN
      LET ls_tmp = g_properties.getValue("genereal_error_message"), '\n',
                   'ERROR(21):',pdn_node.getAttribute("field"),'欄位參考FK數量過多!'
      CALL g_properties.addAttribute("genereal_error_message",ls_tmp)
      LET lb_return = TRUE
   END IF
   CALL cl_str_replace_init()
   
   #若設定有錯誤則中止處理
   IF lb_return THEN
      RETURN
   END IF
   
   #接到select後的欄位名稱(browser_reference_select_field)
   #從sql中擷取出要撈出的欄位
   LET ls_field = ls_sql.subString(ls_sql.getIndexOf('SELECT',1)+7,ls_sql.getIndexOf('FROM',1)-1)
   LET ls_name = ps_loc,"_reference_select_field"   
   LET ls_name = adzp150_create_name(ls_table_name, ls_name, "<<<")
   LET ls_value = g_properties.getValue(ls_name)
   LET ls_value = ls_value, ',', ls_tbl_idx, '.', ls_field
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #回寫到g_properties
   LET ls_join_sql = "               \" LEFT JOIN ", ls_table, ls_tbl_idx, " ON ", adzp150_replace_var(ls_wc)," \","
   LET ls_name = ps_loc,"_reference_join_sql"  
   LET ls_name = adzp150_create_name(ls_table_name, ls_name, "<<<")
   LET ls_value = g_properties.getValue(ls_name)
   #IF cl_null(ls_value) THEN
   #   LET ls_value = "#",ps_loc,"段落JOIN!\n"
   #END IF
   LET ls_value = ls_value, ls_join_sql ,'\n'
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #接到foreach後的變數名稱
   LET lst_token = base.StringTokenizer.create(ls_display_field, ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      #確定該欄位所在的變數名稱
      CASE ps_loc 
         WHEN "master"
            LET ls_tmp = ',',g_properties.getValue("master_var_title"),'.'
         WHEN "detail"
            #先確定在哪個page
            LET ls_tmp = ',',adzp150_find_page(ls_display_field,''),'.'
         WHEN "browser"
            LET ls_tmp = ',g_browser[g_cnt].b_'
      END CASE
      LET ls_fetch_field = ls_fetch_field, ls_tmp, ls_token
   END WHILE
   LET ls_name = ps_loc,"_reference_fetch_field"
   LET ls_name = adzp150_create_name(ls_table_name, ls_name, "<<<")
   LET ls_value = g_properties.getValue(ls_name)
   LET ls_value = ls_value, ls_fetch_field 
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #紀錄browser join使用的table
   IF ps_loc = 'browser' THEN
      LET ls_name = "browser_join_table"
      LET ls_value = g_properties.getValue(ls_name)
      LET ls_value = ls_value, ls_table, ','
      CALL g_properties.addAttribute(ls_name,ls_value)
   END IF
   
   #根據所在位置加到各自變數後(_reference_fetch_field)
   #CASE ps_loc 
   #   WHEN "master" #master_vars_all
   #      LET ls_name = "master_vars_all"
   #      LET ls_value = g_properties.getValue(ls_name), ',', ls_value
   #      CALL g_properties.addAttribute(ls_name,ls_value)
   #   
   #   WHEN "detail" #detail_vars_all_by_tbl
   #      LET ls_name = adzp150_create_name(ls_table_name, "detail_vars_all_by_tbl", "<<<")
   #      LET ls_value = g_properties.getValue(ls_name), ',', ls_value
   #      CALL g_properties.addAttribute(ls_name,ls_value)
   #      
   #   WHEN "browser" #browser_vars_all
   #      LET ls_name = "browser_vars_all"
   #      LET ls_value = g_properties.getValue(ls_name), ',', ls_value
   #      CALL g_properties.addAttribute(ls_name,ls_value)
   #END CASE
   
END FUNCTION

#+ 計算欄位數量(比較用)
PUBLIC FUNCTION adzp150_getField_cnt(ps_list)
   DEFINE ps_list                STRING
   DEFINE lst_token              base.StringTokenizer
   DEFINE ls_token               STRING
   DEFINE li_cnt                 INTEGER
   
   LET lst_token = base.StringTokenizer.create(ps_list, ',')
   LET li_cnt = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET li_cnt = li_cnt + 1
   END WHILE
   
   RETURN li_cnt
   
END FUNCTION 

#+ 濾除ent欄位
PUBLIC FUNCTION adzp150_ent_filter(ps_list)
   DEFINE ps_list                STRING
   DEFINE lst_token              base.StringTokenizer
   DEFINE ls_token               STRING
   DEFINE ls_return              STRING
   
   LET lst_token = base.StringTokenizer.create(ps_list, ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF ls_token.subString(ls_token.getLength()-2,ls_token.getLength()) <> 'ent' THEN
         LET ls_return = ls_return, ls_token, ','
      END IF
   END WHILE
   LET ls_return = ls_return.subString(1,ls_return.getLength()-1)
   
   RETURN ls_return
   
END FUNCTION 

#+ 增加主表欄位代名(field list)
PUBLIC FUNCTION adzp150_add_table_name(ps_field,ps_loc)
   DEFINE ps_field        STRING
   DEFINE ps_loc          STRING
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_token        STRING
   DEFINE ls_return       STRING
   
   IF ps_loc = 'd' AND 
      (
      g_properties.getValue("type_id") = "i04" OR 
      g_properties.getValue("type_id") = "i07" OR 
      g_properties.getValue("type_id") = "i08" OR 
      g_properties.getValue("type_id") = "t01"  
      ) THEN
      RETURN ps_field
   END IF
   
   LET lst_token = base.StringTokenizer.create(ps_field, ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
    
      IF NOT cl_null(ls_token) AND NOT ls_token.getIndexOf("'",1) > 0 THEN
         LET ls_return = ls_return, 't0.', ls_token, ','
      ELSE
         IF ls_token.getIndexOf("'",1) = 0 THEN
            LET ls_return = ls_return, ls_token, ','
         END IF
      END IF
      
   END WHILE
   
   LET ls_return = ls_return.subString(1,ls_return.getLength()-1)
   
   RETURN ls_return

END FUNCTION 

#+ 增加主表欄位代名(wc list)
PUBLIC FUNCTION adzp150_add_table_name_wc(ps_wc,ps_loc)
   DEFINE ps_wc           STRING
   DEFINE ps_loc          STRING
   DEFINE ls_wc           STRING
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_token        STRING
   DEFINE ls_return       STRING
   
   IF ps_loc = 'd' AND 
      (g_properties.getValue("type_id") = "i04" OR 
       g_properties.getValue("type_id") = "i07" OR 
       g_properties.getValue("type_id") = "i08" OR 
       g_properties.getValue("type_id") = "t01" ) THEN
      RETURN ps_wc
   END IF
   
   #先截掉WHERE
   LET ls_wc = ps_wc.subString(ps_wc.getIndexOf('WHERE',1)+6,ps_wc.getLength())
   
   #重組WHERE條件(加入t0)
   LET lst_token = base.StringTokenizer.create(ls_wc, 'AND')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF ls_token.getIndexOf('1=1',1) = 0 AND ls_token.getIndexOf('1 = 1',1) = 0 THEN
         LET ls_return = ls_return, 't0.', ls_token, ' AND '
      ELSE
         LET ls_return = ls_return, ls_token, ' AND '
      END IF
   END WHILE
    
   LET ls_return = ' WHERE ', ls_return.subString(1,ls_return.getLength()-5)
   
   RETURN ls_return

END FUNCTION 
