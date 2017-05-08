#該程式未解開Section, 採用最新樣板產出!
{<section id="aicq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2015-04-10 14:21:00), PR版次:0007(2016-12-20 15:49:25)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000104
#+ Filename...: aicq100
#+ Description: (停用)多角貿易查詢作業
#+ Creator....: 04226(2014-11-10 14:35:54)
#+ Modifier...: 04543 -SD/PR- 08532
 
{</section>}
 
{<section id="aicq100.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#151119-00010#1   151126      By Polly    抓取出貨單已立账数量sql調整
#151130-00016#1   151202      By shiun    單據明細頁簽的"單據性質"問題補上
#160909-00080#1   2016/09/13  By 02097    修改開窗
#161215-00074#1   2016/12/20  By liqma    “單據明細”會撈出該筆單據以外的單
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
PRIVATE TYPE type_g_xmda_d RECORD
       
       sel LIKE type_t.chr1, 
   doctype LIKE type_t.chr500, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmda031 LIKE xmda_t.xmda031, 
   xmda050 LIKE xmda_t.xmda050, 
   xmda050_desc LIKE type_t.chr500, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda004_desc LIKE type_t.chr500, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda002_desc LIKE type_t.chr500, 
   xmdastus LIKE xmda_t.xmdastus, 
   xmda010 LIKE xmda_t.xmda010, 
   xmda010_desc LIKE type_t.chr500, 
   xmda009 LIKE xmda_t.xmda009, 
   xmda009_desc LIKE type_t.chr500, 
   xmda011 LIKE xmda_t.xmda011, 
   xmda011_desc LIKE type_t.chr500, 
   xmda035 LIKE xmda_t.xmda035, 
   xmda035_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xmda2_d RECORD
       doctype1 LIKE type_t.chr500, 
   xmdcdocno LIKE xmdc_t.xmdcdocno, 
   xmdcseq LIKE xmdc_t.xmdcseq, 
   xmdc019 LIKE xmdc_t.xmdc019, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   xmdc001_desc LIKE type_t.chr500, 
   xmdc001_desc_desc LIKE type_t.chr500, 
   xmdc002 LIKE xmdc_t.xmdc002, 
   xmdc006 LIKE xmdc_t.xmdc006, 
   xmdc006_desc LIKE type_t.chr500, 
   xmdc007 LIKE xmdc_t.xmdc007, 
   xmdl035 LIKE xmdl_t.xmdl035, 
   xmdd014 LIKE xmdd_t.xmdd014, 
   xrcb007 LIKE xrcb_t.xrcb007
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
###########站點+營運據點匯總查詢#############
 TYPE type_g_xmda3_d RECORD
   icab002           LIKE icab_t.icab002,  #站點
   icab003           LIKE icab_t.icab003,  #營運據點
   icab003_desc      LIKE type_t.chr500,   #據點名稱
   xmdd005           LIKE xmdd_t.xmdd005,  #訂貨量
   xmdd031           LIKE xmdd_t.xmdd031,  #出通量
   xmdp016           LIKE xmdp_t.xmdp016,  #Invoice量
   xmdl0351          LIKE xmdl_t.xmdl035,  #出貨簽收量
   xmdl036           LIKE xmdl_t.xmdl036,  #出貨簽退量
   xmdd0141          LIKE xmdd_t.xmdd014,  #出貨量
   xrcb0071          LIKE xrcb_t.xrcb007,  #應收量
   xmdd015           LIKE xmdd_t.xmdd015,  #銷退量
   pmdn007           LIKE pmdn_t.pmdn007,  #採購量
   pmdo015           LIKE pmdo_t.pmdo015,  #收貨量
   qcba017           LIKE qcba_t.qcba017,  #QC量
   pmdo019           LIKE pmdo_t.pmdo019,  #入庫量
   apcb007           LIKE apcb_t.apcb007,  #應付量
   pmdo040           LIKE pmdo_t.pmdo040,  #倉退量
   xmda0152          LIKE xmda_t.xmda015,  #訂單幣別
   xmda0152_desc     LIKE type_t.chr500,   #訂單幣別說明
   pmdl015           LIKE pmdl_t.pmdl015,  #採購幣別
   pmdl015_desc      LIKE type_t.chr500,   #採購幣別說明
   xmdc046           LIKE xmdc_t.xmdc046,  #訂單未稅金額
   xmdc047           LIKE xmdc_t.xmdc047,  #訂單含稅金額
   xmdc048           LIKE xmdc_t.xmdc048,  #訂單稅額
   pmdn046           LIKE pmdn_t.pmdn046,  #採購未稅金額
   pmdn047           LIKE pmdn_t.pmdn047,  #採購含稅金額
   pmdn048           LIKE pmdn_t.pmdn048   #採購稅額
                     END RECORD
DEFINE g_xmda3_d     DYNAMIC ARRAY OF type_g_xmda3_d
DEFINE g_xmda3_d_t   type_g_xmda3_d
DEFINE g_detail_idx3 LIKE type_t.num5
###########################################
#################單據明細###################
 TYPE type_g_xmda4_d RECORD
   xmda0312           LIKE xmda_t.xmda031,  #多流程序號
   icab002            LIKE icab_t.icab002,  #站點
   xmdasite2          LIKE xmda_t.xmdasite, #營運據點
   xmdasite2_desc     LIKE type_t.chr500,   #據點名稱
   doctype2           LIKE type_t.chr500,   #單據性質
   xmdadocno2         LIKE xmda_t.xmdadocno,#單號
   xmda0102           LIKE xmda_t.xmda010,  #交易條件
   xmda0102_desc      LIKE type_t.chr500,   #交易條件說明
   xmda0092           LIKE xmda_t.xmda009,  #收/付款條件
   xmda0092_desc      LIKE type_t.chr500,   #收/付款條件說明
   xmda0112           LIKE xmda_t.xmda011,  #稅別
   xmda0112_desc      LIKE type_t.chr500,   #稅別說明
   xmda0352           LIKE xmda_t.xmda035,  #發票類型
   xmda0352_desc      LIKE type_t.chr500,   #發票類型說明
   xmda015            LIKE xmda_t.xmda015,  #幣別
   xmda015_desc       LIKE type_t.chr500,   #幣別說明
   xmdcseq2           LIKE xmdc_t.xmdcseq,  #項次
   xmdc0192           LIKE xmdc_t.xmdc019,  #子件特性
   xmdc0012           LIKE xmdc_t.xmdc001,  #料件編號
   xmdc0012_desc      LIKE type_t.chr500,   #品名
   xmdc0012_desc_desc LIKE type_t.chr500,   #規格
   xmdc0022           LIKE xmdc_t.xmdc002,  #產品特徵
   xmdc0062           LIKE xmdc_t.xmdc006,  #銷售/採購單位
   xmdc0062_desc      LIKE type_t.chr500,   #銷售/採購單位說明
   xmdc0072           LIKE xmdc_t.xmdc007,  #數量
   xmdc010            LIKE xmdc_t.xmdc010,  #計價單位
   xmdc010_desc       LIKE type_t.chr500,   #計價單位說明
   xmdc011            LIKE xmdc_t.xmdc011,  #計價數量
   xmdc003            LIKE xmdc_t.xmdc003,  #包裝容器
   xmdc0152           LIKE xmdc_t.xmdc015,  #訂單單價
   xmdc0462           LIKE xmdc_t.xmdc046,  #訂單未稅金額
   xmdc0472           LIKE xmdc_t.xmdc047,  #訂單含稅金額
   xmdc0482           LIKE xmdc_t.xmdc048   #訂單稅額
                      END RECORD
DEFINE g_xmda4_d      DYNAMIC ARRAY OF type_g_xmda4_d
DEFINE g_xmda4_d_t    type_g_xmda4_d
DEFINE g_detail_idx4  LIKE type_t.num5
###########################################
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmda_d            DYNAMIC ARRAY OF type_g_xmda_d
DEFINE g_xmda_d_t          type_g_xmda_d
DEFINE g_xmda2_d     DYNAMIC ARRAY OF type_g_xmda2_d
DEFINE g_xmda2_d_t   type_g_xmda2_d
 
 
 
 
 
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicq100.main" >}
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
   CALL cl_ap_init("aic","")
 
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
   DECLARE aicq100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aicq100_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aicq100_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicq100 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicq100_init()   
 
      #進入選單 Menu (="N")
      CALL aicq100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aicq100
      
   END IF 
   
   CLOSE aicq100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aicq100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aicq100_init()
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
      CALL cl_set_combo_scc_part('b_xmdastus','13','N,Y,A,D,R,W,C,H,UH,X')
 
      CALL cl_set_combo_scc('b_xmdc019','2055') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('xmdastus','13','N,X,Y,A,D,R,W,C,H,UH')
   CALL cl_set_combo_scc_part('b_doctype','2508','1,2,4')
   CALL cl_set_combo_scc_part('b_doctype1','2508','1,2,4')
   #CALL cl_set_combo_scc_part('b_doctype2','2508','5,6,7,8,9,10,11,12,13,14,15,16,17,18')
   CALL cl_set_combo_scc('b_doctype2','2508')
   CALL cl_set_combo_scc('b_xmdc0192','2055')
   #end add-point
 
   CALL aicq100_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aicq100.default_search" >}
PRIVATE FUNCTION aicq100_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdadocno = '", g_argv[01], "' AND "
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
 
{<section id="aicq100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicq100_ui_dialog() 
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
 
   
   CALL aicq100_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmda_d.clear()
         CALL g_xmda2_d.clear()
 
 
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
 
         CALL aicq100_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON xmda031,xmda050,xmdadocno,xmdadocdt,
                                   xmda004,xmda002,xmdastus,xmda010,
                                   xmda009,xmda011,xmda035
                                   
             ON ACTION controlp INFIELD xmda031
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_xmda031()                       #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda031  #顯示到畫面上
                NEXT FIELD xmda031
                
             ON ACTION controlp INFIELD xmda050
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_icaa001()                       #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda050  #顯示到畫面上
                NEXT FIELD xmda050
                
             ON ACTION controlp INFIELD xmdadocno
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_xmdadocno_10()                   #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdadocno #顯示到畫面上
                NEXT FIELD xmdadocno
                
             ON ACTION controlp INFIELD xmda004
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                #CALL q_pmaa001()       #160909-00080#1 mark
                CALL q_pmaa001_6()      #160909-00080#1   
                DISPLAY g_qryparam.return1 TO xmda004 #顯示到畫面上
                NEXT FIELD xmda004
                
             ON ACTION controlp INFIELD xmda002
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooag001()                      #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda002 #顯示到畫面上
                NEXT FIELD xmda002
                
             ON ACTION controlp INFIELD xmda010
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.arg1 = '238'
                CALL q_oocq002()                      #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda010 #顯示到畫面上
                NEXT FIELD xmda010
                
             ON ACTION controlp INFIELD xmda009
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooib002_2()                    #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda009 #顯示到畫面上
                NEXT FIELD xmda009
                
             ON ACTION controlp INFIELD xmda011
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_oodb002_2()                    #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda011 #顯示到畫面上
                NEXT FIELD xmda011
                
             ON ACTION controlp INFIELD xmda035
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_isac003()                      #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda035 #顯示到畫面上
                NEXT FIELD xmda035
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_xmda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aicq100_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aicq100_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
            
               #150413---earl---add---s
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx2)
               CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx3)
               CALL DIALOG.setCurrentRow("s_detail4",g_detail_idx4)
               #150413---earl---add---e
            
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_xmda2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #150413---earl---add---s
               CALL aicq100_b_fill3()
               
               CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx2)
               CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx3)
               #150413---earl---add---e
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xmda3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx3
               LET g_detail_idx3 = l_ac
               DISPLAY g_detail_idx3 TO FORMONLY.idx
               
               #150413---earl---add---s
               CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx3)
               #150413---earl---add---e
               
         END DISPLAY
         
         DISPLAY ARRAY g_xmda4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 4
            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx4
               LET g_detail_idx4 = l_ac
               DISPLAY g_detail_idx4 TO FORMONLY.idx
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aicq100_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
          
            #end add-point
            NEXT FIELD xmda031
 
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
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL aicq100_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xmda_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xmda2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xmda_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xmda2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_xmda3_d)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_xmda4_d)
               LET g_export_id[4]   = "s_detail4"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aicq100_b_fill()
 
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
            CALL aicq100_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aicq100_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aicq100_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aicq100_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicq100_filter()
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
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
 
{<section id="aicq100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicq100_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_axm_sql       STRING
   DEFINE l_apm_sql       STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
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
 
   CALL g_xmda_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #組條件
   CALL aicq100_where(g_wc) RETURNING l_axm_sql,l_apm_sql
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','',xmdasite,xmda031,xmda050,'',xmdadocno,xmdadocdt,xmda004,'', 
       xmda002,'',xmdastus,xmda010,'',xmda009,'',xmda011,'',xmda035,''  ,DENSE_RANK() OVER( ORDER BY xmda_t.xmdadocno) AS RANK FROM xmda_t", 
 
 
#table2
                     " LEFT JOIN xmdc_t ON xmdcent = xmdaent AND xmdadocno = xmdcdocno",
 
                     "",
                     " WHERE xmdaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmda_t"),
                     " ORDER BY xmda_t.xmdadocno"
 
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
 
   LET g_sql = "SELECT '','',xmdasite,xmda031,xmda050,'',xmdadocno,xmdadocdt,xmda004,'',xmda002,'',xmdastus, 
       xmda010,'',xmda009,'',xmda011,'',xmda035,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #出貨
   LET g_sql = "SELECT UNIQUE 'N','1',xmdasite,xmda031,xmda050,",
               "              '',xmdadocno,xmdadocdt,xmda004,'',",
               "              xmda002,'',xmdastus,xmda010,'',",
               "              xmda009,'',xmda011,'',xmda035,''",
               "  FROM xmda_t LEFT OUTER JOIN xmdc_t ON xmdcent = xmdaent AND xmdadocno = xmdcdocno,",
               "       icaa_t LEFT OUTER JOIN icab_t ON icaaent = icabent AND icaa001 = icab001",
               " WHERE xmdaent = ?",
               "   AND icaaent = xmdaent",
               "   AND icaa001 = xmda050",
               "   AND icab002 = 0",
               "   AND icab003 = '",g_site,"'",
               "   AND xmdasite = icab003",
               "   AND ",l_axm_sql
   LET g_sql = g_sql, cl_sql_add_filter("xmda_t")
   #採購
   LET g_sql = g_sql," UNION ",
               "SELECT UNIQUE 'N',",
               "               CASE pmdl005 WHEN '1' THEN '2'",
               "                            WHEN '2' THEN '3' END,",
               "              pmdlsite,pmdl031,pmdl051,",
               "              '',pmdldocno,pmdldocdt,pmdl004,'',",
               "              pmdl002,'',pmdlstus,pmdl010,'',",
               "              pmdl009,'',pmdl011,'',pmdl033,''",
               "  FROM pmdl_t LEFT OUTER JOIN pmdn_t ON pmdnent = pmdlent AND pmdndocno = pmdldocno,",
               "       icaa_t LEFT OUTER JOIN icab_t ON icaaent = icabent AND icaa001 = icab001",
               " WHERE pmdlent = ",g_enterprise,
               "   AND icaaent = pmdlent",
               "   AND icaa001 = pmdl051",
               "   AND icab002 = 0",
               "   AND icab003 = '",g_site,"'",
               "   AND pmdlsite = icab003",
               "   AND (pmdl005 = '1' OR pmdl005 = '2')",
               "   AND (pmdl006 = '2' OR pmdl006 = '3' OR pmdl006 = '4')",
               "   AND ",l_apm_sql
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aicq100_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicq100_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmda_d[l_ac].sel,g_xmda_d[l_ac].doctype,g_xmda_d[l_ac].xmdasite,g_xmda_d[l_ac].xmda031, 
       g_xmda_d[l_ac].xmda050,g_xmda_d[l_ac].xmda050_desc,g_xmda_d[l_ac].xmdadocno,g_xmda_d[l_ac].xmdadocdt, 
       g_xmda_d[l_ac].xmda004,g_xmda_d[l_ac].xmda004_desc,g_xmda_d[l_ac].xmda002,g_xmda_d[l_ac].xmda002_desc, 
       g_xmda_d[l_ac].xmdastus,g_xmda_d[l_ac].xmda010,g_xmda_d[l_ac].xmda010_desc,g_xmda_d[l_ac].xmda009, 
       g_xmda_d[l_ac].xmda009_desc,g_xmda_d[l_ac].xmda011,g_xmda_d[l_ac].xmda011_desc,g_xmda_d[l_ac].xmda035, 
       g_xmda_d[l_ac].xmda035_desc
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
 
      CALL aicq100_detail_show("'1'")
 
      CALL aicq100_xmda_t_mask()
 
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
 
   CALL g_xmda_d.deleteElement(g_xmda_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmda_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aicq100_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aicq100_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aicq100_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmda_d.getLength() > 0 THEN
      CALL aicq100_b_fill2()
   END IF
 
      CALL aicq100_filter_show('xmdasite','b_xmdasite')
   CALL aicq100_filter_show('xmda031','b_xmda031')
   CALL aicq100_filter_show('xmda050','b_xmda050')
   CALL aicq100_filter_show('xmdadocno','b_xmdadocno')
   CALL aicq100_filter_show('xmdadocdt','b_xmdadocdt')
   CALL aicq100_filter_show('xmda004','b_xmda004')
   CALL aicq100_filter_show('xmda002','b_xmda002')
   CALL aicq100_filter_show('xmdastus','b_xmdastus')
   CALL aicq100_filter_show('xmda010','b_xmda010')
   CALL aicq100_filter_show('xmda009','b_xmda009')
   CALL aicq100_filter_show('xmda011','b_xmda011')
   CALL aicq100_filter_show('xmda035','b_xmda035')
   CALL aicq100_filter_show('xmdcdocno','b_xmdcdocno')
   CALL aicq100_filter_show('xmdcseq','b_xmdcseq')
   CALL aicq100_filter_show('xmdc019','b_xmdc019')
   CALL aicq100_filter_show('xmdc001','b_xmdc001')
   CALL aicq100_filter_show('xmdc002','b_xmdc002')
   CALL aicq100_filter_show('xmdc006','b_xmdc006')
   CALL aicq100_filter_show('xmdc007','b_xmdc007')
   CALL aicq100_filter_show('xmdl035','b_xmdl035')
   CALL aicq100_filter_show('xmdd014','b_xmdd014')
   CALL aicq100_filter_show('xrcb007','b_xrcb007')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aicq100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicq100_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_pmds_sql      STRING
   DEFINE l_xmdl_sql      STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_xmda2_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_xmda3_d.clear()
   CALL g_xmda4_d.clear()
   
   #出貨簽收量(xmdl035) 訂單->出貨 主帳套已請款數量(xmdl038) 
   LET l_sql = "SELECT COALESCE(SUM(xmdl035),0),COALESCE(SUM(xmdl038),0)",
               "  FROM xmdk_t",
              #"  LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno AND xmdldocno",   #151119-00010#1 mark
               "  LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno",   #151119-00010#1 add
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkstus != 'X'",
               "   AND xmdl003 = ?",
               "   AND xmdl004 = ?"
   PREPARE aicq100_pre FROM l_sql
   
   #採購->入庫 主帳套已請款數量(pmdt056)
   LET l_sql = "SELECT COALESCE(SUM(",
               "          CASE pmds000",
               "             WHEN '7' THEN pmdt056 * (-1)",
               "             WHEN '14' THEN pmdt056 * (-1)",
               "             WHEN '15' THEN pmdt056 * (-1)",
               "             ELSE pmdt056",
               "          END),0)",
               "  FROM pmds_t",
               "  LEFT OUTER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno",
               " WHERE pmdsent = ",g_enterprise,
               "   AND (pmds000 = '3' OR pmds000 = '6' OR pmds000 = '12' OR pmds000 = '13'",--入庫(正向)
               "    OR  pmds000 = '7' OR pmds000 = '14' OR pmds000 = '15')",                --倉退(負向)
               "   AND pmdsstus != 'X'",
               "   AND pmdt001 = ?",
               "   AND pmdt002 = ?"
   PREPARE aicq100_pre1 FROM l_sql
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '',xmdcdocno,xmdcseq,xmdc019,xmdc001,'','',xmdc002,xmdc006,'',xmdc007, 
          '','','' FROM xmdc_t",
                  "",
                  " WHERE xmdcent=? AND xmdcdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY xmdc_t.xmdcseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
   #依據單據類型判斷，撈出單據的明細資料
   CASE
      #訂單
      WHEN g_xmda_d[g_detail_idx].doctype = '1'
         LET g_sql = "SELECT UNIQUE '1',xmdcdocno,xmdcseq,xmdc019,xmdc001,",
                     "               '','',xmdc002,xmdc006,'',",
                     "               xmdc007,0,COALESCE(SUM(xmdd014),0),0",
                     "  FROM xmdc_t",
                     "  LEFT OUTER JOIN xmda_t ON xmdcent = xmdaent",
                     "                        AND xmdcdocno = xmdadocno",
                     "  LEFT OUTER JOIN xmdd_t ON xmdcent = xmddent",
                     "                        AND xmdcdocno = xmdddocno",
                     "                        AND xmdcseq = xmddseq",
                     " WHERE xmdcent = ?",
                     "   AND xmdcdocno = ?",
                     "   AND xmdastus != 'X'"
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         LET g_sql = g_sql,
                     " GROUP BY xmdcdocno,xmdcseq,xmdc019,xmdc001,",
                     "          xmdc002,xmdc006,xmdc007",
                     " ORDER BY xmdc_t.xmdcseq"
      #採購
      WHEN g_xmda_d[g_detail_idx].doctype = '2' OR g_xmda_d[g_detail_idx].doctype = '3'
         LET g_sql = "SELECT UNIQUE '",g_xmda_d[g_detail_idx].doctype,"',",
                     "              pmdndocno,pmdnseq,pmdn019,pmdn001,",
                     "              '','',pmdn002,pmdn006,'',",
                     "              pmdn007,0,COALESCE(SUM(pmdo019),0),0",
                     "  FROM pmdn_t",
                     "  LEFT OUTER JOIN pmdl_t ON pmdlent = pmdnent",
                     "                        AND pmdldocno = pmdndocno",
                     "  LEFT OUTER JOIN pmdo_t ON pmdnent = pmdoent",
                     "                        AND pmdndocno = pmdodocno",
                     "                        AND pmdnseq = pmdoseq",
                     " WHERE pmdnent = ?",
                     "   AND pmdndocno = ?",
                     "   AND pmdlstus != 'X'"
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         LET g_sql = g_sql,
                     " GROUP BY pmdndocno,pmdnseq,pmdn019,pmdn001,",
                     "          pmdn002,pmdn006,pmdn007",
                     " ORDER BY pmdn_t.pmdnseq"
   END CASE
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE aicq100_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR aicq100_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
      INTO g_xmda2_d[l_ac].doctype1,g_xmda2_d[l_ac].xmdcdocno,g_xmda2_d[l_ac].xmdcseq,g_xmda2_d[l_ac].xmdc019, 
          g_xmda2_d[l_ac].xmdc001,g_xmda2_d[l_ac].xmdc001_desc,g_xmda2_d[l_ac].xmdc001_desc_desc,g_xmda2_d[l_ac].xmdc002, 
          g_xmda2_d[l_ac].xmdc006,g_xmda2_d[l_ac].xmdc006_desc,g_xmda2_d[l_ac].xmdc007,g_xmda2_d[l_ac].xmdl035, 
          g_xmda2_d[l_ac].xmdd014,g_xmda2_d[l_ac].xrcb007
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      CASE
         #訂單
         WHEN g_xmda_d[g_detail_idx].doctype = '1'
            #出貨簽收量
            EXECUTE aicq100_pre USING g_xmda2_d[l_ac].xmdcdocno,g_xmda2_d[l_ac].xmdcseq
                                 INTO g_xmda2_d[l_ac].xmdl035,g_xmda2_d[l_ac].xrcb007
                                 
         #採購
         WHEN g_xmda_d[g_detail_idx].doctype = '2' OR g_xmda_d[g_detail_idx].doctype = '3'
            EXECUTE aicq100_pre1 USING g_xmda2_d[l_ac].xmdcdocno,g_xmda2_d[l_ac].xmdcseq
                                  INTO g_xmda2_d[l_ac].xrcb007
      END CASE
      #end add-point
 
      CALL aicq100_detail_show("'2'")
 
      CALL aicq100_xmdc_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_xmda2_d.deleteElement(g_xmda2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_xmda2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   #table3
#150410---earl---mod---s
CALL aicq100_b_fill3()   #以下全部改寫並搬至b_fill3
#   LET g_sql = "SELECT icab002,                   icab003,                           '',",
#               "       COALESCE(SUM(x.xmdd005),0),COALESCE(SUM(x.xmdd031),0),COALESCE(SUM(x.xmdp016),0),",
#               "       COALESCE(SUM(x.xmdl035),0),COALESCE(SUM(x.xmdl036),0),COALESCE(SUM(x.xmdd014),0),",
#               "       COALESCE(SUM(x.xmdl038),0),COALESCE(SUM(x.xmdd015),0),COALESCE(SUM(y.pmdn007),0),",
#               "       COALESCE(SUM(y.pmdo015),0),0,                         COALESCE(SUM(y.pmdo019),0),",
#               "       0,                         COALESCE(SUM(y.pmdo040),0),x.xmda015,",
#               "       '',                        y.pmdl015,                 '',",
#               "       COALESCE(SUM(x.xmdc046),0),COALESCE(SUM(x.xmdc047),0),COALESCE(SUM(x.xmdc048),0),",
#               "       COALESCE(SUM(pmdn046),0),  COALESCE(SUM(pmdn047),0),  COALESCE(SUM(pmdn048),0)",
#               "  FROM icab_t",
#               "  LEFT OUTER JOIN (SELECT xmdcent,   xmdcsite,xmda031,   xmdadocno,",   #訂單
#               "                          xmdd005,   xmdd031, t2.xmdp016,t1.xmdl035,",
#               "                          t1.xmdl036,xmdd014, t1.xmdl038,xmda015,",
#               "                          xmdd015,   xmdc046, xmdc047,   xmdc048",
#               "                     FROM xmda_t,xmdc_t",
#               "                     LEFT OUTER JOIN xmdd_t ON xmdcent = xmddent AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq",
#               "                     LEFT OUTER JOIN (SELECT xmdlent,xmdl003,xmdl004,xmdl035,xmdl036,xmdl038",
#               "                                        FROM xmdk_t",
#               "                                        LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno",
#               "                                       WHERE xmdkstus != 'X' AND xmdk000 = '1') t1",
#               "                       ON t1.xmdlent = xmdcent AND t1.xmdl003 = xmdcdocno AND t1.xmdl004 = xmdcseq",
#               "                     LEFT OUTER JOIN (SELECT xmdpent,xmdp003,xmdp004,xmdp016",
#               "                                        FROM xmdo_t",
#               "                                        LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
#               "                                       WHERE xmdostus != 'X') t2",
#               "                       ON t2.xmdpent = xmdcent AND t2.xmdp003 = xmdcdocno AND t2.xmdp004 = xmdcseq",
#               "                    WHERE xmdcent = xmdaent AND xmdcdocno = xmdadocno) x",
#               "    ON x.xmdcent = icabent AND x.xmdcsite = icab003 AND (x.xmda031 = ? OR x.xmdadocno = '",g_xmda_d[g_detail_idx].xmdadocno,"')",
#               "  LEFT OUTER JOIN (SELECT pmdnent,pmdnsite,pmdl031,pmdn007,pmdo015,",    #採購
#               "                          pmdo019,pmdo040, pmdn046,pmdn047,pmdn048,",
#               "                          pmdl015",
#               "                     FROM pmdn_t", 
#               "                     LEFT OUTER JOIN pmdl_t ON pmdnent = pmdlent AND pmdndocno = pmdldocno",
#               "                     LEFT OUTER JOIN pmdo_t ON pmdnent = pmdoent AND pmdndocno = pmdodocno AND pmdnseq = pmdoseq",
#               "                     LEFT OUTER JOIN (SELECT pmdtent,pmdt001,pmdt002,pmdt056",
#               "                                        FROM pmds_t",
#               "                                        LEFT OUTER JOIN pmdt_t ON pmdsent = pmdsent AND pmdtdocno = pmdsdocno",
#               "                                       WHERE pmdsstus != 'X' AND pmds000 = '3' OR pmds000 = '6') t3",
#               "                       ON t3.pmdtent = pmdlent AND t3.pmdt001 = pmdldocno AND t3.pmdt002 = pmdnseq) y",
#               "    ON y.pmdnent = icabent AND y.pmdnsite = icab003 AND y.pmdl031 = ?",
#               "    WHERE icabent = ",g_enterprise,
#               "      AND icab001 = ?",
#               " GROUP BY icab002,icab003,x.xmda015,pmdl015",
#               " ORDER BY icab002"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE aicq100_pb3 FROM g_sql
#   DECLARE b_fill_curs3 CURSOR FOR aicq100_pb3
# 
#   OPEN b_fill_curs3 USING g_xmda_d[g_detail_idx].xmda031,g_xmda_d[g_detail_idx].xmda031,g_xmda_d[g_detail_idx].xmda050
# 
#   LET l_ac = 1
#   FOREACH b_fill_curs3 INTO g_xmda3_d[l_ac].icab002,g_xmda3_d[l_ac].icab003,g_xmda3_d[l_ac].icab003_desc,
#                             g_xmda3_d[l_ac].xmdd005,g_xmda3_d[l_ac].xmdd031,g_xmda3_d[l_ac].xmdp016,
#                             g_xmda3_d[l_ac].xmdl0351,g_xmda3_d[l_ac].xmdl036,g_xmda3_d[l_ac].xmdd0141,
#                             g_xmda3_d[l_ac].xrcb0071,g_xmda3_d[l_ac].xmdd015,g_xmda3_d[l_ac].pmdn007,
#                             g_xmda3_d[l_ac].pmdo015,g_xmda3_d[l_ac].qcba017,g_xmda3_d[l_ac].pmdo019,
#                             g_xmda3_d[l_ac].apcb007,g_xmda3_d[l_ac].pmdo040,g_xmda3_d[l_ac].xmda0152,
#                             g_xmda3_d[l_ac].xmda0152_desc,g_xmda3_d[l_ac].pmdl015,g_xmda3_d[l_ac].pmdl015_desc,
#                             g_xmda3_d[l_ac].xmdc046,g_xmda3_d[l_ac].xmdc047,g_xmda3_d[l_ac].xmdc048,
#                             g_xmda3_d[l_ac].pmdn046,g_xmda3_d[l_ac].pmdn047,g_xmda3_d[l_ac].pmdn048
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#
#      CALL aicq100_detail_show("'3'")
# 
#      IF l_ac > g_max_rec THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend =  "" 
#         LET g_errparam.code   =  9035 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      LET l_ac = l_ac + 1
# 
#   END FOREACH
#   
#   CALL g_xmda3_d.deleteElement(g_xmda3_d.getLength())
#   LET li_ac = g_xmda3_d.getLength()
# 
#   DISPLAY li_ac TO FORMONLY.cnt
#   LET g_detail_idx3 = 1
#   DISPLAY g_detail_idx3 TO FORMONLY.idx
#   
#   #table4
#   LET l_sql = " 1=1"
#   
#   #訂單
#   #訂單 -> 出通單 -> 出貨 -> 簽收 -> 簽退
#   #訂單 -> 出貨 -> 簽收 -> 簽退
#   #訂單 -> 出貨 -> 銷退
#   #訂單 -> 出貨 -> 簽收-> 銷退
#   LET l_xmdl_sql =
#      " OR EXISTS (SELECT t1.xmdg055",
#      "              FROM (SELECT xmdg055",           #出通
#      "                      FROM xmdg_t",
#      "                      LEFT OUTER JOIN xmdh_t ON xmdgent = xmdhent AND xmdgdocno = xmdhdocno",
#      "                     WHERE xmdgent = ",g_enterprise,
#      "                       AND xmdgstus != 'X'",
#      "                       AND xmdh001 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#      "                    UNION ALL",
#      "                    SELECT DISTINCT xmdk035",  #出貨 簽收 簽退 銷退
#      "                      FROM xmdk_t",
#      "                      LEFT OUTER JOIN xmdl_t ON xmdlent = xmdkent AND xmdldocno = xmdkdocno",
#      "                     WHERE xmdkent = ",g_enterprise,
#      "                       AND xmdkstus != 'X'",
#      "                       AND xmdl003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#      "                    UNION ALL",
#      "                    SELECT xmdo055",           #Invoice
#      "                      FROM xmdo_t",
#      "                      LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
#      "                     WHERE xmdoent = ",g_enterprise,
#      "                       AND xmdostus != 'X'",
#      "                       AND xmdp003 = '",g_xmda_d[g_detail_idx].xmdadocno,"')  t1",
#      "             WHERE t1.xmdg055 = "
#   
#   #採購單
#   #採購 -> 收貨單 -> 入庫單
#   #收貨單 單號, 入庫單 多角流程序號
#   LET l_pmds_sql =
#      " OR EXISTS (SELECT 1",
#      "              FROM (SELECT pmds053, pmds041",
#      "                      FROM pmds_t",       --收貨
#      "                     WHERE pmdsent = ",g_enterprise,
#      "                       AND pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#      "                       AND pmdsstus != 'X'",
#      "                    UNION ALL",
#      "                    SELECT t1.pmds053, t1.pmds041",
#      "                      FROM pmds_t t1,",   --入庫
#      "                           pmds_t t2 ",   --收貨
#      "                     WHERE t1.pmdsent = t2.pmdsent",
#      "                       AND t1.pmds006 = t2.pmdsdocno",
#      "                       AND t2.pmdsent = ",g_enterprise,
#      "                       AND t2.pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#      "                       AND t1.pmdsstus != 'X'",
#      "                       AND t2.pmdsstus != 'X'",
#      "                    UNION ALL",
#      "                    SELECT t1.pmds053, t1.pmds041",
#      "                      FROM pmds_t t1,",   --倉退
#      "                           pmds_t t2,",   --入庫
#      "                           pmds_t t3 ",   --收貨
#      "                     WHERE t1.pmdsent = t2.pmdsent",
#      "                       AND t1.pmdsdocno = t2.pmds006",
#      "                       AND t2.pmdsent = t3.pmdsent",
#      "                       AND t2.pmds006 = t3.pmdsdocno",
#      "                       AND t1.pmdsstus != 'X'",
#      "                       AND t2.pmdsstus != 'X'",
#      "                       AND t3.pmdsstus != 'X'",
#      "                       AND t3.pmdsent = ",g_enterprise,
#      "                       AND t3.pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#      "                    UNION ALL",
#      "                    SELECT t1.pmds053,t1.pmds041",
#      "                      FROM pmds_t t1,",  --倉退
#      "                           pmds_T t2 ",  --收貨入庫
#      "                     WHERE t1.pmdsent = t2.pmdsent",
#      "                       AND t1.pmds006 = t2.pmdsdocno",
#      "                       AND t1.pmdsstus != 'X'",
#      "                       AND t2.pmdsstus != 'X'",
#      "                       AND t2.pmdsent = ",g_enterprise,
#      "                       AND t2.pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"') c",
#      "             WHERE c.pmds041 = d.pmds041 and c.pmds053 = d.pmds053)"
#   
#   #訂單
#   LET g_sql = "SELECT xmda031,  icab002,icab003,'',     '1',",
#               "       xmdadocno,xmda010,'',     xmda009,'',",
#               "       xmda011,  '',     xmda035,'',     xmda015,",
#               "       '',       xmdcseq,xmdc019,xmdc001,'',",
#               "       '',       xmdc002,xmdc006,'',     xmdc007,",
#               "       xmdc010,  '',     xmdc011,xmdc003,xmdc015,",
#               "       xmdc046,xmdc047,xmdc048",
#               "  FROM icab_t,xmda_t",
#               "  LEFT OUTER JOIN xmdc_t ON xmdaent = xmdcent AND xmdadocno = xmdcdocno",
#               " WHERE xmdaent = icabent",
#               "   AND xmdasite = icab003",
#               "   AND xmdastus != 'X'",
#               "   AND xmdaent = ",g_enterprise,
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND xmda031 = '",g_xmda_d[g_detail_idx].xmda031,"'",     #多角流程序號
#               "   AND ",l_sql
#   #如果第0站是1.訂單 排除原單據
#   IF g_xmda_d[g_detail_idx].doctype = '1' THEN
#      LET g_sql = g_sql," AND xmdadocno != '",g_xmda_d[g_detail_idx].xmdadocno,"'"
#   END IF
#   #採購單
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT pmdl031,  icab002,icab003,'',     '2',",
#               "       pmdldocno,pmdl010,'',     pmdl009,'',",
#               "       pmdl011,  '',     pmdl033,'',     pmdl015,",
#               "       '',       pmdnseq,pmdn019,pmdn001,'',",
#               "       '',       pmdn002,pmdn006,'',     pmdn007,",
#               "       pmdn010,  '',     pmdn011,pmdn003,pmdn015,",
#               "       pmdn046,pmdn047,pmdn048",
#               "  FROM icab_t,pmdl_t",
#               "  LEFT OUTER JOIN pmdn_t ON pmdlent = pmdnent AND pmdldocno = pmdndocno",
#               " WHERE pmdlent = icabent",
#               "   AND pmdlsite = icab003",
#               "   AND pmdlstus != 'X'",
#               "   AND pmdlent = ",g_enterprise,
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND pmdl031 = '",g_xmda_d[g_detail_idx].xmda031,"'",     #多角流程序號
#               "   AND ",l_sql
#   #如果第0站是1.採購單 排除原單據
#   IF g_xmda_d[g_detail_idx].doctype = '2' THEN
#      LET g_sql = g_sql," AND pmdldocno != '",g_xmda_d[g_detail_idx].xmdadocno,"'"
#   END IF
#   #出貨通知單
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT xmdg055,  icab002,icab003,'',     '5',",
#               "       xmdgdocno,xmdg009,'',     xmdg008,'',",
#               "       xmdg010,  '',     xmdg013,'',     xmdg014,",
#               "       '',       xmdhseq,xmdh005,xmdh006,'',",
#               "       '',       xmdh007,xmdh015,'',     xmdh017,",
#               "       xmdh020,  '',     xmdh021,xmdh008,xmdh023,",
#               "       xmdh026,xmdh027,xmdh028",
#               "  FROM icab_t,xmdg_t",
#               "  LEFT OUTER JOIN xmdh_t ON xmdgent = xmdhent AND xmdgdocno = xmdhdocno",
#               " WHERE xmdgent = icabent",
#               "   AND xmdgsite = icab003",
#               "   AND xmdgstus != 'X'",
#               "   AND xmdgent = ",g_enterprise,
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND (xmdg055 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
#               "    OR xmdh001 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#                       l_xmdl_sql,"xmdg055))",
#               "   AND ",l_sql
#   #Invoice單
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT xmdo055,  icab002,icab003,'',     '6',",
#               "       xmdodocno,xmdo011,'',     xmdo010,'',",
#               "       xmdo012,  '',     xmdo015,'',     xmdo016,",
#               "       '',       xmdpseq,xmdp007,xmdp008,'',",
#               "       '',       xmdp009,xmdp015,'',     xmdp016,",
#               "       xmdp019,  '',     xmdp020,xmdp012,xmdp021,",
#               "       xmdp024,  xmdp025,  xmdp026",
#               "  FROM icab_t,xmdo_t",
#               "  LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
#               " WHERE xmdoent = icabent",
#               "   AND xmdosite = icab003",
#               "   AND xmdostus != 'X'",
#               "   AND xmdoent = ",g_enterprise,
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND (xmdo055 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
#               "    OR xmdp003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#                       l_xmdl_sql,"xmdo055))",
#               "   AND ",l_sql
#   #出貨單 銷退單 簽收單 簽退單
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT xmdk035,  icab002,icab003,'',",
#               "       CASE xmdk000 WHEN '1' THEN '8'",
#               "                    WHEN '4' THEN '17'",
#               "                    WHEN '5' THEN '18'",
#               "                    WHEN '6' THEN '13' END,",
#               "       xmdkdocno,xmdk011,'',     xmdk010,'',",
#               "       xmdk012,  '',     xmdk015,'',     xmdk016,",
#               "       '',       xmdlseq,xmdl007,xmdl008,'',",
#               "       '',       xmdl009,xmdl017,'',     xmdl018,",
#               "       xmdl021,  '',     xmdl022,xmdl010,xmdl024,",
#               "       xmdl027,  xmdl028,xmdl029",
#               "  FROM icab_t,xmdk_t",
#               "  LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno",
#               " WHERE xmdkent = icabent",
#               "   AND xmdksite = icab003",
#               "   AND xmdkstus != 'X'",
#               "   AND xmdkent = ",g_enterprise,
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND (xmdk035 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
#               "    OR xmdl003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#                       l_xmdl_sql,"xmdk035))",
#               "   AND ",l_sql
#   #收貨單 入庫單 倉退單
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT d.pmds041,  icab002,icab003,  '',",
#               "       CASE d.pmds000 WHEN '1' THEN '9'",
#               "                      WHEN '3' THEN '10'",
#               "                      WHEN '6' THEN '10'",
#               "                      WHEN '7' THEN '14' END,",
#               "       d.pmdsdocno,d.pmds032,'',     d.pmds031,'',",
#               "       d.pmds033,  '',       ''      ,'',      d.pmds037,",
#               "       '',       pmdtseq,pmdt005,pmdt006,'',",
#               "       '',       pmdt007,pmdt019,'',     pmdt020,",
#               "       pmdt023,  '',     pmdt024,pmdt008,pmdt036,",
#               "       pmdt038,  pmdt039,pmdt047",
#               "  FROM icab_t,pmds_t d",
#               "  LEFT OUTER JOIN pmdt_t ON d.pmdsent = pmdtent AND d.pmdsdocno = pmdtdocno",
#               " WHERE d.pmdsent = icabent",
#               "   AND d.pmdssite = icab003",
#               "   AND d.pmdsstus != 'X'",
#               "   AND d.pmdsent = ",g_enterprise,
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",       #多角流程代碼
#               "   AND (d.pmds041 = '",g_xmda_d[g_detail_idx].xmda031,"'",
#                       l_pmds_sql,")", #多角流程序號
#               "   AND ",l_sql
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE aicq100_pb4 FROM g_sql
#   DECLARE b_fill_curs4 CURSOR FOR aicq100_pb4
# 
#   OPEN b_fill_curs4
# 
#   LET l_ac = 1
#   FOREACH b_fill_curs4 INTO g_xmda4_d[l_ac].xmda0312,g_xmda4_d[l_ac].icab002,g_xmda4_d[l_ac].xmdasite2,
#                             g_xmda4_d[l_ac].xmdasite2_desc,g_xmda4_d[l_ac].doctype2,g_xmda4_d[l_ac].xmdadocno2,
#                             g_xmda4_d[l_ac].xmda0102,g_xmda4_d[l_ac].xmda0102_desc,g_xmda4_d[l_ac].xmda0092,
#                             g_xmda4_d[l_ac].xmda0092_desc,g_xmda4_d[l_ac].xmda0112,g_xmda4_d[l_ac].xmda0112_desc,
#                             g_xmda4_d[l_ac].xmda0352,g_xmda4_d[l_ac].xmda0352_desc,g_xmda4_d[l_ac].xmda015,
#                             g_xmda4_d[l_ac].xmda015_desc,g_xmda4_d[l_ac].xmdcseq2,g_xmda4_d[l_ac].xmdc0192,
#                             g_xmda4_d[l_ac].xmdc0012,g_xmda4_d[l_ac].xmdc0012_desc,g_xmda4_d[l_ac].xmdc0012_desc_desc,
#                             g_xmda4_d[l_ac].xmdc0022,g_xmda4_d[l_ac].xmdc0062,g_xmda4_d[l_ac].xmdc0062_desc,
#                             g_xmda4_d[l_ac].xmdc0072,g_xmda4_d[l_ac].xmdc010,g_xmda4_d[l_ac].xmdc010_desc,
#                             g_xmda4_d[l_ac].xmdc011,g_xmda4_d[l_ac].xmdc003,g_xmda4_d[l_ac].xmdc0152,
#                             g_xmda4_d[l_ac].xmdc0462,g_xmda4_d[l_ac].xmdc0472,g_xmda4_d[l_ac].xmdc0482
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      
#      CALL aicq100_detail_show("'4'")
# 
#      IF l_ac > g_max_rec THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend =  "" 
#         LET g_errparam.code   =  9035 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      LET l_ac = l_ac + 1
# 
#   END FOREACH
#   
#   CALL g_xmda4_d.deleteElement(g_xmda4_d.getLength())
#   LET li_ac = g_xmda4_d.getLength()
# 
#   DISPLAY li_ac TO FORMONLY.cnt
#   LET g_detail_idx4 = 1
#   DISPLAY g_detail_idx4 TO FORMONLY.idx
#150410---earl---mod---e   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aicq100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicq100_detail_show(ps_page)
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
      
      #151119-00002#1--mark--(s) 
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_xmda_d[l_ac].xmda050
      #LET ls_sql = "SELECT icaal004 FROM icaal_t WHERE icaalent='"||g_enterprise||"' AND icaal001=? AND icaal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_xmda_d[l_ac].xmda050_desc = '', g_rtn_fields[1] , ''
      #151119-00002#1--mark--(e) 
      #多角流程代碼
      CALL s_desc_get_icaa001_desc(g_xmda_d[l_ac].xmda050) RETURNING g_xmda_d[l_ac].xmda050_desc  #151119-00002#1
      DISPLAY BY NAME g_xmda_d[l_ac].xmda050_desc
     
      #客戶/廠商編號
      CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda004) 
         RETURNING g_xmda_d[l_ac].xmda004_desc
      DISPLAY BY NAME g_xmda_d[l_ac].xmda004_desc

      #業務員/採購員編號
      CALL s_desc_get_person_desc(g_xmda_d[l_ac].xmda002)
         RETURNING g_xmda_d[l_ac].xmda002_desc
      DISPLAY BY NAME g_xmda_d[l_ac].xmda002_desc

      #交易條件
      CALL s_desc_get_acc_desc('238',g_xmda_d[l_ac].xmda010)
         RETURNING g_xmda_d[l_ac].xmda010_desc
      DISPLAY BY NAME g_xmda_d[l_ac].xmda010_desc

      #收/付款條件
      CALL s_desc_get_ooib002_desc(g_xmda_d[l_ac].xmda009)
         RETURNING g_xmda_d[l_ac].xmda009_desc
      DISPLAY BY NAME g_xmda_d[l_ac].xmda009_desc

      #稅別
      CALL s_desc_get_tax_desc1(g_xmda_d[l_ac].xmdasite,g_xmda_d[l_ac].xmda011)
         RETURNING g_xmda_d[l_ac].xmda011_desc
      DISPLAY BY NAME g_xmda_d[l_ac].xmda011_desc

      #發票類型
      CALL s_desc_get_invoice_type_desc1(g_xmda_d[l_ac].xmdasite,g_xmda_d[l_ac].xmda035)
         RETURNING g_xmda_d[l_ac].xmda035_desc
      DISPLAY BY NAME g_xmda_d[l_ac].xmda035_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      #商品編號 品名規格
      CALL s_desc_get_item_desc(g_xmda2_d[l_ac].xmdc001)
         RETURNING g_xmda2_d[l_ac].xmdc001_desc,g_xmda2_d[l_ac].xmdc001_desc_desc
      DISPLAY BY NAME g_xmda2_d[l_ac].xmdc001_desc,g_xmda2_d[l_ac].xmdc001_desc_desc

      #銷售/採購單位
      CALL s_desc_get_unit_desc(g_xmda2_d[l_ac].xmdc006)
         RETURNING g_xmda2_d[l_ac].xmdc006_desc
      DISPLAY BY NAME g_xmda2_d[l_ac].xmdc006_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #營運據點
      CALL s_desc_get_department_desc(g_xmda3_d[l_ac].icab003) 
         RETURNING g_xmda3_d[l_ac].icab003_desc
      DISPLAY BY NAME g_xmda3_d[l_ac].icab003_desc
      
      #採購幣別
      CALL s_desc_get_currency_desc(g_xmda3_d[l_ac].pmdl015)
         RETURNING g_xmda3_d[l_ac].pmdl015_desc
      DISPLAY BY NAME g_xmda3_d[l_ac].pmdl015_desc
      
      #訂單幣別
      CALL s_desc_get_currency_desc(g_xmda3_d[l_ac].xmda0152)
         RETURNING g_xmda3_d[l_ac].xmda0152_desc
      DISPLAY BY NAME g_xmda3_d[l_ac].xmda0152_desc
   END IF
   
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #營運據點
      CALL s_desc_get_department_desc(g_xmda4_d[l_ac].xmdasite2) 
         RETURNING g_xmda4_d[l_ac].xmdasite2_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmdasite2_desc
      
      #交易條件
      CALL s_desc_get_acc_desc('238',g_xmda4_d[l_ac].xmda0102)
         RETURNING g_xmda4_d[l_ac].xmda0102_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmda0102_desc
      
      #收/付款條件
      CALL s_desc_get_ooib002_desc(g_xmda4_d[l_ac].xmda0092)
         RETURNING g_xmda4_d[l_ac].xmda0092_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmda0092_desc
      
      #稅別
      CALL s_desc_get_tax_desc1(g_xmda4_d[l_ac].xmdasite2,g_xmda4_d[l_ac].xmda0112)
         RETURNING g_xmda4_d[l_ac].xmda0112_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmda0112_desc
      
      #發票類型
      CALL s_desc_get_invoice_type_desc1(g_xmda4_d[l_ac].xmdasite2,g_xmda4_d[l_ac].xmda0352)
         RETURNING g_xmda4_d[l_ac].xmda0352_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmda0352_desc
      
      #幣別
      CALL s_desc_get_currency_desc(g_xmda4_d[l_ac].xmda015)
         RETURNING g_xmda4_d[l_ac].xmda015_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmda015_desc
      
      #料件編號
      CALL s_desc_get_item_desc(g_xmda4_d[l_ac].xmdc0012)
         RETURNING g_xmda4_d[l_ac].xmdc0012_desc,g_xmda4_d[l_ac].xmdc0012_desc_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmdc0012_desc,g_xmda4_d[l_ac].xmdc0012_desc_desc
      
      #銷售/採購單位
      CALL s_desc_get_unit_desc(g_xmda4_d[l_ac].xmdc0062)
         RETURNING g_xmda4_d[l_ac].xmdc0062_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmdc0062_desc
      
      #計價單位
      CALL s_desc_get_unit_desc(g_xmda4_d[l_ac].xmdc010)
         RETURNING g_xmda4_d[l_ac].xmdc010_desc
      DISPLAY BY NAME g_xmda4_d[l_ac].xmdc010_desc
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicq100.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aicq100_filter()
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
      CONSTRUCT g_wc_filter ON xmdasite,xmda031,xmda050,xmdadocno,xmdadocdt,xmda004,xmda002,xmdastus, 
          xmda010,xmda009,xmda011,xmda035
                          FROM s_detail1[1].b_xmdasite,s_detail1[1].b_xmda031,s_detail1[1].b_xmda050, 
                              s_detail1[1].b_xmdadocno,s_detail1[1].b_xmdadocdt,s_detail1[1].b_xmda004, 
                              s_detail1[1].b_xmda002,s_detail1[1].b_xmdastus,s_detail1[1].b_xmda010, 
                              s_detail1[1].b_xmda009,s_detail1[1].b_xmda011,s_detail1[1].b_xmda035
 
         BEFORE CONSTRUCT
                     DISPLAY aicq100_filter_parser('xmdasite') TO s_detail1[1].b_xmdasite
            DISPLAY aicq100_filter_parser('xmda031') TO s_detail1[1].b_xmda031
            DISPLAY aicq100_filter_parser('xmda050') TO s_detail1[1].b_xmda050
            DISPLAY aicq100_filter_parser('xmdadocno') TO s_detail1[1].b_xmdadocno
            DISPLAY aicq100_filter_parser('xmdadocdt') TO s_detail1[1].b_xmdadocdt
            DISPLAY aicq100_filter_parser('xmda004') TO s_detail1[1].b_xmda004
            DISPLAY aicq100_filter_parser('xmda002') TO s_detail1[1].b_xmda002
            DISPLAY aicq100_filter_parser('xmdastus') TO s_detail1[1].b_xmdastus
            DISPLAY aicq100_filter_parser('xmda010') TO s_detail1[1].b_xmda010
            DISPLAY aicq100_filter_parser('xmda009') TO s_detail1[1].b_xmda009
            DISPLAY aicq100_filter_parser('xmda011') TO s_detail1[1].b_xmda011
            DISPLAY aicq100_filter_parser('xmda035') TO s_detail1[1].b_xmda035
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_doctype>>----
         #----<<b_xmdasite>>----
         #Ctrlp:construct.c.filter.page1.b_xmdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdasite
            #add-point:ON ACTION controlp INFIELD b_xmdasite name="construct.c.filter.page1.b_xmdasite"
            
            #END add-point
 
 
         #----<<b_xmda031>>----
         #Ctrlp:construct.c.filter.page1.b_xmda031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda031
            #add-point:ON ACTION controlp INFIELD b_xmda031 name="construct.c.filter.page1.b_xmda031"
            
            #END add-point
 
 
         #----<<b_xmda050>>----
         #Ctrlp:construct.c.filter.page1.b_xmda050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda050
            #add-point:ON ACTION controlp INFIELD b_xmda050 name="construct.c.filter.page1.b_xmda050"
            
            #END add-point
 
 
         #----<<b_xmda050_desc>>----
         #----<<b_xmdadocno>>----
         #Ctrlp:construct.c.filter.page1.b_xmdadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdadocno
            #add-point:ON ACTION controlp INFIELD b_xmdadocno name="construct.c.filter.page1.b_xmdadocno"
            
            #END add-point
 
 
         #----<<b_xmdadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdadocdt
            #add-point:ON ACTION controlp INFIELD b_xmdadocdt name="construct.c.filter.page1.b_xmdadocdt"
            
            #END add-point
 
 
         #----<<b_xmda004>>----
         #Ctrlp:construct.c.filter.page1.b_xmda004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda004
            #add-point:ON ACTION controlp INFIELD b_xmda004 name="construct.c.filter.page1.b_xmda004"
            
            #END add-point
 
 
         #----<<b_xmda004_desc>>----
         #----<<b_xmda002>>----
         #Ctrlp:construct.c.filter.page1.b_xmda002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda002
            #add-point:ON ACTION controlp INFIELD b_xmda002 name="construct.c.filter.page1.b_xmda002"
            
            #END add-point
 
 
         #----<<b_xmda002_desc>>----
         #----<<b_xmdastus>>----
         #Ctrlp:construct.c.filter.page1.b_xmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdastus
            #add-point:ON ACTION controlp INFIELD b_xmdastus name="construct.c.filter.page1.b_xmdastus"
            
            #END add-point
 
 
         #----<<b_xmda010>>----
         #Ctrlp:construct.c.filter.page1.b_xmda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda010
            #add-point:ON ACTION controlp INFIELD b_xmda010 name="construct.c.filter.page1.b_xmda010"
            
            #END add-point
 
 
         #----<<b_xmda010_desc>>----
         #----<<b_xmda009>>----
         #Ctrlp:construct.c.filter.page1.b_xmda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda009
            #add-point:ON ACTION controlp INFIELD b_xmda009 name="construct.c.filter.page1.b_xmda009"
            
            #END add-point
 
 
         #----<<b_xmda009_desc>>----
         #----<<b_xmda011>>----
         #Ctrlp:construct.c.filter.page1.b_xmda011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda011
            #add-point:ON ACTION controlp INFIELD b_xmda011 name="construct.c.filter.page1.b_xmda011"
            
            #END add-point
 
 
         #----<<b_xmda011_desc>>----
         #----<<b_xmda035>>----
         #Ctrlp:construct.c.filter.page1.b_xmda035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda035
            #add-point:ON ACTION controlp INFIELD b_xmda035 name="construct.c.filter.page1.b_xmda035"
            
            #END add-point
 
 
         #----<<b_xmda035_desc>>----
 
 
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
 
      CALL aicq100_filter_show('xmdasite','b_xmdasite')
   CALL aicq100_filter_show('xmda031','b_xmda031')
   CALL aicq100_filter_show('xmda050','b_xmda050')
   CALL aicq100_filter_show('xmdadocno','b_xmdadocno')
   CALL aicq100_filter_show('xmdadocdt','b_xmdadocdt')
   CALL aicq100_filter_show('xmda004','b_xmda004')
   CALL aicq100_filter_show('xmda002','b_xmda002')
   CALL aicq100_filter_show('xmdastus','b_xmdastus')
   CALL aicq100_filter_show('xmda010','b_xmda010')
   CALL aicq100_filter_show('xmda009','b_xmda009')
   CALL aicq100_filter_show('xmda011','b_xmda011')
   CALL aicq100_filter_show('xmda035','b_xmda035')
   CALL aicq100_filter_show('xmdcdocno','b_xmdcdocno')
   CALL aicq100_filter_show('xmdcseq','b_xmdcseq')
   CALL aicq100_filter_show('xmdc019','b_xmdc019')
   CALL aicq100_filter_show('xmdc001','b_xmdc001')
   CALL aicq100_filter_show('xmdc002','b_xmdc002')
   CALL aicq100_filter_show('xmdc006','b_xmdc006')
   CALL aicq100_filter_show('xmdc007','b_xmdc007')
   CALL aicq100_filter_show('xmdl035','b_xmdl035')
   CALL aicq100_filter_show('xmdd014','b_xmdd014')
   CALL aicq100_filter_show('xrcb007','b_xrcb007')
 
 
   CALL aicq100_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aicq100.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aicq100_filter_parser(ps_field)
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
 
{<section id="aicq100.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aicq100_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicq100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aicq100.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aicq100_detail_action_trans()
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
 
{<section id="aicq100.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aicq100_detail_index_setting()
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
            IF g_xmda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmda_d.getLength() AND g_xmda_d.getLength() > 0
            LET g_detail_idx = g_xmda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmda_d.getLength() THEN
               LET g_detail_idx = g_xmda_d.getLength()
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
 
{<section id="aicq100.mask_functions" >}
 &include "erp/aic/aicq100_mask.4gl"
 
{</section>}
 
{<section id="aicq100.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 把欄位條件拆成出貨或採購
# Memo...........:
# Usage..........: CALL aicq100_where(p_wc)
#                  RETURNING r_axm_sql,r_apm_sql
# Input parameter: p_wc           條件
# Return code....: r_axm_sql      出貨欄位條件
#                : r_axm_sql      採購欄位條件
# Date & Author..: 2014/11/11 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aicq100_where(p_wc)
DEFINE p_wc            STRING
DEFINE r_axm_sql       STRING
DEFINE r_apm_sql       STRING

   LET r_axm_sql = p_wc
   LET r_apm_sql = p_wc
   
   #多角流程序號
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda031","pmdl031")
   
   #多角流程代碼
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda050","pmdl051")
   
   #訂單/採購單號
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmdadocno","pmdldocno")
   
   #單據日期
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmdadocdt","pmdldocdt")
   
   #客戶/廠商編號
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda004","pmdl004")
   
   #業務員/採購員編號
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda002","pmdl002")
   
   #單據狀態
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmdastus","pmdlstus")
   
   #交易條件
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda010","pmdl010")
   
   #收/付款條件
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda009","pmdl009")
   
   #稅別
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda011","pmdl011")
   
   #發票類型
   LET r_apm_sql = cl_replace_str(r_apm_sql,"xmda035","pmdl033")
   
   RETURN r_axm_sql,r_apm_sql
END FUNCTION

################################################################################
# Descriptions...: 顯示第二單身
# Memo...........:
# Usage..........: CALL aicq100_b_fill3()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 150413 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicq100_b_fill3()
   DEFINE li_ac           LIKE type_t.num10
   DEFINE l_sql           STRING
   #161215-00074#1 mod ---s
   #DEFINE l_xmdl_sql      STRING
   DEFINE l_xmdl_sql_1      STRING
   DEFINE l_xmdl_sql_2      STRING
   DEFINE l_xmdl_sql_3      STRING
   #161215-00074#1 mod ---e
   DEFINE l_pmds_sql      STRING
   
   LET g_sql = "SELECT icab002,icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",
               " ORDER BY icab002"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aicq100_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR aicq100_pb3
 
   LET l_ac = 1
   FOREACH b_fill_curs3 INTO g_xmda3_d[l_ac].icab002,g_xmda3_d[l_ac].icab003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      LET g_xmda3_d[l_ac].qcba017 = 0  #送驗量
      LET g_xmda3_d[l_ac].apcb007 = 0  #應付計價數量

      #訂單
      LET g_xmda3_d[l_ac].xmda0152 = ''
      LET g_xmda3_d[l_ac].xmdc046 = 0
      LET g_xmda3_d[l_ac].xmdc047 = 0
      LET g_xmda3_d[l_ac].xmdc048 = 0
      LET g_xmda3_d[l_ac].xmdd005 = 0
      LET g_xmda3_d[l_ac].xmdd031 = 0
      LET g_xmda3_d[l_ac].xmdd0141 = 0
      LET g_xmda3_d[l_ac].xmdd015 = 0
      LET g_xmda3_d[l_ac].xmdp016 = 0
      LET g_xmda3_d[l_ac].xmdl0351 = 0
      LET g_xmda3_d[l_ac].xmdl036 = 0
      LET g_xmda3_d[l_ac].xrcb0071 = 0
      
      SELECT xmda015,
             COALESCE(SUM(xmdc046),0),COALESCE(SUM(xmdc047),0),COALESCE(SUM(xmdc048),0),
             COALESCE(SUM(xmdd005),0),COALESCE(SUM(xmdd031),0),
             COALESCE(SUM(xmdd014),0),COALESCE(SUM(xmdd015),0),
             COALESCE(SUM(t2.xmdp016),0),
             COALESCE(SUM(t1.xmdl035),0),COALESCE(SUM(t1.xmdl036),0),
             COALESCE(SUM(t1.xmdl038),0)
        INTO g_xmda3_d[l_ac].xmda0152,
             g_xmda3_d[l_ac].xmdc046,g_xmda3_d[l_ac].xmdc047,g_xmda3_d[l_ac].xmdc048,
             g_xmda3_d[l_ac].xmdd005,g_xmda3_d[l_ac].xmdd031,
             g_xmda3_d[l_ac].xmdd0141,g_xmda3_d[l_ac].xmdd015,
             g_xmda3_d[l_ac].xmdp016,
             g_xmda3_d[l_ac].xmdl0351,g_xmda3_d[l_ac].xmdl036,
             g_xmda3_d[l_ac].xrcb0071
        FROM xmda_t
        LEFT OUTER JOIN xmdc_t ON xmdcent = xmdaent AND xmdcdocno = xmdadocno
        LEFT OUTER JOIN xmdd_t ON xmddent = xmdcent AND xmdddocno = xmdcdocno AND xmddseq = xmdcseq
        LEFT OUTER JOIN (SELECT xmdlent,xmdl003,xmdl004,xmdl005,xmdl006,xmdl035,xmdl036,xmdl038
                           FROM xmdk_t
                           LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno
                          WHERE xmdkstus != 'X' AND xmdk000 = '1') t1
                        ON t1.xmdlent = xmddent AND t1.xmdl003 = xmdddocno AND t1.xmdl004 = xmddseq AND t1.xmdl005 = xmddseq1 AND t1.xmdl006 = xmddseq2
        LEFT OUTER JOIN (SELECT xmdpent,xmdp003,xmdp004,xmdp005,xmdp006,xmdp016
                           FROM xmdo_t
                           LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno
                          WHERE xmdostus != 'X') t2
                        ON t2.xmdpent = xmddent AND t2.xmdp003 = xmdddocno AND t2.xmdp004 = xmddseq AND t2.xmdp005 = xmddseq1 AND t2.xmdp006 = xmddseq2

      WHERE xmdaent = g_enterprise AND xmdasite = g_xmda3_d[l_ac].icab003
        AND (xmda031 = g_xmda_d[g_detail_idx].xmda031 OR xmdadocno = g_xmda_d[g_detail_idx].xmdadocno)
        AND xmdcseq = g_xmda2_d[g_detail_idx2].xmdcseq
      GROUP BY xmda015


      #採購
      LET g_xmda3_d[l_ac].pmdl015 = ''
      LET g_xmda3_d[l_ac].pmdn007 = 0
      LET g_xmda3_d[l_ac].pmdn046 = 0
      LET g_xmda3_d[l_ac].pmdn047 = 0
      LET g_xmda3_d[l_ac].pmdn048 = 0
      LET g_xmda3_d[l_ac].pmdo015 = 0
      LET g_xmda3_d[l_ac].pmdo019 = 0
      LET g_xmda3_d[l_ac].pmdo040 = 0
      
      SELECT pmdl015,
             COALESCE(SUM(pmdn007),0),
             COALESCE(SUM(pmdn046),0),COALESCE(SUM(pmdn047),0),COALESCE(SUM(pmdn048),0),
             COALESCE(SUM(pmdo015),0),COALESCE(SUM(pmdo019),0),COALESCE(SUM(pmdo040),0)
        INTO g_xmda3_d[l_ac].pmdl015,
             g_xmda3_d[l_ac].pmdn007,
             g_xmda3_d[l_ac].pmdn046,g_xmda3_d[l_ac].pmdn047,g_xmda3_d[l_ac].pmdn048,
             g_xmda3_d[l_ac].pmdo015,g_xmda3_d[l_ac].pmdo019,g_xmda3_d[l_ac].pmdo040
        FROM pmdl_t
        LEFT OUTER JOIN pmdn_t ON pmdnent = pmdlent AND pmdndocno = pmdldocno
        LEFT OUTER JOIN pmdo_t ON pmdoent = pmdnent AND pmdodocno = pmdndocno AND pmdoseq = pmdnseq
        LEFT OUTER JOIN (SELECT pmdtent,pmdt001,pmdt002,pmdt003,pmdt004,pmdt056
                           FROM pmds_t
                           LEFT OUTER JOIN pmdt_t ON pmdtent = pmdsent AND pmdtdocno = pmdsdocno
                          WHERE pmdsstus != 'X' AND pmds000 = '3' OR pmds000 = '6') t3
                        ON t3.pmdtent = pmdoent AND t3.pmdt001 = pmdodocno AND t3.pmdt002 = pmdoseq AND t3.pmdt003 = pmdoseq1 AND t3.pmdt004 = pmdoseq2
      WHERE pmdlent = g_enterprise AND pmdlsite = g_xmda3_d[l_ac].icab003
        AND pmdl031 = g_xmda_d[g_detail_idx].xmda031
        AND pmdnseq = g_xmda2_d[g_detail_idx2].xmdcseq
      GROUP BY pmdl015

      CALL aicq100_detail_show("'3'")
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
   
   CALL g_xmda3_d.deleteElement(g_xmda3_d.getLength())
   LET li_ac = g_xmda3_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx3 = 1
   DISPLAY g_detail_idx3 TO FORMONLY.idx
   
   #table4
   LET l_sql = " 1=1"
   
   #訂單
   #訂單 -> 出通單 -> 出貨 -> 簽收 -> 簽退
   #訂單 -> 出貨 -> 簽收 -> 簽退
   #訂單 -> 出貨 -> 銷退
   #訂單 -> 出貨 -> 簽收-> 銷退
#161215-00074#1 mod ---s
#   LET l_xmdl_sql =
#      " OR EXISTS (SELECT t1.xmdg055",        
#      "              FROM (SELECT xmdg055",           #出通
#      "                      FROM xmdg_t",
#      "                      LEFT OUTER JOIN xmdh_t ON xmdgent = xmdhent AND xmdgdocno = xmdhdocno",
#      "                     WHERE xmdgent = ",g_enterprise,
#      "                       AND xmdgstus != 'X'",
#      "                       AND xmdh001 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#      "                    UNION ALL",
#      "                    SELECT DISTINCT xmdk035",  #出貨 簽收 簽退 銷退
#      "                      FROM xmdk_t",
#      "                      LEFT OUTER JOIN xmdl_t ON xmdlent = xmdkent AND xmdldocno = xmdkdocno",
#      "                     WHERE xmdkent = ",g_enterprise,
#      "                       AND xmdkstus != 'X'",
#      "                       AND xmdl003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#      "                    UNION ALL",
#      "                    SELECT xmdo055",           #Invoice
#      "                      FROM xmdo_t",
#      "                      LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
#      "                     WHERE xmdoent = ",g_enterprise,
#      "                       AND xmdostus != 'X'",
#      "                       AND xmdp003 = '",g_xmda_d[g_detail_idx].xmdadocno,"')  t1",
#      "             WHERE t1.xmdg055 = "
   LET l_xmdl_sql_1 =
      " OR EXISTS (SELECT t1.xmdg055",        
      "              FROM (SELECT xmdg055",           #出通
      "                      FROM xmdg_t",
      "                      LEFT OUTER JOIN xmdh_t ON xmdgent = xmdhent AND xmdgdocno = xmdhdocno",
      "                     WHERE xmdgent = ",g_enterprise,
      "                       AND xmdgstus != 'X'",
      "                       AND xmdh001 = '",g_xmda_d[g_detail_idx].xmdadocno,"')  t1",
      "             WHERE t1.xmdg055 = "
   LET l_xmdl_sql_2 =
      " OR EXISTS (SELECT t3.xmdo055",        
      "              FROM (SELECT xmdo055",           #Invoice
      "                      FROM xmdo_t",
      "                      LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
      "                     WHERE xmdoent = ",g_enterprise,
      "                       AND xmdostus != 'X'",
      "                       AND xmdp003 = '",g_xmda_d[g_detail_idx].xmdadocno,"')  t3",
      "             WHERE t3.xmdo055 = "
   LET l_xmdl_sql_3 =
      " OR EXISTS (SELECT t4.xmdk035",        
      "              FROM (SELECT DISTINCT xmdk035",  #出貨 簽收 簽退 銷退
      "                      FROM xmdk_t",
      "                      LEFT OUTER JOIN xmdl_t ON xmdlent = xmdkent AND xmdldocno = xmdkdocno",
      "                     WHERE xmdkent = ",g_enterprise,
      "                       AND xmdkstus != 'X'",
      "                       AND xmdl003 = '",g_xmda_d[g_detail_idx].xmdadocno,"')  t4",
      "             WHERE t4.xmdk035 = "
#161215-00074#1 mod ---e   
   #採購單
   #採購 -> 收貨單 -> 入庫單
   #收貨單 單號, 入庫單 多角流程序號
   LET l_pmds_sql =
      " OR EXISTS (SELECT 1",
      "              FROM (SELECT pmds053, pmds041",
      "                      FROM pmds_t",       --收貨
      "                     WHERE pmdsent = ",g_enterprise,
      "                       AND pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
      "                       AND pmdsstus != 'X'",
      "                    UNION ALL",
      "                    SELECT t1.pmds053, t1.pmds041",
      "                      FROM pmds_t t1,",   --入庫
      "                           pmds_t t2 ",   --收貨
      "                     WHERE t1.pmdsent = t2.pmdsent",
      "                       AND t1.pmds006 = t2.pmdsdocno",
      "                       AND t2.pmdsent = ",g_enterprise,
      "                       AND t2.pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
      "                       AND t1.pmdsstus != 'X'",
      "                       AND t2.pmdsstus != 'X'",
      "                    UNION ALL",
      "                    SELECT t1.pmds053, t1.pmds041",
      "                      FROM pmds_t t1,",   --倉退
      "                           pmds_t t2,",   --入庫
      "                           pmds_t t3 ",   --收貨
      "                     WHERE t1.pmdsent = t2.pmdsent",
      "                       AND t1.pmdsdocno = t2.pmds006",
      "                       AND t2.pmdsent = t3.pmdsent",
      "                       AND t2.pmds006 = t3.pmdsdocno",
      "                       AND t1.pmdsstus != 'X'",
      "                       AND t2.pmdsstus != 'X'",
      "                       AND t3.pmdsstus != 'X'",
      "                       AND t3.pmdsent = ",g_enterprise,
      "                       AND t3.pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
      "                    UNION ALL",
      "                    SELECT t1.pmds053,t1.pmds041",
      "                      FROM pmds_t t1,",  --倉退
      "                           pmds_T t2 ",  --收貨入庫
      "                     WHERE t1.pmdsent = t2.pmdsent",
      "                       AND t1.pmds006 = t2.pmdsdocno",
      "                       AND t1.pmdsstus != 'X'",
      "                       AND t2.pmdsstus != 'X'",
      "                       AND t2.pmdsent = ",g_enterprise,
      "                       AND t2.pmds006 = '",g_xmda_d[g_detail_idx].xmdadocno,"') c",
      "             WHERE c.pmds041 = d.pmds041 and c.pmds053 = d.pmds053)"
   
   #訂單
   LET g_sql = "SELECT xmda031,  icab002,icab003,'',     '1',",
               "       xmdadocno,xmda010,'',     xmda009,'',",
               "       xmda011,  '',     xmda035,'',     xmda015,",
               "       '',       xmdcseq,xmdc019,xmdc001,'',",
               "       '',       xmdc002,xmdc006,'',     xmdc007,",
               "       xmdc010,  '',     xmdc011,xmdc003,xmdc015,",
               "       xmdc046,xmdc047,xmdc048",
               "  FROM icab_t,xmda_t",
               "  LEFT OUTER JOIN xmdc_t ON xmdaent = xmdcent AND xmdadocno = xmdcdocno",
               " WHERE xmdaent = icabent",
               "   AND xmdasite = icab003",
               "   AND xmdasite = '",g_site,"'",
               "   AND xmdastus != 'X'",
               "   AND xmdaent = ",g_enterprise,                            #161215-00074#1 add
               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
               "   AND xmda031 = '",g_xmda_d[g_detail_idx].xmda031,"'",     #多角流程序號
               "   AND ",l_sql
   #如果第0站是1.訂單 排除原單據
   IF g_xmda_d[g_detail_idx].doctype = '1' THEN
      LET g_sql = g_sql," AND xmdadocno != '",g_xmda_d[g_detail_idx].xmdadocno,"'"
   END IF
   #採購單
   LET g_sql = g_sql," UNION ALL ",
               "SELECT pmdl031,  icab002,icab003,'',     '2',",
               "       pmdldocno,pmdl010,'',     pmdl009,'',",
               "       pmdl011,  '',     pmdl033,'',     pmdl015,",
               "       '',       pmdnseq,pmdn019,pmdn001,'',",
               "       '',       pmdn002,pmdn006,'',     pmdn007,",
               "       pmdn010,  '',     pmdn011,pmdn003,pmdn015,",
               "       pmdn046,pmdn047,pmdn048",
               "  FROM icab_t,pmdl_t",
               "  LEFT OUTER JOIN pmdn_t ON pmdlent = pmdnent AND pmdldocno = pmdndocno",
               " WHERE pmdlent = icabent",
               "   AND pmdlsite = icab003",
               "   AND pmdlsite = '",g_site,"'",
               "   AND pmdlstus != 'X'",
               "   AND pmdlent = ",g_enterprise,                            #161215-00074#1 add
               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
               "   AND pmdl031 = '",g_xmda_d[g_detail_idx].xmda031,"'",     #多角流程序號
               "   AND ",l_sql
   #如果第0站是1.採購單 排除原單據
   IF g_xmda_d[g_detail_idx].doctype = '2' THEN
      LET g_sql = g_sql," AND pmdldocno != '",g_xmda_d[g_detail_idx].xmdadocno,"'"
   END IF
   #出貨通知單
#161215-00074#1 mod ---s
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT xmdg055,  icab002,icab003,'',     '5',",
#               "       xmdgdocno,xmdg009,'',     xmdg008,'',",
#               "       xmdg010,  '',     xmdg013,'',     xmdg014,",
#               "       '',       xmdhseq,xmdh005,xmdh006,'',",
#               "       '',       xmdh007,xmdh015,'',     xmdh017,",
#               "       xmdh020,  '',     xmdh021,xmdh008,xmdh023,",
#               "       xmdh026,xmdh027,xmdh028",
#               "  FROM icab_t,xmdg_t t2",
#               "  LEFT OUTER JOIN xmdh_t ON xmdgent = xmdhent AND xmdgdocno = xmdhdocno",
#               " WHERE xmdgent = icabent",
#               "   AND xmdgsite = icab003",
#               "   AND xmdgsite = '",g_site,"'",
#               "   AND xmdgstus != 'X'",                           
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND (xmdg055 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
#               "    OR xmdh001 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#                       l_xmdl_sql,"xmdg055))",
#               "   AND ",l_sql
      
      LET g_sql = g_sql," UNION ALL ",
               "SELECT t7.xmdg055,  icab002,icab003,'',     '5',",
               "       t7.xmdgdocno,t7.xmdg009,'',     t7.xmdg008,'',",
               "       t7.xmdg010,  '',     t7.xmdg013,'',     t7.xmdg014,",
               "       '',       xmdhseq,xmdh005,xmdh006,'',",
               "       '',       xmdh007,xmdh015,'',     xmdh017,",
               "       xmdh020,  '',     xmdh021,xmdh008,xmdh023,",
               "       xmdh026,xmdh027,xmdh028",
               "  FROM icab_t,xmdg_t t7",
               "  LEFT OUTER JOIN xmdh_t ON t7.xmdgent = xmdhent AND t7.xmdgdocno = xmdhdocno",
               " WHERE t7.xmdgent = icabent",
               "   AND t7.xmdgsite = icab003",
               "   AND t7.xmdgsite = '",g_site,"'",
               "   AND t7.xmdgstus != 'X'",
               "   AND t7.xmdgent = ",g_enterprise,                            #161215-00074#1 add
               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
               "   AND (t7.xmdg055 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
               "    OR xmdh001 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
                       l_xmdl_sql_1,"t7.xmdg055))",                            #161215-00074#1 mod l_xmdl_sql ---->l_xmdl_sql_1
               "   AND ",l_sql
#161215-00074#1 mod ---e

   #Invoice單
#161215-00074#1 mod ---s
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT xmdo055,  icab002,icab003,'',     '6',",
#               "       xmdodocno,xmdo011,'',     xmdo010,'',",
#               "       xmdo012,  '',     xmdo015,'',     xmdo016,",
#               "       '',       xmdpseq,xmdp007,xmdp008,'',",
#               "       '',       xmdp009,xmdp015,'',     xmdp016,",
#               "       xmdp019,  '',     xmdp020,xmdp012,xmdp021,",
#               "       xmdp024,  xmdp025,  xmdp026",
#               "  FROM icab_t,xmdo_t",
#               "  LEFT OUTER JOIN xmdp_t ON xmdoent = xmdpent AND xmdodocno = xmdpdocno",
#               " WHERE xmdoent = icabent",
#               "   AND xmdosite = icab003",
#               "   AND xmdosite = '",g_site,"'",
#               "   AND xmdostus != 'X'",
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND (xmdo055 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
#               "    OR xmdp003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#                       l_xmdl_sql_2,"xmdo055))",                           
#               "   AND ",l_sql
            LET g_sql = g_sql," UNION ALL ",
               "SELECT t5.xmdo055,  icab002,icab003,'',     '6',",
               "       t5.xmdodocno,t5.xmdo011,'',     t5.xmdo010,'',",
               "       t5.xmdo012,  '',     t5.xmdo015,'',     t5.xmdo016,",
               "       '',       xmdpseq,xmdp007,xmdp008,'',",
               "       '',       xmdp009,xmdp015,'',     xmdp016,",
               "       xmdp019,  '',     xmdp020,xmdp012,xmdp021,",
               "       xmdp024,  xmdp025,  xmdp026",
               "  FROM icab_t,xmdo_t t5",
               "  LEFT OUTER JOIN xmdp_t ON t5.xmdoent = xmdpent AND t5.xmdodocno = xmdpdocno",
               " WHERE t5.xmdoent = icabent",
               "   AND t5.xmdosite = icab003",
               "   AND t5.xmdosite = '",g_site,"'",
               "   AND t5.xmdostus != 'X'",
               "   AND t5.xmdoent = ",g_enterprise,                            #161215-00074#1 add
               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
               "   AND (t5.xmdo055 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
               "    OR xmdp003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
                       l_xmdl_sql_2,"t5.xmdo055))",                            #161215-00074#1 mod l_xmdl_sql ---->l_xmdl_sql_2
               "   AND ",l_sql
#161215-00074#1 mod ---e
   #出貨單 銷退單 簽收單 簽退單
#161215-00074#1 mod ---s
#   LET g_sql = g_sql," UNION ALL ",
#               "SELECT xmdk035,  icab002,icab003,'',",
#               "       CASE xmdk000 WHEN '1' THEN '8'",
#               "                    WHEN '4' THEN '17'",
#               "                    WHEN '5' THEN '18'",
#               "                    WHEN '6' THEN '13' END,",
#               "       xmdkdocno,xmdk011,'',     xmdk010,'',",
#               "       xmdk012,  '',     xmdk015,'',     xmdk016,",
#               "       '',       xmdlseq,xmdl007,xmdl008,'',",
#               "       '',       xmdl009,xmdl017,'',     xmdl018,",
#               "       xmdl021,  '',     xmdl022,xmdl010,xmdl024,",
#               "       xmdl027,  xmdl028,xmdl029",
#               "  FROM icab_t,xmdk_t",
#               "  LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno",
#               " WHERE xmdkent = icabent",
#               "   AND xmdksite = icab003",
#               "   AND xmdksite = '",g_site,"'",
#               "   AND xmdkstus != 'X'",
#               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
#               "   AND (xmdk035 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
#               "    OR xmdl003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
#                       l_xmdl_sql,"xmdk035))",                           
#               "   AND ",l_sql
   LET g_sql = g_sql," UNION ALL ",
               "SELECT t6.xmdk035,  icab002,icab003,'',",
               "       CASE t6.xmdk000 WHEN '1' THEN '8'",
               "                    WHEN '4' THEN '17'",
               "                    WHEN '5' THEN '18'",
               "                    WHEN '6' THEN '13' END,",
               "       t6.xmdkdocno,t6.xmdk011,'',     t6.xmdk010,'',",
               "       t6.xmdk012,  '',     t6.xmdk015,'',     t6.xmdk016,",
               "       '',       xmdlseq,xmdl007,xmdl008,'',",
               "       '',       xmdl009,xmdl017,'',     xmdl018,",
               "       xmdl021,  '',     xmdl022,xmdl010,xmdl024,",
               "       xmdl027,  xmdl028,xmdl029",
               "  FROM icab_t,xmdk_t t6",
               "  LEFT OUTER JOIN xmdl_t ON t6.xmdkent = xmdlent AND t6.xmdkdocno = xmdldocno",
               " WHERE t6.xmdkent = icabent",
               "   AND t6.xmdksite = icab003",
               "   AND t6.xmdksite = '",g_site,"'",
               "   AND t6.xmdkstus != 'X'",
               "   AND t6.xmdkent = ",g_enterprise,                            #161215-00074#1 add
               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",     #多角流程代碼
               "   AND (t6.xmdk035 = '",g_xmda_d[g_detail_idx].xmda031,"'",    #多角流程序號
               "    OR xmdl003 = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
                       l_xmdl_sql_3,"t6.xmdk035))",                            #161215-00074#1 mod l_xmdl_sql ---->l_xmdl_sql_3
               "   AND ",l_sql
#161215-00074#1 mod ---e
   #收貨單 入庫單 倉退單
   LET g_sql = g_sql," UNION ALL ",
               "SELECT d.pmds041,  icab002,icab003,  '',",
               "       CASE d.pmds000 WHEN '1' THEN '9'",
               "                      WHEN '3' THEN '10'",
               "                      WHEN '6' THEN '10'",
               "                      WHEN '20' THEN '20'",   #add--151130-00016#1 By shiun
               "                      WHEN '7' THEN '14' END,",
               "       d.pmdsdocno,d.pmds032,'',     d.pmds031,'',",
               "       d.pmds033,  '',       ''      ,'',      d.pmds037,",
               "       '',       pmdtseq,pmdt005,pmdt006,'',",
               "       '',       pmdt007,pmdt019,'',     pmdt020,",
               "       pmdt023,  '',     pmdt024,pmdt008,pmdt036,",
               "       pmdt038,  pmdt039,pmdt047",
               "  FROM icab_t,pmds_t d",
               "  LEFT OUTER JOIN pmdt_t ON d.pmdsent = pmdtent AND d.pmdsdocno = pmdtdocno",
               " WHERE d.pmdsent = icabent",
               "   AND d.pmdssite = icab003",
               "   AND d.pmdssite = '",g_site,"'",
               "   AND d.pmdsstus != 'X'",
               "   AND d.pmdsent = ",g_enterprise,                            #161215-00074#1 add
               "   AND icab001 = '",g_xmda_d[g_detail_idx].xmda050,"'",       #多角流程代碼
               "   AND (d.pmds041 = '",g_xmda_d[g_detail_idx].xmda031,"'",
                       l_pmds_sql,")", #多角流程序號
               "   AND ",l_sql
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   LET g_sql = g_sql," ORDER BY 2,5,6,17" #150413---earl---add
   
   PREPARE aicq100_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR aicq100_pb4
 
   OPEN b_fill_curs4
 
   LET l_ac = 1
   FOREACH b_fill_curs4 INTO g_xmda4_d[l_ac].xmda0312,g_xmda4_d[l_ac].icab002,g_xmda4_d[l_ac].xmdasite2,
                             g_xmda4_d[l_ac].xmdasite2_desc,g_xmda4_d[l_ac].doctype2,g_xmda4_d[l_ac].xmdadocno2,
                             g_xmda4_d[l_ac].xmda0102,g_xmda4_d[l_ac].xmda0102_desc,g_xmda4_d[l_ac].xmda0092,
                             g_xmda4_d[l_ac].xmda0092_desc,g_xmda4_d[l_ac].xmda0112,g_xmda4_d[l_ac].xmda0112_desc,
                             g_xmda4_d[l_ac].xmda0352,g_xmda4_d[l_ac].xmda0352_desc,g_xmda4_d[l_ac].xmda015,
                             g_xmda4_d[l_ac].xmda015_desc,g_xmda4_d[l_ac].xmdcseq2,g_xmda4_d[l_ac].xmdc0192,
                             g_xmda4_d[l_ac].xmdc0012,g_xmda4_d[l_ac].xmdc0012_desc,g_xmda4_d[l_ac].xmdc0012_desc_desc,
                             g_xmda4_d[l_ac].xmdc0022,g_xmda4_d[l_ac].xmdc0062,g_xmda4_d[l_ac].xmdc0062_desc,
                             g_xmda4_d[l_ac].xmdc0072,g_xmda4_d[l_ac].xmdc010,g_xmda4_d[l_ac].xmdc010_desc,
                             g_xmda4_d[l_ac].xmdc011,g_xmda4_d[l_ac].xmdc003,g_xmda4_d[l_ac].xmdc0152,
                             g_xmda4_d[l_ac].xmdc0462,g_xmda4_d[l_ac].xmdc0472,g_xmda4_d[l_ac].xmdc0482
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      CALL aicq100_detail_show("'4'")
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
   
   CALL g_xmda4_d.deleteElement(g_xmda4_d.getLength())
   LET li_ac = g_xmda4_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx4 = 1
   DISPLAY g_detail_idx4 TO FORMONLY.idx
END FUNCTION

 
{</section>}
 
