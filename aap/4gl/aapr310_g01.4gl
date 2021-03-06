#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr310_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-11-28 11:28:41), PR版次:0006(2016-11-28 14:37:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: aapr310_g01
#+ Description: ...
#+ Creator....: 05016(2015-07-23 09:25:59)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aapr310_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161109-00048#2  2016/11/24 By Reanna  1.畫面帳款日期區間主要抓取aapt3*與aapq3*為主,再利用此區間的帳款抓取所有aapt420資料作為已付金額
#                                      2.畫面增加截止日期,回溯此日之後所發生的付款單作為扣除已付金額
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
   l_pmaa016 LIKE type_t.chr100, 
   l_order LIKE type_t.chr100, 
   l_enddate LIKE type_t.dat, 
   l_strdate LIKE type_t.dat, 
   l_apca004_pmaal004 LIKE type_t.chr100, 
   apca100 LIKE apca_t.apca100, 
   l_apca004_oofc0122 LIKE type_t.chr100, 
   l_apca014_desc LIKE type_t.chr100, 
   l_type LIKE type_t.chr100, 
   apcasite LIKE apca_t.apcasite, 
   apcald LIKE apca_t.apcald, 
   apcaent LIKE apca_t.apcaent, 
   apcadocno LIKE apca_t.apcadocno, 
   apcadocdt LIKE apca_t.apcadocdt, 
   l_apce109 LIKE apce_t.apce109, 
   apcacomp LIKE apca_t.apcacomp, 
   apca108 LIKE apca_t.apca108, 
   l_apca004_desc LIKE type_t.chr100, 
   l_apca004_oofc012 LIKE type_t.chr100, 
   apca004 LIKE apca_t.apca004, 
   apcaud001 LIKE apca_t.apcaud001, 
   l_memo LIKE type_t.chr500, 
   apca010 LIKE apca_t.apca010, 
   l_apcb028 LIKE apcb_t.apcb028
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #Where condition 
       a1 LIKE type_t.chr10,         #apcasite 
       a2 LIKE type_t.dat,         #strdate 
       a3 LIKE type_t.dat,         #enddate 
       a4 LIKE type_t.chr1,         #是否包含暫估 
       a5 LIKE type_t.dat          #截止日期
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
DEFINE g_apcasite     LIKE apca_t.apcasite
DEFINE g_strdate      LIKE apca_t.apcadocdt
DEFINE g_enddate      LIKE apca_t.apcadocdt
DEFINE g_wc_apcacomp         STRING
TYPE sr5_r RECORD
     apca014        LIKE type_t.chr100,
     apcadocdt      LIKE apca_t.apcadocdt,
     apcadocno      LIKE apca_t.apcadocno,
     apca001        LIKE type_t.chr100,
     apca100        LIKE apca_t.apca100,
     apcb105        LIKE apcb_t.apcb105,
     apce109        LIKE apce_t.apce109,
     apca010        LIKE apca_t.apca010,
     apcb028        LIKE apcb_t.apcb028
     END RECORD
     
TYPE sr6_r RECORD
   apca100     LIKE apca_t.apca100,
   apcb105     LIKE apcb_t.apcb105,
   apce109     LIKE apce_t.apce109,
   sum_show    LIKE type_t.chr1
   END RECORD

TYPE sr7_r RECORD
   apca100     LIKE apca_t.apca100,
   apcb105     LIKE apcb_t.apcb105,
   sum_show    LIKE type_t.chr1
   END RECORD
   
DEFINE g_deadline      LIKE apca_t.apcadocdt  #161109-00048#2
#end add-point
 
{</section>}
 
{<section id="aapr310_g01.main" readonly="Y" >}
PUBLIC FUNCTION aapr310_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  Where condition 
DEFINE  p_arg2 LIKE type_t.chr10         #tm.a1  apcasite 
DEFINE  p_arg3 LIKE type_t.dat         #tm.a2  strdate 
DEFINE  p_arg4 LIKE type_t.dat         #tm.a3  enddate 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.a4  是否包含暫估 
DEFINE  p_arg6 LIKE type_t.dat         #tm.a5  截止日期
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
   LET tm.a5 = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_apcasite = tm.a1
   LET g_strdate  = tm.a2
   LET g_enddate  = tm.a3
   LET g_deadline  = tm.a5 #161109-00048#2
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aapr310_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aapr310_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aapr310_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aapr310_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr310_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr310_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   CALL aapr310_g01_create_tmp()   
   CALL aapr310_g01_insert_tmp()
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   

   
#   #end add-point
#   LET g_select = " SELECT '','',NULL,NULL,'',apca100,'','','',apcasite,apcald,apcaent,apcadocno,apcadocdt, 
#       '',apcacomp,apca108,'','',apca004,apcaud001,'',apca010,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM apca_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
 
#   #end add-point
#    LET g_order = " ORDER BY apcacomp,apca004"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
  
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("apca_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = "   SELECT '',trim(apcacomp)||trim(apca004),NULL,NULL,'',apca100,'','',apca001,   ",
               "          '','',apcaent,'','','',apcacomp,SUM(apcb105),'','',apca004,'','','','' ",
               "     FROM aapr310_tmp "
   LET g_sql = g_sql CLIPPED," WHERE seq = 1 AND ", tm.wc CLIPPED ,
                             "  GROUP BY trim(apcacomp)||trim(apca004),apca100,apca001,apcacomp,apca004,apcaent ",
                             "  ORDER BY apca100  "
          

   #end add-point
   PREPARE aapr310_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aapr310_g01_curs CURSOR FOR aapr310_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr310_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapr310_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_pmaa016 LIKE type_t.chr100, 
   l_order LIKE type_t.chr100, 
   l_enddate LIKE type_t.dat, 
   l_strdate LIKE type_t.dat, 
   l_apca004_pmaal004 LIKE type_t.chr100, 
   apca100 LIKE apca_t.apca100, 
   l_apca004_oofc0122 LIKE type_t.chr100, 
   l_apca014_desc LIKE type_t.chr100, 
   l_type LIKE type_t.chr100, 
   apcasite LIKE apca_t.apcasite, 
   apcald LIKE apca_t.apcald, 
   apcaent LIKE apca_t.apcaent, 
   apcadocno LIKE apca_t.apcadocno, 
   apcadocdt LIKE apca_t.apcadocdt, 
   l_apce109 LIKE apce_t.apce109, 
   apcacomp LIKE apca_t.apcacomp, 
   apca108 LIKE apca_t.apca108, 
   l_apca004_desc LIKE type_t.chr100, 
   l_apca004_oofc012 LIKE type_t.chr100, 
   apca004 LIKE apca_t.apca004, 
   apcaud001 LIKE apca_t.apcaud001, 
   l_memo LIKE type_t.chr500, 
   apca010 LIKE apca_t.apca010, 
   l_apcb028 LIKE apcb_t.apcb028
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_apca014 LIKE apca_t.apca014
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aapr310_g01_curs INTO sr_s.*
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
       #採購人員
       LET l_apca014 = sr_s.l_apca014_desc
       
       LET sr_s.l_apca004_pmaal004 = sr_s.apca004,".",s_desc_get_trading_partner_abbr_desc(sr_s.apca004)
              
       #聯繫電話
       SELECT oofc012 INTO sr_s.l_apca004_oofc012
         FROM oofc_t
         LEFT OUTER JOIN pmaa_t ON oofcent = pmaaent AND oofc002 = pmaa027
        WHERE oofcent = g_enterprise
          AND pmaa001 = sr_s.apca004
          AND oofc008 ='1'
       
       #傳真
       SELECT oofc012 INTO sr_s.l_apca004_oofc0122
         FROM oofc_t
         LEFT OUTER JOIN pmaa_t ON oofcent = pmaaent AND oofc002 = pmaa027
        WHERE oofcent = g_enterprise
          AND pmaa001 =sr_s.apca004
          AND oofc008 ='3'
       
       #l_pmaa016 #負責人
       SELECT pmaa016 INTO sr_s.l_pmaa016
         FROM pmaa_t
        WHERE pmaaent = g_enterprise
          AND pmaa001 = sr_s.apca004
       
       #帳款期間    #l_strdat,l_enddat
       LET sr_s.l_strdate = tm.a2
       LET sr_s.l_enddate = tm.a3

       #人員名稱
       LET sr_s.l_apca014_desc = s_desc_get_person_desc(l_apca014) 
       
       #客戶全稱       
       SELECT pmaal003 INTO sr_s.l_apca004_desc
         FROM pmaal_t
        WHERE pmaalent = g_enterprise
          AND pmaal001 = sr_s.apca004
          AND pmaal002 = g_dlang
       
       #項目名稱
       CALL s_desc_gzcbl004_desc('9743','10') RETURNING sr_s.l_type                                     
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_pmaa016 = sr_s.l_pmaa016
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].l_enddate = sr_s.l_enddate
       LET sr[l_cnt].l_strdate = sr_s.l_strdate
       LET sr[l_cnt].l_apca004_pmaal004 = sr_s.l_apca004_pmaal004
       LET sr[l_cnt].apca100 = sr_s.apca100
       LET sr[l_cnt].l_apca004_oofc0122 = sr_s.l_apca004_oofc0122
       LET sr[l_cnt].l_apca014_desc = sr_s.l_apca014_desc
       LET sr[l_cnt].l_type = sr_s.l_type
       LET sr[l_cnt].apcasite = sr_s.apcasite
       LET sr[l_cnt].apcald = sr_s.apcald
       LET sr[l_cnt].apcaent = sr_s.apcaent
       LET sr[l_cnt].apcadocno = sr_s.apcadocno
       LET sr[l_cnt].apcadocdt = sr_s.apcadocdt
       LET sr[l_cnt].l_apce109 = sr_s.l_apce109
       LET sr[l_cnt].apcacomp = sr_s.apcacomp
       LET sr[l_cnt].apca108 = sr_s.apca108
       LET sr[l_cnt].l_apca004_desc = sr_s.l_apca004_desc
       LET sr[l_cnt].l_apca004_oofc012 = sr_s.l_apca004_oofc012
       LET sr[l_cnt].apca004 = sr_s.apca004
       LET sr[l_cnt].apcaud001 = sr_s.apcaud001
       LET sr[l_cnt].l_memo = sr_s.l_memo
       LET sr[l_cnt].apca010 = sr_s.apca010
       LET sr[l_cnt].l_apcb028 = sr_s.l_apcb028
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr310_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapr310_g01_rep_data()
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
          START REPORT aapr310_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aapr310_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aapr310_g01_rep
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
 
{<section id="aapr310_g01.rep" readonly="Y" >}
PRIVATE REPORT aapr310_g01_rep(sr1)
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
DEFINE sr6       sr6_r
DEFINE sr7       sr7_r
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_subrep06_show  LIKE type_t.chr1
DEFINE l_subrep07_show  LIKE type_t.chr1
DEFINE l_flag           LIKE type_t.num5   #要不要印字
DEFINE l_print          LIKE type_t.chr1   #要不要印期初帳款
DEFINE l_apce109        LIKE apce_t.apce109
DEFINE l_type_show      LIKE type_t.chr1
DEFINE l_i              LIKE type_t.num5
DEFINE l_apcb105        LIKE apcb_t.apcb105
DEFINE l_seq            LIKE type_t.num5
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
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_order
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'apcaent=' ,sr1.apcaent,'{+}apcald=' ,sr1.apcald,'{+}apcadocno=' ,sr1.apcadocno         
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
                sr1.apcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr310_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aapr310_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aapr310_g01_subrep01
           DECLARE aapr310_g01_repcur01 CURSOR FROM g_sql
           FOREACH aapr310_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr310_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aapr310_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aapr310_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           LET l_type_show = "Y"
           PRINTX g_deadline  #161109-00048#2
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          PRINTX l_type_show
          LET l_type_show = "N"  

                    
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr310_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aapr310_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aapr310_g01_subrep02
           DECLARE aapr310_g01_repcur02 CURSOR FROM g_sql
           FOREACH aapr310_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr310_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aapr310_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aapr310_g01_subrep02
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
                sr1.apcaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr310_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aapr310_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aapr310_g01_subrep03
           DECLARE aapr310_g01_repcur03 CURSOR FROM g_sql
           FOREACH aapr310_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr310_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aapr310_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aapr310_g01_subrep03
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
                sr1.apcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr310_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aapr310_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aapr310_g01_subrep04
           DECLARE aapr310_g01_repcur04 CURSOR FROM g_sql
           FOREACH aapr310_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr310_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aapr310_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aapr310_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"

           #期間異動
           LET g_sql = "   SELECT apca014,apcadocdt,apcadocno,apca001,apca100,apcb105,apce109,apca010,apcb028,seq ",
                      "     FROM aapr310_tmp                       ",
                      "    WHERE seq != 1                          ",
                      "      AND apca004 = '",sr1.apca004,"'       "                     
           LET g_sql = g_sql CLIPPED," AND ", tm.wc CLIPPED ,                      
                      "    ORDER BY seq,apcadocdt,apca100                    "
                      
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr310_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE aapr310_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT aapr310_g01_subrep05
           DECLARE aapr310_g01_repcur05 CURSOR FROM g_sql
           LET l_flag = 1
           FOREACH aapr310_g01_repcur05 INTO sr5.*,l_seq
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr310_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF              
              #項目名稱
              CASE l_seq  
                 WHEN '2' 
                   CALL s_desc_gzcbl004_desc(8540,sr5.apca001) RETURNING sr5.apca001           
                 OTHERWISE
                   CALL s_desc_gzcbl004_desc(9743,'A3') RETURNING sr5.apca001
              END CASE               
               
              #人員名稱
              LET sr5.apca014 = s_desc_get_person_desc(sr5.apca014)                
              OUTPUT TO REPORT aapr310_g01_subrep05(sr5.*)
              END FOREACH
           FINISH REPORT aapr310_g01_subrep05           
           
           #期間合計
           LET g_sql = "   SELECT apca100,SUM(apcb105),SUM(apce109) ",
                       "     FROM aapr310_tmp                       ",
                       "    WHERE seq != 1                          ",
                       "      AND apca004 = '",sr1.apca004,"'       "
          LET g_sql = g_sql CLIPPED," AND ", tm.wc CLIPPED , 
                       "    GROUP BY apca100,apca004                ",
                       "    ORDER BY apca100                        "
                      
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_flag = 0
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr310_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE aapr310_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show
           START REPORT aapr310_g01_subrep06
           DECLARE aapr310_g01_repcur06 CURSOR FROM g_sql
           FOREACH aapr310_g01_repcur06 INTO sr6.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr310_g01_repcur06:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              IF l_flag = 0 THEN #合計只印一次
                 LET sr6.sum_show = 'Y'
              ELSE 
                 LET sr6.sum_show = 'N'
              END IF
              LET l_flag = l_flag + 1  
              OUTPUT TO REPORT aapr310_g01_subrep06(sr6.*)
           END FOREACH
           FINISH REPORT aapr310_g01_subrep06   
           
           #總計
           LET g_sql = "   SELECT DISTINCT apca100,''            ",                       
                       "     FROM aapr310_tmp                    ",
                       "      WHERE apca004 = '",sr1.apca004,"'  "
           LET g_sql = g_sql CLIPPED," AND ", tm.wc CLIPPED , 
                       "    GROUP BY apca100,apca004             ",
                       "    ORDER BY apca100                     "                      
                      
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep07_show ="N"
           LET l_flag = 0
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr310_g01_repcur07_cnt_pre FROM l_sub_sql
           EXECUTE aapr310_g01_repcur07_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep07_show ="Y"
           END IF
           PRINTX l_subrep07_show
           START REPORT aapr310_g01_subrep07
           DECLARE aapr310_g01_repcur07 CURSOR FROM g_sql
           FOREACH aapr310_g01_repcur07 INTO sr7.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr310_g01_repcur07:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              IF cl_null(sr7.apca100) THEN 
                 CONTINUE FOREACH
              END IF
              #期間立帳+期初帳款                        
              LET l_sub_sql = "  SELECT SUM(apcb105)         ", 
                          "   FROM aapr310_tmp               ",             
                          "  WHERE seq  != 3                 ",          
                          "    AND apca004 = '",sr1.apca004,"'     ",
                          "    AND apca100 = '",sr7.apca100,"'     "
              LET l_sub_sql = l_sub_sql CLIPPED ," AND ",tm.wc 
              PREPARE aapr310_prep04 FROM l_sub_sql
              EXECUTE aapr310_prep04 INTO l_apcb105
                            
              IF　cl_null(l_apcb105) THEN LET l_apcb105 = 0 END IF             
               
              #已付帳款
              LET l_sub_sql = "SELECT SUM(apce109)                  ",    
                          "  FROM aapr310_tmp                       ",
                          " WHERE seq  = 3                          ",
                          "   AND apca004 = '",sr1.apca004,"'             ",
                          "   AND apca100 = '",sr7.apca100,"'             "
              LET l_sub_sql = l_sub_sql CLIPPED ," AND ",tm.wc 
              PREPARE aapr310_prep05 FROM l_sub_sql
              EXECUTE aapr310_prep05 INTO l_apce109
                 
              IF　cl_null(l_apce109) THEN LET l_apce109 = 0 END IF
              LET sr7.apcb105  = l_apcb105 - l_apce109
              
              IF l_flag = 0 THEN #合計只印一次
                 LET sr7.sum_show = 'Y'
              ELSE 
                 LET sr7.sum_show = 'N'
              END IF
              LET l_flag = l_flag + 1  
              OUTPUT TO REPORT aapr310_g01_subrep07(sr7.*)
           END FOREACH
           FINISH REPORT aapr310_g01_subrep07   
         
          
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
       
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aapr310_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr310_g01_subrep01(sr2)
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
PRIVATE REPORT aapr310_g01_subrep02(sr2)
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
PRIVATE REPORT aapr310_g01_subrep03(sr2)
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
PRIVATE REPORT aapr310_g01_subrep04(sr2)
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
 
{<section id="aapr310_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aapr310_g01_create_tmp()
# Date & Author..: 2015/07/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr310_g01_create_tmp()

   DROP TABLE aapr310_tmp;
      CREATE TEMP TABLE aapr310_tmp(
         apcasite    LIKE apca_t.apcasite,
         apcacomp    LIKE apca_t.apcacomp,
         apcadocdt   LIKE apca_t.apcadocdt,
         apcadocno   LIKE apca_t.apcadocno,
         apca001     LIKE apca_t.apca001,
         apca004     LIKE apca_t.apca004, #客戶編號
         apca014     LIKE apca_t.apca014, #人員
         apca100     LIKE apca_t.apca100, #交易原幣
         apcb105     LIKE apcb_t.apcb105, #交易原幣含稅金額 
         apce109     LIKE apce_t.apce109, #本幣沖帳金額
         seq         LIKE type_t.num5,    #順序
         apcaent     LIKE apca_t.apcaent,
         apcald      LIKE apca_t.apcald,
         docno       LIKE apca_t.apcadocno,
         apca010     LIKE apca_t.apca010,
         apcb028     LIKE apcb_t.apcb028
        )

END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........:
# Usage..........: CALL aapr310_g01_insert_tmp()
# Date & Author..: 2015/07/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr310_g01_insert_tmp()
DEFINE l_glaa003       LIKE glaa_t.glaa003
DEFINE l_ld            LIKE glaa_t.glaald
DEFINE l_comp          LIKE apca_t.apcacomp
DEFINE l_year          LIKE xrea_t.xrea001
DEFINE l_mon           LIKE xrea_t.xrea002
DEFINE l_apca004       LIKE apca_t.apca004
DEFINE l_apcadocno     LIKE apca_t.apcadocno
DEFINE l_apce109       LIKE apce_t.apce109
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_wc            STRING
DEFINE l_wc_apca001    STRING
   
   LET l_wc = ' 1=1'
   LET l_wc_apca001 = "('15','12','26')"
   
   DELETE FROM aapr310_tmp
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_account_center_sons_query('3',g_apcasite,g_today,'')
   CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp
   CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
   LET l_year = YEAR(g_strdate)
   LET l_mon = MONTH(g_strdate)
   
   LET g_sql = "SELECT glaa003,glaald,glaacomp",
               "  FROM glaa_t",
               " WHERE glaaent = ",g_enterprise,
               "   AND glaa014 = 'Y' AND glaacomp IN ",g_wc_apcacomp
   PREPARE aapr310_prep FROM g_sql
   DECLARE aapr310_curs CURSOR FOR aapr310_prep
   FOREACH aapr310_curs INTO l_glaa003,l_ld,l_comp
      #取上期會計年月
      CALL s_fin_date_get_last_period(l_glaa003,l_ld,l_year,l_mon)
           RETURNING g_sub_success,l_year,l_mon
      
      #期初月結檔
      LET g_sql = "INSERT INTO aapr310_tmp ",
                  "SELECT xreasite,xreacomp,'','','99',xrea009,",
                  "      (SELECT apca014 FROM apca_t WHERE apcaent = xreaent",
                  "          AND xreald = apcald AND xrea005 = apcadocno),",
                  "      xrea100,((CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103*-1 ELSE xrea103 END)),",
                  "      '','1',xreaent,xreald,xrea005,'',''",
                  "  FROM xrea_t",
                  " WHERE xreaent = ",g_enterprise,
                  "   AND xrea003 = 'AP'",
                  "   AND xrea001 = '",l_year,"' AND xrea002 = '",l_mon,"'",
                  "   AND xreacomp = '",l_comp,"' AND xreald = '",l_ld,"'"
      LET g_sql = g_sql CLIPPED ," AND ",l_wc
      IF tm.a4 = 'N' THEN
         LET g_sql = g_sql CLIPPED , " AND xrea004 NOT LIKE '0%' "
      END IF
      PREPARE aapr310_ins_tmp FROM g_sql
      EXECUTE aapr310_ins_tmp
      
      #本期異動 直接抓apcb105 aapt3*+aapq3*的單據
      LET g_sql = "INSERT INTO aapr310_tmp ",
                  "SELECT apcasite,apcacomp,apcadocdt,apcb002,apcb001,",
                  "       apca004,apca014,apca100,",
                  "       ((CASE WHEN (apcb001 ='02' OR apcb001 = '04' OR apcb001 LIKE '2%') THEN apcb105 *-1 ELSE apcb105 END)),",
                  "       '','2',apcaent,apcald,apcadocno,apca010,apcb028",
                  "    FROM apca_t,apcb_t",
                  "   WHERE apcaent = apcbent AND apcaent = ",g_enterprise,
                  "     AND apcasite = '",g_apcasite,"'",
                  "     AND apcadocno = apcbdocno",
                  "     AND apcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'",
                  "     AND apcacomp = '",l_comp,"' AND apcald = '",l_ld,"'",
                  "     AND apcastus = 'Y'"
      LET g_sql = g_sql CLIPPED ," AND apca001 NOT IN ",l_wc_apca001," AND ",l_wc
      IF tm.a4 = 'N' THEN
         LET g_sql = g_sql CLIPPED , " AND apca001 NOT LIKE '0%' "
      END IF
      PREPARE aapr310_ins_tmp2 FROM g_sql
      EXECUTE aapr310_ins_tmp2
      
      #付款沖銷(aapt420沖帳) apda_t/apce_t
      LET g_sql = "INSERT INTO aapr310_tmp ",
                  "SELECT apdasite,apdacomp,apdadocdt,apdadocno,apda001,",
                  "       apda005,(SELECT apca014 FROM apca_t WHERE apcaent = apceent",
                  "                   AND apceld = apcald AND apce003 = apcadocno),",
                  "       apce100,'',apce109,'3',apdaent,apdald,apce003,'',''",
                  "  FROM apda_t,apce_t",
                  " WHERE apdaent = apceent AND apdaent = ",g_enterprise,
                  "   AND apdadocno = apcedocno AND apdald = apceld",
                  #"   AND apdadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'", #161109-00048#2 mark
                  "   AND apdadocdt <= '",g_deadline,"'", #161109-00048#2 add
                  "   AND apdacomp = '",l_comp,"' AND apdald = '",l_ld,"'",
                  "   AND apce001 = 'aapt420'"
      LET g_sql = g_sql CLIPPED ," AND ",l_wc
      LET g_sql = g_sql CLIPPED ," AND apce003 IN (SELECT docno FROM aapr310_tmp)" #161109-00048#2
      PREPARE aapr310_ins_tmp3 FROM g_sql
      EXECUTE aapr310_ins_tmp3

      #直接沖帳 apca_t/apce_t
      LET g_sql = "INSERT INTO aapr310_tmp ",
                  "SELECT apcasite,apcacomp,apcadocdt,apcadocno,apca001,",
                  "       apca004,apca014,apce100,'',",
                  "       ((CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apce109 *-1 ELSE apce109 END)),",                  
                  "       '3',apcaent,apcald,apcadocno,'',''",
                  "  FROM apca_t,apce_t",
                  " WHERE apcaent = apceent AND apcaent = ",g_enterprise,
                  "   AND apcadocno = apcedocno AND apcald = apceld",
                  #"   AND apcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'", #161109-00048#2 mark
                  "   AND apcadocdt <= '",g_deadline,"'", #161109-00048#2 add
                  "   AND apcacomp = '",l_comp,"' AND apcald = '",l_ld,"'"
      LET g_sql = g_sql CLIPPED ," AND apca001 NOT IN ",l_wc_apca001," AND ",l_wc
      IF tm.a4 = 'N' THEN
         LET g_sql = g_sql CLIPPED , " AND apca001 NOT LIKE '0%' "
      END IF
      LET g_sql = g_sql CLIPPED ," AND apcedocno IN (SELECT docno FROM aapr310_tmp)"  #161109-00048#2
      PREPARE aapr310_ins_tmp4 FROM g_sql
      EXECUTE aapr310_ins_tmp4
      
      #直接付款 apca_t/apde_t
      LET g_sql = "INSERT INTO aapr310_tmp ",
                  "SELECT apcasite,apcacomp,apcadocdt,apcadocno,apca001,",
                  "       apca004,apca014,apde100,'',",
                  "       ((CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apde109 *-1 ELSE apde109 END)),",                  
                  "       '3',apcaent,apcald,apcadocno,'',''",
                  "  FROM apca_t,apde_t",
                  " WHERE apcaent = apdeent AND apcaent = ",g_enterprise,
                  "   AND apcadocno = apdedocno AND apcald = apdeld",
                  #"   AND apcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'", #161109-00048#2 mark
                  "   AND apcadocdt <= '",g_deadline,"'", #161109-00048#2 add
                  "   AND apcacomp = '",l_comp,"' AND apcald = '",l_ld,"'"
      LET g_sql = g_sql CLIPPED ," AND apca001 NOT IN ",l_wc_apca001," AND ",l_wc
      IF tm.a4 = 'N' THEN
         LET g_sql = g_sql CLIPPED , " AND apca001 NOT LIKE '0%' "
      END IF
      LET g_sql = g_sql CLIPPED ," AND apdedocno IN (SELECT docno FROM aapr310_tmp)" #161109-00048#2
      PREPARE aapr310_ins_tmp5 FROM g_sql
      EXECUTE aapr310_ins_tmp5
      
   END FOREACH
   
   #期初沒資料 增加一筆資料
   LET g_sql = "SELECT DISTINCT apcald,apcacomp,apca004 FROM aapr310_tmp WHERE seq != 1 "
   PREPARE aapr310_prep2 FROM g_sql
   DECLARE aapr310_curs2 CURSOR FOR aapr310_prep2
   FOREACH aapr310_curs2 INTO l_ld,l_comp,l_apca004
      SELECT COUNT(*) INTO l_cnt
        FROM aapr310_tmp
       WHERE apcald = l_ld
         AND apcacomp = l_comp AND apca004 = l_apca004
         AND seq =1
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INSERT INTO aapr310_tmp
         VALUES(g_apcasite,l_comp,'','','99',l_apca004,'','',0,'','1',g_enterprise,l_ld,'','','')
      END IF
   END FOREACH 
#   #回推 直接抓apcc108不用回推
#   LET g_sql = "SELECT DISTINCT apcadocno FROM aapr310_tmp Where seq = 2     "
#   PREPARE aapr310_prep3 FROM g_sql
#   DECLARE aapr310_curs3 CURSOR FOR aapr310_prep3   
#   FOREACH aapr310_curs3 INTO l_apcadocno 
#
#      SELECT SUM(apce109) INTO l_apce109
#        FROM apce_t,apda_t 
#       WHERE apceent = apdaent AND apceent = g_enterprise
#         AND apdadocno = apcedocno 
#         AND apce003 = l_apcadocno AND apdadocdt > g_enddate
#         
#      IF cl_null(l_apce109) THEN LET l_apce109 = 0 END IF       
#      UPDATE aapr310_tmp
#         SET apcc108 = (apcc108+l_apce109)
#       WHERE apcadocno = l_apcadocno
#         AND seq = '2'
#   END FOREACH   
END FUNCTION

 
{</section>}
 
{<section id="aapr310_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 期初餘額
# Memo...........:
# Usage..........: CALL aapr310_g01_subrep05(sr5)
# Date & Author..: 2015/07/23 By Hans
# Modify.........:
################################################################################
PRIVATE REPORT aapr310_g01_subrep05(sr5)
DEFINE sr5   sr5_r

    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

################################################################################
# Descriptions...: 期間統計
# Memo...........:
# Usage..........: CALL aapr310_g01_subrep06(sr6)
# Date & Author..: 2015/07/24 By Hans
# Modify.........:
################################################################################
PRIVATE REPORT aapr310_g01_subrep06(sr6)
DEFINE sr6   sr6_r
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
END REPORT

################################################################################
# Descriptions...: 本期應付款
# Memo...........:
# Usage..........: CALL aapr310_g01_subrep07(sr7)
# Date & Author..: 2015/07/24 By Hans
# Modify.........:
################################################################################
PRIVATE REPORT aapr310_g01_subrep07(sr7)
DEFINE sr7   sr7_r
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr7.*
END REPORT

 
{</section>}
 
