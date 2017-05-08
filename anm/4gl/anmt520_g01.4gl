#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt520_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-02-15 14:30:36), PR版次:0002(2016-03-17 11:15:41)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: anmt520_g01
#+ Description: ...
#+ Creator....: 06821(2015-09-03 08:59:03)
#+ Modifier...: 02291 -SD/PR- 02291
 
{</section>}
 
{<section id="anmt520_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#150922-00004#4  2015/09/24 By RayHuang 因應單據增加原立帳匯率,本幣金額,累積匯差,異動認列匯差 憑證同時調整
#160122-00001#21 2016/02/15 By yangtt   添加交易帳戶編號用戶權限空管    
#160122-00001#23 2016/03/16 By 07900    添加交易帳戶編號用戶權限空管,增加部门权限
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   nmcr118 LIKE nmcr_t.nmcr118, 
   l_xreb116 LIKE xreb_t.xreb116, 
   l_nmbb005 LIKE nmbb_t.nmbb005, 
   l_nmbb007 LIKE nmbb_t.nmbb007, 
   l_nmbb031_desc LIKE nmbb_t.nmbb031, 
   l_nmbb026_desc LIKE type_t.chr500, 
   l_nmbb026 LIKE nmbb_t.nmbb026, 
   l_nmbb043_desc LIKE type_t.chr500, 
   l_nmbb043 LIKE nmbb_t.nmbb043, 
   nmcr003 LIKE nmcr_t.nmcr003, 
   nmcq003 LIKE nmcq_t.nmcq003, 
   l_nmcq001_desc LIKE type_t.chr500, 
   nmcq001 LIKE nmcq_t.nmcq001, 
   nmcqdocno LIKE nmcq_t.nmcqdocno, 
   nmcq100 LIKE nmcq_t.nmcq100, 
   nmcqdocdt LIKE nmcq_t.nmcqdocdt, 
   nmcrseq LIKE nmcr_t.nmcrseq, 
   nmcr104 LIKE nmcr_t.nmcr104, 
   nmcr105 LIKE nmcr_t.nmcr105, 
   nmcr106 LIKE nmcr_t.nmcr106, 
   nmcr114 LIKE nmcr_t.nmcr114, 
   nmcr115 LIKE nmcr_t.nmcr115, 
   nmcr116 LIKE nmcr_t.nmcr116, 
   nmcr113 LIKE nmcr_t.nmcr113, 
   nmcr103 LIKE nmcr_t.nmcr103, 
   nmcr001 LIKE nmcr_t.nmcr001, 
   l_nmcrorga_desc LIKE type_t.chr500, 
   nmcrorga LIKE nmcr_t.nmcrorga, 
   nmcq101 LIKE nmcq_t.nmcq101, 
   l_nmcq003_desc LIKE type_t.chr500, 
   l_nmcqcomp_desc LIKE type_t.chr500, 
   nmcqcomp LIKE nmcq_t.nmcqcomp, 
   l_nmcqsite_desc LIKE type_t.chr500, 
   nmcqsite LIKE nmcq_t.nmcqsite, 
   nmcrent LIKE nmcr_t.nmcrent, 
   nmcqent LIKE nmcq_t.nmcqent
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
#150922-00004#4---s
DEFINE g_glca002       LIKE glca_t.glca002
DEFINE g_glaald        LIKE glaa_t.glaald
#150922-00004#4---e
DEFINE g_sql_bank      STRING                #160122-00001#23  
#end add-point
 
{</section>}
 
{<section id="anmt520_g01.main" readonly="Y" >}
PUBLIC FUNCTION anmt520_g01(p_arg1)
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
   
   LET g_rep_code = "anmt520_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL anmt520_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL anmt520_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL anmt520_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt520_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmt520_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #160122-00001#23 By 07900--add---str
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#23 By 07900--add---end
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT nmcr118,'','','','','','','','',nmcr003,nmcq003,'',nmcq001,nmcqdocno,nmcq100, 
       nmcqdocdt,nmcrseq,nmcr104,nmcr105,nmcr106,nmcr114,nmcr115,nmcr116,nmcr113,nmcr103,nmcr001,'', 
       nmcrorga,nmcq101,'','',nmcqcomp,'',nmcqsite,nmcrent,nmcqent"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM nmcq_t ",
                " LEFT JOIN nmcr_t ON nmcrent = nmcqent AND nmcqcomp = nmcrcomp AND nmcqdocno = nmcrdocno "
#   #end add-point
#    LET g_from = " FROM nmcq_t,nmcr_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #160122-00001#23--add---str
   LET g_where  = g_where  CLIPPED," AND (nmcq003 IN (",g_sql_bank,")
                              OR TRIM(nmcq003) IS NULL)"   #160122-00001#23 By 07900 --mod
   #160122-00001#23--add---end
   #end add-point
    LET g_order = " ORDER BY nmcqdocno,nmcrseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("nmcq_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE anmt520_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE anmt520_g01_curs CURSOR FOR anmt520_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="anmt520_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION anmt520_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   nmcr118 LIKE nmcr_t.nmcr118, 
   l_xreb116 LIKE xreb_t.xreb116, 
   l_nmbb005 LIKE nmbb_t.nmbb005, 
   l_nmbb007 LIKE nmbb_t.nmbb007, 
   l_nmbb031_desc LIKE nmbb_t.nmbb031, 
   l_nmbb026_desc LIKE type_t.chr500, 
   l_nmbb026 LIKE nmbb_t.nmbb026, 
   l_nmbb043_desc LIKE type_t.chr500, 
   l_nmbb043 LIKE nmbb_t.nmbb043, 
   nmcr003 LIKE nmcr_t.nmcr003, 
   nmcq003 LIKE nmcq_t.nmcq003, 
   l_nmcq001_desc LIKE type_t.chr500, 
   nmcq001 LIKE nmcq_t.nmcq001, 
   nmcqdocno LIKE nmcq_t.nmcqdocno, 
   nmcq100 LIKE nmcq_t.nmcq100, 
   nmcqdocdt LIKE nmcq_t.nmcqdocdt, 
   nmcrseq LIKE nmcr_t.nmcrseq, 
   nmcr104 LIKE nmcr_t.nmcr104, 
   nmcr105 LIKE nmcr_t.nmcr105, 
   nmcr106 LIKE nmcr_t.nmcr106, 
   nmcr114 LIKE nmcr_t.nmcr114, 
   nmcr115 LIKE nmcr_t.nmcr115, 
   nmcr116 LIKE nmcr_t.nmcr116, 
   nmcr113 LIKE nmcr_t.nmcr113, 
   nmcr103 LIKE nmcr_t.nmcr103, 
   nmcr001 LIKE nmcr_t.nmcr001, 
   l_nmcrorga_desc LIKE type_t.chr500, 
   nmcrorga LIKE nmcr_t.nmcrorga, 
   nmcq101 LIKE nmcq_t.nmcq101, 
   l_nmcq003_desc LIKE type_t.chr500, 
   l_nmcqcomp_desc LIKE type_t.chr500, 
   nmcqcomp LIKE nmcq_t.nmcqcomp, 
   l_nmcqsite_desc LIKE type_t.chr500, 
   nmcqsite LIKE nmcq_t.nmcqsite, 
   nmcrent LIKE nmcr_t.nmcrent, 
   nmcqent LIKE nmcq_t.nmcqent
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_xreb001       LIKE xreb_t.xreb001     #150922-00004#4add
   DEFINE l_xreb002       LIKE xreb_t.xreb002     #150922-00004#4add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH anmt520_g01_curs INTO sr_s.*
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
       #開票銀行/對象別/到期日/票據本幣/收票匯率  #150922-00004#4  add  nmbb005    
       SELECT DISTINCT nmbb043,nmbb026,nmbb031,nmbb007,nmbb005
         INTO sr_s.l_nmbb043,sr_s.l_nmbb026,sr_s.l_nmbb031_desc,sr_s.l_nmbb007,sr_s.l_nmbb005
         FROM nmbb_t,nmcq_t
        WHERE nmbbent = g_enterprise AND nmcqcomp = nmbbcomp AND nmcqdocno = sr_s.nmcqdocno 
         AND nmbbcomp= sr_s.nmcqcomp AND nmbbdocno = sr_s.nmcr003 AND nmbb030 = sr_s.nmcr001
       
       SELECT nmabl003 INTO sr_s.l_nmbb043_desc
         FROM nmabl_t 
        WHERE nmablent = g_enterprise AND nmabl001 = sr_s.l_nmbb043 AND nmabl002 = g_dlang
       #150922-00004#4---s
       SELECT glca002,glaald INTO g_glca002,g_glaald
         FROM glca_t,glaa_t 
        WHERE glcaent = glaaent AND glcald = glaald AND glaa014 = 'Y'
          AND glcaent = g_enterprise AND glaacomp = sr_s.nmcqcomp AND glca001 = 'NR'
          
       IF g_glca002 = '3' THEN
          CALL anmt520_g01_nmcqdocdt(sr_s.nmcqdocdt) RETURNING l_xreb001,l_xreb002
          SELECT xreb116 INTO sr_s.l_xreb116
            FROM xreb_t 
           WHERE xrebent = g_enterprise AND xrebld = g_glaald
             AND xreb001 = l_xreb001 AND xreb002 = l_xreb002
             AND xreb003 = 'NM' AND xreb004 = 'NR'  
             AND xreb005 = sr_s.nmcr003
          IF cl_null(sr_s.l_xreb116) THEN LET sr_s.l_xreb116 = 0  END IF
       END IF
       IF cl_null(sr_s.nmcr103) THEN LET sr_s.nmcr103 = 0  END IF
       IF cl_null(sr_s.nmcr104) THEN LET sr_s.nmcr104 = 0  END IF
       IF cl_null(sr_s.nmcr105) THEN LET sr_s.nmcr105 = 0  END IF
       IF cl_null(sr_s.nmcr113) THEN LET sr_s.nmcr113 = 0  END IF
       IF cl_null(sr_s.nmcr114) THEN LET sr_s.nmcr114 = 0  END IF
       IF cl_null(sr_s.nmcr115) THEN LET sr_s.nmcr115 = 0  END IF
       IF cl_null(sr_s.nmcr118) THEN LET sr_s.nmcr118 = 0  END IF
       IF cl_null(sr_s.l_nmbb007) THEN LET sr_s.l_nmbb007 = 0  END IF
       #150922-00004#4---e
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #組合名稱及說明     
       LET sr_s.l_nmcq001_desc = sr_s.nmcq001,":",s_desc_gzcbl004_desc('8714',sr_s.nmcq001)
       LET sr_s.l_nmbb026_desc = sr_s.l_nmbb026,".",s_desc_get_trading_partner_abbr_desc(sr_s.l_nmbb026)
       LET sr_s.l_nmcqsite_desc = sr_s.nmcqsite,".",s_desc_get_department_desc(sr_s.nmcqsite)
       LET sr_s.l_nmcqcomp_desc = sr_s.nmcqcomp,".",s_desc_get_department_desc(sr_s.nmcqcomp)       
       LET sr_s.l_nmcq003_desc  = sr_s.nmcq003,".",s_desc_get_nmas002_desc(sr_s.nmcq003)
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL anmt520_g01_initialize(sr_s.nmcq001,sr_s.l_nmcq001_desc) RETURNING sr_s.l_nmcq001_desc
       CALL anmt520_g01_initialize(sr_s.l_nmbb026,sr_s.l_nmbb026_desc) RETURNING sr_s.l_nmbb026_desc
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].nmcr118 = sr_s.nmcr118
       LET sr[l_cnt].l_xreb116 = sr_s.l_xreb116
       LET sr[l_cnt].l_nmbb005 = sr_s.l_nmbb005
       LET sr[l_cnt].l_nmbb007 = sr_s.l_nmbb007
       LET sr[l_cnt].l_nmbb031_desc = sr_s.l_nmbb031_desc
       LET sr[l_cnt].l_nmbb026_desc = sr_s.l_nmbb026_desc
       LET sr[l_cnt].l_nmbb026 = sr_s.l_nmbb026
       LET sr[l_cnt].l_nmbb043_desc = sr_s.l_nmbb043_desc
       LET sr[l_cnt].l_nmbb043 = sr_s.l_nmbb043
       LET sr[l_cnt].nmcr003 = sr_s.nmcr003
       LET sr[l_cnt].nmcq003 = sr_s.nmcq003
       LET sr[l_cnt].l_nmcq001_desc = sr_s.l_nmcq001_desc
       LET sr[l_cnt].nmcq001 = sr_s.nmcq001
       LET sr[l_cnt].nmcqdocno = sr_s.nmcqdocno
       LET sr[l_cnt].nmcq100 = sr_s.nmcq100
       LET sr[l_cnt].nmcqdocdt = sr_s.nmcqdocdt
       LET sr[l_cnt].nmcrseq = sr_s.nmcrseq
       LET sr[l_cnt].nmcr104 = sr_s.nmcr104
       LET sr[l_cnt].nmcr105 = sr_s.nmcr105
       LET sr[l_cnt].nmcr106 = sr_s.nmcr106
       LET sr[l_cnt].nmcr114 = sr_s.nmcr114
       LET sr[l_cnt].nmcr115 = sr_s.nmcr115
       LET sr[l_cnt].nmcr116 = sr_s.nmcr116
       LET sr[l_cnt].nmcr113 = sr_s.nmcr113
       LET sr[l_cnt].nmcr103 = sr_s.nmcr103
       LET sr[l_cnt].nmcr001 = sr_s.nmcr001
       LET sr[l_cnt].l_nmcrorga_desc = sr_s.l_nmcrorga_desc
       LET sr[l_cnt].nmcrorga = sr_s.nmcrorga
       LET sr[l_cnt].nmcq101 = sr_s.nmcq101
       LET sr[l_cnt].l_nmcq003_desc = sr_s.l_nmcq003_desc
       LET sr[l_cnt].l_nmcqcomp_desc = sr_s.l_nmcqcomp_desc
       LET sr[l_cnt].nmcqcomp = sr_s.nmcqcomp
       LET sr[l_cnt].l_nmcqsite_desc = sr_s.l_nmcqsite_desc
       LET sr[l_cnt].nmcqsite = sr_s.nmcqsite
       LET sr[l_cnt].nmcrent = sr_s.nmcrent
       LET sr[l_cnt].nmcqent = sr_s.nmcqent
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt520_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION anmt520_g01_rep_data()
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
          START REPORT anmt520_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT anmt520_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT anmt520_g01_rep
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
 
{<section id="anmt520_g01.rep" readonly="Y" >}
PRIVATE REPORT anmt520_g01_rep(sr1)
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
#150922-00004#4---s
DEFINE l_sum_nmcr103   LIKE type_t.num20_6  #合計nmcr103 票據原幣金額
DEFINE l_sum_nmcr104   LIKE type_t.num20_6  #合計nmcr104 利息收入原幣金額
DEFINE l_sum_nmcr105   LIKE type_t.num20_6  #合計nmcr105 貼現息原幣金額
DEFINE l_sum_nmbb007   LIKE type_t.num20_6  #合計nmbb007 票據本幣金額  
DEFINE l_sum_nmcr114   LIKE type_t.num20_6  #合計nmcr114 利息收入本幣金額  
DEFINE l_sum_nmcr115   LIKE type_t.num20_6  #合計nmcr115 貼現息本幣金額  
DEFINE l_sum_nmcr113   LIKE type_t.num20_6  #合計nmcr113 異動本幣金額
DEFINE l_sum_xreb116   LIKE type_t.num20_6  #合計xreb116 累積匯差
DEFINE l_sum_nmcr118   LIKE type_t.num20_6  #合計nmcr116 異動認列匯差
DEFINE l_xreb116_show  LIKE type_t.chr1     #累積匯差顯示否
#150922-00004#4---e
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.nmcqdocno,sr1.nmcrseq
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
        BEFORE GROUP OF sr1.nmcqdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.nmcqdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'nmcqent=' ,sr1.nmcqent,'{+}nmcqcomp=' ,sr1.nmcqcomp,'{+}nmcqdocno=' ,sr1.nmcqdocno         
            CALL cl_gr_init_apr(sr1.nmcqdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.nmcqdocno.before name="rep.b_group.nmcqdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.nmcqent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmcqdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmt520_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE anmt520_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT anmt520_g01_subrep01
           DECLARE anmt520_g01_repcur01 CURSOR FROM g_sql
           FOREACH anmt520_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmt520_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT anmt520_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT anmt520_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.nmcqdocno.after name="rep.b_group.nmcqdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.nmcrseq
 
           #add-point:rep.b_group.nmcrseq.before name="rep.b_group.nmcrseq.before"
           IF g_glca002 = '3' THEN
              LET l_xreb116_show = 'Y'
           ELSE
              LET l_xreb116_show = 'N'
           END IF
           PRINTX l_xreb116_show
           #end add-point:
 
 
           #add-point:rep.b_group.nmcrseq.after name="rep.b_group.nmcrseq.after"
           
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
                sr1.nmcqent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmcqdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.nmcrseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmt520_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE anmt520_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT anmt520_g01_subrep02
           DECLARE anmt520_g01_repcur02 CURSOR FROM g_sql
           FOREACH anmt520_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmt520_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT anmt520_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT anmt520_g01_subrep02
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
                sr1.nmcqent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmcqdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.nmcrseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmt520_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE anmt520_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT anmt520_g01_subrep03
           DECLARE anmt520_g01_repcur03 CURSOR FROM g_sql
           FOREACH anmt520_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmt520_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT anmt520_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT anmt520_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.nmcqdocno
 
           #add-point:rep.a_group.nmcqdocno.before name="rep.a_group.nmcqdocno.before"
           #150922-00004#4---s
           LET l_sum_nmcr103  = GROUP SUM(sr1.nmcr103)    #合計nmcr103 票據原幣金額
           LET l_sum_nmcr104  = GROUP SUM(sr1.nmcr104)    #合計nmcr104 利息收入原幣金額
           LET l_sum_nmcr105  = GROUP SUM(sr1.nmcr105)    #合計nmcr105 貼現息原幣金額
           LET l_sum_nmbb007  = GROUP SUM(sr1.l_nmbb007)  #合計nmbb007 票據本幣金額  
           LET l_sum_nmcr114  = GROUP SUM(sr1.nmcr114)    #合計nmcr114 利息收入本幣金額  
           LET l_sum_nmcr115  = GROUP SUM(sr1.nmcr115)    #合計nmcr115 貼現息本幣金額  
           LET l_sum_nmcr113  = GROUP SUM(sr1.nmcr113)    #合計nmcr113 異動本幣金額
           LET l_sum_xreb116  = GROUP SUM(sr1.l_xreb116)  #合計xreb116 累積匯差
           LET l_sum_nmcr118  = GROUP SUM(sr1.nmcr118)    #合計nmcr116 異動認列匯差
           PRINTX l_sum_nmcr103,l_sum_nmcr104,l_sum_nmcr105,l_sum_nmbb007
           PRINTX l_sum_nmcr114,l_sum_nmcr115,l_sum_nmcr113,l_sum_xreb116,l_sum_nmcr118
           #150922-00004#4---e
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.nmcqent CLIPPED ,"'", " AND  ooff003 = '", sr1.nmcqdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE anmt520_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE anmt520_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT anmt520_g01_subrep04
           DECLARE anmt520_g01_repcur04 CURSOR FROM g_sql
           FOREACH anmt520_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "anmt520_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT anmt520_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT anmt520_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.nmcqdocno.after name="rep.a_group.nmcqdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.nmcrseq
 
           #add-point:rep.a_group.nmcrseq.before name="rep.a_group.nmcrseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.nmcrseq.after name="rep.a_group.nmcrseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="anmt520_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT anmt520_g01_subrep01(sr2)
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
PRIVATE REPORT anmt520_g01_subrep02(sr2)
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
PRIVATE REPORT anmt520_g01_subrep03(sr2)
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
PRIVATE REPORT anmt520_g01_subrep04(sr2)
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
 
{<section id="anmt520_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 當編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
# Memo...........:
# Usage..........: CALL anmt520_g01_initialize(p_arg,p_exp)
# Date & Author..: 150903 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt520_g01_initialize(p_arg,p_exp)
   DEFINE p_arg   STRING
   DEFINE p_exp   STRING
   DEFINE r_exp   STRING
      IF cl_null(p_arg) THEN
         INITIALIZE r_exp TO NULL
      ELSE
         LET r_exp = p_exp
      END IF
   RETURN r_exp
END FUNCTION
################################################################################
# Descriptions...: 取得異動日期的上期年度 期別
# Memo...........:
# Usage..........: CALL anmt520_g01_nmcqdocdt(p_nmcqdocdt)
#                  RETURNING r_xreb001,xreb002
# Input parameter: p_nmcqdocdt 異動日期
# Return code....: r_xreb001   上期年度
#                : r_xreb002   上期期別
# Date & Author..: 15/09/24 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt520_g01_nmcqdocdt(p_nmcqdocdt)
DEFINE p_nmcqdocdt LIKE nmcq_t.nmcqdocdt
DEFINE r_xreb001   LIKE xreb_t.xreb001
DEFINE r_xreb002   LIKE xreb_t.xreb002

   LET r_xreb001 = YEAR(p_nmcqdocdt)
   SELECT glav006 INTO r_xreb002
     FROM glav_t,glaa_t
    WHERE glavent = glaaent AND glav001 = glaa003 AND glaald = g_glaald
      AND glav002 = r_xreb001 AND　glav004　= p_nmcqdocdt
   IF r_xreb002 = '1' THEN
      #如果期數是1 則取去年最大期數
      LET r_xreb001 = r_xreb001 - 1
      LET r_xreb002 = ''
      SELECT MAX(glav006) INTO r_xreb002
        FROM glav_t,glaa_t
       WHERE glavent = glaaent AND glav001 = glaa003 
         AND glaald = g_glaald AND glav002 = r_xreb001      
   ELSE   
      LET r_xreb002 = r_xreb002 - 1
   END IF
   RETURN r_xreb001,r_xreb002
END FUNCTION

 
{</section>}
 
{<section id="anmt520_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 