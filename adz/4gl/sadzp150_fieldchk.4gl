#adzp150 副程式 - 欄位檢驗/帶值相關處理

SCHEMA ds 
    
GLOBALS
   DEFINE g_properties   om.SaxAttributes
   CONSTANT li_space = 3
   DEFINE gdnode_all     om.DomNode
   DEFINE g_update       STRING
END GLOBALS

DEFINE g_value STRING

DEFINE g_dzbb RECORD 
         prog_name    STRING,
         point_name   STRING,
         point_ver    STRING,
         addpoint     STRING
         END RECORD

#+ 判斷該欄位是否為key, 若為key則添加檢查段落
PUBLIC FUNCTION adzp150_key_field_chk(pn_column,pi_lv)
   DEFINE ls_var               STRING               #變數名稱
   DEFINE ls_var2              STRING               #變數名稱
   DEFINE l_sql                STRING               #暫存sql
   DEFINE ls_filled_chk        STRING               #檢查所有欄位都已填
   DEFINE ls_insert_chk        STRING               #確定是否為新增段
   DEFINE ls_modify_chk        STRING               #確定是否為修改段
   DEFINE ls_return            STRING               
   DEFINE ls_tmp               STRING               
   DEFINE ls_name              STRING               #欄位名稱
   DEFINE ls_allkeys           STRING               #單頭,單身所有key欄位(含lid,pid,type)
   DEFINE ls_master_keys       STRING               #單頭所有key欄位(含lid,pid,type)
   DEFINE ls_detail_keys       STRING               #單身所有key欄位(含lid,pid,type)
   DEFINE lb_tok               base.StringTokenizer
   DEFINE ls_field             STRING
   DEFINE ls_fks               STRING
   DEFINE ls_var_fk            STRING
   DEFINE l_idx                INTEGER
   DEFINE l_cnt                INTEGER
   DEFINE l_buf                base.StringBuffer
   DEFINE pn_column            om.DomNode
   DEFINE pi_lv                LIKE type_t.num5
   
   LET ls_name = pn_column.getAttributeValue(1)

   #若為單頭pid欄位則附帶檢查該pid是否存在
   LET ls_name = pn_column.getAttribute("id")
   IF ls_name = g_properties.getValue("master_field_pid") THEN
      LET ls_var = g_properties.getValue("master_var_title"),".",ls_name
      LET ls_var2 = g_properties.getValue("master_var_title"),".",g_properties.getValue("master_field_lid")
      LET l_sql = "SELECT COUNT(*) FROM ",g_properties.getValue("master_tbl_name")," WHERE ",g_properties.getValue("master_field_lid"), " = ? "
      
      #IF NOT cl_null(g_properties.getValue("master_field_type")) THEN
      #   LET l_sql = l_sql, " AND ",g_properties.getValue("master_field_type")," = '\"||",g_properties.getValue("master_var_title"),".",g_properties.getValue("master_field_type"),"||\"'"
      #END IF
      
      LET ls_return = ((pi_lv+1)*li_space) SPACES, 
                      "IF ",ls_var," <> ",ls_var2," THEN \n",
                      ((pi_lv+2)*li_space) SPACES, 
                      "IF NOT ap_chk_isexist(",ls_var,",\"",l_sql,"\",'std-00021',1)  THEN\n",
                      ((pi_lv+3)*li_space) SPACES, 
                      "NEXT FIELD ",ls_name,"\n" ,
                      ((pi_lv+2)*li_space) SPACES, 
                      "END IF\n",
                      ((pi_lv+1)*li_space) SPACES, 
                      "END IF\n"
      RETURN ls_return
                              
   END IF
   
   #若為單身lid欄位則附帶檢查該lid是否存在
   LET ls_name = pn_column.getAttribute("id")
   IF ls_name = g_properties.getValue("detail_field_lid") THEN
      LET ls_tmp = g_properties.getValue("general_current_page")
      IF ls_tmp = "1" THEN
         LET ls_tmp = "detail_var_title"
      ELSE
         LET ls_tmp = "detail_var_title",ls_tmp
      END IF
      LET ls_var = g_properties.getValue(ls_tmp),"[l_ac].",ls_name
      LET ls_var2 = g_properties.getValue("master_var_title"),".",g_properties.getValue("master_field_lid")
      LET l_sql = "SELECT COUNT(*) FROM ",g_properties.getValue("master_tbl_name"),
                  " WHERE ",g_properties.getValue("master_field_lid"), " = ? "
      
      #IF NOT cl_null(g_properties.getValue("master_field_type")) THEN
      #   LET l_sql = l_sql, " AND ",g_properties.getValue("master_field_type")," = '",g_properties.getValue(ls_tmp),"[l_ac].",g_properties.getValue("detail_field_type"),"'"
      #END IF
      
      LET ls_return = ((pi_lv+1)*li_space) SPACES, 
                      "IF ",ls_var," = ",ls_var2," THEN \n",
                      ((pi_lv+2)*li_space) SPACES, 
                      "LET g_errparam.extend = '",ls_var,"'\n",
                      ((pi_lv+2)*li_space) SPACES, 
                      "LET g_errparam.code = '-100'\n",
                      ((pi_lv+2)*li_space) SPACES, 
                      "LET g_errparam.popup = 1\n",
                      ((pi_lv+2)*li_space) SPACES, 
                      "CALL cl_err()\n",
                      ((pi_lv+2)*li_space) SPACES, 
                      "NEXT FIELD ",ls_name,"\n" ,
                      ((pi_lv+1)*li_space) SPACES, 
                      "ELSE \n",
                      ((pi_lv+2)*li_space) SPACES, 
                      "IF NOT ap_chk_isexist(",ls_var,",\"",l_sql,"\",'std-00022',1)  THEN\n",
                      ((pi_lv+3)*li_space) SPACES, 
                      "NEXT FIELD ",ls_name,"\n" ,
                      ((pi_lv+2)*li_space) SPACES, 
                      "END IF\n",
                      ((pi_lv+1)*li_space) SPACES, 
                      "END IF\n"

      RETURN ls_return
                              
   END IF
   
   LET ls_allkeys = g_properties.getValue("master_field_allkeys") , #單頭key
                    g_properties.getValue("detail_field_allkeys")   #單身key

   IF ls_allkeys.getIndexOf(ls_name,1) = 0 THEN
      RETURN ""
   END IF

   CASE g_properties.getValue("location") 
      WHEN "head" 
         LET ls_master_keys = g_properties.getValue("master_field_allkeys")
         
         LET ls_name = g_properties.getValue("master_var_title"),".",ls_name
      
         #檢查所有單頭欄位都已填(ls_filled_chk)
         LET ls_filled_chk = "" 
         
         LET lb_tok = base.StringTokenizer.create(ls_master_keys,",")
         WHILE lb_tok.hasMoreTokens()
            LET ls_tmp = lb_tok.nextToken()
            LET ls_var = g_properties.getValue("master_var_title"),".",ls_tmp
            LET ls_filled_chk = ls_filled_chk," NOT cl_null(",ls_var,") "
            IF lb_tok.hasMoreTokens() THEN
               LET ls_filled_chk = ls_filled_chk,"AND"
            END IF
         END WHILE

         #確定是否為新增段(ls_insert_chk)
         LET ls_insert_chk = " p_cmd = 'a' "  
         
         #確定是否為修改段(ls_modify_chk)
         LET ls_modify_chk = " p_cmd = 'u' AND ("
         LET lb_tok = base.StringTokenizer.create(ls_master_keys,",")
         WHILE lb_tok.hasMoreTokens()
            LET ls_field = lb_tok.nextToken()
            LET ls_var = g_properties.getValue("master_var_title"),".",ls_field
            LET ls_modify_chk = ls_modify_chk, ls_var, " != g_",ls_field,"_t "
            IF lb_tok.hasMoreTokens() THEN
               LET ls_modify_chk = ls_modify_chk, " OR "
            END IF
         END WHILE
         LET ls_modify_chk = ls_modify_chk,")"
         
         #組合notDup的SQL(l_sql)
         LET l_sql = "\"SELECT COUNT(*) FROM ",g_properties.getValue("master_tbl_name")," WHERE \"||"
                                              
         #若有ent,site code則須加額外判斷
         IF NOT cl_null(g_properties.getValue("master_append_wc_s")) THEN
            LET l_sql = l_sql,"\"",g_properties.getValue("master_append_wc_s"),"\"||" 
         END IF
         
         #判斷所有單頭key for l_sql
         LET lb_tok = base.StringTokenizer.create(ls_master_keys,",")
         WHILE lb_tok.hasMoreTokens()
            LET ls_tmp = lb_tok.nextToken()
            LET ls_var = g_properties.getValue("master_var_title"),".",ls_tmp
            LET l_sql = l_sql,"\"",ls_tmp," = '\"||",ls_var
            IF lb_tok.hasMoreTokens() THEN
               LET l_sql = l_sql, " ||\"' AND \"|| "
            ELSE
               LET l_sql = l_sql, " ||\"'\""
            END IF
         END WHILE
         
      WHEN "body" 
         RETURN ""
         LET ls_detail_keys = g_properties.getValue("detail_field_allkeys")
         LET ls_fks = g_properties.getValue("detail_field_fks")
         
         #code_i04(Tree雙檔), 因父節點欄位不出現在畫面上, 進行特殊處理
         IF g_properties.getValue("type_id") = "i04" THEN
            LET l_buf = base.StringBuffer.create()
            CALL l_buf.append(ls_detail_keys)
            CALL l_buf.replace(g_properties.getValue("detail_field_pid"), "", 0)
            LET ls_detail_keys = l_buf.toString()
         END IF
         
         #檢查所有單身欄位都已填(ls_filled_chk)
         LET ls_filled_chk = "" 
         
         LET lb_tok = base.StringTokenizer.create(ls_detail_keys,",")
         WHILE lb_tok.hasMoreTokens()
            LET ls_tmp = lb_tok.nextToken()
            LET l_cnt = 1
            IF ls_fks.getIndexOf(ls_tmp,1) THEN
               FOR l_idx = 1 TO ls_fks.getIndexOf(ls_tmp,1)
                  IF ls_fks.subString(l_idx,l_idx) = ',' THEN 
                     LET l_cnt = l_cnt+1
                  END IF
               END FOR
               LET ls_var_fk = "detail_var_fk", l_cnt USING "&&"
               LET ls_var = g_properties.getValue(ls_var_fk)
            ELSE
               LET ls_var = g_properties.getValue("detail_var_title"),"[l_ac].",ls_tmp
            END IF
            LET ls_filled_chk = ls_filled_chk," ",ls_var," IS NOT NULL "
            IF lb_tok.hasMoreTokens() THEN
               LET ls_filled_chk = ls_filled_chk,"AND"
            END IF
         END WHILE

         #確定是否為新增段(ls_insert_chk)
         LET ls_insert_chk = " l_cmd = 'a' "  

         #確定是否為修改段(ls_modify_chk)
         LET ls_modify_chk = " l_cmd = 'u' AND ("
         LET lb_tok = base.StringTokenizer.create(ls_detail_keys,",")
         WHILE lb_tok.hasMoreTokens()
            LET ls_field = lb_tok.nextToken()
            LET l_cnt = 1
        
            IF ls_fks.getIndexOf(ls_field,1) THEN
               #fk特別處理
               FOR l_idx = 1 TO ls_fks.getIndexOf(ls_field,1)
                  IF ls_fks.subString(l_idx,l_idx) = ',' THEN 
                     LET l_cnt = l_cnt+1
                  END IF
               END FOR
               LET ls_var_fk = "detail_var_fk", l_cnt USING "&&"
               LET ls_var = g_properties.getValue(ls_var_fk)
               LET ls_var_fk = "master_field_pk", l_cnt USING "&&"
               LET ls_field = g_properties.getValue(ls_var_fk)
               LET ls_modify_chk = ls_modify_chk, ls_var, " != g_",ls_field,"_t "
            ELSE
               #一般pk處理
               LET ls_var = g_properties.getValue("detail_var_title"),"[l_ac].",ls_field
               LET ls_modify_chk = ls_modify_chk, ls_var, " != ",g_properties.getValue("detail_var_title"),"_t.",ls_field
            END IF
            IF lb_tok.hasMoreTokens() THEN
               LET ls_modify_chk = ls_modify_chk, " OR "
            END IF
         END WHILE
         LET ls_modify_chk = ls_modify_chk,")"
         
         #組合notDup的SQL(l_sql)
         LET l_sql = "\"SELECT COUNT(*) FROM ",g_properties.getValue("detail_tbl_name")," WHERE \"||"
                                              
         #若有ent,site code則須加額外判斷
         IF NOT cl_null(g_properties.getValue("detail_append_wc_s")) THEN
            LET l_sql = l_sql,"\"",g_properties.getValue("detail_append_wc_s") ,"\"||" 
         END IF
         
         #判斷所有單身key for l_sql
         LET lb_tok = base.StringTokenizer.create(ls_detail_keys,",")
         WHILE lb_tok.hasMoreTokens()
            LET ls_field = lb_tok.nextToken()
            LET l_cnt = 1
            #fk特別處理
            IF ls_fks.getIndexOf(ls_field,1) THEN
               FOR l_idx = 1 TO ls_fks.getIndexOf(ls_field,1)
                  IF ls_fks.subString(l_idx,l_idx) = ',' THEN 
                     LET l_cnt = l_cnt+1
                  END IF
               END FOR
               LET ls_var_fk = "detail_var_fk", l_cnt USING "&&"
               LET ls_var = g_properties.getValue(ls_var_fk)
            ELSE
               LET ls_var = g_properties.getValue("detail_var_title"),"[l_ac].",ls_field
            END IF
            
            LET l_sql = l_sql,"\"",ls_field," = '\"||",ls_var
            IF lb_tok.hasMoreTokens() THEN
               LET l_sql = l_sql, " ||\"' AND \"|| "
            ELSE
               LET l_sql = l_sql, " ||\"'\""
            END IF
         END WHILE

   END CASE 
         
   LET g_value = ls_filled_chk
   CALL g_properties.addAttribute("mdl_filled_chk",g_value)
   LET g_value = ls_modify_chk
   CALL g_properties.addAttribute("mdl_modify_chk",g_value)
   LET g_value = l_sql
   CALL g_properties.addAttribute("mdl_sql",g_value)
   IF g_properties.getValue("location") = "head" THEN
      LET g_value = "p_cmd"
   ELSE
      LET g_value = "l_cmd"
   END IF
   CALL g_properties.addAttribute("mdl_loc",g_value)
   LET ls_return = ls_return, adzp150_make_slice("a05")
                                            
   RETURN ls_return
   
END FUNCTION

#+ 產生欄位 AFTER/BEFORE/CONTROLP 段落
PUBLIC FUNCTION adzp150_create_chk_field(li_page,pi_lv,ps_type)
   DEFINE pi_lv         LIKE type_t.num10 
   DEFINE ps_type       LIKE type_t.chr2 
   DEFINE ls_type       LIKE type_t.chr2 
   DEFINE l_nlist       om.NodeList
   DEFINE l_node        om.DomNode
   DEFINE lnode_child   om.DomNode
   DEFINE l_column      om.DomNode
   DEFINE l_ctrl        om.DomNode
   DEFINE l_return      STRING 
   DEFINE l_column_name STRING 
   DEFINE l_n           LIKE type_t.num10 
   DEFINE l_m           LIKE type_t.num10 
   DEFINE li_page       LIKE type_t.num5
   DEFINE li_genaft     LIKE type_t.num5    #確認 AFTER FIELD  必須要被產生
   DEFINE li_genbfr     LIKE type_t.num5    #確認 BEFORE FIELD 必須要被產生
   DEFINE li_genctp     LIKE type_t.num5    #確認 CONTROLP     必須要被產生
   DEFINE li_genonc     LIKE type_t.num5    #確認 ON CHANGE    必須要被產生
   DEFINE l_tmp         STRING
   DEFINE l_ctrl_type   LIKE type_t.chr10
   DEFINE l_candi       LIKE type_t.chr10
   DEFINE ls_page       STRING
   DEFINE ls_next       STRING

   LET l_nlist = gdnode_all.selectByTagName("init")
   
   IF li_page <> 0 THEN
      LET ls_page = "page", adzp150_page_trans(li_page), "."
   END IF
    
   #擷取出head,body的node
   FOR l_n = 1 TO l_nlist.getLength()
      LET l_node = l_nlist.item(l_n)
      LET l_tmp = l_node.toSTRING()
     
      #確定目前要產生的段落為head or body
      IF l_node.getAttributeValue(1) = g_properties.getValue("location") THEN 

         CASE g_properties.getValue("location")
         
            WHEN "head"    #產生單頭段落
               LET lnode_child = l_node

            WHEN "body"    #產生單身段落
               #判斷此處的page為第幾個page
               IF li_page = l_node.getAttributeValue(2) THEN
                  LET lnode_child = l_node
                  CALL g_properties.addAttribute("page_location",li_page)
               END IF 

            WHEN "body2"  #單身凍結
               LET lnode_child = l_node
               
         END CASE 
         
      END IF 
      
   END FOR 
    
   #只是加註解
   #IF g_properties.getValue("location") = "head" THEN
   #   LET l_return = "#---------------------------<  Master  >---------------------------\n"
   #ELSE 
   #   LET l_return = "#---------------------<  Detail: page", li_page USING "<<<","  >---------------------\n"
   #END IF 

   IF lnode_child IS NULL THEN
      RETURN l_return
   END IF

   #產生檢查段落
   FOR l_n = 1 TO lnode_child.getChildCount()
      LET l_column = lnode_child.getChildByIndex(l_n)
      IF l_column.getAttribute("default") IS NOT NULL AND ps_type = "i" THEN   #預設值不可為空
         CALL adzp150_make_default(l_column,li_page)
      END IF
      
      IF l_column.getAttribute("def_scc") IS NOT NULL AND ps_type = "i" THEN   #預設值不可為空
         CALL adzp150_make_combo(l_column)
      END IF
      
      #取得欄位名稱
      LET l_column_name = l_column.getAttributeValue(1)
      
      #取得next行為
      #LET ls_next = l_column.getAttribute("next")
      #IF NOT cl_null(ls_next) THEN
      #   IF ps_type = 'i' THEN
      #      LET ls_next = 'NEXT FIELD ', ls_next
      #   ELSE
      #      LET ls_next = ''
      #   END IF
      #END IF
      
      #單頭有stus
      IF l_column_name.getIndexOf('stus',4) > 0 AND 
         l_column_name.getIndexOf('stus',4) + 3 = l_column_name.getLength() AND
         g_properties.getValue("location") = "head" AND
         ps_type = 'i' THEN
         CALL g_properties.addAttribute("master_stus_isExist","Y")
         CALL adzp150_get_stus(l_column,'master')
      END IF
      
      #單身有stus
      IF l_column_name.getIndexOf('stus',4) > 0 AND 
         l_column_name.getIndexOf('stus',4) + 3 = l_column_name.getLength() AND
         g_properties.getValue("location") = "body" AND
         ps_type = 'i' THEN
         CALL g_properties.addAttribute("detail_field_stus", l_column_name)
         CALL g_properties.addAttribute("detail_stus_isExist","Y")
         CALL adzp150_get_stus(l_column,'detail')
      END IF
      
      #i03需做特別處理
      #IF g_properties.getValue("type_id") = "i03" THEN
      #   LET l_column_name = "b_",l_column_name
      #END IF
      
      #LET l_column_name = adzp150_field_filter(l_column_name,"field")
      
      #特別判斷, 若非可輸入的欄位不做處理
      IF ps_type = "i" OR ps_type = "ic" THEN
         LET l_tmp = g_properties.getValue("general_input_field")
         IF l_tmp.getIndexOf(l_column_name,1) > 0 AND
            l_column_name.getIndexOf('ownid',4) = 0 AND
            l_column_name.getIndexOf('owndp',4) = 0 AND
            l_column_name.getIndexOf('crtid',4) = 0 AND
            l_column_name.getIndexOf('crtdp',4) = 0 AND
            l_column_name.getIndexOf('crtdt',4) = 0 AND
            l_column_name.getIndexOf('modid',4) = 0 AND
            l_column_name.getIndexOf('moddt',4) = 0 AND
            l_column_name.getIndexOf('cnfid',4) = 0 AND
            l_column_name.getIndexOf('cnfdt',4) = 0 AND
            l_column_name.getIndexOf('pstid',4) = 0 AND
            l_column_name.getIndexOf('pstdt',4) = 0 THEN
            IF ps_type = "i" THEN
               LET li_genaft = TRUE
               LET li_genctp = FALSE
               LET li_genbfr = TRUE
               LET li_genonc = TRUE
            ELSE
               LET li_genaft = FALSE
               LET li_genctp = TRUE
               LET li_genbfr = FALSE
               LET li_genonc = FALSE
            END IF
         ELSE
            LET li_genaft = FALSE
            LET li_genctp = FALSE
            LET li_genbfr = FALSE
            LET li_genonc = FALSE
         END IF
         LET ls_type = "i"
      END IF
      
      #特別判斷, 若非可查詢的欄位不做處理
      IF ps_type = "c" THEN
         LET l_tmp = g_properties.getValue("general_construct_field")
         IF l_tmp.getIndexOf(l_column_name,1) > 0 THEN
            LET li_genaft = TRUE
            LET li_genctp = TRUE
            LET li_genbfr = TRUE
            LET li_genonc = FALSE
         ELSE
            LET li_genaft = FALSE
            LET li_genctp = FALSE
            LET li_genbfr = FALSE
            LET li_genonc = FALSE
         END IF
         LET ls_type = "c"
      END IF
      

      #開始逐個欄位取資料
      #LET l_return = l_return, (pi_lv*li_space) SPACES,"#----<<",l_column_name,">>----\n"

      FOR l_m = 1 TO l_column.getChildCount()

         LET l_ctrl =  l_column.getChildByIndex(l_m)
         CALL g_properties.addAttribute("column",l_column_name)

         LET l_ctrl_type = l_ctrl.getAttribute("state")
         IF cl_null(l_ctrl_type) THEN
            LET l_ctrl_type = "i"
         END IF
         
         #確保至少做過一次(主要針對reference)
         IF ps_type = "i" THEN
            LET l_tmp = adzp150_parse_element(l_ctrl,pi_lv+1)
         END IF
         
         CASE
            WHEN l_ctrl.getTagName() = "before" AND li_genbfr AND ps_type <> "c"
               #產生元件段落(before)
               #LET l_return = l_return, (pi_lv*li_space) SPACES, "BEFORE FIELD ",l_column_name,"\n"
               
               #程式產生段落
               LET g_dzbb.prog_name   = g_properties.getValue("app_id")
               LET g_dzbb.point_name  = "input.b.",ls_page,g_properties.getValue("column")
               LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
               LET g_dzbb.addpoint    = adzp150_parse_element(l_ctrl,pi_lv+1)
               CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))
               
               #新增add point段落
               #LET l_return = l_return, ((pi_lv+1)*li_space) SPACES, "#add-point:BEFORE FIELD ",g_properties.getValue("column"),"\n",
               #                         ((pi_lv+1)*li_space) SPACES, "{<point name=\"input.b.",ls_page,g_properties.getValue("column"),"\" />}","\n",
               #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"
               
               #採讀取樣板的方式增加add-point
               LET g_value = g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_column",g_value) 
               LET g_value = "input.b.",ls_page,g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_point",g_value)
               LET l_return = l_return, adzp150_make_slice("a01")
               LET li_genbfr = FALSE
            
            WHEN l_ctrl.getTagName() = "after" AND li_genaft AND ps_type <> "c"
               #產生元件段落(after)
               #LET l_return = l_return, (pi_lv*li_space) SPACES, "AFTER FIELD ",l_column_name,"\n"
               
               #程式產生段落
               LET g_dzbb.prog_name   = g_properties.getValue("app_id")
               LET g_dzbb.point_name  = "input.a.",ls_page,g_properties.getValue("column")
               LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
               LET g_dzbb.addpoint    = adzp150_parse_element(l_ctrl,pi_lv+1),"\n",adzp150_key_field_chk(l_column,pi_lv)
               CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))
               
               #新增add point段落
               #LET l_return = l_return, ((pi_lv+1)*li_space) SPACES, "#add-point:AFTER FIELD ",g_properties.getValue("column"),"\n",
               #                         ((pi_lv+1)*li_space) SPACES, "{<point name=\"input.a.",ls_page,g_properties.getValue("column"),"\" />}","\n",
               #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"

               #採讀取樣板的方式增加add-point 
               LET g_value = g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_column",g_value) 
               LET g_value = "input.a.",ls_page,g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_point",g_value)
               LET g_value = g_properties.getValue(g_properties.getValue("column")||"_range_chk")
               CALL g_properties.addAttribute("mdl_range_chk",g_value) 
               #LET g_value = ls_next
               #CALL g_properties.addAttribute("mdl_next_field",g_value) 
               LET l_return = l_return, adzp150_make_slice("a02")
               CALL g_properties.addAttribute("mdl_range_chk","") 

               #已經有產生AFTER FIELD段落
               LET li_genaft = FALSE

            WHEN l_ctrl.getTagName() = "controlp" AND li_genctp
               #產生元件段落(controlp)
               
               #根據i段,c段產生不同內容
               IF ls_type = "i" THEN 
                  LET l_candi = "input"
               ELSE
                  LET l_candi = "construct"
               END IF
               
               IF l_ctrl_type <> ls_type THEN
                  CONTINUE FOR
               END IF
               
               #先產生說明
               LET l_return = l_return, (pi_lv*li_space) SPACES, "#Ctrlp:",l_candi,".c.",ls_page,g_properties.getValue("column"),"\n"
               #LET l_return = l_return, (pi_lv*li_space) SPACES, "ON ACTION controlp INFIELD ",l_column_name,"\n"
               
               #程式產生段落
               LET g_dzbb.prog_name   = g_properties.getValue("app_id")
               LET g_dzbb.point_name  = l_candi,".c.",ls_page,g_properties.getValue("column")
               LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
               LET g_dzbb.addpoint    = adzp150_create_controlp(l_ctrl,pi_lv+1,l_candi)
               CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))
               
               #新增add point段落
               #LET l_return = l_return, ((pi_lv+1)*li_space)    SPACES, "#add-point:CONTROLP ",g_properties.getValue("column"),"\n",
               #                         ((pi_lv+1)*li_space)    SPACES, "{<point name=\"",l_candi,".c.",ls_page,g_properties.getValue("column"),"\" />}","\n",
               #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"

               #採讀取樣板的方式增加add-point
               LET g_value = g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_column",g_value) 
               LET g_value = l_candi,".c.",ls_page,g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_point",g_value)
               LET l_return = l_return, adzp150_make_slice("a03")    
                                        
               LET li_genctp = FALSE
               
            WHEN l_ctrl.getTagName() = "onchange" AND li_genonc AND ps_type <> "c"
               #產生元件段落(onchange)
               #LET l_return = l_return, (pi_lv*li_space) SPACES, "ON CHANGE ",l_column_name,"\n"
               
               #程式產生段落
               LET g_dzbb.prog_name   = g_properties.getValue("app_id")
               LET g_dzbb.point_name  = "input.g.",ls_page,g_properties.getValue("column")
               LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
               LET g_dzbb.addpoint    = adzp150_parse_element(l_column,pi_lv),"\n",adzp150_parse_element(l_ctrl,pi_lv+1)
               CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))
               
               #新增add point段落
               #LET l_return = l_return, ((pi_lv+1)*li_space) SPACES, "#add-point:ON CHAGE ",g_properties.getValue("column"),"\n",
               #                         ((pi_lv+1)*li_space) SPACES, "{<point name=\"input.g.",ls_page,g_properties.getValue("column"),"\" />}","\n",
               #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"
               
               #採讀取樣板的方式增加add-point
               LET g_value = g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_column",g_value) 
               LET g_value = "input.g.",ls_page,g_properties.getValue("column")
               CALL g_properties.addAttribute("mdl_point",g_value)
               LET l_return = l_return, adzp150_make_slice("a04")  
               
               #已經有產生AFTER FIELD段落
               LET li_genonc = FALSE
            
         END CASE 

      END FOR 
      
      IF l_column.getTagName() = "column" THEN
         CALL g_properties.addAttribute("column",l_column_name )
         
         IF ls_type = "i" THEN 
            LET l_candi = "input"
         ELSE
            IF g_properties.getValue("type_id") = "i02" THEN
               LET l_candi = "query"   
            ELSE
               LET l_candi = "construct"   
            END IF
         END IF
         
         #回頭檢查一下,至少要把BEFORE FIELD產出來 (提供Add-point區塊)
         IF li_genbfr THEN

            #採讀取樣板的方式增加add-point
            LET g_value = g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_column",g_value) 
            LET g_value = l_candi,".b.",ls_page,g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_point",g_value)
            LET l_return = l_return, adzp150_make_slice("a01")
            
            #LET l_return = l_return, (pi_lv*li_space) SPACES, "BEFORE FIELD ",l_column_name,"\n"
            #LET l_return = l_return, ((pi_lv+1)*li_space) SPACES, "#add-point:BEFORE FIELD ",g_properties.getValue("column"),"\n",
            #                         ((pi_lv+1)*li_space) SPACES, "{<point name=\"input.b.",ls_page,g_properties.getValue("column"),"\" />}","\n",
            #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"
         END IF
         
         #回頭檢查一下,至少要把AFTER FIELD產出來 (提供Add-point區塊)
         IF li_genaft THEN
            
            #若為c段, 且為common欄位(時間欄位) 
            IF ps_type = "c" AND ( l_column_name.getIndexOf("crtdt",l_column_name.getLength()-6) > 0 OR 
                                   l_column_name.getIndexOf("moddt",l_column_name.getLength()-6) > 0 OR 
                                   l_column_name.getIndexOf("cnfdt",l_column_name.getLength()-6) > 0 OR 
                                   l_column_name.getIndexOf("pstdt",l_column_name.getLength()-6) > 0) THEN
               
               #程式產生段落
               #LET g_dzbb.prog_name   = g_properties.getValue("app_id")
               #LET g_dzbb.point_name  = l_candi,".c.",g_properties.getValue("column")
               #LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
               #LET g_dzbb.addpoint    = adzp150_create_controlp_common(l_column_name,pi_lv+1)        
               #CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))
               CONTINUE FOR
            END IF
            
            #若為key欄位需做額外處理
            IF ps_type <> "c" THEN
               LET g_dzbb.prog_name   = g_properties.getValue("app_id")
               LET g_dzbb.point_name  = l_candi,".a.",ls_page,g_properties.getValue("column")
               LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
               LET g_dzbb.addpoint    = adzp150_key_field_chk(l_column,pi_lv)
               IF NOT cl_null(g_dzbb.addpoint) THEN
                  LET g_dzbb.addpoint = g_dzbb.addpoint, "\n"
                  CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))
               END IF
               CALL g_properties.addAttribute("column",l_column_name)
            END IF
            
            #採讀取樣板的方式增加add-point
            LET g_value = g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_column",g_value) 
            LET g_value = l_candi,".a.",ls_page,g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_point",g_value)
            #LET g_value = ls_next
            #CALL g_properties.addAttribute("mdl_next_field",g_value) 
            LET l_return = l_return, adzp150_make_slice("a02")
            #LET l_return = l_return, (pi_lv*li_space) SPACES, "AFTER FIELD ",l_column_name,"\n"
            #LET l_return = l_return, ((pi_lv+1)*li_space) SPACES, "#add-point:AFTER FIELD ",g_properties.getValue("column"),"\n",
            #                         ((pi_lv+1)*li_space) SPACES, "{<point name=\"input.a.",ls_page,g_properties.getValue("column"),"\" />}","\n",
            #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"
         END IF
         
         #回頭檢查一下,至少要把CONTROLP產出來 (提供Add-point區塊)
         IF li_genctp THEN
            
            LET l_column_name = g_properties.getValue("column")

            #若為c段, 且為common欄位(modu,oriu,user,orid,dept) 
            IF ps_type = "c" AND ( l_column_name.getIndexOf("crtdt",l_column_name.getLength()-6) > 0 OR 
                                   l_column_name.getIndexOf("moddt",l_column_name.getLength()-6) > 0 OR 
                                   l_column_name.getIndexOf("cnfdt",l_column_name.getLength()-6) > 0 OR 
                                   l_column_name.getIndexOf("pstdt",l_column_name.getLength()-6) > 0 ) THEN
               
               #程式產生段落
               #LET g_dzbb.prog_name   = g_properties.getValue("app_id")
               #LET g_dzbb.point_name  = l_candi,".c.",g_properties.getValue("column")
               #LET g_dzbb.point_ver   = g_properties.getValue("general_adp_ver")
               #LET g_dzbb.addpoint    = adzp150_create_controlp_common(l_column_name,pi_lv+1)        
               #CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))
               CONTINUE FOR
            END IF
            
            LET l_return = l_return, (pi_lv*li_space) SPACES, "#Ctrlp:",l_candi,".c.",ls_page,g_properties.getValue("column"),"\n"
            #採讀取樣板的方式增加add-point 

            LET g_value = g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_column",g_value) 
            LET g_value = l_candi,".c.",ls_page,g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_point",g_value)
            LET l_return = l_return, adzp150_make_slice("a03")

            #LET l_return = l_return, (pi_lv*li_space) SPACES, "ON ACTION controlp INFIELD ",l_column_name,"\n"
            #LET l_return = l_return, ((pi_lv+1)*li_space) SPACES, "#add-point:CONTROLP ",g_properties.getValue("column"),"\n",
            #                         ((pi_lv+1)*li_space) SPACES, "{<point name=\"",l_candi,".c.",ls_page,g_properties.getValue("column"),"\" />}","\n",
            #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"
         END IF
         
         #回頭檢查一下,至少要把ON CHANGE產出來 (提供Add-point區塊)
         IF li_genonc THEN
            #LET l_return = l_return, (pi_lv*li_space) SPACES, "ON CHANGE ",l_column_name,"\n"
            #LET l_return = l_return, ((pi_lv+1)*li_space) SPACES, "#add-point:ON CHANGE ",g_properties.getValue("column"),"\n",
            #                         ((pi_lv+1)*li_space) SPACES, "{<point name=\"input.g.",ls_page,g_properties.getValue("column"),"\" />}","\n",
            #                         ((li_space+1)*li_space) SPACES, "#END add-point\n\n"
            #採讀取樣板的方式增加add-point
            LET g_value = g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_column",g_value) 
            LET g_value = "input.g.",ls_page,g_properties.getValue("column")
            CALL g_properties.addAttribute("mdl_point",g_value)
            LET l_return = l_return, adzp150_make_slice("a04")
         END IF
      END IF
   END FOR 
   
   RETURN l_return
   
END FUNCTION 

#+ 取得所有狀態碼的資訊
PRIVATE FUNCTION adzp150_get_stus(pn_column,ps_loc)
   DEFINE pn_column      om.DomNode
   DEFINE ps_loc         STRING
   DEFINE ln_ctrl        om.DomNode
   DEFINE li_idx         INTEGER
   DEFINE li_cnt         INTEGER
   DEFINE ls_id          STRING
   DEFINE ls_pic         STRING
   DEFINE ls_name        STRING
   DEFINE ls_value       STRING  
   DEFINE ls_scc         STRING  
   DEFINE ls_stus_name   STRING  
   DEFINE ls_stus_list   STRING  
   
   LET li_cnt = 0
   IF pn_column.getChildCount() <= 2 AND ps_loc = 'detail' THEN
      RETURN
   END IF
   
   LET ls_scc = pn_column.getAttribute("scc") 
   LET ls_stus_name = pn_column.getAttribute("id") 
   LET ls_stus_list = ""
   
   FOR li_idx = 1 TO pn_column.getChildCount()
      LET ln_ctrl =  pn_column.getChildByIndex(li_idx)
      IF ln_ctrl.getTagName() = "stus" THEN
         LET li_cnt = li_cnt + 1
         LET ls_id = ln_ctrl.getAttribute("id") 
         LET ls_pic = ln_ctrl.getAttribute("pic") 
 
         IF ps_loc = 'master' THEN
            #定義id
            LET ls_name  = "general_stus_type", li_cnt USING "<<<"
            LET ls_value = ls_id
            CALL g_properties.addAttribute(ls_name,ls_value)
         ELSE
            LET ls_name = "general_stus_type", li_cnt USING "<<<"
            IF NOT cl_null(g_properties.getValue(ls_name)) THEN
               RETURN
            END IF
         END IF
         
         #定義id list
         LET ls_name  = ps_loc||"_stus_list"
         LET ls_value = g_properties.getValue(ps_loc||"_stus_list")
         IF cl_null(ls_value) THEN
            LET ls_value = ls_id 
         ELSE
            LET ls_value = ls_value, ",", ls_id
         END IF
         CALL g_properties.addAttribute(ls_name,ls_value)
         IF cl_null(ls_stus_list) THEN
            LET ls_stus_list = ls_id
         ELSE
            LET ls_stus_list = ls_stus_list, ",", ls_id
         END IF
         
         #定義pic
         LET ls_name  = "general_stus_pic", li_cnt USING "<<<"
         LET ls_value = ls_pic
         CALL g_properties.addAttribute(ls_name,ls_value)
         
      END IF
      
   END FOR
   
   LET ls_name  = "general_define_combo_stus"
   LET ls_value =  g_properties.getValue("general_define_combo_stus")
   LET ls_value = ls_value, "   CALL cl_set_combo_scc_part('",ls_stus_name,"','",ls_scc,"','",ls_stus_list,"')\n"
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   LET ls_name  = "general_stus_cnt"
   LET ls_value = li_cnt
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   LET ls_name  = "general_stus_list"
   LET ls_value = ls_stus_list
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   LET ls_name  = "general_stus_scc"
   LET ls_value = ls_scc
   CALL g_properties.addAttribute(ls_name,ls_value)
   
END FUNCTION


#+ 增加預設值填入段落
PUBLIC FUNCTION adzp150_make_default(pn_column,pi_page)
   DEFINE pn_column         om.DomNode #欄位資料節點
   DEFINE pi_page           INTEGER    #單身page
   DEFINE li_lv             INTEGER   
   DEFINE ls_location       STRING     #該欄位所在位置
   DEFINE ls_default        STRING     #設定預設值程式片段
   DEFINE ls_default_value  STRING     #該欄位預設值
   DEFINE ls_default_type   STRING     #該欄位預設值類型(S-固定內容,V-變數)
   DEFINE ls_name           STRING
   DEFINE ls_field          STRING     #欄位名稱
   DEFINE ls_var            STRING     #欄位變數名稱
   DEFINE ls_page           STRING     #單身page
   
   LET ls_location      = g_properties.getValue("location")
   LET ls_field         = pn_column.getAttribute("id") 
   LET ls_default_value = pn_column.getAttribute("default") 
   LET ls_default_type  = pn_column.getAttribute("type") 

   CASE 
      WHEN cl_null(ls_default_type) OR ls_default_type = 'S'
         LET ls_default_value = "\"",ls_default_value,"\""
      WHEN ls_default_type = 'V'
        
      OTHERWISE
         DISPLAY "不支援該欄位(",ls_field,")之預設值類型(",ls_default_type,")"
   
   END CASE
   
   CASE ls_location
      WHEN "head"
         LET li_lv = 2
         LET ls_default = g_properties.getValue("master_fields_default")
         LET ls_var = g_properties.getValue("master_var_title"),".",ls_field
         LET ls_default = ls_default,
                          (li_lv*li_space) SPACES, "LET ",ls_var," = ", ls_default_value, "\n"
         CALL g_properties.addAttribute("master_fields_default",ls_default)
       
      WHEN "body"
         LET li_lv = 2
         IF pi_page = 1 THEN
            LET ls_page = "detail_var_title"
            LET ls_name = "detail_fields_default"
         ELSE
            LET ls_page = "detail_var_title",pi_page USING "<<<"
            LET ls_name = "detail_fields_default",pi_page USING "<<<"
         END IF
         LET ls_page = g_properties.getValue(ls_page)
         LET ls_default = g_properties.getValue(ls_name)
         LET ls_var = ls_page,"[l_ac].",ls_field
         LET ls_default = ls_default,
                   (li_lv*li_space) SPACES, "LET ",ls_var," = ", ls_default_value, "\n"
         CALL g_properties.addAttribute(ls_name,ls_default)
   END CASE

END FUNCTION


#+ 增加combo scc填入段落
PUBLIC FUNCTION adzp150_make_combo(pn_column)
   DEFINE pn_column         om.DomNode   #欄位資料節點
   DEFINE pi_page           INTEGER      #單身page
   DEFINE ls_scc            STRING       #scc代碼
   DEFINE ls_field          STRING       #欄位名稱
   DEFINE ls_name           STRING
   DEFINE ls_value          STRING
   
   LET ls_field = pn_column.getAttribute("id") 
   LET ls_scc   = pn_column.getAttribute("def_scc") 
   
   IF cl_null(ls_scc) THEN
      RETURN
   END IF
   
   LET ls_name = "general_define_combo"
   LET ls_value = g_properties.getValue(ls_name)
   LET ls_value = ls_value, "   CALL cl_set_combo_scc('",ls_field,"','",ls_scc,"') \n"

   CALL g_properties.addAttribute(ls_name,ls_value)

END FUNCTION



