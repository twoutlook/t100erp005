#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr910_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-16 15:34:32), PR版次:0003(2016-05-16 15:43:06)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: ainr910_g01
#+ Description: ...
#+ Creator....: 05423(2014-12-16 10:05:59)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ainr910_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160321-00032#1   2016-3-22  zhujing mod  控制子报表制造批序号个数与现有库存量一致
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
   inpldocno LIKE inpl_t.inpldocno, 
   inpl008 LIKE inpl_t.inpl008, 
   inpl033 LIKE inpl_t.inpl033, 
   inpl053 LIKE inpl_t.inpl053, 
   inpl032 LIKE inpl_t.inpl032, 
   l_inpl032_desc LIKE type_t.chr30, 
   inpl052 LIKE inpl_t.inpl052, 
   l_inpl053_desc LIKE type_t.chr30, 
   inplseq LIKE inpl_t.inplseq, 
   inpl001 LIKE inpl_t.inpl001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inpl005 LIKE inpl_t.inpl005, 
   l_inpl005_desc LIKE type_t.chr30, 
   inpl006 LIKE inpl_t.inpl006, 
   l_inpl006_desc LIKE type_t.chr30, 
   inpl007 LIKE inpl_t.inpl007, 
   inpl003 LIKE inpl_t.inpl003, 
   inaf_t_inaf011 LIKE inaf_t.inaf011, 
   inpl009 LIKE inpl_t.inpl009, 
   inpl010 LIKE inpl_t.inpl010, 
   inpl030 LIKE inpl_t.inpl030, 
   inpl050 LIKE inpl_t.inpl050, 
   inpj015 LIKE inpj_t.inpj015, 
   inpj014 LIKE inpj_t.inpj014, 
   inplent LIKE inpl_t.inplent, 
   inplsite LIKE inpl_t.inplsite, 
   inpl002 LIKE inpl_t.inpl002, 
   inpl011 LIKE inpl_t.inpl011, 
   inpl012 LIKE inpl_t.inpl012, 
   inpl031 LIKE inpl_t.inpl031, 
   inpl051 LIKE inpl_t.inpl051
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr STRING                   #subrep
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
   inaodocno LIKE inao_t.inaodocno,
   inao008_1 LIKE inao_t.inao008,            #製造批號
   inao009_1 LIKE inao_t.inao009,            #製造序號
   inao008_2 LIKE inao_t.inao008,            #製造批號
   inao009_2 LIKE inao_t.inao009,            #製造序號
   inao008_3 LIKE inao_t.inao008,            #製造批號
   inao009_3 LIKE inao_t.inao009,            #製造序號 
   l_inao008_1_inao009_1 LIKE type_t.chr100, #批號/序號 1
   l_inao008_2_inao009_2 LIKE type_t.chr100, #批號/序號 2 
   l_inao008_3_inao009_3 LIKE type_t.chr100  #批號/序號 3     
END RECORD
TYPE sr4_r RECORD
   inaodocno LIKE inao_t.inaodocno,
   inao008_1 LIKE inao_t.inao008,            #製造批號
   inao012_1 LIKE inao_t.inao012,            #初盤數量
   inao013_1 LIKE inao_t.inao012,            #復盤數量
   inao008_2 LIKE inao_t.inao008,            #製造批號
   inao012_2 LIKE inao_t.inao012,            #初盤數量
   inao013_2 LIKE inao_t.inao012,            #復盤數量
   inao008_3 LIKE inao_t.inao008,            #製造批號
   inao012_3 LIKE inao_t.inao012,            #初盤數量 
   inao013_3 LIKE inao_t.inao012,            #復盤數量
   l_inao008_1_inao012_1 LIKE type_t.chr100, #批號/數量 1
   l_inao008_2_inao012_2 LIKE type_t.chr100, #批號/數量 2 
   l_inao008_3_inao012_3 LIKE type_t.chr100  #批號/數量 3       
END RECORD 
TYPE sr5_r RECORD
   inaodocno LIKE inao_t.inaodocno,
   inao008 LIKE inao_t.inao008,          #製造批號
   inao009 LIKE inao_t.inao009           #製造序號
   END RECORD
TYPE sr6_r RECORD
   inaodocno LIKE inao_t.inaodocno,
   inao008 LIKE inao_t.inao008,          #製造批號
   inao012 LIKE inao_t.inao012,          #初盤數量
   inao013 LIKE inao_t.inao012           #復盤數量
END RECORD
DEFINE sr5 DYNAMIC ARRAY OF sr5_r
DEFINE sr6 DYNAMIC ARRAY OF sr6_r
#end add-point
 
{</section>}
 
{<section id="ainr910_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr910_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr  subrep
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
   
   LET g_rep_code = "ainr910_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr910_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr910_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr910_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr910_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr910_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT inpsdocno,inps001,inps007,NULL,inps006,(trim(inpS006)||'.'||trim(a1.ooag011)),NULL,NULL,inplseq,inpl001, 
       imaal_t.imaal003,imaal_t.imaal004,inpl005,(trim(inpl005)||'.'||trim(inayl003)),inpl006,(trim(inpl006)||'.'||trim(inab003)),inpl007,inpl003,inaf_t.inaf011,inpl009, 
       inpl010,inpl030,inpl050,inpj015,inpj014,inplent,inplsite,inpl002,inpl011,inpl012,inpl031,inpl051"
#   #end add-point
#   LET g_select = " SELECT inpldocno,inpl008,inpl033,inpl053,inpl032,NULL,inpl052,NULL,inplseq,inpl001, 
#       imaal_t.imaal003,imaal_t.imaal004,inpl005,NULL,inpl006,NULL,inpl007,inpl003,inaf_t.inaf011,inpl009, 
#       inpl010,inpl030,inpl050,inpj015,inpj014,inplent,inplsite,inpl002,inpl011,inpl012,inpl031,inpl051" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM inps_t LEFT OUTER JOIN inpl_t ON inpsdocno = inpldocno AND inpssite = inplsite AND inpsent = inplent ",
                 "             LEFT OUTER JOIN inpj_t ON inpldocno = inpjdocno AND inplsite = inpjsite AND inplent = inpjent ",
                 "             LEFT OUTER JOIN inaf_t ON inpl001 = inaf003 AND inpl002 = inaf004 AND inpl005 = inaf001 AND inpl006 = inaf002 AND inplent = inafent AND inplsite = inafsite ",
                 "             LEFT OUTER JOIN inab_t ON inpl005 = inab001 AND inpl006 = inab002 AND inplent = inabent AND inplsite = inabsite ",
                 "             LEFT OUTER JOIN ooag_t a1 ON inps006 = a1.ooag001 AND inpsent = a1.ooagent ",
#                 "             LEFT OUTER JOIN ooag_t a2 ON inpl052 = a2.ooag001 AND inplent = a2.ooagent ",
                 "             LEFT OUTER JOIN imaf_t ON inpl001 = imaf001 AND inplent = imafent AND inplsite = imafsite ",
                 "             LEFT OUTER JOIN imaal_t ON inpl001 = imaal001 AND inplent = imaalent AND imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN inayl_t ON inpl005 = inayl001 AND inplent = inaylent AND inayl002 = '",g_dlang,"' " #還有主畫面上面的表格喲~~~
#   #end add-point
#    LET g_from = " FROM inpl_t,inpj_t,inaf_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY inpldocno,inplseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inpl_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr910_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr910_g01_curs CURSOR FOR ainr910_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr910_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr910_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inpldocno LIKE inpl_t.inpldocno, 
   inpl008 LIKE inpl_t.inpl008, 
   inpl033 LIKE inpl_t.inpl033, 
   inpl053 LIKE inpl_t.inpl053, 
   inpl032 LIKE inpl_t.inpl032, 
   l_inpl032_desc LIKE type_t.chr30, 
   inpl052 LIKE inpl_t.inpl052, 
   l_inpl053_desc LIKE type_t.chr30, 
   inplseq LIKE inpl_t.inplseq, 
   inpl001 LIKE inpl_t.inpl001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inpl005 LIKE inpl_t.inpl005, 
   l_inpl005_desc LIKE type_t.chr30, 
   inpl006 LIKE inpl_t.inpl006, 
   l_inpl006_desc LIKE type_t.chr30, 
   inpl007 LIKE inpl_t.inpl007, 
   inpl003 LIKE inpl_t.inpl003, 
   inaf_t_inaf011 LIKE inaf_t.inaf011, 
   inpl009 LIKE inpl_t.inpl009, 
   inpl010 LIKE inpl_t.inpl010, 
   inpl030 LIKE inpl_t.inpl030, 
   inpl050 LIKE inpl_t.inpl050, 
   inpj015 LIKE inpj_t.inpj015, 
   inpj014 LIKE inpj_t.inpj014, 
   inplent LIKE inpl_t.inplent, 
   inplsite LIKE inpl_t.inplsite, 
   inpl002 LIKE inpl_t.inpl002, 
   inpl011 LIKE inpl_t.inpl011, 
   inpl012 LIKE inpl_t.inpl012, 
   inpl031 LIKE inpl_t.inpl031, 
   inpl051 LIKE inpl_t.inpl051
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
    FOREACH ainr910_g01_curs INTO sr_s.*
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
       IF sr_s.l_inpl032_desc = '.' THEN 
          LET sr_s.l_inpl032_desc = sr_s.inpl032
       END IF
       IF sr_s.l_inpl053_desc = '.' THEN 
          LET sr_s.l_inpl053_desc = sr_s.inpl052
       END IF
       IF sr_s.l_inpl005_desc = '.' THEN 
          LET sr_s.l_inpl005_desc = sr_s.inpl005
       END IF
       IF sr_s.l_inpl006_desc = '.' THEN 
          LET sr_s.l_inpl006_desc = sr_s.inpl006
       END IF
       IF sr_s.inpj014 = 'N' THEN
          LET sr_s.inpl050 = NULL
          LET sr_s.inpl052 = NULL
          LET sr_s.inpl053 = NULL
          LET sr_s.inpl051 = NULL
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].inpldocno = sr_s.inpldocno
       LET sr[l_cnt].inpl008 = sr_s.inpl008
       LET sr[l_cnt].inpl033 = sr_s.inpl033
       LET sr[l_cnt].inpl053 = sr_s.inpl053
       LET sr[l_cnt].inpl032 = sr_s.inpl032
       LET sr[l_cnt].l_inpl032_desc = sr_s.l_inpl032_desc
       LET sr[l_cnt].inpl052 = sr_s.inpl052
       LET sr[l_cnt].l_inpl053_desc = sr_s.l_inpl053_desc
       LET sr[l_cnt].inplseq = sr_s.inplseq
       LET sr[l_cnt].inpl001 = sr_s.inpl001
       LET sr[l_cnt].imaal_t_imaal003 = sr_s.imaal_t_imaal003
       LET sr[l_cnt].imaal_t_imaal004 = sr_s.imaal_t_imaal004
       LET sr[l_cnt].inpl005 = sr_s.inpl005
       LET sr[l_cnt].l_inpl005_desc = sr_s.l_inpl005_desc
       LET sr[l_cnt].inpl006 = sr_s.inpl006
       LET sr[l_cnt].l_inpl006_desc = sr_s.l_inpl006_desc
       LET sr[l_cnt].inpl007 = sr_s.inpl007
       LET sr[l_cnt].inpl003 = sr_s.inpl003
       LET sr[l_cnt].inaf_t_inaf011 = sr_s.inaf_t_inaf011
       LET sr[l_cnt].inpl009 = sr_s.inpl009
       LET sr[l_cnt].inpl010 = sr_s.inpl010
       LET sr[l_cnt].inpl030 = sr_s.inpl030
       LET sr[l_cnt].inpl050 = sr_s.inpl050
       LET sr[l_cnt].inpj015 = sr_s.inpj015
       LET sr[l_cnt].inpj014 = sr_s.inpj014
       LET sr[l_cnt].inplent = sr_s.inplent
       LET sr[l_cnt].inplsite = sr_s.inplsite
       LET sr[l_cnt].inpl002 = sr_s.inpl002
       LET sr[l_cnt].inpl011 = sr_s.inpl011
       LET sr[l_cnt].inpl012 = sr_s.inpl012
       LET sr[l_cnt].inpl031 = sr_s.inpl031
       LET sr[l_cnt].inpl051 = sr_s.inpl051
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr910_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr910_g01_rep_data()
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
          START REPORT ainr910_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr910_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr910_g01_rep
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
 
{<section id="ainr910_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr910_g01_rep(sr1)
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
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_count           INTEGER
DEFINE l_subrep05_show   LIKE type_t.chr1
DEFINE l_subrep06_show   LIKE type_t.chr1

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.inpldocno,sr1.inplseq
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
        BEFORE GROUP OF sr1.inpldocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.inpldocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'inplent=' ,sr1.inplent,'{+}inplsite=' ,sr1.inplsite,'{+}inpldocno=' ,sr1.inpldocno,'{+}inplseq=' ,sr1.inplseq         
            CALL cl_gr_init_apr(sr1.inpldocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.inpldocno.before name="rep.b_group.inpldocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.inplent CLIPPED ,"'", " AND  ooff003 = '", sr1.inpldocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr910_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr910_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr910_g01_subrep01
           DECLARE ainr910_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr910_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr910_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr910_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr910_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.inpldocno.after name="rep.b_group.inpldocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.inplseq
 
           #add-point:rep.b_group.inplseq.before name="rep.b_group.inplseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.inplseq.after name="rep.b_group.inplseq.after"
           
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
                sr1.inplent CLIPPED ,"'", " AND  ooff003 = '", sr1.inpldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.inplseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr910_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr910_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr910_g01_subrep02
           DECLARE ainr910_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr910_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr910_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr910_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr910_g01_subrep02
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
                sr1.inplent CLIPPED ,"'", " AND  ooff003 = '", sr1.inpldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.inplseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr910_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr910_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr910_g01_subrep03
           DECLARE ainr910_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr910_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr910_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr910_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr910_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
                     
            LET g_sql = "SELECT inpmdocno,inpm008,inpm009",
                        "  FROM inpm_t ",
                        " WHERE inpment     = '",sr1.inplent      CLIPPED,"'",                                               
                        "   AND inpmsite    = '",sr1.inplsite     CLIPPED,"'",
                        "   AND inpmdocno   = '",sr1.inpldocno        CLIPPED,"'",                    
                        "   AND inpmseq     = '",sr1.inplseq      CLIPPED,"'",
                        "   AND inpm008 IS NOT NULL AND inpm008 <> ' ' ",
                        "   AND inpm009 IS NOT NULL AND inpm009 <> ' ' ",
                        "   AND inpm012 > 0 "         #160321-00032#1   zhujing add
                        
           LET l_sub_sql = "SELECT COUNT(inpm009) FROM (",g_sql,")"
           PREPARE ainr910_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE ainr910_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 AND tm.pr = 'Y' AND l_subrep06_show = 'N' THEN 
              LET l_subrep05_show ="Y"
           ELSE 
              LET l_subrep05_show ="N"
           END IF                       
           PRINTX l_subrep05_show 
           START REPORT ainr910_g01_subrep05           
           IF tm.pr ="Y" THEN                     

              LET l_ac = 1                              
              CALL sr5.clear()                 
              DECLARE ainr910_g01_repcur05 CURSOR FROM g_sql
              FOREACH ainr910_g01_repcur05 INTO sr5[l_ac].*  
                 LET l_ac = l_ac+1                                
              END FOREACH   
          
               
              LET l_ac = l_ac-1               
              LET l_i = 1                       
              IF l_ac > 0 THEN      
                 WHILE TRUE                         
                    INITIALIZE sr3.* TO NULL
                    LET sr3.inaodocno = sr5[l_i].inaodocno
                    LET sr3.inao008_1 = sr5[l_i].inao008
                    LET sr3.inao009_1 = sr5[l_i].inao009
                    LET sr3.l_inao008_1_inao009_1  = sr3.inao008_1  , "/" , sr3.inao009_1                                                                                         
                    IF l_i+1 <= l_ac THEN    
                       LET sr3.inaodocno = sr5[l_i+1].inaodocno
                       LET sr3.inao008_2 = sr5[l_i+1].inao008
                       LET sr3.inao009_2 = sr5[l_i+1].inao009
                       LET sr3.l_inao008_2_inao009_2 =  sr3.inao008_2 , "/" , sr3.inao009_2
                    END IF
                    
                    IF l_i+2 <= l_ac THEN    
                       LET sr3.inaodocno = sr5[l_i+2].inaodocno
                       LET sr3.inao008_3 = sr5[l_i+2].inao008
                       LET sr3.inao009_3 = sr5[l_i+2].inao009                  
                       LET sr3.l_inao008_3_inao009_3 = sr3.inao008_3 , "/" , sr3.inao009_3
                    END IF              
                           
                    OUTPUT TO REPORT ainr910_g01_subrep05(sr3.*)              
                    LET l_i = l_i + 3
                    IF l_i > l_ac THEN  
                       EXIT WHILE
                    END IF                     
                 END  WHILE                                                
              END IF                    
           END IF                      
           FINISH REPORT ainr910_g01_subrep05

           LET g_sql = "SELECT inpmdocno,inpm008,inpm030,inpm050",
                       "  FROM inpm_t ",
                       " WHERE inpment     = '",sr1.inplent      CLIPPED,"'",                                               
                       "   AND inpmsite    = '",sr1.inplsite     CLIPPED,"'",
                       "   AND inpmdocno   = '",sr1.inpldocno        CLIPPED,"'",                    
                       "   AND inpmseq     = '",sr1.inplseq      CLIPPED,"'",
                       "   AND inpm008 IS NOT NULL AND inpm008 <> ' ' ",
                       "   AND inpm012 > 0 "         #160321-00032#1   zhujing add
                                              
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr910_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE ainr910_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 AND tm.pr = 'Y' AND l_subrep05_show = 'N' THEN 
              LET l_subrep06_show ="Y"
           ELSE 
              LET l_subrep06_show ="N"
           END IF                       
           PRINTX l_subrep06_show      
           START REPORT ainr910_g01_subrep06          
           IF tm.pr ="Y" THEN          
            
              LET l_ac = 1                              
              CALL sr6.clear()                 
              DECLARE ainr910_g01_repcur06 CURSOR FROM g_sql
              FOREACH ainr910_g01_repcur06 INTO sr6[l_ac].*
                  IF sr1.inpj014 = 'N' THEN
                     LET sr6[l_ac].inao013 = NULL
                  END IF
                  LET l_ac = l_ac+1  
                  
              END FOREACH  
              
              LET l_ac = l_ac-1               
              LET l_i = 1                           
              IF l_ac > 0 THEN
                 WHILE TRUE                         
                    INITIALIZE sr4.* TO NULL
                    LET sr4.inaodocno = sr6[l_i].inaodocno
                    LET sr4.inao008_1 = sr6[l_i].inao008
                    LET sr4.inao012_1 = sr6[l_i].inao012
                    LET sr4.inao013_1 = sr6[l_i].inao013
                    LET sr4.l_inao008_1_inao012_1  = sr4.inao008_1  , "/" , sr4.inao012_1 ,"/",sr4.inao013_1                                                                                        
                    IF l_i+1 <= l_ac THEN    
                       LET sr4.inaodocno = sr6[l_i].inaodocno
                       LET sr4.inao008_2 = sr6[l_i+1].inao008
                       LET sr4.inao012_2 = sr6[l_i+1].inao012
                       LET sr4.inao013_2 = sr6[l_i+1].inao013
                       LET sr4.l_inao008_2_inao012_2 =  sr4.inao008_2 , "/" , sr4.inao012_2,"/",sr4.inao013_2                                    
                    END IF
                    
                    IF l_i+2 <= l_ac THEN    
                       LET sr4.inaodocno = sr6[l_i].inaodocno
                       LET sr4.inao008_3 = sr6[l_i+2].inao008
                       LET sr4.inao012_3 = sr6[l_i+2].inao012                  
                       LET sr4.inao013_3 = sr6[l_i+2].inao013                  
                       LET sr4.l_inao008_3_inao012_3 = sr4.inao008_3 , "/" , sr4.inao012_3,"/",sr4.inao013_3     
                    END IF              
                           
                    OUTPUT TO REPORT ainr910_g01_subrep06(sr4.*)              
                    LET l_i = l_i + 3
                    IF l_i > l_ac THEN  
                       EXIT WHILE
                    END IF                     
                 END  WHILE 
              END IF                    
           END IF
                       
           FINISH REPORT ainr910_g01_subrep06  
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inpldocno
 
           #add-point:rep.a_group.inpldocno.before name="rep.a_group.inpldocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.inplent CLIPPED ,"'", " AND  ooff003 = '", sr1.inpldocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr910_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr910_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr910_g01_subrep04
           DECLARE ainr910_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr910_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr910_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr910_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr910_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.inpldocno.after name="rep.a_group.inpldocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inplseq
 
           #add-point:rep.a_group.inplseq.before name="rep.a_group.inplseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.inplseq.after name="rep.a_group.inplseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr910_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr910_g01_subrep01(sr2)
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
PRIVATE REPORT ainr910_g01_subrep02(sr2)
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
PRIVATE REPORT ainr910_g01_subrep03(sr2)
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
PRIVATE REPORT ainr910_g01_subrep04(sr2)
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
 
{<section id="ainr910_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="ainr910_g01.other_report" readonly="Y" >}

#subrep05
PRIVATE REPORT ainr910_g01_subrep05(sr3)
   DEFINE sr3 sr3_r
   ORDER EXTERNAL BY sr3.inaodocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.*
END REPORT

#subrep05
PRIVATE REPORT ainr910_g01_subrep06(sr4)
   DEFINE sr4 sr4_r
   ORDER EXTERNAL BY sr4.inaodocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
END REPORT

 
{</section>}
 