#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr008_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-12-27 09:29:47), PR版次:0008(2016-12-27 10:59:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: apsr008_x01
#+ Description: ...
#+ Creator....: 03079(2015-04-17 14:46:58)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr008_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160503-00030    by whitney  效能優化
#160718-00009#1  by dorislai psph038改成psph017
#160825-00041#1  2016/10/05  by dorislai   1.修改azzi300顯示名稱    2.增加顯示上階需求單號(psph011)
#                                          3.欠料量是否含在途量='Y'，加總psph016 = NP、NM、P、M 的psph026；='N'，加總psph016 = P、M 的psph026
#                                          4.依合併週期的選項，重新編排日期，並補上空缺的日期
#161214-00040#1  2016/12/27  by dorislai   1.料件需求日期是按所有料件的所有日期顯示(週跟月也是)，並依照行事曆來區分
#                                          2.修正#160825-00041#1，會產生一筆空資料的問題
#                                          3.新增需求料號產品特徵
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
       wc STRING,                  #where 
       day STRING,                  #合併週期 
       chk LIKE type_t.chr1          #欠料量
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para         LIKE type_t.num5
DEFINE g_id           LIKE type_t.num10
DEFINE g_psph009      LIKE psph_t.psph009 
DEFINE g_psph019      LIKE psph_t.psph019 
#161214-00040#1-s-add
DEFINE g_ooef008     LIKE ooef_t.ooef008
DEFINE g_ooef009     LIKE ooef_t.ooef009
#161214-00040#1-e-add
#end add-point
 
{</section>}
 
{<section id="apsr008_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr008_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where 
DEFINE  p_arg2 STRING                  #tm.day  合併週期 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.chk  欠料量
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.day = p_arg2
   LET tm.chk = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr008_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr008_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr008_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr008_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr008_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr008_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr008_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr008_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "psph009.psph_t.psph009,psph019.psph_t.psph019,psoq043.psoq_t.psoq043,l_psoq043_desc.imaal_t.imaal003,l_psoq043_desc2.imaal_t.imaal004,psoq044.psoq_t.psoq044,psoq006.psoq_t.psoq006,psph017.psph_t.psph017,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,l_psph026_1.psph_t.psph026,psph039.psph_t.psph039,l_psph026_2.psph_t.psph026,l_psph026_3.psph_t.psph026,l_imaf013.gzcbl_t.gzcbl004,psph011.psph_t.psph011,l_psph019.psph_t.psph019" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   DROP TABLE apsr008_psph_t;
   CREATE TEMP TABLE apsr008_psph_t(
      psph009          VARCHAR(40),          #需求單號  
      psph019          DATE,          #需求日期  
      psoq043          VARCHAR(40),          #需求料號   
      l_psoq043_desc   VARCHAR(255),        #品名   
      l_psoq043_desc2  VARCHAR(255),        #規格  
      psoq044          VARCHAR(256),          #產品特徵   
      psoq006          DECIMAL(20,6),          #需求數量  
      psph040          VARCHAR(40),          #下階料號  
      imaal003         VARCHAR(255),        #品名  
      imaal004         VARCHAR(255),        #規格  
      psph026_1        DECIMAL(20,6),          #需求數量  
      psph026_2        DECIMAL(20,6),          #欠料量  
      psph026_3        DECIMAL(20,6),          #在途量  
      l_imaf013        VARCHAR(500),        #補給策略的說明 
      l_psph019        DATE     #需求日期 
   )
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr008_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr008_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr008_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr008_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
#161214-00040#1-s-add
DEFINE l_sql         STRING
#161214-00040#1-e-add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #161214-00040#1-s-add
   LET g_ooef008 = ''
   LET g_ooef009 = ''
   SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #161214-00040#1-e-add
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #--161214-00040#1-s-mod  多加psph039、
#   #160825-00041#1-s-mod
##   #160718-00009#1-mod-(S)
####160503-00030 by whitney mark start
####   LET g_select = " SELECT a.psph009,e.psoq007,e.psoq043,b.imaal003,b.imaal004,e.psoq044,e.psoq006,a.psph038,c.imaal003,c.imaal004, 
####       a.psph026,0,0,NULL,a.psph019,a.psph016"
####160503-00030 by whitney mark end
###   #160503-00030 by whitney add start
###   LET g_select = " SELECT a.psph009,e.psoq007,e.psoq043,b.imaal003,b.imaal004, ",
###                  "        e.psoq044,e.psoq006,a.psph038,c.imaal003,c.imaal004, ",
###                  "        a.psph026, ",
###                  " CASE WHEN psph016 = 'NP' OR psph016 = 'NM' THEN a.psph026 ELSE 0 END, ",
###                  " CASE WHEN psph016 = 'M' OR psph016 = 'P' THEN a.psph026 ELSE 0 END, ",
###                  "        gzcbl004,a.psph019,a.psph016 "
###   #160503-00030 by whitney add end
##   LET g_select = " SELECT a.psph009,e.psoq007,e.psoq043,b.imaal003,b.imaal004, ",
##                  "        e.psoq044,e.psoq006,a.psph017,c.imaal003,c.imaal004, ",
##                  "        a.psph026, ",
##                  " CASE WHEN psph016 = 'NP' OR psph016 = 'NM' THEN a.psph026 ELSE 0 END, ",
##                  " CASE WHEN psph016 = 'M' OR psph016 = 'P' THEN a.psph026 ELSE 0 END, ",
##                  "        gzcbl004,a.psph019,a.psph016 "
##   #160718-00009#1-mod-(E)
#   LET g_select = " SELECT a.psph009,e.psoq007,e.psoq043,b.imaal003,b.imaal004, ",
#                  "        e.psoq044,e.psoq006,a.psph017,c.imaal003,c.imaal004, ",
#                  "        a.psph026, "
#   #欠料量是否含在途量
#   IF tm.chk = 'N' THEN
#      LET g_select = g_select CLIPPED," CASE WHEN psph016 = 'NP' OR psph016 = 'NM' THEN a.psph026 ELSE 0 END, "
#   ELSE
#      LET g_select = g_select CLIPPED," CASE WHEN psph016 = 'NP' OR psph016 = 'NM' OR psph016 = 'P' OR psph016 = 'M'THEN a.psph026 ELSE 0 END, "
#   END IF
#   LET g_select = g_select CLIPPED," CASE WHEN psph016 = 'M' OR psph016 = 'P' THEN a.psph026 ELSE 0 END, ",
#                                   " gzcbl004,a.psph016,a.psph011,"
#   
#   #依合併週期抓取psph019
#   CASE tm.day
#     WHEN '0' #天
#        LET g_select = g_select CLIPPED,"a.psph019 "
#     WHEN '1' #週
#        LET g_select = g_select CLIPPED,"to_char(add_months(next_day(a.psph019,2)-7,0),'yyyy/mm/dd') "
#     WHEN '3' #月
#        LET g_select = g_select CLIPPED,"to_char(add_months(last_day(a.psph019)+1,-1),'yyyy/mm/dd') "
#   END CASE
   LET g_select = " SELECT a.psph009,e.psoq007,e.psoq043,b.imaal003,b.imaal004, ",
                  "        e.psoq044,e.psoq006,a.psph017,c.imaal003,c.imaal004, ",
                  "        a.psph026,a.psph039,"
   #欠料量是否含在途量
   IF tm.chk = 'N' THEN
      LET g_select = g_select CLIPPED," CASE WHEN psph016 = 'NP' OR psph016 = 'NM' THEN a.psph026 ELSE 0 END, "
   ELSE
      LET g_select = g_select CLIPPED," CASE WHEN psph016 = 'NP' OR psph016 = 'NM' OR psph016 = 'P' OR psph016 = 'M'THEN a.psph026 ELSE 0 END, "
   END IF
   LET g_select = g_select CLIPPED," CASE WHEN psph016 = 'M' OR psph016 = 'P' THEN a.psph026 ELSE 0 END, ",
                                   " gzcbl004,a.psph016,a.psph011,"
   CASE tm.day
     WHEN '0' #天
        LET g_select = g_select CLIPPED,"a.psph019 "
     WHEN '1' #週
        LET g_select = g_select CLIPPED,"(SELECT MIN(oogc003) FROM oogc_t WHERE oogcent = '",g_enterprise,"' ",
                                        "   AND oogc001='",g_ooef008,"' AND oogc002='",g_ooef009,"' ",
                                        "   AND oogc015 = to_char(a.psph019,'yyyy') ",
                                        "   AND oogc008 =  (SELECT DISTINCT oogc008 FROM oogc_t",
                                        "                    WHERE oogcent = '",g_enterprise,"' AND oogc001 = '",g_ooef008,"' ",
                                        "                      AND oogc002 = '",g_ooef009,"'  AND oogc003 = a.psph019 ) )"
     WHEN '3' #月
        LET g_select = g_select CLIPPED,"(SELECT MIN(oogc003) FROM oogc_t WHERE oogcent = '",g_enterprise,"' ",
                                        "   AND oogc001='",g_ooef008,"' AND oogc002='",g_ooef009,"' ",
                                        "   AND oogc015 = to_char(a.psph019,'yyyy') ",
                                        "   AND oogc016 =  (SELECT DISTINCT oogc016 FROM oogc_t",
                                        "                    WHERE oogcent = '",g_enterprise,"' AND oogc001 = '",g_ooef008,"' ",
                                        "                      AND oogc002 = '",g_ooef009,"'  AND oogc003 = a.psph019 ) )"
   END CASE
   #--161214-00040#1-e-mod
   #160825-00041#1-e-mod
#   #end add-point
#   LET g_select = " SELECT psph009,psph019,psoq043,'','',psoq044,psoq006,psph017,imaal_t.imaal003,imaal_t.imaal004, 
#       0,psph039,0,0,NULL,psph016,psph011,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160718-00009#1-mod-(S)
#   #160503-00030 by whitney modify start
#   LET g_from = " FROM psph_t a LEFT OUTER JOIN (SELECT imafent,imaf001,imafsite,gzcbl004 FROM imaf_t LEFT OUTER JOIN gzcbl_t f ON gzcbl001='2022' AND gzcbl002=imaf013 AND gzcbl003='",g_dlang,"') ",
#                "               ON imafent = a.psphent AND imaf001=a.psph038  AND imafsite=a.psphsite ",
#                "               LEFT OUTER JOIN imaal_t c ON c.imaalent = a.psphent AND c.imaal001=a.psph038  AND c.imaal002='",g_dlang,"' ,",
#                "      (SELECT psphent,psphsite,psph001,MAX(psph002) AS psph002 FROM psph_t GROUP BY psphent,psphsite,psph001) d, ",
#                "      psoq_t e LEFT OUTER JOIN imaal_t b ON b.imaalent = e.psoqent AND b.imaal001=e.psoq043  AND b.imaal002='",g_dlang,"' "
#   #160503-00030 by whitney modify end
   LET g_from = " FROM psph_t a LEFT OUTER JOIN (SELECT imafent,imaf001,imafsite,gzcbl004 FROM imaf_t LEFT OUTER JOIN gzcbl_t f ON gzcbl001='2022' AND gzcbl002=imaf013 AND gzcbl003='",g_dlang,"') ",
                "               ON imafent = a.psphent AND imaf001=a.psph017  AND imafsite=a.psphsite ",
                "               LEFT OUTER JOIN imaal_t c ON c.imaalent = a.psphent AND c.imaal001=a.psph017  AND c.imaal002='",g_dlang,"' ,",
                "      (SELECT psphent,psphsite,psph001,MAX(psph002) AS psph002 FROM psph_t GROUP BY psphent,psphsite,psph001) d, ",
                "      psoq_t e LEFT OUTER JOIN imaal_t b ON b.imaalent = e.psoqent AND b.imaal001=e.psoq043  AND b.imaal002='",g_dlang,"' "
   #160718-00009#1-mod-(E)
#   #end add-point
#    LET g_from = " FROM psph_t,psoq_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc CLIPPED ," AND a.psphent = d.psphent AND a.psphsite = d.psphsite ",
                                           " AND a.psph001 = d.psph001 AND a.psph002 = d.psph002 ",
                                           " AND a.psphent = e.psoqent AND a.psphsite = e.psoqsite ",
                                           " AND a.psph001 = e.psoq001 AND a.psph002 = e.psoq002 ",
                                           " AND a.psph009 = e.psoq004 AND a.psph016 != '0' "
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psph_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
#   LET g_sql = "SELECT * ",
#               "  FROM apsr008_psph_t "
     
   LET g_sql = g_sql CLIPPED," ORDER BY a.psph017,a.psph019 " #160825-00041#1-add
   
   #161214-00040#1-s-add
   #取出最小日期、最大日期(不分料件)
   LET l_sql = "SELECT MIN(a.psph019),MAX(a.psph019) ",g_from,g_where
   PREPARE apsr008_x01_max_min_pre FROM l_sql
   #161214-00040#1-e-add
   #end add-point
   PREPARE apsr008_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr008_x01_curs CURSOR FOR apsr008_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr008_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr008_x01_ins_data()
DEFINE sr RECORD 
   psph009 LIKE psph_t.psph009, 
   psph019 LIKE psph_t.psph019, 
   psoq043 LIKE psoq_t.psoq043, 
   l_psoq043_desc LIKE imaal_t.imaal003, 
   l_psoq043_desc2 LIKE imaal_t.imaal004, 
   psoq044 LIKE psoq_t.psoq044, 
   psoq006 LIKE psoq_t.psoq006, 
   psph017 LIKE psph_t.psph017, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_psph026_1 LIKE psph_t.psph026, 
   psph039 LIKE psph_t.psph039, 
   l_psph026_2 LIKE psph_t.psph026, 
   l_psph026_3 LIKE psph_t.psph026, 
   l_imaf013 LIKE gzcbl_t.gzcbl004, 
   psph016 LIKE psph_t.psph016, 
   psph011 LIKE psph_t.psph011, 
   l_psph019 LIKE psph_t.psph019
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_imaf013      LIKE imaf_t.imaf013
#160825-00041#1-s-add
DEFINE l_min_date    LIKE psph_t.psph019
DEFINE l_i           LIKE type_t.num5
DEFINE l_date_diff   LIKE type_t.num10
DEFINE l_month       LIKE type_t.num10
DEFINE l_year        LIKE type_t.num10
DEFINE l_min_year    LIKE type_t.num5
DEFINE l_min_month   LIKE type_t.num10
DEFINE l_psph017_o   LIKE psph_t.psph017
#160825-00041#1-e-add
#161214-00040#1-s-add
DEFINE l_psph_o RECORD 
   psph009 LIKE psph_t.psph009, 
   psph019 LIKE psph_t.psph019, 
   psoq043 LIKE psoq_t.psoq043, 
   l_psoq043_desc LIKE imaal_t.imaal003, 
   l_psoq043_desc2 LIKE imaal_t.imaal004, 
   psoq044 LIKE psoq_t.psoq044, 
   psoq006 LIKE psoq_t.psoq006, 
   psph017 LIKE psph_t.psph017, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_psph026_1 LIKE psph_t.psph026, 
   psph039 LIKE psph_t.psph039, 
   l_psph026_2 LIKE psph_t.psph026, 
   l_psph026_3 LIKE psph_t.psph026, 
   l_imaf013 LIKE gzcbl_t.gzcbl004, 
   psph016 LIKE psph_t.psph016, 
   psph011 LIKE psph_t.psph011, 
   l_psph019 LIKE psph_t.psph019
 END RECORD
DEFINE l_j           LIKE type_t.num5
DEFINE l_date        LIKE type_t.dat
DEFINE l_diff        LIKE type_t.num10
DEFINE l_last_date   LIKE type_t.dat
DEFINE l_date1       LIKE type_t.dat  #最小日期
DEFINE l_date2       LIKE type_t.dat  #最大日期
DEFINE l_max_date    LIKE type_t.dat
DEFINE l_oogc003_1   LIKE oogc_t.oogc003
DEFINE l_oogc003_2   LIKE oogc_t.oogc003
DEFINE l_oogc016_1   LIKE oogc_t.oogc016
DEFINE l_oogc016_2   LIKE oogc_t.oogc016
#161214-00040#1-e-add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160825-00041#1-s-add
    LET l_psph017_o = ''
    #160825-00041#1-e-add
    #161214-00040#1-s-add
    LET l_last_date = ''
    LET l_date1 = ''
    LET l_date2 = ''
    #取出最小日期、最大日期(不分料件)
    EXECUTE apsr008_x01_max_min_pre INTO l_date1,l_date2
    CASE tm.day
     WHEN '0' #天

     WHEN '1' #週
        #取出當週的第一天(最小日期)
        SELECT MIN(oogc003) INTO l_date1
          FROM oogc_t WHERE oogcent = g_enterprise
           AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
           AND oogc015 = to_char(l_date1,'yyyy') 
           AND oogc008 =  (SELECT DISTINCT oogc008 FROM oogc_t
                            WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                              AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = l_date1 )
        #取出當週的第一天(最大日期)
        SELECT MIN(oogc003) INTO l_date2
         FROM oogc_t WHERE oogcent = g_enterprise
          AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
          AND oogc015 = to_char(l_date2,'yyyy') 
          AND oogc008 =  (SELECT DISTINCT oogc008 FROM oogc_t
                           WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                             AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = l_date2 )
     WHEN '3' #月
        #取出當月的第一天(最小日期)
        SELECT MIN(oogc003) INTO l_date1
          FROM oogc_t WHERE oogcent = g_enterprise
           AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
           AND oogc015 = to_char(l_date1,'yyyy') 
           AND oogc016 =  (SELECT DISTINCT oogc016 FROM oogc_t
                            WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                              AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = l_date1 )
        #取出當月的第一天(最大日期)
        SELECT MIN(oogc003) INTO l_date2
         FROM oogc_t WHERE oogcent = g_enterprise
          AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
          AND oogc015 = to_char(l_date2,'yyyy') 
          AND oogc016 =  (SELECT DISTINCT oogc016 FROM oogc_t
                           WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                             AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = l_date2 )
    END CASE
    INITIALIZE l_psph_o.* TO NULL
    #161214-00040#1-e-add
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr008_x01_curs INTO sr.*                               
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
#160503-00030 by whitney mark start
#       #取得補給策略碼 
#       SELECT imaf013 INTO l_imaf013 
#         FROM imaf_t 
#        WHERE imafent  = p_psphent 
#          AND imafsite = p_psphsite 
#          AND imaf001  = sr.psph038 #料號 
#          
#       #取得補給策略說明 
#       CALL s_desc_gzcbl004_desc('2022',l_imaf013) RETURNING sr.l_imaf013
#          
#       #LET l_ins_tmp.l_psph019 = l_psph[l_ac].psph019 
#       
##       #需求量 
##       LET sr.l_psph026_1 = sr.psph026
#       
#       #欠料量 
#       IF sr.psph016 = 'NP' OR sr.psph016 = 'NM' THEN
#          LET sr.l_psph026_2 = sr.l_psph026_1
#       END IF
#       
#       #在途量 
#       IF sr.psph016 = 'M' OR sr.psph016 = 'P' THEN
#          LET sr.l_psph026_3 = sr.l_psph026_1
#       END IF
#160503-00030 by whitney mark end
       
       #161214-00040#1-s-mod
       #160825-00041#1-s-add  補上空缺的日期
       #IF cl_null(l_psph017_o) OR l_psph017_o <> sr.psph017 THEN
       #   LET l_min_date = sr.l_psph019
       #   LET l_psph017_o = sr.psph017
       #END IF
       #IF sr.l_psph019 <> l_min_date THEN
       #   CASE tm.day
       #      WHEN '0' #天
       #         LET l_date_diff = sr.l_psph019 - l_min_date - 1
       #         IF l_date_diff > 0 THEN
       #            FOR l_i = 1 TO l_date_diff
       #                LET l_min_date = l_min_date + 1
       #                EXECUTE insert_prep USING '','','','','','','',sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,
       #                                          '0','0','0',sr.l_imaf013,'',l_min_date
       #            END FOR
       #         END IF
       #         LET l_min_date = l_min_date + 1
       #         
       #      WHEN '1' #週
       #         LET l_date_diff = ((sr.l_psph019 - l_min_date) / 7 ) - 1
       #         IF l_date_diff > 0 THEN
       #            FOR l_i = 1 TO l_date_diff
       #                LET l_min_date = l_min_date + 7
       #                EXECUTE insert_prep USING '','','','','','','',sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,
       #                                          '0','0','0',sr.l_imaf013,'',l_min_date
       #            END FOR
       #         END IF
       #         LET l_min_date = l_min_date + 7
       #         
       #      WHEN '3' #月
       #         LET l_year = YEAR(sr.l_psph019) - YEAR(l_min_date)
       #         LET l_min_year  = YEAR(l_min_date)
       #         LET l_min_month = MONTH(l_min_date) 
       #         #l_date_diff以月為單位
       #         IF l_year > 0 THEN
       #            LET l_year = l_year - 1
       #            LET l_date_diff = (12 * l_year) + (12-MONTH(l_min_date)) + MONTH(sr.l_psph019) - 1
       #         ELSE
       #            LET l_date_diff = MONTH(sr.l_psph019) - l_min_month - 1
       #         END IF
       #         IF l_date_diff > 0 THEN
       #            FOR l_i = 1 TO l_date_diff
       #                LET l_min_month = l_min_month + 1
       #                IF l_min_month > 12 THEN
       #                   LET l_min_year = l_min_year + 1
       #                   LET l_min_month = l_min_month - 12
       #                END IF
       #                LET l_min_date = MDY(l_min_month,1,l_min_year)
       #                EXECUTE insert_prep USING '','','','','','','',sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,
       #                                          '0','0','0',sr.l_imaf013,'',l_min_date
       #                                          
       #            END FOR
       #         END IF
       #         LET l_min_month = l_min_month + 1
       #         IF l_min_month > 12 THEN
       #            LET l_min_year = l_min_year + 1
       #            LET l_min_month = l_min_month - 12
       #         END IF
       #         LET l_min_date = MDY(l_min_month,1,l_min_year)
       #         
       #   END CASE
       #END IF
       ##160825-00041#1-e-add
       IF cl_null(l_psph017_o) THEN
          LET l_psph017_o = sr.psph017
       END IF
       #最大日期補日期
       LET l_max_date = l_date2
       IF l_psph017_o <> sr.psph017 AND l_last_date <> l_max_date THEN
          LET l_min_date = l_last_date
          LET l_date_diff = YEAR(l_max_date) - YEAR(l_min_date) + 1
          FOR l_j = 1 TO l_date_diff 
              CASE tm.day
                 WHEN '0' #天
                    LET l_diff = l_max_date - l_min_date
                    LET l_date = l_min_date
                    IF l_diff > 0 THEN
                       FOR l_i = 1 TO l_diff
                           LET l_date = l_date + 1
                           EXECUTE insert_prep USING sr.psph009,sr.psph019,sr.psoq043,sr.l_psoq043_desc,sr.l_psoq043_desc2,sr.psoq044,sr.psoq006,
                                                     sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,'',sr.psph039,'','',sr.l_imaf013,sr.psph011,l_date
                       END FOR
                    END IF
                    EXIT FOR
                    
                 WHEN '1' #週
                    LET l_oogc003_1 = ''
                    #不同年，取當年最大週別，當週第一天 EX:2016年，取到的最大週別是53，當週第一天為2016/12/25
                    IF YEAR(l_max_date) <> YEAR(l_min_date) THEN
                       SELECT MIN(oogc003) INTO l_oogc003_1
                         FROM oogc_t
                        WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                          AND oogc002 = g_ooef009  AND oogc015 = to_char(l_min_date,'yyyy')
                          AND oogc008 = (SELECT MAX(oogc008) FROM oogc_t
                                          WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                                            AND oogc002 = g_ooef009  AND oogc015 = to_char(l_min_date,'yyyy') )
                    ELSE
                       #同年，直接=psph019
                       LET l_oogc003_1 = l_max_date
                    END IF
                    LET l_date = l_oogc003_1  
                    WHILE TRUE
                       #最後一週的第一個日期<最小的日期
                       IF l_date < l_min_date THEN
                          EXIT WHILE
                       END IF
                       EXECUTE insert_prep USING sr.psph009,sr.psph019,sr.psoq043,sr.l_psoq043_desc,sr.l_psoq043_desc2,sr.psoq044,sr.psoq006,
                                                 sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,'',sr.psph039,'','',sr.l_imaf013,sr.psph011,l_date
                       LET l_date = l_date - 7
                    END WHILE 
                    #把最小日期，換成下一年年初的日期  EX: 2015/12/27，換成2016/1/1
                    LET l_min_date = MDY(1,1,YEAR(l_oogc003_1)+1)
                    
                 WHEN '3' #月
                    SELECT DISTINCT oogc016 INTO l_oogc016_1
                      FROM oogc_t
                     WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                       AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = l_min_date
                    IF YEAR(l_min_date) <> YEAR(l_psph_o.l_psph019) THEN
                       SELECT MAX(oogc016) INTO l_oogc016_2
                         FROM oogc_t WHERE oogcent = g_enterprise
                          AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
                          AND oogc015 = to_char(l_min_date,'yyyy') 
                    ELSE
                       SELECT DISTINCT oogc016 INTO l_oogc016_2
                         FROM oogc_t
                        WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                          AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = l_max_date
                    END IF
                    LET l_diff = l_oogc016_2 - l_oogc016_1
                    IF l_diff > 0 THEN
                       FOR l_i = 0 TO l_diff
                          SELECT MIN(oogc003) INTO l_date
                             FROM oogc_t WHERE oogcent = g_enterprise
                              AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
                              AND oogc015 = to_char(l_min_date,'yyyy') 
                              AND oogc016 = l_oogc016_2 - l_i
                          EXECUTE insert_prep USING sr.psph009,sr.psph019,sr.psoq043,sr.l_psoq043_desc,sr.l_psoq043_desc2,sr.psoq044,sr.psoq006,
                                                    sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,'',sr.psph039,'','',sr.l_imaf013,sr.psph011,l_date
                       END FOR
                       LET l_min_date = MDY(1,1,YEAR(l_min_date)+1)
                    END IF
             END CASE
          END FOR
          LET l_psph017_o = sr.psph017
       END IF
       
       #最小日期補日期
       LET l_min_date = l_date1
       IF sr.l_psph019 <> l_min_date THEN
          LET l_date_diff = YEAR(sr.l_psph019) - YEAR(l_min_date) + 1
          FOR l_j = 1 TO l_date_diff 
             CASE tm.day
                WHEN '0' #天
                   LET l_diff = sr.l_psph019 - l_min_date 
                   LET l_date = sr.l_psph019
                   IF l_diff > 0 THEN
                      FOR l_i = 1 TO l_diff
                          LET l_date = l_date - 1
                          EXECUTE insert_prep USING sr.psph009,sr.psph019,sr.psoq043,sr.l_psoq043_desc,sr.l_psoq043_desc2,sr.psoq044,sr.psoq006,
                                                    sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,'',sr.psph039,'','',sr.l_imaf013,sr.psph011,l_date
                      END FOR
                   END IF
                   EXIT FOR
                   
                WHEN '1' #週
                   LET l_oogc003_1 = ''
                   #不同年，取當年最大週別，當週第一天 EX:2016年，取到的最大週別是53，當週第一天為2016/12/25
                   IF YEAR(l_min_date) <> YEAR(sr.l_psph019) THEN
                      SELECT MIN(oogc003) INTO l_oogc003_1
                        FROM oogc_t
                       WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                         AND oogc002 = g_ooef009  AND oogc015 = to_char(l_min_date,'yyyy')
                         AND oogc008 = (SELECT MAX(oogc008) FROM oogc_t
                                         WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                                           AND oogc002 = g_ooef009  AND oogc015 = to_char(l_min_date,'yyyy') )
                   ELSE
                      #同年，直接=psph019
                      LET l_oogc003_1 = sr.l_psph019
                   END IF
                   LET l_date = l_oogc003_1  
                   WHILE TRUE
                      #最後一週的第一個日期<最小的日期
                      IF l_date < l_min_date THEN
                         EXIT WHILE
                      END IF
                      EXECUTE insert_prep USING sr.psph009,sr.psph019,sr.psoq043,sr.l_psoq043_desc,sr.l_psoq043_desc2,sr.psoq044,sr.psoq006,
                                                sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,'',sr.psph039,'','',sr.l_imaf013,sr.psph011,l_date
                      LET l_date = l_date - 7
                   END WHILE 
                   #把最小日期，換成下一年年初的日期  EX: 2015/12/27，換成2016/1/1
                   LET l_min_date = MDY(1,1,YEAR(l_oogc003_1)+1)
                   
                WHEN '3' #月
                   SELECT DISTINCT oogc016 INTO l_oogc016_1
                     FROM oogc_t
                    WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                      AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = l_min_date
                   IF YEAR(l_min_date) <> YEAR(sr.l_psph019) THEN
                      SELECT MAX(oogc016) INTO l_oogc016_2
                        FROM oogc_t WHERE oogcent = g_enterprise
                         AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
                         AND oogc015 = to_char(l_min_date,'yyyy') 
                   ELSE
                      SELECT DISTINCT oogc016 INTO l_oogc016_2
                        FROM oogc_t
                       WHERE oogcent = g_enterprise AND oogc001 = g_ooef008
                         AND oogc002 = g_ooef009  AND to_char(oogc003,'yyyy/mm/dd') = sr.l_psph019
                   END IF
                   LET l_diff = l_oogc016_2 - l_oogc016_1
                   IF l_diff > 0 THEN
                      FOR l_i = 0 TO l_diff
                         SELECT MIN(oogc003) INTO l_date
                            FROM oogc_t WHERE oogcent = g_enterprise
                             AND oogc001 = g_ooef008 AND oogc002 = g_ooef009
                             AND oogc015 = to_char(l_min_date,'yyyy') 
                             AND oogc016 = l_oogc016_2 - l_i
                         EXECUTE insert_prep USING sr.psph009,sr.psph019,sr.psoq043,sr.l_psoq043_desc,sr.l_psoq043_desc2,sr.psoq044,sr.psoq006,
                                                   sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,'',sr.psph039,'','',sr.l_imaf013,sr.psph011,l_date

                      END FOR
                      LET l_min_date = MDY(1,1,YEAR(l_min_date)+1)
                   END IF
             END CASE
          END FOR
       END IF
       LET l_psph_o.* = sr.*
       LET l_last_date = sr.l_psph019
       #161214-00040#1-e-mod

       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.psph009,sr.psph019,sr.psoq043,sr.l_psoq043_desc,sr.l_psoq043_desc2,sr.psoq044,sr.psoq006,sr.psph017,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.l_psph026_1,sr.psph039,sr.l_psph026_2,sr.l_psph026_3,sr.l_imaf013,sr.psph011,sr.l_psph019
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr008_x01_execute"
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
 
{<section id="apsr008_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr008_x01_rep_data()
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
 
{<section id="apsr008_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 將傳入的三個字串組合成一個字串
# Memo...........:
# Usage..........: CALL apsr008_x01_assemble(p_str1,p_str2,p_mid)
#                  RETURNING r_assemble
# Input parameter: p_str1       字串1
#                : p_str2       字串2
#                : p_mid        串聯符號
# Return code....: r_assemble   組合字串
# Date & Author..: 2015/04/18 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsr008_x01_assemble(p_str1,p_str2,p_mid)
   DEFINE p_str1     STRING
   DEFINE p_str2     STRING
   DEFINE r_assemble STRING
   DEFINE p_mid   LIKE type_t.chr1

   IF cl_null(p_str1) OR cl_null(p_str2) THEN
      LET r_assemble = p_str1 , p_mid , p_str2
   ELSE
      LET r_assemble = p_str1 || p_mid || p_str2
   END IF
   IF cl_null(p_str1) AND cl_null(p_str2) THEN
      INITIALIZE r_assemble TO NULL
   END IF

   RETURN r_assemble
END FUNCTION

 
{</section>}
 
