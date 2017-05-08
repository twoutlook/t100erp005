#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp450_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-09-04 09:59:53), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: anmp450_g01
#+ Description: ...
#+ Creator....: 06821(2015-06-05 09:52:55)
#+ Modifier...: 06816 -SD/PR- 00000
 
{</section>}
 
{<section id="anmp450_g01.global" readonly="Y" >}
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
   l_order LIKE type_t.chr100, 
   nmck005 LIKE nmck_t.nmck005, 
   l_oofb017_1 LIKE oofb_t.oofb017, 
   nmck103 LIKE nmck_t.nmck103, 
   l_memo LIKE type_t.chr500, 
   l_nmck005_nmck015 LIKE type_t.chr500, 
   l_oofc012 LIKE oofc_t.oofc012, 
   l_pmaal004_pmaj012 LIKE type_t.chr500, 
   l_ooag011 LIKE ooag_t.ooag011, 
   l_ooefl006 LIKE ooefl_t.ooefl006, 
   l_pmaj012 LIKE pmaj_t.pmaj012, 
   l_oofb017 LIKE oofb_t.oofb017, 
   l_pmaal003_pmaj012 LIKE type_t.chr500, 
   nmck011 LIKE nmck_t.nmck011, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck025 LIKE nmck_t.nmck025, 
   nmcksite LIKE nmck_t.nmcksite, 
   nmckcomp LIKE nmck_t.nmckcomp, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmckent LIKE nmck_t.nmckent
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #l_print_type 
       a2 STRING,                  #nmcksite 
       a3 STRING,                  #nmckcomp 
       a4 STRING                   #ooag001
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
TYPE sr3_r RECORD  #子報表05
   l_sign      LIKE type_t.chr500,  #廠商簽章
   l_text      LIKE type_t.chr500,  #寄回公司字樣
   l_oofb017_1 LIKE type_t.chr500   #詳細地址
END RECORD

TYPE sr4_r RECORD  #子報表06(分配到欄位呈現)
   l_apce048_1  LIKE apce_t.apce048, #發票欄位1
   l_apce048_2  LIKE apce_t.apce048  #發票欄位2
END RECORD

TYPE sr5_r RECORD  #子報表06(撈出發票號碼)
   l_apce048    LIKE apce_t.apce048  
END RECORD

TYPE sr6_r RECORD
   l_subrep07_order LIKE type_t.chr100, 
   nmck005 LIKE nmck_t.nmck005, 
   l_oofb017_1 LIKE oofb_t.oofb017, 
   nmck103 LIKE nmck_t.nmck103, 
   l_memo LIKE type_t.chr500, 
   l_nmck005_nmck015 LIKE type_t.chr500, 
   l_oofc012 LIKE oofc_t.oofc012, 
   l_pmaal004_pmaj012 LIKE type_t.chr500, 
   l_ooag011 LIKE ooag_t.ooag011, 
   l_ooefl006 LIKE ooefl_t.ooefl006, 
   l_pmaj012 LIKE pmaj_t.pmaj012, 
   l_oofb017 LIKE oofb_t.oofb017, 
   l_pmaal003_pmaj012 LIKE type_t.chr500, 
   nmck011 LIKE nmck_t.nmck011, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck025 LIKE nmck_t.nmck025, 
   nmcksite LIKE nmck_t.nmcksite, 
   nmckcomp LIKE nmck_t.nmckcomp, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmckent LIKE nmck_t.nmckent
END RECORD

DEFINE sr5 DYNAMIC ARRAY OF sr5_r
#end add-point
 
{</section>}
 
{<section id="anmp450_g01.main" readonly="Y" >}
PUBLIC FUNCTION anmp450_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  l_print_type 
DEFINE  p_arg3 STRING                  #tm.a2  nmcksite 
DEFINE  p_arg4 STRING                  #tm.a3  nmckcomp 
DEFINE  p_arg5 STRING                  #tm.a4  ooag001
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CASE
      WHEN tm.a1 = 'a' #列印地址條
         LET g_template ="anmp450_g01_01"
         
      WHEN tm.a1 = 'b' #列印大宗函件存根
         LET g_template ="anmp450_g01_02"
         
      WHEN tm.a1 = 'c' #列印廠商簽收回單
         LET g_template ="anmp450_g01"
   END CASE
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "anmp450_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL anmp450_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL anmp450_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL anmp450_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmp450_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp450_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
   #end add-point
   LET g_select = " SELECT '',nmck005,'',nmck103,NULL,trim(nmck005)||'.'||trim(nmck015),'','','','', 
       '','','',nmck011,nmckdocdt,nmck025,nmcksite,nmckcomp,nmckdocno,nmckent"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   IF tm.a1 = 'a' THEN
      LET g_select = " SELECT DISTINCT '',nmck005,'','','','','','','','', 
          '','','','','','','','','',nmckent"
   END IF
   #end add-point
    LET g_from = " FROM nmck_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
    LET g_order = " ORDER BY nmck005,nmckdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   IF tm.a1 = 'a' THEN
      LET g_order = " ORDER BY nmck005"
   END IF  
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmck_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE anmp450_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE anmp450_g01_curs CURSOR FOR anmp450_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmp450_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmp450_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_order LIKE type_t.chr100, 
   nmck005 LIKE nmck_t.nmck005, 
   l_oofb017_1 LIKE oofb_t.oofb017, 
   nmck103 LIKE nmck_t.nmck103, 
   l_memo LIKE type_t.chr500, 
   l_nmck005_nmck015 LIKE type_t.chr500, 
   l_oofc012 LIKE oofc_t.oofc012, 
   l_pmaal004_pmaj012 LIKE type_t.chr500, 
   l_ooag011 LIKE ooag_t.ooag011, 
   l_ooefl006 LIKE ooefl_t.ooefl006, 
   l_pmaj012 LIKE pmaj_t.pmaj012, 
   l_oofb017 LIKE oofb_t.oofb017, 
   l_pmaal003_pmaj012 LIKE type_t.chr500, 
   nmck011 LIKE nmck_t.nmck011, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck025 LIKE nmck_t.nmck025, 
   nmcksite LIKE nmck_t.nmcksite, 
   nmckcomp LIKE nmck_t.nmckcomp, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmckent LIKE nmck_t.nmckent
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_pmaal004  LIKE pmaal_t.pmaal004 #廠商簡稱
DEFINE l_pmaal003  LIKE pmaal_t.pmaal003 #廠商全名
DEFINE l_ooag001   LIKE ooag_t.ooag001   #人員名稱
DEFINE l_pmaa027   LIKE oofb_t.oofb002   #交易對象識別碼
DEFINE l_date      LIKE oofb_t.oofb018   #當日日期
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH anmp450_g01_curs INTO sr_s.*
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
       #收件者姓名(廠商簡稱+財務主要連絡人)(廠商全名+財務主要連絡人)
       LET sr_s.l_pmaal004_pmaj012 = ''
       LET sr_s.l_pmaal003_pmaj012 = '' 
       LET l_pmaal004 = ''
       LET l_pmaal003 = ''
       LET l_pmaa027 = ''
       LET sr_s.l_pmaj012 = ''
       LET sr_s.l_oofb017 = ''
 
       SELECT DISTINCT pmaal004,pmaal003,pmaj012 INTO l_pmaal004,l_pmaal003,sr_s.l_pmaj012
        FROM nmck_t
       LEFT OUTER JOIN pmaal_t ON nmckent = pmaalent AND  pmaal001 = nmck005 AND pmaal002 = g_dlang 
       LEFT OUTER JOIN pmaj_t ON pmajent = pmaalent AND pmaj001 = pmaal001 AND nmckent = pmajent  AND pmaj001 = nmck005 AND pmaj005 = 'Y'
        WHERE nmck005 = sr_s.nmck005
        
       #收件者/寄達地址
       LET l_date = cl_get_current()

       SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = sr_s.nmckent AND pmaa001 = sr_s.nmck005
       
       SELECT oofb017 INTO sr_s.l_oofb017 
         FROM oofb_t
        WHERE oofb002= l_pmaa027
          AND oofbent = sr_s.nmckent
          AND (oofb018 is null or oofb018 >'",l_date,"')   #失效日期
          AND oofbstus='Y'AND oofb008 = '2' AND oofb010 ='Y' AND rownum = 1
      
        
       LET sr_s.l_pmaal004_pmaj012 = l_pmaal004 CLIPPED,'.',sr_s.l_pmaj012 CLIPPED
       LET sr_s.l_pmaal003_pmaj012 = l_pmaal003 CLIPPED,'.',sr_s.l_pmaj012 CLIPPED
       
       #寄件人名稱/詳細地址/電話號碼
        SELECT DISTINCT ooefl006,oofb017,oofc012 INTO sr_s.l_ooefl006,sr_s.l_oofb017_1,sr_s.l_oofc012
         FROM ooefl_t,ooef_t
       LEFT OUTER JOIN oofb_t ON ooefent = oofbent AND ooef012 = oofb002 AND oofb008 ='1' AND oofbstus = 'Y'
       LEFT OUTER JOIN oofc_t ON oofcent = oofbent AND oofb002 = oofc002 AND ooef012 = oofc002 AND oofc008='1' AND oofcstus = 'Y'
       WHERE ooeflent = sr_s.nmckent AND ooeflent = ooefent AND ooefl001 = ooef001 
         AND ooef017 = sr_s.nmckcomp  AND ooefl002 = g_dlang  AND ooefl001 = sr_s.nmcksite AND ooefstus = 'Y' AND rownum = 1
         
       CALL anmp450_g01_initialize(l_pmaal004,sr_s.l_pmaj012,sr_s.l_pmaal004_pmaj012) RETURNING sr_s.l_pmaal004_pmaj012
       CALL anmp450_g01_initialize(l_pmaal003,sr_s.l_pmaj012,sr_s.l_pmaal004_pmaj012) RETURNING sr_s.l_pmaal003_pmaj012
       
       LET l_ooag001 = tm.a4
       CALL s_desc_get_person_desc(l_ooag001) RETURNING sr_s.l_ooag011
       

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       CASE
          WHEN tm.a1 = 'a' #依廠商印列在同頁(地址條)
             LET sr_s.l_order = '1'
             
          WHEN tm.a1 = 'b' #列印大宗函件存根
             LET sr_s.l_order = sr_s.nmcksite
             
          WHEN tm.a1 = 'c' #列印廠商簽收回單
             LET sr_s.l_order = sr_s.nmck005
       END CASE
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].nmck005 = sr_s.nmck005
       LET sr[l_cnt].l_oofb017_1 = sr_s.l_oofb017_1
       LET sr[l_cnt].nmck103 = sr_s.nmck103
       LET sr[l_cnt].l_memo = sr_s.l_memo
       LET sr[l_cnt].l_nmck005_nmck015 = sr_s.l_nmck005_nmck015
       LET sr[l_cnt].l_oofc012 = sr_s.l_oofc012
       LET sr[l_cnt].l_pmaal004_pmaj012 = sr_s.l_pmaal004_pmaj012
       LET sr[l_cnt].l_ooag011 = sr_s.l_ooag011
       LET sr[l_cnt].l_ooefl006 = sr_s.l_ooefl006
       LET sr[l_cnt].l_pmaj012 = sr_s.l_pmaj012
       LET sr[l_cnt].l_oofb017 = sr_s.l_oofb017
       LET sr[l_cnt].l_pmaal003_pmaj012 = sr_s.l_pmaal003_pmaj012
       LET sr[l_cnt].nmck011 = sr_s.nmck011
       LET sr[l_cnt].nmckdocdt = sr_s.nmckdocdt
       LET sr[l_cnt].nmck025 = sr_s.nmck025
       LET sr[l_cnt].nmcksite = sr_s.nmcksite
       LET sr[l_cnt].nmckcomp = sr_s.nmckcomp
       LET sr[l_cnt].nmckdocno = sr_s.nmckdocno
       LET sr[l_cnt].nmckent = sr_s.nmckent
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
 
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
 
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmp450_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmp450_g01_rep_data()
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
          START REPORT anmp450_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT anmp450_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT anmp450_g01_rep
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
 
{<section id="anmp450_g01.rep" readonly="Y" >}
PRIVATE REPORT anmp450_g01_rep(sr1)
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
DEFINE sr6 sr6_r

DEFINE l_sum           LIKE type_t.num20_6    #合計
DEFINE l_ac            INTEGER                #for 發票號碼
DEFINE l_i             INTEGER                #for 發票號碼
DEFINE l_subrep06_show LIKE type_t.chr1

DEFINE l_year          STRING 
DEFINE l_month         STRING 
DEFINE l_day           STRING 

DEFINE l_lineno        LIKE type_t.num5
DEFINE l_skip          LIKE type_t.chr1

DEFINE l_pmaal004      LIKE pmaal_t.pmaal004 #廠商簡稱
DEFINE l_pmaal003      LIKE pmaal_t.pmaal003 #廠商全名
DEFINE l_ooag001       LIKE ooag_t.ooag001   #人員名稱
DEFINE l_pmaa027       LIKE oofb_t.oofb002   #交易對象識別碼
DEFINE l_date          LIKE oofb_t.oofb018   #當日日期
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order
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
        BEFORE GROUP OF sr1.l_order
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            CALL s_desc_get_ooefl006_desc(sr1.nmckcomp) RETURNING g_grPageHeader.title0101
            CALL cl_gr_init_pageheader() #表頭資訊  
            IF tm.a1 = 'a' THEN
               LET g_grPageHeader.title0101 =''
               LET g_grPageHeader.title0201 =''
            END IF
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            IF tm.a1 = 'c' THEN
               CALL cl_gr_init_apr(sr1.nmckcomp)  
            END IF            
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
 
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'nmckent=' ,sr1.nmckent,'{+}nmckcomp=' ,sr1.nmckcomp,'{+}nmckdocno=' ,sr1.nmckdocno         
            CALL cl_gr_init_apr(sr1.l_order)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            LET l_lineno = 0
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
 
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.nmckent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmp450_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE anmp450_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT anmp450_g01_subrep01
           DECLARE anmp450_g01_repcur01 CURSOR FROM g_sql
           FOREACH anmp450_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmp450_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
 
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT anmp450_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT anmp450_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          #日期
          LET l_year  = YEAR(g_today)
          LET l_month = MONTH(g_today)
          LET l_day   = DAY(g_today)
          PRINTX l_year,l_month,l_day
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
 
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.nmckent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmp450_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE anmp450_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT anmp450_g01_subrep02
           DECLARE anmp450_g01_repcur02 CURSOR FROM g_sql
           FOREACH anmp450_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmp450_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT anmp450_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT anmp450_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
 
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          LET l_lineno = l_lineno + 1
          PRINTX l_lineno
          
          LET l_skip='N'
          IF l_lineno MOD 20=0 THEN
             LET l_skip='Y'
          END IF
             PRINTX l_skip
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          #子報表06 (發票號碼)
          INITIALIZE l_subrep06_show TO NULL
          LET l_subrep06_show = "N"
          START REPORT anmp450_g01_subrep06
             LET g_sql = "SELECT apce048 ",
                         " FROM apce_t,nmcl_t ",
                         "WHERE nmclent = apceent",
                         " AND apcedocno = nmcl001 ",
			                " AND apceent = ",sr1.nmckent CLIPPED,
			                " AND nmcldocno = '",sr1.nmckdocno CLIPPED,"'"
           
             LET l_ac = 1
             CALL sr5.clear()
             DECLARE anmp450_g01_repcur06 CURSOR FROM g_sql
             FOREACH anmp450_g01_repcur06 INTO sr5[l_ac].*
                LET l_ac = l_ac + 1
             END FOREACH
             LET l_ac = l_ac - 1
             LET l_i = 1
           
             IF l_ac > 0 THEN
                LET l_subrep06_show = "Y"
                WHILE TRUE
                   INITIALIZE sr4.* TO NULL
                   LET sr4.l_apce048_1 = sr5[l_i].l_apce048
                   IF l_i+1 <= l_ac THEN
                      LET l_i = l_i + 1
                      LET sr4.l_apce048_2 = sr5[l_i].l_apce048
                   END IF
                   OUTPUT TO REPORT anmp450_g01_subrep06(sr4.*)
                   LET l_i = l_i + 1
                   IF l_i>l_ac THEN 
                      EXIT WHILE 
                   END IF
                END  WHILE
             END IF
          FINISH REPORT anmp450_g01_subrep06
          PRINTX l_subrep06_show
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.nmckent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
 
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmp450_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE anmp450_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT anmp450_g01_subrep03
           DECLARE anmp450_g01_repcur03 CURSOR FROM g_sql
           FOREACH anmp450_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmp450_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT anmp450_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT anmp450_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
 
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
 
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
 
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.nmckent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmp450_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE anmp450_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT anmp450_g01_subrep04
           DECLARE anmp450_g01_repcur04 CURSOR FROM g_sql
           FOREACH anmp450_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmp450_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT anmp450_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT anmp450_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
 
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           #合計
           LET l_sum = GROUP SUM(sr1.nmck103)
           PRINTX l_sum           
           
           #寄回地址
           START REPORT anmp450_g01_subrep05
           LET g_sql = "SELECT DISTINCT NULL,NULL,oofb017 ",
                       "  FROM ooefl_t,ooef_t",
                       "  LEFT OUTER JOIN oofb_t ON ooefent = oofbent AND ooef012 = oofb002 AND oofb008 ='5' AND oofbstus = 'Y'",
                       " WHERE ooeflent =",sr1.nmckent CLIPPED, 
                       "   AND ooeflent = ooefent AND ooefl001 = ooef001", 
                       "   AND ooef017 = '",sr1.nmckcomp CLIPPED,"'" ,
                       "   AND ooefl002 = '",g_dlang CLIPPED,"'", 
                       "   AND ooefl001 = '",sr1.nmcksite CLIPPED,"'" ,
                       "   AND ooefstus = 'Y' AND rownum = 1"

              DECLARE anmp450_g01_repcur05 CURSOR FROM g_sql
              FOREACH anmp450_g01_repcur05 INTO sr3.*
                 OUTPUT TO REPORT anmp450_g01_subrep05(sr3.*)
              END FOREACH   
           FINISH REPORT anmp450_g01_subrep05
           
           #子報表07 (列印次頁)
           START REPORT anmp450_g01_subrep07
              LET g_sql = " SELECT '',nmck005,'',nmck103,NULL,",
                          "        trim(nmck005)||'.'||trim(nmck015),'','','','',",
                          "        '','','',nmck011,nmckdocdt,",
                          "        nmck025,nmcksite,nmckcomp,nmckdocno,nmckent",
                          "  FROM nmck_t",
                          " WHERE ",tm.wc CLIPPED,
                          " ORDER BY nmck005,nmckdocno"

              DECLARE anmp450_g01_repcur07 CURSOR FROM g_sql
              FOREACH anmp450_g01_repcur07 INTO sr6.*
              
                 #收件者姓名(廠商簡稱+財務主要連絡人)(廠商全名+財務主要連絡人)/寄達地址
                 LET sr6.l_pmaal004_pmaj012 = ''
                 LET sr6.l_pmaal003_pmaj012 = ''
                 LET l_pmaal004 = ''
                 LET l_pmaal003 = ''
                 LET l_pmaa027 = ''
                 LET sr6.l_pmaj012 = ''
                 LET sr6.l_oofb017 = ''
                 
                 SELECT DISTINCT pmaal004,pmaal003,pmaj012 INTO l_pmaal004,l_pmaal003,sr6.l_pmaj012
                   FROM nmck_t
                  LEFT OUTER JOIN pmaal_t ON nmckent = pmaalent AND  pmaal001 = nmck005 AND pmaal002 = g_dlang 
                  LEFT OUTER JOIN pmaj_t ON pmajent = pmaalent AND pmaj001 = pmaal001 AND nmckent = pmajent  AND pmaj001 = nmck005 AND pmaj005 = 'Y'
                   WHERE nmck005 = sr6.nmck005
                   
                 #收件者/寄達地址
                 LET l_date = cl_get_current()
                 
                 SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = sr6.nmckent AND pmaa001 = sr6.nmck005
                 
                 SELECT oofb017 INTO sr6.l_oofb017
                   FROM oofb_t
                  WHERE oofb002= l_pmaa027
                    AND oofbent = sr6.nmckent
                    AND (oofb018 is null or oofb018 >'",l_date,"')   #失效日期
                    AND oofbstus='Y'AND oofb008 = '2' AND oofb010 ='Y'
                 
                 LET sr6.l_pmaal004_pmaj012 = l_pmaal004 CLIPPED,'.',sr6.l_pmaj012 CLIPPED
                 LET sr6.l_pmaal003_pmaj012 = l_pmaal003 CLIPPED,'.',sr6.l_pmaj012 CLIPPED
                 
                 #寄件人名稱/詳細地址/電話號碼
                 SELECT DISTINCT ooefl006,oofb017,oofc012 INTO sr6.l_ooefl006,sr6.l_oofb017_1,sr6.l_oofc012
                   FROM ooefl_t,ooef_t
                 LEFT OUTER JOIN oofb_t ON ooefent = oofbent AND ooef012 = oofb002 AND oofb008 ='1' AND oofbstus = 'Y'
                 LEFT OUTER JOIN oofc_t ON oofcent = oofbent AND oofb002 = oofc002 AND ooef012 = oofc002 AND oofc008='1' AND oofcstus = 'Y'
                 WHERE ooeflent = sr6.nmckent AND ooeflent = ooefent AND ooefl001 = ooef001 
                   AND ooef017 = sr6.nmckcomp  AND ooefl002 = g_dlang  AND ooefl001 = sr6.nmcksite AND ooefstus = 'Y' AND rownum = 1
         
                 CALL anmp450_g01_initialize(l_pmaal004,sr6.l_pmaj012,sr6.l_pmaal004_pmaj012) RETURNING sr6.l_pmaal004_pmaj012
                 CALL anmp450_g01_initialize(l_pmaal003,sr6.l_pmaj012,sr6.l_pmaal004_pmaj012) RETURNING sr6.l_pmaal003_pmaj012
                 
                 LET l_ooag001 = tm.a4
                 CALL s_desc_get_person_desc(l_ooag001) RETURNING sr6.l_ooag011
                 
                 LET sr6.l_subrep07_order = sr6.nmcksite
                 OUTPUT TO REPORT anmp450_g01_subrep07(sr6.*)

              END FOREACH   
           FINISH REPORT anmp450_g01_subrep07
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
 
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="anmp450_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT anmp450_g01_subrep01(sr2)
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
PRIVATE REPORT anmp450_g01_subrep02(sr2)
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
PRIVATE REPORT anmp450_g01_subrep03(sr2)
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
PRIVATE REPORT anmp450_g01_subrep04(sr2)
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
 
{<section id="anmp450_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 判斷空值時,組合欄位之處理
# Memo...........:
# Usage..........: CALL anmp450_g01_initialize(p_arg1,p_arg2,p_exp)
# Input parameter: p_arg1 欄位1
#                : p_arg2 欄位2
#                : p_exp  組合欄位
# Date & Author..: 150608 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp450_g01_initialize(p_arg1,p_arg2,p_exp)
   DEFINE p_arg1   STRING
   DEFINE p_arg2   STRING
   DEFINE p_exp    STRING
   DEFINE r_exp    STRING
   
      IF NOT cl_null(p_arg1) AND NOT cl_null(p_arg2) THEN
         LET r_exp = p_exp
      END IF
      
      IF cl_null(p_arg1) AND NOT cl_null(p_arg2) THEN
         LET r_exp = p_arg2
      END IF
      
      IF NOT cl_null(p_arg1) AND cl_null(p_arg2) THEN
         LET r_exp = p_arg1
      END IF

      IF cl_null(p_arg1) AND cl_null(p_arg2) THEN
         INITIALIZE r_exp TO NULL
      END IF
      
   RETURN r_exp
END FUNCTION

 
{</section>}
 
{<section id="anmp450_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 頁尾資料
# Memo...........:
# Usage..........: CALL anmp450_g01_subrep05(sr3)
# Date & Author..: 150608 By Jessy
# Modify.........:
################################################################################
PRIVATE REPORT anmp450_g01_subrep05(sr3)
DEFINE sr3 sr3_r
   
   FORMAT
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.*

END REPORT

################################################################################
# Descriptions...: 發票號碼
# Memo...........:
# Usage..........: CALL anmp450_g01_subrep06(sr4)
# Date & Author..: 150609 By Jessy
# Modify.........:
################################################################################
PRIVATE REPORT anmp450_g01_subrep06(sr4)
DEFINE sr4 sr4_r

   FORMAT
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
END REPORT

################################################################################
# Descriptions...: 報表次頁列印
# Memo...........:
# Usage..........: CALL anmp450_g01_subrep07(sr6)
# Date & Author..: 150612 By Jessy
# Modify.........:
################################################################################
PRIVATE REPORT anmp450_g01_subrep07(sr6)
DEFINE sr6 sr6_r              
DEFINE l_year            STRING 
DEFINE l_month           STRING 
DEFINE l_day             STRING
DEFINE l_skip            LIKE type_t.chr1
DEFINE l_lineno          LIKE type_t.num5

ORDER BY sr6.l_subrep07_order

   FORMAT
      FIRST PAGE HEADER          
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         
      BEFORE GROUP OF sr6.l_subrep07_order
         CALL cl_gr_title_clear()  #清除title變數值 
         CALL s_desc_get_ooefl006_desc(sr6.nmckcomp) RETURNING g_grPageHeader.title0101
         CALL cl_gr_init_pageheader() #表頭資訊  
         PRINTX g_grPageHeader.*
         PRINTX g_grPageFooter.*
         CALL cl_gr_init_apr(sr6.nmckcomp)  
         LET g_doc_key = 'nmckent=' ,sr6.nmckent,'{+}nmckcomp=' ,sr6.nmckcomp       
         CALL cl_gr_init_apr(sr6.l_subrep07_order)
         LET l_lineno = 0
         PRINTX g_grSign.*         
      
      ON EVERY ROW
         LET l_year  = YEAR(g_today)
         LET l_month = MONTH(g_today)
         LET l_day   = DAY(g_today)
         
         PRINTX l_year,l_month,l_day
         
         LET l_lineno = l_lineno + 1
         PRINTX l_lineno
         
         LET l_skip='N'
         IF l_lineno MOD 20=0 THEN
            LET l_skip='Y'
         END IF
         
         PRINTX l_skip 
         PRINTX sr6.*
         
      AFTER GROUP OF sr6.l_subrep07_order
      
      
END REPORT

 
{</section>}
 