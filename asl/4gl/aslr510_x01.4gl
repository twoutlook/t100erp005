#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr510_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-14 11:05:43), PR版次:0001(2016-12-14 11:06:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr510_x01
#+ Description: ...
#+ Creator....: 06814(2016-12-07 11:32:02)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="aslr510_x01.global" readonly="Y" >}
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
       bdate LIKE type_t.dat,         #postbdate 
       edate LIKE type_t.dat          #postedate
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aslr510_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr510_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdate  postbdate 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edate  postedate
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.edate = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
 
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aslr510_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr510_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr510_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr510_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr510_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr510_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr510_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr510_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "debnent.debn_t.debnent,gzoul_t_gzoul003.gzoul_t.gzoul003,debnsite.debn_t.debnsite,ooefl003.ooefl_t.ooefl003,imaa_t_imaa154.imaa_t.imaa154,imaa_t_imaa133.imaa_t.imaa133,l_imaa133_desc.type_t.chr500,imaa_t_imaa126.imaa_t.imaa126,l_imaa126_desc.type_t.chr500,imaa_t_imaa127.imaa_t.imaa127,l_imaa127_desc.type_t.chr500,imaa_t_imaa132.imaa_t.imaa132,l_imaa132_desc.type_t.chr500,imaa_t_imaa156.imaa_t.imaa156,l_imaa156_desc.type_t.chr500,rtax_t_rtax006.rtax_t.rtax006,l_rtax006_desc.type_t.chr500,rtax_t_rtax003.rtax_t.rtax003,l_rtax003_desc.type_t.chr500,imaa_t_imaa009.imaa_t.imaa009,l_imaa009_desc.type_t.chr500,imaa_t_imaa001.imaa_t.imaa001,imaal_t_imaal003.imaal_t.imaal003,inam_t_inam012.inam_t.inam012,l_inam012_desc.type_t.chr500,inam_t_inam014.inam_t.inam014,l_inam014_desc.type_t.chr500,imay_t_imay003.imay_t.imay003,l_smoney.imaa_t.imaa116,l_emoney.imaa_t.imaa116,l_sell_money.imaa_t.imaa116,l_adj_money.imaa_t.imaa116,l_in_money.imaa_t.imaa116,l_out_money.imaa_t.imaa116,l_snum.type_t.num20,l_in_num.type_t.num20,l_out_num.type_t.num20,l_sell_num.type_t.num20,l_adj_num.type_t.num20,l_enum.type_t.num20" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr510_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr510_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aslr510_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr510_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_select_1    STRING
DEFINE l_date        LIKE type_t.dat
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #取前一日的日期
   CALL s_date_get_date(tm.bdate,0,-1) RETURNING l_date
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select_1 = " SELECT debnent,debnent_desc,debnsite,debnsite_desc,imaa154, ",
                    "        imaa133,imaa133_desc,imaa126,imaa126_desc,imaa127, ",
                    "        imaa127_desc,imaa132,imaa132_desc,imaa156,imaa156_desc, ",
                    "        rtax006,rtax006_desc,rtax003,rtax003_desc,imaa009, ",
                    "        imaa009_desc,imaa001,imaa001_desc,debn016,inam012, ",
                    "        inam012_desc,inam014,inam014_desc,imay003, ",
                    "        l_snum*imaa116, ",                                          #期初吊牌金額
                    "        (l_snum+l_in_num-l_out_num-l_sell_num+l_adj_num)*imaa116,", #期末吊牌金額
                    "        l_sell_num*imaa116, ",                                      #銷售吊牌金額
                    "        l_adj_num*imaa116, ",                                       #調整吊牌金額
                    "        l_in_num*imaa116, ",                                        #撥入吊牌金額
                    "        l_out_num, ",                                               #撥出吊牌金額
                    "        l_snum, ",     
                    "        l_in_num,l_out_num,l_sell_num,l_adj_num,(l_snum+l_in_num-l_out_num-l_sell_num+l_adj_num)" 
   LET g_select = " SELECT DISTINCT ",
                  "        t0.debnent,(SELECT gzoul003 ",
                  "                    FROM gzoul_t ",
                  "                   WHERE gzoul001 = t0.debnent ",
                  "                     AND gzoul002 = '",g_dlang,"') debnent_desc, ",
                  "        t0.debnsite,(SELECT ooefl003 ",
                  "                    FROM ooefl_t ",
                  "                   WHERE ooeflent = t0.debnent ",
                  "                     AND ooefl001 = t0.debnsite ",
                  "                     AND ooefl002 = '",g_dlang,"') debnsite_desc, ",
                  "        imaa_t.imaa154, ",
                  "        imaa_t.imaa133, ",
                  "        CASE WHEN imaa_t.imaa133 IS NOT NULL THEN ",
                  "             trim(imaa_t.imaa133)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '2007' AND oocql002 = imaa_t.imaa133 AND oocql003 = '",g_dlang,"' )) END imaa133_desc, ",
                  "        imaa_t.imaa126, ",
                  "        CASE WHEN imaa_t.imaa126 IS NOT NULL THEN ",
                  "             trim(imaa_t.imaa126)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '2002' AND oocql002 = imaa_t.imaa126 AND oocql003 = '",g_dlang,"')) END imaa126_desc, ",
                  "        imaa_t.imaa127, ",
                  "        CASE WHEN imaa_t.imaa127 IS NOT NULL THEN ",
                  "             trim(imaa_t.imaa127)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '2003' AND oocql002 = imaa_t.imaa127 AND oocql003 = '",g_dlang,"')) END imaa127_desc, ",
                  "        imaa_t.imaa132, ",
                  "        CASE WHEN imaa_t.imaa132 IS NOT NULL THEN ",
                  "             trim(imaa_t.imaa132)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '2006' AND oocql002 = imaa_t.imaa127 AND oocql003 = '",g_dlang,"')) END imaa132_desc, ",
                  "        imaa_t.imaa156, ",
                  "        CASE WHEN imaa_t.imaa156 IS NOT NULL THEN ",
                  "             trim(imaa_t.imaa156)||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6941' AND gzcbl002 = imaa_t.imaa156 AND gzcbl003 = '",g_dlang,"')) END imaa156_desc, ",
                  "        rtax_t.rtax006,(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = rtaxent AND rtaxl001 = rtax006 AND rtaxl002 = '",g_dlang,"' ) rtax006_desc, ",
                  "        rtax_t.rtax003,(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = rtaxent AND rtaxl001 = rtax003 AND rtaxl002 = '",g_dlang,"' ) rtax003_desc, ",
                  "        imaa_t.imaa009,(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ) imaa009_desc, ",
                  "        imaa_t.imaa001, ",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"') imaa001_desc, ",
                  "        t0.debn016, ",
                  "        inam012,(SELECT imecl005 FROM imecl_t WHERE imeclent = inament AND imecl001 = inam003 AND imecl002 = 1 ",
                  "                                                AND imecl003 = inam012 AND imecl004 = '",g_dlang,"') inam012_desc , ",
                  "        inam014,(SELECT imecl005 FROM imecl_t WHERE imeclent = inament AND imecl001 = inam003 AND imecl002 = 2 ",
                  "                                                AND imecl003 = inam014 AND imecl004 = '",g_dlang,"') inam014_desc , ",
                  "        (SELECT imay003 FROM imay_t WHERE imayent = t0.debnent AND imay001 = t0.debn005 AND imay019 = t0.debn016) imay003, ",
                  #"       NULL,NULL,NULL,NULL,NULL,NULL, ",
                  "       COALESCE((SELECT t1.debn014 FROM debn_t t1 WHERE t1.debnent = t0.debnent AND t1.debnsite = t0.debnsite ",
                  "                                                    AND t1.debn002 = '",l_date,"' AND t1.debn005 = t0.debn005 ",
                  "                                                    AND t1.debn009 = t0.debn009 AND t1.debn016 = t0.debn016 ",
                  "                                                    AND t1.debn017 = t0.debn017 AND t1.debn018 = t0.debn018),0) l_snum,",
                  "       COALESCE((SELECT SUM(indd031) FROM indc_t,indd_t WHERE indcent = inddent AND indcdocno = indddocno AND indcent = t0.debnent  ",
                  "                                                 AND indc006 = t0.debnsite AND indc024 BETWEEN '",tm.bdate,"' AND '",tm.edate,"' ",
                  "                                                 AND indd002 = t0.debn005 AND indd004 = t0.debn016 AND indcstus IN('P','C') ),0) l_in_num, ",
                  "       COALESCE((SELECT SUM(indd021) FROM indc_t,indd_t WHERE indcent = inddent AND indcdocno = indddocno AND indcent = t0.debnent  ",
                  "                                                 AND indc005 = t0.debnsite AND indc024 BETWEEN '",tm.bdate,"' AND '",tm.edate,"' ",
                  "                                                 AND indd002 = t0.debn005 AND indd004 = t0.debn016 AND indcstus IN('P','O','C') ),0) l_out_num, ",
                  "       COALESCE((SELECT SUM(COALESCE(inaj011,0)*inaj004) ",
                  "          FROM inaj_t WHERE inajent = t0.debnent AND inajsite = t0.debnsite AND inaj005 = t0.debn005 AND inaj006 = t0.debn016  ",
                  "                        AND inaj015 IN ('artt610') AND inaj022 BETWEEN '",tm.bdate,"' AND '",tm.edate,"' ),0) l_sell_num, ",
                  "       COALESCE((SELECT SUM(COALESCE(inaj011,0)*inaj004) ",
                  "          FROM inaj_t WHERE inajent = t0.debnent AND inajsite = t0.debnsite AND inaj005 = t0.debn005 AND inaj006 = t0.debn016  ",
                  "                        AND inaj015 IN ('aint808') AND inaj022 BETWEEN '",tm.bdate,"' AND '",tm.edate,"' ),0) l_adj_num, ",
                  #"       NULL, ",
                  "       COALESCE(imaa116,0) imaa116 "
#   #end add-point
#   LET g_select = " SELECT debnent,gzoul_t.gzoul003,debnsite,ooefl003,imaa_t.imaa154,imaa_t.imaa133, 
#       NULL,imaa_t.imaa126,NULL,imaa_t.imaa127,NULL,imaa_t.imaa132,NULL,imaa_t.imaa156,NULL,rtax_t.rtax006, 
#       NULL,rtax_t.rtax003,NULL,imaa_t.imaa009,NULL,imaa_t.imaa001,imaal_t.imaal003,debn016,inam_t.inam012, 
#       NULL,inam_t.inam014,NULL,imay_t.imay003,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM debn_t t0 ",
                "      LEFT JOIN ooefl_t ON ooeflent = t0.debnent AND ooefl001 = t0.debnsite AND ooefl002 = '",g_dlang,"' ",
                "      LEFT JOIN imaa_t ON imaaent = t0.debnent AND imaa001 = t0.debn005 ",
                "      LEFT JOIN rtax_t ON rtaxent = imaaent AND rtax001 = imaa009 ",
                "      LEFT JOIN inam_t ON inament = t0.debnent AND inam001 = t0.debn005 AND inam002 = t0.debn016 "
                
#   #end add-point
#    LET g_from = " FROM debn_t,ooefl_t,imaa_t,rtax_t,rtaxl_t,imaal_t,inam_t,inaml_t,imay_t,indc_t,indd_t, 
#        inaj_t,gzoul_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc ," AND t0.debnent = ",g_enterprise 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_where = g_where ,cl_sql_add_filter("debn_t")   #資料過濾功能
   LET g_sql = g_select_1 CLIPPED ," FROM (",g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ) "
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("debn_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "#######################g_sql:\n",g_sql
   #end add-point
   PREPARE aslr510_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr510_x01_curs CURSOR FOR aslr510_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr510_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr510_x01_ins_data()
DEFINE sr RECORD 
   debnent LIKE debn_t.debnent, 
   gzoul_t_gzoul003 LIKE gzoul_t.gzoul003, 
   debnsite LIKE debn_t.debnsite, 
   ooefl003 LIKE ooefl_t.ooefl003, 
   imaa_t_imaa154 LIKE imaa_t.imaa154, 
   imaa_t_imaa133 LIKE imaa_t.imaa133, 
   l_imaa133_desc LIKE type_t.chr500, 
   imaa_t_imaa126 LIKE imaa_t.imaa126, 
   l_imaa126_desc LIKE type_t.chr500, 
   imaa_t_imaa127 LIKE imaa_t.imaa127, 
   l_imaa127_desc LIKE type_t.chr500, 
   imaa_t_imaa132 LIKE imaa_t.imaa132, 
   l_imaa132_desc LIKE type_t.chr500, 
   imaa_t_imaa156 LIKE imaa_t.imaa156, 
   l_imaa156_desc LIKE type_t.chr500, 
   rtax_t_rtax006 LIKE rtax_t.rtax006, 
   l_rtax006_desc LIKE type_t.chr500, 
   rtax_t_rtax003 LIKE rtax_t.rtax003, 
   l_rtax003_desc LIKE type_t.chr500, 
   imaa_t_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr500, 
   imaa_t_imaa001 LIKE imaa_t.imaa001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   debn016 LIKE debn_t.debn016, 
   inam_t_inam012 LIKE inam_t.inam012, 
   l_inam012_desc LIKE type_t.chr500, 
   inam_t_inam014 LIKE inam_t.inam014, 
   l_inam014_desc LIKE type_t.chr500, 
   imay_t_imay003 LIKE imay_t.imay003, 
   l_smoney LIKE imaa_t.imaa116, 
   l_emoney LIKE imaa_t.imaa116, 
   l_sell_money LIKE imaa_t.imaa116, 
   l_adj_money LIKE imaa_t.imaa116, 
   l_in_money LIKE imaa_t.imaa116, 
   l_out_money LIKE imaa_t.imaa116, 
   l_snum LIKE type_t.num20, 
   l_in_num LIKE type_t.num20, 
   l_out_num LIKE type_t.num20, 
   l_sell_num LIKE type_t.num20, 
   l_adj_num LIKE type_t.num20, 
   l_enum LIKE type_t.num20
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_field_title_flag    LIKE type_t.chr1   #取過特徵組title否
DEFINE l_oocql004            LIKE oocql_t.oocql004
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_field_title_flag = 'N'
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr510_x01_curs INTO sr.*                               
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
       
       IF l_field_title_flag = 'N' AND (NOT cl_null(sr.debn016)) THEN
          #特徵一值
          #特徵一值說明
          LET l_oocql004 = ''
          SELECT oocql004 INTO l_oocql004
            FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '273' 
             AND oocql002 = (SELECT inam011 FROM inam_t 
                              WHERE inament = oocqlent 
                                AND inam001 = sr.imaa_t_imaa001
                                AND inam002 = sr.debn016 )
             AND oocql003 = g_dlang 
          LET g_xg_fieldname[24] = l_oocql004
          LET g_xg_fieldname[25] = l_oocql004,s_desc_get_error_desc('sub-01386')
          #特徵二值
          #特徵二值說明
          LET l_oocql004 = ''
          SELECT oocql004 INTO l_oocql004
            FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '273' 
             AND oocql002 = (SELECT inam013 FROM inam_t 
                              WHERE inament = oocqlent 
                                AND inam001 = sr.imaa_t_imaa001
                                AND inam002 = sr.debn016 )
             AND oocql003 = g_dlang 
          LET g_xg_fieldname[26] = l_oocql004   
          LET g_xg_fieldname[27] = l_oocql004,s_desc_get_error_desc('sub-01386')
          IF NOT cl_null(g_xg_fieldname[24]) THEN
             LET l_field_title_flag = 'Y'
          END IF
       END IF
       CALL s_num_round('1',sr.l_smoney,2)     RETURNING sr.l_smoney
       CALL s_num_round('1',sr.l_emoney,2)     RETURNING sr.l_emoney
       CALL s_num_round('1',sr.l_sell_money,2) RETURNING sr.l_sell_money
       CALL s_num_round('1',sr.l_in_money,2)   RETURNING sr.l_in_money
       CALL s_num_round('1',sr.l_out_money,2)  RETURNING sr.l_out_money
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.debnent,sr.gzoul_t_gzoul003,sr.debnsite,sr.ooefl003,sr.imaa_t_imaa154,sr.imaa_t_imaa133,sr.l_imaa133_desc,sr.imaa_t_imaa126,sr.l_imaa126_desc,sr.imaa_t_imaa127,sr.l_imaa127_desc,sr.imaa_t_imaa132,sr.l_imaa132_desc,sr.imaa_t_imaa156,sr.l_imaa156_desc,sr.rtax_t_rtax006,sr.l_rtax006_desc,sr.rtax_t_rtax003,sr.l_rtax003_desc,sr.imaa_t_imaa009,sr.l_imaa009_desc,sr.imaa_t_imaa001,sr.imaal_t_imaal003,sr.inam_t_inam012,sr.l_inam012_desc,sr.inam_t_inam014,sr.l_inam014_desc,sr.imay_t_imay003,sr.l_smoney,sr.l_emoney,sr.l_sell_money,sr.l_adj_money,sr.l_in_money,sr.l_out_money,sr.l_snum,sr.l_in_num,sr.l_out_num,sr.l_sell_num,sr.l_adj_num,sr.l_enum
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr510_x01_execute"
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
 
{<section id="aslr510_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr510_x01_rep_data()
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
 
{<section id="aslr510_x01.other_function" readonly="Y" >}

 
{</section>}
 
