#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr410_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:14(2017-01-24 16:01:53), PR版次:0014(2017-02-06 12:08:42)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000101
#+ Filename...: axmr410_g01
#+ Description: ...
#+ Creator....: 05384(2014-06-25 10:23:29)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="axmr410_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160316-00004#1   2016/05/16 By shiun     報表中最後建議廠商欄位沒有資料，不應有點(.)
#161027-00036#1   2016/11/03 By Ann_Huang 修正axmr410_g01_01.4rp樣板(繁中、簡中)裡面的"製表日期與時間"、"頁次"標籤
#161031-00022#2   2016/01/16 By 08992     報表客戶名稱增加一次性交易對象判斷
#161031-00024#9   2017/01/24 By 06137     2.報表畫面增加"列印額外品名規格"選項
#                                         2-1.打勾時，依料件編號+單別參數"額外品名規格類型"，串到aimm221抓取資料
#                                         2-2.有抓到值時，原品名規格資料不印，改印額外品名規格資料，額外品名規格資料依行序+換行符號組成一個大字串放至品名中
#                                         2-3.沒抓到值，印原品名規格
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
   xmfd001 LIKE xmfd_t.xmfd001, 
   xmfd002 LIKE xmfd_t.xmfd002, 
   xmfd003 LIKE xmfd_t.xmfd003, 
   xmfd004 LIKE xmfd_t.xmfd004, 
   xmfd005 LIKE xmfd_t.xmfd005, 
   xmfd006 LIKE xmfd_t.xmfd006, 
   xmfd007 LIKE xmfd_t.xmfd007, 
   xmfd008 LIKE xmfd_t.xmfd008, 
   xmfd009 LIKE xmfd_t.xmfd009, 
   xmfd010 LIKE xmfd_t.xmfd010, 
   xmfd011 LIKE xmfd_t.xmfd011, 
   xmfd012 LIKE xmfd_t.xmfd012, 
   xmfd013 LIKE xmfd_t.xmfd013, 
   xmfd014 LIKE xmfd_t.xmfd014, 
   xmfd015 LIKE xmfd_t.xmfd015, 
   xmfd016 LIKE xmfd_t.xmfd016, 
   xmfd017 LIKE xmfd_t.xmfd017, 
   xmfd018 LIKE xmfd_t.xmfd018, 
   xmfd019 LIKE xmfd_t.xmfd019, 
   xmfd020 LIKE xmfd_t.xmfd020, 
   xmfd021 LIKE xmfd_t.xmfd021, 
   xmfd022 LIKE xmfd_t.xmfd022, 
   xmfd023 LIKE xmfd_t.xmfd023, 
   xmfd024 LIKE xmfd_t.xmfd024, 
   xmfd025 LIKE xmfd_t.xmfd025, 
   xmfd026 LIKE xmfd_t.xmfd026, 
   xmfd027 LIKE xmfd_t.xmfd027, 
   xmfd028 LIKE xmfd_t.xmfd028, 
   xmfd029 LIKE xmfd_t.xmfd029, 
   xmfddocdt LIKE xmfd_t.xmfddocdt, 
   xmfddocno LIKE xmfd_t.xmfddocno, 
   xmfdent LIKE xmfd_t.xmfdent, 
   xmfdsite LIKE xmfd_t.xmfdsite, 
   xmfdstus LIKE xmfd_t.xmfdstus, 
   xmff001 LIKE xmff_t.xmff001, 
   xmff002 LIKE xmff_t.xmff002, 
   xmff003 LIKE xmff_t.xmff003, 
   xmff004 LIKE xmff_t.xmff004, 
   xmff005 LIKE xmff_t.xmff005, 
   xmff006 LIKE xmff_t.xmff006, 
   xmff007 LIKE xmff_t.xmff007, 
   xmff008 LIKE xmff_t.xmff008, 
   xmff009 LIKE xmff_t.xmff009, 
   xmff010 LIKE xmff_t.xmff010, 
   xmff011 LIKE xmff_t.xmff011, 
   xmff012 LIKE xmff_t.xmff012, 
   xmff013 LIKE xmff_t.xmff013, 
   xmffseq LIKE xmff_t.xmffseq, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   pmaal_t_pmaal006 LIKE pmaal_t.pmaal006, 
   xmfal_t_xmfal003 LIKE xmfal_t.xmfal003, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   t2_oocql004 LIKE oocql_t.oocql004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   xmahl_t_xmahl003 LIKE xmahl_t.xmahl003, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_xmfd001_ooag011 LIKE type_t.chr300, 
   l_xmfd002_ooefl003 LIKE type_t.chr1000, 
   l_xmfd003_pmaal003 LIKE type_t.chr300, 
   l_xmfd009_xmfal003 LIKE type_t.chr1000, 
   l_xmff003_show LIKE type_t.chr30, 
   l_xmff008_sum LIKE type_t.num20_6, 
   l_xmff009_sum LIKE type_t.num20_6, 
   l_xmff010_sum LIKE type_t.num20_6, 
   l_xmfd012_desc LIKE type_t.chr1000, 
   l_xmfd029_show LIKE type_t.chr1, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmfd034 LIKE xmfd_t.xmfd034
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #列印額外品名
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
TYPE sr3_r RECORD
   xmfhdocno        LIKE xmfh_t.xmfhdocno,
   xmfhseq          LIKE xmfh_t.xmfhseq,
   xmfh001          LIKE xmfh_t.xmfh001,
   xmfh002          LIKE xmfh_t.xmfh002,
   xmfh003          LIKE xmfh_t.xmfh003,
   xmfh004          LIKE xmfh_t.xmfh004,
   xmfh005          LIKE xmfh_t.xmfh005, 
   xmfh006          LIKE xmfh_t.xmfh006,
   l_xmfh001_desc   LIKE imaal_t.imaal003,
   l_xmfh001_desc_2 LIKE imaal_t.imaal004,
   l_xmfh005_desc   LIKE type_t.chr1000,
   l_xmfh006_show   LIKE type_t.chr1
END RECORD
TYPE sr4_r RECORD
   xmfgdocno LIKE xmfg_t.xmfgdocno,
   xmfg001 LIKE xmfg_t.xmfg001,
   xmfg002 LIKE xmfg_t.xmfg002,
   xmfg003 LIKE xmfg_t.xmfg003,
   xmfg004 LIKE xmfg_t.xmfg004
END RECORD
#end add-point
 
{</section>}
 
{<section id="axmr410_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr410_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  列印額外品名
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axmr410_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr410_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr410_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr410_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr410_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr410_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
   #end add-point
   LET g_select = " SELECT xmfd001,xmfd002,xmfd003,xmfd004,xmfd005,xmfd006,xmfd007,xmfd008,xmfd009,xmfd010, 
       xmfd011,xmfd012,xmfd013,xmfd014,xmfd015,xmfd016,xmfd017,xmfd018,xmfd019,xmfd020,xmfd021,xmfd022, 
       xmfd023,xmfd024,xmfd025,xmfd026,xmfd027,xmfd028,xmfd029,xmfddocdt,xmfddocno,xmfdent,xmfdsite, 
       xmfdstus,xmff001,xmff002,xmff003,xmff004,xmff005,xmff006,xmff007,xmff008,xmff009,xmff010,xmff011, 
       xmff012,xmff013,xmffseq,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmfd_t.xmfd001 AND ooag_t.ooagent = xmfd_t.xmfdent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmfd_t.xmfd002 AND ooefl_t.ooeflent = xmfd_t.xmfdent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmfd_t.xmfd003 AND pmaal_t.pmaalent = xmfd_t.xmfdent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmfd_t.xmfd003 AND pmaal_t.pmaalent = xmfd_t.xmfdent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT xmfal003 FROM xmfal_t WHERE xmfal_t.xmfaldocno = xmfd_t.xmfd009 AND xmfal_t.xmfalent = xmfd_t.xmfdent AND xmfal_t.xmfal002 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = xmfd_t.xmfd019 AND oocql_t.oocqlent = xmfd_t.xmfdent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '275' AND oocql_t.oocql002 = xmfd_t.xmfd018 AND oocql_t.oocqlent = xmfd_t.xmfdent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmfd_t.xmfd015 AND oocql_t.oocqlent = xmfd_t.xmfdent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmfd_t.xmfd016 AND ooibl_t.ooiblent = xmfd_t.xmfdent AND ooibl_t.ooibl003 = '" , 
       g_dlang,"'" ,"),( SELECT xmahl003 FROM xmahl_t WHERE xmahl_t.xmahl001 = xmfd_t.xmfd017 AND xmahl_t.xmahlent = xmfd_t.xmfdent AND xmahl_t.xmahl002 = '" , 
       g_dlang,"'" ,"),( SELECT oofb011 FROM oofb_t WHERE oofb_t.oofb001 = xmfd_t.xmfd022 AND oofb_t.oofbent = xmfd_t.xmfdent), 
       x.imaal_t_imaal003,x.oocal_t_oocal003,trim(xmfd001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmfd_t.xmfd001 AND ooag_t.ooagent = xmfd_t.xmfdent)), 
       trim(xmfd002)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmfd_t.xmfd002 AND ooefl_t.ooeflent = xmfd_t.xmfdent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(xmfd003)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmfd_t.xmfd003 AND pmaal_t.pmaalent = xmfd_t.xmfdent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(xmfd009)||'.'||trim((SELECT xmfal003 FROM xmfal_t WHERE xmfal_t.xmfaldocno = xmfd_t.xmfd009 AND xmfal_t.xmfalent = xmfd_t.xmfdent AND xmfal_t.xmfal002 = '" , 
       g_dlang,"'" ,")),'','','','','','',x.imaal_t_imaal004,xmfd034"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160621-00003#6 160629 by lori add---(S)
   #t2.oocql004改t2.oojdl003
   LET g_select = " SELECT xmfd001,xmfd002,xmfd003,xmfd004,xmfd005,xmfd006,xmfd007,xmfd008,xmfd009,xmfd010, 
       xmfd011,xmfd012,xmfd013,xmfd014,xmfd015,xmfd016,xmfd017,xmfd018,xmfd019,xmfd020,xmfd021,xmfd022, 
       xmfd023,xmfd024,xmfd025,xmfd026,xmfd027,xmfd028,xmfd029,xmfddocdt,xmfddocno,xmfdent,xmfdsite, 
       xmfdstus,xmff001,xmff002,xmff003,xmff004,xmff005,xmff006,xmff007,xmff008,xmff009,xmff010,xmff011, 
       xmff012,xmff013,xmffseq,ooag_t.ooag011,ooefl_t.ooefl003,pmaal_t.pmaal003,pmaal_t.pmaal006,xmfal_t.xmfal003, 
       t1.oocql004,t2.oojdl003,oocql_t.oocql004,ooibl_t.ooibl004,xmahl_t.xmahl003,oofb_t.oofb011,x.imaal_t_imaal003, 
       x.oocal_t_oocal003,trim(xmfd001)||'.'||trim(ooag_t.ooag011),trim(xmfd002)||'.'||trim(ooefl_t.ooefl003), 
       trim(xmfd003)||'.'||trim(pmaal_t.pmaal003),trim(xmfd009)||'.'||trim(xmfal_t.xmfal003),'','','', 
       '','','',x.imaal_t_imaal004"
      ,",xmfd034"   #161031-00022#2 add    
   #160621-00003#6 160629 by lori add---(E)
   #end add-point
    LET g_from = " FROM xmfd_t LEFT OUTER JOIN ( SELECT xmff_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmff_t.xmff001 AND imaal_t.imaalent = xmff_t.xmffent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmff_t.xmff004 AND oocal_t.oocalent = xmff_t.xmffent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = xmff_t.xmff001 AND imaal_t.imaalent = xmff_t.xmffent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004 FROM xmff_t ) x  ON xmfd_t.xmfdent = x.xmffent AND xmfd_t.xmfddocno  
        = x.xmffdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   #160621-00003#6 160629 by lori add---(S)
   #mod:xmfd018=oojdl001
    LET g_from = " FROM xmfd_t LEFT OUTER JOIN xmfal_t ON xmfal_t.xmfaldocno = xmfd_t.xmfd009 AND xmfal_t.xmfalent = xmfd_t.xmfdent AND xmfal_t.xmfal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmfd_t.xmfd015 AND oocql_t.oocqlent = xmfd_t.xmfdent AND oocql_t.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t1 ON t1.oocql001 = '263' AND t1.oocql002 = xmfd_t.xmfd019 AND t1.oocqlent = xmfd_t.xmfdent AND t1.oocql003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = xmfd_t.xmfd001 AND ooag_t.ooagent = xmfd_t.xmfdent             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = xmfd_t.xmfd002 AND ooefl_t.ooeflent = xmfd_t.xmfdent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = xmfd_t.xmfd003 AND pmaal_t.pmaalent = xmfd_t.xmfdent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oofb_t ON oofb_t.oofb001 = xmfd_t.xmfd022 AND oofb_t.oofbent = xmfd_t.xmfdent             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = xmfd_t.xmfd016 AND ooibl_t.ooiblent = xmfd_t.xmfdent AND ooibl_t.ooibl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN xmahl_t ON xmahl_t.xmahl001 = xmfd_t.xmfd017 AND xmahl_t.xmahlent = xmfd_t.xmfdent AND xmahl_t.xmahl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oojdl_t t2 ON t2.oojdl001 = xmfd_t.xmfd018 AND t2.oojdlent = xmfd_t.xmfdent AND t2.oojdl002 = '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT xmff_t.*,imaal_t.imaal003 imaal_t_imaal003,oocal_t.oocal003 oocal_t_oocal003, 
        imaal_t.imaal004 imaal_t_imaal004 FROM xmff_t             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xmff_t.xmff004 AND oocal_t.oocalent = xmff_t.xmffent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xmff_t.xmff001 AND imaal_t.imaalent = xmff_t.xmffent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ," ) x  ON xmfd_t.xmfdent = x.xmffent AND xmfd_t.xmfddocno = x.xmffdocno"   
   #160621-00003#6 160629 by lori add---(E)
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xmfddocno,xmffseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmfd_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr410_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr410_g01_curs CURSOR FOR axmr410_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr410_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr410_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmfd001 LIKE xmfd_t.xmfd001, 
   xmfd002 LIKE xmfd_t.xmfd002, 
   xmfd003 LIKE xmfd_t.xmfd003, 
   xmfd004 LIKE xmfd_t.xmfd004, 
   xmfd005 LIKE xmfd_t.xmfd005, 
   xmfd006 LIKE xmfd_t.xmfd006, 
   xmfd007 LIKE xmfd_t.xmfd007, 
   xmfd008 LIKE xmfd_t.xmfd008, 
   xmfd009 LIKE xmfd_t.xmfd009, 
   xmfd010 LIKE xmfd_t.xmfd010, 
   xmfd011 LIKE xmfd_t.xmfd011, 
   xmfd012 LIKE xmfd_t.xmfd012, 
   xmfd013 LIKE xmfd_t.xmfd013, 
   xmfd014 LIKE xmfd_t.xmfd014, 
   xmfd015 LIKE xmfd_t.xmfd015, 
   xmfd016 LIKE xmfd_t.xmfd016, 
   xmfd017 LIKE xmfd_t.xmfd017, 
   xmfd018 LIKE xmfd_t.xmfd018, 
   xmfd019 LIKE xmfd_t.xmfd019, 
   xmfd020 LIKE xmfd_t.xmfd020, 
   xmfd021 LIKE xmfd_t.xmfd021, 
   xmfd022 LIKE xmfd_t.xmfd022, 
   xmfd023 LIKE xmfd_t.xmfd023, 
   xmfd024 LIKE xmfd_t.xmfd024, 
   xmfd025 LIKE xmfd_t.xmfd025, 
   xmfd026 LIKE xmfd_t.xmfd026, 
   xmfd027 LIKE xmfd_t.xmfd027, 
   xmfd028 LIKE xmfd_t.xmfd028, 
   xmfd029 LIKE xmfd_t.xmfd029, 
   xmfddocdt LIKE xmfd_t.xmfddocdt, 
   xmfddocno LIKE xmfd_t.xmfddocno, 
   xmfdent LIKE xmfd_t.xmfdent, 
   xmfdsite LIKE xmfd_t.xmfdsite, 
   xmfdstus LIKE xmfd_t.xmfdstus, 
   xmff001 LIKE xmff_t.xmff001, 
   xmff002 LIKE xmff_t.xmff002, 
   xmff003 LIKE xmff_t.xmff003, 
   xmff004 LIKE xmff_t.xmff004, 
   xmff005 LIKE xmff_t.xmff005, 
   xmff006 LIKE xmff_t.xmff006, 
   xmff007 LIKE xmff_t.xmff007, 
   xmff008 LIKE xmff_t.xmff008, 
   xmff009 LIKE xmff_t.xmff009, 
   xmff010 LIKE xmff_t.xmff010, 
   xmff011 LIKE xmff_t.xmff011, 
   xmff012 LIKE xmff_t.xmff012, 
   xmff013 LIKE xmff_t.xmff013, 
   xmffseq LIKE xmff_t.xmffseq, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   pmaal_t_pmaal006 LIKE pmaal_t.pmaal006, 
   xmfal_t_xmfal003 LIKE xmfal_t.xmfal003, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   t2_oocql004 LIKE oocql_t.oocql004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   xmahl_t_xmahl003 LIKE xmahl_t.xmahl003, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   l_xmfd001_ooag011 LIKE type_t.chr300, 
   l_xmfd002_ooefl003 LIKE type_t.chr1000, 
   l_xmfd003_pmaal003 LIKE type_t.chr300, 
   l_xmfd009_xmfal003 LIKE type_t.chr1000, 
   l_xmff003_show LIKE type_t.chr30, 
   l_xmff008_sum LIKE type_t.num20_6, 
   l_xmff009_sum LIKE type_t.num20_6, 
   l_xmff010_sum LIKE type_t.num20_6, 
   l_xmfd012_desc LIKE type_t.chr1000, 
   l_xmfd029_show LIKE type_t.chr1, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmfd034 LIKE xmfd_t.xmfd034
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_pmak003 LIKE pmak_t.pmak003  #161031-00022#2 add
#161031-00024#9 Add By Ken 170124(S)
DEFINE l_slip_tmp       LIKE ooba_t.ooba002      #單據別   
DEFINE l_success        LIKE type_t.num10
DEFINE l_gzcb002        LIKE gzcb_t.gzcb002      #單據別參數
DEFINE l_sql            STRING
DEFINE l_cnt_chk        LIKE type_t.num10
#161031-00024#9 Add By Ken 170124(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr410_g01_curs INTO sr_s.*
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
       LET sr_s.l_xmff003_show = "Y"
       IF cl_null(sr_s.xmff003) THEN
          LET sr_s.l_xmff003_show = "N"
       END IF
       LET sr_s.l_xmfd029_show = "Y"
       IF cl_null(sr_s.xmfd029) THEN
          LET sr_s.l_xmfd029_show = "N"
       END IF
       #稅別說明
       CALL s_desc_get_tax_desc1(g_site,sr_s.xmfd012)RETURNING sr_s.l_xmfd012_desc
       IF cl_null(sr_s.l_xmfd012_desc) AND cl_null(sr_s.xmfd013) THEN
           INITIALIZE sr_s.l_xmfd012_desc TO NULL
       ELSE
          IF cl_null(sr_s.l_xmfd012_desc) OR cl_null(sr_s.xmfd013) THEN
             LET sr_s.l_xmfd012_desc = sr_s.l_xmfd012_desc , sr_s.xmfd013 , '%'
          ELSE
             LET sr_s.l_xmfd012_desc = sr_s.l_xmfd012_desc || sr_s.xmfd013 || '%'
          END IF
       END IF
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL axmr410_g01_initialize(sr_s.xmfd001,sr_s.l_xmfd001_ooag011) RETURNING sr_s.l_xmfd001_ooag011
       CALL axmr410_g01_initialize(sr_s.xmfd002,sr_s.l_xmfd002_ooefl003) RETURNING sr_s.l_xmfd002_ooefl003       
       CALL axmr410_g01_initialize(sr_s.xmfd003,sr_s.l_xmfd003_pmaal003) RETURNING sr_s.l_xmfd003_pmaal003
       #161031-00022#2-s       
       LET l_pmak003 = ''    
       SELECT pmak003 INTO l_pmak003 FROM pmak_t 
        WHERE pmakent = g_enterprise AND pmak001 = sr_s.xmfd034  
       
       IF cl_null(l_pmak003) THEN
          CALL s_desc_get_trading_partner_full_desc(sr_s.xmfd003) RETURNING sr_s.pmaal_t_pmaal003          
       ELSE
          LET sr_s.pmaal_t_pmaal003 = l_pmak003
          LET sr_s.pmaal_t_pmaal006 = l_pmak003
       END IF
       #161031-00022#2-e
       
       #161031-00024#9 Add By Ken 170124(S)
       IF tm.a1 = 'Y' THEN
          #先取得單別
          LET l_success = ''
          LET l_slip_tmp = ''
          CALL s_aooi200_get_slip(sr_s.xmfddocno)
             RETURNING l_success,l_slip_tmp
          
          #取得單別參數
          CALL cl_get_doc_para(g_enterprise,g_site,l_slip_tmp,'D-MFG-0087')
             RETURNING l_gzcb002       
             
          IF NOT cl_null(l_gzcb002) THEN
             LET l_cnt_chk = 0
             SELECT COUNT(1) INTO l_cnt_chk
               FROM imab_t
              WHERE imabent = g_enterprise
                AND imab001 = sr_s.xmff001
                AND imab002 = l_gzcb002
                AND imabstus = 'Y'
                AND (imab005 IS NOT NULL OR imab005<>'') 
             IF l_cnt_chk > 0 THEN
                CALL s_desc_get_imab004_desc(sr_s.xmff001,l_gzcb002) RETURNING sr_s.x_imaal_t_imaal003
                IF NOT cl_null(sr_s.x_imaal_t_imaal003) THEN
                   LET sr_s.x_imaal_t_imaal004 = ''
                END IF
             END IF
          END IF
       END IF
       #161031-00024#9 Add By Ken 170124(E)       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmfd001 = sr_s.xmfd001
       LET sr[l_cnt].xmfd002 = sr_s.xmfd002
       LET sr[l_cnt].xmfd003 = sr_s.xmfd003
       LET sr[l_cnt].xmfd004 = sr_s.xmfd004
       LET sr[l_cnt].xmfd005 = sr_s.xmfd005
       LET sr[l_cnt].xmfd006 = sr_s.xmfd006
       LET sr[l_cnt].xmfd007 = sr_s.xmfd007
       LET sr[l_cnt].xmfd008 = sr_s.xmfd008
       LET sr[l_cnt].xmfd009 = sr_s.xmfd009
       LET sr[l_cnt].xmfd010 = sr_s.xmfd010
       LET sr[l_cnt].xmfd011 = sr_s.xmfd011
       LET sr[l_cnt].xmfd012 = sr_s.xmfd012
       LET sr[l_cnt].xmfd013 = sr_s.xmfd013
       LET sr[l_cnt].xmfd014 = sr_s.xmfd014
       LET sr[l_cnt].xmfd015 = sr_s.xmfd015
       LET sr[l_cnt].xmfd016 = sr_s.xmfd016
       LET sr[l_cnt].xmfd017 = sr_s.xmfd017
       LET sr[l_cnt].xmfd018 = sr_s.xmfd018
       LET sr[l_cnt].xmfd019 = sr_s.xmfd019
       LET sr[l_cnt].xmfd020 = sr_s.xmfd020
       LET sr[l_cnt].xmfd021 = sr_s.xmfd021
       LET sr[l_cnt].xmfd022 = sr_s.xmfd022
       LET sr[l_cnt].xmfd023 = sr_s.xmfd023
       LET sr[l_cnt].xmfd024 = sr_s.xmfd024
       LET sr[l_cnt].xmfd025 = sr_s.xmfd025
       LET sr[l_cnt].xmfd026 = sr_s.xmfd026
       LET sr[l_cnt].xmfd027 = sr_s.xmfd027
       LET sr[l_cnt].xmfd028 = sr_s.xmfd028
       LET sr[l_cnt].xmfd029 = sr_s.xmfd029
       LET sr[l_cnt].xmfddocdt = sr_s.xmfddocdt
       LET sr[l_cnt].xmfddocno = sr_s.xmfddocno
       LET sr[l_cnt].xmfdent = sr_s.xmfdent
       LET sr[l_cnt].xmfdsite = sr_s.xmfdsite
       LET sr[l_cnt].xmfdstus = sr_s.xmfdstus
       LET sr[l_cnt].xmff001 = sr_s.xmff001
       LET sr[l_cnt].xmff002 = sr_s.xmff002
       LET sr[l_cnt].xmff003 = sr_s.xmff003
       LET sr[l_cnt].xmff004 = sr_s.xmff004
       LET sr[l_cnt].xmff005 = sr_s.xmff005
       LET sr[l_cnt].xmff006 = sr_s.xmff006
       LET sr[l_cnt].xmff007 = sr_s.xmff007
       LET sr[l_cnt].xmff008 = sr_s.xmff008
       LET sr[l_cnt].xmff009 = sr_s.xmff009
       LET sr[l_cnt].xmff010 = sr_s.xmff010
       LET sr[l_cnt].xmff011 = sr_s.xmff011
       LET sr[l_cnt].xmff012 = sr_s.xmff012
       LET sr[l_cnt].xmff013 = sr_s.xmff013
       LET sr[l_cnt].xmffseq = sr_s.xmffseq
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].pmaal_t_pmaal006 = sr_s.pmaal_t_pmaal006
       LET sr[l_cnt].xmfal_t_xmfal003 = sr_s.xmfal_t_xmfal003
       LET sr[l_cnt].t1_oocql004 = sr_s.t1_oocql004
       LET sr[l_cnt].t2_oocql004 = sr_s.t2_oocql004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].xmahl_t_xmahl003 = sr_s.xmahl_t_xmahl003
       LET sr[l_cnt].oofb_t_oofb011 = sr_s.oofb_t_oofb011
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].l_xmfd001_ooag011 = sr_s.l_xmfd001_ooag011
       LET sr[l_cnt].l_xmfd002_ooefl003 = sr_s.l_xmfd002_ooefl003
       LET sr[l_cnt].l_xmfd003_pmaal003 = sr_s.l_xmfd003_pmaal003
       LET sr[l_cnt].l_xmfd009_xmfal003 = sr_s.l_xmfd009_xmfal003
       LET sr[l_cnt].l_xmff003_show = sr_s.l_xmff003_show
       LET sr[l_cnt].l_xmff008_sum = sr_s.l_xmff008_sum
       LET sr[l_cnt].l_xmff009_sum = sr_s.l_xmff009_sum
       LET sr[l_cnt].l_xmff010_sum = sr_s.l_xmff010_sum
       LET sr[l_cnt].l_xmfd012_desc = sr_s.l_xmfd012_desc
       LET sr[l_cnt].l_xmfd029_show = sr_s.l_xmfd029_show
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].xmfd034 = sr_s.xmfd034
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr410_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr410_g01_rep_data()
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
          START REPORT axmr410_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr410_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr410_g01_rep
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
 
{<section id="axmr410_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr410_g01_rep(sr1)
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
DEFINE sr3 sr3_r
DEFINE sr4 sr4_r
DEFINE l_imaal004_show   LIKE type_t.chr1      #161031-00024#9 Add By ken 170206
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmfddocno,sr1.xmffseq
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
        BEFORE GROUP OF sr1.xmfddocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmfddocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmfdent=' ,sr1.xmfdent,'{+}xmfddocno=' ,sr1.xmfddocno         
            CALL cl_gr_init_apr(sr1.xmfddocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmfddocno.before name="rep.b_group.xmfddocno.before"
           #161031-00024#9 Add By Ken 170206(S)
           #規格若為空，則隱藏
           INITIALIZE l_imaal004_show TO NULL
           IF cl_null(sr1.x_imaal_t_imaal004) THEN
              LET l_imaal004_show = 'N'
           ELSE
              LET l_imaal004_show = 'Y'
           END IF
           PRINTX l_imaal004_show
           #161031-00024#9 Add By Ken 170206(E) 

           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmfdent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfddocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr410_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr410_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr410_g01_subrep01
           DECLARE axmr410_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr410_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr410_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr410_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr410_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmfddocno.after name="rep.b_group.xmfddocno.after"
           START REPORT axmr410_g01_subrep05
              LET g_sql = "SELECT xmfhdocno,xmfhseq,xmfh001,xmfh002,xmfh003,xmfh004,xmfh005,xmfh006",
                          "  FROM xmfh_t ",
                          " WHERE xmfhdocno = '",sr1.xmfddocno CLIPPED,"'",
                          "   AND xmfhent   = '",sr1.xmfdent   CLIPPED,"'",
                          "   ORDER BY xmfhseq "
              DECLARE axmr410_g01_repcur05 CURSOR FROM g_sql
              FOREACH axmr410_g01_repcur05 INTO sr3.*
                 IF STATUS THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "axmr410_g01_repcur05:"
                    LET g_errparam.code   = SQLCA.sqlcode
                    LET g_errparam.popup  = FALSE
                    CALL cl_err()                  
                    EXIT FOREACH 
                 END IF
                 CALL s_desc_get_item_desc(sr3.xmfh001) RETURNING sr3.l_xmfh001_desc,sr3.l_xmfh001_desc_2
                 CALL s_desc_get_trading_partner_full_desc(sr3.xmfh005) RETURNING sr3.l_xmfh005_desc
                 #mod--160316-00004#1 By shiun--(S)
                 IF cl_null(sr3.xmfh005) THEN
                    LET sr3.l_xmfh005_desc = ''
                 ELSE
                    LET sr3.l_xmfh005_desc = sr3.xmfh005,".",sr3.l_xmfh005_desc
                 END IF
                 #mod--160316-00004#1 By shiun--(E)                 
                 IF NOT cl_null(sr3.xmfh006) THEN
                    LET sr3.l_xmfh006_show = "Y"
                 ELSE
                    LET sr3.l_xmfh006_show = "N"
                 END IF
                 
                 OUTPUT TO REPORT axmr410_g01_subrep05(sr3.*)
                 INITIALIZE sr3.* TO NULL
              END FOREACH
           FINISH REPORT axmr410_g01_subrep05
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmffseq
 
           #add-point:rep.b_group.xmffseq.before name="rep.b_group.xmffseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmffseq.after name="rep.b_group.xmffseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.xmfdent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfddocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmffseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr410_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr410_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr410_g01_subrep02
           DECLARE axmr410_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr410_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr410_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr410_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr410_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
           START REPORT axmr410_g01_subrep06
              LET g_sql = "SELECT xmfgdocno,xmfg001,xmfg002,xmfg003,xmfg004",
                          "  FROM xmfg_t ",
                          " WHERE xmfgdocno = '",sr1.xmfddocno CLIPPED,"'",
                          "   AND xmfgent   = '",sr1.xmfdent   CLIPPED,"'",
                          "   AND xmfgseq   = '",sr1.xmffseq   CLIPPED,"'",
                          "   ORDER BY xmfgseq "
              DECLARE axmr410_g01_repcur06 CURSOR FROM g_sql
              FOREACH axmr410_g01_repcur06 INTO sr4.*
               OUTPUT TO REPORT axmr410_g01_subrep06(sr4.*)
              END FOREACH
           FINISH REPORT axmr410_g01_subrep06
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.xmfdent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfddocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmffseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr410_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr410_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr410_g01_subrep03
           DECLARE axmr410_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr410_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr410_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr410_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr410_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmfddocno
 
           #add-point:rep.a_group.xmfddocno.before name="rep.a_group.xmfddocno.before"
 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmfdent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfddocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr410_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr410_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr410_g01_subrep04
           DECLARE axmr410_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr410_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr410_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr410_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr410_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmfddocno.after name="rep.a_group.xmfddocno.after"
           IF cl_null(GROUP SUM(sr1.xmff008)) THEN
              LET sr1.l_xmff008_sum = 0
           ELSE
              LET sr1.l_xmff008_sum = GROUP SUM(sr1.xmff008)
           END IF
           IF cl_null(GROUP SUM(sr1.xmff009)) THEN
              LET sr1.l_xmff009_sum = 0
           ELSE
              LET sr1.l_xmff009_sum = GROUP SUM(sr1.xmff009)
           END IF
           IF cl_null(GROUP SUM(sr1.xmff010)) THEN
              LET sr1.l_xmff010_sum = 0
           ELSE
              LET sr1.l_xmff010_sum = GROUP SUM(sr1.xmff010)
           END IF
           PRINTX sr1.l_xmff008_sum,sr1.l_xmff009_sum,sr1.l_xmff010_sum
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmffseq
 
           #add-point:rep.a_group.xmffseq.before name="rep.a_group.xmffseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmffseq.after name="rep.a_group.xmffseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr410_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr410_g01_subrep01(sr2)
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
PRIVATE REPORT axmr410_g01_subrep02(sr2)
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
PRIVATE REPORT axmr410_g01_subrep03(sr2)
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
PRIVATE REPORT axmr410_g01_subrep04(sr2)
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
 
{<section id="axmr410_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION axmr410_g01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr1
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
      WHEN '1'
         SELECT gzcbl004 INTO r_desc
           FROM gzcbl_t
          WHERE gzcbl001 = p_num
            AND gzcbl002 = p_target
            AND gzcbl003 = g_dlang
         
      WHEN '2'
         SELECT oocql004 INTO r_desc
           FROM oocql_t
          WHERE oocql001 = p_num
            AND oocql002 = p_target
            AND oocql003 = g_dlang
            AND oocqlent = g_enterprise
   END CASE
   
   RETURN r_desc
END FUNCTION

PRIVATE FUNCTION axmr410_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING
   IF cl_null(p_arg) THEN
      INITIALIZE r_exp TO NULL
   ELSE
      LET r_exp = p_exp
   END IF
RETURN r_exp
END FUNCTION

 
{</section>}
 
{<section id="axmr410_g01.other_report" readonly="Y" >}

PRIVATE REPORT axmr410_g01_subrep05(sr3)
     DEFINE sr3 sr3_r  
     ORDER EXTERNAL BY sr3.xmfhdocno
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.*
        PRINTX sr3.*   
END REPORT

PRIVATE REPORT axmr410_g01_subrep06(sr4)
     DEFINE sr4 sr4_r  
     ORDER EXTERNAL BY sr4.xmfgdocno
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.*
        PRINTX sr4.*   
END REPORT

 
{</section>}
 
