#Section預覽工具
IMPORT os
SCHEMA ds

DEFINE g_dzax006   LIKE dzax_t.dzax006
DEFINE gs_mode     CHAR(10)

MAIN
   DEFINE ls_prog     STRING               #程式名稱
   DEFINE ls_gzza001  LIKE gzza_t.gzza001
   DEFINE ls_mod      LIKE type_t.chr50    #模組名稱
   DEFINE li_ver      LIKE type_t.num10    #程式版次(自動取得)
   DEFINE li_success  LIKE type_t.num10
   DEFINE li_cnt      LIKE type_t.num5  
   DEFINE lr_dzbc     RECORD LIKE dzbc_t.*
   
   CALL cl_db_connect("ds",FALSE) 
   
   #程式名稱
   LET ls_prog = ARG_VAL(2)
   LET gs_mode = ARG_VAL(3) #write代表覆寫section
   IF cl_null(gs_mode) OR gs_mode <> 'write' THEN
      DISPLAY 'INFO:開始Section預覽功能!'
      LET gs_mode = '2'
   ELSE
      LET gs_mode = '3'
      DISPLAY 'INFO:開始Section覆寫功能!'
   END IF

   #檢查是否為現存程式(於azzi900註冊)
   IF cl_null(ls_prog) THEN
      DISPLAY 'INFO:請輸入正確程式名稱!'
      EXIT PROGRAM
   END IF
   
   LET li_cnt = 0
   LET ls_gzza001 = ls_prog
   SELECT COUNT(*) INTO li_cnt FROM gzza_t 
    WHERE gzzastus = 'Y' AND gzza001 = ls_gzza001
   IF li_cnt = 0 THEN
      DISPLAY 'INFO:請先至azzi900完成程式註冊!'
      EXIT PROGRAM
   END IF
  
   #開始進行處理
   DISPLAY 'INFO:開始進行程式(',ls_prog,')Section預覽功能!'
 
   #模組判定
   CASE
      WHEN ls_prog.subString(1,3) = "cl_"  LET ls_mod = "LIB"
      WHEN ls_prog.subString(1,2) = "s_"   LET ls_mod = "SUB"
      WHEN ls_prog.subString(1,2) = "q_"   LET ls_mod = "QRY"
      WHEN ls_prog.subString(1,4) = "ccl_" LET ls_mod = "CLIB"
      WHEN ls_prog.subString(1,3) = "cs_"  LET ls_mod = "CSUB"
      WHEN ls_prog.subString(1,3) = "cq_"  LET ls_mod = "CQRY"
      WHEN ls_prog.subString(1,4) = "cwss" LET ls_mod = "CWSS"
      OTHERWISE
         LET ls_mod = UPSHIFT(ls_prog.subString(1,3))
   END CASE
   
   #版次取得
   LET g_dzax006 = 'c'
   CALL compose_section_get_ver(ls_prog,'A',ls_mod)
   RETURNING li_success,li_ver
   IF NOT li_success THEN
      DISPLAY "ERROR: 傳入的組合版次",li_ver USING "<<<","有問題,中止執行"
      EXIT PROGRAM
   END IF
    
   #先確認Section是否解開
   LET li_cnt = 0
   LET lr_dzbc.dzbc001 = ls_prog
   LET lr_dzbc.dzbc002 = li_ver
   LET lr_dzbc.dzbc007 = g_dzax006
   SELECT COUNT(*) INTO li_cnt FROM dzbc_t 
                  WHERE dzbc001 = lr_dzbc.dzbc001 AND #程式名稱
                        dzbc002 = lr_dzbc.dzbc002 AND #PR版次
                        dzbc005 <> 's'            AND #使用標示
                        dzbc007 = lr_dzbc.dzbc007     
   IF li_cnt = 0 THEN
      DISPLAY "ERROR:該程式(",ls_prog,")並無解開Section, 請重新確認!"
      EXIT PROGRAM
   END IF
    
   #執行adzp150,adzp152重產
   CALL compose_section_gen_tgl2(ls_mod,ls_prog,li_ver)
   
   #進行比較
   CALL compose_section_diff(ls_mod,ls_prog)

END MAIN

#+ 取得程式版次
PRIVATE FUNCTION compose_section_get_ver(ps_prog,lc_gzzx010,lc_mod)
   DEFINE ps_prog      STRING
   DEFINE lc_gzzx010   CHAR(100)
   DEFINE lc_gzzx010_b LIKE gzzx_t.gzzx010  #程式版次
   DEFINE lc_dzax001   LIKE dzax_t.dzax001
   DEFINE lc_dzax004   LIKE dzax_t.dzax004
   DEFINE li_return    LIKE type_t.num5
   DEFINE lc_spec_type LIKE type_t.chr1     #程式類型
   DEFINE lc_dzaf002   LIKE type_t.num5     #規格版次
   DEFINE lc_dzaf007   LIKE dzaf_t.dzaf007  #產品代號  $ERPID
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE lc_mod   LIKE type_t.chr4  #模組編號

   LET lc_dzax001 = ps_prog.trim()

   LET lc_spec_type = cl_chk_spec_type(lc_dzax001)

   #若dzax006=c 則先檢查
   IF g_dzax006 = "c" THEN
      SELECT dzax004 INTO lc_dzax004 FROM dzax_t
       WHERE dzax001 = lc_dzax001 AND dzax006 = g_dzax006 AND dzaxstus = "Y"
      IF SQLCA.SQLCODE THEN
         DISPLAY "INFO: 指定查詢的客製程式不存在,自動更換為找標準程式 c->s "
         LET g_dzax006 = "s"
      END IF
   END IF

   #如果找不到,則客製指標已經換回 s
   IF g_dzax006 = "s" THEN
      SELECT dzax004 INTO lc_dzax004 FROM dzax_t
       WHERE dzax001 = lc_dzax001 AND dzax006 = g_dzax006 AND dzaxstus = "Y"
   END IF

   IF SQLCA.SQLCODE OR lc_dzax004 IS NULL THEN
      IF lc_spec_type = "L" OR lc_spec_type = "B" OR lc_spec_type = "X" OR
         lc_spec_type = "G" THEN
         LET lc_dzax004 = "Y"
      ELSE
         DISPLAY "INFO: 程式(",lc_dzax001 CLIPPED,")未經過r.a初始化,dzax_t不存在資料"
         LET lc_dzax004 = "N"
      END IF
   END IF                      
   #L(library)/B(subroutine)/X(eXtragrid)/G(GR)

   #如果傳進來的版次是 A, 表示希望要用自動模式填入
   IF lc_gzzx010 = "A" THEN
      LET lc_gzzx010_b = lc_gzzx010
      LET lc_dzaf007 = FGL_GETENV("ERPID")   #產品代號

      #抓取ALM最大設計版次
      SELECT MAX(CAST(NVL(TRIM(dzaf002),"0") AS INTEGER)) INTO lc_dzaf002 FROM dzaf_t
       WHERE dzaf001 = lc_dzax001   #規格代號
         AND dzaf007 = lc_dzaf007   #產品代號
         AND dzaf010 = g_dzax006    #識別標示
 
      #從最大設計版次決定程式碼的版次
      SELECT dzaf004 INTO lc_gzzx010 FROM dzaf_t
       WHERE dzaf001 = lc_dzax001   #規格代號
         AND dzaf002 = lc_dzaf002
         AND dzaf007 = lc_dzaf007   #產品代號
         AND dzaf010 = g_dzax006    #識別標示
      DISPLAY "INFO: 取得最大設計版次為:",lc_dzaf002," 所屬的程式碼版次為:",lc_gzzx010 CLIPPED

      IF SQLCA.SQLCODE THEN
         #如果發生錯誤,回頭找gzzx010
         SELECT gzzx010 INTO lc_gzzx010 FROM gzzx_t
          WHERE gzzx001 = lc_dzax001
         IF SQLCA.SQLCODE OR lc_gzzx010 IS NULL THEN
            #再發生錯誤直接用A回傳
            LET lc_gzzx010 = lc_gzzx010_b
         END IF
      END IF
   END IF

   #如果版次不等於A, 則檢查在dzba中是否存在 (濾除版次1,有可能是轉free style)
   IF lc_gzzx010 <> "A" AND lc_gzzx010 <> 1 THEN
      SELECT COUNT(*) INTO li_cnt FROM dzba_t
       WHERE dzba001 = lc_dzax001
         AND dzba002 = lc_gzzx010
         AND dzbastus = "Y"
      IF li_cnt = 0 THEN
         DISPLAY "WARNING: 預先查詢設計點資料:不存在 (",lc_dzax001 CLIPPED," ver:",lc_gzzx010,")"
         #可是lib/sub/clib/csub又有這種可能性存在,所以不能擋
         IF lc_mod = "LIB" OR lc_mod = "CLIB" OR
            lc_mod = "SUB" OR lc_mod = "CSUB" THEN
            LET li_return = TRUE
         ELSE
            LET li_return = FALSE
         END IF
      ELSE
         DISPLAY "INFO: 預先查詢設計點資料:",li_cnt,"筆"
         LET li_return = TRUE
      END IF
   ELSE
      LET li_return = TRUE
   END IF

   RETURN li_return,lc_gzzx010

END FUNCTION

#+ 開始產生tgl2
FUNCTION compose_section_gen_tgl2(ps_mod,ps_prog,ps_ver)
   DEFINE ps_mod             LIKE type_t.chr10
   DEFINE ps_prog            LIKE type_t.chr50
   DEFINE ps_ver             LIKE type_t.chr10
   DEFINE lbc_read           base.Channel
   DEFINE ls_cmd             STRING
   DEFINE ls_readline        STRING
   DEFINE lc_dzax002         LIKE dzax_t.dzax002
   DEFINE lc_dzax003         LIKE dzax_t.dzax003
    
   #先確定程式類型
   SELECT dzax002,dzax003 INTO lc_dzax002,lc_dzax003 FROM dzax_t
    WHERE dzax001 = ps_prog
      AND dzax006 = g_dzax006
      AND dzaxstus = "Y"
   IF SQLCA.SQLCODE THEN
      LET ls_cmd = 'fglrun $ADZ/42r/adzp150.42r '
      DISPLAY '判定為i,t,p,r類程式, 呼叫adzp150進行重產!'
   ELSE
      IF lc_dzax002 = "Q" AND lc_dzax003 = "N" THEN
         LET ls_cmd = 'fglrun $ADZ/42r/adzp152.42r '
         DISPLAY '判定為q類程式, 呼叫adzp152進行重產!'
      ELSE
         LET ls_cmd = 'fglrun $ADZ/42r/adzp150.42r '
         DISPLAY '判定為i,t,p,r類程式, 呼叫adzp150進行重產!'
      END IF
   END IF
    
   LET ps_mod = DOWNSHIFT(ps_mod)
   LET lbc_read = base.Channel.create()
   CALL lbc_read.setDelimiter("")
   LET ls_cmd = ls_cmd,                 #0. 執行程式(adzp150,adzp152)
                DOWNSHIFT(ps_mod),' ',  #1. 模組名稱
                ps_prog,' ',            #2. 程式名稱
                ' n ',                  #3. 程式add-point是否覆蓋(y,n), 未傳入則視為n
                ps_ver,' ',             #4. 程式版次
                g_dzax006,' ',          #5. 區域(識別標示)
                ' ',gs_mode,' '         #6. 產出模式(1,2,3) ps. 未傳入則視為1

   CALL lbc_read.openPipe( ls_cmd, "r" )

   DISPLAY '開始產生',ps_prog,'.tgl2'
   WHILE TRUE
      LET ls_readline = lbc_read.readLine()
      #DISPLAY ls_readline
      LET ls_readline = UPSHIFT(ls_readline)
    
      IF ls_readline.getIndexOf('ERROR',1) THEN
         DISPLAY ls_readline
         DISPLAY '產出過程中出現錯誤, 程式中斷!'
         EXIT PROGRAM
      ELSE
         DISPLAY ls_readline
      END IF
     
      IF lbc_read.isEof() THEN
         EXIT WHILE
      END IF
   END WHILE

   #組合
   IF gs_mode = '3' THEN
      DISPLAY 'INFO:開始組合4gl!'
      LET ls_cmd = 'fglrun $ADZ/42r/adzp180.42r '
      LET ls_cmd = ls_cmd,                 #0. 執行程式(adzp150,adzp152)
                   DOWNSHIFT(ps_mod),' ',  #1. 模組名稱
                   ps_prog,' ',            #2. 程式名稱
                   ps_ver,' ',             #3. 程式版次
                   g_dzax006               #4. 區域(識別標示)
      CALL lbc_read.openPipe( ls_cmd, "r" )
      DISPLAY 'INFO:4gl組合完成!'
   END IF
    
   CALL lbc_read.close()

END FUNCTION

#+ 開始比較tgl及tgl2
FUNCTION compose_section_diff(ps_mod,ps_prog)
   DEFINE ps_mod       LIKE type_t.chr10
   DEFINE ps_prog      LIKE type_t.chr50
   DEFINE lbc_read     base.Channel
   DEFINE ls_cmd       STRING
   DEFINE ls_file1     STRING
   DEFINE ls_file2     STRING
   DEFINE ls_readline  STRING
   
   #不比較
   IF gs_mode = '3' THEN
      RETURN
   END IF
   
   DISPLAY '以下開始比較Section差異:'
   LET lbc_read = base.Channel.create()
   CALL lbc_read.setDelimiter("")
   
   LET ls_file1 = os.Path.join(FGL_GETENV(UPSHIFT(ps_mod)),"dzx")
   LET ls_file1 = os.Path.join(ls_file1,"tgl")
   LET ls_file1 = os.Path.join(ls_file1,ps_prog||".tgl")
   
   LET ls_file2 = ls_file1,'2'
   
   LET ls_cmd = 'diff ',ls_file1,' ',ls_file2
   #display ls_cmd
   CALL lbc_read.openPipe( ls_cmd, "r" )

   WHILE TRUE
      LET ls_readline = lbc_read.readLine()
      #顯示diff結果
      IF adzp157_filter(ls_readline) THEN
         IF ls_readline.substring(1,1) = '<' THEN
            LET ls_readline = 'Section同步前:',ls_readline.substring(2,ls_readline.getLength())
         END IF
         IF ls_readline.substring(1,1) = '>' THEN
            LET ls_readline = 'Section同步後:',ls_readline.substring(2,ls_readline.getLength())
         END IF
         IF ls_readline.subString(1,3) = '---' THEN
            LET ls_readline = '\n    ↓   ↓   ↓   ↓   Section同步   ↓   ↓   ↓   ↓    \n'
         END IF
         IF ls_readline.subString(1,1) MATCHES '[0-9]' THEN
            LET ls_readline = '=====================================================================\n',ls_readline
         END IF
         DISPLAY ls_readline
      END IF
      IF lbc_read.isEof() THEN
         EXIT WHILE
      END IF
   END WHILE
   
   DISPLAY 'Section比較檔案如下(不包含add-point內容):'
   DISPLAY 'Section同步前:',ls_file1
   DISPLAY 'Section同步後:',ls_file2
   
   DISPLAY '\n---------------------------------------------------------'
   DISPLAY 'INFO:Section比較完成!'
   
   CALL lbc_read.close()

END FUNCTION

#+ 過濾不需要的內容
FUNCTION adzp157_filter(ps_line)
   DEFINE ps_line    STRING
   DEFINE lb_filter  BOOLEAN
   
   LET lb_filter = TRUE
   
   #當以下幾種狀況時進行排除
   IF ps_line.getIndexOf('#+ Version..: T100-ERP',1) THEN
      #LET lb_filter = FALSE
   END IF
   
   IF ps_line.getIndexOf('#add-point',1) THEN
      #LET lb_filter = FALSE
   END IF
   
   IF ps_line.getIndexOf('{<point name=',1) THEN
      #LET lb_filter = FALSE
   END IF
   
   IF ps_line.getIndexOf('#end add-point',1) THEN
      #LET lb_filter = FALSE
   END IF
   
   #註解段落
   IF ps_line.subString(1,1) = '>' OR ps_line.subString(1,1) = '<' THEN
      LET ps_line = ps_line.subString(2,ps_line.getLength())
      LET ps_line = ps_line.trim()
      IF ps_line.subString(1,1) = '#' THEN
         #LET lb_filter = FALSE
      END IF
   END IF
    
   RETURN lb_filter
   
END FUNCTION 
