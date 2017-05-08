#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr705_g02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-11-22 10:20:01), PR版次:0003(2016-11-22 17:16:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: ainr705_g02
#+ Description: ...
#+ Creator....: 06932(2016-10-31 15:49:30)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="ainr705_g02.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161109-00078#4  20161114 By 06814           1.修改為依需求對象分頁
#                                            2.取數量(由indj009 改為 indj010 )
#161017-00051#13 20161122 By 06814           1.现货格式，排序要按商品编号+特征
#                                            2.现货格式，横向小计为0的行，不显示(也就是此次分配量为0的商品不显示);
#                                            3.现货拣货打印，按需求对象分页后，if 按此需求对象 sum单身（此次分配量indj010）=0,则此需求对象的拣货单部分不打印
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
   l_indidocno LIKE type_t.chr1000, 
   l_indidocdt LIKE type_t.chr1000, 
   l_condition1 LIKE type_t.chr1000, 
   l_condition2 LIKE type_t.chr1000, 
   indi000 LIKE indi_t.indi000, 
   indi001 LIKE indi_t.indi001, 
   indi002 LIKE indi_t.indi002, 
   indi003 LIKE indi_t.indi003, 
   indi004 LIKE indi_t.indi004, 
   indi005 LIKE indi_t.indi005, 
   indi006 LIKE indi_t.indi006, 
   indi007 LIKE indi_t.indi007, 
   indidocdt LIKE indi_t.indidocdt, 
   indidocno LIKE indi_t.indidocno, 
   indient LIKE indi_t.indient, 
   indisite LIKE indi_t.indisite, 
   indistus LIKE indi_t.indistus, 
   indiunit LIKE indi_t.indiunit, 
   indj001 LIKE indj_t.indj001, 
   indj002 LIKE indj_t.indj002, 
   indj003 LIKE indj_t.indj003, 
   indj004 LIKE indj_t.indj004, 
   indj005 LIKE indj_t.indj005, 
   indj006 LIKE indj_t.indj006, 
   indj007 LIKE indj_t.indj007, 
   indj008 LIKE indj_t.indj008, 
   indj009 LIKE indj_t.indj009, 
   indj010 LIKE indj_t.indj010, 
   indj011 LIKE indj_t.indj011, 
   indj012 LIKE indj_t.indj012, 
   indj013 LIKE indj_t.indj013, 
   indj014 LIKE indj_t.indj014, 
   indj015 LIKE indj_t.indj015, 
   indj016 LIKE indj_t.indj016, 
   indj017 LIKE indj_t.indj017, 
   indj018 LIKE indj_t.indj018, 
   indj019 LIKE indj_t.indj019, 
   indj020 LIKE indj_t.indj020, 
   indjseq LIKE indj_t.indjseq, 
   indjsite LIKE indj_t.indjsite, 
   indjunit LIKE indj_t.indjunit, 
   dbabl_t_dbabl003 LIKE dbabl_t.dbabl003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t4_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t7_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t8_ooefl003 LIKE ooefl_t.ooefl003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t6_oocal003 LIKE oocal_t.oocal003, 
   x_inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_t5_inayl003 LIKE inayl_t.inayl003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t3_inab003 LIKE inab_t.inab003, 
   x_pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_indiunit_ooefl003 LIKE type_t.chr1000, 
   l_indi003_ooag011 LIKE type_t.chr300, 
   l_indi004_ooefl003 LIKE type_t.chr1000, 
   l_indisite_ooefl003 LIKE type_t.chr1000, 
   l_indjunit_ooefl003 LIKE type_t.chr1000, 
   l_indj003_ooefl003 LIKE type_t.chr1000, 
   l_indj012_inayl003 LIKE type_t.chr1000, 
   l_indjsite_ooefl003 LIKE type_t.chr1000, 
   l_indj020_pmaal003 LIKE type_t.chr300, 
   l_indj015_inayl003 LIKE type_t.chr1000, 
   l_indj013_inab003 LIKE type_t.chr1000, 
   l_indj016_inab003 LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       type LIKE type_t.chr1          #列印对象类型
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
#str--add by yany 161028
TYPE sr5_r RECORD
   indidocno  LIKE indi_t.indidocno,          #單號 
   item       LIKE imaa_t.imaa001,            #料件编号
   imaal003   LIKE imaal_t.imaal003,          #品名
   indj001    LIKE indj_t.indj001,            #需求单号
   indj020    LIKE indj_t.indj020,            #需求对象
   x_pmaal003 LIKE pmaal_t.pmaal003,          #对象名称
   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
   #161109-00078#4 20161114 mark by beckxie---S
   #indj0091   LIKE indj_t.indj009,            #數量1
   #indj0092   LIKE indj_t.indj009,            #數量2
   #indj0093   LIKE indj_t.indj009,            #數量3
   #indj0094   LIKE indj_t.indj009,            #數量4
   #indj0095   LIKE indj_t.indj009,            #數量5
   #indj0096   LIKE indj_t.indj009,            #數量6
   #indj0097   LIKE indj_t.indj009,            #數量7
   #indj0098   LIKE indj_t.indj009,            #數量8
   #indj0099   LIKE indj_t.indj009,            #數量9
   #indj0090   LIKE indj_t.indj009,            #數量10
   #161109-00078#4 20161114 mark by beckxie---E
   #161109-00078#4 20161114 add by beckxie---S
   indj0101   LIKE indj_t.indj010,            #數量1
   indj0102   LIKE indj_t.indj010,            #數量2
   indj0103   LIKE indj_t.indj010,            #數量3
   indj0104   LIKE indj_t.indj010,            #數量4
   indj0105   LIKE indj_t.indj010,            #數量5
   indj0106   LIKE indj_t.indj010,            #數量6
   indj0107   LIKE indj_t.indj010,            #數量7
   indj0108   LIKE indj_t.indj010,            #數量8
   indj0109   LIKE indj_t.indj010,            #數量9
   indj0100   LIKE indj_t.indj010,            #數量10
   #161109-00078#4 20161114 add by beckxie---E
   l_skip     LIKE type_t.chr1,
   condition1 LIKE type_t.chr1000,
   condition2 LIKE type_t.chr1000
 END RECORD
DEFINE g_inam014        ARRAY[10] OF VARCHAR(1000)
DEFINE l_total          LIKE type_t.num10
TYPE r_sum   RECORD 
                 #161109-00078#4 20161114 mark by beckxie---S
                 #sum01  LIKE indj_t.indj009,
                 #sum02  LIKE indj_t.indj009,
                 #sum03  LIKE indj_t.indj009,
                 #sum04  LIKE indj_t.indj009,
                 #sum05  LIKE indj_t.indj009,
                 #sum06  LIKE indj_t.indj009,
                 #sum07  LIKE indj_t.indj009,
                 #sum08  LIKE indj_t.indj009,
                 #sum09  LIKE indj_t.indj009,
                 #sum10  LIKE indj_t.indj009,
                 #sum11  LIKE indj_t.indj009
                 #161109-00078#4 20161114 mark by beckxie---E
                 #161109-00078#4 20161114 add by beckxie---S
                 sum01  LIKE indj_t.indj010,
                 sum02  LIKE indj_t.indj010,
                 sum03  LIKE indj_t.indj010,
                 sum04  LIKE indj_t.indj010,
                 sum05  LIKE indj_t.indj010,
                 sum06  LIKE indj_t.indj010,
                 sum07  LIKE indj_t.indj010,
                 sum08  LIKE indj_t.indj010,
                 sum09  LIKE indj_t.indj010,
                 sum10  LIKE indj_t.indj010,
                 sum11  LIKE indj_t.indj010
                 #161109-00078#4 20161114 add by beckxie---E
             END RECORD

TYPE r_tot   RECORD 
                 #161109-00078#4 20161114 mark by beckxie---S
                 #tot01  LIKE indj_t.indj009,
                 #tot02  LIKE indj_t.indj009,
                 #tot03  LIKE indj_t.indj009,
                 #tot04  LIKE indj_t.indj009,
                 #tot05  LIKE indj_t.indj009,
                 #tot06  LIKE indj_t.indj009,
                 #tot07  LIKE indj_t.indj009,
                 #tot08  LIKE indj_t.indj009,
                 #tot09  LIKE indj_t.indj009,
                 #tot10  LIKE indj_t.indj009,
                 #tot11  LIKE indj_t.indj009
                 #161109-00078#4 20161114 mark by beckxie---E
                 #161109-00078#4 20161114 add by beckxie---S
                 tot01  LIKE indj_t.indj010,
                 tot02  LIKE indj_t.indj010,
                 tot03  LIKE indj_t.indj010,
                 tot04  LIKE indj_t.indj010,
                 tot05  LIKE indj_t.indj010,
                 tot06  LIKE indj_t.indj010,
                 tot07  LIKE indj_t.indj010,
                 tot08  LIKE indj_t.indj010,
                 tot09  LIKE indj_t.indj010,
                 tot10  LIKE indj_t.indj010,
                 tot11  LIKE indj_t.indj010
                 #161109-00078#4 20161114 add by beckxie---E
             END RECORD
#end--add by yany 161028
DEFINE g_indidocno      STRING   #161109-00078#4 20161114 add by beckxie
DEFINE g_indidocdt      STRING   #161109-00078#4 20161114 add by beckxie
#end add-point
 
{</section>}
 
{<section id="ainr705_g02.main" readonly="Y" >}
PUBLIC FUNCTION ainr705_g02(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.type  列印对象类型
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.type = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "ainr705_g02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr705_g02_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr705_g02_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr705_g02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr705_g02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr705_g02_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT NULL,NULL,NULL,NULL,indi000,indi001,indi002,indi003,indi004,indi005,indi006, 
       indi007,indidocdt,indidocno,indient,indisite,indistus,indiunit,indj001,indj002,indj003,indj004, 
       indj005,indj006,indj007,indj008,indj009,indj010,indj011,indj012,indj013,indj014,indj015,indj016, 
       indj017,indj018,indj019,indj020,indjseq,indjsite,indjunit,( SELECT dbabl003 FROM dbabl_t WHERE dbabl_t.dbabl001 = indi_t.indi002 AND dbabl_t.dbablent = indi_t.indient AND dbabl_t.dbabl002 = '" , 
       g_dlang,"'" ,"),( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = indi_t.indi003 AND ooag_t.ooagent = indi_t.indient), 
       ( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indi_t.indi004 AND ooefl_t.ooeflent = indi_t.indient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indi_t.indiunit AND ooefl_t.ooeflent = indi_t.indient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indi_t.indisite AND ooefl_t.ooeflent = indi_t.indient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,"),x.t4_ooefl003,x.t7_ooefl003,x.t8_ooefl003,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '274' AND oocql_t.oocql002 = indi_t.indi006 AND oocql_t.oocqlent = indi_t.indient AND oocql_t.oocql003 = '" , 
       g_dlang,"'" ,"),x.imaal_t_imaal003,x.oocal_t_oocal003,x.t6_oocal003,x.inayl_t_inayl003,x.t5_inayl003, 
       x.inab_t_inab003,x.t3_inab003,x.pmaal_t_pmaal003,trim(indiunit)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indi_t.indiunit AND ooefl_t.ooeflent = indi_t.indient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(indi003)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = indi_t.indi003 AND ooag_t.ooagent = indi_t.indient)), 
       trim(indi004)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indi_t.indi004 AND ooefl_t.ooeflent = indi_t.indient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(indisite)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indi_t.indisite AND ooefl_t.ooeflent = indi_t.indient AND ooefl_t.ooefl002 = '" , 
       g_dlang,"'" ,")),trim(indjunit)||'.'||trim(x.t7_ooefl003),trim(indj003)||'.'||trim(x.t8_ooefl003), 
       trim(indj012)||'.'||trim(x.t5_inayl003),trim(indjsite)||'.'||trim(x.t4_ooefl003),trim(indj020)||'.'||trim(x.pmaal_t_pmaal003), 
       trim(indj015)||'.'||trim(x.inayl_t_inayl003),trim(indj013)||'.'||trim(x.inab_t_inab003),trim(indj016)||'.'||trim(x.t3_inab003)" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM indi_t LEFT OUTER JOIN ( SELECT indj_t.*,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indj_t.indjsite AND ooefl_t.ooeflent = indj_t.indjent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t4_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indj_t.indjunit AND ooefl_t.ooeflent = indj_t.indjent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t7_ooefl003,( SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = indj_t.indj003 AND ooefl_t.ooeflent = indj_t.indjent AND ooefl_t.ooefl002 = '" , 
        g_dlang,"'" ,") t8_ooefl003,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = indj_t.indj004 AND imaal_t.imaalent = indj_t.indjent AND imaal_t.imaal002 = '" , 
        g_dlang,"'" ,") imaal_t_imaal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = indj_t.indj008 AND oocal_t.oocalent = indj_t.indjent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") oocal_t_oocal003,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = indj_t.indj006 AND oocal_t.oocalent = indj_t.indjent AND oocal_t.oocal002 = '" , 
        g_dlang,"'" ,") t6_oocal003,( SELECT inayl003 FROM inayl_t WHERE inayl_t.inayl001 = indj_t.indj015 AND inayl_t.inaylent = indj_t.indjent AND inayl_t.inayl002 = '" , 
        g_dlang,"'" ,") inayl_t_inayl003,( SELECT inayl003 FROM inayl_t WHERE inayl_t.inayl001 = indj_t.indj012 AND inayl_t.inaylent = indj_t.indjent AND inayl_t.inayl002 = '" , 
        g_dlang,"'" ,") t5_inayl003,( SELECT inab003 FROM inab_t WHERE inab_t.inabsite = indj_t.indjsite AND inab_t.inab001 = indj_t.indj012 AND inab_t.inab002 = indj_t.indj013 AND inab_t.inabent = indj_t.indjent) inab_t_inab003, 
        ( SELECT inab003 FROM inab_t WHERE inab_t.inabsite = indj_t.indjsite AND inab_t.inab001 = indj_t.indj015 AND inab_t.inab002 = indj_t.indj016 AND inab_t.inabent = indj_t.indjent) t3_inab003, 
        ( SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = indj_t.indj020 AND pmaal_t.pmaalent = indj_t.indjent AND pmaal_t.pmaal002 = '" , 
        g_dlang,"'" ,") pmaal_t_pmaal003 FROM indj_t ) x  ON indi_t.indient = x.indjent AND indi_t.indidocno  
        = x.indjdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc ," AND indj010 != 0 "   #161017-00051#13 20161122 add by beckxie
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
    LET g_order = " ORDER BY indidocno,indj004"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("indi_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr705_g02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr705_g02_curs CURSOR FOR ainr705_g02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr705_g02.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr705_g02_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_indidocno LIKE type_t.chr1000, 
   l_indidocdt LIKE type_t.chr1000, 
   l_condition1 LIKE type_t.chr1000, 
   l_condition2 LIKE type_t.chr1000, 
   indi000 LIKE indi_t.indi000, 
   indi001 LIKE indi_t.indi001, 
   indi002 LIKE indi_t.indi002, 
   indi003 LIKE indi_t.indi003, 
   indi004 LIKE indi_t.indi004, 
   indi005 LIKE indi_t.indi005, 
   indi006 LIKE indi_t.indi006, 
   indi007 LIKE indi_t.indi007, 
   indidocdt LIKE indi_t.indidocdt, 
   indidocno LIKE indi_t.indidocno, 
   indient LIKE indi_t.indient, 
   indisite LIKE indi_t.indisite, 
   indistus LIKE indi_t.indistus, 
   indiunit LIKE indi_t.indiunit, 
   indj001 LIKE indj_t.indj001, 
   indj002 LIKE indj_t.indj002, 
   indj003 LIKE indj_t.indj003, 
   indj004 LIKE indj_t.indj004, 
   indj005 LIKE indj_t.indj005, 
   indj006 LIKE indj_t.indj006, 
   indj007 LIKE indj_t.indj007, 
   indj008 LIKE indj_t.indj008, 
   indj009 LIKE indj_t.indj009, 
   indj010 LIKE indj_t.indj010, 
   indj011 LIKE indj_t.indj011, 
   indj012 LIKE indj_t.indj012, 
   indj013 LIKE indj_t.indj013, 
   indj014 LIKE indj_t.indj014, 
   indj015 LIKE indj_t.indj015, 
   indj016 LIKE indj_t.indj016, 
   indj017 LIKE indj_t.indj017, 
   indj018 LIKE indj_t.indj018, 
   indj019 LIKE indj_t.indj019, 
   indj020 LIKE indj_t.indj020, 
   indjseq LIKE indj_t.indjseq, 
   indjsite LIKE indj_t.indjsite, 
   indjunit LIKE indj_t.indjunit, 
   dbabl_t_dbabl003 LIKE dbabl_t.dbabl003, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   t1_ooefl003 LIKE ooefl_t.ooefl003, 
   t2_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t4_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t7_ooefl003 LIKE ooefl_t.ooefl003, 
   x_t8_ooefl003 LIKE ooefl_t.ooefl003, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   x_t6_oocal003 LIKE oocal_t.oocal003, 
   x_inayl_t_inayl003 LIKE inayl_t.inayl003, 
   x_t5_inayl003 LIKE inayl_t.inayl003, 
   x_inab_t_inab003 LIKE inab_t.inab003, 
   x_t3_inab003 LIKE inab_t.inab003, 
   x_pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   l_indiunit_ooefl003 LIKE type_t.chr1000, 
   l_indi003_ooag011 LIKE type_t.chr300, 
   l_indi004_ooefl003 LIKE type_t.chr1000, 
   l_indisite_ooefl003 LIKE type_t.chr1000, 
   l_indjunit_ooefl003 LIKE type_t.chr1000, 
   l_indj003_ooefl003 LIKE type_t.chr1000, 
   l_indj012_inayl003 LIKE type_t.chr1000, 
   l_indjsite_ooefl003 LIKE type_t.chr1000, 
   l_indj020_pmaal003 LIKE type_t.chr300, 
   l_indj015_inayl003 LIKE type_t.chr1000, 
   l_indj013_inab003 LIKE type_t.chr1000, 
   l_indj016_inab003 LIKE type_t.chr1000
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#str--add by yany 2016/10/28
DEFINE l_colorsize      LIKE type_t.chr100
DEFINE l_indj005_desc   LIKE type_t.chr100
DEFINE l_inam012        LIKE type_t.chr1000
DEFINE l_inam014        LIKE type_t.chr1000
DEFINE l_inam018        LIKE type_t.chr1000
DEFINE l_inam012_desc   LIKE type_t.chr100
DEFINE l_inam014_desc   LIKE type_t.chr100
DEFINE l_inam018_desc   LIKE type_t.chr100
DEFINE l_imec003        LIKE imec_t.imec003
DEFINE l_imaa005        LIKE imaa_t.imaa005
DEFINE l_imeb012        LIKE imeb_t.imeb012
DEFINE l_imecl005       LIKE imecl_t.imecl005
DEFINE tok              base.StringTokenizer
DEFINE l_cnt2           LIKE type_t.num10
DEFINE l_success        LIKE type_t.num5
#end--add by yany 2016/10/28
#161109-00078#4 20161114 add by beckxie---S
DEFINE l_sql            STRING   
DEFINE l_i              LIKE type_t.num5
DEFINE l_indj020        LIKE indj_t.indj020
DEFINE l_indidocno      STRING
DEFINE l_indidocdt      STRING
#161109-00078#4 20161114 add by beckxie---E
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #str--add by yany 2016/10/28
    CALL ainr705_g02_erwei_tmp_table()   
    #161109-00078#4 20161114 modify(indj009改為indj010) by beckxie---S
    #LET g_sql = " INSERT INTO ainr705_g02_temp01(indidocno,item,imaal003,indj001,indj020,pmaal003,inam012,inam014,inam018,indj009,condition1,condition2) VALUES (?,?,?,?,?,?,?,?,?,?,?,?) "
    LET g_sql = " INSERT INTO ainr705_g02_temp01(indidocno,item,imaal003,indj001,indj020,pmaal003,inam012,inam014,inam018,indj010,condition1,condition2) VALUES (?,?,?,?,?,?,?,?,?,?,?,?) "
    #161109-00078#4 20161114 modify(indj009改為indj010) by beckxie---E
    PREPARE master_tmp FROM g_sql   
    
    #end--add by yany 2016/10/28
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ainr705_g02_curs INTO sr_s.*
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
       #str--add by yany 2016/10/28
#       #取特征值（颜色+尺码）
#       CALL s_feature_description(sr_s.indj004,sr_s.indj005) RETURNING l_success,l_colorsize
#       LET l_indj005_desc = l_colorsize
       #若品名为空，赋值料件编号
       IF cl_null(sr_s.x_imaal_t_imaal003) THEN
          LET sr_s.x_imaal_t_imaal003 = sr_s.indj004
       END IF
       IF tm.type = '1' THEN   #门店
          SELECT ooefl003 INTO sr_s.x_pmaal_t_pmaal003 FROM ooefl_t WHERE ooeflent = g_enterprise and ooefl001 = sr_s.indj020 and ooefl002 = 'zh_CN'
       ELSE                    #客户
          SELECT pmaal003 INTO sr_s.x_pmaal_t_pmaal003 FROM pmaal_t WHERE pmaalent = g_enterprise and pmaal001 = sr_s.indj020 and pmaal002 = 'zh_CN'
       END IF       
       #end--add by yany 2016/07/20
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_indidocno = sr_s.l_indidocno
       LET sr[l_cnt].l_indidocdt = sr_s.l_indidocdt
       LET sr[l_cnt].l_condition1 = sr_s.l_condition1
       LET sr[l_cnt].l_condition2 = sr_s.l_condition2
       LET sr[l_cnt].indi000 = sr_s.indi000
       LET sr[l_cnt].indi001 = sr_s.indi001
       LET sr[l_cnt].indi002 = sr_s.indi002
       LET sr[l_cnt].indi003 = sr_s.indi003
       LET sr[l_cnt].indi004 = sr_s.indi004
       LET sr[l_cnt].indi005 = sr_s.indi005
       LET sr[l_cnt].indi006 = sr_s.indi006
       LET sr[l_cnt].indi007 = sr_s.indi007
       LET sr[l_cnt].indidocdt = sr_s.indidocdt
       LET sr[l_cnt].indidocno = sr_s.indidocno
       LET sr[l_cnt].indient = sr_s.indient
       LET sr[l_cnt].indisite = sr_s.indisite
       LET sr[l_cnt].indistus = sr_s.indistus
       LET sr[l_cnt].indiunit = sr_s.indiunit
       LET sr[l_cnt].indj001 = sr_s.indj001
       LET sr[l_cnt].indj002 = sr_s.indj002
       LET sr[l_cnt].indj003 = sr_s.indj003
       LET sr[l_cnt].indj004 = sr_s.indj004
       LET sr[l_cnt].indj005 = sr_s.indj005
       LET sr[l_cnt].indj006 = sr_s.indj006
       LET sr[l_cnt].indj007 = sr_s.indj007
       LET sr[l_cnt].indj008 = sr_s.indj008
       LET sr[l_cnt].indj009 = sr_s.indj009
       LET sr[l_cnt].indj010 = sr_s.indj010
       LET sr[l_cnt].indj011 = sr_s.indj011
       LET sr[l_cnt].indj012 = sr_s.indj012
       LET sr[l_cnt].indj013 = sr_s.indj013
       LET sr[l_cnt].indj014 = sr_s.indj014
       LET sr[l_cnt].indj015 = sr_s.indj015
       LET sr[l_cnt].indj016 = sr_s.indj016
       LET sr[l_cnt].indj017 = sr_s.indj017
       LET sr[l_cnt].indj018 = sr_s.indj018
       LET sr[l_cnt].indj019 = sr_s.indj019
       LET sr[l_cnt].indj020 = sr_s.indj020
       LET sr[l_cnt].indjseq = sr_s.indjseq
       LET sr[l_cnt].indjsite = sr_s.indjsite
       LET sr[l_cnt].indjunit = sr_s.indjunit
       LET sr[l_cnt].dbabl_t_dbabl003 = sr_s.dbabl_t_dbabl003
       LET sr[l_cnt].ooag_t_ooag011 = sr_s.ooag_t_ooag011
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].t1_ooefl003 = sr_s.t1_ooefl003
       LET sr[l_cnt].t2_ooefl003 = sr_s.t2_ooefl003
       LET sr[l_cnt].x_t4_ooefl003 = sr_s.x_t4_ooefl003
       LET sr[l_cnt].x_t7_ooefl003 = sr_s.x_t7_ooefl003
       LET sr[l_cnt].x_t8_ooefl003 = sr_s.x_t8_ooefl003
       LET sr[l_cnt].oocql_t_oocql004 = sr_s.oocql_t_oocql004
       LET sr[l_cnt].x_imaal_t_imaal003 = sr_s.x_imaal_t_imaal003
       LET sr[l_cnt].x_oocal_t_oocal003 = sr_s.x_oocal_t_oocal003
       LET sr[l_cnt].x_t6_oocal003 = sr_s.x_t6_oocal003
       LET sr[l_cnt].x_inayl_t_inayl003 = sr_s.x_inayl_t_inayl003
       LET sr[l_cnt].x_t5_inayl003 = sr_s.x_t5_inayl003
       LET sr[l_cnt].x_inab_t_inab003 = sr_s.x_inab_t_inab003
       LET sr[l_cnt].x_t3_inab003 = sr_s.x_t3_inab003
       LET sr[l_cnt].x_pmaal_t_pmaal003 = sr_s.x_pmaal_t_pmaal003
       LET sr[l_cnt].l_indiunit_ooefl003 = sr_s.l_indiunit_ooefl003
       LET sr[l_cnt].l_indi003_ooag011 = sr_s.l_indi003_ooag011
       LET sr[l_cnt].l_indi004_ooefl003 = sr_s.l_indi004_ooefl003
       LET sr[l_cnt].l_indisite_ooefl003 = sr_s.l_indisite_ooefl003
       LET sr[l_cnt].l_indjunit_ooefl003 = sr_s.l_indjunit_ooefl003
       LET sr[l_cnt].l_indj003_ooefl003 = sr_s.l_indj003_ooefl003
       LET sr[l_cnt].l_indj012_inayl003 = sr_s.l_indj012_inayl003
       LET sr[l_cnt].l_indjsite_ooefl003 = sr_s.l_indjsite_ooefl003
       LET sr[l_cnt].l_indj020_pmaal003 = sr_s.l_indj020_pmaal003
       LET sr[l_cnt].l_indj015_inayl003 = sr_s.l_indj015_inayl003
       LET sr[l_cnt].l_indj013_inab003 = sr_s.l_indj013_inab003
       LET sr[l_cnt].l_indj016_inab003 = sr_s.l_indj016_inab003
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #str--add by yany 2016/10/28
       
       #LET sr_s.l_condition1 = "-",sr_s.indidocno,"-",sr_s.indj020,"-"   #161109-00078#4 20161114 mark by beckxie
       LET sr_s.l_condition1 = "-",sr_s.indj020,"-"   #161109-00078#4 20161114 add by beckxie
       LET sr[l_cnt].l_condition1 = sr_s.l_condition1
       
       SELECT imaa005 INTO sr_s.l_condition2 FROM imaa_t
        WHERE imaa001 = sr_s.indj004
          AND imaaent = g_enterprise
       IF cl_null(sr_s.l_condition2) THEN
          LET sr_s.l_condition2 = 'TMP'
       END IF 
       LET sr[l_cnt].l_condition2 = sr_s.l_condition2
       
       
       IF NOT cl_null(sr_s.indj005) THEN   #存在特征值
          LET l_imaa005 = NULL
          SELECT imaa005 INTO l_imaa005 FROM imaa_t 
           WHERE imaaent = g_enterprise 
             and imaa001 = sr_s.indj004
          LET l_inam012 = NULL
          LET l_inam014 = NULL
          LET l_inam018 = NULL
       
       #分别取颜色和尺码特征值
       LET l_cnt2 = 1
       LET tok = base.StringTokenizer.createExt(sr_s.indj005,'_','',TRUE)
       WHILE tok.hasMoreTokens()
           LET l_imec003 = tok.nextToken()
           LET l_imeb012 = 'N'
           SELECT imeb012 INTO l_imeb012 FROM imeb_t
            WHERE imebent = g_enterprise 
              AND imeb002 = l_cnt2
              AND imeb001 = l_imaa005
           case l_imeb012
              #纵向
              when 'N'
                 LET l_imecl005 = NULL
                 SELECT imecl005 INTO l_imecl005 FROM imec_t LEFT OUTER JOIN imecl_t 
                     ON imecent = imeclent AND imec001 = imecl001 AND imec002 = imecl002 AND imec003 = imecl003  AND imecl004 = g_lang
                  WHERE imecent = g_enterprise AND imec001 = l_imaa005 AND imec002 = l_cnt2
                    AND imec003 = l_imec003 AND imecstus = 'Y'
                 IF cl_null(l_inam012) THEN
                    LET l_inam012 = l_imec003,'·',l_imecl005
                 ELSE
                    LET l_inam012 = l_inam012,'/',l_imec003,'·',l_imecl005
                 END IF 
              #横向
              when 'Y'
                 LET l_imecl005 = NULL
                 SELECT imecl005 INTO l_imecl005 FROM imec_t
                   LEFT OUTER JOIN imecl_t
                     ON imecent=imeclent AND imec001=imecl001 AND imec002=imecl002 AND imec003=imecl003  AND imecl004=g_lang
                  WHERE imecent = g_enterprise AND imec001 = l_imaa005 AND imec002 = l_cnt2
                    AND imec003 = l_imec003 AND imecstus = 'Y'
                 LET l_inam014 = l_imec003,'-',l_imecl005
              otherwise
                 exit while
           end case 
           LET l_cnt2 = l_cnt2 + 1
       END WHILE
        
       IF NOT cl_null(l_inam012) AND cl_null(l_inam014) THEN
          LET l_inam014 = "t-*"
       END IF
       IF NOT cl_null(l_inam012) AND NOT cl_null(l_inam014) THEN
           #161109-00078#4 20161114 mark by beckxie---S
           #EXECUTE master_tmp USING sr_s.indidocno,sr_s.indj004,sr_s.x_imaal_t_imaal003,sr_s.indj001,sr_s.indj020,
           #                         sr_s.x_pmaal_t_pmaal003,l_inam012,l_inam014,l_inam018,sr_s.indj009,
           #                         sr_s.l_condition1,sr_s.l_condition2                     
           #161109-00078#4 20161114 mark by beckxie---E
           #161109-00078#4 20161114 add by beckxie---S
           EXECUTE master_tmp USING sr_s.indidocno,sr_s.indj004,sr_s.x_imaal_t_imaal003,sr_s.indj001,sr_s.indj020,
                                    sr_s.x_pmaal_t_pmaal003,l_inam012,l_inam014,l_inam018,sr_s.indj010,
                                    sr_s.l_condition1,sr_s.l_condition2                     
           #161109-00078#4 20161114 add by beckxie---E
       END IF
       ELSE
          LET l_inam012='-'
          LET l_inam014='-'
          LET l_inam018=''
          #161109-00078#4 20161114 mark by beckxie---S
          #EXECUTE master_tmp USING sr_s.indidocno,sr_s.indj004,sr_s.x_imaal_t_imaal003,sr_s.indj001,sr_s.indj020,
          #                         sr_s.x_pmaal_t_pmaal003,l_inam012,l_inam014,l_inam018,sr_s.indj009,
          #                         sr_s.l_condition1,sr_s.l_condition2 
          #161109-00078#4 20161114 mark by beckxie---E
          #161109-00078#4 20161114 add by beckxie---S
          EXECUTE master_tmp USING sr_s.indidocno,sr_s.indj004,sr_s.x_imaal_t_imaal003,sr_s.indj001,sr_s.indj020,
                                   sr_s.x_pmaal_t_pmaal003,l_inam012,l_inam014,l_inam018,sr_s.indj010,
                                   sr_s.l_condition1,sr_s.l_condition2 
          #161109-00078#4 20161114 add by beckxie---E
       END IF
       #end--add by yany 2016/10/28
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    #161109-00078#4 20161114 add by beckxie---S
    LET l_sql = " SELECT DISTINCT indj020 FROM ainr705_g02_temp01 "
    
    PREPARE ainr705_g02_sel_indj_pre FROM l_sql
    IF STATUS THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = 'ainr705_g02_sel_indj_pre:'
       LET g_errparam.code   = STATUS
       LET g_errparam.popup  = TRUE
       CALL cl_err()   
    END IF
    DECLARE ainr705_g02_sel_indj_cur CURSOR FOR ainr705_g02_sel_indj_pre
    LET l_indj020 = ''
    FOREACH ainr705_g02_sel_indj_cur INTO l_indj020
       
       LET l_indidocno = ''
       LET l_indidocdt = ''
       CALL ainr705_g02_get_string(l_indj020) RETURNING l_indidocno,l_indidocdt
       
       FOR l_i = 1 TO sr.getLength()
          IF sr[l_i].indj020 = l_indj020 OR ( cl_null(sr[l_i].indj020) AND cl_null(l_indj020) ) THEN
             #將組好的單號 ,日期 更新回欄位上
             LET sr[l_i].l_indidocno = l_indidocno
             LET sr[l_i].l_indidocdt = l_indidocdt
          END IF
       END FOR
       
       LET l_indj020 = ''
    END FOREACH
    #161109-00078#4 20161114 add by beckxie---E
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr705_g02.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr705_g02_rep_data()
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
          START REPORT ainr705_g02_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr705_g02_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr705_g02_rep
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
 
{<section id="ainr705_g02.rep" readonly="Y" >}
PRIVATE REPORT ainr705_g02_rep(sr1)
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
#str--add by yany 2016/10/28
DEFINE sr5              sr5_r
DEFINE l_tot            r_tot
DEFINE l_sum            r_sum
DEFINE l_sql            STRING      
DEFINE l_inam014_cnt    LIKE type_t.num10
DEFINE l_pageno         LIKE type_t.num10
DEFINE l_i              LIKE type_t.num10
DEFINE l_inam014        LIKE type_t.chr1000 
DEFINE l_item           LIKE type_t.chr1000
#DEFINE l_indj009_sum    LIKE indj_t.indj009   #161109-00078#4 20161114 mark by beckxie
DEFINE l_indj010_sum    LIKE indj_t.indj010    #161109-00078#4 20161114 add by beckxie
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_repheader_show LIKE type_t.chr1
DEFINE l_old_condition1 LIKE type_t.chr1000
#end--add by yany 2016/10/28
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_condition1,sr1.indj020,sr1.l_condition2
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
        BEFORE GROUP OF sr1.l_condition1
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            INITIALIZE l_tot.* TO NULL   #20161117 add by beckxie
            #str--add by yany 2016/10/29
            #调整报表表头名称
            IF tm.type = '1' THEN
               LET g_grPageHeader.title0201 = "门店现货拣货单"
            ELSE
               LET g_grPageHeader.title0201 = "客户现货拣货单"
            END IF
            #end--add by yany 2016/10/29
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_condition1
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
 
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'indient=' ,sr1.indient,'{+}indidocno=' ,sr1.indidocno         
            CALL cl_gr_init_apr(sr1.l_condition1)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_condition1.before name="rep.b_group.l_condition1.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.indient CLIPPED ,"'", " AND  ooff003 = '", sr1.l_condition1 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr705_g02_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr705_g02_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr705_g02_subrep01
           DECLARE ainr705_g02_repcur01 CURSOR FROM g_sql
           FOREACH ainr705_g02_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr705_g02_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr705_g02_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr705_g02_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_condition1.after name="rep.b_group.l_condition1.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.indj020
 
           #add-point:rep.b_group.indj020.before name="rep.b_group.indj020.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.indj020.after name="rep.b_group.indj020.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_condition2
 
           #add-point:rep.b_group.l_condition2.before name="rep.b_group.l_condition2.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_condition2.after name="rep.b_group.l_condition2.after"
           
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
                sr1.indient CLIPPED ,"'", " AND  ooff003 = '", sr1.l_condition1 CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr705_g02_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr705_g02_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr705_g02_subrep02
           DECLARE ainr705_g02_repcur02 CURSOR FROM g_sql
           FOREACH ainr705_g02_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr705_g02_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr705_g02_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr705_g02_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #str--add by yany 2016/11/04
#          LET l_repheader_show = 'N'          
#          IF (l_old_condition1 <> sr1.l_condition1 AND NOT cl_null(l_old_condition1)) OR cl_null(l_old_condition1) THEN
#             LET l_repheader_show = 'Y' 
#          END IF
#          LET l_old_condition1 = sr1.l_condition1
#          PRINTX l_repheader_show
          #end--add by yany 2016/11/04
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
                sr1.indient CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr705_g02_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr705_g02_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr705_g02_subrep03
           DECLARE ainr705_g02_repcur03 CURSOR FROM g_sql
           FOREACH ainr705_g02_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr705_g02_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr705_g02_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr705_g02_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_condition1
 
           #add-point:rep.a_group.l_condition1.before name="rep.a_group.l_condition1.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.indient CLIPPED ,"'", " AND  ooff003 = '", sr1.l_condition1 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr705_g02_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr705_g02_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr705_g02_subrep04
           DECLARE ainr705_g02_repcur04 CURSOR FROM g_sql
           FOREACH ainr705_g02_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr705_g02_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr705_g02_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr705_g02_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_condition1.after name="rep.a_group.l_condition1.after"
                         
           PRINTX l_tot.*   
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.indj020
 
           #add-point:rep.a_group.indj020.before name="rep.a_group.indj020.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.indj020.after name="rep.a_group.indj020.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_condition2
 
           #add-point:rep.a_group.l_condition2.before name="rep.a_group.l_condition2.before"
           #str--add by yany 2016/10/28
            DROP TABLE inam014_tmp
           CREATE TEMP TABLE inam014_tmp
           (
              i          decimal(5,0),
              inam014    LIKE type_t.chr1000
           )

           DROP TABLE indj_print_tmp         
           CREATE TEMP TABLE indj_print_tmp
           (
           indidocno  LIKE indi_t.indidocno,          #單號
           item       LIKE imaa_t.imaa001,            #料件编号           
           imaal003   LIKE imaal_t.imaal003,          #品名
           indj001    LIKE indj_t.indj001,            #需求单号
           indj020    LIKE indj_t.indj020,            #需求对象
           pmaal003   LIKE pmaal_t.pmaal003,          #对象名称
           inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
           inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
           inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)
           #161109-00078#4 20161114 mark by beckxie---S
           #indj0091   LIKE indj_t.indj009,            #數量1
           #indj0092   LIKE indj_t.indj009,            #數量2
           #indj0093   LIKE indj_t.indj009,            #數量3
           #indj0094   LIKE indj_t.indj009,            #數量4
           #indj0095   LIKE indj_t.indj009,            #數量5
           #indj0096   LIKE indj_t.indj009,            #數量6
           #indj0097   LIKE indj_t.indj009,            #數量7
           #indj0098   LIKE indj_t.indj009,            #數量8
           #indj0099   LIKE indj_t.indj009,            #數量9
           #indj0090   LIKE indj_t.indj009,            #數量10
           #161109-00078#4 20161114 mark by beckxie---E
           #161109-00078#4 20161114 add by beckxie---S
           indj0101   LIKE indj_t.indj010,            #數量1
           indj0102   LIKE indj_t.indj010,            #數量2
           indj0103   LIKE indj_t.indj010,            #數量3
           indj0104   LIKE indj_t.indj010,            #數量4
           indj0105   LIKE indj_t.indj010,            #數量5
           indj0106   LIKE indj_t.indj010,            #數量6
           indj0107   LIKE indj_t.indj010,            #數量7
           indj0108   LIKE indj_t.indj010,            #數量8
           indj0109   LIKE indj_t.indj010,            #數量9
           indj0100   LIKE indj_t.indj010,            #數量10
           #161109-00078#4 20161114 add by beckxie---E
           l_skip     LIKE type_t.chr1,
           condition1 LIKE type_t.chr1000,
           condition2 LIKE type_t.chr1000
           )

           LET l_sub_sql = " SELECT DISTINCT inam014 FROM ainr705_g02_temp01 ",
                         # "  WHERE indidocno =? and imaal003 =?  and item =? and condition1 = ?",
                           #"  WHERE indidocno =? and condition1 = ? and condition2 = ? ",   #161109-00078#4 20161115 mark by beckxie
                           "  WHERE condition1 = ? and condition2 = ? ",                     #161109-00078#4 20161115 add by beckxie
                           "  ORDER BY inam014 "
           PREPARE inam014_ins FROM l_sub_sql
           DECLARE inam014_ins_cs CURSOR FOR inam014_ins

           #計算橫軸個數
           LET l_sql = "SELECT COUNT(1) FROM (",l_sub_sql,")"
           PREPARE inam014_cnt_pre FROM l_sql            
         # EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.indidocno,sr1.x_imaal_t_imaal003,sr1.indj004,sr1.l_condition1
           #EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.indidocno,sr1.l_condition1,sr1.l_condition2   #161109-00078#4 20161115 mark by beckxie
           EXECUTE inam014_cnt_pre INTO l_inam014_cnt USING sr1.l_condition1,sr1.l_condition2                  #161109-00078#4 20161115 add by beckxie
           FREE inam014_cnt_pre
             
           --总合计  
           #161109-00078#4 20161114 mark by beckxie---S
           #LET l_sub_sql = " SELECT SUM(indj009) FROM ainr705_g02_temp01 ",
           #                "  WHERE indidocno = ? "
           #PREPARE indj009_total_sum FROM l_sub_sql        
           #161109-00078#4 20161114 mark by beckxie---E
           #161109-00078#4 20161114 add by beckxie---S
           LET l_sub_sql = " SELECT SUM(indj010) FROM ainr705_g02_temp01 ",
                           #"  WHERE indidocno = ? "   #161109-00078#4 20161115 mark by beckxie
                           "  WHERE condition1 = ? "   #161109-00078#4 20161115 add by beckxie
           PREPARE indj010_total_sum FROM l_sub_sql        
           #161109-00078#4 20161114 add by beckxie---E
              
           IF NOT cl_null(l_inam014_cnt) THEN
              LET l_pageno = (l_inam014_cnt -1)/10   #每頁10筆
              LET l_pageno = l_pageno +1
         
              DELETE FROM inam014_tmp WHERE 1=1
            # OPEN inam014_ins_cs USING sr1.indidocno,sr1.x_imaal_t_imaal003,sr1.indj004,sr1.l_condition1
              #OPEN inam014_ins_cs USING sr1.indidocno,sr1.l_condition1,sr1.l_condition2   #161109-00078#4 20161115 mark by beckxie
              OPEN inam014_ins_cs USING sr1.l_condition1,sr1.l_condition2                  #161109-00078#4 20161115 add by beckxie
              LET l_i =1
              FOREACH inam014_ins_cs INTO l_inam014
                 INSERT INTO inam014_tmp VALUES(l_i,l_inam014)
                 LET l_i=l_i+1
              END FOREACH
          
              FOR l_i = 1 to l_pageno
                  #161109-00078#4 20161115 mark by beckxie---S
                  #LET g_sql = " SELECT DISTINCT indidocno,imaal003,condition1,condition2,item FROM ainr705_g02_temp01 ",   
                  #            "  where indidocno = '",sr1.indidocno,"'",   
                  #161109-00078#4 20161115 mark by beckxie---E
                  #161109-00078#4 20161115 add by beckxie---S
                  LET g_sql = " SELECT DISTINCT imaal003,condition1,condition2,item FROM ainr705_g02_temp01 ",   
                              "  where 1=1 ",   
                  #161109-00078#4 20161115 add by beckxie---E            
                              "    and condition1 = '",sr1.l_condition1,"'",
                              "    and condition2 = '",sr1.l_condition2,"'"
                  PREPARE inam014_xxx_ins FROM g_sql
                  DECLARE inam014_xxx_ins_cs CURSOR FOR inam014_xxx_ins
                  #161109-00078#4 20161115 mark by beckxie---S
                  #FOREACH inam014_xxx_ins_cs into sr1.indidocno,sr1.x_imaal_t_imaal003,sr1.l_condition1,sr1.l_condition2,sr1.indj004
                  #   CALL ainr705_g02_ins_erwei_temp(sr1.indidocno,sr1.x_imaal_t_imaal003,l_i,sr1.l_condition1,sr1.l_condition2,sr1.indj004)
                  #161109-00078#4 20161115 mark by beckxie---E   
                  #161109-00078#4 20161115 add by beckxie---S
                  FOREACH inam014_xxx_ins_cs into sr1.x_imaal_t_imaal003,sr1.l_condition1,sr1.l_condition2,sr1.indj004
                     CALL ainr705_g02_ins_erwei_temp(sr1.x_imaal_t_imaal003,l_i,sr1.l_condition1,sr1.l_condition2,sr1.indj004)
                  #161109-00078#4 20161115 add by beckxie---E
                  END FOREACH             
             END FOR  
           END IF           
          
             
         # LET g_sql = " SELECT DISTINCT A.*,'",sr1.indj004,"' FROM indj_print_tmp A WHERE 1=1 "
           LET g_sql = " SELECT DISTINCT A.*  FROM indj_print_tmp A WHERE 1=1 "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show = "N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr705_g02_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE ainr705_g02_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show = "Y"
           END IF
           --调用子报表
           PRINTX l_subrep05_show    
           
           #LET g_sql = g_sql, " ORDER BY 1,4,2 "   #161017-00051#13 20161122 mark by beckxie
           LET g_sql = g_sql, " ORDER BY item,inam012 "   #161017-00051#13 20161122 add by beckxie
           START REPORT ainr705_g02_subrep05
           DECLARE ainr705_g02_repcur05 CURSOR FROM g_sql             
              FOREACH ainr705_g02_repcur05 INTO sr5.*
                 IF STATUS THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "ainr705_g02_repcur05:"
                    LET g_errparam.code   = SQLCA.sqlcode
                    LET g_errparam.popup  = FALSE
                    CALL cl_err()                  
                    EXIT FOREACH 
                 END IF
              
                 OUTPUT TO REPORT ainr705_g02_subrep05(sr5.*) --subrep05中印出
              END FOREACH
           FINISH REPORT ainr705_g02_subrep05


           --打印总合计
           #161109-00078#4 20161114 mark by beckxie---S
           #LET l_indj009_sum = 0
           ##總計(合計)   
           #LET l_sub_sql = " SELECT SUM(indj009) FROM ainr705_g02_temp01 ",          
           #                "  WHERE indidocno =? and imaal003 =? and item =? and condition1 = ? and condition2 = ? "
           #PREPARE indj009_total FROM l_sub_sql
           #EXECUTE indj009_total INTO l_indj009_sum USING sr1.indidocno,sr1.x_imaal_t_imaal003,sr1.indj004,sr1.l_condition1,sr1.l_condition2 
           #PRINTX l_indj009_sum  
           #
           #EXECUTE indj009_total_sum INTO l_total USING sr1.indidocno
           #161109-00078#4 20161114 mark by beckxie---E
           #161109-00078#4 20161114 add by beckxie---S
           LET l_indj010_sum = 0
           #總計(合計)   
           LET l_sub_sql = " SELECT SUM(indj010) FROM ainr705_g02_temp01 ",          
                           #"  WHERE indidocno =? and imaal003 =? and item =? and condition1 = ? and condition2 = ? "   #161109-00078#4 20161115 mark by beckxie
                           "  WHERE imaal003 =? and item =? and condition1 = ? and condition2 = ? "                     #161109-00078#4 20161115 add by beckxie
                           
           PREPARE indj010_total FROM l_sub_sql
           #EXECUTE indj010_total INTO l_indj010_sum USING sr1.indidocno,sr1.x_imaal_t_imaal003,sr1.indj004,sr1.l_condition1,sr1.l_condition2 #161109-00078#4 20161115 mark by beckxie
           EXECUTE indj010_total INTO l_indj010_sum USING sr1.x_imaal_t_imaal003,sr1.indj004,sr1.l_condition1,sr1.l_condition2                #161109-00078#4 20161115 add by beckxie
           PRINTX l_indj010_sum  
           
           #EXECUTE indj010_total_sum INTO l_total USING sr1.indidocno   #161109-00078#4 20161115 mark by beckxie
           EXECUTE indj010_total_sum INTO l_total USING sr1.l_condition1 #161109-00078#4 20161115 add by beckxie
           #161109-00078#4 20161114 add by beckxie---E
           PRINTX l_total
           #end--add by yany 2016/10/28
           
           #str--add by yany 2016/11/03
           IF (NOT cl_null(l_old_condition1) AND l_old_condition1 <> sr1.l_condition1) OR cl_null(l_old_condition1) THEN
              INITIALIZE l_tot.* TO NULL
           END IF
           IF cl_null(l_tot.tot01) THEN  LET l_tot.tot01 = 0 END IF
           IF cl_null(l_tot.tot02) THEN  LET l_tot.tot02 = 0 END IF
           IF cl_null(l_tot.tot03) THEN  LET l_tot.tot03 = 0 END IF
           IF cl_null(l_tot.tot04) THEN  LET l_tot.tot04 = 0 END IF
           IF cl_null(l_tot.tot05) THEN  LET l_tot.tot05 = 0 END IF
           IF cl_null(l_tot.tot06) THEN  LET l_tot.tot06 = 0 END IF
           IF cl_null(l_tot.tot07) THEN  LET l_tot.tot07 = 0 END IF
           IF cl_null(l_tot.tot08) THEN  LET l_tot.tot08 = 0 END IF
           IF cl_null(l_tot.tot09) THEN  LET l_tot.tot09 = 0 END IF
           IF cl_null(l_tot.tot10) THEN  LET l_tot.tot10 = 0 END IF
           IF cl_null(l_tot.tot11) THEN  LET l_tot.tot11 = 0 END IF
           
           INITIALIZE l_sum.* TO NULL
           #161109-00078#4 20161114 mark by beckxie---S
           #LET g_sql = "SELECT SUM(indj0091),SUM(indj0092),SUM(indj0093),SUM(indj0094),SUM(indj0095),SUM(indj0096),SUM(indj0097),SUM(indj0098),SUM(indj0099),SUM(indj0090),0 FROM indj_print_tmp ",
           #            " WHERE condition1 = ? and indidocno = ? "
           #PREPARE indj009_tot_pr FROM g_sql
           #DECLARE indj009_tot_cs CURSOR FOR indj009_tot_pr
           #EXECUTE indj009_tot_cs INTO l_sum.* USING sr1.l_condition1,sr1.indidocno
           #161109-00078#4 20161114 mark by beckxie---E
           #161109-00078#4 20161114 add by beckxie---S
           LET g_sql = "SELECT SUM(indj0101),SUM(indj0102),SUM(indj0103),SUM(indj0104),SUM(indj0105),SUM(indj0106),SUM(indj0107),SUM(indj0108),SUM(indj0109),SUM(indj0100),0 FROM indj_print_tmp ",
                       #" WHERE condition1 = ? and indidocno = ? "   #161109-00078#4 20161115 mark by beckxie
                       " WHERE condition1 = ? "                      #161109-00078#4 20161115 add by beckxie
           PREPARE indj010_tot_pr FROM g_sql
           DECLARE indj010_tot_cs CURSOR FOR indj010_tot_pr
           #EXECUTE indj010_tot_cs INTO l_sum.* USING sr1.l_condition1,sr1.indidocno   #161109-00078#4 20161115 mark by beckxie
           EXECUTE indj010_tot_cs INTO l_sum.* USING sr1.l_condition1                  #161109-00078#4 20161115 add by beckxie
           #161109-00078#4 20161114 add by beckxie---E
           IF cl_null(l_sum.sum01) THEN LET  l_sum.sum01= 0 END IF            
           IF cl_null(l_sum.sum02) THEN LET  l_sum.sum02= 0 END IF            
           IF cl_null(l_sum.sum03) THEN LET  l_sum.sum03= 0 END IF           
           IF cl_null(l_sum.sum04) THEN LET  l_sum.sum04= 0 END IF            
           IF cl_null(l_sum.sum05) THEN LET  l_sum.sum05= 0 END IF            
           IF cl_null(l_sum.sum06) THEN LET  l_sum.sum06= 0 END IF          
           IF cl_null(l_sum.sum07) THEN LET  l_sum.sum07= 0 END IF            
           IF cl_null(l_sum.sum08) THEN LET  l_sum.sum08= 0 END IF            
           IF cl_null(l_sum.sum09) THEN LET  l_sum.sum09= 0 END IF           
           IF cl_null(l_sum.sum10) THEN LET  l_sum.sum10= 0 END IF
           
           LET l_sum.sum11 = l_sum.sum01 + l_sum.sum02 + l_sum.sum03 + l_sum.sum04 + l_sum.sum05 
                           + l_sum.sum06 + l_sum.sum07 + l_sum.sum08 + l_sum.sum09 + l_sum.sum10
           LET l_tot.tot01 = l_tot.tot01 + l_sum.sum01
           LET l_tot.tot02 = l_tot.tot02 + l_sum.sum02
           LET l_tot.tot03 = l_tot.tot03 + l_sum.sum03
           LET l_tot.tot04 = l_tot.tot04 + l_sum.sum04
           LET l_tot.tot05 = l_tot.tot05 + l_sum.sum05
           LET l_tot.tot06 = l_tot.tot06 + l_sum.sum06
           LET l_tot.tot07 = l_tot.tot07 + l_sum.sum07
           LET l_tot.tot08 = l_tot.tot08 + l_sum.sum08
           LET l_tot.tot09 = l_tot.tot09 + l_sum.sum09
           LET l_tot.tot10 = l_tot.tot10 + l_sum.sum10
           LET l_tot.tot11 = l_tot.tot11 + l_sum.sum11
           
#           PRINTX l_tot.*
           
           LET l_old_condition1 = sr1.l_condition1
           #end--add by yany 2016/11/03
           #end add-point:
 
 
           #add-point:rep.a_group.l_condition2.after name="rep.a_group.l_condition2.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr705_g02.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr705_g02_subrep01(sr2)
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
PRIVATE REPORT ainr705_g02_subrep02(sr2)
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
PRIVATE REPORT ainr705_g02_subrep03(sr2)
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
PRIVATE REPORT ainr705_g02_subrep04(sr2)
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
 
{<section id="ainr705_g02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/10/28 By yany
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr705_g02_erwei_tmp_table()
   #str--add by yany 2016/10/28
   DROP TABLE ainr705_g02_temp01;

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ainr705_g02_temp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   CREATE TEMP TABLE ainr705_g02_temp01(  
                   indidocno  LIKE indi_t.indidocno,          #單號  
                   item       LIKE imaa_t.imaa001,            #料件编号
                   imaal003   LIKE imaal_t.imaal003,          #品名
                   indj001    LIKE indj_t.indj001,            #需求单号
                   indj020    LIKE indj_t.indj020,            #需求对象
                   pmaal003   LIKE pmaal_t.pmaal003,          #对象名称
                   inam012    LIKE type_t.chr1000,            #特徵一值(顏色)
                   inam014    LIKE type_t.chr1000,            #特徵二值(尺寸)
                   inam018    LIKE type_t.chr1000,            #特徵四值(拉頭名稱)                
                   #indj009    LIKE indj_t.indj009,            #數量    #161109-00078#4 20161114 mark by beckxie
                   indj010    LIKE indj_t.indj010,            #數量    #161109-00078#4 20161114 add by beckxie
                   condition1 LIKE type_t.chr1000,
                   condition2 LIKE type_t.chr1000                   
                   )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ainr705_g02_temp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_rep_success = 'N'
      RETURN
   END IF
   #end--add by yany 2016/10/28
END FUNCTION

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
# Modify.........: 20161115 移除傳入參數 p_indidocno
################################################################################
PRIVATE FUNCTION ainr705_g02_ins_erwei_temp(p_imaal003,p_i,p_condition1,p_condition2,p_item)
#str--add by yany 2016/10/28
#--計算交叉表數值區資料總和--
#DEFINE p_indidocno  LIKE indi_t.indidocno   #161109-00078#4 20161114 mark by beckxie
DEFINE p_imaal003   LIKE imaal_t.imaal003
DEFINE p_condition1 LIKE type_t.chr1000
DEFINE p_condition2 LIKE type_t.chr1000
DEFINE p_item       LIKE type_t.chr100
DEFINE p_i          LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_max        LIKE type_t.num5
DEFINE l_max2       LIKE type_t.num5
DEFINE l_a          LIKE type_t.num5
DEFINE l_b          LIKE type_t.num5
DEFINE l_sql        STRING
#DEFINE l_indj009    STRING      #161109-00078#4 20161114 mark by beckxie
DEFINE l_indj010    STRING       #161109-00078#4 20161114 add by beckxie
DEFINE l_vi         varchar(3)
DEFINE i            LIKE type_t.num5

   CALL g_inam014.clear()
   
   LET l_n = 0
   SELECT COUNT(DISTINCT inam014) INTO l_n FROM ainr705_g02_temp01
    #WHERE indidocno = p_indidocno   #161109-00078#4 20161115 mark by beckxie
    WHERE 1=1                        #161109-00078#4 20161115 add by beckxie
#      AND imaal003 = p_imaal003
#      AND item = p_item 
      AND condition1 = p_condition1
      and condition2 = p_condition2
   

   LET l_i = (l_n-1)/10
   LET l_i = l_i +1
   IF l_i = p_i THEN
      LET l_max = l_n
   ELSE
      LET l_max = p_i*10
   END IF

   IF l_max mod 10 = 0 THEN 
      LET l_max2 = 10
   ELSE
      LET l_max2 = l_max mod 10
   END IF

   LET l_a = p_i*10-9
   LET l_b = p_i*10
   LET l_sql = " SELECT inam014 FROM inam014_tmp",
               "  WHERE i >=? and i<=? ",
               "  ORDER BY i "
   PREPARE inam014_pr FROM l_sql
   DECLARE inam014_cs CURSOR FOR inam014_pr
   OPEN inam014_cs USING l_a,l_b
   LET i = 1
   FOREACH inam014_cs INTO g_inam014[i]
      IF i = l_max2 THEN
         EXIT FOREACH
      ELSE
         LET i = i +1
      END IF
   END FOREACH
   #161109-00078#4 20161115 modify(拿掉indidocno,indj001) by beckxie---S
   #LET l_sql = " INSERT INTO indj_print_tmp(indidocno,item,imaal003,indj001,indj020,pmaal003,inam012,inam014,inam018,condition1,condition2  "
   LET l_sql = " INSERT INTO indj_print_tmp(item,imaal003,indj020,pmaal003,inam012,inam014,inam018,condition1,condition2  "
   #161109-00078#4 20161115 modify(拿掉indidocno,indj001) by beckxie---E
   FOR i=1 to l_max2
      #161109-00078#4 20161114 mark by beckxie---S
      #CASE i WHEN 1  LET l_indj009 = 'indj0091'
      #       WHEN 2  LET l_indj009 = 'indj0092'
      #       WHEN 3  LET l_indj009 = 'indj0093'
      #       WHEN 4  LET l_indj009 = 'indj0094'
      #       WHEN 5  LET l_indj009 = 'indj0095'
      #       WHEN 6  LET l_indj009 = 'indj0096'
      #       WHEN 7  LET l_indj009 = 'indj0097'
      #       WHEN 8  LET l_indj009 = 'indj0098'
      #       WHEN 9  LET l_indj009 = 'indj0099'           
      #       WHEN 10 LET l_indj009 = 'indj0090'
      #END CASE
      #LET l_sql = l_sql , ",",l_indj009
      #161109-00078#4 20161114 mark by beckxie---E
      #161109-00078#4 20161114 add by beckxie---S
      CASE i WHEN 1  LET l_indj010 = 'indj0101'
             WHEN 2  LET l_indj010 = 'indj0102'
             WHEN 3  LET l_indj010 = 'indj0103'
             WHEN 4  LET l_indj010 = 'indj0104'
             WHEN 5  LET l_indj010 = 'indj0105'
             WHEN 6  LET l_indj010 = 'indj0106'
             WHEN 7  LET l_indj010 = 'indj0107'
             WHEN 8  LET l_indj010 = 'indj0108'
             WHEN 9  LET l_indj010 = 'indj0109'           
             WHEN 10 LET l_indj010 = 'indj0100'
      END CASE
      LET l_sql = l_sql , ",",l_indj010
      #161109-00078#4 20161114 add by beckxie---E
   END FOR
   #161109-00078#4 20161115 modify(拿掉indidocno,indj001) by beckxie---S
   #LET l_sql = l_sql," ) SELECT DISTINCT indidocno,item,imaal003,indj001,indj020,pmaal003,inam012,'','',condition1,condition2 "
   LET l_sql = l_sql," ) SELECT DISTINCT item,imaal003,indj020,pmaal003,inam012,'','',condition1,condition2 "
   #161109-00078#4 20161115 modify(拿掉indidocno,indj001) by beckxie---E
   
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql," ,sum(A",l_vi,")"
   END FOR
   
   LET l_sql = l_sql,"  FROM ( SELECT DISTINCT indidocno,item,imaal003,indj001,indj020,pmaal003,inam012,inam014,inam018,condition1,condition2 "
   
   FOR i=1 to l_max2
      LET l_vi = i
      LET l_sql = l_sql,",CASE WHEN inam014 = '",g_inam014[i],"'",
                        #" THEN indj009 ELSE 0 END A",l_vi   #161109-00078#4 20161114 mark by beckxie 
                        " THEN indj010 ELSE 0 END A",l_vi    #161109-00078#4 20161114 add by beckxie
   END FOR
   LET l_sql = l_sql,  "  FROM ainr705_g02_temp01 ",
                       #" WHERE indidocno='",p_indidocno,"'",   #161109-00078#4 20161115 mark by beckxie
                       " WHERE 1=1 ",                           #161109-00078#4 20161115 add by beckxie
                       "   AND imaal003 = '",p_imaal003,"'",
                       "   AND item = '",p_item,"'",
                       "   AND condition1 = '",p_condition1,"'",
                       "   AND condition2 = '",p_condition2,"')",
                       #161109-00078#4 20161115 mark by beckxie---S
                       #" GROUP BY condition1,indidocno,item,imaal003,indj001,indj020,pmaal003,inam012,condition2 ",   
                       #" ORDER BY condition1,indidocno,item,imaal003,indj001,indj020,pmaal003,inam012,condition2 "  
                       #161109-00078#4 20161115 mark by beckxie---E
                       #161109-00078#4 20161115 add by beckxie---S
                       " GROUP BY condition1,item,imaal003,indj020,pmaal003,inam012,condition2 ",   
                       " ORDER BY condition1,item,imaal003,indj020,pmaal003,inam012,condition2 "  
                       #161109-00078#4 20161115 add by beckxie---E
   #DISPLAY "l_sql:",l_sql
   PREPARE indj_print_pr FROM l_sql
#  DELETE FROM indj_print_tmp WHERE 1=1
   EXECUTE indj_print_pr
   
   UPDATE indj_print_tmp  SET l_skip = "N"
    #WHERE indidocno = p_indidocno    #161109-00078#4 20161115 mark by beckxie
    WHERE 1=1                         #161109-00078#4 20161115 add by beckxie
      AND imaal003 = p_imaal003 
      AND inam014 = g_inam014[l_max2] 
      AND item = p_item
      
#end--add by yany 2016/10/28
END FUNCTION

################################################################################
# Descriptions...: 將該需求對象的單號,日期組成字串
# Memo...........:
# Usage..........: CALL ainr705_g02_get_string(p_indj020)
#                  RETURNING r_indidocno,r_indidocdt
# Input parameter: p_indj020      需求對象
# Return code....: r_indidocno    單號字串
#                : r_indidocdt    日期字串
# Date & Author..: 20161114 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr705_g02_get_string(p_indj020)
   DEFINE p_indj020        LIKE indj_t.indj020
   DEFINE l_sql            STRING
   DEFINE l_indidocno      LIKE indi_t.indidocno
   DEFINE l_indidocdt      LIKE indi_t.indidocdt
   DEFINE r_indidocno      STRING
   DEFINE r_indidocdt      STRING
   
   
   LET l_sql = " SELECT DISTINCT t2.indidocno,t2.indidocdt ",
               "   FROM ainr705_g02_temp01 t1, indi_t t2 ",
               "  WHERE t2.indient = ",g_enterprise,
               "    AND t2.indidocno = t1.indidocno  ",
               "    AND COALESCE(indj020,' ') = COALESCE('",p_indj020,"',' ')",
               "    AND t1.indj010 != 0 ",  #161017-00051#13 20161122 add by beckxie
               "  ORDER BY t2.indidocdt "
   PREPARE ainr705_g02_getstr_pre FROM l_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'ainr705_g02_sel_indj_pre:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
   END IF
   DECLARE ainr705_g02_getstr_cur CURSOR FOR ainr705_g02_getstr_pre
   
   LET l_indidocno = ''
   LET l_indidocdt = ''
   FOREACH ainr705_g02_getstr_cur INTO l_indidocno,l_indidocdt
            
      IF cl_null(r_indidocno) THEN
         LET r_indidocno = l_indidocno 
      ELSE
         LET r_indidocno = r_indidocno ," , ",l_indidocno 
      END IF
      
      IF cl_null(r_indidocdt) THEN
         LET r_indidocdt = l_indidocdt
      ELSE
         LET r_indidocdt = r_indidocdt ," , ",l_indidocdt 
      END IF
      
      LET l_indidocno = ''
      LET l_indidocdt = ''
   END FOREACH
   
   #DISPLAY "r_indidocno:",r_indidocno
   #DISPLAY "r_indidocdt:",r_indidocdt
   
   RETURN r_indidocno,r_indidocdt
END FUNCTION

 
{</section>}
 
{<section id="ainr705_g02.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/10/28 By yany
# Modify.........:
################################################################################
PRIVATE REPORT ainr705_g02_subrep05(sr5)
#str--add by yany 2016/10/28
DEFINE sr5             sr5_r
DEFINE l_sum           r_sum
DEFINE l_tot           r_sum
DEFINE l_old_item      LIKE type_t.chr100
DEFINE l_inam0141      LIKE type_t.chr1000
DEFINE l_inam0142      LIKE type_t.chr1000
DEFINE l_inam0143      LIKE type_t.chr1000
DEFINE l_inam0144      LIKE type_t.chr1000
DEFINE l_inam0145      LIKE type_t.chr1000
DEFINE l_inam0146      LIKE type_t.chr1000
DEFINE l_inam0147      LIKE type_t.chr1000
DEFINE l_inam0148      LIKE type_t.chr1000
DEFINE l_inam0149      LIKE type_t.chr1000
DEFINE l_inam01410     LIKE type_t.chr1000
#DEFINE l_indj009_sum   LIKE type_t.num15_3   #161109-00078#4 20161114 mark by beckxie
#DEFINE l_indj009_total LIKE type_t.num15_3   #161109-00078#4 20161114 mark by beckxie
DEFINE l_indj010_sum   LIKE type_t.num15_3    #161109-00078#4 20161114 add by beckxie
DEFINE l_indj010_total LIKE type_t.num15_3    #161109-00078#4 20161114 add by beckxie
DEFINE l_title         LIKE type_t.chr1000
DEFINE l_sql           LIKE type_t.chr1000

    ORDER EXTERNAL BY sr5.indidocno,sr5.item
    FORMAT
       BEFORE GROUP OF sr5.indidocno  --子報表中動態顯示title及計算總和
           SELECT substr(g_inam014[1],instr(g_inam014[1],'-')+1,Length(g_inam014[1])) INTO l_inam0141  FROM DUAL         
           SELECT substr(g_inam014[2],instr(g_inam014[2],'-')+1,Length(g_inam014[2])) INTO l_inam0142  FROM DUAL 
           SELECT substr(g_inam014[3],instr(g_inam014[3],'-')+1,Length(g_inam014[3])) INTO l_inam0143  FROM DUAL 
           SELECT substr(g_inam014[4],instr(g_inam014[4],'-')+1,Length(g_inam014[4])) INTO l_inam0144  FROM DUAL 
           SELECT substr(g_inam014[5],instr(g_inam014[5],'-')+1,Length(g_inam014[5])) INTO l_inam0145  FROM DUAL 
           SELECT substr(g_inam014[6],instr(g_inam014[6],'-')+1,Length(g_inam014[6])) INTO l_inam0146  FROM DUAL 
           SELECT substr(g_inam014[7],instr(g_inam014[7],'-')+1,Length(g_inam014[7])) INTO l_inam0147  FROM DUAL 
           SELECT substr(g_inam014[8],instr(g_inam014[8],'-')+1,Length(g_inam014[8])) INTO l_inam0148  FROM DUAL 
           SELECT substr(g_inam014[9],instr(g_inam014[9],'-')+1,Length(g_inam014[9])) INTO l_inam0149  FROM DUAL 
           SELECT substr(g_inam014[10],instr(g_inam014[10],'-')+1,Length(g_inam014[10])) INTO l_inam01410  FROM DUAL 
           INITIALIZE l_sum.* TO NULL
           LET l_title = NULL
           LET l_sql= " select listagg(oocql004,'/') within group(order by imeb001,imeb002) ",
                      "   from imeb_t,oocql_t ",
                      " where imebent = oocqlent ",
                      "   and oocql001 = '273' ",
                      "   and oocql002 = imeb004 ",
                      "   and imeb001=(SELECT DISTINCT imaa005 FROM imaa_t WHERE imaaent='",g_enterprise,"' AND imaa001='",sr5.item,"') ",
                      "   and imebent='",g_enterprise,"' ",
                      "   and imeb012='N'",
                      "   and oocql003='",g_dlang,"'"
           PREPARE ainr705_g02_title_pre FROM l_sql
           EXECUTE ainr705_g02_title_pre into l_title
           
           PRINTX l_inam0141
           PRINTX l_inam0142
           PRINTX l_inam0143
           PRINTX l_inam0144
           PRINTX l_inam0145
           PRINTX l_inam0146
           PRINTX l_inam0147
           PRINTX l_inam0148
           PRINTX l_inam0149
           PRINTX l_inam01410  
           PRINTX l_title
        
        BEFORE GROUP OF sr5.item

        ON EVERY ROW
            PRINTX g_grNumFmt.*
#            SELECT substr(sr5.inam012,instr(sr5.inam012,'-')+1,Length(sr5.inam012)) INTO sr5.inam012  FROM DUAL 
            PRINTX sr5.*
            
            #161109-00078#4 20161114 mark by beckxie---S
            #LET l_indj009_sum = 0
            #IF cl_null(sr5.indj0091) THEN LET sr5.indj0091 = 0 END IF            
            #IF cl_null(sr5.indj0092) THEN LET sr5.indj0092 = 0 END IF            
            #IF cl_null(sr5.indj0093) THEN LET sr5.indj0093 = 0 END IF           
            #IF cl_null(sr5.indj0094) THEN LET sr5.indj0094 = 0 END IF            
            #IF cl_null(sr5.indj0095) THEN LET sr5.indj0095 = 0 END IF            
            #IF cl_null(sr5.indj0096) THEN LET sr5.indj0096 = 0 END IF          
            #IF cl_null(sr5.indj0097) THEN LET sr5.indj0097 = 0 END IF            
            #IF cl_null(sr5.indj0098) THEN LET sr5.indj0098 = 0 END IF         
            #IF cl_null(sr5.indj0099) THEN LET sr5.indj0099 = 0 END IF           
            #IF cl_null(sr5.indj0090) THEN LET sr5.indj0090 = 0 END IF              
            #
            ##横向小計
            #LET l_indj009_sum = sr5.indj0091+sr5.indj0092+sr5.indj0093+sr5.indj0094+sr5.indj0095
            #                   +sr5.indj0096+sr5.indj0097+sr5.indj0098+sr5.indj0099+sr5.indj0090
            #PRINTX l_indj009_sum   
            #161109-00078#4 20161114 mark by beckxie---E
            #161109-00078#4 20161114 add by beckxie---S
            LET l_indj010_sum = 0
            IF cl_null(sr5.indj0101) THEN LET sr5.indj0101 = 0 END IF            
            IF cl_null(sr5.indj0102) THEN LET sr5.indj0102 = 0 END IF            
            IF cl_null(sr5.indj0103) THEN LET sr5.indj0103 = 0 END IF           
            IF cl_null(sr5.indj0104) THEN LET sr5.indj0104 = 0 END IF            
            IF cl_null(sr5.indj0105) THEN LET sr5.indj0105 = 0 END IF            
            IF cl_null(sr5.indj0106) THEN LET sr5.indj0106 = 0 END IF          
            IF cl_null(sr5.indj0107) THEN LET sr5.indj0107 = 0 END IF            
            IF cl_null(sr5.indj0108) THEN LET sr5.indj0108 = 0 END IF         
            IF cl_null(sr5.indj0109) THEN LET sr5.indj0109 = 0 END IF           
            IF cl_null(sr5.indj0100) THEN LET sr5.indj0100 = 0 END IF              
            
            #横向小計
            LET l_indj010_sum = sr5.indj0101+sr5.indj0102+sr5.indj0103+sr5.indj0104+sr5.indj0105
                               +sr5.indj0106+sr5.indj0107+sr5.indj0108+sr5.indj0109+sr5.indj0100
            PRINTX l_indj010_sum   
            #161109-00078#4 20161114 add by beckxie---E
            #纵向小计
            IF cl_null(l_sum.sum01) THEN LET  l_sum.sum01= 0 END IF            
            IF cl_null(l_sum.sum02) THEN LET  l_sum.sum02= 0 END IF            
            IF cl_null(l_sum.sum03) THEN LET  l_sum.sum03= 0 END IF           
            IF cl_null(l_sum.sum04) THEN LET  l_sum.sum04= 0 END IF            
            IF cl_null(l_sum.sum05) THEN LET  l_sum.sum05= 0 END IF            
            IF cl_null(l_sum.sum06) THEN LET  l_sum.sum06= 0 END IF          
            IF cl_null(l_sum.sum07) THEN LET  l_sum.sum07= 0 END IF            
            IF cl_null(l_sum.sum08) THEN LET  l_sum.sum08= 0 END IF            
            IF cl_null(l_sum.sum09) THEN LET  l_sum.sum09= 0 END IF           
            IF cl_null(l_sum.sum10) THEN LET  l_sum.sum10= 0 END IF
            IF cl_null(l_sum.sum11) THEN LET  l_sum.sum11= 0 END IF
             
            #161109-00078#4 20161114 mark by beckxie---S
            #LET l_sum.sum01=l_sum.sum01+ sr5.indj0091 
            #LET l_sum.sum02=l_sum.sum02+ sr5.indj0092 
            #LET l_sum.sum03=l_sum.sum03+ sr5.indj0093 
            #LET l_sum.sum04=l_sum.sum04+ sr5.indj0094 
            #LET l_sum.sum05=l_sum.sum05+ sr5.indj0095 
            #LET l_sum.sum06=l_sum.sum06+ sr5.indj0096 
            #LET l_sum.sum07=l_sum.sum07+ sr5.indj0097 
            #LET l_sum.sum08=l_sum.sum08+ sr5.indj0098 
            #LET l_sum.sum09=l_sum.sum09+ sr5.indj0099 
            #LET l_sum.sum10=l_sum.sum10+ sr5.indj0090 
            #161109-00078#4 20161114 mark by beckxie---E
            #161109-00078#4 20161114 add by beckxie---S
            LET l_sum.sum01=l_sum.sum01+ sr5.indj0101 
            LET l_sum.sum02=l_sum.sum02+ sr5.indj0102 
            LET l_sum.sum03=l_sum.sum03+ sr5.indj0103 
            LET l_sum.sum04=l_sum.sum04+ sr5.indj0104 
            LET l_sum.sum05=l_sum.sum05+ sr5.indj0105 
            LET l_sum.sum06=l_sum.sum06+ sr5.indj0106 
            LET l_sum.sum07=l_sum.sum07+ sr5.indj0107 
            LET l_sum.sum08=l_sum.sum08+ sr5.indj0108 
            LET l_sum.sum09=l_sum.sum09+ sr5.indj0109 
            LET l_sum.sum10=l_sum.sum10+ sr5.indj0100 
            #161109-00078#4 20161114 add by beckxie---E
            
            LET l_old_item = sr5.item            
        
        AFTER GROUP OF sr5.item
             #横向总计
            #161109-00078#4 20161114 mark by beckxie---S
            #EXECUTE indj009_total INTO l_indj009_total USING sr5.indidocno,sr5.imaal003,sr5.item,sr5.condition1
            #IF cl_null(l_indj009_total) THEN LET l_indj009_total = 0 END IF
            #PRINTX l_indj009_total  
            #
            #--总合计mxh
            #LET l_total = 0
            #EXECUTE indj009_total_sum INTO l_total USING sr5.indidocno
            #161109-00078#4 20161114 mark by beckxie---E
            #161109-00078#4 20161114 add by beckxie---S
            EXECUTE indj010_total INTO l_indj010_total USING sr5.indidocno,sr5.imaal003,sr5.item,sr5.condition1
            IF cl_null(l_indj010_total) THEN LET l_indj010_total = 0 END IF
            PRINTX l_indj010_total  
            
            --总合计mxh
            LET l_total = 0
            EXECUTE indj010_total_sum INTO l_total USING sr5.indidocno
            #161109-00078#4 20161114 add by beckxie---E
            IF cl_null(l_total) THEN LET l_total = 0 END IF
            
            #纵向小计
            LET l_sum.sum11 = l_sum.sum01+l_sum.sum02+l_sum.sum03+l_sum.sum04+l_sum.sum05
                             +l_sum.sum06+l_sum.sum07+l_sum.sum08+l_sum.sum09+l_sum.sum10
            PRINTX l_sum.*
            
        AFTER GROUP OF sr5.indidocno
#            #横向总计
#            EXECUTE indj009_total INTO l_indj009_total USING sr5.indidocno,sr5.imaal003,sr5.item,sr5.condition1
#            IF cl_null(l_indj009_total) THEN LET l_indj009_total = 0 END IF
#            PRINTX l_indj009_total  
#            
#            --总合计mxh
#            LET l_total = 0
#            EXECUTE indj009_total_sum INTO l_total USING sr5.indidocno
#            IF cl_null(l_total) THEN LET l_total = 0 END IF
#            
#            #纵向小计
#            LET l_sum.sum11 = l_sum.sum01+l_sum.sum02+l_sum.sum03+l_sum.sum04+l_sum.sum05
#                             +l_sum.sum06+l_sum.sum07+l_sum.sum08+l_sum.sum09+l_sum.sum10
#            PRINTX l_sum.*
            
#end--add by yany 2016/10/28
END REPORT

 
{</section>}
 
