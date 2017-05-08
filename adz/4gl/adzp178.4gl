#+ 程式版本......: T100-ERP-1.00.00 Build-00001
#
#+ 程式代碼......: adzp178
#+ 設計人員......: Janet
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp170.4gl 
# Description    : 解析4fd畫面成設計資料工具
# Memo           :
#+ ...........: 161031 janet #161031-00071#1 撈取客製sql資料處理
#+ ...........: 161110 janet #161110-00037#1 多樣板upd 報表元件不是客製的gzgf003為x
#+ ...........: 161228 janet #161227-00056#1 調整撈取gztz_t時，要判斷掉'erp'、'all'、'b2b'、'pos'、'dsm'，避免多拉資料
#+ ...........: 170111 janet #170111-00066#1 補回dzgb011、dzgb013、dzgb015資料
#+ ...........: 170210 janet #170123-00046#1 整批調整報表工具訊息為多語言

IMPORT os
SCHEMA ds


GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"

DEFINE g_log_ch         base.Channel
DEFINE g_log_ch_err     base.Channel
DEFINE g_msg            STRING 
DEFINE g_langs          DYNAMIC ARRAY OF LIKE gzzy_t.gzzy001
DEFINE g_gzgd007        LIKE gzgd_t.gzgd007 #樣板名稱 
DEFINE g_4rpfile        STRING              #檔案路徑
#161110-00037 add -(s)
PRIVATE type type_gzgf   RECORD
        gzgf001          LIKE gzgf_t.gzgf001,
        gzgf002          LIKE gzgf_t.gzgf002,
        gzgf003          LIKE gzgf_t.gzgf003,
        gzgf002_u        LIKE gzgf_t.gzgf002,
        gzgf003_u        LIKE gzgf_t.gzgf003,
        upd              LIKE type_t.chr1 
        END RECORD 
#161110-00037 add -(e)
MAIN
   DEFINE l_result          BOOLEAN
   DEFINE l_node            om.DomNode            #4fd domNode

   DEFINE l_module          STRING                  #4fd所在模組
   DEFINE l_form_name       STRING                  #UI畫面代號
   DEFINE l_ver             STRING                  #規格版次
   DEFINE l_dgenv           LIKE type_t.chr1        #使用標示:s-標準產品, c-客製
   DEFINE l_error_message   STRING
   DEFINE ls_name           STRING 
   DEFINE ls_b              BOOLEAN 
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_msg           STRING   
   DEFINE l_img_path STRING
DEFINE ls_return   STRING
DEFINE ls_match    STRING
DEFINE ls_cnt      LIKE type_t.num5
DEFINE l_cmd       STRING
DEFINE l_num       DECIMAL(20) 
   DEFINE l_dzed004   LIKE dzed_t.dzed004
   DEFINE l_dzed006   LIKE dzed_t.dzed006

  
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz", "") #todo

   #切換至使用者所需要的資料庫 (營運中心)  #todo
   #DISCONNECT CURRENT #todo
   CALL cl_db_connect("ds",FALSE)  #140804 add
   DISPLAY 'connect:ds->', STATUS

   #LET l_num = 21.000000
   #DISPLAY l_num

   #LET l_module = UPSHIFT(ARG_VAL(1))   # 4fd所在模組
   #LET l_form_name = ARG_VAL(3)         # UI畫面代號  "demo"
   LET l_ver = ARG_VAL(2)               # 功能選項   #161110-00037 add -(s)
   DISPLAY "l_ver:",l_ver
   #LET l_dgenv = ARG_VAL(5)             # 使用標示

   IF cl_null(l_dgenv) THEN
      LET l_dgenv = FGL_GETENV("DGENV")
   END IF
   #LET g_lang = "zh_TW"
   #LET l_cmd = "export DGENV='s' "
   #RUN l_cmd
   #LET g_account = 'cynthiajhao'
   #LET g_prog = 'adzp188'
   #LET g_prog_id = "apmt580"
   #LET g_sd_ver = "

   #161110-00037 add -(s)
   IF NOT cl_null(l_ver) THEN 

      CASE l_ver 
        WHEN "1"
          ##更新報表元件sql
          DISPLAY "更新報表元件sql........"
          CALL sadzp188_upd_dzgb()           
        WHEN "2"
          #更新多樣板gzgf002與gzgf003資料
          DISPLAY "更新多樣板gzgf002與gzgf003資料........"
          CALL sadzp178_upd_gzgf002003()  
        #170111-00066#1 add- (s)  
        WHEN "3"
          ##更新報表元件dzgb013015
          DISPLAY "更新報表元件dzgb011013015........"
          CALL sadzp188_upd_dzgb011013015() 
        #170111-00066#1 add- (e)          
      END CASE 
   ELSE 
   #161110-00037 add -(e)
      ##更新報表元件sql
      CALL sadzp188_upd_dzgb()   
   END IF    #161110-00037 add 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN

#161110-00037 add -(s)
PUBLIC FUNCTION sadzp178_upd_gzgf002003()
    DEFINE lchannel_read           base.Channel
    DEFINE lchannel_write          base.Channel
    DEFINE l_sql                   STRING 
    DEFINE l_4gl_main_cnt          INTEGER 
    DEFINE l_4gl_sub_cnt           INTEGER 
    DEFINE l_gzgg_main_cnt         INTEGER 
    DEFINE l_gzgg_sub_cnt          INTEGER 
    DEFINE ls_4glpath              STRING
    DEFINE l_prog_type             LIKE gzde_t.gzde001     #程式類型  
    DEFINE l_module                LIKE gzde_t.gzde002     #模組     
    DEFINE l_spec_ver              LIKE dzga_t.dzga002     #客製版次 
    DEFINE ls_readline             STRING 
    DEFINE ls_text                 STRING
    DEFINE l_cnt                   INTEGER
    DEFINE l_cnt1                   INTEGER
    DEFINE l_field_cnt             INTEGER 
    DEFINE l_msg                   STRING 
    DEFINE ls_code_filename        STRING     
    DEFINE l_gzgf                  DYNAMIC ARRAY OF type_gzgf
    DEFINE l_gzgf002_str           STRING 
    DEFINE l_gzgf001               LIKE gzgf_t.gzgf001
    DEFINE l_gzgf002               LIKE gzgf_t.gzgf002
    DEFINE l_gzgf003               LIKE gzgf_t.gzgf003
    DEFINE l_gzgf002_u             LIKE gzgf_t.gzgf002
    DEFINE l_gzgf003_u             LIKE gzgf_t.gzgf003
    DEFINE l_upd                   LIKE type_t.chr1
    DEFINE i                       INTEGER 
    DEFINE l_gzgf002_max           LIKE gzgf_t.gzgf002
    DEFINE l_sub_str               STRING 
    DEFINE l_gzgf002_seq           INTEGER 
    DEFINE l_sub_str_u             STRING 
    
   
    LET lchannel_read = base.Channel.create()
    LET lchannel_write = base.Channel.create()

    CALL lchannel_read.setDelimiter("")
    CALL lchannel_write.setDelimiter("")


   #產出程式路徑
   LET ls_code_filename = os.Path.join(FGL_GETENV("TEMPDIR"), "upd_gzgf002003.log")
  
   CALL l_gzgf.clear()
   
   DISPLAY "產生檔位置:",ls_code_filename
   CALL lchannel_write.openFile( ls_code_filename, "w" )

    
    DISPLAY "START TIME:",cl_get_current()
    LET l_cnt = 1
    LET l_cnt1 = 0
    LET l_sql = " SELECT gf.gzgf001,gf.gzgf002,gf.gzgf003 ",
                "   FROM gzgf_t gf",
                "  WHERE EXISTS ",
                " ( SELECT 1 FROM gzde_t de ",
                " WHERE de.gzde001 = gf.gzgf001 AND de.gzde008 ='s')",
                " AND gf.gzgf003 ='c'",
                " ORDER BY gf.gzgf001,gf.gzgf002 "
   PREPARE adzp178_prog_pre FROM l_sql
   DECLARE adzp178_prog_curs CURSOR FOR adzp178_prog_pre
   FOREACH adzp178_prog_curs INTO l_gzgf001, l_gzgf002,l_gzgf003
           #IF l_gzgf002_str.getIndexOf("_c",0)> 1 THEN 
               LET l_gzgf002_str = l_gzgf002     
               LET l_gzgf002_str = cl_replace_str(l_gzgf002_str,"_c","_s")
               LET l_gzgf002_u = l_gzgf002_str
               LET l_gzgf003_u = "x"
               LET l_upd = "Y"
               LET l_cnt1 = 0
               #找存在否
               SELECT COUNT(1) INTO l_cnt1 FROM gzgf_t 
                WHERE gzgf001 = l_gzgf001
                  AND gzgf002 = l_gzgf002_u
                  AND gzgf003 = l_gzgf003_u
               IF l_cnt1 > 0 THEN 
                  LET l_upd ="N"             
               END IF   
               LET l_gzgf[l_cnt].gzgf001 = l_gzgf001
               LET l_gzgf[l_cnt].gzgf002 = l_gzgf002
               LET l_gzgf[l_cnt].gzgf003 = l_gzgf003
               LET l_gzgf[l_cnt].gzgf002_u = l_gzgf002_u
               LET l_gzgf[l_cnt].gzgf003_u = l_gzgf003_u
               LET l_gzgf[l_cnt].upd = l_upd
               LET l_cnt = l_cnt + 1
            #END IF 
    END FOREACH 
    CALL l_gzgf.deleteElement(l_cnt)
    FOR i = 1 TO l_gzgf.getLength()
        IF l_gzgf[i].upd = "Y" THEN 
           UPDATE gzgf_t 
              SET gzgf002 = l_gzgf[i].gzgf002_u,gzgf003 = l_gzgf[i].gzgf003_u
                WHERE gzgf001 = l_gzgf[i].gzgf001
                  AND gzgf002 = l_gzgf[i].gzgf002
                  AND gzgf003 = l_gzgf[i].gzgf003 
          #DISPLAY "sqlca code",sqlca.sqlcode        
          LET l_msg = "1st gzgf001:",l_gzgf[i].gzgf001," old gzgf002:",l_gzgf[i].gzgf002," new gzgf002:",l_gzgf[i].gzgf002_u," old gzgf003:",l_gzgf[i].gzgf003," new gzgf003:",l_gzgf[i].gzgf003_u
          DISPLAY "Y :",l_msg
          CALL lchannel_write.write(l_msg)        
        END IF 
    END FOR
    FOR i = 1 TO l_gzgf.getLength()
        IF l_gzgf[i].upd = "N" THEN 
           #找最大值
           SELECT MAX(gzgf002) INTO l_gzgf002_max FROM gzgf_t 
            WHERE gzgf001 = l_gzgf[i].gzgf001
              AND gzgf003 = l_gzgf[l_cnt].gzgf003_u
              LET l_sub_str = l_gzgf002_max
           LET l_gzgf002_seq = l_sub_str.subString(l_sub_str.getIndexOf("_c",1)+1,l_sub_str.getLength())
           LET l_gzgf002_seq = l_gzgf002_seq + 1
           LET l_sub_str_u = l_gzgf[i].gzgf003_u
           LET l_sub_str_u = l_sub_str_u.subString(1,l_sub_str_u.getIndexOf("_c",1)+1),l_gzgf002_seq USING "00"
           LET l_gzgf[i].gzgf003_u = l_sub_str_u
           
           UPDATE gzgf_t 
              SET gzgf002 = l_gzgf[i].gzgf002_u,gzgf003 = l_gzgf[i].gzgf003_u
                WHERE gzgf001 = l_gzgf[i].gzgf001
                  AND gzgf002 = l_gzgf[i].gzgf002
                  AND gzgf003 = l_gzgf[i].gzgf003
              #DISPLAY "N sqlca code",sqlca.sqlcode    
              LET l_msg = "2nd gzgf001:",l_gzgf[i].gzgf001," old gzgf002:",l_gzgf[i].gzgf002," new gzgf002:",l_gzgf[i].gzgf002_u," old gzgf003:",l_gzgf[i].gzgf003," new gzgf003:",l_gzgf[i].gzgf003_u
              DISPLAY "N :",l_msg
              CALL lchannel_write.write(l_msg)         
        END IF 
    END FOR   
    
    DISPLAY "END TIME:",cl_get_current()
    DISPLAY "更新多樣板gzgf002與gzgf003資料 LOG檔位於...", ls_code_filename 
END FUNCTION 
#161110-00037 add -(e)

#170111-00066#1 add- (s)
PUBLIC FUNCTION sadzp188_upd_dzgb011013015()
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_cust_flag      LIKE gzde_t.gzde008   #客製
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_i              INTEGER
   DEFINE l_sql            STRING 
   DEFINE l_log_file       STRING
   DEFINE l_log_file2      STRING
   DEFINE l_dzge001        LIKE dzge_t.dzge001
   DEFINE l_dzge003        LIKE dzge_t.dzge003
   DEFINE ls_err_msg       STRING 
   DEFINE l_ver            LIKE dzga_t.dzga002
   DEFINE l_code_ide       LIKE type_t.chr1 
   DEFINE p_dzgb005      LIKE dzgb_t.dzgb005  
   DEFINE p_dzgb011      LIKE dzgb_t.dzgb011  
   DEFINE p_dzgb012      LIKE dzgb_t.dzgb012 
   DEFINE p_dzgb013      LIKE dzgb_t.dzgb013  
   DEFINE p_dzgb014      LIKE dzgb_t.dzgb014  
   DEFINE p_dzgb015      LIKE dzgb_t.dzgb015  
   DEFINE p_dzgb016      LIKE dzgb_t.dzgb016
   DEFINE p_dzgb017      LIKE dzgb_t.dzgb017  
   DEFINE ls_dzgb013     LIKE dzgb_t.dzgb013  
   DEFINE ls_dzgb015     LIKE dzgb_t.dzgb015   
   DEFINE ls_wc          LIKE dzgb_t.dzgb011  
   DEFINE p_dzgb003      LIKE dzgb_t.dzgb003 
   DEFINE l_dzge001_t    LIKE dzge_t.dzge001 
   DEFINE l_dzgb011_str  STRING 
   DEFINE l_ver_pre      LIKE dzga_t.dzga002 
   
   LET r_success = FALSE

   LET l_log_file = os.Path.join(FGL_GETENV("TEMPDIR"), "upd_dzgb011013.log")
   LET g_log_ch = base.Channel.create()
   LET g_log_ch_err = base.Channel.create()
   CALL g_log_ch.openFile(l_log_file, "w")    
   CALL g_log_ch_err.openFile(l_log_file2, "w")    

   DISPLAY "up start .......",cl_get_current() 

      DECLARE dzgb_data1 SCROLL CURSOR FOR  
      SELECT dzgb003,dzgb005,dzgb011,dzgb012,dzgb013,dzgb014,dzgb015,dzgb016,dzgb017           
        FROM dzgb_t
       WHERE dzgb001 = ? AND dzgb002 = ?
         AND dzgb019 = ?                 #161031-00071#1 add
   


   LET l_sql = "SELECT gzde001,gzde003 ",          
               "  FROM gzde_t ",
               " WHERE gzdestus = 'Y' AND (gzde003 ='X' OR gzde003='G')",                            
               #"   AND gzde001='abxr001_g01'", 
               " ORDER BY gzde001 "

   LET l_dzge001_t=""
   PREPARE adzp178_get_comp1_pr FROM l_sql
   DECLARE adzp178_get_comp1_cs CURSOR FOR adzp178_get_comp1_pr
   FOREACH adzp178_get_comp1_cs INTO l_dzge001,l_dzge003
      CALL cl_adz_get_code_curr_revision(l_dzge001,NULL, l_dzge003) RETURNING l_ver,l_code_ide,ls_err_msg   
      DISPLAY "rep code:",l_dzge001
      
      FOREACH dzgb_data1 USING l_dzge001,l_ver,l_code_ide INTO p_dzgb003,p_dzgb005,p_dzgb011,p_dzgb012,p_dzgb013,p_dzgb014,p_dzgb015,p_dzgb016,p_dzgb017
         LET l_dzgb011_str = p_dzgb011     
         IF cl_null(p_dzgb013) AND cl_null(p_dzgb015) AND l_dzgb011_str.getIndexOf("ON  AND",1) > 0 THEN          
            LET l_ver_pre = l_ver -1 
            IF l_ver_pre > 0 THEN 
                SELECT dzgb013,dzgb015 INTO ls_dzgb013, ls_dzgb015
                  FROM dzgb_t
                 WHERE dzgb001 = l_dzge001 AND dzgb002 = l_ver_pre 
                   AND dzgb003 = p_dzgb003 AND dzgb019 = l_code_ide  
                IF cl_null(p_dzgb013) AND cl_null(p_dzgb015) THEN           
                    SELECT dzai007,dzai009 
                      INTO ls_dzgb013,ls_dzgb015
                      FROM dzai_t
                     WHERE dzai005 = p_dzgb012 and dzai011 = p_dzgb016
                     
                END IF 
                IF l_dzge001 <> l_dzge001_t THEN             
                    LET g_msg = l_dzge001," 已更新 "
                    CALL g_log_ch.writeLine(g_msg)
                    DISPLAY g_msg
                    LET l_dzge001_t = l_dzge001
                END IF                 
                LET ls_wc = adzp178_combine_ref_join_wc("", p_dzgb005, ls_dzgb013, "01", "Y", p_dzgb014, ls_dzgb015)
                UPDATE dzgb_t 
                   SET dzgb011 = ls_wc, dzgb013 = ls_dzgb013, dzgb015 = ls_dzgb015                                  
                 WHERE dzgb001 = l_dzge001 AND dzgb002 = l_ver  AND dzgb003 = p_dzgb003 AND dzgb019 = l_code_ide
            ELSE 
                    LET ls_dzgb013 = ''
                    LET ls_dzgb015 = ''
                    SELECT dzai007,dzai009 
                      INTO ls_dzgb013,ls_dzgb015
                      FROM dzai_t
                     WHERE dzai005 = p_dzgb012 and dzai011 = p_dzgb016
                     
                     UPDATE dzgb_t 
                       SET dzgb011 = ls_wc, dzgb013 = ls_dzgb013, dzgb015 = ls_dzgb015                                  
                     WHERE dzgb001 = l_dzge001 AND dzgb002 = l_ver  AND dzgb003 = p_dzgb003 AND dzgb019 = l_code_ide
                     LET ls_wc = adzp178_combine_ref_join_wc("", p_dzgb005, ls_dzgb013, "01", "Y", p_dzgb014, ls_dzgb015)
                    IF cl_null(ls_dzgb013) AND cl_null(ls_dzgb015) THEN 
                        LET g_msg = l_dzge001," 空值未更新 "
                        CALL g_log_ch.writeLine(g_msg)
                        #DISPLAY g_msg
                        LET l_dzge001_t = l_dzge001               
                    END IF 
            END IF 
         END IF 
      END FOREACH 
   END FOREACH 
   CLOSE adzp178_get_comp1_cs
   FREE adzp178_get_comp1_cs
   FREE adzp178_get_comp1_pr

   DISPLAY "up end .......",cl_get_current() 

END FUNCTION 

#170111-00066#1 add- (e)

PUBLIC FUNCTION sadzp178_count_field()
    DEFINE lchannel_read           base.Channel
    DEFINE lchannel_write          base.Channel
    DEFINE l_4gl_main_cnt          INTEGER 
    DEFINE l_4gl_sub_cnt           INTEGER 
    DEFINE l_gzgg_main_cnt         INTEGER 
    DEFINE l_gzgg_sub_cnt          INTEGER 
    DEFINE ls_4glpath              STRING
    DEFINE l_prog_type             LIKE gzde_t.gzde001     #程式類型  
    DEFINE l_module                LIKE gzde_t.gzde002     #模組     
    DEFINE l_spec_ver              LIKE dzga_t.dzga002     #客製版次 
    DEFINE ls_readline             STRING 
    DEFINE ls_text                 STRING
    DEFINE l_cnt                   INTEGER
    DEFINE l_field_cnt             INTEGER 
    DEFINE l_msg                   STRING 
    DEFINE ls_code_filename        STRING     
         
    
   
    LET lchannel_read = base.Channel.create()
    LET lchannel_write = base.Channel.create()

    CALL lchannel_read.setDelimiter("")
    CALL lchannel_write.setDelimiter("")


   #產出程式路徑
   LET ls_code_filename = os.Path.join(FGL_GETENV("TEMPDIR"), "xgcntfield.log")
   
   #先行移除tgl
   IF os.Path.delete(ls_code_filename) THEN
      #DISPLAY "刪除舊檔案:",ls_code_filename                   #170123-00046#1 mark
      DISPLAY cl_getmsg("adz-01164",g_lang),ls_code_filename   #170123-00046#1 add
   END IF
   
   #判斷是否砍除成功
   IF NOT os.Path.exists(ls_code_filename) THEN
      #DISPLAY "舊檔案刪除成功:",ls_code_filename                  #170123-00046#1 mark
      DISPLAY cl_getmsg("adz-01165",g_lang),ls_code_filename   #170123-00046#1 add
   ELSE
      #DISPLAY "Error:舊檔案刪除失敗:",ls_code_filename           #170123-00046#1 mark
      DISPLAY cl_getmsg("adz-01144",g_lang),ls_code_filename   #170123-00046#1 add
      EXIT PROGRAM
   END IF
   
   DISPLAY "產生檔位置:",ls_code_filename
   CALL lchannel_write.openFile( ls_code_filename, "w" )

    
    DISPLAY "START TIME:",cl_get_current()

    LET ls_4glpath = FGL_GETENV("ERP")
    DECLARE adzp178_prog SCROLL CURSOR FOR
    SELECT gzde001,gzde002 FROM gzde_t 
     WHERE gzdestus='Y' AND gzde003='X' 
    FOREACH adzp178_prog INTO l_prog_type, l_module
        IF NOT cl_null(l_prog_type) AND NOT cl_null(l_module) THEN 
           DISPLAY "報表元件:",l_prog_type
           LET l_cnt = 1
           LET l_4gl_main_cnt = 0
           LET l_4gl_sub_cnt = 0
           LET l_gzgg_main_cnt = 0 
           LET l_gzgg_sub_cnt = 0
           LET ls_4glpath = FGL_GETENV(l_module)
           LET ls_4glpath = os.Path.join(ls_4glpath,"4gl/")
           LET ls_4glpath = ls_4glpath,l_prog_type,".4gl"
           IF os.Path.exists(ls_4glpath) THEN
              CALL lchannel_read.openFile( ls_4glpath CLIPPED, "r" )
               #讀取及轉換
               WHILE TRUE
               
                  LET ls_text = ""
                  LET ls_readline = lchannel_read.readLine()
 

                  IF lchannel_read.isEof() THEN
                     EXIT WHILE
                  END IF

                  #找create template段
                  IF ls_readline.getIndexOf(" LET g_sql = ",1) > 0 AND ls_readline.getIndexOf("INSERT INTO",1) = 0 AND ls_readline.getIndexOf("CLIPPED",1) = 0 AND ls_readline.getIndexOf("cl_sql_add_mask",1) = 0 THEN 
                     CALL adzp178_cnt_4gl_field(ls_readline,l_cnt) RETURNING l_field_cnt
                     IF l_cnt = 1 THEN
                        LET l_4gl_main_cnt = l_field_cnt 
                     ELSE
                        LET l_4gl_sub_cnt = l_field_cnt
                        EXIT WHILE  
                     END IF 
                     LET l_cnt = l_cnt + 1
                  END IF 
                  

               END WHILE 
               CALL lchannel_read.close()              
           END IF 
           CALL adzp178_gzgg_cnt(l_prog_type) RETURNING l_gzgg_main_cnt,l_gzgg_sub_cnt
          IF l_4gl_main_cnt <> l_gzgg_main_cnt THEN         
             LET l_msg = l_prog_type,"-4gl 主報表欄位數:",l_4gl_main_cnt, " azzi300主報表欄位數:",l_gzgg_main_cnt
             CALL lchannel_write.write(l_msg)
          END IF
          IF l_4gl_sub_cnt < l_gzgg_sub_cnt THEN
             LET l_msg = l_prog_type,"-4gl 子報表欄位數:",l_4gl_sub_cnt, " azzi300子報表欄位數:",l_gzgg_sub_cnt
             CALL lchannel_write.write(l_msg)
          END IF


        END IF        
    END FOREACH 
    DISPLAY "END TIME:",cl_get_current()
END FUNCTION 

PUBLIC FUNCTION adzp178_gzgg_cnt(p_prog)
   DEFINE p_prog       LIKE gzde_t.gzde001
   DEFINE l_main_cnt   INTEGER 
   DEFINE l_sub_cnt    INTEGER 

   SELECT COUNT(gzgg001) INTO l_main_cnt FROM gzgg_t 
    WHERE gzgg000 = p_prog AND gzgg002 = g_lang AND (gzgg017 IS NULL OR gzgg017 = 'Y' OR gzgg017 = 'Y' OR gzgg017 = 'N')
    
   SELECT COUNT(gzgg001) INTO l_sub_cnt FROM gzgg_t 
    WHERE gzgg000 = p_prog AND gzgg002 = g_lang AND gzgg017 = '2'
    
   RETURN l_main_cnt,l_sub_cnt   

END FUNCTION 


PUBLIC FUNCTION adzp178_cnt_4gl_field(ls_readline,p_cnt) 
   DEFINE  ls_readline         STRING 
   DEFINE  p_cnt               INTEGER    #主報表:1/子報表:2
   DEFINE  ls_token             base.StringTokenizer
   DEFINE  ls_token_cnt         LIKE type_t.num5

   
   IF NOT cl_null(ls_readline) THEN 
       LET ls_token = base.StringTokenizer.create(ls_readline.trim(), ',')
       LET ls_token_cnt = ls_token.countTokens()
   END IF    

   RETURN ls_token_cnt 
     
END FUNCTION  


PUBLIC FUNCTION sadzp188_upd_4rp(p_rep_code,p_cust_flag)
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_cust_flag      LIKE gzde_t.gzde008   #客製
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_i              INTEGER
   DEFINE l_sql            STRING 
   DEFINE l_log_file       STRING
   DEFINE l_log_file2      STRING
   
   LET r_success = FALSE

   LET l_log_file = os.Path.join(FGL_GETENV("TEMPDIR"), "upd_4rp_label.log")
   LET g_log_ch = base.Channel.create()
   LET g_log_ch_err = base.Channel.create()
   CALL g_log_ch.openFile(l_log_file, "w")    
   CALL g_log_ch_err.openFile(l_log_file2, "w")    
   
   LET l_sql = "SELECT gzgd000,gzgd001,gzgd002,gzgd003,gzgd004,",
               "       gzgd005,gzgd007 ",
               "  FROM gzgd_t ",
               " WHERE gzgdstus = 'Y' "

   #單支報表元件            
   IF NOT cl_null(p_rep_code) THEN
      LET l_sql = l_sql, "  AND gzgd001 = '",p_rep_code CLIPPED,"' "
   END IF
   #客製標示
   IF NOT cl_null(p_cust_flag) THEN
      LET l_sql = l_sql, "  AND gzgd003 = '",p_cust_flag CLIPPED,"' "
   END IF
   
   LET l_sql = l_sql, " ORDER BY gzgd001,gzgd002,gzgd003,gzgd007 "

   PREPARE sadzp188_upd_4rp_pr FROM l_sql
   DECLARE sadzp188_upd_4rp_cs CURSOR FOR sadzp188_upd_4rp_pr
   
   #取得語言列表
   CALL cl_rpt_lang_list() RETURNING g_langs 

   FOR l_i = 1 TO g_langs.getLength()
      CALL sadzp188_upd_4rp_trans(p_rep_code,p_cust_flag,g_langs[l_i])
   END FOR

   CLOSE sadzp188_upd_4rp_cs
   FREE sadzp188_upd_4rp_cs
   FREE sadzp188_upd_4rp_pr
   
   RETURN r_success 
END FUNCTION


PRIVATE FUNCTION sadzp188_upd_4rp_trans(p_rep_code,p_cust_flag,p_lang)
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_cust_flag      LIKE gzde_t.gzde008   #客製
   DEFINE p_lang           LIKE gzzy_t.gzzy001
   DEFINE l_rootnode       om.DomNode
   DEFINE l_doc            om.DomDocument
   DEFINE l_4rpdir         STRING
   DEFINE l_4rpdir_w       STRING 
   DEFINE l_4rpfile        STRING
   DEFINE l_4rpfile_w      STRING
   DEFINE l_gzgd      RECORD
          gzgd000          LIKE gzgd_t.gzgd000,   
          gzgd001          LIKE gzgd_t.gzgd001,
          gzgd002          LIKE gzgd_t.gzgd002,
          gzgd003          LIKE gzgd_t.gzgd003,
          gzgd004          LIKE gzgd_t.gzgd004,
          gzgd005          LIKE gzgd_t.gzgd005,
          gzgd007          LIKE gzgd_t.gzgd007          
                      END RECORD
   DEFINE l_result         BOOLEAN                   

   INITIALIZE l_gzgd TO NULL

   FOREACH sadzp188_upd_4rp_cs INTO l_gzgd.gzgd000,l_gzgd.gzgd001,l_gzgd.gzgd002,l_gzgd.gzgd003,
                                    l_gzgd.gzgd004,l_gzgd.gzgd005,l_gzgd.gzgd007
      LET g_gzgd007 = l_gzgd.gzgd007
      LET l_4rpdir = cl_rpt_get_4rpdir(l_gzgd.gzgd001,l_gzgd.gzgd003,p_lang,"L")
      LET l_4rpdir_w = cl_rpt_get_4rpdir(l_gzgd.gzgd001,l_gzgd.gzgd003,p_lang,"M")
      IF os.Path.exists(l_4rpdir) THEN
         LET l_4rpfile = os.Path.join(l_4rpdir,l_gzgd.gzgd007 CLIPPED||".4rp")
         LET g_4rpfile = l_4rpfile
         
         IF os.Path.exists(l_4rpfile) THEN
            LET l_doc = om.DomDocument.createFromXmlFile(l_4rpfile)
            IF l_doc IS NOT NULL THEN
               LET l_rootnode = l_doc.getDocumentElement()
               IF l_rootnode IS NOT NULL THEN
                  CALL sadzp188_upd_4rp_label(l_gzgd.gzgd000,l_rootnode,p_lang,"WORDWRAPBOX")
                  CALL sadzp188_upd_4rp_label(l_gzgd.gzgd000,l_rootnode,p_lang,"WORDBOX")
                  CALL l_rootnode.writeXml(l_4rpfile)  #更新xml
                  
                  LET l_4rpfile_w = os.Path.join(l_4rpdir_w,l_gzgd.gzgd007 CLIPPED||".4rp")                             
                  CALL os.Path.copy(l_4rpfile, l_4rpfile_w) RETURNING l_result 
                  CALL os.Path.chrwx(l_4rpfile_w,511) RETURNING l_result     
                  LET g_msg = l_4rpfile_w," 已更新 "
                  CALL g_log_ch.writeLine(g_msg)
               END IF
            END IF
         END IF
      END IF      
   END FOREACH
END FUNCTION

#根據語言別置換欄位說明(_Label)
PRIVATE FUNCTION sadzp188_upd_4rp_label(p_gzgd000,p_rootnode,p_lang,p_tagname)
   DEFINE p_gzgd000       LIKE gzgd_t.gzgd000
   DEFINE p_rootnode      om.DomNode
   DEFINE p_lang          LIKE gzzy_t.gzzy001
   DEFINE p_tagname       STRING
   DEFINE l_nodes         om.NodeList
   DEFINE l_i             INTEGER
   DEFINE l_curnode       om.DomNode
   DEFINE l_curname       STRING
   DEFINE l_gzge003       LIKE gzge_t.gzge003
   DEFINE l_label_text    STRING
   DEFINE l_flag          LIKE type_t.chr1    #欄位說明是否有冒號
   DEFINE l_fieldname     STRING
   DEFINE l_trans         STRING
   
   LET l_nodes = p_rootnode.selectByTagName(p_tagname)
   FOR l_i = 1 TO l_nodes.getLength()
      LET l_label_text = ""
      LET l_curnode=l_nodes.item(l_i) 
      LET l_curname=l_curnode.getAttribute("name")
      LET l_label_text=l_curnode.getAttribute("text")

      IF l_curname.getIndexOf("_Label",1) > 0 THEN
         #先移除欄位說明的":"     
         IF l_label_text.getIndexOf(":",1) > 0 THEN
            LET l_flag = "Y"
            LET l_label_text = cl_replace_str(l_label_text,":","")
         ELSE
            LET l_flag = "N"
         END IF
 
         LET l_fieldname = l_curname
         LET l_fieldname = l_fieldname.subString(1,l_fieldname.getIndexOf("_Label",1)-1)
         IF l_fieldname.getIndexOf("sr",1) > 0 THEN
            LET l_fieldname = l_fieldname.subString(l_fieldname.getIndexOf(".",1)+1,l_fieldname.getLength())
         END IF 
         LET l_fieldname = cl_replace_str(l_fieldname,"PH","")
         LET l_fieldname = cl_replace_str(l_fieldname,"RH","")        
         LET l_fieldname = cl_replace_str(l_fieldname,"PF","")
         LET l_fieldname = cl_replace_str(l_fieldname,"RF","")

         CALL sadzp188_gen4rp_get_field_label(l_fieldname,p_lang,p_gzgd000) RETURNING l_gzge003 #取出欄位說明
         IF cl_null(l_gzge003) THEN LET l_gzge003 = l_label_text END IF  #取不到就維持原本說明

         IF NOT cl_null(l_gzge003) THEN
            LET l_trans = l_gzge003
            IF l_flag = "Y" THEN            
               LET l_trans = l_trans,":"
            END IF 
            CALL l_curnode.removeAttribute("text")
            CALL l_curnode.setAttribute("text",l_trans)            
         ELSE 
            LET g_msg = ""
            CALL l_curnode.removeAttribute("text")
            CALL l_curnode.setAttribute("text","")                
            LET g_msg = g_4rpfile," ",l_curname," 轉換失敗"
            CALL g_log_ch_err.writeLine(g_msg)
         END IF
      END IF
   END FOR
END FUNCTION



PUBLIC FUNCTION sadzp188_upd_dzgb()
   DEFINE p_rep_code       LIKE gzgd_t.gzgd001   #報表元件代號
   DEFINE p_cust_flag      LIKE gzde_t.gzde008   #客製
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_i              INTEGER
   DEFINE l_sql            STRING 
   DEFINE l_log_file       STRING
   DEFINE l_log_file2      STRING
   DEFINE l_dzge001        LIKE dzge_t.dzge001
   DEFINE l_dzge003        LIKE dzge_t.dzge003
   DEFINE ls_err_msg       STRING 
   DEFINE l_ver            LIKE dzga_t.dzga002
   DEFINE l_code_ide       LIKE type_t.chr1 
   DEFINE p_dzgb005      LIKE dzgb_t.dzgb005  
   DEFINE p_dzgb011      LIKE dzgb_t.dzgb011  
   DEFINE p_dzgb013      LIKE dzgb_t.dzgb013  
   DEFINE p_dzgb014      LIKE dzgb_t.dzgb014  
   DEFINE p_dzgb015      LIKE dzgb_t.dzgb015  
   DEFINE p_dzgb017      LIKE dzgb_t.dzgb017  
   DEFINE ls_dzgb013     LIKE dzgb_t.dzgb013  
   DEFINE ls_dzgb015     LIKE dzgb_t.dzgb015   
   DEFINE ls_wc          LIKE dzgb_t.dzgb011  
   DEFINE p_dzgb003      LIKE dzgb_t.dzgb003 
   DEFINE l_dzge001_t    LIKE dzge_t.dzge001 

    
   
   LET r_success = FALSE

   LET l_log_file = os.Path.join(FGL_GETENV("TEMPDIR"), "upd_dzgb.log")
   LET g_log_ch = base.Channel.create()
   LET g_log_ch_err = base.Channel.create()
   CALL g_log_ch.openFile(l_log_file, "w")    
   CALL g_log_ch_err.openFile(l_log_file2, "w")    

   DISPLAY "up start .......",cl_get_current() 

      DECLARE dzgb_data SCROLL CURSOR FOR  
      SELECT dzgb003,dzgb005,dzgb011,dzgb013,dzgb014,dzgb015,dzgb017           
        FROM dzgb_t
       WHERE dzgb001 = ? AND dzgb002 = ?
         AND dzgb019 = ?                 #161031-00071#1 add
   

   
   LET l_sql = "SELECT gzde001,gzde003 ",          
               "  FROM gzde_t ",
               " WHERE gzdestus = 'Y' AND (gzde003 ='X' OR gzde003='G')",                            #161031-00071#1  add
               #" WHERE gzdestus = 'Y' AND (gzde003 ='X' OR gzde003='G') AND gzde001='apmr440_g01'", #161031-00071#1 mark
               #" ORDER BY gzde001 "
               " ORDER BY gzde001 "
               #"   AND (gzde001='ainr302_g01' or gzde001='asfr335_g01' or gzde001='asfr335_g01')"
   LET l_dzge001_t=""
   PREPARE adzp178_get_comp_pr FROM l_sql
   DECLARE adzp178_get_comp_cs CURSOR FOR adzp178_get_comp_pr
   FOREACH adzp178_get_comp_cs INTO l_dzge001,l_dzge003
      CALL cl_adz_get_code_curr_revision(l_dzge001,NULL, l_dzge003) RETURNING l_ver,l_code_ide,ls_err_msg   
      DISPLAY "rep code:",l_dzge001
      #FOREACH dzgb_data USING l_dzge001,l_ver INTO p_dzgb003,p_dzgb005,p_dzgb011,p_dzgb013,p_dzgb014,p_dzgb015,p_dzgb017    #161031-00071#1 mark
      FOREACH dzgb_data USING l_dzge001,l_ver,l_code_ide INTO p_dzgb003,p_dzgb005,p_dzgb011,p_dzgb013,p_dzgb014,p_dzgb015,p_dzgb017     #161031-00071#1 add
         IF p_dzgb013 IS NOT NULL  AND p_dzgb015 IS NOT NULL THEN
           
          CALL sadzp188_get_jointable_key(p_dzgb005,p_dzgb013,p_dzgb014,p_dzgb015) RETURNING ls_dzgb013,ls_dzgb015
          LET ls_wc = adzp178_combine_ref_join_wc("", p_dzgb005, ls_dzgb013, "01", "Y", p_dzgb014, ls_dzgb015)
          #LET ls_wc = adzp178_combine_ref_join_wc("", p_dzgb005, p_dzgb013, "01", "Y", p_dzgb014, p_dzgb015)
          IF l_dzge001 <> l_dzge001_t THEN             
              LET g_msg = l_dzge001," 已更新 "
              CALL g_log_ch.writeLine(g_msg)
              DISPLAY g_msg
              LET l_dzge001_t = l_dzge001
          END IF 
          UPDATE dzgb_t 
             #SET dzgb001 = g_dzga_m.dzga001 , dzgb002 = g_dzga_m.dzga002, dzgb019 = g_code_ide, #161031-00071#1 mark
             #     dzgb011 = ls_wc, dzgb013 = ls_dzgb013, dzgb015 = ls_dzgb015                   #161031-00071#1 mark 
           #WHERE dzgb001 = l_dzge001 AND dzgb002 = l_ver AND dzgb003 = l_dzge001                #161031-00071#1 mark
             #SET dzgb011 = ls_wc, dzgb013 = p_dzgb013, dzgb015 = p_dzgb015                                 #161031-00071#1 add  #170111 mark
             SET dzgb011 = ls_wc, dzgb013 = p_dzgb013, dzgb015 = p_dzgb015                                  #161031-00071#1 add  #170111 add
           WHERE dzgb001 = l_dzge001 AND dzgb002 = l_ver  AND dzgb003 = p_dzgb003 AND dzgb019 = l_code_ide    #161031-00071#1 add
         END IF 
      END FOREACH 
   END FOREACH 
   CLOSE adzp178_get_comp_cs
   FREE adzp178_get_comp_cs
   FREE adzp178_get_comp_pr

   DISPLAY "up end .......",cl_get_current() 

END FUNCTION


FUNCTION adzp178_combine_ref_join_wc(ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010)
   DEFINE ps_dzgb004, ps_dzgb005, ps_dzgb006, ps_dzgb007, ps_dzgb008, ps_dzgb009, ps_dzgb010   STRING
   DEFINE ls_str      STRING
   DEFINE l_token1    base.StringTokenizer 
   DEFINE l_token2    base.StringTokenizer
   DEFINE ls_next1    STRING
   DEFINE ls_next2    STRING
   DEFINE l_token1_cnt LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_have       LIKE type_t.num5
   DEFINE ls_dzgb010   LIKE dzgb_t.dzgb010
   DEFINE l_suffix_str STRING 


   #不確定組合規則, 先暫時用分鏡範例來組
   IF ps_dzgb004 = "Y" THEN
      LET ls_str = ps_dzgb009, " RIGHT OUTER JOIN ", ps_dzgb005, " ON "
   END IF   
   IF ps_dzgb008 = "Y" THEN
      LET ls_str = ps_dzgb005 , " LEFT OUTER JOIN ", ps_dzgb009, " ON "
   END IF
   
   LET l_token1 = base.StringTokenizer.create(ps_dzgb006,",")
   LET l_token2 = base.StringTokenizer.create(ps_dzgb010,",")
   LET l_token1_cnt = l_token1.countTokens()
   LET l_cnt = 1
   WHILE l_token1.hasMoreTokens()
         LET ls_next1 = l_token1.nextToken()
         LET ls_next2 = l_token2.nextToken() 
         #判斷欄位存在，組成inbb_t.inbb001，若是傳進來的值是2，就不用組成inbb_t.2
         LET ls_dzgb010 = ls_next1
         LET l_have = 0
         SELECT COUNT(*) INTO l_have FROM gztz_t WHERE gztz002 = ls_dzgb010 
            AND gztz001 NOT LIKE '%rebuil' #151208-00023#1 add
            ##161227-00056#1 add -(s)
            AND gztz001 NOT LIKE 'erp%'   
            AND gztz001 NOT LIKE 'all%'
            AND gztz001 NOT LIKE 'b2b%'
            AND gztz001 NOT LIKE 'pos%'
            AND gztz001 NOT LIKE 'dsm%'
            ##161227-00056#1 add -(e)          
         IF l_cnt < l_token1_cnt THEN 
            IF l_have > 0 THEN 
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", "' '"  ," AND "
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", ps_dzgb005, ".", ls_next1  ," AND "
               END IF 
            ELSE
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ",  "' '"  ," AND "
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ",  ls_next1  ," AND "
               END IF 
            END IF 
         ELSE 
            IF l_have > 0 THEN
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", "' '" 
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", ps_dzgb005, ".", ls_next1
               END IF 
            ELSE
               IF ls_next1 = "' '" OR ls_next1 = "''"  THEN
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ",  "' '"  ," AND "
               ELSE 
                  LET ls_str = ls_str, ps_dzgb009, ".", ls_next2 ," = ", ls_next1
               END IF 
            END IF 
         END IF 
         LET l_cnt = l_cnt + 1
   END WHILE 

   ##140318 add 判斷主檔與reference table是否有ent'site'ld(ent.site.legal), 若有要加上
   CALL adzp178_chk_table_suffix(ps_dzgb009,ps_dzgb005,ls_str) RETURNING  l_suffix_str
   IF NOT cl_null(l_suffix_str) THEN
      LET ls_str = ls_str , " AND ",l_suffix_str 
   END IF 
   
   RETURN ls_str

END FUNCTION


FUNCTION adzp178_chk_table_suffix(p_dzgb005,p_dzgb009,p_str)
   DEFINE p_dzgb005      LIKE dzgb_t.dzgb005
   DEFINE p_dzgb009      LIKE dzgb_t.dzgb009
   DEFINE p_str          STRING 
   DEFINE ls_m_ent       STRING
   DEFINE ls_m_site      STRING 
   DEFINE ls_m_ld        STRING
   DEFINE ls_d_ent       STRING
   DEFINE ls_d_site      STRING 
   DEFINE ls_d_ld        STRING
   DEFINE l_m_table      STRING
   DEFINE l_d_table      STRING
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_gztz002      LIKE gztz_t.gztz002
   DEFINE l_suffix       STRING 
   DEFINE l_dzeb002      LIKE dzeb_t.dzeb002
   DEFINE l_dzeb001      LIKE dzeb_t.dzeb001


   ##主table
   LET l_m_table = p_dzgb005
   LET ls_m_ent = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ent"
   ##140512 只加ent, 其餘不加-(s)
   #LET ls_m_site = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"site"
   #LET ls_m_ld = l_m_table.subString(1,l_m_table.getIndexOf("_",1)-1),"ld"
   ##140512 只加ent, 其餘不加-(e) 
   #reference table
   LET l_d_table = p_dzgb009
   LET ls_d_ent = l_d_table.subString(1,l_d_table.getIndexOf("_",1)-1),"ent"   
   ##140512 只加ent, 其餘不加-(s)
   #LET ls_d_site = l_d_table.subString(1,l_d_table.getIndexOf("_",1)-1),"site"
   #LET ls_d_ld = l_d_table.subString(1,l_d_table.getIndexOf("_",1)-1),"ld"
   ##140512 只加ent, 其餘不加-(e)

   IF p_str.getIndexOf("ent",1) = 0 THEN 
       IF adzp178_table_field_exist(l_m_table,ls_m_ent) THEN
          IF adzp178_table_field_exist(l_d_table,ls_d_ent) THEN
             LET l_suffix = l_suffix , l_m_table,".",ls_m_ent," = ",l_d_table,".",ls_d_ent
          END IF  
       END IF 
   END IF 
   ##140512 只加ent, 其餘不加-(s)
   #IF p_str.getIndexOf("site",1) = 0 THEN    
       #IF adzp188_table_field_exist(l_m_table,ls_m_site) THEN
          #IF adzp188_table_field_exist(l_d_table,ls_d_site) THEN
             #IF NOT cl_null(l_suffix) THEN
                #LET l_suffix = l_suffix ," AND "
             #END IF  
             #LET l_suffix = l_suffix , l_m_table,".",ls_m_site," = ",l_d_table,".",ls_d_site         
          #END IF  
       #END IF 
   #END IF
   #IF p_str.getIndexOf("ld",1) = 0 THEN   
       #IF adzp188_table_field_exist(l_m_table,ls_m_ld) THEN
          #IF adzp188_table_field_exist(l_d_table,ls_d_ld) THEN
             #IF NOT cl_null(l_suffix) THEN
                #LET l_suffix = l_suffix ," AND "
             #END IF  
             #LET l_suffix = l_suffix , l_m_table,".",ls_m_ld," = ",l_d_table,".",ls_d_ld
          #END IF  
       #END IF 
   #END IF
   ##140512 只加ent, 其餘不加-(e)
   
  ##reference table若為語言檔，要抓出語言別欄位
  LET l_dzeb001 = p_dzgb005 
  LET l_dzeb002 =''
  SELECT dzeb002 INTO l_dzeb002 FROM dzeb_t 
    LEFT JOIN dzea_t ON dzea004 ='L' and dzea001 = dzeb001
   WHERE dzeb006 ='C800' and dzeb001 = l_dzeb001
  IF NOT cl_null(l_dzeb002)  THEN 
     IF NOT cl_null(l_suffix) THEN
        LET l_suffix = l_suffix ," AND "
     END IF   
     LET l_suffix = l_suffix , l_dzeb001,".",l_dzeb002," = g_dlang"
  END IF  
   
   RETURN l_suffix
END FUNCTION 


FUNCTION adzp178_table_field_exist(ps_table,ps_field)
   DEFINE ps_table       LIKE gztz_t.gztz001
   DEFINE ps_field       LIKE gztz_t.gztz002
   DEFINE l_have         LIKE type_t.num5  

   LET l_have = 0
   SELECT COUNT(*) INTO l_have FROM gztz_t 
    WHERE gztz001 = ps_table AND gztz002 = ps_field

   RETURN l_have
END FUNCTION 