#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr845_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-08-02 10:11:57), PR版次:0002(2016-08-02 10:21:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: acrr845_x01
#+ Description: ...
#+ Creator....: 07959(2016-05-03 16:11:10)
#+ Modifier...: 08734 -SD/PR- 08734
 
{</section>}
 
{<section id="acrr845_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01,acrr845_x01_deba ——> acrr845_tmp02
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
       chk STRING,                  #是否勾选会员 
       sdate LIKE type_t.dat,         #startdate 
       edate LIKE type_t.dat,         #enddate 
       type LIKE type_t.chr1,         #排序方式 
       num LIKE type_t.num10          #TOP NUM
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql_temp          STRING         #备份查询主商品信息
DEFINE g_sql_temp_num      STRING         #查询主商品个数
DEFINE g_sql_temp_goods    STRING         #查询主商品的商品编号
DEFINE g_sql_minor         STRING         #查询与主商品同一张销售单上 子商品编号及次数
DEFINE g_sql_minor_goods   STRING         #查询与主商品同一张销售单上 子商品编号
DEFINE g_sql_minor_num     STRING         #查询与主商品同一张销售单上 子商品次数
#end add-point
 
{</section>}
 
{<section id="acrr845_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr845_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.chk  是否勾选会员 
DEFINE  p_arg3 LIKE type_t.dat         #tm.sdate  startdate 
DEFINE  p_arg4 LIKE type_t.dat         #tm.edate  enddate 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.type  排序方式 
DEFINE  p_arg6 LIKE type_t.num10         #tm.num  TOP NUM
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
   LET tm.sdate = p_arg3
   LET tm.edate = p_arg4
   LET tm.type = p_arg5
   LET tm.num = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"
 
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr845_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr845_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr845_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr845_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr845_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr845_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr845_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr845_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "deba009.deba_t.deba009,l_debal011.imaal_t.imaal004,deba026.deba_t.deba026,deba027.deba_t.deba027,deba021.deba_t.deba021,deba029.deba_t.deba029,l_rtjbl004_1.rtjb_t.rtjb004,l_rtjbl004_11.imaal_t.imaal004,l_rtjbl004_12.type_t.num20_6,l_rtjbl004_2.rtjb_t.rtjb004,l_rtjbl004_21.imaal_t.imaal004,l_rtjbl004_22.type_t.num20_6,l_rtjbl004_3.rtjb_t.rtjb004,l_rtjb004_31.imaal_t.imaal004,l_rtjb004_32.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE acrr845_tmp01    #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
   CREATE TEMP TABLE acrr845_tmp01(   #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
       rtjb004    VARCHAR(40),               #主商品
       rtjb004_1  VARCHAR(40),               #关联商品
       rtjb_rate  DECIMAL(20,6),               #关联度
       rtjbdocno  VARCHAR(20),               #销售单号
       num1       DECIMAL(20,6),               #主商品出现的次数
       num2       DECIMAL(20,6),               #关联商品出现的次数
       num3       DECIMAL(20,6)     #关联度排名
       );
   DROP TABLE acrr845_tmp02      #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
   CREATE TEMP TABLE acrr845_tmp02(   #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
       deba009        VARCHAR(40),           #商品编号
       l_debal011     VARCHAR(255),         #商品名称
       deba026        DECIMAL(20,6),           #销售金额
       deba027        DECIMAL(20,6),           #销售毛利
       deba021        DECIMAL(20,6),           #销售数量
       deba029        DECIMAL(20,6),           #消费次数
       l_rtjbl004_1   VARCHAR(40),           #关联商品1
       l_rtjbl004_11  VARCHAR(255),         #关联商品1名称
       l_rtjbl004_12  DECIMAL(20,6),           #关联度
       l_rtjbl004_2   VARCHAR(40),           #关联商品2
       l_rtjbl004_21  VARCHAR(255),         #关联商品2名称
       l_rtjbl004_22  DECIMAL(20,6),           #关联度
       l_rtjbl004_3   VARCHAR(40),           #关联商品3
       l_rtjb004_31   VARCHAR(255),         #关联商品3名称
       l_rtjb004_32   DECIMAL(20,6)     #关联度
       );
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr845_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr845_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?)"
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
 
{<section id="acrr845_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr845_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_where       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT deba009,trim(deba011)||'.'||trim(deba012),deba026,deba027,deba021,deba029, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   IF tm.chk = 'N' THEN    #没有勾选会员
      LET g_select = " SELECT deba009,trim(deba011)||'.'||trim(deba012),deba026,deba027,deba021,deba029,'','','','','','','','',''"
   ELSE
      LET g_select = " SELECT deca009,trim(deca011)||'.'||trim(deca012),deca027,deca028,deca022,deca031,'','','','','','','','',''"
   END IF
#   #end add-point
#    LET g_from = " FROM deba_t,rtab_t,rtjb_t,deca_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   IF tm.chk = 'N' THEN    #没有勾选会员
      LET g_from = " FROM deba_t ,rtab_t"
   ELSE                    #勾选会员
      LET g_from = " FROM deca_t ,rtab_t"
   END IF  
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("deba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM acrr845_tmp02 "    #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
   CASE tm.type
      WHEN '1' LET g_sql = g_sql," ORDER BY deba026 DESC"
      WHEN '2' LET g_sql = g_sql," ORDER BY deba027 DESC"
      WHEN '3' LET g_sql = g_sql," ORDER BY deba021 DESC"
      WHEN '4' LET g_sql = g_sql," ORDER BY deba029 DESC"
   END CASE
                
   #end add-point
   PREPARE acrr845_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr845_x01_curs CURSOR FOR acrr845_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr845_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr845_x01_ins_data()
DEFINE sr RECORD 
   deba009 LIKE deba_t.deba009, 
   l_debal011 LIKE imaal_t.imaal004, 
   deba026 LIKE deba_t.deba026, 
   deba027 LIKE deba_t.deba027, 
   deba021 LIKE deba_t.deba021, 
   deba029 LIKE deba_t.deba029, 
   l_rtjbl004_1 LIKE rtjb_t.rtjb004, 
   l_rtjbl004_11 LIKE imaal_t.imaal004, 
   l_rtjbl004_12 LIKE type_t.num20_6, 
   l_rtjbl004_2 LIKE rtjb_t.rtjb004, 
   l_rtjbl004_21 LIKE imaal_t.imaal004, 
   l_rtjbl004_22 LIKE type_t.num20_6, 
   l_rtjbl004_3 LIKE rtjb_t.rtjb004, 
   l_rtjb004_31 LIKE imaal_t.imaal004, 
   l_rtjb004_32 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    CALL acrr845_x01_ins_temptab()   #数据处理，INSERT到临时表
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr845_x01_curs INTO sr.*                               
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
         
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.deba009,sr.l_debal011,sr.deba026,sr.deba027,sr.deba021,sr.deba029,sr.l_rtjbl004_1,sr.l_rtjbl004_11,sr.l_rtjbl004_12,sr.l_rtjbl004_2,sr.l_rtjbl004_21,sr.l_rtjbl004_22,sr.l_rtjbl004_3,sr.l_rtjb004_31,sr.l_rtjb004_32
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr845_x01_execute"
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
 
{<section id="acrr845_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr845_x01_rep_data()
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
 
{<section id="acrr845_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 数据新增到临时表
# Memo...........:
# Usage..........: CALL acrr845_x01_ins_temptab()
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20160602 By shiwya
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr845_x01_ins_temptab()
 DEFINE l_where  STRING
 DEFINE l_where1 STRING
 DEFINE l_where2 STRING
 
#   CREATE TEMP TABLE acrr845_x01_deba(
#       deba009       LIKE deba_t.deba009,      #商品编号
#       l_debal011    LIKE imaal_t.imaal004,    #商品名称
#       deba026       LIKE deba_t.deba026,      #销售金额
#       deba027       LIKE deba_t.deba027,      #销售毛利
#       deba021       LIKE deba_t.deba021,      #销售数量
#       deba029       LIKE deba_t.deba029,      #消费次数
#       l_rtjbl004_1  LIKE rtjb_t.rtjb004,      #关联商品1
#       l_rtjbl004_11 LIKE imaal_t.imaal004,    #关联商品1名称
#       l_rtjbl004_12 LIKE type_t.num20_6,      #关联度
#       l_rtjbl004_2  LIKE rtjb_t.rtjb004,      #关联商品2
#       l_rtjbl004_21 LIKE imaal_t.imaal004,    #关联商品2名称
#       l_rtjbl004_22 LIKE type_t.num20_6,      #关联度
#       l_rtjbl004_3  LIKE rtjb_t.rtjb004,      #关联商品3
#       l_rtjb004_31  LIKE imaal_t.imaal004,    #关联商品3名称
#       l_rtjb004_32  LIKE type_t.num20_6       #关联度
#       )
#   CREATE TEMP TABLE acrr845_x01_rtjb(
#       rtjb004   LIKE rtjb_t.rtjb004,          #主商品
#       rtjb004_1 LIKE rtjb_t.rtjb004,          #关联商品
#       rtjb_rate LIKE type_t.num20_6,          #关联度
#       rtjbdocno LIKE rtjb_t.rtjb001,          #销售单号
#       num1      LIKE type_t.num20_6,          #主商品出现的次数
#       num2      LIKE type_t.num20_6,          #关联商品出现的次数
#       num3      LIKE type_t.num20_6           #关联度排名
#       )
       
       
   #第1步，把前TOP NUM笔商品的数据新增到临时表acrr845_x01_deba中
   IF NOT cl_null(tm.sdate) THEN
      LET l_where = l_where," AND deba002 >= to_date('",tm.sdate,"','yy/mm/dd') "
   END IF
   IF  NOT cl_null(tm.edate) THEN
      LET l_where = l_where," AND deba002 <= to_date('",tm.edate,"','yy/mm/dd') "
   END IF
   
   IF tm.chk = 'N' THEN    #没有勾选会员
      LET g_sql = " SELECT DISTINCT deba009,trim(deba011)||'.'||trim(deba012) t,",
                  "        SUM(deba026) a,SUM(deba027) b,SUM(deba021) c,SUM(deba021)/(CASE WHEN SUM(deba029)=0 THEN 1 ELSE SUM(deba029) END ) d",
                  "   FROM deba_t LEFT JOIN rtab_t ON debaent = rtabent AND debasite = rtab002 ",
                  "  WHERE ",tm.wc CLIPPED,l_where,
                  "  GROUP BY deba009,trim(deba011)||'.'||trim(deba012) "
   ELSE                    #勾选会员
      LET g_sql = " SELECT DISTINCT deca009,trim(deca011)||'.'||trim(deca012) t,",
                  "        SUM(deca027) a,SUM(deca028) b,SUM(deca022) c,SUM(deca022)/(CASE WHEN SUM(deca031)=0 THEN 1 ELSE SUM(deca031) END) d",
                  "   FROM deca_t LEFT JOIN rtab_t ON decaent = rtabent AND decasite = rtab002 ",
                  "  WHERE ",tm.wc CLIPPED,l_where,
                  "  GROUP BY deca009,trim(deca011)||'.'||trim(deca012)"
   END IF
   LET g_sql = " SELECT deba009,t,a,b,c,d,'','','','','','','','','' FROM(",g_sql,") ",
               "  WHERE ROWNUM <= ",tm.num
   CASE tm.type
      WHEN '1' LET g_sql = g_sql," ORDER BY a DESC"
      WHEN '2' LET g_sql = g_sql," ORDER BY b DESC"
      WHEN '3' LET g_sql = g_sql," ORDER BY c DESC"
      WHEN '4' LET g_sql = g_sql," ORDER BY d DESC"
   END CASE
   LET g_sql = " INSERT INTO acrr845_tmp02 ",g_sql     #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
   PREPARE acrr845_x01_ins_temptab_p1 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p1
   
   #第2步，按照临时表里面的商品抓关联所有的关联商品 insert 到acrr845_x01_rtjb
   DELETE FROM acrr845_tmp01     #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
   LET l_where1 = cl_replace_str(l_where,'deba002','e.rtja006')
   LET l_where2 = cl_replace_str(l_where,'deba002','f.rtja006')
   IF tm.chk='N' THEN
      LET g_sql="INSERT INTO acrr845_tmp01(rtjb004,rtjb004_1,rtjbdocno)",    #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
               " SELECT DISTINCT a.rtjb004,b.rtjb004,a.rtjbdocno ",
                 " FROM acrr845_tmp02,",       #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
                 "      rtjb_t a LEFT JOIN rtja_t e ON e.rtjaent=a.rtjbent AND e.rtjadocno=a.rtjbdocno AND e.rtja001 IS NULL AND e.rtja032<>'4',",
                 "      rtjb_t b LEFT JOIN rtja_t f ON f.rtjaent=b.rtjbent AND f.rtjadocno=b.rtjbdocno AND f.rtja001 IS NULL AND f.rtja032<>'4' ",
                 " WHERE a.rtjb004 = deba009 ",
                  " AND a.rtjbent='",g_enterprise,"'",
                  " AND b.rtjbent='",g_enterprise,"'",
                  " AND a.rtjbdocno=b.rtjbdocno",
                  " AND b.rtjb004<>deba009 ",l_where1,l_where2
   ELSE
      LET g_sql="INSERT INTO acrr845_tmp01(rtjb004,rtjb004_1,rtjbdocno)",     #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
               " SELECT DISTINCT a.rtjb004,b.rtjb004,a.rtjbdocno ",
                 " FROM acrr845_tmp02,",    #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
                 "      rtjb_t a LEFT JOIN rtja_t e ON e.rtjaent=a.rtjbent AND e.rtjadocno=a.rtjbdocno AND e.rtja001 IS NOT NULL AND e.rtja032<>'4',",
                 "      rtjb_t b LEFT JOIN rtja_t f ON f.rtjaent=b.rtjbent AND f.rtjadocno=b.rtjbdocno AND f.rtja001 IS NOT NULL AND f.rtja032<>'4' ",
                 " WHERE a.rtjb004 = deba009 ",
                  " AND a.rtjbent='",g_enterprise,"'",
                  " AND b.rtjbent='",g_enterprise,"'",
                  " AND a.rtjbdocno=b.rtjbdocno",
                  " AND b.rtjb004<>deba009 ",l_where1,l_where2
   END IF
   PREPARE acrr845_x01_ins_temptab_p2 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p2
   
   #第3步，更新临时表acrr845_x01_rtjb中商品的关联度（num2/num1）和排名（按关联度逆序排序更新名次num3）
   LET g_sql = " MERGE INTO acrr845_tmp01 ",     #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
               " USING (SELECT rtjb004 aaa,COUNT(rtjbdocno) num ",
               "          FROM acrr845_tmp01 ",   #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
               "         GROUP BY rtjb004 ",
               "        ) ",
               " ON (rtjb004 = aaa)",
               " WHEN MATCHED THEN  ",
               "   UPDATE SET num1 = num "
   PREPARE acrr845_x01_ins_temptab_p3 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p3
   LET g_sql = " MERGE INTO acrr845_tmp01 ",     #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
               " USING (SELECT rtjb004 aaa,rtjb004_1 aaa_1,COUNT(rtjbdocno) num ",
               "          FROM acrr845_tmp01 ",   #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
               "         GROUP BY rtjb004,rtjb004_1 ",
               "        ) ",
               " ON (rtjb004 = aaa AND rtjb004_1 = aaa_1)",
               " WHEN MATCHED THEN  ",
               "   UPDATE SET num2 = num "
   PREPARE acrr845_x01_ins_temptab_p4 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p4
   LET g_sql = " MERGE INTO acrr845_tmp01 ",    #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
               " USING (SELECT DISTINCT rtjb004 aaa,rtjb004_1 aaa_1,rtjbdocno aaa_docno,",
               "               dense_rank() over(PARTITION BY rtjb004 ORDER BY rtjb004,num2 DESC,rtjb004_1) num ",
               "          FROM acrr845_tmp01 ",    #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
              #"         GROUP BY rtjb004,rtjb004_1,num2 ",
               "        ) ",
               " ON (rtjb004 = aaa AND rtjb004_1 = aaa_1 AND rtjbdocno = aaa_docno)",
               " WHEN MATCHED THEN  ",
               "   UPDATE SET num3 = num "
   PREPARE acrr845_x01_ins_temptab_p5 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p5
   
   #第4步，抓临时表acrr845_x01_rtjb中关联度前三名，更新到临时表acrr845_x01_deba的关联商品1/2/3
   #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
   LET g_sql = " MERGE INTO acrr845_tmp02 ",    #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
               " USING (SELECT DISTINCT rtjb004,rtjb004_1,num1,num2,num3,imaal003 ",
               "          FROM acrr845_tmp01 LEFT JOIN imaal_t ON (imaalent=",g_enterprise," AND imaal001 = rtjb004_1 AND imaal002 = '",g_dlang,"')  ",
               "         WHERE num3 = 1 ",
               "        ) ",
               " ON (rtjb004 = deba009)",
               " WHEN MATCHED THEN  ",
               "   UPDATE SET l_rtjbl004_1 = rtjb004_1,l_rtjbl004_11=imaal003,l_rtjbl004_12=num2/num1 "
   PREPARE acrr845_x01_ins_temptab_p6 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p6
   #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
   LET g_sql = " MERGE INTO acrr845_tmp02 ",     #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
               " USING (SELECT DISTINCT rtjb004,rtjb004_1,num1,num2,num3,imaal003 ",
               "          FROM acrr845_tmp01 LEFT JOIN imaal_t ON (imaalent=",g_enterprise," AND imaal001 = rtjb004_1 AND imaal002 = '",g_dlang,"')  ",
               "         WHERE num3 = 2 ",
               "        ) ",
               " ON (rtjb004 = deba009)",
               " WHEN MATCHED THEN  ",
               "   UPDATE SET l_rtjbl004_2 = rtjb004_1,l_rtjbl004_21=imaal003,l_rtjbl004_22=num2/num1 "
   PREPARE acrr845_x01_ins_temptab_p7 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p7
   #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_rtjb ——> acrr845_tmp01
   LET g_sql = " MERGE INTO acrr845_tmp02 ",     #160727-00019#7   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 acrr845_x01_deba ——> acrr845_tmp02
               " USING (SELECT DISTINCT rtjb004,rtjb004_1,num1,num2,num3,imaal003 ",
               "          FROM acrr845_tmp01 LEFT JOIN imaal_t ON (imaalent=",g_enterprise," AND imaal001 = rtjb004_1 AND imaal002 = '",g_dlang,"') ",
               "         WHERE num3 = 3 ",
               "        ) ",
               " ON (rtjb004 = deba009)",
               " WHEN MATCHED THEN  ",
               "   UPDATE SET l_rtjbl004_3 = rtjb004_1,l_rtjb004_31=imaal003,l_rtjb004_32=num2/num1 "
   PREPARE acrr845_x01_ins_temptab_p8 FROM g_sql
   EXECUTE acrr845_x01_ins_temptab_p8
END FUNCTION

 
{</section>}
 
