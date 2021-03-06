#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr400_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:16(2017-01-25 09:03:47), PR版次:0016(2017-02-06 12:06:32)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000398
#+ Filename...: axmr400_g01
#+ Description: ...
#+ Creator....: 05384(2014-06-17 17:58:46)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="axmr400_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160316-00002#1   2016/05/16 By shiun     報表中最後建議廠商欄位沒有資料，不應有點(.)
#161109-00085#11  2016/11/10 By 08993     整批調整系統星號寫法
#161031-00023#2   2016/01/16 By 08992     報表客戶名稱增加一次性交易對象判斷
#161031-00024#8   2017/01/25 By 06137     2.報表畫面增加"列印額外品名規格"選項
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
   xmev001 LIKE xmev_t.xmev001, 
   xmev002 LIKE xmev_t.xmev002, 
   xmev003 LIKE xmev_t.xmev003, 
   xmev004 LIKE xmev_t.xmev004, 
   xmev005 LIKE xmev_t.xmev005, 
   xmev006 LIKE xmev_t.xmev006, 
   xmev007 LIKE xmev_t.xmev007, 
   xmev008 LIKE xmev_t.xmev008, 
   xmev009 LIKE xmev_t.xmev009, 
   xmev010 LIKE xmev_t.xmev010, 
   xmev011 LIKE xmev_t.xmev011, 
   xmev012 LIKE xmev_t.xmev012, 
   xmev013 LIKE xmev_t.xmev013, 
   xmev014 LIKE xmev_t.xmev014, 
   xmev015 LIKE xmev_t.xmev015, 
   xmev016 LIKE xmev_t.xmev016, 
   xmev017 LIKE xmev_t.xmev017, 
   xmev018 LIKE xmev_t.xmev018, 
   xmev019 LIKE xmev_t.xmev019, 
   xmevdocdt LIKE xmev_t.xmevdocdt, 
   xmevdocno LIKE xmev_t.xmevdocno, 
   xmevent LIKE xmev_t.xmevent, 
   xmevsite LIKE xmev_t.xmevsite, 
   xmevstus LIKE xmev_t.xmevstus, 
   xmew001 LIKE xmew_t.xmew001, 
   xmew002 LIKE xmew_t.xmew002, 
   xmew003 LIKE xmew_t.xmew003, 
   xmew004 LIKE xmew_t.xmew004, 
   xmew005 LIKE xmew_t.xmew005, 
   xmew006 LIKE xmew_t.xmew006, 
   xmew007 LIKE xmew_t.xmew007, 
   xmew008 LIKE xmew_t.xmew008, 
   xmew009 LIKE xmew_t.xmew009, 
   xmew010 LIKE xmew_t.xmew010, 
   xmew011 LIKE xmew_t.xmew011, 
   xmew012 LIKE xmew_t.xmew012, 
   xmew013 LIKE xmew_t.xmew013, 
   xmew014 LIKE xmew_t.xmew014, 
   xmew015 LIKE xmew_t.xmew015, 
   xmew016 LIKE xmew_t.xmew016, 
   xmewseq LIKE xmew_t.xmewseq, 
   xmewsite LIKE xmew_t.xmewsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t1_pmaal004 LIKE pmaal_t.pmaal004, 
   xmesl_t_xmesl003 LIKE xmesl_t.xmesl003, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t2_oocal003 LIKE oocal_t.oocal003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   l_xmev004_xmesl003 LIKE type_t.chr1000, 
   l_xmev001_ooag011 LIKE type_t.chr300, 
   l_xmev003_pmaal003 LIKE type_t.chr300, 
   l_xmev002_ooefl003 LIKE type_t.chr1000, 
   l_xmew013_pmaal004 LIKE type_t.chr100, 
   xmewent LIKE xmew_t.xmewent, 
   xmewdocno LIKE xmew_t.xmewdocno, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_xmew001_desc LIKE oocql_t.oocql004, 
   l_xmew002_desc LIKE oocql_t.oocql004, 
   l_xmew016_show LIKE type_t.chr1, 
   l_detail02_show LIKE type_t.chr1, 
   l_detail03_show LIKE type_t.chr1, 
   l_detail04_show LIKE type_t.chr1, 
   l_xmev019_show LIKE type_t.chr1, 
   l_xmev008_desc LIKE type_t.chr1000, 
   pmaal_t_pmaal006 LIKE pmaal_t.pmaal006, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   xmev020 LIKE xmev_t.xmev020
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1,         #估價製程資料 
       c1 LIKE type_t.chr1          #列印額外品名
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
TYPE sr3_r RECORD  #子報表(不良原因) 
   #161109-00085#11-mod-s
   #xmex RECORD LIKE xmex_t.*,   #161109-00085#11 mark  
   xmex RECORD  #銷售估價製程明細單身檔
       xmexent LIKE xmex_t.xmexent, #企業編號
       xmexsite LIKE xmex_t.xmexsite, #營運據點
       xmexdocno LIKE xmex_t.xmexdocno, #估價單號
       xmexseq LIKE xmex_t.xmexseq, #製程項次
       xmex001 LIKE xmex_t.xmex001, #部位編號
       xmex002 LIKE xmex_t.xmex002, #料件編號
       xmex003 LIKE xmex_t.xmex003, #製程項序
       xmex004 LIKE xmex_t.xmex004, #作業編號
       xmex005 LIKE xmex_t.xmex005, #作業序
       xmex006 LIKE xmex_t.xmex006, #工作站編號
       xmex007 LIKE xmex_t.xmex007, #預估工時
       xmex008 LIKE xmex_t.xmex008, #預估機時
       xmex009 LIKE xmex_t.xmex009, #工作單位
       xmex010 LIKE xmex_t.xmex010, #單位工資率
       xmex011 LIKE xmex_t.xmex011, #單位製費率
       xmex012 LIKE xmex_t.xmex012, #工資單價
       xmex013 LIKE xmex_t.xmex013, #費用單價
       xmex014 LIKE xmex_t.xmex014 #備註
   END RECORD,
   #161109-00085#11-mod-e
   l_imaal003  LIKE imaal_t.imaal003,
   l_imaal004  LIKE imaal_t.imaal004,
   l_xmex001_desc LIKE oocql_t.oocql004,
   l_xmex004_desc LIKE oocql_t.oocql004,
   l_xmex006_desc LIKE ecaa_t.ecaa002,
   l_detail02_show LIKE type_t.chr1,
   l_detail03_show LIKE type_t.chr1,
   l_xmex014_show  LIKE type_t.chr1
END RECORD
TYPE sr4_r RECORD  #子報表(不良原因)
   xmfidocno        LIKE xmfi_t.xmfidocno,
   xmfiseq          LIKE xmfi_t.xmfiseq,
   xmfi001          LIKE xmfi_t.xmfi001,
   xmfi002          LIKE xmfi_t.xmfi002,
   xmfi003          LIKE xmfi_t.xmfi003,
   xmfi004          LIKE xmfi_t.xmfi004,
   xmfi005          LIKE xmfi_t.xmfi005,
   xmfi006          LIKE xmfi_t.xmfi006,
   l_xmfi001_desc   LIKE imaal_t.imaal003,
   l_xmfi001_desc_2 LIKE imaal_t.imaal004,
   l_xmfi005_desc   LIKE type_t.chr1000,
   l_xmfi006_show   LIKE type_t.chr1
END RECORD
#DEFINE g_pmn RECORD LIKE pmn_file.*
#end add-point
 
{</section>}
 
{<section id="axmr400_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr400_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  估價製程資料 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.c1  列印額外品名
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.c1 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axmr400_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr400_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr400_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr400_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr400_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr400_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xmev001,xmev002,xmev003,xmev004,xmev005,xmev006,xmev007,xmev008,xmev009,xmev010, 
       xmev011,xmev012,xmev013,xmev014,xmev015,xmev016,xmev017,xmev018,xmev019,xmevdocdt,xmevdocno,xmevent, 
       xmevsite,xmevstus,xmew001,xmew002,xmew003,xmew004,xmew005,xmew006,xmew007,xmew008,xmew009,xmew010, 
       xmew011,xmew012,xmew013,xmew014,xmew015,xmew016,xmewseq,xmewsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmev_t.xmev001 AND ooag_t.ooagent = xmev_t.xmevent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmev_t.xmev002 AND ooefl_t.ooeflent = xmev_t.xmevent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmev_t.xmev003 AND pmaal_t.pmaalent = xmev_t.xmevent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),x.t1_pmaal004,( SELECT xmesl003 FROM xmesl_t WHERE xmesl_t.xmesldocno = xmev_t.xmev004 AND xmesl_t.xmeslent = xmev_t.xmevent AND xmesl_t.xmesl002 = '" , 
       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmev_t.xmev006 AND ooail_t.ooailent = xmev_t.xmevent AND ooail_t.ooail002 = '" , 
       g_dlang,"'" ,"),( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmev_t.xmev012 AND oocal_t.oocalent = xmev_t.xmevent AND oocal_t.oocal002 = '" , 
       g_dlang,"'" ,"),x.t2_oocal003,x.imaal_t_imaal003,trim(xmev004)||'.'||trim((SELECT xmesl003 FROM xmesl_t WHERE xmesl_t.xmesldocno = xmev_t.xmev004 AND xmesl_t.xmeslent = xmev_t.xmevent AND xmesl_t.xmesl002 = '" , 
       g_dlang,"'" ,")),trim(xmev001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmev_t.xmev001 AND ooag_t.ooagent = xmev_t.xmevent)), 
       trim(xmev003)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmev_t.xmev003 AND pmaal_t.pmaalent = xmev_t.xmevent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),trim(xmev002)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmev_t.xmev002 AND ooefl_t.ooeflent = xmev_t.xmevent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(xmew013)||'.'||trim(x.t1_pmaal004),xmewent,xmewdocno,x.imaal_t_imaal004, 
       '','','','','','','','',( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmev_t.xmev003 AND pmaal_t.pmaalent = xmev_t.xmevent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmev_t.xmev003 AND pmaal_t.pmaalent = xmev_t.xmevent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),xmev020"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xmev_t LEFT OUTER JOIN ( SELECT xmew_t.*,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmew_t.xmew013 AND pmaal_t.pmaalent = xmew_t.xmewent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,") t1_pmaal004,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmew_t.xmew006 AND oocal_t.oocalent = xmew_t.xmewent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") t2_oocal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmew_t.xmew003 AND imaal_t.imaalent = xmew_t.xmewent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = xmew_t.xmew003 AND imaal_t.imaalent = xmew_t.xmewent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004 FROM xmew_t ) x  ON xmev_t.xmevent = x.xmewent AND xmev_t.xmevdocno  
        = x.xmewdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xmevdocno,xmewseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmev_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr400_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr400_g01_curs CURSOR FOR axmr400_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr400_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr400_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmev001 LIKE xmev_t.xmev001, 
   xmev002 LIKE xmev_t.xmev002, 
   xmev003 LIKE xmev_t.xmev003, 
   xmev004 LIKE xmev_t.xmev004, 
   xmev005 LIKE xmev_t.xmev005, 
   xmev006 LIKE xmev_t.xmev006, 
   xmev007 LIKE xmev_t.xmev007, 
   xmev008 LIKE xmev_t.xmev008, 
   xmev009 LIKE xmev_t.xmev009, 
   xmev010 LIKE xmev_t.xmev010, 
   xmev011 LIKE xmev_t.xmev011, 
   xmev012 LIKE xmev_t.xmev012, 
   xmev013 LIKE xmev_t.xmev013, 
   xmev014 LIKE xmev_t.xmev014, 
   xmev015 LIKE xmev_t.xmev015, 
   xmev016 LIKE xmev_t.xmev016, 
   xmev017 LIKE xmev_t.xmev017, 
   xmev018 LIKE xmev_t.xmev018, 
   xmev019 LIKE xmev_t.xmev019, 
   xmevdocdt LIKE xmev_t.xmevdocdt, 
   xmevdocno LIKE xmev_t.xmevdocno, 
   xmevent LIKE xmev_t.xmevent, 
   xmevsite LIKE xmev_t.xmevsite, 
   xmevstus LIKE xmev_t.xmevstus, 
   xmew001 LIKE xmew_t.xmew001, 
   xmew002 LIKE xmew_t.xmew002, 
   xmew003 LIKE xmew_t.xmew003, 
   xmew004 LIKE xmew_t.xmew004, 
   xmew005 LIKE xmew_t.xmew005, 
   xmew006 LIKE xmew_t.xmew006, 
   xmew007 LIKE xmew_t.xmew007, 
   xmew008 LIKE xmew_t.xmew008, 
   xmew009 LIKE xmew_t.xmew009, 
   xmew010 LIKE xmew_t.xmew010, 
   xmew011 LIKE xmew_t.xmew011, 
   xmew012 LIKE xmew_t.xmew012, 
   xmew013 LIKE xmew_t.xmew013, 
   xmew014 LIKE xmew_t.xmew014, 
   xmew015 LIKE xmew_t.xmew015, 
   xmew016 LIKE xmew_t.xmew016, 
   xmewseq LIKE xmew_t.xmewseq, 
   xmewsite LIKE xmew_t.xmewsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   x_t1_pmaal004 LIKE pmaal_t.pmaal004, 
   xmesl_t_xmesl003 LIKE xmesl_t.xmesl003, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t2_oocal003 LIKE oocal_t.oocal003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   l_xmev004_xmesl003 LIKE type_t.chr1000, 
   l_xmev001_ooag011 LIKE type_t.chr300, 
   l_xmev003_pmaal003 LIKE type_t.chr300, 
   l_xmev002_ooefl003 LIKE type_t.chr1000, 
   l_xmew013_pmaal004 LIKE type_t.chr100, 
   xmewent LIKE xmew_t.xmewent, 
   xmewdocno LIKE xmew_t.xmewdocno, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_xmew001_desc LIKE oocql_t.oocql004, 
   l_xmew002_desc LIKE oocql_t.oocql004, 
   l_xmew016_show LIKE type_t.chr1, 
   l_detail02_show LIKE type_t.chr1, 
   l_detail03_show LIKE type_t.chr1, 
   l_detail04_show LIKE type_t.chr1, 
   l_xmev019_show LIKE type_t.chr1, 
   l_xmev008_desc LIKE type_t.chr1000, 
   pmaal_t_pmaal006 LIKE pmaal_t.pmaal006, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   xmev020 LIKE xmev_t.xmev020
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_pmak003 LIKE pmak_t.pmak003  #161031-00023#2 add
#161031-00024#8 Add By Ken 170125(S)
DEFINE l_slip_tmp       LIKE ooba_t.ooba002      #單據別   
DEFINE l_success        LIKE type_t.num10
DEFINE l_gzcb002        LIKE gzcb_t.gzcb002      #單據別參數
DEFINE l_sql            STRING
DEFINE l_cnt_chk        LIKE type_t.num10
#161031-00024#8 Add By Ken 170125(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr400_g01_curs INTO sr_s.*
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
       #稅別說明
       CALL s_desc_get_tax_desc1(g_site,sr_s.xmev008) RETURNING sr_s.l_xmev008_desc
       IF cl_null(sr_s.l_xmev008_desc) OR cl_null(sr_s.xmev009) THEN
          LET sr_s.l_xmev008_desc = sr_s.l_xmev008_desc , sr_s.xmev009 , '%'
       ELSE
          LET sr_s.l_xmev008_desc = sr_s.l_xmev008_desc || sr_s.xmev009 || '%'
       END IF
       #部位編號說明
       CALL axmr400_g01_desc('2','215',sr_s.xmew001) RETURNING sr_s.l_xmew001_desc
       #部位編號說明
       CALL axmr400_g01_desc('2','221',sr_s.xmew002) RETURNING sr_s.l_xmew002_desc
       #單頭補充說明顯示否
       CALL axmr400_g01_show(sr_s.xmev019,'','','') RETURNING sr_s.l_xmev019_show
       CALL axmr400_g01_show(sr_s.xmew004,'','','') RETURNING sr_s.l_detail04_show
       #單身欄位顯示否
       CALL axmr400_g01_show(sr_s.xmew016,'','','') RETURNING sr_s.l_xmew016_show 
       CALL axmr400_g01_show(sr_s.xmew002,sr_s.x_imaal_t_imaal003,sr_s.xmew006,'') RETURNING sr_s.l_detail02_show
       CALL axmr400_g01_show(sr_s.x_imaal_t_imaal004,'','','') RETURNING sr_s.l_detail03_show
       CALL axmr400_g01_show(sr_s.xmew004,'','','') RETURNING sr_s.l_detail04_show
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL axmr400_g01_initialize(sr_s.xmev003,sr_s.l_xmev003_pmaal003) RETURNING sr_s.l_xmev003_pmaal003
       CALL axmr400_g01_initialize(sr_s.xmev001,sr_s.l_xmev001_ooag011) RETURNING sr_s.l_xmev001_ooag011 
       CALL axmr400_g01_initialize(sr_s.xmev002,sr_s.l_xmev002_ooefl003) RETURNING sr_s.l_xmev002_ooefl003
       #161031-00023#2-s       
       LET l_pmak003 = ''    
       SELECT pmak003 INTO l_pmak003 FROM pmak_t 
        WHERE pmakent = g_enterprise AND pmak001 = sr_s.xmev020  
       
       IF cl_null(l_pmak003) THEN
          CALL s_desc_get_trading_partner_full_desc(sr_s.xmev003) RETURNING sr_s.pmaal_t_pmaal003          
       ELSE
          LET sr_s.pmaal_t_pmaal003 = l_pmak003
          LET sr_s.pmaal_t_pmaal006 = l_pmak003
       END IF
       #161031-00023#2-e
       
       #161031-00024#8 Add By Ken 170125(S)
       IF tm.c1 = 'Y' THEN
          #先取得單別
          LET l_success = ''
          LET l_slip_tmp = ''
          CALL s_aooi200_get_slip(sr_s.xmevdocno)
             RETURNING l_success,l_slip_tmp
          
          #取得單別參數
          CALL cl_get_doc_para(g_enterprise,g_site,l_slip_tmp,'D-MFG-0087')
             RETURNING l_gzcb002       
             
          IF NOT cl_null(l_gzcb002) THEN
             LET l_cnt_chk = 0
             SELECT COUNT(1) INTO l_cnt_chk
               FROM imab_t
              WHERE imabent = g_enterprise
                AND imab001 = sr_s.xmew003
                AND imab002 = l_gzcb002
                AND imabstus = 'Y'
                AND (imab005 IS NOT NULL OR imab005<>'') 
             IF l_cnt_chk > 0 THEN
                CALL s_desc_get_imab004_desc(sr_s.xmew003,l_gzcb002) RETURNING sr_s.x_imaal_t_imaal003
                IF NOT cl_null(sr_s.x_imaal_t_imaal003) THEN
                   LET sr_s.x_imaal_t_imaal004 = ''
                END IF
             END IF
          END IF
       END IF
       #161031-00024#8 Add By Ken 170125(E)       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmev001 = sr_s.xmev001
       LET sr[l_cnt].xmev002 = sr_s.xmev002
       LET sr[l_cnt].xmev003 = sr_s.xmev003
       LET sr[l_cnt].xmev004 = sr_s.xmev004
       LET sr[l_cnt].xmev005 = sr_s.xmev005
       LET sr[l_cnt].xmev006 = sr_s.xmev006
       LET sr[l_cnt].xmev007 = sr_s.xmev007
       LET sr[l_cnt].xmev008 = sr_s.xmev008
       LET sr[l_cnt].xmev009 = sr_s.xmev009
       LET sr[l_cnt].xmev010 = sr_s.xmev010
       LET sr[l_cnt].xmev011 = sr_s.xmev011
       LET sr[l_cnt].xmev012 = sr_s.xmev012
       LET sr[l_cnt].xmev013 = sr_s.xmev013
       LET sr[l_cnt].xmev014 = sr_s.xmev014
       LET sr[l_cnt].xmev015 = sr_s.xmev015
       LET sr[l_cnt].xmev016 = sr_s.xmev016
       LET sr[l_cnt].xmev017 = sr_s.xmev017
       LET sr[l_cnt].xmev018 = sr_s.xmev018
       LET sr[l_cnt].xmev019 = sr_s.xmev019
       LET sr[l_cnt].xmevdocdt = sr_s.xmevdocdt
       LET sr[l_cnt].xmevdocno = sr_s.xmevdocno
       LET sr[l_cnt].xmevent = sr_s.xmevent
       LET sr[l_cnt].xmevsite = sr_s.xmevsite
       LET sr[l_cnt].xmevstus = sr_s.xmevstus
       LET sr[l_cnt].xmew001 = sr_s.xmew001
       LET sr[l_cnt].xmew002 = sr_s.xmew002
       LET sr[l_cnt].xmew003 = sr_s.xmew003
       LET sr[l_cnt].xmew004 = sr_s.xmew004
       LET sr[l_cnt].xmew005 = sr_s.xmew005
       LET sr[l_cnt].xmew006 = sr_s.xmew006
       LET sr[l_cnt].xmew007 = sr_s.xmew007
       LET sr[l_cnt].xmew008 = sr_s.xmew008
       LET sr[l_cnt].xmew009 = sr_s.xmew009
       LET sr[l_cnt].xmew010 = sr_s.xmew010
       LET sr[l_cnt].xmew011 = sr_s.xmew011
       LET sr[l_cnt].xmew012 = sr_s.xmew012
       LET sr[l_cnt].xmew013 = sr_s.xmew013
       LET sr[l_cnt].xmew014 = sr_s.xmew014
       LET sr[l_cnt].xmew015 = sr_s.xmew015
       LET sr[l_cnt].xmew016 = sr_s.xmew016
       LET sr[l_cnt].xmewseq = sr_s.xmewseq
       LET sr[l_cnt].xmewsite = sr_s.xmewsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].x_t1_pmaal004 = sr_s.x_t1_pmaal004
       LET sr[l_cnt].xmesl_t_xmesl003 = sr_s.xmesl_t_xmesl003
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].oocal_t_oocal003 = sr_s.oocal_t_oocal003
       LET sr[l_cnt].x_t2_oocal003 = sr_s.x_t2_oocal003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].l_xmev004_xmesl003 = sr_s.l_xmev004_xmesl003
       LET sr[l_cnt].l_xmev001_ooag011 = sr_s.l_xmev001_ooag011
       LET sr[l_cnt].l_xmev003_pmaal003 = sr_s.l_xmev003_pmaal003
       LET sr[l_cnt].l_xmev002_ooefl003 = sr_s.l_xmev002_ooefl003
       LET sr[l_cnt].l_xmew013_pmaal004 = sr_s.l_xmew013_pmaal004
       LET sr[l_cnt].xmewent = sr_s.xmewent
       LET sr[l_cnt].xmewdocno = sr_s.xmewdocno
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].l_xmew001_desc = sr_s.l_xmew001_desc
       LET sr[l_cnt].l_xmew002_desc = sr_s.l_xmew002_desc
       LET sr[l_cnt].l_xmew016_show = sr_s.l_xmew016_show
       LET sr[l_cnt].l_detail02_show = sr_s.l_detail02_show
       LET sr[l_cnt].l_detail03_show = sr_s.l_detail03_show
       LET sr[l_cnt].l_detail04_show = sr_s.l_detail04_show
       LET sr[l_cnt].l_xmev019_show = sr_s.l_xmev019_show
       LET sr[l_cnt].l_xmev008_desc = sr_s.l_xmev008_desc
       LET sr[l_cnt].pmaal_t_pmaal006 = sr_s.pmaal_t_pmaal006
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].xmev020 = sr_s.xmev020
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr400_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr400_g01_rep_data()
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
          START REPORT axmr400_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr400_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr400_g01_rep
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
 
{<section id="axmr400_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr400_g01_rep(sr1)
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
DEFINE sr3       sr3_r
DEFINE sr4       sr4_r
DEFINE l_subrep05_show   LIKE type_t.chr1
DEFINE l_subrep06_show   LIKE type_t.chr1
DEFINE l_imaal004_show   LIKE type_t.chr1      #161031-00024#8 Add By ken 170206
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmevdocno,sr1.xmewseq
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
        BEFORE GROUP OF sr1.xmevdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmevdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmevent=' ,sr1.xmevent,'{+}xmevdocno=' ,sr1.xmevdocno         
            CALL cl_gr_init_apr(sr1.xmevdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmevdocno.before name="rep.b_group.xmevdocno.before"
           #161031-00024#8 Add By Ken 170206(S)
           #規格若為空，則隱藏
           INITIALIZE l_imaal004_show TO NULL
           IF cl_null(sr1.x_imaal_t_imaal004) THEN
              LET l_imaal004_show = 'N'
           ELSE
              LET l_imaal004_show = 'Y'
           END IF
           PRINTX l_imaal004_show
           #161031-00024#8 Add By Ken 170206(E) 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmevent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmevdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr400_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr400_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr400_g01_subrep01
           DECLARE axmr400_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr400_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr400_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr400_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr400_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmevdocno.after name="rep.b_group.xmevdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmewseq
 
           #add-point:rep.b_group.xmewseq.before name="rep.b_group.xmewseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmewseq.after name="rep.b_group.xmewseq.after"
           
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
                sr1.xmevent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmevdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmewseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr400_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr400_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr400_g01_subrep02
           DECLARE axmr400_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr400_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr400_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr400_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr400_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.xmevent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmevdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmewseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr400_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr400_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr400_g01_subrep03
           DECLARE axmr400_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr400_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr400_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr400_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr400_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
 
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
 
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmevdocno
 
           #add-point:rep.a_group.xmevdocno.before name="rep.a_group.xmevdocno.before"
           START REPORT axmr400_g01_subrep05
              IF tm.a1 ="Y" THEN
                 #161109-00085#11-mod-s
#                 LET g_sql = "SELECT *",   #161109-00085#11   mark
                 LET g_sql = "SELECT xmexent,xmexsite,xmexdocno,xmexseq,xmex001,xmex002,xmex003,xmex004,xmex005,xmex006,
                                     xmex007,xmex008,xmex009,xmex010,xmex011,xmex012,xmex013,xmex014",
                             "  FROM xmex_t ",
                             " WHERE xmexdocno = '",sr1.xmevdocno CLIPPED,"'",
                             "   AND xmexent   = '",sr1.xmevent   CLIPPED,"'",                             
                             "   ORDER BY xmexseq "
                 #161109-00085#11-mod-e
                 DECLARE axmr400_g01_repcur05 CURSOR FROM g_sql
                 #161109-00085#11-s mod
#                 FOREACH axmr400_g01_repcur05 INTO sr3.xmex.*   #161109-00085#11-s mark
                 FOREACH axmr400_g01_repcur05 INTO sr3.xmex.xmexent,sr3.xmex.xmexsite,sr3.xmex.xmexdocno,sr3.xmex.xmexseq,sr3.xmex.xmex001,
                                                   sr3.xmex.xmex002,sr3.xmex.xmex003,sr3.xmex.xmex004,sr3.xmex.xmex005,sr3.xmex.xmex006,
                                                   sr3.xmex.xmex007,sr3.xmex.xmex008,sr3.xmex.xmex009,sr3.xmex.xmex010,sr3.xmex.xmex011,
                                                   sr3.xmex.xmex012,sr3.xmex.xmex013,sr3.xmex.xmex014
                 #161109-00085#11-e mod
                    #品名、規格
                    SELECT imaal003,imaal004 INTO sr3.l_imaal003,sr3.l_imaal004
                      FROM imaal_t
                     WHERE imaalent = sr3.xmex.xmexent
                       AND imaal002 = g_dlang
                       AND imaal001 = sr3.xmex.xmex002
                    #工作站名
                    SELECT ecaa002 INTO sr3.l_xmex006_desc
                      FROM ecaa_t
                     WHERE ecaaent = g_enterprise
                       AND ecaasite = g_site
                       AND ecaa001 = sr3.xmex.xmex006
                    CALL axmr400_g01_desc('2','215',sr3.xmex.xmex001) RETURNING sr3.l_xmex001_desc
                    CALL axmr400_g01_desc('2','215',sr3.xmex.xmex004) RETURNING sr3.l_xmex004_desc
                    CALL axmr400_g01_show(sr3.l_imaal003,sr3.xmex.xmex007,sr3.xmex.xmex010,sr3.xmex.xmex012) RETURNING sr3.l_detail02_show
                    CALL axmr400_g01_show(sr3.l_imaal004,sr3.xmex.xmex008,sr3.xmex.xmex011,sr3.xmex.xmex013) RETURNING sr3.l_detail03_show
                    CALL axmr400_g01_show(sr3.xmex.xmex014,'','','') RETURNING sr3.l_xmex014_show
                    #161109-00085#11-s mod
#                    OUTPUT TO REPORT axmr400_g01_subrep05(sr3.*)
                    OUTPUT TO REPORT axmr400_g01_subrep05(sr3.xmex.xmexent,sr3.xmex.xmexsite,sr3.xmex.xmexdocno,sr3.xmex.xmexseq,sr3.xmex.xmex001,
                                                          sr3.xmex.xmex002,sr3.xmex.xmex003,sr3.xmex.xmex004,sr3.xmex.xmex005,sr3.xmex.xmex006,
                                                          sr3.xmex.xmex007,sr3.xmex.xmex008,sr3.xmex.xmex009,sr3.xmex.xmex010,sr3.xmex.xmex011,
                                                          sr3.xmex.xmex012,sr3.xmex.xmex013,sr3.xmex.xmex014,sr3.l_imaal003,sr3.l_imaal004,
                                                          sr3.l_xmex001_desc,sr3.l_xmex004_desc,sr3.l_xmex006_desc,sr3.l_detail02_show,
                                                          sr3.l_detail03_show,sr3.l_xmex014_show)
                    #161109-00085#11-e mod
                 END FOREACH
              END IF
           FINISH REPORT axmr400_g01_subrep05
           PRINTX l_subrep05_show
#           
           START REPORT axmr400_g01_subrep06
              LET g_sql = "SELECT xmfidocno,xmfiseq,xmfi001,xmfi002,xmfi003,xmfi004,xmfi005,xmfi006",
                          "  FROM xmfi_t ",
                          " WHERE xmfidocno = '",sr1.xmevdocno CLIPPED,"'",
                          "   AND xmfient   = '",sr1.xmevent CLIPPED,"'",
                          "   ORDER BY xmfiseq "
              DECLARE axmr400_g01_repcur06 CURSOR FROM g_sql
              #161109-00085#11-s mod
#              FOREACH axmr400_g01_repcur06 INTO sr4.*   #161109-00085#11-s mark
              FOREACH axmr400_g01_repcur06 INTO sr4.xmfidocno,sr4.xmfiseq,sr4.xmfi001,sr4.xmfi002,sr4.xmfi003,
                                                sr4.xmfi004,sr4.xmfi005,sr4.xmfi006
              #161109-00085#11-e mod
                 IF STATUS THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "axmr400_g01_repcur05:"
                    LET g_errparam.code   = SQLCA.sqlcode
                    LET g_errparam.popup  = FALSE
                    CALL cl_err()                  
                    EXIT FOREACH 
                 END IF
                 CALL s_desc_get_item_desc(sr4.xmfi001) RETURNING sr4.l_xmfi001_desc,sr4.l_xmfi001_desc_2
                 CALL s_desc_get_trading_partner_abbr_desc(sr4.xmfi005) RETURNING sr4.l_xmfi005_desc
                 #mod--160316-00002#1 By shiun--(S)
                 IF cl_null(sr4.xmfi005) THEN
                    LET sr4.l_xmfi005_desc = ''
                 ELSE
                    LET sr4.l_xmfi005_desc = sr4.xmfi005,".",sr4.l_xmfi005_desc
                 END IF
                 #mod--160316-00002#1 By shiun--(E)
                 IF NOT cl_null(sr4.xmfi006) THEN
                    LET sr4.l_xmfi006_show = "Y"
                 ELSE
                    LET sr4.l_xmfi006_show = "N"
                 END IF
                 #161109-00085#11-s mod
#                 OUTPUT TO REPORT axmr400_g01_subrep06(sr4.*)
                 OUTPUT TO REPORT axmr400_g01_subrep06(sr4.xmfidocno,sr4.xmfiseq,sr4.xmfi001,sr4.xmfi002,sr4.xmfi003,
                                                       sr4.xmfi004,sr4.xmfi005,sr4.xmfi006,sr4.l_xmfi001_desc,
                                                       sr4.l_xmfi001_desc_2,sr4.l_xmfi005_desc,sr4.l_xmfi006_show)
                 #161109-00085#11-e mod
                 INITIALIZE sr4.* TO NULL
              END FOREACH
           FINISH REPORT axmr400_g01_subrep06
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmevent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmevdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr400_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr400_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr400_g01_subrep04
           DECLARE axmr400_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr400_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr400_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr400_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr400_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmevdocno.after name="rep.a_group.xmevdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmewseq
 
           #add-point:rep.a_group.xmewseq.before name="rep.a_group.xmewseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmewseq.after name="rep.a_group.xmewseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr400_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr400_g01_subrep01(sr2)
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
PRIVATE REPORT axmr400_g01_subrep02(sr2)
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
PRIVATE REPORT axmr400_g01_subrep03(sr2)
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
PRIVATE REPORT axmr400_g01_subrep04(sr2)
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
 
{<section id="axmr400_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION axmr400_g01_desc(p_class,p_num,p_target)
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

PRIVATE FUNCTION axmr400_g01_show(p_arg1,p_arg2,p_arg3,p_arg4)
   DEFINE p_arg1 LIKE type_t.chr1000
   DEFINE p_arg2 LIKE type_t.chr1000
   DEFINE p_arg3 LIKE type_t.chr1000
   DEFINE p_arg4 LIKE type_t.chr1000
   DEFINE r_show LIKE type_t.chr1
   
      IF cl_null(p_arg1) AND cl_null(p_arg2) AND cl_null(p_arg3) AND cl_null(p_arg4) THEN
         LET r_show = "N"
      ELSE
         LET r_show = "Y"
      END IF
      RETURN r_show
END FUNCTION

PRIVATE FUNCTION axmr400_g01_initialize(p_arg,p_exp)
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
 
{<section id="axmr400_g01.other_report" readonly="Y" >}

PRIVATE REPORT axmr400_g01_subrep05(sr3)
     DEFINE sr3 sr3_r  
     ORDER EXTERNAL BY sr3.xmex.xmexdocno
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.*
        PRINTX sr3.*        
END REPORT

PRIVATE REPORT axmr400_g01_subrep06(sr4)
     DEFINE sr4 sr4_r   
     ORDER EXTERNAL BY sr4.xmfidocno
     FORMAT
        ON EVERY ROW       
        PRINTX g_grNumFmt.*
        PRINTX sr4.*        
END REPORT

 
{</section>}
 
