#該程式未解開Section, 採用最新樣板產出!
{<section id="afmr580_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-04 16:21:02), PR版次:0003(2016-05-06 09:33:16)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: afmr580_g01
#+ Description: ...
#+ Creator....: 02159(2015-11-20 16:51:32)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="afmr580_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160122-00001#21   16/02/15   By yangtt  添加交易帳戶編號用戶權限空管 
#160414-00018#22   16/05/05   By 06821   效能調整
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
   fmmv001 LIKE fmmv_t.fmmv001, 
   fmmv002 LIKE fmmv_t.fmmv002, 
   fmmv003 LIKE fmmv_t.fmmv003, 
   fmmv004 LIKE fmmv_t.fmmv004, 
   fmmv005 LIKE fmmv_t.fmmv005, 
   fmmv006 LIKE fmmv_t.fmmv006, 
   fmmv007 LIKE fmmv_t.fmmv007, 
   fmmv010 LIKE fmmv_t.fmmv010, 
   fmmv011 LIKE fmmv_t.fmmv011, 
   fmmv012 LIKE fmmv_t.fmmv012, 
   fmmv013 LIKE fmmv_t.fmmv013, 
   fmmv014 LIKE fmmv_t.fmmv014, 
   fmmv015 LIKE fmmv_t.fmmv015, 
   fmmvdocdt LIKE fmmv_t.fmmvdocdt, 
   fmmvdocno LIKE fmmv_t.fmmvdocno, 
   fmmvent LIKE fmmv_t.fmmvent, 
   fmmvsite LIKE fmmv_t.fmmvsite, 
   fmmvstus LIKE fmmv_t.fmmvstus, 
   l_fmndseq LIKE fmnd_t.fmndseq, 
   l_fmnd001 LIKE fmnd_t.fmnd001, 
   l_fmnd008 LIKE fmnd_t.fmnd008, 
   l_fmnd002 LIKE fmnd_t.fmnd002, 
   l_fmnd003 LIKE fmnd_t.fmnd003, 
   l_fmnd004 LIKE fmnd_t.fmnd004, 
   l_fmnd011 LIKE fmnd_t.fmnd011, 
   l_fmmvsite_desc LIKE type_t.chr100, 
   l_fmmv015_desc LIKE type_t.chr100, 
   l_fmmj027 LIKE fmmj_t.fmmj027, 
   l_fmmv007_desc LIKE type_t.chr100, 
   l_fmmv013_desc LIKE type_t.chr100, 
   l_fmmv012_desc LIKE type_t.chr100, 
   l_fmmv011_desc LIKE type_t.chr100, 
   l_fmnd001_desc LIKE type_t.chr100, 
   l_fmnd008_desc LIKE type_t.chr100
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
 TYPE sr3_r RECORD
   l_sum_fmnd011  LIKE fmnd_t.fmnd011
END RECORD
DEFINE g_sql_bank       STRING #160122-00001#22 add by07675
#end add-point
 
{</section>}
 
{<section id="afmr580_g01.main" readonly="Y" >}
PUBLIC FUNCTION afmr580_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #160122-00001#22--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#22--add--end
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "afmr580_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afmr580_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afmr580_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afmr580_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afmr580_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmr580_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160414-00018#22 --s add
   LET g_select = " SELECT fmmv001,fmmv002,fmmv003,fmmv004,fmmv005,fmmv006,fmmv007,fmmv010,fmmv011,fmmv012, ", 
                  "        fmmv013,fmmv014,fmmv015,fmmvdocdt,fmmvdocno,fmmvent,fmmvsite,fmmvstus, ",
                  "        fmndseq,fmnd001,fmnd008,fmnd002,fmnd003,fmnd004, ",
                  "        CASE WHEN fmndseq IS NOT NULL AND fmnd011 IS NULL THEN 0 ELSE fmnd011 END, ",
                  #投資組織
                  "        CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = fmmvent AND ooefl001 = fmmvsite AND ooefl002 = '",g_dlang,"') IS NULL  ",    
                  "             THEN fmmvsite ELSE (SELECT fmmvsite||'.'||ooefl003 FROM ooefl_t WHERE ooeflent = fmmvent AND ooefl001 = fmmvsite AND ooefl002 = '",g_dlang,"') END, ",
                  #收息來源
                  "        CASE WHEN (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8807' AND gzcbl002 = fmmv015 AND gzcbl003 = '",g_dlang,"') IS NULL ",      
                  "             THEN fmmv015 ELSE (SELECT fmmv015||':'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8807' AND gzcbl002 = fmmv015 AND gzcbl003 = '",g_dlang,"') END, ",
                  "        (SELECT fmmj027 FROM fmmj_t WHERE fmmvent = fmmjent AND fmmv001 = fmmjdocno) l_fmmj027, ",
                  #收息方式
                  "        CASE WHEN (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8806' AND gzcbl002 = fmmv007 AND gzcbl003 = '",g_dlang,"') IS NULL ",         
                  "             THEN fmmv007 ELSE (SELECT fmmv007||':'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8806' AND gzcbl002 = fmmv007 AND gzcbl003 = '",g_dlang,"') END, ",
                  #收息帳戶
                  "        CASE WHEN (SELECT nmaal003 FROM nmas_t LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' WHERE nmasent = fmmvent AND nmas002 = fmmv013) IS NULL ", 
                  "             THEN fmmv013 ELSE (SELECT fmmv013||'.'||nmaal003 FROM nmas_t LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' WHERE nmasent = fmmvent AND nmas002 = fmmv013) END, ", 
                  #存提碼
                  "        CASE WHEN (SELECT nmajl003 FROM nmajl_t WHERE nmajlent = fmmvent AND nmajl001 = fmmv012 AND nmajl002 = '",g_dlang,"') IS NULL ",      
                  "             THEN fmmv012 ELSE (SELECT fmmv012||'.'||nmajl003 FROM nmajl_t WHERE nmajlent = fmmvent AND nmajl001 = fmmv012 AND nmajl002 = '",g_dlang,"') END, ",
                  #現金碼
                  "        CASE WHEN (SELECT nmail004 FROM nmail_t WHERE nmailent = fmmvent AND nmail001 IN(SELECT glaa005 FROM glaa_t WHERE glaaent = fmmvent", 
                  "                      AND glaald IN (SELECT glaald FROM glaa_t,ooef_t WHERE glaaent = ooefent AND glaacomp = ooef017 AND ooef001 = fmmvsite AND ooefent = fmmvent AND glaa014 = 'Y'))  ",
                  "                      AND nmail002 = fmmv011 AND nmail003 = '",g_dlang,"') IS NULL ",
                  "             THEN fmmv011 ELSE (SELECT fmmv011||'.'||nmail004 FROM nmail_t WHERE nmailent = fmmvent ", 
                  "                                   AND nmail001 IN(SELECT glaa005 FROM glaa_t WHERE glaaent = fmmvent ",
                  "                                                      AND glaald IN (SELECT glaald FROM glaa_t,ooef_t WHERE glaaent = ooefent AND glaacomp = ooef017 AND ooef001 = fmmvsite AND ooefent = fmmvent AND glaa014 = 'Y'))  ",
                  "                                   AND nmail002 = fmmv011 AND nmail003 = '",g_dlang,"') END, ", 
                  #費用類型
                  "        CASE WHEN (SELECT fmmcl003 FROM fmmc_t  ",                                                                                            
                  "                     LEFT OUTER JOIN fmmcl_t ON fmmclent = fmmcent AND fmmcl001 = fmmc001 AND fmmcl002 = '",g_dlang,"' ",
                  "                    WHERE fmmcent = fmmvent AND fmmc001 = fmnd001) IS NULL ", 
                  "             THEN fmnd001 ELSE (SELECT fmnd001||'.'||fmmcl003 FROM fmmc_t  ",                                                                                           
                  "                     LEFT OUTER JOIN fmmcl_t ON fmmclent = fmmcent AND fmmcl001 = fmmc001 AND fmmcl002 = '",g_dlang,"' ",
                  "                    WHERE fmmcent = fmmvent AND fmmc001 = fmnd001) END , ",
                  #支付帳戶
                  "        CASE WHEN (SELECT nmaal003 FROM nmas_t ",                                                                                             
                  "                     LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ",
                  "                    WHERE nmasent = fmmvent ",
                  "                      AND nmas002 = fmnd008) IS NULL ",
                  "             THEN fmnd008 ELSE (SELECT nmaal003 FROM nmas_t ",                                                                              
                  "                                  LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ",
                  "                                 WHERE nmasent = fmmvent AND nmas002 = fmnd008) END "
   #160414-00018#22 --e add
   
   #160414-00018#22 --s mark
   #LET g_select = " SELECT t0.fmmv001,t0.fmmv002,t0.fmmv003,t0.fmmv004,t0.fmmv005,t0.fmmv006,t0.fmmv007,t0.fmmv010,t0.fmmv011,t0.fmmv012, ", 
   #               "        t0.fmmv013,t0.fmmv014,t0.fmmv015,t0.fmmvdocdt,t0.fmmvdocno,t0.fmmvent,t0.fmmvsite,t0.fmmvstus, ",
   #               "        t1.fmndseq,t1.fmnd001,t1.fmnd008,t1.fmnd002,t1.fmnd003,t1.fmnd0`04,t1.fmnd011, ", 
   #               "        '',t3.gzcbl004,t2.fmmj027,t4.gzcbl004,'','','','',''"
   #160414-00018#22 --e mark
#   #end add-point
#   LET g_select = " SELECT fmmv001,fmmv002,fmmv003,fmmv004,fmmv005,fmmv006,fmmv007,fmmv010,fmmv011,fmmv012, 
#       fmmv013,fmmv014,fmmv015,fmmvdocdt,fmmvdocno,fmmvent,fmmvsite,fmmvstus,NULL,'','','',NULL,NULL, 
#       NULL,'','','','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    #160414-00018#22 --s add
    LET g_from = " FROM fmmv_t ", 
                 " LEFT OUTER JOIN fmnd_t ON fmmvent = fmndent AND fmmvdocno = fmnddocno "
    #160414-00018#22 --e add
    
    #160414-00018#22 --s mark
    #LET g_from = " FROM fmmv_t t0 ",
    #             " LEFT OUTER JOIN fmnd_t t1 ON t0.fmmvent = t1.fmndent AND t0.fmmvdocno = t1.fmnddocno ",
    #             " LEFT OUTER JOIN fmmj_t t2 ON t0.fmmvent = t2.fmmjent AND t0.fmmv001 = t2.fmmjdocno ",
    #             " LEFT OUTER JOIN gzcbl_t t3 ON t3.gzcbl001 = '8807' AND t3.gzcbl002 = t0.fmmv015 AND t3.gzcbl003 = '",g_dlang,"'",
    #             " LEFT OUTER JOIN gzcbl_t t4 ON t4.gzcbl001 = '8806' AND t4.gzcbl002 = t0.fmmv007 AND t4.gzcbl003 = '",g_dlang,"'"
    #160414-00018#22 --e mark
#   #end add-point
#    LET g_from = " FROM fmmv_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #160414-00018#22 --s add
   LET g_where = g_where CLIPPED," AND (fmmv013 IN(",g_sql_bank,") OR TRIM(fmmv013) IS NULL)",
                                 " AND (fmnd008 IN(",g_sql_bank,") OR TRIM(fmnd008) IS NULL)"
                                 
   #160414-00018#22 --e add
   
   #160122-00001#22--add---str
#   LET g_where = g_where CLIPPED," AND (t0.fmmv013 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') OR t0.fmmv013 IS NULL)",
#                 " AND (t1.fmnd008 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') OR t1.fmnd008 IS NULL)"
   #160414-00018#22 --s mark
   #LET g_where = g_where CLIPPED," AND (t0.fmmv013 IN(",g_sql_bank,") OR TRIM(t0.fmmv013) IS NULL)",
   #                              " AND (t1.fmnd008 IN(",g_sql_bank,") OR TRIM(t1.fmnd008) IS NULL)" #160122-00001#22 mod by 07675
   #160414-00018#22 --s mark
   #160122-00001#22--add---end
   #end add-point
    LET g_order = " ORDER BY fmmvdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fmmv_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afmr580_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afmr580_g01_curs CURSOR FOR afmr580_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afmr580_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afmr580_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fmmv001 LIKE fmmv_t.fmmv001, 
   fmmv002 LIKE fmmv_t.fmmv002, 
   fmmv003 LIKE fmmv_t.fmmv003, 
   fmmv004 LIKE fmmv_t.fmmv004, 
   fmmv005 LIKE fmmv_t.fmmv005, 
   fmmv006 LIKE fmmv_t.fmmv006, 
   fmmv007 LIKE fmmv_t.fmmv007, 
   fmmv010 LIKE fmmv_t.fmmv010, 
   fmmv011 LIKE fmmv_t.fmmv011, 
   fmmv012 LIKE fmmv_t.fmmv012, 
   fmmv013 LIKE fmmv_t.fmmv013, 
   fmmv014 LIKE fmmv_t.fmmv014, 
   fmmv015 LIKE fmmv_t.fmmv015, 
   fmmvdocdt LIKE fmmv_t.fmmvdocdt, 
   fmmvdocno LIKE fmmv_t.fmmvdocno, 
   fmmvent LIKE fmmv_t.fmmvent, 
   fmmvsite LIKE fmmv_t.fmmvsite, 
   fmmvstus LIKE fmmv_t.fmmvstus, 
   l_fmndseq LIKE fmnd_t.fmndseq, 
   l_fmnd001 LIKE fmnd_t.fmnd001, 
   l_fmnd008 LIKE fmnd_t.fmnd008, 
   l_fmnd002 LIKE fmnd_t.fmnd002, 
   l_fmnd003 LIKE fmnd_t.fmnd003, 
   l_fmnd004 LIKE fmnd_t.fmnd004, 
   l_fmnd011 LIKE fmnd_t.fmnd011, 
   l_fmmvsite_desc LIKE type_t.chr100, 
   l_fmmv015_desc LIKE type_t.chr100, 
   l_fmmj027 LIKE fmmj_t.fmmj027, 
   l_fmmv007_desc LIKE type_t.chr100, 
   l_fmmv013_desc LIKE type_t.chr100, 
   l_fmmv012_desc LIKE type_t.chr100, 
   l_fmmv011_desc LIKE type_t.chr100, 
   l_fmnd001_desc LIKE type_t.chr100, 
   l_fmnd008_desc LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_glaald    LIKE glaa_t.glaald    #組織所屬法人主帳套
   DEFINE l_glaa005   LIKE glaa_t.glaa005
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH afmr580_g01_curs INTO sr_s.*
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
       #160414-00018#22 --s mark
       #IF NOT cl_null(sr_s.l_fmndseq) AND cl_null(sr_s.l_fmnd011) THEN
       #   LET sr_s.l_fmnd011 = 0
       #END IF
       ##投資組織
       #CALL s_desc_get_department_desc(sr_s.fmmvsite) RETURNING sr_s.l_fmmvsite_desc
       #CALL afmr580_g01_desc_show(sr_s.fmmvsite,sr_s.l_fmmvsite_desc) RETURNING sr_s.l_fmmvsite_desc
       ##收息來源
       #IF cl_null(sr_s.l_fmmv015_desc) THEN
       #   LET sr_s.l_fmmv015_desc = sr_s.fmmv015
       #ELSE
       #   LET sr_s.l_fmmv015_desc = sr_s.fmmv015,":",sr_s.l_fmmv015_desc
       #END IF
       ##收息方式
       #IF cl_null(sr_s.l_fmmv007_desc) THEN
       #   LET sr_s.l_fmmv007_desc = sr_s.fmmv007
       #ELSE
       #   LET sr_s.l_fmmv007_desc = sr_s.fmmv007,":",sr_s.l_fmmv007_desc       
       #END IF       
       ##收息帳戶
       #CALL s_desc_get_nmas002_desc(sr_s.fmmv013) RETURNING sr_s.l_fmmv013_desc
       #CALL afmr580_g01_desc_show(sr_s.fmmv013,sr_s.l_fmmv013_desc) RETURNING sr_s.l_fmmv013_desc     
       ##存提碼
       #CALL s_desc_get_nmajl003_desc(sr_s.fmmv012) RETURNING sr_s.l_fmmv012_desc
       #CALL afmr580_g01_desc_show(sr_s.fmmv012,sr_s.l_fmmv012_desc) RETURNING sr_s.l_fmmv012_desc
       ##抓組織所屬法人主帳套
       #LET l_glaald = ''
       #SELECT glaald INTO l_glaald 
       #  FROM glaa_t,ooef_t
       # WHERE glaaent = ooefent
       #   AND glaacomp = ooef017
       #   AND ooef001 = sr_s.fmmvsite
       #   AND ooefent = g_enterprise
       #   AND glaa014 = 'Y'
       #   
       #LET l_glaa005 = ''
       #SELECT glaa005 INTO l_glaa005
       #  FROM glaa_t
       # WHERE glaald = l_glaald 
       #   AND glaaent = g_enterprise         
       ##現金碼
       #CALL s_desc_get_nmail004_desc(l_glaa005,sr_s.fmmv011) RETURNING sr_s.l_fmmv011_desc
       #CALL afmr580_g01_desc_show(sr_s.fmmv011,sr_s.l_fmmv011_desc) RETURNING sr_s.l_fmmv011_desc
       ##費用類型
       #CALL s_desc_fmmc001_desc(sr_s.l_fmnd001) RETURNING sr_s.l_fmnd001_desc
       #CALL afmr580_g01_desc_show(sr_s.l_fmnd001,sr_s.l_fmnd001_desc) RETURNING sr_s.l_fmnd001_desc
       ##支付帳戶
       #CALL s_desc_get_nmas002_desc(sr_s.l_fmnd008) RETURNING sr_s.l_fmnd008_desc
       #CALL afmr580_g01_desc_show(sr_s.l_fmnd008,sr_s.l_fmnd008_desc) RETURNING sr_s.l_fmnd008_desc
       #160414-00018#22 --e mark
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fmmv001 = sr_s.fmmv001
       LET sr[l_cnt].fmmv002 = sr_s.fmmv002
       LET sr[l_cnt].fmmv003 = sr_s.fmmv003
       LET sr[l_cnt].fmmv004 = sr_s.fmmv004
       LET sr[l_cnt].fmmv005 = sr_s.fmmv005
       LET sr[l_cnt].fmmv006 = sr_s.fmmv006
       LET sr[l_cnt].fmmv007 = sr_s.fmmv007
       LET sr[l_cnt].fmmv010 = sr_s.fmmv010
       LET sr[l_cnt].fmmv011 = sr_s.fmmv011
       LET sr[l_cnt].fmmv012 = sr_s.fmmv012
       LET sr[l_cnt].fmmv013 = sr_s.fmmv013
       LET sr[l_cnt].fmmv014 = sr_s.fmmv014
       LET sr[l_cnt].fmmv015 = sr_s.fmmv015
       LET sr[l_cnt].fmmvdocdt = sr_s.fmmvdocdt
       LET sr[l_cnt].fmmvdocno = sr_s.fmmvdocno
       LET sr[l_cnt].fmmvent = sr_s.fmmvent
       LET sr[l_cnt].fmmvsite = sr_s.fmmvsite
       LET sr[l_cnt].fmmvstus = sr_s.fmmvstus
       LET sr[l_cnt].l_fmndseq = sr_s.l_fmndseq
       LET sr[l_cnt].l_fmnd001 = sr_s.l_fmnd001
       LET sr[l_cnt].l_fmnd008 = sr_s.l_fmnd008
       LET sr[l_cnt].l_fmnd002 = sr_s.l_fmnd002
       LET sr[l_cnt].l_fmnd003 = sr_s.l_fmnd003
       LET sr[l_cnt].l_fmnd004 = sr_s.l_fmnd004
       LET sr[l_cnt].l_fmnd011 = sr_s.l_fmnd011
       LET sr[l_cnt].l_fmmvsite_desc = sr_s.l_fmmvsite_desc
       LET sr[l_cnt].l_fmmv015_desc = sr_s.l_fmmv015_desc
       LET sr[l_cnt].l_fmmj027 = sr_s.l_fmmj027
       LET sr[l_cnt].l_fmmv007_desc = sr_s.l_fmmv007_desc
       LET sr[l_cnt].l_fmmv013_desc = sr_s.l_fmmv013_desc
       LET sr[l_cnt].l_fmmv012_desc = sr_s.l_fmmv012_desc
       LET sr[l_cnt].l_fmmv011_desc = sr_s.l_fmmv011_desc
       LET sr[l_cnt].l_fmnd001_desc = sr_s.l_fmnd001_desc
       LET sr[l_cnt].l_fmnd008_desc = sr_s.l_fmnd008_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmr580_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afmr580_g01_rep_data()
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
          START REPORT afmr580_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afmr580_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afmr580_g01_rep
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
 
{<section id="afmr580_g01.rep" readonly="Y" >}
PRIVATE REPORT afmr580_g01_rep(sr1)
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
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.fmmvdocno,sr1.l_fmndseq
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
        BEFORE GROUP OF sr1.fmmvdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fmmvdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fmmvent=' ,sr1.fmmvent,'{+}fmmvdocno=' ,sr1.fmmvdocno         
            CALL cl_gr_init_apr(sr1.fmmvdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fmmvdocno.before name="rep.b_group.fmmvdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fmmvent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmvdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr580_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afmr580_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afmr580_g01_subrep01
           DECLARE afmr580_g01_repcur01 CURSOR FROM g_sql
           FOREACH afmr580_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr580_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afmr580_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afmr580_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fmmvdocno.after name="rep.b_group.fmmvdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_fmndseq
 
           #add-point:rep.b_group.l_fmndseq.before name="rep.b_group.l_fmndseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_fmndseq.after name="rep.b_group.l_fmndseq.after"
           
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
                sr1.fmmvent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmvdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_fmndseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr580_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afmr580_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afmr580_g01_subrep02
           DECLARE afmr580_g01_repcur02 CURSOR FROM g_sql
           FOREACH afmr580_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr580_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afmr580_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afmr580_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.fmmvent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmvdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_fmndseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr580_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afmr580_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afmr580_g01_subrep03
           DECLARE afmr580_g01_repcur03 CURSOR FROM g_sql
           FOREACH afmr580_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr580_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afmr580_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afmr580_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmmvdocno
 
           #add-point:rep.a_group.fmmvdocno.before name="rep.a_group.fmmvdocno.before"
           START REPORT afmr580_g01_subrep05
           IF NOT cl_null(sr1.l_fmndseq)THEN
              LET g_sql = "SELECT SUM(COALESCE(fmnd011,0)) ", 
                          "  FROM fmnd_t ",
                          " WHERE fmndent = '",sr1.fmmvent CLIPPED,"'",
						        "   AND fmnddocno = '",sr1.fmmvdocno CLIPPED,"'",
                          " GROUP by fmnddocno "
              DECLARE afmr580_g01_repcur05 CURSOR FROM g_sql
              FOREACH afmr580_g01_repcur05 INTO sr3.*
                 OUTPUT TO REPORT afmr580_g01_subrep05(sr3.*)
              END FOREACH
           END IF
           FINISH REPORT afmr580_g01_subrep05
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fmmvent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmvdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr580_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afmr580_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afmr580_g01_subrep04
           DECLARE afmr580_g01_repcur04 CURSOR FROM g_sql
           FOREACH afmr580_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr580_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afmr580_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afmr580_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fmmvdocno.after name="rep.a_group.fmmvdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_fmndseq
 
           #add-point:rep.a_group.l_fmndseq.before name="rep.a_group.l_fmndseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_fmndseq.after name="rep.a_group.l_fmndseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afmr580_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afmr580_g01_subrep01(sr2)
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
PRIVATE REPORT afmr580_g01_subrep02(sr2)
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
PRIVATE REPORT afmr580_g01_subrep03(sr2)
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
PRIVATE REPORT afmr580_g01_subrep04(sr2)
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
 
{<section id="afmr580_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 字串顯示方式
# Memo...........: 部門編號.部門名稱>例如:DC0300.資訊部
# Usage..........: CALL afmr580_g01_desc_show(p_field,p_desc)
#                  RETURNING r_desc
# Input parameter: p_field   欄位代號
#                : p_desc    欄位代號+說明欄位
# Return code....: r_desc
# Date & Author..: 2015/11/23 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION afmr580_g01_desc_show(p_field,p_desc)
DEFINE p_field   LIKE type_t.chr500
DEFINE p_desc    LIKE type_t.chr500
DEFINE r_desc    LIKE type_t.chr500

   IF cl_null(p_desc)THEN
      LET r_desc = p_field
   ELSE
      LET r_desc = p_field CLIPPED,'.',p_desc
   END IF

   RETURN r_desc
END FUNCTION

 
{</section>}
 
{<section id="afmr580_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 單身合計子報表
# Memo...........:
# Usage..........: CALL afmr580_g01_subrep05(sr3)
# Date & Author..: 2015/11/23 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT afmr580_g01_subrep05(sr3)
DEFINE sr3 sr3_r
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 
