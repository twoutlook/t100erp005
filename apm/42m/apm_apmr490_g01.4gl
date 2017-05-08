#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr490_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2017-02-13 14:24:47), PR版次:0006(2017-02-13 15:30:15)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: apmr490_g01
#+ Description: ...
#+ Creator....: 05423(2015-04-09 10:37:17)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="apmr490_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160816-00001#8  2016/08/16  By 08734     抓取理由碼改CALL sub
#160905-00007#11  2016/09/05 By 01727     调整系统中无ENT的SQL条件增加ent
#161031-00011#3  2016/11/3   By08734      调整g_select
#161031-00025#13 2017/02/13  By xujing    处理备注sql
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
   pmea000 LIKE pmea_t.pmea000, 
   pmea001 LIKE pmea_t.pmea001, 
   pmea002 LIKE pmea_t.pmea002, 
   pmea003 LIKE pmea_t.pmea003, 
   pmea004 LIKE pmea_t.pmea004, 
   pmea005 LIKE pmea_t.pmea005, 
   pmea006 LIKE pmea_t.pmea006, 
   pmea007 LIKE pmea_t.pmea007, 
   pmea008 LIKE pmea_t.pmea008, 
   pmea009 LIKE pmea_t.pmea009, 
   pmea010 LIKE pmea_t.pmea010, 
   pmea011 LIKE pmea_t.pmea011, 
   pmea012 LIKE pmea_t.pmea012, 
   pmea014 LIKE pmea_t.pmea014, 
   pmea015 LIKE pmea_t.pmea015, 
   pmea016 LIKE pmea_t.pmea016, 
   pmea017 LIKE pmea_t.pmea017, 
   pmea018 LIKE pmea_t.pmea018, 
   pmea019 LIKE pmea_t.pmea019, 
   pmea020 LIKE pmea_t.pmea020, 
   pmea030 LIKE pmea_t.pmea030, 
   pmea900 LIKE pmea_t.pmea900, 
   pmea901 LIKE pmea_t.pmea901, 
   pmea902 LIKE pmea_t.pmea902, 
   pmea903 LIKE pmea_t.pmea903, 
   pmea904 LIKE pmea_t.pmea904, 
   pmeaacti LIKE pmea_t.pmeaacti, 
   pmeadocdt LIKE pmea_t.pmeadocdt, 
   pmeadocno LIKE pmea_t.pmeadocno, 
   pmeaent LIKE pmea_t.pmeaent, 
   pmeasite LIKE pmea_t.pmeasite, 
   pmeastus LIKE pmea_t.pmeastus, 
   pmeb001 LIKE pmeb_t.pmeb001, 
   pmeb002 LIKE pmeb_t.pmeb002, 
   pmeb003 LIKE pmeb_t.pmeb003, 
   pmeb004 LIKE pmeb_t.pmeb004, 
   pmeb005 LIKE pmeb_t.pmeb005, 
   pmeb006 LIKE pmeb_t.pmeb006, 
   pmeb007 LIKE pmeb_t.pmeb007, 
   pmeb008 LIKE pmeb_t.pmeb008, 
   pmeb009 LIKE pmeb_t.pmeb009, 
   pmeb010 LIKE pmeb_t.pmeb010, 
   pmeb011 LIKE pmeb_t.pmeb011, 
   pmeb012 LIKE pmeb_t.pmeb012, 
   pmeb013 LIKE pmeb_t.pmeb013, 
   pmeb014 LIKE pmeb_t.pmeb014, 
   pmeb017 LIKE pmeb_t.pmeb017, 
   pmeb018 LIKE pmeb_t.pmeb018, 
   pmeb019 LIKE pmeb_t.pmeb019, 
   pmeb020 LIKE pmeb_t.pmeb020, 
   pmeb021 LIKE pmeb_t.pmeb021, 
   pmeb022 LIKE pmeb_t.pmeb022, 
   pmeb023 LIKE pmeb_t.pmeb023, 
   pmeb024 LIKE pmeb_t.pmeb024, 
   pmeb030 LIKE pmeb_t.pmeb030, 
   pmeb901 LIKE pmeb_t.pmeb901, 
   pmeb902 LIKE pmeb_t.pmeb902, 
   pmeb903 LIKE pmeb_t.pmeb903, 
   pmebseq LIKE pmeb_t.pmebseq, 
   pmebsite LIKE pmeb_t.pmebsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t2_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_pmea004_pmaal004 LIKE type_t.chr100, 
   l_pmea003_ooefl003 LIKE type_t.chr1000, 
   l_pmea002_ooag011 LIKE type_t.chr300, 
   l_pmea903_desc LIKE oocql_t.oocql004, 
   l_pmea006_desc LIKE oocql_t.oocql004, 
   l_pmea011_desc LIKE oocql_t.oocql004, 
   l_pmea009_desc LIKE oocql_t.oocql004, 
   x_t2_imaal004 LIKE imaal_t.imaal004, 
   l_pmeb003_desc LIKE oocql_t.oocql004, 
   l_order LIKE type_t.chr100, 
   l_pmeb017 LIKE pmeb_t.pmeb017
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr LIKE type_t.chr2          #l_pr
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
TYPE sr3_r RECORD  #單頭變更前欄位#
   pmed002_1       LIKE pmed_t.pmed002,   #變更欄位第一排
   pmed002_1_desc  LIKE dzeb_t.dzeb003,   #欄位名稱
   pmed004_1       LIKE pmed_t.pmed004,   #變更前內容
   pmed002_2       LIKE pmed_t.pmed002,   #變更欄位第二排
   pmed002_2_desc  LIKE dzeb_t.dzeb003,   #欄位名稱
   pmed004_2       LIKE pmed_t.pmed004    #變更前內容
END RECORD

TYPE sr4_r RECORD   #單頭變更資訊   
   pmed002   LIKE pmed_t.pmed002,   #變更欄位
   pmed004   LIKE pmed_t.pmed004    #變更前內容
END RECORD

TYPE sr5_r RECORD  #單身變更欄位
   pmebseq         LIKE pmeb_t.pmebseq,
   pmeb002         LIKE pmeb_t.pmeb002,     #料件編號
   pmeb002_desc    LIKE imaal_t.imaal003,   #品名
   pmeb002_desc_2  LIKE imaal_t.imaal004,   #規格
   pmeb003         LIKE pmeb_t.pmeb003,     #產品特徵
   l_pmeb003_desc  LIKE oocql_t.oocql004,   #產品特徵說明
   pmeb009         LIKE pmeb_t.pmeb009,     #數量
   pmeb008         LIKE pmeb_t.pmeb008,     #單位
   pmeb010         LIKE pmeb_t.pmeb010,     #單價
   pmeb005         LIKE pmeb_t.pmeb005,     #供應商料號
   l_pmeb017       LIKE pmeb_t.pmeb017,     #金額
   pmeb018         LIKE pmeb_t.pmeb018,     #含稅金額
   pmeb017         LIKE pmeb_t.pmeb017,     #未稅金額
   pmeb903         LIKE pmeb_t.pmeb903,     #變更備註
   l_pmeb903_show  LIKE type_t.chr1,
   l_pmeb003_show  LIKE type_t.chr1,
   l_pmeb005_show  LIKE type_t.chr1
END RECORD

TYPE sr6_r RECORD   #累計量定價資料
   pmecdocno          LIKE pmec_t.pmecdocno,
   pmecseq            LIKE pmec_t.pmecseq,
   pmecseq1_chg       LIKE pmec_t.pmecseq1,   #項序
   pmec001_chg        LIKE pmec_t.pmec001,    #到達數量
   pmec002_chg        LIKE pmec_t.pmec002,    #單價
   pmec003_chg        LIKE pmec_t.pmec003,    #折扣率
   pmecseq1           LIKE pmec_t.pmecseq1,   #項序
   pmec001            LIKE pmec_t.pmec001,    #到達數量
   pmec002            LIKE pmec_t.pmec002,    #單價
   pmec003            LIKE pmec_t.pmec003,    #折扣率
   pmec_chg_show      LIKE type_t.chr1,       #是否變更
   pmec_show          LIKE type_t.chr1,       #是否使用累積量定價pmeb024
   pmecseq1_pmec001_show LIKE type_t.chr1,  
   pmecseq1_btl       LIKE type_t.num20_6,
   pmec001_btl        LIKE type_t.num20_6,
   pmec002_btl        LIKE type_t.num20_6,   
   pmec003_btl        LIKE type_t.num20_6
END RECORD

DEFINE g_cnt      LIKE type_t.num5
DEFINE g_sql_cnt  STRING
DEFINE sr4 DYNAMIC ARRAY OF sr4_r
DEFINE g_acc                LIKE gzcb_t.gzcb008           #變更理由碼

#end add-point
 
{</section>}
 
{<section id="apmr490_g01.main" readonly="Y" >}
PUBLIC FUNCTION apmr490_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.pr  l_pr
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
  # SELECT gzcb008 INTO g_acc  #160816-00001#8  2016/08/16  By 08734 Mark
  #  FROM gzcb_t
  # WHERE gzcb001 = '24'
  #   AND gzcb002 = 'apmt480'
  LET g_acc = s_fin_get_scc_value('24','apmt480','6')  #160816-00001#8  2016/08/16  By 08734 add
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "apmr490_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL apmr490_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL apmr490_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL apmr490_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr490_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr490_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
  # LET g_select = " SELECT pmea000,pmea001,pmea002,pmea003,pmea004,pmea005,pmea006,pmea007,pmea008,pmea009, 
  #     pmea010,pmea011,pmea012,pmea014,pmea015,pmea016,pmea017,pmea018,pmea019,pmea020,pmea030,pmea900, 
  #     pmea901,pmea902,pmea903,pmea904,pmeaacti,pmeadocdt,pmeadocno,pmeaent,pmeasite,pmeastus,pmeb001, 
  #     pmeb002,pmeb003,pmeb004,pmeb005,pmeb006,pmeb007,pmeb008,pmeb009,pmeb010,pmeb011,pmeb012,pmeb013, 
  #     pmeb014,pmeb017,pmeb018,pmeb019,pmeb020,pmeb021,pmeb022,pmeb023,pmeb024,pmeb030,pmeb901,pmeb902, 
  #     pmeb903,pmebseq,pmebsite,ooag_t.ooag011,ooefl_t.ooefl003,pmaal_t.pmaal004,ooail_t.ooail003,ooibl_t.ooibl004, 
  #     oocql_t.oocql004,x.t1_oocql004,x.t3_oocql004,x.imaal_t_imaal003,x.t2_imaal003,x.oocal_t_oocal003, 
  #     trim(pmea004)||'.'||trim(pmaal_t.pmaal004),trim(pmea003)||'.'||trim(ooefl_t.ooefl003),trim(pmea002)||'.'||trim(ooag_t.ooag011), 
  #     NULL,NULL,NULL,NULL,x.t2_imaal004,NULL,trim(pmeadocno)||trim(TO_CHAR(pmea900,'000')),NULL"
    #161031-00011#3  2016/11/3   By08734 add(S)
    LET g_select = " SELECT pmea000,pmea001,pmea002,pmea003,pmea004,pmea005,pmea006,pmea007,pmea008,pmea009, 
       pmea010,pmea011,pmea012,pmea014,pmea015,pmea016,pmea017,pmea018,pmea019,pmea020,pmea030,pmea900, 
       pmea901,pmea902,pmea903,pmea904,pmeaacti,pmeadocdt,pmeadocno,pmeaent,pmeasite,pmeastus,pmeb001, 
       pmeb002,pmeb003,pmeb004,pmeb005,pmeb006,pmeb007,pmeb008,pmeb009,pmeb010,pmeb011,pmeb012,pmeb013, 
       pmeb014,pmeb017,pmeb018,pmeb019,pmeb020,pmeb021,pmeb022,pmeb023,pmeb024,pmeb030,pmeb901,pmeb902, 
       pmeb903,pmebseq,pmebsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmea_t.pmea002 AND ooag_t.ooagent = pmea_t.pmeaent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmea_t.pmea003 AND ooefl_t.ooeflent = pmea_t.pmeaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmea_t.pmea004 AND pmaal_t.pmaalent = pmea_t.pmeaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmea_t.pmea005 AND ooail_t.ooailent = pmea_t.pmeaent AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmea_t.pmea009 AND ooibl_t.ooiblent = pmea_t.pmeaent AND ooibl_t.ooibl003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmea_t.pmea011 AND oocql_t.oocqlent = pmea_t.pmeaent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.t1_oocql004,x.t3_oocql004,x.imaal_t_imaal003,x.t2_imaal003,x.oocal_t_oocal003, 
       trim(pmea004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmea_t.pmea004 AND pmaal_t.pmaalent = pmea_t.pmeaent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(pmea003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmea_t.pmea003 AND ooefl_t.ooeflent = pmea_t.pmeaent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(pmea002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmea_t.pmea002 AND ooag_t.ooagent = pmea_t.pmeaent)), 
       NULL,NULL,NULL,NULL,x.t2_imaal004,NULL,trim(pmeadocno)||trim(TO_CHAR(pmea900,'000')),NULL" 
    #161031-00011#3  2016/11/3   By08734 add(E)               
#   #end add-point
#   LET g_select = " SELECT pmea000,pmea001,pmea002,pmea003,pmea004,pmea005,pmea006,pmea007,pmea008,pmea009, 
#       pmea010,pmea011,pmea012,pmea014,pmea015,pmea016,pmea017,pmea018,pmea019,pmea020,pmea030,pmea900, 
#       pmea901,pmea902,pmea903,pmea904,pmeaacti,pmeadocdt,pmeadocno,pmeaent,pmeasite,pmeastus,pmeb001, 
#       pmeb002,pmeb003,pmeb004,pmeb005,pmeb006,pmeb007,pmeb008,pmeb009,pmeb010,pmeb011,pmeb012,pmeb013, 
#       pmeb014,pmeb017,pmeb018,pmeb019,pmeb020,pmeb021,pmeb022,pmeb023,pmeb024,pmeb030,pmeb901,pmeb902, 
#       pmeb903,pmebseq,pmebsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmea_t.pmea002 AND ooag_t.ooagent = pmea_t.pmeaent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmea_t.pmea003 AND ooefl_t.ooeflent = pmea_t.pmeaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmea_t.pmea004 AND pmaal_t.pmaalent = pmea_t.pmeaent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmea_t.pmea005 AND ooail_t.ooailent = pmea_t.pmeaent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmea_t.pmea009 AND ooibl_t.ooiblent = pmea_t.pmeaent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmea_t.pmea011 AND oocql_t.oocqlent = pmea_t.pmeaent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),x.t1_oocql004,x.t3_oocql004,x.imaal_t_imaal003,x.t2_imaal003,x.oocal_t_oocal003, 
#       trim(pmea004)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmea_t.pmea004 AND pmaal_t.pmaalent = pmea_t.pmeaent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(pmea003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmea_t.pmea003 AND ooefl_t.ooeflent = pmea_t.pmeaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(pmea002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmea_t.pmea002 AND ooag_t.ooagent = pmea_t.pmeaent)), 
#       NULL,NULL,NULL,NULL,x.t2_imaal004,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM pmea_t LEFT OUTER JOIN ( SELECT pmeb_t.*,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '221' AND oocql_t.oocql002 = pmeb_t.pmeb006 AND oocql_t.oocqlent = pmeb_t.pmebent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t1_oocql004,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = pmeb_t.pmeb013 AND oocql_t.oocqlent = pmeb_t.pmebent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,") t3_oocql004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmeb_t.pmeb004 AND imaal_t.imaalent = pmeb_t.pmebent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmeb_t.pmeb002 AND imaal_t.imaalent = pmeb_t.pmebent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t2_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmeb_t.pmeb008 AND oocal_t.oocalent = pmeb_t.pmebent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmeb_t.pmeb002 AND imaal_t.imaalent = pmeb_t.pmebent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t2_imaal004 FROM pmeb_t ) x  ON pmea_t.pmeaent = x.pmebent AND pmea_t.pmeadocno  
        = x.pmebdocno AND pmea_t.pmea900 = x.pmeb900"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY pmeadocno,pmeb900,pmebseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmea_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr490_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE apmr490_g01_curs CURSOR FOR apmr490_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr490_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr490_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmea000 LIKE pmea_t.pmea000, 
   pmea001 LIKE pmea_t.pmea001, 
   pmea002 LIKE pmea_t.pmea002, 
   pmea003 LIKE pmea_t.pmea003, 
   pmea004 LIKE pmea_t.pmea004, 
   pmea005 LIKE pmea_t.pmea005, 
   pmea006 LIKE pmea_t.pmea006, 
   pmea007 LIKE pmea_t.pmea007, 
   pmea008 LIKE pmea_t.pmea008, 
   pmea009 LIKE pmea_t.pmea009, 
   pmea010 LIKE pmea_t.pmea010, 
   pmea011 LIKE pmea_t.pmea011, 
   pmea012 LIKE pmea_t.pmea012, 
   pmea014 LIKE pmea_t.pmea014, 
   pmea015 LIKE pmea_t.pmea015, 
   pmea016 LIKE pmea_t.pmea016, 
   pmea017 LIKE pmea_t.pmea017, 
   pmea018 LIKE pmea_t.pmea018, 
   pmea019 LIKE pmea_t.pmea019, 
   pmea020 LIKE pmea_t.pmea020, 
   pmea030 LIKE pmea_t.pmea030, 
   pmea900 LIKE pmea_t.pmea900, 
   pmea901 LIKE pmea_t.pmea901, 
   pmea902 LIKE pmea_t.pmea902, 
   pmea903 LIKE pmea_t.pmea903, 
   pmea904 LIKE pmea_t.pmea904, 
   pmeaacti LIKE pmea_t.pmeaacti, 
   pmeadocdt LIKE pmea_t.pmeadocdt, 
   pmeadocno LIKE pmea_t.pmeadocno, 
   pmeaent LIKE pmea_t.pmeaent, 
   pmeasite LIKE pmea_t.pmeasite, 
   pmeastus LIKE pmea_t.pmeastus, 
   pmeb001 LIKE pmeb_t.pmeb001, 
   pmeb002 LIKE pmeb_t.pmeb002, 
   pmeb003 LIKE pmeb_t.pmeb003, 
   pmeb004 LIKE pmeb_t.pmeb004, 
   pmeb005 LIKE pmeb_t.pmeb005, 
   pmeb006 LIKE pmeb_t.pmeb006, 
   pmeb007 LIKE pmeb_t.pmeb007, 
   pmeb008 LIKE pmeb_t.pmeb008, 
   pmeb009 LIKE pmeb_t.pmeb009, 
   pmeb010 LIKE pmeb_t.pmeb010, 
   pmeb011 LIKE pmeb_t.pmeb011, 
   pmeb012 LIKE pmeb_t.pmeb012, 
   pmeb013 LIKE pmeb_t.pmeb013, 
   pmeb014 LIKE pmeb_t.pmeb014, 
   pmeb017 LIKE pmeb_t.pmeb017, 
   pmeb018 LIKE pmeb_t.pmeb018, 
   pmeb019 LIKE pmeb_t.pmeb019, 
   pmeb020 LIKE pmeb_t.pmeb020, 
   pmeb021 LIKE pmeb_t.pmeb021, 
   pmeb022 LIKE pmeb_t.pmeb022, 
   pmeb023 LIKE pmeb_t.pmeb023, 
   pmeb024 LIKE pmeb_t.pmeb024, 
   pmeb030 LIKE pmeb_t.pmeb030, 
   pmeb901 LIKE pmeb_t.pmeb901, 
   pmeb902 LIKE pmeb_t.pmeb902, 
   pmeb903 LIKE pmeb_t.pmeb903, 
   pmebseq LIKE pmeb_t.pmebseq, 
   pmebsite LIKE pmeb_t.pmebsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_t1_oocql004 LIKE oocql_t.oocql004, 
   x_t3_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t2_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_pmea004_pmaal004 LIKE type_t.chr100, 
   l_pmea003_ooefl003 LIKE type_t.chr1000, 
   l_pmea002_ooag011 LIKE type_t.chr300, 
   l_pmea903_desc LIKE oocql_t.oocql004, 
   l_pmea006_desc LIKE oocql_t.oocql004, 
   l_pmea011_desc LIKE oocql_t.oocql004, 
   l_pmea009_desc LIKE oocql_t.oocql004, 
   x_t2_imaal004 LIKE imaal_t.imaal004, 
   l_pmeb003_desc LIKE oocql_t.oocql004, 
   l_order LIKE type_t.chr100, 
   l_pmeb017 LIKE pmeb_t.pmeb017
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooef019 LIKE ooef_t.ooef019 #稅區
DEFINE l_success  LIKE type_t.chr2
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH apmr490_g01_curs INTO sr_s.*
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
      
       #變更理由
       LET sr_s.l_pmea903_desc = ''
       SELECT oocql004 INTO sr_s.l_pmea903_desc
         FROM oocql_t
        WHERE oocql001 = g_acc
          AND oocql002 = sr_s.pmea903
          AND oocql003 = g_dlang 
          AND oocqlent = g_enterprise   #160905-00007#11  Add
       
       #交易條件:只顯示交易條件說明就好
       LET sr_s.l_pmea011_desc = sr_s.oocql_t_oocql004
       
       #供應商:顯示供應商編號與說明，說明跟在編號後面中間用.區隔
       IF cl_null(sr_s.pmea004) THEN
          LET sr_s.l_pmea004_pmaal004 = NULL
       END IF
       #付款條件:只顯示付款條件說明就好
       LET sr_s.l_pmea009_desc = sr_s.ooibl_t_ooibl004
       #稅別:1.只顯示稅別條件說明與對應的稅率，稅率值跟在說明後面
       #稅區
       LET l_ooef019 = ''
       SELECT ooef019 INTO l_ooef019
         FROM ooef_t
        WHERE ooefent = sr_s.pmeaent
          AND ooef001 = sr_s.pmeasite
          
       #稅別說明
       SELECT oodbl004 INTO sr_s.l_pmea006_desc
         FROM oodbl_t
        WHERE oodblent = sr_s.pmeaent
          AND oodbl001 = l_ooef019
          AND oodbl002 = sr_s.pmea006
          AND oodbl003 = g_dlang
        IF cl_null(sr_s.l_pmea006_desc) THEN
           LET sr_s.l_pmea006_desc = sr_s.pmea006
        END IF        
#       LET sr_s.l_pmea006_desc = sr_s.l_pmea006_desc,' ',sr_s.pmea007
      
       #採購人員
       IF cl_null(sr_s.pmea002) THEN
          LET sr_s.l_pmea002_ooag011 = NULL
       END IF
       #採購部門
       IF cl_null(sr_s.pmea002) THEN
          LET sr_s.l_pmea003_ooefl003 = NULL
       END IF

       #產品特征
       IF NOT cl_null(sr_s.pmeb003) THEN
          CALL s_feature_description(sr_s.pmeb002,sr_s.pmeb003) RETURNING l_success,sr_s.l_pmeb003_desc
          LET sr_s.l_pmeb003_desc = sr_s.pmeb003 CLIPPED,".",sr_s.l_pmeb003_desc CLIPPED
       ELSE 
          LET sr_s.l_pmeb003_desc = NULL
       END IF
       #金額：依據單頭的單價含稅否金額pmea008，若單價含稅則印含稅金額pmeb017,反之則印未稅金額pmeb018
       #單身金額是否含稅
       IF sr_s.pmea008 = 'Y' THEN 
          LET sr_s.l_pmeb017 = sr_s.pmeb018
       ELSE
          LET sr_s.l_pmeb017 = sr_s.pmeb017
       END IF       

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmea000 = sr_s.pmea000
       LET sr[l_cnt].pmea001 = sr_s.pmea001
       LET sr[l_cnt].pmea002 = sr_s.pmea002
       LET sr[l_cnt].pmea003 = sr_s.pmea003
       LET sr[l_cnt].pmea004 = sr_s.pmea004
       LET sr[l_cnt].pmea005 = sr_s.pmea005
       LET sr[l_cnt].pmea006 = sr_s.pmea006
       LET sr[l_cnt].pmea007 = sr_s.pmea007
       LET sr[l_cnt].pmea008 = sr_s.pmea008
       LET sr[l_cnt].pmea009 = sr_s.pmea009
       LET sr[l_cnt].pmea010 = sr_s.pmea010
       LET sr[l_cnt].pmea011 = sr_s.pmea011
       LET sr[l_cnt].pmea012 = sr_s.pmea012
       LET sr[l_cnt].pmea014 = sr_s.pmea014
       LET sr[l_cnt].pmea015 = sr_s.pmea015
       LET sr[l_cnt].pmea016 = sr_s.pmea016
       LET sr[l_cnt].pmea017 = sr_s.pmea017
       LET sr[l_cnt].pmea018 = sr_s.pmea018
       LET sr[l_cnt].pmea019 = sr_s.pmea019
       LET sr[l_cnt].pmea020 = sr_s.pmea020
       LET sr[l_cnt].pmea030 = sr_s.pmea030
       LET sr[l_cnt].pmea900 = sr_s.pmea900
       LET sr[l_cnt].pmea901 = sr_s.pmea901
       LET sr[l_cnt].pmea902 = sr_s.pmea902
       LET sr[l_cnt].pmea903 = sr_s.pmea903
       LET sr[l_cnt].pmea904 = sr_s.pmea904
       LET sr[l_cnt].pmeaacti = sr_s.pmeaacti
       LET sr[l_cnt].pmeadocdt = sr_s.pmeadocdt
       LET sr[l_cnt].pmeadocno = sr_s.pmeadocno
       LET sr[l_cnt].pmeaent = sr_s.pmeaent
       LET sr[l_cnt].pmeasite = sr_s.pmeasite
       LET sr[l_cnt].pmeastus = sr_s.pmeastus
       LET sr[l_cnt].pmeb001 = sr_s.pmeb001
       LET sr[l_cnt].pmeb002 = sr_s.pmeb002
       LET sr[l_cnt].pmeb003 = sr_s.pmeb003
       LET sr[l_cnt].pmeb004 = sr_s.pmeb004
       LET sr[l_cnt].pmeb005 = sr_s.pmeb005
       LET sr[l_cnt].pmeb006 = sr_s.pmeb006
       LET sr[l_cnt].pmeb007 = sr_s.pmeb007
       LET sr[l_cnt].pmeb008 = sr_s.pmeb008
       LET sr[l_cnt].pmeb009 = sr_s.pmeb009
       LET sr[l_cnt].pmeb010 = sr_s.pmeb010
       LET sr[l_cnt].pmeb011 = sr_s.pmeb011
       LET sr[l_cnt].pmeb012 = sr_s.pmeb012
       LET sr[l_cnt].pmeb013 = sr_s.pmeb013
       LET sr[l_cnt].pmeb014 = sr_s.pmeb014
       LET sr[l_cnt].pmeb017 = sr_s.pmeb017
       LET sr[l_cnt].pmeb018 = sr_s.pmeb018
       LET sr[l_cnt].pmeb019 = sr_s.pmeb019
       LET sr[l_cnt].pmeb020 = sr_s.pmeb020
       LET sr[l_cnt].pmeb021 = sr_s.pmeb021
       LET sr[l_cnt].pmeb022 = sr_s.pmeb022
       LET sr[l_cnt].pmeb023 = sr_s.pmeb023
       LET sr[l_cnt].pmeb024 = sr_s.pmeb024
       LET sr[l_cnt].pmeb030 = sr_s.pmeb030
       LET sr[l_cnt].pmeb901 = sr_s.pmeb901
       LET sr[l_cnt].pmeb902 = sr_s.pmeb902
       LET sr[l_cnt].pmeb903 = sr_s.pmeb903
       LET sr[l_cnt].pmebseq = sr_s.pmebseq
       LET sr[l_cnt].pmebsite = sr_s.pmebsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_t1_oocql004 = sr_s.x_t1_oocql004
       LET sr[l_cnt].x_t3_oocql004 = sr_s.x_t3_oocql004
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t2_imaal003 = sr_s.x_t2_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].l_pmea004_pmaal004 = sr_s.l_pmea004_pmaal004
       LET sr[l_cnt].l_pmea003_ooefl003 = sr_s.l_pmea003_ooefl003
       LET sr[l_cnt].l_pmea002_ooag011 = sr_s.l_pmea002_ooag011
       LET sr[l_cnt].l_pmea903_desc = sr_s.l_pmea903_desc
       LET sr[l_cnt].l_pmea006_desc = sr_s.l_pmea006_desc
       LET sr[l_cnt].l_pmea011_desc = sr_s.l_pmea011_desc
       LET sr[l_cnt].l_pmea009_desc = sr_s.l_pmea009_desc
       LET sr[l_cnt].x_t2_imaal004 = sr_s.x_t2_imaal004
       LET sr[l_cnt].l_pmeb003_desc = sr_s.l_pmeb003_desc
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].l_pmeb017 = sr_s.l_pmeb017
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr490_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr490_g01_rep_data()
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
          START REPORT apmr490_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT apmr490_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT apmr490_g01_rep
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
 
{<section id="apmr490_g01.rep" readonly="Y" >}
PRIVATE REPORT apmr490_g01_rep(sr1)
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
DEFINE sr3       sr3_r #單頭變更欄位
DEFINE sr5       sr5_r #單身變更欄位
DEFINE sr6       sr6_r #累計量定價資料

DEFINE l_pmea904_show  LIKE type_t.chr5   #單頭變更備註是否顯示
DEFINE l_pmeb003_show  LIKE type_t.chr5   #產品特征顯示否 
DEFINE l_pmeb005_show  LIKE type_t.chr5   #供應商編號顯示否
DEFINE l_subrep05_show LIKE type_t.chr5
DEFINE l_subrep06_show LIKE type_t.chr5
DEFINE l_subrep07_show LIKE type_t.chr5

DEFINE l_pmeb_show     LIKE type_t.chr5   #是否有變更（對應傳入參數tm.pr）
DEFINE l_pmeb_title_show LIKE type_t.chr5 #是否单身都无变更资料
DEFINE l_pmec_title_show LIKE type_t.chr5 #是否累计量单身都无变更资料
DEFINE l_ac            INTEGER
DEFINE l_i             INTEGER
DEFINE l_count         LIKE type_t.num5
DEFINE l_num           LIKE type_t.num5   #用来查看单身是否有资料
DEFINE l_pmec_count    LIKE type_t.num5

DEFINE l_pmeb017_sum   LIKE pmeb_t.pmeb017   #未稅金額總計
DEFINE l_pmeb019_sum   LIKE pmeb_t.pmeb019   #稅額總計
DEFINE l_pmeb018_sum   LIKE pmeb_t.pmeb018   #含稅金額總計
#底線寬度
DEFINE l_pmea004_btl   LIKE type_t.num20_6   #供應商
DEFINE l_pmea005_btl   LIKE type_t.num20_6   #幣別
DEFINE l_pmea006_btl   LIKE type_t.num20_6   #稅別
DEFINE l_pmea007_btl   LIKE type_t.num20_6   #稅率
DEFINE l_pmea011_btl   LIKE type_t.num20_6   #交易條件
DEFINE l_pmea009_btl   LIKE type_t.num20_6   #付款條件
DEFINE l_pmea002_btl   LIKE type_t.num20_6   #採購人員
DEFINE l_pmea003_btl   LIKE type_t.num20_6   #採購部門
DEFINE l_pmea014_btl   LIKE type_t.num20_6   #生效日期
DEFINE l_pmea015_btl   LIKE type_t.num20_6   #失效日期
#記錄是否值有變更
DEFINE l_pmea004       LIKE type_t.num20_6   #供應商
DEFINE l_pmea005       LIKE type_t.num20_6   #幣別
DEFINE l_pmea006       LIKE type_t.num20_6   #稅別
DEFINE l_pmea007       LIKE type_t.num20_6   #稅率
DEFINE l_pmea011       LIKE type_t.num20_6   #交易條件
DEFINE l_pmea009       LIKE type_t.num20_6   #付款條件
DEFINE l_pmea002       LIKE type_t.num20_6   #採購人員
DEFINE l_pmea003       LIKE type_t.num20_6   #採購部門
DEFINE l_pmea014       LIKE type_t.num20_6   #生效日期
DEFINE l_pmea015       LIKE type_t.num20_6   #失效日期
#底線寬度
DEFINE l_pmeb002_btl   LIKE type_t.num20_6   #料件編號
DEFINE l_pmeb003_btl   LIKE type_t.num20_6   #產品特征
DEFINE l_pmeb009_btl   LIKE type_t.num20_6   #數量
DEFINE l_pmeb008_btl   LIKE type_t.num20_6   #單位
DEFINE l_pmeb010_btl   LIKE type_t.num20_6   #單價
DEFINE l_pmeb017_btl   LIKE type_t.num20_6   #金額
DEFINE l_pmeb005_btl   LIKE type_t.num20_6   #供應商料號

DEFINE l_ooef019       LIKE ooef_t.ooef019   #稅區
DEFINE l_tmp           LIKE type_t.chr50
DEFINE l_success  LIKE type_t.chr2
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.pmebseq
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
        BEFORE GROUP OF sr1.l_order
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            CALL cl_gr_init_apr(sr1.pmeadocno)
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
 
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'pmeaent=' ,sr1.pmeaent,'{+}pmeadocno=' ,sr1.pmeadocno,'{+}pmea900=' ,sr1.pmea900         
            CALL cl_gr_init_apr(sr1.l_order)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           #取得所屬稅區
           SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site 
           #单身是否显示
           LET l_num = 0
           LET l_pmeb_title_show ='Y'
           IF tm.pr = 'Y' THEN        
              IF sr1.pmea008 = 'Y' THEN
                 SELECT COUNT(*) INTO l_num
                   FROM pmed_t 
                  WHERE pmedent    = sr1.pmeaent
                    AND pmeddocno  = sr1.pmeadocno
                    AND pmedseq1   = 0
                    AND pmed001    = sr1.pmea900
                    AND pmed002    IN ('pmdyseq','pmdy002','pmdy003','pmdy005','pmdy009','pmdy008','pmdy010','pmdy018')
                    AND pmed004 IS NOT NULL
              ELSE
                 SELECT COUNT(*) INTO l_num
                   FROM pmed_t 
                  WHERE pmedent    = sr1.pmeaent
                    AND pmeddocno  = sr1.pmeadocno
                    AND pmedseq1   = 0
                    AND pmed001    = sr1.pmea900
                    AND pmed002    IN ('pmdyseq','pmdy002','pmdy003','pmdy005','pmdy009','pmdy008','pmdy010','pmdy017')
                    AND pmed004 IS NOT NULL
              END IF
              IF l_num = 0 OR cl_null(l_num) THEN
                 LET l_pmeb_title_show ='N'
              END IF
           END IF
                
           #單頭變更子報表
           LET l_subrep05_show = "N"
           LET l_pmea004_btl = 0
           LET l_pmea005_btl = 0
           LET l_pmea006_btl = 0
           LET l_pmea007_btl = 0
           LET l_pmea011_btl = 0
           LET l_pmea009_btl = 0
           LET l_pmea002_btl = 0
           LET l_pmea003_btl = 0
           LET l_pmea014_btl = 0
           LET l_pmea015_btl = 0
           
           LET l_pmea004 = 0
           LET l_pmea005 = 0 
           LET l_pmea006 = 0 
           LET l_pmea007 = 0
           LET l_pmea011 = 0
           LET l_pmea009 = 0
           LET l_pmea002 = 0
           LET l_pmea003 = 0
           LET l_pmea014 = 0
           LET l_pmea015 = 0
           LET l_pmea904_show = 'Y'
           #單頭備註隱藏
           CALL apmr490_g01_show(sr1.pmea904,'','') RETURNING l_pmea904_show
           PRINTX l_pmea904_show
           
           START REPORT apmr490_g01_subrep05
              LET g_sql = "SELECT pmed002,pmed004 ",
                          "  FROM pmed_t ",
                          " WHERE pmeddocno  = '",sr1.pmeadocno CLIPPED,"'",
                          "   AND pmedent    = '",sr1.pmeaent   CLIPPED,"'",
                          "   AND pmedsite   = '",sr1.pmeasite  CLIPPED,"'",
                          "   AND pmed001    = '",sr1.pmea900   CLIPPED,"'",
                          "   AND pmed002 IN ('pmdxdocno','pmdx004','pmdx005','pmdx006','pmdx007','pmdx011','pmdx009','pmdx002','pmdx003','pmdx014','pmdx015')",
                          "   AND pmedseq    = 0 ",
                          "   AND pmedseq1   = 0 "
              LET l_ac = 1
              CALL sr4.clear()
              DECLARE apmr490_g01_repcur05 CURSOR FROM g_sql
              FOREACH apmr490_g01_repcur05 INTO sr4[l_ac].*
                 IF STATUS THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "apmr490_g01_repcur05:"
                    LET g_errparam.code   = SQLCA.sqlcode
                    LET g_errparam.popup  = FALSE
                    CALL cl_err()
                    EXIT FOREACH
                 END IF                                                                             
              LET l_ac = l_ac + 1
              END FOREACH
              LET l_ac = l_ac-1            #最後多加了一次
              LET l_i = 1                  #目前筆數              
              IF l_ac > 0 THEN
                 LET l_subrep05_show = "Y"
                 WHILE TRUE
                    INITIALIZE sr3.* TO NULL
                    LET sr3.pmed002_1 = sr4[l_i].pmed002
                    LET sr3.pmed004_1 = sr4[l_i].pmed004      
                    CASE                     
                      WHEN sr3.pmed002_1 = 'pmdx002' #採購人員
                         LET l_tmp = sr3.pmed004_1 
                         CALL s_desc_get_person_desc(sr3.pmed004_1) RETURNING sr3.pmed004_1 
                         LET sr3.pmed004_1 = l_tmp CLIPPED,'.',sr3.pmed004_1 CLIPPED
                      WHEN sr3.pmed002_1 = 'pmdx003' #採購部門 
                         LET l_tmp = sr3.pmed004_1 
                         CALL s_desc_get_department_desc(sr3.pmed004_1)RETURNING sr3.pmed004_1
                         LET sr3.pmed004_1 = l_tmp CLIPPED,'.',sr3.pmed004_1 CLIPPED
                      WHEN sr3.pmed002_1 = 'pmdx004' #供應商
                         LET l_tmp = sr3.pmed004_1 
                         CALL s_desc_get_trading_partner_abbr_desc(sr3.pmed004_1)RETURNING sr3.pmed004_1
                         LET sr3.pmed004_1 = l_tmp CLIPPED,'.',sr3.pmed004_1 CLIPPED
                      WHEN sr3.pmed002_1 = 'pmdx009' #付款條件
                         CALL s_desc_get_ooib002_desc(sr3.pmed004_1) RETURNING sr3.pmed004_1
                      WHEN sr3.pmed002_1 = 'pmdx011' #交易條件
                         CALL s_desc_get_acc_desc(238,sr3.pmed004_1) RETURNING sr3.pmed004_1  
                      WHEN sr3.pmed002_1 = 'pmdx006' #稅別
                         CALL s_desc_get_tax_desc(l_ooef019,sr3.pmed004_1) RETURNING l_tmp
                         IF NOT cl_null(l_tmp) THEN
                            LET sr3.pmed004_1 = l_tmp
                         END IF
                    END CASE
                    CALL apmr490_g01_pmed002_ref(sr3.pmed002_1) RETURNING sr3.pmed002_1_desc                                                                
                    IF (l_i + 1) <= l_ac THEN
                       LET sr3.pmed002_2 = sr4[l_i+1].pmed002
                       LET sr3.pmed004_2 = sr4[l_i+1].pmed004
                       CASE                     
                          WHEN sr3.pmed002_2 = 'pmdx002' #採購人員
                             LET l_tmp = sr3.pmed004_2 
                             CALL s_desc_get_person_desc(sr3.pmed004_2) RETURNING sr3.pmed004_2
                             LET sr3.pmed004_2 = l_tmp CLIPPED,'.',sr3.pmed004_2 CLIPPED
                          WHEN sr3.pmed002_2 = 'pmdx003' #採購部門 
                             LET l_tmp = sr3.pmed004_2 
                             CALL s_desc_get_department_desc(sr3.pmed004_2)RETURNING sr3.pmed004_2
                             LET sr3.pmed004_2 = l_tmp CLIPPED,'.',sr3.pmed004_2 CLIPPED
                          WHEN sr3.pmed002_2 = 'pmdx004' #供應商
                             LET l_tmp = sr3.pmed004_2 
                             CALL s_desc_get_trading_partner_abbr_desc(sr3.pmed004_2)RETURNING sr3.pmed004_2
                             LET sr3.pmed004_2 = l_tmp CLIPPED,'.',sr3.pmed004_2 CLIPPED
                          WHEN sr3.pmed002_2 = 'pmdx009' #付款條件
                             CALL s_desc_get_ooib002_desc(sr3.pmed004_2) RETURNING sr3.pmed004_2
                          WHEN sr3.pmed002_2 = 'pmdx011' #交易條件
                             CALL s_desc_get_acc_desc(238,sr3.pmed004_2) RETURNING sr3.pmed004_2
                          WHEN sr3.pmed002_2 = 'pmdx006' #稅別
                             CALL s_desc_get_tax_desc(l_ooef019,sr3.pmed004_2) RETURNING sr3.pmed004_2             
                       END CASE
                       CALL apmr490_g01_pmed002_ref(sr3.pmed002_2) RETURNING sr3.pmed002_2_desc  
                    END IF
                                       
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx004')RETURNING l_pmea004  #如果相等表示有變更
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx005')RETURNING l_pmea005
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx006')RETURNING l_pmea006
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx007')RETURNING l_pmea007
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx011')RETURNING l_pmea011
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx009')RETURNING l_pmea009
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmex002')RETURNING l_pmea002
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx003')RETURNING l_pmea003
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx014')RETURNING l_pmea014
                    CALL apmr490_g01_pmea_chg(sr3.pmed002_1,sr3.pmed002_2,'pmdx015')RETURNING l_pmea015 
 
                    IF l_pmea004 != 0 THEN LET l_pmea004_btl = 0.5 END IF
                    IF l_pmea005 != 0 THEN LET l_pmea005_btl = 0.5 END IF
                    IF l_pmea006 != 0 THEN LET l_pmea006_btl = 0.5 END IF
                    IF l_pmea007 != 0 THEN LET l_pmea007_btl = 0.5 END IF
                    IF l_pmea011 != 0 THEN LET l_pmea011_btl = 0.5 END IF
                    IF l_pmea009 != 0 THEN LET l_pmea009_btl = 0.5 END IF
                    IF l_pmea002 != 0 THEN LET l_pmea002_btl = 0.5 END IF
                    IF l_pmea003 != 0 THEN LET l_pmea003_btl = 0.5 END IF
                    IF l_pmea014 != 0 THEN LET l_pmea014_btl = 0.5 END IF
                    IF l_pmea015 != 0 THEN LET l_pmea015_btl = 0.5 END IF

                    OUTPUT TO REPORT apmr490_g01_subrep05(sr3.*)
                    LET l_i = l_i + 2
                    IF l_i > l_ac THEN
                       EXIT WHILE
                    END IF
                 END  WHILE
              END IF
           FINISH REPORT apmr490_g01_subrep05
           PRINTX l_subrep05_show
           PRINTX l_pmea004_btl
           PRINTX l_pmea005_btl
           PRINTX l_pmea006_btl
           PRINTX l_pmea007_btl
           PRINTX l_pmea011_btl
           PRINTX l_pmea009_btl
           PRINTX l_pmea002_btl
           PRINTX l_pmea003_btl
           PRINTX l_pmea014_btl
           PRINTX l_pmea015_btl
           PRINTX l_pmeb_title_show 
           LET l_pmeb017_sum = 0 #未稅金額
           LET l_pmeb019_sum = 0 #稅額
           LET l_pmeb018_sum = 0 #含稅金額
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '",    #161031-00025#13 mark
#                sr1.pmeaent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeadocno CLIPPED ,"'", " AND ooff003 = '",sr1.pmea900 CLIPPED,"' "   #161031-00025#13 mark
           #161031-00025#13 add(s)
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = ",    
                sr1.pmeaent CLIPPED, " AND  ooff003 = '", sr1.pmeadocno CLIPPED ,"'", " AND ooff004 = ",sr1.pmea900 CLIPPED  
           #161031-00025#13 add(e)
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.pmeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr490_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE apmr490_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT apmr490_g01_subrep01
           DECLARE apmr490_g01_repcur01 CURSOR FROM g_sql
           FOREACH apmr490_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr490_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT apmr490_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT apmr490_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.pmebseq
 
           #add-point:rep.b_group.pmebseq.before name="rep.b_group.pmebseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.pmebseq.after name="rep.b_group.pmebseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
#161031-00025#13 mark(s)
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                 sr1.pmeaent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeadocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmea900 CLIPPED ,"'", 
#                 "AND ooff004 = '", sr1.pmebseq CLIPPED ,"' "
#161031-00025#13 mark(e)
           #161031-00025#13 add(s)
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = ", 
                 sr1.pmeaent CLIPPED , " AND  ooff003 = '", sr1.pmeadocno CLIPPED ,"'", " AND  ooff004 = ", sr1.pmea900 CLIPPED ,
                 " AND ooff005 = ", sr1.pmebseq CLIPPED 
           #161031-00025#13 add(e)
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.pmeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.pmebseq CLIPPED ,""
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr490_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE apmr490_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT apmr490_g01_subrep02
           DECLARE apmr490_g01_repcur02 CURSOR FROM g_sql
           FOREACH apmr490_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr490_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT apmr490_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT apmr490_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"

          #單身產品特徵隱藏
          CALL apmr490_g01_show(sr1.pmeb003,'','') RETURNING l_pmeb003_show
          #單身供應商料號隱藏
          CALL apmr490_g01_show(sr1.pmeb005,'','') RETURNING l_pmeb005_show
                    
#          PRINTX l_pmea904_show
          PRINTX l_pmeb003_show
          PRINTX l_pmeb005_show
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          #單身子報表
          START REPORT apmr490_g01_subrep06 
             LET l_subrep06_show = l_pmeb_title_show 
             LET l_pmeb_show = l_pmeb_title_show 
             LET l_count = 0
             LET l_num = 0
             
             #項次
             CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdyseq') RETURNING sr5.pmebseq,l_cnt            
             IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                LET sr5.pmebseq = sr1.pmebseq 
             END IF  
             #料號                       
             CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy002') RETURNING sr5.pmeb002,l_cnt                             
             LET l_pmeb002_btl = 0.5             
             IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                LET l_pmeb002_btl = 0
                LET sr5.pmeb002 = sr1.pmeb002
                LET sr5.pmeb002_desc = sr1.x_t2_imaal003
                LET sr5.pmeb002_desc_2 = sr1.x_t2_imaal004
                LET l_count = l_count + 1
             ELSE
                CALL s_desc_get_item_desc(sr5.pmeb002)RETURNING sr5.pmeb002_desc,sr5.pmeb002_desc_2 
             END IF          
             #產品特徵
             CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy003') RETURNING sr5.pmeb003,l_cnt
             LET l_pmeb003_btl = 0.5  
             IF NOT cl_null(sr5.pmeb003) THEN
                CALL s_feature_description(sr5.pmeb002,sr5.pmeb003) RETURNING l_success,sr5.l_pmeb003_desc
                LET sr5.l_pmeb003_desc = sr5.pmeb003 CLIPPED,".",sr5.l_pmeb003_desc CLIPPED
             END IF
             IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                LET l_pmeb003_btl = 0
                LET sr5.pmeb003 = sr1.pmeb003 
                LET sr5.l_pmeb003_desc = sr1.l_pmeb003_desc
                LET l_count = l_count + 1
                CALL apmr490_g01_show(sr5.pmeb003,'','') RETURNING sr5.l_pmeb003_show  
             END IF
             #變更備註
             LET sr5.pmeb903 = sr1.pmeb903 
             INITIALIZE sr5.l_pmeb903_show TO NULL             
             IF cl_null(sr5.pmeb903) THEN
                LET sr5.l_pmeb903_show ='N'
             ELSE
                LET sr5.l_pmeb903_show ='Y'
             END IF
             
             #供應商料號
             CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy005') RETURNING sr5.pmeb005,l_cnt
             LET l_pmeb005_btl = 0.5
             LET sr5.l_pmeb005_show = 'Y'
             IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                LET l_pmeb005_btl = 0
                LET sr5.pmeb005 = sr1.pmeb005
                LET l_count = l_count + 1
             END IF
             IF cl_null(sr5.pmeb005) THEN
               LET sr5.l_pmeb005_show = 'N'
             END IF
             
             #數量
             CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy009') RETURNING sr5.pmeb009,l_cnt
             LET l_pmeb009_btl = 0.5
             IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                LET l_pmeb009_btl = 0
                LET sr5.pmeb009 = sr1.pmeb009
                LET l_count = l_count + 1
             END IF
             #單位
             CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy008') RETURNING sr5.pmeb008,l_cnt
             LET l_pmeb008_btl = 0.5
             IF l_cnt = 0 OR cl_null(l_cnt) THEN
                LET l_pmeb008_btl = 0             
                LET sr5.pmeb008 = sr1.pmeb008
                LET l_count = l_count + 1
             END IF
             #單價
             CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy010') RETURNING sr5.pmeb010,l_cnt
             LET l_pmeb010_btl = 0.5
             IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                LET l_pmeb010_btl = 0
                LET sr5.pmeb010 = sr1.pmeb010
                LET l_count = l_count + 1
             END IF
             #金額
             IF sr1.pmea008 = 'Y' THEN
                CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy018') RETURNING sr5.l_pmeb017,l_cnt
                LET l_pmeb017_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN
                   LET l_pmeb017_btl = 0                
                   LET sr5.l_pmeb017 = sr1.l_pmeb017
                   LET l_count = l_count + 1
                END IF
             ELSE
                CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdy017') RETURNING sr5.l_pmeb017,l_cnt
                LET l_pmeb017_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN
                   LET l_pmeb017_btl = 0                
                   LET sr5.l_pmeb017 = sr1.l_pmeb017
                   LET l_count = l_count + 1
                END IF
             END IF 
             
             IF l_count = 7 THEN
                LET l_subrep06_show ='N'
                IF tm.pr = 'Y' THEN
                   LET l_pmeb_show ='N'
                END IF
             END IF   
             IF l_pmeb_show = 'Y' THEN
                LET l_pmeb017_sum = l_pmeb017_sum + sr1.pmeb017 #未稅金額
                LET l_pmeb019_sum = l_pmeb019_sum + sr1.pmeb019 #稅額
                LET l_pmeb018_sum = l_pmeb018_sum + sr1.pmeb018 #含稅金額
             END IF
             
          OUTPUT TO REPORT apmr490_g01_subrep06(sr5.*)
          FINISH REPORT apmr490_g01_subrep06
          PRINTX l_subrep06_show
          PRINTX l_pmeb002_btl
          PRINTX l_pmeb003_btl
          PRINTX l_pmeb009_btl
          PRINTX l_pmeb008_btl
          PRINTX l_pmeb010_btl
          PRINTX l_pmeb017_btl
          PRINTX l_pmeb005_btl
          
          ##############################################################################################3
          #累計量定價資料
          START REPORT apmr490_g01_subrep07
             LET l_subrep07_show ='N'
             LET sr6.pmecseq1_pmec001_show ='N'
             LET sr6.pmecseq1_btl = 0
             LET sr6.pmec001_btl = 0              
             LET sr6.pmec002_btl = 0  
             LET sr6.pmec003_btl = 0  
             LET l_pmec_title_show = 'Y'                   
             IF tm.pr = 'Y' THEN
                LET l_num = 0
                SELECT COUNT(*) INTO l_num
                  FROM pmed_t 
                 WHERE pmedent    = sr1.pmeaent
                   AND pmeddocno  = sr1.pmeadocno
                   AND pmedseq    = sr1.pmebseq
                   AND pmedseq1   = 0
                   AND pmed001    = sr1.pmea900
                   AND pmed002    IN ('pmdzseq','pmdz001','pmdz002','pmdz003')
                   AND pmed004 IS NOT NULL
                IF cl_null(l_num) OR l_num = 0 THEN
                   LET l_pmec_title_show = 'N'
                END IF
             END IF
             
             LET g_sql = "SELECT pmecdocno,pmecseq,pmecseq1,pmec001,pmec002,pmec003 ",
                         "  FROM pmec_t ",
                         " WHERE pmecdocno = '",sr1.pmeadocno  CLIPPED,"'",
                         "   AND pmecent   = '",sr1.pmeaent    CLIPPED,"'",
                         "   AND pmec900   = '",sr1.pmea900    CLIPPED,"'",
                         "   AND pmecseq   = '",sr1.pmebseq    CLIPPED,"'",
                         "   ORDER BY pmecseq,pmecseq1 "
             LET g_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
             PREPARE apmr490_g01_subrep07_cnt_pre FROM g_sql_cnt
             
             LET g_cnt = 0
             EXECUTE apmr490_g01_subrep07_cnt_pre INTO g_cnt
             FREE apmr490_g01_subrep07_cnt_pre
             
             IF g_cnt >= 1 AND sr1.pmeb024 == 'Y' AND l_pmeb_title_show =='Y' AND l_pmec_title_show=="Y" THEN
                LET l_subrep07_show ='Y'
                
                DECLARE apmr490_g01_repcur08 CURSOR FROM g_sql
                FOREACH apmr490_g01_repcur08 INTO sr6.*
                   IF STATUS THEN INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = STATUS
                      LET g_errparam.extend = 'apmr490_g01_repcur03:'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      EXIT FOREACH
                   END IF                                                                                 
                   LET l_pmec_count  = 0                                                        
                   LET sr6.pmec_show='Y'                    
                   LET sr6.pmec_chg_show ='Y'  
                   IF g_cnt > 0 THEN
                      LET sr6.pmecseq1_pmec001_show ='Y'
                      #項序
                      CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdzseq1') RETURNING sr6.pmecseq1,l_cnt
                      LET sr6.pmecseq1_btl = 0.5
                      IF l_cnt = 0 THEN
                         LET sr6.pmecseq1_btl = 0                    
                         LET sr6.pmecseq1 = sr6.pmecseq1_chg
                         LET l_pmec_count = l_pmec_count + 1                       
                      END IF
                      #到達數量
                      CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdz001') RETURNING sr6.pmec001,l_cnt
                      LET sr6.pmec001_btl = 0.5
                      IF l_cnt = 0 THEN
                         LET sr6.pmec001_btl = 0                    
                         LET sr6.pmec001 = sr6.pmec001_chg
                         LET l_pmec_count = l_pmec_count + 1                       
                      END IF
                      #單價
                      CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdz002') RETURNING sr6.pmec002,l_cnt
                      LET sr6.pmec002_btl = 0.5
                      IF l_cnt = 0 THEN
                         LET sr6.pmec002_btl = 0                    
                         LET sr6.pmec002 = sr6.pmec002_chg
                         LET l_pmec_count = l_pmec_count + 1                       
                      END IF
                      #折扣率
                      CALL apmr490_g01_chg(sr1.pmeaent,sr1.pmeadocno,sr1.pmebseq,0,sr1.pmea900,'pmdz003') RETURNING sr6.pmec003,l_cnt
                      LET sr6.pmec003_btl = 0.5
                      IF l_cnt = 0 THEN
                         LET sr6.pmec003_btl = 0                    
                         LET sr6.pmec003 = sr6.pmec003_chg
                         LET l_pmec_count = l_pmec_count + 1                       
                      END IF
                   END IF         
                   IF g_cnt > 0 THEN
                      IF  l_pmec_count = 4 THEN
                         LET sr6.pmec_show ='N' #沒變更 直接取pmec資料 變更前隱藏
                         IF tm.pr ='Y' THEN
                            LET sr6.pmec_chg_show ='N' #只列印變更後資料 沒變更全部隱藏
                         END IF                       
                      END IF  
                   END IF
                   IF sr6.pmecseq1_pmec001_show  = 'N' AND sr1.pmeb024 = 'N' AND l_pmec_title_show=="N" THEN  
                      LET l_subrep07_show ='N'
                   END IF                    
                   OUTPUT TO REPORT apmr490_g01_subrep07(sr6.*)                    
                END FOREACH
             END IF
          FINISH REPORT apmr490_g01_subrep07
          
          PRINTX l_subrep07_show
          PRINTX l_pmeb_show
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
#161031-00025#13 mark(s)
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                 sr1.pmeaent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeadocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmea900 CLIPPED ,"'", 
#                 "AND ooff004 = '", sr1.pmebseq CLIPPED ,"' " 
#161031-00025#13 mark(e)
            #161031-00025#13 add(s)
            LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = ", 
                 sr1.pmeaent CLIPPED ," AND  ooff003 = '", sr1.pmeadocno CLIPPED ,"'", " AND  ooff004 = ", sr1.pmea900 CLIPPED ,
                 " AND ooff005 = ", sr1.pmebseq CLIPPED 
            #161031-00025#13 add(e)
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
#                sr1.pmeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
#                sr1.pmebseq CLIPPED ,""
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr490_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE apmr490_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT apmr490_g01_subrep03
           DECLARE apmr490_g01_repcur03 CURSOR FROM g_sql
           FOREACH apmr490_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr490_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT apmr490_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT apmr490_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
#161031-00025#13 mark(s)
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
#                 sr1.pmeaent CLIPPED ,"'", " AND  ooff002 = '", sr1.pmeadocno CLIPPED ,"'", " AND  ooff003 = '", sr1.pmea900 CLIPPED ,"'", 
#                 "AND ooff004 = '", sr1.pmebseq CLIPPED ,"' "  
#161031-00025#13 mark(e)
            #161031-00025#13 add(s)
            LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = ", 
                 sr1.pmeaent CLIPPED , " AND  ooff003 = '", sr1.pmeadocno CLIPPED ,"'", " AND  ooff004 = ", sr1.pmea900 CLIPPED 
  
            #161031-00025#13 add(e)
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.pmeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE apmr490_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE apmr490_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT apmr490_g01_subrep04
           DECLARE apmr490_g01_repcur04 CURSOR FROM g_sql
           FOREACH apmr490_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "apmr490_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT apmr490_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT apmr490_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
#           LET l_pmeb017_sum = GROUP SUM(sr1.pmeb017)#未稅金額
#           LET l_pmeb019_sum = GROUP SUM(sr1.pmeb019)#稅額
#           LET l_pmeb018_sum = GROUP SUM(sr1.pmeb018)#含稅金額
           
           PRINTX l_pmeb017_sum
           PRINTX l_pmeb019_sum
           PRINTX l_pmeb018_sum
             
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.pmebseq
 
           #add-point:rep.a_group.pmebseq.before name="rep.a_group.pmebseq.before"
 
           #end add-point:
 
 
           #add-point:rep.a_group.pmebseq.after name="rep.a_group.pmebseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="apmr490_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT apmr490_g01_subrep01(sr2)
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
PRIVATE REPORT apmr490_g01_subrep02(sr2)
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
PRIVATE REPORT apmr490_g01_subrep03(sr2)
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
PRIVATE REPORT apmr490_g01_subrep04(sr2)
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
 
{<section id="apmr490_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取欄位說明
# Memo...........:
# Usage..........: CALL apmr490_g01__pmed002_ref(l_pmed002)
#                  RETURNING r_pmed002_desc
# Input parameter: l_pmed002   欄位代號
# Return code....: r_pmed002_desc   欄位名稱
# Date & Author..: 日期2015-4-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr490_g01_pmed002_ref(p_pmed002)
DEFINE p_pmed002         LIKE pmed_t.pmed002
DEFINE r_pmed002_desc    LIKE dzeb_t.dzeb003
   
   SELECT dzebl003 INTO r_pmed002_desc
     FROM dzebl_t
    WHERE dzebl001 = p_pmed002
      AND dzebl002 = g_dlang
      
   RETURN r_pmed002_desc
END FUNCTION

################################################################################
# Descriptions...: 單頭變更底線
# Memo...........:
# Usage..........: CALL apmr490_g01_pmea_chg(p_pmed002,p_pmed002_1,p_pmed002_2)
#                  RETURNING 0/0.5
# Input parameter: p_pmed002      變更欄位
#                : p_pmed002_1    變更欄位
#                : p_pmed002_2    採購合約單欄位
# Return code....: 0/0.5
# Date & Author..: 日期2015-4-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr490_g01_pmea_chg(p_pmed002,p_pmed002_1,p_pmed002_2)
DEFINE p_pmed002   LIKE pmed_t.pmed002
DEFINE p_pmed002_1 LIKE pmed_t.pmed002
DEFINE p_pmed002_2 LIKE pmed_t.pmed002

 IF p_pmed002 = p_pmed002_2 OR p_pmed002_1 = p_pmed002_2 THEN
    RETURN 0.5
 ELSE
    RETURN 0
 END IF
 
END FUNCTION

################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: apmr490_g01_show(p_arg1,p_arg2,p_arg3)
#                  RETURNING r_show
# Date & Author..: 日期2015-4-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apmr490_g01_show(p_arg1,p_arg2,p_arg3)
   DEFINE p_arg1 LIKE type_t.chr1000
   DEFINE p_arg2 LIKE type_t.chr1000
   DEFINE p_arg3 LIKE type_t.chr1000
   DEFINE r_show LIKE type_t.chr1

     IF cl_null(p_arg1) AND cl_null(p_arg2) AND cl_null(p_arg3) THEN
        LET r_show = "N"
     ELSE
        LET r_show = "Y"
     END IF
     RETURN r_show
END FUNCTION

################################################################################
# Descriptions...: 抓取變更前資料
# Memo...........:
# Usage..........: CALLapmr490_g01_chg(p_pmedent,p_pmeddocno,p_pmedseq,p_pmedseq1,p_pmedseq2,p_pmea900,p_pmed002)
# Input parameter: p_pmedent    企業編號
#                  p_pmeddocno  單號
#                  p_pmedseq    項次
#                  p_pmedseq1   項序 
#                  p_pmed001    變更序
#                  p_pmed002    變更欄位
# Return code....: r_pmed004    變更前資料
#                  r_cnt        是否有變更過
# Date & Author..: 2015-4-10 By zhujing
################################################################################
PRIVATE FUNCTION apmr490_g01_chg(p_pmedent,p_pmeddocno,p_pmedseq,p_pmedseq1,p_pmed001,p_pmed002)
DEFINE r_pmed004   LIKE pmed_t.pmed004   #變更前欄位數值
DEFINE p_pmedent   LIKE pmed_t.pmedent   
DEFINE p_pmeddocno LIKE pmed_t.pmeddocno #單號
DEFINE p_pmedseq   LIKE pmed_t.pmedseq 
DEFINE p_pmedseq1  LIKE pmed_t.pmedseq1  
DEFINE p_pmed001   LIKE pmed_t.pmed001   #變更序
DEFINE p_pmed002   LIKE pmed_t.pmed002   #變更欄位名稱
DEFINE l_pmed005   LIKE pmed_t.pmed005
DEFINE r_cnt       LIKE type_t.num5

   LET r_pmed004  = ''
   LET r_cnt = 0
   
   SELECT COUNT(*) INTO r_cnt
     FROM pmed_t 
    WHERE pmedent    = p_pmedent
      AND pmeddocno  = p_pmeddocno
      AND pmedseq    = p_pmedseq
      AND pmedseq1   = p_pmedseq1
      AND pmed001    = p_pmed001 
      AND pmed002    = p_pmed002
      AND pmed004 IS NOT NULL
      
   IF r_cnt ! =0 THEN 
      SELECT pmed004 INTO r_pmed004 
        FROM pmed_t 
       WHERE pmedent    = p_pmedent
         AND pmeddocno  = p_pmeddocno
         AND pmedseq    = p_pmedseq
         AND pmedseq1   = p_pmedseq1
         AND pmed001    = p_pmed001
         AND pmed002    = p_pmed002
         AND pmed004 IS NOT NULL
   END IF

      RETURN r_pmed004,r_cnt
END FUNCTION

 
{</section>}
 
{<section id="apmr490_g01.other_report" readonly="Y" >}
#單頭變更資料
PRIVATE REPORT apmr490_g01_subrep05(sr3)
   DEFINE sr3 sr3_r  
     FORMAT
        ON EVERY ROW
           PRINTX g_grNumFmt.*         
           PRINTX sr3.*
END REPORT

#單身變更前資料
PRIVATE REPORT apmr490_g01_subrep06(sr5)
    DEFINE sr5 sr5_r 
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

#累計量定價資料
PRIVATE REPORT apmr490_g01_subrep07(sr6)
DEFINE sr6 sr6_r 
    ORDER EXTERNAL BY sr6.pmecdocno,sr6.pmecseq,sr6.pmecseq1
        
    FORMAT 
       FIRST PAGE HEADER 

       ON EVERY ROW
          PRINTX g_grNumFmt.*
          PRINTX sr6.*
END REPORT

 
{</section>}
 
