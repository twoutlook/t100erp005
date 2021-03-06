#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq770_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-03-11 18:31:56), PR版次:0001(2015-03-20 16:20:45)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000105
#+ Filename...: aglq770_g01
#+ Description: ...
#+ Creator....: 05416(2014-07-22 16:10:16)
#+ Modifier...: 01251 -SD/PR- 01251
 
{</section>}
 
{<section id="aglq770_g01.global" readonly="Y" >}
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
   glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glapdocno LIKE glap_t.glapdocno, 
   glaq001 LIKE glaq_t.glaq001, 
   style LIKE type_t.chr200, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq010d LIKE type_t.num20_6, 
   glaq010c LIKE type_t.num20_6, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   state LIKE type_t.chr10, 
   amt LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   glapent LIKE glap_t.glapent, 
   glaq002 LIKE glaq_t.glaq002, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq021 LIKE glaq_t.glaq021, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq025 LIKE glaq_t.glaq025, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq028 LIKE glaq_t.glaq028, 
   glaq029 LIKE glaq_t.glaq029, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq038 LIKE glaq_t.glaq038, 
   l_groupby LIKE type_t.chr500
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       sdate LIKE type_t.dat,         #起始日期 
       syear LIKE glap_t.glap002,         #起始年度 
       speri LIKE glap_t.glap004,         #起始期別 
       edate LIKE type_t.dat,         #截止日期 
       eyear LIKE glap_t.glap002,         #截止年度 
       eperi LIKE glap_t.glap004,         #截止期別 
       curro LIKE type_t.chr1,         #顯示外幣 
       currp LIKE type_t.chr1,         #幣別分頁 
       comp LIKE type_t.chr1,         #營運據點 
       ad007 LIKE type_t.chr1,         #部門 
       ad008 LIKE type_t.chr1,         #利潤成本 
       ad009 LIKE type_t.chr1,         #區域 
       ad010 LIKE type_t.chr1,         #交易客商 
       ad027 LIKE type_t.chr1,         #帳款客商 
       ad011 LIKE type_t.chr1,         #客群 
       ad012 LIKE type_t.chr1,         #產品類別 
       ad031 LIKE type_t.chr1,         #經營方式 
       ad032 LIKE type_t.chr1,         #渠道 
       ad033 LIKE type_t.chr1,         #品牌 
       ad013 LIKE type_t.chr1,         #人員 
       ad015 LIKE type_t.chr1,         #專案 
       ad016 LIKE type_t.chr1,         #WBS 
       ad017 LIKE type_t.chr1,         #自由核算項一 
       ad018 LIKE type_t.chr1,         #自由核算項二 
       ad019 LIKE type_t.chr1,         #自由核算項三 
       ad020 LIKE type_t.chr1,         #自由核算項四 
       ad021 LIKE type_t.chr1,         #自由核算項五 
       ad022 LIKE type_t.chr1,         #自由核算項六 
       ad023 LIKE type_t.chr1,         #自由核算項七 
       ad024 LIKE type_t.chr1,         #自由核算項八 
       ad025 LIKE type_t.chr1,         #自由核算項九 
       ad026 LIKE type_t.chr1,         #自由核算項十 
       ld LIKE glap_t.glapld          #帳套
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
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
{</section>}
 
{<section id="aglq770_g01.main" readonly="Y" >}
PUBLIC FUNCTION aglq770_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9,p_arg10,p_arg11,p_arg12,p_arg13,p_arg14,p_arg15,p_arg16,p_arg17,p_arg18,p_arg19,p_arg20,p_arg21,p_arg22,p_arg23,p_arg24,p_arg25,p_arg26,p_arg27,p_arg28,p_arg29,p_arg30,p_arg31,p_arg32,p_arg33,p_arg34)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.sdate  起始日期 
DEFINE  p_arg3 LIKE glap_t.glap002         #tm.syear  起始年度 
DEFINE  p_arg4 LIKE glap_t.glap004         #tm.speri  起始期別 
DEFINE  p_arg5 LIKE type_t.dat         #tm.edate  截止日期 
DEFINE  p_arg6 LIKE glap_t.glap002         #tm.eyear  截止年度 
DEFINE  p_arg7 LIKE glap_t.glap004         #tm.eperi  截止期別 
DEFINE  p_arg8 LIKE type_t.chr1         #tm.curro  顯示外幣 
DEFINE  p_arg9 LIKE type_t.chr1         #tm.currp  幣別分頁 
DEFINE  p_arg10 LIKE type_t.chr1         #tm.comp  營運據點 
DEFINE  p_arg11 LIKE type_t.chr1         #tm.ad007  部門 
DEFINE  p_arg12 LIKE type_t.chr1         #tm.ad008  利潤成本 
DEFINE  p_arg13 LIKE type_t.chr1         #tm.ad009  區域 
DEFINE  p_arg14 LIKE type_t.chr1         #tm.ad010  交易客商 
DEFINE  p_arg15 LIKE type_t.chr1         #tm.ad027  帳款客商 
DEFINE  p_arg16 LIKE type_t.chr1         #tm.ad011  客群 
DEFINE  p_arg17 LIKE type_t.chr1         #tm.ad012  產品類別 
DEFINE  p_arg18 LIKE type_t.chr1         #tm.ad031  經營方式 
DEFINE  p_arg19 LIKE type_t.chr1         #tm.ad032  渠道 
DEFINE  p_arg20 LIKE type_t.chr1         #tm.ad033  品牌 
DEFINE  p_arg21 LIKE type_t.chr1         #tm.ad013  人員 
DEFINE  p_arg22 LIKE type_t.chr1         #tm.ad015  專案 
DEFINE  p_arg23 LIKE type_t.chr1         #tm.ad016  WBS 
DEFINE  p_arg24 LIKE type_t.chr1         #tm.ad017  自由核算項一 
DEFINE  p_arg25 LIKE type_t.chr1         #tm.ad018  自由核算項二 
DEFINE  p_arg26 LIKE type_t.chr1         #tm.ad019  自由核算項三 
DEFINE  p_arg27 LIKE type_t.chr1         #tm.ad020  自由核算項四 
DEFINE  p_arg28 LIKE type_t.chr1         #tm.ad021  自由核算項五 
DEFINE  p_arg29 LIKE type_t.chr1         #tm.ad022  自由核算項六 
DEFINE  p_arg30 LIKE type_t.chr1         #tm.ad023  自由核算項七 
DEFINE  p_arg31 LIKE type_t.chr1         #tm.ad024  自由核算項八 
DEFINE  p_arg32 LIKE type_t.chr1         #tm.ad025  自由核算項九 
DEFINE  p_arg33 LIKE type_t.chr1         #tm.ad026  自由核算項十 
DEFINE  p_arg34 LIKE glap_t.glapld         #tm.ld  帳套
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.sdate = p_arg2
   LET tm.syear = p_arg3
   LET tm.speri = p_arg4
   LET tm.edate = p_arg5
   LET tm.eyear = p_arg6
   LET tm.eperi = p_arg7
   LET tm.curro = p_arg8
   LET tm.currp = p_arg9
   LET tm.comp = p_arg10
   LET tm.ad007 = p_arg11
   LET tm.ad008 = p_arg12
   LET tm.ad009 = p_arg13
   LET tm.ad010 = p_arg14
   LET tm.ad027 = p_arg15
   LET tm.ad011 = p_arg16
   LET tm.ad012 = p_arg17
   LET tm.ad031 = p_arg18
   LET tm.ad032 = p_arg19
   LET tm.ad033 = p_arg20
   LET tm.ad013 = p_arg21
   LET tm.ad015 = p_arg22
   LET tm.ad016 = p_arg23
   LET tm.ad017 = p_arg24
   LET tm.ad018 = p_arg25
   LET tm.ad019 = p_arg26
   LET tm.ad020 = p_arg27
   LET tm.ad021 = p_arg28
   LET tm.ad022 = p_arg29
   LET tm.ad023 = p_arg30
   LET tm.ad024 = p_arg31
   LET tm.ad025 = p_arg32
   LET tm.ad026 = p_arg33
   LET tm.ld = p_arg34
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   IF tm.curro='Y' THEN
      LET g_template ="aglq770_g01"
   ELSE
      LET g_template ="aglq770_g01_01"
   END IF
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aglq770_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aglq770_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aglq770_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aglq770_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq770_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq770_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select="SELECT UNIQUE NULL,glap004,glapdocdt,glaqdocno,glaq001,style,glaq005,glaq006,glaq010d,glaq010c,glaq003,glaq004,state,amt,amt1,",
                "NULL,glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,",
                "glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,NULL,seq"   
   
#   #end add-point
#   LET g_select = " SELECT glap002,glap004,glapdocdt,glapdocno,glaq001,NULL,glaq005,glaq006,NULL,NULL, 
#       glaq003,glaq004,NULL,NULL,NULL,glapent,glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022, 
#       glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032, 
#       glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM ",tm.wc CLIPPED
#   #end add-point
#    LET g_from = " FROM glap_t,glaq_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where=" WHERE 1=1 "
#   #end add-point
#    LET g_where = " WHERE glap_t.glapstus = 'Y' AND " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY l_groupby"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY glaq002,seq"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glap_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aglq770_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aglq770_g01_curs CURSOR FOR aglq770_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq770_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq770_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glapdocno LIKE glap_t.glapdocno, 
   glaq001 LIKE glaq_t.glaq001, 
   style LIKE type_t.chr200, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq010d LIKE type_t.num20_6, 
   glaq010c LIKE type_t.num20_6, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   state LIKE type_t.chr10, 
   amt LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   glapent LIKE glap_t.glapent, 
   glaq002 LIKE glaq_t.glaq002, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq021 LIKE glaq_t.glaq021, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq025 LIKE glaq_t.glaq025, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq028 LIKE glaq_t.glaq028, 
   glaq029 LIKE glaq_t.glaq029, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq038 LIKE glaq_t.glaq038, 
   l_groupby LIKE type_t.chr500
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaq002  LIKE glaq_t.glaq002
DEFINE l_glaq017  LIKE glaq_t.glaq017
DEFINE l_glaq018  LIKE glaq_t.glaq018
DEFINE l_glaq019  LIKE glaq_t.glaq019
DEFINE l_glaq020  LIKE glaq_t.glaq020
DEFINE l_glaq021  LIKE glaq_t.glaq021
DEFINE l_glaq022  LIKE glaq_t.glaq022
DEFINE l_glaq023  LIKE glaq_t.glaq023
DEFINE l_glaq024  LIKE glaq_t.glaq024
DEFINE l_glaq051  LIKE glaq_t.glaq051
DEFINE l_glaq052  LIKE glaq_t.glaq052
DEFINE l_glaq053  LIKE glaq_t.glaq053
DEFINE l_glaq025  LIKE glaq_t.glaq025
DEFINE l_glaq027  LIKE glaq_t.glaq027
DEFINE l_glaq028  LIKE glaq_t.glaq028
DEFINE l_glaq029  LIKE glaq_t.glaq029
DEFINE l_glaq030  LIKE glaq_t.glaq030
DEFINE l_glaq031  LIKE glaq_t.glaq031
DEFINE l_glaq032  LIKE glaq_t.glaq032
DEFINE l_glaq033  LIKE glaq_t.glaq033
DEFINE l_glaq034  LIKE glaq_t.glaq034
DEFINE l_glaq035  LIKE glaq_t.glaq035
DEFINE l_glaq036  LIKE glaq_t.glaq036
DEFINE l_glaq037  LIKE glaq_t.glaq037
DEFINE l_glaq038  LIKE glaq_t.glaq038
DEFINE l_flag1    LIKE type_t.chr1
DEFINE l_errno    LIKE type_t.chr100
DEFINE l_glav002  LIKE glav_t.glav002
DEFINE l_glav005  LIKE glav_t.glav005
DEFINE l_sdate_s  LIKE glav_t.glav004
DEFINE l_sdate_e  LIKE glav_t.glav004
DEFINE l_glav006  LIKE glav_t.glav006
DEFINE l_pdate_s  LIKE glav_t.glav004
DEFINE l_pdate_e  LIKE glav_t.glav004
DEFINE l_glav007  LIKE glav_t.glav007
DEFINE l_wdate_s  LIKE glav_t.glav004
DEFINE l_wdate_e  LIKE glav_t.glav004
DEFINE l_glaa003  LIKE glaa_t.glaa003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aglq770_g01_curs INTO sr_s.*
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
       #期初
       IF sr_s.style='1' THEN
          IF l_glaq002 = sr_s.glaq002 AND 
             l_glaq017 = sr_s.glaq017 AND
             l_glaq018 = sr_s.glaq018 AND
             l_glaq019 = sr_s.glaq019 AND
             l_glaq020 = sr_s.glaq020 AND
             l_glaq021 = sr_s.glaq021 AND
             l_glaq022 = sr_s.glaq022 AND
             l_glaq023 = sr_s.glaq023 AND
             l_glaq024 = sr_s.glaq024 AND
             l_glaq051 = sr_s.glaq051 AND
             l_glaq052 = sr_s.glaq052 AND
             l_glaq053 = sr_s.glaq053 AND
             l_glaq025 = sr_s.glaq025 AND
             l_glaq027 = sr_s.glaq027 AND
             l_glaq028 = sr_s.glaq028 AND
             l_glaq029 = sr_s.glaq029 AND
             l_glaq030 = sr_s.glaq030 AND
             l_glaq031 = sr_s.glaq031 AND
             l_glaq032 = sr_s.glaq032 AND
             l_glaq033 = sr_s.glaq033 AND
             l_glaq034 = sr_s.glaq034 AND
             l_glaq035 = sr_s.glaq035 AND
             l_glaq036 = sr_s.glaq036 AND
             l_glaq037 = sr_s.glaq037 AND
             l_glaq038 = sr_s.glaq038 
             THEN
             CONTINUE FOREACH
          ELSE
             LET l_glaq002 = sr_s.glaq002
             LET l_glaq017 = sr_s.glaq017
             LET l_glaq018 = sr_s.glaq018
             LET l_glaq019 = sr_s.glaq019
             LET l_glaq020 = sr_s.glaq020
             LET l_glaq021 = sr_s.glaq021
             LET l_glaq022 = sr_s.glaq022
             LET l_glaq023 = sr_s.glaq023
             LET l_glaq024 = sr_s.glaq024
             LET l_glaq051 = sr_s.glaq051
             LET l_glaq052 = sr_s.glaq052
             LET l_glaq053 = sr_s.glaq053
             LET l_glaq025 = sr_s.glaq025
             LET l_glaq027 = sr_s.glaq027
             LET l_glaq028 = sr_s.glaq028
             LET l_glaq029 = sr_s.glaq029
             LET l_glaq030 = sr_s.glaq030
             LET l_glaq031 = sr_s.glaq031
             LET l_glaq032 = sr_s.glaq032
             LET l_glaq033 = sr_s.glaq033
             LET l_glaq034 = sr_s.glaq034
             LET l_glaq035 = sr_s.glaq035
             LET l_glaq036 = sr_s.glaq036
             LET l_glaq037 = sr_s.glaq037
             LET l_glaq038 = sr_s.glaq038
          END IF
       END IF

       #1、分頁
       #2、按照要求一定會按照科目分頁
       #4、根據界面參數currp是否按照幣別分頁
       #3、按照核算項分頁       
       
       IF cl_null(sr_s.glaq005) THEN
          LET sr_s.glaq005=' '
       END IF
       IF cl_null(sr_s.glaq017) THEN
          LET sr_s.glaq017=' '
       END IF       
       IF cl_null(sr_s.glaq018) THEN
          LET sr_s.glaq018=' '
       END IF     
       IF cl_null(sr_s.glaq019) THEN
          LET sr_s.glaq019=' '
       END IF   
       IF cl_null(sr_s.glaq020) THEN
          LET sr_s.glaq020=' '
       END IF        
       IF cl_null(sr_s.glaq021) THEN
          LET sr_s.glaq021=' '
       END IF   
       IF cl_null(sr_s.glaq022) THEN
          LET sr_s.glaq022=' '
       END IF
       IF cl_null(sr_s.glaq023) THEN
          LET sr_s.glaq023=' '
       END IF
       IF cl_null(sr_s.glaq024) THEN
          LET sr_s.glaq024=' '
       END IF       
       IF cl_null(sr_s.glaq051) THEN
          LET sr_s.glaq051=' '
       END IF   
       IF cl_null(sr_s.glaq052) THEN
          LET sr_s.glaq052=' '
       END IF        
       IF cl_null(sr_s.glaq053) THEN
          LET sr_s.glaq053=' '
       END IF         
       IF cl_null(sr_s.glaq025) THEN
          LET sr_s.glaq025=' '
       END IF       
       IF cl_null(sr_s.glaq027) THEN
          LET sr_s.glaq027=' '
       END IF       
       IF cl_null(sr_s.glaq028) THEN
          LET sr_s.glaq028=' '
       END IF       
       IF cl_null(sr_s.glaq029) THEN
          LET sr_s.glaq029=' '
       END IF 
       IF cl_null(sr_s.glaq030) THEN
          LET sr_s.glaq030=' '
       END IF          
       IF cl_null(sr_s.glaq031) THEN
          LET sr_s.glaq031=' '
       END IF        
       IF cl_null(sr_s.glaq032) THEN
          LET sr_s.glaq032=' '
       END IF
       IF cl_null(sr_s.glaq033) THEN
          LET sr_s.glaq033=' '
       END IF
       IF cl_null(sr_s.glaq034) THEN
          LET sr_s.glaq034=' '
       END IF
       IF cl_null(sr_s.glaq035) THEN
          LET sr_s.glaq035=' '
       END IF
       IF cl_null(sr_s.glaq036) THEN
          LET sr_s.glaq036=' '
       END IF
       IF cl_null(sr_s.glaq037) THEN
          LET sr_s.glaq037=' '
       END IF
       IF cl_null(sr_s.glaq038) THEN
          LET sr_s.glaq038=' '
       END IF       
       LET sr_s.l_groupby=sr_s.glaq002
       IF tm.currp='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq005
       END IF
       IF tm.comp='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq017
       END IF
       IF tm.ad007='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq018
       END IF
       IF tm.ad008='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq019
       END IF
       IF tm.ad009='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq020
       END IF
       IF tm.ad010='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq021
       END IF
       IF tm.ad027='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq022
       END IF
       IF tm.ad011='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq023
       END IF
       IF tm.ad012='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq024
       END IF
       IF tm.ad031='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq051
       END IF
       IF tm.ad032='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq052
       END IF
       IF tm.ad033='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq053
       END IF
       IF tm.ad013='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq025
       END IF
       IF tm.ad015='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq027
       END IF
       IF tm.ad016='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq028
       END IF
       IF tm.ad017='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq029
       END IF
       IF tm.ad018='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq030
       END IF
       IF tm.ad019='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq031
       END IF
       IF tm.ad020='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq032
       END IF
       IF tm.ad021='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq033
       END IF
       IF tm.ad022='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq034
       END IF
       IF tm.ad023='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq035
       END IF
       IF tm.ad024='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq036
       END IF
       IF tm.ad025='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq037
       END IF
       IF tm.ad026='Y' THEN
          LET sr_s.l_groupby=sr_s.l_groupby||','||sr_s.glaq038
       END IF

       IF sr_s.style='1' THEN  #期初
          LET sr_s.glap002=tm.syear
          LET sr_s.glap004=tm.speri
          LET sr_s.glapdocdt=tm.sdate
       END IF
       IF sr_s.style='2' OR sr_s.style='3' THEN  #本期合計&本年累計
          LET sr_s.glap002=tm.eyear
          LET sr_s.glapdocdt='' 
       END IF 
       IF cl_null(sr_s.style) THEN
          LET l_glaa003=''
          SELECT glaa003
            INTO l_glaa003
            FROM glaa_t
           WHERE glaaent = g_enterprise
             AND glaald = tm.ld       
          CALL s_get_accdate(l_glaa003,sr_s.glapdocdt,'','')
          RETURNING l_flag1,l_errno,sr_s.glap002,l_glav005,l_sdate_s,l_sdate_e,
                    sr_s.glap004,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
       END IF
                
       SELECT gzcbl004 INTO sr_s.state
         FROM gzcbl_t
        WHERE gzcbl001='9926'
          AND gzcbl002=sr_s.state
          AND gzcbl003=g_dlang
       SELECT gzcbl004 INTO sr_s.style
         FROM gzcbl_t
        WHERE gzcbl001='9927'
          AND gzcbl002=sr_s.style
          AND gzcbl003=g_dlang  
       IF NOT cl_null(sr_s.style) THEN
          LET sr_s.glaq001=sr_s.style
       END IF          
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].glap002 = sr_s.glap002
       LET sr[l_cnt].glap004 = sr_s.glap004
       LET sr[l_cnt].glapdocdt = sr_s.glapdocdt
       LET sr[l_cnt].glapdocno = sr_s.glapdocno
       LET sr[l_cnt].glaq001 = sr_s.glaq001
       LET sr[l_cnt].style = sr_s.style
       LET sr[l_cnt].glaq005 = sr_s.glaq005
       LET sr[l_cnt].glaq006 = sr_s.glaq006
       LET sr[l_cnt].glaq010d = sr_s.glaq010d
       LET sr[l_cnt].glaq010c = sr_s.glaq010c
       LET sr[l_cnt].glaq003 = sr_s.glaq003
       LET sr[l_cnt].glaq004 = sr_s.glaq004
       LET sr[l_cnt].state = sr_s.state
       LET sr[l_cnt].amt = sr_s.amt
       LET sr[l_cnt].amt1 = sr_s.amt1
       LET sr[l_cnt].glapent = sr_s.glapent
       LET sr[l_cnt].glaq002 = sr_s.glaq002
       LET sr[l_cnt].glaq017 = sr_s.glaq017
       LET sr[l_cnt].glaq018 = sr_s.glaq018
       LET sr[l_cnt].glaq019 = sr_s.glaq019
       LET sr[l_cnt].glaq020 = sr_s.glaq020
       LET sr[l_cnt].glaq021 = sr_s.glaq021
       LET sr[l_cnt].glaq022 = sr_s.glaq022
       LET sr[l_cnt].glaq023 = sr_s.glaq023
       LET sr[l_cnt].glaq024 = sr_s.glaq024
       LET sr[l_cnt].glaq051 = sr_s.glaq051
       LET sr[l_cnt].glaq052 = sr_s.glaq052
       LET sr[l_cnt].glaq053 = sr_s.glaq053
       LET sr[l_cnt].glaq025 = sr_s.glaq025
       LET sr[l_cnt].glaq027 = sr_s.glaq027
       LET sr[l_cnt].glaq028 = sr_s.glaq028
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
       LET sr[l_cnt].l_groupby = sr_s.l_groupby
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq770_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq770_g01_rep_data()
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
          START REPORT aglq770_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aglq770_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aglq770_g01_rep
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
 
{<section id="aglq770_g01.rep" readonly="Y" >}
PRIVATE REPORT aglq770_g01_rep(sr1)
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
DEFINE l_comp          STRING
DEFINE l_comp2         STRING
DEFINE l_desc          LIKE type_t.chr200
DEFINE l_glad0171      LIKE glad_t.glad0171
DEFINE l_glad0181      LIKE glad_t.glad0181
DEFINE l_glad0191      LIKE glad_t.glad0191
DEFINE l_glad0201      LIKE glad_t.glad0201
DEFINE l_glad0211      LIKE glad_t.glad0211
DEFINE l_glad0221      LIKE glad_t.glad0221
DEFINE l_glad0231      LIKE glad_t.glad0231
DEFINE l_glad0241      LIKE glad_t.glad0241
DEFINE l_glad0251      LIKE glad_t.glad0251
DEFINE l_glad0261      LIKE glad_t.glad0261
DEFINE l_glaq002       LIKE type_t.chr100
DEFINE l_glaa004       LIKE glaa_t.glaa004
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
 
    #end add-point
    ORDER EXTERNAL BY sr1.l_groupby
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
        BEFORE GROUP OF sr1.l_groupby
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_groupby
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'glapent=' ,sr1.glapent,'{+}glapdocno=' ,sr1.glapdocno         
            CALL cl_gr_init_apr(sr1.l_groupby)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_groupby.before name="rep.b_group.l_groupby.before"
            LET l_comp=''
            LET l_comp2="("
            #營運據點    
            IF tm.comp='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq017
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq017
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] =sr1.glaq017
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]
            END IF
            #部門
            IF tm.ad007='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq018
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq018
               END IF               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] =sr1.glaq018
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF               
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]      
            END IF
            #成本中心
            IF tm.ad008='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq019
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq019
               END IF                
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] =sr1.glaq019
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF               
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]         
            END IF
            #區域
            IF tm.ad009='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq020
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq020
               END IF   
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = '287'
               LET g_ref_fields[2] = sr1.glaq020
               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF                
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]           
            END IF
            #交易客戶
            IF tm.ad010='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq021
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq021
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = sr1.glaq021
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF                  
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]       
            END IF    
            #帳款客戶
            IF tm.ad027='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq022
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq022
               END IF  
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = sr1.glaq022
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]       
            END IF
            
            #客群     
            IF tm.ad011='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq023
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq023
               END IF       
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = '281'
               LET g_ref_fields[2] = sr1.glaq023
               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]        
            END IF
            #產品類別
            IF tm.ad012='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq024
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq024
               END IF    
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = sr1.glaq024
               CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]         
            END IF
            #經營方式
            IF tm.ad031='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq051
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq051
               END IF               
               SELECT gzcbl004 INTO l_desc
                 FROM gzcbl_t
                WHERE gzcbl001='6013'
                  AND gzcbl002=sr1.glaq051
                  AND gzcbl003=g_dlang
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                     
               LET l_comp2=l_comp2||'-'||l_desc     
            END IF
            #渠道管理
            IF tm.ad032='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq052
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq052
               END IF  
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = sr1.glaq052
               CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]        
            END IF
            #品牌
            IF tm.ad033='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq053
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq053
               END IF    
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = '2002'
               LET g_ref_fields[2] = sr1.glaq053
               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||g_rtn_fields[1]       
            END IF
            #人員編號
            IF tm.ad013='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq025
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq025
               END IF     
               LET l_desc=''
               SELECT ooag011 INTO l_desc FROM ooag_t
                WHERE ooagent = g_enterprise AND ooag001 = sr1.glaq025
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||l_desc        
            END IF
            #專案
            IF tm.ad015='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq027
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq027
               END IF      
               LET l_desc=''
               CALL s_desc_get_project_desc(sr1.glaq027) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||l_desc 
               
            END IF
            #WBS
            IF tm.ad016='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq028
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq028
               END IF  
               LET l_desc=''
               CALL s_desc_get_wbs_desc(sr1.glaq027,sr1.glaq028) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                
               LET l_comp2=l_comp2||'-'||l_desc 
               
            END IF
              
            #自由核算項
            SELECT glad0171,glad0181,glad0191,glad0201,glad0211,glad0221,
                   glad0231,glad0221,glad0251,glad0261
             INTO  l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,l_glad0221,
                   l_glad0231,l_glad0241,l_glad0251,l_glad0261
             FROM  glad_t
             WHERE gladent = g_enterprise
               AND gladld = tm.ld
               AND glad001 = sr1.glaq002   
            IF tm.ad017='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq029
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq029
               END IF  
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0171,sr1.glaq029) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad018='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq030
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq030
               END IF   
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0181,sr1.glaq030) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF               
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad019='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq031
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq031
               END IF         
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0191,sr1.glaq031) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF               
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad020='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq032
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq032
               END IF    
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0201,sr1.glaq032) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad021='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq033
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq033
               END IF   
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0211,sr1.glaq033) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                 
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad022='Y' THEN
                IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq034
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq034
               END IF   
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0221,sr1.glaq034) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad023='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq035
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq035
               END IF  
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0231,sr1.glaq035) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad024='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq036
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq036
               END IF              
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0241,sr1.glaq036) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad025='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq037
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq037
               END IF   
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0251,sr1.glaq037) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            IF tm.ad026='Y' THEN
               IF cl_null(l_comp) THEN
                  LET l_comp=sr1.glaq038
               ELSE
                 LET l_comp=l_comp||'-'||sr1.glaq038
               END IF  
               LET l_desc=''
               CALL s_voucher_free_account_desc(l_glad0261,sr1.glaq038) RETURNING l_desc
               IF cl_null(l_desc) THEN
                  LET l_desc=' '
               END IF                
               LET l_comp2=l_comp2||'-'||l_desc 
            END IF
            LET l_comp2=l_comp2||')'
            LET l_comp=l_comp||l_comp2  
           
           LET l_glaa004=''
           LET l_glaq002=''
           SELECT glaa004 INTO l_glaa004
             FROM glaa_t
            WHERE glaaent=g_enterprise
              AND glaald=tm.ld
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = sr1.glaq002
           CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||l_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET l_glaq002=g_rtn_fields[1]
           
           IF cl_null(l_glaq002) THEN
              LET l_glaq002=' '
           END IF   
           
           LET l_glaq002=sr1.glaq002||'('||l_glaq002||')' 
           PRINTX l_glaq002

           PRINTX l_comp
           
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.glapent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_groupby CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq770_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aglq770_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aglq770_g01_subrep01
           DECLARE aglq770_g01_repcur01 CURSOR FROM g_sql
           FOREACH aglq770_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq770_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aglq770_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aglq770_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_groupby.after name="rep.b_group.l_groupby.after"
           
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
                sr1.glapent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_groupby CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq770_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aglq770_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aglq770_g01_subrep02
           DECLARE aglq770_g01_repcur02 CURSOR FROM g_sql
           FOREACH aglq770_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq770_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aglq770_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aglq770_g01_subrep02
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
                sr1.glapent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq770_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aglq770_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aglq770_g01_subrep03
           DECLARE aglq770_g01_repcur03 CURSOR FROM g_sql
           FOREACH aglq770_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq770_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aglq770_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aglq770_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_groupby
 
           #add-point:rep.a_group.l_groupby.before name="rep.a_group.l_groupby.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.glapent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_groupby CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq770_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aglq770_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aglq770_g01_subrep04
           DECLARE aglq770_g01_repcur04 CURSOR FROM g_sql
           FOREACH aglq770_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq770_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aglq770_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aglq770_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_groupby.after name="rep.a_group.l_groupby.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aglq770_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aglq770_g01_subrep01(sr2)
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
PRIVATE REPORT aglq770_g01_subrep02(sr2)
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
PRIVATE REPORT aglq770_g01_subrep03(sr2)
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
PRIVATE REPORT aglq770_g01_subrep04(sr2)
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
 
{<section id="aglq770_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aglq770_g01.other_report" readonly="Y" >}

 
{</section>}
 
