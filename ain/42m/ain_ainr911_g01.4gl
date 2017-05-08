#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr911_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-07-01 10:09:38), PR版次:0002(2016-07-01 11:08:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: ainr911_g01
#+ Description: ...
#+ Creator....: 06137(2015-02-12 09:50:17)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="ainr911_g01.global" readonly="Y" >}
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
   inba002 LIKE inba_t.inba002, 
   inba003 LIKE inba_t.inba003, 
   inba004 LIKE inba_t.inba004, 
   inba005 LIKE inba_t.inba005, 
   inba006 LIKE inba_t.inba006, 
   inba007 LIKE inba_t.inba007, 
   inba008 LIKE inba_t.inba008, 
   inbadocdt LIKE inba_t.inbadocdt, 
   inbadocno LIKE inba_t.inbadocno, 
   inbaent LIKE inba_t.inbaent, 
   inbasite LIKE inba_t.inbasite, 
   inbastus LIKE inba_t.inbastus, 
   inbb001 LIKE inbb_t.inbb001, 
   inbb002 LIKE inbb_t.inbb002, 
   inbb003 LIKE inbb_t.inbb003, 
   inbb004 LIKE inbb_t.inbb004, 
   inbb007 LIKE inbb_t.inbb007, 
   inbb008 LIKE inbb_t.inbb008, 
   inbb009 LIKE inbb_t.inbb009, 
   inbb010 LIKE inbb_t.inbb010, 
   inbb011 LIKE inbb_t.inbb011, 
   inbb012 LIKE inbb_t.inbb012, 
   inbb013 LIKE inbb_t.inbb013, 
   inbb014 LIKE inbb_t.inbb014, 
   inbb015 LIKE inbb_t.inbb015, 
   inbb016 LIKE inbb_t.inbb016, 
   inbb017 LIKE inbb_t.inbb017, 
   inbb018 LIKE inbb_t.inbb018, 
   inbb019 LIKE inbb_t.inbb019, 
   inbb020 LIKE inbb_t.inbb020, 
   inbb021 LIKE inbb_t.inbb021, 
   inbb022 LIKE inbb_t.inbb022, 
   inbbseq LIKE inbb_t.inbbseq, 
   inbbsite LIKE inbb_t.inbbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t2_imaal003 LIKE imaal_t.imaal003, 
   x_inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t1_oocal003 LIKE oocal_t.oocal003, 
   l_inba004_ooefl003 LIKE type_t.chr1000, 
   l_inba003_ooag011 LIKE type_t.chr300, 
   l_inbb007_inayl003 LIKE type_t.chr1000, 
   l_inbb016_desc LIKE type_t.chr200, 
   l_inbb008_inab003 LIKE type_t.chr200, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inbbdocno LIKE inbb_t.inbbdocno, 
   inbbent LIKE inbb_t.inbbent
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr1 STRING                   #print subrep01
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
   inbcdocno LIKE inbc_t.inbcdocno,
   l_inbc005_inayl003 LIKE type_t.chr30,              #庫位
   l_inbc006_inab003 LIKE type_t.chr30,              #儲位
   inbc007 LIKE inbc_t.inbc007,              #批號
   inbc003 LIKE inbc_t.inbc003,              #庫存管理特徵
   inbc010 LIKE inbc_t.inbc010,              #數量
   inbc009 LIKE inbc_t.inbc009               #單位

END RECORD
DEFINE g_inbb016_acc         LIKE gzcb_t.gzcb007
#end add-point
 
{</section>}
 
{<section id="ainr911_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr911_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr1  print subrep01
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "ainr911_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr911_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr911_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr911_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr911_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr911_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT inba002,inba003,inba004,inba005,inba006,inba007,inba008,inbadocdt,inbadocno, ",
                  "        inbaent,inbasite,inbastus,inbb001,inbb002,inbb003,inbb004,inbb007,inbb008,inbb009,inbb010,inbb011,  ",
                  "        inbb012,inbb013,inbb014,inbb015,inbb016,inbb017,inbb018,inbb019,inbb020,inbb021,inbb022,inbbseq,  ",
                  "        inbbsite,ooag_t.ooag011,ooefl_t.ooefl003,x.imaal_t_imaal003,x.t2_imaal003,x.inayl_t_inayl003,  ",
                  "        x.oocal_t_oocal003,x.t1_oocal003,trim(inba004)||'.'||trim(ooefl_t.ooefl003),trim(inba003)||'.'||trim(ooag_t.ooag011),  ",
                  #160420-00039#16 20160701 modify by beckxie---S
                  #"        trim(inbb007)||'.'||trim(x.inayl_t_inayl003),NULL,NULL,x.imaal_t_imaal004,inbbdocno,inbbent "
                  "        trim(inbb007)||'.'||trim(x.inayl_t_inayl003), ",
                  "        (SELECT oocql004 FROM oocql_t ",
                  "          WHERE oocqlent = ",g_enterprise,
                  "            AND oocql001 = (SELECT gzcb004 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint911') ",
                  "            AND oocql002 = inbb016 ",
                  "            AND oocql003 = '",g_dlang,"') ,",
                  "        CASE WHEN COALESCE(inbb008,' ') !=' ' THEN trim(inbb008)||'.'||(SELECT inab003 FROM inab_t ",
                  "          WHERE inabent  = ",g_enterprise,
                  "            AND inabsite = '",g_site,"' ",
                  "            AND inab001  = inbb007 ",
                  "            AND inab002  = inbb008 ) END , ",
                  "        x.imaal_t_imaal004,inbbdocno,inbbent "
                  #160420-00039#16 20160701 modify by beckxie---E
#   #end add-point
#   LET g_select = " SELECT inba002,inba003,inba004,inba005,inba006,inba007,inba008,inbadocdt,inbadocno, 
#       inbaent,inbasite,inbastus,inbb001,inbb002,inbb003,inbb004,inbb007,inbb008,inbb009,inbb010,inbb011, 
#       inbb012,inbb013,inbb014,inbb015,inbb016,inbb017,inbb018,inbb019,inbb020,inbb021,inbb022,inbbseq, 
#       inbbsite,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inba_t.inba003 AND ooag_t.ooagent = inba_t.inbaent), 
#       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inba_t.inba004 AND ooefl_t.ooeflent = inba_t.inbaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),x.imaal_t_imaal003,x.t2_imaal003,x.inayl_t_inayl003,x.oocal_t_oocal003,x.t1_oocal003, 
#       trim(inba004)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inba_t.inba004 AND ooefl_t.ooeflent = inba_t.inbaent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inba003)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inba_t.inba003 AND ooag_t.ooagent = inba_t.inbaent)), 
#       trim(inbb007)||'.'||trim(x.inayl_t_inayl003),NULL,NULL,x.imaal_t_imaal004,inbbdocno,inbbent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM inba_t LEFT OUTER JOIN ( SELECT inbb_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = inbb_t.inbb001 AND imaal_t.imaalent = inbb_t.inbbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal003 FROM imaal_t t2 WHERE t2.imaal001 = inbb_t.inbb004 AND t2.imaalent = inbb_t.inbbent AND t2.imaal002 = '" , 
        g_dlang,"'" ,") t2_imaal003,( SELECT inayl003 FROM inayl_t WHERE inayl_t.inayl001 = inbb_t.inbb007 AND inayl_t.inaylent = inbb_t.inbbent AND inayl_t.inayl002 = '" , 
        g_dlang,"'" ,") inayl_t_inayl003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = inbb_t.inbb010 AND oocal_t.oocalent = inbb_t.inbbent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t t1 WHERE t1.oocal001 = inbb_t.inbb013 AND t1.oocalent = inbb_t.inbbent AND t1.oocal002 = '" , 
        g_dlang,"'" ,") t1_oocal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = inbb_t.inbb001 AND imaal_t.imaalent = inbb_t.inbbent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004 FROM inbb_t ) x  ON inba_t.inbaent = x.inbbent AND inba_t.inbadocno  
        = x.inbbdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY inbadocno,inbbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr911_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr911_g01_curs CURSOR FOR ainr911_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr911_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr911_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inba002 LIKE inba_t.inba002, 
   inba003 LIKE inba_t.inba003, 
   inba004 LIKE inba_t.inba004, 
   inba005 LIKE inba_t.inba005, 
   inba006 LIKE inba_t.inba006, 
   inba007 LIKE inba_t.inba007, 
   inba008 LIKE inba_t.inba008, 
   inbadocdt LIKE inba_t.inbadocdt, 
   inbadocno LIKE inba_t.inbadocno, 
   inbaent LIKE inba_t.inbaent, 
   inbasite LIKE inba_t.inbasite, 
   inbastus LIKE inba_t.inbastus, 
   inbb001 LIKE inbb_t.inbb001, 
   inbb002 LIKE inbb_t.inbb002, 
   inbb003 LIKE inbb_t.inbb003, 
   inbb004 LIKE inbb_t.inbb004, 
   inbb007 LIKE inbb_t.inbb007, 
   inbb008 LIKE inbb_t.inbb008, 
   inbb009 LIKE inbb_t.inbb009, 
   inbb010 LIKE inbb_t.inbb010, 
   inbb011 LIKE inbb_t.inbb011, 
   inbb012 LIKE inbb_t.inbb012, 
   inbb013 LIKE inbb_t.inbb013, 
   inbb014 LIKE inbb_t.inbb014, 
   inbb015 LIKE inbb_t.inbb015, 
   inbb016 LIKE inbb_t.inbb016, 
   inbb017 LIKE inbb_t.inbb017, 
   inbb018 LIKE inbb_t.inbb018, 
   inbb019 LIKE inbb_t.inbb019, 
   inbb020 LIKE inbb_t.inbb020, 
   inbb021 LIKE inbb_t.inbb021, 
   inbb022 LIKE inbb_t.inbb022, 
   inbbseq LIKE inbb_t.inbbseq, 
   inbbsite LIKE inbb_t.inbbsite, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_t2_imaal003 LIKE imaal_t.imaal003, 
   x_inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t1_oocal003 LIKE oocal_t.oocal003, 
   l_inba004_ooefl003 LIKE type_t.chr1000, 
   l_inba003_ooag011 LIKE type_t.chr300, 
   l_inbb007_inayl003 LIKE type_t.chr1000, 
   l_inbb016_desc LIKE type_t.chr200, 
   l_inbb008_inab003 LIKE type_t.chr200, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inbbdocno LIKE inbb_t.inbbdocno, 
   inbbent LIKE inbb_t.inbbent
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_inayl003 LIKE inayl_t.inayl003
   DEFINE l_inab003  LIKE inab_t.inab003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ainr911_g01_curs INTO sr_s.*
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
       #160420-00039#16 20160701 mark by beckxie---S
       #理由碼(應用分類碼轉換)
       #LET g_inbb016_acc = ''
       ##抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
       #SELECT gzcb004 INTO g_inbb016_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint911'        
       #CALL s_desc_get_acc_desc(g_inbb016_acc,sr_s.inbb016) RETURNING sr_s.l_inbb016_desc
       ##儲位名稱及組合 
       #LET l_inab003 = ''
       #CALL s_desc_get_locator_desc(g_site,sr_s.inbb007,sr_s.inbb008) RETURNING l_inab003
       #LET sr_s.l_inbb008_inab003 = sr_s.inbb008 CLIPPED,'.',l_inab003 CLIPPED
       #160420-00039#16 20160701 mark by beckxie---E
       
       IF sr_s.l_inbb007_inayl003 = '.' THEN
         LET sr_s.l_inbb007_inayl003 = NULL
       END IF
       IF sr_s.l_inbb008_inab003 = '.' THEN
         LET sr_s.l_inbb008_inab003 = NULL
       END IF
       IF sr_s.inbb020 = ' ' THEN
         LET sr_s.inbb020 = NULL
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].inba002 = sr_s.inba002
       LET sr[l_cnt].inba003 = sr_s.inba003
       LET sr[l_cnt].inba004 = sr_s.inba004
       LET sr[l_cnt].inba005 = sr_s.inba005
       LET sr[l_cnt].inba006 = sr_s.inba006
       LET sr[l_cnt].inba007 = sr_s.inba007
       LET sr[l_cnt].inba008 = sr_s.inba008
       LET sr[l_cnt].inbadocdt = sr_s.inbadocdt
       LET sr[l_cnt].inbadocno = sr_s.inbadocno
       LET sr[l_cnt].inbaent = sr_s.inbaent
       LET sr[l_cnt].inbasite = sr_s.inbasite
       LET sr[l_cnt].inbastus = sr_s.inbastus
       LET sr[l_cnt].inbb001 = sr_s.inbb001
       LET sr[l_cnt].inbb002 = sr_s.inbb002
       LET sr[l_cnt].inbb003 = sr_s.inbb003
       LET sr[l_cnt].inbb004 = sr_s.inbb004
       LET sr[l_cnt].inbb007 = sr_s.inbb007
       LET sr[l_cnt].inbb008 = sr_s.inbb008
       LET sr[l_cnt].inbb009 = sr_s.inbb009
       LET sr[l_cnt].inbb010 = sr_s.inbb010
       LET sr[l_cnt].inbb011 = sr_s.inbb011
       LET sr[l_cnt].inbb012 = sr_s.inbb012
       LET sr[l_cnt].inbb013 = sr_s.inbb013
       LET sr[l_cnt].inbb014 = sr_s.inbb014
       LET sr[l_cnt].inbb015 = sr_s.inbb015
       LET sr[l_cnt].inbb016 = sr_s.inbb016
       LET sr[l_cnt].inbb017 = sr_s.inbb017
       LET sr[l_cnt].inbb018 = sr_s.inbb018
       LET sr[l_cnt].inbb019 = sr_s.inbb019
       LET sr[l_cnt].inbb020 = sr_s.inbb020
       LET sr[l_cnt].inbb021 = sr_s.inbb021
       LET sr[l_cnt].inbb022 = sr_s.inbb022
       LET sr[l_cnt].inbbseq = sr_s.inbbseq
       LET sr[l_cnt].inbbsite = sr_s.inbbsite
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_t2_imaal003 = sr_s.x_t2_imaal003
       LET sr[l_cnt].x_inayl_t_inayl003 = sr_s.x_inayl_t_inayl003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t1_oocal003 = sr_s.x_t1_oocal003
       LET sr[l_cnt].l_inba004_ooefl003 = sr_s.l_inba004_ooefl003
       LET sr[l_cnt].l_inba003_ooag011 = sr_s.l_inba003_ooag011
       LET sr[l_cnt].l_inbb007_inayl003 = sr_s.l_inbb007_inayl003
       LET sr[l_cnt].l_inbb016_desc = sr_s.l_inbb016_desc
       LET sr[l_cnt].l_inbb008_inab003 = sr_s.l_inbb008_inab003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].inbbdocno = sr_s.inbbdocno
       LET sr[l_cnt].inbbent = sr_s.inbbent
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr911_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr911_g01_rep_data()
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
          START REPORT ainr911_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr911_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr911_g01_rep
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
 
{<section id="ainr911_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr911_g01_rep(sr1)
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
DEFINE sr3   sr3_r
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_count           INTEGER
DEFINE l_subrep05_show   LIKE type_t.chr1
DEFINE l_ooef017         LIKE ooef_t.ooef017   #法人
DEFINE l_g_site_t        LIKE ooef_t.ooef001   #儲存g_site值
DEFINE l_ooef012         LIKE ooef_t.ooef012   #聯絡對象識別碼
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.inbadocno,sr1.inbbseq
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
        BEFORE GROUP OF sr1.inbadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"

            #取法人對內名稱
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = sr1.inbasite               
            LET l_g_site_t = g_site #備份g_site預設值
            LET g_site = l_ooef017  #抓法人資料

            #end add-point:rep.header 
            LET g_rep_docno = sr1.inbadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            
            LET g_site = l_g_site_t #恢復原g_site值
            
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'inbaent=' ,sr1.inbaent,'{+}inbadocno=' ,sr1.inbadocno         
            CALL cl_gr_init_apr(sr1.inbadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.inbadocno.before name="rep.b_group.inbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr911_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr911_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr911_g01_subrep01
           DECLARE ainr911_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr911_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr911_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr911_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr911_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.inbadocno.after name="rep.b_group.inbadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.inbbseq
 
           #add-point:rep.b_group.inbbseq.before name="rep.b_group.inbbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.inbbseq.after name="rep.b_group.inbbseq.after"
           
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
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.inbbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr911_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr911_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr911_g01_subrep02
           DECLARE ainr911_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr911_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr911_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr911_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr911_g01_subrep02
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
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.inbbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr911_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr911_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr911_g01_subrep03
           DECLARE ainr911_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr911_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr911_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr911_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr911_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
            START REPORT ainr911_g01_subrep05
            IF tm.pr1 ="Y" THEN
               IF NOT cl_null(sr1.inbbseq) THEN
                  LET g_sql = "SELECT inbcdocno,trim(inbc005)||'.'||trim(inayl_t.inayl003),trim(inbc006)||'.'||trim(inab_t.inab003),inbc007,inbc003,inbc010,inbc009 ",
                              "  FROM inbc_t LEFT OUTER JOIN inayl_t ON inayl001 = inbc006 AND inaylent = inbcent AND inayl002 = '",g_dlang,"' ",
                              "              LEFT OUTER JOIN inab_t ON inab001 = inbc006 AND inab002 = inbc007 AND inabent = inbcent AND inbcsite = inabsite ",
                              " WHERE inbcdocno = '",sr1.inbbdocno CLIPPED,"'",
                              "   AND inbcent   = '",sr1.inbbent   CLIPPED,"'",
                              "   AND inbcseq   = '",sr1.inbbseq   CLIPPED,"' ",                         
                              "   ORDER BY inbcseq "
                                     
                  DECLARE ainr911_g01_repcur05 CURSOR FROM g_sql
                  FOREACH ainr911_g01_repcur05 INTO sr3.*
                     IF sr3.l_inbc005_inayl003 = '.' THEN
                        LET sr3.l_inbc005_inayl003 = NULL
                     END IF                    
                     IF sr3.l_inbc006_inab003 = '.' THEN
                        LET sr3.l_inbc006_inab003 = NULL
                     END IF 
                     OUTPUT TO REPORT ainr911_g01_subrep05(sr3.*)
                  END FOREACH 
               END IF
            END IF
            FINISH REPORT ainr911_g01_subrep05
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inbadocno
 
           #add-point:rep.a_group.inbadocno.before name="rep.a_group.inbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.inbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.inbadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr911_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr911_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr911_g01_subrep04
           DECLARE ainr911_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr911_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr911_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr911_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr911_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.inbadocno.after name="rep.a_group.inbadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inbbseq
 
           #add-point:rep.a_group.inbbseq.before name="rep.a_group.inbbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.inbbseq.after name="rep.a_group.inbbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr911_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr911_g01_subrep01(sr2)
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
PRIVATE REPORT ainr911_g01_subrep02(sr2)
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
PRIVATE REPORT ainr911_g01_subrep03(sr2)
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
PRIVATE REPORT ainr911_g01_subrep04(sr2)
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
 
{<section id="ainr911_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="ainr911_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE REPORT ainr911_g01_subrep05(sr3)
   DEFINE sr3 sr3_r
   ORDER EXTERNAL BY sr3.inbcdocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.*
END REPORT

 
{</section>}
 
