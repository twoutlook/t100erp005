#該程式未解開Section, 採用最新樣板產出!
{<section id="aint701_g02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:14(2017-01-16 14:12:20), PR版次:0014(2017-01-16 14:48:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000011
#+ Filename...: aint701_g02
#+ Description: ...
#+ Creator....: 08172(2016-09-18 11:23:00)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="aint701_g02.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161024-00023#9   2016/10/27  by 08172    入库单据增加装箱功能
#161024-00023#18  2016/11/01  by 08172    增加分销销退部分处理
#161102-00026#5   2016/11/03  by 08172    1.报表名称和单头资料只要第一页显示 2.单头需求对象显示中文名称 3.整个报表字体调小，商品名称栏位不允许换行，如果超出栏位宽度就截断 
#                                         4.同一款商品编号打在一起 5.页脚之只在最后显示 6.右边涉及装箱数改成款号加颜色小计，最后一行加合计数
#161017-00051#8   2016/11/08  by 06137    装箱清单和汇总单同一颜色的，不同尺码的装箱信息，应该显示在一行
#161109-00078#14  2016/11/17  by 08172    从单身关联来源单号
#161017-00051#9   2016/11/28  by 06137    装箱清单和汇总单打印，尺码超过12列的，增加分页显示功能
#161217-00002#3   2016/12/23  by 06137    装箱汇总单打印增加一阶段仓退单部分，详见分镜
#161220-00037#8   2016/12/27  by 06137    修改装箱汇总单打印逻辑，详见分镜
#161220-00009#1   2016/12/27  by 06137    1.装箱清单和汇总单打印单头增加审核人、审核日期，2.装箱清单和汇总单增加显示颜色编码,显示格式是58▪黑色
#161228-00033#1   2017/01/04  By 06137    後續T100 應會有不同的DB支持  ROWNUM只適用於ORACLE DB 予以改寫 應將rownum寫法移除，ORDER BY 後FETCH FIRST抓第一筆
#170104-00068#4   2017/01/05  By 06137    BUG调整：来源是4.配送单的时候，预览时会多出一张出入库单号=对应配送调拨拨入的单据，debug原因是关联的时候，第二段exists未关联配送单身信息的装箱单号[indd049]、装箱项次[indd050]
#170116-00026#1   2017/01/16  By 06137    修正ainr701匯總表數量加總異常問題
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
   inbm001 LIKE inbm_t.inbm001, 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbment LIKE inbm_t.inbment, 
   inbmsite LIKE inbm_t.inbmsite, 
   inbmunit LIKE inbm_t.inbmunit, 
   inboent LIKE inbo_t.inboent, 
   inbo001 LIKE inbo_t.inbo001, 
   inbm007 LIKE inbm_t.inbm007, 
   l_inbo006 LIKE inbo_t.inbo006, 
   l_imaal003 LIKE type_t.chr100, 
   l_inam012 LIKE inam_t.inam012, 
   l_inam014 LIKE inam_t.inam014, 
   l_inam018 LIKE inam_t.inam018, 
   l_inbo008 LIKE inbo_t.inbo008, 
   l_inbo0091 LIKE inbo_t.inbo009, 
   l_inbo0092 LIKE inbo_t.inbo009, 
   l_inbo0093 LIKE inbo_t.inbo009, 
   l_inbo0094 LIKE inbo_t.inbo009, 
   l_inbo0095 LIKE inbo_t.inbo009, 
   l_inbo0096 LIKE inbo_t.inbo009, 
   l_inbo0097 LIKE inbo_t.inbo009, 
   l_inbo0098 LIKE inbo_t.inbo009, 
   l_inbo0099 LIKE inbo_t.inbo009, 
   l_inbo00910 LIKE inbo_t.inbo009, 
   l_inbo00911 LIKE inbo_t.inbo009, 
   l_inbo00912 LIKE inbo_t.inbo009, 
   l_inaa001 LIKE inaa_t.inaa001, 
   l_inaa002 LIKE inaa_t.inaa002, 
   l_indcdocno LIKE indc_t.indcdocno, 
   l_sum LIKE type_t.num20, 
   l_imaa157 LIKE imaa_t.imaa157, 
   l_money LIKE type_t.num20_6, 
   l_rel_num LIKE type_t.num20, 
   l_ooag011 LIKE ooag_t.ooag011, 
   l_ooefl003 LIKE ooefl_t.ooefl003, 
   l_pageno LIKE type_t.num5, 
   l_order LIKE type_t.chr30
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       typ LIKE type_t.chr20,         #inbm008 
       typ1 LIKE type_t.chr20          #inbm003
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
TYPE t_print RECORD
   inbm001 LIKE inbm_t.inbm001, 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbment LIKE inbm_t.inbment, 
   inbmsite LIKE inbm_t.inbmsite, 
   inbmunit LIKE inbm_t.inbmunit,
   inbo001 LIKE inbo_t.inbo001,
   inbm007 LIKE inbm_t.inbm007,   
   l_inbo006 LIKE inbo_t.inbo006, 
   l_imaal003 LIKE type_t.chr100, 
   l_inam012 LIKE inam_t.inam012, 
   l_inam014 LIKE inam_t.inam014, 
   l_inam018 LIKE inam_t.inam018, 
   l_inbo008 LIKE inbo_t.inbo008, 
   l_inbo0091 LIKE inbo_t.inbo009, 
   l_inbo0092 LIKE inbo_t.inbo009, 
   l_inbo0093 LIKE inbo_t.inbo009, 
   l_inbo0094 LIKE inbo_t.inbo009, 
   l_inbo0095 LIKE inbo_t.inbo009, 
   l_inbo0096 LIKE inbo_t.inbo009, 
   l_inbo0097 LIKE inbo_t.inbo009,
   l_inbo0098 LIKE inbo_t.inbo009,  #161102-00026#5 by 08172 
   l_inbo0099 LIKE inbo_t.inbo009,  #161102-00026#5 by 08172
   l_inbo00910 LIKE inbo_t.inbo009,  #161102-00026#5 by 08172 
   l_inbo00911 LIKE inbo_t.inbo009,  #161102-00026#5 by 08172
   l_inbo00912 LIKE inbo_t.inbo009,  #161102-00026#5 by 08172    
   l_inaa001 LIKE inaa_t.inaa001,
   l_inaa002 LIKE inaa_t.inaa002,   
   l_indcdocno LIKE indc_t.indcdocno, 
   l_sum LIKE type_t.num20, 
   l_imaa116 LIKE imaa_t.imaa116, 
   l_money LIKE type_t.num20_6, 
   l_rel_num LIKE type_t.num20,
   l_ooag011 LIKE ooag_t.ooag011, 
   l_ooefl003 LIKE ooefl_t.ooefl003
 END RECORD
DEFINE g_inam014        ARRAY[20] OF VARCHAR(1000)
DEFINE l_total LIKE type_t.num10
#纵向合计
TYPE r_sum   RECORD 
                 sum01  LIKE type_t.num20_6, 
                 sum02  LIKE type_t.num20_6,
                 sum03  LIKE type_t.num20_6,
                 sum04  LIKE type_t.num20_6,
                 sum05  LIKE type_t.num20_6,
                 sum06  LIKE type_t.num20_6,
                 sum07  LIKE type_t.num20_6,
                 sum08  LIKE type_t.num20_6,    #161102-00026#5 by 08172
                 sum09  LIKE type_t.num20_6,    #161102-00026#5 by 08172
                 sum10  LIKE type_t.num20_6,    #161102-00026#5 by 08172
                 sum11  LIKE type_t.num20_6,    #161102-00026#5 by 08172
                 sum12  LIKE type_t.num20_6     #161102-00026#5 by 08172
             END RECORD 
#end add-point
 
{</section>}
 
{<section id="aint701_g02.main" readonly="Y" >}
PUBLIC FUNCTION aint701_g02(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr20         #tm.typ  inbm008 
DEFINE  p_arg3 LIKE type_t.chr20         #tm.typ1  inbm003
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
DEFINE l_session_id    LIKE type_t.num20
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.typ = p_arg2
   LET tm.typ1 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_template="aint701_g02"
   
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "------------------------------"
   DISPLAY "SessionId: ",l_session_id   
   DISPLAY "------------------------------"
   CALL aint701_g02_create_tmp_table()     
   LET g_sql = " INSERT INTO aint701_tmp1(inbm001,inbment,inbmsite,inbmunit,inbm007,inbo001,ooag011,ooefl003, ",
               "                          docno,item,imaal003,inam012,imaa116,inam014,inam018,inaa001,inaa002,unit,qty, ",
               "                          condition,inbmdocno) ",    #161220-00009#1 Add By Ken 161228 加inbmdocno 
               " VALUES (?,?,?,?,?,?,?,?,?,?,?,?, ",
               "         ?,?,?,?,?,?, ",
               "         ?,?,?) "    #161220-00009#1 Add By Ken 161228 加inbmdocno
   PREPARE aint701_ins_tmp1 FROM g_sql
   CALL aint701_g02_ins_tmp_table1(tm.wc,tm.typ,tm.typ1)   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aint701_g02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aint701_g02_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aint701_g02_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aint701_g02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aint701_g02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aint701_g02_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT inbm001,inbmdocno,inbment,inbmsite,inbmunit,inboent,inbo001,inbm007,'','', 
       '','','','',0,0,0,0,0,0,0,0,0,0,0,0,'',NULL,'',0,0,0,0,NULL,NULL,0,''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM inbm_t,inbo_t,indc_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY inbo001"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inbm_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #161017-00051#8 Mark By Ken 161108(S)
   #LET g_sql = " SELECT inbm001,    '',         inbment,     inbmsite,  inbmunit,  ",g_enterprise,",",
   #            "        inbo001,    inbm007,    l_inbo006,   l_imaal003,  l_inam012, l_inam014,  l_inam018, ",
   #            "        l_inbo008,  l_inbo0091, l_inbo0092,  l_inbo0093,  l_inbo0094, l_inbo0095,",
   #            "        l_inbo0096, l_inbo0097, l_inbo0098,  l_inbo0099,  l_inbo00910,l_inbo00911,l_inbo00912,",
   #            "        l_inaa001,  l_inaa002, l_indcdocno,l_sum,",
   #            "        l_imaa116,  l_money,    l_rel_num,           ooag011,   ooefl003",
   #            "   FROM aint701_print_tmp ",
   #            "  WHERE l_rel_num <> 0"  
   #161017-00051#8 Mark By Ken 161108(E)
   #161017-00051#8 Add By Ken 161108(S)
   #LET g_sql = " SELECT inbm001,    '',         inbment,     inbmsite,  inbmunit,  ",g_enterprise,",",    #161220-00009#1 Mark By ken 161228
   LET g_sql = " SELECT inbm001,    inbmdocno,    inbment,     inbmsite,  inbmunit,  ",g_enterprise,",",   #161220-00009#1 Add By ken 161228
               "        inbo001,    inbm007,    l_inbo006,   l_imaal003,  l_inam012, '' l_inam014,  l_inam018, ",
               "        l_inbo008,  SUM(l_inbo0091), SUM(l_inbo0092),  SUM(l_inbo0093),  SUM(l_inbo0094), SUM(l_inbo0095),",
               "        SUM(l_inbo0096), SUM(l_inbo0097), SUM(l_inbo0098),  SUM(l_inbo0099),  SUM(l_inbo00910),SUM(l_inbo00911),SUM(l_inbo00912),",
               "        l_inaa001,  l_inaa002,  l_indcdocno, l_sum,",
               "        l_imaa116,  SUM(l_money),    SUM(l_rel_num),           ooag011,   ooefl003,",
               "        page_no,    trim(l_indcdocno)||'.'||trim(TO_CHAR(page_no,'0000')) ",       #161017-00051#9 Add BY Ken 161128
               "   FROM aint701_print_tmp ",
               #"  WHERE l_rel_num <> 0" ,     #161017-00051#9 Mark BY Ken 161128 
               #"  GROUP BY inbm001,   inbment,    inbmsite,     inbmunit,  ",                 #161220-00009#1 Mark By ken 161228
               "  GROUP BY inbm001,    inbmdocno,    inbment,    inbmsite,     inbmunit,  ",   #161220-00009#1 Add By ken 161228
               "           inbo001,    inbm007,    l_inbo006,    l_imaal003,  l_inam012,  l_inam018, ",
               "           l_inbo008,  l_inaa001,  l_inaa002,    l_indcdocno, l_sum,   ",
               "           l_imaa116,  ooag011,     ooefl003,",   
               "           page_no,    trim(l_indcdocno)||'.'||trim(TO_CHAR(page_no,'0000')) ",     #161017-00051#9 Add BY Ken 161128           
               "  ORDER BY l_indcdocno,page_no,l_inbo006,l_inam012 "     #161017-00051#9 Add BY Ken 161128           
   #161017-00051#8 Add By Ken 161108(E)               
   #end add-point
   PREPARE aint701_g02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aint701_g02_curs CURSOR FOR aint701_g02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aint701_g02.ins_data" readonly="Y" >}
PRIVATE FUNCTION aint701_g02_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inbm001 LIKE inbm_t.inbm001, 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbment LIKE inbm_t.inbment, 
   inbmsite LIKE inbm_t.inbmsite, 
   inbmunit LIKE inbm_t.inbmunit, 
   inboent LIKE inbo_t.inboent, 
   inbo001 LIKE inbo_t.inbo001, 
   inbm007 LIKE inbm_t.inbm007, 
   l_inbo006 LIKE inbo_t.inbo006, 
   l_imaal003 LIKE type_t.chr100, 
   l_inam012 LIKE inam_t.inam012, 
   l_inam014 LIKE inam_t.inam014, 
   l_inam018 LIKE inam_t.inam018, 
   l_inbo008 LIKE inbo_t.inbo008, 
   l_inbo0091 LIKE inbo_t.inbo009, 
   l_inbo0092 LIKE inbo_t.inbo009, 
   l_inbo0093 LIKE inbo_t.inbo009, 
   l_inbo0094 LIKE inbo_t.inbo009, 
   l_inbo0095 LIKE inbo_t.inbo009, 
   l_inbo0096 LIKE inbo_t.inbo009, 
   l_inbo0097 LIKE inbo_t.inbo009, 
   l_inbo0098 LIKE inbo_t.inbo009, 
   l_inbo0099 LIKE inbo_t.inbo009, 
   l_inbo00910 LIKE inbo_t.inbo009, 
   l_inbo00911 LIKE inbo_t.inbo009, 
   l_inbo00912 LIKE inbo_t.inbo009, 
   l_inaa001 LIKE inaa_t.inaa001, 
   l_inaa002 LIKE inaa_t.inaa002, 
   l_indcdocno LIKE indc_t.indcdocno, 
   l_sum LIKE type_t.num20, 
   l_imaa157 LIKE imaa_t.imaa157, 
   l_money LIKE type_t.num20_6, 
   l_rel_num LIKE type_t.num20, 
   l_ooag011 LIKE ooag_t.ooag011, 
   l_ooefl003 LIKE ooefl_t.ooefl003, 
   l_pageno LIKE type_t.num5, 
   l_order LIKE type_t.chr30
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
    FOREACH aint701_g02_curs INTO sr_s.*
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
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].inbm001 = sr_s.inbm001
       LET sr[l_cnt].inbmdocno = sr_s.inbmdocno
       LET sr[l_cnt].inbment = sr_s.inbment
       LET sr[l_cnt].inbmsite = sr_s.inbmsite
       LET sr[l_cnt].inbmunit = sr_s.inbmunit
       LET sr[l_cnt].inboent = sr_s.inboent
       LET sr[l_cnt].inbo001 = sr_s.inbo001
       LET sr[l_cnt].inbm007 = sr_s.inbm007
       LET sr[l_cnt].l_inbo006 = sr_s.l_inbo006
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_inam012 = sr_s.l_inam012
       LET sr[l_cnt].l_inam014 = sr_s.l_inam014
       LET sr[l_cnt].l_inam018 = sr_s.l_inam018
       LET sr[l_cnt].l_inbo008 = sr_s.l_inbo008
       LET sr[l_cnt].l_inbo0091 = sr_s.l_inbo0091
       LET sr[l_cnt].l_inbo0092 = sr_s.l_inbo0092
       LET sr[l_cnt].l_inbo0093 = sr_s.l_inbo0093
       LET sr[l_cnt].l_inbo0094 = sr_s.l_inbo0094
       LET sr[l_cnt].l_inbo0095 = sr_s.l_inbo0095
       LET sr[l_cnt].l_inbo0096 = sr_s.l_inbo0096
       LET sr[l_cnt].l_inbo0097 = sr_s.l_inbo0097
       LET sr[l_cnt].l_inbo0098 = sr_s.l_inbo0098
       LET sr[l_cnt].l_inbo0099 = sr_s.l_inbo0099
       LET sr[l_cnt].l_inbo00910 = sr_s.l_inbo00910
       LET sr[l_cnt].l_inbo00911 = sr_s.l_inbo00911
       LET sr[l_cnt].l_inbo00912 = sr_s.l_inbo00912
       LET sr[l_cnt].l_inaa001 = sr_s.l_inaa001
       LET sr[l_cnt].l_inaa002 = sr_s.l_inaa002
       LET sr[l_cnt].l_indcdocno = sr_s.l_indcdocno
       LET sr[l_cnt].l_sum = sr_s.l_sum
       LET sr[l_cnt].l_imaa157 = sr_s.l_imaa157
       LET sr[l_cnt].l_money = sr_s.l_money
       LET sr[l_cnt].l_rel_num = sr_s.l_rel_num
       LET sr[l_cnt].l_ooag011 = sr_s.l_ooag011
       LET sr[l_cnt].l_ooefl003 = sr_s.l_ooefl003
       LET sr[l_cnt].l_pageno = sr_s.l_pageno
       LET sr[l_cnt].l_order = sr_s.l_order
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint701_g02.rep_data" readonly="Y" >}
PRIVATE FUNCTION aint701_g02_rep_data()
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
          START REPORT aint701_g02_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aint701_g02_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aint701_g02_rep
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
 
{<section id="aint701_g02.rep" readonly="Y" >}
PRIVATE REPORT aint701_g02_rep(sr1)
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
DEFINE l_inam0141      LIKE type_t.chr1000
DEFINE l_inam0142      LIKE type_t.chr1000
DEFINE l_inam0143      LIKE type_t.chr1000
DEFINE l_inam0144      LIKE type_t.chr1000
DEFINE l_inam0145      LIKE type_t.chr1000
DEFINE l_inam0146      LIKE type_t.chr1000
DEFINE l_inam0147      LIKE type_t.chr1000
DEFINE l_inam0148      LIKE type_t.chr1000   #161102-00026#5 by 08172
DEFINE l_inam0149      LIKE type_t.chr1000   #161102-00026#5 by 08172
DEFINE l_inam01410      LIKE type_t.chr1000   #161102-00026#5 by 08172
DEFINE l_inam01411      LIKE type_t.chr1000   #161102-00026#5 by 08172
DEFINE l_inam01412      LIKE type_t.chr1000   #161102-00026#5 by 08172
DEFINE l_inbo009_total LIKE type_t.num10
DEFINE l_money_total   LIKE type_t.num20_6
DEFINE l_title         LIKE type_t.chr1000
DEFINE l_sql           STRING
DEFINE l_sum r_sum
DEFINE i               LIKE type_t.num5
#161017-00051#9 Add BY Ken 161128(S)
DEFINE l_inbo009_sum   LIKE type_t.num10
DEFINE l_money_sum     LIKE type_t.num10
#161017-00051#9 Add BY Ken 161128(E)
#161220-00009#1 Add By Ken 161227(S)
DEFINE l_inbmcnfid     LIKE inbm_t.inbmcnfid    #資料確認人員
DEFINE l_inbmcnfdt     LIKE inbm_t.inbmcnfdt    #資料確認日期
#161220-00009#1 Add By Ken 161227(E)
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.l_inbo006,sr1.l_inam012
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
            LET g_grPageHeader.title0201 = "装箱汇总单打印"
            #161017-00051#9 Add BY Ken 161128(S)
            LET g_rep_docno = sr1.l_indcdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*            
            #161017-00051#9 Add BY Ken 161128(E)            
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            #161017-00051#9 Add BY Ken 161128(S)
            LET g_doc_key = 'inbment=' ,sr1.inbment,'{+}inbmdocno=' ,sr1.inbmdocno         
            CALL cl_gr_init_apr(sr1.l_indcdocno)
            #161017-00051#9 Add BY Ken 161128(E)            
#            #end add-point:rep.apr.signstr.before   
#            LET g_doc_key = 'inbment=' ,sr1.inbment,'{+}inbmdocno=' ,sr1.inbmdocno         
#            CALL cl_gr_init_apr(sr1.l_order)
#            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           #161017-00051#9 Add By Ken 161128(S)
           #用來判斷此筆資料的單號、箱號是否超過一頁
           LET l_sql = "SELECT COUNT(1) FROM ( " ,
                       "SELECT UNIQUE l_indcdocno, page_no ",
                       "  FROM aint701_print_tmp ",
                       " WHERE l_indcdocno = ? )"
           PREPARE aint701_page_cnt FROM l_sql  

           #如單號有多頁時，橫向總計(同箱的最後一頁顯示)
           LET l_sql = " SELECT SUM(l_rel_num)l_rel_num,SUM(l_money)l_money FROM aint701_print_tmp ",
                       " WHERE l_indcdocno=? AND l_inbo006=? AND l_inam012 =? "  
           PREPARE aint701_inbo009_sum FROM l_sql
           #161017-00051#9 Add By Ken 161128(E)
           
           #每頁顯示，橫向總計
           LET l_sql = " SELECT SUM(l_rel_num)l_rel_num,SUM(l_money)l_money FROM aint701_print_tmp ",
                       " WHERE l_indcdocno=? AND page_no=? AND l_inbo006=? AND l_inam012 =? "  
           PREPARE aint701_inbo009_page_sum FROM l_sql
           #161017-00051#9 Add By Ken 161128(E)           
           
           CALL g_inam014.clear()
           LET i = 1
           LET l_sql = " SELECT inam014 FROM inam014_tmp",
                       " WHERE docno = ?",
                       "   AND page_no = ? ",    #161017-00051#9 Add BY Ken 161128                       
                       " ORDER BY i"
           PREPARE aint701_sel_inam014_pre FROM l_sql
           DECLARE aint701_sel_inam014_cs CURSOR FOR aint701_sel_inam014_pre          
           #FOREACH aint701_sel_inam014_cs USING sr1.l_indcdocno INTO g_inam014[i]   #161017-00051#9 Mark BY Ken 161128
           #161017-00051#9 Add BY Ken 161116(S)           
           FOREACH aint701_sel_inam014_cs 
             USING sr1.l_indcdocno,sr1.l_pageno INTO g_inam014[i]            
           #161017-00051#9 Add BY Ken 161116(E)          
              LET i = i + 1
           END FOREACH           
           LET l_inam0141 = g_inam014[1]
           LET l_inam0142 = g_inam014[2]
           LET l_inam0143 = g_inam014[3]
           LET l_inam0144 = g_inam014[4]
           LET l_inam0145 = g_inam014[5]
           LET l_inam0146 = g_inam014[6]
           LET l_inam0147 = g_inam014[7]  #161102-00026#5 by 08172
           LET l_inam0148 = g_inam014[8]  #161102-00026#5 by 08172
           LET l_inam0149 = g_inam014[9]  #161102-00026#5 by 08172
           LET l_inam01410 = g_inam014[10]  #161102-00026#5 by 08172
           LET l_inam01411 = g_inam014[11]  #161102-00026#5 by 08172
           LET l_inam01412 = g_inam014[12]  #161102-00026#5 by 08172
           PRINTX l_inam0141
           PRINTX l_inam0142
           PRINTX l_inam0143
           PRINTX l_inam0144
           PRINTX l_inam0145
           PRINTX l_inam0146   
           PRINTX l_inam0147   #161102-00026#5 by 08172 
           PRINTX l_inam0148   #161102-00026#5 by 08172
           PRINTX l_inam0149   #161102-00026#5 by 08172
           PRINTX l_inam01410   #161102-00026#5 by 08172
           PRINTX l_inam01411   #161102-00026#5 by 08172
           PRINTX l_inam01412   #161102-00026#5 by 08172
           LET l_title=NULL
           LET l_sql=
           "SELECT  listagg(oocql004,'/') within GROUP(ORDER BY imeb001,imeb002) ",
           "  FROM imeb_t,oocql_t ",
           " WHERE imebent=oocqlent ",
           "   AND oocql001='273' ",
           "   AND oocql002=imeb004 ",
           "   AND imeb001=(SELECT DISTINCT imaa005 FROM imaa_t WHERE imaaent=",g_enterprise," AND imaa001='",sr1.l_inbo006,"') ",
           "   AND imebent=",g_enterprise,
           "   AND imeb012='N'",
           "   AND oocql003='",g_dlang,"'"
           PREPARE erwei_title_pre FROM l_sql
           EXECUTE erwei_title_pre into l_title
           PRINTX l_title
           INITIALIZE l_sum.* TO NULL  #清空縱向小計  

           #161220-00009#1 Add By Ken 161227(S)
           SELECT ooag011,inbmcnfdt 
             INTO l_inbmcnfid,l_inbmcnfdt
             FROM inbm_t 
             LEFT JOIN ooag_t ON inbment = ooagent AND inbmcnfid = ooag001
            WHERE inbment = g_enterprise
              AND inbmdocno = sr1.inbmdocno
           PRINTX l_inbmcnfid
           PRINTX l_inbmcnfdt
           #161220-00009#1 Add By Ken 161227(E)
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           #161017-00051#9 Add BY Ken 161128(S)
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                sr1.inbment CLIPPED ,"'", " AND  ooff002 = '", sr1.l_indcdocno CLIPPED ,"'" 
           #161017-00051#9 Add BY Ken 161128(E)
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.inbment CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aint701_g02_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g02_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aint701_g02_subrep01
           DECLARE aint701_g02_repcur01 CURSOR FROM g_sql
           FOREACH aint701_g02_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g02_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aint701_g02_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g02_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_inbo006
 
           #add-point:rep.b_group.l_inbo006.before name="rep.b_group.l_inbo006.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_inbo006.after name="rep.b_group.l_inbo006.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_inam012
 
           #add-point:rep.b_group.l_inam012.before name="rep.b_group.l_inam012.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_inam012.after name="rep.b_group.l_inam012.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           #161017-00051#9 Add BY Ken 161116(S)
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.inbment CLIPPED ,"'", " AND  ooff002 = '", sr1.l_indcdocno CLIPPED CLIPPED ,"'" 
           #161017-00051#9 Add BY Ken 161116(E)
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.inbment CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aint701_g02_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g02_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aint701_g02_subrep02
           DECLARE aint701_g02_repcur02 CURSOR FROM g_sql
           FOREACH aint701_g02_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g02_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aint701_g02_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g02_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
#          LET sr1.l_rel_num = 0 
          #161017-00051#9 Add By Ken 161128(S)
          LET l_inbo009_sum = 0
          LET l_cnt = 0
          #先判斷此筆資料是否有超過一頁(超過一頁的話，第一頁橫向加總空白，第二頁是整箱合計)
          EXECUTE aint701_page_cnt USING sr1.l_indcdocno INTO l_cnt   
          IF (l_cnt = 1) THEN                                         
          #161017-00051#9 Add By Ken 161128(E)
             IF cl_null(sr1.l_inbo0091) THEN LET sr1.l_inbo0091 = 0 END IF            
             IF cl_null(sr1.l_inbo0092) THEN LET sr1.l_inbo0092 = 0 END IF            
             IF cl_null(sr1.l_inbo0093) THEN LET sr1.l_inbo0093 = 0 END IF
             IF cl_null(sr1.l_inbo0094) THEN LET sr1.l_inbo0094 = 0 END IF            
             IF cl_null(sr1.l_inbo0095) THEN LET sr1.l_inbo0095 = 0 END IF            
             IF cl_null(sr1.l_inbo0096) THEN LET sr1.l_inbo0096 = 0 END IF      
             IF cl_null(sr1.l_inbo0097) THEN LET sr1.l_inbo0097 = 0 END IF  #161102-00026#5 by 08172 
             IF cl_null(sr1.l_inbo0098) THEN LET sr1.l_inbo0098 = 0 END IF  #161102-00026#5 by 08172 
             IF cl_null(sr1.l_inbo0099) THEN LET sr1.l_inbo0099 = 0 END IF  #161102-00026#5 by 08172 
             IF cl_null(sr1.l_inbo00910) THEN LET sr1.l_inbo00910 = 0 END IF  #161102-00026#5 by 08172
             IF cl_null(sr1.l_inbo00911) THEN LET sr1.l_inbo00911 = 0 END IF  #161102-00026#5 by 08172
             IF cl_null(sr1.l_inbo00912) THEN LET sr1.l_inbo00912 = 0 END IF  #161102-00026#5 by 08172 
             EXECUTE aint701_inbo009_page_sum 
               USING sr1.l_indcdocno,sr1.l_pageno,sr1.l_inbo006,sr1.l_inam012 INTO l_inbo009_sum,l_money_sum
          ELSE       #同單號、箱號大於一頁(IF (l_cnt > 1) THEN)
          #161017-00051#9 Add By Ken 161118(S)          
             IF (l_cnt != sr1.l_pageno) THEN
                LET l_inbo009_sum = ''
                LET l_money_sum = ''
                LET sr1.l_rel_num = '' #20161130 add by beckxie
                LET sr1.l_money = ''   #20161130 add by beckxie
             ELSE
                EXECUTE aint701_inbo009_sum 
                  #USING sr1.l_indcdocno,sr1.l_inbo006,sr1.l_inam012 INTO l_inbo009_sum,l_money_sum   #20161130 mark by beckxie      
                  USING sr1.l_indcdocno,sr1.l_inbo006,sr1.l_inam012 INTO sr1.l_rel_num,sr1.l_money   #20161130 add by beckxie
             END IF
          END IF
          PRINTX l_inbo009_sum 
          PRINTX l_money_sum
          #161017-00051#9 Add By Ken 161118(E)
          
                    
#          #161102-00026#5 -s by 08172
#          #小計
#          LET sr1.l_rel_num = sr1.l_inbo0091+sr1.l_inbo0092+sr1.l_inbo0093+sr1.l_inbo0094+sr1.l_inbo0095+
#                              sr1.l_inbo0096
#          PRINTX sr1.l_rel_num
##         #161102-00026#5 -e by 08172 
          #纵向小计
          IF cl_null(l_sum.sum01) THEN LET  l_sum.sum01= 0 END IF            
          IF cl_null(l_sum.sum02) THEN LET  l_sum.sum02= 0 END IF            
          IF cl_null(l_sum.sum03) THEN LET  l_sum.sum03= 0 END IF           
          IF cl_null(l_sum.sum04) THEN LET  l_sum.sum04= 0 END IF            
          IF cl_null(l_sum.sum05) THEN LET  l_sum.sum05= 0 END IF            
          IF cl_null(l_sum.sum06) THEN LET  l_sum.sum06= 0 END IF
          IF cl_null(l_sum.sum07) THEN LET  l_sum.sum07= 0 END IF    #161102-00026#5 by 08172
          IF cl_null(l_sum.sum08) THEN LET  l_sum.sum08= 0 END IF    #161102-00026#5 by 08172
          IF cl_null(l_sum.sum09) THEN LET  l_sum.sum09= 0 END IF    #161102-00026#5 by 08172
          IF cl_null(l_sum.sum10) THEN LET  l_sum.sum10= 0 END IF    #161102-00026#5 by 08172
          IF cl_null(l_sum.sum11) THEN LET  l_sum.sum11= 0 END IF    #161102-00026#5 by 08172
          IF cl_null(l_sum.sum12) THEN LET  l_sum.sum12= 0 END IF    #161102-00026#5 by 08172          
          LET l_sum.sum01=l_sum.sum01+ sr1.l_inbo0091 
          LET l_sum.sum02=l_sum.sum02+ sr1.l_inbo0092 
          LET l_sum.sum03=l_sum.sum03+ sr1.l_inbo0093 
          LET l_sum.sum04=l_sum.sum04+ sr1.l_inbo0094 
          LET l_sum.sum05=l_sum.sum05+ sr1.l_inbo0095 
          LET l_sum.sum06=l_sum.sum06+ sr1.l_inbo0096
          LET l_sum.sum07=l_sum.sum07+ sr1.l_inbo0097    #161102-00026#5 by 08172
          LET l_sum.sum08=l_sum.sum08+ sr1.l_inbo0098    #161102-00026#5 by 08172
          LET l_sum.sum09=l_sum.sum09+ sr1.l_inbo0099    #161102-00026#5 by 08172
          LET l_sum.sum10=l_sum.sum10+ sr1.l_inbo00910    #161102-00026#5 by 08172
          LET l_sum.sum11=l_sum.sum11+ sr1.l_inbo00911    #161102-00026#5 by 08172
          LET l_sum.sum12=l_sum.sum12+ sr1.l_inbo00912    #161102-00026#5 by 08172          
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
                sr1.inbment CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aint701_g02_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g02_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aint701_g02_subrep03
           DECLARE aint701_g02_repcur03 CURSOR FROM g_sql
           FOREACH aint701_g02_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g02_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aint701_g02_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g02_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           #先判斷此筆資料是否有超過一頁(超過一頁的話，第一頁橫向加總空白，第二頁是整箱合計)
           LET l_cnt = 0
           EXECUTE aint701_page_cnt USING sr1.l_indcdocno INTO l_cnt   #161017-00051#9 Add By Ken 161118                     
           #總計(合計)   
           #161102-00026#5 -s by 08172
           LET l_sub_sql = " SELECT SUM(l_rel_num) FROM aint701_print_tmp ",
                       " WHERE l_indcdocno=? "
           PREPARE inbo009_total FROM l_sub_sql                      
           EXECUTE inbo009_total INTO l_inbo009_total USING sr1.l_indcdocno
           IF cl_null(l_inbo009_total) THEN LET l_inbo009_total = 0 END IF
#           LET l_inbo009_total = ''
           #161102-00026#5 -e by 08172
           LET l_sub_sql = " SELECT SUM(l_money) FROM aint701_print_tmp ",
                           "  WHERE l_indcdocno=?"
           PREPARE l_money_total FROM l_sub_sql                      
           EXECUTE l_money_total INTO l_money_total USING sr1.l_indcdocno
           IF cl_null(l_money_total) THEN LET l_money_total = 0 END IF
           #161017-00051#9 Add By ken 161128(S)  #先判斷此筆資料是否有超過一頁(超過一頁的話，第一頁橫向加總空白，第二頁是整箱合計)
           IF (l_cnt > 1) THEN 
              IF (l_cnt != sr1.l_pageno) THEN
                 LET l_inbo009_total = '' 
                 LET l_money_total = ''                 
              END IF
           END IF
           #161017-00051#9 Add By ken 161128(E)           
           PRINTX l_inbo009_total
           PRINTX l_money_total    
           PRINTX l_sum.*   
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.inbment CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aint701_g02_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g02_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aint701_g02_subrep04
           DECLARE aint701_g02_repcur04 CURSOR FROM g_sql
           FOREACH aint701_g02_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g02_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aint701_g02_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g02_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_inbo006
 
           #add-point:rep.a_group.l_inbo006.before name="rep.a_group.l_inbo006.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_inbo006.after name="rep.a_group.l_inbo006.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_inam012
 
           #add-point:rep.a_group.l_inam012.before name="rep.a_group.l_inam012.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_inam012.after name="rep.a_group.l_inam012.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aint701_g02.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aint701_g02_subrep01(sr2)
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
PRIVATE REPORT aint701_g02_subrep02(sr2)
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
PRIVATE REPORT aint701_g02_subrep03(sr2)
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
PRIVATE REPORT aint701_g02_subrep04(sr2)
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
 
{<section id="aint701_g02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL aint701_g02_create_tmp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/9/9 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g02_create_tmp_table()
   DROP TABLE aint701_tmp1;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aint701_tmp1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF

   CREATE TEMP TABLE aint701_tmp1(  
                   inbm001     VARCHAR(10), 
                   inbment     SMALLINT, 
                   inbmsite    VARCHAR(10), 
                   inbmunit    VARCHAR(10),
                   inbm007     VARCHAR(255),                 #备注                   
                   inbo001     VARCHAR(10),
                   ooag011  VARCHAR(255), 
                   ooefl003  VARCHAR(500),
                   docno       VARCHAR(20),               #單號  
                   item        VARCHAR(100),                  #料件编号
                   imaal003    VARCHAR(255),               #品名
                   inam012     VARCHAR(1000),                 #特徵一值(顏色)
                   imaa116     DECIMAL(20,6),                 #吊牌价
                   inam014     VARCHAR(1000),                 #特徵二值(尺寸)
                   inam018     VARCHAR(1000),                 #特徵四值(拉頭名稱)
                   inaa001     VARCHAR(10),                 #出货仓库
                   inaa002     VARCHAR(10),                 #仓库名称
                   unit        VARCHAR(10),                 #單位                  
                   qty         DECIMAL(20,6),                 #數量 
                   condition   VARCHAR(1000),                 #分组条件                   
                   inbmdocno   VARCHAR(20)     #161220-00009#1 Add By Ken 161228 加inbmdocno
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create aint701_tmp1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 建立列印用暫存表
# Memo...........:
# Usage..........: CALL aint701_g02_create_print_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g02_create_print_tmp()
   DROP TABLE aint701_print_tmp   
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'aint701_pring_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF

   CREATE TEMP TABLE aint701_print_tmp(    
                     inbm001  VARCHAR(10), 
                     inbment  SMALLINT, 
                     inbmsite  VARCHAR(10), 
                     inbmunit  VARCHAR(10),
                     inbm007   VARCHAR(255),                     
                     inbo001  VARCHAR(10),
                     ooag011  VARCHAR(255), 
                     ooefl003  VARCHAR(500),
                     page_no    SMALLINT,       #161017-00051#9 Add By Ken 161128                     
                     l_inbo006  VARCHAR(40), 
                     l_imaal003  VARCHAR(100), 
                     l_inam012  VARCHAR(30),
                     l_imaa116  DECIMAL(20,6),                     
                     l_inam014  VARCHAR(30), 
                     l_inam018  VARCHAR(30), 
                     l_inbo008  VARCHAR(10), 
                     l_inbo0091  DECIMAL(20,6), 
                     l_inbo0092  DECIMAL(20,6), 
                     l_inbo0093  DECIMAL(20,6), 
                     l_inbo0094  DECIMAL(20,6), 
                     l_inbo0095  DECIMAL(20,6), 
                     l_inbo0096  DECIMAL(20,6), 
                     l_inbo0097  DECIMAL(20,6),
                     l_inbo0098  DECIMAL(20,6),        #161102-00026#5 by 08172
                     l_inbo0099  DECIMAL(20,6),        #161102-00026#5 by 08172
                     l_inbo00910  DECIMAL(20,6),        #161102-00026#5 by 08172
                     l_inbo00911  DECIMAL(20,6),        #161102-00026#5 by 08172
                     l_inbo00912  DECIMAL(20,6),        #161102-00026#5 by 08172
                     l_inaa001  VARCHAR(10),
                     l_inaa002  VARCHAR(500),                     
                     l_indcdocno  VARCHAR(20), 
                     l_sum  DECIMAL(20,0),
                     l_rel_num  DECIMAL(20,0),                     
                     l_money  DECIMAL(20,6),
                     inbmdocno  VARCHAR(20)     #161220-00009#1 Add By Ken 161228 加inbmdocno
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create aint701_print_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF    

   DROP TABLE inam014_tmp
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'inam014_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   
   CREATE TEMP TABLE inam014_tmp
   (
    i          decimal(5,0),
    docno       VARCHAR(20),
    inam014     VARCHAR(30),
    page_no     SMALLINT     #161017-00051#9 Add By Ken 161128    
    )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create inam014_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 計算交叉表數值區資料總和
# Memo...........:
# Usage..........: CALL aint701_g02_inbo_tmp(p_indcdocno,p_i)
#                  RETURNING 回传参数
# Input parameter: p_indcdocno    裝箱單號
#                : p_i            第幾筆
# Return code....: 
# Date & Author..: 2016/09/19 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g02_inbo_tmp_1(p_indcdocno,p_i)
   DEFINE p_indcdocno  LIKE inbm_t.inbmdocno
   DEFINE p_i          LIKE type_t.num5
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_max        LIKE type_t.num5
   DEFINE l_max2       LIKE type_t.num5
   DEFINE l_a          LIKE type_t.num5
   DEFINE l_b          LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_inbo009    STRING
   DEFINE l_vi         varchar(3)
   DEFINE i            LIKE type_t.num5
   DEFINE merge_l_sum  STRING
   DEFINE merge_l_rel_num  STRING
   DEFINE merge_l_money  STRING

   CALL g_inam014.clear()

   SELECT COUNT(DISTINCT inam014) INTO l_n FROM aint701_tmp1
         WHERE docno=p_indcdocno 
   LET l_i = (l_n-1)/12
   LET l_i = l_i +1
   IF l_i = p_i THEN
      LET l_max = l_n
   ELSE
      LET l_max = p_i*12
   END IF

   IF l_max mod 12 = 0 THEN 
      LET l_max2 = 12
   ELSE
      LET l_max2 = l_max mod 12
   END IF

   #161017-00051#9 Mark By ken 161109(S)
   #LET l_a = p_i*12-11
   #LET l_b = p_i*12  
   #161017-00051#9 Mark By ken 161109(E)
   LET l_a = 12-11
   LET l_b = 12     
   LET l_sql = " SELECT inam014 FROM inam014_tmp",
               " WHERE i >=? AND i<=? ",
               "   AND docno = '",p_indcdocno,"'",
               "   AND page_no = ",p_i," ",    #161017-00051#9 Add By ken 161109 第幾頁的特徵
               " ORDER BY i"
   PREPARE inam014_pr FROM l_sql
   DECLARE inam014_cs CURSOR FOR inam014_pr
   OPEN inam014_cs USING l_a,l_b
   LET i=1
   FOREACH inam014_cs INTO g_inam014[i]
      IF i = l_max2 THEN
         EXIT FOREACH
      ELSE
         LET i=i+1
      END IF
   END FOREACH
   
   LET l_sql = " INSERT INTO aint701_print_tmp(inbm001 ,   inbment   ,  inbmsite   , inbmunit ,inbm007, ",
               "                               inbo001 ,   ooag011,ooefl003,l_inbo006 , l_imaal003 , l_inam012  , l_imaa116  ,l_inam014 , ",
               "                               l_inam018 , l_inbo008,  ",
               "                               page_no "     #161017-00051#9 Add By ken 161128 第幾頁的特徵               
   FOR i=1 to l_max2
      CASE i WHEN 1 LET l_inbo009 = 'l_inbo0091'
             WHEN 2 LET l_inbo009 = 'l_inbo0092'
             WHEN 3 LET l_inbo009 = 'l_inbo0093'
             WHEN 4 LET l_inbo009 = 'l_inbo0094'
             WHEN 5 LET l_inbo009 = 'l_inbo0095'
             WHEN 6 LET l_inbo009 = 'l_inbo0096'
             WHEN 7 LET l_inbo009 = 'l_inbo0097'
             WHEN 8 LET l_inbo009 = 'l_inbo0098'   #161102-00026#5 by 08172
             WHEN 9 LET l_inbo009 = 'l_inbo0099'   #161102-00026#5 by 08172
             WHEN 10 LET l_inbo009 = 'l_inbo00910'   #161102-00026#5 by 08172
             WHEN 11 LET l_inbo009 = 'l_inbo00911'   #161102-00026#5 by 08172
             WHEN 12 LET l_inbo009 = 'l_inbo00912'   #161102-00026#5 by 08172
      END CASE
      LET l_sql = l_sql , ",",l_inbo009
   END FOR
   
   LET l_sql = l_sql,",l_inaa001,l_inaa002,l_indcdocno,l_sum,l_rel_num,l_money,",
                     " inbmdocno "    #161220-00009#1 Add By Ken 161228 加inbmdocno
   LET l_sql = l_sql," ) SELECT inbm001,inbment,inbmsite,inbmunit,inbm007,'',ooag011,ooefl003,item,imaal003,inam012,imaa116,inam014,inam018,unit, ",
                     "          ",p_i, " "   #161017-00051#9 Add By ken 161128 第幾頁的特徵    
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,con",l_vi
   END FOR
   
   LET l_sql = l_sql,",inaa001,inaa002,docno,0,0,0, ",
                     " inbmdocno "   #161220-00009#1 Add By Ken 161228 加inbmdocno
   LET l_sql = l_sql,"     FROM ( SELECT inbm001,   inbment, inbmsite,inbmunit,inbm007,   ",
                     "          '',   ooag011,ooefl003,item,    imaal003,inam012, imaa116,inam014,    ",
                     "          inam018,   unit "
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,") con",l_vi
   END FOR
   LET l_sql = l_sql," ,inaa001,inaa002,docno, ",
                     "  inbmdocno ",   #161220-00009#1 Add By Ken 161228 加inbmdocno   
                     "  FROM ( SELECT inbm001 ,   inbment   , inbmsite   , inbmunit ,inbm007, ",
                     "                '' ,   ooag011,ooefl003,item,       imaal003 , inam012, imaa116,  inam014 , ",
                     "                inam018 ,   unit "
 
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        " THEN qty ELSE 0 END A",l_vi
   END FOR
   LET l_sql = l_sql,  ",inaa001,inaa002,docno, ",
               "  inbmdocno ",   #161220-00009#1 Add By Ken 161228 加inbmdocno
               "  FROM aint701_tmp1 ",
               " WHERE docno='",p_indcdocno,"'",
               "   ) "
               ," GROUP BY inbm001, inbment,  inbmsite, inbmunit,inbm007, ",
               "           ooag011, ooefl003, item,     imaal003, inam012, imaa116,  inam014, ",
               "           inam018, unit,     inaa001,  inaa002,  docno, ",
               "           inbmdocno)"   #161220-00009#1 Add By Ken 161228 加inbmdocno
                              
   PREPARE inbm_print_pr FROM l_sql
   
   EXECUTE inbm_print_pr
   LET merge_l_sum = " MERGE INTO aint701_print_tmp O",
                     " USING (SELECT docno,COUNT(distinct inbo001) A FROM aint701_tmp1 GROUP BY docno) U ",
                     "    ON ( O.l_indcdocno = U.docno)",
                     " WHEN MATCHED THEN ",
                     "    UPDATE SET O.l_sum = U.A"
  PREPARE merge_l_sum_pre FROM merge_l_sum
  EXECUTE merge_l_sum_pre
  #161102-00026#5 -s by 08172
#  LET merge_l_rel_num = " MERGE INTO aint701_print_tmp O",
#                        " USING (SELECT docno,item,inam012,inam014,unit,COUNT(distinct inbo001) A FROM aint701_tmp1 GROUP BY docno,item,inam012,inam014,unit) U ",
#                        "    ON (     O.l_indcdocno = U.docno
#                                  AND O.l_inbo006 = U.item
#                                  AND O.l_inam012 = U.inam012
#                                  AND O.l_inam014 = U.inam014
#                                  AND O.l_inbo008 = U.unit)",
#                        " WHEN MATCHED THEN ",
#                        "    UPDATE SET O.l_rel_num = U.A"
#  PREPARE merge_l_rel_num_pre FROM merge_l_rel_num
#  EXECUTE merge_l_rel_num_pre
  #161102-00026#5 -e by 08172
  #161017-00051#9 Add BY Ken 161128加page_no(S)
  LET merge_l_money = " MERGE INTO aint701_print_tmp O",
                      " USING (SELECT l_indcdocno,page_no,l_inbo006,l_imaa116,l_inam012,l_inam014,con A,con*l_imaa116 B
                                 FROM (SELECT l_indcdocno,page_no,l_inbo006,l_imaa116,l_inam012,l_inam014,
                                              (COALESCE(l_inbo0091,0)+COALESCE(l_inbo0092,0)+COALESCE(l_inbo0093,0)+COALESCE(l_inbo0094,0)+COALESCE(l_inbo0095,0)+COALESCE(l_inbo0096,0)+COALESCE(l_inbo0097,0)+COALESCE(l_inbo0098,0)+COALESCE(l_inbo0099,0)+COALESCE(l_inbo00910,0)+COALESCE(l_inbo00911,0)+COALESCE(l_inbo00912,0)) con
                                         FROM (SELECT l_indcdocno,page_no,l_inbo006,l_imaa116,l_inam012,l_inam014,l_inbo0091,l_inbo0092,l_inbo0093,l_inbo0094,l_inbo0095,l_inbo0096,l_inbo0097,l_inbo0098,l_inbo0099,l_inbo00910,l_inbo00911,l_inbo00912
                                                 FROM aint701_print_tmp) )
                               ) U",   
                      "    ON (      O.l_indcdocno = U.l_indcdocno
                                 AND o.page_no   = U.page_no     
                                 AND O.l_inbo006 = U.l_inbo006
                                 AND O.l_inam012 = U.l_inam012
                                 AND O.l_inam014 = U.l_inam014)",
                      "  WHEN MATCHED THEN ",
                      "   UPDATE SET O.l_rel_num = U.A,O.l_money = U.B"  
  #161017-00051#9 Add BY Ken 161128加page_no(E)                      
  PREPARE merge_l_money_pre FROM merge_l_money
  EXECUTE merge_l_money_pre 
  #161102-00026#5 add l_rel_num by 08172  
END FUNCTION

################################################################################
# Descriptions...: 寫入暫存表
# Memo...........:
# Usage..........: CALL aint701_g02_ins_tmp_table1(p_wc,p_typ,p_typ1)
# Input parameter: p_wc           查詢條件
#                : p_typ          需求对象类型
#                : p_typ1         来源类型
# Return code....: 
# Date & Author..: #161024-00023#9 2016/10/27 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g02_ins_tmp_table1(p_wc,p_typ,p_typ1)
   DEFINE p_wc             STRING
   DEFINE p_typ            LIKE type_t.chr20
   DEFINE p_typ1           LIKE type_t.chr20    #161024-00023#9 by 08172
   DEFINE l_sql            STRING
   DEFINE l_inbment        LIKE inbm_t.inbment
   DEFINE l_inbmsite       LIKE inbm_t.inbmsite     
   DEFINE l_inbmunit       LIKE inbm_t.inbmunit     #配送中心
   DEFINE l_inbmdocno      LIKE inbm_t.inbmdocno    #裝箱單號
   DEFINE l_inbm001        LIKE inbm_t.inbm001      #需求對象
   DEFINE l_inbm001_desc   LIKE ooefl_t.ooefl003    #需求對象名稱
   DEFINE l_inbm005        LIKE inbm_t.inbm005      #裝箱人員
   DEFINE l_inbm005_desc   LIKE ooag_t.ooag011      #裝箱人員名稱
   DEFINE l_inbm007        LIKE inbm_t.inbm007      #备注
   DEFINE l_inbo001        LIKE inbo_t.inbo001      #箱號
   DEFINE l_inbo006        LIKE inbo_t.inbo006      #商品編號
   DEFINE l_imaal003       LIKE imaal_t.imaal003    #品名
   DEFINE l_inbo007        LIKE inbo_t.inbo007      #產品特徵
   DEFINE l_inbo008        LIKE inbo_t.inbo008      #單位
   DEFINE l_inbo009        LIKE inbo_t.inbo009      #裝箱數量
   DEFINE l_condition      LIKE type_t.chr1000      
   DEFINE l_imaa005        LIKE imaa_t.imaa005
   DEFINE l_inam012        LIKE inam_t.inam012
   DEFINE l_imaa116        LIKE imaa_t.imaa116      #吊牌价
   DEFINE l_indcdocno      LIKE indc_t.indcdocno    #出货单号
   DEFINE l_inaa001        LIKE inaa_t.inaa001      #出货仓库
   DEFINE l_inaa002        LIKE inaa_t.inaa002      #出货仓库名称
   DEFINE l_inam014        LIKE inam_t.inam014
   DEFINE l_inam018        LIKE inam_t.inam018
   DEFINE l_imec003        LIKE imec_t.imec003
   DEFINE l_imecl005       LIKE imecl_t.imecl005
   DEFINE l_imeb012        LIKE imeb_t.imeb012
   DEFINE l_cnt2           LIKE type_t.num5
   DEFINE l_docno_tmp      LIKE inbm_t.inbmdocno
   DEFINE l_inbo001_tmp    LIKE inbo_t.inbo001
   DEFINE l_sub_sql        STRING
   DEFINE l_inam014_cnt    LIKE type_t.num10
   DEFINE l_pageno         LIKE type_t.num10
   DEFINE l_pagecnt        LIKE type_t.num10      #161017-00051#9 Add By Ken 161128 單號、箱號的第幾頁   
   DEFINE l_ii             LIKE type_t.num10 
   DEFINE l_print_show     LIKE type_t.chr1
   DEFINE l_item           LIKE type_t.chr1000
   DEFINE l_qty_sum        LIKE pmdn_t.pmdn007
   DEFINE l_i              INTEGER
   DEFINE tok              base.StringTokenizer

   #把資料整理成明細
   IF p_typ = '1' AND p_typ1 = '4' THEN   #161024-00023#9 add p_typ1 by 08172
      #170116-00026#1 Mark By Ken 170116(S)
      #LET l_sql = " SELECT DISTINCT inbment,inbmsite,inbmunit,inbmdocno, ",
      #            "        inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
      #            "        inbo007,inbo008,inbo009,imaa116,indcdocno,'','' ",
      #170116-00026#1 Mark By Ken 170116(E)
      #170116-00026#1 Add By Ken 170116(S)
      LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno, ",
                  "        inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "        inbo007,inbo008,SUM(inbo009),imaa116,indcdocno,'','' ",
      #170116-00026#1 Add By Ken 170116(E)                  
                  "   FROM inbm_t ",
                  #161109-00078#14 -s by 08172
                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno ",
                  "   LEFT JOIN inbp_t ON inbpent = inbment AND inbpdocno = inbmdocno AND inbpseq = inbo011",
                  "                   AND EXISTS ",
                  "                         ( SELECT 1
                                                FROM indc_t,indd_t
                                               WHERE indcent = inbment
                                                 AND indcent = inddent
                                                 AND indcdocno = indddocno ",
                                                "AND indc199 = '2' ",   #161220-00037#8 Add By Ken 161227
                                                "AND indc000 <> '3' ",   #161220-00037#8 Mark By Ken 161227   #170116-00026#1 Modify By Ken 170116
                                                "AND indc002 = '4' ",
                                                "AND indc003 = inbp002 ",
                                                 #161220-00037#8 Add By Ken 161227(S)
                                                "AND inbpdocno = indd049 ",
                                                "AND inbpseq = indd050 ",
                                                 #161220-00037#8 Add By Ken 161227(E)
                                                 #161220-00037#8 Mark By Ken 161227(S)
                                                 #AND inbp011 = indd047
                                                 #AND inbp012 = indd048
                                                 #161220-00037#8 Mark By Ken 161227(E)
                                                 "AND indcstus <> 'X')",
                  #"   LEFT JOIN indc_t ON indcent = inbment AND indc000 <> '3' AND indc002 = '4' AND indc003 = inbp002 AND indcstus <> 'X'",   #161220-00037#8 Mark By Ken 161227
                  "   LEFT JOIN indc_t ON indcent = inbment AND indc199 = '2' AND indc002 = '4'  AND indc003 = inbp002 AND indcstus <> 'X'",    #161220-00037#8 Add By Ken 161227
                  "                    AND indc000 <> '3' ",  #170116-00026#1 Add By Ken 170116
                  "                    AND EXISTS",
                  "                        ( SELECT 1
                                               FROM indd_t
                                              WHERE inddent = indcent
                                                AND indddocno = indcdocno ",
                                                #170104-00068#4 Mark By ken 170105(S)
                                                #AND indd047 = inbp011
                                                #AND indd048 = inbp012)",
                                                #170104-00068#4 Mark By ken 170105(E)
                                                #170104-00068#4 Add By ken 170105(S)
                                                "AND inbpdocno = indd049 ",
                                                "AND inbpseq = indd050) ",                                                
                                                #170104-00068#4 Add By ken 170105(E)
#                  "   LEFT JOIN indc_t ON indcent = inbment AND indc000 <> '3' AND indc002 = '4' AND indc003 = inbm004 AND indcstus <> 'X'",
#                  "                   AND EXISTS
#                                           (SELECT 1
#                                                    FROM indd_t,inbp_t d
#                                                   WHERE indcent = inddent
#                                                     AND indddocno = indcdocno
#                                                     AND inbpdocno = inbmdocno
#                                                     AND inbpent = indcent
#                                                     AND indd047 = d.inbp011
#                                                     AND indd048 = d.inbp012
#                                                     AND inbpseq = (SELECT MIN(c.inbpseq)
#                                                                      FROM inbp_t c
#                                                                     WHERE c.inbpent = d.inbpent
#                                                                       AND c.inbpdocno = d.inbpdocno))",#161024-00023#9 by 08172
#                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno ",
                  #161109-00078#14 -e by 08172
                  "   LEFT JOIN ooefl_t ON ooeflent = inbment AND ooefl001 = inbm001 AND ooefl002 = '",g_dlang,"'",
                  "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
                  "   LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ", 
#                  "   LEFT JOIN indd_t ON inddent = indcent AND indddocno = indcdocno AND indd001 = inbo011",  #161024-00023#9 by 08172
#                  "   LEFT JOIN inaa_t ON inaaent = inbment AND inaasite = inbmunit AND inaa136 = 'Y'",
                  "  WHERE inbment = ",g_enterprise," AND inbo001 IS NOT NULL AND " ,p_wc CLIPPED ,
                  #170116-00026#1 Add By Ken 170116(S)
                  "  GROUP BY inbment,inbmsite,inbmunit,inbmdocno, ",
                  "           inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "           inbo007,inbo008,imaa116,indcdocno  "                
                  #170116-00026#1 Add By Ken 170116(E)
#161024-00023#9 -s by 08172
#   ELSE
   END IF
   IF p_typ = '2' AND p_typ1 = '4' THEN
#161024-00023#9 -e by 08172
      #170116-00026#1 Mark By Ken 170116(S)
      #LET l_sql = " SELECT DISTINCT inbment,inbmsite,inbmunit,inbmdocno, ",
      #            "        inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
      #            "        inbo007,inbo008,inbo009,imaa116,xmdkdocno,'','' ",
      #170116-00026#1 Mark By Ken 170116(E)
      #170116-00026#1 Add By Ken 170116(S)
      LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno, ",
                  "        inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "        inbo007,inbo008,SUM(inbo009),imaa116,xmdkdocno,'','' ",
      #170116-00026#1 Add By Ken 170116(E)
                  "   FROM inbm_t ",
                  #161109-00078#14 -s by 08172
                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno  ",
                  "   LEFT JOIN inbp_t ON inbpent = inbment AND inbpdocno = inbmdocno AND inbo011 = inbpseq",
                  "                   AND EXISTS",
                  "                        ( SELECT 1
                                               FROM xmdk_t,xmdl_t
                                              WHERE xmdkent = inbment
                                                AND xmdkent = xmdlent
                                                AND xmdkdocno = xmdldocno
                                                AND xmdk088 = '4'
                                                AND xmdkstus <> 'X' ",
                                                #161220-00037#8 Add By Ken 161227(S)
                                               "AND xmdl097 = inbpdocno ",
                                               "AND xmdl098 = inbpseq ",
                                                #161220-00037#8 Add By Ken 161227(E)
                                                #161220-00037#8 Mark By Ken 161227(S)
                                                #AND xmdl003 = inbp011
                                                #AND xmdl004 = inbp012
                                                #161220-00037#8 Mark By Ken 161227(E)
                                               "AND inbp002 = xmdk089)",
                  "   LEFT JOIN xmdk_t ON xmdkent = inbment AND xmdk088 = '4' AND xmdk089 = inbp002 AND xmdkstus <> 'X'",
                  "                   AND EXISTS",
                  "                        ( SELECT 1
                                               FROM xmdl_t
                                              WHERE xmdlent = xmdkent
                                                AND xmdldocno = xmdkdocno ",
                                                #161220-00037#8 Add By Ken 161227(S)
                                               "AND xmdl097 = inbpdocno ",
                                               "AND xmdl098 = inbpseq )",
                                                #161220-00037#8 Add By Ken 161227(E)
                                                #161220-00037#8 Mark By Ken 161227(S)
                                                #AND xmdl003 = inbp011
                                                #AND xmdl004 = inbp012)",
                                                #161220-00037#8 Mark By Ken 161227(E)                                                
#                  "   LEFT JOIN xmdk_t ON xmdkent = inbment AND xmdk088 = '4' AND xmdk089 = inbm004 AND xmdkstus <> 'X'",
#                  "   LEFT JOIN inbp_t b ON inbpent = inbment AND inbpdocno = inbmdocno 
#                                         AND EXISTS ( SELECT 1 FROM xmdl_t WHERE xmdlent = b.inbpent AND xmdldocno = xmdkdocno AND xmdl003 = b.inbp011 AND xmdl004 = b.inbp012)",  #161024-00023#9 by 08172
#                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno AND inbo011 = inbpseq ",
                  #161109-00078#14 -e by 08172
                  "   LEFT JOIN pmaal_t ON pmaalent = inbment AND pmaal001 = inbm001 AND pmaal002 = '",g_dlang,"'",
                  "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
                  "   LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ", 
#                  "   LEFT JOIN xmdl_t ON xmdlent = xmdkent AND xmdldocno = xmdkdocno AND xmdl095 = inbo011",  #161024-00023#9 by 08172
#                  "   LEFT JOIN inaa_t ON inaaent = inbment AND inaasite = inbmunit AND inaa136 = 'Y'",
                  "  WHERE inbment = ",g_enterprise," AND inbo001 IS NOT NULL AND " ,p_wc CLIPPED ,
                  #170116-00026#1 Add By Ken 170116(S)
                  "  GROUP BY inbment,inbmsite,inbmunit,inbmdocno, ",
                  "           inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "           inbo007,inbo008,imaa116,xmdkdocno  " 
                  #170116-00026#1 Add By Ken 170116(E)                  
   END IF
   #161024-00023#9 -s by 08172
   IF p_typ1 = '5' THEN
      #170116-00026#1 Mark By Ken 170116(S)
      #LET l_sql = " SELECT DISTINCT inbment,inbmsite,inbmunit,inbmdocno, ",
      #            "        inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
      #            "        inbo007,inbo008,inbo009,imaa116,pmdsdocno,'','' ",
      #170116-00026#1 Mark By Ken 170116(E)
      #170116-00026#1 Add By Ken 170116(S)
      LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno, ",
                  "        inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "        inbo007,inbo008,SUM(inbo009),imaa116,pmdsdocno,'','' ",
      #170116-00026#1 Add By Ken 170116(E)            
                  "   FROM inbm_t",
                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno ",
                  "   LEFT JOIN pmaal_t ON pmaalent = inbment AND pmaal001 = inbm001 AND pmaal002 = '",g_dlang,"'",
                  "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
                  "   LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ",
                  "   LEFT JOIN pmds_t ON pmdsent = inbment AND pmds006 = inbm004 AND pmdsstus <> 'X'",
                  "  WHERE inbment = ",g_enterprise," AND " ,p_wc CLIPPED ,
                  #170116-00026#1 Add By Ken 170116(S)
                  "  GROUP BY inbment,inbmsite,inbmunit,inbmdocno, ",
                  "           inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "           inbo007,inbo008,imaa116,pmdsdocno "
                  #170116-00026#1 Add By Ken 170116(E)
   END IF
   IF p_typ1 = '6' THEN
      #170116-00026#1 Mark By Ken 170116(S)
      #LET l_sql = " SELECT DISTINCT inbment,inbmsite,inbmunit,inbmdocno, ",
      #            "        inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
      #            "        inbo007,inbo008,inbo009,imaa116,indcdocno,'','' ",
      #170116-00026#1 Mark By Ken 170116(E)
      #170116-00026#1 Add By Ken 170116(S)
      LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno, ",
                  "        inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "        inbo007,inbo008,SUM(inbo009),imaa116,indcdocno,'','' ",
      #170116-00026#1 Add By Ken 170116(E)            
                  "   FROM inbm_t",
                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno ",
                  "   LEFT JOIN ooefl_t ON ooeflent = inbment AND ooefl001 = inbm001 AND ooefl002 = '",g_dlang,"'",
                  "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
                  "   LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ",
                  "   LEFT JOIN indc_t ON indcent = inbment AND indc001 = inbm004 AND indcstus <> 'X'",
                  "  WHERE inbment = ",g_enterprise," AND " ,p_wc CLIPPED ,
                  #170116-00026#1 Add By Ken 170116(S)
                  "  GROUP BY inbment,inbmsite,inbmunit,inbmdocno, ",
                  "           inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "           inbo007,inbo008,imaa116,indcdocno  "   
                  #170116-00026#1 Add By Ken 170116(E)                  
   END IF
   #161024-00023#9 -e by 08172
   #161024-00023#18 -s by 08172
   IF p_typ1 = '7' THEN
      #170116-00026#1 Mark By Ken 170116(S)
      #LET l_sql = " SELECT DISTINCT inbment,inbmsite,inbmunit,inbmdocno, ",
      #            "        inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
      #            "        inbo007,inbo008,inbo009,imaa116,xmdkdocno,'','' ",
      #170116-00026#1 Mark By Ken 170116(E)
      #170116-00026#1 Add By Ken 170116(S)
      LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno, ",
                  "        inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "        inbo007,inbo008,SUM(inbo009),imaa116,xmdkdocno,'','' ",
      #170116-00026#1 Add By Ken 170116(E)            
                  "   FROM inbm_t",
                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno ",
                  "   LEFT JOIN pmaal_t ON pmaalent = inbment AND pmaal001 = inbm001 AND pmaal002 = '",g_dlang,"'",
                  "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
                  "   LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ",
                  "   LEFT JOIN xmdk_t ON xmdkent = inbment AND xmdkdocno = inbm004 AND xmdkstus <> 'X'",
                  "  WHERE inbment = ",g_enterprise," AND " ,p_wc CLIPPED  ,
      #170116-00026#1 Add By Ken 170116(S)          
                  "  GROUP BY inbment,inbmsite,inbmunit,inbmdocno, ",
                  "           inbm001,pmaal004,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "           inbo007,inbo008,imaa116,xmdkdocno   "
      #170116-00026#1 Add By Ken 170116(E)                  
   END IF   
   #161024-00023#18 -e by 08172    
   
   #161217-00002#3 Add By Ken 161223(S)
   IF p_typ1 = '9' THEN
      #170116-00026#1 Mark By Ken 170116(S)
      #LET l_sql = " SELECT DISTINCT inbment,inbmsite,inbmunit,inbmdocno, ",
      #            "        inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
      #            "        inbo007,inbo008,inbo009,imaa116,inbm004,'','' ",
      #170116-00026#1 Mark By Ken 170116(E)
      #170116-00026#1 Add By Ken 170116(S)
      LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno, ",
                  "        inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "        inbo007,inbo008,SUM(inbo009),imaa116,inbm004,'','' ",
      #170116-00026#1 Add By Ken 170116(E)
                  "   FROM inbm_t",
                  "   LEFT JOIN inbo_t ON inbment = inboent AND inbmdocno = inbodocno ",
                  "   LEFT JOIN ooefl_t ON ooeflent = inbment AND ooefl001 = inbm001 AND ooefl002 = '",g_dlang,"'",
                  "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
                  "   LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ",
                  "  WHERE inbment = ",g_enterprise," AND " ,p_wc CLIPPED   ,
                  #170116-00026#1 Add By Ken 170116(S)
                  "  GROUP BY inbment,inbmsite,inbmunit,inbmdocno, ",
                  "           inbm001,ooefl003,inbm005,ooag011,inbm007,inbo001,inbo006,imaal003,",
                  "           inbo007,inbo008,imaa116,inbm004 "  
                  #170116-00026#1 Add By Ken 170116(E)                  
   END IF      
   #161217-00002#3 Add By Ken 161223(E)
   
   PREPARE aint701_sel_inbm_pre FROM l_sql
   DECLARE aint701_sel_inbm_cur CURSOR FOR aint701_sel_inbm_pre
   FOREACH aint701_sel_inbm_cur INTO l_inbment,l_inbmsite,    l_inbmunit,l_inbmdocno, 
                                     l_inbm001,l_inbm001_desc,l_inbm005,l_inbm005_desc,l_inbm007,l_inbo001,l_inbo006,l_imaal003,
                                     l_inbo007,l_inbo008,l_inbo009,l_imaa116,l_indcdocno,l_inaa001,l_inaa002
       #LET sr_s.l_condition="-",sr_s.inbb007 CLIPPED,"-",sr_s.inbb008 CLIPPED,"-",sr_s.inbb009 CLIPPED,"-",sr_s.inbb016 CLIPPED,"-"
       #LET sr[l_cnt].l_condition = sr_s.l_condition
       IF NOT cl_null(l_inbo007) THEN
         LET l_imaa005=NULL
         SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent=g_enterprise and imaa001=l_inbo006
         LET l_inam012=NULL
         LET l_inam014=NULL
         LET l_inam018=NULL
       
         LET l_cnt2=1
         LET tok = base.StringTokenizer.createExt(l_inbo007,'_','',TRUE)
         WHILE tok.hasMoreTokens()
            LET l_imec003=tok.nextToken()
            LET l_imeb012='N'
            SELECT imeb012 INTO l_imeb012 FROM imeb_t
             WHERE imebent=g_enterprise AND imeb002=l_cnt2
               AND imeb001=l_imaa005
               
            CASE l_imeb012
            #纵向
            WHEN 'N'
              LET l_imecl005=NULL
              SELECT imecl005 INTO l_imecl005
                FROM imec_t 
                LEFT OUTER JOIN imecl_t ON imecent = imeclent AND imec001 = imecl001 
                                       AND imec002 = imecl002 AND imec003 = imecl003  AND imecl004 = g_lang
               WHERE imecent = g_enterprise AND imec001 = l_imaa005 AND imec002 = l_cnt2
                 AND imec003 = l_imec003 AND imecstus = 'Y'
              IF cl_null(l_inam012) THEN
                LET l_inam012 = l_imec003,'·',l_imecl005   #161220-00009#1 Add By Ken 161227
                #LET l_inam012 = l_imecl005                #161220-00009#1 Mark By Ken 161227
              ELSE
                 LET l_inam012 = l_inam012,'/',l_imec003,'·',l_imecl005  #161220-00009#1 Add By Ken 161227
                 #LET l_inam012 = l_inam012,'/',l_imecl005               #161220-00009#1 Mark By Ken 161227  
              END IF 
            #横向
            WHEN 'Y'
              LET l_imecl005=NULL
              SELECT imecl005 INTO l_imecl005
                FROM imec_t 
                LEFT OUTER JOIN imecl_t ON imecent = imeclent AND imec001 = imecl001 
                                       AND imec002 = imecl002 AND imec003 = imecl003  AND imecl004 = g_lang
               WHERE imecent = g_enterprise AND imec001 = l_imaa005 AND imec002 = l_cnt2
                 AND imec003 = l_imec003 AND imecstus = 'Y'
               #LET l_inam014 = l_imec003,'-',l_imecl005
               LET l_inam014 = l_imecl005
            OTHERWISE
              EXIT WHILE
            END CASE 
            LET l_cnt2=l_cnt2+1
         END WHILE
        
          IF NOT cl_null(l_inam012) AND cl_null(l_inam014) THEN
            LET l_inam014 = "t-*"
          END IF 
          IF NOT cl_null(l_inam012) AND NOT cl_null(l_inam014) THEN
            EXECUTE aint701_ins_tmp1 USING l_inbm001,     l_inbment,     l_inbmsite,    l_inbmunit,l_inbm007,
                                           l_inbo001,     l_inbm005_desc,l_inbm001_desc,l_indcdocno,   
                                           l_inbo006,     l_imaal003,    l_inam012,     l_imaa116,     
                                           l_inam014,     l_inam018,     l_inaa001,     l_inaa002,
                                           l_inbo008,     l_inbo009,     l_condition,
                                           l_inbmdocno    #161220-00009#1 Add By Ken 161228 加inbmdocno                                           
          END IF 
        END IF 
   END FOREACH
   #如有多笔仓库抓第一笔
   LET l_sql = " SELECT docno,inbmunit FROM aint701_tmp1"
   PREPARE aint701_upd_inaa FROM l_sql
   DECLARE aint701_upd_inaa_cur CURSOR FOR aint701_upd_inaa
   FOREACH aint701_upd_inaa_cur INTO l_indcdocno,l_inbmunit
      #161228-00033#1 Mark By ken 170104(S)
      #LET l_sql = " SELECT inaa001,inaa002,ROWNUM rn FROM inaa_t WHERE inaaent = ",g_enterprise," AND inaasite = '",l_inbmunit,"' AND inaa136 = 'Y' ORDER BY inaa001"
      #LET l_sql = " SELECT inaa001,inaa002 FROM (",l_sql,") WHERE rn = 1"
      #PREPARE aint701_sel_inaa FROM l_sql
      #EXECUTE aint701_sel_inaa INTO l_inaa001,l_inaa002
      #161228-00033#1 Mark By ken 170104(E)      
      #161228-00033#1 Add By ken 170104(S)   
      LET l_sql = " SELECT inaa001,inaa002 ",
                  "   FROM inaa_t ",
                  "  WHERE inaaent = ",g_enterprise,
                  "    AND inaasite = '",l_inbmunit,"' ",
                  "    AND inaa136 = 'Y' ",
                  "  ORDER BY inaa001"
      PREPARE aint701_sel_inaa FROM l_sql
      DECLARE aint701_sel_inaa_cur SCROLL CURSOR FOR aint701_sel_inaa
      OPEN aint701_sel_inaa_cur
      FETCH FIRST aint701_sel_inaa_cur INTO l_inaa001,l_inaa002
      FREE aint701_sel_inaa
      CLOSE aint701_sel_inaa_cur
      #161228-00033#1 Add By ken 170104(E)   
      UPDATE aint701_tmp1 SET inaa001 = l_inaa001,inaa002 = l_inaa002  WHERE docno =  l_indcdocno    
   END FOREACH   
   
   CALL aint701_g02_create_print_tmp()
   #把明細資料整理成二維資料
   LET l_sql = "SELECT UNIQUE docno ",
               "  FROM aint701_tmp1 ORDER BY docno "
   PREPARE aint701_sel_tmp1 FROM l_sql
   DECLARE aint701_sel_tmp1_cur CURSOR FOR aint701_sel_tmp1
   FOREACH aint701_sel_tmp1_cur INTO l_docno_tmp
      
      LET l_sub_sql = " SELECT DISTINCT inam014 FROM aint701_tmp1 ",
                  " WHERE docno=? ",
                  " ORDER BY inam014"
      PREPARE inam014_ins FROM l_sub_sql
      DECLARE inam014_ins_cs CURSOR FOR inam014_ins
      
      #計算橫軸個數
      LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
      PREPARE inam014_cnt_pre FROM l_sql            
      
      EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING l_docno_tmp
      FREE inam014_cnt_pre
         
      ##總計(合計)   
      #LET l_sub_sql = " SELECT SUM(inbo009) FROM aint701_tmp1 ",
      #            " WHERE docno=? and inbn001=? "
      #PREPARE inbo009_total FROM l_sub_sql
          
      IF NOT cl_null(l_inam014_cnt) THEN
         #LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆  #170104-00068#4 Mark By Ken 170105
         LET l_pageno = (l_inam014_cnt -1)/12   #每頁10筆   #170104-00068#4 Add By ken 170105
         LET l_pageno = l_pageno +1
         LET l_pagecnt = 1     #161017-00051#9 Add By Ken 161128  第幾頁
         #DELETE FROM inam014_tmp WHERE 1=1
         OPEN inam014_ins_cs USING l_docno_tmp
         LET l_i=1
         FOREACH inam014_ins_cs INTO l_inam014
            #INSERT INTO inam014_tmp VALUES(l_i,l_docno_tmp,l_inam014)  #161017-00051#9 Mark By Ken 161128
            #161017-00051#9 Add By Ken 161109(S)
            INSERT INTO inam014_tmp VALUES(l_i,l_docno_tmp,l_inam014,l_pagecnt)  
            IF l_i MOD 12 = 0 THEN            
               LET l_i = 0
               LET l_pagecnt = l_pagecnt + 1
            END IF
            #161017-00051#9 Add By Ken 161109(E)            
            LET l_i=l_i+1
         END FOREACH
      
         FOR l_i = 1 to l_pageno
            CALL aint701_g02_inbo_tmp_1(l_docno_tmp,l_i)
         END FOR  
      END IF
   END FOREACH
END FUNCTION

 
{</section>}
 
{<section id="aint701_g02.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
