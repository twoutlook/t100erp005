#該程式未解開Section, 採用最新樣板產出!
{<section id="afmr590_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-06 09:24:40), PR版次:0003(2016-05-09 10:00:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: afmr590_g01
#+ Description: ...
#+ Creator....: 02159(2015-11-10 19:03:03)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="afmr590_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#151126-00013#10   151218   By albireo 報表樣式修改
#160122-00001#21   160215   By yangtt  添加交易帳戶編號用戶權限空管    
#160414-00018#23   160506   By 06821   效能調整

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
   fmmy001 LIKE fmmy_t.fmmy001, 
   fmmy002 LIKE fmmy_t.fmmy002, 
   fmmy003 LIKE fmmy_t.fmmy003, 
   fmmy004 LIKE fmmy_t.fmmy004, 
   fmmy005 LIKE fmmy_t.fmmy005, 
   fmmy006 LIKE fmmy_t.fmmy006, 
   fmmy007 LIKE fmmy_t.fmmy007, 
   fmmy008 LIKE fmmy_t.fmmy008, 
   fmmy009 LIKE fmmy_t.fmmy009, 
   fmmy010 LIKE fmmy_t.fmmy010, 
   fmmy011 LIKE fmmy_t.fmmy011, 
   fmmy012 LIKE fmmy_t.fmmy012, 
   fmmy013 LIKE fmmy_t.fmmy013, 
   fmmy014 LIKE fmmy_t.fmmy014, 
   fmmy015 LIKE fmmy_t.fmmy015, 
   fmmy016 LIKE fmmy_t.fmmy016, 
   fmmy017 LIKE fmmy_t.fmmy017, 
   fmmy018 LIKE fmmy_t.fmmy018, 
   fmmy019 LIKE fmmy_t.fmmy019, 
   fmmy020 LIKE fmmy_t.fmmy020, 
   fmmy021 LIKE fmmy_t.fmmy021, 
   fmmy022 LIKE fmmy_t.fmmy022, 
   fmmy023 LIKE fmmy_t.fmmy023, 
   fmmydocdt LIKE fmmy_t.fmmydocdt, 
   fmmydocno LIKE fmmy_t.fmmydocno, 
   fmmyent LIKE fmmy_t.fmmyent, 
   fmmysite LIKE fmmy_t.fmmysite, 
   fmmystus LIKE fmmy_t.fmmystus, 
   l_fmmzseq LIKE fmmz_t.fmmzseq, 
   l_fmmz001 LIKE fmmz_t.fmmz001, 
   l_fmmz008 LIKE fmmz_t.fmmz008, 
   l_fmmz002 LIKE fmmz_t.fmmz002, 
   l_fmmz003 LIKE fmmz_t.fmmz003, 
   l_fmmz004 LIKE fmmz_t.fmmz004, 
   l_fmmz011 LIKE fmmz_t.fmmz011, 
   l_fmmj021 LIKE fmmj_t.fmmj021, 
   l_fmmj027 LIKE fmmj_t.fmmj027, 
   l_fmmz008_desc LIKE type_t.chr100, 
   l_fmmz001_desc LIKE type_t.chr100, 
   l_sum_fmmz011 LIKE fmmz_t.fmmz011, 
   l_fmmy008_desc LIKE type_t.chr100, 
   l_fmmy010_desc LIKE type_t.chr100, 
   l_fmmy011_desc LIKE type_t.chr100, 
   l_fmmysite_desc LIKE type_t.chr100, 
   fmmy028 LIKE fmmy_t.fmmy028, 
   fmmy029 LIKE fmmy_t.fmmy029, 
   l_fmmj002 LIKE type_t.chr30, 
   l_fmmj002_desc LIKE type_t.chr100
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
   l_sum_fmmz011  LIKE fmmz_t.fmmz011
END RECORD
DEFINE g_sql_bank       STRING #160122-00001#21 add by07675
#end add-point
 
{</section>}
 
{<section id="afmr590_g01.main" readonly="Y" >}
PUBLIC FUNCTION afmr590_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
 
#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #160122-00001#21--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#21--add--end
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "afmr590_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afmr590_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afmr590_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afmr590_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afmr590_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmr590_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #160414-00018#23 --s add
   LET g_select = " SELECT fmmy001,fmmy002,fmmy003,fmmy004,fmmy005,fmmy006,fmmy007,fmmy008,fmmy009,fmmy010, ",
                  "        fmmy011,fmmy012,fmmy013,fmmy014,fmmy015,fmmy016,fmmy017,fmmy018,fmmy019,fmmy020, ",
                  "        fmmy021,fmmy022,fmmy023,fmmydocdt,fmmydocno,fmmyent,fmmysite,fmmystus, ",
                  "        fmmzseq,fmmz001,fmmz008,fmmz002,fmmz003,fmmz004, ",
                  "        CASE WHEN fmmzseq IS NOT NULL AND fmmz011 IS NULL THEN 0 ELSE fmmz011 END, ",
                  "        (SELECT fmmj021 FROM fmmj_t WHERE fmmyent = fmmjent AND fmmy001 = fmmjdocno), ",
                  "        (SELECT fmmj027 FROM fmmj_t WHERE fmmyent = fmmjent AND fmmy001 = fmmjdocno), ",
                  #支付帳戶
                  "        CASE WHEN (SELECT nmaal003 FROM nmas_t ",
                  "                     LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ",
                  "                    WHERE nmasent = fmmzent AND nmas002 = fmmz008) IS NULL ",
                  "             THEN fmmz008 ELSE (SELECT fmmz008||'.'||nmaal003 FROM nmas_t ",
                  "                                  LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ",
                  "                                 WHERE nmasent = fmmzent AND nmas002 = fmmz008) END, ",
                  #費用類型
                  "        CASE WHEN (SELECT fmmcl003 FROM fmmc_t LEFT OUTER JOIN fmmcl_t ON fmmclent = fmmcent AND fmmcl001 = fmmc001 AND fmmcl002 = '",g_dlang,"' ",
                  "                    WHERE fmmcent = fmmzent AND fmmc001 = fmmz001 ) IS NULL  ",
                  "             THEN fmmz001 ELSE (SELECT fmmz001||'.'||fmmcl003 FROM fmmc_t  ",
                  "                                  LEFT OUTER JOIN fmmcl_t ON fmmclent = fmmcent AND fmmcl001 = fmmc001 AND fmmcl002 = '",g_dlang,"' ",
                  "                                 WHERE fmmcent = fmmzent AND fmmc001 = fmmz001 ) END, ",
                  "        0, ",
                  #收款方式
                  "        CASE WHEN (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8867' AND gzcbl002 =  fmmy008 AND gzcbl003 = '",g_dlang,"') IS NULL ",
                  "             THEN fmmy008 ELSE (SELECT fmmy008||':'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8867' AND gzcbl002 =  fmmy008 AND gzcbl003 = '",g_dlang,"') END, ",
                  #交易帳戶
                  "        CASE WHEN (SELECT nmaal003 FROM nmas_t LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ",
                  "                    WHERE nmasent = fmmyent AND nmas002 = fmmy010) IS NULL ",
                  "             THEN fmmy010 ELSE (SELECT fmmy010||'.'||nmaal003 FROM nmas_t ",
                  "                                  LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001 AND nmaal002 = '",g_dlang,"' ",
                  "                                 WHERE nmasent = fmmyent AND nmas002 = fmmy010) END, ",
                  #現金變動碼
                  "        CASE WHEN (SELECT nmail004 FROM nmail_t ",
                  "                    WHERE nmailent = fmmyent AND nmail002 = fmmy011 AND nmail003 = '",g_dlang,"' ",
                  "                      AND nmail001 IN (SELECT glaa005 FROM glaa_t ",
                  "                                        WHERE glaald IN (SELECT glaald FROM glaa_t,ooef_t WHERE glaaent = ooefent AND glaacomp = ooef017 ",
                  "                                                            AND ooef001 = fmmysite AND ooefent = fmmyent AND glaa014 = 'Y') ",
                  "                                          AND glaaent = fmmyent)) IS NULL ",
                  "             THEN fmmy011 ELSE (SELECT fmmy011||'.'||nmail004 FROM nmail_t ",
                  "                                 WHERE nmailent = fmmyent AND nmail002 = fmmy011 AND nmail003 = '",g_dlang,"' ",
                  "                                   AND nmail001 IN (SELECT glaa005 FROM glaa_t ",
                  "                                                     WHERE glaald IN (SELECT glaald FROM glaa_t,ooef_t WHERE glaaent = ooefent AND glaacomp = ooef017 ",
                  "                                                                         AND ooef001 = fmmysite AND ooefent = fmmyent AND glaa014 = 'Y') ",
                  "                                                       AND glaaent = fmmyent)) END , ",
                  #投資組織
                  "        CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = fmmyent AND ooefl001 = fmmysite AND ooefl002 = '",g_dlang,"') IS NULL ",
                  "             THEN fmmysite ELSE (SELECT fmmysite||'.'||ooefl003 FROM ooefl_t ",
                  "                                  WHERE ooeflent = fmmyent AND ooefl001 = fmmysite AND ooefl002 = '",g_dlang,"') END, ", 
                  "        fmmy028,fmmy029, ",
                  "        (SELECT fmmj002 FROM fmmj_t WHERE fmmyent = fmmjent AND fmmy001 = fmmjdocno), ",
                  #交易市場編號
                  "        (SELECT fmmel003 FROM fmmel_t WHERE fmmelent = fmmyent AND fmmel001 IN (SELECT fmmj002 FROM fmmj_t WHERE fmmyent = fmmjent AND fmmy001 = fmmjdocno) AND fmmel002 = '",g_dlang,"') "              
   #160414-00018#23 --e add
   
   #160414-00018#23 --s mark
   #LET g_select = " SELECT t0.fmmy001,t0.fmmy002,t0.fmmy003,t0.fmmy004,t0.fmmy005,t0.fmmy006,t0.fmmy007,t0.fmmy008,t0.fmmy009,t0.fmmy010, ",
   #               "        t0.fmmy011,t0.fmmy012,t0.fmmy013,t0.fmmy014,t0.fmmy015,t0.fmmy016,t0.fmmy017,t0.fmmy018,t0.fmmy019,t0.fmmy020, ",
   #               "        t0.fmmy021,t0.fmmy022,t0.fmmy023,t0.fmmydocdt,t0.fmmydocno,t0.fmmyent,t0.fmmysite,t0.fmmystus, ",
   #               "        t1.fmmzseq,t1.fmmz001,t1.fmmz008,t1.fmmz002,t1.fmmz003,t1.fmmz004,t1.fmmz011, ",
   #               "        t2.fmmj021,t2.fmmj027,'','',0,t3.gzcbl004,'','','', ",
   #               "        t0.fmmy028,t0.fmmy029,t2.fmmj002,'' "     #151126-00013#10 add
   #160414-00018#23 --e mark                  
#   #end add-point
#   LET g_select = " SELECT fmmy001,fmmy002,fmmy003,fmmy004,fmmy005,fmmy006,fmmy007,fmmy008,fmmy009,fmmy010, 
#       fmmy011,fmmy012,fmmy013,fmmy014,fmmy015,fmmy016,fmmy017,fmmy018,fmmy019,fmmy020,fmmy021,fmmy022, 
#       fmmy023,fmmydocdt,fmmydocno,fmmyent,fmmysite,fmmystus,NULL,'','','',0,0,0,'','','','',0,'','', 
#       '','',fmmy028,fmmy029,'',NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160414-00018#23 --s mark
   #LET g_from = " FROM fmmy_t t0 ",
   #             " LEFT OUTER JOIN fmmz_t t1 ON t0.fmmyent = t1.fmmzent AND t0.fmmydocno = t1.fmmzdocno ",
   #             " LEFT OUTER JOIN fmmj_t t2 ON t0.fmmyent = t2.fmmjent AND t0.fmmy001 = t2.fmmjdocno ",
   #             " LEFT OUTER JOIN gzcbl_t t3 ON t3.gzcbl001 = '8867' AND t3.gzcbl002 =  t0.fmmy008 AND t3.gzcbl003 = '",g_dlang,"'"
   #160414-00018#23 --e mark
   
   #160414-00018#23 --s add
   LET g_from = " FROM fmmy_t ",
                " LEFT OUTER JOIN fmmz_t ON fmmyent = fmmzent AND fmmydocno = fmmzdocno  "
   #160414-00018#23 --e add
#   #end add-point
#    LET g_from = " FROM fmmy_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #160414-00018#23 --s mark
   #160122-00001#21--add---str
#   LET g_where = g_where CLIPPED," AND (t0.fmmy010 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') OR t0.fmmy010 IS NULL)",
#                 " AND (t1.fmmz008 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') OR t1.fmmz008 IS NULL)"
   #160414-00018#23 --s mark
   #LET g_where = g_where CLIPPED," AND (t0.fmmy010 IN(",g_sql_bank,") OR TRIM(t0.fmmy010) IS NULL)",
   #                              " AND (t1.fmmz008 IN(",g_sql_bank,") OR TRIM(t1.fmmz008) IS NULL)"#160122-00001#21 mod by 07675
   #160414-00018#23 --e mark                                 
   #160122-00001#21--add---end
   
   #160414-00018#23 --s add 
   LET g_where = g_where CLIPPED," AND (fmmy010 IN(",g_sql_bank,") OR TRIM(fmmy010) IS NULL)",
                                 " AND (fmmz008 IN(",g_sql_bank,") OR TRIM(fmmz008) IS NULL)"
   #160414-00018#23 --e add
   #end add-point
    LET g_order = " ORDER BY fmmydocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fmmy_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afmr590_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afmr590_g01_curs CURSOR FOR afmr590_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afmr590_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afmr590_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fmmy001 LIKE fmmy_t.fmmy001, 
   fmmy002 LIKE fmmy_t.fmmy002, 
   fmmy003 LIKE fmmy_t.fmmy003, 
   fmmy004 LIKE fmmy_t.fmmy004, 
   fmmy005 LIKE fmmy_t.fmmy005, 
   fmmy006 LIKE fmmy_t.fmmy006, 
   fmmy007 LIKE fmmy_t.fmmy007, 
   fmmy008 LIKE fmmy_t.fmmy008, 
   fmmy009 LIKE fmmy_t.fmmy009, 
   fmmy010 LIKE fmmy_t.fmmy010, 
   fmmy011 LIKE fmmy_t.fmmy011, 
   fmmy012 LIKE fmmy_t.fmmy012, 
   fmmy013 LIKE fmmy_t.fmmy013, 
   fmmy014 LIKE fmmy_t.fmmy014, 
   fmmy015 LIKE fmmy_t.fmmy015, 
   fmmy016 LIKE fmmy_t.fmmy016, 
   fmmy017 LIKE fmmy_t.fmmy017, 
   fmmy018 LIKE fmmy_t.fmmy018, 
   fmmy019 LIKE fmmy_t.fmmy019, 
   fmmy020 LIKE fmmy_t.fmmy020, 
   fmmy021 LIKE fmmy_t.fmmy021, 
   fmmy022 LIKE fmmy_t.fmmy022, 
   fmmy023 LIKE fmmy_t.fmmy023, 
   fmmydocdt LIKE fmmy_t.fmmydocdt, 
   fmmydocno LIKE fmmy_t.fmmydocno, 
   fmmyent LIKE fmmy_t.fmmyent, 
   fmmysite LIKE fmmy_t.fmmysite, 
   fmmystus LIKE fmmy_t.fmmystus, 
   l_fmmzseq LIKE fmmz_t.fmmzseq, 
   l_fmmz001 LIKE fmmz_t.fmmz001, 
   l_fmmz008 LIKE fmmz_t.fmmz008, 
   l_fmmz002 LIKE fmmz_t.fmmz002, 
   l_fmmz003 LIKE fmmz_t.fmmz003, 
   l_fmmz004 LIKE fmmz_t.fmmz004, 
   l_fmmz011 LIKE fmmz_t.fmmz011, 
   l_fmmj021 LIKE fmmj_t.fmmj021, 
   l_fmmj027 LIKE fmmj_t.fmmj027, 
   l_fmmz008_desc LIKE type_t.chr100, 
   l_fmmz001_desc LIKE type_t.chr100, 
   l_sum_fmmz011 LIKE fmmz_t.fmmz011, 
   l_fmmy008_desc LIKE type_t.chr100, 
   l_fmmy010_desc LIKE type_t.chr100, 
   l_fmmy011_desc LIKE type_t.chr100, 
   l_fmmysite_desc LIKE type_t.chr100, 
   fmmy028 LIKE fmmy_t.fmmy028, 
   fmmy029 LIKE fmmy_t.fmmy029, 
   l_fmmj002 LIKE type_t.chr30, 
   l_fmmj002_desc LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   #160414-00018#23 --s mark
   #DEFINE l_glaald    LIKE glaa_t.glaald    #組織所屬法人主帳套
   #DEFINE l_glaa005   LIKE glaa_t.glaa005
   #160414-00018#23 --e mark
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH afmr590_g01_curs INTO sr_s.*
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
       #160414-00018#23 --s mark
       #for調整效能,搬到主SQL內
       #IF NOT cl_null(sr_s.l_fmmzseq) AND cl_null(sr_s.l_fmmz011) THEN
       #   LET sr_s.l_fmmz011 = 0
       #END IF
       ##投資組織
       #CALL s_desc_get_department_desc(sr_s.fmmysite) RETURNING sr_s.l_fmmysite_desc
       #CALL afmr590_g01_desc_show(sr_s.fmmysite,sr_s.l_fmmysite_desc) RETURNING sr_s.l_fmmysite_desc
       ##收款方式
       #IF cl_null(sr_s.l_fmmy008_desc) THEN
       #   LET sr_s.l_fmmy008_desc = sr_s.fmmy008
       #ELSE
       #   LET sr_s.l_fmmy008_desc = sr_s.fmmy008,":",sr_s.l_fmmy008_desc       
       #END IF
       ##交易帳戶
       #CALL s_desc_get_nmas002_desc(sr_s.fmmy010) RETURNING sr_s.l_fmmy010_desc
       #CALL afmr590_g01_desc_show(sr_s.fmmy010,sr_s.l_fmmy010_desc) RETURNING sr_s.l_fmmy010_desc
       ##抓組織所屬法人主帳套
       #LET l_glaald = ''
       #SELECT glaald INTO l_glaald 
       #  FROM glaa_t,ooef_t
       # WHERE glaaent = ooefent
       #   AND glaacomp = ooef017
       #   AND ooef001 = sr_s.fmmysite
       #   AND ooefent = g_enterprise
       #   AND glaa014 = 'Y'
       #   
       #LET l_glaa005 = ''
       #SELECT glaa005 INTO l_glaa005
       #  FROM glaa_t
       # WHERE glaald = l_glaald 
       #   AND glaaent = g_enterprise
       ##現金變動碼        
       #CALL s_desc_get_nmail004_desc(l_glaa005,sr_s.fmmy011) RETURNING sr_s.l_fmmy011_desc
       #CALL afmr590_g01_desc_show(sr_s.fmmy011,sr_s.l_fmmy011_desc) RETURNING sr_s.l_fmmy011_desc
       ##費用類型
       #CALL s_desc_fmmc001_desc(sr_s.l_fmmz001) RETURNING sr_s.l_fmmz001_desc
       #CALL afmr590_g01_desc_show(sr_s.l_fmmz001,sr_s.l_fmmz001_desc) RETURNING sr_s.l_fmmz001_desc
       ##支付帳戶
       #CALL s_desc_get_nmas002_desc(sr_s.l_fmmz008) RETURNING sr_s.l_fmmz008_desc
       #CALL afmr590_g01_desc_show(sr_s.l_fmmz008,sr_s.l_fmmz008_desc) RETURNING sr_s.l_fmmz008_desc
       #
       #CALL s_desc_fmme001_desc(sr_s.l_fmmj002) RETURNING sr_s.l_fmmj002_desc   #151126-00013#10
       #160414-00018#23 --e mark
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fmmy001 = sr_s.fmmy001
       LET sr[l_cnt].fmmy002 = sr_s.fmmy002
       LET sr[l_cnt].fmmy003 = sr_s.fmmy003
       LET sr[l_cnt].fmmy004 = sr_s.fmmy004
       LET sr[l_cnt].fmmy005 = sr_s.fmmy005
       LET sr[l_cnt].fmmy006 = sr_s.fmmy006
       LET sr[l_cnt].fmmy007 = sr_s.fmmy007
       LET sr[l_cnt].fmmy008 = sr_s.fmmy008
       LET sr[l_cnt].fmmy009 = sr_s.fmmy009
       LET sr[l_cnt].fmmy010 = sr_s.fmmy010
       LET sr[l_cnt].fmmy011 = sr_s.fmmy011
       LET sr[l_cnt].fmmy012 = sr_s.fmmy012
       LET sr[l_cnt].fmmy013 = sr_s.fmmy013
       LET sr[l_cnt].fmmy014 = sr_s.fmmy014
       LET sr[l_cnt].fmmy015 = sr_s.fmmy015
       LET sr[l_cnt].fmmy016 = sr_s.fmmy016
       LET sr[l_cnt].fmmy017 = sr_s.fmmy017
       LET sr[l_cnt].fmmy018 = sr_s.fmmy018
       LET sr[l_cnt].fmmy019 = sr_s.fmmy019
       LET sr[l_cnt].fmmy020 = sr_s.fmmy020
       LET sr[l_cnt].fmmy021 = sr_s.fmmy021
       LET sr[l_cnt].fmmy022 = sr_s.fmmy022
       LET sr[l_cnt].fmmy023 = sr_s.fmmy023
       LET sr[l_cnt].fmmydocdt = sr_s.fmmydocdt
       LET sr[l_cnt].fmmydocno = sr_s.fmmydocno
       LET sr[l_cnt].fmmyent = sr_s.fmmyent
       LET sr[l_cnt].fmmysite = sr_s.fmmysite
       LET sr[l_cnt].fmmystus = sr_s.fmmystus
       LET sr[l_cnt].l_fmmzseq = sr_s.l_fmmzseq
       LET sr[l_cnt].l_fmmz001 = sr_s.l_fmmz001
       LET sr[l_cnt].l_fmmz008 = sr_s.l_fmmz008
       LET sr[l_cnt].l_fmmz002 = sr_s.l_fmmz002
       LET sr[l_cnt].l_fmmz003 = sr_s.l_fmmz003
       LET sr[l_cnt].l_fmmz004 = sr_s.l_fmmz004
       LET sr[l_cnt].l_fmmz011 = sr_s.l_fmmz011
       LET sr[l_cnt].l_fmmj021 = sr_s.l_fmmj021
       LET sr[l_cnt].l_fmmj027 = sr_s.l_fmmj027
       LET sr[l_cnt].l_fmmz008_desc = sr_s.l_fmmz008_desc
       LET sr[l_cnt].l_fmmz001_desc = sr_s.l_fmmz001_desc
       LET sr[l_cnt].l_sum_fmmz011 = sr_s.l_sum_fmmz011
       LET sr[l_cnt].l_fmmy008_desc = sr_s.l_fmmy008_desc
       LET sr[l_cnt].l_fmmy010_desc = sr_s.l_fmmy010_desc
       LET sr[l_cnt].l_fmmy011_desc = sr_s.l_fmmy011_desc
       LET sr[l_cnt].l_fmmysite_desc = sr_s.l_fmmysite_desc
       LET sr[l_cnt].fmmy028 = sr_s.fmmy028
       LET sr[l_cnt].fmmy029 = sr_s.fmmy029
       LET sr[l_cnt].l_fmmj002 = sr_s.l_fmmj002
       LET sr[l_cnt].l_fmmj002_desc = sr_s.l_fmmj002_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmr590_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afmr590_g01_rep_data()
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
          START REPORT afmr590_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afmr590_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afmr590_g01_rep
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
 
{<section id="afmr590_g01.rep" readonly="Y" >}
PRIVATE REPORT afmr590_g01_rep(sr1)
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
    ORDER  BY sr1.fmmydocno,sr1.l_fmmzseq
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
        BEFORE GROUP OF sr1.fmmydocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fmmydocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fmmyent=' ,sr1.fmmyent,'{+}fmmydocno=' ,sr1.fmmydocno         
            CALL cl_gr_init_apr(sr1.fmmydocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fmmydocno.before name="rep.b_group.fmmydocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fmmyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmydocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr590_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afmr590_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afmr590_g01_subrep01
           DECLARE afmr590_g01_repcur01 CURSOR FROM g_sql
           FOREACH afmr590_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr590_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afmr590_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afmr590_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fmmydocno.after name="rep.b_group.fmmydocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_fmmzseq
 
           #add-point:rep.b_group.l_fmmzseq.before name="rep.b_group.l_fmmzseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_fmmzseq.after name="rep.b_group.l_fmmzseq.after"
           
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
                sr1.fmmyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmydocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_fmmzseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr590_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afmr590_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afmr590_g01_subrep02
           DECLARE afmr590_g01_repcur02 CURSOR FROM g_sql
           FOREACH afmr590_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr590_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afmr590_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afmr590_g01_subrep02
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
                sr1.fmmyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmydocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_fmmzseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr590_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afmr590_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afmr590_g01_subrep03
           DECLARE afmr590_g01_repcur03 CURSOR FROM g_sql
           FOREACH afmr590_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr590_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afmr590_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afmr590_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmmydocno
 
           #add-point:rep.a_group.fmmydocno.before name="rep.a_group.fmmydocno.before"
           START REPORT afmr590_g01_subrep05
           IF NOT cl_null(sr1.l_fmmzseq)THEN
              LET g_sql = "SELECT SUM(COALESCE(fmmz011,0)) ", 
                          "  FROM fmmz_t ",
                          " WHERE fmmzent = '",sr1.fmmyent CLIPPED,"'",
						        "   AND fmmzdocno = '",sr1.fmmydocno CLIPPED,"'",
						        #160122-00001#21--add---str
#                          " AND (fmmz008 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') OR fmmz008 IS NULL)",
                           " AND (fmmz008 IN(",g_sql_bank,") OR TRIM(fmmz008) IS NULL)",#160122-00001#21 mod by 07675
                          #160122-00001#21--add---end
                          " GROUP by fmmzdocno "
              DECLARE afmr590_g01_repcur05 CURSOR FROM g_sql
              FOREACH afmr590_g01_repcur05 INTO sr3.*
                 OUTPUT TO REPORT afmr590_g01_subrep05(sr3.*)
              END FOREACH
           END IF
           FINISH REPORT afmr590_g01_subrep05
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fmmyent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmydocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr590_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afmr590_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afmr590_g01_subrep04
           DECLARE afmr590_g01_repcur04 CURSOR FROM g_sql
           FOREACH afmr590_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr590_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afmr590_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afmr590_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fmmydocno.after name="rep.a_group.fmmydocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_fmmzseq
 
           #add-point:rep.a_group.l_fmmzseq.before name="rep.a_group.l_fmmzseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_fmmzseq.after name="rep.a_group.l_fmmzseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afmr590_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afmr590_g01_subrep01(sr2)
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
PRIVATE REPORT afmr590_g01_subrep02(sr2)
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
PRIVATE REPORT afmr590_g01_subrep03(sr2)
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
PRIVATE REPORT afmr590_g01_subrep04(sr2)
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
 
{<section id="afmr590_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 字串顯示方式
# Memo...........: 部門編號.部門名稱>例如:DC0300.資訊部
# Usage..........: CALL afmr590_g01_desc_show(p_field,p_desc)
#                  RETURNING r_desc
# Input parameter: p_field   欄位代號
#                : p_desc    欄位代號+說明欄位
# Return code....: r_desc
# Date & Author..: 2015/11/11 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION afmr590_g01_desc_show(p_field,p_desc)
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
 
{<section id="afmr590_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 單身合計子報表
# Memo...........:
# Usage..........: CALL afmr590_g01_subrep05(sr3)
# Date & Author..: 2015/11/11 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT afmr590_g01_subrep05(sr3)
DEFINE sr3 sr3_r
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 
