#該程式未解開Section, 採用最新樣板產出!
{<section id="aecm200_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-01-20 15:09:13), PR版次:0002(2016-04-20 10:00:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: aecm200_05
#+ Description: 資源專案
#+ Creator....: 05384(2016-01-18 16:57:24)
#+ Modifier...: 05384 -SD/PR- 02295
 
{</section>}
 
{<section id="aecm200_05.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160414-00003#1  2016/04/20 By xianghui 抓资料时没有加上site的条件
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_ecbh_d        RECORD
       ecbh001 LIKE ecbh_t.ecbh001, 
   ecbh002 LIKE ecbh_t.ecbh002, 
   ecbh003 LIKE ecbh_t.ecbh003, 
   ecbh004 LIKE ecbh_t.ecbh004, 
   ecbh004_desc LIKE type_t.chr500, 
   ecbh005 LIKE ecbh_t.ecbh005, 
   ecbh005_desc LIKE type_t.chr500, 
   ecbh006 LIKE ecbh_t.ecbh006, 
   ecbh007 LIKE ecbh_t.ecbh007
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ecbh_d_o        type_g_ecbh_d
DEFINE g_ecbb    RECORD   #單頭display欄位
   ecbh001        LIKE ecbh_t.ecbh001,
   ecbh001_desc   LIKE type_t.chr500,
   ecbh001_desc_1 LIKE type_t.chr500,
   ecbh002        LIKE ecbh_t.ecbh002,
   ecbh002_desc   LIKE type_t.chr500,
   ecbh003        LIKE ecbh_t.ecbh003,
   ecbb026        LIKE ecbb_t.ecbb026,
   ecbb027        LIKE ecbb_t.ecbb027,
   ecbb037        LIKE ecbb_t.ecbb037,
   ecbb037_desc   LIKE type_t.chr500,
   ecbb038        LIKE ecbb_t.ecbb038,
   ecbb038_desc   LIKE type_t.chr500
                 END RECORD
#end add-point
 
DEFINE g_ecbh_d          DYNAMIC ARRAY OF type_g_ecbh_d
DEFINE g_ecbh_d_t        type_g_ecbh_d
 
 
DEFINE g_ecbh001_t   LIKE ecbh_t.ecbh001    #Key值備份
DEFINE g_ecbh002_t      LIKE ecbh_t.ecbh002    #Key值備份
DEFINE g_ecbh003_t      LIKE ecbh_t.ecbh003    #Key值備份
DEFINE g_ecbh004_t      LIKE ecbh_t.ecbh004    #Key值備份
DEFINE g_ecbh005_t      LIKE ecbh_t.ecbh005    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="aecm200_05.input" >}
#+ 資料輸入
PUBLIC FUNCTION aecm200_05(--)
   #add-point:input段變數傳入 name="input.get_var"
p_ecbb001,p_ecbb002,p_ecbb003
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_ecbb001       LIKE ecbb_t.ecbb001
   DEFINE p_ecbb002       LIKE ecbb_t.ecbb002
   DEFINE p_ecbb003       LIKE ecbb_t.ecbb003
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_sql_2         STRING
   DEFINE l_sql_3         STRING
   DEFINE l_merge         STRING
   DEFINE l_mrbi002_1     LIKE mrbi_t.mrbi002
   DEFINE l_mrbi002_2     LIKE mrbi_t.mrbi002
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_n1            LIKE type_t.num5
   DEFINE l_n2            LIKE type_t.num5
   DEFINE l_count_1       LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_ecbh          DYNAMIC ARRAY OF type_g_ecbh_d
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aecm200_05 WITH FORM cl_ap_formpath("aec","aecm200_05")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   LET l_success = TRUE
   CALL aecm200_05_cre_tmp() RETURNING l_success
   IF NOT l_success THEN
      DROP TABLE aecm200_05_temp
      CLOSE WINDOW w_aecm200_05
      RETURN
   END IF
   
   SELECT ecbb026,ecbb027,ecbb037,ecbb038 INTO g_ecbb.ecbb026,g_ecbb.ecbb027,g_ecbb.ecbb037,g_ecbb.ecbb038
     FROM ecbb_t
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site          #160414-00003#1 add
      AND ecbb001 = p_ecbb001
      AND ecbb002 = p_ecbb002
      AND ecbb003 = p_ecbb003
   LET g_ecbb.ecbh001 = p_ecbb001
   LET g_ecbb.ecbh002 = p_ecbb002
   LET g_ecbb.ecbh003 = p_ecbb003
   
   CALL aecm200_05_display_ecbb()
   
   LET l_sql = "SELECT mrbi002",
               "  FROM mrbi_t",
               " WHERE mrbient = '",g_enterprise,"'",
               "   AND mrbisite = '",g_site,"'",
               "   AND mrbi001 = '",g_ecbb.ecbb037,"'",
               " ORDER BY mrbi002"
   
   PREPARE aecm200_05_temp_pre1 FROM l_sql
   DECLARE aecm200_05_temp_cs1 CURSOR FOR aecm200_05_temp_pre1
   LET l_mrbi002_1 = ''
   
   LET l_sql = "SELECT mrbi002",
               "  FROM mrbi_t",
               " WHERE mrbient = '",g_enterprise,"'",
               "   AND mrbisite = '",g_site,"'",
               "   AND mrbi001 = '",g_ecbb.ecbb038,"'",
               " ORDER BY mrbi002"
   PREPARE aecm200_05_temp_pre2 FROM l_sql
   DECLARE aecm200_05_temp_cs2 CURSOR FOR aecm200_05_temp_pre2
   LET l_mrbi002_2 = ''
   LET l_n1 = 0
   LET l_n2 = 0
   FOREACH aecm200_05_temp_cs1 INTO l_mrbi002_1
      LET l_n1 = l_n1 + 1
      LET l_n2 = 0
      FOREACH aecm200_05_temp_cs2 INTO l_mrbi002_2
         LET l_n2 = l_n2 + 1
         INSERT INTO aecm200_05_temp(ecbh001,ecbh002,ecbh003,ecbh004,ecbh005,ecbh006,ecbh007)
              VALUES(p_ecbb001,p_ecbb002,p_ecbb003,l_mrbi002_1,l_mrbi002_2,g_ecbb.ecbb026,g_ecbb.ecbb027)
                  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INSERT:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH
      IF l_n2 = 0 THEN
         INSERT INTO aecm200_05_temp(ecbh001,ecbh002,ecbh003,ecbh004,ecbh005,ecbh006,ecbh007)
              VALUES(p_ecbb001,p_ecbb002,p_ecbb003,l_mrbi002_1,' ',g_ecbb.ecbb026,g_ecbb.ecbb027)
                  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INSERT:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END IF
   END FOREACH
   IF l_n1 = 0 THEN
      LET l_n2 = 0
      FOREACH aecm200_05_temp_cs2 INTO l_mrbi002_2
         LET l_n2 = l_n2 + 1
         INSERT INTO aecm200_05_temp(ecbh001,ecbh002,ecbh003,ecbh004,ecbh005,ecbh006,ecbh007)
              VALUES(p_ecbb001,p_ecbb002,p_ecbb003,' ',l_mrbi002_2,g_ecbb.ecbb026,g_ecbb.ecbb027)
                  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INSERT:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH
      IF l_n2 = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "aec-00055"
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         LET l_success = FALSE
      END IF
   END IF
   IF NOT l_success THEN
      DROP TABLE aecm200_05_temp
      CLOSE WINDOW w_aecm200_05
      RETURN
   END IF
   LET l_merge =                  
       " MERGE INTO aecm200_05_temp t0 ",
       "      USING (SELECT ecbh001,ecbh002,ecbh003,ecbh004,ecbh005,ecbh006,ecbh007 ",
       "               FROM ecbh_t ",
       "              WHERE ecbhent  = '",g_enterprise,"'",
       "                AND ecbhsite   = '",g_site,"'",
       "                AND ecbh001  = '",p_ecbb001,"'",
       "                AND ecbh002  = '",p_ecbb002,"'",
       "                AND ecbh003 = '",p_ecbb003,"' ) t1",          
       "      ON ( t0.ecbh004 = t1.ecbh004 AND t0.ecbh005 = t1.ecbh005 ) ",
       "    WHEN MATCHED THEN ",
       " UPDATE SET t0.ecbh006 = t1.ecbh006,", 
       "            t0.ecbh007 = t1.ecbh007 "    
   PREPARE aecm200_05_merge_qc FROM l_merge
   EXECUTE aecm200_05_merge_qc
   LET l_sql_3 = " SELECT ecbh001,ecbh002,ecbh003,ecbh004,ecbh005,ecbh006,ecbh007,t0.mrba005,t1.mrba005 ",
                 "   FROM ecbh_t ",
                 " LEFT OUTER JOIN mrba_t t0 ON t0.mrbaent = '",g_enterprise,"' AND t0.mrbasite = '",g_site,"' AND t0.mrba001 = ecbh004 ",
                 " LEFT OUTER JOIN mrba_t t1 ON t1.mrbaent = '",g_enterprise,"' AND t1.mrbasite = '",g_site,"' AND t1.mrba001 = ecbh005 ",
                 "  WHERE ecbhent = '",g_enterprise,"' ",
                 "  AND ecbhsite = '",g_site,"' ",
                 "  AND ecbh001 = '",g_ecbb.ecbh001,"' ",
                 "  AND ecbh002 = '",g_ecbb.ecbh002,"' ",
                 "  AND ecbh003 = '",g_ecbb.ecbh003,"' ",
                 " ORDER BY ecbh004,ecbh005 "
               
   PREPARE ins_ecbh_pre FROM l_sql_3
   DECLARE ins_ecbh_cs CURSOR FOR ins_ecbh_pre

   CALL l_ecbh.clear()
   LET l_n = 1
   FOREACH ins_ecbh_cs INTO l_ecbh[l_n].ecbh001,l_ecbh[l_n].ecbh002,l_ecbh[l_n].ecbh003,
                            l_ecbh[l_n].ecbh004,l_ecbh[l_n].ecbh005,l_ecbh[l_n].ecbh006,
                            l_ecbh[l_n].ecbh007,l_ecbh[l_n].ecbh004_desc,l_ecbh[l_n].ecbh005_desc
      LET l_count_1 = 0
      SELECT COUNT(*) INTO l_count_1
        FROM aecm200_05_temp
       WHERE ecbh001 = g_ecbb.ecbh001
         AND ecbh002 = g_ecbb.ecbh002
         AND ecbh003 = g_ecbb.ecbh003
         AND ecbh004 = l_ecbh[l_n].ecbh004
         AND ecbh005 = l_ecbh[l_n].ecbh005
      IF l_count_1 > 0 THEN
         CONTINUE FOREACH
      END IF
      LET l_n = l_n + 1                          
   END FOREACH
   LET l_n = l_n - 1
   IF l_n > 0 THEN
      CALL cl_err_collect_init()
      FOR l_i = 1 TO l_ecbh.getLength() - 1
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aec-00056'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_ecbh[l_i].ecbh004
         LET g_errparam.replace[2] = l_ecbh[l_i].ecbh005
         CALL cl_err()
      END FOR
      CALL cl_err_collect_show()
   END IF
   CALL aecm200_05_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_ecbh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
         BEFORE ROW
         LET l_cmd = ''
         LET l_ac = ARR_CURR()
         DISPLAY l_ac TO FORMONLY.idx
          
         IF g_rec_b >= l_ac THEN
            LET l_cmd = 'u'
            LET g_ecbh_d_t.* = g_ecbh_d[l_ac].*  #BACKUP
            LET g_ecbh_d_o.* = g_ecbh_d[l_ac].*
         ELSE
            LET l_cmd = 'a'
         END IF

            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecbh001
            #add-point:BEFORE FIELD ecbh001 name="input.b.page1.ecbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecbh001
            
            #add-point:AFTER FIELD ecbh001 name="input.a.page1.ecbh001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_ecbh_d[g_detail_idx].ecbh001 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh002 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh003 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh004 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ecbh_d[g_detail_idx].ecbh001 != g_ecbh_d_t.ecbh001 OR g_ecbh_d[g_detail_idx].ecbh002 != g_ecbh_d_t.ecbh002 OR g_ecbh_d[g_detail_idx].ecbh003 != g_ecbh_d_t.ecbh003 OR g_ecbh_d[g_detail_idx].ecbh004 != g_ecbh_d_t.ecbh004 OR g_ecbh_d[g_detail_idx].ecbh005 != g_ecbh_d_t.ecbh005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ecbh_t WHERE "||"ecbhent = '" ||g_enterprise|| "' AND ecbhsite = '" ||g_site|| "' AND "||"ecbh001 = '"||g_ecbh_d[g_detail_idx].ecbh001 ||"' AND "|| "ecbh002 = '"||g_ecbh_d[g_detail_idx].ecbh002 ||"' AND "|| "ecbh003 = '"||g_ecbh_d[g_detail_idx].ecbh003 ||"' AND "|| "ecbh004 = '"||g_ecbh_d[g_detail_idx].ecbh004 ||"' AND "|| "ecbh005 = '"||g_ecbh_d[g_detail_idx].ecbh005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ecbh001
            #add-point:ON CHANGE ecbh001 name="input.g.page1.ecbh001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecbh002
            #add-point:BEFORE FIELD ecbh002 name="input.b.page1.ecbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecbh002
            
            #add-point:AFTER FIELD ecbh002 name="input.a.page1.ecbh002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_ecbh_d[g_detail_idx].ecbh001 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh002 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh003 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh004 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ecbh_d[g_detail_idx].ecbh001 != g_ecbh_d_t.ecbh001 OR g_ecbh_d[g_detail_idx].ecbh002 != g_ecbh_d_t.ecbh002 OR g_ecbh_d[g_detail_idx].ecbh003 != g_ecbh_d_t.ecbh003 OR g_ecbh_d[g_detail_idx].ecbh004 != g_ecbh_d_t.ecbh004 OR g_ecbh_d[g_detail_idx].ecbh005 != g_ecbh_d_t.ecbh005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ecbh_t WHERE "||"ecbhent = '" ||g_enterprise|| "' AND ecbhsite = '" ||g_site|| "' AND "||"ecbh001 = '"||g_ecbh_d[g_detail_idx].ecbh001 ||"' AND "|| "ecbh002 = '"||g_ecbh_d[g_detail_idx].ecbh002 ||"' AND "|| "ecbh003 = '"||g_ecbh_d[g_detail_idx].ecbh003 ||"' AND "|| "ecbh004 = '"||g_ecbh_d[g_detail_idx].ecbh004 ||"' AND "|| "ecbh005 = '"||g_ecbh_d[g_detail_idx].ecbh005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ecbh002
            #add-point:ON CHANGE ecbh002 name="input.g.page1.ecbh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecbh003
            #add-point:BEFORE FIELD ecbh003 name="input.b.page1.ecbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecbh003
            
            #add-point:AFTER FIELD ecbh003 name="input.a.page1.ecbh003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_ecbh_d[g_detail_idx].ecbh001 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh002 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh003 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh004 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ecbh_d[g_detail_idx].ecbh001 != g_ecbh_d_t.ecbh001 OR g_ecbh_d[g_detail_idx].ecbh002 != g_ecbh_d_t.ecbh002 OR g_ecbh_d[g_detail_idx].ecbh003 != g_ecbh_d_t.ecbh003 OR g_ecbh_d[g_detail_idx].ecbh004 != g_ecbh_d_t.ecbh004 OR g_ecbh_d[g_detail_idx].ecbh005 != g_ecbh_d_t.ecbh005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ecbh_t WHERE "||"ecbhent = '" ||g_enterprise|| "' AND ecbhsite = '" ||g_site|| "' AND "||"ecbh001 = '"||g_ecbh_d[g_detail_idx].ecbh001 ||"' AND "|| "ecbh002 = '"||g_ecbh_d[g_detail_idx].ecbh002 ||"' AND "|| "ecbh003 = '"||g_ecbh_d[g_detail_idx].ecbh003 ||"' AND "|| "ecbh004 = '"||g_ecbh_d[g_detail_idx].ecbh004 ||"' AND "|| "ecbh005 = '"||g_ecbh_d[g_detail_idx].ecbh005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ecbh003
            #add-point:ON CHANGE ecbh003 name="input.g.page1.ecbh003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecbh004
            
            #add-point:AFTER FIELD ecbh004 name="input.a.page1.ecbh004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_ecbh_d[g_detail_idx].ecbh001 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh002 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh003 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh004 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ecbh_d[g_detail_idx].ecbh001 != g_ecbh_d_t.ecbh001 OR g_ecbh_d[g_detail_idx].ecbh002 != g_ecbh_d_t.ecbh002 OR g_ecbh_d[g_detail_idx].ecbh003 != g_ecbh_d_t.ecbh003 OR g_ecbh_d[g_detail_idx].ecbh004 != g_ecbh_d_t.ecbh004 OR g_ecbh_d[g_detail_idx].ecbh005 != g_ecbh_d_t.ecbh005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ecbh_t WHERE "||"ecbhent = '" ||g_enterprise|| "' AND ecbhsite = '" ||g_site|| "' AND "||"ecbh001 = '"||g_ecbh_d[g_detail_idx].ecbh001 ||"' AND "|| "ecbh002 = '"||g_ecbh_d[g_detail_idx].ecbh002 ||"' AND "|| "ecbh003 = '"||g_ecbh_d[g_detail_idx].ecbh003 ||"' AND "|| "ecbh004 = '"||g_ecbh_d[g_detail_idx].ecbh004 ||"' AND "|| "ecbh005 = '"||g_ecbh_d[g_detail_idx].ecbh005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecbh004
            #add-point:BEFORE FIELD ecbh004 name="input.b.page1.ecbh004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ecbh004
            #add-point:ON CHANGE ecbh004 name="input.g.page1.ecbh004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecbh005
            
            #add-point:AFTER FIELD ecbh005 name="input.a.page1.ecbh005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_ecbh_d[g_detail_idx].ecbh001 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh002 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh003 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh004 IS NOT NULL AND g_ecbh_d[g_detail_idx].ecbh005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ecbh_d[g_detail_idx].ecbh001 != g_ecbh_d_t.ecbh001 OR g_ecbh_d[g_detail_idx].ecbh002 != g_ecbh_d_t.ecbh002 OR g_ecbh_d[g_detail_idx].ecbh003 != g_ecbh_d_t.ecbh003 OR g_ecbh_d[g_detail_idx].ecbh004 != g_ecbh_d_t.ecbh004 OR g_ecbh_d[g_detail_idx].ecbh005 != g_ecbh_d_t.ecbh005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ecbh_t WHERE "||"ecbhent = '" ||g_enterprise|| "' AND ecbhsite = '" ||g_site|| "' AND "||"ecbh001 = '"||g_ecbh_d[g_detail_idx].ecbh001 ||"' AND "|| "ecbh002 = '"||g_ecbh_d[g_detail_idx].ecbh002 ||"' AND "|| "ecbh003 = '"||g_ecbh_d[g_detail_idx].ecbh003 ||"' AND "|| "ecbh004 = '"||g_ecbh_d[g_detail_idx].ecbh004 ||"' AND "|| "ecbh005 = '"||g_ecbh_d[g_detail_idx].ecbh005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecbh005
            #add-point:BEFORE FIELD ecbh005 name="input.b.page1.ecbh005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ecbh005
            #add-point:ON CHANGE ecbh005 name="input.g.page1.ecbh005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecbh006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbh_d[l_ac].ecbh006,"0","0","","","azz-00079",1) THEN
               NEXT FIELD ecbh006
            END IF 
 
 
 
            #add-point:AFTER FIELD ecbh006 name="input.a.page1.ecbh006"
            IF NOT cl_null(g_ecbh_d[l_ac].ecbh006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecbh006
            #add-point:BEFORE FIELD ecbh006 name="input.b.page1.ecbh006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ecbh006
            #add-point:ON CHANGE ecbh006 name="input.g.page1.ecbh006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecbh007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbh_d[l_ac].ecbh007,"0","0","","","azz-00079",1) THEN
               NEXT FIELD ecbh007
            END IF 
 
 
 
            #add-point:AFTER FIELD ecbh007 name="input.a.page1.ecbh007"
            IF NOT cl_null(g_ecbh_d[l_ac].ecbh007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecbh007
            #add-point:BEFORE FIELD ecbh007 name="input.b.page1.ecbh007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ecbh007
            #add-point:ON CHANGE ecbh007 name="input.g.page1.ecbh007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.ecbh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecbh001
            #add-point:ON ACTION controlp INFIELD ecbh001 name="input.c.page1.ecbh001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ecbh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecbh002
            #add-point:ON ACTION controlp INFIELD ecbh002 name="input.c.page1.ecbh002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ecbh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecbh003
            #add-point:ON ACTION controlp INFIELD ecbh003 name="input.c.page1.ecbh003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ecbh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecbh004
            #add-point:ON ACTION controlp INFIELD ecbh004 name="input.c.page1.ecbh004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ecbh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecbh005
            #add-point:ON ACTION controlp INFIELD ecbh005 name="input.c.page1.ecbh005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ecbh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecbh006
            #add-point:ON ACTION controlp INFIELD ecbh006 name="input.c.page1.ecbh006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ecbh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecbh007
            #add-point:ON ACTION controlp INFIELD ecbh007 name="input.c.page1.ecbh007"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         ON ROW CHANGE
            UPDATE aecm200_05_temp SET ecbh006 = g_ecbh_d[l_ac].ecbh006,
                                       ecbh007 = g_ecbh_d[l_ac].ecbh007             
             WHERE ecbh004 = g_ecbh_d[l_ac].ecbh004
               AND ecbh005 = g_ecbh_d[l_ac].ecbh005
                     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "UPDATE:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ecbh_d[l_ac].* = g_ecbh_d_t.*
            END IF
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
 
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      AFTER DIALOG
         LET l_count = 0
         SELECT COUNT(*) INTO l_count
           FROM aecm200_05_temp
          WHERE ecbh001 = g_ecbb.ecbh001
            AND ecbh002 = g_ecbb.ecbh002
            AND ecbh003 = g_ecbb.ecbh003
            AND ( ecbh006 <= 0 OR ecbh007 <= 0)
         
         IF l_count > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "aec-00054"
            #LET g_errparam.extend = "UPDATE:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CONTINUE DIALOG 
         END IF
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
 
   #add-point:畫面關閉前 name="input.before_close"
   DROP TABLE aecm200_05_temp
   IF NOT INT_FLAG  THEN
      CALL aecm200_05_ins_ecbh() RETURNING l_success
   END IF
   LET INT_FLAG = FALSE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aecm200_05 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200_05.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aecm200_05.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aecm200_05_cre_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 2016/01/15 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_05_cre_tmp()
DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
#   DROP TABLE aecm200_05_temp;
   CREATE TEMP TABLE aecm200_05_temp(
       ecbh001   LIKE ecbh_t.ecbh001,
       ecbh002   LIKE ecbh_t.ecbh002,
       ecbh003   LIKE ecbh_t.ecbh003,
       ecbh004   LIKE ecbh_t.ecbh004,
       ecbh005   LIKE ecbh_t.ecbh005,
       ecbh006   LIKE ecbh_t.ecbh006,
       ecbh007   LIKE ecbh_t.ecbh007
                     )
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'CREATE'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aecm200_05_display_ecbb()
   
   CALL s_desc_get_item_desc(g_ecbb.ecbh001) RETURNING g_ecbb.ecbh001_desc,g_ecbb.ecbh001_desc_1
   CALL s_desc_get_acc_desc('1103',g_ecbb.ecbb037) RETURNING g_ecbb.ecbb037_desc
   CALL s_desc_get_acc_desc('1103',g_ecbb.ecbb038) RETURNING g_ecbb.ecbb038_desc
   
   SELECT ecba003 INTO g_ecbb.ecbh002_desc
     FROM ecba_t
    WHERE ecbaent = g_enterprise
      AND ecbasite = g_site     #160414-00003#1 add
      AND ecba001 = g_ecbb.ecbh001
      AND ecba002 = g_ecbb.ecbh002
   
   DISPLAY BY NAME g_ecbb.ecbh001
   DISPLAY BY NAME g_ecbb.ecbh001_desc
   DISPLAY BY NAME g_ecbb.ecbh001_desc_1
   DISPLAY BY NAME g_ecbb.ecbh002
   DISPLAY BY NAME g_ecbb.ecbh002_desc
   DISPLAY BY NAME g_ecbb.ecbh003
   DISPLAY BY NAME g_ecbb.ecbb037
   DISPLAY BY NAME g_ecbb.ecbb037_desc
   DISPLAY BY NAME g_ecbb.ecbb038
   DISPLAY BY NAME g_ecbb.ecbb038_desc
END FUNCTION

PRIVATE FUNCTION aecm200_05_b_fill()
#add-point:b_fill段define(客製用)
   DEFINE l_sql        STRING
   
   LET l_sql = " SELECT ecbh001,ecbh002,ecbh003,ecbh004,ecbh005,ecbh006,ecbh007,t0.mrba005,t1.mrba005 ",
               "   FROM aecm200_05_temp ",
               " LEFT OUTER JOIN mrba_t t0 ON t0.mrbaent = '",g_enterprise,"' AND t0.mrbasite = '",g_site,"' AND t0.mrba001 = ecbh004 ",
               " LEFT OUTER JOIN mrba_t t1 ON t1.mrbaent = '",g_enterprise,"' AND t1.mrbasite = '",g_site,"' AND t1.mrba001 = ecbh005 ",
               " ORDER BY ecbh004,ecbh005 "

   PREPARE aecm200_05_b_pre FROM l_sql
   DECLARE aecm200_05_b_cs CURSOR FOR aecm200_05_b_pre

   CALL g_ecbh_d.clear()
   LET l_ac = 1
   FOREACH aecm200_05_b_cs INTO g_ecbh_d[l_ac].ecbh001,g_ecbh_d[l_ac].ecbh002,g_ecbh_d[l_ac].ecbh003,
                                g_ecbh_d[l_ac].ecbh004,g_ecbh_d[l_ac].ecbh005,g_ecbh_d[l_ac].ecbh006,
                                g_ecbh_d[l_ac].ecbh007,g_ecbh_d[l_ac].ecbh004_desc,g_ecbh_d[l_ac].ecbh005_desc
                                
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF


      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET l_ac = l_ac - 1
   CALL g_ecbh_d.deleteElement(g_ecbh_d.getLength())
   LET g_rec_b = l_ac
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE aecm200_05_b_cs
   FREE aecm200_05_b_pre
END FUNCTION

################################################################################
# Descriptions...: 將tmep資料寫入ecbh
# Memo...........:
# Usage..........: CALL aecm200_05_ins_ecbh()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 2016/01/20 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_05_ins_ecbh()
DEFINE r_success   LIKE type_t.num5
DEFINE l_i         LIKE type_t.num10
   LET r_success = TRUE
   
   #先將原始資料刪除(以此次維護為主)
   DELETE FROM ecbh_t
         WHERE ecbhent = g_enterprise
           AND ecbhsite = g_site
           AND ecbh001 = g_ecbb.ecbh001
           AND ecbh002 = g_ecbb.ecbh002
           AND ecbh003 = g_ecbb.ecbh003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "DELETE:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   FOR l_i = 1 TO g_ecbh_d.getLength()
      INSERT INTO ecbh_t (ecbhent,ecbhsite,ecbh001,ecbh002,ecbh003,ecbh004,ecbh005,ecbh006,ecbh007)
                  VALUES (g_enterprise,g_site,g_ecbh_d[l_i].ecbh001,
                          g_ecbh_d[l_i].ecbh002,g_ecbh_d[l_i].ecbh003,g_ecbh_d[l_i].ecbh004,
                          g_ecbh_d[l_i].ecbh005,g_ecbh_d[l_i].ecbh006,g_ecbh_d[l_i].ecbh007)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         EXIT FOR
      END IF
   END FOR
   RETURN r_success
END FUNCTION

 
{</section>}
 
