#該程式未解開Section, 採用最新樣板產出!
{<section id="asrr340_g02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-01-13 15:06:51), PR版次:0001(2015-04-28 10:38:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: asrr340_g02
#+ Description: ...
#+ Creator....: 05423(2015-01-13 10:41:13)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="asrr340_g02.global" readonly="Y" >}
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
   sfeadocno LIKE sfea_t.sfeadocno, 
   sfeadocdt LIKE sfea_t.sfeadocdt, 
   l_ooff013 LIKE type_t.chr100, 
   sfea002 LIKE sfea_t.sfea002, 
   l_sfea002_desc LIKE type_t.chr30, 
   sfea003 LIKE sfea_t.sfea003, 
   l_sfea003_desc LIKE type_t.chr50, 
   sfea006 LIKE sfea_t.sfea006, 
   l_sfea006_desc LIKE type_t.chr30, 
   sfebseq LIKE sfeb_t.sfebseq, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   l_sfeb005_show LIKE type_t.chr2, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfeb021 LIKE sfeb_t.sfeb021, 
   l_sfeb021_show LIKE type_t.chr2, 
   sfeb009 LIKE sfeb_t.sfeb009, 
   sfeb012 LIKE sfeb_t.sfeb012, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb022 LIKE sfeb_t.sfeb022, 
   l_sfeb022_show LIKE type_t.chr2, 
   sfeaent LIKE sfea_t.sfeaent
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr LIKE type_t.chr2          #pr
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
 TYPE sr3_r RECORD                          #子報表一變數
   sfecseq1 LIKE sfec_t.sfecseq1,
   sfec002  LIKE sfec_t.sfec002,
   sfec003  LIKE sfec_t.sfec003,
   l_sfec003_desc1   LIKE type_t.chr30,
   l_sfec003_desc2   LIKE type_t.chr30,
   sfec009  LIKE sfec_t.sfec009,
   sfec011  LIKE sfec_t.sfec011,
   sfec012  LIKE sfec_t.sfec012,
   l_sfec012_desc LIKE type_t.chr50,
   sfec013  LIKE sfec_t.sfec013,
   l_sfec013_desc LIKE type_t.chr50,
   sfec014  LIKE sfec_t.sfec014,
   l_sfec014_show LIKE type_t.chr2,
   sfec015  LIKE sfec_t.sfec015,
   l_sfec015_show LIKE type_t.chr2
END RECORD
 
 TYPE sr4_r RECORD                          #子報表二變數
   inaoseq1 LIKE inao_t.inaoseq1,
   inao008  LIKE inao_t.inao008,
   inao009  LIKE inao_t.inao009,
   inao010  LIKE inao_t.inao010,
   inao012  LIKE inao_t.inao012
END RECORD

#end add-point
 
{</section>}
 
{<section id="asrr340_g02.main" readonly="Y" >}
PUBLIC FUNCTION asrr340_g02(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.pr  pr
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
   
   LET g_rep_code = "asrr340_g02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asrr340_g02_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asrr340_g02_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asrr340_g02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asrr340_g02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asrr340_g02_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT sfeadocno,sfeadocdt,NULL,sfea002,(trim(sfea002)||'.'||trim(ooag011)),sfea003,(trim(sfea003)||'.'||trim(ooefl004)),
       sfea006,(trim(sfea006)||'.'||trim(srza002)),sfebseq,sfeb004,imaal_t.imaal003,imaal_t.imaal004,sfeb005,'N',sfeb008,sfeb011,sfeb021,'N',
       sfeb009,sfeb012,sfeb007,sfeb010,sfeb022,'N',sfeaent"
#   #end add-point
#   LET g_select = " SELECT sfeadocno,sfeadocdt,NULL,sfea002,NULL,sfea003,NULL,sfea006,NULL,sfebseq,sfeb004, 
#       imaal_t.imaal003,imaal_t.imaal004,sfeb005,NULL,sfeb008,sfeb011,sfeb021,NULL,sfeb009,sfeb012,sfeb007, 
#       sfeb010,sfeb022,NULL,sfeaent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM sfea_t LEFT OUTER JOIN sfeb_t ON sfeadocno = sfebdocno AND sfeaent = sfebent AND sfeasite = sfebsite ",
                 "             LEFT OUTER JOIN srza_t ON sfea006 = srza001 AND sfeaent = srzaent AND sfeasite = srzasite ",
                 "             LEFT OUTER JOIN ooag_t ON sfea002 = ooag001 AND sfeaent = ooagent ",
                 "             LEFT OUTER JOIN imaal_t ON sfeb004 = imaal001 AND sfebent = imaalent AND imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN ooefl_t ON sfea003 = ooefl001 AND sfeaent = ooeflent AND ooefl002 = '",g_dlang,"' "
                 
   
#   #end add-point
#    LET g_from = " FROM sfea_t,sfeb_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sfeadocno,sfebseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfea_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asrr340_g02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asrr340_g02_curs CURSOR FOR asrr340_g02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asrr340_g02.ins_data" readonly="Y" >}
PRIVATE FUNCTION asrr340_g02_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfeadocno LIKE sfea_t.sfeadocno, 
   sfeadocdt LIKE sfea_t.sfeadocdt, 
   l_ooff013 LIKE type_t.chr100, 
   sfea002 LIKE sfea_t.sfea002, 
   l_sfea002_desc LIKE type_t.chr30, 
   sfea003 LIKE sfea_t.sfea003, 
   l_sfea003_desc LIKE type_t.chr50, 
   sfea006 LIKE sfea_t.sfea006, 
   l_sfea006_desc LIKE type_t.chr30, 
   sfebseq LIKE sfeb_t.sfebseq, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   l_sfeb005_show LIKE type_t.chr2, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfeb021 LIKE sfeb_t.sfeb021, 
   l_sfeb021_show LIKE type_t.chr2, 
   sfeb009 LIKE sfeb_t.sfeb009, 
   sfeb012 LIKE sfeb_t.sfeb012, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb022 LIKE sfeb_t.sfeb022, 
   l_sfeb022_show LIKE type_t.chr2, 
   sfeaent LIKE sfea_t.sfeaent
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success  LIKE type_t.chr2
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asrr340_g02_curs INTO sr_s.*
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
       #說明為空，取消點的顯示
       #申請人員
       IF sr_s.l_sfea002_desc = '.' THEN
          LET sr_s.l_sfea002_desc = NULL
       END IF
       #部門
       IF sr_s.l_sfea003_desc = '.' THEN
          LET sr_s.l_sfea003_desc = NULL
       END IF
       #生產計劃
       IF sr_s.l_sfea006_desc = '.' THEN
          LET sr_s.l_sfea006_desc = NULL
       END IF
       
       #獲取單頭備註
       #備註（單頭）ooff013
       CALL s_aooi360_sel('6',sr_s.sfeadocno,sr_s.sfebseq,'','','','','','','','','4')
           RETURNING l_success,sr_s.l_ooff013
       
       #若下列欄位為空，則使其隱顯條件設為隱藏（'N'）
       #料件特征
       IF NOT cl_null(sr_s.sfeb005) THEN
          LET sr_s.l_sfeb005_show = 'Y'
       END IF
       #有效日期
       IF NOT cl_null(sr_s.sfeb021) THEN
          LET sr_s.l_sfeb021_show = 'Y'
       END IF
       #備註（單身）
       IF NOT cl_null(sr_s.sfeb022) THEN
          LET sr_s.l_sfeb022_show = 'Y'
       END IF

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfeadocno = sr_s.sfeadocno
       LET sr[l_cnt].sfeadocdt = sr_s.sfeadocdt
       LET sr[l_cnt].l_ooff013 = sr_s.l_ooff013
       LET sr[l_cnt].sfea002 = sr_s.sfea002
       LET sr[l_cnt].l_sfea002_desc = sr_s.l_sfea002_desc
       LET sr[l_cnt].sfea003 = sr_s.sfea003
       LET sr[l_cnt].l_sfea003_desc = sr_s.l_sfea003_desc
       LET sr[l_cnt].sfea006 = sr_s.sfea006
       LET sr[l_cnt].l_sfea006_desc = sr_s.l_sfea006_desc
       LET sr[l_cnt].sfebseq = sr_s.sfebseq
       LET sr[l_cnt].sfeb004 = sr_s.sfeb004
       LET sr[l_cnt].imaal_t_imaal003 = sr_s.imaal_t_imaal003
       LET sr[l_cnt].imaal_t_imaal004 = sr_s.imaal_t_imaal004
       LET sr[l_cnt].sfeb005 = sr_s.sfeb005
       LET sr[l_cnt].l_sfeb005_show = sr_s.l_sfeb005_show
       LET sr[l_cnt].sfeb008 = sr_s.sfeb008
       LET sr[l_cnt].sfeb011 = sr_s.sfeb011
       LET sr[l_cnt].sfeb021 = sr_s.sfeb021
       LET sr[l_cnt].l_sfeb021_show = sr_s.l_sfeb021_show
       LET sr[l_cnt].sfeb009 = sr_s.sfeb009
       LET sr[l_cnt].sfeb012 = sr_s.sfeb012
       LET sr[l_cnt].sfeb007 = sr_s.sfeb007
       LET sr[l_cnt].sfeb010 = sr_s.sfeb010
       LET sr[l_cnt].sfeb022 = sr_s.sfeb022
       LET sr[l_cnt].l_sfeb022_show = sr_s.l_sfeb022_show
       LET sr[l_cnt].sfeaent = sr_s.sfeaent
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asrr340_g02.rep_data" readonly="Y" >}
PRIVATE FUNCTION asrr340_g02_rep_data()
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
          START REPORT asrr340_g02_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asrr340_g02_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asrr340_g02_rep
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
 
{<section id="asrr340_g02.rep" readonly="Y" >}
PRIVATE REPORT asrr340_g02_rep(sr1)
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
DEFINE sr3 sr3_r
DEFINE sr4 sr4_r

DEFINE l_subrep05_show  LIKE type_t.chr1,
       l_subrep06_show  LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.sfeadocno,sr1.sfebseq
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
        BEFORE GROUP OF sr1.sfeadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfeadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfeaent=' ,sr1.sfeaent,'{+}sfeadocno=' ,sr1.sfeadocno         
            CALL cl_gr_init_apr(sr1.sfeadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfeadocno.before name="rep.b_group.sfeadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfeadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr340_g02_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asrr340_g02_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asrr340_g02_subrep01
           DECLARE asrr340_g02_repcur01 CURSOR FROM g_sql
           FOREACH asrr340_g02_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr340_g02_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asrr340_g02_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asrr340_g02_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfeadocno.after name="rep.b_group.sfeadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfebseq
 
           #add-point:rep.b_group.sfebseq.before name="rep.b_group.sfebseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfebseq.after name="rep.b_group.sfebseq.after"
           
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
                sr1.sfeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfeadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.sfebseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr340_g02_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asrr340_g02_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asrr340_g02_subrep02
           DECLARE asrr340_g02_repcur02 CURSOR FROM g_sql
           FOREACH asrr340_g02_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr340_g02_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asrr340_g02_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asrr340_g02_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          #子報表二
          LET g_sql = " SELECT DISTINCT sfecseq1,sfec002,sfec003,NULL,NULL,sfec009,sfec011,sfec012,(trim(sfec012)||'.'||trim(inayl003)),",
                      " sfec013,(trim(sfec013)||'.'||trim(inab003)),sfec014,'N',sfec015,'N' ",
                      " FROM sfec_t ",
                      " LEFT OUTER JOIN inayl_t ON sfec012 = inayl001 AND sfecent = inaylent AND inayl002 = '",g_dlang,"' ",
                      " LEFT OUTER JOIN inab_t ON sfec012 = inab001 AND sfec013 = inab002 AND sfecent = inabent ",
                      " WHERE sfecdocno = '",sr1.sfeadocno CLIPPED,"' ",
                      "   AND sfecent = '",sr1.sfeaent CLIPPED,"' ",
                      "   AND sfecseq = '",sr1.sfebseq CLIPPED,"' ",
                      " ORDER BY sfecseq1 "
          
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep05_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE asrr340_g02_repcur05_cnt_pre FROM l_sub_sql
          EXECUTE asrr340_g02_repcur05_cnt_pre INTO l_cnt
          IF l_cnt > 0 AND tm.pr = 'Y' THEN 
             LET l_subrep05_show ="Y"
          END IF
          PRINTX l_subrep05_show
          START REPORT asrr340_g02_subrep05
          DECLARE asrr340_g02_repcur05 CURSOR FROM g_sql
          FOREACH asrr340_g02_repcur05 INTO sr3.*
             IF STATUS THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "asrr340_g02_repcur05:"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()                  
                EXIT FOREACH 
             END IF
             #add-point:rep.sub05.foreach
             #說明為空，取消點的顯示
             #指定庫位
             IF sr3.l_sfec012_desc = '.' THEN
                LET sr3.l_sfec012_desc = NULL
             END IF
             #指定儲位
             IF sr3.l_sfec013_desc = '.' THEN
                LET sr3.l_sfec013_desc = NULL
             END IF
       
             #獲取判定结果
             SELECT qcbc002 INTO sr3.l_sfec003_desc1
               FROM qcbc_t
              WHERE qcbcdocno = sr3.sfec002
                AND qcbcseq = sr3.sfec003
                AND qcbcent = g_enterprise
                AND qcbcsite = g_site
                
             LET sr3.l_sfec003_desc2 = s_desc_get_qc_desc(g_site,sr3.l_sfec003_desc1)
             IF NOT cl_null(sr3.l_sfec003_desc2) THEN
               LET sr3.l_sfec003_desc2 = sr3.l_sfec003_desc1 CLIPPED,'.',sr3.l_sfec003_desc2 CLIPPED
             ELSE 
               LET sr3.l_sfec003_desc2 = sr3.l_sfec003_desc1 CLIPPED
             END IF
       
             #若下列欄位為空，則使其隱顯條件設為隱藏（'N'）
             #批號
             IF NOT cl_null(sr3.sfec014) THEN
                LET sr3.l_sfec014_show = 'Y'
             END IF
             #庫存特征
             IF NOT cl_null(sr3.sfec015) THEN
                LET sr3.l_sfec015_show = 'Y'
             END IF
             #end add-point:rep.sub05.foreach
             OUTPUT TO REPORT asrr340_g02_subrep05(sr3.*)
             END FOREACH
          FINISH REPORT asrr340_g02_subrep05          
          
          #子報表二
          LET g_sql = " SELECT DISTINCT inaoseq1,inao008,inao009,inao010,inao012 ",
                      " FROM inao_t ",
                      " WHERE inaodocno = '",sr1.sfeadocno CLIPPED,"' ",
                      "   AND inaoent = '",sr1.sfeaent CLIPPED,"' ",
                      "   AND inaoseq = '",sr1.sfebseq CLIPPED,"' ",
                      " ORDER BY inaoseq1 "
          
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep06_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE asrr340_g02_repcur06_cnt_pre FROM l_sub_sql
          EXECUTE asrr340_g02_repcur06_cnt_pre INTO l_cnt
          IF l_cnt > 0 THEN 
             LET l_subrep06_show ="Y"
          END IF
          PRINTX l_subrep06_show
          START REPORT asrr340_g02_subrep06
          DECLARE asrr340_g02_repcur06 CURSOR FROM g_sql
          FOREACH asrr340_g02_repcur06 INTO sr4.*
             IF STATUS THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "asrr340_g02_repcur06:"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = FALSE
                CALL cl_err()                  
                EXIT FOREACH 
             END IF
             #add-point:rep.sub06.foreach
             
             #end add-point:rep.sub06.foreach
             OUTPUT TO REPORT asrr340_g02_subrep06(sr4.*)
             END FOREACH
          FINISH REPORT asrr340_g02_subrep06
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.sfeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfeadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.sfebseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr340_g02_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asrr340_g02_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asrr340_g02_subrep03
           DECLARE asrr340_g02_repcur03 CURSOR FROM g_sql
           FOREACH asrr340_g02_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr340_g02_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asrr340_g02_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asrr340_g02_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfeadocno
 
           #add-point:rep.a_group.sfeadocno.before name="rep.a_group.sfeadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfeaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfeadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr340_g02_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asrr340_g02_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asrr340_g02_subrep04
           DECLARE asrr340_g02_repcur04 CURSOR FROM g_sql
           FOREACH asrr340_g02_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr340_g02_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asrr340_g02_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asrr340_g02_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfeadocno.after name="rep.a_group.sfeadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfebseq
 
           #add-point:rep.a_group.sfebseq.before name="rep.a_group.sfebseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfebseq.after name="rep.a_group.sfebseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asrr340_g02.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asrr340_g02_subrep01(sr2)
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
PRIVATE REPORT asrr340_g02_subrep02(sr2)
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
PRIVATE REPORT asrr340_g02_subrep03(sr2)
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
PRIVATE REPORT asrr340_g02_subrep04(sr2)
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
 
{<section id="asrr340_g02.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="asrr340_g02.other_report" readonly="Y" >}

PRIVATE REPORT asrr340_g02_subrep05(sr3)
   DEFINE sr3 sr3_r
   ORDER EXTERNAL BY sr3.sfecseq1
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.*
 
END REPORT

PRIVATE REPORT asrr340_g02_subrep06(sr4)
   DEFINE sr4 sr4_r
   ORDER EXTERNAL BY sr4.inaoseq1
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
 
END REPORT

 
{</section>}
 
