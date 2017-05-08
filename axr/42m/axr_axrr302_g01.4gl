#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr302_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-12-28 11:07:34), PR版次:0006(2016-12-28 11:22:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: axrr302_g01
#+ Description: ...
#+ Creator....: 06816(2015-09-17 13:40:59)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="axrr302_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160428-00025#1  2016/04/28  By Hans     發票合計金額不正確修改
#161104-00049#3  2016/12/05  By 07900    報表輸出的【報表名稱】title,改為依單別名稱輸出
#161206-00042#1  2016/12/28  By 02114    账款客户为一次性交易对象时,名称带一次性交易对象的名称   
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
   xrcaent LIKE xrca_t.xrcaent, 
   xrcald LIKE xrca_t.xrcald, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca018 LIKE xrca_t.xrca018, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr200, 
   xrca008 LIKE xrca_t.xrca008, 
   l_xrca008_desc LIKE type_t.chr500, 
   xrca009 LIKE xrca_t.xrca009, 
   xrca010 LIKE xrca_t.xrca010, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca101 LIKE xrca_t.xrca101, 
   xrca011 LIKE xrca_t.xrca011, 
   xrca058 LIKE xrca_t.xrca058, 
   xrca058_desc LIKE type_t.chr200, 
   xrca003 LIKE xrca_t.xrca003, 
   xrca003_desc LIKE type_t.chr200, 
   xrca015 LIKE xrca_t.xrca015, 
   xrca015_desc LIKE type_t.chr200, 
   xrca038 LIKE xrca_t.xrca038, 
   xrca012 LIKE xrca_t.xrca012, 
   xrca035 LIKE xrca_t.xrca035, 
   xrca035_desc LIKE type_t.chr200, 
   xrca103 LIKE xrca_t.xrca103, 
   xrca104 LIKE xrca_t.xrca104, 
   xrca108 LIKE xrca_t.xrca108, 
   xrca113 LIKE xrca_t.xrca113, 
   xrca114 LIKE xrca_t.xrca114, 
   xrca118 LIKE xrca_t.xrca118, 
   xrcbld LIKE xrcb_t.xrcbld, 
   xrcbseq LIKE xrcb_t.xrcbseq, 
   xrcb002 LIKE xrcb_t.xrcb002, 
   xrcb004 LIKE xrcb_t.xrcb004, 
   xrcb005 LIKE xrcb_t.xrcb005, 
   xrcb021 LIKE xrcb_t.xrcb021, 
   xrcb021_desc LIKE type_t.chr200, 
   xrcb101 LIKE xrcb_t.xrcb101, 
   xrcb111 LIKE xrcb_t.xrcb111, 
   xrcb007 LIKE xrcb_t.xrcb007, 
   xrcb103 LIKE xrcb_t.xrcb103, 
   xrcb104 LIKE xrcb_t.xrcb104, 
   xrcb105 LIKE xrcb_t.xrcb105, 
   xrcb113 LIKE xrcb_t.xrcb113, 
   xrcb114 LIKE xrcb_t.xrcb114, 
   xrcb115 LIKE xrcb_t.xrcb115, 
   xrcbent LIKE xrcb_t.xrcbent, 
   xrcb047 LIKE xrcb_t.xrcb047
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
TYPE sr3_r      RECORD
   docno        LIKE isat_t.isatdocno, #160428-00025#1 
   seq          LIKE type_t.num10,
   isat001      LIKE isat_t.isat001,
   isat001_desc LIKE type_t.chr500,
   isat004      LIKE isat_t.isat004,
   isat007      LIKE isat_t.isat007,   #151013-00019#3
   isat113      LIKE isat_t.isat113,   
   isat114      LIKE isat_t.isat114,  
   isat115      LIKE isat_t.isat115
            END RECORD
#end add-point
 
{</section>}
 
{<section id="axrr302_g01.main" readonly="Y" >}
PUBLIC FUNCTION axrr302_g01(p_arg1)
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
   
   LET g_rep_code = "axrr302_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axrr302_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axrr302_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axrr302_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrr302_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr302_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xrcaent,xrcald,xrcadocno,xrcadocdt,xrca018,xrca004,NULL,xrca008,'',xrca009, 
       xrca010,xrca100,xrca101,xrca011,xrca058,NULL,xrca003,NULL,xrca015,NULL,xrca038,xrca012,xrca035, 
       NULL,xrca103,xrca104,xrca108,xrca113,xrca114,xrca118,xrcbld,xrcbseq,xrcb002,xrcb004,xrcb005,xrcb021, 
       NULL,xrcb101,xrcb111,xrcb007,xrcb103,xrcb104,xrcb105,xrcb113,xrcb114,xrcb115,xrcbent,xrcb047" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM xrca_t,xrcb_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xrcadocno,xrcbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_where = " WHERE " ,tm.wc CLIPPED,
                 "   AND xrcaent = '",g_enterprise,"'",
                 "   AND xrcaent = xrcbent ",
                 "   AND xrcald = xrcbld ",
                 "   AND xrcadocno = xrcbdocno "  
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xrca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axrr302_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axrr302_g01_curs CURSOR FOR axrr302_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrr302_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrr302_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xrcaent LIKE xrca_t.xrcaent, 
   xrcald LIKE xrca_t.xrcald, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca018 LIKE xrca_t.xrca018, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr200, 
   xrca008 LIKE xrca_t.xrca008, 
   l_xrca008_desc LIKE type_t.chr500, 
   xrca009 LIKE xrca_t.xrca009, 
   xrca010 LIKE xrca_t.xrca010, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca101 LIKE xrca_t.xrca101, 
   xrca011 LIKE xrca_t.xrca011, 
   xrca058 LIKE xrca_t.xrca058, 
   xrca058_desc LIKE type_t.chr200, 
   xrca003 LIKE xrca_t.xrca003, 
   xrca003_desc LIKE type_t.chr200, 
   xrca015 LIKE xrca_t.xrca015, 
   xrca015_desc LIKE type_t.chr200, 
   xrca038 LIKE xrca_t.xrca038, 
   xrca012 LIKE xrca_t.xrca012, 
   xrca035 LIKE xrca_t.xrca035, 
   xrca035_desc LIKE type_t.chr200, 
   xrca103 LIKE xrca_t.xrca103, 
   xrca104 LIKE xrca_t.xrca104, 
   xrca108 LIKE xrca_t.xrca108, 
   xrca113 LIKE xrca_t.xrca113, 
   xrca114 LIKE xrca_t.xrca114, 
   xrca118 LIKE xrca_t.xrca118, 
   xrcbld LIKE xrcb_t.xrcbld, 
   xrcbseq LIKE xrcb_t.xrcbseq, 
   xrcb002 LIKE xrcb_t.xrcb002, 
   xrcb004 LIKE xrcb_t.xrcb004, 
   xrcb005 LIKE xrcb_t.xrcb005, 
   xrcb021 LIKE xrcb_t.xrcb021, 
   xrcb021_desc LIKE type_t.chr200, 
   xrcb101 LIKE xrcb_t.xrcb101, 
   xrcb111 LIKE xrcb_t.xrcb111, 
   xrcb007 LIKE xrcb_t.xrcb007, 
   xrcb103 LIKE xrcb_t.xrcb103, 
   xrcb104 LIKE xrcb_t.xrcb104, 
   xrcb105 LIKE xrcb_t.xrcb105, 
   xrcb113 LIKE xrcb_t.xrcb113, 
   xrcb114 LIKE xrcb_t.xrcb114, 
   xrcb115 LIKE xrcb_t.xrcb115, 
   xrcbent LIKE xrcb_t.xrcbent, 
   xrcb047 LIKE xrcb_t.xrcb047
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_xrca001       LIKE xrca_t.xrca001
   DEFINE l_xrcb001       LIKE xrcb_t.xrcb001
   DEFINE l_xrcb022       LIKE xrcb_t.xrcb022
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #161206-00042#1 add lujh
   DEFINE l_xrca057       LIKE xrca_t.xrca057   #161206-00042#1 add lujh
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axrr302_g01_curs INTO sr_s.*
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
       #單頭說明
       
       CALL s_desc_get_trading_partner_abbr_desc(sr_s.xrca004) RETURNING sr_s.xrca004_desc
       
       #161206-00042#1--add--str--lujh
       SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = sr_s.xrca004
       SELECT xrca057 INTO l_xrca057 FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = sr_s.xrcald AND xrcadocno = sr_s.xrcadocno

       IF l_pmaa004 = '2' THEN    #一次性交易對象
          SELECT pmak003 INTO sr_s.xrca004_desc FROM pmak_t
		     WHERE pmakent = g_enterprise
		       AND pmak001 = l_xrca057
       END IF
       
       IF l_pmaa004 = '4' THEN    #员工
          CALL s_axrt300_xrca_ref('xrca003',l_xrca057,'','') RETURNING l_success,sr_s.xrca004_desc
       END IF
       #161206-00042#1--add--end--lujh
       
       CALL s_desc_get_person_desc(sr_s.xrca003) RETURNING sr_s.xrca003_desc
       CALL s_desc_get_department_desc(sr_s.xrca015) RETURNING sr_s.xrca015_desc
       CALL s_desc_get_acc_desc('295',sr_s.xrca058) RETURNING sr_s.xrca058_desc
       CALL s_desc_get_account_desc(sr_s.xrcald,sr_s.xrca035) RETURNING sr_s.xrca035_desc
       LET sr_s.xrca035_desc = sr_s.xrca035,' ',sr_s.xrca035_desc
       CALL s_axrt300_xrca_ref('xrca008',sr_s.xrca008,'','') RETURNING l_success,sr_s.l_xrca008_desc
       LET sr_s.l_xrca008_desc = sr_s.xrca008,' ',sr_s.l_xrca008_desc
       #單身說明
       CALL s_desc_get_account_desc(sr_s.xrcald,sr_s.xrcb021) RETURNING sr_s.xrcb021_desc
       
       SELECT xrca001,xrcb001,xrcb022 INTO l_xrca001,l_xrcb001,l_xrcb022 
       FROM xrca_t,xrcb_t
        WHERE xrcaent = xrcbent AND xrcadocno = xrcbdocno AND xrcald = xrcbld
          AND xrcaent = g_enterprise AND xrcadocno = sr_s.xrcadocno
          AND xrcald = sr_s.xrcald AND xrcbseq = sr_s.xrcbseq
       IF l_xrca001[1,1] = '1' OR l_xrca001 = '01' THEN
          LET sr_s.xrcb103 = sr_s.xrcb103 * l_xrcb022
          LET sr_s.xrcb104 = sr_s.xrcb104 * l_xrcb022
          LET sr_s.xrcb105 = sr_s.xrcb105 * l_xrcb022
          LET sr_s.xrcb113 = sr_s.xrcb113 * l_xrcb022
          LET sr_s.xrcb114 = sr_s.xrcb114 * l_xrcb022
          LET sr_s.xrcb115 = sr_s.xrcb115 * l_xrcb022
       END IF
       IF l_xrca001[1,1] = '2' OR l_xrca001 = '02' OR l_xrca001 = '04' THEN
          LET sr_s.xrcb103 = sr_s.xrcb103 * l_xrcb022 * -1
          LET sr_s.xrcb104 = sr_s.xrcb104 * l_xrcb022 * -1
          LET sr_s.xrcb105 = sr_s.xrcb105 * l_xrcb022 * -1
          LET sr_s.xrcb113 = sr_s.xrcb113 * l_xrcb022 * -1
          LET sr_s.xrcb114 = sr_s.xrcb114 * l_xrcb022 * -1
          LET sr_s.xrcb115 = sr_s.xrcb115 * l_xrcb022 * -1
       END IF
       IF l_xrcb001 MATCHES '[12]9' THEN
          LET sr_s.xrcb002 = s_desc_gzcbl004_desc('8340',l_xrcb001)
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       IF cl_null(sr_s.xrcb103) THEN LET sr_s.xrcb103 = 0 END IF
       IF cl_null(sr_s.xrcb104) THEN LET sr_s.xrcb104 = 0 END IF
       IF cl_null(sr_s.xrcb105) THEN LET sr_s.xrcb105 = 0 END IF
       IF cl_null(sr_s.xrcb113) THEN LET sr_s.xrcb113 = 0 END IF
       IF cl_null(sr_s.xrcb114) THEN LET sr_s.xrcb114 = 0 END IF
       IF cl_null(sr_s.xrcb115) THEN LET sr_s.xrcb115 = 0 END IF
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xrcaent = sr_s.xrcaent
       LET sr[l_cnt].xrcald = sr_s.xrcald
       LET sr[l_cnt].xrcadocno = sr_s.xrcadocno
       LET sr[l_cnt].xrcadocdt = sr_s.xrcadocdt
       LET sr[l_cnt].xrca018 = sr_s.xrca018
       LET sr[l_cnt].xrca004 = sr_s.xrca004
       LET sr[l_cnt].xrca004_desc = sr_s.xrca004_desc
       LET sr[l_cnt].xrca008 = sr_s.xrca008
       LET sr[l_cnt].l_xrca008_desc = sr_s.l_xrca008_desc
       LET sr[l_cnt].xrca009 = sr_s.xrca009
       LET sr[l_cnt].xrca010 = sr_s.xrca010
       LET sr[l_cnt].xrca100 = sr_s.xrca100
       LET sr[l_cnt].xrca101 = sr_s.xrca101
       LET sr[l_cnt].xrca011 = sr_s.xrca011
       LET sr[l_cnt].xrca058 = sr_s.xrca058
       LET sr[l_cnt].xrca058_desc = sr_s.xrca058_desc
       LET sr[l_cnt].xrca003 = sr_s.xrca003
       LET sr[l_cnt].xrca003_desc = sr_s.xrca003_desc
       LET sr[l_cnt].xrca015 = sr_s.xrca015
       LET sr[l_cnt].xrca015_desc = sr_s.xrca015_desc
       LET sr[l_cnt].xrca038 = sr_s.xrca038
       LET sr[l_cnt].xrca012 = sr_s.xrca012
       LET sr[l_cnt].xrca035 = sr_s.xrca035
       LET sr[l_cnt].xrca035_desc = sr_s.xrca035_desc
       LET sr[l_cnt].xrca103 = sr_s.xrca103
       LET sr[l_cnt].xrca104 = sr_s.xrca104
       LET sr[l_cnt].xrca108 = sr_s.xrca108
       LET sr[l_cnt].xrca113 = sr_s.xrca113
       LET sr[l_cnt].xrca114 = sr_s.xrca114
       LET sr[l_cnt].xrca118 = sr_s.xrca118
       LET sr[l_cnt].xrcbld = sr_s.xrcbld
       LET sr[l_cnt].xrcbseq = sr_s.xrcbseq
       LET sr[l_cnt].xrcb002 = sr_s.xrcb002
       LET sr[l_cnt].xrcb004 = sr_s.xrcb004
       LET sr[l_cnt].xrcb005 = sr_s.xrcb005
       LET sr[l_cnt].xrcb021 = sr_s.xrcb021
       LET sr[l_cnt].xrcb021_desc = sr_s.xrcb021_desc
       LET sr[l_cnt].xrcb101 = sr_s.xrcb101
       LET sr[l_cnt].xrcb111 = sr_s.xrcb111
       LET sr[l_cnt].xrcb007 = sr_s.xrcb007
       LET sr[l_cnt].xrcb103 = sr_s.xrcb103
       LET sr[l_cnt].xrcb104 = sr_s.xrcb104
       LET sr[l_cnt].xrcb105 = sr_s.xrcb105
       LET sr[l_cnt].xrcb113 = sr_s.xrcb113
       LET sr[l_cnt].xrcb114 = sr_s.xrcb114
       LET sr[l_cnt].xrcb115 = sr_s.xrcb115
       LET sr[l_cnt].xrcbent = sr_s.xrcbent
       LET sr[l_cnt].xrcb047 = sr_s.xrcb047
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrr302_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrr302_g01_rep_data()
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
          START REPORT axrr302_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axrr302_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axrr302_g01_rep
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
 
{<section id="axrr302_g01.rep" readonly="Y" >}
PRIVATE REPORT axrr302_g01_rep(sr1)
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
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_i              LIKE type_t.num10
DEFINE l_xrcacomp       LIKE xrca_t.xrcacomp
DEFINE l_xrcb103_sum    LIKE xrcb_t.xrcb103
DEFINE l_xrcb104_sum    LIKE xrcb_t.xrcb104
DEFINE l_xrcb105_sum    LIKE xrcb_t.xrcb105
DEFINE l_xrcb113_sum    LIKE xrcb_t.xrcb113
DEFINE l_xrcb114_sum    LIKE xrcb_t.xrcb114
DEFINE l_xrcb115_sum    LIKE xrcb_t.xrcb115
DEFINE l_oobxl003       LIKE oobxl_t.oobxl003  #161104-00049#3 add
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.xrcadocno,sr1.xrcbseq
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
        BEFORE GROUP OF sr1.xrcadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            CALL s_aooi200_fin_get_slip_desc(sr1.xrcadocno) RETURNING l_oobxl003 #161104-00049#3 add
            LET g_grPageHeader.title0201 = l_oobxl003                            #161104-00049#3 add
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xrcadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xrcaent=' ,sr1.xrcaent,'{+}xrcald=' ,sr1.xrcald,'{+}xrcadocno=' ,sr1.xrcadocno         
            CALL cl_gr_init_apr(sr1.xrcadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xrcadocno.before name="rep.b_group.xrcadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xrcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrcadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr302_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axrr302_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axrr302_g01_subrep01
           DECLARE axrr302_g01_repcur01 CURSOR FROM g_sql
           FOREACH axrr302_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr302_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axrr302_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axrr302_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xrcadocno.after name="rep.b_group.xrcadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xrcbseq
 
           #add-point:rep.b_group.xrcbseq.before name="rep.b_group.xrcbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xrcbseq.after name="rep.b_group.xrcbseq.after"
           
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
                sr1.xrcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrcadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xrcbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr302_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axrr302_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axrr302_g01_subrep02
           DECLARE axrr302_g01_repcur02 CURSOR FROM g_sql
           FOREACH axrr302_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr302_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axrr302_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axrr302_g01_subrep02
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
                sr1.xrcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrcadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xrcbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr302_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axrr302_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axrr302_g01_subrep03
           DECLARE axrr302_g01_repcur03 CURSOR FROM g_sql
           FOREACH axrr302_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr302_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axrr302_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axrr302_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xrcadocno
 
           #add-point:rep.a_group.xrcadocno.before name="rep.a_group.xrcadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xrcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrcadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr302_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axrr302_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axrr302_g01_subrep04
           DECLARE axrr302_g01_repcur04 CURSOR FROM g_sql
           FOREACH axrr302_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr302_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axrr302_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axrr302_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xrcadocno.after name="rep.a_group.xrcadocno.after"
           LET l_xrcb103_sum = GROUP SUM(sr1.xrcb103)
           LET l_xrcb104_sum = GROUP SUM(sr1.xrcb104)
           LET l_xrcb105_sum = GROUP SUM(sr1.xrcb105)
           LET l_xrcb113_sum = GROUP SUM(sr1.xrcb113)
           LET l_xrcb114_sum = GROUP SUM(sr1.xrcb114)
           LET l_xrcb115_sum = GROUP SUM(sr1.xrcb115)
           PRINTX l_xrcb103_sum,l_xrcb104_sum,l_xrcb105_sum
           PRINTX l_xrcb113_sum,l_xrcb114_sum,l_xrcb115_sum
           
           LET l_subrep05_show = "N"
           LET l_cnt = 0
           LET l_i = 1
          #LET g_sql = " SELECT '',isat001,'',isat004,isat113,isat114,isat115",         #151013-00019#3 mark
           LET g_sql = " SELECT isatdocno,'',isat001,'',isat004,isat007,isat113,isat114,isat115", #151013-00019#3 #160428-00025#1 add isatdocno
                       "   FROM isaf_t,isat_t ",
                       "  WHERE isafent = '",sr1.xrcaent,"' AND isafstus = 'Y' AND isatent = isafent ",
                       "    AND isaf035 = '",sr1.xrcadocno,"' AND isatdocno = isafdocno  ",
                       "    AND (isat014 = '11' OR isat014 = '21') ", #狀態 = 發票開立及折讓開立
                       "    AND isatdocno NOT IN(SELECT isatdocno FROM isat_t ",
                       "                          WHERE isatent = '",sr1.xrcaent,"'  ",
                       "                            AND isatdocno = isafdocno",
                       "                            AND isat014 <> '11' AND isat014 <> '21' )"
           #因為同一張發票若作廢,會有2筆在isat,一筆為開立狀態,一筆為作廢狀態,若被作廢了就不取用     
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr302_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE axrr302_g01_repcur05_cnt_pre INTO l_cnt
          
           IF l_cnt > 0 THEN 
             LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show   
           START REPORT axrr302_g01_subrep05
           DECLARE axrr302_g01_repcur05 CURSOR FROM g_sql
          
           FOREACH axrr302_g01_repcur05 INTO sr3.*
              LET l_xrcacomp = ''
              SELECT xrcacomp INTO l_xrcacomp
                FROM xrca_t
               WHERE xrcaent = g_enterprise AND xrcadocno = sr1.xrcadocno          
              LET sr3.seq = l_i
              CALL s_desc_get_invoice_type_desc1(l_xrcacomp,sr3.isat001) RETURNING sr3.isat001_desc
              LET sr3.isat001_desc = sr3.isat001," ",sr3.isat001_desc
              LET l_i = l_i + 1
              OUTPUT TO REPORT axrr302_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT axrr302_g01_subrep05
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xrcbseq
 
           #add-point:rep.a_group.xrcbseq.before name="rep.a_group.xrcbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xrcbseq.after name="rep.a_group.xrcbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axrr302_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axrr302_g01_subrep01(sr2)
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
PRIVATE REPORT axrr302_g01_subrep02(sr2)
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
PRIVATE REPORT axrr302_g01_subrep03(sr2)
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
PRIVATE REPORT axrr302_g01_subrep04(sr2)
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
 
{<section id="axrr302_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="axrr302_g01.other_report" readonly="Y" >}
################################################################################
# Descriptions...: 發票明細
# Memo...........:
# Usage..........: CALL axrr302_g01_subrep05(sr3)
# Input parameter: sr3,p_xrcadocno
# Return code....: 
# Date & Author..: 20150918 By RayHuang
# Modify.........:
################################################################################
PRIVATE REPORT axrr302_g01_subrep05(sr3)
DEFINE sr3 sr3_r
DEFINE l_isat113_sum    LIKE isat_t.isat113
DEFINE l_isat114_sum    LIKE isat_t.isat114
DEFINE l_isat115_sum    LIKE isat_t.isat115

    
    #ORDER EXTERNAL BY sr3.seq  #160428-00025#1 
    ORDER EXTERNAL BY sr3.docno #160428-00025#1 
    FORMAT
        
        ON EVERY ROW
           PRINTX g_grNumFmt.*
           PRINTX sr3.*
            
        #AFTER GROUP OF sr3.seq  #160428-00025#1  
        AFTER GROUP OF sr3.docno #160428-00025#1  
           LET l_isat113_sum = GROUP SUM(sr3.isat113)              
           LET l_isat114_sum = GROUP SUM(sr3.isat114)  
           LET l_isat115_sum = GROUP SUM(sr3.isat115)
           PRINTX l_isat113_sum,l_isat114_sum,l_isat115_sum
END REPORT

 
{</section>}
 
