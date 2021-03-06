#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt400_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2017-01-10 15:10:59), PR版次:0017(2017-05-05 16:14:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: apmt400_01
#+ Description: 請購單身整批產生子作業
#+ Creator....: 02294(2014-12-01 10:16:43)
#+ Modifier...: 02294 -SD/PR- TOPSTD
 
{</section>}
 
{<section id="apmt400_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00025#2   2016/04/07  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160512-00016#23  2016/05/27  By lixiang     因為s_asft300_02_bom增加參數，所以call s_asft300_02_bom的地方多傳保稅否欄位 pmdb043
#160708-00015#1   2016/07/19  By lixiang     請購單單身，選擇依工單整批產生,查詢的備料料號的補給策略(imaf013)須為'1:採購'
#160706-00029#1   2016/07/19  By lixiang     修正 單身選擇依工單整批產生方式，單頭第一個項次輸入第一張工單單號、接著第二項輸入第二張工單單號，再把第二個項次刪除，按[產生底稿]，請購底稿卻包含了刪除掉的第二張工單的備料
#160720-00011#1   2016/07/20  By lixiang     展BOM时，不需要将元件的单位转换成主件单位对应的数量
#160816-00064#1   2016/08/16  By lixiang     展BOM时，无需判断返回的bom数组大于1（g_bmba.getLength() > 1）；
#160731-00042#1   2016/08/25  By lixiang     （#160731-00444#1）整批产生后，请购单单身无内容时，不再弹出整批产生单身的选择，且提示无资料产生
#161108-00012#3   2016/11/09  By 08734       g_browser_cnt 由num5改為num10
#161102-00065#1   2016/11/21  By wuxja       需求日期应以画面输入为主，若没有，则由单据带出
#161125-00008#1   2016/11/26  By wuxja       需求日期赋值位置调整
#161212-00034#1   2016/12/12  By wuxja       1、需求日期改为必输，防止因需求日期不同导致请购数量增大了； 2、已备料量查询条件调整
#161212-00015#1   2016/12/12  By wuxja       计算在采量时应扣除结案部分
#161215-00034#1   2016/12/19  By wuxja       依订单展bom生成时需考虑订单的bom特性
#161124-00048#9   2016/12/19  By zhujing     .*整批调整
#161205-00025#1   2016/12/22  By lixiang     效能优化
#161219-00028#1   2017/01/10  By lixiang     修复来源资料单身有资料时，再开窗选择，没有更新到当前的栏位值等BUG
#161230-00034#1   2017/01/10  By lixiang     依工单产生时，增加备料单身料号的产品特征栏位
#170321-00089#1   2017/03/22  By 00768       订单转请购：展bom时需考虑订单中的产品特征需求
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="apmt400_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_bmaa_d        RECORD
   bmaa001   LIKE bmaa_t.bmaa001,
   imaal003 LIKE imaal_t.imaal003,
   imaal004 LIKE imaal_t.imaal004,
   bmaa002  LIKE bmaa_t.bmaa002,
   imaa009  LIKE imaa_t.imaa009
       END RECORD

 TYPE type_g_sfaa_d        RECORD
   sfaadocno LIKE sfaa_t.sfaadocno,
   sfbaseq   LIKE sfba_t.sfbaseq,
   sfbaseq1  LIKE sfba_t.sfbaseq1,
   sfaa010   LIKE sfaa_t.sfaa010,
   imaal003  LIKE imaal_t.imaal003,
   imaal004  LIKE imaal_t.imaal004,
   sfaa019   LIKE sfaa_t.sfaa019,
   sfaa020   LIKE sfaa_t.sfaa020,
   sfaa012   LIKE sfaa_t.sfaa012,
   sfaa002   LIKE sfaa_t.sfaa002,
   sfaa002_desc LIKE type_t.chr80,
   sfba006   LIKE sfba_t.sfba006,
   imaal003_2 LIKE imaal_t.imaal003,
   imaal004_2 LIKE imaal_t.imaal004,
   sfba021   LIKE sfba_t.sfba021,    #161230-00034#1
   sfba021_desc LIKE type_t.chr80,   #161230-00034#1
   sfba013   LIKE sfba_t.sfba013,
   sfba014   LIKE sfba_t.sfba014,
   sfba014_desc LIKE type_t.chr80
       END RECORD
       
 TYPE type_g_xmdd_d        RECORD
   xmdddocno LIKE xmdd_t.xmdddocno,
   xmddseq   LIKE xmdd_t.xmddseq,
   xmddseq1  LIKE xmdd_t.xmddseq1,
   xmddseq2  LIKE xmdd_t.xmddseq2,
   xmdd001   LIKE xmdd_t.xmdd001,
   imaal003  LIKE imaal_t.imaal003,
   imaal004  LIKE imaal_t.imaal004,
   xmdd002   LIKE xmdd_t.xmdd002,
   xmdd002_desc LIKE type_t.chr500,
   xmdd011   LIKE xmdd_t.xmdd011,
   xmdd006   LIKE xmdd_t.xmdd006,
   xmdd004   LIKE xmdd_t.xmdd004,
   xmdd004_desc LIKE type_t.chr80,
   xmda004   LIKE xmda_t.xmda004,
   xmda004_desc LIKE type_t.chr80,
   xmda002   LIKE xmda_t.xmda002,
   xmda002_desc LIKE type_t.chr80,
   xmda003   LIKE xmda_t.xmda003,
   xmda003_desc LIKE type_t.chr80
       END RECORD
       
 TYPE type_g_pmdb_d        RECORD
   pmdb004  LIKE pmdb_t.pmdb004,
   imaal003 LIKE imaal_t.imaal003,
   imaal004 LIKE imaal_t.imaal004,
   pmdb005  LIKE pmdb_t.pmdb005,
   pmdb005_desc LIKE type_t.chr500,
   pmdb030  LIKE pmdb_t.pmdb030,
   pmdb006  LIKE pmdb_t.pmdb006,
   pmdb007  LIKE pmdb_t.pmdb007,
   pmdb007_desc LIKE type_t.chr80,
   pmdb006_1 LIKE pmdb_t.pmdb006,
   pmdb007_1 LIKE pmdb_t.pmdb007,
   pmdb007_1_desc LIKE type_t.chr80,
   pmdb006_2 LIKE pmdb_t.pmdb006,
   stock     LIKE pmdb_t.pmdb006,
   safe      LIKE pmdb_t.pmdb006, 
   inventory LIKE pmdb_t.pmdb006,
   request   LIKE pmdb_t.pmdb006,
   purchase  LIKE pmdb_t.pmdb006,
   pick      LIKE pmdb_t.pmdb006,
   preparation LIKE pmdb_t.pmdb006
       END RECORD
       
 TYPE type_g_pmdb2_d        RECORD
   keyno    LIKE type_t.num10,
   pmdb004  LIKE pmdb_t.pmdb004,
   imaal003 LIKE imaal_t.imaal003,
   imaal004 LIKE imaal_t.imaal004,
   pmdb005  LIKE pmdb_t.pmdb005,
   pmdb005_desc LIKE type_t.chr500,
   pmdb006  LIKE pmdb_t.pmdb006,
   pmdb001  LIKE pmdb_t.pmdb001,
   pmdb002  LIKE pmdb_t.pmdb002,
   pmdb003  LIKE pmdb_t.pmdb003,
   pmdb052  LIKE pmdb_t.pmdb052,
   pmdb030  LIKE pmdb_t.pmdb030,
   pmdb006_1 LIKE pmdb_t.pmdb006,
   pmdb006_5 LIKE pmdb_t.pmdb006,
   pmdb007  LIKE pmdb_t.pmdb007,
   pmdb007_desc LIKE type_t.chr80
       END RECORD
       
DEFINE g_bmaa_d          DYNAMIC ARRAY OF type_g_bmaa_d
DEFINE g_bmaa_d_t        type_g_bmaa_d
DEFINE g_bmaa_d_o        type_g_bmaa_d
DEFINE g_sfaa_d          DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_sfaa_d_t        type_g_sfaa_d
DEFINE g_sfaa_d_o        type_g_sfaa_d
DEFINE g_xmdd_d          DYNAMIC ARRAY OF type_g_xmdd_d
DEFINE g_xmdd_d_t        type_g_xmdd_d
DEFINE g_xmdd_d_o        type_g_xmdd_d

DEFINE g_pmdb_d          DYNAMIC ARRAY OF type_g_pmdb_d
DEFINE g_pmdb_d_t        type_g_pmdb_d
DEFINE g_pmdb_d_o        type_g_pmdb_d
DEFINE g_pmdb2_d         DYNAMIC ARRAY OF type_g_pmdb2_d
DEFINE g_pmdb2_d_t       type_g_pmdb2_d
DEFINE g_pmdb2_d_o       type_g_pmdb2_d

DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc1                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc1_sub1            STRING                          #BOM單身產品分類的查詢
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc3                 STRING                          #單身CONSTRUCT結果

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE l_ac                  LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING

DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#3 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#3 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#3 num5==》num10
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數   #161108-00012#3  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#3  2016/11/09 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#3 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#3 num5==》num10

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#3 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數  #161108-00012#3 num5==》num10
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #

DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置

DEFINE g_pmdadocno  LIKE pmda_t.pmdadocno
DEFINE g_rec_b1     LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE l_ac1        LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_rec_b2     LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE l_ac2        LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_success    LIKE type_t.num5

DEFINE g_choice      LIKE type_t.chr1

DEFINE tm   RECORD
       inventory    LIKE type_t.chr1,   #库存可用量
       pick         LIKE type_t.chr1,   #在验量
       stock        LIKE type_t.chr1,   #已备料量
       request      LIKE type_t.chr1,   #请购量
       preparation  LIKE type_t.chr1,   #在制量
       purchase     LIKE type_t.chr1,   #在采量
       safe         LIKE type_t.chr1,   #库存安全量
       a            LIKE type_t.chr1,   #请购明细依料号汇总需求
       pmdb030      LIKE pmdb_t.pmdb030,#需求日期
       sfaa049      LIKE sfaa_t.sfaa049,#需求套数
       b            LIKE type_t.chr1    #展至尾阶
         END RECORD
         
         
DEFINE g_pmdb030     LIKE pmdb_t.pmdb030
DEFINE g_sfaa049     LIKE sfaa_t.sfaa049
DEFINE g_imaa009     LIKE imaa_t.imaa009

DEFINE g_flag        LIKE type_t.num10  #161108-00012#3 num5==》num10

DEFINE g_bmba                 DYNAMIC ARRAY OF RECORD #回传数组
       bmba001                LIKE bmba_t.bmba001,    #bom相关资料都可以通过回传的key值抓取
       bmba002                LIKE bmba_t.bmba002,
       bmba003                LIKE bmba_t.bmba003,
       bmba004                LIKE bmba_t.bmba004,
       bmba005                DATETIME YEAR TO SECOND,
       bmba007                LIKE bmba_t.bmba007,
       bmba008                LIKE bmba_t.bmba008,
       bmba035                LIKE bmba_t.bmba035,         #保稅否  #160512-00016#23
       l_bmba011              LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
       l_bmba012              LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
       l_inam002              LIKE inam_t.inam002      #元件对应特征
                              END RECORD
#end add-point
 
{</section>}
 
{<section id="apmt400_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmt400_01.other_dialog" >}

 
{</section>}
 
{<section id="apmt400_01.other_function" readonly="Y" >}

PUBLIC FUNCTION apmt400_01(--)
   #add-point:input段變數傳入
   p_pmdadocno
   #end add-point
   )
   
#add-point:input段define
DEFINE p_pmdadocno  LIKE pmda_t.pmdadocno
DEFINE lwin_curr    ui.Window
DEFINE lfrm_curr    ui.Form
DEFINE ls_path      STRING
#end add-point
   
   LET g_success = FALSE
   
   IF cl_null(p_pmdadocno) THEN
      RETURN g_success
   END IF
   
   LET g_pmdadocno = p_pmdadocno
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CONTINUE
   WHENEVER ERROR CALL cl_err_msg_log
   
   #開啟子畫面，選擇資料產生來源
   OPEN WINDOW w_apmt400_01_s01 WITH FORM cl_ap_formpath("apm","apmt400_01_s01")
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   #1.依BOM產生  #2.依工單整批產生  #3.依訂單產生 #4.依訂單展BOM產生
   INPUT g_choice FROM formonly.choice
       BEFORE INPUT
          LET g_choice = '1'
   END INPUT
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_apmt400_01_s01
      RETURN g_success
   END IF
   
   IF g_choice NOT MATCHES '[1234]' OR cl_null(g_choice) THEN
      CLOSE WINDOW w_apmt400_01_s01
      RETURN g_success
   END IF
   
   CLOSE WINDOW w_apmt400_01_s01
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt400_01 WITH FORM cl_ap_formpath("apm","apmt400_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   CALL apmt400_01_init()
   DELETE FROM bmaa_tmp
   DELETE FROM sfaa_tmp
   DELETE FROM xmdd_tmp
   DELETE FROM pmdb_tmp
   DELETE FROM pmdb_tmp2
   
   LET tm.inventory = 'Y'
   LET tm.pick = 'Y'
   LET tm.stock = 'Y'
   LET tm.request = 'Y'
   LET tm.preparation = 'Y'
   LET tm.purchase = 'Y'
   LET tm.safe = 'Y'
   
   LET tm.a = 'Y'
   LET tm.pmdb030 = ''
   LET tm.sfaa049 = ''
   LET tm.b = 'N'
   
   CALL apmt400_01_input()

   
   #畫面關閉
   CLOSE WINDOW w_apmt400_01
   
   DELETE FROM bmaa_tmp
   DELETE FROM sfaa_tmp
   DELETE FROM xmdd_tmp
   DELETE FROM pmdb_tmp
   DELETE FROM pmdb_tmp2
   
   LET INT_FLAG = FALSE
   RETURN g_success

END FUNCTION

#畫面初始化
PRIVATE FUNCTION apmt400_01_init()

   #1.依BOM產生  #2.依工單整批產生  #3.依訂單產生 #4.依訂單展BOM產生
   CASE g_choice 
      WHEN '1' CALL cl_set_comp_visible("page_2,page_3",FALSE)
      WHEN '2' CALL cl_set_comp_visible("page_1,page_3,lbl_sfaa049,sfaa049,b",FALSE)
      WHEN '3' CALL cl_set_comp_visible("page_1,page_2,lbl_sfaa049,sfaa049,b",FALSE) 
      WHEN '4' CALL cl_set_comp_visible("page_1,page_2,lbl_sfaa049,sfaa049,b",FALSE) 
   END CASE
   
END FUNCTION

PRIVATE FUNCTION apmt400_01_set_entry()

   CALL cl_set_comp_entry('pmda006',TRUE)

END FUNCTION

PRIVATE FUNCTION apmt400_01_set_no_entry()

   IF g_choice MATCHES '[14]' THEN
      CALL cl_set_comp_entry('pmda006',FALSE)
      LET tm.a = 'Y'
   END IF
      
END FUNCTION

#來源資錄入
PRIVATE FUNCTION apmt400_01_input()
DEFINE l_cmd_t               LIKE type_t.chr1
DEFINE l_cmd                 LIKE type_t.chr1
DEFINE l_n                   LIKE type_t.num10                #檢查重複用  
DEFINE l_cnt                 LIKE type_t.num10                #檢查重複用  
DEFINE l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
DEFINE l_allow_insert        LIKE type_t.num5                #可新增否 
DEFINE l_allow_delete        LIKE type_t.num5                #可刪除否  
DEFINE l_count               LIKE type_t.num10
DEFINE l_i                   LIKE type_t.num10
DEFINE l_insert              BOOLEAN
DEFINE l_str1                STRING
DEFINE l_str2                STRING
DEFINE l_str3                STRING
DEFINE l_str4                STRING
DEFINE bst                   base.StringTokenizer
DEFINE l_index               LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE l_bmaa001             LIKE bmaa_t.bmaa001
DEFINE l_bmaa002             LIKE bmaa_t.bmaa002
DEFINE l_sfaadocno           LIKE sfaa_t.sfaadocno
DEFINE l_sfbaseq             LIKE sfba_t.sfbaseq
DEFINE l_sfbaseq1            LIKE sfba_t.sfbaseq1
DEFINE l_xmdddocno           LIKE xmdd_t.xmdddocno
DEFINE l_xmddseq             LIKE xmdd_t.xmddseq
DEFINE l_xmddseq1            LIKE xmdd_t.xmddseq1
DEFINE l_xmddseq2            LIKE xmdd_t.xmddseq2
DEFINE l_bmaastus            LIKE bmaa_t.bmaastus
DEFINE l_sql                 STRING
DEFINE l_sfaa012             LIKE sfaa_t.sfaa012
DEFINE l_sfaa010             LIKE sfaa_t.sfaa010
DEFINE l_sfaa019             LIKE sfaa_t.sfaa019
DEFINE l_sfaa020             LIKE sfaa_t.sfaa020
DEFINE l_sfaa002             LIKE sfaa_t.sfaa002
DEFINE l_sfba006             LIKE sfba_t.sfba006
DEFINE l_sfba013             LIKE sfba_t.sfba013
DEFINE l_sfba014             LIKE sfba_t.sfba014
DEFINE l_xmdd006             LIKE xmdd_t.xmdd006
DEFINE l_xmdd001             LIKE xmdd_t.xmdd001
DEFINE l_xmdd002             LIKE xmdd_t.xmdd002
DEFINE l_xmdd004             LIKE xmdd_t.xmdd004
DEFINE l_xmdd011             LIKE xmdd_t.xmdd011
DEFINE l_xmda002             LIKE xmda_t.xmda002
DEFINE l_xmda003             LIKE xmda_t.xmda003
DEFINE l_xmda004             LIKE xmda_t.xmda004
DEFINE l_flag1               LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE l_ooac002             LIKE ooac_t.ooac002
DEFINE l_prog                LIKE oobx_t.oobx004
DEFINE l_ooac004             LIKE ooac_t.ooac004
DEFINE l_pmdb001             LIKE pmdb_t.pmdb001
DEFINE l_pmdb002             LIKE pmdb_t.pmdb002
DEFINE l_pmdb003             LIKE pmdb_t.pmdb003
DEFINE l_pmdb052             LIKE pmdb_t.pmdb052
DEFINE l_pmdb030             LIKE pmdb_t.pmdb030
DEFINE l_pmdb006             LIKE pmdb_t.pmdb006
DEFINE l_pmdb006_1           LIKE pmdb_t.pmdb006
DEFINE l_pmdb001_t           LIKE pmdb_t.pmdb001
DEFINE l_pmdb002_t           LIKE pmdb_t.pmdb002
DEFINE l_pmdb003_t           LIKE pmdb_t.pmdb003
DEFINE l_pmdb052_t           LIKE pmdb_t.pmdb052
DEFINE l_pmdb030_t           LIKE pmdb_t.pmdb030
DEFINE l_success             LIKE type_t.num5
DEFINE l_imaf013             LIKE imaf_t.imaf013
DEFINE l_sfba021             LIKE sfba_t.sfba021   #161230-00034#1

   #清除畫面
   CLEAR FORM                
   CALL g_bmaa_d.clear()        
   CALL g_sfaa_d.clear() 
   CALL g_xmdd_d.clear() 
   CALL g_pmdb_d.clear() 
   CALL g_pmdb2_d.clear()
   
   LET g_forupd_sql = "SELECT bmaa001,bmaa002 FROM bmaa_tmp WHERE bmaa001=? AND bmaa002=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt400_01_bmaa_bcl CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014 FROM sfaa_tmp WHERE sfaadocno=? AND sfbaseq = ? AND sfbaseq1 = ?  FOR UPDATE"  #161230-00034#1 add sfba021
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt400_01_sfaa_bcl CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003 FROM xmdd_tmp WHERE xmdddocno=? AND xmddseq=? AND xmddseq1=? AND xmddseq2=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt400_01_xmdd_bcl CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT pmdb004,pmdb005,pmdb030,pmdb006,pmdb007,pmdb006_1,pmdb007_1,pmdb006_2,stock,safe,inventory,request,purchase,pick,preparation FROM pmdb_tmp WHERE pmdb004=? AND pmdb005=? AND pmdb030 = ? AND pmdb007 = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt400_01_pmdb_bcl CURSOR FROM g_forupd_sql

   LET g_forupd_sql = "SELECT keyno,pmdb004,pmdb005,pmdb006,pmdb001,pmdb002,pmdb003,pmdb052,pmdb030,pmdb006_1,pmdb006_5,pmdb007 FROM pmdb_tmp2 WHERE keyno=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt400_01_pmdb_bcl2 CURSOR FROM g_forupd_sql
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   LET g_qryparam.state = 'i'
   LET g_errshow = 1
   
   DISPLAY tm.inventory TO FORMONLY.inventory
   DISPLAY tm.pick TO FORMONLY.pick
   DISPLAY tm.stock TO FORMONLY.stock
   DISPLAY tm.request TO FORMONLY.request
   DISPLAY tm.preparation TO FORMONLY.preparation
   DISPLAY tm.purchase TO FORMONLY.purchase
   DISPLAY tm.safe TO FORMONLY.safe
   DISPLAY tm.a TO FORMONLY.pmda006
   DISPLAY tm.pmdb030 TO FORMONLY.pmdb030
   DISPLAY tm.sfaa049 TO FORMONLY.sfaa049
   DISPLAY tm.b TO FORMONLY.b
   
   CALL apmt400_01_set_entry()
   CALL apmt400_01_set_no_entry()
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      INPUT tm.inventory,tm.pick,tm.stock,tm.request,tm.preparation,tm.purchase,tm.safe,tm.a,tm.pmdb030,tm.sfaa049,tm.b   
         FROM inventory,pick,stock,request,preparation,purchase,safe,pmda006,pmdb030,sfaa049,b  ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            
         AFTER FIELD sfaa049
            IF NOT cl_null(tm.sfaa049) THEN
               IF NOT cl_ap_chk_Range(tm.sfaa049,"0.000","0","","","azz-00079",1) THEN
                  NEXT FIELD sfaa049
               END IF
            END IF
         
      END INPUT
      
      INPUT ARRAY g_bmaa_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt400_01_bmaa_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bmaa_d.getLength()
           
         BEFORE ROW 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()

            LET g_rec_b = g_bmaa_d.getLength()
            
            IF g_rec_b >= l_ac  AND g_bmaa_d[l_ac].bmaa001 IS NOT NULL AND g_bmaa_d[l_ac].bmaa002 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_bmaa_d_t.* = g_bmaa_d[l_ac].*  #BACKUP
               LET g_bmaa_d_o.* = g_bmaa_d[l_ac].*  #BACKUP
               OPEN apmt400_01_bmaa_bcl USING g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002

               FETCH apmt400_01_bmaa_bcl INTO g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_bmaa_d_t.bmaa001
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
                
               CALL cl_show_fld_cont()
            ELSE
               LET l_cmd='a'
            END IF

        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmaa_d[l_ac].* TO NULL 
            INITIALIZE g_bmaa_d_t.* TO NULL 
            INITIALIZE g_bmaa_d_o.* TO NULL 
            
            LET g_bmaa_d_t.* = g_bmaa_d[l_ac].*
            LET g_bmaa_d_o.* = g_bmaa_d[l_ac].*
        
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            IF cl_null(g_bmaa_d[l_ac].bmaa002) THEN
               LET g_bmaa_d[l_ac].bmaa002 = ' '
            END IF
            
            SELECT COUNT(*) INTO l_count FROM bmaa_tmp 
             WHERE bmaa001 = g_bmaa_d[l_ac].bmaa001 AND bmaa002 = g_bmaa_d[l_ac].bmaa002

            IF l_count = 0 THEN 
               INSERT INTO bmaa_tmp(bmaa001,bmaa002) 
                 VALUES (g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002)
                
               LET g_rec_b = g_rec_b + 1
            END IF
            
         BEFORE DELETE                            #是否取消單身
            #160706-00029#1--s---
            #IF l_cmd = 'a' THEN
            #   LET l_cmd='d'
            #   #add-point:單身刪除後(=d)
            #
            #   #end add-point
            #ELSE
            #160706-00029#1--e---
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               
               IF cl_null(g_bmaa_d[l_ac].bmaa002) THEN
                  LET g_bmaa_d[l_ac].bmaa002 = ' '
               END IF
                
               DELETE FROM bmaa_tmp
                  WHERE bmaa001 = g_bmaa_d[l_ac].bmaa001 AND bmaa002 = g_bmaa_d[l_ac].bmaa002
                       
               CLOSE apmt400_01_bmaa_bcl
            
               LET g_rec_b = g_rec_b-1
               LET l_count = g_bmaa_d.getLength()
            #END IF  #160706-00029#1
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bmaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
         AFTER FIELD bmaa001
            CALL apmt400_01_bmaa001_ref()
            IF cl_null(g_bmaa_d[l_ac].bmaa002) THEN
               LET g_bmaa_d[l_ac].bmaa002 = ' '
            END IF
            IF (NOT cl_null(g_bmaa_d[l_ac].bmaa001)) AND (g_bmaa_d[l_ac].bmaa001 != g_bmaa_d_o.bmaa001 OR cl_null(g_bmaa_d_o.bmaa001)) THEN
               #檢查是否重複
               IF g_bmaa_d[l_ac].bmaa002 IS NOT NULL  THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmaa_tmp WHERE "||"bmaa001 = '" ||g_bmaa_d[l_ac].bmaa001|| "' AND "||"bmaa002 = '"||g_bmaa_d[l_ac].bmaa002 ||"' ",'std-00004',0) THEN 
                     LET g_bmaa_d[l_ac].bmaa001 = g_bmaa_d_o.bmaa001
                     CALL apmt400_01_bmaa001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #檢查主件編號是否存在BOM 檔中
               SELECT bmaastus INTO l_bmaastus FROM bmaa_t WHERE bmaaent = g_enterprise AND bmaasite = g_site AND bmaa001 = g_bmaa_d[l_ac].bmaa001
               IF SQLCA.sqlcode = 100 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_bmaa_d[l_ac].bmaa001
                  LET g_errparam.code   = 'aim-00126'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_bmaa_d[l_ac].bmaa001 = g_bmaa_d_o.bmaa001
                  CALL apmt400_01_bmaa001_ref()
                  NEXT FIELD CURRENT
               END IF
               
               #檢查主件編號+BOM特性是否存在BOM 檔中
               IF NOT cl_null(g_bmaa_d[l_ac].bmaa002) THEN
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bmaa_d[l_ac].bmaa001
                  LET g_chkparam.arg2 = g_bmaa_d[l_ac].bmaa002
                  
                  #160318-00025#2--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = " aim-00127:sub-01302|abmm200|",cl_get_progname("abmm200",g_lang,"2"),"|:EXEPROGabmm200"
                  #160318-00025#2--add--end

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_bmaa002") THEN
                     LET g_bmaa_d[l_ac].bmaa001 = g_bmaa_d_o.bmaa001
                     CALL apmt400_01_bmaa001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            UPDATE bmaa_tmp SET (bmaa001,bmaa002) = (g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002)
                WHERE bmaa001 = g_bmaa_d_o.bmaa001 AND bmaa002 = g_bmaa_d_o.bmaa002
                
            LET g_bmaa_d_o.bmaa001 = g_bmaa_d[l_ac].bmaa001
            
            
         AFTER FIELD bmaa002
            IF (NOT cl_null(g_bmaa_d[l_ac].bmaa002)) AND (g_bmaa_d[l_ac].bmaa002 != g_bmaa_d_o.bmaa002 OR cl_null(g_bmaa_d_o.bmaa002)) THEN
               #檢查是否重複
               IF g_bmaa_d[l_ac].bmaa001 IS NOT NULL  THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmaa_tmp WHERE "||"bmaa001 = '" ||g_bmaa_d[l_ac].bmaa001|| "' AND "||"bmaa002 = '"||g_bmaa_d[l_ac].bmaa002 ||"' ",'std-00004',0) THEN 
                     LET g_bmaa_d[l_ac].bmaa002 = g_bmaa_d_o.bmaa002
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #檢查主件編號+BOM特性是否存在BOM 檔中
               IF g_bmaa_d[l_ac].bmaa001 IS NOT NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bmaa_d[l_ac].bmaa001
                  LET g_chkparam.arg2 = g_bmaa_d[l_ac].bmaa002
                  #160318-00025#2--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = " aim-00127:sub-01302|abmm200|",cl_get_progname("abmm200",g_lang,"2"),"|:EXEPROGabmm200"
                  #160318-00025#2--add--end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_bmaa002") THEN
                     LET g_bmaa_d[l_ac].bmaa002 = g_bmaa_d_o.bmaa002
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF l_cmd = 'a' THEN
                     INSERT INTO bmaa_tmp(bmaa001,bmaa002) 
                       VALUES (g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002)
                     LET g_rec_b = g_rec_b + 1
                  END IF    
               END IF
            END IF
            
            IF cl_null(g_bmaa_d[l_ac].bmaa002) THEN
               LET g_bmaa_d[l_ac].bmaa002 = ' '
            END IF
            
            UPDATE bmaa_tmp SET (bmaa001,bmaa002) = (g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002)
                WHERE bmaa001 = g_bmaa_d_o.bmaa001 AND bmaa002 = g_bmaa_d_o.bmaa002
                
            LET g_bmaa_d_o.bmaa002 = g_bmaa_d[l_ac].bmaa002

         ON ACTION controlp INFIELD bmaa001         
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmaa_d[l_ac].bmaa001            #給予default值
            LET g_qryparam.default2 = g_bmaa_d[l_ac].bmaa002
            
            IF l_cmd = 'a' THEN
               LET g_qryparam.where = " bmaastus = 'Y' "
            END IF
            CALL q_bmaa001_1() 
            
            #LET l_str1 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET l_str2 = g_qryparam.return2
            IF l_cmd = 'a' THEN  #161219-00028#1
               FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_bmaa001 = l_str1
                   LET l_bmaa002 = l_str2
                   LET l_count = 0  
                   IF cl_null(l_bmaa002) THEN
                      LET l_bmaa002 = ' '
                   END IF
                   SELECT COUNT(*) INTO l_count FROM bmaa_tmp 
                    WHERE bmaa001 = l_bmaa001 AND bmaa002 = l_bmaa002
                   IF l_count = 0 THEN
                      INSERT INTO  bmaa_tmp (bmaa001,bmaa002) VALUES(l_bmaa001,l_bmaa002)
                   END IF
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL
               
               #161205-00025#1---s
               #CALL apmt400_01_bmaa_fill()
               #LET g_rec_b = g_bmaa_d.getLength()
               #IF g_rec_b > 0 THEN
               SELECT COUNT(1) INTO l_n FROM bmaa_tmp
               IF l_n > 0 THEN
               #161205-00025#1---e
                  LET g_flag = TRUE
                  EXIT DIALOG
               END IF
               INITIALIZE g_qryparam.str_array TO NULL
            #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_bmaa_d[l_ac].bmaa001 = g_qryparam.return1
               LET g_bmaa_d[l_ac].bmaa002 = g_qryparam.return2
               DISPLAY g_bmaa_d[l_ac].bmaa001 TO bmaa001              #顯示到畫面上
               DISPLAY g_bmaa_d[l_ac].bmaa002 TO bmaa002              #顯示到畫面上
               UPDATE bmaa_tmp SET (bmaa001,bmaa002) = (g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002)
                 WHERE bmaa001 = g_bmaa_d_o.bmaa001 AND bmaa002 = g_bmaa_d_o.bmaa002
            END IF 
            #161219-00028#1---e
            
         ON ACTION controlp INFIELD bmaa002         
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'c'
            END IF
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmaa_d[l_ac].bmaa002
            LET g_qryparam.where = " bmaa001 = '",g_bmaa_d[l_ac].bmaa001,"' "
            
            IF l_cmd = 'a' THEN
               LET g_qryparam.where = g_qryparam.where , " AND bmaastus = 'Y' "
            END IF
            
            CALL q_bmaa002() 
            
            LET l_str1 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET l_index = l_str1.getIndexOf('|',1)
            #開窗時多選，則所選資料全部新增到表中
            IF l_index > 1 THEN
               LET bst= base.StringTokenizer.create(l_str1,"|")
               WHILE bst.hasMoreTokens()
                  LET l_str2 = bst.nextToken()
                  LET l_bmaa002 = l_str2
                  LET l_count = 0  
                  IF cl_null(l_bmaa002) THEN
                     LET l_bmaa002 = ' '
                  END IF
                  SELECT COUNT(*) INTO l_count FROM bmaa_tmp 
                   WHERE bmaa001 = g_bmaa_d[l_ac].bmaa001 AND bmaa002 = l_bmaa002
                  IF l_count = 0 THEN
                     INSERT INTO bmaa_tmp (bmaa001,bmaa002) VALUES(g_bmaa_d[l_ac].bmaa001,l_bmaa002)
                  END IF
               END WHILE
               #161205-00025#1---s
               #CALL apmt400_01_bmaa_fill()
               #LET g_rec_b = g_bmaa_d.getLength()
               #IF g_rec_b > 0 THEN
               SELECT COUNT(1) INTO l_n FROM bmaa_tmp
               IF l_n > 0 THEN
               #161205-00025#1---e
                  LET g_flag = TRUE
                  EXIT DIALOG
               END IF
            ELSE
               LET g_bmaa_d[l_ac].bmaa002 = g_qryparam.return1
               IF cl_null(g_bmaa_d[l_ac].bmaa002) THEN
                   LET g_bmaa_d[l_ac].bmaa002 = ' '
                END IF
               LET l_count = 1  
               SELECT COUNT(*) INTO l_count FROM bmaa_tmp 
                WHERE bmaa001 = g_bmaa_d[l_ac].bmaa001 AND bmaa002 = g_bmaa_d[l_ac].bmaa002
               IF l_count = 0 THEN
                  INSERT INTO bmaa_tmp (bmaa001,bmaa002) VALUES(g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002)
               END IF
               #161219-00028#1---s
               #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
               IF l_cmd='u' THEN
                  DELETE FROM bmaa_tmp WHERE bmaa001 = g_bmaa_d_o.bmaa001 AND bmaa002 = g_bmaa_d_o.bmaa002
               END IF
               #161219-00028#1---e 
               LET g_bmaa_d_o.bmaa002 = g_bmaa_d[l_ac].bmaa002
               
               DISPLAY g_bmaa_d[l_ac].bmaa002 TO bmaa002
               NEXT FIELD bmaa002                          #返回原欄位
            END IF
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_bmaa_d[l_ac].* = g_bmaa_d_t.*
               CLOSE apmt400_01_bmaa_bcl
               EXIT DIALOG 
            END IF
            IF cl_null(g_bmaa_d[l_ac].bmaa002) THEN
               LET g_bmaa_d[l_ac].bmaa002 = ' '
            END IF
            IF cl_null(g_bmaa_d_t.bmaa002) THEN
               LET g_bmaa_d_t.bmaa002 = ' '
            END IF    
            UPDATE bmaa_tmp SET (bmaa001,bmaa002) = (g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002)
                WHERE bmaa001 = g_bmaa_d_t.bmaa001 AND bmaa002 = g_bmaa_d_t.bmaa002
            
         AFTER ROW
           CLOSE apmt400_01_bmaa_bcl
         
         AFTER INPUT
           
      END INPUT
      
      INPUT ARRAY g_sfaa_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sfaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt400_01_sfaa_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_sfaa_d.getLength()
           
         BEFORE ROW 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()

            LET g_rec_b = g_sfaa_d.getLength()
            
            IF g_rec_b >= l_ac  AND g_sfaa_d[l_ac].sfaadocno IS NOT NULL AND g_sfaa_d[l_ac].sfbaseq IS NOT NULL AND g_sfaa_d[l_ac].sfbaseq1 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_sfaa_d_t.* = g_sfaa_d[l_ac].*  #BACKUP
               LET g_sfaa_d_o.* = g_sfaa_d[l_ac].*  #BACKUP
               OPEN apmt400_01_sfaa_bcl USING g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1

               FETCH apmt400_01_sfaa_bcl INTO g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
	                                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
					                               g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,
					                               g_sfaa_d[l_ac].sfba021,   #161230-00034#1 add sfba021
					                               g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_sfaa_d_t.sfaadocno
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
                
               CALL cl_show_fld_cont()
            ELSE
               LET l_cmd='a'
            END IF

        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_sfaa_d[l_ac].* TO NULL 
            INITIALIZE g_sfaa_d_t.* TO NULL 
            INITIALIZE g_sfaa_d_o.* TO NULL 
            
            LET g_sfaa_d[l_ac].sfaa012 = 0
            LET g_sfaa_d_t.* = g_sfaa_d[l_ac].*
            LET g_sfaa_d_o.* = g_sfaa_d[l_ac].*
        
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM sfaa_tmp 
             WHERE sfaadocno = g_sfaa_d[l_ac].sfaadocno AND sfbaseq = g_sfaa_d[l_ac].sfbaseq AND sfbaseq1 = g_sfaa_d[l_ac].sfbaseq1

            IF l_count = 0 THEN 
               INSERT INTO sfaa_tmp(sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) #161230-00034#1 add sfba021 
                 VALUES (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                   g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021, #161230-00034#1 add sfba021
			                g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                               
               LET g_rec_b = g_rec_b + 1
            END IF
            
         BEFORE DELETE                            #是否取消單身
            #160706-00029#1--s---
            #IF l_cmd = 'a' THEN
            #   LET l_cmd='d'
            #   #add-point:單身刪除後(=d)
            #
            #   #end add-point
            #ELSE
            #160706-00029#1--e---
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               
               DELETE FROM sfaa_tmp
                  WHERE sfaadocno = g_sfaa_d[l_ac].sfaadocno
                    AND sfbaseq = g_sfaa_d[l_ac].sfbaseq
		              AND sfbaseq1 = g_sfaa_d[l_ac].sfbaseq1
		    
               CLOSE apmt400_01_sfaa_bcl
            
               LET g_rec_b = g_rec_b-1
               LET l_count = g_sfaa_d.getLength()
            #END IF  #160706-00029#1
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sfaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
         AFTER FIELD sfaadocno
            IF (NOT cl_null(g_sfaa_d[l_ac].sfaadocno)) AND (g_sfaa_d[l_ac].sfaadocno != g_sfaa_d_o.sfaadocno OR cl_null(g_sfaa_d_o.sfaadocno)) THEN
               
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_sfaa_d[l_ac].sfaadocno
               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_sfaadocno_4") THEN
                  LET g_sfaa_d[l_ac].sfaadocno = g_sfaa_d_o.sfaadocno
                  NEXT FIELD CURRENT
               END IF

               SELECT sfaa010,sfaa019,sfaa020,sfaa012,sfaa002 
	                INTO g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002 
		            FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_sfaa_d[l_ac].sfaadocno
               DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002 

	            CALL s_desc_get_person_desc(g_sfaa_d[l_ac].sfaa002) RETURNING g_sfaa_d[l_ac].sfaa002_desc
               DISPLAY BY NAME g_sfaa_d[l_ac].sfaa002_desc

	            IF cl_null(g_sfaa_d[l_ac].sfaa012) THEN
                  LET g_sfaa_d[l_ac].sfaa012 =  0
               END IF
               
               LET g_sfaa_d[l_ac].sfbaseq = ''
               LET g_sfaa_d[l_ac].sfbaseq1= ''
               LET g_sfaa_d[l_ac].sfba006 = ''
               LET g_sfaa_d[l_ac].imaal003_2=''
               LET g_sfaa_d[l_ac].imaal004_2=''
               LET g_sfaa_d[l_ac].sfba021 = ''  #161230-00034#1 add sfba021
               LET g_sfaa_d[l_ac].sfba021_desc = '' #161230-00034#1 add
               LET g_sfaa_d[l_ac].sfba013 = ''
               LET g_sfaa_d[l_ac].sfba014 = ''
               LET g_sfaa_d[l_ac].sfba014_desc = ''
	            LET l_n = 0
	            SELECT COUNT(*) INTO l_n FROM sfba_t WHERE sfbaent = g_enterprise AND sfbadocno = g_sfaa_d[l_ac].sfaadocno
	            IF l_n = 1 THEN
                  SELECT sfbaseq,sfbaseq1,sfba006,sfba021,(sfba013-sfba016),sfba014   #161230-00034#1 add sfba021
		               INTO g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021, #161230-00034#1 add sfba021
		                    g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014
		              FROM sfba_t WHERE sfbaent = g_enterprise AND sfbadocno = g_sfaa_d[l_ac].sfaadocno
		            
		            #160708-00015#1---s
		            LET l_imaf013 = apmt400_01_get_imaf013(g_sfaa_d[l_ac].sfba006)
		            IF l_imaf013 <> '1' THEN
		               INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sfaa_d[l_ac].sfba006
                     LET g_errparam.code   = 'apm-01121'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_sfaa_d[l_ac].sfbaseq = ''
                     LET g_sfaa_d[l_ac].sfbaseq1= ''
                     LET g_sfaa_d[l_ac].sfba006 = ''
                     LET g_sfaa_d[l_ac].imaal003_2=''
                     LET g_sfaa_d[l_ac].imaal004_2=''
                     LET g_sfaa_d[l_ac].sfba021 = ''  #161230-00034#1 add sfba021
                     LET g_sfaa_d[l_ac].sfba021_desc = '' #161230-00034#1 add
                     LET g_sfaa_d[l_ac].sfba013 = ''
                     LET g_sfaa_d[l_ac].sfba014 = ''
                     LET g_sfaa_d[l_ac].sfba014_desc = ''
                     LET g_sfaa_d[l_ac].sfaadocno = g_sfaa_d_o.sfaadocno
                     NEXT FIELD CURRENT
		            END IF
		            #160708-00015#1---e
		            
		            CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfba006) RETURNING g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
                  
		            CALL s_desc_get_unit_desc(g_sfaa_d[l_ac].sfba014) RETURNING g_sfaa_d[l_ac].sfba014_desc
                  DISPLAY BY NAME g_sfaa_d[l_ac].sfba014_desc
                  
                  #161230-00034#1---s
                  CALL s_feature_description(g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021) RETURNING l_success,g_sfaa_d[l_ac].sfba021_desc
                  DISPLAY BY NAME g_sfaa_d[l_ac].sfba021_desc
                  #161230-00034#1---e
                  
                  IF l_cmd = 'a' THEN 
                     #161219-00028#1--s
                     LET l_count = 1  
                     SELECT COUNT(*) INTO l_count FROM sfaa_tmp 
                      WHERE sfaadocno = g_sfaa_d[l_ac].sfaadocno AND sfbaseq = g_sfaa_d[l_ac].sfbaseq AND sfbaseq1 = g_sfaa_d[l_ac].sfbaseq1
                     
                     IF l_count = 0 THEN
                     #161219-00028#1---e                     
                        INSERT INTO sfaa_tmp(sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014)  #161230-00034#1 add sfba021
                         VALUES (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                                       
                        LET g_rec_b = g_rec_b + 1
                     END IF   #161219-00028#1
                 END IF
	           END IF
              DISPLAY BY NAME g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014
              DISPLAY BY NAME g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
              DISPLAY BY NAME g_sfaa_d[l_ac].sfba014_desc
            END IF
            
            UPDATE sfaa_tmp SET (sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) =   #161230-00034#1 add sfba021
                                (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                WHERE sfaadocno = g_sfaa_d_o.sfaadocno AND sfbaseq = g_sfaa_d_o.sfbaseq AND sfbaseq1 = g_sfaa_d_o.sfbaseq1
            
            LET g_sfaa_d_o.sfaadocno = g_sfaa_d[l_ac].sfaadocno
         
	      AFTER FIELD sfbaseq
            IF (NOT cl_null(g_sfaa_d[l_ac].sfbaseq)) AND (g_sfaa_d[l_ac].sfbaseq != g_sfaa_d_o.sfbaseq OR cl_null(g_sfaa_d_o.sfbaseq)) THEN
               
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfaa_d[l_ac].sfaadocno
               LET g_chkparam.arg2 = g_sfaa_d[l_ac].sfbaseq
               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_sfbaseq") THEN
                  LET g_sfaa_d[l_ac].sfbaseq = g_sfaa_d_o.sfbaseq
                  NEXT FIELD CURRENT
               END IF
               
               LET g_sfaa_d[l_ac].sfbaseq1= ''
               LET g_sfaa_d[l_ac].sfba006 = ''
               LET g_sfaa_d[l_ac].imaal003_2=''
               LET g_sfaa_d[l_ac].imaal004_2=''
               LET g_sfaa_d[l_ac].sfba021 = ''  #161230-00034#1 add sfba021
               LET g_sfaa_d[l_ac].sfba021_desc = '' #161230-00034#1 add
               LET g_sfaa_d[l_ac].sfba013 = ''
               LET g_sfaa_d[l_ac].sfba014 = ''
               LET g_sfaa_d[l_ac].sfba014_desc = ''
               
	            LET l_n = 0
	            SELECT COUNT(*) INTO l_n FROM sfba_t 
	               WHERE sfbaent = g_enterprise AND sfbadocno = g_sfaa_d[l_ac].sfaadocno AND sfbaseq = g_sfaa_d[l_ac].sfbaseq
	            IF l_n = 1 THEN
                  SELECT sfbaseq1,sfba006,sfba021,(sfba013-sfba016),sfba014   #161230-00034#1 add sfba021
		                INTO g_sfaa_d[l_ac].sfbaseq1,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,   #161230-00034#1 add sfba021
		                     g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014
		              FROM sfba_t WHERE sfbaent = g_enterprise AND sfbadocno = g_sfaa_d[l_ac].sfaadocno AND sfbaseq = g_sfaa_d[l_ac].sfbaseq
		            
		            #160708-00015#1---s
		            LET l_imaf013 = apmt400_01_get_imaf013(g_sfaa_d[l_ac].sfba006)
		            IF l_imaf013 <> '1' THEN
		               INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sfaa_d[l_ac].sfba006
                     LET g_errparam.code   = 'apm-01121'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_sfaa_d[l_ac].sfbaseq1= ''
                     LET g_sfaa_d[l_ac].sfba006 = ''
                     LET g_sfaa_d[l_ac].imaal003_2=''
                     LET g_sfaa_d[l_ac].imaal004_2=''
                     LET g_sfaa_d[l_ac].sfba021 = ''  #161230-00034#1 add sfba021
                     LET g_sfaa_d[l_ac].sfba021_desc = '' #161230-00034#1 add
                     LET g_sfaa_d[l_ac].sfba013 = ''
                     LET g_sfaa_d[l_ac].sfba014 = ''
                     LET g_sfaa_d[l_ac].sfba014_desc = ''
                     LET g_sfaa_d[l_ac].sfbaseq = g_sfaa_d_o.sfbaseq
                     NEXT FIELD CURRENT
		            END IF
		            #160708-00015#1---e  
		            CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfba006) RETURNING g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
                  
		            CALL s_desc_get_unit_desc(g_sfaa_d[l_ac].sfba014) RETURNING g_sfaa_d[l_ac].sfba014_desc
		            
		            #161230-00034#1---s
                  CALL s_feature_description(g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021) RETURNING l_success,g_sfaa_d[l_ac].sfba021_desc
                  DISPLAY BY NAME g_sfaa_d[l_ac].sfba021_desc
                  #161230-00034#1---e
                  
	               IF l_cmd = 'a' THEN 
                     #161219-00028#1--s
                     LET l_count = 1  
                     SELECT COUNT(*) INTO l_count FROM sfaa_tmp 
                      WHERE sfaadocno = g_sfaa_d[l_ac].sfaadocno AND sfbaseq = g_sfaa_d[l_ac].sfbaseq AND sfbaseq1 = g_sfaa_d[l_ac].sfbaseq1
                     
                     IF l_count = 0 THEN
                     #161219-00028#1---e                     
                        INSERT INTO sfaa_tmp(sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014)  #161230-00034#1 add sfba021
                         VALUES (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                                       
                        LET g_rec_b = g_rec_b + 1
                     END IF   #161219-00028#1
                  END IF
	            END IF
               DISPLAY BY NAME g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014
               DISPLAY BY NAME g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
               DISPLAY BY NAME g_sfaa_d[l_ac].sfba014_desc
            END IF
            
            UPDATE sfaa_tmp SET (sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) = #161230-00034#1 add sfba021
                                (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                WHERE sfaadocno = g_sfaa_d_o.sfaadocno AND sfbaseq = g_sfaa_d_o.sfbaseq AND sfbaseq1 = g_sfaa_d_o.sfbaseq1
            
            LET g_sfaa_d_o.sfbaseq = g_sfaa_d[l_ac].sfbaseq

	      AFTER FIELD sfbaseq1
            IF (NOT cl_null(g_sfaa_d[l_ac].sfbaseq1)) AND (g_sfaa_d[l_ac].sfbaseq1 != g_sfaa_d_o.sfbaseq1 OR cl_null(g_sfaa_d_o.sfbaseq1)) THEN
               
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfaa_d[l_ac].sfaadocno
               LET g_chkparam.arg2 = g_sfaa_d[l_ac].sfbaseq
               LET g_chkparam.arg3 = g_sfaa_d[l_ac].sfbaseq1
               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_sfbaseq1") THEN
                  LET g_sfaa_d[l_ac].sfbaseq1 = g_sfaa_d_o.sfbaseq1
                  NEXT FIELD CURRENT
               END IF
               
	            SELECT sfba006,sfba021,(sfba013-sfba016),sfba014   #161230-00034#1 add sfba021
		            INTO g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,   #161230-00034#1 add sfba021
		                 g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014 
		           FROM sfba_t WHERE sfbaent = g_enterprise AND sfbadocno = g_sfaa_d[l_ac].sfaadocno AND sfbaseq = g_sfaa_d[l_ac].sfbaseq
		         #160708-00015#1---s
		         LET l_imaf013 = apmt400_01_get_imaf013(g_sfaa_d[l_ac].sfba006)
		         IF l_imaf013 <> '1' THEN
		            INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_sfaa_d[l_ac].sfba006
                  LET g_errparam.code   = 'apm-01121'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_sfaa_d[l_ac].sfba006 = ''
                  LET g_sfaa_d[l_ac].imaal003_2=''
                  LET g_sfaa_d[l_ac].imaal004_2=''
                  LET g_sfaa_d[l_ac].sfba021 = ''  #161230-00034#1 add sfba021
                  LET g_sfaa_d[l_ac].sfba021_desc = '' #161230-00034#1 add
                  LET g_sfaa_d[l_ac].sfba013 = ''
                  LET g_sfaa_d[l_ac].sfba014 = ''
                  LET g_sfaa_d[l_ac].sfba014_desc = ''
                  LET g_sfaa_d[l_ac].sfbaseq1 = g_sfaa_d_o.sfbaseq1
                  NEXT FIELD CURRENT
		         END IF
		         #160708-00015#1---e 
	            DISPLAY BY NAME g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014

	            CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfba006) RETURNING g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
               DISPLAY BY NAME g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2

	            CALL s_desc_get_unit_desc(g_sfaa_d[l_ac].sfba014) RETURNING g_sfaa_d[l_ac].sfba014_desc
               DISPLAY BY NAME g_sfaa_d[l_ac].sfba014_desc
               
               #161230-00034#1---s
               CALL s_feature_description(g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021) RETURNING l_success,g_sfaa_d[l_ac].sfba021_desc
               DISPLAY BY NAME g_sfaa_d[l_ac].sfba021_desc
               #161230-00034#1---e
               
               IF l_cmd = 'a' THEN 
                  #161219-00028#1--s
                     LET l_count = 1  
                     SELECT COUNT(*) INTO l_count FROM sfaa_tmp 
                      WHERE sfaadocno = g_sfaa_d[l_ac].sfaadocno AND sfbaseq = g_sfaa_d[l_ac].sfbaseq AND sfbaseq1 = g_sfaa_d[l_ac].sfbaseq1
                     
                     IF l_count = 0 THEN
                     #161219-00028#1---e                     
                        INSERT INTO sfaa_tmp(sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014)  #161230-00034#1 add sfba021
                         VALUES (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                                       
                        LET g_rec_b = g_rec_b + 1
                     END IF   #161219-00028#1
               END IF
            END IF
            UPDATE sfaa_tmp SET (sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) =  #161230-00034#1 add sfba021 
                                (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add sfba021 
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                WHERE sfaadocno = g_sfaa_d_o.sfaadocno AND sfbaseq = g_sfaa_d_o.sfbaseq AND sfbaseq1 = g_sfaa_d_o.sfbaseq1
            
            LET g_sfaa_d_o.sfbaseq1 = g_sfaa_d[l_ac].sfbaseq1

         AFTER FIELD sfaa012
            IF NOT cl_ap_chk_range(g_sfaa_d[l_ac].sfaa012,"0.000","0","","","azz-00079",1) THEN
               LET g_sfaa_d[l_ac].sfaa012 = g_sfaa_d_o.sfaa012
               NEXT FIELD sfaa012
            END IF 
            LET g_sfaa_d_o.sfaa012 = g_sfaa_d[l_ac].sfaa012
            
         ON ACTION controlp INFIELD sfaadocno         
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
	         LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaadocno            #給予default值
	         LET g_qryparam.default2 = g_sfaa_d[l_ac].sfbaseq
	         LET g_qryparam.default3 = g_sfaa_d[l_ac].sfbaseq1

            LET g_qryparam.where = " sfaasite = '",g_site,"' AND sfaastus IN ('Y','F') AND (sfba013-sfba016) >0 "
            LET g_qryparam.where = g_qryparam.where , " AND sfba006 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf013 = '1' ) "  #160708-00015#1

            CALL q_sfbaseq1_1() 
            LET l_n = 0
            IF l_cmd = 'a' THEN   #161219-00028#1
	            FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
		                   WHEN "3"
                            LET l_str3 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_sfaadocno = l_str1
                   LET l_sfbaseq = l_str2
		             LET l_sfbaseq1 = l_str3
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM sfaa_tmp 
                    WHERE sfaadocno = l_sfaadocno AND sfbaseq = l_sfbaseq AND sfbaseq1 = l_sfbaseq1
                   IF l_count = 0 THEN
                      SELECT sfaa010,sfaa019,sfaa020,sfaa012,sfaa002 
	                      INTO l_sfaa010,l_sfaa019,l_sfaa020,l_sfaa012,l_sfaa002 
		                  FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_sfaadocno
                  
                      SELECT sfba006,(sfba013-sfba016),sfba014,sfba021 #161230-00034#1 add sfba021
		                   INTO l_sfba006,l_sfba013,l_sfba014,l_sfba021 FROM sfba_t  #161230-00034#1 add sfba021
		                  WHERE sfbaent = g_enterprise AND sfbadocno = l_sfaadocno
		                    AND sfbaseq = l_sfbaseq AND sfbaseq1 = l_sfbaseq1
               
                      INSERT INTO sfaa_tmp(sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014)  #161230-00034#1 add sfba021
                         VALUES (l_sfaadocno,l_sfbaseq,l_sfbaseq1,l_sfaa010,l_sfaa019,l_sfaa020,
			                         l_sfaa012,l_sfaa002,l_sfba006,l_sfba021,l_sfba013,l_sfba014) #161230-00034#1 add sfba021
                   END IF
                   LET l_n = l_n + 1
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL

               IF l_n > 0 THEN
                  #161205-00025#1---s
                  #CALL apmt400_01_sfaa_fill()
                  #LET g_rec_b = g_sfaa_d.getLength()
                  #IF g_rec_b > 0 THEN
                  SELECT COUNT(1) INTO l_n FROM sfaa_tmp
                  IF l_n > 0 THEN
                  #161205-00025#1---e
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
	            END IF
            #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_sfaa_d[l_ac].sfaadocno = g_qryparam.return1
               LET g_sfaa_d[l_ac].sfbaseq = g_qryparam.return2
               LET g_sfaa_d[l_ac].sfbaseq1 = g_qryparam.return3
               DISPLAY g_sfaa_d[l_ac].sfaadocno TO sfaadocno              #顯示到畫面上
               DISPLAY g_sfaa_d[l_ac].sfbaseq TO sfbaseq              #顯示到畫面上
               DISPLAY g_sfaa_d[l_ac].sfbaseq1 TO sfbaseq1 
               CALL apmt400_01_sfaa_ref()
               UPDATE sfaa_tmp SET (sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) =   #161230-00034#1 add sfba021
                                (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                WHERE sfaadocno = g_sfaa_d_o.sfaadocno AND sfbaseq = g_sfaa_d_o.sfbaseq AND sfbaseq1 = g_sfaa_d_o.sfbaseq1
               NEXT FIELD sfaadocno
            END IF 
            #161219-00028#1---e
            
         ON ACTION controlp INFIELD sfbaseq         
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
	         LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaadocno            #給予default值
	         LET g_qryparam.default2 = g_sfaa_d[l_ac].sfbaseq
	         LET g_qryparam.default3 = g_sfaa_d[l_ac].sfbaseq1

            LET g_qryparam.where = " sfbasite = '",g_site,"' AND sfbadocno = '",g_sfaa_d[l_ac].sfaadocno,"' AND (sfba013-sfba016) >0 "
            LET g_qryparam.where = g_qryparam.where , " AND sfba006 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf013 = '1' ) "  #160708-00015#1
            CALL q_sfbaseq1_1() 
            LET l_n = 0
            IF l_cmd = 'a' THEN  #161219-00028#1
	            FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
		                   WHEN "3"
                            LET l_str3 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_sfaadocno = l_str1
                   LET l_sfbaseq = l_str2
		             LET l_sfbaseq1 = l_str3
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM sfaa_tmp 
                    WHERE sfaadocno = l_sfaadocno AND sfbaseq = l_sfbaseq AND sfbaseq1 = l_sfbaseq1
                   IF l_count = 0 THEN
                      SELECT sfaa010,sfaa019,sfaa020,sfaa012,sfaa002 
	                      INTO l_sfaa010,l_sfaa019,l_sfaa020,l_sfaa012,l_sfaa002 
		                  FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_sfaadocno
                  
                      SELECT sfba006,(sfba013-sfba016),sfba014,sfba021 #161230-00034#1 add sfba021
		                   INTO l_sfba006,l_sfba013,l_sfba014,l_sfba021 FROM sfba_t 
		                  WHERE sfbaent = g_enterprise AND sfbadocno = l_sfaadocno
		                    AND sfbaseq = l_sfbaseq AND sfbaseq1 = l_sfbaseq1
               
                      INSERT INTO sfaa_tmp(sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014)  #161230-00034#1 add sfba021 
                         VALUES (l_sfaadocno,l_sfbaseq,l_sfbaseq1,l_sfaa010,l_sfaa019,l_sfaa020,
			                        l_sfaa012,l_sfaa002,l_sfba006,l_sfba021,l_sfba013,l_sfba014)  #161230-00034#1 add sfba021
                   END IF
                   LET l_n = l_n + 1
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL
               
               IF l_n > 0 THEN
                  #161205-00025#1---s
                  #CALL apmt400_01_sfaa_fill()
                  #LET g_rec_b = g_sfaa_d.getLength()
                  #IF g_rec_b > 0 THEN
                  SELECT COUNT(1) INTO l_n FROM sfaa_tmp
                  IF l_n > 0 THEN
                  #161205-00025#1---e
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
	            END IF
	         #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_sfaa_d[l_ac].sfaadocno = g_qryparam.return1
               LET g_sfaa_d[l_ac].sfbaseq = g_qryparam.return2
               LET g_sfaa_d[l_ac].sfbaseq1 = g_qryparam.return3
               DISPLAY g_sfaa_d[l_ac].sfaadocno TO sfaadocno              #顯示到畫面上
               DISPLAY g_sfaa_d[l_ac].sfbaseq TO sfbaseq              #顯示到畫面上
               DISPLAY g_sfaa_d[l_ac].sfbaseq1 TO sfbaseq1 
               CALL apmt400_01_sfaa_ref()
               UPDATE sfaa_tmp SET (sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) =   #161230-00034#1 add sfba021
                                (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                WHERE sfaadocno = g_sfaa_d_o.sfaadocno AND sfbaseq = g_sfaa_d_o.sfbaseq AND sfbaseq1 = g_sfaa_d_o.sfbaseq1
               NEXT FIELD sfbaseq
            END IF 
            #161219-00028#1---e

	      ON ACTION controlp INFIELD sfbaseq1      
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
	         LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaadocno            #給予default值
	         LET g_qryparam.default2 = g_sfaa_d[l_ac].sfbaseq
	         LET g_qryparam.default3 = g_sfaa_d[l_ac].sfbaseq1

            LET g_qryparam.where = " sfbasite = '",g_site,"' AND sfbadocno = '",g_sfaa_d[l_ac].sfaadocno,"' ",
                                   " AND sfbaseq = '",g_sfaa_d[l_ac].sfbaseq,"' AND (sfba013-sfba016) >0 "
            LET g_qryparam.where = g_qryparam.where , " AND sfba006 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf013 = '1' ) "  #160708-00015#1
            CALL q_sfbaseq1_1() 
            
            LET l_n = 0
            IF l_cmd = 'a' THEN  #161219-00028#1
	            FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
		                   WHEN "3"
                            LET l_str3 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_sfaadocno = l_str1
                   LET l_sfbaseq = l_str2
		             LET l_sfbaseq1 = l_str3
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM sfaa_tmp 
                    WHERE sfaadocno = l_sfaadocno AND sfbaseq = l_sfbaseq AND sfbaseq1 = l_sfbaseq1
                   IF l_count = 0 THEN
                      SELECT sfaa010,sfaa019,sfaa020,sfaa012,sfaa002 
	                       INTO l_sfaa010,l_sfaa019,l_sfaa020,l_sfaa012,l_sfaa002 
		                  FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_sfaadocno
                  
                      SELECT sfba006,(sfba013-sfba016),sfba014,sfba021 #161230-00034#1 add sfba021
		                   INTO l_sfba006,l_sfba013,l_sfba014,l_sfba021 FROM sfba_t  #161230-00034#1 add sfba021
		                  WHERE sfbaent = g_enterprise AND sfbadocno = l_sfaadocno
		                    AND sfbaseq = l_sfbaseq AND sfbaseq1 = l_sfbaseq1
               
                      INSERT INTO sfaa_tmp(sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) #161230-00034#1 add sfba021 
                         VALUES (l_sfaadocno,l_sfbaseq,l_sfbaseq1,l_sfaa010,l_sfaa019,l_sfaa020,
			                        l_sfaa012,l_sfaa002,l_sfba006,l_sfba021,l_sfba013,l_sfba014) #161230-00034#1 add sfba021
                   END IF
                   LET l_n = l_n + 1
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL

               IF l_n > 0 THEN
                  #161205-00025#1---s
                  #CALL apmt400_01_sfaa_fill()
                  #LET g_rec_b = g_sfaa_d.getLength()
                  #IF g_rec_b > 0 THEN
                  SELECT COUNT(1) INTO l_n FROM sfaa_tmp
                  IF l_n > 0 THEN
                  #161205-00025#1---e
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
	            END IF
	         #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_sfaa_d[l_ac].sfaadocno = g_qryparam.return1
               LET g_sfaa_d[l_ac].sfbaseq = g_qryparam.return2
               LET g_sfaa_d[l_ac].sfbaseq1 = g_qryparam.return3
               DISPLAY g_sfaa_d[l_ac].sfaadocno TO sfaadocno              #顯示到畫面上
               DISPLAY g_sfaa_d[l_ac].sfbaseq TO sfbaseq              #顯示到畫面上
               DISPLAY g_sfaa_d[l_ac].sfbaseq1 TO sfbaseq1 
               CALL apmt400_01_sfaa_ref()
               UPDATE sfaa_tmp SET (sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) =   #161230-00034#1 add sfba021
                                (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                WHERE sfaadocno = g_sfaa_d_o.sfaadocno AND sfbaseq = g_sfaa_d_o.sfbaseq AND sfbaseq1 = g_sfaa_d_o.sfbaseq1
               NEXT FIELD sfbaseq1
            END IF 
            #161219-00028#1---e
	         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_sfaa_d[l_ac].* = g_sfaa_d_t.*
               CLOSE apmt400_01_sfaa_bcl
               EXIT DIALOG 
            END IF
            UPDATE sfaa_tmp SET (sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014) =  #161230-00034#1 add sfba021
                                (g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                           g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                        g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021,  #161230-00034#1 add sfba021
			                        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014)
                WHERE sfaadocno = g_sfaa_d_t.sfaadocno AND sfbaseq = g_sfaa_d_t.sfbaseq AND sfbaseq1 = g_sfaa_d_t.sfbaseq1
            
         AFTER ROW
           CLOSE apmt400_01_sfaa_bcl
         
         AFTER INPUT
           
      END INPUT
    
      INPUT ARRAY g_xmdd_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmdd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt400_01_xmdd_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xmdd_d.getLength()
           
         BEFORE ROW 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()

            LET g_rec_b = g_xmdd_d.getLength()
            
            IF g_rec_b >= l_ac  AND g_xmdd_d[l_ac].xmdddocno IS NOT NULL AND g_xmdd_d[l_ac].xmddseq IS NOT NULL AND g_xmdd_d[l_ac].xmddseq1 IS NOT NULL AND g_xmdd_d[l_ac].xmddseq2 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_xmdd_d_t.* = g_xmdd_d[l_ac].*  #BACKUP
               LET g_xmdd_d_o.* = g_xmdd_d[l_ac].*  #BACKUP
               OPEN apmt400_01_xmdd_bcl USING g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2

               FETCH apmt400_01_xmdd_bcl INTO g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                                              g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                                              g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xmdd_d_t.xmdddocno
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
                
               CALL cl_show_fld_cont()
            ELSE
               LET l_cmd='a'
            END IF

        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmdd_d[l_ac].* TO NULL 
            INITIALIZE g_xmdd_d_t.* TO NULL 
            INITIALIZE g_xmdd_d_o.* TO NULL 
            
            LET g_xmdd_d[l_ac].xmdd006 = 0
            LET g_xmdd_d_t.* = g_xmdd_d[l_ac].*
            LET g_xmdd_d_o.* = g_xmdd_d[l_ac].*
        
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
             WHERE xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq 
	            AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2

            IF l_count = 0 THEN 
               INSERT INTO xmdd_tmp(xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                 VALUES (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                         g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                         g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                
               LET g_rec_b = g_rec_b + 1
            END IF
            
         BEFORE DELETE                            #是否取消單身
            #160706-00029#1--s---
            #IF l_cmd = 'a' THEN
            #   LET l_cmd='d'
            #   #add-point:單身刪除後(=d)
            #
            #   #end add-point
            #ELSE
            #160706-00029#1--e---
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               
               DELETE FROM xmdd_tmp
                  WHERE xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq
                    AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2

               CLOSE apmt400_01_xmdd_bcl
            
               LET g_rec_b = g_rec_b-1
               LET l_count = g_xmdd_d.getLength()
            #END IF  #160706-00029#1
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmdd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
         AFTER FIELD xmdddocno
            IF (NOT cl_null(g_xmdd_d[l_ac].xmdddocno)) AND (g_xmdd_d[l_ac].xmdddocno != g_xmdd_d_o.xmdddocno OR cl_null(g_xmdd_d_o.xmdddocno)) THEN
               
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdd_d[l_ac].xmdddocno
               LET g_chkparam.where = " xmdasite = '",g_site,"' "
               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_xmdadocno_1") THEN
                  LET g_xmdd_d[l_ac].xmdddocno = g_xmdd_d_o.xmdddocno
                  NEXT FIELD CURRENT
               END IF
               
               SELECT xmda004,xmda002,xmda003 INTO g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003
                   FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = g_xmdd_d[l_ac].xmdddocno
               CALL s_desc_get_trading_partner_abbr_desc(g_xmdd_d[l_ac].xmda004) RETURNING g_xmdd_d[l_ac].xmda004_desc
               DISPLAY BY NAME g_xmdd_d[l_ac].xmda004_desc
               
               CALL s_desc_get_person_desc(g_xmdd_d[l_ac].xmda002) RETURNING g_xmdd_d[l_ac].xmda002_desc
               DISPLAY BY NAME g_xmdd_d[l_ac].xmda002_desc
       
               CALL s_desc_get_department_desc(g_xmdd_d[l_ac].xmda003) RETURNING g_xmdd_d[l_ac].xmda003_desc
               DISPLAY BY NAME g_xmdd_d[l_ac].xmda003_desc
               
               LET g_xmdd_d[l_ac].xmddseq = ''
               LET g_xmdd_d[l_ac].xmddseq1= ''
               LET g_xmdd_d[l_ac].xmddseq2= ''
               LET g_xmdd_d[l_ac].xmdd001 = ''
               LET g_xmdd_d[l_ac].imaal003 = ''
               LET g_xmdd_d[l_ac].imaal004= ''
               LET g_xmdd_d[l_ac].xmdd002 = ''
               LET g_xmdd_d[l_ac].xmdd002 = ''
               LET g_xmdd_d[l_ac].xmdd011 = ''
               LET g_xmdd_d[l_ac].xmdd006 = ''
               LET g_xmdd_d[l_ac].xmdd004 = ''
               LET g_xmdd_d[l_ac].xmdd004_desc = ''
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM xmdd_t WHERE xmddent = g_enterprise AND xmdddocno = g_xmdd_d[l_ac].xmdddocno
               IF l_n = 1 THEN
                  SELECT xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004
                      INTO g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                           g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
                     FROM xmdd_t WHERE xmddent = g_enterprise AND xmdddocno = g_xmdd_d[l_ac].xmdddocno 
                  CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001) RETURNING g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
                  
                  CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002) RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc
     
                  CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc
    
                  IF l_cmd = 'a' THEN 
                     #161219-00028#1---s
                     LET l_count = 1  
                     SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                      WHERE xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq 
	                     AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2
                     IF l_count = 0 THEN
                     #161219-00028#1---e
                        INSERT INTO xmdd_tmp(xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                          VALUES (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                                  g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                                  g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                         
                        LET g_rec_b = g_rec_b + 1
                     END IF  #161219-00028#1
                  END IF
               END IF
               DISPLAY BY NAME g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                               g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
               DISPLAY BY NAME g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
               DISPLAY BY NAME g_xmdd_d[l_ac].xmdd002_desc
               DISPLAY BY NAME g_xmdd_d[l_ac].xmdd004_desc
            END IF
            
            UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            LET g_xmdd_d_o.xmdddocno = g_xmdd_d[l_ac].xmdddocno
            
            
         AFTER FIELD xmddseq
            IF (NOT cl_null(g_xmdd_d[l_ac].xmddseq)) AND (g_xmdd_d[l_ac].xmddseq != g_xmdd_d_o.xmddseq OR cl_null(g_xmdd_d_o.xmddseq)) THEN
               #檢查是否重複
               IF g_xmdd_d[l_ac].xmdddocno IS NOT NULL  THEN 
                  
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xmdd_d[l_ac].xmdddocno
                  LET g_chkparam.arg2 = g_xmdd_d[l_ac].xmddseq
                  
                  LET g_chkparam.where = " xmdasite = '",g_site,"' "
                  LET g_errshow = TRUE                                                                                                #160328-00029#4
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_xmdcseq_1") THEN
                     LET g_xmdd_d[l_ac].xmddseq = g_xmdd_d_o.xmddseq
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET g_xmdd_d[l_ac].xmddseq1= ''
                  LET g_xmdd_d[l_ac].xmddseq2= ''
                  LET g_xmdd_d[l_ac].xmdd001 = ''
                  LET g_xmdd_d[l_ac].imaal003 = ''
                  LET g_xmdd_d[l_ac].imaal004= ''
                  LET g_xmdd_d[l_ac].xmdd002 = ''
                  LET g_xmdd_d[l_ac].xmdd002 = ''
                  LET g_xmdd_d[l_ac].xmdd011 = ''
                  LET g_xmdd_d[l_ac].xmdd006 = ''
                  LET g_xmdd_d[l_ac].xmdd004 = ''
                  LET g_xmdd_d[l_ac].xmdd004_desc = ''
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM xmdd_t WHERE xmddent = g_enterprise 
                     AND xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq
                  IF l_n = 1 THEN
                     SELECT xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004
                         INTO g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                              g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
                        FROM xmdd_t WHERE xmddent = g_enterprise 
                         AND xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq
                     CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001) RETURNING g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
                     
                     CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002) RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc
                  
                     CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc
                  
                     IF l_cmd = 'a' THEN 
                        #161219-00028#1---s
                        LET l_count = 1  
                        SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                         WHERE xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq 
	                        AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2
                        IF l_count = 0 THEN
                        #161219-00028#1---e
                           INSERT INTO xmdd_tmp(xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                             VALUES (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                                     g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                                     g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                            
                           LET g_rec_b = g_rec_b + 1
                        END IF  #161219-00028#1
                     END IF
                  
                  END IF
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                                  g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
                  DISPLAY BY NAME g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmdd002_desc
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmdd004_desc
               
               END IF
            END IF
            UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            LET g_xmdd_d_o.xmddseq = g_xmdd_d[l_ac].xmddseq

         AFTER FIELD xmddseq1
            IF (NOT cl_null(g_xmdd_d[l_ac].xmddseq1)) AND (g_xmdd_d[l_ac].xmddseq1 != g_xmdd_d_o.xmddseq1 OR cl_null(g_xmdd_d_o.xmddseq1)) THEN
               IF g_xmdd_d[l_ac].xmdddocno IS NOT NULL AND g_xmdd_d[l_ac].xmddseq IS NOT NULL THEN 
                  
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xmdd_d[l_ac].xmdddocno
                  LET g_chkparam.arg2 = g_xmdd_d[l_ac].xmddseq
                  LET g_chkparam.arg3 = g_xmdd_d[l_ac].xmddseq1
                  
                  LET g_chkparam.where = " xmdasite = '",g_site,"' "

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_xmddseq1") THEN
                     LET g_xmdd_d[l_ac].xmddseq1 = g_xmdd_d_o.xmddseq1
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET g_xmdd_d[l_ac].xmddseq2= ''
                  LET g_xmdd_d[l_ac].xmdd001 = ''
                  LET g_xmdd_d[l_ac].imaal003 = ''
                  LET g_xmdd_d[l_ac].imaal004= ''
                  LET g_xmdd_d[l_ac].xmdd002 = ''
                  LET g_xmdd_d[l_ac].xmdd002 = ''
                  LET g_xmdd_d[l_ac].xmdd011 = ''
                  LET g_xmdd_d[l_ac].xmdd006 = ''
                  LET g_xmdd_d[l_ac].xmdd004 = ''
                  LET g_xmdd_d[l_ac].xmdd004_desc = ''
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM xmdd_t WHERE xmddent = g_enterprise 
                     AND xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq
                     AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1
                  IF l_n = 1 THEN
                     SELECT xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004
                         INTO g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                              g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
                        FROM xmdd_t WHERE xmddent = g_enterprise 
                         AND xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq
                         AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 
                     CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001) RETURNING g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
                     
                     CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002) RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc
                  
                     CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc
                  
                     IF l_cmd = 'a' THEN 
                        #161219-00028#1---s
                        LET l_count = 1  
                        SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                         WHERE xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq 
	                        AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2
                        IF l_count = 0 THEN
                        #161219-00028#1---e
                           INSERT INTO xmdd_tmp(xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                             VALUES (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                                     g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                                     g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                            
                           LET g_rec_b = g_rec_b + 1
                        END IF  #161219-00028#1
                     END IF
                  END IF
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                                  g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
                  DISPLAY BY NAME g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmdd002_desc
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmdd004_desc
               
               END IF
            END IF
            UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            LET g_xmdd_d_o.xmddseq1 = g_xmdd_d[l_ac].xmddseq1
            
         AFTER FIELD xmddseq2
            IF (NOT cl_null(g_xmdd_d[l_ac].xmddseq2)) AND (g_xmdd_d[l_ac].xmddseq2 != g_xmdd_d_o.xmddseq2 OR cl_null(g_xmdd_d_o.xmddseq2)) THEN
               IF g_xmdd_d[l_ac].xmdddocno IS NOT NULL AND g_xmdd_d[l_ac].xmddseq IS NOT NULL AND g_xmdd_d[l_ac].xmddseq1 IS NOT NULL THEN 
                  
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xmdd_d[l_ac].xmdddocno
                  LET g_chkparam.arg2 = g_xmdd_d[l_ac].xmddseq
                  LET g_chkparam.arg3 = g_xmdd_d[l_ac].xmddseq1
                  LET g_chkparam.arg4 = g_xmdd_d[l_ac].xmddseq2
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_xmddseq2") THEN
                     LET g_xmdd_d[l_ac].xmddseq2 = g_xmdd_d_o.xmddseq2
                     NEXT FIELD CURRENT
                  END IF
                  
                  SELECT xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004
                      INTO g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                           g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
                     FROM xmdd_t WHERE xmddent = g_enterprise 
                      AND xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq
                      AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2 
                  
                  IF l_cmd = 'a' THEN 
                     #161219-00028#1---s
                     LET l_count = 1  
                     SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                      WHERE xmdddocno = g_xmdd_d[l_ac].xmdddocno AND xmddseq = g_xmdd_d[l_ac].xmddseq 
	                     AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1 AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2
                     IF l_count = 0 THEN
                     #161219-00028#1---e
                        INSERT INTO xmdd_tmp(xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                          VALUES (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                                  g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                                  g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                         
                        LET g_rec_b = g_rec_b + 1
                     END IF  #161219-00028#1
                  END IF
                 
                  CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001) RETURNING g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
                  
                  CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002) RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc
                  
                  CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc

                  DISPLAY BY NAME g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                                  g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
                  DISPLAY BY NAME g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmdd002_desc
                  DISPLAY BY NAME g_xmdd_d[l_ac].xmdd004_desc
               
               END IF
            END IF
            UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            LET g_xmdd_d_o.xmddseq2 = g_xmdd_d[l_ac].xmddseq2
            
         AFTER FIELD xmdd006
            IF NOT cl_ap_chk_range(g_xmdd_d[l_ac].xmdd006,"0.000","0","","","azz-00079",1) THEN
               LET g_xmdd_d[l_ac].xmdd006 = g_xmdd_d_o.xmdd006
               NEXT FIELD xmdd006
            END IF 
            LET g_xmdd_d_o.xmdd006 = g_xmdd_d[l_ac].xmdd006
            
         ON ACTION controlp INFIELD xmdddocno         
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdd_d[l_ac].xmdddocno            #給予default值
            LET g_qryparam.default2 = g_xmdd_d[l_ac].xmddseq
            LET g_qryparam.default3 = g_xmdd_d[l_ac].xmddseq1            #給予default值
            LET g_qryparam.default4 = g_xmdd_d[l_ac].xmddseq2
            
            LET g_qryparam.where = " xmddsite = '",g_site,"' AND (xmdd006-xmdd014) > 0 "
            CALL q_xmdddocno_5() 
            
            LET l_n = 0
            IF l_cmd = 'a' THEN   #161219-00028#1
               FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
                         WHEN "3"
                            LET l_str3 = bst.nextToken()
                         WHEN "4"
                            LET l_str4 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_xmdddocno = l_str1
                   LET l_xmddseq = l_str2
                   LET l_xmddseq1 = l_str3
                   LET l_xmddseq2 = l_str4
                   
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                    WHERE xmdddocno = l_xmdddocno AND xmddseq = l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                   IF l_count = 0 THEN
                      
                      SELECT xmda004,xmda002,xmda003 INTO l_xmda004,l_xmda002,l_xmda003
                         FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdddocno
                
                      SELECT xmdd001,xmdd002,xmdd004,xmdd011,xmdd006
                          INTO l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd011,l_xmdd006 FROM xmdd_t
                         WHERE xmddent = g_enterprise AND xmdddocno = l_xmdddocno AND xmddseq =  l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                      
                      IF cl_null(l_xmdd006) THEN
                         LET l_xmdd006 =  0
                      END IF
                      
                      INSERT INTO xmdd_tmp (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                         VALUES(l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd011,
                                l_xmdd006,l_xmdd004,l_xmda004,l_xmda002,l_xmda003)
                   END IF
                   
                   LET l_n = l_n + 1
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL

               IF l_n > 0 THEN
                  #161205-00025#1---s
                  #CALL apmt400_01_xmdd_fill()
                  #LET g_rec_b = g_xmdd_d.getLength()
                  #IF g_rec_b > 0 THEN
                  SELECT COUNT(1) INTO l_n FROM xmdd_tmp
                  IF l_n > 0 THEN
                  #161205-00025#1---e
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
            #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_xmdd_d[l_ac].xmdddocno = g_qryparam.return1
               LET g_xmdd_d[l_ac].xmddseq = g_qryparam.return2
               LET g_xmdd_d[l_ac].xmddseq1 = g_qryparam.return3
			      LET g_xmdd_d[l_ac].xmddseq2 = g_qryparam.return4
               DISPLAY g_xmdd_d[l_ac].xmdddocno TO xmdddocno              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq TO xmddseq              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq1 TO xmddseq1 
			      DISPLAY g_xmdd_d[l_ac].xmddseq2 TO xmddseq2
			      CALL apmt400_01_xmdd_ref()
			      UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            END IF 
            #161219-00028#1---e
           
         ON ACTION controlp INFIELD xmddseq         
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdd_d[l_ac].xmdddocno            #給予default值
            LET g_qryparam.default2 = g_xmdd_d[l_ac].xmddseq
            LET g_qryparam.default3 = g_xmdd_d[l_ac].xmddseq1            #給予default值
            LET g_qryparam.default4 = g_xmdd_d[l_ac].xmddseq2
            
            LET g_qryparam.where = " xmddsite = '",g_site,"' AND xmdddocno = '",g_xmdd_d[l_ac].xmdddocno,"' AND (xmdd006-xmdd014) > 0  "
            CALL q_xmdddocno_5() 
            
            LET l_n = 0
            IF l_cmd = 'a' THEN  #161219-00028#1
               FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
                         WHEN "3"
                            LET l_str3 = bst.nextToken()
                         WHEN "4"
                            LET l_str4 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_xmdddocno = l_str1
                   LET l_xmddseq = l_str2
                   LET l_xmddseq1 = l_str3
                   LET l_xmddseq2 = l_str4
                   
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                    WHERE xmdddocno = l_xmdddocno AND xmddseq = l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                   IF l_count = 0 THEN
                      
                      SELECT xmda004,xmda002,xmda003 INTO l_xmda004,l_xmda002,l_xmda003
                         FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdddocno
                
                      SELECT xmdd001,xmdd002,xmdd004,xmdd011,xmdd006
                          INTO l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd011,l_xmdd006 FROM xmdd_t
                         WHERE xmddent = g_enterprise AND xmdddocno = l_xmdddocno AND xmddseq =  l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                      
                      IF cl_null(l_xmdd006) THEN
                         LET l_xmdd006 =  0
                      END IF
                      
                      INSERT INTO xmdd_tmp (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                         VALUES(l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd011,
                                l_xmdd006,l_xmdd004,l_xmda004,l_xmda002,l_xmda003)
                   END IF
                   
                   LET l_n = l_n + 1
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL
               IF l_n > 0 THEN
                  #161205-00025#1---s
                  #CALL apmt400_01_xmdd_fill()
                  #LET g_rec_b = g_xmdd_d.getLength()
                  #IF g_rec_b > 0 THEN
                  SELECT COUNT(1) INTO l_n FROM xmdd_tmp
                  IF l_n > 0 THEN
                  #161205-00025#1---e
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
            #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_xmdd_d[l_ac].xmdddocno = g_qryparam.return1
               LET g_xmdd_d[l_ac].xmddseq = g_qryparam.return2
               LET g_xmdd_d[l_ac].xmddseq1 = g_qryparam.return3
			      LET g_xmdd_d[l_ac].xmddseq2 = g_qryparam.return4
               DISPLAY g_xmdd_d[l_ac].xmdddocno TO xmdddocno              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq TO xmddseq              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq1 TO xmddseq1 
			      DISPLAY g_xmdd_d[l_ac].xmddseq2 TO xmddseq2
			      CALL apmt400_01_xmdd_ref()
			      UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            END IF 
            #161219-00028#1---e
           
         ON ACTION controlp INFIELD xmddseq1       
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdd_d[l_ac].xmdddocno            #給予default值
            LET g_qryparam.default2 = g_xmdd_d[l_ac].xmddseq
            LET g_qryparam.default3 = g_xmdd_d[l_ac].xmddseq1            #給予default值
            LET g_qryparam.default4 = g_xmdd_d[l_ac].xmddseq2
            
            LET g_qryparam.where = " xmddsite = '",g_site,"' AND xmdddocno = '",g_xmdd_d[l_ac].xmdddocno,"' ",
                                   " AND xmddseq = '",g_xmdd_d[l_ac].xmddseq,"' AND (xmdd006-xmdd014) > 0 "
            CALL q_xmdddocno_5() 
            
            LET l_n = 0
            IF l_cmd = 'a' THEN  #161219-00028#1
               FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
                         WHEN "3"
                            LET l_str3 = bst.nextToken()
                         WHEN "4"
                            LET l_str4 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_xmdddocno = l_str1
                   LET l_xmddseq = l_str2
                   LET l_xmddseq1 = l_str3
                   LET l_xmddseq2 = l_str4
                   
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                    WHERE xmdddocno = l_xmdddocno AND xmddseq = l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                   IF l_count = 0 THEN
                      
                      SELECT xmda004,xmda002,xmda003 INTO l_xmda004,l_xmda002,l_xmda003
                         FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdddocno
                
                      SELECT xmdd001,xmdd002,xmdd004,xmdd011,xmdd006 
                          INTO l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd011,l_xmdd006 FROM xmdd_t
                         WHERE xmddent = g_enterprise AND xmdddocno = l_xmdddocno AND xmddseq =  l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                      
                      IF cl_null(l_xmdd006) THEN
                         LET l_xmdd006 =  0
                      END IF
                      INSERT INTO xmdd_tmp (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                         VALUES(l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd011,
                                l_xmdd006,l_xmdd004,l_xmda004,l_xmda002,l_xmda003)
                   END IF
                   
                   LET l_n = l_n + 1
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL
               IF l_n > 0 THEN
                  #161205-00025#1---s
                  #CALL apmt400_01_xmdd_fill()
                  #LET g_rec_b = g_xmdd_d.getLength()
                  #IF g_rec_b > 0 THEN
                  SELECT COUNT(1) INTO l_n FROM xmdd_tmp
                  IF l_n > 0 THEN
                  #161205-00025#1---e
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
            #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_xmdd_d[l_ac].xmdddocno = g_qryparam.return1
               LET g_xmdd_d[l_ac].xmddseq = g_qryparam.return2
               LET g_xmdd_d[l_ac].xmddseq1 = g_qryparam.return3
			      LET g_xmdd_d[l_ac].xmddseq2 = g_qryparam.return4
               DISPLAY g_xmdd_d[l_ac].xmdddocno TO xmdddocno              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq TO xmddseq              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq1 TO xmddseq1 
			      DISPLAY g_xmdd_d[l_ac].xmddseq2 TO xmddseq2
			      CALL apmt400_01_xmdd_ref()
			      UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            END IF 
            #161219-00028#1---e

         ON ACTION controlp INFIELD xmddseq2     
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.state = 'i'  #161219-00028#1
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            END IF
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdd_d[l_ac].xmdddocno            #給予default值
            LET g_qryparam.default2 = g_xmdd_d[l_ac].xmddseq
            LET g_qryparam.default3 = g_xmdd_d[l_ac].xmddseq1            #給予default值
            LET g_qryparam.default4 = g_xmdd_d[l_ac].xmddseq2
            
            LET g_qryparam.where = " xmddsite = '",g_site,"' AND xmdddocno = '",g_xmdd_d[l_ac].xmdddocno,"' ",
                                   " AND xmddseq = '",g_xmdd_d[l_ac].xmddseq,"' AND xmddseq1 = '",g_xmdd_d[l_ac].xmddseq1,"' ",
                                   " AND (xmdd006-xmdd014) > 0 "
            CALL q_xmdddocno_5() 
            
            LET l_n = 0
            IF l_cmd = 'a' THEN  #161219-00028#1
               FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
                         WHEN "3"
                            LET l_str3 = bst.nextToken()
                         WHEN "4"
                            LET l_str4 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_xmdddocno = l_str1
                   LET l_xmddseq = l_str2
                   LET l_xmddseq1 = l_str3
                   LET l_xmddseq2 = l_str4
                   
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM xmdd_tmp 
                    WHERE xmdddocno = l_xmdddocno AND xmddseq = l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                   IF l_count = 0 THEN
                      
                      SELECT xmda004,xmda002,xmda003 INTO l_xmda004,l_xmda002,l_xmda003
                         FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = l_xmdddocno
                
                      SELECT xmdd001,xmdd002,xmdd004,xmdd011,xmdd006
                          INTO l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd011,l_xmdd006 FROM xmdd_t
                         WHERE xmddent = g_enterprise AND xmdddocno = l_xmdddocno AND xmddseq =  l_xmddseq AND xmddseq1 = l_xmddseq1 AND xmddseq2 = l_xmddseq2
                      
                      IF cl_null(l_xmdd006) THEN
                         LET l_xmdd006 =  0
                      END IF
                      
                      INSERT INTO xmdd_tmp (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) 
                         VALUES(l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd011,
                                l_xmdd006,l_xmdd004,l_xmda004,l_xmda002,l_xmda003)
                   END IF
                   
                   LET l_n = l_n + 1
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL
               IF l_n > 0 THEN
                  #161205-00025#1---s
                  #CALL apmt400_01_xmdd_fill()
                  #LET g_rec_b = g_xmdd_d.getLength()
                  #IF g_rec_b > 0 THEN
                  SELECT COUNT(1) INTO l_n FROM xmdd_tmp
                  IF l_n > 0 THEN
                  #161205-00025#1---e
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
            #161219-00028#1---s
            #当前状态为修改时，当前栏位的资料需被开窗资料替换掉，做删除动作
            ELSE
               LET g_xmdd_d[l_ac].xmdddocno = g_qryparam.return1
               LET g_xmdd_d[l_ac].xmddseq = g_qryparam.return2
               LET g_xmdd_d[l_ac].xmddseq1 = g_qryparam.return3
			      LET g_xmdd_d[l_ac].xmddseq2 = g_qryparam.return4
               DISPLAY g_xmdd_d[l_ac].xmdddocno TO xmdddocno              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq TO xmddseq              #顯示到畫面上
               DISPLAY g_xmdd_d[l_ac].xmddseq1 TO xmddseq1 
			      DISPLAY g_xmdd_d[l_ac].xmddseq2 TO xmddseq2
			      CALL apmt400_01_xmdd_ref()
			      UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_o.xmdddocno AND xmddseq = g_xmdd_d_o.xmddseq
                  AND xmddseq1 = g_xmdd_d_o.xmddseq1 AND xmddseq2 = g_xmdd_d_o.xmddseq2
            END IF 
            #161219-00028#1---e
           
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xmdd_d[l_ac].* = g_xmdd_d_t.*
               CLOSE apmt400_01_xmdd_bcl
               EXIT DIALOG 
            END IF
            UPDATE xmdd_tmp SET (xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003) = 
                            (g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                             g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                             g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003)
                WHERE xmdddocno = g_xmdd_d_t.xmdddocno AND xmddseq = g_xmdd_d_t.xmddseq
                  AND xmddseq1 = g_xmdd_d_t.xmddseq1 AND xmddseq2 = g_xmdd_d_t.xmddseq2
            
         AFTER ROW
           CLOSE apmt400_01_xmdd_bcl
         
         AFTER INPUT
           
      END INPUT
      
      INPUT ARRAY g_pmdb_d FROM s_detail4.*
          ATTRIBUTE(COUNT = g_rec_b1,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt400_01_pmdb_tmp_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b1 != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b1 = g_pmdb_d.getLength()
           
         BEFORE ROW 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET g_detail_idx = l_ac1
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()

            LET g_rec_b1 = g_pmdb_d.getLength()
            
            IF g_rec_b1 >= l_ac1  AND g_pmdb_d[l_ac1].pmdb004 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_pmdb_d_t.* = g_pmdb_d[l_ac1].*  #BACKUP
               LET g_pmdb_d_o.* = g_pmdb_d[l_ac1].*  #BACKUP
               OPEN apmt400_01_pmdb_bcl USING g_pmdb_d[l_ac1].pmdb004,g_pmdb_d[l_ac1].pmdb005,g_pmdb_d[l_ac1].pmdb030,g_pmdb_d[l_ac1].pmdb007

               FETCH apmt400_01_pmdb_bcl INTO g_pmdb_d[l_ac1].pmdb004,g_pmdb_d[l_ac1].pmdb005,g_pmdb_d[l_ac1].pmdb030,g_pmdb_d[l_ac1].pmdb006,
                                              g_pmdb_d[l_ac1].pmdb007,g_pmdb_d[l_ac1].pmdb006_1,g_pmdb_d[l_ac1].pmdb007_1,
                                              g_pmdb_d[l_ac1].pmdb006_2,g_pmdb_d[l_ac1].stock,g_pmdb_d[l_ac1].safe,g_pmdb_d[l_ac1].inventory,
                                              g_pmdb_d[l_ac1].request,g_pmdb_d[l_ac1].purchase,g_pmdb_d[l_ac1].pick,g_pmdb_d[l_ac1].preparation
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_pmdb_d_t.pmdb004
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
                
               CALL cl_show_fld_cont()
            END IF

         AFTER FIELD pmdb006
            IF g_pmdb_d[l_ac1].pmdb006 <> g_pmdb_d_o.pmdb006 THEN
               IF NOT cl_ap_chk_range(g_pmdb_d[l_ac1].pmdb006,"0.000","1","","","azz-00079",1) THEN
                  LET g_pmdb_d[l_ac1].pmdb006 = g_pmdb_d_o.pmdb006
                  NEXT FIELD pmdb006
               END IF 
               UPDATE pmdb_tmp SET pmdb006 = g_pmdb_d[l_ac1].pmdb006 
                  WHERE pmdb004 = g_pmdb_d[l_ac1].pmdb004 AND pmdb005 = g_pmdb_d[l_ac1].pmdb005
                    AND pmdb030 = g_pmdb_d[l_ac1].pmdb030 AND pmdb007 = g_pmdb_d[l_ac1].pmdb007
            END IF
            #若產生來源為'依工單產生'或是'依訂單產生'時，當修改了本次請購量時需自動退算需求明細中各筆需求來源的本此請購量，
　          #依據需求日期越前面的越先分配請購量，分配的請購量不可以大於該需求明細的原始需求量
            #若本次總請購量大於需求明細的原始需求量加總的話，將分配剩餘的請購量分配到需求日期最前面的那一筆需求中
            IF g_choice MATCHES '[234]' THEN
               LET l_pmdb006 = g_pmdb_d[l_ac1].pmdb006
               DECLARE pmdb_tmp2_pmdb006 CURSOR FOR
                  SELECT pmdb001,pmdb002,pmdb003,pmdb052,pmdb006_1,pmdb030 FROM pmdb_tmp2
                     WHERE pmdb004 = g_pmdb_d[l_ac1].pmdb004 AND pmdb005 = g_pmdb_d[l_ac1].pmdb005 ORDER BY pmdb030
               LET l_pmdb030_t = ''
               LET l_pmdb001_t = ''
               LET l_pmdb002_t = ''
               LET l_pmdb003_t = ''
               LET l_pmdb052_t = ''
               
               FOREACH pmdb_tmp2_pmdb006 INTO l_pmdb001,l_pmdb002,l_pmdb003,l_pmdb052,l_pmdb006_1,l_pmdb030
                  IF l_pmdb006 >= l_pmdb006_1 THEN
                     UPDATE pmdb_tmp2 SET pmdb006_5 = l_pmdb006_1 ,
                                          pmdb006 = g_pmdb_d[l_ac1].pmdb006
                        WHERE pmdb001 = l_pmdb001 AND pmdb002 = l_pmdb002 AND pmdb003 = l_pmdb003 AND pmdb052 = l_pmdb052
                          AND pmdb004 = g_pmdb_d[l_ac1].pmdb004 AND pmdb005 = g_pmdb_d[l_ac1].pmdb005 AND pmdb030 = l_pmdb030
                     LET l_pmdb006 = l_pmdb006 - l_pmdb006_1
                  ELSE
                     UPDATE pmdb_tmp2 SET pmdb006_5 = l_pmdb006 ,
                                          pmdb006 = g_pmdb_d[l_ac1].pmdb006
                        WHERE pmdb001 = l_pmdb001 AND pmdb002 = l_pmdb002 AND pmdb003 = l_pmdb003 AND pmdb052 = l_pmdb052
                          AND pmdb004 = g_pmdb_d[l_ac1].pmdb004 AND pmdb005 = g_pmdb_d[l_ac1].pmdb005 AND pmdb030 = l_pmdb030
                     LET l_pmdb006 = 0
                  END IF
                  #取得最前的需求日期
                  IF l_pmdb030 < l_pmdb030_t OR cl_null(l_pmdb030_t) THEN
                     LET l_pmdb030_t = l_pmdb030
                     LET l_pmdb001_t = l_pmdb001
                     LET l_pmdb002_t = l_pmdb002
                     LET l_pmdb003_t = l_pmdb003
                     LET l_pmdb052_t = l_pmdb052
                  END IF   
               END FOREACH
               
               #若本次總請購量大於需求明細的原始需求量加總的話，將分配剩餘的請購量分配到需求日期最前面的那一筆需求中
               IF l_pmdb006 > 0 THEN
                  UPDATE pmdb_tmp2 SET pmdb006_5 = pmdb006_5 + l_pmdb006 
                     WHERE pmdb001 = l_pmdb001_t AND pmdb002 = l_pmdb002_t AND pmdb003 = l_pmdb003_t AND pmdb052 = l_pmdb052_t
                       AND pmdb004 = g_pmdb_d[l_ac1].pmdb004 AND pmdb005 = g_pmdb_d[l_ac1].pmdb005 AND pmdb030 = l_pmdb030_t
               END IF
            
            ELSE
               UPDATE pmdb_tmp2 SET pmdb006_5 = g_pmdb_d[l_ac1].pmdb006 ,
                                    pmdb006 = g_pmdb_d[l_ac1].pmdb006
                     WHERE pmdb004 = g_pmdb_d[l_ac1].pmdb004 AND pmdb005 = g_pmdb_d[l_ac1].pmdb005   
            END IF
            LET g_pmdb_d_o.pmdb006 = g_pmdb_d[l_ac1].pmdb006
            
         AFTER FIELD pmdb030_1
            IF g_pmdb_d[l_ac1].pmdb030 <> g_pmdb_d_o.pmdb030 OR cl_null(g_pmdb_d_o.pmdb030) THEN
               UPDATE pmdb_tmp SET pmdb030 = g_pmdb_d[l_ac1].pmdb030 
                  WHERE pmdb004 = g_pmdb_d[l_ac1].pmdb004 AND pmdb005 = g_pmdb_d[l_ac1].pmdb005
                    AND pmdb007 = g_pmdb_d[l_ac1].pmdb007 AND pmdb030 = g_pmdb_d_o.pmdb030
            END IF
            LET g_pmdb_d_o.pmdb030 = g_pmdb_d[l_ac1].pmdb030

         
         AFTER ROW
           CLOSE apmt400_01_pmdb_bcl
         
         AFTER INPUT
           
      END INPUT
      
      INPUT ARRAY g_pmdb2_d FROM s_detail5.*
          ATTRIBUTE(COUNT = g_rec_b2,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt400_01_pmdb_tmp2_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b2 != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b2 = g_pmdb_d.getLength()
           
         BEFORE ROW 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx = l_ac2
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()

            LET g_rec_b2 = g_pmdb2_d.getLength()
            
            IF g_rec_b2 >= l_ac2 AND g_pmdb2_d[l_ac2].keyno IS NOT NULL THEN
               LET l_cmd='u'
               LET g_pmdb2_d_t.* = g_pmdb2_d[l_ac1].*  #BACKUP
               LET g_pmdb2_d_o.* = g_pmdb2_d[l_ac1].*  #BACKUP
               OPEN apmt400_01_pmdb_bcl2 USING g_pmdb2_d[l_ac2].keyno

               FETCH apmt400_01_pmdb_bcl2 INTO g_pmdb2_d[l_ac2].keyno,g_pmdb2_d[l_ac2].pmdb004,g_pmdb2_d[l_ac2].pmdb005,g_pmdb2_d[l_ac2].pmdb006,
                                               g_pmdb2_d[l_ac2].pmdb001,g_pmdb2_d[l_ac2].pmdb002,g_pmdb2_d[l_ac2].pmdb003,g_pmdb2_d[l_ac2].pmdb052,
                                               g_pmdb2_d[l_ac2].pmdb030,g_pmdb2_d[l_ac2].pmdb006_1,g_pmdb2_d[l_ac2].pmdb006_5,g_pmdb2_d[l_ac2].pmdb007
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
                
               CALL cl_show_fld_cont()
            END IF

         AFTER FIELD pmdb006_5
            IF g_pmdb2_d[l_ac2].pmdb006_5 <> g_pmdb2_d_o.pmdb006_5 THEN
               IF NOT cl_ap_chk_range(g_pmdb2_d[l_ac2].pmdb006_5,"0.000","1","","","azz-00079",1) THEN
                  LET g_pmdb2_d[l_ac2].pmdb006_5 = g_pmdb2_d_o.pmdb006_5
                  NEXT FIELD pmdb006_5
               END IF 
               ##維護的本此請購數量後同一個料件+產品特徵的總量不可以不等於料件匯總上的總請購量
               #SELECT SUM(pmdb006) INTO l_pmdb006_1 FROM pmdb_tmp WHERE pmdb004 = g_pmdb2_d[l_ac2].pmdb004 AND pmdb005 = g_pmdb2_d[l_ac2].pmdb005
               #SELECT SUM(pmdb006_5) INTO l_pmdb006_5 FROM pmdb_tmp2 WHERE pmdb004 = g_pmdb2_d[l_ac2].pmdb004 AND pmdb005 = g_pmdb2_d[l_ac2].pmdb005
               #IF l_pmdb006_1 <> l_pmdb006_5 - g_pmdb2_d_o.pmdb006_5 + g_pmdb2_d[l_ac1].pmdb006_5 THEN
               #   INITIALIZE g_errparam TO NULL 
               #   LET g_errparam.extend = g_pmdb2_d[l_ac2].pmdb004 , " + ",g_pmdb2_d[l_ac2].pmdb005
               #   LET g_errparam.code   = ''
               #   LET g_errparam.popup  = TRUE 
               #   CALL cl_err()
               #   LET g_pmdb2_d[l_ac2].pmdb006_5 = g_pmdb2_d_o.pmdb006_5
               #   NEXT FIELD pmdb006_5
               #END IF
               UPDATE pmdb_tmp2 SET pmdb006_5 = g_pmdb2_d[l_ac1].pmdb006_5 WHERE keyno = g_pmdb2_d[l_ac1].keyno
               #更新料件+产品特征的总请购量
               UPDATE pmdb_tmp SET pmdb006 = pmdb006 - g_pmdb2_d_o.pmdb006_5 + g_pmdb2_d[l_ac1].pmdb006_5
                  WHERE pmdb004 = g_pmdb2_d[l_ac2].pmdb004 AND pmdb005 = g_pmdb2_d[l_ac2].pmdb005
            END IF
            LET g_pmdb2_d_o.pmdb006_5 = g_pmdb2_d[l_ac1].pmdb006_5
            
         AFTER ROW
           CLOSE apmt400_01_pmdb_bcl2
         
         AFTER INPUT
           
      END INPUT
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         CASE g_choice
            WHEN "1"
               NEXT FIELD bmaa001
            WHEN "2"
               NEXT FIELD sfaadocno
            WHEN "3"
               NEXT FIELD xmdddocno
            WHEN "4"
               NEXT FIELD xmdddocno
         END CASE
         
      ON ACTION gen_pmdb_draft
         #产生请购底稿
         CALL apmt400_01_gen_pmdb_draft()
      
      ON ACTION gen_pmdb
         #产生请购明细
         IF g_rec_b1 > 0 AND g_rec_b2 > 0 THEN
            LET g_success = TRUE
            IF NOT apmt400_01_gen_pmdb() THEN
               IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                  LET g_success = FALSE                 
                  RETURN
               END IF
            ELSE
               #160731-00042#1---s
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmdadocno
               IF l_n > 0 THEN
               #160731-00042#1---e
                  IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                     #清空單身欄位及臨時表中的值
                     LET l_ac = 0   #161205-00025#1
                     CALL g_bmaa_d.clear()        
                     CALL g_sfaa_d.clear() 
                     CALL g_xmdd_d.clear() 
                     CALL g_pmdb_d.clear() 
                     CALL g_pmdb2_d.clear()
                     LET tm.sfaa049 = ''
                     DELETE FROM bmaa_tmp
                     DELETE FROM sfaa_tmp
                     DELETE FROM xmdd_tmp
                     DELETE FROM pmdb_tmp
                     DELETE FROM pmdb_tmp2
                     #161205-00025#1---s
                     #CALL apmt400_01_input()        
                     CASE g_choice
                        WHEN "1"
                           NEXT FIELD bmaa001
                        WHEN "2"
                           NEXT FIELD sfaadocno
                        WHEN "3"
                           NEXT FIELD xmdddocno
                        WHEN "4"
                           NEXT FIELD xmdddocno
                     END CASE
                     #161205-00025#1----e
                  ELSE
                     LET INT_FLAG = TRUE 
                     EXIT DIALOG
                  END IF
               #160731-00042#1---s
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'apm-01123'  #未產生請購單身資料，請檢查底稿中的請購量是否大於0且料件的補給策略是否為“採購”等！
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
               #160731-00042#1---e
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00292'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      
      ON ACTION pmdb_collect
         CALL apmt400_01_pmdb_tmp_fill()
      
      ON ACTION pmdb_detail
         CALL apmt400_01_pmdb_tmp2_fill()
         
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
         
   END DIALOG
   
   IF INT_FLAG THEN
      RETURN
   END IF   
      
   IF g_flag THEN
      LET g_flag = FALSE   
      CALL apmt400_01_input()
   END IF

END FUNCTION

#BOM單身資料填充
PRIVATE FUNCTION apmt400_01_bmaa_fill()

    CALL g_bmaa_d.clear()
    LET g_sql = "SELECT bmaa001,bmaa002, ",
                "       t1.imaal003,t2.imaal004,t3.imaa009 ",  #161205-00025#1
                "  FROM bmaa_tmp ",
                #161205-00025#1---s
                "   LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=bmaa001 AND t1.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=bmaa001 AND t2.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN imaa_t t3 ON t3.imaaent="||g_enterprise||" AND t3.imaa001=bmaa001  "
                #161205-00025#1---e

    LET g_sql = cl_sql_add_mask(g_sql)
    PREPARE apmt400_01_bmaa_pb FROM g_sql
    DECLARE apmt400_01_bmaa_cs CURSOR FOR apmt400_01_bmaa_pb
         
    LET g_cnt = l_ac
    LET l_ac = 1
    FOREACH apmt400_01_bmaa_cs INTO g_bmaa_d[l_ac].bmaa001,g_bmaa_d[l_ac].bmaa002,
                                    g_bmaa_d[l_ac].imaal003,g_bmaa_d[l_ac].imaal004,g_bmaa_d[l_ac].imaa009  #161205-00025#1
       #CALL apmt400_01_bmaa001_ref()  #161205-00025#1
       IF l_ac > g_max_rec THEN
          IF g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = l_ac
             LET g_errparam.code   = 9035 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
          END IF
          EXIT FOREACH
       END IF
         
       LET l_ac = l_ac + 1
    END FOREACH
    
    #161205-00025#1-S
    LET l_ac = l_ac - 1
    IF l_ac >= g_cnt THEN
       LET l_ac = g_cnt
    END IF
    IF l_ac = 0 THEN
       LET l_ac = 1
    END IF
    #161205-00025#1-E
    
    CALL g_bmaa_d.deleteElement(g_bmaa_d.getLength())
    #LET l_ac = g_cnt   #161205-00025#1
    #LET g_cnt = 0      #161205-00025#1
    
    FREE apmt400_01_bmaa_pb
END FUNCTION

#建立臨時表
PUBLIC FUNCTION apmt400_01_create_tmp()
   CREATE TEMP TABLE bmaa_tmp(
   bmaa001   VARCHAR(40),
   bmaa002   VARCHAR(30)
   );

   CREATE TEMP TABLE sfaa_tmp(
   sfaadocno VARCHAR(20),
   sfbaseq   DECIMAL(10,0),
   sfbaseq1  DECIMAL(10,0),
   sfaa010   VARCHAR(40),
   sfaa019   DATE,
   sfaa020   DATE,
   sfaa012   DECIMAL(20,6),
   sfaa002   VARCHAR(20),
   sfba006   VARCHAR(40),
   sfba021   VARCHAR(256),   #161230-00034#1 add
   sfba013   DECIMAL(20,6),
   sfba014   VARCHAR(10)
   );
       
   CREATE TEMP TABLE xmdd_tmp(
   xmdddocno    VARCHAR(20),
   xmddseq      DECIMAL(10,0),
   xmddseq1     DECIMAL(10,0),
   xmddseq2     DECIMAL(10,0),
   xmdd001      VARCHAR(40),
   xmdd002      VARCHAR(256),
   xmdd011      DATE,
   xmdd006      DECIMAL(20,6),
   xmdd004      VARCHAR(10),
   xmda004      VARCHAR(10),
   xmda002      VARCHAR(20),
   xmda003      VARCHAR(10)
   );
       
   CREATE TEMP TABLE pmdb_tmp(
   pmdb004      VARCHAR(40),
   pmdb005      VARCHAR(256),
   pmdb030      DATE,
   pmdb006      DECIMAL(20,6),
   pmdb007      VARCHAR(10),
   pmdb006_1    DECIMAL(20,6),
   pmdb007_1    VARCHAR(10),
   pmdb006_2    DECIMAL(20,6),
   stock        DECIMAL(20,6),
   safe         DECIMAL(20,6), 
   inventory    DECIMAL(20,6),
   request      DECIMAL(20,6),
   purchase     DECIMAL(20,6),
   pick         DECIMAL(20,6),
   preparation  DECIMAL(20,6)
   );
   
   CREATE TEMP TABLE pmdb_tmp2(
   keyno        DECIMAL(10,0),
   pmdb004      VARCHAR(40),
   pmdb005      VARCHAR(256),
   pmdb006      DECIMAL(20,6),
   pmdb001      VARCHAR(20),
   pmdb002      DECIMAL(10,0),
   pmdb003      DECIMAL(10,0),
   pmdb052      DECIMAL(10,0),
   pmdb030      DATE,
   pmdb006_1    DECIMAL(20,6),
   pmdb006_5    DECIMAL(20,6),
   pmdb007      VARCHAR(10)
   );
   
END FUNCTION
#根據主件編號帶出其他欄位
PRIVATE FUNCTION apmt400_01_bmaa001_ref()
    CALL s_desc_get_item_desc(g_bmaa_d[l_ac].bmaa001) RETURNING g_bmaa_d[l_ac].imaal003,g_bmaa_d[l_ac].imaal004
    DISPLAY BY NAME g_bmaa_d[l_ac].imaal003,g_bmaa_d[l_ac].imaal004
    
    SELECT imaa009 INTO g_bmaa_d[l_ac].imaa009 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_bmaa_d[l_ac].bmaa001
    #CALL s_desc_get_rtaxl003_desc(g_bmaa_d[l_ac].imaa009) RETURNING g_bmaa_d[l_ac].imaa009_desc
    DISPLAY BY NAME g_bmaa_d[l_ac].imaa009#,g_bmaa_d[l_ac].imaa009_desc
    
END FUNCTION

#删除临时表
PUBLIC FUNCTION apmt400_01_drop_tmp()

   DROP TABLE bmaa_tmp
   DROP TABLE sfaa_tmp
   DROP TABLE xmdd_tmp
   DROP TABLE pmdb_tmp
   DROP TABLE pmdb_tmp2
   
END FUNCTION

#产生请购底稿
PRIVATE FUNCTION apmt400_01_gen_pmdb_draft()
#161124-00048#9 mod-S
#DEFINE l_pmdb           RECORD LIKE pmdb_t.* 
DEFINE l_pmdb RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企业编号
       pmdbsite LIKE pmdb_t.pmdbsite, #营运据点
       pmdbdocno LIKE pmdb_t.pmdbdocno, #请购单号
       pmdbseq LIKE pmdb_t.pmdbseq, #项次
       pmdb001 LIKE pmdb_t.pmdb001, #来源单号
       pmdb002 LIKE pmdb_t.pmdb002, #来源项次
       pmdb003 LIKE pmdb_t.pmdb003, #来源项序
       pmdb004 LIKE pmdb_t.pmdb004, #料件编号
       pmdb005 LIKE pmdb_t.pmdb005, #产品特征
       pmdb006 LIKE pmdb_t.pmdb006, #需求数量
       pmdb007 LIKE pmdb_t.pmdb007, #单位
       pmdb008 LIKE pmdb_t.pmdb008, #参考数量
       pmdb009 LIKE pmdb_t.pmdb009, #参考单位
       pmdb010 LIKE pmdb_t.pmdb010, #计价数量
       pmdb011 LIKE pmdb_t.pmdb011, #计价单位
       pmdb012 LIKE pmdb_t.pmdb012, #包装容器
       pmdb014 LIKE pmdb_t.pmdb014, #供应商选择
       pmdb015 LIKE pmdb_t.pmdb015, #供应商编号
       pmdb016 LIKE pmdb_t.pmdb016, #付款条件
       pmdb017 LIKE pmdb_t.pmdb017, #交易条件
       pmdb018 LIKE pmdb_t.pmdb018, #税率
       pmdb019 LIKE pmdb_t.pmdb019, #参考单价
       pmdb020 LIKE pmdb_t.pmdb020, #参考税前金额
       pmdb021 LIKE pmdb_t.pmdb021, #参考含税金额
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由码
       pmdb032 LIKE pmdb_t.pmdb032, #行状态
       pmdb033 LIKE pmdb_t.pmdb033, #紧急度
       pmdb034 LIKE pmdb_t.pmdb034, #项目编号
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活动编号
       pmdb037 LIKE pmdb_t.pmdb037, #收货据点
       pmdb038 LIKE pmdb_t.pmdb038, #收货库位
       pmdb039 LIKE pmdb_t.pmdb039, #收货储位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允许部份交货
       pmdb042 LIKE pmdb_t.pmdb042, #允许提前交货
       pmdb043 LIKE pmdb_t.pmdb043, #保税
       pmdb044 LIKE pmdb_t.pmdb044, #纳入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期冻结否
       pmdb046 LIKE pmdb_t.pmdb046, #费用部门
       pmdb048 LIKE pmdb_t.pmdb048, #收货时段
       pmdb049 LIKE pmdb_t.pmdb049, #已转采购量
       pmdb050 LIKE pmdb_t.pmdb050, #备注
       pmdb051 LIKE pmdb_t.pmdb051, #结案/留置理由码
       pmdb200 LIKE pmdb_t.pmdb200, #商品条码
       pmdb201 LIKE pmdb_t.pmdb201, #包装单位
       pmdb202 LIKE pmdb_t.pmdb202, #件装数
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送仓库
       pmdb205 LIKE pmdb_t.pmdb205, #采购中心
       pmdb206 LIKE pmdb_t.pmdb206, #采购员
       pmdb207 LIKE pmdb_t.pmdb207, #采购方式
       pmdb208 LIKE pmdb_t.pmdb208, #经营方式
       pmdb209 LIKE pmdb_t.pmdb209, #结算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促销开始日
       pmdb211 LIKE pmdb_t.pmdb211, #促销结束日
       pmdb212 LIKE pmdb_t.pmdb212, #要货件数
       pmdb250 LIKE pmdb_t.pmdb250, #合理库存
       pmdb251 LIKE pmdb_t.pmdb251, #最高库存
       pmdb252 LIKE pmdb_t.pmdb252, #现有库存
       pmdb253 LIKE pmdb_t.pmdb253, #入库在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一周销量
       pmdb255 LIKE pmdb_t.pmdb255, #前二周销量
       pmdb256 LIKE pmdb_t.pmdb256, #前三周销量
       pmdb257 LIKE pmdb_t.pmdb257, #前四周销量
       pmdb258 LIKE pmdb_t.pmdb258, #要货在途量
       pmdb259 LIKE pmdb_t.pmdb259, #周平均销量
       pmdb900 LIKE pmdb_t.pmdb900, #保留字段str
       pmdb999 LIKE pmdb_t.pmdb999, #保留字段end
       pmdb260 LIKE pmdb_t.pmdb260, #收货部门
       pmdb052 LIKE pmdb_t.pmdb052, #来源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #补货规格说明
       pmdb053 LIKE pmdb_t.pmdb053, #预算细项
       pmdb213 LIKE pmdb_t.pmdb213, #参考进价
       pmdb054 LIKE pmdb_t.pmdb054, #库存管理特征
       pmdb214 LIKE pmdb_t.pmdb214 #需求时间
END RECORD
#161124-00048#9 mod-S
DEFINE l_bmaa002   LIKE bmaa_t.bmaa002
DEFINE l_sql       STRING
DEFINE l_i         LIKE type_t.num5
DEFINE l_imaf013   LIKE imaf_t.imaf013
DEFINE l_bmaa004   LIKE bmaa_t.bmaa004
DEFINE l_pmdb007   LIKE pmdb_t.pmdb007
DEFINE l_bmba010   LIKE bmba_t.bmba010
DEFINE l_success   LIKE type_t.num5
DEFINE l_pmdb004_t LIKE pmdb_t.pmdb004
DEFINE l_pmdb005_t LIKE pmdb_t.pmdb005
DEFINE l_pmdb006_sum  LIKE pmdb_t.pmdb006
DEFINE l_sfba014   LIKE sfba_t.sfba014
DEFINE l_sfba013   LIKE sfba_t.sfba013
DEFINE l_pmdb006_1 LIKE pmdb_t.pmdb006
DEFINE l_xmdd006   LIKE xmdd_t.xmdd006
DEFINE l_pmdb030   LIKE pmdb_t.pmdb030   #161102-00065#1 add
DEFINE l_xmdd040   LIKE xmdd_t.xmdd040   #161215-00034#1  add
DEFINE l_feature   LIKE xmdd_t.xmdd002   #170321-00089#1 add

   
  #IF g_choice = '1' THEN     #161212-00034#1 mark
      IF cl_null(tm.pmdb030) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01102'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN
      END IF
   
   IF g_choice = '1' THEN     #161212-00034#1 add
      IF cl_null(tm.sfaa049) OR tm.sfaa049 <= 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01103'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN
      END IF
   END IF
   
   CASE g_choice
       WHEN '1' LET g_rec_b = g_bmaa_d.getLength()
       WHEN '2' LET g_rec_b = g_sfaa_d.getLength()
       WHEN '3' LET g_rec_b = g_xmdd_d.getLength()
       WHEN '4' LET g_rec_b = g_xmdd_d.getLength()
    END CASE  
    IF g_rec_b = 0 THEN
       RETURN
    END IF

   DELETE FROM pmdb_tmp
   DELETE FROM pmdb_tmp2
   
    CASE g_choice
       WHEN '1' LET l_sql = " SELECT DISTINCT '','','','','',bmaa001,'','',bmaa002,'' FROM bmaa_tmp ORDER BY bmaa001 "
       #WHEN '2' LET l_sql = " SELECT sfaadocno,sfbaseq,sfbaseq1,'',sfaa019,sfba006,'',SUM(sfba013),'',sfba014 FROM sfaa_tmp WHERE sfba013 > 0 GROUP BY sfaadocno,sfbaseq,sfbaseq1,sfaa019,sfba006,sfba014 ORDER BY sfba006 "  #161230-00034#1
       WHEN '2' LET l_sql = " SELECT sfaadocno,sfbaseq,sfbaseq1,'',sfaa019,sfba006,sfba021,SUM(sfba013),'',sfba014 FROM sfaa_tmp WHERE sfba013 > 0 GROUP BY sfaadocno,sfbaseq,sfbaseq1,sfaa019,sfba006,sfba021,sfba014 ORDER BY sfba006 "  #161230-00034#1
       WHEN '3' LET l_sql = " SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd011,xmdd001,xmdd002,SUM(xmdd006),'',xmdd004 FROM xmdd_tmp WHERE xmdd006 > 0 GROUP BY xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd004 ORDER BY xmdd001,xmdd002 "
       WHEN '4' LET l_sql = " SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd011,xmdd001,xmdd002,SUM(xmdd006),'',xmdd004 FROM xmdd_tmp WHERE xmdd006 > 0 GROUP BY xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd004 ORDER BY xmdd001,xmdd002 "
    END CASE 
    
    PREPARE apmt400_01_pmdb_tmp_pb FROM l_sql
    DECLARE apmt400_01_pmdb_tmp_cs CURSOR FOR apmt400_01_pmdb_tmp_pb
    
    INITIALIZE l_pmdb.* TO NULL
    
    LET l_pmdb004_t = ''
    LET l_pmdb005_t = ''
   #LET l_pmdb.pmdb030 = tm.pmdb030      #161102-00065#1 add #161125-00008#1 mark
       
    CALL cl_err_collect_init() 
    
    FOREACH apmt400_01_pmdb_tmp_cs INTO l_pmdb.pmdb001,l_pmdb.pmdb002,l_pmdb.pmdb003,l_pmdb.pmdb052,
                                       #l_pmdb.pmdb030,l_pmdb.pmdb004,l_pmdb.pmdb005,l_sfba013,l_bmaa002,l_sfba014  #161102-00065#1 mark
                                        l_pmdb030,l_pmdb.pmdb004,l_pmdb.pmdb005,l_sfba013,l_bmaa002,l_sfba014       #161102-00065#1 add
       
       #產品特徵
       IF cl_null(l_pmdb.pmdb005) THEN
          LET l_pmdb.pmdb005 = ' '
       END IF
       
       #161102-00065#1 add  --begin--
       LET l_pmdb.pmdb030 = tm.pmdb030    #161125-00008#1 add
       IF cl_null(l_pmdb.pmdb030) THEN
          LET l_pmdb.pmdb030 = l_pmdb030
       END IF
       #161102-00065#1 add  --end--
       
       #更新需求明细临时表中料件总请购量栏位,以料号和产品特征汇总
       IF NOT cl_null(l_pmdb.pmdb004) AND (NOT cl_null(l_pmdb004_t)) AND (l_pmdb.pmdb005 IS NOT NULL) AND (l_pmdb005_t IS NOT NULL) THEN
          IF l_pmdb004_t <> l_pmdb.pmdb004 OR l_pmdb005_t <> l_pmdb.pmdb005 THEN
             SELECT SUM(pmdb006_5) INTO l_pmdb006_sum FROM pmdb_tmp2 WHERE pmdb004 = l_pmdb004_t AND pmdb005 = l_pmdb005_t
             UPDATE pmdb_tmp2 SET pmdb006 = l_pmdb006_sum WHERE pmdb004 = l_pmdb004_t AND pmdb005 = l_pmdb005_t
          END IF
       END IF
       
       LET l_pmdb004_t = l_pmdb.pmdb004
       LET l_pmdb005_t = l_pmdb.pmdb005
       
       #依BOM时，先抓生产单位
       IF g_choice = '1' THEN
          SELECT bmaa004 INTO l_bmaa004 FROM bmaa_t 
            WHERE bmaaent = g_enterprise AND bmaasite = g_site AND bmaa001 = l_pmdb.pmdb004 AND bmaa002 = l_bmaa002
       END IF
       #採購單位
       IF cl_null(l_pmdb.pmdb007) THEN
          SELECT imaf143 INTO l_pmdb.pmdb007 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004
       END IF
       #基礎單位
       IF cl_null(l_pmdb.pmdb007) THEN
          SELECT imaa006 INTO l_pmdb.pmdb007 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_pmdb.pmdb004
       END IF
       
       IF cl_null(l_pmdb.pmdb007) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-01105'
          LET g_errparam.extend = l_pmdb.pmdb004
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CONTINUE FOREACH
       END IF          
      
       #依BOM
       IF g_choice = '1' THEN
          #展至尾階
          IF tm.b = 'Y' THEN
             IF cl_null(l_bmaa002) THEN
                LET l_bmaa002 = ' '
             END IF
             #160512-00016#23---s
             #CALL s_asft300_02_bom(0,l_pmdb.pmdb004,l_bmaa002,l_pmdb.pmdb007,1,1,'','Y','','','N') RETURNING g_bmba
             CALL s_asft300_02_bom(0,l_pmdb.pmdb004,l_bmaa002,l_pmdb.pmdb007,1,1,'','Y','','','N','N') RETURNING g_bmba
             #160512-00016#23---e
             #IF g_bmba.getLength() > 1 THEN   #160816-00064#1
             IF g_bmba.getLength() > 0 THEN    #160816-00064#1
                FOR l_i = 1 TO g_bmba.getLength()
                    LET l_pmdb.pmdb004 = g_bmba[l_i].bmba003     #元件料號  
                    LET l_pmdb.pmdb005 = g_bmba[l_i].l_inam002   #元件对应特征
                    
                    #取出的元件的補給策略(imaf013)須為'1:採購'的才需要產生到請購明細
                    CALL apmt400_01_get_imaf013(l_pmdb.pmdb004) RETURNING l_imaf013
                    IF l_imaf013 <> '1' OR cl_null(l_imaf013) THEN
                       CONTINUE FOR
                    END IF
                    
                    #g_bmba[l_i].l_bmba011         #QPA 分子，对应于原始的主件料号
                    #g_bmba[l_i].l_bmba012         #QPA 分母，对应于原始的主件料号
                    LET l_pmdb.pmdb006 = g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012 * tm.sfaa049
                    
                    #採購單位
                    SELECT imaf143 INTO l_pmdb.pmdb007 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004
                    
                    #基礎單位
                    IF cl_null(l_pmdb.pmdb007) THEN
                       SELECT imaa006 INTO l_pmdb.pmdb007 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_pmdb.pmdb004
                    END IF
       
                    #取得發料單位
                    SELECT bmba010 INTO l_bmba010 FROM bmba_t
                       WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = g_bmba[l_i].bmba001 AND bmba002 = g_bmba[l_i].bmba002
                         AND bmba003 = g_bmba[l_i].bmba003 AND bmba004 = g_bmba[l_i].bmba004 AND bmba005 = g_bmba[l_i].bmba005
                         AND bmba007 = g_bmba[l_i].bmba007 AND bmba008 = g_bmba[l_i].bmba008
                    #160720-00011#1--s
                    #IF l_bmba010 <> l_bmaa004 AND (NOT cl_null(l_bmba010)) AND (NOT cl_null(l_bmaa004)) THEN
                    #   CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmba010,l_bmaa004,l_pmdb.pmdb006)
                    #      RETURNING l_success,l_pmdb.pmdb006
                    #END IF
                    #IF l_bmaa004 <> l_pmdb.pmdb007 AND (NOT cl_null(l_bmaa004)) THEN
                    #    CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmaa004,l_pmdb.pmdb007,l_pmdb.pmdb006)
                    #      RETURNING l_success,l_pmdb.pmdb006
                    #END IF
                    IF l_bmba010 <> l_pmdb.pmdb007 AND (NOT cl_null(l_bmba010)) AND (NOT cl_null(l_pmdb.pmdb007)) THEN
                       CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmba010,l_pmdb.pmdb007,l_pmdb.pmdb006)
                          RETURNING l_success,l_pmdb.pmdb006
                    END IF
                    #160720-00011#1--e--
                    
                    #IF l_pmdb.pmdb006 <> 0 THEN                    
                       CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,0)
                    #END IF
                    
                END FOR
             ELSE
                #取出的元件的補給策略(imaf013)須為'1:採購'的才需要產生到請購明細
                CALL apmt400_01_get_imaf013(l_pmdb.pmdb004) RETURNING l_imaf013
                IF l_imaf013 <> '1' OR cl_null(l_imaf013) THEN
                   CONTINUE FOREACH
                END IF
                LET l_pmdb.pmdb006 = tm.sfaa049
                #IF l_pmdb.pmdb006 <> 0 THEN
                   CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,0)
                #END IF
             END IF
          ELSE
             IF cl_null(l_bmaa002) THEN
                LET l_bmaa002 = ' '
             END IF
             #160512-00016#23---s
             #CALL s_asft300_02_bom(0,l_pmdb.pmdb004,l_bmaa002,l_pmdb.pmdb007,1,1,'','S','','','N') RETURNING g_bmba
             CALL s_asft300_02_bom(0,l_pmdb.pmdb004,l_bmaa002,l_pmdb.pmdb007,1,1,'','S','','','N','N') RETURNING g_bmba
             #160512-00016#23---e
             #IF g_bmba.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理  #160816-00064#1
             IF g_bmba.getLength() > 0 THEN    #160816-00064#1         
                FOR l_i = 1 TO g_bmba.getLength()
                    LET l_pmdb.pmdb004 = g_bmba[l_i].bmba003     #元件料號  
                    LET l_pmdb.pmdb005 = g_bmba[l_i].l_inam002   #元件对应特征
                    
                    #g_bmba[l_i].l_bmba011         #QPA 分子，对应于原始的主件料号
                    #g_bmba[l_i].l_bmba012         #QPA 分母，对应于原始的主件料号
                    #取出的元件的補給策略(imaf013)須為'1:採購'的才需要產生到請購明細
                    CALL apmt400_01_get_imaf013(l_pmdb.pmdb004) RETURNING l_imaf013
                    IF l_imaf013 <> '1' OR cl_null(l_imaf013) THEN
                       CONTINUE FOR
                    END IF
                    
                    LET l_pmdb.pmdb006 = g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012 * tm.sfaa049
                    
                    #採購單位
                    SELECT imaf143 INTO l_pmdb.pmdb007 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004
                    
                    #基礎單位
                    IF cl_null(l_pmdb.pmdb007) THEN
                       SELECT imaa006 INTO l_pmdb.pmdb007 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_pmdb.pmdb004
                    END IF
       
                    #取得發料單位
                    SELECT bmba010 INTO l_bmba010 FROM bmba_t
                       WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = g_bmba[l_i].bmba001 AND bmba002 = g_bmba[l_i].bmba002
                         AND bmba003 = g_bmba[l_i].bmba003 AND bmba004 = g_bmba[l_i].bmba004 AND bmba005 = g_bmba[l_i].bmba005
                         AND bmba007 = g_bmba[l_i].bmba007 AND bmba008 = g_bmba[l_i].bmba008
                    #160720-00011#1--s
                    #IF l_bmba010 <> l_bmaa004 AND (NOT cl_null(l_bmba010)) AND (NOT cl_null(l_bmaa004)) THEN
                    #   CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmba010,l_bmaa004,l_pmdb.pmdb006)
                    #      RETURNING l_success,l_pmdb.pmdb006
                    #END IF
                    #IF l_bmaa004 <> l_pmdb.pmdb007 AND (NOT cl_null(l_bmaa004)) THEN
                    #    CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmaa004,l_pmdb.pmdb007,l_pmdb.pmdb006)
                    #      RETURNING l_success,l_pmdb.pmdb006
                    #END IF
                    IF l_bmba010 <> l_pmdb.pmdb007 AND (NOT cl_null(l_bmba010)) AND (NOT cl_null(l_pmdb.pmdb007)) THEN
                       CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmba010,l_pmdb.pmdb007,l_pmdb.pmdb006)
                          RETURNING l_success,l_pmdb.pmdb006
                    END IF
                    #160720-00011#1--e--
                    #IF l_pmdb.pmdb006 <> 0 THEN       
                       CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,0)
                    #END IF
                END FOR
             ELSE
                #取出的元件的補給策略(imaf013)須為'1:採購'的才需要產生到請購明細
                CALL apmt400_01_get_imaf013(l_pmdb.pmdb004) RETURNING l_imaf013
                IF l_imaf013 <> '1' OR cl_null(l_imaf013) THEN
                   CONTINUE FOREACH
                END IF
                LET l_pmdb.pmdb006 = tm.sfaa049
                #IF l_pmdb.pmdb006 <> 0 THEN
                   CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,0)
                #END IF
             END IF
          END IF
       END IF
       
       #依工單
       IF g_choice = '2' THEN
          #本次請購數量，轉換成請購單位對應的數量
          #160708-00015#1--s
          #補給策略(imaf013)須為'1:採購'的才需要產生到請購明細
          CALL apmt400_01_get_imaf013(l_pmdb.pmdb004) RETURNING l_imaf013
          IF l_imaf013 <> '1' OR cl_null(l_imaf013) THEN
             CONTINUE FOREACH
          END IF
          #160708-00015#1--e
          LET l_pmdb.pmdb006 = l_sfba013
          IF l_sfba014 <> l_pmdb.pmdb007 AND (NOT cl_null(l_sfba014)) THEN
              CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_sfba014,l_pmdb.pmdb007,l_sfba013)
                RETURNING l_success,l_pmdb.pmdb006
              
              #原始需求數量轉換成請購單位對應的數量              
              CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_sfba014,l_pmdb.pmdb007,l_sfba013)
                RETURNING l_success,l_sfba013 
          END IF
          #IF l_pmdb.pmdb006 <> 0 THEN
             CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,l_sfba013)
          #END IF
              
       END IF
       
       #依訂單
       IF g_choice = '3' THEN
          #原始需求數量= 訂單數量-已出貨數量-已轉請購量
          SELECT xmdd006-xmdd014 INTO l_xmdd006 FROM xmdd_t
             WHERE xmddent = g_enterprise AND xmdddocno = l_pmdb.pmdb001 AND xmddseq =  l_pmdb.pmdb002 
               AND xmddseq1 = l_pmdb.pmdb003 AND xmddseq2 = l_pmdb.pmdb052
                   
          IF cl_null(l_xmdd006) THEN
             LET l_xmdd006 =  0
          END IF
          
          #該訂單的已轉請購量
          SELECT SUM(pmdb006) INTO l_pmdb006_1 FROM pmdb_t,pmda_t 
             WHERE pmdbent = pmdaent AND pmdbdocno = pmdadocno AND pmdastus <> 'X'
               AND pmdbent = g_enterprise AND pmdb001 = l_pmdb.pmdb001 AND pmdb002 = l_pmdb.pmdb002 
               AND pmdb003 = l_pmdb.pmdb003 AND pmdb052 = l_pmdb.pmdb052
               
          IF cl_null(l_pmdb006_1) THEN
             LET l_pmdb006_1 = 0
          END IF
          LET l_sfba013 = l_xmdd006 - l_pmdb006_1
          
          LET l_pmdb.pmdb006 = l_sfba013
          IF l_sfba014 <> l_pmdb.pmdb007 AND (NOT cl_null(l_sfba014)) THEN
              CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_sfba014,l_pmdb.pmdb007,l_sfba013)
                RETURNING l_success,l_pmdb.pmdb006
              
              #原始需求數量轉換成請購單位對應的數量              
              LET l_sfba013 = l_pmdb.pmdb006
          END IF
          #IF l_pmdb.pmdb006 <> 0 THEN
             CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,l_sfba013)
          #END IF
          
       END IF
       
       #依訂單展BOM時,展至尾階
       IF g_choice = '4' THEN
          #原始需求數量= 訂單數量-已出貨數量-已轉請購量
          #170321-00089#1 mod add xmdd002 to l_feature
          SELECT xmdd006-xmdd014,xmdd040,xmdd002 INTO l_xmdd006,l_xmdd040,l_feature FROM xmdd_t    #161215-00034#1 add xmdd040
             WHERE xmddent = g_enterprise AND xmdddocno = l_pmdb.pmdb001 AND xmddseq =  l_pmdb.pmdb002 
               AND xmddseq1 = l_pmdb.pmdb003 AND xmddseq2 = l_pmdb.pmdb052
                   
          IF cl_null(l_xmdd006) THEN
             LET l_xmdd006 =  0
          END IF
          
          #161215-00034#1  add   --begin--
          IF cl_null(l_xmdd040) THEN
             LET l_xmdd040 = ' '
          END IF
          #161215-00034#1  add   --end--
          
          #160512-00016#23---s
          #CALL s_asft300_02_bom(0,l_pmdb.pmdb004,' ',l_pmdb.pmdb007,1,1,'','Y','','','N') RETURNING g_bmba
         #CALL s_asft300_02_bom(0,l_pmdb.pmdb004,' ',l_pmdb.pmdb007,1,1,'','Y','','','N','N') RETURNING g_bmba        #161215-00034#1  mark
          #CALL s_asft300_02_bom(0,l_pmdb.pmdb004,l_xmdd040,l_pmdb.pmdb007,1,1,'','Y','','','N','N') RETURNING g_bmba  #161215-00034#1  add  #170321-00089#1 mark
          CALL s_asft300_02_bom(0,l_pmdb.pmdb004,l_xmdd040,l_pmdb.pmdb007,1,1,'','Y','',l_feature,'N','N') RETURNING g_bmba #170321-00089#1 add          
          #160512-00016#23---e
          #IF g_bmba.getLength() > 1 THEN   #160816-00064#1
          IF g_bmba.getLength() > 0 THEN    #160816-00064#1    
             FOR l_i = 1 TO g_bmba.getLength()
                 LET l_pmdb.pmdb004 = g_bmba[l_i].bmba003     #元件料號  
                 LET l_pmdb.pmdb005 = g_bmba[l_i].l_inam002   #元件对应特征
                 
                 #取出的元件的補給策略(imaf013)須為'1:採購'的才需要產生到請購明細
                 CALL apmt400_01_get_imaf013(l_pmdb.pmdb004) RETURNING l_imaf013
                 IF l_imaf013 <> '1' OR cl_null(l_imaf013) THEN
                    CONTINUE FOR
                 END IF
                 
                 #該訂單的已轉請購量
                 SELECT SUM(pmdb006) INTO l_pmdb006_1 FROM pmdb_t,pmda_t 
                    WHERE pmdbent = pmdaent AND pmdbdocno = pmdadocno AND pmdastus <> 'X'
                      AND pmdbent = g_enterprise AND pmdb001 = l_pmdb.pmdb001 AND pmdb002 = l_pmdb.pmdb002 
                      AND pmdb003 = l_pmdb.pmdb003 AND pmdb052 = l_pmdb.pmdb052 AND pmdb004 = l_pmdb.pmdb004
                      AND (CASE WHEN pmdb005 IS NULL THEN ' ' ELSE pmdb005 END) = l_pmdb.pmdb005
                      
                 IF cl_null(l_pmdb006_1) THEN
                    LET l_pmdb006_1 = 0
                 END IF
                 LET l_sfba013 = l_xmdd006 - l_pmdb006_1
                 
                 #g_bmba[l_i].l_bmba011         #QPA 分子，对应于原始的主件料号
                 #g_bmba[l_i].l_bmba012         #QPA 分母，对应于原始的主件料号
                 LET l_pmdb.pmdb006 = g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012 * l_sfba013
                 
                 #採購單位
                 SELECT imaf143 INTO l_pmdb.pmdb007 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004
                 
                 #基礎單位
                 IF cl_null(l_pmdb.pmdb007) THEN
                    SELECT imaa006 INTO l_pmdb.pmdb007 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_pmdb.pmdb004
                 END IF
       
                 #取得發料單位
                 SELECT bmba010 INTO l_bmba010 FROM bmba_t
                    WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = g_bmba[l_i].bmba001 AND bmba002 = g_bmba[l_i].bmba002
                      AND bmba003 = g_bmba[l_i].bmba003 AND bmba004 = g_bmba[l_i].bmba004 AND bmba005 = g_bmba[l_i].bmba005
                      AND bmba007 = g_bmba[l_i].bmba007 AND bmba008 = g_bmba[l_i].bmba008
                 #160720-00011#1--s
                 #IF l_bmba010 <> l_sfba014 AND (NOT cl_null(l_bmba010)) AND (NOT cl_null(l_sfba014)) THEN
                 #   CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmba010,l_bmaa004,l_pmdb.pmdb006)
                 #      RETURNING l_success,l_pmdb.pmdb006
                 #END IF
                 #IF l_sfba014 <> l_pmdb.pmdb007 AND (NOT cl_null(l_sfba014)) THEN
                 #    CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmaa004,l_pmdb.pmdb007,l_pmdb.pmdb006)
                 #      RETURNING l_success,l_pmdb.pmdb006
                 #END IF
                 IF l_bmba010 <> l_pmdb.pmdb007 AND (NOT cl_null(l_bmba010)) AND (NOT cl_null(l_pmdb.pmdb007)) THEN
                    CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_bmba010,l_pmdb.pmdb007,l_pmdb.pmdb006)
                       RETURNING l_success,l_pmdb.pmdb006
                 END IF
                 #160720-00011#1--e
                 LET l_sfba013 = l_pmdb.pmdb006
                 #IF l_pmdb.pmdb006 <> 0 THEN                    
                    CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,l_sfba013)
                 #END IF
                 
             END FOR
          ELSE
             #取出的元件的補給策略(imaf013)須為'1:採購'的才需要產生到請購明細
             CALL apmt400_01_get_imaf013(l_pmdb.pmdb004) RETURNING l_imaf013
             IF l_imaf013 <> '1' OR cl_null(l_imaf013) THEN
                CONTINUE FOREACH
             END IF
             
             #該訂單的已轉請購量
             SELECT SUM(pmdb006) INTO l_pmdb006_1 FROM pmdb_t,pmda_t 
                WHERE pmdbent = pmdaent AND pmdbdocno = pmdadocno AND pmdastus <> 'X'
                  AND pmdbent = g_enterprise AND pmdb001 = l_pmdb.pmdb001 AND pmdb002 = l_pmdb.pmdb002 
                  AND pmdb003 = l_pmdb.pmdb003 AND pmdb052 = l_pmdb.pmdb052 
                  
             IF cl_null(l_pmdb006_1) THEN
                LET l_pmdb006_1 = 0
             END IF
             LET l_sfba013 = l_xmdd006 - l_pmdb006_1
                 
             LET l_pmdb.pmdb006 = l_sfba013
             
             IF l_sfba014 <> l_pmdb.pmdb007 AND (NOT cl_null(l_sfba014)) THEN
                CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_sfba014,l_pmdb.pmdb007,l_sfba013)
                  RETURNING l_success,l_pmdb.pmdb006
                
                #原始需求數量轉換成請購單位對應的數量              
                LET l_sfba013 = l_pmdb.pmdb006
            END IF
            #IF l_pmdb.pmdb006 <> 0 THEN
                CALL apmt400_01_insert_pmdb_tmp2(l_pmdb.*,l_sfba013)
             #END IF
          END IF
       END IF
       
       INITIALIZE l_pmdb.* TO NULL
       
    END FOREACH
    
    CALL apmt400_01_insert_pmdb_tmp()
    
    CALL cl_err_collect_show()
    
    CALL apmt400_01_pmdb_tmp_fill()
    CALL apmt400_01_pmdb_tmp2_fill()
    LET g_rec_b1 = g_pmdb_d.getLength()
    LET g_rec_b2 = g_pmdb2_d.getLength()
    
       
END FUNCTION

#写入底稿临时表中
PRIVATE FUNCTION apmt400_01_insert_pmdb_tmp2(p_pmdb,p_pmdb006)
#161124-00048#9 mod-S
#DEFINE p_pmdb           RECORD LIKE pmdb_t.* 
DEFINE p_pmdb RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企业编号
       pmdbsite LIKE pmdb_t.pmdbsite, #营运据点
       pmdbdocno LIKE pmdb_t.pmdbdocno, #请购单号
       pmdbseq LIKE pmdb_t.pmdbseq, #项次
       pmdb001 LIKE pmdb_t.pmdb001, #来源单号
       pmdb002 LIKE pmdb_t.pmdb002, #来源项次
       pmdb003 LIKE pmdb_t.pmdb003, #来源项序
       pmdb004 LIKE pmdb_t.pmdb004, #料件编号
       pmdb005 LIKE pmdb_t.pmdb005, #产品特征
       pmdb006 LIKE pmdb_t.pmdb006, #需求数量
       pmdb007 LIKE pmdb_t.pmdb007, #单位
       pmdb008 LIKE pmdb_t.pmdb008, #参考数量
       pmdb009 LIKE pmdb_t.pmdb009, #参考单位
       pmdb010 LIKE pmdb_t.pmdb010, #计价数量
       pmdb011 LIKE pmdb_t.pmdb011, #计价单位
       pmdb012 LIKE pmdb_t.pmdb012, #包装容器
       pmdb014 LIKE pmdb_t.pmdb014, #供应商选择
       pmdb015 LIKE pmdb_t.pmdb015, #供应商编号
       pmdb016 LIKE pmdb_t.pmdb016, #付款条件
       pmdb017 LIKE pmdb_t.pmdb017, #交易条件
       pmdb018 LIKE pmdb_t.pmdb018, #税率
       pmdb019 LIKE pmdb_t.pmdb019, #参考单价
       pmdb020 LIKE pmdb_t.pmdb020, #参考税前金额
       pmdb021 LIKE pmdb_t.pmdb021, #参考含税金额
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由码
       pmdb032 LIKE pmdb_t.pmdb032, #行状态
       pmdb033 LIKE pmdb_t.pmdb033, #紧急度
       pmdb034 LIKE pmdb_t.pmdb034, #项目编号
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活动编号
       pmdb037 LIKE pmdb_t.pmdb037, #收货据点
       pmdb038 LIKE pmdb_t.pmdb038, #收货库位
       pmdb039 LIKE pmdb_t.pmdb039, #收货储位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允许部份交货
       pmdb042 LIKE pmdb_t.pmdb042, #允许提前交货
       pmdb043 LIKE pmdb_t.pmdb043, #保税
       pmdb044 LIKE pmdb_t.pmdb044, #纳入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期冻结否
       pmdb046 LIKE pmdb_t.pmdb046, #费用部门
       pmdb048 LIKE pmdb_t.pmdb048, #收货时段
       pmdb049 LIKE pmdb_t.pmdb049, #已转采购量
       pmdb050 LIKE pmdb_t.pmdb050, #备注
       pmdb051 LIKE pmdb_t.pmdb051, #结案/留置理由码
       pmdb200 LIKE pmdb_t.pmdb200, #商品条码
       pmdb201 LIKE pmdb_t.pmdb201, #包装单位
       pmdb202 LIKE pmdb_t.pmdb202, #件装数
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送仓库
       pmdb205 LIKE pmdb_t.pmdb205, #采购中心
       pmdb206 LIKE pmdb_t.pmdb206, #采购员
       pmdb207 LIKE pmdb_t.pmdb207, #采购方式
       pmdb208 LIKE pmdb_t.pmdb208, #经营方式
       pmdb209 LIKE pmdb_t.pmdb209, #结算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促销开始日
       pmdb211 LIKE pmdb_t.pmdb211, #促销结束日
       pmdb212 LIKE pmdb_t.pmdb212, #要货件数
       pmdb250 LIKE pmdb_t.pmdb250, #合理库存
       pmdb251 LIKE pmdb_t.pmdb251, #最高库存
       pmdb252 LIKE pmdb_t.pmdb252, #现有库存
       pmdb253 LIKE pmdb_t.pmdb253, #入库在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一周销量
       pmdb255 LIKE pmdb_t.pmdb255, #前二周销量
       pmdb256 LIKE pmdb_t.pmdb256, #前三周销量
       pmdb257 LIKE pmdb_t.pmdb257, #前四周销量
       pmdb258 LIKE pmdb_t.pmdb258, #要货在途量
       pmdb259 LIKE pmdb_t.pmdb259, #周平均销量
       pmdb900 LIKE pmdb_t.pmdb900, #保留字段str
       pmdb999 LIKE pmdb_t.pmdb999, #保留字段end
       pmdb260 LIKE pmdb_t.pmdb260, #收货部门
       pmdb052 LIKE pmdb_t.pmdb052, #来源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #补货规格说明
       pmdb053 LIKE pmdb_t.pmdb053, #预算细项
       pmdb213 LIKE pmdb_t.pmdb213, #参考进价
       pmdb054 LIKE pmdb_t.pmdb054, #库存管理特征
       pmdb214 LIKE pmdb_t.pmdb214 #需求时间
END RECORD
#161124-00048#9 mod-S
DEFINE p_pmdb006   LIKE type_t.num5
DEFINE l_keyno     LIKE type_t.num10
DEFINE l_pmdb006   LIKE type_t.num5

   IF cl_null(p_pmdb.pmdb005) THEN
      LET p_pmdb.pmdb005 = ' '
   END IF
      
   SELECT MAX(keyno)+1 INTO l_keyno FROM pmdb_tmp2
   IF l_keyno = 0 OR cl_null(l_keyno) THEN
      LET l_keyno = 1
   END IF
   
   LET l_pmdb006 = p_pmdb006
   
   IF g_choice = '1' THEN
      LET p_pmdb.pmdb001 = ''
      LET p_pmdb.pmdb002 = ''
      LET p_pmdb.pmdb003 = ''
      LET p_pmdb.pmdb052 = ''
      LET l_pmdb006 = p_pmdb.pmdb006 #原始需求量
   END IF
   
   IF g_choice = '2' THEN
      LET p_pmdb.pmdb052 = 0
   END IF
   
   IF cl_null(p_pmdb.pmdb030) THEN
      LET p_pmdb.pmdb030 =  tm.pmdb030
   END IF
   
   #产生需求明细单身
   INSERT INTO pmdb_tmp2(keyno,pmdb004,pmdb005,pmdb006,pmdb001,pmdb002,pmdb003,pmdb052,pmdb030,pmdb006_1,pmdb006_5,pmdb007)
      VALUES (l_keyno,p_pmdb.pmdb004,p_pmdb.pmdb005,p_pmdb.pmdb006,p_pmdb.pmdb001,p_pmdb.pmdb002,p_pmdb.pmdb003,p_pmdb.pmdb052,p_pmdb.pmdb030,l_pmdb006,p_pmdb.pmdb006,p_pmdb.pmdb007)
   
END FUNCTION

#单身底稿资料填充
PRIVATE FUNCTION apmt400_01_pmdb_tmp2_fill()
DEFINE l_success  LIKE type_t.num5

    CALL g_pmdb2_d.clear()
    LET g_sql = "SELECT keyno,pmdb004,pmdb005,pmdb006,pmdb001,pmdb002,pmdb003,pmdb052,pmdb030,pmdb006_1,pmdb006_5,pmdb007, ",
                "       t1.imaal003,t2.imaal004,t3.inaml004,t4.oocal003 ",  #161205-00025#1
                "   FROM pmdb_tmp2 ",
    #161205-00025#1---s
                "   LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=pmdb004 AND t1.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdb004 AND t2.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN inaml_t t3 ON t3.inamlent="||g_enterprise||" AND t3.inaml001=pmdb004 AND t3.inaml002=pmdb005 AND t3.inaml003='"||g_dlang||"' ",
                "   LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=pmdb007 AND t4.oocal002='"||g_dlang||"' ",
    #161205-00025#1---e            
                "  ORDER BY pmdb004,pmdb005 "
    LET g_sql = cl_sql_add_mask(g_sql)
    PREPARE apmt400_01_pmdb_pb2 FROM g_sql
    DECLARE apmt400_01_pmdb_cs2 CURSOR FOR apmt400_01_pmdb_pb2
         
    LET g_cnt = l_ac
    LET l_ac = 1
    FOREACH apmt400_01_pmdb_cs2 INTO g_pmdb2_d[l_ac].keyno,g_pmdb2_d[l_ac].pmdb004,g_pmdb2_d[l_ac].pmdb005,g_pmdb2_d[l_ac].pmdb006,
                                     g_pmdb2_d[l_ac].pmdb001,g_pmdb2_d[l_ac].pmdb002,g_pmdb2_d[l_ac].pmdb003,g_pmdb2_d[l_ac].pmdb052,
                                     g_pmdb2_d[l_ac].pmdb030,g_pmdb2_d[l_ac].pmdb006_1,g_pmdb2_d[l_ac].pmdb006_5,g_pmdb2_d[l_ac].pmdb007,
                                     #161205-00025#1---s
                                     g_pmdb2_d[l_ac].imaal003,g_pmdb2_d[l_ac].imaal004,
                                     g_pmdb2_d[l_ac].pmdb005_desc,g_pmdb2_d[l_ac].pmdb007_desc
                                     #161205-00025#1---e
       #161205-00025#1---s
       #CALL s_desc_get_item_desc(g_pmdb2_d[l_ac].pmdb004) RETURNING g_pmdb2_d[l_ac].imaal003,g_pmdb2_d[l_ac].imaal004
       #DISPLAY BY NAME g_pmdb2_d[l_ac].imaal003,g_pmdb2_d[l_ac].imaal004
       #CALL s_feature_description(g_pmdb2_d[l_ac].pmdb004,g_pmdb2_d[l_ac].pmdb005) RETURNING l_success,g_pmdb2_d[l_ac].pmdb005_desc
       #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb005_desc
       #CALL s_desc_get_unit_desc(g_pmdb2_d[l_ac].pmdb007) RETURNING g_pmdb2_d[l_ac].pmdb007_desc
       #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb007_desc
       #161205-00025#1---e
       
       IF l_ac > g_max_rec THEN
          IF g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = l_ac
             LET g_errparam.code   = 9035 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
          END IF
          EXIT FOREACH
       END IF
         
       LET l_ac = l_ac + 1
    END FOREACH
    
    CALL g_pmdb2_d.deleteElement(g_pmdb2_d.getLength())
    LET l_ac = g_cnt
    LET g_cnt = 0  
    
END FUNCTION

#補給策略(imaf013)
PRIVATE FUNCTION apmt400_01_get_imaf013(p_imaf001)
DEFINE p_imaf001    LIKE imaf_t.imaf001
DEFINE r_imaf013    LIKE imaf_t.imaf013

    LET r_imaf013 = ''
    SELECT imaf013 INTO r_imaf013 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_imaf001
    RETURN r_imaf013
   
END FUNCTION

#写入料件汇总单身
PRIVATE FUNCTION apmt400_01_insert_pmdb_tmp()
DEFINE l_sql          STRING
DEFINE l_pmdb004      LIKE pmdb_t.pmdb004
DEFINE l_pmdb005      LIKE pmdb_t.pmdb005
DEFINE l_inventory    LIKE pmdb_t.pmdb006   #库存可用量
DEFINE l_pick         LIKE pmdb_t.pmdb006   #在验量
DEFINE l_stock        LIKE pmdb_t.pmdb006   #已备料量
DEFINE l_request      LIKE pmdb_t.pmdb006   #请购量
DEFINE l_preparation  LIKE pmdb_t.pmdb006   #在制量
DEFINE l_purchase     LIKE pmdb_t.pmdb006   #在采量
DEFINE l_safe         LIKE pmdb_t.pmdb006   #库存安全量
DEFINE l_inag007      LIKE inag_t.inag007
DEFINE l_imaf053      LIKE imaf_t.imaf053
DEFINE l_inag008      LIKE inag_t.inag008
DEFINE l_success      LIKE type_t.num5
DEFINE l_pmdb006      LIKE pmdb_t.pmdb006
DEFINE l_pmdb007      LIKE pmdb_t.pmdb007
DEFINE l_pmdb006_1    LIKE pmdb_t.pmdb006
DEFINE l_pmdb006_2    LIKE pmdb_t.pmdb006
DEFINE l_pmdb006_3    LIKE pmdb_t.pmdb006
DEFINE l_pmdb007_1    LIKE pmdb_t.pmdb007
DEFINE l_pmdb030      LIKE pmdb_t.pmdb030

    DELETE FROM pmdb_tmp
    
    #將相同料件與產品特徵的需求數量加總寫入需求數量欄位
    LET l_sql = "SELECT pmdb004,pmdb005,SUM(pmdb006),pmdb030 FROM pmdb_tmp2 GROUP BY pmdb004,pmdb005,pmdb030 "
    PREPARE apmt400_01_ins_tmp_pb FROM l_sql
    DECLARE apmt400_01_ins_tmp_cs CURSOR FOR apmt400_01_ins_tmp_pb
    
    #161205-00025#1---s
    LET l_sql = " SELECT inag007,SUM(inag008) FROM inag_t ",
                "  WHERE inagent = ",g_enterprise," AND inagsite = '",g_site,"' AND inag001 = ? AND inag002 = ? AND inag010 = 'Y' ",
                "   GROUP BY inag007 "
    PREPARE inag_pb FROM l_sql
    DECLARE inag_cs CURSOR FOR inag_pb   

    #DECLARE pmdb_cs CURSOR FOR
    LET l_sql = " SELECT pmdb007,SUM(pmdb006 - (CASE WHEN pmdb049 IS NULL THEN 0 ELSE pmdb049 END) ) FROM pmdb_t,pmda_t ",
                "   WHERE pmdaent = pmdbent AND pmdadocno = pmdbdocno AND pmdastus = 'Y'  ",
                "     AND pmdbent = ",g_enterprise," AND pmdbsite = '",g_site,"' AND pmdb004 = ? ", 
                "     AND (CASE WHEN pmdb005 IS NULL THEN ' ' ELSE pmdb005 END) = ? ",
                "   GROUP BY pmdb007 "
    PREPARE pmdb_pb FROM l_sql
    DECLARE pmdb_cs CURSOR FOR pmdb_pb    

    LET l_sql = " SELECT pmdo004,SUM(pmdo006 - (CASE WHEN pmdo015 IS NULL THEN 0 ELSE pmdo015 END) ) FROM pmdo_t,pmdl_t,pmdn_t  ",
                "   WHERE pmdoent = pmdlent AND pmdodocno = pmdldocno AND pmdlstus = 'Y' AND pmdl005 NOT IN ('2','5','6')",  #一般採購
                "     AND pmdoent = pmdnent AND pmdodocno = pmdndocno AND pmdoseq = pmdnseq AND pmdn045 NOT IN ('2','3','4') AND pmdo021 NOT IN ('5') ", #161212-00015#1 add 
                "     AND pmdoent = ",g_enterprise," AND pmdosite = '",g_site,"' AND pmdo001 = ? ", 
                "     AND (CASE WHEN pmdo002 IS NULL THEN ' ' ELSE pmdo002 END) = ? ", 
                "   GROUP BY pmdo004 "
    PREPARE pmdo_pb FROM l_sql
    DECLARE pmdo_cs CURSOR FOR pmdo_pb 

    LET l_sql = " SELECT pmdt019,SUM(pmdt053 - (CASE WHEN pmdt054 IS NULL THEN 0 ELSE pmdt054 END) ) FROM pmdt_t,pmds_t ",
                "   WHERE pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdsstus = 'Y' AND (pmds000 = '1' OR pmds000 = '2' OR pmds000 = '3' OR pmds000 = '4') ",
                "     AND pmdtent = ",g_enterprise," AND pmdtsite = '",g_site,"' AND pmdt006 = ? ", 
                "     AND (CASE WHEN pmdt007 IS NULL THEN ' ' ELSE pmdt007 END) = ? ",
                "   GROUP BY pmdt019 "
    PREPARE pmdt_pb FROM l_sql
    DECLARE pmdt_cs CURSOR FOR pmdt_pb 
    
    LET l_sql = " SELECT sfac004,SUM(sfac003 - (CASE WHEN sfac005 IS NULL THEN 0 ELSE sfac005 END) ) FROM sfac_t,sfaa_t ",
                "   WHERE sfaaent = sfacent AND sfaadocno = sfacdocno AND (sfaastus = 'Y' OR sfaastus = 'F') ",
                "     AND sfacent = ",g_enterprise," AND sfacsite = '",g_site,"' AND sfac001 = ? ",
                "     AND (CASE WHEN sfac006 IS NULL THEN ' ' ELSE sfac006 END) = ? ",
                "   GROUP BY sfac004   "
    PREPARE sfac_pb FROM l_sql
    DECLARE sfac_cs CURSOR FOR sfac_pb 
    
    LET l_sql = " SELECT sfba014,SUM(sfba013 - (CASE WHEN sfba016 IS NULL THEN 0 ELSE sfba016 END) - (CASE WHEN sfba015 IS NULL THEN 0 ELSE sfba015 END) + (CASE WHEN sfba017 IS NULL THEN 0 ELSE sfba017 END)) FROM sfba_t,sfaa_t ",
                "   WHERE sfaaent = sfbaent AND sfaadocno = sfbadocno AND sfaa003 <> '4' ",
                "     AND (sfaastus != 'X' AND sfaastus != 'M' AND sfaastus != 'C') ",
                "     AND sfbaent = ",g_enterprise," AND sfbasite = '",g_site,"' AND sfba006 = ? ", 
                "     AND (CASE WHEN sfba021 IS NULL THEN ' ' ELSE sfba021 END) = ? ",
                " GROUP BY sfba014 "
    PREPARE sfba_pb FROM l_sql
    DECLARE sfba_cs CURSOR FOR sfba_cs             
    #161205-00025#1---e
    
    FOREACH apmt400_01_ins_tmp_cs INTO l_pmdb004,l_pmdb005,l_pmdb006,l_pmdb030
       #依據畫面的供需內容區塊勾選的項目抓取該料的各項供需量寫入匯總資料對應的欄位，沒有勾選的項目給0  
       LET l_inventory = 0     
       LET l_pick = 0          
       LET l_stock = 0         
       LET l_request = 0       
       LET l_preparation = 0   
       LET l_purchase = 0      
       LET l_safe = 0          
       
       #請購單位等於料件主檔設置的採購單位
       LET l_pmdb007 = ''
       SELECT imaf143 INTO l_pmdb007 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb004

       #庫存可用量:抓取庫存量(inag008)且庫存可用(inag010='Y')，需考慮inag的庫存單位與料件設置的庫存單位的換算率
       #庫存單位
       SELECT imaf053 INTO l_imaf053 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb004
       IF tm.inventory = 'Y' THEN
          #161205-00025#1--s
          #DECLARE inag_cs CURSOR FOR
          #   SELECT inag007,SUM(inag008) FROM inag_t
          #     WHERE inagent = g_enterprise AND inagsite = g_site AND inag001 = l_pmdb004 AND inag002 = l_pmdb005 AND inag010 = 'Y'
          #   GROUP BY inag007
          #FOREACH inag_cs INTO l_inag007,l_inag008
          FOREACH inag_cs USING l_pmdb004,l_pmdb005 INTO l_inag007,l_inag008
          #161205-00025#1--e
             IF l_imaf053 <> l_inag007 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_inag007)) THEN
                CALL s_aooi250_convert_qty(l_pmdb004,l_inag007,l_imaf053,l_inag008)
                    RETURNING l_success,l_inag008
             END IF
             LET l_inventory = l_inventory + l_inag008
          END FOREACH
       END IF
       #請購量:抓取已經確認未結案的請購單的未轉採購量(請購量(pmdb006)-已轉採購量(pmdb049))，需考慮請購單位與料件設置的庫存單位的換算率
       IF tm.request = 'Y' THEN
          #161205-00025#1--s
          #DECLARE pmdb_cs CURSOR FOR
          #   SELECT pmdb007,SUM(pmdb006 - (CASE WHEN pmdb049 IS NULL THEN 0 ELSE pmdb049 END) ) FROM pmdb_t,pmda_t
          #     WHERE pmdaent = pmdbent AND pmdadocno = pmdbdocno AND pmdastus = 'Y'
          #       AND pmdbent = g_enterprise AND pmdbsite = g_site AND pmdb004 = l_pmdb004 
          #       AND (CASE WHEN pmdb005 IS NULL THEN ' ' ELSE pmdb005 END) = l_pmdb005
          #     GROUP BY pmdb007
          #FOREACH pmdb_cs INTO l_pmdb007_1,l_pmdb006_1
          FOREACH pmdb_cs USING l_pmdb004,l_pmdb005 INTO l_pmdb007_1,l_pmdb006_1
          #161205-00025#1--e
             IF l_imaf053 <> l_pmdb007_1 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_pmdb007_1)) THEN
                CALL s_aooi250_convert_qty(l_pmdb004,l_pmdb007_1,l_imaf053,l_pmdb006_1)
                    RETURNING l_success,l_pmdb006_1
             END IF
             LET l_request = l_request + l_pmdb006_1
          END FOREACH
       END IF
       
       #在採量:抓取已經確認未結案的採購單未收貨量(採購量(pmdo006) - 已收貨量(pmdo015))，需考慮採購單位與料件設置的庫存單位的換算率
       IF tm.purchase = 'Y' THEN
          #161205-00025#1--s
          #DECLARE pmdo_cs CURSOR FOR
          #   SELECT pmdo004,SUM(pmdo006 - (CASE WHEN pmdo015 IS NULL THEN 0 ELSE pmdo015 END) ) FROM pmdo_t,pmdl_t,pmdn_t   #161212-00015#1 add pmdn_t
          #     WHERE pmdoent = pmdlent AND pmdodocno = pmdldocno AND pmdlstus = 'Y' AND pmdl005 NOT IN ('2','5','6')  #一般採購
          #       AND pmdoent = pmdnent AND pmdodocno = pmdndocno AND pmdoseq = pmdnseq AND pmdn045 NOT IN ('2','3','4') AND pmdo021 NOT IN ('5')  #161212-00015#1 add 
          #       AND pmdoent = g_enterprise AND pmdosite = g_site AND pmdo001 = l_pmdb004 
          #       AND (CASE WHEN pmdo002 IS NULL THEN ' ' ELSE pmdo002 END) = l_pmdb005 
          #     GROUP BY pmdo004   
          #FOREACH pmdo_cs INTO l_pmdb007_1,l_pmdb006_1
          FOREACH pmdo_cs USING l_pmdb004,l_pmdb005 INTO l_pmdb007_1,l_pmdb006_1
          #161205-00025#1--e
             IF l_imaf053 <> l_pmdb007_1 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_pmdb007_1)) THEN
                CALL s_aooi250_convert_qty(l_pmdb004,l_pmdb007_1,l_imaf053,l_pmdb006_1)
                    RETURNING l_success,l_pmdb006_1
             END IF
             LET l_purchase = l_purchase + l_pmdb006_1
          END FOREACH
       END IF
       
       #在驗量:抓取已經確認的收貨單未入庫量(允收數量(pmdt053)-已入庫量(pmdt054))，需考慮收貨單位與料件設置的庫存單位的換算率
       IF tm.pick = 'Y' THEN
          #161205-00025#1--s
          #DECLARE pmdt_cs CURSOR FOR
          #   SELECT pmdt019,SUM(pmdt053 - (CASE WHEN pmdt054 IS NULL THEN 0 ELSE pmdt054 END) ) FROM pmdt_t,pmds_t
          #     WHERE pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdsstus = 'Y' AND pmds000 IN ('1','2','3','4')
          #       AND pmdtent = g_enterprise AND pmdtsite = g_site AND pmdt006 = l_pmdb004 
          #       AND (CASE WHEN pmdt007 IS NULL THEN ' ' ELSE pmdt007 END) = l_pmdb005
          #     GROUP BY pmdt019   
          #FOREACH pmdt_cs INTO l_pmdb007_1,l_pmdb006_1
          FOREACH pmdt_cs USING l_pmdb004,l_pmdb005 INTO l_pmdb007_1,l_pmdb006_1
          #161205-00025#1--e
             IF l_imaf053 <> l_pmdb007_1 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_pmdb007_1)) THEN
                CALL s_aooi250_convert_qty(l_pmdb004,l_pmdb007_1,l_imaf053,l_pmdb006_1)
                    RETURNING l_success,l_pmdb006_1
             END IF
             LET l_pick = l_pick + l_pmdb006_1
          END FOREACH
       END IF
       
       #在製量:抓取已經確認未結案的工單的在製數量(預計產出量(sfac003) -實際入庫量(sfac005)),需考慮生產單位與料件設置的庫存單位的換算率
       IF tm.preparation = 'Y' THEN
          #161205-00025#1--s
          #DECLARE sfac_cs CURSOR FOR
          #   SELECT sfac004,SUM(sfac003 - (CASE WHEN sfac005 IS NULL THEN 0 ELSE sfac005 END) ) FROM sfac_t,sfaa_t
          #     WHERE sfaaent = sfacent AND sfaadocno = sfacdocno AND (sfaastus = 'Y' OR sfaastus = 'F') 
          #       AND sfacent = g_enterprise AND sfacsite = g_site AND sfac001 = l_pmdb004 
          #       AND (CASE WHEN sfac006 IS NULL THEN ' ' ELSE sfac006 END) = l_pmdb005
          #     GROUP BY sfac004   
          #FOREACH sfac_cs INTO l_pmdb007_1,l_pmdb006_1
          FOREACH sfac_cs USING l_pmdb004,l_pmdb005 INTO l_pmdb007_1,l_pmdb006_1
          #161205-00025#1--e
             IF l_imaf053 <> l_pmdb007_1 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_pmdb007_1)) THEN
                CALL s_aooi250_convert_qty(l_pmdb004,l_pmdb007_1,l_imaf053,l_pmdb006_1)
                    RETURNING l_success,l_pmdb006_1
             END IF
             LET l_preparation = l_preparation + l_pmdb006_1
          END FOREACH
       END IF
       
       #安全庫存量:抓取料件設置的安全庫存量(imaf026)
       SELECT imaf026 INTO l_safe FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb004
       IF cl_null(l_safe) THEN
          LET l_safe = 0
       END IF 
       #已備料量:抓取已經確認未結案的工單得未發料量(總應發料(sfba013) - 已發料量(sfba016))，需考慮發料單位與料件設置的庫存單位的換算率
       #若產生來源為'依工單產生'時，取出的已備料量須減掉本次的需求數量
       IF tm.stock = 'Y' THEN
          #161205-00025#1--s
          #DECLARE sfba_cs CURSOR FOR
          #  #161212-00034#1  --begin--
          #  #SELECT sfba014,SUM(sfba013 - (CASE WHEN sfba016 IS NULL THEN 0 ELSE sfba016 END) ) FROM sfba_t,sfaa_t
          #  #  WHERE sfaaent = sfbaent AND sfaadocno = sfbadocno AND (sfaastus = 'Y' OR sfaastus = 'F') 
          #  #    AND sfbaent = g_enterprise AND sfbasite = g_site AND sfba006 = l_pmdb004 
          #  #    AND (CASE WHEN sfba021 IS NULL THEN ' ' ELSE sfba021 END) = l_pmdb005
          #  #GROUP BY sfba014  
          #   SELECT sfba014,SUM(sfba013 - (CASE WHEN sfba016 IS NULL THEN 0 ELSE sfba016 END) - (CASE WHEN sfba015 IS NULL THEN 0 ELSE sfba015 END) + (CASE WHEN sfba017 IS NULL THEN 0 ELSE sfba017 END)) FROM sfba_t,sfaa_t
          #     WHERE sfaaent = sfbaent AND sfaadocno = sfbadocno AND sfaa003 <> '4' 
          #       AND (sfaastus != 'X' AND sfaastus != 'M' AND sfaastus != 'C') 
          #       AND sfbaent = g_enterprise AND sfbasite = g_site AND sfba006 = l_pmdb004 
          #       AND (CASE WHEN sfba021 IS NULL THEN ' ' ELSE sfba021 END) = l_pmdb005
          #   GROUP BY sfba014 
          #  #161212-00034#1  --end--             
          #FOREACH sfba_cs INTO l_pmdb007_1,l_pmdb006_1
          FOREACH sfba_cs USING l_pmdb004,l_pmdb005 INTO l_pmdb007_1,l_pmdb006_1
          #161205-00025#1--e
             IF l_imaf053 <> l_pmdb007_1 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_pmdb007_1)) THEN
                CALL s_aooi250_convert_qty(l_pmdb004,l_pmdb007_1,l_imaf053,l_pmdb006_1)
                    RETURNING l_success,l_pmdb006_1
             END IF
             LET l_stock = l_stock + l_pmdb006_1
          END FOREACH
          
          IF g_choice = '2' THEN
             LET l_stock = l_stock - l_pmdb006
          END IF
       END IF
       
       #將需求數量轉換為庫存單位對應的數量，便於下面的計算
       IF l_imaf053 <> l_pmdb007 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_pmdb007)) THEN
          CALL s_aooi250_convert_qty(l_pmdb004,l_pmdb007,l_imaf053,l_pmdb006)  
                 RETURNING l_success,l_pmdb006
       END IF
       
       #結餘量=庫存可用量+請購量+在採量+在驗量+在製量-安全庫存量-已備料量-本次需求量
       LET l_pmdb006_2 = l_inventory + l_request + l_purchase + l_pick + l_preparation - l_safe - l_stock - l_pmdb006
       
       #結餘量乘上料件主檔設置庫存單位與採購單位的換算率取得本次請購量
       IF l_imaf053 <> l_pmdb007 AND (NOT cl_null(l_imaf053)) AND (NOT cl_null(l_pmdb007)) THEN
          CALL s_aooi250_convert_qty(l_pmdb004,l_imaf053,l_pmdb007,(l_pmdb006_2*(-1)))  #結餘量小於0的部份是本次請購量，换算成请购量时，乘以-1
              RETURNING l_success,l_pmdb006_3 
       ELSE
          LET l_pmdb006_3 = l_pmdb006_2*(-1)
       END IF
       
       IF cl_null(l_pmdb005) THEN
          LET l_pmdb005 = ' '
       END IF
       
       IF cl_null(l_pmdb030) THEN
          LET l_pmdb030 = tm.pmdb030
       END IF
       
       INSERT INTO pmdb_tmp (pmdb004,pmdb005,pmdb030,pmdb006,pmdb007,pmdb006_1,pmdb007_1,pmdb006_2,stock,safe,inventory,request,purchase,pick,preparation)
          VALUES (l_pmdb004,l_pmdb005,l_pmdb030,l_pmdb006_3,l_pmdb007,l_pmdb006_2,l_imaf053,l_pmdb006,
                  l_stock,l_safe,l_inventory,l_request,l_purchase,l_pick,l_preparation)
    END FOREACH
    
END FUNCTION

#料件汇总单身填充
PRIVATE FUNCTION apmt400_01_pmdb_tmp_fill()
DEFINE l_success  LIKE type_t.num5

    CALL g_pmdb_d.clear()
    LET g_sql = "SELECT pmdb004,pmdb005,pmdb030,pmdb006,pmdb007,pmdb006_1,pmdb007_1,pmdb006_2,stock,safe,inventory,request,purchase,pick,preparation, ",
                "       t1.imaal003,t2.imaal004,t3.inaml004,t4.oocal003,t5.oocal003 ",  #161205-00025#1
                "   FROM pmdb_tmp ",
    #161205-00025#1---s
                "   LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=pmdb004 AND t1.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdb004 AND t2.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN inaml_t t3 ON t3.inamlent="||g_enterprise||" AND t3.inaml001=pmdb004 AND t3.inaml002=pmdb005 AND t3.inaml003='"||g_dlang||"' ",
                "   LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=pmdb007 AND t4.oocal002='"||g_dlang||"' ",
                "   LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=pmdb007_1 AND t5.oocal002='"||g_dlang||"' ",
    #161205-00025#1---e
                " ORDER BY pmdb004,pmdb005"
    LET g_sql = cl_sql_add_mask(g_sql)
    PREPARE apmt400_01_pmdb_pb FROM g_sql
    DECLARE apmt400_01_pmdb_cs CURSOR FOR apmt400_01_pmdb_pb
         
    LET g_cnt = l_ac
    LET l_ac = 1
    FOREACH apmt400_01_pmdb_cs INTO g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb006,
                                    g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006_1,g_pmdb_d[l_ac].pmdb007_1,g_pmdb_d[l_ac].pmdb006_2,
                                    g_pmdb_d[l_ac].stock,g_pmdb_d[l_ac].safe,g_pmdb_d[l_ac].inventory,g_pmdb_d[l_ac].request,
                                    g_pmdb_d[l_ac].purchase,g_pmdb_d[l_ac].pick,g_pmdb_d[l_ac].preparation,
                                    #161205-00025#1---s
                                    g_pmdb_d[l_ac].imaal003,g_pmdb_d[l_ac].imaal004,g_pmdb_d[l_ac].pmdb005_desc,
                                    g_pmdb_d[l_ac].pmdb007_desc,g_pmdb_d[l_ac].pmdb007_1_desc
                                    #161205-00025#1---e
        
       #161205-00025#1---s 
       #CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].imaal003,g_pmdb_d[l_ac].imaal004
       #DISPLAY BY NAME g_pmdb_d[l_ac].imaal003,g_pmdb_d[l_ac].imaal004
       #CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
       #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc
       #CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
       #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc
       #CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007_1) RETURNING g_pmdb_d[l_ac].pmdb007_1_desc
       #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_1_desc
       #161205-00025#1---e
       
       IF l_ac > g_max_rec THEN
          IF g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = l_ac
             LET g_errparam.code   = 9035 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
          END IF
          EXIT FOREACH
       END IF
         
       LET l_ac = l_ac + 1
    END FOREACH
    
    CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength())
    LET l_ac = g_cnt
    LET g_cnt = 0  
    
END FUNCTION

#产生请购明细单身
PRIVATE FUNCTION apmt400_01_gen_pmdb()
DEFINE l_sql     STRING
#161124-00048#9 mod-S
#DEFINE l_pmdb    RECORD LIKE pmdb_t.*
#DEFINE l_pmda    RECORD LIKE pmda_t.*
DEFINE l_pmdb RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企业编号
       pmdbsite LIKE pmdb_t.pmdbsite, #营运据点
       pmdbdocno LIKE pmdb_t.pmdbdocno, #请购单号
       pmdbseq LIKE pmdb_t.pmdbseq, #项次
       pmdb001 LIKE pmdb_t.pmdb001, #来源单号
       pmdb002 LIKE pmdb_t.pmdb002, #来源项次
       pmdb003 LIKE pmdb_t.pmdb003, #来源项序
       pmdb004 LIKE pmdb_t.pmdb004, #料件编号
       pmdb005 LIKE pmdb_t.pmdb005, #产品特征
       pmdb006 LIKE pmdb_t.pmdb006, #需求数量
       pmdb007 LIKE pmdb_t.pmdb007, #单位
       pmdb008 LIKE pmdb_t.pmdb008, #参考数量
       pmdb009 LIKE pmdb_t.pmdb009, #参考单位
       pmdb010 LIKE pmdb_t.pmdb010, #计价数量
       pmdb011 LIKE pmdb_t.pmdb011, #计价单位
       pmdb012 LIKE pmdb_t.pmdb012, #包装容器
       pmdb014 LIKE pmdb_t.pmdb014, #供应商选择
       pmdb015 LIKE pmdb_t.pmdb015, #供应商编号
       pmdb016 LIKE pmdb_t.pmdb016, #付款条件
       pmdb017 LIKE pmdb_t.pmdb017, #交易条件
       pmdb018 LIKE pmdb_t.pmdb018, #税率
       pmdb019 LIKE pmdb_t.pmdb019, #参考单价
       pmdb020 LIKE pmdb_t.pmdb020, #参考税前金额
       pmdb021 LIKE pmdb_t.pmdb021, #参考含税金额
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由码
       pmdb032 LIKE pmdb_t.pmdb032, #行状态
       pmdb033 LIKE pmdb_t.pmdb033, #紧急度
       pmdb034 LIKE pmdb_t.pmdb034, #项目编号
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活动编号
       pmdb037 LIKE pmdb_t.pmdb037, #收货据点
       pmdb038 LIKE pmdb_t.pmdb038, #收货库位
       pmdb039 LIKE pmdb_t.pmdb039, #收货储位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允许部份交货
       pmdb042 LIKE pmdb_t.pmdb042, #允许提前交货
       pmdb043 LIKE pmdb_t.pmdb043, #保税
       pmdb044 LIKE pmdb_t.pmdb044, #纳入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期冻结否
       pmdb046 LIKE pmdb_t.pmdb046, #费用部门
       pmdb048 LIKE pmdb_t.pmdb048, #收货时段
       pmdb049 LIKE pmdb_t.pmdb049, #已转采购量
       pmdb050 LIKE pmdb_t.pmdb050, #备注
       pmdb051 LIKE pmdb_t.pmdb051, #结案/留置理由码
       pmdb200 LIKE pmdb_t.pmdb200, #商品条码
       pmdb201 LIKE pmdb_t.pmdb201, #包装单位
       pmdb202 LIKE pmdb_t.pmdb202, #件装数
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送仓库
       pmdb205 LIKE pmdb_t.pmdb205, #采购中心
       pmdb206 LIKE pmdb_t.pmdb206, #采购员
       pmdb207 LIKE pmdb_t.pmdb207, #采购方式
       pmdb208 LIKE pmdb_t.pmdb208, #经营方式
       pmdb209 LIKE pmdb_t.pmdb209, #结算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促销开始日
       pmdb211 LIKE pmdb_t.pmdb211, #促销结束日
       pmdb212 LIKE pmdb_t.pmdb212, #要货件数
       pmdb250 LIKE pmdb_t.pmdb250, #合理库存
       pmdb251 LIKE pmdb_t.pmdb251, #最高库存
       pmdb252 LIKE pmdb_t.pmdb252, #现有库存
       pmdb253 LIKE pmdb_t.pmdb253, #入库在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一周销量
       pmdb255 LIKE pmdb_t.pmdb255, #前二周销量
       pmdb256 LIKE pmdb_t.pmdb256, #前三周销量
       pmdb257 LIKE pmdb_t.pmdb257, #前四周销量
       pmdb258 LIKE pmdb_t.pmdb258, #要货在途量
       pmdb259 LIKE pmdb_t.pmdb259, #周平均销量
       pmdb900 LIKE pmdb_t.pmdb900, #保留字段str
       pmdb999 LIKE pmdb_t.pmdb999, #保留字段end
       pmdb260 LIKE pmdb_t.pmdb260, #收货部门
       pmdb052 LIKE pmdb_t.pmdb052, #来源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #补货规格说明
       pmdb053 LIKE pmdb_t.pmdb053, #预算细项
       pmdb213 LIKE pmdb_t.pmdb213, #参考进价
       pmdb054 LIKE pmdb_t.pmdb054, #库存管理特征
       pmdb214 LIKE pmdb_t.pmdb214 #需求时间
END RECORD
DEFINE l_pmda RECORD  #請購單單頭頭檔
       pmdaent LIKE pmda_t.pmdaent, #企业编号
       pmdaownid LIKE pmda_t.pmdaownid, #资料所有者
       pmdaowndp LIKE pmda_t.pmdaowndp, #资料所有部门
       pmdacrtid LIKE pmda_t.pmdacrtid, #资料录入者
       pmdacrtdp LIKE pmda_t.pmdacrtdp, #资料录入部门
       pmdacrtdt LIKE pmda_t.pmdacrtdt, #资料创建日
       pmdamodid LIKE pmda_t.pmdamodid, #资料更改者
       pmdamoddt LIKE pmda_t.pmdamoddt, #最近更改日
       pmdacnfid LIKE pmda_t.pmdacnfid, #资料审核者
       pmdacnfdt LIKE pmda_t.pmdacnfdt, #数据审核日
       pmdapstid LIKE pmda_t.pmdapstid, #资料过账者
       pmdapstdt LIKE pmda_t.pmdapstdt, #资料过账日
       pmdastus LIKE pmda_t.pmdastus, #状态码
       pmdasite LIKE pmda_t.pmdasite, #营运据点
       pmdadocno LIKE pmda_t.pmdadocno, #请购单号
       pmdadocdt LIKE pmda_t.pmdadocdt, #请购日期
       pmda001 LIKE pmda_t.pmda001, #版次
       pmda002 LIKE pmda_t.pmda002, #请购人员
       pmda003 LIKE pmda_t.pmda003, #请购部门
       pmda004 LIKE pmda_t.pmda004, #单价为必要录入
       pmda005 LIKE pmda_t.pmda005, #币种
       pmda006 LIKE pmda_t.pmda006, #No Use
       pmda007 LIKE pmda_t.pmda007, #费用部门
       pmda008 LIKE pmda_t.pmda008, #请购总税前金额
       pmda009 LIKE pmda_t.pmda009, #请购总含税金额
       pmda010 LIKE pmda_t.pmda010, #税种
       pmda011 LIKE pmda_t.pmda011, #税率
       pmda012 LIKE pmda_t.pmda012, #单价含税否
       pmda020 LIKE pmda_t.pmda020, #纳入APS计算
       pmda021 LIKE pmda_t.pmda021, #运送方式
       pmda022 LIKE pmda_t.pmda022, #备注
       pmda200 LIKE pmda_t.pmda200, #来源类型
       pmda201 LIKE pmda_t.pmda201, #采购方式
       pmda202 LIKE pmda_t.pmda202, #所属品类
       pmda203 LIKE pmda_t.pmda203, #需求组织
       pmda204 LIKE pmda_t.pmda204, #采购中心
       pmda205 LIKE pmda_t.pmda205, #配送中心
       pmda206 LIKE pmda_t.pmda206, #配送仓
       pmda207 LIKE pmda_t.pmda207, #到货日期
       pmda208 LIKE pmda_t.pmda208, #包装总数量
       pmda900 LIKE pmda_t.pmda900, #保留字段str
       pmda999 LIKE pmda_t.pmda999, #保留字段end
       pmda023 LIKE pmda_t.pmda023, #留置原因
       pmda024 LIKE pmda_t.pmda024, #送货地址
       pmda025 LIKE pmda_t.pmda025, #账款地址
       pmda209 LIKE pmda_t.pmda209, #包装总金额
       pmda210 LIKE pmda_t.pmda210, #品种数
       pmda211 LIKE pmda_t.pmda211, #需求时间
       pmda027 LIKE pmda_t.pmda027, #前端单号
       pmda028 LIKE pmda_t.pmda028  #前端类型
END RECORD
#161124-00048#9 mod-E
DEFINE l_success LIKE type_t.num5
DEFINE l_slip    LIKE pmda_t.pmdadocno
DEFINE r_success LIKE type_t.num5

    LET r_success = TRUE
    
    #畫面上有勾選請購明細依料號匯總需求時，則是依據料號匯總的資料產生到請購單身
    #畫面上沒有勾選要依料號匯總需求時，則依據需求明細的資料產生到單身
    IF tm.a = 'Y' THEN
       LET l_sql = " SELECT pmdb004,pmdb005,'','','','',pmdb030,SUM(pmdb006),pmdb007 FROM pmdb_tmp ",
                   "    WHERE pmdb006 > 0 AND pmdb030 IS NOT NULL AND pmdb007 IS NOT NULL ",
                   " GROUP BY pmdb004,pmdb005,pmdb030,pmdb007 ",
                   " ORDER BY pmdb004,pmdb005 "
    ELSE
       LET l_sql = " SELECT pmdb004,pmdb005,(CASE WHEN pmdb001 IS NULL THEN ' ' ELSE pmdb001 END),",
                   "        (CASE WHEN pmdb002 IS NULL THEN 0 ELSE pmdb002 END),",
                   "        (CASE WHEN pmdb003 IS NULL THEN 0 ELSE pmdb003 END),",
                   "        (CASE WHEN pmdb052 IS NULL THEN 0 ELSE pmdb052 END),",
                   "        pmdb030,SUM(pmdb006_5),pmdb007 FROM pmdb_tmp2 ",
                   "    WHERE pmdb006_5 > 0 AND pmdb030 IS NOT NULL AND pmdb007 IS NOT NULL ",
                   " GROUP BY pmdb004,pmdb005,(CASE WHEN pmdb001 IS NULL THEN ' ' ELSE pmdb001 END), ",
                   "          (CASE WHEN pmdb002 IS NULL THEN 0 ELSE pmdb002 END),",
                   "          (CASE WHEN pmdb003 IS NULL THEN 0 ELSE pmdb003 END),",
                   "          (CASE WHEN pmdb052 IS NULL THEN 0 ELSE pmdb052 END),",
                   "          pmdb030,pmdb007 ",
                   " ORDER BY pmdb004,pmdb005"
    END IF
    PREPARE apmt400_01_ins_pmdb_pb FROM l_sql
    DECLARE apmt400_01_ins_pmdb_cs CURSOR FOR apmt400_01_ins_pmdb_pb
    
    INITIALIZE l_pmda.* TO NULL
    INITIALIZE l_pmdb.* TO NULL
    #161124-00048#9 mod-S
#    SELECT * INTO l_pmda.* FROM pmda_t WHERE pmdaent = g_enterprise AND pmdadocno = g_pmdadocno
    SELECT pmdaent,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,
           pmdacrtdt,pmdamodid,pmdamoddt,pmdacnfid,pmdacnfdt,
           pmdapstid,pmdapstdt,pmdastus,pmdasite,pmdadocno,
           pmdadocdt,pmda001,pmda002,pmda003,pmda004,
           pmda005,pmda006,pmda007,pmda008,pmda009,
           pmda010,pmda011,pmda012,pmda020,pmda021,
           pmda022,pmda200,pmda201,pmda202,pmda203,
           pmda204,pmda205,pmda206,pmda207,pmda208,
           pmda900,pmda999,pmda023,pmda024,pmda025,
           pmda209,pmda210,pmda211,pmda027,pmda028
      INTO l_pmda.* 
      FROM pmda_t 
     WHERE pmdaent = g_enterprise AND pmdadocno = g_pmdadocno
    #161124-00048#9 mod-E
    
    CALL cl_err_collect_init() 
    
    FOREACH apmt400_01_ins_pmdb_cs INTO l_pmdb.pmdb004,l_pmdb.pmdb005,l_pmdb.pmdb001,l_pmdb.pmdb002,l_pmdb.pmdb003,
                                        l_pmdb.pmdb052,l_pmdb.pmdb030,l_pmdb.pmdb006,l_pmdb.pmdb007
                                  
       LET l_pmdb.pmdbent = g_enterprise
       LET l_pmdb.pmdbsite = g_site
       LET l_pmdb.pmdbdocno = g_pmdadocno
       LET l_pmdb.pmdb037 = g_site
       
       LET l_pmdb.pmdb014 = "1"
       LET l_pmdb.pmdb019 = "0"
       LET l_pmdb.pmdb043 = "N"
       
       LET l_pmdb.pmdb032 = "1"    #行狀態
       LET l_pmdb.pmdb033 = "1"   #緊急度
       LET l_pmdb.pmdb049 = 0     #已轉採購量
       
       LET l_pmdb.pmdb018 = l_pmda.pmda011  #稅率
       LET l_pmdb.pmdb020 = 0
       LET l_pmdb.pmdb021 = 0
       
       LET l_pmdb.pmdb046 = l_pmda.pmda007  #費用部門
       
       LET l_pmdb.pmdb044 = l_pmda.pmda020  #MRP/MPS計算
       LET l_pmdb.pmdb045 = "N"   #MRP交期凍結
       LET l_pmdb.pmdb041 = "N"   #允許部分交貨
       LET l_pmdb.pmdb042 = "N"   #允許提前交貨
       
       #170322 by wuxja add  --begin--
       CALL s_aooi250_take_decimals(l_pmdb.pmdb007,l_pmdb.pmdb006)
                RETURNING l_success,l_pmdb.pmdb006
       #170322 by wuxja add  --end--
        
       #預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
       IF cl_null(l_pmdb.pmdb038) THEN
          #預設欄位
          CALL s_aooi200_get_slip(g_pmdadocno) RETURNING l_success,l_slip
          IF l_success THEN
             CALL s_aooi200_get_doc_default(g_site,'1',l_slip,'pmdb038',l_pmdb.pmdb038) RETURNING l_pmdb.pmdb038
             #應用參數
             IF cl_null(l_pmdb.pmdb038) THEN
                CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0076') RETURNING l_pmdb.pmdb038
             END IF
          END IF          
       END IF
       
       #採購單位、參考單位、收貨時段、慣用包裝容器
       SELECT imaf015,imaf176,imaf157 INTO l_pmdb.pmdb009,l_pmdb.pmdb048,l_pmdb.pmdb012
          FROM imaf_t
          WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004
       
       IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
          SELECT imaf144 INTO l_pmdb.pmdb011 FROM imaf_t
             WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004                     
       END IF
                    
       #計算參考數量
       IF NOT cl_null(l_pmdb.pmdb009) THEN
          CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb009,l_pmdb.pmdb006)
            RETURNING l_success,l_pmdb.pmdb008
          IF NOT cl_null(l_pmdb.pmdb008) THEN
             #數量取位
             CALL s_aooi250_take_decimals(l_pmdb.pmdb009,l_pmdb.pmdb008)
                RETURNING l_success,l_pmdb.pmdb008 
          END IF
       END IF
       
       #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
       #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
       IF (cl_get_para(g_enterprise,g_site,'S-BAS-0019')) = "Y" AND (NOT cl_null(l_pmdb.pmdb011)) THEN  #體參數使用採購計價單位
          CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb011,l_pmdb.pmdb006)
            RETURNING l_success,l_pmdb.pmdb010
          IF NOT cl_null(l_pmdb.pmdb010) THEN
             CALL s_aooi250_take_decimals(l_pmdb.pmdb011,l_pmdb.pmdb010) 
                RETURNING l_success,l_pmdb.pmdb010
          END IF 
       ELSE
          LET l_pmdb.pmdb010 = l_pmdb.pmdb006
          LET l_pmdb.pmdb011 = l_pmdb.pmdb007
       END IF
       
       IF g_choice = '1' THEN
          LET l_pmdb.pmdb001 = ''
          LET l_pmdb.pmdb002 = ''
          LET l_pmdb.pmdb003 = ''
          LET l_pmdb.pmdb052 = ''
       END IF
       
       SELECT MAX(pmdbseq)+1 INTO l_pmdb.pmdbseq FROM pmdb_t
         WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmdadocno
       IF cl_null(l_pmdb.pmdbseq) OR l_pmdb.pmdbseq = 0 THEN
          LET l_pmdb.pmdbseq = 1
       END IF
       
       INSERT INTO pmdb_t 
             (pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb007,pmdb006,
              pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033,
              pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034,
              pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046,pmdb052) 
            VALUES(l_pmdb.pmdbent,l_pmdb.pmdbsite,l_pmdb.pmdbdocno,l_pmdb.pmdbseq,l_pmdb.pmdb001,l_pmdb.pmdb002, 
                   l_pmdb.pmdb003,l_pmdb.pmdb004,l_pmdb.pmdb005,l_pmdb.pmdb007,l_pmdb.pmdb006,l_pmdb.pmdb009, 
                   l_pmdb.pmdb008,l_pmdb.pmdb011,l_pmdb.pmdb010,l_pmdb.pmdb030,l_pmdb.pmdb048,l_pmdb.pmdb031, 
                   l_pmdb.pmdb050,l_pmdb.pmdb032,l_pmdb.pmdb051,l_pmdb.pmdb033,l_pmdb.pmdb049,l_pmdb.pmdb012, 
                   l_pmdb.pmdb014,l_pmdb.pmdb015,l_pmdb.pmdb016,l_pmdb.pmdb017,l_pmdb.pmdb018,l_pmdb.pmdb019, 
                   l_pmdb.pmdb020,l_pmdb.pmdb021,l_pmdb.pmdb034,l_pmdb.pmdb035,l_pmdb.pmdb036,l_pmdb.pmdb037,
                   l_pmdb.pmdb038,l_pmdb.pmdb039,
                   l_pmdb.pmdb041,l_pmdb.pmdb042,l_pmdb.pmdb043,l_pmdb.pmdb044,l_pmdb.pmdb045,l_pmdb.pmdb046,
                   l_pmdb.pmdb052) 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmdb_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
                     
       INITIALIZE l_pmdb.* TO NULL       
    END FOREACH
    
    CALL cl_err_collect_show()
    
    RETURN r_success
    
END FUNCTION

PRIVATE FUNCTION apmt400_01_sfaa_fill()

    CALL g_sfaa_d.clear()
    LET g_sql = "SELECT sfaadocno,sfbaseq,sfbaseq1,sfaa010,sfaa019,sfaa020,sfaa012,sfaa002,sfba006,sfba021,sfba013,sfba014, ",  #161230-00034#1 add sfba021
                "       t1.imaal003,t2.imaal004,t3.ooag011,t4.imaal003,t5.imaal004,t6.oocal003,t7.inaml004 ",  #161205-00025#1  #161230-00034#1 add inaml004
                "   FROM sfaa_tmp ",
    #161205-00025#1---s
                "   LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=sfaa010 AND t1.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=sfaa010 AND t2.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=sfaa002  ",
                "   LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=sfba006 AND t4.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=sfba006 AND t5.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=sfba014 AND t6.oocal002='"||g_dlang||"' ",
                #161230-00034#1---s
                "   LEFT JOIN inaml_t t7 ON t7.inamlent="||g_enterprise||" AND t7.inaml001=sfba006 AND t7.inaml002=sfba021 AND t7.inaml003='"||g_dlang||"' "
                #161230-00034#1---e
    #161205-00025#1---e
    LET g_sql = cl_sql_add_mask(g_sql)
    PREPARE apmt400_01_sfaa_pb FROM g_sql
    DECLARE apmt400_01_sfaa_cs CURSOR FOR apmt400_01_sfaa_pb
         
    LET g_cnt = l_ac
    LET l_ac = 1
    FOREACH apmt400_01_sfaa_cs INTO g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,
		                              g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,
			                           g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021, #161230-00034#1 add sfba021
			                           g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014,
			                           #161205-00025#1---s
			                           g_sfaa_d[l_ac].imaal003,g_sfaa_d[l_ac].imaal004,g_sfaa_d[l_ac].sfaa002_desc,
			                           g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2,g_sfaa_d[l_ac].sfba014_desc,
			                           g_sfaa_d[l_ac].sfba021_desc #161230-00034#1 add sfba021
			                           #161205-00025#1---e
			                           
       #161205-00025#1---s
       #CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfaa010) RETURNING g_sfaa_d[l_ac].imaal003,g_sfaa_d[l_ac].imaal004
       #DISPLAY BY NAME g_sfaa_d[l_ac].imaal003,g_sfaa_d[l_ac].imaal004
       #
	    #CALL s_desc_get_person_desc(g_sfaa_d[l_ac].sfaa002) RETURNING g_sfaa_d[l_ac].sfaa002_desc
       #DISPLAY BY NAME g_sfaa_d[l_ac].sfaa002_desc
       #
       #CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfba006) RETURNING g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
       #DISPLAY BY NAME g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
       #
		 #CALL s_desc_get_unit_desc(g_sfaa_d[l_ac].sfba014) RETURNING g_sfaa_d[l_ac].sfba014_desc
       #DISPLAY BY NAME g_sfaa_d[l_ac].sfba014_desc
       #161205-00025#1---e
       
       IF l_ac > g_max_rec THEN
          IF g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = l_ac
             LET g_errparam.code   = 9035 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
          END IF
          EXIT FOREACH
       END IF
         
       LET l_ac = l_ac + 1
    END FOREACH
    
    #161205-00025#1-S
    LET l_ac = l_ac - 1
    IF l_ac >= g_cnt THEN
       LET l_ac = g_cnt
    END IF
    IF l_ac = 0 THEN
       LET l_ac = 1
    END IF
    #161205-00025#1-E
    
    CALL g_sfaa_d.deleteElement(g_sfaa_d.getLength())
    #LET l_ac = g_cnt  #161205-00025#1
    #LET g_cnt = 0     #161205-00025#1
    
    FREE apmt400_01_sfaa_pb
END FUNCTION

PRIVATE FUNCTION apmt400_01_xmdd_fill()
DEFINE l_success             LIKE type_t.num5

    CALL g_xmdd_d.clear()
    
    LET g_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004,xmda004,xmda002,xmda003,",
                "       t1.pmaal004,t2.ooag011,t3.ooefl003,t4.imaal003,t5.imaal004,t6.inaml004,t7.oocal003 ",  #161205-00025#1
                "    FROM xmdd_tmp ",
    #161205-00025#1---s
                "   LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=xmda004 AND t1.pmaal002='"||g_dlang||"' ",
                "   LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=xmda002  ",
                "   LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=xmda003 AND t3.ooefl002='"||g_dlang||"' ",
                "   LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=xmdd001 AND t4.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=xmdd001 AND t5.imaal002='"||g_dlang||"' ",
                "   LEFT JOIN inaml_t t6 ON t6.inamlent="||g_enterprise||" AND t6.inaml001=xmdd001 AND t6.inaml002=xmdd002 AND t6.inaml003='"||g_dlang||"' ",
                "   LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=xmdd004 AND t7.oocal002='"||g_dlang||"' "
    #161205-00025#1---e

    LET g_sql = cl_sql_add_mask(g_sql)
    PREPARE apmt400_01_xmdd_pb FROM g_sql
    DECLARE apmt400_01_xmdd_cs CURSOR FOR apmt400_01_xmdd_pb
         
    LET g_cnt = l_ac
    LET l_ac = 1
    FOREACH apmt400_01_xmdd_cs INTO g_xmdd_d[l_ac].xmdddocno,g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,
                                    g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,
                                    g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003,
                                    #161205-00025#1---s
                                    g_xmdd_d[l_ac].xmda004_desc,g_xmdd_d[l_ac].xmda002_desc,g_xmdd_d[l_ac].xmda003_desc,
                                    g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004,g_xmdd_d[l_ac].xmdd002_desc,
                                    g_xmdd_d[l_ac].xmdd004_desc
                                    #161205-00025#1---e
       #161205-00025#1---s                             
       #CALL s_desc_get_trading_partner_abbr_desc(g_xmdd_d[l_ac].xmda004) RETURNING g_xmdd_d[l_ac].xmda004_desc
       #DISPLAY BY NAME g_xmdd_d[l_ac].xmda004_desc
       #
       #CALL s_desc_get_person_desc(g_xmdd_d[l_ac].xmda002) RETURNING g_xmdd_d[l_ac].xmda002_desc
       #DISPLAY BY NAME g_xmdd_d[l_ac].xmda002_desc
       #
       #CALL s_desc_get_department_desc(g_xmdd_d[l_ac].xmda003) RETURNING g_xmdd_d[l_ac].xmda003_desc
       #DISPLAY BY NAME g_xmdd_d[l_ac].xmda003_desc
       #        
       #CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001) RETURNING g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
       #DISPLAY BY NAME g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
       #
       #CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002) RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc
       #DISPLAY BY NAME g_xmdd_d[l_ac].xmdd002_desc
       #
       #CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc
       #DISPLAY BY NAME g_xmdd_d[l_ac].xmdd004_desc
       #161205-00025#1---e
       
       IF l_ac > g_max_rec THEN
          IF g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = l_ac
             LET g_errparam.code   = 9035 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
          END IF
          EXIT FOREACH
       END IF
         
       LET l_ac = l_ac + 1
    END FOREACH
    
    #161205-00025#1-S
    LET l_ac = l_ac - 1
    IF l_ac >= g_cnt THEN
       LET l_ac = g_cnt
    END IF
    IF l_ac = 0 THEN
       LET l_ac = 1
    END IF
    #161205-00025#1-E
       
    CALL g_xmdd_d.deleteElement(g_xmdd_d.getLength())
    #LET l_ac = g_cnt   #161205-00025#1
    #LET g_cnt = 0      #161205-00025#1
    
    FREE apmt400_01_xmdd_pb
    
END FUNCTION

#161219-00028#1
PRIVATE FUNCTION apmt400_01_sfaa_ref()
DEFINE l_success             LIKE type_t.num5

    SELECT sfaa010,sfaa019,sfaa020,sfaa012,sfaa002 
	     INTO g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002 
	   FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = g_sfaa_d[l_ac].sfaadocno
    DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa002 
     
	 CALL s_desc_get_person_desc(g_sfaa_d[l_ac].sfaa002) RETURNING g_sfaa_d[l_ac].sfaa002_desc
    DISPLAY BY NAME g_sfaa_d[l_ac].sfaa002_desc
     
	 IF cl_null(g_sfaa_d[l_ac].sfaa012) THEN
       LET g_sfaa_d[l_ac].sfaa012 =  0
    END IF
    
    LET g_sfaa_d[l_ac].sfba006 = ''
    LET g_sfaa_d[l_ac].imaal003_2=''
    LET g_sfaa_d[l_ac].imaal004_2=''
    LET g_sfaa_d[l_ac].sfba021 = '' 
    LET g_sfaa_d[l_ac].sfba021_desc = ''
    LET g_sfaa_d[l_ac].sfba013 = ''
    LET g_sfaa_d[l_ac].sfba014 = ''
    LET g_sfaa_d[l_ac].sfba014_desc = ''

    SELECT sfbaseq,sfbaseq1,sfba006,sfba021,(sfba013-sfba016),sfba014 
	   INTO g_sfaa_d[l_ac].sfbaseq,g_sfaa_d[l_ac].sfbaseq1,g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021, 
	        g_sfaa_d[l_ac].sfba013,g_sfaa_d[l_ac].sfba014
	  FROM sfba_t WHERE sfbaent = g_enterprise AND sfbadocno = g_sfaa_d[l_ac].sfaadocno 
	                AND sfbaseq = g_sfaa_d[l_ac].sfbaseq AND sfbaseq1 = g_sfaa_d[l_ac].sfbaseq1
	  
	 CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfba006) RETURNING g_sfaa_d[l_ac].imaal003_2,g_sfaa_d[l_ac].imaal004_2
    
	 CALL s_desc_get_unit_desc(g_sfaa_d[l_ac].sfba014) RETURNING g_sfaa_d[l_ac].sfba014_desc
    DISPLAY BY NAME g_sfaa_d[l_ac].sfba014_desc
     
    CALL s_feature_description(g_sfaa_d[l_ac].sfba006,g_sfaa_d[l_ac].sfba021) RETURNING l_success,g_sfaa_d[l_ac].sfba021_desc
    DISPLAY BY NAME g_sfaa_d[l_ac].sfba021_desc
    
END FUNCTION

#161219-00028#1
PRIVATE FUNCTION apmt400_01_xmdd_ref()
DEFINE l_success             LIKE type_t.num5

    SELECT xmda004,xmda002,xmda003 INTO g_xmdd_d[l_ac].xmda004,g_xmdd_d[l_ac].xmda002,g_xmdd_d[l_ac].xmda003
        FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = g_xmdd_d[l_ac].xmdddocno
    CALL s_desc_get_trading_partner_abbr_desc(g_xmdd_d[l_ac].xmda004) RETURNING g_xmdd_d[l_ac].xmda004_desc
    DISPLAY BY NAME g_xmdd_d[l_ac].xmda004_desc
    
    CALL s_desc_get_person_desc(g_xmdd_d[l_ac].xmda002) RETURNING g_xmdd_d[l_ac].xmda002_desc
    DISPLAY BY NAME g_xmdd_d[l_ac].xmda002_desc
    
    CALL s_desc_get_department_desc(g_xmdd_d[l_ac].xmda003) RETURNING g_xmdd_d[l_ac].xmda003_desc
    DISPLAY BY NAME g_xmdd_d[l_ac].xmda003_desc
    
    LET g_xmdd_d[l_ac].xmdd001 = ''
    LET g_xmdd_d[l_ac].imaal003 = ''
    LET g_xmdd_d[l_ac].imaal004= ''
    LET g_xmdd_d[l_ac].xmdd002 = ''
    LET g_xmdd_d[l_ac].xmdd002 = ''
    LET g_xmdd_d[l_ac].xmdd011 = ''
    LET g_xmdd_d[l_ac].xmdd006 = ''
    LET g_xmdd_d[l_ac].xmdd004 = ''
    LET g_xmdd_d[l_ac].xmdd004_desc = ''

    SELECT xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd011,xmdd006,xmdd004
        INTO g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
             g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
       FROM xmdd_t WHERE xmddent = g_enterprise AND xmdddocno = g_xmdd_d[l_ac].xmdddocno 
                     AND xmddseq = g_xmdd_d[l_ac].xmddseq AND xmddseq1 = g_xmdd_d[l_ac].xmddseq1
                     AND xmddseq2 = g_xmdd_d[l_ac].xmddseq2
                     
    CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001) RETURNING g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
    
    CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002) RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc
    
    CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc

    DISPLAY BY NAME g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd001,
                    g_xmdd_d[l_ac].xmdd002,g_xmdd_d[l_ac].xmdd011,g_xmdd_d[l_ac].xmdd006,g_xmdd_d[l_ac].xmdd004
    DISPLAY BY NAME g_xmdd_d[l_ac].imaal003,g_xmdd_d[l_ac].imaal004
    DISPLAY BY NAME g_xmdd_d[l_ac].xmdd002_desc
    DISPLAY BY NAME g_xmdd_d[l_ac].xmdd004_desc
END FUNCTION

 
{</section>}
 
