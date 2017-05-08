#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp140_gen_4gl
#+ Buildtype: 
#+ Memo.....: 是adzp140 副程式，產生4gl
#+ modify...: 2014/08/26 by jrg542 改寫抓取table相關的資料的sql，由inner join改成一個table一個table取相關資料 
#160519-00018 #1 2016/05/19 by jrg542 多語言產生器調整編譯順序位置及增加全部重產功能
IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS 
   DEFINE g_properties    om.SaxAttributes 
   DEFINE g_table_id STRING    #table id
   TYPE type_g_table_info RECORD 
          table_id     LIKE dzeb_t.dzeb001,    #table id ex:gzwel_t
          field_id     LIKE dzeb_t.dzeb002,    #field id
          field_pk     LIKE dzeb_t.dzeb004,    #是否 pk
          field_type   LIKE dzeb_t.dzeb006,    #field 屬性 (field type ex:230)
          widge_code   LIKE dzep_t.dzep010,    #widge code (ex:05)
          field_ent    LIKE type_t.num5,       #是否 ent
          field_lang   LIKE type_t.num5        #是否 lang 語言別     
                       END RECORD
   DEFINE g_table_info     DYNAMIC ARRAY OF type_g_table_info     
   DEFINE g_key_count      LIKE type_t.num5    #key 總數  
   DEFINE g_pkey_count     LIKE type_t.num5    #pk 總數 
   DEFINE gs_code_filename STRING              #4gl 檔案名稱
   DEFINE g_generation_ch  base.Channel
   DEFINE gs_log_file      STRING 
   DEFINE gs_log_path      STRING
END GLOBALS

PUBLIC CONSTANT li_space = 3 #空三格

#+ 程式產生 4gl 
PUBLIC FUNCTION sadzp140_gen_4gl(ps_code_filename)
 
   DEFINE ps_code_filename   STRING
   DEFINE li_stus            LIKE type_t.num5

   #檢核table是否有設計資料
   IF NOT sadzp140_gen_chk_table(ps_code_filename) THEN 
      DISPLAY "ERROR: 多語言表格 ",ps_code_filename,"不存在設計資料中. "
      RETURN FALSE
   END IF 

   #特殊的table就不用建立 (該table有存在語言別欄位,但非語言表)
   IF ps_code_filename = "gzac_t" OR ps_code_filename = "gzzd_t" OR 
      ps_code_filename = "gzxa_t" OR ps_code_filename = "gzzy_t" OR
      ps_code_filename = "pmba_t" OR ps_code_filename = "gzzq_t" THEN  #供應商准入檔
      DISPLAY "INFO: 本表在adzi140登錄,屬於特殊用途表格,直接予以排除建置!"
      RETURN FALSE
   END IF

   #若存在則用 n_tableid.4gl (去除_t) 存入 ls_code_filename
   LET ps_code_filename = sadzp140_trim_table(ps_code_filename) #n_gzzt

   #建立channel
   CALL adzp140_channel()
   LET g_properties = om.SaxAttributes.create()
   CALL g_properties.addAttribute("general_prefix", ps_code_filename)   #general_prefix 程式代號
   CALL g_properties.addAttribute("master_tbl_name",g_table_id)
   CALL g_properties.addAttribute("detail_tbl_name",g_table_id)
   LET gs_code_filename = ps_code_filename 

   #取得table 資訊
   IF NOT sadzp140_get_table_info() THEN
      DISPLAY "---"
      #DISPLAY "Warning: 不存在多語言欄位,非語言別table.停止建立多語言副程式"
      DISPLAY "ERROR: 不存在多語言欄位,非語言別table.停止建立多語言副程式"
      CALL g_generation_ch.close()
      RETURN FALSE
   END IF

   #check pk 數量 語言檔 xxxxl_t xxxent,xxxx(語言別)
   LET li_stus  = sadzp140_chk_pk_count()
   IF NOT li_stus THEN 
      DISPLAY "ERROR: 多語言表格少了一個鍵值 "
      CALL g_generation_ch.close()
      RETURN li_stus
   END IF 

   #組成要產生4gl的資料
   CALL sadzp140_compose_4gl()
   #讀取樣板,行代換
   CALL sadzp140_read_and_replace()

   CALL g_generation_ch.close()
   RETURN li_stus
END FUNCTION

#+r.c 、 r.f 、 r.l lng
PUBLIC FUNCTION sadzp140_compile_file(p_type)
   DEFINE p_type     LIKE type_t.chr1  #要編譯的檔案類型--1:4gl ; 2:4fd
   DEFINE ls_str     STRING
   DEFINE l_read     base.Channel
   DEFINE l_cmd      STRING            #要執行的指令
   DEFINE l_path     STRING            #要編譯的路徑
   DEFINE l_msg      STRING            #編譯後訊息
   DEFINE li_cnt     LIKE type_t.num10 #筆數
   DEFINE lc_gzzn002 LIKE gzzn_t.gzzn002
   DEFINE gt_start,gt_temp_start,gt_end  DATETIME HOUR TO SECOND

   LET gt_start = CURRENT HOUR TO SECOND 
   LET l_read = base.Channel.create()
   LET l_cmd = ""
   LET l_path = ""
   LET l_msg = ""

   #因為要編譯開窗的4gl或4fd檔需先進行切換目錄到該com/lng/4fd com/lng/4gl相對路徑下
   #才可進行編譯動作
   LET l_path = os.Path.join(FGL_GETENV("COM"), "lng")
   #4gl和4fd存放路徑不同,編譯方式也不同
   
   CASE p_type
      WHEN "1"   #4gl
         LET l_path = os.Path.join(l_path, "4gl")
         LET l_cmd = "r.c ", gs_code_filename
      WHEN "2"   #4fd
         LET l_path = os.Path.join(l_path, "4fd")
         LET l_cmd = "r.f ", gs_code_filename #," tiptop"
         #160519-00018 #1 add
         IF ARG_VAL(3) = "tiptop" THEN 
            LET l_cmd = l_cmd," tiptop"
         END IF 
         #160519-00018 #1 end
         
      WHEN "3"   #lng 42x打包
         IF UPSHIFT(ARG_VAL(2)) <> "ALL" THEN 
            LET lc_gzzn002 = gs_code_filename.trim()
             SELECT COUNT(*) INTO li_cnt FROM gzzn_t
              WHERE gzzn001 = "LNG" AND gzzn002 = lc_gzzn002
          
             DISPLAY "+++++++++++++++++++++++++++++++++++++"
             DISPLAY "gzzn001 = LNG"
             DISPLAY "gzzn002 = ",lc_gzzn002
             DISPLAY "+++++++++++++++++++++++++++++++++++++"

             IF li_cnt = 0 THEN
                INSERT INTO gzzn_t(gzzn001,gzzn002,gzzn003,gzzn004)
                 VALUES("LNG",lc_gzzn002,"Y","N")
             END IF
         END IF 


         LET l_cmd = "r.l lng"
         #LET l_cmd = "ls "
    
   END CASE

   LET l_msg = l_msg, l_cmd, ASCII 10
   
   IF l_path IS NOT NULL THEN
      #切換目錄
      LET l_cmd = "cd ", l_path.trim(), "; ", l_cmd
   END IF
   DISPLAY "l_cmd:",l_cmd
   #執行指令
   CALL l_read.openPipe(l_cmd, "r")
   CALL l_read.setDelimiter("")

   WHILE TRUE
      LET ls_str = l_read.readLine()
      IF l_read.isEof() OR ls_str = 'r.f success...' THEN
         EXIT WHILE
      END IF

      LET l_msg = l_msg, ls_str
   END WHILE
   CALL l_read.close()
   DISPLAY l_msg
   LET gt_end = CURRENT HOUR TO SECOND 
   DISPLAY "Total Spent Time:",gt_end - gt_start,"\n"
END FUNCTION


#+ 檢核table是否有設計資料
PRIVATE FUNCTION sadzp140_gen_chk_table(p_tablei_d)

   DEFINE p_tablei_d  STRING
   DEFINE l_dzea001   LIKE dzea_t.dzea001
   DEFINE l_n         LIKE type_t.num5

   LET l_dzea001 = p_tablei_d
   SELECT COUNT(*) INTO l_n FROM dzea_t
    WHERE dzea001 = l_dzea001  

   #有資料 TRUE/無資料 FALSE
   IF l_n > 0 THEN 
      RETURN TRUE
    ELSE 
      RETURN FALSE
   END IF 
    
END FUNCTION 


#+ 去除 _t
PRIVATE FUNCTION sadzp140_trim_table(ps_code_filename)

   DEFINE ps_code_filename  STRING
   DEFINE l_n               LIKE type_t.num5

   LET ps_code_filename = ps_code_filename.toLowerCase() #table id
   LET g_table_id = ps_code_filename
   LET l_n = ps_code_filename.getIndexOf("_t",1)
   LET ps_code_filename = ps_code_filename.subString(1,l_n-1)  
   LET ps_code_filename = "n_",ps_code_filename
   
   RETURN ps_code_filename
    
END FUNCTION


#+取得table的欄位相關資訊 
PRIVATE FUNCTION sadzp140_get_table_info()
   DEFINE l_sql   STRING 
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_stus  LIKE type_t.num5
   DEFINE ls_tmp  STRING 

   #抓取設計資料中的訊息
   #2014/08/26
   #LET l_sql = "SELECT dzeb001,dzeb002,dzeb004,dzeb006,dzep010 FROM dzeb_t,dzep_t ",
   LET l_sql = "SELECT dzeb001,dzeb002,dzeb004,dzeb006 FROM dzeb_t ",
               " WHERE ",#dzep001 = dzeb001 ",
               #"   AND dzep002 = dzeb002 ",
               "   dzeb001 = '", g_table_id,"'",
               "   ORDER by dzeb021 "

   PREPARE sadzp140_pre_tab_info FROM l_sql 
   DECLARE sadzp140_fill_cs CURSOR FOR sadzp140_pre_tab_info   

   CALL g_table_info.clear()
   LET l_cnt = 1
   LET g_key_count = 0

   FOREACH sadzp140_fill_cs INTO 
      g_table_info[l_cnt].table_id,g_table_info[l_cnt].field_id,
      g_table_info[l_cnt].field_pk,g_table_info[l_cnt].field_type
      #g_table_info[l_cnt].widge_code

      
      LET l_sql = " SELECT dzep010 FROM dzep_t ",
                   " WHERE dzep001 = '",g_table_info[l_cnt].table_id,"'" ,
                   "   AND dzep002 = '",g_table_info[l_cnt].field_id,"'"
      PREPARE sadzp140_pre_tab_info2 FROM l_sql  
      EXECUTE sadzp140_pre_tab_info2 INTO g_table_info[l_cnt].widge_code
      FREE  sadzp140_pre_tab_info2
      
      IF g_table_info[l_cnt].field_pk = "Y" THEN 
         LET g_pkey_count = g_pkey_count + 1    #primary key 數量
         LET g_key_count = g_key_count + 1      #先計算單頭宣告筆數
      END IF 

      LET ls_tmp = g_table_info[l_cnt].field_id

      #判定是否存在 ent 企業代碼
      IF ls_tmp.getIndexOf("ent",5) THEN 
         LET g_table_info[l_cnt].field_ent = TRUE
         LET g_key_count = g_key_count - 1 
      ELSE 
         LET g_table_info[l_cnt].field_ent = FALSE   
      END IF
     
      #判定是否存在 語言別欄位
      IF g_table_info[l_cnt].field_type = "C800" THEN
         LET g_table_info[l_cnt].field_lang = TRUE
         LET g_key_count = g_key_count - 1 
      ELSE 
         LET g_table_info[l_cnt].field_lang = FALSE  
      END IF

      #決定畫面需要的控件編號
      IF cl_null(g_table_info[l_cnt].widge_code) THEN # 控件代碼
         IF g_table_info[l_cnt].field_lang THEN 
            LET g_table_info[l_cnt].widge_code = "03" #ComboBox
         ELSE 
            LET g_table_info[l_cnt].widge_code = "05" #Edit
         END IF  
      END IF 

      LET l_cnt = l_cnt + 1 
   END FOREACH 

   CALL g_table_info.deleteElement(l_cnt)

   #檢查是否有語言別欄位存在
   LET l_stus = FALSE
   FOR l_cnt = 1 TO g_table_info.getLength()
      IF g_table_info[l_cnt].field_lang THEN
         LET l_stus = TRUE
         EXIT FOR
      END IF
   END FOR

   IF l_stus THEN 
      CALL sadzp140_get_table_sort() #排序共用欄位
   END IF

   RETURN l_stus
  
END FUNCTION 

#+ 組4gl
PRIVATE FUNCTION sadzp140_compose_4gl()
   CALL sadzp140_compose_master()       #單頭
   CALL sadzp140_compose_datail()       #單身
END FUNCTION 

#+ 組單頭變數宣告
PRIVATE FUNCTION sadzp140_compose_master()
   DEFINE li_i                    LIKE type_t.num5
   DEFINE ls_mstesr_field         STRING       #單頭變數值
   DEFINE l_n                     LIKE type_t.num5
   DEFINE l_cnt                   LIKE type_t.num5
   DEFINE l_k                     LIKE type_t.num5
   DEFINE ls_var_pk               STRING 
   DEFINE li_tmp                  LIKE type_t.num5
   DEFINE l_mkey,l_vkey           STRING   
   DEFINE ls_b_fill_where         STRING
   DEFINE ls_ps_master_field_pk   STRING   #多key 處理
   DEFINE ls_ps_master_define_pk  STRING 
   DEFINE ls_ps_master_fld_var_pk STRING
   DEFINE ls_forupd_where         STRING #g_forupd_sql where 條件式 
   
   LET l_k = 3
   LET l_cnt = 0
   LET li_tmp = 1
   LET l_n = g_table_id.getIndexOf("_t",1)
   CALL g_properties.addAttribute("master_var_title", "g_"||g_table_id.subString(1,l_n-1)||"_m")   #master_var_title g_gzza_m

   FOR li_i = 1 TO g_table_info.getLength()
       LET ls_mstesr_field = ls_mstesr_field, (li_space*l_k) SPACES
           
       IF g_table_info[li_i].field_pk = "Y" THEN

          #排除ent 企業代碼及語言別
          IF g_table_info[li_i].field_ent OR g_table_info[li_i].field_lang THEN  

             IF g_table_info[li_i].field_ent THEN  #針對多key 還有 ent 欄位  多加,  
                LET ls_forupd_where = ls_forupd_where,g_table_info[li_i].field_id ,"= ? "," AND "
                LET ls_b_fill_where = ls_b_fill_where,g_table_info[li_i].field_id ,"= ? "," AND "
                CONTINUE FOR  
            END IF 
          ELSE 
             LET l_vkey = "master_var_pk",li_tmp USING "&&"
             LET ls_var_pk = g_properties.getValue("master_var_title"),".",g_table_info[li_i].field_id
             CALL g_properties.addAttribute(l_vkey, ls_var_pk)   #master_var_pk 
             LET l_vkey = "master_field_pk",li_tmp USING "&&"
             LET ls_var_pk = g_table_info[li_i].field_id
             CALL g_properties.addAttribute(l_vkey, ls_var_pk)   #master_field_pk 
             LET ls_mstesr_field = ls_mstesr_field,g_table_info[li_i].field_id ," LIKE ",g_table_id ,".",g_table_info[li_i].field_id 
             LET l_cnt = l_cnt + 1
             LET li_tmp = li_tmp + 1
             LET ls_forupd_where = ls_forupd_where ,g_table_info[li_i].field_id ,"= ? "
             LET ls_b_fill_where = ls_b_fill_where ,g_table_info[li_i].field_id ,"= ? "
             LET ls_ps_master_field_pk = ls_ps_master_field_pk ,"ps_", g_table_info[li_i].field_id
             LET ls_ps_master_define_pk = ls_ps_master_define_pk, "DEFINE " , "ps_",g_table_info[li_i].field_id ," LIKE ",g_table_info[li_i].table_id,".",g_table_info[li_i].field_id ,"\n"
             LET ls_ps_master_fld_var_pk = ls_ps_master_fld_var_pk, "LET ",g_properties.getValue("master_var_title"),".",g_table_info[li_i].field_id ," = " ,"ps_",g_table_info[li_i].field_id
          END IF 

          #排除語言別 不算是單頭欄位數量,避免PK落在最後一個欄位時發生問題
          IF g_table_info[li_i].field_lang THEN
             CONTINUE FOR
          END IF

          IF l_cnt != g_key_count THEN #單頭欄位數量
             LET ls_mstesr_field = ls_mstesr_field , ", \n"  
             LET ls_b_fill_where = ls_b_fill_where , " AND " 
             LET ls_ps_master_field_pk = ls_ps_master_field_pk ,","
             LET ls_ps_master_fld_var_pk = ls_ps_master_fld_var_pk," \n"
          END IF    
       END IF
   END FOR
   DISPLAY "INFO 單頭變數筆數:",g_key_count
   DISPLAY "INFO 單頭變數:",ls_mstesr_field 

   CALL adzp140_output_log("單頭變數:" || ls_mstesr_field )
   CALL g_properties.addAttribute("master_fields_define", ls_mstesr_field) 
   CALL g_properties.addAttribute("master_key_cnt", g_key_count)           #master_key_cnt 單頭變數數量
   CALL g_properties.addAttribute("ls_forupd_where", ls_forupd_where) 
   CALL g_properties.addAttribute("ls_b_fill_where", ls_b_fill_where)  
   CALL g_properties.addAttribute("ps_master_field_pk", ls_ps_master_field_pk)  
   CALL g_properties.addAttribute("ps_master_field_define_pk", ls_ps_master_define_pk)     
   CALL g_properties.addAttribute("ps_master_field_var_pk", ls_ps_master_fld_var_pk)       

END FUNCTION 

#+ 組單身變數宣告 & 組forupd_sql
PRIVATE FUNCTION sadzp140_compose_datail()
   DEFINE li_i               LIKE type_t.num5
   DEFINE l_n                LIKE type_t.num5
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE li_ent             LIKE type_t.num5
   DEFINE l_k                LIKE type_t.num5
   DEFINE li_tmp             LIKE type_t.num5
   DEFINE ls_detail_field    STRING       #單身欄位變數值
   DEFINE ls_detail_vars     STRING       #單身table變數值
   DEFINE ls_tmp             STRING 
   DEFINE ls_tmp_field       STRING    
   DEFINE ls_forupd_where    STRING
   DEFINE ls_select_field    STRING    #for update select 欄位
   DEFINE l_vkey             STRING 
   DEFINE ls_var_pk          STRING 
   DEFINE ls_detail_append_wc  STRING   
   DEFINE ls_detail_fields_update STRING  #單身 INSERT INTO 欄位
   DEFINE ls_detail_vars_update STRING    #單身 INSERT INTO 變數欄位
   DEFINE ls_str             STRING
   DEFINE ls_trans_cnt       LIKE type_t.num5   #單身需做自動翻譯的欄位數
   
   LET l_k = 3     #空三行
   LET l_cnt = 0
   LET li_tmp = 1
   LET g_key_count = g_table_info.getLength() - g_key_count  #計算單身宣告筆數
   LET l_n = g_table_id.getIndexOf("_t",1)
   CALL g_properties.addAttribute("detail_var_title", "g_"||g_table_id.subString(1,l_n-1)||"_d")   #detail_var_title g_gzza_d

   FOR li_i = 1 TO g_table_info.getLength()
       LET ls_tmp_field = ""
       

       #判斷site欄位

       #IF cl_getField(g_table_info[li_i].g_table_id CLIPPED, l_detail_field_site CLIPPED) THEN
       #   LET l_detail_site = TRUE
       #ELSE
       #   LET l_detail_site = FALSE
       #END IF

       # PK AND 語言別
       IF g_table_info[li_i].field_pk = "Y" AND g_table_info[li_i].field_lang THEN 
          LET ls_tmp_field =  (li_space*l_k) SPACES
          
          CALL g_properties.addAttribute("lang_field", g_table_info[li_i].field_id)   #lang_field 語言別欄位變數宣告
          LET ls_detail_field = ls_detail_field,ls_tmp_field,g_table_info[li_i].field_id ," LIKE ",g_table_id ,".",g_table_info[li_i].field_id             
          LET ls_detail_fields_update = ls_detail_fields_update,g_table_info[li_i].field_id  
          LET ls_detail_vars_update = ls_detail_vars_update,g_properties.getValue("detail_var_title"),"[l_ac]." ,g_table_info[li_i].field_id
          LET ls_detail_vars = ls_detail_vars,g_properties.getValue("detail_var_title"),"[l_ac].",g_table_info[li_i].field_id
          
          LET ls_select_field = ls_select_field,g_table_info[li_i].field_id 
          LET l_cnt = l_cnt + 1     #計算單身變數宣告筆數
          LET ls_forupd_where =  g_properties.getValue("ls_b_fill_where")," AND ",g_table_info[li_i].field_id ,"=?"
          LET l_vkey = "detail_var_pk",li_tmp USING "&&"      #g_gzzt_d[l_ac].gzzd002
          LET ls_var_pk = g_properties.getValue("detail_var_title") ,"[l_ac].",g_table_info[li_i].field_id
          
          CALL g_properties.addAttribute(l_vkey, ls_var_pk)   #detail_var_pk # 
          LET l_vkey = "detail_field_pk",li_tmp USING "&&"    #欄位pk
          LET ls_var_pk = g_table_info[li_i].field_id          
          CALL g_properties.addAttribute(l_vkey,ls_var_pk)
          LET li_tmp = li_tmp + 1
          
       ELSE # 外層IF
          IF NOT g_table_info[li_i].field_ent  THEN 
             LET ls_tmp_field = (li_space*l_k) SPACES 
             
             LET ls_tmp = g_table_info[li_i].field_id
             LET ls_tmp = DOWNSHIFT(ls_tmp)
             IF g_table_info[li_i].field_pk != "Y" THEN #排除 PK 
                LET ls_detail_field = ls_detail_field,ls_tmp_field,ls_tmp ," LIKE ",g_table_id ,".",g_table_info[li_i].field_id            
                LET ls_detail_fields_update = ls_detail_fields_update,ls_tmp
                LET ls_detail_vars_update = ls_detail_vars_update,g_properties.getValue("detail_var_title"),"[l_ac]." ,ls_tmp
                LET ls_detail_vars = ls_detail_vars,g_properties.getValue("detail_var_title"),"[l_ac].",ls_tmp 
                LET ls_select_field = ls_select_field,g_table_info[li_i].field_id

                LET ls_trans_cnt = ls_trans_cnt + 1
                LET ls_str = "detail_trans_field_count"
                CALL g_properties.addAttribute(ls_str,ls_trans_cnt)
                LET ls_str = "detail_trans_field",ls_trans_cnt USING "&&"
                CALL g_properties.addAttribute(ls_str,ls_tmp)
             DISPLAY "ls_str:",ls_str
             DISPLAY "detail_trans_field",ls_trans_cnt,":",g_properties.getValue(ls_str)
                LET ls_str = "detail_trans_field_var",ls_trans_cnt USING "&&"
                CALL g_properties.addAttribute(ls_str,ls_tmp)
             DISPLAY "ls_str:",ls_str
             DISPLAY "detail_trans_field",ls_trans_cnt,":",g_properties.getValue(ls_str)

                LET l_cnt = l_cnt + 1
             ELSE
                # PK key field 單頭
                LET ls_tmp_field = ""
                CONTINUE FOR 
             END IF 
            
          ELSE #是 xxxent(企業代碼) 欄位 
             #改先在單頭先取where key值再取單身key值
             LET ls_detail_append_wc = g_table_info[li_i].field_id ," = g_enterprise AND "
             CALL g_properties.addAttribute("detail_var_append"," g_enterprise ,")
             CALL g_properties.addAttribute("detail_field_append",g_table_info[li_i].field_id ||"," )
             LET g_key_count = g_key_count - 1 #把企業代碼扣掉(隱藏)
             LET li_ent = TRUE    
          END IF 
       END IF #外層if 

       CALL adzp140_output_log("單身變數筆數:" || g_key_count || " 目前單身筆數:" || l_cnt )
       IF l_cnt != g_key_count AND NOT g_table_info[li_i].field_ent THEN 
          LET ls_detail_field = ls_detail_field , ", \n"  
          LET ls_detail_fields_update = ls_detail_fields_update, ","
          LET ls_detail_vars_update = ls_detail_vars_update,","
          LET ls_detail_vars = ls_detail_vars, ","
          LET ls_select_field = ls_select_field,","   
       END IF

   END FOR
   DISPLAY "INFO 單身變數筆數:",g_key_count
   DISPLAY "INFO 單身變數:",ls_detail_field
   CALL adzp140_output_log("單身變數:" || ls_detail_field )
   #單頭key              #單頭key cnt
   LET g_key_count = g_properties.getValue("master_key_cnt")  
   #目前手動設定 page
   CALL g_properties.addAttribute("page",1) 
   #detail_fields_define 單身變數宣告
   CALL g_properties.addAttribute("detail_fields_define",ls_detail_field) 
   CALL g_properties.addAttribute("detail_vars_all",ls_detail_vars)                #detail_vars_all      ex g_gzzt_d[l_ac].gzzt003 單身陣列變數宣告
   CALL g_properties.addAttribute("detail_sql_forupd","SELECT " || ls_select_field || " FROM " || g_table_id || " WHERE " || ls_forupd_where || " FOR UPDATE")        #detail_sql_forupd  
   #detail_fill_sql
   CALL g_properties.addAttribute("detail_fill_sql","SELECT " || ls_select_field || " FROM " || g_table_id || " WHERE "  || g_properties.getValue("ls_b_fill_where"))         
   CALL g_properties.addAttribute("detail_append_wc",ls_detail_append_wc )               #
   CALL g_properties.addAttribute("detail_fields_update",ls_detail_fields_update )       #
   CALL g_properties.addAttribute("detail_vars_update",ls_detail_vars_update )           #
   
   IF li_ent THEN #ent 企業代碼                                                                       
      CALL g_properties.addAttribute("detail_key_cnt",(g_pkey_count - g_key_count - 1 )) #detail_key_cnt  #減1是扣掉 ent
   ELSE 
      CALL g_properties.addAttribute("detail_key_cnt",(g_pkey_count - g_key_count  ))   #detail_key_cnt
   END IF 
   
END FUNCTION

#+ 排序
PRIVATE FUNCTION sadzp140_get_table_sort()
   DEFINE li_i           LIKE type_t.num5
   DEFINE ls_tmp         STRING 

   FOR li_i = 1 TO g_table_info.getLength() 
      LET ls_tmp = g_table_info[li_i].field_id
      LET ls_tmp = DOWNSHIFT(ls_tmp)
      IF ls_tmp.getIndexOf("ent",1) THEN
         #判定是否有ent欄位
         IF cl_getField(g_table_info[li_i].table_id,g_table_info[li_i].field_id) THEN 
            IF li_i = 1 THEN 
               EXIT FOR 
            END IF 
            CALL g_table_info.insertElement(1)#
            LET g_table_info[1].table_id = g_table_info[li_i+1].table_id
            LET g_table_info[1].field_id = g_table_info[li_i+1].field_id
            LET g_table_info[1].field_pk = g_table_info[li_i+1].field_pk
            LET g_table_info[1].field_type  = g_table_info[li_i+1].field_type 
            LET g_table_info[1].field_ent = g_table_info[li_i+1].field_ent
            LET g_table_info[1].field_lang = g_table_info[li_i+1].field_lang
            CALL g_table_info.deleteElement(li_i+1)
         END IF 
      END IF     
   END FOR

   FOR li_i = 1 TO g_table_info.getLength() 
       LET ls_tmp = g_table_info[li_i].field_id
       LET ls_tmp = DOWNSHIFT(ls_tmp)
       IF ls_tmp.getIndexOf("site",1) THEN
         #判定是否有site欄位
           IF cl_getField(g_table_info[li_i].table_id,g_table_info[li_i].field_id) THEN 
              IF li_i = 2 THEN 
                 EXIT FOR 
              END IF
              CALL g_table_info.insertElement(2)#
              LET g_table_info[2].table_id = g_table_info[li_i+1].table_id
              LET g_table_info[2].field_id = g_table_info[li_i+1].field_id
              LET g_table_info[2].field_pk = g_table_info[li_i+1].field_pk
              LET g_table_info[2].field_type  = g_table_info[li_i+1].field_type 
              LET g_table_info[2].field_ent = g_table_info[li_i+1].field_ent
              LET g_table_info[2].field_lang = g_table_info[li_i+1].field_lang
              CALL g_table_info.deleteElement(li_i+1)
           END IF  
     END IF
   END FOR
   
   DISPLAY "------------------------------"
   FOR li_i = 1 TO g_table_info.getLength()
      CALL adzp140_output_log("g_table_info g_field_id:"||g_table_info[li_i].field_id || " field type: " || g_table_info[li_i].field_type ) 
      CALL adzp140_output_log("g_table_info g_field_pk:"||g_table_info[li_i].field_pk || " field_lang: " || g_table_info[li_i].field_lang )    
      
      DISPLAY "欄位:",g_table_info[li_i].field_id  ," 欄位屬性: ",g_table_info[li_i].field_type
      DISPLAY "控件代碼:",g_table_info[li_i].widge_code 
      DISPLAY "是否PK:",g_table_info[li_i].field_pk  ," 是否語言別: ",g_table_info[li_i].field_lang 
   END FOR
   DISPLAY "------------------------------" 
END FUNCTION 

#+ 程式樣板讀取/程式寫出(一進一出) / 產生器符號中斷,擺放切片或產生code
PRIVATE FUNCTION sadzp140_read_and_replace( )
   DEFINE lchannel_read           base.Channel
   DEFINE lchannel_write          base.Channel
   DEFINE ls_readline             STRING
   DEFINE ls_text                 STRING
   DEFINE ls_sample_filename      STRING
   DEFINE ls_code_filename        STRING

   LET lchannel_read = base.Channel.create()
   LET lchannel_write = base.Channel.create()

   CALL lchannel_read.setDelimiter("")
   CALL lchannel_write.setDelimiter("")
   #定義寫入檔案  $COM/lng/4gl/n_tabid.4gl
   LET ls_sample_filename = os.Path.join(os.Path.join(FGL_GETENV("COM"),"lng"),"4gl") #檔案路徑
   LET ls_code_filename = os.Path.join(ls_sample_filename,gs_code_filename||".4gl")

   #定義要讀取的樣板檔案  $COM/lng/mdl/ntab_template.4gl 
   LET ls_sample_filename = os.Path.join(os.Path.join(FGL_GETENV("COM"),"lng"),"mdl")
   LET ls_sample_filename = os.Path.join(ls_sample_filename,"ntab_template.4gl")
 
   DISPLAY "樣板檔:",ls_sample_filename
   DISPLAY "目的檔:",gs_code_filename,".4gl"
   
   IF NOT os.Path.exists(ls_sample_filename) THEN
      DISPLAY "Error:樣板檔案:",ls_sample_filename.trim()," 不存在!"
      EXIT PROGRAM
   END IF
   CALL lchannel_read.openFile(ls_sample_filename CLIPPED, "r" )

   DISPLAY "產生檔位置:", ls_code_filename
   
   IF NOT os.Path.exists(ls_code_filename) THEN

      CALL lchannel_write.openFile(ls_code_filename, "w" )
   ELSE
      IF os.Path.delete(ls_code_filename||".bak") THEN

      END IF
      
      IF NOT os.Path.rename(ls_code_filename, ls_code_filename||".bak" ) THEN 
         DISPLAY "Error:目的備份檔案:",ls_code_filename.trim(),"不存在!"
         #EXIT PROGRAM   
      END IF 
      CALL lchannel_write.openFile(ls_code_filename, "w" )
   END IF
   
   #產生程式版本及說明
   CALL lchannel_write.write(sadzp140_prog_memo())

   #讀取及轉換
   WHILE TRUE
   
      LET ls_text = ""
      LET ls_readline = lchannel_read.readLine()
        
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF

      #產生code部分
      #DISPLAY ls_readline
      CASE
         #page段落產生
         WHEN ls_readline.getIndexOf("#pages - Start -",1) > 0
            CALL sadzp140_make_pages(lchannel_read,lchannel_write) RETURNING lchannel_read,lchannel_write
            LET ls_readline = ""
          
         # 在input( )段落產生
         WHEN ls_readline.getIndexOf("#detail_keys - Start -",1) > 0            
             CALL sadzp140_make_keys(lchannel_read,lchannel_write,'d') RETURNING lchannel_read,lchannel_write         
            LET ls_readline = ""
         WHEN ls_readline.getIndexOf("#master_keys - Start -",1) > 0            
             CALL sadzp140_make_keys(lchannel_read,lchannel_write,'m') RETURNING lchannel_read,lchannel_write         
            LET ls_readline = ""   

         #trans_cnt段落產生
         WHEN ls_readline.getIndexOf("#trans_cnt - Start -",1) > 0
            CALL sadzp140_make_trans_fields(lchannel_read,lchannel_write) RETURNING lchannel_read,lchannel_write
            LET ls_readline = ""

      END CASE
      
      #行代換/ 對 ${} 置換
      IF ls_readline.getIndexOf("${",1) AND 
         (ls_readline.getIndexOf("${",1) < ls_readline.getIndexOf("}",1)) THEN
         LET ls_text = sadzp140_line_replace(ls_readline)
      END IF

      #一般未進行任何處理段落產出
      IF ls_text IS NULL THEN
         LET ls_text = ls_readline
      END IF
      CALL lchannel_write.write(ls_text)
   END WHILE

   CALL lchannel_read.close()
   CALL lchannel_write.close()

   #進行4gl編譯成42m
   #CALL sadzp140_compile_file("1")
   
END FUNCTION

#+ 逐行代換
PRIVATE FUNCTION sadzp140_line_replace(ls_read)
   DEFINE ls_read     STRING
   DEFINE ls_text     STRING
   DEFINE ls_tag      STRING
   DEFINE li_pos1     LIKE type_t.num10
   DEFINE li_pos2     LIKE type_t.num10
   DEFINE ls_temp     STRING                #暫存properties資料用

   LET li_pos1 = ls_read.getIndexOf("${",1)
   LET li_pos2 = ls_read.getIndexOf("}", li_pos1)

   IF li_pos1 > 0 AND li_pos2 > 0 AND li_pos1 < li_pos2 THEN
      LET ls_text = ""
      LET ls_tag = ls_read.subString(li_pos1 +2, li_pos2 -1 ) #取出要置換的tag

      #由SaxAttribute內取出值進行代換
      #不在行首
      IF li_pos1 > 1 THEN
         LET ls_text = ls_read.subString(1, li_pos1 - 1)
      END IF

      #中間段
      LET ls_temp = g_properties.getValue(ls_tag) CLIPPED
         
      LET ls_text = ls_text, g_properties.getValue(ls_tag) CLIPPED,
                       ls_read.subString(li_pos2+1, ls_read.getLength())

      #遞迴處理同行其他組
      IF ls_text.getIndexOf("${",1) THEN
         LET ls_text = sadzp140_line_replace(ls_text)
      END IF
   END IF

   RETURN ls_text
END FUNCTION

#+ 產生程式版本及說明
PRIVATE FUNCTION sadzp140_prog_memo()
   DEFINE ls_text  STRING

   LET ls_text = ""
   LET ls_text = ls_text, "#+ Version..: T100-ERP-1.00.00 Build-", sadzp140_prog_buildtime(), " at ", TODAY, "\n"
   LET ls_text = ls_text, "#+ ","\n" 
   LET ls_text = ls_text, "#+ Filename......: ", gs_code_filename CLIPPED,".4gl" ,"\n"
   LET ls_text = ls_text, "#+ Buildtype..: " ,"\n"
   LET ls_text = ls_text, "#+ Memo.......: " ,"\n" 

   RETURN ls_text
END FUNCTION

#+ 根據tabx設定之key數量產生對應之key段落
PRIVATE FUNCTION sadzp140_make_keys(l_read,l_write,ls_cmd)
   DEFINE ls_cmd       STRING 
   DEFINE l_read        base.Channel
   DEFINE l_write       base.Channel
   DEFINE l_tmp         STRING 
   DEFINE l_key        DYNAMIC ARRAY OF STRING 
   DEFINE l_key_num    LIKE type_t.num10 
   DEFINE li_cnt        LIKE type_t.num10 
   DEFINE l_is          STRING 
 
   IF ls_cmd = 'm' THEN 
      LET l_key_num = g_properties.getValue("master_key_cnt")
   ELSE 
      LET l_key_num = g_properties.getValue("detail_key_cnt")
   END IF 
   #先取出key段落之樣本
   WHILE TRUE 
      LET l_tmp = l_read.readLine()
      IF l_tmp.getIndexOf("#keys -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_key[1] = l_key[1],l_tmp , "\n"
   END WHILE 

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_key_num
      
      #先將${key}取代掉
      LET l_is = li_cnt
      LET l_key[li_cnt] = (2*li_space) SPACES, "#key",l_is,"\n",
          sadzp140_replace_key(l_key[1],li_cnt)
						
      #若資料未取代完成則重複返回
      WHILE l_key[li_cnt].getIndexOf("${",1) > 0 
         LET l_key[li_cnt] = sadzp140_line_replace(l_key[li_cnt])
      END WHILE  
      #回寫到檔案中
      CALL l_write.write( l_key[li_cnt] )
   END FOR    
   RETURN l_read,l_write
END FUNCTION 

#+ 根據tabx設定之page數量產生對應之page段落
PRIVATE FUNCTION sadzp140_make_pages(l_read,l_write)
   DEFINE l_read        base.Channel
   DEFINE l_write       base.Channel
   DEFINE l_tmp         STRING 
   DEFINE l_page        DYNAMIC ARRAY OF STRING 
   DEFINE l_page_num    LIKE type_t.num10 
   DEFINE li_cnt        LIKE type_t.num10 
   DEFINE l_is          STRING 

   #先取出page段落之樣本
   WHILE TRUE 
      LET l_tmp = l_read.readLine()
      IF l_tmp.getIndexOf("#pages -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_page[1] = l_page[1],l_tmp , "\n"
   END WHILE 
   #取得page總數量
   LET l_page_num = g_properties.getValue("page")
   #根據page數量產生對應的page段落並進行資料取代
   FOR li_cnt = 2 TO l_page_num
      
      #先將${page}取代掉
      LET l_is = li_cnt
      LET l_page[li_cnt] = (2*li_space) SPACES, "#Page",l_is,"\n",
                        sadzp140_replace_page(l_page[1],li_cnt)
      #若資料未取代完成則重複返回
      WHILE l_page[li_cnt].getIndexOf("${",1) > 0 
         LET l_page[li_cnt] = sadzp140_line_replace(l_page[li_cnt])
      END WHILE  

      #回寫到檔案中
      CALL l_write.write( l_page[li_cnt] )
   END FOR    
   RETURN l_read,l_write
END FUNCTION 

#+ 根據tabx設定之需做自動轉換的欄位數量產生對應之key段落
PRIVATE FUNCTION sadzp140_make_trans_fields(l_read,l_write)
   DEFINE l_read        base.Channel
   DEFINE l_write       base.Channel
   DEFINE l_tmp         STRING 
   DEFINE l_trans       DYNAMIC ARRAY OF STRING 
   DEFINE l_trans_num   LIKE type_t.num10 
   DEFINE li_cnt        LIKE type_t.num10 
   DEFINE l_is          STRING
   DEFINE l_trans_str   STRING
 
   LET l_trans_num = g_properties.getValue("detail_trans_field_count")
   #先取出trans_field段落之樣本
   WHILE TRUE 
      LET l_tmp = l_read.readLine()
      IF l_tmp.getIndexOf("#trans_cnt -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_trans[1] = l_trans[1],l_tmp , "\n"
   END WHILE

   LET l_trans_str = l_trans[1]

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 1 TO l_trans_num
      
      #先將${trans_field_cnt}取代掉
      LET l_is = li_cnt
   #  LET l_trans[li_cnt] = (2*li_space) SPACES, "#field",l_is,"\n",
      LET l_trans[li_cnt] = sadzp140_replace_trans_cnt(l_trans_str,li_cnt)
						
      #若資料未取代完成則重複返回
      WHILE l_trans[li_cnt].getIndexOf("${",1) > 0 
         LET l_trans[li_cnt] = sadzp140_line_replace(l_trans[li_cnt])
      END WHILE  
      #回寫到檔案中
      CALL l_write.write( l_trans[li_cnt] )
   END FOR    
   RETURN l_read,l_write
END FUNCTION 

#+ 取出版本建置次數
PRIVATE FUNCTION sadzp140_prog_buildtime()
   DEFINE lc_dzaz001   LIKE dzaz_t.dzaz001
   DEFINE li_dzaz002   LIKE dzaz_t.dzaz002
   DEFINE lc_dzaz003   LIKE dzaz_t.dzaz003
   DEFINE lc_dzaz004   DATETIME YEAR TO SECOND

   LET lc_dzaz001 = gs_code_filename CLIPPED
   LET li_dzaz002 = 0
   
   SELECT MAX(dzaz002) INTO li_dzaz002 FROM dzaz_t WHERE dzaz001 = lc_dzaz001
   
   IF STATUS OR li_dzaz002 IS NULL THEN
      LET li_dzaz002 = 0
   END IF
   
   #取得登入帳號
   LET lc_dzaz003 = FGL_GETENV("LOGNAME")
   LET lc_dzaz004 = CURRENT

   INSERT INTO dzaz_t(dzaz001, dzaz002, dzaz003, dzaz004)
      VALUES(lc_dzaz001, li_dzaz002+1, lc_dzaz003, lc_dzaz004)

   RETURN li_dzaz002 USING "&&&&"
END FUNCTION

#+ 取代${key}並帶入實際數字
PRIVATE FUNCTION sadzp140_replace_key(p_key, l_i)

   DEFINE p_key   STRING 
   DEFINE l_i     LIKE type_t.num10 
   DEFINE p_i      STRING 
   DEFINE l_s      LIKE type_t.num10 
   DEFINE l_e      LIKE type_t.num10 
   DEFINE l_key   STRING 
   
   LET p_i = l_i USING "&&"
   WHILE TRUE 
      LET l_s = p_key.getIndexOf("${key}",1) - 1
      LET l_e = p_key.getLength()
      #取代${key}
      LET l_key = p_key.subString(1,l_s), p_i,p_key.subString((l_s+7),l_e)
      LET p_key = l_key
      IF l_key.getIndexOf("${key}",1) < 1 THEN 
          EXIT while
      END IF 
   END WHILE 
    
   RETURN l_key
END FUNCTION 

#+ 取代${page}並帶入實際數字
PRIVATE FUNCTION sadzp140_replace_page(p_page, p_i)

   DEFINE p_page   STRING 
   DEFINE p_i      STRING 
   DEFINE l_s      LIKE type_t.num10 
   DEFINE l_e      LIKE type_t.num10 
   DEFINE l_page   STRING 

   WHILE TRUE 
      LET l_s = p_page.getIndexOf("${page}",1) - 1
      LET l_e = p_page.getLength()
          #取代${page}
      LET l_page = p_page.subString(1,l_s), p_i,p_page.subString((l_s+8),l_e)
      LET p_page = l_page
      IF l_page.getIndexOf("${page}",1) < 1 THEN 
          EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN l_page
END FUNCTION 

#+ 取代${trans_cnt}並帶入實際數字
PRIVATE FUNCTION sadzp140_replace_trans_cnt(p_trans, l_i)
   DEFINE p_trans   STRING 
   DEFINE p_i       STRING 
   DEFINE l_i       LIKE type_t.num10 
   DEFINE l_s       LIKE type_t.num10 
   DEFINE l_e       LIKE type_t.num10 
   DEFINE l_trans   STRING
   DEFINE l_str     STRING


   LET p_i = l_i USING "&&"
   LET l_str = "${trans_field_cnt}"
   WHILE TRUE 
      LET l_s = p_trans.getIndexOf(l_str,1) - 1
      LET l_e = p_trans.getLength()
          #取代${trans_cnt}
      LET l_trans = p_trans.subString(1,l_s), p_i,p_trans.subString((l_s+l_str.getLength()+1),l_e)
      LET p_trans = l_trans
      IF l_trans.getIndexOf(l_str,1) < 1 THEN 
          EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN l_trans
END FUNCTION 

PRIVATE FUNCTION sadzp140_chk_pk_count()
   DEFINE li_stus LIKE type_t.num5
   DEFINE li LIKE type_t.num5
   DEFINE li_chk LIKE type_t.num5
   
   IF g_table_id.getIndexOf("l_t",1) THEN 
      FOR li = 1 TO g_table_info.getLength()
          IF g_table_info[li].field_ent THEN 
             LET li_chk = li_chk + 1 
          END IF 
          IF g_table_info[li].field_lang THEN 
             LET li_chk = li_chk + 1 
          END IF
      END FOR 

   END IF 
   IF li_chk = g_pkey_count THEN 
       RETURN FALSE  
   END IF 
   RETURN TRUE  
END FUNCTION 

#+ 把產生過程寫入到log 
PUBLIC FUNCTION adzp140_output_log(p_msg)

   DEFINE p_msg   STRING   
   CALL g_generation_ch.writeLine(p_msg)

END FUNCTION 

#+建立channel
PUBLIC FUNCTION adzp140_channel()
   LET g_generation_ch = base.Channel.create()
   LET gs_log_file = "adzp140_",g_table_id CLIPPED,".log"
   LET gs_log_path = os.Path.join(FGL_GETENV("TEMPDIR"),gs_log_file)   
   DISPLAY "輸出log位置:",gs_log_path
   IF NOT os.Path.exists(gs_log_path) THEN
      CALL g_generation_ch.openFile(gs_log_path, "w")      
   ELSE 
      IF os.Path.delete(gs_log_path) THEN 
         CALL g_generation_ch.openFile(gs_log_path, "w") 
      END IF    
   END IF
END FUNCTION 

#+ 全部重產
PUBLIC FUNCTION sadzp140_gen_all()
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE lc_gzzn002  LIKE gzzn_t.gzzn002
   DEFINE ls_gzzn002  LIKE gzzn_t.gzzn002
   DEFINE ls_cmd      STRING  
   
   SELECT COUNT(*) INTO li_cnt FROM gzzn_t
    WHERE gzzn001 = "LNG" AND gzzn003 = 'Y'

   IF li_cnt = 0 THEN 
      RETURN 
   END IF

   DECLARE sadzp140_gen_all_cs CURSOR FOR
   SELECT gzzn002 FROM gzzn_t
    WHERE gzzn001 = "LNG" AND gzzn003 = 'Y'

   FOREACH sadzp140_gen_all_cs INTO lc_gzzn002
      LET ls_gzzn002 = lc_gzzn002[3,LENGTH(lc_gzzn002)]
      LET ls_gzzn002 = ls_gzzn002,"_t" 
      LET ls_cmd = " r.r adzp140 ",ls_gzzn002 ," ",ARG_VAL(3) ," " ,ARG_VAL(4)
                                                 #編譯、           連結
      DISPLAY "ls_cmd: ",ls_cmd
      RUN ls_cmd  
   END FOREACH    
END FUNCTION 
