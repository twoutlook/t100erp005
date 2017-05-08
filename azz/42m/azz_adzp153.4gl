#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: adzp153
#+ Buildtype: 
#+ Memo.....: 產生參數作業
 
IMPORT os
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"

DEFINE ms_module STRING  #模組編號
DEFINE ms_prog   STRING  #程式編號
DEFINE g_trans   DYNAMIC ARRAY OF RECORD
         tag     STRING,
         code    STRING
                 END RECORD
DEFINE g_gzsz    DYNAMIC ARRAY OF RECORD
         gzsz006 LIKE gzsz_t.gzsz006,   #分頁編號
         gzsz007 LIKE gzsz_t.gzsz007,   #分項編號
         pos     LIKE type_t.num5,      #本項序號
         gzsz002 LIKE gzsz_t.gzsz002,   #參數編號
         gzsz003 LIKE gzsz_t.gzsz003,   #輸入型態
         gzsz008 LIKE gzsz_t.gzsz008,   #預設值
         gzsz009 LIKE gzsz_t.gzsz009    #值域範圍
                 END RECORD

CONSTANT li_space = 3
                 
MAIN
   DEFINE li_cnt LIKE type_t.num5
   DEFINE ls_code_filename STRING 
   
   CALL cl_tool_init()

   #取得目前的環境代碼
   LET ms_module = ARG_VAL(2) CLIPPED  #模組編號
   LET ms_prog   = ARG_VAL(3) CLIPPED  #程式編號
   #LET ms_module = "azz"
   #LET ms_prog = "azzs010" 
   IF cl_null(ms_module) OR cl_null(ms_prog) THEN 
      DISPLAY "g_argv[1]:"
      DISPLAY "Error: 參數不足"
      DISPLAY "Example: r.r adzp153 模組編號 程式編號"
      CALL cl_ap_exitprogram("0")
   END IF 
   
   IF azzp153_chk_module(UPSHIFT(ms_module)) THEN 
      DISPLAY "Error: 模組編號不存在" 
      CALL cl_ap_exitprogram("0")
   END IF 
   
   IF azzp153_chk_prog(ms_prog) THEN 
      DISPLAY "Error: 程式編號不存在"
      CALL cl_ap_exitprogram("0") 
   END IF 
   

   #代換程式資料準備
   CALL adzp153_data_prep()

   #進行程式碼轉換
   CALL adzp153_read_and_replace() RETURNING ls_code_filename

   CALL adzp153_comp_and_link(ls_code_filename)
   CALL cl_ap_exitprogram("0")
END MAIN
 
#+ 代換資料的準備
PRIVATE FUNCTION adzp153_data_prep()

   DEFINE ls_sql  STRING
   DEFINE l_gzsx  DYNAMIC ARRAY OF RECORD
           gzsx002 LIKE gzsx_t.gzsx002,   #分頁編號
           gzsx003 LIKE gzsx_t.gzsx003    #分項編號
                   END RECORD
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE li_pos     LIKE type_t.num5
   DEFINE ls_colid   STRING
   DEFINE ls_temp    STRING
   DEFINE ls_temp_2    STRING
   DEFINE li_layer,li_item LIKE type_t.num5
   DEFINE l_gzsx002_t LIKE gzsx_t.gzsx002
   DEFINE li_bak     LIKE type_t.num5
   DEFINE li_length  LIKE type_t.num5
   DEFINE ls_table   STRING 
   DEFINE li         LIKE type_t.num5

   #分頁,分項
   LET ls_sql = "SELECT gzsx002,gzsx003 FROM gzsx_t ",
                " WHERE gzsx001 = '",ms_prog.trim(),"' ",
                " ORDER BY gzsx004,gzsx005 "
   DECLARE adzp153_data_prep_cs CURSOR FROM ls_sql

   LET li_cnt = 1
   LET li_pos = 1
   LET li_layer = 0
   CALL g_trans.clear()
   LET l_gzsx002_t = " "
   #LET li_length = g_trans.getLength()
   IF li_length = 0 THEN 
      LET li_length = 1 
   END IF 

   #先定義tag
   LET g_trans[g_trans.getLength()+1].tag = "variable_list"       #1
   LET g_trans[g_trans.getLength()+1].tag = "field_list"          #2
   LET g_trans[g_trans.getLength()+1].tag = "on_action_help "     #3
   LET g_trans[g_trans.getLength()+1].tag = "before_field"        #4
   
   LET g_trans[g_trans.getLength()+1].tag = "btn_page"            #5
   LET g_trans[g_trans.getLength()+1].tag = "btn_page2"           #7
   LET g_trans[g_trans.getLength()+1].tag = "area_information"    #8
      
   LET g_trans[g_trans.getLength()+1].tag = "btn_paramsubgp"      #6

 
   LET g_trans[g_trans.getLength()+1].tag = "prog"                #9
   LET g_trans[g_trans.getLength()].code = ms_prog.trim()         
   LET g_trans[g_trans.getLength()+1].tag = "tab_id"              #10
   CALL adzp153_get_table_info() RETURNING g_trans[g_trans.getLength()].code
   LET ls_table =  g_trans[g_trans.getLength()].code 
   #display "ls_table:",ls_table
   
   #先取分頁 再取分項 最後再取參數
   FOREACH adzp153_data_prep_cs INTO l_gzsx[li_cnt].gzsx002,l_gzsx[li_cnt].gzsx003
    
      #=============先處理分頁=============
      IF l_gzsx[li_cnt].gzsx002 <> l_gzsx002_t THEN
         LET li_item = 0
         FOR li = 1 TO g_trans.getLength()
             # 切換參數區塊 & 更換參數Title圖示文字
             LET li = 5
             LET g_trans[li].code = g_trans[li].code,"\n",li_space*2 SPACES,"ON ACTION ",l_gzsx[li_cnt].gzsx002 CLIPPED,
                                                     "\n",li_space*3 SPACES,'CALL ',ms_prog,'_parameter_switch("',l_gzsx[li_cnt].gzsx002 CLIPPED,'")'
             
             LET li = li + 1
             LET g_trans[li].code = g_trans[li].code,"\n",li_space*2 SPACES,"ON ACTION ",l_gzsx[li_cnt].gzsx002 CLIPPED,
                                                     "\n",li_space*3 SPACES,'CALL ',ms_prog,'_parameter_switch("',l_gzsx[li_cnt].gzsx002 CLIPPED,'")'

             #指定各參數區塊資料
             LET li = li + 1
             LET li_layer = li_layer + 1
             LET g_trans[li].code = g_trans[li].code,"\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<","].id = \"",l_gzsx[li_cnt].gzsx002 CLIPPED,"\"",
                                                     "\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<","].name = \"aoo-702\"",
                                                     "\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<","].comp = \"scrgr",li_layer USING"<<<","\"",
                                                     "\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<","].img = \"24/s_setting.png\""

             LET li = li + 1
             # 子參數區塊開關 隱藏/顯示
             LET li_item = li_item + 1 
             LET ls_temp = "paramsubgp",li_layer USING "<<<","_",li_item USING "<<<"
             LET g_trans[li].code = g_trans[li].code,"\n",li_space*2 SPACES,"ON ACTION btn_",ls_temp,
                                                     "\n",li_space*3 SPACES,'CALL ',ms_prog,'_parameter_group_switch("',ls_temp,'")'
             EXIT FOR 
         END FOR 
      END IF

      #下去抓取個別參數
      LET li_bak = li_pos
      CALL adzp153_data_item(l_gzsx[li_cnt].gzsx002,l_gzsx[li_cnt].gzsx003,li_pos) RETURNING li_pos
      IF l_gzsx[li_cnt].gzsx002 <> l_gzsx002_t AND li_pos <> li_bak THEN
         LET ls_colid = g_gzsz[li_bak].gzsz006,"_",g_gzsz[li_bak].gzsz007,"_",g_gzsz[li_bak].pos USING "<<<"
         LET li = 6
         LET g_trans[li].code = g_trans[li].code,"\n",li_space*3 SPACES,"NEXT FIELD ",ls_colid
      END IF 
      LET l_gzsx002_t = l_gzsx[li_cnt].gzsx002
   END FOREACH

   #個別參數
   FOR li_cnt = 1 TO g_gzsz.getLength()
      IF g_gzsz[li_cnt].gzsz006 IS NOT NULL THEN
         LET ls_colid = g_gzsz[li_cnt].gzsz006,"_",g_gzsz[li_cnt].gzsz007,"_",g_gzsz[li_cnt].pos USING "<<<"

         FOR li =  1 TO g_trans.getLength()
             LET li =  1
             LET g_trans[li].code = g_trans[li].code,"g_",ls_table.subString(1,4),"_d[",li_cnt USING "<<<","].",ls_table.subString(1,4),"002,"
             LET li =  li + 1
             LET g_trans[li].code = g_trans[li].code,ls_colid,","
             LET li =  li + 1 
             LET g_trans[li].code = g_trans[li].code,"\n",li_space*2 SPACES,"ON ACTION help_",ls_colid,
                                                     "\n",li_space*3 SPACES,'CALL ',ms_prog,'_show_field_help("',ls_colid,'")'
             LET li =  li + 1
             LET g_trans[li].code = g_trans[li].code,"\n",li_space*3 SPACES,"BEFORE FIELD ",ls_colid,
                                                     "\n",li_space*4 SPACES,'CALL ',ms_prog,'_show_field_help("',ls_colid,'")'
             EXIT FOR  
         END FOR 
        
      END IF
   END FOR
   
   #variable_list
   LET g_trans[1].code = g_trans[1].code.subString(1,g_trans[1].code.getLength()-1)
   #field_list
   LET g_trans[2].code = g_trans[2].code.subString(1,g_trans[2].code.getLength()-1)

   #13/12/10
   LET g_trans[g_trans.getLength()+1].tag = "general_module"
   LET g_trans[g_trans.getLength()].code = ms_module

   #g_ooaa_d
   LET g_trans[g_trans.getLength()+1].tag = "detail_var_title"
   LET g_trans[g_trans.getLength()].code = "g_",ls_table.subString(1,4),"_d" 

   #field info
   CALL adzp153_get_field_info(ls_table) RETURNING ls_temp,ls_temp_2
   LET g_trans[g_trans.getLength()+1].tag = "detail_fields_define"
   LET g_trans[g_trans.getLength()].code = ls_temp

   LET g_trans[g_trans.getLength()+1].tag = "detail_fields"
   LET g_trans[g_trans.getLength()].code = ls_temp_2

   
END FUNCTION
 
#+ 抓取細項參數資料
PRIVATE FUNCTION adzp153_data_item(lc_gzsz006,lc_gzsz007,li_pos)
   DEFINE li_pos     LIKE type_t.num5
   DEFINE lc_gzsz006 LIKE gzsz_t.gzsz006  #分頁編號
   DEFINE lc_gzsz007 LIKE gzsz_t.gzsz007  #分項編號
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5

   LET ls_sql = "SELECT gzsz006,gzsz007,'',gzsz002,gzsz003,gzsz008,gzsz009 ",
                 " FROM gzsz_t ",
                " WHERE gzsz004 = '",ms_prog.trim(),"' ",
                  " AND gzsz006 = '",lc_gzsz006 CLIPPED,"' ", #分頁編號
                  " AND gzsz007 = '",lc_gzsz007 CLIPPED,"' ", #分項編號
                  " AND gzszstus = 'Y' ",
                " ORDER BY gzsz005 "
   DISPLAY "adzp153_data_item ls_sql:",ls_sql
   DECLARE adzp153_data_item_cs CURSOR FROM ls_sql
   LET li_cnt = 1
   FOREACH adzp153_data_item_cs INTO g_gzsz[li_pos].*
      LET g_gzsz[li_pos].pos = li_cnt
      LET li_cnt = li_cnt + 1
      LET li_pos = li_pos + 1
   END FOREACH
   CALL g_gzsz.deleteElement(li_pos)
   RETURN g_gzsz.getLength()+1
END FUNCTION

#+ 程式讀取/程式寫出(一進一出) 
PRIVATE FUNCTION adzp153_read_and_replace()
 
   DEFINE lchannel_read         base.Channel
   DEFINE lchannel_write        base.Channel
   DEFINE ls_readline           STRING
   DEFINE ls_text               STRING
   DEFINE ls_code_filename      STRING
   DEFINE ls_sample_filename    STRING
   DEFINE ls_prog               STRING
 
   LET lchannel_read = base.Channel.create()
   LET lchannel_write = base.Channel.create()
 
   CALL lchannel_read.setDelimiter("")
   CALL lchannel_write.setDelimiter("")
 
   #定義寫入檔案  $ERP/Module/4gl/xxxxx.4gl
   LET ls_code_filename = os.Path.join(os.Path.join(FGL_GETENV("ERP"),ms_module),"4gl")
   LET ls_code_filename = os.Path.join(ls_code_filename,ms_prog||".4gl")
   DISPLAY "ls_code_filename:",ls_code_filename
   #定義要讀取的 template 檔案
   LET ls_sample_filename = os.Path.join(FGL_GETENV("ERP"),"mdl")
   LET ls_sample_filename = os.Path.join(ls_sample_filename,"code_s01.template")
   DISPLAY "ls_sample_filename:",ls_sample_filename
   DISPLAY "azdp153:產生器" 

   #檢查來源
   IF NOT os.Path.exists(ls_sample_filename) THEN
      DISPLAY "Error:來源檔案:",ls_sample_filename.trim()," 不存在!"
      EXIT PROGRAM
   ELSE
      DISPLAY "來源檔:",ls_sample_filename
      CALL lchannel_read.openFile( ls_sample_filename CLIPPED, "r" )
   END IF

   #先行移除4gl
   IF os.Path.delete(ls_code_filename) THEN
      DISPLAY "刪除舊檔案:",ls_code_filename
   END IF

   #判斷是否砍除成功
   IF NOT os.Path.exists(ls_code_filename) THEN
      DISPLAY "舊檔案刪除成功:",ls_code_filename
   ELSE
      DISPLAY "Error:舊檔案刪除失敗:",ls_code_filename
      EXIT PROGRAM
   END IF

   DISPLAY "目的檔:",ls_code_filename
   CALL lchannel_write.openFile( ls_code_filename CLIPPED, "w" )
   #讀取及轉換
   
   WHILE TRUE
      LET ls_text = ""
      LET ls_readline = lchannel_read.readLine()
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF

     #行代換/ 對 ${} 置換
      IF ls_readline.getIndexOf("${",1) AND
         (ls_readline.getIndexOf("${",1) < ls_readline.getIndexOf("}",1)) THEN
         LET ls_text = adzp153_line_replace(ls_readline)
      END IF

      #一般未進行任何處理段落產出
      IF ls_text IS NULL THEN
         LET ls_text = ls_readline
      END IF
      
      #進行檢視與代換
      #IF ls_readline.getIndexOf("${",1) THEN
      #   LET ls_text = adzp153_line_replace(ls_readline)
      #ELSE
      #   LET ls_text = ls_readline
      #END IF

      CALL lchannel_write.write(ls_text)
   END WHILE
   
   CALL lchannel_read.close()
   CALL lchannel_write.close()
   
   DISPLAY ls_code_filename,"產生成功!"
   
   #對產生器寫出的檔案權限在UNIX下均全部打開
   IF os.Path.separator() = "/" THEN
      IF os.Path.chrwx(ls_code_filename,511) THEN
      END IF
   END IF
   RETURN ls_code_filename
END FUNCTION
 
#+ 從db內把資料讀出來
PRIVATE FUNCTION adzp153_line_replace(ls_readline)
   DEFINE ls_readline  STRING 
   DEFINE ls_text      STRING
   DEFINE li_pos,li_end,li_cnt LIKE type_t.num5
   DEFINE ls_tag  STRING

   LET li_pos = ls_readline.getIndexOf("${",1)

   #取出待轉換的tag
   IF li_pos > 0 THEN
      LET li_end = ls_readline.getIndexOf("}",li_pos+2)
      LET ls_tag = ls_readline.subString(li_pos+2,li_end-1)
      FOR li_cnt = 1 TO g_trans.getLength()
         IF g_trans[li_cnt].tag = ls_tag THEN
            IF li_pos = 1 THEN
               LET ls_text = g_trans[li_cnt].code,ls_readline.subString(li_end,ls_readline.getLength())
            ELSE
               LET ls_text = ls_readline.subString(1,li_pos-1),
                             g_trans[li_cnt].code,
                             ls_readline.subString(li_end+1,ls_readline.getLength())
            END IF
         END IF
      END FOR
   END IF

   #遞迴處理同行其他組
   IF ls_text.getIndexOf("${",1) THEN
      LET ls_text = adzp153_line_replace(ls_text)
   END IF
   IF ls_text IS NULL THEN
      LET ls_text = ls_readline
   END IF

   RETURN ls_text
END FUNCTION


PRIVATE FUNCTION adzp153_get_table_info()
   DEFINE lc_gzsz001 LIKE gzsz_t.gzsz001 
   DEFINE ls_sql STRING 

   LET ls_sql = " SELECT DISTINCT gzsz001  ", 
                "    FROM gzsz_t ",
                "       WHERE gzsz004 = '",ms_prog.trim(),"'"
   PREPARE adzp153_table_info_pre FROM ls_sql
   EXECUTE adzp153_table_info_pre  INTO lc_gzsz001

   
   FREE adzp153_table_info_pre 
   RETURN lc_gzsz001  
END FUNCTION 

#+ 取得 fields 
PRIVATE FUNCTION adzp153_get_field_info(pc_table)
    DEFINE lc_dzeb002 LIKE dzeb_t.dzeb002
    DEFINE lc_dzeb004 LIKE dzeb_t.dzeb004
    DEFINE lc_dzeb005 LIKE dzeb_t.dzeb005
    DEFINE lc_dzeb006 LIKE dzeb_t.dzeb006
    DEFINE pc_table   LIKE dzeb_t.dzeb001  
    DEFINE ls_field   STRING 
    DEFINE ls_temp    STRING
    DEFINE ls_temp_2         STRING 
    DEFINE ls_define  STRING 
    DEFINE ls_define_desc STRING 
    DEFINE ls_sql     STRING 
    DEFINE li_ent     LIKE type_t.num5
    DEFINE ls_select_fields  STRING  

    LET ls_sql = " SELECT dzeb002,dzeb004,dzeb005,dzeb006 " , 
                 " FROM dzeb_t ", 
                 " WHERE ",
                 " dzeb001 = ? ORDER BY dzeb021 "
    PREPARE adzp153_field_info_pre FROM ls_sql
    DECLARE adzp153_field_info_curs CURSOR FROM ls_sql 
    #DISPLAY "ls_sql:",ls_sql
    LET li_ent = FALSE 
    OPEN adzp153_field_info_curs USING pc_table
    FOREACH adzp153_field_info_curs INTO lc_dzeb002,lc_dzeb004,lc_dzeb005,lc_dzeb006
       LET ls_define = ""
       LET ls_define_desc = ""
       LET ls_select_fields = ""
       LET ls_field =  lc_dzeb002
       CASE 
          #判別ent field
          WHEN ls_field.getIndexOf("ent",1) 
               LET li_ent = TRUE 
               LET g_trans[g_trans.getLength()+1].tag = "detail_append_ent_wc"  
               LET g_trans[g_trans.getLength()].code = ls_field ,"=g_enterprise "," AND "

               LET g_trans[g_trans.getLength()+1].tag = "detail_var_ent_append"
               LET g_trans[g_trans.getLength()].code = "\"",ls_field ," = \" ,g_enterprise,\" AND \"," 
               CONTINUE FOREACH 
               
          WHEN ls_field.getIndexOf("modid",1) OR ls_field.getIndexOf("crtid",1)  OR ls_field.getIndexOf("ownid",1) 
               OR ls_field.getIndexOf("crtdp",1)  
               
               IF ls_field.getIndexOf("modid",1) THEN 
                  LET g_trans[g_trans.getLength()+1].tag = "field_modid"  
                  LET g_trans[g_trans.getLength()].code = ls_field
               END IF 
               #DISPLAY " 000 ls_field:",ls_field
               LET ls_define = li_space SPACES ,ls_field ," LIKE ",pc_table,".",ls_field ,",\n"
               LET ls_define_desc = li_space SPACES ,ls_field ,"_desc"," LIKE type_t.chr80,\n" 
 
               LET ls_select_fields = ls_field,",'',"
          WHEN ls_field.getIndexOf("moddt",1)  OR ls_field.getIndexOf("crtdt",1)   

               IF ls_field.getIndexOf("moddt",1) THEN 
                  LET g_trans[g_trans.getLength()+1].tag = "field_moddt"  
                  LET g_trans[g_trans.getLength()].code = ls_field
               END IF 
               LET ls_define = li_space SPACES,ls_field ," DATETIME YEAR TO SECOND ,\n"
               LET ls_select_fields = ls_field ,","
          WHEN lc_dzeb005 = "Y" AND lc_dzeb006 = "C101"  
               LET g_trans[g_trans.getLength()+1].tag = "field_fk"  
               LET g_trans[g_trans.getLength()].code = ls_field
               LET ls_define = li_space SPACES,ls_field," LIKE ",pc_table,".",ls_field ,",\n"
               LET ls_select_fields = ls_field,","
          WHEN lc_dzeb004 = "Y" AND lc_dzeb005 = "Y"  
               LET g_trans[g_trans.getLength()+1].tag = "field_pk"  
               LET g_trans[g_trans.getLength()].code = ls_field
               LET ls_define = li_space SPACES ,ls_field," LIKE ",pc_table,".",ls_field ,",\n"
               LET ls_define = li_space SPACES ,ls_define ,ls_field ,"_desc"," LIKE type_t.chr80,\n"   
               LET ls_select_fields = ls_field,",''," 
       END CASE  
       #DISPLAY "ls_temp:",ls_temp
       #DISPLAY "ls_temp_2:",ls_temp_2
       LET ls_temp = ls_temp,ls_define,ls_define_desc
       LET ls_temp_2 = ls_temp_2,ls_select_fields
    END FOREACH 

    IF NOT li_ent THEN 
       LET g_trans[g_trans.getLength()+1].tag = "detail_append_ent_wc"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_var_ent_append"
       LET g_trans[g_trans.getLength()].code = " "
    END IF 
    LET ls_temp = ls_temp.subString(1,ls_temp.getLength()-3)
    LET ls_temp_2 = ls_temp_2.subString(1,ls_temp_2.getLength()-1)
    CLOSE adzp153_field_info_curs
    FREE adzp153_field_info_pre
    RETURN ls_temp,ls_temp_2
END FUNCTION  

#+檢核模組
PRIVATE FUNCTION azzp153_chk_module(ps_module)
   DEFINE ps_module LIKE gzzo_t.gzzo001 
   DEFINE li_cnt LIKE type_t.num5

   SELECT count(*) INTO li_cnt FROM  gzzo_t WHERE gzzo001 = ps_module
   #DISPLAY "li_cnt:",li_cnt
   IF li_cnt > 0 THEN
      RETURN   FALSE 
   END IF 
   RETURN TRUE
END FUNCTION

#+ 檢核程式編號
PRIVATE FUNCTION azzp153_chk_prog(ps_prog)
   DEFINE ps_prog LIKE gzza_t.gzza001 
   DEFINE li_cnt LIKE type_t.num5

   SELECT count(*) INTO li_cnt FROM  gzza_t WHERE gzza001 = ps_prog
   #DISPLAY "li_cnt:",li_cnt
   IF li_cnt > 0 THEN
      RETURN   FALSE 
   END IF 
   RETURN TRUE
END FUNCTION

#+ complier及link及產生多語言 
PRIVATE FUNCTION adzp153_comp_and_link(ps_code_filename) 
   DEFINE ps_code_filename STRING  #/u1/t10dev/erp/aoo/4gl/aoos010.4gl
   DEFINE ls_dir           STRING 
   DEFINE li_result        LIKE type_t.num5
   DEFINE ls_psg           STRING 

   LET ls_dir = os.Path.dirname(ps_code_filename)
   #DISPLAY "ls_dir:",ls_dir
   IF  os.Path.chdir(ls_dir) THEN END IF 
   CALL cl_cmdrun_openpipe("r.c","r.c "||ms_prog ,"0") RETURNING li_result,ls_psg

   IF li_result THEN 
      CALL cl_cmdrun_openpipe("r.l","r.l "||ms_prog ,"0") RETURNING li_result,ls_psg
   END IF 



   CALL cl_cmdrun_openpipe("r.r","r.r adzp154 "||ms_module ||" "||ms_prog ,"0") RETURNING li_result,ls_psg 


   CALL cl_cmdrun_openpipe("r.r","r.r azzp191 "||ms_prog ||" "||g_lang ,"0") RETURNING li_result,ls_psg

END FUNCTION 