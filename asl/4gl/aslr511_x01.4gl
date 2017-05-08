#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr511_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-21 16:34:54), PR版次:0001(2017-01-04 17:22:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr511_x01
#+ Description: ...
#+ Creator....: 06932(2016-12-19 20:04:15)
#+ Modifier...: 06932 -SD/PR- 06932
 
{</section>}
 
{<section id="aslr511_x01.global" readonly="Y" >}
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aslr511_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr511_x01(p_arg1)
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
   LET g_rep_code = "aslr511_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr511_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr511_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr511_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr511_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr511_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr511_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr511_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "indcent.indc_t.indcent,l_indcent_desc.type_t.chr300,l_indc199.type_t.chr100,indcdocno.indc_t.indcdocno,indc022.indc_t.indc022,indc005.indc_t.indc005,l_indc005_desc.type_t.chr1000,indc024.indc_t.indc024,indc006.indc_t.indc006,l_indc006_desc.type_t.chr1000,l_indcstus.type_t.chr100,inddseq.indd_t.inddseq,indd002.indd_t.indd002,l_imaal003.type_t.chr300,l_color.type_t.chr200,l_color_desc.type_t.chr200,l_size.type_t.chr30,l_size_desc.type_t.chr300,indd003.indd_t.indd003,imaa_t_imaa154.imaa_t.imaa154,l_imaa133.type_t.chr30,l_imaa133_desc.type_t.chr100,l_rtax006.type_t.chr30,l_rtax006_desc.type_t.chr200,imaa_t_imaa156.imaa_t.imaa156,imaa_t_imaa116.imaa_t.imaa116,indc008.indc_t.indc008,l_outprt.type_t.chr200,l_inprt.type_t.chr300,l_imaa132.type_t.chr30,l_imaa132_desc.type_t.chr300,indd021.indd_t.indd021,indd031.indd_t.indd031,l_diff.type_t.num15_3,indd022.indd_t.indd022,l_indd022_desc.type_t.chr300,indd032.indd_t.indd032,l_indd032_desc.type_t.chr300" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr511_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr511_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aslr511_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr511_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_group       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #161104-00021#7  add by yany 2016/12/20 --str
   LET g_select = " SELECT DISTINCT indcent,NULL,indc199,indcdocno,indc022,indc005,NULL,indc024,indc006,NULL, ",
                  "        indcstus,inddseq,indd002,NULL,NULL,NULL,NULL,NULL,indd003,imaa154,imaa133,NULL, ",
                  "        rtax006,NULL,imaa156,COALESCE(imaa116, 0) imaa116,indc008,NULL,NULL,imaa132,NULL, ",
                  "        sum(nvl(indd021,0)),sum(nvl(indd031,0)),sum(nvl(indd021,0)-nvl(indd031,0)),",
                  "        indd022,NULL,indd032,NULL "
   #161104-00021#7  add by yany 2016/12/20 --end
   
#   #end add-point
#   LET g_select = " SELECT indcent,NULL,NULL,indcdocno,indc022,indc005,NULL,indc024,indc006,NULL,NULL, 
#       inddseq,indd002,NULL,NULL,NULL,NULL,NULL,indd003,imaa_t.imaa154,NULL,NULL,NULL,NULL,imaa_t.imaa156, 
#       imaa_t.imaa116,indc008,NULL,NULL,NULL,NULL,indd021,indd031,NULL,indd022,NULL,indd032,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #161104-00021#7  add by yany 2016/12/20 --str
   LET g_from = " FROM indc_t ",
                " LEFT JOIN indd_t ON (indcent = inddent and indcdocno = indddocno) ",
                " LEFT JOIN imaa_t ON (indcent = imaaent and indd002 = imaa001) ",
                " LEFT JOIN rtax_t ON (indcent = rtaxent and rtax001 = imaa009) "
   #161104-00021#7  add by yany 2016/12/20 --end
   
#   #end add-point
#    LET g_from = " FROM indc_t,indd_t,imaa_t,rtax_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   #161104-00021#7  add by yany 2016/12/20 --str
   LET g_where = " WHERE " ,tm.wc CLIPPED," AND indcsite = indc005 "
   LET g_group = " GROUP BY indcent,indc199,indcdocno,indc022,indc005,indc024,indc006,indcstus,inddseq,indd002,",
                 "          indd003,imaa154,imaa133,rtax006,imaa156,imaa116,indc008,imaa132,indd022,indd032 "
   #161104-00021#7  add by yany 2016/12/20 --end
   
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   #161104-00021#7  add by yany 2016/12/20 --str
   LET g_where = g_where ,cl_sql_add_filter("indc_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," ",g_group CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql) 
   #161104-00021#7  add by yany 2016/12/20 --end
   
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("indc_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aslr511_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr511_x01_curs CURSOR FOR aslr511_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr511_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr511_x01_ins_data()
DEFINE sr RECORD 
   indcent LIKE indc_t.indcent, 
   l_indcent_desc LIKE type_t.chr300, 
   l_indc199 LIKE type_t.chr100, 
   indcdocno LIKE indc_t.indcdocno, 
   indc022 LIKE indc_t.indc022, 
   indc005 LIKE indc_t.indc005, 
   l_indc005_desc LIKE type_t.chr1000, 
   indc024 LIKE indc_t.indc024, 
   indc006 LIKE indc_t.indc006, 
   l_indc006_desc LIKE type_t.chr1000, 
   l_indcstus LIKE type_t.chr100, 
   inddseq LIKE indd_t.inddseq, 
   indd002 LIKE indd_t.indd002, 
   l_imaal003 LIKE type_t.chr300, 
   l_color LIKE type_t.chr200, 
   l_color_desc LIKE type_t.chr200, 
   l_size LIKE type_t.chr30, 
   l_size_desc LIKE type_t.chr300, 
   indd003 LIKE indd_t.indd003, 
   imaa_t_imaa154 LIKE imaa_t.imaa154, 
   l_imaa133 LIKE type_t.chr30, 
   l_imaa133_desc LIKE type_t.chr100, 
   l_rtax006 LIKE type_t.chr30, 
   l_rtax006_desc LIKE type_t.chr200, 
   imaa_t_imaa156 LIKE imaa_t.imaa156, 
   imaa_t_imaa116 LIKE imaa_t.imaa116, 
   indc008 LIKE indc_t.indc008, 
   l_outprt LIKE type_t.chr200, 
   l_inprt LIKE type_t.chr300, 
   l_imaa132 LIKE type_t.chr30, 
   l_imaa132_desc LIKE type_t.chr300, 
   indd021 LIKE indd_t.indd021, 
   indd031 LIKE indd_t.indd031, 
   l_diff LIKE type_t.num15_3, 
   indd022 LIKE indd_t.indd022, 
   l_indd022_desc LIKE type_t.chr300, 
   indd032 LIKE indd_t.indd032, 
   l_indd032_desc LIKE type_t.chr300
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#161104-00021#7  add by yany 2016/12/20 --str
DEFINE l_indd004        LIKE indd_t.indd004,
       l_indc021        LIKE indc_t.indc021,
       l_indc023        LIKE indc_t.indc023,
       l_num            LIKE type_t.num10,
       l_success        LIKE type_t.chr10,
       l_colorsize      LIKE type_t.chr100
#161104-00021#7  add by yany 2016/12/20 --end
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr511_x01_curs INTO sr.*                               
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
       #161104-00021#7  add by yany 2016/12/20 --str
       #企业编号说明
       SELECT gzoul003 INTO sr.l_indcent_desc FROM gzoul_t
        WHERE gzoul001 = sr.indcent
          AND gzoul002 = g_dlang
       
       #拨出拨入组织
       SELECT DISTINCT ooefl003 INTO sr.l_indc005_desc FROM ooef_t LEFT JOIN ooefl_t 
                                                         ON ooef001 = ooefl001
                                                        AND ooefl002 = g_dlang
                                                        AND ooefent = ooeflent
        WHERE ooefent = g_enterprise
          AND ooef001 = sr.indc005
          AND ooef201 = 'Y'
          
       SELECT DISTINCT ooefl003 INTO sr.l_indc006_desc FROM ooef_t LEFT JOIN ooefl_t 
                                                         ON ooef001 = ooefl001
                                                        AND ooefl002 = g_dlang
                                                        AND ooefent = ooeflent
        WHERE ooefent = g_enterprise
          AND ooef001 = sr.indc006
          AND ooef201 = 'Y'
      
       #取特征值：颜色和尺码
       LET l_indd004 = NULL
       SELECT indd004 INTO l_indd004 FROM indd_t
        WHERE indddocno = sr.indcdocno
          AND inddseq = sr.inddseq
       LET l_num = 0
       IF NOT cl_null(l_indd004) THEN
        # CALL s_feature_description(sr.indd002,l_indd004)  RETURNING l_success,l_colorsize
          SELECT instr(l_indd004,'_',1,1) INTO l_num FROM DUAL
          IF l_num > 0 THEN
             SELECT substr(l_indd004,1,instr(l_indd004,'_',1,1)-1) INTO sr.l_color FROM dual  
             SELECT substr(l_indd004,instr(l_indd004,'_',1,1)+1) INTO sr.l_size FROM dual
          ELSE
             LET sr.l_color = l_colorsize
          END IF
          
          SELECT DISTINCT oocql004 INTO sr.l_color_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql003 = g_dlang
             AND oocql002 = sr.l_color AND oocql001 = '2148'     
          SELECT DISTINCT oocql004 INTO sr.l_size_desc  FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql003 = g_dlang
             AND oocql002 = sr.l_size  AND oocql001 = '2149' 
       END IF
       
       #品名
       SELECT DISTINCT imaal003 INTO sr.l_imaal003 FROM imaal_t WHERE imaal001 = sr.indd002 AND imaal002 = g_dlang AND imaalent = g_enterprise
       #季节
       SELECT DISTINCT oocql004 INTO sr.l_imaa133_desc FROM oocql_t WHERE oocql002 = sr.l_imaa133 AND oocql001 = '2007' AND oocqlent = g_enterprise  
       #大类名称
       SELECT DISTINCT rtaxl003 INTO sr.l_rtax006_desc FROM rtaxl_t WHERE rtaxl001 = sr.l_rtax006
       #上下装
       SELECT DISTINCT oocql004 INTO sr.l_imaa132_desc FROM oocql_t WHERE oocql002 = sr.l_imaa132 and oocql001 = '2006' AND oocqlent = g_enterprise
 
       #发货收货部门
       LET l_indc021 = NULL
       LET l_indc023 = NULL
       SELECT DISTINCT indc021,indc023 INTO l_indc021,l_indc023 FROM indc_t WHERE indcdocno = sr.indcdocno
       SELECT DISTINCT ooefl003 INTO sr.l_outprt 
         FROM ooeg_t 
         LEFT JOIN ooefl_t ON ooefl001 = ooeg001 AND ooeflent = ooegent AND ooefl002 = g_dlang
         LEFT JOIN ooag_t  ON ooag003 = ooeg001 AND ooagent = ooegent 
        WHERE ooegent = g_enterprise
          AND EXISTS (SELECT 1 FROM ooef_t
                       WHERE ooefent = g_enterprise
                         AND (ooef001 = g_site OR ooef001 = 'ALL')
                         AND  ooef017 = ooeg009)
          AND ooegstus = 'Y'
          AND ooeg006 <= g_today
          AND (ooeg007 IS NULL OR ooeg007 > g_today)
          AND ooag001 = l_indc021
       
       SELECT DISTINCT ooefl003 INTO sr.l_inprt 
         FROM ooeg_t 
         LEFT JOIN ooefl_t ON ooefl001 = ooeg001 AND ooeflent = ooegent AND ooefl002 = g_dlang
         LEFT JOIN ooag_t  ON ooag003 = ooeg001 AND ooagent = ooegent 
        WHERE ooegent = g_enterprise
          AND EXISTS (SELECT 1 FROM ooef_t
                       WHERE ooefent = g_enterprise
                         AND (ooef001 = g_site OR ooef001 = 'ALL')
                         AND  ooef017 = ooeg009)
          AND ooegstus = 'Y'
          AND ooeg006 <= g_today
          AND (ooeg007 IS NULL OR ooeg007 > g_today)
          AND ooag001 = l_indc023
          
              
       #拨出拨入库位
       SELECT DISTINCT inayl003 INTO sr.l_indd022_desc FROM inaa_t LEFT JOIN inayl_t
                                                         ON inaaent = inaylent
                                                        AND inaa001 = inayl001
                                                        AND inayl002 = g_dlang
        WHERE inaaent = g_enterprise
          AND inaa001 = sr.indd022
       
       SELECT DISTINCT inayl003 INTO sr.l_indd032_desc FROM inaa_t LEFT JOIN inayl_t
                                                         ON inaaent = inaylent
                                                        AND inaa001 = inayl001
                                                        AND inayl002 = g_dlang
        WHERE inaaent = g_enterprise
          AND inaa001 = sr.indd032     
       
       CASE sr.l_indc199
          WHEN '1'  LET sr.l_indc199 = '1.调拨'
          WHEN '2'  LET sr.l_indc199 = '2.配送'
          WHEN '3'  LET sr.l_indc199 = '3.仓退'
          WHEN '4'  LET sr.l_indc199 = '4.普通商品移仓'
          WHEN '5'  LET sr.l_indc199 = '5.生鲜商品移仓'
          WHEN '6'  LET sr.l_indc199 = '6.赠品仓品移仓'
          WHEN '7'  LET sr.l_indc199 = '7.门店报废'
       END CASE  
       
       CASE sr.l_indcstus
          WHEN 'Y'  LET sr.l_indcstus = 'Y:已审核'
          WHEN 'O'  LET sr.l_indcstus = 'O:拨出审核'
          WHEN 'P'  LET sr.l_indcstus = 'P:拨入审核'
          WHEN 'C'  LET sr.l_indcstus = 'C:结案'
          WHEN 'A'  LET sr.l_indcstus = 'A:已核准'
          WHEN 'S'  LET sr.l_indcstus = 'S:已过账'
       END CASE       
       #161104-00021#7  add by yany 2016/12/20 --end
   
   
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.indcent,sr.l_indcent_desc,sr.l_indc199,sr.indcdocno,sr.indc022,sr.indc005,sr.l_indc005_desc,sr.indc024,sr.indc006,sr.l_indc006_desc,sr.l_indcstus,sr.inddseq,sr.indd002,sr.l_imaal003,sr.l_color,sr.l_color_desc,sr.l_size,sr.l_size_desc,sr.indd003,sr.imaa_t_imaa154,sr.l_imaa133,sr.l_imaa133_desc,sr.l_rtax006,sr.l_rtax006_desc,sr.imaa_t_imaa156,sr.imaa_t_imaa116,sr.indc008,sr.l_outprt,sr.l_inprt,sr.l_imaa132,sr.l_imaa132_desc,sr.indd021,sr.indd031,sr.l_diff,sr.indd022,sr.l_indd022_desc,sr.indd032,sr.l_indd032_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr511_x01_execute"
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
 
{<section id="aslr511_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr511_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"
DEFINE l_title     LIKE type_t.chr300  ##161104-00021#7  add by yany 2016/12/20
#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #161104-00021#7  add by yany 2016/12/20 --str
    # 取title
    LET l_title = NULL
    SELECT gzdel003 INTO l_title
      FROM gzdel_t
     WHERE gzdel001 = 'aslr511_x01'
       AND gzdel002 = g_dlang
    #161104-00021#7  add by yany 2016/12/20 --end
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="aslr511_x01.other_function" readonly="Y" >}

 
{</section>}
 
