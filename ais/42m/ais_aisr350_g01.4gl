#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr350_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-11-09 17:07:31), PR版次:0005(2016-11-17 09:33:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000107
#+ Filename...: aisr350_g01
#+ Description: ...
#+ Creator....: 04152(2015-01-15 18:12:34)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aisr350_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#150306         2015/03/06 By Reanna 修改QBE條件傳入
#150311-00016#1 2015/03/13 By Reanna QBE條件增加狀態碼
#160914-00001#1 2016/11/09 By 06821  增加發票歷程檔(isat_t)列印,取有效發票本幣金額,取isat欄位同aapr300發票列印(串聯方式為:取條件法人+客戶+日期區間isaf下的isat全數列出,流水號以項序重編 )
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   l_group LIKE type_t.chr1, 
   isaf057 LIKE isaf_t.isaf057, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isafdocno LIKE isaf_t.isafdocno, 
   l_isag001 LIKE type_t.chr30, 
   isaf100 LIKE isaf_t.isaf100, 
   isaf105 LIKE isaf_t.isaf105, 
   isaf115 LIKE isaf_t.isaf115, 
   isafent LIKE isaf_t.isafent, 
   isafsite LIKE isaf_t.isafsite, 
   isafcomp LIKE isaf_t.isafcomp, 
   isaf003 LIKE isaf_t.isaf003, 
   l_isafcomp_ooefl003 LIKE type_t.chr1000, 
   l_isaf003_pmaal004 LIKE type_t.chr100, 
   l_isaf003_oofc012 LIKE type_t.chr30, 
   l_oofc012 LIKE type_t.chr30, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_pmaa016 LIKE pmaa_t.pmaa016, 
   l_date1 LIKE isaf_t.isafdocdt, 
   l_date2 LIKE isaf_t.isafdocdt, 
   l_print_line LIKE type_t.chr1, 
   l_memo LIKE type_t.chr1000, 
   l_order LIKE type_t.chr20
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #帳務中心 
       a2 LIKE type_t.dat,         #帳款期間起 
       a3 LIKE type_t.dat          #帳款期間迄
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
     isag001        LIKE isag_t.isag001,
     isaf105        LIKE isaf_t.isaf105,
     isaf100        LIKE isaf_t.isaf100
     END RECORD
TYPE sr6_r RECORD
     isaf057        LIKE isaf_t.isaf057,
     isbadocdt      LIKE isba_t.isbadocdt,
     isbadocno      LIKE isba_t.isbadocno,
     isag001        LIKE isag_t.isag001,
     isaf100        LIKE isaf_t.isaf100,
     isaf105        LIKE isaf_t.isaf105,
     isbc103        LIKE isbc_t.isbc103
     END RECORD
TYPE sr7_r RECORD
     isag001        LIKE isag_t.isag001,
     isaf100        LIKE isaf_t.isaf100,
     isaf105        LIKE isaf_t.isaf105,
     isbc103        LIKE isbc_t.isbc103
     END RECORD
TYPE sr8_r RECORD
     isag010        LIKE isag_t.isag010,
     isag001        LIKE isag_t.isag001,
     isaf100        LIKE isaf_t.isaf100,
     isag105        LIKE isag_t.isag105
     END RECORD
TYPE sr9_r RECORD  #子報表09
     l_order        LIKE type_t.chr20,      #排序
     isatdocno      LIKE isat_t.isatdocno,  #相關單據
     isatseq        LIKE isat_t.isatseq,    #項次
     isat003        LIKE isat_t.isat003,    #發票代碼
     isat004        LIKE isat_t.isat004,    #發票號碼
     isat010        LIKE isat_t.isat010,    #統一編號      
     isat007        LIKE isat_t.isat007,    #發票日期
     isat023        LIKE isat_t.isat023,    #稅率
     isat113        LIKE isat_t.isat113,    #本幣未稅
     isat114        LIKE isat_t.isat114,    #稅額
     isat115        LIKE isat_t.isat115,    #本幣含稅
     l_isat003      LIKE isat_t.isat003     #發票代碼隱顯
     END RECORD
#end add-point
 
{</section>}
 
{<section id="aisr350_g01.main" readonly="Y" >}
PUBLIC FUNCTION aisr350_g01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  帳務中心 
DEFINE  p_arg3 LIKE type_t.dat         #tm.a2  帳款期間起 
DEFINE  p_arg4 LIKE type_t.dat         #tm.a3  帳款期間迄
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aisr350_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aisr350_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aisr350_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aisr350_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisr350_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr350_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   DEFINE l_main_sql      STRING
   DEFINE l_wc_date       STRING
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
 
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT C,isaf057,isafdocdt,isag002,isag001,isaf100",
                  "       ,A,B,isafent,isafsite,isafcomp",
                  "       ,isaf003,'','','',''",
                  "       ,pmaal003,'','','',''",
                  "       ,'',trim(isafcomp)||trim(isaf003)"
#   #end add-point
#   LET g_select = " SELECT NULL,isaf057,isafdocdt,isafdocno,NULL,isaf100,isaf105,isaf115,isafent,isafsite, 
#       isafcomp,isaf003,NULL,NULL,trim(isaf001)||'.'||trim(isaf002),trim(isaf001)||'.'||trim(isaf002), 
#       ( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaalent = isaf_t.isafent AND pmaal_t.pmaal001 = isaf_t.isaf003 AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),NULL,NULL,NULL,'','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET l_main_sql = " SELECT '1' AS C,isaf057,isafdocdt,isag002,isag001",
                    "       ,isaf100,SUM(isag105*isag015) AS A,0 AS B,isafent,isafsite",
                    "       ,isafcomp,isaf003",
                    "   FROM isaf_t",
                    "   LEFT OUTER JOIN isag_t ON isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                    "  WHERE isafent=",g_enterprise,
                    #"    AND isafstus ='Y'",   #150311-00016#1 mark
                    "    AND isafcomp IN ",tm.a1,
                    "    AND ",tm.wc, #150306
                    "    !@# ",   #用!@# 取代日期條件
                    "  GROUP BY isag002,isafdocdt,isaf100,isaf057,isag001,isafent,isafsite,isafcomp,isaf003",
                    " UNION ",
                    " SELECT '2','',isbadocdt,isbadocno,''",
                    "       ,isaf100,0,SUM(isbc103),isbaent,''",
                    "       ,isbacomp,isba003",
                    "   FROM isba_t",
                    "   LEFT OUTER JOIN isbc_t ON isbaent = isbcent AND isbacomp = isbccomp AND isbadocno = isbcdocno",
                    "   LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno",
                    "  WHERE isbaent=",g_enterprise,
                    #"    AND isbastus ='Y'",   #150311-00016#1 mark
                    "    AND isbacomp IN ",tm.a1,
                    "    AND ",tm.wc, #150306
                    "    !@# ",   #用!@# 取代日期條件
                    "  GROUP BY isbadocno,isbadocdt,isaf100,isbaent,isbacomp,isba003"
   
   #取QBE日期區間異動資料
   LET l_wc_date = " AND isafdocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'"
   CALL s_chr_replace(l_main_sql,'!@#',l_wc_date,1) RETURNING l_sql1
   LET l_wc_date = " AND isbadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'"
   CALL s_chr_replace(l_sql1,'!@#',l_wc_date,1) RETURNING l_sql1
   
   #取尚未付款金額
   LET l_wc_date = " AND isafdocdt < '",tm.a2,"'"
   CALL s_chr_replace(l_main_sql,'!@#',l_wc_date,1) RETURNING l_sql2
   LET l_wc_date = " AND isbadocdt < '",tm.a2,"'"
   CALL s_chr_replace(l_sql2,'!@#',l_wc_date,1) RETURNING l_sql2
    
   #最後在把"QBE日期區間異動資料"+"尚未付款金額(期初餘額)"GROUP BY
   LET g_from = "  FROM (",
                "          SELECT C,isaf057,isafdocdt,isag002,isag001",
                "                 ,isaf100,SUM(A) AS A,SUM(B) AS B,isafent,isafsite",
                "                 ,isafcomp,isaf003",
                "            FROM (",l_sql1,") ",
                "            GROUP BY C,isag002,isafdocdt,isaf100,isaf057,isag001,isafent,isafsite,isafcomp,isaf003",
                "          UNION ",
                "          SELECT '0','',(SELECT apafcrtdt FROM apaf_t WHERE apaf001='!'),'',''",
                "                ,isaf100,SUM(A)-SUM(B),0,isafent,''",
                "                ,isafcomp,isaf003",
                "            FROM (",l_sql2,") ",
                "            GROUP BY isafent,isafcomp,isaf003,isaf100",
                "        )",
                "  LEFT OUTER JOIN pmaal_t ON pmaalent = ",g_enterprise," AND pmaal001 = isaf003 AND pmaal002 = '",g_dlang,"'"
#   #end add-point
#    LET g_from = " FROM isaf_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE 1=1" #150306
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
    LET g_order = " ORDER BY isafcomp,isaf003"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY isafcomp,isaf003,C,isafdocdt,isaf100"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("isaf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aisr350_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aisr350_g01_curs CURSOR FOR aisr350_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisr350_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisr350_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_group LIKE type_t.chr1, 
   isaf057 LIKE isaf_t.isaf057, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isafdocno LIKE isaf_t.isafdocno, 
   l_isag001 LIKE type_t.chr30, 
   isaf100 LIKE isaf_t.isaf100, 
   isaf105 LIKE isaf_t.isaf105, 
   isaf115 LIKE isaf_t.isaf115, 
   isafent LIKE isaf_t.isafent, 
   isafsite LIKE isaf_t.isafsite, 
   isafcomp LIKE isaf_t.isafcomp, 
   isaf003 LIKE isaf_t.isaf003, 
   l_isafcomp_ooefl003 LIKE type_t.chr1000, 
   l_isaf003_pmaal004 LIKE type_t.chr100, 
   l_isaf003_oofc012 LIKE type_t.chr30, 
   l_oofc012 LIKE type_t.chr30, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_pmaa016 LIKE pmaa_t.pmaa016, 
   l_date1 LIKE isaf_t.isafdocdt, 
   l_date2 LIKE isaf_t.isafdocdt, 
   l_print_line LIKE type_t.chr1, 
   l_memo LIKE type_t.chr1000, 
   l_order LIKE type_t.chr20
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_n             INTEGER  #計算對帳單筆數
   DEFINE l_n2            INTEGER  #計算收款單筆數
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_n = 1
    LET l_n2 = 1
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aisr350_g01_curs INTO sr_s.*
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
       #客戶編號
       IF NOT cl_null(sr_s.isaf003) THEN
          LET sr_s.l_isaf003_pmaal004 = sr_s.isaf003 CLIPPED,".",s_desc_get_trading_partner_abbr_desc(sr_s.isaf003) CLIPPED
       END IF
       
       #聯繫電話
       SELECT oofc012 INTO sr_s.l_isaf003_oofc012
         FROM oofc_t
         LEFT OUTER JOIN pmaa_t ON oofcent = pmaaent AND oofc002 = pmaa027
        WHERE oofcent = g_enterprise
          AND pmaa001 = sr_s.isaf003
          AND oofc008 ='1'
       
       #傳真
       SELECT oofc012 INTO sr_s.l_oofc012
         FROM oofc_t
         LEFT OUTER JOIN pmaa_t ON oofcent = pmaaent AND oofc002 = pmaa027
        WHERE oofcent = g_enterprise
          AND pmaa001 = sr_s.isaf003
          AND oofc008 ='3'
       
       #負責人
       SELECT pmaa016 INTO sr_s.l_pmaa016
         FROM pmaa_t
        WHERE pmaaent = g_enterprise
          AND pmaa001 = sr_s.isaf003

       #帳款期間
       LET sr_s.l_date1 = tm.a2
       LET sr_s.l_date2 = tm.a3

       #人員名稱
       IF NOT cl_null(sr_s.isaf057) THEN
          LET sr_s.isaf057 = sr_s.isaf057 CLIPPED,".",s_desc_get_person_desc(sr_s.isaf057) CLIPPED
       END IF
       
       #項目名稱
       CASE
          WHEN sr_s.l_group = "0"
             #期初金額
             LET sr_s.l_isag001 = s_desc_gzcbl004_desc('9743','10') CLIPPED
          WHEN sr_s.l_group = "1"
             #對帳單
             LET sr_s.l_isag001 = s_desc_gzcbl004_desc('8341',sr_s.l_isag001) CLIPPED
             LET l_n2 = l_n2 + 1 #計算有沒有對帳單存在
          WHEN sr_s.l_group = "2"
             #收款核銷
             LET sr_s.l_isag001 = s_desc_gzcbl004_desc('9743','A') CLIPPED
       END CASE
       
       LET sr_s.l_print_line = "N"
       IF l_cnt > 1 THEN
          IF sr[l_cnt-1].l_group <> sr_s.l_group THEN
             LET sr_s.l_print_line = "Y"
          END IF
       END IF
       
       #150304-00006#1 add ------
       #若有出貨/銷退單，日期改抓扣帳日
       IF NOT cl_null(sr_s.isafdocno) THEN
          SELECT xmdk001 INTO sr_s.isafdocdt
            FROM xmdk_t
           WHERE xmdkent = g_enterprise
             AND xmdkdocno = sr_s.isafdocno
       END IF
       #150304-00006#1 add end---
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_group = sr_s.l_group
       LET sr[l_cnt].isaf057 = sr_s.isaf057
       LET sr[l_cnt].isafdocdt = sr_s.isafdocdt
       LET sr[l_cnt].isafdocno = sr_s.isafdocno
       LET sr[l_cnt].l_isag001 = sr_s.l_isag001
       LET sr[l_cnt].isaf100 = sr_s.isaf100
       LET sr[l_cnt].isaf105 = sr_s.isaf105
       LET sr[l_cnt].isaf115 = sr_s.isaf115
       LET sr[l_cnt].isafent = sr_s.isafent
       LET sr[l_cnt].isafsite = sr_s.isafsite
       LET sr[l_cnt].isafcomp = sr_s.isafcomp
       LET sr[l_cnt].isaf003 = sr_s.isaf003
       LET sr[l_cnt].l_isafcomp_ooefl003 = sr_s.l_isafcomp_ooefl003
       LET sr[l_cnt].l_isaf003_pmaal004 = sr_s.l_isaf003_pmaal004
       LET sr[l_cnt].l_isaf003_oofc012 = sr_s.l_isaf003_oofc012
       LET sr[l_cnt].l_oofc012 = sr_s.l_oofc012
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].l_pmaa016 = sr_s.l_pmaa016
       LET sr[l_cnt].l_date1 = sr_s.l_date1
       LET sr[l_cnt].l_date2 = sr_s.l_date2
       LET sr[l_cnt].l_print_line = sr_s.l_print_line
       LET sr[l_cnt].l_memo = sr_s.l_memo
       LET sr[l_cnt].l_order = sr_s.l_order
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
 
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr350_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisr350_g01_rep_data()
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
          START REPORT aisr350_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aisr350_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aisr350_g01_rep
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
 
{<section id="aisr350_g01.rep" readonly="Y" >}
PRIVATE REPORT aisr350_g01_rep(sr1)
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
DEFINE l_sql     STRING
DEFINE sr5       sr5_r 
DEFINE sr6       sr6_r
DEFINE sr7       sr7_r
DEFINE sr8       sr8_r
DEFINE sr9       sr9_r  #160914-00001#1 add
DEFINE i         INTEGER
DEFINE l_count          LIKE type_t.num5
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_subrep06_show  LIKE type_t.chr1
DEFINE l_subrep07_show  LIKE type_t.chr1
DEFINE l_subrep08_show  LIKE type_t.chr1
DEFINE l_comment        LIKE type_t.chr20
DEFINE l_print          LIKE type_t.chr1   #要不要印期初帳款
DEFINE l_flag           LIKE type_t.num5   #要不要印字
DEFINE l_subrep09_show  LIKE type_t.chr1   #160914-00001#1 add
DEFINE l_ooef019        LIKE ooef_t.ooef019 #160914-00001#1 add
DEFINE l_isatseq        LIKE isat_t.isatseq #160914-00001#1 add
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.l_group,sr1.isafdocdt,sr1.isaf100
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
            #單頭說明
            CALL s_desc_get_ooefl006_desc(sr1.isafcomp) RETURNING g_grPageHeader.title0101
            CALL cl_gr_init_pageheader() #表頭資訊  
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*  #150701-00001#1
            CALL cl_gr_init_apr(sr1.isafcomp)
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'isafent=' ,sr1.isafent,'{+}isafcomp=' ,sr1.isafcomp,'{+}isafdocno=' ,sr1.isafdocno         
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
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                 sr1.isafent CLIPPED ,"'", " AND  ooff002 = '", sr1.isafcomp CLIPPED ,"' AND  ooff003 = '", sr1.isaf003 CLIPPED ,"'"
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aisr350_g01_subrep01
           DECLARE aisr350_g01_repcur01 CURSOR FROM g_sql
           FOREACH aisr350_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aisr350_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           LET l_print = "Y" #在這先給初始值Y表示要印
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_group
 
           #add-point:rep.b_group.l_group.before name="rep.b_group.l_group.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_group.after name="rep.b_group.l_group.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.isafdocdt
 
           #add-point:rep.b_group.isafdocdt.before name="rep.b_group.isafdocdt.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.isafdocdt.after name="rep.b_group.isafdocdt.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.isaf100
 
           #add-point:rep.b_group.isaf100.before name="rep.b_group.isaf100.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.isaf100.after name="rep.b_group.isaf100.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
           PRINTX l_print
           #期初餘額
           LET g_sql = "SELECT '',SUM(A)-SUM(B),isaf100",
                       "  FROM(",
                       "       SELECT isafdocno,0 AS C,isaf105 AS A,0 AS B,isaf100",
                       "         FROM isaf_t",
                       "        WHERE isafent = ",g_enterprise,
                       "          AND isafstus ='Y'",
                       "          AND isafcomp = '",sr1.isafcomp,"'",
                       "          AND isaf003 = '",sr1.isaf003,"'",
                       "          AND isafdocdt < '",tm.a2,"'",
                       "        GROUP BY isafdocno,isaf105,isaf100",
                       "       UNION",
                       "       SELECT isbadocno,isbcseq,0,isbc103,isaf100",
                       "         FROM isba_t",
                       "         LEFT OUTER JOIN isbc_t ON isbaent = isbcent AND isbacomp = isbccomp AND isbadocno = isbcdocno",
                       "         LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno",
                       "        WHERE isbaent= ",g_enterprise,
                       "          AND isbastus ='Y'",
                       "          AND isbacomp = '",sr1.isafcomp,"'",
                       "          AND isaf003 = '",sr1.isaf003,"'",
                       "          AND isbadocdt < '",tm.a2,"'",
                       "        GROUP BY isbadocno,isbcseq,isbc103,isaf100",
                       "       )",
                       "  GROUP BY isaf100"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep05_show ="Y"
           END IF
           LET l_subrep05_show ="N"
           PRINTX l_subrep05_show
           START REPORT aisr350_g01_subrep05
           DECLARE aisr350_g01_repcur05 CURSOR FROM g_sql
           LET l_flag = 1
           FOREACH aisr350_g01_repcur05 INTO sr5.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              #期初帳款名稱
              IF l_flag = 1 THEN
                 LET sr5.isag001 = s_desc_gzcbl004_desc('9743','10') CLIPPED
              ELSE
                 LET sr5.isag001 = ''
              END IF
              LET l_flag = l_flag + 1
              OUTPUT TO REPORT aisr350_g01_subrep05(sr5.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep05
           LET l_print = "N" #只印一次就好
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                 sr1.isafent CLIPPED ,"'", " AND  ooff002 = '", sr1.isafcomp CLIPPED ,"' AND  ooff003 = '", sr1.isaf003 CLIPPED ,"'"
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aisr350_g01_subrep02
           DECLARE aisr350_g01_repcur02 CURSOR FROM g_sql
           FOREACH aisr350_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aisr350_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep02
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
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff002 = '", 
                 sr1.isafent CLIPPED ,"' AND  ooff002 = '", sr1.isafcomp CLIPPED ,"' AND  ooff003 = '", sr1.isaf003 CLIPPED ,"'"
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
#                sr1.isafent CLIPPED ,"'"
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aisr350_g01_subrep03
           DECLARE aisr350_g01_repcur03 CURSOR FROM g_sql
           FOREACH aisr350_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aisr350_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           #收款單
           LET g_sql = "SELECT '',isbadocdt,isbadocno,'',isaf100",
                       "      ,0,SUM(isbc103)",
                       "  FROM isba_t",
                       "  LEFT OUTER JOIN isbc_t ON isbaent = isbcent AND isbacomp = isbccomp AND isbadocno = isbcdocno",
                       "  LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno",
                       " WHERE isbaent=",g_enterprise,
                       "   AND isbacomp='",sr1.isafcomp,"'",
                       "   AND isaf003='",sr1.isaf003,"'",
                       "   AND isbadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'",
                       "   AND isafstus = 'Y'",
                       "   AND isbastus = 'Y'",
                       " GROUP BY isbadocno,isbadocdt,isaf100"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep06_show ="Y"
           END IF
           LET l_subrep06_show ="N" #先不印
           PRINTX l_subrep06_show
           START REPORT aisr350_g01_subrep06
           DECLARE aisr350_g01_repcur06 CURSOR FROM g_sql
           FOREACH aisr350_g01_repcur06 INTO sr6.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur06:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              #收款核銷
              LET sr6.isag001 = s_desc_gzcbl004_desc('9743','A') CLIPPED

              OUTPUT TO REPORT aisr350_g01_subrep06(sr6.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep06
           
           
                      
           #合計
           LET g_sql = "SELECT '',isaf100,SUM(A),SUM(B)",
                       "  FROM(",
                       "       SELECT isafdocno,isaf100,SUM(isag105*isag015) AS A,0 AS B",
                       "         FROM isaf_t",
                       "         LEFT OUTER JOIN isag_t ON isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                       "        WHERE isafent = ",g_enterprise,
                       #"          AND isafstus ='Y'",   #150311-00016#1 mark
                       "          AND isafcomp = '",sr1.isafcomp,"'",
                       "          AND isaf003 = '",sr1.isaf003,"'",
                       "          AND ",tm.wc, #150306
                       "          AND isafdocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'",
                       "        GROUP BY isafdocno,isaf100",
                       "       UNION",
                       "       SELECT isbadocno,isaf100,0,SUM(isbc103)",
                       "         FROM isba_t",
                       "         LEFT OUTER JOIN isbc_t ON isbaent = isbcent AND isbacomp = isbccomp AND isbadocno = isbcdocno",
                       "         LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno",
                       "        WHERE isbaent= ",g_enterprise,
                       #"          AND isbastus ='Y'",   #150311-00016#1 mark
                       "          AND isbacomp = '",sr1.isafcomp,"'",
                       "          AND isaf003 = '",sr1.isaf003,"'",
                       "          AND ",tm.wc, #150306
                       "          AND isbadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'",
                       "        GROUP BY isbadocno,isaf100",
                       "       )",
                       "  GROUP BY isaf100",
                       "  ORDER BY isaf100"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep07_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur07_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur07_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep07_show ="Y"
           END IF
           PRINTX l_subrep07_show
           START REPORT aisr350_g01_subrep07
           DECLARE aisr350_g01_repcur07 CURSOR FROM g_sql
           LET l_flag = 1
           FOREACH aisr350_g01_repcur07 INTO sr7.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur07:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              #合計名稱
              LET sr7.isag001 = ''
              IF l_flag = 1 THEN
                 CALL s_azzi902_get_gzzd('aapq930','sum01') RETURNING sr7.isag001,l_comment
              END IF
              LET l_flag = l_flag + 1
              OUTPUT TO REPORT aisr350_g01_subrep07(sr7.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep07
           
           
           
           #本期應收款
           LET g_sql = "SELECT '','',isaf100,SUM(A)-SUM(B)",
                       "  FROM(",
                       "       SELECT isafdocno,isaf100,SUM(isag105*isag015) AS A,0 AS B",
                       "         FROM isaf_t",
                       "         LEFT OUTER JOIN isag_t ON isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                       "        WHERE isafent = ",g_enterprise,
                       #"          AND isafstus ='Y'",   #150311-00016#1 mark
                       "          AND isafcomp = '",sr1.isafcomp,"'",
                       "          AND isaf003 = '",sr1.isaf003,"'",
                       "          AND ",tm.wc, #150306
                       "          AND isafdocdt <= '",tm.a3,"'",
                       "        GROUP BY isafdocno,isaf100",
                       "       UNION",
                       "       SELECT isbadocno,isaf100,0,SUM(isbc103)",
                       "         FROM isba_t",
                       "         LEFT OUTER JOIN isbc_t ON isbaent = isbcent AND isbacomp = isbccomp AND isbadocno = isbcdocno",
                       "         LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno",
                       "        WHERE isbaent= ",g_enterprise,
                       #"          AND isbastus ='Y'",   #150311-00016#1 mark
                       "          AND isbacomp = '",sr1.isafcomp,"'",
                       "          AND isaf003 = '",sr1.isaf003,"'",
                       "          AND ",tm.wc, #150306
                       "          AND isbadocdt <= '",tm.a3,"'",
                       "        GROUP BY isbadocno,isaf100",
                       "       )",
                       "  GROUP BY isaf100",
                       "  ORDER BY isaf100"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep08_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur08_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur08_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep08_show ="Y"
           END IF
           PRINTX l_subrep08_show
           START REPORT aisr350_g01_subrep08
           DECLARE aisr350_g01_repcur08 CURSOR FROM g_sql
           LET l_flag = 1
           FOREACH aisr350_g01_repcur08 INTO sr8.*
              IF STATUS THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur08:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()
                 EXIT FOREACH
              END IF
              #本期應收款名稱
              LET sr8.isag010 = ''
              IF l_flag = 1 THEN
                 CALL cl_getmsg("ais-00186",g_lang) RETURNING sr8.isag010
                 CALL s_azzi902_get_gzzd('aisr350','lbl_isag001') RETURNING sr8.isag001,l_comment
              END IF
              LET l_flag = l_flag + 1
              OUTPUT TO REPORT aisr350_g01_subrep08(sr8.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep08
           
           #160914-00001#1 --s add
           #子報表09
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep09_show = "N"
           LET l_isatseq = 0
           LET g_sql = "SELECT trim(isafcomp)||trim(isaf003),isatdocno,'",l_isatseq,"',isat003,isat004,isat010,",      
                       "       isat007,isat023,isat113,isat114,isat115,'' ",                                        
                       "  FROM isaf_t,isat_t ",                                          
                       " WHERE isatent =  '",g_enterprise,"'",
                       "   AND isatent = isafent AND isatcomp = isafcomp AND isatdocno = isafdocno ",
                       "   AND isatcomp = '",sr1.isafcomp CLIPPED,"'",
                       "   AND isaf003 = '",sr1.isaf003,"'",
                       "   AND ",tm.wc,
                       "   AND isafdocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'",
                       "   AND isat014 NOT IN ('12','22') AND isat025 NOT IN ('12','22') ",
                       " GROUP BY isafcomp,isaf003,isatdocno,isat003,isat004,isat010,isat007,isat023,isat113,isat114,isat115 ",
                       " ORDER BY isafcomp,isaf003,isatdocno,isat003,isat004,isat010,isat007,isat023 "
                       
           LET l_sub_sql = "SELECT COUNT(*) FROM (",g_sql,")"     
           PREPARE aisr350_g01_repcur09_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur09_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep09_show ="Y"
           END IF
           PRINTX l_subrep09_show
           
           START REPORT aisr350_g01_subrep09
           DECLARE aisr350_g01_repcur09 CURSOR FROM g_sql
           FOREACH aisr350_g01_repcur09 INTO sr9.*
           
              #項次
              LET l_isatseq = l_isatseq +1
              LET sr9.isatseq = l_isatseq
              
              #取得稅區
              LET l_ooef019 = ''
              SELECT ooef019 INTO l_ooef019
                FROM ooef_t
               WHERE ooefent = g_enterprise
                 AND ooef001 = sr1.isafcomp
                 AND ooefstus = 'Y'
                 
              #取得發票編碼方式
              LET sr9.l_isat003  = ''
              SELECT isai002 INTO sr9.l_isat003
                FROM isai_t
               WHERE isaient = g_enterprise
                 AND isai001 = l_ooef019
              OUTPUT TO REPORT aisr350_g01_subrep09(sr9.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep09
           #160914-00001#1 --e add
           
           
           #備註
           LET sr1.l_memo = cl_getmsg("ais-00181",g_lang) CLIPPED,"\r\n"
           LET sr1.l_memo = sr1.l_memo,cl_getmsg("ais-00182",g_lang) CLIPPED,"\r\n\r\n"
           LET sr1.l_memo = sr1.l_memo,cl_getmsg("ais-00184",g_lang) CLIPPED,"\r\n\r\n"
           LET sr1.l_memo = sr1.l_memo,cl_getmsg("ais-00185",g_lang) CLIPPED
           PRINTX sr1.l_memo

           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
                 sr1.isafent CLIPPED ,"'", " AND  ooff002 = '", sr1.isafcomp CLIPPED ,"' AND  ooff003 = '", sr1.isaf003 CLIPPED ,"'"
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr350_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aisr350_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aisr350_g01_subrep04
           DECLARE aisr350_g01_repcur04 CURSOR FROM g_sql
           FOREACH aisr350_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr350_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aisr350_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aisr350_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
 
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_group
 
           #add-point:rep.a_group.l_group.before name="rep.a_group.l_group.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_group.after name="rep.a_group.l_group.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isafdocdt
 
           #add-point:rep.a_group.isafdocdt.before name="rep.a_group.isafdocdt.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.isafdocdt.after name="rep.a_group.isafdocdt.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isaf100
 
           #add-point:rep.a_group.isaf100.before name="rep.a_group.isaf100.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.isaf100.after name="rep.a_group.isaf100.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
 
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aisr350_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisr350_g01_subrep01(sr2)
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
PRIVATE REPORT aisr350_g01_subrep02(sr2)
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
PRIVATE REPORT aisr350_g01_subrep03(sr2)
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
PRIVATE REPORT aisr350_g01_subrep04(sr2)
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
 
{<section id="aisr350_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aisr350_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 期初餘額
# Memo...........:
# Usage..........: CALL aisr350_g01_subrep05(sr5)

# Date & Author..: 2015/01/16 By Reanna
# Modify.........:
################################################################################
PRIVATE REPORT aisr350_g01_subrep05(sr5)
DEFINE sr5     sr5_r

    FORMAT
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

################################################################################
# Descriptions...: 收款單
# Memo...........:
# Usage..........: CALL aisr350_g01_subrep06(sr6)

# Date & Author..: 2015/01/16 By Reanna
# Modify.........:
################################################################################
PRIVATE REPORT aisr350_g01_subrep06(sr6)
DEFINE sr6     sr6_r
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
END REPORT

################################################################################
# Descriptions...: 合計
# Memo...........:
# Usage..........: CALL aisr350_g01_subrep07(sr7)

# Date & Author..: 2015/01/16 By Reanna
# Modify.........:
################################################################################
PRIVATE REPORT aisr350_g01_subrep07(sr7)
DEFINE sr7     sr7_r
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr7.*
END REPORT

################################################################################
# Descriptions...: 本期應收款
# Memo...........:
# Usage..........: CALL aisr350_g01_subrep08(sr8)

# Date & Author..: 2015/01/16 By Reanna
# Modify.........:
################################################################################
PRIVATE REPORT aisr350_g01_subrep08(sr8)
DEFINE sr8     sr8_r
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr8.*
END REPORT

################################################################################
# Descriptions...: 增加發票歷程檔列印
# Memo...........: #160914-00001#1
# Usage..........: CALL aisr350_g01_subrep09(sr9)
# Date & Author..: 161109 By 06821
# Modify.........:
################################################################################
PRIVATE REPORT aisr350_g01_subrep09(sr9)
DEFINE sr9 sr9_r
DEFINE l_isat113_sum  LIKE isat_t.isat113
DEFINE l_isat114_sum  LIKE isat_t.isat114
DEFINE l_isat115_sum  LIKE isat_t.isat115
DEFINE l_isat003_show LIKE type_t.chr1
DEFINE l_isat023_show LIKE type_t.chr1

   ORDER EXTERNAL BY sr9.l_order
   
   FORMAT
      ON EVERY ROW      
         IF sr9.l_isat003 = 1 THEN
            LET l_isat003_show = "N"
         ELSE
            LET l_isat003_show = "Y"
         END IF  
         
         IF cl_null(sr9.isat023) THEN
            LET l_isat023_show = "N"
         ELSE
            LET l_isat023_show = "Y"
         END IF  
         
         PRINTX l_isat023_show
         PRINTX l_isat003_show                               
         PRINTX sr9.*
         PRINTX g_grNumFmt.*
         
      AFTER GROUP OF sr9.l_order      
         LET l_isat113_sum = GROUP SUM(sr9.isat113)
         LET l_isat114_sum = GROUP SUM(sr9.isat114)
         LET l_isat115_sum = GROUP SUM(sr9.isat115)     
         
         PRINTX l_isat113_sum
         PRINTX l_isat114_sum
         PRINTX l_isat115_sum
         
END REPORT

 
{</section>}
 
