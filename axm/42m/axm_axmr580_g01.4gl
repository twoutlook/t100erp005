#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr580_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-01-16 14:44:00), PR版次:0003(2017-01-16 15:01:14)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axmr580_g01
#+ Description: ...
#+ Creator....: 05384(2016-11-10 15:39:42)
#+ Modifier...: 09042 -SD/PR- 09042
 
{</section>}
 
{<section id="axmr580_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#25  2016/08/5  By 08742    系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                        Mod   axmr580_g01_temp--> axmr540_tmp01
#161207-00033#14  2016/12/21 By 08992    一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
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
   xmdk000 LIKE xmdk_t.xmdk000, 
   xmdk001 LIKE xmdk_t.xmdk001, 
   xmdk002 LIKE xmdk_t.xmdk002, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk005 LIKE xmdk_t.xmdk005, 
   xmdk006 LIKE xmdk_t.xmdk006, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk008 LIKE xmdk_t.xmdk008, 
   xmdk009 LIKE xmdk_t.xmdk009, 
   xmdk010 LIKE xmdk_t.xmdk010, 
   xmdk011 LIKE xmdk_t.xmdk011, 
   xmdk012 LIKE xmdk_t.xmdk012, 
   xmdk013 LIKE xmdk_t.xmdk013, 
   xmdk014 LIKE xmdk_t.xmdk014, 
   xmdk015 LIKE xmdk_t.xmdk015, 
   xmdk016 LIKE xmdk_t.xmdk016, 
   xmdk017 LIKE xmdk_t.xmdk017, 
   xmdk018 LIKE xmdk_t.xmdk018, 
   xmdk019 LIKE xmdk_t.xmdk019, 
   xmdk020 LIKE xmdk_t.xmdk020, 
   xmdk021 LIKE xmdk_t.xmdk021, 
   xmdk022 LIKE xmdk_t.xmdk022, 
   xmdk023 LIKE xmdk_t.xmdk023, 
   xmdk024 LIKE xmdk_t.xmdk024, 
   xmdk025 LIKE xmdk_t.xmdk025, 
   xmdk026 LIKE xmdk_t.xmdk026, 
   xmdk027 LIKE xmdk_t.xmdk027, 
   xmdk028 LIKE xmdk_t.xmdk028, 
   xmdk029 LIKE xmdk_t.xmdk029, 
   xmdk030 LIKE xmdk_t.xmdk030, 
   xmdk031 LIKE xmdk_t.xmdk031, 
   xmdk032 LIKE xmdk_t.xmdk032, 
   xmdk033 LIKE xmdk_t.xmdk033, 
   xmdk034 LIKE xmdk_t.xmdk034, 
   xmdk035 LIKE xmdk_t.xmdk035, 
   xmdk036 LIKE xmdk_t.xmdk036, 
   xmdk037 LIKE xmdk_t.xmdk037, 
   xmdk038 LIKE xmdk_t.xmdk038, 
   xmdk039 LIKE xmdk_t.xmdk039, 
   xmdk040 LIKE xmdk_t.xmdk040, 
   xmdk054 LIKE xmdk_t.xmdk054, 
   xmdk083 LIKE xmdk_t.xmdk083, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkent LIKE xmdk_t.xmdkent, 
   xmdksite LIKE xmdk_t.xmdksite, 
   xmdkstus LIKE xmdk_t.xmdkstus, 
   xmdkunit LIKE xmdk_t.xmdkunit, 
   xmdl001 LIKE xmdl_t.xmdl001, 
   xmdl002 LIKE xmdl_t.xmdl002, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmdl004 LIKE xmdl_t.xmdl004, 
   xmdl005 LIKE xmdl_t.xmdl005, 
   xmdl006 LIKE xmdl_t.xmdl006, 
   xmdl007 LIKE xmdl_t.xmdl007, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   xmdl009 LIKE xmdl_t.xmdl009, 
   xmdl010 LIKE xmdl_t.xmdl010, 
   xmdl011 LIKE xmdl_t.xmdl011, 
   xmdl012 LIKE xmdl_t.xmdl012, 
   xmdl013 LIKE xmdl_t.xmdl013, 
   xmdl014 LIKE xmdl_t.xmdl014, 
   xmdl015 LIKE xmdl_t.xmdl015, 
   xmdl016 LIKE xmdl_t.xmdl016, 
   xmdl017 LIKE xmdl_t.xmdl017, 
   xmdl018 LIKE xmdl_t.xmdl018, 
   xmdl019 LIKE xmdl_t.xmdl019, 
   xmdl020 LIKE xmdl_t.xmdl020, 
   xmdl021 LIKE xmdl_t.xmdl021, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl023 LIKE xmdl_t.xmdl023, 
   xmdl024 LIKE xmdl_t.xmdl024, 
   xmdl025 LIKE xmdl_t.xmdl025, 
   xmdl026 LIKE xmdl_t.xmdl026, 
   xmdl027 LIKE xmdl_t.xmdl027, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xmdl029 LIKE xmdl_t.xmdl029, 
   xmdl030 LIKE xmdl_t.xmdl030, 
   xmdl031 LIKE xmdl_t.xmdl031, 
   xmdl032 LIKE xmdl_t.xmdl032, 
   xmdl033 LIKE xmdl_t.xmdl033, 
   xmdl034 LIKE xmdl_t.xmdl034, 
   xmdl035 LIKE xmdl_t.xmdl035, 
   xmdl036 LIKE xmdl_t.xmdl036, 
   xmdl037 LIKE xmdl_t.xmdl037, 
   xmdl041 LIKE xmdl_t.xmdl041, 
   xmdl042 LIKE xmdl_t.xmdl042, 
   xmdl043 LIKE xmdl_t.xmdl043, 
   xmdl044 LIKE xmdl_t.xmdl044, 
   xmdl045 LIKE xmdl_t.xmdl045, 
   xmdl046 LIKE xmdl_t.xmdl046, 
   xmdl050 LIKE xmdl_t.xmdl050, 
   xmdl051 LIKE xmdl_t.xmdl051, 
   xmdl087 LIKE xmdl_t.xmdl087, 
   xmdl088 LIKE xmdl_t.xmdl088, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdlsite LIKE xmdl_t.xmdlsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   t7_pmaal003 LIKE pmaal_t.pmaal003, 
   t8_pmaal003 LIKE pmaal_t.pmaal003, 
   t9_pmaal003 LIKE pmaal_t.pmaal003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   xmahl_t_xmahl003 LIKE xmahl_t.xmahl003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t13_oocal003 LIKE oocal_t.oocal003, 
   x_t14_oocal003 LIKE oocal_t.oocal003, 
   l_xmdk003_ooag011 LIKE type_t.chr300, 
   l_xmdk009_pmaal003 LIKE type_t.chr300, 
   l_xmdk008_pmaal003 LIKE type_t.chr300, 
   l_xmdk020_pmaal003 LIKE type_t.chr300, 
   l_xmdk004_ooefl003 LIKE type_t.chr1000, 
   l_xmdk007_pmaal003 LIKE type_t.chr300, 
   pmaal_t_pmaal006 LIKE pmaal_t.pmaal006, 
   t9_pmaal006 LIKE pmaal_t.pmaal006, 
   t8_pmaal006 LIKE pmaal_t.pmaal006, 
   t7_pmaal006 LIKE pmaal_t.pmaal006, 
   l_xmdl015_inab003 LIKE type_t.chr1000, 
   l_address LIKE type_t.chr200, 
   l_imaal004 LIKE type_t.chr30, 
   l_xmdk030_desc LIKE type_t.chr80, 
   l_xmda033 LIKE type_t.chr20, 
   l_xmdl014_inayl003 LIKE type_t.chr1000, 
   l_xmdk022_desc LIKE oocql_t.oocql004, 
   l_pmaj002_desc LIKE pmaj_t.pmaj012, 
   l_xmdk007_tel LIKE oofc_t.oofc012, 
   l_xmdk007_fax LIKE oofc_t.oofc012, 
   t8_pmaal004 LIKE pmaal_t.pmaal004, 
   t9_pmaal004 LIKE pmaal_t.pmaal004, 
   t7_pmaal004 LIKE pmaal_t.pmaal004, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmdl081 LIKE xmdl_t.xmdl081, 
   xmdl083 LIKE xmdl_t.xmdl083
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1,         #列印多庫儲批 
       a2 LIKE type_t.chr1          #列印批序說明
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
   #子報表1資料
   xmdmdocno     LIKE xmdm_t.xmdmdocno, #出貨單號
   xmdmseq       LIKE xmdm_t.xmdmseq,   #項次
   xmdmseq1      LIKE xmdm_t.xmdmseq1,  #項序
   xmdm005       LIKE xmdm_t.xmdm005,   #庫位
   xmdm006       LIKE xmdm_t.xmdm006,   #儲位 
   xmdm007       LIKE xmdm_t.xmdm007,   #批號
   xmdm009       LIKE xmdm_t.xmdm009,   #數量
   xmdm008       LIKE xmdm_t.xmdm008,   #單位
   xmdment       LIKE xmdm_t.xmdment,   #企業編號
   l_xmdm005_inayl003 LIKE type_t.chr1000,  #庫位.名稱
   l_xmdm006_inab003  LIKE type_t.chr1000   #儲位.名稱

END RECORD  

TYPE sr4_r RECORD  
   #子報表2資料
   inaodocno     LIKE inao_t.inaodocno, #單號
   inaoseq       LIKE inao_t.inaoseq,   #項次
   inaoseq1      LIKE inao_t.inaoseq1,  #項序
   inaoseq2      LIKE inao_t.inaoseq2,  #序號
   inao008       LIKE inao_t.inao008,   #製造批號
   inao009       LIKE inao_t.inao009,   #製造序號
   inao012       LIKE inao_t.inao012,   #數量
   inao010       LIKE inao_t.inao010,   #製造日期
   inao011       LIKE inao_t.inao011    #有效日期
   
END RECORD   
#add--2015/08/11 By shiun--(S)
TYPE sr6_r RECORD 
   xmao001        LIKE xmao_t.xmao001,          #客戶編號
   xmao002        LIKE xmao_t.xmao002,          #嘜頭編號
   xmap003        LIKE xmap_t.xmap003,          #類別
   xmap004        LIKE xmap_t.xmap004,          #行序
   xmap005        LIKE xmap_t.xmap005,          #資料類型
   xmap006        LIKE xmap_t.xmap006,          #資料內容
   l_xmap003_desc LIKE type_t.chr500,           #類別說明
   l_xmap005_desc LIKE type_t.chr500,           #資料內容說明
   l_xmap003_show LIKE type_t.chr1              #類別顯示否
END RECORD
TYPE sr7_r RECORD 
   xmao001          LIKE xmao_t.xmao001,          #客戶編號
   xmao002          LIKE xmao_t.xmao002,          #嘜頭編號
   xmap006_1        LIKE xmap_t.xmap006,          #資料內容
   xmap006_2        LIKE xmap_t.xmap006,          #資料內容
   l_xmap003_desc_1 LIKE type_t.chr500,           #類別說明
   l_xmap003_desc_2 LIKE type_t.chr500#,           #類別說明
#   l_xmap003_show_1 LIKE type_t.chr500,           #類別顯示否
#   l_xmap003_show_2 LIKE type_t.chr500            #類別顯示否
END RECORD
TYPE sr8_r RECORD
   xmao001          LIKE xmao_t.xmao001,          #客戶編號
   xmao002          LIKE xmao_t.xmao002,          #嘜頭編號
   xmap006_1        LIKE xmap_t.xmap006,          #資料內容
   xmap006_2        LIKE xmap_t.xmap006,          #資料內容
   l_xmap003_desc_1 LIKE type_t.chr500,           #類別說明
   l_xmap003_desc_2 LIKE type_t.chr500#,           #類別說明
#   l_xmap003_show_1 LIKE type_t.chr500,           #類別顯示否
#   l_xmap003_show_2 LIKE type_t.chr500            #類別顯示否
END RECORD
DEFINE sr8 DYNAMIC ARRAY OF sr8_r
#add--2015/08/11 By shiun--(E)
#end add-point
 
{</section>}
 
{<section id="axmr580_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr580_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  列印多庫儲批 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  列印批序說明
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
DEFINE  l_success LIKE type_t.num5
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL s_axmi210_cre_tmp_table() RETURNING l_success #add--2015/08/11 By shiun
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axmr580_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr580_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr580_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr580_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr580_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr580_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
       LET g_select = " SELECT xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,xmdk005,xmdk006,xmdk007,xmdk008,xmdk009, 
       xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,xmdk021, 
       xmdk022,xmdk023,xmdk024,xmdk025,xmdk026,xmdk027,xmdk028,xmdk029,xmdk030,xmdk031,xmdk032,xmdk033, 
       xmdk034,xmdk035,xmdk036,xmdk037,xmdk038,xmdk039,xmdk040,xmdk054,xmdk083,xmdkdocdt,xmdkdocno,xmdkent, 
       xmdksite,xmdkstus,xmdkunit,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007,xmdl008,xmdl009, 
       xmdl010,xmdl011,xmdl012,xmdl013,xmdl014,xmdl015,xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,xmdl021, 
       xmdl022,xmdl023,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,xmdl031,xmdl032,xmdl033, 
       xmdl034,xmdl035,xmdl036,xmdl037,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,xmdl046,xmdl050,xmdl051, 
       xmdl087,xmdl088,xmdlseq,xmdlsite,ooag_t.ooag011,ooefl_t.ooefl003,pmaal_t.pmaal003,t7.pmaal003, 
       t8.pmaal003,t9.pmaal003,ooibl_t.ooibl004,ooail_t.ooail003,xmahl_t.xmahl003,ooidl_t.ooidl003,x.imaal_t_imaal003, 
       x.inab_t_inab003,x.oocal_t_oocal003,x.t13_oocal003,x.t14_oocal003,
       trim(xmdk003)||'.'||trim(ooag_t.ooag011), 
       trim(xmdk009)||'.'||trim(t9.pmaal003),
       trim(xmdk008)||'.'||trim(t8.pmaal003),
       trim(xmdk020)||'.'||trim(pmaal_t.pmaal003), 
       trim(xmdk004)||'.'||trim(ooefl_t.ooefl003),
       trim(xmdk007)||'.'||trim(t7.pmaal003),
       pmaal_t.pmaal006, t9.pmaal006,t8.pmaal006,t7.pmaal006,
       CASE WHEN COALESCE(x.inab_t_inab003,' ') = ' ' THEN xmdl015 ELSE trim(xmdl015)||'.'||trim(x.inab_t_inab003) END,
       NULL,NULL,NULL,NULL,     
       CASE WHEN COALESCE(x.inayl_t_inayl003,' ') = ' ' THEN xmdl014 ELSE trim(xmdl014)||'.'||trim(x.inayl_t_inayl003) END,       
       '','','','',t8.pmaal004,t9.pmaal004,t7.pmaal004,x.imaal_t_imaal004,xmdl081,xmdl083"  #170111-00045#1
       #160422-00014#20 s983961--add(e)
#   #end add-point
#   LET g_select = " SELECT xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,xmdk005,xmdk006,xmdk007,xmdk008,xmdk009, 
#       xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,xmdk021, 
#       xmdk022,xmdk023,xmdk024,xmdk025,xmdk026,xmdk027,xmdk028,xmdk029,xmdk030,xmdk031,xmdk032,xmdk033, 
#       xmdk034,xmdk035,xmdk036,xmdk037,xmdk038,xmdk039,xmdk040,xmdk054,xmdk083,xmdkdocdt,xmdkdocno,xmdkent, 
#       xmdksite,xmdkstus,xmdkunit,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007,xmdl008,xmdl009, 
#       xmdl010,xmdl011,xmdl012,xmdl013,xmdl014,xmdl015,xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,xmdl021, 
#       xmdl022,xmdl023,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,xmdl031,xmdl032,xmdl033, 
#       xmdl034,xmdl035,xmdl036,xmdl037,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,xmdl046,xmdl050,xmdl051, 
#       xmdl087,xmdl088,xmdlseq,xmdlsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdk_t.xmdk003 AND ooag_t.ooagent = xmdk_t.xmdkent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdk_t.xmdk004 AND ooefl_t.ooeflent = xmdk_t.xmdkent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk020 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk007 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk008 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk009 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmdk_t.xmdk010 AND ooibl_t.ooiblent = xmdk_t.xmdkent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmdk_t.xmdk016 AND ooail_t.ooailent = xmdk_t.xmdkent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT xmahl003 FROM xmahl_t WHERE xmahl_t.xmahl001 = xmdk_t.xmdk018 AND xmahl_t.xmahlent = xmdk_t.xmdkent AND xmahl_t.xmahl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooidl003 FROM ooidl_t WHERE ooidl_t.ooidl001 = xmdk_t.xmdk019 AND ooidl_t.ooidlent = xmdk_t.xmdkent AND ooidl_t.ooidl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.inab_t_inab003,x.oocal_t_oocal003,x.t13_oocal003,x.t14_oocal003, 
#       trim(xmdk003)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdk_t.xmdk003 AND ooag_t.ooagent = xmdk_t.xmdkent)), 
#       trim(xmdk009)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk009 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdk008)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk008 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdk020)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk020 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdk004)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdk_t.xmdk004 AND ooefl_t.ooeflent = xmdk_t.xmdkent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(xmdk007)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk007 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk020 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk009 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk008 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal006 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk007 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),trim(xmdl015)||'.'||trim(x.inab_t_inab003),NULL,NULL,NULL,NULL,'','','','','', 
#       ( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk008 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk009 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk007 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal004,xmdl081,xmdl083"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM xmdk_t LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = xmdk_t.xmdk003 AND ooag_t.ooagent = xmdk_t.xmdkent   LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = xmdk_t.xmdk020 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = xmdk_t.xmdk004 AND ooefl_t.ooeflent = xmdk_t.xmdkent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t7 ON t7.pmaal001 = xmdk_t.xmdk007 AND t7.pmaalent = xmdk_t.xmdkent AND t7.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t8 ON t8.pmaal001 = xmdk_t.xmdk008 AND t8.pmaalent = xmdk_t.xmdkent AND t8.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t9 ON t9.pmaal001 = xmdk_t.xmdk009 AND t9.pmaalent = xmdk_t.xmdkent AND t9.pmaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = xmdk_t.xmdk010 AND ooibl_t.ooiblent = xmdk_t.xmdkent AND ooibl_t.ooibl003 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = xmdk_t.xmdk016 AND ooail_t.ooailent = xmdk_t.xmdkent AND ooail_t.ooail002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN xmahl_t ON xmahl_t.xmahl001 = xmdk_t.xmdk018 AND xmahl_t.xmahlent = xmdk_t.xmdkent AND xmahl_t.xmahl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = xmdk_t.xmdk019 AND ooidl_t.ooidlent = xmdk_t.xmdkent AND ooidl_t.ooidl002 = '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT xmdl_t.*,inayl003 inayl_t_inayl003,imaal_t.imaal003 imaal_t_imaal003,imaal_t.imaal004 imaal_t_imaal004 ,
        inab_t.inab003 inab_t_inab003,oocal_t.oocal003 oocal_t_oocal003,t13.oocal003 t13_oocal003,t14.oocal003 t14_oocal003,xmda033 FROM xmdl_t LEFT OUTER JOIN xmda_t ON xmda_t.xmdadocno = xmdl_t.xmdl003 AND xmda_t.xmdaent = xmdl_t.xmdlent             LEFT OUTER JOIN inab_t ON inab_t.inabsite = xmdl_t.xmdlsite AND inab_t.inab001 = xmdl_t.xmdl014 AND inab_t.inab002 = xmdl_t.xmdl015 AND inab_t.inabent = xmdl_t.xmdlent             LEFT OUTER JOIN inayl_t ON inayl001 = xmdl_t.xmdl014 AND inaylent = xmdl_t.xmdlent AND inayl002 = '" ,
        g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xmdl_t.xmdl008 AND imaal_t.imaalent = xmdl_t.xmdlent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xmdl_t.xmdl021 AND oocal_t.oocalent = xmdl_t.xmdlent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t13 ON t13.oocal001 = xmdl_t.xmdl019 AND t13.oocalent = xmdl_t.xmdlent AND t13.oocal002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t14 ON t14.oocal001 = xmdl_t.xmdl017 AND t14.oocalent = xmdl_t.xmdlent AND t14.oocal002 = '" , 
        g_dlang,"'" ," ) x  ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdkdocno = x.xmdldocno"

#   #end add-point
#    LET g_from = " FROM xmdk_t LEFT OUTER JOIN ( SELECT xmdl_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdl_t.xmdl008 AND imaal_t.imaalent = xmdl_t.xmdlent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT inab003 FROM inab_t WHERE inab_t.inabsite = xmdl_t.xmdlsite AND inab_t.inab001 = xmdl_t.xmdl014 AND inab_t.inab002 = xmdl_t.xmdl015 AND inab_t.inabent = xmdl_t.xmdlent) inab_t_inab003, 
#        ( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmdl_t.xmdl021 AND oocal_t.oocalent = xmdl_t.xmdlent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmdl_t.xmdl019 AND oocal_t.oocalent = xmdl_t.xmdlent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t13_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmdl_t.xmdl017 AND oocal_t.oocalent = xmdl_t.xmdlent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t14_oocal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = xmdl_t.xmdl008 AND imaal_t.imaalent = xmdl_t.xmdlent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM xmdl_t ) x  ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdkdocno  
#        = x.xmdldocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE xmdk_t.xmdk000 = '4' AND " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xmdkdocno,xmdlseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr580_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr580_g01_curs CURSOR FOR axmr580_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr580_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr580_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmdk000 LIKE xmdk_t.xmdk000, 
   xmdk001 LIKE xmdk_t.xmdk001, 
   xmdk002 LIKE xmdk_t.xmdk002, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk005 LIKE xmdk_t.xmdk005, 
   xmdk006 LIKE xmdk_t.xmdk006, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk008 LIKE xmdk_t.xmdk008, 
   xmdk009 LIKE xmdk_t.xmdk009, 
   xmdk010 LIKE xmdk_t.xmdk010, 
   xmdk011 LIKE xmdk_t.xmdk011, 
   xmdk012 LIKE xmdk_t.xmdk012, 
   xmdk013 LIKE xmdk_t.xmdk013, 
   xmdk014 LIKE xmdk_t.xmdk014, 
   xmdk015 LIKE xmdk_t.xmdk015, 
   xmdk016 LIKE xmdk_t.xmdk016, 
   xmdk017 LIKE xmdk_t.xmdk017, 
   xmdk018 LIKE xmdk_t.xmdk018, 
   xmdk019 LIKE xmdk_t.xmdk019, 
   xmdk020 LIKE xmdk_t.xmdk020, 
   xmdk021 LIKE xmdk_t.xmdk021, 
   xmdk022 LIKE xmdk_t.xmdk022, 
   xmdk023 LIKE xmdk_t.xmdk023, 
   xmdk024 LIKE xmdk_t.xmdk024, 
   xmdk025 LIKE xmdk_t.xmdk025, 
   xmdk026 LIKE xmdk_t.xmdk026, 
   xmdk027 LIKE xmdk_t.xmdk027, 
   xmdk028 LIKE xmdk_t.xmdk028, 
   xmdk029 LIKE xmdk_t.xmdk029, 
   xmdk030 LIKE xmdk_t.xmdk030, 
   xmdk031 LIKE xmdk_t.xmdk031, 
   xmdk032 LIKE xmdk_t.xmdk032, 
   xmdk033 LIKE xmdk_t.xmdk033, 
   xmdk034 LIKE xmdk_t.xmdk034, 
   xmdk035 LIKE xmdk_t.xmdk035, 
   xmdk036 LIKE xmdk_t.xmdk036, 
   xmdk037 LIKE xmdk_t.xmdk037, 
   xmdk038 LIKE xmdk_t.xmdk038, 
   xmdk039 LIKE xmdk_t.xmdk039, 
   xmdk040 LIKE xmdk_t.xmdk040, 
   xmdk054 LIKE xmdk_t.xmdk054, 
   xmdk083 LIKE xmdk_t.xmdk083, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkent LIKE xmdk_t.xmdkent, 
   xmdksite LIKE xmdk_t.xmdksite, 
   xmdkstus LIKE xmdk_t.xmdkstus, 
   xmdkunit LIKE xmdk_t.xmdkunit, 
   xmdl001 LIKE xmdl_t.xmdl001, 
   xmdl002 LIKE xmdl_t.xmdl002, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmdl004 LIKE xmdl_t.xmdl004, 
   xmdl005 LIKE xmdl_t.xmdl005, 
   xmdl006 LIKE xmdl_t.xmdl006, 
   xmdl007 LIKE xmdl_t.xmdl007, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   xmdl009 LIKE xmdl_t.xmdl009, 
   xmdl010 LIKE xmdl_t.xmdl010, 
   xmdl011 LIKE xmdl_t.xmdl011, 
   xmdl012 LIKE xmdl_t.xmdl012, 
   xmdl013 LIKE xmdl_t.xmdl013, 
   xmdl014 LIKE xmdl_t.xmdl014, 
   xmdl015 LIKE xmdl_t.xmdl015, 
   xmdl016 LIKE xmdl_t.xmdl016, 
   xmdl017 LIKE xmdl_t.xmdl017, 
   xmdl018 LIKE xmdl_t.xmdl018, 
   xmdl019 LIKE xmdl_t.xmdl019, 
   xmdl020 LIKE xmdl_t.xmdl020, 
   xmdl021 LIKE xmdl_t.xmdl021, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl023 LIKE xmdl_t.xmdl023, 
   xmdl024 LIKE xmdl_t.xmdl024, 
   xmdl025 LIKE xmdl_t.xmdl025, 
   xmdl026 LIKE xmdl_t.xmdl026, 
   xmdl027 LIKE xmdl_t.xmdl027, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xmdl029 LIKE xmdl_t.xmdl029, 
   xmdl030 LIKE xmdl_t.xmdl030, 
   xmdl031 LIKE xmdl_t.xmdl031, 
   xmdl032 LIKE xmdl_t.xmdl032, 
   xmdl033 LIKE xmdl_t.xmdl033, 
   xmdl034 LIKE xmdl_t.xmdl034, 
   xmdl035 LIKE xmdl_t.xmdl035, 
   xmdl036 LIKE xmdl_t.xmdl036, 
   xmdl037 LIKE xmdl_t.xmdl037, 
   xmdl041 LIKE xmdl_t.xmdl041, 
   xmdl042 LIKE xmdl_t.xmdl042, 
   xmdl043 LIKE xmdl_t.xmdl043, 
   xmdl044 LIKE xmdl_t.xmdl044, 
   xmdl045 LIKE xmdl_t.xmdl045, 
   xmdl046 LIKE xmdl_t.xmdl046, 
   xmdl050 LIKE xmdl_t.xmdl050, 
   xmdl051 LIKE xmdl_t.xmdl051, 
   xmdl087 LIKE xmdl_t.xmdl087, 
   xmdl088 LIKE xmdl_t.xmdl088, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdlsite LIKE xmdl_t.xmdlsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   t7_pmaal003 LIKE pmaal_t.pmaal003, 
   t8_pmaal003 LIKE pmaal_t.pmaal003, 
   t9_pmaal003 LIKE pmaal_t.pmaal003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   xmahl_t_xmahl003 LIKE xmahl_t.xmahl003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t13_oocal003 LIKE oocal_t.oocal003, 
   x_t14_oocal003 LIKE oocal_t.oocal003, 
   l_xmdk003_ooag011 LIKE type_t.chr300, 
   l_xmdk009_pmaal003 LIKE type_t.chr300, 
   l_xmdk008_pmaal003 LIKE type_t.chr300, 
   l_xmdk020_pmaal003 LIKE type_t.chr300, 
   l_xmdk004_ooefl003 LIKE type_t.chr1000, 
   l_xmdk007_pmaal003 LIKE type_t.chr300, 
   pmaal_t_pmaal006 LIKE pmaal_t.pmaal006, 
   t9_pmaal006 LIKE pmaal_t.pmaal006, 
   t8_pmaal006 LIKE pmaal_t.pmaal006, 
   t7_pmaal006 LIKE pmaal_t.pmaal006, 
   l_xmdl015_inab003 LIKE type_t.chr1000, 
   l_address LIKE type_t.chr200, 
   l_imaal004 LIKE type_t.chr30, 
   l_xmdk030_desc LIKE type_t.chr80, 
   l_xmda033 LIKE type_t.chr20, 
   l_xmdl014_inayl003 LIKE type_t.chr1000, 
   l_xmdk022_desc LIKE oocql_t.oocql004, 
   l_pmaj002_desc LIKE pmaj_t.pmaj012, 
   l_xmdk007_tel LIKE oofc_t.oofc012, 
   l_xmdk007_fax LIKE oofc_t.oofc012, 
   t8_pmaal004 LIKE pmaal_t.pmaal004, 
   t9_pmaal004 LIKE pmaal_t.pmaal004, 
   t7_pmaal004 LIKE pmaal_t.pmaal004, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmdl081 LIKE xmdl_t.xmdl081, 
   xmdl083 LIKE xmdl_t.xmdl083
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success       LIKE type_t.chr1
DEFINE l_pmaa027       LIKE pmaa_t.pmaa027
#add--2015/0813 By shiun--(S)
DEFINE l_oofb171_n1    STRING
DEFINE l_oofb171_n2    STRING
DEFINE l_oofb171_n3    STRING
DEFINE l_oofb171       STRING
DEFINE l_pmaj002       LIKE pmaj_t.pmaj002
#add--2015/0813 By shiun--(E)
#add--2015/08/13 By shiun--(S)
DEFINE l_xmda033      LIKE xmda_t.xmda033
DEFINE l_xmdk023_desc LIKE type_t.chr200
DEFINE l_xmdk024_desc LIKE type_t.chr200
DEFINE l_oocq019       LIKE oocq_t.oocq019
#add--2015/08/13 By shiun--(E)
DEFINE r_pmak003       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#14 add
DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#14 add
DEFINE l_sql1           STRING                                   #161207-00033#14 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #161207-00033#14-s add
    LET l_sql1 = "SELECT pmaa004 FROM pmaa_t ",
               " WHERE pmaaent ='",g_enterprise,"'",
               "   AND pmaa001 = ?  "
    PREPARE axmr580_pb FROM l_sql1
    #161207-00033#14-e add
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr580_g01_curs INTO sr_s.*
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
       #add--2015/07/14 By shiun--(S)
       #運輸方式
       CALL s_desc_get_acc_desc('263',sr_s.xmdk022) RETURNING sr_s.l_xmdk022_desc
       #add--2015/07/14 By shiun--(S)
       #銷售通路說明
       CALL axmr580_g01_xmdk030_ref(sr_s.xmdkent,sr_s.xmdk030)
            RETURNING sr_s.l_xmdk030_desc       
       
       #帶出送貨地址
       LET l_pmaa027 = ''
       SELECT pmaa027 INTO l_pmaa027
         FROM pmaa_t
        WHERE pmaaent = g_enterprise
          AND pmaa001 = sr_s.xmdk009  
       
       IF NOT cl_null(sr_s.xmdk021) THEN             
          CALL s_aooi350_get_address(l_pmaa027,sr_s.xmdk021,g_lang)RETURNING l_success,l_oofb171
       END IF
       #add--2015/08/13 By shiun--(S)
       #抓第一段地址-郵遞區號
       LET l_oofb171_n1 = l_oofb171.getIndexOf("\r\n",1)          
       IF l_oofb171_n1 <> 1 THEN
          LET l_oofb171_n3 = l_oofb171.subString(1,l_oofb171_n1-1)
          LET sr_s.l_address = l_oofb171_n3
       END IF
       #抓第二段地址-州/省 + 縣/市 + 行政區         
       LET l_oofb171_n2 = l_oofb171.getIndexOf("\r\n",l_oofb171_n1+1)  #抓第二個\r\n
       LET l_oofb171_n3 = l_oofb171.subString(l_oofb171_n1+2,l_oofb171_n2-1)
       IF NOT cl_null(l_oofb171_n3) THEN
          #此段判斷僅用來讓字串不要有多餘的空白          
          IF cl_null(sr_s.l_address) THEN
             LET sr_s.l_address = l_oofb171_n3
          ELSE
             LET sr_s.l_address = sr_s.l_address,' ',l_oofb171_n3
          END IF
       END IF
       #抓第三段地址-地址
       LET l_oofb171_n1 = l_oofb171_n2 
       LET l_oofb171_n2 = l_oofb171.getLength()
       LET l_oofb171_n3 = l_oofb171.subString(l_oofb171_n1+2,l_oofb171_n2)
       IF NOT cl_null(l_oofb171_n3) THEN
          #此段判斷僅用來讓字串不要有多餘的空白   
          IF cl_null(sr_s.l_address) THEN
             LET sr_s.l_address = l_oofb171_n3
          ELSE
             LET sr_s.l_address = sr_s.l_address,' ',l_oofb171_n3
          END IF
       END IF
       #客戶連絡人
       LET l_pmaj002 = ''
       LET sr_s.l_pmaj002_desc = ''
       SELECT pmaj002 INTO l_pmaj002
         FROM pmaj_t 
        WHERE pmajent = g_enterprise
          AND pmaj001 = sr_s.xmdk007
          AND pmajstus = 'Y' 
          AND pmaj004 = 'Y'   
       
       IF cl_null(sr_s.xmdk007) OR cl_null(l_pmaj002) THEN
          LET sr_s.l_pmaj002_desc = ''
       ELSE
          SELECT pmaj012 INTO sr_s.l_pmaj002_desc
            FROM pmaj_t
           WHERE pmajent = g_enterprise
             AND pmaj001 = sr_s.xmdk007
             AND pmaj002 = l_pmaj002
       END IF
       IF NOT cl_null(l_pmaj002) THEN
          CALL axmr580_g01_get_oofc012(l_pmaj002,'1') RETURNING sr_s.l_xmdk007_tel
          CALL axmr580_g01_get_oofc012(l_pmaj002,'3') RETURNING sr_s.l_xmdk007_fax
       END IF
       #add--2015/08/13 By shiun--(E)
       #客戶訂購單號
       SELECT xmda033 INTO sr_s.l_xmda033
         FROM xmda_t
        WHERE xmdaent = g_enterprise
          AND xmdadocno = sr_s.xmdl003       
       
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL axmr580_g01_initialize(sr_s.xmdl014,sr_s.l_xmdl014_inayl003) RETURNING sr_s.l_xmdl014_inayl003
       CALL axmr580_g01_initialize(sr_s.xmdl015,sr_s.l_xmdl015_inab003) RETURNING sr_s.l_xmdl015_inab003
       CALL axmr580_g01_initialize(sr_s.xmdk007,sr_s.l_xmdk007_pmaal003) RETURNING sr_s.l_xmdk007_pmaal003
       CALL axmr580_g01_initialize(sr_s.xmdk008,sr_s.l_xmdk008_pmaal003) RETURNING sr_s.l_xmdk008_pmaal003
       CALL axmr580_g01_initialize(sr_s.xmdk009,sr_s.l_xmdk009_pmaal003) RETURNING sr_s.l_xmdk009_pmaal003
       CALL axmr580_g01_initialize(sr_s.xmdk003,sr_s.l_xmdk003_ooag011) RETURNING sr_s.l_xmdk003_ooag011
       CALL axmr580_g01_initialize(sr_s.xmdk004,sr_s.l_xmdk004_ooefl003) RETURNING sr_s.l_xmdk004_ooefl003
       
       #add--2015/08/13 By shiun--(S)
       #單頭客戶訂購單號
       SELECT xmda033 INTO l_xmda033
         FROM xmda_t
        WHERE xmdaent = g_enterprise
          AND xmdadocno = sr_s.xmdk006
       
       #add--2015/08/28 By shiun--(S)
       CALL s_apmi011_location_ref(sr_s.xmdk022,sr_s.xmdk023) RETURNING l_xmdk023_desc
       CALL s_apmi011_location_ref(sr_s.xmdk022,sr_s.xmdk024) RETURNING l_xmdk024_desc
       #add--2015/08/28 By shiun--(E)
       #mark--2015/08/28 By shiun--(S)
       #add--2015/08/11 By shiun--(S)
       #起運地帶出參考欄位
#       LET l_oocq019 = ''               #運輸方式清空
#       LET l_xmdk023_desc = ''
#
#       IF NOT cl_null(sr_s.xmdk022) THEN
#       SELECT oocq019 INTO l_oocq019 FROM oocq_t
#        WHERE oocqent = sr_s.xmdkent
#          AND oocq001 ='263'
#          AND oocq002 = sr_s.xmdk022 #運輸方式
#       END IF
#
#       CASE
#          WHEN l_oocq019 = '1' OR    #陸運
#               l_oocq019 = '4'       #其他
#        
#             DECLARE axmr540_xmdk_cs SCROLL CURSOR FOR
#                SELECT oockl005 FROM oockl_t
#                 WHERE oocklent = sr_s.xmdkent
#                   AND oockl003 = sr_s.xmdk023
#                   AND oockl004 = g_dlang
#              ORDER BY oockl001 DESC
#                  OPEN axmr540_xmdk_cs
#           FETCH FIRST axmr540_xmdk_cs INTO l_xmdk023_desc
#        
#          WHEN l_oocq019 = '2'       #海運        
#             SELECT oocql004 INTO l_xmdk023_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdkent
#                AND oocql001 ='262'
#                AND oocql002 = sr_s.xmdk023
#                AND oocql003 = g_dlang
#
#          WHEN l_oocq019 = '3'       #空運
#             SELECT oocql004 INTO l_xmdk023_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdkent
#                AND oocql001 = '276'
#                AND oocql002 = sr_s.xmdk023
#                AND oocql003 = g_dlang
#       END CASE
#
#       #目的地帶出參考欄位
#       LET l_oocq019 = ''
#       LET l_xmdk024_desc = ''
#
#       IF NOT cl_null(sr_s.xmdk022) THEN
#       SELECT oocq019 INTO l_oocq019
#         FROM oocq_t
#        WHERE oocq001 = '263'
#          AND oocq002 = sr_s.xmdk038
#       END IF
#       CASE
#          WHEN l_oocq019 = '1' OR    #陸運
#               l_oocq019 = '4'       #其他
#
#             DECLARE axme500_xmdk_cs1 SCROLL CURSOR FOR
#                SELECT oockl005 FROM oockl_t
#                 WHERE oocklent = sr_s.xmdkent
#                   AND oockl003 = sr_s.xmdk024
#                   AND oockl004 = g_dlang
#                 ORDER BY oockl001 DESC
#                 OPEN axme500_xmdk_cs1
#             FETCH FIRST axme500_xmdk_cs1 INTO l_xmdk024_desc
#
#          WHEN l_oocq019 = '2'       #海運
#
#             SELECT oocql004 INTO l_xmdk024_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdkent
#                AND oocql001 ='262'
#                AND oocql002 = sr_s.xmdk024
#                AND oocql003 = g_dlang
#
#          WHEN l_oocq019 = '3'       #空運
#
#             SELECT oocql004 INTO l_xmdk024_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmdkent
#                AND oocql001 = '276'
#                AND oocql002 = sr_s.xmdk024
#                AND oocql003 = g_dlang
#       END CASE
       #mark--2015/08/28 By shiun--(E)
       CALL s_axmi210_ins_tmp_table(sr_s.xmdl008,sr_s.x_imaal_t_imaal003,sr_s.t7_pmaal004,l_xmda033,sr_s.xmdk006,l_xmdk023_desc,l_xmdk024_desc,'','','','','',sr_s.xmdkdocno) RETURNING l_success
       #add--2015/08/13 By shiun--(E)
       #161207-00033#14-s add
       EXECUTE axmr580_pb USING sr_s.xmdk007 INTO l_pmaa004
       IF l_pmaa004 = '2' THEN   #2.一次性交易對象
          #一次性交易對象全名
          CALL s_desc_axm_get_oneturn_guest_desc('4',sr_s.xmdkdocno)
               RETURNING r_pmak003
          IF NOT cl_null(r_pmak003) THEN
             LET sr_s.t7_pmaal003 = r_pmak003
             IF sr_s.xmdk008 = sr_s.xmdk007 THEN   #帳款客戶
                LET sr_s.t8_pmaal004 = sr_s.t7_pmaal003
             END IF
             IF sr_s.xmdk009 = sr_s.xmdk007 THEN   #收貨客戶
                LET sr_s.t9_pmaal004 = sr_s.t7_pmaal003
             END IF
          END IF
       END IF
       #161207-00033#14-e add 
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmdk000 = sr_s.xmdk000
       LET sr[l_cnt].xmdk001 = sr_s.xmdk001
       LET sr[l_cnt].xmdk002 = sr_s.xmdk002
       LET sr[l_cnt].xmdk003 = sr_s.xmdk003
       LET sr[l_cnt].xmdk004 = sr_s.xmdk004
       LET sr[l_cnt].xmdk005 = sr_s.xmdk005
       LET sr[l_cnt].xmdk006 = sr_s.xmdk006
       LET sr[l_cnt].xmdk007 = sr_s.xmdk007
       LET sr[l_cnt].xmdk008 = sr_s.xmdk008
       LET sr[l_cnt].xmdk009 = sr_s.xmdk009
       LET sr[l_cnt].xmdk010 = sr_s.xmdk010
       LET sr[l_cnt].xmdk011 = sr_s.xmdk011
       LET sr[l_cnt].xmdk012 = sr_s.xmdk012
       LET sr[l_cnt].xmdk013 = sr_s.xmdk013
       LET sr[l_cnt].xmdk014 = sr_s.xmdk014
       LET sr[l_cnt].xmdk015 = sr_s.xmdk015
       LET sr[l_cnt].xmdk016 = sr_s.xmdk016
       LET sr[l_cnt].xmdk017 = sr_s.xmdk017
       LET sr[l_cnt].xmdk018 = sr_s.xmdk018
       LET sr[l_cnt].xmdk019 = sr_s.xmdk019
       LET sr[l_cnt].xmdk020 = sr_s.xmdk020
       LET sr[l_cnt].xmdk021 = sr_s.xmdk021
       LET sr[l_cnt].xmdk022 = sr_s.xmdk022
       LET sr[l_cnt].xmdk023 = sr_s.xmdk023
       LET sr[l_cnt].xmdk024 = sr_s.xmdk024
       LET sr[l_cnt].xmdk025 = sr_s.xmdk025
       LET sr[l_cnt].xmdk026 = sr_s.xmdk026
       LET sr[l_cnt].xmdk027 = sr_s.xmdk027
       LET sr[l_cnt].xmdk028 = sr_s.xmdk028
       LET sr[l_cnt].xmdk029 = sr_s.xmdk029
       LET sr[l_cnt].xmdk030 = sr_s.xmdk030
       LET sr[l_cnt].xmdk031 = sr_s.xmdk031
       LET sr[l_cnt].xmdk032 = sr_s.xmdk032
       LET sr[l_cnt].xmdk033 = sr_s.xmdk033
       LET sr[l_cnt].xmdk034 = sr_s.xmdk034
       LET sr[l_cnt].xmdk035 = sr_s.xmdk035
       LET sr[l_cnt].xmdk036 = sr_s.xmdk036
       LET sr[l_cnt].xmdk037 = sr_s.xmdk037
       LET sr[l_cnt].xmdk038 = sr_s.xmdk038
       LET sr[l_cnt].xmdk039 = sr_s.xmdk039
       LET sr[l_cnt].xmdk040 = sr_s.xmdk040
       LET sr[l_cnt].xmdk054 = sr_s.xmdk054
       LET sr[l_cnt].xmdk083 = sr_s.xmdk083
       LET sr[l_cnt].xmdkdocdt = sr_s.xmdkdocdt
       LET sr[l_cnt].xmdkdocno = sr_s.xmdkdocno
       LET sr[l_cnt].xmdkent = sr_s.xmdkent
       LET sr[l_cnt].xmdksite = sr_s.xmdksite
       LET sr[l_cnt].xmdkstus = sr_s.xmdkstus
       LET sr[l_cnt].xmdkunit = sr_s.xmdkunit
       LET sr[l_cnt].xmdl001 = sr_s.xmdl001
       LET sr[l_cnt].xmdl002 = sr_s.xmdl002
       LET sr[l_cnt].xmdl003 = sr_s.xmdl003
       LET sr[l_cnt].xmdl004 = sr_s.xmdl004
       LET sr[l_cnt].xmdl005 = sr_s.xmdl005
       LET sr[l_cnt].xmdl006 = sr_s.xmdl006
       LET sr[l_cnt].xmdl007 = sr_s.xmdl007
       LET sr[l_cnt].xmdl008 = sr_s.xmdl008
       LET sr[l_cnt].xmdl009 = sr_s.xmdl009
       LET sr[l_cnt].xmdl010 = sr_s.xmdl010
       LET sr[l_cnt].xmdl011 = sr_s.xmdl011
       LET sr[l_cnt].xmdl012 = sr_s.xmdl012
       LET sr[l_cnt].xmdl013 = sr_s.xmdl013
       LET sr[l_cnt].xmdl014 = sr_s.xmdl014
       LET sr[l_cnt].xmdl015 = sr_s.xmdl015
       LET sr[l_cnt].xmdl016 = sr_s.xmdl016
       LET sr[l_cnt].xmdl017 = sr_s.xmdl017
       LET sr[l_cnt].xmdl018 = sr_s.xmdl018
       LET sr[l_cnt].xmdl019 = sr_s.xmdl019
       LET sr[l_cnt].xmdl020 = sr_s.xmdl020
       LET sr[l_cnt].xmdl021 = sr_s.xmdl021
       LET sr[l_cnt].xmdl022 = sr_s.xmdl022
       LET sr[l_cnt].xmdl023 = sr_s.xmdl023
       LET sr[l_cnt].xmdl024 = sr_s.xmdl024
       LET sr[l_cnt].xmdl025 = sr_s.xmdl025
       LET sr[l_cnt].xmdl026 = sr_s.xmdl026
       LET sr[l_cnt].xmdl027 = sr_s.xmdl027
       LET sr[l_cnt].xmdl028 = sr_s.xmdl028
       LET sr[l_cnt].xmdl029 = sr_s.xmdl029
       LET sr[l_cnt].xmdl030 = sr_s.xmdl030
       LET sr[l_cnt].xmdl031 = sr_s.xmdl031
       LET sr[l_cnt].xmdl032 = sr_s.xmdl032
       LET sr[l_cnt].xmdl033 = sr_s.xmdl033
       LET sr[l_cnt].xmdl034 = sr_s.xmdl034
       LET sr[l_cnt].xmdl035 = sr_s.xmdl035
       LET sr[l_cnt].xmdl036 = sr_s.xmdl036
       LET sr[l_cnt].xmdl037 = sr_s.xmdl037
       LET sr[l_cnt].xmdl041 = sr_s.xmdl041
       LET sr[l_cnt].xmdl042 = sr_s.xmdl042
       LET sr[l_cnt].xmdl043 = sr_s.xmdl043
       LET sr[l_cnt].xmdl044 = sr_s.xmdl044
       LET sr[l_cnt].xmdl045 = sr_s.xmdl045
       LET sr[l_cnt].xmdl046 = sr_s.xmdl046
       LET sr[l_cnt].xmdl050 = sr_s.xmdl050
       LET sr[l_cnt].xmdl051 = sr_s.xmdl051
       LET sr[l_cnt].xmdl087 = sr_s.xmdl087
       LET sr[l_cnt].xmdl088 = sr_s.xmdl088
       LET sr[l_cnt].xmdlseq = sr_s.xmdlseq
       LET sr[l_cnt].xmdlsite = sr_s.xmdlsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].t7_pmaal003 = sr_s.t7_pmaal003
       LET sr[l_cnt].t8_pmaal003 = sr_s.t8_pmaal003
       LET sr[l_cnt].t9_pmaal003 = sr_s.t9_pmaal003
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].xmahl_t_xmahl003 = sr_s.xmahl_t_xmahl003
       LET sr[l_cnt].ooidl_t_ooidl003 = sr_s.ooidl_t_ooidl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_inab_t_inab003 = sr_s.x_inab_t_inab003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t13_oocal003 = sr_s.x_t13_oocal003
       LET sr[l_cnt].x_t14_oocal003 = sr_s.x_t14_oocal003
       LET sr[l_cnt].l_xmdk003_ooag011 = sr_s.l_xmdk003_ooag011
       LET sr[l_cnt].l_xmdk009_pmaal003 = sr_s.l_xmdk009_pmaal003
       LET sr[l_cnt].l_xmdk008_pmaal003 = sr_s.l_xmdk008_pmaal003
       LET sr[l_cnt].l_xmdk020_pmaal003 = sr_s.l_xmdk020_pmaal003
       LET sr[l_cnt].l_xmdk004_ooefl003 = sr_s.l_xmdk004_ooefl003
       LET sr[l_cnt].l_xmdk007_pmaal003 = sr_s.l_xmdk007_pmaal003
       LET sr[l_cnt].pmaal_t_pmaal006 = sr_s.pmaal_t_pmaal006
       LET sr[l_cnt].t9_pmaal006 = sr_s.t9_pmaal006
       LET sr[l_cnt].t8_pmaal006 = sr_s.t8_pmaal006
       LET sr[l_cnt].t7_pmaal006 = sr_s.t7_pmaal006
       LET sr[l_cnt].l_xmdl015_inab003 = sr_s.l_xmdl015_inab003
       LET sr[l_cnt].l_address = sr_s.l_address
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_xmdk030_desc = sr_s.l_xmdk030_desc
       LET sr[l_cnt].l_xmda033 = sr_s.l_xmda033
       LET sr[l_cnt].l_xmdl014_inayl003 = sr_s.l_xmdl014_inayl003
       LET sr[l_cnt].l_xmdk022_desc = sr_s.l_xmdk022_desc
       LET sr[l_cnt].l_pmaj002_desc = sr_s.l_pmaj002_desc
       LET sr[l_cnt].l_xmdk007_tel = sr_s.l_xmdk007_tel
       LET sr[l_cnt].l_xmdk007_fax = sr_s.l_xmdk007_fax
       LET sr[l_cnt].t8_pmaal004 = sr_s.t8_pmaal004
       LET sr[l_cnt].t9_pmaal004 = sr_s.t9_pmaal004
       LET sr[l_cnt].t7_pmaal004 = sr_s.t7_pmaal004
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].xmdl081 = sr_s.xmdl081
       LET sr[l_cnt].xmdl083 = sr_s.xmdl083
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr580_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr580_g01_rep_data()
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
          START REPORT axmr580_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr580_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr580_g01_rep
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
 
{<section id="axmr580_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr580_g01_rep(sr1)
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
DEFINE l_xmdk054_show  LIKE type_t.chr10      #單頭備註
DEFINE l_xmdl051_show  LIKE type_t.chr10      #單身備註
DEFINE l_xmdk028_show  LIKE type_t.chr10      #包裝單製作
DEFINE l_xmdk029_show  LIKE type_t.chr10      #Invoice製作
DEFINE l_xmdl014_show  LIKE type_t.chr10      #庫位
DEFINE l_xmdl015_show  LIKE type_t.chr10      #儲位
DEFINE l_xmdl016_show  LIKE type_t.chr10      #批號
DEFINE l_xmdl009_show  LIKE type_t.chr10      #產品特徵
#dorislai-20150701-add----(S)
DEFINE l_pmaal006_show  LIKE type_t.chr1      #客戶全名二是否顯現
#dorislai-20150701-add----(E)
#add--2015/08/11 By shiun--(S)
DEFINE sr6 sr6_r
DEFINE l_xmao003   LIKE xmao_t.xmao003         #變數內容多筆時顯示方式
DEFINE l_xmao004   LIKE xmao_t.xmao004         #顯示符號
DEFINE l_count     LIKE type_t.num5
DEFINE l_xmap_show LIKE type_t.chr10           #嘜頭隱藏   
DEFINE l_xmap006   STRING #資料內容
DEFINE l_out       STRING #輸出內容
DEFINE l_load      STRING #xmap006暫存內容
DEFINE l_str       STRING #擷取參數
DEFINE l_length    LIKE type_t.num5   #總長度
DEFINE l_n         LIKE type_t.num5   #起始位置(判斷用)
DEFINE l_n1        LIKE type_t.num5   #第一個&位置
DEFINE l_n2        LIKE type_t.num5   #第二個&位置
DEFINE l_min       LIKE type_t.num5   #第一筆資料
#add--2015/08/11 By shiun--(E)
#add--2015/08/12 By shiun--(S)
DEFINE sr7 sr7_r
DEFINE l_tmp_sql         STRING
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_j               INTEGER
DEFINE l_max_count       INTEGER
DEFINE l_while_count     INTEGER
DEFINE l_xmap003_sql     STRING
DEFINE l_xmap006_sql     STRING
DEFINE l_xmap003_desc    LIKE type_t.chr500
DEFINE l_xmap005_desc    LIKE type_t.chr500
DEFINE l_xmap003_show    LIKE type_t.chr1
DEFINE l_xmao001         LIKE xmao_t.xmao001         #客戶編號
DEFINE l_xmao002         LIKE xmao_t.xmao002         #嘜頭編號
DEFINE l_xmap006_array   LIKE xmap_t.xmap006         #資料內容
DEFINE l_xmap003         LIKE xmap_t.xmap003         #類別
DEFINE l_xmap004         LIKE xmap_t.xmap004         #行序
#add--2015/08/12 By shiun--(E)
#add--2015/08/13 By shiun--(S)
DEFINE l_xmda004_credit_show    LIKE  type_t.chr1      #額度是否超限顯示
DEFINE l_xmaj002_1     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(據點)
DEFINE l_xmaj002_2     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(集團)
#add--2015/08/13 By shiun--(E)
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmdkdocno,sr1.xmdlseq
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
        BEFORE GROUP OF sr1.xmdkdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
 
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmdkdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmdkent=' ,sr1.xmdkent,'{+}xmdkdocno=' ,sr1.xmdkdocno         
            CALL cl_gr_init_apr(sr1.xmdkdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmdkdocno.before name="rep.b_group.xmdkdocno.before"
           #dorislai-20150701-add----(S)
           IF cl_null(sr1.t9_pmaal006) AND cl_null(sr1.t8_pmaal006) AND cl_null(sr1.t7_pmaal006) THEN
              LET l_pmaal006_show = 'N'
           ELSE
              LET l_pmaal006_show = 'Y'
           END IF
           PRINTX l_pmaal006_show

           #dorislai-20150701-add----(E)
           #信用額度檢查
           #呼叫信用額度檢核應用元件，檢核此交易是否會超限
           IF NOT cl_null(sr1.xmdk007) THEN
              CALL s_axmt500_get_credit('1',sr1.xmdk007) RETURNING l_xmaj002_1,l_xmaj002_2  #抓取axmi140的訂單列印時超限控管方式
              IF l_xmaj002_1 = '3' OR l_xmaj002_2 = '3' THEN      #警告
                 #檢查/更新信用額度
                 IF s_axmt500_credit('1',sr1.xmdk006,sr1.xmdk007) THEN
                    LET l_xmda004_credit_show = 'N'  #不超過信用額度，不顯示警告
                 ELSE
                    LET l_xmda004_credit_show = 'Y'  #超過信用額度，顯示警告
                 END IF    
              END IF
           ELSE
              LET l_xmda004_credit_show = 'N'
           END IF
           PRINTX l_xmda004_credit_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmdkent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdkdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr580_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr580_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr580_g01_subrep01
           DECLARE axmr580_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr580_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr580_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr580_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr580_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmdkdocno.after name="rep.b_group.xmdkdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmdlseq
 
           #add-point:rep.b_group.xmdlseq.before name="rep.b_group.xmdlseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmdlseq.after name="rep.b_group.xmdlseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
       
       #若單頭備註為null，將會隱藏   
       IF cl_null(sr1.xmdk054) THEN
           LET l_xmdk054_show = "N"
       ELSE
           LET l_xmdk054_show = "Y"
       END IF
       
      #若單身備註為null，將會隱藏
       IF cl_null(sr1.xmdl051) THEN  
           LET l_xmdl051_show = "N"
       ELSE
           LET l_xmdl051_show = "Y"
       END IF
       
       #若包裝單製作為N，將會隱藏
       IF  sr1.xmdk028 CLIPPED = "N"     THEN  
           LET l_xmdk028_show  = "N"
       ELSE
           LET l_xmdk028_show = "Y"
       END IF
       
       #若Invoice製作為N，將會隱藏
       IF  sr1.xmdk029 CLIPPED = "N"     THEN  
           LET l_xmdk029_show  = "N"
       ELSE
           LET l_xmdk029_show = "Y"
       END IF
       
       #若限定庫位為null，將會隱藏
       IF cl_null(sr1.xmdl014) THEN  
           LET l_xmdl014_show = "N"
       ELSE
           LET l_xmdl014_show = "Y"
       END IF
       
       #若限定儲位為null，將會隱藏
       IF cl_null(sr1.xmdl015) THEN  
           LET l_xmdl015_show = "N"
       ELSE
           LET l_xmdl015_show = "Y"
       END IF       
       #若限定批號為null，將會隱藏
        IF cl_null(sr1.xmdl016) THEN  
           LET l_xmdl016_show = "N"
       ELSE
           LET l_xmdl016_show = "Y"
       END IF
     
       #若產品特徵為null，將會隱藏
       IF cl_null(sr1.xmdl009) THEN  
           LET l_xmdl009_show = "N"
       ELSE
           LET l_xmdl009_show = "Y"
       END IF
       
       PRINTX l_xmdk054_show,l_xmdl051_show,l_xmdk028_show,l_xmdk029_show,l_xmdl014_show,l_xmdl015_show,
              l_xmdl016_show,l_xmdl009_show
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.xmdkent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdkdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdlseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr580_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr580_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr580_g01_subrep02
           DECLARE axmr580_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr580_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr580_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr580_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr580_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            START REPORT axmr580_g01_subrep05
            IF tm.a1 ="Y" AND NOT cl_null(sr1.xmdlseq) AND sr1.xmdl013 = 'Y' THEN  
               LET g_sql = " SELECT xmdmdocno,xmdmseq,xmdmseq1,xmdm005,xmdm006,xmdm007,xmdm009,xmdm008,xmdment,trim(xmdm005)||'.'||trim(inayl003),trim(xmdm006)||'.'||trim(inab003) ",  
                           "  FROM xmdm_t LEFT OUTER JOIN inayl_t ON inayl001 = xmdm005 AND inaylent = xmdment AND inayl002 = '",g_dlang,"' ",
                           "              LEFT OUTER JOIN inab_t ON inab001 = xmdm005 AND inabent = xmdment AND inab002 = xmdm006 AND inabsite = '",g_site,"'",
                           "  WHERE xmdment = '",sr1.xmdkent,"' ",
                           "    AND xmdmdocno = '",sr1.xmdkdocno CLIPPED,"'",
                           "    AND xmdmseq   = '",sr1.xmdlseq CLIPPED,"' ",
                           "  ORDER BY xmdmseq1 "            
               DECLARE axmr580_g01_repcur05 CURSOR FROM g_sql
               FOREACH axmr580_g01_repcur05 INTO sr3.*
                  CALL axmr580_g01_initialize(sr3.xmdm005,sr3.l_xmdm005_inayl003) RETURNING sr3.l_xmdm005_inayl003
                  CALL axmr580_g01_initialize(sr3.xmdm006,sr3.l_xmdm006_inab003) RETURNING sr3.l_xmdm006_inab003
                  OUTPUT TO REPORT axmr580_g01_subrep05(sr3.*)
               END FOREACH   
            END IF               
            FINISH REPORT axmr580_g01_subrep05
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.xmdkent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdkdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdlseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr580_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr580_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr580_g01_subrep03
           DECLARE axmr580_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr580_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr580_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr580_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr580_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdkdocno
 
           #add-point:rep.a_group.xmdkdocno.before name="rep.a_group.xmdkdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmdkent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdkdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr580_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr580_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr580_g01_subrep04
           DECLARE axmr580_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr580_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr580_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr580_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr580_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmdkdocno.after name="rep.a_group.xmdkdocno.after"
#           START REPORT axmr580_g01_subrep08              
#              LET l_count = 0
#              IF NOT cl_null(sr1.xmdk007) AND NOT cl_null(sr1.xmdk027) THEN
#                 CALL axmr580_g01_cre_tmp_table()
#                 LET g_sql = " SELECT xmao003,xmao004,xmao001,xmao002,xmap003,xmap004,xmap005,xmap006 ",
#                             "   FROM xmao_t,xmap_t ",
#                             "  WHERE xmaoent = xmapent",
#                             "    AND xmao001 = xmap001",
#                             "    AND xmao002 = xmap002",
#                             "    AND xmaoent = '",sr1.xmdkent,"' ",
#                             "    AND xmao001 = '",sr1.xmdk007,"'",
#                             "    AND xmao002 = '",sr1.xmdk027,"'",
#                             "  ORDER BY xmap003,xmap004 "
#                 DECLARE axmr580_g01_repcur08 CURSOR FROM g_sql 
#                 #add--2015/08/12 By shiun--(S)
#                 LET l_tmp_sql = " INSERT INTO axmr540_tmp01 (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap003_show) VALUES (?,?,?,?,?,?,?) "  
#                 #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01
#                 PREPARE master_tmp FROM l_tmp_sql
#                 #add--2015/08/12 By shiun--(E)
#                 FOREACH axmr580_g01_repcur08 INTO l_xmao003,l_xmao004,sr6.*                    
#                    CALL s_desc_gzcbl004_desc('2102',sr6.xmap003) RETURNING sr6.l_xmap003_desc
#                    CALL s_desc_gzcbl004_desc('2100',sr6.xmap005) RETURNING sr6.l_xmap005_desc
#                    LET l_n = 1
#                    LET l_load =''
#                    WHILE TRUE
#                     LET l_xmap006 = sr6.xmap006
#                     LET l_length = LENGTH(l_xmap006)
#                     LET l_n1 = l_xmap006.getIndexOf('&',l_n)
#                     LET l_n2 = l_xmap006.getIndexOf('&',l_n1+1)
#                     IF l_n1 != 0 AND l_n2 != 0 THEN
#                        LET l_str = l_xmap006.subString(l_n1+1,l_n2-1)
#                        IF cl_null(l_load) THEN
#                           LET l_load = l_xmap006.subString(l_n,l_n1-1)
#                        ELSE
#                           LET l_load = l_load || l_xmap006.subString(l_n,l_n1-1)
#                        END IF                        
#                        CALL s_axmi210_assemble(sr1.xmdkdocno,l_str,l_xmao003,l_xmao004) RETURNING l_out
#                        IF cl_null(l_load) THEN
#                           LET l_load = l_out
#                        ELSE
#                           LET l_load = l_load || l_out
#                        END IF    
#                        LET l_n = l_n2 + 1
#                     ELSE
#                        IF NOT cl_null(l_load) THEN
#                           LET sr6.xmap006 = l_load
#                        END IF
#                        EXIT WHILE
#                     END IF
#                    END WHILE
#                    SELECT MIN(xmap004) INTO l_min
#                      FROM xmap_t
#                     WHERE xmapent = sr1.xmdkent
#                       AND xmap001 = sr1.xmdk007
#                       AND xmap002 = sr1.xmdk027
#                       AND xmap003 = sr6.xmap003
#                    IF sr6.xmap004 = l_min THEN
#                       LET sr6.l_xmap003_show = 'Y'
#                    ELSE
#                       LET sr6.l_xmap003_show = 'N'
#                    END IF
#                    EXECUTE master_tmp USING sr6.xmao001,sr6.xmao002,sr6.xmap003,sr6.l_xmap003_desc,sr6.xmap004,sr6.xmap006,sr6.l_xmap003_show        #add--2015/08/12 By shiun            
#                 END FOREACH
#                 #add--2015/08/12 By shiun--(S)
#                 LET l_xmap003_sql = " SELECT DISTINCT xmap003,l_xmap003_desc ",
#                                     " FROM axmr540_tmp01 ",   #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01
#                                     " ORDER BY xmap003"
#                 LET l_xmap006_sql = " SELECT DISTINCT xmap004,xmap006,l_xmap003_show,xmao001,xmao002 ",
#                                     " FROM axmr540_tmp01 ",   #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01
#                                     " WHERE l_xmap003_desc = ?",
#                                     " ORDER BY xmap004"
#                 DECLARE axmr580_g01_xmap003 CURSOR FROM l_xmap003_sql 
#                 
#                 PREPARE axmr580_g01_xmap006_pb FROM l_xmap006_sql                 
#                 DECLARE axmr580_g01_xmap006_cs CURSOR FOR axmr580_g01_xmap006_pb   
#                 
#                 LET l_i = 1
#                 LET l_max_count = 1
#                 
#                 FOREACH axmr580_g01_xmap003 INTO l_xmap003,l_xmap003_desc
#                    LET l_j = l_max_count
#                    OPEN axmr580_g01_xmap006_cs USING l_xmap003_desc
#                    
#                    FOREACH axmr580_g01_xmap006_cs INTO l_xmap004,l_xmap006_array,l_xmap003_show,l_xmao001,l_xmao002
#                       IF l_i MOD 2 = 1 THEN
#                          IF l_xmap003_show = 'Y' THEN
#                             LET sr8[l_j].l_xmap003_desc_1 = l_xmap003_desc
#                          ELSE
#                             LET sr8[l_j].l_xmap003_desc_1 = ' '
#                          END IF
#                          LET sr8[l_j].xmao001 = l_xmao001
#                          LET sr8[l_j].xmao002 = l_xmao002
#                          LET sr8[l_j].xmap006_1 = l_xmap006_array
#                       ELSE
#                          IF l_xmap003_show = 'Y' THEN
#                             LET sr8[l_j].l_xmap003_desc_2 = l_xmap003_desc
#                          ELSE
#                             LET sr8[l_j].l_xmap003_desc_2 = ' '
#                          END IF
#                          LET sr8[l_j].xmao001 = l_xmao001
#                          LET sr8[l_j].xmao002 = l_xmao002
#                          LET sr8[l_j].xmap006_2 = l_xmap006_array
#                       END IF
#                       LET l_j = l_j + 1
#                    END FOREACH
#                 
#                    LET l_i = l_i + 1 
#                 
#                    IF l_i MOD 2 = 1 THEN
#                       LET l_max_count = sr8.getLength() + 1
#                    END IF
#                 END FOREACH
#                 LET l_ac = 1
#                 LET l_while_count = sr8.getLength()
#                 WHILE TRUE
#                    LET sr7.xmao001 = sr8[l_ac].xmao001
#                    LET sr7.xmao002 = sr8[l_ac].xmao002
#                    LET sr7.l_xmap003_desc_1 = sr8[l_ac].l_xmap003_desc_1
#                    LET sr7.l_xmap003_desc_2 = sr8[l_ac].l_xmap003_desc_2
#                    LET sr7.xmap006_1 = sr8[l_ac].xmap006_1
#                    LET sr7.xmap006_2 = sr8[l_ac].xmap006_2
#                    OUTPUT TO REPORT axmr580_g01_subrep08(sr7.*)
#                    LET l_ac = l_ac + 1
#                    IF l_ac > l_while_count THEN
#                       EXIT WHILE
#                    END IF
#                 END WHILE
#                 #add--2015/08/12 BY shiun--(E)                 
#              END IF
#              CLOSE master_tmp   #add--2015/08/12 By shiun
#           FINISH REPORT axmr580_g01_subrep08 
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdlseq
 
           #add-point:rep.a_group.xmdlseq.before name="rep.a_group.xmdlseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmdlseq.after name="rep.a_group.xmdlseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            CALL s_axmi210_drop_tmp_table()  #add--2015/08/11 By shiun
            CALL axmr580_g01_drop_tmp_table()   #add--2015/08/12 By shiun
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr580_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr580_g01_subrep01(sr2)
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
PRIVATE REPORT axmr580_g01_subrep02(sr2)
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
PRIVATE REPORT axmr580_g01_subrep03(sr2)
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
PRIVATE REPORT axmr580_g01_subrep04(sr2)
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
 
{<section id="axmr580_g01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 抓取收款條件
# Memo...........:
# Usage..........: CALL axmr580_g01_xmdk030_ref(p_xmdkent,p_xmdk030)
#                  RETURNING r_xmdk030_desc
# Input parameter: p_xmdkent 企業編號
#                : p_xmdk030 銷售通路
# Return code....: r_xmdk030_desc 銷售通路說明
#                : 
# Date & Author..: 2014/05/26 By zechs
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr580_g01_xmdk030_ref(p_xmdkent,p_xmdk030)
DEFINE p_xmdk030         LIKE xmdk_t.xmdk030
DEFINE p_xmdkent         LIKE xmdk_t.xmdkent
DEFINE r_xmdk030_desc    LIKE oocql_t.oocql004

   #銷售通路
   LET r_xmdk030_desc = ''
   
   #160621-00003#6 160629 by lori mark and add---(S)
   #SELECT oocql004 INTO r_xmdk030_desc
   #  FROM oocql_t
   # WHERE oocqlent = p_xmdkent
   #   AND oocql001 = '275'
   #   AND oocql002 = p_xmdk030
   #   AND oocql003 = g_dlang
   SELECT oojdl003 INTO r_xmdk030_desc
     FROM oojdl_t
    WHERE oojdlent = p_xmdkent
      AND oojdl001 = p_xmdk030
      AND oojdl002 = g_dlang      
   #160621-00003#6 160629 by lori mark and add---(E)
   
   RETURN r_xmdk030_desc
END FUNCTION

PRIVATE FUNCTION axmr580_g01_initialize(p_arg,p_exp)
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
################################################################################
# Descriptions...: 取得聯絡人聯絡方式
# Memo...........:
# Usage..........: CALL axmr580_g01_get_oofc012(p_pmaj002,p_flag)
#                  RETURNING r_success,r_oofc012
# Input parameter: p_pmaj002   聯絡對象
#                : p_flag      聯絡方式(1=電話、3=傳真)
# Return code....: r_oofc012   通訊內容
# Date & Author..: 2015/08/13  By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr580_g01_get_oofc012(p_pmaj002,p_flag)
DEFINE p_pmaj002  LIKE pmdl_t.pmdl027
DEFINE p_flag     LIKE oofc_t.oofc008
DEFINE r_oofc012  LIKE oofc_t.oofc012
DEFINE l_count    LIKE type_t.num5

   LET r_oofc012 = ''
   LET l_count = 0
   SELECT COUNT(*) INTO l_count
     FROM oofc_t
    WHERE oofcent = g_enterprise
      AND oofcstus = 'Y'
      AND oofc002 = p_pmaj002
      AND oofc008 = p_flag
      
   CASE l_count
      WHEN 0
      
      WHEN 1
         SELECT oofc012 INTO r_oofc012
           FROM oofc_t
          WHERE oofcent = g_enterprise
            AND oofcstus = 'Y'
            AND oofc002 = p_pmaj002
            AND oofc008 = p_flag
            
      OTHERWISE
         SELECT oofc012 INTO r_oofc012
           FROM oofc_t
          WHERE oofcent = g_enterprise
            AND oofcstus = 'Y'
            AND oofc002 = p_pmaj002
            AND oofc008 = p_flag
            AND oofc010 = 'Y'         
   END CASE
   
   RETURN r_oofc012
END FUNCTION
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axmr580_g01_cre_tmp_table()
#                  RETURNING r_success
# Input parameter: 無
# Date & Author..: 2015/08/12 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr580_g01_cre_tmp_table()
DROP TABLE axmr540_tmp01;       #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmr540_tmp01'       #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE axmr540_tmp01(            #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01
                   xmao001         VARCHAR(10),               #客戶編號
                   xmao002         VARCHAR(10),               #嘜頭編號
                   xmap003         VARCHAR(10),               #類別
                   l_xmap003_desc  VARCHAR(500),                #類別說明
                   xmap004         INTEGER,               #行序
                   xmap006         VARCHAR(500),               #資料內容
                   l_xmap003_show  VARCHAR(1)     #類別顯示否
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmr540_tmp01'         #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
END FUNCTION
################################################################################
# Descriptions...: 刪除臨時表
# Memo...........:
# Usage..........: CALL axmr580_g01_drop_tmp_table()
# Input parameter:
# Return code....:
# Date & Author..: 2015/08/12 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr580_g01_drop_tmp_table()

   DROP TABLE axmr540_tmp01;         #160727-00019#25 Mod  axmr580_g01_temp--> axmr540_tmp01

END FUNCTION

 
{</section>}
 
{<section id="axmr580_g01.other_report" readonly="Y" >}
################################################################################
# Descriptions...: 多倉儲批出貨明細子報表
# Memo...........:
# Usage..........: CALL axmr580_g01_subrep05(sr3)
#                  
# Input parameter: sr3            資料RECORD
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/05/26 By zechs
# Modify.........:
################################################################################
PRIVATE REPORT axmr580_g01_subrep05(sr3)
DEFINE sr3             sr3_r
DEFINE sr4             sr4_r     

   ORDER EXTERNAL BY sr3.xmdmdocno,sr3.xmdmseq,sr3.xmdmseq1
      FORMAT       
        ON EVERY ROW
           PRINTX g_grNumFmt.*
           PRINTX sr3.*
            
               START REPORT axmr580_g01_subrep06
               IF tm.a2 ="Y" THEN           
                LET g_sql = " SELECT inaodocno,inaoseq,inaoseq1,inaoseq2,inao008,inao009,inao012,inao010,inao011 ",   
                            "   FROM inao_t ",  
                            "  WHERE inaoent = '",sr3.xmdment,"' ",
                            "    AND inaodocno = '",sr3.xmdmdocno CLIPPED,"'",
                            "    AND inaoseq  = ",sr3.xmdmseq  CLIPPED,  
                            "    AND inaoseq1 = ",sr3.xmdmseq1 CLIPPED,                           
                            "  ORDER BY inaoseq2 "            
                DECLARE axmr580_g01_repcur06 CURSOR FROM g_sql
                FOREACH axmr580_g01_repcur06 INTO sr4.*
                   OUTPUT TO REPORT axmr580_g01_subrep06(sr4.*)
                END FOREACH  
               END IF
               FINISH REPORT axmr580_g01_subrep06                                       
END REPORT
################################################################################
# Descriptions...: 批序號明細資料子報表
# Memo...........:
# Usage..........: CALL axmr580_g01_subrep06(sr4)
#                  
# Input parameter: sr4            資料RECORD
#                : 
# Return code....:
#                : 
# Date & Author..: 2014/05/26 By zechs
# Modify.........:
################################################################################
PRIVATE REPORT axmr580_g01_subrep06(sr4)
    DEFINE sr4  sr4_r
    
    ORDER EXTERNAL BY sr4.inaodocno,sr4.inaoseq,sr4.inaoseq1,sr4.inaoseq2
    
    FORMAT
                 
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

 
{</section>}
 
