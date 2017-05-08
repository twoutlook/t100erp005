#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr620_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:15(2017-02-22 14:18:29), PR版次:0015(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000158
#+ Filename...: axmr620_g01
#+ Description: ...
#+ Creator....: 05016(2014-05-13 17:11:21)
#+ Modifier...: 06021 -SD/PR- 00000
 
{</section>}
 
{<section id="axmr620_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#25  2016/08/5 By 08742        系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                           Mod   axmr620_g01_temp--> axmr620_tmp01
#161031-00021#2   2016/12/19 BY 08992       axmr620增加選項"列印單價選項"，可選列印單價一、單價二，報表單價、金額資料依選項列印
#161207-00033#14  2016/12/21 By 08992       一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#161205-00042#5   2016/12/23 By 08992       嘜頭預設圖片設置、圖中字位置設定
#161031-00024#4   2017/01/25 By 06137       2.報表畫面增加"列印額外品名規格"選項
#                                           2-1.打勾時，依料件編號+單別參數"額外品名規格類型"，串到aimm221抓取資料
#                                           2-2.有抓到值時，原品名規格資料不印，改印額外品名規格資料，額外品名規格資料依行序+換行符號組成一個大字串放至品名中
#                                           2-3.沒抓到值，印原品名規格
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
IMPORT util   #161205-00042#5 add
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   xmdo001 LIKE xmdo_t.xmdo001, 
   xmdo002 LIKE xmdo_t.xmdo002, 
   xmdo003 LIKE xmdo_t.xmdo003, 
   xmdo004 LIKE xmdo_t.xmdo004, 
   xmdo005 LIKE xmdo_t.xmdo005, 
   xmdo007 LIKE xmdo_t.xmdo007, 
   xmdo008 LIKE xmdo_t.xmdo008, 
   xmdo009 LIKE xmdo_t.xmdo009, 
   xmdo010 LIKE xmdo_t.xmdo010, 
   xmdo011 LIKE xmdo_t.xmdo011, 
   xmdo012 LIKE xmdo_t.xmdo012, 
   xmdo013 LIKE xmdo_t.xmdo013, 
   xmdo014 LIKE xmdo_t.xmdo014, 
   xmdo015 LIKE xmdo_t.xmdo015, 
   xmdo016 LIKE xmdo_t.xmdo016, 
   xmdo017 LIKE xmdo_t.xmdo017, 
   xmdo019 LIKE xmdo_t.xmdo019, 
   xmdo020 LIKE xmdo_t.xmdo020, 
   xmdo021 LIKE xmdo_t.xmdo021, 
   xmdo022 LIKE xmdo_t.xmdo022, 
   xmdo023 LIKE xmdo_t.xmdo023, 
   xmdo024 LIKE xmdo_t.xmdo024, 
   xmdo025 LIKE xmdo_t.xmdo025, 
   xmdo026 LIKE xmdo_t.xmdo026, 
   xmdo029 LIKE xmdo_t.xmdo029, 
   xmdo053 LIKE xmdo_t.xmdo053, 
   xmdodocdt LIKE xmdo_t.xmdodocdt, 
   xmdodocno LIKE xmdo_t.xmdodocno, 
   xmdoent LIKE xmdo_t.xmdoent, 
   xmdosite LIKE xmdo_t.xmdosite, 
   xmdostus LIKE xmdo_t.xmdostus, 
   xmdp001 LIKE xmdp_t.xmdp001, 
   xmdp002 LIKE xmdp_t.xmdp002, 
   xmdp003 LIKE xmdp_t.xmdp003, 
   xmdp004 LIKE xmdp_t.xmdp004, 
   xmdp005 LIKE xmdp_t.xmdp005, 
   xmdp006 LIKE xmdp_t.xmdp006, 
   xmdp007 LIKE xmdp_t.xmdp007, 
   xmdp008 LIKE xmdp_t.xmdp008, 
   xmdp009 LIKE xmdp_t.xmdp009, 
   xmdp010 LIKE xmdp_t.xmdp010, 
   xmdp012 LIKE xmdp_t.xmdp012, 
   xmdp013 LIKE xmdp_t.xmdp013, 
   xmdp014 LIKE xmdp_t.xmdp014, 
   xmdp015 LIKE xmdp_t.xmdp015, 
   xmdp016 LIKE xmdp_t.xmdp016, 
   xmdp017 LIKE xmdp_t.xmdp017, 
   xmdp018 LIKE xmdp_t.xmdp018, 
   xmdp019 LIKE xmdp_t.xmdp019, 
   xmdp020 LIKE xmdp_t.xmdp020, 
   xmdp021 LIKE xmdp_t.xmdp021, 
   xmdp022 LIKE xmdp_t.xmdp022, 
   xmdp023 LIKE xmdp_t.xmdp023, 
   xmdp024 LIKE xmdp_t.xmdp024, 
   xmdp025 LIKE xmdp_t.xmdp025, 
   xmdp026 LIKE xmdp_t.xmdp026, 
   xmdp040 LIKE xmdp_t.xmdp040, 
   xmdpseq LIKE xmdp_t.xmdpseq, 
   xmdpsite LIKE xmdp_t.xmdpsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t8_imaal003 LIKE imaal_t.imaal003, 
   l_xmdo002_ooag011 LIKE type_t.chr300, 
   l_xmdo003_ooefl003 LIKE type_t.chr1000, 
   x_t8_imaal004 LIKE imaal_t.imaal004, 
   l_xmdo010_desc LIKE type_t.chr100, 
   l_xmdo022_desc LIKE type_t.chr100, 
   l_xmdo023_desc LIKE type_t.chr100, 
   l_xmdo008_address LIKE type_t.chr300, 
   l_xmdo009_address LIKE type_t.chr300, 
   l_xmdosite_desc LIKE ooefl_t.ooefl006, 
   l_xmdp025_026 LIKE type_t.num20_6, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_xmdo009_pmaal003 LIKE type_t.chr1000, 
   l_xmdo008_pmaal003 LIKE type_t.chr1000, 
   l_xmdo007_pmaal003 LIKE type_t.chr1000, 
   l_xmdo019_pmaal003 LIKE type_t.chr1000, 
   t3_pmaal003 LIKE pmaal_t.pmaal003, 
   t4_pmaal003 LIKE pmaal_t.pmaal003, 
   t5_pmaal003 LIKE pmaal_t.pmaal003, 
   t3_pmaal004 LIKE pmaal_t.pmaal004, 
   l_xmda033 LIKE xmda_t.xmda033, 
   l_xmdo011_desc LIKE oocql_t.oocql004, 
   l_xmdo021_desc LIKE oocql_t.oocql004, 
   l_xmdo009_pmaj002 LIKE pmaj_t.pmaj002, 
   l_xmdo009_tel_fax LIKE type_t.chr1000, 
   xmdo030 LIKE xmdo_t.xmdo030, 
   xmdo031 LIKE xmdo_t.xmdo031, 
   xmdo032 LIKE xmdo_t.xmdo032
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       chk LIKE type_t.chr1,         #chk 
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
DEFINE g_ref_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
TYPE sr3_r RECORD 
   xmao001        LIKE xmao_t.xmao001,          #客戶編號
   xmao002        LIKE xmao_t.xmao002,          #嘜頭編號
   xmap003        LIKE xmap_t.xmap003,          #類別
   xmap004        LIKE xmap_t.xmap004,          #行序
   xmap005        LIKE xmap_t.xmap005,          #資料類型
   xmap006        LIKE type_t.chr1000,          #資料內容
   l_xmap006_img  LIKE type_t.chr1000,          #資料內容(圖片)   #161205-00042#5-add
   l_imgstr       LIKE xmap_t.xmap006,          #圖中字內容       #161205-00042#5-add
   l_xmap003_desc LIKE type_t.chr500,           #類別說明
   l_xmap005_desc LIKE type_t.chr500,           #資料內容說明
   l_xmap003_show LIKE type_t.chr1              #類別顯示否
END RECORD
#add--2015/08/17 By shiun--(S)
TYPE sr4_r RECORD 
   xmao001          LIKE xmao_t.xmao001,          #客戶編號
   xmao002          LIKE xmao_t.xmao002,          #嘜頭編號
   xmap006_1        LIKE xmap_t.xmap006,          #資料內容
   xmap006_2        LIKE xmap_t.xmap006,          #資料內容
   l_xmap003_desc_1 LIKE type_t.chr500,           #類別說明
   l_xmap003_desc_2 LIKE type_t.chr500,           #類別說明
   #161205-00042#5-add-s
   l_xmap006_1_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_xmap006_2_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_imgstr_1       LIKE xmap_t.xmap006,          #圖中字內容
   l_imgstr_2       LIKE xmap_t.xmap006           #圖中字內容
   #161205-00042#5-add-e
#   l_xmap003_show_1 LIKE type_t.chr500,           #類別顯示否
#   l_xmap003_show_2 LIKE type_t.chr500            #類別顯示否
END RECORD
TYPE sr5_r RECORD
   xmao001          LIKE xmao_t.xmao001,          #客戶編號
   xmao002          LIKE xmao_t.xmao002,          #嘜頭編號
   xmap006_1        LIKE xmap_t.xmap006,          #資料內容
   xmap006_2        LIKE xmap_t.xmap006,          #資料內容
   l_xmap003_desc_1 LIKE type_t.chr500,           #類別說明
   l_xmap003_desc_2 LIKE type_t.chr500,           #類別說明
   #161205-00042#5-add-s
   l_xmap006_1_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_xmap006_2_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_imgstr_1       LIKE xmap_t.xmap006,          #圖中字內容
   l_imgstr_2       LIKE xmap_t.xmap006           #圖中字內容
   #161205-00042#5-add-e   
#   l_xmap003_show_1 LIKE type_t.chr500,           #類別顯示否
#   l_xmap003_show_2 LIKE type_t.chr500            #類別顯示否
END RECORD
DEFINE sr5 DYNAMIC ARRAY OF sr5_r
#add--2015/08/17 By shiun--(E)
#end add-point
 
{</section>}
 
{<section id="axmr620_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr620_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  chk 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.c1  列印額外品名
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
DEFINE  l_success LIKE type_t.num5
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
   LET tm.c1 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL s_axmi210_cre_tmp_table() RETURNING l_success #add--2015/06/30 By shiun
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axmr620_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr620_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr620_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr620_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr620_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr620_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #161031-00021#2-s
   LET g_select = " SELECT xmdo001,xmdo002,xmdo003,xmdo004,xmdo005,xmdo007,xmdo008,xmdo009,xmdo010,xmdo011, 
    xmdo012,xmdo013,xmdo014,xmdo015,xmdo016,xmdo017,xmdo019,xmdo020,xmdo021,xmdo022,xmdo023,xmdo024, 
    xmdo025,xmdo026,xmdo029,xmdo053,xmdodocdt,xmdodocno,xmdoent,xmdosite,xmdostus,xmdp001,xmdp002, 
    xmdp003,xmdp004,xmdp005,xmdp006,xmdp007,xmdp008,xmdp009,xmdp010,xmdp012,xmdp013,xmdp014,xmdp015, 
    xmdp016,xmdp017,xmdp018,xmdp019,xmdp020,    
    (CASE '",tm.chk,"' WHEN '1' THEN xmdp021 ELSE xmdp031 END ),
    xmdp022,xmdp023,
    (CASE '",tm.chk,"' WHEN '1' THEN xmdp024 ELSE xmdp032 END ),
    (CASE '",tm.chk,"' WHEN '1' THEN xmdp025 ELSE xmdp033 END ),
    (CASE '",tm.chk,"' WHEN '1' THEN xmdp026 ELSE xmdp034 END ),
    xmdp040, 
    xmdpseq,xmdpsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdo_t.xmdo002 AND ooag_t.ooagent = xmdo_t.xmdoent), 
    ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdo_t.xmdo003 AND ooefl_t.ooeflent = xmdo_t.xmdoent AND ooefl_t.ooefl002 = '" , 
    g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmdo_t.xmdo010 AND ooibl_t.ooiblent = xmdo_t.xmdoent AND ooibl_t.ooibl003 = '" , 
    g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmdo_t.xmdo016 AND ooail_t.ooailent = xmdo_t.xmdoent AND ooail_t.ooail002 = '" , 
    g_dlang,"'" ,"),( SELECT oofb011 FROM oofb_t WHERE oofb_t.oofb001 = xmdo_t.xmdo020 AND oofb_t.oofbent = xmdo_t.xmdoent), 
    x.imaal_t_imaal003,x.t8_imaal003,trim(xmdo002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdo_t.xmdo002 AND ooag_t.ooagent = xmdo_t.xmdoent)), 
    trim(xmdo003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdo_t.xmdo003 AND ooefl_t.ooeflent = xmdo_t.xmdoent AND ooefl_t.ooefl002 = '" , 
    g_dlang,"'" ,")),x.t8_imaal004,'','','','','','',NULL,( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo019 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
    g_dlang,"'" ,"),trim(xmdo009)||'.'||trim((SELECT pmaal003 FROM pmaal_t t5 WHERE t5.pmaal001 = xmdo_t.xmdo009 AND t5.pmaalent = xmdo_t.xmdoent AND t5.pmaal002 = '" , 
    g_dlang,"'" ,")),trim(xmdo008)||'.'||trim((SELECT pmaal003 FROM pmaal_t t4 WHERE t4.pmaal001 = xmdo_t.xmdo008 AND t4.pmaalent = xmdo_t.xmdoent AND t4.pmaal002 = '" , 
    g_dlang,"'" ,")),trim(xmdo007)||'.'||trim((SELECT pmaal003 FROM pmaal_t t3 WHERE t3.pmaal001 = xmdo_t.xmdo007 AND t3.pmaalent = xmdo_t.xmdoent AND t3.pmaal002 = '" , 
    g_dlang,"'" ,")),trim(xmdo019)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo019 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
    g_dlang,"'" ,")),( SELECT pmaal003 FROM pmaal_t t3 WHERE t3.pmaal001 = xmdo_t.xmdo007 AND t3.pmaalent = xmdo_t.xmdoent AND t3.pmaal002 = '" , 
    g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t t4 WHERE t4.pmaal001 = xmdo_t.xmdo008 AND t4.pmaalent = xmdo_t.xmdoent AND t4.pmaal002 = '" , 
    g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t t5 WHERE t5.pmaal001 = xmdo_t.xmdo009 AND t5.pmaalent = xmdo_t.xmdoent AND t5.pmaal002 = '" , 
    g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t t3 WHERE t3.pmaal001 = xmdo_t.xmdo007 AND t3.pmaalent = xmdo_t.xmdoent AND t3.pmaal002 = '" , 
    g_dlang,"'" ,"),'','','','','',xmdo030,xmdo031,xmdo032"
    #161031-00021#2-e
#   #end add-point
#   LET g_select = " SELECT xmdo001,xmdo002,xmdo003,xmdo004,xmdo005,xmdo007,xmdo008,xmdo009,xmdo010,xmdo011, 
#       xmdo012,xmdo013,xmdo014,xmdo015,xmdo016,xmdo017,xmdo019,xmdo020,xmdo021,xmdo022,xmdo023,xmdo024, 
#       xmdo025,xmdo026,xmdo029,xmdo053,xmdodocdt,xmdodocno,xmdoent,xmdosite,xmdostus,xmdp001,xmdp002, 
#       xmdp003,xmdp004,xmdp005,xmdp006,xmdp007,xmdp008,xmdp009,xmdp010,xmdp012,xmdp013,xmdp014,xmdp015, 
#       xmdp016,xmdp017,xmdp018,xmdp019,xmdp020,xmdp021,xmdp022,xmdp023,xmdp024,xmdp025,xmdp026,xmdp040, 
#       xmdpseq,xmdpsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdo_t.xmdo002 AND ooag_t.ooagent = xmdo_t.xmdoent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdo_t.xmdo003 AND ooefl_t.ooeflent = xmdo_t.xmdoent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmdo_t.xmdo010 AND ooibl_t.ooiblent = xmdo_t.xmdoent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmdo_t.xmdo016 AND ooail_t.ooailent = xmdo_t.xmdoent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT oofb011 FROM oofb_t WHERE oofb_t.oofb001 = xmdo_t.xmdo020 AND oofb_t.oofbent = xmdo_t.xmdoent), 
#       x.imaal_t_imaal003,x.t8_imaal003,trim(xmdo002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdo_t.xmdo002 AND ooag_t.ooagent = xmdo_t.xmdoent)), 
#       trim(xmdo003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdo_t.xmdo003 AND ooefl_t.ooeflent = xmdo_t.xmdoent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),x.t8_imaal004,'','','','','','',NULL,( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo019 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),trim(xmdo009)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo009 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdo008)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo008 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdo007)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo007 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdo019)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo019 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo007 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo008 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo009 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdo_t.xmdo007 AND pmaal_t.pmaalent = xmdo_t.xmdoent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),'','','','','',xmdo030,xmdo031,xmdo032"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xmdo_t LEFT OUTER JOIN ( SELECT xmdp_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdp_t.xmdp012 AND imaal_t.imaalent = xmdp_t.xmdpent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdp_t.xmdp008 AND imaal_t.imaalent = xmdp_t.xmdpent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t8_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = xmdp_t.xmdp008 AND imaal_t.imaalent = xmdp_t.xmdpent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") t8_imaal004 FROM xmdp_t ) x  ON xmdo_t.xmdodocno = x.xmdpdocno AND xmdo_t.xmdoent  
        = x.xmdpent"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xmdodocno,xmdpseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdo_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr620_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr620_g01_curs CURSOR FOR axmr620_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr620_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr620_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmdo001 LIKE xmdo_t.xmdo001, 
   xmdo002 LIKE xmdo_t.xmdo002, 
   xmdo003 LIKE xmdo_t.xmdo003, 
   xmdo004 LIKE xmdo_t.xmdo004, 
   xmdo005 LIKE xmdo_t.xmdo005, 
   xmdo007 LIKE xmdo_t.xmdo007, 
   xmdo008 LIKE xmdo_t.xmdo008, 
   xmdo009 LIKE xmdo_t.xmdo009, 
   xmdo010 LIKE xmdo_t.xmdo010, 
   xmdo011 LIKE xmdo_t.xmdo011, 
   xmdo012 LIKE xmdo_t.xmdo012, 
   xmdo013 LIKE xmdo_t.xmdo013, 
   xmdo014 LIKE xmdo_t.xmdo014, 
   xmdo015 LIKE xmdo_t.xmdo015, 
   xmdo016 LIKE xmdo_t.xmdo016, 
   xmdo017 LIKE xmdo_t.xmdo017, 
   xmdo019 LIKE xmdo_t.xmdo019, 
   xmdo020 LIKE xmdo_t.xmdo020, 
   xmdo021 LIKE xmdo_t.xmdo021, 
   xmdo022 LIKE xmdo_t.xmdo022, 
   xmdo023 LIKE xmdo_t.xmdo023, 
   xmdo024 LIKE xmdo_t.xmdo024, 
   xmdo025 LIKE xmdo_t.xmdo025, 
   xmdo026 LIKE xmdo_t.xmdo026, 
   xmdo029 LIKE xmdo_t.xmdo029, 
   xmdo053 LIKE xmdo_t.xmdo053, 
   xmdodocdt LIKE xmdo_t.xmdodocdt, 
   xmdodocno LIKE xmdo_t.xmdodocno, 
   xmdoent LIKE xmdo_t.xmdoent, 
   xmdosite LIKE xmdo_t.xmdosite, 
   xmdostus LIKE xmdo_t.xmdostus, 
   xmdp001 LIKE xmdp_t.xmdp001, 
   xmdp002 LIKE xmdp_t.xmdp002, 
   xmdp003 LIKE xmdp_t.xmdp003, 
   xmdp004 LIKE xmdp_t.xmdp004, 
   xmdp005 LIKE xmdp_t.xmdp005, 
   xmdp006 LIKE xmdp_t.xmdp006, 
   xmdp007 LIKE xmdp_t.xmdp007, 
   xmdp008 LIKE xmdp_t.xmdp008, 
   xmdp009 LIKE xmdp_t.xmdp009, 
   xmdp010 LIKE xmdp_t.xmdp010, 
   xmdp012 LIKE xmdp_t.xmdp012, 
   xmdp013 LIKE xmdp_t.xmdp013, 
   xmdp014 LIKE xmdp_t.xmdp014, 
   xmdp015 LIKE xmdp_t.xmdp015, 
   xmdp016 LIKE xmdp_t.xmdp016, 
   xmdp017 LIKE xmdp_t.xmdp017, 
   xmdp018 LIKE xmdp_t.xmdp018, 
   xmdp019 LIKE xmdp_t.xmdp019, 
   xmdp020 LIKE xmdp_t.xmdp020, 
   xmdp021 LIKE xmdp_t.xmdp021, 
   xmdp022 LIKE xmdp_t.xmdp022, 
   xmdp023 LIKE xmdp_t.xmdp023, 
   xmdp024 LIKE xmdp_t.xmdp024, 
   xmdp025 LIKE xmdp_t.xmdp025, 
   xmdp026 LIKE xmdp_t.xmdp026, 
   xmdp040 LIKE xmdp_t.xmdp040, 
   xmdpseq LIKE xmdp_t.xmdpseq, 
   xmdpsite LIKE xmdp_t.xmdpsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   oofb_t_oofb011 LIKE oofb_t.oofb011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t8_imaal003 LIKE imaal_t.imaal003, 
   l_xmdo002_ooag011 LIKE type_t.chr300, 
   l_xmdo003_ooefl003 LIKE type_t.chr1000, 
   x_t8_imaal004 LIKE imaal_t.imaal004, 
   l_xmdo010_desc LIKE type_t.chr100, 
   l_xmdo022_desc LIKE type_t.chr100, 
   l_xmdo023_desc LIKE type_t.chr100, 
   l_xmdo008_address LIKE type_t.chr300, 
   l_xmdo009_address LIKE type_t.chr300, 
   l_xmdosite_desc LIKE ooefl_t.ooefl006, 
   l_xmdp025_026 LIKE type_t.num20_6, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_xmdo009_pmaal003 LIKE type_t.chr1000, 
   l_xmdo008_pmaal003 LIKE type_t.chr1000, 
   l_xmdo007_pmaal003 LIKE type_t.chr1000, 
   l_xmdo019_pmaal003 LIKE type_t.chr1000, 
   t3_pmaal003 LIKE pmaal_t.pmaal003, 
   t4_pmaal003 LIKE pmaal_t.pmaal003, 
   t5_pmaal003 LIKE pmaal_t.pmaal003, 
   t3_pmaal004 LIKE pmaal_t.pmaal004, 
   l_xmda033 LIKE xmda_t.xmda033, 
   l_xmdo011_desc LIKE oocql_t.oocql004, 
   l_xmdo021_desc LIKE oocql_t.oocql004, 
   l_xmdo009_pmaj002 LIKE pmaj_t.pmaj002, 
   l_xmdo009_tel_fax LIKE type_t.chr1000, 
   xmdo030 LIKE xmdo_t.xmdo030, 
   xmdo031 LIKE xmdo_t.xmdo031, 
   xmdo032 LIKE xmdo_t.xmdo032
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_pmaa027       LIKE pmaa_t.pmaa027 
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_oocq019       LIKE oocq_t.oocq019
   DEFINE l_xmdp025       LIKE xmdp_t.xmdp025
   #ming 20141210 add -------------------------(S) 
   DEFINE l_xmda033       LIKE xmda_t.xmda033
   DEFINE l_xmdo005       LIKE xmdo_t.xmdo005
   DEFINE l_sql           STRING
   #ming 20141210 add -------------------------(E) 
   DEFINE l_pmaj002       LIKE pmaj_t.pmaj002  #add--2015/09/09 By shiun
   DEFINE l_tel           LIKE oofc_t.oofc012  #add--2015/09/09 By shiun
   DEFINE l_fax           LIKE oofc_t.oofc012  #add--2015/09/09 By shiun
   DEFINE l_xmda026       LIKE xmda_t.xmda026  #150925 by whitney add
   DEFINE r_pmak003       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#14 add
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#14 add
   DEFINE p_type          LIKE type_t.num5                          #161207-00033#14 add  
   DEFINE l_sql1           STRING                                   #161207-00033#14 add
#161031-00024#4 Add By Ken 170125(S)
DEFINE l_slip_tmp       LIKE ooba_t.ooba002      #單據別   
DEFINE l_gzcb002        LIKE gzcb_t.gzcb002      #單據別參數
DEFINE l_cnt_chk        LIKE type_t.num10
#161031-00024#4 Add By Ken 170125(E)   
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #161207-00033#14-s add
    LET l_sql = "SELECT pmaa004 FROM pmaa_t",
                " WHERE pmaaent ='",g_enterprise,"'",
                "   AND pmaa001 = ?  "
    PREPARE axmr620_pb FROM l_sql
    #161207-00033#14-e add
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr620_g01_curs INTO sr_s.*
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
       SELECT ooefl006 INTO sr_s.l_xmdosite_desc
         FROM ooefl_t
        WHERE ooeflent = sr_s.xmdoent
          AND ooefl001 = sr_s.xmdosite
          AND ooefl002 = g_dlang
       #150925 by whitney modify start
       #送貨
       LET l_pmaa027 = ''
       SELECT pmaa027 INTO l_pmaa027
         FROM pmaa_t
        WHERE pmaaent = g_enterprise
          AND pmaa001 = sr_s.xmdo009
       IF NOT cl_null(l_pmaa027) AND NOT cl_null(sr_s.xmdo020) THEN
          CALL s_aooi350_get_address(l_pmaa027,sr_s.xmdo020,g_lang) RETURNING l_success,sr_s.l_xmdo009_address
       END IF
       #帳款
       LET l_pmaa027 = ''
       LET l_xmda026 = ''
       SELECT pmaa027,xmda026 INTO l_pmaa027,l_xmda026
         FROM xmda_t,xmdg_t,pmaa_t
        WHERE xmdaent = xmdgent
          AND xmdadocno = xmdg004
          AND xmdgent = g_enterprise
          AND xmdgdocno = sr_s.xmdo005
          AND pmaaent = xmdaent
          AND pmaa001 = xmda021
       IF NOT cl_null(l_pmaa027) AND NOT cl_null(l_xmda026) THEN
          CALL s_aooi350_get_address(l_pmaa027,l_xmda026,g_lang) RETURNING l_success,sr_s.l_xmdo008_address
       END IF
       #150925 by whitney modify end
       
       LET sr_s.l_xmdo008_address = sr_s.t4_pmaal003 CLIPPED,ASCII 13, ASCII 10,sr_s.l_xmdo008_address CLIPPED
       LET sr_s.l_xmdo009_address = sr_s.t5_pmaal003 CLIPPED,ASCII 13, ASCII 10,sr_s.l_xmdo009_address CLIPPED
       
       #付款條件說明   
        SELECT ooibl004 INTO sr_s.l_xmdo010_desc
         FROM ooibl_t
        WHERE ooiblent = sr_s.xmdoent
          AND ooibl002 = sr_s.xmdo010
          AND ooibl003 = g_dlang
       #add--2015/08/28 By shiun--(S)
       CALL s_apmi011_location_ref(sr_s.xmdo021,sr_s.xmdo022) RETURNING sr_s.l_xmdo022_desc
       CALL s_apmi011_location_ref(sr_s.xmdo021,sr_s.xmdo023) RETURNING sr_s.l_xmdo023_desc
       #add--2015/08/28 By shiun--(E)
       #mark--2015/08/28 By shiun--(S)
#       #交運起點
#       LET l_oocq019 = ''
#       IF NOT cl_null(sr_s.xmdo021) THEN
#          SELECT oocq019 INTO l_oocq019
#            FROM oocq_t WHERE oocq001='263' AND oocq002= sr_s.xmdo021
#       END IF
#      
#       IF NOT cl_null(l_oocq019) THEN
#          CASE
#             WHEN l_oocq019 ='1' OR l_oocq019 ='4'
#                INITIALIZE g_ref_fields TO NULL
#                LET g_ref_fields[1] = sr_s.xmdo022
#                CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmdoent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#                LET sr_s.l_xmdo022_desc = '', g_rtn_fields[1] , ''
#             WHEN l_oocq019 ='2' 
#                INITIALIZE g_ref_fields TO NULL
#                LET g_ref_fields[1] = sr_s.xmdo022
#                CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||sr_s.xmdoent||"' AND oocql002=? AND oocql001 = '262' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#                LET sr_s.l_xmdo022_desc = '', g_rtn_fields[1] , ''
#             WHEN  l_oocq019 ='3'
#                INITIALIZE g_ref_fields TO NULL
#                LET g_ref_fields[1] = sr_s.xmdo022
#                CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||sr_s.xmdoent||"' AND oocql002=? AND oocql001 = '276' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#                LET sr_s.l_xmdo022_desc = '', g_rtn_fields[1] , ''
#          END CASE
#        ELSE
#           INITIALIZE g_ref_fields TO NULL
#           LET g_ref_fields[1] = sr_s.xmdo022
#           CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmdoent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#           LET sr_s.l_xmdo022_desc = '', g_rtn_fields[1] , ''         
#        END IF
#      
#       #交運終點
#       LET l_oocq019 = ''
#       IF NOT cl_null(sr_s.xmdo021) THEN
#          SELECT oocq019 INTO l_oocq019
#            FROM oocq_t WHERE oocq001='263' AND oocq002= sr_s.xmdo021
#       END IF
#      
#       IF NOT cl_null(l_oocq019) THEN
#          CASE
#             WHEN l_oocq019 ='1' OR l_oocq019 ='4'
#                INITIALIZE g_ref_fields TO NULL
#                LET g_ref_fields[1] = sr_s.xmdo023
#                CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmdoent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#                LET sr_s.l_xmdo023_desc = '', g_rtn_fields[1] , ''
#             WHEN l_oocq019 ='2' OR l_oocq019 ='3'
#                INITIALIZE g_ref_fields TO NULL
#                LET g_ref_fields[1] = sr_s.xmdo023
#                CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||sr_s.xmdoent||"' AND oocql002=? AND oocql001 = '262' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#                LET sr_s.l_xmdo023_desc = '', g_rtn_fields[1] , ''
#             WHEN l_oocq019 ='2' OR l_oocq019 ='3'
#                INITIALIZE g_ref_fields TO NULL
#                LET g_ref_fields[1] = sr_s.xmdo023
#                CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||sr_s.xmdoent||"' AND oocql002=? AND oocql001 = '276' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#                LET sr_s.l_xmdo023_desc = '', g_rtn_fields[1] , '' 
#          END CASE
#       ELSE
#          INITIALIZE g_ref_fields TO NULL
#          LET g_ref_fields[1] = sr_s.xmdo023
#          CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmdoent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#          LET sr_s.l_xmdo023_desc = '', g_rtn_fields[1] , ''         
#       END IF
       #mark--2015/08/28 By shiun--(E)
       #是否含稅
       IF sr_s.xmdo014 = 'N' THEN
          LET sr_s.l_xmdp025_026 = sr_s.xmdp024 #未稅
       ELSE 
          LET sr_s.l_xmdp025_026 = sr_s.xmdp025 #含稅
       END IF
       #add--2015/06/30 By shiun--(S)
       SELECT xmda033 INTO sr_s.l_xmda033
         FROM xmda_t
        WHERE xmdaent = g_enterprise
          AND xmdadocno = sr_s.xmdp003
       CALL s_axmi210_ins_tmp_table(sr_s.xmdp008,sr_s.x_t8_imaal003,sr_s.t3_pmaal004,sr_s.l_xmda033,sr_s.xmdp003,sr_s.l_xmdo022_desc,sr_s.l_xmdo023_desc,'','','','','',sr_s.xmdodocno) RETURNING l_success
       #add--2015/06/30 By shiun--(E)
       #add--2015/09/09 By shiun--(S)
       #客戶連絡人
       LET l_pmaj002 = ''
       LET sr_s.l_xmdo009_pmaj002 = ''
       SELECT pmaj002 INTO l_pmaj002
         FROM pmaj_t 
        WHERE pmajent = g_enterprise
          AND pmaj001 = sr_s.xmdo009
          AND pmajstus = 'Y' 
          AND pmaj004 = 'Y'
       IF cl_null(sr_s.xmdo009) OR cl_null(l_pmaj002) THEN
          LET sr_s.l_xmdo009_pmaj002 = ''
       ELSE
          SELECT pmaj012 INTO sr_s.l_xmdo009_pmaj002
            FROM pmaj_t
           WHERE pmajent = g_enterprise
             AND pmaj001 = sr_s.xmdo009
             AND pmaj002 = l_pmaj002
       END IF
       IF NOT cl_null(l_pmaj002) THEN
          CALL axmr620_g01_get_oofc012(l_pmaj002,'1') RETURNING l_tel
          CALL axmr620_g01_get_oofc012(l_pmaj002,'3') RETURNING l_fax
       END IF
       IF NOT cl_null(l_tel) AND NOT cl_null(l_fax) THEN
          LET sr_s.l_xmdo009_tel_fax = l_tel || "/" || l_fax
       ELSE
          LET sr_s.l_xmdo009_tel_fax = l_tel , "/" , l_fax
       END IF
       CALL s_desc_get_acc_desc('238',sr_s.xmdo011) RETURNING sr_s.l_xmdo011_desc
       CALL s_desc_get_acc_desc('263',sr_s.xmdo021) RETURNING sr_s.l_xmdo021_desc
       #add--2015/09/09 By shiun--(E)
       #161207-00033#14-s add
       EXECUTE axmr620_pb USING sr_s.xmdo007 INTO l_pmaa004
       IF l_pmaa004 = '2' THEN   #2.一次性交易對象
          CASE sr_s.xmdo004
            WHEN '1' #出通
                LET p_type = '2'
            WHEN '2' #出貨
                LET p_type = '3'                  
          END CASE
          #一次性交易對象全名
          CALL s_desc_axm_get_oneturn_guest_desc(p_type,sr_s.xmdo005)
               RETURNING r_pmak003               
          IF NOT cl_null(r_pmak003) THEN
             LET sr_s.l_xmdo007_pmaal003 = sr_s.xmdo007,".",r_pmak003
             IF sr_s.xmdo008 = sr_s.xmdo007 THEN   #帳款客戶
                LET sr_s.l_xmdo008_address = sr_s.l_xmdo007_pmaal003
             END IF
             IF sr_s.xmdo009 = sr_s.xmdo007 THEN   #收貨客戶
                LET sr_s.l_xmdo009_address = sr_s.l_xmdo007_pmaal003
             END IF
          END IF 
       END IF          
       #161207-00033#14-e add 
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #ming 20141210 add ------------------------(S)  
       #Original Order No: invoice來源為出貨/出通單時，回串至訂單抓取客戶訂購單號(xmda033)
       IF sr_s.xmdo004 = '1' OR sr_s.xmdo004 = '2' THEN
          IF NOT cl_null(sr_s.xmdo005) THEN
             LET l_sql = "SELECT DISTINCT xmda033 ",
                         "  FROM xmdg_t,xmdh_t,xmda_t ",
                         " WHERE xmdgent   = xmdhent ",
                         "   AND xmdgsite  = xmdhsite ",
                         "   AND xmdgdocno = xmdhdocno ",
                         "   AND xmdgdocno = '",sr_s.xmdo005,"' ",
                         "   AND xmdhent   = xmdaent ",
                         "   AND xmdhsite  = xmdasite ",
                         "   AND xmdh001   = xmdadocno ",
                         " ORDER BY xmda033 "
             PREPARE axmr620_g01_xmda_prep FROM l_sql
             DECLARE axmr620_g01_xmda_curs CURSOR FOR axmr620_g01_xmda_prep

             LET l_xmda033 = ''
             LET l_xmdo005 = ''
             FOREACH axmr620_g01_xmda_curs INTO l_xmda033
                IF cl_null(l_xmdo005) THEN
                   LET l_xmdo005 = l_xmda033
                ELSE
                   LET l_xmdo005 = l_xmdo005,",",l_xmda033
                END IF

                LET l_xmda033 = ''
             END FOREACH 
             
             IF NOT cl_null(l_xmdo005) THEN
                LET sr_s.xmdo005 = l_xmdo005
             END IF
          END IF
       END IF
       #ming 20141210 add ------------------------(E)  

       #161031-00024#4 Add By Ken 170125(S)
       IF tm.c1 = 'Y' THEN
          LET l_gzcb002 = ''
          #如單據的額外品名規格分類不為空白，則使用單據的分類
          IF NOT cl_null(sr_s.xmdo029) THEN
             LET l_gzcb002 = sr_s.xmdo029
          ELSE
             #先取得單別
             LET l_success = ''
             LET l_slip_tmp = ''
             CALL s_aooi200_get_slip(sr_s.xmdodocno)
                RETURNING l_success,l_slip_tmp
             
             #取得單別參數
             CALL cl_get_doc_para(g_enterprise,g_site,l_slip_tmp,'D-MFG-0087')
                RETURNING l_gzcb002          
          END IF
                    
          IF NOT cl_null(l_gzcb002) THEN
             LET l_cnt_chk = 0
             SELECT COUNT(1) INTO l_cnt_chk
               FROM imab_t
              WHERE imabent = g_enterprise
                AND imab001 = sr_s.xmdp008
                AND imab002 = l_gzcb002
                AND imabstus = 'Y'
                AND (imab005 IS NOT NULL OR imab005<>'')                 
             IF l_cnt_chk > 0 THEN
                CALL s_desc_get_imab004_desc(sr_s.xmdp008,l_gzcb002) RETURNING sr_s.x_t8_imaal003
                IF NOT cl_null(sr_s.x_t8_imaal003) THEN
                   LET sr_s.x_t8_imaal004 = ''
                END IF
             END IF
          END IF
       END IF
       #161031-00024#4 Add By Ken 170125(E)    
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmdo001 = sr_s.xmdo001
       LET sr[l_cnt].xmdo002 = sr_s.xmdo002
       LET sr[l_cnt].xmdo003 = sr_s.xmdo003
       LET sr[l_cnt].xmdo004 = sr_s.xmdo004
       LET sr[l_cnt].xmdo005 = sr_s.xmdo005
       LET sr[l_cnt].xmdo007 = sr_s.xmdo007
       LET sr[l_cnt].xmdo008 = sr_s.xmdo008
       LET sr[l_cnt].xmdo009 = sr_s.xmdo009
       LET sr[l_cnt].xmdo010 = sr_s.xmdo010
       LET sr[l_cnt].xmdo011 = sr_s.xmdo011
       LET sr[l_cnt].xmdo012 = sr_s.xmdo012
       LET sr[l_cnt].xmdo013 = sr_s.xmdo013
       LET sr[l_cnt].xmdo014 = sr_s.xmdo014
       LET sr[l_cnt].xmdo015 = sr_s.xmdo015
       LET sr[l_cnt].xmdo016 = sr_s.xmdo016
       LET sr[l_cnt].xmdo017 = sr_s.xmdo017
       LET sr[l_cnt].xmdo019 = sr_s.xmdo019
       LET sr[l_cnt].xmdo020 = sr_s.xmdo020
       LET sr[l_cnt].xmdo021 = sr_s.xmdo021
       LET sr[l_cnt].xmdo022 = sr_s.xmdo022
       LET sr[l_cnt].xmdo023 = sr_s.xmdo023
       LET sr[l_cnt].xmdo024 = sr_s.xmdo024
       LET sr[l_cnt].xmdo025 = sr_s.xmdo025
       LET sr[l_cnt].xmdo026 = sr_s.xmdo026
       LET sr[l_cnt].xmdo029 = sr_s.xmdo029
       LET sr[l_cnt].xmdo053 = sr_s.xmdo053
       LET sr[l_cnt].xmdodocdt = sr_s.xmdodocdt
       LET sr[l_cnt].xmdodocno = sr_s.xmdodocno
       LET sr[l_cnt].xmdoent = sr_s.xmdoent
       LET sr[l_cnt].xmdosite = sr_s.xmdosite
       LET sr[l_cnt].xmdostus = sr_s.xmdostus
       LET sr[l_cnt].xmdp001 = sr_s.xmdp001
       LET sr[l_cnt].xmdp002 = sr_s.xmdp002
       LET sr[l_cnt].xmdp003 = sr_s.xmdp003
       LET sr[l_cnt].xmdp004 = sr_s.xmdp004
       LET sr[l_cnt].xmdp005 = sr_s.xmdp005
       LET sr[l_cnt].xmdp006 = sr_s.xmdp006
       LET sr[l_cnt].xmdp007 = sr_s.xmdp007
       LET sr[l_cnt].xmdp008 = sr_s.xmdp008
       LET sr[l_cnt].xmdp009 = sr_s.xmdp009
       LET sr[l_cnt].xmdp010 = sr_s.xmdp010
       LET sr[l_cnt].xmdp012 = sr_s.xmdp012
       LET sr[l_cnt].xmdp013 = sr_s.xmdp013
       LET sr[l_cnt].xmdp014 = sr_s.xmdp014
       LET sr[l_cnt].xmdp015 = sr_s.xmdp015
       LET sr[l_cnt].xmdp016 = sr_s.xmdp016
       LET sr[l_cnt].xmdp017 = sr_s.xmdp017
       LET sr[l_cnt].xmdp018 = sr_s.xmdp018
       LET sr[l_cnt].xmdp019 = sr_s.xmdp019
       LET sr[l_cnt].xmdp020 = sr_s.xmdp020
       LET sr[l_cnt].xmdp021 = sr_s.xmdp021
       LET sr[l_cnt].xmdp022 = sr_s.xmdp022
       LET sr[l_cnt].xmdp023 = sr_s.xmdp023
       LET sr[l_cnt].xmdp024 = sr_s.xmdp024
       LET sr[l_cnt].xmdp025 = sr_s.xmdp025
       LET sr[l_cnt].xmdp026 = sr_s.xmdp026
       LET sr[l_cnt].xmdp040 = sr_s.xmdp040
       LET sr[l_cnt].xmdpseq = sr_s.xmdpseq
       LET sr[l_cnt].xmdpsite = sr_s.xmdpsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].oofb_t_oofb011 = sr_s.oofb_t_oofb011
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t8_imaal003 = sr_s.x_t8_imaal003
       LET sr[l_cnt].l_xmdo002_ooag011 = sr_s.l_xmdo002_ooag011
       LET sr[l_cnt].l_xmdo003_ooefl003 = sr_s.l_xmdo003_ooefl003
       LET sr[l_cnt].x_t8_imaal004 = sr_s.x_t8_imaal004
       LET sr[l_cnt].l_xmdo010_desc = sr_s.l_xmdo010_desc
       LET sr[l_cnt].l_xmdo022_desc = sr_s.l_xmdo022_desc
       LET sr[l_cnt].l_xmdo023_desc = sr_s.l_xmdo023_desc
       LET sr[l_cnt].l_xmdo008_address = sr_s.l_xmdo008_address
       LET sr[l_cnt].l_xmdo009_address = sr_s.l_xmdo009_address
       LET sr[l_cnt].l_xmdosite_desc = sr_s.l_xmdosite_desc
       LET sr[l_cnt].l_xmdp025_026 = sr_s.l_xmdp025_026
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].l_xmdo009_pmaal003 = sr_s.l_xmdo009_pmaal003
       LET sr[l_cnt].l_xmdo008_pmaal003 = sr_s.l_xmdo008_pmaal003
       LET sr[l_cnt].l_xmdo007_pmaal003 = sr_s.l_xmdo007_pmaal003
       LET sr[l_cnt].l_xmdo019_pmaal003 = sr_s.l_xmdo019_pmaal003
       LET sr[l_cnt].t3_pmaal003 = sr_s.t3_pmaal003
       LET sr[l_cnt].t4_pmaal003 = sr_s.t4_pmaal003
       LET sr[l_cnt].t5_pmaal003 = sr_s.t5_pmaal003
       LET sr[l_cnt].t3_pmaal004 = sr_s.t3_pmaal004
       LET sr[l_cnt].l_xmda033 = sr_s.l_xmda033
       LET sr[l_cnt].l_xmdo011_desc = sr_s.l_xmdo011_desc
       LET sr[l_cnt].l_xmdo021_desc = sr_s.l_xmdo021_desc
       LET sr[l_cnt].l_xmdo009_pmaj002 = sr_s.l_xmdo009_pmaj002
       LET sr[l_cnt].l_xmdo009_tel_fax = sr_s.l_xmdo009_tel_fax
       LET sr[l_cnt].xmdo030 = sr_s.xmdo030
       LET sr[l_cnt].xmdo031 = sr_s.xmdo031
       LET sr[l_cnt].xmdo032 = sr_s.xmdo032
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr620_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr620_g01_rep_data()
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
          START REPORT axmr620_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr620_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr620_g01_rep
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
 
{<section id="axmr620_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr620_g01_rep(sr1)
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
DEFINE l_xmdo053_show       LIKE type_t.chr1     #單頭備註
DEFINE l_xmdp040_show       LIKE type_t.chr1     #單身備註
DEFINE l_xmdo005_show       LIKE type_t.chr1     #來源單號
DEFINE l_xmdp019_show       LIKE type_t.chr1     #產品特徵
DEFINE l_xmdp_sum           LIKE type_t.num20_6  #金額總計
DEFINE l_xmdp_sum_eng       LIKE type_t.chr100   #金額英文
DEFINE l_xmdp_sum_show   LIKE type_t.chr1
#add--2015/05/29 By shiun--(S)
DEFINE l_xmao001   LIKE xmao_t.xmao001         #客戶編號
DEFINE l_xmao002   LIKE xmao_t.xmao002         #嘜頭編號
DEFINE l_xmao003   LIKE xmao_t.xmao003         #變數內容多筆時顯示方式
DEFINE l_xmao004   LIKE xmao_t.xmao004         #顯示符號
DEFINE sr3 sr3_r
DEFINE l_xmap006   STRING #資料內容
DEFINE l_out       STRING #輸出內容
DEFINE l_load      STRING #xmap006暫存內容
DEFINE l_str       STRING #擷取參數
DEFINE l_length    LIKE type_t.num5   #總長度
DEFINE l_n         LIKE type_t.num5   #起始位置(判斷用)
DEFINE l_n1        LIKE type_t.num5   #第一個&位置
DEFINE l_n2        LIKE type_t.num5   #第二個&位置
DEFINE l_min       LIKE type_t.num5   #第一筆資料
#add--2015/05/29 By shiun--(E)
#add--2015/08/17 By shiun--(S)
DEFINE sr4 sr4_r
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
DEFINE l_xmap006_array   LIKE xmap_t.xmap006         #資料內容
DEFINE l_xmap003         LIKE xmap_t.xmap003         #類別
DEFINE l_xmap004         LIKE xmap_t.xmap004         #行序
DEFINE l_xmda004_credit_show    LIKE  type_t.chr1      #額度是否超限顯示
DEFINE l_xmaj002_1     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(據點)
DEFINE l_xmaj002_2     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(集團)
#add--2015/08/17 By shiun--(E)
#161205-00042#5-add-s
DEFINE l_js              STRING
DEFINE l_loaa001         LIKE loaa_t.loaa001
DEFINE l_xmap006_img     LIKE type_t.chr1000      #資料內容(圖片)
DEFINE l_xmap006_img_arr DYNAMIC ARRAY OF STRING
DEFINE l_imgstr          LIKE xmap_t.xmap006      #圖中字內容
#161205-00042#5-add-e
DEFINe ls_url_surc  STRING   #161205-00042#5-add
DEFINe ls_url_dest  STRING   #161205-00042#5-add
DEFINE l_imaal004_show   LIKE type_t.chr1      #161031-00024#4 Add By ken 170206
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.xmdodocno,sr1.xmdpseq
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
        BEFORE GROUP OF sr1.xmdodocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmdodocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmdoent=' ,sr1.xmdoent,'{+}xmdodocno=' ,sr1.xmdodocno         
            CALL cl_gr_init_apr(sr1.xmdodocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmdodocno.before name="rep.b_group.xmdodocno.before"
 
           #xmdo053 備註單頭隱藏
           INITIALIZE l_xmdo053_show TO NULL
           IF cl_null(sr1.xmdo053) THEN
              LET l_xmdo053_show = "N"
           ELSE
              LET l_xmdo053_show = "Y"
           END IF
           
           PRINTX l_xmdo053_show
           
           #來源單號
           INITIALIZE l_xmdo005_show TO NULL
           IF cl_null(sr1.xmdo005) THEN
              LET l_xmdo005_show = "N"
           ELSE
              LET l_xmdo005_show = "Y"
           END IF
           
           PRINTX l_xmdo005_show
           
           #161031-00024#4 Add By Ken 170206(S)
           #規格若為空，則隱藏
           INITIALIZE l_imaal004_show TO NULL
           IF cl_null(sr1.x_t8_imaal004) THEN
              LET l_imaal004_show = 'N'
           ELSE
              LET l_imaal004_show = 'Y'
           END IF
           PRINTX l_imaal004_show
           #161031-00024#4 Add By Ken 170206(E)           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmdoent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdodocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr620_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr620_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr620_g01_subrep01
           DECLARE axmr620_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr620_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr620_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr620_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr620_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmdodocno.after name="rep.b_group.xmdodocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmdpseq
 
           #add-point:rep.b_group.xmdpseq.before name="rep.b_group.xmdpseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmdpseq.after name="rep.b_group.xmdpseq.after"
           
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
                sr1.xmdoent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdodocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdpseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr620_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr620_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr620_g01_subrep02
           DECLARE axmr620_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr620_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr620_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr620_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr620_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
            # 備註單身隱藏
            INITIALIZE l_xmdp040_show TO NULL
            IF cl_null(sr1.xmdp040) THEN
               LET l_xmdp040_show = "N"
            ELSE
               LET l_xmdp040_show = "Y"
            END IF
                                 
            PRINTX l_xmdp040_show
            
            # 產品特徵隱藏
            INITIALIZE l_xmdp019_show TO NULL
            IF cl_null(sr1.xmdp019) THEN
               LET l_xmdp019_show = "N"
            ELSE
               LET l_xmdp019_show = "Y"
            END IF
                                 
            PRINTX l_xmdp019_show
            
            
            
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
                sr1.xmdoent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdodocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmdpseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr620_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr620_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr620_g01_subrep03
           DECLARE axmr620_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr620_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr620_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr620_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr620_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdodocno
 
           #add-point:rep.a_group.xmdodocno.before name="rep.a_group.xmdodocno.before"
           
           #總金額含稅否
           LET l_xmdp_sum  = ''
           LET l_xmdp_sum_eng = ''
           IF NOT cl_null(sr1.xmdp024) OR NOT cl_null(sr1.xmdp025) THEN
              IF sr1.xmdo014 = 'N' THEN            
                 LET l_xmdp_sum = GROUP SUM(sr1.xmdp024)  #未稅         
                 CALL s_num_to_english (l_xmdp_sum) RETURNING l_xmdp_sum_eng
                 #dorislai-20150831-modfiy----(S)
#                 LET l_xmdp_sum_eng = "PAY TOTAL"," ",sr1.xmdo016," ",l_xmdp_sum_eng 
                 LET l_xmdp_sum_eng = "SAY TOTAL"," ",sr1.xmdo016," ",l_xmdp_sum_eng 
                 #dorislai-20150831-modify----(E)                      
              ELSE
                 LET l_xmdp_sum = GROUP SUM(sr1.xmdp025)  #含稅        
                 CALL s_num_to_english (l_xmdp_sum) RETURNING l_xmdp_sum_eng
                 #dorislai-20150831-modfiy----(S)
#                 LET l_xmdp_sum_eng = "PAY TOTAL"," ",sr1.xmdo016," ",l_xmdp_sum_eng  
                 LET l_xmdp_sum_eng = "SAY TOTAL"," ",sr1.xmdo016," ",l_xmdp_sum_eng  
                 #dorislai-20150831-modify----(E)                 
              END IF  
           END IF
           PRINTX l_xmdp_sum
           PRINTX l_xmdp_sum_eng  
           
           IF cl_null(l_xmdp_sum) THEN
              LET l_xmdp_sum_show  = 'N'
           ELSE
              LET l_xmdp_sum_show  = 'Y'
           END IF
           PRINTX l_xmdp_sum_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmdoent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmdodocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr620_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr620_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr620_g01_subrep04
           DECLARE axmr620_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr620_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr620_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr620_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr620_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmdodocno.after name="rep.a_group.xmdodocno.after"
           #嘜頭子報表
           START REPORT axmr620_g01_subrep05
              CASE
                 WHEN sr1.xmdo004 = '1'  #出貨通知單axmt520    
                    SELECT xmdg005,xmdg023 INTO l_xmao001,l_xmao002
                      FROM xmdg_t
                     WHERE xmdgdocno = sr1.xmdo005 
                       AND xmdgent = sr1.xmdoent
                 WHEN sr1.xmdo004 = '2'
                    SELECT xmdk007,xmdk027 INTO l_xmao001,l_xmao002
                      FROM xmdk_t  
                     WHERE xmdkdocno = sr1.xmdo005 
                       AND xmdkent = sr1.xmdoent
              END CASE
              IF NOT cl_null(l_xmao001) AND NOT cl_null(l_xmao002) THEN
                 CALL axmr620_g01_cre_tmp_table()  #add--2015/08/17 By shiun
                 #161205-00042#5-mod-s
#                LET g_sql = " SELECT xmao003,xmao004,xmao001,xmao002,xmap003,xmap004,xmap005,xmap006 ",
                 LET g_sql = " SELECT xmao003,xmao004,xmao001,xmao002,xmap003,xmap004,xmap005,xmap006,'','','','','' ",
                 #161205-00042#5-mod-e
                             "   FROM xmao_t,xmap_t ",
                             "  WHERE xmaoent = xmapent",
                             "    AND xmao001 = xmap001",
                             "    AND xmao002 = xmap002",
                             "    AND xmaoent = '",sr1.xmdoent,"' ",
                             "    AND xmao001 = '",l_xmao001,"'",
                             "    AND xmao002 = '",l_xmao002,"'",
                             "  ORDER BY xmap003,xmap004 "
                 DECLARE axmr620_g01_repcur05 CURSOR FROM g_sql   
                 #161205-00042#5-mod-s
#                LET l_tmp_sql = " INSERT INTO axmr620_tmp01 (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap003_show) VALUES (?,?,?,?,?,?,?) "  
                 LET l_tmp_sql = " INSERT INTO axmr620_tmp01 (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show) VALUES (?,?,?,?,?, ?,?,?,?) "  
                 LET l_xmao003 = ''
                 LET l_xmao004 = ''
                 #161205-00042#5-mod-e                   
                 #add--2015/08/17 By shiun--(S)
                 #161205-00042#5-mod-s
                 #LET l_tmp_sql = " INSERT INTO axmr620_tmp01 (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap003_show) VALUES (?,?,?,?,?,?,?) " 
                 LET l_tmp_sql = " INSERT INTO axmr620_tmp01 (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show) VALUES (?,?,?,?,?,?,?,?,?) "
                 #161205-00042#5-mod-e
                 #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01
                 PREPARE master_tmp FROM l_tmp_sql
                 #add--2015/08/17 By shiun--(E)
                 FOREACH axmr620_g01_repcur05 INTO l_xmao003,l_xmao004,sr3.*
                    CALL s_desc_gzcbl004_desc('2102',sr3.xmap003) RETURNING sr3.l_xmap003_desc
                    CALL s_desc_gzcbl004_desc('2100',sr3.xmap005) RETURNING sr3.l_xmap005_desc
                    LET l_n = 1
                    LET l_load =''
                    WHILE TRUE
                     LET l_xmap006 = sr3.xmap006
                     LET l_length = LENGTH(l_xmap006)
                     LET l_n1 = l_xmap006.getIndexOf('&',l_n)
                     LET l_n2 = l_xmap006.getIndexOf('&',l_n1+1)
                     IF l_n1 != 0 AND l_n2 != 0 THEN
                        LET l_str = l_xmap006.subString(l_n1+1,l_n2-1)
                        IF cl_null(l_load) THEN
                           LET l_load = l_xmap006.subString(l_n,l_n1-1)
                        ELSE
                           LET l_load = l_load || l_xmap006.subString(l_n,l_n1-1)
                        END IF                        
                        CALL s_axmi210_assemble(sr1.xmdodocno,l_str,l_xmao003,l_xmao004) RETURNING l_out
                        IF cl_null(l_load) THEN
                           LET l_load = l_out
                        ELSE
                           LET l_load = l_load || l_out
                        END IF    
                        LET l_n = l_n2 + 1
                     ELSE
                        IF NOT cl_null(l_load) THEN
                           LET sr3.xmap006 = l_load
                        END IF
                        EXIT WHILE
                     END IF
                    END WHILE
                    #add--2015/07/20 By shiun--(S)
                    SELECT MIN(xmap004) INTO l_min
                      FROM xmap_t
                     WHERE xmapent = sr1.xmdoent
                       AND xmap001 = l_xmao001
                       AND xmap002 = l_xmao002
                       AND xmap003 = sr3.xmap003
                    IF sr3.xmap004 = l_min THEN
                       LET sr3.l_xmap003_show = 'Y'
                    ELSE
                       LET sr3.l_xmap003_show = 'N'
                    END IF
                    #add--2015/07/20 By shiun--(E)
                    #161205-00042#5-add-s
                    CASE sr3.xmap005
                       WHEN '2'
                          LET l_js = ''
                          LET l_loaa001 = ''
                          LET g_pk_array[1].values = sr3.xmao001
                          LET g_pk_array[1].column = 'xmap001'
                          LET g_pk_array[2].values = sr3.xmao002
                          LET g_pk_array[2].column = 'xmap002'
                          LET g_pk_array[3].values = sr3.xmap003
                          LET g_pk_array[3].column = 'xmap003'
                          LET g_pk_array[4].values = sr3.xmap004
                          LET g_pk_array[4].column = 'xmap004'                          
                          LET l_js = util.JSON.stringify(g_pk_array)
                          LET l_loaa001 = l_js.trim()
                          LET l_xmap006_img_arr = cl_doc_open_attach(l_loaa001,"","","2")
                          LET sr3.l_xmap006_img = l_xmap006_img_arr[1]
                       WHEN '3'
                          CASE sr3.xmap006
                             WHEN "diamond"
                                 #source pic
                                 LET ls_url_surc = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"res/img/ui/application"),"diamond.png")
                                #destination pic
                                 LET ls_url_dest = os.Path.join(FGL_GETENV("TEMPDIR"),"diamond.png")
                                 LET sr3.l_xmap006_img = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"diamond.png")
                                 IF NOT os.path.exists(ls_url_dest) THEN
                                   IF os.path.copy(ls_url_surc,ls_url_dest) THEN 
                                      LET sr3.l_xmap006_img  = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"diamond.png")
                                   ELSE
                                      #copy error, get notfound pic
                                      LET sr3.l_xmap006_img = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"pic"),"reptpic"),"no_logo.png")
                                   END IF
                                 END IF                       
                             WHEN "triangle"
                                 #source pic
                                 LET ls_url_surc = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"res/img/ui/application"),"triangle.png")
                                 #destination pic
                                 LET ls_url_dest = os.Path.join(FGL_GETENV("TEMPDIR"),"triangle.png")
                                 LET sr3.l_xmap006_img = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"triangle.png")
                                 IF NOT os.path.exists(ls_url_dest) THEN
                                   IF os.path.copy(ls_url_surc,ls_url_dest) THEN 
                                      LET sr3.l_xmap006_img  = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),"triangle.png")
                                   ELSE
                                      #copy error, get notfound pic
                                      LET sr3.l_xmap006_img = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"pic"),"reptpic"),"no_logo.png")
                                   END IF
                                 END IF                                  
                          END CASE
                       WHEN '4' 
                          LET sr3.l_imgstr = sr3.xmap006
                    END CASE
                    IF cl_null(sr3.l_xmap006_img) THEN
                       LET sr3.l_xmap006_img = ' '
                    END IF
                    #161205-00042#5-add-e            
                    #161205-00042#5-mod-s
#                   EXECUTE master_tmp USING sr3.xmao001,sr3.xmao002,sr3.xmap003,sr3.l_xmap003_desc,sr3.xmap004,sr3.xmap006,sr3.l_xmap003_show
                    #add--2015/08/12 By shiun
                    EXECUTE master_tmp USING sr3.xmao001,sr3.xmao002,sr3.xmap003,sr3.l_xmap003_desc,sr3.xmap004,sr3.xmap006,sr3.l_xmap006_img,sr3.l_imgstr,sr3.l_xmap003_show
                    #161205-00042#5-mod-e
                 END FOREACH
                 #add--2015/08/17 By shiun--(S)
                 LET l_xmap003_sql = " SELECT DISTINCT xmap003,l_xmap003_desc ",
                                     " FROM axmr620_tmp01 ",    #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01
                                     " ORDER BY xmap003"
                 #161205-00042#5-mod-s
#                 LET l_xmap006_sql = " SELECT DISTINCT xmap004,xmap006,l_xmap003_show,xmao001,xmao002 ",
                 LET l_xmap006_sql = " SELECT DISTINCT xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show,xmao001,xmao002 ",
                 #161205-00042#5-mod-e
                                     " FROM axmr620_tmp01 ",    #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01
                                     " WHERE l_xmap003_desc = ?",
                                     " ORDER BY xmap004"
                 DECLARE axmr620_g01_xmap003 CURSOR FROM l_xmap003_sql 
                 
                 PREPARE axmr620_g01_xmap006_pb FROM l_xmap006_sql                 
                 DECLARE axmr620_g01_xmap006_cs CURSOR FOR axmr620_g01_xmap006_pb   
                 
                 LET l_i = 1
                 LET l_max_count = 1
                 
                 FOREACH axmr620_g01_xmap003 INTO l_xmap003,l_xmap003_desc
                    LET l_j = l_max_count
                    OPEN axmr620_g01_xmap006_cs USING l_xmap003_desc
                    
                    #161205-00042#5-mod-s
#                   FOREACH axmr620_g01_xmap006_cs INTO l_xmap004,l_xmap006_array,l_xmap003_show,l_xmao001,l_xmao002
                    FOREACH axmr620_g01_xmap006_cs INTO l_xmap004,l_xmap006_array,l_xmap006_img,l_imgstr,l_xmap003_show,l_xmao001,l_xmao002
                    #161205-00042#5-mod-e 
                       IF l_i MOD 2 = 1 THEN
                          #161205-00042#5-add-s
                          #圖中字放置，在4rp中根據預設圖檔的不同會放置不同位置&大小的圖中字
                          IF NOT cl_null(l_imgstr) THEN
                             LET sr5[l_j-1].l_imgstr_1 = l_imgstr
                             CONTINUE FOREACH
                          END IF
                          #161205-00042#5-add-e
                          IF l_xmap003_show = 'Y' THEN
                             LET sr5[l_j].l_xmap003_desc_1 = l_xmap003_desc
                          ELSE
                             LET sr5[l_j].l_xmap003_desc_1 = ' '
                          END IF
                          LET sr5[l_j].xmao001 = l_xmao001
                          LET sr5[l_j].xmao002 = l_xmao002
                          LET sr5[l_j].xmap006_1 = l_xmap006_array
                          #161205-00042#5-add-s
                          LET sr5[l_j].l_xmap006_1_img = l_xmap006_img
                          DISPLAY "sr5[l_j].l_xmap006_1_img:",sr5[l_j].l_xmap006_1_img
                          #161205-00042#5-add-e
                       ELSE
                          #161205-00042#5-add-s
                          #圖中字放置，在4rp中根據預設圖檔的不同會放置不同位置&大小的圖中字
                          IF NOT cl_null(l_imgstr) THEN
                             LET sr5[l_j-1].l_imgstr_2 = l_imgstr
                             CONTINUE FOREACH
                          END IF
                          #161205-00042#5-add-e
                          IF l_xmap003_show = 'Y' THEN
                             LET sr5[l_j].l_xmap003_desc_2 = l_xmap003_desc
                          ELSE
                             LET sr5[l_j].l_xmap003_desc_2 = ' '
                          END IF
                          LET sr5[l_j].xmao001 = l_xmao001
                          LET sr5[l_j].xmao002 = l_xmao002
                          LET sr5[l_j].xmap006_2 = l_xmap006_array
                          #161205-00042#5-add-s
                          LET sr5[l_j].l_xmap006_2_img = l_xmap006_img
                          DISPLAY "sr5[l_j].l_xmap006_2_img:",sr5[l_j].l_xmap006_2_img
                          #161205-00042#5-add-e 
                       END IF
                       LET l_j = l_j + 1
                    END FOREACH
                 
                    LET l_i = l_i + 1 
                 
                    IF l_i MOD 2 = 1 THEN
                       LET l_max_count = sr5.getLength() + 1
                    END IF
                 END FOREACH
                 LET l_ac = 1
                 LET l_while_count = sr5.getLength()
                 WHILE TRUE
                    LET sr4.xmao001 = sr5[l_ac].xmao001
                    LET sr4.xmao002 = sr5[l_ac].xmao002
                    LET sr4.l_xmap003_desc_1 = sr5[l_ac].l_xmap003_desc_1
                    LET sr4.l_xmap003_desc_2 = sr5[l_ac].l_xmap003_desc_2
                    LET sr4.xmap006_1 = sr5[l_ac].xmap006_1
                    LET sr4.xmap006_2 = sr5[l_ac].xmap006_2
                    #161205-00042#5-add-s
                    LET sr4.l_xmap006_1_img = sr5[l_ac].l_xmap006_1_img
                    LET sr4.l_xmap006_2_img = sr5[l_ac].l_xmap006_2_img            
                    LET sr4.l_imgstr_1 = sr5[l_ac].l_imgstr_1
                    LET sr4.l_imgstr_2 = sr5[l_ac].l_imgstr_2   
                    #161205-00042#5-add-e
                    OUTPUT TO REPORT axmr620_g01_subrep05(sr4.*)
                    LET l_ac = l_ac + 1
                    IF l_ac > l_while_count THEN
                       EXIT WHILE
                    END IF
                 END WHILE
                 #add--2015/08/17 BY shiun--(E)                 
              END IF
              CLOSE master_tmp   #add--2015/08/17 By shiun
           FINISH REPORT axmr620_g01_subrep05 
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmdpseq
 
           #add-point:rep.a_group.xmdpseq.before name="rep.a_group.xmdpseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmdpseq.after name="rep.a_group.xmdpseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            CALL s_axmi210_drop_tmp_table()
            CALL axmr620_g01_drop_tmp_table()   #add--2015/08/17 By shiun
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr620_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr620_g01_subrep01(sr2)
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
PRIVATE REPORT axmr620_g01_subrep02(sr2)
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
PRIVATE REPORT axmr620_g01_subrep03(sr2)
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
PRIVATE REPORT axmr620_g01_subrep04(sr2)
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
 
{<section id="axmr620_g01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axmr620_g01_cre_tmp_table()
#                  RETURNING r_success
# Input parameter: 無
# Date & Author..: 2015/08/17 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr620_g01_cre_tmp_table()
DROP TABLE axmr620_tmp01;       #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmr620_tmp01'       #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE axmr620_tmp01(         #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01
                   xmao001        LIKE xmao_t.xmao001,          #客戶編號
                   xmao002        LIKE xmao_t.xmao002,          #嘜頭編號
                   xmap003        LIKE xmap_t.xmap003,          #類別
                   l_xmap003_desc LIKE type_t.chr500,           #類別說明
                   xmap004        LIKE xmap_t.xmap004,          #行序
                   xmap006        LIKE xmap_t.xmap006,          #資料內容
                   l_xmap006_img  LIKE type_t.chr1000,          #資料內容(圖)   #161205-00042#5-add
                   l_imgstr       LIKE xmap_t.xmap006,          #圖中字內容     #161205-00042#5-add                   
                   l_xmap003_show LIKE type_t.chr1              #類別顯示否
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmr620_tmp01'       #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
END FUNCTION
################################################################################
# Descriptions...: 刪除臨時表
# Memo...........:
# Usage..........: CALL axmr620_g01_drop_tmp_table()
# Input parameter:
# Return code....:
# Date & Author..: 2015/08/17 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr620_g01_drop_tmp_table()

   DROP TABLE axmr620_tmp01;       #160727-00019#25 Mod  axmr620_g01_temp--> axmr620_tmp01

END FUNCTION
################################################################################
# Descriptions...: 取得聯絡人聯絡方式
# Memo...........:
# Usage..........: CALL axmr620_g01_get_oofc012(p_pmaj002,p_flag)
#                  RETURNING r_success,r_oofc012
# Input parameter: p_pmaj002   聯絡對象
#                : p_flag      聯絡方式(1=電話、3=傳真)
# Return code....: r_oofc012   通訊內容
# Date & Author..: 2015/09/09  By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr620_g01_get_oofc012(p_pmaj002,p_flag)
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

 
{</section>}
 
{<section id="axmr620_g01.other_report" readonly="Y" >}

PRIVATE REPORT axmr620_g01_subrep05(sr4)
   #嘜頭子報表輸出
   DEFINE sr4 sr4_r
   ORDER EXTERNAL BY sr4.xmao001,sr4.xmao002
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
END REPORT

 
{</section>}
 
