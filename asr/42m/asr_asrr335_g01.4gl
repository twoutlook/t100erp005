#該程式未解開Section, 採用最新樣板產出!
{<section id="asrr335_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-12-09 14:35:44), PR版次:0002(2016-12-09 18:11:04)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: asrr335_g01
#+ Description: ...
#+ Creator....: 05423(2015-01-26 16:47:17)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="asrr335_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161128-00014#1      2016/12/09  By zhujing     单头添加报工类别
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
   sffadocno LIKE sffa_t.sffadocno, 
   sffadocdt LIKE sffa_t.sffadocdt, 
   sffa005 LIKE sffa_t.sffa005, 
   l_sffa005_desc LIKE oocql_t.oocql004, 
   l_sffa005_show LIKE type_t.chr2, 
   sffa002 LIKE sffa_t.sffa002, 
   l_sffa002_desc LIKE ooag_t.ooag011, 
   sffa003 LIKE sffa_t.sffa003, 
   l_sffa003_desc LIKE ooefl_t.ooefl004, 
   sffa004 LIKE sffa_t.sffa004, 
   l_sffa004_desc LIKE oogd_t.oogd002, 
   sffa006 LIKE sffa_t.sffa006, 
   l_sffa006_desc LIKE ooge_t.ooge002, 
   sffa001 LIKE sffa_t.sffa001, 
   sffaent LIKE sffa_t.sffaent, 
   sffbseq LIKE sffb_t.sffbseq, 
   sffb025 LIKE sffb_t.sffb025, 
   l_sffb025_desc LIKE srza_t.srza002, 
   sffb023 LIKE sffb_t.sffb023, 
   l_sffb023_show LIKE type_t.chr2, 
   sffb026 LIKE sffb_t.sffb026, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   sffb027 LIKE sffb_t.sffb027, 
   sffb028 LIKE sffb_t.sffb028, 
   sffb007 LIKE sffb_t.sffb007, 
   l_sffb007_desc LIKE oocql_t.oocql004, 
   sffb009 LIKE sffb_t.sffb009, 
   l_sffb009_desc LIKE ecaa_t.ecaa002, 
   sffb010 LIKE sffb_t.sffb010, 
   l_sffb010_desc LIKE mrba_t.mrba005, 
   sffb008 LIKE sffb_t.sffb008, 
   l_qty LIKE sffb_t.sffb017, 
   sffb017 LIKE sffb_t.sffb017, 
   sffb018 LIKE sffb_t.sffb018, 
   sffb019 LIKE sffb_t.sffb019, 
   sffb012 LIKE sffb_t.sffb012, 
   sffb013 LIKE sffb_t.sffb013, 
   sffb011 LIKE sffb_t.sffb011, 
   sffb014 LIKE sffb_t.sffb014, 
   sffb015 LIKE sffb_t.sffb015, 
   sffb001 LIKE sffb_t.sffb001, 
   l_sffb001 LIKE oocql_t.oocql004
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

#end add-point
 
{</section>}
 
{<section id="asrr335_g01.main" readonly="Y" >}
PUBLIC FUNCTION asrr335_g01(p_arg1)
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
   
   LET g_rep_code = "asrr335_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asrr335_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asrr335_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asrr335_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asrr335_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asrr335_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT sffbdocno,sffbdocdt,sffb005,NULL,'N',sffb002,NULL,sffb003,NULL,sffb004,NULL, 
       sffb006,NULL,sffb001,sffbent,sffbseq,sffb025,srza002,sffb023,'N',sffb026,imaal003,imaal004,sffb027,sffb028, 
       sffb007,NULL,sffb009,NULL,sffb010,NULL,sffb008,NULL,sffb017,sffb018,sffb019,sffb012,sffb013,sffb011, 
       sffb014,sffb015,",
       #161128-00014#1 add-S
       "sffb001,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4021' AND gzcbl002 = sffb001 AND gzcbl003 = '",g_dlang,"') gzcbl004 "
       #161128-00014#1 add-E
#   #end add-point
#   LET g_select = " SELECT sffadocno,sffadocdt,sffa005,NULL,'',sffa002,NULL,sffa003,NULL,sffa004,NULL, 
#       sffa006,NULL,sffa001,sffaent,sffbseq,sffb025,NULL,sffb023,'',sffb026,NULL,NULL,sffb027,sffb028, 
#       sffb007,NULL,sffb009,NULL,sffb010,NULL,sffb008,NULL,sffb017,sffb018,sffb019,sffb012,sffb013,sffb011, 
#       sffb014,sffb015,sffb001,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM sffb_t ",#LEFT OUTER JOIN sffb_t ON sffadocno = sffbdocno AND sffaent = sffbent AND sffasite = sffbsite ",
                 "             LEFT OUTER JOIN srza_t ON sffb025 = srza001 AND sffbent = srzaent AND sffbsite = srzasite ",
                 "             LEFT OUTER JOIN imaal_t ON sffb026 = imaal001 AND sffbent = imaalent AND imaal002 = '",g_dlang,"' " 
#   #end add-point
#    LET g_from = " FROM sffa_t,sffb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   #161128-00014#1 add-S
   LET g_where = " WHERE sffb001 IN ('11','12','13','14','15') AND " ,tm.wc CLIPPED 
   #161128-00014#1 add-E
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY sffbdocno,sffb025"
#   #end add-point
#    LET g_order = " ORDER BY sffadocno,sffb025"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sffa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asrr335_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asrr335_g01_curs CURSOR FOR asrr335_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asrr335_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asrr335_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sffadocno LIKE sffa_t.sffadocno, 
   sffadocdt LIKE sffa_t.sffadocdt, 
   sffa005 LIKE sffa_t.sffa005, 
   l_sffa005_desc LIKE oocql_t.oocql004, 
   l_sffa005_show LIKE type_t.chr2, 
   sffa002 LIKE sffa_t.sffa002, 
   l_sffa002_desc LIKE ooag_t.ooag011, 
   sffa003 LIKE sffa_t.sffa003, 
   l_sffa003_desc LIKE ooefl_t.ooefl004, 
   sffa004 LIKE sffa_t.sffa004, 
   l_sffa004_desc LIKE oogd_t.oogd002, 
   sffa006 LIKE sffa_t.sffa006, 
   l_sffa006_desc LIKE ooge_t.ooge002, 
   sffa001 LIKE sffa_t.sffa001, 
   sffaent LIKE sffa_t.sffaent, 
   sffbseq LIKE sffb_t.sffbseq, 
   sffb025 LIKE sffb_t.sffb025, 
   l_sffb025_desc LIKE srza_t.srza002, 
   sffb023 LIKE sffb_t.sffb023, 
   l_sffb023_show LIKE type_t.chr2, 
   sffb026 LIKE sffb_t.sffb026, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   sffb027 LIKE sffb_t.sffb027, 
   sffb028 LIKE sffb_t.sffb028, 
   sffb007 LIKE sffb_t.sffb007, 
   l_sffb007_desc LIKE oocql_t.oocql004, 
   sffb009 LIKE sffb_t.sffb009, 
   l_sffb009_desc LIKE ecaa_t.ecaa002, 
   sffb010 LIKE sffb_t.sffb010, 
   l_sffb010_desc LIKE mrba_t.mrba005, 
   sffb008 LIKE sffb_t.sffb008, 
   l_qty LIKE sffb_t.sffb017, 
   sffb017 LIKE sffb_t.sffb017, 
   sffb018 LIKE sffb_t.sffb018, 
   sffb019 LIKE sffb_t.sffb019, 
   sffb012 LIKE sffb_t.sffb012, 
   sffb013 LIKE sffb_t.sffb013, 
   sffb011 LIKE sffb_t.sffb011, 
   sffb014 LIKE sffb_t.sffb014, 
   sffb015 LIKE sffb_t.sffb015, 
   sffb001 LIKE sffb_t.sffb001, 
   l_sffb001 LIKE oocql_t.oocql004
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_ret      LIKE type_t.chr20
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asrr335_g01_curs INTO sr_s.*
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
       #获取说明
       #161128-00014#1 add-S
       IF NOT cl_null(sr_s.l_sffb001) THEN
          LET sr_s.l_sffb001 = sr_s.sffb001 CLIPPED,'.',sr_s.l_sffb001 CLIPPED
       ELSE
          LET sr_s.l_sffb001 = sr_s.sffb001 CLIPPED
       END IF
       #161128-00014#1 add-E
       #作业编号 sffa005
       IF NOT cl_null(sr_s.sffa005) THEN
         LET sr_s.l_sffa005_show = 'Y'
         CALL asrr335_g01_desc('2','221',sr_s.sffa005) RETURNING sr_s.l_sffa005_desc
         LET sr_s.l_sffa005_desc = sr_s.sffa005 CLIPPED,'.',sr_s.l_sffa005_desc
       END IF
       #报工人员 sffa002
       IF NOT cl_null(sr_s.sffa002) THEN
         CALL asrr335_g01_desc('7','',sr_s.sffa002) RETURNING sr_s.l_sffa002_desc
         LET sr_s.l_sffa002_desc = sr_s.sffa002 CLIPPED,'.',sr_s.l_sffa002_desc
       END IF
       #报工部门 sffa003
       IF NOT cl_null(sr_s.sffa003) THEN
         CALL asrr335_g01_desc('8','',sr_s.sffa003) RETURNING sr_s.l_sffa003_desc
         LET sr_s.l_sffa003_desc = sr_s.sffa003 CLIPPED,'.',sr_s.l_sffa003_desc
       END IF
       #报工班别 sffa004
       IF NOT cl_null(sr_s.sffa004) THEN
         CALL asrr335_g01_desc('4','',sr_s.sffa004) RETURNING sr_s.l_sffa004_desc
         LET sr_s.l_sffa004_desc = sr_s.sffa004 CLIPPED,'.',sr_s.l_sffa004_desc
       END IF
       #报工组别 sffa006
       IF NOT cl_null(sr_s.sffa006) THEN
         CALL asrr335_g01_desc('5','',sr_s.sffa006) RETURNING sr_s.l_sffa006_desc
         LET sr_s.l_sffa006_desc = sr_s.sffa006 CLIPPED,'.',sr_s.l_sffa006_desc
       END IF
       #作业编号 sffb007
       IF NOT cl_null(sr_s.sffb007) THEN
         CALL asrr335_g01_desc('2','221',sr_s.sffb007) RETURNING sr_s.l_sffb007_desc
         LET sr_s.l_sffb007_desc = sr_s.sffb007 CLIPPED,'.',sr_s.l_sffb007_desc
       END IF
       #工作站 sffb009
       IF NOT cl_null(sr_s.sffb009) THEN
         CALL asrr335_g01_desc('3','',sr_s.sffb009) RETURNING sr_s.l_sffb009_desc
         LET sr_s.l_sffb009_desc = sr_s.sffb009 CLIPPED,'.',sr_s.l_sffb009_desc
       END IF
       #机器 sffb010
       IF NOT cl_null(sr_s.sffb010) THEN
         CALL asrr335_g01_desc('6','',sr_s.sffb010) RETURNING sr_s.l_sffb010_desc
         LET sr_s.l_sffb010_desc = sr_s.sffb010 CLIPPED,'.',sr_s.l_sffb010_desc
       END IF
       
       #备注是否列印 sffb023
       IF NOT cl_null(sr_s.sffb023) THEN
         LET sr_s.l_sffb023_show = 'Y'
       END IF
       #待处理数量 l_qty
       IF cl_null(sr_s.sffb025) AND cl_null(sr_s.sffb026) AND cl_null(sr_s.sffbseq) THEN
         LET sr_s.l_qty = NULL
       ELSE
         CALL s_asrt335_set_qty(sr_s.sffadocno,sr_s.sffbseq,sr_s.sffa001,sr_s.sffb025,sr_s.sffb026,sr_s.sffb027,sr_s.sffb028,sr_s.sffb007,sr_s.sffb008) RETURNING sr_s.l_qty,l_ret
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sffadocno = sr_s.sffadocno
       LET sr[l_cnt].sffadocdt = sr_s.sffadocdt
       LET sr[l_cnt].sffa005 = sr_s.sffa005
       LET sr[l_cnt].l_sffa005_desc = sr_s.l_sffa005_desc
       LET sr[l_cnt].l_sffa005_show = sr_s.l_sffa005_show
       LET sr[l_cnt].sffa002 = sr_s.sffa002
       LET sr[l_cnt].l_sffa002_desc = sr_s.l_sffa002_desc
       LET sr[l_cnt].sffa003 = sr_s.sffa003
       LET sr[l_cnt].l_sffa003_desc = sr_s.l_sffa003_desc
       LET sr[l_cnt].sffa004 = sr_s.sffa004
       LET sr[l_cnt].l_sffa004_desc = sr_s.l_sffa004_desc
       LET sr[l_cnt].sffa006 = sr_s.sffa006
       LET sr[l_cnt].l_sffa006_desc = sr_s.l_sffa006_desc
       LET sr[l_cnt].sffa001 = sr_s.sffa001
       LET sr[l_cnt].sffaent = sr_s.sffaent
       LET sr[l_cnt].sffbseq = sr_s.sffbseq
       LET sr[l_cnt].sffb025 = sr_s.sffb025
       LET sr[l_cnt].l_sffb025_desc = sr_s.l_sffb025_desc
       LET sr[l_cnt].sffb023 = sr_s.sffb023
       LET sr[l_cnt].l_sffb023_show = sr_s.l_sffb023_show
       LET sr[l_cnt].sffb026 = sr_s.sffb026
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].sffb027 = sr_s.sffb027
       LET sr[l_cnt].sffb028 = sr_s.sffb028
       LET sr[l_cnt].sffb007 = sr_s.sffb007
       LET sr[l_cnt].l_sffb007_desc = sr_s.l_sffb007_desc
       LET sr[l_cnt].sffb009 = sr_s.sffb009
       LET sr[l_cnt].l_sffb009_desc = sr_s.l_sffb009_desc
       LET sr[l_cnt].sffb010 = sr_s.sffb010
       LET sr[l_cnt].l_sffb010_desc = sr_s.l_sffb010_desc
       LET sr[l_cnt].sffb008 = sr_s.sffb008
       LET sr[l_cnt].l_qty = sr_s.l_qty
       LET sr[l_cnt].sffb017 = sr_s.sffb017
       LET sr[l_cnt].sffb018 = sr_s.sffb018
       LET sr[l_cnt].sffb019 = sr_s.sffb019
       LET sr[l_cnt].sffb012 = sr_s.sffb012
       LET sr[l_cnt].sffb013 = sr_s.sffb013
       LET sr[l_cnt].sffb011 = sr_s.sffb011
       LET sr[l_cnt].sffb014 = sr_s.sffb014
       LET sr[l_cnt].sffb015 = sr_s.sffb015
       LET sr[l_cnt].sffb001 = sr_s.sffb001
       LET sr[l_cnt].l_sffb001 = sr_s.l_sffb001
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asrr335_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asrr335_g01_rep_data()
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
          START REPORT asrr335_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asrr335_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asrr335_g01_rep
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
 
{<section id="asrr335_g01.rep" readonly="Y" >}
PRIVATE REPORT asrr335_g01_rep(sr1)
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

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.sffadocno,sr1.sffb025
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
        BEFORE GROUP OF sr1.sffadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sffadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sffaent=' ,sr1.sffaent,'{+}sffadocno=' ,sr1.sffadocno         
            CALL cl_gr_init_apr(sr1.sffadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sffadocno.before name="rep.b_group.sffadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sffaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr335_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asrr335_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asrr335_g01_subrep01
           DECLARE asrr335_g01_repcur01 CURSOR FROM g_sql
           FOREACH asrr335_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr335_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asrr335_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asrr335_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sffadocno.after name="rep.b_group.sffadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sffb025
 
           #add-point:rep.b_group.sffb025.before name="rep.b_group.sffb025.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sffb025.after name="rep.b_group.sffb025.after"
           
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
                sr1.sffaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.sffb025 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr335_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asrr335_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asrr335_g01_subrep02
           DECLARE asrr335_g01_repcur02 CURSOR FROM g_sql
           FOREACH asrr335_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr335_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asrr335_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asrr335_g01_subrep02
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
                sr1.sffaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.sffb025 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr335_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asrr335_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asrr335_g01_subrep03
           DECLARE asrr335_g01_repcur03 CURSOR FROM g_sql
           FOREACH asrr335_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr335_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asrr335_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asrr335_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sffadocno
 
           #add-point:rep.a_group.sffadocno.before name="rep.a_group.sffadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sffaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sffadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr335_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asrr335_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asrr335_g01_subrep04
           DECLARE asrr335_g01_repcur04 CURSOR FROM g_sql
           FOREACH asrr335_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr335_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asrr335_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asrr335_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sffadocno.after name="rep.a_group.sffadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sffb025
 
           #add-point:rep.a_group.sffb025.before name="rep.a_group.sffb025.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sffb025.after name="rep.a_group.sffb025.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asrr335_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asrr335_g01_subrep01(sr2)
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
PRIVATE REPORT asrr335_g01_subrep02(sr2)
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
PRIVATE REPORT asrr335_g01_subrep03(sr2)
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
PRIVATE REPORT asrr335_g01_subrep04(sr2)
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
 
{<section id="asrr335_g01.other_function" readonly="Y" >}

#GET DESC
PRIVATE FUNCTION asrr335_g01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
   WHEN '1' #获取SCC码说明
      SELECT gzcbl004 INTO r_desc
        FROM gzcbl_t
       WHERE gzcbl001 = p_num
         AND gzcbl002 = p_target
         AND gzcbl003 = g_dlang
         
   WHEN '2' #获取ACC码说明
      SELECT oocql004 INTO r_desc
        FROM oocql_t
       WHERE oocql001 = p_num
         AND oocql002 = p_target
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise

   WHEN '3' #获取工作站名称
      SELECT ecaa002 INTO r_desc
        FROM ecaa_t
       WHERE ecaa001 = p_target
         AND ecaasite = g_site
         AND ecaaent = g_enterprise
         
   WHEN '4' #获取报工班别名称
      SELECT oogd002 INTO r_desc
        FROM oogd_t
       WHERE oogd001 = p_target
         AND oogdsite = g_site
         AND oogdent = g_enterprise
         
   WHEN '5' #获取报工组别名称
      SELECT ooge002 INTO r_desc
        FROM ooge_t
       WHERE ooge001 = p_target
         AND oogesite = g_site
         AND oogeent = g_enterprise
         
   WHEN '6' #获取机器名称
      SELECT mrba005 INTO r_desc
        FROM mrba_t
       WHERE oogd001 = p_target
         AND mrba000 = '0'
         AND mrbasite = g_site
         AND mrbaent = g_enterprise
                  
   WHEN '7' #获取报工人员名称
      SELECT ooag011 INTO r_desc
        FROM ooag_t
       WHERE ooag001 = p_target
         AND ooagent = g_enterprise
   
   WHEN '8' #获取报工部门名称
      SELECT ooefl004 INTO r_desc
        FROM ooefl_t
       WHERE ooefl001 = p_target
         AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise         
         
   END CASE
   
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
{<section id="asrr335_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
