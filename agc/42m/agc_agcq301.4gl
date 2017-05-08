#該程式未解開Section, 採用最新樣板產出!
{<section id="agcq301.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-11-06 11:11:08), PR版次:0003(2016-01-27 10:03:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: agcq301
#+ Description: 券資料查詢列印作業
#+ Creator....: 06189(2015-07-01 10:27:08)
#+ Modifier...: 06189 -SD/PR- 04226
 
{</section>}
 
{<section id="agcq301.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_gcao_d RECORD
       
       sel LIKE type_t.chr1, 
   seq LIKE type_t.chr500, 
   count LIKE type_t.chr500, 
   gcao001 LIKE gcao_t.gcao001, 
   gcao002 LIKE gcao_t.gcao002, 
   gcafl003 LIKE type_t.chr500, 
   oocq009 LIKE oocq_t.oocq009, 
   gcao008 LIKE gcao_t.gcao008, 
   gcao009 LIKE gcao_t.gcao009
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_rtdy001            LIKE rtdy_t.rtdy001
DEFINE g_number             LIKE type_t.num10
DEFINE g_gcao002            LIKE gcao_t.gcao002
DEFINE g_gcao002_t            LIKE gcao_t.gcao002
DEFINE g_gcao003            LIKE gcao_t.gcao003
DEFINE g_gcao001            LIKE gcao_t.gcao001
DEFINE g_gcao001_1            LIKE gcao_t.gcao001
DEFINE g_cust_rec   RECORD
               id               STRING,
               template         STRING,
               data                     DYNAMIC ARRAY OF RECORD
                rowid     LIKE          type_t.num5,           #项次
                count     LIKE          type_t.chr500,         #打印数量
                inna28    LIKE          gcao_t.gcao001,        #券编号
                inna29    LIKE          gcao_t.gcao002,        #券种编号
                inna30    LIKE          gcafl_t.gcafl003,      #券种编号说明
                inna31    LIKE          oocq_t.oocq009,        #券面额
                inna32    LIKE          gcao_t.gcao008,        #生效日期
                inna33    LIKE          gcao_t.gcao009,        #失效日期
                inna24    LIKE          stba_t.stbaownid,       #打印人员
                inna34    LIKE          ooefl_t.ooefl003,      #门店
                inna35    LIKE          gcaa_t.gcaa035         #打印内容
                    END RECORD
               END RECORD
DEFINE g_str        LIKE type_t.chr50
DEFINE g_insert             LIKE type_t.chr5 
DEFINE g_aw                  STRING 
DEFINE g_rtiadocno  LIKE rtia_t.rtiadocno 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_gcao_d            DYNAMIC ARRAY OF type_g_gcao_d
DEFINE g_gcao_d_t          type_g_gcao_d
 
 
 
 
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
 
{<section id="agcq301.main" >}
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
   CALL cl_ap_init("agc","")
 
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
   DECLARE agcq301_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agcq301_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcq301_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agcq301 WITH FORM cl_ap_formpath("agc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agcq301_init()   
 
      #進入選單 Menu (="N")
      CALL agcq301_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agcq301
      
   END IF 
   
   CLOSE agcq301_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agcq301.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agcq301_init()
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
   
   #end add-point
 
   CALL agcq301_default_search()
END FUNCTION
 
{</section>}
 
{<section id="agcq301.default_search" >}
PRIVATE FUNCTION agcq301_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " gcao001 = '", g_argv[01], "' AND "
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
 
{<section id="agcq301.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION agcq301_ui_dialog() 
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
   DEFINE l_cnt         LIKE type_t.num10 
   DEFINE l_gcao002     LIKE gcao_t.gcao002  #160126-00002#1 160127 By pomelo add
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
   #CALL agcq301_query()          #160126-00002#1 160127 By pomelo mark
   #end add-point
 
   
   CALL agcq301_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gcao_d.clear()
 
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
 
         CALL agcq301_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #160126-00002#1 160127 By pomelo add(S)
         INPUT g_gcao002,g_gcao003 FROM gcao002,gcao003 ATTRIBUTE(WITHOUT DEFAULTS)    
             
             BEFORE INPUT
             
             ON ACTION controlp INFIELD gcao002
		  	       INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
		  	       LET g_qryparam.reqry = FALSE
                CALL q_gcaf001()
                LET g_gcao002 = g_qryparam.return1 
                DISPLAY g_gcao002 TO gcao002
                NEXT FIELD gcao002 
              
            
             ON ACTION controlp INFIELD gcao003
		  	       INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
		  	       LET g_qryparam.reqry = FALSE 
                LET g_qryparam.arg1 = '2071'		   
                CALL q_oocq002()
                LET g_gcao003 = g_qryparam.return1 
                DISPLAY g_gcao003 TO gcao003
                NEXT FIELD gcao003            
           
             AFTER FIELD gcao002
                IF NOT cl_null(g_gcao002) THEN
                   LET l_cnt = 0
                   SELECT COUNT(*) INTO l_cnt
                     FROM gcaf_t 
                    WHERE gcafent = g_enterprise
                      AND gcaf001 = g_gcao002             
                   IF l_cnt = 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = 'agc-00001'
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                     
                      NEXT FIELD CURRENT
                   
                   END IF
                   LET l_cnt = 0
                   SELECT COUNT(*) INTO l_cnt
                     FROM gcaf_t 
                    WHERE gcafent = g_enterprise
                      AND gcaf001 = g_gcao002
                      AND gcafstus = 'Y'                   
                   IF l_cnt = 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = 'amm-00194'
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                      NEXT FIELD CURRENT
                   END IF
                   IF g_gcao002 != g_gcao002_t THEN
                      LET g_gcao001 = ''
                      LET g_gcao001_1 = ''
                   END IF
                   LET g_gcao002_t = g_gcao002
                END IF
              
             AFTER FIELD gcao003
                IF NOT cl_null(g_gcao003) THEN
                   LET l_cnt = 0
                   SELECT COUNT(*) INTO l_cnt
                     FROM oocq_t 
                    WHERE oocqent = g_enterprise
                      AND oocq001 = '2071'
                      AND oocq002 = g_gcao003                  
                   IF l_cnt = 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = 'agc-00011'
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                      NEXT FIELD CURRENT
                   END IF
                   LET l_cnt = 0
                   SELECT COUNT(*) INTO l_cnt
                     FROM oocq_t 
                    WHERE oocqent = g_enterprise
                      AND oocq001 = '2071'
                      AND oocq002 = g_gcao003    
                      AND oocqstus = 'Y'                   
                   IF l_cnt = 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = 'agc-00012'
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                      NEXT FIELD CURRENT
                   END IF
                END IF
                
           AFTER INPUT
        END INPUT
        
        INPUT g_number FROM number ATTRIBUTE(WITHOUT DEFAULTS)
           BEFORE INPUT
       
           DISPLAY g_number TO number
            
           AFTER INPUT
        END INPUT
        
        INPUT g_rtdy001 FROM rtdy001 ATTRIBUTE(WITHOUT DEFAULTS)    
            BEFORE INPUT 
               DISPLAY g_rtdy001 TO rtdy001
               
            ON ACTION controlp INFIELD rtdy001
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = " rtdystus = 'Y' "
              CALL q_rtdy001()
              LET g_rtdy001 = g_qryparam.return1
              DISPLAY g_rtdy001 TO rtdy001
              NEXT FIELD rtdy001
           
           AFTER FIELD rtdy001
              IF NOT cl_null(g_rtdy001) THEN
                 LET l_cnt = 0
                 SELECT COUNT(*) INTO l_cnt
                   FROM rtdy_t 
                  WHERE rtdyent = g_enterprise
                    AND rtdy001 = g_rtdy001             
                    AND rtdystus = 'Y'
                 IF l_cnt = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ''
                    LET g_errparam.code   = 'art-00631'
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                    NEXT FIELD CURRENT
                 END IF
              END IF
              
            AFTER INPUT
              
         END INPUT
        
         INPUT g_gcao001,g_gcao001_1 FROM gcao001,gcao001_1 ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT 
               DISPLAY g_gcao001,g_gcao001_1 TO gcao001,gcao001_1
               
            ON ACTION controlp INFIELD gcao001
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
              IF NOT cl_null(g_gcao002)   THEN
                 LET g_qryparam.where = " gcao002 = '",g_gcao002,"'"
              END IF
              CALL q_gcao001_9()
              LET g_gcao001 = g_qryparam.return1 
              DISPLAY g_gcao001 TO gcao001
              NEXT FIELD gcao001
           
           BEFORE FIELD gcao001
              IF g_gcao002 IS NULL THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'agc-00116'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()                
                 NEXT FIELD gcao002 
              END IF
             
           AFTER FIELD gcao001
              IF NOT cl_null(g_gcao001)   THEN
                 #券号是否存在
                 LET l_cnt = 0
                 SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcao001 = g_gcao001
                  AND gcaoent = g_enterprise
                 IF l_cnt = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ''
                    LET g_errparam.code   = 'agc-00114'
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()                
                    NEXT FIELD CURRENT
                 END IF 
                 #券号是否存在与券种之下               
                 INITIALIZE l_gcao002 TO NULL
                 SELECT gcao002 INTO l_gcao002 FROM gcao_t WHERE gcao001 = g_gcao001
                  AND gcaoent = g_enterprise                          
                 IF l_gcao002 != g_gcao002 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ''
                    LET g_errparam.code   = 'agc-00115'
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                    NEXT FIELD CURRENT
                 END IF
                 #起始券号不能大于结束券号
                 IF NOT cl_null(g_gcao001_1)  THEN
                    IF g_gcao001 > g_gcao001_1 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = ''
                       LET g_errparam.code   = 'agc-00010'
                       LET g_errparam.popup  = TRUE
                       CALL cl_err()
                       NEXT FIELD CURRENT
                    END IF
                 END IF
              END IF
              
           ON ACTION controlp INFIELD gcao001_1
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'     
              LET g_qryparam.reqry = FALSE
              IF NOT cl_null(g_gcao002)   THEN
                 LET g_qryparam.where = " gcao002 = '",g_gcao002,"'"
              END IF
              CALL q_gcao001_9()
              LET g_gcao001_1 = g_qryparam.return1
              DISPLAY g_gcao001_1 TO gcao001_1
              NEXT FIELD gcao001_1
           
           BEFORE FIELD gcao001_1
             IF g_gcao002 IS NULL THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = ''
                LET g_errparam.code   = 'agc-00116'
                LET g_errparam.popup  = TRUE
                CALL cl_err()                
                NEXT FIELD gcao002 
             END IF
             
           AFTER FIELD gcao001_1
              IF NOT cl_null(g_gcao001_1)   THEN
                 #券号是否存在
                 LET l_cnt = 0
                 SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcao001 = g_gcao001_1
                  AND gcaoent = g_enterprise
                 IF l_cnt = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ''
                    LET g_errparam.code   = 'agc-00114'
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()                
                    NEXT FIELD CURRENT
                 END IF
                 
                 #券号是否存在与券种之下
                 INITIALIZE l_gcao002 TO NULL               
                 SELECT gcao002 INTO l_gcao002 FROM gcao_t WHERE gcao001 = g_gcao001_1
                  AND gcaoent = g_enterprise                          
                 IF l_gcao002 != g_gcao002 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ''
                    LET g_errparam.code   = 'agc-00115'
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                    NEXT FIELD CURRENT
                 END IF
                 
                 #起始券号不能大于结束券号
                 IF NOT cl_null(g_gcao001)  THEN
                    IF g_gcao001 > g_gcao001_1 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = ''
                       LET g_errparam.code   = 'agc-00010'
                       LET g_errparam.popup  = TRUE
                       CALL cl_err()
                       NEXT FIELD CURRENT
                    END IF
                 END IF
              END IF
              
              AFTER INPUT
              
         END INPUT
         #160126-00002#1 160127 By pomelo add(E)
         #end add-point
     
         DISPLAY ARRAY g_gcao_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL agcq301_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL agcq301_b_fill2()
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
            CALL agcq301_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert,query", FALSE)   #160126-00002#1 160127 By pomelo add
            #NEXT FIELD sel                                  #160126-00002#1 160127 By pomelo mark
            #end add-point
            NEXT FIELD rtdy001
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            ON ACTION modify_detail
               LET g_action_choice="modify_detail"
               IF cl_auth_chk_act("modify") THEN
                  LET g_aw = g_curr_diag.getCurrentItem()
                  CALL cl_set_act_visible("insert", FALSE)
                  CALL agcq301_modify()
                  #add-point:ON ACTION modify_detail
                                                
                  #END add-point
                  
               END IF
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
            LET g_wc = " 1=1"   #160126-00002#1 160127 By pomelo add
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL agcq301_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_gcao_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL agcq301_b_fill()
 
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
            CALL agcq301_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL agcq301_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL agcq301_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL agcq301_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_gcao_d.getLength()
               LET g_gcao_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_gcao_d.getLength()
               LET g_gcao_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_gcao_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gcao_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_gcao_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gcao_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL agcq301_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print
            LET g_action_choice="print"
            IF cl_auth_chk_act("print") THEN
               
               #add-point:ON ACTION print name="menu.print"
               LET l_cnt = g_gcao_d.getLength()
               IF l_cnt > 0 THEN 
                  
                  CALL agcq301_print()
                  
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00633'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  EXIT DIALOG
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET l_cnt = g_gcao_d.getLength()
               IF l_cnt > 0 THEN 
                  
                  CALL agcq301_print()
                  
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00633'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  EXIT DIALOG
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET l_cnt = g_gcao_d.getLength()
               IF l_cnt > 0 THEN 
                  
                  CALL agcq301_print()
                  
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00633'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  EXIT DIALOG
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL agcq301_query()
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
 
{<section id="agcq301.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agcq301_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #160126-00002#1 160127 By pomelo mark(S)
   #IF g_wc = " 1=2" THEN
   #   LET g_wc = " 1=1"
   #END IF
   #160126-00002#1 160127 By pomelo mark(E)
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
 
   CALL g_gcao_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','',gcao001,gcao002,'','',gcao008,gcao009  ,DENSE_RANK() OVER( ORDER BY gcao_t.gcao001) AS RANK FROM gcao_t", 
 
 
 
                     "",
                     " WHERE gcaoent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gcao_t"),
                     " ORDER BY gcao_t.gcao001"
 
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
 
   LET g_sql = "SELECT '','','',gcao001,gcao002,'','',gcao008,gcao009",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE '','','',gcao001,gcao002,gcafl003,oocq009,gcao008,gcao009  FROM gcao_t", 
                     " LEFT JOIN oocq_t ON oocqent = gcaoent AND oocq001 = '2071' AND oocq002 = gcao003",
                     " LEFT JOIN gcafl_t ON gcaflent = gcaoent AND gcafl001 = gcao002 AND gcafl002 = '"||g_dlang||"'",
                     " WHERE gcaoent= ? AND 1=1 AND ", ls_wc
   IF NOT cl_null(g_gcao002) THEN
      LET g_sql = g_sql," AND gcao002 ='",g_gcao002,"'"
   END IF
   IF NOT cl_null(g_gcao003) THEN
      LET g_sql = g_sql," AND gcao003 ='",g_gcao003,"'"
   END IF
   IF NOT cl_null(g_gcao001) THEN
      LET g_sql = g_sql," AND gcao001 >='",g_gcao001,"'"
   END IF
   IF NOT cl_null(g_gcao001_1) THEN
      LET g_sql = g_sql," AND gcao001 <='",g_gcao001_1,"'"
   END IF
   LET g_sql = g_sql," ORDER BY gcao001"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE agcq301_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR agcq301_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_gcao_d[l_ac].sel,g_gcao_d[l_ac].seq,g_gcao_d[l_ac].count,g_gcao_d[l_ac].gcao001, 
       g_gcao_d[l_ac].gcao002,g_gcao_d[l_ac].gcafl003,g_gcao_d[l_ac].oocq009,g_gcao_d[l_ac].gcao008, 
       g_gcao_d[l_ac].gcao009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_gcao_d[l_ac].sel = 'Y'
      LET g_gcao_d[l_ac].seq = l_ac
      LET g_gcao_d[l_ac].count = '1'
      #end add-point
 
      CALL agcq301_detail_show("'1'")
 
      CALL agcq301_gcao_t_mask()
 
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
 
   CALL g_gcao_d.deleteElement(g_gcao_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_gcao_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE agcq301_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL agcq301_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL agcq301_detail_action_trans()
 
   LET l_ac = 1
   IF g_gcao_d.getLength() > 0 THEN
      CALL agcq301_b_fill2()
   END IF
 
      CALL agcq301_filter_show('gcao001','b_gcao001')
   CALL agcq301_filter_show('gcao002','b_gcao002')
   CALL agcq301_filter_show('oocq009','b_oocq009')
   CALL agcq301_filter_show('gcao008','b_gcao008')
   CALL agcq301_filter_show('gcao009','b_gcao009')
 
 
END FUNCTION
 
{</section>}
 
{<section id="agcq301.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agcq301_b_fill2()
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
   LET g_detail_cnt = g_gcao_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="agcq301.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION agcq301_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gcao_d[l_ac].gcao002
            LET ls_sql = "SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_gcao_d[l_ac].gcafl003 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gcao_d[l_ac].gcafl003

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agcq301.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION agcq301_filter()
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
      CONSTRUCT g_wc_filter ON gcao001,gcao002,oocq009,gcao008,gcao009
                          FROM s_detail1[1].b_gcao001,s_detail1[1].b_gcao002,s_detail1[1].b_oocq009, 
                              s_detail1[1].b_gcao008,s_detail1[1].b_gcao009
 
         BEFORE CONSTRUCT
                     DISPLAY agcq301_filter_parser('gcao001') TO s_detail1[1].b_gcao001
            DISPLAY agcq301_filter_parser('gcao002') TO s_detail1[1].b_gcao002
            DISPLAY agcq301_filter_parser('oocq009') TO s_detail1[1].b_oocq009
            DISPLAY agcq301_filter_parser('gcao008') TO s_detail1[1].b_gcao008
            DISPLAY agcq301_filter_parser('gcao009') TO s_detail1[1].b_gcao009
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<seq>>----
         #----<<count>>----
         #----<<b_gcao001>>----
         #Ctrlp:construct.c.page1.b_gcao001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gcao001
            #add-point:ON ACTION controlp INFIELD b_gcao001 name="construct.c.filter.page1.b_gcao001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gcao001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gcao001  #顯示到畫面上
            NEXT FIELD b_gcao001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_gcao002>>----
         #Ctrlp:construct.c.page1.b_gcao002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gcao002
            #add-point:ON ACTION controlp INFIELD b_gcao002 name="construct.c.filter.page1.b_gcao002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gcaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gcao002  #顯示到畫面上
            NEXT FIELD b_gcao002                     #返回原欄位
    


            #END add-point
 
 
         #----<<gcafl003>>----
         #----<<b_oocq009>>----
         #Ctrlp:construct.c.filter.page1.b_oocq009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_oocq009
            #add-point:ON ACTION controlp INFIELD b_oocq009 name="construct.c.filter.page1.b_oocq009"
            
            #END add-point
 
 
         #----<<b_gcao008>>----
         #Ctrlp:construct.c.filter.page1.b_gcao008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gcao008
            #add-point:ON ACTION controlp INFIELD b_gcao008 name="construct.c.filter.page1.b_gcao008"
            
            #END add-point
 
 
         #----<<b_gcao009>>----
         #Ctrlp:construct.c.filter.page1.b_gcao009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gcao009
            #add-point:ON ACTION controlp INFIELD b_gcao009 name="construct.c.filter.page1.b_gcao009"
            
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
 
      CALL agcq301_filter_show('gcao001','b_gcao001')
   CALL agcq301_filter_show('gcao002','b_gcao002')
   CALL agcq301_filter_show('oocq009','b_oocq009')
   CALL agcq301_filter_show('gcao008','b_gcao008')
   CALL agcq301_filter_show('gcao009','b_gcao009')
 
 
   CALL agcq301_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="agcq301.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION agcq301_filter_parser(ps_field)
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
 
{<section id="agcq301.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION agcq301_filter_show(ps_field,ps_object)
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
   LET ls_condition = agcq301_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="agcq301.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION agcq301_detail_action_trans()
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
 
{<section id="agcq301.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION agcq301_detail_index_setting()
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
            IF g_gcao_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_gcao_d.getLength() AND g_gcao_d.getLength() > 0
            LET g_detail_idx = g_gcao_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_gcao_d.getLength() THEN
               LET g_detail_idx = g_gcao_d.getLength()
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
 
{<section id="agcq301.mask_functions" >}
 &include "erp/agc/agcq301_mask.4gl"
 
{</section>}
 
{<section id="agcq301.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查询方法
# Memo...........:
# Usage..........: CALL agcq301_query()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150701 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION agcq301_query()
DEFINE ls_wc         LIKE type_t.chr500
DEFINE ls_return     STRING
DEFINE ls_result     STRING 
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_success     LIKE type_t.num5 
DEFINE l_errno       LIKE type_t.chr10
DEFINE r_insert      LIKE type_t.num5
DEFINE ls_sql        STRING
DEFINE l_gcao002     LIKE gcao_t.gcao002
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gcao_d.clear()
   INITIALIZE g_gcao002 TO NULL #
   INITIALIZE g_gcao003 TO NULL #
   INITIALIZE g_gcao001 TO NULL #
   INITIALIZE g_gcao001_1 TO NULL #
   LET g_qryparam.state = "c"
   IF g_number = 0 THEN
      LET g_number = 1
   END IF  
   #wc備份
   LET ls_wc = g_wc2
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      INPUT g_gcao002,g_gcao003 FROM gcao002,gcao003  
         ATTRIBUTE(WITHOUT DEFAULTS)    

         BEFORE INPUT
         

         ON ACTION controlp INFIELD gcao002
            
           
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            CALL q_gcaf001()                       #呼叫開窗
            LET g_gcao002 = g_qryparam.return1 
            DISPLAY g_gcao002 TO gcao002  #顯示到畫面上
            
            NEXT FIELD gcao002 
            
          
         ON ACTION controlp INFIELD gcao003
            #add-point:ON ACTION controlp INFIELD deag002
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2071'		   
            CALL q_oocq002()                           #呼叫開窗
            LET g_gcao003 = g_qryparam.return1 
            DISPLAY g_gcao003 TO gcao003  #顯示到畫面上
             
            NEXT FIELD gcao003            
         
         AFTER FIELD gcao002
            IF NOT cl_null(g_gcao002) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM gcaf_t 
                WHERE gcafent = g_enterprise
                  AND gcaf001 = g_gcao002             
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00001'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM gcaf_t 
                WHERE gcafent = g_enterprise
                  AND gcaf001 = g_gcao002
                  AND gcafstus = 'Y'                   
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'amm-00194'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
               IF g_gcao002 != g_gcao002_t THEN
                  LET g_gcao001 = ''
                  LET g_gcao001_1 = ''
               END IF
               LET g_gcao002_t = g_gcao002
            END IF
         
         
            
         AFTER FIELD gcao003
            IF NOT cl_null(g_gcao003) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM oocq_t 
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2071'
                  AND oocq002 = g_gcao003                  
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00011'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
                LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM oocq_t 
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2071'
                  AND oocq002 = g_gcao003    
                  AND oocqstus = 'Y'                   
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00012'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
            END IF
         
         
         AFTER INPUT

         
      END INPUT
      
      INPUT g_number FROM number  
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT

         DISPLAY g_number TO number
          
         AFTER INPUT
      END INPUT
      
      INPUT g_rtdy001 FROM rtdy001
           ATTRIBUTE(WITHOUT DEFAULTS)    
          BEFORE INPUT 
             DISPLAY g_rtdy001
                  TO rtdy001
  

          ON ACTION controlp INFIELD rtdy001
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值

            #給予arg
            LET g_qryparam.where = " rtdystus = 'Y' "
            CALL q_rtdy001()                                #呼叫開窗

            LET g_rtdy001 = g_qryparam.return1              

            DISPLAY g_rtdy001 TO rtdy001             #顯示到畫面上

            NEXT FIELD rtdy001
         
         AFTER FIELD rtdy001
            IF NOT cl_null(g_rtdy001) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtdy_t 
                WHERE rtdyent = g_enterprise
                  AND rtdy001 = g_rtdy001             
                  AND rtdystus = 'Y'
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'art-00631'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
            END IF
           
            AFTER INPUT
            
       END INPUT
      
      INPUT g_gcao001,g_gcao001_1
       FROM gcao001,gcao001_1
           ATTRIBUTE(WITHOUT DEFAULTS)
       
          BEFORE INPUT 
             DISPLAY g_gcao001,g_gcao001_1
                  TO gcao001,gcao001_1
          
    

          ON ACTION controlp INFIELD gcao001
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值

            #給予arg
            IF NOT cl_null(g_gcao002)   THEN
               LET g_qryparam.where = " gcao002 = '",g_gcao002,"'"
            END IF
            CALL q_gcao001_9()                                #呼叫開窗

            LET g_gcao001 = g_qryparam.return1              

            DISPLAY g_gcao001 TO gcao001             #顯示到畫面上

            NEXT FIELD gcao001
         
         BEFORE FIELD gcao001
           IF g_gcao002 IS NULL THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = ''
              LET g_errparam.code   = 'agc-00116'
              LET g_errparam.popup  = TRUE
              CALL cl_err()                
              NEXT FIELD gcao002 
           END IF
         AFTER FIELD gcao001
            IF NOT cl_null(g_gcao001)   THEN
               #券号是否存在
               LET l_cnt = 0
               SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcao001 = g_gcao001
                AND gcaoent = g_enterprise
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00114'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()                
                  NEXT FIELD CURRENT
               END IF 
               #券号是否存在与券种之下               
               INITIALIZE l_gcao002 TO NULL
               SELECT gcao002 INTO l_gcao002 FROM gcao_t WHERE gcao001 = g_gcao001
                AND gcaoent = g_enterprise                          
               IF l_gcao002 != g_gcao002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00115'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
               #起始券号不能大于结束券号
               IF NOT cl_null(g_gcao001_1)  THEN
                  IF g_gcao001 > g_gcao001_1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'agc-00010'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                    
                     NEXT FIELD CURRENT
                  
                  END IF
               END IF
            END IF
            
         ON ACTION controlp INFIELD gcao001_1
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值

            #給予arg
            IF NOT cl_null(g_gcao002)   THEN
               LET g_qryparam.where = " gcao002 = '",g_gcao002,"'"
            END IF
            CALL q_gcao001_9()                                #呼叫開窗

            LET g_gcao001_1 = g_qryparam.return1              

            DISPLAY g_gcao001_1 TO gcao001_1             #顯示到畫面上

            NEXT FIELD gcao001_1
         
         BEFORE FIELD gcao001_1
           IF g_gcao002 IS NULL THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = ''
              LET g_errparam.code   = 'agc-00116'
              LET g_errparam.popup  = TRUE
              CALL cl_err()                
              NEXT FIELD gcao002 
           END IF
         AFTER FIELD gcao001_1
            IF NOT cl_null(g_gcao001_1)   THEN
               #券号是否存在
               LET l_cnt = 0
               SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcao001 = g_gcao001_1
                AND gcaoent = g_enterprise
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00114'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()                
                  NEXT FIELD CURRENT
               END IF
               #券号是否存在与券种之下
               INITIALIZE l_gcao002 TO NULL               
               SELECT gcao002 INTO l_gcao002 FROM gcao_t WHERE gcao001 = g_gcao001_1
                AND gcaoent = g_enterprise                          
               IF l_gcao002 != g_gcao002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00115'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
               #起始券号不能大于结束券号
               IF NOT cl_null(g_gcao001)  THEN
                  IF g_gcao001 > g_gcao001_1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'agc-00010'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                    
                     NEXT FIELD CURRENT
                  
                  END IF
               END IF
            END IF
            
            
            
          AFTER INPUT
            
       END INPUT


      BEFORE DIALOG 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   END IF
    
   LET g_error_show = 1
   CALL agcq301_b_fill()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET INT_FLAG = FALSE
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........:
# Usage..........: CALL agcq301_print()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150701 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION agcq301_print()
DEFINE l_cn         LIKE type_t.num10
 DEFINE l_sql        STRING
 DEFINE ls          STRING
 DEFINE l_str        LIKE type_t.chr50
 DEFINE l_str1       STRING
 DEFINE l_str2       STRING
 DEFINE l_dir        STRING
 DEFINE l_json_path STRING
 DEFINE ls_tmp      STRING
 DEFINE l_channel   base.Channel
 DEFINE obj util.JSONObject
 DEFINE  l_url                  STRING
 DEFINE l_c                     STRING
 DEFINE p_content   STRING
 DEFINE l_time      DATETIME YEAR TO FRACTION(5)
 DEFINE path          STRING
 DEFINE l_result INTEGER
 DEFINE parm1          STRING
 DEFINE parm2          STRING
 DEFINE parm3          STRING
 DEFINE l_str3          STRING
 DEFINE l_gcaf037   LIKE gcaf_t.gcaf037    #20151110--dongsz add
 DEFINE l_gcao036   LIKE gcao_t.gcao036    #20151110--dongsz add

#   CALL g_cust_rec.data.clear()
   FOR l_ac = 1 TO g_gcao_d.getLength() STEP 1
      IF g_gcao_d[l_ac].sel = 'Y' AND g_gcao_d[l_ac].count >= 1 THEN
         LET l_cn = g_cust_rec.data.getLength()+1
         
         #20151110--dongsz add--str
         SELECT gcaf037 INTO l_gcaf037
           FROM gcaf_t
          WHERE gcafent = g_enterprise
            AND gcaf001 = g_gcao_d[l_ac].gcao002
         IF l_gcaf037 = 'Y' THEN
            SELECT gcao036 INTO l_gcao036
              FROM gcao_t
             WHERE gcaoent = g_enterprise
               AND gcao001 = g_gcao_d[l_ac].gcao001
            LET g_gcao_d[l_ac].gcao001 = g_gcao_d[l_ac].gcao001,l_gcao036
         END IF
         #20151110--dongsz add--end
                 
         LET g_cust_rec.data[l_cn].rowid=g_gcao_d[l_ac].seq
         LET g_cust_rec.data[l_cn].count=g_gcao_d[l_ac].count
         LET g_cust_rec.data[l_cn].inna28=g_gcao_d[l_ac].gcao001
         LET g_cust_rec.data[l_cn].inna29=g_gcao_d[l_ac].gcao002
         LET g_cust_rec.data[l_cn].inna30=g_gcao_d[l_ac].gcafl003         
         LET g_cust_rec.data[l_cn].inna31=g_gcao_d[l_ac].oocq009
         LET g_cust_rec.data[l_cn].inna32=g_gcao_d[l_ac].gcao008
         LET g_cust_rec.data[l_cn].inna33=g_gcao_d[l_ac].gcao009
         LET g_cust_rec.data[l_cn].inna24=g_user

      END IF       
   END FOR
   
   LET l_time = cl_get_timestamp()
   LET l_str = l_time
   LET l_str1 = l_str[1,4],l_str[6,7],l_str[9,10],l_str[12,13],l_str[15,16],l_str[18,19],l_str[21,25]

   LET l_str = l_str1,".dt"
   #LET g_str = l_str1
   
   LET l_dir = FGL_GETENV("TEMPDIR"),"/",l_str
   LET l_c ="touch ",l_dir
   RUN l_c
   
   LET g_cust_rec.id = l_str1  
   LET g_cust_rec.template = g_rtdy001,".svg" 
  
   
   LET obj = util.JSONObject.fromFGL(g_cust_rec)
   #產生json string
   LET p_content = obj.toString()
   LET l_json_path = os.Path.join(FGL_GETENV("TEMPDIR"), l_str)
   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openFile(l_json_path,"w")
   CALL l_channel.write(p_content)
   CALL l_channel.close()
   #parm1: 模版文件下载路径
   #parm2: 数据文件下载路径
   LET parm1 = FGL_GETENV("FGLASIP"),"/components/tag/templates/",g_rtdy001,".svg"
   LET parm2 = FGL_GETENV("FGLASIP"),"/out/",l_str
   LET parm3 = FGL_GETENV("FGLASIP"),"/components/tag/config.csv"
   LET path =  "C:\\\\T100\\tag\\TPrinter.exe ",parm1," ",parm2," ",parm3
   CALL ui.interface.frontCall("standard", "execute", [path,0],[l_result]);
END FUNCTION

################################################################################
# Descriptions...: 修改
# Memo...........:
# Usage..........: CALL agcq301_modify()
#                  RETURNING 回传参数
# Date & Author..: 20150704 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION agcq301_modify()
DEFINE  l_cmd                  LIKE type_t.chr1
DEFINE  l_ac_t                 LIKE type_t.num5                #未取消的ARRAY CNT 
DEFINE  l_n                    LIKE type_t.num5                #檢查重複用  
DEFINE  l_cnt                  LIKE type_t.num5                #檢查重複用  
DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
DEFINE  l_count                LIKE type_t.num5
DEFINE  ls_return              STRING
DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
DEFINE  l_fields               DYNAMIC ARRAY OF STRING
DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
DEFINE  li_reproduce           LIKE type_t.num5
DEFINE  li_reproduce_target    LIKE type_t.num5
DEFINE  lb_reproduce           BOOLEAN
DEFINE  l_sql                  STRING
DEFINE  r_success              LIKE type_t.num5
DEFINE  r_errno                LIKE type_t.chr50
DEFINE  l_stdb002              LIKE stdb_t.stdb002
DEFINE  l_stdb007              LIKE stdb_t.stdb007
DEFINE  l_stdbstus             LIKE stdb_t.stdbstus
DEFINE  l_insert               BOOLEAN
DEFINE  l_site                 LIKE rtdx_t.rtdxsite
DEFINE  l_i                    LIKE type_t.num10
DEFINE  l_gcao002              LIKE gcao_t.gcao002
   #end add-point
   #add-point:modify段define-客製

   #end add-point
 
   #add-point:modify段control
   LET g_action_choice = ""

   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_gcao_d FROM s_detail1.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
                  
         BEFORE INPUT
            #单身没资料关闭单身
#            IF g_rtdx_d.getLength() = 0  THEN
#               EXIT DIALOG
#            END IF 
            
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcao_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
 
            #CALL artq520_b_fill()
            LET g_detail_cnt = g_gcao_d.getLength()
         
            
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.h_index
            DISPLAY g_gcao_d.getLength() TO FORMONLY.h_count
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gcao_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gcao_d[l_ac].sel IS NOT NULL
               AND g_gcao_d[l_ac].seq IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_gcao_d_t.* = g_gcao_d[l_ac].*
            ELSE
               LET l_cmd='a'
            END IF   
            IF l_cmd = 'a' THEN               
             #  CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
         BEFORE INSERT
            
            LET l_cmd = 'a'
            INITIALIZE g_gcao_d[l_ac].* TO NULL
            INITIALIZE g_gcao_d_t.* TO NULL            
            #公用欄位給值(單身2)
            LET g_gcao_d[l_ac].sel = 'Y'
            LET g_gcao_d[l_ac].seq = l_ac
            LET g_gcao_d[l_ac].count = g_number
            
            LET g_gcao_d_t.* = g_gcao_d[l_ac].*
            #add-point:modify段before備份

            #end add-point
            CALL cl_show_fld_cont()
         
         
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
         
         ON ACTION controlp INFIELD b_gcao001
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值

            #給予arg
            IF NOT cl_null(g_gcao_d[l_ac].gcao002)   THEN
               LET g_qryparam.where = " gcao002 = '",g_gcao_d[l_ac].gcao002,"'"
            END IF
            CALL q_gcao001_9()                                #呼叫開窗

            LET g_gcao_d[l_ac].gcao001 = g_qryparam.return1              

            DISPLAY g_gcao_d[l_ac].gcao001 TO b_gcao001             #顯示到畫面上

            NEXT FIELD b_gcao001
         
         AFTER FIELD b_gcao001
            IF NOT cl_null(g_gcao_d[l_ac].gcao001)   THEN
               #券号是否存在
               LET l_cnt = 0
               SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcao001 = g_gcao_d[l_ac].gcao001
                AND gcaoent = g_enterprise
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00114'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err() 
                  LET g_gcao_d[l_ac].gcao001 = g_gcao_d_t.gcao001                 
                  NEXT FIELD CURRENT
               END IF 
               #券号是否存在与券种之下               
               IF NOT cl_null(g_gcao_d[l_ac].gcao002) THEN
                  INITIALIZE l_gcao002 TO NULL
                  SELECT gcao002 INTO l_gcao002 FROM gcao_t WHERE gcao001 = g_gcao_d[l_ac].gcao001
                   AND gcaoent = g_enterprise                          
                  IF l_gcao002 != g_gcao_d[l_ac].gcao002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'agc-00115'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_gcao_d[l_ac].gcao001 = g_gcao_d_t.gcao001  
                     NEXT FIELD CURRENT                 
                  END IF
               END IF
               CALL agcq301_gcao001_init()
            END IF

         ON ACTION controlp INFIELD b_gcao002
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值b_gcao002
            #給予arg
            CALL q_gcaf001()                                #呼叫開窗

            LET g_gcao_d[l_ac].gcao002 = g_qryparam.return1              

            DISPLAY g_gcao_d[l_ac].gcao002 TO b_gcao002             #顯示到畫面上

            NEXT FIELD b_gcao002
         
         AFTER FIELD b_gcao002
            IF NOT cl_null( g_gcao_d[l_ac].gcao002) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM gcaf_t 
                WHERE gcafent = g_enterprise
                  AND gcaf001 = g_gcao_d[l_ac].gcao002          
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00001'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_gcao_d[l_ac].gcao002 = g_gcao_d_t.gcao002  
                  NEXT FIELD CURRENT
               
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM gcaf_t 
                WHERE gcafent = g_enterprise
                  AND gcaf001 = g_gcao_d[l_ac].gcao002
                  AND gcafstus = 'Y'                   
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'amm-00194'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_gcao_d[l_ac].gcao002 = g_gcao_d_t.gcao002
                  NEXT FIELD CURRENT
               
               END IF      
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gcao_d[l_ac].gcao002
            CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gcao_d[l_ac].gcafl003 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gcao_d[l_ac].gcafl003
            
         ON ACTION controlp INFIELD b_oocq009
            #add-point:ON ACTION controlp INFIELD deag002
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2071'		   
            CALL q_oocq002()                           #呼叫開窗
            LET g_gcao_d[l_ac].oocq009 = g_qryparam.return1 
            DISPLAY g_gcao_d[l_ac].oocq009 TO b_oocq009  #顯示到畫面上
             
            NEXT FIELD gcao003   
            
         AFTER FIELD b_oocq009
            IF NOT cl_null(g_gcao_d[l_ac].oocq009) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM oocq_t 
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2071'
                  AND oocq002 = g_gcao_d[l_ac].oocq009                  
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00011'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_gcao_d[l_ac].oocq009 = g_gcao_d_t.oocq009
                  NEXT FIELD CURRENT
               
               END IF
                LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM oocq_t 
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2071'
                  AND oocq002 = g_gcao_d[l_ac].oocq009    
                  AND oocqstus = 'Y'                   
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agc-00012'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_gcao_d[l_ac].oocq009 = g_gcao_d_t.oocq009
                  NEXT FIELD CURRENT
               
               END IF
            END IF
            
            
         AFTER ROW
#            CALL astq730_unlock_b("stde_t")
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
#               IF l_cmd = 'u' THEN
#                  LET g_rtdx_d[l_ac].* = g_rtdx_d_t.*
#               END IF       
               EXIT DIALOG 
            END IF
            #其他table進行unlock
            
             #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_gcao_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gcao_d.getLength()+1
            
      END INPUT
      
      #add-point:before_more_input
      INPUT g_rtdy001,g_number FROM rtdy001,number  
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT

         DISPLAY g_rtdy001,g_number TO rtdy001,number
          
          

         ON ACTION controlp INFIELD rtdy001
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值

            #給予arg
            LET g_qryparam.where = " rtdystus = 'Y' "
            CALL q_rtdy001()                                #呼叫開窗

            LET g_rtdy001 = g_qryparam.return1              

            DISPLAY g_rtdy001 TO rtdy001             #顯示到畫面上

            NEXT FIELD rtdy001
         
         AFTER FIELD rtdy001
            IF NOT cl_null(g_rtdy001) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtdy_t 
                WHERE rtdyent = g_enterprise
                  AND rtdy001 = g_rtdy001             
                  AND rtdystus = 'Y'
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'art-00631'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
            END IF
            
         AFTER FIELD number
            IF g_number IS NOT NULL THEN
               FOR l_i = 1 TO g_gcao_d.getLength() STEP 1
                  LET g_gcao_d[l_i].count = g_number
                  DISPLAY g_gcao_d[l_i].count TO count                   
               END FOR         
            END IF   
            
            
         AFTER INPUT
      END INPUT
      #add-point:單身input後
      
      #end add-point 
      #end add-point
      
      BEFORE DIALOG 

         LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog

         #end add-point

   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         IF l_cmd = 'a'  THEN
            CALL g_gcao_d.deleteElement(l_ac) 
         END IF
         IF l_cmd = 'u' THEN
            LET g_gcao_d[l_ac].* = g_gcao_d_t.*
         END IF
         EXIT DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
   
   #add-point:modify段修改後
END FUNCTION

################################################################################
# Descriptions...: 券编号带值
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150706 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION agcq301_gcao001_init()
DEFINE  l_gcao003             LIKE gcao_t.gcao003
DEFINE ls_sql     STRING
   SELECT gcao002,gcao008,gcao009,gcao003 INTO g_gcao_d[l_ac].gcao002,g_gcao_d[l_ac].gcao008,g_gcao_d[l_ac].gcao009,l_gcao003
     FROM gcao_t  
    WHERE gcaoent=g_enterprise
      AND gcao001=g_gcao_d[l_ac].gcao001
   
   SELECT oocq009 INTO g_gcao_d[l_ac].oocq009 
     FROM oocq_t
    WHERE oocqent=g_enterprise
      AND oocq001 = '2071'
      AND oocq002 = l_gcao003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcao_d[l_ac].gcao002
   LET ls_sql = "SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET g_gcao_d[l_ac].gcafl003 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcao_d[l_ac].gcafl003   
END FUNCTION

 
{</section>}
 
