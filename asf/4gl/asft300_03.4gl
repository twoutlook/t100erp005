#該程式未解開Section, 採用最新樣板產出!
{<section id="asft300_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-01-07 19:15:08), PR版次:0005(2016-09-06 16:14:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000172
#+ Filename...: asft300_03
#+ Description: SET替代
#+ Creator....: 01258(2014-01-06 09:58:42)
#+ Modifier...: 01258 -SD/PR- 04441
 
{</section>}
 
{<section id="asft300_03.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160905-00022#1   160906  by whitney  如果備料已存在發料單不能刪除，將應發調整為0
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
PRIVATE TYPE type_g_bmga_d        RECORD
       check LIKE type_t.chr1, 
   check1 LIKE type_t.chr1, 
   bmga003 LIKE bmga_t.bmga003, 
   bmga003_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_bmga2_d RECORD
       sfaadocno LIKE type_t.chr20, 
   bmgb004 LIKE bmgb_t.bmgb004, 
   bmgb004_desc LIKE type_t.chr500, 
   bmgb004_desc_desc LIKE type_t.chr500, 
   bmgb005 LIKE bmgb_t.bmgb005, 
   bmgb005_desc LIKE type_t.chr500, 
   bmgb005_desc_desc LIKE type_t.chr500, 
   bmgb006 LIKE bmgb_t.bmgb006, 
   bmgb006_desc LIKE type_t.chr500, 
   bmgb007 LIKE bmgb_t.bmgb007, 
   bmgb007_desc LIKE type_t.chr500, 
   bmgb008 LIKE bmgb_t.bmgb008, 
   bmgb009 LIKE bmgb_t.bmgb009
       END RECORD

 TYPE type_g_bmga3_d RECORD
       sfbadocno LIKE type_t.chr20, 
   bmgc004 LIKE bmgc_t.bmgc004, 
   bmgc004_desc LIKE type_t.chr500, 
   bmgc004_desc_desc LIKE type_t.chr500, 
   bmgc005 LIKE bmgc_t.bmgc005, 
   bmgc005_desc LIKE type_t.chr500, 
   bmgc005_desc_desc LIKE type_t.chr500, 
   bmgc006 LIKE bmgc_t.bmgc006, 
   bmgc006_desc LIKE type_t.chr500, 
   bmgc007 LIKE bmgc_t.bmgc007, 
   bmgc007_desc LIKE type_t.chr500, 
   bmgc008 LIKE bmgc_t.bmgc008, 
   bmgc009 LIKE bmgc_t.bmgc009, 
   bmgc010 LIKE bmgc_t.bmgc010, 
   bmgc011 LIKE bmgc_t.bmgc011
       END RECORD
       
DEFINE g_bmga2_d   DYNAMIC ARRAY OF type_g_bmga2_d
DEFINE g_bmga2_d_t type_g_bmga2_d

DEFINE g_bmga3_d   DYNAMIC ARRAY OF type_g_bmga3_d
DEFINE g_bmga3_d_t type_g_bmga3_d


DEFINE g_sfaadocno           LIKE sfaa_t.sfaadocno
DEFINE g_sfaa010             LIKE sfaa_t.sfaa010
DEFINE g_sfaa011             LIKE sfaa_t.sfaa011
DEFINE g_sql                 STRING
DEFINE l_ac2                 LIKE type_t.num5
DEFINE g_rec_b2              LIKE type_t.num5
DEFINE l_ac3                 LIKE type_t.num5
DEFINE g_rec_b3              LIKE type_t.num5
#end add-point
 
DEFINE g_bmga_d          DYNAMIC ARRAY OF type_g_bmga_d
DEFINE g_bmga_d_t        type_g_bmga_d
 
 
DEFINE g_bmga001_t   LIKE bmga_t.bmga001    #Key值備份
DEFINE g_bmga002_t      LIKE bmga_t.bmga002    #Key值備份
DEFINE g_bmga003_t      LIKE bmga_t.bmga003    #Key值備份
 
 
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
 
{<section id="asft300_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION asft300_03(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_sfaadocno
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
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_j             LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft300_03 WITH FORM cl_ap_formpath("asf","asft300_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET g_sfaadocno = p_sfaadocno
   SELECT sfaa010,sfaa011 INTO g_sfaa010,g_sfaa011 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaasite = g_site 
      AND sfaadocno = g_sfaadocno
   CALL asft300_03_b_fill1()  
   CALL asft300_03_b_fill2(1)
   CALL asft300_03_b_fill3(1)
   WHILE TRUE

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_bmga_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL asft300_03_b_fill2(l_ac)
            CALL asft300_03_b_fill3(l_ac)
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check
            #add-point:BEFORE FIELD check name="input.b.page1.check"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check
            
            #add-point:AFTER FIELD check name="input.a.page1.check"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE check
            #add-point:ON CHANGE check name="input.g.page1.check"
            IF g_bmga_d[l_ac].check = 'Y' THEN
               LET l_flag1 = 'Y'
               FOR l_j = 1 TO g_rec_b2
                  IF cl_null(g_bmga2_d[l_j].sfaadocno) THEN
                     LET l_flag1 = 'N'
                     EXIT FOR
                  END IF              
               END FOR
               IF l_flag1 = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00061'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmga_d[l_ac].check = 'N'
                  NEXT FIELD check   
               END IF                   
               FOR l_j = 1 TO g_rec_b3
                  IF cl_null(g_bmga3_d[l_j].sfbadocno) THEN
                     LET l_flag1 = 'N'
                     EXIT FOR
                  END IF              
               END FOR
               IF l_flag1 = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00061'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmga_d[l_ac].check = 'N'
                  NEXT FIELD check   
               END IF
               FOR l_j = 1 TO g_rec_b
                  IF l_j != l_ac THEN   
                     LET g_bmga_d[l_j].check = 'N'
                     DISPLAY BY NAME g_bmga_d[l_j].check
                  END IF
               END FOR                  
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check1
            #add-point:BEFORE FIELD check1 name="input.b.page1.check1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check1
            
            #add-point:AFTER FIELD check1 name="input.a.page1.check1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE check1
            #add-point:ON CHANGE check1 name="input.g.page1.check1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga003
            
            #add-point:AFTER FIELD bmga003 name="input.a.page1.bmga003"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga003
            #add-point:BEFORE FIELD bmga003 name="input.b.page1.bmga003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmga003
            #add-point:ON CHANGE bmga003 name="input.g.page1.bmga003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.check
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check
            #add-point:ON ACTION controlp INFIELD check name="input.c.page1.check"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.check1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check1
            #add-point:ON ACTION controlp INFIELD check1 name="input.c.page1.check1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga003
            #add-point:ON ACTION controlp INFIELD bmga003 name="input.c.page1.bmga003"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_bmga2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)
         BEFORE ROW
            LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
           
      END DISPLAY
      
      DISPLAY ARRAY g_bmga3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3)
         BEFORE ROW
            LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
      END DISPLAY
      
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
      IF INT_FLAG THEN 
         LET INT_FLAG = 0
         EXIT WHILE
      ELSE
         IF NOT asft300_03_sfba() THEN
            CONTINUE WHILE
         ELSE
            EXIT WHILE
         END IF 
      END IF 
   END WHILE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asft300_03 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asft300_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asft300_03.other_function" readonly="Y" >}
##第一单身显示
PRIVATE FUNCTION asft300_03_b_fill1()
DEFINE l_n       LIKE type_t.num5

  CALL g_bmga_d.clear()
  LET g_sql = "SELECT 'N','N',bmga003,bmgal005 FROM bmga_t LEFT OUTER JOIN bmgal_t ON bmgaent = bmgalent AND bmgasite = bmgalsite ",
              "   AND bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"'",
              " WHERE bmgaent = '",g_enterprise,"' AND bmgasite = '",g_site,"' AND bmga001 = '",g_sfaa010,"' AND bmga002 = '",g_sfaa011,"'",
              "   AND ((bmga004 IS NULL AND bmga005 IS NULL) OR (bmga004 IS NOT NULL AND bmga004<='",g_today,"' AND (bmga005 IS NULL OR bmga005>'",g_today,"')))" 
  PREPARE asft300_03_pre1 FROM g_sql
  DECLARE asft300_03_cs1 CURSOR FOR asft300_03_pre1
  LET l_ac = 1
  FOREACH asft300_03_cs1 INTO g_bmga_d[l_ac].*
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        EXIT FOREACH
     END IF 
     
     SELECT COUNT(*) INTO l_n FROM sfba_t WHERE sfbaent = g_enterprise AND sfbasite = g_site
        AND sfbadocno = g_sfaadocno AND sfba027 = g_bmga_d[l_ac].bmga003 AND sfba026 != '1'
     IF l_n > 0 THEN
        LET g_bmga_d[l_ac].check1 = 'Y'
     END IF

     LET l_ac = l_ac + 1
     IF l_ac > g_max_rec THEN
        EXIT FOREACH
     END IF
  END FOREACH
  CALL g_bmga_d.deleteElement(g_bmga_d.getLength())
  LET g_rec_b = l_ac - 1
END FUNCTION
#单身二显示
PRIVATE FUNCTION asft300_03_b_fill2(p_ac)
DEFINE p_ac      LIKE type_t.num5
DEFINE l_sfaa021 LIKE sfaa_t.sfaa021
  CALL g_bmga2_d.clear()

  LET g_sql = "SELECT '',bmgb004,'','',bmgb005,'','',bmgb006,'',bmgb007,'',bmgb008,bmgb009 FROM bmgb_t",
              " INNER JOIN bmga_t ON bmgaent = bmgbent AND bmgasite = bmgbsite AND bmga001 = bmgb001 AND bmga002 = bmgb002 AND bmga003 = bmgb003",
              " WHERE bmgbent='",g_enterprise,"' AND bmgbsite='",g_site,"' AND bmgb001='",g_sfaa010,"' AND bmgb002='",g_sfaa011,"' AND bmgb003=?"
  PREPARE asft300_03_b_fill2_pre FROM g_sql
  DECLARE asft300_03_b_fill2_cs CURSOR FOR asft300_03_b_fill2_pre

  LET g_sql = "SELECT unique sfaadocno FROM sfba_t,sfaa_t WHERE sfaaent = sfbaent AND sfbasite = sfaasite AND sfbadocno = sfaadocno ",
               "   AND sfbaent='",g_enterprise,"' AND sfbasite='",g_site,"'",
               "   AND sfba001=? AND sfba006=? AND sfba002=? AND sfba003=? AND sfba004=? "             
  SELECT sfaa021 INTO l_sfaa021 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno=g_sfaadocno
  IF cl_null(l_sfaa021) THEN
     LET l_sfaa021 = g_sfaadocno
  END IF 
  LET g_sql = g_sql," AND (sfaadocno = '",l_sfaa021,"' OR sfaadocno IN(SELECT unique sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaasite = '",g_site,"' AND sfaa021='",l_sfaa021,"'))"  
  PREPARE asft300_03_b_fill2_pre1 FROM g_sql
              
  LET l_ac2 = 1
  FOREACH asft300_03_b_fill2_cs USING g_bmga_d[p_ac].bmga003 INTO g_bmga2_d[l_ac2].*
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        EXIT FOREACH
     END IF
     CALL asft300_03_bmgb_desc()
     EXECUTE asft300_03_b_fill2_pre1 USING g_bmga2_d[l_ac2].bmgb004,g_bmga2_d[l_ac2].bmgb005,g_bmga2_d[l_ac2].bmgb006,g_bmga2_d[l_ac2].bmgb007,g_bmga2_d[l_ac2].bmgb008 INTO g_bmga2_d[l_ac2].sfaadocno
     LET l_ac2 = l_ac2 + 1
     IF l_ac2 > g_max_rec THEN
        EXIT FOREACH
     END IF
  END FOREACH
  CALL g_bmga2_d.deleteElement(g_bmga2_d.getLength())
  LET g_rec_b2 = l_ac2 - 1
  
END FUNCTION
#第三单身显示
PRIVATE FUNCTION asft300_03_b_fill3(p_ac)
DEFINE p_ac      LIKE type_t.num5
DEFINE l_sfaa021 LIKE sfaa_t.sfaa021
  CALL g_bmga3_d.clear()

  LET g_sql = "SELECT '',bmgc004,'','',bmgc005,'','',bmgc006,'',bmgc007,'',bmgc008,bmgc009,bmgc010,bmgc011 FROM bmgc_t",
              " INNER JOIN bmga_t ON bmgaent = bmgcent AND bmgasite = bmgcsite AND bmga001 = bmgc001 AND bmga002 = bmgc002 AND bmga003 = bmgc003",
              " WHERE bmgcent='",g_enterprise,"' AND bmgcsite='",g_site,"' AND bmgc001='",g_sfaa010,"' AND bmgc002='",g_sfaa011,"' AND bmgc003=?"
  PREPARE asft300_03_b_fill3_pre FROM g_sql
  DECLARE asft300_03_b_fill3_cs CURSOR FOR asft300_03_b_fill3_pre
  
  LET g_sql = "SELECT UNIQUE sfaadocno FROM sfaa_t,sfba_t WHERE sfaaent=sfbaent AND sfaadocno=sfbadocno ",
              "   AND sfaaent='",g_enterprise,"' AND sfaasite='",g_site,"'",
              "   AND sfba001=? "
  SELECT sfaa021 INTO l_sfaa021 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno=g_sfaadocno
  IF cl_null(l_sfaa021) THEN
     LET l_sfaa021 = g_sfaadocno
  END IF 
  LET g_sql = g_sql," AND (sfaadocno = '",l_sfaa021,"' OR sfaadocno IN(SELECT unique sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaasite = '",g_site,"' AND sfaa021='",l_sfaa021,"'))"  
  PREPARE asft300_03_b_fill3_pre1 FROM g_sql
              
  LET l_ac3 = 1
  FOREACH asft300_03_b_fill3_cs USING g_bmga_d[p_ac].bmga003 INTO g_bmga3_d[l_ac3].*
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        EXIT FOREACH
     END IF
     CALL asft300_03_bmgc_desc()
     EXECUTE asft300_03_b_fill3_pre1 USING g_bmga3_d[l_ac3].bmgc004 INTO g_bmga3_d[l_ac3].sfbadocno
     LET l_ac3 = l_ac3 + 1
     IF l_ac3 > g_max_rec THEN
        EXIT FOREACH
     END IF
  END FOREACH
  CALL g_bmga3_d.deleteElement(g_bmga3_d.getLength())
  LET g_rec_b3 = l_ac3 - 1
END FUNCTION
#第二单身相关说明栏位带出
PRIVATE FUNCTION asft300_03_bmgb_desc()
   LET g_bmga2_d[l_ac2].bmgb004_desc = ''
   LET g_bmga2_d[l_ac2].bmgb004_desc_desc = ''
   LET g_bmga2_d[l_ac2].bmgb005_desc = ''
   LET g_bmga2_d[l_ac2].bmgb005_desc_desc = ''
   LET g_bmga2_d[l_ac2].bmgb006_desc  = ''
   LET g_bmga2_d[l_ac2].bmgb007_desc = ''
   SELECT imaal003,imaal004 INTO g_bmga2_d[l_ac2].bmgb004_desc,g_bmga2_d[l_ac2].bmgb004_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmga2_d[l_ac2].bmgb004
      AND imaal002 = g_lang
   SELECT imaal003,imaal004 INTO g_bmga2_d[l_ac2].bmgb005_desc,g_bmga2_d[l_ac2].bmgb005_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmga2_d[l_ac2].bmgb005
      AND imaal002 = g_lang
   SELECT oocql004 INTO g_bmga2_d[l_ac2].bmgb006_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '215'
      AND oocql002 = g_bmga2_d[l_ac2].bmgb006
      AND oocql003 = g_lang
   SELECT oocql004 INTO g_bmga2_d[l_ac2].bmgb007_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '221'
      AND oocql002 = g_bmga2_d[l_ac2].bmgb007
      AND oocql003 = g_lang    
END FUNCTION
#第三单身相关说明栏位显示
PRIVATE FUNCTION asft300_03_bmgc_desc()
   LET g_bmga3_d[l_ac3].bmgc004_desc = ''
   LET g_bmga3_d[l_ac3].bmgc004_desc_desc = ''
   LET g_bmga3_d[l_ac3].bmgc005_desc = ''
   LET g_bmga3_d[l_ac3].bmgc005_desc_desc = ''
   LET g_bmga3_d[l_ac3].bmgc006_desc = ''
   LET g_bmga3_d[l_ac3].bmgc007_desc = ''
   SELECT imaal003,imaal004 INTO g_bmga3_d[l_ac3].bmgc004_desc,g_bmga3_d[l_ac3].bmgc004_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmga3_d[l_ac3].bmgc004
      AND imaal002 = g_lang
   SELECT imaal003,imaal004 INTO g_bmga3_d[l_ac3].bmgc005_desc,g_bmga3_d[l_ac3].bmgc005_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmga3_d[l_ac3].bmgc005
      AND imaal002 = g_lang       
   SELECT oocql004 INTO g_bmga3_d[l_ac3].bmgc006_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '215'
      AND oocql002 = g_bmga3_d[l_ac3].bmgc006
      AND oocql003 = g_lang
   SELECT oocql004 INTO g_bmga3_d[l_ac3].bmgc007_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '221'
      AND oocql002 = g_bmga3_d[l_ac3].bmgc007
      AND oocql003 = g_lang  
END FUNCTION
#根据元件单身及替代料单身异动工单单身档
PRIVATE FUNCTION asft300_03_sfba()
DEFINE l_flag            LIKE type_t.chr1
DEFINE l_sfba            RECORD LIKE sfba_t.*
DEFINE l_i               LIKE type_t.num5
DEFINE l_j               LIKE type_t.num5
DEFINE l_sfaa004         LIKE sfaa_t.sfaa004
DEFINE l_sfaa012         LIKE sfaa_t.sfaa012
DEFINE l_sys             LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_n               LIKE type_t.num5
DEFINE l_ooba002         LIKE ooba_t.ooba002

  LET l_flag = 'N'
  FOR l_i = 1 TO g_rec_b
     IF g_bmga_d[l_i].check = 'Y' AND NOT cl_null(g_bmga_d[l_i].bmga003) THEN
        LET l_flag = 'Y'
        EXIT FOR
     END IF
  END FOR
  IF l_flag = 'N' THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'asf-00062'
     LET g_errparam.extend = ''
     LET g_errparam.popup = TRUE
     CALL cl_err()

     RETURN FALSE
  END IF 
  
  CALL asft300_03_b_fill2(l_i)
  CALL asft300_03_b_fill3(l_i)
  
  CALL s_transaction_begin()
  
  #群组未做SET取代，
  IF g_bmga_d[l_i].check1 = 'N' THEN
     FOR l_j = 1 TO g_rec_b2
        #SET替代時，如果該組合內有任一個項目已經有發料數量，則不允許再被SET替代  （还原也要判断）
        SELECT COUNT(*) INTO l_n FROM sfba_t WHERE sfbaent = g_enterprise AND sfbasite = g_site
           AND sfbadocno = g_bmga2_d[l_j].sfaadocno AND sfba006=g_bmga2_d[l_j].bmgb005 AND sfba002=g_bmga2_d[l_j].bmgb006
           AND sfba003=g_bmga2_d[l_j].bmgb007 AND sfba004=g_bmga2_d[l_j].bmgb008 AND sfba016 > 0
        IF l_n > 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'asf-00328'
           LET g_errparam.extend = g_bmga2_d[l_j].bmgb005
           LET g_errparam.popup = TRUE
           CALL cl_err()

           CALL s_transaction_end('N',0)
           RETURN FALSE
        END IF
           
        UPDATE sfba_t SET sfba023 = 0,sfba024=0,sfba013=0,sfba026='2',sfba027=g_bmga_d[l_i].bmga003 WHERE sfbaent=g_enterprise AND sfbasite=g_site
           AND sfbadocno=g_bmga2_d[l_j].sfaadocno AND sfba006=g_bmga2_d[l_j].bmgb005 AND sfba002=g_bmga2_d[l_j].bmgb006
           AND sfba003=g_bmga2_d[l_j].bmgb007 AND sfba004=g_bmga2_d[l_j].bmgb008
        IF SQLCA.SQLcode  THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd sfba_t"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           CALL s_transaction_end('N',0)
           RETURN FALSE
        END IF 
     END FOR
     
     FOR l_j = 1 TO g_rec_b3
        INITIALIZE l_sfba.* TO NULL
        SELECT MAX(sfbaseq) INTO l_sfba.sfbaseq FROM sfba_t WHERE sfbaent=g_enterprise AND sfbasite=g_site AND sfbadocno=g_bmga3_d[l_j].sfbadocno
        CALL s_aooi200_get_slip(g_bmga3_d[l_j].sfbadocno) RETURNING l_success,l_ooba002
        CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0049')  RETURNING l_sys
        IF cl_null(l_sys) OR l_sys = 0 THEN 
           LET l_sys = 1 
        END IF    
        IF cl_null(l_sfba.sfbaseq) THEN 
           LET l_sfba.sfbaseq = l_sys                 
        ELSE  
           LET l_sfba.sfbaseq = l_sfba.sfbaseq+l_sys
        END IF 
        LET l_sfba.sfbaent=g_enterprise
        LET l_sfba.sfbasite=g_site
        LET l_sfba.sfbadocno=g_bmga3_d[l_j].sfbadocno
        LET l_sfba.sfbaseq1=0
        LET l_sfba.sfba002=g_bmga3_d[l_j].bmgc006
        LET l_sfba.sfba003=g_bmga3_d[l_j].bmgc007
        LET l_sfba.sfba004=g_bmga3_d[l_j].bmgc008
        LET l_sfba.sfba005=g_bmga3_d[l_j].bmgc005
        LET l_sfba.sfba006=g_bmga3_d[l_j].bmgc005
        LET l_sfba.sfba007=0
        #160115-00002 by whitney modify start
        #LET l_sfba.sfba010=g_bmga3_d[l_j].bmgc009
        #LET l_sfba.sfba011=g_bmga3_d[l_j].bmgc010
        LET l_sfba.sfba010=0
        LET l_sfba.sfba011=0
        #160115-00002 by whitney modify end
        LET l_sfba.sfba012=0
        LET l_sfba.sfba015=0
        LET l_sfba.sfba016=0
        LET l_sfba.sfba017=0
        LET l_sfba.sfba018=0
        LET l_sfba.sfba024=0
        LET l_sfba.sfba025=0
        LET l_sfba.sfba026='3'
        LET l_sfba.sfba027=g_bmga_d[l_i].bmga003
        LET l_sfba.sfba028='N'
        SELECT sfaa004,sfaa012 INTO l_sfaa004,l_sfaa012 FROM sfaa_t WHERE sfaaent=g_enterprise AND sfaasite=g_site
           AND sfaadocno=g_bmga3_d[l_j].sfbadocno
        IF l_sfaa004='1' THEN
           LET l_sfba.sfba009='N'
        END IF 
        IF l_sfaa004='2' THEN
           LET l_sfba.sfba009='Y'
        END IF 
        LET l_sfba.sfba013=l_sfaa012*g_bmga3_d[l_j].bmgc009/g_bmga3_d[l_j].bmgc010
        LET l_sfba.sfba014=g_bmga3_d[l_j].bmgc011
        LET l_sfba.sfba022=1
        SELECT imae023 INTO l_sfba.sfba008 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=l_sfba.sfba006
        LET l_sfba.sfba001=g_bmga3_d[l_j].bmgc004
        LET l_sfba.sfba023=l_sfaa012*g_bmga3_d[l_j].bmgc009/g_bmga3_d[l_j].bmgc010
        #建议应发数量
        CALL s_asft300_03(l_sfba.sfba006,l_sfba.sfba013) RETURNING l_success,l_sfba.sfba013            
        LET l_sfba.sfba024 = l_sfba.sfba013 - l_sfba.sfba023
        INSERT INTO sfba_t VALUES(l_sfba.*)
        IF SQLCA.SQLcode  THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "ins sfba_t"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           CALL s_transaction_end('N',0)
           RETURN FALSE
        END IF 
     END FOR
  END IF
  
  #群组已做SET取代，群组替代还原
  IF g_bmga_d[l_i].check1 = 'Y' THEN
     FOR l_j = 1 TO g_rec_b3
        #SET替代時，如果該組合內有任一個項目已經有發料數量，則不允許再被SET替代  （还原也要判断）
        SELECT COUNT(*) INTO l_n FROM sfba_t WHERE sfbaent = g_enterprise AND sfbasite = g_site
           AND sfbadocno = g_bmga3_d[l_j].sfbadocno AND sfba026='3' AND sfba027=g_bmga_d[l_i].bmga003 AND sfba016 > 0 
        IF l_n > 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'asf-00328'
           LET g_errparam.extend = g_bmga2_d[l_j].bmgb005
           LET g_errparam.popup = TRUE
           CALL cl_err()

           CALL s_transaction_end('N',0)
           RETURN FALSE
        END IF
        
        #160905-00022#1-s
        LET l_n = 0
        SELECT COUNT(1) INTO l_n
          FROM sfba_t
         WHERE sfbaent = g_enterprise
           AND sfbasite = g_site
           AND sfbadocno = g_bmga3_d[l_j].sfbadocno
           AND sfba026 = '3'
           AND sfba027=g_bmga_d[l_i].bmga003
           AND EXISTS (SELECT 1 FROM sfdc_t WHERE sfdc001=sfbadocno AND sfdc002=sfbaseq AND sfdc003=sfbaseq1)
        IF l_n > 0 THEN
           UPDATE sfba_t
              SET sfba013 = 0
            WHERE sfbaent = g_enterprise
              AND sfbasite = g_site
              AND sfbadocno = g_bmga3_d[l_j].sfbadocno
              AND sfba026 = '3'
              AND sfba027=g_bmga_d[l_i].bmga003
           IF SQLCA.SQLcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "UPDATE sfba_t",SQLERRMESSAGE
              LET g_errparam.popup = TRUE
              CALL cl_err()
              CALL s_transaction_end('N',0)
              RETURN FALSE
           END IF
        ELSE
           DELETE FROM sfba_t WHERE sfbaent=g_enterprise AND sfbasite=g_site
              AND sfbadocno=g_bmga3_d[l_j].sfbadocno AND sfba026='3' AND sfba027=g_bmga_d[l_i].bmga003
           IF SQLCA.SQLcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "DELETE sfba_t",SQLERRMESSAGE
              LET g_errparam.popup = TRUE
              CALL cl_err()
              CALL s_transaction_end('N',0)
              RETURN FALSE
           END IF
        END IF
        #160905-00022#1-e
        
     END FOR
     FOR l_j = 1 TO g_rec_b2
        SELECT sfaa012 INTO l_sfaa012 FROM sfaa_t WHERE sfaaent=g_enterprise AND sfaasite=g_site
           AND sfaadocno=g_bmga2_d[l_j].sfaadocno
        SELECT sfba010,sfba011 INTO l_sfba.sfba010,l_sfba.sfba011 FROM sfba_t WHERE sfbaent=g_enterprise AND sfbasite=g_site
           AND sfbadocno=g_bmga2_d[l_j].sfaadocno AND sfba006=g_bmga2_d[l_j].bmgb005 AND sfba002=g_bmga2_d[l_j].bmgb006
           AND sfba003=g_bmga2_d[l_j].bmgb007 AND sfba004=g_bmga2_d[l_j].bmgb008 AND sfba026='2' AND sfba027=g_bmga_d[l_i].bmga003
        LET l_sfba.sfba023 = l_sfba.sfba010/l_sfba.sfba011*l_sfaa012
        #建议应发数量
        CALL s_asft300_03(g_bmga2_d[l_j].bmgb005,l_sfba.sfba023) RETURNING l_success,l_sfba.sfba013            
        LET l_sfba.sfba024 = l_sfba.sfba013 - l_sfba.sfba023
        UPDATE sfba_t SET sfba013 = l_sfba.sfba013,sfba023 = l_sfba.sfba023,sfba024 = l_sfba.sfba024,sfba026='1',sfba027='' 
         WHERE sfbaent=g_enterprise AND sfbasite=g_site
           AND sfbadocno=g_bmga2_d[l_j].sfaadocno AND sfba006=g_bmga2_d[l_j].bmgb005 AND sfba002=g_bmga2_d[l_j].bmgb006
           AND sfba003=g_bmga2_d[l_j].bmgb007 AND sfba004=g_bmga2_d[l_j].bmgb008 AND sfba026='2' AND sfba027=g_bmga_d[l_i].bmga003
        IF SQLCA.SQLcode  THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd sfba_t"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           CALL s_transaction_end('N',0)
           RETURN FALSE
        END IF 
     END FOR
  END IF 
  CALL s_transaction_end('Y',0)
  RETURN TRUE
END FUNCTION

 
{</section>}
 
