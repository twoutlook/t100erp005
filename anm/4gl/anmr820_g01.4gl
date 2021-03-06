#該程式未解開Section, 採用最新樣板產出!
{<section id="anmr820_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-02-18 11:02:50), PR版次:0002(2016-03-18 15:52:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: anmr820_g01
#+ Description: ...
#+ Creator....: 02159(2015-10-22 19:11:24)
#+ Modifier...: 02291 -SD/PR- 02291
 
{</section>}
 
{<section id="anmr820_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160122-00001#26 2016/01/27 By yangtt   添加交易帳戶編號用戶權限空管 
#160122-00001#26 2016/03/16 By 07673    添加交易帳戶編號用戶權限空管,增加部门权限
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
   nmde001 LIKE nmde_t.nmde001, 
   nmde002 LIKE nmde_t.nmde002, 
   nmde004 LIKE nmde_t.nmde004, 
   nmde005 LIKE nmde_t.nmde005, 
   nmde017 LIKE nmde_t.nmde017, 
   nmde100 LIKE nmde_t.nmde100, 
   nmde101 LIKE nmde_t.nmde101, 
   nmde102 LIKE nmde_t.nmde102, 
   nmde103 LIKE nmde_t.nmde103, 
   nmde104 LIKE nmde_t.nmde104, 
   nmde105 LIKE nmde_t.nmde105, 
   nmde106 LIKE nmde_t.nmde106, 
   nmde111 LIKE nmde_t.nmde111, 
   nmde113 LIKE nmde_t.nmde113, 
   nmde114 LIKE nmde_t.nmde114, 
   nmde115 LIKE nmde_t.nmde115, 
   nmde116 LIKE nmde_t.nmde116, 
   nmde121 LIKE nmde_t.nmde121, 
   nmde123 LIKE nmde_t.nmde123, 
   nmde124 LIKE nmde_t.nmde124, 
   nmde125 LIKE nmde_t.nmde125, 
   nmde126 LIKE nmde_t.nmde126, 
   nmdecomp LIKE nmde_t.nmdecomp, 
   nmdedocdt LIKE nmde_t.nmdedocdt, 
   nmdedocno LIKE nmde_t.nmdedocno, 
   nmdeent LIKE nmde_t.nmdeent, 
   nmdeld LIKE nmde_t.nmdeld, 
   nmdesite LIKE nmde_t.nmdesite, 
   l_nmdeld_desc LIKE type_t.chr100, 
   l_nmdesite_desc LIKE type_t.chr100, 
   l_nmdecomp_desc LIKE type_t.chr100, 
   l_nmde005_desc LIKE type_t.chr100, 
   l_nmde004_desc LIKE type_t.chr100, 
   l_nmde001_nmde002 LIKE type_t.chr10, 
   l_glab005 LIKE type_t.chr20, 
   l_glab005_desc LIKE type_t.chr100, 
   l_order LIKE type_t.chr20, 
   l_nmde101_01 LIKE nmde_t.nmde101
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
   l_nmde100 LIKE nmde_t.nmde100,   #幣別
   l_nmde102 LIKE nmde_t.nmde102,   #原幣結存金額
   l_nmde103 LIKE nmde_t.nmde103,   #本幣結存金額
   l_nmde104 LIKE nmde_t.nmde104,   #本幣重評金額
   l_nmde105 LIKE nmde_t.nmde105    #本期匯差
END RECORD
DEFINE g_sql_bank        STRING     #160122-00001#26 by 07673
#end add-point
 
{</section>}
 
{<section id="anmr820_g01.main" readonly="Y" >}
PUBLIC FUNCTION anmr820_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #160122-00001#5 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#5 --add--end

   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "anmr820_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL anmr820_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL anmr820_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL anmr820_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmr820_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmr820_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT nmde001,nmde002,nmde004,nmde005,nmde017,nmde100,nmde101,nmde102,nmde103,nmde104, 
       nmde105,nmde106,nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124,nmde125,nmde126, 
       nmdecomp,nmdedocdt,nmdedocno,nmdeent,nmdeld,nmdesite,'','','','','','','','',trim(nmdeld)||'.'||trim(nmde001), 
       0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM nmde_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    #160122-00001#26 by 07673--modify---str
    LET g_where = g_where CLIPPED," AND (nmde004 IN(",g_sql_bank,")  OR TRIM(nmde004) IS NULL)"
    #160122-00001#26 by 07673--modify---end
   #end add-point
    LET g_order = " ORDER BY nmdeld,nmde001,nmde002"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmde_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE anmr820_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE anmr820_g01_curs CURSOR FOR anmr820_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmr820_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmr820_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   nmde001 LIKE nmde_t.nmde001, 
   nmde002 LIKE nmde_t.nmde002, 
   nmde004 LIKE nmde_t.nmde004, 
   nmde005 LIKE nmde_t.nmde005, 
   nmde017 LIKE nmde_t.nmde017, 
   nmde100 LIKE nmde_t.nmde100, 
   nmde101 LIKE nmde_t.nmde101, 
   nmde102 LIKE nmde_t.nmde102, 
   nmde103 LIKE nmde_t.nmde103, 
   nmde104 LIKE nmde_t.nmde104, 
   nmde105 LIKE nmde_t.nmde105, 
   nmde106 LIKE nmde_t.nmde106, 
   nmde111 LIKE nmde_t.nmde111, 
   nmde113 LIKE nmde_t.nmde113, 
   nmde114 LIKE nmde_t.nmde114, 
   nmde115 LIKE nmde_t.nmde115, 
   nmde116 LIKE nmde_t.nmde116, 
   nmde121 LIKE nmde_t.nmde121, 
   nmde123 LIKE nmde_t.nmde123, 
   nmde124 LIKE nmde_t.nmde124, 
   nmde125 LIKE nmde_t.nmde125, 
   nmde126 LIKE nmde_t.nmde126, 
   nmdecomp LIKE nmde_t.nmdecomp, 
   nmdedocdt LIKE nmde_t.nmdedocdt, 
   nmdedocno LIKE nmde_t.nmdedocno, 
   nmdeent LIKE nmde_t.nmdeent, 
   nmdeld LIKE nmde_t.nmdeld, 
   nmdesite LIKE nmde_t.nmdesite, 
   l_nmdeld_desc LIKE type_t.chr100, 
   l_nmdesite_desc LIKE type_t.chr100, 
   l_nmdecomp_desc LIKE type_t.chr100, 
   l_nmde005_desc LIKE type_t.chr100, 
   l_nmde004_desc LIKE type_t.chr100, 
   l_nmde001_nmde002 LIKE type_t.chr10, 
   l_glab005 LIKE type_t.chr20, 
   l_glab005_desc LIKE type_t.chr100, 
   l_order LIKE type_t.chr20, 
   l_nmde101_01 LIKE nmde_t.nmde101
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
    FOREACH anmr820_g01_curs INTO sr_s.*
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
       LET sr_s.l_nmdeld_desc = sr_s.nmdeld,".",s_desc_get_ld_desc(sr_s.nmdeld)
       LET sr_s.l_nmdesite_desc = sr_s.nmdesite,".",s_desc_get_department_desc(sr_s.nmdesite)
       LET sr_s.l_nmdecomp_desc = sr_s.nmdecomp,".",s_desc_get_department_desc(sr_s.nmdecomp)
       LET sr_s.l_nmde001_nmde002 = sr_s.nmde001 USING "&&&&",sr_s.nmde002 USING "&&"
       LET sr_s.l_nmde005_desc = s_desc_get_department_desc(sr_s.nmde005)
       LET sr_s.l_nmde004_desc = s_desc_get_nmas002_desc(sr_s.nmde004)
       #會計科目
       SELECT glab005 INTO sr_s.l_glab005
            FROM glab_t
           WHERE glabent = g_enterprise
             AND glabld  = sr_s.nmdeld
             AND glab001 = '40'
             AND glab002 = '40'
             AND glab003 = sr_s.nmde004
       LET sr_s.l_glab005_desc = s_desc_get_account_desc(sr_s.nmdeld,sr_s.l_glab005)
       #上期重評匯率
       IF sr_s.nmde002 = '1' THEN
          LET sr_s.nmde001 = sr_s.nmde001 - 1
          SELECT MAX(glav006) INTO sr_s.nmde002
            FROM glaa_t,glav_t
           WHERE glaaent = glavent
             AND glav001 = glaa003 
             AND glav002 = sr_s.nmde002  
             AND glav004 = sr_s.nmdedocdt
             AND glaaent = g_enterprise
             AND glaald  = sr_s.nmdeld
       ELSE
          LET sr_s.nmde002 = sr_s.nmde002 - 1        
       END IF
       SELECT nmde101 INTO sr_s.l_nmde101_01
         FROM nmde_t
        WHERE nmdeent = g_enterprise
          AND nmdeld = sr_s.nmdeld
          AND nmde001 = sr_s.nmde001
          AND nmde002 = sr_s.nmde002
          AND nmde004 = sr_s.nmde004
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].nmde001 = sr_s.nmde001
       LET sr[l_cnt].nmde002 = sr_s.nmde002
       LET sr[l_cnt].nmde004 = sr_s.nmde004
       LET sr[l_cnt].nmde005 = sr_s.nmde005
       LET sr[l_cnt].nmde017 = sr_s.nmde017
       LET sr[l_cnt].nmde100 = sr_s.nmde100
       LET sr[l_cnt].nmde101 = sr_s.nmde101
       LET sr[l_cnt].nmde102 = sr_s.nmde102
       LET sr[l_cnt].nmde103 = sr_s.nmde103
       LET sr[l_cnt].nmde104 = sr_s.nmde104
       LET sr[l_cnt].nmde105 = sr_s.nmde105
       LET sr[l_cnt].nmde106 = sr_s.nmde106
       LET sr[l_cnt].nmde111 = sr_s.nmde111
       LET sr[l_cnt].nmde113 = sr_s.nmde113
       LET sr[l_cnt].nmde114 = sr_s.nmde114
       LET sr[l_cnt].nmde115 = sr_s.nmde115
       LET sr[l_cnt].nmde116 = sr_s.nmde116
       LET sr[l_cnt].nmde121 = sr_s.nmde121
       LET sr[l_cnt].nmde123 = sr_s.nmde123
       LET sr[l_cnt].nmde124 = sr_s.nmde124
       LET sr[l_cnt].nmde125 = sr_s.nmde125
       LET sr[l_cnt].nmde126 = sr_s.nmde126
       LET sr[l_cnt].nmdecomp = sr_s.nmdecomp
       LET sr[l_cnt].nmdedocdt = sr_s.nmdedocdt
       LET sr[l_cnt].nmdedocno = sr_s.nmdedocno
       LET sr[l_cnt].nmdeent = sr_s.nmdeent
       LET sr[l_cnt].nmdeld = sr_s.nmdeld
       LET sr[l_cnt].nmdesite = sr_s.nmdesite
       LET sr[l_cnt].l_nmdeld_desc = sr_s.l_nmdeld_desc
       LET sr[l_cnt].l_nmdesite_desc = sr_s.l_nmdesite_desc
       LET sr[l_cnt].l_nmdecomp_desc = sr_s.l_nmdecomp_desc
       LET sr[l_cnt].l_nmde005_desc = sr_s.l_nmde005_desc
       LET sr[l_cnt].l_nmde004_desc = sr_s.l_nmde004_desc
       LET sr[l_cnt].l_nmde001_nmde002 = sr_s.l_nmde001_nmde002
       LET sr[l_cnt].l_glab005 = sr_s.l_glab005
       LET sr[l_cnt].l_glab005_desc = sr_s.l_glab005_desc
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].l_nmde101_01 = sr_s.l_nmde101_01
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmr820_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmr820_g01_rep_data()
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
          START REPORT anmr820_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT anmr820_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT anmr820_g01_rep
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
 
{<section id="anmr820_g01.rep" readonly="Y" >}
PRIVATE REPORT anmr820_g01_rep(sr1)
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
DEFINE l_sql           STRING
DEFINE sr5 sr5_r
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.nmde002,sr1.nmde100
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
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_order
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'nmdeent=' ,sr1.nmdeent,'{+}nmdeld=' ,sr1.nmdeld,'{+}nmde001=' ,sr1.nmde001,'{+}nmde002=' ,sr1.nmde002,'{+}nmde004=' ,sr1.nmde004         
            CALL cl_gr_init_apr(sr1.l_order)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
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
                sr1.nmdeent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr820_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE anmr820_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT anmr820_g01_subrep01
           DECLARE anmr820_g01_repcur01 CURSOR FROM g_sql
           FOREACH anmr820_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr820_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT anmr820_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT anmr820_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.nmde002
 
           #add-point:rep.b_group.nmde002.before name="rep.b_group.nmde002.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.nmde002.after name="rep.b_group.nmde002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.nmde100
 
           #add-point:rep.b_group.nmde100.before name="rep.b_group.nmde100.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.nmde100.after name="rep.b_group.nmde100.after"
           
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
                sr1.nmdeent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr820_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE anmr820_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT anmr820_g01_subrep02
           DECLARE anmr820_g01_repcur02 CURSOR FROM g_sql
           FOREACH anmr820_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr820_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT anmr820_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT anmr820_g01_subrep02
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
                sr1.nmdeent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr820_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE anmr820_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT anmr820_g01_subrep03
           DECLARE anmr820_g01_repcur03 CURSOR FROM g_sql
           FOREACH anmr820_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr820_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT anmr820_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT anmr820_g01_subrep03
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
                sr1.nmdeent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmr820_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE anmr820_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT anmr820_g01_subrep04
           DECLARE anmr820_g01_repcur04 CURSOR FROM g_sql
           FOREACH anmr820_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr820_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT anmr820_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT anmr820_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.nmde002
 
           #add-point:rep.a_group.nmde002.before name="rep.a_group.nmde002.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.nmde002.after name="rep.a_group.nmde002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.nmde100
 
           #add-point:rep.a_group.nmde100.before name="rep.a_group.nmde100.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.nmde100.after name="rep.a_group.nmde100.after"
           LET l_sql = "SELECT nmde100,SUM(nmde102),SUM(nmde103),SUM(nmde104),SUM(nmde105) ",
                       "  FROM nmde_t ",
                       " WHERE nmdeent = ",g_enterprise," ",
                       "   AND nmde100 = '",sr1.nmde100,"' ",					   
                       "   AND ",tm.wc CLIPPED,
                       " GROUP BY nmde100 "
           START REPORT anmr820_g01_subrep05
           DECLARE anmr820_g01_repcur05 CURSOR FROM l_sql
           FOREACH anmr820_g01_repcur05 INTO sr5.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmr820_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              OUTPUT TO REPORT anmr820_g01_subrep05(sr5.*)
              END FOREACH
           FINISH REPORT anmr820_g01_subrep05
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="anmr820_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT anmr820_g01_subrep01(sr2)
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
PRIVATE REPORT anmr820_g01_subrep02(sr2)
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
PRIVATE REPORT anmr820_g01_subrep03(sr2)
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
PRIVATE REPORT anmr820_g01_subrep04(sr2)
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
 
{<section id="anmr820_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="anmr820_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 幣別小計
# Memo...........:
# Usage..........: CALL anmr820_g01_subrep05(sr5)
# Input parameter: sr5   record變數
# Return code....: 無
# Date & Author..: 2015/10/23 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT anmr820_g01_subrep05(sr5)
DEFINE sr5 sr5_r    
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

 
{</section>}
 
