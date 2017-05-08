#該程式未解開Section, 採用最新樣板產出!
{<section id="anmr310_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-02-16 14:42:54), PR版次:0004(2016-03-18 15:59:23)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: anmr310_g01
#+ Description: ...
#+ Creator....: 05016(2015-09-09 15:08:02)
#+ Modifier...: 02291 -SD/PR- 02291
 
{</section>}
 
{<section id="anmr310_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#150909-00006#2 　2015/10/05 By Hans   移除合計
#151016-00018#1   2015/10/19 By Jessy  增加存入/提出/借方/貸方合計
#160122-00001#27  2016/02/15 By yangtt 添加交易帳戶編號用戶權限空管 
#160122-00001#27  2016/03/16 By 07673  添加交易帳戶編號用戶權限空管,增加部门权限
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   l_nmaa005 LIKE nmaa_t.nmaa005, 
   l_nmbb003_desc LIKE type_t.chr100, 
   l_nmbb054_desc LIKE type_t.chr100, 
   l_nmbb002_desc LIKE type_t.chr100, 
   l_nmbb001_desc LIKE type_t.chr100, 
   l_nmbacomp_desc LIKE type_t.chr100, 
   l_nmbasite_desc LIKE type_t.chr100, 
   nmba002 LIKE nmba_t.nmba002, 
   nmba003 LIKE nmba_t.nmba003, 
   nmba004 LIKE nmba_t.nmba004, 
   nmba005 LIKE nmba_t.nmba005, 
   nmba006 LIKE nmba_t.nmba006, 
   nmba007 LIKE nmba_t.nmba007, 
   nmbacomp LIKE nmba_t.nmbacomp, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmbadocno LIKE nmba_t.nmbadocno, 
   nmbaent LIKE nmba_t.nmbaent, 
   nmbasite LIKE nmba_t.nmbasite, 
   nmbastus LIKE nmba_t.nmbastus, 
   nmbb001 LIKE nmbb_t.nmbb001, 
   nmbb002 LIKE nmbb_t.nmbb002, 
   nmbb003 LIKE nmbb_t.nmbb003, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb005 LIKE nmbb_t.nmbb005, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb007 LIKE nmbb_t.nmbb007, 
   nmbb008 LIKE nmbb_t.nmbb008, 
   nmbb009 LIKE nmbb_t.nmbb009, 
   nmbb010 LIKE nmbb_t.nmbb010, 
   nmbb011 LIKE nmbb_t.nmbb011, 
   nmbb012 LIKE nmbb_t.nmbb012, 
   nmbb013 LIKE nmbb_t.nmbb013, 
   nmbb014 LIKE nmbb_t.nmbb014, 
   nmbb015 LIKE nmbb_t.nmbb015, 
   nmbb016 LIKE nmbb_t.nmbb016, 
   nmbb017 LIKE nmbb_t.nmbb017, 
   nmbb018 LIKE nmbb_t.nmbb018, 
   nmbb019 LIKE nmbb_t.nmbb019, 
   nmbb020 LIKE nmbb_t.nmbb020, 
   nmbb021 LIKE nmbb_t.nmbb021, 
   nmbb022 LIKE nmbb_t.nmbb022, 
   nmbb023 LIKE nmbb_t.nmbb023, 
   nmbb024 LIKE nmbb_t.nmbb024, 
   nmbb025 LIKE nmbb_t.nmbb025, 
   nmbb026 LIKE nmbb_t.nmbb026, 
   nmbb027 LIKE nmbb_t.nmbb027, 
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbb053 LIKE nmbb_t.nmbb053, 
   nmbb054 LIKE nmbb_t.nmbb054, 
   nmbb056 LIKE nmbb_t.nmbb056, 
   nmbb057 LIKE nmbb_t.nmbb057, 
   nmbb058 LIKE nmbb_t.nmbb058, 
   nmbb059 LIKE nmbb_t.nmbb059, 
   nmbb060 LIKE nmbb_t.nmbb060, 
   nmbb061 LIKE nmbb_t.nmbb061, 
   nmbb062 LIKE nmbb_t.nmbb062, 
   nmbb066 LIKE nmbb_t.nmbb066, 
   nmbb067 LIKE nmbb_t.nmbb067, 
   nmbb068 LIKE nmbb_t.nmbb068, 
   nmbblegl LIKE nmbb_t.nmbblegl, 
   nmbborga LIKE nmbb_t.nmbborga, 
   nmbbseq LIKE nmbb_t.nmbbseq
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
DEFINE g_sql_bank      STRING                  #160122-00001#27 by 07673 
#end add-point
 
{</section>}
 
{<section id="anmr310_g01.main" readonly="Y" >}
PUBLIC FUNCTION anmr310_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #160122-00001#27 by 07673--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#27 by 07673--add--end
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "anmr310_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL anmr310_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL anmr310_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL anmr310_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmr310_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmr310_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT '','','','','','','',nmba002,nmba003,nmba004,nmba005,nmba006,nmba007,nmbacomp, 
       nmbadocdt,nmbadocno,nmbaent,nmbasite,nmbastus,nmbb001,nmbb002,nmbb003,nmbb004,nmbb005,nmbb006, 
       nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018, 
       nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,nmbb027,nmbb029,nmbb053,nmbb054, 
       nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068,nmbblegl,nmbborga, 
       nmbbseq"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM  nmba_t  LEFT OUTER JOIN ( SELECT nmbb_t.* FROM nmbb_t  ) x  ON nmba_t.nmbaent  
        = x.nmbbent AND nmba_t.nmbacomp = x.nmbbcomp AND nmba_t.nmbadocno = x.nmbbdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #160122-00001#27 by 07673--modify---str
   LET g_where = g_where CLIPPED," AND (x.nmbb003 IN(",g_sql_bank,") OR TRIM(x.nmbb003) IS NULL)" 
   #160122-00001#27 by 07673--modify---end
   #end add-point
    LET g_order = " ORDER BY nmbadocno,nmbbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE anmr310_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE anmr310_g01_curs CURSOR FOR anmr310_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmr310_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmr310_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_nmaa005 LIKE nmaa_t.nmaa005, 
   l_nmbb003_desc LIKE type_t.chr100, 
   l_nmbb054_desc LIKE type_t.chr100, 
   l_nmbb002_desc LIKE type_t.chr100, 
   l_nmbb001_desc LIKE type_t.chr100, 
   l_nmbacomp_desc LIKE type_t.chr100, 
   l_nmbasite_desc LIKE type_t.chr100, 
   nmba002 LIKE nmba_t.nmba002, 
   nmba003 LIKE nmba_t.nmba003, 
   nmba004 LIKE nmba_t.nmba004, 
   nmba005 LIKE nmba_t.nmba005, 
   nmba006 LIKE nmba_t.nmba006, 
   nmba007 LIKE nmba_t.nmba007, 
   nmbacomp LIKE nmba_t.nmbacomp, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmbadocno LIKE nmba_t.nmbadocno, 
   nmbaent LIKE nmba_t.nmbaent, 
   nmbasite LIKE nmba_t.nmbasite, 
   nmbastus LIKE nmba_t.nmbastus, 
   nmbb001 LIKE nmbb_t.nmbb001, 
   nmbb002 LIKE nmbb_t.nmbb002, 
   nmbb003 LIKE nmbb_t.nmbb003, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb005 LIKE nmbb_t.nmbb005, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb007 LIKE nmbb_t.nmbb007, 
   nmbb008 LIKE nmbb_t.nmbb008, 
   nmbb009 LIKE nmbb_t.nmbb009, 
   nmbb010 LIKE nmbb_t.nmbb010, 
   nmbb011 LIKE nmbb_t.nmbb011, 
   nmbb012 LIKE nmbb_t.nmbb012, 
   nmbb013 LIKE nmbb_t.nmbb013, 
   nmbb014 LIKE nmbb_t.nmbb014, 
   nmbb015 LIKE nmbb_t.nmbb015, 
   nmbb016 LIKE nmbb_t.nmbb016, 
   nmbb017 LIKE nmbb_t.nmbb017, 
   nmbb018 LIKE nmbb_t.nmbb018, 
   nmbb019 LIKE nmbb_t.nmbb019, 
   nmbb020 LIKE nmbb_t.nmbb020, 
   nmbb021 LIKE nmbb_t.nmbb021, 
   nmbb022 LIKE nmbb_t.nmbb022, 
   nmbb023 LIKE nmbb_t.nmbb023, 
   nmbb024 LIKE nmbb_t.nmbb024, 
   nmbb025 LIKE nmbb_t.nmbb025, 
   nmbb026 LIKE nmbb_t.nmbb026, 
   nmbb027 LIKE nmbb_t.nmbb027, 
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbb053 LIKE nmbb_t.nmbb053, 
   nmbb054 LIKE nmbb_t.nmbb054, 
   nmbb056 LIKE nmbb_t.nmbb056, 
   nmbb057 LIKE nmbb_t.nmbb057, 
   nmbb058 LIKE nmbb_t.nmbb058, 
   nmbb059 LIKE nmbb_t.nmbb059, 
   nmbb060 LIKE nmbb_t.nmbb060, 
   nmbb061 LIKE nmbb_t.nmbb061, 
   nmbb062 LIKE nmbb_t.nmbb062, 
   nmbb066 LIKE nmbb_t.nmbb066, 
   nmbb067 LIKE nmbb_t.nmbb067, 
   nmbb068 LIKE nmbb_t.nmbb068, 
   nmbblegl LIKE nmbb_t.nmbblegl, 
   nmbborga LIKE nmbb_t.nmbborga, 
   nmbbseq LIKE nmbb_t.nmbbseq
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
    FOREACH anmr310_g01_curs INTO sr_s.*
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
       #組織
       LET sr_s.l_nmbasite_desc = s_desc_get_department_desc(sr_s.nmbasite)
       IF NOT cl_null(sr_s.l_nmbasite_desc) THEN
          LET sr_s.l_nmbasite_desc = sr_s.nmbasite,'.',sr_s.l_nmbasite_desc
       ELSE
          LET sr_s.l_nmbasite_desc = sr_s.nmbasite
       END IF
       #法人
       LET sr_s.l_nmbacomp_desc = s_desc_get_department_desc(sr_s.nmbacomp)
       IF NOT cl_null(sr_s.l_nmbacomp_desc) THEN
          LET sr_s.l_nmbacomp_desc = sr_s.nmbacomp,'.',sr_s.l_nmbacomp_desc
       ELSE
          LET sr_s.l_nmbacomp_desc = sr_s.nmbacomp
       END IF
       #異動別
       LET sr_s.l_nmbb001_desc = s_desc_gzcbl004_desc('8701',sr_s.nmbb001)
       IF NOT cl_null(sr_s.l_nmbb001_desc) THEN
          LET sr_s.l_nmbb001_desc = sr_s.nmbb001,'.',sr_s.l_nmbb001_desc
       ELSE
          LET sr_s.l_nmbb001_desc = sr_s.nmbb001
       END IF
       #存提碼
       LET sr_s.l_nmbb002_desc = s_desc_get_nmajl003_desc(sr_s.nmbb002)
       IF NOT cl_null(sr_s.l_nmbb002_desc) THEN
          LET sr_s.l_nmbb002_desc = sr_s.nmbb002,'.',sr_s.l_nmbb002_desc
       ELSE
          LET sr_s.l_nmbb002_desc = sr_s.nmbb002   
       END IF
       #繳款部門
       LET sr_s.l_nmbb054_desc = s_desc_get_department_desc(sr_s.nmbb054)
       IF NOT cl_null(sr_s.l_nmbb054_desc) THEN
          LET sr_s.l_nmbb054_desc = sr_s.nmbb054,'.',sr_s.l_nmbb054_desc
       ELSE
          LET sr_s.l_nmbb054_desc = sr_s.nmbb054   
       END IF
       #交易帳戶
       LET sr_s.l_nmbb003_desc = s_desc_get_nmas002_desc(sr_s.nmbb003)
       IF NOT cl_null(sr_s.l_nmbb003_desc) THEN
          LET sr_s.l_nmbb003_desc = sr_s.nmbb003,'.',sr_s.l_nmbb003_desc
       ELSE
          LET sr_s.l_nmbb003_desc = sr_s.nmbb003   
       END IF
       
       #151012-00014#5 151016 by lori add---(S)
       #銀行帳號
       SELECT nmaa005 INTO sr_s.l_nmaa005
         FROM nmas_t,nmaa_t
        WHERE nmasent = nmaaent
          AND nmas001 = nmaa001
          AND nmasent = g_enterprise          
          AND nmas002 = sr_s.nmbb003
       #151012-00014#5 151016 by lori add---(S)
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
        
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_nmaa005 = sr_s.l_nmaa005
       LET sr[l_cnt].l_nmbb003_desc = sr_s.l_nmbb003_desc
       LET sr[l_cnt].l_nmbb054_desc = sr_s.l_nmbb054_desc
       LET sr[l_cnt].l_nmbb002_desc = sr_s.l_nmbb002_desc
       LET sr[l_cnt].l_nmbb001_desc = sr_s.l_nmbb001_desc
       LET sr[l_cnt].l_nmbacomp_desc = sr_s.l_nmbacomp_desc
       LET sr[l_cnt].l_nmbasite_desc = sr_s.l_nmbasite_desc
       LET sr[l_cnt].nmba002 = sr_s.nmba002
       LET sr[l_cnt].nmba003 = sr_s.nmba003
       LET sr[l_cnt].nmba004 = sr_s.nmba004
       LET sr[l_cnt].nmba005 = sr_s.nmba005
       LET sr[l_cnt].nmba006 = sr_s.nmba006
       LET sr[l_cnt].nmba007 = sr_s.nmba007
       LET sr[l_cnt].nmbacomp = sr_s.nmbacomp
       LET sr[l_cnt].nmbadocdt = sr_s.nmbadocdt
       LET sr[l_cnt].nmbadocno = sr_s.nmbadocno
       LET sr[l_cnt].nmbaent = sr_s.nmbaent
       LET sr[l_cnt].nmbasite = sr_s.nmbasite
       LET sr[l_cnt].nmbastus = sr_s.nmbastus
       LET sr[l_cnt].nmbb001 = sr_s.nmbb001
       LET sr[l_cnt].nmbb002 = sr_s.nmbb002
       LET sr[l_cnt].nmbb003 = sr_s.nmbb003
       LET sr[l_cnt].nmbb004 = sr_s.nmbb004
       LET sr[l_cnt].nmbb005 = sr_s.nmbb005
       LET sr[l_cnt].nmbb006 = sr_s.nmbb006
       LET sr[l_cnt].nmbb007 = sr_s.nmbb007
       LET sr[l_cnt].nmbb008 = sr_s.nmbb008
       LET sr[l_cnt].nmbb009 = sr_s.nmbb009
       LET sr[l_cnt].nmbb010 = sr_s.nmbb010
       LET sr[l_cnt].nmbb011 = sr_s.nmbb011
       LET sr[l_cnt].nmbb012 = sr_s.nmbb012
       LET sr[l_cnt].nmbb013 = sr_s.nmbb013
       LET sr[l_cnt].nmbb014 = sr_s.nmbb014
       LET sr[l_cnt].nmbb015 = sr_s.nmbb015
       LET sr[l_cnt].nmbb016 = sr_s.nmbb016
       LET sr[l_cnt].nmbb017 = sr_s.nmbb017
       LET sr[l_cnt].nmbb018 = sr_s.nmbb018
       LET sr[l_cnt].nmbb019 = sr_s.nmbb019
       LET sr[l_cnt].nmbb020 = sr_s.nmbb020
       LET sr[l_cnt].nmbb021 = sr_s.nmbb021
       LET sr[l_cnt].nmbb022 = sr_s.nmbb022
       LET sr[l_cnt].nmbb023 = sr_s.nmbb023
       LET sr[l_cnt].nmbb024 = sr_s.nmbb024
       LET sr[l_cnt].nmbb025 = sr_s.nmbb025
       LET sr[l_cnt].nmbb026 = sr_s.nmbb026
       LET sr[l_cnt].nmbb027 = sr_s.nmbb027
       LET sr[l_cnt].nmbb029 = sr_s.nmbb029
       LET sr[l_cnt].nmbb053 = sr_s.nmbb053
       LET sr[l_cnt].nmbb054 = sr_s.nmbb054
       LET sr[l_cnt].nmbb056 = sr_s.nmbb056
       LET sr[l_cnt].nmbb057 = sr_s.nmbb057
       LET sr[l_cnt].nmbb058 = sr_s.nmbb058
       LET sr[l_cnt].nmbb059 = sr_s.nmbb059
       LET sr[l_cnt].nmbb060 = sr_s.nmbb060
       LET sr[l_cnt].nmbb061 = sr_s.nmbb061
       LET sr[l_cnt].nmbb062 = sr_s.nmbb062
       LET sr[l_cnt].nmbb066 = sr_s.nmbb066
       LET sr[l_cnt].nmbb067 = sr_s.nmbb067
       LET sr[l_cnt].nmbb068 = sr_s.nmbb068
       LET sr[l_cnt].nmbblegl = sr_s.nmbblegl
       LET sr[l_cnt].nmbborga = sr_s.nmbborga
       LET sr[l_cnt].nmbbseq = sr_s.nmbbseq
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmr310_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmr310_g01_rep_data()
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
          START REPORT anmr310_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT anmr310_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT anmr310_g01_rep
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
 
{<section id="anmr310_g01.rep" readonly="Y" >}
PRIVATE REPORT anmr310_g01_rep(sr1)
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
DEFINE l_nmbb007_sum       LIKE nmbb_t.nmbb007
DEFINE l_nmbb007_sum_show  LIKE type_t.chr1

#151016-00018#1-----s
DEFINE l_nmbb006_1         LIKE nmbb_t.nmbb007
DEFINE l_nmbb007_1         LIKE nmbb_t.nmbb007
DEFINE l_nmbb006_2         LIKE nmbb_t.nmbb007
DEFINE l_nmbb007_2         LIKE nmbb_t.nmbb007
DEFINE l_nmbb006_3         LIKE nmbb_t.nmbb007
DEFINE l_nmbb007_3         LIKE nmbb_t.nmbb007
DEFINE l_nmbb006_4         LIKE nmbb_t.nmbb007
DEFINE l_nmbb007_4         LIKE nmbb_t.nmbb007
#151016-00018#1-----e
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.nmbadocno,sr1.nmbbseq
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
        BEFORE GROUP OF sr1.nmbadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.nmbadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'nmbaent=' ,sr1.nmbaent,'{+}nmbacomp=' ,sr1.nmbacomp,'{+}nmbadocno=' ,sr1.nmbadocno         
            CALL cl_gr_init_apr(sr1.nmbadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.nmbadocno.before name="rep.b_group.nmbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.nmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmbadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr310_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE anmr310_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT anmr310_g01_subrep01
           DECLARE anmr310_g01_repcur01 CURSOR FROM g_sql
           FOREACH anmr310_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr310_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT anmr310_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT anmr310_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.nmbadocno.after name="rep.b_group.nmbadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.nmbbseq
 
           #add-point:rep.b_group.nmbbseq.before name="rep.b_group.nmbbseq.before"
  
           #end add-point:
 
 
           #add-point:rep.b_group.nmbbseq.after name="rep.b_group.nmbbseq.after"
           
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
                sr1.nmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.nmbbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr310_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE anmr310_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT anmr310_g01_subrep02
           DECLARE anmr310_g01_repcur02 CURSOR FROM g_sql
           FOREACH anmr310_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr310_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT anmr310_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT anmr310_g01_subrep02
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
                sr1.nmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.nmbbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr310_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE anmr310_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT anmr310_g01_subrep03
           DECLARE anmr310_g01_repcur03 CURSOR FROM g_sql
           FOREACH anmr310_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr310_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT anmr310_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT anmr310_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.nmbadocno
 
           #add-point:rep.a_group.nmbadocno.before name="rep.a_group.nmbadocno.before"
           LET l_nmbb007_sum_show = 'Y' #150909-00006#2 ---mark---  #151016-00018#1 取消mark
           #LET l_nmbb007_sum_show = 'N'  #150909-00006#2           #151016-00018#1 mark
           IF cl_null(sr1.nmbbseq) THEN
              LET l_nmbb007_sum_show = 'N'
           END IF                                          
           #LET l_nmbb007_sum = GROUP SUM(sr1.nmbb007)              #151016-00018#1 mark
           #PRINTX l_nmbb007_sum                                    #151016-00018#1 mark
           PRINTX l_nmbb007_sum_show 
           
           #151016-00018#1-----s
           #存入
           SELECT SUM(nmbb006),SUM(nmbb007) INTO l_nmbb006_1,l_nmbb007_1 
             FROM nmbb_t
            WHERE nmbbent = g_enterprise AND nmbbdocno = sr1.nmbadocno AND nmbbcomp = sr1.nmbacomp AND nmbb001 = '1'
           IF cl_null(l_nmbb006_1) THEN LET l_nmbb006_1 = 0 END IF
           IF cl_null(l_nmbb007_1) THEN LET l_nmbb007_1 = 0 END IF
           
           #提出
           SELECT SUM(nmbb006),SUM(nmbb007) INTO l_nmbb006_2,l_nmbb007_2
             FROM nmbb_t
            WHERE nmbbent = g_enterprise AND nmbbdocno = sr1.nmbadocno AND nmbbcomp = sr1.nmbacomp AND nmbb001 = '2'
           IF cl_null(l_nmbb006_2) THEN LET l_nmbb006_2 = 0 END IF
           IF cl_null(l_nmbb007_2) THEN LET l_nmbb007_2 = 0 END IF

           #借方
           SELECT SUM(nmbb006),SUM(nmbb007) INTO l_nmbb006_3,l_nmbb007_3
             FROM nmbb_t
            WHERE nmbbent = g_enterprise AND nmbbdocno = sr1.nmbadocno AND nmbbcomp = sr1.nmbacomp AND nmbb001 = '3'
           IF cl_null(l_nmbb006_3) THEN LET l_nmbb006_3 = 0 END IF
           IF cl_null(l_nmbb007_3) THEN LET l_nmbb007_3 = 0 END IF

           #貸方
           SELECT SUM(nmbb006),SUM(nmbb007) INTO l_nmbb006_4,l_nmbb007_4
             FROM nmbb_t
            WHERE nmbbent = g_enterprise AND nmbbdocno = sr1.nmbadocno AND nmbbcomp = sr1.nmbacomp AND nmbb001 = '4'
           IF cl_null(l_nmbb006_4) THEN LET l_nmbb006_4 = 0 END IF
           IF cl_null(l_nmbb007_4) THEN LET l_nmbb007_4 = 0 END IF
           
           PRINTX l_nmbb006_1,l_nmbb007_1,l_nmbb006_2,l_nmbb007_2,l_nmbb006_3,l_nmbb007_3,l_nmbb006_4,l_nmbb007_4
           #151016-00018#1-----e
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.nmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmbadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr310_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE anmr310_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT anmr310_g01_subrep04
           DECLARE anmr310_g01_repcur04 CURSOR FROM g_sql
           FOREACH anmr310_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr310_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT anmr310_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT anmr310_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.nmbadocno.after name="rep.a_group.nmbadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.nmbbseq
 
           #add-point:rep.a_group.nmbbseq.before name="rep.a_group.nmbbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.nmbbseq.after name="rep.a_group.nmbbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="anmr310_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT anmr310_g01_subrep01(sr2)
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
PRIVATE REPORT anmr310_g01_subrep02(sr2)
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
PRIVATE REPORT anmr310_g01_subrep03(sr2)
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
PRIVATE REPORT anmr310_g01_subrep04(sr2)
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
 
{<section id="anmr310_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="anmr310_g01.other_report" readonly="Y" >}

 
{</section>}
 
