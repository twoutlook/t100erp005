#該程式未解開Section, 採用最新樣板產出!
{<section id="abmt301_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-01-24 16:27:09), PR版次:0002(2014-07-16 18:15:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000194
#+ Filename...: abmt301_01
#+ Description: 主件整批產生
#+ Creator....: 02482(2013-08-27 16:02:48)
#+ Modifier...: 02482 -SD/PR- 02295
 
{</section>}
 
{<section id="abmt301_01.global" >}
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
 
{<section id="abmt301_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_bmba001                  LIKE bmba_t.bmba001
DEFINE g_bmba003                  LIKE bmba_t.bmba003
 TYPE type_g_bmba_d        RECORD
       sel           LIKE type_t.chr1,
       bmba001       LIKE bmba_t.bmba002,
       bmba001_desc  LIKE type_t.chr80,
       bmba001_desc1 LIKE type_t.chr80,
       bmba002       LIKE bmba_t.bmba003
       END RECORD

DEFINE g_bmba_d          DYNAMIC ARRAY OF type_g_bmba_d
DEFINE g_bmba_d_t        type_g_bmba_d
DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE l_allow_insert    LIKE type_t.num5        #可新增否 
DEFINE l_allow_delete    LIKE type_t.num5        #可刪除否 
DEFINE l_wc              STRING
DEFINE l_sql             STRING
DEFINE l_ac2             LIKE type_t.num5
DEFINE l_ac2_t           LIKE type_t.num5
DEFINE l_rec_b           LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5
DEFINE g_bmba005         DATETIME YEAR TO SECOND
DEFINE g_bmfadocno       LIKE bmfa_t.bmfadocno
#end add-point
 
{</section>}
 
{<section id="abmt301_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="abmt301_01.other_dialog" >}

 
{</section>}
 
{<section id="abmt301_01.other_function" readonly="Y" >}
#單身選擇
PRIVATE FUNCTION abmt301_01_b()
DEFINE l_i       LIKE type_t.num5

    LET l_ac2 = 1
    INPUT ARRAY g_bmba_d WITHOUT DEFAULTS FROM s_detail1.*
        ATTRIBUTE(COUNT=l_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                APPEND ROW=l_allow_insert)

        BEFORE INPUT

        BEFORE ROW
            LET l_ac2 = ARR_CURR()
            LET g_bmba_d_t.* = g_bmba_d[l_ac2].*

        AFTER ROW
           LET l_ac2 = ARR_CURR()
           LET l_ac2_t = l_ac2
           IF INT_FLAG THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 9001
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()

              LET INT_FLAG = 0
              LET g_bmba_d[l_ac2].* = g_bmba_d_t.*
              EXIT INPUT
           END IF

        ON ACTION sel_yes
           FOR l_i = 1 TO l_rec_b    #將所有的設為選擇
               LET g_bmba_d[l_i].sel = 'Y'
           END FOR
           
        ON ACTION sel_no
           FOR l_i = 1 TO l_rec_b    #將所有的設為選擇
               LET g_bmba_d[l_i].sel = 'N'
           END FOR
           
        ON ACTION CONTROLR
            CALL cl_show_req_fields()

        ON ACTION CONTROLG
            CALL cl_cmdask()
           
        #公用action
         ON ACTION accept
            LET INT_FLAG = FALSE
            ACCEPT INPUT
            
         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT INPUT
            
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT INPUT
   
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT INPUT
            
        AFTER INPUT
         
        IF NOT INT_FLAG THEN
           CALL abmt301_01_ins()
        ELSE
           LET INT_FLAG = FALSE         
        END IF 
    END INPUT
END FUNCTION
#單身資料填充
PRIVATE FUNCTION abmt301_01_b_fill()
   LET l_sql = " SELECT DISTINCT 'Y',bmba001,'','',bmba002",
               "   FROM bmaa_t,bmba_t ",
               "  WHERE bmbaent =  '",g_enterprise,"' ",
               "    AND bmbasite = '",g_site,"' ",
               "    AND bmaaent = bmbaent AND bmaasite = bmbasite ",
               "    AND bmba001 = bmaa001 AND bmba002 = bmaa002 ",
               "    AND bmaastus = 'Y' ",
               "    AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= '",g_bmba005,"'",
               "    AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > '",g_bmba005,"' OR bmba006 IS NULL) ",
               "    AND bmba019 <> '2' ",
               "    AND ",l_wc CLIPPED ,
               "  ORDER BY bmba001 "
   PREPARE abmt301_01_pb FROM l_sql 
   DECLARE abmt301_01_curs CURSOR FOR abmt301_01_pb

   CALL g_bmba_d.clear()
   LET l_ac2 = 1
   FOREACH abmt301_01_curs INTO g_bmba_d[l_ac2].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_bmba_d[l_ac2].bmba001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND  imaal001 = ? AND imaal002 = '"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_bmba_d[l_ac2].bmba001_desc = g_rtn_fields[1]
      LET g_bmba_d[l_ac2].bmba001_desc1 = g_rtn_fields[2]
      DISPLAY BY NAME g_bmba_d[l_ac2].bmba001_desc
      DISPLAY BY NAME g_bmba_d[l_ac2].bmba001_desc1

      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_bmba_d.deleteElement(g_bmba_d.getLength())
   LET l_rec_b = l_ac2 - 1
   DISPLAY l_rec_b TO FORMONLY.h_count
   CLOSE abmt301_01_curs
   FREE abmt301_01_pb
END FUNCTION
#主件整批產生入口
PUBLIC FUNCTION abmt301_01(p_bmfadocno,p_bmba005)
DEFINE p_bmba005         DATETIME YEAR TO SECOND
DEFINE p_bmfadocno       LIKE bmfa_t.bmfadocno

   LET g_bmba005 = p_bmba005
   LET g_bmfadocno = p_bmfadocno
   WHENEVER ERROR CALL cl_err_msg_log

   #畫面開啟 (identifier)
   OPEN WINDOW w_abmt301_01 WITH FORM cl_ap_formpath("abm","abmt301_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         CONSTRUCT BY NAME l_wc ON bmba001,bmba003
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
   
            ON ACTION controlp INFIELD bmba001
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "bmaastus = 'Y'"
               CALL q_bmaa001()
               LET g_bmba001 = g_qryparam.return1
               LET g_qryparam.where = ""
               DISPLAY g_bmba001 TO bmba001
   
            ON ACTION controlp INFIELD bmba003
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
               CALL q_bmba003()
               LET g_bmba003 = g_qryparam.return1
               DISPLAY g_bmba003 TO bmba003
   
         END CONSTRUCT
   
         #公用action
         ON ACTION accept
            LET INT_FLAG = FALSE
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
   
      IF NOT INT_FLAG THEN
         CALL abmt301_01_b_fill()
         IF NOT cl_null(l_rec_b) AND l_rec_b > 0 THEN 
            CALL abmt301_01_b()
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'abm-00028'
            LET g_errparam.extend = l_wc
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CONTINUE WHILE
         END IF
      ELSE
         LET INT_FLAG = FALSE         
      END IF 
      
      EXIT WHILE
      
   END WHILE
   #畫面關閉
   CLOSE WINDOW w_abmt301_01
END FUNCTION
#+整批新增
PRIVATE FUNCTION abmt301_01_ins()
DEFINE l_n           LIKE type_t.num5
DEFINE l_n1          LIKE type_t.num5
   FOR l_n = 1 TO g_bmba_d.getLength()
       IF g_bmba_d[l_n].sel = 'Y' THEN
          LET l_n1 = 0
          SELECT COUNT(*) INTO l_n1
            FROM bmfp_t
           WHERE bmfpent =  g_enterprise
             AND bmfpsite = g_site
             AND bmfpdocno = g_bmfadocno
             AND bmfp002 = g_bmba_d[l_n].bmba001
             AND bmfp003 = g_bmba_d[l_n].bmba002
          IF l_n1 = 0 THEN
             INSERT INTO bmfp_t(bmfpent,bmfpsite,bmfpdocno,bmfp002,bmfp003)
                         VALUES(g_enterprise,g_site,g_bmfadocno,g_bmba_d[l_n].bmba001,g_bmba_d[l_n].bmba002)
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'ins_bmfp'
                LET g_errparam.popup = TRUE
                CALL cl_err()

                EXIT FOR
             END IF
          END IF
       END IF
   END FOR
END FUNCTION

 
{</section>}
 
