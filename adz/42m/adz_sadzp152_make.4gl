#adzp152 副程式 - 多page,key產生
## Modify........: No:YSC-E50003 14/05/19 By joyce 單頭串查功能調整
## Modify........: No:150529-00031 15/06/03 By joyce 調整FUNCTION adzp152_make_mdls()的回傳參數

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

#+ 根據tabx設定之page數量產生對應之page段落
PUBLIC FUNCTION adzp152_make_pages(pc_read,pc_write,pi_type)

   DEFINE pc_read       base.Channel
   DEFINE pc_write      base.Channel
   DEFINE pi_type       LIKE type_t.num5 
   DEFINE l_tmp         STRING 
   DEFINE l_tmp2        STRING 
   DEFINE l_page        DYNAMIC ARRAY OF STRING 
   DEFINE l_page_num    LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE l_is          STRING 
   DEFINE ls_name       STRING

   #先取出page段落之樣本
   WHILE TRUE 
      LET l_tmp = pc_read.readLine()
      CASE 
         WHEN l_tmp.getIndexOf("#pages -  End  -",1)
            EXIT WHILE 
         WHEN l_tmp.getIndexOf("#master_keys - Start -",1)
            CALL adzp152_make_keys_in_page(pc_read,pc_write,'m') RETURNING l_tmp,pc_read
         WHEN l_tmp.getIndexOf("#detail_keys - Start -",1)
            CALL adzp152_make_keys_in_page(pc_read,pc_write,'d') RETURNING l_tmp,pc_read
      END CASE
      LET l_page[1] = l_page[1],l_tmp , "\n"
   END WHILE 
   
   #取得page總數量
   LET l_page_num = g_properties.getValue("page")
    
   #根據page數量產生對應的page段落並進行資料取代
   FOR li_cnt = 2 TO l_page_num
   
      #input段才產生
      IF pi_type = 1 THEN
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_input", "<<<") 
         LET l_tmp = g_properties.getValue(l_tmp)
         LET l_tmp2 = adzp152_create_name(li_cnt, "general_page_detail", "<<<") 
         LET l_tmp2 = g_properties.getValue(l_tmp2)
         IF cl_null(l_tmp2) THEN
            LET l_tmp2 = "N"
         END IF
         IF l_tmp = "N" OR l_tmp2 = "Y" THEN
            CONTINUE FOR
         END IF
      END IF
      
      #單身的單身才產生
      IF pi_type = 2 THEN
         LET l_tmp2 = adzp152_create_name(li_cnt, "general_page_input", "<<<") 
         LET l_tmp2 = g_properties.getValue(l_tmp2)
         IF cl_null(l_tmp2) THEN
            LET l_tmp2 = "N"
         END IF
         IF l_tmp2 = "N" THEN
            CONTINUE FOR
         END IF
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_detail", "<<<") 
         LET l_tmp = g_properties.getValue(l_tmp)
         IF cl_null(l_tmp) THEN
            LET l_tmp = "N"
         END IF
         IF l_tmp = "N" THEN
            CONTINUE FOR
         END IF
      END IF
      
      #display段才產生(單身)
      IF pi_type = 3 THEN
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_input", "<<<") 
         LET l_tmp = g_properties.getValue(l_tmp)
         LET l_tmp2 = adzp152_create_name(li_cnt, "general_page_detail", "<<<") 
         LET l_tmp2 = g_properties.getValue(l_tmp2)
         IF cl_null(l_tmp2) THEN
            LET l_tmp2 = "N"
         END IF
         IF l_tmp = "Y" OR l_tmp2 = "Y" THEN
            CONTINUE FOR
         END IF
      END IF
      
      #單身的單身才產生(display)
      IF pi_type = 4 THEN
         LET l_tmp2 = adzp152_create_name(li_cnt, "general_page_input", "<<<") 
         LET l_tmp2 = g_properties.getValue(l_tmp2)
         IF cl_null(l_tmp2) THEN
            LET l_tmp2 = "N"
         END IF
         IF l_tmp2 = "Y" THEN
            CONTINUE FOR
         END IF
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_detail", "<<<") 
         LET l_tmp = g_properties.getValue(l_tmp)
         IF cl_null(l_tmp) THEN
            LET l_tmp = "N"
         END IF
         IF l_tmp = "N" THEN
            CONTINUE FOR
         END IF
      END IF
      
      #單身的單頭才產生(所有段落)
      IF pi_type = 5 THEN
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_detail", "<<<") 
         LET l_tmp = g_properties.getValue(l_tmp)
         IF l_tmp = "Y" OR cl_null(l_tmp) THEN
            CONTINUE FOR
         END IF
      END IF
      
      #單身的單身才產生(所有段落)
      IF pi_type = 6 THEN
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_detail", "<<<") 
         LET l_tmp = g_properties.getValue(l_tmp)
         IF l_tmp = "N" OR cl_null(l_tmp) THEN
            CONTINUE FOR
         END IF
      END IF
      
      #先將${page}取代掉
      LET l_is = li_cnt
      LET l_page[li_cnt] = #(2*li_space) SPACES, "#Page",l_is,"\n",
                        adzp152_replace_page(l_page[1],li_cnt)
                        
      #針對不同的page進行key取代
      LET l_page[li_cnt] = adzp152_make_keys_in_multi_table(l_page[li_cnt],li_cnt)
      
      #若資料未取代完成則重複返回
      WHILE l_page[li_cnt].getIndexOf("${",1) > 0 
         LET l_page[li_cnt] = adzp152_line_replace(l_page[li_cnt])
      END WHILE  

      #回寫到檔案中
      CALL pc_write.write( l_page[li_cnt] )
   END FOR    
   
   RETURN pc_read,pc_write
   
END FUNCTION 

#+ 根據tabx設定之key數量產生對應之key段落
PUBLIC FUNCTION adzp152_make_keys(pc_read,pc_write,l_type)

   DEFINE pc_read       base.Channel
   DEFINE pc_write      base.Channel
   DEFINE l_type        STRING 
   DEFINE l_tmp         STRING 
   DEFINE l_key         DYNAMIC ARRAY OF STRING 
   DEFINE l_key_num     LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE l_is          STRING 
   
   #先取出key段落之樣本
   WHILE TRUE 
      LET l_tmp = pc_read.readLine()
      IF l_tmp.getIndexOf("#keys -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_key[1] = l_key[1],l_tmp , "\n"
   END WHILE 

   #取得key總數量
   IF l_type = 'm' THEN
      LET l_key_num = g_properties.getValue("master_pk_num")
   ELSE
      LET l_key_num = g_properties.getValue("detail_pk_num")
   END IF

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_key_num
      
      #先將${key}取代掉
      LET l_is = li_cnt
      LET l_key[li_cnt] = #(2*li_space) SPACES, "#key",l_is,"\n",
                        adzp152_replace_key(l_key[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE l_key[li_cnt].getIndexOf("${",1) > 0 
         LET l_key[li_cnt] = adzp152_line_replace(l_key[li_cnt])
      END WHILE  

      #回寫到檔案中
      CALL pc_write.write( l_key[li_cnt] )
      
   END FOR    
   RETURN pc_read,pc_write
   
END FUNCTION 

#+ 根據tabx設定之table數量產生對應之table段落
PUBLIC FUNCTION adzp152_make_tables(pc_read,pc_write,pi_type)

   DEFINE pc_read       base.Channel
   DEFINE pc_write      base.Channel
   DEFINE pi_type       LIKE type_t.num5 
   DEFINE l_tmp         STRING 
   DEFINE l_table       DYNAMIC ARRAY OF STRING 
   DEFINE l_table_num   LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE l_is          STRING 
   DEFINE ls_name       STRING 
   
   #先取出table段落之樣本
   WHILE TRUE 
      LET l_tmp = pc_read.readLine()
      CASE 
         WHEN l_tmp.getIndexOf("#tables -  End  -",1)
            EXIT WHILE 
         WHEN l_tmp.getIndexOf("#master_keys - Start -",1)
            CALL adzp152_make_keys_in_table(pc_read,pc_write,'m') RETURNING l_tmp,pc_read
         WHEN l_tmp.getIndexOf("#detail_keys - Start -",1)
            CALL adzp152_make_keys_in_table(pc_read,pc_write,'d') RETURNING l_tmp,pc_read
      END CASE
      LET l_table[1] = l_table[1],l_tmp , "\n"
   END WHILE 

   #取得table總數量
   LET l_table_num = g_properties.getValue("detail_table_num")

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_table_num
   
      LET ls_name = adzp152_create_name(li_cnt, "detail_tbl_link", "<<<")

      #主table才產出
      IF pi_type = 1 AND g_properties.getValue(ls_name) <> '0' THEN
         CONTINUE FOR
      END IF

      #副table才產出
      IF pi_type = 2 AND g_properties.getValue(ls_name) = '0' THEN
         CONTINUE FOR
      END IF
      
      LET l_tmp = adzp152_create_name(li_cnt, "detail_tbl_type_by_tbl", "<<<") 
      LET l_tmp = g_properties.getValue(l_tmp)
      IF NOT (cl_null(l_tmp) OR l_tmp = "N") AND pi_type <> 3THEN
         CONTINUE FOR
      END IF
      
      #副table的table才產出 
      LET l_tmp = adzp152_create_name(li_cnt, "detail_tbl_type_by_tbl", "<<<") 
      LET l_tmp = g_properties.getValue(l_tmp)
      IF pi_type = 3 AND (l_tmp ="N" OR cl_null(l_tmp)) THEN
         CONTINUE FOR
      END IF
      
      #先將${table}取代掉
      LET l_is = li_cnt
      LET l_table[li_cnt] = #(2*li_space) SPACES, "#table",l_is,"\n",
                        adzp152_replace_table(l_table[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE l_table[li_cnt].getIndexOf("${",1) > 0 
         LET l_table[li_cnt] = adzp152_line_replace(l_table[li_cnt])
      END WHILE  

      #回寫到檔案中
      CALL pc_write.write(l_table[li_cnt])
      
   END FOR    
   RETURN pc_read,pc_write
   
END FUNCTION 

#+ 取代${page}並帶入實際數字
PUBLIC FUNCTION adzp152_replace_page(p_page, p_i)

   DEFINE p_page   STRING 
   DEFINE p_i      STRING 
   DEFINE l_s      LIKE type_t.num5 
   DEFINE l_e      LIKE type_t.num5 
   DEFINE l_page   STRING 
   DEFINE l_id    STRING 
   
   LET l_id = adzp152_page_trans(p_i)
   
   LET l_page = p_page

   WHILE TRUE 
      IF l_page.getIndexOf("${page}",1) > 0 THEN
         LET l_s = l_page.getIndexOf("${page}",1) - 1
         LET l_e = l_page.getLength()
         #取代${page}
         LET l_page = l_page.subString(1,l_s), p_i,l_page.subString((l_s+8),l_e)
         LET l_page = l_page
      END IF
      
      IF l_page.getIndexOf("${page_id}",1) > 0 THEN
         LET l_s = l_page.getIndexOf("${page_id}",1) - 1
         LET l_e = l_page.getLength()
         #取代${page_id}
         LET l_page = l_page.subString(1,l_s), l_id,l_page.subString((l_s+11),l_e)
         LET l_page = l_page
      END IF
      
      IF l_page.getIndexOf("${page}",1) < 1 AND l_page.getIndexOf("${page_id}",1) < 1 THEN 
          EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN l_page
   
END FUNCTION 

#+ 取代${key}並帶入實際數字
PUBLIC FUNCTION adzp152_replace_key(p_key, p_i)

   DEFINE p_key    STRING 
   DEFINE p_i      STRING 
   DEFINE l_s      LIKE type_t.num5 
   DEFINE l_e      LIKE type_t.num5 
   DEFINE l_key    STRING 

   WHILE TRUE 
      LET l_s = p_key.getIndexOf("${key}",1) - 1
      LET l_e = p_key.getLength()
      #取代${key}
      LET l_key = p_key.subString(1,l_s), p_i USING "&&"
      LET l_key = l_key, p_key.subString((l_s+7),l_e)
      LET p_key = l_key
      IF l_key.getIndexOf("${key}",1) < 1 THEN 
          EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN l_key
   
END FUNCTION 

#+ 取代${table}並帶入實際數字
PUBLIC FUNCTION adzp152_replace_table(p_table, p_i)

   DEFINE p_table   STRING 
   DEFINE p_i      STRING 
   DEFINE l_s      LIKE type_t.num5 
   DEFINE l_e      LIKE type_t.num5 
   DEFINE l_table   STRING 

   WHILE TRUE 
      LET l_s = p_table.getIndexOf("${table}",1) - 1
      LET l_e = p_table.getLength()
      #取代${table}
      LET l_table = p_table.subString(1,l_s), p_i,p_table.subString((l_s+9),l_e)
      LET p_table = l_table
      IF l_table.getIndexOf("${table}",1) < 1 THEN 
          EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN l_table
   
END FUNCTION 

#+ 根據tabx設定之key數量產生對應之key段落(但不回寫tgl)
PUBLIC FUNCTION adzp152_make_keys_in_page(pc_read,pc_write,l_type)

   DEFINE pc_read       base.Channel
   DEFINE pc_write      base.Channel
   DEFINE l_type        STRING 
   DEFINE l_tmp         STRING 
   DEFINE l_key         DYNAMIC ARRAY OF STRING 
   DEFINE l_key_num     LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE l_is          STRING 
   DEFINE ls_return     STRING
   
   #先取出key段落之樣本
   WHILE TRUE 
      LET l_tmp = pc_read.readLine()
      IF l_tmp.getIndexOf("#keys -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_key[1] = l_key[1],l_tmp , "\n"
   END WHILE 

   #取得key總數量
   IF l_type = 'm' THEN
      LET l_key_num = g_properties.getValue("master_pk_num")
   ELSE
      LET l_key_num = g_properties.getValue("detail_pk_num")
   END IF

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_key_num
      
      #先將${key}取代掉
      LET l_is = li_cnt
      LET l_key[li_cnt] = #(2*li_space) SPACES, "#key",l_is,"\n",
                        adzp152_replace_key(l_key[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE l_key[li_cnt].getIndexOf("${",1) > 0 
         LET l_key[li_cnt] = adzp152_line_replace(l_key[li_cnt])
      END WHILE  

      #回寫到檔案中
      LET ls_return = ls_return, l_key[li_cnt], "\n"
      
   END FOR 

   RETURN ls_return,pc_read
   
END FUNCTION 

#+ 根據tabx設定之key數量產生對應之key段落(但不回寫tgl)
PUBLIC FUNCTION adzp152_make_keys_in_table(pc_read,pc_write,l_type)

   DEFINE pc_read       base.Channel
   DEFINE pc_write      base.Channel
   DEFINE l_type        STRING 
   DEFINE l_tmp         STRING 
   DEFINE l_key         DYNAMIC ARRAY OF STRING 
   DEFINE l_key_num     LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE l_is          STRING 
   DEFINE ls_return     STRING
   
   #先取出key段落之樣本
   WHILE TRUE 
      LET l_tmp = pc_read.readLine()
      IF l_tmp.getIndexOf("#keys -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_key[1] = l_key[1],l_tmp , "\n"
   END WHILE 

   #取得key總數量
   IF l_type = 'm' THEN
      LET l_key_num = g_properties.getValue("master_pk_num")
   ELSE
      LET l_key_num = g_properties.getValue("detail_pk_num")
   END IF

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_key_num
      
      #先將${key}取代掉
      LET l_is = li_cnt
      LET l_key[li_cnt] = #(2*li_space) SPACES, "#key",l_is,"\n",
                        adzp152_replace_key(l_key[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE l_key[li_cnt].getIndexOf("${key",1) > 0 
         LET l_key[li_cnt] = adzp152_line_replace(l_key[li_cnt])
      END WHILE  

      #回寫到檔案中
      LET ls_return = ls_return, l_key[li_cnt], "\n"
      
   END FOR 

   RETURN ls_return,pc_read
   
END FUNCTION 

#+ 若該page沒有主table欄位則進行特定段落隱藏
PUBLIC FUNCTION adzp152_page_mark()
   
   DEFINE li_page          INTEGER
   DEFINE ls_fields        STRING
   DEFINE ls_key_fields    STRING
   DEFINE ls_page          STRING
   DEFINE ls_table_pre     STRING
   DEFINE ls_tmp           STRING
   DEFINE ls_tmp2          STRING
   DEFINE li_idx           INTEGER
   DEFINE lst_token        base.StringTokenizer
   DEFINE ls_token         STRING
   
   #取得總page數量
   LET li_page = g_properties.getValue("page")  
   
   LET ls_tmp = g_properties.getValue("detail_tbl_name")
   
   LET ls_table_pre = ls_tmp.subString(1,ls_tmp.getIndexOf("_",1)-1)
   
   LET ls_key_fields = g_properties.getValue("detail_field_pks")
   
   FOR li_idx = 1 TO li_page
   
      LET ls_page = li_idx USING "<<<"
   
      LET ls_tmp = "page",ls_page,"_mark"
      
      LET ls_fields = g_properties.getValue("detail_page_field"||ls_page)
      
      IF ls_fields.getIndexOf(ls_table_pre,1) = 0 THEN
         CALL g_properties.addAttribute(ls_tmp,"#此page無主要表格欄位 ")
      ELSE
         LET ls_tmp2 = g_properties.getValue("detail_multi_table_delete"||ls_page)
         CALL g_properties.addAttribute("detail_multi_table_delete_chk"||ls_page,ls_tmp2)
      END IF
      
      LET lst_token = base.StringTokenizer.create(ls_key_fields, ',')
      WHILE lst_token.hasMoreTokens()
         LET ls_token = lst_token.nextToken()
         LET ls_fields = cl_replace_str(ls_fields,ls_token,"")
      END WHILE
      
      LET ls_tmp = "page",ls_page,"_mark_ins"
      IF ls_fields.getIndexOf(ls_table_pre,1) = 0 THEN
         CALL g_properties.addAttribute(ls_tmp,"#此page無key以外主要表格欄位 ")
      END IF
   
   END FOR

END FUNCTION


#+ 
PUBLIC FUNCTION adzp152_make_keys_in_multi_table(ps_string,ps_num)
   DEFINE ps_string    STRING
   DEFINE ps_num       INTEGER
   DEFINE lst_token    base.StringTokenizer
   DEFINE ls_token     STRING
   DEFINE ls_return    STRING
   DEFINE ls_key_tmp   STRING
   DEFINE ls_key       STRING
   DEFINE ls_name      STRING
   DEFINE li_mkey_num  INTEGER
   DEFINE li_dkey_num  INTEGER
   DEFINE li_key_num   INTEGER
   DEFINE li_cnt       INTEGER
   
   LET li_mkey_num = g_properties.getValue("master_pk_num")
   LET ls_name = adzp152_create_name(ps_num,"detail_pk_num", "<<<")
   LET li_dkey_num = g_properties.getValue(ls_name)

   LET lst_token = base.StringTokenizer.create(ps_string, '\n')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_key = ""
      IF ls_token.getIndexOf("_page_keys - Start -",1) THEN
         IF ls_token.getIndexOf("master_page_keys - Start -",1) THEN
            LET li_key_num = li_mkey_num
         ELSE
            LET li_key_num = li_dkey_num
         END IF
         LET ls_token = lst_token.nextToken()
         WHILE ls_token.getIndexOf("#keys -  End  -",1) = 0
            LET ls_key = ls_key, ls_token, '\n'
            LET ls_token = lst_token.nextToken()
         END WHILE
         
         #根據key數量產生對應的key段落並進行資料取代
         FOR li_cnt = 2 TO li_key_num
            LET ls_key_tmp = ls_key 
            
            #先將${key}取代掉
            LET ls_key_tmp = #(3*li_space) SPACES, 
                             #"#key - ",li_cnt USING "<<<","\n",
                             adzp152_replace_key(ls_key_tmp,li_cnt)
                              
            #若資料未取代完成則重複返回
            WHILE ls_key_tmp.getIndexOf("${",1) > 0 
               LET ls_key_tmp = adzp152_line_replace(ls_key_tmp)
            END WHILE  
            
            LET ls_return = ls_return, ls_key_tmp, '\n'
            
         END FOR 
      ELSE
         LET ls_return = ls_return, ls_token, '\n'
      END IF
   END WHILE
   
   RETURN ls_return

END FUNCTION

#rtn產生
PUBLIC FUNCTION adzp152_make_rtns(ps_read)
   DEFINE ps_read       base.Channel
   DEFINE ls_rtn        DYNAMIC ARRAY OF STRING 
   DEFINE li_rtn_num    LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE ls_is         STRING 
   DEFINE ls_return     STRING
   DEFINE ls_tmp        STRING
   
   #先取出rtn段落之樣版
   WHILE TRUE 
      LET ls_tmp = ps_read.readLine()
      IF ls_tmp.getIndexOf("#rtns -  End  -",1) THEN
         EXIT WHILE 
      END IF
      LET ls_rtn[1] = ls_rtn[1], ls_tmp
   END WHILE 
   
   #總數量
   LET li_rtn_num = g_properties.getValue("mdl_rtns")
   
   #根據rtn數量產生對應的rtn段落並進行資料取代
   FOR li_cnt = 2 TO li_rtn_num
      
      #先將${rtns}取代掉
      LET ls_is = li_cnt
      LET ls_rtn[li_cnt] = adzp152_replace_rtns(ls_rtn[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_rtn[li_cnt].getIndexOf("${",1) > 0 
         LET ls_rtn[li_cnt] = adzp152_line_replace(ls_rtn[li_cnt])
      END WHILE  
      LET ls_return = ls_return, ls_rtn[li_cnt], '\n'
      
   END FOR    
   
   RETURN ls_return, ps_read
   
END FUNCTION 

#將${rtn}取代為號碼
PUBLIC FUNCTION adzp152_replace_rtns(ps_rtn, pi_i)
   DEFINE ps_rtn   STRING 
   DEFINE pi_i     STRING 
   DEFINE li_s     LIKE type_t.num5 
   DEFINE li_e     LIKE type_t.num5 
   DEFINE ls_rtn   STRING 

   WHILE TRUE 
      LET li_s = ps_rtn.getIndexOf("${rtns}",1) - 1
      LET li_e = ps_rtn.getLength()
      #取代${rtns}
      LET ls_rtn = ps_rtn.subString(1,li_s), pi_i, ps_rtn.subString((li_s+8),li_e)
      LET ps_rtn = ls_rtn
      IF ls_rtn.getIndexOf("${rtns}",1) < 1 THEN 
         EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN ls_rtn
   
END FUNCTION 

#arg產生
PUBLIC FUNCTION adzp152_make_args(ps_read)
   DEFINE ps_read       base.Channel
   DEFINE ls_arg        DYNAMIC ARRAY OF STRING 
   DEFINE ls_arg_mdl    STRING 
   DEFINE li_arg_num    LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE ls_is         STRING 
   DEFINE ls_return     STRING
   DEFINE ls_tmp        STRING
   
   #先取出arg段落之樣板
   WHILE TRUE 
      LET ls_tmp = ps_read.readLine()
      IF ls_tmp.getIndexOf("#args -  End  -",1) THEN
         EXIT WHILE 
      END IF
      LET ls_arg_mdl = ls_arg_mdl, ls_tmp
   END WHILE 
   
   #總數量
   LET li_arg_num = g_properties.getValue("mdl_args")
   
   #根據arg數量產生對應的arg段落並進行資料取代
   FOR li_cnt = 1 TO li_arg_num
      
      #先將${args}取代掉 
      LET ls_is = li_cnt
      LET ls_arg[li_cnt] = adzp152_replace_args(ls_arg_mdl,li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_arg[li_cnt].getIndexOf("${",1) > 0 
         LET ls_arg[li_cnt] = adzp152_line_replace(ls_arg[li_cnt])
      END WHILE  
      LET ls_return = ls_return, ls_arg[li_cnt], '\n'
      
   END FOR    
   
   RETURN ls_return, ps_read
   
END FUNCTION 

#將${arg}取代為號碼
PUBLIC FUNCTION adzp152_replace_args(ps_arg, pi_i)
   DEFINE ps_arg   STRING 
   DEFINE pi_i     STRING 
   DEFINE li_s     LIKE type_t.num5 
   DEFINE li_e     LIKE type_t.num5 
   DEFINE ls_arg   STRING 

   WHILE TRUE 
      LET li_s = ps_arg.getIndexOf("${args}",1) - 1
      LET li_e = ps_arg.getLength()
      #取代${args}
      LET ls_arg = ps_arg.subString(1,li_s), pi_i, ps_arg.subString((li_s+8),li_e)
      LET ps_arg = ls_arg
      IF ls_arg.getIndexOf("${args}",1) < 1 THEN 
          EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN ls_arg
   
END FUNCTION 


#mdl產生
#PUBLIC FUNCTION adzp152_make_mdls(ps_read)         #YSC-E50003 mark
PUBLIC FUNCTION adzp152_make_mdls(ps_read,pi_num)   #YSC-E50003 add pi_num
   DEFINE ps_read       base.Channel
   DEFINE pi_num        LIKE type_t.num5         #YSC-E50003 add
   DEFINE ls_mdl        DYNAMIC ARRAY OF STRING  #是第幾組mdl
   DEFINE li_mdl_num    LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE ls_is         STRING 
   DEFINE ls_return     STRING
   DEFINE ls_tmp        STRING
   
   #先取出mdl段落之樣版
   WHILE TRUE 
      LET ls_tmp = ps_read.readLine()
      IF ls_tmp.getIndexOf("#mdls -  End  -",1) THEN
         LET ls_mdl[1] = ls_mdl[1].subString(1,ls_mdl[1].getLength()-1)   #YSC-E50003 add
         EXIT WHILE 
      END IF
      LET ls_mdl[1] = ls_mdl[1], ls_tmp, '\n'
   END WHILE 
   
   #總數量
#  LET li_mdl_num = g_properties.getValue("mdl_mdls")            #YSC-E50003 mark
   LET ls_tmp = adzp152_create_name(pi_num, "mdl_mdls", "<<<")   #YSC-E50003 add
   LET li_mdl_num = g_properties.getValue(ls_tmp)                #YSC-E50003 add
  
   #根據mdl數量產生對應的mdl段落並進行資料取代
   FOR li_cnt = 2 TO li_mdl_num
      
      #先將${mdls}取代掉
      LET ls_is = li_cnt
      LET ls_mdl[li_cnt] = adzp152_replace_mdls(ls_mdl[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_mdl[li_cnt].getIndexOf("${",1) > 0 
         LET ls_mdl[li_cnt] = adzp152_line_replace(ls_mdl[li_cnt])
      END WHILE  
      LET ls_return = ls_return, ls_mdl[li_cnt]

      #YSC-E50003 ---start---
      IF li_cnt < li_mdl_num THEN
         LET ls_return = ls_return, '\n'
      END IF
      #YSC-E50003 --- end ---
   END FOR    

#  RETURN ls_return, ps_read   #150529-00031
   RETURN ps_read, ls_return
   
END FUNCTION 

#將${mdl}取代為號碼
PUBLIC FUNCTION adzp152_replace_mdls(ps_mdl, pi_i)
   DEFINE ps_mdl   STRING 
   DEFINE pi_i     STRING 
   DEFINE li_s     LIKE type_t.num5 
   DEFINE li_e     LIKE type_t.num5 
   DEFINE ls_mdl   STRING 

   WHILE TRUE 
   #  LET li_s = ps_mdl.getIndexOf("${mdls}",1) - 1   #YSC-E50003 mark
      LET li_s = ps_mdl.getIndexOf("${mdl}",1) - 1    #YSC-E50003 modify
      LET li_e = ps_mdl.getLength()
      #取代${mdls}
   #  LET ls_mdl = ps_mdl.subString(1,li_s), pi_i, ps_mdl.subString((li_s+8),li_e)   #YSC-E50003 mark
      LET ls_mdl = ps_mdl.subString(1,li_s), pi_i, ps_mdl.subString((li_s+7),li_e)   #YSC-E50003 modify
      LET ps_mdl = ls_mdl
   #  IF ls_mdl.getIndexOf("${mdls}",1) < 1 THEN   #YSC-E50003 mark
      IF ls_mdl.getIndexOf("${mdl}",1) < 1 THEN    #YSC-E50003 modify
         EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN ls_mdl
   
END FUNCTION 


#loop產生
PUBLIC FUNCTION adzp152_make_loop(pc_read,pc_write,pc_type)
   DEFINE pc_read       base.Channel
   DEFINE pc_write      base.Channel
   DEFINE pc_type       LIKE type_t.chr1
   DEFINE ls_loop_str   STRING
   DEFINE ls_loop       DYNAMIC ARRAY OF STRING
   DEFINE li_loop_num   LIKE type_t.num5
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE ls_is         STRING
   DEFINE ls_return     STRING
   DEFINE ls_tmp        STRING

   #先取出loop段落之樣版
   WHILE TRUE
      LET ls_tmp = pc_read.readLine()
      IF ls_tmp.getIndexOf("#loop_times -  End  -",1) THEN
         EXIT WHILE
      END IF
      LET ls_loop_str = ls_loop_str, ls_tmp,"\n"
   END WHILE

   CASE
      WHEN pc_type = "A"
         #總數量
         LET li_loop_num = g_properties.getValue("master_maintain_prog_parameter_cnt")
   END CASE

   IF li_loop_num > 0 THEN
      #根據loop數量產生對應的loop段落並進行資料取代
      FOR li_cnt = 1 TO li_loop_num

         #先將${loop_no}取代掉
         LET ls_is = li_cnt
         LET ls_loop[li_cnt] = adzp152_replace_loop(ls_loop_str,li_cnt)

         #若資料未取代完成則重複返回
         WHILE ls_loop[li_cnt].getIndexOf("${",1) > 0
            LET ls_loop[li_cnt] = adzp152_line_replace(ls_loop[li_cnt])
         END WHILE

         #回寫到檔案中
         CALL pc_write.write( ls_loop[li_cnt] )

      END FOR
   END IF

   RETURN pc_read, pc_write

END FUNCTION

#將${loop_no}取代為號碼
PUBLIC FUNCTION adzp152_replace_loop(ps_loop, pi_i)
   DEFINE ps_loop        STRING
   DEFINE pi_i           STRING
   DEFINE li_s           LIKE type_t.num5
   DEFINE li_e           LIKE type_t.num5
   DEFINE ls_loop        STRING

   WHILE TRUE
      LET li_s = ps_loop.getIndexOf("${loop_no}",1) - 1
      LET li_e = ps_loop.getLength()
      #取代${loop_no}

      LET ls_loop = ps_loop.subString(1,li_s), pi_i, ps_loop.subString((li_s+11),li_e)
      LET ps_loop = ls_loop
      IF ls_loop.getIndexOf("${loop_no}",1) < 1 THEN
         EXIT WHILE
      END IF
   END WHILE

   RETURN ls_loop

END FUNCTION


