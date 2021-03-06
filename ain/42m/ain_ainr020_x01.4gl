#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr020_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-05-06 10:12:05), PR版次:0004(2016-05-06 10:55:37)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: ainr020_x01
#+ Description: ...
#+ Creator....: 05423(2014-11-17 10:27:09)
#+ Modifier...: 02294 -SD/PR- 02294
 
{</section>}
 
{<section id="ainr020_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160505-00014#1  2016/05/06   By lixiang  效能优化
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_where         STRING
#end add-point
 
{</section>}
 
{<section id="ainr020_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr020_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr020_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr020_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr020_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr020_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr020_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr020_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr020_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr020_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inaj005.inaj_t.inaj005,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,inag007.inag_t.inag007,l_cnt1.type_t.num20_6,l_cnt2.type_t.num20_6,l_cnt3.type_t.num20_6,l_cnt4.type_t.num20_6,l_cnt5.type_t.num20_6,l_cnt6.type_t.num20_6,l_cnt7.type_t.num20_6,l_cnt8.type_t.num20_6,l_cnt10.type_t.num20_6,l_cnt9.type_t.num20_6,l_left.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr020_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr020_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?)"
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
 
{<section id="ainr020_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr020_x01_sel_prep()
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
   #LET g_select = " SELECT DISTINCT imaa001,imaal_t.imaal003,imaal_t.imaal004,imaa006,0,0,   #160505-00014#1 mark
   #                 0,0,0,0,0,0,0,0,0"   #160505-00014#1 mark
   #160505-00014#1--add--begin---
   LET g_select = " SELECT DISTINCT imaa001, (SELECT imaal003 FROM imaal_t WHERE imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"') imaal003, 
                                             (SELECT imaal004 FROM imaal_t WHERE imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang,"') imaal004, 
                                    imaa006,0,0,  
                                    0,0,0,0,0,0,0,0,0"
   #160505-00014#1--add--end---
                                    
 
#   #end add-point
#   LET g_select = " SELECT inaj005,imaal_t.imaal003,imaal_t.imaal004,inag007,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM imaa_t ",
#    LEFT OUTER JOIN inag_t ON inaj005 = inag001 AND inaj006 = inag002 AND inaj007 = inag003 AND inajent = inagent AND inajsite = inagsite AND 
#    " FROM inaj_t LEFT OUTER JOIN inag_t ON inaj005 = inag001 AND inaj006 = inag002 AND inaj007 = inag003 AND inajent = inagent AND inajsite = inagsite AND ",
#                 "                                       inaj008 = inag004 AND inaj009 = inag005 AND inaj010 = inag006 AND inaj012 = inag007 ",
#                 "             LEFT OUTER JOIN imaa_t ON imaa001 = inaj005 AND imaaent = inajent ",
                 #"             LEFT OUTER JOIN inag_t ON inag001 = imaa001 AND inagent = imaaent AND inagsite = '",g_site CLIPPED, "' ",  #160505-00014#1 mark ainr020串过来的条件中无需关联inag
                 "             LEFT OUTER JOIN imae_t ON imae001 = imaa001 AND imaeent = imaaent AND imaesite = '",g_site, "' ",
                 "             LEFT OUTER JOIN imaf_t ON imaf001 = imaa001 AND imafent = imaaent AND imafsite = '",g_site, "' "
                 #"             LEFT OUTER JOIN imaal_t ON imaal001 = imaa001 AND imaalent = imaaent AND imaal002 = '",g_dlang CLIPPED,"' "  #160505-00014#1 mark

#   #end add-point
#    LET g_from = " FROM inaj_t,inag_t,imaa_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inaj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET l_where = g_where
   #end add-point
   PREPARE ainr020_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr020_x01_curs CURSOR FOR ainr020_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr020_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr020_x01_ins_data()
DEFINE sr RECORD 
   inaj005 LIKE inaj_t.inaj005, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inag007 LIKE inag_t.inag007, 
   l_cnt1 LIKE type_t.num20_6, 
   l_cnt2 LIKE type_t.num20_6, 
   l_cnt3 LIKE type_t.num20_6, 
   l_cnt4 LIKE type_t.num20_6, 
   l_cnt5 LIKE type_t.num20_6, 
   l_cnt6 LIKE type_t.num20_6, 
   l_cnt7 LIKE type_t.num20_6, 
   l_cnt8 LIKE type_t.num20_6, 
   l_cnt10 LIKE type_t.num20_6, 
   l_cnt9 LIKE type_t.num20_6, 
   l_left LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_rate LIKE type_t.num20_6      #記錄轉換率
DEFINE l_inag007  LIKE inag_t.inag007  #記錄需轉換的單位
DEFINE l_sql      STRING               #獲取各張表中的數據
DEFINE l_tmp      LIKE type_t.num20_6  #暫存字段值
DEFINE l_success  LIKE type_t.chr2
DEFINE l_key      LIKE type_t.chr50
DEFINE l_pmds011  LIKE pmds_t.pmds011
DEFINE l_pmds000  LIKE pmds_t.pmds000
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160505-00014#1---add---begin---
    #CURSOR的定义放到FOREACH外面，提升效能
    LET l_sql = " SELECT COALESCE(inag008,0),inag032 FROM inag_t ",--,l_where CLIPPED,
                " WHERE inag001 = ? ",
                " AND inagent = '",g_enterprise CLIPPED,"' ",
                " AND inagsite = '",g_site CLIPPED,"' ",
                " AND inag010 = 'Y'"
                
                
    PREPARE ainr020_inag008_pre FROM l_sql
    DECLARE ainr020_inag008_cur CURSOR FOR ainr020_inag008_pre
    
    #-受訂量 l_cnt2
    LET l_sql = " SELECT (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd015,0)+COALESCE(xmdd016,0)),xmdd004 FROM xmdd_t,xmda_t,xmdc_t ",
                "  WHERE xmdaent = xmddent ",
                "    AND xmdasite = xmddsite ",
                "    AND xmdadocno = xmdddocno ",
                #150112 by zj add start
                "    AND xmdaent = xmdcent ",
                "    AND xmdasite = xmdcsite ",
                "    AND xmdadocno = xmdcdocno ",
                "    AND xmddseq = xmdcseq ",
                "    AND xmdc045 NOT IN ('2','3','4') ",
                #150112 by zj add end  
                "    AND xmdasite = '",g_site CLIPPED,"'",               
                "    AND xmdaent = '",g_enterprise CLIPPED,"'",
                "    AND xmdastus = 'Y' ",
                
                "    AND xmdd001 = ? "
    PREPARE ainr020_xmdd_pre FROM l_sql
    DECLARE ainr020_xmdd_cur CURSOR FOR ainr020_xmdd_pre   

    #-工單備料量 l_cnt3       
    LET l_sql = " SELECT (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+DECODE(SIGN(COALESCE(sfba017,0)-COALESCE(sfba025,0)),-1,0,(COALESCE(sfba017,0)-COALESCE(sfba025,0)))),sfba014 ",
                " FROM sfaa_t,sfba_t ",   --2015-1-16 zj mod 工單超領
                "  WHERE sfaaent = sfbaent ", 
                "    AND sfaadocno = sfbadocno ",
                "    AND sfaaent = '",g_enterprise,"'",
                "    AND sfaasite = '",g_site,"'",
                "    AND sfba006 = ? ",
                "    AND sfaa003 <> '4' ",
                "    AND sfaastus <> 'X' ",
                "    AND sfaastus <> 'C'",
                "    AND sfaastus <> 'M'",
                "    AND sfaa057 = '1' "
#                " GROUP BY sfaa006 "      
#    SELECT sfba014 INTO l_inag007 FROM sfba_t WHERE sfba006 = sr.inaj005 AND sfbaent = g_enterprise AND sfbasite = g_site
    PREPARE ainr020_sfba_pre FROM l_sql
    DECLARE ainr020_sfba_cur CURSOR FOR ainr020_sfba_pre
    
    #+請購量 l_cnt4
    LET l_sql = " SELECT (COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),pmdb007 FROM pmda_t,pmdb_t ",
                "  WHERE pmdaent = pmdbent ",
                "    AND pmdaent = '",g_enterprise,"'",
                "    AND pmdasite = '",g_site,"'",
                "    AND pmdadocno = pmdbdocno ",
                "    AND pmdb004 = ? ", 
                "    AND pmdb006 <> pmdb049 ",
                "    AND pmdb032 NOT IN ('2','3','4') ",  #150112
                "    AND pmdastus <> 'X' AND pmdastus <> 'C' "
     
    PREPARE ainr020_pmdb_pre FROM l_sql
    DECLARE ainr020_pmdb_cur CURSOR FOR ainr020_pmdb_pre
    
    #+採購量 l_cnt5
    LET l_sql = " SELECT (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),pmdo004 FROM pmdl_t,pmdo_t,pmdn_t ",
                "  WHERE pmdlent = pmdoent ",
                "    AND pmdlent = '",g_enterprise,"'",
                "    AND pmdosite = '",g_site,"'",
                "    AND pmdldocno = pmdodocno ",
                "    AND pmdo001 = ? ", 
                #150112 by zj add start
                "    AND pmdnent = pmdlent ",
                "    AND pmdnsite = pmdlsite ",
                "    AND pmdndocno = pmdldocno ",
                "    AND pmdnseq = pmdoseq ",
                "    AND pmdn045 NOT IN ('2','3','4') ",
                #150104 by zj add end   
                "    AND pmdlstus <> 'X' AND pmdlstus <> 'C' ",
                "    AND pmdl005 <> '2' "   #add by zj 20150203
     
    PREPARE ainr020_pmdo_pre FROM l_sql
    DECLARE ainr020_pmdo_cur CURSOR FOR ainr020_pmdo_pre
    
    #+工單在測量 l_cnt6
    LET l_sql = " SELECT (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),sfaa013 FROM sfaa_t ",
                "  WHERE sfaaent = '",g_enterprise,"'",
                "    AND sfaasite = '",g_site,"'",
                "    AND sfaa010 = ? ",
                "    AND sfaa003 <> '4' ",
                "    AND sfaastus <> 'X'",
                "    AND sfaastus <> 'C'",
                "    AND sfaastus <> 'M'",
                "    AND sfaa057 = '1' "
#                " GROUP BY sfaa010 "
#    SELECT sfaa013 INTO l_inag007 FROM sfaa_t WHERE sfaa010 = sr.inaj005 AND sfaaent = g_enterprise AND sfaasite = g_site
    PREPARE ainr020_sfaa_pre FROM l_sql
    DECLARE ainr020_sfaa_cur CURSOR FOR ainr020_sfaa_pre
    
    #+委外在制量 l_cnt7
    LET l_sql = " SELECT (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),sfaa013 FROM sfaa_t ",
                "  WHERE sfaaent = '",g_enterprise,"'",
                "    AND sfaasite = '",g_site,"'",               
                "    AND sfaa010 = ? ",
                "    AND sfaa003 <> '4' ",
                "    AND sfaastus <> 'X'",
                "    AND sfaastus <> 'C'",
                "    AND sfaastus <> 'M'",
                "    AND sfaa057 = '2' "
#                " GROUP BY sfaa010 "
--    SELECT sfaa013 INTO l_inag007 FROM sfaa_t WHERE sfaa010 = sr.inaj005 AND sfaaent = g_enterprise AND sfaasite = g_site
    PREPARE ainr020_sfaa2_pre FROM l_sql
    DECLARE ainr020_sfaa2_cur CURSOR FOR ainr020_sfaa2_pre
    
    #+IQC在驗量 l_cnt8
    LET l_sql = " SELECT (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),pmdt019,pmds011,pmds000 FROM pmds_t,pmdt_t ",
                "  WHERE pmdsent = pmdtent ",
                "    AND pmdsent = '",g_enterprise,"'",
                "    AND pmdssite = '",g_site,"'",
                "    AND pmdsdocno = pmdtdocno ",
#                "    AND pmds000 IN ('1','2','3','4','8','12') ",
                "    AND pmds000 IN ('1','2','8') ",
                "    AND pmds011 IN ('1','2','3','7','8','9','10')",
                "    AND pmdsstus = 'Y' ",
                "    AND pmdt006 = ? ",
                "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 "
     
    SELECT pmdt019 INTO l_inag007 FROM pmdt_t WHERE pmdt006 = sr.inaj005 AND pmdtent = g_enterprise AND pmdtsite = g_site
    PREPARE ainr020_pmdt_pre FROM l_sql
    DECLARE ainr020_pmdt_cur CURSOR FOR ainr020_pmdt_pre
    
    #+FQC在驗量 l_cnt9
    LET l_sql = " SELECT (COALESCE(qcba017,0)-COALESCE(qcba023,0)),qcba016 FROM qcba_t ",
                "  WHERE qcbaent = '",g_enterprise,"'",
                "    AND qcbasite = '",g_site,"'",
                "    AND qcba000 = '2' ",
                "    AND qcbastus = 'Y' ",
                "    AND qcba010 = ? "
#                "  GROUP BY qcba010 "
#    SELECT qcba016 INTO l_inag007 FROM qcba_t WHERE qcba010 = sr.inaj005 AND qcbaent = g_enterprise AND qcbasite = g_site
    PREPARE ainr020_qcba_pre FROM l_sql
    DECLARE ainr020_qcba_cur CURSOR FOR ainr020_qcba_pre
    #160505-00014#1---add---end---
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr020_x01_curs INTO sr.*                               
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
       #可用量 l_cnt1
       LET l_key = sr.inaj005 CLIPPED
       LET sr.l_cnt1 = 0

      #160505-00014#1---mark---begin---
      #LET l_sql = " SELECT COALESCE(inag008,0),inag032 FROM inag_t ",--,l_where CLIPPED,
      #             " WHERE inag001 = '",sr.inaj005 CLIPPED,"' ",
      #             " AND inagent = '",g_enterprise CLIPPED,"' ",
      #             " AND inagsite = '",g_site CLIPPED,"' ",
      #             " AND inag010 = 'Y'"
      #             
      #             
      # PREPARE ainr020_inag008_pre FROM l_sql
      # DECLARE ainr020_inag008_cur CURSOR FOR ainr020_inag008_pre
      # FOREACH ainr020_inag008_cur INTO l_tmp,l_inag007
      #160505-00014#1---mark---end---
      FOREACH ainr020_inag008_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp) RETURNING l_success,l_tmp
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate  #xj mod
            END IF 
         END IF
         LET sr.l_cnt1 = sr.l_cnt1 + l_tmp    
       END FOREACH 
       
       #-受訂量 l_cnt2
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd015,0)+COALESCE(xmdd016,0)),xmdd004 FROM xmdd_t,xmda_t,xmdc_t ",
       #            "  WHERE xmdaent = xmddent ",
       #            "    AND xmdasite = xmddsite ",
       #            "    AND xmdadocno = xmdddocno ",
       #            #150112 by zj add start
       #            "    AND xmdaent = xmdcent ",
       #            "    AND xmdasite = xmdcsite ",
       #            "    AND xmdadocno = xmdcdocno ",
       #            "    AND xmddseq = xmdcseq ",
       #            "    AND xmdc045 NOT IN ('2','3','4') ",
       #            #150112 by zj add end  
       #            "    AND xmdasite = '",g_site CLIPPED,"'",               
       #            "    AND xmdaent = '",g_enterprise CLIPPED,"'",
       #            "    AND xmdastus = 'Y' ",
       #            
       #            "    AND xmdd001 = '",sr.inaj005 CLIPPED ,"' "
       #PREPARE ainr020_xmdd_pre FROM l_sql
       #DECLARE ainr020_xmdd_cur CURSOR FOR ainr020_xmdd_pre
       #FOREACH ainr020_xmdd_cur INTO l_tmp,l_inag007
       #160505-00014#1---mark---end---
       FOREACH ainr020_xmdd_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate    #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp) RETURNING l_success,l_tmp
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate #xj mod
            END IF 
         END IF
         LET sr.l_cnt2 = sr.l_cnt2 + l_tmp
       
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt2 = l_tmp*l_rate
#            END IF 
#         END IF     
       END FOREACH
       
       #-工單備料量 l_cnt3 
#       LET l_sql = " SELECT (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)-COALESCE(sfba025,0)),sfba014 FROM sfaa_t,sfba_t ",
#       LET l_sql = " SELECT DECODE(SIGN(COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+DECODE((COALESCE(sfba017,0)),0,COALESCE(sfba017,0),(COALESCE(sfba017,0)-COALESCE(sfba025,0)))),-1,0,",
#                   "(COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+DECODE((COALESCE(sfba017,0)),0,COALESCE(sfba017,0),(COALESCE(sfba017,0)-COALESCE(sfba025,0))))),sfba014 ",
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+DECODE(SIGN(COALESCE(sfba017,0)-COALESCE(sfba025,0)),-1,0,(COALESCE(sfba017,0)-COALESCE(sfba025,0)))),sfba014 ",
       #            " FROM sfaa_t,sfba_t ",   --2015-1-16 zj mod 工單超領
       #            "  WHERE sfaaent = sfbaent ", 
       #            "    AND sfaadocno = sfbadocno ",
       #            "    AND sfaaent = '",g_enterprise,"'",
       #            "    AND sfaasite = '",g_site,"'",
       #            "    AND sfba006 = '",sr.inaj005 CLIPPED ,"'",
       #            "    AND sfaa003 <> '4' ",
       #            "    AND sfaastus <> 'X' ",
       #            "    AND sfaastus <> 'C'",
       #            "    AND sfaastus <> 'M'",
       #            "    AND sfaa057 = '1' "
#      #             " GROUP BY sfaa006 "      
#      # SELECT sfba014 INTO l_inag007 FROM sfba_t WHERE sfba006 = sr.inaj005 AND sfbaent = g_enterprise AND sfbasite = g_site
       #PREPARE ainr020_sfba_pre FROM l_sql
       #DECLARE ainr020_sfba_cur CURSOR FOR ainr020_sfba_pre
       #FOREACH ainr020_sfba_cur INTO l_tmp,l_inag007
       #160505-00014#1---mark---end---
       FOREACH ainr020_sfba_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN   #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate     #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp)  RETURNING l_success,l_tmp #xj mod
            
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate  #xj mod
            END IF 
         END IF
         LET sr.l_cnt3 = sr.l_cnt3 + l_tmp  
       
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt3 = l_tmp*l_rate
#            END IF 
#         END IF     
       END FOREACH                              
       
       #+請購量 l_cnt4
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),pmdb007 FROM pmda_t,pmdb_t ",
       #            "  WHERE pmdaent = pmdbent ",
       #            "    AND pmdasite = '",g_site,"'",
       #            "    AND pmdadocno = pmdbdocno ",
       #            "    AND pmdb004 = '",sr.inaj005,"'", 
       #            "    AND pmdb006 <> pmdb049 ",
       #            "    AND pmdb032 NOT IN ('2','3','4') ",  #150112
       #            "    AND pmdastus <> 'X' AND pmdastus <> 'C' "
       #
       #PREPARE ainr020_pmdb_pre FROM l_sql
       #DECLARE ainr020_pmdb_cur CURSOR FOR ainr020_pmdb_pre
       #FOREACH ainr020_pmdb_cur INTO l_tmp,l_inag007
       #160505-00014#1---mark---end---
       FOREACH ainr020_pmdb_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate    #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp)  RETURNING l_success,l_tmp
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate   #xj mod
            END IF 
         END IF
         LET sr.l_cnt4 = sr.l_cnt4 + l_tmp    
       
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt4 = l_tmp*l_rate
#            END IF 
#         END IF  
       END FOREACH                
       
       #+採購量 l_cnt5
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),pmdo004 FROM pmdl_t,pmdo_t,pmdn_t ",
       #            "  WHERE pmdlent = pmdoent ",
       #            "    AND pmdosite = '",g_site,"'",
       #            "    AND pmdldocno = pmdodocno ",
       #            "    AND pmdo001 = '",sr.inaj005,"'", 
       #            #150112 by zj add start
       #            "    AND pmdnent = pmdlent ",
       #            "    AND pmdnsite = pmdlsite ",
       #            "    AND pmdndocno = pmdldocno ",
       #            "    AND pmdnseq = pmdoseq ",
       #            "    AND pmdn045 NOT IN ('2','3','4') ",
       #            #150104 by zj add end   
       #            "    AND pmdlstus <> 'X' AND pmdlstus <> 'C' ",
       #            "    AND pmdl005 <> '2' "   #add by zj 20150203
       #
       #PREPARE ainr020_pmdo_pre FROM l_sql
       #DECLARE ainr020_pmdo_cur CURSOR FOR ainr020_pmdo_pre
       #FOREACH ainr020_pmdo_cur INTO l_tmp,l_inag007
       #160505-00014#1---mark---end---
       FOREACH ainr020_pmdo_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate     #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp) RETURNING l_success,l_tmp
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate  #xj mod
            END IF 
         END IF
         LET sr.l_cnt5 = sr.l_cnt5 + l_tmp    
                
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt5 = l_tmp*l_rate
#            END IF 
#         END IF  
       END FOREACH  

       #+工單在測量 l_cnt6
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),sfaa013 FROM sfaa_t ",
       #            "  WHERE sfaaent = '",g_enterprise,"'",
       #            "    AND sfaasite = '",g_site,"'",
       #            "    AND sfaa010 = '",sr.inaj005,"'",
       #            "    AND sfaa003 <> '4' ",
       #            "    AND sfaastus <> 'X'",
       #            "    AND sfaastus <> 'C'",
       #            "    AND sfaastus <> 'M'",
       #            "    AND sfaa057 = '1' "
#      #             " GROUP BY sfaa010 "
#      # SELECT sfaa013 INTO l_inag007 FROM sfaa_t WHERE sfaa010 = sr.inaj005 AND sfaaent = g_enterprise AND sfaasite = g_site
       #PREPARE ainr020_sfaa_pre FROM l_sql
       #DECLARE ainr020_sfaa_cur CURSOR FOR ainr020_sfaa_pre
       #FOREACH ainr020_sfaa_cur INTO l_tmp,l_inag007
       #160505-00014#1---mark---end---
       FOREACH ainr020_sfaa_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate    #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp) RETURNING l_success,l_tmp
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate   #xj mod 
            END IF 
         END IF
         LET sr.l_cnt6 = sr.l_cnt6 + l_tmp   
                
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt6 = l_tmp*l_rate
#            END IF 
#         END IF  
       END FOREACH  
       
       #+委外在制量 l_cnt7
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),sfaa013 FROM sfaa_t ",
       #            "  WHERE sfaaent = '",g_enterprise,"'",
       #            "    AND sfaasite = '",g_site,"'",               
       #            "    AND sfaa010 = '",sr.inaj005,"'",
       #            "    AND sfaa003 <> '4' ",
       #            "    AND sfaastus <> 'X'",
       #            "    AND sfaastus <> 'C'",
       #            "    AND sfaastus <> 'M'",
       #            "    AND sfaa057 = '2' "
#      #             " GROUP BY sfaa010 "
--     #  SELECT sfaa013 INTO l_inag007 FROM sfaa_t WHERE sfaa010 = sr.inaj005 AND sfaaent = g_enterprise AND sfaasite = g_site
       #PREPARE ainr020_sfaa2_pre FROM l_sql
       #DECLARE ainr020_sfaa2_cur CURSOR FOR ainr020_sfaa2_pre
       #FOREACH ainr020_sfaa2_cur INTO l_tmp,l_inag007
       #160505-00014#1---mark---end---
       FOREACH ainr020_sfaa2_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate    #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp)  RETURNING l_success,l_tmp
            
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate    #xj mod
            END IF 
         END IF
         LET sr.l_cnt7 = sr.l_cnt7 + l_tmp 
                
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt7 = l_tmp*l_rate
#            END IF 
#         END IF  
       END FOREACH   
       
       #+IQC在驗量 l_cnt8
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),pmdt019,pmds011,pmds000 FROM pmds_t,pmdt_t ",
       #            "  WHERE pmdsent = pmdtent ",
       #            "    AND pmdssite = '",g_site,"'",
       #            "    AND pmdsdocno = pmdtdocno ",
#      #             "    AND pmds000 IN ('1','2','3','4','8','12') ",
       #            "    AND pmds000 IN ('1','2','8') ",
       #            "    AND pmds011 IN ('1','2','3','7','8','9','10')",
       #            "    AND pmdsstus = 'Y' ",
       #            "    AND pmdt006 = '",sr.inaj005,"'",
       #            "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 "
       #
       #SELECT pmdt019 INTO l_inag007 FROM pmdt_t WHERE pmdt006 = sr.inaj005 AND pmdtent = g_enterprise AND pmdtsite = g_site
       #PREPARE ainr020_pmdt_pre FROM l_sql
       #DECLARE ainr020_pmdt_cur CURSOR FOR ainr020_pmdt_pre
       #FOREACH ainr020_pmdt_cur INTO l_tmp,l_inag007,l_pmds011,l_pmds000
       #160505-00014#1---mark---end---
       FOREACH ainr020_pmdt_cur USING sr.inaj005 INTO l_tmp,l_inag007,l_pmds011,l_pmds000  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate     #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp) RETURNING l_success,l_tmp
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate  #xj mod
            END IF 
         END IF
         
       -----2015-2-9  zj mod ----
       #委外在制量=委外在制量-IQC委外采购在验量   
         IF l_pmds011 = '2' AND l_pmds000 = '8' THEN
            LET sr.l_cnt10 = sr.l_cnt10 + l_tmp
            LET sr.l_cnt7 = sr.l_cnt7 - l_tmp
         ELSE 
            LET sr.l_cnt8 = sr.l_cnt8 + l_tmp    
         END IF
       -----2015-2-9  zj mod ----       
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt8 = l_tmp*l_rate
#            END IF 
#         END IF  
       END FOREACH    
    
               
       #+FQC在驗量 l_cnt9
       #160505-00014#1---mark---begin---
       #LET l_sql = " SELECT (COALESCE(qcba017,0)-COALESCE(qcba023,0)),qcba016 FROM qcba_t ",
       #            "  WHERE qcbaent = '",g_enterprise,"'",
       #            "    AND qcbasite = '",g_site,"'",
       #            "    AND qcba000 = '2' ",
       #            "    AND qcbastus = 'Y' ",
       #            "    AND qcba010 = '",sr.inaj005,"'"
#      #             "  GROUP BY qcba010 "
#      # SELECT qcba016 INTO l_inag007 FROM qcba_t WHERE qcba010 = sr.inaj005 AND qcbaent = g_enterprise AND qcbasite = g_site
       #PREPARE ainr020_qcba_pre FROM l_sql
       #DECLARE ainr020_qcba_cur CURSOR FOR ainr020_qcba_pre
       #FOREACH ainr020_qcba_cur INTO l_tmp,l_inag007
       #160505-00014#1---mark---end---
       FOREACH ainr020_qcba_cur USING sr.inaj005 INTO l_tmp,l_inag007  #160505-00014#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()    
            EXIT FOREACH
         END IF  
         #IF (NOT cl_null(l_inag007) )AND (NOT cl_null(sr.inag007) )THEN  #160505-00014#1 mark
         IF (NOT cl_null(l_inag007) ) AND (NOT cl_null(sr.inag007) ) AND (l_inag007 <> sr.inag007 ) THEN  #160505-00014#1 mark
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate    #xj mod
            CALL s_aooi250_convert_qty(sr.inaj005,l_inag007,sr.inag007,l_tmp) RETURNING  l_success,l_tmp
            IF l_success THEN
#               LET l_tmp = l_tmp*l_rate           #xj mod
            END IF 
         END IF
         LET sr.l_cnt9 = sr.l_cnt9 + l_tmp     
                
#         IF NOT cl_null(l_inag007) AND NOT cl_null(sr.inag007) THEN
#            CALL s_aimi190_get_convert(sr.inaj005,l_inag007,sr.inag007) RETURNING l_success,l_rate   
#            IF l_success THEN
#               LET sr.l_cnt9 = l_tmp*l_rate
#            END IF 
#         END IF  
       END FOREACH                 
 
       #=預計結存量 l_left
       LET sr.l_left = sr.l_cnt1 - sr.l_cnt2 - sr.l_cnt3 + sr.l_cnt4 + sr.l_cnt5 + sr.l_cnt6 + sr.l_cnt7 + sr.l_cnt8 + sr.l_cnt10 + sr.l_cnt9
              
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inaj005,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.l_cnt1,sr.l_cnt2,sr.l_cnt3,sr.l_cnt4,sr.l_cnt5,sr.l_cnt6,sr.l_cnt7,sr.l_cnt8,sr.l_cnt10,sr.l_cnt9,sr.l_left
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr020_x01_execute"
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
 
{<section id="ainr020_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr020_x01_rep_data()
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
 
{<section id="ainr020_x01.other_function" readonly="Y" >}

 
{</section>}
 
