#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr005_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2017-01-25 14:53:33), PR版次:0008(2017-01-25 14:55:14)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000117
#+ Filename...: apmr005_x01
#+ Description: ...
#+ Creator....: 05384(2014-07-17 13:34:50)
#+ Modifier...: 06021 -SD/PR- 06021
 
{</section>}
 
{<section id="apmr005_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#161207-00033#23  2016/12/21  By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
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
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr500          #印未完全請款
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr005_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr005_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr500         #tm.a1  印未完全請款
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr005_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr005_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr005_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr005_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr005_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr005_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr005_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr005_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmds007.pmds_t.pmds007,pmaal_t_pmaal004.pmaal_t.pmaal004,pmds008.pmds_t.pmds008,t2_pmaal004.pmaal_t.pmaal004,pmds009.pmds_t.pmds009,t1_pmaal004.pmaal_t.pmaal004,l_pmds031_desc.type_t.chr500,l_pmds033_desc.type_t.chr1000,pmds037.pmds_t.pmds037,pmdsdocno.pmds_t.pmdsdocno,pmdtseq.pmdt_t.pmdtseq,pmdsdocdt.pmds_t.pmdsdocdt,pmds002.pmds_t.pmds002,ooag_t_ooag011.ooag_t.ooag011,pmds003.pmds_t.pmds003,ooefl_t_ooefl003.ooefl_t.ooefl003,pmdt001.pmdt_t.pmdt001,pmdt002.pmdt_t.pmdt002,pmdt003.pmdt_t.pmdt003,pmdt006.pmdt_t.pmdt006,x_t3_imaal003.imaal_t.imaal003,x_t3_imaal004.imaal_t.imaal004,pmdt007.pmdt_t.pmdt007,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,pmdt020.pmdt_t.pmdt020,pmdt019.pmdt_t.pmdt019,pmdt036.pmdt_t.pmdt036,pmdt047.pmdt_t.pmdt047,pmdt038.pmdt_t.pmdt038,pmdt039.pmdt_t.pmdt039,pmdt050.pmdt_t.pmdt050,pmdt056.pmdt_t.pmdt056,l_pmdt020_pmdt056.type_t.num20_6,pmdt059.pmdt_t.pmdt059" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr005_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr005_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apmr005_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr005_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_ooef025     LIKE ooef_t.ooef025
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #151106-00004#2 20151124 add by beckxie ---S
   #品管參照表編號
   LET l_ooef025 = ''
   SELECT ooef025 INTO l_ooef025 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #151106-00004#2 20151124 add by beckxie ---E
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #151106-00004#2 20151109 add by beckxie ---S
   LET g_select = " SELECT trim(pmds007)||'.'||trim(A2.pmaal004),pmds007,A2.pmaal004, ",
                  "        trim(pmds008)||'.'||trim(A9.pmaal004),pmds008,A9.pmaal004, ",
                  "        trim(pmds009)||'.'||trim(A8.pmaal004),pmds009,A8.pmaal004,A7.ooibl004,'', ",
                  "        pmds033,A12.oodbl004,pmds037,pmdsdocno,pmdtseq,pmdsdocdt, ", #151124-00016#1-add-'pmdtseq'
                  "        trim(pmds002)||'.'||trim(A10.ooag011),pmds002,A10.ooag011, ",
                  "        trim(pmds003)||'.'||trim(A1.ooefl003),pmds003,A1.ooefl003,",
                  "        pmdt001,pmdt002,pmdt003, ",
                  "        pmdt006,x.B4_imaal003,x.B4_imaal004,pmdt007,x.B1_imaa127, ",
                  "        x.B2_oocql004,trim(B1_imaa127)||'.'||trim(B2_oocql004),pmdt020,pmdt019,pmdt036, ",
                  "        pmdt047,pmdt038,pmdt039,pmdt050,pmdt056,'', ",
                  "        pmdt059,pmds000,pmds031, ",
                  "        A10.ooag011,A1.ooefl003, ",
                  "        A8.pmaal004,A9.pmaal004,A2.pmaal004,A6.oocql004,A5.ooail003, ",
                  "        A4.pmaml003,A3.ooidl003,x.imaal_t_imaal003,x.oocal_t_oocal003,x.B6_oocal003,x.B7_oocal003, ",
                  "        x.qcaol_t_qcaol004  "
   #151106-00004#2 20151109 add by beckxie ---E
#   #end add-point
#   LET g_select = " SELECT trim(pmds007)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),pmds007,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),trim(pmds008)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds008 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),pmds008,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds008 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),trim(pmds009)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds009 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),pmds009,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = pmds_t.pmds009 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),'',pmds033,'',pmds037,pmdsdocno,pmdtseq,pmdsdocdt,trim(pmds002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent)), 
#       pmds002,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent), 
#       trim(pmds003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),pmds003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),pmdt001,pmdt002,pmdt003,pmdt006,x.t3_imaal003,x.t3_imaal004,pmdt007,'','','', 
#       pmdt020,pmdt019,pmdt036,pmdt047,pmdt038,pmdt039,pmdt050,pmdt056,'',pmdt059,pmds000,pmds031,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = pmds_t.pmds037 AND ooail_t.ooailent = pmds_t.pmdsent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),( SELECT pmaml003 FROM pmaml_t WHERE pmaml_t.pmaml001 = pmds_t.pmds039 AND pmaml_t.pmamlent = pmds_t.pmdsent AND pmaml_t.pmaml002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooidl003 FROM ooidl_t WHERE ooidl_t.ooidl001 = pmds_t.pmds040 AND ooidl_t.ooidlent = pmds_t.pmdsent AND ooidl_t.ooidl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.oocal_t_oocal003,x.t4_oocal003,x.t5_oocal003,x.qcaol_t_qcaol004" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151106-00004#2 20151109 mark by beckxie ---S
   #LET g_from = " FROM pmds_t LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = pmds_t.pmds003 AND ooefl_t.ooeflent = pmds_t.pmdsent AND ooefl_t.ooefl002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = pmds_t.pmds007 AND pmaal_t.pmaalent = pmds_t.pmdsent AND pmaal_t.pmaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN ooidl_t ON ooidl_t.ooidl001 = pmds_t.pmds040 AND ooidl_t.ooidlent = pmds_t.pmdsent AND ooidl_t.ooidl002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaml_t ON pmaml_t.pmaml001 = pmds_t.pmds039 AND pmaml_t.pmamlent = pmds_t.pmdsent AND pmaml_t.pmaml002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = pmds_t.pmds037 AND ooail_t.ooailent = pmds_t.pmdsent AND ooail_t.ooail002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = pmds_t.pmds032 AND oocql_t.oocqlent = pmds_t.pmdsent AND oocql_t.oocql003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = pmds_t.pmds031 AND ooibl_t.ooiblent = pmds_t.pmdsent AND ooibl_t.ooibl003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t1 ON t1.pmaal001 = pmds_t.pmds009 AND t1.pmaalent = pmds_t.pmdsent AND t1.pmaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = pmds_t.pmds008 AND t2.pmaalent = pmds_t.pmdsent AND t2.pmaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = pmds_t.pmds002 AND ooag_t.ooagent = pmds_t.pmdsent LEFT OUTER JOIN ( SELECT pmdt_t.*,imaa_t.*, 
   #     t3.imaal003 t3_imaal003,t3.imaal004 t3_imaal004,imaal_t.imaal003 imaal_t_imaal003,oocal_t.oocal003 oocal_t_oocal003, 
   #     t4.oocal003 t4_oocal003,t5.oocal003 t5_oocal003,qcaol_t.qcaol004 qcaol_t_qcaol004 FROM pmdt_t LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = pmdt_t.pmdtent AND imaa_t.imaa001 = pmdt_t.pmdt006 LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t t3 ON t3.imaal001 = pmdt_t.pmdt006 AND t3.imaalent = pmdt_t.pmdtent AND t3.imaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = pmdt_t.pmdt023 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t4 ON t4.oocal001 = pmdt_t.pmdt021 AND t4.oocalent = pmdt_t.pmdtent AND t4.oocal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t5 ON t5.oocal001 = pmdt_t.pmdt019 AND t5.oocalent = pmdt_t.pmdtent AND t5.oocal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN qcaol_t ON qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol003 = '" , 
   #     g_dlang,"'" ," ) x  ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno"
   #151106-00004#2 20151109 mark by beckxie ---S
   #151106-00004#2 20151109 add by beckxie ---S
   LET g_from = " FROM pmds_t ",
                " LEFT OUTER JOIN ooefl_t A1 ON A1.ooeflent = pmds_t.pmdsent AND A1.ooefl001 = pmds_t.pmds003 AND A1.ooefl002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t A2 ON A2.pmaalent = pmds_t.pmdsent AND A2.pmaal001 = pmds_t.pmds007 AND A2.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN ooidl_t A3 ON A3.ooidlent = pmds_t.pmdsent AND A3.ooidl001 = pmds_t.pmds040 AND A3.ooidl002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaml_t A4 ON A4.pmamlent = pmds_t.pmdsent AND A4.pmaml001 = pmds_t.pmds039 AND A4.pmaml002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN ooail_t A5 ON A5.ooailent = pmds_t.pmdsent AND A5.ooail001 = pmds_t.pmds037 AND A5.ooail002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN oocql_t A6 ON A6.oocqlent = pmds_t.pmdsent AND A6.oocql001 = '238' AND A6.oocql002 = pmds_t.pmds032 AND A6.oocql003 = '",g_dlang,"' ",
                " LEFT OUTER JOIN ooibl_t A7 ON A7.ooiblent = pmds_t.pmdsent AND A7.ooibl002 = pmds_t.pmds031 AND A7.ooibl003 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t A8 ON A8.pmaalent = pmds_t.pmdsent AND A8.pmaal001 = pmds_t.pmds009 AND A8.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t A9 ON A9.pmaalent = pmds_t.pmdsent AND A9.pmaal001 = pmds_t.pmds008 AND A9.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN ooag_t A10 ON A10.ooagent = pmds_t.pmdsent AND A10.ooag001 = pmds_t.pmds002 ",
                " LEFT OUTER JOIN ooef_t A11 ON  A11.ooefent = pmds_t.pmdsent AND A11.ooef001 ='",g_site,"' ",
                " LEFT OUTER JOIN oodbl_t A12 ON A12.oodblent = pmds_t.pmdsent AND A12.oodbl001 = A11.ooef019 AND A12.oodbl002 = pmds033 AND A12.oodbl003 =  '",g_dlang,"' ",
                " LEFT OUTER JOIN ( SELECT pmdt_t.*,B1.imaa127 B1_imaa127,B4.imaal003 B4_imaal003,B4.imaal004 B4_imaal004,B3.imaal003 imaal_t_imaal003, ",
                "                          B5.oocal003 oocal_t_oocal003,B6.oocal003 B6_oocal003,B7.oocal003 B7_oocal003,B8.qcaol004 qcaol_t_qcaol004 ,B2.oocql004 B2_oocql004 ",
                "                     FROM pmdt_t  ",
                "                     LEFT OUTER JOIN imaa_t B1 ON B1.imaaent = pmdt_t.pmdtent AND B1.imaa001 = pmdt_t.pmdt006  ",
                "                     LEFT OUTER JOIN oocql_t B2 ON B2.oocqlent = pmdt_t.pmdtent AND B2.oocql001 = '2003' AND B2.oocql002 = B1.imaa127 AND B2.oocql003 = '",g_dlang,"' ",
                "                     LEFT OUTER JOIN imaal_t B3 ON B3.imaalent = pmdt_t.pmdtent AND B3.imaal001 = pmdt_t.pmdt008 AND B3.imaal002 = '",g_dlang,"' ",             
                "                     LEFT OUTER JOIN imaal_t B4 ON B4.imaalent = pmdt_t.pmdtent AND B4.imaal001 = pmdt_t.pmdt006 AND B4.imaal002 = '",g_dlang,"' ",             
                "                     LEFT OUTER JOIN oocal_t B5 ON B5.oocalent = pmdt_t.pmdtent AND B5.oocal001 = pmdt_t.pmdt023 AND B5.oocal002 = '",g_dlang,"' ",             
                "                     LEFT OUTER JOIN oocal_t B6 ON B6.oocalent = pmdt_t.pmdtent AND B6.oocal001 = pmdt_t.pmdt021 AND B6.oocal002 = '",g_dlang,"' ",             
                "                     LEFT OUTER JOIN oocal_t B7 ON B7.oocalent = pmdt_t.pmdtent AND B7.oocal001 = pmdt_t.pmdt019 AND B7.oocal002 = '",g_dlang,"' ",             
                "                     LEFT OUTER JOIN qcaol_t B8 ON B8.qcaolent = pmdt_t.pmdtent AND B8.qcaol001 ='",l_ooef025,"' AND B8.qcaol002 = pmdt_t.pmdt083 AND B8.qcaol003 = '",g_dlang,"' ) x ",  
                "                     ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno = x.pmdtdocno  "
   #151106-00004#2 20151109 add by beckxie ---E
#   #end add-point
#    LET g_from = " FROM pmds_t LEFT OUTER JOIN ( SELECT pmdt_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt006 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t3_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt006 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") t3_imaal004,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = pmdt_t.pmdt008 AND imaal_t.imaalent = pmdt_t.pmdtent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdt_t.pmdt023 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdt_t.pmdt021 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t4_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = pmdt_t.pmdt019 AND oocal_t.oocalent = pmdt_t.pmdtent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") t5_oocal003,( SELECT qcaol004 FROM qcaol_t WHERE qcaol_t.qcaol002 = pmdt_t.pmdt083 AND qcaol_t.qcaolent = pmdt_t.pmdtent AND qcaol_t.qcaol003 = '" , 
#        g_dlang,"'" ,") qcaol_t_qcaol004 FROM pmdt_t ) x  ON pmds_t.pmdsent = x.pmdtent AND pmds_t.pmdsdocno  
#        = x.pmdtdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmds_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE apmr005_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr005_x01_curs CURSOR FOR apmr005_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr005_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr005_x01_ins_data()
DEFINE sr RECORD 
   l_pmds007_pmaal004 LIKE type_t.chr100, 
   pmds007 LIKE pmds_t.pmds007, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   l_pmds008_pmaal004 LIKE type_t.chr100, 
   pmds008 LIKE pmds_t.pmds008, 
   t2_pmaal004 LIKE pmaal_t.pmaal004, 
   l_pmds009_pmaal004 LIKE type_t.chr100, 
   pmds009 LIKE pmds_t.pmds009, 
   t1_pmaal004 LIKE pmaal_t.pmaal004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   l_pmds031_desc LIKE type_t.chr500, 
   pmds033 LIKE pmds_t.pmds033, 
   l_pmds033_desc LIKE type_t.chr1000, 
   pmds037 LIKE pmds_t.pmds037, 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   l_pmds002_ooag011 LIKE type_t.chr300, 
   pmds002 LIKE pmds_t.pmds002, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   l_pmds003_ooefl003 LIKE type_t.chr1000, 
   pmds003 LIKE pmds_t.pmds003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   pmdt003 LIKE pmdt_t.pmdt003, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   x_t3_imaal003 LIKE imaal_t.imaal003, 
   x_t3_imaal004 LIKE imaal_t.imaal004, 
   pmdt007 LIKE pmdt_t.pmdt007, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt019 LIKE pmdt_t.pmdt019, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   pmdt047 LIKE pmdt_t.pmdt047, 
   pmdt038 LIKE pmdt_t.pmdt038, 
   pmdt039 LIKE pmdt_t.pmdt039, 
   pmdt050 LIKE pmdt_t.pmdt050, 
   pmdt056 LIKE pmdt_t.pmdt056, 
   l_pmdt020_pmdt056 LIKE type_t.num20_6, 
   pmdt059 LIKE pmdt_t.pmdt059, 
   pmds000 LIKE pmds_t.pmds000, 
   pmds031 LIKE pmds_t.pmds031, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   pmaml_t_pmaml003 LIKE pmaml_t.pmaml003, 
   ooidl_t_ooidl003 LIKE ooidl_t.ooidl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t4_oocal003 LIKE oocal_t.oocal003, 
   x_t5_oocal003 LIKE oocal_t.oocal003, 
   x_qcaol_t_qcaol004 LIKE qcaol_t.qcaol004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_pmds028  LIKE pmds_t.pmds028   
DEFINE l_pmdt020_pmdt056  LIKE type_t.num20_6   #170124-00028#1 add 
DEFINE l_pmdn047  LIKE pmdn_t.pmdn047           #170124-00028#1 add 
DEFINE l_pmdn048  LIKE pmdn_t.pmdn048           #170124-00028#1 add 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr005_x01_curs INTO sr.*                               
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
       #161207-00033#23-S
       SELECT pmds028 INTO l_pmds028 FROM pmds_t
        WHERE pmdsent = g_enterprise
          AND pmdsdocno = sr.pmdsdocno
       IF NOT cl_null(l_pmds028) THEN
          CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING sr.pmaal_t_pmaal004
          LET sr.l_pmds007_pmaal004 = sr.pmds007 CLIPPED,'.',sr.pmaal_t_pmaal004 CLIPPED
          IF sr.pmds007 = sr.pmds008 THEN
             LET sr.t2_pmaal004 = sr.pmaal_t_pmaal004
             LET sr.l_pmds008_pmaal004 = sr.pmds008 CLIPPED,'.',sr.t2_pmaal004 CLIPPED 
          END IF
          IF sr.pmds007 = sr.pmds009 THEN
             LET sr.t1_pmaal004 = sr.pmaal_t_pmaal004
             LET sr.l_pmds009_pmaal004 = sr.pmds009 CLIPPED,'.',sr.t1_pmaal004 CLIPPED
          END IF          
       END IF       
       #161207-00033#23-E
       CALL apmr005_x01_nulltozero(sr.pmdt020) RETURNING sr.pmdt020
       CALL apmr005_x01_nulltozero(sr.pmdt056) RETURNING sr.pmdt056
       
       IF tm.a1 = "Y" AND sr.pmdt020 <= sr.pmdt056 THEN
          CONTINUE FOREACH
       END IF
       
       IF sr.pmds000 = '7' THEN
          LET sr.pmdt020 = sr.pmdt020 * (-1)
          LET sr.pmdt047 = sr.pmdt047 * (-1)
          LET sr.pmdt038 = sr.pmdt038 * (-1)
          LET sr.pmdt039 = sr.pmdt039 * (-1)
          LET sr.pmdt056 = sr.pmdt056 * (-1)
       END IF
       #170124-00028#1---add---begin------
       LET l_pmdt020_pmdt056 = sr.pmdt020 - sr.pmdt056
       CALL s_apmt500_get_amount(sr.pmdt001,sr.pmdt002,sr.pmds037,l_pmdt020_pmdt056,sr.pmdt036,sr.pmds033)
         RETURNING  sr.l_pmdt020_pmdt056,l_pmdn048,l_pmdn047
       #170124-00028#1---add---end-----
       #LET sr.l_pmdt020_pmdt056 = (sr.pmdt020 - sr.pmdt056) * sr.pmdt036  #170124-00028#1  mark
       LET sr.l_pmdt020_pmdt056 = (sr.pmdt020 - sr.pmdt056) * sr.pmdt036
       LET sr.l_pmds031_desc = sr.ooibl_t_ooibl004

       #稅別說明
       IF NOT cl_null(sr.pmdt001) THEN
          IF cl_null(sr.pmdt020) THEN
             LET sr.pmdt020 = 0
          END IF
          IF cl_null(sr.pmdt056) THEN
             LET sr.pmdt056 = 0
          END IF
       END IF
       #151106-00004#2 20151109 mark by beckxie ---S
       #CALL s_desc_get_tax_desc1(g_site,sr.pmds033)RETURNING sr.l_pmds033_desc
       #
       ##系列號   20150821 by dorislai add  (S)
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.pmdt006
       #   AND imaaent = g_enterprise
       #   #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
       #ELSE
       #   LET sr.l_imaa127desc = ''
       #END IF
       ##         20150821 by dorislai add  (E)
       #151106-00004#2 20151109 mark by beckxie ---E
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmds007,sr.pmaal_t_pmaal004,sr.pmds008,sr.t2_pmaal004,sr.pmds009,sr.t1_pmaal004,sr.l_pmds031_desc,sr.l_pmds033_desc,sr.pmds037,sr.pmdsdocno,sr.pmdtseq,sr.pmdsdocdt,sr.pmds002,sr.ooag_t_ooag011,sr.pmds003,sr.ooefl_t_ooefl003,sr.pmdt001,sr.pmdt002,sr.pmdt003,sr.pmdt006,sr.x_t3_imaal003,sr.x_t3_imaal004,sr.pmdt007,sr.l_imaa127,sr.l_imaa127_desc,sr.pmdt020,sr.pmdt019,sr.pmdt036,sr.pmdt047,sr.pmdt038,sr.pmdt039,sr.pmdt050,sr.pmdt056,sr.l_pmdt020_pmdt056,sr.pmdt059
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr005_x01_execute"
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
 
{<section id="apmr005_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr005_x01_rep_data()
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
 
{<section id="apmr005_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION apmr005_x01_nulltozero(p_num)
DEFINE p_num LIKE type_t.num20_6

   IF cl_null(p_num) THEN
      LET p_num = 0
   END IF

   RETURN p_num
END FUNCTION

 
{</section>}
 
