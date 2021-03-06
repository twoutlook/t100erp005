#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr432_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-12-21 18:30:58), PR版次:0003(2016-12-22 15:07:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: apmr432_x01
#+ Description: ...
#+ Creator....: 01996(2015-08-03 16:00:56)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="apmr432_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#151106-00004#14 By Dorislai 改善效能，將ins_data中說明的資料串進去ins_data()的l_sql中
#161207-00033#24  2016/12/22  By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where codition 
       wc2 STRING                   #where codition2
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr432_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr432_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where codition 
DEFINE  p_arg2 STRING                  #tm.wc2  where codition2
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.wc2 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr432_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr432_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr432_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr432_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr432_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr432_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr432_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr432_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmevdocno.pmev_t.pmevdocno,pmexseq.pmex_t.pmexseq,l_pmdl002.pmdl_t.pmdl002,l_pmdl002_desc.type_t.chr1000,l_pmdl003.pmdl_t.pmdl003,l_pmdl003_desc.type_t.chr1000,pmev003.pmev_t.pmev003,l_pmev003_desc.type_t.chr1000,l_pmdsdocno.pmds_t.pmdsdocno,l_pmdtseq.pmdt_t.pmdtseq,l_pmds007.pmds_t.pmds007,l_pmds007_desc.type_t.chr1000,l_pmds001.pmds_t.pmds001,l_imaa009.imaa_t.imaa009,l_imaa009_desc.type_t.chr1000,l_imaf141.imaf_t.imaf141,l_imaf141_desc.type_t.chr1000,l_pmdt006.pmdt_t.pmdt006,l_pmdt006_desc.type_t.chr1000,l_pmdt006_desc2.type_t.chr1000,l_pmdt007.pmdt_t.pmdt007,l_pmdt007_desc.type_t.chr1000,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr1000,l_imaa127_oocql004.type_t.chr1000,l_pmdt024.pmdt_t.pmdt024,l_pmdt023.pmdt_t.pmdt023,l_pmdt036.pmdt_t.pmdt036,l_pmdt038.pmdt_t.pmdt038,l_pmdt039.pmdt_t.pmdt039,l_pmdt047.pmdt_t.pmdt047" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr432_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr432_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apmr432_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr432_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT pmevdocno,pmexseq,'','','','',pmev003,'','','','','','','','','','','','', 
       '','','','','','','','','','','','',pmevent,pmevsite,pmevstus,pmev004,pmev005,pmev006,pmev008, 
       pmev009,pmev010,pmev011,pmev012,pmev013,pmev014,pmev015,pmev016,pmev017,pmev018,pmex001,pmex002" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM pmev_t LEFT OUTER JOIN pmex_t ON pmexent = pmevent AND pmexdocno = pmevdocno"
#   #end add-point
#    LET g_from = " FROM pmev_t,pmex_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmev_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY g_sql
   #end add-point
   PREPARE apmr432_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr432_x01_curs CURSOR FOR apmr432_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr432_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr432_x01_ins_data()
DEFINE sr RECORD 
   pmevdocno LIKE pmev_t.pmevdocno, 
   pmexseq LIKE pmex_t.pmexseq, 
   l_pmdl002 LIKE pmdl_t.pmdl002, 
   l_pmdl002_desc LIKE type_t.chr1000, 
   l_pmdl003 LIKE pmdl_t.pmdl003, 
   l_pmdl003_desc LIKE type_t.chr1000, 
   pmev003 LIKE pmev_t.pmev003, 
   l_pmev003_desc LIKE type_t.chr1000, 
   l_pmdsdocno LIKE pmds_t.pmdsdocno, 
   l_pmdtseq LIKE pmdt_t.pmdtseq, 
   l_pmds007 LIKE pmds_t.pmds007, 
   l_pmds007_desc LIKE type_t.chr1000, 
   l_pmds001 LIKE pmds_t.pmds001, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr1000, 
   l_imaf141 LIKE imaf_t.imaf141, 
   l_imaf141_desc LIKE type_t.chr1000, 
   l_pmdt006 LIKE pmdt_t.pmdt006, 
   l_pmdt006_desc LIKE type_t.chr1000, 
   l_pmdt006_desc2 LIKE type_t.chr1000, 
   l_pmdt007 LIKE pmdt_t.pmdt007, 
   l_pmdt007_desc LIKE type_t.chr1000, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr1000, 
   l_imaa127_oocql004 LIKE type_t.chr1000, 
   l_pmdt024 LIKE pmdt_t.pmdt024, 
   l_pmdt023 LIKE pmdt_t.pmdt023, 
   l_pmdt036 LIKE pmdt_t.pmdt036, 
   l_pmdt038 LIKE pmdt_t.pmdt038, 
   l_pmdt039 LIKE pmdt_t.pmdt039, 
   l_pmdt047 LIKE pmdt_t.pmdt047, 
   pmevent LIKE pmev_t.pmevent, 
   pmevsite LIKE pmev_t.pmevsite, 
   pmevstus LIKE pmev_t.pmevstus, 
   pmev004 LIKE pmev_t.pmev004, 
   pmev005 LIKE pmev_t.pmev005, 
   pmev006 LIKE pmev_t.pmev006, 
   pmev008 LIKE pmev_t.pmev008, 
   pmev009 LIKE pmev_t.pmev009, 
   pmev010 LIKE pmev_t.pmev010, 
   pmev011 LIKE pmev_t.pmev011, 
   pmev012 LIKE pmev_t.pmev012, 
   pmev013 LIKE pmev_t.pmev013, 
   pmev014 LIKE pmev_t.pmev014, 
   pmev015 LIKE pmev_t.pmev015, 
   pmev016 LIKE pmev_t.pmev016, 
   pmev017 LIKE pmev_t.pmev017, 
   pmev018 LIKE pmev_t.pmev018, 
   pmex001 LIKE pmex_t.pmex001, 
   pmex002 LIKE pmex_t.pmex002
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql      STRING
DEFINE l_where    STRING
DEFINE l_success  LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_pmds028  LIKE pmds_t.pmds028  #161207-00033#24
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr432_x01_curs INTO sr.*                               
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
       LET l_where = ''
       LET l_where = ''
       IF cl_null(sr.pmev012) THEN
          LET l_where = " pmds001 >= '",sr.pmev011,"' "
       ELSE
          #dorislai-20150821-modify----(S)   固定日期型態，sql才抓的到
#         LET l_where = " pmds001 >= '",sr.pmev011,"' AND pmds001 <= '",sr.pmev012,"' "
          LET l_where = " to_char(pmds001,'yyyy/mm/dd') >= '",sr.pmev011,"' AND to_char(pmds001,'yyyy/mm/dd') <= '",sr.pmev012,"' "
          #dorislai-20150821-modify----(E)
       END IF
       
       IF sr.pmev013 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND pmds037 = '",sr.pmev004,"' "
       END IF
       
       IF sr.pmev014 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND pmds033 = '",sr.pmev005,"' "
       END IF
       
       IF sr.pmev015 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND pmds031 = '",sr.pmev008,"' "
       END IF
       
       IF sr.pmev016 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND pmds032 = '",sr.pmev009,"' "
       END IF
       
       IF sr.pmev017 = 'Y' THEN
         LET l_where = l_where CLIPPED ," AND pmds012 = '",sr.pmev010,"' "
       END IF
        CASE sr.pmex001
          WHEN '1'
             IF NOT cl_null(sr.pmex002) THEN
                LET l_where = l_where CLIPPED ," AND pmdt006 = '",sr.pmex002,"' "
             END IF
          WHEN '2'
             IF NOT cl_null(sr.pmex002) THEN
                LET l_where = l_where CLIPPED ," AND imaa009 = '",sr.pmex002,"' "
             END IF
          WHEN '3'
             IF NOT cl_null(sr.pmex002) THEN
                LET l_where = l_where CLIPPED ," AND imaa127 = '",sr.pmex002,"' "
             END IF
       END CASE
       
       IF sr.pmev018 = 'Y' THEN
          LET l_where = l_where CLIPPED," AND ((pmds000 = '7' AND pmds054 NOT IN ('2','4' )) ",   #倉退單
                                        "       OR pmds000 IN ('3','4','6')) "   
       ELSE 
          LET l_where = l_where CLIPPED," AND pmds000 IN ('3','4','6') "  #入庫單
       END IF
       IF cl_null(l_where) THEN
          LET l_where = ' 1=1 '
       END IF
       #151106-00004#14-mod-(S)
#       LET l_sql = "SELECT pmdl002,pmdl003,pmdsdocno,pmdtseq,pmds007,pmds001,imaa009,imaf141,",
#                   "       imaa127,pmdt006,pmdt007,pmdt024,pmdt023,pmdt036,pmdt038,pmdt039,pmdt047",
#                   "  FROM pmds_t,pmdt_t LEFT OUTER JOIN pmdl_t ON pmdlent = pmdtent AND pmdldocno = pmdt001 ",
#                   "                     LEFT OUTER JOIN imaa_t ON imaaent = pmdtent AND imaa001 = pmdt006 ",
#                   "                     LEFT OUTER JOIN imaf_t ON imafent = pmdtent AND imafsite = pmdtsite AND imaf001 = pmdt006",
#                   "  WHERE pmdsent = pmdtent  AND pmdsdocno = pmdtdocno ",
#                   
#                   "    AND pmdsdocno||pmdtseq NOT IN (SELECT DISTINCT pmeo003||pmeo004 ",
#                   "                            FROM pmeo_t ",
#                   "                           WHERE pmeoent = ",g_enterprise,
#                   "                             AND pmeosite = '",g_site,"')",
#                   "    AND pmdsstus = 'S'",
#                   "    AND ",tm.wc2,
#                   "    AND ",l_where  
       LET l_sql = "SELECT pmdl002,ooag011,pmdl003,ooefl003,B1.pmaal004,pmdsdocno,pmdtseq,pmds007,B2.pmaal004,pmds001,",
                   "       imaa009,rtaxl003,imaf141,A1.oocql004,pmdt006,imaal003,imaal004,pmdt007,imaa127,S2.oocql004,",
                   "       CASE WHEN A2.oocql004 IS NULL THEN imaa127 ELSE trim(imaa127)||'.'||trim(A2.oocql004) END ,",
                   "       pmdt024,pmdt023,pmdt036,pmdt038,pmdt039,pmdt047,pmds028 ", #161207-00033#24 add pmds028         
                   "  FROM pmdt_t  LEFT OUTER JOIN pmds_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
                   "                               AND pmdsdocno||pmdtseq NOT IN (SELECT DISTINCT pmeo003||pmeo004 ",
                   "                                                              FROM pmeo_t WHERE pmeoent = ",g_enterprise,
                   "                                                               AND pmeosite = '",g_site,"') AND pmdsstus = 'S'",
                   "               LEFT OUTER JOIN pmdl_t ON pmdlent = pmdtent AND pmdldocno = pmdt001 ",
                   "               LEFT OUTER JOIN imaa_t ON imaaent = pmdtent AND imaa001 = pmdt006 ",
                   "               LEFT OUTER JOIN imaf_t ON imafent = pmdtent AND imafsite = pmdtsite AND imaf001 = pmdt006",
                   "               LEFT OUTER JOIN ooag_t ON ooagent = pmdlent AND ooag001 = pmdl002",
                   "               LEFT OUTER JOIN ooefl_t ON ooeflent = pmdlent AND ooefl001 = pmdl003 AND ooefl002 = '",g_dlang,"'",
                   "               LEFT OUTER JOIN imaal_t ON imaalent = imaaent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"'",
                   "               LEFT OUTER JOIN pmaal_t B1 ON B1.pmaalent = '",g_enterprise,"' AND B1.pmaal001 = '",sr.pmev003,"' AND B1.pmaal002 = '",g_dlang,"'",
                   "               LEFT OUTER JOIN pmaal_t B2 ON B2.pmaalent = pmdsent AND B2.pmaal001 = pmds007 AND B2.pmaal002 = '",g_dlang,"'",
                   "               LEFT OUTER JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"'",
                   "               LEFT OUTER JOIN oocql_t A1 ON A1.oocqlent = imafent AND A1.oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '",g_dlang,"'",
                   "               LEFT OUTER JOIN oocql_t A2 ON A2.oocqlent = imaaent AND A2.oocql001 = '2003' AND A2.oocql002 = imaa127 AND A2.oocql003 = '",g_dlang,"'",
                   "    WHERE ",tm.wc2,"    AND ",l_where
       #151106-00004#14-mod-(E)
       PREPARE apmr432_pmds_prepare FROM l_sql
       DISPLAY l_sql
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'prepare:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N' 
       END IF
       DISPLAY l_sql
       DECLARE apmr432_pmds_curs CURSOR FOR apmr432_pmds_prepare
       #151106-00004#14-mod-(S)
#       FOREACH apmr432_pmds_curs INTO sr.l_pmdl002,sr.l_pmdl003,sr.l_pmdsdocno,sr.l_pmdtseq,sr.l_pmds007,sr.l_pmds001,sr.l_imaa009,sr.l_imaf141,
#                                      sr.l_imaa127,sr.l_pmdt006,sr.l_pmdt007,sr.l_pmdt024,sr.l_pmdt023,sr.l_pmdt036,sr.l_pmdt038,sr.l_pmdt039,sr.l_pmdt047
       FOREACH apmr432_pmds_curs INTO sr.l_pmdl002,sr.l_pmdl002_desc,sr.l_pmdl003,sr.l_pmdl003_desc,sr.l_pmev003_desc,sr.l_pmdsdocno,
                                      sr.l_pmdtseq,sr.l_pmds007,sr.l_pmds007_desc,sr.l_pmds001,sr.l_imaa009,sr.l_imaa009_desc,
                                      sr.l_imaf141,sr.l_imaf141_desc,sr.l_pmdt006,sr.l_pmdt006_desc,sr.l_pmdt006_desc2,sr.l_pmdt007,
                                      sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127_oocql004,sr.l_pmdt024,sr.l_pmdt023,sr.l_pmdt036,
                                      sr.l_pmdt038,sr.l_pmdt039,sr.l_pmdt047,l_pmds028  #161207-00033#24 add pmds028                               
       #151106-00004#14-mod-(E)
           IF STATUS THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = 'foreach:'
              LET g_errparam.code   = STATUS
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              LET g_rep_success = 'N'
              EXIT FOREACH
           END IF 
           #161207-00033#24-S
           IF NOT cl_null(l_pmds028) THEN
              CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING sr.l_pmds007_desc
           END IF
           #161207-00033#24-E
          #151106-00004#14-mark-(S)           
#          #採購人員
#          CALL s_desc_get_person_desc(sr.l_pmdl002) RETURNING sr.l_pmdl002_desc
#          #採購部門
#          CALL s_desc_get_department_desc(sr.l_pmdl003) RETURNING sr.l_pmdl003_desc
#          #帳款供應商
#          CALL s_desc_get_trading_partner_abbr_desc(sr.pmev003) RETURNING sr.l_pmev003_desc          
#          #採購供應商
#          CALL s_desc_get_trading_partner_abbr_desc(sr.l_pmds007) RETURNING sr.l_pmds007_desc
#          #產品分類
#          CALL s_desc_get_rtaxl003_desc(sr.l_imaa009) RETURNING sr.l_imaa009_desc
#          #採購分群
#          CALL s_desc_get_acc_desc('203',sr.l_imaf141) RETURNING sr.l_imaf141_desc
#          #系列號
#          CALL s_desc_get_acc_desc('2003',sr.l_imaa127) RETURNING sr.l_imaa127_desc
#          #dorislai-20150821-add----(S)
#          IF NOT cl_null(sr.l_imaa127_desc) THEN
#             LET sr.l_imaa127_oocql004 = sr.l_imaa127,'.',sr.l_imaa127_desc
#          ELSE
#             LET sr.l_imaa127_oocql004 = ''
#          END IF
#          #dorislai-20150821-add----(E)
#          #品名規格
#          CALL s_desc_get_item_desc(sr.l_pmdt006) RETURNING sr.l_pmdt006_desc,sr.l_pmdt006_desc2
          #151106-00004#14-mark-(E)
          #產品特徵
          CALL s_feature_description(sr.l_pmdt006,sr.l_pmdt007) RETURNING l_success,sr.l_pmdt007_desc
          IF NOT l_success THEN
             LET sr.l_pmdt007_desc = ''
          END IF
          
          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt
            FROM pmew_t
           WHERE pmewent = g_enterprise
             AND pmewdocno = sr.pmevdocno
          IF l_cnt > 0 THEN
             LET l_cnt = 0
             SELECT COUNT(*) INTO l_cnt
               FROM pmew_t
              WHERE pmewent = g_enterprise
                AND pmewdocno = sr.pmevdocno
                AND pmew001 = sr.l_pmds007
             IF l_cnt = 0 AND (NOT cl_null(sr.pmev003) AND sr.pmev003 <> sr.l_pmds007) THEN
                CONTINUE FOREACH
             END IF
          ELSE
             #指定帳款客戶
             IF NOT cl_null(sr.pmev003) AND sr.pmev003 <> sr.l_pmds007 THEN
                CONTINUE FOREACH
             END IF
          END IF 
          
          EXECUTE insert_prep USING sr.pmevdocno,sr.pmexseq,sr.l_pmdl002,sr.l_pmdl002_desc,sr.l_pmdl003,sr.l_pmdl003_desc,sr.pmev003,sr.l_pmev003_desc,sr.l_pmdsdocno,sr.l_pmdtseq,sr.l_pmds007,sr.l_pmds007_desc,sr.l_pmds001,sr.l_imaa009,sr.l_imaa009_desc,sr.l_imaf141,sr.l_imaf141_desc,sr.l_pmdt006,sr.l_pmdt006_desc,sr.l_pmdt006_desc2,sr.l_pmdt007,sr.l_pmdt007_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127_oocql004,sr.l_pmdt024,sr.l_pmdt023,sr.l_pmdt036,sr.l_pmdt038,sr.l_pmdt039,sr.l_pmdt047
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "apmr432_x01_execute"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END FOREACH
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       IF g_rep_success = 'N' THEN
         EXIT FOREACH
       ELSE
         CONTINUE FOREACH
       END IF
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmevdocno,sr.pmexseq,sr.l_pmdl002,sr.l_pmdl002_desc,sr.l_pmdl003,sr.l_pmdl003_desc,sr.pmev003,sr.l_pmev003_desc,sr.l_pmdsdocno,sr.l_pmdtseq,sr.l_pmds007,sr.l_pmds007_desc,sr.l_pmds001,sr.l_imaa009,sr.l_imaa009_desc,sr.l_imaf141,sr.l_imaf141_desc,sr.l_pmdt006,sr.l_pmdt006_desc,sr.l_pmdt006_desc2,sr.l_pmdt007,sr.l_pmdt007_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127_oocql004,sr.l_pmdt024,sr.l_pmdt023,sr.l_pmdt036,sr.l_pmdt038,sr.l_pmdt039,sr.l_pmdt047
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr432_x01_execute"
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
 
{<section id="apmr432_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr432_x01_rep_data()
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
 
{<section id="apmr432_x01.other_function" readonly="Y" >}

 
{</section>}
 
