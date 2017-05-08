#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr610_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2017-02-22 20:33:29), PR版次:0013(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000651
#+ Filename...: axmr610_g01
#+ Description: ...
#+ Creator....: 05229(2014-05-26 19:13:38)
#+ Modifier...: 06021 -SD/PR- 00000
 
{</section>}
 
{<section id="axmr610_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161207-00033#14   2016/12/21   By 08992    一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#161221-00064#21   2017/01/10   By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#161205-00042#4   2016/12/23 By 08992        嘜頭預設圖片設置、圖中字位置設定
#161031-00024#3   2017/02/02 By 06137       2.報表畫面增加"列印額外品名規格"選項
#                                           2-1.打勾時，依料件編號+單別參數"額外品名規格類型"，串到aimm221抓取資料
#                                           2-2.有抓到值時，原品名規格資料不印，改印額外品名規格資料，額外品名規格資料依行序+換行符號組成一個大字串放至品名中
#                                           2-3.沒抓到值，印原品名規格
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
IMPORT util   #161205-00042#4 add
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   xmel001 LIKE xmel_t.xmel001, 
   xmel002 LIKE xmel_t.xmel002, 
   xmel003 LIKE xmel_t.xmel003, 
   xmel004 LIKE xmel_t.xmel004, 
   xmel005 LIKE xmel_t.xmel005, 
   xmel006 LIKE xmel_t.xmel006, 
   xmel007 LIKE xmel_t.xmel007, 
   xmel008 LIKE xmel_t.xmel008, 
   xmel009 LIKE xmel_t.xmel009, 
   xmel010 LIKE xmel_t.xmel010, 
   xmel011 LIKE xmel_t.xmel011, 
   xmel012 LIKE xmel_t.xmel012, 
   xmel013 LIKE xmel_t.xmel013, 
   xmel014 LIKE xmel_t.xmel014, 
   xmel015 LIKE xmel_t.xmel015, 
   xmel016 LIKE xmel_t.xmel016, 
   xmel017 LIKE xmel_t.xmel017, 
   xmel018 LIKE xmel_t.xmel018, 
   xmel019 LIKE xmel_t.xmel019, 
   xmel020 LIKE xmel_t.xmel020, 
   xmel021 LIKE xmel_t.xmel021, 
   xmeldocdt LIKE xmel_t.xmeldocdt, 
   xmeldocno LIKE xmel_t.xmeldocno, 
   xmelent LIKE xmel_t.xmelent, 
   xmelsite LIKE xmel_t.xmelsite, 
   xmelstus LIKE xmel_t.xmelstus, 
   xmem001 LIKE xmem_t.xmem001, 
   xmem002 LIKE xmem_t.xmem002, 
   xmem003 LIKE xmem_t.xmem003, 
   xmem004 LIKE xmem_t.xmem004, 
   xmem005 LIKE xmem_t.xmem005, 
   xmem006 LIKE xmem_t.xmem006, 
   xmem007 LIKE xmem_t.xmem007, 
   xmem008 LIKE xmem_t.xmem008, 
   xmem009 LIKE xmem_t.xmem009, 
   xmem010 LIKE xmem_t.xmem010, 
   xmem011 LIKE xmem_t.xmem011, 
   xmem012 LIKE xmem_t.xmem012, 
   xmem013 LIKE xmem_t.xmem013, 
   xmem014 LIKE xmem_t.xmem014, 
   xmem015 LIKE xmem_t.xmem015, 
   xmem016 LIKE xmem_t.xmem016, 
   xmem017 LIKE xmem_t.xmem017, 
   xmem018 LIKE xmem_t.xmem018, 
   xmem019 LIKE xmem_t.xmem019, 
   xmemseq LIKE xmem_t.xmemseq, 
   xmemsite LIKE xmem_t.xmemsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   l_xmeldocno_oobxl003 LIKE type_t.chr1000, 
   l_xmel001_ooag011 LIKE type_t.chr300, 
   l_xmel002_ooefl003 LIKE type_t.chr1000, 
   l_address_desc LIKE type_t.chr200, 
   l_bill_address LIKE type_t.chr1000, 
   l_payment_desc LIKE type_t.chr80, 
   l_currency_desc LIKE type_t.chr30, 
   l_imaal004_desc LIKE type_t.chr80, 
   l_volume_desc LIKE type_t.chr12, 
   l_xmem014_at LIKE type_t.chr80, 
   l_xmem016_at LIKE type_t.chr80, 
   l_xmem018_at LIKE type_t.chr80, 
   l_pallet_desc LIKE type_t.chr1000, 
   xmemdocno LIKE xmem_t.xmemdocno, 
   xmement LIKE xmem_t.xmement, 
   l_unit_desc LIKE type_t.chr30, 
   l_xmel009_desc LIKE type_t.chr200, 
   l_xmel010_desc LIKE type_t.chr200, 
   l_xmel003_pmaal003 LIKE type_t.chr1000, 
   l_xmem008_xmem010 LIKE type_t.chr30, 
   l_customer_item LIKE imaa_t.imaa001, 
   l_customer_show LIKE type_t.chr1, 
   l_xmem008_xmem011 LIKE type_t.chr30, 
   l_xmel014_show LIKE type_t.chr1, 
   l_xmdadocno LIKE xmda_t.xmdadocno, 
   l_xmdadocno_show LIKE type_t.chr1, 
   l_xmelsite_desc LIKE ooefl_t.ooefl006, 
   l_xmda033 LIKE xmda_t.xmda033, 
   l_xmel007_desc LIKE oocql_t.oocql004, 
   l_dims LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
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
DEFINE g_ref_fields    DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields    DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
TYPE sr3_r RECORD 
#   xmeldocno     LIKE xmel_t.xmeldocno,
#   xmem009       LIKE xmem_t.xmem009,           #棧板號
#   xmem010       LIKE xmem_t.xmem010,           #起始包裝箱號
#   xmem011       LIKE xmem_t.xmem011,           #截止包裝箱號
#   xmemdocno     LIKE xmem_t.xmemdocno          #測試
   xmao001        LIKE xmao_t.xmao001,          #客戶編號
   xmao002        LIKE xmao_t.xmao002,          #嘜頭編號
   xmap003        LIKE xmap_t.xmap003,          #類別
   xmap004        LIKE xmap_t.xmap004,          #行序
   xmap005        LIKE xmap_t.xmap005,          #資料類型
   xmap006        LIKE xmap_t.xmap006,          #資料內容
   l_xmap006_img  LIKE type_t.chr1000,          #資料內容(圖片)   #161205-00042#4-add
   l_imgstr       LIKE xmap_t.xmap006,          #圖中字內容       #161205-00042#4-add   
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
   #161205-00042#4-s
   l_xmap006_1_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_xmap006_2_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_imgstr_1       LIKE xmap_t.xmap006,          #圖中字內容
   l_imgstr_2       LIKE xmap_t.xmap006           #圖中字內容
   #161205-00042#4-e
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
   #161205-00042#4-s
   l_xmap006_1_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_xmap006_2_img  LIKE type_t.chr1000,          #資料內容(圖片)
   l_imgstr_1       LIKE xmap_t.xmap006,          #圖中字內容
   l_imgstr_2       LIKE xmap_t.xmap006           #圖中字內容
   #161205-00042#4-e    
#   l_xmap003_show_1 LIKE type_t.chr500,           #類別顯示否
#   l_xmap003_show_2 LIKE type_t.chr500            #類別顯示否
END RECORD
DEFINE sr5 DYNAMIC ARRAY OF sr5_r
#add--2015/08/17 By shiun--(E)
#end add-point
 
{</section>}
 
{<section id="axmr610_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr610_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.c1  列印額外品名
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
DEFINE l_success  LIKE type_t.num5
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.c1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
#   WHENEVER ERROR CALL cl_err_msg_log #當錯誤訊息出現是否shot down
   CALL s_axmi210_cre_tmp_table() RETURNING l_success #add--2015/07/01 By shiun
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axmr610_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr610_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr610_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr610_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr610_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr610_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xmel001,xmel002,xmel003,xmel004,xmel005,xmel006,xmel007,xmel008,xmel009,xmel010, 
       xmel011,xmel012,xmel013,xmel014,xmel015,xmel016,xmel017,xmel018,xmel019,xmel020,xmel021,xmeldocdt, 
       xmeldocno,xmelent,xmelsite,xmelstus,xmem001,xmem002,xmem003,xmem004,xmem005,xmem006,xmem007,xmem008, 
       xmem009,xmem010,xmem011,xmem012,xmem013,xmem014,xmem015,xmem016,xmem017,xmem018,xmem019,xmemseq, 
       xmemsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmel_t.xmel001 AND ooag_t.ooagent = xmel_t.xmelent), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmel_t.xmel002 AND ooefl_t.ooeflent = xmel_t.xmelent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmel_t.xmel003 AND pmaal_t.pmaalent = xmel_t.xmelent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '263' AND oocql_t.oocql002 = xmel_t.xmel007 AND oocql_t.oocqlent = xmel_t.xmelent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '209' AND oocql_t.oocql002 = xmel_t.xmel013 AND oocql_t.oocqlent = xmel_t.xmelent AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmel_t.xmel003 AND pmaal_t.pmaalent = xmel_t.xmelent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),( SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = xmel_t.xmeldocno AND oobxl_t.oobxlent = xmel_t.xmelent AND oobxl_t.oobxl002 = '" , 
       g_dlang,"'" ,"),x.imaal_t_imaal003,trim(xmeldocno)||'.'||trim((SELECT oobxl003 FROM oobxl_t WHERE oobxl_t.oobxl001 = xmel_t.xmeldocno AND oobxl_t.oobxlent = xmel_t.xmelent AND oobxl_t.oobxl002 = '" , 
       g_dlang,"'" ,")),trim(xmel001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmel_t.xmel001 AND ooag_t.ooagent = xmel_t.xmelent)), 
       trim(xmel002)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmel_t.xmel002 AND ooefl_t.ooeflent = xmel_t.xmelent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,xmemdocno,xmement,NULL,NULL, 
       NULL,trim(xmel003)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmel_t.xmel003 AND pmaal_t.pmaalent = xmel_t.xmelent AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,")),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xmel_t LEFT OUTER JOIN ( SELECT xmem_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmem_t.xmem003 AND imaal_t.imaalent = xmem_t.xmement AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003 FROM xmem_t ) x  ON xmel_t.xmelent = x.xmement AND xmel_t.xmeldocno  
        = x.xmemdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xmeldocno,xmem010"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmel_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr610_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr610_g01_curs CURSOR FOR axmr610_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr610_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr610_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmel001 LIKE xmel_t.xmel001, 
   xmel002 LIKE xmel_t.xmel002, 
   xmel003 LIKE xmel_t.xmel003, 
   xmel004 LIKE xmel_t.xmel004, 
   xmel005 LIKE xmel_t.xmel005, 
   xmel006 LIKE xmel_t.xmel006, 
   xmel007 LIKE xmel_t.xmel007, 
   xmel008 LIKE xmel_t.xmel008, 
   xmel009 LIKE xmel_t.xmel009, 
   xmel010 LIKE xmel_t.xmel010, 
   xmel011 LIKE xmel_t.xmel011, 
   xmel012 LIKE xmel_t.xmel012, 
   xmel013 LIKE xmel_t.xmel013, 
   xmel014 LIKE xmel_t.xmel014, 
   xmel015 LIKE xmel_t.xmel015, 
   xmel016 LIKE xmel_t.xmel016, 
   xmel017 LIKE xmel_t.xmel017, 
   xmel018 LIKE xmel_t.xmel018, 
   xmel019 LIKE xmel_t.xmel019, 
   xmel020 LIKE xmel_t.xmel020, 
   xmel021 LIKE xmel_t.xmel021, 
   xmeldocdt LIKE xmel_t.xmeldocdt, 
   xmeldocno LIKE xmel_t.xmeldocno, 
   xmelent LIKE xmel_t.xmelent, 
   xmelsite LIKE xmel_t.xmelsite, 
   xmelstus LIKE xmel_t.xmelstus, 
   xmem001 LIKE xmem_t.xmem001, 
   xmem002 LIKE xmem_t.xmem002, 
   xmem003 LIKE xmem_t.xmem003, 
   xmem004 LIKE xmem_t.xmem004, 
   xmem005 LIKE xmem_t.xmem005, 
   xmem006 LIKE xmem_t.xmem006, 
   xmem007 LIKE xmem_t.xmem007, 
   xmem008 LIKE xmem_t.xmem008, 
   xmem009 LIKE xmem_t.xmem009, 
   xmem010 LIKE xmem_t.xmem010, 
   xmem011 LIKE xmem_t.xmem011, 
   xmem012 LIKE xmem_t.xmem012, 
   xmem013 LIKE xmem_t.xmem013, 
   xmem014 LIKE xmem_t.xmem014, 
   xmem015 LIKE xmem_t.xmem015, 
   xmem016 LIKE xmem_t.xmem016, 
   xmem017 LIKE xmem_t.xmem017, 
   xmem018 LIKE xmem_t.xmem018, 
   xmem019 LIKE xmem_t.xmem019, 
   xmemseq LIKE xmem_t.xmemseq, 
   xmemsite LIKE xmem_t.xmemsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   t1_oocql004 LIKE oocql_t.oocql004, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   oobxl_t_oobxl003 LIKE oobxl_t.oobxl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   l_xmeldocno_oobxl003 LIKE type_t.chr1000, 
   l_xmel001_ooag011 LIKE type_t.chr300, 
   l_xmel002_ooefl003 LIKE type_t.chr1000, 
   l_address_desc LIKE type_t.chr200, 
   l_bill_address LIKE type_t.chr1000, 
   l_payment_desc LIKE type_t.chr80, 
   l_currency_desc LIKE type_t.chr30, 
   l_imaal004_desc LIKE type_t.chr80, 
   l_volume_desc LIKE type_t.chr12, 
   l_xmem014_at LIKE type_t.chr80, 
   l_xmem016_at LIKE type_t.chr80, 
   l_xmem018_at LIKE type_t.chr80, 
   l_pallet_desc LIKE type_t.chr1000, 
   xmemdocno LIKE xmem_t.xmemdocno, 
   xmement LIKE xmem_t.xmement, 
   l_unit_desc LIKE type_t.chr30, 
   l_xmel009_desc LIKE type_t.chr200, 
   l_xmel010_desc LIKE type_t.chr200, 
   l_xmel003_pmaal003 LIKE type_t.chr1000, 
   l_xmem008_xmem010 LIKE type_t.chr30, 
   l_customer_item LIKE imaa_t.imaa001, 
   l_customer_show LIKE type_t.chr1, 
   l_xmem008_xmem011 LIKE type_t.chr30, 
   l_xmel014_show LIKE type_t.chr1, 
   l_xmdadocno LIKE xmda_t.xmdadocno, 
   l_xmdadocno_show LIKE type_t.chr1, 
   l_xmelsite_desc LIKE ooefl_t.ooefl006, 
   l_xmda033 LIKE xmda_t.xmda033, 
   l_xmel007_desc LIKE oocql_t.oocql004, 
   l_dims LIKE type_t.chr1000
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_xmeldocno     LIKE xmel_t.xmeldocno
   DEFINE l_xmem009       LIKE xmem_t.xmem009        #棧板號
   DEFINE l_xmem010       LIKE xmem_t.xmem010        #起始包裝箱號
   DEFINE l_xmem011       LIKE xmem_t.xmem011        #截止包裝箱號
   DEFINE l_pmaa027       LIKE pmaa_t.pmaa027        #聯絡對象識別碼
   DEFINE l_xmdg007       LIKE xmdg_t.xmdg007        #出通單收貨客戶
   DEFINE l_xmdg017       LIKE xmdg_t.xmdg017        #出通單送貨地址
   DEFINE l_success       LIKE type_t.chr1            
   DEFINE l_xmdk009       LIKE xmdk_t.xmdk009        #出貨單收貨客戶
   DEFINE l_xmdk021       LIKE xmdk_t.xmdk021        #出貨單送貨地址
   DEFINE l_oofa001       LIKE oofa_t.oofa001        #聯絡對象識別碼
   DEFINE l_indc105       LIKE indc_t.indc105        #出貨單送貨地址	
   DEFINE l_indc006       LIKE indc_t.indc006        #撥入營運據點
   DEFINE l_xmdg009       LIKE xmdg_t.xmdg009        #出通單交易條件帶說明
   DEFINE l_xmdk011       LIKE xmdk_t.xmdk011        #出貨單交易條件帶說明
   DEFINE l_oocq019       LIKE oocq_t.oocq019        #起運地參考欄位
   DEFINE l_xmdadocno     LIKE xmda_t.xmdadocno      #訂單單號(回抓xmda033用)
   #add--2015/06/15 By shiun--(S)
   DEFINE l_xmdg006       LIKE xmdg_t.xmdg006        #出通單收款客戶
   DEFINE l_xmdh006       LIKE xmdh_t.xmdh006        #出通單料號
   DEFINE l_xmdh007       LIKE xmdh_t.xmdh007        #出通單產品特徵
   DEFINE l_xmdl008       LIKE xmdl_t.xmdl008        #出貨單料號
   DEFINE l_xmdl009       LIKE xmdl_t.xmdl009        #出貨單產品特徵
   DEFINE l_xmdk008       LIKE xmdk_t.xmdk008        #出貨單收款客戶
   DEFINE l_trim          STRING
   DEFINE l_pmaal003      LIKE pmaal_t.pmaal003      #聯絡對象全名
   DEFINE l_pmaal003_1    LIKE pmaal_t.pmaal003      #帳款聯絡全名
   DEFINE l_xmda033       LIKE xmda_t.xmda033        #客戶訂單號
   #add--2015/06/15 By shiun--(E)
   #add--2015/09/09 By shiun--(S)
   DEFINE l_dzeb006       LIKE dzeb_t.dzeb006
   DEFINE l_gztd014       LIKE gztd_t.gztd014
   DEFINE l_xmem014_str   STRING
   DEFINE l_xmem016_str   STRING
   DEFINE l_xmem018_str   STRING
   DEFINE l_xmam010       LIKE xmam_t.xmam010
   DEFINE l_xmam011       LIKE xmam_t.xmam011
   DEFINE l_xmam012       LIKE xmam_t.xmam012
   DEFINE l_xmam014       LIKE xmam_t.xmam014
   #add--2015/09/09 By shiun--(E)
   #add--2015/09/14 By shiun--(S)
   DEFINE l_dzeb006_xmam010 LIKE dzeb_t.dzeb006
   DEFINE l_gztd014_xmam010 LIKE gztd_t.gztd014
   DEFINE l_xmam010_str   STRING
   DEFINE l_xmam011_str   STRING
   DEFINE l_xmam012_str   STRING
   #add--2015/09/14 By shiun--(E)
   DEFINE l_xmda026       LIKE xmda_t.xmda026        #150925 by whitney add     
#161031-00024#3 Add By Ken 170202(S)
   DEFINE l_slip_tmp       LIKE ooba_t.ooba002      #單據別   
   DEFINE l_gzcb002        LIKE gzcb_t.gzcb002      #單據別參數
   DEFINE l_cnt_chk        LIKE type_t.num10
#161031-00024#3 Add By Ken 170202(E)      
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_xmeldocno = ''
    DROP TABLE axmr610_g01_tmp
    CREATE TEMP TABLE axmr610_g01_tmp
       (xmeldocno         LIKE xmel_t.xmeldocno,
        pallet            LIKE type_t.chr1000)
    
    #add--2015/09/09 By shiun--(S)
    SELECT dzeb006 INTO l_dzeb006
      FROM dzeb_t
     WHERE dzeb001 = 'xmem_t'
       AND dzeb002 = 'xmem014'
       
    SELECT gztd014 INTO l_gztd014
      FROM gztd_t
     WHERE gztd001 = l_dzeb006
       AND gztdstus = 'Y'
    #add--2015/09/09 By shiun--(E)
    #add--2015/09/14 By shiun--(S)
    SELECT dzeb006 INTO l_dzeb006_xmam010
      FROM dzeb_t
     WHERE dzeb001 = 'xmam_t'
       AND dzeb002 = 'xmam010'
       
    SELECT gztd014 INTO l_gztd014_xmam010
      FROM gztd_t
     WHERE gztd001 = l_dzeb006_xmam010
       AND gztdstus = 'Y'
    #add--2015/09/14 By shiun--(E)
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr610_g01_curs INTO sr_s.*
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
       #add--2015/06/15 By shiun--(S)
       #字軌+箱數
       CALL axmr610_g01_assemble(sr_s.xmem008,sr_s.xmem010) RETURNING sr_s.l_xmem008_xmem010
       CALL axmr610_g01_assemble(sr_s.xmem008,sr_s.xmem011) RETURNING sr_s.l_xmem008_xmem011
       IF cl_null(sr_s.xmel014) THEN
          LET sr_s.l_xmel014_show = 'N'
       ELSE
          LET sr_s.l_xmel014_show = 'Y'
       END IF
       SELECT ooefl006 INTO sr_s.l_xmelsite_desc
         FROM ooefl_t
        WHERE ooeflent = sr_s.xmelent
          AND ooefl001 = sr_s.xmelsite
          AND ooefl002 = g_dlang
       #add--2015/06/15 By shiun--(E)
       #淨重、毛重前加入"@"
       #modify--2015/09/09 By shiun(S)
       LET l_xmem014_str = sr_s.xmem014 USING l_gztd014
       LET l_xmem016_str = sr_s.xmem016 USING l_gztd014
       LET l_xmem018_str = sr_s.xmem018 USING l_gztd014       
       LET sr_s.l_xmem014_at = "@"||l_xmem014_str.trim()
       LET sr_s.l_xmem016_at = "@"||l_xmem016_str.trim()
       LET sr_s.l_xmem018_at = "@"||l_xmem018_str.trim()
       #modify--2015/09/09 By shiun(E)
       #add--2015/08/28 By shiun--(S)
       CALL s_apmi011_location_ref(sr_s.xmel007,sr_s.xmel009) RETURNING sr_s.l_xmel009_desc
       CALL s_apmi011_location_ref(sr_s.xmel007,sr_s.xmel010) RETURNING sr_s.l_xmel010_desc
       #add--2015/08/28 By shiun--(E)
       #mark--2015/08/28 By shiun--(S)
       #起運地帶出參考欄位
#       LET l_oocq019 = ''               #運輸方式清空
#       LET sr_s.l_xmel009_desc = ''
#
#       IF NOT cl_null(sr_s.xmel007) THEN
#       SELECT oocq019 INTO l_oocq019 FROM oocq_t
#        WHERE oocqent = sr_s.xmelent
#          AND oocq001 ='263'
#          AND oocq002 = sr_s.xmel007 #運輸方式
#       END IF
#
#       CASE
#          WHEN l_oocq019 = '1' OR    #陸運
#               l_oocq019 = '4'       #其他
#        
#             DECLARE axmr610_xmel_cs SCROLL CURSOR FOR
#                SELECT oockl005 FROM oockl_t
#                 WHERE oocklent = sr_s.xmelent
#                   AND oockl003 = sr_s.xmel009
#                   AND oockl004 = g_dlang
#              ORDER BY oockl001 DESC
#                  OPEN axmr610_xmel_cs
#           FETCH FIRST axmr610_xmel_cs INTO sr_s.l_xmel009_desc
#        
#          WHEN l_oocq019 = '2'       #海運        
#             SELECT oocql004 INTO sr_s.l_xmel009_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmelent
#                AND oocql001 ='262'
#                AND oocql002 = sr_s.xmel009
#                AND oocql003 = g_dlang
#
#          WHEN l_oocq019 = '3'       #空運
#             SELECT oocql004 INTO sr_s.l_xmel009_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmelent
#                AND oocql001 = '276'
#                AND oocql002 = sr_s.l_xmel009_desc
#                AND oocql003 = g_dlang
#       END CASE
#
#       #目的地帶出參考欄位
#       LET l_oocq019 = ''
#       LET sr_s.l_xmel010_desc = ''
#
#       IF NOT cl_null(sr_s.xmel007) THEN
#       SELECT oocq019 INTO l_oocq019
#         FROM oocq_t
#        WHERE oocq001 = '263'
#          AND oocq002 = sr_s.xmel010
#       END IF
#       CASE
#          WHEN l_oocq019 = '1' OR    #陸運
#               l_oocq019 = '4'       #其他
#
#             DECLARE axme610_xmel_cs1 SCROLL CURSOR FOR
#                SELECT oockl005 FROM oockl_t
#                 WHERE oocklent = sr_s.xmelent
#                 AND oockl003 = sr_s.xmel010
#                   AND oockl004 = g_dlang
#                 ORDER BY oockl001 DESC
#                 OPEN axme610_xmel_cs1
#             FETCH FIRST axme610_xmel_cs1 INTO sr_s.l_xmel010_desc
#
#          WHEN l_oocq019 = '2'       #海運
#
#             SELECT oocql004 INTO sr_s.l_xmel010_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmelent
#                AND oocql001 ='262'
#                AND oocql002 = sr_s.xmel010
#                AND oocql003 = g_dlang
#
#          WHEN l_oocq019 = '3'       #空運
#
#             SELECT oocql004 INTO sr_s.l_xmel010_desc FROM oocql_t
#              WHERE oocqlent = sr_s.xmelent
#                AND oocql001 = '276'
#                AND oocql002 = sr_s.xmel010
#                AND oocql003 = g_dlang
#       END CASE
       #mark--2015/08/28 By shiun--(E)

#       #起運地帶出參考欄位
#       IF NOT cl_null(sr_s.xmel007) THEN
#       SELECT oocq019 INTO l_oocq019
#         FROM oocq_t WHERE oocq001 ='263' AND oocq002 = sr_s.xmel009
#       END IF
#       
#       IF NOT cl_null(l_oocq019) THEN
#          CASE
#             WHEN l_oocq019 ='1' OR l_oocq019 ='4'
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = sr_s.xmel009
#               CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmelent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET sr_s.l_xmel009_desc = '', g_rtn_fields[1] , ''
#             
#             WHEN l_oocq019 ='2' OR l_oocq019 ='3'
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = sr_s.xmel009
#               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||sr_s.xmelent||"' AND oocql002=? AND oocql001 = '262' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET sr_s.l_xmel009_desc = '', g_rtn_fields[1] , ''             
#          END CASE
#       ELSE
#          INITIALIZE g_ref_fields TO NULL
#          LET g_ref_fields[1] = sr_s.xmel009
#          CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmelent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#          LET sr_s.l_xmel009_desc = '', g_rtn_fields[1] , ''         
#       END IF 
#       
#       #目的地帶出參考欄位
#       IF NOT cl_null(sr_s.xmel007) THEN
#       SELECT oocq019 INTO l_oocq019
#         FROM oocq_t WHERE oocq001='263' AND oocq002= sr_s.xmel010
#       END IF
#       
#       IF NOT cl_null(l_oocq019) THEN
#          CASE
#             WHEN l_oocq019 ='1' OR l_oocq019 ='4'
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = sr_s.xmel010
#               CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmelent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET sr_s.l_xmel010_desc = '', g_rtn_fields[1] , ''
#             
#             WHEN l_oocq019 ='2' OR l_oocq019 ='3'
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = sr_s.xmel010
#               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||sr_s.xmelent||"' AND oocql002=? AND oocql001 = '262' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET sr_s.l_xmel010_desc = '', g_rtn_fields[1] , ''             
#          END CASE
#       ELSE
#          INITIALIZE g_ref_fields TO NULL
#          LET g_ref_fields[1] = sr_s.xmel010
#          CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||sr_s.xmelent||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#          LET sr_s.l_xmel010_desc = '', g_rtn_fields[1] , ''         
#       END IF  
       
       #依照不同的來源單號回抓
       LET sr_s.l_xmdadocno = ''
       CASE
          WHEN sr_s.xmel004 = '1'  #出貨通知單axmt520       
             
             #mark--2015/06/16 By shiun--(S)
#             IF cl_null(l_xmdadocno) THEN
#                LET sr_s.xmel005 = ''
#             ELSE
#                SELECT xmda033 INTO sr_s.xmel005
#                  FROM xmda_t
#                 WHERE xmdaent = sr_s.xmelent
#                   AND xmdadocno = l_xmdadocno
#             END IF
             #mark--2015/06/16 By shiun--(E)
             #依照單號塞值(交易條件、幣別)
             SELECT xmdg004,xmdg006,xmdg007,xmdg009,xmdg014,xmdg017
               INTO sr_s.l_xmdadocno,l_xmdg006,l_xmdg007,l_xmdg009,sr_s.l_currency_desc,l_xmdg017
               FROM xmdg_t
              WHERE xmdgdocno = sr_s.xmel005 
                AND xmdgent = sr_s.xmelent
             #交易條件帶說明   
             SELECT oocql004 INTO sr_s.l_payment_desc FROM oocql_t
              WHERE oocqlent = sr_s.xmelent AND oocql001 = 238 AND oocql002 = l_xmdg009 AND oocql003 = g_dlang
             #add--2015/06/15 By shiun--(S)
             #單位         
             SELECT xmdh006,xmdh007,xmdh015
               INTO l_xmdh006,l_xmdh007,sr_s.l_unit_desc
               FROM xmdh_t
              WHERE xmdhent = sr_s.xmelent
                AND xmdhdocno = sr_s.xmem001
                AND xmdhseq = sr_s.xmem002
             #依交易對象、料號、產品特徵回傳客戶料號
             IF NOT cl_null(l_xmdh006) AND NOT cl_null(l_xmdh007) THEN
                #161221-00064#21 mod-S
#                CALL s_apmi070_get_pmao004(sr_s.xmel003,l_xmdh006,l_xmdh007)
                CALL s_apmi070_get_pmao004_2(sr_s.xmel003,l_xmdh006,l_xmdh007,'2')
                #161221-00064#21 mod-E
                     RETURNING l_success,sr_s.l_customer_item
             END IF
             #add--2015/06/15 By shiun--(E)
             
             #150925 by whitney modify start
             #送貨地址
             LET l_pmaa027 = ''
             SELECT pmaa027 INTO l_pmaa027 
               FROM pmaa_t
              WHERE pmaaent = g_enterprise 
                AND pmaa001 = l_xmdg007 
             IF NOT cl_null(l_pmaa027) AND NOT cl_null(l_xmdg017) THEN
                CALL s_aooi350_get_address(l_pmaa027,l_xmdg017,g_lang)RETURNING l_success,sr_s.l_address_desc
             END IF
             #收款地址
             LET l_pmaa027 = ''
             LET l_xmda026 = ''
             SELECT pmaa027,xmda026 INTO l_pmaa027,l_xmda026
               FROM xmda_t,pmaa_t
              WHERE xmdaent = g_enterprise
                AND xmdadocno = sr_s.l_xmdadocno
                AND pmaaent = xmdaent
                AND pmaa001 = xmda021
             IF NOT cl_null(l_pmaa027) AND NOT cl_null(l_xmda026) THEN
                CALL s_aooi350_get_address(l_pmaa027,l_xmda026,g_lang) RETURNING l_success,sr_s.l_bill_address
             END IF
             #150925 by whitney modify end

             #add--2015/06/15 By shiun--(S)
#             CALL s_desc_get_trading_partner_full_desc(l_xmdg007) RETURNING l_pmaal003    #161207-00033#14 MARK
#             CALL s_desc_get_trading_partner_full_desc(l_xmdg006) RETURNING l_pmaal003_1  #161207-00033#14 MARK
             #161207-00033#14-s
             CALL axmr610_g01_guest_desc1(l_xmdg006,l_xmdg007,sr_s.xmel003,sr_s.xmeldocno)  RETURNING l_pmaal003,l_pmaal003_1
             #161207-00033#14-e
             LET sr_s.l_address_desc = l_pmaal003 CLIPPED,ASCII 13, ASCII 10,sr_s.l_address_desc CLIPPED
             LET sr_s.l_bill_address = l_pmaal003_1 CLIPPED,ASCII 13, ASCII 10,sr_s.l_bill_address CLIPPED
             #add--2015/06/15 By shiun--(E)
             
-------------------------------------------------------------------------------------------------------------------
          WHEN sr_s.xmel004 = '2'  #出貨單axmt540
          
             #mark--2015/06/16 By shiun--(S)
#             IF cl_null(l_xmdadocno) THEN
#                LET sr_s.xmel005 = ''
#             ELSE
#                SELECT xmda033 INTO sr_s.xmel005
#                  FROM xmda_t
#                 WHERE xmdaent = sr_s.xmelent
#                   AND xmdadocno = l_xmdadocno
#             END IF
             #mark--2015/06/16 By shiun--(E)
             #依照單號塞值(交易條件、幣別)       
             SELECT xmdk006,xmdk008,xmdk009,xmdk011,xmdk016,xmdk021
               #INTO l_xmdadocno,l_xmdk008,l_xmdk009,l_xmdk011,sr_s.l_currency_desc,l_xmdk021
               INTO sr_s.l_xmdadocno,l_xmdk008,l_xmdk009,l_xmdk011,sr_s.l_currency_desc,l_xmdk021 #161205-00042#4 mod
               FROM xmdk_t  
              WHERE xmdkdocno = sr_s.xmel005 
                AND xmdkent = sr_s.xmelent
             #交易條件帶說明   
             SELECT oocql004 INTO sr_s.l_payment_desc FROM oocql_t
              WHERE oocqlent = sr_s.xmelent AND oocql001 = 238 AND oocql002 = l_xmdk011 AND oocql003 = g_dlang
             #add--2015/06/15 By shiun--(S)
             #單位         
             SELECT xmdl008,xmdl009,xmdl017
               INTO l_xmdl008,l_xmdl009,sr_s.l_unit_desc
               FROM xmdl_t
              WHERE xmdlent = sr_s.xmelent
                AND xmdldocno = sr_s.xmem001
                AND xmdlseq = sr_s.xmem002
             #依交易對象、料號、產品特徵回傳客戶料號
             IF NOT cl_null(l_xmdl008) AND NOT cl_null(l_xmdl009) THEN
                #161221-00064#21 mod-S
#                CALL s_apmi070_get_pmao004(sr_s.xmel003,l_xmdl008,l_xmdl009)
                CALL s_apmi070_get_pmao004_2(sr_s.xmel003,l_xmdl008,l_xmdl009,'2')
                #161221-00064#21 mod-E
                     RETURNING l_success,sr_s.l_customer_item
             END IF
             #add--2015/06/15 By shiun--(E)
             
             #150925 by whitney modify start
             #送貨地址
             LET l_pmaa027 = ''
             SELECT pmaa027 INTO l_pmaa027 
               FROM pmaa_t
              WHERE pmaaent = g_enterprise 
                AND pmaa001 = l_xmdk009  
             IF NOT cl_null(l_pmaa027) AND NOT cl_null(l_xmdk021) THEN
                CALL s_aooi350_get_address(l_pmaa027,l_xmdk021,g_lang)RETURNING l_success,sr_s.l_address_desc
             END IF
             #收款地址
             LET l_pmaa027 = ''
             LET l_xmda026 = ''
             SELECT pmaa027,xmda026 INTO l_pmaa027,l_xmda026
               FROM xmda_t,pmaa_t
              WHERE xmdaent = g_enterprise
                AND xmdadocno = sr_s.l_xmdadocno
                AND pmaaent = xmdaent
                AND pmaa001 = xmda021
             IF NOT cl_null(l_pmaa027) AND NOT cl_null(l_xmda026) THEN
                CALL s_aooi350_get_address(l_pmaa027,l_xmda026,g_lang) RETURNING l_success,sr_s.l_bill_address
             END IF
             #150925 by whitney modify end

             #add--2015/06/15 By shiun--(S)
             #CALL s_desc_get_trading_partner_full_desc(l_xmdk009) RETURNING l_pmaal003   #161207-00033#14 MARK
             #CALL s_desc_get_trading_partner_full_desc(l_xmdk008) RETURNING l_pmaal003_1 #161207-00033#14 MARK 
             #161207-00033#14-s
             CALL axmr610_g01_guest_desc1(l_xmdk008,l_xmdk009,sr_s.xmel003,sr_s.xmeldocno)  RETURNING l_pmaal003,l_pmaal003_1
             #161207-00033#14-e
             LET sr_s.l_address_desc = l_pmaal003 CLIPPED,ASCII 13, ASCII 10,sr_s.l_address_desc CLIPPED
             LET sr_s.l_bill_address = l_pmaal003_1 CLIPPED,ASCII 13, ASCII 10,sr_s.l_bill_address CLIPPED
             #add--2015/06/15 By shiun--(E)

-------------------------------------------------------------------------------------------------------------------
          WHEN sr_s.xmel004 = '4'  #調撥單aint330,340
          
             SELECT indc105,indc006 INTO l_indc105,l_indc006 FROM indc_t
              WHERE indcdocno = sr_s.xmel005 AND indcent = sr_s.xmelent    
              
             #送貨地址處理
             LET l_oofa001 = ''
             SELECT oofa001 INTO l_oofa001 FROM oofa_t 
              WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = l_indc006  
               
             IF NOT cl_null(l_indc105) THEN             
                CALL s_aooi350_get_address(l_oofa001,l_indc105,g_lang)RETURNING l_success,sr_s.l_address_desc
             END IF
             #add--2015/06/15 By shiun--(S)
             CALL s_desc_get_trading_partner_full_desc(l_indc006) RETURNING l_pmaal003
             LET sr_s.l_address_desc = l_pmaal003 CLIPPED,ASCII 13, ASCII 10,sr_s.l_address_desc CLIPPED
             #add--2015/06/15 By shiun--(E)
             
             #單位         
             SELECT indd006 INTO sr_s.l_unit_desc FROM indc_t,indd_t
              WHERE indcent = inddent AND indcdocno = indddocno AND indcdocno = sr_s.xmel005  AND ROWNUM=1
           
       END CASE
       IF cl_null(sr_s.l_customer_item) THEN
          LET sr_s.l_customer_show = 'N'
       ELSE
          LET sr_s.l_customer_show = 'Y'
       END IF
       IF cl_null(sr_s.l_xmdadocno) THEN
          LET sr_s.l_xmdadocno_show = 'N'
       ELSE
          LET sr_s.l_xmdadocno_show = 'Y'
       END IF
       #add--2015/07/01 By shiun--(S)
       LET l_xmda033 = ''
       SELECT xmda033 INTO sr_s.l_xmda033
         FROM xmda_t
        WHERE xmdaent = sr_s.xmelent
          AND xmdadocno = sr_s.l_xmdadocno
       CALL s_axmi210_ins_tmp_table(sr_s.xmem003,sr_s.x_imaal_t_imaal003,sr_s.pmaal_t_pmaal004,sr_s.l_xmda033,sr_s.l_xmdadocno,sr_s.l_xmel009_desc,sr_s.l_xmel010_desc,sr_s.xmem010,sr_s.xmem011,(sr_s.xmem011-sr_s.xmem010+1),sr_s.xmem017,sr_s.xmem019,sr_s.xmeldocno) RETURNING l_success 
       #add--2015/07/01 By shiun--(E)
       #add--2015/09/09 By shiun--(S)
       CALL s_desc_get_acc_desc('263',sr_s.xmel007) RETURNING sr_s.l_xmel007_desc  #add--2015/09/09 By shiun
       IF NOT cl_null(sr_s.xmem005) THEN
          INITIALIZE l_xmam010,l_xmam011,l_xmam012,l_xmam014 TO NULL
          SELECT xmam010,xmam011,xmam012,xmam014 INTO l_xmam010,l_xmam011,l_xmam012,l_xmam014
            FROM xmam_t
           WHERE xmament = g_enterprise
             AND xmam001 = sr_s.xmem005
             
          LET l_xmam010_str = l_xmam010 USING l_gztd014_xmam010
          LET l_xmam011_str = l_xmam011 USING l_gztd014_xmam010
          LET l_xmam012_str = l_xmam012 USING l_gztd014_xmam010
          LET sr_s.l_dims = "DMIS(",l_xmam014,"):"||l_xmam010_str.trim()||"*"||l_xmam011_str.trim()||"*"||l_xmam012_str.trim()
       
       END IF
       #add--2015/09/09 By shiun--(E)
       
       #161031-00024#3 Add By Ken 170202(S)
       IF tm.c1 = 'Y' THEN
          #先取得單別
          LET l_success = ''
          LET l_slip_tmp = ''
          CALL s_aooi200_get_slip(sr_s.xmeldocno)
             RETURNING l_success,l_slip_tmp
          
          #取得單別參數
          CALL cl_get_doc_para(g_enterprise,g_site,l_slip_tmp,'D-MFG-0087')
             RETURNING l_gzcb002       
             
          IF NOT cl_null(l_gzcb002) THEN
             LET l_cnt_chk = 0
             SELECT COUNT(1) INTO l_cnt_chk
               FROM imab_t
              WHERE imabent = g_enterprise
                AND imab001 = sr_s.xmem003
                AND imab002 = l_gzcb002
                AND imabstus = 'Y'
                AND (imab005 IS NOT NULL OR imab005<>'')                 
             IF l_cnt_chk > 0 THEN
                CALL s_desc_get_imab004_desc(sr_s.xmem003,l_gzcb002) RETURNING sr_s.x_imaal_t_imaal003
                IF NOT cl_null(sr_s.x_imaal_t_imaal003) THEN
                   LET sr_s.l_imaal004_desc = ''
                END IF
             END IF
          END IF
       END IF
       #161031-00024#3 Add By Ken 170202(E)         
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmel001 = sr_s.xmel001
       LET sr[l_cnt].xmel002 = sr_s.xmel002
       LET sr[l_cnt].xmel003 = sr_s.xmel003
       LET sr[l_cnt].xmel004 = sr_s.xmel004
       LET sr[l_cnt].xmel005 = sr_s.xmel005
       LET sr[l_cnt].xmel006 = sr_s.xmel006
       LET sr[l_cnt].xmel007 = sr_s.xmel007
       LET sr[l_cnt].xmel008 = sr_s.xmel008
       LET sr[l_cnt].xmel009 = sr_s.xmel009
       LET sr[l_cnt].xmel010 = sr_s.xmel010
       LET sr[l_cnt].xmel011 = sr_s.xmel011
       LET sr[l_cnt].xmel012 = sr_s.xmel012
       LET sr[l_cnt].xmel013 = sr_s.xmel013
       LET sr[l_cnt].xmel014 = sr_s.xmel014
       LET sr[l_cnt].xmel015 = sr_s.xmel015
       LET sr[l_cnt].xmel016 = sr_s.xmel016
       LET sr[l_cnt].xmel017 = sr_s.xmel017
       LET sr[l_cnt].xmel018 = sr_s.xmel018
       LET sr[l_cnt].xmel019 = sr_s.xmel019
       LET sr[l_cnt].xmel020 = sr_s.xmel020
       LET sr[l_cnt].xmel021 = sr_s.xmel021
       LET sr[l_cnt].xmeldocdt = sr_s.xmeldocdt
       LET sr[l_cnt].xmeldocno = sr_s.xmeldocno
       LET sr[l_cnt].xmelent = sr_s.xmelent
       LET sr[l_cnt].xmelsite = sr_s.xmelsite
       LET sr[l_cnt].xmelstus = sr_s.xmelstus
       LET sr[l_cnt].xmem001 = sr_s.xmem001
       LET sr[l_cnt].xmem002 = sr_s.xmem002
       LET sr[l_cnt].xmem003 = sr_s.xmem003
       LET sr[l_cnt].xmem004 = sr_s.xmem004
       LET sr[l_cnt].xmem005 = sr_s.xmem005
       LET sr[l_cnt].xmem006 = sr_s.xmem006
       LET sr[l_cnt].xmem007 = sr_s.xmem007
       LET sr[l_cnt].xmem008 = sr_s.xmem008
       LET sr[l_cnt].xmem009 = sr_s.xmem009
       LET sr[l_cnt].xmem010 = sr_s.xmem010
       LET sr[l_cnt].xmem011 = sr_s.xmem011
       LET sr[l_cnt].xmem012 = sr_s.xmem012
       LET sr[l_cnt].xmem013 = sr_s.xmem013
       LET sr[l_cnt].xmem014 = sr_s.xmem014
       LET sr[l_cnt].xmem015 = sr_s.xmem015
       LET sr[l_cnt].xmem016 = sr_s.xmem016
       LET sr[l_cnt].xmem017 = sr_s.xmem017
       LET sr[l_cnt].xmem018 = sr_s.xmem018
       LET sr[l_cnt].xmem019 = sr_s.xmem019
       LET sr[l_cnt].xmemseq = sr_s.xmemseq
       LET sr[l_cnt].xmemsite = sr_s.xmemsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].t1_oocql004 = sr_s.t1_oocql004
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].oobxl_t_oobxl003 = sr_s.oobxl_t_oobxl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].l_xmeldocno_oobxl003 = sr_s.l_xmeldocno_oobxl003
       LET sr[l_cnt].l_xmel001_ooag011 = sr_s.l_xmel001_ooag011
       LET sr[l_cnt].l_xmel002_ooefl003 = sr_s.l_xmel002_ooefl003
       LET sr[l_cnt].l_address_desc = sr_s.l_address_desc
       LET sr[l_cnt].l_bill_address = sr_s.l_bill_address
       LET sr[l_cnt].l_payment_desc = sr_s.l_payment_desc
       LET sr[l_cnt].l_currency_desc = sr_s.l_currency_desc
       LET sr[l_cnt].l_imaal004_desc = sr_s.l_imaal004_desc
       LET sr[l_cnt].l_volume_desc = sr_s.l_volume_desc
       LET sr[l_cnt].l_xmem014_at = sr_s.l_xmem014_at
       LET sr[l_cnt].l_xmem016_at = sr_s.l_xmem016_at
       LET sr[l_cnt].l_xmem018_at = sr_s.l_xmem018_at
       LET sr[l_cnt].l_pallet_desc = sr_s.l_pallet_desc
       LET sr[l_cnt].xmemdocno = sr_s.xmemdocno
       LET sr[l_cnt].xmement = sr_s.xmement
       LET sr[l_cnt].l_unit_desc = sr_s.l_unit_desc
       LET sr[l_cnt].l_xmel009_desc = sr_s.l_xmel009_desc
       LET sr[l_cnt].l_xmel010_desc = sr_s.l_xmel010_desc
       LET sr[l_cnt].l_xmel003_pmaal003 = sr_s.l_xmel003_pmaal003
       LET sr[l_cnt].l_xmem008_xmem010 = sr_s.l_xmem008_xmem010
       LET sr[l_cnt].l_customer_item = sr_s.l_customer_item
       LET sr[l_cnt].l_customer_show = sr_s.l_customer_show
       LET sr[l_cnt].l_xmem008_xmem011 = sr_s.l_xmem008_xmem011
       LET sr[l_cnt].l_xmel014_show = sr_s.l_xmel014_show
       LET sr[l_cnt].l_xmdadocno = sr_s.l_xmdadocno
       LET sr[l_cnt].l_xmdadocno_show = sr_s.l_xmdadocno_show
       LET sr[l_cnt].l_xmelsite_desc = sr_s.l_xmelsite_desc
       LET sr[l_cnt].l_xmda033 = sr_s.l_xmda033
       LET sr[l_cnt].l_xmel007_desc = sr_s.l_xmel007_desc
       LET sr[l_cnt].l_dims = sr_s.l_dims
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
 
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
   
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr610_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr610_g01_rep_data()
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
          START REPORT axmr610_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr610_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr610_g01_rep
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
 
{<section id="axmr610_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr610_g01_rep(sr1)
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
DEFINE l_xmel005_show   LIKE type_t.chr10      #訂單單號
DEFINE l_xmel014_show   LIKE type_t.chr10      #單頭備註
DEFINE l_xmem012_sum    LIKE xmem_t.xmem012    #數量加總
DEFINE l_xmem015_sum    LIKE xmem_t.xmem015    #總淨重加總 dorislai-20150915-add
DEFINE l_xmem017_sum    LIKE xmem_t.xmem017    #總毛重加總
DEFINE l_xmem019_sum    LIKE xmem_t.xmem019    #總材積加總
DEFINE l_xmem007_sum    LIKE xmem_t.xmem007    #箱數加總
DEFINE l_xmem007_sum_e  LIKE type_t.chr100     #總箱數英文
DEFINE l_xmem009_o      LIKE xmem_t.xmem009    #棧板號舊值
DEFINE l_pallet_sum LIKE type_t.chr1000        #包裝方式 
DEFINE l_pallet_sum_show LIKE type_t.chr10     #Pallet隱藏   
#add--2015/06/15 By shiun--(S)
DEFINE l_xmao001   LIKE xmao_t.xmao001         #客戶編號
DEFINE l_xmao002   LIKE xmao_t.xmao002         #嘜頭編號
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
#add--2015/06/15 By shiun--(S)
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
#DEFINE l_xmao001         LIKE xmao_t.xmao001         #客戶編號
#DEFINE l_xmao002         LIKE xmao_t.xmao002         #嘜頭編號
DEFINE l_xmap006_array   LIKE xmap_t.xmap006         #資料內容
DEFINE l_xmap003         LIKE xmap_t.xmap003         #類別
DEFINE l_xmap004         LIKE xmap_t.xmap004         #行序
DEFINE l_xmda004_credit_show    LIKE  type_t.chr1      #額度是否超限顯示
DEFINE l_xmaj002_1     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(據點)
DEFINE l_xmaj002_2     LIKE xmaj_t.xmaj002      #訂單確認時超限控管方式(集團)
#add--2015/08/17 By shiun--(E)
#161205-00042#4-s
DEFINE l_js              STRING
DEFINE l_loaa001         LIKE loaa_t.loaa001
DEFINE l_xmap006_img     LIKE type_t.chr1000      #資料內容(圖片)
DEFINE l_xmap006_img_arr DYNAMIC ARRAY OF STRING
DEFINE l_imgstr          LIKE xmap_t.xmap006      #圖中字內容
#161205-00042#4-e
DEFINe ls_url_surc  STRING   #161205-00042#1-add
DEFINe ls_url_dest  STRING   #161205-00042#1-add
DEFINE l_imaal004_show   LIKE type_t.chr1      #161031-00024#3 Add By ken 170206
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.xmeldocno,sr1.xmem010
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
        BEFORE GROUP OF sr1.xmeldocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmeldocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmelent=' ,sr1.xmelent,'{+}xmeldocno=' ,sr1.xmeldocno         
            CALL cl_gr_init_apr(sr1.xmeldocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmeldocno.before name="rep.b_group.xmeldocno.before"
           LET l_xmem012_sum = 0    #數量清空  dorislai-20150915-add
           LET l_xmem015_sum = 0    #重量清空 
           LET l_xmem017_sum = 0
           LET l_xmem019_sum = 0
           LET l_xmem007_sum = 0
           
           #計量制度轉換(
           IF sr1.xmel012 = 1 THEN 
             LET sr1.l_volume_desc = "Volume(CBM)"
           ELSE
             LET sr1.l_volume_desc = "Volume(Cuft)" 
           END IF 
           
           #161031-00024#3 Add By Ken 170206(S)
           #規格若為空，則隱藏
           INITIALIZE l_imaal004_show TO NULL
           IF cl_null(sr1.l_imaal004_desc) THEN
              LET l_imaal004_show = 'N'
           ELSE
              LET l_imaal004_show = 'Y'
           END IF
           PRINTX l_imaal004_show
           #161031-00024#3 Add By Ken 170206(E)              
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmelent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmeldocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr610_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr610_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr610_g01_subrep01
           DECLARE axmr610_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr610_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr610_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr610_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr610_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmeldocno.after name="rep.b_group.xmeldocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmem010
 
           #add-point:rep.b_group.xmem010.before name="rep.b_group.xmem010.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmem010.after name="rep.b_group.xmem010.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
       
       #若訂單單號為null，將會隱藏
       IF cl_null(sr1.xmel005) THEN  
           LET l_xmel005_show = "N"
       ELSE
           LET l_xmel005_show = "Y"
       END IF
     
       #若產品特徵為null，將會隱藏
       IF cl_null(sr1.xmel014) THEN  
           LET l_xmel014_show = "N"
       ELSE
           LET l_xmel014_show = "Y"
       END IF
       #modify--2015/06/15 By shiun--(S)
#       #若棧板號為null，將會隱藏
#       IF cl_null(sr1.xmem001 OR sr1.xmem009) THEN  
#           LET l_pallet_sum_show = "N"
#       ELSE
#           LET l_pallet_sum_show = "Y"
#       END IF
#       
       PRINTX l_xmel005_show,l_xmel014_show#,l_pallet_sum_show
       #modify--2015/06/15 By shiun--(E)
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.xmelent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmeldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmem010 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr610_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr610_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr610_g01_subrep02
           DECLARE axmr610_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr610_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr610_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr610_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr610_g01_subrep02
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
                sr1.xmelent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmeldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmem010 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr610_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr610_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr610_g01_subrep03
           DECLARE axmr610_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr610_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr610_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr610_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr610_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
             
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmeldocno
 
           #add-point:rep.a_group.xmeldocno.before name="rep.a_group.xmeldocno.before"
   
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmelent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmeldocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr610_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr610_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr610_g01_subrep04
           DECLARE axmr610_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr610_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr610_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr610_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr610_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmeldocno.after name="rep.a_group.xmeldocno.after"
          
#            START REPORT axmr610_g01_subrep05
#               LET g_sql = " SELECT xmemdocno,xmem009,xmem010,xmem011 ",
#                           "  FROM xmem_t ",
#                           "  WHERE xmement = '",sr1.xmelent,"' ",
#                           "    AND xmemdocno = '",sr1.xmeldocno CLIPPED,"'",
#                           "  ORDER BY xmem009 "
#               DECLARE axmr610_g01_repcur05 CURSOR FROM g_sql
#               
#               #棧板號+起始包裝號+截止包裝號之處理(組完棧板號後，印出)
#               LET l_xmem009_o = ''  
#               LET l_pallet_sum = ''
#               FOREACH axmr610_g01_repcur05 INTO sr3.*
#               
#               IF cl_null(l_xmem009_o) THEN
#                     IF sr3.xmem010 = sr3.xmem011 THEN 
#                        LET l_pallet_sum = sr3.xmem009," " , ":",sr3.xmem010
#                     ELSE 
#                        LET l_pallet_sum = sr3.xmem009," " , ":",sr3.xmem010," ","~"," ",sr3.xmem011
#                     END IF   
#               ELSE
#                  IF l_xmem009_o = sr3.xmem009 THEN
#                     IF sr3.xmem010 = sr3.xmem011 THEN
#                        LET l_pallet_sum = l_pallet_sum," , ",sr3.xmem010
#                     ELSE
#                        LET l_pallet_sum = l_pallet_sum," , ",sr3.xmem010," ","~"," ",sr3.xmem011
#                     END IF
#                  ELSE
#                     
#                     OUTPUT TO REPORT axmr610_g01_subrep05(l_pallet_sum)
#                     IF sr3.xmem010 = sr3.xmem011 THEN 
#                        LET l_pallet_sum = sr3.xmem009," ",":",sr3.xmem010 
#                     ELSE 
#                        LET l_pallet_sum = sr3.xmem009," ",":",sr3.xmem010," ","~"," ",sr3.xmem011
#                     END IF
#                  END IF
#               END IF
#               
#               LET l_xmem009_o = sr3.xmem009
#      
#               END FOREACH
#               OUTPUT TO REPORT axmr610_g01_subrep05(l_pallet_sum)
#            FINISH REPORT axmr610_g01_subrep05
           START REPORT axmr610_g01_subrep05
              CASE
                 WHEN sr1.xmel004 = '1'  #出貨通知單axmt520    
                    SELECT xmdg005,xmdg023 INTO l_xmao001,l_xmao002
                      FROM xmdg_t
                     WHERE xmdgdocno = sr1.xmel005 
                       AND xmdgent = sr1.xmelent
                 WHEN sr1.xmel004 = '2'
                    SELECT xmdk007,xmdk027 INTO l_xmao001,l_xmao002
                      FROM xmdk_t  
                     #161205-00042#4-s 
                     #WHERE xmdkdocno = sr_s.xmel005 
                       #AND xmdkent = sr_s.xmelent
                      WHERE xmdkdocno = sr1.xmel005 
                       AND xmdkent = sr1.xmelent  
                     #161205-00042#4-e  
              END CASE
              LET l_count = 0
              IF NOT cl_null(l_xmao001) AND NOT cl_null(l_xmao002) THEN
#                 SELECT COUNT(*) INTO l_count
#                   FROM xmao_t,xmap_t
#                  WHERE xmaoent = xmapent
#                    AND xmao001 = xmap001
#                    AND xmao002 = xmap002
#                    AND xmaoent = sr1.xmelent
#                    AND xmao001 = l_xmao001
#                    AND xmao002 = l_xmao002
                 CALL axmr610_g01_cre_tmp_table()  #add--2015/08/17 By shiun
                 #161205-00042#4-mod-s
#                LET g_sql = " SELECT xmao003,xmao004,xmao001,xmao002,xmap003,xmap004,xmap005,xmap006 ",
                 LET g_sql = " SELECT xmao003,xmao004,xmao001,xmao002,xmap003,xmap004,xmap005,xmap006,'','','','','' ",
                 #161205-00042#4-mod-e
                             "   FROM xmao_t,xmap_t ",
                             "  WHERE xmaoent = xmapent",
                             "    AND xmao001 = xmap001",
                             "    AND xmao002 = xmap002",
                             "    AND xmaoent = '",sr1.xmelent,"' ",
                             "    AND xmao001 = '",l_xmao001,"'",
                             "    AND xmao002 = '",l_xmao002,"'",
                             "  ORDER BY xmap003,xmap004 "
                 DECLARE axmr610_g01_repcur05 CURSOR FROM g_sql                                  
                 #add--2015/08/17 By shiun--(S)
                 #161205-00042#5-mod-s
#                LET l_tmp_sql = " INSERT INTO axmr610_g01_temp (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap003_show) VALUES (?,?,?,?,?,?,?) "  
                 LET l_tmp_sql = " INSERT INTO axmr610_g01_temp (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show) VALUES (?,?,?,?,?, ?,?,?,?) "  
                 LET l_xmao003 = ''
                 LET l_xmao004 = ''
                 LET l_tmp_sql = " INSERT INTO axmr610_g01_temp (xmao001,xmao002,xmap003,l_xmap003_desc,xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show) VALUES (?,?,?,?,?,?,?,?,?) "
                 #161205-00042#5-mod-e  
                 PREPARE master_tmp FROM l_tmp_sql
                 #add--2015/08/17 By shiun--(E)
                 FOREACH axmr610_g01_repcur05 INTO l_xmao003,l_xmao004,sr3.*                    
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
                        CALL s_axmi210_assemble(sr1.xmeldocno,l_str,l_xmao003,l_xmao004) RETURNING l_out
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
                    SELECT MIN(xmap004) INTO l_min
                      FROM xmap_t
                     WHERE xmapent = sr1.xmelent
                       AND xmap001 = l_xmao001
                       AND xmap002 = l_xmao002
                       AND xmap003 = sr3.xmap003
                    IF sr3.xmap004 = l_min THEN
                       LET sr3.l_xmap003_show = 'Y'
                    ELSE
                       LET sr3.l_xmap003_show = 'N'
                    END IF
                    #161205-00042#4-s
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
                    #161205-00042#4-e              
                    #161205-00042#4-s
#                   EXECUTE master_tmp USING sr3.xmao001,sr3.xmao002,sr3.xmap003,sr3.l_xmap003_desc,sr3.xmap004,sr3.xmap006,sr3.l_xmap003_show  #add--2015/08/12 By shiun
                    #add--2015/08/12 By shiun
                    EXECUTE master_tmp USING sr3.xmao001,sr3.xmao002,sr3.xmap003,sr3.l_xmap003_desc,sr3.xmap004,sr3.xmap006,sr3.l_xmap006_img,sr3.l_imgstr,sr3.l_xmap003_show
                    #161205-00042#4-e                    
                 END FOREACH
                 #add--2015/08/17 By shiun--(S)
                 LET l_xmap003_sql = " SELECT DISTINCT xmap003,l_xmap003_desc ",
                                     " FROM axmr610_g01_temp ",
                                     " ORDER BY xmap003"
                 #161205-00042#4-mod-s
#                LET l_xmap006_sql = " SELECT DISTINCT xmap004,xmap006,l_xmap003_show,xmao001,xmao002 ",
                 LET l_xmap006_sql = " SELECT DISTINCT xmap004,xmap006,l_xmap006_img,l_imgstr,l_xmap003_show,xmao001,xmao002 ",
                 #161205-00042#4-mod-e
                                     " FROM axmr610_g01_temp ",
                                     " WHERE l_xmap003_desc = ?",
                                     " ORDER BY xmap004"
                 DECLARE axmr610_g01_xmap003 CURSOR FROM l_xmap003_sql 
                 
                 PREPARE axmr610_g01_xmap006_pb FROM l_xmap006_sql                 
                 DECLARE axmr610_g01_xmap006_cs CURSOR FOR axmr610_g01_xmap006_pb   
                 
                 LET l_i = 1
                 LET l_max_count = 1
                 
                 FOREACH axmr610_g01_xmap003 INTO l_xmap003,l_xmap003_desc
                    LET l_j = l_max_count
                    OPEN axmr610_g01_xmap006_cs USING l_xmap003_desc
                    
                    #161205-00042#4-mod-s
#                   FOREACH axmr610_g01_xmap006_cs INTO l_xmap004,l_xmap006_array,l_xmap003_show,l_xmao001,l_xmao002
                    FOREACH axmr610_g01_xmap006_cs INTO l_xmap004,l_xmap006_array,l_xmap006_img,l_imgstr,l_xmap003_show,l_xmao001,l_xmao002
                    #161205-00042#4-mod-e
                       IF l_i MOD 2 = 1 THEN
                          #161205-00042#4-add-s
                          #圖中字放置，在4rp中根據預設圖檔的不同會放置不同位置&大小的圖中字
                          IF NOT cl_null(l_imgstr) THEN
                             LET sr5[l_j-1].l_imgstr_1 = l_imgstr
                             CONTINUE FOREACH
                          END IF
                          #161205-00042#4-add-e
                          IF l_xmap003_show = 'Y' THEN
                             LET sr5[l_j].l_xmap003_desc_1 = l_xmap003_desc
                          ELSE
                             LET sr5[l_j].l_xmap003_desc_1 = ' '
                          END IF
                          LET sr5[l_j].xmao001 = l_xmao001
                          LET sr5[l_j].xmao002 = l_xmao002
                          LET sr5[l_j].xmap006_1 = l_xmap006_array
                          #161205-00042#4-add-s
                          LET sr5[l_j].l_xmap006_1_img = l_xmap006_img
                          DISPLAY "sr5[l_j].l_xmap006_1_img:",sr5[l_j].l_xmap006_1_img
                          #161205-00042#4-add-e
                       ELSE
                          #161205-00042#4-add-s
                          #圖中字放置，在4rp中根據預設圖檔的不同會放置不同位置&大小的圖中字
                          IF NOT cl_null(l_imgstr) THEN
                             LET sr5[l_j-1].l_imgstr_2 = l_imgstr
                             CONTINUE FOREACH
                          END IF
                          #161205-00042#4-add-e
                          IF l_xmap003_show = 'Y' THEN
                             LET sr5[l_j].l_xmap003_desc_2 = l_xmap003_desc
                          ELSE
                             LET sr5[l_j].l_xmap003_desc_2 = ' '
                          END IF
                          LET sr5[l_j].xmao001 = l_xmao001
                          LET sr5[l_j].xmao002 = l_xmao002
                          LET sr5[l_j].xmap006_2 = l_xmap006_array
                          #161205-00042#4-add-s
                          LET sr5[l_j].l_xmap006_2_img = l_xmap006_img
                          DISPLAY "sr5[l_j].l_xmap006_2_img:",sr5[l_j].l_xmap006_2_img
                          #161205-00042#4-add-e
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
                    #161205-00042#4-add-s
                    LET sr4.l_xmap006_1_img = sr5[l_ac].l_xmap006_1_img
                    LET sr4.l_xmap006_2_img = sr5[l_ac].l_xmap006_2_img            
                    LET sr4.l_imgstr_1 = sr5[l_ac].l_imgstr_1
                    LET sr4.l_imgstr_2 = sr5[l_ac].l_imgstr_2   
                    #161205-00042#4-add-e
                    OUTPUT TO REPORT axmr610_g01_subrep05(sr4.*)
                    LET l_ac = l_ac + 1
                    IF l_ac > l_while_count THEN
                       EXIT WHILE
                    END IF
                 END WHILE
                 #add--2015/08/17 BY shiun--(E)                 
              END IF
              CLOSE master_tmp   #add--2015/08/17 By shiun
           FINISH REPORT axmr610_g01_subrep05 

               LET l_xmem012_sum = GROUP SUM(sr1.xmem012)    #數量加總    dorislai-20150915-add
               LET l_xmem015_sum = GROUP SUM(sr1.xmem015)    #總淨重加總
               LET l_xmem017_sum = GROUP SUM(sr1.xmem017)    #總毛重加總 
               LET l_xmem019_sum = GROUP SUM(sr1.xmem019)    #總材積加總
               LET l_xmem007_sum = GROUP SUM(sr1.xmem007)    #總箱數加總
                
               CALL s_num_to_english (l_xmem007_sum) RETURNING l_xmem007_sum_e
                
               #將轉換英文的字串，ONLY → CARTONS ONLY
               LET l_xmem007_sum_e = "SAY TOTAL"," ",cl_replace_str(l_xmem007_sum_e,'ONLY','CARTONS ONLY')
               
               #dorislai-20150915-modify----(S)               
#               PRINTX l_xmem015_sum,l_xmem017_sum,l_xmem019_sum,l_xmem007_sum_e
               PRINTX l_xmem012_sum,l_xmem015_sum,l_xmem017_sum,l_xmem019_sum,l_xmem007_sum_e
               #dorislai-20150915-modify----(E)
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmem010
 
           #add-point:rep.a_group.xmem010.before name="rep.a_group.xmem010.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmem010.after name="rep.a_group.xmem010.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
            
            #PRINTX sr1.l_pallet_desc #123
            
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            CALL s_axmi210_drop_tmp_table()  #add--2015/07/01 By shiun
            CALL axmr610_g01_drop_tmp_table()   #add--2015/08/17 By shiun
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr610_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr610_g01_subrep01(sr2)
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
PRIVATE REPORT axmr610_g01_subrep02(sr2)
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
PRIVATE REPORT axmr610_g01_subrep03(sr2)
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
PRIVATE REPORT axmr610_g01_subrep04(sr2)
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
 
{<section id="axmr610_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION axmr610_g01_assemble(p_str1,p_str2)
   DEFINE p_str1  STRING
   DEFINE p_str2  STRING
   DEFINE r_assemble STRING
   DEFINE p_mid   LIKE type_t.chr1

   IF cl_null(p_str1) AND cl_null(p_str2) THEN
      INITIALIZE r_assemble TO NULL
   ELSE
      IF cl_null(p_str1) OR cl_null(p_str2) THEN
         LET r_assemble = p_str1 , (p_str2 USING '&&&')
         LET r_assemble = r_assemble.trim()
      ELSE
         LET r_assemble = p_str1 || (p_str2 USING '&&&')
      END IF
   END IF

   RETURN r_assemble
END FUNCTION
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axmr610_g01_cre_tmp_table()
#                  RETURNING r_success
# Input parameter: 無
# Date & Author..: 2015/08/17 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr610_g01_cre_tmp_table()
DROP TABLE axmr610_g01_temp;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop axmr610_g01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE axmr610_g01_temp(
                   xmao001        LIKE xmao_t.xmao001,          #客戶編號
                   xmao002        LIKE xmao_t.xmao002,          #嘜頭編號
                   xmap003        LIKE xmap_t.xmap003,          #類別
                   l_xmap003_desc LIKE type_t.chr500,           #類別說明
                   xmap004        LIKE xmap_t.xmap004,          #行序
                   xmap006        LIKE xmap_t.xmap006,          #資料內容
                   l_xmap006_img  LIKE type_t.chr1000,          #資料內容(圖)   #161205-00042#4-add
                   l_imgstr       LIKE xmap_t.xmap006,          #圖中字內容     #161205-00042#4-add
                   l_xmap003_show LIKE type_t.chr1              #類別顯示否
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmr610_g01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
END FUNCTION
################################################################################
# Descriptions...: 刪除臨時表
# Memo...........:
# Usage..........: CALL axmr610_g01_drop_tmp_table()
# Input parameter:
# Return code....:
# Date & Author..: 2015/08/17 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr610_g01_drop_tmp_table()

   DROP TABLE axmr610_g01_temp;

END FUNCTION

################################################################################
# Descriptions...: 161207-00033#14
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/12/29 By 08992
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr610_g01_guest_desc1(p_xmdg006,p_xmdg007,p_xmel003,p_xmeldocno)
   DEFINE r_pmak003       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#14 add
   DEFINE r_pmak003_1       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#14 add
   DEFINE l_pmak003       LIKE pmak_t.pmak003
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#14 add
   DEFINE l_sql1          STRING                                   #161207-00033#14 add
   DEFINE p_xmdg006      LIKE xmdg_t.xmdg006
   DEFINE p_xmdg007     LIKE xmdg_t.xmdg007
   DEFINE p_xmel003     LIKE xmel_t.xmel003
   DEFINE p_xmeldocno     LIKE xmel_t.xmeldocno
   LET l_sql1 = "SELECT pmaa004 FROM pmaa_t        ",
               " WHERE pmaaent ='",g_enterprise,"'",
               "   AND pmaa001 = ?  "
   PREPARE axmr610_pb FROM l_sql1            
   EXECUTE axmr610_pb USING p_xmel003 INTO l_pmaa004       
   LET r_pmak003 = ''  
   LET r_pmak003_1 = ''
   IF l_pmaa004 = '2' THEN   #2.一次性交易對象
      CALL s_desc_axm_get_oneturn_guest_desc('5',p_xmeldocno)
      RETURNING l_pmak003  
       #一次性交易對象全名
      IF p_xmdg006 = p_xmel003 THEN   #帳款客戶
         LET r_pmak003_1 = l_pmak003
      END IF
      IF p_xmdg007 = p_xmel003 THEN   #收貨客戶
         LET r_pmak003 = l_pmak003
      END IF
   END IF          
   IF cl_null(r_pmak003) THEN
      CALL s_desc_get_trading_partner_full_desc(p_xmdg007) RETURNING r_pmak003
   END IF
   IF cl_null(r_pmak003_1) THEN
      CALL s_desc_get_trading_partner_full_desc(p_xmdg006) RETURNING r_pmak003_1             
   END IF

   RETURN r_pmak003,r_pmak003_1    
  

   
END FUNCTION

 
{</section>}
 
{<section id="axmr610_g01.other_report" readonly="Y" >}
################################################################################
# Descriptions...: 棧板號
# Memo...........:
# Usage..........: CALL axmr610_g01_subrep05(sr4)
#                
# Input parameter: sr4            
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/09 By zechs
# Modify.........:
################################################################################
PRIVATE REPORT axmr610_g01_subrep05(sr4)
#DEFINE l_pallet_sum LIKE type_t.chr1000
#      FORMAT
#        ON EVERY ROW
#           PRINTX l_pallet_sum
   DEFINE sr4 sr4_r
   ORDER EXTERNAL BY sr4.xmao001,sr4.xmao002
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
END REPORT

 
{</section>}
 
