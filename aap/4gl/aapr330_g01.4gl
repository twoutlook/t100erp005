#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr330_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:12(2016-11-08 15:25:06), PR版次:0012(2016-11-08 15:34:52)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000235
#+ Filename...: aapr330_g01
#+ Description: ...
#+ Creator....: 02097(2014-04-23 17:43:56)
#+ Modifier...: 08729 -SD/PR- 08729
 
{</section>}
 
{<section id="aapr330_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#150622-00008#3  2015/07/13 新增標準樣板(無表格) by RayHuang
#150908-00011#1  2015/09/09 應付款金額列印,應該要取 未付餘額
#160122-00001#16 2016/02/14 By yangtt   添加交易帳戶編號用戶權限空管
#160414-00018#14 2016/05/04 By Hans     效能調校
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   apcb047 LIKE apcb_t.apcb047, 
   apca123 LIKE apca_t.apca123, 
   apca041 LIKE apca_t.apca041, 
   apca131 LIKE apca_t.apca131, 
   apcb007 LIKE apcb_t.apcb007, 
   apcb023 LIKE apcb_t.apcb023, 
   apca008 LIKE apca_t.apca008, 
   apca118 LIKE apca_t.apca118, 
   apca009 LIKE apca_t.apca009, 
   apca010 LIKE apca_t.apca010, 
   apca015 LIKE apca_t.apca015, 
   apca017 LIKE apca_t.apca017, 
   apca019 LIKE apca_t.apca019, 
   apca053 LIKE apca_t.apca053, 
   apca063 LIKE apca_t.apca063, 
   apca121 LIKE apca_t.apca121, 
   apca138 LIKE apca_t.apca138, 
   apcald LIKE apca_t.apcald, 
   apcb115 LIKE apcb_t.apcb115, 
   apcb009 LIKE apcb_t.apcb009, 
   apcb021 LIKE apcb_t.apcb021, 
   apcb028 LIKE apcb_t.apcb028, 
   apca005 LIKE apca_t.apca005, 
   apca031 LIKE apca_t.apca031, 
   apca038 LIKE apca_t.apca038, 
   apca039 LIKE apca_t.apca039, 
   apca040 LIKE apca_t.apca040, 
   apca044 LIKE apca_t.apca044, 
   apca057 LIKE apca_t.apca057, 
   apcacomp LIKE apca_t.apcacomp, 
   apcastus LIKE apca_t.apcastus, 
   apcb002 LIKE apcb_t.apcb002, 
   apcb135 LIKE apcb_t.apcb135, 
   apcb004 LIKE apcb_t.apcb004, 
   apcb012 LIKE apcb_t.apcb012, 
   apcb015 LIKE apcb_t.apcb015, 
   apcb016 LIKE apcb_t.apcb016, 
   apcb103 LIKE apcb_t.apcb103, 
   apca133 LIKE apca_t.apca133, 
   apca101 LIKE apca_t.apca101, 
   apca130 LIKE apca_t.apca130, 
   apca137 LIKE apca_t.apca137, 
   apcb005 LIKE apcb_t.apcb005, 
   apcb011 LIKE apcb_t.apcb011, 
   apcb101 LIKE apcb_t.apcb101, 
   apcb121 LIKE apcb_t.apcb121, 
   apcborga LIKE apcb_t.apcborga, 
   apca007 LIKE apca_t.apca007, 
   apca059 LIKE apca_t.apca059, 
   apca128 LIKE apca_t.apca128, 
   apca113 LIKE apca_t.apca113, 
   apca014 LIKE apca_t.apca014, 
   apca027 LIKE apca_t.apca027, 
   apca028 LIKE apca_t.apca028, 
   apca034 LIKE apca_t.apca034, 
   apcasite LIKE apca_t.apcasite, 
   apcb003 LIKE apcb_t.apcb003, 
   apcb105 LIKE apcb_t.apcb105, 
   apcb010 LIKE apcb_t.apcb010, 
   apcb100 LIKE apcb_t.apcb100, 
   apcblegl LIKE apcb_t.apcblegl, 
   apca016 LIKE apca_t.apca016, 
   apca018 LIKE apca_t.apca018, 
   apca025 LIKE apca_t.apca025, 
   apca035 LIKE apca_t.apca035, 
   apca036 LIKE apca_t.apca036, 
   apca042 LIKE apca_t.apca042, 
   apca120 LIKE apca_t.apca120, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apcb008 LIKE apcb_t.apcb008, 
   apcbseq LIKE apcb_t.apcbseq, 
   apca003 LIKE apca_t.apca003, 
   apca117 LIKE apca_t.apca117, 
   apca004 LIKE apca_t.apca004, 
   apca026 LIKE apca_t.apca026, 
   apca029 LIKE apca_t.apca029, 
   apca043 LIKE apca_t.apca043, 
   apca045 LIKE apca_t.apca045, 
   apca051 LIKE apca_t.apca051, 
   apca054 LIKE apca_t.apca054, 
   apca056 LIKE apca_t.apca056, 
   apcadocno LIKE apca_t.apcadocno, 
   apcb125 LIKE apcb_t.apcb125, 
   apcb024 LIKE apcb_t.apcb024, 
   apcb027 LIKE apcb_t.apcb027, 
   apcb131 LIKE apcb_t.apcb131, 
   apca050 LIKE apca_t.apca050, 
   apca001 LIKE apca_t.apca001, 
   apca030 LIKE apca_t.apca030, 
   apca052 LIKE apca_t.apca052, 
   apca055 LIKE apca_t.apca055, 
   apca127 LIKE apca_t.apca127, 
   apcb014 LIKE apcb_t.apcb014, 
   apcb017 LIKE apcb_t.apcb017, 
   l_apca015_ooefl003 LIKE type_t.chr80, 
   l_apca014_ooag011 LIKE type_t.chr80, 
   l_apca007_desc LIKE type_t.chr80, 
   l_apca003_ooag011 LIKE type_t.chr80, 
   apcaent LIKE apca_t.apcaent, 
   l_apca057_ooag011 LIKE type_t.chr80, 
   l_apcasite_ooefl003 LIKE type_t.chr80, 
   apcb102 LIKE apcb_t.apcb102
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
TYPE sr5_r RECORD #
   apcc004      LIKE apcc_t.apcc004,
   apcc002      LIKE apcc_t.apcc002,
   apcc002_desc LIKE type_t.chr500,
   apcc100      LIKE apcc_t.apcc100,
   apcc108      LIKE apcc_t.apcc108,
   apcc101      LIKE apcc_t.apcc101,
   apcc118      LIKE apcc_t.apcc118
END RECORD

TYPE sr6_r RECORD #借支沖銷
   apcedocno LIKE apce_t.apcedocno,
   apce003   LIKE apce_t.apce003,
   apce100   LIKE apce_t.apce100,
   apce109   LIKE apce_t.apce109,
   apce101   LIKE apce_t.apce119,
   apce119   LIKE apce_t.apce119
END RECORD

TYPE sr7_r RECORD #繳回款項
   apcedocno LIKE apce_t.apcedocno,
   apce010   LIKE apce_t.apce010,
   apce008   LIKE apce_t.apce008,
   apce100   LIKE apce_t.apce100,
   apce109   LIKE apce_t.apce109,
   apce102   LIKE apce_t.apce101,
   apce119   LIKE apce_t.apce119
END RECORD

TYPE sr8_r RECORD #發票及收據明細
   isam008      LIKE isam_t.isam008,
   isam008_desc LIKE type_t.chr500,
   isam009      LIKE isam_t.isam009,
   isam010      LIKE isam_t.isam010,
   isam011      LIKE isam_t.isam011,
   isam014      LIKE isam_t.isam014,
   isam023      LIKE isam_t.isam023,
   isam024      LIKE isam_t.isam024,
   isam025      LIKE isam_t.isam025
END RECORD

TYPE sr9_r RECORD
   apcb100       LIKE apcb_t.apcb100,
   apcb105       LIKE apcb_t.apcb105,
   apcb100_show  LIKE type_t.chr1
END RECORD

TYPE sr10_r RECORD
   apcb115       LIKE apcb_t.apcb115,
   glaa001       LIKE glaa_t.glaa001
END RECORD

TYPE sr11_r RECORD #直接付款
   apdedocno    LIKE apde_t.apdedocno,
   apde008      LIKE apde_t.apde008,
   apde008_desc LIKE type_t.chr500,
   apde006      LIKE apde_t.apde006,
   apde006_desc LIKE type_t.chr500,
   apde100      LIKE apde_t.apde100,
   apde109      LIKE apde_t.apde109
END RECORD

TYPE sr12_r RECORD # 幣別/發票金額合計 
   isam014      LIKE isam_t.isam014,
   isam026      LIKE isam_t.isam026,
   isam027      LIKE isam_t.isam027,
   isam028      LIKE isam_t.isam028
END RECORD

DEFINE g_sql_bank       STRING #160122-00001#16 add by07675
#end add-point
 
{</section>}
 
{<section id="aapr330_g01.main" readonly="Y" >}
PUBLIC FUNCTION aapr330_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #160122-00001#16 --add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#16 --add--end
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aapr330_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aapr330_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aapr330_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aapr330_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr330_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr330_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
 
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160414-00018#14---s---
   LET g_select = " SELECT apcb047,apca123,apca041,apca131,apcb007,apcb023,apca008,apca118,apca009,apca010,                    ",
                  "        apca015,apca017,apca019,apca053,apca063,apca121,apca138,apcald,apcb115,apcb009,apcb021,apcb028,     ",
                  "        apca005,apca031,apca038,apca039,apca040,apca044,apca057,apcacomp,apcastus,apcb002,apcb135,apcb004,  ",
                  "        apcb012,apcb015,apcb016,apcb103,apca133,apca101,apca130,apca137,apcb005,apcb011,apcb101,apcb121,    ",
                  "        apcborga,apca007,apca059,apca128,apca113,apca014,apca027,apca028,apca034,apcasite,apcb003,apcb105,  ",
                  "        apcb010,apcb100,apcblegl,apca016,apca018,apca025,apca035,apca036,apca042,apca120,apcadocdt,apcb008, ",
                  "        apcbseq,apca003,apca117,apca004,apca026,apca029,apca043,apca045,apca051,apca054,apca056,apcadocno,  ",
                  "        apcb125,apcb024,apcb027,apcb131,apca050,apca001,apca030,apca052,apca055,apca127,apcb014,apcb017,    ",
                  #費用部門
                  " CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apca015 AND ooefl002 ='",g_dlang,"')  ",
                  " IS NULL THEN apca015 ELSE ",
                  "           (SELECT apca015||'.'||ooefl003 FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apca015 AND ooefl002 ='",g_dlang,"') END, ",
                  #請款人員
                  " CASE WHEN (SELECT ooag011 FROM ooag_t WHERE ooag001 = apca014 AND ooagent = apcaent ) ",
                  " IS NUlL THEN apca014 ELSE ",
                  "          (SELECT apca014||'.'||ooag011 FROM ooag_t WHERE ooag001 = apca014 AND ooagent = apcaent) END, ",
                  #帳款類別
                  " (SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = 3211 AND oocql002 = apca007 AND oocql003 = '",g_dlang,"'), ",
                  #帳務人員
                  " CASE WHEN (SELECT ooag011 FROM ooag_t WHERE ooag001 = apca003 AND ooagent = apcaent ) ",
                  " IS NUlL THEN apca003 ELSE ",
                  "          (SELECT apca003||'.'||ooag011 FROM ooag_t WHERE ooag001 = apca003 AND ooagent = apcaent) END, ",
                  "  apcaent, ",
                  #受款對象
                  " CASE WHEN (SELECT ooag011 FROM ooag_t WHERE ooag001 = apca057 AND ooagent = apcaent ) ",
                  " IS NUlL THEN apca057 ELSE ",
                  "          (SELECT apca057||'.'||ooag011 FROM ooag_t WHERE ooag001 = apca057 AND ooagent = apcaent) END, ", 
                  #帳務中心
                  " CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apcasite AND ooefl002 ='",g_dlang,"')  ",                
                  " IS NULL THEN apcasite ELSE ",
                  "           (SELECT apcasite||'.'||ooefl003 FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apcasite AND ooefl002 ='",g_dlang,"') END, ",
                  " apcb102  "
   #160414-00018#14---e---                      
#   #end add-point
#   LET g_select = " SELECT apcb047,apca123,apca041,apca131,apcb007,apcb023,apca008,apca118,apca009,apca010, 
#       apca015,apca017,apca019,apca053,apca063,apca121,apca138,apcald,apcb115,apcb009,apcb021,apcb028, 
#       apca005,apca031,apca038,apca039,apca040,apca044,apca057,apcacomp,apcastus,apcb002,apcb135,apcb004, 
#       apcb012,apcb015,apcb016,apcb103,apca133,apca101,apca130,apca137,apcb005,apcb011,apcb101,apcb121, 
#       apcborga,apca007,apca059,apca128,apca113,apca014,apca027,apca028,apca034,apcasite,apcb003,apcb105, 
#       apcb010,apcb100,apcblegl,apca016,apca018,apca025,apca035,apca036,apca042,apca120,apcadocdt,apcb008, 
#       apcbseq,apca003,apca117,apca004,apca026,apca029,apca043,apca045,apca051,apca054,apca056,apcadocno, 
#       apcb125,apcb024,apcb027,apcb131,apca050,apca001,apca030,apca052,apca055,apca127,apcb014,apcb017, 
#       '','','',NULL,apcaent,'','',apcb102"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM  apca_t  LEFT OUTER JOIN ( SELECT apcb_t.* FROM apcb_t WHERE apcbent = '",g_enterprise,"' ) x  ON apca_t.apcaent     
                               = x.apcbent AND apca_t.apcald = x.apcbld AND apca_t.apcadocno = x.apcbdocno"   #160414-00018#14

#   #end add-point
#    LET g_from = " FROM  apca_t  LEFT OUTER JOIN ( SELECT apcb_t.* FROM apcb_t  ) x  ON apca_t.apcaent  
#        = x.apcbent AND apca_t.apcald = x.apcbld AND apca_t.apcadocno = x.apcbdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY apcadocno,apcbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("apca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aapr330_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aapr330_g01_curs CURSOR FOR aapr330_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr330_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapr330_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   apcb047 LIKE apcb_t.apcb047, 
   apca123 LIKE apca_t.apca123, 
   apca041 LIKE apca_t.apca041, 
   apca131 LIKE apca_t.apca131, 
   apcb007 LIKE apcb_t.apcb007, 
   apcb023 LIKE apcb_t.apcb023, 
   apca008 LIKE apca_t.apca008, 
   apca118 LIKE apca_t.apca118, 
   apca009 LIKE apca_t.apca009, 
   apca010 LIKE apca_t.apca010, 
   apca015 LIKE apca_t.apca015, 
   apca017 LIKE apca_t.apca017, 
   apca019 LIKE apca_t.apca019, 
   apca053 LIKE apca_t.apca053, 
   apca063 LIKE apca_t.apca063, 
   apca121 LIKE apca_t.apca121, 
   apca138 LIKE apca_t.apca138, 
   apcald LIKE apca_t.apcald, 
   apcb115 LIKE apcb_t.apcb115, 
   apcb009 LIKE apcb_t.apcb009, 
   apcb021 LIKE apcb_t.apcb021, 
   apcb028 LIKE apcb_t.apcb028, 
   apca005 LIKE apca_t.apca005, 
   apca031 LIKE apca_t.apca031, 
   apca038 LIKE apca_t.apca038, 
   apca039 LIKE apca_t.apca039, 
   apca040 LIKE apca_t.apca040, 
   apca044 LIKE apca_t.apca044, 
   apca057 LIKE apca_t.apca057, 
   apcacomp LIKE apca_t.apcacomp, 
   apcastus LIKE apca_t.apcastus, 
   apcb002 LIKE apcb_t.apcb002, 
   apcb135 LIKE apcb_t.apcb135, 
   apcb004 LIKE apcb_t.apcb004, 
   apcb012 LIKE apcb_t.apcb012, 
   apcb015 LIKE apcb_t.apcb015, 
   apcb016 LIKE apcb_t.apcb016, 
   apcb103 LIKE apcb_t.apcb103, 
   apca133 LIKE apca_t.apca133, 
   apca101 LIKE apca_t.apca101, 
   apca130 LIKE apca_t.apca130, 
   apca137 LIKE apca_t.apca137, 
   apcb005 LIKE apcb_t.apcb005, 
   apcb011 LIKE apcb_t.apcb011, 
   apcb101 LIKE apcb_t.apcb101, 
   apcb121 LIKE apcb_t.apcb121, 
   apcborga LIKE apcb_t.apcborga, 
   apca007 LIKE apca_t.apca007, 
   apca059 LIKE apca_t.apca059, 
   apca128 LIKE apca_t.apca128, 
   apca113 LIKE apca_t.apca113, 
   apca014 LIKE apca_t.apca014, 
   apca027 LIKE apca_t.apca027, 
   apca028 LIKE apca_t.apca028, 
   apca034 LIKE apca_t.apca034, 
   apcasite LIKE apca_t.apcasite, 
   apcb003 LIKE apcb_t.apcb003, 
   apcb105 LIKE apcb_t.apcb105, 
   apcb010 LIKE apcb_t.apcb010, 
   apcb100 LIKE apcb_t.apcb100, 
   apcblegl LIKE apcb_t.apcblegl, 
   apca016 LIKE apca_t.apca016, 
   apca018 LIKE apca_t.apca018, 
   apca025 LIKE apca_t.apca025, 
   apca035 LIKE apca_t.apca035, 
   apca036 LIKE apca_t.apca036, 
   apca042 LIKE apca_t.apca042, 
   apca120 LIKE apca_t.apca120, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apcb008 LIKE apcb_t.apcb008, 
   apcbseq LIKE apcb_t.apcbseq, 
   apca003 LIKE apca_t.apca003, 
   apca117 LIKE apca_t.apca117, 
   apca004 LIKE apca_t.apca004, 
   apca026 LIKE apca_t.apca026, 
   apca029 LIKE apca_t.apca029, 
   apca043 LIKE apca_t.apca043, 
   apca045 LIKE apca_t.apca045, 
   apca051 LIKE apca_t.apca051, 
   apca054 LIKE apca_t.apca054, 
   apca056 LIKE apca_t.apca056, 
   apcadocno LIKE apca_t.apcadocno, 
   apcb125 LIKE apcb_t.apcb125, 
   apcb024 LIKE apcb_t.apcb024, 
   apcb027 LIKE apcb_t.apcb027, 
   apcb131 LIKE apcb_t.apcb131, 
   apca050 LIKE apca_t.apca050, 
   apca001 LIKE apca_t.apca001, 
   apca030 LIKE apca_t.apca030, 
   apca052 LIKE apca_t.apca052, 
   apca055 LIKE apca_t.apca055, 
   apca127 LIKE apca_t.apca127, 
   apcb014 LIKE apcb_t.apcb014, 
   apcb017 LIKE apcb_t.apcb017, 
   l_apca015_ooefl003 LIKE type_t.chr80, 
   l_apca014_ooag011 LIKE type_t.chr80, 
   l_apca007_desc LIKE type_t.chr80, 
   l_apca003_ooag011 LIKE type_t.chr80, 
   apcaent LIKE apca_t.apcaent, 
   l_apca057_ooag011 LIKE type_t.chr80, 
   l_apcasite_ooefl003 LIKE type_t.chr80, 
   apcb102 LIKE apcb_t.apcb102
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"


#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aapr330_g01_curs INTO sr_s.*
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
       #160414-00018#14 ---s---
       ##帳務人員
       #LET sr_s.l_apca003_ooag011 = sr_s.apca003 CLIPPED,".",s_desc_get_person_desc(sr_s.apca003) CLIPPED
       ##帳款類別
       #LET sr_s.l_apca007_desc = s_desc_get_acc_desc('3211',sr_s.apca007) CLIPPED
       ##費用部門
       #LET sr_s.l_apca015_ooefl003 = sr_s.apca015 CLIPPED,".",s_desc_get_department_desc(sr_s.apca015) CLIPPED
       ##請款人員
       #LET sr_s.l_apca014_ooag011 = sr_s.apca003 CLIPPED,".",s_desc_get_person_desc(sr_s.apca003) CLIPPED
       ##受款對象
       #LET sr_s.l_apca057_ooag011 = sr_s.apca057 CLIPPED,".",s_desc_get_person_desc(sr_s.apca057) CLIPPED
       ##帳務中心
       #LET sr_s.l_apcasite_ooefl003 = sr_s.apcasite CLIPPED,".",s_desc_get_department_desc(sr_s.apcasite) CLIPPED     
       #160414-00018#14 ---e---
       IF cl_null(sr_s.apcb005) THEN
          LET sr_s.apcb005 = sr_s.apcb047
          LET sr_s.apcb047 = ''
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
      
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].apcb047 = sr_s.apcb047
       LET sr[l_cnt].apca123 = sr_s.apca123
       LET sr[l_cnt].apca041 = sr_s.apca041
       LET sr[l_cnt].apca131 = sr_s.apca131
       LET sr[l_cnt].apcb007 = sr_s.apcb007
       LET sr[l_cnt].apcb023 = sr_s.apcb023
       LET sr[l_cnt].apca008 = sr_s.apca008
       LET sr[l_cnt].apca118 = sr_s.apca118
       LET sr[l_cnt].apca009 = sr_s.apca009
       LET sr[l_cnt].apca010 = sr_s.apca010
       LET sr[l_cnt].apca015 = sr_s.apca015
       LET sr[l_cnt].apca017 = sr_s.apca017
       LET sr[l_cnt].apca019 = sr_s.apca019
       LET sr[l_cnt].apca053 = sr_s.apca053
       LET sr[l_cnt].apca063 = sr_s.apca063
       LET sr[l_cnt].apca121 = sr_s.apca121
       LET sr[l_cnt].apca138 = sr_s.apca138
       LET sr[l_cnt].apcald = sr_s.apcald
       LET sr[l_cnt].apcb115 = sr_s.apcb115
       LET sr[l_cnt].apcb009 = sr_s.apcb009
       LET sr[l_cnt].apcb021 = sr_s.apcb021
       LET sr[l_cnt].apcb028 = sr_s.apcb028
       LET sr[l_cnt].apca005 = sr_s.apca005
       LET sr[l_cnt].apca031 = sr_s.apca031
       LET sr[l_cnt].apca038 = sr_s.apca038
       LET sr[l_cnt].apca039 = sr_s.apca039
       LET sr[l_cnt].apca040 = sr_s.apca040
       LET sr[l_cnt].apca044 = sr_s.apca044
       LET sr[l_cnt].apca057 = sr_s.apca057
       LET sr[l_cnt].apcacomp = sr_s.apcacomp
       LET sr[l_cnt].apcastus = sr_s.apcastus
       LET sr[l_cnt].apcb002 = sr_s.apcb002
       LET sr[l_cnt].apcb135 = sr_s.apcb135
       LET sr[l_cnt].apcb004 = sr_s.apcb004
       LET sr[l_cnt].apcb012 = sr_s.apcb012
       LET sr[l_cnt].apcb015 = sr_s.apcb015
       LET sr[l_cnt].apcb016 = sr_s.apcb016
       LET sr[l_cnt].apcb103 = sr_s.apcb103
       LET sr[l_cnt].apca133 = sr_s.apca133
       LET sr[l_cnt].apca101 = sr_s.apca101
       LET sr[l_cnt].apca130 = sr_s.apca130
       LET sr[l_cnt].apca137 = sr_s.apca137
       LET sr[l_cnt].apcb005 = sr_s.apcb005
       LET sr[l_cnt].apcb011 = sr_s.apcb011
       LET sr[l_cnt].apcb101 = sr_s.apcb101
       LET sr[l_cnt].apcb121 = sr_s.apcb121
       LET sr[l_cnt].apcborga = sr_s.apcborga
       LET sr[l_cnt].apca007 = sr_s.apca007
       LET sr[l_cnt].apca059 = sr_s.apca059
       LET sr[l_cnt].apca128 = sr_s.apca128
       LET sr[l_cnt].apca113 = sr_s.apca113
       LET sr[l_cnt].apca014 = sr_s.apca014
       LET sr[l_cnt].apca027 = sr_s.apca027
       LET sr[l_cnt].apca028 = sr_s.apca028
       LET sr[l_cnt].apca034 = sr_s.apca034
       LET sr[l_cnt].apcasite = sr_s.apcasite
       LET sr[l_cnt].apcb003 = sr_s.apcb003
       LET sr[l_cnt].apcb105 = sr_s.apcb105
       LET sr[l_cnt].apcb010 = sr_s.apcb010
       LET sr[l_cnt].apcb100 = sr_s.apcb100
       LET sr[l_cnt].apcblegl = sr_s.apcblegl
       LET sr[l_cnt].apca016 = sr_s.apca016
       LET sr[l_cnt].apca018 = sr_s.apca018
       LET sr[l_cnt].apca025 = sr_s.apca025
       LET sr[l_cnt].apca035 = sr_s.apca035
       LET sr[l_cnt].apca036 = sr_s.apca036
       LET sr[l_cnt].apca042 = sr_s.apca042
       LET sr[l_cnt].apca120 = sr_s.apca120
       LET sr[l_cnt].apcadocdt = sr_s.apcadocdt
       LET sr[l_cnt].apcb008 = sr_s.apcb008
       LET sr[l_cnt].apcbseq = sr_s.apcbseq
       LET sr[l_cnt].apca003 = sr_s.apca003
       LET sr[l_cnt].apca117 = sr_s.apca117
       LET sr[l_cnt].apca004 = sr_s.apca004
       LET sr[l_cnt].apca026 = sr_s.apca026
       LET sr[l_cnt].apca029 = sr_s.apca029
       LET sr[l_cnt].apca043 = sr_s.apca043
       LET sr[l_cnt].apca045 = sr_s.apca045
       LET sr[l_cnt].apca051 = sr_s.apca051
       LET sr[l_cnt].apca054 = sr_s.apca054
       LET sr[l_cnt].apca056 = sr_s.apca056
       LET sr[l_cnt].apcadocno = sr_s.apcadocno
       LET sr[l_cnt].apcb125 = sr_s.apcb125
       LET sr[l_cnt].apcb024 = sr_s.apcb024
       LET sr[l_cnt].apcb027 = sr_s.apcb027
       LET sr[l_cnt].apcb131 = sr_s.apcb131
       LET sr[l_cnt].apca050 = sr_s.apca050
       LET sr[l_cnt].apca001 = sr_s.apca001
       LET sr[l_cnt].apca030 = sr_s.apca030
       LET sr[l_cnt].apca052 = sr_s.apca052
       LET sr[l_cnt].apca055 = sr_s.apca055
       LET sr[l_cnt].apca127 = sr_s.apca127
       LET sr[l_cnt].apcb014 = sr_s.apcb014
       LET sr[l_cnt].apcb017 = sr_s.apcb017
       LET sr[l_cnt].l_apca015_ooefl003 = sr_s.l_apca015_ooefl003
       LET sr[l_cnt].l_apca014_ooag011 = sr_s.l_apca014_ooag011
       LET sr[l_cnt].l_apca007_desc = sr_s.l_apca007_desc
       LET sr[l_cnt].l_apca003_ooag011 = sr_s.l_apca003_ooag011
       LET sr[l_cnt].apcaent = sr_s.apcaent
       LET sr[l_cnt].l_apca057_ooag011 = sr_s.l_apca057_ooag011
       LET sr[l_cnt].l_apcasite_ooefl003 = sr_s.l_apcasite_ooefl003
       LET sr[l_cnt].apcb102 = sr_s.apcb102
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"


       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr330_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapr330_g01_rep_data()
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
          START REPORT aapr330_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aapr330_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aapr330_g01_rep
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
 
{<section id="aapr330_g01.rep" readonly="Y" >}
PRIVATE REPORT aapr330_g01_rep(sr1)
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
DEFINE l_sql     STRING
DEFINE sr5       sr5_r 
DEFINE sr6       sr6_r #預支沖銷
DEFINE sr7       sr7_r #繳回款項
DEFINE sr8       sr8_r
DEFINE sr9       sr9_r
DEFINE sr10      sr10_r
DEFINE sr11      sr11_r
DEFINE sr12      sr12_r
DEFINE i         INTEGER
DEFINE l_count          LIKE type_t.num5
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_subrep06_show  LIKE type_t.chr1
DEFINE l_subrep07_show  LIKE type_t.chr1
DEFINE l_subrep08_show  LIKE type_t.chr1
DEFINE l_subrep09_show  LIKE type_t.chr1
DEFINE l_subrep10_show  LIKE type_t.chr1
DEFINE l_subrep11_show  LIKE type_t.chr1
DEFINE l_apcb047_show   LIKE type_t.chr1
DEFINE l_line01 LIKE type_t.num5
DEFINE l_oobxl003       LIKE oobxl_t.oobxl003  #161104-00049#4 add
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.apcadocno,sr1.apcbseq
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
        BEFORE GROUP OF sr1.apcadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            CALL s_desc_gzcbl004_desc(8502,sr1.apca001) RETURNING g_grPageHeader.title0201
            CALL s_aooi200_fin_get_slip_desc(sr1.apcadocno) RETURNING l_oobxl003 #161104-00049#4 add
            LET g_grPageHeader.title0201 = l_oobxl003                            #161104-00049#4 add
            #end add-point:rep.header 
            LET g_rep_docno = sr1.apcadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'apcaent=' ,sr1.apcaent,'{+}apcald=' ,sr1.apcald,'{+}apcadocno=' ,sr1.apcadocno         
            CALL cl_gr_init_apr(sr1.apcadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
           
                                  
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.apcadocno.before name="rep.b_group.apcadocno.before"
           LET l_line01 = 0
           PRINTX l_line01
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apcadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
 

           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr330_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aapr330_g01_subrep01
           DECLARE aapr330_g01_repcur01 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr330_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aapr330_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.apcadocno.after name="rep.b_group.apcadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.apcbseq
 
           #add-point:rep.b_group.apcbseq.before name="rep.b_group.apcbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.apcbseq.after name="rep.b_group.apcbseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          LET l_apcb047_show = 'Y'
          IF cl_null(sr1.apcb047) THEN
             LET l_apcb047_show ='N'
          END IF
          PRINTX l_apcb047_show
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apcadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apcbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr330_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aapr330_g01_subrep02
           DECLARE aapr330_g01_repcur02 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr330_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aapr330_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep02
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
                sr1.apcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apcadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apcbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr330_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aapr330_g01_subrep03
           DECLARE aapr330_g01_repcur03 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr330_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aapr330_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apcadocno
 
           #add-point:rep.a_group.apcadocno.before name="rep.a_group.apcadocno.before"
           #合計金額
           LET l_subrep09_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0                   
           LET g_sql = "SELECT apcb100,sum(apcb105),'','' ",
                        "  FROM apcb_t ",
                        " WHERE apcbdocno = '",sr1.apcadocno CLIPPED,"'",
                        "   AND apcbld    = '",sr1.apcald    CLIPPED,"'",
                        "   AND apcbent   = '",sr1.apcaent   CLIPPED,"'",
                        " GROUP BY apcb100"
                        
           LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"    
           PREPARE aapr330_g01_subrep09_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_subrep09_cnt_pre INTO l_count
           FREE aapr330_g01_subrep09_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep09_show = 'Y'
           END IF              
           LET l_count = 0
           START REPORT aapr330_g01_subrep09
           DECLARE aapr330_g01_repcur09 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur09 INTO sr9.* 
              IF l_count = 0 THEN
                 LET sr9.apcb100_show = 'Y'
              ELSE
                 LET sr9.apcb100_show = 'N'
              END IF                                
              LET l_count = 1
           
               OUTPUT TO REPORT aapr330_g01_subrep09(sr9.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep09           
           PRINTX l_subrep09_show
           
           #本位幣合計
           LET l_subrep10_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0               
           #160414-00018#14 ---s---
           LET g_sql = "   SELECT SUM(apcb115), ''                                                  ", 
                       "      FROM apcb_t                                                           ",
                       "     WHERE apcbent   = ",g_enterprise," AND apcbld =  '",sr1.apcald,"'      ",
                       "       AND apcbdocno = '",sr1.apcadocno,"'                                  "
           #160414-00018#14 ---e---                                        
           LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"    
           PREPARE aapr330_g01_subrep10_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_subrep10_cnt_pre INTO l_count
           FREE aapr330_g01_subrep10_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep10_show = 'Y'
           END IF              
           START REPORT aapr330_g01_subrep10
           DECLARE aapr330_g01_repcur10 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur10 INTO sr10.*  
              SELECT glaa001      INTO sr10.glaa001
                FROM glaa_t
               WHERE glaaent = g_enterprise AND glaald = sr1.apcald                      
              OUTPUT TO REPORT aapr330_g01_subrep10(sr10.*)   
           END FOREACH
           FINISH REPORT aapr330_g01_subrep10           
           PRINTX l_subrep10_show             
                             
           #借支沖銷
           LET l_subrep06_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0
           LET g_sql = "SELECT apcedocno,apce003,apce100,apce109, ",
                       "       apce101,apce119  ",
                       "  FROM apce_t ",
                       " WHERE apcedocno = '",sr1.apcadocno CLIPPED,"'",
                       "   AND apceld    = '",sr1.apcald    CLIPPED,"'",
                       "   AND apceent   = '",sr1.apcaent   CLIPPED,"'",
                       "   AND apce002   IN ('30','41')",
                       " ORDER BY apce003 "
                       
           LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"    
           PREPARE aapr330_g01_subrep06_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_subrep06_cnt_pre INTO l_count
           FREE aapr330_g01_subrep06_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep06_show = 'Y'
           END IF           
           
           START REPORT aapr330_g01_subrep06
           DECLARE aapr330_g01_repcur06 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur06 INTO sr6.*
               OUTPUT TO REPORT aapr330_g01_subrep06(sr6.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep06
           PRINTX l_subrep06_show
           
           #繳回款項
           LET l_subrep07_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0
           LET g_sql = "SELECT apcedocno,apce010,apce008, ",
                       "       apce100,apce109,apce101,apce119 ",
                       "  FROM apce_t ",
                       " WHERE apcedocno = '",sr1.apcadocno CLIPPED,"'",
                       "   AND apceld    = '",sr1.apcald    CLIPPED,"'",
                       "   AND apceent   = '",sr1.apcaent   CLIPPED,"'",
                       "   AND apce002   ='17' ",
                       " ORDER BY apce008"
                       
           LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"    
           PREPARE aapr330_g01_subrep07_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_subrep07_cnt_pre INTO l_count
           FREE aapr330_g01_subrep07_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep07_show = 'Y'
           END IF           
           
           START REPORT aapr330_g01_subrep07
           DECLARE aapr330_g01_repcur07 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur07 INTO sr7.*
               OUTPUT TO REPORT aapr330_g01_subrep07(sr7.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep07          
           PRINTX l_subrep07_show
           
           #發票/收據
           LET l_subrep08_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0
           #160414-00018#14 ---s---
           #LET g_sql = "SELECT isam008,'',",
           #            "       isam009,isam010,isam011,isam014,isam023,isam024,isam025 ",
           #            "  FROM isam_t ",
           #            " WHERE isam050   = '",sr1.apcadocno CLIPPED,"'",
           #            "   AND isament   = '",sr1.apcaent   CLIPPED,"'",
           #            " ORDER BY isamseq"
           LET g_sql = "SELECT isam008, ",
                       #發票類型
                       "(CASE WHEN (SELECT isacl004 FROM isacl_t,glaa_t,ooef_t WHERE glaald = '",sr1.apcald,"' AND glaaent = '",g_enterprise,"' ", 
                       "             AND ooefent = glaaent AND ooef001 = glaacomp AND isacl001 = ooef019 AND isaclent = ooefent                 ",
                       "             AND isacl002 = isam008 AND isacl003 = '",g_dlang,"') IS NULL THEN isam008 ELSE  ",
                       "           (SELECT isam008||'.'||isacl004 FROM isacl_t,glaa_t,ooef_t WHERE glaald = '",sr1.apcald,"' AND glaaent = '",g_enterprise,"' ", 
                       "             AND ooefent = glaaent AND ooef001 = glaacomp AND isacl001 = ooef019 AND isaclent = ooefent                ",
                       "             AND isacl002 = isam008 AND isacl003 = '",g_dlang,"') END ),                                               ",                                                                    
                       "       isam009,isam010,isam011,isam014,isam023,isam024,isam025 ",
                       "  FROM isam_t ",
                       " WHERE isam050   = '",sr1.apcadocno,"' AND isament   = '",sr1.apcaent,"' ",
                       " ORDER BY isamseq "
           LET l_sub_sql = "  SELECT COUNT(*) FROM ",
                           " (SELECT isam050 FROM isam_t WHERE isam050 = '",sr1.apcadocno,"' AND isament = '",sr1.apcaent,"' ) "
           #LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"    
           #160414-00018#14---e---                       
           PREPARE aapr330_g01_subrep08_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_subrep08_cnt_pre INTO l_count
           FREE aapr330_g01_subrep08_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep08_show = 'Y'
           END IF                               
           START REPORT aapr330_g01_subrep08
           DECLARE aapr330_g01_repcur08 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur08 INTO sr8.*
               #160414-00018#14---s---
               #發票類型 
               #IF NOT cl_null(sr8.isam008) THEN
               #   CALL s_desc_get_invoice_type_desc(sr1.apcald,sr8.isam008)RETURNING sr8.isam008_desc
               #   IF NOT cl_null(sr8.isam008_desc) THEN
               #      LET sr8.isam008_desc = sr8.isam008,".",sr8.isam008_desc
               #   ELSE 
               #      LET sr8.isam008_desc = sr8.isam008
               #   END IF
               #END IF
               #160414-00018#14---e---
               OUTPUT TO REPORT aapr330_g01_subrep08(sr8.*,sr1.apcadocno,sr1.apcaent,sr1.apcald)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep08              
           PRINTX l_subrep08_show        
            
           #直接付款
           LET l_subrep11_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0      
          #160414-00018#14---s---           
          #LET g_sql = "SELECT apdedocno,apde008,'',apde006,'', ",
          #            "       apde100,apde109         ",
          #            "  FROM apde_t ",
          #            " WHERE apdedocno = '",sr1.apcadocno CLIPPED,"'",
          #            "   AND apdeld    = '",sr1.apcald    CLIPPED,"'",
          #            "   AND apdeent    = '",sr1.apcaent   CLIPPED,"'"
          #            #160122-00001#16--add---str
#         #             ,"   AND (apde008 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#         #             "    AND nmll002 = '",g_user,"') OR apde008 IS NULL)"
          #            ,"   AND (apde008 IN (",g_sql_bank,") OR TRIM(apde008) IS NULL)" #160122-00001#5 mod by 07675
          #            #160122-00001#16--add---end
          #            
          LET g_sql = "SELECT apdedocno, ",
                       "      apde008,(CASE WHEN (SELECT nmaal003 FROM nmaal_t,nmas_t WHERE nmaalent = nmasent AND nmaalent = '",g_enterprise,"'               ",
                       "                             AND nmas001 = nmaal001 AND nmas002 = apde008 AND nmaal002 ='",g_dlang,"' )IS NULL THEN apde008 ELSE       ",
                       "                         (SELECT apde008||'.'||nmaal003 FROM nmaal_t,nmas_t WHERE nmaalent = nmasent AND nmaalent = '",g_enterprise,"' ",
                       "                             AND nmas001 = nmaal001 AND nmas002 = apde008 AND nmaal002 ='",g_dlang,"' ) END), ",                       
                       "      apde006,(CASE WHEN (SELECT gzcbl004  FROM gzcb_t,gzcbl_t WHERE gzcb001 = '8310' AND gzcb002 = apde006   ",
                       "                             AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"')IS NULL THEN apde006 ELSE ",
                       "                         (SELECT apde006||'.'||gzcbl004  FROM gzcb_t,gzcbl_t WHERE gzcb001 = '8310' AND gzcb002 = apde006          ",
                       "                             AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"') END) , ",                                                                                            
                       "       apde100,apde109         ",
                       "  FROM apde_t ",
                       " WHERE apdedocno = '",sr1.apcadocno,"' AND apdeld    = '",sr1.apcald,"' AND apdeent    = '",sr1.apcaent,"' ",
                       "   AND (apde008 IN (",g_sql_bank,") OR TRIM(apde008) IS NULL)" 
           LET l_sub_sql = " SELECT COUNT(*) FROM  ",
                           "(SELECT apdedocno,apdeld,apde008 FROM apde_t ",
                           " WHERE apdedocno = '",sr1.apcadocno,"' AND apdeld    = '",sr1.apcald,"' AND apdeent    = '",sr1.apcaent,"' ",
                           "   AND (apde008 IN (",g_sql_bank,") OR TRIM(apde008) IS NULL) ) " 
                           
           #LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"  
           #160414-00018#14---e---        
           PREPARE aapr330_g01_subrep11_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_subrep11_cnt_pre INTO l_count
           FREE aapr330_g01_subrep11_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep11_show = 'Y'
           END IF           
           
           START REPORT aapr330_g01_subrep11
           DECLARE aapr330_g01_repcur11 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur11 INTO sr11.*
              #160414-00018#14---s---
              # #支付帳戶
              # IF NOT cl_null(s_desc_get_nmas002_desc(sr11.apde008)) THEN
              #    LET sr11.apde008_desc = sr11.apde008 CLIPPED,".",s_desc_get_nmas002_desc(sr11.apde008) CLIPPED
              # ELSE
              #    LET sr11.apde008_desc = sr11.apde008
              # END IF 
              ##沖銷類別
              #IF NOT cl_null(s_desc_gzcbl004_desc('8310',sr11.apde006)) THEN
              #   LET sr11.apde006_desc = sr11.apde006 CLIPPED,".",s_desc_gzcbl004_desc('8310',sr11.apde006) CLIPPED
              #ELSE
              #   LET sr11.apde006_desc = sr11.apde006
              #END IF              
               #160414-00018#14---e---
              OUTPUT TO REPORT aapr330_g01_subrep11(sr11.*,sr1.apcald)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep11
           PRINTX l_subrep11_show
           
           #應付款
           LET l_subrep05_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0
           #160414-00018#14---s--- 
           #LET g_sql = "SELECT apcc004,apcc002,'',apcc100,(apcc108-apcc109), ", #150908-00011#1
           #            "       apcc101,(apcc118-apcc119) ",                     #150908-00011#1
           #            "  FROM apcc_t ",
           #            " WHERE apccdocno = '",sr1.apcadocno CLIPPED,"'",
           #            "   AND apccld    = '",sr1.apcald    CLIPPED,"'",
           #            "   AND apccent   = '",sr1.apcaent   CLIPPED,"'",
           #            "   AND apccseq = 1 "                        
           LET g_sql = "SELECT apcc004, ",
                       "       apcc002,(SELECT apcc002||'.'||gzcbl004 FROM gzcb_t,gzcbl_t WHERE gzcb001 = '8310'  ",
                      "                    AND gzcb002 = apcc002 AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"' ), ",
                       "       apcc100,(apcc108-apcc109), ",
                       "       apcc101,(apcc118-apcc119) ",                    
                       "  FROM apcc_t ",
                       " WHERE apccdocno = '",sr1.apcadocno CLIPPED,"'",
                       "   AND apccld    = '",sr1.apcald    CLIPPED,"'",
                       "   AND apccent   = '",sr1.apcaent   CLIPPED,"'",
                       "   AND apccseq = 1 "                        
           LET l_sub_sql = " SELECT COUNT(*) FROM  ",
                           "(SELECT apccdocno,apccld,apccseq FROM apcc_t ",
                           "  WHERE apccdocno = '",sr1.apcadocno CLIPPED,"'",
                           "    AND apccld    = '",sr1.apcald    CLIPPED,"'",
                           "    AND apccent   = '",sr1.apcaent   CLIPPED,"'",
                           "    AND apccseq = 1 ) "                        
           #LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"  
           #160414-00018#14---e--- 
           PREPARE aapr330_g01_subrep05_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_subrep05_cnt_pre INTO l_count
           FREE aapr330_g01_subrep05_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep05_show = 'Y'
           END IF           
           
           START REPORT aapr330_g01_subrep05
           DECLARE aapr330_g01_repcur05 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur05 INTO sr5.*
              #IF NOT cl_null(s_desc_gzcbl004_desc('8310',sr5.apcc002)) THEN
              #   LET sr5.apcc002_desc = sr5.apcc002 CLIPPED,".",s_desc_gzcbl004_desc('8310',sr5.apcc002) CLIPPED
              #ELSE
              #   LET sr5.apcc002_desc = sr5.apcc002
              #END IF              
            
              OUTPUT TO REPORT aapr330_g01_subrep05(sr5.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep05
           PRINTX l_subrep05_show
                      

           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.apcadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr330_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aapr330_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aapr330_g01_subrep04
           DECLARE aapr330_g01_repcur04 CURSOR FROM g_sql
           FOREACH aapr330_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr330_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aapr330_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aapr330_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.apcadocno.after name="rep.a_group.apcadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apcbseq
 
           #add-point:rep.a_group.apcbseq.before name="rep.a_group.apcbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.apcbseq.after name="rep.a_group.apcbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
 
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aapr330_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr330_g01_subrep01(sr2)
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
PRIVATE REPORT aapr330_g01_subrep02(sr2)
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
PRIVATE REPORT aapr330_g01_subrep03(sr2)
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
PRIVATE REPORT aapr330_g01_subrep04(sr2)
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
 
{<section id="aapr330_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aapr330_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 本位幣合計子報表
# Memo...........:
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
REPORT aapr330_g01_subrep10(sr10)
DEFINE sr10  sr10_r   
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX PRINTX sr10.*
END REPORT

################################################################################
# Descriptions...: 發票金額合計
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
REPORT aapr330_g01_subrep12(sr12)
DEFINE sr12  sr12_r    
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr12.*
END REPORT

PRIVATE REPORT aapr330_g01_subrep08(sr8,p_docno,p_ent,p_ld)
DEFINE sr8         sr8_r
DEFINE p_docno     LIKE apca_t.apcadocno
DEFINE p_ent       LIKE apca_t.apcaent
DEFINE p_ld        LIKE apca_t.apcald
DEFINE l_isam026   LIKE isam_t.isam028
DEFINE l_isam027   LIKE isam_t.isam028
DEFINE l_isam028   LIKE isam_t.isam028
DEFINE l_glaa001   LIKE glaa_t.glaa001 
 
    FORMAT
     
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr8.*
            
        ON LAST ROW
        
           SELECT glaa001  INTO l_glaa001
             FROM glaa_t
            WHERE glaaent = g_enterprise AND glaald = p_ld
            
           SELECT SUM(isam026),SUM(isam027),SUM(isam028) 
             INTO l_isam026,l_isam027,l_isam028
             FROM isam_t
            WHERE isam050   = p_docno 
              AND isament   = p_ent
           
           PRINTX l_isam026,l_isam027,l_isam028,l_glaa001
END REPORT

PRIVATE REPORT aapr330_g01_subrep05(sr5)
DEFINE sr5 sr5_r
    FORMAT
               
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

PRIVATE REPORT aapr330_g01_subrep06(sr6)
DEFINE sr6  sr6_r
DEFINE l_apce119_sum LIKE apce_t.apce119
    
    ORDER EXTERNAL BY sr6.apcedocno
    FORMAT
        
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
            
        AFTER GROUP OF sr6.apcedocno                   
           LET l_apce119_sum = GROUP SUM(sr6.apce119)
           PRINTX l_apce119_sum
           
END REPORT

PRIVATE REPORT aapr330_g01_subrep09(sr9)
DEFINE sr9  sr9_r
DEFINE l_glaa001      LIKE glaa_t.glaa001
DEFINE l_apcb115_sum  LIKE apcb_t.apcb115

    ORDER EXTERNAL BY sr9.apcb100
    FORMAT
          
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr9.*          

END REPORT

################################################################################
# Descriptions...: 直接付款
# Memo...........:
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
REPORT aapr330_g01_subrep11(sr11,p_ld)
DEFINE sr11  sr11_r
DEFINE l_apde119_sum LIKE apde_t.apde109
DEFINE l_glaa001     LIKE glaa_t.glaa001
DEFINE p_ld          LIKE apde_t.apdeld
    

    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr11.*
            
        ON LAST ROW         
        SELECT glaa001  INTO l_glaa001
         FROM glaa_t
        WHERE glaaent = g_enterprise AND glaald = p_ld
        
        SELECT sum(apde119) INTO l_apde119_sum 
          FROM apde_t
         WHERE apdedocno = sr11.apdedocno
           AND apdeld = p_ld
           AND apdeent = g_enterprise
        PRINTX l_glaa001
        PRINTX l_apde119_sum

END REPORT

PRIVATE REPORT aapr330_g01_subrep07(sr7)
DEFINE sr7 sr7_r
DEFINE l_apce119_sum   LIKE type_t.num10
   
    ORDER EXTERNAL BY sr7.apcedocno

    FORMAT
           
         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr7.*
            
        AFTER GROUP OF sr7.apcedocno
           
           LET l_apce119_sum = GROUP SUM(sr7.apce119)
           PRINTX l_apce119_sum
            
END REPORT

 
{</section>}
 
