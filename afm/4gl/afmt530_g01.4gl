#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt530_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-09-06 15:56:39), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: afmt530_g01
#+ Description: ...
#+ Creator....: 00222(2015-06-22 14:55:17)
#+ Modifier...: 08729 -SD/PR- 00000
 
{</section>}
 
{<section id="afmt530_g01.global" readonly="Y" >}
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
   fmmj001 LIKE fmmj_t.fmmj001, 
   fmmj002 LIKE fmmj_t.fmmj002, 
   l_fmmj011_desc LIKE type_t.chr80, 
   l_fmmj020_desc LIKE type_t.chr80, 
   l_fmmj002_fmmel003 LIKE type_t.chr80, 
   fmmj003 LIKE fmmj_t.fmmj003, 
   l_fmmj003_fmmal003 LIKE type_t.chr80, 
   fmmj004 LIKE fmmj_t.fmmj004, 
   fmmj005 LIKE fmmj_t.fmmj005, 
   fmmj006 LIKE fmmj_t.fmmj006, 
   fmmj007 LIKE fmmj_t.fmmj007, 
   fmmj008 LIKE fmmj_t.fmmj008, 
   fmmj009 LIKE fmmj_t.fmmj009, 
   fmmj010 LIKE fmmj_t.fmmj010, 
   fmmj011 LIKE fmmj_t.fmmj011, 
   fmmj012 LIKE fmmj_t.fmmj012, 
   fmmj013 LIKE fmmj_t.fmmj013, 
   fmmj014 LIKE fmmj_t.fmmj014, 
   fmmj015 LIKE fmmj_t.fmmj015, 
   fmmj016 LIKE fmmj_t.fmmj016, 
   fmmj017 LIKE fmmj_t.fmmj017, 
   fmmj018 LIKE fmmj_t.fmmj018, 
   fmmj019 LIKE fmmj_t.fmmj019, 
   fmmj020 LIKE fmmj_t.fmmj020, 
   fmmj021 LIKE fmmj_t.fmmj021, 
   fmmj022 LIKE fmmj_t.fmmj022, 
   fmmj023 LIKE fmmj_t.fmmj023, 
   fmmj027 LIKE fmmj_t.fmmj027, 
   fmmjdocdt LIKE fmmj_t.fmmjdocdt, 
   fmmjdocno LIKE fmmj_t.fmmjdocno, 
   fmmjent LIKE fmmj_t.fmmjent, 
   fmmjsite LIKE fmmj_t.fmmjsite, 
   fmmjstus LIKE fmmj_t.fmmjstus, 
   fmmel_t_fmmel003 LIKE fmmel_t.fmmel003, 
   fmmal_t_fmmal003 LIKE fmmal_t.fmmal003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   l_fmmjsite_ooefl003 LIKE type_t.chr1000, 
   fmmj024 LIKE fmmj_t.fmmj024, 
   fmmj025 LIKE fmmj_t.fmmj025, 
   fmmj026 LIKE fmmj_t.fmmj026, 
   fmmj028 LIKE fmmj_t.fmmj028, 
   fmmj029 LIKE fmmj_t.fmmj029, 
   fmmj030 LIKE fmmj_t.fmmj030, 
   fmmj031 LIKE fmmj_t.fmmj031, 
   l_fmmj025_desc LIKE type_t.chr100, 
   l_fmmj026_desc LIKE type_t.chr100
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
 
{<section id="afmt530_g01.main" readonly="Y" >}
PUBLIC FUNCTION afmt530_g01(p_arg1)
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
   
   LET g_rep_code = "afmt530_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afmt530_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afmt530_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afmt530_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt530_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmt530_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT fmmj001,fmmj002,'','',trim(fmmj002)||'.'||trim(fmmel003),fmmj003,trim(fmmj003)||'.'||trim((SELECT fmmal003 FROM fmmal_t WHERE fmmal_t.fmmal001 = fmmj_t.fmmj003 AND fmmal_t.fmmalent = fmmj_t.fmmjent AND fmmal_t.fmmal002 = '" , 
       g_dlang,"'" ,")),fmmj004,fmmj005,fmmj006,fmmj007,fmmj008,fmmj009,fmmj010,fmmj011,fmmj012,fmmj013, 
       fmmj014,fmmj015,fmmj016,fmmj017,fmmj018,fmmj019,fmmj020,fmmj021,fmmj022,fmmj023,fmmj027,fmmjdocdt, 
       fmmjdocno,fmmjent,fmmjsite,fmmjstus,( SELECT fmmel003 FROM fmmel_t WHERE fmmel_t.fmmel001 = fmmj_t.fmmj002 AND fmmel_t.fmmelent = fmmj_t.fmmjent AND fmmel_t.fmmel002 = '" , 
       g_dlang,"'" ,"),( SELECT fmmal003 FROM fmmal_t WHERE fmmal_t.fmmal001 = fmmj_t.fmmj003 AND fmmal_t.fmmalent = fmmj_t.fmmjent AND fmmal_t.fmmal002 = '" , 
       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = fmmj_t.fmmjsite AND ooefl_t.ooeflent = fmmj_t.fmmjent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),trim(fmmjsite)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = fmmj_t.fmmjsite AND ooefl_t.ooeflent = fmmj_t.fmmjent AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),fmmj024,fmmj025,fmmj026,fmmj028,fmmj029,fmmj030,fmmj031,'',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM fmmj_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY fmmjdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fmmj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afmt530_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afmt530_g01_curs CURSOR FOR afmt530_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afmt530_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afmt530_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fmmj001 LIKE fmmj_t.fmmj001, 
   fmmj002 LIKE fmmj_t.fmmj002, 
   l_fmmj011_desc LIKE type_t.chr80, 
   l_fmmj020_desc LIKE type_t.chr80, 
   l_fmmj002_fmmel003 LIKE type_t.chr80, 
   fmmj003 LIKE fmmj_t.fmmj003, 
   l_fmmj003_fmmal003 LIKE type_t.chr80, 
   fmmj004 LIKE fmmj_t.fmmj004, 
   fmmj005 LIKE fmmj_t.fmmj005, 
   fmmj006 LIKE fmmj_t.fmmj006, 
   fmmj007 LIKE fmmj_t.fmmj007, 
   fmmj008 LIKE fmmj_t.fmmj008, 
   fmmj009 LIKE fmmj_t.fmmj009, 
   fmmj010 LIKE fmmj_t.fmmj010, 
   fmmj011 LIKE fmmj_t.fmmj011, 
   fmmj012 LIKE fmmj_t.fmmj012, 
   fmmj013 LIKE fmmj_t.fmmj013, 
   fmmj014 LIKE fmmj_t.fmmj014, 
   fmmj015 LIKE fmmj_t.fmmj015, 
   fmmj016 LIKE fmmj_t.fmmj016, 
   fmmj017 LIKE fmmj_t.fmmj017, 
   fmmj018 LIKE fmmj_t.fmmj018, 
   fmmj019 LIKE fmmj_t.fmmj019, 
   fmmj020 LIKE fmmj_t.fmmj020, 
   fmmj021 LIKE fmmj_t.fmmj021, 
   fmmj022 LIKE fmmj_t.fmmj022, 
   fmmj023 LIKE fmmj_t.fmmj023, 
   fmmj027 LIKE fmmj_t.fmmj027, 
   fmmjdocdt LIKE fmmj_t.fmmjdocdt, 
   fmmjdocno LIKE fmmj_t.fmmjdocno, 
   fmmjent LIKE fmmj_t.fmmjent, 
   fmmjsite LIKE fmmj_t.fmmjsite, 
   fmmjstus LIKE fmmj_t.fmmjstus, 
   fmmel_t_fmmel003 LIKE fmmel_t.fmmel003, 
   fmmal_t_fmmal003 LIKE fmmal_t.fmmal003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   l_fmmjsite_ooefl003 LIKE type_t.chr1000, 
   fmmj024 LIKE fmmj_t.fmmj024, 
   fmmj025 LIKE fmmj_t.fmmj025, 
   fmmj026 LIKE fmmj_t.fmmj026, 
   fmmj028 LIKE fmmj_t.fmmj028, 
   fmmj029 LIKE fmmj_t.fmmj029, 
   fmmj030 LIKE fmmj_t.fmmj030, 
   fmmj031 LIKE fmmj_t.fmmj031, 
   l_fmmj025_desc LIKE type_t.chr100, 
   l_fmmj026_desc LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_glaacomp LIKE glaa_t.glaacomp  #151106-00002#6 151119 by sakura add
   DEFINE l_glaald   LIKE glaa_t.glaald    #151106-00002#6 151119 by sakura add
   DEFINE l_glaa005  LIKE glaa_t.glaa005   #151106-00002#6 151119 by sakura add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH afmt530_g01_curs INTO sr_s.*
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
       IF NOT cl_null(sr_s.fmmj020)THEN            
          LET sr_s.l_fmmj020_desc = sr_s.fmmj020,":",s_desc_gzcbl004_desc('8860',sr_s.fmmj020)
       END IF
       IF NOT cl_null(sr_s.fmmj011)THEN 
          LET sr_s.l_fmmj011_desc = sr_s.fmmj011,":",s_desc_gzcbl004_desc('8804',sr_s.fmmj011)
       END IF
       #151106-00002#6 151119 by sakura add(S)
       #存提碼
       IF NOT cl_null(sr_s.fmmj025) THEN
          LET sr_s.l_fmmj025_desc = sr_s.fmmj025,".",s_desc_get_nmajl003_desc(sr_s.fmmj025)
       END IF
       #取得投資組織所屬法人與法人之主帳套
       LET l_glaacomp = ''
       LET l_glaald = ''
       CALL s_fin_orga_get_comp_ld(sr_s.fmmjsite) RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
       #若組織非空，取出現金參照表編碼
       IF NOT cl_null(sr_s.fmmjsite) THEN
          LET l_glaa005 = ''
          SELECT glaa005 INTO l_glaa005 
            FROM glaa_t
           WHERE glaaent = g_enterprise 
             AND glaald = l_glaald
       END IF       
       #現金變動碼       
       IF NOT cl_null(sr_s.fmmj026) THEN
          LET sr_s.l_fmmj026_desc = sr_s.fmmj026,".",s_desc_get_nmail004_desc(l_glaa005,sr_s.fmmj026)
       END IF       
       #151106-00002#6 151119 by sakura add(E)
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fmmj001 = sr_s.fmmj001
       LET sr[l_cnt].fmmj002 = sr_s.fmmj002
       LET sr[l_cnt].l_fmmj011_desc = sr_s.l_fmmj011_desc
       LET sr[l_cnt].l_fmmj020_desc = sr_s.l_fmmj020_desc
       LET sr[l_cnt].l_fmmj002_fmmel003 = sr_s.l_fmmj002_fmmel003
       LET sr[l_cnt].fmmj003 = sr_s.fmmj003
       LET sr[l_cnt].l_fmmj003_fmmal003 = sr_s.l_fmmj003_fmmal003
       LET sr[l_cnt].fmmj004 = sr_s.fmmj004
       LET sr[l_cnt].fmmj005 = sr_s.fmmj005
       LET sr[l_cnt].fmmj006 = sr_s.fmmj006
       LET sr[l_cnt].fmmj007 = sr_s.fmmj007
       LET sr[l_cnt].fmmj008 = sr_s.fmmj008
       LET sr[l_cnt].fmmj009 = sr_s.fmmj009
       LET sr[l_cnt].fmmj010 = sr_s.fmmj010
       LET sr[l_cnt].fmmj011 = sr_s.fmmj011
       LET sr[l_cnt].fmmj012 = sr_s.fmmj012
       LET sr[l_cnt].fmmj013 = sr_s.fmmj013
       LET sr[l_cnt].fmmj014 = sr_s.fmmj014
       LET sr[l_cnt].fmmj015 = sr_s.fmmj015
       LET sr[l_cnt].fmmj016 = sr_s.fmmj016
       LET sr[l_cnt].fmmj017 = sr_s.fmmj017
       LET sr[l_cnt].fmmj018 = sr_s.fmmj018
       LET sr[l_cnt].fmmj019 = sr_s.fmmj019
       LET sr[l_cnt].fmmj020 = sr_s.fmmj020
       LET sr[l_cnt].fmmj021 = sr_s.fmmj021
       LET sr[l_cnt].fmmj022 = sr_s.fmmj022
       LET sr[l_cnt].fmmj023 = sr_s.fmmj023
       LET sr[l_cnt].fmmj027 = sr_s.fmmj027
       LET sr[l_cnt].fmmjdocdt = sr_s.fmmjdocdt
       LET sr[l_cnt].fmmjdocno = sr_s.fmmjdocno
       LET sr[l_cnt].fmmjent = sr_s.fmmjent
       LET sr[l_cnt].fmmjsite = sr_s.fmmjsite
       LET sr[l_cnt].fmmjstus = sr_s.fmmjstus
       LET sr[l_cnt].fmmel_t_fmmel003 = sr_s.fmmel_t_fmmel003
       LET sr[l_cnt].fmmal_t_fmmal003 = sr_s.fmmal_t_fmmal003
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].l_fmmjsite_ooefl003 = sr_s.l_fmmjsite_ooefl003
       LET sr[l_cnt].fmmj024 = sr_s.fmmj024
       LET sr[l_cnt].fmmj025 = sr_s.fmmj025
       LET sr[l_cnt].fmmj026 = sr_s.fmmj026
       LET sr[l_cnt].fmmj028 = sr_s.fmmj028
       LET sr[l_cnt].fmmj029 = sr_s.fmmj029
       LET sr[l_cnt].fmmj030 = sr_s.fmmj030
       LET sr[l_cnt].fmmj031 = sr_s.fmmj031
       LET sr[l_cnt].l_fmmj025_desc = sr_s.l_fmmj025_desc
       LET sr[l_cnt].l_fmmj026_desc = sr_s.l_fmmj026_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt530_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afmt530_g01_rep_data()
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
          START REPORT afmt530_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afmt530_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afmt530_g01_rep
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
 
{<section id="afmt530_g01.rep" readonly="Y" >}
PRIVATE REPORT afmt530_g01_rep(sr1)
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
    ORDER  BY sr1.fmmjdocno
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
        BEFORE GROUP OF sr1.fmmjdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fmmjdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fmmjent=' ,sr1.fmmjent,'{+}fmmjdocno=' ,sr1.fmmjdocno         
            CALL cl_gr_init_apr(sr1.fmmjdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fmmjdocno.before name="rep.b_group.fmmjdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fmmjent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmjdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt530_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afmt530_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afmt530_g01_subrep01
           DECLARE afmt530_g01_repcur01 CURSOR FROM g_sql
           FOREACH afmt530_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt530_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afmt530_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afmt530_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fmmjdocno.after name="rep.b_group.fmmjdocno.after"
           
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
                sr1.fmmjent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmjdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt530_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afmt530_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afmt530_g01_subrep02
           DECLARE afmt530_g01_repcur02 CURSOR FROM g_sql
           FOREACH afmt530_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt530_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afmt530_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afmt530_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.fmmjent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt530_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afmt530_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afmt530_g01_subrep03
           DECLARE afmt530_g01_repcur03 CURSOR FROM g_sql
           FOREACH afmt530_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt530_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afmt530_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afmt530_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmmjdocno
 
           #add-point:rep.a_group.fmmjdocno.before name="rep.a_group.fmmjdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fmmjent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmjdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt530_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afmt530_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afmt530_g01_subrep04
           DECLARE afmt530_g01_repcur04 CURSOR FROM g_sql
           FOREACH afmt530_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt530_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afmt530_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afmt530_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fmmjdocno.after name="rep.a_group.fmmjdocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afmt530_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afmt530_g01_subrep01(sr2)
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
PRIVATE REPORT afmt530_g01_subrep02(sr2)
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
PRIVATE REPORT afmt530_g01_subrep03(sr2)
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
PRIVATE REPORT afmt530_g01_subrep04(sr2)
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
 
{<section id="afmt530_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afmt530_g01.other_report" readonly="Y" >}

 
{</section>}
 
