#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr550_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-11-09 16:13:21), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aapr550_g01
#+ Description: ...
#+ Creator....: 05016(2016-03-15 14:17:44)
#+ Modifier...: 08993 -SD/PR- 00000
 
{</section>}
 
{<section id="aapr550_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

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
   l_apgl005_ooag011 LIKE type_t.chr100, 
   apgl001 LIKE apgl_t.apgl001, 
   apgl002 LIKE apgl_t.apgl002, 
   l_apgl002_desc LIKE type_t.chr100, 
   apgl003 LIKE apgl_t.apgl003, 
   apgl004 LIKE apgl_t.apgl004, 
   apgl005 LIKE apgl_t.apgl005, 
   apgl006 LIKE apgl_t.apgl006, 
   apgl007 LIKE apgl_t.apgl007, 
   l_apgl006_desc LIKE type_t.chr100, 
   apgl008 LIKE apgl_t.apgl008, 
   apgl024 LIKE apgl_t.apgl024, 
   apgl026 LIKE apgl_t.apgl026, 
   l_apgl026_desc LIKE type_t.chr100, 
   l_apgl008_desc LIKE type_t.chr100, 
   apgl009 LIKE apgl_t.apgl009, 
   apgl014 LIKE apgl_t.apgl014, 
   apgl010 LIKE apgl_t.apgl010, 
   apgl011 LIKE apgl_t.apgl011, 
   apgl012 LIKE apgl_t.apgl012, 
   apgl013 LIKE apgl_t.apgl013, 
   apgl015 LIKE apgl_t.apgl015, 
   apgl016 LIKE apgl_t.apgl016, 
   apgl017 LIKE apgl_t.apgl017, 
   apgl018 LIKE apgl_t.apgl018, 
   apgl019 LIKE apgl_t.apgl019, 
   apgl020 LIKE apgl_t.apgl020, 
   apgl021 LIKE apgl_t.apgl021, 
   apgl022 LIKE apgl_t.apgl022, 
   apgl023 LIKE apgl_t.apgl023, 
   apgl025 LIKE apgl_t.apgl025, 
   apgl027 LIKE apgl_t.apgl027, 
   apgl028 LIKE apgl_t.apgl028, 
   apgl029 LIKE apgl_t.apgl029, 
   apgl030 LIKE apgl_t.apgl030, 
   apgl100 LIKE apgl_t.apgl100, 
   apgl101 LIKE apgl_t.apgl101, 
   apgl103 LIKE apgl_t.apgl103, 
   apglcomp LIKE apgl_t.apglcomp, 
   apgldocdt LIKE apgl_t.apgldocdt, 
   apgldocno LIKE apgl_t.apgldocno, 
   apglent LIKE apgl_t.apglent, 
   apglstus LIKE apgl_t.apglstus, 
   apgm001 LIKE apgm_t.apgm001, 
   apgm002 LIKE apgm_t.apgm002, 
   apgm003 LIKE apgm_t.apgm003, 
   l_apgm003_desc LIKE type_t.chr100, 
   apgm004 LIKE apgm_t.apgm004, 
   apgm005 LIKE apgm_t.apgm005, 
   apgm006 LIKE apgm_t.apgm006, 
   apgm105 LIKE apgm_t.apgm105, 
   apgmorga LIKE apgm_t.apgmorga, 
   apgmseq LIKE apgm_t.apgmseq, 
   apgmseq2 LIKE apgm_t.apgmseq2
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
TYPE sr3_r RECORD #子報表01
   apgcdocno        LIKE apgc_t.apgcdocno,
   apgcseq          LIKE apgc_t.apgcseq,
   apgc001          LIKE apgc_t.apgc001,
   apgc001_desc     LIKE type_t.chr100,
   apgc006          LIKE apgc_t.apgc006, #稅別
   apgc006_desc     LIKE apca_t.apca012, #稅率
   apgc009          LIKE apgc_t.apgc009, #發票號碼
   apgc014          LIKE apgc_t.apgc014, #付款帳戶
   apgc100          LIKE apgc_t.apgc100, 
   apgc101          LIKE apgc_t.apgc101,
   apgc103          LIKE apgc_t.apgc103, #原幣未稅金額
   apgc104          LIKE apgc_t.apgc104, #稅額
   apgc105          LIKE apgc_t.apgc105, #原幣含稅金額
   apgc113          LIKE apgc_t.apgc113, #本幣未稅金額
   apgc114          LIKE apgc_t.apgc114, #本幣稅額
   apgc115          LIKE apgc_t.apgc115 #本幣含稅金額
        END RECORD

#end add-point
 
{</section>}
 
{<section id="aapr550_g01.main" readonly="Y" >}
PUBLIC FUNCTION aapr550_g01(p_arg1)
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
   
   LET g_rep_code = "aapr550_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aapr550_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aapr550_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aapr550_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr550_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr550_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT CASE WHEN (SELECT ooag011 FROM ooag_t WHERE ooag001 = apgl005 AND ooagent = '",g_enterprise,"' ) ",
                  "         IS NUlL THEN apgl005 ELSE ",
                  "                  (SELECT apgl005||'.'||ooag011 FROM ooag_t WHERE ooag001 = apgl005 AND ooagent = '",g_enterprise,"') END, ",   
                  "        apgl001,            ",
                  "        apgl002,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = apgl002 AND pmaal002 = '",g_dlang,"'), ",                  
                  "        apgl003,apgl004,apgl005,apgl006,apgl007,                                                                                       ",
                  "                (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = apgl006 AND pmaal002 = '",g_dlang,"'), ",
                  " apgl008,apgl024,                                                                                                                      ",
                  " apgl026,(SELECT apgl026||'.'||gzcbl004 FROM gzcb_t,gzcbl_t WHERE gzcb001 = '9719' AND gzcb002 = apgl026 AND gzcb001 = gzcbl001  AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"'), ",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '263' AND oocql002 = apgl008 AND oocql003 = '",g_dlang,"'), ",                                     
                  "        apgl009,apgl014,apgl010,apgl011,apgl012,apgl013,apgl015,apgl016,apgl017,                            ",
                  "        apgl018,apgl019,apgl020,apgl021,apgl022,apgl023,apgl025,apgl027,apgl028,apgl029,apgl030,apgl100,    ",
                  "        apgl101,apgl103,apglcomp,apgldocdt,apgldocno,apglent,apglstus,apgm001,apgm002,                      ",
                  " apgm003,(SELECT apgb004 FROM apgb_t WHERE apgbent = '",g_enterprise,"' AND apgbdocno = apgl004 AND apgbseq = apgmseq2),  ",
                  " apgm004,apgm005,apgm006,apgm105,apgmorga,apgmseq,apgmseq2                                                   "                                                
                  
#   #end add-point
#   LET g_select = " SELECT '',apgl001,apgl002,'',apgl003,apgl004,apgl005,apgl006,apgl007,'',apgl008, 
#       apgl024,apgl026,'','',apgl009,apgl014,apgl010,apgl011,apgl012,apgl013,apgl015,apgl016,apgl017, 
#       apgl018,apgl019,apgl020,apgl021,apgl022,apgl023,apgl025,apgl027,apgl028,apgl029,apgl030,apgl100, 
#       apgl101,apgl103,apglcomp,apgldocdt,apgldocno,apglent,apglstus,apgm001,apgm002,apgm003,'',apgm004, 
#       apgm005,apgm006,apgm105,apgmorga,apgmseq,apgmseq2"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM  apgl_t  LEFT OUTER JOIN ( SELECT apgm_t.* FROM apgm_t WHERE apgment = '",g_enterprise,"' ) x  ON apgl_t.apglent  
                               = x.apgment AND apgl_t.apglcomp = x.apgmcomp AND apgl_t.apgldocno = x.apgmdocno"
#   #end add-point
#    LET g_from = " FROM  apgl_t  LEFT OUTER JOIN ( SELECT apgm_t.* FROM apgm_t  ) x  ON apgl_t.apglent  
#        = x.apgment AND apgl_t.apglcomp = x.apgmcomp AND apgl_t.apgldocno = x.apgmdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY apgldocno,apgmseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("apgl_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aapr550_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aapr550_g01_curs CURSOR FOR aapr550_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr550_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapr550_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_apgl005_ooag011 LIKE type_t.chr100, 
   apgl001 LIKE apgl_t.apgl001, 
   apgl002 LIKE apgl_t.apgl002, 
   l_apgl002_desc LIKE type_t.chr100, 
   apgl003 LIKE apgl_t.apgl003, 
   apgl004 LIKE apgl_t.apgl004, 
   apgl005 LIKE apgl_t.apgl005, 
   apgl006 LIKE apgl_t.apgl006, 
   apgl007 LIKE apgl_t.apgl007, 
   l_apgl006_desc LIKE type_t.chr100, 
   apgl008 LIKE apgl_t.apgl008, 
   apgl024 LIKE apgl_t.apgl024, 
   apgl026 LIKE apgl_t.apgl026, 
   l_apgl026_desc LIKE type_t.chr100, 
   l_apgl008_desc LIKE type_t.chr100, 
   apgl009 LIKE apgl_t.apgl009, 
   apgl014 LIKE apgl_t.apgl014, 
   apgl010 LIKE apgl_t.apgl010, 
   apgl011 LIKE apgl_t.apgl011, 
   apgl012 LIKE apgl_t.apgl012, 
   apgl013 LIKE apgl_t.apgl013, 
   apgl015 LIKE apgl_t.apgl015, 
   apgl016 LIKE apgl_t.apgl016, 
   apgl017 LIKE apgl_t.apgl017, 
   apgl018 LIKE apgl_t.apgl018, 
   apgl019 LIKE apgl_t.apgl019, 
   apgl020 LIKE apgl_t.apgl020, 
   apgl021 LIKE apgl_t.apgl021, 
   apgl022 LIKE apgl_t.apgl022, 
   apgl023 LIKE apgl_t.apgl023, 
   apgl025 LIKE apgl_t.apgl025, 
   apgl027 LIKE apgl_t.apgl027, 
   apgl028 LIKE apgl_t.apgl028, 
   apgl029 LIKE apgl_t.apgl029, 
   apgl030 LIKE apgl_t.apgl030, 
   apgl100 LIKE apgl_t.apgl100, 
   apgl101 LIKE apgl_t.apgl101, 
   apgl103 LIKE apgl_t.apgl103, 
   apglcomp LIKE apgl_t.apglcomp, 
   apgldocdt LIKE apgl_t.apgldocdt, 
   apgldocno LIKE apgl_t.apgldocno, 
   apglent LIKE apgl_t.apglent, 
   apglstus LIKE apgl_t.apglstus, 
   apgm001 LIKE apgm_t.apgm001, 
   apgm002 LIKE apgm_t.apgm002, 
   apgm003 LIKE apgm_t.apgm003, 
   l_apgm003_desc LIKE type_t.chr100, 
   apgm004 LIKE apgm_t.apgm004, 
   apgm005 LIKE apgm_t.apgm005, 
   apgm006 LIKE apgm_t.apgm006, 
   apgm105 LIKE apgm_t.apgm105, 
   apgmorga LIKE apgm_t.apgmorga, 
   apgmseq LIKE apgm_t.apgmseq, 
   apgmseq2 LIKE apgm_t.apgmseq2
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
    FOREACH aapr550_g01_curs INTO sr_s.*
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
       #IF NOT cl_null(s_desc_get_person_desc(sr_s.apgl005)) THEN
       #   LET sr_s.l_apgl005_ooag011 = sr_s.apgl005||"."||s_desc_get_person_desc(sr_s.apgl005)
       #ELSE
       #   LET sr_s.l_apgl005_ooag011 = sr_s.apgl005
       #END IF
       #LET sr_s.l_apgl002_desc = s_desc_get_trading_partner_abbr_desc(sr_s.apgl002)
       #SELECT apgb004 
       #  INTO sr_s.l_apgm003_desc
       #  FROM apgb_t WHERE apgbent = g_enterprise AND apgbdocno = sr_s.apgl004
       #   AND apgbseq = sr_s.apgmseq2
       #LET sr_s.l_apgl006_desc =  s_desc_get_trading_partner_abbr_desc(sr_s.apgl006)
       #
       #
       #IF NOT cl_null(s_desc_get_acc_desc('263',sr_s.apgl008)) THEN
       #   LET sr_s.l_apgl008_desc = sr_s.apgl008||"."||s_desc_get_acc_desc('263',sr_s.apgl008)
       #ELSE
       #   LET sr_s.l_apgl008_desc = sr_s.apgl008
       #END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_apgl005_ooag011 = sr_s.l_apgl005_ooag011
       LET sr[l_cnt].apgl001 = sr_s.apgl001
       LET sr[l_cnt].apgl002 = sr_s.apgl002
       LET sr[l_cnt].l_apgl002_desc = sr_s.l_apgl002_desc
       LET sr[l_cnt].apgl003 = sr_s.apgl003
       LET sr[l_cnt].apgl004 = sr_s.apgl004
       LET sr[l_cnt].apgl005 = sr_s.apgl005
       LET sr[l_cnt].apgl006 = sr_s.apgl006
       LET sr[l_cnt].apgl007 = sr_s.apgl007
       LET sr[l_cnt].l_apgl006_desc = sr_s.l_apgl006_desc
       LET sr[l_cnt].apgl008 = sr_s.apgl008
       LET sr[l_cnt].apgl024 = sr_s.apgl024
       LET sr[l_cnt].apgl026 = sr_s.apgl026
       LET sr[l_cnt].l_apgl026_desc = sr_s.l_apgl026_desc
       LET sr[l_cnt].l_apgl008_desc = sr_s.l_apgl008_desc
       LET sr[l_cnt].apgl009 = sr_s.apgl009
       LET sr[l_cnt].apgl014 = sr_s.apgl014
       LET sr[l_cnt].apgl010 = sr_s.apgl010
       LET sr[l_cnt].apgl011 = sr_s.apgl011
       LET sr[l_cnt].apgl012 = sr_s.apgl012
       LET sr[l_cnt].apgl013 = sr_s.apgl013
       LET sr[l_cnt].apgl015 = sr_s.apgl015
       LET sr[l_cnt].apgl016 = sr_s.apgl016
       LET sr[l_cnt].apgl017 = sr_s.apgl017
       LET sr[l_cnt].apgl018 = sr_s.apgl018
       LET sr[l_cnt].apgl019 = sr_s.apgl019
       LET sr[l_cnt].apgl020 = sr_s.apgl020
       LET sr[l_cnt].apgl021 = sr_s.apgl021
       LET sr[l_cnt].apgl022 = sr_s.apgl022
       LET sr[l_cnt].apgl023 = sr_s.apgl023
       LET sr[l_cnt].apgl025 = sr_s.apgl025
       LET sr[l_cnt].apgl027 = sr_s.apgl027
       LET sr[l_cnt].apgl028 = sr_s.apgl028
       LET sr[l_cnt].apgl029 = sr_s.apgl029
       LET sr[l_cnt].apgl030 = sr_s.apgl030
       LET sr[l_cnt].apgl100 = sr_s.apgl100
       LET sr[l_cnt].apgl101 = sr_s.apgl101
       LET sr[l_cnt].apgl103 = sr_s.apgl103
       LET sr[l_cnt].apglcomp = sr_s.apglcomp
       LET sr[l_cnt].apgldocdt = sr_s.apgldocdt
       LET sr[l_cnt].apgldocno = sr_s.apgldocno
       LET sr[l_cnt].apglent = sr_s.apglent
       LET sr[l_cnt].apglstus = sr_s.apglstus
       LET sr[l_cnt].apgm001 = sr_s.apgm001
       LET sr[l_cnt].apgm002 = sr_s.apgm002
       LET sr[l_cnt].apgm003 = sr_s.apgm003
       LET sr[l_cnt].l_apgm003_desc = sr_s.l_apgm003_desc
       LET sr[l_cnt].apgm004 = sr_s.apgm004
       LET sr[l_cnt].apgm005 = sr_s.apgm005
       LET sr[l_cnt].apgm006 = sr_s.apgm006
       LET sr[l_cnt].apgm105 = sr_s.apgm105
       LET sr[l_cnt].apgmorga = sr_s.apgmorga
       LET sr[l_cnt].apgmseq = sr_s.apgmseq
       LET sr[l_cnt].apgmseq2 = sr_s.apgmseq2
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr550_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapr550_g01_rep_data()
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
          START REPORT aapr550_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aapr550_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aapr550_g01_rep
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
 
{<section id="aapr550_g01.rep" readonly="Y" >}
PRIVATE REPORT aapr550_g01_rep(sr1)
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
DEFINE sr3       sr3_r
DEFINE l_subrep05_show LIKE type_t.chr1
DEFINE l_apgm105_sum     LIKE apgm_t.apgm105
DEFINE l_oodb004    LIKE oodb_t.oodb004
DEFINE l_oodb011    LIKE oodb_t.oodb011
DEFINE l_apcb105    LIKE apcb_t.apcb105
DEFINE l_apca013    LIKE apca_t.apca013
DEFINE l_apca012    LIKE apca_t.apca012
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.apgldocno,sr1.apgmseq
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
        BEFORE GROUP OF sr1.apgldocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.apgldocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'apglent=' ,sr1.apglent,'{+}apglcomp=' ,sr1.apglcomp,'{+}apgldocno=' ,sr1.apgldocno         
            CALL cl_gr_init_apr(sr1.apgldocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.apgldocno.before name="rep.b_group.apgldocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.apglent CLIPPED ,"'", " AND  ooff003 = '", sr1.apgldocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr550_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aapr550_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aapr550_g01_subrep01
           DECLARE aapr550_g01_repcur01 CURSOR FROM g_sql
           FOREACH aapr550_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr550_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aapr550_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aapr550_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.apgldocno.after name="rep.b_group.apgldocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.apgmseq
 
           #add-point:rep.b_group.apgmseq.before name="rep.b_group.apgmseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.apgmseq.after name="rep.b_group.apgmseq.after"
           
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
                sr1.apglent CLIPPED ,"'", " AND  ooff003 = '", sr1.apgldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apgmseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr550_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aapr550_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aapr550_g01_subrep02
           DECLARE aapr550_g01_repcur02 CURSOR FROM g_sql
           FOREACH aapr550_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr550_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aapr550_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aapr550_g01_subrep02
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
                sr1.apglent CLIPPED ,"'", " AND  ooff003 = '", sr1.apgldocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.apgmseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr550_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aapr550_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aapr550_g01_subrep03
           DECLARE aapr550_g01_repcur03 CURSOR FROM g_sql
           FOREACH aapr550_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr550_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aapr550_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aapr550_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apgldocno
 
           #add-point:rep.a_group.apgldocno.before name="rep.a_group.apgldocno.before"
           LET l_apgm105_sum = GROUP SUM(sr1.apgm105)
           PRINTX l_apgm105_sum
           
           #subrep 費用資訊
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show = 'N'
           LET g_sql = " SELECT apgcdocno,apgcseq,apgc001, ",
                       " (SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"'                  ",
                       "     AND oocql001 = '3117' AND oocql002 = apgc001 AND oocql003 = '",g_dlang,"'),    ",
                       "         apgc006,'' ,apgc009,apgc014,apgc100,apgc101,apgc103,               ",                                    
                       "         apgc104,apgc105,apgc113,apgc114,apgc115                            ",
                       "   FROM apgc_t WHERE apgcent = '",g_enterprise,"'                           ",                       
                       "    AND apgcdocno = '",sr1.apgldocno,"'                                     ",
                       "    AND apgccomp  = '",sr1.apglcomp,"'                                      "
           
           LET l_sub_sql = "   SELECT COUNT(*) FROM   ",
                           " ( SELECT apgcdocno,apgcseq FROM apgc_t    ", 
                           "    WHERE apgcent = '",g_enterprise,"'     ",                       
                           "      AND apgcdocno = '",sr1.apgldocno,"'  ",
                           "      AND apgccomp  = '",sr1.apglcomp,"' ) "  
           PREPARE aapr550_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE aapr550_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep05_show ="Y"
           END IF
           START REPORT aapr550_g01_subrep05
           DECLARE aapr550_g01_repcur05 CURSOR FROM g_sql
           FOREACH aapr550_g01_repcur05 INTO sr3.*
           
              #CALL s_desc_get_acc_desc('3117',sr3.apgc001) RETURNING sr3.apgc001_desc
              CALL s_tax_chk(sr1.apglcomp,sr3.apgc006)
                     RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
              #稅率
              LET sr3.apgc006_desc = l_apca012                                  
              OUTPUT TO REPORT aapr550_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT aapr550_g01_subrep05
           PRINTX l_subrep05_show
           
           
         
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.apglent CLIPPED ,"'", " AND  ooff003 = '", sr1.apgldocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapr550_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aapr550_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aapr550_g01_subrep04
           DECLARE aapr550_g01_repcur04 CURSOR FROM g_sql
           FOREACH aapr550_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapr550_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aapr550_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aapr550_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.apgldocno.after name="rep.a_group.apgldocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apgmseq
 
           #add-point:rep.a_group.apgmseq.before name="rep.a_group.apgmseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.apgmseq.after name="rep.a_group.apgmseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aapr550_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapr550_g01_subrep01(sr2)
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
PRIVATE REPORT aapr550_g01_subrep02(sr2)
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
PRIVATE REPORT aapr550_g01_subrep03(sr2)
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
PRIVATE REPORT aapr550_g01_subrep04(sr2)
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
 
{<section id="aapr550_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aapr550_g01.other_report" readonly="Y" >}

PRIVATE REPORT aapr550_g01_subrep05(sr3)
DEFINE sr3 sr3_r
DEFINE l_apgc103_sum  LIKE apgc_t.apgc103
DEFINE l_apgc104_sum  LIKE apgc_t.apgc104
DEFINE l_apgc105_sum  LIKE apgc_t.apgc105
DEFINE l_apgc113_sum  LIKE apgc_t.apgc113
DEFINE l_apgc114_sum  LIKE apgc_t.apgc114
DEFINE l_apgc115_sum  LIKE apgc_t.apgc115

 ORDER EXTERNAL BY sr3.apgcdocno
   FORMAT

      ON EVERY ROW
         PRINTX sr3.*
         PRINTX g_grNumFmt.*

      AFTER GROUP OF sr3.apgcdocno
         LET l_apgc103_sum = GROUP SUM(sr3.apgc103)
         LET l_apgc104_sum = GROUP SUM(sr3.apgc104)
         LET l_apgc105_sum = GROUP SUM(sr3.apgc105)
         LET l_apgc113_sum = GROUP SUM(sr3.apgc113)
         LET l_apgc114_sum = GROUP SUM(sr3.apgc114)
         LET l_apgc115_sum = GROUP SUM(sr3.apgc115)         
         PRINTX l_apgc103_sum,l_apgc104_sum,l_apgc105_sum,
                l_apgc113_sum,l_apgc114_sum,l_apgc115_sum
END REPORT

 
{</section>}
 
