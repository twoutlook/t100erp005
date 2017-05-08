#該程式未解開Section, 採用最新樣板產出!
{<section id="asrr801_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-10-20 16:08:38), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: asrr801_g01
#+ Description: ...
#+ Creator....: 05423(2015-01-20 16:40:41)
#+ Modifier...: 05384 -SD/PR- 00000
 
{</section>}
 
{<section id="asrr801_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160816-00001#10  16/08/17 By 08742     抓取理由碼改CALL sub
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
   srca001 LIKE srca_t.srca001, 
   l_srca001_desc LIKE srza_t.srza002, 
   srca004 LIKE srca_t.srca004, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   srca906 LIKE srca_t.srca906, 
   srca005 LIKE srca_t.srca005, 
   srca006 LIKE srca_t.srca006, 
   srca002 LIKE srca_t.srca002, 
   srca900 LIKE srca_t.srca900, 
   srca902 LIKE srca_t.srca902, 
   srca905 LIKE srca_t.srca905, 
   l_srca905_desc LIKE oocql_t.oocql004, 
   srcaent LIKE srca_t.srcaent, 
   srcc007 LIKE srcc_t.srcc007, 
   l_show LIKE type_t.chr2, 
   srcc901 LIKE srcc_t.srcc901, 
   l_srcc901_desc LIKE type_t.chr50, 
   srcc906 LIKE srcc_t.srcc906, 
   l_srcc906_show LIKE type_t.chr2, 
   srcc008 LIKE srcc_t.srcc008, 
   srcc009 LIKE srcc_t.srcc009, 
   l_srcc008_srcc009 LIKE type_t.chr80, 
   l_srcc008_desc LIKE type_t.chr50, 
   srcc010 LIKE srcc_t.srcc010, 
   l_srcc010_desc LIKE type_t.chr50, 
   srcc011 LIKE srcc_t.srcc011, 
   srcc012 LIKE srcc_t.srcc012, 
   srcc013 LIKE srcc_t.srcc013, 
   l_srcc012_srcc013 LIKE type_t.chr80, 
   l_srcc012_desc LIKE type_t.chr50, 
   srcc905 LIKE srcc_t.srcc905, 
   l_srcc905_desc LIKE type_t.chr80, 
   srcc014 LIKE srcc_t.srcc014, 
   srcc015 LIKE srcc_t.srcc015, 
   l_srcc014_srcc015 LIKE type_t.chr80, 
   l_srcc014_desc LIKE type_t.chr50, 
   srcc016 LIKE srcc_t.srcc016, 
   l_srcc016_desc LIKE type_t.chr30, 
   srcc017 LIKE srcc_t.srcc017, 
   srcc018 LIKE srcc_t.srcc018, 
   srcc019 LIKE srcc_t.srcc019, 
   srcc020 LIKE srcc_t.srcc020, 
   srcc036 LIKE srcc_t.srcc036, 
   srcc037 LIKE srcc_t.srcc037, 
   l_srcc036_srcc037 LIKE type_t.chr50, 
   l_srcc037_desc LIKE type_t.chr80, 
   srcc021 LIKE srcc_t.srcc021, 
   srcc022 LIKE srcc_t.srcc022, 
   srcc023 LIKE srcc_t.srcc023, 
   srcc024 LIKE srcc_t.srcc024, 
   srcc026 LIKE srcc_t.srcc026, 
   srcc025 LIKE srcc_t.srcc025, 
   srcc046 LIKE srcc_t.srcc046, 
   srcc027 LIKE srcc_t.srcc027, 
   srcc047 LIKE srcc_t.srcc047, 
   srcc048 LIKE srcc_t.srcc048, 
   l_srcc047_srcc048 LIKE type_t.chr50, 
   srcc028 LIKE srcc_t.srcc028, 
   srcc029 LIKE srcc_t.srcc029, 
   l_srcc028_srcc029 LIKE type_t.chr50, 
   l_srcc047 LIKE srcc_t.srcc047, 
   srca000 LIKE srca_t.srca000, 
   srcasite LIKE srca_t.srcasite, 
   l_srca002_desc LIKE ecba_t.ecba003, 
   l_key LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr LIKE type_t.chr2          #pr
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
DEFINE g_acc                 LIKE gzcb_t.gzcb004

 TYPE sr3_r RECORD
   srcdseq  LIKE srcd_t.srcdseq,             #項序      srcd008 0/1 check out / check in
   srcd009  LIKE srcd_t.srcd009,             #項目
   l_srcd009   LIKE srcd_t.srcd009,          
   l_srcd009_desc LIKE type_t.chr50,         #項目說明
   l_srcd009_desc1   LIKE type_t.chr50,
   srcd010  LIKE srcd_t.srcd010,             #形態
   l_srcd010   LIKE srcd_t.srcd010,
   l_srcd010_desc LIKE type_t.chr50,         #形態說明
   l_srcd010_desc1   LIKE type_t.chr50,
   srcd011  LIKE srcd_t.srcd011,             #下限
   l_srcd011   LIKE srcd_t.srcd011,    
   srcd012  LIKE srcd_t.srcd012,             #上限
   l_srcd012   LIKE srcd_t.srcd012,
   srcd013  LIKE srcd_t.srcd013,             #預設值
   l_srcd013   LIKE srcd_t.srcd013,          
   srcd014  LIKE srcd_t.srcd014,             #必要
   l_srcd014   LIKE srcd_t.srcd014,
   srcd901  LIKE srcd_t.srcd901,             #變更類型
   l_srcd901   LIKE srcd_t.srcd901,
   l_srcd901_desc LIKE type_t.chr50,         #變更類型說明
   l_srcd901_desc1   LIKE type_t.chr50,
   srcd905  LIKE srcd_t.srcd905,             #變更理由
   l_srcd905   LIKE srcd_t.srcd905,
   l_srcd905_desc LIKE type_t.chr50,         #變更理由說明
   l_srcd905_desc1   LIKE type_t.chr50,
   srcd906  LIKE srcd_t.srcd906,             #變更備註
   l_srcd906   LIKE srcd_t.srcd906,
   l_srcd009_btl   LIKE type_t.num15_3,
   l_srcd009_desc_btl   LIKE type_t.num15_3,
   l_srcd010_desc_btl   LIKE type_t.num15_3,
   l_srcd011_btl   LIKE type_t.num15_3,
   l_srcd012_btl   LIKE type_t.num15_3,
   l_srcd013_btl   LIKE type_t.num15_3,
   l_srcd014_btl   LIKE type_t.num15_3,
   l_show   LIKE type_t.chr2     #判定是否需要列印变更前信息
END RECORD

TYPE sr4_r RECORD  #單身變更欄位
   srcc007 LIKE srcc_t.srcc007,              #項次
   l_show LIKE type_t.chr2,                  #變更前（是否顯示）
   srcc901 LIKE srcc_t.srcc901,              #變更類型
   l_srcc901_desc LIKE type_t.chr50,         #變更類型說明
   srcc906 LIKE srcc_t.srcc906,              #變更備註
   l_srcc906_show LIKE type_t.chr2,          #變更備註顯示否
   srcc905 LIKE srcc_t.srcc906,              #變更理由
   l_srcc905_desc LIKE type_t.chr50,         #變更理由說明          
   l_srcc905_show LIKE type_t.chr2,          #變更理由顯示否
   srcc008 LIKE srcc_t.srcc008,              #本站作業
   srcc009 LIKE srcc_t.srcc009,              #本站作業序
   l_srcc008_srcc009 LIKE type_t.chr80, 
   l_srcc008_desc LIKE type_t.chr50,         #本站作業說明
   srcc010 LIKE srcc_t.srcc010,              #群組性質
   l_srcc010_desc LIKE type_t.chr50, 
   srcc011 LIKE srcc_t.srcc011,              #群組
   srcc012 LIKE srcc_t.srcc012,              #上站作業
   srcc013 LIKE srcc_t.srcc013,              #上站作業序
   l_srcc012_srcc013 LIKE type_t.chr80,      
   l_srcc012_desc LIKE type_t.chr50,         #上站作業說明
   srcc014 LIKE srcc_t.srcc014,              #下站作業
   srcc015 LIKE srcc_t.srcc015,              #下站作業序
   l_srcc014_srcc015 LIKE type_t.chr80,      
   l_srcc014_desc LIKE type_t.chr50,         #下站作業說明
   srcc016 LIKE srcc_t.srcc016,              #工作站
   l_srcc016_desc LIKE type_t.chr30,         #工作站說明
   srcc017 LIKE srcc_t.srcc017,              #固定工時
   srcc018 LIKE srcc_t.srcc018,              #標準工時
   srcc019 LIKE srcc_t.srcc019,              #固定機時
   srcc020 LIKE srcc_t.srcc020,              #標準機時
   srcc036 LIKE srcc_t.srcc036,              #委外否
   srcc037 LIKE srcc_t.srcc037,              #委外廠商
   l_srcc036_srcc037 LIKE type_t.chr50,      
   l_srcc037_desc LIKE type_t.chr80, 
   srcc021 LIKE srcc_t.srcc021,              #move in
   srcc022 LIKE srcc_t.srcc022,              #check in
   srcc023 LIKE srcc_t.srcc023,              #報工
   srcc024 LIKE srcc_t.srcc024,              #PQC
   srcc026 LIKE srcc_t.srcc026,              #move out
   srcc025 LIKE srcc_t.srcc025,              #check out
   srcc046 LIKE srcc_t.srcc046,              #轉入單位
   srcc027 LIKE srcc_t.srcc027,              #轉出單位
   srcc047 LIKE srcc_t.srcc047,              #轉入單位轉換率分子
   srcc048 LIKE srcc_t.srcc048,              #轉入單位轉換率分母
   l_srcc047_srcc048 LIKE type_t.chr50,      
   srcc028 LIKE srcc_t.srcc028,              #單位轉換率分子
   srcc029 LIKE srcc_t.srcc029,              #單位轉換率分母
   l_srcc028_srcc029 LIKE type_t.chr50
END RECORD

#DEFINE btl_1 RECORD
# l_srcc008_srcc009_btl   LIKE type_t.num15_3,
# l_srcc008_desc_btl   LIKE type_t.num15_3,
# l_srcc010_desc_btl   LIKE type_t.num15_3,
# l_srcc011_btl   LIKE type_t.num15_3,
# l_srcc012_srcc013_btl   LIKE type_t.num15_3,
# l_srcc012_desc_btl   LIKE type_t.num15_3,
# l_srcc014_srcc015_btl   LIKE type_t.num15_3,
# l_srcc014_desc_btl   LIKE type_t.num15_3,
# l_srcc016_btl   LIKE type_t.num15_3,
# l_srcc016_desc_btl   LIKE type_t.num15_3,
# l_srcc017_btl   LIKE type_t.num15_3,
# l_srcc018_btl   LIKE type_t.num15_3,
# l_srcc019_btl   LIKE type_t.num15_3,
# l_srcc020_btl   LIKE type_t.num15_3,
# l_srcc036_srcc037_btl   LIKE type_t.num15_3,
# l_srcc037_desc_btl   LIKE type_t.num15_3,
# l_srcc021_btl   LIKE type_t.num15_3,
# l_srcc022_btl   LIKE type_t.num15_3,
# l_srcc023_btl   LIKE type_t.num15_3,
# l_srcc024_btl   LIKE type_t.num15_3,
# l_srcc025_btl   LIKE type_t.num15_3,
# l_srcc026_btl   LIKE type_t.num15_3,
# l_srcc046_btl   LIKE type_t.num15_3,
# l_srcc027_btl   LIKE type_t.num15_3,
# l_srcc047_srcc048_btl   LIKE type_t.num15_3,
# l_srcc028_srcc029_btl   LIKE type_t.num15_3
#END RECORD

DEFINE btl_2   RECORD
 l_srcd009_btl   LIKE type_t.num15_3,
 l_srcd009_desc_btl   LIKE type_t.num15_3,
 l_srcd010_desc_btl   LIKE type_t.num15_3,
 l_srcd011_btl   LIKE type_t.num15_3,
 l_srcd012_btl   LIKE type_t.num15_3,
 l_srcd013_btl   LIKE type_t.num15_3,
 l_srcd014_btl   LIKE type_t.num15_3,
 l_srcd901_desc_btl   LIKE type_t.num15_3,
 l_srcd905_desc_btl   LIKE type_t.num15_3,
 l_srcd906_btl   LIKE type_t.num15_3
END RECORD
#end add-point
 
{</section>}
 
{<section id="asrr801_g01.main" readonly="Y" >}
PUBLIC FUNCTION asrr801_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.pr  pr
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog  #160816-00001#10 mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#10  Add
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asrr801_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asrr801_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asrr801_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asrr801_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asrr801_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asrr801_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
#   LET g_select = " SELECT DISTINCT srca001,(trim(srca001)||'.'||trim(srza002)),srca004,imaal_t.imaal003,imaal_t.imaal004,srca906,srca005,srca006, 
#       srca002,srca900,srca902,srca905,NULL,srcaent,srcc007,'N',srcc901,NULL,srcc906,'N',srcc008,srcc009, 
#       (trim(srcc008)||'/'||trim(srcc009)),NULL,NULL,NULL,NULL,NULL,srcc010,NULL,srcc011,NULL,NULL,NULL, 
#       srcc012,srcc013,(trim(srcc012)||'/'||trim(srcc013)),NULL,NULL,NULL,NULL,NULL,srcc905,NULL,srcc014, 
#       srcc015,(trim(srcc014)||'/'||trim(srcc015)),NULL,NULL,NULL,NULL,NULL,srcc016,NULL,NULL,NULL,srcc017, 
#       srcc018,NULL,NULL,srcc019,srcc020,NULL,NULL,srcc036,srcc037,(trim(srcc036)||' '||trim(srcc037)), 
#       NULL,NULL,NULL,NULL,NULL,srcc021,srcc022,NULL,NULL,srcc023,srcc024,NULL,NULL,srcc026,srcc025, 
#       NULL,NULL,srcc046,srcc027,NULL,NULL,srcc047,srcc048,(trim(srcc047)||'/'||trim(srcc048)),srcc028, 
#       srcc029,(trim(srcc028)||'/'||trim(srcc029)),NULL,NULL,NULL,NULL,NULL,NULL,srca000,srcasite,ecba003"
   LET g_select = " SELECT DISTINCT srca001,(trim(srca001)||'.'||trim(srza002)),srca004,imaal_t.imaal003,imaal_t.imaal004,srca906,srca005,srca006, 
       srca002,srca900,srca902,srca905,NULL,srcaent,srcc007,'N',srcc901,NULL,srcc906,'N',srcc008,srcc009, 
       (trim(srcc008)||'/'||trim(srcc009)),NULL,srcc010,NULL,srcc011,srcc012,srcc013,(trim(srcc012)||'/'||trim(srcc013)), 
       NULL,srcc905,NULL,srcc014,srcc015,(trim(srcc014)||'/'||trim(srcc015)),NULL,srcc016,NULL,srcc017, 
       srcc018,srcc019,srcc020,srcc036,srcc037,(trim(srcc036)||'/'||trim(srcc037)),NULL,srcc021,srcc022, 
       srcc023,srcc024,srcc026,srcc025,srcc046,srcc027,srcc047,srcc048,(trim(srcc047)||'/'||trim(srcc048)), 
       srcc028,srcc029,(trim(srcc028)||'/'||trim(srcc029)),NULL,srca000,srcasite,ecba003,trim(srca001)||'-'||trim(srca900)"
#   #end add-point
#   LET g_select = " SELECT srca001,NULL,srca004,imaal_t.imaal003,imaal_t.imaal004,srca906,srca005,srca006, 
#       srca002,srca900,srca902,srca905,NULL,srcaent,srcc007,NULL,srcc901,NULL,srcc906,NULL,srcc008,srcc009, 
#       (trim(srcc008)||'/'||trim(srcc009)),NULL,srcc010,NULL,srcc011,srcc012,srcc013,(trim(srcc012)||'/'||trim(srcc013)), 
#       NULL,srcc905,NULL,srcc014,srcc015,(trim(srcc014)||'/'||trim(srcc015)),NULL,srcc016,NULL,srcc017, 
#       srcc018,srcc019,srcc020,srcc036,srcc037,(trim(srcc036)||'/'||trim(srcc037)),NULL,srcc021,srcc022, 
#       srcc023,srcc024,srcc026,srcc025,srcc046,srcc027,srcc047,srcc048,(trim(srcc047)||'/'||trim(srcc048)), 
#       srcc028,srcc029,(trim(srcc028)||'/'||trim(srcc029)),NULL,srca000,srcasite,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM srca_t LEFT OUTER JOIN srcc_t ON srcaent = srccent AND srcasite = srccsite AND srca000 = srcc000 AND srca001 = srcc001 AND srca002 = srcc002 ",
                 " AND srca004 = srcc004 AND srca005 = srcc005 AND srca006 = srcc006 AND srca900 = srcc900 ",
                 "             LEFT OUTER JOIN srza_t ON srcaent = srzaent AND srcasite = srzasite AND srca001 = srza001 ",
                 "             LEFT OUTER JOIN imaal_t ON srcaent = imaalent AND srca004 = imaal001 AND imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN ecba_t ON ecbaent = srcaent AND srcasite = ecbasite AND ecba001 = srca004 AND srca002 = ecba002 "
                 
#   #end add-point
#    LET g_from = " FROM srca_t,srcc_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY srca001,srca002,srcc007"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("srca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asrr801_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asrr801_g01_curs CURSOR FOR asrr801_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asrr801_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asrr801_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   srca001 LIKE srca_t.srca001, 
   l_srca001_desc LIKE srza_t.srza002, 
   srca004 LIKE srca_t.srca004, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   srca906 LIKE srca_t.srca906, 
   srca005 LIKE srca_t.srca005, 
   srca006 LIKE srca_t.srca006, 
   srca002 LIKE srca_t.srca002, 
   srca900 LIKE srca_t.srca900, 
   srca902 LIKE srca_t.srca902, 
   srca905 LIKE srca_t.srca905, 
   l_srca905_desc LIKE oocql_t.oocql004, 
   srcaent LIKE srca_t.srcaent, 
   srcc007 LIKE srcc_t.srcc007, 
   l_show LIKE type_t.chr2, 
   srcc901 LIKE srcc_t.srcc901, 
   l_srcc901_desc LIKE type_t.chr50, 
   srcc906 LIKE srcc_t.srcc906, 
   l_srcc906_show LIKE type_t.chr2, 
   srcc008 LIKE srcc_t.srcc008, 
   srcc009 LIKE srcc_t.srcc009, 
   l_srcc008_srcc009 LIKE type_t.chr80, 
   l_srcc008_desc LIKE type_t.chr50, 
   srcc010 LIKE srcc_t.srcc010, 
   l_srcc010_desc LIKE type_t.chr50, 
   srcc011 LIKE srcc_t.srcc011, 
   srcc012 LIKE srcc_t.srcc012, 
   srcc013 LIKE srcc_t.srcc013, 
   l_srcc012_srcc013 LIKE type_t.chr80, 
   l_srcc012_desc LIKE type_t.chr50, 
   srcc905 LIKE srcc_t.srcc905, 
   l_srcc905_desc LIKE type_t.chr80, 
   srcc014 LIKE srcc_t.srcc014, 
   srcc015 LIKE srcc_t.srcc015, 
   l_srcc014_srcc015 LIKE type_t.chr80, 
   l_srcc014_desc LIKE type_t.chr50, 
   srcc016 LIKE srcc_t.srcc016, 
   l_srcc016_desc LIKE type_t.chr30, 
   srcc017 LIKE srcc_t.srcc017, 
   srcc018 LIKE srcc_t.srcc018, 
   srcc019 LIKE srcc_t.srcc019, 
   srcc020 LIKE srcc_t.srcc020, 
   srcc036 LIKE srcc_t.srcc036, 
   srcc037 LIKE srcc_t.srcc037, 
   l_srcc036_srcc037 LIKE type_t.chr50, 
   l_srcc037_desc LIKE type_t.chr80, 
   srcc021 LIKE srcc_t.srcc021, 
   srcc022 LIKE srcc_t.srcc022, 
   srcc023 LIKE srcc_t.srcc023, 
   srcc024 LIKE srcc_t.srcc024, 
   srcc026 LIKE srcc_t.srcc026, 
   srcc025 LIKE srcc_t.srcc025, 
   srcc046 LIKE srcc_t.srcc046, 
   srcc027 LIKE srcc_t.srcc027, 
   srcc047 LIKE srcc_t.srcc047, 
   srcc048 LIKE srcc_t.srcc048, 
   l_srcc047_srcc048 LIKE type_t.chr50, 
   srcc028 LIKE srcc_t.srcc028, 
   srcc029 LIKE srcc_t.srcc029, 
   l_srcc028_srcc029 LIKE type_t.chr50, 
   l_srcc047 LIKE srcc_t.srcc047, 
   srca000 LIKE srca_t.srca000, 
   srcasite LIKE srca_t.srcasite, 
   l_srca002_desc LIKE ecba_t.ecba003, 
   l_key LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_srcf008               LIKE srcf_t.srcf008
DEFINE l_srcf010               LIKE srcf_t.srcf010   
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asrr801_g01_curs INTO sr_s.*
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
       #去除多余'.''/'
       #计划组别
       IF sr_s.l_srca001_desc = '.' THEN
         LET sr_s.l_srca001_desc = NULL
       END IF
       #本站作业
       IF sr_s.l_srcc008_srcc009 = '/' THEN
         LET sr_s.l_srcc008_srcc009 = NULL
       END IF
       #上站作业
       IF sr_s.l_srcc012_srcc013 = '/' THEN
         LET sr_s.l_srcc012_srcc013 = NULL
       END IF
       #下站作业
       IF sr_s.l_srcc014_srcc015 = '/' THEN
         LET sr_s.l_srcc014_srcc015 = NULL
       END IF
       #委外加工厂商
       IF sr_s.l_srcc036_srcc037 = ' ' THEN
         LET sr_s.l_srcc036_srcc037 = NULL
       END IF
       #转出转换率
       IF sr_s.l_srcc047_srcc048 = '/' THEN
         LET sr_s.l_srcc047_srcc048 = NULL
       END IF
       #转入转换率
       IF sr_s.l_srcc028_srcc029 = '/' THEN
         LET sr_s.l_srcc028_srcc029 = NULL
       END IF
       
       #显示变更备注
       IF NOT cl_null(sr_s.srcc906) THEN
         LET sr_s.l_srcc906_show = 'Y'
       END IF
       
       #製程編號
       IF NOT cl_null(sr_s.srca002) AND NOT cl_null(sr_s.l_srca002_desc) THEN
          LET sr_s.l_srca002_desc = sr_s.srca002,'.',sr_s.l_srca002_desc
       END IF
       
       #获取说明
       #变更理由:srca905
       IF NOT cl_null(sr_s.srca905) THEN
         CALL asrr801_g01_desc('2',g_acc,sr_s.srca905) RETURNING sr_s.l_srca905_desc
         LET sr_s.l_srca905_desc = sr_s.srca905,'.',sr_s.l_srca905_desc
       END IF
       #变更理由:srcc905
       IF NOT cl_null(sr_s.srcc905) THEN
         CALL asrr801_g01_desc('2',g_acc,sr_s.srcc905) RETURNING sr_s.l_srcc905_desc
         LET sr_s.l_srcc905_desc = sr_s.srcc905,'.',sr_s.l_srcc905_desc
       END IF
       #变更类型:srcc901
       IF NOT cl_null(sr_s.srcc901) THEN
         CALL asrr801_g01_desc('1','5448',sr_s.srcc901) RETURNING sr_s.l_srcc901_desc
         LET sr_s.l_srcc901_desc = sr_s.srcc901,'.',sr_s.l_srcc901_desc
       END IF
       #群组性质:srcc010
       IF NOT cl_null(sr_s.srcc010) THEN
         CALL asrr801_g01_desc('1','1202',sr_s.srcc010) RETURNING sr_s.l_srcc010_desc
         LET sr_s.l_srcc010_desc = sr_s.srcc010,'.',sr_s.l_srcc010_desc
       END IF
       #本站作业:srcc008
       IF NOT cl_null(sr_s.srcc008) THEN
         CALL asrr801_g01_desc('2','221',sr_s.srcc008) RETURNING sr_s.l_srcc008_desc
       END IF
       #上站作业:srcc012
       IF NOT cl_null(sr_s.srcc012) THEN
         CALL asrr801_g01_desc('2','221',sr_s.srcc012) RETURNING sr_s.l_srcc012_desc
       END IF
       #下站作业:srcc014
       IF NOT cl_null(sr_s.srcc014) THEN
         CALL asrr801_g01_desc('2','221',sr_s.srcc014) RETURNING sr_s.l_srcc014_desc
       END IF       
       #工作站:srcc016
       IF NOT cl_null(sr_s.srcc016) THEN
         CALL asrr801_g01_desc('3',' ',sr_s.srcc016) RETURNING sr_s.l_srcc016_desc
       END IF
       #委外加工厂商:srcc037
       IF NOT cl_null(sr_s.srcc037) THEN
         CALL asrr801_g01_desc('4',' ',sr_s.srcc037) RETURNING sr_s.l_srcc037_desc
       END IF

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].srca001 = sr_s.srca001
       LET sr[l_cnt].l_srca001_desc = sr_s.l_srca001_desc
       LET sr[l_cnt].srca004 = sr_s.srca004
       LET sr[l_cnt].imaal_t_imaal003 = sr_s.imaal_t_imaal003
       LET sr[l_cnt].imaal_t_imaal004 = sr_s.imaal_t_imaal004
       LET sr[l_cnt].srca906 = sr_s.srca906
       LET sr[l_cnt].srca005 = sr_s.srca005
       LET sr[l_cnt].srca006 = sr_s.srca006
       LET sr[l_cnt].srca002 = sr_s.srca002
       LET sr[l_cnt].srca900 = sr_s.srca900
       LET sr[l_cnt].srca902 = sr_s.srca902
       LET sr[l_cnt].srca905 = sr_s.srca905
       LET sr[l_cnt].l_srca905_desc = sr_s.l_srca905_desc
       LET sr[l_cnt].srcaent = sr_s.srcaent
       LET sr[l_cnt].srcc007 = sr_s.srcc007
       LET sr[l_cnt].l_show = sr_s.l_show
       LET sr[l_cnt].srcc901 = sr_s.srcc901
       LET sr[l_cnt].l_srcc901_desc = sr_s.l_srcc901_desc
       LET sr[l_cnt].srcc906 = sr_s.srcc906
       LET sr[l_cnt].l_srcc906_show = sr_s.l_srcc906_show
       LET sr[l_cnt].srcc008 = sr_s.srcc008
       LET sr[l_cnt].srcc009 = sr_s.srcc009
       LET sr[l_cnt].l_srcc008_srcc009 = sr_s.l_srcc008_srcc009
       LET sr[l_cnt].l_srcc008_desc = sr_s.l_srcc008_desc
       LET sr[l_cnt].srcc010 = sr_s.srcc010
       LET sr[l_cnt].l_srcc010_desc = sr_s.l_srcc010_desc
       LET sr[l_cnt].srcc011 = sr_s.srcc011
       LET sr[l_cnt].srcc012 = sr_s.srcc012
       LET sr[l_cnt].srcc013 = sr_s.srcc013
       LET sr[l_cnt].l_srcc012_srcc013 = sr_s.l_srcc012_srcc013
       LET sr[l_cnt].l_srcc012_desc = sr_s.l_srcc012_desc
       LET sr[l_cnt].srcc905 = sr_s.srcc905
       LET sr[l_cnt].l_srcc905_desc = sr_s.l_srcc905_desc
       LET sr[l_cnt].srcc014 = sr_s.srcc014
       LET sr[l_cnt].srcc015 = sr_s.srcc015
       LET sr[l_cnt].l_srcc014_srcc015 = sr_s.l_srcc014_srcc015
       LET sr[l_cnt].l_srcc014_desc = sr_s.l_srcc014_desc
       LET sr[l_cnt].srcc016 = sr_s.srcc016
       LET sr[l_cnt].l_srcc016_desc = sr_s.l_srcc016_desc
       LET sr[l_cnt].srcc017 = sr_s.srcc017
       LET sr[l_cnt].srcc018 = sr_s.srcc018
       LET sr[l_cnt].srcc019 = sr_s.srcc019
       LET sr[l_cnt].srcc020 = sr_s.srcc020
       LET sr[l_cnt].srcc036 = sr_s.srcc036
       LET sr[l_cnt].srcc037 = sr_s.srcc037
       LET sr[l_cnt].l_srcc036_srcc037 = sr_s.l_srcc036_srcc037
       LET sr[l_cnt].l_srcc037_desc = sr_s.l_srcc037_desc
       LET sr[l_cnt].srcc021 = sr_s.srcc021
       LET sr[l_cnt].srcc022 = sr_s.srcc022
       LET sr[l_cnt].srcc023 = sr_s.srcc023
       LET sr[l_cnt].srcc024 = sr_s.srcc024
       LET sr[l_cnt].srcc026 = sr_s.srcc026
       LET sr[l_cnt].srcc025 = sr_s.srcc025
       LET sr[l_cnt].srcc046 = sr_s.srcc046
       LET sr[l_cnt].srcc027 = sr_s.srcc027
       LET sr[l_cnt].srcc047 = sr_s.srcc047
       LET sr[l_cnt].srcc048 = sr_s.srcc048
       LET sr[l_cnt].l_srcc047_srcc048 = sr_s.l_srcc047_srcc048
       LET sr[l_cnt].srcc028 = sr_s.srcc028
       LET sr[l_cnt].srcc029 = sr_s.srcc029
       LET sr[l_cnt].l_srcc028_srcc029 = sr_s.l_srcc028_srcc029
       LET sr[l_cnt].l_srcc047 = sr_s.l_srcc047
       LET sr[l_cnt].srca000 = sr_s.srca000
       LET sr[l_cnt].srcasite = sr_s.srcasite
       LET sr[l_cnt].l_srca002_desc = sr_s.l_srca002_desc
       LET sr[l_cnt].l_key = sr_s.l_key
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asrr801_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asrr801_g01_rep_data()
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
          START REPORT asrr801_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asrr801_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asrr801_g01_rep
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
 
{<section id="asrr801_g01.rep" readonly="Y" >}
PRIVATE REPORT asrr801_g01_rep(sr1)
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
DEFINE sr3 sr3_r     #子报表1 CHECK IN 项目
DEFINE sr4 sr3_r     #子报表2 CHECK OUT 项目
DEFINE sr5 sr4_r     #單身變更
DEFINE l_subrep05_show  LIKE type_t.chr1,
       l_subrep06_show  LIKE type_t.chr1,
       l_subrep07_show  LIKE type_t.chr1
DEFINE l_srcf008               LIKE srcf_t.srcf008
DEFINE l_srcf010               LIKE srcf_t.srcf010      
DEFINE l_count          LIKE type_t.num5
DEFINE l_chk            LIKE type_t.num5
#底線寬度
DEFINE l_srcc008_btl   LIKE type_t.num20_6
DEFINE l_srcc008_desc_btl   LIKE type_t.num20_6
DEFINE l_srcc009_btl   LIKE type_t.num20_6
DEFINE l_srcc010_desc_btl   LIKE type_t.num20_6
DEFINE l_srcc011_btl   LIKE type_t.num20_6
DEFINE l_srcc012_btl   LIKE type_t.num20_6
DEFINE l_srcc012_desc_btl   LIKE type_t.num20_6
DEFINE l_srcc013_btl   LIKE type_t.num20_6
DEFINE l_srcc014_btl   LIKE type_t.num20_6
DEFINE l_srcc014_desc_btl   LIKE type_t.num20_6
DEFINE l_srcc015_btl   LIKE type_t.num20_6
DEFINE l_srcc016_btl   LIKE type_t.num20_6
DEFINE l_srcc016_desc_btl   LIKE type_t.num20_6
DEFINE l_srcc017_btl   LIKE type_t.num20_6
DEFINE l_srcc018_btl   LIKE type_t.num20_6
DEFINE l_srcc019_btl   LIKE type_t.num20_6
DEFINE l_srcc020_btl   LIKE type_t.num20_6
DEFINE l_srcc037_btl   LIKE type_t.num20_6
DEFINE l_srcc037_desc_btl   LIKE type_t.num20_6
DEFINE l_srcc036_btl   LIKE type_t.num20_6
DEFINE l_srcc021_btl   LIKE type_t.num20_6
DEFINE l_srcc022_btl   LIKE type_t.num20_6
DEFINE l_srcc023_btl   LIKE type_t.num20_6
DEFINE l_srcc024_btl   LIKE type_t.num20_6
DEFINE l_srcc026_btl   LIKE type_t.num20_6
DEFINE l_srcc025_btl   LIKE type_t.num20_6
DEFINE l_srcc046_btl   LIKE type_t.num20_6
DEFINE l_srcc027_btl   LIKE type_t.num20_6
DEFINE l_srcc047_btl   LIKE type_t.num20_6
DEFINE l_srcc048_btl   LIKE type_t.num20_6
DEFINE l_srcc028_btl   LIKE type_t.num20_6
DEFINE l_srcc029_btl   LIKE type_t.num20_6
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
 
    #end add-point
    ORDER  BY sr1.l_key,sr1.srcc007
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
        BEFORE GROUP OF sr1.l_key
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_key
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'srcaent=' ,sr1.srcaent,'{+}srcasite=' ,sr1.srcasite,'{+}srca000=' ,sr1.srca000,'{+}srca001=' ,sr1.srca001,'{+}srca002=' ,sr1.srca002,'{+}srca004=' ,sr1.srca004,'{+}srca005=' ,sr1.srca005,'{+}srca006=' ,sr1.srca006,'{+}srca900=' ,sr1.srca900         
            CALL cl_gr_init_apr(sr1.l_key)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_key.before name="rep.b_group.l_key.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.srcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_key CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr801_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asrr801_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asrr801_g01_subrep01
           DECLARE asrr801_g01_repcur01 CURSOR FROM g_sql
           FOREACH asrr801_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr801_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asrr801_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asrr801_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_key.after name="rep.b_group.l_key.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.srcc007
 
           #add-point:rep.b_group.srcc007.before name="rep.b_group.srcc007.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.srcc007.after name="rep.b_group.srcc007.after"
           
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
                sr1.srcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_key CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.srcc007 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr801_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asrr801_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asrr801_g01_subrep02
           DECLARE asrr801_g01_repcur02 CURSOR FROM g_sql
           FOREACH asrr801_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr801_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asrr801_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asrr801_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
 
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
 
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          #單身子報表
          START REPORT asrr801_g01_subrep07
             #单身此笔变更类型为1.未变更3.单身新增4.单身删除时，不显示变更前资料
             LET sr5.l_show = 'N'
             IF sr1.srcc901 = '2' THEN
                LET sr5.l_show = 'Y'      #僅決定是否顯示變更前資料
             END IF
             IF NOT cl_null(sr1.srcc901) THEN
                LET sr5.srcc901 = sr1.srcc901
                LET sr5.l_srcc901_desc = sr1.l_srcc901_desc
             END IF
             LET sr5.l_srcc906_show = 'N'    #變更備註
             IF NOT cl_null(sr1.srcc906) THEN
                LET sr5.srcc906 = sr1.srcc906
                LET sr5.l_srcc906_show = 'Y'
             END IF
             LET sr5.l_srcc905_show = 'N'    #變更理由
             IF NOT cl_null(sr1.srcc905) THEN
                LET sr5.srcc905 = sr1.srcc905
                LET sr5.l_srcc905_desc = sr1.l_srcc905_desc
                LET sr5.l_srcc905_show = 'Y'
             END IF
             LET l_srcc008_btl = 0
             LET l_srcc008_desc_btl = 0
             LET l_srcc009_btl = 0
             LET l_srcc010_desc_btl = 0
             LET l_srcc011_btl = 0
             LET l_srcc012_btl = 0
             LET l_srcc012_desc_btl = 0
             LET l_srcc013_btl = 0
             LET l_srcc014_btl = 0
             LET l_srcc014_desc_btl = 0
             LET l_srcc015_btl = 0
             LET l_srcc016_btl = 0
             LET l_srcc016_desc_btl = 0
             LET l_srcc017_btl = 0
             LET l_srcc018_btl = 0
             LET l_srcc019_btl = 0
             LET l_srcc020_btl = 0
             LET l_srcc037_btl = 0
             LET l_srcc037_desc_btl = 0
             LET l_srcc036_btl = 0
             LET l_srcc021_btl = 0
             LET l_srcc022_btl = 0
             LET l_srcc023_btl = 0
             LET l_srcc024_btl = 0
             LET l_srcc026_btl = 0
             LET l_srcc025_btl = 0
             LET l_srcc046_btl = 0
             LET l_srcc027_btl = 0
             LET l_srcc047_btl = 0
             LET l_srcc048_btl = 0
             LET l_srcc028_btl = 0
             LET l_srcc029_btl = 0
             LET l_subrep07_show ='Y'  
             IF sr1.srcc901 = '2' THEN
                LET l_count = 0
                #本站作業srcc008
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac008','0') RETURNING sr5.srcc008,l_cnt            
                LET l_srcc008_btl = 0.5
                LET l_srcc008_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_srcc008_btl = 0
                   LET l_srcc008_desc_btl = 0
                   LET sr5.srcc008 = NULL #sr1.srcc008
                   LET sr5.l_srcc008_desc =NULL # sr1.l_srcc008_desc
                ELSE
                   CALL asrr801_g01_desc('2','221',sr5.srcc008) RETURNING sr5.l_srcc008_desc
                   LET l_count = l_count + 1
                END IF  
                
                #本站作業序srcc009     
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac009','0') RETURNING sr5.srcc009,l_cnt            
                LET l_srcc009_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc009_btl = 0
                   LET sr5.srcc009 = NULL #sr1.srcc009
                ELSE
                   LET l_count = l_count + 1
                END IF  
                
                #群組性質srcc010
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac010','0') RETURNING sr5.srcc010,l_cnt            
                LET l_srcc010_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_srcc010_desc_btl = 0
                   LET sr5.srcc010 = NULL #sr1.srcc010
                   LET sr5.l_srcc010_desc =NULL # sr1.l_srcc010_desc
                ELSE
                   CALL asrr801_g01_desc('1','1202',sr5.srcc010) RETURNING sr5.l_srcc010_desc
                   LET sr5.l_srcc010_desc = sr5.srcc010,'.',sr5.l_srcc010_desc
                   LET l_count = l_count + 1
                END IF  
                #群组srcc011
                #本站作業序srcc009     
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac011','0') RETURNING sr5.srcc011,l_cnt            
                LET l_srcc011_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc011_btl = 0
                   LET sr5.srcc011 = NULL #sr1.srcc011
                ELSE
                   LET l_count = l_count + 1
                END IF 

                #上站作業srcc012
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac012','0') RETURNING sr5.srcc012,l_cnt            
                LET l_srcc012_btl = 0.5
                LET l_srcc012_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_srcc012_btl = 0
                   LET l_srcc012_desc_btl = 0
                   LET sr5.srcc012 = NULL #sr1.srcc012
                   LET sr5.l_srcc012_desc =NULL # sr1.l_srcc012_desc
                ELSE
                   CALL asrr801_g01_desc('2','221',sr5.srcc012) RETURNING sr5.l_srcc012_desc
                   LET l_count = l_count + 1
                END IF  
                
                #上站作業序srcc013
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac013','0') RETURNING sr5.srcc013,l_cnt            
                LET l_srcc013_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc013_btl = 0
                   LET sr5.srcc013 = NULL #sr1.srcc013
                ELSE
                   LET l_count = l_count + 1
                END IF 
   
                #下站作業srcc014
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac014','0') RETURNING sr5.srcc014,l_cnt            
                LET l_srcc014_btl = 0.5
                LET l_srcc014_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_srcc014_btl = 0
                   LET l_srcc014_desc_btl = 0
                   LET sr5.srcc014 = NULL #sr1.srcc014
                   LET sr5.l_srcc014_desc =NULL # sr1.l_srcc014_desc
                ELSE
                   CALL asrr801_g01_desc('2','221',sr5.srcc014) RETURNING sr5.l_srcc014_desc
                   LET l_count = l_count + 1
                END IF  
                
                #下站作業序srcc015
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac015','0') RETURNING sr5.srcc015,l_cnt            
                LET l_srcc015_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc015_btl = 0
                   LET sr5.srcc015 = NULL #sr1.srcc015
                ELSE
                   LET l_count = l_count + 1
                END IF 
                
                #工作站srcc016
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac016','0') RETURNING sr5.srcc016,l_cnt            
                LET l_srcc016_btl = 0.5
                LET l_srcc016_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_srcc016_btl = 0
                   LET l_srcc016_desc_btl = 0
                   LET sr5.srcc016 = NULL #sr1.srcc016
                   LET sr5.l_srcc016_desc =NULL # sr1.l_srcc016_desc
                ELSE
                   CALL asrr801_g01_desc('3',' ',sr5.srcc016) RETURNING sr5.l_srcc016_desc
                   LET l_count = l_count + 1
                END IF  
                
                #固定工時srcc017
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac017','0') RETURNING sr5.srcc017,l_cnt            
                LET l_srcc017_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc017_btl = 0
                   LET sr5.srcc017 = -1 #sr1.srcc017
                ELSE
                   LET l_count = l_count + 1
                END IF 
                #標準工時srcc018
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac018','0') RETURNING sr5.srcc018,l_cnt            
                LET l_srcc018_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc018_btl = 0
                   LET sr5.srcc018 = -1 #sr1.srcc018
                ELSE
                   LET l_count = l_count + 1
                END IF 
                #固定機時srcc019
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac019','0') RETURNING sr5.srcc019,l_cnt            
                LET l_srcc019_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc019_btl = 0
                   LET sr5.srcc019 = -1 #sr1.srcc019
                ELSE
                   LET l_count = l_count + 1
                END IF 
                #標準機時srcc020
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac020','0') RETURNING sr5.srcc020,l_cnt            
                LET l_srcc020_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc020_btl = 0
                   LET sr5.srcc020 = -1 #sr1.srcc020
                ELSE
                   LET l_count = l_count + 1
                END IF 
                
                #委外加工廠商srcc037
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac037','0') RETURNING sr5.srcc037,l_cnt            
                LET l_srcc037_btl = 0.5
                LET l_srcc037_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_srcc037_btl = 0
                   LET l_srcc037_desc_btl = 0
                   LET sr5.srcc037 = NULL #sr1.srcc037
                   LET sr5.l_srcc037_desc = NULL #sr1.l_srcc037_desc
                ELSE
                   CALL asrr801_g01_desc('4',' ',sr5.srcc037) RETURNING sr5.l_srcc037_desc
                   LET l_count = l_count + 1
                END IF  
                
                #委外否srcc036 
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac036','0') RETURNING sr5.srcc036,l_cnt            
                LET l_srcc036_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc036_btl = 0
                   LET sr5.srcc036 = NULL #sr1.srcc036
                ELSE
                   LET l_count = l_count + 1
                END IF
                
                #MOVE IN srcc021
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac021','0') RETURNING sr5.srcc021,l_cnt            
                LET l_srcc021_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc021_btl = 0
                   LET sr5.srcc021 = NULL #sr1.srcc021
                ELSE
                   LET l_count = l_count + 1
                END IF
                #CHECK IN srcc022
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac022','0') RETURNING sr5.srcc022,l_cnt            
                LET l_srcc022_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc022_btl = 0
                   LET sr5.srcc022 = NULL #sr1.srcc022
                ELSE
                   LET l_count = l_count + 1
                END IF
                #報工 srcc023
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac023','0') RETURNING sr5.srcc023,l_cnt            
                LET l_srcc023_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc023_btl = 0
                   LET sr5.srcc023 = NULL #sr1.srcc023
                ELSE
                   LET l_count = l_count + 1
                END IF
                #PQC srcc024
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac024','0') RETURNING sr5.srcc024,l_cnt            
                LET l_srcc024_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc024_btl = 0
                   LET sr5.srcc024 = NULL #sr1.srcc024
                ELSE
                   LET l_count = l_count + 1
                END IF
                #MOVE OUT srcc026 
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac026','0') RETURNING sr5.srcc026,l_cnt            
                LET l_srcc026_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc026_btl = 0
                   LET sr5.srcc026 = NULL #sr1.srcc026
                ELSE
                   LET l_count = l_count + 1
                END IF
                #CHECK OUT srcc025
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac025','0') RETURNING sr5.srcc025,l_cnt            
                LET l_srcc025_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc025_btl = 0
                   LET sr5.srcc025 = NULL #sr1.srcc025
                ELSE
                   LET l_count = l_count + 1
                END IF
                #轉入單位 srcc046
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac046','0') RETURNING sr5.srcc046,l_cnt            
                LET l_srcc046_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc046_btl = 0
                   LET sr5.srcc046 = NULL #sr1.srcc046
                ELSE
                   LET l_count = l_count + 1
                END IF
                #轉出單位 srcc027
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac027','0') RETURNING sr5.srcc027,l_cnt            
                LET l_srcc027_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc027_btl = 0
                   LET sr5.srcc027 = NULL #sr1.srcc027
                ELSE
                   LET l_count = l_count + 1
                END IF
                
                #轉入轉換率分子 srcc047
                LET l_chk = 0 #計算是否分子分母都變動
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac047','0') RETURNING sr5.srcc047,l_cnt            
                LET l_srcc047_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc047_btl = 0
                   LET sr5.srcc047 = NULL #sr1.srcc047
                   LET sr5.l_srcc047_srcc048 = sr1.srcc047 USING '######'
                ELSE
                   LET sr5.l_srcc047_srcc048 = sr5.srcc047 USING '######'
                   LET l_chk = l_chk + 1
#                   LET sr5.srcc047 = sr5.srcc047 USING '######'
                   LET l_count = l_count + 1
                END IF
                
                #轉入轉換率分母 srcc048
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac048','0') RETURNING sr5.srcc048,l_cnt            
                LET l_srcc048_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc048_btl = 0
                   LET sr5.srcc048 = NULL #sr1.srcc048
                   LET sr5.l_srcc047_srcc048 = sr5.l_srcc047_srcc048,'/',sr1.srcc048 USING '######' CLIPPED
                ELSE
                   LET sr5.l_srcc047_srcc048 = sr5.l_srcc047_srcc048,'/',sr5.srcc048 USING '######' CLIPPED
                   LET l_chk = l_chk + 1
#                   LET sr5.srcc048 = sr5.srcc048 USING '######'
                   LET l_count = l_count + 1
                END IF
                IF l_chk = 0 THEN
                   LET sr5.l_srcc047_srcc048 = NULL
                END IF
                #轉出轉換率分子 srcc028
                LET l_chk = 0
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac028','0') RETURNING sr5.srcc028,l_cnt            
                LET l_srcc028_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc028_btl = 0
                   LET sr5.srcc028 = NULL #sr1.srcc028
                   LET sr5.l_srcc028_srcc029 = sr1.srcc028 USING '######'
                ELSE
                   LET sr5.l_srcc028_srcc029 = sr5.srcc028 USING '######'
                   LET l_chk = l_chk + 1
#                   LET sr5.srcc028 = sr5.srcc028 USING '######'
                   LET l_count = l_count + 1
                END IF
                #轉出轉換率分母 srcc029
                CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srac029','0') RETURNING sr5.srcc029,l_cnt            
                LET l_srcc029_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_srcc029_btl = 0
                   LET sr5.srcc029 = sr1.srcc029 
                   LET sr5.l_srcc028_srcc029 = sr5.l_srcc028_srcc029,'/',sr1.srcc029 USING '######'
                ELSE
                   LET sr5.l_srcc028_srcc029 = sr5.l_srcc028_srcc029,'/',sr5.srcc029 USING '######'
                   LET l_chk = l_chk + 1
#                   LET sr5.srcc029 = sr5.srcc029 USING '######'
                   LET l_count = l_count + 1
                END IF
                IF l_chk = 0 THEN
                   LET sr5.l_srcc028_srcc029 = NULL
                END IF
                IF l_count = 0 AND sr5.l_show = 'Y' THEN #僅決定是否顯示變更前資料
                   LET sr5.l_show ='N'
                END IF   
             END IF
          OUTPUT TO REPORT asrr801_g01_subrep07(sr5.*)
          FINISH REPORT asrr801_g01_subrep07
          PRINTX l_subrep07_show
          PRINTX l_srcc008_btl
          PRINTX l_srcc008_desc_btl
          PRINTX l_srcc009_btl
          PRINTX l_srcc010_desc_btl
          PRINTX l_srcc011_btl
          PRINTX l_srcc012_btl
          PRINTX l_srcc012_desc_btl
          PRINTX l_srcc013_btl
          PRINTX l_srcc014_btl
          PRINTX l_srcc014_desc_btl
          PRINTX l_srcc015_btl
          PRINTX l_srcc016_btl
          PRINTX l_srcc016_desc_btl
          PRINTX l_srcc017_btl
          PRINTX l_srcc018_btl
          PRINTX l_srcc019_btl
          PRINTX l_srcc020_btl
          PRINTX l_srcc037_btl
          PRINTX l_srcc037_desc_btl
          PRINTX l_srcc036_btl
          PRINTX l_srcc021_btl
          PRINTX l_srcc022_btl
          PRINTX l_srcc023_btl
          PRINTX l_srcc024_btl
          PRINTX l_srcc026_btl
          PRINTX l_srcc025_btl
          PRINTX l_srcc046_btl
          PRINTX l_srcc027_btl
          PRINTX l_srcc047_btl
          PRINTX l_srcc048_btl
          PRINTX l_srcc028_btl
          PRINTX l_srcc029_btl
          ######################################
-----------子报表一：CHECK IN 项目------           
           LET g_sql = " SELECT DISTINCT srcdseq,srcd009,NULL,NULL,NULL,srcd010,NULL,NULL,NULL,srcd011,NULL,srcd012,NULL,srcd013,NULL,",
                       " srcd014,NULL,srcd901,NULL,NULL,NULL,srcd905,NULL,NULL,NULL,srcd906,NULL,'0','0','0','0','0','0','0','N' ",
                       " FROM srcd_t ",
                       " WHERE srcdent = ",g_enterprise ,
                       " AND srcdsite = '",g_site ,"' ",
                       " AND srcd000 = '",sr1.srca000,"' ",
                       " AND srcd001 = '",sr1.srca001,"' ",
                       " AND srcd002 = '",sr1.srca002,"' ",
                       " AND srcd004 = '",sr1.srca004,"' ",
                       " AND srcd900 = '",sr1.srca900,"' ",
                       " AND srcd007 = '",sr1.srcc007,"' ",
                       " AND srcd008 = '1' "
           #BOM特性
           IF NOT cl_null(sr1.srca005) THEN
              LET g_sql = g_sql," AND srcd005 = '",sr1.srca005,"' "
           END IF
           #產品特征
           IF NOT cl_null(sr1.srca006) THEN
              LET g_sql = g_sql," AND srcd006 = '",sr1.srca006,"' "
           END IF
           IF tm.pr = 'N' THEN 
              LET g_sql = g_sql CLIPPED ," AND srcd901 <>'4' "
           END IF
           LET g_sql = g_sql CLIPPED ," ORDER BY srcdseq "
           #add-point:rep.sub05.afsql

           #end add-point:rep.sub05.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr801_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE asrr801_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT asrr801_g01_subrep05
           DECLARE asrr801_g01_repcur05 CURSOR FROM g_sql
           FOREACH asrr801_g01_repcur05 INTO sr3.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr801_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub05.foreach
              #项目说明：srcd009
              IF NOT cl_null(sr3.srcd009) THEN 
                CALL asrr801_g01_desc('2','223',sr3.srcd009) RETURNING sr3.l_srcd009_desc
              END IF
              #形态:srcd010
              IF NOT cl_null(sr3.srcd010) THEN 
                CALL asrr801_g01_desc('1','1201',sr3.srcd010) RETURNING sr3.l_srcd010_desc
                LET sr3.l_srcd010_desc = sr3.srcd010,'.',sr3.l_srcd010_desc
              END IF
              #变更类型:srcd901
              IF NOT cl_null(sr3.srcd901) THEN 
                CALL asrr801_g01_desc('1','5448',sr3.srcd901) RETURNING sr3.l_srcd901_desc
                LET sr3.l_srcd901_desc = sr3.srcd901,'.',sr3.l_srcd901_desc
              END IF
              #变更理由:srcd905
              IF NOT cl_null(sr3.srcd905) THEN 
                CALL asrr801_g01_desc('2',g_acc,sr3.srcd905) RETURNING sr3.l_srcd905_desc
                LET sr3.l_srcd905_desc = sr3.srcd905,'.',sr3.l_srcd905_desc
              END IF
              --------------变更前资料----------
              LET sr3.l_srcd009_btl = 0
              LET sr3.l_srcd009_desc_btl = 0
              LET sr3.l_srcd010_desc_btl = 0
              LET sr3.l_srcd011_btl = 0
              LET sr3.l_srcd012_btl = 0
              LET sr3.l_srcd013_btl = 0
              LET sr3.l_srcd014_btl = 0
              IF sr3.srcd901 = '2' THEN 
                 LET l_count = 0
                 #项目说明 srcd009
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad009',sr3.srcdseq) RETURNING sr3.l_srcd009,l_cnt            
                 LET sr3.l_srcd009_btl = 0.5
                 LET sr3.l_srcd009_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_srcd009_btl = 0
                    LET sr3.l_srcd009_desc_btl = 0
                    LET sr3.l_srcd009 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF  
                 #形态 l_srcd010_desc_btl 
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad010',sr3.srcdseq) RETURNING sr3.l_srcd010,l_cnt            
                 LET sr3.l_srcd010_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_srcd010_desc_btl = 0
                    LET sr3.l_srcd010 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                  
                 #下限 l_srcd011_btl
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad011',sr3.srcdseq) RETURNING sr3.l_srcd011,l_cnt            
                 LET sr3.l_srcd011_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_srcd011_btl = 0
                    LET sr3.l_srcd011 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #上限 l_srcd012_btl  
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad012',sr3.srcdseq) RETURNING sr3.l_srcd012,l_cnt            
                 LET sr3.l_srcd012_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_srcd012_btl = 0
                    LET sr3.l_srcd012 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #默认值 l_srcd013_btl  
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad013',sr3.srcdseq) RETURNING sr3.l_srcd013,l_cnt            
                 LET sr3.l_srcd013_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_srcd013_btl = 0
                    LET sr3.l_srcd013 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #必要 l_srcd014_btl 
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad014',sr3.srcdseq) RETURNING sr3.l_srcd014,l_cnt            
                 LET sr3.l_srcd014_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_srcd014_btl = 0
                    LET sr3.l_srcd014 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 IF l_count <> 0 THEN
                     LET sr3.l_show = 'Y'
                 END IF
                  
                 #项目说明：l_srcd009
                 IF NOT cl_null(sr3.l_srcd009) THEN 
                    CALL asrr801_g01_desc('2','223',sr3.l_srcd009) RETURNING sr3.l_srcd009_desc1
                 END IF
                 #形态:l_srcd010
                 IF NOT cl_null(sr3.l_srcd010) THEN 
                    CALL asrr801_g01_desc('1','1201',sr3.l_srcd010) RETURNING sr3.l_srcd010_desc1
                    LET sr3.l_srcd010_desc1 = sr3.l_srcd010,'.',sr3.l_srcd010_desc1
                 END IF
                 #变更类型:l_srcd901
                 IF NOT cl_null(sr3.l_srcd901) THEN 
                    CALL asrr801_g01_desc('1','5448',sr3.l_srcd901) RETURNING sr3.l_srcd901_desc1
                    LET sr3.l_srcd901_desc1 = sr3.l_srcd901,'.',sr3.l_srcd901_desc1
                 END IF
                 #变更理由:l_srcd905
                 IF NOT cl_null(sr3.l_srcd905) THEN 
                   CALL asrr801_g01_desc('2',g_acc,sr3.l_srcd905) RETURNING sr3.l_srcd905_desc1
                   LET sr3.l_srcd905_desc1 = sr3.l_srcd905,'.',sr3.l_srcd905_desc1
                 END IF
              END IF
              #end add-point:rep.sub05.foreach
              
           OUTPUT TO REPORT asrr801_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT asrr801_g01_subrep05
           
-----------子报表二：CHECK OUT 项目------    
           LET g_sql = " SELECT DISTINCT srcdseq,srcd009,NULL,NULL,NULL,srcd010,NULL,NULL,NULL,srcd011,NULL,srcd012,NULL,srcd013,NULL,",
                       " srcd014,NULL,srcd901,NULL,NULL,NULL,srcd905,NULL,NULL,NULL,srcd906,NULL,'0','0','0','0','0','0','0','N' ",
                       " FROM srcd_t ",
                       " WHERE srcdent = ",g_enterprise ,
                       " AND srcdsite = '",g_site ,"' ",
                       " AND srcd000 = '",sr1.srca000,"' ",
                       " AND srcd001 = '",sr1.srca001,"' ",
                       " AND srcd002 = '",sr1.srca002,"' ",
                       " AND srcd004 = '",sr1.srca004,"' ",
                       " AND srcd900 = '",sr1.srca900,"' ",
                       " AND srcd007 = '",sr1.srcc007,"' ",
                       " AND srcd008 = '2' "
           #BOM特性
           IF NOT cl_null(sr1.srca005) THEN
              LET g_sql = g_sql," AND srcd005 = '",sr1.srca005,"' "
           END IF
           #產品特征
           IF NOT cl_null(sr1.srca006) THEN
              LET g_sql = g_sql," AND srcd006 = '",sr1.srca006,"' "
           END IF
           IF tm.pr = 'N' THEN 
              LET g_sql = g_sql CLIPPED ," AND srcd901 <>'4' "
           END IF
           LET g_sql = g_sql CLIPPED ," ORDER BY srcdseq "
           #add-point:rep.sub06.afsql

           #end add-point:rep.sub06.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr801_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE asrr801_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show
           START REPORT asrr801_g01_subrep06
           DECLARE asrr801_g01_repcur06 CURSOR FROM g_sql
           FOREACH asrr801_g01_repcur06 INTO sr4.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr801_g01_repcur06:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub06.foreach
              #项目说明：srcd009
              IF NOT cl_null(sr4.srcd009) THEN 
                CALL asrr801_g01_desc('2','223',sr4.srcd009) RETURNING sr4.l_srcd009_desc
              END IF
              #形态:srcd010
              IF NOT cl_null(sr4.srcd010) THEN 
                CALL asrr801_g01_desc('1','1201',sr4.srcd010) RETURNING sr4.l_srcd010_desc
                LET sr4.l_srcd010_desc = sr4.srcd010,'.',sr4.l_srcd010_desc
              END IF
              #变更类型:srcd901
              IF NOT cl_null(sr4.srcd901) THEN 
                CALL asrr801_g01_desc('1','5448',sr4.srcd901) RETURNING sr4.l_srcd901_desc
                LET sr4.l_srcd901_desc = sr4.srcd901,'.',sr4.l_srcd901_desc
              END IF
              #变更理由:srcd905
              IF NOT cl_null(sr4.srcd905) THEN 
                CALL asrr801_g01_desc('2',g_acc,sr4.srcd905) RETURNING sr4.l_srcd905_desc
                LET sr4.l_srcd905_desc = sr4.srcd905,'.',sr4.l_srcd905_desc
              END IF
               --------------变更前资料----------
              LET sr4.l_srcd009_btl = 0
              LET sr4.l_srcd009_desc_btl = 0
              LET sr4.l_srcd010_desc_btl = 0
              LET sr4.l_srcd011_btl = 0
              LET sr4.l_srcd012_btl = 0
              LET sr4.l_srcd013_btl = 0
              LET sr4.l_srcd014_btl = 0
              IF sr4.srcd901 = '2' THEN 
                 LET l_count = 0
                 #项目说明 srcd009
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad009',sr4.srcdseq) RETURNING sr4.l_srcd009,l_cnt            
                 LET sr4.l_srcd009_btl = 0.5
                 LET sr4.l_srcd009_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr4.l_srcd009_btl = 0
                    LET sr4.l_srcd009_desc_btl = 0
                    LET sr4.l_srcd009 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF  
                 #形态 l_srcd010_desc_btl 
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad010',sr4.srcdseq) RETURNING sr4.l_srcd010,l_cnt            
                 LET sr4.l_srcd010_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr4.l_srcd010_desc_btl = 0
                    LET sr4.l_srcd010 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                  
                 #下限 l_srcd011_btl
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad011',sr4.srcdseq) RETURNING sr4.l_srcd011,l_cnt            
                 LET sr4.l_srcd011_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr4.l_srcd011_btl = 0
                    LET sr4.l_srcd011 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #上限 l_srcd012_btl  
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad012',sr4.srcdseq) RETURNING sr4.l_srcd012,l_cnt            
                 LET sr4.l_srcd012_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr4.l_srcd012_btl = 0
                    LET sr4.l_srcd012 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #默认值 l_srcd013_btl  
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad013',sr4.srcdseq) RETURNING sr4.l_srcd013,l_cnt            
                 LET sr4.l_srcd013_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr4.l_srcd013_btl = 0
                    LET sr4.l_srcd013 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #必要 l_srcd014_btl 
                 CALL asrr801_g01_chg(sr1.srcaent,sr1.srca000,sr1.srca001,sr1.srca002,sr1.srca004,sr1.srca005,sr1.srca006,sr1.srcc007,sr1.srca900,'srad014',sr4.srcdseq) RETURNING sr4.l_srcd014,l_cnt            
                 LET sr4.l_srcd014_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr4.l_srcd014_btl = 0
                    LET sr4.l_srcd014 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 IF l_count <> 0 THEN
                     LET sr4.l_show = 'Y'
                 END IF
                  
                 #项目说明：l_srcd009
                 IF NOT cl_null(sr4.l_srcd009) THEN 
                    CALL asrr801_g01_desc('2','223',sr4.l_srcd009) RETURNING sr4.l_srcd009_desc1
                 END IF
                 #形态:l_srcd010
                 IF NOT cl_null(sr4.l_srcd010) THEN 
                    CALL asrr801_g01_desc('1','1201',sr4.l_srcd010) RETURNING sr4.l_srcd010_desc1
                    LET sr4.l_srcd010_desc1 = sr4.l_srcd010,'.',sr4.l_srcd010_desc1
                 END IF
                 #变更类型:l_srcd901
                 IF NOT cl_null(sr4.l_srcd901) THEN 
                    CALL asrr801_g01_desc('1','5448',sr4.l_srcd901) RETURNING sr4.l_srcd901_desc1
                    LET sr4.l_srcd901_desc1 = sr4.l_srcd901,'.',sr4.l_srcd901_desc1
                 END IF
                 #变更理由:l_srcd905
                 IF NOT cl_null(sr4.l_srcd905) THEN 
                   CALL asrr801_g01_desc('2',g_acc,sr4.l_srcd905) RETURNING sr4.l_srcd905_desc1
                   LET sr4.l_srcd905_desc1 = sr4.l_srcd905,'.',sr4.l_srcd905_desc1
                 END IF
              END IF
              #end add-point:rep.sub06.foreach
              
           OUTPUT TO REPORT asrr801_g01_subrep06(sr4.*)
           END FOREACH
           FINISH REPORT asrr801_g01_subrep06
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.srcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_key CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.srcc007 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr801_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asrr801_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asrr801_g01_subrep03
           DECLARE asrr801_g01_repcur03 CURSOR FROM g_sql
           FOREACH asrr801_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr801_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asrr801_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asrr801_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_key
 
           #add-point:rep.a_group.l_key.before name="rep.a_group.l_key.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.srcaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_key CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asrr801_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asrr801_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asrr801_g01_subrep04
           DECLARE asrr801_g01_repcur04 CURSOR FROM g_sql
           FOREACH asrr801_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asrr801_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asrr801_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asrr801_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_key.after name="rep.a_group.l_key.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.srcc007
 
           #add-point:rep.a_group.srcc007.before name="rep.a_group.srcc007.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.srcc007.after name="rep.a_group.srcc007.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asrr801_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asrr801_g01_subrep01(sr2)
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
PRIVATE REPORT asrr801_g01_subrep02(sr2)
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
PRIVATE REPORT asrr801_g01_subrep03(sr2)
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
PRIVATE REPORT asrr801_g01_subrep04(sr2)
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
 
{<section id="asrr801_g01.other_function" readonly="Y" >}

#GET DESC
PRIVATE FUNCTION asrr801_g01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
   WHEN '1' #获取SCC码说明
      SELECT gzcbl004 INTO r_desc
        FROM gzcbl_t
       WHERE gzcbl001 = p_num
         AND gzcbl002 = p_target
         AND gzcbl003 = g_dlang
         
   WHEN '2' #获取ACC码说明
      SELECT oocql004 INTO r_desc
        FROM oocql_t
       WHERE oocql001 = p_num
         AND oocql002 = p_target
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise

   WHEN '3' #获取工作站名称
      SELECT ecaa002 INTO r_desc
        FROM ecaa_t
       WHERE ecaa001 = p_target
         AND ecaasite = g_site
         AND ecaaent = g_enterprise
         
   WHEN '4' #获取加工厂商名称
      SELECT pmaal004 INTO r_desc
        FROM pmaal_t
       WHERE pmaal001 = p_target
         AND pmaal002 = g_dlang
         AND pmaalent = g_enterprise
         
   END CASE
   
   RETURN r_desc 
END FUNCTION

################################################################################
# Descriptions...: 獲取變更前資料
# Memo...........:
# Usage..........: CALL asrr801_g01_chg(p_srcfent,p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcf007,p_srcfseq)
#                  RETURNING r_srcf010,r_cnt
# Input parameter: p_srcfent      營運據點
#                : p_srcf000      類型
#                : p_srcf001      生產計劃
#                : p_srcf002      製程編號
#                : p_srcf003      料件編號
#                : p_srcf004      BOM特性
#                : p_srcf005      產品特征
#                : p_srcf006      項次
#                : p_srcf007      變更序
#                : p_srcf008      變更欄位
#                : p_srcfseq      項序
# Return code....: r_srcf010      變更前值
#                : r_cnt          線寬
# Date & Author..: 2015-5-15 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION asrr801_g01_chg(p_srcfent,p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcf007,p_srcf008,p_srcfseq)
DEFINE p_srcfent   LIKE srcf_t.srcfent   
DEFINE p_srcf000   LIKE srcf_t.srcf000   #類型
DEFINE p_srcf001   LIKE srcf_t.srcf001
DEFINE p_srcf002   LIKE srcf_t.srcf002
DEFINE p_srcf003   LIKE srcf_t.srcf003   
DEFINE p_srcf004   LIKE srcf_t.srcf004   
DEFINE p_srcf005   LIKE srcf_t.srcf005
DEFINE p_srcf006   LIKE srcf_t.srcf006
DEFINE p_srcf007   LIKE srcf_t.srcf007   #變更序
DEFINE p_srcf008   LIKE srcf_t.srcf008   #變更欄位名稱
DEFINE p_srcfseq   LIKE srcf_t.srcfseq
DEFINE r_cnt       LIKE type_t.num5
DEFINE r_srcf010   LIKE srcf_t.srcf010   #變更前欄位數值

   LET r_srcf010  = ''
   LET r_cnt = 0
   IF cl_null(p_srcf005) THEN
      SELECT COUNT(*) INTO r_cnt
      FROM srcf_t
      WHERE srcfent = p_srcfent AND srcfsite = g_site
         AND srcf000 = p_srcf000
         AND srcf001 = p_srcf001
         AND srcf002 = p_srcf002
         AND srcf003 = p_srcf003
         AND srcf004 = p_srcf004
         AND srcf006 = p_srcf006
         AND srcfseq = p_srcfseq
         AND srcf007 = p_srcf007
         AND srcf008 = p_srcf008
         AND srcf010 IS NOT NULL
      IF r_cnt ! =0 THEN 
         SELECT srcf010 INTO r_srcf010
           FROM srcf_t
          WHERE srcfent = p_srcfent AND srcfsite = g_site
            AND srcf000 = p_srcf000
            AND srcf001 = p_srcf001
            AND srcf002 = p_srcf002
            AND srcf003 = p_srcf003
            AND srcf004 = p_srcf004
            AND srcf006 = p_srcf006
            AND srcfseq = p_srcfseq
            AND srcf007 = p_srcf007
            AND srcf008 = p_srcf008
            AND srcf010 IS NOT NULL
      END IF
   ELSE
      SELECT COUNT(*) INTO r_cnt
      FROM srcf_t
      WHERE srcfent = p_srcfent AND srcfsite = g_site
         AND srcf000 = p_srcf000
         AND srcf001 = p_srcf001
         AND srcf002 = p_srcf002
         AND srcf003 = p_srcf003
         AND srcf004 = p_srcf004
         AND srcf005 = p_srcf005
         AND srcf006 = p_srcf006
         AND srcfseq = p_srcfseq
         AND srcf007 = p_srcf007
         AND srcf008 = p_srcf008
         AND srcf010 IS NOT NULL
      IF r_cnt ! =0 THEN 
         SELECT srcf010 INTO r_srcf010
           FROM srcf_t
          WHERE srcfent = p_srcfent AND srcfsite = g_site
            AND srcf000 = p_srcf000
            AND srcf001 = p_srcf001
            AND srcf002 = p_srcf002
            AND srcf003 = p_srcf003
            AND srcf004 = p_srcf004
            AND srcf005 = p_srcf005
            AND srcf006 = p_srcf006
            AND srcfseq = p_srcfseq
            AND srcf007 = p_srcf007
            AND srcf008 = p_srcf008
            AND srcf010 IS NOT NULL
      END IF
   END IF
#   IF r_cnt ! =0 THEN 
#      SELECT srcf010 INTO r_srcf010
#        FROM srcf_t
#       WHERE srcfent = p_srcfent AND srcfsite = g_site
#         AND srcf000 = p_srcf000
#         AND srcf001 = p_srcf001
#         AND srcf002 = p_srcf002
#         AND srcf003 = p_srcf003
#         AND srcf004 = p_srcf004
#         AND srcf005 = p_srcf005
#         AND srcf006 = p_srcf006
#         AND srcfseq = p_srcfseq
#         AND srcf007 = p_srcf007
#         AND srcf010 IS NOT NULL
#   END IF

      RETURN r_srcf010,r_cnt
END FUNCTION

 
{</section>}
 
{<section id="asrr801_g01.other_report" readonly="Y" >}

PRIVATE REPORT asrr801_g01_subrep05(sr3)
DEFINE sr3        sr3_r

   ORDER EXTERNAL BY sr3.srcdseq
   FORMAT
        
        ON EVERY ROW
#            #底线粗细
#            LET btl_2.l_srcd009_btl = 0
#            LET btl_2.l_srcd009_desc_btl = 0
#            LET btl_2.l_srcd010_desc_btl = 0
#            LET btl_2.l_srcd011_btl = 0
#            LET btl_2.l_srcd012_btl = 0
#            LET btl_2.l_srcd013_btl = 0
#            LET btl_2.l_srcd014_btl = 0
#            LET btl_2.l_srcd901_desc_btl = 0
#            LET btl_2.l_srcd905_desc_btl = 0
#            LET btl_2.l_srcd906_btl = 0
#            IF NOT cl_null(sr3.l_srcd009) THEN
#               LET btl_2.l_srcd009_btl = 0.5
#               LET btl_2.l_srcd009_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd010_desc1) THEN
#               LET btl_2.l_srcd010_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd011) THEN
#               LET btl_2.l_srcd011_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd012) THEN
#               LET btl_2.l_srcd012_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd013) THEN
#               LET btl_2.l_srcd013_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd014) THEN
#               LET btl_2.l_srcd014_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd901_desc) THEN
#               LET btl_2.l_srcd901_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd905_desc) THEN
#               LET btl_2.l_srcd905_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr3.l_srcd906) THEN
#               LET btl_2.l_srcd906_btl = 0.5
#            END IF
            PRINTX g_grNumFmt.*
#            PRINTX btl_2.*
            PRINTX sr3.*
END REPORT

PRIVATE REPORT asrr801_g01_subrep06(sr4)
DEFINE sr4        sr3_r

   ORDER EXTERNAL BY sr4.srcdseq
   FORMAT
           
        ON EVERY ROW
#            #底线粗细
#            LET btl_2.l_srcd009_btl = 0
#            LET btl_2.l_srcd009_desc_btl = 0
#            LET btl_2.l_srcd010_desc_btl = 0
#            LET btl_2.l_srcd011_btl = 0
#            LET btl_2.l_srcd012_btl = 0
#            LET btl_2.l_srcd013_btl = 0
#            LET btl_2.l_srcd014_btl = 0
#            LET btl_2.l_srcd901_desc_btl = 0
#            LET btl_2.l_srcd905_desc_btl = 0
#            LET btl_2.l_srcd906_btl = 0
#            IF NOT cl_null(sr4.l_srcd009) THEN
#               LET btl_2.l_srcd009_btl = 0.5
#               LET btl_2.l_srcd009_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd010_desc1) THEN
#               LET btl_2.l_srcd010_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd011) THEN
#               LET btl_2.l_srcd011_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd012) THEN
#               LET btl_2.l_srcd012_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd013) THEN
#               LET btl_2.l_srcd013_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd014) THEN
#               LET btl_2.l_srcd014_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd901_desc) THEN
#               LET btl_2.l_srcd901_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd905_desc) THEN
#               LET btl_2.l_srcd905_desc_btl = 0.5
#            END IF
#            IF NOT cl_null(sr4.l_srcd906) THEN
#               LET btl_2.l_srcd906_btl = 0.5
#            END IF
            PRINTX g_grNumFmt.*
#            PRINTX btl_2.*
            PRINTX sr4.*
END REPORT

PRIVATE REPORT asrr801_g01_subrep07(sr5)
    DEFINE sr5 sr4_r 
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

 
{</section>}
 
