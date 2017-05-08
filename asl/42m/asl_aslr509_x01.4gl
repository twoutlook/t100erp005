#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr509_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-12 16:27:13), PR版次:0001(2016-12-12 17:24:24)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr509_x01
#+ Description: ...
#+ Creator....: 08172(2016-12-05 17:34:40)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="aslr509_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

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
       wc STRING                   #condiction
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aslr509_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr509_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  condiction
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
   LET g_rep_code = "aslr509_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr509_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr509_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr509_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr509_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr509_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr509_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr509_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inagent.inag_t.inagent,inagsite.inag_t.inagsite,l_inagsite.type_t.chr100,l_ooefl003.type_t.chr500,imaa001.imaa_t.imaa001,l_sku.type_t.chr100,l_imas003.imas_t.imas003,l_color.type_t.chr500,l_imaal003.type_t.chr500,imaa154.imaa_t.imaa154,imaa155.imaa_t.imaa155,l_imaa155_desc.gzcbl_t.gzcbl004,imaa133.imaa_t.imaa133,l_imaa133_desc.oocql_t.oocql004,l_rtaxl003_1.type_t.chr500,l_rtaxl003_2.type_t.chr500,l_rtaxl003_3.type_t.chr500,imaa116.imaa_t.imaa116,imaa127.imaa_t.imaa127,l_imaa127_desc.oocql_t.oocql004,imaa126.imaa_t.imaa126,l_imaa126_desc.oocql_t.oocql004,imaa132.imaa_t.imaa132,l_imaa132_desc.oocql_t.oocql004,imaa156.imaa_t.imaa156,l_imaa156_desc.gzcbl_t.gzcbl004,l_count.type_t.num20,l_money_sto.type_t.num20_6,l_money_pas.type_t.num20_6,l_money.type_t.num20_6,inag002.inag_t.inag002,l_sto.type_t.num20,l_pas.type_t.num20" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr509_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr509_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aslr509_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr509_x01_sel_prep()
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
   
   #end add-point
   LET g_select = " SELECT inagent,inagsite,NULL,NULL,imaa001,NULL,NULL,NULL,NULL,imaa154,imaa155,NULL, 
       imaa133,NULL,NULL,NULL,NULL,imaa116,imaa127,NULL,imaa126,NULL,imaa132,NULL,imaa156,NULL,0,0,0, 
       0,inag002,0,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM inag_t,imaa_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inag_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT inagent,inagsite,'',ooefl003,imaa001,'',",
               #颜色编码，颜色
               "        imas003,oocql004,",
               "        imaal003,imaa154,imaa155,",
               "        (SELECT DISTINCT gzcbl004 FROM gzcbl_t",
               "         WHERE gzcbl001='6940' AND gzcbl002=imaa155 AND gzcbl003='",g_lang,"') imaa155_desc,",
               "        imaa133,",
               "        (SELECT DISTINCT oocql004 FROM oocql_t",
               "          WHERE oocqlent=inagent AND oocql001='2007' AND oocql002 = imaa133 AND oocql003='",g_lang,"') imaa133_desc,",
               #大类
               "        rtaxl003 rtaxl003_1,",
               #中类
               "        (SELECT DISTINCT rtaxl003 FROM rtax_t,rtaxl_t",
               "          WHERE rtaxent=rtaxlent AND rtaxent=inagent AND rtax003=rtaxl001 AND rtax001=imaa009 AND rtaxl002='",g_lang,"') rtaxl003_2,",
               #小类
               "        (SELECT DISTINCT rtaxl003 FROM rtaxl_t",
               "          WHERE rtaxlent=inagent AND rtaxl001=imaa009 AND rtaxl002='",g_lang,"') rtaxl003_3,",
               "        imaa116,imaa127,",
               "        (SELECT DISTINCT oocql004 FROM oocql_t",
               "          WHERE oocqlent=inagent AND oocql001='2003' AND oocql002 = imaa127 AND oocql003='",g_lang,"') imaa127_desc,",
               "        imaa126,",
               "        (SELECT DISTINCT oocql004 FROM oocql_t",
               "          WHERE oocqlent=inagent AND oocql001='2002' AND oocql002 = imaa126 AND oocql003='",g_lang,"') imaa126_desc,",
               "        imaa132,",
               "        (SELECT DISTINCT oocql004 FROM oocql_t",
               "          WHERE oocqlent=inagent AND oocql001='2006' AND oocql002 = imaa132 AND oocql003='",g_lang,"') imaa132_desc,",
               "        imaa156,",
               "        (SELECT DISTINCT gzcbl004 FROM gzcbl_t",
               "         WHERE gzcbl001='6941' AND gzcbl002=imaa156 AND gzcbl003='",g_lang,"') imaa156_desc,",
               "        0,0,0,0,",
               "        inag002,sto,pas",
               "   FROM (SELECT inagent,inagsite,ooefl003,imaa001,imaa009,imas003,oocql004,imaal003,imaa154,imaa155,imaa133,",
               "                rtaxl003,imaa116,imaa127,imaa126,imaa132,imaa156,inag002,",
               #库存量
               "                SUM(COALESCE((CASE WHEN inaa140 <> '3' THEN inag009 ELSE 0 END),0)) sto,",
               #在途量
               "                SUM(COALESCE((CASE WHEN inaa140 = '3' THEN inag009 ELSE 0 END),0)) pas ",
               "           FROM inaa_t,inag_t",
               "                LEFT JOIN ooef_t ON ooefent=inagent AND ooef001=inagsite AND ooefstus='Y'",
               "                LEFT JOIN ooefl_t ON ooeflent=ooefent AND ooefl001=ooef001 AND ooefl002='",g_lang,"'",
               "                ,imaa_t",
               "                LEFT JOIN imaal_t ON imaalent=imaaent AND imaal001=imaa001 AND imaal002='",g_lang,"'",
               "                LEFT JOIN rtax_t ON rtaxent=imaaent AND rtax001=imaa009 AND rtaxstus='Y'",
               "                LEFT JOIN rtaxl_t ON rtaxent=rtaxlent AND rtax006=rtaxl001 AND rtaxl002='",g_lang,"'", 
               "                ,inam_t,imeb_t,imas_t",
               "                LEFT JOIN oocq_t ON oocqent=imasent AND oocq001='2148' AND oocq002=imas003 AND oocqstus='Y'",
               "                LEFT JOIN oocql_t ON oocqlent=oocqent AND oocql001=oocq001 AND oocql002=oocq002 AND oocql003='",g_lang,"'",
               "          WHERE inagent=imaaent AND inag001=imaa001",
               "            AND inaaent=inagent AND inaasite=inagsite AND inaa001=inag004 AND inaa008='Y'",
               "            AND imasent=imebent AND imasent=imaaent AND imas001=imaa001 AND imeb001=imaa005",
               "            AND imas002=imeb004 AND imeb002='1'",
               "            AND inament=inagent AND inam001=imaa001 AND inam002=inag002 AND inam003=imaa005 AND inam012=imas003",
               "            AND inagent=",g_enterprise,
               "            AND ",tm.wc,
               "          GROUP BY inagent,inagsite,ooefl003,imaa001,imaa009,imas003,oocql004,imaal003,imaa154,imaa155,imaa133,",
               "                   rtaxl003,imaa116,imaa127,imaa126,imaa132,imaa156,inag002)"
   #end add-point
   PREPARE aslr509_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr509_x01_curs CURSOR FOR aslr509_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr509_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr509_x01_ins_data()
DEFINE sr RECORD 
   inagent LIKE inag_t.inagent, 
   inagsite LIKE inag_t.inagsite, 
   l_inagsite LIKE type_t.chr100, 
   l_ooefl003 LIKE type_t.chr500, 
   imaa001 LIKE imaa_t.imaa001, 
   l_sku LIKE type_t.chr100, 
   l_imas003 LIKE imas_t.imas003, 
   l_color LIKE type_t.chr500, 
   l_imaal003 LIKE type_t.chr500, 
   imaa154 LIKE imaa_t.imaa154, 
   imaa155 LIKE imaa_t.imaa155, 
   l_imaa155_desc LIKE gzcbl_t.gzcbl004, 
   imaa133 LIKE imaa_t.imaa133, 
   l_imaa133_desc LIKE oocql_t.oocql004, 
   l_rtaxl003_1 LIKE type_t.chr500, 
   l_rtaxl003_2 LIKE type_t.chr500, 
   l_rtaxl003_3 LIKE type_t.chr500, 
   imaa116 LIKE imaa_t.imaa116, 
   imaa127 LIKE imaa_t.imaa127, 
   l_imaa127_desc LIKE oocql_t.oocql004, 
   imaa126 LIKE imaa_t.imaa126, 
   l_imaa126_desc LIKE oocql_t.oocql004, 
   imaa132 LIKE imaa_t.imaa132, 
   l_imaa132_desc LIKE oocql_t.oocql004, 
   imaa156 LIKE imaa_t.imaa156, 
   l_imaa156_desc LIKE gzcbl_t.gzcbl004, 
   l_count LIKE type_t.num20, 
   l_money_sto LIKE type_t.num20_6, 
   l_money_pas LIKE type_t.num20_6, 
   l_money LIKE type_t.num20_6, 
   inag002 LIKE inag_t.inag002, 
   l_sto LIKE type_t.num20, 
   l_pas LIKE type_t.num20
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_imaa005        LIKE imaa_t.imaa005      #特征组别
DEFINE l_inam012        LIKE inam_t.inam012      #特征一值
DEFINE l_inam014        LIKE inam_t.inam014      #特征二值
DEFINE l_inam018        LIKE inam_t.inam018      #特征四值
DEFINE l_imec003        LIKE imec_t.imec003      #特征值
DEFINE l_imecl005       LIKE imecl_t.imecl005    #特征说明
DEFINE l_imeb012        LIKE imeb_t.imeb012      #二维录入
DEFINE l_cnt2           LIKE type_t.num5 
DEFINE tok              base.StringTokenizer
DEFINE l_table          LIKE type_t.chr500
DEFINE l_count_merge    STRING
DEFINE l_money_merge    STRING
DEFINE l_sql            STRING
DEFINE l_inagent        LIKE inag_t.inagent
DEFINE l_inagsite       LIKE inag_t.inagsite
DEFINE l_inagsite_1     LIKE type_t.chr100
DEFINE l_inag002        LIKE inag_t.inag002
DEFINE l_sto_sum        LIKE type_t.num20
DEFINE l_pas_sum        LIKE type_t.num20
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr509_x01_curs INTO sr.*                               
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
       #SKU
       LET sr.l_sku = sr.imaa001,sr.l_imas003
       LET sr.l_inagsite = sr.inagsite
#       #库存量
#       SELECT SUM(inag009) INTO sr.l_sto
#         FROM inag_t 
#        WHERE inagent=sr.inagent
#          AND inagsite=sr.inagsite 
#          AND inag001=sr.imaa001
#          AND inag002=sr.inag002
#          AND EXISTS (SELECT 1 FROM inaa_t
#                       WHERE inaaent=inagent 
#                         AND inaasite=inagsite 
#                         AND inaa001=inag004
#                         AND inaa008='Y'
#                         AND inaa140<>'3')
#       #在途量
#       SELECT SUM(inag009) INTO sr.l_pas
#         FROM inag_t 
#        WHERE inagent=sr.inagent
#          AND inagsite=sr.inagsite 
#          AND inag001=sr.imaa001
#          AND inag002=sr.inag002
#          AND EXISTS (SELECT 1 FROM inaa_t
#                       WHERE inaaent=inagent 
#                         AND inaasite=inagsite 
#                         AND inaa001=inag004
#                         AND inaa008='Y'
#                         AND inaa140='3')
       #二维特征
       IF NOT cl_null(sr.inag002) THEN
          LET l_imaa005=NULL
          SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent=g_enterprise and imaa001=sr.imaa001
          LET l_inam012=NULL
          LET l_inam014=NULL
          LET l_inam018=NULL
          
          LET l_cnt2=1
          LET tok = base.StringTokenizer.createExt(sr.inag002,'_','',TRUE)
          WHILE tok.hasMoreTokens()
             LET l_imec003=tok.nextToken()
             LET l_imeb012='N'
             SELECT imeb012 INTO l_imeb012 FROM imeb_t
              WHERE imebent=g_enterprise AND imeb002=l_cnt2
                AND imeb001=l_imaa005
                
             CASE l_imeb012
             #纵向
             WHEN 'N'
               LET l_imecl005=NULL
               SELECT imecl005 INTO l_imecl005
                 FROM imec_t 
                 LEFT OUTER JOIN imecl_t ON imecent = imeclent AND imec001 = imecl001 
                                        AND imec002 = imecl002 AND imec003 = imecl003  AND imecl004 = g_lang
                WHERE imecent = g_enterprise AND imec001 = l_imaa005 AND imec002 = l_cnt2
                  AND imec003 = l_imec003 AND imecstus = 'Y'
               IF cl_null(l_inam012) THEN
                 LET l_inam012 = l_imecl005
               ELSE
                  LET l_inam012 = l_inam012,'/',l_imecl005
               END IF 
             #横向
             WHEN 'Y'
               LET l_imecl005=NULL
               SELECT imecl005 INTO l_imecl005
                 FROM imec_t 
                 LEFT OUTER JOIN imecl_t ON imecent = imeclent AND imec001 = imecl001 
                                        AND imec002 = imecl002 AND imec003 = imecl003  AND imecl004 = g_lang
                WHERE imecent = g_enterprise AND imec001 = l_imaa005 AND imec002 = l_cnt2
                  AND imec003 = l_imec003 AND imecstus = 'Y'
                LET l_inam014 = l_imecl005
             OTHERWISE
               EXIT WHILE
             END CASE 
             LET l_cnt2=l_cnt2+1
          END WHILE
        
          IF NOT cl_null(l_inam012) AND cl_null(l_inam014) THEN
            LET l_inam014 = "t-*"
          END IF
       END IF
       LET sr.inag002 = l_inam014      
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inagent,sr.inagsite,sr.l_inagsite,sr.l_ooefl003,sr.imaa001,sr.l_sku,sr.l_imas003,sr.l_color,sr.l_imaal003,sr.imaa154,sr.imaa155,sr.l_imaa155_desc,sr.imaa133,sr.l_imaa133_desc,sr.l_rtaxl003_1,sr.l_rtaxl003_2,sr.l_rtaxl003_3,sr.imaa116,sr.imaa127,sr.l_imaa127_desc,sr.imaa126,sr.l_imaa126_desc,sr.imaa132,sr.l_imaa132_desc,sr.imaa156,sr.l_imaa156_desc,sr.l_count,sr.l_money_sto,sr.l_money_pas,sr.l_money,sr.inag002,sr.l_sto,sr.l_pas
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr509_x01_execute"
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
    LET l_table = g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED
    LET l_count_merge = " MERGE INTO ",l_table," O",
                        " USING (SELECT inagent,inagsite,imaa001,l_sku,l_imas003,imaa154,imaa155,imaa133,imaa116,imaa127,imaa126,",
                        "               imaa132,imaa156,(SUM(COALESCE(l_sto,0))*imaa116) A,(SUM(COALESCE(l_pas,0))*imaa116) B,",
                        "               (SUM(COALESCE(l_sto,0))+SUM(COALESCE(l_pas,0))) C",
                        "          FROM ",l_table,
                        "         GROUP BY inagent,inagsite,imaa001,l_sku,l_imas003,imaa154,imaa155,imaa133,imaa116,imaa127,imaa126,",
                        "                  imaa132,imaa156) U",
                        " ON (     O.inagsite = U.inagsite",
                        "      AND O.inagent = U.inagent",
                        "      AND O.imaa001 =U.imaa001",
                        "      AND O.l_sku = U.l_sku",
                        "      AND O.l_imas003 = U.l_imas003)",
#                        "      AND O.imaa154 = COALESCE(U.imaa154,O.imaa154)",
#                        "      AND O.imaa155 = COALESCE(U.imaa155,O.imaa155)",
#                        "      AND O.imaa133 = COALESCE(U.imaa133,O.imaa133)",
#                        "      AND O.imaa116 = COALESCE(U.imaa116,O.imaa116)",
#                        "      AND O.imaa127 = COALESCE(U.imaa127,O.imaa127)",
#                        "      AND O.imaa126 = COALESCE(U.imaa126,O.imaa126)",
#                        "      AND O.imaa132 = COALESCE(U.imaa132,O.imaa132)",
#                        "      AND O.imaa156 = COALESCE(U.imaa156,O.imaa156))",
                        " WHEN MATCHED THEN",
                        "    UPDATE SET O.l_money_sto=U.A,O.l_money_pas=U.B,O.l_count=U.C,O.l_money=U.C*U.imaa116"                         
    PREPARE l_count_merge_pr1 FROM l_count_merge 
    EXECUTE l_count_merge_pr1
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "l_count_merge_pr1"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
       END IF
    LET l_sql = " SELECT inagent,inagsite,inag002,SUM(COALESCE(l_sto,0)),SUM(COALESCE(l_pas,0)) FROM ",l_table,
                "  WHERE imaa001 IS NOT NULL",
                "  GROUP BY inagent,inagsite,inag002"
    PREPARE aslr509_pre FROM l_sql
    DECLARE aslr509_cur CURSOR FOR aslr509_pre
    FOREACH aslr509_cur INTO l_inagent,l_inagsite,l_inag002,l_sto_sum,l_pas_sum
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr509_cur"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
       END IF
       LET l_inagsite_1 = l_inagsite,".门店小计" CLIPPED
       EXECUTE insert_prep USING l_inagent,l_inagsite,l_inagsite_1,'','','','','','','','','','','','','','','','','','','','','','','','','','','',l_inag002,l_sto_sum,l_pas_sum
 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "aslr509_x01_execute"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
          END IF
    END FOREACH
    
    LET l_money_merge = " MERGE INTO ",l_table," O",
                        " USING (SELECT inagsite,SUM(COALESCE((l_sto*imaa116),0)) A,SUM(COALESCE((l_pas*imaa116),0)) B,",
                        "               (SUM(COALESCE(l_sto,0))+SUM(COALESCE(l_pas,0))) C",
                        "          FROM ",l_table,
                        "         WHERE imaa001 IS NOT NULL",
                        "         GROUP BY inagsite) U",
                        " ON (     O.l_inagsite = U.inagsite||'.门店小计'",
                        "      AND O.imaa001 IS NULL)",
                        " WHEN MATCHED THEN",
                        "    UPDATE SET O.l_money_sto=U.A,O.l_money_pas=U.B,O.l_count=U.C,O.l_money=U.A+U.B"  
    PREPARE l_money_merge_pr FROM l_money_merge 
    EXECUTE l_money_merge_pr
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "l_money_merge_pr"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
       END IF 
    LET l_sql = " SELECT inagent,inag002,SUM(COALESCE(l_sto,0)),SUM(COALESCE(l_pas,0)) FROM ",l_table,
                "  WHERE imaa001 IS NOT NULL",
                "  GROUP BY inagent,inag002"
    PREPARE aslr509_pre1 FROM l_sql
    DECLARE aslr509_cur1 CURSOR FOR aslr509_pre1
    FOREACH aslr509_cur1 INTO l_inagent,l_inag002,l_sto_sum,l_pas_sum
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr509_cur"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
       END IF
       LET l_inagsite = "总计" 
       EXECUTE insert_prep USING l_inagent,l_inagsite,l_inagsite,'','','','','','','','','','','','','','','','','','','','','','','','','','','',l_inag002,l_sto_sum,l_pas_sum
 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "aslr509_x01_execute"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
          END IF
    END FOREACH
    
    LET l_money_merge = " MERGE INTO ",l_table," O",
                        " USING (SELECT SUM(COALESCE((l_sto*imaa116),0)) A,SUM(COALESCE((l_pas*imaa116),0)) B,",
                        "               (SUM(COALESCE(l_sto,0))+SUM(COALESCE(l_pas,0))) C",
                        "          FROM ",l_table,
                        "         WHERE imaa001 IS NOT NULL) U",
                        " ON (     O.inagsite = '总计' )",
                        " WHEN MATCHED THEN",
                        "    UPDATE SET O.l_money_sto=U.A,O.l_money_pas=U.B,O.l_count=U.C,O.l_money=U.A+U.B"  
    PREPARE l_money_merge_pr1 FROM l_money_merge 
    EXECUTE l_money_merge_pr1
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "l_money_merge_pr1"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
       END IF         
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aslr509_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr509_x01_rep_data()
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
 
{<section id="aslr509_x01.other_function" readonly="Y" >}

 
{</section>}
 
