#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr513_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-22 19:08:49), PR版次:0001(2017-01-05 10:23:14)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr513_x01
#+ Description: ...
#+ Creator....: 02346(2016-12-21 17:28:27)
#+ Modifier...: 02346 -SD/PR- 02346
 
{</section>}
 
{<section id="aslr513_x01.global" readonly="Y" >}
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
       wc STRING,                  #where condition 
       diff LIKE type_t.chr1          #未有差异显示
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aslr513_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr513_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.diff  未有差异显示
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.diff = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aslr513_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr513_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr513_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr513_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr513_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr513_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr513_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr513_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inbm001.inbm_t.inbm001,ooefl_t_ooefl003.ooefl_t.ooefl003,l_size_desc.type_t.chr200,l_color.type_t.chr200,inbp008.inbp_t.inbp008,inbp009.inbp_t.inbp009,imaa_t_imaa116.imaa_t.imaa116,l_sum1.type_t.num20_6,l_price.type_t.num20_6,l_sum2.type_t.num20_6,l_discount.type_t.num15_3,inbpdocno.inbp_t.inbpdocno,inbmcnfdt.inbm_t.inbmcnfdt,inbp004.inbp_t.inbp004,l_diffcount.type_t.num20_6,inbp005.inbp_t.inbp005,imaal_t_imaal003.imaal_t.imaal003,l_size.type_t.chr200,l_color_desc.type_t.chr200,l_indj015.indj_t.indj015" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr513_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr513_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aslr513_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr513_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_group       STRING  #161129-00027#5 add by sunxh 161222
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #161129-00027#5 add by sunxh 161222(S)
   LET g_select = "SELECT DISTINCT inbm001,'',inbp006,'',sum(inbp008),sum(inbp009),imaa116,sum(nvl(inbp009*imaa116,0)), ",
               "       CASE ",
               "          WHEN inbm003 = '4' AND inbm008 = '1' THEN imaa116 ",
               "          WHEN inbm003 = '4' AND inbm008 = '2' THEN imaa116 ",
               "          WHEN inbm003 = '4' AND inbm008 = '3' THEN xmja010 ",
               "          WHEN inbm003 = '5' THEN pmdt036 ",
               "          WHEN inbm003 = '6' THEN indd045 ",
               "          WHEN inbm003 = '7' THEN xmdl210 ",
               "       END l_price,0,0,",
               "       inbmdocno,inbmcnfdt,inbp004,sum(NVL(inbp008,0)-NVL(inbp009,0)),t1.inbp005,imaal003,'','',t2.indj015 " 
   LET g_from =  "  FROM inbm_t ",
               "       LEFT JOIN inbp_t t1 ON (inbment = t1.inbpent AND inbmdocno = t1.inbpdocno) ",
               "       LEFT JOIN (select DISTINCT inbpent,inbpdocno,inbpseq,inbp005, ",
               "               CASE WHEN inbp001 = '4' THEN indj015 ",
               "                    WHEN inbp001 = '5' OR inbp001 = '8' THEN pmdt016 ",
               "                    WHEN inbp001 = '6' THEN indd032 ",
               "                    WHEN inbp001 = '7' THEN xmdl014  ",
               "               END indj015 ",
               "          FROM inbp_t ",
               "               LEFT JOIN indj_t ON (indjent = inbpent AND indjdocno = inbp002 AND indjseq = inbp003 AND inbp001 = '4') ",
               "               LEFT JOIN pmdt_t ON pmdtent = inbpent AND pmdtdocno = inbp002 AND pmdtseq = inbp003 AND inbp001 IN ('5','8') ",
               "               LEFT JOIN indd_t ON inddent = inbpent AND indddocno = inbp002 AND inddseq = inbp003 AND inbp001 = '6' ",
               "               LEFT JOIN xmdl_t ON xmdlent = inbpent AND xmdldocno = inbp002 AND xmdlseq = inbp003 AND inbp001 = '7' ",
               "          WHERE inbpent = ",g_enterprise,
               "       ) t2 ON (inbment = t2.inbpent AND inbmdocno = t2.inbpdocno AND t1.inbpseq = t2.inbpseq)    ",
               "       LEFT JOIN imaa_t ON (imaaent = inbment AND imaa001 = t1.inbp005 ) ",
               "       LEFT JOIN imaal_t ON (imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"') ",
               "       LEFT JOIN xmja_t ON (xmjaent = t1.inbpent AND xmjadocno = inbp002 AND xmjaseq = inbp003 AND inbm003 = '4' AND inbm008 = '3') ",
               "       LEFT JOIN pmdt_t ON (pmdtent = t1.inbpent AND pmdtdocno = inbp002 AND pmdtseq = inbp003 AND inbp001 IN ('5','8')) ",
               "       LEFT JOIN indd_t ON (inddent = t1.inbpent AND indddocno = inbp002 AND inddseq = inbp003 AND inbp001 = '6') ",
               "       LEFT JOIN xmdl_t ON (xmdlent = t1.inbpent AND xmdldocno = inbp002 AND xmdlseq = inbp003 AND inbp001 = '7') "  
   #161129-00027#5 add by sunxh 161222(E)  
                  
#   #end add-point
#   LET g_select = " SELECT inbm001,ooefl_t.ooefl003,NULL,NULL,inbp008,inbp009,imaa_t.imaa116,0,0,0,0, 
#       inbpdocno,inbmcnfdt,inbp004,0,inbp005,imaal_t.imaal003,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
  
#   #end add-point
#    LET g_from = " FROM inbp_t,inbm_t,ooefl_t,imaa_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
#   LET g_where = " WHERE ",tm.wc,
#               " GROUP BY inbm001,imaa116,inbp006,inbm003,inbm008,imaa116,xmja010,pmdt036,indd045,xmdl210, ",
#               "          inbmdocno,inbmcnfdt,inbp004,t1.inbp005,imaal003,t2.indj015 ",
#               " ORDER BY inbmdocno "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #161129-00027#5 add by sunxh 161222(S)
   IF NOT cl_null(tm.diff) THEN
      IF tm.diff='Y' THEN
         LET g_where = g_where," AND inbp008=inbp009 "
      ELSE
         LET g_where = g_where," AND inbp008<>inbp009 "
      END IF
   END IF 
   #161129-00027#5 add by sunxh 161222(E)    
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_group =" GROUP BY inbm001,imaa116,inbp006,inbm003,inbm008,imaa116,xmja010,pmdt036,indd045,xmdl210, ",
               "          inbmdocno,inbmcnfdt,inbp004,t1.inbp005,imaal003,t2.indj015 ",
               " ORDER BY inbmdocno "
   LET g_where = g_where ,cl_sql_add_filter("inbp_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," ",g_group CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("inbp_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aslr513_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr513_x01_curs CURSOR FOR aslr513_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr513_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr513_x01_ins_data()
DEFINE sr RECORD 
   inbm001 LIKE inbm_t.inbm001, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   l_size_desc LIKE type_t.chr200, 
   l_color LIKE type_t.chr200, 
   inbp008 LIKE inbp_t.inbp008, 
   inbp009 LIKE inbp_t.inbp009, 
   imaa_t_imaa116 LIKE imaa_t.imaa116, 
   l_sum1 LIKE type_t.num20_6, 
   l_price LIKE type_t.num20_6, 
   l_sum2 LIKE type_t.num20_6, 
   l_discount LIKE type_t.num15_3, 
   inbpdocno LIKE inbp_t.inbpdocno, 
   inbmcnfdt LIKE inbm_t.inbmcnfdt, 
   inbp004 LIKE inbp_t.inbp004, 
   l_diffcount LIKE type_t.num20_6, 
   inbp005 LIKE inbp_t.inbp005, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   l_size LIKE type_t.chr200, 
   l_color_desc LIKE type_t.chr200, 
   l_indj015 LIKE indj_t.indj015
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#161129-00027#5 add by sunxh 161222(S)
DEFINE l_num            LIKE type_t.num10,
       l_success        LIKE type_t.chr10,
       l_colorsize      LIKE type_t.chr100
#161129-00027#5 add by sunxh 161222(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr513_x01_curs INTO sr.*                               
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
       #161129-00027#5 add by sunxh 161222(S) 
       #取尺寸,尺寸说明,颜色,颜色说明
       LET l_num = 0       
       IF NOT cl_null(sr.l_size_desc) THEN
#          CALL s_feature_description(sr.inbp005,sr.l_size_desc)  RETURNING l_success,l_colorsize
          LET l_colorsize = sr.l_size_desc  #mod by sunxh 170104
          SELECT instr(sr.l_size_desc,'_',1,1) INTO l_num FROM DUAL
          IF l_num > 0 THEN
             SELECT substr(sr.l_size_desc,1,instr(sr.l_size_desc,'_',1,1)-1) INTO sr.l_color FROM dual  
             SELECT substr(sr.l_size_desc,instr(sr.l_size_desc,'_',1,1)+1) INTO sr.l_size FROM dual
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
       LET sr.l_sum2 = sr.inbp009*sr.l_price
       SELECT round(sr.l_price/sr.imaa_t_imaa116*100,2) INTO sr.l_discount FROM dual       
       #161129-00027#5 add by sunxh 161222(E)        
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inbm001,sr.ooefl_t_ooefl003,sr.l_size_desc,sr.l_color,sr.inbp008,sr.inbp009,sr.imaa_t_imaa116,sr.l_sum1,sr.l_price,sr.l_sum2,sr.l_discount,sr.inbpdocno,sr.inbmcnfdt,sr.inbp004,sr.l_diffcount,sr.inbp005,sr.imaal_t_imaal003,sr.l_size,sr.l_color_desc,sr.l_indj015
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr513_x01_execute"
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
 
{<section id="aslr513_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr513_x01_rep_data()
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
 
{<section id="aslr513_x01.other_function" readonly="Y" >}

 
{</section>}
 
