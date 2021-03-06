#該程式未解開Section, 採用最新樣板產出!
{<section id="axmq140.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2017-04-21 10:56:37), PR版次:0001(2017-04-21 11:14:11)
#+ Customerized Version.: SD版次:(), PR版次:0001(1900-01-01 00:00:00)
#+ Build......: 000071
#+ Filename...: axmq140
#+ Description: 信用額度查詢作業
#+ Creator....: 04441(2015-03-13 10:45:47)
#+ Modifier...: TOPSTD -SD/PR- TOPSTD
 
{</section>}
 
{<section id="axmq140.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
#160826-00035#1   16/08/29 By charles4m   明細過濾了重複資料，導致額度彙總金額與明細不一致
#160816-00043#1   16/09/02 By 02097       專案明細、耗用明細頁籤，都增加項次的顯示
#161215-00012#1   16/12/27 By 08993       原畫面為"明細資料"頁籤，另增加一個"匯總資料"頁籤使用清單方式呈現呈現欄位：客戶編號、客戶簡稱、額度對象、額度對象簡稱、額度幣別、信用額度、over due、逾期未兌現票據、計算項目(橫向呈現S1,S2,S3.....)、額度耗用金額、信用餘額
#170310-00011#1   17/03/20 By 08993       修改查询的资料【明细页签】下的【额度耗用金额】栏位没有资料的問題(axmq140規格也有做修改)
#170413-00051#1   By   dorislai   1.修正【匯總資料】頁籤下【信用額度餘額】欄位金額不正確的問題
#                                 2.單頭【額度耗用金額】欄位名稱更改為【信用額度餘額】
#                                 3.隱藏【匯總資料】頁籤下的信用餘額
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       pmab001 LIKE type_t.chr10, 
   pmab001_desc LIKE type_t.chr80, 
   xmac001 LIKE type_t.chr10, 
   xmac001_desc LIKE type_t.chr80, 
   xmac002 LIKE type_t.chr10, 
   xmac002_desc LIKE type_t.chr80, 
   xmac003 LIKE type_t.num20_6, 
   xmac004 LIKE type_t.num20_6, 
   chk1 LIKE type_t.chr1, 
   chk2 LIKE type_t.chr1
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   xmaa002 LIKE type_t.chr10, 
   xmaa004 LIKE type_t.chr1, 
   xmaa005 LIKE type_t.num20_6, 
   money1 LIKE type_t.num20_6, 
   money2 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

 TYPE type_g_detail2 RECORD
   xmab003      LIKE xmab_t.xmab003, 
   xmab004      LIKE xmab_t.xmab004,      #160816-00043#1
   xmab005      LIKE xmab_t.xmab005, 
   xmab005_desc LIKE ooefl_t.ooefl003, 
   xmab006      LIKE xmab_t.xmab006, 
   xmab006_desc LIKE pmaal_t.pmaal004, 
   xmab007      LIKE xmab_t.xmab007, 
   xmab007_desc LIKE ooail_t.ooail003, 
   xmab008      LIKE xmab_t.xmab008, 
   xmab008_desc LIKE pmaal_t.pmaal004, 
   xmab009      LIKE xmab_t.xmab009, 
   xmab013      LIKE xmab_t.xmab013, 
   xmab010      LIKE xmab_t.xmab010
       END RECORD
 
 TYPE type_g_detail3 RECORD
   xmaa002      LIKE xmaa_t.xmaa002, 
   xmab003      LIKE xmab_t.xmab003, 
   xmab004      LIKE xmab_t.xmab004,      #160816-00043#1
   xmab005      LIKE xmab_t.xmab005, 
   xmab005_desc LIKE ooefl_t.ooefl003, 
   xmab006      LIKE xmab_t.xmab006, 
   xmab006_desc LIKE pmaal_t.pmaal004, 
   xmab007      LIKE xmab_t.xmab007, 
   xmab007_desc LIKE ooail_t.ooail003, 
   xmab008      LIKE xmab_t.xmab008, 
   xmab008_desc LIKE pmaal_t.pmaal004, 
   xmab009      LIKE xmab_t.xmab009, 
   xmab013      LIKE xmab_t.xmab013, 
   money1       LIKE xmab_t.xmab009, 
   xmaa004      LIKE xmaa_t.xmaa004, 
   xmaa005      LIKE xmaa_t.xmaa005, 
   money2       LIKE xmab_t.xmab009
       END RECORD
  #161215-00012#1-s add
  TYPE type_g_detail4 RECORD
   pmab001_1        LIKE pmab_t.pmab001,  
   pmab001_desc_1 LIKE pmaal_t.pmaal004, 
   xmac001_1      LIKE xmac_t.xmac001,      
   xmac001_desc_1 LIKE pmaal_t.pmaal004, 
   xmac002_1      LIKE xmac_t.xmac002, 
   xmac002_desc_1 LIKE ooail_t.ooail003, 
   xmac003_1      LIKE xmac_t.xmac003, 
   chk3           LIKE type_t.chr1, 
   chk4           LIKE type_t.chr1, 
   xmac041        LIKE xmac_t.xmac041,
   xmac042        LIKE xmac_t.xmac042, 
   xmac043        LIKE xmac_t.xmac043,
   xmac044        LIKE xmac_t.xmac044,
   xmac045        LIKE xmac_t.xmac045,
   xmac046        LIKE xmac_t.xmac046,
   xmac048        LIKE xmac_t.xmac048,
   xmac011        LIKE xmac_t.xmac011,
   xmac012        LIKE xmac_t.xmac012,
   xmac013        LIKE xmac_t.xmac013,
   xmac014        LIKE xmac_t.xmac014,
   xmac015        LIKE xmac_t.xmac015,
   xmac016        LIKE xmac_t.xmac016,
   xmac018        LIKE xmac_t.xmac018,
   xmac019        LIKE xmac_t.xmac019,
   money2_2       LIKE xmac_t.xmac004,
#  xmac004        LIKE xmac_t.xmac004    #170310-00011#1 mark
   xmac004_1        LIKE xmac_t.xmac004   #170310-00011#1 mod
       END RECORD
   #161215-00012#1-e add

DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
DEFINE g_detail3     DYNAMIC ARRAY OF type_g_detail3
DEFINE g_detail3_t   type_g_detail3
#161215-00012#1-s add
DEFINE g_detail4     DYNAMIC ARRAY OF type_g_detail4
DEFINE g_detail4_t   type_g_detail4                  
DEFINE g_detail_idx3         LIKE type_t.num10
DEFINE g_detail_idx4         LIKE type_t.num10             #161215-00012#1-s add
DEFINE g_detail_cnt2         LIKE type_t.num10
DEFINE g_detail_cnt3         LIKE type_t.num10
DEFINE g_detail_cnt4         LIKE type_t.num10             #161215-00012#1-s add
DEFINE g_chk                 LIKE type_t.chr1              #僅顯示超限資料
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關   #161215-00012#1-s add

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
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
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
DEFINE g_master_row_move     LIKE type_t.chr1              #是否為單頭筆數更動
 
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
 
{<section id="axmq140.main" >}
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
   CALL cl_ap_init("cxm","")
 
   #add-point:作業初始化 name="main.init"
   #150615 by whitney add start
   IF g_argv[01] = 'ALL' THEN
      LET g_site = 'ALL'
   END IF
   #150615 by whitney add end  
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
   DECLARE axmq140_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmq140_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmq140_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmq140 WITH FORM cl_ap_formpath("cxm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmq140_init()   
 
      #進入選單 Menu (="N")
      CALL axmq140_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmq140
      
   END IF 
   
   CLOSE axmq140_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axmq140_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmq140.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmq140_init()
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
   LET g_master_row_move = "Y"
   
      CALL cl_set_combo_scc('xmaa002','2044') 
   CALL cl_set_combo_scc('xmaa004','2045') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('pmaa002','2014')
   CALL cl_set_combo_scc('b_xmaa002','2044')
   CALL cl_set_combo_scc('b_xmaa004','2045')
   
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   
   LET g_chk = 'N'
   
   CREATE TEMP TABLE axmq140_tmp(
       pmab001    LIKE pmab_t.pmab001,
       xmac001    LIKE xmac_t.xmac001,
       xmac002    LIKE xmac_t.xmac002,
       xmac003    LIKE xmac_t.xmac003,
       xmac004    LIKE xmac_t.xmac004,
       chk1       LIKE type_t.chr1,
       chk2       LIKE type_t.chr1,
       xmacsite   LIKE xmac_t.xmacsite)
   #end add-point
 
   CALL axmq140_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axmq140.default_search" >}
PRIVATE FUNCTION axmq140_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " pmab001 = '", g_argv[02], "' AND "
   END IF

   #end add-point
 
   
 
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
 
{<section id="axmq140.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmq140_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE lb_first   BOOLEAN   #161215-00012#1-s add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CLEAR FORM  
 
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
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET lb_first = TRUE   #161215-00012#1-s add
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axmq140_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axmq140_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_chk
            ATTRIBUTE(WITHOUT DEFAULTS)
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pmaa001,pmaa002,pmab003

         ON ACTION controlp INFIELD pmaa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()
            DISPLAY g_qryparam.return1 TO pmaa001
            NEXT FIELD pmaa001

         ON ACTION controlp INFIELD pmab003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()
            DISPLAY g_qryparam.return1 TO pmab003
            NEXT FIELD pmab003

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axmq140_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axmq140_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2 TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt2)

            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx

            #自訂ACTION(detail_show,page_2)

         END DISPLAY

         DISPLAY ARRAY g_detail3 TO s_detail3.* ATTRIBUTES(COUNT=g_detail_cnt3)

            BEFORE DISPLAY
               LET g_current_page = 3

            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx3
               LET g_detail_idx3 = l_ac
               DISPLAY g_detail_idx3 TO FORMONLY.idx

            #自訂ACTION(detail_show,page_3)

         END DISPLAY
         
         #161215-00012#1-s add
         DISPLAY ARRAY g_detail4 TO s_detail4.* ATTRIBUTES(COUNT=g_detail_cnt4)
#            BEFORE ROW
#               #回歸舊筆數位置 (回到當時異動的筆數)
#               LET g_current_idx = DIALOG.getCurrentRow("s_detail4")
#               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
#                  CALL DIALOG.setCurrentRow("s_detail4",g_current_row)
#                  LET g_current_idx = g_current_row
#               END IF
#               LET g_current_row = g_current_idx #目前指標
#               LET g_current_sw = TRUE
#         
#               IF g_current_idx > g_detail4.getLength() THEN
#                  LET g_current_idx = g_detail4.getLength()
#               END IF 
#               
#               CALL axmq140_fetch('') # reload data
#
#               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
#               LET l_ac = g_detail_idx4
#               LET g_detail_idx4 = l_ac
#               DISPLAY g_detail_idx4 TO FORMONLY.idx
               

            #自訂ACTION(detail_show,page_4)
               
            BEFORE DISPLAY
               LET g_current_page = 4

            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx4
               LET g_detail_idx4 = l_ac
               DISPLAY g_detail_idx4 TO FORMONLY.idx

            #自訂ACTION(detail_show,page_4)

         END DISPLAY 
         #161215-00012#1-s add         
         
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axmq140_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD pmaa001
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
         
         
         #161215-00012#1-s add
         ON ACTION worksheet
            LET g_master.pmab001 = g_detail4[g_detail_idx4].pmab001_1
            LET g_master.xmac001 = g_detail4[g_detail_idx4].xmac001_1 
            LET g_master.xmac002 = g_detail4[g_detail_idx4].xmac002_1
            LET g_master.xmac003 = g_detail4[g_detail_idx4].xmac003_1
#           LET g_master.xmac004 = g_detail4[g_detail_idx4].xmac004    #170310-00011#1 mark
            LET g_master.xmac004 = g_detail4[g_detail_idx4].xmac004_1   #170310-00011#1 mod
            LET g_master.chk1 = g_detail4[g_detail_idx4].chk3
            LET g_master.chk2 = g_detail4[g_detail_idx4].chk4
            CALL axmq140_show()                                                 

               NEXT FIELD sel

         #161215-00012#1-e add
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
            
            #end add-point
 
            CALL axmq140_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
 
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_detail3)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_detail4)
               LET g_export_id[4]   = "s_detail4"
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axmq140_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
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
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo name="ui_dialog.datainfo"
 
            #end add-point
            CALL axmq140_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axmq140_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axmq140_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axmq140_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axmq140_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axmq140_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axmq140_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axmq140_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axmq140_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axmq140_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
 
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
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
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               
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
 
{<section id="axmq140.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axmq140_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_xmac  RECORD
       pmab001    LIKE pmab_t.pmab001,
       xmac001    LIKE xmac_t.xmac001,
       xmac002    LIKE xmac_t.xmac002,
       xmac003    LIKE xmac_t.xmac003,
       xmac004    LIKE xmac_t.xmac004,
       chk1       LIKE type_t.chr1,
       chk2       LIKE type_t.chr1,
       xmacsite   LIKE xmac_t.xmacsite
              END RECORD
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   CALL axmq140_b_fill4()   #161215-00012#1-s add
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      DELETE FROM axmq140_tmp
#150615 by whitney mark start
#      LET g_sql = " SELECT UNIQUE pmab001,xmac001,xmac002,pmab006,xmac004,pmabsite ",
#                  "   FROM xmac_t,pmab_t,pmaa_t ",
#                  "  WHERE xmacent = ",g_enterprise," AND xmacsite = '",g_site,"' ",
#                  "    AND pmabent = xmacent AND pmabsite = xmacsite AND pmab003 = xmac001 ",
#                  "    AND pmab002 IN ('2','3') ",  #信用查核
#                  "    AND pmaaent = pmabent AND pmaa001 = pmab001 ",
#                  "    AND ",g_wc CLIPPED,
#                  "  UNION ",
#                  " SELECT UNIQUE pmab001,xmac001,xmac002,pmab006,xmac004,pmabsite ",
#                  "   FROM xmac_t,pmab_t,pmaa_t ",
#                  "  WHERE xmacent = ",g_enterprise," AND xmacsite = pmabsite ",
#                  "    AND pmabent = xmacent AND pmab003 = xmac001 ",
#                  "    AND (SELECT COUNT(*) FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite = '",g_site,"') = 0 ",
#                  "    AND pmabsite = 'ALL' ",
#                  "    AND pmab002 IN ('2','3') ",  #信用查核
#                  "    AND pmaaent = pmabent AND pmaa001 = pmab001 ",
#                  "    AND ",g_wc CLIPPED
#150615 by whitney mark end
      LET g_sql = " SELECT UNIQUE a.pmab001,a.pmab003,b.pmab005,b.pmab006,b.pmab006,b.pmabsite ",
                  "   FROM pmab_t a,pmab_t b ",
                  "  WHERE a.pmabent = ",g_enterprise,
                  "    AND a.pmabsite = '",g_site,"' ",
                  "    AND a.pmabent = b.pmabent ",
                  "    AND a.pmabsite = b.pmabsite ",
                  "    AND b.pmab002 IN ('2','3') ",  #信用查核
                  "    AND a.pmab003 = b.pmab001 ",
                  "    AND a.pmab001 IN (SELECT pmab001 FROM pmaa_t,pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite = '",g_site,"' AND pmaaent = pmabent AND pmaa001 = pmab001 AND ",g_wc CLIPPED,")"
      PREPARE axmq140_cs_pb FROM g_sql
      DECLARE axmq140_cs_cs CURSOR FOR axmq140_cs_pb
      INITIALIZE l_xmac.* TO NULL
      FOREACH axmq140_cs_cs INTO l_xmac.pmab001,l_xmac.xmac001,l_xmac.xmac002,
                                 l_xmac.xmac003,l_xmac.xmac004,l_xmac.xmacsite
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #Over Due
         IF s_credit_over_due_chk(l_xmac.xmacsite,l_xmac.xmac001) THEN
            LET l_xmac.chk1 = 'N'
         ELSE
            LET l_xmac.chk1 = 'Y'
         END IF
         #逾期未兌現票據
         IF s_credit_unrealized_bills_chk(l_xmac.xmacsite,l_xmac.xmac001) THEN
            LET l_xmac.chk2 = 'N'
         ELSE
            LET l_xmac.chk2 = 'Y'
         END IF
         #僅顯示超限資料=Y時，僅抓取 信用額度餘額<0 或 Over Due 或 逾期未兌現票據 的資料
         IF g_chk = 'Y' AND l_xmac.chk1 = 'N' AND l_xmac.chk2 = 'N' THEN
            CONTINUE FOREACH
         END IF
         
         INSERT INTO axmq140_tmp VALUES(l_xmac.pmab001,l_xmac.xmac001,l_xmac.xmac002,l_xmac.xmac003,
                                        l_xmac.xmac004,l_xmac.chk1,l_xmac.chk2,l_xmac.xmacsite)
         
         INITIALIZE l_xmac.* TO NULL
      END FOREACH
      
      LET g_sql = " SELECT UNIQUE pmab001,xmac001,xmac002,xmac003,xmac004,chk1,chk2,xmacsite ",
                  "   FROM axmq140_tmp ",
                  "  ORDER BY pmab001,xmac001,xmac002 "
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE axmq140_pre FROM g_sql
   DECLARE axmq140_curs SCROLL CURSOR WITH HOLD FOR axmq140_pre
   OPEN axmq140_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql = "SELECT COUNT(*) FROM ( ",g_sql," )"
   LET g_row_count = 0
   #end add-point
   PREPARE axmq140_precount FROM g_cnt_sql
   EXECUTE axmq140_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axmq140_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axmq140.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axmq140_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   #150615 by whitney add start
   IF SQLCA.sqlcode = 100 THEN
      RETURN
   END IF
   #150615 by whitney add end
   CASE p_flag
      WHEN 'N' FETCH NEXT      axmq140_curs INTO g_master.pmab001,g_master.xmac001,g_master.xmac002,g_master.xmac003,
                                                 g_master.xmac004,g_master.chk1,g_master.chk2
      WHEN 'P' FETCH PREVIOUS  axmq140_curs INTO g_master.pmab001,g_master.xmac001,g_master.xmac002,g_master.xmac003,
                                                 g_master.xmac004,g_master.chk1,g_master.chk2
      WHEN 'F' FETCH FIRST     axmq140_curs INTO g_master.pmab001,g_master.xmac001,g_master.xmac002,g_master.xmac003,
                                                 g_master.xmac004,g_master.chk1,g_master.chk2
      WHEN 'L' FETCH LAST      axmq140_curs INTO g_master.pmab001,g_master.xmac001,g_master.xmac002,g_master.xmac003,
                                                 g_master.xmac004,g_master.chk1,g_master.chk2
      WHEN '/'
         IF (NOT g_no_ask) THEN
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            CALL cl_getmsg('azz-00658',g_dlang) RETURNING ls_msg
            LET INT_FLAG = 0
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
            END IF
         END IF

         IF g_jump > g_row_count  OR g_jump <= 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-00659'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_jump = g_current_idx
         END IF

         IF cl_null(g_jump) THEN
            LET g_jump = g_current_idx
         END IF

         FETCH ABSOLUTE g_jump axmq140_curs INTO g_master.pmab001,g_master.xmac001,g_master.xmac002,g_master.xmac003,
                                                 g_master.xmac004,g_master.chk1,g_master.chk2
         LET g_no_ask = FALSE   
   END CASE
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO pmab001,pmab001_desc,xmac001,xmac001_desc,xmac002,xmac002_desc,xmac003,xmac004, 
          chk1,chk2
      CALL g_detail.clear()
 
      #add-point:陣列清空 name="fetch.array_clear"
      CALL g_detail2.clear()
      CALL g_detail3.clear()
      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = '-100' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_row_count
         WHEN '/' LET g_current_idx = g_jump
      END CASE
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_row_count TO FORMONLY.h_count
      CALL cl_navigator_setting( g_current_idx, g_row_count )
   END IF
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL axmq140_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axmq140.show" >}
PRIVATE FUNCTION axmq140_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO pmab001,pmab001_desc,xmac001,xmac001_desc,xmac002,xmac002_desc,xmac003,xmac004, 
       chk1,chk2
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   #客戶編號
   CALL s_desc_get_trading_partner_abbr_desc(g_master.pmab001)
        RETURNING g_master.pmab001_desc
   DISPLAY BY NAME g_master.pmab001_desc
   #額度對象
   CALL s_desc_get_trading_partner_abbr_desc(g_master.xmac001)
        RETURNING g_master.xmac001_desc
   DISPLAY BY NAME g_master.xmac001_desc
   #額度幣別
   CALL s_desc_get_currency_desc(g_master.xmac002)
        RETURNING g_master.xmac002_desc
   DISPLAY BY NAME g_master.xmac002_desc
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axmq140_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axmq140.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmq140_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET g_sql = " SELECT UNIQUE 'N',xmaa002,xmaa004,xmaa005, ",
               #項目金額：依計算項目抓取對應的xmac_t欄位
               "  (CASE WHEN xmaa002 = 'S1' THEN xmac011 ",
               "        WHEN xmaa002 = 'S2' THEN xmac012 ",
               "        WHEN xmaa002 = 'S3' THEN xmac013 ",
               "        WHEN xmaa002 = 'S4' THEN xmac014 ",
               "        WHEN xmaa002 = 'S5' THEN xmac015 ",
               "        WHEN xmaa002 = 'S6' THEN xmac016 ",
               "        WHEN xmaa002 = 'S7' THEN xmac017 ",
               "        WHEN xmaa002 = 'S8' THEN xmac018 ",
               "        WHEN xmaa002 = 'S9' THEN xmac019 ",
               "        WHEN xmaa002 = 'P1' THEN xmac041 ",
               "        WHEN xmaa002 = 'P2' THEN xmac042 ",
               "        WHEN xmaa002 = 'P3' THEN xmac043 ",
               "        WHEN xmaa002 = 'P4' THEN xmac044 ",
               "        WHEN xmaa002 = 'P5' THEN xmac045 ",
               "        WHEN xmaa002 = 'P6' THEN xmac046 ",
               "        WHEN xmaa002 = 'P7' THEN xmac047 ",
               "        WHEN xmaa002 = 'P9' THEN xmac048 ",
               "        END),0 ",
               "   FROM xmaa_t,pmab_t,xmac_t ",
               "  WHERE pmabent = xmacent ",
               "    AND pmabsite = xmacsite ",
#150921 by whitney mod start --- 多客戶對到同一個額度客戶，看到的資料相同
#               "    AND pmab001 = '",g_master.pmab001,"' ",
               "    AND pmab001 = '",g_master.xmac001,"' ",
#150921 by whitney mod end
               "    AND xmacent = xmaaent ",
               "    AND xmacsite = '",g_site,"' ",
               "    AND xmac001 = '",g_master.xmac001,"' ",
               "    AND xmaaent = ",g_enterprise," ",
               "    AND xmaa001 = pmab004 ",
               "    AND xmaa002 NOT IN ('S7','S10','S11') ",  #150822-00001#9 150903 by whitney add 'S7'
               "  ORDER BY xmaa002 "
   PREPARE axmq140_b_fill_pb FROM g_sql
   DECLARE axmq140_b_fill_cs CURSOR FOR axmq140_b_fill_pb
   LET g_master.xmac004 = g_master.xmac003
   FOREACH axmq140_b_fill_cs INTO g_detail[l_ac].sel,g_detail[l_ac].xmaa002,g_detail[l_ac].xmaa004,
                                  g_detail[l_ac].xmaa005,g_detail[l_ac].money1,g_detail[l_ac].money2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #額度耗用金額 = 項目金額 * 計算比率
      LET g_detail[l_ac].money2 = g_detail[l_ac].money1 * g_detail[l_ac].xmaa005 / 100
      
      #計算餘額
      IF g_detail[l_ac].xmaa004 = '1' THEN
         LET g_master.xmac004 = g_master.xmac004 + g_detail[l_ac].money2
      ELSE
         LET g_master.xmac004 = g_master.xmac004 - g_detail[l_ac].money2
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF      
   END FOREACH

   DISPLAY BY NAME g_master.xmac004

   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axmq140_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axmq140_detail_action_trans()
 
   CALL axmq140_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axmq140.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmq140_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_xmab020   LIKE xmab_t.xmab020
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"

   IF g_detail_idx > g_detail_cnt THEN
      LET g_detail_idx = g_detail_cnt
   END IF
   
   IF cl_null(g_detail_idx) OR g_detail_idx <= 0 THEN
      RETURN
   END IF

   CALL g_detail2.clear()
   #依單身一選取之計算項目，抓取xmab_t資料，交易含稅金額>已沖銷金額才顯示
   LET g_sql = " SELECT xmab003,xmab004,xmab005,ooefl003,xmab006,a.pmaal004,xmab007,ooail003, ",     #160816-00043#1
               "        xmab008,b.pmaal004,xmab009,xmab013,xmab010,xmab020 ",
               "   FROM xmab_t ",
               "        LEFT JOIN ooefl_t ON ooeflent = xmabent AND ooefl001 = xmab005 AND ooefl002 = '",g_dlang,"' ",
               "        LEFT JOIN pmaal_t a ON a.pmaalent = xmabent AND a.pmaal001 = xmab006 AND a.pmaal002= '",g_dlang,"' ",
               "        LEFT JOIN ooail_t ON ooailent = xmabent AND ooail001 = xmab007 AND ooail002= '",g_dlang,"' ",
               "        LEFT JOIN pmaal_t b ON b.pmaalent = xmabent AND b.pmaal001 = xmab008 AND b.pmaal002= '",g_dlang,"' ",
               "  WHERE xmabent = ",g_enterprise,
               "    AND xmab001 = '",g_detail[g_detail_idx].xmaa002,"' ",
#               "    AND xmab006 = '",g_master.pmab001,"' ",
               "    AND xmab008 = '",g_master.xmac001,"' ",
               "    AND xmab009 > xmab010 ",
               "    AND xmab017 = 'N' "
   IF g_argv[01] = 'ALL' THEN
      LET g_sql = g_sql," ORDER BY xmab003,xmab005 "
   ELSE
      LET g_sql = g_sql," AND xmab005 = '",g_site,"' ",
                        " ORDER BY xmab003,xmab005 "
   END IF
   PREPARE axmq140_b_fill2_pb FROM g_sql
   DECLARE axmq140_b_fill2_cs CURSOR FOR axmq140_b_fill2_pb
      
   FOREACH axmq140_b_fill2_cs INTO g_detail2[li_ac].xmab003,g_detail2[li_ac].xmab004,g_detail2[li_ac].xmab005,g_detail2[li_ac].xmab005_desc,        #160816-00043#1
                                   g_detail2[li_ac].xmab006,g_detail2[li_ac].xmab006_desc,g_detail2[li_ac].xmab007,
                                   g_detail2[li_ac].xmab007_desc,g_detail2[li_ac].xmab008,g_detail2[li_ac].xmab008_desc,
                                   g_detail2[li_ac].xmab009,g_detail2[li_ac].xmab013,g_detail2[li_ac].xmab010,l_xmab020
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #150814--polly--add--(s)
      IF g_argv[01] = 'ALL' THEN
         LET g_detail2[li_ac].xmab013 = l_xmab020
      END IF
      #150814--polly--add--(e)
      
      #額度金額 = 交易含稅金額 - 已沖銷金額 * 匯率
      LET g_detail2[li_ac].xmab010 = (g_detail2[li_ac].xmab009 - g_detail2[li_ac].xmab010) * g_detail2[li_ac].xmab013
      
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF      
   END FOREACH

   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   CALL g_detail2.deleteElement(g_detail2.getLength())
   
   LET g_error_show = 0
   
   #單身總筆數顯示
   LET g_detail_cnt2 = g_detail2.getLength()
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
   ELSE
      LET g_detail_idx2 = 0
   END IF

   CALL axmq140_b_fill3()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmq140.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmq140_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
   END IF
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
   END IF

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmq140.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axmq140_maintain_prog()
   #add-point:maintain_prog段define-客製 name="maintain_prog.define_customerization"
   
   #end add-point
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="maintain_prog.define"
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前 name="maintain_prog.before"
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmq140.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axmq140_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.idx
   DISPLAY g_tot_cnt TO FORMONLY.cnt
 
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
 
{<section id="axmq140.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axmq140_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
               IF g_detail.getLength() THEN
                  LET li_redirect = TRUE
               END IF
            WHEN g_curr_diag.getCurrentRow("s_detail1") > g_detail.getLength() AND g_detail.getLength() > 0
               LET g_detail_idx = g_detail.getLength()
               LET li_redirect = TRUE
            WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
               IF g_detail_idx > g_detail.getLength() THEN
                  LET g_detail_idx = g_detail.getLength()
               END IF
               LET li_redirect = TRUE
         END CASE
      END IF
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmq140.mask_functions" >}
 &include "erp/cxm/axmq140_mask.4gl"
 
{</section>}
 
{<section id="axmq140.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 額度耗用明細
# Memo...........:
# Usage..........: CALL axmq140_b_fill3()
# Input parameter: no
# Return code....: no
# Date & Author..: 150319 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmq140_b_fill3()
   DEFINE li_ac           LIKE type_t.num10
   DEFINE l_xmab020       LIKE xmab_t.xmab020
   
   
   LET g_detail_idx3 = 1

   CALL g_detail3.clear()

   LET li_ac = 1

#   LET g_sql = " SELECT UNIQUE xmaa002,xmab003,xmab005,ooefl003,xmab006, ",
#               "        a.pmaal004,xmab007,ooail003,xmab008,b.pmaal004, ",
#               "        xmab009,xmab013,xmab020, ",
#               "  (CASE WHEN xmaa002 = 'S1' THEN xmac011 ",
#               "        WHEN xmaa002 = 'S2' THEN xmac012 ",
#               "        WHEN xmaa002 = 'S3' THEN xmac013 ",
#               "        WHEN xmaa002 = 'S4' THEN xmac014 ",
#               "        WHEN xmaa002 = 'S5' THEN xmac015 ",
#               "        WHEN xmaa002 = 'S6' THEN xmac016 ",
#               "        WHEN xmaa002 = 'S7' THEN xmac017 ",
#               "        WHEN xmaa002 = 'S8' THEN xmac018 ",
#               "        WHEN xmaa002 = 'S9' THEN xmac019 ",
#               "        WHEN xmaa002 = 'P1' THEN xmac041 ",
#               "        WHEN xmaa002 = 'P2' THEN xmac042 ",
#               "        WHEN xmaa002 = 'P3' THEN xmac043 ",
#               "        WHEN xmaa002 = 'P4' THEN xmac044 ",
#               "        WHEN xmaa002 = 'P5' THEN xmac045 ",
#               "        WHEN xmaa002 = 'P6' THEN xmac046 ",
#               "        WHEN xmaa002 = 'P7' THEN xmac047 ",
#               "        WHEN xmaa002 = 'P9' THEN xmac048 ",               
#               "        END),xmaa004,xmaa005,0 ",
#               "   FROM xmaa_t,pmab_t,xmac_t,xmab_t ",
#               "        LEFT JOIN ooefl_t ON ooeflent = xmabent AND ooefl001 = xmab005 AND ooefl002 = '",g_dlang,"' ",
#               "        LEFT JOIN pmaal_t a ON a.pmaalent = xmabent AND a.pmaal001 = xmab006 AND a.pmaal002= '",g_dlang,"' ",
#               "        LEFT JOIN ooail_t ON ooailent = xmabent AND ooail001 = xmab007 AND ooail002= '",g_dlang,"' ",
#               "        LEFT JOIN pmaal_t b ON b.pmaalent = xmabent AND b.pmaal001 = xmab008 AND b.pmaal002= '",g_dlang,"' ",
#               "  WHERE pmabent = ",g_enterprise," ",
#               "    AND pmabsite = '",g_site,"' ",
#               "    AND pmab001 = '",g_master.pmab001,"' ",
#               "    AND pmab003 = '",g_master.xmac001,"' ",
#               "    AND xmacent = xmaaent ",
#               "    AND xmacsite = pmabsite ",
#               "    AND xmac001 = pmab003 ",
#               "    AND xmaaent = pmabent ",
#               "    AND xmaa001 = pmab004 ",
#               "    AND xmaa002 NOT IN ('S10','S11') ",
#               "    AND xmabent = xmaaent ",
#               "    AND xmab001 = xmaa002 ",
#               "    AND xmab006 = pmab001 ",
#               "    AND xmab008 = pmab003 ",
#               "    AND xmab009 > xmab010 "

  #LET g_sql = " SELECT UNIQUE xmaa002,xmab003,xmab005,ooefl003,xmab006, ", #160826-00035#1 mark
   LET g_sql = " SELECT xmaa002,xmab003,xmab004,xmab005,ooefl003,xmab006, ",        #160826-00035#1 add     #160816-00043#1 add xmab004
               "        a.pmaal004,xmab007,ooail003,xmab008,b.pmaal004, ",
               "        xmab009,xmab013,xmab020, ",
               "        xmab010,xmaa004,xmaa005,0 ",
               "   FROM xmaa_t,pmab_t,xmab_t ",
               "        LEFT JOIN ooefl_t ON ooeflent = xmabent AND ooefl001 = xmab005 AND ooefl002 = '",g_dlang,"' ",
               "        LEFT JOIN pmaal_t a ON a.pmaalent = xmabent AND a.pmaal001 = xmab006 AND a.pmaal002= '",g_dlang,"' ",
               "        LEFT JOIN ooail_t ON ooailent = xmabent AND ooail001 = xmab007 AND ooail002= '",g_dlang,"' ",
               "        LEFT JOIN pmaal_t b ON b.pmaalent = xmabent AND b.pmaal001 = xmab008 AND b.pmaal002= '",g_dlang,"' ",
               "  WHERE pmabent = ",g_enterprise," ",
               "    AND pmabsite = '",g_site,"' ",
#150921 by whitney mod start --- 多客戶對到同一個額度客戶，看到的資料相同
#               "    AND pmab001 = '",g_master.pmab001,"' ",
               "    AND pmab001 = '",g_master.xmac001,"' ",
#150921 by whitney mod end
               "    AND xmaaent = pmabent ",
               "    AND xmaa001 = pmab004 ",
               "    AND xmaa002 NOT IN ('S7','S10','S11') ",  #150822-00001#9 150903 by whitney add 'S7'
               "    AND xmabent = xmaaent ",
               "    AND xmab001 = xmaa002 ",
#               "    AND xmab006 = pmab001 ",
               "    AND xmab008 = pmab003 ",
               "    AND xmab009 > xmab010 ",
               "    AND xmab017 = 'N' "
               
   IF g_argv[01] = 'ALL' THEN
      LET g_sql = g_sql," ORDER BY xmaa002,xmab003,xmab005 "
   ELSE
      LET g_sql = g_sql," AND xmab005 = '",g_site,"' ",
                        " ORDER BY xmaa002,xmab003,xmab005 "
   END IF
   PREPARE axmq140_b_fill3_pb FROM g_sql
   DECLARE axmq140_b_fill3_cs CURSOR FOR axmq140_b_fill3_pb
   
   FOREACH axmq140_b_fill3_cs INTO g_detail3[li_ac].xmaa002,g_detail3[li_ac].xmab003,g_detail3[li_ac].xmab004,           #160816-00043#1 add xmab004
                                   g_detail3[li_ac].xmab005,g_detail3[li_ac].xmab005_desc,
                                   g_detail3[li_ac].xmab006,g_detail3[li_ac].xmab006_desc,
                                   g_detail3[li_ac].xmab007,g_detail3[li_ac].xmab007_desc,
                                   g_detail3[li_ac].xmab008,g_detail3[li_ac].xmab008_desc,
                                   g_detail3[li_ac].xmab009,g_detail3[li_ac].xmab013,l_xmab020,
                                   g_detail3[li_ac].money1,g_detail3[li_ac].xmaa004,
                                   g_detail3[li_ac].xmaa005,g_detail3[li_ac].money2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #150814--polly--add--(s)
      IF g_argv[01] = 'ALL' THEN
         LET g_detail3[li_ac].xmab013 = l_xmab020
      END IF
      LET g_detail3[li_ac].money1 = (g_detail3[li_ac].xmab009 - g_detail3[li_ac].money1 ) * g_detail3[li_ac].xmab013 
      #150814--polly--add--(e)
      
      #額度耗用金額 = 項目金額 * 計算比率
      LET g_detail3[li_ac].money2 = g_detail3[li_ac].money1 * g_detail3[li_ac].xmaa005 / 100
      
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF      
   END FOREACH

   CALL g_detail3.deleteElement(g_detail3.getLength())
   
   LET g_error_show = 0
   
   #單身總筆數顯示
   LET g_detail_cnt3 = g_detail3.getLength()
   IF g_detail_cnt3 > 0 THEN
      LET g_detail_idx3 = 1
   ELSE
      LET g_detail_idx3 = 0
   END IF

END FUNCTION
#應用 a06 樣板自動產生(Version:2)
#次要單頭table相關處理
PRIVATE FUNCTION axmq140_pmab_t(ps_type)
 
   DEFINE li_cnt    LIKE type_t.num10
   DEFINE ps_type   STRING  
   DEFINE ls_sql    STRING  
 
#   IF ps_type = "s" THEN 
#            LET ls_sql = 'SELECT  FROM pmab_t WHERE pmabent= ? AND pmabsite= ? AND pmabsite=? AND pmab001=? ' 
#      DECLARE pmab_t_cl CURSOR FROM ls_sql 
#      OPEN pmab_t_cl USING g_enterprise,g_site,g_xmaa_m.xmaa001,g_xmaa_m.xmaa002
#      FETCH pmab_t_cl INTO g_xmaa_m. 
#
#      IF SQLCA.sqlcode THEN
#                  LET g_xmaa_m.  = NULL 
#
#      END IF 
#      RETURN 
#   END IF 
# 
#      SELECT COUNT(*) INTO li_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmabsite = g_xmaa001_t AND pmab001 = g_xmaa002_t
#   
#   IF li_cnt = 0 AND ps_type = "u" THEN 
#            INSERT INTO pmab_t 
#      (pmabent,pmabsite,pmabsite,pmab001, )
#      VALUES (g_enterprise,g_site,g_xmaa_m.xmaa001,g_xmaa_m.xmaa002,g_xmaa_m. )
#   END IF 
# 
#   IF li_cnt > 0 AND ps_type = "u" THEN 
#            UPDATE pmab_t SET 
#      (pmabsite,pmab001, ) = 
#      (g_xmaa_m.xmaa001,g_xmaa_m.xmaa002,g_xmaa_m. ) 
#      WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmabsite = g_xmaa001_t AND pmab001 = g_xmaa002_t
#
#   END IF 
# 
#   IF li_cnt > 0 AND ps_type = "d" THEN 
#            DELETE FROM pmab_t
#      WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmabsite = g_xmaa001_t AND pmab001 = g_xmaa002_t
#   END IF 
# 
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "axmq140" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#   END IF 
 
END FUNCTION
#應用 a06 樣板自動產生(Version:2)
#次要單頭table相關處理
PRIVATE FUNCTION axmq140_xmab_t(ps_type)
 
   DEFINE li_cnt    LIKE type_t.num10
   DEFINE ps_type   STRING  
   DEFINE ls_sql    STRING  
 
#   IF ps_type = "s" THEN 
#            LET ls_sql = 'SELECT  FROM xmab_t WHERE xmabent= ? AND xmab001=? AND xmab002=? AND xmab003=? AND xmab004=? AND xmab005=? ' 
#      DECLARE xmab_t_cl CURSOR FROM ls_sql 
#      OPEN xmab_t_cl USING g_enterprise,g_xmaa_m.xmaa001,g_xmaa_m.xmaa002
#      FETCH xmab_t_cl INTO g_xmaa_m. 
#
#      IF SQLCA.sqlcode THEN
#                  LET g_xmaa_m.  = NULL 
#
#      END IF 
#      RETURN 
#   END IF 
# 
#      SELECT COUNT(*) INTO li_cnt FROM xmab_t WHERE xmabent = g_enterprise AND xmab001 = g_xmaa001_t AND xmab002 = g_xmaa002_t AND xmab003 = g__t AND xmab004 = g__t AND xmab005 = g__t
#   
#   IF li_cnt = 0 AND ps_type = "u" THEN 
#            INSERT INTO xmab_t 
#      (xmabent,xmab001,xmab002,xmab003,xmab004,xmab005, )
#      VALUES (g_enterprise,g_xmaa_m.xmaa001,g_xmaa_m.xmaa002,g_xmaa_m. )
#   END IF 
# 
#   IF li_cnt > 0 AND ps_type = "u" THEN 
#            UPDATE xmab_t SET 
#      (xmab001,xmab002,xmab003,xmab004,xmab005, ) = 
#      (g_xmaa_m.xmaa001,g_xmaa_m.xmaa002,g_xmaa_m. ) 
#      WHERE xmabent = g_enterprise AND xmab001 = g_xmaa001_t AND xmab002 = g_xmaa002_t AND xmab003 = g__t AND xmab004 = g__t AND xmab005 = g__t
#
#   END IF 
# 
#   IF li_cnt > 0 AND ps_type = "d" THEN 
#            DELETE FROM xmab_t
#      WHERE xmabent = g_enterprise AND xmab001 = g_xmaa001_t AND xmab002 = g_xmaa002_t AND xmab003 = g__t AND xmab004 = g__t AND xmab005 = g__t
#   END IF 
# 
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "axmq140" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#   END IF 
 
END FUNCTION
#應用 a06 樣板自動產生(Version:2)
#次要單頭table相關處理
PRIVATE FUNCTION axmq140_xmac_t(ps_type)
 
   DEFINE li_cnt    LIKE type_t.num10
   DEFINE ps_type   STRING  
   DEFINE ls_sql    STRING  
 
#   IF ps_type = "s" THEN 
#            LET ls_sql = 'SELECT  FROM xmac_t WHERE xmacent= ? AND xmacsite= ? AND xmacsite=? AND xmac001=? ' 
#      DECLARE xmac_t_cl CURSOR FROM ls_sql 
#      OPEN xmac_t_cl USING g_enterprise,g_site,g_xmaa_m.xmaa001,g_xmaa_m.xmaa002
#      FETCH xmac_t_cl INTO g_xmaa_m. 
#
#      IF SQLCA.sqlcode THEN
#                  LET g_xmaa_m.  = NULL 
#
#      END IF 
#      RETURN 
#   END IF 
# 
#      SELECT COUNT(*) INTO li_cnt FROM xmac_t WHERE xmacent = g_enterprise AND xmacsite = g_site AND xmacsite = g_xmaa001_t AND xmac001 = g_xmaa002_t
#   
#   IF li_cnt = 0 AND ps_type = "u" THEN 
#            INSERT INTO xmac_t 
#      (xmacent,xmacsite,xmacsite,xmac001, )
#      VALUES (g_enterprise,g_site,g_xmaa_m.xmaa001,g_xmaa_m.xmaa002,g_xmaa_m. )
#   END IF 
# 
#   IF li_cnt > 0 AND ps_type = "u" THEN 
#            UPDATE xmac_t SET 
#      (xmacsite,xmac001, ) = 
#      (g_xmaa_m.xmaa001,g_xmaa_m.xmaa002,g_xmaa_m. ) 
#      WHERE xmacent = g_enterprise AND xmacsite = g_site AND xmacsite = g_xmaa001_t AND xmac001 = g_xmaa002_t
#
#   END IF 
# 
#   IF li_cnt > 0 AND ps_type = "d" THEN 
#            DELETE FROM xmac_t
#      WHERE xmacent = g_enterprise AND xmacsite = g_site AND xmacsite = g_xmaa001_t AND xmac001 = g_xmaa002_t
#   END IF 
# 
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "axmq140" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#   END IF 
 
END FUNCTION

################################################################################
# Descriptions...: 匯總資料
# Memo...........:
# Usage..........: CALL axmq140_b_fill4()
#                  
# Input parameter:no
# Return code....:no
# Date & Author..: 2016/12/29 By 08993
# Modify.........: #161215-00012#1 add
################################################################################
PRIVATE FUNCTION axmq140_b_fill4()
   DEFINE l_xmac  RECORD
       pmab001    LIKE pmab_t.pmab001,
       xmac001    LIKE xmac_t.xmac001,
       xmac002    LIKE xmac_t.xmac002,
       xmac003    LIKE xmac_t.xmac003,
       xmac004    LIKE xmac_t.xmac004,
       chk1       LIKE type_t.chr1,
       chk2       LIKE type_t.chr1,
       xmacsite   LIKE xmac_t.xmacsite
              END RECORD
   DEFINE li_ac           LIKE type_t.num10
    #170413-00051#1-s-add
   DEFINE l_xmaa004       LIKE xmaa_t.xmaa004
   DEFINE l_xmaa005       LIKE xmaa_t.xmaa005  
   DEFINE l_money         LIKE xmac_t.xmac004  
   DEFINE l_cost          LIKE xmac_t.xmac004  
   DEFINE l_pmab001_o     LIKE pmab_t.pmab001
   #170413-00051#1-e-add
   
   LET g_detail_idx4 = 1 
   CALL g_detail4.clear()
    
   LET li_ac = 1
    #170413-00051#1-s-mod 多信用額度餘額的抓取(xmaa_t,b.pmab006)
   #LET g_sql = " SELECT UNIQUE a.pmab001,a.pmab003,a.pmab003,b.pmab005,b.pmab006,b.pmab006,b.pmabsite, ",
   #            "               xmac041,xmac042,xmac043,xmac044,xmac045, ",
   #            "               xmac046,xmac048,xmac011,xmac012,xmac013, ",
   #            "               xmac014,xmac015,xmac016,xmac018,xmac019,0 ",
   #            "   FROM pmab_t a,pmab_t b,xmac_t ",
   #            "  WHERE a.pmabent = ",g_enterprise,
   #            "    AND a.pmabsite = '",g_site,"' ",
   #            "    AND a.pmabent = b.pmabent ",
   #            "    AND a.pmabsite = b.pmabsite ",
   #            "    AND b.pmab002 IN ('2','3') ",  #信用查核
   #            "    AND a.pmab003 = b.pmab001 ",
   #            "    AND a.pmab001 IN (SELECT pmab001 FROM pmaa_t,pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite = '",g_site,"' AND pmaaent = pmabent AND pmaa001 = pmab001 AND ",g_wc CLIPPED,")",
   #            "    AND xmacent = b.pmabent ",
   #            "    AND xmacsite = b.pmabsite ",
   #            "    AND xmac001 = a.pmab003 "
   LET g_sql = " SELECT UNIQUE a.pmab001,a.pmab003,a.pmab003,b.pmab005,b.pmab006,b.pmab006,b.pmabsite, ",
               "               xmac041,xmac042,xmac043,xmac044,xmac045, ",
               "               xmac046,xmac048,xmac011,xmac012,xmac013, ",
               "               xmac014,xmac015,xmac016,xmac018,xmac019,b.pmab006,xmaa004,xmaa005,",
               #項目金額：依計算項目抓取對應的xmac_t欄位
               "  (CASE WHEN xmaa002 = 'S1' THEN xmac011 ",
               "        WHEN xmaa002 = 'S2' THEN xmac012 ",
               "        WHEN xmaa002 = 'S3' THEN xmac013 ",
               "        WHEN xmaa002 = 'S4' THEN xmac014 ",
               "        WHEN xmaa002 = 'S5' THEN xmac015 ",
               "        WHEN xmaa002 = 'S6' THEN xmac016 ",
               "        WHEN xmaa002 = 'S7' THEN xmac017 ",
               "        WHEN xmaa002 = 'S8' THEN xmac018 ",
               "        WHEN xmaa002 = 'S9' THEN xmac019 ",
               "        WHEN xmaa002 = 'P1' THEN xmac041 ",
               "        WHEN xmaa002 = 'P2' THEN xmac042 ",
               "        WHEN xmaa002 = 'P3' THEN xmac043 ",
               "        WHEN xmaa002 = 'P4' THEN xmac044 ",
               "        WHEN xmaa002 = 'P5' THEN xmac045 ",
               "        WHEN xmaa002 = 'P6' THEN xmac046 ",
               "        WHEN xmaa002 = 'P7' THEN xmac047 ",
               "        WHEN xmaa002 = 'P9' THEN xmac048 ",
               "    END) money",
               "   FROM pmab_t a,pmab_t b,xmaa_t,xmac_t ",
               "  WHERE a.pmabent = ",g_enterprise,
               "    AND a.pmabsite = '",g_site,"' ",
               "    AND a.pmabent = b.pmabent ",
               "    AND a.pmabsite = b.pmabsite ",
               "    AND b.pmab002 IN ('2','3') ",  #信用查核
               "    AND a.pmab003 = b.pmab001 ",
               "    AND a.pmab001 IN (SELECT pmab001 FROM pmaa_t,pmab_t WHERE pmabent = ",g_enterprise,"AND pmabsite = '",g_site,"'",
               "                          AND pmaaent = pmabent AND pmaa001 = pmab001 AND ",g_wc CLIPPED,")",
               "    AND xmacent = b.pmabent ",
               "    AND xmacsite = b.pmabsite ",
               "    AND xmac001 = a.pmab003 ",
               "    AND xmacent = xmaaent ",
               "    AND xmaa001 = b.pmab004 ",
               "    AND xmaa002 NOT IN ('S7','S10','S11') ",
               "  ORDER BY a.pmab001 "
   #170413-00051#1-e-mod            
   PREPARE axmq140_b_fill4_pb FROM g_sql
   DECLARE axmq140_b_fill4_cs CURSOR FOR axmq140_b_fill4_pb
   INITIALIZE l_xmac.* TO NULL
   #170413-00051#1-s-add
   LET l_xmaa005  = '' 
   LET l_money = '' 
   LET l_pmab001_o = ''
   #170413-00051#1-e-add
   
#   FOREACH axmq140_b_fill4_cs INTO g_detail4[li_ac].pmab001_1,g_detail4[li_ac].xmac001_1,l_xmac.xmac001,g_detail4[li_ac].xmac002_1,g_detail4[li_ac].xmac003_1,g_detail4[li_ac].xmac004,l_xmac.xmacsite,    #170310-00011#1 mark
   FOREACH axmq140_b_fill4_cs INTO g_detail4[li_ac].pmab001_1,g_detail4[li_ac].xmac001_1,l_xmac.xmac001,g_detail4[li_ac].xmac002_1,g_detail4[li_ac].xmac003_1,g_detail4[li_ac].xmac004_1,l_xmac.xmacsite,   #170310-00011#1 mod
                                   g_detail4[li_ac].xmac041,g_detail4[li_ac].xmac042,g_detail4[li_ac].xmac043,g_detail4[li_ac].xmac044,g_detail4[li_ac].xmac045,
                                   g_detail4[li_ac].xmac046,g_detail4[li_ac].xmac048,g_detail4[li_ac].xmac011,g_detail4[li_ac].xmac012,g_detail4[li_ac].xmac013,
                                   g_detail4[li_ac].xmac014,g_detail4[li_ac].xmac015,g_detail4[li_ac].xmac016,g_detail4[li_ac].xmac018,g_detail4[li_ac].xmac019,g_detail4[li_ac].money2_2 
                                   ,l_xmaa004,l_xmaa005,l_money #170413-00051#1-add
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #170413-00051#1-s-add
      #同一個客戶，顯示在同一筆就好(與計算計算餘額有關)
      IF l_pmab001_o = g_detail4[li_ac].pmab001_1 THEN
         LET li_ac = li_ac - 1
      ELSE
         LET l_pmab001_o = g_detail4[li_ac].pmab001_1
      END IF
      #170413-00051#1-e-add
      
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4[li_ac].pmab001_1)
         RETURNING g_detail4[li_ac].pmab001_desc_1
      
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4[li_ac].xmac001_1)
         RETURNING g_detail4[li_ac].xmac001_desc_1 
      
      CALL s_desc_get_currency_desc(g_detail4[li_ac].xmac002_1)
         RETURNING g_detail4[li_ac].xmac002_desc_1
      
      #Over Due
      IF s_credit_over_due_chk(l_xmac.xmacsite,l_xmac.xmac001) THEN
         LET g_detail4[li_ac].chk3 = 'N'
      ELSE
         LET g_detail4[li_ac].chk3 = 'Y'
      END IF
      #逾期未兌現票據
      IF s_credit_unrealized_bills_chk(l_xmac.xmacsite,l_xmac.xmac001) THEN
         LET g_detail4[li_ac].chk4 = 'N'
      ELSE
         LET g_detail4[li_ac].chk4 = 'Y'
      END IF
      #170413-00051#1-s-add
      #額度耗用金額 = 項目金額 * 計算比率
      LET l_cost = l_money * l_xmaa005 / 100
      
      #計算餘額
      IF l_xmaa004 = '1' THEN
         LET g_detail4[li_ac].money2_2 = g_detail4[li_ac].money2_2  + l_cost
      ELSE
         LET g_detail4[li_ac].money2_2 = g_detail4[li_ac].money2_2  - l_cost
      END IF
      #170413-00051#1-e-add
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF      
   END FOREACH
   
   CALL g_detail4.deleteElement(g_detail4.getLength())
   
   LET g_error_show = 0
   
   #單身總筆數顯示
   LET g_detail_cnt4 = g_detail4.getLength()
   IF g_detail_cnt4 > 0 THEN
      LET g_detail_idx4 = 1
   ELSE
      LET g_detail_idx4 = 0
   END IF
  
END FUNCTION

 
{</section>}
 
