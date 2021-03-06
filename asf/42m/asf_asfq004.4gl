#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq004.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:18(2017-02-08 17:38:11), PR版次:0018(2017-02-08 18:02:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000121
#+ Filename...: asfq004
#+ Description: 訂單/產品用料模擬作業
#+ Creator....: 04441(2014-08-29 09:51:32)
#+ Modifier...: 04441 -SD/PR- 04441
 
{</section>}
 
{<section id="asfq004.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150814-00009#1    15/11/18 by ywtsai    增加一查詢條件，選擇參考材料列印否(因參考材料不需發料，故客戶認為不需列出)
#151224-00025#3    15/12/24 By fionchen  產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160503-00030      16/05/10 by whitney   效能優化 
#160512-00016#14   16/05/27 By ming      s_asft300_02_bom增加參數 
#160512-00016#15   16/05/28 By ming      s_asft300_02_bom處多傳入參數保稅否，預設N
#160707-00002#1    16/07/21 By Sarah     需求數量應加上BOM的外加損秏率數量
#160727-00019#18   16/08/04 By 08734     临时表长度超过15码的减少到15码以下 asfq004_g01_tmp1 ——> asfq004_tmp01,asfq004_g01_tmp2 ——> asfq004_tmp02
#160816-00002#1    16/08/16 By Sarah     效能優化Part2
#160816-00002#2    16/08/23 By Sarah     將#160816-00002#1在MAIN段定義抓Temptable資料的CURSOR搬到FUNCTION asfq004_maneuvers()
#160824-00063#1    16/08/24 By Sarah     寫入asfq004_xmdd_tmp的SELECT少寫了xmdd001,導致受訂量的值對應不到
#161027-00027#1    16/10/28 By liuym     仿真查询时添加BOM特性作为查询条件
#170208-00015#1    17/02/08 By Whitney   修正asfq004_tmp1_ins_pb
#170208-00043#1    17/02/08 By Whitney   訂單用料模擬訂單欄位要輸入值
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdc_d RECORD
       
       sel LIKE type_t.chr1, 
   xmdcseq LIKE xmdc_t.xmdcseq, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   xmdc062 LIKE xmdc_t.xmdc062, 
   xmdc001_desc LIKE type_t.chr500, 
   xmdc001_desc_desc LIKE type_t.chr500, 
   xmdc002 LIKE xmdc_t.xmdc002, 
   xmdc002_desc LIKE type_t.chr500, 
   xmdc006 LIKE xmdc_t.xmdc006, 
   xmdc006_desc LIKE type_t.chr500, 
   xmdc007 LIKE xmdc_t.xmdc007
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tm              RECORD
    con1               LIKE type_t.chr1,       #訂單/產品用料模擬
    con2               LIKE type_t.chr1,       #展開選項
    con3               STRING,                 #訂單單號          #150814-00009#1 加,
    con4               LIKE type_t.chr1        #參考材料列印否     #150814-00009#1 add
                   END RECORD
TYPE type_g_bmba_d     RECORD
    bmba003            LIKE bmba_t.bmba003,    #料號
    bmba003_desc       LIKE imaal_t.imaal003,  #品名
    bmba003_desc_desc  LIKE imaal_t.imaal004,  #規格
    bmba010            LIKE bmba_t.bmba010,    #單位
    bmba010_desc       LIKE oocal_t.oocal003,  #說明
    qty1               LIKE xmdc_t.xmdc007,    #需求數量 
    qty2               LIKE xmdc_t.xmdc007,    #庫存可用量
    qty3               LIKE xmdc_t.xmdc007,    #備置量
    qty4               LIKE xmdc_t.xmdc007,    #在揀量
    qty5               LIKE xmdc_t.xmdc007,    #可用餘量
    qty13              LIKE xmdc_t.xmdc007,    #受訂量
    qty6               LIKE xmdc_t.xmdc007,    #工單預計備料量
    qty7               LIKE xmdc_t.xmdc007,    #請購量
    qty8               LIKE xmdc_t.xmdc007,    #在途量
    qty9               LIKE xmdc_t.xmdc007,    #在驗量
    qty10              LIKE xmdc_t.xmdc007,    #在制量
    qty11              LIKE xmdc_t.xmdc007,    #預計可用量
    qty12              LIKE xmdc_t.xmdc007,    #預計結存量
    stus               LIKE type_t.chr1        #滿足備料需求否
                  END RECORD
DEFINE g_bmba_d        DYNAMIC ARRAY OF type_g_bmba_d
DEFINE g_detail_idx3   LIKE type_t.num5
DEFINE g_detail_cnt3   LIKE type_t.num5
DEFINE g_bmba          DYNAMIC ARRAY OF RECORD
    bmba001            LIKE bmba_t.bmba001,    #主件料號
    bmba002            LIKE bmba_t.bmba002,    #特性
    bmba003            LIKE bmba_t.bmba003,    #元件料號
    bmba004            LIKE bmba_t.bmba004,    #部位編號
    bmba005            DATETIME YEAR TO SECOND,#生效日期時間
    bmba007            LIKE bmba_t.bmba007,    #作業編號
    bmba008            LIKE bmba_t.bmba008,    #作業序 
    #160512-00016#14 20160528 add by ming -----(S) 
    bmba035            LIKE bmba_t.bmba035,    #保稅否 
    #160512-00016#14 20160528 add by ming -----(E) 
    l_bmba011          LIKE bmba_t.bmba011,    #組成用量
    l_bmba012          LIKE bmba_t.bmba012,    #主件底數
    l_inam002          LIKE inam_t.inam002     #元件对应特征
                   END RECORD

#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmdc_d            DYNAMIC ARRAY OF type_g_xmdc_d
DEFINE g_xmdc_d_t          type_g_xmdc_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfq004.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asf","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq004_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asfq004_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
#160816-00002#2-s mark
#將#160816-00002#1在MAIN段定義抓Temptable資料的CURSOR搬到FUNCTION asfq004_maneuvers()
##160816-00002#1-s add
##效能優化Part2,將FUNCTION asfq004_maneuvers()在FOREACH中呼叫到的FUNCTION中會用到的CURSOR(改成抓Temptable資料效能會更好)搬到前面
#   #FUNCTION asfq004_sfaa()的sfaa_cur CURSOR
#   LET g_sql = "SELECT qty,sfaa013 FROM asfq004_sfaa_tmp WHERE sfaa010=?"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE sfaa_pre FROM g_sql
#   DECLARE sfaa_cur CURSOR FOR sfaa_pre
#
#   #FUNCTION asfq004_pmdt()的pmdt_cur CURSOR
#   LET g_sql = "SELECT qty,pmdt019 FROM asfq004_pmdt_tmp WHERE pmdt006=?"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE pmdt_pre FROM g_sql
#   DECLARE pmdt_cur CURSOR FOR pmdt_pre
#   
#   #FUNCTION asfq004_pmdo()的pmdo_cur CURSOR
#   LET g_sql = "SELECT qty,pmdo004 FROM asfq004_pmdo_tmp WHERE pmdo001=?"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE pmdo_pre FROM g_sql
#   DECLARE pmdo_cur CURSOR FOR pmdo_pre
#
#   #FUNCTION asfq004_sfba()的sfba_cur CURSOR
#   LET g_sql = "SELECT qty,sfba014 FROM asfq004_sfba_tmp WHERE sfba006=?"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE sfba_pre FROM g_sql
#   DECLARE sfba_cur CURSOR FOR sfba_pre
#   
#   #FUNCTION asfq004_pmdb()的pmdb_cur CURSOR
#   LET g_sql = "SELECT qty,pmdb007 FROM asfq004_pmdb_tmp WHERE pmdb004=?"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE pmdb_pre FROM g_sql
#   DECLARE pmdb_cur CURSOR FOR pmdb_pre
#
#   #FUNCTION asfq004_xmdd()的xmdd_cur CURSOR
#   LET g_sql = "SELECT qty,xmdd004 FROM asfq004_xmdd_tmp WHERE xmdd001=?"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE xmdd_pre FROM g_sql
#   DECLARE xmdd_cur CURSOR FOR xmdd_pre
#   
#   #FUNCTION asfq004_get_inag008()的inag_cur CURSOR
#   LET g_sql = "SELECT COALESCE(inag008,0),inag007",
#               "  FROM inag_t",
#               " WHERE inagent = ?",
#               "   AND inagsite = ?",
#               "   AND inag001 = ?",
#               "   AND inag010 = 'Y'"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE inag_pre FROM g_sql
#   DECLARE inag_cur CURSOR FOR inag_pre
##160816-00002#1-e add
#160816-00002#2-e mark
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq004_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq004 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq004_init()   
 
      #進入選單 Menu (="N")
      CALL asfq004_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq004
      
   END IF 
   
   CLOSE asfq004_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE asfq004_tmp1
   DROP TABLE asfq004_tmp2
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asfq004.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asfq004_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   LET tm.con1 = '1'
   LET tm.con2 = '4'
   LET tm.con4 = 'N'     #150814-00009#1 add
   
   CREATE TEMP TABLE asfq004_tmp1(
      xmdcent     SMALLINT,
      xmdcseq     INTEGER,
      xmdc001     VARCHAR(40),
      xmdc002     VARCHAR(256),
      xmdc062     VARCHAR(30),       #161027-00027#1 add 
      xmdc006     VARCHAR(10),
      xmdc007     DECIMAL(20,6))

   CREATE TEMP TABLE asfq004_tmp2(
      bmba003     VARCHAR(40),
      bmba010     VARCHAR(10),
      qty1        DECIMAL(20,6),
      qty2        DECIMAL(20,6),
      qty3        DECIMAL(20,6),
      qty4        DECIMAL(20,6),
      qty5        DECIMAL(20,6),
      qty13       DECIMAL(20,6),
      qty6        DECIMAL(20,6),
      qty7        DECIMAL(20,6),
      qty8        DECIMAL(20,6),
      qty9        DECIMAL(20,6),
      qty10       DECIMAL(20,6),
      qty11       DECIMAL(20,6),
      qty12       DECIMAL(20,6))

#160816-00002#1-s add
#效能優化Part2,將FUNCTION asfq004_maneuvers()在FOREACH中呼叫到的FUNCTION中會用到的資料寫入Temptable中
   CREATE TEMP TABLE asfq004_sfaa_tmp(
      sfaa010     VARCHAR(40),
      qty         DECIMAL(20,6),
      sfaa013     VARCHAR(10))

   CREATE TEMP TABLE asfq004_pmdt_tmp(
      pmdt006     VARCHAR(40),
      qty         DECIMAL(20,6),
      pmdt019     VARCHAR(10))
      
   CREATE TEMP TABLE asfq004_pmdo_tmp(
      pmdo001     VARCHAR(40),
      qty         DECIMAL(20,6),
      pmdo004     VARCHAR(10))

   CREATE TEMP TABLE asfq004_sfba_tmp(
      sfba006     VARCHAR(40),
      qty         DECIMAL(20,6),
      sfba014     VARCHAR(10))
   
   CREATE TEMP TABLE asfq004_pmdb_tmp(
      pmdb004     VARCHAR(40),
      qty         DECIMAL(20,6),
      pmdb007     VARCHAR(10))
      
   CREATE TEMP TABLE asfq004_xmdd_tmp(
      xmdd001     VARCHAR(40),
      qty         DECIMAL(20,6),
      xmdd004     VARCHAR(10))
#160816-00002#1-e add
   #end add-point
 
   CALL asfq004_default_search()
END FUNCTION
 
{</section>}
 
{<section id="asfq004.default_search" >}
PRIVATE FUNCTION asfq004_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdcdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xmdcseq = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfq004_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_imaa005  LIKE imaa_t.imaa005

   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
   CALL asfq004_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmdc_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL asfq004_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         #INPUT BY NAME tm.con1,tm.con2,tm.con3          #150814-00009#1 mark
         INPUT BY NAME tm.con1,tm.con2,tm.con3,tm.con4   #150814-00009#1 add
            ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
               CALL asfq004_set_entry()

            ON CHANGE con1
               DELETE FROM asfq004_tmp1
               CALL g_xmdc_d.clear()
               CALL g_bmba_d.clear()
               CALL asfq004_set_entry()
               IF tm.con1 = '1' THEN
                  NEXT FIELD con3
               ELSE
                  NEXT FIELD b_xmdc001
               END IF
               
            ON ACTION controlp INFIELD con3  #訂單單號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.con3
               LET g_qryparam.where = " xmdastus <> 'X' "
               CALL q_xmdadocno_9()
               LET tm.con3 = g_qryparam.return1
               DISPLAY tm.con3 TO con3
               NEXT FIELD con3

            AFTER INPUT

         END INPUT

         INPUT ARRAY g_xmdc_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,
                      MAXCOUNT = g_max_rec,
                      WITHOUT DEFAULTS, 
                      INSERT ROW = TRUE,
                      DELETE ROW = TRUE,
                      APPEND ROW = TRUE)
         
            BEFORE INPUT
               LET g_detail_cnt = g_xmdc_d.getLength()
         
            BEFORE ROW
               LET g_detail_idx = ARR_CURR()
               DISPLAY g_detail_idx TO FORMONLY.h_index
               LET g_detail_cnt = g_xmdc_d.getLength()
         
            BEFORE INSERT
               SELECT MAX(xmdcseq)+1 
                 INTO g_xmdc_d[g_detail_idx].xmdcseq
                 FROM asfq004_tmp1
               IF cl_null(g_xmdc_d[g_detail_idx].xmdcseq) OR g_xmdc_d[g_detail_idx].xmdcseq = 0 THEN
                  LET g_xmdc_d[g_detail_idx].xmdcseq = 1
               END IF
               LET g_xmdc_d[g_detail_idx].sel = 'Y'
               LET g_xmdc_d_t.* = g_xmdc_d[g_detail_idx].*
         
            AFTER INSERT
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF
               INSERT INTO asfq004_tmp1(xmdcent,xmdcseq,xmdc001,xmdc002,xmdc062,xmdc006,xmdc007) #161027-00027#1 add xmdc062 
                  VALUES(g_enterprise,g_xmdc_d[g_detail_idx].xmdcseq,
                         g_xmdc_d[g_detail_idx].xmdc001,g_xmdc_d[g_detail_idx].xmdc002,g_xmdc_d[g_detail_idx].xmdc062,
                         g_xmdc_d[g_detail_idx].xmdc006,g_xmdc_d[g_detail_idx].xmdc007)
               LET g_detail_cnt = g_detail_cnt + 1
         
            AFTER FIELD b_xmdc001
               LET g_xmdc_d[g_detail_idx].xmdc001_desc = ' '
               LET g_xmdc_d[g_detail_idx].xmdc001_desc_desc = ' '
               IF NOT cl_null(g_xmdc_d[g_detail_idx].xmdc001) THEN 
                  IF g_xmdc_d[g_detail_idx].xmdc001 != g_xmdc_d_t.xmdc001 OR g_xmdc_d_t.xmdc001 IS NULL THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_xmdc_d[g_detail_idx].xmdc001
                     IF NOT cl_chk_exist("v_imaf001_14") THEN
                        LET g_xmdc_d[g_detail_idx].xmdc001 = g_xmdc_d_t.xmdc001
                        CALL s_desc_get_item_desc(g_xmdc_d[g_detail_idx].xmdc001)
                             RETURNING g_xmdc_d[g_detail_idx].xmdc001_desc,g_xmdc_d[g_detail_idx].xmdc001_desc_desc
                        NEXT FIELD CURRENT
                     END IF
                     #發料單位
                     SELECT imae081 INTO g_xmdc_d[g_detail_idx].xmdc006
                       FROM imae_t
                      WHERE imaeent = g_enterprise
                        AND imaesite = g_site
                        AND imae001 = g_xmdc_d[g_detail_idx].xmdc001
                     CALL s_desc_get_unit_desc(g_xmdc_d[g_detail_idx].xmdc006)
                          RETURNING g_xmdc_d[g_detail_idx].xmdc006_desc
                  END IF
               END IF
               CALL s_desc_get_item_desc(g_xmdc_d[g_detail_idx].xmdc001)
                    RETURNING g_xmdc_d[g_detail_idx].xmdc001_desc,g_xmdc_d[g_detail_idx].xmdc001_desc_desc
               LET g_xmdc_d_t.xmdc001 = g_xmdc_d[g_detail_idx].xmdc001
               LET g_xmdc_d_t.xmdc006 = g_xmdc_d[g_detail_idx].xmdc006
         
            AFTER FIELD b_xmdc002
               LET g_xmdc_d[g_detail_idx].xmdc002_desc = ''
               IF cl_null(g_xmdc_d[g_detail_idx].xmdc002) THEN
                  LET g_xmdc_d[g_detail_idx].xmdc002 = ' '
               ELSE
                  IF g_xmdc_d[g_detail_idx].xmdc002 != g_xmdc_d_t.xmdc002 OR g_xmdc_d_t.xmdc002 IS NULL THEN
                     IF NOT s_feature_check(g_xmdc_d[g_detail_idx].xmdc001,g_xmdc_d[g_detail_idx].xmdc002) THEN
                        LET g_xmdc_d[g_detail_idx].xmdc002 = g_xmdc_d_t.xmdc002
                        CALL s_feature_description(g_xmdc_d[g_detail_idx].xmdc001,g_xmdc_d[g_detail_idx].xmdc002)
                             RETURNING l_success,g_xmdc_d[g_detail_idx].xmdc002_desc
                        NEXT FIELD CURRENT
                     END IF
                     #151224-00025#3 add start ------------------------
                     IF NOT s_feature_direct_input(g_xmdc_d[g_detail_idx].xmdc001,g_xmdc_d[g_detail_idx].xmdc002,g_xmdc_d_t.xmdc002,'',g_site) THEN
                        NEXT FIELD CURRENT
                     END IF
                     #151224-00025#3 add end   ------------------------ 
                  END IF
               END IF
               CALL s_feature_description(g_xmdc_d[g_detail_idx].xmdc001,g_xmdc_d[g_detail_idx].xmdc002)
                    RETURNING l_success,g_xmdc_d[g_detail_idx].xmdc002_desc
               LET g_xmdc_d_t.xmdc002 = g_xmdc_d[g_detail_idx].xmdc002
               LET g_xmdc_d_t.xmdc007 = g_xmdc_d[g_detail_idx].xmdc007
               
            AFTER FIELD b_xmdc006
               LET g_xmdc_d[g_detail_idx].xmdc006_desc = ' '
               IF NOT cl_null(g_xmdc_d[g_detail_idx].xmdc006) THEN 
                  IF g_xmdc_d[g_detail_idx].xmdc006 != g_xmdc_d_t.xmdc006 OR g_xmdc_d_t.xmdc006 IS NULL THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_xmdc_d[g_detail_idx].xmdc001
                     LET g_chkparam.arg2 = g_xmdc_d[g_detail_idx].xmdc006
                     IF NOT cl_chk_exist("v_imao002") THEN
                        LET g_xmdc_d[g_detail_idx].xmdc006 = g_xmdc_d_t.xmdc006
                        CALL s_desc_get_unit_desc(g_xmdc_d[g_detail_idx].xmdc006)
                             RETURNING g_xmdc_d[g_detail_idx].xmdc006_desc
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT cl_null(g_xmdc_d[g_detail_idx].xmdc007) THEN
                        CALL s_aooi250_take_decimals(g_xmdc_d[g_detail_idx].xmdc006,g_xmdc_d[g_detail_idx].xmdc007)
                             RETURNING l_success,g_xmdc_d[g_detail_idx].xmdc007
                     END IF
                  END IF
               END IF
               CALL s_desc_get_unit_desc(g_xmdc_d[g_detail_idx].xmdc006)
                    RETURNING g_xmdc_d[g_detail_idx].xmdc006_desc
               LET g_xmdc_d_t.xmdc006 = g_xmdc_d[g_detail_idx].xmdc006
               LET g_xmdc_d_t.xmdc007 = g_xmdc_d[g_detail_idx].xmdc007
         
            AFTER FIELD b_xmdc007
               IF NOT cl_null(g_xmdc_d[g_detail_idx].xmdc007) THEN 
                  IF g_xmdc_d[g_detail_idx].xmdc007 != g_xmdc_d_t.xmdc007 OR g_xmdc_d_t.xmdc007 IS NULL THEN
                     IF NOT cl_ap_chk_range(g_xmdc_d[g_detail_idx].xmdc007,"0.000","1","","","azz-00079",1) THEN
                        LET g_xmdc_d[g_detail_idx].xmdc007 = g_xmdc_d_t.xmdc007
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT cl_null(g_xmdc_d[g_detail_idx].xmdc006) THEN
                        CALL s_aooi250_take_decimals(g_xmdc_d[g_detail_idx].xmdc006,g_xmdc_d[g_detail_idx].xmdc007)
                             RETURNING l_success,g_xmdc_d[g_detail_idx].xmdc007
                     END IF
                  END IF
               END IF
               LET g_xmdc_d_t.xmdc007 = g_xmdc_d[g_detail_idx].xmdc007
         
            ON ACTION controlp INFIELD b_xmdc001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xmdc_d[g_detail_idx].xmdc001
               CALL q_imaf001_15()
               LET g_xmdc_d[g_detail_idx].xmdc001 = g_qryparam.return1              
               DISPLAY g_xmdc_d[g_detail_idx].xmdc001 TO b_xmdc001
               CALL s_desc_get_item_desc(g_xmdc_d[g_detail_idx].xmdc001)
                    RETURNING g_xmdc_d[g_detail_idx].xmdc001_desc,g_xmdc_d[g_detail_idx].xmdc001_desc_desc
               NEXT FIELD b_xmdc001
         
            ON ACTION controlp INFIELD b_xmdc002
               LET l_imaa005 = ''
               SELECT imaa005 INTO l_imaa005 FROM imaa_t
                WHERE imaaent = g_enterprise AND imaa001 = g_xmdc_d[g_detail_idx].xmdc001
               IF NOT cl_null(l_imaa005) AND NOT cl_null(g_xmdc_d[g_detail_idx].xmdc002) THEN
                  CALL s_feature_single(g_xmdc_d[g_detail_idx].xmdc001,g_xmdc_d[g_detail_idx].xmdc002,g_site,'')
                       RETURNING l_success,g_xmdc_d[g_detail_idx].xmdc002
               END IF
               CALL s_feature_description(g_xmdc_d[g_detail_idx].xmdc001,g_xmdc_d[g_detail_idx].xmdc002)
                    RETURNING l_success,g_xmdc_d[g_detail_idx].xmdc002_desc
            #161027-00018#1 add-------------S------------
            ON ACTION controlp INFIELD b_xmdc062
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xmdc_d[g_detail_idx].xmdc062
               LET g_qryparam.arg1=g_xmdc_d[g_detail_idx].xmdc001
               CALL q_bmba002()
               LET g_xmdc_d[g_detail_idx].xmdc062 = g_qryparam.return1              
               DISPLAY g_xmdc_d[g_detail_idx].xmdc062 TO b_xmdc062
               NEXT FIELD b_xmdc062
            #161027-00018#1 add-------------E----------
            ON ACTION controlp INFIELD b_xmdc006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xmdc_d[g_detail_idx].xmdc006
               LET g_qryparam.arg1 = g_xmdc_d[g_detail_idx].xmdc001
               CALL q_imao002()
               LET g_xmdc_d[g_detail_idx].xmdc006 = g_qryparam.return1              
               DISPLAY g_xmdc_d[g_detail_idx].xmdc006 TO b_xmdc006
               CALL s_desc_get_unit_desc(g_xmdc_d[g_detail_idx].xmdc006)
                    RETURNING g_xmdc_d[g_detail_idx].xmdc006_desc
               NEXT FIELD b_xmdc006
         
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET INT_FLAG = 0
                  LET g_xmdc_d[g_detail_idx].* = g_xmdc_d_t.*
                  EXIT DIALOG 
               END IF
               UPDATE asfq004_tmp1 SET xmdc001 = g_xmdc_d[g_detail_idx].xmdc001,
                                       xmdc002 = g_xmdc_d[g_detail_idx].xmdc002,
                                       xmdc006 = g_xmdc_d[g_detail_idx].xmdc006,
                                       xmdc007 = g_xmdc_d[g_detail_idx].xmdc007
                WHERE xmdcseq = g_xmdc_d[g_detail_idx].xmdcseq
               
            AFTER ROW
                 
            AFTER INPUT

            ON ACTION delete
               LET g_action_choice="delete"
               IF cl_ask_del_detail() THEN
                  DELETE FROM asfq004_tmp1
                   WHERE xmdcseq = g_xmdc_d[g_detail_idx].xmdcseq
                  INITIALIZE g_xmdc_d[g_detail_idx].* TO NULL
                  LET g_detail_cnt = g_detail_cnt - 1
                  CALL asfq004_b_fill()
               END IF

         END INPUT

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
 
#         #end add-point
#     
#         DISPLAY ARRAY g_xmdc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
# 
#            BEFORE DISPLAY
#               LET g_current_page = 1
# 
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_ac = g_detail_idx
#               CALL asfq004_detail_action_trans()
# 
#               LET g_master_idx = l_ac
#               #為避免按上下筆時影響執行效能，所以做一些處理
#               LET lc_action_choice_old = g_action_choice
#               LET g_action_choice = "fetch"
#               CALL asfq004_b_fill2()
#               LET g_action_choice = lc_action_choice_old
# 
#               #add-point:input段before row name="input.body.before_row"
 
#               #end add-point
# 
#            
# 
#            #自訂ACTION(detail_show,page_1)
#            
# 
#            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
 
#            #end add-point
# 
#         END DISPLAY
# 
#         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_bmba_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3)
         
            BEFORE DISPLAY
         
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
         
         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfq004_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD con1
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            #170208-00043#1-s
            IF tm.con1 = '1' AND cl_null(tm.con3) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 'art-00558'
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               NEXT FIELD con3
            END IF
            #170208-00043#1-s

            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL asfq004_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xmdc_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_bmba_d)
               LET g_export_id[2]   = "s_detail3"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL asfq004_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL asfq004_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL asfq004_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL asfq004_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL asfq004_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmdc_d.getLength()
               LET g_xmdc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmdc_d.getLength()
               LET g_xmdc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmdc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmdc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdc_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfq004_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL asfq004_g01(" 1=1 ","asfq004_tmp01","asfq004_tmp02")  #fengmy141201 call 报表子程序   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp1 ——> asfq004_tmp01,asfq004_g01_tmp2 ——> asfq004_tmp02  
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL asfq004_g01(" 1=1 ","asfq004_tmp01","asfq004_tmp02")  #fengmy141201 call 报表子程序   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp1 ——> asfq004_tmp01,asfq004_g01_tmp2 ——> asfq004_tmp02  
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION maneuvers
            LET g_action_choice="maneuvers"
            IF cl_auth_chk_act("maneuvers") THEN
               
               #add-point:ON ACTION maneuvers name="menu.maneuvers"
               CALL asfq004_maneuvers()
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
 
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq004_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xmdc  RECORD
       xmdcseq    LIKE xmdc_t.xmdcseq, 
       xmdc001    LIKE xmdc_t.xmdc001, 
       xmdc002    LIKE xmdc_t.xmdc002, 
       xmdc062    LIKE xmdc_t.xmdc062,    #161027-00027#1 add 
       xmdc006    LIKE xmdc_t.xmdc006, 
       xmdc007    LIKE xmdc_t.xmdc007
              END RECORD

   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF NOT cl_null(tm.con3) THEN
      LET g_wc = ''
      CONSTRUCT BY NAME g_wc ON con3
         BEFORE CONSTRUCT
            DISPLAY tm.con3 TO con3
            EXIT CONSTRUCT
      END CONSTRUCT
      CALL s_chr_replace(g_wc,'con3','xmdcdocno',0)
           RETURNING g_wc
   
      LET tm.con3 = ''
   
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
      
      LET g_sql = " SELECT UNIQUE xmdc001,xmdc002,xmdc062,xmdc006,SUM(xmdc007) ", #161027-00027#1 add xmdc062 
                  "   FROM xmdc_t ",
                  " WHERE xmdcent= ? AND 1=1 AND ", ls_wc
      
      LET g_sql = g_sql, cl_sql_add_filter("xmdc_t"),
                 #170208-00015#1-s
                 #" GROUP BY xmdc001,xmdc002,xmdc006 ORDER BY xmdc001 "
                  " GROUP BY xmdc001,xmdc002,xmdc062,xmdc006 "
                 #170208-00015#1-e
      
      PREPARE asfq004_tmp1_ins_pb FROM g_sql
      DECLARE asfq004_tmp1_ins_curs CURSOR FOR asfq004_tmp1_ins_pb
      
      LET g_sql = "INSERT INTO asfq004_tmp1(xmdcent,xmdcseq,xmdc001,xmdc002,xmdc062,xmdc006,xmdc007) ",#161027-00027#1 add xmdc062 
                  "                  VALUES(?,?,?,?,?,?,?) "
      
      PREPARE asfq004_tmp1_ins_pre FROM g_sql
      
      OPEN asfq004_tmp1_ins_curs USING g_enterprise
      
      INITIALIZE l_xmdc.* TO NULL
      
      FOREACH asfq004_tmp1_ins_curs INTO l_xmdc.xmdc001,l_xmdc.xmdc002,l_xmdc.xmdc062, #161027-00027#1 add l_xmdc.xmdc062 
                                         l_xmdc.xmdc006,l_xmdc.xmdc007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         SELECT MAX(xmdcseq)+1 INTO l_xmdc.xmdcseq FROM asfq004_tmp1
         IF cl_null(l_xmdc.xmdcseq) OR l_xmdc.xmdcseq = 0 THEN
            LET l_xmdc.xmdcseq = 1
         END IF
         
         EXECUTE asfq004_tmp1_ins_pre
           USING g_enterprise,l_xmdc.xmdcseq,l_xmdc.xmdc001,
                 l_xmdc.xmdc002,l_xmdc.xmdc062,l_xmdc.xmdc006,l_xmdc.xmdc007  #161027-00027#1 add l_xmdc.xmdc062 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "asfq004_tmp1_ins_pre"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         INITIALIZE l_xmdc.* TO NULL
      END FOREACH
   END IF


   LET g_detail_idx3 = 1

   #end add-point
 
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xmdc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_bmba_d.clear()

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xmdcseq,xmdc001,xmdc062,'','',xmdc002,'',xmdc006,'',xmdc007  , 
       DENSE_RANK() OVER( ORDER BY xmdc_t.xmdcdocno,xmdc_t.xmdcseq) AS RANK FROM xmdc_t",
 
 
                     "",
                     " WHERE xmdcent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmdc_t"),
                     " ORDER BY xmdc_t.xmdcdocno,xmdc_t.xmdcseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '',xmdcseq,xmdc001,xmdc062,'','',xmdc002,'',xmdc006,'',xmdc007",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#160503-00030 by whitney mark start
#   LET g_sql = " SELECT UNIQUE 'Y',xmdcseq,xmdc001,'','',xmdc002,'',xmdc006,'',xmdc007 ",
#               "   FROM asfq004_tmp1 ",
#               " WHERE xmdcent= ? ",
#               " ORDER BY xmdcseq "
#160503-00030 by whitney mark end
   #160503-00030 by whitney add start
   #170208-00015#1-s
   #LET g_sql = " SELECT UNIQUE 'Y',xmdcseq,xmdc001,imaal003,imaal004,xmdc002, ",
   LET g_sql = " SELECT UNIQUE 'Y',xmdcseq,xmdc001,xmdc062,imaal003,imaal004,xmdc002, ",
   #170208-00015#1-e
               "(SELECT inaml004 FROM inaml_t WHERE inamlent=xmdcent AND inaml001=xmdc001 AND inaml002=xmdc002 AND inaml003='"||g_dlang||"') inaml004,",
               "               xmdc006, ",
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=xmdcent AND oocal001=xmdc006 AND oocal002='"||g_dlang||"') oocal003,",
               "               xmdc007 ",
               "   FROM asfq004_tmp1 ",
               "   LEFT JOIN imaal_t ON imaalent=xmdcent AND imaal001=xmdc001 AND imaal002='"||g_dlang||"' ",
               " WHERE xmdcent= ? ",
               " ORDER BY xmdcseq "
   #160503-00030 by whitney add end
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq004_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq004_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmdc_d[l_ac].sel,g_xmdc_d[l_ac].xmdcseq,g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc062, 
       g_xmdc_d[l_ac].xmdc001_desc,g_xmdc_d[l_ac].xmdc001_desc_desc,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc002_desc, 
       g_xmdc_d[l_ac].xmdc006,g_xmdc_d[l_ac].xmdc006_desc,g_xmdc_d[l_ac].xmdc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
 
      #end add-point
 
      CALL asfq004_detail_show("'1'")
 
      CALL asfq004_xmdc_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
 
   CALL g_xmdc_d.deleteElement(g_xmdc_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmdc_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE asfq004_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL asfq004_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL asfq004_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmdc_d.getLength() > 0 THEN
      CALL asfq004_b_fill2()
   END IF
 
      CALL asfq004_filter_show('xmdcseq','b_xmdcseq')
   CALL asfq004_filter_show('xmdc001','b_xmdc001')
   CALL asfq004_filter_show('xmdc062','b_xmdc062')
   CALL asfq004_filter_show('xmdc002','b_xmdc002')
   CALL asfq004_filter_show('xmdc006','b_xmdc006')
   CALL asfq004_filter_show('xmdc007','b_xmdc007')
 
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq004_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
 
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq004_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
#160503-00030 by whitney mark start
#      CALL s_desc_get_item_desc(g_xmdc_d[l_ac].xmdc001)
#           RETURNING g_xmdc_d[l_ac].xmdc001_desc,g_xmdc_d[l_ac].xmdc001_desc_desc
#
#      CALL s_desc_get_unit_desc(g_xmdc_d[l_ac].xmdc006)
#           RETURNING g_xmdc_d[l_ac].xmdc006_desc
#      
#      CALL s_feature_description(g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002)
#           RETURNING l_success,g_xmdc_d[l_ac].xmdc002_desc
#160503-00030 by whitney mark end
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION asfq004_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xmdcseq,xmdc001,xmdc062,xmdc002,xmdc006,xmdc007
                          FROM s_detail1[1].b_xmdcseq,s_detail1[1].b_xmdc001,s_detail1[1].b_xmdc062, 
                              s_detail1[1].b_xmdc002,s_detail1[1].b_xmdc006,s_detail1[1].b_xmdc007
 
         BEFORE CONSTRUCT
                     DISPLAY asfq004_filter_parser('xmdcseq') TO s_detail1[1].b_xmdcseq
            DISPLAY asfq004_filter_parser('xmdc001') TO s_detail1[1].b_xmdc001
            DISPLAY asfq004_filter_parser('xmdc062') TO s_detail1[1].b_xmdc062
            DISPLAY asfq004_filter_parser('xmdc002') TO s_detail1[1].b_xmdc002
            DISPLAY asfq004_filter_parser('xmdc006') TO s_detail1[1].b_xmdc006
            DISPLAY asfq004_filter_parser('xmdc007') TO s_detail1[1].b_xmdc007
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xmdcseq>>----
         #Ctrlp:construct.c.filter.page1.b_xmdcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdcseq
            #add-point:ON ACTION controlp INFIELD b_xmdcseq name="construct.c.filter.page1.b_xmdcseq"
            
            #END add-point
 
 
         #----<<b_xmdc001>>----
         #Ctrlp:construct.c.filter.page1.b_xmdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdc001
            #add-point:ON ACTION controlp INFIELD b_xmdc001 name="construct.c.filter.page1.b_xmdc001"
            
            #END add-point
 
 
         #----<<b_xmdc062>>----
         #Ctrlp:construct.c.page1.b_xmdc062
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdc062
            #add-point:ON ACTION controlp INFIELD b_xmdc062 name="construct.c.filter.page1.b_xmdc062"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bmba002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdc062  #顯示到畫面上
            NEXT FIELD b_xmdc062                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_xmdc001_desc>>----
         #----<<b_xmdc001_desc_desc>>----
         #----<<b_xmdc002>>----
         #Ctrlp:construct.c.filter.page1.b_xmdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdc002
            #add-point:ON ACTION controlp INFIELD b_xmdc002 name="construct.c.filter.page1.b_xmdc002"
            
            #END add-point
 
 
         #----<<b_xmdc002_desc>>----
         #----<<b_xmdc006>>----
         #Ctrlp:construct.c.filter.page1.b_xmdc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdc006
            #add-point:ON ACTION controlp INFIELD b_xmdc006 name="construct.c.filter.page1.b_xmdc006"
            
            #END add-point
 
 
         #----<<b_xmdc006_desc>>----
         #----<<b_xmdc007>>----
         #Ctrlp:construct.c.filter.page1.b_xmdc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdc007
            #add-point:ON ACTION controlp INFIELD b_xmdc007 name="construct.c.filter.page1.b_xmdc007"
            
            #END add-point
 
 
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL asfq004_filter_show('xmdcseq','b_xmdcseq')
   CALL asfq004_filter_show('xmdc001','b_xmdc001')
   CALL asfq004_filter_show('xmdc062','b_xmdc062')
   CALL asfq004_filter_show('xmdc002','b_xmdc002')
   CALL asfq004_filter_show('xmdc006','b_xmdc006')
   CALL asfq004_filter_show('xmdc007','b_xmdc007')
 
 
   CALL asfq004_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION asfq004_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
 
{</section>}
 
{<section id="asfq004.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq004_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = asfq004_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="asfq004.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION asfq004_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION asfq004_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_xmdc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmdc_d.getLength() AND g_xmdc_d.getLength() > 0
            LET g_detail_idx = g_xmdc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmdc_d.getLength() THEN
               LET g_detail_idx = g_xmdc_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004.mask_functions" >}
 &include "erp/asf/asfq004_mask.4gl"
 
{</section>}
 
{<section id="asfq004.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 控制QBE欄位可否輸入
# Memo...........:
# Usage..........: CALL asfq004_set_entry()
# Input parameter: no
# Return code....: no
# Date & Author..: 140829 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_set_entry()

   CALL cl_set_comp_entry("con3",TRUE)

   IF tm.con1 = '2' THEN
      CALL cl_set_comp_entry("con3",FALSE)
      LET tm.con3 = ''
      DISPLAY tm.con3 TO con3
   END IF

END FUNCTION

################################################################################
# Descriptions...: 依产品资料中已勾选的项目，产生备料资讯单身
# Memo...........:
# Usage..........: CALL asfq004_maneuvers()
# Input parameter: no
# Return code....: no
# Date & Author..: 140901 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_maneuvers()
DEFINE l_success    LIKE type_t.num5
DEFINE l_ac2        LIKE type_t.num5
DEFINE l_bmba       type_g_bmba_d
DEFINE l_imae081    LIKE imae_t.imae081
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_time       DATETIME YEAR TO SECOND
DEFINE l_bmba013    LIKE bmba_t.bmba013       #150814-00009#1 add
DEFINE l_bmbb011    LIKE bmbb_t.bmbb011       #160707-00002#1 add
DEFINE l_bmbb012    LIKE bmbb_t.bmbb012       #160707-00002#1 add

   LET g_detail_idx3 = 1

   CALL g_bmba_d.clear()
   
   LET g_cnt = l_ac
   CALL cl_err_collect_init()
   LET l_time = cl_get_current()

   DELETE FROM asfq004_tmp2

#160816-00002#1-s add
   DELETE FROM asfq004_sfaa_tmp
   DELETE FROM asfq004_pmdt_tmp
   DELETE FROM asfq004_pmdo_tmp
   DELETE FROM asfq004_sfba_tmp
   DELETE FROM asfq004_pmdb_tmp
   DELETE FROM asfq004_xmdd_tmp

#效能優化Part2,將等一下FOREACH中會呼叫的FUNCTION的資料寫入Temptable
   LET g_sql = "INSERT INTO asfq004_sfaa_tmp (sfaa010,qty,sfaa013) ",
               "SELECT sfaa010,(COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),sfaa013",
               "  FROM sfaa_t",
               " WHERE sfaaent = ",g_enterprise,
               "   AND sfaasite = '",g_site,"'",
               "   AND sfaa003 <> '4'",
               "   AND sfaa057 = '1'",
               "   AND sfaastus NOT IN ('X','C','M')",
               "   AND COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0) <> 0"
   PREPARE asfq004_sfaa_ins_tmp_pre FROM g_sql               
   EXECUTE asfq004_sfaa_ins_tmp_pre
   
   LET g_sql = "INSERT INTO asfq004_pmdt_tmp (pmdt006,qty,pmdt019) ",
               "SELECT pmdt006,(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),pmdt019",
               "  FROM pmds_t,pmdt_t",
               " WHERE pmdsent = pmdtent",
               "   AND pmdssite = pmdtsite",
               "   AND pmdsdocno = pmdtdocno",
               "   AND pmdsent = ",g_enterprise,
               "   AND pmdssite = '",g_site,"'",
               "   AND pmds000 IN ('1','2','3','4')",
               "   AND pmds011 IN ('1','3','7','8','9','10')",
               "   AND pmdsstus = 'Y'",               
               "   AND COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0) <> 0"
   PREPARE asfq004_pmdt_ins_tmp_pre FROM g_sql               
   EXECUTE asfq004_pmdt_ins_tmp_pre
   
   LET g_sql = "INSERT INTO asfq004_pmdo_tmp (pmdo001,qty,pmdo004) ",
               "SELECT pmdo001,(COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),pmdo004",
               "  FROM pmdl_t,pmdo_t,pmdn_t",
               " WHERE pmdlent = pmdoent",
               "   AND pmdlsite = pmdosite",
               "   AND pmdldocno = pmdodocno",
               "   AND pmdlent = pmdnent",
               "   AND pmdlsite = pmdnsite",
               "   AND pmdldocno = pmdndocno",
               "   AND pmdoseq = pmdnseq",
               "   AND pmdlent = ",g_enterprise,
               "   AND pmdlsite = '",g_site,"'",
               "   AND pmdlstus <> 'X' AND pmdlstus <> 'C'",               
               "   AND COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0) <> 0",
               "   AND pmdn045 NOT IN ('2','3','4')"
   PREPARE asfq004_pmdo_ins_tmp_pre FROM g_sql               
   EXECUTE asfq004_pmdo_ins_tmp_pre
   
   LET g_sql = "INSERT INTO asfq004_sfba_tmp (sfba006,qty,sfba014) ",
               "SELECT sfba006,",
               "       (CASE WHEN (COALESCE(sfba017,0)=0) OR ((COALESCE(sfba017,0)-COALESCE(sfba025,0))<0)",
               "             THEN (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0))",
               "             ELSE (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)-COALESCE(sfba025,0))",
               "             END),sfba014",
               "  FROM sfaa_t,sfba_t",
               " WHERE sfaaent = sfbaent",
               "   AND sfaasite = sfbasite",
               "   AND sfaadocno = sfbadocno",
               "   AND sfaaent = ",g_enterprise,
               "   AND sfaasite = '",g_site,"'",
               "   AND sfaa003 <> '4'",
               "   AND sfaastus NOT IN ('X','C','M')",
               "   AND COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0) <> 0"
   PREPARE asfq004_sfba_ins_tmp_pre FROM g_sql               
   EXECUTE asfq004_sfba_ins_tmp_pre
   
   LET g_sql = "INSERT INTO asfq004_pmdb_tmp (pmdb004,qty,pmdb007) ",
               "SELECT pmdb004,(COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),pmdb007",
               "  FROM pmda_t,pmdb_t",
               " WHERE pmdaent   = pmdbent",
               "   AND pmdasite  = pmdbsite",
               "   AND pmdadocno = pmdbdocno",
               "   AND pmdaent   = ",g_enterprise,
               "   AND pmdasite  = '",g_site,"'",
               "   AND pmdastus <> 'X' AND pmdastus <> 'C'",
               "   AND COALESCE(pmdb006,0) <> COALESCE(pmdb049,0)",
               "   AND pmdb032 NOT IN ('2','3','4')"
   PREPARE asfq004_pmdb_ins_tmp_pre FROM g_sql               
   EXECUTE asfq004_pmdb_ins_tmp_pre
   
   LET g_sql = "INSERT INTO asfq004_xmdd_tmp (xmdd001,qty,xmdd004) ",
               "SELECT xmdd001,(COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd034,0)+COALESCE(xmdd016,0)),xmdd004",  #160824-00063#1 mod
               "  FROM xmda_t,xmdd_t,xmdc_t",
               " WHERE xmdaent = xmddent",
               "   AND xmdasite = xmddsite",
               "   AND xmdadocno = xmdddocno",
               "   AND xmdaent = xmdcent",
               "   AND xmdasite = xmdcsite",
               "   AND xmdadocno = xmdcdocno",
               "   AND xmddseq = xmdcseq",
               "   AND xmdaent = ",g_enterprise,
               "   AND xmdasite = '",g_site,"'",
               "   AND xmdastus = 'Y'",
               "   AND COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd015,0)+COALESCE(xmdd016,0) <> 0",
               "   AND xmdc045 NOT IN ('2','3','4')"
   PREPARE asfq004_xmdd_ins_tmp_pre FROM g_sql               
   EXECUTE asfq004_xmdd_ins_tmp_pre
#160816-00002#1-e add

#160816-00002#2-s add
   #將#160816-00002#1在MAIN段定義抓Temptable資料的CURSOR搬到FUNCTION asfq004_maneuvers()
   #FUNCTION asfq004_sfaa()的sfaa_cur CURSOR
   LET g_sql = "SELECT qty,sfaa013 FROM asfq004_sfaa_tmp WHERE sfaa010=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE sfaa_pre FROM g_sql
   DECLARE sfaa_cur CURSOR FOR sfaa_pre

   #FUNCTION asfq004_pmdt()的pmdt_cur CURSOR
   LET g_sql = "SELECT qty,pmdt019 FROM asfq004_pmdt_tmp WHERE pmdt006=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE pmdt_pre FROM g_sql
   DECLARE pmdt_cur CURSOR FOR pmdt_pre
   
   #FUNCTION asfq004_pmdo()的pmdo_cur CURSOR
   LET g_sql = "SELECT qty,pmdo004 FROM asfq004_pmdo_tmp WHERE pmdo001=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE pmdo_pre FROM g_sql
   DECLARE pmdo_cur CURSOR FOR pmdo_pre

   #FUNCTION asfq004_sfba()的sfba_cur CURSOR
   LET g_sql = "SELECT qty,sfba014 FROM asfq004_sfba_tmp WHERE sfba006=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE sfba_pre FROM g_sql
   DECLARE sfba_cur CURSOR FOR sfba_pre
   
   #FUNCTION asfq004_pmdb()的pmdb_cur CURSOR
   LET g_sql = "SELECT qty,pmdb007 FROM asfq004_pmdb_tmp WHERE pmdb004=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE pmdb_pre FROM g_sql
   DECLARE pmdb_cur CURSOR FOR pmdb_pre

   #FUNCTION asfq004_xmdd()的xmdd_cur CURSOR
   LET g_sql = "SELECT qty,xmdd004 FROM asfq004_xmdd_tmp WHERE xmdd001=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE xmdd_pre FROM g_sql
   DECLARE xmdd_cur CURSOR FOR xmdd_pre
   
   #FUNCTION asfq004_get_inag008()的inag_cur CURSOR
   LET g_sql = "SELECT COALESCE(inag008,0),inag007",
               "  FROM inag_t",
               " WHERE inagent = ?",
               "   AND inagsite = ?",
               "   AND inag001 = ?",
               "   AND inag010 = 'Y'"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE inag_pre FROM g_sql
   DECLARE inag_cur CURSOR FOR inag_pre
#160816-00002#2-e add   

   FOR l_ac = 1 TO g_xmdc_d.getLength()
      IF g_xmdc_d[l_ac].sel = 'Y' AND NOT cl_null(g_xmdc_d[l_ac].xmdc001) AND NOT cl_null(g_xmdc_d[l_ac].xmdc006) THEN
         CALL g_bmba.clear()
         #展bom
         CASE tm.con2
            #單階：展到第1階停止
            WHEN '1' 
               #160512-00016#14 20160527 modify by ming -----(S) 
               #CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'S','','','')
               #     RETURNING g_bmba
               CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc062,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'S','','','','N') #161027-00027#1 g_xmdc_d[l_ac].xmdc002--->xmdc062
                    RETURNING g_bmba
               #160512-00016#14 20160527 modify by ming -----(E) 
            #多階：展全階，備料資訊連同半成品
            WHEN '2'
               #160512-00016#14 20160527 modify by ming -----(S) 
               #CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'M','','','')
               #     RETURNING g_bmba
               CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc062,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'M','','','','N')#161027-00027#1 g_xmdc_d[l_ac].xmdc002--->xmdc062
                    RETURNING g_bmba
               #160512-00016#14 20160527 modify by ming -----(E) 
            #尾階：展到尾階，備料資訊只包含尾階材料
            WHEN '3' 
               #160512-00016#14 20160527 modify by ming -----(S) 
               #CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'Y','','','')
               #     RETURNING g_bmba
               CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc062,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'Y','','','','N')#161027-00027#1 g_xmdc_d[l_ac].xmdc002--->xmdc062
                    RETURNING g_bmba
               #160512-00016#14 20160527 modify by ming -----(E) 
            #依BOM展開選項：依照BOM的展開選項判斷是否展開
            WHEN '4' 
               #160512-00016#14 20160527 modify by ming -----(S) 
               #CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'W','','','')
               #     RETURNING g_bmba
               CALL s_asft300_02_bom('0',g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc062,g_xmdc_d[l_ac].xmdc006,'1','1',l_time,'W','','','','N')#161027-00027#1 g_xmdc_d[l_ac].xmdc002--->xmdc062
                    RETURNING g_bmba     
               #160512-00016#14 20160527 modify by ming -----(E) 
         END CASE
         IF g_bmba.getLength() <> 0 THEN
            FOR l_ac2 = 1 TO g_bmba.getLength()
            
               IF cl_null(g_bmba[l_ac2].bmba003) THEN
                  CONTINUE FOR
               END IF
               
#160707-00002#1-s
               INITIALIZE l_bmba.* TO NULL
               #元件料號
               LET l_bmba.bmba003 = g_bmba[l_ac2].bmba003
               
               #需求數量=生產數量*QPA(組成用量/主件底數)
               LET l_bmba.qty1 = g_xmdc_d[l_ac].xmdc007 * g_bmba[l_ac2].l_bmba011 / g_bmba[l_ac2].l_bmba012

               LET l_bmba.bmba010 = ''
               LET l_bmba013 = ''
               LET l_bmbb011 = 0
               LET l_bmbb012 = 0
               #抓取BOM的資料
               SELECT bmba010,bmba013,bmbb011,bmbb012
                 INTO l_bmba.bmba010,l_bmba013,l_bmbb011,l_bmbb012
                 FROM bmba_t
                 LEFT OUTER JOIN bmbb_t ON bmbbent = bmbaent AND bmbbsite = bmbasite
                                       AND bmbb001 = bmba001 AND bmbb002 = bmba002 AND bmbb003 = bmba003
                                       AND bmbb004 = bmba004 AND bmbb005 = bmba005 AND bmbb007 = bmba007
                                       AND bmbb008 = bmba008 AND ((bmbb009 <= l_bmba.qty1 AND bmbb010 IS NULL) OR
                                                                  (bmbb009 <= l_bmba.qty1 AND bmbb010 >= l_bmba.qty1))
                WHERE bmbaent = g_enterprise AND bmbasite = g_site
                  AND bmba001 = g_bmba[l_ac2].bmba001 AND bmba002 = g_bmba[l_ac2].bmba002
                  AND bmba003 = g_bmba[l_ac2].bmba003 AND bmba004 = g_bmba[l_ac2].bmba004
                  AND bmba005 = g_bmba[l_ac2].bmba005
                  AND bmba007 = g_bmba[l_ac2].bmba007 AND bmba008 = g_bmba[l_ac2].bmba008
               IF cl_null(l_bmbb011) THEN LET l_bmbb011 = 0 END IF
               IF cl_null(l_bmbb012) THEN LET l_bmbb012 = 0 END IF
#160707-00002#1-e

               #150814-00009#1 add---start---
               IF tm.con4 = 'N' THEN
#160707-00002#1-s
#拉到前面的SQL一起抓
#                  LET l_bmba013 = ''
#                  SELECT bmba013 INTO l_bmba013 FROM bmba_t
#                   WHERE bmbaent = g_enterprise AND bmbasite = g_site
#                     AND bmba001 = g_bmba[l_ac2].bmba001
#                     AND bmba003 = g_bmba[l_ac2].bmba003
#160707-00002#1-e
                  IF l_bmba013 = '4' THEN
                     CONTINUE FOR
                  END IF
               END IF
               #150814-00009#1 add---end---
#160707-00002#1-s
#拉到前面
#               INITIALIZE l_bmba.* TO NULL
#               #元件料號
#               LET l_bmba.bmba003 = g_bmba[l_ac2].bmba003
#拉到前面的SQL一起抓               
#               #發料單位
#               SELECT bmba010 INTO l_bmba.bmba010 FROM bmba_t
#                WHERE bmbaent = g_enterprise AND bmbasite = g_site
#                  AND bmba001 = g_bmba[l_ac2].bmba001
#                  AND bmba002 = g_bmba[l_ac2].bmba002
#                  AND bmba003 = g_bmba[l_ac2].bmba003
#                  AND bmba004 = g_bmba[l_ac2].bmba004
#                  AND bmba005 = g_bmba[l_ac2].bmba005
#                  AND bmba007 = g_bmba[l_ac2].bmba007
#                  AND bmba008 = g_bmba[l_ac2].bmba008
#160707-00002#1-e
              #抓元件料件主檔設定的發料單位
               LET l_imae081 = ''
               SELECT imae081 INTO l_imae081
                 FROM imae_t
                WHERE imaeent = g_enterprise
                  AND imaesite = g_site
                  AND imae001 = l_bmba.bmba003
               IF cl_null(l_imae081) THEN
                  LET l_imae081 = l_bmba.bmba010
               END IF                       
               
               #需求數量=生產數量*QPA(組成用量/主件底數)
               LET l_bmba.qty1 = g_xmdc_d[l_ac].xmdc007 * g_bmba[l_ac2].l_bmba011 / g_bmba[l_ac2].l_bmba012
#160707-00002#1-s
               #需求數量應加上BOM的外加損秏率數量
               LET l_bmba.qty1 = l_bmba.qty1 + (l_bmba.qty1 * l_bmbb011/100 + l_bmbb012)
#160707-00002#1-e
               CALL s_aooi250_convert_qty(l_bmba.bmba003,l_bmba.bmba010,l_imae081,l_bmba.qty1)
                    RETURNING l_success,l_bmba.qty1
               
               #庫存可用量=取该料+料件特征所有库储批的库存可用量合计
#               CALL s_inventory_get_inag008(g_site,l_bmba.bmba003,l_imae081)
#                    RETURNING l_success,l_bmba.qty2
               CALL asfq004_get_inag008(l_bmba.bmba003,l_imae081) RETURNING l_bmba.qty2
                    
               #備置量=
               LET l_bmba.qty3 = 0
               
               #在揀量=取该料+料件特征所有库储批的在拣量合计
               LET l_bmba.qty4 = 0
               CALL s_inventory_get_inan010_2(g_site,l_bmba.bmba003,' ',' ',' ',' ',' ',l_imae081)
                    RETURNING l_success,l_bmba.qty4
               
               #可用餘量=库存可用量-在检量-备置量
               LET l_bmba.qty5 = l_bmba.qty2 - l_bmba.qty3 - l_bmba.qty4
               
               #受訂量
               CALL asfq004_xmdd(l_bmba.bmba003,l_imae081) RETURNING l_bmba.qty13
               
               #工單預計備料量=取所有已发放但尚未发料的工单备料数量
               CALL asfq004_sfba(l_bmba.bmba003,l_imae081) RETURNING l_bmba.qty6 
               
               #請購量=已確認的請購單之單身需求數量-已轉採購量 
               CALL asfq004_pmdb(l_bmba.bmba003,l_imae081) RETURNING l_bmba.qty7
               
               #在途量=已采购发出、尚未收货确认的数量
               CALL asfq004_pmdo(l_bmba.bmba003,l_imae081) RETURNING l_bmba.qty8
               
               #在驗量=已收货但尚未入库的数量
               CALL asfq004_pmdt(l_bmba.bmba003,l_imae081) RETURNING l_bmba.qty9
               
               #在制量=取已发料的工单生产数量-完工入库数量
               CALL asfq004_sfaa(l_bmba.bmba003,l_imae081) RETURNING l_bmba.qty10

               #預計可用量=库存可用量-受订量-工单预计备料量+在途量+在验量+在制量+請購量 
               LET l_bmba.qty11 = l_bmba.qty2 - l_bmba.qty13 - l_bmba.qty6 + l_bmba.qty8
                                              + l_bmba.qty9 + l_bmba.qty10 + l_bmba.qty7

               #判斷若元件已經存在temptable終究只更新累加需求量
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM asfq004_tmp2
                WHERE bmba003 = l_bmba.bmba003
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN      
                  INSERT INTO asfq004_tmp2(bmba003,bmba010,qty1,qty2,qty3,qty4,qty5,
                                           qty13,qty6,qty7,qty8,qty9,qty10,qty11,qty12)
                         VALUES(l_bmba.bmba003,l_imae081,l_bmba.qty1,l_bmba.qty2,l_bmba.qty3,l_bmba.qty4,
                                l_bmba.qty5,l_bmba.qty13,l_bmba.qty6,l_bmba.qty7,
                                l_bmba.qty8,l_bmba.qty9,l_bmba.qty10,l_bmba.qty11,0)
               ELSE
                   UPDATE asfq004_tmp2
                      SET qty1 = qty1 + l_bmba.qty1
                    WHERE bmba003 = l_bmba.bmba003
               END IF 
            END FOR
         END IF
      END IF
   END FOR

   LET l_ac = 1
   DECLARE asfq004_maneuvers_cur CURSOR FOR
      SELECT bmba003,bmba010,SUM(qty1),SUM(qty2),SUM(qty3),SUM(qty4),SUM(qty5),SUM(qty13),
             SUM(qty6),SUM(qty7),SUM(qty8),SUM(qty9),SUM(qty10),SUM(qty11),SUM(qty12)
        FROM asfq004_tmp2
       GROUP BY bmba003,bmba010
   FOREACH asfq004_maneuvers_cur INTO g_bmba_d[l_ac].bmba003,g_bmba_d[l_ac].bmba010,g_bmba_d[l_ac].qty1 ,
                     g_bmba_d[l_ac].qty2 ,g_bmba_d[l_ac].qty3 ,g_bmba_d[l_ac].qty4 ,g_bmba_d[l_ac].qty5 ,
                     g_bmba_d[l_ac].qty13,g_bmba_d[l_ac].qty6 ,g_bmba_d[l_ac].qty7 ,g_bmba_d[l_ac].qty8 ,
                     g_bmba_d[l_ac].qty9 ,g_bmba_d[l_ac].qty10,g_bmba_d[l_ac].qty11,g_bmba_d[l_ac].qty12
      #元件料號
      CALL s_desc_get_item_desc(g_bmba_d[l_ac].bmba003)
           RETURNING g_bmba_d[l_ac].bmba003_desc,g_bmba_d[l_ac].bmba003_desc_desc
      #發料單位
      CALL s_desc_get_unit_desc(g_bmba_d[l_ac].bmba010) RETURNING g_bmba_d[l_ac].bmba010_desc
      
      #重新計算預計可用量
      LET g_bmba_d[l_ac].qty11 = g_bmba_d[l_ac].qty2 - g_bmba_d[l_ac].qty13 - g_bmba_d[l_ac].qty6 
                                                     + g_bmba_d[l_ac].qty8  + g_bmba_d[l_ac].qty9
                                                     + g_bmba_d[l_ac].qty10 + g_bmba_d[l_ac].qty7
      #預計結存量
      LET g_bmba_d[l_ac].qty12 = g_bmba_d[l_ac].qty11 - g_bmba_d[l_ac].qty1
      
      CASE
         #可用余量>=本次预计需求量时为状态1.是
         WHEN g_bmba_d[l_ac].qty11 >= g_bmba_d[l_ac].qty1
            LET g_bmba_d[l_ac].stus = '1'
         #可用余量<本次预计需求量时为状态2.否
         WHEN g_bmba_d[l_ac].qty11 < g_bmba_d[l_ac].qty1
            LET g_bmba_d[l_ac].stus = '2'
         OTHERWISE EXIT CASE
      END CASE
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_bmba_d.deleteElement(g_bmba_d.getLength())  #170208-00015#1
   LET g_detail_cnt3 = l_ac - 1
   LET l_ac = g_cnt
   LET g_cnt = 0

   CALL cl_err_collect_show()
   
   CALL asfq004_insert_rep()  #fengmy141203
END FUNCTION

################################################################################
# Descriptions...: 在製量=生產數量-已入庫合格量-已入庫不合格量
# Memo...........:
# Usage..........: CALL asfq004_sfaa(p_bmba003,p_bmba010)
#                  RETURNING r_qty
# Input parameter: p_bmba003   料號
#                : p_bmba010   單位
# Return code....: r_qty   在製量
# Date & Author..: 140903 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_sfaa(p_bmba003,p_bmba010)
DEFINE p_bmba003  LIKE bmba_t.bmba003
DEFINE p_bmba010  LIKE bmba_t.bmba010
DEFINE r_qty      LIKE sfaa_t.sfaa012
DEFINE l_qty      LIKE sfaa_t.sfaa012
DEFINE l_unit     LIKE sfaa_t.sfaa013
DEFINE l_success  LIKE type_t.num5

   LET r_qty = 0

   LET l_qty = ''
   LET l_unit = ''
   
#160816-00002#1-s mark
#   DECLARE sfaa_cur CURSOR FOR
##150104 by whitney modify start
##    SELECT (sfaa012-sfaa051-sfaa052),sfaa013
##      FROM sfaa_t
##     WHERE sfaaent = g_enterprise
##       AND sfaasite = g_site
##       AND sfaastus = 'F'
##       AND sfaa010 = p_bmba003
##       AND sfaa049 > 0  #已發料套數
#    SELECT (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),sfaa013
#      FROM sfaa_t
#     WHERE sfaaent = g_enterprise
#       AND sfaasite = g_site
#       AND sfaa010 = p_bmba003
#       AND sfaa003 <> '4'
#       AND sfaa057 = '1'
#       AND sfaastus NOT IN ('X','C','M')
#       AND COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0) <> 0
##150104 by whitney modify end
#160816-00002#1-e mark
#160816-00002#1-s mod
#  FOREACH sfaa_cur INTO l_qty,l_unit   
   FOREACH sfaa_cur USING p_bmba003 INTO l_qty,l_unit
#160816-00002#1-e mod
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF
      
      #换算成发料单位数量
      IF NOT cl_null(l_unit) AND NOT cl_null(p_bmba010) THEN
         CALL s_aooi250_convert_qty(p_bmba003,l_unit,p_bmba010,l_qty)
              RETURNING l_success,l_qty
      END IF
      
      LET r_qty = r_qty + l_qty
      
      LET l_qty = ''
      LET l_unit = ''
   END FOREACH

   RETURN r_qty

END FUNCTION

################################################################################
# Descriptions...: 在驗量=收貨量-已入庫量-已驗退量
# Memo...........:
# Usage..........: CALL asfq004_pmdt(p_bmba003,p_bmba010)
#                  RETURNING r_qty
# Input parameter: p_bmba003   料號
#                : p_bmba010   單位
# Return code....: r_qty   在驗量
# Date & Author..: 140903 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_pmdt(p_bmba003,p_bmba010)
DEFINE p_bmba003  LIKE bmba_t.bmba003
DEFINE p_bmba010  LIKE bmba_t.bmba010
DEFINE r_qty      LIKE sfaa_t.sfaa012
DEFINE l_qty      LIKE sfaa_t.sfaa012
DEFINE l_unit     LIKE sfaa_t.sfaa013
DEFINE l_success  LIKE type_t.num5

   LET r_qty = 0

   LET l_qty = ''
   LET l_unit = ''
  
#160816-00002#1-s mark
#   DECLARE pmdt_cur CURSOR FOR
##150104 by whitney modify start
##    SELECT (pmdt020-pmdt054-pmdt055),pmdt019
##      FROM pmds_t,pmdt_t
##     WHERE pmdsent = pmdtent
##       AND pmdsdocno = pmdtdocno
##       AND pmdsent = g_enterprise
##       AND pmdssite = g_site
##       AND pmdsstus = 'S'
##       AND pmdt006 = p_bmba003
##       AND (pmdt020-pmdt054-pmdt055) > 0
#    SELECT (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),pmdt019
#      FROM pmds_t,pmdt_t
#     WHERE pmdsent = pmdtent
#       AND pmdssite = pmdtsite
#       AND pmdsdocno = pmdtdocno
#       AND pmdsent = g_enterprise
#       AND pmdssite = g_site
#       AND pmds000 IN ('1','2','3','4')
#       AND pmds011 IN ('1','3','7','8','9','10')
#       AND pmdsstus = 'Y'
#       AND pmdt006 = p_bmba003
#       AND COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0) <> 0
##150104 by whitney modify end
#160816-00002#1-e mark
#160816-00002#1-s mod
#  FOREACH pmdt_cur INTO l_qty,l_unit
   FOREACH pmdt_cur USING p_bmba003 INTO l_qty,l_unit
#160816-00002#1-e mod
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF
      
      #换算成发料单位数量
      IF NOT cl_null(l_unit) AND NOT cl_null(p_bmba010) THEN
         CALL s_aooi250_convert_qty(p_bmba003,l_unit,p_bmba010,l_qty)
              RETURNING l_success,l_qty
      END IF
      
      LET r_qty = r_qty + l_qty
      
      LET l_qty = ''
      LET l_unit = ''
   END FOREACH

   RETURN r_qty

END FUNCTION

################################################################################
# Descriptions...: 在途量=採購量-已收貨量
# Memo...........:
# Usage..........: CALL asfq004_pmdo(p_bmba003,p_bmba010)
#                  RETURNING r_qty
# Input parameter: p_bmba003   料號
#                : p_bmba010   單位
# Return code....: r_qty   在途量
# Date & Author..: 140903 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_pmdo(p_bmba003,p_bmba010)
DEFINE p_bmba003  LIKE bmba_t.bmba003
DEFINE p_bmba010  LIKE bmba_t.bmba010
DEFINE r_qty      LIKE sfaa_t.sfaa012
DEFINE l_qty      LIKE sfaa_t.sfaa012
DEFINE l_unit     LIKE sfaa_t.sfaa013
DEFINE l_success  LIKE type_t.num5

   LET r_qty = 0

   LET l_qty = ''
   LET l_unit = ''
  
#160816-00002#1-s mark
#   DECLARE pmdo_cur CURSOR FOR
##150104 by whitney modify start
##      SELECT (pmdo006-pmdo015),pmdo004
##        FROM pmdl_t,pmdo_t
##       WHERE pmdlent = pmdoent
##         AND pmdldocno = pmdodocno
##         AND pmdlent = g_enterprise
##         AND pmdlsite = g_site
##         AND pmdlstus = 'Y'
##         AND pmdo001 = p_bmba003
##         AND (pmdo006 - pmdo015) > 0
#      SELECT (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),pmdo004
#        FROM pmdl_t,pmdo_t,pmdn_t
#       WHERE pmdlent = pmdoent
#         AND pmdlsite = pmdosite
#         AND pmdldocno = pmdodocno
#         AND pmdlent = pmdnent
#         AND pmdlsite = pmdnsite
#         AND pmdldocno = pmdndocno
#         AND pmdoseq = pmdnseq
#         AND pmdlent = g_enterprise
#         AND pmdlsite = g_site
#         AND pmdlstus <> 'X' AND pmdlstus <> 'C'
#         AND pmdo001 = p_bmba003
#         AND COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0) <> 0
#         AND pmdn045 NOT IN ('2','3','4')
##150104 by whitney modify end
#160816-00002#1-e mark
#160816-00002#1-s mod
#  FOREACH pmdo_cur INTO l_qty,l_unit
   FOREACH pmdo_cur USING p_bmba003 INTO l_qty,l_unit
#160816-00002#1-e mod
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF
      
      #换算成发料单位数量
      IF NOT cl_null(l_unit) AND NOT cl_null(p_bmba010) THEN
         CALL s_aooi250_convert_qty(p_bmba003,l_unit,p_bmba010,l_qty)
              RETURNING l_success,l_qty
      END IF
      
      LET r_qty = r_qty + l_qty
      
      LET l_qty = ''
      LET l_unit = ''
   END FOREACH

   RETURN r_qty

END FUNCTION

################################################################################
# Descriptions...: 工單預計備料量=應發數量-已發數量
# Memo...........:
# Usage..........: CALL asfq004_sfba(p_bmba003,p_bmba010)
#                  RETURNING r_qty
# Input parameter: p_bmba003   料號
#                : p_bmba010   單位
# Return code....: r_qty   工單預計備料量
# Date & Author..: 140903 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_sfba(p_bmba003,p_bmba010)
DEFINE p_bmba003  LIKE bmba_t.bmba003
DEFINE p_bmba010  LIKE bmba_t.bmba010
DEFINE r_qty      LIKE sfaa_t.sfaa012
DEFINE l_qty      LIKE sfaa_t.sfaa012
DEFINE l_unit     LIKE sfaa_t.sfaa013
DEFINE l_success  LIKE type_t.num5

   LET r_qty = 0

   LET l_qty = ''
   LET l_unit = ''

#160816-00002#1-s mark
#   DECLARE sfba_cur CURSOR FOR
##150104 by whitney modify start
##      SELECT (sfba013-sfba016),sfba014
##        FROM sfaa_t,sfba_t
##       WHERE sfaaent = sfbaent
##         AND sfaadocno =  sfbadocno
##         AND sfaaent = g_enterprise
##         AND sfaasite = g_site
##         AND sfaastus = 'F'
##         AND sfba006 = p_bmba003
##         AND (sfba013 - sfba016) > 0
#      #若有報廢量>0,备料量=應發量 - 已發量 -委外代買量 + 報廢量 - 超領量 
#      #若報廢量=0，备料量=應發量 - 已發量 -委外代買量
#      SELECT (CASE WHEN (COALESCE(sfba017,0)=0) OR ((COALESCE(sfba017,0)-COALESCE(sfba025,0))<0)
#                   THEN (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0))
#                   ELSE (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)-COALESCE(sfba025,0))
#                    END),sfba014
#        FROM sfaa_t,sfba_t
#       WHERE sfaaent = sfbaent
#         AND sfaasite = sfbasite
#         AND sfaadocno = sfbadocno
#         AND sfaaent = g_enterprise
#         AND sfaasite = g_site
#         AND sfba006 = p_bmba003
#         AND sfaa003 <> '4'
##         AND sfaa057 = '1'  #150710 by whitney mark
#         AND sfaastus NOT IN ('X','C','M')
#         AND COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0) <> 0
##150104 by whitney modify end
#160816-00002#1-e mark
#160816-00002#1-s mod
#  FOREACH sfba_cur INTO l_qty,l_unit
   FOREACH sfba_cur USING p_bmba003 INTO l_qty,l_unit
#160816-00002#1-e mod
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF
      
      #换算成发料单位数量
      IF NOT cl_null(l_unit) AND NOT cl_null(p_bmba010) THEN
         CALL s_aooi250_convert_qty(p_bmba003,l_unit,p_bmba010,l_qty)
              RETURNING l_success,l_qty
      END IF
      
      LET r_qty = r_qty + l_qty
      
      LET l_qty = ''
      LET l_unit = ''
   END FOREACH

   RETURN r_qty

END FUNCTION

################################################################################
# Descriptions...: 單身資料插入暫存檔
# Memo...........:
# Usage..........: CALL asfq004_insert_rep()
# Input parameter: no
# Return code....: no
# Date & Author..: 141203 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_insert_rep()
   DEFINE l_ac LIKE type_t.num5
   #創建報表暫存檔
   DROP TABLE asfq004_tmp01    #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp1 ——> asfq004_tmp01
   CREATE TEMP TABLE asfq004_tmp01(   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp1 ——> asfq004_tmp01
      xmdc001      VARCHAR(40),      
      xmdc002      VARCHAR(256),       
      xmdc006      VARCHAR(10),      
      xmdc007      DECIMAL(20,6)
      );
   DROP TABLE asfq004_tmp02   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp2 ——> asfq004_tmp02
   CREATE TEMP TABLE asfq004_tmp02(     #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp2 ——> asfq004_tmp02  
      bmba003      VARCHAR(40),      
      bmba010      VARCHAR(10),      
      qty1         DECIMAL(20,6),    
      qty2         DECIMAL(20,6),    
      qty3         DECIMAL(20,6),    
      qty4         DECIMAL(20,6),    
      qty5         DECIMAL(20,6),    
      qty6         DECIMAL(20,6),    
      qty7         DECIMAL(20,6),    
      qty8         DECIMAL(20,6),    
      qty9         DECIMAL(20,6),    
      qty10        DECIMAL(20,6),    
      qty11        DECIMAL(20,6),
      qty12        DECIMAL(20,6),
      qty13        DECIMAL(20,6),      
      stus         VARCHAR(1),
      bmbaent      SMALLINT
      );
   #插入資料
   #第一單身
   FOR l_ac = 1 TO g_xmdc_d.getLength()
       INSERT INTO asfq004_tmp01 VALUES(g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc062,  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp1 ——> asfq004_tmp01  #161027-00027#1 add g_xmdc_d[l_ac].xmdc062
       g_xmdc_d[l_ac].xmdc006,g_xmdc_d[l_ac].xmdc007)
   END FOR
   #第二單身
   FOR l_ac = 1 TO g_bmba_d.getLength()
       INSERT INTO asfq004_tmp02 VALUES(g_bmba_d[l_ac].bmba003,g_bmba_d[l_ac].bmba010,   #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq004_g01_tmp2 ——> asfq004_tmp02
                                           g_bmba_d[l_ac].qty1,g_bmba_d[l_ac].qty2,g_bmba_d[l_ac].qty3,
                                           g_bmba_d[l_ac].qty4,g_bmba_d[l_ac].qty5,g_bmba_d[l_ac].qty6,
                                           g_bmba_d[l_ac].qty7,g_bmba_d[l_ac].qty8,g_bmba_d[l_ac].qty9,
                                           g_bmba_d[l_ac].qty10,g_bmba_d[l_ac].qty11,g_bmba_d[l_ac].qty12,
                                           g_bmba_d[l_ac].qty13,g_bmba_d[l_ac].stus,g_enterprise)
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 請購量=請購需求數量-已轉採購量
# Memo...........:
# Usage..........: CALL asfq004_pmdb(p_bmba003,p_bmba010)
#                  RETURNING r_qty
# Input parameter: p_bmba003：料號
#                : p_bmba010：單位
# Return code....: r_qty：請購量
# Date & Author..: 2014/12/31 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_pmdb(p_bmba003,p_bmba010)
   DEFINE p_bmba003     LIKE bmba_t.bmba003     #料號  
   DEFINE p_bmba010     LIKE bmba_t.bmba010     #單位  
   DEFINE r_qty         LIKE sfaa_t.sfaa012     #請購量  
   DEFINE l_qty         LIKE sfaa_t.sfaa012
   DEFINE l_unit        LIKE sfaa_t.sfaa013
   DEFINE l_success     LIKE type_t.num5

   LET r_qty  = 0

   LET l_qty  = ''
   LET l_unit = ''

#160816-00002#1-s mark
#   DECLARE pmdb_curs CURSOR FOR
##150104 by whitney modify start
##      SELECT (pmdb006-pmdb049),pmdb007
##        FROM pmda_t,pmdb_t
##       WHERE pmdaent   = pmdbent
##         AND pmdadocno = pmdbdocno
##         AND pmdaent   = g_enterprise
##         AND pmdasite  = g_site
##         AND pmdastus  = 'Y'            #已確認的請購單  
##         AND pmdb004   = p_bmba003 
##         AND (pmdb006 - pmdb049) > 0
#      SELECT (COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),pmdb007
#        FROM pmda_t,pmdb_t
#       WHERE pmdaent   = pmdbent
#         AND pmdasite  = pmdbsite
#         AND pmdadocno = pmdbdocno
#         AND pmdaent   = g_enterprise
#         AND pmdasite  = g_site
#         AND pmdb004   = p_bmba003 
#         AND pmdastus <> 'X' AND pmdastus <> 'C'
#         AND COALESCE(pmdb006,0) <> COALESCE(pmdb049,0)
#         AND pmdb032 NOT IN ('2','3','4')
##150104 by whitney modify end
#160816-00002#1-e mark
#160816-00002#1-s mod
#  FOREACH pmdb_cur INTO l_qty,l_unit
   FOREACH pmdb_cur USING p_bmba003 INTO l_qty,l_unit
#160816-00002#1-e mod
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF

      #換算成發料單位數量 
      IF NOT cl_null(l_unit) AND NOT cl_null(p_bmba010) THEN
         CALL s_aooi250_convert_qty(p_bmba003,l_unit,p_bmba010,l_qty)
              RETURNING l_success,l_qty
      END IF

      LET r_qty = r_qty + l_qty

      LET l_qty  = ''
      LET l_unit = ''
   END FOREACH

   RETURN r_qty
END FUNCTION

################################################################################
# Descriptions...: 受订量 ＝ 订单数量 - 已出货量
# Memo...........:
# Usage..........: CALL asfq004_xmdd(p_bmba003,p_bmba010)
#                  RETURNING 回传参数
# Input parameter: p_bmba003   料号   
#                : p_bmba010   单位   
# Return code....: r_qty       受订量
# Date & Author..: 150101 By pengu
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_xmdd(p_bmba003,p_bmba010)
DEFINE p_bmba003  LIKE bmba_t.bmba003
DEFINE p_bmba010  LIKE bmba_t.bmba010
DEFINE r_qty      LIKE sfaa_t.sfaa012
DEFINE l_qty      LIKE sfaa_t.sfaa012
DEFINE l_unit     LIKE sfaa_t.sfaa013
DEFINE l_success  LIKE type_t.num5

  LET r_qty = 0

   LET l_qty = ''
   LET l_unit = ''
  
#160816-00002#1-s mark
#   DECLARE xmdd_cur CURSOR FOR
##150104 by whitney modify start
##      SELECT (xmdd006-xmdd014+xmdd016),xmdd004
##        FROM xmda_t,xmdd_t
##       WHERE xmdaent = xmddent
##         AND xmdadocno = xmdddocno
##         AND xmdaent = g_enterprise
##         AND xmdasite = g_site
##         AND xmdastus = 'Y'
##         AND xmdd001 = p_bmba003
##         AND (xmdd006-xmdd014+xmdd016) > 0
#      #xmdd006(訂購數量)-xmdd014(已出貨量)+xmdd016(銷退換貨數量)+xmdd034(已簽退數量)
#      SELECT (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd034,0)+COALESCE(xmdd016,0)),xmdd004
#        FROM xmda_t,xmdd_t,xmdc_t
#       WHERE xmdaent = xmddent
#         AND xmdasite = xmddsite
#         AND xmdadocno = xmdddocno
#         AND xmdaent = xmdcent
#         AND xmdasite = xmdcsite
#         AND xmdadocno = xmdcdocno
#         AND xmddseq = xmdcseq
#         AND xmdaent = g_enterprise
#         AND xmdasite = g_site
#         AND xmdastus = 'Y'
#         AND xmdd001 = p_bmba003
#         AND COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd015,0)+COALESCE(xmdd016,0) <> 0
#         AND xmdc045 NOT IN ('2','3','4')
##150104 by whitney modify end
#160816-00002#1-e mark
#160816-00002#1-s mod
#  FOREACH xmdd_cur INTO l_qty,l_unit
   FOREACH xmdd_cur USING p_bmba003 INTO l_qty,l_unit
#160816-00002#1-e mod
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF
      
      #換算成發料單位數量 
      IF NOT cl_null(l_unit) AND NOT cl_null(p_bmba010) THEN
         CALL s_aooi250_convert_qty(p_bmba003,l_unit,p_bmba010,l_qty)
              RETURNING l_success,l_qty
      END IF
      
      LET r_qty = r_qty + l_qty
      
      LET l_qty = ''
      LET l_unit = ''
   END FOREACH

   RETURN r_qty

END FUNCTION

################################################################################
# Descriptions...: 庫存可用量=取该料+料件特征所有库储批的库存可用量合计
# Memo...........:
# Usage..........: CALL asfq004_get_inag008(p_bmba003,p_bmba010)
#                  RETURNING r_qty
# Input parameter: p_bmba003   料號
#                : p_bmba010   單位
# Return code....: r_qty   庫存可用量
# Date & Author..: 150114 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq004_get_inag008(p_bmba003,p_bmba010)
DEFINE p_bmba003  LIKE bmba_t.bmba003
DEFINE p_bmba010  LIKE bmba_t.bmba010
DEFINE r_qty      LIKE sfaa_t.sfaa012
DEFINE l_qty      LIKE sfaa_t.sfaa012
DEFINE l_unit     LIKE sfaa_t.sfaa013
DEFINE l_success  LIKE type_t.num5

  LET r_qty = 0

   LET l_qty = ''
   LET l_unit = ''
  
#160816-00002#1-s mark
#   DECLARE inag_cur CURSOR FOR
#      SELECT COALESCE(inag008,0),inag007
#        FROM inag_t
#       WHERE inagent = g_enterprise
#         AND inagsite = g_site
#         AND inag001 = p_bmba003
#         AND inag010 = 'Y'
#160816-00002#1-e mark
#160816-00002#1-s mod
#  FOREACH inag_cur INTO l_qty,l_unit
   FOREACH inag_cur USING g_enterprise,g_site,p_bmba003 INTO l_qty,l_unit
#160816-00002#1-e mod
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF
      
      #換算成發料單位數量 
      IF NOT cl_null(l_unit) AND NOT cl_null(p_bmba010) THEN
         CALL s_aooi250_convert_qty(p_bmba003,l_unit,p_bmba010,l_qty)
              RETURNING l_success,l_qty
      END IF
      
      LET r_qty = r_qty + l_qty
      
      LET l_qty = ''
      LET l_unit = ''
   END FOREACH

   RETURN r_qty

END FUNCTION

 
{</section>}
 
