#該程式未解開Section, 採用最新樣板產出!
{<section id="aglr500_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-12-31 18:08:05), PR版次:0001(2016-01-13 18:18:17)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: aglr500_g01
#+ Description: ...
#+ Creator....: 02159(2015-12-30 18:50:46)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="aglr500_g01.global" readonly="Y" >}
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
   gldp001 LIKE gldp_t.gldp001, 
   gldp002 LIKE gldp_t.gldp002, 
   gldp003 LIKE gldp_t.gldp003, 
   gldp004 LIKE gldp_t.gldp004, 
   gldp005 LIKE gldp_t.gldp005, 
   gldp006 LIKE gldp_t.gldp006, 
   gldp007 LIKE gldp_t.gldp007, 
   gldp008 LIKE gldp_t.gldp008, 
   gldp009 LIKE gldp_t.gldp009, 
   gldp010 LIKE gldp_t.gldp010, 
   gldp011 LIKE gldp_t.gldp011, 
   gldp012 LIKE gldp_t.gldp012, 
   gldp013 LIKE gldp_t.gldp013, 
   gldp014 LIKE gldp_t.gldp014, 
   gldp015 LIKE gldp_t.gldp015, 
   gldp016 LIKE gldp_t.gldp016, 
   gldpdocdt LIKE gldp_t.gldpdocdt, 
   gldpdocno LIKE gldp_t.gldpdocno, 
   gldpent LIKE gldp_t.gldpent, 
   gldpld LIKE gldp_t.gldpld, 
   gldpstus LIKE gldp_t.gldpstus, 
   l_glaal002 LIKE glaal_t.glaal002, 
   l_gldqdocno LIKE gldq_t.gldqdocno, 
   l_gldqseq LIKE gldq_t.gldqseq, 
   l_gldq023 LIKE gldq_t.gldq023, 
   l_gldq001 LIKE gldq_t.gldq001, 
   l_gldq001_desc LIKE type_t.chr500, 
   l_gldq017 LIKE gldq_t.gldq017, 
   l_gldq018 LIKE gldq_t.gldq018, 
   l_date LIKE type_t.chr500
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
 
{<section id="aglr500_g01.main" readonly="Y" >}
PUBLIC FUNCTION aglr500_g01(p_arg1)
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
   
   LET g_rep_code = "aglr500_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aglr500_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aglr500_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aglr500_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglr500_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglr500_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT gldp001,gldp002,gldp003,gldp004,gldp005,gldp006,gldp007,gldp008,gldp009,gldp010, 
                           gldp011,gldp012,gldp013,gldp014,gldp015,gldp016,gldpdocdt,gldpdocno,gldpent,gldpld,gldpstus,
                           glaal002,gldqdocno,gldqseq,gldq023,gldq001,'',gldq017,gldq018,''"
#   #end add-point
#   LET g_select = " SELECT gldp001,gldp002,gldp003,gldp004,gldp005,gldp006,gldp007,gldp008,gldp009,gldp010, 
#       gldp011,gldp012,gldp013,gldp014,gldp015,gldp016,gldpdocdt,gldpdocno,gldpent,gldpld,gldpstus,'', 
#       '',NULL,'','','',0,0,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM gldp_t
                   LEFT OUTER JOIN gldq_t ON gldpent = gldqent AND gldpdocno = gldqdocno
                   LEFT OUTER JOIN glaal_t ON glaalent = gldpent AND glaalld = gldpld AND glaal001 = '" ,g_dlang,"'"
#   #end add-point
#    LET g_from = " FROM gldp_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_order = " ORDER BY gldpdocno,gldqseq"
#   #end add-point
#    LET g_order = " ORDER BY gldpdocno"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("gldp_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aglr500_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aglr500_g01_curs CURSOR FOR aglr500_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglr500_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglr500_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   gldp001 LIKE gldp_t.gldp001, 
   gldp002 LIKE gldp_t.gldp002, 
   gldp003 LIKE gldp_t.gldp003, 
   gldp004 LIKE gldp_t.gldp004, 
   gldp005 LIKE gldp_t.gldp005, 
   gldp006 LIKE gldp_t.gldp006, 
   gldp007 LIKE gldp_t.gldp007, 
   gldp008 LIKE gldp_t.gldp008, 
   gldp009 LIKE gldp_t.gldp009, 
   gldp010 LIKE gldp_t.gldp010, 
   gldp011 LIKE gldp_t.gldp011, 
   gldp012 LIKE gldp_t.gldp012, 
   gldp013 LIKE gldp_t.gldp013, 
   gldp014 LIKE gldp_t.gldp014, 
   gldp015 LIKE gldp_t.gldp015, 
   gldp016 LIKE gldp_t.gldp016, 
   gldpdocdt LIKE gldp_t.gldpdocdt, 
   gldpdocno LIKE gldp_t.gldpdocno, 
   gldpent LIKE gldp_t.gldpent, 
   gldpld LIKE gldp_t.gldpld, 
   gldpstus LIKE gldp_t.gldpstus, 
   l_glaal002 LIKE glaal_t.glaal002, 
   l_gldqdocno LIKE gldq_t.gldqdocno, 
   l_gldqseq LIKE gldq_t.gldqseq, 
   l_gldq023 LIKE gldq_t.gldq023, 
   l_gldq001 LIKE gldq_t.gldq001, 
   l_gldq001_desc LIKE type_t.chr500, 
   l_gldq017 LIKE gldq_t.gldq017, 
   l_gldq018 LIKE gldq_t.gldq018, 
   l_date LIKE type_t.chr500
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_yy              LIKE type_t.num5 
DEFINE l_mm              LIKE type_t.num5
DEFINE l_dd              LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aglr500_g01_curs INTO sr_s.*
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
       #M:個體公司餘額調整的資料抓取帳套
       IF sr_s.gldp006 = 'M' THEN
          LET sr_s.l_glaal002 = s_desc_get_ld_desc(sr_s.gldp002)
       END IF
       #科目說明
       LET sr_s.l_gldq001_desc = s_desc_get_account_desc(sr_s.gldpld,sr_s.l_gldq001)
       #組日期
       LET l_yy = YEAR(sr_s.gldpdocdt)
       LET l_mm = MONTH(sr_s.gldpdocdt)
       LET l_dd = DAY(sr_s.gldpdocdt)
       LET sr_s.l_date = l_yy,cl_getmsg("agl-00274",g_dlang),l_mm,cl_getmsg("agl-00275",g_dlang),l_dd,cl_getmsg("agl-00276",g_dlang)       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].gldp001 = sr_s.gldp001
       LET sr[l_cnt].gldp002 = sr_s.gldp002
       LET sr[l_cnt].gldp003 = sr_s.gldp003
       LET sr[l_cnt].gldp004 = sr_s.gldp004
       LET sr[l_cnt].gldp005 = sr_s.gldp005
       LET sr[l_cnt].gldp006 = sr_s.gldp006
       LET sr[l_cnt].gldp007 = sr_s.gldp007
       LET sr[l_cnt].gldp008 = sr_s.gldp008
       LET sr[l_cnt].gldp009 = sr_s.gldp009
       LET sr[l_cnt].gldp010 = sr_s.gldp010
       LET sr[l_cnt].gldp011 = sr_s.gldp011
       LET sr[l_cnt].gldp012 = sr_s.gldp012
       LET sr[l_cnt].gldp013 = sr_s.gldp013
       LET sr[l_cnt].gldp014 = sr_s.gldp014
       LET sr[l_cnt].gldp015 = sr_s.gldp015
       LET sr[l_cnt].gldp016 = sr_s.gldp016
       LET sr[l_cnt].gldpdocdt = sr_s.gldpdocdt
       LET sr[l_cnt].gldpdocno = sr_s.gldpdocno
       LET sr[l_cnt].gldpent = sr_s.gldpent
       LET sr[l_cnt].gldpld = sr_s.gldpld
       LET sr[l_cnt].gldpstus = sr_s.gldpstus
       LET sr[l_cnt].l_glaal002 = sr_s.l_glaal002
       LET sr[l_cnt].l_gldqdocno = sr_s.l_gldqdocno
       LET sr[l_cnt].l_gldqseq = sr_s.l_gldqseq
       LET sr[l_cnt].l_gldq023 = sr_s.l_gldq023
       LET sr[l_cnt].l_gldq001 = sr_s.l_gldq001
       LET sr[l_cnt].l_gldq001_desc = sr_s.l_gldq001_desc
       LET sr[l_cnt].l_gldq017 = sr_s.l_gldq017
       LET sr[l_cnt].l_gldq018 = sr_s.l_gldq018
       LET sr[l_cnt].l_date = sr_s.l_date
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglr500_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglr500_g01_rep_data()
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
          START REPORT aglr500_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aglr500_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aglr500_g01_rep
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
 
{<section id="aglr500_g01.rep" readonly="Y" >}
PRIVATE REPORT aglr500_g01_rep(sr1)
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
    ORDER EXTERNAL BY sr1.gldpdocno
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
        BEFORE GROUP OF sr1.gldpdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            #報表名稱
            CASE sr1.gldp005
               WHEN '1'
                  LET g_grPageHeader.title0201 = s_desc_gzcbl004_desc('9974','1'),cl_getmsg("adz-00238",g_dlang)
               WHEN '2'
                  LET g_grPageHeader.title0201 = s_desc_gzcbl004_desc('9974','2'),cl_getmsg("adz-00238",g_dlang)
               WHEN '3'
                  LET g_grPageHeader.title0201 = s_desc_gzcbl004_desc('9974','3'),cl_getmsg("adz-00238",g_dlang)
               WHEN '4'
                  LET g_grPageHeader.title0201 = s_desc_gzcbl004_desc('9974','4'),cl_getmsg("adz-00238",g_dlang)
            END CASE
            #end add-point:rep.header 
            LET g_rep_docno = sr1.gldpdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'gldpent=' ,sr1.gldpent,'{+}gldpdocno=' ,sr1.gldpdocno         
            CALL cl_gr_init_apr(sr1.gldpdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.gldpdocno.before name="rep.b_group.gldpdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.gldpent CLIPPED ,"'", " AND  ooff003 = '", sr1.gldpdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr500_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aglr500_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aglr500_g01_subrep01
           DECLARE aglr500_g01_repcur01 CURSOR FROM g_sql
           FOREACH aglr500_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr500_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aglr500_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aglr500_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.gldpdocno.after name="rep.b_group.gldpdocno.after"
           
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
                sr1.gldpent CLIPPED ,"'", " AND  ooff003 = '", sr1.gldpdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr500_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aglr500_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aglr500_g01_subrep02
           DECLARE aglr500_g01_repcur02 CURSOR FROM g_sql
           FOREACH aglr500_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr500_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aglr500_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aglr500_g01_subrep02
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
                sr1.gldpent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr500_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aglr500_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aglr500_g01_subrep03
           DECLARE aglr500_g01_repcur03 CURSOR FROM g_sql
           FOREACH aglr500_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr500_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aglr500_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aglr500_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.gldpdocno
 
           #add-point:rep.a_group.gldpdocno.before name="rep.a_group.gldpdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.gldpent CLIPPED ,"'", " AND  ooff003 = '", sr1.gldpdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr500_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aglr500_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aglr500_g01_subrep04
           DECLARE aglr500_g01_repcur04 CURSOR FROM g_sql
           FOREACH aglr500_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr500_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aglr500_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aglr500_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.gldpdocno.after name="rep.a_group.gldpdocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aglr500_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aglr500_g01_subrep01(sr2)
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
PRIVATE REPORT aglr500_g01_subrep02(sr2)
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
PRIVATE REPORT aglr500_g01_subrep03(sr2)
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
PRIVATE REPORT aglr500_g01_subrep04(sr2)
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
 
{<section id="aglr500_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aglr500_g01.other_report" readonly="Y" >}

 
{</section>}
 
