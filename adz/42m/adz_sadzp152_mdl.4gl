#adzp152 副程式 - 子樣板存取
# Modify........: No:YSC-E40006 14/04/23 By joyce q類樣板因應多頁籤調整
# Modify........: No:YSC-E50003 14/05/19 By joyce 單頭串查功能調整

IMPORT os
SCHEMA ds

GLOBALS
   DEFINE g_properties   om.SaxAttributes
END GLOBALS

#+ 讀取片段樣板並進行取代(欄位檢查段落)
PUBLIC FUNCTION adzp152_make_slice(ps_mdl)
   DEFINE ps_mdl          STRING
   DEFINE ls_mdl          STRING
   DEFINE ls_read         STRING
   DEFINE ls_return       STRING
   DEFINE ls_return_tmp   STRING
   DEFINE ls_text         STRING
   DEFINE lchannel_read   base.Channel
   DEFINE ls_mdlpath      STRING
   DEFINE ls_name         STRING   #150529-00031
   DEFINE ls_value        STRING   #150529-00031
   

   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_mdlpath = FGL_GETENV("T100TEMPLATEPATH")
   IF cl_null(ls_mdlpath) THEN
      LET ls_mdlpath = FGL_GETENV("ERP")
      LET ls_mdlpath = os.Path.join(ls_mdlpath,"mdl")
   END IF

   #定義取用樣板檔案
   LET ls_mdl = "slice/code_",ps_mdl,".template"
#  LET ls_mdl = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),ls_mdl)
   LET ls_mdl = os.Path.join(ls_mdlpath,ls_mdl)

   #開啟樣板檔
   LET lchannel_read = base.Channel.create()
   CALL lchannel_read.setDelimiter("")

   CALL lchannel_read.openFile( ls_mdl CLIPPED, "r" )

   #150529-00031 ---start---
   #因為q04樣板沒有dataset，所以後續在組傳入參數時可能會有問題(無法找到對應的index指標)，
   #所以若是q04樣板，則把該行mark起來，讓使用者自行調整
   IF g_properties.getValue("type_id") = "q04" AND ps_mdl = "a41" THEN
      LET ls_value = "#"
   ELSE
      LET ls_value = ""
   END IF
   LET ls_name  = "mdl_link_mark"
   CALL g_properties.addAttribute(ls_name,ls_value)
   #150529-00031 --- end ---

   WHILE NOT lchannel_read.isEof()
   
      LET ls_text = ""
      LET ls_read = lchannel_read.readLine()
      
      LET ls_return_tmp = ""
      
      #產生code部分
      CASE
         #page段落產生
         WHEN ls_read.getIndexOf("#pages - Start -",1) > 0
            CALL adzp152_slice_pages(lchannel_read,'0') RETURNING lchannel_read,ls_return_tmp   #YSC-E40006 add 0
            LET ls_read = ""

         #YSC-E40006 ---start---
         #page段落產生(單身的單頭)
         WHEN ls_read.getIndexOf("#pages_m - Start -",1) > 0
            CALL adzp152_slice_pages(lchannel_read,'5') RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""

         #page段落產生(單身的單身)
         WHEN ls_read.getIndexOf("#pages_d - Start -",1) > 0
            CALL adzp152_slice_pages(lchannel_read,'6') RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""
         #YSC-E40006 --- end ---
            
         #單頭key段落產生    
         WHEN ls_read.getIndexOf("#master_keys - Start -",1) > 0
            CALL adzp152_slice_keys(lchannel_read,'m') RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""
            
         #單身key段落產生    
         WHEN ls_read.getIndexOf("#detail_keys - Start -",1) > 0
            CALL adzp152_slice_keys(lchannel_read,'d') RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""
            
         #多table段落產生
         WHEN ls_read.getIndexOf("#tables - Start -",1) > 0
         #  CALL adzp152_slice_tables(lchannel_read) RETURNING lchannel_read,ls_return_tmp   #YSC-E30002 mark
            CALL adzp152_slice_tables(lchannel_read,0) RETURNING lchannel_read,ls_return_tmp   #YSC-E30002 modify
            LET ls_read = ""

         #YSC-E30002 ---start---
         #多table段落產生(主要table)   
         WHEN ls_read.getIndexOf("#tables_m - Start -",1) > 0
            CALL adzp152_slice_tables(lchannel_read,1) RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""

         #多table段落產生(附帶table)
         WHEN ls_read.getIndexOf("#tables_d - Start -",1) > 0
            CALL adzp152_slice_tables(lchannel_read,2) RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""

         #多table段落產生(附帶table的table)
         WHEN ls_read.getIndexOf("tables_d2 - Start -",1) > 0
            CALL adzp152_slice_tables(lchannel_read,3) RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""
         #YSC-E30002 --- end ---

         WHEN ls_read.getIndexOf("#reproduces - Start -",1)
            CALL adzp152_make_reproduces(lchannel_read) RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""

         #YSC-E50003 ---start---
         #slice專用迴圈1
         WHEN ls_read.getIndexOf("#mdls - Start -",1)
            CALL adzp152_make_mdls(lchannel_read,1) RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""

         #slice專用迴圈2
         WHEN ls_read.getIndexOf("#mdls2 - Start -",1)
            CALL adzp152_make_mdls(lchannel_read,2) RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""

         #slice專用迴圈3
         WHEN ls_read.getIndexOf("#mdls3 - Start -",1)
            CALL adzp152_make_mdls(lchannel_read,3) RETURNING lchannel_read,ls_return_tmp
            LET ls_read = ""
         #YSC-E50003 --- end ---     
      END CASE
      
      LET ls_return = ls_return, ls_return_tmp

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

   #YSC-E80002 ---start---
   #若單頭取不到table的pk欄位，則此段不須產生
   IF ps_mdl = "qs26" AND cl_null(g_properties.getValue("master_field_pk01")) THEN
      LET ls_return = ""
   END IF

   #若單身取不到table的pk欄位，則此段不須產生
   IF ps_mdl = "qs27" AND cl_null(g_properties.getValue("detail_field_pk01")) THEN
      LET ls_return = ""
   END IF
   #YSC-E80002 --- end ---

   RETURN ls_return

END FUNCTION


#+ 根據tabx設定之page數量產生對應之page段落
PRIVATE FUNCTION adzp152_slice_pages(l_read,pi_type)   #YSC-E40006 add pi_type
   DEFINE l_read        base.Channel
   DEFINE pi_type       LIKE type_t.chr1    #YSC-E40006
   DEFINE l_tmp         STRING 
   DEFINE l_page        DYNAMIC ARRAY OF STRING 
   DEFINE l_page_num    LIKE type_t.num10 
   DEFINE li_cnt        LIKE type_t.num10 
   DEFINE l_is          STRING 
   DEFINE ls_return     STRING

   #先取出page段落之樣本
   WHILE TRUE 
      LET l_tmp = l_read.readLine()
      CASE 
         WHEN l_tmp.getIndexOf("#pages -  End  -",1)
            EXIT WHILE 
         WHEN l_tmp.getIndexOf("#master_keys - Start -",1)
            CALL adzp152_make_keys_in_page(l_read,"",'m') RETURNING l_tmp,l_read
         WHEN l_tmp.getIndexOf("#detail_keys - Start -",1)
            CALL adzp152_make_keys_in_page(l_read,"",'d') RETURNING l_tmp,l_read
      END CASE
      LET l_page[1] = l_page[1],l_tmp , "\n"
   END WHILE 
   
   #取得page總數量
   LET l_page_num = g_properties.getValue("page")
   
   #根據page數量產生對應的page段落並進行資料取代
   FOR li_cnt = 2 TO l_page_num
      #YSC-E40006 ---start---
      #單身的單頭才產生(所有段落)
      IF pi_type = "5" THEN
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_detail", "<<<")
         LET l_tmp = g_properties.getValue(l_tmp)
         IF l_tmp = "Y" OR cl_null(l_tmp) THEN
            CONTINUE FOR
         END IF
      END IF

      #單身的單身才產生(所有段落)
      IF pi_type = "6" THEN
         LET l_tmp = adzp152_create_name(li_cnt, "general_page_detail", "<<<")
         LET l_tmp = g_properties.getValue(l_tmp)
         IF l_tmp = "N" OR cl_null(l_tmp) THEN
            CONTINUE FOR
         END IF
      END IF
      #YSC-E40006 --- end ---

      #先將${page}取代掉
      LET l_is = li_cnt
      LET ls_return = ls_return,
                      "#Page",l_is,"\n",
                      adzp152_replace_page(l_page[1],li_cnt)
                        
      #針對不同的page進行key取代
      LET ls_return = adzp152_make_keys_in_multi_table(ls_return,li_cnt)
      
      #若資料未取代完成則重複返回
      WHILE ls_return.getIndexOf("${",1) > 0 
         LET ls_return = adzp152_line_replace(ls_return)
      END WHILE  

   END FOR    
   
   RETURN l_read, ls_return
   
END FUNCTION 

#+ 根據tabx設定之key數量產生對應之key段落
PRIVATE FUNCTION adzp152_slice_keys(l_read,l_type)
   DEFINE l_read        base.Channel
   DEFINE l_type        STRING
   DEFINE l_tmp         STRING 
   DEFINE l_key         DYNAMIC ARRAY OF STRING 
   DEFINE l_key_num     LIKE type_t.num10 
   DEFINE li_cnt        LIKE type_t.num10 
   DEFINE l_is          STRING 
   DEFINE ls_return     STRING
   
   #先取出key段落之樣本
   WHILE TRUE 
      LET l_tmp = l_read.readLine()
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

   LET ls_return = ""
   
   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_key_num
      
      #先將${key}取代掉
      LET l_is = li_cnt
      LET ls_return = ls_return, 
                        adzp152_replace_key(l_key[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_return.getIndexOf("${",1) > 0 
         LET ls_return = adzp152_line_replace(ls_return)
      END WHILE  
      
   END FOR   
   
   RETURN l_read, ls_return
   
END FUNCTION 

#+ 根據tabx設定之table數量產生對應之table段落
PRIVATE FUNCTION adzp152_slice_tables(l_read,pi_type)   #YSC-E30002 add pi_type
   DEFINE l_read        base.Channel
   DEFINE pi_type       LIKE type_t.num5    #YSC-E30002
   DEFINE l_tmp         STRING 
   DEFINE l_table       DYNAMIC ARRAY OF STRING 
   DEFINE l_table_num   LIKE type_t.num10 
   DEFINE li_cnt        LIKE type_t.num10 
   DEFINE l_is          STRING 
   DEFINE ls_return     STRING
   DEFINE ls_name       STRING    #YSC-E30002
   
   #先取出table段落之樣本
   WHILE TRUE 
      LET l_tmp = l_read.readLine()
      CASE 
         WHEN l_tmp.getIndexOf("#tables -  End  -",1)
            EXIT WHILE 
         WHEN l_tmp.getIndexOf("#master_keys - Start -",1)
            CALL adzp152_make_keys_in_table(l_read,'','m') RETURNING l_tmp,l_read
         WHEN l_tmp.getIndexOf("#detail_keys - Start -",1)
            CALL adzp152_make_keys_in_table(l_read,'','d') RETURNING l_tmp,l_read
      END CASE
      LET l_table[1] = l_table[1],l_tmp , "\n"
   END WHILE 

   #取得table總數量
   LET l_table_num = g_properties.getValue("detail_table_num")

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_table_num
      #YSC-E30002 ---start---
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
      IF NOT (cl_null(l_tmp) OR l_tmp = "N") AND pi_type <> 3 THEN
         CONTINUE FOR
      END IF

      #副table的table才產出 
      LET l_tmp = adzp152_create_name(li_cnt, "detail_tbl_type_by_tbl", "<<<")
      LET l_tmp = g_properties.getValue(l_tmp)
      IF pi_type = 3 AND (l_tmp ="N" OR cl_null(l_tmp)) THEN
         CONTINUE FOR
      END IF
      #YSC-E30002 --- end ---
      
      #先將${table}取代掉
      LET l_is = li_cnt
      LET ls_return = ls_return,
                      "#table",l_is,"\n",   #YSC-E30002 mark
                      adzp152_replace_table(l_table[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_return.getIndexOf("${",1) > 0 
         LET ls_return = adzp152_line_replace(ls_return)   #YSC-E30002 modify l_table[li_cnt] -> ls_return
      END WHILE  

   END FOR    
   
   RETURN l_read, ls_return
   
END FUNCTION 

#reproduce產生
PUBLIC FUNCTION adzp152_make_reproduces(ps_read)
   DEFINE ps_read       base.Channel
   DEFINE ls_reproduce        DYNAMIC ARRAY OF STRING 
   DEFINE li_reproduce_num    LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE ls_is         STRING 
   DEFINE ls_return     STRING
   DEFINE ls_tmp        STRING
   
   #先取出reproduce段落之樣版
   WHILE TRUE 
      LET ls_tmp = ps_read.readLine()
      IF ls_tmp.getIndexOf("#reproduces -  End  -",1) THEN
         EXIT WHILE 
      END IF
      LET ls_reproduce[1] = ls_reproduce[1], ls_tmp
   END WHILE 
   
   #總數量
   LET li_reproduce_num = g_properties.getValue("mdl_reproduces")
   
   #根據reproduce數量產生對應的reproduce段落並進行資料取代
   FOR li_cnt = 2 TO li_reproduce_num
      
      #先將${reproduces}取代掉
      LET ls_is = li_cnt
      LET ls_reproduce[li_cnt] = adzp152_replace_reproduces(ls_reproduce[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_reproduce[li_cnt].getIndexOf("${",1) > 0 
         LET ls_reproduce[li_cnt] = adzp152_line_replace(ls_reproduce[li_cnt])
      END WHILE  
      LET ls_return = ls_return, ls_reproduce[li_cnt], '\n'
      
   END FOR    
   
   RETURN ps_read, ls_return
   
END FUNCTION 

#將${reproduce}取代為號碼
PUBLIC FUNCTION adzp152_replace_reproduces(ps_reproduce, pi_i)
   DEFINE ps_reproduce   STRING 
   DEFINE pi_i           STRING 
   DEFINE li_s           LIKE type_t.num5 
   DEFINE li_e           LIKE type_t.num5 
   DEFINE ls_reproduce   STRING 

   WHILE TRUE 
      LET li_s = ps_reproduce.getIndexOf("${reproduce}",1) - 1
      LET li_e = ps_reproduce.getLength()
      #取代${reproduce}
      LET ls_reproduce = ps_reproduce.subString(1,li_s), pi_i, ps_reproduce.subString((li_s+13),li_e)
      LET ps_reproduce = ls_reproduce
      IF ls_reproduce.getIndexOf("${reproduce}",1) < 1 THEN 
         EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN ls_reproduce
   
END FUNCTION 





