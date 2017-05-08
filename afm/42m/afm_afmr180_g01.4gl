#該程式未解開Section, 採用最新樣板產出!
{<section id="afmr180_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-10-04 14:06:30), PR版次:0001(2016-10-05 11:39:50)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000003
#+ Filename...: afmr180_g01
#+ Description: ...
#+ Creator....: 08729(2016-09-28 14:20:50)
#+ Modifier...: 08729 -SD/PR- 08729
 
{</section>}
 
{<section id="afmr180_g01.global" readonly="Y" >}
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
   fmcy001 LIKE fmcy_t.fmcy001, 
   fmcy002 LIKE fmcy_t.fmcy002, 
   fmcycomp LIKE fmcy_t.fmcycomp, 
   fmcydocdt LIKE fmcy_t.fmcydocdt, 
   fmcydocno LIKE fmcy_t.fmcydocno, 
   fmcyent LIKE fmcy_t.fmcyent, 
   fmcysite LIKE fmcy_t.fmcysite, 
   fmcystus LIKE fmcy_t.fmcystus, 
   fmcz001 LIKE fmcz_t.fmcz001, 
   fmcz002 LIKE fmcz_t.fmcz002, 
   fmcz003 LIKE fmcz_t.fmcz003, 
   fmcz004 LIKE fmcz_t.fmcz004, 
   fmcz005 LIKE fmcz_t.fmcz005, 
   fmcz006 LIKE fmcz_t.fmcz006, 
   fmcz007 LIKE fmcz_t.fmcz007, 
   fmcz008 LIKE fmcz_t.fmcz008, 
   fmcz009 LIKE fmcz_t.fmcz009, 
   fmcz010 LIKE fmcz_t.fmcz010, 
   fmcz011 LIKE fmcz_t.fmcz011, 
   fmcz012 LIKE fmcz_t.fmcz012, 
   fmcz013 LIKE fmcz_t.fmcz013, 
   fmcz014 LIKE fmcz_t.fmcz014, 
   fmcz015 LIKE fmcz_t.fmcz015, 
   fmcz016 LIKE fmcz_t.fmcz016, 
   fmcz017 LIKE fmcz_t.fmcz017, 
   fmcz018 LIKE fmcz_t.fmcz018, 
   fmcz023 LIKE fmcz_t.fmcz023, 
   fmczseq LIKE fmcz_t.fmczseq, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   l_fmcycomp_ooefl003 LIKE type_t.chr1000, 
   l_fmcysite_ooefl003 LIKE type_t.chr1000, 
   l_fmcz001_ooefl003 LIKE type_t.chr100, 
   l_fmcz004_desc LIKE type_t.chr100, 
   l_fmcy001_fmcy002 LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where.comdition
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
   fmcz005       LIKE fmcz_t.fmcz005,
   fmcz006       LIKE fmcz_t.fmcz006,
   fmcz005_show  LIKE type_t.chr1
END RECORD   
#end add-point
 
{</section>}
 
{<section id="afmr180_g01.main" readonly="Y" >}
PUBLIC FUNCTION afmr180_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where.comdition
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
   
   LET g_rep_code = "afmr180_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afmr180_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afmr180_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afmr180_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afmr180_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmr180_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT fmcy001,fmcy002,fmcycomp,fmcydocdt,fmcydocno,fmcyent,fmcysite,fmcystus,fmcz001, 
       fmcz002,fmcz003,fmcz004,fmcz005,fmcz006,fmcz007,fmcz008,fmcz009,fmcz010,fmcz011,fmcz012,fmcz013, 
       fmcz014,fmcz015,fmcz016,fmcz017,fmcz018,fmcz023,fmczseq,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = fmcy_t.fmcyent AND ooefl_t.ooefl001 = fmcy_t.fmcycomp AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = fmcy_t.fmcyent AND ooefl_t.ooefl001 = fmcy_t.fmcysite AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),trim(fmcycomp)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = fmcy_t.fmcyent AND ooefl_t.ooefl001 = fmcy_t.fmcycomp AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(fmcysite)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = fmcy_t.fmcyent AND ooefl_t.ooefl001 = fmcy_t.fmcysite AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(fmcz001)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = fmcy_t.fmcyent AND ooefl_t.ooefl001 = fmcy_t.fmcysite AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),'',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM fmcy_t LEFT OUTER JOIN ( SELECT fmcz_t.* FROM fmcz_t  ) x  ON fmcy_t.fmcyent  
        = x.fmczent AND fmcy_t.fmcydocno = x.fmczdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY fmcydocno,fmczseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fmcy_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afmr180_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afmr180_g01_curs CURSOR FOR afmr180_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afmr180_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afmr180_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fmcy001 LIKE fmcy_t.fmcy001, 
   fmcy002 LIKE fmcy_t.fmcy002, 
   fmcycomp LIKE fmcy_t.fmcycomp, 
   fmcydocdt LIKE fmcy_t.fmcydocdt, 
   fmcydocno LIKE fmcy_t.fmcydocno, 
   fmcyent LIKE fmcy_t.fmcyent, 
   fmcysite LIKE fmcy_t.fmcysite, 
   fmcystus LIKE fmcy_t.fmcystus, 
   fmcz001 LIKE fmcz_t.fmcz001, 
   fmcz002 LIKE fmcz_t.fmcz002, 
   fmcz003 LIKE fmcz_t.fmcz003, 
   fmcz004 LIKE fmcz_t.fmcz004, 
   fmcz005 LIKE fmcz_t.fmcz005, 
   fmcz006 LIKE fmcz_t.fmcz006, 
   fmcz007 LIKE fmcz_t.fmcz007, 
   fmcz008 LIKE fmcz_t.fmcz008, 
   fmcz009 LIKE fmcz_t.fmcz009, 
   fmcz010 LIKE fmcz_t.fmcz010, 
   fmcz011 LIKE fmcz_t.fmcz011, 
   fmcz012 LIKE fmcz_t.fmcz012, 
   fmcz013 LIKE fmcz_t.fmcz013, 
   fmcz014 LIKE fmcz_t.fmcz014, 
   fmcz015 LIKE fmcz_t.fmcz015, 
   fmcz016 LIKE fmcz_t.fmcz016, 
   fmcz017 LIKE fmcz_t.fmcz017, 
   fmcz018 LIKE fmcz_t.fmcz018, 
   fmcz023 LIKE fmcz_t.fmcz023, 
   fmczseq LIKE fmcz_t.fmczseq, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   l_fmcycomp_ooefl003 LIKE type_t.chr1000, 
   l_fmcysite_ooefl003 LIKE type_t.chr1000, 
   l_fmcz001_ooefl003 LIKE type_t.chr100, 
   l_fmcz004_desc LIKE type_t.chr100, 
   l_fmcy001_fmcy002 LIKE type_t.chr100
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
    FOREACH afmr180_g01_curs INTO sr_s.*
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
       LET sr_s.l_fmcysite_ooefl003 =''
       LET sr_s.l_fmcysite_ooefl003 = s_desc_get_department_desc(sr_s.fmcysite)
       IF NOT cl_null(sr_s.l_fmcysite_ooefl003) THEN
          LET sr_s.l_fmcysite_ooefl003 = sr_s.fmcysite,'.',sr_s.l_fmcysite_ooefl003
       ELSE
          LET sr_s.l_fmcysite_ooefl003 = sr_s.fmcysite
       END IF
       
       LET sr_s.l_fmcycomp_ooefl003 = ''
       LET sr_s.l_fmcycomp_ooefl003 = s_desc_get_department_desc(sr_s.fmcycomp)
       IF NOT cl_null(sr_s.l_fmcycomp_ooefl003) THEN
          LET sr_s.l_fmcycomp_ooefl003 = sr_s.fmcycomp,'.',sr_s.l_fmcycomp_ooefl003
       ELSE
          LET sr_s.l_fmcycomp_ooefl003 = sr_s.fmcycomp
       END IF
       #組織說明
       LET  sr_s.l_fmcz001_ooefl003 = ''
       LET  sr_s.l_fmcz001_ooefl003 = s_desc_get_department_desc(sr_s.fmcz001)
       IF NOT cl_null( sr_s.l_fmcz001_ooefl003) THEN
          LET  sr_s.l_fmcz001_ooefl003 = sr_s.l_fmcz001_ooefl003
       ELSE
          LET  sr_s.l_fmcz001_ooefl003 = sr_s.fmcz001
       END IF
       #顯示類別的文字
       LET sr_s.l_fmcz004_desc = ''
       CALL s_desc_gzcbl004_desc('8872',sr_s.fmcz004) RETURNING sr_s.l_fmcz004_desc
       CASE sr_s.fmcz004
          WHEN '1'
                LET sr_s.l_fmcz004_desc = sr_s.fmcz004,':',sr_s.l_fmcz004_desc
          WHEN '2'
                LET sr_s.l_fmcz004_desc = sr_s.fmcz004,':',sr_s.l_fmcz004_desc
          WHEN '3'
                LET sr_s.l_fmcz004_desc = sr_s.fmcz004,':',sr_s.l_fmcz004_desc
          WHEN '4'
                LET sr_s.l_fmcz004_desc = sr_s.fmcz004,':',sr_s.l_fmcz004_desc
          WHEN '5'
                LET sr_s.l_fmcz004_desc = sr_s.fmcz004,':',sr_s.l_fmcz004_desc
          WHEN '6'
                LET sr_s.l_fmcz004_desc = sr_s.fmcz004,':',sr_s.l_fmcz004_desc
          WHEN '7'
                LET sr_s.l_fmcz004_desc = sr_s.fmcz004,':',sr_s.l_fmcz004_desc          
       END CASE  
       #年度期別
       LET  sr_s.l_fmcy001_fmcy002 =NULL
       LET  sr_s.l_fmcy001_fmcy002 =sr_s.fmcy001,'/',sr_s.fmcy002
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fmcy001 = sr_s.fmcy001
       LET sr[l_cnt].fmcy002 = sr_s.fmcy002
       LET sr[l_cnt].fmcycomp = sr_s.fmcycomp
       LET sr[l_cnt].fmcydocdt = sr_s.fmcydocdt
       LET sr[l_cnt].fmcydocno = sr_s.fmcydocno
       LET sr[l_cnt].fmcyent = sr_s.fmcyent
       LET sr[l_cnt].fmcysite = sr_s.fmcysite
       LET sr[l_cnt].fmcystus = sr_s.fmcystus
       LET sr[l_cnt].fmcz001 = sr_s.fmcz001
       LET sr[l_cnt].fmcz002 = sr_s.fmcz002
       LET sr[l_cnt].fmcz003 = sr_s.fmcz003
       LET sr[l_cnt].fmcz004 = sr_s.fmcz004
       LET sr[l_cnt].fmcz005 = sr_s.fmcz005
       LET sr[l_cnt].fmcz006 = sr_s.fmcz006
       LET sr[l_cnt].fmcz007 = sr_s.fmcz007
       LET sr[l_cnt].fmcz008 = sr_s.fmcz008
       LET sr[l_cnt].fmcz009 = sr_s.fmcz009
       LET sr[l_cnt].fmcz010 = sr_s.fmcz010
       LET sr[l_cnt].fmcz011 = sr_s.fmcz011
       LET sr[l_cnt].fmcz012 = sr_s.fmcz012
       LET sr[l_cnt].fmcz013 = sr_s.fmcz013
       LET sr[l_cnt].fmcz014 = sr_s.fmcz014
       LET sr[l_cnt].fmcz015 = sr_s.fmcz015
       LET sr[l_cnt].fmcz016 = sr_s.fmcz016
       LET sr[l_cnt].fmcz017 = sr_s.fmcz017
       LET sr[l_cnt].fmcz018 = sr_s.fmcz018
       LET sr[l_cnt].fmcz023 = sr_s.fmcz023
       LET sr[l_cnt].fmczseq = sr_s.fmczseq
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].l_fmcycomp_ooefl003 = sr_s.l_fmcycomp_ooefl003
       LET sr[l_cnt].l_fmcysite_ooefl003 = sr_s.l_fmcysite_ooefl003
       LET sr[l_cnt].l_fmcz001_ooefl003 = sr_s.l_fmcz001_ooefl003
       LET sr[l_cnt].l_fmcz004_desc = sr_s.l_fmcz004_desc
       LET sr[l_cnt].l_fmcy001_fmcy002 = sr_s.l_fmcy001_fmcy002
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmr180_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afmr180_g01_rep_data()
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
          START REPORT afmr180_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afmr180_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afmr180_g01_rep
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
 
{<section id="afmr180_g01.rep" readonly="Y" >}
PRIVATE REPORT afmr180_g01_rep(sr1)
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
DEFINE sr5      sr5_r 
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_count          LIKE type_t.num5
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.fmcydocno,sr1.fmczseq
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
        BEFORE GROUP OF sr1.fmcydocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fmcydocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fmcyent=' ,sr1.fmcyent,'{+}fmcydocno=' ,sr1.fmcydocno         
            CALL cl_gr_init_apr(sr1.fmcydocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fmcydocno.before name="rep.b_group.fmcydocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fmcyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcydocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr180_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afmr180_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afmr180_g01_subrep01
           DECLARE afmr180_g01_repcur01 CURSOR FROM g_sql
           FOREACH afmr180_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr180_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afmr180_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afmr180_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fmcydocno.after name="rep.b_group.fmcydocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.fmczseq
 
           #add-point:rep.b_group.fmczseq.before name="rep.b_group.fmczseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.fmczseq.after name="rep.b_group.fmczseq.after"
           
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
                sr1.fmcyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcydocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fmczseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr180_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afmr180_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afmr180_g01_subrep02
           DECLARE afmr180_g01_repcur02 CURSOR FROM g_sql
           FOREACH afmr180_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr180_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afmr180_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afmr180_g01_subrep02
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
                sr1.fmcyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcydocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fmczseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr180_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afmr180_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afmr180_g01_subrep03
           DECLARE afmr180_g01_repcur03 CURSOR FROM g_sql
           FOREACH afmr180_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr180_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afmr180_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afmr180_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmcydocno
 
           #add-point:rep.a_group.fmcydocno.before name="rep.a_group.fmcydocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fmcyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmcydocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr180_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afmr180_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afmr180_g01_subrep04
           DECLARE afmr180_g01_repcur04 CURSOR FROM g_sql
           FOREACH afmr180_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr180_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afmr180_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afmr180_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fmcydocno.after name="rep.a_group.fmcydocno.after"
           LET l_subrep05_show = 'N'
           LET l_sub_sql = ""
           LET l_count = 0                   
           LET g_sql =  "SELECT fmcz005,sum(fmcz006) ",
                        "  FROM fmcz_t ",
                        " WHERE fmczdocno = '",sr1.fmcydocno CLIPPED,"'",
                        "   AND fmczent   = '",sr1.fmcyent   CLIPPED,"'",
                        " GROUP BY fmcz005"
                        
           LET l_sub_sql = " SELECT COUNT(1) FROM (",g_sql,")"    
           PREPARE afmr180_g01_subrep05_cnt_pre FROM l_sub_sql
           EXECUTE afmr180_g01_subrep05_cnt_pre INTO l_count
           FREE afmr180_g01_subrep05_cnt_pre
           IF l_count > 0 THEN
              LET l_subrep05_show = 'Y'
           END IF          
           PRINTX l_subrep05_show           
           LET l_count = 0
           START REPORT afmr180_g01_subrep05
           DECLARE afmr180_g01_subrep05 CURSOR FROM g_sql
           FOREACH afmr180_g01_subrep05 INTO sr5.* 
              IF l_count = 0 THEN
                 LET sr5.fmcz005_show = 'Y'
              ELSE
                 LET sr5.fmcz005_show = 'N'
              END IF                                
              LET l_count = 1
              IF STATUS THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "afmr180_g01_repcur05:"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()                  
                  EXIT FOREACH 
              END IF
               OUTPUT TO REPORT afmr180_g01_subrep05(sr5.*)
           END FOREACH
           FINISH REPORT afmr180_g01_subrep05
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmczseq
 
           #add-point:rep.a_group.fmczseq.before name="rep.a_group.fmczseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.fmczseq.after name="rep.a_group.fmczseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afmr180_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afmr180_g01_subrep01(sr2)
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
PRIVATE REPORT afmr180_g01_subrep02(sr2)
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
PRIVATE REPORT afmr180_g01_subrep03(sr2)
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
PRIVATE REPORT afmr180_g01_subrep04(sr2)
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
 
{<section id="afmr180_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afmr180_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 幣別合計子報表
# Usage..........: CALL afmr180_g01_subrep05(sr5)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/04 By 08729
# Modify.........:
################################################################################
PRIVATE REPORT afmr180_g01_subrep05(sr5)
DEFINE sr5  sr5_r
DEFINE l_glaa001      LIKE glaa_t.glaa001
DEFINE l_fmcz006_sum  LIKE fmcz_t.fmcz006

    ORDER EXTERNAL BY sr5.fmcz005
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

 
{</section>}
 
