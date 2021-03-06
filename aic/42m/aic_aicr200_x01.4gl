#該程式未解開Section, 採用最新樣板產出!
{<section id="aicr200_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-06-04 18:15:54), PR版次:0001(2016-06-04 18:14:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: aicr200_x01
#+ Description: ...
#+ Creator....: 07024(2016-06-01 13:56:18)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="aicr200_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#SQL概念：Step1.先抓訂單資料 Step2.抓其他站的訂單&採購單對應欄位有：(1)訂單的多角序號[每組多角序號都是唯一值]
#                                                               (2)ent=g_enterprise (3)site=各站營運據點
#WHERE條件:xmda006=2.銷售多角 AND 第0站=g_site
#注意事項:(1)採購單的據點，需以aici100中，各站的營運據點去對應，請勿用xmdasite，會造成抓出的採購單，都只有當下我們選擇的那個site

#幣別轉換:Step1.先對照"訂單幣別"&"採購單幣別"是否相同，不相同進行Step2
#       :Step2.取"採購單幣別"轉換成"訂單幣別"的匯率(別名exchange)
#       :Step3.(1)採購單價=採購單價*exchange  (2)採購原幣金額=採購原幣金額*exchange   (3)採購本幣金額=採購本幣金額*exchange
#   備註:採購本幣金額，在SQL中已*過採購匯率，故在幣別轉換部分，可以直接*exchange

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
 
{<section id="aicr200_x01.main" readonly="Y" >}
PUBLIC FUNCTION aicr200_x01(p_arg1)
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
   LET g_rep_code = "aicr200_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aicr200_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aicr200_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aicr200_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aicr200_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aicr200_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aicr200_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aicr200_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmda050.xmda_t.xmda050,xmdadocno.xmda_t.xmdadocno,xmdadocdt.xmda_t.xmdadocdt,xmda004.xmda_t.xmda004,l_xmda004_desc.pmaal_t.pmaal004,xmda031.xmda_t.xmda031,xmda015.xmda_t.xmda015,l_xmda015_desc.ooail_t.ooail003,xmda016.xmda_t.xmda016,xmda002.xmda_t.xmda002,l_xmda002_desc.ooag_t.ooag011,xmda003.xmda_t.xmda003,l_xmda003_desc.ooefl_t.ooefl003,xmddseq.xmdd_t.xmddseq,xmdd001.xmdd_t.xmdd001,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,xmdd002.xmdd_t.xmdd002,l_xmdd002_desc.inaml_t.inaml004,imaa_t_imaa003.imaa_t.imaa003,l_imaa003_desc.oocql_t.oocql004,imaf_t_imaf111.imaf_t.imaf111,l_imaf111_desc.oocql_t.oocql004,imaa_t_imaa127.imaa_t.imaa127,l_imaa127_desc.oocql_t.oocql004,l_xmdc012.xmdc_t.xmdc012,l_icab002.icab_t.icab002,xmdasite.xmda_t.xmdasite,l_xmdasite_desc.ooefl_t.ooefl003,l_xmdc015.xmdc_t.xmdc015,l_order_oprice.type_t.num20_6,l_order_cprice.type_t.num20_6,pmdn_t_pmdn015.pmdn_t.pmdn015,l_purchase_oprice.type_t.num20_6,l_purchase_cprice.type_t.num20_6,l_oprice_diff.type_t.num20_6,l_cprice_diff.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aicr200_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aicr200_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aicr200_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicr200_x01_sel_prep()
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
   #單價及金額部分，若NUL，給0
   LET g_select = " SELECT xm.xmdaent,xm.xmda050,xm.xmdadocno,xm.xmdadocdt,xm.xmda004,",
                  "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xm.xmdaent AND pmaal001=xm.xmda004 AND pmaal002='",g_dlang,"') pmaal004,",
                  "        xm.xmda031,xm.xmda015,",
                  "        (SELECT ooail003 FROM ooail_t WHERE ooailent=xm.xmdaent AND ooail001=xm.xmda015 AND ooail002='",g_dlang,"') ooail003,",
                  #各站的訂單幣別
                  "        (SELECT xmda015 FROM xmda_t WHERE xm.xmdaent=xmdaent AND xmdasite=b.icab003 AND xm.xmda031=xmda031 AND xmdcseq=c.xmdcseq) xmda015_1,",
                  "        xm.xmda016,xm.xmda002,",
                  "        (SELECT ooag011 FROM ooag_t WHERE ooagent=xm.xmdaent AND ooag001=xm.xmda002) ooag011,",
                  "        xm.xmda003,",
                  "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xm.xmdaent AND ooefl001=xm.xmda003 AND ooefl002='",g_dlang,"') B1_ooefl003,",
                  "        c.xmdcseq,c.xmdc001,",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent=c.xmdcent AND imaal001=c.xmdc001 AND imaal002='",g_dlang,"') imaal003,",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent=c.xmdcent AND imaal001=c.xmdc001 AND imaal002='",g_dlang,"') imaal004,",
                  "        xmdc002,",
                  "        (SELECT inaml004 FROM inaml_t WHERE inamlent=xmdcent AND inaml001=xmdc001 AND inaml002=xmdc002 AND inaml003='",g_dlang,"') inaml004,",
                  "        c.imaa003, ",
                  "        (SELECT oocql004 FROM oocql_t WHERE oocqlent=c.imaaent AND oocql001='200' AND oocql002=c.imaa003 AND oocql003='",g_dlang,"') A1_oocql004,",
                  "        c.imaf111,",
                  "        (SELECT oocql004 FROM oocql_t WHERE oocqlent=xm.xmdaent AND oocql001='202' AND oocql002=c.imaf111 AND oocql003='",g_dlang,"') A2_oocql004,",
                  "        c.imaa127,",
                  "        (SELECT oocql004 FROM oocql_t WHERE oocqlent=c.imaaent AND oocql001='2003' AND oocql002=c.imaa127 AND oocql003='",g_dlang,"') A3_oocql004,",
                  "        c.xmdc012,b.icab002,",
                  "        b.icab003, ",
                  "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xm.xmdaent AND ooefl001=b.icab003 AND ooefl002='",g_dlang,"') B2_ooefl003,",
                  #訂單單價
                  "        NVL((SELECT xmdc015 FROM xmdc_t,xmda_t WHERE xmdaent=xmdcent AND xmdasite=xmdcsite AND xmdadocno=xmdcdocno 
                                                                    AND xm.xmdaent=xmdaent AND xmdasite=b.icab003 AND xm.xmda031=xmda031 AND xmdcseq=c.xmdcseq),0) xmdc015,",
                  #訂單原幣金額
                  "        NVL((SELECT xmdc046 FROM xmdc_t,xmda_t WHERE xmdaent=xmdcent AND xmdasite=xmdcsite AND xmdadocno=xmdcdocno 
                                                                    AND xm.xmdaent=xmdaent AND xmdasite=b.icab003 AND xm.xmda031=xmda031 AND xmdcseq=c.xmdcseq),0) xmdc046,",
                  #訂單本幣金額
                  "        NVL((SELECT (xmdc046*xmda016) FROM xmdc_t,xmda_t WHERE xmdaent=xmdcent AND xmdasite=xmdcsite AND xmdadocno=xmdcdocno 
                                                                              AND xm.xmdaent=xmdaent AND xmdasite=b.icab003 AND xm.xmda031=xmda031 AND xmdcseq=c.xmdcseq),0) xmdc016_1,",
                  #訂單內外購、採購單幣別、採購單單價、採購原幣金額、採購本幣金額
                  "        xm.xmda048,d.pmdl015,NVL(d.pmdn015,0),NVL(d.pmdn046,0),NVL(d.pmdn046*d.pmdl016,0), ",
                  #價差原幣金額、價差比幣金額
                  "        NULL,NULL"
#   #end add-point
#   LET g_select = " SELECT xmdaent,xmda050,xmdadocno,xmdadocdt,xmda004,NULL,xmda031,xmda015,NULL,NULL, 
#       xmda016,xmda002,NULL,xmda003,NULL,xmddseq,xmdd001,imaal_t.imaal003,imaal_t.imaal004,xmdd002,NULL, 
#       imaa_t.imaa003,NULL,imaf_t.imaf111,NULL,imaa_t.imaa127,NULL,NULL,NULL,xmdasite,NULL,NULL,NULL, 
#       NULL,xmda048,pmdl_t.pmdl015,pmdn_t.pmdn015,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM xmda_t xm",
                #取站別及各站的據點 (先對到第0站=g_site的流程編號，再拿那個流程編號去抓出各站及各站營運據點)
                "      LEFT OUTER JOIN (SELECT icab_t.* FROM icab_t,icaa_t WHERE icaaent=icabent AND icaasite=icabsite AND icaa001=icab001 AND icaa003='1') a ON a.icabent=xmdaent AND a.icab001=xmda050 AND a.icab003='",g_site,"' AND a.icab002='0'",
                "      LEFT OUTER JOIN (SELECT icab_t.* FROM icab_t,icaa_t WHERE icaaent=icabent AND icaasite=icabsite AND icaa001=icab001 AND icaa003='1') b ON b.icabent=xmdaent AND b.icab001=xmda050 AND b.icab001=a.icab001 ",
                #取訂單單身
                "      LEFT OUTER JOIN (SELECT DISTINCT xmdc_t.*,xmdd_t.xmdd011,imaf_t.imaf111,imaa_t.* ",
                "                         FROM xmdc_t ",
                "                         LEFT OUTER JOIN imaf_t ON imafent=xmdcent AND imafsite=xmdcsite AND imaf001=xmdc001 ",
                "                         LEFT OUTER JOIN imaa_t ON imaaent=xmdcent AND imaa001=xmdc001 ",
                "                             ,xmdd_t ",
                "                        WHERE xmdcent=xmddent AND xmdcsite=xmdcsite AND xmdcdocno=xmdddocno AND xmdcseq=xmddseq) c",
                "                   ON xm.xmdaent=c.xmdcent AND xm.xmdasite=c.xmdcsite AND xm.xmdadocno=c.xmdcdocno ",
                #取採購單
                "      LEFT OUTER JOIN (SELECT pmdn_t.*,pmdl_t.pmdl031,pmdl_t.pmdl015,pmdl_t.pmdl054,pmdl_t.pmdl016 FROM pmdl_t,pmdn_t ",
                "                        WHERE pmdlent=pmdnent AND pmdlsite=pmdnsite AND pmdldocno=pmdndocno ) d",
                "                   ON xm.xmdaent=d.pmdnent AND d.pmdnsite=b.icab003 AND xm.xmda031=d.pmdl031 AND c.xmdcseq=d.pmdnseq AND xm.xmda031 IS NOT NULL"
   
#   #end add-point
#    LET g_from = " FROM xmda_t,xmdd_t,pmdl_t,pmdn_t,imaa_t,imaf_t,ooag_t,ooeg_t,imaal_t,ooefl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE a.icab003='",g_site,"' AND a.icab002='0' AND b.icab001=a.icab001 ",
                 #情1:多角序號為空，僅顯示第一筆訂單資料
                 #情2:多角序號不為空，抓取各站訂單、採購單資料
                 "   AND ( (xm.xmda031 IS NULL AND b.icab003='",g_site,"' AND b.icab002='0') OR xm.xmda031 IS NOT NULL ) ",
                 "   AND ",tm.wc CLIPPED
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
   #排序：多角流程編號、訂單單號、站別、營運據點、項次
   LET g_sql = g_sql CLIPPED ," ORDER BY xmda050,xmdadocno,b.icab002,xmdasite,xmdcseq"
#   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE aicr200_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aicr200_x01_curs CURSOR FOR aicr200_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aicr200_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aicr200_x01_ins_data()
DEFINE sr RECORD 
   xmdaent LIKE xmda_t.xmdaent, 
   xmda050 LIKE xmda_t.xmda050, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmda004 LIKE xmda_t.xmda004, 
   l_xmda004_desc LIKE pmaal_t.pmaal004, 
   xmda031 LIKE xmda_t.xmda031, 
   xmda015 LIKE xmda_t.xmda015, 
   l_xmda015_desc LIKE ooail_t.ooail003, 
   l_xmda015_1 LIKE xmda_t.xmda015, 
   xmda016 LIKE xmda_t.xmda016, 
   xmda002 LIKE xmda_t.xmda002, 
   l_xmda002_desc LIKE ooag_t.ooag011, 
   xmda003 LIKE xmda_t.xmda003, 
   l_xmda003_desc LIKE ooefl_t.ooefl003, 
   xmddseq LIKE xmdd_t.xmddseq, 
   xmdd001 LIKE xmdd_t.xmdd001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmdd002 LIKE xmdd_t.xmdd002, 
   l_xmdd002_desc LIKE inaml_t.inaml004, 
   imaa_t_imaa003 LIKE imaa_t.imaa003, 
   l_imaa003_desc LIKE oocql_t.oocql004, 
   imaf_t_imaf111 LIKE imaf_t.imaf111, 
   l_imaf111_desc LIKE oocql_t.oocql004, 
   imaa_t_imaa127 LIKE imaa_t.imaa127, 
   l_imaa127_desc LIKE oocql_t.oocql004, 
   l_xmdc012 LIKE xmdc_t.xmdc012, 
   l_icab002 LIKE icab_t.icab002, 
   xmdasite LIKE xmda_t.xmdasite, 
   l_xmdasite_desc LIKE ooefl_t.ooefl003, 
   l_xmdc015 LIKE xmdc_t.xmdc015, 
   l_order_oprice LIKE type_t.num20_6, 
   l_order_cprice LIKE type_t.num20_6, 
   xmda048 LIKE xmda_t.xmda048, 
   pmdl_t_pmdl015 LIKE pmdl_t.pmdl015, 
   pmdn_t_pmdn015 LIKE pmdn_t.pmdn015, 
   l_purchase_oprice LIKE type_t.num20_6, 
   l_purchase_cprice LIKE type_t.num20_6, 
   l_oprice_diff LIKE type_t.num20_6, 
   l_cprice_diff LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success    LIKE type_t.num5
DEFINE l_exchange   LIKE xmdk_t.xmdk017
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aicr200_x01_curs INTO sr.*                               
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
       #採購單幣別轉換成第0站的訂單幣別
       IF sr.xmda015 <> sr.l_xmda015_1 THEN
          LET l_success = ''
          LET l_exchange = ''
          #取匯率(採購單幣別轉訂單幣別)
          CALL s_aicr200_x01_exchange (sr.xmda048,sr.xmdasite,sr.xmdadocdt,sr.l_xmda015_1,sr.xmda015)
               RETURNING l_success,l_exchange
          IF l_success THEN
             #訂單單價
             LET sr.l_xmdc015 = sr.l_xmdc015 * l_exchange
             #採購原幣金額
             LET sr.l_order_oprice = sr.l_order_oprice * l_exchange
             #採購本幣金額 (原先的l_order_cprice已在SQL*完採購的匯率)
             LET sr.l_order_cprice = sr.l_order_cprice * l_exchange
          END IF
       END IF
       
       #幣別轉換(以第0站的site 訂單幣別為主)
       IF sr.xmda015 <> sr.pmdl_t_pmdl015 THEN
          LET l_success = ''
          LET l_exchange = ''
          #取匯率(採購單幣別轉訂單幣別)
          CALL s_aicr200_x01_exchange (sr.xmda048,sr.xmdasite,sr.xmdadocdt,sr.pmdl_t_pmdl015,sr.xmda015)
               RETURNING l_success,l_exchange
          IF l_success THEN
             #採購單價
             LET sr.pmdn_t_pmdn015 = sr.pmdn_t_pmdn015 * l_exchange
             #採購原幣金額
             LET sr.l_purchase_oprice = sr.l_purchase_oprice * l_exchange
             #採購本幣金額 (原先的l_purchase_cprice已在SQL*完採購的匯率)
             LET sr.l_purchase_cprice = sr.l_purchase_cprice * l_exchange
          END IF
       END IF
       #價差原幣金額(訂單原幣金額-採購原幣金額)
       LET sr.l_oprice_diff = sr.l_order_oprice - sr.l_purchase_oprice
       #價差本幣金額(訂單本幣金額-採購本幣金額)
       LET sr.l_cprice_diff = sr.l_order_cprice - sr.l_purchase_cprice
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmda050,sr.xmdadocno,sr.xmdadocdt,sr.xmda004,sr.l_xmda004_desc,sr.xmda031,sr.xmda015,sr.l_xmda015_desc,sr.xmda016,sr.xmda002,sr.l_xmda002_desc,sr.xmda003,sr.l_xmda003_desc,sr.xmddseq,sr.xmdd001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.xmdd002,sr.l_xmdd002_desc,sr.imaa_t_imaa003,sr.l_imaa003_desc,sr.imaf_t_imaf111,sr.l_imaf111_desc,sr.imaa_t_imaa127,sr.l_imaa127_desc,sr.l_xmdc012,sr.l_icab002,sr.xmdasite,sr.l_xmdasite_desc,sr.l_xmdc015,sr.l_order_oprice,sr.l_order_cprice,sr.pmdn_t_pmdn015,sr.l_purchase_oprice,sr.l_purchase_cprice,sr.l_oprice_diff,sr.l_cprice_diff
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aicr200_x01_execute"
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
 
{<section id="aicr200_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aicr200_x01_rep_data()
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
 
{<section id="aicr200_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 計算匯率
# Memo...........:
# Usage..........: CALL s_aicr200_x01_exchange(p_icaa013,p_site,p_date,p_from,p_to)
#                  RETURNING r_success,r_exchange
# Input parameter: p_icaa013   #1.內銷(購)  2.外銷(購)
#                : p_site      #營運據點
#                : p_date      #單據日期
#                : p_from      #來源幣別
#                : p_to        #目的幣別(若為Null則預帶p_site本幣)
# Return code....: r_success   #執行結果
#                : r_exchange  #匯率
# Date & Author..: 2016/06/02 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION s_aicr200_x01_exchange(p_icaa013,p_site,p_date,p_from,p_to)
   DEFINE p_icaa013      LIKE icaa_t.icaa013
   DEFINE p_site         LIKE xmdk_t.xmdksite
   DEFINE p_date         LIKE xmdk_t.xmdkdocdt
   DEFINE p_from         LIKE xmdk_t.xmdk016
   DEFINE p_to           LIKE xmdk_t.xmdk016
   DEFINE r_success      LIKE type_t.num5
   DEFINE r_exchange     LIKE xmdk_t.xmdk017

   DEFINE l_para_data    LIKE type_t.chr80

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   LET r_exchange = ''

   LET l_para_data = ''   
   CASE p_icaa013
      WHEN '1'  #內
         CALL cl_get_para(g_enterprise,p_site,'S-BAS-0010') RETURNING l_para_data
      WHEN '2'  #外
         CALL cl_get_para(g_enterprise,p_site,'S-BAS-0011') RETURNING l_para_data
   END CASE

   IF cl_null(l_para_data) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00363'  #查無外幣採用匯率類型！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success,r_exchange
   ELSE
      #取匯率
      CALL s_aooi160_get_exrate('1',p_site,g_today,p_from,p_to,0,l_para_data) RETURNING r_exchange

   END IF

   RETURN r_success,r_exchange
END FUNCTION

 
{</section>}
 
