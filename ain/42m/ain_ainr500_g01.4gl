#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr500_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-05-06 15:26:46), PR版次:0002(2016-05-10 15:37:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: ainr500_g01
#+ Description: ...
#+ Creator....: 02159(2015-02-11 14:46:15)
#+ Modifier...: 06815 -SD/PR- 06815
 
{</section>}
 
{<section id="ainr500_g01.global" readonly="Y" >}
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
   inda001 LIKE inda_t.inda001, 
   inda002 LIKE inda_t.inda002, 
   inda003 LIKE inda_t.inda003, 
   inda004 LIKE inda_t.inda004, 
   inda005 LIKE inda_t.inda005, 
   inda006 LIKE inda_t.inda006, 
   indadocdt LIKE inda_t.indadocdt, 
   indadocno LIKE inda_t.indadocno, 
   indaent LIKE inda_t.indaent, 
   indasite LIKE inda_t.indasite, 
   indastus LIKE inda_t.indastus, 
   indaunit LIKE inda_t.indaunit, 
   indb001 LIKE indb_t.indb001, 
   indb002 LIKE indb_t.indb002, 
   indb003 LIKE indb_t.indb003, 
   indb004 LIKE indb_t.indb004, 
   indb005 LIKE indb_t.indb005, 
   indb006 LIKE indb_t.indb006, 
   indb007 LIKE indb_t.indb007, 
   indb008 LIKE indb_t.indb008, 
   indb009 LIKE indb_t.indb009, 
   indb010 LIKE indb_t.indb010, 
   indb011 LIKE indb_t.indb011, 
   indb012 LIKE indb_t.indb012, 
   indb013 LIKE indb_t.indb013, 
   indbseq LIKE indb_t.indbseq, 
   indbsite LIKE indb_t.indbsite, 
   indbunit LIKE indb_t.indbunit, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t4_oocal003 LIKE oocal_t.oocal003, 
   l_inda001_ooag011 LIKE type_t.chr300, 
   l_indasite_ooefl003 LIKE type_t.chr1000, 
   l_inda004_ooefl003 LIKE type_t.chr1000, 
   l_inda003_ooefl003 LIKE type_t.chr1000, 
   l_inda002_ooefl003 LIKE type_t.chr1000, 
   indb151 LIKE indb_t.indb151, 
   l_indb001_desc LIKE type_t.chr80, 
   l_indb001_desc_1 LIKE type_t.chr80, 
   l_indb151_desc LIKE type_t.chr100
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
 
{<section id="ainr500_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr500_g01(p_arg1)
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
   
   LET g_rep_code = "ainr500_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr500_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr500_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr500_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr500_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr500_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160420-00039#12 s983961--add(s)
   LET g_select = " SELECT inda001,inda002,inda003,inda004,inda005,inda006,indadocdt,indadocno,indaent, 
       indasite,indastus,indaunit,indb001,indb002,indb003,indb004,indb005,indb006,indb007,indb008,indb009, 
       indb010,indb011,indb012,indb013,indbseq,indbsite,indbunit,
       ooefl_t.ooefl003,
       t1.ooefl003,t2.ooefl003,t3.ooefl003,
       ooag_t.ooag011,x.imaal_t_imaal003,x.oocal_t_oocal003,x.t4_oocal003,trim(inda001)||'.'||trim(ooag_t.ooag011), 
       trim(indasite)||'.'||trim(ooefl_t.ooefl003),trim(inda004)||'.'||trim(t1.ooefl003),trim(inda003)||'.'||trim(t2.ooefl003), 
       trim(inda002)||'.'||trim(t3.ooefl003),indb151,
       (SELECT oocql004
          FROM oocql_t
         WHERE oocqlent=x.indbent AND oocql001='303' AND oocql002 = x.indb151 
           AND oocql003='"||g_lang||"') oocql004,
       x.t5_imaal003,x.t5_imaal004 "
   #160420-00039#12 s983961--add(e)    
#   #end add-point
#   LET g_select = " SELECT inda001,inda002,inda003,inda004,inda005,inda006,indadocdt,indadocno,indaent, 
#       indasite,indastus,indaunit,indb001,indb002,indb003,indb004,indb005,indb006,indb007,indb008,indb009, 
#       indb010,indb011,indb012,indb013,indbseq,indbsite,indbunit,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = inda_t.indaent AND ooefl_t.ooefl001 = inda_t.indasite AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooeflent = inda_t.indaent AND t1.ooefl001 = inda_t.inda004 AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooeflent = inda_t.indaent AND t2.ooefl001 = inda_t.inda003 AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooeflent = inda_t.indaent AND t3.ooefl001 = inda_t.inda002 AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inda_t.inda001 AND ooag_t.ooagent = inda_t.indaent), 
#       x.imaal_t_imaal003,x.oocal_t_oocal003,x.t4_oocal003,trim(inda001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inda_t.inda001 AND ooag_t.ooagent = inda_t.indaent)), 
#       trim(indasite)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = inda_t.indaent AND ooefl_t.ooefl001 = inda_t.indasite AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inda004)||'.'||trim((SELECT ooefl003 FROM ooefl_t t1 WHERE t1.ooeflent = inda_t.indaent AND t1.ooefl001 = inda_t.inda004 AND t1.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inda003)||'.'||trim((SELECT ooefl003 FROM ooefl_t t2 WHERE t2.ooeflent = inda_t.indaent AND t2.ooefl001 = inda_t.inda003 AND t2.ooefl002 = '" , 
#       g_dlang,"'" ,")),trim(inda002)||'.'||trim((SELECT ooefl003 FROM ooefl_t t3 WHERE t3.ooeflent = inda_t.indaent AND t3.ooefl001 = inda_t.inda002 AND t3.ooefl002 = '" , 
#       g_dlang,"'" ,")),indb151,'','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160420-00039#12 s983961--add(s)
   LET g_from = " FROM inda_t LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = inda_t.inda001 AND ooag_t.ooagent = inda_t.indaent             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = inda_t.indaent AND ooefl_t.ooefl001 = inda_t.indasite AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = inda_t.indaent AND t1.ooefl001 = inda_t.inda004 AND t1.ooefl002 = '" , 
       g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent = inda_t.indaent AND t2.ooefl001 = inda_t.inda003 AND t2.ooefl002 = '" , 
       g_dlang,"'" ,"             LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent = inda_t.indaent AND t3.ooefl001 = inda_t.inda002 AND t3.ooefl002 = '" , 
       g_dlang,"'" ,"
                 LEFT OUTER JOIN ( SELECT indb_t.*,imaal_t.imaal003 imaal_t_imaal003,oocal_t.oocal003 oocal_t_oocal003, 
                                            t4.oocal003 t4_oocal003,t5.imaal003 t5_imaal003,t5.imaal004 t5_imaal004
                                     FROM indb_t 
                                     LEFT OUTER JOIN imaal_t ON imaal_t.imaalent = indb_t.indbent AND imaal_t.imaal001 = indb_t.indb001 AND imaal_t.imaal002 = '",g_dlang,"'" ,"     
                                     LEFT OUTER JOIN oocal_t ON oocal_t.oocalent = indb_t.indbent AND oocal_t.oocal001 = indb_t.indb004 AND oocal_t.oocal002 = '",g_dlang,"'" ,"   
                                     LEFT OUTER JOIN oocal_t t4 ON t4.oocalent = indb_t.indbent AND t4.oocal001 = indb_t.indb005 AND t4.oocal002 = '",g_dlang,"'" ,"
                                     LEFT OUTER JOIN imaal_t t5 ON t5.imaalent = indb_t.indbent AND t5.imaal001 = indb_t.indb001 AND t5.imaal002 = '",g_dlang,"'" ,"
                                     ) x  ON inda_t.indaent = x.indbent AND inda_t.indadocno = x.indbdocno"
   #160420-00039#12 s983961--add(e)                                      
#   #end add-point
#    LET g_from = " FROM inda_t LEFT OUTER JOIN ( SELECT indb_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaalent = indb_t.indbent AND imaal_t.imaal001 = indb_t.indb001 AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocalent = indb_t.indbent AND oocal_t.oocal001 = indb_t.indb004 AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t t4 WHERE t4.oocalent = indb_t.indbent AND t4.oocal001 = indb_t.indb005 AND t4.oocal002 = '" , 
#        g_dlang,"'" ,") t4_oocal003 FROM indb_t ) x  ON inda_t.indaent = x.indbent AND inda_t.indadocno  
#        = x.indbdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY indadocno,indbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr500_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr500_g01_curs CURSOR FOR ainr500_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr500_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr500_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inda001 LIKE inda_t.inda001, 
   inda002 LIKE inda_t.inda002, 
   inda003 LIKE inda_t.inda003, 
   inda004 LIKE inda_t.inda004, 
   inda005 LIKE inda_t.inda005, 
   inda006 LIKE inda_t.inda006, 
   indadocdt LIKE inda_t.indadocdt, 
   indadocno LIKE inda_t.indadocno, 
   indaent LIKE inda_t.indaent, 
   indasite LIKE inda_t.indasite, 
   indastus LIKE inda_t.indastus, 
   indaunit LIKE inda_t.indaunit, 
   indb001 LIKE indb_t.indb001, 
   indb002 LIKE indb_t.indb002, 
   indb003 LIKE indb_t.indb003, 
   indb004 LIKE indb_t.indb004, 
   indb005 LIKE indb_t.indb005, 
   indb006 LIKE indb_t.indb006, 
   indb007 LIKE indb_t.indb007, 
   indb008 LIKE indb_t.indb008, 
   indb009 LIKE indb_t.indb009, 
   indb010 LIKE indb_t.indb010, 
   indb011 LIKE indb_t.indb011, 
   indb012 LIKE indb_t.indb012, 
   indb013 LIKE indb_t.indb013, 
   indbseq LIKE indb_t.indbseq, 
   indbsite LIKE indb_t.indbsite, 
   indbunit LIKE indb_t.indbunit, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   t3_ooefl003 LIKE ooefl_t.ooefl003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t4_oocal003 LIKE oocal_t.oocal003, 
   l_inda001_ooag011 LIKE type_t.chr300, 
   l_indasite_ooefl003 LIKE type_t.chr1000, 
   l_inda004_ooefl003 LIKE type_t.chr1000, 
   l_inda003_ooefl003 LIKE type_t.chr1000, 
   l_inda002_ooefl003 LIKE type_t.chr1000, 
   indb151 LIKE indb_t.indb151, 
   l_indb001_desc LIKE type_t.chr80, 
   l_indb001_desc_1 LIKE type_t.chr80, 
   l_indb151_desc LIKE type_t.chr100
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
    FOREACH ainr500_g01_curs INTO sr_s.*
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
       #160420-00039#12 s983961--mark(s)
       ##單身理由瑪    
       #CALL s_desc_get_acc_desc('303',sr_s.indb151) RETURNING sr_s.l_indb151_desc       
       ##品名、規格
       #CALL s_desc_get_item_desc(sr_s.indb001) RETURNING sr_s.l_indb001_desc,sr_s.l_indb001_desc_1
       #160420-00039#12 s983961--mark(e)
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL ainr500_g01_initialize(sr_s.indasite,sr_s.l_indasite_ooefl003) RETURNING sr_s.l_indasite_ooefl003
       CALL ainr500_g01_initialize(sr_s.inda001,sr_s.l_inda001_ooag011) RETURNING sr_s.l_inda001_ooag011
       CALL ainr500_g01_initialize(sr_s.inda003,sr_s.l_inda003_ooefl003) RETURNING sr_s.l_inda003_ooefl003
       CALL ainr500_g01_initialize(sr_s.inda004,sr_s.l_inda004_ooefl003) RETURNING sr_s.l_inda004_ooefl003
       CALL ainr500_g01_initialize(sr_s.inda002,sr_s.l_inda002_ooefl003) RETURNING sr_s.l_inda002_ooefl003
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].inda001 = sr_s.inda001
       LET sr[l_cnt].inda002 = sr_s.inda002
       LET sr[l_cnt].inda003 = sr_s.inda003
       LET sr[l_cnt].inda004 = sr_s.inda004
       LET sr[l_cnt].inda005 = sr_s.inda005
       LET sr[l_cnt].inda006 = sr_s.inda006
       LET sr[l_cnt].indadocdt = sr_s.indadocdt
       LET sr[l_cnt].indadocno = sr_s.indadocno
       LET sr[l_cnt].indaent = sr_s.indaent
       LET sr[l_cnt].indasite = sr_s.indasite
       LET sr[l_cnt].indastus = sr_s.indastus
       LET sr[l_cnt].indaunit = sr_s.indaunit
       LET sr[l_cnt].indb001 = sr_s.indb001
       LET sr[l_cnt].indb002 = sr_s.indb002
       LET sr[l_cnt].indb003 = sr_s.indb003
       LET sr[l_cnt].indb004 = sr_s.indb004
       LET sr[l_cnt].indb005 = sr_s.indb005
       LET sr[l_cnt].indb006 = sr_s.indb006
       LET sr[l_cnt].indb007 = sr_s.indb007
       LET sr[l_cnt].indb008 = sr_s.indb008
       LET sr[l_cnt].indb009 = sr_s.indb009
       LET sr[l_cnt].indb010 = sr_s.indb010
       LET sr[l_cnt].indb011 = sr_s.indb011
       LET sr[l_cnt].indb012 = sr_s.indb012
       LET sr[l_cnt].indb013 = sr_s.indb013
       LET sr[l_cnt].indbseq = sr_s.indbseq
       LET sr[l_cnt].indbsite = sr_s.indbsite
       LET sr[l_cnt].indbunit = sr_s.indbunit
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].t3_ooefl003 = sr_s.t3_ooefl003
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t4_oocal003 = sr_s.x_t4_oocal003
       LET sr[l_cnt].l_inda001_ooag011 = sr_s.l_inda001_ooag011
       LET sr[l_cnt].l_indasite_ooefl003 = sr_s.l_indasite_ooefl003
       LET sr[l_cnt].l_inda004_ooefl003 = sr_s.l_inda004_ooefl003
       LET sr[l_cnt].l_inda003_ooefl003 = sr_s.l_inda003_ooefl003
       LET sr[l_cnt].l_inda002_ooefl003 = sr_s.l_inda002_ooefl003
       LET sr[l_cnt].indb151 = sr_s.indb151
       LET sr[l_cnt].l_indb001_desc = sr_s.l_indb001_desc
       LET sr[l_cnt].l_indb001_desc_1 = sr_s.l_indb001_desc_1
       LET sr[l_cnt].l_indb151_desc = sr_s.l_indb151_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr500_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr500_g01_rep_data()
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
          START REPORT ainr500_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr500_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr500_g01_rep
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
 
{<section id="ainr500_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr500_g01_rep(sr1)
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
DEFINE l_inda006_show    LIKE type_t.chr1  #單頭備註
DEFINE l_indb013_show    LIKE type_t.chr1  #單身備註
DEFINE l_ooef017         LIKE ooef_t.ooef017   #法人
DEFINE l_g_site_t        LIKE ooef_t.ooef001   #儲存g_site值
DEFINE l_ooef012         LIKE ooef_t.ooef012   #聯絡對象識別碼
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.indadocno,sr1.indbseq
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
        BEFORE GROUP OF sr1.indadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #取法人對內名稱
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = sr1.indasite               
            LET l_g_site_t = g_site #備份g_site預設值
            LET g_site = l_ooef017  #抓法人資料
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.indadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"

            LET g_site = l_g_site_t #恢復原g_site值

            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'indaent=' ,sr1.indaent,'{+}indadocno=' ,sr1.indadocno         
            CALL cl_gr_init_apr(sr1.indadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.indadocno.before name="rep.b_group.indadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.indaent CLIPPED ,"'", " AND  ooff003 = '", sr1.indadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr500_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr500_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr500_g01_subrep01
           DECLARE ainr500_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr500_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr500_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr500_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr500_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.indadocno.after name="rep.b_group.indadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.indbseq
 
           #add-point:rep.b_group.indbseq.before name="rep.b_group.indbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.indbseq.after name="rep.b_group.indbseq.after"
           
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
                sr1.indaent CLIPPED ,"'", " AND  ooff003 = '", sr1.indadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.indbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr500_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr500_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr500_g01_subrep02
           DECLARE ainr500_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr500_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr500_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr500_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr500_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
            #單頭備註是否隱藏
            CALL ainr500_g01_show(sr1.inda006,'','') RETURNING l_inda006_show
            PRINTX l_inda006_show
            #單身備註是否隱藏
            CALL ainr500_g01_show(sr1.indb013,'','') RETURNING l_indb013_show
            PRINTX l_indb013_show
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
                sr1.indaent CLIPPED ,"'", " AND  ooff003 = '", sr1.indadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.indbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr500_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr500_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr500_g01_subrep03
           DECLARE ainr500_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr500_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr500_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr500_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr500_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.indadocno
 
           #add-point:rep.a_group.indadocno.before name="rep.a_group.indadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.indaent CLIPPED ,"'", " AND  ooff003 = '", sr1.indadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr500_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr500_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr500_g01_subrep04
           DECLARE ainr500_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr500_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr500_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr500_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr500_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.indadocno.after name="rep.a_group.indadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.indbseq
 
           #add-point:rep.a_group.indbseq.before name="rep.a_group.indbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.indbseq.after name="rep.a_group.indbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr500_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr500_g01_subrep01(sr2)
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
PRIVATE REPORT ainr500_g01_subrep02(sr2)
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
PRIVATE REPORT ainr500_g01_subrep03(sr2)
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
PRIVATE REPORT ainr500_g01_subrep04(sr2)
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
 
{<section id="ainr500_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: CALL ainr500_g01_show(p_arg1,p_arg2,p_arg3)
# Input parameter: p_arg1   传入参数变量说明1
#                : p_arg2   传入参数变量说明2
#                : p_arg3   传入参数变量说明2
# Return code....: r_show   Y/N
# Date & Author..: 2015/02/11 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr500_g01_show(p_arg1,p_arg2,p_arg3)
DEFINE p_arg1 LIKE type_t.chr1000
   DEFINE p_arg2 LIKE type_t.chr1000
   DEFINE p_arg3 LIKE type_t.chr1000
   DEFINE r_show LIKE type_t.chr1

      IF cl_null(p_arg1) AND cl_null(p_arg2) AND cl_null(p_arg3) THEN
         LET r_show = "N"
      ELSE
         LET r_show = "Y"
      END IF
      RETURN r_show
END FUNCTION

################################################################################
# Descriptions...: 當編號為空時清空編號.說明字串
# Usage..........: CALL ainr500_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg   編號
#                : p_exp   編號.說明
# Return code....: r_exp   編號.說明
# Date & Author..: 2015/02/11 By sakura
################################################################################
PRIVATE FUNCTION ainr500_g01_initialize(p_arg,p_exp)
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

 
{</section>}
 
{<section id="ainr500_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
