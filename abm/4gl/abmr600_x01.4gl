#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr600_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2016-12-05 15:25:56), PR版次:0010(2016-12-05 15:55:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: abmr600_x01
#+ Description: ...
#+ Creator....: 01996(2015-05-27 09:39:08)
#+ Modifier...: 08734 -SD/PR- 08734
 
{</section>}
 
{<section id="abmr600_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160510-00019#15  2016-5-31  By zhujing      效能优化
#160728-00007#1   2016-7-28  By zhujing      添加主件的标准工时，标准机时，以及主件的材料成本、人工成本、制造费用、委外加工、成本合计要加上
#160801-00014#1   2016-8-03  By zhujing      主件添加人工率，制费率
#160831-00073#1   2016-9-01  By wuxja        抓成本单价时sql条件有误
#161110-00016#1   2016-11-14 By ywtsai       計算標準用量時，需參考各上階用量比率
#161115-00039#1   2016-11-15 By ywtsai       修正161110-00016#1對於g_stduseqty給值的時機
#161124-00048#1   2016/12/05 By 08734        星号整批调整
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
       wc STRING,                  #條件 
       price STRING,                  #單價條件 
       con2 STRING,                  #採購價為0時 
       sal LIKE type_t.num15_3,         #每小時工資率 
       cost LIKE type_t.num15_3,         #每小時制費率 
       last STRING,                  #展至尾階 
       times STRING                   #有效日期
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
   DEFINE g_type     LIKE type_t.num20
   DEFINE g_pid      LIKE type_t.num20
   DEFINE g_id       LIKE type_t.num20
   DEFINE g_first    LIKE type_t.chr1
   DEFINE g_bom      LIKE type_t.num5
   DEFINE g_dead     LIKE type_t.chr1
   DEFINE g_cnt      LIKE type_t.num5
   DEFINE g_stduseqty LIKE bmba_t.bmba011    #161110-00016#1 add---記錄上階標準用量
#end add-point
 
{</section>}
 
{<section id="abmr600_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmr600_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  條件 
DEFINE  p_arg2 STRING                  #tm.price  單價條件 
DEFINE  p_arg3 STRING                  #tm.con2  採購價為0時 
DEFINE  p_arg4 LIKE type_t.num15_3         #tm.sal  每小時工資率 
DEFINE  p_arg5 LIKE type_t.num15_3         #tm.cost  每小時制費率 
DEFINE  p_arg6 STRING                  #tm.last  展至尾階 
DEFINE  p_arg7 STRING                  #tm.times  有效日期
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.price = p_arg2
   LET tm.con2 = p_arg3
   LET tm.sal = p_arg4
   LET tm.cost = p_arg5
   LET tm.last = p_arg6
   LET tm.times = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abmr600_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmr600_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmr600_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmr600_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmr600_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmr600_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr600_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmr600_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_bmba009.type_t.chr500,l_bmaa001_bmaa002.type_t.chr500,l_imaal003_1.imaal_t.imaal003,l_imaal004_1.imaal_t.imaal004,l_vdate.type_t.dat,l_bmba011.bmba_t.bmba011,l_bmba010.bmba_t.bmba010,l_price_1.type_t.num15_3,l_cmount.type_t.num20_6,l_imae051_1.imae_t.imae051,l_salary.type_t.num15_3,l_rmount.type_t.num20_6,l_imae052_1.type_t.num15_3,l_cost.type_t.num15_3,l_zmount.type_t.num20_6,l_bmba011_1.type_t.num15_3,l_bmba010_2.bmba_t.bmba010,l_price_2.type_t.num15_3,l_jmount.type_t.num20_6,l_current_sum.type_t.num20_6,l_ne_mate.type_t.num20_6,l_ne_arti.type_t.num20_6,l_ne_fee.type_t.num20_6,l_ne_mach.type_t.num20_6,l_ne_total.type_t.num20_6,l_total.type_t.num20_6,l_type.type_t.num20,l_pid.type_t.num20,l_id.type_t.num20" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
#   LET g_sql = "l_bmba009.type_t.chr1000,l_bmba003.bmba_t.bmba003,l_imaal003_2.imaal_t.imaal003,l_imaal004_2.imaal_t.imaal004,l_bmba011.bmba_t.bmba011,l_bmba010.bmba_t.bmba010,l_price_1.type_t.num15_3,l_cmount.type_t.num20_6,l_imae051_1.imae_t.imae051,l_salary.type_t.num15_3,l_rmount.type_t.num20_6,l_imae052_1.imae_t.imae052,l_cost.type_t.num15_3,l_zmount.type_t.num20_6,l_bmba011_1.bmba_t.bmba011,l_bmba010_2.bmba_t.bmba010,l_price_2.type_t.num15_3,l_jmount.type_t.num20_6,l_current_sum.type_t.num20_6,l_bmba022.bmba_t.bmba022,l_bmba012.bmba_t.bmba012,l_bmba001.bmba_t.bmba001,l_bmbaent.bmba_t.bmbaent,l_bmbasite.bmba_t.bmbasite,l_bmba002.bmba_t.bmba002" 
#   
#   #建立TEMP TABLE,主報表序號1 
#   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
#      LET g_rep_success = 'N'            
#   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmr600_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmr600_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
#         WHEN 2
#         #INSERT INTO PREP
#         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
#         PREPARE insert_prep1 FROM g_sql
#         IF STATUS THEN
#            LET l_prep_str ="insert_prep",i
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = l_prep_str
#            LET g_errparam.code   = status
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            CALL cl_xg_drop_tmptable()
#            LET g_rep_success = 'N'           
#         END IF 
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="abmr600_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr600_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql         STRING   #160510-00019#15 add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160510-00019#15 marked -S
#   LET g_sql  = "SELECT '','',imaal003,imaal004,'',bmaa001,bmaa002,'','','','','','','','','','','','','','','',bmaaent,bmaasite,'','',''",
#                " FROM bmaa_t LEFT OUTER JOIN imaal_t ON imaalent = bmaaent AND imaal001 = bmaa001 AND imaal002 = '",g_dlang,"'",
#                " WHERE ",tm.wc CLIPPED
   #160510-00019#15 marked -E
   #160510-00019#15 mod -S
   LET g_sql  = "SELECT DISTINCT '','',",
                " (SELECT imaal003 FROM imaal_t WHERE imaal001 = bmaa001 AND imaalent = bmaaent AND imaal002 = '",g_dlang,"') t1_imaal003,",
                " (SELECT imaal004 FROM imaal_t WHERE imaal001 = bmaa001 AND imaalent = bmaaent AND imaal002 = '",g_dlang,"') t1_imaal004,",
                #160728-00007#1 mod-S
#                " '',bmaa001,bmaa002,'','','','','','','','','','','','','','','',bmaaent,bmaasite,'','',''",
                #" '',bmaa001,bmaa002,'','','','',",  #160902-00023#1
                " '',bmaa001,bmaa002,'1',bmaa004,'','',",  #160902-00023#1
                " (SELECT imae051 FROM imae_t WHERE imae001 = bmaa001 AND imaeent = bmaaent AND bmaasite = imaesite) t2_imae051,",#标准工时
                " '",tm.sal,"','',",      #160801-00014#1 mod
#                " '','',",                #160801-00014#1 mod
                " (SELECT imae052 FROM imae_t WHERE imae001 = bmaa001 AND imaeent = bmaaent AND bmaasite = imaesite) t2_imae052,",#标准机时
                " '",tm.cost,"','','','','','','',",
                " '','','','','','',",    #160902-00023#1 add 
                " bmaaent,bmaasite,'','',''", #160801-00014#1 mod
#                " '','','','','','','',bmaaent,bmaasite,'','',''", #160801-00014#1 mod
                #160728-00007#1 mod-E
                " FROM bmaa_t ",
                " WHERE ",tm.wc CLIPPED
   #160510-00019#15 mod -E
 
#   #end add-point
#   LET g_select = " SELECT '','','','','',bmaa001,bmaa002,'','','','','','','','','','','','','','', 
#       '',NULL,NULL,NULL,NULL,NULL,NULL,bmaaent,bmaasite,'','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"


#   #end add-point
#    LET g_from = " FROM bmaa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
#   LET g_sql = g_select CLIPPED ,g_from CLIPPED ,g_where CLIPPED
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("bmaa_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #160902-00023#1---add---s
   LET l_sql  =" SELECT  ",
               " (SELECT imae051 FROM imae_t WHERE imae001 = bmaa001 AND imaeent = bmaaent AND imaesite = bmaasite) imae051,",
               " (SELECT imae052 FROM imae_t WHERE imae001 = bmaa001 AND imaeent = bmaaent AND imaesite = bmaasite) imae052,",
               " (SELECT imai021 FROM imai_t WHERE imai001 = bmaa001 AND imaient = bmaaent AND imaisite = bmaasite) imai021,",
               " (SELECT imai022 FROM imai_t WHERE imai001 = bmaa001 AND imaient = bmaaent AND imaisite = bmaasite) imai022,",
               " (SELECT imai023 FROM imai_t WHERE imai001 = bmaa001 AND imaient = bmaaent AND imaisite = bmaasite) imai023,",
               " (SELECT DISTINCT glaald FROM glaa_t WHERE glaaent = bmaaent AND glaa014 = 'Y' AND glaacomp = (SELECT DISTINCT ooef017 FROM ooef_t WHERE ooefent = bmaaent AND ooef001 = bmaasite )) glaald,",
               " (SELECT imaa006 FROM imaa_t WHERE imaa001 = bmaa001 AND imaaent = bmaaent) imaa006",
               " FROM bmaa_t ",
               " WHERE bmaaent = '",g_enterprise,"'",
               "   AND bmaa001 = ? AND bmaa002 = ? AND bmaasite = ?"
   PREPARE abmr600_x01_prepare_bmaa FROM l_sql
   DECLARE abmr600_x01_bmaa CURSOR FOR abmr600_x01_prepare_bmaa               
   #160902-00023#1---add---e
   #160510-00019#15 add -S
   LET l_sql = " SELECT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba009,bmba010,bmba011,bmba012,bmba022,",
               " (SELECT imaal003 FROM imaal_t WHERE imaal001 = bmba003 AND imaalent = bmbaent AND imaal002 = '",g_dlang,"') t1_imaal003,",
               " (SELECT imaal004 FROM imaal_t WHERE imaal001 = bmba003 AND imaalent = bmbaent AND imaal002 = '",g_dlang,"') t1_imaal004,",
               " (SELECT imae051 FROM imae_t WHERE imae001 = bmba003 AND imaeent = bmbaent AND imaesite = bmbasite) t2_imae051,",
               " (SELECT imae052 FROM imae_t WHERE imae001 = bmba003 AND imaeent = bmbaent AND imaesite = bmbasite) t2_imae052,",
               " (SELECT imai021 FROM imai_t WHERE imai001 = bmba003 AND imaient = bmbaent AND imaisite = bmbasite) t3_imai021,",
               " (SELECT imai022 FROM imai_t WHERE imai001 = bmba003 AND imaient = bmbaent AND imaisite = bmbasite) t3_imai022,",
               " (SELECT imai023 FROM imai_t WHERE imai001 = bmba003 AND imaient = bmbaent AND imaisite = bmbasite) t3_imai023,",
               " (SELECT DISTINCT glaald FROM glaa_t WHERE glaaent = bmbaent AND glaa014 = 'Y' AND glaacomp = (SELECT DISTINCT ooef017 FROM ooef_t WHERE ooefent = bmbaent AND ooef001 = bmbasite )) t4_glaald,",
               " (SELECT imaa006 FROM imaa_t WHERE imaa001 = bmba003 AND imaaent = bmbaent) t5_imaa006",
               "   FROM bmba_t ",
               "  WHERE bmbaent = ? ",
               "    AND bmbasite = ? ",
               "    AND bmba001 = ? ",
               "    AND bmba002 = ? ",
               "    AND to_char(bmba005,'yy-mm-dd') <= ? ",
               "    AND (to_char(bmba006,'yy-mm-dd') >= ? OR bmba006 IS NULL)",
               "    AND bmba019 <> '2'",
               "  ORDER BY bmba009"
   
   PREPARE abmr600_x01_prepare_bom FROM l_sql
   DECLARE abmr600_x01_bom CURSOR FOR abmr600_x01_prepare_bom
   
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM bmba_t ",
               " WHERE bmbaent = ? ",
               " AND bmbasite = ? ",
               " AND bmba001 = ? ",
               " AND bmba002 = ? ",
               " AND to_char(bmba005,'yy-mm-dd') <= ? ",
               " AND (to_char(bmba006,'yy-mm-dd') >= ? OR bmba006 IS NULL)",
               " AND bmba019 <> '2'"
   PREPARE abmr600_count FROM l_sql
   #160510-00019#15 add -E
   #end add-point
   PREPARE abmr600_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmr600_x01_curs CURSOR FOR abmr600_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr600_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr600_x01_ins_data()
DEFINE sr RECORD 
   l_bmba009 LIKE type_t.chr500, 
   l_bmaa001_bmaa002 LIKE type_t.chr500, 
   l_imaal003_1 LIKE imaal_t.imaal003, 
   l_imaal004_1 LIKE imaal_t.imaal004, 
   l_vdate LIKE type_t.dat, 
   bmaa001 LIKE bmaa_t.bmaa001, 
   bmaa002 LIKE bmaa_t.bmaa002, 
   l_bmba011 LIKE bmba_t.bmba011, 
   l_bmba010 LIKE bmba_t.bmba010, 
   l_price_1 LIKE type_t.num15_3, 
   l_cmount LIKE type_t.num20_6, 
   l_imae051_1 LIKE imae_t.imae051, 
   l_salary LIKE type_t.num15_3, 
   l_rmount LIKE type_t.num20_6, 
   l_imae052_1 LIKE type_t.num15_3, 
   l_cost LIKE type_t.num15_3, 
   l_zmount LIKE type_t.num20_6, 
   l_bmba011_1 LIKE type_t.num15_3, 
   l_bmba010_2 LIKE bmba_t.bmba010, 
   l_price_2 LIKE type_t.num15_3, 
   l_jmount LIKE type_t.num20_6, 
   l_current_sum LIKE type_t.num20_6, 
   l_ne_mate LIKE type_t.num20_6, 
   l_ne_arti LIKE type_t.num20_6, 
   l_ne_fee LIKE type_t.num20_6, 
   l_ne_mach LIKE type_t.num20_6, 
   l_ne_total LIKE type_t.num20_6, 
   l_total LIKE type_t.num20_6, 
   bmaaent LIKE bmaa_t.bmaaent, 
   bmaasite LIKE bmaa_t.bmaasite, 
   l_type LIKE type_t.num20, 
   l_pid LIKE type_t.num20, 
   l_id LIKE type_t.num20
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

   DEFINE l_type    LIKE type_t.num20
   DEFINE l_pid     LIKE type_t.num20
   DEFINE l_id      LIKE type_t.num20
   DEFINE l_success LIKE type_t.num5
   #modify--2015/06/24 By shiun--(S)
#   DEFINE l_a2      LIKE type_t.dat
   DEFINE l_a2     LIKE type_t.dat
   DEFINE l_sql      STRING      #160728-00007#1 add
   #160902-00023#1---add---s
   DEFINE l_rate     LIKE inaj_t.inaj014, 
          l_imae051  LIKE imae_t.imae051,
          l_imae052  LIKE imae_t.imae052,
          l_imai021  LIKE imai_t.imai021,          
          l_imai022  LIKE imai_t.imai022,       
          l_imai023  LIKE imai_t.imai023,       
          l_glaald   LIKE glaa_t.glaald,        
          l_imaa006  LIKE imaa_t.imaa006
  # DEFINE l_glaa RECORD LIKE glaa_t.*  #161124-00048#1 2016/12/05 By 08734 mark
   #161124-00048#1 2016/12/05 By 08734 add(S)
   DEFINE l_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企业编号
       glaaownid LIKE glaa_t.glaaownid, #资料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #资料所有部门
       glaacrtid LIKE glaa_t.glaacrtid, #资料录入者
       glaacrtdp LIKE glaa_t.glaacrtdp, #资料录入部门
       glaacrtdt LIKE glaa_t.glaacrtdt, #资料创建日
       glaamodid LIKE glaa_t.glaamodid, #资料更改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近更改日
       glaastus LIKE glaa_t.glaastus, #状态码
       glaald LIKE glaa_t.glaald, #账套编号
       glaacomp LIKE glaa_t.glaacomp, #归属法人
       glaa001 LIKE glaa_t.glaa001, #使用币种
       glaa002 LIKE glaa_t.glaa002, #汇率参照表号
       glaa003 LIKE glaa_t.glaa003, #会计周期参照表号
       glaa004 LIKE glaa_t.glaa004, #会计科目参照表号
       glaa005 LIKE glaa_t.glaa005, #现金变动参照表号
       glaa006 LIKE glaa_t.glaa006, #月结方式
       glaa007 LIKE glaa_t.glaa007, #年结方式
       glaa008 LIKE glaa_t.glaa008, #平行记账否
       glaa009 LIKE glaa_t.glaa009, #凭证登录方式
       glaa010 LIKE glaa_t.glaa010, #现行年度
       glaa011 LIKE glaa_t.glaa011, #现行期别
       glaa012 LIKE glaa_t.glaa012, #最后过账日期
       glaa013 LIKE glaa_t.glaa013, #关账日期
       glaa014 LIKE glaa_t.glaa014, #主账套
       glaa015 LIKE glaa_t.glaa015, #启用本位币二
       glaa016 LIKE glaa_t.glaa016, #本位币二
       glaa017 LIKE glaa_t.glaa017, #本位币二换算基准
       glaa018 LIKE glaa_t.glaa018, #本位币二汇率采用
       glaa019 LIKE glaa_t.glaa019, #启用本位币三
       glaa020 LIKE glaa_t.glaa020, #本位币三
       glaa021 LIKE glaa_t.glaa021, #本位币三换算基准
       glaa022 LIKE glaa_t.glaa022, #本位币三汇率采用
       glaa023 LIKE glaa_t.glaa023, #次账套账务生成时机
       glaa024 LIKE glaa_t.glaa024, #单据别参照表号
       glaa025 LIKE glaa_t.glaa025, #本位币一汇率采用
       glaa026 LIKE glaa_t.glaa026, #币种参照表号
       glaa100 LIKE glaa_t.glaa100, #凭证录入时自动按缺号生成
       glaa101 LIKE glaa_t.glaa101, #凭证总号录入时机
       glaa102 LIKE glaa_t.glaa102, #凭证成立时,借贷不平衡的处理方式
       glaa103 LIKE glaa_t.glaa103, #未打印的凭证可否进行过账
       glaa111 LIKE glaa_t.glaa111, #应计调整单别
       glaa112 LIKE glaa_t.glaa112, #期末结转单别
       glaa113 LIKE glaa_t.glaa113, #年底结转单别
       glaa120 LIKE glaa_t.glaa120, #成本计算类型
       glaa121 LIKE glaa_t.glaa121, #子模块启用分录底稿
       glaa122 LIKE glaa_t.glaa122, #总账可维护资金异动明细
       glaa027 LIKE glaa_t.glaa027, #单据据点编号
       glaa130 LIKE glaa_t.glaa130, #合并账套否
       glaa131 LIKE glaa_t.glaa131, #分层合并
       glaa132 LIKE glaa_t.glaa132, #平均汇率计算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司导入余额类型
       glaa134 LIKE glaa_t.glaa134, #合并科目转换依据异动码设置值
       glaa135 LIKE glaa_t.glaa135, #现流表间接法群组参照表号
       glaa136 LIKE glaa_t.glaa136, #应收账款核销限定己立账凭证
       glaa137 LIKE glaa_t.glaa137, #应付账款核销限定已立账凭证
       glaa138 LIKE glaa_t.glaa138, #合并报表编制期别
       glaa139 LIKE glaa_t.glaa139, #递延收入(负债)管理生成否
       glaa140 LIKE glaa_t.glaa140, #无原出货单的递延负债减项者,是否仍立递延收入管理?
       glaa123 LIKE glaa_t.glaa123, #应收帐款核销可维护资金异动明细
       glaa124 LIKE glaa_t.glaa124, #应付帐款核销可维护资金异动明细
       glaa028 LIKE glaa_t.glaa028 #汇率来源
END RECORD
#161124-00048#1 2016/12/05 By 08734 add(E)
   DEFINE l_month    LIKE type_t.num5
   DEFINE l_year     LIKE type_t.num5          
   #160902-00023#1---add---e          
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
   LET l_type = 1
   CALL cl_err_collect_init()
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmr600_x01_curs INTO sr.*                               
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
       LET sr.l_type = l_type
       LET sr.l_pid = ''
       IF l_type = 1 THEN
          LET sr.l_id = 1
          LET g_id = 1
       ELSE
          LET sr.l_id = g_id + 1
       END IF
       IF NOT cl_null(sr.bmaa001) THEN
          IF cl_null(sr.bmaa002) THEN
             LET sr.l_bmaa001_bmaa002 = sr.bmaa001
          ELSE
             LET sr.l_bmaa001_bmaa002 = sr.bmaa001 || '(' || sr.bmaa002 || ')'
          END IF
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       LET sr.l_vdate = tm.times
       #160902-00023#1---add---s
       EXECUTE abmr600_x01_bmaa USING sr.bmaa001,sr.bmaa002,sr.bmaasite
                                 INTO l_imae051,l_imae052,l_imai021,
                                      l_imai022,l_imai023,l_glaald,l_imaa006
                                 
       IF cl_null(sr.l_cmount) THEN LET sr.l_cmount = 0 END IF
       IF cl_null(sr.l_rmount) THEN LET sr.l_rmount = 0 END IF
       IF cl_null(sr.l_zmount) THEN LET sr.l_zmount = 0 END IF
       IF cl_null(sr.l_jmount) THEN LET sr.l_jmount = 0 END IF             
       IF cl_null(l_imae051) THEN LET l_imae051 = 0 END IF
       IF cl_null(l_imae052) THEN LET l_imae052 = 0 END IF
       IF cl_null(l_imai021) THEN LET l_imai021 = 0 END IF
       IF cl_null(l_imai022) THEN LET l_imai022 = 0 END IF
       IF cl_null(l_imai023) THEN LET l_imai023 = 0 END IF
       CASE tm.price     #单价
          WHEN '1'
             LET sr.l_price_1 = l_imai022
          WHEN '2'              
             LET sr.l_price_1 = l_imai023
          WHEN '3'              
             LET sr.l_price_1 = l_imai021
       END CASE
       #采购单价为0时取上月平均材料成本
       IF tm.con2 = 'Y' THEN
          IF cl_null(sr.l_price_1) OR sr.l_price_1 = 0 THEN 
            # SELECT * INTO l_glaa.* FROM glaa_t #161124-00048#1 2016/12/05 By 08734 mark
              SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,  #161124-00048#1 2016/12/05 By 08734 add
       glaa020,glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO l_glaa.* FROM glaa_t
              WHERE glaaent = g_enterprise AND glaald = l_glaald
              
            #抓取上月平均成本单价
            IF MONTH(g_today) = 1 THEN
               LET l_year =  YEAR(g_today) - 1
               LET l_month = 12
            ELSE
               LET l_year =  YEAR(g_today)
               LET l_month = MONTH(g_today) - 1
            END IF
            SELECT AVG(xccc280a) INTO sr.l_price_1 FROM xccc_t
              WHERE xcccent = g_enterprise AND xcccld = l_glaa.glaald           
                AND xccc001 = 1 AND xccc003 = l_glaa.glaa120
                AND xccc004 = l_year AND xccc005 = l_month
                AND xccc006 = sr.bmaa001                                  
             IF cl_null(sr.l_price_1) THEN LET sr.l_price_1 = 0 END IF
          END IF
       END IF
        
       IF NOT cl_null(sr.bmaa001) AND NOT cl_null(l_imaa006) AND NOT cl_null(sr.l_bmba010) THEN
          CALL s_aimi190_get_convert(sr.bmaa001,l_imaa006,sr.l_bmba010) 
            RETURNING l_success,l_rate
          IF l_success THEN
             LET sr.l_price_1 = sr.l_price_1 / l_rate
          END IF
       END IF
       
       LET sr.l_bmba011_1 = 0                   
       LET sr.l_price_2 = 0
       LET sr.l_cmount = sr.l_price_1
       LET sr.l_jmount = 0
       
       LET sr.l_salary = tm.sal
       LET sr.l_rmount = l_imae051 * sr.l_salary
       LET sr.l_cost = tm.cost
       LET sr.l_zmount = l_imae052 * sr.l_cost
       LET sr.l_current_sum  = sr.l_cmount + sr.l_rmount + sr.l_zmount + sr.l_jmount   
       #160902-00023#1---add---e          
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_bmba009,sr.l_bmaa001_bmaa002,sr.l_imaal003_1,sr.l_imaal004_1,sr.l_vdate,sr.l_bmba011,sr.l_bmba010,sr.l_price_1,sr.l_cmount,sr.l_imae051_1,sr.l_salary,sr.l_rmount,sr.l_imae052_1,sr.l_cost,sr.l_zmount,sr.l_bmba011_1,sr.l_bmba010_2,sr.l_price_2,sr.l_jmount,sr.l_current_sum,sr.l_ne_mate,sr.l_ne_arti,sr.l_ne_fee,sr.l_ne_mach,sr.l_ne_total,sr.l_total,sr.l_type,sr.l_pid,sr.l_id
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmr600_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       LET g_dead = 'N'
       LET g_cnt = 1
       LET l_a2 = tm.times
       
       LET g_bom = sr.l_id
       CALL abmr600_x01_bom(sr.l_type,sr.l_pid,sr.l_id,sr.bmaaent,sr.bmaasite,sr.bmaa001,sr.bmaa002,l_a2)
       RETURNING l_success
       LET l_type = l_type + 1
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    #CALL cl_err_collect_show()
    #160902-00023#1---mark---s
    ##160728-00007#1 mod-S
    ##根据l_type进行合计，并更新至成品料件
    #LET l_sql= " MERGE INTO (SELECT * FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," WHERE l_pid IS NULL) A ",
    #           " USING (SELECT l_type,SUM(NVL(l_cmount,0)) S1,SUM(NVL(l_rmount,0)) S2,SUM(NVL(l_zmount,0)) S3,SUM(NVL(l_jmount,0)) S4,SUM(NVL(l_current_sum,0)) S5 ",
    #           "          FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," WHERE l_pid IS NOT NULL GROUP BY l_type) B ",
    #           " ON (A.l_type = B.l_type)",
    #           " WHEN MATCHED THEN ",
    #           " UPDATE SET A.l_cmount = B.S1,A.l_rmount = B.S2,A.l_zmount = B.S3,A.l_jmount = B.S4,A.l_current_sum = B.S5 "
    #EXECUTE IMMEDIATE l_sql
    ##160728-00007#1 mod-E
    #160902-00023#1---mark---e
    #160902-00023#1---add---s
    LET l_sql= " MERGE INTO (SELECT * FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED,") A ",
               " USING (SELECT l_type,l_pid,SUM(NVL(l_cmount,0)) S1,SUM(NVL(l_rmount,0)) S2,SUM(NVL(l_zmount,0)) S3,SUM(NVL(l_jmount,0)) S4 ",
               "          FROM ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," GROUP BY l_type,l_pid) B ",
               " ON (A.l_type = B.l_type AND A.l_id = B.l_pid)",
               " WHEN MATCHED THEN ",
               " UPDATE SET A.l_ne_mate = B.S1,",
               "            A.l_ne_arti = B.S2,",
               "            A.l_ne_fee = B.S3,",
               "            A.l_ne_mach = B.S4,",
               "            A.l_ne_total = B.S1+B.S2+B.S3+B.S4,",
               "            A.l_total = A.l_current_sum+B.S1+B.S2+B.S3+B.S4 "
   EXECUTE IMMEDIATE l_sql               
   #160902-00023#1---add---e    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmr600_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr600_x01_rep_data()
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
 
{<section id="abmr600_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 展BOM
# Memo...........:
# Usage..........: CALL abmr600_x01_bom(p_type,p_pid,p_id,p_bmaaent,p_bmaasite,p_bmaa001,p_bmaa002,p_times)
#                  RETURNING 回传参数
# Input parameter: p_type 樹狀type
#                : p_pid 樹狀pid
#                : p_id 樹狀id
#                : p_bmaaent 企業編號
#                : p_bmaasite 營運據點
#                : p_bmaa001 料件編號
#                : p_bmaa002 特性
#                : p_times   有效日期
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 150709 By xujing
# Modify.........:
################################################################################
PRIVATE FUNCTION abmr600_x01_bom(p_type,p_pid,p_id,p_bmaaent,p_bmaasite,p_bmaa001,p_bmaa002,p_times)
DEFINE l_sql      STRING
   DEFINE l_sql_2    STRING
   DEFINE l_sql_3    STRING
   DEFINE l_sql_4    STRING
   DEFINE l_sql_5    STRING
   DEFINE l_datetype STRING
   DEFINE l_id_add   LIKE type_t.num5
   DEFINE p_times    LIKE type_t.dat     #有效日期
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_ac       LIKE type_t.num5
   DEFINE l_ac2      LIKE type_t.num5
   DEFINE l_count    LIKE type_t.num5
   DEFINE l_count2   LIKE type_t.num5
   DEFINE l_count3   LIKE type_t.num5
   DEFINE l_first    LIKE type_t.chr1
   DEFINE p_type     LIKE type_t.num20
   DEFINE p_pid      LIKE type_t.num20
   DEFINE p_id       LIKE type_t.num20
   DEFINE l_type     LIKE type_t.num20
   DEFINE l_pid      LIKE type_t.num20
   DEFINE l_id       LIKE type_t.num20
   DEFINE p_bmaaent  LIKE bmaa_t.bmaaent
   DEFINE p_bmaasite LIKE bmaa_t.bmaasite
   DEFINE p_bmaa001  LIKE bmaa_t.bmaa001
   DEFINE p_bmaa002  LIKE bmaa_t.bmaa002
   DEFINE l_bmbalen  LIKE type_t.num5
   DEFINE l_bmealen  LIKE type_t.num5
   DEFINE l_imaal003 LIKE imaal_t.imaal003
   DEFINE l_imaal004 LIKE imaal_t.imaal004
   DEFINE l_bmba005  LIKE ooff_t.ooff007
   DEFINE l_bmba011  LIKE type_t.chr1000
   DEFINE l_bmba012  LIKE type_t.chr1000
   DEFINE l_bmea011  STRING
   DEFINE l_bmea012  STRING
   DEFINE l_bmba003_bmba002 LIKE type_t.chr100
   DEFINE l_bmba004_desc LIKE oocql_t.oocql004
   DEFINE l_bmba007_desc LIKE oocql_t.oocql004
   DEFINE l_bmba011_bmba012 LIKE type_t.chr100
   DEFINE l_bmea011_bmea012 LIKE type_t.chr100
   DEFINE l_bmba009_1 LIKE type_t.chr1000
   DEFINE l_bmba009_2 LIKE type_t.chr1000
   DEFINE l_bmba     DYNAMIC ARRAY OF RECORD
          bmbaent   LIKE bmba_t.bmbaent,
          bmbasite  LIKE bmba_t.bmbasite,
          bmba001   LIKE bmba_t.bmba001,
          bmba002   LIKE bmba_t.bmba002,
          bmba003   LIKE bmba_t.bmba003,
          bmba009   LIKE bmba_t.bmba009,
          bmba010   LIKE bmba_t.bmba010,
          bmba011   LIKE bmba_t.bmba011,
          bmba012   LIKE bmba_t.bmba012,
          bmba022   LIKE bmba_t.bmba022,
          imaal003  LIKE imaal_t.imaal003,
          imaal004  LIKE imaal_t.imaal004,
          imae051   LIKE imae_t.imae051,
          imae052   LIKE imae_t.imae052,
          imai021  LIKE imai_t.imai021,       #160510-00019#15 add   
          imai022  LIKE imai_t.imai022,       #160510-00019#15 add
          imai023  LIKE imai_t.imai023,       #160510-00019#15 add
          glaald   LIKE glaa_t.glaald,        #160510-00019#15 add
          imaa006  LIKE imaa_t.imaa006,       #160510-00019#15 add
          l_ac      LIKE type_t.num5
   END RECORD
DEFINE l_price_1 LIKE type_t.num20_6, 
       l_cmount LIKE type_t.num20_6, 
       l_salary LIKE type_t.num20_6, 
       l_rmount LIKE type_t.num20_6, 
       l_cost LIKE type_t.num20_6, 
       l_zmount LIKE type_t.num20_6, 
       l_bmba011_1 LIKE type_t.num15_3, 
       l_bmba010_2 LIKE bmba_t.bmba010, 
       l_price_2 LIKE type_t.num20_6, 
       l_jmount LIKE type_t.num20_6, 
       l_current_sum LIKE type_t.num20_6,
       l_vdate  DATETIME YEAR TO SECOND     #有效日期
#DEFINE l_imai021  LIKE imai_t.imai021        #160510-00019#15 marked
#DEFINE l_imai022  LIKE imai_t.imai022        #160510-00019#15 marked
#DEFINE l_imai023  LIKE imai_t.imai023        #160510-00019#15 marked
DEFINE l_bmba009  STRING
DEFINE l_num      LIKE type_t.num5
#DEFINE l_ooef017  LIKE ooef_t.ooef017        #160510-00019#15 marked
#DEFINE l_glaald   LIKE glaa_t.glaald         #160510-00019#15 marked
# DEFINE l_glaa RECORD LIKE glaa_t.*  #161124-00048#1 2016/12/05 By 08734 mark
   #161124-00048#1 2016/12/05 By 08734 add(S)
   DEFINE l_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企业编号
       glaaownid LIKE glaa_t.glaaownid, #资料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #资料所有部门
       glaacrtid LIKE glaa_t.glaacrtid, #资料录入者
       glaacrtdp LIKE glaa_t.glaacrtdp, #资料录入部门
       glaacrtdt LIKE glaa_t.glaacrtdt, #资料创建日
       glaamodid LIKE glaa_t.glaamodid, #资料更改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近更改日
       glaastus LIKE glaa_t.glaastus, #状态码
       glaald LIKE glaa_t.glaald, #账套编号
       glaacomp LIKE glaa_t.glaacomp, #归属法人
       glaa001 LIKE glaa_t.glaa001, #使用币种
       glaa002 LIKE glaa_t.glaa002, #汇率参照表号
       glaa003 LIKE glaa_t.glaa003, #会计周期参照表号
       glaa004 LIKE glaa_t.glaa004, #会计科目参照表号
       glaa005 LIKE glaa_t.glaa005, #现金变动参照表号
       glaa006 LIKE glaa_t.glaa006, #月结方式
       glaa007 LIKE glaa_t.glaa007, #年结方式
       glaa008 LIKE glaa_t.glaa008, #平行记账否
       glaa009 LIKE glaa_t.glaa009, #凭证登录方式
       glaa010 LIKE glaa_t.glaa010, #现行年度
       glaa011 LIKE glaa_t.glaa011, #现行期别
       glaa012 LIKE glaa_t.glaa012, #最后过账日期
       glaa013 LIKE glaa_t.glaa013, #关账日期
       glaa014 LIKE glaa_t.glaa014, #主账套
       glaa015 LIKE glaa_t.glaa015, #启用本位币二
       glaa016 LIKE glaa_t.glaa016, #本位币二
       glaa017 LIKE glaa_t.glaa017, #本位币二换算基准
       glaa018 LIKE glaa_t.glaa018, #本位币二汇率采用
       glaa019 LIKE glaa_t.glaa019, #启用本位币三
       glaa020 LIKE glaa_t.glaa020, #本位币三
       glaa021 LIKE glaa_t.glaa021, #本位币三换算基准
       glaa022 LIKE glaa_t.glaa022, #本位币三汇率采用
       glaa023 LIKE glaa_t.glaa023, #次账套账务生成时机
       glaa024 LIKE glaa_t.glaa024, #单据别参照表号
       glaa025 LIKE glaa_t.glaa025, #本位币一汇率采用
       glaa026 LIKE glaa_t.glaa026, #币种参照表号
       glaa100 LIKE glaa_t.glaa100, #凭证录入时自动按缺号生成
       glaa101 LIKE glaa_t.glaa101, #凭证总号录入时机
       glaa102 LIKE glaa_t.glaa102, #凭证成立时,借贷不平衡的处理方式
       glaa103 LIKE glaa_t.glaa103, #未打印的凭证可否进行过账
       glaa111 LIKE glaa_t.glaa111, #应计调整单别
       glaa112 LIKE glaa_t.glaa112, #期末结转单别
       glaa113 LIKE glaa_t.glaa113, #年底结转单别
       glaa120 LIKE glaa_t.glaa120, #成本计算类型
       glaa121 LIKE glaa_t.glaa121, #子模块启用分录底稿
       glaa122 LIKE glaa_t.glaa122, #总账可维护资金异动明细
       glaa027 LIKE glaa_t.glaa027, #单据据点编号
       glaa130 LIKE glaa_t.glaa130, #合并账套否
       glaa131 LIKE glaa_t.glaa131, #分层合并
       glaa132 LIKE glaa_t.glaa132, #平均汇率计算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司导入余额类型
       glaa134 LIKE glaa_t.glaa134, #合并科目转换依据异动码设置值
       glaa135 LIKE glaa_t.glaa135, #现流表间接法群组参照表号
       glaa136 LIKE glaa_t.glaa136, #应收账款核销限定己立账凭证
       glaa137 LIKE glaa_t.glaa137, #应付账款核销限定已立账凭证
       glaa138 LIKE glaa_t.glaa138, #合并报表编制期别
       glaa139 LIKE glaa_t.glaa139, #递延收入(负债)管理生成否
       glaa140 LIKE glaa_t.glaa140, #无原出货单的递延负债减项者,是否仍立递延收入管理?
       glaa123 LIKE glaa_t.glaa123, #应收帐款核销可维护资金异动明细
       glaa124 LIKE glaa_t.glaa124, #应付帐款核销可维护资金异动明细
       glaa028 LIKE glaa_t.glaa028 #汇率来源
END RECORD
#161124-00048#1 2016/12/05 By 08734 add(E)

DEFINE l_bmba002  LIKE bmba_t.bmba002
DEFINE l_month    LIKE type_t.num5
DEFINE l_year     LIKE type_t.num5
DEFINE l_n        LIKE type_t.num5  #0423
#DEFINE l_imaa006  LIKE imaa_t.imaa006  #0423 #160510-00019#15 marked
DEFINE l_rate     LIKE inaj_t.inaj014  

   #160510-00019#15 marked -S
#   LET l_sql = " SELECT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba009,bmba010,bmba011,bmba012,bmba022,imaal003,imaal004,imae051,imae052",
#               "   FROM bmba_t LEFT OUTER JOIN imaal_t ON imaalent = bmbaent AND imaal001 = bmba003 AND imaal002 = '",g_dlang,"'",
#               "               LEFT OUTER JOIN imae_t  ON imaeent  = bmbaent AND imaesite = bmbasite AND imae001 = bmba003 ",
#               "  WHERE bmbaent = ",p_bmaaent,
#               "    AND bmbasite = '",p_bmaasite,"'",
#               "    AND bmba001 = '",p_bmaa001,"'",
#               "    AND bmba002 = '",p_bmaa002,"'",
#               "    AND to_char(bmba005,'yy-mm-dd') < '",p_times,"'",
#               "    AND (to_char(bmba006,'yy-mm-dd') >= '",p_times,"' OR bmba006 IS NULL)",
#               "    AND bmba019 <> '2'",
#               "  ORDER BY bmba009"
   #160510-00019#15 marked -E
   #160510-00019#15 mod -S
#   LET l_sql = " SELECT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba009,bmba010,bmba011,bmba012,bmba022,",
#               " (SELECT imaal003 FROM imaal_t WHERE imaal001 = bmba003 AND imaalent = bmbaent AND imaal002 = '",g_dlang,"') t1_imaal003,",
#               " (SELECT imaal004 FROM imaal_t WHERE imaal001 = bmba003 AND imaalent = bmbaent AND imaal002 = '",g_dlang,"') t1_imaal004,",
#               " (SELECT imae051 FROM imae_t WHERE imae001 = bmba003 AND imaeent = bmbaent AND imaesite = bmbasite) t2_imae051,",
#               " (SELECT imae052 FROM imae_t WHERE imae001 = bmba003 AND imaeent = bmbaent AND imaesite = bmbasite) t2_imae052,",
#               " (SELECT imai021 FROM imai_t WHERE imai001 = bmba003 AND imaient = bmbaent AND imaisite = bmbasite) t3_imai021,",
#               " (SELECT imai022 FROM imai_t WHERE imai001 = bmba003 AND imaient = bmbaent AND imaisite = bmbasite) t3_imai022,",
#               " (SELECT imai023 FROM imai_t WHERE imai001 = bmba003 AND imaient = bmbaent AND imaisite = bmbasite) t3_imai023,",
#               " (SELECT DISTINCT glaald FROM glaa_t WHERE glaaent = bmbaent AND glaa014 = 'Y' AND glaacomp = (SELECT DISTINCT ooef017 FROM ooef_t WHERE ooefent = bmbaent AND ooef001 = bmbasite )) t4_glaald,",
#               " (SELECT imaa006 FROM imaa_t WHERE imaa001 = bmba003 AND imaaent = bmbaent) t5_imaa006",
#               "   FROM bmba_t ",
#               "  WHERE bmbaent = ",p_bmaaent,
#               "    AND bmbasite = '",p_bmaasite,"'",
#               "    AND bmba001 = '",p_bmaa001,"'",
#               "    AND bmba002 = '",p_bmaa002,"'",
#               "    AND to_char(bmba005,'yy-mm-dd') < '",p_times,"'",
#               "    AND (to_char(bmba006,'yy-mm-dd') >= '",p_times,"' OR bmba006 IS NULL)",
#               "    AND bmba019 <> '2'",
#               "  ORDER BY bmba009"
#   
#     PREPARE abmr600_x01_prepare_bom FROM l_sql
#     DECLARE abmr600_x01_bom CURSOR FOR abmr600_x01_prepare_bom
     #160510-00019#15 mod -E
     LET l_ac = l_ac + 1
     LET g_first = 'N'
#     FOREACH abmr600_x01_bom INTO l_bmba[l_ac].* #160510-00019#15 marked
     FOREACH abmr600_x01_bom USING p_bmaaent,p_bmaasite,p_bmaa001,p_bmaa002,p_times,p_times INTO l_bmba[l_ac].*   #160510-00019#15 mod
        IF STATUS THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'foreach:'
           LET g_errparam.code   = STATUS
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           LET g_rep_success = 'N'
           EXIT FOREACH
        END IF
        LET g_first = 'Y'
        
        LET l_ac = l_ac + 1
     END FOREACH
     LET l_type = p_type
     LET l_pid = p_id
     LET l_bmbalen = l_bmba.getLength() - 1
     IF l_bmbalen < 0 THEN
        LET l_bmbalen = 0
     END IF
     
     #輸出
     LET l_count3 = 0    
     FOR l_ac = 1 TO l_bmbalen
          
         LET p_id = p_id + 1
         IF p_id < g_id THEN
            LET p_id = g_id +1 
         END IF
         IF p_id = g_id THEN
            LET p_id = p_id + 1
         END IF
         LET g_id = p_id
         LET l_id = g_id
         IF NOT cl_null(l_bmba[l_ac].bmba003) THEN
            IF cl_null(l_bmba[l_ac].bmba002) THEN
               LET l_bmba003_bmba002 = l_bmba[l_ac].bmba003
            ELSE
               LET l_bmba003_bmba002 = l_bmba[l_ac].bmba003 || '(' || l_bmba[l_ac].bmba002 || ')'
            END IF
         END IF
         IF l_bmba[l_ac].l_ac <> (g_id+2) THEN
            LET p_id = p_id + l_id_add
            IF p_id < g_id THEN
               LET p_id = g_id +1 
            END IF
            IF p_id = g_id THEN
               LET p_id = p_id + 1
            END IF
            LET g_id = p_id
            LET l_id = g_id
         END IF
         IF g_dead = 'Y' THEN
            EXIT FOR
         END IF
         INITIALIZE l_price_1,l_cmount,l_salary,l_rmount,l_vdate,
                    l_cost,l_zmount,l_bmba011_1,l_bmba010_2,l_price_2,l_jmount,l_current_sum TO NULL
         
         LET l_vdate = p_times
         IF cl_null(l_cmount) THEN LET l_cmount = 0 END IF
         IF cl_null(l_rmount) THEN LET l_rmount = 0 END IF
         IF cl_null(l_zmount) THEN LET l_zmount = 0 END IF
         IF cl_null(l_jmount) THEN LET l_jmount = 0 END IF             
         IF cl_null(l_bmba[l_ac].imae051) THEN LET l_bmba[l_ac].imae051 = 0 END IF
         IF cl_null(l_bmba[l_ac].imae052) THEN LET l_bmba[l_ac].imae052 = 0 END IF
         #160510-00019#15 marked -S
#         INITIALIZE l_imai021 TO NULL
#         INITIALIZE l_imai022 TO NULL
#         INITIALIZE l_imai023 TO NULL
#         SELECT imai021,imai022,imai023 INTO l_imai021,l_imai022,l_imai023 FROM imai_t
#          WHERE imaient = l_bmba[l_ac].bmbaent AND imaisite = l_bmba[l_ac].bmbasite AND imai001 = l_bmba[l_ac].bmba003
#         IF cl_null(l_imai021) THEN LET l_imai021 = 0 END IF
#         IF cl_null(l_imai022) THEN LET l_imai022 = 0 END IF
#         IF cl_null(l_imai023) THEN LET l_imai023 = 0 END IF
#         CASE tm.price     #单价
#            WHEN '1'
#               LET l_price_1 = l_imai022
#            WHEN '2'
#               LET l_price_1 = l_imai023
#            WHEN '3'
#               LET l_price_1 = l_imai021
#         END CASE
         #160510-00019#15 marked -E
         #160510-00019#15 mod -S
         IF cl_null(l_bmba[l_ac].imai021) THEN LET l_bmba[l_ac].imai021 = 0 END IF
         IF cl_null(l_bmba[l_ac].imai022) THEN LET l_bmba[l_ac].imai022 = 0 END IF
         IF cl_null(l_bmba[l_ac].imai023) THEN LET l_bmba[l_ac].imai023 = 0 END IF
         CASE tm.price     #单价
            WHEN '1'
               LET l_price_1 = l_bmba[l_ac].imai022
            WHEN '2'
               LET l_price_1 = l_bmba[l_ac].imai023
            WHEN '3'
               LET l_price_1 = l_bmba[l_ac].imai021
         END CASE
         #160510-00019#15 mod -E
         #采购单价为0时取上月平均材料成本
         IF tm.con2 = 'Y' THEN
            IF cl_null(l_price_1) OR l_price_1 = 0 THEN 
               #160510-00019#15 marked -S
#               SELECT ooef017 INTO l_ooef017 FROM ooef_t
#                WHERE ooefent = g_enterprise AND ooef001 = l_bmba[l_ac].bmbasite
#               SELECT glaald INTO l_glaald FROM glaa_t
#                WHERE glaaent = g_enterprise AND glaa014 = 'Y'
#                  AND glaacomp = l_ooef017
#               SELECT * INTO l_glaa.* FROM glaa_t
#                WHERE glaaent = l_bmba[l_ac].bmbaent AND glaald = l_glaald
               #160510-00019#15 marked -E
               #160510-00019#15 mod -S
              # SELECT * INTO l_glaa.* FROM glaa_t  #161124-00048#1 2016/12/05 By 08734 mark
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,  #161124-00048#1 2016/12/05 By 08734 add
       glaa020,glaa021,glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO l_glaa.* FROM glaa_t
                WHERE glaaent = l_bmba[l_ac].bmbaent AND glaald = l_bmba[l_ac].glaald
               #160510-00019#15 mod -E
                
              #抓取上月平均成本单价
              IF MONTH(g_today) = 1 THEN
                 LET l_year =  YEAR(g_today) - 1
                 LET l_month = 12
              ELSE
                 LET l_year =  YEAR(g_today)
                 LET l_month = MONTH(g_today) - 1
              END IF
              SELECT AVG(xccc280a) INTO l_price_1 FROM xccc_t
               #WHERE xcccent = g_enterprise AND xcccld = l_glaald                #160831-00073#1 mark
                WHERE xcccent = g_enterprise AND xcccld = l_glaa.glaald           #160831-00073#1 add
                  AND xccc001 = 1 AND xccc003 = l_glaa.glaa120
                  AND xccc004 = l_year AND xccc005 = l_month
                 #AND xccc006 = l_bmba[l_ac].bmba003 AND xccc007 = l_bmba[l_ac].bmba002 #160831-00073#1 mark
                  AND xccc006 = l_bmba[l_ac].bmba003                                    #160831-00073#1 add 
               IF cl_null(l_price_1) THEN LET l_price_1 = 0 END IF
            END IF
          END IF
          
          #160510-00019#15 marked -S
#          SELECT imaa006 INTO l_imaa006 FROM imaa_t
#                   WHERE imaaent = l_bmba[l_ac].bmbaent AND imaa001 = l_bmba[l_ac].bmba003
#          IF NOT cl_null(l_bmba[l_ac].bmba003) AND NOT cl_null(l_imaa006) AND NOT cl_null(l_bmba[l_ac].bmba010) THEN
#             CALL s_aimi190_get_convert(l_bmba[l_ac].bmba003,l_imaa006,l_bmba[l_ac].bmba010) 
#               RETURNING g_success,l_rate
          #160510-00019#15 marked -S
          IF NOT cl_null(l_bmba[l_ac].bmba003) AND NOT cl_null(l_bmba[l_ac].imaa006) AND NOT cl_null(l_bmba[l_ac].bmba010) THEN
             CALL s_aimi190_get_convert(l_bmba[l_ac].bmba003,l_bmba[l_ac].imaa006,l_bmba[l_ac].bmba010) 
               RETURNING g_success,l_rate
             IF g_success THEN
                LET l_price_1 = l_price_1 / l_rate
             END IF
          END IF
          
          IF l_bmba[l_ac].bmba022 = 'N' THEN   #判断是否委外
             IF cl_null(g_stduseqty) OR g_stduseqty = 0 THEN           #161110-00016#1 add
                LET l_bmba[l_ac].bmba011 = l_bmba[l_ac].bmba011 / l_bmba[l_ac].bmba012   #标准用量
             #161110-00016#1 add---start---
                #LET g_stduseqty = l_bmba[l_ac].bmba011     #161115-00039#1 mark
             ELSE
                LET l_bmba[l_ac].bmba011 = g_stduseqty * (l_bmba[l_ac].bmba011 / l_bmba[l_ac].bmba012)
                #LET g_stduseqty = l_bmba[l_ac].bmba011     #161115-00039#1 mark
             END IF
             #161110-00016#1 add---end---
             LET l_bmba011_1 = 0                   
             LET l_price_2 = 0
             LET l_cmount = l_price_1 * l_bmba[l_ac].bmba011  #材料金额
             LET l_jmount = 0
          ELSE
             IF cl_null(g_stduseqty) OR g_stduseqty = 0 THEN           #161110-00016#1 add
                LET l_bmba011_1 = l_bmba[l_ac].bmba011 / l_bmba[l_ac].bmba012 #标准用量
             #161110-00016#1 add---start---
                #LET g_stduseqty = l_bmba[l_ac].bmba011      #161115-00039#1 mark
             ELSE
                LET l_bmba[l_ac].bmba011 = g_stduseqty * (l_bmba[l_ac].bmba011 / l_bmba[l_ac].bmba012)
                #LET g_stduseqty = l_bmba[l_ac].bmba011      #161115-00039#1 mark
             END IF
             #161110-00016# add---end---
             LET l_bmba[l_ac].bmba011 = 0
             LET l_price_2 = l_price_1            #委外单价
             LET l_price_1 = 0
             LET l_jmount = l_price_2 * l_bmba011_1 #加工金额
             LET l_cmount = 0
          END IF
          
          LET l_salary = tm.sal
          LET l_rmount = l_bmba[l_ac].imae051 * l_salary
          LET l_cost = tm.cost
          LET l_zmount = l_bmba[l_ac].imae052 * l_cost
          LET l_current_sum  = l_cmount + l_rmount + l_zmount + l_jmount
         
         IF tm.last = 'Y' THEN
            #160510-00019#15 marked -S
#            LET l_sql_5 = " SELECT COUNT(*) ",
#                          "   FROM bmba_t ",
#                          " WHERE bmbaent = '",l_bmba[l_ac].bmbaent,"' ",
#                          " AND bmbasite = '",l_bmba[l_ac].bmbasite,"' ",
#                          " AND bmba001 = '",l_bmba[l_ac].bmba003,"' ",
#                          " AND bmba002 = '",l_bmba[l_ac].bmba002,"' ",
#                          " AND to_char(bmba005,'yy-mm-dd') < '",p_times,"'",
#                          " AND (to_char(bmba006,'yy-mm-dd') >= '",p_times,"' OR bmba006 IS NULL)",
#                          " AND bmba019 <> '2'"
#            PREPARE abmr600_count FROM l_sql_5
#            EXECUTE abmr600_count INTO l_count3
            #160510-00019#15 marked -E
            EXECUTE abmr600_count USING l_bmba[l_ac].bmbaent,l_bmba[l_ac].bmbasite,l_bmba[l_ac].bmba003,l_bmba[l_ac].bmba002,p_times,p_times INTO l_count3  #160510-00019#15 mod
            IF l_count3 = 0 THEN
               EXECUTE insert_prep USING l_bmba[l_ac].bmba009,l_bmba003_bmba002,l_bmba[l_ac].imaal003,l_bmba[l_ac].imaal004,l_vdate,l_bmba[l_ac].bmba011,l_bmba[l_ac].bmba010,
                                         l_price_1,l_cmount,l_bmba[l_ac].imae051,l_salary,l_rmount,l_bmba[l_ac].imae052,l_cost,l_zmount,
                                         l_bmba011_1,l_bmba010_2,l_price_2,l_jmount,l_current_sum,
                                         '0','0','0','0','0','0',    #160902-00023#1 add
                                         l_type,g_bom,l_id
               IF l_ac = l_bmbalen THEN     #161115-00039#1 add
                  LET g_stduseqty = 0       #161110-00016#1 add
               END IF                       #161115-00039#1 add
            ELSE
               IF g_cnt > 20 THEN
                  LET g_dead = 'Y'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = l_bmba[l_ac].bmba003||"--->"||p_bmaa001
                  LET g_errparam.code   = 'abm-00260'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()   
                  EXIT FOR
               END IF
               LET g_cnt = g_cnt + 1
               LET g_stduseqty = l_bmba[l_ac].bmba011    #161115-00039#1 add
               CALL abmr600_x01_bom(l_type,l_pid,l_id,l_bmba[l_ac].bmbaent,l_bmba[l_ac].bmbasite,l_bmba[l_ac].bmba003,l_bmba[l_ac].bmba002,p_times)
                RETURNING l_id_add
            END IF
         ELSE
            EXECUTE insert_prep USING l_bmba[l_ac].bmba009,l_bmba003_bmba002,l_bmba[l_ac].imaal003,l_bmba[l_ac].imaal004,l_vdate,l_bmba[l_ac].bmba011,l_bmba[l_ac].bmba010,
                                         l_price_1,l_cmount,l_bmba[l_ac].imae051,l_salary,l_rmount,l_bmba[l_ac].imae052,l_cost,l_zmount,
                                         l_bmba011_1,l_bmba010_2,l_price_2,l_jmount,l_current_sum,
                                         '0','0','0','0','0','0',    #160902-00023#1 add
                                         l_type,l_pid,l_id
            IF l_ac = l_bmbalen THEN        #161115-00039#1 add
               LET g_stduseqty = 0          #161110-00016#1 add
            END IF                          #161115-00039#1 add
         END IF
      END FOR
      IF g_first = 'N' THEN
        LET p_id = p_id + 1
        IF g_id < p_id THEN
           LET g_id = p_id
        END IF
     END IF
     
     RETURN l_bmbalen
END FUNCTION

 
{</section>}
 
