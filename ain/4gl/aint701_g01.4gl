#該程式未解開Section, 採用最新樣板產出!
{<section id="aint701_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-12-27 16:56:50), PR版次:0008(2016-12-27 18:36:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000010
#+ Filename...: aint701_g01
#+ Description: ...
#+ Creator....: 06137(2016-09-09 13:46:48)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="aint701_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161024-00023#6  20161028  by  06137    1.装箱清单IF (需求对象类型)inbm008=3.供应商 then 根据需求对象编号(inbm001)取供应商名称
#161017-00051#7  20161104  by  06137    装箱清单二维的特征栏位改为12列
#161017-00051#8  20161108  by  06137    装箱清单和汇总单同一颜色的，不同尺码的装箱信息，应该显示在一行
#161017-00051#9  20161109  by  06137    装箱清单和汇总单打印，尺码超过12列的，增加分页显示功能
#161220-00009#1  20161227  by  06137    1.装箱清单和汇总单打印单头增加审核人、审核日期，2.装箱清单和汇总单增加显示颜色编码,显示格式是58▪黑色
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
   inbnent LIKE inbn_t.inbnent, 
   inbm001 LIKE inbm_t.inbm001, 
   inbm005 LIKE inbm_t.inbm005, 
   inbm006 LIKE inbm_t.inbm006, 
   inbm007 LIKE inbm_t.inbm007, 
   inbmdocdt LIKE inbm_t.inbmdocdt, 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbment LIKE inbm_t.inbment, 
   inbmsite LIKE inbm_t.inbmsite, 
   inbmstus LIKE inbm_t.inbmstus, 
   inbmunit LIKE inbm_t.inbmunit, 
   inbn001 LIKE inbn_t.inbn001, 
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
   inbnunit LIKE inbn_t.inbnunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   l_pageno LIKE type_t.num5, 
   l_order LIKE type_t.chr37
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
TYPE t_print RECORD
   inbm001 LIKE inbm_t.inbm001, 
   inbm005 LIKE inbm_t.inbm005, 
   inbm006 LIKE inbm_t.inbm006, 
   inbm007 LIKE inbm_t.inbm007, 
   inbmdocdt LIKE inbm_t.inbmdocdt, 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbment LIKE inbm_t.inbment, 
   inbmsite LIKE inbm_t.inbmsite, 
   inbmstus LIKE inbm_t.inbmstus, 
   inbmunit LIKE inbm_t.inbmunit, 
   inbn001 LIKE inbn_t.inbn001, 
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
   #161017-00051#7 Add By Ken 161104(S)
   l_inbo0098 LIKE inbo_t.inbo009, 
   l_inbo0099 LIKE inbo_t.inbo009, 
   l_inbo00910 LIKE inbo_t.inbo009, 
   l_inbo00911 LIKE inbo_t.inbo009, 
   l_inbo00912 LIKE inbo_t.inbo009,    
   #161017-00051#7 Add By Ken 161104(E)
   inbnunit LIKE inbn_t.inbnunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003
 END RECORD
#DEFINE g_inam014        ARRAY[6] OF VARCHAR(1000)   #161017-00051#7 Mark By Ken 161104
DEFINE g_inam014        ARRAY[13] OF VARCHAR(1000)   #161017-00051#7 Add By Ken 161104
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
                 #161017-00051#7 Add By Ken 161104(S)
                 sum08  LIKE type_t.num20_6,
                 sum09  LIKE type_t.num20_6,
                 sum10  LIKE type_t.num20_6,
                 sum11  LIKE type_t.num20_6,
                 sum12  LIKE type_t.num20_6
                 #161017-00051#7 Add By Ken 161104(E)
             END RECORD 
#end add-point
 
{</section>}
 
{<section id="aint701_g01.main" readonly="Y" >}
PUBLIC FUNCTION aint701_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
DEFINE l_session_id    LIKE type_t.num20
#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_template="aint701_g01"
   
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "------------------------------"
   DISPLAY "SessionId: ",l_session_id   
   DISPLAY "------------------------------"
   CALL aint701_g01_create_tmp_table()     
   LET g_sql = " INSERT INTO aint701_tmp1(inbm001,inbm005,inbm006,inbm007,inbmdocdt,inbment,inbmsite,inbmstus,inbmunit,inbn001, ",
               "                          ooag_t_ooag011,ooefl_t_ooefl003,docno,item,imaal003,inam012,inam014,inam018,unit,qty, ",
               "                          condition) ",
               " VALUES (?,?,?,?,?,?,?,?,?,?, ",
               "         ?,?,?,?,?,?,?,?,?,?, ",
               "         ?) "
   PREPARE aint701_ins_tmp1 FROM g_sql
   CALL aint701_g01_ins_tmp_table(tm.wc)   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aint701_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aint701_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aint701_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aint701_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aint701_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aint701_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT inbnent,inbm001,inbm005,inbm006,inbm007,inbmdocdt,inbmdocno,inbment,inbmsite, 
       inbmstus,inbmunit,inbn001,'','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,inbnunit,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = inbm_t.inbm005 AND ooag_t.ooagent = inbm_t.inbment), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = inbm_t.inbm006 AND ooefl_t.ooeflent = inbm_t.inbment AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),0,''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM inbm_t LEFT OUTER JOIN ( SELECT inbn_t.* FROM inbn_t  ) x  ON inbm_t.inbment  
        = x.inbnent AND inbm_t.inbmdocno = x.inbndocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY inbmdocno,inbn001"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inbm_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #161017-00051#8 Mark By Ken 161108(S)
   #LET g_sql = " SELECT inbment,   inbm001,  inbm005,   inbm006,   inbm007, ",
   #            "        inbmdocdt, inbmdocno,inbment,   inbmsite,  inbmstus,", 
   #            "        inbmunit,  inbn001,  l_inbo006, l_imaal003,l_inam012,",
   #            "        l_inam014, l_inam018,l_inbo008, l_inbo0091,l_inbo0092,",
   #            "        l_inbo0093,l_inbo0094,l_inbo0095,l_inbo0096,l_inbo0097, ",
   #            "        l_inbo0098,l_inbo0099,l_inbo00910,l_inbo00911,l_inbo00912, ",   #161017-00051#7 Add By Ken 161104
   #            "        inbnunit,  ooag_t_ooag011, ooefl_t_ooefl003 ", 
   #            "   FROM aint701_print_tmp ",
   #            "  ORDER BY inbmdocno,inbm001 "
   #161017-00051#8 Mark By Ken 161108(E)
   #161017-00051#8 Add By Ken 161108(S)
   LET g_sql = " SELECT inbment,   inbm001,  inbm005,   inbm006,   inbm007, ",
               "        inbmdocdt, inbmdocno,inbment,   inbmsite,  inbmstus,", 
               "        inbmunit,  inbn001,  l_inbo006, l_imaal003,l_inam012,",
               "     '' l_inam014, l_inam018,l_inbo008, SUM(l_inbo0091),SUM(l_inbo0092),",
               "        SUM(l_inbo0093),SUM(l_inbo0094),SUM(l_inbo0095),SUM(l_inbo0096),SUM(l_inbo0097), ",
               "        SUM(l_inbo0098),SUM(l_inbo0099),SUM(l_inbo00910),SUM(l_inbo00911),SUM(l_inbo00912), ",   #161017-00051#7 Add By Ken 161104
               "        inbnunit,  ooag_t_ooag011, ooefl_t_ooefl003, ", 
               "        page_no,   trim(inbmdocno)||'.'||trim(inbn001)||'.'||trim(TO_CHAR(page_no,'0000')) ",
               "   FROM aint701_print_tmp ",
               "  GROUP BY inbment,   inbm001,  inbm005,   inbm006,   inbm007, ",
               "           inbmdocdt, inbmdocno,inbment,   inbmsite,  inbmstus,", 
               "           inbmunit,  inbn001,  l_inbo006, l_imaal003,l_inam012,",
               "           l_inam018,l_inbo008, inbnunit,  ooag_t_ooag011, ooefl_t_ooefl003, ",
               "           page_no,   trim(inbmdocno)||'.'||trim(inbn001)||'.'||trim(TO_CHAR(page_no,'0000')) ",
               "  ORDER BY inbmdocno,inbn001,page_no,l_inbo006,l_inam012 "
               #"  ORDER BY inbmdocno,inbm001 "
               
   #161017-00051#8 Add By Ken 161108(E)               
   #end add-point
   PREPARE aint701_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aint701_g01_curs CURSOR FOR aint701_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aint701_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aint701_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inbnent LIKE inbn_t.inbnent, 
   inbm001 LIKE inbm_t.inbm001, 
   inbm005 LIKE inbm_t.inbm005, 
   inbm006 LIKE inbm_t.inbm006, 
   inbm007 LIKE inbm_t.inbm007, 
   inbmdocdt LIKE inbm_t.inbmdocdt, 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbment LIKE inbm_t.inbment, 
   inbmsite LIKE inbm_t.inbmsite, 
   inbmstus LIKE inbm_t.inbmstus, 
   inbmunit LIKE inbm_t.inbmunit, 
   inbn001 LIKE inbn_t.inbn001, 
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
   inbnunit LIKE inbn_t.inbnunit, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   l_pageno LIKE type_t.num5, 
   l_order LIKE type_t.chr37
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
    FOREACH aint701_g01_curs INTO sr_s.*
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
       LET sr[l_cnt].inbnent = sr_s.inbnent
       LET sr[l_cnt].inbm001 = sr_s.inbm001
       LET sr[l_cnt].inbm005 = sr_s.inbm005
       LET sr[l_cnt].inbm006 = sr_s.inbm006
       LET sr[l_cnt].inbm007 = sr_s.inbm007
       LET sr[l_cnt].inbmdocdt = sr_s.inbmdocdt
       LET sr[l_cnt].inbmdocno = sr_s.inbmdocno
       LET sr[l_cnt].inbment = sr_s.inbment
       LET sr[l_cnt].inbmsite = sr_s.inbmsite
       LET sr[l_cnt].inbmstus = sr_s.inbmstus
       LET sr[l_cnt].inbmunit = sr_s.inbmunit
       LET sr[l_cnt].inbn001 = sr_s.inbn001
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
       LET sr[l_cnt].inbnunit = sr_s.inbnunit
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
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
 
{<section id="aint701_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aint701_g01_rep_data()
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
          START REPORT aint701_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aint701_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aint701_g01_rep
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
 
{<section id="aint701_g01.rep" readonly="Y" >}
PRIVATE REPORT aint701_g01_rep(sr1)
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
#161017-00051#7 Add By Ken 161104(S)
DEFINE l_inam0148      LIKE type_t.chr1000
DEFINE l_inam0149      LIKE type_t.chr1000
DEFINE l_inam01410     LIKE type_t.chr1000
DEFINE l_inam01411     LIKE type_t.chr1000
DEFINE l_inam01412     LIKE type_t.chr1000
#161017-00051#7 Add By Ken 161104(E)
DEFINE l_inbo009_sum   LIKE type_t.num10
DEFINE l_inbo009_total LIKE type_t.num10
DEFINE l_title         LIKE type_t.chr1000
DEFINE l_sql           STRING
DEFINE l_sum r_sum
DEFINE i               LIKE type_t.num5
DEFINE l_title_tmp     LIKE type_t.chr1000
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
            CALL cl_getmsg('ain-00819',g_dlang) RETURNING l_title_tmp
            LET g_grPageHeader.title0201 = l_title_tmp
            #161017-00051#9 Add BY Ken 161116(S)
            LET g_rep_docno = sr1.inbmdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*            
            #161017-00051#9 Add BY Ken 161116(E)
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.l_order
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            #161017-00051#9 Add BY Ken 161116(S)
            LET g_doc_key = 'inbment=' ,sr1.inbment,'{+}inbmdocno=' ,sr1.inbmdocno         
            CALL cl_gr_init_apr(sr1.inbmdocno)
            #161017-00051#9 Add BY Ken 161116(E)
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
           #161017-00051#9 Add By Ken 161118(S)
           #用來判斷此筆資料的單號、箱號是否超過一頁
           LET l_sql = "SELECT COUNT(1) FROM ( " ,
                       "SELECT UNIQUE inbmdocno,inbn001, page_no ",
                       "  FROM aint701_print_tmp ",
                       " WHERE inbmdocno = ? ",
                       "   AND inbn001 = ?  )"
           PREPARE aint701_page_cnt FROM l_sql  

           #如單號、箱號有多頁時，橫向總計(同箱的最後一頁顯示)
           LET l_sql = " SELECT SUM(COALESCE(l_inbo0091,0) ",
                       "          + COALESCE(l_inbo0092,0) ",
                       "          + COALESCE(l_inbo0093,0) ",
                       "          + COALESCE(l_inbo0094,0) ",
                       "          + COALESCE(l_inbo0095,0) ",
                       "          + COALESCE(l_inbo0096,0) ",
                       "          + COALESCE(l_inbo0097,0) ",
                       "          + COALESCE(l_inbo0098,0) ",
                       "          + COALESCE(l_inbo0099,0) ",
                       "          + COALESCE(l_inbo00910,0)",
                       "          + COALESCE(l_inbo00911,0)",
                       "          + COALESCE(l_inbo00912,0)) FROM aint701_print_tmp ",
                       " WHERE inbmdocno=? AND inbn001=? AND l_inbo006=? AND l_inam012 =? "  
           PREPARE aint701_inbo009_sum FROM l_sql
           #161017-00051#9 Add By Ken 161118(E)
           
           CALL g_inam014.clear()
           LET i = 1
           LET l_sql = " SELECT inam014 FROM inam014_tmp",
                       " WHERE inbn001 = ? ",
                       "   AND inbndocno = ? ",  #20161014
                       "   AND page_no = ? ",    #161017-00051#9 Add BY Ken 161116
                       " ORDER BY i"
           PREPARE aint701_sel_inam014_pre FROM l_sql
           DECLARE aint701_sel_inam014_cs CURSOR FOR aint701_sel_inam014_pre          
           #FOREACH aint701_sel_inam014_cs USING sr1.inbn001 INTO g_inam014[i]
           #FOREACH aint701_sel_inam014_cs USING sr1.inbn001,sr1.inbmdocno INTO g_inam014[i]  #20161014   #161017-00051#9 Mark BY Ken 161116
           #161017-00051#9 Add BY Ken 161116(S)
           FOREACH aint701_sel_inam014_cs 
             USING sr1.inbn001,sr1.inbmdocno,sr1.l_pageno INTO g_inam014[i] 
           #161017-00051#9 Add BY Ken 161116(E)
              LET i = i + 1
           END FOREACH           
           LET l_inam0141 = g_inam014[1]
           LET l_inam0142 = g_inam014[2]
           LET l_inam0143 = g_inam014[3]
           LET l_inam0144 = g_inam014[4]
           LET l_inam0145 = g_inam014[5]
           LET l_inam0146 = g_inam014[6]
           #161017-00051#7 Add By Ken 161104(S)
           LET l_inam0147  = g_inam014[7]
           LET l_inam0148  = g_inam014[8]
           LET l_inam0149  = g_inam014[9]
           LET l_inam01410 = g_inam014[10]
           LET l_inam01411 = g_inam014[11]
           LET l_inam01412 = g_inam014[12]
           #161017-00051#7 Add By Ken 161104(E)
           PRINTX l_inam0141
           PRINTX l_inam0142
           PRINTX l_inam0143
           PRINTX l_inam0144
           PRINTX l_inam0145
           PRINTX l_inam0146 
           #161017-00051#7 Add By Ken 161104(S)
           PRINTX l_inam0147 
           PRINTX l_inam0148 
           PRINTX l_inam0149 
           PRINTX l_inam01410 
           PRINTX l_inam01411 
           PRINTX l_inam01412 
           #161017-00051#7 Add By Ken 161104(E)
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
           #161017-00051#9 Add BY Ken 161116(S)
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                sr1.inbment CLIPPED ,"'", " AND  ooff002 = '", sr1.inbmdocno CLIPPED ,"'" 
           #161017-00051#9 Add BY Ken 161116(E)
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
           PREPARE aint701_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aint701_g01_subrep01
           DECLARE aint701_g01_repcur01 CURSOR FROM g_sql
           FOREACH aint701_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aint701_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g01_subrep01
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
                sr1.inbment CLIPPED ,"'", " AND  ooff002 = '", sr1.inbmdocno CLIPPED ,"'"," AND  ooff003 = '", sr1.inbn001 CLIPPED ,"'" 
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
           PREPARE aint701_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aint701_g01_subrep02
           DECLARE aint701_g01_repcur02 CURSOR FROM g_sql
           FOREACH aint701_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aint701_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          LET l_inbo009_sum = 0
          #先判斷此筆資料是否有超過一頁(超過一頁的話，第一頁橫向加總空白，第二頁是整箱合計)
          EXECUTE aint701_page_cnt USING sr1.inbmdocno,sr1.inbn001 INTO l_cnt   #161017-00051#9 Add By Ken 161118
          IF (l_cnt = 1) THEN          
             IF cl_null(sr1.l_inbo0091) THEN LET sr1.l_inbo0091 = 0 END IF            
             IF cl_null(sr1.l_inbo0092) THEN LET sr1.l_inbo0092 = 0 END IF            
             IF cl_null(sr1.l_inbo0093) THEN LET sr1.l_inbo0093 = 0 END IF
             IF cl_null(sr1.l_inbo0094) THEN LET sr1.l_inbo0094 = 0 END IF            
             IF cl_null(sr1.l_inbo0095) THEN LET sr1.l_inbo0095 = 0 END IF            
             IF cl_null(sr1.l_inbo0096) THEN LET sr1.l_inbo0096 = 0 END IF                               
             #161017-00051#7 Add By Ken 161104(S)
             IF cl_null(sr1.l_inbo0097)  THEN LET sr1.l_inbo0097  = 0 END IF
             IF cl_null(sr1.l_inbo0098)  THEN LET sr1.l_inbo0098  = 0 END IF
             IF cl_null(sr1.l_inbo0099)  THEN LET sr1.l_inbo0099  = 0 END IF
             IF cl_null(sr1.l_inbo00910) THEN LET sr1.l_inbo00910 = 0 END IF
             IF cl_null(sr1.l_inbo00911) THEN LET sr1.l_inbo00911 = 0 END IF
             IF cl_null(sr1.l_inbo00912) THEN LET sr1.l_inbo00912 = 0 END IF
             #161017-00051#7 Add By Ken 161104(E)
             #小計
             #161017-00051#7 Mark By Ken 161104(S)
             #LET l_inbo009_sum = sr1.l_inbo0091+sr1.l_inbo0092+sr1.l_inbo0093+sr1.l_inbo0094+sr1.l_inbo0095+
             #                    sr1.l_inbo0096
             #161017-00051#7 Mark By Ken 161104(E)
             #161017-00051#7 Add By Ken 161104(S)
             LET l_inbo009_sum = sr1.l_inbo0091+sr1.l_inbo0092+sr1.l_inbo0093+sr1.l_inbo0094+sr1.l_inbo0095+
                                 sr1.l_inbo0096+sr1.l_inbo0097+sr1.l_inbo0098+sr1.l_inbo0099+sr1.l_inbo00910+
                                 sr1.l_inbo00911+sr1.l_inbo00912
             #161017-00051#7 Add By Ken 161104(E) 
          ELSE       #同單號、箱號大於一頁(IF (l_cnt > 1) THEN)
          #161017-00051#9 Add By Ken 161118(S)          
             IF (l_cnt != sr1.l_pageno) THEN
                LET l_inbo009_sum = ''
             ELSE
                EXECUTE aint701_inbo009_sum USING sr1.inbmdocno,sr1.inbn001,sr1.l_inbo006,sr1.l_inam012 INTO l_inbo009_sum            
             END IF
          END IF
          #161017-00051#9 Add By Ken 161118(E)
          PRINTX l_inbo009_sum
          
          #纵向小计
          IF cl_null(l_sum.sum01) THEN LET  l_sum.sum01= 0 END IF            
          IF cl_null(l_sum.sum02) THEN LET  l_sum.sum02= 0 END IF            
          IF cl_null(l_sum.sum03) THEN LET  l_sum.sum03= 0 END IF           
          IF cl_null(l_sum.sum04) THEN LET  l_sum.sum04= 0 END IF            
          IF cl_null(l_sum.sum05) THEN LET  l_sum.sum05= 0 END IF            
          IF cl_null(l_sum.sum06) THEN LET  l_sum.sum06= 0 END IF          
          #161017-00051#7 Add By Ken 161104(S)
          IF cl_null(l_sum.sum07) THEN LET  l_sum.sum07= 0 END IF
          IF cl_null(l_sum.sum08) THEN LET  l_sum.sum08= 0 END IF
          IF cl_null(l_sum.sum09) THEN LET  l_sum.sum09= 0 END IF
          IF cl_null(l_sum.sum10) THEN LET  l_sum.sum10= 0 END IF
          IF cl_null(l_sum.sum11) THEN LET  l_sum.sum11= 0 END IF
          IF cl_null(l_sum.sum12) THEN LET  l_sum.sum12= 0 END IF
          #161017-00051#7 Add By Ken 161104(E)
          LET l_sum.sum01=l_sum.sum01+ sr1.l_inbo0091 
          LET l_sum.sum02=l_sum.sum02+ sr1.l_inbo0092 
          LET l_sum.sum03=l_sum.sum03+ sr1.l_inbo0093 
          LET l_sum.sum04=l_sum.sum04+ sr1.l_inbo0094 
          LET l_sum.sum05=l_sum.sum05+ sr1.l_inbo0095 
          LET l_sum.sum06=l_sum.sum06+ sr1.l_inbo0096           
          #161017-00051#7 Add By Ken 161104(S)
          LET l_sum.sum07=l_sum.sum07+ sr1.l_inbo0097
          LET l_sum.sum08=l_sum.sum08+ sr1.l_inbo0098
          LET l_sum.sum09=l_sum.sum09+ sr1.l_inbo0099
          LET l_sum.sum10=l_sum.sum10+ sr1.l_inbo00910
          LET l_sum.sum11=l_sum.sum11+ sr1.l_inbo00911
          LET l_sum.sum12=l_sum.sum12+ sr1.l_inbo00912
          #161017-00051#7 Add By Ken 161104(E)
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           #161017-00051#9 Add BY Ken 161116(S)
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff002 = '", 
                sr1.inbment CLIPPED ,"'", " AND  ooff002 = '", sr1.inbmdocno CLIPPED ,"'"," AND  ooff003 = '", sr1.inbn001 CLIPPED ,"'" 
           #161017-00051#9 Add BY Ken 161116(E)
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
#                sr1.inbment CLIPPED ,"'"
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aint701_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aint701_g01_subrep03
           DECLARE aint701_g01_repcur03 CURSOR FROM g_sql
           FOREACH aint701_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aint701_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           #總計(合計)   
           #161017-00051#9 Mark By ken 161117(S)
           #LET l_sub_sql = " SELECT SUM(qty) FROM aint701_tmp1 ",
           #            " WHERE docno=? and inbn001=? "
           #161017-00051#9 Mark By ken 161117(E)
           #161017-00051#9 Add By ken 161117(S)
           #先判斷此筆資料是否有超過一頁(超過一頁的話，第一頁橫向加總空白，第二頁是整箱合計)
           EXECUTE aint701_page_cnt USING sr1.inbmdocno,sr1.inbn001 INTO l_cnt   #161017-00051#9 Add By Ken 161118           
           
           LET l_sub_sql = " SELECT SUM(COALESCE(l_inbo0091,0) ",
                           "          + COALESCE(l_inbo0092,0) ",
                           "          + COALESCE(l_inbo0093,0) ",
                           "          + COALESCE(l_inbo0094,0) ",
                           "          + COALESCE(l_inbo0095,0) ",
                           "          + COALESCE(l_inbo0096,0) ",
                           "          + COALESCE(l_inbo0097,0) ",
                           "          + COALESCE(l_inbo0098,0) ",
                           "          + COALESCE(l_inbo0099,0) ",
                           "          + COALESCE(l_inbo00910,0)",
                           "          + COALESCE(l_inbo00911,0)",
                           "          + COALESCE(l_inbo00912,0)) FROM aint701_print_tmp ",
                           " WHERE inbmdocno=? AND inbn001=?  "                      
           PREPARE inbo009_total FROM l_sub_sql                      
           EXECUTE inbo009_total INTO l_inbo009_total USING sr1.inbmdocno,sr1.inbn001
           IF (l_cnt > 1) THEN 
              IF (l_cnt != sr1.l_pageno) THEN
                 LET l_inbo009_total = ''  
              ELSE
                 IF cl_null(l_inbo009_total) THEN LET l_inbo009_total = 0 END IF
              END IF              
           ELSE
              IF cl_null(l_inbo009_total) THEN LET l_inbo009_total = 0 END IF
           END IF
           #161017-00051#9 Add By ken 161117(E)
           
           PRINTX l_inbo009_total 
           PRINTX l_sum.*        
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           #161017-00051#9 Add BY Ken 161116(S)
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
                sr1.inbment CLIPPED ,"'", " AND  ooff002 = '", sr1.inbmdocno CLIPPED ,"'"
           #161017-00051#9 Add BY Ken 161116(E)
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.inbment CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aint701_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aint701_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aint701_g01_subrep04
           DECLARE aint701_g01_repcur04 CURSOR FROM g_sql
           FOREACH aint701_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aint701_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aint701_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aint701_g01_subrep04
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
 
{<section id="aint701_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aint701_g01_subrep01(sr2)
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
PRIVATE REPORT aint701_g01_subrep02(sr2)
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
PRIVATE REPORT aint701_g01_subrep03(sr2)
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
PRIVATE REPORT aint701_g01_subrep04(sr2)
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
 
{<section id="aint701_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL aint701_g01_create_tmp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/9/9 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g01_create_tmp_table()
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
                   inbm001    LIKE inbm_t.inbm001, 
                   inbm005    LIKE inbm_t.inbm005, 
                   inbm006    LIKE inbm_t.inbm006, 
                   inbm007    LIKE inbm_t.inbm007, 
                   inbmdocdt  LIKE inbm_t.inbmdocdt, 
                   inbment    LIKE inbm_t.inbment, 
                   inbmsite   LIKE inbm_t.inbmsite, 
                   inbmstus   LIKE inbm_t.inbmstus, 
                   inbmunit   LIKE inbm_t.inbmunit, 
                   inbn001    LIKE inbn_t.inbn001,
                   ooag_t_ooag011 LIKE ooag_t.ooag011, 
                   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003,                   
                   docno      LIKE inbm_t.inbmdocno,          #單號  
                   item       LIKE type_t.chr100,             #料件编号
                   imaal003   LIKE imaal_t.imaal003,          #品名
                   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
                   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
                   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
                   unit       LIKE inbo_t.inbo008,            #單位                  
                   qty        LIKE inbo_t.inbo009,            #數量 
                   condition  LIKE type_t.chr1000             #分组条件                   
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
# Descriptions...: 寫入暫存表
# Memo...........:
# Usage..........: CALL aint701_g01_ins_tmp_table(p_wc)
# Input parameter: p_wc           查詢條件
# Return code....: 
# Date & Author..: 2016/9/9 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g01_ins_tmp_table(p_wc)
DEFINE p_wc             STRING
DEFINE l_sql            STRING
DEFINE l_inbment        LIKE inbm_t.inbment
DEFINE l_inbmsite       LIKE inbm_t.inbmsite     
DEFINE l_inbmunit       LIKE inbm_t.inbmunit     #配送中心
DEFINE l_inbmdocno      LIKE inbm_t.inbmdocno    #裝箱單號
DEFINE l_inbmdocdt      LIKE inbm_t.inbmdocdt    #單據日期
DEFINE l_inbm001        LIKE inbm_t.inbm001      #需求對象
DEFINE l_inbm001_desc   LIKE ooefl_t.ooefl003    #需求對象名稱
DEFINE l_inbm005        LIKE inbm_t.inbm005      #裝箱人員
DEFINE l_inbm005_desc   LIKE ooag_t.ooag011      #裝箱人員名稱
DEFINE l_inbm006        LIKE inbm_t.inbm006      #裝箱部門
DEFINE l_inbm007        LIKE inbm_t.inbm007      #備註
DEFINE l_inbmstus       LIKE inbm_t.inbmstus     #狀態碼
DEFINE l_inbn001        LIKE inbn_t.inbn001      #箱號
DEFINE l_inbo006        LIKE inbo_t.inbo006      #商品編號
DEFINE l_imaal003       LIKE imaal_t.imaal003    #品名
DEFINE l_inbo007        LIKE inbo_t.inbo007      #產品特徵
DEFINE l_inbo008        LIKE inbo_t.inbo008      #單位
DEFINE l_inbo009        LIKE inbo_t.inbo009      #裝箱數量
DEFINE l_condition      LIKE type_t.chr1000      
DEFINE l_imaa005        LIKE imaa_t.imaa005
DEFINE l_inam012        LIKE inam_t.inam012
DEFINE l_inam014        LIKE inam_t.inam014
DEFINE l_inam018        LIKE inam_t.inam018
DEFINE l_imec003        LIKE imec_t.imec003
DEFINE l_imecl005       LIKE imecl_t.imecl005
DEFINE l_imeb012        LIKE imeb_t.imeb012
DEFINE l_cnt2           LIKE type_t.num5
DEFINE l_docno_tmp      LIKE inbm_t.inbmdocno
DEFINE l_inbn001_tmp    LIKE inbn_t.inbn001
DEFINE l_sub_sql        STRING
DEFINE l_inam014_cnt    LIKE type_t.num10
DEFINE l_pageno         LIKE type_t.num10
DEFINE l_pagecnt        LIKE type_t.num10      #161017-00051#9 Add By Ken 161109 單號、箱號的第幾頁
DEFINE l_ii             LIKE type_t.num10 
DEFINE l_print_show     LIKE type_t.chr1
DEFINE l_item           LIKE type_t.chr1000
DEFINE l_qty_sum        LIKE pmdn_t.pmdn007
DEFINE l_i              INTEGER
DEFINE tok              base.StringTokenizer

   #把資料整理成明細
   #161024-00023#6 Mark BY Ken 161028(S)
   #LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno,inbmdocdt, ",
   #            "        inbm001,ooefl003,inbm005, ooag011,  inbm006,   ",
   #            "        inbm007,inbmstus,inbn001, inbo006,  imaal003,",
   #            "        inbo007,inbo008, inbo009 ",
   #            "   FROM inbm_t ",
   #            "   LEFT JOIN inbn_t ON inbment = inbnent AND inbmdocno = inbndocno ",
   #            "   LEFT JOIN inbo_t ON inbnent = inboent AND inbndocno = inbodocno AND inbn001=inbo001 ",
   #            "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
   #            "   LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"'",
   #            "   LEFT JOIN ooefl_t ON inbment = ooeflent AND inbm001 = ooefl001 AND ooefl002 = '",g_dlang,"'", 
   #            "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ",           
   #            "  WHERE inbment = ",g_enterprise," AND " ,p_wc CLIPPED 
   #161024-00023#6 Mark BY Ken 161028(E)            
   #161024-00023#6 Add BY Ken 161028(S)
   LET l_sql = " SELECT inbment,inbmsite,inbmunit,inbmdocno,inbmdocdt, ",
               "        inbm001, ",
               "        CASE WHEN inbm008='1' THEN (SELECT ooefl003 FROM ooefl_t ",
               "                                     WHERE inbment=ooeflent AND inbm001=ooefl001 AND ooefl002= '",g_dlang,"')",  
               "                              ELSE (SELECT pmaal003 FROM pmaal_t ",
               "                                     WHERE inbment=pmaalent AND inbm001=pmaal001 AND pmaal002= '",g_dlang,"') END ooefl003,",
               "        inbm005, ooag011,  inbm006,   ",
               "        inbm007,inbmstus,inbn001, inbo006,  imaal003,",
               "        inbo007,inbo008, inbo009 ",
               "   FROM inbm_t ",
               "   LEFT JOIN inbn_t ON inbment = inbnent AND inbmdocno = inbndocno ",
               "   LEFT JOIN inbo_t ON inbnent = inboent AND inbndocno = inbodocno AND inbn001=inbo001 ",
               "   LEFT JOIN imaa_t ON imaaent = inboent AND imaa001 = inbo006 ",
               "   LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"'",
               "   LEFT JOIN ooag_t  ON inbment = ooagent  AND inbm005 = ooag001 ",           
               "  WHERE inbment = ",g_enterprise," AND " ,p_wc CLIPPED                
   #161024-00023#6 Add BY Ken 161028(E)              
   PREPARE aint701_sel_inbm_pre FROM l_sql
   DECLARE aint701_sel_inbm_cur CURSOR FOR aint701_sel_inbm_pre
   FOREACH aint701_sel_inbm_cur INTO l_inbment,l_inbmsite,    l_inbmunit,l_inbmdocno,   l_inbmdocdt,
                                     l_inbm001,l_inbm001_desc,l_inbm005, l_inbm005_desc,l_inbm006, 
                                     l_inbm007,l_inbmstus,    l_inbn001, l_inbo006,     l_imaal003,
                                     l_inbo007,l_inbo008,     l_inbo009
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
                LET l_inam012 = l_imec003,'·',l_imecl005  #161220-00009#1 Add By Ken 161227
                #LET l_inam012 = l_imecl005               #161220-00009#1 Mark By Ken 161227
              ELSE
                 LET l_inam012 = l_inam012,'/',l_imec003,'·',l_imecl005 #161220-00009#1 Add By Ken 161227 
                 #LET l_inam012 = l_inam012,'/',l_imecl005              #161220-00009#1 Mark By Ken 161227
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
            EXECUTE aint701_ins_tmp1 USING l_inbm001,     l_inbm005,     l_inbm006,  l_inbm007, l_inbmdocdt,
                                           l_inbment,     l_inbmsite,    l_inbmstus, l_inbmunit,l_inbn001,
                                           l_inbm005_desc,l_inbm001_desc,l_inbmdocno,l_inbo006, l_imaal003,    
                                           l_inam012,     l_inam014,     l_inam018,  l_inbo008, l_inbo009,
                                           l_condition 
          END IF 
        END IF 
   END FOREACH

   CALL aint701_g01_create_print_tmp()
   #把明細資料整理成二維資料
   LET l_sql = "SELECT UNIQUE docno,inbn001 ",
               "  FROM aint701_tmp1 ORDER BY docno,inbn001 "
   PREPARE aint701_sel_tmp1 FROM l_sql
   DECLARE aint701_sel_tmp1_cur CURSOR FOR aint701_sel_tmp1
   FOREACH aint701_sel_tmp1_cur INTO l_docno_tmp,l_inbn001_tmp  
      
      LET l_sub_sql = " SELECT DISTINCT inam014 FROM aint701_tmp1 ",
                  " WHERE docno=? and inbn001=? ",
                  " ORDER BY inam014"
      PREPARE inam014_ins FROM l_sub_sql
      DECLARE inam014_ins_cs CURSOR FOR inam014_ins
      
      #計算橫軸個數
      LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
      PREPARE inam014_cnt_pre FROM l_sql            
      
      EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING l_docno_tmp,l_inbn001_tmp
      FREE inam014_cnt_pre
         
      ##總計(合計)   
      #LET l_sub_sql = " SELECT SUM(inbo009) FROM aint701_tmp1 ",
      #            " WHERE docno=? and inbn001=? "
      #PREPARE inbo009_total FROM l_sub_sql
          
      IF NOT cl_null(l_inam014_cnt) THEN
         #LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆
         LET l_pageno = (l_inam014_cnt -1)/12   #每頁12筆
         LET l_pageno = l_pageno +1
         LET l_pagecnt = 1     #161017-00051#9 Add By Ken 161109  第幾頁
         #DELETE FROM inam014_tmp WHERE 1=1
         OPEN inam014_ins_cs USING l_docno_tmp,l_inbn001_tmp
         LET l_i=1
         FOREACH inam014_ins_cs INTO l_inam014
            #INSERT INTO inam014_tmp VALUES(l_i,l_inbn001_tmp,l_inam014)
            #INSERT INTO inam014_tmp VALUES(l_i,l_docno_tmp,l_inbn001_tmp,l_inam014)  #20161014
            #161017-00051#9 Add By Ken 161109(S)
            INSERT INTO inam014_tmp VALUES(l_i,l_docno_tmp,l_inbn001_tmp,l_pagecnt,l_inam014)  
            IF l_i MOD 12 = 0 THEN            
               LET l_i = 0
               LET l_pagecnt = l_pagecnt + 1
            END IF
            #161017-00051#9 Add By Ken 161109(E)
            LET l_i=l_i+1
         END FOREACH
      
         FOR l_i = 1 to l_pageno
            CALL aint701_g01_inbo_tmp(l_docno_tmp,l_inbn001_tmp,l_i)
         END FOR  
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 建立列印用暫存表
# Memo...........:
# Usage..........: CALL aint701_g01_create_print_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g01_create_print_tmp()
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
                     inbm001 LIKE inbm_t.inbm001, 
                     inbm005 LIKE inbm_t.inbm005, 
                     inbm006 LIKE inbm_t.inbm006, 
                     inbm007 LIKE inbm_t.inbm007, 
                     inbmdocdt LIKE inbm_t.inbmdocdt, 
                     inbmdocno LIKE inbm_t.inbmdocno, 
                     inbment LIKE inbm_t.inbment, 
                     inbmsite LIKE inbm_t.inbmsite, 
                     inbmstus LIKE inbm_t.inbmstus, 
                     inbmunit LIKE inbm_t.inbmunit, 
                     inbn001 LIKE inbn_t.inbn001, 
                     page_no   LIKE type_t.num5,  #161017-00051#9 Add By Ken 161109
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
                     #161017-00051#7 Add By Ken 161104(S)
                     l_inbo0098 LIKE inbo_t.inbo009, 
                     l_inbo0099 LIKE inbo_t.inbo009, 
                     l_inbo00910 LIKE inbo_t.inbo009, 
                     l_inbo00911 LIKE inbo_t.inbo009, 
                     l_inbo00912 LIKE inbo_t.inbo009, 
                     #161017-00051#7 Add By Ken 161104(E) 
                     inbnunit LIKE inbn_t.inbnunit, 
                     ooag_t_ooag011 LIKE ooag_t.ooag011, 
                     ooefl_t_ooefl003 LIKE ooefl_t.ooefl003
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
    inbndocno  LIKE inbn_t.inbndocno, #20161014
    inbn001    LIKE inbn_t.inbn001,
    page_no    LIKE type_t.num5,      #161017-00051#9 Add By Ken 161109
    inam014    LIKE inam_t.inam014
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
# Usage..........: CALL aint701_g01_inbo_tmp(p_inbmdocno,p_inbn001,p_i)
#                  RETURNING 回传参数
# Input parameter: p_inbmdocno    裝箱單號
#                : p_indn001      箱號
#                : p_i            第幾頁
# Return code....: 
# Date & Author..: 2016/09/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_g01_inbo_tmp(p_inbmdocno,p_inbn001,p_i)
DEFINE p_inbmdocno  LIKE inbm_t.inbmdocno
DEFINE p_inbn001    LIKE inbn_t.inbn001
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

   CALL g_inam014.clear()

   SELECT COUNT(DISTINCT inam014) INTO l_n 
     FROM aint701_tmp1
    WHERE docno=p_inbmdocno 
      AND inbn001 = p_inbn001
   #LET l_i = (l_n-1)/10
   LET l_i = (l_n-1)/12
   LET l_i = l_i +1
   IF l_i = p_i THEN
      LET l_max = l_n
   ELSE
      #LET l_max = p_i*10
      LET l_max = p_i*12
   END IF

   #IF l_max mod 10 = 0 THEN 
   #   LET l_max2 = 10
   #ELSE
   #   LET l_max2 = l_max mod 10
   #END IF
   
   IF l_max mod 12 = 0 THEN 
      LET l_max2 = 12
   ELSE
      LET l_max2 = l_max mod 12
   END IF   

   #LET l_a = p_i*10-9
   #LET l_b = p_i*10
   #LET l_a = p_i*12-11
   #LET l_b = p_i*12  
   LET l_a = 12-11
   LET l_b = 12     
   LET l_sql = " SELECT inam014 FROM inam014_tmp",
               " WHERE i >=? AND i<=? AND inbndocno = '",p_inbmdocno,"' AND inbn001 = '",p_inbn001,"'",
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
   
   LET l_sql = " INSERT INTO aint701_print_tmp(inbm001 ,   inbm005   , inbm006    , inbm007        , inbmdocdt , ",
               "                               inbmdocno , inbment   , inbmsite   , inbmstus       , inbmunit , ",
               "                               inbn001 ,   l_inbo006 , l_imaal003 , l_inam012      , l_inam014 , ",
               "                               l_inam018 , l_inbo008 , inbnunit   , ooag_t_ooag011 , ooefl_t_ooefl003, ",
               "                               page_no "     #161017-00051#9 Add By ken 161109 第幾頁的特徵
   FOR i=1 to l_max2
      CASE i WHEN 1 LET l_inbo009 = 'l_inbo0091'
             WHEN 2 LET l_inbo009 = 'l_inbo0092'
             WHEN 3 LET l_inbo009 = 'l_inbo0093'
             WHEN 4 LET l_inbo009 = 'l_inbo0094'
             WHEN 5 LET l_inbo009 = 'l_inbo0095'
             WHEN 6 LET l_inbo009 = 'l_inbo0096'
             WHEN 7 LET l_inbo009 = 'l_inbo0097'
             #161017-00051#7 Add By Ken 161104(S)
             WHEN 8  LET l_inbo009 = 'l_inbo0098'
             WHEN 9  LET l_inbo009 = 'l_inbo0099'
             WHEN 10 LET l_inbo009 = 'l_inbo00910'
             WHEN 11 LET l_inbo009 = 'l_inbo00911'
             WHEN 12 LET l_inbo009 = 'l_inbo00912'
             #161017-00051#7 Add By Ken 161104(E)
      END CASE
      LET l_sql = l_sql , ",",l_inbo009
   END FOR
   
   LET l_sql = l_sql," ) SELECT inbm001,   inbm005, inbm006, inbm007, inbmdocdt , ",
                     "          docno,     inbment, inbmsite,inbmstus,inbmunit,   ",
                     "          inbn001,   item,    imaal003,inam012, inam014,    ",
                     "          inam018,   unit,    inbmunit,ooag_t_ooag011 , ooefl_t_ooefl003, ",
                     "          ",p_i, " "   #161017-00051#9 Add By ken 161109 第幾頁的特徵                     
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,")"
   END FOR
   LET l_sql = l_sql,"  FROM ( SELECT inbm001 ,   inbm005   , inbm006    , inbm007        , inbmdocdt , ",
                     "                docno,      inbment   , inbmsite   , inbmstus       , inbmunit , ",
                     "                inbn001 ,   item,       imaal003   , inam012        , inam014 , ",
                     "                inam018 ,   unit,       ooag_t_ooag011 , ooefl_t_ooefl003 "
 
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        " THEN qty ELSE 0 END A",l_vi
   END FOR
   LET l_sql = l_sql,  "  FROM aint701_tmp1 ",
               " WHERE docno='",p_inbmdocno,"'",
               "   AND inbn001 = '",p_inbn001,"'",
               "   ) "
               ," GROUP BY inbm001 ,   inbm005   , inbm006    , inbm007        , inbmdocdt , ",
               "           docno,      inbment   , inbmsite   , inbmstus       , inbmunit , ",
               "           inbn001 ,   item,       imaal003 , inam012      ,   inam014 , ",
               "           inam018 ,   unit,       ooag_t_ooag011 , ooefl_t_ooefl003 "
                              
   PREPARE inbm_print_pr FROM l_sql
   
   #DELETE FROM sfec_print WHERE 1=1
   EXECUTE inbm_print_pr
   
  #UPDATE csfr341_g01_temp 
  #    SET l_skip = "Y"
  #    WHERE sfeadocno = p_sfeadocno AND imaal003 = p_imaal003 AND inam014 = g_inam014[l_max2] 
   
END FUNCTION

 
{</section>}
 
{<section id="aint701_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
