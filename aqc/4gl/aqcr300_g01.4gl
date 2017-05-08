#該程式未解開Section, 採用最新樣板產出!
{<section id="aqcr300_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-10-26 14:25:04), PR版次:0006(2016-10-26 14:54:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000104
#+ Filename...: aqcr300_g01
#+ Description: ...
#+ Creator....: 05423(2014-07-23 10:48:41)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aqcr300_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161018-0001#1  2016/10/26  By zhujing    01.來源單號的項次沒值時，"-"也不要顯示
#                                         02.判定結果明細改判斷料件是否有使用料件判定，沒使用就不印
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
   qcbadocno LIKE qcba_t.qcbadocno, 
   qcbadocdt LIKE qcba_t.qcbadocdt, 
   l_qcba010_qcba011 LIKE type_t.chr30, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   qcba000 LIKE qcba_t.qcba000, 
   l_qcba000_desc LIKE type_t.chr30, 
   qcba005 LIKE qcba_t.qcba005, 
   l_qcba005_pmaal004 LIKE type_t.chr30, 
   qcba012 LIKE qcba_t.qcba012, 
   qcba006 LIKE qcba_t.qcba006, 
   l_qcba006_desc LIKE type_t.chr30, 
   qcba007 LIKE qcba_t.qcba007, 
   qcba022 LIKE qcba_t.qcba022, 
   l_qcba022_desc LIKE type_t.chr30, 
   qcba024 LIKE qcba_t.qcba024, 
   qcba014 LIKE qcba_t.qcba014, 
   l_qcba024_ooag011 LIKE type_t.chr30, 
   l_qcba017_qcba009 LIKE type_t.chr30, 
   l_qcba001_qcba002 LIKE type_t.chr30, 
   qcba002 LIKE qcba_t.qcba002, 
   l_imae120 LIKE type_t.chr30, 
   qcba023 LIKE qcba_t.qcba023, 
   qcba027 LIKE qcba_t.qcba027, 
   qcbdseq LIKE qcbd_t.qcbdseq, 
   l_qcbd001_qcbd002 LIKE type_t.chr30, 
   qcbd003 LIKE qcbd_t.qcbd003, 
   l_qcbd003_desc LIKE type_t.chr30, 
   qcbd020 LIKE qcbd_t.qcbd020, 
   l_qcbd020_desc LIKE type_t.chr30, 
   qcbd004 LIKE qcbd_t.qcbd004, 
   qcbd018 LIKE qcbd_t.qcbd018, 
   l_qcbd018_desc LIKE type_t.chr100, 
   qcbd005 LIKE qcbd_t.qcbd005, 
   qcbd006 LIKE qcbd_t.qcbd006, 
   qcbd009 LIKE qcbd_t.qcbd009, 
   qcbd010 LIKE qcbd_t.qcbd010, 
   qcbd021 LIKE qcbd_t.qcbd021, 
   qcbd011 LIKE qcbd_t.qcbd011, 
   l_qcbd011_desc LIKE type_t.chr30, 
   qcbd019 LIKE qcbd_t.qcbd019, 
   qcbaent LIKE qcba_t.qcbaent, 
   qcbd013 LIKE qcbd_t.qcbd013, 
   qcbd014 LIKE qcbd_t.qcbd014, 
   qcbd015 LIKE qcbd_t.qcbd015, 
   qcbd017 LIKE qcbd_t.qcbd017, 
   l_qcba023 LIKE type_t.chr30, 
   l_qcba027 LIKE type_t.chr30
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
#單頭子報表1變數
 TYPE sr3_r RECORD
   qcbb001 LIKE qcbb_t.qcbb001,
   qcbb002 LIKE qcbb_t.qcbb002,
   qcbb003 LIKE qcbb_t.qcbb003,
   qcbb004 LIKE qcbb_t.qcbb004,
   qcbb005 LIKE qcbb_t.qcbb005,
   qcbb006 LIKE qcbb_t.qcbb006,
   l_qcbb006_desc LIKE type_t.chr30
END RECORD

#單頭子報表2變數
 TYPE sr4_r RECORD
   qcbcseq LIKE qcbc_t.qcbcseq,
   qcbc001 LIKE qcbc_t.qcbc001,
   l_qcbc001_desc LIKE type_t.chr30,
   qcbc002 LIKE qcbc_t.qcbc002,
   l_qcbc002_desc LIKE type_t.chr30,
   qcbc012 LIKE qcbc_t.qcbc012,
   l_qcbc012_desc LIKE type_t.chr30,   
   qcbc013 LIKE qcbc_t.qcbc013,
   l_qcbc013_desc LIKE type_t.chr30,
   qcbc003 LIKE qcbc_t.qcbc003,
   l_imaal003_imaal004 LIKE type_t.chr100,
   imaal004 LIKE imaal_t.imaal004,
   qcbc004 LIKE qcbc_t.qcbc004,
   qcbc007 LIKE qcbc_t.qcbc007,
   qcbc009 LIKE qcbc_t.qcbc009
END RECORD

#單身子報表變數
------------11.21 MODIFY TO TABLE
 TYPE sr5_r RECORD
   qcbddocno   LIKE qcbd_t.qcbddocno,  #檢驗單號
   qcbdseq  LIKE qcbd_t.qcbdseq,       #檢驗項次
   qcbdent  LIKE qcbd_t.qcbdent,       #企業編號
   qcbd001  LIKE qcbd_t.qcbd001,       #檢驗項目
   qcbd002  LIKE qcbd_t.qcbd002,
   l_qcbd001_desc LIKE type_t.chr100,  #檢驗項目說明
   qcbd018  LIKE qcbd_t.qcbd018,       #檢驗說明
   l_qcbg002_1    LIKE type_t.chr30,   #測量值1
   l_qcbg002_2    LIKE type_t.chr30,   #測量值2
   l_qcbg002_3    LIKE type_t.chr30,   #測量值3
   l_qcbg002_4    LIKE type_t.chr30,   #測量值4
   l_qcbg002_5    LIKE type_t.chr30,   #測量值5
   l_qcbg002_6    LIKE type_t.chr30,   #測量值6
   l_qcbg002_7    LIKE type_t.chr30,   #測量值7
   l_qcbg002_8    LIKE type_t.chr30,   #測量值8
   l_qcbg002_9    LIKE type_t.chr30,   #測量值9
   l_qcbg002_10   LIKE type_t.chr30    #測量值10
END RECORD  

TYPE a1 RECORD
   qcbg002  LIKE qcbg_t.qcbg002,       #測量值
   qcbg003  LIKE qcbg_t.qcbg003,       #合格
   l_rec    LIKE type_t.chr30          #記錄最終值
END RECORD   

------------11.21 MODIFY 
#缺點原因列印，增加至單身最後一列，列印多個缺點原因
TYPE sr6_r RECORD
   qcbe001 LIKE qcbe_t.qcbe001,
   l_qcbe001_desc LIKE type_t.chr30
END RECORD  

------------11.21 MODIFY 
#缺點描述列印，增加至TABLE最後一列，列印多個缺點原因
TYPE sr7_r RECORD
   qcbe003 LIKE qcbe_t.qcbe003
   
END RECORD 
 
TYPE sr8_r RECORD
   qcbddocno   LIKE qcbd_t.qcbddocno,
   qcbdent  LIKE qcbd_t.qcbdent,
   qcbdseq  LIKE qcbd_t.qcbdseq, 
   l_qcbd001_qcbd002 LIKE type_t.chr100,
   qcbd002  LIKE qcbd_t.qcbd002,   
   qcbd003  LIKE qcbd_t.qcbd003, 
   l_qcbd003_desc LIKE type_t.chr30, 
   qcbd020  LIKE qcbd_t.qcbd020, 
   l_qcbd020_desc LIKE type_t.chr30, 
   qcbd004  LIKE qcbd_t.qcbd004, 
   qcbd018  LIKE qcbd_t.qcbd018, 
   l_qcbd018_desc LIKE type_t.chr100, 
   qcbd005  LIKE qcbd_t.qcbd005, 
   qcbd006  LIKE qcbd_t.qcbd006, 
   qcbd009  LIKE qcbd_t.qcbd009, 
   qcbd010  LIKE qcbd_t.qcbd010, 
   qcbd021  LIKE qcbd_t.qcbd021, 
   qcbd011  LIKE qcbd_t.qcbd011, 
   l_qcbd011_desc LIKE type_t.chr30, 
   qcbd019  LIKE qcbd_t.qcbd019, 
   qcbd013  LIKE qcbd_t.qcbd013, 
   qcbd014  LIKE qcbd_t.qcbd014, 
   qcbd015  LIKE qcbd_t.qcbd015, 
   qcbd017  LIKE qcbd_t.qcbd017
   
END RECORD 
DEFINE l_tmp   STRING
DEFINE l_length         LIKE type_t.num5
DEFINE l_cnt3           LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="aqcr300_g01.main" readonly="Y" >}
PUBLIC FUNCTION aqcr300_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aqcr300_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aqcr300_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aqcr300_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aqcr300_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr300_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcr300_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT qcba_t.qcbadocno,qcba_t.qcbadocdt,trim(qcba_t.qcba010),imaal_t.imaal003, 
       imaal_t.imaal004,qcba_t.qcba000,NULL,qcba_t.qcba005,(trim(qcba_t.qcba005)||'.'||trim(pmaal_t.pmaal004)),qcba_t.qcba012,qcba_t.qcba006,NULL,qcba_t.qcba007,qcba_t.qcba022,NULL,qcba_t.qcba024,qcba_t.qcba014,(trim(qcba_t.qcba024)||'.'||trim(ooag_t.ooag011)),trim(qcba_t.qcba017)||' '||trim(qcba_t.qcba009), ",
       #161018-0001#1 mod-S
#       (trim(qcba_t.qcba001)||'-'||trim(qcba_t.qcba002)),qcba_t.qcba023,qcba_t.qcba027,NULL,NULL,    
       "qcba001,qcba002,(SELECT imae120 FROM imae_t WHERE imae001 = qcba010 AND imaeent = qcbaent AND imaesite = qcbasite) imae120,qcba_t.qcba023,qcba_t.qcba027,NULL,NULL,                                      
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,qcba_t.qcbaent,NULL,
       NULL,NULL,NULL,qcba023,qcba027" 
       #161018-0001#1 mod-E
#   #end add-point
#   LET g_select = " SELECT qcbadocno,qcbadocdt,(trim(qcba010)||'/'||trim(qcba011)),imaal_t.imaal003, 
#       imaal_t.imaal004,qcba000,NULL,qcba005,NULL,qcba012,qcba006,NULL,qcba007,qcba022,NULL,qcba024, 
#       qcba014,NULL,trim(qcba017)||' '||trim(qcba009),(trim(qcba001)||'-'||trim(qcba002)),qcba002,NULL, 
#       qcba023,qcba027,qcbdseq,trim(qcbd001)||'.'||trim(qcbd002),qcbd003,NULL,qcbd020,NULL,qcbd004,qcbd018, 
#       NULL,qcbd005,qcbd006,qcbd009,qcbd010,qcbd021,qcbd011,NULL,qcbd019,qcbaent,qcbd013,qcbd014,qcbd015, 
#       qcbd017,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM qcba_t LEFT OUTER JOIN qcbd_t ON qcba_t.qcbadocno = qcbd_t.qcbddocno AND qcba_t.qcbaent = qcbd_t.qcbdent ",
                "             LEFT OUTER JOIN imaal_t ON qcba_t.qcba010 = imaal_t.imaal001 AND qcba_t.qcbaent = imaal_t.imaalent AND imaal_t.imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN ooag_t ON ooag001 = qcba024 AND ooagent = qcbaent ",
                "             LEFT OUTER JOIN pmaal_t ON pmaal001 = qcba005 AND pmaalent = qcbaent AND pmaal002 = '",g_dlang,"' "
#                "             LEFT OUTER JOIN oocql_t ON oocql001 = '1051' AND oocql002 = qcbd001 AND oocqlent = qcbdent AND oocql003 = '",g_dlang,"' "                
#   #end add-point
#    LET g_from = " FROM qcba_t,qcbd_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE " ,tm.wc CLIPPED 

#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY qcbadocno,qcbdseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("qcba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aqcr300_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aqcr300_g01_curs CURSOR FOR aqcr300_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aqcr300_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aqcr300_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   qcbadocno LIKE qcba_t.qcbadocno, 
   qcbadocdt LIKE qcba_t.qcbadocdt, 
   l_qcba010_qcba011 LIKE type_t.chr30, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   qcba000 LIKE qcba_t.qcba000, 
   l_qcba000_desc LIKE type_t.chr30, 
   qcba005 LIKE qcba_t.qcba005, 
   l_qcba005_pmaal004 LIKE type_t.chr30, 
   qcba012 LIKE qcba_t.qcba012, 
   qcba006 LIKE qcba_t.qcba006, 
   l_qcba006_desc LIKE type_t.chr30, 
   qcba007 LIKE qcba_t.qcba007, 
   qcba022 LIKE qcba_t.qcba022, 
   l_qcba022_desc LIKE type_t.chr30, 
   qcba024 LIKE qcba_t.qcba024, 
   qcba014 LIKE qcba_t.qcba014, 
   l_qcba024_ooag011 LIKE type_t.chr30, 
   l_qcba017_qcba009 LIKE type_t.chr30, 
   l_qcba001_qcba002 LIKE type_t.chr30, 
   qcba002 LIKE qcba_t.qcba002, 
   l_imae120 LIKE type_t.chr30, 
   qcba023 LIKE qcba_t.qcba023, 
   qcba027 LIKE qcba_t.qcba027, 
   qcbdseq LIKE qcbd_t.qcbdseq, 
   l_qcbd001_qcbd002 LIKE type_t.chr30, 
   qcbd003 LIKE qcbd_t.qcbd003, 
   l_qcbd003_desc LIKE type_t.chr30, 
   qcbd020 LIKE qcbd_t.qcbd020, 
   l_qcbd020_desc LIKE type_t.chr30, 
   qcbd004 LIKE qcbd_t.qcbd004, 
   qcbd018 LIKE qcbd_t.qcbd018, 
   l_qcbd018_desc LIKE type_t.chr100, 
   qcbd005 LIKE qcbd_t.qcbd005, 
   qcbd006 LIKE qcbd_t.qcbd006, 
   qcbd009 LIKE qcbd_t.qcbd009, 
   qcbd010 LIKE qcbd_t.qcbd010, 
   qcbd021 LIKE qcbd_t.qcbd021, 
   qcbd011 LIKE qcbd_t.qcbd011, 
   l_qcbd011_desc LIKE type_t.chr30, 
   qcbd019 LIKE qcbd_t.qcbd019, 
   qcbaent LIKE qcba_t.qcbaent, 
   qcbd013 LIKE qcbd_t.qcbd013, 
   qcbd014 LIKE qcbd_t.qcbd014, 
   qcbd015 LIKE qcbd_t.qcbd015, 
   qcbd017 LIKE qcbd_t.qcbd017, 
   l_qcba023 LIKE type_t.chr30, 
   l_qcba027 LIKE type_t.chr30
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_qcba002        LIKE type_t.chr10
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aqcr300_g01_curs INTO sr_s.*
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
       #161018-0001#1 add-S
       IF NOT cl_null(sr_s.l_qcba001_qcba002) AND NOT cl_null(sr_s.qcba002) THEN
          LET l_qcba002 = sr_s.qcba002
          LET sr_s.l_qcba001_qcba002 = sr_s.l_qcba001_qcba002 CLIPPED,'-',l_qcba002 CLIPPED
       END IF
       #161018-0001#1 add-E
        
#       CALL aqcr300_g01_desc('1',5057,sr_s.qcbd003) RETURNING sr_s.l_qcbd003_desc   #缺點等級
#       CALL aqcr300_g01_desc('1',5058,sr_s.qcbd020) RETURNING sr_s.l_qcbd020_desc   #抽樣計劃
#       CALL aqcr300_g01_desc('1',5073,sr_s.qcbd011) RETURNING sr_s.l_qcbd011_desc   #判定結果     

      IF NOT cl_null(sr_s.qcba000) THEN 
         CALL aqcr300_g01_desc('1',5056,sr_s.qcba000) RETURNING sr_s.l_qcba000_desc   #檢驗類型
#         LET sr_s.l_qcba000_desc = sr_s.qcba000 CLIPPED,".",sr_s.l_qcba000_desc CLIPPED
#      ELSE 
#         LET sr_s.l_qcba000_desc = sr_s.qcba000 CLIPPED
      END IF
      IF NOT cl_null(sr_s.qcba006) THEN 
         CALL aqcr300_g01_desc('3',221,sr_s.qcba006) RETURNING sr_s.l_qcba006_desc    #作業編號
         LET sr_s.l_qcba006_desc = sr_s.qcba006 CLIPPED,".",sr_s.l_qcba006_desc CLIPPED
      ELSE 
         LET sr_s.l_qcba006_desc = sr_s.qcba006 CLIPPED
      END IF
#      IF NOT cl_null(sr_s.qcba022) THEN 
         CALL aqcr300_g01_desc('1',5072,sr_s.qcba022) RETURNING sr_s.l_qcba022_desc   #判定結果
#         LET sr_s.l_qcba022_desc = sr_s.qcba022 CLIPPED,".",sr_s.l_qcba022_desc CLIPPED
#      ELSE 
#         LET sr_s.l_qcba022_desc = sr_s.qcba022 CLIPPED
#      END IF
       IF sr_s.l_qcba010_qcba011 = '/' THEN
         LET sr_s.l_qcba010_qcba011 = NULL
       END IF

       IF sr_s.l_qcba005_pmaal004 = '.' THEN
         LET sr_s.l_qcba005_pmaal004 = NULL
       END IF
       IF sr_s.l_qcba024_ooag011 = '.' THEN
         LET sr_s.l_qcba024_ooag011 = NULL
       END IF    
#       LET sr_s.l_qcba023 = sr_s.qcba023
#       LET sr_s.l_qcba027 = sr_s.qcba027
       #去允收數小數
       LET sr_s.l_qcba023 = sr_s.l_qcba023 USING '<<<<<&.<<<'
       IF sr_s.l_qcba023 = '0.000' THEN
          LET sr_s.l_qcba023 = '0'
       END IF
       LET l_tmp =  sr_s.l_qcba023 CLIPPED
       IF l_tmp.getIndexOf('.000',1) != 0 THEN
         LET sr_s.l_qcba023 = sr_s.l_qcba023 USING "<<<<<<"
       ELSE
         IF (l_tmp.getIndexOf('.',1) != 0 )THEN #是小數
            FOR l_cnt3 = 1 TO 10
               LET l_length = l_tmp.getLength()                   
               IF sr_s.l_qcba023[l_length,l_length] == 0 THEN
                  LET sr_s.l_qcba023 = sr_s.l_qcba023[1,l_length-1]  
                  LET l_tmp = sr_s.l_qcba023 CLIPPED
               ELSE
                  EXIT FOR
               END IF
            END FOR
         END IF
       END IF
       #去不良數小數
       LET sr_s.l_qcba027 = sr_s.l_qcba027 USING '<<<<<&.<<<'
       IF sr_s.l_qcba027 = '0.000' THEN
          LET sr_s.l_qcba027 = '0'
       END IF
       LET l_tmp =  sr_s.l_qcba027 CLIPPED
       IF l_tmp.getIndexOf('.000',1) != 0 THEN #不是小數
         LET sr_s.l_qcba027 = sr_s.l_qcba027 USING "<<<<<<" #qcbg002有值的印qcbg002
       ELSE 
         IF (l_tmp.getIndexOf('.',1) != 0 )THEN #是小數
            FOR l_cnt3 = 1 TO 10
               LET l_length = l_tmp.getLength()                   
               IF sr_s.l_qcba027[l_length,l_length] == 0 THEN
                  LET sr_s.l_qcba027 = sr_s.l_qcba027[1,l_length-1]  
                  LET l_tmp = sr_s.l_qcba027
#             IF l_tmp.subString(l_length,l_length) == 0 THEN
#               LET l_tmp = l_tmp.subString(1,l_length-1)
#               LET sr_s.qcba023 = sr_s.qcba023[1,l_length-1]  
#               LET sr_s.qcba023 = l_tmp
               ELSE
                  EXIT FOR
               END IF
            END FOR
         END IF
       END IF
#       IF sr_s.l_qcbd001_qcbd002 = '/' THEN
#         LET sr_s.l_qcbd001_qcbd002 = NULL
#       END IF    
#
#       IF sr_s.qcbd011 = '1'  THEN  
#         LET sr_s.l_qcbd011_desc = sr_s.l_qcbd011_desc CLIPPED ,'〇'
#       ELSE 
#         IF sr_s.qcbd011 = '2'  THEN  
#            LET sr_s.l_qcbd011_desc = sr_s.l_qcbd011_desc CLIPPED ,'×'
#         END IF
#       END IF
#       #若qcbd015或qcbd013不為空，將qcbd015+qcbd017+'~'+qcbd013+qcbd017組合后列印。
#       #若qcbd014不為空，則將qcbd014+qcbd017組合后列印到後面，用','隔開。
##       SELECT qcbd013,qcbd014,qcbd015,qcbd018,qcbd017 INTO sr_s.qcbd013,sr_s.qcbd014,sr_s.qcbd015,sr_s.qcbd018,sr_s.qcbd017
##       FROM qcbd_t LEFT OUTER JOIN qcba_t ON qcba_t.qcbadocno = qcbd_t.qcbddocno AND qcbd_t.qcbdent = qcba_t.qcbaent AND qcbd_t.qcbdseq = qcba_t.qcba002
##       WHERE qcbd_t.qcbddocno = sr_s.qcbadocno AND qcbd_t.qcbdseq = sr_s.qcbdseq
#       
#       IF NOT cl_null(sr_s.qcbd015) OR NOT cl_null(sr_s.qcbd013) THEN
#         LET sr_s.l_qcbd018_desc = sr_s.qcbd015 USING "<<<<<<<<",' ', sr_s.qcbd017 CLIPPED, '~' ,sr_s.qcbd013 USING "<<<<<<<<",' ', sr_s.qcbd017 CLIPPED
#       END IF
#       IF NOT cl_null(sr_s.qcbd014) THEN
#         LET sr_s.l_qcbd018_desc = sr_s.l_qcbd018_desc CLIPPED,',',sr_s.qcbd014 USING "<<<<<<<<",' ',sr_s.qcbd017
#       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].qcbadocno = sr_s.qcbadocno
       LET sr[l_cnt].qcbadocdt = sr_s.qcbadocdt
       LET sr[l_cnt].l_qcba010_qcba011 = sr_s.l_qcba010_qcba011
       LET sr[l_cnt].imaal_t_imaal003 = sr_s.imaal_t_imaal003
       LET sr[l_cnt].imaal_t_imaal004 = sr_s.imaal_t_imaal004
       LET sr[l_cnt].qcba000 = sr_s.qcba000
       LET sr[l_cnt].l_qcba000_desc = sr_s.l_qcba000_desc
       LET sr[l_cnt].qcba005 = sr_s.qcba005
       LET sr[l_cnt].l_qcba005_pmaal004 = sr_s.l_qcba005_pmaal004
       LET sr[l_cnt].qcba012 = sr_s.qcba012
       LET sr[l_cnt].qcba006 = sr_s.qcba006
       LET sr[l_cnt].l_qcba006_desc = sr_s.l_qcba006_desc
       LET sr[l_cnt].qcba007 = sr_s.qcba007
       LET sr[l_cnt].qcba022 = sr_s.qcba022
       LET sr[l_cnt].l_qcba022_desc = sr_s.l_qcba022_desc
       LET sr[l_cnt].qcba024 = sr_s.qcba024
       LET sr[l_cnt].qcba014 = sr_s.qcba014
       LET sr[l_cnt].l_qcba024_ooag011 = sr_s.l_qcba024_ooag011
       LET sr[l_cnt].l_qcba017_qcba009 = sr_s.l_qcba017_qcba009
       LET sr[l_cnt].l_qcba001_qcba002 = sr_s.l_qcba001_qcba002
       LET sr[l_cnt].qcba002 = sr_s.qcba002
       LET sr[l_cnt].l_imae120 = sr_s.l_imae120
       LET sr[l_cnt].qcba023 = sr_s.qcba023
       LET sr[l_cnt].qcba027 = sr_s.qcba027
       LET sr[l_cnt].qcbdseq = sr_s.qcbdseq
       LET sr[l_cnt].l_qcbd001_qcbd002 = sr_s.l_qcbd001_qcbd002
       LET sr[l_cnt].qcbd003 = sr_s.qcbd003
       LET sr[l_cnt].l_qcbd003_desc = sr_s.l_qcbd003_desc
       LET sr[l_cnt].qcbd020 = sr_s.qcbd020
       LET sr[l_cnt].l_qcbd020_desc = sr_s.l_qcbd020_desc
       LET sr[l_cnt].qcbd004 = sr_s.qcbd004
       LET sr[l_cnt].qcbd018 = sr_s.qcbd018
       LET sr[l_cnt].l_qcbd018_desc = sr_s.l_qcbd018_desc
       LET sr[l_cnt].qcbd005 = sr_s.qcbd005
       LET sr[l_cnt].qcbd006 = sr_s.qcbd006
       LET sr[l_cnt].qcbd009 = sr_s.qcbd009
       LET sr[l_cnt].qcbd010 = sr_s.qcbd010
       LET sr[l_cnt].qcbd021 = sr_s.qcbd021
       LET sr[l_cnt].qcbd011 = sr_s.qcbd011
       LET sr[l_cnt].l_qcbd011_desc = sr_s.l_qcbd011_desc
       LET sr[l_cnt].qcbd019 = sr_s.qcbd019
       LET sr[l_cnt].qcbaent = sr_s.qcbaent
       LET sr[l_cnt].qcbd013 = sr_s.qcbd013
       LET sr[l_cnt].qcbd014 = sr_s.qcbd014
       LET sr[l_cnt].qcbd015 = sr_s.qcbd015
       LET sr[l_cnt].qcbd017 = sr_s.qcbd017
       LET sr[l_cnt].l_qcba023 = sr_s.l_qcba023
       LET sr[l_cnt].l_qcba027 = sr_s.l_qcba027
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aqcr300_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aqcr300_g01_rep_data()
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
          START REPORT aqcr300_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aqcr300_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aqcr300_g01_rep
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
 
{<section id="aqcr300_g01.rep" readonly="Y" >}
PRIVATE REPORT aqcr300_g01_rep(sr1)
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
DEFINE sr5 sr5_r
DEFINE sr6 sr6_r
DEFINE sr7 sr7_r
DEFINE sr8 sr8_r

DEFINE l_cnt2           LIKE type_t.num5


DEFINE l_sql   STRING

DEFINE l_rec1   DYNAMIC ARRAY OF a1    #11.21 測量值

DEFINE l_subrep05_show  LIKE type_t.chr1,
       l_subrep06_show  LIKE type_t.chr1,
       l_subrep07_show  LIKE type_t.chr1,
       l_subrep08_show  LIKE type_t.chr1,    #11.21 缺點原因子報表
       l_subrep09_show  LIKE type_t.chr1,    #11.21 缺點描述子報表
       l_subrep10_show  LIKE type_t.chr1
       
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.qcbadocno,sr1.qcbdseq
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
        BEFORE GROUP OF sr1.qcbadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.qcbadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'qcbaent=' ,sr1.qcbaent,'{+}qcbadocno=' ,sr1.qcbadocno         
            CALL cl_gr_init_apr(sr1.qcbadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.qcbadocno.before name="rep.b_group.qcbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.qcbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.qcbadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aqcr300_g01_subrep01
           DECLARE aqcr300_g01_repcur01 CURSOR FROM g_sql
           FOREACH aqcr300_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aqcr300_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aqcr300_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aqcr300_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.qcbadocno.after name="rep.b_group.qcbadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.qcbdseq
 
           #add-point:rep.b_group.qcbdseq.before name="rep.b_group.qcbdseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.qcbdseq.after name="rep.b_group.qcbdseq.after"
           
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
                sr1.qcbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.qcbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.qcbdseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aqcr300_g01_subrep02
           DECLARE aqcr300_g01_repcur02 CURSOR FROM g_sql
           FOREACH aqcr300_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aqcr300_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aqcr300_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aqcr300_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"

#
#          #11.21 缺點原因
#          LET g_sql = "SELECT qcbe_t.qcbe001,NULL ",
#                      "  FROM qcbe_t ",
#                      " WHERE qcbe_t.qcbedocno = '",sr1.qcbadocno CLIPPED,"'",
#                      "   AND qcbe_t.qcbeseq = '",sr1.qcbdseq  CLIPPED,"' AND qcbeent = '",sr1.qcbaent CLIPPED,"' "
#           LET l_cnt = 0
#           LET l_sub_sql = ""
#           LET l_subrep08_show ="N"
#           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
#           PREPARE aqcr300_g01_repcur08_cnt_pre FROM l_sub_sql
#           EXECUTE aqcr300_g01_repcur08_cnt_pre INTO l_cnt
#           IF l_cnt > 0 THEN 
#              LET l_subrep08_show ="Y"
#           END IF
#           PRINTX l_subrep08_show
#           
#          START REPORT aqcr300_g01_subrep08
#
#          DECLARE aqcr300_g01_repcur08 CURSOR FROM g_sql
#          FOREACH aqcr300_g01_repcur08 INTO sr6.*
#             CALL aqcr300_g01_desc('3',1053,sr6.qcbe001) RETURNING sr6.l_qcbe001_desc #缺点原因说明
#             OUTPUT TO REPORT aqcr300_g01_subrep08(sr6.*)
#          END FOREACH
#          FINISH REPORT aqcr300_g01_subrep08 


         
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.qcbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.qcbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.qcbdseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aqcr300_g01_subrep03
           DECLARE aqcr300_g01_repcur03 CURSOR FROM g_sql
           FOREACH aqcr300_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aqcr300_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aqcr300_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aqcr300_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
 
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.qcbadocno
 
           #add-point:rep.a_group.qcbadocno.before name="rep.a_group.qcbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.qcbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.qcbadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aqcr300_g01_subrep04
           DECLARE aqcr300_g01_repcur04 CURSOR FROM g_sql
           FOREACH aqcr300_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aqcr300_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aqcr300_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aqcr300_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.qcbadocno.after name="rep.a_group.qcbadocno.after"
#-------------------------------------------------------------------------------------------------          
                   #檢驗規格與結果

          LET g_sql = " SELECT qcbddocno,qcbdent,qcbd_t.qcbdseq,trim(oocql_t.oocql004),trim(qcbd_t.qcbd002),qcbd_t.qcbd003,NULL,qcbd_t.qcbd020,NULL,",
                      " qcbd_t.qcbd004,trim(qcbd_t.qcbd018),NULL,qcbd_t.qcbd005,qcbd_t.qcbd006,qcbd_t.qcbd009,qcbd_t.qcbd010,qcbd_t.qcbd021,qcbd_t.qcbd011,",
                      " NULL,qcbd_t.qcbd019,trim(qcbd_t.qcbd013),trim(qcbd_t.qcbd014),trim(qcbd_t.qcbd015),trim(qcbd_t.qcbd017) ",
                      " FROM qcbd_t  LEFT OUTER JOIN oocql_t ON oocql001 = '1051' AND oocql002 = qcbd001 AND oocqlent = qcbdent AND oocql003 = '",g_dlang,"' ",
                      " WHERE qcbd_t.qcbddocno = '",sr1.qcbadocno CLIPPED,"'",
                      " AND qcbdent = '",sr1.qcbaent CLIPPED,"' ",
                      " ORDER BY qcbdseq "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep10_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur10_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur10_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep10_show ="Y"
           END IF
           PRINTX l_subrep10_show
           
          START REPORT aqcr300_g01_subrep10
          DECLARE aqcr300_g01_repcur10 CURSOR FROM g_sql
          FOREACH aqcr300_g01_repcur10 INTO sr8.*
            
            
                 
            IF NOT cl_null(sr8.qcbd002) THEN
               LET sr8.l_qcbd001_qcbd002 = sr8.l_qcbd001_qcbd002 CLIPPED,'/',sr8.qcbd002 CLIPPED
            END IF
            IF NOT cl_null(sr8.qcbd003) THEN
               CALL aqcr300_g01_desc('1',5057,sr8.qcbd003) RETURNING sr8.l_qcbd003_desc   #缺點等級   
            --   LET sr8.l_qcbd003_desc = sr8.qcbd003 CLIPPED,'.',sr8.l_qcbd003_desc CLIPPED
#            ELSE
#               LET sr8.l_qcbd003_desc = sr8.qcbd003 CLIPPED
            END IF
            
            IF NOT cl_null(sr8.qcbd020) THEN
               CALL aqcr300_g01_desc('1',5058,sr8.qcbd020) RETURNING sr8.l_qcbd020_desc   #抽樣計劃
#               LET sr8.l_qcbd020_desc = sr8.qcbd020 CLIPPED,'.',sr8.l_qcbd020_desc CLIPPED
#            ELSE
#               LET sr8.l_qcbd020_desc = sr8.qcbd020 CLIPPED
            END IF
#            
            IF NOT cl_null(sr8.qcbd011) THEN
               CALL aqcr300_g01_desc('1',5073,sr8.qcbd011) RETURNING sr8.l_qcbd011_desc   #判定結果
#               LET sr8.l_qcbd011_desc = sr8.qcbd011 CLIPPED,'.',sr8.l_qcbd011_desc CLIPPED
#            ELSE
#               LET sr8.l_qcbd011_desc = sr8.qcbd011 CLIPPED
            END IF

            IF sr8.l_qcbd001_qcbd002 = '/' THEN
               LET sr8.l_qcbd001_qcbd002 = NULL
            END IF    

            IF sr8.qcbd011 = '1'  THEN  
               LET sr8.l_qcbd011_desc = sr8.l_qcbd011_desc CLIPPED ,'〇'
            ELSE 
               IF sr8.qcbd011 = '2'  THEN  
                  LET sr8.l_qcbd011_desc = sr8.l_qcbd011_desc CLIPPED ,'×'
               END IF
            END IF
             OUTPUT TO REPORT aqcr300_g01_subrep10(sr8.*)
          END FOREACH
          FINISH REPORT aqcr300_g01_subrep10
          
          #單身子報表----修改為單身列印后子報表
          #11.21 更改為TABLE形式 檢驗項目-檢驗說明-測量值
          LET g_sql = "SELECT qcbddocno,qcbdseq,qcbdent,qcbd001,qcbd002,NULL,qcbd018,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ",
                      "  FROM qcbd_t ",
                      " WHERE qcbd_t.qcbddocno = '",sr1.qcbadocno CLIPPED,"'",
                      "   AND qcbdent = '",sr1.qcbaent CLIPPED,"' "
           
           LET l_sql = " SELECT qcbg002,qcbg003,NULL ",
                         " FROM qcbg_t ",
                         " WHERE qcbgdocno = '",sr1.qcbadocno ,"' AND qcbgent = '",sr1.qcbaent,"' "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep07_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",l_sql,")"
           PREPARE aqcr300_g01_repcur07_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur07_cnt_pre INTO l_cnt
           LET l_cnt2 = 0
           LET l_sub_sql = ""
           
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur07_cnt_pre2 FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur07_cnt_pre2 INTO l_cnt2
           IF l_cnt > 0 AND l_cnt2>0 THEN 
              LET l_subrep07_show ="Y"
           END IF
           PRINTX l_subrep07_show
           
          START REPORT aqcr300_g01_subrep07

          DECLARE aqcr300_g01_repcur07 CURSOR FROM g_sql
          FOREACH aqcr300_g01_repcur07 INTO sr5.*
             CALL aqcr300_g01_desc('3',1051,sr5.qcbd001) RETURNING sr5.l_qcbd001_desc #檢驗項目說明
             LET sr5.l_qcbd001_desc = sr5.l_qcbd001_desc CLIPPED
             IF NOT cl_null(sr5.qcbd002) THEN
               LET sr5.l_qcbd001_desc = sr5.l_qcbd001_desc,'/',sr5.qcbd002
             END IF
             LET l_sql = " SELECT qcbg002,qcbg003,NULL ",
                         " FROM qcbg_t ",
                         " WHERE qcbgdocno = '",sr5.qcbddocno ,"' AND qcbgseq = '",sr5.qcbdseq ,"' AND qcbgent = '",sr5.qcbdent,"' "
             
             LET l_sub_sql = "SELECT COUNT(1) FROM (",l_sql,")"
             LET l_cnt = 0
             PREPARE aqcr300_g01_repcur07_cnt_pre1 FROM l_sub_sql
             EXECUTE aqcr300_g01_repcur07_cnt_pre1 INTO l_cnt
             IF l_cnt = 0 THEN
               INITIALIZE sr5.* TO NULL
               CONTINUE FOREACH
             END IF
             
             LET l_cnt = 1
             DECLARE aqcr300_g01_reccur CURSOR FROM l_sql
             FOREACH aqcr300_g01_reccur INTO l_rec1[l_cnt].*
               IF cl_null(l_rec1[l_cnt].qcbg002) THEN #如果qcbg002沒有值，則列印qcbg003  
                  CASE l_rec1[l_cnt].qcbg003
                     WHEN 'Y' 
                        LET l_rec1[l_cnt].l_rec = 'OK' #qcbg003=Y 印 OK
                     WHEN 'N' 
                        LET l_rec1[l_cnt].l_rec = 'NG' #qcbg003=N 印 NG
                  END CASE
               ELSE
                  LET l_rec1[l_cnt].l_rec = l_rec1[l_cnt].qcbg002 USING "<<&.<<<" #qcbg002有值的印qcbg002
                  IF l_rec1[l_cnt].l_rec = '0.000' THEN
                     LET l_rec1[l_cnt].l_rec = '0'
                  END IF
                  LET l_tmp = l_rec1[l_cnt].l_rec CLIPPED
                     
                  IF l_tmp.getIndexOf('.000',1) != 0 THEN
                     LET l_rec1[l_cnt].l_rec = l_rec1[l_cnt].qcbg002 USING "###" #qcbg002有值的印qcbg002
                  ELSE
                     IF (l_tmp.getIndexOf('.',1) != 0 )THEN #是小數
                        FOR l_cnt3 = 1 TO 10
                           LET l_length = l_tmp.getLength()                   
                           IF l_rec1[l_cnt].l_rec[l_length,l_length] == 0 THEN
                              LET l_rec1[l_cnt].l_rec = l_rec1[l_cnt].l_rec[1,l_length-1]  
                              LET l_tmp = l_rec1[l_cnt].l_rec 
#                        IF l_tmp.subString(l_length-1,l_length) == 0 THEN
#                           LET l_tmp = l_tmp.subString(1,l_length-1)
#                           LET l_rec1[l_cnt].l_rec = l_rec1[l_cnt].l_rec[1,l_length]  
#                           LET l_tmp = l_rec1[l_cnt].l_rec
                           ELSE
                              EXIT FOR
                           END IF
                        END FOR
                     END IF
                  END IF
               END IF
               LET l_cnt = l_cnt + 1
             END FOREACH
             
             LET l_cnt = l_cnt - 1 
             IF (l_cnt>10) THEN
               LET l_cnt = 10
             END IF
             #記錄測量值
             CASE l_cnt
               WHEN '1' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
               WHEN '2' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
               WHEN '3' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
               WHEN '4' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
                  LET sr5.l_qcbg002_4 = l_rec1[4].l_rec
               WHEN '5' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
                  LET sr5.l_qcbg002_4 = l_rec1[4].l_rec
                  LET sr5.l_qcbg002_5 = l_rec1[5].l_rec
               WHEN '6' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
                  LET sr5.l_qcbg002_4 = l_rec1[4].l_rec
                  LET sr5.l_qcbg002_5 = l_rec1[5].l_rec
                  LET sr5.l_qcbg002_6 = l_rec1[6].l_rec
               WHEN '7' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
                  LET sr5.l_qcbg002_4 = l_rec1[4].l_rec
                  LET sr5.l_qcbg002_5 = l_rec1[5].l_rec
                  LET sr5.l_qcbg002_6 = l_rec1[6].l_rec
                  LET sr5.l_qcbg002_7 = l_rec1[7].l_rec
               WHEN '8' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
                  LET sr5.l_qcbg002_4 = l_rec1[4].l_rec
                  LET sr5.l_qcbg002_5 = l_rec1[5].l_rec
                  LET sr5.l_qcbg002_6 = l_rec1[6].l_rec
                  LET sr5.l_qcbg002_7 = l_rec1[7].l_rec
                  LET sr5.l_qcbg002_8 = l_rec1[8].l_rec
               WHEN '9' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
                  LET sr5.l_qcbg002_4 = l_rec1[4].l_rec
                  LET sr5.l_qcbg002_5 = l_rec1[5].l_rec
                  LET sr5.l_qcbg002_6 = l_rec1[6].l_rec
                  LET sr5.l_qcbg002_7 = l_rec1[7].l_rec
                  LET sr5.l_qcbg002_8 = l_rec1[8].l_rec
                  LET sr5.l_qcbg002_9 = l_rec1[9].l_rec
               WHEN '10' 
                  LET sr5.l_qcbg002_1 = l_rec1[1].l_rec
                  LET sr5.l_qcbg002_2 = l_rec1[2].l_rec
                  LET sr5.l_qcbg002_3 = l_rec1[3].l_rec
                  LET sr5.l_qcbg002_4 = l_rec1[4].l_rec
                  LET sr5.l_qcbg002_5 = l_rec1[5].l_rec
                  LET sr5.l_qcbg002_6 = l_rec1[6].l_rec
                  LET sr5.l_qcbg002_7 = l_rec1[7].l_rec
                  LET sr5.l_qcbg002_8 = l_rec1[8].l_rec
                  LET sr5.l_qcbg002_9 = l_rec1[9].l_rec
                  LET sr5.l_qcbg002_10 = l_rec1[10].l_rec
             END CASE

             OUTPUT TO REPORT aqcr300_g01_subrep07(sr5.*)
          END FOREACH
          FINISH REPORT aqcr300_g01_subrep07 
            
            #缺點描述            
            LET l_subrep09_show = "N"
            LET g_sql = " SELECT qcbe003 ",
                        " FROM qcbe_t ",
                        " WHERE qcbedocno = '",sr1.qcbadocno ,"'  AND qcbeent = '",sr1.qcbaent,"' AND qcbe003 IS NOT NULL "
            LET l_cnt = 0
            LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
            PREPARE aqcr300_g01_repcur00_cnt_pre FROM l_sub_sql
            EXECUTE aqcr300_g01_repcur00_cnt_pre INTO l_cnt
            IF l_cnt > 0 THEN
               LET l_subrep09_show ="Y"
            END IF
            PRINTX l_subrep09_show
            START REPORT aqcr300_g01_subrep09
            LET l_cnt = 1
            DECLARE aqcr300_g01_repcur00 CURSOR FROM g_sql
            FOREACH aqcr300_g01_repcur00 INTO sr7.*
               
               OUTPUT TO REPORT aqcr300_g01_subrep09(sr7.*,l_cnt)
               LET l_cnt = l_cnt + 1
               
            END FOREACH
            FINISH REPORT aqcr300_g01_subrep09

          #單頭子報表1：批序號檢查明細
          LET g_sql = "SELECT qcbb001,qcbb002,qcbb003,qcbb004,qcbb005,qcbb006,NULL",
                      " FROM qcbb_t ",
                      " WHERE qcbbdocno = '",sr1.qcbadocno CLIPPED,"' AND qcbbent = '",sr1.qcbaent CLIPPED,"'",
                      " ORDER BY qcbb001 "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           
          START REPORT aqcr300_g01_subrep05

          DECLARE aqcr300_g01_repcur05 CURSOR FROM g_sql
          FOREACH aqcr300_g01_repcur05 INTO sr3.*
             IF NOT cl_null(sr3.qcbb006) THEN
               CALL aqcr300_g01_desc('1',5073,sr3.qcbb006) RETURNING sr3.l_qcbb006_desc
#               LET sr3.l_qcbb006_desc = sr3.qcbb006 CLIPPED,'.',sr3.l_qcbb006_desc CLIPPED
#             ELSE
#               LET sr3.l_qcbb006_desc = sr3.qcbb006 CLIPPED
             END IF
             OUTPUT TO REPORT aqcr300_g01_subrep05(sr3.*)
          END FOREACH
          FINISH REPORT aqcr300_g01_subrep05
#-----------------------------------------------------------------------------------------------
          #單頭子報表2：判定結果明細
          #161018-0001#1 若料件不使用品检判定等级功能，则不列印
          LET g_sql = "SELECT qcbcseq,qcbc001,NULL,qcbc002,NULL,qcbc012,NULL,qcbc013,NULL,qcbc003,trim(imaal_t.imaal003),trim(imaal_t.imaal004),",
                      "       qcbc004,qcbc007,qcbc009",
                      "  FROM qcbc_t LEFT OUTER JOIN imaal_t on imaal_t.imaal001 = qcbc_t.qcbc003 AND qcbc_t.qcbcent = imaal_t.imaalent AND imaal_t.imaal002 = '",g_dlang,"'",
                      " WHERE qcbcdocno = '",sr1.qcbadocno CLIPPED,"' AND qcbcent = '",sr1.qcbaent CLIPPED,"'",
                      " ORDER BY qcbcseq "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur06_cnt_pre INTO l_cnt
#           IF l_cnt > 0 THEN                         #161018-0001#1 marked
           IF l_cnt > 0 AND sr1.l_imae120 = 'Y' THEN  #161018-0001#1 add
              LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show                      
          START REPORT aqcr300_g01_subrep06

          DECLARE aqcr300_g01_repcur06 CURSOR FROM g_sql
          FOREACH aqcr300_g01_repcur06 INTO sr4.*
             IF NOT cl_null(sr4.qcbc001) THEN
               CALL aqcr300_g01_desc('1',1002,sr4.qcbc001) RETURNING sr4.l_qcbc001_desc
#               LET sr4.l_qcbc001_desc = sr4.qcbc001 CLIPPED,'.',sr4.l_qcbc001_desc CLIPPED
#             ELSE
#               LET sr4.l_qcbc001_desc = sr4.qcbc001 CLIPPED
             END IF
             IF NOT cl_null(sr4.qcbc012) THEN
               CALL aqcr300_g01_desc('1',5070,sr4.qcbc012) RETURNING sr4.l_qcbc012_desc
#               LET sr4.l_qcbc012_desc = sr4.qcbc012 CLIPPED,'.',sr4.l_qcbc012_desc CLIPPED
#             ELSE
#               LET sr4.l_qcbc012_desc = sr4.qcbc012 CLIPPED
             END IF
             IF NOT cl_null(sr4.qcbc013) THEN
               CALL aqcr300_g01_desc('1',5071,sr4.qcbc013) RETURNING sr4.l_qcbc013_desc
#               LET sr4.l_qcbc013_desc = sr4.qcbc013 CLIPPED,'.',sr4.l_qcbc013_desc CLIPPED
#             ELSE
#               LET sr4.l_qcbc013_desc = sr4.qcbc013 CLIPPED
             END IF             
             IF NOT cl_null(sr4.l_imaal003_imaal004) AND NOT cl_null(sr4.imaal004) THEN
               LET sr4.l_imaal003_imaal004 = sr4.l_imaal003_imaal004 CLIPPED,'/',sr4.imaal004
             END IF             

             
             

             SELECT oocql004 INTO sr4.l_qcbc002_desc
              FROM qcaol004
             WHERE qcaol001 = 'A'
               AND qcaol002 = sr4.qcbc002
               AND qcaol003 = g_dlang
               AND qcaolent = g_enterprise
#             LET sr4.l_qcbc002_desc = sr4.qcbc002,".",sr4.l_qcbc002_desc 
             
             OUTPUT TO REPORT aqcr300_g01_subrep06(sr4.*)
          END FOREACH
          FINISH REPORT aqcr300_g01_subrep06
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.qcbdseq
 
           #add-point:rep.a_group.qcbdseq.before name="rep.a_group.qcbdseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.qcbdseq.after name="rep.a_group.qcbdseq.after"


           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aqcr300_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aqcr300_g01_subrep01(sr2)
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
PRIVATE REPORT aqcr300_g01_subrep02(sr2)
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
PRIVATE REPORT aqcr300_g01_subrep03(sr2)
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
PRIVATE REPORT aqcr300_g01_subrep04(sr2)
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
 
{<section id="aqcr300_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcr300_g01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr1
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr20
   DEFINE r_desc   LIKE type_t.chr500
   #1.系統分類碼SCC 2.應用分類嗎ACC

      CASE p_class
         WHEN '1'
            SELECT trim(gzcbl004) INTO r_desc
              FROM gzcbl_t
             WHERE gzcbl001 = p_num
               AND gzcbl002 = p_target
               AND gzcbl003 = g_dlang
               
            
         WHEN '2'
            SELECT trim(gzaal003) INTO r_desc
              FROM gzaal_t
              LEFT OUTER JOIN gzaa_t on gzaa_t.gzaa001 = gzaal_t.gzaal001
             WHERE gzaal001 = p_num
               AND gzaa_t.gzaa004 = p_target
               AND gzaal002 = g_dlang
               
         
         WHEN '3'
            SELECT trim(oocql004) INTO r_desc
              FROM oocql_t
             WHERE oocql001 = p_num
               AND oocql002 = p_target
               AND oocql003 = g_dlang
               AND oocqlent = g_enterprise
               
      END CASE
#   IF NOT cl_null(p_target) THEN 
#      LET r_desc =p_target CLIPPED,".",r_desc CLIPPED
#   ELSE 
#      LET r_desc = p_target CLIPPED
#   END IF
   
   RETURN r_desc
END FUNCTION

 
{</section>}
 
{<section id="aqcr300_g01.other_report" readonly="Y" >}
# 單頭子報表：批序號檢驗明細
PRIVATE REPORT aqcr300_g01_subrep05(sr3)
DEFINE sr3          sr3_r
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT
# Descriptions...: 單頭子報表：判定結果明細
PRIVATE REPORT aqcr300_g01_subrep06(sr4)
DEFINE sr4          sr4_r
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

# Descriptions...: 單身子報表
# 11.21 修改為單身後表格化子報表
PRIVATE REPORT aqcr300_g01_subrep07(sr5)
DEFINE sr5          sr5_r


   ORDER EXTERNAL BY sr5.qcbdseq
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
            
        
        

            
END REPORT
# 11.21 新增
# 缺點原因子報表
PRIVATE REPORT aqcr300_g01_subrep08(sr6)
DEFINE sr6          sr6_r
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
END REPORT

# 11.21 新增
# 缺點描述子報表
PRIVATE REPORT aqcr300_g01_subrep09(sr7,l_cnt1)
DEFINE sr7          sr7_r
DEFINE l_cnt1        LIKE type_t.num5
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX l_cnt1
            PRINTX sr7.*
            
END REPORT

#檢驗規格與結果
PRIVATE REPORT aqcr300_g01_subrep10(sr8)
DEFINE sr8           sr8_r
DEFINE sr6           sr6_r
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_sub_sql       STRING

DEFINE l_subrep08_show  LIKE type_t.chr1

    ORDER EXTERNAL BY sr8.qcbdseq
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr8.*
            
        
          #11.21 缺點原因
          LET g_sql = "SELECT qcbe_t.qcbe001,NULL ",
                      "  FROM qcbe_t ",
                      " WHERE qcbe_t.qcbedocno = '",sr8.qcbddocno CLIPPED,"'",
                      "   AND qcbe_t.qcbeseq = '",sr8.qcbdseq  CLIPPED,"' AND qcbeent = '",sr8.qcbdent CLIPPED,"' "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep08_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aqcr300_g01_repcur08_cnt_pre FROM l_sub_sql
           EXECUTE aqcr300_g01_repcur08_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep08_show ="Y"
           END IF
           PRINTX l_subrep08_show
           
          START REPORT aqcr300_g01_subrep08

          DECLARE aqcr300_g01_repcur08 CURSOR FROM g_sql
          FOREACH aqcr300_g01_repcur08 INTO sr6.*
             CALL aqcr300_g01_desc('3',1053,sr6.qcbe001) RETURNING sr6.l_qcbe001_desc #缺点原因说明
             OUTPUT TO REPORT aqcr300_g01_subrep08(sr6.*)
          END FOREACH
          FINISH REPORT aqcr300_g01_subrep08 
END REPORT

 
{</section>}
 
