#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr930_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-02-02 17:26:15), PR版次:0002(2015-02-02 16:57:25)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: aapr930_x01
#+ Description: ...
#+ Creator....: 05016(2014-12-15 16:29:13)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="aapr930_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

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
       a1 LIKE type_t.chr100,         #apcald 
       a2 LIKE type_t.chr100,         #apcacomp 
       a3 LIKE type_t.chr100,         #xref001 
       a4 LIKE type_t.chr100,         #xref002 
       a5 LIKE type_t.chr100,         #apcasite 
       a6 LIKE type_t.chr10,         #chk1 
       a7 LIKE type_t.chr10,         #chk2 
       a8 LIKE type_t.chr10          #xrad004
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa003    LIKE glaa_t.glaa003 #會計參照表號
DEFINE g_day        LIKE type_t.num5 #帳零天數
DEFINE g_strdate    LIKE glav_t.glav004 #會計日期
DEFINE g_enddate    LIKE glav_t.glav004 #會計日期

DEFINE g_apcald     LIKE apca_t.apcald
DEFINE g_apcacomp   LIKE apca_t.apcacomp
DEFINE g_xref001    LIKE xref_t.xref001
DEFINE g_xref002    LIKE xref_t.xref002
DEFINE g_apcasite   LIKE apca_t.apcasite
DEFINE g_chk1       LIKE type_t.chr80
DEFINE g_chk2       LIKE type_t.chr80
DEFINE g_xrad004    LIKE xrad_t.xrad004

DEFINE g_wc_apcald   STRING
DEFINE g_wc_apcasite STRING

#end add-point
 
{</section>}
 
{<section id="aapr930_x01.main" readonly="Y" >}
PUBLIC FUNCTION aapr930_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr100         #tm.a1  apcald 
DEFINE  p_arg3 LIKE type_t.chr100         #tm.a2  apcacomp 
DEFINE  p_arg4 LIKE type_t.chr100         #tm.a3  xref001 
DEFINE  p_arg5 LIKE type_t.chr100         #tm.a4  xref002 
DEFINE  p_arg6 LIKE type_t.chr100         #tm.a5  apcasite 
DEFINE  p_arg7 LIKE type_t.chr10         #tm.a6  chk1 
DEFINE  p_arg8 LIKE type_t.chr10         #tm.a7  chk2 
DEFINE  p_arg9 LIKE type_t.chr10         #tm.a8  xrad004
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
   LET tm.a5 = p_arg6
   LET tm.a6 = p_arg7
   LET tm.a7 = p_arg8
   LET tm.a8 = p_arg9
 
   #add-point:報表元件參數準備 name="component.arg.prep"
    LET g_apcald   = tm.a1
    LET g_apcacomp = tm.a2
    LET g_xref001  = tm.a3
    LET g_xref002  = tm.a4
    LET g_apcasite = tm.a5
    LET g_chk1     = tm.a6
    LET g_chk2     = tm.a7
    LET g_xrad004  = tm.a8                 
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aapr930_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aapr930_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aapr930_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aapr930_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aapr930_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aapr930_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr930_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aapr930_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_apcald_desc.type_t.chr100,apca004_desc.type_t.chr100,apca100.apca_t.apca100,apca001_desc.type_t.chr100,apccdocno.apcc_t.apccdocno,apccseq.apcc_t.apccseq,apcc001.apcc_t.apcc001,ori_money.type_t.num20,loc_money.apcc_t.apcc118,apcadocdt.apca_t.apcadocdt,apcc004.apcc_t.apcc004,day2.type_t.chr500,day.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aapr930_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aapr930_x01_ins_prep()
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
             ?,?,?,?,?,?,?)"
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
 
{<section id="aapr930_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr930_x01_sel_prep()
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
 
#   #end add-point
#   LET g_select = " SELECT apcald,'',apca004,'',apca100,apca001,'','','','','','',apcadocdt,'','',''" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM apca_t,apcc_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("apca_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   CALL aapr930_x01_creat_temp()
   CALL aapr930_x01_insert_temp() 
   LET g_sql = " SELECT apcald,'',apca004,'',apca100,apca001,'',apccdocno,          ",
               "        apccseq,apcc001,ori_money,loc_money,                        ",
               "        apcadocdt,apcc004,'',day                                    ",
               "   FROM aapq930_tmp                                                 ",
               "  ORDER BY apca004,apcadocdt                                        "    
               
    LET g_sql = cl_sql_add_mask(g_sql)            
   #end add-point
   PREPARE aapr930_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aapr930_x01_curs CURSOR FOR aapr930_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr930_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapr930_x01_ins_data()
DEFINE sr RECORD 
   apcald LIKE apca_t.apcald, 
   l_apcald_desc LIKE type_t.chr100, 
   apca004 LIKE apca_t.apca004, 
   apca004_desc LIKE type_t.chr100, 
   apca100 LIKE apca_t.apca100, 
   apca001 LIKE apca_t.apca001, 
   apca001_desc LIKE type_t.chr100, 
   apccdocno LIKE apcc_t.apccdocno, 
   apccseq LIKE apcc_t.apccseq, 
   apcc001 LIKE apcc_t.apcc001, 
   ori_money LIKE type_t.num20, 
   loc_money LIKE apcc_t.apcc118, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apcc004 LIKE apcc_t.apcc004, 
   day2 LIKE type_t.chr500, 
   day LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_apcc004         LIKE apcc_t.apcc004  # 90 應收付款日 
DEFINE l_apcc010         LIKE apcc_t.apcc010  # 03 發票日期     
DEFINE l_apcc011         LIKE apcc_t.apcc011  # 01 交易單據日期
DEFINE l_apcc012         LIKE apcc_t.apcc012  # 05 立帳日期
DEFINE l_apcc013         LIKE apcc_t.apcc013  # 09 交易認定日期
DEFINE l_apcc014         LIKE apcc_t.apcc014  # 07 出入庫扣帳日期 
DEFINE l_apcf103         LIKE apcf_t.apcf103
DEFINE l_apcf113         LIKE apcf_t.apcf113
DEFINE l_apcf123         LIKE apcf_t.apcf123
DEFINE l_apcf133         LIKE apcf_t.apcf133
DEFINE l_xrea001         LIKE xrea_t.xrea001
DEFINE l_xrea002         LIKE xrea_t.xrea002
DEFINE l_glaa003         LIKE glaa_t.glaa003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
   
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aapr930_x01_curs INTO sr.*                               
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
       CALL s_ld_sel_glaa(sr.apcald,'glaa003') RETURNING  g_sub_success,l_glaa003      
       CALL s_fin_date_get_period_range(l_glaa003,g_xref001,g_xref002)RETURNING g_strdate,g_enddate 

       IF sr.apca001[1.1] ='0' THEN
         SELECT SUM(apcf103),SUM(apcf113),SUM(apcf123),SUM(apcf133)
           INTO l_apcf103,l_apcf113,l_apcf123,l_apcf133
           FROM apca_t,apcf_t
          WHERE apcaent = apcfent AND apcfent = g_enterprise           
            AND apcald  = apcfld  AND apcfld =  g_input.apcald
            AND apcadocno = apcfdocno
            AND apcf008 = sr.apccdocno
            AND apcf009 =  sr.apccseq
            AND apcadocdt > g_enddate
            AND apcastus = 'Y'
            IF cl_null(l_apcf103)THEN LET l_apcf103 = 0 END IF
            IF cl_null(l_apcf113)THEN LET l_apcf113 = 0 END IF
            IF cl_null(l_apcf123)THEN LET l_apcf123 = 0 END IF
            IF cl_null(l_apcf133)THEN LET l_apcf133 = 0 END IF
            
            LET sr.ori_money = sr.ori_money + l_apcf103
            LET sr.loc_money = sr.loc_money + l_apcf113            
       END IF
       
       #0204 2*給負數
       IF sr.apca001 = '02' OR sr.apca001 = '04' OR sr.apca001[1.1] = '2'  THEN  
          LET sr.ori_money = sr.ori_money * -1
          LET sr.loc_money = sr.loc_money * -1
       END IF
  
       #逾期天數
       LET sr.day2 = g_enddate - sr.apcc004 
       IF  sr.day2  < 0 THEN LET  sr.day2  = 0 END IF
       #上期年月_原幣期初金額
       CALL s_fin_date_get_last_period(g_glaa003,g_apcald,g_xref001,g_xref002)
           RETURNING g_sub_success,l_xrea001,l_xrea002            
       LET sr.day = ''
      SELECT apcc011,  apcc010  ,apcc012  ,apcc014  ,apcc013  ,apcc004
        INTO l_apcc011,l_apcc010,l_apcc012,l_apcc014,l_apcc013,l_apcc004
        FROM apcc_t
       WHERE apccent    = g_enterprise
         AND apccdocno  = sr.apccdocno
         AND apccseq    = sr.apccseq
      CASE  #取帳齡天數
        WHEN g_xrad004 = '01' 
           IF cl_null(l_apcc011) THEN #01 交易單據日期
              LET sr.day = g_enddate - sr.apcadocdt
           ELSE   
              LET sr.day = g_enddate - l_apcc011   
           END IF 
        WHEN g_xrad004 = '03' #發票日期     
          IF cl_null(l_apcc010) THEN
             LET sr.day = g_enddate - sr.apcadocdt
          ELSE   
             LET sr.day = g_enddate - l_apcc010 
          END IF            
        WHEN g_xrad004 = '05' #入庫日期 
            IF cl_null(l_apcc012) THEN
             LET sr.day = g_enddate - sr.apcadocdt
          ELSE   
             LET sr.day = g_enddate - l_apcc012 
          END IF                          
        WHEN g_xrad004 = '07' #07 出入庫扣帳日期 
           IF cl_null(l_apcc014) THEN
             LET sr.day = g_enddate - sr.apcadocdt
           ELSE   
             LET sr.day = g_enddate - l_apcc014 
           END IF      
        WHEN g_xrad004 = '09' #09 交易認定日期
           IF cl_null(l_apcc013) THEN
             LET sr.day = g_enddate - sr.apcadocdt
           ELSE   
             LET sr.day = g_enddate - l_apcc013 
           END IF          
        WHEN g_xrad004 = '90'      
          #09 應收付款日           
          IF cl_null(l_apcc004) THEN
            LET sr.day = g_enddate - sr.apcadocdt
          ELSE   
            LET sr.day = g_enddate - l_apcc004 
          END IF               
       END CASE   
       #負的天數給0天
       IF sr.day < 0 THEN LET sr.day = 0 END IF
      
       #組織/帳款單性質/交易對象/帳套
       IF NOT cl_null(s_desc_gzcbl004_desc('8502',sr.apca001))THEN      
          LET sr.apca001_desc = sr.apca001,".",s_desc_gzcbl004_desc('8502',sr.apca001)
       ELSE
          LET sr.apca001_desc = sr.apca001
       END IF
       IF NOt cl_null(s_desc_get_trading_partner_abbr_desc(sr.apca004)) THEN
          LET sr.apca004_desc = sr.apca004,".",s_desc_get_trading_partner_abbr_desc(sr.apca004)
       ELSE
          LET sr.apca004_desc = sr.apca004
       END IF         
       IF NOt cl_null(s_desc_get_ld_desc(sr.apcald)) THEN
          LET sr.l_apcald_desc = sr.apcald,".",s_desc_get_ld_desc(sr.apcald)
       ELSE
          LET sr.l_apcald_desc = sr.apcald
       END IF              
                   
                   
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_apcald_desc,sr.apca004_desc,sr.apca100,sr.apca001_desc,sr.apccdocno,sr.apccseq,sr.apcc001,sr.ori_money,sr.loc_money,sr.apcadocdt,sr.apcc004,sr.day2,sr.day
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aapr930_x01_execute"
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
 
{<section id="aapr930_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapr930_x01_rep_data()
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
 
{<section id="aapr930_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取臨時表
# Memo...........:
# Usage..........: CALL aapr930_x01_creat_temp()
# Date & Author..: 2014/12/15 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapr930_x01_creat_temp()
DROP TABLE aapq930_tmp;
      CREATE TEMP TABLE aapq930_tmp(
             apcborga      VARCHAR(10),          #來源組織
             apca001       VARCHAR(10),           #帳款單性質
             apccdocno     VARCHAR(20),         #單據號碼
             apccseq       INTEGER,           #項次
             apcc001       INTEGER,           #分期帳款序
             apca004       VARCHAR(10),           #交易對象     2
             apcadocdt     DATE,         #立帳日期
             apcc004       DATE,           #應兌現日
             day           VARCHAR(500),            #帳齡天數
             ori_money     VARCHAR(500),            #原幣未沖金額
             loc_money     VARCHAR(500),            #本幣未沖金額
             debt          VARCHAR(500),            #壞帳提列比率
             ori_debt      VARCHAR(500),            #壞帳原幣金額
             loc_debt      VARCHAR(500),            #壞帳本幣金額
             apca035       VARCHAR(24),           #應付科目      1
             apca015       VARCHAR(10),           #業務部門      3
             apca014       VARCHAR(20),           #業務人員      4
          apca004_apcc035  VARCHAR(500),
             apca100       VARCHAR(10),           #對象+科目
             xred1032      DECIMAL(20,6),           #原幣本期增加金額
             xred1132      DECIMAL(20,6),           #本幣本期增加金額
             apcald        VARCHAR(5)
              )       
   CREATE INDEX aap_ix1 ON aapq930_temp (apcald)
   DROP TABLE xrea_tmp;   
      CREATE TEMP TABLE xrea_tmp(
             xrea103       DECIMAL(20,6),
             xrea113       DECIMAL(20,6),
             xrea019       VARCHAR(24),            #應收付科目
             xrea009       VARCHAR(10),
             xrea011       VARCHAR(10),
             xrea016       VARCHAR(20),
             xrea100       VARCHAR(10))
              
END FUNCTION

################################################################################
# Descriptions...: 填充單身
# Memo...........:
# Usage..........: CALL aapr930_x01_insert_temp()
# Date & Author..: 2014/12/15 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapr930_x01_insert_temp()
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_glcb007       LIKE glcb_t.glcb007
DEFINE l_ld            LIKE glaa_t.glaald   #141218-00011#8
   
   CALL s_fin_account_center_sons_query('3',g_apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   #取得帳務中心底下的帳套範圍   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   
   DELETE FROM aapq930_tmp      
   LET g_sql = " SELECT glaald FROM glaa_t ",
               "  WHERE glaaent = ",g_enterprise," ",
               "    AND glaald IN ",g_wc_apcald CLIPPED,
               "    AND (glaa008 = 'Y' OR glaa014 = 'Y') " 
   PREPARE aapq930_ldp1 FROM g_sql
   DECLARE aapq930_ldc1 CURSOR FOR aapq930_ldp1     
   FOREACH aapq930_ldc1 INTO l_ld
      CALL s_ld_sel_glaa(l_ld,'glaa003') RETURNING  g_sub_success,g_glaa003      
      CALL s_fin_date_get_period_range(g_glaa003,g_xref001,g_xref002)RETURNING g_strdate,g_enddate   
       
      LET g_sql =   " INSERT INTO aapq930_tmp ",
                    " SELECT '',a.apca001,apccdocno,apccseq,apcc001,a.apca004,a.apcadocdt,                             ",
                    "        apcc004,'',                                                                               ",
                    "        (apcc108+COALESCE(apce109,0)+COALESCE(xrce109,0)+COALESCE(apce1091,0)),                   ",
                    "        (apcc118+apcc113+COALESCE(apce119,0)+COALESCE(xrce119,0)+COALESCE(apce1191,0)),'','','',  ",
                    "        a.apca035,a.apca015,a.apca014,a.apca004||'&'||a.apca035,a.apca100,                        ",
                    "        (apcc108+COALESCE(apce109,0)+COALESCE(xrce109,0)+COALESCE(apce1091,0)),        ",
                    "        (apcc118+apcc113+COALESCE(apce119,0)+COALESCE(xrce119,0)+COALESCE(apce1191,0)) ", 
                    "       ,a.apcald    ",                 #141218-00011#8
                    "   FROM apca_t a,apcb_t,apcc_t                                                                 ",
                    "   LEFT OUTER JOIN(SELECT apdald,apce003,apce004,apce005,apce048,SUM(apce109) apce109,         ",
                    "                SUM(apce119) apce119,SUM(apce129) apce129, SUM(apce139) apce139                ",
                    "               FROM apda_t,apce_t                                                              ",
                    "              WHERE apdaent = apceent AND apdaent = ",g_enterprise,"                           ",
                    "                AND apdald  = apceld   AND apdadocno = apcedocno                               ",
                    "                AND apdastus = 'Y'  AND apdadocdt >  '",g_enddate,"'                           ",
                    "              GROUP BY apdald,apce003,apce004,apce005,apce048) b                               ",
                    "                 ON b.apdald = apccld   AND b.apce003 = apccdocno AND b.apce004 = apccseq      ",
                    "                AND b.apce005 = apcc001 AND b.apce048 = apcc009                                ",  
                    "   LEFT OUTER JOIN(                                                                            ",
                    "               SELECT xrdald,xrce003,xrce004,xrce005,xrce048,SUM(xrce109) xrce109,             ",
                    "                      SUM(xrce119) xrce119,SUM(xrce129) xrce129, SUM(xrce139) xrce139          ",
                    "                 FROM xrce_t,xrda_t                                                            ",
                    "                WHERE xrdaent = ",g_enterprise," AND xrceent = xrdaent                         ",                                               
                    "                  AND xrceld  = xrdald                                                         ",
                    "                  AND xrcedocno = xrdadocno                                                    ",
                    "                  AND xrdastus = 'Y'                                                           ",
                    "                  AND xrdadocdt >  '",g_enddate,"'                                             ",
                    "                GROUP BY xrdald,xrce003,xrce004,xrce005,xrce048                                ",
                    "                   ) ON xrdald = apccld AND xrce003 = apccdocno AND xrce004 = apccseq          ",
                    "                  AND xrce005 = apcc001                                                        ", 
                    "   LEFT OUTER JOIN(SELECT apcald,apce003,apce004,apce005,apce048,SUM(apce109) apce1091,        ",
                    "                SUM(apce119) apce1191,SUM(apce129) apce1291, SUM(apce139) apce1391             ",
                    "               FROM apca_t,apce_t                                                              ",
                    "              WHERE apcaent = apceent  AND apcaent = ",g_enterprise,"                          ",
                    "                AND apcald  = apceld   AND apcedocno = apcadocno                               ",
                    "                AND apcastus = 'Y'  AND apcadocdt >  '",g_enddate,"'                           ",
                    "              GROUP BY apcald,apce003,apce004,apce005,apce048) c                               ",
                    "                 ON c.apcald = apccld   AND c.apce003 = apccdocno AND c.apce004 = apccseq      ",
                    "                AND c.apce005 = apcc001 AND c.apce048 = apcc009                                ",  
                    "   LEFT OUTER JOIN(SELECT apcald,apcf008,apcf009,apcf010,SUM(apcf103) apcf103,                 ",
                    "                SUM(apcf113) apcf113,SUM(apcf123) apcf123, SUM(apcf133) apcf133                ",
                    "               FROM apca_t,apcf_t                                                              ",
                    "              WHERE apcaent = apcfent  AND apcaent = ",g_enterprise,"                          ",
                    "                AND apcald  = apcfld   AND apcfdocno = apcadocno                               ",
                    "                AND apcastus = 'Y'  AND apcadocdt >  '",g_enddate,"'                           ",
                    "              GROUP BY apcald,apcf008,apcf009,apcf010) d                                       ",
                    "                 ON d.apcald = apccld   AND d.apcf008 = apccdocno AND d.apcf009 = apccseq      ",
                    "                AND d.apcf010 = apcc001                                                        ",                    
                    "  WHERE apcaent = apcbent AND apcaent = apccent AND apcaent = '",g_enterprise,"'               ",
                    "    AND a.apcadocno = apcbdocno AND a.apcadocno = apccdocno AND apcbseq = apccseq              ",
                    "    AND a.apcald   = apcbld AND a.apcald = apccld AND a.apcald  = '",l_ld,"'         ",
                    "    AND a.apcastus = 'Y'                                                                       ",
                    "    AND (apcc108 + COALESCE(apce109,0)+COALESCE(xrce109,0)+COALESCE(apcf103,0) > 0)    ",
                    "    AND a.apcasite IN " , g_wc_apcasite,
                    "    AND a.apcadocdt <= '",g_enddate,"'                                                         "
       #暫估類帳款納入分析否
       LET g_sql = g_sql CLIPPED,
                   " AND ((a.apca001 NOT LIKE '2%' AND a.apca001 NOT LIKE '0%') "
       
       IF g_chk1 = 'Y' THEN
          LET g_sql = g_sql CLIPPED,
                   " OR (a.apca001 LIKE '0%' ) "
       END IF
       
       IF g_chk2 = 'Y' THEN
          LET g_sql = g_sql CLIPPED,
                   " OR (a.apca001 LIKE '2%') "
       END IF
       
       LET g_sql = g_sql CLIPPED,")"
       PREPARE aapq930_ins_tmp_1 FROM g_sql
       EXECUTE aapq930_ins_tmp_1 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
       END IF    
   
   END FOREACH   #141218-00011#8
   
   SELECT COUNT(*) INTO l_cnt FROM aapq930_tmp   
END FUNCTION

 
{</section>}
 
