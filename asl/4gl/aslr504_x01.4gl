#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr504_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-12-29 19:08:28), PR版次:0007(2016-12-30 17:26:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr504_x01
#+ Description: ...
#+ Creator....: 06814(2016-11-04 14:17:21)
#+ Modifier...: 06840 -SD/PR- 06840
 
{</section>}
 
{<section id="aslr504_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#161109-00078#13 20161118 By 06814              inbp_t已裝數量有可能為0,關聯時條件增加:inbp009 <> 0   
#161017-00051#17 20161201 By 06814              前端条件日期，改为拣货日期，
#                                               前端条件增加两个日期区间条件：装箱日期、出库日期；
#                                               报表里字段：装箱日期名称改为拣货日期，
#                                               出货日期名称改为装箱日期，
#                                               增加栏位‘出库日期’，带出库单aint512的的拨出审核日期或adbt540的过账日期
#161220-00037#7  20161222 By 06814              1.調整關聯的條件:配送调拨单身档(indd_t),分销出库单身档(xmdl_t)
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       bdat1 LIKE type_t.dat,         #bdat1 
       edat1 LIKE type_t.dat,         #edat1 
       bdat2 LIKE type_t.dat,         #bdat2 
       edat2 LIKE type_t.dat          #edat2
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aslr504_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr504_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdat1  bdat1 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edat1  edat1 
DEFINE  p_arg4 LIKE type_t.dat         #tm.bdat2  bdat2 
DEFINE  p_arg5 LIKE type_t.dat         #tm.edat2  edat2
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdat1 = p_arg2
   LET tm.edat1 = p_arg3
   LET tm.bdat2 = p_arg4
   LET tm.edat2 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aslr504_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr504_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr504_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr504_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr504_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr504_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr504_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr504_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inbmdocno.inbm_t.inbmdocno,inbmdocdt.inbm_t.inbmdocdt,l_indcdocno.indc_t.indcdocno,l_indcdocdt.indc_t.indcdocdt,l_indc022.indc_t.indc022,inbm001.inbm_t.inbm001,l_inbm001_desc.type_t.chr500,inbmstus.inbm_t.inbmstus,l_inbmstus_desc.type_t.chr500,l_indcstus.indc_t.indcstus,l_indcstus_desc.type_t.chr500,inbm007.inbm_t.inbm007,l_inbm003_desc.type_t.chr500,inbp008.inbp_t.inbp008,inbp009.inbp_t.inbp009,l_pmcz065.pmcz_t.pmcz065,l_count_imaa116.imaa_t.imaa116,inbm008.inbm_t.inbm008,l_inbm008_desc.type_t.chr500,inbp011.inbp_t.inbp011,inbp012.inbp_t.inbp012,imaa_t_imaa154.imaa_t.imaa154,imaa_t_imaa133.imaa_t.imaa133,l_imaa133_desc.type_t.chr500,rtax_t_rtax006.rtax_t.rtax006,l_rtax006_desc.type_t.chr500,inbp005.inbp_t.inbp005,imaal_t_imaal003.imaal_t.imaal003,inbp006.inbp_t.inbp006,inaml_t_inaml004.inaml_t.inaml004,inbp004.inbp_t.inbp004,l_imaa116_prfl011.imaa_t.imaa116,l_prfm021.type_t.chr500,l_count_imaa116_1.imaa_t.imaa116,l_count_imaa116_2.imaa_t.imaa116,inbmcnfid.inbm_t.inbmcnfid,inbmcnfdt.inbm_t.inbmcnfdt,l_ooag011.type_t.chr100" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr504_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr504_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="aslr504_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr504_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_select_1      STRING
DEFINE g_from_1        STRING
DEFINE g_where_1       STRING
DEFINE g_order         STRING
#161017-00051#17 20161201 add by beckxie---S
DEFINE l_indcdocdt_wc1 STRING   #indcdocdt 裝箱開始&結束日的條件
DEFINE l_xmdkdocdt_wc1 STRING   #xmdkdocdt 裝箱開始&結束日的條件
DEFINE l_indc022_wc2   STRING   #indc022   出庫開始&結束日的條件
DEFINE l_xmdk001_wc2   STRING   #xmdk001   出庫開始&結束日的條件
DEFINE l_wc_aint512    STRING   #aint512的條件
DEFINE l_wc_adbt540    STRING   #adbt540的條件
#161017-00051#17 20161201 add by beckxie---E
DEFINE g_select_2      STRING  #161228-00060#3 20161229 add by cheng
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #161017-00051#17 20161201 add by beckxie---S
   #組裝箱開始日結束日的wc
   IF NOT cl_null(tm.bdat1) AND NOT cl_null(tm.edat1) THEN
      LET l_indcdocdt_wc1 = " AND indcdocdt BETWEEN '",tm.bdat1,"' AND '",tm.edat1,"' "
      LET l_xmdkdocdt_wc1 = " AND xmdkdocdt BETWEEN '",tm.bdat1,"' AND '",tm.edat1,"' "
   ELSE 
      IF NOT cl_null(tm.bdat1) THEN
         LET l_indcdocdt_wc1 = " AND indcdocdt >= '",tm.bdat1,"' "
         LET l_xmdkdocdt_wc1 = " AND xmdkdocdt >= '",tm.bdat1,"' "
      END IF
      IF NOT cl_null(tm.edat1) THEN
         LET l_indcdocdt_wc1 = " AND indcdocdt <= '",tm.edat1,"' "
         LET l_xmdkdocdt_wc1 = " AND xmdkdocdt <= '",tm.edat1,"' "
      END IF
   END IF
   #組出庫開始日結束日的wc
   IF NOT cl_null(tm.bdat2) AND NOT cl_null(tm.edat2) THEN
      LET l_indc022_wc2 = " AND indc022 BETWEEN '",tm.bdat2,"' AND '",tm.edat2,"' "
      LET l_xmdk001_wc2 = " AND xmdk001 BETWEEN '",tm.bdat2,"' AND '",tm.edat2,"' "
   ELSE 
      IF NOT cl_null(tm.bdat2) THEN
         LET l_indc022_wc2 = " AND indc022 >= '",tm.bdat2,"' "
         LET l_xmdk001_wc2 = " AND xmdk001 >= '",tm.bdat2,"' "
      END IF
      IF NOT cl_null(tm.edat2) THEN
         LET l_indc022_wc2 = " AND indc022 <= '",tm.edat2,"' "
         LET l_xmdk001_wc2 = " AND xmdk001 <= '",tm.edat2,"' "
      END IF
   END IF
   IF cl_null(l_indcdocdt_wc1) THEN
      LET l_indcdocdt_wc1 = " AND 1=1 "
   END IF
   IF cl_null(l_xmdkdocdt_wc1) THEN
      LET l_xmdkdocdt_wc1 = " AND 1=1 "
   END IF
   IF cl_null(l_indc022_wc2) THEN
      LET l_indc022_wc2 = " AND 1=1 "
   END IF
   IF cl_null(l_xmdk001_wc2) THEN
      LET l_xmdk001_wc2 = " AND 1=1 "
   END IF
   LET l_wc_aint512 = tm.wc,l_indcdocdt_wc1,l_indc022_wc2
   LET l_wc_adbt540 = tm.wc,l_xmdkdocdt_wc1,l_xmdk001_wc2
   DISPLAY "l_wc_aint512:",l_wc_aint512
   DISPLAY "l_wc_adbt540:",l_wc_adbt540
   #161017-00051#17 20161201 add by beckxie---E
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #LET g_select = " SELECT DISTINCT inbmdocno,inbmdocdt,indcdocno,indcdocdt,inbm001,",          #161017-00051#17 20161201 mark by beckxie
   #LET g_select = " SELECT DISTINCT inbmdocno,inbmdocdt,indcdocno,indcdocdt,indc022,inbm001,",   #161017-00051#17 20161201 add by beckxie   #161228-00060#3 20161229 mark by cheng
    LET g_select = " SELECT DISTINCT inbmdocno,inbmdocdt,indcdocno l_indcdocno,indcdocdt l_indcdocdt,indc022 l_indc022,inbm001,",     #161228-00060#3 20161229 add by cheng
                  "                        (SELECT ooefl003 ",
                  "                           FROM ooefl_t ",
                  "                          WHERE ooeflent = ",g_enterprise,
                  "                            AND ooefl001 = inbm001 ",
                  "                            AND ooefl002 = '",g_dlang,"') inbm001_desc, ", #需求對象名稱
                  "                inbmstus, ",
                  #装箱单状态说明：未审核（装箱单未审核）、已确认(出库单据已审核)、已完成(出库单据已过账)
                  "                CASE WHEN inbmstus='N' THEN 'N'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'N' AND gzcbl003 ='",g_dlang,"')) ",
   #               "                     WHEN indcstus NOT IN('O','P','C') THEN 'Y'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'Y' AND gzcbl003 ='",g_dlang,"')) ",        #161228-00060#3 20161230 mark by cheng
   #               "                     WHEN indcstus IN('O','P','C') THEN 'F'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'F' AND gzcbl003 ='",g_dlang,"')) END l_inbmstus_desc, ",     #161228-00060#3 20161230 mark by cheng
                  "                     WHEN inbmstus NOT IN('O','P','C') THEN 'Y'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'Y' AND gzcbl003 ='",g_dlang,"')) ",      #161228-00060#3 20161230 add by cheng
                  "                     WHEN inbmstus IN('O','P','C') THEN 'F'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'F' AND gzcbl003 ='",g_dlang,"')) END l_inbmstus_desc, ",    #161228-00060#3 20161230 add by cheng
   #               "                indcstus, ",      #161228-00060#3 20161229 mark by cheng
                  "                indcstus l_indcstus, ",    #161228-00060#3 20161229 add by cheng 
                  #出库单状态：已确认(出库单据已生成未审核)、财务已审核（出库单据已审核）、已完成(出库单已过账)
                  "                CASE WHEN indcstus='N' THEN 'N'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6981' AND gzcbl002 = 'N' AND gzcbl003 ='",g_dlang,"')) ",
                  "                     WHEN indcstus='Y' THEN 'Y'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6981' AND gzcbl002 = 'Y' AND gzcbl003 ='",g_dlang,"')) ",
                  "                     WHEN indcstus IN('O','P','C') THEN 'F'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6981' AND gzcbl002 = 'F' AND gzcbl003 ='",g_dlang,"')) END l_indcstus_desc, ",
                  "                 inbm007,inbm003,",
                  "                CASE WHEN inbm003 IS NOT NULL THEN ",
                  "                     trim(inbm003)||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6977' AND gzcbl002 = inbm003 AND gzcbl003 ='",g_dlang,"')) END inbm003_desc, ",
                  "                 inbp008,inbp009, ",
                  "                 (SELECT pmcz065 ",
                  "                    FROM pmcz_t ",
                  "                   WHERE pmczent = inbpent  ",
                  "                     AND pmcz001 = inbp011  ",
                  "                     AND pmcz002 = inbp012 ) pmcz065, ", #pmcz065出貨量
                  "                 COALESCE(imaa116,0)*COALESCE(inbp009,0) l_count_imaa116, ", #裝箱吊牌金額
                  "                 inbm008, ",
                  "                CASE WHEN inbm008 IS NOT NULL THEN ",
                  "                     trim(inbm008)||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6968' AND gzcbl002 = inbm008 AND gzcbl003 ='",g_dlang,"')) END inbm008_desc,",
                  "                 inbp011,inbp012,imaa_t.imaa154,",
                  #161212-00045#1 20161212 mark by beckxie---S
                  #"                 imaa_t.imaa155, ",
                  #"                CASE WHEN imaa_t.imaa155 IS NOT NULL THEN ",
                  #"                     trim(imaa_t.imaa155)||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6940' AND gzcbl002 = imaa_t.imaa155 AND gzcbl003 ='",g_dlang,"')) END imaa155_desc, ",
                  #161212-00045#1 20161212 mark by beckxie---E
                  #161212-00045#1 20161212 add by beckxie---S
                  "                 imaa_t.imaa133, ",
                  "                CASE WHEN imaa_t.imaa133 IS NOT NULL THEN ",
   #               "                     trim(imaa_t.imaa133)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocql001 = '2007' AND oocql002= imaa_t.imaa133 AND oocql003 ='",g_dlang,"')) END imaa133_desc, ", #161228-00060#3 20161230 mark by cheng
                  "                     trim(imaa_t.imaa133)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocql001 = '2007' AND oocql002= imaa_t.imaa133 AND oocql003 ='",g_dlang,"' AND oocqlent = '",g_enterprise,"')) END imaa133_desc, ",   #161228-00060#3 20161230 add by cheng
                  #161212-00045#1 20161212 add by beckxie---E
                  "                 rtax006,",
                  "                CASE WHEN rtax006 IS NOT NULL THEN ",
                  "                     trim(rtax006)||'.'||trim((SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = rtaxent AND rtaxl001 = rtax006 AND rtaxl002 ='",g_dlang,"')) END rtax006_desc, ",
                  "                 inbp005,imaal_t.imaal003,inbp006,inaml_t.inaml004, ",
                  "                 inbp004, ",
                  "                  COALESCE(imaa116,0) l_imaa116_prfl011 , ", #出貨價
                  "                  100 ||'%' l_prfm021, ", #折扣
                  "                 COALESCE(imaa116,0)*COALESCE(inbp009,0) l_count_imaa116_1, ", #出貨吊牌金額[imaa116*已装箱量]
                  "                 COALESCE(imaa116,0)*COALESCE(inbp009,0) l_count_imaa116_2, " ,  #裝箱折後金額 [出货价*已装箱量]
                  #161228-00060#3 20161229 add by cheng---S
                  "                 inbmcnfid,inbmcnfdt, '',",
                  "          ROW_NUMBER() OVER (PARTITION BY inbmdocno ORDER BY inbmdocno,indcdocno) l_rownum "  
                  #161228-00060#3 20161229 add by cheng---E

   #LET g_select_1 = "SELECT DISTINCT inbmdocno,inbmdocdt,xmdkdocno,xmdkdocdt,inbm001, ",          #161017-00051#17 20161201 mark by beckxie
   #LET g_select_1 = "SELECT DISTINCT inbmdocno,inbmdocdt,xmdkdocno,xmdkdocdt,xmdk001,inbm001, ",   #161017-00051#17 20161201 add by beckxie  #161228-00060#3 20161229 mark by cheng
    LET g_select_1 = "SELECT DISTINCT inbmdocno,inbmdocdt,xmdkdocno l_indcdocno,xmdkdocdt l_indcdocdt,xmdk001 l_indc022,inbm001, ",       #161228-00060#3 20161229 add by cheng         
                    "                (SELECT pmaal004  ",
                    "                   FROM pmaal_t  ",
                    "                  WHERE pmaalent = ",g_enterprise,
                    "                    AND pmaal001 = inbm001 ",
                    "                    AND pmaal002 ='",g_dlang,"') inbm001_desc,", #需求對象名稱
                    "                inbmstus,",
                    #装箱单状态说明：未审核（装箱单未审核）、已确认(出库单据已审核)、已完成(出库单据已过账)
                    "                CASE WHEN inbmstus='N' THEN 'N'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'N' AND gzcbl003 ='",g_dlang,"')) ",
   #                 "                     WHEN xmdkstus<>'S' THEN 'Y'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'Y' AND gzcbl003 ='",g_dlang,"')) ",     #161228-00060#3 20161230 mark by cheng
   #                 "                     WHEN xmdkstus='S' THEN 'F'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'F' AND gzcbl003 ='",g_dlang,"')) END l_inbmstus_desc, ",   #161228-00060#3 20161230 mark by cheng
                    "                     WHEN inbmstus<>'S' THEN 'Y'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'Y' AND gzcbl003 ='",g_dlang,"')) ",     #161228-00060#3 20161230 add by cheng
                    "                     WHEN inbmstus='S' THEN 'F'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6979' AND gzcbl002 = 'F' AND gzcbl003 ='",g_dlang,"')) END l_inbmstus_desc, ",                      #161228-00060#3 20161230 add by cheng
   #                 "                xmdkstus ,",       #161228-00060#3 20161229 mark by cheng
                    "                xmdkstus l_indcstus,",       #161228-00060#3 20161229 add by cheng
                    #出库单状态：已确认(出库单据已生成未审核)、财务已审核（出库单据已审核）、已完成(出库单已过账)
                    "                CASE WHEN xmdkstus='N' THEN 'N'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6981' AND gzcbl002 = 'N' AND gzcbl003 ='",g_dlang,"')) ",
                    "                     WHEN xmdkstus='Y' THEN 'Y'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6981' AND gzcbl002 = 'Y' AND gzcbl003 ='",g_dlang,"')) ",
                    "                     WHEN xmdkstus='S' THEN 'F'||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6981' AND gzcbl002 = 'F' AND gzcbl003 ='",g_dlang,"')) END l_indcstus_desc, ",
                    "                inbm007,inbm003,",
                    "                CASE WHEN inbm003 IS NOT NULL THEN ",
                    "                     trim(inbm003)||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6977' AND gzcbl002 = inbm003 AND gzcbl003 ='",g_dlang,"')) END inbm003_desc,",
                    "                inbp008,inbp009, ",
                    "                (SELECT pmcz065",
                    "                   FROM pmcz_t",
                    "                  WHERE pmczent = inbpent ",
                    "                    AND pmcz001 = inbp011 ",
                    "                    AND pmcz002 = inbp012 ) pmcz065, ", #pmcz065出貨量
                    "                COALESCE(imaa116,0)*COALESCE(inbp009,0) l_count_imaa116, ", #裝箱吊牌金額
                    "                inbm008,",
                    "                CASE WHEN inbm008 IS NOT NULL THEN ",
                    "                     trim(inbm008)||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6968' AND gzcbl002 = inbm008 AND gzcbl003 ='",g_dlang,"')) END inbm008_desc,",
                    "                inbp011,inbp012,imaa_t.imaa154,",
                    #161212-00045#1 20161212 mark by beckxie---S
                    #"                 imaa_t.imaa155, ",
                    #"                CASE WHEN imaa_t.imaa155 IS NOT NULL THEN ",
                    #"                     trim(imaa_t.imaa155)||'.'||trim((SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '6940' AND gzcbl002 = imaa_t.imaa155 AND gzcbl003 ='",g_dlang,"')) END imaa155_desc, ",
                    #161212-00045#1 20161212 mark by beckxie---E
                    #161212-00045#1 20161212 add by beckxie---S
                    "                 imaa_t.imaa133, ",
                    "                CASE WHEN imaa_t.imaa133 IS NOT NULL THEN ",
  #                  "                     trim(imaa_t.imaa133)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocql001 = '2007' AND oocql002= imaa_t.imaa133 AND oocql003 ='",g_dlang,"' )) END imaa133_desc, ",    #161228-00060#3 20161230 mark by cheng
                    "                     trim(imaa_t.imaa133)||'.'||trim((SELECT oocql004 FROM oocql_t WHERE oocql001 = '2007' AND oocql002= imaa_t.imaa133 AND oocql003 ='",g_dlang,"' AND oocqlent = '",g_enterprise,"')) END imaa133_desc, ",    #161228-00060#3 20161230 add by cheng
                    #161212-00045#1 20161212 add by beckxie---E
                    "                rtax006,",
                    "                CASE WHEN rtax006 IS NOT NULL THEN ",
                    "                     trim(rtax006)||'.'||trim((SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = rtaxent AND rtaxl001 = rtax006 AND rtaxl002 ='",g_dlang,"')) END rtax006_desc, ",
                    "                inbp005,imaal_t.imaal003,inbp006,inaml_t.inaml004, ",
                    "                inbp004, ",
                    "                COALESCE(((SELECT prfm011 FROM (SELECT prfm011,ROW_NUMBER() OVER(ORDER BY prfm019 DESC) AS rank1 ",
                    "                                                  FROM prfm_t ",
                    "                                                 WHERE prfment = inbpent AND prfmsite ='ALL' ",
                    "                                                   AND prfm001 = '2' AND prfm002 = inbm001 ",
                    "                                                   AND prfm003 = inbp005 AND prfm004 = '1' ",
                    "                                                   AND prfm005 = xmdk016 AND prfm006 = xmdk012 ",
                    "                                                   AND ((prfm007 <= xmdkdocdt OR prfm007 IS NULL) ",
                    "                                                   AND  (prfm008 >= xmdkdocdt OR prfm008 IS NULL)) ",
                    "                                                   AND prfm009 = inbp007 ) ",
                    "                                         WHERE rank1=1)),0) l_imaa116_prfl011, ",   #出貨價
                    "                COALESCE(((SELECT prfm021 FROM (SELECT prfm021,ROW_NUMBER() OVER(ORDER BY prfm019 DESC) AS rank1 ",
                    "                                                  FROM prfm_t ",
                    "                                                 WHERE prfment = inbpent AND prfmsite ='ALL' ",
                    "                                                   AND prfm001 = '2' AND prfm002 = inbm001 ",
                    "                                                   AND prfm003 = inbp005 AND prfm004 = '1' ",
                    "                                                   AND prfm005 = xmdk016 AND prfm006 = xmdk012 ",
                    "                                                   AND ((prfm007 <= xmdkdocdt OR prfm007 IS NULL) ",
                    "                                                   AND  (prfm008 >= xmdkdocdt OR prfm008 IS NULL)) ",
                    "                                                   AND prfm009 = inbp007 ) ",
                    "                                         WHERE rank1=1)),0) ||'%' l_prfm021, ",#折扣
                    "                COALESCE(imaa116,0)*COALESCE(inbp009,0) l_count_imaa116_1 , ", #出貨吊牌金額[imaa116*已装箱量]
                    "                COALESCE(((SELECT prfm011 FROM (SELECT prfm011,ROW_NUMBER() OVER(ORDER BY prfm019 DESC) AS rank1 ",
                    "                                                  FROM prfm_t ",
                    "                                                 WHERE prfment = inbpent AND prfmsite ='ALL' ",
                    "                                                   AND prfm001 = '2' AND prfm002 = inbm001 ",
                    "                                                   AND prfm003 = inbp005 AND prfm004 = '1' ",
                    "                                                   AND prfm005 = xmdk016 AND prfm006 = xmdk012 ",
                    "                                                   AND ((prfm007 <= xmdkdocdt OR prfm007 IS NULL) ",
                    "                                                   AND  (prfm008 >= xmdkdocdt OR prfm008 IS NULL)) ",
                    "                                                   AND prfm009 = inbp007 ) ",
                    "                                         WHERE rank1=1)),0)*COALESCE(inbp009,0) l_count_imaa116_2 , " ,#裝箱折後金額 [出货价*已装箱量]
                    #161228-00060#3 20161229 add by cheng---S
                    "                 inbmcnfid,inbmcnfdt,'', ",
                    "                ROW_NUMBER() OVER (PARTITION BY inbmdocno ORDER BY inbmdocno,xmdkdocno) l_rownum "  
                    #161228-00060#3 20161229 add by cheng---E
      #161228-00060#3 20161229 add by cheng---S
   LET g_select_2 = "SELECT inbmdocno,inbmdocdt,l_indcdocno,l_indcdocdt,l_indc022,inbm001,inbm001_desc,inbmstus,l_inbmstus_desc,l_indcstus,l_indcstus_desc,",
                  "       CASE WHEN l_rownum = 1 THEN inbm007 ",
                  "            WHEN (l_rownum <>'1' AND inbm007 IS NOT NULL) THEN '*************' END inbm007, ",
                  "       inbm003,inbm003_desc,inbp008,inbp009,pmcz065,l_count_imaa116,inbm008,inbm008_desc,inbp011,inbp012,imaa154,",
                  "       imaa133, imaa133_desc,rtax006,rtax006_desc,inbp005,imaal003,inbp006,inaml004,inbp004,",
                  "       l_imaa116_prfl011 ,l_prfm021,l_count_imaa116_1,l_count_imaa116_2,inbmcnfid,inbmcnfdt,''"
   #161228-00060#3 20161229 add by cheng---E
#   #end add-point
#   LET g_select = " SELECT inbmdocno,inbmdocdt,NULL,NULL,NULL,inbm001,NULL,inbmstus,NULL,NULL,NULL,inbm007, 
#       inbm003,NULL,inbp008,inbp009,NULL,NULL,inbm008,NULL,inbp011,inbp012,imaa_t.imaa154,imaa_t.imaa133, 
#       NULL,rtax_t.rtax006,NULL,inbp005,imaal_t.imaal003,inbp006,inaml_t.inaml004,inbp004,NULL,NULL, 
#       NULL,NULL,inbmcnfid,inbmcnfdt,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM inbm_t,inbp_t ",
                "      LEFT JOIN imaa_t  ON imaaent  = inbpent AND imaa001  = inbp005 ",
                "      LEFT JOIN rtax_t  ON rtaxent  = imaaent AND rtax001  = imaa009 ", 
                "      LEFT JOIN imaal_t ON imaalent = inbpent AND imaal001 = inbp005 AND imaal002 = '",g_dlang,"' ",
                "      LEFT JOIN inaml_t ON inamlent = inbpent AND inaml001 = inbp005 AND inaml002 = inbp006 AND inaml003 = '",g_dlang,"' ",
                #"      LEFT JOIN indd_t  ON inddent  = inbpent AND indd047  = inbp011 AND indd048 = inbp012 ",    #161220-00037#6 20161222 mark by beckxie
                "      LEFT JOIN indd_t  ON inddent  = inbpent AND indd049  = inbpdocno AND indd050 = inbpseq ",   #161220-00037#6 20161222  add by beckxie
                "      LEFT JOIN indc_t  ON indcent  = inddent AND indcdocno= indddocno "
   LET g_from_1 = "FROM inbm_t,inbp_t ",
                  "     LEFT JOIN imaa_t  ON imaaent  = inbpent AND imaa001  = inbp005 ",
                  "     LEFT JOIN rtax_t  ON rtaxent  = imaaent AND rtax001  = imaa009 ", 
                  "     LEFT JOIN imaal_t ON imaalent = inbpent AND imaal001 = inbp005 AND imaal002 = '",g_dlang,"' ",
                  "     LEFT JOIN inaml_t ON inamlent = inbpent AND inaml001 = inbp005 AND inaml002 = inbp006 AND inaml003 = '",g_dlang,"' ",
                  #"     LEFT JOIN xmdl_t  ON inbpent  = xmdlent AND inbp011  = xmdl003 AND inbp012 = xmdl004  ",   #161220-00037#6 20161222 mark by beckxie
                  "     LEFT JOIN xmdl_t  ON inbpent  = xmdlent AND inbpdocno  = xmdl097 AND inbpseq = xmdl098  ",   #161220-00037#6 20161222  add by beckxie
                  "     LEFT JOIN xmdk_t  ON xmdkent  = xmdlent AND xmdkdocno= xmdldocno "
#   #end add-point
#    LET g_from = " FROM inbm_t,inbp_t,imaa_t,imaal_t,ooefl_t,pmaal_t,indc_t,indd_t,inaml_t,rtax_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE inbment = inbpent AND inbmdocno = inbpdocno ", #inbm_t,inbp_t
                 "   AND inbment = ",g_enterprise, 
                 "   AND inbm003 = '4' ",
                 "   AND inbm008 = '1' ",
                 #"   AND indc000 <>'3' ",   #161220-00037#6 20161222 mark by beckxie
                 "   AND indc199 = '2' ",    #161220-00037#6 20161222 add by beckxie
                 "   AND inbp009 <> 0 ",   #161109-00078#13 20161118 add by beckxie
                 #"   AND " ,tm.wc CLIPPED         #161017-00051#17 20161201 mark by beckxie
                 "   AND " ,l_wc_aint512 CLIPPED   #161017-00051#17 20161201 add by beckxie
   LET g_where_1 = " WHERE inbment = inbpent AND inbmdocno = inbpdocno ", #inbm_t,inbp_t
                   "   AND inbment = ",g_enterprise, 
                   "   AND inbm003 = '4' ",
                   "   AND inbm008 = '2' ",
                   "   AND inbp009 <> 0 ",   #161109-00078#13 20161118 add by beckxie
                   #"   AND " ,tm.wc CLIPPED         #161017-00051#17 20161201 mark by beckxie
                   "   AND " ,l_wc_adbt540 CLIPPED   #161017-00051#17 20161201 add by beckxie
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY inbmdocno,inbmdocdt "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_where = g_where ,cl_sql_add_filter("inbm_t")   #資料過濾功能
   LET g_sql = g_select_2, " FROM (",g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," UNION (",g_select_1 CLIPPED ," ",g_from_1 CLIPPED ," ",g_where_1 CLIPPED ," ) ",g_order,")"
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("inbm_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql:",g_sql 
   #end add-point
   PREPARE aslr504_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr504_x01_curs CURSOR FOR aslr504_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr504_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr504_x01_ins_data()
DEFINE sr RECORD 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbmdocdt LIKE inbm_t.inbmdocdt, 
   l_indcdocno LIKE indc_t.indcdocno, 
   l_indcdocdt LIKE indc_t.indcdocdt, 
   l_indc022 LIKE indc_t.indc022, 
   inbm001 LIKE inbm_t.inbm001, 
   l_inbm001_desc LIKE type_t.chr500, 
   inbmstus LIKE inbm_t.inbmstus, 
   l_inbmstus_desc LIKE type_t.chr500, 
   l_indcstus LIKE indc_t.indcstus, 
   l_indcstus_desc LIKE type_t.chr500, 
   inbm007 LIKE inbm_t.inbm007, 
   inbm003 LIKE inbm_t.inbm003, 
   l_inbm003_desc LIKE type_t.chr500, 
   inbp008 LIKE inbp_t.inbp008, 
   inbp009 LIKE inbp_t.inbp009, 
   l_pmcz065 LIKE pmcz_t.pmcz065, 
   l_count_imaa116 LIKE imaa_t.imaa116, 
   inbm008 LIKE inbm_t.inbm008, 
   l_inbm008_desc LIKE type_t.chr500, 
   inbp011 LIKE inbp_t.inbp011, 
   inbp012 LIKE inbp_t.inbp012, 
   imaa_t_imaa154 LIKE imaa_t.imaa154, 
   imaa_t_imaa133 LIKE imaa_t.imaa133, 
   l_imaa133_desc LIKE type_t.chr500, 
   rtax_t_rtax006 LIKE rtax_t.rtax006, 
   l_rtax006_desc LIKE type_t.chr500, 
   inbp005 LIKE inbp_t.inbp005, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   inbp006 LIKE inbp_t.inbp006, 
   inaml_t_inaml004 LIKE inaml_t.inaml004, 
   inbp004 LIKE inbp_t.inbp004, 
   l_imaa116_prfl011 LIKE imaa_t.imaa116, 
   l_prfm021 LIKE type_t.chr500, 
   l_count_imaa116_1 LIKE imaa_t.imaa116, 
   l_count_imaa116_2 LIKE imaa_t.imaa116, 
   inbmcnfid LIKE inbm_t.inbmcnfid, 
   inbmcnfdt LIKE inbm_t.inbmcnfdt, 
   l_ooag011 LIKE type_t.chr100
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr504_x01_curs INTO sr.*                               
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
       SELECT DISTINCT ooag011 INTO sr.l_ooag011  FROM  ooag_t    WHERE  ooagent = g_enterprise and ooag001 = sr.inbmcnfid
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
 
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inbmdocno,sr.inbmdocdt,sr.l_indcdocno,sr.l_indcdocdt,sr.l_indc022,sr.inbm001,sr.l_inbm001_desc,sr.inbmstus,sr.l_inbmstus_desc,sr.l_indcstus,sr.l_indcstus_desc,sr.inbm007,sr.l_inbm003_desc,sr.inbp008,sr.inbp009,sr.l_pmcz065,sr.l_count_imaa116,sr.inbm008,sr.l_inbm008_desc,sr.inbp011,sr.inbp012,sr.imaa_t_imaa154,sr.imaa_t_imaa133,sr.l_imaa133_desc,sr.rtax_t_rtax006,sr.l_rtax006_desc,sr.inbp005,sr.imaal_t_imaal003,sr.inbp006,sr.inaml_t_inaml004,sr.inbp004,sr.l_imaa116_prfl011,sr.l_prfm021,sr.l_count_imaa116_1,sr.l_count_imaa116_2,sr.inbmcnfid,sr.inbmcnfdt,sr.l_ooag011
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr504_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aslr504_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr504_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="aslr504_x01.other_function" readonly="Y" >}

 
{</section>}
 
