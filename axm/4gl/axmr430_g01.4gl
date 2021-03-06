#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr430_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-11-09 12:42:23), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: axmr430_g01
#+ Description: ...
#+ Creator....: 04543(2015-07-22 14:38:59)
#+ Modifier...: 08992 -SD/PR- 00000
 
{</section>}
 
{<section id="axmr430_g01.global" readonly="Y" >}
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
   xmfj001 LIKE xmfj_t.xmfj001, 
   xmfj002 LIKE xmfj_t.xmfj002, 
   xmfj003 LIKE xmfj_t.xmfj003, 
   xmfj004 LIKE xmfj_t.xmfj004, 
   xmfj005 LIKE xmfj_t.xmfj005, 
   xmfj006 LIKE xmfj_t.xmfj006, 
   xmfj007 LIKE xmfj_t.xmfj007, 
   xmfj008 LIKE xmfj_t.xmfj008, 
   xmfj009 LIKE xmfj_t.xmfj009, 
   xmfj010 LIKE xmfj_t.xmfj010, 
   xmfj011 LIKE xmfj_t.xmfj011, 
   xmfj012 LIKE xmfj_t.xmfj012, 
   xmfj013 LIKE xmfj_t.xmfj013, 
   xmfj014 LIKE xmfj_t.xmfj014, 
   xmfj015 LIKE xmfj_t.xmfj015, 
   xmfj016 LIKE xmfj_t.xmfj016, 
   xmfj017 LIKE xmfj_t.xmfj017, 
   xmfj018 LIKE xmfj_t.xmfj018, 
   xmfj019 LIKE xmfj_t.xmfj019, 
   xmfj020 LIKE xmfj_t.xmfj020, 
   xmfj030 LIKE xmfj_t.xmfj030, 
   xmfjcnfdt LIKE xmfj_t.xmfjcnfdt, 
   xmfjcnfid LIKE xmfj_t.xmfjcnfid, 
   xmfjcrtdp LIKE xmfj_t.xmfjcrtdp, 
   xmfjcrtdt DATETIME YEAR TO SECOND, 
   xmfjcrtid LIKE xmfj_t.xmfjcrtid, 
   xmfjdocdt LIKE xmfj_t.xmfjdocdt, 
   xmfjdocno LIKE xmfj_t.xmfjdocno, 
   xmfjent LIKE xmfj_t.xmfjent, 
   xmfjmoddt DATETIME YEAR TO SECOND, 
   xmfjmodid LIKE xmfj_t.xmfjmodid, 
   xmfjowndp LIKE xmfj_t.xmfjowndp, 
   xmfjownid LIKE xmfj_t.xmfjownid, 
   xmfjpstdt LIKE xmfj_t.xmfjpstdt, 
   xmfjpstid LIKE xmfj_t.xmfjpstid, 
   xmfjsite LIKE xmfj_t.xmfjsite, 
   xmfjstus LIKE xmfj_t.xmfjstus, 
   xmfl001 LIKE xmfl_t.xmfl001, 
   xmfl002 LIKE xmfl_t.xmfl002, 
   xmfl003 LIKE xmfl_t.xmfl003, 
   xmfl004 LIKE xmfl_t.xmfl004, 
   xmfl005 LIKE xmfl_t.xmfl005, 
   xmfl006 LIKE xmfl_t.xmfl006, 
   xmfl007 LIKE xmfl_t.xmfl007, 
   xmfl008 LIKE xmfl_t.xmfl008, 
   xmfl009 LIKE xmfl_t.xmfl009, 
   xmfl010 LIKE xmfl_t.xmfl010, 
   xmfl011 LIKE xmfl_t.xmfl011, 
   xmfl012 LIKE xmfl_t.xmfl012, 
   xmfl020 LIKE xmfl_t.xmfl020, 
   xmfldocno LIKE xmfl_t.xmfldocno, 
   xmflent LIKE xmfl_t.xmflent, 
   xmflseq LIKE xmfl_t.xmflseq, 
   xmflsite LIKE xmfl_t.xmflsite, 
   l_xmfj003_desc LIKE type_t.chr1000, 
   l_xmfj005_desc LIKE oodbl_t.oodbl004, 
   l_xmfj009_desc LIKE oocql_t.oocql004, 
   l_xmfj008_desc LIKE ooibl_t.ooibl004, 
   l_xmfj010_desc LIKE oocql_t.oocql004, 
   l_xmfj001_desc LIKE type_t.chr1000, 
   l_xmfj002_desc LIKE type_t.chr1000, 
   l_xmfj019_desc LIKE gzcbl_t.gzcbl004, 
   l_xmfl001_desc LIKE gzcbl_t.gzcbl004, 
   l_xmfl002_desc1 LIKE imaal_t.imaal003, 
   l_xmfl002_desc2 LIKE imaal_t.imaal004, 
   l_xmfl002_desc3 LIKE type_t.chr100, 
   l_xmfl005_desc LIKE gzcbl_t.gzcbl004, 
   l_xmfl020_show LIKE type_t.chr1
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
TYPE sr3_r RECORD
   xmfkdocno      LIKE xmfk_t.xmfkdocno,
   xmfk001        LIKE xmfk_t.xmfk001,
   xmfk001_desc   LIKE pmaal_t.pmaal004,
   xmfk002        LIKE xmfk_t.xmfk002,
   xmfk002_desc   LIKE pmaal_t.pmaal004
END RECORD

TYPE sr4_r RECORD
   xmfmdocno      LIKE xmfm_t.xmfmdocno,
   xmfm001        LIKE xmfm_t.xmfm001,
   xmfm002        LIKE xmfm_t.xmfm002,
   xmfm003        LIKE xmfm_t.xmfm003,
   xmfm004        LIKE xmfm_t.xmfm004
END RECORD
#end add-point
 
{</section>}
 
{<section id="axmr430_g01.main" readonly="Y" >}
PUBLIC FUNCTION axmr430_g01(p_arg1)
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
   
   LET g_rep_code = "axmr430_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axmr430_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axmr430_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axmr430_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr430_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr430_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xmfj001,xmfj002,xmfj003,xmfj004,xmfj005,xmfj006,xmfj007,xmfj008,xmfj009,xmfj010, 
       xmfj011,xmfj012,xmfj013,xmfj014,xmfj015,xmfj016,xmfj017,xmfj018,xmfj019,xmfj020,xmfj030,xmfjcnfdt, 
       xmfjcnfid,xmfjcrtdp,xmfjcrtdt,xmfjcrtid,xmfjdocdt,xmfjdocno,xmfjent,xmfjmoddt,xmfjmodid,xmfjowndp, 
       xmfjownid,xmfjpstdt,xmfjpstid,xmfjsite,xmfjstus,xmfl001,xmfl002,xmfl003,xmfl004,xmfl005,xmfl006, 
       xmfl007,xmfl008,xmfl009,xmfl010,xmfl011,xmfl012,xmfl020,xmfldocno,xmflent,xmflseq,xmflsite,'', 
       '','','','','','','','','','','','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xmfj_t,xmfl_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM xmfj_t LEFT OUTER JOIN xmfl_t ON xmflent = xmfjent AND xmfldocno = xmfjdocno"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xmfjdocno,xmflseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmfj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr430_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axmr430_g01_curs CURSOR FOR axmr430_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr430_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr430_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xmfj001 LIKE xmfj_t.xmfj001, 
   xmfj002 LIKE xmfj_t.xmfj002, 
   xmfj003 LIKE xmfj_t.xmfj003, 
   xmfj004 LIKE xmfj_t.xmfj004, 
   xmfj005 LIKE xmfj_t.xmfj005, 
   xmfj006 LIKE xmfj_t.xmfj006, 
   xmfj007 LIKE xmfj_t.xmfj007, 
   xmfj008 LIKE xmfj_t.xmfj008, 
   xmfj009 LIKE xmfj_t.xmfj009, 
   xmfj010 LIKE xmfj_t.xmfj010, 
   xmfj011 LIKE xmfj_t.xmfj011, 
   xmfj012 LIKE xmfj_t.xmfj012, 
   xmfj013 LIKE xmfj_t.xmfj013, 
   xmfj014 LIKE xmfj_t.xmfj014, 
   xmfj015 LIKE xmfj_t.xmfj015, 
   xmfj016 LIKE xmfj_t.xmfj016, 
   xmfj017 LIKE xmfj_t.xmfj017, 
   xmfj018 LIKE xmfj_t.xmfj018, 
   xmfj019 LIKE xmfj_t.xmfj019, 
   xmfj020 LIKE xmfj_t.xmfj020, 
   xmfj030 LIKE xmfj_t.xmfj030, 
   xmfjcnfdt LIKE xmfj_t.xmfjcnfdt, 
   xmfjcnfid LIKE xmfj_t.xmfjcnfid, 
   xmfjcrtdp LIKE xmfj_t.xmfjcrtdp, 
   xmfjcrtdt LIKE xmfj_t.xmfjcrtdt, 
   xmfjcrtid LIKE xmfj_t.xmfjcrtid, 
   xmfjdocdt LIKE xmfj_t.xmfjdocdt, 
   xmfjdocno LIKE xmfj_t.xmfjdocno, 
   xmfjent LIKE xmfj_t.xmfjent, 
   xmfjmoddt LIKE xmfj_t.xmfjmoddt, 
   xmfjmodid LIKE xmfj_t.xmfjmodid, 
   xmfjowndp LIKE xmfj_t.xmfjowndp, 
   xmfjownid LIKE xmfj_t.xmfjownid, 
   xmfjpstdt LIKE xmfj_t.xmfjpstdt, 
   xmfjpstid LIKE xmfj_t.xmfjpstid, 
   xmfjsite LIKE xmfj_t.xmfjsite, 
   xmfjstus LIKE xmfj_t.xmfjstus, 
   xmfl001 LIKE xmfl_t.xmfl001, 
   xmfl002 LIKE xmfl_t.xmfl002, 
   xmfl003 LIKE xmfl_t.xmfl003, 
   xmfl004 LIKE xmfl_t.xmfl004, 
   xmfl005 LIKE xmfl_t.xmfl005, 
   xmfl006 LIKE xmfl_t.xmfl006, 
   xmfl007 LIKE xmfl_t.xmfl007, 
   xmfl008 LIKE xmfl_t.xmfl008, 
   xmfl009 LIKE xmfl_t.xmfl009, 
   xmfl010 LIKE xmfl_t.xmfl010, 
   xmfl011 LIKE xmfl_t.xmfl011, 
   xmfl012 LIKE xmfl_t.xmfl012, 
   xmfl020 LIKE xmfl_t.xmfl020, 
   xmfldocno LIKE xmfl_t.xmfldocno, 
   xmflent LIKE xmfl_t.xmflent, 
   xmflseq LIKE xmfl_t.xmflseq, 
   xmflsite LIKE xmfl_t.xmflsite, 
   l_xmfj003_desc LIKE type_t.chr1000, 
   l_xmfj005_desc LIKE oodbl_t.oodbl004, 
   l_xmfj009_desc LIKE oocql_t.oocql004, 
   l_xmfj008_desc LIKE ooibl_t.ooibl004, 
   l_xmfj010_desc LIKE oocql_t.oocql004, 
   l_xmfj001_desc LIKE type_t.chr1000, 
   l_xmfj002_desc LIKE type_t.chr1000, 
   l_xmfj019_desc LIKE gzcbl_t.gzcbl004, 
   l_xmfl001_desc LIKE gzcbl_t.gzcbl004, 
   l_xmfl002_desc1 LIKE imaal_t.imaal003, 
   l_xmfl002_desc2 LIKE imaal_t.imaal004, 
   l_xmfl002_desc3 LIKE type_t.chr100, 
   l_xmfl005_desc LIKE gzcbl_t.gzcbl004, 
   l_xmfl020_show LIKE type_t.chr1
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_success       LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axmr430_g01_curs INTO sr_s.*
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

       #.帳款客戶
       CALL s_desc_get_trading_partner_abbr_desc(sr_s.xmfj003)
       RETURNING sr_s.l_xmfj003_desc
       LET sr_s.l_xmfj003_desc = sr_s.xmfj003,".",sr_s.l_xmfj003_desc
       #稅別
       CALL s_desc_get_tax_desc1(sr_s.xmfjsite,sr_s.xmfj005)
       RETURNING sr_s.l_xmfj005_desc
       #交易條件
       CALL s_desc_get_acc_desc('238',sr_s.xmfj009)
       RETURNING sr_s.l_xmfj009_desc
       #收款條件
       CALL s_desc_get_ooib002_desc(sr_s.xmfj008)
       RETURNING sr_s.l_xmfj008_desc
       #銷售通路
       CALL s_desc_get_acc_desc('275',sr_s.xmfj010)
       RETURNING sr_s.l_xmfj010_desc
       #.銷售人員
       CALL s_desc_get_person_desc(sr_s.xmfj001)
       RETURNING sr_s.l_xmfj001_desc
       LET sr_s.l_xmfj001_desc = sr_s.xmfj001,".",sr_s.l_xmfj001_desc
       #.銷售部門
       CALL s_desc_get_department_desc(sr_s.xmfj002)
       RETURNING sr_s.l_xmfj002_desc
       LET sr_s.l_xmfj002_desc = sr_s.xmfj002,".",sr_s.l_xmfj002_desc
       #帳款產生方式
       CALL s_desc_gzcbl004_desc('2103',sr_s.xmfj019)
       RETURNING sr_s.l_xmfj019_desc
       #資料類型
       CALL s_desc_gzcbl004_desc('2104',sr_s.xmfl001)
       RETURNING sr_s.l_xmfl001_desc
       #品名,規格
       CALL s_desc_get_item_desc(sr_s.xmfl002)
       RETURNING sr_s.l_xmfl002_desc1,sr_s.l_xmfl002_desc2
       #產品特徵
       CALL s_feature_description(sr_s.xmfl002,sr_s.xmfl003)
       RETURNING l_success,sr_s.l_xmfl002_desc3
       #折扣方式
       CALL s_desc_gzcbl004_desc('2105',sr_s.xmfl005)
       RETURNING sr_s.l_xmfl005_desc
       
       #備註顯示否
       IF cl_null(sr_s.xmfl020) THEN
          LET sr_s.l_xmfl020_show = 'N'
       ELSE
          LET sr_s.l_xmfl020_show = 'Y'
       END IF
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xmfj001 = sr_s.xmfj001
       LET sr[l_cnt].xmfj002 = sr_s.xmfj002
       LET sr[l_cnt].xmfj003 = sr_s.xmfj003
       LET sr[l_cnt].xmfj004 = sr_s.xmfj004
       LET sr[l_cnt].xmfj005 = sr_s.xmfj005
       LET sr[l_cnt].xmfj006 = sr_s.xmfj006
       LET sr[l_cnt].xmfj007 = sr_s.xmfj007
       LET sr[l_cnt].xmfj008 = sr_s.xmfj008
       LET sr[l_cnt].xmfj009 = sr_s.xmfj009
       LET sr[l_cnt].xmfj010 = sr_s.xmfj010
       LET sr[l_cnt].xmfj011 = sr_s.xmfj011
       LET sr[l_cnt].xmfj012 = sr_s.xmfj012
       LET sr[l_cnt].xmfj013 = sr_s.xmfj013
       LET sr[l_cnt].xmfj014 = sr_s.xmfj014
       LET sr[l_cnt].xmfj015 = sr_s.xmfj015
       LET sr[l_cnt].xmfj016 = sr_s.xmfj016
       LET sr[l_cnt].xmfj017 = sr_s.xmfj017
       LET sr[l_cnt].xmfj018 = sr_s.xmfj018
       LET sr[l_cnt].xmfj019 = sr_s.xmfj019
       LET sr[l_cnt].xmfj020 = sr_s.xmfj020
       LET sr[l_cnt].xmfj030 = sr_s.xmfj030
       LET sr[l_cnt].xmfjcnfdt = sr_s.xmfjcnfdt
       LET sr[l_cnt].xmfjcnfid = sr_s.xmfjcnfid
       LET sr[l_cnt].xmfjcrtdp = sr_s.xmfjcrtdp
       LET sr[l_cnt].xmfjcrtdt = sr_s.xmfjcrtdt
       LET sr[l_cnt].xmfjcrtid = sr_s.xmfjcrtid
       LET sr[l_cnt].xmfjdocdt = sr_s.xmfjdocdt
       LET sr[l_cnt].xmfjdocno = sr_s.xmfjdocno
       LET sr[l_cnt].xmfjent = sr_s.xmfjent
       LET sr[l_cnt].xmfjmoddt = sr_s.xmfjmoddt
       LET sr[l_cnt].xmfjmodid = sr_s.xmfjmodid
       LET sr[l_cnt].xmfjowndp = sr_s.xmfjowndp
       LET sr[l_cnt].xmfjownid = sr_s.xmfjownid
       LET sr[l_cnt].xmfjpstdt = sr_s.xmfjpstdt
       LET sr[l_cnt].xmfjpstid = sr_s.xmfjpstid
       LET sr[l_cnt].xmfjsite = sr_s.xmfjsite
       LET sr[l_cnt].xmfjstus = sr_s.xmfjstus
       LET sr[l_cnt].xmfl001 = sr_s.xmfl001
       LET sr[l_cnt].xmfl002 = sr_s.xmfl002
       LET sr[l_cnt].xmfl003 = sr_s.xmfl003
       LET sr[l_cnt].xmfl004 = sr_s.xmfl004
       LET sr[l_cnt].xmfl005 = sr_s.xmfl005
       LET sr[l_cnt].xmfl006 = sr_s.xmfl006
       LET sr[l_cnt].xmfl007 = sr_s.xmfl007
       LET sr[l_cnt].xmfl008 = sr_s.xmfl008
       LET sr[l_cnt].xmfl009 = sr_s.xmfl009
       LET sr[l_cnt].xmfl010 = sr_s.xmfl010
       LET sr[l_cnt].xmfl011 = sr_s.xmfl011
       LET sr[l_cnt].xmfl012 = sr_s.xmfl012
       LET sr[l_cnt].xmfl020 = sr_s.xmfl020
       LET sr[l_cnt].xmfldocno = sr_s.xmfldocno
       LET sr[l_cnt].xmflent = sr_s.xmflent
       LET sr[l_cnt].xmflseq = sr_s.xmflseq
       LET sr[l_cnt].xmflsite = sr_s.xmflsite
       LET sr[l_cnt].l_xmfj003_desc = sr_s.l_xmfj003_desc
       LET sr[l_cnt].l_xmfj005_desc = sr_s.l_xmfj005_desc
       LET sr[l_cnt].l_xmfj009_desc = sr_s.l_xmfj009_desc
       LET sr[l_cnt].l_xmfj008_desc = sr_s.l_xmfj008_desc
       LET sr[l_cnt].l_xmfj010_desc = sr_s.l_xmfj010_desc
       LET sr[l_cnt].l_xmfj001_desc = sr_s.l_xmfj001_desc
       LET sr[l_cnt].l_xmfj002_desc = sr_s.l_xmfj002_desc
       LET sr[l_cnt].l_xmfj019_desc = sr_s.l_xmfj019_desc
       LET sr[l_cnt].l_xmfl001_desc = sr_s.l_xmfl001_desc
       LET sr[l_cnt].l_xmfl002_desc1 = sr_s.l_xmfl002_desc1
       LET sr[l_cnt].l_xmfl002_desc2 = sr_s.l_xmfl002_desc2
       LET sr[l_cnt].l_xmfl002_desc3 = sr_s.l_xmfl002_desc3
       LET sr[l_cnt].l_xmfl005_desc = sr_s.l_xmfl005_desc
       LET sr[l_cnt].l_xmfl020_show = sr_s.l_xmfl020_show
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr430_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr430_g01_rep_data()
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
          START REPORT axmr430_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axmr430_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axmr430_g01_rep
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
 
{<section id="axmr430_g01.rep" readonly="Y" >}
PRIVATE REPORT axmr430_g01_rep(sr1)
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
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.xmfjdocno,sr1.xmflseq
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
        BEFORE GROUP OF sr1.xmfjdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xmfjdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xmfjent=' ,sr1.xmfjent,'{+}xmfjdocno=' ,sr1.xmfjdocno         
            CALL cl_gr_init_apr(sr1.xmfjdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xmfjdocno.before name="rep.b_group.xmfjdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xmfjent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfjdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr430_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axmr430_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axmr430_g01_subrep01
           DECLARE axmr430_g01_repcur01 CURSOR FROM g_sql
           FOREACH axmr430_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr430_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axmr430_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axmr430_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           START REPORT axmr430_g01_subrep05
              IF NOT cl_null(sr1.xmfjdocno) THEN
                 LET g_sql = "SELECT xmfkdocno,xmfk001,'',xmfk002,''",
                             "  FROM xmfk_t ",
                             " WHERE xmfkent   = '",sr1.xmfjent   CLIPPED,"'",
                             "   AND xmfkdocno = '",sr1.xmfjdocno CLIPPED,"'",
                             "   ORDER BY xmfkseq "
                                    
                 DECLARE axmr430_g01_repcur05 CURSOR FROM g_sql
                 FOREACH axmr430_g01_repcur05 INTO sr3.*
                 
                    CALL s_desc_get_trading_partner_abbr_desc(sr3.xmfk001)
                    RETURNING sr3.xmfk001_desc
                    
                    CALL s_desc_get_trading_partner_abbr_desc(sr3.xmfk002)
                    RETURNING sr3.xmfk002_desc
                    
                    OUTPUT TO REPORT axmr430_g01_subrep05(sr3.*)
                 END FOREACH 
              END IF
           FINISH REPORT axmr430_g01_subrep05
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xmfjdocno.after name="rep.b_group.xmfjdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xmflseq
 
           #add-point:rep.b_group.xmflseq.before name="rep.b_group.xmflseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xmflseq.after name="rep.b_group.xmflseq.after"
           
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
                sr1.xmfjent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfjdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmflseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr430_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axmr430_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axmr430_g01_subrep02
           DECLARE axmr430_g01_repcur02 CURSOR FROM g_sql
           FOREACH axmr430_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr430_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axmr430_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axmr430_g01_subrep02
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
                sr1.xmfjent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfjdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xmflseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr430_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axmr430_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axmr430_g01_subrep03
           DECLARE axmr430_g01_repcur03 CURSOR FROM g_sql
           FOREACH axmr430_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr430_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axmr430_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axmr430_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           START REPORT axmr430_g01_subrep06
              IF NOT cl_null(sr1.xmflseq) THEN
                 LET g_sql = "SELECT xmfmdocno,xmfm001,xmfm002,xmfm003,xmfm004",
                             "  FROM xmfm_t ",
                             " WHERE xmfment   = '",sr1.xmfjent   CLIPPED,"'",
                             "   AND xmfmdocno = '",sr1.xmfjdocno CLIPPED,"'",
                             "   AND xmfmseq = '",sr1.xmflseq,"'",
                             "   ORDER BY xmfm001 "
                                    
                 DECLARE axmr430_g01_repcur06 CURSOR FROM g_sql
                 FOREACH axmr430_g01_repcur06 INTO sr4.*
                 
                    OUTPUT TO REPORT axmr430_g01_subrep06(sr4.*)
                 END FOREACH 
              END IF
           FINISH REPORT axmr430_g01_subrep06
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmfjdocno
 
           #add-point:rep.a_group.xmfjdocno.before name="rep.a_group.xmfjdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xmfjent CLIPPED ,"'", " AND  ooff003 = '", sr1.xmfjdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axmr430_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axmr430_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axmr430_g01_subrep04
           DECLARE axmr430_g01_repcur04 CURSOR FROM g_sql
           FOREACH axmr430_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axmr430_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axmr430_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axmr430_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xmfjdocno.after name="rep.a_group.xmfjdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xmflseq
 
           #add-point:rep.a_group.xmflseq.before name="rep.a_group.xmflseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xmflseq.after name="rep.a_group.xmflseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axmr430_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axmr430_g01_subrep01(sr2)
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
PRIVATE REPORT axmr430_g01_subrep02(sr2)
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
PRIVATE REPORT axmr430_g01_subrep03(sr2)
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
PRIVATE REPORT axmr430_g01_subrep04(sr2)
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
 
{<section id="axmr430_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="axmr430_g01.other_report" readonly="Y" >}

PRIVATE REPORT axmr430_g01_subrep05(sr3)
   DEFINE sr3 sr3_r
   
   ORDER EXTERNAL BY sr3.xmfkdocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.*
END REPORT

PRIVATE REPORT axmr430_g01_subrep06(sr4)
   DEFINE sr4 sr4_r
   
   ORDER EXTERNAL BY sr4.xmfmdocno
   FORMAT
      ON EVERY ROW
          PRINTX g_grNumFmt.*
          PRINTX sr4.*
END REPORT

 
{</section>}
 
