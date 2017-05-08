#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr501_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-12-22 15:43:50), PR版次:0003(2016-12-22 15:57:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: axmr501_x01
#+ Description: ...
#+ Creator....: 07024(2016-04-21 10:29:31)
#+ Modifier...: 08993 -SD/PR- 08993
 
{</section>}
 
{<section id="axmr501_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#       SQL中，目前狀態各代碼所代表的字
#       X1:'訂單待確認'    X2:'訂單留置'      X3:'訂單作廢'      X4:'訂單被拒'      X5：'訂單抽單'     G1:'已出貨'
#       G2:'待出貨'        G3:'轉出貨通知'    S1:'待開工單'      S2:'工單待發料'    S3:'生產製造'      S4:'入庫申請'
#       S5:'完工入庫'
#161207-00033#9   2016/12/22  By  08993     一次性交易對象名稱顯示要改抓pmak003
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr501_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr501_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr501_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr501_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr501_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr501_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr501_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr501_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr501_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr501_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmdadocno.xmda_t.xmdadocno,xmdadocdt.xmda_t.xmdadocdt,xmda004.xmda_t.xmda004,t9_pmaal004.pmaal_t.pmaal004,xmda002.xmda_t.xmda002,ooag_t_ooag011.ooag_t.ooag011,xmda003.xmda_t.xmda003,ooefl_t_ooefl003.ooefl_t.ooefl003,xmddseq.xmdd_t.xmddseq,xmddseq1.xmdd_t.xmddseq1,xmddseq2.xmdd_t.xmddseq2,xmdd001.xmdd_t.xmdd001,x_imaal_t_imaal003.imaal_t.imaal003,x_imaal_t_imaal004.imaal_t.imaal004,xmdd002.xmdd_t.xmdd002,l_xmdd002_desc.inaml_t.inaml004,xmdd011.xmdd_t.xmdd011,l_xmdg028.xmdg_t.xmdg028,l_xmdk001.xmdk_t.xmdk001,l_now_stus.type_t.chr50,l_next_stand.type_t.chr50" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr501_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr501_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="axmr501_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr501_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT xmdaent,xmdasite,xmdadocno,xmdadocdt,xmda004,
                    (SELECT pmaal004 FROM pmaal_t WHERE pmaal001 = xmda004 AND pmaalent = xmdaent AND pmaal002 = '",g_dlang,"') pmaal004,
                    xmda002,
                    (SELECT ooag011 FROM ooag_t WHERE ooag001 = xmda002 AND ooagent = xmdaent) ooag011,
                    xmda003,
                    (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = xmda003 AND ooeflent = xmdaent AND ooefl002 = '",g_dlang,"') ooefl003,
                    xmddseq,xmddseq1,xmddseq2,xmdd001,
                    (SELECT imaal003 FROM imaal_t WHERE imaal001 = xmdd001 AND imaalent = xmddent AND imaal002 = '",g_dlang,"') imaal003,
                    (SELECT imaal004 FROM imaal_t WHERE imaal001 = xmdd001 AND imaalent = xmddent AND imaal002 = '",g_dlang,"') imaal004,
                    xmdd002,
                    (SELECT inaml004 FROM inaml_t WHERE inamlent=xmddent AND inaml001=xmdd001 AND inaml002=xmdd002 AND inaml003='",g_dlang,"') inaml004,
                    xmdd011,
                    (SELECT MIN(xmdg028) FROM xmdg_t,xmdh_t WHERE xmdgent=xmdhent AND xmdgsite=xmdhsite AND xmdgdocno=xmdhdocno 
                                                              AND xmdddocno=xmdh001 AND xmddseq=xmdh002 AND xmddseq1=xmdh003 
                                                              AND xmddseq2=xmdh004 AND xmdg001 = '1' 
                                                              AND xmdgstus NOT IN ('D','R','X')) xmdg028,
                    (SELECT CASE WHEN MIN(a.xmdk001) IS NULL THEN MIN(b.xmdk001) ELSE MIN(a.xmdk001) END
                       FROM (SELECT xmdk_t.*,xmdl_t.* FROM xmdk_t,xmdl_t 
                                                      WHERE xmdkent=xmdlent AND xmdksite=xmdlsite AND xmdkdocno=xmdldocno
                                                        AND xmdddocno=xmdl003 AND xmddseq=xmdl004 AND xmddseq1=xmdl005 
                                                        AND xmddseq2=xmdl006 AND xmdkstus NOT IN ('D','R','X')) b
                       LEFT OUTER JOIN (SELECT xmdk_t.*,xmdl_t.* FROM xmdk_t,xmdl_t 
                                                                WHERE xmdkent=xmdlent AND xmdksite=xmdlsite AND xmdkdocno=xmdldocno
                                                                  AND xmdddocno=xmdl003 AND xmddseq=xmdl004 AND xmddseq1=xmdl005 
                                                                  AND xmddseq2=xmdl006 AND xmdkstus='S' 
                                                                  AND xmdkstus NOT IN ('D','R','X')) a
                                    ON a.xmdkent=b.xmdkent AND a.xmdksite=b.xmdksite AND a.xmdkdocno=b.xmdkdocno
                    ) xmdk001,",
                    #----↓目前狀態↓----
                    "(SELECT CASE WHEN xmdastus IN ('N','A','W') THEN
                                     'X1'
                                  WHEN xmdastus = 'H' THEN
                                     'X2'
                                  WHEN xmdastus = 'X' THEN
                                     'X3'
                                  WHEN xmdastus = 'R' THEN
                                     'X4'
                                  WHEN xmdastus = 'D' THEN
                                     'X5'
                                  WHEN k1.xmdkstus = 'S' THEN
                                     'G1'
                                  WHEN k6.xmdkstus <> 'S' THEN
                                     'G2'
                                  WHEN k2.xmdgstus IS NOT NULL THEN
                                     'G3'
                                  WHEN k3.sfaastus IS NULL THEN
                                     'S1'
                                  WHEN k3.sfaastus NOT IN ('C','F','M','E') THEN   
                                     'S2'
                                  WHEN k3.sfaastus='F' AND k3.sfaa004='1' AND (k3.sfaa049=0 OR k3.sfaa049 IS NULL) AND k3.sfbadocno IS NOT NULL THEN
                                     'S2'
                                  WHEN k3.sfaastus='F' AND k4.sfeastus IS NULL THEN
                                     'S3'
                                  WHEN k4.sfeastus<>'S' THEN
                                     'S4'
                                  WHEN k5.sfeastus='S' THEN
                                     'S5'                                 
                             END
                        FROM xmda_t x1 ",
                        #順序2：已出貨(=S)
                      " LEFT OUTER JOIN (SELECT xmdk_t.*,xmdl_t.* FROM xmdk_t,xmdl_t WHERE xmdkent=xmdlent AND xmdkdocno=xmdldocno AND xmdkstus='S') k1
                                     ON k1.xmdkent=x1.xmdaent AND k1.xmdksite=x1.xmdasite AND k1.xmdl003=xmdd_t.xmdddocno AND k1.xmdl004=xmdd_t.xmddseq 
                                    AND k1.xmdl005=xmdd_t.xmddseq1 AND k1.xmdl006=xmdd_t.xmddseq2 ",
                        #順序3：待出貨(<>S)
                      " LEFT OUTER JOIN (SELECT xmdk_t.*,xmdl_t.* FROM xmdk_t,xmdl_t WHERE xmdkent=xmdlent AND xmdkdocno=xmdldocno 
                                            AND xmdkstus NOT IN ('D','R','X','S') ) k6
                                     ON k6.xmdkent=x1.xmdaent AND k6.xmdksite=x1.xmdasite AND k6.xmdl003=xmdd_t.xmdddocno AND k6.xmdl004=xmdd_t.xmddseq 
                                    AND k6.xmdl005=xmdd_t.xmddseq1 AND k6.xmdl006=xmdd_t.xmddseq2 ",
                        #順序4：轉出貨通知
                      " LEFT OUTER JOIN (SELECT xmdg_t.*,xmdh_t.* FROM xmdg_t,xmdh_t WHERE xmdgent=xmdhent AND xmdgdocno=xmdhdocno
                                            AND xmdgstus NOT IN ('D','R','X') ) k2
                                     ON k2.xmdhent=x1.xmdaent AND k2.xmdhsite=x1.xmdasite AND k2.xmdh001=xmdd_t.xmdddocno AND k2.xmdh002=xmdd_t.xmddseq
                                    AND k2.xmdh003=xmdd_t.xmddseq1  AND k2.xmdh004=xmdd_t.xmddseq2 ",
                        #順序5：待開工單、順序6：工單待發料
                      " LEFT OUTER JOIN (SELECT sfaa_t.*,sfab_t.*,sfba_t.* FROM sfaa_t 
                                                                           LEFT OUTER JOIN sfba_t on sfaaent=sfbaent AND sfaasite=sfbasite AND sfaadocno=sfbadocno AND sfba009 = 'N'
                                                                               ,sfab_t 
                                                                          WHERE sfaaent=sfabent AND sfaasite=sfabsite AND sfaadocno=sfabdocno AND sfab001='2' AND sfaastus NOT IN ('D','R','X') ) k3
                                     ON k3.sfabent=x1.xmdaent AND k3.sfabsite=x1.xmdasite AND k3.sfab002=xmdd_t.xmdddocno AND k3.sfab003=xmdd_t.xmddseq  AND k3.sfab004=xmdd_t.xmddseq1
                                    AND k3.sfab005=xmdd_t.xmddseq2 ",
                        #順序7：生產製造、順序8：入庫申請
                      " LEFT OUTER JOIN (SELECT sfea_t.*,sfeb_t.* FROM sfea_t,sfeb_t WHERE sfeaent=sfebent AND sfeadocno=sfebdocno AND sfeastus NOT IN ('D','R','X') ) k4
                                     ON k4.sfebent=k3.sfaaent AND k4.sfebsite=k3.sfaasite AND k4.sfeb001=k3.sfaadocno ",
                        #順序9：完工入庫
                      " LEFT OUTER JOIN (SELECT sfea_t.*,sfec_t.* FROM sfea_t,sfec_t WHERE sfeaent=sfecent AND sfeadocno=sfecdocno AND sfeastus NOT IN ('D','R','X') ) k5
                                     ON k5.sfecent=k3.sfaaent AND k5.sfecsite=k3.sfaasite AND k5.sfec001=k3.sfaadocno 
                        WHERE xmda_t.xmdaent = x1.xmdaent AND xmda_t.xmdasite = x1.xmdasite AND xmda_t.xmdadocno = x1.xmdadocno AND ROWNUM=1
                    ),",
                    #----↑目前狀態↑----
                    "NULL"
                    
#   #end add-point
#   LET g_select = " SELECT xmdaent,xmdasite,xmdadocno,xmdadocdt,xmda004,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmda_t.xmda004 AND pmaal_t.pmaalent = xmda_t.xmdaent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),xmda002,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmda_t.xmda002 AND ooag_t.ooagent = xmda_t.xmdaent), 
#       xmda003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmda_t.xmda003 AND ooefl_t.ooeflent = xmda_t.xmdaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),xmddseq,xmddseq1,xmddseq2,xmdd001,x.imaal_t_imaal003,x.imaal_t_imaal004,xmdd002, 
#       NULL,xmdd011,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM xmda_t,xmdd_t"
#   #end add-point
#    LET g_from = " FROM xmda_t LEFT OUTER JOIN ( SELECT xmdd_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdd_t.xmdd001 AND imaal_t.imaalent = xmdd_t.xmddent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = xmdd_t.xmdd001 AND imaal_t.imaalent = xmdd_t.xmddent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM xmdd_t ) x  ON xmda_t.xmdaent = x.xmddent AND xmda_t.xmdadocno  
#        = x.xmdddocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE xmdaent = xmddent AND xmdadocno = xmdddocno AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY xmdadocno,xmdadocdt,xmddseq,xmddseq1,xmddseq2"
   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE axmr501_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr501_x01_curs CURSOR FOR axmr501_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr501_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr501_x01_ins_data()
DEFINE sr RECORD 
   xmdaent LIKE xmda_t.xmdaent, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmda004 LIKE xmda_t.xmda004, 
   t9_pmaal004 LIKE pmaal_t.pmaal004, 
   xmda002 LIKE xmda_t.xmda002, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   xmda003 LIKE xmda_t.xmda003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   xmddseq LIKE xmdd_t.xmddseq, 
   xmddseq1 LIKE xmdd_t.xmddseq1, 
   xmddseq2 LIKE xmdd_t.xmddseq2, 
   xmdd001 LIKE xmdd_t.xmdd001, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmdd002 LIKE xmdd_t.xmdd002, 
   l_xmdd002_desc LIKE inaml_t.inaml004, 
   xmdd011 LIKE xmdd_t.xmdd011, 
   l_xmdg028 LIKE xmdg_t.xmdg028, 
   l_xmdk001 LIKE xmdk_t.xmdk001, 
   l_now_stus LIKE type_t.chr50, 
   l_next_stand LIKE type_t.chr50
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE  l_msg1   STRING
DEFINE  l_msg2   STRING
DEFINE  l_msg3   STRING
DEFINE  l_msg4   STRING
DEFINE  l_msg5   STRING
DEFINE  l_msg6   STRING
DEFINE  l_msg7   STRING
DEFINE  l_msg8   STRING
DEFINE  l_msg9   STRING
DEFINE  l_msg10  STRING
DEFINE  l_msg11  STRING
DEFINE  l_msg12  STRING
DEFINE  l_msg13  STRING
DEFINE  r_pmak003  LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#9 add
DEFINE  l_pmaa004  LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#9 add
DEFINE  l_sql     STRING                                     #161207-00033#9 add

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    CALL cl_getmsg('axm-00762',g_lang) RETURNING l_msg1  #訂單待確認
    CALL cl_getmsg('axm-00763',g_lang) RETURNING l_msg2  #訂單留置
    CALL cl_getmsg('axm-00764',g_lang) RETURNING l_msg3  #訂單作廢
    CALL cl_getmsg('axm-00765',g_lang) RETURNING l_msg4  #訂單被拒
    CALL cl_getmsg('axm-00766',g_lang) RETURNING l_msg5  #訂單抽單
    CALL cl_getmsg('axm-00767',g_lang) RETURNING l_msg6  #已出貨
    CALL cl_getmsg('axm-00768',g_lang) RETURNING l_msg7  #待出貨
    CALL cl_getmsg('axm-00769',g_lang) RETURNING l_msg8  #轉出貨通知
    CALL cl_getmsg('axm-00770',g_lang) RETURNING l_msg9  #待開工單
    CALL cl_getmsg('axm-00771',g_lang) RETURNING l_msg10 #工單待發料
    CALL cl_getmsg('axm-00772',g_lang) RETURNING l_msg11 #生產製造
    CALL cl_getmsg('axm-00773',g_lang) RETURNING l_msg12 #入庫申請
    CALL cl_getmsg('axm-00774',g_lang) RETURNING l_msg13 #完工入庫

    #161207-00033#9-s add
    LET l_sql = "SELECT pmaa004 FROM pmaa_t        ",
                " WHERE pmaaent ='",g_enterprise,"'",
                "   AND pmaa001 = ?                "
    PREPARE axmr501_x01_prep FROM l_sql
    #161207-00033#9-e add
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr501_x01_curs INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       #161207-00033#9-s add
       EXECUTE axmr501_x01_prep USING sr.xmda004 INTO l_pmaa004
       IF l_pmaa004 = '2' THEN   #2.一次性交易對象
          #一次性交易對象全名
          CALL s_desc_axm_get_oneturn_guest_desc('1',sr.xmdadocno)
               RETURNING r_pmak003
          
          IF NOT cl_null(r_pmak003) THEN
             LET sr.t9_pmaal004 = r_pmak003
          END IF
       END IF
       #161207-00033#9-e add  
       CASE sr.l_now_stus
          WHEN 'X1' #訂單待確認
             LET sr.l_now_stus = l_msg1
             LET sr.l_next_stand = l_msg9
          WHEN 'X2' #訂單留置
             LET sr.l_now_stus = l_msg2
             LET sr.l_next_stand = '--'
          WHEN 'X3' #訂單作廢
             LET sr.l_now_stus = l_msg3
             LET sr.l_next_stand = '--'
          WHEN 'X4' #訂單被拒
             LET sr.l_now_stus = l_msg4
             LET sr.l_next_stand = '--'
          WHEN 'X5' #訂單抽單
             LET sr.l_now_stus = l_msg5
             LET sr.l_next_stand = '--'
          WHEN 'G1' #已出貨
             LET sr.l_now_stus = l_msg6
             LET sr.l_next_stand = '--'
          WHEN 'G2' #待出貨
             LET sr.l_now_stus = l_msg7
             LET sr.l_next_stand = l_msg6
          WHEN 'G3' #轉出貨通知
             LET sr.l_now_stus = l_msg8
             LET sr.l_next_stand = l_msg7
          WHEN 'S1' #待開工單
             LET sr.l_now_stus = l_msg9
             LET sr.l_next_stand = l_msg10
          WHEN 'S2' #工單待發料
             LET sr.l_now_stus = l_msg10
             LET sr.l_next_stand = l_msg11
          WHEN 'S3' #生產製造
             LET sr.l_now_stus = l_msg11
             LET sr.l_next_stand = l_msg12
          WHEN 'S4' #入庫申請
             LET sr.l_now_stus = l_msg12
             LET sr.l_next_stand = l_msg13
          WHEN 'S5' #完工入庫
             LET sr.l_now_stus = l_msg13
             LET sr.l_next_stand = l_msg8
       
       END CASE
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmdadocno,sr.xmdadocdt,sr.xmda004,sr.t9_pmaal004,sr.xmda002,sr.ooag_t_ooag011,sr.xmda003,sr.ooefl_t_ooefl003,sr.xmddseq,sr.xmddseq1,sr.xmddseq2,sr.xmdd001,sr.x_imaal_t_imaal003,sr.x_imaal_t_imaal004,sr.xmdd002,sr.l_xmdd002_desc,sr.xmdd011,sr.l_xmdg028,sr.l_xmdk001,sr.l_now_stus,sr.l_next_stand
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr501_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmr501_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr501_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axmr501_x01.other_function" readonly="Y" >}

 
{</section>}
 
