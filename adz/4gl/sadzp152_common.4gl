#adzp152 副程式 - 公用欄位相關處理

GLOBALS
   DEFINE g_properties   om.SaxAttributes
   CONSTANT li_space = 3
END GLOBALS

PUBLIC FUNCTION adzp152_create_common()
   DEFINE ls_m_tbl          STRING
   DEFINE ls_d_tbl          STRING
   DEFINE ls_slice          STRING
   DEFINE ls_common         STRING
   DEFINE ls_exist          STRING
   DEFINE ls_tbl_common     DYNAMIC ARRAY OF RECORD
          name  STRING,
          exist STRING
          END RECORD
   DEFINE ls_common_name    DYNAMIC ARRAY OF STRING
   DEFINE li_idx            INTEGER
   DEFINE li_idx2           INTEGER
   DEFINE ls_tmp            STRING
   DEFINE ls_name           STRING
   DEFINE ls_value          STRING
   DEFINE ls_tbl_pre        STRING
   DEFINE ls_pages          STRING
   DEFINE lst_token         base.StringTokenizer
   DEFINE ls_token          STRING
   DEFINE ls_title_pre      STRING
   
   LET ls_common_name[1]  = "ownid"
   LET ls_common_name[2]  = "owndp"
   LET ls_common_name[3]  = "crtid"
   LET ls_common_name[4]  = "crtdp"
   LET ls_common_name[5]  = "crtdt"
   LET ls_common_name[6]  = "modid"
   LET ls_common_name[7]  = "moddt"
   LET ls_common_name[8]  = "cnfid"
   LET ls_common_name[9]  = "cnfdt"
   LET ls_common_name[10] = "pstid"
   LET ls_common_name[11] = "pstdt"
   LET ls_common_name[12] = "stus"
   
   #單頭段處理
   FOR li_idx = 1 TO g_properties.getValue("master_tbl_cnt")
   
      INITIALIZE ls_tbl_common TO NULL
      
      LET ls_tmp =  adzp152_create_name(li_idx, "master_tbl_name_by_tbl", "<<<") 
      LET ls_tmp = g_properties.getValue(ls_tmp)
      LET ls_tbl_pre = ls_tmp.subString(1,ls_tmp.getIndexOf("_",1)-1)
      
      #tbl name
      LET ls_name = "mdl_tbl_name"
      LET ls_value = ls_tmp
      CALL g_properties.addAttribute(ls_name, ls_value)
      
      LET ls_exist = "N"
      #組合各table公用欄位名稱並判斷是否存在
      FOR li_idx2 = 1 TO ls_common_name.getLength()
         LET ls_tbl_common[li_idx2].name = ls_tbl_pre, ls_common_name[li_idx2]
         LET ls_tbl_common[li_idx2].exist = adzp152_chk_field_exist(ls_tbl_common[li_idx2].name)
         IF ls_tbl_common[li_idx2].exist = "Y" THEN
            LET ls_exist = "Y"
         END IF
      END FOR
      
      IF ls_exist = "Y" THEN
      
         #將公用欄位名稱加入mdl變數中
         LET ls_tmp = adzp152_create_name(li_idx, "master_var_title", "<<<") 
         LET ls_title_pre = g_properties.getValue(ls_tmp),"."
         
         FOR li_idx2 = 1 TO ls_tbl_common.getLength()
            #前置字元
            LET ls_name = adzp152_create_name(li_idx2, "mdl_var_title", "&&")
            LET ls_value = ls_title_pre
            CALL g_properties.addAttribute(ls_name, ls_value)
            #不存在則mark
            IF ls_tbl_common[li_idx2].exist = "N" THEN
               LET ls_value = "#"
            ELSE
               LET ls_value = ""
            END IF
            LET ls_name = adzp152_create_name(li_idx2, "mdl_mark", "&&")
            CALL g_properties.addAttribute(ls_name, ls_value)
            #欄位名稱
            LET ls_name = adzp152_create_name(li_idx2, "mdl_field", "&&")
            LET ls_value = ls_tbl_common[li_idx2].name
            CALL g_properties.addAttribute(ls_name, ls_value)
            #變數名稱
            LET ls_name = adzp152_create_name(li_idx2, "mdl_var", "&&")
            LET ls_value = ls_title_pre, ls_tbl_common[li_idx2].name
            CALL g_properties.addAttribute(ls_name, ls_value)
            #變數名稱(pre)
            LET ls_name = adzp152_create_name(li_idx2, "mdl_pre", "&&")
            LET ls_value = ls_tbl_common[li_idx2].name
            CALL g_properties.addAttribute(ls_name, ls_value)
         END FOR
         
         CALL g_properties.addAttribute("mdl_var_title",ls_title_pre)
         CALL g_properties.addAttribute("mdl_loc", "master")
      
         #公用欄位開窗
         LET ls_slice = g_properties.getValue("master_commons_ctrlp")
         LET ls_slice = ls_slice, adzp152_make_slice("a11")
         CALL g_properties.addAttribute("master_commons_ctrlp",ls_slice)
         
         #公用欄位帶值
         LET ls_slice = g_properties.getValue("master_commons_ref")
         LET ls_slice = ls_slice, adzp152_make_slice("a12")
         CALL g_properties.addAttribute("master_commons_ref",ls_slice)
         
         #公用欄位複製給值
         LET ls_slice = g_properties.getValue("master_repro_define")
         LET ls_slice = ls_slice, adzp152_make_slice("a13")
         CALL g_properties.addAttribute("master_repro_define",ls_slice)
         
         #公用欄位新增給值 
         LET ls_slice = g_properties.getValue("master_insert_define")
         LET ls_slice = ls_slice, adzp152_make_slice("a14")
         CALL g_properties.addAttribute("master_insert_define",ls_slice)
         
         #公用欄位owner定義
         #LET ls_slice = g_properties.getValue("master_owner_define")
         #LET ls_slice = ls_slice, adzp152_common_create_owner(li_idx)
         #CALL g_properties.addAttribute("master_owner_define",ls_slice)
         
      END IF
      
   END FOR
   
   #單身段處理
   FOR li_idx = 1 TO g_properties.getValue("detail_tbl_cnt")
   
      INITIALIZE ls_tbl_common TO NULL
      
      LET ls_tmp =  adzp152_create_name(li_idx, "detail_tbl_name_by_tbl", "<<<") 
      LET ls_tmp = g_properties.getValue(ls_tmp)
      LET ls_tbl_pre = ls_tmp.subString(1,ls_tmp.getIndexOf("_",1)-1)
      
      LET ls_exist = "N"
      #組合各table公用欄位名稱並判斷是否存在
      FOR li_idx2 = 1 TO ls_common_name.getLength()
         LET ls_tbl_common[li_idx2].name = ls_tbl_pre, ls_common_name[li_idx2]
         LET ls_tbl_common[li_idx2].exist = adzp152_chk_field_exist(ls_tbl_common[li_idx2].name)
         IF ls_tbl_common[li_idx2].exist = "Y" THEN
            LET ls_exist = "Y"
         END IF
      END FOR

      IF ls_exist = "Y" THEN

         #將公用欄位名稱加入mdl變數中
         FOR li_idx2 = 1 TO ls_tbl_common.getLength()
            #不存在則mark
            IF ls_tbl_common[li_idx2].exist = "N" THEN
               LET ls_value = "#"
            ELSE
               LET ls_value = ""
            END IF
            LET ls_name = adzp152_create_name(li_idx2, "mdl_mark", "&&")
            CALL g_properties.addAttribute(ls_name, ls_value)
            #前置字元
            LET ls_tmp = adzp152_create_name(li_idx, "detail_tbl_pages", "<<<") 
            LET ls_tmp = g_properties.getValue(ls_tmp)
            LET ls_title_pre = adzp152_find_page(ls_tbl_common[li_idx2].name,ls_tmp),'.'
            LET ls_name = adzp152_create_name(li_idx2, "mdl_var_title", "&&")
            LET ls_value = ls_title_pre
            CALL g_properties.addAttribute(ls_name, ls_value)
            #欄位名稱
            LET ls_name = adzp152_create_name(li_idx2, "mdl_field", "&&")
            LET ls_value = ls_tbl_common[li_idx2].name
            CALL g_properties.addAttribute(ls_name, ls_value)
            #變數名稱
            LET ls_name = adzp152_create_name(li_idx2, "mdl_var", "&&")
            LET ls_value = ls_title_pre, ls_tbl_common[li_idx2].name
            LET ls_value = cl_replace_str(ls_value,'[l_ac]','[1]')
            CALL g_properties.addAttribute(ls_name, ls_value)
            #變數名稱(pre)
            LET ls_name = adzp152_create_name(li_idx2, "mdl_pre", "&&")
            LET ls_value = ls_tbl_common[li_idx2].name
            CALL g_properties.addAttribute(ls_name, ls_value)
         END FOR
         
		 LET ls_value = adzp152_create_name(li_idx, "detail", "<<<")
         CALL g_properties.addAttribute("mdl_loc", ls_value)
      
         #公用欄位開窗
         LET ls_tmp = adzp152_create_name(li_idx, "detail_tbl_name_by_tbl", "<<<") 
         LET ls_slice = adzp152_make_slice("a11")
         LET ls_tmp = adzp152_create_name(li_idx, "detail_commons_ctrlp", "<<<") 
         CALL g_properties.addAttribute(ls_tmp,ls_slice)
         
         #替換[1]為[l_ac]
         FOR li_idx2 = 1 TO ls_tbl_common.getLength()
            #前置字元
            LET ls_tmp = adzp152_create_name(li_idx, "detail_tbl_pages", "<<<") 
            LET ls_tmp = g_properties.getValue(ls_tmp)
            LET ls_title_pre = adzp152_find_page(ls_tbl_common[li_idx2].name,ls_tmp),'.'
            #變數名稱
            LET ls_name = adzp152_create_name(li_idx2, "mdl_var", "&&")
            LET ls_value = ls_title_pre, ls_tbl_common[li_idx2].name
            CALL g_properties.addAttribute(ls_name, ls_value)
         END FOR
         
         #公用欄位帶值
         LET ls_slice = adzp152_make_slice("a12")
         LET ls_tmp = adzp152_create_name(li_idx, "detail_tbl_pages", "<<<") 
         LET ls_tmp = g_properties.getValue(ls_tmp)
         LET ls_pages = adzp152_find_page_num(ls_tbl_common[1].name,ls_tmp)
         LET ls_tmp = adzp152_create_name(ls_pages, "detail_commons_ref", "<<<") 
         CALL g_properties.addAttribute(ls_tmp,ls_slice)
         
         #公用欄位複製給值
         LET ls_slice = g_properties.getValue("detail_repro_define")
         LET ls_slice = ls_slice, adzp152_make_slice("a13")
         CALL g_properties.addAttribute("detail_repro_define",ls_slice)
         
         #公用欄位新增給值
         LET ls_slice = adzp152_make_slice("a14")
         LET ls_tmp = adzp152_create_name(li_idx, "detail_tbl_pages", "<<<") 
         LET ls_pages = g_properties.getValue(ls_tmp)
         
         #開始解析那些page屬於該table
         LET lst_token = base.StringTokenizer.create(ls_pages, ',')
         WHILE lst_token.hasMoreTokens()
            LET ls_token = lst_token.nextToken()
            LET ls_tmp = adzp152_create_name(ls_token, "detail_insert_define", "<<<") 
            CALL g_properties.addAttribute(ls_tmp,ls_slice)
         END WHILE

      END IF  

   END FOR   
    
END FUNCTION

#+ 公用欄位owner定義
PRIVATE FUNCTION adzp152_common_create_owner(ps_tbl)
   DEFINE ps_tbl      STRING
   DEFINE ls_return   STRING
   
   LET ls_return = "LET g_data_owner = ",g_properties.getValue("mdl_var03"),"\n",
                   "LET g_data_group = ",g_properties.getValue("mdl_var04"),"\n" 

   RETURN ls_return
   
END FUNCTION

#+ 檢查該欄位是否存在於畫面上
PRIVATE FUNCTION adzp152_chk_field_exist(ps_field)
   DEFINE ps_field        STRING  
   DEFINE ls_return       STRING  #Y-有, N-無
   DEFINE ls_field_list   STRING
   DEFINE ls_field        STRING
   
   LET ls_field_list = g_properties.getValue("general_form_field")
   
   LET ls_field = ps_field
   
   IF ls_field_list.getIndexOf(ls_field,1) THEN
      LET ls_return = 'Y'
   ELSE
      LET ls_return = 'N'
   END IF
   
   RETURN ls_return

END FUNCTION





