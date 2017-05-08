#該程式未解開Section, 採用最新樣板產出!
{<section id="aglr310_g02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2017-01-22 10:41:03), PR版次:0007(2017-01-22 10:58:20)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000136
#+ Filename...: aglr310_g02
#+ Description: ...
#+ Creator....: 05416(2014-07-29 16:47:49)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglr310_g02.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160510-00022#1  2016/05/27 By 02599    凭证里为0的金额，不需要打印出来
#170117-00005#1  2017/01/20 By 02599    顯示已啟用的固定核算項和自由核算項，參照aglr310_g03中的格式
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
   glap012 LIKE glap_t.glap012, 
   glap014 LIKE glap_t.glap014, 
   glap015 LIKE glap_t.glap015, 
   glaq007 LIKE glaq_t.glaq007, 
   glaq009 LIKE glaq_t.glaq009, 
   glaq021 LIKE glaq_t.glaq021, 
   glapdocno LIKE glap_t.glapdocno, 
   glapld LIKE glap_t.glapld, 
   glap004 LIKE glap_t.glap004, 
   glap006 LIKE glap_t.glap006, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq013 LIKE glaq_t.glaq013, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq025 LIKE glaq_t.glaq025, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glaq011 LIKE glaq_t.glaq011, 
   glaq012 LIKE glaq_t.glaq012, 
   glaq015 LIKE glaq_t.glaq015, 
   glaq016 LIKE glaq_t.glaq016, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq044 LIKE glaq_t.glaq044, 
   glap007 LIKE glap_t.glap007, 
   glap013 LIKE glap_t.glap013, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq014 LIKE glaq_t.glaq014, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq040 LIKE glaq_t.glaq040, 
   glap009 LIKE glap_t.glap009, 
   glaq039 LIKE glaq_t.glaq039, 
   glaq042 LIKE glaq_t.glaq042, 
   glapcomp LIKE glap_t.glapcomp, 
   glapstus LIKE glap_t.glapstus, 
   glaq010 LIKE glaq_t.glaq010, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq043 LIKE glaq_t.glaq043, 
   glaqseq LIKE glaq_t.glaqseq, 
   glap001 LIKE glap_t.glap001, 
   glap002 LIKE glap_t.glap002, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq028 LIKE glaq_t.glaq028, 
   glap008 LIKE glap_t.glap008, 
   glap010 LIKE glap_t.glap010, 
   glap011 LIKE glap_t.glap011, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq002 LIKE glaq_t.glaq002, 
   glaq008 LIKE glaq_t.glaq008, 
   glaq041 LIKE glaq_t.glaq041, 
   glaqcomp LIKE glaq_t.glaqcomp, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   glaal_t_glaal002 LIKE glaal_t.glaal002, 
   l_glapcomp_ooefl003 LIKE type_t.chr1000, 
   glapcnfid LIKE glap_t.glapcnfid, 
   glappstid LIKE glap_t.glappstid, 
   glapcrtid LIKE glap_t.glapcrtid, 
   glapent LIKE glap_t.glapent, 
   glaq002_1 LIKE type_t.chr500, 
   glacl004 LIKE glacl_t.glacl004, 
   l_glaq017_1 LIKE type_t.chr1000, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq029 LIKE glaq_t.glaq029, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq038 LIKE glaq_t.glaq038
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
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
{</section>}
 
{<section id="aglr310_g02.main" readonly="Y" >}
PUBLIC FUNCTION aglr310_g02(p_arg1)
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
   
   LET g_rep_code = "aglr310_g02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aglr310_g02_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aglr310_g02_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aglr310_g02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglr310_g02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglr310_g02_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
 
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #170117-00005#1--mod--str--
#   LET g_select = " SELECT glap012,glap014,glap015,glaq007,glaq009,glaq021,glapdocno,glapld, 
#       glap004,glap006,glaq006,glaq004,glaq013,glaq018,glaq025,glapdocdt,glaq011,glaq012,glaq015,glaq016, 
#       glaq027,glaq044,glap007,glap013,glaq003,glaq014,glaq017,glaq020,glaq022,glaq040,glap009,glaq039, 
#       glaq042,glapcomp,glapstus,glaq010,glaq024,glaq043,glaqseq,glap001,glap002,glaq001,glaq019,glaq023,
#       glaq028,glap008,glap010,glap011,glaq005,glaq002,glaq008,glaq041,glaqcomp,ooefl_t.ooefl003,glaal_t.glaal002, 
#       trim(glapcomp)||'.'||trim(ooefl_t.ooefl003),glapcnfid,glappstid,glapcrtid,glapent,'','',glaq051,glaq052 
#      "
   LET g_select = " SELECT glap012,glap014,glap015,glaq007,glaq009,",
                  "        glaq021,glapdocno,glapld,glap004,glap006,",
                  "        glaq006,glaq004,glaq013,glaq018,glaq025,",
                  "        glapdocdt,glaq011,glaq012,glaq015,glaq016,", 
                  "        glaq027,glaq044,glap007,glap013,glaq003,",
                  "        glaq014,glaq017,glaq020,glaq022,glaq040,",
                  "        glap009,glaq039,glaq042,glapcomp,glapstus,",
                  "        glaq010,glaq024,glaq043,glaqseq,glap001,",
                  "        glap002,glaq001,glaq019,glaq023,glaq028,",
                  "        glap008,glap010,glap011,glaq005,glaq002,",
                  "        glaq008,glaq041,glaqcomp,ooefl_t.ooefl003,glaal_t.glaal002,", 
                  "        trim(glapcomp)||'.'||trim(ooefl_t.ooefl003),glapcnfid,glappstid,glapcrtid,",
                  "        glapent,'',glacl_t.glacl004,'',glaq051,glaq052,glaq053,", 
                  "        glaq029,glaq030,glaq031,glaq032,glaq033",
                  "        glaq034,glaq035,glaq036,glaq037,glaq038 "
   #170117-00005#1--mod--end
#   #end add-point
#   LET g_select = " SELECT glap012,glap014,glap015,glaq007,glaq009,glaq021,glapdocno,glapld,glap004, 
#       glap006,glaq006,glaq004,glaq013,glaq018,glaq025,glapdocdt,glaq011,glaq012,glaq015,glaq016,glaq027, 
#       glaq044,glap007,glap013,glaq003,glaq014,glaq017,glaq020,glaq022,glaq040,glap009,glaq039,glaq042, 
#       glapcomp,glapstus,glaq010,glaq024,glaq043,glaqseq,glap001,glap002,glaq001,glaq019,glaq023,glaq028, 
#       glap008,glap010,glap011,glaq005,glaq002,glaq008,glaq041,glaqcomp,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = glap_t.glapent AND ooefl_t.ooefl001 = glap_t.glapcomp AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,"),( SELECT glaal002 FROM glaal_t WHERE glaal_t.glaalent = glap_t.glapent AND glaal_t.glaalld = glap_t.glapld AND glaal_t.glaal001 = '" , 
#       g_dlang,"'" ,"),trim(glapcomp)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooeflent = glap_t.glapent AND ooefl_t.ooefl001 = glap_t.glapcomp AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),glapcnfid,glappstid,glapcrtid,glapent,NULL,NULL,NULL,glaq051,glaq052,glaq053, 
#       glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM glap_t LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = glap_t.glapent AND ooefl_t.ooefl001 = glap_t.glapcomp AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN glaal_t ON glaal_t.glaalent = glap_t.glapent AND glaal_t.glaalld = glap_t.glapld AND glaal_t.glaal001 = '" , 
        g_dlang,"'" ,"             LEFT OUTER JOIN glacl_t ON glacl_t.glaclent = glap_t.glapent AND glacl_t.glacl001 = glap_t.glap016 AND glacl_t.glacl002=glap_t.glap006 AND glacl_t.glacl003= '" , 
        g_dlang,"'" ," LEFT OUTER JOIN ( SELECT glaq_t.* FROM glaq_t  ) x  ON glap_t.glapent = x.glaqent  
        AND glap_t.glapld = x.glaqld AND glap_t.glapdocno = x.glaqdocno"
#   #end add-point
#    LET g_from = " FROM glap_t LEFT OUTER JOIN ( SELECT glaq_t.* FROM glaq_t  ) x  ON glap_t.glapent  
#        = x.glaqent AND glap_t.glapld = x.glaqld AND glap_t.glapdocno = x.glaqdocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE " ,tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE glap_t.glapstus = 'Y' AND " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE " ,tm.wc CLIPPED
   #end add-point
    LET g_order = " ORDER BY glapdocno,glaqseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glap_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aglr310_g02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aglr310_g02_curs CURSOR FOR aglr310_g02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglr310_g02.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglr310_g02_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   glap012 LIKE glap_t.glap012, 
   glap014 LIKE glap_t.glap014, 
   glap015 LIKE glap_t.glap015, 
   glaq007 LIKE glaq_t.glaq007, 
   glaq009 LIKE glaq_t.glaq009, 
   glaq021 LIKE glaq_t.glaq021, 
   glapdocno LIKE glap_t.glapdocno, 
   glapld LIKE glap_t.glapld, 
   glap004 LIKE glap_t.glap004, 
   glap006 LIKE glap_t.glap006, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq013 LIKE glaq_t.glaq013, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq025 LIKE glaq_t.glaq025, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glaq011 LIKE glaq_t.glaq011, 
   glaq012 LIKE glaq_t.glaq012, 
   glaq015 LIKE glaq_t.glaq015, 
   glaq016 LIKE glaq_t.glaq016, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq044 LIKE glaq_t.glaq044, 
   glap007 LIKE glap_t.glap007, 
   glap013 LIKE glap_t.glap013, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq014 LIKE glaq_t.glaq014, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq040 LIKE glaq_t.glaq040, 
   glap009 LIKE glap_t.glap009, 
   glaq039 LIKE glaq_t.glaq039, 
   glaq042 LIKE glaq_t.glaq042, 
   glapcomp LIKE glap_t.glapcomp, 
   glapstus LIKE glap_t.glapstus, 
   glaq010 LIKE glaq_t.glaq010, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq043 LIKE glaq_t.glaq043, 
   glaqseq LIKE glaq_t.glaqseq, 
   glap001 LIKE glap_t.glap001, 
   glap002 LIKE glap_t.glap002, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq028 LIKE glaq_t.glaq028, 
   glap008 LIKE glap_t.glap008, 
   glap010 LIKE glap_t.glap010, 
   glap011 LIKE glap_t.glap011, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq002 LIKE glaq_t.glaq002, 
   glaq008 LIKE glaq_t.glaq008, 
   glaq041 LIKE glaq_t.glaq041, 
   glaqcomp LIKE glaq_t.glaqcomp, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   glaal_t_glaal002 LIKE glaal_t.glaal002, 
   l_glapcomp_ooefl003 LIKE type_t.chr1000, 
   glapcnfid LIKE glap_t.glapcnfid, 
   glappstid LIKE glap_t.glappstid, 
   glapcrtid LIKE glap_t.glapcrtid, 
   glapent LIKE glap_t.glapent, 
   glaq002_1 LIKE type_t.chr500, 
   glacl004 LIKE glacl_t.glacl004, 
   l_glaq017_1 LIKE type_t.chr1000, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq029 LIKE glaq_t.glaq029, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq038 LIKE glaq_t.glaq038
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_ooagcnfid     LIKE ooag_t.ooag011
   DEFINE l_ooagcstid     LIKE ooag_t.ooag011
   DEFINE l_ooagcrtid     LIKE ooag_t.ooag011
   DEFINE l_glaq002       STRING
   DEFINE l_str           STRING
   DEFINE l_glapdocno_o   LIKE glap_t.glapdocno
   DEFINE l_str2          STRING #170117-00005#1 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_glapdocno_o = ''  #2015/9/18 add
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aglr310_g02_curs INTO sr_s.*
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
       LET sr[l_cnt].glap012 = sr_s.glap012
       LET sr[l_cnt].glap014 = sr_s.glap014
       LET sr[l_cnt].glap015 = sr_s.glap015
       LET sr[l_cnt].glaq007 = sr_s.glaq007
       LET sr[l_cnt].glaq009 = sr_s.glaq009
       LET sr[l_cnt].glaq021 = sr_s.glaq021
       LET sr[l_cnt].glapdocno = sr_s.glapdocno
       LET sr[l_cnt].glapld = sr_s.glapld
       LET sr[l_cnt].glap004 = sr_s.glap004
       LET sr[l_cnt].glap006 = sr_s.glap006
       LET sr[l_cnt].glaq006 = sr_s.glaq006
       LET sr[l_cnt].glaq004 = sr_s.glaq004
       LET sr[l_cnt].glaq013 = sr_s.glaq013
       LET sr[l_cnt].glaq018 = sr_s.glaq018
       LET sr[l_cnt].glaq025 = sr_s.glaq025
       LET sr[l_cnt].glapdocdt = sr_s.glapdocdt
       LET sr[l_cnt].glaq011 = sr_s.glaq011
       LET sr[l_cnt].glaq012 = sr_s.glaq012
       LET sr[l_cnt].glaq015 = sr_s.glaq015
       LET sr[l_cnt].glaq016 = sr_s.glaq016
       LET sr[l_cnt].glaq027 = sr_s.glaq027
       LET sr[l_cnt].glaq044 = sr_s.glaq044
       LET sr[l_cnt].glap007 = sr_s.glap007
       LET sr[l_cnt].glap013 = sr_s.glap013
       LET sr[l_cnt].glaq003 = sr_s.glaq003
       LET sr[l_cnt].glaq014 = sr_s.glaq014
       LET sr[l_cnt].glaq017 = sr_s.glaq017
       LET sr[l_cnt].glaq020 = sr_s.glaq020
       LET sr[l_cnt].glaq022 = sr_s.glaq022
       LET sr[l_cnt].glaq040 = sr_s.glaq040
       LET sr[l_cnt].glap009 = sr_s.glap009
       LET sr[l_cnt].glaq039 = sr_s.glaq039
       LET sr[l_cnt].glaq042 = sr_s.glaq042
       LET sr[l_cnt].glapcomp = sr_s.glapcomp
       LET sr[l_cnt].glapstus = sr_s.glapstus
       LET sr[l_cnt].glaq010 = sr_s.glaq010
       LET sr[l_cnt].glaq024 = sr_s.glaq024
       LET sr[l_cnt].glaq043 = sr_s.glaq043
       LET sr[l_cnt].glaqseq = sr_s.glaqseq
       LET sr[l_cnt].glap001 = sr_s.glap001
       LET sr[l_cnt].glap002 = sr_s.glap002
       LET sr[l_cnt].glaq001 = sr_s.glaq001
       LET sr[l_cnt].glaq019 = sr_s.glaq019
       LET sr[l_cnt].glaq023 = sr_s.glaq023
       LET sr[l_cnt].glaq028 = sr_s.glaq028
       LET sr[l_cnt].glap008 = sr_s.glap008
       LET sr[l_cnt].glap010 = sr_s.glap010
       LET sr[l_cnt].glap011 = sr_s.glap011
       LET sr[l_cnt].glaq005 = sr_s.glaq005
       LET sr[l_cnt].glaq002 = sr_s.glaq002
       LET sr[l_cnt].glaq008 = sr_s.glaq008
       LET sr[l_cnt].glaq041 = sr_s.glaq041
       LET sr[l_cnt].glaqcomp = sr_s.glaqcomp
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].glaal_t_glaal002 = sr_s.glaal_t_glaal002
       LET sr[l_cnt].l_glapcomp_ooefl003 = sr_s.l_glapcomp_ooefl003
       LET sr[l_cnt].glapcnfid = sr_s.glapcnfid
       LET sr[l_cnt].glappstid = sr_s.glappstid
       LET sr[l_cnt].glapcrtid = sr_s.glapcrtid
       LET sr[l_cnt].glapent = sr_s.glapent
       LET sr[l_cnt].glaq002_1 = sr_s.glaq002_1
       LET sr[l_cnt].glacl004 = sr_s.glacl004
       LET sr[l_cnt].l_glaq017_1 = sr_s.l_glaq017_1
       LET sr[l_cnt].glaq051 = sr_s.glaq051
       LET sr[l_cnt].glaq052 = sr_s.glaq052
       LET sr[l_cnt].glaq053 = sr_s.glaq053
       LET sr[l_cnt].glaq029 = sr_s.glaq029
       LET sr[l_cnt].glaq030 = sr_s.glaq030
       LET sr[l_cnt].glaq031 = sr_s.glaq031
       LET sr[l_cnt].glaq032 = sr_s.glaq032
       LET sr[l_cnt].glaq033 = sr_s.glaq033
       LET sr[l_cnt].glaq034 = sr_s.glaq034
       LET sr[l_cnt].glaq035 = sr_s.glaq035
       LET sr[l_cnt].glaq036 = sr_s.glaq036
       LET sr[l_cnt].glaq037 = sr_s.glaq037
       LET sr[l_cnt].glaq038 = sr_s.glaq038
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = sr_s.glapcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET l_ooagcnfid= g_rtn_fields[1]

            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = sr_s.glappstid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET l_ooagcstid= g_rtn_fields[1]

            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = sr_s.glapcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET l_ooagcrtid = g_rtn_fields[1]
       
       LET sr[l_cnt].glapcnfid = l_ooagcnfid 
       LET sr[l_cnt].glappstid = l_ooagcstid 
       LET sr[l_cnt].glapcrtid = l_ooagcrtid
       #科目名稱及核算項資料
#       CALL aglr310_g02_glaq002(l_cnt) RETURNING sr[l_cnt].glacl004,l_glaq002,l_str #170117-00005#1 mark
       CALL aglr310_g02_glaq002(l_cnt) RETURNING sr[l_cnt].glacl004,l_glaq002,l_str,l_str2 #170117-00005#1 add
       #第一行科目編號+核算項編號
       LET sr[l_cnt].glaq002_1 = sr[l_cnt].glaq002,l_str
#       LET sr[l_cnt].l_glaq017_1 = l_glaq002 #170117-00005#1 mark
       LET sr[l_cnt].l_glaq017_1 = l_str2 #170117-00005#1 add
       
       #2015/9/18--add--str--
       #更新凭证打印次数
       IF cl_null(l_glapdocno_o) THEN
          UPDATE glap_t SET glap012=glap012 + 1
           WHERE glapent=g_enterprise AND glapld=sr_s.glapld AND glapdocno=sr_s.glapdocno
          LET l_glapdocno_o = sr_s.glapdocno
       ELSE
          IF l_glapdocno_o <> sr_s.glapdocno THEN
             UPDATE glap_t SET glap012=glap012 + 1
              WHERE glapent=g_enterprise AND glapld=sr_s.glapld AND glapdocno=sr_s.glapdocno
             LET l_glapdocno_o = sr_s.glapdocno
          END IF
       END IF
       #2015/9/18--add--end
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglr310_g02.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglr310_g02_rep_data()
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
          START REPORT aglr310_g02_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aglr310_g02_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aglr310_g02_rep
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
 
{<section id="aglr310_g02.rep" readonly="Y" >}
PRIVATE REPORT aglr310_g02_rep(sr1)
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
DEFINE l_glaq005_show  LIKE type_t.chr1   #幣別
DEFINE l_glaq006_show  LIKE type_t.chr1   #匯率
DEFINE l_glaq010_show  LIKE type_t.chr1   #原幣金額
DEFINE glaq001_sum LIKE type_t.chr1   #合計

DEFINE l_glaq003_sum LIKE type_t.num20_6  #借方金額統計
DEFINE l_glaq004_sum LIKE type_t.num20_6  #貸方金額統計

DEFINE l_cmd             STRING               
DEFINE l_body_cnt        LIKE type_t.num5     
DEFINE l_body_tot        LIKE type_t.num5  
DEFINE l_display_line2   LIKE type_t.chr1
DEFINE l_display_line3   LIKE type_t.chr1
DEFINE l_display_line4   LIKE type_t.chr1
DEFINE l_display_sum     LIKE type_t.chr1
DEFINE l_lineno          LIKE type_t.num5
DEFINE l_pageno          STRING  
DEFINE l_pagecnt         LIKE type_t.num5  
DEFINE l_pagetot         LIKE type_t.num5 
DEFINE l_display_header  LIKE type_t.chr1
DEFINE l_display_line5   LIKE type_t.chr1
DEFINE l_yy              LIKE type_t.num5 
DEFINE l_mm              LIKE type_t.num5
DEFINE l_dd              LIKE type_t.num5
DEFINE l_sum_str         STRING
DEFINE l_skip            LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.glapdocno,sr1.glaqseq
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
        BEFORE GROUP OF sr1.glapdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            #2015/1/8--add--str--
            CASE sr1.glap001
               WHEN '1' #转帐凭证 aglt310
                  LET g_grPageHeader.title0201 = cl_getmsg("agl-00273",g_dlang)
               WHEN '2' #现收凭证 aglt320
                  LET g_grPageHeader.title0201 = cl_getmsg("agl-00300",g_dlang)
               WHEN '3' #现支凭证 aglt330
                  LET g_grPageHeader.title0201 = cl_getmsg("agl-00301",g_dlang)
               WHEN '4' #转回凭证 aglt340
                  LET g_grPageHeader.title0201 = cl_getmsg("agl-00302",g_dlang)
               WHEN '5' #应计凭证 aglt350
                  LET g_grPageHeader.title0201 = cl_getmsg("agl-00303",g_dlang)
               WHEN '6' #审计调整凭证 aglt410
                  LET g_grPageHeader.title0201 = cl_getmsg("agl-00304",g_dlang)
            END CASE
            #2015/1/8--add--end
            LET l_yy = YEAR(sr1.glapdocdt)
            LET l_mm = MONTH(sr1.glapdocdt)
            LET l_dd = DAY(sr1.glapdocdt)
            LET g_grPageHeader.title0202 = l_yy,cl_getmsg("agl-00274",g_dlang),l_mm,cl_getmsg("agl-00275",g_dlang),l_dd,cl_getmsg("agl-00276",g_dlang)
            #end add-point:rep.header 
            LET g_rep_docno = sr1.glapdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'glapent=' ,sr1.glapent,'{+}glapld=' ,sr1.glapld,'{+}glapdocno=' ,sr1.glapdocno         
            CALL cl_gr_init_apr(sr1.glapdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            LET l_lineno = 0
            
            #獲取單身總筆數
            LET l_cmd = " SELECT COUNT(*)  ",
                        "   FROM glap_t LEFT OUTER JOIN ( SELECT glaq_t.* FROM glaq_t  ) x  ON glap_t.glapent = x.glaqent ",  
                        "    AND glap_t.glapld = x.glaqld AND glap_t.glapdocno = x.glaqdocno ",
                        " WHERE " ,tm.wc CLIPPED," AND glapdocno = '",sr1.glapdocno,"'",
                        " ORDER BY glapdocno,glaqseq"
            PREPARE aglr310_g02_body_cnt_pr FROM l_cmd
            EXECUTE aglr310_g02_body_cnt_pr INTO l_body_cnt 
            LET l_body_tot = l_body_cnt + 1  #多加合計那一筆    
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.glapdocno.before name="rep.b_group.glapdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.glapent CLIPPED ,"'", " AND  ooff003 = '", sr1.glapdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr310_g02_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aglr310_g02_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aglr310_g02_subrep01
           DECLARE aglr310_g02_repcur01 CURSOR FROM g_sql
           FOREACH aglr310_g02_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr310_g02_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aglr310_g02_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aglr310_g02_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.glapdocno.after name="rep.b_group.glapdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.glaqseq
 
           #add-point:rep.b_group.glaqseq.before name="rep.b_group.glaqseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.glaqseq.after name="rep.b_group.glaqseq.after"
           
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
                sr1.glapent CLIPPED ,"'", " AND  ooff003 = '", sr1.glapdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.glaqseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr310_g02_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aglr310_g02_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aglr310_g02_subrep02
           DECLARE aglr310_g02_repcur02 CURSOR FROM g_sql
           FOREACH aglr310_g02_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr310_g02_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aglr310_g02_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aglr310_g02_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          LET l_lineno = l_lineno + 1
          PRINTX l_lineno
          
          #預設給每個空白行的顯示flag為N
          LET l_display_line2 = 'N' 
          LET l_display_line3 = 'N' 
          LET l_display_line4 = 'N' 
          LET l_display_line5 = 'N' 
          LET l_display_sum = 'N' 
          LET l_skip='N'
          IF l_lineno MOD 5=0 THEN
             LET l_skip='Y'
          END IF
          IF l_lineno = l_body_cnt THEN 
             CASE (l_body_tot MOD 5)
               WHEN 2 LET l_display_line2 = 'Y'
                      LET l_display_line3 = 'Y'
                      LET l_display_line4 = 'Y' 
               WHEN 3 LET l_display_line3 = 'Y'
                      LET l_display_line4 = 'Y'
               WHEN 4 LET l_display_line4 = 'Y'
               WHEN 1 LET l_display_line2 = 'Y'
                      LET l_display_line3 = 'Y'
                      LET l_display_line4 = 'Y'
                      LET l_display_line5 = 'Y'
             END CASE
#             IF l_body_cnt MOD 5=0 THEN
#                LET l_skip='Y'
#             END IF
             LET l_display_sum = 'Y'             
          END IF
          
          PRINTX l_display_line2
          PRINTX l_display_line3
          PRINTX l_display_line4
          PRINTX l_display_line5 
          PRINTX l_display_header
          PRINTX l_display_sum
          PRINTX l_skip
          #頁碼
          LET l_pagecnt = (l_lineno / 5) + 1 #目前頁次
          IF (l_body_cnt MOD 5) > 0 THEN 
             LET l_pagetot = (l_body_cnt / 5) + 1 #總頁次
          ELSE
             LET l_pagetot = (l_body_cnt / 5)     #總頁次
          END IF
          
          IF cl_null(l_pagecnt) OR l_pagecnt = 0 THEN LET l_pagecnt = 1 END IF
          IF cl_null(l_pagetot) OR l_pagetot = 0 THEN LET l_pagetot = 1 END IF
          LET l_pageno = l_pagecnt USING '##','/',l_pagetot USING '##'
          PRINTX l_pageno
          
          #160510-00022#1--add--str--
          IF sr1.glaq003=0 THEN
             LET sr1.glaq003=NULL
          END IF
          IF sr1.glaq004=0 THEN
             LET sr1.glaq004=NULL
          END IF
          #160510-00022#1--add--end
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
                sr1.glapent CLIPPED ,"'", " AND  ooff003 = '", sr1.glapdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.glaqseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr310_g02_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aglr310_g02_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aglr310_g02_subrep03
           DECLARE aglr310_g02_repcur03 CURSOR FROM g_sql
           FOREACH aglr310_g02_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr310_g02_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aglr310_g02_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aglr310_g02_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.glapdocno
 
           #add-point:rep.a_group.glapdocno.before name="rep.a_group.glapdocno.before"
           LET l_glaq003_sum = GROUP SUM(sr1.glaq003)
           LET l_glaq004_sum = GROUP SUM(sr1.glaq004)
        
           PRINTX l_glaq003_sum
           PRINTX l_glaq004_sum
           #大寫金額
           LET l_glaq003_sum=s_num_round('1',l_glaq003_sum,2)
           CALL s_num_to_chinese(l_glaq003_sum) RETURNING l_sum_str
           PRINTX l_sum_str
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.glapent CLIPPED ,"'", " AND  ooff003 = '", sr1.glapdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglr310_g02_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aglr310_g02_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aglr310_g02_subrep04
           DECLARE aglr310_g02_repcur04 CURSOR FROM g_sql
           FOREACH aglr310_g02_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglr310_g02_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aglr310_g02_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aglr310_g02_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.glapdocno.after name="rep.a_group.glapdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.glaqseq
 
           #add-point:rep.a_group.glaqseq.before name="rep.a_group.glaqseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.glaqseq.after name="rep.a_group.glaqseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aglr310_g02.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aglr310_g02_subrep01(sr2)
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
PRIVATE REPORT aglr310_g02_subrep02(sr2)
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
PRIVATE REPORT aglr310_g02_subrep03(sr2)
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
PRIVATE REPORT aglr310_g02_subrep04(sr2)
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
 
{<section id="aglr310_g02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取科目說明及核算項資料
# Memo...........:
# Usage..........: CALL aglr310_g02_glaq002(p_ac)
# Date & Author..: 2014/09/09 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_glaq002(p_ac)
   DEFINE p_ac                LIKE type_t.num5
   DEFINE l_glaq002_desc      LIKE glacl_t.glacl004
   DEFINE r_glaq002           STRING
   DEFINE r_str               STRING
   DEFINE l_desc              STRING
   #170117-00005#1--add--str--
   DEFINE r_str2              STRING 
   DEFINE l_glad              RECORD
                              glad0171    LIKE  glad_t.glad0171,
                              glad0172    LIKE  glad_t.glad0172,
                              glad0181    LIKE  glad_t.glad0181,
                              glad0182    LIKE  glad_t.glad0182,
                              glad0191    LIKE  glad_t.glad0191,
                              glad0192    LIKE  glad_t.glad0192,
                              glad0201    LIKE  glad_t.glad0201,
                              glad0202    LIKE  glad_t.glad0202,
                              glad0211    LIKE  glad_t.glad0211,
                              glad0212    LIKE  glad_t.glad0212,
                              glad0221    LIKE  glad_t.glad0221,
                              glad0222    LIKE  glad_t.glad0222,
                              glad0231    LIKE  glad_t.glad0231,
                              glad0232    LIKE  glad_t.glad0232,
                              glad0241    LIKE  glad_t.glad0241,
                              glad0242    LIKE  glad_t.glad0242,
                              glad0251    LIKE  glad_t.glad0251,
                              glad0252    LIKE  glad_t.glad0252,
                              glad0261    LIKE  glad_t.glad0261,
                              glad0262    LIKE  glad_t.glad0262
                           END RECORD
   #170117-00005#1--add--end
   
   #抓取科目名称
   LET l_glaq002_desc = ''
   SELECT glacl004 INTO l_glaq002_desc FROM glacl_t
    WHERE glaclent = g_enterprise
      AND glacl001 = (SELECT glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=sr[p_ac].glapld)
      AND glacl002 = sr[p_ac].glaq002
      AND glacl003 = g_dlang   

   #组合名称以及核算项
   LET r_glaq002 = ''
   LET r_str = ''
   LET r_str2 = '' #170117-00005#1 add
#170117-00005#1--unmark--str--
   #營運據點
   IF NOT cl_null(sr[p_ac].glaq017) THEN
      CALL aglr310_g02_ooef001_desc(sr[p_ac].glaq017) RETURNING l_desc
      LET r_glaq002 = l_desc    
      LET r_str=sr[p_ac].glaq017  
      LET r_str2=s_desc_show1(sr[p_ac].glaq017,l_desc) #170117-00005#1 add
   END IF
#170117-00005#1--unmark--end
   #部门
   IF NOT cl_null(sr[p_ac].glaq018) THEN
      CALL aglr310_g02_ooef001_desc(sr[p_ac].glaq018) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq018
      ELSE
         LET r_str=sr[p_ac].glaq018
      END IF
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq018,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq018,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
#170117-00005#1--unmark--str--
   #成本利润中心
   IF NOT cl_null(sr[p_ac].glaq019) THEN
      CALL aglr310_g02_ooef001_desc(sr[p_ac].glaq019) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq019
      ELSE
         LET r_str=sr[p_ac].glaq019
      END IF
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq019,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq019,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
   
   #区域
   IF NOT cl_null(sr[p_ac].glaq020) THEN 
      CALL aglr310_g02_glaq020_desc('287',sr[p_ac].glaq020) RETURNING l_desc   
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq020
      ELSE
         LET r_str=sr[p_ac].glaq020
      END IF
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq020,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq020,l_desc)
      END IF
      #170117-00005#1--add--end      
   END IF 
#170117-00005#1--unmark--end
   #交易客商
   IF NOT cl_null(sr[p_ac].glaq021) THEN
      CALL aglr310_g02_glaq021_desc(sr[p_ac].glaq021) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq021
      ELSE
         LET r_str=sr[p_ac].glaq021
      END IF
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq021,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq021,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
#170117-00005#1--unmark--str--
   #帐款客商
   IF NOT cl_null(sr[p_ac].glaq022) THEN
      CALL aglr310_g02_glaq021_desc(sr[p_ac].glaq022) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq022
      ELSE
         LET r_str=sr[p_ac].glaq022
      END IF     
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq022,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq022,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
   #客群
   IF NOT cl_null(sr[p_ac].glaq023) THEN
      CALL aglr310_g02_glaq020_desc('281',sr[p_ac].glaq023) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq023
      ELSE
         LET r_str=sr[p_ac].glaq023
      END IF 
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq023,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq023,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
   
   #产品分类
   IF NOT cl_null(sr[p_ac].glaq024) THEN
      CALL aglr310_g02_glaq024_desc(sr[p_ac].glaq024) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq024
      ELSE
         LET r_str=sr[p_ac].glaq024
      END IF     
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq024,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq024,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
   
   #經營方式
   IF NOT cl_null(sr[p_ac].glaq051) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '6013'
      LET g_ref_fields[2] = sr[p_ac].glaq051
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001=? AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_desc = g_rtn_fields[1]
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq051
      ELSE
         LET r_str=sr[p_ac].glaq051
      END IF
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq051,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq051,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
   
   #渠道
   IF NOT cl_null(sr[p_ac].glaq052) THEN
      CALL aglr310_g02_glaq052_desc(sr[p_ac].glaq052) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq052
      ELSE
         LET r_str=sr[p_ac].glaq052
      END IF      
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq052,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq052,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
   
   #品牌
   IF NOT cl_null(sr[p_ac].glaq053) THEN
      CALL aglr310_g02_glaq020_desc('2002',sr[p_ac].glaq053) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq053
      ELSE
         LET r_str=sr[p_ac].glaq053
      END IF      
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq053,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq053,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF
#170117-00005#1--unmark--end   
   #人员
   IF NOT cl_null(sr[p_ac].glaq025) THEN
       CALL aglr310_g02_glaq013_desc(sr[p_ac].glaq025) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq025
      ELSE
         LET r_str=sr[p_ac].glaq025
      END IF      
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq025,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq025,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 

#   #预算编号
#   IF NOT cl_null(sr[p_ac].glaq026) THEN
#       CALL aglr310_g02_glaq026_desc(sr[p_ac].glaq026) RETURNING l_desc
#      IF NOT cl_null(r_glaq002) THEN
#         LET r_glaq002 = r_glaq002 ,'-',l_desc
#      ELSE
#         LET r_glaq002 = l_desc
#      END IF
#      IF NOT cl_null(r_str) THEN
#         LET r_str=r_str,'-',sr[p_ac].glaq026
#      ELSE
#         LET r_str=sr[p_ac].glaq026
#      END IF  
#   END IF 
#170117-00005#1--unmark--str--
   #专案编号
   IF NOT cl_null(sr[p_ac].glaq027) THEN
      CALL s_desc_get_project_desc(sr[p_ac].glaq027) RETURNING l_desc #170117-00005#1 add
      IF NOT cl_null(r_glaq002) THEN
#         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq027 #170117-00005#1 mark
         LET r_glaq002 = r_glaq002 ,'-',l_desc #170117-00005#1 add
      ELSE
#         LET r_glaq002 = sr[p_ac].glaq027 #170117-00005#1 mark
         LET r_glaq002 = l_desc #170117-00005#1 add
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq027
      ELSE
         LET r_str=sr[p_ac].glaq027
      END IF      
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq027,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq027,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
   #WBS
   IF NOT cl_null(sr[p_ac].glaq028) THEN
      CALL s_desc_get_pjbbl004_desc(sr[p_ac].glaq027,sr[p_ac].glaq028) RETURNING l_desc #170117-00005#1 add
      IF NOT cl_null(r_glaq002) THEN
#         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq028 #170117-00005#1 mark
         LET r_glaq002 = r_glaq002 ,'-',l_desc #170117-00005#1 add
      ELSE
#         LET r_glaq002 = sr[p_ac].glaq028 #170117-00005#1 mark
         LET r_glaq002 = l_desc #170117-00005#1 add
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq028
      ELSE
         LET r_str=sr[p_ac].glaq028
      END IF      
      #170117-00005#1--add--str--
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq028,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq028,l_desc)
      END IF
      #170117-00005#1--add--end
   END IF 
#170117-00005#1--unmark--end

   #170117-00005#1--add--str--
   #抓取自由核算项
   CALL s_fin_sel_glad(sr[p_ac].glapld,sr[p_ac].glaq002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
        RETURNING g_errno,l_glad.*
   #自由核算項一
   IF NOT cl_null(sr[p_ac].glaq029) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0171,sr[p_ac].glaq029) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq029
      ELSE
         LET r_glaq002 = sr[p_ac].glaq029
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq029
      ELSE
         LET r_str=sr[p_ac].glaq029
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq029,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq029,l_desc)
      END IF
   END IF
   #自由核算項二
   IF NOT cl_null(sr[p_ac].glaq030) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0181,sr[p_ac].glaq030) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq030
      ELSE
         LET r_glaq002 = sr[p_ac].glaq030
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq030
      ELSE
         LET r_str=sr[p_ac].glaq030
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq030,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq030,l_desc)
      END IF
   END IF
   #自由核算項三
   IF NOT cl_null(sr[p_ac].glaq031) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0191,sr[p_ac].glaq031) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq031
      ELSE
         LET r_glaq002 = sr[p_ac].glaq031
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq031
      ELSE
         LET r_str=sr[p_ac].glaq031
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq031,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq031,l_desc)
      END IF
   END IF
   #自由核算項四
   IF NOT cl_null(sr[p_ac].glaq032) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0201,sr[p_ac].glaq032) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq032
      ELSE
         LET r_glaq002 = sr[p_ac].glaq032
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq032
      ELSE
         LET r_str=sr[p_ac].glaq032
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq032,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq032,l_desc)
      END IF
   END IF
   #自由核算項五
   IF NOT cl_null(sr[p_ac].glaq033) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0211,sr[p_ac].glaq033) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq033
      ELSE
         LET r_glaq002 = sr[p_ac].glaq033
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq033
      ELSE
         LET r_str=sr[p_ac].glaq033
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq033,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq033,l_desc)
      END IF
   END IF
   #自由核算項六
   IF NOT cl_null(sr[p_ac].glaq034) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0221,sr[p_ac].glaq034) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq034
      ELSE
         LET r_glaq002 = sr[p_ac].glaq034
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq034
      ELSE
         LET r_str=sr[p_ac].glaq034
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq034,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq034,l_desc)
      END IF
   END IF
   #自由核算項七
   IF NOT cl_null(sr[p_ac].glaq035) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0231,sr[p_ac].glaq035) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq035
      ELSE
         LET r_glaq002 = sr[p_ac].glaq035
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq035
      ELSE
         LET r_str=sr[p_ac].glaq035
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq035,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq035,l_desc)
      END IF
   END IF
   #自由核算項八
   IF NOT cl_null(sr[p_ac].glaq036) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0241,sr[p_ac].glaq036) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq036
      ELSE
         LET r_glaq002 = sr[p_ac].glaq036
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq036
      ELSE
         LET r_str=sr[p_ac].glaq036
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq036,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq036,l_desc)
      END IF
   END IF
   #自由核算項九
   IF NOT cl_null(sr[p_ac].glaq037) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0251,sr[p_ac].glaq037) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq037
      ELSE
         LET r_glaq002 = sr[p_ac].glaq037
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq037
      ELSE
         LET r_str=sr[p_ac].glaq037
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq037,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq037,l_desc)
      END IF
   END IF
   #自由核算項十
   IF NOT cl_null(sr[p_ac].glaq038) THEN
      CALL s_fin_get_accting_desc(l_glad.glad0261,sr[p_ac].glaq038) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',sr[p_ac].glaq038
      ELSE
         LET r_glaq002 = sr[p_ac].glaq038
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',sr[p_ac].glaq038
      ELSE
         LET r_str=sr[p_ac].glaq038
      END IF
      IF NOT cl_null(r_str2) THEN
         LET r_str2=r_str2,'-',s_desc_show1(sr[p_ac].glaq038,l_desc)
      ELSE
         LET r_str2=s_desc_show1(sr[p_ac].glaq038,l_desc)
      END IF
   END IF
   #170117-00005#1--add--end
   
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF 
   #科目名称、核算项說明、核算項編號组合  
#   RETURN l_glaq002_desc,r_glaq002,r_str #170117-00005#1 mark
   RETURN l_glaq002_desc,r_glaq002,r_str,r_str2 #170117-00005#1 add
END FUNCTION

################################################################################
# Descriptions...: 抓取組織說明
# Memo...........:
# Usage..........: CALL aglr310_g02_ooef001_desc(p_ooef001)
#                  RETURNING r_desc
# Input parameter: p_ooef001      組織編號
# Return code....: r_desc         組織說明
# Date & Author..: 2014/09/09 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_ooef001_desc(p_ooef001)
   DEFINE p_ooef001     LIKE ooef_t.ooef001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 區域客群說明
# Memo...........:
# Usage..........: CALL aglr310_g02_glaq020_desc(p_oocq001,p_oocq002)
# Date & Author..: 2014/09/09 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_glaq020_desc(p_oocq001,p_oocq002)
   DEFINE p_oocq001     LIKE oocql_t.oocql001
   DEFINE p_oocq002     LIKE oocql_t.oocql002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocq001
   LET g_ref_fields[2] = p_oocq002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 客商說明
# Memo...........:
# Usage..........: CALL aglr310_g02_glaq021_desc(p_glaq021)
# Date & Author..: 2014/09/09 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_glaq021_desc(p_glaq021)
   DEFINE p_glaq021    LIKE pmaa_t.pmaa001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq021
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 產品分類說明
# Memo...........:
# Usage..........: CALL aglr310_g02_glaq024_desc(p_glaq024)
# Date & Author..: 2014/09/09 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_glaq024_desc(p_glaq024)
   DEFINE p_glaq024   LIKE glaq_t.glaq024
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq024
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 人員名稱
# Memo...........:
# Usage..........: CALL aglr310_g02_glaq013_desc(p_glaq013)
# Date & Author..: 2014/09/09 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_glaq013_desc(p_glaq013)
   DEFINE l_ooag011        LIKE ooag_t.ooag011
   DEFINE p_glaq013        LIKE glaq_t.glaq013

   LET  l_ooag011 = ''
   SELECT ooag011 INTO l_ooag011 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = p_glaq013
    RETURN l_ooag011
END FUNCTION

################################################################################
# Descriptions...: 預算編號說明
# Memo...........:
# Usage..........: CALL aglr310_g02_glaq026_desc(p_glaq026)
# Date & Author..: 2014/09/09 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_glaq026_desc(p_glaq026)
   DEFINE p_glaq026      LIKE glaq_t.glaq026
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq026
   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 抓取渠道說明
# Memo...........:
# Usage..........: CALL aglr310_g02_glaq052_desc(p_glaq052)
#                  RETURNING r_desc
# Input parameter: p_glaq052      渠道編號
# Date & Author..: 2014/10/20 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglr310_g02_glaq052_desc(p_glaq052)
   DEFINE p_glaq052    LIKE glaq_t.glaq052

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq052
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION

 
{</section>}
 
{<section id="aglr310_g02.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
