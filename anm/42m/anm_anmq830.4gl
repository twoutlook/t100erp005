#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq830.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2015-10-26 10:26:07), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: anmq830
#+ Description: 銀行調節表查詢
#+ Creator....: 01251(2014-11-18 17:46:41)
#+ Modifier...: 03080 -SD/PR- 00000
 
{</section>}
 
{<section id="anmq830.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150715-00014#2  2015/07/24  By Jessy    anmq* bug修復(欄位控卡有誤/資料報錯有問題)
#150924-00006#4  2015/09/30  By albireo  增加XG
#151002-00011#3  2015/10/23  By yangtt   1.画面单头栏位有INPUT改成CONSTRUCT；2.对账单号和币别栏位不给不查询，只显示
#160122-00001#29 2016/02/03  By 02599    增加交易账户用户权限控管
#160122-00001#29 2016/03/17  By 07900    增加交易账户用户权限控管,增加部门权限
#160318-00025#26 2016/04/28  BY 07900    校验代码重复错误讯息的修改
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
PRIVATE TYPE type_g_nmdf_d RECORD
       
       sel LIKE type_t.chr1, 
   nmdf001 LIKE nmdf_t.nmdf001, 
   nmdf002 LIKE nmdf_t.nmdf002, 
   nmdf003 LIKE nmdf_t.nmdf003, 
   nmdfseq LIKE nmdf_t.nmdfseq, 
   nmdf006 LIKE nmdf_t.nmdf006, 
   nmdf005 LIKE nmdf_t.nmdf005, 
   nmdf004 LIKE nmdf_t.nmdf004, 
   nmdf007 LIKE nmdf_t.nmdf007, 
   nmdf0062 LIKE type_t.chr1, 
   nmdj004 LIKE nmdj_t.nmdj004, 
   nmdf012 LIKE nmdf_t.nmdf012, 
   nmdf013 LIKE nmdf_t.nmdf013, 
   nmdf008 LIKE nmdf_t.nmdf008, 
   l_nmbc003 LIKE type_t.chr10, 
   l_nmbc003_desc LIKE type_t.chr100
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input        RECORD 
       nmdf001        LIKE nmdf_t.nmdf001,
       nmdf002        LIKE nmdf_t.nmdf002,
       nmdf003        LIKE nmdf_t.nmdf003,
       nmdjdocno      LIKE nmdj_t.nmdjdocno,
       nmas003        LIKE nmas_t.nmas003
                      END RECORD
DEFINE g_amount1      LIKE type_t.num20_6
DEFINE g_amount2      LIKE type_t.num20_6
DEFINE g_amount3      LIKE type_t.num20_6
DEFINE g_amount4      LIKE type_t.num20_6
DEFINE g_amount5      LIKE type_t.num20_6
DEFINE g_amount6      LIKE type_t.num20_6
DEFINE g_amount7      LIKE type_t.num20_6
DEFINE g_amount8      LIKE type_t.num20_6
#151002-00011#3---add---str
 TYPE type_g_detail2 RECORD
       nmdf001        LIKE nmdf_t.nmdf001,
       nmdf002        LIKE nmdf_t.nmdf002,
       nmdf003        LIKE nmdf_t.nmdf003
                      END RECORD
DEFINE g_detail2            DYNAMIC ARRAY OF type_g_detail2
DEFINE g_jump                LIKE type_t.num10
DEFINE g_row_count           LIKE type_t.num10
#151002-00011#3---add---end
DEFINE g_sql_bank    STRING   #160122-00001#29 By 07900 --add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmdf_d            DYNAMIC ARRAY OF type_g_nmdf_d
DEFINE g_nmdf_d_t          type_g_nmdf_d
 
 
 
 
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
 
{<section id="anmq830.main" >}
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
   CALL cl_ap_init("anm","")
 
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
   DECLARE anmq830_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq830_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
 
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq830_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq830 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq830_init()   
 
      #進入選單 Menu (="N")
      CALL anmq830_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq830
      
   END IF 
   
   CLOSE anmq830_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq830.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq830_init()
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
   
      CALL cl_set_combo_scc('b_nmdf006','9945') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('nmdf0062','9945') 
   CALL cl_set_comp_visible('sel',FALSE)    #150715-00014#2
   
   
   #150924-00006#1-----s
   CALL anmq830_create_tmp()
   #150924-00006#1-----e
   
   #160122-00001#29 By 07900 --add--str
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#29 By 07900 --add--end 
   #end add-point
 
   CALL anmq830_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq830.default_search" >}
PRIVATE FUNCTION anmq830_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmdf001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmdf002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " nmdf003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " nmdfseq = '", g_argv[04], "' AND "
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
 
{<section id="anmq830.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq830_ui_dialog() 
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
   #150924-00006#1-----s
   DEFINE l_tmp   RECORD
         nmdf001 LIKE nmdf_t.nmdf001,
         nmdf002 LIKE nmdf_t.nmdf002,
         nmdf003 LIKE nmdf_t.nmdf003,
         l_nmdjdocno LIKE type_t.chr100,
         l_nmas003 LIKE type_t.chr30,
         l_amount1 LIKE type_t.num26_10,
         l_amount2 LIKE type_t.num20_6,
         l_amount3 LIKE type_t.num20_6,
         l_amount4 LIKE type_t.num20_6,
         l_amount5 LIKE type_t.num20_6,
         l_amount6 LIKE type_t.num20_6,
         l_amount7 LIKE type_t.num20_6,
         l_amount8 LIKE type_t.num20_6,
         nmdf006 LIKE nmdf_t.nmdf006,
         l_nmdf006_desc LIKE type_t.chr100,
         nmdf005 LIKE nmdf_t.nmdf005,
         nmdf004 LIKE nmdf_t.nmdf004,
         nmdf007 LIKE nmdf_t.nmdf007,
         l_nmdf0062 LIKE type_t.chr100,
         l_nmdf0062_desc LIKE type_t.chr100,
         l_nmdj0042 LIKE type_t.dat,
         nmdf012 LIKE nmdf_t.nmdf012,
         nmdf013 LIKE nmdf_t.nmdf013,
         nmdf008 LIKE nmdf_t.nmdf008,
         l_nmbc003 LIKE type_t.chr100,
         l_nmbc003_desc LIKE type_t.chr100         
                  END RECORD
   DEFINE l_i     LIKE type_t.num10
   #150924-00006#1-----e
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
   CALL anmq830_ui_dialog_1()    #151002-00011#3
   RETURN   #151002-00011#3
   #150715-00014#2-----s
   INITIALIZE g_input.* TO NULL
   CALL cl_set_comp_visible('sel',FALSE)
   CALL g_nmdf_d.clear()
   IF cl_null(g_input.nmdf001) OR g_input.nmdf001=0 THEN
      LET g_input.nmdf001=YEAR(g_today)
   END IF
   IF cl_null(g_input.nmdf002) OR g_input.nmdf002=0 THEN
      LET g_input.nmdf002=MONTH(g_today)
   END IF 
   DISPLAY BY NAME g_input.nmdf001
   DISPLAY BY NAME g_input.nmdf002
   #150715-00014#2-----e
   #end add-point
 
   
   CALL anmq830_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmdf_d.clear()
 
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
 
         CALL anmq830_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
        INPUT BY NAME g_input.nmdf001,g_input.nmdf002,g_input.nmdf003,g_input.nmdjdocno,g_input.nmas003 
           ATTRIBUTE(WITHOUT DEFAULTS)
           
           BEFORE INPUT
              IF cl_null(g_input.nmdf001) OR g_input.nmdf001=0 THEN
                 LET g_input.nmdf001=YEAR(g_today)
              END IF
              IF cl_null(g_input.nmdf002) OR g_input.nmdf002=0 THEN
                 LET g_input.nmdf002=MONTH(g_today)
              END IF 
              DISPLAY BY NAME g_input.nmdf001
              DISPLAY BY NAME g_input.nmdf002

           AFTER FIELD nmdf001 #年度
              IF NOT cl_null(g_input.nmdf001) THEN 
              
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_input.nmdf001
                 
                 IF cl_chk_exist("v_glav002") THEN
              
                 ELSE
                    LET g_input.nmdf001 =''
                    NEXT FIELD CURRENT
                 END IF
                 
                 IF NOT cl_null(g_input.nmdf002) THEN
                    INITIALIZE g_chkparam.* TO NULL
                 
                    LET g_chkparam.arg1 = g_input.nmdf001
                    LET g_chkparam.arg2 = g_input.nmdf002
              
                    IF cl_chk_exist("v_glav002_1") THEN
              
                    ELSE
                       LET g_input.nmdf001 = ''
                       NEXT FIELD CURRENT
                    END IF                                                 
                 END IF
              END IF               

           AFTER FIELD nmdf002 #期別
              IF NOT cl_null(g_input.nmdf002) THEN 
              
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_input.nmdf002
                 
                 IF cl_chk_exist("v_glav006") THEN
              
                 ELSE
                    LET g_input.nmdf002 =''
                    NEXT FIELD CURRENT
                 END IF
                 
                 IF NOT cl_null(g_input.nmdf001) THEN
                    INITIALIZE g_chkparam.* TO NULL
                 
                    LET g_chkparam.arg1 = g_input.nmdf001
                    LET g_chkparam.arg2 = g_input.nmdf002
              
                    IF cl_chk_exist("v_glav002_1") THEN
              
                    ELSE
                       LET g_input.nmdf002 = ''
                       NEXT FIELD CURRENT
                    END IF                                                 
                 END IF
              END IF 


           AFTER FIELD nmdf003 #交易帳戶
              IF NOT cl_null(g_input.nmdf003) THEN 
                  INITIALIZE g_chkparam.* TO NULL                  
                  LET g_chkparam.arg1 = g_input.nmdf003
                  IF cl_chk_exist("v_nmas002_9") THEN
                  ELSE
                     LET g_input.nmdf003 = ''
                     NEXT FIELD CURRENT
                  END IF   
              END IF

           AFTER FIELD nmdjdocno #對帳單號
              IF NOT cl_null(g_input.nmdjdocno) THEN 
                  INITIALIZE g_chkparam.* TO NULL                  
                  LET g_chkparam.arg1 = g_input.nmdjdocno
                  IF cl_chk_exist("v_nmdjdocno") THEN
                  ELSE
                     LET g_input.nmdjdocno = ''
                     NEXT FIELD CURRENT
                  END IF   
              END IF
              

            AFTER FIELD nmas003 #幣別
              IF NOT cl_null(g_input.nmas003) THEN 
                  INITIALIZE g_chkparam.* TO NULL                  
                  LET g_chkparam.arg1 = g_input.nmas003 
                  #160318-00025#26  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  #160318-00025#26  by 07900 --add-end                  
                  IF cl_chk_exist("v_ooai001") THEN 
                  ELSE
                     LET g_input.nmas003 = ''
                     NEXT FIELD CURRENT
                  END IF               
              END IF  



           ON ACTION controlp INFIELD nmdf001
           
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
           
              LET g_qryparam.default1 = g_input.nmdf001             #給予default值
           
              #給予arg
              LET g_qryparam.arg1 = "" #s
           
              CALL q_glav001_1()                                #呼叫開窗
           
              LET g_input.nmdf001 = g_qryparam.return1              
              DISPLAY g_input.nmdf001 TO nmdf001              #
              NEXT FIELD nmdf001                          #返回原欄位
           
           
           ON ACTION controlp INFIELD nmdf002
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
           
              LET g_qryparam.default1 = g_input.nmdf002           #給予default值
           
              #給予arg
              LET g_qryparam.arg1 = "" #s
            
              CALL q_glav001_2()                                #呼叫開窗
           
              LET g_input.nmdf002 = g_qryparam.return1              
           
              DISPLAY g_input.nmdf002 TO nmdf002              #
           
              NEXT FIELD nmdf002                          #返回原欄位
           
            ON ACTION controlp INFIELD nmdf003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
            
               LET g_qryparam.default1 = g_input.nmdf003            #給予default值
               #160122-00001#29--add--str--
               LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
               #160122-00001#29--add--end
               #給予arg    
                CALL q_nmas002_5()

               LET g_input.nmdf003 = g_qryparam.return1              
            
               DISPLAY g_input.nmdf003 TO nmdf003              #
            
               NEXT FIELD nmdf003                          #返回原欄位    

            ON ACTION controlp INFIELD nmdjdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
            
               LET g_qryparam.default1 = g_input.nmdjdocno            #給予default值
               CALL q_nmdjdocno()                           #呼叫開窗
               LET g_input.nmdjdocno = g_qryparam.return1              
            
               DISPLAY g_input.nmdjdocno TO nmdf003              #
            
               NEXT FIELD nmdjdocno                          #返回原欄位    

            ON ACTION controlp INFIELD nmas003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
            
               LET g_qryparam.default1 = g_input.nmas003            #給予default值
               CALL q_ooai001_1()                           #150715-00014#2 呼叫開窗
               LET g_input.nmas003 = g_qryparam.return1              
            
               DISPLAY g_input.nmas003 TO nmdf003              #
            
               NEXT FIELD nmas003                          #返回原欄位    



        END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON nmdf001,nmdf002,nmdf003
           
            ON ACTION controlp INFIELD nmdf001 #年度
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
              #CALL q_glav001_1()   #151002-00011#3  mark
               LET g_qryparam.arg1 = "43"   #151002-00011#3 add
               CALL q_gzcb001()    #151002-00011#3 add
               DISPLAY g_qryparam.return1 TO nmdf001
               NEXT FIELD nmdf001         
         
            ON ACTION controlp INFIELD nmdf002 #期別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
              #CALL q_glav001_2() #151002-00011#3 mark
               LET g_qryparam.arg1 = "8861" #151002-00011#3
               CALL q_gzcb001() #151002-00011#3
               DISPLAY g_qryparam.return1 TO nmdf002
               NEXT FIELD nmdf002           
         
            ON ACTION controlp INFIELD nmdf003 #交易帳戶
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160122-00001#29--add--str--
               LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
               #160122-00001#29--add--end
               CALL q_nmas002_5()
               DISPLAY g_qryparam.return1 TO nmdf003
               NEXT FIELD nmdf003           
         
         
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_nmdf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmq830_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq830_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL anmq830_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            DISPLAY g_amount1 TO amount1
            DISPLAY g_amount2 TO amount2
            DISPLAY g_amount3 TO amount3
            DISPLAY g_amount4 TO amount4
            DISPLAY g_amount5 TO amount5
            DISPLAY g_amount6 TO amount6
            DISPLAY g_amount7 TO amount7 
            DISPLAY g_amount8 TO amount8  
            
            #150715-00014#2-----s
            CALL cl_set_act_visible('insert',FALSE)   #隱藏新增Action
            CALL cl_set_comp_visible('sel',FALSE)     #隱藏選取標籤
            #150715-00014#2-----e            
            #end add-point
            NEXT FIELD nmdf001
 
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
            CALL anmq830_set_page()  #151002-00011#3
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL anmq830_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_nmdf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmq830_b_fill()
 
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
            CALL anmq830_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq830_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq830_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq830_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               LET g_nmdf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               LET g_nmdf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmdf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmdf_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq830_filter()
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
               #150924-00006#1-----s
               DELETE FROM anmq830_x01_tmp
               FOR l_i = 1 TO g_nmdf_d.getLength()
                  INITIALIZE l_tmp.* TO NULL
                  LET l_tmp.nmdf001     = g_input.nmdf001
                  LET l_tmp.nmdf002     = g_input.nmdf002
                  LET l_tmp.nmdf003     = g_input.nmdf003
                  LET l_tmp.l_nmdjdocno = g_input.nmdjdocno
                  LET l_tmp.l_nmas003   = g_input.nmas003
                  LET l_tmp.l_amount1   = g_amount1
                  LET l_tmp.l_amount2   = g_amount2
                  LET l_tmp.l_amount3   = g_amount3
                  LET l_tmp.l_amount4   = g_amount4
                  LET l_tmp.l_amount5   = g_amount5
                  LET l_tmp.l_amount6   = g_amount6
                  LET l_tmp.l_amount7   = g_amount7
                  LET l_tmp.l_amount8   = g_amount8
                  LET l_tmp.nmdf006     = g_nmdf_d[l_i].nmdf006
                  LET l_tmp.l_nmdf006_desc =  s_desc_gzcbl004_desc('9945',g_nmdf_d[l_i].nmdf006)
                  LET l_tmp.nmdf005     = g_nmdf_d[l_i].nmdf005
                  LET l_tmp.nmdf004     = g_nmdf_d[l_i].nmdf004
                  LET l_tmp.nmdf007     = g_nmdf_d[l_i].nmdf007
                  LET l_tmp.l_nmdf0062  = g_nmdf_d[l_i].nmdf0062
                  LET l_tmp.l_nmdf0062_desc = s_desc_gzcbl004_desc('9945',g_nmdf_d[l_i].nmdf0062)
                  LET l_tmp.l_nmdj0042  = g_nmdf_d[l_i].nmdj004
                  LET l_tmp.nmdf012     = g_nmdf_d[l_i].nmdf012
                  LET l_tmp.nmdf013     = g_nmdf_d[l_i].nmdf013
                  LET l_tmp.nmdf008     = g_nmdf_d[l_i].nmdf008
                  LET l_tmp.l_nmbc003_desc =g_nmdf_d[l_i].l_nmbc003_desc
                  LET l_tmp.l_nmbc003 =g_nmdf_d[l_i].l_nmbc003
                  INSERT INTO anmq830_x01_tmp VALUES(l_tmp.*)
               END FOR
               
               CALL anmq830_x01(' 1=1','anmq830_x01_tmp')
               #150924-00006#1-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150924-00006#1-----s
               DELETE FROM anmq830_x01_tmp
               FOR l_i = 1 TO g_nmdf_d.getLength()
                  INITIALIZE l_tmp.* TO NULL
                  LET l_tmp.nmdf001     = g_input.nmdf001
                  LET l_tmp.nmdf002     = g_input.nmdf002
                  LET l_tmp.nmdf003     = g_input.nmdf003
                  LET l_tmp.l_nmdjdocno = g_input.nmdjdocno
                  LET l_tmp.l_nmas003   = g_input.nmas003
                  LET l_tmp.l_amount1   = g_amount1
                  LET l_tmp.l_amount2   = g_amount2
                  LET l_tmp.l_amount3   = g_amount3
                  LET l_tmp.l_amount4   = g_amount4
                  LET l_tmp.l_amount5   = g_amount5
                  LET l_tmp.l_amount6   = g_amount6
                  LET l_tmp.l_amount7   = g_amount7
                  LET l_tmp.l_amount8   = g_amount8
                  LET l_tmp.nmdf006     = g_nmdf_d[l_i].nmdf006
                  LET l_tmp.l_nmdf006_desc =  s_desc_gzcbl004_desc('9945',g_nmdf_d[l_i].nmdf006)
                  LET l_tmp.nmdf005     = g_nmdf_d[l_i].nmdf005
                  LET l_tmp.nmdf004     = g_nmdf_d[l_i].nmdf004
                  LET l_tmp.nmdf007     = g_nmdf_d[l_i].nmdf007
                  LET l_tmp.l_nmdf0062  = g_nmdf_d[l_i].nmdf0062
                  LET l_tmp.l_nmdf0062_desc = s_desc_gzcbl004_desc('9945',g_nmdf_d[l_i].nmdf0062)
                  LET l_tmp.l_nmdj0042  = g_nmdf_d[l_i].nmdj004
                  LET l_tmp.nmdf012     = g_nmdf_d[l_i].nmdf012
                  LET l_tmp.nmdf013     = g_nmdf_d[l_i].nmdf013
                  LET l_tmp.nmdf008     = g_nmdf_d[l_i].nmdf008
                  LET l_tmp.l_nmbc003_desc =g_nmdf_d[l_i].l_nmbc003_desc
                  LET l_tmp.l_nmbc003 =g_nmdf_d[l_i].l_nmbc003
                  INSERT INTO anmq830_x01_tmp VALUES(l_tmp.*)
               END FOR
               
               CALL anmq830_x01(' 1=1','anmq830_x01_tmp')
               #150924-00006#1-----e
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
         #151002-00011#3---add---str
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('L')
            LET g_action_choice = lc_action_choice_old
         #151002-00011#3---add---end
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            #150715-00014#2-----s
            INITIALIZE g_input.* TO NULL
            CALL g_nmdf_d.clear()
            IF cl_null(g_input.nmdf001) OR g_input.nmdf001=0 THEN
               LET g_input.nmdf001=YEAR(g_today)
            END IF
            IF cl_null(g_input.nmdf002) OR g_input.nmdf002=0 THEN
               LET g_input.nmdf002=MONTH(g_today)
            END IF 
            DISPLAY BY NAME g_input.nmdf001
            DISPLAY BY NAME g_input.nmdf002
            #150715-00014#2-----e
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="anmq830.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq830_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_sql2          STRING
   DEFINE l_count1        LIKE type_t.num5
   DEFINE l_count2        LIKE type_t.num5
   DEFINE l_count3        LIKE type_t.num5
   DEFINE l_count4        LIKE type_t.num5
   DEFINE l_nmdf006_1     LIKE nmdf_t.nmdf006
   DEFINE l_nmdf006_2     LIKE nmdf_t.nmdf006
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_nmdfseq       LIKE nmdf_t.nmdfseq
   DEFINE l_nmdf006       LIKE nmdf_t.nmdf006
   DEFINE l_nmdf005       LIKE nmdf_t.nmdf005
   DEFINE l_nmdf004       LIKE nmdf_t.nmdf004
   DEFINE l_nmdf007       LIKE nmdf_t.nmdf007
   DEFINE l_nmdf012       LIKE nmdf_t.nmdf012
   DEFINE l_nmdf013       LIKE nmdf_t.nmdf013
   DEFINE l_nmdf008       LIKE nmdf_t.nmdf008
   DEFINE l_nmbc103       LIKE nmbc_t.nmbc103
   DEFINE l_nmbc103_2     LIKE nmbc_t.nmbc103
   DEFINE l_bdate         LIKE type_t.dat
   DEFINE l_edate         LIKE type_t.dat
   DEFINE l_days          LIKE type_t.num5
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_nmdg003       LIKE nmdg_t.nmdg003
   DEFINE l_nmdg004       LIKE nmdg_t.nmdg004
   DEFINE l_nmdf001       LIKE nmdf_t.nmdf001
   DEFINE l_nmdf002       LIKE nmdf_t.nmdf002
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   LET g_amount1=0
   LET g_amount2=0
   LET g_amount3=0
   LET g_amount4=0
   LET g_amount5=0
   LET g_amount6=0
   LET g_amount7=0
   LET g_amount8=0
    
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
 
   CALL g_nmdf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc =  g_wc2, " AND ", g_wc_filter,
                " AND nmdf001='",g_input.nmdf001,"'",
                " AND nmdf002='",g_input.nmdf002,"'",
                " AND nmdf003='",g_input.nmdf003,"'"
                
#151002-00011#3--mark--str--
#   IF NOT cl_null(g_input.nmdjdocno) THEN
#      LET ls_wc =ls_wc," AND EXISTS(SELECT 1 FROM nmdj_t WHERE nmdjent='",g_enterprise,"'",
#                       "                                   AND nmdjdocno='",g_input.nmdjdocno,"'",
#                       "                                   AND nmdj001='",g_input.nmdf003,"'",
#                       "                                   AND nmdj002='",g_input.nmdf001,"'",
#                       "                                   AND nmdj003='",g_input.nmdf002,"'",
#                       "                                   AND nmdjstus='Y'",
#                       "                                   AND nmdj001=nmdf003 AND nmdj002=nmdf001 AND nmdj003=nmdf002",
#                       "            )"
#   END IF
#151002-00011#3--mark--end--
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',nmdf001,nmdf002,nmdf003,nmdfseq,nmdf006,nmdf005,nmdf004,nmdf007, 
       '','',nmdf012,nmdf013,nmdf008,'',''  ,DENSE_RANK() OVER( ORDER BY nmdf_t.nmdf001,nmdf_t.nmdf002, 
       nmdf_t.nmdf003,nmdf_t.nmdfseq) AS RANK FROM nmdf_t",
 
 
                     "",
                     " WHERE nmdfent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmdf_t"),
                     " ORDER BY nmdf_t.nmdf001,nmdf_t.nmdf002,nmdf_t.nmdf003,nmdf_t.nmdfseq"
 
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
 
   LET g_sql = "SELECT '',nmdf001,nmdf002,nmdf003,nmdfseq,nmdf006,nmdf005,nmdf004,nmdf007,'','',nmdf012, 
       nmdf013,nmdf008,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq830_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq830_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_nmdf_d[l_ac].sel,g_nmdf_d[l_ac].nmdf001,g_nmdf_d[l_ac].nmdf002,g_nmdf_d[l_ac].nmdf003, 
       g_nmdf_d[l_ac].nmdfseq,g_nmdf_d[l_ac].nmdf006,g_nmdf_d[l_ac].nmdf005,g_nmdf_d[l_ac].nmdf004,g_nmdf_d[l_ac].nmdf007, 
       g_nmdf_d[l_ac].nmdf0062,g_nmdf_d[l_ac].nmdj004,g_nmdf_d[l_ac].nmdf012,g_nmdf_d[l_ac].nmdf013, 
       g_nmdf_d[l_ac].nmdf008,g_nmdf_d[l_ac].l_nmbc003,g_nmdf_d[l_ac].l_nmbc003_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT nmbc003 INTO g_nmdf_d[l_ac].l_nmbc003
        FROM nmbc_t
       WHERE nmbcent = g_enterprise
         AND nmbcdocno = g_nmdf_d[l_ac].nmdf012
         AND nmbcseq   = g_nmdf_d[l_ac].nmdf013
      LET g_nmdf_d[l_ac].l_nmbc003_desc =  s_desc_get_trading_partner_abbr_desc(g_nmdf_d[l_ac].l_nmbc003)
      #end add-point
 
      CALL anmq830_detail_show("'1'")
 
      CALL anmq830_nmdf_t_mask()
 
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
 
   CALL g_nmdf_d.deleteElement(g_nmdf_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL g_nmdf_d.clear()
   
   #3:银行已收企业未收---筆數
   LET l_sql="SELECT COUNT(*) FROM nmdf_t",
             " WHERE nmdfent='",g_enterprise,"'",
             "   AND nmdf006='3'",
             "   AND ",ls_wc,cl_sql_add_filter("nmdf_t")
   PREPARE anmq830_count1_pb FROM l_sql
   EXECUTE anmq830_count1_pb INTO l_count1  
   IF cl_null(l_count1) THEN LET l_count1=0 END IF

   #1:企业已收银行未收---筆數
   LET l_sql="SELECT COUNT(*) FROM nmdf_t",
             " WHERE nmdfent='",g_enterprise,"'",
             "   AND nmdf006='1'",
             "   AND ",ls_wc,cl_sql_add_filter("nmdf_t")
   PREPARE anmq830_count2_pb FROM l_sql
   EXECUTE anmq830_count2_pb INTO l_count2   
   IF cl_null(l_count2) THEN LET l_count2=0 END IF
   
   #4:银行已付企业未付---筆數 
   LET l_sql="SELECT COUNT(*) FROM nmdf_t",
             " WHERE nmdfent='",g_enterprise,"'",
             "   AND nmdf006='4'",
             "   AND ",ls_wc,cl_sql_add_filter("nmdf_t")
   PREPARE anmq830_count3_pb FROM l_sql
   EXECUTE anmq830_count3_pb INTO l_count3   
   IF cl_null(l_count3) THEN LET l_count3=0 END IF   

   #2:企业已付银行未付---筆數
   LET l_sql="SELECT COUNT(*) FROM nmdf_t",
             " WHERE nmdfent='",g_enterprise,"'",
             "   AND nmdf006='2'",
             "   AND ",ls_wc,cl_sql_add_filter("nmdf_t")
   PREPARE anmq830_count4_pb FROM l_sql
   EXECUTE anmq830_count4_pb INTO l_count4    
   IF cl_null(l_count4) THEN LET l_count4=0 END IF  
   

   #無滿足條件的資料
   IF l_count1+l_count2+l_count3+l_count4=0 THEN
      RETURN
   END IF


   #設置斷點
   IF l_count1>=l_count2  THEN
      LET l_nmdf006_1='3'
      LET l_flag=l_count1
   ELSE
      LET l_nmdf006_1='1'
      LET l_flag=l_count2
   END IF
   IF l_count3>=l_count4  THEN
      LET l_nmdf006_2='4'
   ELSE
      LET l_nmdf006_2='2'
   END IF
   
   LET l_sql = "SELECT  UNIQUE nmdf006,nmdf005,nmdf004,nmdf007,nmdf012,nmdf013,nmdf008",
               "  FROM nmdf_t",
               " WHERE nmdfent='",g_enterprise,"'",
               "   AND ",ls_wc,
               "   AND nmdf006='",l_nmdf006_1,"'",cl_sql_add_filter("nmdf_t"),
               " ORDER BY nmdf_t.nmdf006,nmdf_t.nmdf005,nmdf_t.nmdf004"
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE anmq830_fill_pb FROM l_sql
   DECLARE b_fill1_curs CURSOR FOR anmq830_fill_pb
   
   LET l_sql2= "SELECT  UNIQUE nmdf006,nmdf005,nmdf004,nmdf007,nmdf012,nmdf013,nmdf008",
               "  FROM nmdf_t",
               " WHERE nmdfent='",g_enterprise,"'",
               "   AND ",ls_wc,
               "   AND nmdf006='",l_nmdf006_2,"'",cl_sql_add_filter("nmdf_t"),
               " ORDER BY nmdf_t.nmdf006,nmdf_t.nmdf005,nmdf_t.nmdf004"  
    
   LET l_sql2 = cl_sql_add_mask(l_sql2)              #遮蔽特定資料
   PREPARE anmq830_fill2_pb FROM l_sql2
   DECLARE b_fill2_curs CURSOR FOR anmq830_fill2_pb                   


   ##3:银行已收企业未收--1:企业已收银行未收--資料
   LET l_ac=1
   FOREACH b_fill1_curs INTO l_nmdf006,l_nmdf005,l_nmdf004,l_nmdf007,l_nmdf012,l_nmdf013,l_nmdf008
      LET g_nmdf_d[l_ac].sel='N'
      IF l_nmdf006='3' THEN  #3:银行已收企业未收
         LET g_nmdf_d[l_ac].nmdf006=l_nmdf006
         LET g_nmdf_d[l_ac].nmdf005=l_nmdf005
         LET g_nmdf_d[l_ac].nmdf004=l_nmdf004
         LET g_nmdf_d[l_ac].nmdf007=l_nmdf007
         
         ##1:企业已收银行未收
         IF l_ac>l_count2 THEN
            LET l_ac = l_ac + 1 
            CONTINUE FOREACH
         END IF
         IF l_ac=1 THEN
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='1'
         ELSE
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='1'
               AND nmdfseq>l_nmdfseq
         END IF               
         SELECT nmdf005,nmdf006,nmdf007,nmdf012,nmdf013 
           INTO g_nmdf_d[l_ac].nmdj004,g_nmdf_d[l_ac].nmdf0062,g_nmdf_d[l_ac].nmdf008,g_nmdf_d[l_ac].nmdf012,g_nmdf_d[l_ac].nmdf013
           FROM nmdf_t
          WHERE nmdfent=g_enterprise
            AND nmdf001=g_input.nmdf001
            AND nmdf002=g_input.nmdf002
            AND nmdf003=g_input.nmdf003 
            AND nmdfseq=l_nmdfseq            
      END IF
      IF l_nmdf006='1' THEN  #1:企业已收银行未收
         LET g_nmdf_d[l_ac].nmdf0062=l_nmdf006
         LET g_nmdf_d[l_ac].nmdj004=l_nmdf005
         LET g_nmdf_d[l_ac].nmdf012=l_nmdf012
         LET g_nmdf_d[l_ac].nmdf013=l_nmdf013
         LET g_nmdf_d[l_ac].nmdf008=l_nmdf007
         
         #3:银行已收企业未收
         IF l_ac>l_count1 THEN
            LET l_ac = l_ac + 1 
            CONTINUE FOREACH
         END IF         
         IF l_ac=1 THEN
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='3'
         ELSE
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='3'
               AND nmdfseq>l_nmdfseq
         END IF               
         SELECT nmdf004,nmdf005,nmdf006,nmdf007 
           INTO g_nmdf_d[l_ac].nmdf004,g_nmdf_d[l_ac].nmdf005,g_nmdf_d[l_ac].nmdf006,g_nmdf_d[l_ac].nmdf007
           FROM nmdf_t
          WHERE nmdfent=g_enterprise
            AND nmdf001=g_input.nmdf001
            AND nmdf002=g_input.nmdf002
            AND nmdf003=g_input.nmdf003 
            AND nmdfseq=l_nmdfseq            
      END IF   
      SELECT nmbc003 INTO g_nmdf_d[l_ac].l_nmbc003
        FROM nmbc_t
       WHERE nmbcent = g_enterprise
         AND nmbcdocno = g_nmdf_d[l_ac].nmdf012
         AND nmbcseq   = g_nmdf_d[l_ac].nmdf013
      LET g_nmdf_d[l_ac].l_nmbc003_desc =  s_desc_get_trading_partner_abbr_desc(g_nmdf_d[l_ac].l_nmbc003)
      LET l_ac = l_ac + 1       
   END FOREACH
   
   #4:银行已付企业未付--#2:企业已付银行未付--資料
   #IF l_ac>1 THEN
   #   LET l_ac = l_ac + 1
   #END IF
   FOREACH b_fill2_curs INTO l_nmdf006,l_nmdf005,l_nmdf004,l_nmdf007,l_nmdf012,l_nmdf013,l_nmdf008
      LET g_nmdf_d[l_ac].sel='N'
      IF l_nmdf006='4' THEN  #4:银行已付企业未付
         LET g_nmdf_d[l_ac].nmdf006=l_nmdf006
         LET g_nmdf_d[l_ac].nmdf005=l_nmdf005
         LET g_nmdf_d[l_ac].nmdf004=l_nmdf004
         LET g_nmdf_d[l_ac].nmdf007=l_nmdf008

         #2:企业已付银行未付
         IF l_ac>l_flag+l_count4 THEN
            LET l_ac = l_ac + 1
            CONTINUE FOREACH
         END IF           
         IF l_ac=l_flag+1 THEN
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='2'
         ELSE
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='2'
               AND nmdfseq>l_nmdfseq
         END IF               
         SELECT nmdf005,nmdf006,nmdf008,nmdf012,nmdf013 
           INTO g_nmdf_d[l_ac].nmdj004,g_nmdf_d[l_ac].nmdf0062,g_nmdf_d[l_ac].nmdf008,g_nmdf_d[l_ac].nmdf012,g_nmdf_d[l_ac].nmdf013
           FROM nmdf_t
          WHERE nmdfent=g_enterprise
            AND nmdf001=g_input.nmdf001
            AND nmdf002=g_input.nmdf002
            AND nmdf003=g_input.nmdf003 
            AND nmdfseq=l_nmdfseq  
      END IF
      IF l_nmdf006='2' THEN  #2:企业已付银行未付
         LET g_nmdf_d[l_ac].nmdf0062=l_nmdf006
         LET g_nmdf_d[l_ac].nmdj004=l_nmdf005
         LET g_nmdf_d[l_ac].nmdf012=l_nmdf012
         LET g_nmdf_d[l_ac].nmdf013=l_nmdf013
         LET g_nmdf_d[l_ac].nmdf008=l_nmdf008
         
         #4:银行已付企业未付
         IF l_ac>l_flag+l_count3 THEN
            LET l_ac = l_ac + 1
            CONTINUE FOREACH
         END IF         
         IF l_ac=l_flag+1 THEN
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='4'
         ELSE
            SELECT MIN(nmdfseq) INTO l_nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_input.nmdf001
               AND nmdf002=g_input.nmdf002
               AND nmdf003=g_input.nmdf003
               AND nmdf006='4'
               AND nmdfseq>l_nmdfseq
         END IF               
         SELECT nmdf004,nmdf005,nmdf006,nmdf008 
           INTO g_nmdf_d[l_ac].nmdf004,g_nmdf_d[l_ac].nmdf005,g_nmdf_d[l_ac].nmdf006,g_nmdf_d[l_ac].nmdf007
           FROM nmdf_t
          WHERE nmdfent=g_enterprise
            AND nmdf001=g_input.nmdf001
            AND nmdf002=g_input.nmdf002
            AND nmdf003=g_input.nmdf003 
            AND nmdfseq=l_nmdfseq           
      END IF   
      SELECT nmbc003 INTO g_nmdf_d[l_ac].l_nmbc003
        FROM nmbc_t
       WHERE nmbcent = g_enterprise
         AND nmbcdocno = g_nmdf_d[l_ac].nmdf012
         AND nmbcseq   = g_nmdf_d[l_ac].nmdf013
      LET g_nmdf_d[l_ac].l_nmbc003_desc =  s_desc_get_trading_partner_abbr_desc(g_nmdf_d[l_ac].l_nmbc003)
      LET l_ac = l_ac + 1       
   END FOREACH   
       
   LET g_detail_cnt = g_nmdf_d.getLength()
   LET l_ac =g_detail_cnt 
   IF g_detail_cnt > 0 THEN
      SELECT nmdjdocno INTO g_input.nmdjdocno
        FROM nmdj_t
       WHERE nmdjent=g_enterprise
         AND nmdj001=g_input.nmdf003
         AND nmdj002=g_input.nmdf001
         AND nmdj003=g_input.nmdf002
         AND nmdjstus='Y'

      SELECT nmas003 INTO g_input.nmas003
        FROM nmas_t
       WHERE nmasent=g_enterprise
         AND nmas002=g_input.nmdf003

   END IF


   #取得當期天數
   CALL s_date_get_max_day(g_input.nmdf001,g_input.nmdf002) RETURNING l_days
   #計算當年當月日期
   LET l_edate= MDY(g_input.nmdf002,l_days,g_input.nmdf001)
   LET l_bdate= MDY(g_input.nmdf002,1,g_input.nmdf001)
   
   #期末企業日記帳餘額
   #LET l_nmdf002=g_input.nmdf002-1
   #LET l_nmdf001=g_input.nmdf001
   #IF l_nmdf002<1 THEN
   #   LET l_nmdf002=l_nmdf002+12
   #   LET l_nmdf001=l_nmdf001-1
   #END IF
   SELECT SUM(nmbx103)-SUM(nmbx104) INTO g_amount1
     FROM nmbx_t
    WHERE nmbxent=g_enterprise
      AND nmbx001=g_input.nmdf001
      AND nmbx002<g_input.nmdf002
      AND nmbx003=g_input.nmdf003
   IF cl_null(g_amount1) THEN LET g_amount1=0 END IF
   
   SELECT SUM(nmbc103) INTO l_nmbc103
     FROM nmbc_t
    WHERE nmbcent=g_enterprise
      AND nmbc002=g_input.nmdf003
      AND nmbc005>=l_bdate
      AND nmbc005<=l_edate
      AND nmbc006='1'
   IF cl_null(l_nmbc103) THEN LET l_nmbc103=0 END IF
   
   SELECT SUM(nmbc103) INTO l_nmbc103_2
     FROM nmbc_t
    WHERE nmbcent=g_enterprise
      AND nmbc002=g_input.nmdf003
      AND nmbc005>=l_bdate
      AND nmbc005<=l_edate
      AND nmbc006='2'      
   IF cl_null(l_nmbc103_2) THEN LET l_nmbc103_2=0 END IF
    
   LET g_amount1=g_amount1+l_nmbc103-l_nmbc103_2  
    
   #3:銀行已收企業未收    
   SELECT SUM(nmdf007) INTO g_amount2
     FROM nmdf_t
    WHERE nmdfent=g_enterprise
      AND nmdf001=g_input.nmdf001
      AND nmdf002=g_input.nmdf002
      AND nmdf003=g_input.nmdf003  
      AND nmdf006='3'  
   IF cl_null(g_amount2) THEN LET g_amount2=0 END IF       
 
   #4:銀行已付企業未付    
   SELECT SUM(nmdf008) INTO g_amount3
     FROM nmdf_t
    WHERE nmdfent=g_enterprise
      AND nmdf001=g_input.nmdf001
      AND nmdf002=g_input.nmdf002
      AND nmdf003=g_input.nmdf003  
      AND nmdf006='4' 
   IF cl_null(g_amount3) THEN LET g_amount3=0 END IF       
   
   LET g_amount4=g_amount1+g_amount2-g_amount3


 #期末對帳單餘額
   SELECT MAX(nmdg003) INTO l_nmdg003
     FROM nmdg_t
    WHERE nmdgent=g_enterprise
      AND nmdg001=g_input.nmdf003
      AND nmdg003>=l_bdate
      AND nmdg003<=l_edate
     
   LET l_count=0     
   SELECT COUNT(*) INTO l_count
     FROM nmdg_t
    WHERE nmdgent=g_enterprise
      AND nmdg001=g_input.nmdf003 
      AND nmdg003>=l_bdate
      AND nmdg003<=l_edate
      AND nmdg003=l_nmdg003
   IF l_count>1 THEN
      SELECT MAX(nmdg004) INTO l_nmdg004
        FROM nmdg_t
       WHERE nmdgent=g_enterprise
         AND nmdg001=g_input.nmdf003 
         AND nmdg003>=l_bdate
         AND nmdg003<=l_edate
         AND nmdg003=l_nmdg003  
      SELECT nmdg010 INTO g_amount5
        FROM nmdg_t
       WHERE nmdgent=g_enterprise
         AND nmdg001=g_input.nmdf003 
         AND nmdg003>=l_bdate
         AND nmdg003<=l_edate
         AND nmdg003=l_nmdg003
         AND nmdg004=l_nmdg004
   ELSE
      SELECT nmdg010 INTO g_amount5
        FROM nmdg_t
       WHERE nmdgent=g_enterprise
         AND nmdg001=g_input.nmdf003 
         AND nmdg003>=l_bdate
         AND nmdg003<=l_edate
         AND nmdg003=l_nmdg003
   END IF       
   IF cl_null(g_amount5) THEN LET g_amount5=0 END IF 

   
   #1：企業已收銀行未收
   SELECT SUM(nmdf007) INTO g_amount6
     FROM nmdf_t
    WHERE nmdfent=g_enterprise
      AND nmdf001=g_input.nmdf001
      AND nmdf002=g_input.nmdf002
      AND nmdf003=g_input.nmdf003  
      AND nmdf006='1'  
   IF cl_null(g_amount6) THEN LET g_amount6=0 END IF   

   #2:企業已付銀行未付    
   SELECT SUM(nmdf008) INTO g_amount7
     FROM nmdf_t
    WHERE nmdfent=g_enterprise
      AND nmdf001=g_input.nmdf001
      AND nmdf002=g_input.nmdf002
      AND nmdf003=g_input.nmdf003  
      AND nmdf006='2' 
   IF cl_null(g_amount7) THEN LET g_amount7=0 END IF 

   LET g_amount8=g_amount5+g_amount6-g_amount7
   
   DISPLAY g_amount1 TO amount1
   DISPLAY g_amount2 TO amount2
   DISPLAY g_amount3 TO amount3
   DISPLAY g_amount4 TO amount4
   DISPLAY g_amount5 TO amount5
   DISPLAY g_amount6 TO amount6
   DISPLAY g_amount7 TO amount7 
   DISPLAY g_amount8 TO amount8      
   LET g_tot_cnt = g_nmdf_d.getLength()
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_nmdf_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE anmq830_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq830_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq830_detail_action_trans()
 
   LET l_ac = 1
   IF g_nmdf_d.getLength() > 0 THEN
      CALL anmq830_b_fill2()
   END IF
 
      CALL anmq830_filter_show('nmdf001','b_nmdf001')
   CALL anmq830_filter_show('nmdf002','b_nmdf002')
   CALL anmq830_filter_show('nmdf003','b_nmdf003')
   CALL anmq830_filter_show('nmdfseq','b_nmdfseq')
   CALL anmq830_filter_show('nmdf006','b_nmdf006')
   CALL anmq830_filter_show('nmdf005','b_nmdf005')
   CALL anmq830_filter_show('nmdf004','b_nmdf004')
   CALL anmq830_filter_show('nmdf007','b_nmdf007')
   CALL anmq830_filter_show('nmdf012','b_nmdf012')
   CALL anmq830_filter_show('nmdf013','b_nmdf013')
   CALL anmq830_filter_show('nmdf008','b_nmdf008')
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmq830.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq830_b_fill2()
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
   CALL anmq830_detail_action_trans_1()  #151002-00011#3
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="anmq830.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq830_detail_show(ps_page)
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
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq830.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION anmq830_filter()
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
      CONSTRUCT g_wc_filter ON nmdf001,nmdf002,nmdf003,nmdfseq,nmdf006,nmdf005,nmdf004,nmdf007,nmdf012, 
          nmdf013,nmdf008
                          FROM s_detail1[1].b_nmdf001,s_detail1[1].b_nmdf002,s_detail1[1].b_nmdf003, 
                              s_detail1[1].b_nmdfseq,s_detail1[1].b_nmdf006,s_detail1[1].b_nmdf005,s_detail1[1].b_nmdf004, 
                              s_detail1[1].b_nmdf007,s_detail1[1].b_nmdf012,s_detail1[1].b_nmdf013,s_detail1[1].b_nmdf008 
 
 
         BEFORE CONSTRUCT
                     DISPLAY anmq830_filter_parser('nmdf001') TO s_detail1[1].b_nmdf001
            DISPLAY anmq830_filter_parser('nmdf002') TO s_detail1[1].b_nmdf002
            DISPLAY anmq830_filter_parser('nmdf003') TO s_detail1[1].b_nmdf003
            DISPLAY anmq830_filter_parser('nmdfseq') TO s_detail1[1].b_nmdfseq
            DISPLAY anmq830_filter_parser('nmdf006') TO s_detail1[1].b_nmdf006
            DISPLAY anmq830_filter_parser('nmdf005') TO s_detail1[1].b_nmdf005
            DISPLAY anmq830_filter_parser('nmdf004') TO s_detail1[1].b_nmdf004
            DISPLAY anmq830_filter_parser('nmdf007') TO s_detail1[1].b_nmdf007
            DISPLAY anmq830_filter_parser('nmdf012') TO s_detail1[1].b_nmdf012
            DISPLAY anmq830_filter_parser('nmdf013') TO s_detail1[1].b_nmdf013
            DISPLAY anmq830_filter_parser('nmdf008') TO s_detail1[1].b_nmdf008
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmdf001>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf001
            #add-point:ON ACTION controlp INFIELD b_nmdf001 name="construct.c.filter.page1.b_nmdf001"
            
            #END add-point
 
 
         #----<<b_nmdf002>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf002
            #add-point:ON ACTION controlp INFIELD b_nmdf002 name="construct.c.filter.page1.b_nmdf002"
            
            #END add-point
 
 
         #----<<b_nmdf003>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf003
            #add-point:ON ACTION controlp INFIELD b_nmdf003 name="construct.c.filter.page1.b_nmdf003"
            
            #END add-point
 
 
         #----<<b_nmdfseq>>----
         #Ctrlp:construct.c.filter.page1.b_nmdfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdfseq
            #add-point:ON ACTION controlp INFIELD b_nmdfseq name="construct.c.filter.page1.b_nmdfseq"
            
            #END add-point
 
 
         #----<<b_nmdf006>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf006
            #add-point:ON ACTION controlp INFIELD b_nmdf006 name="construct.c.filter.page1.b_nmdf006"
            
            #END add-point
 
 
         #----<<b_nmdf005>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf005
            #add-point:ON ACTION controlp INFIELD b_nmdf005 name="construct.c.filter.page1.b_nmdf005"
            
            #END add-point
 
 
         #----<<b_nmdf004>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf004
            #add-point:ON ACTION controlp INFIELD b_nmdf004 name="construct.c.filter.page1.b_nmdf004"
            
            #END add-point
 
 
         #----<<b_nmdf007>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf007
            #add-point:ON ACTION controlp INFIELD b_nmdf007 name="construct.c.filter.page1.b_nmdf007"
            
            #END add-point
 
 
         #----<<nmdf0062>>----
         #----<<nmdj004_2>>----
         #----<<b_nmdf012>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf012
            #add-point:ON ACTION controlp INFIELD b_nmdf012 name="construct.c.filter.page1.b_nmdf012"
            
            #END add-point
 
 
         #----<<b_nmdf013>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf013
            #add-point:ON ACTION controlp INFIELD b_nmdf013 name="construct.c.filter.page1.b_nmdf013"
            
            #END add-point
 
 
         #----<<b_nmdf008>>----
         #Ctrlp:construct.c.filter.page1.b_nmdf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmdf008
            #add-point:ON ACTION controlp INFIELD b_nmdf008 name="construct.c.filter.page1.b_nmdf008"
            
            #END add-point
 
 
         #----<<l_nmbc003>>----
         #----<<l_nmbc003_desc>>----
 
 
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
 
      CALL anmq830_filter_show('nmdf001','b_nmdf001')
   CALL anmq830_filter_show('nmdf002','b_nmdf002')
   CALL anmq830_filter_show('nmdf003','b_nmdf003')
   CALL anmq830_filter_show('nmdfseq','b_nmdfseq')
   CALL anmq830_filter_show('nmdf006','b_nmdf006')
   CALL anmq830_filter_show('nmdf005','b_nmdf005')
   CALL anmq830_filter_show('nmdf004','b_nmdf004')
   CALL anmq830_filter_show('nmdf007','b_nmdf007')
   CALL anmq830_filter_show('nmdf012','b_nmdf012')
   CALL anmq830_filter_show('nmdf013','b_nmdf013')
   CALL anmq830_filter_show('nmdf008','b_nmdf008')
 
 
   CALL anmq830_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq830.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION anmq830_filter_parser(ps_field)
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
 
{<section id="anmq830.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq830_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq830_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="anmq830.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq830_detail_action_trans()
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
 
{<section id="anmq830.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq830_detail_index_setting()
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
            IF g_nmdf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmdf_d.getLength() AND g_nmdf_d.getLength() > 0
            LET g_detail_idx = g_nmdf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmdf_d.getLength() THEN
               LET g_detail_idx = g_nmdf_d.getLength()
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
 
{<section id="anmq830.mask_functions" >}
 &include "erp/anm/anmq830_mask.4gl"
 
{</section>}
 
{<section id="anmq830.other_function" readonly="Y" >}

################################################################################
# Descriptions...: XG 用tmp
# Memo...........:
# Date & Author..: 150930 By albireo
# Modify.........: 150924-00006#4
################################################################################
PRIVATE FUNCTION anmq830_create_tmp()
   DROP TABLE anmq830_x01_tmp;
   CREATE TEMP TABLE anmq830_x01_tmp(
   nmdf001  SMALLINT,
   nmdf002  SMALLINT,
   nmdf003  VARCHAR(10),
   l_nmdjdocno  VARCHAR(100),
   l_nmas003  VARCHAR(30),
   l_amount1  DECIMAL(26,10),
   l_amount2  DECIMAL(20,6),
   l_amount3  DECIMAL(20,6),
   l_amount4  DECIMAL(20,6),
   l_amount5  DECIMAL(20,6),
   l_amount6  DECIMAL(20,6),
   l_amount7  DECIMAL(20,6),
   l_amount8  DECIMAL(20,6),
   nmdf006  VARCHAR(1),
   l_nmdf006_desc  VARCHAR(100),
   nmdf005  DATE,
   nmdf004  VARCHAR(20),
   nmdf007  DECIMAL(20,6),
   l_nmdf0062  VARCHAR(100),
   l_nmdf0062_desc  VARCHAR(100),
   l_nmdj0042  DATE,
   nmdf012  VARCHAR(80),
   nmdf013  INTEGER,
   nmdf008  DECIMAL(20,6),
   l_nmbc003  VARCHAR(100),
   l_nmbc003_desc  VARCHAR(100)
   )
END FUNCTION

################################################################################
# Descriptions...: 分页 #151002-00011#3
# Date & Author..: 15/10/23 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq830_set_page()
   DEFINE li_idx      LIKE type_t.num5
   DEFINE l_sql       STRING
   
   LET li_idx = 1
   LET l_sql = "SELECT  UNIQUE nmdf001,nmdf002,nmdf003",
               "  FROM nmdf_t",
               " WHERE nmdfent='",g_enterprise,"'",
               "   AND ",g_wc,
               #160122-00001#29--add--str--
               "   AND nmdf003 IN (",g_sql_bank,")",  #160122-00001#29 By 07900 --mod
               #160122-00001#29--add--end
               " ORDER BY nmdf_t.nmdf001,nmdf_t.nmdf002,nmdf_t.nmdf003"               
   
   PREPARE anmq830_page_prep FROM l_sql
   DECLARE anmq830_page_curs CURSOR FOR anmq830_page_prep
   FOREACH anmq830_page_curs INTO g_detail2[li_idx].nmdf001,g_detail2[li_idx].nmdf002,g_detail2[li_idx].nmdf003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH anmq830_page_curs'
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      LET li_idx = li_idx + 1
      IF li_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET li_idx=li_idx - 1
   CALL g_detail2.deleteElement(g_detail2.getLength())
   LET g_header_cnt = g_detail2.getLength()
   LET g_row_count = g_detail2.getLength()
  #LET g_rec_b = li_idx
   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: #151002-00011#3
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq830_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準

   #end add-point
   #add-point:fetch段define-客製

   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:2)
   #add-point:fetch段CURSOR移動
   

   #end add-point

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

 
   #add-point:fetch結束前
   LET g_input.nmdjdocno = ''
   LET g_input.nmas003 = ''
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_input.nmdf001 = g_detail2[g_current_idx].nmdf001
   LET g_input.nmdf002 = g_detail2[g_current_idx].nmdf002
   LET g_input.nmdf003 = g_detail2[g_current_idx].nmdf003
   SELECT nmdjdocno INTO g_input.nmdjdocno
     FROM nmdj_t
    WHERE nmdjent=g_enterprise
      AND nmdj001=g_input.nmdf003
      AND nmdj002=g_input.nmdf001
      AND nmdj003=g_input.nmdf002
      AND nmdjstus='Y'
    
   SELECT nmas003 INTO g_input.nmas003
     FROM nmas_t
    WHERE nmasent=g_enterprise
      AND nmas002=g_input.nmdf003
   
   #end add-point

   #重新顯示
   DISPLAY g_input.* TO nmdf001,nmdf002,nmdf003,nmdjdocno,nmas003
 
   #讀入ref值
   #add-point:show段單身reference

   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL anmq830_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: #151002-00011#3
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq830_ui_dialog_1()
   #add-point:ui_dialog段define-客製

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
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   #150924-00006#1-----s
   DEFINE l_tmp   RECORD
         nmdf001 LIKE nmdf_t.nmdf001,
         nmdf002 LIKE nmdf_t.nmdf002,
         nmdf003 LIKE nmdf_t.nmdf003,
         l_nmdjdocno LIKE type_t.chr100,
         l_nmas003 LIKE type_t.chr30,
         l_amount1 LIKE type_t.num26_10,
         l_amount2 LIKE type_t.num20_6,
         l_amount3 LIKE type_t.num20_6,
         l_amount4 LIKE type_t.num20_6,
         l_amount5 LIKE type_t.num20_6,
         l_amount6 LIKE type_t.num20_6,
         l_amount7 LIKE type_t.num20_6,
         l_amount8 LIKE type_t.num20_6,
         nmdf006 LIKE nmdf_t.nmdf006,
         l_nmdf006_desc LIKE type_t.chr100,
         nmdf005 LIKE nmdf_t.nmdf005,
         nmdf004 LIKE nmdf_t.nmdf004,
         nmdf007 LIKE nmdf_t.nmdf007,
         l_nmdf0062 LIKE type_t.chr100,
         l_nmdf0062_desc LIKE type_t.chr100,
         l_nmdj0042 LIKE type_t.dat,
         nmdf012 LIKE nmdf_t.nmdf012,
         nmdf013 LIKE nmdf_t.nmdf013,
         nmdf008 LIKE nmdf_t.nmdf008,
         l_nmbc003 LIKE type_t.chr100,
         l_nmbc003_desc LIKE type_t.chr100         
                  END RECORD
   DEFINE l_i     LIKE type_t.num10
   #150924-00006#1-----e
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
 
   #add-point:ui_dialog段before dialog 
   #150715-00014#2-----s
   INITIALIZE g_input.* TO NULL
   CALL cl_set_comp_visible('sel',FALSE)
   CALL g_nmdf_d.clear()
   IF cl_null(g_input.nmdf001) OR g_input.nmdf001=0 THEN
      LET g_input.nmdf001=YEAR(g_today)
   END IF
   IF cl_null(g_input.nmdf002) OR g_input.nmdf002=0 THEN
      LET g_input.nmdf002=MONTH(g_today)
   END IF 
   DISPLAY BY NAME g_input.nmdf001
   DISPLAY BY NAME g_input.nmdf002
   #150715-00014#2-----e
   #end add-point
 
   
   CALL anmq830_b_fill()
  
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmdf_d.clear()
 
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
 
         CALL anmq830_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
        
         #end add-point
 
         #add-point:construct段落
         
         #end add-point
     
         DISPLAY ARRAY g_nmdf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmq830_detail_action_trans_1()  #151002-00011#3
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq830_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用

         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL anmq830_detail_action_trans_1()  #151002-00011#3
 
            #add-point:ui_dialog段before dialog
            CALL anmq830_construct()
            DISPLAY g_amount1 TO amount1
            DISPLAY g_amount2 TO amount2
            DISPLAY g_amount3 TO amount3
            DISPLAY g_amount4 TO amount4
            DISPLAY g_amount5 TO amount5
            DISPLAY g_amount6 TO amount6
            DISPLAY g_amount7 TO amount7 
            DISPLAY g_amount8 TO amount8  
            
            #150715-00014#2-----s
            CALL cl_set_act_visible('insert',FALSE)   #隱藏新增Action
            CALL cl_set_comp_visible('sel',FALSE)     #隱藏選取標籤
            #150715-00014#2-----e              
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

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
 
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmdf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmq830_b_fill()
 
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
            CALL anmq830_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq830_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq830_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq830_b_fill()
 
         #應用 qs19 樣板自動產生(Version:2)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               LET g_nmdf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               LET g_nmdf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmdf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmdf_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
 
 
 
 
         #應用 qs16 樣板自動產生(Version:2)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq830_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
 
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert

               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               #150924-00006#1-----s
               DELETE FROM anmq830_x01_tmp
               FOR l_i = 1 TO g_nmdf_d.getLength()
                  INITIALIZE l_tmp.* TO NULL
                  LET l_tmp.nmdf001     = g_input.nmdf001
                  LET l_tmp.nmdf002     = g_input.nmdf002
                  LET l_tmp.nmdf003     = g_input.nmdf003
                  LET l_tmp.l_nmdjdocno = g_input.nmdjdocno
                  LET l_tmp.l_nmas003   = g_input.nmas003
                  LET l_tmp.l_amount1   = g_amount1
                  LET l_tmp.l_amount2   = g_amount2
                  LET l_tmp.l_amount3   = g_amount3
                  LET l_tmp.l_amount4   = g_amount4
                  LET l_tmp.l_amount5   = g_amount5
                  LET l_tmp.l_amount6   = g_amount6
                  LET l_tmp.l_amount7   = g_amount7
                  LET l_tmp.l_amount8   = g_amount8
                  LET l_tmp.nmdf006     = g_nmdf_d[l_i].nmdf006
                  LET l_tmp.l_nmdf006_desc =  s_desc_gzcbl004_desc('9945',g_nmdf_d[l_i].nmdf006)
                  LET l_tmp.nmdf005     = g_nmdf_d[l_i].nmdf005
                  LET l_tmp.nmdf004     = g_nmdf_d[l_i].nmdf004
                  LET l_tmp.nmdf007     = g_nmdf_d[l_i].nmdf007
                  LET l_tmp.l_nmdf0062  = g_nmdf_d[l_i].nmdf0062
                  LET l_tmp.l_nmdf0062_desc = s_desc_gzcbl004_desc('9945',g_nmdf_d[l_i].nmdf0062)
                  LET l_tmp.l_nmdj0042  = g_nmdf_d[l_i].nmdj004
                  LET l_tmp.nmdf012     = g_nmdf_d[l_i].nmdf012
                  LET l_tmp.nmdf013     = g_nmdf_d[l_i].nmdf013
                  LET l_tmp.nmdf008     = g_nmdf_d[l_i].nmdf008
                  LET l_tmp.l_nmbc003_desc =g_nmdf_d[l_i].l_nmbc003_desc
                  LET l_tmp.l_nmbc003 =g_nmdf_d[l_i].l_nmbc003
                  INSERT INTO anmq830_x01_tmp VALUES(l_tmp.*)
               END FOR
               
               CALL anmq830_x01(' 1=1','anmq830_x01_tmp')
               #150924-00006#1-----e
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               #清除畫面及相關資料
               CLEAR FORM
               CALL g_nmdf_d.clear()
              
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
              
               CALL anmq830_init()
               CALL anmq830_construct()
               CALL anmq830_fetch('F')
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               
               
            END IF
 
         #151002-00011#3---add---str
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq830_fetch('L')
            LET g_action_choice = lc_action_choice_old
         #151002-00011#3---add---end
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後
            #150715-00014#2-----s
            INITIALIZE g_input.* TO NULL
            CALL g_nmdf_d.clear()
            IF cl_null(g_input.nmdf001) OR g_input.nmdf001=0 THEN
               LET g_input.nmdf001=YEAR(g_today)
            END IF
            IF cl_null(g_input.nmdf002) OR g_input.nmdf002=0 THEN
               LET g_input.nmdf002=MONTH(g_today)
            END IF 
            DISPLAY BY NAME g_input.nmdf001
            DISPLAY BY NAME g_input.nmdf002
            #150715-00014#2-----e
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point
 
      END DIALOG 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: #151002-00011#3
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq830_construct()
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
   #add-point:ui_dialog段define-標準
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_flag           LIKE type_t.num5
   
   LET l_flag=TRUE
   #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         
         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc ON nmdf001,nmdf002,nmdf003
           
            ON ACTION controlp INFIELD nmdf001 #年度
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
              #CALL q_glav001_1()   #151002-00011#3  mark
               LET g_qryparam.arg1 = "43"   #151002-00011#3 add
               CALL q_gzcb001()    #151002-00011#3 add
               DISPLAY g_qryparam.return1 TO nmdf001
               NEXT FIELD nmdf001         
         
            ON ACTION controlp INFIELD nmdf002 #期別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
              #CALL q_glav001_2() #151002-00011#3 mark
               LET g_qryparam.arg1 = "8861" #151002-00011#3
               CALL q_gzcb001() #151002-00011#3
               DISPLAY g_qryparam.return1 TO nmdf002
               NEXT FIELD nmdf002           
         
            ON ACTION controlp INFIELD nmdf003 #交易帳戶
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160122-00001#29--add--str--
               LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
               #160122-00001#29--add--end
               CALL q_nmas002_5()
               DISPLAY g_qryparam.return1 TO nmdf003
               NEXT FIELD nmdf003           
         
         
         END CONSTRUCT
         #end add-point
            
      
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
   
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
            #add-point:ON ACTION accept
            CALL anmq830_set_page()
            CALL anmq830_fetch('F')
            ACCEPT DIALOG
            #end add-point
 
 
      
         #交談指令共用ACTION
         &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單身分頁筆數顯示及action圖片顯示切換功能
# Memo...........: #151002-00011#3
# Usage..........: CALL anmq830_detail_action_trans_1()
# Date & Author..: 15/10/23 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq830_detail_action_trans_1()
   DISPLAY g_current_idx TO FORMONLY.h_index
   DISPLAY g_row_count TO FORMONLY.h_count
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
 
