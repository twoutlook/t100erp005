#+ Version..: T100-ERP-1.00.00(版次:1) Build-000
#
#+ 程式代碼......: sadzi888_05
#+ 設計人員......: Cynthia
# Prog. Version..: 'T00-14.08.26(00000)'     #
#
# Program name : sadzi888_05.4gl 
# Description  : 報表紙張資料異動及修改樣板檔

IMPORT os
IMPORT security
IMPORT xml

SCHEMA ds


GLOBALS "../../cfg/top_global.inc"

DEFINE g_gzah001_moudle      LIKE gzza_t.gzza003           #存作業的模組   #for include
DEFINE g_properties          om.SaxAttributes              #屬性          #for include
DEFINE g_comp_cnt            LIKE type_t.num5              #報表元件數     #for include
DEFINE g_sql                 STRING                                      #for include
 
#+異動GR報表樣板檔             
PUBLIC FUNCTION sadzi888_05_4rpupd(p_rep_code)
   DEFINE p_rep_code          LIKE gzgf_t.gzgf001   #報表元件代號
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5   #150212 add
   DEFINE r_msg               STRING
   DEFINE l_gzgd          DYNAMIC ARRAY OF RECORD
             gzgd001          LIKE gzgd_t.gzgd001,
             gzgd002          LIKE gzgd_t.gzgd002,
             gzgd003          LIKE gzgd_t.gzgd003,
             gzgd004          LIKE gzgd_t.gzgd004,
             gzgd005          LIKE gzgd_t.gzgd005
                          END RECORD
   DEFINE l_i,l_j         INTEGER
   DEFINE l_langs         DYNAMIC ARRAY OF LIKE gzzy_t.gzzy001  #語言別
   DEFINE l_gzgd002       DYNAMIC ARRAY OF LIKE gzgd_t.gzgd002  #樣板代號
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_msg           STRING   
   DEFINE l_gzgd013       LIKE gzgd_t.gzgd013
    
   LET r_success = TRUE  
   LET r_msg = NULL
   CALL l_gzgd.clear()
   
   #抓取有設定的語系
   #CALL l_langs.clear()
   #CALL s_azzi301_lang_list() RETURNING l_langs
   #語言別暫時只做繁中和簡中
   CALL l_langs.clear()
   LET l_langs[1] = "zh_TW"
   LET l_langs[2] = "zh_CN"

   SELECT COUNT(gzgd001) INTO l_cnt FROM gzgd_t 
    WHERE gzgdstus = 'Y' AND gzgd001 = p_rep_code
      #AND (gzgd003 = 'N' OR gzgd003 = 's')
     
   IF l_cnt < 1 THEN
      LET r_success = FALSE
      LET r_msg = "Please Check the Information about azzi301 in adzi888!(請檢查adzi888中的過單資料!)"
   ELSE
      #GR樣板上傳是依據"報表元件代號",只變更標準報表(gzgd003=N)
      #DECLARE sadzi888_05_gzgd002_cur CURSOR FROM "SELECT DISTINCT gzgd002 FROM gzgd_t WHERE gzgdstus = 'Y' AND gzgd001 = ? "
      #DECLARE sadzi888_05_gzgd002_cur CURSOR FROM "SELECT DISTINCT gzgd001,gzgd002,gzgd003,gzgd004,gzgd005 FROM gzgd_t WHERE gzgdstus = 'Y' AND gzgd001 = ? AND (gzgd003 = 'N' OR gzgd003 = 's') "
      DECLARE sadzi888_05_gzgd002_cur CURSOR FROM "SELECT DISTINCT gzgd001,gzgd002,gzgd003,gzgd004,gzgd005 FROM gzgd_t WHERE gzgdstus = 'Y' AND gzgd001 = ? "
      LET l_i = 1
      FOREACH sadzi888_05_gzgd002_cur USING p_rep_code INTO l_gzgd[l_i].*
         LET l_success = TRUE
         #更新gzgd_t的資料
         CALL sadzi888_05_upd_gzgd(l_gzgd[l_i].*) RETURNING l_success,l_gzgd013
         
         #變更4rp樣板檔紙張大小
         IF l_success THEN
            IF NOT cl_null(l_gzgd013) THEN
               LET l_j = 1
               FOR l_j = 1 TO l_langs.getLength()
                  CALL s_azzi301_change_paper_size(l_gzgd[l_i].*,l_langs[l_j],l_gzgd013,"") RETURNING l_success,l_msg
                  IF l_success THEN
                     LET r_success = TRUE
                  ELSE
                     LET r_success = FALSE
                     LET r_msg = "Change Paper Size Failure!"
                  END IF
               END FOR
            END IF
         ELSE
            LET r_success = FALSE
            LET r_msg = "Update gzgd013 Failure!"
         END IF
         LET l_i = l_i + 1
      END FOREACH   
   END IF   
   
   RETURN r_success,r_msg
END FUNCTION 

PRIVATE FUNCTION sadzi888_05_upd_gzgd(p_gzgd)
   DEFINE p_gzgd          RECORD
             gzgd001          LIKE gzgd_t.gzgd001,
             gzgd002          LIKE gzgd_t.gzgd002,
             gzgd003          LIKE gzgd_t.gzgd003,
             gzgd004          LIKE gzgd_t.gzgd004,
             gzgd005          LIKE gzgd_t.gzgd005
                          END RECORD
   DEFINE r_gzgd013           LIKE gzgd_t.gzgd013   #客戶紙張
   DEFINE r_success           LIKE type_t.num5

   LET r_success = TRUE
   LET r_gzgd013 = NULL
   
   SELECT gzgd013 INTO r_gzgd013 FROM gzgd_t
    WHERE gzgd001 = p_gzgd.gzgd001
      AND gzgd002 = p_gzgd.gzgd002
      AND gzgd003 = p_gzgd.gzgd003
      AND gzgd004 = p_gzgd.gzgd004
      AND gzgd005 = p_gzgd.gzgd005
      AND gzgd006 = 1    #取得主樣板的客戶紙張

   IF NOT cl_null(r_gzgd013) THEN
      UPDATE gzgd_t SET gzgd013 = r_gzgd013
       WHERE gzgd001 = p_gzgd.gzgd001
         AND gzgd002 = p_gzgd.gzgd002
         AND gzgd003 = p_gzgd.gzgd003
         AND gzgd004 = p_gzgd.gzgd004
         AND gzgd005 = p_gzgd.gzgd005
        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "udpate gzgd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         LET r_success = FALSE
         LET r_gzgd013 = NULL
         RETURN r_success,r_gzgd013
      END IF         
   END IF

   RETURN r_success,r_gzgd013 
END FUNCTION 

#+產生include 4gl            
PUBLIC FUNCTION sadzi888_05_gen_include(p_code)
   DEFINE  p_code                  LIKE gzah_t.gzah001
   DEFINE  r_retrun                BOOLEAN
   
   CALL s_azzi988_gen_include_4gl(p_code) RETURNING r_retrun

   RETURN r_retrun
END FUNCTION


