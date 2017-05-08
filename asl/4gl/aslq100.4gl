#該程式未解開Section, 採用最新樣板產出!
{<section id="aslq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2017-02-06 13:51:38), PR版次:0003(2017-02-06 11:14:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslq100
#+ Description: 多據點庫存明細查詢作業
#+ Creator....: 06189(2016-11-22 15:12:19)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="aslq100.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160225-00010#1  2016/03/22 By lixh     在捡量页签，取消inag_t与inap_t 的储位批号关联（inap_t 可能没有记录储位批号）
#160512-00004#2  2016/06/15 By dorislai 新增製造日期的欄位(inad014)
#160512-00004#1  2016/06/20 By Whitney  inai012製造日期改抓inae010
#160512-00004#5  2016/06/28 By dorislai 新增有效日期的欄位(inae011)
#160810-00034#1  2016/08/19 By lixh     在揀量資料抓取，在揀量明細抓取的方式，除了自已本身外，還需要往下抓
#161019-00017#8  2016/10/19 By zhujing  据点组织开窗资料整批调整
#161019-00023#1  2016/10/25 By lixh     增加备置量明细显示（xmdr_t/sfbb_t）
#161107-00033#1  2016/10/25 By lixh     在捡量改从inan_t抓取
#161006-00018#29 2016/11/17 By lixh     1.aslq100在揀量、備置量的部分都改成直接抓inan的資料呈現
#.......................................2.增加顯示備置明細 (#161019-00023#1&#161107-00033#1已处理)
#170116-00018#7  2017/01/17 by 08172    1.去掉所有储位、批号、有效日期、制造日期、呆滞日期、最近盘点日期、下次检验日期、最后一次检验日期、拣货优先序字段、查询条件，以及相关逻辑；
#                                       2.调整'在拣量数据'页签，去掉营运据点、料件、特征、库存管理特征、库位编号、库位名称、异动指令、加减项字段，增加项序、分批序字段；全部字段修改inas取值
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_inag_d RECORD
   b_inagsite       LIKE inag_t.inagsite,
   b_inagsite_desc  LIKE type_t.chr500,
   b_inag001 LIKE inag_t.inag001, 
   b_inag001_desc LIKE type_t.chr500,
   b_inag001_desc_1 LIKE type_t.chr500,   
   b_inag002 LIKE inag_t.inag002,
   b_inag002_desc LIKE type_t.chr500,
   b_imaa154 LIKE imaa_t.imaa154, 
   b_imaa155 LIKE imaa_t.imaa155,
   b_imaa133 LIKE imaa_t.imaa133, 
   b_imaa133_desc LIKE type_t.chr500, 
   b_rtax001 LIKE rtax_t.rtax001, 
   b_rtax001_desc LIKE type_t.chr500, 
   b_rtax001_1 LIKE rtax_t.rtax001, 
   b_rtax001_1_desc LIKE type_t.chr500,
   b_imaa156 LIKE imaa_t.imaa156, 
   b_imaa116 LIKE imaa_t.imaa116,
   b_imaa126 LIKE imaa_t.imaa126,
   b_imaa126_desc LIKE type_t.chr500,
   b_imaa132 LIKE imaa_t.imaa132,
   b_imaa132_desc LIKE type_t.chr500,
   b_imaa127 LIKE imaa_t.imaa127,
   b_imaa127_desc LIKE type_t.chr500,
   b_imaa131 LIKE imaa_t.imaa131,
   b_imaa131_desc LIKE type_t.chr500,
   b_inag004 LIKE inag_t.inag004, 
   b_inag004_desc LIKE type_t.chr500, 
   b_inag005 LIKE inag_t.inag005, 
   b_inag005_desc LIKE type_t.chr500, 
   b_inag006 LIKE inag_t.inag006, 
   b_inag003 LIKE inag_t.inag003, 
   b_inag007 LIKE inag_t.inag007, 
   b_inag007_desc LIKE type_t.chr500,
   b_inad014 LIKE inad_t.inad014,     #160512-00004#2-add
   b_inad011 LIKE inad_t.inad011, 
   b_inag027 LIKE inag_t.inag027
       END RECORD
       
 TYPE type_g_inag2_d RECORD
   l_inagsite_1       LIKE inag_t.inagsite,
   l_inagsite_1_desc  LIKE type_t.chr500,
   l_inag001_1 LIKE type_t.chr500, 
   l_inag001_1_desc LIKE type_t.chr500, 
   l_inag001_1_desc_1 LIKE type_t.chr500, 
   l_inag002_1 LIKE type_t.chr500,
   l_inag002_1_desc LIKE type_t.chr500,    
   l_inad014_1 LIKE inad_t.inad014,     #160512-00004#2-add
   l_inad011_1 LIKE type_t.dat, 
   l_inag004_1 LIKE type_t.chr10, 
   l_inag004_1_desc LIKE type_t.chr500, 
   l_inag005_1 LIKE type_t.chr10, 
   l_inag005_1_desc LIKE type_t.chr500, 
   l_inag006_1 LIKE type_t.chr30, 
   l_inag003_1 LIKE type_t.chr30,
   l_inag007_1 LIKE type_t.chr10, 
   l_inag007_1_desc LIKE type_t.chr500, 
   l_inag008_1 LIKE type_t.num20_6,   
   l_inap013_1 LIKE type_t.num20_6, 
   l_inag021_1 LIKE type_t.num20_6, 
   l_inag024_1 LIKE type_t.chr10, 
   l_inag024_1_desc LIKE type_t.chr500,
   l_inag025_1 LIKE type_t.num20_6, 
   l_inag013_1 LIKE type_t.num5, 
   l_inag016_1 LIKE type_t.dat, 
   l_inag015_1 LIKE type_t.dat, 
   l_inag014_1 LIKE type_t.dat, 
   l_inag026_1 LIKE type_t.dat, 
   l_inag027_1 LIKE type_t.dat, 
   l_inag012_1 LIKE type_t.chr1, 
   l_inag011_1 LIKE type_t.chr1, 
   l_inag010_1 LIKE type_t.chr1, 
   l_inaa015_1 LIKE type_t.chr1, 
   l_inag019_1 LIKE type_t.chr1, 
   l_inag020_1 LIKE type_t.chr10, 
   l_inad012_1 LIKE type_t.chr500
       END RECORD

 TYPE type_g_inag3_d RECORD
   inaisite          LIKE inai_t.inaisite,
   inaisite_desc     LIKE type_t.chr500,
   inai001 LIKE inai_t.inai001, 
   inai001_desc LIKE type_t.chr500, 
   inai001_desc_1 LIKE type_t.chr500, 
   inai002 LIKE inai_t.inai002,
   inai002_desc LIKE type_t.chr500,  
   inai003 LIKE inai_t.inai003, 
   inai004 LIKE inai_t.inai004, 
   inai004_desc LIKE type_t.chr500, 
   inai005 LIKE inai_t.inai005, 
   inai005_desc LIKE type_t.chr500, 
   inai006 LIKE inai_t.inai006, 
   inai007 LIKE inai_t.inai007, 
   inai008 LIKE inai_t.inai008, 
  #inai012 LIKE inai_t.inai012,  #160512-00004#1 by whitney mark
   inae010 LIKE inae_t.inae010,  #160512-00004#1 by whitney add
   inae011 LIKE inae_t.inae011,  #160512-00004#5-add
   inai010 LIKE inai_t.inai010
       END RECORD
       
 TYPE type_g_inag4_d RECORD
   inapsite        LIKE inap_t.inapsite,
   inapsite_desc   LIKE type_t.chr500,
   inap004 LIKE inap_t.inap004, 
   inap004_desc LIKE type_t.chr500, 
   inap004_desc_1 LIKE type_t.chr500, 
   inap005 LIKE inap_t.inap005,
   inap005_desc LIKE type_t.chr500,   
   inap006 LIKE inap_t.inap006, 
   inap007 LIKE inap_t.inap007, 
   inap007_desc LIKE type_t.chr500, 
   inap008 LIKE inap_t.inap008, 
   inap008_desc LIKE type_t.chr500, 
   inap009 LIKE inap_t.inap009, 
   inap014 LIKE inap_t.inap014,
   inax002 LIKE inax_t.inax002,   
   inap001 LIKE inap_t.inap001, 
   inap002 LIKE inap_t.inap002, 
   inap003 LIKE inap_t.inap003,
   xmdrseq2  LIKE xmdr_t.xmdrseq2,
   #170116-00018#7 -s 20170203 add by 08172
   inas005 LIKE inas_t.inas005,
   inas006 LIKE inas_t.inas006,
   inas007 LIKE inas_t.inas007,
   inas008 LIKE inas_t.inas008,
   inap013 LIKE inap_t.inap013,
   inas012 LIKE inas_t.inas012,
   inas013 LIKE inas_t.inas013,
   inas014 LIKE inas_t.inas014,
   #170116-00018#7 -e 20170203 add by 08172
   inax003 LIKE inax_t.inax003, 
#   inap013 LIKE inap_t.inap013,  #170116-00018#7 20170203 mark by 08172
   inap017 LIKE inap_t.inap017, 
   inap017_desc LIKE type_t.chr500, 
   inap018 LIKE inap_t.inap018, 
   inap018_desc LIKE type_t.chr500
       END RECORD    #161019-00023#1 add xmdrseq2 
TYPE type_g_inaa_d RECORD 
     inaa010     LIKE inaa_t.inaa010,
     inaa008     LIKE inaa_t.inaa008,
     inag019     LIKE inag_t.inag019,
     inaa009     LIKE inaa_t.inaa009,
     inaa015     LIKE inaa_t.inaa015,
     inaa016     LIKE inaa_t.inaa016,
     l_print     LIKE inag_t.inag019
        END RECORD
 TYPE type_g_inag1_d RECORD
   l_inagsite  LIKE inag_t.inagsite,
   l_inag001 LIKE inag_t.inag019, 
   l_inag002 LIKE inag_t.inag019, 
   l_inag004 LIKE inag_t.inag019, 
   l_inag005 LIKE inag_t.inag019, 
   l_inag006 LIKE inag_t.inag019, 
   l_inag003 LIKE inag_t.inag019,
   l_inag007 LIKE inag_t.inag019, 
   l_inad014 LIKE type_t.chr1,  #160512-00004#2-add  
   l_inad011 LIKE inag_t.inag019, 
   l_inag027 LIKE inag_t.inag019   
       END RECORD   
  TYPE type_g_inag RECORD
    inagsite  LIKE inag_t.inagsite,
    imaa009 LIKE type_t.chr1000,
    inag001 LIKE type_t.chr1000,
    inag002 LIKE type_t.chr1000, 
    inag004 LIKE type_t.chr1000, 
    inag005 LIKE type_t.chr1000, 
    inag006 LIKE type_t.chr1000, 
    inag003 LIKE type_t.chr1000,
    inad014 LIKE type_t.chr1000, #160512-00004#2-add
    inad011 LIKE type_t.chr1000, 
    inag027 LIKE type_t.chr1000, 
    inag014 LIKE type_t.chr1000   
       END RECORD
#模組變數(Module Variables)
DEFINE g_inaa_d      type_g_inaa_d
DEFINE g_inag        type_g_inag
DEFINE g_inag1_d     type_g_inag1_d
DEFINE g_inag_d      DYNAMIC ARRAY OF type_g_inag_d
DEFINE g_inag_d_t    type_g_inag_d
DEFINE g_inag2_d     DYNAMIC ARRAY OF type_g_inag2_d
DEFINE g_inag2_d_t   type_g_inag2_d
 
DEFINE g_inag3_d     DYNAMIC ARRAY OF type_g_inag3_d
DEFINE g_inag3_d_t   type_g_inag3_d
 
DEFINE g_inag4_d     DYNAMIC ARRAY OF type_g_inag4_d
DEFINE g_inag4_d_t   type_g_inag4_d
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件       
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num5              #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num5
DEFINE g_detail_cnt          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址

#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
DEFINE g_wc2_filter_table3   STRING
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_cnt2                 LIKE type_t.num10              
DEFINE l_ac2                  LIKE type_t.num5              #目前處理的ARRAY CNT
DEFINE g_cnt3                 LIKE type_t.num10              
DEFINE l_ac3                  LIKE type_t.num5              #目前處理的ARRAY CNT
DEFINE g_cnt4                 LIKE type_t.num10              
DEFINE l_ac4                  LIKE type_t.num5              #目前處理的ARRAY CNT

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="aslq100.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asl","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = ""
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE aslq100_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aslq100 WITH FORM cl_ap_formpath("asl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aslq100_init()
 
      #進入選單 Menu (='N')
      CALL aslq100_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_aslq100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="aslq100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aslq100_init()
   #add-point:init段define

   #end add-point

   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"

   CALL cl_set_comp_visible("page",FALSE) 
   
   #add-point:畫面資料初始化
#   IF g_code = 'ainq121' THEN
#      LET g_argv[01] = '2'
#   ELSE
#      LET g_argv[01] = '1'   
#   END IF    
#   IF cl_null(g_argv[01]) THEN
#      IF g_code = 'ainq121' THEN
#         LET g_argv[01] = '2'
#      ELSE
#         LET g_argv[01] = '1'   
#      END IF   
#   END IF
#   IF g_argv[01] = '1' THEN
#      CALL cl_set_comp_visible("inagsite,l_inagsite",FALSE)
#      CALL cl_set_comp_visible("b_inagsite,b_inagsite_desc",FALSE)
#      CALL cl_set_comp_visible("l_inagsite_1,l_inagsite_1_desc,inaisite,inaisite_desc,inapsite,inapsite_desc",FALSE)      
#   END IF
   LET g_inag1_d.l_inag001 = 'Y'
   LET g_inag1_d.l_inagsite = 'N'
   LET g_inag1_d.l_inag002 = 'N'
   LET g_inag1_d.l_inag003 = 'N'
   LET g_inag1_d.l_inag004 = 'N'
   LET g_inag1_d.l_inag005 = 'N'
   LET g_inag1_d.l_inag006 = 'N'
   LET g_inag1_d.l_inag007 = 'N'
   LET g_inag1_d.l_inad014 = 'N'  #160512-00004#2-add
   LET g_inag1_d.l_inad011 = 'N'
   LET g_inag1_d.l_inag027 = 'N'
   LET g_inaa_d.l_print = 'Y'
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("b_inag002,b_inag002_desc",FALSE)
      CALL cl_set_comp_visible("l_inag002_1,l_inag002_1_desc",FALSE)
      CALL cl_set_comp_visible("inai002,inai002_desc",FALSE)
      CALL cl_set_comp_visible("inap005,inap005_desc",FALSE)
   END IF    
   CALL cl_set_combo_scc('b_imaa155','6940') 
   CALL cl_set_combo_scc('imaa156','6941')
   CALL cl_set_combo_scc('b_imaa156','6941') 
   CALL cl_set_combo_scc_part('inap014','6978','2,14,15,16')
   CALL cl_set_combo_scc('inax002','2045')    
   #end add-point

END FUNCTION

#库存明细资料页签显示
PRIVATE FUNCTION aslq100_b_fill2(p_ac)
DEFINE p_ac               LIKE type_t.num5
DEFINE ls_wc              STRING
   IF cl_null(p_ac) OR p_ac = 0 THEN
      RETURN
   END IF

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF

   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   CALL g_inag2_d.clear()
   #160512-00004#2-add-'inad014'
   #LET g_sql = "SELECT UNIQUE inagsite,'',inag001,'','',inag002,'',inad014,inad011,inag004,'',inag005,'',inag006,inag003,inag007,'',inag008,'',inan010,", #mark by geza 20161210 #161124-00039#2
   #170116-00018#7 -s 20170103 mark by 08172 
#   LET g_sql = "SELECT UNIQUE inagsite,'',inag001,'','',inag002,'',inad014,inad011,inag004,'',inag005,'',inag006,inag003,inag007,'',inag009,'',inan010,", #add by geza 20161210 #161124-00039#2  
#               "inag024,'',inag025,inag013,inag016,inag015,inag014,inag026,inag027,inag012,inag011,inag010,'',inag019,inag020,inad012",
   #170116-00018#7 -e 20170103 mark by 08172 
   #170116-00018#7 -s 20170103 add by 08172 
   LET g_sql = "SELECT UNIQUE inagsite,'',inag001,'','',inag002,'','','','','','','','',inag003,inag007,'',SUM(COALESCE(inag009,0)) inag009,'',", 
               "SUM(COALESCE(inag021,0)) inag021,inag024,'',SUM(COALESCE(inag025,0)) inag025,'','',MAX(inag015) inag015,'','','','','','','',inag019,inag020,inad012",
   #170116-00018#7 -e 20170103 add by 08172 
               " FROM inag_t ",
               " LEFT JOIN inan_t ON inanent = inagent AND inansite = inagsite AND inan001 = inag001 AND inan002 = inag002 AND inan004 =inag004 AND inan005 =inag005 AND inan006 =inag006 AND inan000 = '2' ",  #add by lixh 20151027               
               " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 =inag006 ",
               ",inaa_t,imaa_t ",                
               " WHERE inagent = inaaent AND inagsite = inaasite AND inag004 = inaa001  AND imaaent = inagent AND imaa001 = inag001 AND inagent=",g_enterprise
   IF g_inaa_d.l_print = 'Y' THEN      
      #LET g_sql = g_sql,"  AND inag008 <> 0 " #mark by geza 20161210 #161124-00039#2
      LET g_sql = g_sql,"  AND inag009 <> 0 " #add by geza 20161210 #161124-00039#2
   END IF            
#   #add by lixh 20141226
#   IF g_inag_d[p_ac].b_inagsite IS NOT NULL THEN
#      LET g_sql = g_sql," AND inagsite='",g_inag_d[p_ac].b_inagsite,"'"
#   END IF
#   #add by lixh 20141226
   LET g_sql = g_sql," AND inagsite='",g_inag_d[p_ac].b_inagsite,"'"
   #add by lixh 20151027
   IF g_inag_d[p_ac].b_inag001 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag001='",g_inag_d[p_ac].b_inag001,"'"
   END IF
   IF g_inag_d[p_ac].b_inag002 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag002='",g_inag_d[p_ac].b_inag002,"'"
   END IF
   IF g_inag_d[p_ac].b_inag003 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag003='",g_inag_d[p_ac].b_inag003,"'"
   END IF
   IF g_inag_d[p_ac].b_inag004 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag004='",g_inag_d[p_ac].b_inag004,"'"
   END IF
   IF g_inag_d[p_ac].b_inag005 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag005='",g_inag_d[p_ac].b_inag005,"'"
   END IF
   IF g_inag_d[p_ac].b_inag006 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag006='",g_inag_d[p_ac].b_inag006,"'"
   END IF
   IF g_inag_d[p_ac].b_inag007 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag007='",g_inag_d[p_ac].b_inag007,"'"
   END IF
   #160512-00004#2-add-(S) 製造日期
   IF g_inag_d[p_ac].b_inad014 IS NOT NULL THEN
      LET g_sql = g_sql," AND inad014='",g_inag_d[p_ac].b_inad014,"'"
   END IF
   #160512-00004#2-add-(E)
   IF g_inag_d[p_ac].b_inad011 IS NOT NULL THEN
      LET g_sql = g_sql," AND inad011='",g_inag_d[p_ac].b_inad011,"'"
   END IF
   IF g_inag_d[p_ac].b_inag027 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag027='",g_inag_d[p_ac].b_inag027,"'"
   END IF
 
   IF NOT cl_null(g_inaa_d.inaa008) THEN
      LET g_sql = g_sql," AND inaa008='",g_inaa_d.inaa008,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa009) THEN
      LET g_sql = g_sql," AND inaa009='",g_inaa_d.inaa009,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa010) THEN
      LET g_sql = g_sql," AND inaa010='",g_inaa_d.inaa010,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa015) THEN
      LET g_sql = g_sql," AND inaa015='",g_inaa_d.inaa015,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa016) THEN
      LET g_sql = g_sql," AND inaa016='",g_inaa_d.inaa016,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inag019) THEN
      LET g_sql = g_sql," AND inag019='",g_inaa_d.inag019,"'"
   END IF
   
   LET g_sql = g_sql," AND ", ls_wc 
   #LET g_sql = g_sql, " ORDER BY inagsite,inag001,inag002,inad011,inag004,inag005,inag006,inag003,inag007,inag008" #mark by geza 20161210 #161124-00039#2
#   LET g_sql = g_sql, " ORDER BY inagsite,inag001,inag002,inad011,inag004,inag005,inag006,inag003,inag007,inag009" #add by geza 20161210 #161124-00039#2  #170116-00018#7 20170203 mark by 08172
   LET g_sql = g_sql, " GROUP BY inagsite,inag001,inag002,inag003,inag007,inag024,inag019,inag020,inad012" #170116-00018#7 20170203 add by 08172
   LET g_sql = g_sql, " ORDER BY inagsite,inag001,inag002,'','','','',inag003,inag007,inag009" #170116-00018#7 20170203 add by 08172
   PREPARE aslq100_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aslq100_pb2
   LET l_ac2 = 1
   FOREACH b_fill_curs2 INTO g_inag2_d[l_ac2].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #161107-00033#1-S mark
      #在拣量
#      SELECT SUM(inap013) INTO g_inag2_d[l_ac2].l_inap013_1 FROM inap_t WHERE inapent=g_enterprise AND inapsite=g_site
#         AND inap004=g_inag2_d[l_ac2].l_inag001_1 AND inap005=g_inag2_d[l_ac2].l_inag002_1
#         AND inap006=g_inag2_d[l_ac2].l_inag003_1 AND inap007=g_inag2_d[l_ac2].l_inag004_1
#         AND inap008=g_inag2_d[l_ac2].l_inag005_1 AND inap009=g_inag2_d[l_ac2].l_inag006_1
#         AND inap012=g_inag2_d[l_ac2].l_inag007_1 
      #161107-00033#1-E mark
      #mark by geza 201611206 161124-00039#1(S)
#      #161107-00033#1-S
#      SELECT inan010 INTO g_inag2_d[l_ac2].l_inap013_1 FROM inan_t
#       WHERE inanent = g_enterprise
#         AND inansite = g_site
#         AND inan000 = '1'
#         AND inan001 = g_inag2_d[l_ac2].l_inag001_1
#         AND inan002 = g_inag2_d[l_ac2].l_inag002_1
#         AND inan003 = g_inag2_d[l_ac2].l_inag003_1
#         AND inan004 = g_inag2_d[l_ac2].l_inag004_1
#         AND inan005 = g_inag2_d[l_ac2].l_inag005_1 
#         AND inan006 = g_inag2_d[l_ac2].l_inag006_1 
#         AND inan007 = g_inag2_d[l_ac2].l_inag007_1          
#      #161107-00033#1-E
#      IF cl_null(g_inag2_d[l_ac2].l_inap013_1) THEN
#         LET g_inag2_d[l_ac2].l_inap013_1 = 0
#      END IF
      #mark by geza 201611206 161124-00039#1(E)
      #170116-00018#7 -s 20170203 mark by 08172
      #add by geza 201611206 161124-00039#1(S)
#      SELECT SUM((CASE WHEN inax002 = '1' THEN 1  ELSE -1 END)*inax014) INTO g_inag2_d[l_ac2].l_inap013_1 
#        FROM inax_t
#       WHERE inaxent = g_enterprise
#         AND inax017 = g_inag_d[p_ac].b_inagsite
#         AND inax010 = g_inag2_d[l_ac2].l_inag001_1
#         AND inax011 = g_inag2_d[l_ac2].l_inag002_1
#         AND inax015 = g_inag2_d[l_ac2].l_inag004_1
#         AND inax013 = g_inag2_d[l_ac2].l_inag007_1 
#         AND inax002 IS NOT NULL  
#         AND inax008||inax009 NOT IN (SELECT a.inax008||a.inax009 as docno FROM inax_t a  WHERE a.inaxent = g_enterprise AND a.inax001 <> '16' AND a.inax002 IS NOT NULL 
#                       AND EXISTS (SELECT 1 FROM inax_t b WHERE b.inaxent=a.inaxent AND a.inax008 =b.inax008 AND b.inax009 = a.inax009 AND a.inax001 = b.inax001 AND b.inax001 <> '16' AND b.inax002 <> a.inax002 AND b.inax002 IS NOT NULL )  )
#
#      IF cl_null(g_inag2_d[l_ac2].l_inap013_1) THEN
#         LET g_inag2_d[l_ac2].l_inap013_1 = 0
#      END IF
      #add by geza 201611206 161124-00039#1(E)
      #170116-00018#7 -e 20170203 mark by 08172
      #170116-00018#7 -s 20170203 add by 08172
      SELECT SUM(inas011) INTO g_inag2_d[l_ac2].l_inap013_1 
        FROM inas_t
       WHERE inasent = g_enterprise
         AND inassite = g_inag_d[p_ac].b_inagsite
         AND inas009 = g_inag2_d[l_ac2].l_inag001_1
         AND inas010 = g_inag2_d[l_ac2].l_inag002_1
         AND inas013 = g_inag2_d[l_ac2].l_inag007_1 

      IF cl_null(g_inag2_d[l_ac2].l_inap013_1) THEN
         LET g_inag2_d[l_ac2].l_inap013_1 = 0
      END IF
      #170116-00018#7 -e 20170203 add by 08172
      #170116-00018#7 -s 20170203 mark by 08172
#      #保税否
#      SELECT inaa015 INTO g_inag2_d[l_ac2].l_inaa015_1 FROM inaa_t WHERE inaaent=g_enterprise AND inaasite=g_site
#         AND inaa001=g_inag2_d[l_ac2].l_inag004_1 
      #170116-00018#7 -e 20170203 mark by 08172
      CALL aslq100_b_fill2_desc()
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   LET g_cnt2 = l_ac2 - 1
   CALL g_inag2_d.deleteElement(l_ac2)
END FUNCTION

PRIVATE FUNCTION aslq100_ui_dialog()
   {<Local define>}
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE ldig_curr ui.Dialog
   DEFINE li_index  LIKE type_t.num5
   
   {</Local define>}
   #add-point:ui_dialog段define

   #end add-point


   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 1
   LET l_ac = 1

   #add-point:ui_dialog段before dialog

   #end add-point


   #CALL aslq100_b_fill()

   WHILE li_exit = FALSE

      CALL cl_dlg_query_bef_disp()  #相關查詢

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
      CONSTRUCT BY NAME g_wc ON inagsite,imaa009,inag001,inag002,inag004,inag005,inag006,inag003,inad014, #160512-00004#2-add-'inad014'
                                inad011,inag027,inag014,imaa154,imaa133,imaa156,imaa126   
         BEFORE CONSTRUCT
            IF cl_null(g_inag.inad011) THEN
               LET g_inag.inad011 = ''
            END IF
            IF cl_null(g_inag.inag027) THEN
               LET g_inag.inag027 = ''
            END IF
            IF cl_null(g_inag.inag014) THEN
               LET g_inag.inag014 = ''
            END IF
            DISPLAY BY NAME g_inag.imaa009,g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,g_inag.inag005,g_inag.inag006,g_inag.inad011,g_inag.inag027,g_inag.inag014
            
         AFTER FIELD imaa009
            LET g_inag.imaa009 = GET_FLDBUF(imaa009)
         
         AFTER FIELD inag001
            LET g_inag.inag001 = GET_FLDBUF(inag001)
            
         AFTER FIELD inag002
            LET g_inag.inag002 = GET_FLDBUF(inag002)

         AFTER FIELD inag003
            LET g_inag.inag003 = GET_FLDBUF(inag003)
            
         AFTER FIELD inag004
            LET g_inag.inag004 = GET_FLDBUF(inag004)
            
         AFTER FIELD inag005
            LET g_inag.inag005 = GET_FLDBUF(inag005)
         
         AFTER FIELD inag006
            LET g_inag.inag006 = GET_FLDBUF(inag006)
            
         AFTER FIELD inad011
            LET g_inag.inad011 = GET_FLDBUF(inad011)
            
         AFTER FIELD inag027
            LET g_inag.inag027 = GET_FLDBUF(inag027)
         
         AFTER FIELD inag014
            LET g_inag.inag014 = GET_FLDBUF(inag014)
 

         ON ACTION controlp INFIELD inagsite
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#            CALL q_ooef001_12()                   #161019-00017#8 marked
            CALL q_ooef001_1()                    #161019-00017#8 add
            DISPLAY g_qryparam.return1 TO inagsite  #顯示到畫面上

            NEXT FIELD inagsite                    #返回原欄位
            
         ON ACTION controlp INFIELD imaa009
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009                    #返回原欄位

         ON ACTION controlp INFIELD inag001          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag001      #顯示到畫面上
            NEXT FIELD inag001                         #返回原欄位
            
         ON ACTION controlp INFIELD inag002          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag002      #顯示到畫面上
            NEXT FIELD inag002                         #返回原欄位
            
         ON ACTION controlp INFIELD inag003          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag003      #顯示到畫面上
            NEXT FIELD inag003                         #返回原欄位
            
         ON ACTION controlp INFIELD inag004          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag004      #顯示到畫面上
            NEXT FIELD inag004                         #返回原欄位
            
         ON ACTION controlp INFIELD inag005          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag005      #顯示到畫面上
            NEXT FIELD inag005                         #返回原欄位
            
         ON ACTION controlp INFIELD inag006          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag006      #顯示到畫面上
            NEXT FIELD inag006                         #返回原欄位
        
        ON ACTION controlp INFIELD imaa133          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2007" #應用分類
            CALL q_oocq002()  
            DISPLAY g_qryparam.return1 TO imaa133      #顯示到畫面上
            NEXT FIELD imaa133 

         ON ACTION controlp INFIELD imaa126          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2002" #應用分類
            CALL q_oocq002()  
            DISPLAY g_qryparam.return1 TO imaa126      #顯示到畫面上
            NEXT FIELD imaa126 
         
      END CONSTRUCT  
      
      INPUT BY NAME g_inaa_d.inaa010,g_inaa_d.inaa008,g_inaa_d.inag019,g_inaa_d.inaa009,g_inaa_d.inaa015,g_inaa_d.inaa016,g_inaa_d.l_print
                    ATTRIBUTE(WITHOUT DEFAULTS)    
         BEFORE INPUT
            #INITIALIZE g_inaa_d.* TO NULL

            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF  
      END INPUT
      #160512-00004#2-add-'g_inag1_d.l_inad011'
      INPUT BY NAME g_inag1_d.l_inagsite,g_inag1_d.l_inag001,g_inag1_d.l_inag002,g_inag1_d.l_inag003,g_inag1_d.l_inag004,g_inag1_d.l_inag005,g_inag1_d.l_inag006,
                    g_inag1_d.l_inag007,g_inag1_d.l_inad014,g_inag1_d.l_inad011,g_inag1_d.l_inag027 ATTRIBUTE(WITHOUT DEFAULTS) 
         
         BEFORE INPUT
             #INITIALIZE g_inag1_d.* TO NULL 
        
            
         AFTER INPUT
            #160512-00004#2-add-AND g_inag1_d.l_inad014 = 'N'
            IF g_inag1_d.l_inag001 = 'N' AND g_inag1_d.l_inagsite = 'N' AND g_inag1_d.l_inag002 = 'N' AND g_inag1_d.l_inag003 = 'N' AND g_inag1_d.l_inag004 = 'N' AND g_inag1_d.l_inag005 = 'N' AND
              g_inag1_d.l_inag006 = 'N' AND g_inag1_d.l_inag007 = 'N' AND g_inag1_d.l_inad014 = 'N' AND g_inag1_d.l_inad011 = 'N' AND g_inag1_d.l_inag027 = 'N'  THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'ain-00173'
              LET g_errparam.extend = ' '
              LET g_errparam.popup = TRUE
              CALL cl_err()

              NEXT FIELD l_inag001
            END IF            
      END INPUT
         #end add-point

         #add-point:construct段落

         #end add-point

         DISPLAY ARRAY g_inag_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_inag_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aslq100_b_fill2(l_ac)
               CALL aslq100_b_fill3(l_ac)
               CALL aslq100_b_fill4(l_ac)
               #add-point:input段before row

               #end add-point

            #自訂ACTION(detail_show,page_1)


         END DISPLAY

         DISPLAY ARRAY g_inag2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               #CALL aslq100_b_fill4(g_detail_idx2)  #add by lixh 20150731
               #CALL aslq100_b_fill3(g_detail_idx2)  #add by lixh 20150731
               #end add-point
            #自訂ACTION(detail_show,page_2)

         END DISPLAY

         DISPLAY ARRAY g_inag3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row

               #end add-point
            #自訂ACTION(detail_show,page_3)

         END DISPLAY

         DISPLAY ARRAY g_inag4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 4
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row

               #end add-point
            #自訂ACTION(detail_show,page_4)

         END DISPLAY



         #add-point:ui_dialog段自定義display array

         #end add-point

         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan

         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL cl_set_act_visible("query", FALSE)
            #add-point:ui_dialog段before dialog
            LET g_inag1_d.l_inagsite = 'Y'
            LET g_inag1_d.l_inag001 = 'Y'
            LET g_inag1_d.l_inag004 = 'N'   #170116-00018#7 20170203 add by 08172
#            LET g_inag1_d.l_inag004 = 'Y'  #170116-00018#7 20170203 mark by 08172
            CALL aslq100_comp_visible()   #add by lixh 20150115
            #end add-point


         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

            #end add-point

        ON ACTION accept
           IF INT_FLAG THEN
               LET INT_FLAG = 0
               #還原
               LET g_wc = ls_wc
            ELSE
               CALL cl_dlg_save_user_latestqry("("||g_wc||")")  
               LET g_master_idx = 1
            END IF
            
            CALL aslq100_comp_visible()
            
            LET g_error_show = 1
            CALL aslq100_b_fill()
            CALL aslq100_b_fill2(1)
            CALL aslq100_b_fill3(1)
            CALL aslq100_b_fill4(1)            
            LET l_ac = g_master_idx
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -100
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
         ON ACTION qbehidden   #瀏覽頁折疊
            IF g_worksheet_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_worksheet_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_worksheet_hidden = 1
            END IF

         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG


         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()

         #+ 提供二次篩選的功能
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aslq100_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG





         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF


         ON ACTION qbeclear
            LET g_action_choice="qbeclear"
          #  IF cl_auth_chk_act("qbeclear") THEN
               CALL aslq100_qbeclear()
               EXIT DIALOG
          #  END IF
         
         ON ACTION datainfo

            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF

        ON ACTION queryplansel
           LET g_inag.imaa009 = ''
           LET g_inag.inag001 = ''
           LET g_inag.inag002 = ''
           LET g_inag.inag003 = ''
           LET g_inag.inag004 = ''
           LET g_inag.inag005 = ''
           LET g_inag.inag006 = ''
           LET g_inag.inad011 = ''
           LET g_inag.inag027 = ''
           LET g_inag.inag014 = ''          
           CALL cl_dlg_qryplan_select() RETURNING ls_wc
           #在azzi915无法维护inaa的资料，排除点击“最近一次查询条件”，
           IF cl_null(ls_wc) THEN
              LET ldig_curr = ui.Dialog.getCurrent()
              LET li_index = ldig_curr.getCurrentRow("s_queryplan")
              IF li_index > 3 THEN
                 LET ls_wc = "inaa015 = 'Y'"
              END IF
           END IF           
           IF NOT cl_null(ls_wc) THEN
              LET g_wc = ls_wc   #不是空條件才寫入g_wc跟重新找資料
              CASE g_wc
                 WHEN "inag011 = 'Y'"
                    LET g_inaa_d.inaa009 = 'Y'
                    LET g_inaa_d.inaa010 = ''
                    LET g_inaa_d.inaa015 = ''
                 WHEN "inag011 = 'N'"
                    LET g_inaa_d.inaa009 = 'N'
                    LET g_inaa_d.inaa010 = ''
                    LET g_inaa_d.inaa015 = ''
                 WHEN "inag012 = 'Y'"
                    LET g_inaa_d.inaa010 = 'Y'
                    LET g_inaa_d.inaa009 = ''
                    LET g_inaa_d.inaa015 = ''
                 WHEN "inag012 = 'N'"
                    LET g_inaa_d.inaa010 = 'N'
                    LET g_inaa_d.inaa009 = ''
                    LET g_inaa_d.inaa015 = ''
                 WHEN "inaa015 = 'Y'"
                    LET g_inaa_d.inaa015 = 'Y'
                    LET g_inaa_d.inaa010 = ''
                    LET g_inaa_d.inaa009 = ''
              END CASE  
              LET g_inag1_d.l_inagsite = 'N'
              LET g_inag1_d.l_inag001 = 'Y'
              LET g_inag1_d.l_inag002 = 'N'
              LET g_inag1_d.l_inag003 = 'N'
              LET g_inag1_d.l_inag004 = 'N'
              LET g_inag1_d.l_inag005 = 'N'
              LET g_inag1_d.l_inag006 = 'N'
              LET g_inag1_d.l_inag007 = 'N'
              LET g_inag1_d.l_inad011 = 'N'
              LET g_inag1_d.l_inag027 = 'N'
              CALL aslq100_comp_visible()
              CALL aslq100_b_fill()   #browser_fill()會將notice區塊清空
              CALL aslq100_b_fill2(1)
              CALL aslq100_b_fill3(1)
              CALL aslq100_b_fill4(1)              
              CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
           END IF

        
        # ON ACTION insert
        #
        #    LET g_action_choice="insert"
        #    IF cl_auth_chk_act("insert") THEN
        #       #add-point:ON ACTION insert
        #
        #       #END add-point
        #       EXIT DIALOG
        #    END IF
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()

               LET g_main_hidden = 0  #xj add
               LET g_export_node[1] = base.typeInfo.create(g_inag_d)
               LET g_export_id[1]   = "s_detail1"
            
               #add-point:ON ACTION exporttoexcel
               LET g_export_node[2] = base.typeInfo.create(g_inag2_d)
               LET g_export_id[2]   = "s_detail2"
               
               LET g_export_node[3] = base.typeInfo.create(g_inag3_d)
               LET g_export_id[3]   = "s_detail3"
            
               #add-point:ON ACTION exporttoexcel
               LET g_export_node[4] = base.typeInfo.create(g_inag4_d)
               LET g_export_id[4]   = "s_detail4"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()

            END IF

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

      END DIALOG

   END WHILE

END FUNCTION

PRIVATE FUNCTION aslq100_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   DEFINE l_sql           STRING
   DEFINE l_sql_order     STRING
   {</Local define>}
   #add-point:b_fill段define

   #end add-point

   #add-point:b_fill段sql_before

   #end add-point

   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF

   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter

   CALL g_inag_d.clear()
   CALL g_inag2_d.clear()
   CALL g_inag3_d.clear()
   CALL g_inag4_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   # b_fill段sql組成及FOREACH撰寫
      #+ 此段落由子樣板qs04產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET l_sql = "SELECT UNIQUE "
   LET l_sql_order = " ORDER BY "
   #add by lixha 20141226 (s)
   IF g_inag1_d.l_inagsite = 'Y' THEN
      LET l_sql = l_sql,"inagsite,''"
      LET l_sql_order = l_sql_order,"inagsite"
   ELSE
      LET l_sql = l_sql,"inagsite,''"
      LET l_sql_order = l_sql_order,"inagsite"
   END IF  
   #add by lixha 20141226 (e)
   IF g_inag1_d.l_inag001 = 'Y' THEN
      LET l_sql = l_sql,",inag001,'',''"
      LET l_sql_order = l_sql_order,",inag001"
   ELSE
      LET l_sql = l_sql,",'','',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF g_inag1_d.l_inag002 = 'Y' THEN
      LET l_sql = l_sql,",inag002,''"
      LET l_sql_order = l_sql_order,",inag002"
   ELSE
#      LET l_sql = l_sql,",''"
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   #geza
   LET l_sql = l_sql,",imaa154,imaa155,imaa133,t1.oocql004,rtax006,t3.rtaxl003,rtax003,t5.rtaxl003,imaa156,imaa116,imaa126,t6.oocql004,imaa132,t7.oocql004,imaa127,t8.oocql004,imaa131,t9.oocql004 "  
   IF g_inag1_d.l_inag004 = 'Y' THEN
      LET l_sql = l_sql,",inag004,''"
      LET l_sql_order = l_sql_order,",inag004"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF g_inag1_d.l_inag005 = 'Y' THEN
      LET l_sql = l_sql,",inag005,''"
      LET l_sql_order = l_sql_order,",inag005"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF g_inag1_d.l_inag006 = 'Y' THEN
      LET l_sql = l_sql,",inag006"
      LET l_sql_order = l_sql_order,",inag006"
   ELSE
      LET l_sql = l_sql,",''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF g_inag1_d.l_inag003 = 'Y' THEN
      LET l_sql = l_sql,",inag003"
      LET l_sql_order = l_sql_order,",inag003"
   ELSE
      LET l_sql = l_sql,",''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF g_inag1_d.l_inag007 = 'Y' THEN
      LET l_sql = l_sql,",inag007,''"
      LET l_sql_order = l_sql_order,",inag007"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   #160512-00004#2-add-(S) 製造日期
   IF g_inag1_d.l_inad014 = 'Y' THEN
      LET l_sql = l_sql,",inad014"
      LET l_sql_order = l_sql_order,",inad014"
   ELSE
      LET l_sql = l_sql,",''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   #160512-00004#2-add-(E)
   
   IF g_inag1_d.l_inad011 = 'Y' THEN
      LET l_sql = l_sql,",inad011"
      LET l_sql_order = l_sql_order,",inad011"
   ELSE
      LET l_sql = l_sql,",''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF g_inag1_d.l_inag027 = 'Y' THEN
      LET l_sql = l_sql,",inag027"
      LET l_sql_order = l_sql_order,",inag027"
   ELSE
      LET l_sql = l_sql,",''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   #库存属性
   IF NOT cl_null(g_inaa_d.inaa008) THEN
      LET ls_wc = ls_wc," AND inaa008='",g_inaa_d.inaa008,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa009) THEN
      LET ls_wc = ls_wc," AND inaa009='",g_inaa_d.inaa009,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa010) THEN
      LET ls_wc = ls_wc," AND inaa010='",g_inaa_d.inaa010,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa015) THEN
      LET ls_wc = ls_wc," AND inaa015='",g_inaa_d.inaa015,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa016) THEN
      LET ls_wc = ls_wc," AND inaa016='",g_inaa_d.inaa016,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inag019) THEN
      LET ls_wc = ls_wc," AND inag019='",g_inaa_d.inag019,"'"
   END IF
   IF ls_wc.getIndexOf("inaa",1) THEN
      IF ls_wc.getIndexOf("imaa",1) THEN
#         IF g_argv[01] = '1' THEN
#            LET g_sql = l_sql," FROM inag_t ",
#                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
#                              ",inaa_t,imaa_t ", 
#                              " WHERE inagent=inaaent AND inagsite=inaasite AND inag004=inaa001 AND inagent=imaaent AND inag001=imaa001",
#                              "  AND inagent=",g_enterprise," AND inagsite='",g_site,"' AND ", ls_wc                              
#         ELSE
            LET g_sql = l_sql," FROM inag_t ",
                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
                              ",inaa_t,imaa_t ",                           
                              " LEFT JOIN oocql_t t1 ON imaaent = t1.oocqlent AND t1.oocql001 = '2007' AND t1.oocql002 = imaa133 AND t1.oocql003 = '"||g_dlang||"'  ",
                              " LEFT JOIN oocql_t t6 ON t6.oocqlent = imaaent AND t6.oocql001 = '2002' AND t6.oocql002 = imaa126 AND t6.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN oocql_t t7 ON t7.oocqlent = imaaent AND t7.oocql001 = '2006' AND t7.oocql002 = imaa132 AND t7.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN oocql_t t8 ON t8.oocqlent= imaaent AND t8.oocql001='2003' AND t8.oocql002=imaa127 AND t8.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN oocql_t t9 ON t9.oocqlent=imaaent AND t9.oocql001='2001' AND t9.oocql002=imaa131 AND t9.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN rtax_t ON imaaent = rtaxent AND rtax001 = imaa009  ",
                              " LEFT JOIN rtaxl_t t3 ON rtaxent = t3.rtaxlent AND t3.rtaxl001 = rtax006 AND t3.rtaxl002 = '"||g_dlang||"'  ",
                              " LEFT JOIN rtaxl_t t5 ON rtaxent = t5.rtaxlent AND t5.rtaxl001 = rtax003 AND t5.rtaxl002 = '"||g_dlang||"'  ",
                              " WHERE inagent=inaaent AND inagsite=inaasite AND inag004=inaa001 AND inagent=imaaent AND inag001=imaa001",
                              "  AND inagent=",g_enterprise," AND ", ls_wc         
         #END IF   
         IF g_inaa_d.l_print = 'Y' THEN                  
            #LET g_sql = g_sql," AND inag008 <> 0 " #mark by geza 20161210 #161124-00039#2
            LET g_sql = g_sql,"  AND inag009 <> 0 " #add by geza 20161210 #161124-00039#2
         END IF             
      ELSE
#         IF g_argv[01] = '1' THEN
#            LET g_sql = l_sql," FROM inag_t ",
#                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
#                              ",inaa_t ",
#                              " WHERE inagent=inaaent AND inagsite=inaasite AND inag004=inaa001",
#                              "  AND inagent=",g_enterprise,"  AND inagsite='",g_site,"' AND ", ls_wc
#         ELSE
#            LET g_sql = l_sql," FROM inag_t ",
#                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
#                              ",inaa_t ",
#                              " WHERE inagent=inaaent AND inagsite=inaasite AND inag004=inaa001",
#                              "  AND inagent=",g_enterprise,"  AND ", ls_wc   

             LET g_sql = l_sql," FROM inag_t ",
                               " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
                               ",inaa_t,imaa_t ",                           
                               " LEFT JOIN oocql_t t1 ON imaaent = t1.oocqlent AND t1.oocql001 = '2007' AND t1.oocql002 = imaa133 AND t1.oocql003 = '"||g_dlang||"'  ",
                               " LEFT JOIN oocql_t t6 ON t6.oocqlent = imaaent AND t6.oocql001 = '2002' AND t6.oocql002 = imaa126 AND t6.oocql003='"||g_dlang||"' ",
                               " LEFT JOIN oocql_t t7 ON t7.oocqlent = imaaent AND t7.oocql001 = '2006' AND t7.oocql002 = imaa132 AND t7.oocql003='"||g_dlang||"' ",
                               " LEFT JOIN oocql_t t8 ON t8.oocqlent= imaaent AND t8.oocql001='2003' AND t8.oocql002=imaa127 AND t8.oocql003='"||g_dlang||"' ",
                               " LEFT JOIN oocql_t t9 ON t9.oocqlent=imaaent AND t9.oocql001='2001' AND t9.oocql002=imaa131 AND t9.oocql003='"||g_dlang||"' ",
                               " LEFT JOIN rtax_t ON imaaent = rtaxent AND rtax001 = imaa009  ",
                               " LEFT JOIN rtaxl_t t3 ON rtaxent = t3.rtaxlent AND t3.rtaxl001 = rtax006 AND t3.rtaxl002 = '"||g_dlang||"'  ",
                               " LEFT JOIN rtaxl_t t5 ON rtaxent = t5.rtaxlent AND t5.rtaxl001 = rtax003 AND t5.rtaxl002 = '"||g_dlang||"'  ",
                               " WHERE inagent=inaaent AND inagsite=inaasite AND inag004=inaa001 AND inagent=imaaent AND inag001=imaa001",
                               "  AND inagent=",g_enterprise," AND ", ls_wc   
         #END IF  
         IF g_inaa_d.l_print = 'Y' THEN                  
            #LET g_sql = g_sql," AND inag008 <> 0 " #mark by geza 20161210 #161124-00039#2
            LET g_sql = g_sql,"  AND inag009 <> 0 " #add by geza 20161210 #161124-00039#2
         END IF           
      END IF
   ELSE  
      IF ls_wc.getIndexOf("imaa",1) THEN
#         IF g_argv[01] = '1' THEN
#            LET g_sql = l_sql," FROM inag_t ",
#                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
#                              ",imaa_t ",   
#                              " WHERE inagent=imaaent AND inag001=imaa001",
#                              "  AND inagent=",g_enterprise,"  AND inagsite='",g_site,"' AND ", ls_wc
#         ELSE
            LET g_sql = l_sql," FROM inag_t ",
                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
                              ",imaa_t ", 
                              " LEFT JOIN oocql_t t1 ON imaaent = t1.oocqlent AND t1.oocql001 = '2007' AND t1.oocql002 = imaa133 AND t1.oocql003 = '"||g_dlang||"'  ",
                              " LEFT JOIN oocql_t t6 ON t6.oocqlent = imaaent AND t6.oocql001 = '2002' AND t6.oocql002 = imaa126 AND t6.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN oocql_t t7 ON t7.oocqlent = imaaent AND t7.oocql001 = '2006' AND t7.oocql002 = imaa132 AND t7.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN oocql_t t8 ON t8.oocqlent= imaaent AND t8.oocql001='2003' AND t8.oocql002=imaa127 AND t8.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN oocql_t t9 ON t9.oocqlent=imaaent AND t9.oocql001='2001' AND t9.oocql002=imaa131 AND t9.oocql003='"||g_dlang||"' ",
                              " LEFT JOIN rtax_t ON imaaent = rtaxent AND rtax001 = imaa009  ",
                              " LEFT JOIN rtaxl_t t3 ON rtaxent = t3.rtaxlent AND t3.rtaxl001 = rtax006 AND t3.rtaxl002 = '"||g_dlang||"'  ",
                              " LEFT JOIN rtaxl_t t5 ON rtaxent = t5.rtaxlent AND t5.rtaxl001 = rtax003 AND t5.rtaxl002 = '"||g_dlang||"'  ",                              
                              " WHERE inagent=imaaent AND inag001=imaa001",
                              "  AND inagent=",g_enterprise,"  AND ", ls_wc         
         #END IF     
         IF g_inaa_d.l_print = 'Y' THEN                  
            #LET g_sql = g_sql," AND inag008 <> 0 " #mark by geza 20161210 #161124-00039#2
            LET g_sql = g_sql,"  AND inag009 <> 0 " #add by geza 20161210 #161124-00039#2
         END IF           
      ELSE
#         IF g_argv[01] = '1' THEN
#            LET g_sql = l_sql," FROM inag_t",
#                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
#                              " WHERE inagent=",g_enterprise," AND inagsite='",g_site,"' AND ", ls_wc
#         ELSE
#            LET g_sql = l_sql," FROM inag_t",
#                              " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
#                              " WHERE inagent=",g_enterprise," AND ", ls_wc         
         #END IF   
         LET g_sql = l_sql," FROM inag_t ",
                           " LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 ",
                           ",imaa_t ", 
                           " LEFT JOIN oocql_t t1 ON imaaent = t1.oocqlent AND t1.oocql001 = '2007' AND t1.oocql002 = imaa133 AND t1.oocql003 = '"||g_dlang||"'  ",
                           " LEFT JOIN oocql_t t6 ON t6.oocqlent = imaaent AND t6.oocql001 = '2002' AND t6.oocql002 = imaa126 AND t6.oocql003='"||g_dlang||"' ",
                           " LEFT JOIN oocql_t t7 ON t7.oocqlent = imaaent AND t7.oocql001 = '2006' AND t7.oocql002 = imaa132 AND t7.oocql003='"||g_dlang||"' ",
                           " LEFT JOIN oocql_t t8 ON t8.oocqlent= imaaent AND t8.oocql001='2003' AND t8.oocql002=imaa127 AND t8.oocql003='"||g_dlang||"' ",
                           " LEFT JOIN oocql_t t9 ON t9.oocqlent=imaaent AND t9.oocql001='2001' AND t9.oocql002=imaa131 AND t9.oocql003='"||g_dlang||"' ",
                           " LEFT JOIN rtax_t ON imaaent = rtaxent AND rtax001 = imaa009  ",
                           " LEFT JOIN rtaxl_t t3 ON rtaxent = t3.rtaxlent AND t3.rtaxl001 = rtax006 AND t3.rtaxl002 = '"||g_dlang||"'  ",
                           " LEFT JOIN rtaxl_t t5 ON rtaxent = t5.rtaxlent AND t5.rtaxl001 = rtax003 AND t5.rtaxl002 = '"||g_dlang||"'  ",                              
                           " WHERE inagent=imaaent AND inag001=imaa001",
                           "  AND inagent=",g_enterprise,"  AND ", ls_wc  
         IF g_inaa_d.l_print = 'Y' THEN                  
            #LET g_sql = g_sql," AND inag008 <> 0 " #mark by geza 20161210 #161124-00039#2
            LET g_sql = g_sql,"  AND inag009 <> 0 " #add by geza 20161210 #161124-00039#2
         END IF           
      END IF         
   END IF
   LET g_sql = g_sql,l_sql_order

   PREPARE aslq100_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aslq100_pb

   FOREACH b_fill_curs INTO g_inag_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL aslq100_b_fill_desc()
      
     #CALL aslq100_b_fill2(l_ac)
     #CALL aslq100_b_fill3(l_ac)
     #CALL aslq100_b_fill4(l_ac)

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_inag_d.deleteElement(g_inag_d.getLength())
   CALL g_inag2_d.deleteElement(g_inag2_d.getLength())
   CALL g_inag3_d.deleteElement(g_inag3_d.getLength())
   CALL g_inag4_d.deleteElement(g_inag4_d.getLength())

   LET g_error_show = 0

   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0

   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aslq100_pb

#   #add by lixh 20150731
#   CALL aslq100_b_fill2(l_ac)
#   CALL aslq100_b_fill3(l_ac)
#   CALL aslq100_b_fill4(l_ac)
#   #add by lixh 20150731   

#   LET l_ac = 1
#   CALL aslq100_b_fill2()
#
#      CALL aslq100_filter_show('inag001','b_inag001')
#   CALL aslq100_filter_show('inag002','b_inag002')
#   CALL aslq100_filter_show('inag003','b_inag003')
#   CALL aslq100_filter_show('inag004','b_inag004')
#   CALL aslq100_filter_show('inag004_desc','b_inag004_desc')
#   CALL aslq100_filter_show('inag005','b_inag005')
#   CALL aslq100_filter_show('inag005_desc','b_inag005_desc')
#   CALL aslq100_filter_show('inag006','b_inag006')
#   CALL aslq100_filter_show('inag007','b_inag007')
#   CALL aslq100_filter_show('inad011','b_inad011')
#   CALL aslq100_filter_show('inag027','b_inag027')
#   CALL aslq100_filter_show('','l_inag001_')
#   CALL aslq100_filter_show('','l_inag001_1_des')
#   CALL aslq100_filter_show('','l_inag001_1_desc_des')
#   CALL aslq100_filter_show('','l_inag002_')
#   CALL aslq100_filter_show('','l_inag003_')
#   CALL aslq100_filter_show('','l_inad011_')
#   CALL aslq100_filter_show('','l_inag004_')
#   CALL aslq100_filter_show('','l_inag004_1_des')
#   CALL aslq100_filter_show('','l_inag005_')
#   CALL aslq100_filter_show('','l_inag005_1_des')
#   CALL aslq100_filter_show('','l_inag006_')
#   CALL aslq100_filter_show('','l_inag007_')
#   CALL aslq100_filter_show('','l_inag007_1_des')
#   CALL aslq100_filter_show('','l_inag008_')
#   CALL aslq100_filter_show('','l_inap013_')
#   CALL aslq100_filter_show('','l_inag021_')
#   CALL aslq100_filter_show('','l_inag024_')
#   CALL aslq100_filter_show('','l_inag025_')
#   CALL aslq100_filter_show('','l_inag013_')
#   CALL aslq100_filter_show('','l_inag016_')
#   CALL aslq100_filter_show('','l_inag015_')
#   CALL aslq100_filter_show('','l_inag014_')
#   CALL aslq100_filter_show('','l_inag026_')
#   CALL aslq100_filter_show('','l_inag027_')
#   CALL aslq100_filter_show('','l_inag012_')
#   CALL aslq100_filter_show('','l_inag011_')



END FUNCTION

PRIVATE FUNCTION aslq100_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define

   #end add-point

   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF

   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF

   RETURN ls_var

END FUNCTION

################################################################################
# Descriptions...: 根據單頭資料內容動態顯示資料清單、庫存明細資料、製造批序號資料、在揀量資料欄位
# Memo...........:
# Date & Author..: 2014/04/16  By chenjing
# Modify.........:
################################################################################
PRIVATE FUNCTION aslq100_comp_visible()
   #资料清单页签栏位隐藏
   CALL cl_set_comp_visible("b_inagsite,b_inagsite_desc,b_inag001,b_inag001_desc,b_inag001_desc_1,b_inag002,b_inag002_desc,b_inag003,b_inag004,b_inag004_desc",FALSE)
   CALL cl_set_comp_visible("b_inag005,b_inag005_desc,b_inag006,b_inag007,b_inag007_desc,b_inad014,b_inad011,b_inag027",FALSE) #160512-00004#2-add-'b_inad014'
   #库存明细资料页签栏位开启
   CALL cl_set_comp_visible("l_inagsite_1,l_inagsite_1_desc,l_inag001_1,l_inag001_1_desc,l_inag001_1_desc_1,l_inag002_1,l_inag002_1_desc,l_inag003_1,l_inag004_1,l_inag004_1_desc",TRUE)
   CALL cl_set_comp_visible("l_inag007_1,l_inag007_1_desc",TRUE) #170116-00018#7 20170203 add by 08172
   CALL cl_set_comp_visible("l_inag005_1,l_inag005_1_desc,l_inag006_1,l_inad014_1,l_inad011_1,l_inag027_1",FALSE) #170116-00018#7 20170203 add by 08172
#   CALL cl_set_comp_visible("l_inag005_1,l_inag005_1_desc,l_inag006_1,l_inag007_1,l_inag007_1_desc,l_inad014_1,l_inad011_1,l_inag027_1",TRUE) #160512-00004#2-add-'l_inad014_1'  #170116-00018#7 20170203 mark by 08172
   #制造批序号资料页签栏位开启
#   CALL cl_set_comp_visible("inaisite,inaisite_desc,inai001,inai001_desc,inai001_desc_1,inai002,inai002_desc,inai003,inai004,inai004_desc,inai005,inai005_desc,inai006",TRUE)  #170116-00018#7 20170203 mark by 08172
   CALL cl_set_comp_visible("inaisite,inaisite_desc,inai001,inai001_desc,inai001_desc_1,inai002,inai002_desc,inai003,inai004,inai004_desc",TRUE) #170116-00018#7 20170203 add by 08172
   CALL cl_set_comp_visible("inai005,inai005_desc,inai006",FALSE) #170116-00018#7 20170203 add by 08172
   CALL cl_set_comp_visible("page_1",FALSE) #170116-00018#7 20170203 add by 08172
   #在捡量资料页签栏位开启
   #CALL cl_set_comp_visible("inapsite,inapsite_desc,inap004,inap004_desc,inap004_desc_1,inap005,inap005_desc,inap006,inap007,inap007_desc,inap008,inap008_desc,inap009",TRUE) #mark by geza 20161209 
#   CALL cl_set_comp_visible("inapsite,inapsite_desc,inap004,inap004_desc,inap004_desc_1,inap005,inap005_desc,inap006,inap007,inap007_desc",TRUE) #add by geza 20161209  #170116-00018#7 20170203 mark by 08172
   CALL cl_set_comp_visible("inapsite,inapsite_desc,inap006,inap007,inap007_desc",FALSE) #170116-00018#7 20170203 add by 08172
   CALL cl_set_comp_visible("inap008,inap008_desc,inap009,inap014,inax002",FALSE) #170116-00018#7 20170203 add by 08172
   CALL cl_set_comp_visible("inap004,inap004_desc,inap004_desc_1,inap005,inap005_desc",TRUE) #170116-00018#7 20170206 add by 08172
   

   IF g_inag1_d.l_inagsite = 'Y' THEN
      CALL cl_set_comp_visible("b_inagsite,b_inagsite_desc",TRUE)
      CALL cl_set_comp_visible("l_inagsite_1,l_inagsite_1_desc",FALSE)
      CALL cl_set_comp_visible("inaisite,inaisite_desc",FALSE)
      CALL cl_set_comp_visible("inapsite,inapsite_desc",FALSE)
   END IF
   
   IF g_inag1_d.l_inag001 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag001,b_inag001_desc,b_inag001_desc_1",TRUE)
      CALL cl_set_comp_visible("l_inag001_1,l_inag001_1_desc,l_inag001_1_desc_1",FALSE)
      CALL cl_set_comp_visible("inai001,inai001_desc,inai001_desc_1",FALSE)
      #CALL cl_set_comp_visible("inap004,inap004_desc,inap004_desc_1",FALSE) #mark by geza 20161209 
   END IF
   
   IF g_inag1_d.l_inag002 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag002,b_inag002_desc",TRUE)
      CALL cl_set_comp_visible("l_inag002_1,l_inag002_1_desc",FALSE)
      CALL cl_set_comp_visible("inai002,inai002_desc",FALSE)
      #CALL cl_set_comp_visible("inap005,inap005_desc",FALSE) #mark by geza 20161209 
   END IF

   IF g_inag1_d.l_inag003 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag003",TRUE)
      CALL cl_set_comp_visible("l_inag003_1",FALSE)
      CALL cl_set_comp_visible("inai003",FALSE)
      #CALL cl_set_comp_visible("inap006",FALSE) #mark by geza 20161209 
   END IF
   #170116-00018#7 -s 20170203 mark by 08172
#   IF g_inag1_d.l_inag004 = 'Y' THEN
#      CALL cl_set_comp_visible("b_inag004,b_inag004_desc",TRUE)
#      CALL cl_set_comp_visible("l_inag004_1,l_inag004_1_desc",FALSE)
#      CALL cl_set_comp_visible("inai004,inai004_desc",FALSE)
#      #CALL cl_set_comp_visible("inap007,inap007_desc",FALSE) #mark by geza 20161209 
#   END IF
   #170116-00018#7 -e 20170203 mark by 08172
   #170116-00018#7 -s 20170203 add by 08172
   CALL cl_set_comp_visible("b_inag004,b_inag004_desc",FALSE)
   CALL cl_set_comp_visible("l_inag004_1,l_inag004_1_desc",FALSE)
   CALL cl_set_comp_visible("inai004,inai004_desc",FALSE)
   #170116-00018#7 -e 20170203 add by 08172
   IF g_inag1_d.l_inag005 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag005,b_inag005_desc",TRUE)
      CALL cl_set_comp_visible("l_inag005_1,l_inag005_1_desc",FALSE)      
      CALL cl_set_comp_visible("inai005,inai005_desc",FALSE)
      #CALL cl_set_comp_visible("inap008,inap008_desc",FALSE) #160810-00034#1  储位无需隐藏
   END IF
   
   IF g_inag1_d.l_inag006 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag006",TRUE)
      CALL cl_set_comp_visible("l_inag006_1",FALSE)
      CALL cl_set_comp_visible("inai006",FALSE)
      #CALL cl_set_comp_visible("inap009",FALSE) #mark by geza 20161209 
   END IF
   
   IF g_inag1_d.l_inag007 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag007,b_inag007_desc",TRUE)
      CALL cl_set_comp_visible("l_inag007_1,l_inag007_1_desc",FALSE)
   END IF
   
   #160512-00004#2-add-(S) 製造日期
   IF g_inag1_d.l_inad014 = 'Y' THEN
      CALL cl_set_comp_visible("b_inad014",TRUE)
      CALL cl_set_comp_visible("l_inad014_1",FALSE)
   END IF
   #160512-00004#2-add-(E)
   
   IF g_inag1_d.l_inad011 = 'Y' THEN
      CALL cl_set_comp_visible("b_inad011",TRUE)
      CALL cl_set_comp_visible("l_inad011_1",FALSE)
   END IF
   
   IF g_inag1_d.l_inag027 = 'Y' THEN
      CALL cl_set_comp_visible("b_inag027",TRUE)
      CALL cl_set_comp_visible("l_inag027_1",FALSE)
   END IF
   
#   IF g_argv[01] = '1' THEN  #aslq100
#      CALL cl_set_comp_visible("b_inagsite,b_inagsite_desc,l_inagsite_1,l_inagsite_1_desc,inaisite,inaisite_desc,inapsite,inapsite_desc",FALSE)
#   END IF
END FUNCTION

#制造批序号资料页签显示
PRIVATE FUNCTION aslq100_b_fill3(p_ac)
DEFINE p_ac               LIKE type_t.num5
DEFINE ls_wc              STRING

   IF cl_null(p_ac) OR p_ac = 0 THEN
      RETURN
   END IF
   
   CALL g_inag3_d.clear()
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF

   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
#160512-00004#1 by whitney modify start
#   LET g_sql = "SELECT UNIQUE inaisite,'',inai001,'','',inai002,'',inai003,inai004,'',inai005,'',inai006,inai007,inai008,inai012,inai010",
#               " FROM inai_t LEFT JOIN inaa_t ON inaient = inaaent AND inaisite = inaasite AND inai004 = inaa001 ",
#               " LEFT JOIN inag_t ON inaient = inagent AND inaisite = inagsite AND inai004 = inag004 ",
#               " AND inai001 = inag001 AND inai002 = inag002 AND inai003 = inag003 AND inai005 = inag005 AND inai006 = inag006 ", #add by lixh 20150929
#               " LEFT JOIN inad_t ON inaient = inadent AND inaisite = inadsite AND inai001 = inad001 AND inai002 = inad002 AND inai006 = inad003 ",  #add by lixh 20150929
##               "WHERE inaient=",g_enterprise," AND inaisite='",g_site,"'"
#               "WHERE inaient=",g_enterprise
   
   #170116-00018#7 -s 20170203 mark by 08172
#   LET g_sql = " SELECT UNIQUE inaisite,'',inai001,'','',inai002,'',inai003,inai004,'', ",
#               "               inai005,'',inai006,inai007,inai008,inae010,inae011,inai010 ",  #160512-00004#5-add-'inae011'
   #170116-00018#7 -e 20170203 mark by 08172
   #170116-00018#7 -s 20170203 add by 08172
   LET g_sql = " SELECT UNIQUE inaisite,'',inai001,'','',inai002,'',inai003,inai004,'', ",
               "               '','','','','','','',inai010 ",  #160512-00004#5-add-'inae011'
   #170116-00018#7 -e 20170203 add by 08172
               "   FROM inai_t ",
               "   LEFT JOIN inaa_t ON inaient=inaaent AND inaisite=inaasite AND inai004=inaa001 ",
               "   LEFT JOIN inag_t ON inaient=inagent AND inaisite=inagsite AND inai004=inag004 AND inai001=inag001 AND inai002=inag002 AND inai003=inag003 AND inai005=inag005 AND inai006=inag006 ",
               #170116-00018#7 -s 20170203 mark by 08172
#               "   LEFT JOIN inad_t ON inaient=inadent AND inaisite=inadsite AND inai001=inad001 AND inai002=inad002 AND inai006=inad003 ",
#               "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
               #170116-00018#7 -e 20170203 mark by 08172
               "  WHERE inaient=",g_enterprise
#160512-00004#1 by whitney modify end

##add by lixh 20141226
#   IF g_inag_d[p_ac].b_inagsite IS NOT NULL THEN
#      LET g_sql = g_sql," AND inaisite='",g_inag_d[p_ac].b_inagsite,"'"
#   END IF
##add by lixh 20141226 

   #add by lixh 20151027
#   IF g_argv[01] = '1' THEN
#      LET g_sql = g_sql," AND inaisite='",g_site,"'"
#   ELSE
   LET g_sql = g_sql," AND inaisite='",g_inag_d[p_ac].b_inagsite,"'"
   #END IF   
   #add by lixh 20151027
   
   #add by lixh 20150928
   IF g_inaa_d.l_print = 'Y' THEN      
      LET g_sql = g_sql,"  AND inai010 <> 0 "
   END IF
   #add by lixh 20150928 
   
   IF g_inag_d[p_ac].b_inag001 IS NOT NULL THEN
      LET g_sql = g_sql," AND inai001='",g_inag_d[p_ac].b_inag001,"'"
   END IF
   IF g_inag_d[p_ac].b_inag002 IS NOT NULL THEN
      LET g_sql = g_sql," AND inai002='",g_inag_d[p_ac].b_inag002,"'"
   END IF
   IF g_inag_d[p_ac].b_inag003 IS NOT NULL THEN
      LET g_sql = g_sql," AND inai003='",g_inag_d[p_ac].b_inag003,"'"
   END IF
   IF g_inag_d[p_ac].b_inag004 IS NOT NULL THEN
      LET g_sql = g_sql," AND inai004='",g_inag_d[p_ac].b_inag004,"'"
   END IF
   IF g_inag_d[p_ac].b_inag005 IS NOT NULL THEN
      LET g_sql = g_sql," AND inai005='",g_inag_d[p_ac].b_inag005,"'"
   END IF
   IF g_inag_d[p_ac].b_inag006 IS NOT NULL THEN
      LET g_sql = g_sql," AND inai006='",g_inag_d[p_ac].b_inag006,"'"
   END IF

   IF NOT cl_null(g_inaa_d.inaa008) THEN
      LET g_sql = g_sql," AND inaa008='",g_inaa_d.inaa008,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa009) THEN
      LET g_sql = g_sql," AND inaa009='",g_inaa_d.inaa009,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa010) THEN
      LET g_sql = g_sql," AND inaa010='",g_inaa_d.inaa010,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa015) THEN
      LET g_sql = g_sql," AND inaa015='",g_inaa_d.inaa015,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa016) THEN
      LET g_sql = g_sql," AND inaa016='",g_inaa_d.inaa016,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inag019) THEN
      LET g_sql = g_sql," AND inag019='",g_inaa_d.inag019,"'"
   END IF
   
   LET g_sql = g_sql," AND ", ls_wc   
#   LET g_sql = g_sql, " ORDER BY inaisite,inai001,inai002,inai003,inai004,inai005,inai006,inai007,inai008"  #170116-00018#7 20170203 mark by 08172
   LET g_sql = g_sql, " ORDER BY inaisite,inai001,inai002,inai003,inai004,'','','',''"   #170116-00018#7 20170203 add by 08172
   PREPARE aslq100_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR aslq100_pb3
   LET l_ac3 = 1
   FOREACH b_fill_curs3 INTO g_inag3_d[l_ac3].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aslq100_b_fill3_desc()
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   LET g_cnt3 = l_ac3 - 1
   CALL g_inag3_d.deleteElement(l_ac3)
END FUNCTION

#在拣量资料页签显示
PRIVATE FUNCTION aslq100_b_fill4(p_ac)
DEFINE p_ac               LIKE type_t.num5
DEFINE ls_wc              STRING

   IF cl_null(p_ac) OR p_ac = 0 THEN
      RETURN
   END IF
   
   CALL g_inag4_d.clear()
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF

   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
#   LET g_sql = "SELECT UNIQUE inapsite,'',inap004,'','',inap005,'',inap006,inap007,'',inap008,'',inap009,inap014,inap001,inap002,inap003,inap016,inap013,",
#               "inap017,'',inap018,'' FROM inap_t LEFT JOIN inaa_t ON inapent = inaaent AND inapsite = inaasite AND inap007 = inaa001 ",
#                " LEFT JOIN inag_t ON inapent = inagent AND inapsite = inagsite AND inap007 = inag004 ",
##                " WHERE inapent=",g_enterprise," AND inapsite='",g_site,"'"
#                " WHERE inapent=",g_enterprise
#   #mark by geza 20161209 #161124-00039#1(S)             
#   LET g_sql = " SELECT UNIQUE inapsite,'',inap004,'','',inap005,'',inap006,inap007,'',inap008,'',inap009,inap014,inap001,inap002,inap003,'',inap016,inap013,",  #161019-00023#1 add ''
#               " inap017,'',inap018,'' FROM inap_t ", 
#               " LEFT JOIN inaa_t ON inapent = inaaent AND inapsite = inaasite AND inap007 = inaa001 ",
#               #" LEFT JOIN inag_t ON inapent = inagent AND inapsite = inagsite AND inap007 = inag004 AND inap008 = inag005 AND inap009 = inag006 AND inap004 = inag001 AND inap005 = inag002 AND inap006 = inag003 ",  #160225-00010#1
#               " LEFT JOIN inag_t ON inapent = inagent AND inapsite = inagsite AND inap007 = inag004 AND inap004 = inag001 AND inap005 = inag002 AND inap006 = inag003 ",   #160225-00010#1
#               " LEFT JOIN inad_t ON inapent = inadent AND inapsite = inadsite AND inap004 = inad001 AND inap005 = inad002 AND inap009 = inad003 ",
#               " WHERE inapent=",g_enterprise                
#
###add by lixh 20141226
##   IF g_inag_d[p_ac].b_inagsite IS NOT NULL THEN
##      LET g_sql = g_sql," AND inapsite='",g_inag_d[p_ac].b_inagsite,"'"
##   END IF
###add by lixh 20141226   
#
#   #add by lixh 20151027
##   IF g_argv[01] = '1' THEN
##      LET g_sql = g_sql," AND inapsite='",g_site,"'"
##   ELSE
#      LET g_sql = g_sql," AND inapsite='",g_inag_d[p_ac].b_inagsite,"'"
#   #END IF
#   #add by lixh 20151027
#   IF g_inag_d[p_ac].b_inag001 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inap004='",g_inag_d[p_ac].b_inag001,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag002 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inap005='",g_inag_d[p_ac].b_inag002,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag003 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inap006='",g_inag_d[p_ac].b_inag003,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag004 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inap007='",g_inag_d[p_ac].b_inag004,"'"
#   END IF
#     
#   #IF g_inag_d[p_ac].b_inag005 IS NOT NULL THEN   #160810-00034#1 mark
#   IF NOT cl_null(g_inag_d[p_ac].b_inag005) THEN   #160810-00034#1 add
#      LET g_sql = g_sql," AND inap008='",g_inag_d[p_ac].b_inag005,"'"
#   END IF
#      
#   IF g_inag_d[p_ac].b_inag006 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inap009='",g_inag_d[p_ac].b_inag006,"'"
#   END IF  
#   IF NOT cl_null(g_inaa_d.inaa008) THEN
#      LET g_sql = g_sql," AND inaa008='",g_inaa_d.inaa008,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa009) THEN
#      LET g_sql = g_sql," AND inaa009='",g_inaa_d.inaa009,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa010) THEN
#      LET g_sql = g_sql," AND inaa010='",g_inaa_d.inaa010,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa015) THEN
#      LET g_sql = g_sql," AND inaa015='",g_inaa_d.inaa015,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa016) THEN
#      LET g_sql = g_sql," AND inaa016='",g_inaa_d.inaa016,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inag019) THEN
#      LET g_sql = g_sql," AND inag019='",g_inaa_d.inag019,"'"
#   END IF
#   
#   LET g_sql = g_sql," AND ", ls_wc
#   LET g_sql = g_sql, " ORDER BY inapsite,inap004,inap005,inap006,inap007,inap008,inap009,inap014,inap001,inap002,inap003"
#   #mark by geza 20161209 #161124-00039#1(E)
   
   #170116-00018#7 -s 20170203 mark by 08172
   #add by geza 20161209 #161124-00039#1(S)             
#   LET g_sql = " SELECT UNIQUE inax017,'',inax010,'','',inax011,'',inax012,inax015,'','','','',inax001,inax002,inax005,inax006,'','',inax003,inax014,",  #161019-00023#1 add ''
#               " '','','','' FROM inax_t ", 
#               " LEFT JOIN inaa_t ON inaxent = inaaent AND inax017 = inaasite AND inax015 = inaa001 ",
#               " LEFT JOIN inag_t ON inaxent = inagent AND inax010 = inag001 AND inax011 = inag002 AND inag004 = inax015  ",   #160225-00010#1
#               " WHERE inaxent=",g_enterprise                
#
#   LET g_sql = g_sql," AND inax017='",g_inag_d[p_ac].b_inagsite,"'"
#
#   IF g_inag_d[p_ac].b_inag001 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inax010='",g_inag_d[p_ac].b_inag001,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag002 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inax011='",g_inag_d[p_ac].b_inag002,"'"
#   END IF
##   IF g_inag_d[p_ac].b_inag003 IS NOT NULL THEN
##      LET g_sql = g_sql," AND inax012='",g_inag_d[p_ac].b_inag003,"'"
##   END IF
#   IF g_inag_d[p_ac].b_inag004 IS NOT NULL THEN
#      LET g_sql = g_sql," AND inax015='",g_inag_d[p_ac].b_inag004,"'"
#   END IF
#     
#   IF NOT cl_null(g_inaa_d.inaa008) THEN
#      LET g_sql = g_sql," AND inaa008='",g_inaa_d.inaa008,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa009) THEN
#      LET g_sql = g_sql," AND inaa009='",g_inaa_d.inaa009,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa010) THEN
#      LET g_sql = g_sql," AND inaa010='",g_inaa_d.inaa010,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa015) THEN
#      LET g_sql = g_sql," AND inaa015='",g_inaa_d.inaa015,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa016) THEN
#      LET g_sql = g_sql," AND inaa016='",g_inaa_d.inaa016,"'"
#   END IF
#   
#   LET g_sql = g_sql," AND inax002 IS NOT NULL  AND ", ls_wc
#   LET g_sql = g_sql," AND inax008||inax009 NOT IN (SELECT a.inax008||a.inax009 as docno FROM inax_t a  WHERE a.inaxent = ",g_enterprise," AND a.inax001 <> '16' AND a.inax002 IS NOT NULL 
#                       AND EXISTS (SELECT 1 FROM inax_t b WHERE b.inaxent=a.inaxent AND a.inax008 =b.inax008 AND b.inax009 = a.inax009 AND a.inax001 = b.inax001 AND b.inax001 <> '16' AND b.inax002 <> a.inax002 AND b.inax002 IS NOT NULL  )  ) "
#   LET g_sql = g_sql, " ORDER BY inax010,inax011,inax012,inax015,inax001 "
   #add by geza 20161209 #161124-00039#1(E) 
   #170116-00018#7 -e 20170203 mark by 08172
   #170116-00018#7 -s 20170203 add by 08172
   LET g_sql = " SELECT UNIQUE '','',inas009,'','',inas010,'','','','','','','','','',inas001,inas002,inas003,inas004,inas005,inas006,",
               " inas007,inas008,inas011,inas012,inas013,inas014,inas015,inas016,'',inas017,'' FROM inas_t ", 
               " LEFT JOIN inag_t ON inasent = inagent AND inas009 = inag001 AND inas010 = inag002 AND inag007 = inas013  ",
               " LEFT JOIN inaa_t ON inaaent = inagent AND inaasite = inagsite AND inaa001 = inag004",               
               " WHERE inasent=",g_enterprise                

   LET g_sql = g_sql," AND inassite='",g_inag_d[p_ac].b_inagsite,"'"

   IF g_inag_d[p_ac].b_inag001 IS NOT NULL THEN
      LET g_sql = g_sql," AND inas009='",g_inag_d[p_ac].b_inag001,"'"
   END IF
   IF g_inag_d[p_ac].b_inag002 IS NOT NULL THEN
      LET g_sql = g_sql," AND inas010='",g_inag_d[p_ac].b_inag002,"'"
   END IF
   IF g_inag_d[p_ac].b_inag004 IS NOT NULL THEN
      LET g_sql = g_sql," AND inag004='",g_inag_d[p_ac].b_inag004,"'"
   END IF
     
   IF NOT cl_null(g_inaa_d.inaa008) THEN
      LET g_sql = g_sql," AND inaa008='",g_inaa_d.inaa008,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa009) THEN
      LET g_sql = g_sql," AND inaa009='",g_inaa_d.inaa009,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa010) THEN
      LET g_sql = g_sql," AND inaa010='",g_inaa_d.inaa010,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa015) THEN
      LET g_sql = g_sql," AND inaa015='",g_inaa_d.inaa015,"'"
   END IF
   IF NOT cl_null(g_inaa_d.inaa016) THEN
      LET g_sql = g_sql," AND inaa016='",g_inaa_d.inaa016,"'"
   END IF
   
   LET g_sql = g_sql," AND ", ls_wc
   LET g_sql = g_sql, " ORDER BY inas009,inas010,inas001,inas002,inas003,inas004 "
   #170116-00018#7 -e 20170203 add by 08172
   PREPARE aslq100_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR aslq100_pb4
   LET l_ac4 = 1
   FOREACH b_fill_curs4 INTO g_inag4_d[l_ac4].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aslq100_b_fill4_desc()
      LET l_ac4 = l_ac4 + 1
      IF l_ac4 > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #mark by geza 20161209 #161124-00039#1(S)
#   #161019-00023#1-S
#   #订单备置
#   LET g_sql = " SELECT UNIQUE xmdrsite,'',xmdr001,'','',xmdr002,'',xmdr003,xmdr004,'',xmdr005,'',xmdr006,'axmt500',xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,'',xmdr008,'','','','' ",
#               "   FROM xmdr_t ",
#               " LEFT JOIN inaa_t ON xmdrent = inaaent AND xmdrsite = inaasite AND xmdr004 = inaa001 ",             
#               " LEFT JOIN inag_t ON xmdrent = inagent AND xmdrsite = inagsite AND xmdr004 = inag004 AND xmdr001 = inag001 AND xmdr002 = inag002 AND xmdr003 = inag003 ",  
#               " LEFT JOIN inad_t ON xmdrent = inadent AND xmdrsite = inadsite AND xmdr001 = inad001 AND xmdr002 = inad002 AND xmdr003 = inad003 ",
#               " WHERE xmdrent=",g_enterprise     
##   IF g_argv[01] = '1' THEN
##      LET g_sql = g_sql," AND xmdrsite='",g_site,"'"
##   ELSE
#      LET g_sql = g_sql," AND xmdrsite='",g_inag_d[p_ac].b_inagsite,"'"
#   #END IF
#   IF g_inag_d[p_ac].b_inag001 IS NOT NULL THEN
#      LET g_sql = g_sql," AND xmdr001='",g_inag_d[p_ac].b_inag001,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag002 IS NOT NULL THEN
#      LET g_sql = g_sql," AND xmdr002='",g_inag_d[p_ac].b_inag002,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag003 IS NOT NULL THEN
#      LET g_sql = g_sql," AND xmdr003='",g_inag_d[p_ac].b_inag003,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag004 IS NOT NULL THEN
#      LET g_sql = g_sql," AND xmdr004='",g_inag_d[p_ac].b_inag004,"'"
#   END IF
#     
#   IF NOT cl_null(g_inag_d[p_ac].b_inag005) THEN  
#      LET g_sql = g_sql," AND xmdr005='",g_inag_d[p_ac].b_inag005,"'"
#   END IF
#      
#   IF g_inag_d[p_ac].b_inag006 IS NOT NULL THEN
#      LET g_sql = g_sql," AND xmdr006='",g_inag_d[p_ac].b_inag006,"'"
#   END IF  
#   IF NOT cl_null(g_inaa_d.inaa008) THEN
#      LET g_sql = g_sql," AND inaa008='",g_inaa_d.inaa008,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa009) THEN
#      LET g_sql = g_sql," AND inaa009='",g_inaa_d.inaa009,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa010) THEN
#      LET g_sql = g_sql," AND inaa010='",g_inaa_d.inaa010,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa015) THEN
#      LET g_sql = g_sql," AND inaa015='",g_inaa_d.inaa015,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa016) THEN
#      LET g_sql = g_sql," AND inaa016='",g_inaa_d.inaa016,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inag019) THEN
#      LET g_sql = g_sql," AND inag019='",g_inaa_d.inag019,"'"
#   END IF
#   
#   LET g_sql = g_sql," AND ", ls_wc
#   LET g_sql = g_sql, " ORDER BY xmdrsite,xmdr001,xmdr002,xmdr003,xmdr004,xmdr005,xmdr006,xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2"
#   PREPARE aslq100_pb5 FROM g_sql
#   DECLARE b_fill_curs5 CURSOR FOR aslq100_pb5
#
#   FOREACH b_fill_curs5 INTO g_inag4_d[l_ac4].*
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         EXIT FOREACH
#      END IF
#      CALL aslq100_b_fill4_desc()
#      LET l_ac4 = l_ac4 + 1
#      IF l_ac4 > g_max_rec THEN
#         EXIT FOREACH
#      END IF
#   END FOREACH
#   #工单备置
#   LET g_sql = " SELECT UNIQUE sfbbsite,'',sfbb001,'','',sfbb002,'',sfbb003,sfbb004,'',sfbb005,'',sfbb006,'asft300',sfbbdocno,sfbbseq,sfbbseq1,'','',sfbb008,'','','','' ",
#               "   FROM sfbb_t ",
#               " LEFT JOIN inaa_t ON sfbbent = inaaent AND sfbbsite = inaasite AND sfbb004 = inaa001 ",             
#               " LEFT JOIN inag_t ON sfbbent = inagent AND sfbbsite = inagsite AND sfbb004 = inag004 AND sfbb001 = inag001 AND sfbb002 = inag002 AND sfbb003 = inag003 ",  
#               " LEFT JOIN inad_t ON sfbbent = inadent AND sfbbsite = inadsite AND sfbb001 = inad001 AND sfbb002 = inad002 AND sfbb003 = inad003 ",
#               " WHERE sfbbent=",g_enterprise     
##   IF g_argv[01] = '1' THEN
##      LET g_sql = g_sql," AND sfbbsite='",g_site,"'"
##   ELSE
#      LET g_sql = g_sql," AND sfbbsite='",g_inag_d[p_ac].b_inagsite,"'"
#   #END IF
#   IF g_inag_d[p_ac].b_inag001 IS NOT NULL THEN
#      LET g_sql = g_sql," AND sfbb001='",g_inag_d[p_ac].b_inag001,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag002 IS NOT NULL THEN
#      LET g_sql = g_sql," AND sfbb002='",g_inag_d[p_ac].b_inag002,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag003 IS NOT NULL THEN
#      LET g_sql = g_sql," AND sfbb003='",g_inag_d[p_ac].b_inag003,"'"
#   END IF
#   IF g_inag_d[p_ac].b_inag004 IS NOT NULL THEN
#      LET g_sql = g_sql," AND sfbb004='",g_inag_d[p_ac].b_inag004,"'"
#   END IF
#     
#   IF NOT cl_null(g_inag_d[p_ac].b_inag005) THEN  
#      LET g_sql = g_sql," AND sfbb005='",g_inag_d[p_ac].b_inag005,"'"
#   END IF
#      
#   IF g_inag_d[p_ac].b_inag006 IS NOT NULL THEN
#      LET g_sql = g_sql," AND sfbb006='",g_inag_d[p_ac].b_inag006,"'"
#   END IF  
#   IF NOT cl_null(g_inaa_d.inaa008) THEN
#      LET g_sql = g_sql," AND inaa008='",g_inaa_d.inaa008,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa009) THEN
#      LET g_sql = g_sql," AND inaa009='",g_inaa_d.inaa009,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa010) THEN
#      LET g_sql = g_sql," AND inaa010='",g_inaa_d.inaa010,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa015) THEN
#      LET g_sql = g_sql," AND inaa015='",g_inaa_d.inaa015,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inaa016) THEN
#      LET g_sql = g_sql," AND inaa016='",g_inaa_d.inaa016,"'"
#   END IF
#   IF NOT cl_null(g_inaa_d.inag019) THEN
#      LET g_sql = g_sql," AND inag019='",g_inaa_d.inag019,"'"
#   END IF
#   
#   LET g_sql = g_sql," AND ", ls_wc
#   LET g_sql = g_sql, " ORDER BY sfbbsite,sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbbdocno,sfbbseq,sfbbseq1"
#   PREPARE aslq100_pb6 FROM g_sql
#   DECLARE b_fill_curs6 CURSOR FOR aslq100_pb6   
#   FOREACH b_fill_curs6 INTO g_inag4_d[l_ac4].*
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         EXIT FOREACH
#      END IF
#      CALL aslq100_b_fill4_desc()
#      LET l_ac4 = l_ac4 + 1
#      IF l_ac4 > g_max_rec THEN
#         EXIT FOREACH
#      END IF
#   END FOREACH   
   #161019-00023#1-E
   #
   #mark by geza 20161209 #161124-00039#1(E)   
   LET g_cnt4 = l_ac4 - 1
   CALL g_inag4_d.deleteElement(l_ac4)
   
END FUNCTION

PRIVATE FUNCTION aslq100_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING

   LET ls_name = "formonly.", ps_object

   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF

   #顯示資料組合
   LET ls_condition = aslq100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION

#资料清单页签ref栏位显示
PRIVATE FUNCTION aslq100_b_fill_desc()
   CALL s_desc_get_department_desc(g_inag_d[l_ac].b_inagsite) RETURNING g_inag_d[l_ac].b_inagsite_desc
   DISPLAY BY NAME g_inag_d[l_ac].b_inagsite_desc
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag_d[l_ac].b_inag001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag_d[l_ac].b_inag001_desc = '', g_rtn_fields[1] , ''
   LET g_inag_d[l_ac].b_inag001_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inag_d[l_ac].b_inag001_desc,g_inag_d[l_ac].b_inag001_desc_1
   
   CALL s_feature_description(g_inag_d[l_ac].b_inag001,g_inag_d[l_ac].b_inag002) RETURNING g_success,g_inag_d[l_ac].b_inag002_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag_d[l_ac].b_inag007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag_d[l_ac].b_inag007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inag_d[l_ac].b_inag007_desc
   
   IF g_inag_d[l_ac].b_inag004 IS NOT NULL THEN
      LET g_inag_d[l_ac].b_inag004_desc = s_desc_get_stock_desc(g_site,g_inag_d[l_ac].b_inag004) 
      DISPLAY BY NAME g_inag_d[l_ac].b_inag004_desc
   END IF
   
   IF g_inag_d[l_ac].b_inag004 IS NOT NULL AND g_inag_d[l_ac].b_inag005 IS NOT NULL THEN
      LET g_inag_d[l_ac].b_inag005_desc = s_desc_get_locator_desc(g_site,g_inag_d[l_ac].b_inag004,g_inag_d[l_ac].b_inag005)  
      DISPLAY BY NAME g_inag_d[l_ac].b_inag005_desc
   END IF
END FUNCTION

#库存明细资料页签ref栏位显示
PRIVATE FUNCTION aslq100_b_fill2_desc()
   
   CALL s_desc_get_department_desc(g_inag2_d[l_ac2].l_inagsite_1) RETURNING g_inag2_d[l_ac2].l_inagsite_1_desc
   DISPLAY BY NAME g_inag2_d[l_ac2].l_inagsite_1_desc
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag2_d[l_ac2].l_inag001_1
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag2_d[l_ac2].l_inag001_1_desc = '', g_rtn_fields[1] , ''
   LET g_inag2_d[l_ac2].l_inag001_1_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inag2_d[l_ac2].l_inag001_1_desc,g_inag2_d[l_ac2].l_inag001_1_desc_1
   
   CALL s_feature_description(g_inag2_d[l_ac2].l_inag001_1,g_inag2_d[l_ac2].l_inag002_1) RETURNING g_success,g_inag2_d[l_ac2].l_inag002_1_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag2_d[l_ac2].l_inag007_1
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag2_d[l_ac2].l_inag007_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inag2_d[l_ac2].l_inag007_1_desc
   
   IF g_inag2_d[l_ac2].l_inag004_1 IS NOT NULL THEN
      LET g_inag2_d[l_ac2].l_inag004_1_desc = s_desc_get_stock_desc(g_site,g_inag2_d[l_ac2].l_inag004_1) 
      DISPLAY BY NAME g_inag2_d[l_ac2].l_inag004_1_desc
   END IF
   
   IF g_inag2_d[l_ac2].l_inag004_1 IS NOT NULL AND g_inag2_d[l_ac2].l_inag005_1 IS NOT NULL THEN
      LET g_inag2_d[l_ac2].l_inag005_1_desc = s_desc_get_locator_desc(g_site,g_inag2_d[l_ac2].l_inag004_1,g_inag2_d[l_ac2].l_inag005_1)  
      DISPLAY BY NAME g_inag2_d[l_ac2].l_inag005_1_desc
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag2_d[l_ac2].l_inag024_1
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag2_d[l_ac2].l_inag024_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inag2_d[l_ac2].l_inag024_1_desc
END FUNCTION

#制造批序号资料页签ref栏位显示
PRIVATE FUNCTION aslq100_b_fill3_desc()
   
   CALL s_desc_get_department_desc(g_inag3_d[l_ac3].inaisite) RETURNING g_inag3_d[l_ac3].inaisite_desc
   DISPLAY BY NAME g_inag3_d[l_ac3].inaisite_desc
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag3_d[l_ac3].inai001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag3_d[l_ac3].inai001_desc = '', g_rtn_fields[1] , ''
   LET g_inag3_d[l_ac3].inai001_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inag3_d[l_ac3].inai001_desc,g_inag3_d[l_ac3].inai001_desc_1
   
   CALL s_feature_description(g_inag3_d[l_ac3].inai001,g_inag3_d[l_ac3].inai002) RETURNING g_success,g_inag3_d[l_ac3].inai002_desc
   
   IF g_inag3_d[l_ac3].inai004 IS NOT NULL THEN
      LET g_inag3_d[l_ac3].inai004_desc = s_desc_get_stock_desc(g_site,g_inag3_d[l_ac3].inai004) 
      DISPLAY BY NAME g_inag3_d[l_ac3].inai004_desc
   END IF
   
   IF g_inag3_d[l_ac3].inai004 IS NOT NULL AND g_inag3_d[l_ac3].inai005 IS NOT NULL THEN
      LET g_inag3_d[l_ac3].inai005_desc = s_desc_get_locator_desc(g_site,g_inag3_d[l_ac3].inai004,g_inag3_d[l_ac3].inai005)  
      DISPLAY BY NAME g_inag3_d[l_ac3].inai005_desc
   END IF
END FUNCTION

#在拣量资料页签ref栏位显示
PRIVATE FUNCTION aslq100_b_fill4_desc()
   
   CALL s_desc_get_department_desc(g_inag4_d[l_ac4].inapsite) RETURNING g_inag4_d[l_ac4].inapsite_desc
   DISPLAY BY NAME g_inag4_d[l_ac4].inapsite_desc
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag4_d[l_ac4].inap004
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag4_d[l_ac4].inap004_desc = '', g_rtn_fields[1] , ''
   LET g_inag4_d[l_ac4].inap004_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inag4_d[l_ac4].inap004_desc,g_inag4_d[l_ac4].inap004_desc_1
   
   CALL s_feature_description(g_inag4_d[l_ac4].inap004,g_inag4_d[l_ac4].inap005) RETURNING g_success,g_inag4_d[l_ac4].inap005_desc
   
   IF g_inag4_d[l_ac4].inap007 IS NOT NULL THEN
      LET g_inag4_d[l_ac4].inap007_desc = s_desc_get_stock_desc(g_site,g_inag4_d[l_ac4].inap007) 
      DISPLAY BY NAME g_inag4_d[l_ac4].inap007_desc
   END IF
   
   IF g_inag4_d[l_ac4].inap007 IS NOT NULL AND g_inag4_d[l_ac4].inap008 IS NOT NULL THEN
      LET g_inag4_d[l_ac4].inap008_desc = s_desc_get_locator_desc(g_site,g_inag4_d[l_ac4].inap007,g_inag4_d[l_ac4].inap008)  
      DISPLAY BY NAME g_inag4_d[l_ac4].inap008_desc
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag4_d[l_ac4].inap017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inag4_d[l_ac4].inap017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inag4_d[l_ac4].inap017_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inag4_d[l_ac4].inap018
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inag4_d[l_ac4].inap018_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inag4_d[l_ac4].inap018_desc
END FUNCTION

#清楚条件
PRIVATE FUNCTION aslq100_qbeclear()
   CLEAR FORM
   CALL g_inag_d.clear()
   CALL g_inag2_d.clear()
   CALL g_inag3_d.clear()
   CALL g_inag4_d.clear()
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc_filter TO NULL
   LET g_inag.imaa009 = ''
   LET g_inag.inag001 = ''
   LET g_inag.inag002 = ''
   LET g_inag.inag003 = ''
   LET g_inag.inag004 = ''
   LET g_inag.inag005 = ''
   LET g_inag.inag006 = ''
   LET g_inag.inad011 = ''
   LET g_inag.inag027 = ''
   LET g_inag.inag014 = ''
   LET g_inaa_d.inaa010 = ''
   LET g_inaa_d.inaa009 = ''
   LET g_inaa_d.inaa008 = ''
   LET g_inaa_d.inaa015 = ''
   LET g_inaa_d.inaa016 = ''
   LET g_inaa_d.inag019 = ''
   
END FUNCTION

PRIVATE FUNCTION aslq100_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc


   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)



   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CLEAR FORM
   CALL g_inag_d.clear()
   CALL g_inag2_d.clear()
   CALL g_inag3_d.clear()
   CALL g_inag4_d.clear()
  # CALL s_detail1.clear()

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
      #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON inag001,inag002,inag003,inag004,inag005,inag006,inag007,inad011,inag027
                          FROM s_detail1[1].b_inag001,s_detail1[1].b_inag002,s_detail1[1].b_inag003,
                              s_detail1[1].b_inag004,s_detail1[1].b_inag005,
                              s_detail1[1].b_inag006,s_detail1[1].b_inag007,
                              s_detail1[1].b_inad011,s_detail1[1].b_inag027


         BEFORE CONSTRUCT
            DISPLAY BY NAME g_inag.imaa009,g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,g_inag.inag005,g_inag.inag006,g_inag.inad011,g_inag.inag027,g_inag.inag014
            
         ON ACTION controlp INFIELD b_inag001          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag001      #顯示到畫面上
            NEXT FIELD b_inag001                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag002          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag002      #顯示到畫面上
            NEXT FIELD b_inag002                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag003          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag003      #顯示到畫面上
            NEXT FIELD b_inag003                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag004          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag004      #顯示到畫面上
            NEXT FIELD b_inag004                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag005          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag005      #顯示到畫面上
            NEXT FIELD b_inag005                         #返回原欄位
            
         ON ACTION controlp INFIELD b_inag006          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inag006      #顯示到畫面上
            NEXT FIELD b_inag006                         #返回原欄位
      
      END CONSTRUCT

      #add-point:filter段add_cs

      #end add-point

      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG





   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " AND ",g_wc_filter_t
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF

  #CALL aslq100_filter_show('inag001','b_inag001')
  #CALL aslq100_filter_show('inag002','b_inag002')
  #CALL aslq100_filter_show('inag003','b_inag003')
  #CALL aslq100_filter_show('inag004','b_inag004')
  #CALL aslq100_filter_show('inag005','b_inag005')
  #CALL aslq100_filter_show('inag006','b_inag006')
  #CALL aslq100_filter_show('inag007','b_inag007')
  #CALL aslq100_filter_show('inad011','b_inad011')
  #CALL aslq100_filter_show('inag027','b_inag027')


   CALL aslq100_b_fill()


   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)

END FUNCTION

#end add-point
 
{</section>}
 
