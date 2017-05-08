#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr350_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-08-31 09:30:03), PR版次:0002(2016-08-29 15:22:02)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: apsr350_g01
#+ Description: 採購預測表
#+ Creator....: 00593(2014-10-22 01:35:00)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr350_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   l_psia003_pmaal004 LIKE type_t.chr100, 
   psia002 LIKE psia_t.psia002, 
   psia005 LIKE psia_t.psia005, 
   l_group LIKE type_t.chr500, 
   psib006 LIKE psib_t.psib006, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   psib007 LIKE psib_t.psib007, 
   l_psib007_desc LIKE inam_t.inam002, 
   psib012 LIKE psib_t.psib012, 
   l_psib011_1 LIKE psib_t.psib011, 
   l_psib011_2 LIKE psib_t.psib011, 
   l_psib011_3 LIKE psib_t.psib011, 
   l_psib011_4 LIKE psib_t.psib011, 
   l_psib011_5 LIKE psib_t.psib011, 
   l_psib011_6 LIKE psib_t.psib011, 
   psib009 LIKE psib_t.psib009, 
   psib011 LIKE psib_t.psib011, 
   psia001 LIKE psia_t.psia001, 
   psia003 LIKE psia_t.psia003, 
   psia004 LIKE psia_t.psia004, 
   psiaent LIKE psia_t.psiaent, 
   psiasite LIKE psia_t.psiasite, 
   psiastus LIKE psia_t.psiastus, 
   psib008 LIKE psib_t.psib008, 
   psib010 LIKE psib_t.psib010, 
   psjal_t_psjal003 LIKE psjal_t.psjal003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   l_psia004_ooag011 LIKE type_t.chr300, 
   l_psib009_1 LIKE type_t.dat, 
   l_psib009_2 LIKE type_t.dat, 
   l_psib009_3 LIKE type_t.dat, 
   l_psib009_4 LIKE type_t.dat, 
   l_psib009_5 LIKE type_t.dat, 
   l_psib009_6 LIKE type_t.dat
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where condition
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr350_g01.main" readonly="Y" >}
PUBLIC FUNCTION apsr350_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apsr350_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apsr350_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apsr350_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apsr350_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr350_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr350_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET g_sql = "SELECT DISTINCT psib008,psib009 FROM psib_t",
               " WHERE psibent = ? AND psibsite= ?",
               "   AND psib001 = ? AND psib002 = ? AND psib003 = ?",
               "   AND psib004 = ? AND psib005 = ? AND psib009 > ?",
               " ORDER BY psib008,psib009"
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
   PREPARE apsr350_g01_p0 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare 0:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   DECLARE apsr350_g01_c0 CURSOR FOR apsr350_g01_p0

   LET g_sql = "SELECT psib011 FROM psib_t",
               " WHERE psibent = ? AND psibsite= ?",
               "   AND psib001 = ? AND psib002 = ? AND psib003 = ?",
               "   AND psib004 = ? AND psib005 = ? AND psib006 = ?",
               "   AND psib007 = ? AND psib008 = ? AND psib009 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
   PREPARE apsr350_g01_p1 FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare 1:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
   END IF
   DECLARE apsr350_g01_c1 CURSOR FOR apsr350_g01_p1
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT trim(psia003)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = psia_t.psia003 AND pmaal_t.pmaalent = psia_t.psiaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),psia002,psia005,NULL,psib006,x.imaal_t_imaal003,x.imaal_t_imaal004,psib007,NULL, 
       psib012,NULL,NULL,NULL,NULL,NULL,NULL,psib009,psib011,psia001,psia003,psia004,psiaent,psiasite, 
       psiastus,psib008,psib010,( SELECT psjal003 FROM psjal_t WHERE psjal_t.psjal001 = psia_t.psia001 AND psjal_t.psjalsite = psia_t.psiasite AND psjal_t.psjalent = psia_t.psiaent AND psjal_t.psjal002 = '" , 
       g_dlang,"'" ,"),( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = psia_t.psia004 AND ooag_t.ooagent = psia_t.psiaent), 
       x.oocal_t_oocal003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = psia_t.psia003 AND pmaal_t.pmaalent = psia_t.psiaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),trim(psia004)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = psia_t.psia004 AND ooag_t.ooagent = psia_t.psiaent)), 
       NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM psia_t LEFT OUTER JOIN ( SELECT psib_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = psib_t.psib006 AND imaal_t.imaalent = psib_t.psibent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = psib_t.psib006 AND imaal_t.imaalent = psib_t.psibent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = psib_t.psib012 AND oocal_t.oocalent = psib_t.psibent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003 FROM psib_t ) x  ON psia_t.psiaent = x.psibent AND psia_t.psiasite  
        = x.psibsite AND psia_t.psia001 = x.psib001 AND psia_t.psia002 = x.psib002 AND psia_t.psia003  
        = x.psib003 AND psia_t.psia004 = x.psib004 AND psia_t.psia005 = x.psib005"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY psia003,psia002,psia005,psib006,psib007,psib012,psib009"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psia_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apsr350_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apsr350_g01_curs CURSOR FOR apsr350_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr350_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr350_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_psia003_pmaal004 LIKE type_t.chr100, 
   psia002 LIKE psia_t.psia002, 
   psia005 LIKE psia_t.psia005, 
   l_group LIKE type_t.chr500, 
   psib006 LIKE psib_t.psib006, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   psib007 LIKE psib_t.psib007, 
   l_psib007_desc LIKE inam_t.inam002, 
   psib012 LIKE psib_t.psib012, 
   l_psib011_1 LIKE psib_t.psib011, 
   l_psib011_2 LIKE psib_t.psib011, 
   l_psib011_3 LIKE psib_t.psib011, 
   l_psib011_4 LIKE psib_t.psib011, 
   l_psib011_5 LIKE psib_t.psib011, 
   l_psib011_6 LIKE psib_t.psib011, 
   psib009 LIKE psib_t.psib009, 
   psib011 LIKE psib_t.psib011, 
   psia001 LIKE psia_t.psia001, 
   psia003 LIKE psia_t.psia003, 
   psia004 LIKE psia_t.psia004, 
   psiaent LIKE psia_t.psiaent, 
   psiasite LIKE psia_t.psiasite, 
   psiastus LIKE psia_t.psiastus, 
   psib008 LIKE psib_t.psib008, 
   psib010 LIKE psib_t.psib010, 
   psjal_t_psjal003 LIKE psjal_t.psjal003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   l_psia004_ooag011 LIKE type_t.chr300, 
   l_psib009_1 LIKE type_t.dat, 
   l_psib009_2 LIKE type_t.dat, 
   l_psib009_3 LIKE type_t.dat, 
   l_psib009_4 LIKE type_t.dat, 
   l_psib009_5 LIKE type_t.dat, 
   l_psib009_6 LIKE type_t.dat
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_psib008       LIKE psib_t.psib008
   DEFINE l_psib009       LIKE psib_t.psib009
   DEFINE l_psib011       LIKE psib_t.psib011
   DEFINE l_cnt0          INTEGER
   DEFINE l_group         LIKE type_t.num5
   DEFINE l_psiaent_o     LIKE psia_t.psiaent
   DEFINE l_psiasite_o    LIKE psia_t.psiasite
   DEFINE l_psia001_o     LIKE psia_t.psia001
   DEFINE l_psia002_o     LIKE psia_t.psia002
   DEFINE l_psia003_o     LIKE psia_t.psia003
   DEFINE l_psia004_o     LIKE psia_t.psia004
   DEFINE l_psia005_o     LIKE psia_t.psia005
   DEFINE l_psib006_o     LIKE psib_t.psib006
   DEFINE l_psib007_o     LIKE psib_t.psib007
   DEFINE l_psib012_o     LIKE psib_t.psib012
   DEFINE l_group_o       LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_psiaent_o  = ''
    LET l_psiasite_o = ''
    LET l_psia001_o  = ''
    LET l_psia002_o  = ''
    LET l_psia003_o  = ''
    LET l_psia004_o  = ''
    LET l_psia005_o  = ''
    LET l_psib006_o  = ''
    LET l_psib007_o  = ''
    LET l_psib012_o  = ''  
    LET l_group_o  = 1 
    LET l_psib009 = ''
    LET l_group = 1   #6個日期為1群,當psib009的日期超過6個時,以此變數控制跳頁顯示第2、3....群的日期資料    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apsr350_g01_curs INTO sr_s.*
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
       #跟前一筆一樣的直接跳下一筆
       #160819-00015#4-s-mod  拿掉l_group_o = l_group
       #IF NOT (cl_null(l_psiaent_o) AND cl_null(l_psiasite_o) AND cl_null(l_psia001_o) AND
       #        cl_null(l_psia002_o) AND cl_null(l_psia003_o)  AND cl_null(l_psia004_o)  AND
       #        cl_null(l_psia005_o) AND cl_null(l_psib006_o)  AND cl_null(l_psib007_o)) AND
       #       (l_psiaent_o = sr_s.psiaent AND l_psiasite_o= sr_s.psiasite AND
       #        l_psia001_o = sr_s.psia001 AND l_psia002_o = sr_s.psia002  AND
       #        l_psia003_o = sr_s.psia003 AND l_psia004_o = sr_s.psia004  AND 
       #        l_psia005_o = sr_s.psia005 AND l_psib006_o = sr_s.psib006  AND
       #        l_psib007_o = sr_s.psib007 AND l_group_o   = l_group) THEN  
       #   CONTINUE FOREACH
       #END IF
       IF NOT (cl_null(l_psiaent_o) AND cl_null(l_psiasite_o) AND cl_null(l_psia001_o) AND
               cl_null(l_psia002_o) AND cl_null(l_psia003_o)  AND cl_null(l_psia004_o)  AND
               cl_null(l_psia005_o) AND cl_null(l_psib006_o)  AND cl_null(l_psib007_o)) AND
              (l_psiaent_o = sr_s.psiaent AND l_psiasite_o= sr_s.psiasite AND
               l_psia001_o = sr_s.psia001 AND l_psia002_o = sr_s.psia002  AND
               l_psia003_o = sr_s.psia003 AND l_psia004_o = sr_s.psia004  AND 
               l_psia005_o = sr_s.psia005 AND l_psib006_o = sr_s.psib006  AND
               l_psib007_o = sr_s.psib007 ) THEN  
          CONTINUE FOREACH
       END IF
       #160819-00015#4-e-mod
       LET sr_s.l_group = sr_s.psia003||'-'||sr_s.psia002||'-'||sr_s.psia005||'-'||l_group  #160819-00015#4-add
       #產品特徵說明
       CALL s_feature_description(sr_s.psib006,sr_s.psib007)
            RETURNING l_success,sr_s.l_psib007_desc

       IF l_group = 1 AND NOT cl_null(sr_s.psib009) THEN
          LET l_psib009 = s_date_get_date(sr_s.psib009,0,-1)
       END IF

       #處理日期一~日期六、日期一數量~日期六數量
       LET l_cnt0 = 1       
       OPEN apsr350_g01_c0 USING sr_s.psiaent,sr_s.psiasite,sr_s.psia001,sr_s.psia002,
                                 sr_s.psia003,sr_s.psia004,sr_s.psia005,l_psib009
       FOREACH apsr350_g01_c0 INTO l_psib008,l_psib009
          #抓取數量
          OPEN apsr350_g01_c1 USING sr_s.psiaent,sr_s.psiasite,
                                    sr_s.psia001,sr_s.psia002,sr_s.psia003,sr_s.psia004,sr_s.psia005,
                                    sr_s.psib006,sr_s.psib007,l_psib008,l_psib009
          FETCH apsr350_g01_c1 INTO l_psib011
          IF cl_null(l_psib011) THEN LET l_psib011=0 END IF
          CASE l_cnt0
             WHEN 1   LET sr_s.l_psib009_1 = l_psib009
                      LET sr_s.l_psib011_1 = l_psib011
             WHEN 2   LET sr_s.l_psib009_2 = l_psib009
                      LET sr_s.l_psib011_2 = l_psib011
             WHEN 3   LET sr_s.l_psib009_3 = l_psib009
                      LET sr_s.l_psib011_3 = l_psib011
             WHEN 4   LET sr_s.l_psib009_4 = l_psib009
                      LET sr_s.l_psib011_4 = l_psib011
             WHEN 5   LET sr_s.l_psib009_5 = l_psib009
                      LET sr_s.l_psib011_5 = l_psib011
             WHEN 6   LET sr_s.l_psib009_6 = l_psib009
                      LET sr_s.l_psib011_6 = l_psib011
          END CASE
          IF l_cnt0 = 6 THEN
             LET l_group_o = l_group
             LET l_group = l_group + 1
             EXIT FOREACH
          END IF
          LET l_cnt0 = l_cnt0 + 1
       END FOREACH
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_psia003_pmaal004 = sr_s.l_psia003_pmaal004
       LET sr[l_cnt].psia002 = sr_s.psia002
       LET sr[l_cnt].psia005 = sr_s.psia005
       LET sr[l_cnt].l_group = sr_s.l_group
       LET sr[l_cnt].psib006 = sr_s.psib006
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].psib007 = sr_s.psib007
       LET sr[l_cnt].l_psib007_desc = sr_s.l_psib007_desc
       LET sr[l_cnt].psib012 = sr_s.psib012
       LET sr[l_cnt].l_psib011_1 = sr_s.l_psib011_1
       LET sr[l_cnt].l_psib011_2 = sr_s.l_psib011_2
       LET sr[l_cnt].l_psib011_3 = sr_s.l_psib011_3
       LET sr[l_cnt].l_psib011_4 = sr_s.l_psib011_4
       LET sr[l_cnt].l_psib011_5 = sr_s.l_psib011_5
       LET sr[l_cnt].l_psib011_6 = sr_s.l_psib011_6
       LET sr[l_cnt].psib009 = sr_s.psib009
       LET sr[l_cnt].psib011 = sr_s.psib011
       LET sr[l_cnt].psia001 = sr_s.psia001
       LET sr[l_cnt].psia003 = sr_s.psia003
       LET sr[l_cnt].psia004 = sr_s.psia004
       LET sr[l_cnt].psiaent = sr_s.psiaent
       LET sr[l_cnt].psiasite = sr_s.psiasite
       LET sr[l_cnt].psiastus = sr_s.psiastus
       LET sr[l_cnt].psib008 = sr_s.psib008
       LET sr[l_cnt].psib010 = sr_s.psib010
       LET sr[l_cnt].psjal_t_psjal003 = sr_s.psjal_t_psjal003
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].l_psia004_ooag011 = sr_s.l_psia004_ooag011
       LET sr[l_cnt].l_psib009_1 = sr_s.l_psib009_1
       LET sr[l_cnt].l_psib009_2 = sr_s.l_psib009_2
       LET sr[l_cnt].l_psib009_3 = sr_s.l_psib009_3
       LET sr[l_cnt].l_psib009_4 = sr_s.l_psib009_4
       LET sr[l_cnt].l_psib009_5 = sr_s.l_psib009_5
       LET sr[l_cnt].l_psib009_6 = sr_s.l_psib009_6
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       LET l_psiaent_o  = sr_s.psiaent
       LET l_psiasite_o = sr_s.psiasite
       LET l_psia001_o  = sr_s.psia001
       LET l_psia002_o  = sr_s.psia002
       LET l_psia003_o  = sr_s.psia003
       LET l_psia004_o  = sr_s.psia004
       LET l_psia005_o  = sr_s.psia005
       LET l_psib006_o  = sr_s.psib006
       LET l_psib007_o  = sr_s.psib007
       LET l_psib012_o  = sr_s.psib012
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsr350_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr350_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT apsr350_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apsr350_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apsr350_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="apsr350_g01.rep" readonly="Y" >}
PRIVATE REPORT apsr350_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_group
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_group
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            #160819-00015#4-s-add
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            CALL cl_gr_init_apr(sr1.psia003)
            #160819-00015#4-e-add
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_group
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"

            #160819-00015#4-e-add
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'psiaent=' ,sr1.psiaent,'{+}psiasite=' ,sr1.psiasite,'{+}psia001=' ,sr1.psia001,'{+}psia002=' ,sr1.psia002,'{+}psia003=' ,sr1.psia003,'{+}psia004=' ,sr1.psia004,'{+}psia005=' ,sr1.psia005         
            CALL cl_gr_init_apr(sr1.l_group)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_group.before name="rep.b_group.l_group.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           #160819-00015#4-s-add
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' AND ooff001='6' AND ooff012='2' ",
                       "    AND ooffent = '",sr1.psiaent CLIPPED ,"' AND ooff002 = '",sr1.psia003 CLIPPED ,"'",
                       "    AND ooff003 = '",sr1.psia002 CLIPPED ,"' AND ooff004 = '",sr1.psia005 CLIPPED ,"'"
           #160819-00015#4-e-add            
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.psiaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_group CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apsr350_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apsr350_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apsr350_g01_subrep01
           DECLARE apsr350_g01_repcur01 CURSOR FROM g_sql
           FOREACH apsr350_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apsr350_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apsr350_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apsr350_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_group.after name="rep.b_group.l_group.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           #160819-00015#4-s-add
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' AND ooff001='7' AND ooff012='2' ",
                       "    AND ooffent = '",sr1.psiaent CLIPPED ,"' AND ooff002 = '",sr1.psia003 CLIPPED ,"'",
                       "    AND ooff003 = '",sr1.psia002 CLIPPED ,"' AND ooff004 = '",sr1.psia005 CLIPPED ,"'"
           #160819-00015#4-e-add
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.psiaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_group CLIPPED ,"'"
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apsr350_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apsr350_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apsr350_g01_subrep02
           DECLARE apsr350_g01_repcur02 CURSOR FROM g_sql
           FOREACH apsr350_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apsr350_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apsr350_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apsr350_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.psiaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apsr350_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apsr350_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apsr350_g01_subrep03
           DECLARE apsr350_g01_repcur03 CURSOR FROM g_sql
           FOREACH apsr350_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apsr350_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apsr350_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apsr350_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_group
 
           #add-point:rep.a_group.l_group.before name="rep.a_group.l_group.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           #160819-00015#4-s-add
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' AND ooff001='6' AND ooff012='1' ",
                       "    AND ooffent = '",sr1.psiaent CLIPPED ,"' AND ooff002 = '",sr1.psia003 CLIPPED ,"'",
                       "    AND ooff003 = '",sr1.psia002 CLIPPED ,"' AND ooff004 = '",sr1.psia005 CLIPPED ,"'"
           #160819-00015#4-e-add
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.psiaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_group CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apsr350_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apsr350_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apsr350_g01_subrep04
           DECLARE apsr350_g01_repcur04 CURSOR FROM g_sql
           FOREACH apsr350_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apsr350_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apsr350_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apsr350_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_group.after name="rep.a_group.l_group.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apsr350_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apsr350_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apsr350_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apsr350_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apsr350_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="apsr350_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="apsr350_g01.other_report" readonly="Y" >}

 
{</section>}
 
