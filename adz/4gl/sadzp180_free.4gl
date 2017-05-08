IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE g_sd_ver  LIKE dzaa_t.dzaa002 #規格版次
DEFINE g_pr_ver  LIKE dzaf_t.dzaf004 #程式版次
DEFINE g_env     LIKE dzaa_t.dzaa006 #辨識目前所在的環境:s.產中環境,c.客製環境
DEFINE g_gzza001 LIKE gzza_t.gzza001

PUBLIC FUNCTION sadzp180_free(lc_sd_ver,lc_gzza001,lc_dzfq005)

   DEFINE lc_sd_ver     LIKE dzaa_t.dzaa002 #規格版次/程式版次
   DEFINE lc_gzza001    LIKE gzza_t.gzza001
   DEFINE lc_gzza003    LIKE gzza_t.gzza003 #模組編號
   DEFINE lc_dzax003    LIKE dzax_t.dzax003 #為FreeStyle
   DEFINE ls_filename   STRING
   DEFINE lc_spectype   LIKE type_t.chr1
   DEFINE lc_dzfq005    LIKE dzfq_t.dzfq005 #子程式或主程式(M)
   DEFINE li_stus       LIKE type_t.num5    #狀態
   DEFINE li_cnt        LIKE type_t.num5    #狀態
   DEFINE ls_tmp1,ls_tmp2 STRING

   LET g_sd_ver = lc_sd_ver
   LET g_env = FGL_GETENV("DGENV") CLIPPED
   LET g_gzza001 = lc_gzza001
   LET lc_spectype = cl_chk_spec_type(lc_gzza001) #查詢spec類型 "M"主程式 "S"子程式
 
   #檢查主程式是否已完成註冊
   IF lc_spectype = "M" THEN
      SELECT gzza003 INTO lc_gzza003 FROM gzza_t
       WHERE gzza001 = lc_gzza001
   ELSE
      IF lc_gzza001[1,2] = "q_" OR lc_gzza001[1,3] = "cq_" THEN
         LET SQLCA.SQLCODE = 0
         LET lc_spectype = "Q"
         IF lc_gzza001[1,2] = "q_" THEN
            LET lc_gzza003 = "QRY"
         ELSE
            LET lc_gzza003 = "CQRY"
         END IF
      ELSE
         SELECT gzde002 INTO lc_gzza003 FROM gzde_t
          WHERE gzde001 = lc_gzza001
      END IF
   END IF
   IF SQLCA.SQLCODE THEN
      DISPLAY "WARNING:編號:",lc_gzza001,"未設定為主程式"
      RETURN FALSE
   END IF

   IF lc_gzza001[1,2] = "q_" OR lc_gzza001[1,3] = "cq_" THEN
      LET lc_dzax003 = "Y"
   ELSE
      #檢查是否標示使用Free Style
      SELECT COUNT(*) INTO li_cnt FROM dzax_t
       WHERE dzax001 = lc_gzza001 AND dzaxstus = "Y"
      IF li_cnt >=2 THEN
         SELECT dzax003 INTO lc_dzax003 FROM dzax_t
          WHERE dzax001 = lc_gzza001 AND dzaxstus = "Y"
            AND dzax006 = "c"
      ELSE
         SELECT dzax003 INTO lc_dzax003 FROM dzax_t
          WHERE dzax001 = lc_gzza001 AND dzaxstus = "Y"
      END IF
   END IF

   #程式版次抓取
   CALL sadzp060_2_get_code_curr_revision(lc_gzza001,lc_spectype,'')
        RETURNING g_pr_ver,ls_tmp1,ls_tmp2
   DISPLAY "INFO: ",lc_gzza001,"取得種類:",lc_spectype,"得到pr_ver:",g_pr_ver

   #確認有被標示為 FreeStyle
   IF lc_dzax003 IS NOT NULL AND lc_dzax003 = "Y" THEN
      LET ls_filename = os.Path.join(os.Path.join(FGL_GETENV(lc_gzza003),"4gl"),lc_gzza001),".4gl"
      IF os.Path.exists(ls_filename) THEN
         LET li_stus = sadzp180_free_load_file(ls_filename)

         #在此處檢查一下所需要的add-point是否已經存在
         SELECT COUNT(*) INTO li_cnt FROM dzbb_t
          WHERE dzbb001 = lc_gzza001        #規格/程式編號
            AND dzbb002 = "free_style.variable"   #程式設計點/add-point id
#           AND dzbb003 = g_pr_ver          #規格版次/程式版次
#           AND dzbb005 = g_cust            #客戶編號
         IF li_cnt = 0 THEN
            INSERT INTO dzbb_t (dzbb001,dzbb002,dzbb003,dzbb004,dzbbstus,
                                dzbbcrtid,dzbbcrtdt,dzbbcrtdp,dzbbownid,dzbbowndp)
                 VALUES (lc_gzza001,"free_style.variable",g_pr_ver,g_env,"Y",
                         g_user,TODAY,g_dept,g_user,g_dept)
         END IF

         RETURN li_stus
      ELSE
         DISPLAY "WARNING:檔案",ls_filename,"不存在,請確認"
      END IF
   END IF
   RETURN FALSE
END FUNCTION


PRIVATE FUNCTION sadzp180_free_load_file(ls_filename)

   DEFINE l_channel     base.Channel
   DEFINE ls_readline   STRING
   DEFINE ls_filename   STRING
   DEFINE ls_temp       STRING
   DEFINE ls_lower      STRING
   DEFINE ls_adpid      STRING
   DEFINE lc_dzba001    LIKE dzba_t.dzba001
   DEFINE lc_dzba003    LIKE dzba_t.dzba003 
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE li_mainstat   LIKE type_t.num5   #查看是否在main區塊內
   DEFINE li_q_free_style LIKE type_t.num5
   DEFINE ls_freestyle_temp  STRING

   LET l_channel = base.Channel.create()
   CALL l_channel.openFile(ls_filename,"r")
   CALL l_channel.setDelimiter("")
   LET ls_freestyle_temp = ""
   LET li_q_free_style = FALSE

   WHILE TRUE
      LET ls_readline = l_channel.readLine()

      IF l_channel.isEof() THEN
         EXIT WHILE
      ELSE
         LET ls_lower = ls_readline.toLowerCase()
      END IF

      #判斷是否為q_的程式
      IF g_gzza001[1,2] = "q_" THEN
         IF ls_lower.getIndexOf("function",1) AND 
            (ls_lower.getIndexOf("private",1) OR ls_lower.getIndexOf("public",1) ) THEN
            LET li_q_free_style = FALSE
         END IF
         IF li_q_free_style THEN
            LET ls_freestyle_temp = ls_freestyle_temp,"\n",ls_readline CLIPPED
         END IF
         IF ls_lower.getIndexOf("globals",1) AND ls_lower.getIndexOf("top_global.inc",1)  THEN
            LET li_q_free_style = TRUE
         END IF
      END IF

      #判斷是否在MAIN內
      IF ls_lower.getIndexOf("main",1) THEN
         LET ls_lower = ls_lower.trim()  #在清除一次
         IF ls_lower.subString(1,4) = "main" THEN
            LET li_mainstat = TRUE
         END IF
         IF ls_lower.subString(1,8) = "end main" THEN
            LET li_mainstat = FALSE
         END IF
      END IF 

      #遇到 PUBLIC FUNCTION 或 PRIVATE FUNCTION 或 FUNCTION 在行首,啟動開始str
      IF ls_lower.getIndexOf("public function",1) OR 
         ls_lower.getIndexOf("private function",1) THEN
         LET ls_adpid = ls_readline.subString(ls_lower.getIndexOf("function",1)+9,
                                              ls_lower.getIndexOf("(",ls_lower.getIndexOf("function",1)+10)-1)
         #將MAIN以外的均作為個別的function 寫入
         LET lc_dzba001 = g_gzza001  #程式代號
         LET lc_dzba003 = "function.",ls_adpid
         LET ls_adpid = "function.",ls_adpid

         LET ls_temp = ""
      END IF

      #MAIN函式中的LOCK CURSOR
      IF li_mainstat AND ls_lower.getIndexOf('let g_forupd_sql = "',1) THEN
         LET ls_adpid = "main.define_sql"
         LET ls_temp = ""
      END IF
      
      IF ls_readline.getIndexOf('{<section',1) > 0 OR ls_readline.getIndexOf('{</section',1) > 0 THEN
         LET ls_readline = '' 
      END IF

      LET ls_temp = ls_temp,"\n",ls_readline CLIPPED

      IF ls_lower.getIndexOf("end function",1) OR
         (li_mainstat = TRUE AND ls_lower.getIndexOf('let g_forupd_sql = "',1)) THEN
         IF sadzp180_free_write_adp(ls_adpid,ls_temp) THEN
         END IF
      END IF
   END WHILE

   #如果有值就寫入free style這一顆
   IF ls_freestyle_temp IS NOT NULL THEN
      IF sadzp180_free_write_adp("free_style.variable",ls_freestyle_temp) THEN
      END IF
   END IF

   RETURN TRUE

END FUNCTION


PRIVATE FUNCTION sadzp180_free_write_adp(lc_adpid,ls_temp)
   DEFINE ls_temp  STRING
   DEFINE lc_adpid LIKE dzbb_t.dzbb002
   DEFINE li_cnt   LIKE type_t.num5
   DEFINE lc_dzba006    LIKE dzba_t.dzba006   #序號
   DEFINE lc_dzbb       RECORD
             dzbb001    LIKE dzbb_t.dzbb001,
             dzbb002    LIKE dzbb_t.dzbb002,
             dzbb003    LIKE dzbb_t.dzbb003,
             dzbb004    LIKE dzbb_t.dzbb004,
             dzbb098    LIKE type_t.clob
                        END RECORD
   DEFINE lc_dzba008    LIKE dzba_t.dzba008  #產品版本
   DEFINE lc_dzba011    LIKE dzba_t.dzba011  #客戶代號
   DEFINE lc_today      LIKE type_t.dat      #日期

   LOCATE lc_dzbb.dzbb098 IN FILE

   LET lc_dzbb.dzbb098 = ls_temp
   LET lc_dzbb.dzbb001 = g_gzza001  #程式代號
   LET lc_dzbb.dzbb002 = lc_adpid   #程式設計點
   LET lc_dzbb.dzbb003 = g_pr_ver   #設計點版次
   LET lc_dzbb.dzbb004 = g_env      #使用標示
   LET lc_dzba006 = 0               #預設數字為0
   LET lc_today = TODAY
   LET lc_dzba008 = FGL_GETENV("ERPVER")  #產品版本
   LET lc_dzba011 = FGL_GETENV("CUST")    #客戶編號

   SELECT COUNT(*) INTO li_cnt FROM dzba_t 
    WHERE dzba001 = lc_dzbb.dzbb001
      AND dzba002 = g_pr_ver
      AND dzba003 = lc_dzbb.dzbb002

   IF li_cnt < 1 THEN
      #如果是other function則安排顯示順序
      IF lc_adpid[1,9]="function." THEN 
         SELECT MAX(dzba006) INTO lc_dzba006 FROM dzba_t 
          WHERE dzba001 = lc_dzbb.dzbb001
            AND dzba002 = g_pr_ver
         LET lc_dzba006 = lc_dzba006 + 1
      END IF

      INSERT INTO dzba_t (dzba001,dzba002,dzba003,dzba004,dzba005,dzba006,dzba010,dzbastus,
                          dzba007,dzba008,dzba009,dzba011,
                          dzbacrtid,dzbacrtdt,dzbacrtdp,dzbaownid,dzbaowndp)
           VALUES (lc_dzbb.dzbb001,g_pr_ver,lc_dzbb.dzbb002,lc_dzbb.dzbb003,
                   lc_dzbb.dzbb004,lc_dzba006,lc_dzbb.dzbb004,"Y",
                   "N",lc_dzba008,"N",lc_dzba011,
                   g_user,lc_today,g_dept,g_user,g_dept)
      INSERT INTO dzbb_t (dzbb001,dzbb002,dzbb003,dzbb004,dzbb098,dzbbstus,
                          dzbb005,
                          dzbbcrtid,dzbbcrtdt,dzbbcrtdp,dzbbownid,dzbbowndp)
           VALUES (lc_dzbb.dzbb001,lc_dzbb.dzbb002,lc_dzbb.dzbb003,
                   lc_dzbb.dzbb004,lc_dzbb.dzbb098,"Y",
                   lc_dzba011,
                   g_user,lc_today,g_dept,g_user,g_dept)
   ELSE
      DISPLAY "WARNING: FUNCTION Exists!:",lc_dzbb.dzbb002
   END IF

   FREE lc_dzbb.dzbb098

   RETURN TRUE

END FUNCTION

