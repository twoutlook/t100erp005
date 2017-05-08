#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr340_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-11-09 15:34:41), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000156
#+ Filename...: asfr340_g01
#+ Description: 工单入库单
#+ Creator....: 05016(2014-05-26 10:11:19)
#+ Modifier...: 08993 -SD/PR- 00000
 
{</section>}
 
{<section id="asfr340_g01.global" readonly="Y" >}
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
   sfea001 LIKE sfea_t.sfea001, 
   sfea002 LIKE sfea_t.sfea002, 
   sfea003 LIKE sfea_t.sfea003, 
   sfea004 LIKE sfea_t.sfea004, 
   sfea005 LIKE sfea_t.sfea005, 
   sfeadocdt LIKE sfea_t.sfeadocdt, 
   sfeadocno LIKE sfea_t.sfeadocno, 
   sfeaent LIKE sfea_t.sfeaent, 
   sfeasite LIKE sfea_t.sfeasite, 
   sfeastus LIKE sfea_t.sfeastus, 
   sfeb001 LIKE sfeb_t.sfeb001, 
   sfeb002 LIKE sfeb_t.sfeb002, 
   sfeb003 LIKE sfeb_t.sfeb003, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   sfeb006 LIKE sfeb_t.sfeb006, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb009 LIKE sfeb_t.sfeb009, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfeb012 LIKE sfeb_t.sfeb012, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb017 LIKE sfeb_t.sfeb017, 
   sfeb018 LIKE sfeb_t.sfeb018, 
   sfeb019 LIKE sfeb_t.sfeb019, 
   sfeb020 LIKE sfeb_t.sfeb020, 
   sfeb021 LIKE sfeb_t.sfeb021, 
   sfeb022 LIKE sfeb_t.sfeb022, 
   sfeb025 LIKE sfeb_t.sfeb025, 
   sfeb026 LIKE sfeb_t.sfeb026, 
   sfebseq LIKE sfeb_t.sfebseq, 
   sfebsite LIKE sfeb_t.sfebsite, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_inayl003 LIKE inayl_t.inayl003, 
   l_sfeb013_inayl003 LIKE type_t.chr1000, 
   l_sfea002_ooag011 LIKE type_t.chr100, 
   l_sfea003_ooefl003 LIKE type_t.chr100, 
   l_inab003 LIKE inab_t.inab003, 
   l_sfeb014_inab003 LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #列印入庫明細
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
   inaoseq1  LIKE inao_t.inaoseq1,           #項序
   inao008   LIKE inao_t.inao008,            #製造批號
   inao009   LIKE inao_t.inao009,            #製造序號
   inao010   LIKE inao_t.inao010,            #製造日期
   inao012   LIKE inao_t.inao012             #數量
 
 END RECORD

#end add-point
 
{</section>}
 
{<section id="asfr340_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr340_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  列印入庫明細
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asfr340_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr340_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr340_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr340_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr340_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr340_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT sfea001,sfea002,sfea003,sfea004,sfea005,sfeadocdt,sfeadocno,sfeaent,sfeasite, 
       sfeastus,sfeb001,sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,sfeb007,sfeb008,sfeb009,sfeb010,sfeb011, 
       sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb022,sfeb025, 
       sfeb026,sfebseq,sfebsite,x.imaal_t_imaal003,x.imaal_t_imaal004,'','','','','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM  sfea_t  LEFT OUTER JOIN ( SELECT sfeb_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = sfeb_t.sfeb004 AND imaal_t.imaalent = sfeb_t.sfebent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = sfeb_t.sfeb004 AND imaal_t.imaalent = sfeb_t.sfebent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal004 FROM sfeb_t ) x  ON sfea_t.sfeaent = x.sfebent AND sfea_t.sfeadocno  
        = x.sfebdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
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
   PREPARE asfr340_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr340_g01_curs CURSOR FOR asfr340_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr340_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr340_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfea001 LIKE sfea_t.sfea001, 
   sfea002 LIKE sfea_t.sfea002, 
   sfea003 LIKE sfea_t.sfea003, 
   sfea004 LIKE sfea_t.sfea004, 
   sfea005 LIKE sfea_t.sfea005, 
   sfeadocdt LIKE sfea_t.sfeadocdt, 
   sfeadocno LIKE sfea_t.sfeadocno, 
   sfeaent LIKE sfea_t.sfeaent, 
   sfeasite LIKE sfea_t.sfeasite, 
   sfeastus LIKE sfea_t.sfeastus, 
   sfeb001 LIKE sfeb_t.sfeb001, 
   sfeb002 LIKE sfeb_t.sfeb002, 
   sfeb003 LIKE sfeb_t.sfeb003, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   sfeb006 LIKE sfeb_t.sfeb006, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb009 LIKE sfeb_t.sfeb009, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfeb012 LIKE sfeb_t.sfeb012, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb017 LIKE sfeb_t.sfeb017, 
   sfeb018 LIKE sfeb_t.sfeb018, 
   sfeb019 LIKE sfeb_t.sfeb019, 
   sfeb020 LIKE sfeb_t.sfeb020, 
   sfeb021 LIKE sfeb_t.sfeb021, 
   sfeb022 LIKE sfeb_t.sfeb022, 
   sfeb025 LIKE sfeb_t.sfeb025, 
   sfeb026 LIKE sfeb_t.sfeb026, 
   sfebseq LIKE sfeb_t.sfebseq, 
   sfebsite LIKE sfeb_t.sfebsite, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   l_inayl003 LIKE inayl_t.inayl003, 
   l_sfeb013_inayl003 LIKE type_t.chr1000, 
   l_sfea002_ooag011 LIKE type_t.chr100, 
   l_sfea003_ooefl003 LIKE type_t.chr100, 
   l_inab003 LIKE inab_t.inab003, 
   l_sfeb014_inab003 LIKE type_t.chr1000
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
    FOREACH asfr340_g01_curs INTO sr_s.*
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
       #聯絡對象
       CALL s_desc_get_person_desc(sr_s.sfea002) RETURNING sr_s.l_sfea002_ooag011    
       LET sr_s.l_sfea002_ooag011 = sr_s.sfea002,".",sr_s.l_sfea002_ooag011
       
       #部門說明       
       INITIALIZE sr_s.l_sfea003_ooefl003 TO NULL
       CALL s_desc_get_department_desc(sr_s.sfea003) RETURNING sr_s.l_sfea003_ooefl003
       LET sr_s.l_sfea003_ooefl003 = sr_s.sfea003,".",sr_s.l_sfea003_ooefl003
       
       #倉庫編號帶說明            
       CALL s_desc_get_stock_desc(sr_s.sfeasite,sr_s.sfeb013) RETURNING sr_s.l_sfeb013_inayl003           
       LET sr_s.l_sfeb013_inayl003 = sr_s.sfeb013,".",sr_s.l_sfeb013_inayl003
       #儲位編號帶說明            
       CALL s_desc_get_locator_desc(sr_s.sfeasite,sr_s.sfeb013,sr_s.sfeb014) RETURNING sr_s.l_sfeb014_inab003
       LET sr_s.l_sfeb014_inab003 = sr_s.sfeb014,".",sr_s.l_sfeb014_inab003
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfea001 = sr_s.sfea001
       LET sr[l_cnt].sfea002 = sr_s.sfea002
       LET sr[l_cnt].sfea003 = sr_s.sfea003
       LET sr[l_cnt].sfea004 = sr_s.sfea004
       LET sr[l_cnt].sfea005 = sr_s.sfea005
       LET sr[l_cnt].sfeadocdt = sr_s.sfeadocdt
       LET sr[l_cnt].sfeadocno = sr_s.sfeadocno
       LET sr[l_cnt].sfeaent = sr_s.sfeaent
       LET sr[l_cnt].sfeasite = sr_s.sfeasite
       LET sr[l_cnt].sfeastus = sr_s.sfeastus
       LET sr[l_cnt].sfeb001 = sr_s.sfeb001
       LET sr[l_cnt].sfeb002 = sr_s.sfeb002
       LET sr[l_cnt].sfeb003 = sr_s.sfeb003
       LET sr[l_cnt].sfeb004 = sr_s.sfeb004
       LET sr[l_cnt].sfeb005 = sr_s.sfeb005
       LET sr[l_cnt].sfeb006 = sr_s.sfeb006
       LET sr[l_cnt].sfeb007 = sr_s.sfeb007
       LET sr[l_cnt].sfeb008 = sr_s.sfeb008
       LET sr[l_cnt].sfeb009 = sr_s.sfeb009
       LET sr[l_cnt].sfeb010 = sr_s.sfeb010
       LET sr[l_cnt].sfeb011 = sr_s.sfeb011
       LET sr[l_cnt].sfeb012 = sr_s.sfeb012
       LET sr[l_cnt].sfeb013 = sr_s.sfeb013
       LET sr[l_cnt].sfeb014 = sr_s.sfeb014
       LET sr[l_cnt].sfeb015 = sr_s.sfeb015
       LET sr[l_cnt].sfeb016 = sr_s.sfeb016
       LET sr[l_cnt].sfeb017 = sr_s.sfeb017
       LET sr[l_cnt].sfeb018 = sr_s.sfeb018
       LET sr[l_cnt].sfeb019 = sr_s.sfeb019
       LET sr[l_cnt].sfeb020 = sr_s.sfeb020
       LET sr[l_cnt].sfeb021 = sr_s.sfeb021
       LET sr[l_cnt].sfeb022 = sr_s.sfeb022
       LET sr[l_cnt].sfeb025 = sr_s.sfeb025
       LET sr[l_cnt].sfeb026 = sr_s.sfeb026
       LET sr[l_cnt].sfebseq = sr_s.sfebseq
       LET sr[l_cnt].sfebsite = sr_s.sfebsite
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_imaal_t_imaal004 = sr_s.x_imaal_t_imaal004
       LET sr[l_cnt].l_inayl003 = sr_s.l_inayl003
       LET sr[l_cnt].l_sfeb013_inayl003 = sr_s.l_sfeb013_inayl003
       LET sr[l_cnt].l_sfea002_ooag011 = sr_s.l_sfea002_ooag011
       LET sr[l_cnt].l_sfea003_ooefl003 = sr_s.l_sfea003_ooefl003
       LET sr[l_cnt].l_inab003 = sr_s.l_inab003
       LET sr[l_cnt].l_sfeb014_inab003 = sr_s.l_sfeb014_inab003
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr340_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr340_g01_rep_data()
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
          START REPORT asfr340_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr340_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr340_g01_rep
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
 
{<section id="asfr340_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr340_g01_rep(sr1)
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
DEFINE l_sfeb002_show   LIKE type_t.chr1      # FQC
DEFINE l_sfeb005_show   LIKE type_t.chr1      #料件特徵
DEFINE l_sfeb021_show   LIKE type_t.chr1      #有效日期
DEFINE l_sfeb022_show   LIKE type_t.chr1      #料件備註
DEFINE l_sfeb013_show   LIKE type_t.chr1      # 庫位
DEFINE l_sfeb014_show   LIKE type_t.chr1      # 儲位
DEFINE l_ooag011        LIKE ooag_t.ooag011   #人員名稱
DEFINE l_sfeb005_sfeb016_show LIKE type_t.chr1  #料件特徵/庫存特徵

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
           PREPARE asfr340_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr340_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr340_g01_subrep01
           DECLARE asfr340_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr340_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr340_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr340_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr340_g01_subrep01
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
           PREPARE asfr340_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr340_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr340_g01_subrep02
           DECLARE asfr340_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr340_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr340_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr340_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr340_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
           
             #FQC為N不顯示
            INITIALIZE l_sfeb002_show TO NULL            
            IF sr1.sfeb002 = "Y" THEN
               LET l_sfeb002_show = "Y"
            ELSE
               LET l_sfeb002_show = "N"
            END IF          

            #料件特徵為空不顯示
            INITIALIZE l_sfeb005_show TO NULL            
            IF cl_null(sr1.sfeb005) THEN
               LET l_sfeb005_show = "N"
            ELSE
               LET l_sfeb005_show = "Y"
            END IF
            
            #有效日期徵為空不顯示
            INITIALIZE l_sfeb021_show TO NULL            
            IF cl_null(sr1.sfeb021) THEN
               LET l_sfeb021_show = "N"
            ELSE
               LET l_sfeb021_show = "Y"
            END IF
            
            #料件備註為空不顯示
            INITIALIZE l_sfeb022_show TO NULL            
            IF cl_null(sr1.sfeb022) THEN
               LET l_sfeb022_show = "N"
            ELSE
               LET l_sfeb022_show = "Y"
            END IF
            
            ##料件特徵/庫存特徵 為空時 縮排
            INITIALIZE l_sfeb005_sfeb016_show TO NULL
            IF cl_null(sr1.sfeb005) AND cl_null(sr1.sfeb016) THEN 
               LET l_sfeb005_sfeb016_show = "N"
            ELSE
               LET l_sfeb005_sfeb016_show = "Y"
            END IF
            
            #單身庫位為空不顯示
            INITIALIZE l_sfeb013_show  TO NULL
            IF cl_null(sr1.sfeb013) THEN 
               LET l_sfeb013_show = "N"
            ELSE
               LET l_sfeb013_show = "Y"
            END IF
            
            INITIALIZE l_sfeb014_show  TO NULL
            IF cl_null(sr1.sfeb014) THEN 
               LET l_sfeb014_show = "N"
            ELSE
               LET l_sfeb014_show = "Y"
            END IF
                                   
            PRINTX l_sfeb005_sfeb016_show
            PRINTX l_sfeb005_show
            PRINTX l_sfeb021_show
            PRINTX l_sfeb022_show
            PRINTX l_sfeb002_show
            PRINTX l_sfeb013_show 
            PRINTX l_sfeb014_show 
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
            
            #子報表05 批序號管理
          
            START REPORT asfr340_g01_subrep05            
            IF NOT cl_null(sr1.sfebseq) THEN                             
               LET g_sql = "SELECT inaodocno,inaoseq1,inao008,inao009,inao010,inao012 ",
                           "  FROM inao_t ",
                           " WHERE inaodocno = '",sr1.sfeadocno CLIPPED,"'",
                           "   AND inaoent   = '",sr1.sfeaent   CLIPPED,"'",                     
                           "   AND inaoseq   = '",sr1.sfebseq   CLIPPED,"'",                        
                           "   AND inao008 IS NOT NULL  ",
                           "   AND inao009 IS NOT NULL  "                      
               DECLARE asfr340_g01_repcur05 CURSOR FROM g_sql
               FOREACH asfr340_g01_repcur05 INTO sr3.*                       
                  OUTPUT TO REPORT asfr340_g01_subrep05(sr3.*)
               END FOREACH  
            END IF
            FINISH REPORT asfr340_g01_subrep05
           
            
            
            
            
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
           PREPARE asfr340_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr340_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr340_g01_subrep03
           DECLARE asfr340_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr340_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr340_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr340_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr340_g01_subrep03
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
           PREPARE asfr340_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr340_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr340_g01_subrep04
           DECLARE asfr340_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr340_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr340_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr340_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr340_g01_subrep04
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
 
{<section id="asfr340_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr340_g01_subrep01(sr2)
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
PRIVATE REPORT asfr340_g01_subrep02(sr2)
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
PRIVATE REPORT asfr340_g01_subrep03(sr2)
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
PRIVATE REPORT asfr340_g01_subrep04(sr2)
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
 
{<section id="asfr340_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="asfr340_g01.other_report" readonly="Y" >}

REPORT asfr340_g01_subrep05(sr3)
DEFINE sr3 sr3_r

ORDER EXTERNAL BY sr3.inaodocno    
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 