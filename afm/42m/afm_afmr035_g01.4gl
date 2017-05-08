#該程式未解開Section, 採用最新樣板產出!
{<section id="afmr035_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-10-11 09:33:09), PR版次:0001(2016-10-11 16:47:06)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000003
#+ Filename...: afmr035_g01
#+ Description: ...
#+ Creator....: 08732(2016-09-29 18:26:13)
#+ Modifier...: 08732 -SD/PR- 08732
 
{</section>}
 
{<section id="afmr035_g01.global" readonly="Y" >}
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
   fmcj001 LIKE fmcj_t.fmcj001, 
   l_fmcj001_desc LIKE type_t.chr100, 
   fmcj002 LIKE fmcj_t.fmcj002, 
   l_fmcj002_desc LIKE type_t.chr100, 
   fmcj003 LIKE fmcj_t.fmcj003, 
   fmcj004 LIKE fmcj_t.fmcj004, 
   fmcj005 LIKE fmcj_t.fmcj005, 
   l_fmcj005_desc LIKE type_t.chr100, 
   fmcj006 LIKE fmcj_t.fmcj006, 
   fmcj007 LIKE fmcj_t.fmcj007, 
   fmcj008 LIKE fmcj_t.fmcj008, 
   fmcj009 LIKE fmcj_t.fmcj009, 
   l_fmcj009_desc LIKE type_t.chr100, 
   fmcjcnfdt LIKE fmcj_t.fmcjcnfdt, 
   fmcjcnfid LIKE fmcj_t.fmcjcnfid, 
   fmcjcomp LIKE fmcj_t.fmcjcomp, 
   l_fmcjcomp_desc LIKE type_t.chr100, 
   fmcjcrtdp LIKE fmcj_t.fmcjcrtdp, 
   fmcjcrtdt DATETIME YEAR TO SECOND, 
   fmcjcrtid LIKE fmcj_t.fmcjcrtid, 
   fmcjdocdt LIKE fmcj_t.fmcjdocdt, 
   fmcjdocno LIKE fmcj_t.fmcjdocno, 
   fmcjent LIKE fmcj_t.fmcjent, 
   fmcjmoddt DATETIME YEAR TO SECOND, 
   fmcjmodid LIKE fmcj_t.fmcjmodid, 
   fmcjowndp LIKE fmcj_t.fmcjowndp, 
   fmcjownid LIKE fmcj_t.fmcjownid, 
   fmcjsite LIKE fmcj_t.fmcjsite, 
   l_fmcjsite_desc LIKE type_t.chr100, 
   fmcjstus LIKE fmcj_t.fmcjstus, 
   l_fmcjstus_desc LIKE type_t.chr100, 
   fmck001 LIKE fmck_t.fmck001, 
   fmck002 LIKE fmck_t.fmck002, 
   fmck003 LIKE fmck_t.fmck003, 
   fmck004 LIKE fmck_t.fmck004, 
   fmck005 LIKE fmck_t.fmck005, 
   l_fmck005_desc LIKE type_t.chr100, 
   fmck006 LIKE fmck_t.fmck006, 
   l_fmck006_desc LIKE type_t.chr100, 
   fmck007 LIKE fmck_t.fmck007, 
   l_fmck007_desc LIKE type_t.chr100, 
   fmck008 LIKE fmck_t.fmck008, 
   l_fmck008_desc LIKE type_t.chr100, 
   fmck009 LIKE fmck_t.fmck009, 
   l_fmck009_desc LIKE type_t.chr100, 
   fmck010 LIKE fmck_t.fmck010, 
   fmck011 LIKE fmck_t.fmck011, 
   fmck012 LIKE fmck_t.fmck012, 
   fmckdocno LIKE fmck_t.fmckdocno, 
   fmckent LIKE fmck_t.fmckent, 
   fmckseq LIKE fmck_t.fmckseq
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
TYPE sr5_r RECORD
   fmck002     LIKE fmck_t.fmck002,
   fmck004     LIKE fmck_t.fmck004,
   sum_show    LIKE type_t.chr1
   END RECORD
#end add-point
 
{</section>}
 
{<section id="afmr035_g01.main" readonly="Y" >}
PUBLIC FUNCTION afmr035_g01(p_arg1)
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
   
   LET g_rep_code = "afmr035_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afmr035_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afmr035_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afmr035_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afmr035_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmr035_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT fmcj001,",
                  " (SELECT fmaal003 FROM fmaal_t WHERE fmaalent= fmcjent AND fmaal001 = fmcj001 AND fmaal002 = '", g_dlang,"'),",
                  " fmcj002,",
                  " (SELECT nmabl004 FROM nmabl_t WHERE nmablent= fmcjent AND nmabl001 = fmcj002 AND nmabl002 = '", g_dlang,"'),",
                  " fmcj003,fmcj004,fmcj005,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8856' AND gzcbl002 = fmcj005 AND gzcbl003 = '", g_dlang,"'),",
                  " fmcj006,fmcj007,fmcj008,fmcj009,NULL,fmcjcnfdt,fmcjcnfid,fmcjcomp,",
                  " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = fmcjent AND ooefl001 = fmcjcomp AND ooefl002 = '", g_dlang,"'),",
                  " fmcjcrtdp,fmcjcrtdt,fmcjcrtid,fmcjdocdt,fmcjdocno,fmcjent,fmcjmoddt,fmcjmodid,",
                  " fmcjowndp,fmcjownid,fmcjsite,",
                  " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = fmcjent AND ooefl001 = fmcjsite AND ooefl002 = '", g_dlang,"'),",
                  " fmcjstus,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = fmcjstus AND gzcbl003 = '", g_dlang,"'),",
                  " fmck001,fmck002,fmck003,fmck004,fmck005,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8854' AND gzcbl002 = fmck005 AND gzcbl003 = '", g_dlang,"'),",
                  " fmck006,",
                  " (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8855' AND gzcbl002 = fmck006 AND gzcbl003 = '", g_dlang,"'),",
                  " fmck007,NULL,fmck008,NULL,fmck009,NULL,fmck010,fmck011,fmck012,fmckdocno,fmckent,fmckseq"
#   #end add-point
#   LET g_select = " SELECT fmcj001,NULL,fmcj002,NULL,fmcj003,fmcj004,fmcj005,NULL,fmcj006,fmcj007,fmcj008, 
#       fmcj009,NULL,fmcjcnfdt,fmcjcnfid,fmcjcomp,NULL,fmcjcrtdp,fmcjcrtdt,fmcjcrtid,fmcjdocdt,fmcjdocno, 
#       fmcjent,fmcjmoddt,fmcjmodid,fmcjowndp,fmcjownid,fmcjsite,NULL,fmcjstus,NULL,fmck001,fmck002,fmck003, 
#       fmck004,fmck005,NULL,fmck006,NULL,fmck007,NULL,fmck008,NULL,fmck009,NULL,fmck010,fmck011,fmck012, 
#       fmckdocno,fmckent,fmckseq"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
   #end add-point
    LET g_from = " FROM fmcj_t,fmck_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY fmcjdocno,fmckseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fmcj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afmr035_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afmr035_g01_curs CURSOR FOR afmr035_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afmr035_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afmr035_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fmcj001 LIKE fmcj_t.fmcj001, 
   l_fmcj001_desc LIKE type_t.chr100, 
   fmcj002 LIKE fmcj_t.fmcj002, 
   l_fmcj002_desc LIKE type_t.chr100, 
   fmcj003 LIKE fmcj_t.fmcj003, 
   fmcj004 LIKE fmcj_t.fmcj004, 
   fmcj005 LIKE fmcj_t.fmcj005, 
   l_fmcj005_desc LIKE type_t.chr100, 
   fmcj006 LIKE fmcj_t.fmcj006, 
   fmcj007 LIKE fmcj_t.fmcj007, 
   fmcj008 LIKE fmcj_t.fmcj008, 
   fmcj009 LIKE fmcj_t.fmcj009, 
   l_fmcj009_desc LIKE type_t.chr100, 
   fmcjcnfdt LIKE fmcj_t.fmcjcnfdt, 
   fmcjcnfid LIKE fmcj_t.fmcjcnfid, 
   fmcjcomp LIKE fmcj_t.fmcjcomp, 
   l_fmcjcomp_desc LIKE type_t.chr100, 
   fmcjcrtdp LIKE fmcj_t.fmcjcrtdp, 
   fmcjcrtdt LIKE fmcj_t.fmcjcrtdt, 
   fmcjcrtid LIKE fmcj_t.fmcjcrtid, 
   fmcjdocdt LIKE fmcj_t.fmcjdocdt, 
   fmcjdocno LIKE fmcj_t.fmcjdocno, 
   fmcjent LIKE fmcj_t.fmcjent, 
   fmcjmoddt LIKE fmcj_t.fmcjmoddt, 
   fmcjmodid LIKE fmcj_t.fmcjmodid, 
   fmcjowndp LIKE fmcj_t.fmcjowndp, 
   fmcjownid LIKE fmcj_t.fmcjownid, 
   fmcjsite LIKE fmcj_t.fmcjsite, 
   l_fmcjsite_desc LIKE type_t.chr100, 
   fmcjstus LIKE fmcj_t.fmcjstus, 
   l_fmcjstus_desc LIKE type_t.chr100, 
   fmck001 LIKE fmck_t.fmck001, 
   fmck002 LIKE fmck_t.fmck002, 
   fmck003 LIKE fmck_t.fmck003, 
   fmck004 LIKE fmck_t.fmck004, 
   fmck005 LIKE fmck_t.fmck005, 
   l_fmck005_desc LIKE type_t.chr100, 
   fmck006 LIKE fmck_t.fmck006, 
   l_fmck006_desc LIKE type_t.chr100, 
   fmck007 LIKE fmck_t.fmck007, 
   l_fmck007_desc LIKE type_t.chr100, 
   fmck008 LIKE fmck_t.fmck008, 
   l_fmck008_desc LIKE type_t.chr100, 
   fmck009 LIKE fmck_t.fmck009, 
   l_fmck009_desc LIKE type_t.chr100, 
   fmck010 LIKE fmck_t.fmck010, 
   fmck011 LIKE fmck_t.fmck011, 
   fmck012 LIKE fmck_t.fmck012, 
   fmckdocno LIKE fmck_t.fmckdocno, 
   fmckent LIKE fmck_t.fmckent, 
   fmckseq LIKE fmck_t.fmckseq
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
    FOREACH afmr035_g01_curs INTO sr_s.*
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
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       IF NOT cl_null(sr_s.l_fmcj001_desc) THEN
          LET sr_s.l_fmcj001_desc = sr_s.fmcj001,':',sr_s.l_fmcj001_desc
       ELSE
          LET sr_s.l_fmcj001_desc = sr_s.fmcj001
       END IF
       
       IF NOT cl_null(sr_s.l_fmcjsite_desc) THEN
          LET sr_s.l_fmcjsite_desc = sr_s.fmcjsite,':',sr_s.l_fmcjsite_desc
       ELSE
          LET sr_s.l_fmcjsite_desc = sr_s.fmcjsite
       END IF
       
       IF NOT cl_null(sr_s.l_fmcjcomp_desc) THEN
          LET sr_s.l_fmcjcomp_desc = sr_s.fmcjcomp,':',sr_s.l_fmcjcomp_desc
       ELSE
          LET sr_s.l_fmcjcomp_desc = sr_s.fmcjcomp
       END IF
       
       IF NOT cl_null(sr_s.l_fmcj002_desc) THEN
          LET sr_s.l_fmcj002_desc = sr_s.fmcj002,':',sr_s.l_fmcj002_desc
       ELSE
          LET sr_s.l_fmcj002_desc = sr_s.fmcj002
       END IF

       LET sr_s.l_fmcjstus_desc = sr_s.fmcjstus,'',sr_s.l_fmcjstus_desc
 
       LET sr_s.l_fmcj005_desc = sr_s.fmcj005,'.', sr_s.l_fmcj005_desc
       LET sr_s.l_fmcj009_desc = sr_s.fmcj009
       LET sr_s.l_fmck005_desc = sr_s.fmck005,'.', sr_s.l_fmck005_desc
       IF sr_s.fmck005 = '1' THEN
          LET sr_s.l_fmck006_desc = ''
       ELSE
          LET sr_s.l_fmck006_desc = sr_s.fmck006,'.', sr_s.l_fmck006_desc
       END IF
       
       LET sr_s.l_fmck007_desc = sr_s.fmck007,'%'
       LET sr_s.l_fmck008_desc = sr_s.fmck008,'%'
       LET sr_s.l_fmck009_desc = sr_s.fmck009,'%'
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fmcj001 = sr_s.fmcj001
       LET sr[l_cnt].l_fmcj001_desc = sr_s.l_fmcj001_desc
       LET sr[l_cnt].fmcj002 = sr_s.fmcj002
       LET sr[l_cnt].l_fmcj002_desc = sr_s.l_fmcj002_desc
       LET sr[l_cnt].fmcj003 = sr_s.fmcj003
       LET sr[l_cnt].fmcj004 = sr_s.fmcj004
       LET sr[l_cnt].fmcj005 = sr_s.fmcj005
       LET sr[l_cnt].l_fmcj005_desc = sr_s.l_fmcj005_desc
       LET sr[l_cnt].fmcj006 = sr_s.fmcj006
       LET sr[l_cnt].fmcj007 = sr_s.fmcj007
       LET sr[l_cnt].fmcj008 = sr_s.fmcj008
       LET sr[l_cnt].fmcj009 = sr_s.fmcj009
       LET sr[l_cnt].l_fmcj009_desc = sr_s.l_fmcj009_desc
       LET sr[l_cnt].fmcjcnfdt = sr_s.fmcjcnfdt
       LET sr[l_cnt].fmcjcnfid = sr_s.fmcjcnfid
       LET sr[l_cnt].fmcjcomp = sr_s.fmcjcomp
       LET sr[l_cnt].l_fmcjcomp_desc = sr_s.l_fmcjcomp_desc
       LET sr[l_cnt].fmcjcrtdp = sr_s.fmcjcrtdp
       LET sr[l_cnt].fmcjcrtdt = sr_s.fmcjcrtdt
       LET sr[l_cnt].fmcjcrtid = sr_s.fmcjcrtid
       LET sr[l_cnt].fmcjdocdt = sr_s.fmcjdocdt
       LET sr[l_cnt].fmcjdocno = sr_s.fmcjdocno
       LET sr[l_cnt].fmcjent = sr_s.fmcjent
       LET sr[l_cnt].fmcjmoddt = sr_s.fmcjmoddt
       LET sr[l_cnt].fmcjmodid = sr_s.fmcjmodid
       LET sr[l_cnt].fmcjowndp = sr_s.fmcjowndp
       LET sr[l_cnt].fmcjownid = sr_s.fmcjownid
       LET sr[l_cnt].fmcjsite = sr_s.fmcjsite
       LET sr[l_cnt].l_fmcjsite_desc = sr_s.l_fmcjsite_desc
       LET sr[l_cnt].fmcjstus = sr_s.fmcjstus
       LET sr[l_cnt].l_fmcjstus_desc = sr_s.l_fmcjstus_desc
       LET sr[l_cnt].fmck001 = sr_s.fmck001
       LET sr[l_cnt].fmck002 = sr_s.fmck002
       LET sr[l_cnt].fmck003 = sr_s.fmck003
       LET sr[l_cnt].fmck004 = sr_s.fmck004
       LET sr[l_cnt].fmck005 = sr_s.fmck005
       LET sr[l_cnt].l_fmck005_desc = sr_s.l_fmck005_desc
       LET sr[l_cnt].fmck006 = sr_s.fmck006
       LET sr[l_cnt].l_fmck006_desc = sr_s.l_fmck006_desc
       LET sr[l_cnt].fmck007 = sr_s.fmck007
       LET sr[l_cnt].l_fmck007_desc = sr_s.l_fmck007_desc
       LET sr[l_cnt].fmck008 = sr_s.fmck008
       LET sr[l_cnt].l_fmck008_desc = sr_s.l_fmck008_desc
       LET sr[l_cnt].fmck009 = sr_s.fmck009
       LET sr[l_cnt].l_fmck009_desc = sr_s.l_fmck009_desc
       LET sr[l_cnt].fmck010 = sr_s.fmck010
       LET sr[l_cnt].fmck011 = sr_s.fmck011
       LET sr[l_cnt].fmck012 = sr_s.fmck012
       LET sr[l_cnt].fmckdocno = sr_s.fmckdocno
       LET sr[l_cnt].fmckent = sr_s.fmckent
       LET sr[l_cnt].fmckseq = sr_s.fmckseq
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmr035_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afmr035_g01_rep_data()
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
          START REPORT afmr035_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afmr035_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afmr035_g01_rep
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
 
{<section id="afmr035_g01.rep" readonly="Y" >}
PRIVATE REPORT afmr035_g01_rep(sr1)
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
DEFINE sr5       sr5_r
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_flag           LIKE type_t.num5   #要不要印字
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.fmcjdocno,sr1.fmckseq
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
        BEFORE GROUP OF sr1.fmcjdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fmcjdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fmcjent=' ,sr1.fmcjent,'{+}fmcjdocno=' ,sr1.fmcjdocno         
            CALL cl_gr_init_apr(sr1.fmcjdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fmcjdocno.before name="rep.b_group.fmcjdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fmcjent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcjdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr035_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afmr035_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afmr035_g01_subrep01
           DECLARE afmr035_g01_repcur01 CURSOR FROM g_sql
           FOREACH afmr035_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr035_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afmr035_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afmr035_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fmcjdocno.after name="rep.b_group.fmcjdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.fmckseq
 
           #add-point:rep.b_group.fmckseq.before name="rep.b_group.fmckseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.fmckseq.after name="rep.b_group.fmckseq.after"
           
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
                sr1.fmcjent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcjdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fmckseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr035_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afmr035_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afmr035_g01_subrep02
           DECLARE afmr035_g01_repcur02 CURSOR FROM g_sql
           FOREACH afmr035_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr035_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afmr035_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afmr035_g01_subrep02
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
                sr1.fmcjent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcjdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fmckseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr035_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afmr035_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afmr035_g01_subrep03
           DECLARE afmr035_g01_repcur03 CURSOR FROM g_sql
           FOREACH afmr035_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr035_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afmr035_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afmr035_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmcjdocno
 
           #add-point:rep.a_group.fmcjdocno.before name="rep.a_group.fmcjdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fmcjent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcjdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr035_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afmr035_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afmr035_g01_subrep04
           DECLARE afmr035_g01_repcur04 CURSOR FROM g_sql
           FOREACH afmr035_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr035_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afmr035_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afmr035_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           #總計
           LET g_sql = " SELECT fmck002,SUM(fmck004),'' ",                       
                       " FROM fmck_t,fmcj_t ",
                       " WHERE fmckent = fmcjent AND fmckdocno = fmcjdocno ",
                       " AND fmckent ='",g_enterprise,"' ",
                       " AND fmcjdocno = '",sr1.fmcjdocno CLIPPED,"' "
           LET g_sql = g_sql CLIPPED," AND ", tm.wc CLIPPED , 
                       " GROUP BY fmcjdocno,fmck002 ",
                       " ORDER BY fmck002 " 
           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_flag = 0
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr035_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE afmr035_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT afmr035_g01_subrep05
           DECLARE afmr035_g01_repcur05 CURSOR FROM g_sql
           FOREACH afmr035_g01_repcur05 INTO sr5.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr035_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              IF l_flag = 0 THEN #合計只印一次
                 LET sr5.sum_show = 'Y'
              ELSE 
                 LET sr5.sum_show = 'N'
              END IF
              LET l_flag = l_flag + 1  
              OUTPUT TO REPORT afmr035_g01_subrep05(sr5.*)
           END FOREACH
           FINISH REPORT afmr035_g01_subrep05   
           
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fmcjdocno.after name="rep.a_group.fmcjdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmckseq
 
           #add-point:rep.a_group.fmckseq.before name="rep.a_group.fmckseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.fmckseq.after name="rep.a_group.fmckseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afmr035_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afmr035_g01_subrep01(sr2)
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
PRIVATE REPORT afmr035_g01_subrep02(sr2)
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
PRIVATE REPORT afmr035_g01_subrep03(sr2)
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
PRIVATE REPORT afmr035_g01_subrep04(sr2)
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
 
{<section id="afmr035_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afmr035_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 金額總計
# Memo...........:
# Usage..........: CALL afmr035_g01_subrep05(sr5)
# Date & Author..: 2016/10/03 By 08732
# Modify.........:
################################################################################
PRIVATE REPORT afmr035_g01_subrep05(sr5)
DEFINE sr5   sr5_r
    FORMAT
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

 
{</section>}
 
