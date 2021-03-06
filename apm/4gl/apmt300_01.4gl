#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt300_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-07-21 14:34:15), PR版次:0001(2014-08-27 17:55:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: apmt300_01
#+ Description: 產生評分專案
#+ Creator....: 01752(2014-07-21 10:50:13)
#+ Modifier...: 01752 -SD/PR- 04543
 
{</section>}
 
{<section id="apmt300_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="apmt300_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_pmbn_d     DYNAMIC ARRAY OF RECORD
         sel            LIKE type_t.chr1,
         pmbn002        LIKE pmbn_t.pmbn002,
         pmbn002_desc   LIKE oocql_t.oocql004
                    END RECORD

DEFINE l_ac             LIKE type_t.num5
DEFINE g_rec_b          LIKE type_t.num5
DEFINE g_sql            STRING
DEFINE g_error_show     LIKE type_t.num5

#end add-point
 
{</section>}
 
{<section id="apmt300_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmt300_01.other_dialog" >}

 
{</section>}
 
{<section id="apmt300_01.other_function" readonly="Y" >}

PUBLIC FUNCTION apmt300_01(p_pmbpdocno,p_pmbp003)
   DEFINE p_pmbpdocno     LIKE pmbp_t.pmbpdocno
   DEFINE p_pmbp003       LIKE pmbp_t.pmbp003
   DEFINE r_success       LIKE type_t.num5
   
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE l_i             LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE

   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt300_01 WITH FORM cl_ap_formpath("apm","apmt300_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   
   CALL apmt300_01_b_fill(p_pmbpdocno,p_pmbp003)

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_pmbn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete, APPEND ROW = l_allow_insert)

         BEFORE INPUT
         
         AFTER INPUT

         BEFORE ROW
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.idx

      END INPUT

      ON ACTION selall 
         FOR l_i = 1 TO g_pmbn_d.getLength()
            LET g_pmbn_d[l_i].sel = 'Y'
         END FOR
         
      ON ACTION selnone
         FOR l_i = 1 TO g_pmbn_d.getLength()
            LET g_pmbn_d[l_i].sel = 'N'
         END FOR
         
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   IF INT_FLAG THEN
      LET INT_FLAG = 0
   ELSE
      CALL apmt300_01_gen_pmbs(p_pmbpdocno,p_pmbp003) RETURNING r_success
   END IF
   #畫面關閉
   CLOSE WINDOW w_apmt300_01

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION apmt300_01_b_fill(p_pmbpdocno,p_pmbp003)
   DEFINE p_pmbpdocno       LIKE pmbp_t.pmbpdocno
   DEFINE p_pmbp003         LIKE pmbp_t.pmbp003
   DEFINE l_ac_t            LIKE type_t.num5
 
   CALL g_pmbn_d.clear() 
   
   #判斷是否填充
   LET g_sql = "SELECT UNIQUE 'Y',pmbn002,t1.oocql004 FROM pmbn_t",   
               "  LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001 = '2052' AND t1.oocql002= pmbn002 AND t1.oocql003='"||g_dlang||"' ",
               " WHERE pmbnent=? AND pmbnsite=? AND pmbn001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料

   LET g_sql = g_sql, " ORDER BY pmbn_t.pmbn002"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料

   PREPARE apmt300_01_pre FROM g_sql
   DECLARE apmt300_01_b_fill_cs CURSOR FOR apmt300_01_pre
      
   LET l_ac_t = l_ac
   LET l_ac = 1

   OPEN apmt300_01_b_fill_cs USING g_enterprise,g_site,p_pmbp003

   FOREACH apmt300_01_b_fill_cs INTO g_pmbn_d[l_ac].sel,g_pmbn_d[l_ac].pmbn002,g_pmbn_d[l_ac].pmbn002_desc 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:apmt300_01_b_fill_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  '' 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF            
      
   END FOREACH
   LET g_error_show = 0

   CALL g_pmbn_d.deleteElement(g_pmbn_d.getLength())
   
   LET g_rec_b = l_ac - 1
   LET l_ac = l_ac_t
   
   DISPLAY g_rec_b TO FORMONLY.cnt
   FREE apmt300_01_pre

END FUNCTION
#存入pmbs_t
PRIVATE FUNCTION apmt300_01_gen_pmbs(p_pmbpdocno,p_pmbp003)
   DEFINE p_pmbpdocno      LIKE pmbp_t.pmbpdocno
   DEFINE p_pmbp003        LIKE pmbp_t.pmbp003
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_pmbl002        LIKE pmbl_t.pmbl002
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_pmbsseq        LIKE type_t.num5
   DEFINE l_pmaa001        LIKE pmaa_t.pmaa001
   DEFINE l_pmbs001        LIKE pmbs_t.pmbs001
   DEFINE l_pmbs002        LIKE pmbs_t.pmbs002
   DEFINE l_pmbs003        LIKE pmbs_t.pmbs003
   
   LET r_success = TRUE
   
   LET l_sql = " SELECT UNIQUE pmbl002 FROM pmbl_t ",
               "  WHERE pmblent = ",g_enterprise CLIPPED,
               "    AND pmblsite = '",g_site CLIPPED,"'",
               "    AND pmbl001 = '",p_pmbp003 CLIPPED,"'"

   PREPARE apmt300_01_pmbl_pre FROM l_sql
   DECLARE apmt300_01_pmbl_cs  CURSOR WITH HOLD FOR apmt300_01_pmbl_pre

   LET l_sql = " SELECT UNIQUE pmaa001 FROM pmaa_t",
               "  WHERE pmaaent = ",g_enterprise CLIPPED,
               "    AND pmaastus = 'Y'",
               "    AND pmaa080 = ? "

   PREPARE apmt300_01_pmaa_pre FROM l_sql
   DECLARE apmt300_01_pmaa_cs  CURSOR WITH HOLD FOR apmt300_01_pmaa_pre

   LET l_sql = " SELECT DISTINCT pmbs001,pmbs002,pmbs003",
               "   FROM pmbs_t",
               "  WHERE pmbsent = ",g_enterprise,
               "    AND pmbsdocno = '",p_pmbpdocno,"'"

   PREPARE apmt300_01_pmbs_pre FROM l_sql
   DECLARE apmt300_01_pmbs_cs  CURSOR WITH HOLD FOR apmt300_01_pmbs_pre

   LET l_sql = " SELECT pmbs003",
               "   FROM apmt300_01_tmp",
               "  WHERE pmbs001 = ?",
               "    AND pmbs002 = ?"

   PREPARE apmt300_01_tmp_pre FROM l_sql

   #先將已輸入的分數存入Temp table
   DELETE FROM apmt300_01_tmp
   FOREACH apmt300_01_pmbs_cs INTO l_pmbs001,l_pmbs002,l_pmbs003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      INSERT INTO apmt300_01_tmp(pmbs001,pmbs002,pmbs003)
           VALUES (l_pmbs001,l_pmbs002,l_pmbs003)
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET r_success = FALSE
         EXIT FOREACH
      END IF      

   END FOREACH

   IF NOT r_success THEN
      RETURN r_success
   END IF

   #刪除舊資料
   DELETE FROM pmbs_t
    WHERE pmbsent = g_enterprise
      AND pmbssite = g_site
      AND pmbsdocno = p_pmbpdocno

   LET l_pmbsseq = 1

   #供應商
   FOREACH apmt300_01_pmbl_cs INTO l_pmbl002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET r_success = FALSE
         EXIT FOREACH
      END IF
            
      FOREACH apmt300_01_pmaa_cs USING l_pmbl002 INTO l_pmaa001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            
            LET r_success = FALSE
            EXIT FOREACH
         END IF

         FOR l_i = 1 TO g_pmbn_d.getLength()
            IF g_pmbn_d[l_i].sel = 'N' THEN            
               CONTINUE FOR
            END IF

            #原輸入分數
            LET l_pmbs003 = 0
            EXECUTE apmt300_01_tmp_pre USING l_pmaa001,g_pmbn_d[l_i].pmbn002 INTO l_pmbs003
            IF cl_null(l_pmbs003) THEN
               LET l_pmbs003 = 0
            END IF
            
            INSERT INTO pmbs_t(pmbsent,pmbssite,pmbsdocno,pmbsseq,pmbs001,pmbs002,pmbs003)
                   VALUES(g_enterprise,g_site,p_pmbpdocno,l_pmbsseq,l_pmaa001,g_pmbn_d[l_i].pmbn002,l_pmbs003)
            LET l_pmbsseq = l_pmbsseq + 1
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "INSERT:"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               LET r_success = FALSE
               EXIT FOR
            END IF                  
            
         END FOR
         
         IF NOT r_success THEN
            EXIT FOREACH
         END IF

      END FOREACH

      IF NOT r_success THEN
         EXIT FOREACH
      END IF

   END FOREACH

   RETURN r_success
END FUNCTION
#建立Temp table
PUBLIC FUNCTION apmt300_01_create_tmp()
   CALL apmt300_01_drop_tmp()
   
   CREATE TEMP TABLE apmt300_01_tmp(
      pmbs001    LIKE pmbs_t.pmbs001,   #供應商編號
      pmbs002    LIKE pmbs_t.pmbs002,   #評核項目
      pmbs003    LIKE pmbs_t.pmbs003);  #分數
END FUNCTION
#刪除Temp table
PUBLIC FUNCTION apmt300_01_drop_tmp()
   DROP TABLE apmt300_01_tmp
END FUNCTION

 
{</section>}
 
