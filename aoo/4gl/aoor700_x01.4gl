#該程式未解開Section, 採用最新樣板產出!
{<section id="aoor700_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:19(2017-02-13 15:37:59), PR版次:0019(2017-02-13 16:06:31)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000088
#+ Filename...: aoor700_x01
#+ Description: ...
#+ Creator....: 05423(2014-08-13 16:21:25)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aoor700_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#151211-00015#2   2015/12/11  By Sarah       程式中寫ent='99'的地方改為ent=g_enterprise
#160510-00019#12  2016/06/07  By zhujing     效能优化
#160704-00005#1   2016/08/19  By zhujing     apmt520单据无过账状态，但使用的表格包括过账状态。故apmt520状态为Y排除不输出。
#161118-00006#1   2016/11/23  By Ann_Huang   增加工單ASF模組狀態須排除狀態結案與成本結案
#161205-00015#1   2016/12/08  By fionchen    資料篩選條件增加ent條件
#161212-00007#1   2016/12/14  By fionchen    調整依程式代號取得主表方式
#161216-00016#1   2016/12/16  By zhujing     排除验退单的过账状态
#170117-00064#2   2017/01/19  By zhujing     anmt540,anmt510资金模组用到状态码'V'，检核时需要特殊判断
#170203-00014#1   2017/02/03  By fionchen    排除結案/已發出/已更新狀態 
#170207-00010#1   2017/02/07  By fionchen    aist310單據無過帳狀態，但使用的表格包括過帳狀態。故aist310狀態為Y排除不輸出。
#170213-00025#1   2017/02/13  By zhujing     aist310單據增加判斷 s_fin_1003 若為 3 時, 增加已過帳檢查,否則不做已過帳檢核
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
       edate STRING,                  #enddate 
       bdate STRING,                  #begindate 
       print STRING,                  #print 
       show STRING                   #show
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tn RECORD
       tname LIKE dzfs_t.dzfs004
END RECORD      

DEFINE tn         DYNAMIC ARRAY OF type_tn
DEFINE l_cnt                  LIKE type_t.num5
DEFINE l_sql      STRING
DEFINE l_sql1     STRING
DEFINE l_sql2     STRING
DEFINE name       STRING
DEFINE l_start LIKE type_t.num5
DEFINE l_end LIKE type_t.num5
DEFINE l_length LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="aoor700_x01.main" readonly="Y" >}
PUBLIC FUNCTION aoor700_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.edate  enddate 
DEFINE  p_arg3 STRING                  #tm.bdate  begindate 
DEFINE  p_arg4 STRING                  #tm.print  print 
DEFINE  p_arg5 STRING                  #tm.show  show
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.edate = p_arg2
   LET tm.bdate = p_arg3
   LET tm.print = p_arg4
   LET tm.show = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aoor700_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aoor700_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aoor700_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aoor700_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aoor700_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aoor700_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aoor700_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aoor700_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "oobx002.oobx_t.oobx002,l_oobx001.type_t.chr30,oobx001.oobx_t.oobx001,oobxl003.oobxl_t.oobxl003,oobxcrtdt.oobx_t.oobxcrtdt,oobxstus.oobx_t.oobxstus,l_oobxstus_desc.type_t.chr30,l_oobxsuts.type_t.chr30,oobxownid.oobx_t.oobxownid,oobxowndp.oobx_t.oobxowndp,oobxcrtid.oobx_t.oobxcrtid,oobxcrtdp.oobx_t.oobxcrtdp,oobx004.oobx_t.oobx004,l_oobxownid_desc.ooag_t.ooag011,l_oobxowndp_desc.ooefl_t.ooefl003,l_oobxcrtid_desc.ooag_t.ooag011,l_oobxcrtdp_desc.ooefl_t.ooefl003,l_oobx004_desc.gzzal_t.gzzal003" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aoor700_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aoor700_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aoor700_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aoor700_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING   #151211-00015#2 add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT UNIQUE oobx002,NULL,oobx001,oobxl003,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,oobx004,NULL,NULL,NULL,NULL,NULL"
#   #end add-point
#   LET g_select = " SELECT oobx002,NULL,oobx001,oobxl003,oobxcrtdt,oobxstus,NULL,NULL,oobxownid,oobxowndp, 
#       oobxcrtid,oobxcrtdp,oobx004,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM oobx_t LEFT OUTER JOIN oobxl_t ON oobx_t.oobxent = oobxl_t.oobxlent AND oobx_t.oobx001 = oobxl_t.oobxl001 AND oobxl002 = '",g_dlang,"' "
    #160510-00019#12 add-S
    IF tm.show = 'N' THEN
       LET g_from = g_from CLIPPED,"             LEFT OUTER JOIN gzcb_t  ON gzcb001 = '24' AND oobx003 = gzcb002 "
    END IF
    #160510-00019#12 add-E
#   #end add-point
#    LET g_from = " FROM oobx_t,oobxl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE " ,tm.wc CLIPPED
    #160510-00019#12 add-S
    IF tm.show = 'N' THEN
       LET g_where = g_where CLIPPED," AND (gzcb015 = '999' OR gzcb015 IS NULL) "
    END IF
    #160510-00019#12 add-E
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY oobx001"   #151211-00015#2 add
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
#   LET g_sql = g_sql , g_order   #151211-00015#2 add #160510-00019#12 marked
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("oobx_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #160510-00019#12 add-S
   LET g_sql = g_sql , g_order   #151211-00015#2 add
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #160510-00019#12 add-E
   #end add-point
   PREPARE aoor700_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aoor700_x01_curs CURSOR FOR aoor700_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aoor700_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aoor700_x01_ins_data()
DEFINE sr RECORD 
   oobx002 LIKE oobx_t.oobx002, 
   l_oobx001 LIKE type_t.chr30, 
   oobx001 LIKE oobx_t.oobx001, 
   oobxl003 LIKE oobxl_t.oobxl003, 
   oobxcrtdt LIKE oobx_t.oobxcrtdt, 
   oobxstus LIKE oobx_t.oobxstus, 
   l_oobxstus_desc LIKE type_t.chr30, 
   l_oobxsuts LIKE type_t.chr30, 
   oobxownid LIKE oobx_t.oobxownid, 
   oobxowndp LIKE oobx_t.oobxowndp, 
   oobxcrtid LIKE oobx_t.oobxcrtid, 
   oobxcrtdp LIKE oobx_t.oobxcrtdp, 
   oobx004 LIKE oobx_t.oobx004, 
   l_oobxownid_desc LIKE ooag_t.ooag011, 
   l_oobxowndp_desc LIKE ooefl_t.ooefl003, 
   l_oobxcrtid_desc LIKE ooag_t.ooag011, 
   l_oobxcrtdp_desc LIKE ooefl_t.ooefl003, 
   l_oobx004_desc LIKE gzzal_t.gzzal003
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_pn LIKE type_t.chr30
DEFINE l_no LIKE type_t.chr30
DEFINE l_sql4  STRING
DEFINE l_oobx003 LIKE oobx_t.oobx003
DEFINE l_gzcb015 LIKE gzcb_t.gzcb015
DEFINE l_sql5     STRING                  #2015-9-7-zhujing-add 用来判断表格类型，是否拥有site,comp字段
DEFINE l_type     LIKE type_t.chr30       #2015-9-7-zhujing-add 1.有site 2.有comp  3.无comp
DEFINE l_ooef017  LIKE ooef_t.ooef017     #2015-9-7-zhujing-add 用来存储当前据点对应所属法人  
#160510-00019#12 add-S
DEFINE nametable  LIKE dzeb_t.dzeb001
DEFINE namesite   LIKE dzeb_t.dzeb002
DEFINE namedocno  LIKE dzeb_t.dzeb002
DEFINE namedocdt  LIKE dzeb_t.dzeb002
DEFINE namestus   LIKE dzeb_t.dzeb002
DEFINE nameownid  LIKE dzeb_t.dzeb002
DEFINE nameowndp  LIKE dzeb_t.dzeb002
DEFINE namecrtid  LIKE dzeb_t.dzeb002
DEFINE namecrtdp  LIKE dzeb_t.dzeb002
DEFINE namecomp   LIKE dzeb_t.dzeb002
#160510-00019#12 add-E
DEFINE l_no2      LIKE type_t.chr30       #161118-00006#1 add
DEFINE nameent    LIKE dzeb_t.dzeb002     #161205-00015#1 add
DEFINE l_ent      LIKE type_t.chr30       #161205-00015#1 add
DEFINE l_ooba002  LIKE ooba_t.ooba002     #170213-00025#1 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #170213-00025#1 add-S
    LET l_ooba002 = cl_get_para(g_enterprise,g_site,'S-FIN-1003')
    #170213-00025#1 add-E
    #160510-00019#12 add-S 抓取主表名称
    SELECT ooef017 INTO l_ooef017
      FROM ooef_t
     WHERE ooef001 = g_site AND ooefent = g_enterprise AND ooefstus = 'Y'
   #161212-00007#1 mark --(S)--  
   
#    LET l_sql = "SELECT UNIQUE dzfs004 FROM dzfs_t ",
#                " WHERE dzfs_t.dzfs002 IN (SELECT gzzz002 FROM gzzz_t WHERE gzzz001 = ? )",
#                "   AND dzfs003 = 's_browse' ",
#                "   AND dzfs004 IN (SELECT dzea001 FROM dzea_t WHERE dzea004='T')"   #Sarah add  
   #161212-00007#1 mark --(E)--  
    #161212-00007#1 add --(S)--
    #調整主表取法與取消限制表格型態需為T.交易檔,目為部分固資財務table設定為M.主檔
    LET l_sql = "SELECT DISTINCT(dzag002) FROM dzag_t ",
                " WHERE dzag001 IN (SELECT gzzz002 FROM gzzz_t WHERE gzzz001 = ? )", 
                "   AND dzag005='Y' "
    #161212-00007#1 add --(E)--    
    PREPARE aoor700_x01_single_prepare FROM l_sql
    DECLARE aoor700_x01_single_curs CURSOR FOR aoor700_x01_single_prepare
   #161212-00007#1 mark --(S)-- 
#    LET l_sql = "SELECT UNIQUE dzfs004 FROM dzfs_t ",
#                " WHERE dzfs002 IN",
#                "       (SELECT gzzz002 FROM gzzz_t",
#                "         WHERE gzzz001 IN (SELECT oobl002",
#                "                             FROM oobl_t",
#                "                             LEFT OUTER JOIN oobx_t ON oobx001 = oobl001 AND ooblent = oobxent",
#                "                            WHERE oobl001 = ? ",
#                "                              AND ooblent = ",g_enterprise,  #151211-00015#2 mod
#                "                              AND oobx004 = 'MULTI')) ",
#                " AND dzfs004 IN (SELECT dzea001 FROM dzea_t WHERE dzea004='T')"   #Sarah add  
   #161212-00007#1 mark --(E)--  
    #161212-00007#1 add --(S)--
    LET l_sql = "SELECT DISTINCT(dzag002) FROM dzag_t ",
                " WHERE dzag001 IN",
                "       (SELECT gzzz002 FROM gzzz_t",
                "         WHERE gzzz001 IN (SELECT oobl002",
                "                             FROM oobl_t",
                "                             LEFT OUTER JOIN oobx_t ON oobx001 = oobl001 AND ooblent = oobxent",
                "                            WHERE oobl001 = ? ",
                "                              AND ooblent = ",g_enterprise,  
                "                              AND oobx004 = 'MULTI')) ",
                "   AND dzag005='Y' "
    #161212-00007#1 add --(E)--    
    PREPARE aoor700_x01_multi_prepare FROM l_sql
    DECLARE aoor700_x01_multi_curs CURSOR FOR aoor700_x01_multi_prepare
    
    LET l_sql4 = "SELECT COUNT(*) FROM dzeb_t  WHERE dzeb001 = ? AND dzeb002 = ? "
    PREPARE aoor700_x01_prepare5 FROM l_sql4
    DECLARE aoor700_x01_curs5 CURSOR FOR aoor700_x01_prepare5
    
    LET l_sql1 = "SELECT COUNT(*) FROM gzcc_t WHERE gzccstus = 'Y' AND gzcc001 = ? AND gzcc004 = 'S' "
    PREPARE aoor700_x01_prepare4 FROM l_sql1
    DECLARE aoor700_x01_curs4 CURSOR FOR aoor700_x01_prepare4
    #160510-00019#12 add-E
    
    #161118-00006#1-(S)-add
    #ASF模組須排除狀態: 結案或成本結案
    LET l_sql1 = "SELECT COUNT(*) FROM gzcc_t WHERE gzccstus = 'Y' AND gzcc001 = ? AND (gzcc004 = 'M' OR gzcc004 = 'C') "
    PREPARE aoor700_x01_prepare7 FROM l_sql1
    DECLARE aoor700_x01_curs7 CURSOR FOR aoor700_x01_prepare7
    #161118-00006#1-(E)-add
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aoor700_x01_curs INTO sr.*                               
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
       LET l_cnt = 1
       #160510-00019#12 marked-S
#       IF (tm.show == 'N') THEN  #查看可選狀態碼,僅列印影響庫存單 oobx003 = gzcb002 gzcb001 = '24' gzcb015!='999'or null
##         SELECT oobx003 INTO l_oobx003
##           FROM oobx_t
##          WHERE oobx001 = sr.oobx001
##            AND oobxent = g_enterprise
##         SELECT gzcb015 INTO l_gzcb015
##           FROM gzcb_t
##          WHERE gzcb001 = '24'
##            AND gzcb002 = l_oobx003
#         SELECT oobx003,gzcb015 INTO l_oobx003,l_gzcb015
#           FROM oobx_t,gzcb_t
#          WHERE oobx001 = sr.oobx001
#            AND oobxent = g_enterprise
#            AND oobx003 = gzcb002
#            AND gzcb001 = '24'
#            
#         IF cl_null(l_gzcb015) OR l_gzcb015 = '999' THEN    #非库存异动单据
#            INITIALIZE sr.* TO NULL
#            CONTINUE FOREACH
#         END IF
#
#       END IF 
       #160510-00019#12 marked-E
       INITIALIZE tn[l_cnt].* TO NULL
       #160510-00019#12 marked-S
#       IF sr.oobx004 != 'MULTI' THEN
#         LET l_sql = "SELECT UNIQUE dzfs004 FROM dzfs_t ",
#                     " WHERE dzfs_t.dzfs002 IN (SELECT gzzz002 FROM gzzz_t WHERE gzzz001 = '",sr.oobx004 ,"')",
#                     "   AND dzfs003 = 's_browse' "
#       ELSE
#         LET l_sql = "SELECT UNIQUE dzfs004 FROM dzfs_t ",
#                     " WHERE dzfs002 IN",
#                     "       (SELECT gzzz002 FROM gzzz_t",
#                     "         WHERE gzzz001 IN (SELECT oobl002",
#                     "                             FROM oobl_t",
#                     "                             LEFT OUTER JOIN oobx_t ON oobx001 = oobl001 AND ooblent = oobxent",
#                     "                            WHERE oobl001 = '",sr.oobx001,"'",
#                     "                              AND ooblent = ",g_enterprise,  #151211-00015#2 mod
#                     "                              AND oobx004 = 'MULTI')) "
#       END IF
#       LET l_sql = l_sql," AND dzfs004 IN (SELECT dzea001 FROM dzea_t WHERE dzea004='T')"   #Sarah add       
#         PREPARE aoor700_x01_prepare2 FROM l_sql
#         DECLARE aoor700_x01_curs2 CURSOR FOR aoor700_x01_prepare2
       #160510-00019#12 marked-E
       IF sr.oobx004 != 'MULTI' THEN
          FOREACH aoor700_x01_single_curs USING sr.oobx004 INTO tn[l_cnt].*
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF 
             LET l_cnt = l_cnt + 1
          END FOREACH
       ELSE
          FOREACH aoor700_x01_multi_curs USING sr.oobx001 INTO tn[l_cnt].*
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF 
             LET l_cnt = l_cnt + 1
          END FOREACH
       END IF
       #160510-00019#12 marked-S
#         FOREACH aoor700_x01_curs2 INTO tn[l_cnt].*
#            IF STATUS THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = 'foreach:'
#               LET g_errparam.code   = STATUS
#               LET g_errparam.popup  = TRUE
#               CALL cl_err()
#               LET g_rep_success = 'N'
#               EXIT FOREACH
#            END IF 
#            
##            IF (tm.show == 'N') THEN  #查看可選狀態碼,僅列印影響庫存單 oobx003 = gzcb002 gzcb001 = '24' gzcb015!='999'or null
##               SELECT oobx003 INTO l_oobx003
##                 FROM oobx_t
##                WHERE oobx001 = sr.oobx001
##                  AND oobxent = g_enterprise
##               SELECT gzcb015 INTO l_gzcb015
##                 FROM gzcb_t
##                WHERE gzcb001 = '24'
##                  AND gzcb002 = l_oobx003
##               IF cl_null(l_gzcb015) OR l_gzcb015 = '999' THEN
###               LET l_sql1 = "SELECT gzcc004 FROM gzcc_t WHERE gzccstus = 'Y' AND gzcc001 = '",tn[l_cnt].tname ,"' "
###               PREPARE aoor700_x01_prepare4 FROM l_sql1
###               DECLARE aoor700_x01_curs4 CURSOR FOR aoor700_x01_prepare4
###               FOREACH aoor700_x01_curs4 INTO l_no
###                  IF (l_no <> "S") THEN
###                     CONTINUE FOREACH
###                  ELSE
##                     LET tn[l_cnt].tname = NULL
##                     LET l_cnt = l_cnt - 1
###                     EXIT FOREACH                     
##                  END IF
###                END FOREACH
##            END IF            
#            LET l_cnt = l_cnt+1
#         END FOREACH
       #160510-00019#12 marked-E
       CALL tn.deleteElement(l_cnt)
       FOR l_cnt = 1 TO tn.getlength()
         INITIALIZE name TO NULL
         LET name = tn[l_cnt].tname 
         LET name = name.subString(1,4)
         CALL aoor700_x01_getposition() RETURNING l_start,l_end,l_length
         #160510-00019#12 add-S
         LET nametable = name CLIPPED,'_t'
         LET namesite  = name CLIPPED,'site'
         LET namedocno = name CLIPPED,'docno'
         LET namedocdt = name CLIPPED,'docdt'
         LET namestus  = name CLIPPED,'stus'
         LET nameownid = name CLIPPED,'ownid'
         LET nameowndp = name CLIPPED,'owndp'
         LET namecrtid = name CLIPPED,'crtid'
         LET namecrtdp = name CLIPPED,'crtdp'
         LET namecomp  = name CLIPPED,'comp'
         LET l_type = 0
         EXECUTE aoor700_x01_curs5 USING nametable,namesite INTO l_pn
         IF l_pn = 0 OR cl_null(l_pn) THEN
            EXECUTE aoor700_x01_curs5 USING nametable,namecomp INTO l_pn
            IF l_pn = 0 OR cl_null(l_pn) THEN   
               LET l_type = '3' #无comp，无site#无comp，无site
               LET namesite = '***'
               LET namecomp = '***'
            ELSE
               LET l_type = '2' #有comp，无site
               LET namesite = '***'
            END IF
         ELSE
            LET l_type = '1' #有site
            LET namecomp = '***'
         END IF
         #添加状态码判断：若可选状态码中包含S则剔除状态为S的单据，若无S有Y，则剔除Y的单据（最终状态码）
         EXECUTE aoor700_x01_curs4 USING nametable INTO l_no   
#         IF cl_null(l_no) THEN #无过账               #160704-00005#1 mark
         IF cl_null(l_no)                          #160704-00005#1 mod-S   以下作业共用的表格最终状态码为S，但是以下作业的最终状态码无S,故需剔除 （ps:若有其他共用表格最终状态码为'S',但作业的最终状态码却为Y的作业需在下面加上
            OR sr.oobx004 = 'apmt520' OR sr.oobx004 = 'apmt521' OR sr.oobx004 = 'apmt522' OR sr.oobx004 = 'apmt523' OR sr.oobx004 = 'apmt524' OR sr.oobx004 = 'apmt526' 
            OR sr.oobx004 = 'apmt560' OR sr.oobx004 = 'apmt561' OR sr.oobx004 = 'apmt563'  #161216-00016#1 add
            #170213-00025#1 mod-S   aist310 單據請增加判斷 s_fin_1003 若為 3 時,增加已過帳檢查,否則不做已過帳檢核
#            OR sr.oobx004 = 'aist310'                                                      #170207-00010#1 add
            OR (sr.oobx004 = 'aist310' AND l_ooba002 <> '3')
            #170213-00025#1 mod-E
            OR sr.oobx004 = 'axmt580' OR sr.oobx004 = 'axmt581' OR sr.oobx004 = 'axmt590' OR sr.oobx004 = 'axmt591' THEN #无过账  #160704-00005#1 mod-E
            LET l_no = 0
         END IF
         #160510-00019#12 add-E
         #170117-00064#2 add-S      资金模组的以下作业状态码最高为'V'，需另外剔除。（ps：若有其他最终状态码为'V'的作业需在下面加上
         IF sr.oobx004 = 'anmt561' OR sr.oobx004 = 'anmt510' OR sr.oobx004 = 'anmt540'
            OR sr.oobx004 = 'anmt560' OR sr.oobx004 = 'anmt563' OR sr.oobx004 = 'anmt541' THEN
            LET l_no = 200
         END IF 
         #170117-00064#2 add-E 
         #170203-00014#1 add --(S)--      abmt400作業需排除'4'已更新。
         IF sr.oobx004 = 'abmt400' THEN
            LET l_no = 300
         END IF 
         #170203-00014#1 add --(E)--          
         #161205-00015#1 add --(S)--
         LET nameent = name CLIPPED,'ent'
         LET l_ent = '0'
         EXECUTE aoor700_x01_curs5 USING nametable,nameent INTO l_pn
         IF l_pn = 0 OR cl_null(l_pn) THEN
            LET nameent = '***'
         ELSE
            LET l_ent = '1' #有ent
         END IF
         #161205-00015#1 add --(E)--
         
         #161118-00006#1-(S)-add
         #ASF模組須排除狀態: 結案或成本結案
         IF sr.oobx002 = "ASF" THEN
            EXECUTE aoor700_x01_curs7 USING nametable INTO l_no2
            IF cl_null(l_no2) OR (l_no2 = 0) OR (l_no > 0) THEN
               #代表無成本或成本結案狀態,則無須更動l_no               
            ELSE            
               LET l_no = 999             
            END IF
         END IF
         #161118-00006#1-(E)-add
         
         #160510-00019#12 marked-S------------------
#         LET l_sql4 = "SELECT ",name CLIPPED,"site FROM ",name CLIPPED,"_t "
#         PREPARE aoor700_x01_prepare5 FROM l_sql4
#         DECLARE aoor700_x01_curs5 CURSOR FOR aoor700_x01_prepare5
#         FOREACH aoor700_x01_curs5 INTO l_pn
#            EXIT FOREACH
#         END FOREACH
#         #zhujing 2015-9-07 add---(S)财务模组无site，但须判断法人资料ooef001 = g_site and ooef007 = ****comp
#         LET l_type = '1'     #1.有site
#         IF STATUS THEN
#            LET l_type = '2'  #2.有comp
#            LET l_sql5 = "SELECT ",name CLIPPED,"comp FROM ",name CLIPPED,"_t "
#            PREPARE aoor700_x01_prepare6 FROM l_sql5
#            DECLARE aoor700_x01_curs6 CURSOR FOR aoor700_x01_prepare6
#            FOREACH aoor700_x01_curs6 INTO l_pn
#               EXIT FOREACH
#            END FOREACH
#            IF STATUS THEN
#               LET l_type = '3'  #3.无comp，无site
#            END IF
#         END IF
#         #zhujing 2015-9-07 add---(E)
#         #zhujing 2015-8-18 add---(S)添加状态码判断：若可选状态码中包含S则剔除状态为S的单据，若无S有Y，则剔除Y的单据（最终状态码）
#         LET l_sql1 = "SELECT COUNT(*) FROM gzcc_t WHERE gzccstus = 'Y' AND gzcc001 = '",tn[l_cnt].tname ,"' AND gzcc004 = 'S' "
#         PREPARE aoor700_x01_prepare4 FROM l_sql1
#         DECLARE aoor700_x01_curs4 CURSOR FOR aoor700_x01_prepare4
#         FOREACH aoor700_x01_curs4 INTO l_no
#            IF cl_null(l_no) THEN      #可选状态码无过帐
#               LET l_no = 0
#            END IF
#         END FOREACH
#         #zhujing 2015-8-18 add---(E)
         #zhujing 2015-9-07 modify---(S)根据是否有comp,site组sql
         #160510-00019#12 marked-E------------------
         CASE l_type
            WHEN '1'
               LET l_sql2 = "SELECT DISTINCT ", name CLIPPED,"docno,",name CLIPPED,"docdt,",name CLIPPED,"stus,",name CLIPPED,"ownid,",
                     name CLIPPED,"owndp,",name CLIPPED,"crtid,",name CLIPPED,"crtdp",
                     #160510-00019#12 add-S
                     ",(SELECT ooag011 FROM ooag_t WHERE ooag001 = ",nameownid," AND ooagent = ",g_enterprise,") t1_ooag011",
                     ",(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = ",nameowndp," AND ooefl002 = '",g_dlang,"' AND ooeflent = ",g_enterprise,") t2_ooefl003",
                     ",(SELECT ooag011 FROM ooag_t WHERE ooag001 = ",namecrtid," AND ooagent = ",g_enterprise,") t3_ooag011",
                     ",(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = ",namecrtdp," AND ooefl002 = '",g_dlang,"' AND ooeflent = ",g_enterprise,") t4_ooefl003",
                     ",(SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = '",sr.oobx004,"' AND gzzal002 = '",g_dlang,"' ) t5_gzzal003 ",
                     #160510-00019#12 add-E
                     " FROM ",name CLIPPED,"_t"
                     ," WHERE ",name CLIPPED,"site = '",g_site,"' AND substr(",name CLIPPED,"docno,",l_start,",",l_length,") = '",sr.oobx001,"' "
            WHEN '2'
               #160510-00019#12 marked-S
#               SELECT ooef017 INTO l_ooef017
#                 FROM ooef_t
#                WHERE ooef001 = g_site AND ooefent = g_enterprise AND ooefstus = 'Y'
               #160510-00019#12 marked-E
               LET l_sql2 = "SELECT DISTINCT ", name CLIPPED,"docno,",name CLIPPED,"docdt,",name CLIPPED,"stus,",name CLIPPED,"ownid,",
                     name CLIPPED,"owndp,",name CLIPPED,"crtid,",name CLIPPED,"crtdp",
                     #160510-00019#12 add-S
                     ",(SELECT ooag011 FROM ooag_t WHERE ooag001 = ",nameownid," AND ooagent = ",g_enterprise,") t1_ooag011",
                     ",(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = ",nameowndp," AND ooefl002 = '",g_dlang,"' AND ooeflent = ",g_enterprise,") t2_ooefl003",
                     ",(SELECT ooag011 FROM ooag_t WHERE ooag001 = ",namecrtid," AND ooagent = ",g_enterprise,") t3_ooag011",
                     ",(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = ",namecrtdp," AND ooefl002 = '",g_dlang,"' AND ooeflent = ",g_enterprise,") t4_ooefl003",
                     ",(SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = '",sr.oobx004,"' AND gzzal002 = '",g_dlang,"' ) t5_gzzal003 ",
                     #160510-00019#12 add-E
                     " FROM ",name CLIPPED,"_t"
                     ," WHERE ",name CLIPPED,"comp = '",l_ooef017,"' AND substr(",name CLIPPED,"docno,",l_start,",",l_length,") = '",sr.oobx001,"' "
            WHEN '3'
               LET l_sql2 = "SELECT DISTINCT ", name CLIPPED,"docno,",name CLIPPED,"docdt,",name CLIPPED,"stus,",name CLIPPED,"ownid,",
                     name CLIPPED,"owndp,",name CLIPPED,"crtid,",name CLIPPED,"crtdp",
                     #160510-00019#12 add-S
                     ",(SELECT ooag011 FROM ooag_t WHERE ooag001 = ",nameownid," AND ooagent = ",g_enterprise,") t1_ooag011",
                     ",(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = ",nameowndp," AND ooefl002 = '",g_dlang,"' AND ooeflent = ",g_enterprise,") t2_ooefl003",
                     ",(SELECT ooag011 FROM ooag_t WHERE ooag001 = ",namecrtid," AND ooagent = ",g_enterprise,") t3_ooag011",
                     ",(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = ",namecrtdp," AND ooefl002 = '",g_dlang,"' AND ooeflent = ",g_enterprise,") t4_ooefl003",
                     ",(SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = '",sr.oobx004,"' AND gzzal002 = '",g_dlang,"' ) t5_gzzal003 ",
                     #160510-00019#12 add-E
                     " FROM ",name CLIPPED,"_t"
                     ," WHERE substr(",name CLIPPED,"docno,",l_start,",",l_length,") = '",sr.oobx001,"' "
         END CASE
         #zhujing 2015-9-07 modify---(E)
         
         #161205-00015#1 add --(S)--
         IF l_ent = '1' THEN
            LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"ent = '",g_enterprise,"' "
         END IF
         #161205-00015#1 add --(E)--
         
         #161118-00006#1-(S)-mark 
         ##zhujing 2015-8-18 add---(S)         
         #IF l_no = 0 THEN
         #   LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus <> 'Y' "
         #ELSE
         #   LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus <> 'S' "
         #END IF
         ##zhujing 2015-8-18 add---(E)         
         #161118-00006#1-(E)-mark 
         
         #161118-00006#1-(S)-add
         CASE 
             WHEN l_no = 0
               #LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus <> 'Y' "                       #170203-00014#1 mark
                LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus not in ('Y','C') "             #170203-00014#1 add 增加排除結案 
                
             WHEN l_no = 999  #排除工單模組結案、成本結案
               #LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus not in ('Y','M','C') "         #170203-00014#1 mark
                LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus not in ('Y','F','M','C') "     #170203-00014#1 add 增加排除已發出
             #170117-00064#2 add-S      资金模组的以下作业状态码最高为'V'，sql需要剔除为'V'的状态
             WHEN l_no = 200
                LET l_sql2= l_sql2 CLIPPED," AND ",name CLIPPED,"stus <> 'V' "
             #170117-00064#2 add-E   
             #170203-00014#1 add --(S)--      abmt400作業狀態需排除'4'已更新
             WHEN l_no = 300
                LET l_sql2= l_sql2 CLIPPED," AND ",name CLIPPED,"stus not in ('Y','4') "
             #170203-00014#1 add --(E)--              
             OTHERWISE
                LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus <> 'S' "
         END CASE
         #161118-00006#1-(E)-add
         
         #160510-00019#12 add-S
         IF (tm.print == 'N') THEN
            LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"stus <> 'X' "
         END IF
         #160510-00019#12 add-E
         IF NOT cl_null(tm.bdate) THEN
            LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"docdt >= '",tm.bdate,"' "
         END IF
         IF NOT cl_null(tm.edate) THEN
            LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"docdt <= '",tm.edate,"'"
         END IF
         LET l_sql2 = l_sql2 CLIPPED ," ORDER BY ",name CLIPPED,"docno "
         PREPARE aoor700_x01_prepare3 FROM l_sql2
         DECLARE aoor700_x01_curs3 CURSOR FOR aoor700_x01_prepare3
         FOREACH aoor700_x01_curs3 INTO sr.l_oobx001,sr.oobxcrtdt,sr.oobxstus,sr.oobxownid,sr.oobxowndp,sr.oobxcrtid,sr.oobxcrtdp
                                        ,sr.l_oobxownid_desc,sr.l_oobxowndp_desc,sr.l_oobxcrtid_desc,sr.l_oobxcrtdp_desc,sr.l_oobx004_desc       #160510-00019#12 add
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_rep_success = 'N'
               EXIT FOREACH
            END IF  
            #2015/09/10 by stellar modify ----- (S)
#            CALL aoor700_x01_desc('13',sr.oobxstus) RETURNING sr.l_oobxstus_desc
#            LET sr.l_oobxstus_desc = sr.oobxstus , sr.l_oobxstus_desc
            CASE sr.oobxstus
               WHEN 'N'
                    CALL cl_getmsg('aoo-00451',g_dlang)
                         RETURNING sr.l_oobxstus_desc
               WHEN 'Y'
                    #170117-00064#2 mod-S
                    IF l_no = '200' THEN   #aoo-00721 已确认未复核
                       CALL cl_getmsg('aoo-00721',g_dlang)
                            RETURNING sr.l_oobxstus_desc
                    ELSE   
                       CALL cl_getmsg('aoo-00452',g_dlang)  #已确认未过账
                            RETURNING sr.l_oobxstus_desc
                    END IF
                    #170117-00064#2 mod-E
               WHEN 'X'
                    CALL cl_getmsg('aoo-00453',g_dlang)
                         RETURNING sr.l_oobxstus_desc
               #2015/10/16 by stellar add ----- (S)
               #stellar add:其他狀態抓SCC13
               OTHERWISE
                    CALL aoor700_x01_desc('13',sr.oobxstus) RETURNING sr.l_oobxstus_desc
               #2015/10/16 by stellar add ----- (E)
            END CASE
            #2015/09/10 by stellar modify ----- (E)
            IF NOT cl_null(sr.oobxownid) THEN
               #160510-00019#12 marked-S
#               SELECT ooag011 INTO sr.l_oobxownid_desc
#                 FROM ooag_t 
#                WHERE ooag001 = sr.oobxownid AND ooagent = g_enterprise
               #160510-00019#12 marked-E
               LET sr.l_oobxownid_desc = sr.oobxownid,".",sr.l_oobxownid_desc
            END IF
            IF NOT cl_null(sr.oobxowndp) THEN
               #160510-00019#12 marked-S
#               SELECT ooefl003 INTO sr.l_oobxowndp_desc
#                 FROM ooefl_t 
#                WHERE ooefl001 = sr.oobxowndp AND ooeflent = g_enterprise AND ooefl002 = g_dlang
               #160510-00019#12 marked-E
               LET sr.l_oobxowndp_desc = sr.oobxowndp,".",sr.l_oobxowndp_desc
            END IF
            IF NOT cl_null(sr.oobxcrtid) THEN
               #160510-00019#12 marked-S
#               SELECT ooag011 INTO sr.l_oobxcrtid_desc
#                 FROM ooag_t 
#                WHERE ooag001 = sr.oobxcrtid AND ooagent = g_enterprise
               #160510-00019#12 marked-E
               LET sr.l_oobxcrtid_desc = sr.oobxcrtid,".",sr.l_oobxcrtid_desc
            END IF
            IF NOT cl_null(sr.oobxcrtdp) THEN
               #160510-00019#12 marked-S
#               SELECT ooefl003 INTO sr.l_oobxcrtdp_desc
#                 FROM ooefl_t 
#                WHERE ooefl001 = sr.oobxcrtdp AND ooeflent = g_enterprise AND ooefl002 = g_dlang
               #160510-00019#12 marked-E
               LET sr.l_oobxcrtdp_desc = sr.oobxcrtdp,".",sr.l_oobxcrtdp_desc
            END IF
            IF (sr.oobx004 != 'MULTI') THEN
               #160510-00019#12 marked-S
#               SELECT gzzal003 INTO sr.l_oobx004_desc
#                 FROM gzzal_t 
#                WHERE gzzal001 = sr.oobx004  AND gzzal002 = g_dlang
               #160510-00019#12 marked-E
               LET sr.l_oobx004_desc = sr.oobx004,".",sr.l_oobx004_desc
            ELSE 
               LET sr.l_oobx004_desc = 'MULTI'
                 
            END IF

    
#       IF (sr.oobxcrtdt > tm.edate OR sr.oobxcrtdt < tm.bdate ) THEN
#         CONTINUE FOREACH
#       END IF
      IF cl_null(sr.l_oobx001) THEN
         INITIALIZE sr.* TO NULL
         CONTINUE FOREACH
      END IF
      #160510-00019#12 marked-S
#      IF (tm.print == 'N') THEN
#        IF (sr.oobxstus == 'X') THEN
#           CONTINUE FOREACH
#        END IF
#      END IF
      #160510-00019#12 marked-E 

       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.oobx002,sr.l_oobx001,sr.oobx001,sr.oobxl003,sr.oobxcrtdt,sr.oobxstus,sr.l_oobxstus_desc,sr.l_oobxsuts,sr.oobxownid,sr.oobxowndp,sr.oobxcrtid,sr.oobxcrtdp,sr.oobx004,sr.l_oobxownid_desc,sr.l_oobxowndp_desc,sr.l_oobxcrtid_desc,sr.l_oobxcrtdp_desc,sr.l_oobx004_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aoor700_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
         END FOREACH
       END FOR
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aoor700_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aoor700_x01_rep_data()
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
 
{<section id="aoor700_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION aoor700_x01_desc(p_num,p_target)
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   #1.系統分類碼SCC 

         SELECT gzcbl004 INTO r_desc
           FROM gzcbl_t
          WHERE gzcbl001 = p_num
            AND gzcbl002 = p_target
            AND gzcbl003 = g_dlang

   
   RETURN r_desc
END FUNCTION

PRIVATE FUNCTION aoor700_x01_getposition()
DEFINE g_form RECORD
kind LIKE type_t.chr10,  #單據編號格式
length LIKE type_t.num5,#單別長度
sign LIKE type_t.chr10, #第一字元分隔符
ent   LIKE type_t.chr10 #营运据点长度    2015-1-14 zj add
END RECORD
DEFINE l_start LIKE type_t.num5
DEFINE l_end LIKE type_t.num5

CALL cl_get_para(g_enterprise,g_site,'E-COM-0008') RETURNING g_form.kind
CALL cl_get_para(g_enterprise,g_site,'E-COM-0001') RETURNING g_form.length
CALL cl_get_para(g_enterprise,g_site,'E-COM-0002') RETURNING g_form.sign
CALL cl_get_para(g_enterprise,g_site,'E-COM-0003') RETURNING g_form.ent    #2015-1-14 zj mod

IF (g_form.kind=='2') THEN
   LET l_start = 1
   LET l_end = g_form.length
ELSE
   LET l_start = g_form.ent + 1     #2015-1-14 zj mod
   IF (g_form.sign == 'Y') THEN
      LET l_start = l_start + 1
   END IF
   LET l_end = l_start + g_form.length
END IF
RETURN l_start,l_end,g_form.length
END FUNCTION

 
{</section>}
 
