#該程式未解開Section, 採用最新樣板產出!
{<section id="armr200_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-10-20 15:26:40), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: armr200_g01
#+ Description: ...
#+ Creator....: 05423(2015-07-22 11:00:44)
#+ Modifier...: 05384 -SD/PR- 00000
 
{</section>}
 
{<section id="armr200_g01.global" readonly="Y" >}
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
   rmba000 LIKE rmba_t.rmba000, 
   rmba001 LIKE rmba_t.rmba001, 
   rmba002 LIKE rmba_t.rmba002, 
   rmba003 LIKE rmba_t.rmba003, 
   rmba004 LIKE rmba_t.rmba004, 
   rmba005 LIKE rmba_t.rmba005, 
   rmba006 LIKE rmba_t.rmba006, 
   rmba007 LIKE rmba_t.rmba007, 
   rmba008 LIKE rmba_t.rmba008, 
   rmba009 LIKE rmba_t.rmba009, 
   rmba010 LIKE rmba_t.rmba010, 
   rmba011 LIKE rmba_t.rmba011, 
   rmba012 LIKE rmba_t.rmba012, 
   rmba013 LIKE rmba_t.rmba013, 
   rmbadocdt LIKE rmba_t.rmbadocdt, 
   rmbadocno LIKE rmba_t.rmbadocno, 
   rmbaent LIKE rmba_t.rmbaent, 
   rmbasite LIKE rmba_t.rmbasite, 
   rmbastus LIKE rmba_t.rmbastus, 
   rmbb001 LIKE rmbb_t.rmbb001, 
   rmbb002 LIKE rmbb_t.rmbb002, 
   rmbbseq LIKE rmbb_t.rmbbseq, 
   rmbbsite LIKE rmbb_t.rmbbsite, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   l_rmba003_ooefl003 LIKE type_t.chr1000, 
   l_rmba001_pmaal004 LIKE type_t.chr100, 
   l_rmba003_ooefl_t_ooefl003 LIKE type_t.chr1000, 
   l_rmba002_ooag011 LIKE type_t.chr300, 
   l_rmbadocno_rmba000 LIKE type_t.chr50, 
   l_rmaa007 LIKE rmaa_t.rmaa007, 
   l_rmab009 LIKE rmab_t.rmab009, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_rmab010 LIKE type_t.chr50, 
   l_rmab010_desc LIKE type_t.chr50, 
   l_rmaa006 LIKE type_t.chr100, 
   l_rmab005 LIKE rmab_t.rmab005, 
   l_rmab006 LIKE rmab_t.rmab006, 
   l_rmab007 LIKE rmab_t.rmab007, 
   l_rmaa005 LIKE type_t.chr100, 
   l_rmab003 LIKE rmab_t.rmab003, 
   l_rmab004 LIKE rmab_t.rmab004, 
   l_rmba006_desc LIKE type_t.chr30, 
   l_rmba006_rmba007 LIKE type_t.chr50, 
   l_rmba010_rmba011 LIKE type_t.chr50, 
   l_rmab013 LIKE rmab_t.rmab013, 
   l_rmab011 LIKE rmab_t.rmab011, 
   l_sum LIKE rmbb_t.rmbb001
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr LIKE type_t.chr1          #列印賬務資訊
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
 TYPE sr3_r RECORD      #材料明细
   rmbcseq1       LIKE rmbc_t.rmbcseq1,
   rmbc001        LIKE rmbc_t.rmbc001,
   l_imaal003     LIKE imaal_t.imaal003,
   l_imaal004     LIKE imaal_t.imaal004,
   rmbc002        LIKE rmbc_t.rmbc002,
   l_rmbc002_desc LIKE type_t.chr50,
   rmbc004        LIKE rmbc_t.rmbc004,
   rmbc003        LIKE rmbc_t.rmbc003,
   rmbc005        LIKE rmbc_t.rmbc005,
   rmbc006        LIKE rmbc_t.rmbc006,
   rmbc008        LIKE rmbc_t.rmbc008,
   rmbc007        LIKE rmbc_t.rmbc007
END RECORD

 TYPE sr4_r RECORD      #费用明细
   rmbdseq1       LIKE rmbd_t.rmbdseq1,
   rmbd001        LIKE rmbd_t.rmbd001,
   l_rmbd001_desc LIKE oocql_t.oocql004,
   rmbd002        LIKE rmbd_t.rmbd002,
   rmbd003        LIKE rmbd_t.rmbd003,
   rmbd004        LIKE rmbd_t.rmbd004,
   rmbd006        LIKE rmbd_t.rmbd006,
   rmbd005        LIKE rmbd_t.rmbd005
END RECORD
#end add-point
 
{</section>}
 
{<section id="armr200_g01.main" readonly="Y" >}
PUBLIC FUNCTION armr200_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.pr  列印賬務資訊
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

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
   
   LET g_rep_code = "armr200_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL armr200_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL armr200_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL armr200_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="armr200_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION armr200_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
 
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT rmba000,rmba001,rmba002,rmba003,rmba004,rmba005,rmba006,rmba007,rmba008,rmba009, 
       rmba010,rmba011,rmba012,rmba013,rmbadocdt,rmbadocno,rmbaent,rmbasite,rmbastus,COALESCE(rmbb001,0),COALESCE(rmbb002,0), 
       rmbbseq,rmbbsite,pmaal_t.pmaal004,ooag_t.ooag011,t1.ooefl003,ooefl_t.ooefl003,ooibl_t.ooibl004, 
       oocql_t.oocql004,ooail_t.ooail003,trim(rmba003)||'.'||trim(t1.ooefl003),trim(rmba001)||'.'||trim(pmaal_t.pmaal004), 
       trim(rmba003)||'.'||trim(ooefl_t.ooefl003),trim(rmba002)||'.'||trim(ooag_t.ooag011),(trim(rmbadocno)||'/'||trim(rmba000)), 
       rmaa007,rmab009,imaal003,imaal004,rmab010,NULL,NULL,rmab005,rmab006,rmab007,NULL,rmab003,rmab004,
       NULL,NULL,NULL,rmab013,rmab011,NULL"
#   #end add-point
#   LET g_select = " SELECT rmba000,rmba001,rmba002,rmba003,rmba004,rmba005,rmba006,rmba007,rmba008,rmba009, 
#       rmba010,rmba011,rmba012,rmba013,rmbadocdt,rmbadocno,rmbaent,rmbasite,rmbastus,rmbb001,rmbb002, 
#       rmbbseq,rmbbsite,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = rmba_t.rmba001 AND pmaal_t.pmaalent = rmba_t.rmbaent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = rmba_t.rmba002 AND ooag_t.ooagent = rmba_t.rmbaent), 
#       ( SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooefl001 = rmba_t.rmba003 AND t1.ooeflent = rmba_t.rmbaent AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = rmba_t.rmba001 AND ooefl_t.ooeflent = rmba_t.rmbaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = rmba_t.rmba004 AND ooibl_t.ooiblent = rmba_t.rmbaent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '238' AND oocql_t.oocql002 = rmba_t.rmba005 AND oocql_t.oocqlent = rmba_t.rmbaent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = rmba_t.rmba010 AND ooail_t.ooailent = rmba_t.rmbaent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),trim(rmba003)||'.'||trim((SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooefl001 = rmba_t.rmba003 AND t1.ooeflent = rmba_t.rmbaent AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(rmba001)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = rmba_t.rmba001 AND pmaal_t.pmaalent = rmba_t.rmbaent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(rmba003)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = rmba_t.rmba001 AND ooefl_t.ooeflent = rmba_t.rmbaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(rmba002)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = rmba_t.rmba002 AND ooag_t.ooagent = rmba_t.rmbaent)), 
#       (trim(rmbadocno)||'/'||trim(rmba000)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM rmba_t LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = rmba_t.rmba002 AND ooag_t.ooagent = rmba_t.rmbaent ",
                "             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = rmba_t.rmba001 AND ooefl_t.ooeflent = rmba_t.rmbaent AND ooefl_t.ooefl002 = '" ,g_dlang,"'" ,
                "             LEFT OUTER JOIN ooefl_t t1 ON t1.ooefl001 = rmba_t.rmba003 AND t1.ooeflent = rmba_t.rmbaent AND t1.ooefl002 = '" ,g_dlang,"'" ,
                "             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = rmba_t.rmba001 AND pmaal_t.pmaalent = rmba_t.rmbaent AND pmaal_t.pmaal002 = '" ,g_dlang,"'" ,
                "             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = rmba_t.rmba005 AND oocql_t.oocqlent = rmba_t.rmbaent AND oocql_t.oocql003 = '" ,g_dlang,"'" ,
                "             LEFT OUTER JOIN ooail_t ON ooail_t.ooail001 = rmba_t.rmba010 AND ooail_t.ooailent = rmba_t.rmbaent AND ooail_t.ooail002 = '" ,g_dlang,"'" ,
                "             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = rmba_t.rmba004 AND ooibl_t.ooiblent = rmba_t.rmbaent AND ooibl_t.ooibl003 = '" ,g_dlang,"'" ,
                "             LEFT OUTER JOIN rmbb_t ON rmba_t.rmbaent = rmbbent AND rmba_t.rmbadocno = rmbbdocno AND rmba_t.rmba000 = rmbb000 ",
                "             LEFT OUTER JOIN rmaa_t ON rmbadocno = rmaadocno AND rmbaent = rmaaent AND rmbasite = rmaasite ",
                "             LEFT OUTER JOIN rmab_t ON rmbbdocno = rmabdocno AND rmbbent = rmabent AND rmbbsite = rmabsite AND rmbbseq = rmabseq ",
                "             LEFT OUTER JOIN imaal_t ON rmab009 = imaal001 AND rmabent = imaalent AND imaal002 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM rmba_t LEFT OUTER JOIN ( SELECT rmbb_t.* FROM rmbb_t  ) x  ON rmba_t.rmbaent  
#        = x.rmbbent AND rmba_t.rmbadocno = x.rmbbdocno AND rmba_t.rmba000 = x.rmbb000"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY rmbadocno,rmba000,rmbbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("rmba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE armr200_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE armr200_g01_curs CURSOR FOR armr200_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="armr200_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION armr200_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   rmba000 LIKE rmba_t.rmba000, 
   rmba001 LIKE rmba_t.rmba001, 
   rmba002 LIKE rmba_t.rmba002, 
   rmba003 LIKE rmba_t.rmba003, 
   rmba004 LIKE rmba_t.rmba004, 
   rmba005 LIKE rmba_t.rmba005, 
   rmba006 LIKE rmba_t.rmba006, 
   rmba007 LIKE rmba_t.rmba007, 
   rmba008 LIKE rmba_t.rmba008, 
   rmba009 LIKE rmba_t.rmba009, 
   rmba010 LIKE rmba_t.rmba010, 
   rmba011 LIKE rmba_t.rmba011, 
   rmba012 LIKE rmba_t.rmba012, 
   rmba013 LIKE rmba_t.rmba013, 
   rmbadocdt LIKE rmba_t.rmbadocdt, 
   rmbadocno LIKE rmba_t.rmbadocno, 
   rmbaent LIKE rmba_t.rmbaent, 
   rmbasite LIKE rmba_t.rmbasite, 
   rmbastus LIKE rmba_t.rmbastus, 
   rmbb001 LIKE rmbb_t.rmbb001, 
   rmbb002 LIKE rmbb_t.rmbb002, 
   rmbbseq LIKE rmbb_t.rmbbseq, 
   rmbbsite LIKE rmbb_t.rmbbsite, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   l_rmba003_ooefl003 LIKE type_t.chr1000, 
   l_rmba001_pmaal004 LIKE type_t.chr100, 
   l_rmba003_ooefl_t_ooefl003 LIKE type_t.chr1000, 
   l_rmba002_ooag011 LIKE type_t.chr300, 
   l_rmbadocno_rmba000 LIKE type_t.chr50, 
   l_rmaa007 LIKE rmaa_t.rmaa007, 
   l_rmab009 LIKE rmab_t.rmab009, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_rmab010 LIKE type_t.chr50, 
   l_rmab010_desc LIKE type_t.chr50, 
   l_rmaa006 LIKE type_t.chr100, 
   l_rmab005 LIKE rmab_t.rmab005, 
   l_rmab006 LIKE rmab_t.rmab006, 
   l_rmab007 LIKE rmab_t.rmab007, 
   l_rmaa005 LIKE type_t.chr100, 
   l_rmab003 LIKE rmab_t.rmab003, 
   l_rmab004 LIKE rmab_t.rmab004, 
   l_rmba006_desc LIKE type_t.chr30, 
   l_rmba006_rmba007 LIKE type_t.chr50, 
   l_rmba010_rmba011 LIKE type_t.chr50, 
   l_rmab013 LIKE rmab_t.rmab013, 
   l_rmab011 LIKE rmab_t.rmab011, 
   l_sum LIKE rmbb_t.rmbb001
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_rmab004   LIKE type_t.chr10
   DEFINE l_rmab006   LIKE type_t.chr10
   DEFINE l_rmab007   LIKE type_t.chr10
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH armr200_g01_curs INTO sr_s.*
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
       IF cl_null(sr_s.rmbbseq) THEN
          INITIALIZE sr_s.l_rmab013 TO NULL
          INITIALIZE sr_s.rmbb001 TO NULL
          INITIALIZE sr_s.rmbb002 TO NULL
          INITIALIZE sr_s.l_sum TO NULL
       END IF
       LET l_rmab004 = NULL
       LET l_rmab006 = NULL
       LET l_rmab007 = NULL
       LET l_rmab004 = sr_s.l_rmab004
       LET l_rmab006 = sr_s.l_rmab006
       LET l_rmab007 = sr_s.l_rmab007
       #获取税别，业务人员、部门、客户编号、收款条件、交易条件、税别税率、币别汇率
       #税别税率
       CALL s_desc_get_tax_desc1(g_site,sr_s.rmba006) RETURNING sr_s.l_rmba006_desc
       IF cl_null(sr_s.l_rmba006_desc) THEN
          LET sr_s.l_rmba006_desc = sr_s.rmba006
       END IF
       IF NOT cl_null(sr_s.rmba007) THEN
          LET sr_s.l_rmba006_rmba007 = sr_s.l_rmba006_desc CLIPPED,'/',sr_s.rmba007 USING '<<<<<','%'
       ELSE
          LET sr_s.l_rmba006_rmba007 = sr_s.l_rmba006_desc CLIPPED,'/',sr_s.rmba007 CLIPPED
       END IF
       #币别汇率
       LET sr_s.l_rmba010_rmba011 = sr_s.rmba010 CLIPPED,'/',sr_s.rmba011  USING '<<<<<<<<<<'
       
       IF cl_null(sr_s.rmba000) THEN
          LET sr_s.l_rmbadocno_rmba000 = sr_s.rmbadocno
       END IF
       IF cl_null(sr_s.rmba001) THEN
          LET sr_s.l_rmba001_pmaal004 = sr_s.rmba001
       END IF
       IF cl_null(sr_s.rmba002) THEN
          LET sr_s.l_rmba002_ooag011 = sr_s.rmba002
       END IF
       IF cl_null(sr_s.rmba003) THEN
          LET sr_s.l_rmba003_ooefl003 = sr_s.rmba003
       END IF
       #收款条件
       IF NOT cl_null(sr_s.rmba004) THEN
          LET sr_s.ooibl_t_ooibl004 = sr_s.rmba004 CLIPPED,'.',sr_s.ooibl_t_ooibl004
       ELSE
          LET sr_s.ooibl_t_ooibl004 = sr_s.rmba004 
       END IF
       #交易条件
       IF NOT cl_null(sr_s.rmba005) THEN
          LET sr_s.oocql_t_oocql004 = sr_s.rmba005 CLIPPED,'.',sr_s.oocql_t_oocql004
       ELSE
          LET sr_s.oocql_t_oocql004 = sr_s.rmba005 
       END IF
       #订单单号
       IF NOT cl_null(sr_s.l_rmab005) THEN
          LET sr_s.l_rmaa006 = sr_s.l_rmab005 CLIPPED,'/',l_rmab006 CLIPPED,'/',l_rmab007 CLIPPED
       END IF
       #出货单号
       IF NOT cl_null(sr_s.l_rmab003) THEN
          LET sr_s.l_rmaa005 = sr_s.l_rmab003 CLIPPED,'/',l_rmab004 CLIPPED
       END IF
       #料件特征
       IF NOT cl_null(sr_s.l_rmab010) THEN
         CALL s_feature_description(sr_s.l_rmab009,sr_s.l_rmab010) RETURNING r_success,sr_s.l_rmab010_desc
       END IF
       #合计金额
       LET sr_s.l_sum = sr_s.rmbb001 + sr_s.rmbb002
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].rmba000 = sr_s.rmba000
       LET sr[l_cnt].rmba001 = sr_s.rmba001
       LET sr[l_cnt].rmba002 = sr_s.rmba002
       LET sr[l_cnt].rmba003 = sr_s.rmba003
       LET sr[l_cnt].rmba004 = sr_s.rmba004
       LET sr[l_cnt].rmba005 = sr_s.rmba005
       LET sr[l_cnt].rmba006 = sr_s.rmba006
       LET sr[l_cnt].rmba007 = sr_s.rmba007
       LET sr[l_cnt].rmba008 = sr_s.rmba008
       LET sr[l_cnt].rmba009 = sr_s.rmba009
       LET sr[l_cnt].rmba010 = sr_s.rmba010
       LET sr[l_cnt].rmba011 = sr_s.rmba011
       LET sr[l_cnt].rmba012 = sr_s.rmba012
       LET sr[l_cnt].rmba013 = sr_s.rmba013
       LET sr[l_cnt].rmbadocdt = sr_s.rmbadocdt
       LET sr[l_cnt].rmbadocno = sr_s.rmbadocno
       LET sr[l_cnt].rmbaent = sr_s.rmbaent
       LET sr[l_cnt].rmbasite = sr_s.rmbasite
       LET sr[l_cnt].rmbastus = sr_s.rmbastus
       LET sr[l_cnt].rmbb001 = sr_s.rmbb001
       LET sr[l_cnt].rmbb002 = sr_s.rmbb002
       LET sr[l_cnt].rmbbseq = sr_s.rmbbseq
       LET sr[l_cnt].rmbbsite = sr_s.rmbbsite
       LET sr[l_cnt].pmaal_t_pmaal004 = sr_s.pmaal_t_pmaal004
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].ooibl_t_ooibl004 = sr_s.ooibl_t_ooibl004
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].ooail_t_ooail003 = sr_s.ooail_t_ooail003
       LET sr[l_cnt].l_rmba003_ooefl003 = sr_s.l_rmba003_ooefl003
       LET sr[l_cnt].l_rmba001_pmaal004 = sr_s.l_rmba001_pmaal004
       LET sr[l_cnt].l_rmba003_ooefl_t_ooefl003 = sr_s.l_rmba003_ooefl_t_ooefl003
       LET sr[l_cnt].l_rmba002_ooag011 = sr_s.l_rmba002_ooag011
       LET sr[l_cnt].l_rmbadocno_rmba000 = sr_s.l_rmbadocno_rmba000
       LET sr[l_cnt].l_rmaa007 = sr_s.l_rmaa007
       LET sr[l_cnt].l_rmab009 = sr_s.l_rmab009
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_rmab010 = sr_s.l_rmab010
       LET sr[l_cnt].l_rmab010_desc = sr_s.l_rmab010_desc
       LET sr[l_cnt].l_rmaa006 = sr_s.l_rmaa006
       LET sr[l_cnt].l_rmab005 = sr_s.l_rmab005
       LET sr[l_cnt].l_rmab006 = sr_s.l_rmab006
       LET sr[l_cnt].l_rmab007 = sr_s.l_rmab007
       LET sr[l_cnt].l_rmaa005 = sr_s.l_rmaa005
       LET sr[l_cnt].l_rmab003 = sr_s.l_rmab003
       LET sr[l_cnt].l_rmab004 = sr_s.l_rmab004
       LET sr[l_cnt].l_rmba006_desc = sr_s.l_rmba006_desc
       LET sr[l_cnt].l_rmba006_rmba007 = sr_s.l_rmba006_rmba007
       LET sr[l_cnt].l_rmba010_rmba011 = sr_s.l_rmba010_rmba011
       LET sr[l_cnt].l_rmab013 = sr_s.l_rmab013
       LET sr[l_cnt].l_rmab011 = sr_s.l_rmab011
       LET sr[l_cnt].l_sum = sr_s.l_sum
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="armr200_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION armr200_g01_rep_data()
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
          START REPORT armr200_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT armr200_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT armr200_g01_rep
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
 
{<section id="armr200_g01.rep" readonly="Y" >}
PRIVATE REPORT armr200_g01_rep(sr1)
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
DEFINE l_subrep05_show  LIKE type_t.chr1,
       l_subrep06_show  LIKE type_t.chr1
DEFINE l_rmbb001        LIKE rmbb_t.rmbb001
DEFINE l_rmbb002        LIKE rmbb_t.rmbb002
DEFINE l_sum            LIKE rmbb_t.rmbb001
DEFINE  r_success   LIKE type_t.num5
DEFINE l_show           LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_rmbadocno_rmba000,sr1.rmbbseq
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
        BEFORE GROUP OF sr1.l_rmbadocno_rmba000
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_rmbadocno_rmba000
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'rmbaent=' ,sr1.rmbaent,'{+}rmbadocno=' ,sr1.rmbadocno,'{+}rmba000=' ,sr1.rmba000         
            CALL cl_gr_init_apr(sr1.l_rmbadocno_rmba000)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_rmbadocno_rmba000.before name="rep.b_group.l_rmbadocno_rmba000.before"
           LET l_rmbb001 = 0
           LET l_rmbb002 = 0
           LET l_sum = 0
           LET l_show = 'Y'
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt
             FROM rmbb_t
            WHERE rmbbdocno = sr1.rmbadocno
              AND rmbb000 = sr1.rmba000
              AND rmbbent = sr1.rmbaent
              AND rmbbsite = sr1.rmbasite
           IF l_cnt = 0 THEN
              LET l_show = 'N'
           END IF
           PRINTX l_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.rmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_rmbadocno_rmba000 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr200_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE armr200_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT armr200_g01_subrep01
           DECLARE armr200_g01_repcur01 CURSOR FROM g_sql
           FOREACH armr200_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr200_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT armr200_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT armr200_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_rmbadocno_rmba000.after name="rep.b_group.l_rmbadocno_rmba000.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.rmbbseq
 
           #add-point:rep.b_group.rmbbseq.before name="rep.b_group.rmbbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.rmbbseq.after name="rep.b_group.rmbbseq.after"
           
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
                sr1.rmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_rmbadocno_rmba000 CLIPPED ,"'", 
                " AND  ooff004 = ", sr1.rmbbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr200_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE armr200_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT armr200_g01_subrep02
           DECLARE armr200_g01_repcur02 CURSOR FROM g_sql
           FOREACH armr200_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr200_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT armr200_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT armr200_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          LET l_rmbb001 = l_rmbb001 + sr1.rmbb001
          LET l_rmbb002 = l_rmbb002 + sr1.rmbb002
          LET l_sum = l_sum + sr1.l_sum
          #材料明细子报表subrep05
          LET g_sql = " SELECT DISTINCT rmbcseq1,rmbc001,imaal003,imaal004,rmbc002,NULL,COALESCE(rmbc004,0),",
                      " rmbc003,COALESCE(rmbc005,0),COALESCE(rmbc006,0),COALESCE(rmbc008,0),COALESCE(rmbc007,0)", 
                      " FROM rmbc_t LEFT OUTER JOIN imaal_t ON imaal001 = rmbc001 AND imaalent = rmbcent AND imaal002 = '",g_dlang,"' ",
                      " WHERE rmbcent = ",sr1.rmbaent CLIPPED ," AND  rmbcdocno = '", sr1.rmbadocno CLIPPED ,
                      "' AND rmbc000 = '",sr1.rmba000,"' AND rmbcsite = '",g_site,"' AND (rmbcseq = '",sr1.rmbbseq,"' OR rmbcseq IS NULL) ",
                      " ORDER BY rmbcseq1 "
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep05_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE armr200_g01_repcur05_cnt_pre FROM l_sub_sql
          EXECUTE armr200_g01_repcur05_cnt_pre INTO l_cnt
          IF l_cnt > 0 THEN 
             LET l_subrep05_show ="Y"
          END IF
          PRINTX l_subrep05_show
          START REPORT armr200_g01_subrep05
          DECLARE armr200_g01_repcur05 CURSOR FROM g_sql
          FOREACH armr200_g01_repcur05 INTO sr3.*
             IF STATUS THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "armr200_g01_repcur05:"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()                  
                EXIT FOREACH 
             END IF
             #add-point:rep.sub02.foreach
             CALL s_feature_description(sr3.rmbc001,sr3.rmbc002) RETURNING r_success,sr3.l_rmbc002_desc
             #end add-point:rep.sub02.foreach
             OUTPUT TO REPORT armr200_g01_subrep05(sr3.*)
          END FOREACH
          FINISH REPORT armr200_g01_subrep05
          
          #费用明细子报表subrep06
          LET g_sql = " SELECT DISTINCT rmbdseq1,rmbd001,trim(rmbd001)||'.'||trim(oocql004),COALESCE(rmbd002,0),COALESCE(rmbd003,0),",
                      " COALESCE(rmbd004,0),COALESCE(rmbd006,0),COALESCE(rmbd005,0)", 
                      " FROM rmbd_t LEFT OUTER JOIN oocql_t ON oocql001 = '1131' AND oocql002 = rmbd001 AND oocqlent = rmbdent AND oocql003 = '",g_dlang,"' ",
                      " WHERE rmbdent = ",sr1.rmbaent CLIPPED ," AND  rmbddocno = '", sr1.rmbadocno CLIPPED ,
                      "' AND rmbd000 = '",sr1.rmba000,"' AND rmbdsite = '",g_site,"' AND (rmbdseq = '",sr1.rmbbseq,"' OR rmbdseq IS NULL) ",
                      " ORDER BY rmbdseq1 "
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep06_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE armr200_g01_repcur06_cnt_pre FROM l_sub_sql
          EXECUTE armr200_g01_repcur06_cnt_pre INTO l_cnt
          IF l_cnt > 0 THEN 
             LET l_subrep06_show ="Y"
          END IF
          PRINTX l_subrep06_show
          START REPORT armr200_g01_subrep06
          DECLARE armr200_g01_repcur06 CURSOR FROM g_sql
          FOREACH armr200_g01_repcur06 INTO sr4.*
             IF STATUS THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "armr200_g01_repcur06:"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()                  
                EXIT FOREACH 
             END IF
             #add-point:rep.sub02.foreach
             IF cl_null(sr4.rmbd001) THEN
                LET sr4.l_rmbd001_desc = sr4.rmbd001
             END IF
             #end add-point:rep.sub02.foreach
             OUTPUT TO REPORT armr200_g01_subrep06(sr4.*)
          END FOREACH
          FINISH REPORT armr200_g01_subrep06
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.rmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_rmbadocno_rmba000 CLIPPED ,"'", 
                " AND  ooff004 = ", sr1.rmbbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr200_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE armr200_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT armr200_g01_subrep03
           DECLARE armr200_g01_repcur03 CURSOR FROM g_sql
           FOREACH armr200_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr200_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT armr200_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT armr200_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_rmbadocno_rmba000
 
           #add-point:rep.a_group.l_rmbadocno_rmba000.before name="rep.a_group.l_rmbadocno_rmba000.before"
           PRINTX l_rmbb001
           PRINTX l_rmbb002
           PRINTX l_sum
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.rmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_rmbadocno_rmba000 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE armr200_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE armr200_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT armr200_g01_subrep04
           DECLARE armr200_g01_repcur04 CURSOR FROM g_sql
           FOREACH armr200_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "armr200_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT armr200_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT armr200_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_rmbadocno_rmba000.after name="rep.a_group.l_rmbadocno_rmba000.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.rmbbseq
 
           #add-point:rep.a_group.rmbbseq.before name="rep.a_group.rmbbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.rmbbseq.after name="rep.a_group.rmbbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="armr200_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT armr200_g01_subrep01(sr2)
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
PRIVATE REPORT armr200_g01_subrep02(sr2)
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
PRIVATE REPORT armr200_g01_subrep03(sr2)
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
PRIVATE REPORT armr200_g01_subrep04(sr2)
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
 
{<section id="armr200_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="armr200_g01.other_report" readonly="Y" >}
#材料明细子报表
PRIVATE REPORT armr200_g01_subrep05(sr3)
DEFINE sr3  sr3_r
    ORDER EXTERNAL BY sr3.rmbcseq1
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

#费用明细子报表
PRIVATE REPORT armr200_g01_subrep06(sr4)
DEFINE sr4  sr4_r    
    ORDER EXTERNAL BY sr4.rmbdseq1
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

 
{</section>}
 
