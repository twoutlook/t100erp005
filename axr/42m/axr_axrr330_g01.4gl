#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr330_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2016-12-09 10:27:42), PR版次:0009(2016-12-29 13:58:19)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: axrr330_g01
#+ Description: ...
#+ Creator....: 01727(2015-03-17 15:51:59)
#+ Modifier...: 01727 -SD/PR- 01727
 
{</section>}
 
{<section id="axrr330_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#150911-00015#1   2015/10/08 By 01727  關於xrda的sql要多加上xrdastus <> 'X'的條件
#150828-00001#4   2016/03/28 By Reanna 製作英文版
#160518-00075#10  2016/07/26 By 07900  (依單別參數作權限管理)aooi200的控制組設定, 取7/8 設定的部門及人員
#161116-00056#1   2016/11/23 By 01727  STEP4修改语法错误
#161109-00048#3   2016/12/08 By 01727  1.畫面帳款日期區間主要抓取 axrt3* 與 axrq3* 為主, 再利用此區間的帳款抓取所有 axrt400 資料作為已收金額
#                                      2.畫面增加截止日期,回溯此日之後所發生的收款單作為扣除已收金額

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
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca100 LIKE xrca_t.xrca100, 
   xrcacomp LIKE xrca_t.xrcacomp, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcaent LIKE xrca_t.xrcaent, 
   pmaa016 LIKE type_t.chr1000, 
   l_date1 LIKE type_t.dat, 
   oofc012_1 LIKE type_t.chr1000, 
   oofc012_3 LIKE type_t.chr1000, 
   l_date2 LIKE type_t.dat, 
   l_xrcb001_gzcbl004 LIKE type_t.chr1000, 
   xrcb100 LIKE type_t.chr20, 
   l_xrca109 LIKE type_t.num20_6, 
   l_xrcc108 LIKE type_t.num20_6, 
   l_xrca004_pmaal004 LIKE type_t.chr1000, 
   xrcb051 LIKE type_t.chr1000, 
   xrcb047 LIKE type_t.chr1000, 
   l_order LIKE type_t.chr1000, 
   l_line LIKE type_t.chr2, 
   l_order1 LIKE type_t.chr10, 
   l_memo LIKE type_t.chr1000, 
   orders LIKE type_t.chr30, 
   xrcald LIKE xrca_t.xrcald, 
   l_isat004 LIKE isat_t.isat004, 
   xrca010 LIKE xrca_t.xrca010
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #帳務中心 
       a2 LIKE type_t.dat,         #帳款期間起 
       a3 LIKE type_t.dat,         #帳款期間迄 
       a4 STRING,                  #狀態碼 
       a5 STRING,                  #据点 
       a6 LIKE type_t.dat          #截止日期
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
   #子報表05資料
   lab       LIKE type_t.chr100, 
   xrca100   LIKE type_t.chr20, 
   xrca109   LIKE type_t.num20_6, 
   xrcc108   LIKE type_t.num20_6
END RECORD

TYPE sr4_r RECORD         
   #子報表06資料
   lab       LIKE type_t.chr100, 
   lab1      LIKE type_t.chr100, 
   xrca100   LIKE type_t.chr20, 
   xrca109   LIKE type_t.num20_6
END RECORD
DEFINE g_deadline  LIKE xrca_t.xrcadocdt   #161109-00048#3 Add
#end add-point
 
{</section>}
 
{<section id="axrr330_g01.main" readonly="Y" >}
PUBLIC FUNCTION axrr330_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  帳務中心 
DEFINE  p_arg3 LIKE type_t.dat         #tm.a2  帳款期間起 
DEFINE  p_arg4 LIKE type_t.dat         #tm.a3  帳款期間迄 
DEFINE  p_arg5 STRING                  #tm.a4  狀態碼 
DEFINE  p_arg6 STRING                  #tm.a5  据点 
DEFINE  p_arg7 LIKE type_t.dat         #tm.a6  截止日期
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
   LET tm.a5 = p_arg6
   LET tm.a6 = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL axrr330_g01_create_tmp()
   LET g_deadline = tm.a6   #161109-00048#3 Add
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axrr330_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axrr330_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axrr330_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axrr330_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrr330_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr330_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
 #  DEFINE g_sql_ctr2    STRING                #160518-00075#10
 #DEFINE g_sql_ctr3    STRING                #160518-00075#10
# DEFINE l_glaa024     LIKE glaa_t.glaa024   #160518-00075#10
#DEFINE l_site_len    LIKE type_t.num5      #SITE段长度 #160518-00075#10
#DEFINE l_slip_len    LIKE type_t.num5      #单别段长度 #160518-00075#10
#DEFINE l_i           LIKE type_t.num5      #160518-00075#10
#DEFINE l_j           LIKE type_t.num5      #160518-00075#10
#DEFINE l_xrcald       LIKE xrca_t.xrcald   #160518-00075#10
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET g_sql = "SELECT xrcb047 FROM xrcb_t WHERE xrcbent = '",g_enterprise,"'",
               "  AND xrcbld = ? AND xrcbdocno = ? AND xrcb047 IS NOT NULL"
   PREPARE axrr330_xrcb_prep FROM g_sql
   DECLARE axrr330_xrcb_curs CURSOR FOR axrr330_xrcb_prep

   LET g_sql = "SELECT xrde010 FROM xrde_t WHERE xrdeent = '",g_enterprise,"'",
               "  AND xrdeld = ? AND xrdedocno = ? AND xrde010 IS NOT NULL"
   PREPARE axrr330_xrde_prep FROM g_sql
   DECLARE axrr330_xrde_curs CURSOR FOR axrr330_xrde_prep

   LET g_sql = "SELECT xrce010 FROM xrce_t WHERE xrceent = '",g_enterprise,"'",
               "  AND xrceld = ? AND xrcedocno = ? AND xrce010 IS NOT NULL"
   PREPARE axrr330_xrce_prep FROM g_sql
   DECLARE axrr330_xrce_curs CURSOR FOR axrr330_xrce_prep

   LET g_sql = "SELECT apce010 FROM apce_t WHERE apceent = '",g_enterprise,"'",
               "  AND apceld = ? AND apcedocno = ? AND apce010 IS NOT NULL"
   PREPARE axrr330_apce_prep FROM g_sql
   DECLARE axrr330_apce_curs CURSOR FOR axrr330_apce_prep
   #160518-00075#10 add --s--
#   LET g_sql = " SELECT glaa024 FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaald = ? "
#   PREPARE axrq360_glaa_pre FROM g_sql
#
#   LET g_sql = " SELECT COUNT(*) FROM oobc_t,ooba_t WHERE oobcent = oobaent AND oobc001 = ooba001 AND oobc002 = ooba002 ",
#               "    AND oobc001 = ? AND oobc002 = substr(?,?,?) "
#   PREPARE axrq360_oobc_pre1 FROM g_sql 
#
#   LET g_sql = " SELECT COUNT(*) FROM oobc_t,ooba_t WHERE oobcent = oobaent AND oobc001 = ooba001 AND oobc002 = ooba002 ",  
#               "            AND oobc001 = ? ",
#               "            AND oobc002 = substr(?,?,?) ",
#               "            AND (oobc003 IN (SELECT ooha001 FROM ooha_t,oohc_t WHERE oohaent = oohcent AND ooha001 = oohc001 ",
#               "                                AND oohc002 = '",g_user,"' ",
#               "                                AND oohastus = 'Y'",  
#               "                                AND oohc003 <= '",g_today,"' AND (oohc004 IS NULL OR oohc004 > '",g_today,"') ",
#               "                              UNION ",
#               "                             SELECT ooha001 FROM ooha_t,oohb_t WHERE oohaent = oohbent AND ooha001 = oohb001 ",
#               "                                AND oohb002 = '",g_dept,"' ",
#               "                                AND oohastus = 'Y'",  
#               "                                AND oohb003 <= '",g_today,"' AND (oohb004 IS NULL OR oohb004 > '",g_today,"')) ",
#               "             OR ((oobc003 = '",g_user,"' AND oobc004 = '8') ",
#               "             OR (oobc003 = '",g_dept,"' AND oobc004 = '7')))"
#   PREPARE axrq360_oobc_pre2 FROM g_sql   
    #160518-00075#10 add --e--
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   CALL axrr330_g01_ins_tmp()
   #end add-point
   LET g_select = " SELECT ( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaalent = xrca_t.xrcaent AND pmaal_t.pmaal001 = xrca_t.xrca004 AND pmaal_t.pmaal002 = '" , 
       g_dlang,"'" ,"),xrca004,xrca100,xrcacomp,xrcadocdt,xrcadocno,xrcaent,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,xrcald,NULL,xrca010"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
 
   #end add-point
    LET g_from = " FROM xrca_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
    LET g_order = " ORDER BY xrcacomp,xrca004"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xrca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = "SELECT pmaal003,xrca004,xrca100,xrcacomp,xrcadocdt,xrcadocno,xrcaent,pmaa016,'",tm.a2,"',t1.oofc012,t2.oofc012,'",tm.a3,"',",
               "       xrcb001,xrca100,xrcb105,xrde109,xrca004||'.'||pmaal004,xrcb051,xrcb047,xrcacomp||'.'||xrca004,'',flag,'',orders,xrcald,isat004,xrca010,'' ",
               "  FROM axrr330_g01_tmp",
               "  LEFT OUTER JOIN oofc_t t1 ON t1.oofcent = xrcaent AND t1.oofc002 = pmaa027 AND t1.oofc008 = '1'",
               "  LEFT OUTER JOIN oofc_t t2 ON t2.oofcent = xrcaent AND t2.oofc002 = pmaa027 AND t2.oofc008 = '3'",
               "  WHERE 1=1",
               "    AND ",tm.wc,
               " ORDER BY xrcacomp,xrca004,flag ASC,xrcb001 ASC"
   #end add-point
   PREPARE axrr330_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axrr330_g01_curs CURSOR FOR axrr330_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrr330_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrr330_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca100 LIKE xrca_t.xrca100, 
   xrcacomp LIKE xrca_t.xrcacomp, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcaent LIKE xrca_t.xrcaent, 
   pmaa016 LIKE type_t.chr1000, 
   l_date1 LIKE type_t.dat, 
   oofc012_1 LIKE type_t.chr1000, 
   oofc012_3 LIKE type_t.chr1000, 
   l_date2 LIKE type_t.dat, 
   l_xrcb001_gzcbl004 LIKE type_t.chr1000, 
   xrcb100 LIKE type_t.chr20, 
   l_xrca109 LIKE type_t.num20_6, 
   l_xrcc108 LIKE type_t.num20_6, 
   l_xrca004_pmaal004 LIKE type_t.chr1000, 
   xrcb051 LIKE type_t.chr1000, 
   xrcb047 LIKE type_t.chr1000, 
   l_order LIKE type_t.chr1000, 
   l_line LIKE type_t.chr2, 
   l_order1 LIKE type_t.chr10, 
   l_memo LIKE type_t.chr1000, 
   orders LIKE type_t.chr30, 
   xrcald LIKE xrca_t.xrcald, 
   l_isat004 LIKE isat_t.isat004, 
   xrca010 LIKE xrca_t.xrca010
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
# DEFINE l_glaa024       LIKE glaa_t.glaa024  #160518-00075#10
#   DEFINE l_n1            LIKE type_t.num5     #160518-00075#10
#   DEFINE l_n2            LIKE type_t.num5    #160518-00075#10
#   DEFINE g_sql_ctr2       STRING                #160518-00075#10
#DEFINE g_sql_ctr3       STRING                #160518-00075#10
#DEFINE l_site_len       LIKE type_t.num5      #SITE段长度 #160518-00075#10
#DEFINE l_slip_len       LIKE type_t.num5      #单别段长度 #160518-00075#10
#DEFINE l_i              LIKE type_t.num5      #160518-00075#10
#DEFINE l_j              LIKE type_t.num5      #160518-00075#10
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
   #151231-00010#8--add--end
      #160518-00075#10 add s--- 
   #用g_site的單別參照表
#   SELECT glaa024 INTO l_glaa024 FROM glaa_t
#    WHERE glaaent = g_enterprise AND glaacomp = g_site
#      AND glaa014 = 'Y'
#
#   CALL s_control_get_docno_sql_q(g_user,g_dept,l_glaa024) RETURNING g_sub_success,g_sql_ctr2,g_sql_ctr3 
#     
#   #SITE 长度
#   LET l_site_len = cl_get_para(g_enterprise,g_site,'E-COM-0003')
#   
#   #单别长度
#   LET l_slip_len = cl_get_para(g_enterprise,g_site,'E-COM-0001')
#   
#   #第一个分隔符
#   IF cl_get_para(g_enterprise,g_site,'E-COM-0008') = '1' THEN    #据点+单别
#      LET l_i = l_site_len + 2
#      LET l_j = l_slip_len
#   ELSE
#      LET l_i = 1
#      LET l_j = l_slip_len
#   END IF    
#
   #160518-00075#10 add e--- 

#   LET l_n1 = 0               #160518-00075#10
#   LET l_n2 = 0               #160518-00075#10
#   LET l_glaa024 = NULL       #160518-00075#10
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH axrr330_g01_curs INTO sr_s.*
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
         #160518-00075#10 add s---
#         EXECUTE axrq360_glaa_pre USING sr_s.xrcald INTO l_glaa024 
#         
#         #检查单别是否有设置控制组，若有再继续检查 user或dept是否在該控制組內
#         EXECUTE axrq360_oobc_pre1 USING l_glaa024,sr_s.xrcadocno,l_i,l_j INTO l_n1
#         IF l_n1 != 0 THEN 
#            EXECUTE axrq360_oobc_pre2 USING l_glaa024,sr_s.xrcadocno,l_i,l_j INTO l_n2
#            IF l_n2 = 0 THEN 
#                #当查询的单号都是不可查询的单别时，将默认的第一笔删除，否则始终会查询出一笔不可查询的资料
#               IF l_cnt = 1 THEN 
#                   INITIALIZE sr_s.* TO NULL
#               END IF             
#               CONTINUE FOREACH
#            END IF
#         END IF   
         #160518-00075#10 add e ---
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].pmaal_t_pmaal003 = sr_s.pmaal_t_pmaal003
       LET sr[l_cnt].xrca004 = sr_s.xrca004
       LET sr[l_cnt].xrca100 = sr_s.xrca100
       LET sr[l_cnt].xrcacomp = sr_s.xrcacomp
       LET sr[l_cnt].xrcadocdt = sr_s.xrcadocdt
       LET sr[l_cnt].xrcadocno = sr_s.xrcadocno
       LET sr[l_cnt].xrcaent = sr_s.xrcaent
       LET sr[l_cnt].pmaa016 = sr_s.pmaa016
       LET sr[l_cnt].l_date1 = sr_s.l_date1
       LET sr[l_cnt].oofc012_1 = sr_s.oofc012_1
       LET sr[l_cnt].oofc012_3 = sr_s.oofc012_3
       LET sr[l_cnt].l_date2 = sr_s.l_date2
       LET sr[l_cnt].l_xrcb001_gzcbl004 = sr_s.l_xrcb001_gzcbl004
       LET sr[l_cnt].xrcb100 = sr_s.xrcb100
       LET sr[l_cnt].l_xrca109 = sr_s.l_xrca109
       LET sr[l_cnt].l_xrcc108 = sr_s.l_xrcc108
       LET sr[l_cnt].l_xrca004_pmaal004 = sr_s.l_xrca004_pmaal004
       LET sr[l_cnt].xrcb051 = sr_s.xrcb051
       LET sr[l_cnt].xrcb047 = sr_s.xrcb047
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].l_line = sr_s.l_line
       LET sr[l_cnt].l_order1 = sr_s.l_order1
       LET sr[l_cnt].l_memo = sr_s.l_memo
       LET sr[l_cnt].orders = sr_s.orders
       LET sr[l_cnt].xrcald = sr_s.xrcald
       LET sr[l_cnt].l_isat004 = sr_s.l_isat004
       LET sr[l_cnt].xrca010 = sr_s.xrca010
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       LET sr[l_cnt].l_line = 'N'
       SELECT ooag011 INTO  sr[l_cnt].xrcb051 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = sr_s.xrcb051
       IF l_cnt > 1 THEN
          IF sr[l_cnt].xrca004 = sr[l_cnt - 1].xrca004 AND sr[l_cnt].xrcacomp = sr[l_cnt - 1].xrcacomp THEN
             IF sr[l_cnt - 1].orders <> sr[l_cnt].orders THEN
                LET sr[l_cnt].l_line = 'Y'
             END IF
          END IF
       END IF

       IF sr[l_cnt].l_xrca109 = 0 THEN LET sr[l_cnt].l_xrca109 = NULL END IF
       IF sr[l_cnt].l_xrcc108 = 0 THEN LET sr[l_cnt].l_xrcc108 = NULL END IF

       CASE
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = '10'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('9743','10') CLIPPED
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = '11'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('8340','11') CLIPPED
             FOREACH axrr330_xrcb_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = '21'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('8340','21') CLIPPED
             LET sr[l_cnt].l_xrca109 = sr[l_cnt].l_xrca109 * -1
             LET sr[l_cnt].l_xrcc108 = sr[l_cnt].l_xrcc108 * -1           
             FOREACH axrr330_xrcb_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = '19'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('8340','19') CLIPPED
             FOREACH axrr330_xrcb_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = '29'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('8340','29') CLIPPED
             LET sr[l_cnt].l_xrca109 = sr[l_cnt].l_xrca109 * -1
             LET sr[l_cnt].l_xrcc108 = sr[l_cnt].l_xrcc108 * -1 
             FOREACH axrr330_xrcb_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = 'A'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('9743','A') CLIPPED
             FOREACH axrr330_xrde_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = 'A1'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('9743','A1') CLIPPED
             FOREACH axrr330_xrde_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = 'A2'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('9743','A2') CLIPPED
             FOREACH axrr330_xrce_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
          WHEN sr[l_cnt].l_xrcb001_gzcbl004 = 'A3'
             LET sr[l_cnt].l_xrcb001_gzcbl004 = s_desc_gzcbl004_desc('9743','A3') CLIPPED
             FOREACH axrr330_apce_curs USING sr_s.xrcald,sr_s.xrcadocno INTO sr[l_cnt].xrcb047
                EXIT FOREACH
             END FOREACH
       END CASE
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
 
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrr330_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrr330_g01_rep_data()
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
          START REPORT axrr330_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axrr330_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axrr330_g01_rep
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
 
{<section id="axrr330_g01.rep" readonly="Y" >}
PRIVATE REPORT axrr330_g01_rep(sr1)
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
DEFINE l_subrep_show    LIKE type_t.chr1
DEFINE sr3              sr3_r
DEFINE sr4              sr4_r
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_subrep06_show  LIKE type_t.chr1
DEFINE l_memo           LIKE type_t.chr1000
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.l_order1,sr1.l_xrcb001_gzcbl004,sr1.xrcadocdt,sr1.xrcadocno,sr1.xrca100
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
        BEFORE GROUP OF sr1.l_order
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            CALL s_desc_get_ooefl006_desc(sr1.xrcacomp) RETURNING g_grPageHeader.title0101
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_order
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xrcaent=' ,sr1.xrcaent,'{+}xrcald=' ,sr1.xrcald,'{+}xrcadocno=' ,sr1.xrcadocno         
            CALL cl_gr_init_apr(sr1.l_order)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xrcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr330_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axrr330_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axrr330_g01_subrep01
           DECLARE axrr330_g01_repcur01 CURSOR FROM g_sql
           FOREACH axrr330_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr330_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axrr330_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axrr330_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           PRINTX g_deadline  #161109-00048#3 Add
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_order1
 
           #add-point:rep.b_group.l_order1.before name="rep.b_group.l_order1.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_order1.after name="rep.b_group.l_order1.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_xrcb001_gzcbl004
 
           #add-point:rep.b_group.l_xrcb001_gzcbl004.before name="rep.b_group.l_xrcb001_gzcbl004.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_xrcb001_gzcbl004.after name="rep.b_group.l_xrcb001_gzcbl004.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xrcadocdt
 
           #add-point:rep.b_group.xrcadocdt.before name="rep.b_group.xrcadocdt.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xrcadocdt.after name="rep.b_group.xrcadocdt.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xrcadocno
 
           #add-point:rep.b_group.xrcadocno.before name="rep.b_group.xrcadocno.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xrcadocno.after name="rep.b_group.xrcadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xrca100
 
           #add-point:rep.b_group.xrca100.before name="rep.b_group.xrca100.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xrca100.after name="rep.b_group.xrca100.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
           LET l_subrep_show = 'Y'
           IF sr1.l_xrcb001_gzcbl004 <> '11' OR sr1.l_xrcb001_gzcbl004 <> '21' THEN LET l_subrep_show = 'N' END IF
           PRINTX l_subrep_show
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.xrcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr330_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axrr330_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axrr330_g01_subrep02
           DECLARE axrr330_g01_repcur02 CURSOR FROM g_sql
           FOREACH axrr330_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr330_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axrr330_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axrr330_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.xrcaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr330_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axrr330_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axrr330_g01_subrep03
           DECLARE axrr330_g01_repcur03 CURSOR FROM g_sql
           FOREACH axrr330_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr330_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axrr330_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axrr330_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           #合計
           LET g_sql = "SELECT '',xrca100,SUM(xrcb105),SUM(xrde109) FROM axrr330_g01_tmp ",
                       " WHERE xrcacomp = '",sr1.xrcacomp,"'",
                       "   AND xrca004  = '",sr1.xrca004,"'",
                       "   AND xrcb001 <> '10'",
                       " GROUP BY xrca100"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr330_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE axrr330_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
             LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show                           
           START REPORT axrr330_g01_subrep05  
           DECLARE axrr330_g01_repcur05 CURSOR FROM g_sql
           LET l_cnt = 0
           FOREACH axrr330_g01_repcur05 INTO sr3.*
              IF l_cnt = 0 THEN
                 LET l_cnt = 1
                #LET sr3.lab = cl_getmsg("axc-00383",g_lang)   #150828-00001#4 mark
                 LET sr3.lab = cl_getmsg("axc-00383",g_dlang)  #150828-00001#4
              END IF
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr330_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              OUTPUT TO REPORT axrr330_g01_subrep05(sr3.*)
           END FOREACH 
           FINISH REPORT axrr330_g01_subrep05

           #總計
           LET g_sql = "SELECT '','',xrca100,SUM(xrcb105 - xrde109) FROM axrr330_g01_tmp ",
                       " WHERE xrcacomp = '",sr1.xrcacomp,"'",
                       "   AND xrca004  = '",sr1.xrca004,"'",
                       " GROUP BY xrca100"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr330_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE axrr330_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
             LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show                           
           START REPORT axrr330_g01_subrep06
           DECLARE axrr330_g01_repcur06 CURSOR FROM g_sql
           LET l_cnt = 0
           FOREACH axrr330_g01_repcur06 INTO sr4.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr330_g01_repcur06:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              IF l_cnt = 0 THEN
                 LET l_cnt = 1
                 #150828-00001#4 mark ------
                 #LET sr4.lab = cl_getmsg("axr-00316",g_lang)
                 #LET sr4.lab1= cl_getmsg("axr-00317",g_lang)
                 #150828-00001#4 mark end---
                 #150828-00001#4 add ------
                 LET sr4.lab = cl_getmsg("axr-00316",g_dlang)
                 LET sr4.lab1= cl_getmsg("axr-00317",g_dlang)
                 #150828-00001#4 add end---
              END IF
              OUTPUT TO REPORT axrr330_g01_subrep06(sr4.*)
           END FOREACH 
           FINISH REPORT axrr330_g01_subrep06

           #備註
           #150828-00001#4 mark ------
           #LET l_memo = cl_getmsg_parm("axr-00306",g_lang,tm.a3) CLIPPED,"\r\n"
           #LET l_memo = l_memo,cl_getmsg("ais-00182",g_lang) CLIPPED,"\r\n"
           #LET l_memo = l_memo,cl_getmsg("axr-00305",g_lang) CLIPPED,"\r\n\r\n"
           #LET l_memo = l_memo,cl_getmsg("ais-00184",g_lang) CLIPPED,"\r\n\r\n"
           #LET l_memo = l_memo,cl_getmsg("ais-00185",g_lang) CLIPPED
           #150828-00001#4 mark end---
           #150828-00001#4 add ------
           LET l_memo = ""
           IF g_dlang = "en_US" THEN
              LET l_memo = cl_getmsg("axr-01003",g_dlang) CLIPPED,"\r\n\r\n"
              LET l_memo = l_memo,cl_getmsg_parm("axr-01004",g_dlang,tm.a3) CLIPPED,"\r\n"
              LET l_memo = l_memo,cl_getmsg("axr-01005",g_dlang) CLIPPED,"\r\n"
              LET l_memo = l_memo,cl_getmsg("axr-01006",g_dlang) CLIPPED,"\r\n"
              LET l_memo = l_memo,cl_getmsg("axr-01007",g_dlang) CLIPPED,"\r\n\r\n"
           ELSE
              LET l_memo = cl_getmsg_parm("axr-00306",g_dlang,tm.a3) CLIPPED,"\r\n"
              LET l_memo = l_memo,cl_getmsg("ais-00182",g_dlang) CLIPPED,"\r\n"
           END IF
           LET l_memo = l_memo,cl_getmsg("axr-00305",g_dlang) CLIPPED,"\r\n\r\n"
           LET l_memo = l_memo,cl_getmsg("ais-00184",g_dlang) CLIPPED,"\r\n\r\n"
           LET l_memo = l_memo,cl_getmsg("ais-00185",g_dlang) CLIPPED
           #150828-00001#4 add end---
           PRINTX l_memo

           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xrcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr330_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axrr330_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axrr330_g01_subrep04
           DECLARE axrr330_g01_repcur04 CURSOR FROM g_sql
           FOREACH axrr330_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr330_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axrr330_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axrr330_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order1
 
           #add-point:rep.a_group.l_order1.before name="rep.a_group.l_order1.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_order1.after name="rep.a_group.l_order1.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_xrcb001_gzcbl004
 
           #add-point:rep.a_group.l_xrcb001_gzcbl004.before name="rep.a_group.l_xrcb001_gzcbl004.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_xrcb001_gzcbl004.after name="rep.a_group.l_xrcb001_gzcbl004.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xrcadocdt
 
           #add-point:rep.a_group.xrcadocdt.before name="rep.a_group.xrcadocdt.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xrcadocdt.after name="rep.a_group.xrcadocdt.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xrcadocno
 
           #add-point:rep.a_group.xrcadocno.before name="rep.a_group.xrcadocno.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xrcadocno.after name="rep.a_group.xrcadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xrca100
 
           #add-point:rep.a_group.xrca100.before name="rep.a_group.xrca100.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xrca100.after name="rep.a_group.xrca100.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axrr330_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axrr330_g01_subrep01(sr2)
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
PRIVATE REPORT axrr330_g01_subrep02(sr2)
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
PRIVATE REPORT axrr330_g01_subrep03(sr2)
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
PRIVATE REPORT axrr330_g01_subrep04(sr2)
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
 
{<section id="axrr330_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axrr330_g01_create_tmp()
#                  RETURNING ---
# Input parameter:
# Return code....: 
# Date & Author..: 2015/03/18 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrr330_g01_create_tmp()

   DROP TABLE axrr330_g01_tmp;
   CREATE TEMP TABLE axrr330_g01_tmp(
      xrcaent         SMALLINT,
      xrca004         VARCHAR(10),
      pmaa016         VARCHAR(80),
      pmaa027         VARCHAR(20),
      pmaal003        VARCHAR(255),
      pmaal004        VARCHAR(80),
      xrca100         VARCHAR(10),
      xrcacomp        VARCHAR(10),
      xrcadocno       VARCHAR(20),
      xrcadocdt       DATE,
      xrcb001         VARCHAR(20),
      xrcb051         VARCHAR(20),
      xrcb105         DECIMAL(20,6),
      xrde109         DECIMAL(20,6),
      xrcb047         VARCHAR(255),
      flag            VARCHAR(1),
      orders          VARCHAR(1),
      xrcald          VARCHAR(5),
      isat004         VARCHAR(20),
      xrca010         DATE,
      xrcbdocno       VARCHAR(20)     #紀錄xrcbdocno的值,以方便查詢發票號碼
      )

END FUNCTION

################################################################################
# Descriptions...: 資料匯入臨時表
# Memo...........:
# Usage..........: CALL axrr330_g01_ins_tmp()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/18 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrr330_g01_ins_tmp()
DEFINE l_wc         STRING
DEFINE l_syear      LIKE type_t.num5
DEFINE l_smonth     LIKE type_t.num5
DEFINE l_tmp        RECORD
       xrcacomp     LIKE xrca_t.xrcacomp,
       flag         LIKE type_t.chr1,
       orders       LIKE type_t.chr1,
       xrcald       LIKE xrca_t.xrcald,
       isat004      LIKE isat_t.isat004,
       xrcbdocno    LIKE xrcb_t.xrcbdocno
                    END RECORD
DEFINE l_success    LIKE type_t.chr1
DEFINE l_s          LIKE type_t.chr1
DEFINE l_isafdocno  LIKE isaf_t.isafdocno
DEFINE ls_wc1       STRING
DEFINE l_syear1     LIKE type_t.num5      #20150818
DEFINE l_smonth1    LIKE type_t.num5      #20150818
DEFINE l_a4         STRING                #161116-00056#1 Add

   LET l_syear  = YEAR(tm.a2)
   LET l_smonth = MONTH(tm.a2)
   #20150818
   IF l_smonth = 1 THEN
      LET l_syear1 = l_syear-1
      LET l_smonth1= 12
   ELSE
      LET l_syear1 = l_syear
      LET l_smonth1= l_smonth - 1
   END IF
   #20150818
   LET l_wc = "INSERT INTO axrr330_g01_tmp "

   LET l_a4 = cl_replace_str(tm.a4,'xrcastus','xrdastus')

   #STEP1.往臨時表匯入期初資料
   LET g_sql = l_wc,
               " SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrea100,xreacomp,",
               "        '',NULL,'10','',SUM(xrea103),0,'',1,1,'','','','' FROM ",
               "    (SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004 FROM pmaa_t LEFT OUTER JOIN pmaal_t          ",
              #"            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_lang,"' AND pmaalent = ",g_enterprise,   #150828-00001#4 mark
               "            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_dlang,"' AND pmaalent = ",g_enterprise,  #150828-00001#4
               "      WHERE pmaa001 IN (SELECT DISTINCT xrea009 FROM xrea_t WHERE xreacomp IN ",tm.a1 CLIPPED,
               "                           AND xrea001 = '",l_syear,"' AND xrea002 = '",l_smonth,"' AND xreaent = ",g_enterprise," UNION                  ",
               "                        SELECT DISTINCT xrca004 FROM xrca_t WHERE xrcacomp IN ",tm.a1 CLIPPED,
               "                           AND xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"' AND xrcaent = ",g_enterprise," UNION                         ",
               "                        SELECT DISTINCT xrda004 FROM xrda_t WHERE xrdacomp IN ",tm.a1 CLIPPED,
               "                           AND xrdastus <> 'X'",      #150911-00015#1 Add
               "                           AND xrdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"' AND xrdaent = ",g_enterprise," AND xrdastus <> 'X' )),                            ",
              #"    (SELECT xrea100,xreacomp,xrea009,CASE WHEN xrea009 LIKE '2%' THEN xrea103 * -1 ELSE xrea103 END xrea103",       #20150818 mark
              #"       FROM xrea_t  WHERE xreacomp IN ",tm.a1," AND xrea001 = '",l_syear,"' AND xrea002 = '",l_smonth,"'   ",       #20150818 mark
               "    (SELECT xrea100,xreacomp,xrea009,CASE WHEN xrea004 LIKE '2%' THEN xrea103 * -1 ELSE xrea103 END xrea103",       #20150818
               "       FROM xrea_t  WHERE xreacomp IN ",tm.a1," AND xrea001 = '",l_syear1,"' AND xrea002 = '",l_smonth1,"'   ",     #20150818
               "        AND xrea003 = 'AR' AND xrea004 NOT LIKE '0%' AND xreaent = ",g_enterprise,")                                                      ",
               " WHERE pmaa001 = xrea009 AND pmaaent = ",g_enterprise,
               " GROUP BY pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrea100,xreacomp"
   PREPARE axrr330_g01_prep_s1 FROM g_sql
   EXECUTE axrr330_g01_prep_s1

   #STEP2.往臨時表匯入出貨及銷退資料
   LET g_sql = l_wc,
               " SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrca100,xrcacomp,",
               "        xrcb002,xmdk001,xrcb001,xrcb051,SUM(xrcb105),0,'',2,2,xrcald,'',xrca010,xrcbdocno FROM",
               "    (SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004 FROM pmaa_t LEFT OUTER JOIN pmaal_t",
              #"            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_lang,"'   AND pmaalent = ",g_enterprise,    #150828-00001#4 mark
               "            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_dlang,"'   AND pmaalent = ",g_enterprise,   #150828-00001#4
               "      WHERE pmaa001 IN (SELECT DISTINCT xrea009 FROM xrea_t WHERE xreacomp IN ",tm.a1 CLIPPED,
               "                           AND xrea001 = '",l_syear,"' AND xrea002 = '",l_smonth,"' AND xreaent = ",g_enterprise," UNION                  ",
               "                        SELECT DISTINCT xrca004 FROM xrca_t WHERE xrcacomp IN ",tm.a1 CLIPPED,
               "                           AND xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrcaent = ",g_enterprise," UNION                         ",
               "                        SELECT DISTINCT xrda004 FROM xrda_t WHERE xrdacomp IN ",tm.a1 CLIPPED,
               "                           AND xrdastus <> 'X'",      #150911-00015#1 Add
               "                           AND xrdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"' AND xrdaent = ",g_enterprise," AND xrdastus <> 'X' )),                            ",
               "    (SELECT xrca100,xrcacomp,xmdk001,xrcb002,xrcb001,xrcb105,xrcb051,xrca004,xrcald,xrca010,xrcbdocno FROM xrca_t,xrcb_t,xmdk_t,glaa_t     ",
               "      WHERE xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'   AND xrcadocno = xrcbdocno                      ",tm.a4,
               "      AND xrcacomp IN ",tm.a1,"                             AND xrcald = xrcbld    AND glaald = xrcald     ",
               "      AND xrcaent = xrcbent    AND glaaent = xrcaent        AND xmdkent = xrcaent  AND xmdkent =",g_enterprise,"                           ",
               "      AND xrcb002 = xmdkdocno  AND glaa014 = 'Y'            AND xrcb001 IN ('11','21'))              ",
               "      WHERE pmaa001 = xrca004      AND pmaaent = ",g_enterprise,"                                                                             ",
               "      GROUP BY pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrca100,xrcacomp,xrcb002,xmdk001,xrcb001,xrcb051,xrcald,xrca010,xrcbdocno  "
   PREPARE axrr330_g01_prep_s2 FROM g_sql
   EXECUTE axrr330_g01_prep_s2

   #STEP3.往臨時表匯入其他加項、其他減項資料
   LET g_sql = l_wc,
               " SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrca100,xrcacomp,                                ",
               "        xrcb002,xrcadocdt,xrcb001,xrcb051,SUM(xrcb105),0,'',3,3,xrcald,'',xrca010,xrcbdocno FROM           ",         #161109-00048#3 Mod '' --> xrcbdocno
               "    (SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004 FROM pmaa_t LEFT OUTER JOIN pmaal_t          ",
              #"            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_lang,"'  AND pmaalent = ",g_enterprise,   #150828-00001#4 mark
               "            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_dlang,"'  AND pmaalent = ",g_enterprise,  #150828-00001#4
               "      WHERE pmaa001 IN (SELECT DISTINCT xrea009 FROM xrea_t WHERE xreacomp IN ",tm.a1 CLIPPED,
               "                           AND xrea001 = '",l_syear,"' AND xrea002 = '",l_smonth,"' AND xreaent = ",g_enterprise," UNION                  ",
               "                        SELECT DISTINCT xrca004 FROM xrca_t WHERE xrcacomp IN ",tm.a1 CLIPPED,
               "                           AND xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrcaent = ",g_enterprise," UNION                         ",
               "                        SELECT DISTINCT xrda004 FROM xrda_t WHERE xrdacomp IN ",tm.a1 CLIPPED,
               "                           AND xrdastus <> 'X'",      #150911-00015#1 Add
               "                           AND xrdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrdaent = ",g_enterprise," AND xrdastus <> 'X' )),                            ",
               "    (SELECT xrca100,xrcacomp,xrcadocdt,xrcb002,xrcb001,xrcb105,xrcb051,xrca004,xrcald,xrca010,xrcbdocno FROM xrca_t,xrcb_t,glaa_t ",
               "      WHERE xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'   AND xrcadocno = xrcbdocno   AND glaa014 = 'Y'   ",tm.a4,
               "      AND xrcacomp IN ",tm.a1,"  AND glaaent = xrcaent      AND xrcald = xrcbld   AND glaald = xrcald      ",
               "      AND xrcaent = xrcbent AND xrcaent = ",g_enterprise,"  AND xrcb001 IN ('19','29') )   ",
               "      WHERE pmaa001 = xrca004     AND pmaaent = ",g_enterprise,"                                                                              ",
               "      GROUP BY pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrca100,xrcacomp,xrcb002,xrcadocdt,xrcb001,xrcb051,xrcald,xrca010,xrcbdocno  "
   PREPARE axrr330_g01_prep_s3 FROM g_sql
   EXECUTE axrr330_g01_prep_s3

   #STEP4.往臨時表匯入取收款及差異(匯差不取)資料
   LET g_sql = l_wc,
               " SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrde100,xrdacomp,                                ",
               "        xrdadocno,xrdadocdt,CASE WHEN xrde002 = '10' THEN 'A' ELSE 'A1' END,'',0,xrde109,'',4,4,xrdald,'','','' FROM         ",
               "    (SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004 FROM pmaa_t LEFT OUTER JOIN pmaal_t          ",
              #"            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_lang,"'  AND pmaalent = ",g_enterprise,   #150828-00001#4 mark
               "            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_dlang,"'  AND pmaalent = ",g_enterprise,  #150828-00001#4
               "      WHERE pmaa001 IN (SELECT DISTINCT xrea009 FROM xrea_t WHERE xreacomp IN ",tm.a1 CLIPPED,
               "                           AND xrea001 = '",l_syear,"' AND xrea002 = '",l_smonth,"'AND xreaent = ",g_enterprise,"  UNION                  ",
               "                        SELECT DISTINCT xrca004 FROM xrca_t WHERE xrcacomp IN ",tm.a1 CLIPPED,
               "                           AND xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrcaent = ",g_enterprise,"  UNION                         ",
               "                        SELECT DISTINCT xrda004 FROM xrda_t WHERE xrdacomp IN ",tm.a1 CLIPPED,
               "                           AND xrdastus <> 'X'",      #150911-00015#1 Add
               "                           AND xrdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrdaent = ",g_enterprise," AND xrdastus <> 'X' )),                            ",
               "    (SELECT xrdadocdt,xrdadocno,xrdacomp,xrde002,xrde100,xrde109,xrda004,xrdald FROM xrda_t,xrde_t,glaa_t   ",
              #"      WHERE xrdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'   AND xrdald = xrdeld AND glaald = xrdald    AND glaa014 = 'Y'   ",l_a4,    #161116-00056#1 Mod tm.a4 --> l_a4   #161109-00048#3 Mark
               "      WHERE xrdadocdt <= '",tm.a6,"' AND xrdald = xrdeld AND glaald = xrdald    AND glaa014 = 'Y'   ",l_a4,    #161109-00048#3 Add
               "        AND xrdastus <> 'X'",      #150911-00015#1 Add
               "        AND xrdadocno IN (SELECT xrcedocno FROM xrce_t WHERE xrceent = ",g_enterprise," AND xrce003 IN (SELECT DISTINCT xrcbdocno FROM axrr330_g01_tmp))",    #161109-00048#3 Add
               "        AND xrdacomp IN ",tm.a1 CLIPPED,"                   AND xrdadocno = xrdedocno   AND glaaent = xrdaent   ",   #161116-00056#1 Mod xrcent = xrdaent
               "    AND xrdaent = xrdeent  AND xrdaent = ",g_enterprise,"   AND xrde002 NOT IN ('11','12')    AND xrdastus <> 'X') ",  #161116-00056#1 Mod ) AND xrdastus <> 'X' -->  AND xrdastus <> 'X')
               "    WHERE pmaa001 = xrda004   AND pmaaent = ",g_enterprise,"                                                                                  "
   PREPARE axrr330_g01_prep_s4 FROM g_sql
   EXECUTE axrr330_g01_prep_s4

   #STEP5.
   LET g_sql = l_wc,
               " SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrce100,xrcacomp,                                ",
               "        xrcadocno,xrcadocdt,'A2','',0,SUM(xrce109),'',5,4,xrcald,'','','' FROM                             ",
               "    (SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004 FROM pmaa_t LEFT OUTER JOIN pmaal_t          ",
              #"            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_lang,"'   AND pmaalent = ",g_enterprise,   #150828-00001#4 mark
               "            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_dlang,"'   AND pmaalent = ",g_enterprise,  #150828-00001#4
               "      WHERE pmaa001 IN (SELECT DISTINCT xrea009 FROM xrea_t WHERE xreacomp IN ",tm.a1 CLIPPED,
               "                           AND xrea001 = '",l_syear,"' AND xrea002 = '",l_smonth,"' AND xreaent = ",g_enterprise,"  UNION                  ",
               "                        SELECT DISTINCT xrca004 FROM xrca_t WHERE xrcacomp IN ",tm.a1 CLIPPED,
               "                           AND xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrcaent = ",g_enterprise,"  UNION                         ",
               "                        SELECT DISTINCT xrda004 FROM xrda_t WHERE xrdacomp IN ",tm.a1 CLIPPED,
               "                           AND xrdastus <> 'X'",      #150911-00015#1 Add
               "                           AND xrdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrdaent = ",g_enterprise,"  AND xrdastus <> 'X')),                            ",
               "    (SELECT xrcadocdt,xrcadocno,xrce100,xrce109,xrcacomp,xrca004,xrcald FROM xrca_t,xrce_t,glaa_t          ",
               "      WHERE xrcacomp IN ",tm.a1 CLIPPED, "                  AND xrcadocno = xrcedocno                ",tm.a4,
              #"        AND xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'   AND xrcald = xrceld  AND glaald = xrcald       ",   #161109-00048#3 Mark
               "        AND xrcadocdt <= '",tm.a6,"'      AND xrcald = xrceld  AND glaald = xrcald       ",   #161109-00048#3 Add
               "        AND xrce003 IN (SELECT DISTINCT xrcbdocno FROM axrr330_g01_tmp)",    #161109-00048#3 Add
               "        AND glaaent = xrcaent AND xrcaent = xrceent AND xrcaent = ",g_enterprise," AND glaa014 = 'Y'        )                                                                             ",
               "    WHERE pmaa001 = xrca004   AND pmaaent = ",g_enterprise,"                                                                                  ",
               "    GROUP BY pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,xrce100,xrcacomp,xrcadocno,xrcadocdt,xrcald        "   #161116-00056#1 Add xrcald
   PREPARE axrr330_g01_prep_s5 FROM g_sql
   EXECUTE axrr330_g01_prep_s5

   #STEP6.
   LET g_sql = l_wc,
               " SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,apce100,apdacomp,                                ",
               "        apdadocno,apdadocdt,'A2','',0,SUM(apce109),'',6,4,apdald,'','','' FROM (                           ",
               "    (SELECT pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004 FROM pmaa_t LEFT OUTER JOIN pmaal_t          ",
              #"            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_lang,"'   AND pmaalent = ",g_enterprise,   #150828-00001#4 mark
               "            ON pmaalent = pmaaent AND pmaal001 = pmaa001 AND pmaal002 = '",g_dlang,"'   AND pmaalent = ",g_enterprise,  #150828-00001#4
               "      WHERE pmaa001 IN (SELECT DISTINCT xrea009 FROM xrea_t WHERE xreacomp IN ",tm.a1 CLIPPED,
               "                           AND xrea001 = '",l_syear,"' AND xrea002 = '",l_smonth,"' AND xreaent = ",g_enterprise,"  UNION                  ",
               "                        SELECT DISTINCT xrca004 FROM xrca_t WHERE xrcacomp IN ",tm.a1 CLIPPED,
               "                           AND xrcadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrcaent = ",g_enterprise,"  UNION                         ",
               "                        SELECT DISTINCT xrda004 FROM xrda_t WHERE xrdacomp IN ",tm.a1 CLIPPED,
               "                           AND xrdastus <> 'X'",      #150911-00015#1 Add
               "                           AND xrdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'  AND xrdaent = ",g_enterprise,"  AND xrdastus <> 'X')),                            ",
               "    (SELECT apdadocdt,apdadocno,apce100,apce109,apda004,apdacomp,apdald FROM apda_t,apce_t,xrca_t,glaa_t                 ",
              #"      WHERE apdadocdt BETWEEN '",tm.a2,"' AND '",tm.a3,"'   AND apceent = xrcaent AND glaaent = xrcaent    ",   #161109-00048#3 Mark
               "      WHERE apdadocdt <= '",tm.a6,"'   AND apceent = xrcaent AND glaaent = xrcaent    ",   #161109-00048#3 Add
               "        AND apdadocno = apcedocno        AND apdald = apceld AND glaald = xrcald  AND glaa014 = 'Y'        ",
               "        AND apceld = xrcald  AND apceent = ",g_enterprise,"  AND apce003 = xrcadocno                 ",tm.a4,
               "        AND apce003 IN (SELECT DISTINCT xrcbdocno FROM axrr330_g01_tmp)",    #161109-00048#3 Add
               "        AND apdacomp IN ",tm.a1 CLIPPED, " AND apdaent = apceent )                                         ",
               "    WHERE pmaa001 = apda004  AND pmaaent = ",g_enterprise,"                                                                                   ",
               "    GROUP BY pmaaent,pmaa001,pmaa016,pmaa027,pmaal003,pmaal004,apce100,apdacomp,apdadocno,apdadocdt,apcald        " #161116-00056#1 add apcald
   PREPARE axrr330_g01_prep_s6 FROM g_sql
   EXECUTE axrr330_g01_prep_s6
   #STEP7.發票號碼
   LET g_sql = " SELECT xrcacomp,flag,orders,xrcald,'',xrcbdocno ",
               "   FROM axrr330_g01_tmp  WHERE flag = '2' "
   PREPARE axrr330_g01_prep_s7 FROM g_sql
   DECLARE axrr330_g01_curs_s7 CURSOR FOR axrr330_g01_prep_s7
   FOREACH axrr330_g01_curs_s7 INTO l_tmp.*
      CALL s_axrt300_sel_ld(l_tmp.xrcald) RETURNING l_success,l_s   #獲取帳套主/次
      CASE l_s
         WHEN '1'
            LET ls_wc1 = " isaf035 = '",l_tmp.xrcbdocno,"'"
         WHEN '2'
            LET ls_wc1 = " isaf048 = '",l_tmp.xrcbdocno,"'"
         WHEN '3'
            LET ls_wc1 = " isaf049 = '",l_tmp.xrcbdocno,"'"
      END CASE
      #應收單據獲取開票單號
      LET g_sql = " SELECT isafdocno FROM isaf_t ",
                  "  WHERE isafent = '",g_enterprise,"' AND isafcomp = '",l_tmp.xrcacomp,"'",
                  "    AND ",ls_wc1 CLIPPED,"  AND isafstus = 'Y' "
      PREPARE axrr330_isaf_prep FROM g_sql
      DECLARE axrr330_isaf_curs CURSOR FOR axrr330_isaf_prep  
      
      #開票單號串查isat資料
      LET g_sql = " SELECT isat004   FROM isat_t ",
                  "  WHERE isatent = '",g_enterprise,"' AND isatcomp = '",l_tmp.xrcacomp,"'",
                  "    AND isatdocno = ? "
      PREPARE axrr330_isat004_prep FROM g_sql
      DECLARE axrr330_isat004_curs CURSOR FOR axrr330_isat004_prep   

      LET l_isafdocno = NULL
      FOREACH axrr330_isaf_curs INTO l_isafdocno 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH isaf:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         FOREACH axrr330_isat004_curs USING l_isafdocno INTO l_tmp.isat004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH isat:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            EXIT FOREACH
         END FOREACH
      END FOREACH
      
      UPDATE axrr330_g01_tmp
      SET isat004 = l_tmp.isat004 
      WHERE xrcald    = l_tmp.xrcald AND  xrcacomp  = l_tmp.xrcacomp    
        AND xrcbdocno = l_tmp.xrcbdocno 
        AND flag      = l_tmp.flag  AND    orders    = l_tmp.orders
   END FOREACH


END FUNCTION

 
{</section>}
 
{<section id="axrr330_g01.other_report" readonly="Y" >}

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
PRIVATE REPORT axrr330_g01_subrep05(sr3)
   DEFINE sr3      sr3_r

    FORMAT
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT
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
PRIVATE REPORT axrr330_g01_subrep06(sr4)
   DEFINE sr4      sr4_r

    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
END REPORT

 
{</section>}
 
