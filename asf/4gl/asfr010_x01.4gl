#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr010_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-11-17 16:17:55), PR版次:0003(2016-11-17 16:28:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: asfr010_x01
#+ Description: ...
#+ Creator....: 05795(2015-06-01 11:24:43)
#+ Modifier...: 08992 -SD/PR- 08992
 
{</section>}
 
{<section id="asfr010_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160411-00027#11  2016/04/21  By lixiang  效能優化
#161109-00085#40 2016/11/17 By lienjunqi    整批調整系統星號寫法
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
       wc STRING,                  #QBE 
       flag1 LIKE type_t.chr30,         #未发料需列印 
       flag2 LIKE type_t.chr30,         #未足套需列印 
       dtx1 LIKE type_t.chr500,         #需求日期str 
       dtx2 LIKE type_t.chr500,         #需求日期end 
       dts1 LIKE type_t.chr30,         #收料日期str 
       dts2 LIKE type_t.chr500          #收料日期end
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE  g_dtx1         LIKE type_t.dat         #需求日期str 
DEFINE  g_dtx2         LIKE type_t.dat         #需求日期end 
DEFINE  g_dts1         LIKE type_t.dat         #收料日期str 
DEFINE  g_dts2         LIKE type_t.dat         #收料日期end
DEFINE  g_sum_pmt020   LIKE type_t.num20_6     #收货数量
DEFINE  g_sql_tmp      STRING
#end add-point
 
{</section>}
 
{<section id="asfr010_x01.main" readonly="Y" >}
PUBLIC FUNCTION asfr010_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  QBE 
DEFINE  p_arg2 LIKE type_t.chr30         #tm.flag1  未发料需列印 
DEFINE  p_arg3 LIKE type_t.chr30         #tm.flag2  未足套需列印 
DEFINE  p_arg4 LIKE type_t.chr500         #tm.dtx1  需求日期str 
DEFINE  p_arg5 LIKE type_t.chr500         #tm.dtx2  需求日期end 
DEFINE  p_arg6 LIKE type_t.chr30         #tm.dts1  收料日期str 
DEFINE  p_arg7 LIKE type_t.chr500         #tm.dts2  收料日期end
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.flag1 = p_arg2
   LET tm.flag2 = p_arg3
   LET tm.dtx1 = p_arg4
   LET tm.dtx2 = p_arg5
   LET tm.dts1 = p_arg6
   LET tm.dts2 = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "asfr010_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL asfr010_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL asfr010_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL asfr010_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL asfr010_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL asfr010_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr010_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION asfr010_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdt_t_pmdt006.pmdt_t.pmdt006,pmdt006_desc1.type_t.chr30,pmdt006_desc2.type_t.chr30,pmdt_t_pmdt007.pmdt_t.pmdt007,pmdt_t_pmdt019.pmdt_t.pmdt019,pmdt_t_pmdt020.pmdt_t.pmdt020,sum_pmdt020.type_t.num20_6,sfaadocno.sfaa_t.sfaadocno,sfaa010.sfaa_t.sfaa010,sfaa010_desc1.type_t.chr30,sfaa010_desc2.type_t.chr30,sfaa019.sfaa_t.sfaa019,imae081_desc.type_t.chr200,sfba013.sfba_t.sfba013,sfba014.sfba_t.sfba014,qty1.type_t.num20_6,qty2.type_t.num20_6,sfbaseq1.sfba_t.sfbaseq1,sfbaseq.sfba_t.sfbaseq,sfaa002.sfaa_t.sfaa002,sfaa003.sfaa_t.sfaa003,sfaa004.sfaa_t.sfaa004,sfaa057.sfaa_t.sfaa057,sfaadocdt.sfaa_t.sfaadocdt,sfaastus.sfaa_t.sfaastus,sfaa005.sfaa_t.sfaa005,sfaa006.sfaa_t.sfaa006,sfaa009.sfaa_t.sfaa009,sfaa011.sfaa_t.sfaa011,sfaa012.sfaa_t.sfaa012,sfaa013.sfaa_t.sfaa013,sfaa017.sfaa_t.sfaa017,sfaa018.sfaa_t.sfaa018,sfaa020.sfaa_t.sfaa020,sfaa021.sfaa_t.sfaa021,sfaa022.sfaa_t.sfaa022,sfaa058.sfaa_t.sfaa058,sfaa060.sfaa_t.sfaa060,sfaa068.sfaa_t.sfaa068,sfaa049.sfaa_t.sfaa049,sfaa050.sfaa_t.sfaa050,sfaa051.sfaa_t.sfaa051,sfaa055.sfaa_t.sfaa055,sfaa056.sfaa_t.sfaa056,sfba002.sfba_t.sfba002,sfba003.sfba_t.sfba003,sfba004.sfba_t.sfba004,sfba005.sfba_t.sfba005,l_sfba005_imaal003.type_t.chr50,l_sfba005_imaal004.type_t.chr50,sfba006.sfba_t.sfba006,l_sfba006_imaal003.type_t.chr50,l_sfba006_imaal004.type_t.chr50,sfba009.sfba_t.sfba009,sfba010.sfba_t.sfba010,sfba011.sfba_t.sfba011,sfba012.sfba_t.sfba012,sfba015.sfba_t.sfba015,sfba016.sfba_t.sfba016,sfba017.sfba_t.sfba017,sfba018.sfba_t.sfba018,sfba021.sfba_t.sfba021,sfba022.sfba_t.sfba022,sfba023.sfba_t.sfba023,sfba024.sfba_t.sfba024,sfba025.sfba_t.sfba025,sfba026.sfba_t.sfba026,sfba027.sfba_t.sfba027,sfba028.sfba_t.sfba028,l_sfaa002_desc.type_t.chr30,l_sfaa003_desc.type_t.chr30,l_sfaa004_desc.type_t.chr30,l_sfaa057_desc.type_t.chr30,l_sfaastus_desc.type_t.chr30,l_sfaa005_desc.type_t.chr30,l_sfaa009_desc.type_t.chr30,l_sfaa013_desc.type_t.chr30,l_sfaa017_desc.type_t.chr30,l_sfaa018_desc.type_t.chr30,l_sfaa060_desc.type_t.chr30,l_sfaa068_desc.type_t.chr50,l_sfaa029_desc.type_t.chr50,l_sfaa030_desc.type_t.chr50,l_sfba002_desc.type_t.chr30,l_sfba003_desc.type_t.chr30,l_sfba008_desc.type_t.chr30,l_sfba021_desc.type_t.chr100,l_sfba026_desc.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="asfr010_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION asfr010_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="asfr010_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr010_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_select1      STRING
DEFINE g_from1        STRING
DEFINE g_where1       STRING
DEFINE g_sql1       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT pmdt_t.pmdt006,NULL,NULL,pmdt_t.pmdt007,pmdt_t.pmdt019,pmdt_t.pmdt020,NULL, 
       sfaadocno,sfaa010,NULL,NULL,sfaa019,NULL,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq,sfaa002,sfaa003, 
       sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,sfaa017,sfaa018, 
       sfaa020,sfaa021,sfaa022,sfaa058,sfaa060,sfaa068,sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,sfba002, 
       sfba003,sfba004,sfba005,NULL,NULL,sfba006,NULL,NULL,sfba009,sfba010,sfba011,sfba012,sfba015,sfba016, 
       sfba017,sfba018,sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #dorislai-20150811-modify----(S)
#   LET g_select = " SELECT  pmdt006,NULL,NULL,pmdt007,pmdt019,sum(pmdt020) as pmdt020s,0,sfaadocno,sfaa010,NULL,NULL,sfaa019,",
#                  " imae081,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq "
   LET g_select = " SELECT  pmdt006, NULL,NULL,pmdt007,pmdt019,sum(pmdt020) as pmdt020s,0,sfaadocno,sfaa010,NULL,NULL,", 
                  " sfaa019,",
                  " imae081,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq,",
                  #" sfaa001,",  #160411-00027#11 mark
                  " sfaa002,",
                  " sfaa003,sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,",
                  #" sfaa016,",  #160411-00027#11 mark
                  " sfaa017,sfaa018,sfaa020,sfaa021,sfaa022,",
                  #" sfaa025,",  #160411-00027#11 mark
                  " sfaa058,sfaa060,",
                  #" sfaa061,",  #160411-00027#11 mark
                  " sfaa068,",
                  #" sfaa014,sfaa015, ",  #160411-00027#11 mark
                  #" sfaa026,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,",  #160411-00027#11 mark
                  #" sfaa059,sfaa062,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048, ", #160411-00027#11 mark
                  " sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,",
                  #" sfaa065,sfaa069,sfaa070,sfba001,NULL,NULL,", #160411-00027#11 mark
                  " sfba002,sfba003,", 
                  " sfba004,sfba005, NULL,NULL,", 
                  " sfba006, NULL,NULL,", 
                  #" sfba007,sfba008,",  #160411-00027#11 mark
                  " sfba009,sfba010,sfba011,sfba012,sfba015,", 
                  " sfba016,sfba017,sfba018,",
                  #" sfba019,sfba020,",  #160411-00027#11 mark
                  " sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027, ",
                  " sfba028,",
                  #" sfba029,sfba030,", #160411-00027#11 mark
                  " sfaa028,sfaa029,sfaa030,sfba008,",  #160411-00027#11 add (需要抓出来，关联说明栏位时用到)
                  " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,",  
                  " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL" 
                  #" NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,",   #160411-00027#11 mark
                  #" NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,",   #160411-00027#11 mark
                  #" NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"  #160411-00027#11 mark
   #dorislai-20150811-modify----(E)
   #end add-point
    LET g_from = " FROM sfaa_t,sfba_t,sfdb_t,pmdt_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM pmds_t,pmdt_t,sfaa_t,sfba_t,imae_t "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE sfaadocno = sfbadocno ",
                 " AND sfaaent = ",g_enterprise,
                 " AND pmdsent = pmdtent ",
                 " AND pmdsdocno = pmdtdocno ",
                 #" AND pmdsstus = 'Y' ",  #160411-00027#11 mark
                 " AND pmdt006 = sfba006 ",
                 " AND pmdtent = imaeent ",
                 " AND pmdt006 = imae001 ",
                 " AND sfaasite = imaesite",
                 #" AND (pmds000 = '1' OR pmds000 = '2') ",  #160411-00027#11 mark
                 " AND ( ((pmds000 = '1' OR pmds000 = '2') AND pmdsstus = 'Y') OR ((pmds000 = '3' OR pmds000 = '4') AND (pmdsstus = 'Y' OR pmdsstus = 'S')) )", #160411-00027#11 add
                 " AND sfaasite ='",g_site,"' ",
                 " AND pmdssite ='",g_site,"' ",
                 " AND ",tm.wc CLIPPED
                 
   IF NOT cl_null(tm.dtx1) THEN
      LET  g_dtx1 = tm.dtx1 
#      LET g_where = g_where," AND sfaa019 >= ",g_dtx1  
      LET g_where = g_where," AND sfaa019 >= to_date('",tm.dtx1,"','yyyy/mm/dd') "
   END IF
   IF NOT cl_null(tm.dtx2) THEN
      LET  g_dtx2 = tm.dtx2
#      LET g_where = g_where," AND sfaa019 <= ",g_dtx2
      LET g_where = g_where," AND sfaa019 <= to_date('",tm.dtx2,"','yyyy/mm/dd') "
   END IF
   IF NOT cl_null(tm.dts1) THEN
      LET  g_dts1 = tm.dts1
#      LET g_where = g_where," AND pmdsdocdt >= ",g_dts1
      LET g_where = g_where," AND pmdsdocdt >= to_date('",tm.dts1,"','yyyy/mm/dd') "
   END IF
   IF NOT cl_null(tm.dts2) THEN
      LET  g_dts2 = tm.dts2
#      LET g_where = g_where," AND pmdsdocdt >= ",g_dts2
      LET g_where = g_where," AND pmdsdocdt <= to_date('",tm.dts2,"','yyyy/mm/dd') "
   END IF
   #dorislai-20150812-modify----(S)
#   LET g_select1 = " SELECT  pmdt006,NULL,NULL,pmdt007,pmdt019,sum(pmdt020) as pmdt020s,0,sfaadocno,sfaa010,NULL,NULL,sfaa019,",
#                  " imae081,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq "
   #160411-00027#11--mark--begin---
   #LET g_select1 = " SELECT  pmdt006,NULL,NULL,",       
   #                " pmdt007,pmdt019,sum(pmdt020) as pmdt020s,0,sfaadocno,sfaa010, NULL,NULL,",  
   #                " sfaa019,",
   #                " imae081,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq, sfaa001,", 
   #                " sfaa002,",
   #                " sfaa003,sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,sfaa016,", 
   #                " sfaa017,sfaa018,sfaa020,sfaa021,sfaa022,sfaa025,", 
   #                " sfaa058,sfaa060, sfaa061, sfaa068,",
   #                " sfaa014,sfaa015,",  
   #                " sfaa026,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,",  
   #                " sfaa059,sfaa062,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,",  
   #                " sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,",
   #                " sfaa065,sfaa069,sfaa070,sfba001,NULL,NULL,",  
   #                " sfba002,sfba003,fba004,sfba005, NULL,NULL,", 
   #                " sfba006, NULL,NULL, sfba007,sfba008,",
   #                " sfba009,sfba010,sfba011,sfba012,sfba015, ",
   #                " sfba016,sfba017,sfba018,sfba019,sfba020,", 
   #                " sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027, ",
   #                " sfba028, sfba029,sfba030,", 
   #                " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,", 
   #                " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL " 
   #                " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,",   
   #                " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, ", 
   #                " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL" 
   ##dorislai-20150812-modify----(E)
   #LET g_from1 = " FROM pmds_t,pmdt_t,sfaa_t,sfba_t,imae_t "
   #LET g_where1 = " WHERE sfaadocno = sfbadocno ",
   #              " AND sfaaent = ",g_enterprise,
   #              " AND pmdsent = pmdtent ",
   #              " AND pmdsdocno = pmdtdocno ",
   #              " AND (pmdsstus = 'Y' OR pmdsstus = 'S')",
   #              " AND pmdt006 = sfba006 ",
   #              " AND pmdtent = imaeent ",
   #              " AND pmdt006 = imae001 ",
   #              " AND sfaasite = imaesite",
   #              " AND (pmds000 = '3' OR pmds000 = '4') ",
   #              " AND sfaasite ='",g_site,"' ",
   #              " AND pmdssite ='",g_site,"' ",
   #              " AND ",tm.wc CLIPPED
   #              
   #IF NOT cl_null(tm.dtx1) THEN
   #   LET g_where1 = g_where1," AND sfaa019 >= to_date('",tm.dtx1,"','yyyy/mm/dd') "
   #END IF
   #IF NOT cl_null(tm.dtx2) THEN
   #   LET g_where1 = g_where1," AND sfaa019 <= to_date('",tm.dtx2,"','yyyy/mm/dd') "
   #END IF
   #IF NOT cl_null(tm.dts1) THEN
   #   LET g_where1 = g_where1," AND pmdsdocdt >= to_date('",tm.dts1,"','yyyy/mm/dd') "
   #END IF
   #IF NOT cl_null(tm.dts2) THEN
   #   LET g_where1 = g_where1," AND pmdsdocdt <= to_date('",tm.dts2,"','yyyy/mm/dd') "
   #END IF
   #LET g_where1 = g_where1 ,cl_sql_add_filter("sfaa_t") 
   #LET g_sql1 = g_select1 CLIPPED ," ",g_from1 CLIPPED ," ",g_where1 CLIPPED
   #LET g_sql1 = cl_sql_add_mask(g_sql1)
#  # LET g_sql1 = g_sql1," group by sfaadocno,pmdt006,pmdt007,pmdt019,sfaadocno,sfaa010,sfaa019, imae081,sfba013,sfba014,sfbaseq1,sfbaseq ", 
#  #             " ORDER BY pmdt006,pmdt007 "   
   #LET g_sql1 = g_sql1," GROUP BY sfaadocno,pmdt006,pmdt007,pmdt019,sfaadocno,sfaa010,",
   #             " sfaa019, imae081,sfba013,sfba014,sfbaseq1,sfbaseq,",
   #             " sfaa001,",
   #             " sfaa002,sfaa003,sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,",
   #             " sfaa016,",
   #             " sfaa017,sfaa018,sfaa020,sfaa021,sfaa022, sfaa025,", 
   #             " sfaa058,sfaa060,sfaa061,",  
   #             " sfaa068,",
   #             " sfaa014,sfaa015,sfaa026,sfaa028,sfaa029,", 
   #             " sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,sfaa059,sfaa062,sfaa039,sfaa040,sfaa041,sfaa042,",
   #             " sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,", 
   #             " sfaa049,sfaa050,sfaa051,sfaa055,sfaa056, sfaa065,sfaa069,sfaa070,sfba001,", 
   #             " sfba002,sfba003,sfba004,sfba005,sfba006, sfba007,sfba008,",  
   #             " sfba009,sfba010,sfba011,sfba012,sfba015,sfba016,",
   #             " sfba017,sfba018,sfba019,sfba020,", 
   #             " sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028 sfba029,sfba030 ", 
   #             " ORDER BY pmdt006,pmdt007 " 
   #160411-00027#11--mark--end---
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #dorislai-20150812-modify----(S)
#   LET g_sql = g_sql," group by sfaadocno,pmdt006,pmdt007,pmdt019,sfaadocno,sfaa010,sfaa019, imae081,sfba013,sfba014,sfbaseq1,sfbaseq "
#   LET g_sql = g_sql,"UNION ALL",g_sql1
#   LET g_sql = " SELECT pmdt006,NULL,NULL,pmdt007,pmdt019,sum(pmdt020s),0,sfaadocno,sfaa010,NULL,NULL,sfaa019, imae081,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq ",
#               " FROM (",g_sql,") ",
#               " GROUP BY sfaadocno,pmdt006,pmdt007,pmdt019,sfaadocno,sfaa010,sfaa019, imae081,sfba013,sfba014,sfbaseq1,sfbaseq  ",
#               " ORDER BY pmdt006,pmdt007 "
                
   LET g_sql = g_sql," GROUP BY sfaadocno,pmdt006,pmdt007,pmdt019,sfaadocno,sfaa010,",
                " sfaa019, imae081,sfba013,sfba014,sfbaseq1,sfbaseq,",
                #" sfaa001,", #160411-00027#11 mark
                " sfaa002,sfaa003,sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,",
                #" sfaa016,", #160411-00027#11 mark
                " sfaa017,sfaa018,sfaa020,sfaa021,sfaa022,",
                #" sfaa025,", #160411-00027#11 mark
                " sfaa058,sfaa060,",
                #" sfaa061,",  #160411-00027#11 mark
                " sfaa068,",
                #" sfaa014,sfaa015,sfaa026,sfaa028,sfaa029,",  #160411-00027#11 mark
                #" sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,sfaa059,sfaa062,sfaa039,sfaa040,sfaa041,sfaa042,", #160411-00027#11 mark
                #" sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,",  #160411-00027#11 mark
                " sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,",
                #" sfaa065,sfaa069,sfaa070,sfba001,", #160411-00027#11 mark
                " sfba002,sfba003,sfba004,sfba005,sfba006,",
                #" sfba007,sfba008,",  #160411-00027#11 mark
                " sfba009,sfba010,sfba011,sfba012,sfba015,sfba016,",
                " sfba017,sfba018,",
                #" sfba019,sfba020,",  #160411-00027#11 mark
                " sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028," ,
                #" sfba029,sfba030 " #160411-00027#11 mark
                " sfaa028,sfaa029,sfaa030,sfba008 ",  #160411-00027#11 add (需要抓出来，关联说明栏位时用到)
                " ORDER BY pmdt006,pmdt007 "  #160411-00027#11 add
   #160411-00027#11--mark--begin---
   #LET g_sql = g_sql,"UNION ALL",g_sql1
   #LET g_sql = " SELECT pmdt006, NULL,NULL,", 
   #            " pmdt007,pmdt019,sum(pmdt020s),0,sfaadocno,sfaa010, NULL,NULL,", 
   #            " sfaa019, imae081,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq,",
   #            " sfaa001,", 
   #            " sfaa002,sfaa003,sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,",
   #            " sfaa016,", 
   #            " sfaa017,sfaa018,sfaa020,sfaa021,sfaa022, sfaa025,", 
   #            " sfaa058,sfaa060, sfaa061, sfaa068,",
   #            " sfaa014,sfaa015,sfaa026,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,sfaa037,", 
   #            " sfaa038,sfaa059,sfaa062,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,",
   #            " sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,",
   #            " sfaa065,sfaa069,sfaa070,sfba001,NULL,NULL,",  
   #            " sfba002,sfba003,sfba004,sfba005,NULL,NULL,",  
   #            " sfba006, NULL,NULL,sfba007,sfba008,", 
   #            " sfba009,sfba010,sfba011,sfba012,sfba015,",
   #            " sfba016,sfba017,sfba018,sfba019,sfba020,", 
   #            " sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028,",
   #            " sfba029,sfba030,", 
   #            " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,",  
   #            " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL" ,  
   #            " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,", 
   #            " NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL",
   #            " FROM (",g_sql,") ",
   #            " GROUP BY sfaadocno,pmdt006,",
   #            " pmdt007,pmdt019,sfaadocno,sfaa010,",
   #            " sfaa019, imae081,sfba013,sfba014,sfbaseq1,sfbaseq,",
   #            #" sfaa001,", #160411-00027#11 mark
   #            " sfaa002,sfaa003,sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,",
   #            #" sfaa016,",  #160411-00027#11 mark
   #            " sfaa017,sfaa018,sfaa020,sfaa021,sfaa022,",
   #            #" sfaa025,",  #160411-00027#11 mark
   #            " sfaa058,sfaa060,",
   #            #" sfaa061,",  #160411-00027#11 mark
   #            " sfaa068,",
   #            #" sfaa014,sfaa015,sfaa026,sfaa028,sfaa029,",  #160411-00027#11 mark
   #            #" sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,sfaa059,sfaa062,sfaa039,sfaa040,sfaa041,sfaa042,", #160411-00027#11 mark
   #            #" sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,",  #160411-00027#11 mark
   #            " sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,",
   #            #" sfaa065,sfaa069,sfaa070,sfba001,", #160411-00027#11 mark
   #            " sfba002,sfba003,sfba004,sfba005,",
   #            " sfba006,",
   #            #" sfba007,sfba008,", #160411-00027#11 mark
   #            " sfba009,sfba010,sfba011,sfba012,sfba015,sfba016,",
   #            " sfba017,sfba018,",
   #            #" sfba019,sfba020,", #160411-00027#11 mark
   #            " sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028",
   #            #" sfba029,sfba030 ",  #160411-00027#11 mark
   #            " ORDER BY pmdt006,pmdt007 "
   ##dorislai-20150812-modify----(E) 
   #160411-00027#11---mark--end---
   
   #160411-00027#11 add--begin---
   LET g_sql = " SELECT pmdt006, ", 
               " (SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d1_imaal003 ,", 
               " (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = pmdt006 AND imaal002 =  '",g_dlang,"') d1_imaal004 ,",
               " pmdt007,pmdt019,pmdt020s,0,sfaadocno,sfaa010, ",
               " (SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = sfaa010 AND imaal002 =  '",g_dlang,"') d2_imaal003 ,",
               " (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = sfaa010 AND imaal002 =  '",g_dlang,"') d2_imaal004 ,", 
               " sfaa019, imae081,sfba013,sfba014,NULL,NULL,sfbaseq1,sfbaseq,",
               " sfaa002,sfaa003,sfaa004,sfaa057,sfaadocdt,sfaastus,sfaa005,sfaa006,sfaa009,sfaa011,sfaa012,sfaa013,",
               " sfaa017,sfaa018,sfaa020,sfaa021,sfaa022,sfaa058,sfaa060,",
               " sfaa068, sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,",
               " sfba002,sfba003,sfba004,sfba005,",
               " (SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = sfba005 AND imaal002 =  '",g_dlang,"') d3_imaal003 ,",
               " (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = sfba005 AND imaal002 =  '",g_dlang,"') d3_imaal004 ,",
               " sfba006, ", 
               " (SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = sfba006 AND imaal002 =  '",g_dlang,"') d4_imaal003 ,", 
               " (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = sfba006 AND imaal002 =  '",g_dlang,"') d4_imaal004 ,",
               " sfba009,sfba010,sfba011,sfba012,sfba015,",
               " sfba016,sfba017,sfba018,",
               " sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028,",
               " (SELECT ooag011 FROM ooag_t WHERE ooagent = ",g_enterprise," AND ooag001 = sfaa002) d1_ooag011, ",
               " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4007' AND gzcbl002 = sfaa003 AND gzcbl003 = '",g_dlang,"') d1_gzcbl004 ,",
               " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4008' AND gzcbl002 = sfaa004 AND gzcbl003 = '",g_dlang,"') d2_gzcbl004 ,",
               " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4010' AND gzcbl002 = sfaa057 AND gzcbl003 = '",g_dlang,"') d3_gzcbl004 ,",
               " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = sfaastus AND gzcbl003 = '",g_dlang,"') d4_gzcbl004 ,",
               " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4009' AND gzcbl002 = sfaa005 AND gzcbl003 = '",g_dlang,"') d5_gzcbl004 ,",
               " (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = ",g_enterprise," AND pmaal001 = sfaa009 AND pmaal002 = '",g_dlang,"') d1_pmaal004 ," ,
               " (SELECT oocal003 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = sfaa013 AND oocal002 = '",g_dlang,"') d1_oocal003,",
               " (CASE sfaa057 WHEN '2' THEN (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = ",g_enterprise," AND pmaal001 = sfaa017 AND pmaal002= '",g_dlang,"') ELSE (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=",g_enterprise," AND ooefl001=sfaa017 AND ooefl002='",g_dlang,"') END) d1_ooefl003,",
               " (SELECT ooeal003 FROM ooeal_t WHERE ooealent = ",g_enterprise," AND ooeal001 = sfaa018 AND ooeal002 ='",g_dlang,"') d1_ooeal003 ,",
               " (SELECT oocal003 FROM oocal_t WHERE oocalent = ",g_enterprise," AND oocal001 = sfaa060 AND oocal002 = '",g_dlang,"') d2_oocal003,",
               " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = ",g_enterprise," AND ooefl001 = sfaa068 AND ooefl002 = '",g_dlang,"') d2_ooefl003,",
               " (SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent = ",g_enterprise," AND pjbbl001 = sfaa028 AND pjbbl002 = sfaa029 AND pjbbl003 = '",g_dlang,"') d1_pjbbl004,",
               " (SELECT pjbml004 FROM pjbml_t WHERE pjbmlent = ",g_enterprise," AND pjbml001 = sfaa028 AND pjbml002 = sfaa030 AND pjbml003 = '",g_dlang,"') d1_pjbml004,",
               " (SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '215' AND oocql002 = sfba002 AND oocql003 = '",g_dlang,"') d1_oocql004 ,",
               " (SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '221' AND oocql002 = sfba003 AND oocql003 = '",g_dlang,"') d2_oocql004 ,",
               " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '1101' AND gzcbl002 = sfba008 AND gzcbl003 = '",g_dlang,"') d6_gzcbl004 ,",
               " (SELECT inaml004 FROM inaml_t WHERE inamlent = ",g_enterprise," AND inaml001 = sfba006 AND inaml002 = sfba021 AND inaml003 = '",g_dlang,"' ) d1_inaml004,",
               " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4012' AND gzcbl002 = sfba026 AND gzcbl003 = '",g_dlang,"') d7_gzcbl004 ",   
               " FROM (",g_sql,") ",
               " ORDER BY pmdt006,pmdt007 "
   #160411-00027#11 add--end---
   
   LET g_sql_tmp = g_sql
   #end add-point
   PREPARE asfr010_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE asfr010_x01_curs CURSOR FOR asfr010_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr010_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr010_x01_ins_data()
DEFINE sr RECORD 
   pmdt_t_pmdt006 LIKE pmdt_t.pmdt006, 
   pmdt006_desc1 LIKE type_t.chr30, 
   pmdt006_desc2 LIKE type_t.chr30, 
   pmdt_t_pmdt007 LIKE pmdt_t.pmdt007, 
   pmdt_t_pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt_t_pmdt020 LIKE pmdt_t.pmdt020, 
   sum_pmdt020 LIKE type_t.num20_6, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc1 LIKE type_t.chr30, 
   sfaa010_desc2 LIKE type_t.chr30, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   imae081_desc LIKE type_t.chr200, 
   sfba013 LIKE sfba_t.sfba013, 
   sfba014 LIKE sfba_t.sfba014, 
   qty1 LIKE type_t.num20_6, 
   qty2 LIKE type_t.num20_6, 
   sfbaseq1 LIKE sfba_t.sfbaseq1, 
   sfbaseq LIKE sfba_t.sfbaseq, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfaa004 LIKE sfaa_t.sfaa004, 
   sfaa057 LIKE sfaa_t.sfaa057, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfaa005 LIKE sfaa_t.sfaa005, 
   sfaa006 LIKE sfaa_t.sfaa006, 
   sfaa009 LIKE sfaa_t.sfaa009, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   sfaa018 LIKE sfaa_t.sfaa018, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa021 LIKE sfaa_t.sfaa021, 
   sfaa022 LIKE sfaa_t.sfaa022, 
   sfaa058 LIKE sfaa_t.sfaa058, 
   sfaa060 LIKE sfaa_t.sfaa060, 
   sfaa068 LIKE sfaa_t.sfaa068, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa055 LIKE sfaa_t.sfaa055, 
   sfaa056 LIKE sfaa_t.sfaa056, 
   sfba002 LIKE sfba_t.sfba002, 
   sfba003 LIKE sfba_t.sfba003, 
   sfba004 LIKE sfba_t.sfba004, 
   sfba005 LIKE sfba_t.sfba005, 
   l_sfba005_imaal003 LIKE type_t.chr50, 
   l_sfba005_imaal004 LIKE type_t.chr50, 
   sfba006 LIKE sfba_t.sfba006, 
   l_sfba006_imaal003 LIKE type_t.chr50, 
   l_sfba006_imaal004 LIKE type_t.chr50, 
   sfba009 LIKE sfba_t.sfba009, 
   sfba010 LIKE sfba_t.sfba010, 
   sfba011 LIKE sfba_t.sfba011, 
   sfba012 LIKE sfba_t.sfba012, 
   sfba015 LIKE sfba_t.sfba015, 
   sfba016 LIKE sfba_t.sfba016, 
   sfba017 LIKE sfba_t.sfba017, 
   sfba018 LIKE sfba_t.sfba018, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba022 LIKE sfba_t.sfba022, 
   sfba023 LIKE sfba_t.sfba023, 
   sfba024 LIKE sfba_t.sfba024, 
   sfba025 LIKE sfba_t.sfba025, 
   sfba026 LIKE sfba_t.sfba026, 
   sfba027 LIKE sfba_t.sfba027, 
   sfba028 LIKE sfba_t.sfba028, 
   l_sfaa002_desc LIKE type_t.chr30, 
   l_sfaa003_desc LIKE type_t.chr30, 
   l_sfaa004_desc LIKE type_t.chr30, 
   l_sfaa057_desc LIKE type_t.chr30, 
   l_sfaastus_desc LIKE type_t.chr30, 
   l_sfaa005_desc LIKE type_t.chr30, 
   l_sfaa009_desc LIKE type_t.chr30, 
   l_sfaa013_desc LIKE type_t.chr30, 
   l_sfaa017_desc LIKE type_t.chr30, 
   l_sfaa018_desc LIKE type_t.chr30, 
   l_sfaa060_desc LIKE type_t.chr30, 
   l_sfaa068_desc LIKE type_t.chr50, 
   l_sfaa029_desc LIKE type_t.chr50, 
   l_sfaa030_desc LIKE type_t.chr50, 
   l_sfba002_desc LIKE type_t.chr30, 
   l_sfba003_desc LIKE type_t.chr30, 
   l_sfba008_desc LIKE type_t.chr30, 
   l_sfba021_desc LIKE type_t.chr100, 
   l_sfba026_desc LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sfba015      LIKE sfba_t.sfba015
DEFINE l_sfba016      LIKE sfba_t.sfba016
DEFINE l_success      LIKE type_t.num5
DEFINE l_rate         LIKE inaj_t.inaj014
DEFINE l_success2     LIKE type_t.num5
DEFINE l_rate2        LIKE inaj_t.inaj014
DEFINE l_success3     LIKE type_t.num5
DEFINE l_sum_pmdt020  LIKE type_t.num20_6
DEFINE l_pmdt006      LIKE pmdt_t.pmdt006
DEFINE l_pmdt007      LIKE pmdt_t.pmdt007
DEFINE l_imaa127 LIKE imaa_t.imaa127   #系列       20150811 by dorislai add  (S)
DEFINE l_imae032 LIKE imae_t.imae032   #製程料號   
DEFINE l_sfaa007 LIKE sfaa_t.sfaa007   #來源項次
DEFINE l_sfaa008 LIKE sfaa_t.sfaa008   #來源項序
DEFINE l_sfaa063 LIKE sfaa_t.sfaa063   #來源分批序  20150811 by dorislai add  (E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    CALL asfr010_x01_tmp()
    LET l_sum_pmdt020 = 0
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH asfr010_x01_curs INTO sr.*                               
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
       #160411-00027#11--mark--begin--
       ##生产料号sfaa010  
       #SELECT imaal003,imaal004 INTO sr.sfaa010_desc1,sr.sfaa010_desc2
       #FROM imaal_t
       #WHERE imaalent = g_enterprise
       #AND imaal001 = sr.sfaa010
       #AND imaal002 = g_dlang
       ##料件编号pmdt006 
       #SELECT imaal003,imaal004 INTO sr.pmdt006_desc1,sr.pmdt006_desc2
       #FROM imaal_t
       #WHERE imaalent = g_enterprise
       #AND imaal001 = sr.pmdt_t_pmdt006
       #AND imaal002 = g_dlang
       #160411-00027#11--mark--end---
       
       SELECT sfba015,sfba016 INTO l_sfba015,l_sfba016 #sfba015:委外代买数量;sfba016:已发数量
       FROM sfba_t
       WHERE sfbaent = g_enterprise
       AND sfbadocno = sr.sfaadocno
       AND sfbaseq = sr.sfbaseq
       AND sfbaseq1 = sr.sfbaseq1
       
       IF cl_null(sr.imae081_desc) THEN #发料单位为空的时候取基础单位
         SELECT imaa006 INTO sr.imae081_desc
         FROM imaa_t
         WHERE imaaent = g_enterprise
         AND imaa001 = sr.pmdt_t_pmdt006
       END IF
       #收料数量转换率
       CALL s_aimi190_get_convert(sr.pmdt_t_pmdt006,sr.pmdt_t_pmdt019,sr.imae081_desc) RETURNING l_success,l_rate
       #应发数量转换率
       CALL s_aimi190_get_convert(sr.pmdt_t_pmdt006,sr.sfba014,sr.imae081_desc) RETURNING l_success2,l_rate2
       
       LET sr.pmdt_t_pmdt020 = sr.pmdt_t_pmdt020 * l_rate
       
       LET sr.sfba013 = sr.sfba013 * l_rate2
       LET l_sfba015 = l_sfba015 * l_rate2
       LET l_sfba016 = l_sfba016 * l_rate2
       
       LET sr.qty1 = sr.sfba013 - l_sfba015 - l_sfba016
       CALL s_asft300_07(sr.sfaadocno,sr.sfbaseq,sr.sfbaseq1) RETURNING l_success3,sr.qty2
       IF cl_null(sr.qty1) THEN
         LET sr.qty1 = 0
       END IF
       IF cl_null(sr.qty2) THEN
         LET sr.qty2 = 0
       END IF
       
       #160411-00027#11--mark--begin---
       #dorislai-20150811-add----(S)
       ##單頭
       ##生管人員全名 l_sfaa002desc	
       #LET sr.l_sfaa002_desc = ''
       #LET sr.l_sfaa002desc = ''
       #SELECT ooag011 INTO sr.l_sfaa002_desc FROM ooag_t 
       # WHERE ooagent = g_enterprise AND ooag001 = sr.sfaa002 
       #IF NOT cl_null(sr.l_sfaa002_desc) THEN
       #   LET sr.l_sfaa002desc = sr.sfaa002,'.',sr.l_sfaa002_desc
       #END IF
       ##工單類型全名 l_sfaa003desc	
       #LET sr.l_sfaa003_desc = ''
       #LET sr.l_sfaa003desc = ''
       #CALL s_desc_gzcbl004_desc('4007',sr.sfaa003) RETURNING sr.l_sfaa003_desc
       #IF NOT cl_null(sr.l_sfaa003_desc) THEN
       #   LET sr.l_sfaa003desc = sr.sfaa003,'.',sr.l_sfaa003_desc 
       #END IF
       ##發科制度全名 l_sfaa004desc	
       #LET sr.l_sfaa004_desc = ''
       #LET sr.l_sfaa004desc = ''
       #CALL s_desc_gzcbl004_desc('4008',sr.sfaa004) RETURNING sr.l_sfaa004_desc
       #IF NOT cl_null(sr.l_sfaa004_desc) THEN
       #   LET sr.l_sfaa004desc = sr.sfaa004,'.',sr.l_sfaa004_desc
       #END IF
       ##委外類型全名 l_sfaa057desc	
       #LET sr.l_sfaa057_desc = ''
       #LET sr.l_sfaa057desc = ''
       #CALL s_desc_gzcbl004_desc('4010',sr.sfaa057) RETURNING sr.l_sfaa057_desc
       #IF NOT cl_null(sr.l_sfaa057_desc) THEN
       #   LET sr.l_sfaa057desc = sr.sfaa057,'.',sr.l_sfaa057_desc
       #END IF
       ##單號全名 l_sfaadocnodesc	
       #LET sr.l_sfaadocno_desc = ''
       #LET sr.l_sfaadocnodesc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaadocno) RETURNING sr.l_sfaadocno_desc
       #IF NOT cl_null(sr.l_sfaadocno_desc) THEN
       #   LET sr.l_sfaadocnodesc = sr.sfaadocno,'.',sr.l_sfaadocno_desc
       #END IF
       ##狀態碼全名 l_sfaastusdesc	
       #LET sr.l_sfaastus_desc = ''
       #LET sr.l_sfaastusdesc = ''
       #CALL s_desc_gzcbl004_desc('13',sr.sfaastus) RETURNING sr.l_sfaastus_desc
       #IF NOT cl_null(sr.l_sfaastus_desc) THEN
       #   LET sr.l_sfaastusdesc = sr.sfaastus,'.',sr.l_sfaastus_desc
       #END IF
       #
       ##====基本資料====
       ##工單來源全名 l_sfaa005desc	
       #LET sr.l_sfaa005_desc = ''
       #LET sr.l_sfaa005desc = ''
       #CALL s_desc_gzcbl004_desc('4009',sr.sfaa005) RETURNING sr.l_sfaa005_desc
       #IF NOT cl_null(sr.l_sfaa005_desc) THEN
       #   LET sr.l_sfaa005desc = sr.sfaa005,'.',sr.l_sfaa005_desc
       #END IF
       ##來源單號全名 l_sfaa006desc	
       #LET sr.l_sfaa006_desc = ''	
       #LET sr.l_sfaa006desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa006) RETURNING sr.l_sfaa006_desc
       #IF NOT cl_null(sr.l_sfaa006_desc) THEN
       #   LET sr.l_sfaa006desc = sr.sfaa006,'.',sr.l_sfaa006_desc
       #END IF
       #
       ##來源項次序 l_sfaa007
       #LET sr.l_sfaa007 = ''
       #SELECT sfaa007,sfaa008,sfaa063 INTO l_sfaa007,l_sfaa008,l_sfaa063 FROM sfaa_t
       # WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = sr.sfaadocno
       ##---項次
       #IF NOT cl_null(l_sfaa007) THEN
       #   LET sr.l_sfaa007 = l_sfaa007
       #END IF
       ##----項序
       #IF NOT cl_null(l_sfaa008) THEN
       #   LET sr.l_sfaa007 = sr.l_sfaa007 CLIPPED ||'-'||l_sfaa008 
       #END IF
       ##----分批序
       #IF NOT cl_null(l_sfaa063) THEN
       #   LET sr.l_sfaa007 = sr.l_sfaa007 CLIPPED ||'-'||l_sfaa063
       #END IF
       #
       ##參考客戶全名 l_sfaa009desc	
       #LET sr.l_sfaa009_desc = ''
       #LET sr.l_sfaa009desc = ''
       #SELECT pmaal004 INTO sr.l_sfaa009_desc FROM pmaal_t 
       # WHERE pmaalent = g_enterprise AND pmaal001 = sr.sfaa009 AND pmaal002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa009_desc) THEN
       #   LET sr.l_sfaa009desc = sr.sfaa009,'.',sr.l_sfaa009_desc
       #END IF
       ##生產單位全名 l_sfaa013desc	
       #LET sr.l_sfaa013_desc = ''
       #LET sr.l_sfaa013desc = ''
       #SELECT oocal003 INTO sr.l_sfaa013_desc FROM oocal_t 
       # WHERE oocalent = g_enterprise AND oocal001 = sr.sfaa013 AND oocal002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa013_desc) THEN
       #   LET sr.l_sfaa013desc = sr.sfaa013,'.',sr.l_sfaa013_desc
       #END IF
       ##製成編號全名 l_sfaa016desc	
       #LET sr.l_sfaa016_desc = ''
       #LET sr.l_sfaa016desc = ''
       #IF NOT cl_null(sr.sfaa016) THEN
       #   #抓製成料號
       #   SELECT imae032 INTO l_imae032 FROM imae_t 
       #    WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = sr.sfaa010
       #   IF cl_null(l_imae032) THEN
       #      LET l_imae032 = sr.sfaa010
       #   END IF
       #   #抓製成編號
       #   IF NOT cl_null(l_imae032) THEN
       #      SELECT ecba003 INTO sr.l_sfaa016_desc FROM ecba_t 
       #       WHERE ecbaent = g_enterprise AND ecba001 = l_imae032 AND ecba002 = sr.sfaa016
       #   END IF
       #END IF
       #
       #IF NOT cl_null(sr.l_sfaa016_desc) THEN
       #   LET sr.l_sfaa016desc = sr.sfaa016,'.',sr.l_sfaa016_desc
       #END IF
       ##部門廠商全名 l_sfaa017desc	
       #LET sr.l_sfaa017_desc = ''
       #LET sr.l_sfaa017desc = ''
       #
       #IF sr.sfaa057 = '2' THEN
       #   INITIALIZE g_chkparam.* TO NULL
       #   LET g_chkparam.arg1 = sr.sfaa017
       #   CALL cl_ref_val("v_pmaal004")
       #   LET sr.l_sfaa017_desc = g_chkparam.return1
       #ELSE
       #   CALL s_desc_get_department_desc(sr.sfaa017) RETURNING sr.l_sfaa017_desc
       #END IF
       #
       #IF NOT cl_null(sr.l_sfaa017_desc) THEN
       #   LET sr.l_sfaa017desc = sr.sfaa017,'.',sr.l_sfaa017_desc
       #END IF
       ##協作據點全名 l_sfaa018desc	
       #LET sr.l_sfaa018_desc = ''
       #LET sr.l_sfaa018desc = ''
       #SELECT ooeal003 INTO sr.l_sfaa018_desc FROM ooeal_t
       # WHERE ooealent = g_enterprise AND ooeal001 = sr.sfaa018 AND ooeal002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa018_desc) THEN
       #   LET sr.l_sfaa018desc = sr.sfaa018,'.',sr.l_sfaa018_desc
       #END IF
       ##母工單單號全名 l_sfaa021desc	
       #LET sr.l_sfaa021_desc = ''
       #LET sr.l_sfaa021desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa021) RETURNING sr.l_sfaa021_desc
       #IF NOT cl_null(sr.l_sfaa021_desc) THEN
       #   LET sr.l_sfaa021desc = sr.sfaa021,'.',sr.l_sfaa021_desc
       #END IF
       ##參考原始單號全名 l_sfaa022desc	
       #LET sr.l_sfaa022_desc = ''
       #LET sr.l_sfaa022desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa022) RETURNING sr.l_sfaa022_desc
       #IF NOT cl_null(sr.l_sfaa022_desc) THEN
       #   LET sr.l_sfaa022desc = sr.sfaa022,'.',sr.l_sfaa022_desc
       #END IF
       ##前工單單號全名 l_sfaa025desc	
       #LET sr.l_sfaa025_desc = ''
       #LET sr.l_sfaa025desc = ''
       #CALL s_aooi200_get_slip_desc(sr.sfaa025) RETURNING sr.l_sfaa025_desc
       #IF NOT cl_null(sr.l_sfaa025_desc) THEN
       #   LET sr.l_sfaa025desc = sr.sfaa025,'.',sr.l_sfaa025_desc
       #END IF
       ##參考單位全名 l_sfaa060desc	
       #LET sr.l_sfaa060_desc = ''
       #LET sr.l_sfaa060desc = ''
       #SELECT oocal003 INTO sr.l_sfaa060_desc FROM oocal_t 
       # WHERE oocalent = g_enterprise AND oocal001 = sr.sfaa060 AND oocal002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa060_desc) THEN
       #   LET sr.l_sfaa060desc = sr.sfaa060,'.',sr.l_sfaa060_desc
       #END IF  
       ##成本中心全名 l_sfaa068desc	
       #LET sr.l_sfaa068_desc = ''
       #LET sr.l_sfaa068desc = ''
       #SELECT ooefl003 INTO sr.l_sfaa068_desc FROM ooefl_t
       # WHERE ooeflent = g_enterprise AND ooefl001 = sr.sfaa068 AND ooefl002 = g_dlang
       #IF NOT cl_null(sr.l_sfaa068_desc) THEN
       #   LET sr.l_sfaa068desc = sr.sfaa068,'.',sr.l_sfaa068_desc
       #END IF
       #
       ##====工單資料====
       ##專案代號全名 l_sfaa028desc
       #LET sr.l_sfaa028_desc = ''
       #LET sr.l_sfaa028desc = ''
       #CALL s_desc_get_project_desc(sr.sfaa028) RETURNING sr.l_sfaa028_desc
       #IF NOT cl_null(sr.l_sfaa028_desc) THEN
       #   LET sr.l_sfaa028desc = sr.sfaa028,'.',sr.l_sfaa028_desc
       #END IF
       ##WBS全名 l_sfaa029desc
       #LET sr.l_sfaa029_desc = ''
       #LET sr.l_sfaa029desc = ''
       #CALL s_desc_get_wbs_desc(sr.sfaa028,sr.sfaa029) RETURNING sr.l_sfaa029_desc
       #IF NOT cl_null(sr.l_sfaa029_desc) THEN
       #   LET sr.l_sfaa029desc = sr.sfaa029,'.',sr.l_sfaa029_desc
       #END IF
       ##活動全名 l_sfaa030desc
       #LET sr.l_sfaa030_desc = ''
       #LET sr.l_sfaa030desc = ''
       #CALL s_desc_get_activity_desc(sr.sfaa028,sr.sfaa030) RETURNING sr.l_sfaa030_desc
       #IF NOT cl_null(sr.l_sfaa030_desc) THEN
       #   LET sr.l_sfaa030desc = sr.sfaa030,'.',sr.l_sfaa030_desc
       #END IF
       ##理由碼全名 l_sfaa031desc
       #LET sr.l_sfaa031_desc = ''
       #LET sr.l_sfaa031desc = ''
       #CALL s_desc_get_acc_desc('225',sr.sfaa031) RETURNING sr.l_sfaa031_desc
       #IF NOT cl_null(sr.l_sfaa031_desc) THEN
       #   LET sr.l_sfaa031desc = sr.sfaa031,'.',sr.l_sfaa031_desc
       #END IF
       ##預計入庫庫位全名 l_sfaa034desc
       #LET sr.l_sfaa034_desc = ''
       #LET sr.l_sfaa034desc = ''
       #CALL s_desc_get_stock_desc(g_site,sr.sfaa034) RETURNING sr.l_sfaa034_desc
       #IF NOT cl_null(sr.l_sfaa034_desc) THEN
       #   LET sr.l_sfaa034desc = sr.sfaa034,'.',sr.l_sfaa034_desc
       #END IF
       ##預計入庫儲位全名 l_sfaa035desc
       #LET sr.l_sfaa035_desc = ''
       #LET sr.l_sfaa035desc = ''
       #CALL s_desc_get_locator_desc(g_site,sr.sfaa034,sr.sfaa035) RETURNING sr.l_sfaa035_desc
       #IF NOT cl_null(sr.l_sfaa035_desc) THEN
       #   LET sr.l_sfaa035desc = sr.sfaa035,'.',sr.l_sfaa035_desc
       #END IF
       #
       ##====相關資訊====
       ##生管結案狀態全名 l_sfaa065desc
       #LET sr.l_sfaa065_desc = ''
       #LET sr.l_sfaa065desc = ''
       #CALL s_desc_gzcbl004_desc('4022',sr.sfaa065) RETURNING sr.l_sfaa065_desc
       #IF NOT cl_null(sr.l_sfaa065_desc) THEN
       #   LET sr.l_sfaa065desc = sr.sfaa065,'.',sr.l_sfaa065_desc
       #END IF
       ##系列全名 l_imaa127desc
       #LET sr.l_imaa127_desc = ''
       #LET sr.l_imaa127desc = ''
       #   #用料號抓取系列
       #SELECT imaa127 INTO l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.sfaa010
       #   AND imaaent = g_enterprise
       #  #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc 
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc
       #END IF
       #
       ##====備料明細====
       ##部位全名	l_sfba002desc
       #LET sr.l_sfba002_desc = ''
       #LET sr.l_sfba002desc = ''
       #SELECT oocql004 INTO sr.l_sfba002_desc FROM oocql_t
       # WHERE oocqlent = g_enterprise AND oocql001 = '215' 
       #   AND oocql002 = sr.sfba002 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_sfba002_desc) THEN
       #   LET sr.l_sfba002desc = sr.sfba002,'.',sr.l_sfba002_desc
       #END IF
       ##作業編號全名	l_sfba003desc
       #LET sr.l_sfba003_desc = ''
       #LET sr.l_sfba003desc = ''
       #SELECT oocql004 INTO sr.l_sfba003_desc FROM oocql_t
       # WHERE oocqlent = g_enterprise AND oocql001 = '221' 
       #   AND oocql002 = sr.sfba003 AND oocql003 = g_dlang
       #IF NOT cl_null(sr.l_sfba003_desc) THEN
       #   LET sr.l_sfba003desc = sr.sfba003,'.',sr.l_sfba003_desc
       #END IF
       ##必要特性全名	l_sfba008desc
       #LET sr.l_sfba008_desc = ''
       #LET sr.l_sfba008desc = ''
       #CALL s_desc_gzcbl004_desc('1101',sr.sfba008) RETURNING sr.l_sfba008_desc
       #IF NOT cl_null(sr.l_sfba008_desc) THEN
       #   LET sr.l_sfba008desc = sr.sfba008,'.',sr.l_sfba008_desc
       #END IF
       ##指定發料倉庫全名	l_sfba019desc
       #LET sr.l_sfba019_desc = ''
       #LET sr.l_sfba019desc = ''
       #CALL s_desc_get_stock_desc(g_site,sr.sfba019) RETURNING sr.l_sfba019_desc
       #IF NOT cl_null(sr.l_sfba019_desc) THEN
       #   LET sr.l_sfba019desc = sr.sfba019,'.',sr.l_sfba019_desc
       #END IF
       ##儲位名稱全名	l_sfba020desc
       #LET sr.l_sfba020_desc = ''
       #LET sr.l_sfba020desc = ''
       #CALL s_desc_get_locator_desc(g_site,sr.sfba019,sr.sfba020) RETURNING sr.l_sfba020_desc
       #IF NOT cl_null(sr.l_sfba020_desc) THEN
       #   LET sr.l_sfba020desc = sr.sfba020,'.',sr.l_sfba020_desc
       #END IF
       ##產品特徵全名	l_sfba021desc
       #LET sr.l_sfba021_desc = ''
       #LET sr.l_sfba021desc = ''
       #CALL s_feature_description(sr.sfba006,sr.sfba021) RETURNING l_success,sr.l_sfba021_desc
       #IF NOT cl_null(sr.l_sfba021_desc) THEN
       #   LET sr.l_sfba021desc = sr.sfba021,'.',sr.l_sfba021_desc
       #END IF
       ##替代狀態全名	l_sfba026desc
       #LET sr.l_sfba026_desc = ''
       #LET sr.l_sfba026desc = ''
       #CALL s_desc_gzcbl004_desc('4012',sr.sfba026) RETURNING sr.l_sfba026_desc
       #IF NOT cl_null(sr.l_sfba026_desc) THEN
       #   LET sr.l_sfba026desc = sr.sfba026,'.',sr.l_sfba026_desc
       #END IF
       #
       #
       ##上階料號品名(l_sfba001_imaal003).上階料號規格	(l_sfba001_imaal004)
       #SELECT imaal003,imaal004 INTO sr.l_sfba001_imaal003,sr.l_sfba001_imaal004
       #FROM imaal_t
       #WHERE imaalent = g_enterprise
       #AND imaal001 = sr.sfba001
       #AND imaal002 = g_dlang
       #
       ##發料料號品名(l_sfba006_imaal003).發料料號規格	(l_sfba006_imaal004)
       #SELECT imaal003,imaal004 INTO sr.l_sfba006_imaal003,sr.l_sfba006_imaal004
       #FROM imaal_t
       #WHERE imaalent = g_enterprise
       #AND imaal001 = sr.sfba006
       #AND imaal002 = g_dlang
       #
       ##BOM品名(l_sfba005_imaal003).BOM規格(l_sfba005_imaal004)
       #SELECT imaal003,imaal004 INTO sr.l_sfba005_imaal003,sr.l_sfba005_imaal004
       #FROM imaal_t
       #WHERE imaalent = g_enterprise
       #AND imaal001 = sr.sfba005
       #AND imaal002 = g_dlang
       ##dorislai-20150811-add----(E)
       #160411-00027#11--mark---end000
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       IF tm.flag2 = 'N' THEN
       IF sr.qty1 > 0 THEN #未发数量等于0就不需要显示
#         IF (l_pmdt006 <> sr.pmdt_t_pmdt006 OR l_pmdt007 <> sr.pmdt_t_pmdt007) OR (l_pmdt006 IS NULL OR l_pmdt007 IS null)  THEN
#               CALL asfr010_x01_sum_pmdt020(sr.pmdt_t_pmdt006,sr.pmdt_t_pmdt007,l_rate) RETURNING l_sum_pmdt020
#               LET l_pmdt006 = sr.pmdt_t_pmdt006 
#               LET l_pmdt007 = sr.pmdt_t_pmdt007
#            END IF
#         
#         LET sr.sum_pmdt020 = l_sum_pmdt020
#          IF (l_pmdt006 <> sr.pmdt_t_pmdt006 OR l_pmdt007 <> sr.pmdt_t_pmdt007) OR (l_pmdt006 IS NULL OR l_pmdt007 IS null)  THEN
#               CALL asfr010_x01_sum2_pmdt020(sr.pmdt_t_pmdt006,sr.pmdt_t_pmdt007,l_rate) RETURNING l_sum_pmdt020
#               LET l_pmdt006 = sr.pmdt_t_pmdt006 
#               LET l_pmdt007 = sr.pmdt_t_pmdt007
#          END IF
#          LET sr.sum_pmdt020 = l_sum_pmdt020
           LET sr.sum_pmdt020 = sr.pmdt_t_pmdt020
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdt_t_pmdt006,sr.pmdt006_desc1,sr.pmdt006_desc2,sr.pmdt_t_pmdt007,sr.pmdt_t_pmdt019,sr.pmdt_t_pmdt020,sr.sum_pmdt020,sr.sfaadocno,sr.sfaa010,sr.sfaa010_desc1,sr.sfaa010_desc2,sr.sfaa019,sr.imae081_desc,sr.sfba013,sr.sfba014,sr.qty1,sr.qty2,sr.sfbaseq1,sr.sfbaseq,sr.sfaa002,sr.sfaa003,sr.sfaa004,sr.sfaa057,sr.sfaadocdt,sr.sfaastus,sr.sfaa005,sr.sfaa006,sr.sfaa009,sr.sfaa011,sr.sfaa012,sr.sfaa013,sr.sfaa017,sr.sfaa018,sr.sfaa020,sr.sfaa021,sr.sfaa022,sr.sfaa058,sr.sfaa060,sr.sfaa068,sr.sfaa049,sr.sfaa050,sr.sfaa051,sr.sfaa055,sr.sfaa056,sr.sfba002,sr.sfba003,sr.sfba004,sr.sfba005,sr.l_sfba005_imaal003,sr.l_sfba005_imaal004,sr.sfba006,sr.l_sfba006_imaal003,sr.l_sfba006_imaal004,sr.sfba009,sr.sfba010,sr.sfba011,sr.sfba012,sr.sfba015,sr.sfba016,sr.sfba017,sr.sfba018,sr.sfba021,sr.sfba022,sr.sfba023,sr.sfba024,sr.sfba025,sr.sfba026,sr.sfba027,sr.sfba028,sr.l_sfaa002_desc,sr.l_sfaa003_desc,sr.l_sfaa004_desc,sr.l_sfaa057_desc,sr.l_sfaastus_desc,sr.l_sfaa005_desc,sr.l_sfaa009_desc,sr.l_sfaa013_desc,sr.l_sfaa017_desc,sr.l_sfaa018_desc,sr.l_sfaa060_desc,sr.l_sfaa068_desc,sr.l_sfaa029_desc,sr.l_sfaa030_desc,sr.l_sfba002_desc,sr.l_sfba003_desc,sr.l_sfba008_desc,sr.l_sfba021_desc,sr.l_sfba026_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "asfr010_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       END IF
       END IF
       
       IF tm.flag2 = 'Y' THEN
         IF sr.qty1 > 0 THEN #未发数量等于0就不需要显示
#            IF (l_pmdt006 <> sr.pmdt_t_pmdt006 OR l_pmdt007 <> sr.pmdt_t_pmdt007) OR (l_pmdt006 IS NULL OR l_pmdt007 IS null)  THEN
#                  CALL asfr010_x01_sum_pmdt020(sr.pmdt_t_pmdt006,sr.pmdt_t_pmdt007,l_rate) RETURNING l_sum_pmdt020
#                  LET l_pmdt006 = sr.pmdt_t_pmdt006 
#                  LET l_pmdt007 = sr.pmdt_t_pmdt007
#            END IF
#            LET sr.sum_pmdt020 = l_sum_pmdt020
#          IF (l_pmdt006 <> sr.pmdt_t_pmdt006 OR l_pmdt007 <> sr.pmdt_t_pmdt007) OR (l_pmdt006 IS NULL OR l_pmdt007 IS null)  THEN
#               CALL asfr010_x01_sum2_pmdt020(sr.pmdt_t_pmdt006,sr.pmdt_t_pmdt007,l_rate) RETURNING l_sum_pmdt020
#               LET l_pmdt006 = sr.pmdt_t_pmdt006 
#               LET l_pmdt007 = sr.pmdt_t_pmdt007
#          END IF
#          LET sr.sum_pmdt020 = l_sum_pmdt020
          LET sr.sum_pmdt020 = sr.pmdt_t_pmdt020

            IF sr.qty2 > 0 THEN
               EXECUTE insert_prep USING sr.pmdt_t_pmdt006,sr.pmdt006_desc1,sr.pmdt006_desc2,sr.pmdt_t_pmdt007,sr.pmdt_t_pmdt019,sr.pmdt_t_pmdt020,sr.sum_pmdt020,sr.sfaadocno,sr.sfaa010,sr.sfaa010_desc1,sr.sfaa010_desc2,sr.sfaa019,sr.imae081_desc,sr.sfba013,sr.sfba014,sr.qty1,sr.qty2,sr.sfbaseq1,sr.sfbaseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "asfr010_x01_execute"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  LET g_rep_success = 'N'
                  EXIT FOREACH
               END IF
            END IF
         END IF
       END IF
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    DROP TABLE asfr010_1_tmp
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfr010_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr010_x01_rep_data()
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
 
{<section id="asfr010_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明：创建临时表
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150603 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr010_x01_tmp()
   DEFINE l_sql             STRING
   
   DEFINE sr_tmp RECORD 
      pmdt_t_pmdt006 LIKE pmdt_t.pmdt006, 
      pmdt006_desc1 LIKE type_t.chr30, 
      pmdt006_desc2 LIKE type_t.chr30, 
      pmdt_t_pmdt007 LIKE pmdt_t.pmdt007, 
      pmdt_t_pmdt019 LIKE pmdt_t.pmdt019, 
      pmdt_t_pmdt020 LIKE pmdt_t.pmdt020, 
      sum_pmdt020 LIKE type_t.num20_6, 
      sfaadocno LIKE sfaa_t.sfaadocno, 
      sfaa010 LIKE sfaa_t.sfaa010, 
      sfaa010_desc1 LIKE type_t.chr30, 
      sfaa010_desc2 LIKE type_t.chr30, 
      sfaa019 LIKE sfaa_t.sfaa019, 
      imae081_desc LIKE type_t.chr200, 
      sfba013 LIKE sfba_t.sfba013, 
      sfba014 LIKE sfba_t.sfba014, 
      qty1 LIKE type_t.num20_6, 
      qty2 LIKE type_t.num20_6, 
      sfbaseq1 LIKE sfba_t.sfbaseq1, 
      sfbaseq LIKE sfba_t.sfbaseq
   END RECORD
   
   DROP TABLE asfr010_1_tmp
   
   CREATE TEMP TABLE asfr010_1_tmp(
      pmdt_t_pmdt006     LIKE pmdt_t.pmdt006, 
      pmdt006_desc1      LIKE type_t.chr30, 
      pmdt006_desc2      LIKE type_t.chr30, 
      pmdt_t_pmdt007     LIKE pmdt_t.pmdt007, 
      pmdt_t_pmdt019     LIKE pmdt_t.pmdt019, 
      pmdt_t_pmdt020     LIKE pmdt_t.pmdt020, 
      sum_pmdt020        LIKE type_t.num20_6, 
      sfaadocno          LIKE sfaa_t.sfaadocno, 
      sfaa010            LIKE sfaa_t.sfaa010, 
      sfaa010_desc1      LIKE type_t.chr30, 
      sfaa010_desc2      LIKE type_t.chr30, 
      sfaa019            LIKE sfaa_t.sfaa019, 
      imae081_desc       LIKE type_t.chr200, 
      sfba013            LIKE sfba_t.sfba013, 
      sfba014            LIKE sfba_t.sfba014, 
      qty1               LIKE type_t.num20_6, 
      qty2               LIKE type_t.num20_6, 
      sfbaseq1           LIKE sfba_t.sfbaseq1, 
      sfbaseq            LIKE sfba_t.sfbaseq
   )

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfr010_1_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   PREPARE asfr010_x01_pt_tmp FROM g_sql_tmp
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   DECLARE asfr010_x01_cst_tmp CURSOR FOR asfr010_x01_pt_tmp
   #161109-00085#40-s
   #FOREACH asfr010_x01_cst_tmp INTO sr_tmp.*
   FOREACH asfr010_x01_cst_tmp 
   INTO sr_tmp.pmdt_t_pmdt006,sr_tmp.pmdt006_desc1,sr_tmp.pmdt006_desc2,sr_tmp.pmdt_t_pmdt007,sr_tmp.pmdt_t_pmdt019,
        sr_tmp.pmdt_t_pmdt020,sr_tmp.sum_pmdt020,sr_tmp.sfaadocno,sr_tmp.sfaa010,sr_tmp.sfaa010_desc1,
        sr_tmp.sfaa010_desc2,sr_tmp.sfaa019,sr_tmp.imae081_desc,sr_tmp.sfba013,sr_tmp.sfba014,       
        sr_tmp.qty1,sr_tmp.qty2,sr_tmp.sfbaseq1,sr_tmp.sfbaseq 
   #161109-00085#40-e
      LET sr_tmp.qty1 = 0
      LET sr_tmp.qty2 = 0
      LET sr_tmp.sum_pmdt020 = 0
      LET sr_tmp.pmdt006_desc1 = ' '
      LET sr_tmp.pmdt006_desc2 = ' ' 
      LET sr_tmp.sfaa010_desc1 = ' '   
      LET sr_tmp.sfaa010_desc2 = ' '     
      LET sr_tmp.imae081_desc = ' '      
      
      #161109-00085#40-s
      #INSERT INTO asfr010_1_tmp VALUES (sr_tmp.*)
      INSERT INTO asfr010_1_tmp (pmdt_t_pmdt006,pmdt006_desc1,pmdt006_desc2,pmdt_t_pmdt007,pmdt_t_pmdt019,
                                 pmdt_t_pmdt020,sum_pmdt020,sfaadocno,sfaa010,sfaa010_desc1,
                                 sfaa010_desc2,sfaa019,imae081_desc,sfba013,sfba014,       
                                 qty1,qty2,sfbaseq1,sfbaseq ) 
              VALUES (sr_tmp.pmdt_t_pmdt006,sr_tmp.pmdt006_desc1,sr_tmp.pmdt006_desc2,sr_tmp.pmdt_t_pmdt007,sr_tmp.pmdt_t_pmdt019,
                      sr_tmp.pmdt_t_pmdt020,sr_tmp.sum_pmdt020,sr_tmp.sfaadocno,sr_tmp.sfaa010,sr_tmp.sfaa010_desc1,
                      sr_tmp.sfaa010_desc2,sr_tmp.sfaa019,sr_tmp.imae081_desc,sr_tmp.sfba013,sr_tmp.sfba014,       
                      sr_tmp.qty1,sr_tmp.qty2,sr_tmp.sfbaseq1,sr_tmp.sfbaseq )
      #161109-00085#40-e       
      IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT asfr010_1_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   END FOREACH
  
END FUNCTION

################################################################################
# Descriptions...: 描述说明计算收货数量
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150603 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr010_x01_sum_pmdt020(p_pmdt006,p_pmdt007,p_rate)
   DEFINE p_pmdt006           LIKE  pmdt_t.pmdt006
   DEFINE p_pmdt007           LIKE  pmdt_t.pmdt007
   DEFINE p_rate              LIKE  inaj_t.inaj014
   DEFINE l_sql               STRING
   DEFINE l_pmdt020           LIKE  pmdt_t.pmdt020
   
   LET g_sum_pmt020 = 0
   
   IF p_pmdt007 IS NULL THEN
      LET l_sql = " SELECT pmdt_t_pmdt020 FROM asfr010_1_tmp ",
               "  WHERE pmdt_t_pmdt006 = '",p_pmdt006,"' ",
               "    AND pmdt_t_pmdt007 IS NULL "
   ELSE
      LET l_sql = " SELECT pmdt_t_pmdt020 FROM asfr010_1_tmp ",
               "  WHERE pmdt_t_pmdt006 = '",p_pmdt006,"' ",
               "    AND pmdt_t_pmdt007 = '",p_pmdt007,"' "
   END IF
   PREPARE asfr010_x01_pt FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   DECLARE asfr010_x01_cst CURSOR FOR asfr010_x01_pt
   FOREACH asfr010_x01_cst INTO l_pmdt020
      LET l_pmdt020 = l_pmdt020 * p_rate
      LET g_sum_pmt020 = g_sum_pmt020 + l_pmdt020
   END FOREACH
   
   RETURN g_sum_pmt020 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr010_x01_sum2_pmdt020(p_pmdt006,p_pmdt007,p_rate)
   DEFINE p_pmdt006           LIKE  pmdt_t.pmdt006
   DEFINE p_pmdt007           LIKE  pmdt_t.pmdt007
   DEFINE p_rate              LIKE  inaj_t.inaj014
   DEFINE l_sql               STRING
   DEFINE l_pmdt020           LIKE  pmdt_t.pmdt020
   DEFINE l_sr RECORD 
      pmdt_t_pmdt006 LIKE pmdt_t.pmdt006, 
      pmdt006_desc1 LIKE type_t.chr30, 
      pmdt006_desc2 LIKE type_t.chr30, 
      pmdt_t_pmdt007 LIKE pmdt_t.pmdt007, 
      pmdt_t_pmdt019 LIKE pmdt_t.pmdt019, 
      pmdt_t_pmdt020 LIKE pmdt_t.pmdt020, 
      sum_pmdt020 LIKE type_t.num20_6, 
      sfaadocno LIKE sfaa_t.sfaadocno, 
      sfaa010 LIKE sfaa_t.sfaa010, 
      sfaa010_desc1 LIKE type_t.chr30, 
      sfaa010_desc2 LIKE type_t.chr30, 
      sfaa019 LIKE sfaa_t.sfaa019, 
      imae081_desc LIKE type_t.chr200, 
      sfba013 LIKE sfba_t.sfba013, 
      sfba014 LIKE sfba_t.sfba014, 
      qty1 LIKE type_t.num20_6, 
      qty2 LIKE type_t.num20_6, 
      sfbaseq1 LIKE sfba_t.sfbaseq1,
      sfbaseq LIKE sfba_t.sfbaseq
   END RECORD
   DEFINE l_sfba015      LIKE sfba_t.sfba015
   DEFINE l_sfba016      LIKE sfba_t.sfba016
   
   LET g_sum_pmt020 = 0
   
   IF p_pmdt007 IS NULL THEN
      LET l_sql = " SELECT pmdt_t_pmdt006,pmdt006_desc1,pmdt006_desc2,pmdt_t_pmdt007,pmdt_t_pmdt019,",
                  "        pmdt_t_pmdt020,sum_pmdt020,sfaadocno,sfaa010,sfaa010_desc1,sfaa010_desc2,sfaa019,",
                  "        imae081_desc,sfba013,sfba014,qty1,qty2,sfbaseq1,sfbaseq ", 
                  "   FROM asfr010_1_tmp ",
                  "  WHERE pmdt_t_pmdt006 = '",p_pmdt006,"' ",
                  "    AND pmdt_t_pmdt007 IS NULL "
   ELSE
      LET l_sql = " SELECT pmdt_t_pmdt006,pmdt006_desc1,pmdt006_desc2,pmdt_t_pmdt007,pmdt_t_pmdt019,",
                  "        pmdt_t_pmdt020,sum_pmdt020,sfaadocno,sfaa010,sfaa010_desc1,sfaa010_desc2,sfaa019,",
                  "        imae081_desc,sfba013,sfba014,qty1,qty2,sfbaseq1,sfbaseq ", 
                  "  FROM asfr010_1_tmp ",
                  "  WHERE pmdt_t_pmdt006 = '",p_pmdt006,"' ",
                  "    AND pmdt_t_pmdt007 = '",p_pmdt007,"' "
   END IF
   PREPARE asfr010_x01_pt1 FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   DECLARE asfr010_x01_cst1 CURSOR FOR asfr010_x01_pt1
   FOREACH asfr010_x01_cst1 INTO l_sr.*
      SELECT sfba015,sfba016 INTO l_sfba015,l_sfba016 #sfba015:委外代买数量;sfba016:已发数量
       FROM sfba_t
      WHERE sfbaent = g_enterprise
        AND sfbadocno = l_sr.sfaadocno
        AND sfbaseq = l_sr.sfbaseq
        AND sfbaseq1 = l_sr.sfbaseq1
                  
      LET l_sr.qty1 = l_sr.sfba013 - l_sfba015 - l_sfba016
      
      IF  l_sr.qty1 > 0 THEN           
         LET l_pmdt020 = l_sr.pmdt_t_pmdt020 * p_rate
         LET g_sum_pmt020 = g_sum_pmt020 + l_pmdt020
      END IF
   END FOREACH

   RETURN g_sum_pmt020 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr010_x01_tem1()
   DEFINE l_sql             STRING
   
   DEFINE sr_tmp1 RECORD 
      pmdt_t_pmdt006 LIKE pmdt_t.pmdt006, 
      pmdt006_desc1 LIKE type_t.chr30, 
      pmdt006_desc2 LIKE type_t.chr30, 
      pmdt_t_pmdt007 LIKE pmdt_t.pmdt007, 
      pmdt_t_pmdt019 LIKE pmdt_t.pmdt019, 
      pmdt_t_pmdt020 LIKE pmdt_t.pmdt020, 
      sum_pmdt020 LIKE type_t.num20_6, 
      sfaadocno LIKE sfaa_t.sfaadocno, 
      sfaa010 LIKE sfaa_t.sfaa010, 
      sfaa010_desc1 LIKE type_t.chr30, 
      sfaa010_desc2 LIKE type_t.chr30, 
      sfaa019 LIKE sfaa_t.sfaa019, 
      imae081_desc LIKE type_t.chr200, 
      sfba013 LIKE sfba_t.sfba013, 
      sfba014 LIKE sfba_t.sfba014, 
      qty1 LIKE type_t.num20_6, 
      qty2 LIKE type_t.num20_6, 
      sfbaseq1 LIKE sfba_t.sfbaseq1, 
      sfbaseq LIKE sfba_t.sfbaseq
   END RECORD
   
   DROP TABLE asfr010_1_tmp1
   
   CREATE TEMP TABLE asfr010_1_tmp1(
      pmdt_t_pmdt006     LIKE pmdt_t.pmdt006, 
      pmdt006_desc1      LIKE type_t.chr30, 
      pmdt006_desc2      LIKE type_t.chr30, 
      pmdt_t_pmdt007     LIKE pmdt_t.pmdt007, 
      pmdt_t_pmdt019     LIKE pmdt_t.pmdt019, 
      pmdt_t_pmdt020     LIKE pmdt_t.pmdt020, 
      sum_pmdt020        LIKE type_t.num20_6, 
      sfaadocno          LIKE sfaa_t.sfaadocno, 
      sfaa010            LIKE sfaa_t.sfaa010, 
      sfaa010_desc1      LIKE type_t.chr30, 
      sfaa010_desc2      LIKE type_t.chr30, 
      sfaa019            LIKE sfaa_t.sfaa019, 
      imae081_desc       LIKE type_t.chr200, 
      sfba013            LIKE sfba_t.sfba013, 
      sfba014            LIKE sfba_t.sfba014, 
      qty1               LIKE type_t.num20_6, 
      qty2               LIKE type_t.num20_6, 
      sfbaseq1           LIKE sfba_t.sfbaseq1, 
      sfbaseq            LIKE sfba_t.sfbaseq
   )

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfr010_1_tmp1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   PREPARE asfr010_x01_pt_tmp1 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   DECLARE asfr010_x01_cst_tmp1 CURSOR FOR asfr010_x01_pt_tmp1
   #161109-00085#40-s
   #FOREACH asfr010_x01_cst_tmp1 INTO sr_tmp1.*
   FOREACH asfr010_x01_cst_tmp1 
   INTO sr_tmp1.pmdt_t_pmdt006,sr_tmp1.pmdt006_desc1,sr_tmp1.pmdt006_desc2,sr_tmp1.pmdt_t_pmdt007,sr_tmp1.pmdt_t_pmdt019,
        sr_tmp1.pmdt_t_pmdt020,sr_tmp1.sum_pmdt020,sr_tmp1.sfaadocno,sr_tmp1.sfaa010,sr_tmp1.sfaa010_desc1,
        sr_tmp1.sfaa010_desc2,sr_tmp1.sfaa019,sr_tmp1.imae081_desc,sr_tmp1.sfba013,sr_tmp1.sfba014,       
        sr_tmp1.qty1,sr_tmp1.qty2,sr_tmp1.sfbaseq1,sr_tmp1.sfbaseq 
   #161109-00085#40-e
      LET sr_tmp1.qty1 = 0
      LET sr_tmp1.qty2 = 0
      LET sr_tmp1.sum_pmdt020 = 0
      LET sr_tmp1.pmdt006_desc1 = ' '
      LET sr_tmp1.pmdt006_desc2 = ' ' 
      LET sr_tmp1.sfaa010_desc1 = ' '   
      LET sr_tmp1.sfaa010_desc2 = ' '     
      LET sr_tmp1.imae081_desc = ' '      
      
      #161109-00085#40-s
      #INSERT INTO asfr010_1_tmp1 VALUES (sr_tmp1.*)
      INSERT INTO asfr010_1_tmp1 (pmdt_t_pmdt006,pmdt006_desc1,pmdt006_desc2,pmdt_t_pmdt007,pmdt_t_pmdt019,
                                 pmdt_t_pmdt020,sum_pmdt020,sfaadocno,sfaa010,sfaa010_desc1,
                                 sfaa010_desc2,sfaa019,imae081_desc,sfba013,sfba014,       
                                 qty1,qty2,sfbaseq1,sfbaseq ) 
      VALUES (sr_tmp1.pmdt_t_pmdt006,sr_tmp1.pmdt006_desc1,sr_tmp1.pmdt006_desc2,sr_tmp1.pmdt_t_pmdt007,sr_tmp1.pmdt_t_pmdt019,
              sr_tmp1.pmdt_t_pmdt020,sr_tmp1.sum_pmdt020,sr_tmp1.sfaadocno,sr_tmp1.sfaa010,sr_tmp1.sfaa010_desc1,
              sr_tmp1.sfaa010_desc2,sr_tmp1.sfaa019,sr_tmp1.imae081_desc,sr_tmp1.sfba013,sr_tmp1.sfba014,       
              sr_tmp1.qty1,sr_tmp1.qty2,sr_tmp1.sfbaseq1,sr_tmp1.sfbaseq )
      #161109-00085#40-e 
      IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT asfr010_1_tmp1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   END FOREACH
END FUNCTION

 
{</section>}
 
