#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr751_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-09-29 09:19:29), PR版次:0001(2016-02-23 10:07:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000065
#+ Filename...: acrr751_x02
#+ Description: ...
#+ Creator....: 03247(2014-09-28 10:35:19)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="acrr751_x02.global" readonly="Y" >}
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
       year1 LIKE oogb_t.oogb010,         #input condition 
       year2 LIKE oogb_t.oogb010,         #input condition 
       week1 LIKE ooga_t.ooga011,         #input condition 
       week2 LIKE ooga_t.ooga011          #input condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr751_x02.main" readonly="Y" >}
PUBLIC FUNCTION acrr751_x02(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE oogb_t.oogb010         #tm.year1  input condition 
DEFINE  p_arg3 LIKE oogb_t.oogb010         #tm.year2  input condition 
DEFINE  p_arg4 LIKE ooga_t.ooga011         #tm.week1  input condition 
DEFINE  p_arg5 LIKE ooga_t.ooga011         #tm.week2  input condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.year1 = p_arg2
   LET tm.year2 = p_arg3
   LET tm.week1 = p_arg4
   LET tm.week2 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr751_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr751_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr751_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr751_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr751_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr751_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr751_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr751_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_year.type_t.num5,ooga011.ooga_t.ooga011,l_mmaf.type_t.chr500,l_rtaa.type_t.chr500,l_site.type_t.chr500,l_oocq.type_t.chr500,deca027.deca_t.deca027,deca028.deca_t.deca028,deca022.deca_t.deca022,deca031.deca_t.deca031,l_price.type_t.num10,l_amount.type_t.num10" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr751_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr751_x02_ins_prep()
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
             ?,?,?,?,?,?)"
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
 
{<section id="acrr751_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr751_x02_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sdate       LIKE decb_t.decb002
DEFINE l_edate       LIKE decb_t.decb002
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #取年度/週別的開始日期和結束日期
   SELECT MIN(oogc003) INTO l_sdate FROM oogc_t,ooef_t
    WHERE oogcent = ooefent AND oogcent = g_enterprise
      AND ooef001 = g_site AND oogc001 = ooef008 
      AND oogc002 = '3' 
      AND oogc015 = tm.year1
      AND oogc008 = tm.week1
   SELECT MAX(oogc003) INTO l_edate FROM oogc_t,ooef_t
    WHERE oogcent = ooefent AND oogcent = g_enterprise
      AND ooef001 = g_site AND oogc001 = ooef008 
      AND oogc002 = '3' 
      AND oogc015 = tm.year2
      AND oogc008 = tm.week2
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT NULL,ooga011,deca020,mmaf_t.mmaf008,NULL,rtab_t.rtab001,rtaal_t.rtaal003, 
       NULL,decasite,ooefl_t.ooefl003,NULL,oocq_t.oocq002,oocql_t.oocql004,NULL,deca027,deca028,deca022, 
       deca031,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT substr(to_char(deca002,'YYYYMMDD'),1,4),oogc008,deca020,mmaf_t.mmaf008,NULL,rtab_t.rtab001,rtaal_t.rtaal003,
       NULL,decasite,ooefl_t.ooefl003,NULL,oocq_t.oocq002,oocql_t.oocql004,NULL,SUM(deca027),SUM(deca028),SUM(deca022), 
       SUM(deca031),NULL,NULL"
   #end add-point
    LET g_from = " FROM deca_t,ooga_t,rtab_t,oocq_t,mmaf_t,rtaal_t,ooefl_t,oocql_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM deca_t LEFT OUTER JOIN oocq_t ON decaent = oocqent AND oocq001 = '2001' ",
                "             LEFT OUTER JOIN mmaf_t ON decaent = mmafent AND deca020 = mmaf001 ",
                "             LEFT OUTER JOIN ooefl_t ON decaent = ooeflent AND decasite = ooefl001 AND ooefl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                "     ,ooef_t,oogc_t,rtak_t,rtab_t LEFT OUTER JOIN rtaal_t ON rtabent = rtaalent AND rtab001 = rtaal001 AND rtaal002 = '",g_dlang,"' "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = g_where," AND decaent = ",g_enterprise," ",
                         " AND (deca027/deca022 BETWEEN oocq009 AND oocq010) ",
                         " AND deca022 <> 0 ",
                         " AND oocqstus = 'Y' ",
                         #" AND (substr(to_char(deca002,'YYYYMMDD'),1,4) BETWEEN ",tm.year1," AND ",tm.year2,") ",
                         #" AND (ooga011 BETWEEN ",tm.week1," AND ",tm.week2,") ",
                         " AND oogcent = decaent AND ooefent = decaent ",
                         " AND ooef001 = decasite AND oogc001 = ooef008 ",
                         " AND oogc002 = '3' AND oogc003 = deca002 ",
                         " AND (deca002 BETWEEN '",l_sdate,"' AND '",l_edate,"') ",
                         " AND decaent = rtabent AND decasite = rtab002 ",
                         " AND rtakent = rtabent AND rtak001 = rtab001 AND rtak002 = '1' AND rtak003 = 'Y' "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("deca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," GROUP BY substr(to_char(deca002,'YYYYMMDD'),1,4),oogc008,deca020,mmaf_t.mmaf008,rtab_t.rtab001,rtaal_t.rtaal003, ",
                     "          decasite,ooefl_t.ooefl003,oocq_t.oocq002,oocql_t.oocql004 ",                    
                     " ORDER BY substr(to_char(deca002,'YYYYMMDD'),1,4),oogc008,deca020,rtab_t.rtab001,decasite,oocq_t.oocq002 "
   #end add-point
   PREPARE acrr751_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr751_x02_curs CURSOR FOR acrr751_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr751_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr751_x02_ins_data()
DEFINE sr RECORD 
   l_year LIKE type_t.num5, 
   ooga011 LIKE ooga_t.ooga011, 
   deca020 LIKE deca_t.deca020, 
   mmaf_t_mmaf008 LIKE mmaf_t.mmaf008, 
   l_mmaf LIKE type_t.chr500, 
   rtab_t_rtab001 LIKE rtab_t.rtab001, 
   rtaal_t_rtaal003 LIKE rtaal_t.rtaal003, 
   l_rtaa LIKE type_t.chr500, 
   decasite LIKE deca_t.decasite, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   l_site LIKE type_t.chr500, 
   oocq_t_oocq002 LIKE oocq_t.oocq002, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_oocq LIKE type_t.chr500, 
   deca027 LIKE deca_t.deca027, 
   deca028 LIKE deca_t.deca028, 
   deca022 LIKE deca_t.deca022, 
   deca031 LIKE deca_t.deca031, 
   l_price LIKE type_t.num10, 
   l_amount LIKE type_t.num10
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr751_x02_curs INTO sr.*                               
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
       IF cl_null(sr.mmaf_t_mmaf008) THEN
          LET sr.mmaf_t_mmaf008 = ' '
       END IF
       IF cl_null(sr.rtaal_t_rtaal003) THEN
          LET sr.rtaal_t_rtaal003 = ' '
       END IF
       IF cl_null(sr.ooefl_t_ooefl003) THEN
          LET sr.ooefl_t_ooefl003 = ' '
       END IF
       IF cl_null(sr.oocql_t_oocql004) THEN
          LET sr.oocql_t_oocql004 = ' '
       END IF
       
       LET sr.l_mmaf = sr.deca020||'.'||sr.mmaf_t_mmaf008
       LET sr.l_rtaa = sr.rtab_t_rtab001||'.'||sr.rtaal_t_rtaal003
       LET sr.l_site = sr.decasite||'.'||sr.ooefl_t_ooefl003
       LET sr.l_oocq = sr.oocq_t_oocq002||'.'||sr.oocql_t_oocql004
       LET sr.l_price = sr.deca027/sr.deca031
       LET sr.l_amount = sr.deca022/sr.deca031
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_year,sr.ooga011,sr.l_mmaf,sr.l_rtaa,sr.l_site,sr.l_oocq,sr.deca027,sr.deca028,sr.deca022,sr.deca031,sr.l_price,sr.l_amount
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr751_x02_execute"
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
 
{<section id="acrr751_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr751_x02_rep_data()
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
 
{<section id="acrr751_x02.other_function" readonly="Y" >}

 
{</section>}
 
