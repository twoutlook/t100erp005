#adzp152 副程式 - 多語言相關處理
# Modify........: No:YSC-E60003 14/07/16 By joyce 增加資料遮罩功能

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
END GLOBALS


DEFINE g_dzbb RECORD 
         prog_name    STRING,
         point_name   STRING,
         point_ver    STRING,
         addpoint     STRING
         END RECORD
         
DEFINE g_detail om.SaxAttributes
         
DEFINE gs_wc           STRING #wc sql
DEFINE gi_m_keycnt     INTEGER
DEFINE gb_site         BOOLEAN
DEFINE gb_ent          BOOLEAN
DEFINE ga_lang_field   DYNAMIC ARRAY OF STRING

#+ 單頭多table處理
PUBLIC FUNCTION adzp152_master_multi_table(p_node)
   DEFINE p_node           om.DomNode
   DEFINE ls_ref_table     STRING
   DEFINE ls_ref_field     STRING
   DEFINE ls_ref_ent       STRING
   DEFINE ls_ref_var       STRING
   DEFINE ls_ref_wc        STRING
   DEFINE ls_ref           STRING
   DEFINE ls_sel_sql       STRING
   DEFINE ls_key_var       STRING
   DEFINE ls_rtn_var       STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE ls_type          STRING
   DEFINE ls_key_num       STRING
   DEFINE ls_tmp           STRING
   DEFINE li_idx           INTEGER
   
   #非多語言特別處理
   IF p_node.getAttribute("type") <> 'lang' THEN
      LET p_node = adzp152_other_change(p_node,'m','')
   END IF
   
   #過濾target欄位
   LET p_node = adzp152_target_filter(p_node)
   
   #濾除fk的ent
   LET p_node = adzp152_entperise_filter(p_node)
   
   #調整fk的固定值
   LET p_node = adzp152_static_change(p_node,'m')
   
   #取得多table之table名稱
   LET ls_ref_table = p_node.getAttribute("table")
   
   #取得多table之欄位名稱
   LET ls_ref_field = p_node.getAttribute("field")
   
   #取得key變數(多個), key數量
   LET ls_key_num = g_properties.getValue("master_pk_num")
   
   #取得key變數
   LET ls_key_var = ""
   LET lst_token = base.StringTokenizer.create(p_node.getAttribute("fk"), ',')
   LET li_idx = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET li_idx = li_idx + 1
      LET ls_tmp = li_idx USING "<<<"
      IF ls_token.getIndexOf('master_lang_field',1) THEN
         LET ls_token = g_properties.getValue(ls_token)
      ELSE
         LET ls_token = g_properties.getValue("master_var_title"),'.', ls_token
      END IF
      LET ls_key_var = ls_key_var, "   LET g_ref_fields[",ls_tmp,"] = ",ls_token, "\n"
   END WHILE
   
   #取得回傳變數
   LET ls_rtn_var = ""
   LET lst_token = base.StringTokenizer.create(p_node.getAttribute("target"), ',')
   LET li_idx = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = g_properties.getValue("master_var_title"),".", lst_token.nextToken()
      LET li_idx = li_idx + 1
      LET ls_tmp = li_idx USING "<<<"
      LET ls_rtn_var = ls_rtn_var, "   LET ",ls_token, " = g_rtn_fields[",ls_tmp,"] \n"
   END WHILE
   
   #取得多table之變數名稱
   LET lst_token = base.StringTokenizer.create(p_node.getAttribute("target"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_ref_var = ls_ref_var,
          g_properties.getValue("master_var_title"),'.',ls_token
      IF lst_token.hasMoreTokens() THEN
         LET ls_ref_var = ls_ref_var, ','
      END IF
   END WHILE
   
   #確定type為何
   LET ls_type = p_node.getAttribute("type")
   CASE ls_type
   
      WHEN "lang"
         LET lst_token = base.StringTokenizer.create(p_node.getAttribute("pk"), ',')
         WHILE lst_token.hasMoreTokens()
            LET ls_token = lst_token.nextToken()
            IF lst_token.hasMoreTokens() THEN
               LET ls_ref_wc = ls_ref_wc, ls_token, " = ? AND "
            ELSE
               LET ls_ref_wc = ls_ref_wc, ls_token, " = '\"||g_dlang||\"'"
            END IF
         END WHILE
         
         #多語言助記碼查詢功能
         CALL adzp152_create_mcode_info('m',
                                        g_properties.getValue("master_tbl_name"),
                                        g_properties.getValue("master_field_pk01"),
                                        ls_ref_table,
                                        ls_key_num)
         
      WHEN "single"
         LET lst_token = base.StringTokenizer.create(p_node.getAttribute("pk"), ',')
         WHILE lst_token.hasMoreTokens()
            LET ls_token = lst_token.nextToken()
            IF lst_token.hasMoreTokens() THEN
               LET ls_ref_wc = ls_ref_wc, ls_token, " = ? AND "
            ELSE
               LET ls_ref_wc = ls_ref_wc, ls_token, " = ? "
            END IF
         END WHILE

      WHEN "common"
         LET lst_token = base.StringTokenizer.create(p_node.getAttribute("pk"), ',')
         WHILE lst_token.hasMoreTokens()
            LET ls_token = lst_token.nextToken()
            IF lst_token.hasMoreTokens() THEN
               LET ls_ref_wc = ls_ref_wc, ls_token, " = ? AND "
            ELSE
               LET ls_ref_wc = ls_ref_wc, ls_token, " = ? "
            END IF
         END WHILE
         
      OTHERWISE
         DISPLAY "ERROR:目前append屬性不支援",ls_type,"類型"
         
   END CASE
   
   #若有ent則在wc最前頭補上
   LET ls_ref_ent = ls_ref_table.subString(1,ls_ref_table.getIndexOf("_",1)-1),"ent"
   IF cl_getField(ls_ref_table CLIPPED, ls_ref_ent CLIPPED) THEN
      LET ls_ref_wc = ls_ref_ent, " = '\"||g_enterprise||\"' AND ", ls_ref_wc
   END IF
   
   #產出join段落
   CALL adzp152_append_join(p_node,'m',ls_ref_table,p_node.getAttribute("pk"),ls_type, '', '', '')
  
   #組合ref所需資料
   LET ls_sel_sql = " SELECT ",ls_ref_field," FROM ",ls_ref_table, " WHERE ",ls_ref_wc
   LET ls_ref = g_properties.getValue("master_vars_reference")
   LET ls_ref = ls_ref, "\n",
                "   INITIALIZE g_ref_fields TO NULL\n",
                ls_key_var,
                "   LET ls_sql = \"",ls_sel_sql,"\"\n",  #YSC-E60003
                "   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料","\n",   #YSC-E60003
             #  "   CALL ap_ref_array2(g_ref_fields,\"",ls_sel_sql,"\",\"\") RETURNING g_rtn_fields \n",   #YSC-E60003 mark
                "   CALL ap_ref_array2(g_ref_fields,ls_sql,\"\") RETURNING g_rtn_fields \n",   #YSC-E60003
                ls_rtn_var,
                "   DISPLAY ",ls_ref_var, " TO ", p_node.getAttribute("target")
   

   CALL g_properties.addAttribute("master_vars_reference",ls_ref)

END FUNCTION

#+ 多table資料更動
PUBLIC FUNCTION adzp152_master_multi_table_upd(p_node)
   DEFINE p_node           om.DomNode
   DEFINE ls_ref_table     STRING
   DEFINE ls_key_field     STRING
   DEFINE ls_field         STRING
   DEFINE ls_ref_var       STRING
   DEFINE ls_ref_wc        STRING
   DEFINE ls_ref           STRING
   DEFINE ls_sel_sql       STRING
   DEFINE ls_key_var       STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE lst_token2       base.StringTokenizer
   DEFINE ls_token2        STRING
   DEFINE ls_type          STRING
   DEFINE ls_tmp           STRING
   DEFINE ls_var           STRING
   DEFINE ls_var2          STRING
   DEFINE ls_title         STRING
   DEFINE ls_chk           STRING
   DEFINE ls_table_pre     STRING
   DEFINE ls_common_field  DYNAMIC ARRAY OF STRING
   DEFINE ls_common_var    DYNAMIC ARRAY OF STRING
   DEFINE li_keys          INTEGER
   DEFINE li_idx           INTEGER
   DEFINE li_idx2          INTEGER
   DEFINE ls_idx           STRING
   DEFINE li_space         INTEGER
   DEFINE ls_return        STRING
   DEFINE ls_return_delete STRING   
   
   #判斷是第幾個多語言table
   IF g_properties.getValue("master_multi_table_idx") = 1 THEN
      LET ls_idx = ""
   ELSE
      LET ls_idx = "_idx", g_properties.getValue("master_multi_table_idx")
   END IF
   
   LET li_space = 9
   LET li_idx = 1
   
   #取得單頭title名稱
   LET ls_title = g_properties.getValue("master_var_title")
   
   #取得多table之table名稱
   LET ls_ref_table = p_node.getAttribute("table")
   
   #取得多table之key欄位名稱
   LET ls_key_field = p_node.getAttribute("pk")
   
   #取得多table之一般欄位名稱
   LET ls_field = p_node.getAttribute("field")
   
   #取得類型
   LET ls_type = p_node.getAttribute("type")
   
   #取得多table之key名稱及內容
   LET lst_token = base.StringTokenizer.create(ls_key_field, ',')
   LET lst_token2 = base.StringTokenizer.create(p_node.getAttribute("fk"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      LET ls_tmp = li_idx USING "&&"
      
      IF NOT lst_token.hasMoreTokens() AND ls_type = "lang" THEN
         LET ls_var = "g_dlang"
         LET ls_var2 = "g_dlang"
      ELSE
         IF ls_token2.getIndexOf('master_lang_field',1) THEN
            LET ls_var = g_properties.getValue(ls_token2)
         ELSE
            LET ls_var = g_properties.getValue("master_var_title"),'.',ls_token2
         END IF
         LET ls_var2 = "g_master_multi_table_t.",ls_token
         LET ls_chk = ls_chk, li_space SPACES, ls_var, " = ", ls_var2,ls_idx, " AND\n"
      END IF
      
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_var_keys[",ls_tmp,"] = ", ls_var, "\n"

      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_field_keys[",ls_tmp,"] = '",ls_token,"'\n"
      
      IF ls_var2 = 'g_dlang' THEN
         LET ls_return = ls_return, (li_space+3) SPACES, 
                         "LET l_var_keys_bak[",ls_tmp,"] = ",ls_var2,"\n"
         LET ls_return_delete = ls_return_delete, 3 SPACES,  
                                "LET l_var_keys_bak[",ls_tmp,"] = ",ls_var2,"\n"
      ELSE
         LET ls_return = ls_return, (li_space+3) SPACES, 
                         "LET l_var_keys_bak[",ls_tmp,"] = ",ls_var2, ls_idx,"\n"
         LET ls_return_delete = ls_return_delete, 3 SPACES,  
                                "LET l_var_keys_bak[",ls_tmp,"] = ",ls_var2, ls_idx,"\n" 
      END IF
      
      LET ls_return_delete = ls_return_delete, 3 SPACES,  
                             "LET l_field_keys[",ls_tmp,"] = '",ls_token,"'\n"    
         
                      
      LET li_idx = li_idx + 1

   END WHILE
   
   LET li_idx = 1
   
   #取得多table之一般欄位名稱及內容
   LET lst_token = base.StringTokenizer.create(p_node.getAttribute("target"), ',')
   LET lst_token2 = base.StringTokenizer.create(p_node.getAttribute("field"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      LET ls_tmp = li_idx USING "&&"
      
      LET ls_var = g_properties.getValue("master_var_title"),".",ls_token
      LET ls_var2 = "g_master_multi_table_t.",ls_token
      
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_vars[",ls_tmp,"] = ", ls_var, "\n"

      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_fields[",ls_tmp,"] = '",ls_token2,"'\n"
                      
      LET ls_chk = ls_chk, li_space SPACES, ls_var, " = ",ls_var2,ls_idx, " AND \n"                   
                      
      LET li_idx = li_idx + 1

   END WHILE
   
   LET li_idx = li_idx - 1
   
   LET ls_table_pre = adzp152_get_table_pre(ls_ref_table)
   
   #確定有共用欄位*8
   IF ls_type = "common" THEN
      
      #LET ls_common_field[1] = ls_table_pre, "user"
      #LET ls_common_field[2] = ls_table_pre, "dept"
      #LET ls_common_field[3] = ls_table_pre, "buid"
      #LET ls_common_field[4] = ls_table_pre, "oriu"
      #LET ls_common_field[5] = ls_table_pre, "orid"
      #LET ls_common_field[6] = ls_table_pre, "modu"
      #LET ls_common_field[7] = ls_table_pre, "date"
      #LET ls_common_field[8] = ls_table_pre, "stus"
      
      LET ls_common_var[1] = "g_user"
      LET ls_common_var[2] = "g_dept"
      LET ls_common_var[3] = "\"to_date('\",cl_get_current(),\"','YYYY-MM-DD HH24:MI:SS')\""
      LET ls_common_var[4] = "g_user"
      LET ls_common_var[5] = "g_dept"
      LET ls_common_var[6] = "g_user"
      LET ls_common_var[7] = "\"to_date('\",cl_get_current(),\"','YYYY-MM-DD HH24:MI:SS')\""
      LET ls_common_var[8] = "'Y'"
      
      FOR li_idx2 = li_idx TO li_idx + 7
         LET ls_tmp = li_idx2 USING "&&"
         LET ls_return = ls_return, (li_space+3) SPACES, 
                         "LET l_vars[",ls_tmp,"] = ", ls_common_var[(li_idx2-li_idx+1)], "\n"
         LET ls_return = ls_return, (li_space+3) SPACES, 
                         "LET l_fields[",ls_tmp,"] = '",ls_common_field[(li_idx2-li_idx+1)],"'\n"
      END FOR
      LET li_idx = li_idx2
   END IF
   
   #確定是否有site
   LET ls_field = ls_table_pre, "site"
   IF cl_getField(ls_ref_table,ls_field) THEN
         LET li_idx = li_idx + 1
      LET ls_tmp = li_idx USING "&&"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_vars[",ls_tmp,"] = g_site \n"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_fields[",ls_tmp,"] = '",ls_field,"'\n"
   END IF
   
   #確定是否有enterprise
   LET ls_field = ls_table_pre, "ent"
   IF cl_getField(ls_ref_table,ls_field) THEN
         LET li_idx = li_idx + 1
      LET ls_tmp = li_idx USING "&&"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_vars[",ls_tmp,"] = g_enterprise \n"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_fields[",ls_tmp,"] = '",ls_field,"'\n"
   END IF
   
   LET ls_return = ls_return, (li_space+3) SPACES, 
                   "CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'",ls_ref_table,"')\n"
   
   #進行資料確認, 若資料沒有異動則不做任何處理
   LET ls_return = li_space SPACES, "IF ",
                                    ls_chk.subString(10,ls_chk.getLength()-5), " THEN\n",
                   li_space SPACES, "ELSE \n",                
                                    ls_return, 
                   li_space SPACES, "END IF \n "
    
   #先將array清空    
   LET ls_return = li_space SPACES, "INITIALIZE l_var_keys TO NULL \n",         
                   li_space SPACES, "INITIALIZE l_field_keys TO NULL \n",     
                   li_space SPACES, "INITIALIZE l_vars TO NULL \n",           
                   li_space SPACES, "INITIALIZE l_fields TO NULL \n",      
                                    ls_return
   
   LET ls_return = g_properties.getValue("master_multi_language"), ls_return
   CALL g_properties.addAttribute("master_multi_language", ls_return)

   #產生delete段落
   LET ls_return_delete = "INITIALIZE l_var_keys_bak TO NULL \n",    
                          3 SPACES, "INITIALIZE l_field_keys   TO NULL \n",
                          ls_return_delete,
                          3 SPACES, "CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'",ls_ref_table,"')\n"
   #暫時先不提供產生器產出刪除多語言段落
   LET ls_return_delete = ""
   CALL g_properties.addAttribute("master_multi_table_delete", ls_return_delete)
   
END FUNCTION

#+ 多table資料備份
PUBLIC FUNCTION adzp152_master_multi_table_bak(p_node)
   DEFINE p_node           om.DomNode
   DEFINE ls_field_define  STRING
   DEFINE ls_key_fields    STRING
   DEFINE ls_all_fields    STRING
   DEFINE ls_table_name    STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE lst_token2       base.StringTokenizer
   DEFINE ls_token2        STRING
   DEFINE ls_title         STRING
   DEFINE ls_bak           STRING
   DEFINE ls_clear         STRING
   DEFINE li_idx           INTEGER
   DEFINE ls_idx           STRING
   
   #判斷是第幾個多語言table
   IF g_properties.getValue("master_multi_table_idx") = 1 THEN
      LET ls_idx = ""
   ELSE
      LET ls_idx = "_idx", g_properties.getValue("master_multi_table_idx")
   END IF
   
   LET ls_field_define = g_properties.getValue("master_multi_table_define")
   LET ls_bak = g_properties.getValue("master_multi_table_bak")
   LET ls_clear = g_properties.getValue("master_multi_table_clear")
   
   LET ls_key_fields = p_node.getAttribute("pk")
   LET ls_all_fields = p_node.getAttribute("target")
                       
   LET ls_title = g_properties.getValue("master_var_title")
   
   #IF cl_null(ls_bak) AND cl_null(ls_field_define) THEN
      LET lst_token = base.StringTokenizer.create(ls_key_fields, ',')      
      LET lst_token2 = base.StringTokenizer.create(p_node.getAttribute("fk"), ',')      
      WHILE lst_token.hasMoreTokens() AND lst_token2.hasMoreTokens() 
         LET ls_token = lst_token.nextToken()
         LET ls_token2 = lst_token2.nextToken()
         LET ls_table_name = adzp152_define_table_name(ls_token)

         LET ls_field_define = ls_field_define, "      ", ls_token, ls_idx, " LIKE ",ls_table_name, ls_token, ",\n"
         
         #資料備份段落
         IF ls_token2.getIndexOf('master_lang_field',1) THEN
            LET ls_bak = ls_bak, "LET g_master_multi_table_t.", ls_token, ls_idx, " = ", g_properties.getValue(ls_token2), "\n" 
         ELSE
            LET ls_bak = ls_bak, "LET g_master_multi_table_t.", ls_token, ls_idx, " = ", ls_title, ".", ls_token2, "\n" 
         END IF
         
         #清空
         LET ls_clear = ls_clear, "LET g_master_multi_table_t.", ls_token, ls_idx, " = ''\n" 
      END WHILE
   #END IF
   
   #欄位定義
   LET lst_token = base.StringTokenizer.create(ls_all_fields, ',')                   
   LET lst_token2 = base.StringTokenizer.create(p_node.getAttribute("field"), ',')                   
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      
      #資料定義段落
      LET ls_table_name = adzp152_define_table_name(ls_token2)

      LET ls_field_define = ls_field_define, "      ", ls_token,ls_idx , " LIKE ",ls_table_name, ls_token2, ",\n"
      
      #資料備份段落
      LET ls_bak = ls_bak, "LET g_master_multi_table_t.", ls_token,ls_idx , " = ", ls_title, ".", ls_token, "\n"
      
      #清空
      LET ls_clear = ls_clear, "LET g_master_multi_table_t.", ls_token, ls_idx, " = ''\n" 
   END WHILE
   
   CALL g_properties.addAttribute("master_multi_table_define", ls_field_define)
   
   #實際備份程式段落
   CALL g_properties.addAttribute("master_multi_table_bak", ls_bak)
   #實際清空程式段落
   CALL g_properties.addAttribute("master_multi_table_clear", ls_clear)
   
END FUNCTION

#+ 單身多table統一處理入口
PUBLIC FUNCTION adzp152_detail_multi_table(p_node,ps_master,ps_master_pk,ps_idx,ps_pk)
   DEFINE p_node        om.DomNode
   DEFINE ps_master     STRING
   DEFINE ps_master_pk  STRING
   DEFINE ps_idx        STRING
   DEFINE ps_pk         STRING
   DEFINE ls_tmp        STRING
   DEFINE ls_page       STRING
   DEFINE ls_page2      STRING
   DEFINE ls_page_num   STRING
   DEFINE ls_idx        STRING
   DEFINE li_idx        INTEGER
   DEFINE li_idx2       INTEGER
   DEFINE li_tmp        INTEGER
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   DEFINE lst_token2    base.StringTokenizer
   DEFINE ls_token2     STRING
   DEFINE lst_token3    base.StringTokenizer
   DEFINE ls_token3     STRING
   
   #非多語言特別處理
   IF p_node.getAttribute("type") <> 'lang' THEN
      LET p_node = adzp152_other_change(p_node,'d',ps_pk)
   END IF
   
   #調整fk的固定值
   LET p_node = adzp152_static_change(p_node,'d')
   
   #過濾target欄位
   LET p_node = adzp152_target_filter(p_node)
   
   #濾除fk的ent
   LET p_node = adzp152_entperise_filter(p_node)

   #變數初始化
   LET g_detail = om.SaxAttributes.create()

   #取得append類型, Y(單頭key+本身key)/N(單頭key+單身key)
   #LET ls_tmp = p_node.getAttribute("unique")
   LET ls_tmp = "N"
   CALL g_detail.addAttribute("detail_append_unique", ls_tmp)

   #取得table名稱
   LET ls_tmp = p_node.getAttribute("table")
   CALL g_detail.addAttribute("detail_append_table", ls_tmp)
   
   #取得table前置代碼
   LET ls_tmp = adzp152_get_table_pre(ls_tmp)
   CALL g_detail.addAttribute("detail_append_table_pre", ls_tmp)
   
   #取得table類型, common(一般table有共用欄位)
   #               single(一般table無共用欄位)
   #               lang  (多語言table)
   LET ls_tmp = p_node.getAttribute("type")
   CALL g_detail.addAttribute("detail_append_type", ls_tmp)
   
   #取得pkey欄位
   LET ls_tmp = p_node.getAttribute("pk")
   CALL g_detail.addAttribute("detail_append_pk", ls_tmp)
   
   #取得fkey欄位
   LET ls_tmp = p_node.getAttribute("fk")
   CALL g_detail.addAttribute("detail_append_fk", ls_tmp)
   
   #取得key欄位數量
   LET lst_token = base.StringTokenizer.create(ls_tmp, ',')
   LET li_tmp = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET li_tmp = li_tmp + 1
   END WHILE
   IF g_detail.getValue("detail_append_type") = "lang" THEN
      LET li_tmp = li_tmp - 1
   END IF
   CALL g_detail.addAttribute("detail_append_pk_num", li_tmp)
   
   #取得一般欄位
   LET ls_tmp = p_node.getAttribute("field")
   CALL g_detail.addAttribute("detail_append_field", ls_tmp)
   
   #取得一般欄位(目標)
   LET ls_tmp = p_node.getAttribute("target")
   CALL g_detail.addAttribute("detail_append_target", ls_tmp)
   
   #取得一般欄位所在頁面
   LET li_idx2 = g_properties.getValue("page")
   FOR li_idx = 1 TO li_idx2
      LET ls_tmp = "detail_field_loc",li_idx USING "<<<"
      LET ls_tmp = g_properties.getValue(ls_tmp)
      IF ls_tmp.getIndexOf(g_detail.getValue("detail_append_table_pre"),1) > 0 THEN
         LET ls_page = li_idx USING "<<<"
         EXIT FOR
      END IF
   END FOR
   
   CALL g_detail.addAttribute("detail_append_page_num", ls_page)
   LET ls_page_num = ls_page
   IF ls_page = "1" THEN
      LET ls_page = g_properties.getValue("detail_var_title")
   ELSE
      LET ls_page = g_properties.getValue("detail_var_title"||ls_page)
   END IF

   CALL g_detail.addAttribute("detail_append_page", ls_page)
   
   #取得所有欄位變數名稱(g_detail_d[l_ac].xxx)
   #先取得key欄位的
   LET li_idx = 1 
   LET ls_tmp = adzp152_create_name(ps_idx, "detail_field_fks_by_tbl", "<<<")
   LET lst_token3 = base.StringTokenizer.create(g_properties.getValue(ls_tmp), ',')
   LET ls_tmp = ""
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_pk"), ',')
   LET lst_token2 = base.StringTokenizer.create(g_detail.getValue("detail_append_fk"), ',')

   IF g_detail.getValue("detail_append_unique") = "Y" THEN
      WHILE lst_token2.hasMoreTokens()
         LET ls_token = lst_token.nextToken()
         LET ls_token2 = lst_token2.nextToken()
         
         #判斷該fk欄位為單頭/身
         IF adzp152_chk_loc(ls_token2) = 'M' THEN
            #頭
            LET ls_tmp = ls_tmp, g_properties.getValue("master_var_title"),".",ls_token2,","
         ELSE
            #身
            LET ls_tmp = ls_tmp, ls_page,"[l_ac].",ls_token2,","
         END IF
         
      END WHILE
   ELSE
      WHILE lst_token2.hasMoreTokens()
         LET ls_token = lst_token.nextToken()
         LET ls_token2 = lst_token2.nextToken()
         LET ls_token3 = lst_token3.nextToken()
    
         #判斷該fk欄位為單頭/身
         IF adzp152_chk_loc(ls_token2) = 'M' THEN
            #頭
            LET ls_tmp = ls_tmp, g_properties.getValue("master_var_title"),".",ls_token2,","
         ELSE
            #身
            LET ls_page2 = adzp152_find_page(ls_token2,"")
            IF g_properties.getValue(adzp152_create_name(ps_idx, "detail_master_idx", "<<<")) IS NOT NULL AND
               NOT cl_null(ls_token3) THEN
               LET ls_page2 = cl_replace_str(ls_page2,'l_ac','g_detail_idx')
            END IF
            LET ls_tmp = ls_tmp, ls_page2,".",ls_token2,","
         END IF
         
      END WHILE
      #IF ls_page_num = "1" THEN
      #   LET ls_page_num = "detail_var_allkeys"
      #   LET ls_tmp = g_properties.getValue("detail_var_allkeys"),","
      #ELSE
      #   LET ls_page_num = "detail_var_pks",ls_page_num
      #   LET ls_tmp = g_properties.getValue("master_var_allkeys"),",",
      #                g_properties.getValue(ls_page_num),","
      #END IF
   END IF 
   
   IF g_detail.getValue("detail_append_type") = "lang" THEN
      LET ls_tmp = ls_tmp, "g_dlang,"
   ELSE
      LET ls_tmp = ls_tmp.subString(1,ls_tmp.getLength()-1)
   END IF
   CALL g_detail.addAttribute("detail_append_var_pk", ls_tmp)

   
   #取得一般欄位的
   LET ls_tmp = ""
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_target"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_tmp = ls_tmp, ls_page,"[l_ac].",ls_token,","
   END WHILE
   LET ls_tmp = ls_tmp.subString(1,ls_tmp.getLength()-1)
   CALL g_detail.addAttribute("detail_append_var_field", ls_tmp)
   
   #取得所有欄位
   IF g_detail.getValue("detail_append_type") = "lang" THEN
      LET ls_tmp = g_detail.getValue("detail_append_var_pk"),",",
                   g_detail.getValue("detail_append_var_field")
      CALL g_detail.addAttribute("detail_append_var_all", ls_tmp)
   ELSE
      LET ls_tmp = g_detail.getValue("detail_append_var_pk"),",",
                   g_detail.getValue("detail_append_var_field")
      CALL g_detail.addAttribute("detail_append_var_all", ls_tmp)
   END IF
   
   #取得所有欄位備份名稱(g_detail_multi_table_t.xxx)
   
   #先取得key欄位的
   LET ls_tmp = ""
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_pk"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF g_detail.getValue("type") = "lang" AND NOT lst_token.hasMoreTokens() THEN
         LET ls_tmp = ls_tmp, "g_dlang,"
      ELSE
         LET ls_tmp = ls_tmp, "g_detail_multi_table_t.", ls_token, ","
      END IF
   END WHILE
   CALL g_detail.addAttribute("detail_append_key_bak", ls_tmp)
   
   #再取得一般欄位的
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_target"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_tmp = ls_tmp, "g_detail_multi_table_t.", ls_token, ","
   END WHILE
   LET ls_tmp = ls_tmp.subString(1,ls_tmp.getLength()-1)
   CALL g_detail.addAttribute("detail_append_var_bak", ls_tmp)
   
   #取得所有欄位名稱(xxx)
   LET ls_tmp = g_detail.getValue("detail_append_pk"), ",",
                g_detail.getValue("detail_append_field")
   CALL g_detail.addAttribute("detail_append_allfield", ls_tmp)
   
   #取得所有欄位名稱(xxx)
   LET ls_tmp = g_detail.getValue("detail_append_pk"), ",",
                g_detail.getValue("detail_append_target")
   CALL g_detail.addAttribute("detail_append_alltarget", ls_tmp)
   
   #取得所有欄位內容(xxx)
   LET ls_tmp = g_detail.getValue("detail_append_var_pk"), ",",
                g_detail.getValue("detail_append_var_field")

   CALL g_detail.addAttribute("detail_append_allvar", ls_tmp)
   
   #產生reference段落
   IF g_detail.getValue("detail_append_unique") = "Y" THEN
      CALL adzp152_detail_multi_table_ref_unique()
   ELSE
      CALL adzp152_detail_multi_table_ref()
   END IF
   
   #產生資料更新段落
   CALL adzp152_detail_multi_table_upd()

   #產生資料備份段落
   CALL adzp152_detail_multi_table_bak()
   
   #單頭key欄位發生異動
   CALL adzp152_detail_multi_table_key_upd()
   
   #單身key欄位發生異動(for 多單身)
   CALL adzp152_detail_multi_table_detail_key_upd()  

   #join
   CALL adzp152_append_join(p_node,'d',p_node.getAttribute("table"),p_node.getAttribute("pk"),p_node.getAttribute("type"),ps_master,ps_master_pk,ps_idx)   
   
   #單身多語言複製
   CALL adzp152_detail_multi_table_reproduce(p_node) 
   
END FUNCTION

#+ 單身多table處理reference(獨立)
PRIVATE FUNCTION adzp152_detail_multi_table_ref_unique()
   DEFINE ls_ref        STRING
   DEFINE ls_wc         STRING
   DEFINE li_idx        INTEGER
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   DEFINE ls_table      STRING
   DEFINE ls_fields     STRING
   DEFINE ls_vars       STRING
   
   #特殊處理field
   LET li_idx = 1
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_field"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_fields = ls_fields, ls_token, ","
   END WHILE
   LET ls_fields = ls_fields.subString(1,ls_fields.getLength()-1)
   
   #特殊處理var
   LET li_idx = 1
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_var_field"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_vars = ls_vars, ls_token, ","
   END WHILE
   LET ls_vars = ls_vars.subString(1,ls_vars.getLength()-1)
   
   LET ls_table = g_detail.getValue("detail_append_table")
   
   #組合wc
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_var_pk"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_wc = ls_wc, " ", ls_token, " = ? "
      IF lst_token.hasMoreTokens()  THEN
         LET ls_wc = ls_wc, " ", " AND "
      END IF
   END WHILE
   
   LET ls_ref = "   LET l_sql = 'SELECT ",ls_fields,
                                 " FROM ",ls_table,
                                 " WHERE ",ls_wc,
                                 "' \n",
                "   PREPARE ",ls_table,"_pre FROM l_sql \n",
                "   DECLARE ",ls_table,"_cur CURSOR FOR ",ls_table,"_pre \n",
                "   OPEN ",ls_table,"_cur USING ",g_detail.getValue("detail_append_var_pk"),"\n",
                
                "   LET l_ac = 1 \n",
                "   FOREACH ",ls_table,"_cur INTO ",ls_vars," \n",
                "      LET l_ac = l_ac + 1 \n",
                "   END FOREACH \n"
                
   CALL g_properties.addAttribute("detail_vars_reference_unique",ls_ref)
                
END FUNCTION

#+ 單身多table處理reference
PRIVATE FUNCTION adzp152_detail_multi_table_ref()
   DEFINE ls_ref_field     STRING
   DEFINE ls_ref_ent       STRING
   DEFINE ls_ref_var       STRING
   DEFINE ls_ref_wc        STRING
   DEFINE ls_ref           STRING
   DEFINE ls_sel_sql       STRING
   DEFINE ls_key_var       STRING
   DEFINE ls_rtn_var       STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE ls_type          STRING
   DEFINE ls_tmp           STRING
   DEFINE ls_page          STRING
   DEFINE ls_title         STRING
   DEFINE ls_ref_table     STRING
   DEFINE li_idx           INTEGER
   
   #取得頁碼
   LET ls_page = g_detail.getValue("detail_append_page_num")
   IF ls_page = '1' THEN
      LET ls_title = g_properties.getValue("detail_var_title"),"[l_ac]."
   ELSE
      LET ls_title = g_properties.getValue("detail_var_title"||ls_page),"[l_ac]."
   END IF
   
   #取得key變數
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_var_pk"), ',')

   LET li_idx = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET li_idx = li_idx + 1
      IF ls_token.getIndexOf('detail_lang_field',1) THEN
         LET ls_token = ls_token.subString(ls_token.getIndexOf('detail_lang_field',1),ls_token.getLength())
         LET ls_token = g_properties.getValue(ls_token)
      END IF
      IF ls_token.getIndexOf("g_dlang",1) = 0 THEN
         LET ls_tmp = li_idx USING "<<<"
         LET ls_key_var = ls_key_var, "   LET g_ref_fields[",ls_tmp,"] = ", ls_token, "\n"
      END IF
   END WHILE
   
   #取得table
   LET ls_ref_table = g_detail.getValue("detail_append_table")
   
   #取得要撈出的欄位
   LET ls_ref_field = g_detail.getValue("detail_append_target")
   
   #取得回傳變數
   LET ls_rtn_var = ""
   LET lst_token = base.StringTokenizer.create(ls_ref_field, ',')
   LET li_idx = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = ls_title, lst_token.nextToken()
      LET li_idx = li_idx + 1
      LET ls_tmp = li_idx USING "<<<"
      LET ls_rtn_var = ls_rtn_var, "   LET ",ls_token, " = g_rtn_fields[",ls_tmp,"] \n"
   END WHILE
   
   #取得一般欄位
   LET ls_ref_var = g_detail.getValue("detail_append_var_field")
   
   #確定type為何
   LET ls_type = g_detail.getValue("detail_append_type")
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_pk"), ',')
   IF ls_type = "lang" THEN
      WHILE lst_token.hasMoreTokens()
         LET ls_token = lst_token.nextToken()
         IF lst_token.hasMoreTokens() THEN
            LET ls_ref_wc = ls_ref_wc, ls_token, " = ? AND "
         ELSE
            LET ls_ref_wc = ls_ref_wc, ls_token, " = '\"||g_dlang||\"'"
         END IF
      END WHILE
   ELSE      
      WHILE lst_token.hasMoreTokens()
         LET ls_token = lst_token.nextToken()
         IF lst_token.hasMoreTokens() THEN
            LET ls_ref_wc = ls_ref_wc, ls_token, " = ? AND "
         ELSE
            LET ls_ref_wc = ls_ref_wc, ls_token, " = ? "
         END IF
      END WHILE
   END IF
   
   #若有ent則在wc最前頭補上
   LET ls_ref_ent = ls_ref_table.subString(1,ls_ref_table.getIndexOf("_",1)-1),"ent"
   IF cl_getField(ls_ref_table CLIPPED, ls_ref_ent CLIPPED) THEN
      LET ls_ref_wc = ls_ref_ent, " = '\"||g_enterprise||\"' AND ", ls_ref_wc
   END IF
  
   #組合ref所需資料
   LET ls_sel_sql = " SELECT ",g_detail.getValue("detail_append_field")," FROM ",ls_ref_table, " WHERE ",ls_ref_wc
   
   IF ls_page = "1" THEN
      LET ls_ref = g_properties.getValue("detail_vars_reference")
   ELSE
      LET ls_ref = g_properties.getValue("detail_vars_reference"||ls_page)
   END IF

   
   LET ls_ref = ls_ref, "\n",
                "   INITIALIZE g_ref_fields TO NULL \n",
                ls_key_var,
                "   LET ls_sql = \"",ls_sel_sql,"\"\n",   #YSC-E60003
                "   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料","\n",   #YSC-E60003
             #  "   CALL ap_ref_array2(g_ref_fields,\"",ls_sel_sql,"\",\"\") RETURNING g_rtn_fields \n",   #YSC-E60003 mark
                "   CALL ap_ref_array2(g_ref_fields,ls_sql,\"\") RETURNING g_rtn_fields \n",   #YSC-E60003
                ls_rtn_var,
                "   DISPLAY BY NAME ",ls_ref_var
   
   IF ls_page = "1" THEN
      CALL g_properties.addAttribute("detail_vars_reference",ls_ref)
   ELSE
      CALL g_properties.addAttribute("detail_vars_reference"||ls_page,ls_ref)
   END IF

END FUNCTION

#+ 單頭key發生異動
PRIVATE FUNCTION adzp152_detail_multi_table_key_upd()
   DEFINE ls_key_upd       STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE lst_token2       base.StringTokenizer
   DEFINE ls_token2        STRING
   DEFINE lst_token3       base.StringTokenizer
   DEFINE ls_token3        STRING 
   DEFINE li_idx           LIKE type_t.num5
   DEFINE ls_tmp           STRING 

   #單頭key發生異動
   #新key&舊key&欄位名稱
   LET lst_token = base.StringTokenizer.create(g_properties.getValue("detail_append_var_pk"), ',')
   LET lst_token2 = base.StringTokenizer.create(g_properties.getValue("detail_append_fk"), ',')
   LET lst_token3 = base.StringTokenizer.create(g_detail.getValue("detail_append_pk"), ',')
   LET li_idx = 1
   WHILE lst_token.hasMoreTokens()
      LET ls_tmp = li_idx USING "&&"
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      LET ls_token3 = lst_token3.nextToken()
      LET ls_key_upd = ls_key_upd, "LET l_new_key[",ls_tmp,"] = ", ls_token, "\n"
      LET ls_key_upd = ls_key_upd, "LET l_old_key[",ls_tmp,"] = g_", ls_token2, "_t\n"
      LET ls_key_upd = ls_key_upd, "LET l_field_key[",ls_tmp,"] = '", ls_token3, "'\n"
      LET li_idx = li_idx + 1
   END WHILE
   
   LET ls_tmp = g_detail.getValue("detail_append_table")

   LET ls_key_upd = ls_key_upd, "CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, '",ls_tmp,"')"
   
   #取得頁碼
   LET ls_tmp = g_detail.getValue("detail_append_page_num")
   CALL g_properties.addAttribute("detail_append_pk_upd"||ls_tmp, ls_key_upd)

   #單身key發生異動
   #新key&舊key&欄位名稱
   LET ls_key_upd = ""
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_pk"), ',')
   LET li_idx = 1
   WHILE lst_token.hasMoreTokens()
      LET ls_tmp = li_idx USING "&&"
      LET ls_token = lst_token.nextToken()
      IF g_detail.getValue("detail_append_type") = "lang" AND 
         NOT lst_token.hasMoreTokens() THEN
         LET ls_key_upd = ls_key_upd, "LET l_new_key[",ls_tmp,"] = g_dlang \n"
         LET ls_key_upd = ls_key_upd, "LET l_old_key[",ls_tmp,"] = g_dlang \n"
      ELSE
         LET ls_key_upd = ls_key_upd, "LET l_new_key[",ls_tmp,"] = ps_keys[",ls_tmp,"] \n"
         LET ls_key_upd = ls_key_upd, "LET l_old_key[",ls_tmp,"] = ps_keys_bak[",ls_tmp,"] \n"
      END IF
      LET ls_key_upd = ls_key_upd, "LET l_field_key[",ls_tmp,"] = '", ls_token, "'\n"
      LET li_idx = li_idx + 1
   END WHILE
   
   LET ls_tmp = g_detail.getValue("detail_append_table")

   LET ls_key_upd = ls_key_upd, "CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, '",ls_tmp,"')"
   
   #取得頁碼
   LET ls_tmp = g_detail.getValue("detail_append_page_num")
   CALL g_properties.addAttribute("detail_append_pk_upd_tmp"||ls_tmp, ls_key_upd)
   
END FUNCTION

#+ 多table資料更動
PRIVATE FUNCTION adzp152_detail_multi_table_upd()
   DEFINE ls_ref_table     STRING
   DEFINE ls_ref_table_pre STRING
   DEFINE ls_field         STRING
   DEFINE ls_ref           STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE lst_token2       base.StringTokenizer
   DEFINE ls_token2        STRING
   DEFINE ls_tmp           STRING
   DEFINE ls_tmp2          STRING
   DEFINE ls_var           STRING
   DEFINE ls_var2          STRING
   DEFINE ls_chk           STRING
   DEFINE ls_common_field  DYNAMIC ARRAY OF STRING
   DEFINE ls_common_var    DYNAMIC ARRAY OF STRING
   DEFINE li_idx           INTEGER
   DEFINE li_idx2          INTEGER
   DEFINE li_space         INTEGER
   DEFINE ls_return        STRING
   DEFINE ls_return_delete STRING
   DEFINE ls_return_lock   STRING
   
   LET li_space = 9
   
   LET li_idx = 1
   
   #變動確認
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_var_all"), ',')
   LET lst_token2 = base.StringTokenizer.create(g_detail.getValue("detail_append_var_bak"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      IF ls_token.getIndexOf('detail_lang_field',1) THEN
         LET ls_token = ls_token.subString(ls_token.getIndexOf('detail_lang_field',1),ls_token.getLength())
         LET ls_token = g_properties.getValue(ls_token)
      END IF
      IF ls_token <> "g_dlang" THEN
         LET ls_chk = ls_chk, li_space SPACES, ls_token, " = ", ls_token2, " AND\n"
      END IF
   END WHILE
   
   #取得多table之key名稱及內容
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_pk"), ',')
   LET lst_token2 = base.StringTokenizer.create(g_detail.getValue("detail_append_var_pk"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      LET ls_tmp = li_idx USING "&&"
      
      LET ls_return_lock = ls_return_lock, (li_space+3) SPACES, 
                           "LET l_field_keys[",ls_tmp,"] = '", ls_token, "'\n"
      
      IF ls_token2.getIndexOf('detail_lang_field',1) THEN
         LET ls_token2 = ls_token2.subString(ls_token2.getIndexOf('detail_lang_field',1),ls_token2.getLength())
         LET ls_token2 = g_properties.getValue(ls_token2)
      END IF
      
      LET ls_return_lock = ls_return_lock, (li_space+3) SPACES, 
                           "LET l_var_keys[",ls_tmp,"] = ", ls_token2, "\n"
                           
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_var_keys[",ls_tmp,"] = ", ls_token2, "\n"

      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_field_keys[",ls_tmp,"] = '",ls_token,"'\n"
                                    
      LET ls_return_delete = ls_return_delete, (li_space+9) SPACES, 
                      "LET l_field_keys[",ls_tmp,"] = '",ls_token,"'\n"   
                      
      LET li_idx = li_idx + 1

   END WHILE
   
   #取得多table之一般名稱及內容
   LET li_idx = 1
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_field"), ',')
   LET lst_token2 = base.StringTokenizer.create(g_detail.getValue("detail_append_var_field"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()

      LET ls_tmp = li_idx USING "&&"
      
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_vars[",ls_tmp,"] = ", ls_token2, "\n"

      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_fields[",ls_tmp,"] = '",ls_token,"'\n"
                                    
                      
      LET li_idx = li_idx + 1

   END WHILE
   
   #LET li_idx = li_idx - 1
   
   #確定有共用欄位*8
   IF g_detail.getValue("detail_append_type") = "common" THEN    
      LET ls_common_field[1] = g_detail.getValue("detail_append_table_pre"), "user"
      LET ls_common_field[2] = g_detail.getValue("detail_append_table_pre"), "dept"
      LET ls_common_field[3] = g_detail.getValue("detail_append_table_pre"), "buid"
      LET ls_common_field[4] = g_detail.getValue("detail_append_table_pre"), "oriu"
      LET ls_common_field[5] = g_detail.getValue("detail_append_table_pre"), "orid"
      LET ls_common_field[6] = g_detail.getValue("detail_append_table_pre"), "modu"
      LET ls_common_field[7] = g_detail.getValue("detail_append_table_pre"), "date"
      LET ls_common_field[8] = g_detail.getValue("detail_append_table_pre"), "stus"
      
      LET ls_common_var[1] = "g_user"
      LET ls_common_var[2] = "g_dept"
      LET ls_common_var[3] = "\"to_date('\",cl_get_current(),\"','YYYY-MM-DD HH24:MI:SS')\""
      LET ls_common_var[4] = "g_user"
      LET ls_common_var[5] = "g_dept"
      LET ls_common_var[6] = "g_user"
      LET ls_common_var[7] = "\"to_date('\",cl_get_current(),\"','YYYY-MM-DD HH24:MI:SS')\""
      LET ls_common_var[8] = "'Y'"
      
      FOR li_idx2 = li_idx TO li_idx + 7
         LET ls_tmp = li_idx2 USING "&&"
         LET ls_return = ls_return, (li_space+3) SPACES, 
                         "LET l_vars[",ls_tmp,"] = ", ls_common_var[(li_idx2-li_idx+1)], "\n"
         LET ls_return = ls_return, (li_space+3) SPACES, 
                         "LET l_fields[",ls_tmp,"] = '",ls_common_field[(li_idx2-li_idx+1)],"'\n"
      END FOR
      LET li_idx = li_idx2 - 1
   END IF
   
   LET ls_ref_table = g_detail.getValue("detail_append_table")
   LET ls_ref_table_pre = g_detail.getValue("detail_append_table_pre")
   
   #確定是否有site
   LET ls_field = ls_ref_table_pre, "site"
   IF cl_getField(ls_ref_table,ls_field) THEN
      LET ls_tmp = li_idx USING "&&"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_vars[",ls_tmp,"] = g_site \n"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_fields[",ls_tmp,"] = '",ls_field,"'\n"
      LET li_idx = li_idx + 1
   END IF
   
   #確定是否有enterprise
   LET ls_field = ls_ref_table_pre, "ent"
   IF cl_getField(ls_ref_table,ls_field) THEN
      LET ls_tmp = li_idx USING "&&"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_vars[",ls_tmp,"] = g_enterprise \n"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_fields[",ls_tmp,"] = '",ls_field,"'\n"
      LET li_idx = li_idx + 1
   END IF
   
   #取得key舊值
   LET li_idx = 1
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_key_bak"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_tmp = li_idx USING "&&"
      LET ls_return = ls_return, (li_space+3) SPACES, 
                      "LET l_var_keys_bak[",ls_tmp,"] = ",ls_token,"\n"
                                    
      LET ls_return_delete = ls_return_delete, (li_space+9) SPACES, 
                      "LET l_var_keys_bak[",ls_tmp,"] = ",ls_token,"\n"             
      LET li_idx = li_idx + 1
   END WHILE
   
   LET ls_tmp = g_detail.getValue("detail_append_page_num")
   
   LET ls_return = ls_return, (li_space+3) SPACES, 
                   "CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'",ls_ref_table,"')\n"
   
   #進行資料確認, 若資料沒有異動則不做任何處理
   LET ls_return = li_space SPACES, "IF ",
                                    ls_chk.subString(10,ls_chk.getLength()-5), " THEN\n",
                   li_space SPACES, "ELSE \n",                
                                    ls_return, 
                   li_space SPACES, "END IF \n "
    
   #先將array清空    
   LET ls_return = li_space SPACES, "INITIALIZE l_var_keys TO NULL \n",         
                   li_space SPACES, "INITIALIZE l_field_keys TO NULL \n",     
                   li_space SPACES, "INITIALIZE l_vars TO NULL \n",           
                   li_space SPACES, "INITIALIZE l_fields TO NULL \n",
                   li_space SPACES, "INITIALIZE l_var_keys_bak TO NULL \n",                   
                                    ls_return
   

   LET ls_return = g_properties.getValue("detail_multi_language"||ls_tmp), ls_return
   CALL g_properties.addAttribute("detail_multi_language"||ls_tmp, ls_return)

   #產生delete段落
   LET ls_return_delete =                      "INITIALIZE l_var_keys_bak TO NULL \n",    
                          (li_space+9) SPACES, "INITIALIZE l_field_keys TO NULL \n",
                          ls_return_delete,
                          (li_space+9) SPACES, "CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'",ls_ref_table,"')\n"
                          
   CALL g_properties.addAttribute("detail_multi_table_delete"||ls_tmp, ls_return_delete)

   #lock段
   LET ls_return_lock = (li_space+3) SPACES, "INITIALIZE l_var_keys TO NULL \n",         
                        (li_space+3) SPACES, "INITIALIZE l_field_keys TO NULL \n",                    
                                         ls_return_lock,
                        (li_space+3) SPACES, "IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'",ls_ref_table,"') THEN\n",
                        (li_space+6) SPACES, "RETURN \n",
                        (li_space+3) SPACES, "END IF \n"
    
   CALL g_properties.addAttribute("detail_multi_table_lock"||ls_tmp, ls_return_lock)
   
   CALL g_properties.addAttribute("detail_multi_table_unlock"||ls_tmp, "CALL cl_multitable_unlock()")
   
END FUNCTION

#+ 多table資料備份
PUBLIC FUNCTION adzp152_detail_multi_table_bak()
   DEFINE ls_table_name    STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE lst_token2       base.StringTokenizer
   DEFINE ls_token2        STRING
   DEFINE lst_token3       base.StringTokenizer
   DEFINE ls_token3        STRING
   DEFINE ls_bak           STRING
   DEFINE ls_tbl_pre       STRING
   DEFINE ls_page_fields   STRING
   DEFINE li_idx           INTEGER
   DEFINE ls_idx           STRING
   DEFINE ls_field_define  STRING
   DEFINE ls_page          STRING
   DEFINE ls_name          STRING
   DEFINE ls_value         STRING

   LET ls_page = g_detail.getValue("detail_append_page_num")
   LET ls_table_name = g_detail.getValue("detail_append_table")
   
   LET ls_field_define = g_properties.getValue("detail_multi_table_define")
   #LET ls_bak = g_properties.getValue("detail_multi_table_bak")
   
   LET lst_token = base.StringTokenizer.create(g_detail.getValue("detail_append_allfield"), ',')
   LET lst_token2 = base.StringTokenizer.create(g_detail.getValue("detail_append_allvar"), ',')            
   LET lst_token3 = base.StringTokenizer.create(g_detail.getValue("detail_append_alltarget"), ',')            
   WHILE lst_token.hasMoreTokens()
   
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      LET ls_token3 = lst_token3.nextToken()

      #資料備份變數定義
      LET ls_field_define = ls_field_define, "      ", ls_token3, 
                                             " LIKE ",ls_table_name,".",ls_token, ",\n"
      #資料備份段落
      IF ls_token2.getIndexOf('detail_lang_field',1) THEN
         LET ls_token2 = ls_token2.subString(ls_token2.getIndexOf('detail_lang_field',1),ls_token2.getLength())
         LET ls_token2 = g_properties.getValue(ls_token2)
      END IF
      LET ls_bak = ls_bak, "LET g_detail_multi_table_t.",ls_token3, " = ", ls_token2,"\n"
   END WHILE
   
   CALL g_properties.addAttribute("detail_multi_table_define", ls_field_define)
   
   #實際備份程式段落(先判斷哪些page有這些欄位)
   LET ls_tbl_pre = ls_table_name.subString(1,ls_table_name.getIndexOf("_",1)-1)
   
   FOR li_idx = 1 TO g_properties.getValue("page")
      LET ls_idx = li_idx USING "<<<"
      LET ls_page_fields = g_properties.getValue("detail_page_field"||ls_idx)
      IF ls_page_fields.getIndexOf(ls_tbl_pre,1) THEN
         LET ls_name = adzp152_create_name(li_idx, "detail_multi_table_bak", "<<<") 
         LET ls_value = ls_bak
         CALL g_properties.addAttribute(ls_name, ls_value)
      END IF
   END FOR

END FUNCTION



#+ 資料多語言(單頭)
PUBLIC FUNCTION adzp152_master_multilang(ps_string)
   DEFINE ps_string       STRING
   DEFINE ls_table_pre    STRING
   DEFINE ls_table        STRING
   DEFINE ls_return       STRING
   DEFINE ls_tmp          STRING
   DEFINE ls_tmp2         STRING
   DEFINE li_tmp          INTEGER
   DEFINE li_idx          INTEGER
   DEFINE li_cnt          INTEGER
   DEFINE lst_token       base.StringTokenizer

   CASE 
      WHEN ps_string.subString(5,5) MATCHES '[0-9]'
         LET ls_table_pre = ps_string.subString(1,4)
      WHEN ps_string.subString(7,7) MATCHES '[0-9]' 
         LET ls_table_pre = ps_string.subString(1,6)
      OTHERWISE
         DISPLAY "ERROR:多語言資料欄位名稱不符合規定!"
   END CASE
   
   LET ls_table = ls_table_pre, "_t"
   
   LET li_tmp = 9
   LET li_cnt = g_properties.getValue("master_pk_num")
   
   FOR li_idx = 1 TO li_cnt
      LET ls_tmp = "master_var_pk", li_idx USING "&&"
      LET ls_tmp2 = li_idx USING "<<<"
      LET ls_return = ls_return, li_tmp SPACES, 
                      "LET l_keys[",ls_tmp2,"] = ",g_properties.getValue(ls_tmp), "\n"
   END FOR
   
   #因為tree架構不同, 特殊處理
   CASE g_properties.getValue("type_id")
      WHEN "i03"
         #填入lid
         LET ls_tmp = "master_var_lid"
         LET ls_return = ls_return, li_tmp SPACES, 
                      "LET l_keys[1] = ",g_properties.getValue(ls_tmp), "\n"
         LET li_idx = 2
         
      WHEN "i04"
         #暫不處理
         
      WHEN "i05"
         #填入lid
         LET ls_tmp = "master_var_lid"
         LET ls_return = ls_return, li_tmp SPACES, 
                      "LET l_keys[1] = ",g_properties.getValue(ls_tmp), "\n"
         LET li_idx = 2
   
   END CASE
   
   #填入g_dlang
   LET ls_tmp2 = li_idx USING "<<<"
   LET ls_return = ls_return, li_tmp SPACES, 
                   "LET l_keys[",ls_tmp2,"] = g_dlang \n"
   
   #填入多語言欄位
   LET lst_token = base.StringTokenizer.create(ps_string, ',')
   LET li_idx = 1
   WHILE lst_token.hasMoreTokens()
      LET ls_tmp = g_properties.getValue("master_var_title"),".",lst_token.nextToken()
      LET ls_tmp2 = li_idx USING "<<<"
      LET ls_return = ls_return, li_tmp SPACES, 
                      "LET l_langs[",ls_tmp2,"] = ",ls_tmp, "\n"
      LET li_idx = li_idx + 1
   END WHILE
   
   LET ls_return = ls_return, li_tmp SPACES,
                   "CALL cl_multilang(l_keys,l_langs,'",ls_table,"')"
   
   RETURN ls_return
   
END FUNCTION


#+ 資料多語言(單身)
PUBLIC FUNCTION adzp152_detail_multilang(ps_string)
   DEFINE ps_string       STRING
   DEFINE ls_table_pre    STRING
   DEFINE ls_table        STRING
   DEFINE ls_return       STRING
   DEFINE ls_tmp          STRING
   DEFINE ls_tmp2         STRING
   DEFINE li_tmp          INTEGER
   DEFINE li_idx          INTEGER
   DEFINE li_cnt          INTEGER
   DEFINE lst_token       base.StringTokenizer

   CASE 
      WHEN ps_string.subString(5,5) MATCHES '[0-9]'
         LET ls_table_pre = ps_string.subString(1,4)
      WHEN ps_string.subString(7,7) MATCHES '[0-9]' 
         LET ls_table_pre = ps_string.subString(1,6)
      OTHERWISE
         DISPLAY "ERROR:多語言資料欄位名稱不符合規定!"
   END CASE
   
   LET ls_table = ls_table_pre, "_t"
   
   LET li_tmp = 15

   #fk&pk處理
   LET li_cnt  = g_properties.getValue("detail_fk_num")
   LET li_idx = 0
    
   #fk處理, 但未必有fk, 額外判斷
   IF li_cnt > 0 THEN
      FOR li_idx = 1 TO li_cnt
         LET ls_tmp  = "detail_var_fk", li_idx USING "&&"
         LET ls_tmp2 = li_idx USING "<<<"
         LET ls_return = ls_return, li_tmp SPACES, 
                         "LET l_keys[",ls_tmp2,"] = ",g_properties.getValue(ls_tmp), "\n"
      END FOR
   END IF

   #pk處理
   LET li_cnt = g_properties.getValue("detail_pk_num")+li_idx
   FOR li_idx = (li_idx+1) TO li_cnt
      LET ls_tmp  = "detail_var_pk", li_idx USING "&&"
      LET ls_tmp2 = li_idx USING "<<<"
      LET ls_return = ls_return, li_tmp SPACES, 
                      "LET l_keys[",ls_tmp2,"] = ",g_properties.getValue(ls_tmp), "\n"
   END FOR

   #填入g_dlang
   LET ls_tmp2 = li_idx USING "<<<"
   LET ls_return = ls_return, li_tmp SPACES, 
                   "LET l_keys[",ls_tmp2,"] = g_dlang \n"
   
   #填入多語言欄位
   LET lst_token = base.StringTokenizer.create(ps_string, ',')
   LET li_idx = 1
   WHILE lst_token.hasMoreTokens()
      LET ls_tmp = g_properties.getValue("detail_var_title"),"[l_ac].",lst_token.nextToken()
      LET ls_tmp2 = li_idx USING "<<<"
      LET ls_return = ls_return, li_tmp SPACES, 
                      "LET l_langs[",ls_tmp2,"] = ",ls_tmp, "\n"
      LET li_idx = li_idx + 1
   END WHILE
   
   LET ls_return = ls_return, li_tmp SPACES,
                   "CALL cl_multilang(l_keys,l_langs,'",ls_table,"')"

   RETURN ls_return
   
END FUNCTION


#+ 多語言join
PUBLIC FUNCTION adzp152_append_join(p_node,ps_loc,ps_tbl,ps_key_fields,ps_type,ps_master,ps_master_pk,ps_idx)
   DEFINE p_node           om.DomNode
   DEFINE ps_loc           STRING
   DEFINE ps_tbl           STRING
   DEFINE ps_key_fields    STRING
   DEFINE ps_type          STRING
   DEFINE ps_master        STRING
   DEFINE ps_master_pk     STRING
   DEFINE ps_idx           STRING
   DEFINE ls_var_keys      STRING
   DEFINE ls_loc           STRING
   DEFINE li_idx           INTEGER
   DEFINE li_tmp           INTEGER
   DEFINE ls_tmp           STRING
   DEFINE ls_name          STRING
   DEFINE ls_value         STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   DEFINE lst_token2       base.StringTokenizer
   DEFINE ls_token2        STRING
   
   IF ps_loc = 'm' THEN
      LET ls_loc = "master_append_join"
      LET ps_master_pk = g_properties.getValue("master_field_allkeys")
   ELSE
      LET ls_loc = adzp152_create_name(ps_idx, "detail_append_join", "<<<")
   END IF

   LET ls_value = g_properties.getValue(ls_loc)
   
   LET ls_value = ls_value, " LEFT JOIN ", ps_tbl, " ON "
   
   
   LET li_idx = 1

   LET lst_token = base.StringTokenizer.create(ps_key_fields, ',')
   LET lst_token2 = base.StringTokenizer.create(p_node.getAttribute("fk"), ',')
   WHILE lst_token.hasMoreTokens()
      LET li_tmp = ls_value.getLength()
      LET ls_token = lst_token.nextToken()
      LET ls_token2 = lst_token2.nextToken()
      IF lst_token.hasMoreTokens() THEN
         IF ls_token2.getIndexOf('_lang_field',1) THEN
            LET ls_token2 = g_properties.getValue(ls_token2)
         END IF
         LET ls_value = ls_value, ls_token2, " = ", ls_token, " AND "
      ELSE
         IF ps_type = 'lang' THEN
            LET ls_value = ls_value, ls_token, " = '\",g_lang,\"' "
         ELSE 
            IF ls_token2.getIndexOf('_lang_field',1) THEN
               LET ls_token2 = g_properties.getValue(ls_token2)
            END IF
            LET ls_value = ls_value, ls_token2, " = ", ls_token
         END IF
      END IF
      LET li_idx = li_idx + 1
   END WHILE
   
   #IF ps_type = 'lang' THEN
   #  LET ls_value = ls_value.subString(1,li_tmp-5)
   #END IF
   CALL g_properties.addAttribute(ls_loc,ls_value)
   
   #針對b_fill段落
   IF ps_loc = 'd' THEN
   
      LET ls_loc = adzp152_create_name(ps_idx, "detail_append_join_b_fill", "<<<") 
      LET ls_value = g_properties.getValue(ls_loc)
      LET ls_value = ls_value, " LEFT JOIN ", ps_tbl, " ON "    
      
      LET li_idx = 1 
      LET lst_token = base.StringTokenizer.create(p_node.getAttribute("pk"), ',')
      LET lst_token2 = base.StringTokenizer.create(p_node.getAttribute("fk"), ',')
      WHILE lst_token2.hasMoreTokens()
         LET li_tmp = ls_value.getLength()
         LET ls_token = lst_token.nextToken()
         LET ls_token2 = lst_token2.nextToken()
         IF ls_token2.getIndexOf('_lang_field',1) THEN
            LET ls_token2 = g_properties.getValue(ls_token2)
         END IF
         LET ls_value = ls_value, ls_token2, " = ", ls_token
         IF lst_token.hasMoreTokens() THEN
            LET ls_value = ls_value, " AND "
         END IF
         LET li_idx = li_idx + 1
      END WHILE
      
      IF ps_type = 'lang' THEN
        LET ls_value = ls_value, lst_token.nextToken(), " = '\",g_lang,\"'"
      END IF
      
      CALL g_properties.addAttribute(ls_loc,ls_value)
      
      #detail_append_join_master
      LET ls_tmp = adzp152_create_name(ps_idx, "detail_master_idx", "<<<")  
      LET ls_tmp =  g_properties.getValue(ls_tmp)
      LET ls_name = adzp152_create_name(ls_tmp, "detail_append_join_b_fill", "<<<")  
      LET ls_value = g_properties.getValue(ls_name)
      LET ls_name = adzp152_create_name(ps_idx, "detail_append_join_master", "<<<")  
      CALL g_properties.addAttribute(ls_name,ls_value)
      
      #detail_append_join_b_fill2
      LET ls_value = " LEFT JOIN ", ps_tbl, " ON "    
      LET li_idx = 1 
      LET lst_token = base.StringTokenizer.create(p_node.getAttribute("pk"), ',')
      LET ls_tmp = adzp152_create_name(ps_idx, "detail_field_allkeys", "<<<")  
      LET lst_token2 = base.StringTokenizer.create(g_properties.getValue(ls_tmp), ',')
      WHILE lst_token2.hasMoreTokens()
         LET li_tmp = ls_value.getLength()
         LET ls_token = lst_token.nextToken()
         LET ls_token2 = lst_token2.nextToken()
         IF ls_token2.getIndexOf('_lang_field',1) THEN
            LET ls_token2 = g_properties.getValue(ls_token2)
         END IF
         LET ls_value = ls_value, ls_token2, " = ", ls_token
         IF lst_token.hasMoreTokens() THEN
            LET ls_value = ls_value, " AND "
         END IF
         LET li_idx = li_idx + 1
      END WHILE
      
      IF ps_type = 'lang' THEN
        LET ls_value = ls_value, lst_token.nextToken(), " = '\",g_lang,\"'"
      END IF
      LET ls_name = adzp152_create_name(ps_idx, "detail_append_join_b_fill2", "<<<") 
      CALL g_properties.addAttribute(ls_name,ls_value)
      
   END IF
   
END FUNCTION


FUNCTION adzp152_create_mcode_info(ps_loc,ps_table,ps_field,ps_mtable,pi_key_num)
   DEFINE ps_loc       STRING
   DEFINE ps_table     STRING
   DEFINE ps_field     STRING
   DEFINE ps_mtable    STRING
   DEFINE pi_key_num   INTEGER
   DEFINE ls_mfield    STRING
   DEFINE ls_slice     STRING
   DEFINE ls_title     STRING
   DEFINE ls_tmp       STRING
   
   #取得舊資料資料
   LET ls_slice = g_properties.getValue("general_mcode_slice")
    
   #先取得助記碼欄位
   LET ls_tmp = ps_mtable.subString(1,ps_mtable.getIndexOf("_",1)-1)
   LET ls_mfield = ls_tmp, (pi_key_num+3) USING "&&&"
   
   #前置資料
   LET ls_slice = ls_slice, "LET g_wc = cl_mcode_parser(ls_wc,"
   
   #取得助記碼table
   LET ls_slice = ls_slice, "'",ps_mtable,"',"
   
   #取得助記碼欄位(多語言table)
   LET ls_slice = ls_slice, "'",ls_mfield,"',"
   
   #本table
   LET ls_slice = ls_slice, "'",ps_table,"',"
   
   #取得助記碼欄位(本table)
   LET ls_slice = ls_slice, "'",ps_field,"',"
   
   #參照的table的key數量
   LET ls_slice = ls_slice, "'",pi_key_num USING "<<<","',"
   
   #參照的table是否含ent
   LET ls_slice = ls_slice, "'",g_properties.getValue("master_field_ent"),"')"
   
   #回存
   CALL g_properties.addAttribute("general_mcode_slice",ls_slice)

END FUNCTION

PUBLIC FUNCTION adzp152_chk_loc(ps_field)
   DEFINE ps_field     STRING
   DEFINE ls_master    STRING
   DEFINE ls_detail    STRING
   
   LET ls_master = g_properties.getValue("master_all_field")
   LET ls_detail = g_properties.getValue("detail_all_field")
   
   IF ls_master.getIndexOf(ps_field,1) > 0 THEN
      RETURN "M"
   END IF
   
   IF ls_detail.getIndexOf(ps_field,1) > 0 THEN
      RETURN "D"
   END IF
   
   DISPLAY "ERROR(15):該",ps_field,"欄位不存在於畫面上！"
   RETURN ""

END FUNCTION

#濾除target中不需要的段落
PUBLIC FUNCTION adzp152_target_filter(p_node)
   DEFINE p_node           om.DomNode
   DEFINE l_node           om.DomNode
   DEFINE ls_target        STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
    
   LET ls_target = p_node.getAttribute("target")
   
   LET lst_token = base.StringTokenizer.create(ls_target, ',')
   LET ls_target = ""
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF ls_token.getIndexOf('.',1) THEN
         LET ls_token = ls_token.subString(ls_token.getIndexOf('.',1)+1,ls_token.getLength())
      END IF
      
      IF cl_null(ls_target) THEN
         LET ls_target = ls_token
      ELSE
         LET ls_target = ls_target, ',', ls_token
      END IF
   END WHILE
   
   LET l_node = p_node
   
   CALL l_node.setAttribute("target",ls_target)
   
   RETURN l_node
   
END FUNCTION

#濾除target中不需要的段落
PUBLIC FUNCTION adzp152_entperise_filter(p_node)
   DEFINE p_node           om.DomNode
   DEFINE l_node           om.DomNode
   DEFINE ls_target        STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
    
   LET ls_target = p_node.getAttribute("fk")
   
   LET lst_token = base.StringTokenizer.create(ls_target, ',')
   LET ls_target = ""
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF ls_token.getIndexOf('ent',4) THEN
         CONTINUE WHILE
      END IF
      
      IF cl_null(ls_target) THEN
         LET ls_target = ls_token
      ELSE
         LET ls_target = ls_target, ',', ls_token
      END IF
   END WHILE
   
   LET l_node = p_node
   
   CALL l_node.setAttribute("fk",ls_target)
   
   RETURN l_node
   
END FUNCTION

#調整fk的固定值
PUBLIC FUNCTION adzp152_static_change(p_node,ps_loc)
   DEFINE p_node           om.DomNode
   DEFINE ps_loc            STRING
   DEFINE l_node           om.DomNode
   DEFINE ls_loc            STRING
   DEFINE ls_target        STRING
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
    
   IF ps_loc = 'm' THEN
      LET ls_loc = 'master_lang_field'
   ELSE
      LET ls_loc = 'detail_lang_field'
   END IF
    
   LET ls_target = p_node.getAttribute("fk")
   
   LET lst_token = base.StringTokenizer.create(ls_target, ',')
   LET ls_target = ""
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF ls_token.getIndexOf("'",1) THEN
         LET ga_lang_field[ga_lang_field.getLength()+1] = ls_token
         LET ls_token = adzp152_create_name(ga_lang_field.getLength(), ls_loc, "&&") 
         CALL g_properties.addAttribute(ls_token,ga_lang_field[ga_lang_field.getLength()])
      END IF
      
      IF cl_null(ls_target) THEN
         LET ls_target = ls_token
      ELSE
         LET ls_target = ls_target, ',', ls_token
      END IF
   END WHILE
   
   LET l_node = p_node
   
   CALL l_node.setAttribute("fk",ls_target)
   
   RETURN l_node
   
END FUNCTION

#調整lang以外的類型
PUBLIC FUNCTION adzp152_other_change(p_node,ps_loc,ps_pk)
   DEFINE p_node           om.DomNode
   DEFINE ps_loc           STRING
   DEFINE ps_pk            STRING
   DEFINE l_node           om.DomNode
   DEFINE ls_target        STRING
   DEFINE ls_fk            STRING
    
   
   LET l_node = p_node
   
   LET ls_target = p_node.getAttribute("field")
   
   IF ps_loc = 'm' THEN
      LET ls_fk = g_properties.getValue("master_field_allkeys")
   END IF
   
   IF ps_loc = 'd' THEN
      LET ls_fk = g_properties.getValue("master_field_allkeys"),',',ps_pk
   END IF
   
   CALL l_node.setAttribute("target",ls_target)
   CALL l_node.setAttribute("fk",ls_fk)
   
   RETURN l_node
   
END FUNCTION

#複製段落產生
FUNCTION adzp152_detail_multi_table_reproduce(p_node)
   DEFINE p_node        om.DomNode
   DEFINE ls_repro      STRING
   DEFINE ls_value      STRING
   DEFINE ls_name       STRING
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   DEFINE li_idx        INTEGER
   DEFINE ls_tmp        STRING
   
   LET ls_repro = g_properties.getValue("detail_multi_lang_repro")
   
   #多語言序號
   IF cl_null(g_properties.getValue("detail_multi_lang_idx")) THEN
      LET li_idx = 0
   ELSE
      LET li_idx = g_properties.getValue("detail_multi_lang_idx") + 1
   END IF
   LET ls_name = "detail_multi_lang_idx"
   LET ls_value = li_idx
   CALL g_properties.addAttribute(ls_name,ls_value)
   CALL g_properties.addAttribute("lang",ls_value)
  
   #mdl_lang_tbl
   LET ls_name = "mdl_lang_tbl"
   LET ls_value = p_node.getAttribute("table")
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #mdl_field_fk
   LET li_idx = 1
   LET ls_name = "mdl_field_fk"
   LET lst_token = base.StringTokenizer.create(p_node.getAttribute("pk"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_name = adzp152_create_name(li_idx, "mdl_field_fk", "&&") 
      LET ls_value = ls_token
      CALL g_properties.addAttribute(ls_name,ls_value)
      LET li_idx = li_idx + 1
   END WHILE
   
   #mdl_append_wc
   LET ls_value = ""
   LET ls_tmp = p_node.getAttribute("table")
   LET ls_tmp = ls_tmp.subString(1,ls_tmp.getIndexOf("_",1)-1),"ent"
   IF cl_getField(p_node.getAttribute("table") CLIPPED, ls_tmp CLIPPED) THEN
      LET ls_value = ls_tmp," = g_enterprise AND " 
   END IF
   LET ls_name = "mdl_append_wc"
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #組合
   LET ls_name = "detail_multi_lang_repro"
   LET ls_value = ls_repro, adzp152_make_slice("a38")
   CALL g_properties.addAttribute(ls_name,ls_value)

END FUNCTION



