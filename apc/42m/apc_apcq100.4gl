#該程式未解開Section, 採用最新樣板產出!
{<section id="apcq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2015-11-19 10:03:48), PR版次:0006(2016-11-09 11:17:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: apcq100
#+ Description: 前臺後臺統計分析作業
#+ Creator....: 03247(2015-07-22 17:13:39)
#+ Modifier...: 03247 -SD/PR- 08742
 
{</section>}
 
{<section id="apcq100.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#7   2016/10/24  by 08742       组织开窗调整
#161108-00016#1   2016/11/09  by 08742       修改 g_browser_cnt 定义大小
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
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       pcarsite LIKE pcar_t.pcarsite
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   pcas002 LIKE pcas_t.pcas002, 
   pcas003 LIKE pcas_t.pcas003, 
   pcas004 LIKE pcas_t.pcas004, 
   pcas0031 LIKE type_t.num10, 
   pcas0041 LIKE type_t.num20_6, 
   pcasstus LIKE pcas_t.pcasstus
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       pcas001 LIKE pcas_t.pcas001, 
   pcas002 LIKE pcas_t.pcas002, 
   pcas003 LIKE pcas_t.pcas003, 
   pcas004 LIKE pcas_t.pcas004
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       pcat002 LIKE pcat_t.pcat002, 
   pcat003 LIKE pcat_t.pcat003, 
   pcat003_desc LIKE type_t.chr500, 
   pcat005 LIKE pcat_t.pcat005, 
   pcat0051 LIKE type_t.num20_6, 
   pcat0052 LIKE type_t.num20_6, 
   pcat0053 LIKE type_t.num20_6, 
   pcatstus LIKE pcat_t.pcatstus
       END RECORD
 
PRIVATE TYPE type_g_detail4 RECORD
       pcat001 LIKE pcat_t.pcat001, 
   pcat002 LIKE pcat_t.pcat002, 
   pcat004 LIKE pcat_t.pcat004, 
   pcat004_desc LIKE type_t.chr500, 
   pcat005 LIKE pcat_t.pcat005
       END RECORD
 
PRIVATE TYPE type_g_detail5 RECORD
       rtjadocdt LIKE rtja_t.rtjadocdt, 
   pcat001 LIKE pcat_t.pcat001, 
   pcat002 LIKE pcat_t.pcat002, 
   pcat003 LIKE pcat_t.pcat003, 
   pcat003_1_desc LIKE type_t.chr500, 
   pcat005 LIKE pcat_t.pcat005, 
   rtja033 LIKE rtja_t.rtja033, 
   rtja034 LIKE rtja_t.rtja034, 
   rtja035 LIKE rtja_t.rtja035, 
   rtjapstdt LIKE rtja_t.rtjapstdt, 
   rtjf036 LIKE rtjf_t.rtjf036
       END RECORD
 
PRIVATE TYPE type_g_detail6 RECORD
       pcaw002 LIKE type_t.chr500, 
   pcaw005 LIKE pcaw_t.pcaw005, 
   pcaw005_desc LIKE type_t.chr500, 
   pcaw008 LIKE type_t.chr500, 
   pcaw012 LIKE type_t.chr500, 
   pcaw0081 LIKE type_t.num20_6, 
   pcaw0121 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_browser      DYNAMIC ARRAY OF RECORD
                      pcarsite LIKE pcar_t.pcarsite,
                      pcar001  LIKE pcar_t.pcar001
                      END RECORD
#DEFINE g_browser_cnt  LIKE type_t.num5             #Browser 總筆數  #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_browser_cnt  LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add
DEFINE g_pcar001      LIKE pcar_t.pcar001
DEFINE g_flag         LIKE type_t.chr1     #狀態是否異常
DEFINE g_pcarsite     LIKE pcar_t.pcarsite
DEFINE g_pcarstus     LIKE pcar_t.pcarstus
DEFINE g_amt_f        LIKE type_t.num10
DEFINE g_amt_b        LIKE type_t.num10
DEFINE g_sum_f        LIKE type_t.num20_6
DEFINE g_sum_b        LIKE type_t.num20_6
DEFINE g_wc1          STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
DEFINE g_detail3     DYNAMIC ARRAY OF type_g_detail3
DEFINE g_detail3_t   type_g_detail3
 
DEFINE g_detail4     DYNAMIC ARRAY OF type_g_detail4
DEFINE g_detail4_t   type_g_detail4
 
DEFINE g_detail5     DYNAMIC ARRAY OF type_g_detail5
DEFINE g_detail5_t   type_g_detail5
 
DEFINE g_detail6     DYNAMIC ARRAY OF type_g_detail6
DEFINE g_detail6_t   type_g_detail6
 
 
 
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
 
{<section id="apcq100.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success       LIKE type_t.num5    #161024-00025#7   2016/10/24 by 08742   add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apc","")
 
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
   DECLARE apcq100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apcq100_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apcq100_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apcq100 WITH FORM cl_ap_formpath("apc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apcq100_init()   
 
      #進入選單 Menu (="N")
      CALL apcq100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apcq100
      
   END IF 
   
   CLOSE apcq100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success    #161024-00025#7   2016/10/24 by 08742   add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apcq100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apcq100_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success       LIKE type_t.num5    #161024-00025#7   2016/10/24 by 08742   add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('pcarstus','6849')
   CALL cl_set_combo_scc('b_pcas002','6850')
   CALL cl_set_combo_scc('b_pcasstus','6849')
   CALL cl_set_combo_scc('b_pcas002_2','6850')
   CALL cl_set_combo_scc('b_pcatstus','6849')
   CALL s_aooi500_create_temp() RETURNING l_success          #161024-00025#7   2016/10/24 by 08742   add
   #end add-point
 
   CALL apcq100_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apcq100.default_search" >}
PRIVATE FUNCTION apcq100_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
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
 
{<section id="apcq100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apcq100_ui_dialog() 
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
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL apcq100_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
         CALL g_detail3.clear()
 
         CALL g_detail4.clear()
 
         CALL g_detail5.clear()
 
         CALL g_detail6.clear()
 
 
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
 
         CALL apcq100_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         #INPUT g_pcar001 FROM pcar001
         #   ATTRIBUTE(WITHOUT DEFAULTS)
         #   
         #   #自訂ACTION(master_input)
         #   
         #
         #   BEFORE INPUT
         #      #add-point:資料輸入前
         #
         #      #end add-point
         #      
         #END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pcarsite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct
               
               #end add-point 
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.debasite
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD pcarsite
               #add-point:ON ACTION controlp INFIELD debasite
               #應用 a08 樣板自動產生(Version:1)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pcarsite',g_site,'c')
               CALL q_ooef001_24()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pcarsite  #顯示到畫面上 
               NEXT FIELD pcarsite                     #返回原欄位
            
               #END add-point
            
            #應用 a01 樣板自動產生(Version:1)
            BEFORE FIELD pcarsite
               #add-point:BEFORE FIELD debasite
            
               #END add-point
            
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pcarsite
               
               #add-point:AFTER FIELD debasite
            
               #END add-point
            
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc1 ON pcar001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct
               
               #end add-point 
               
            #應用 a01 樣板自動產生(Version:1)
            BEFORE FIELD pcar001
               #add-point:BEFORE FIELD debasite
            
               #END add-point
            
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD pcar001
               
               #add-point:AFTER FIELD debasite
            
               #END add-point
            
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apcq100_detail_action_trans()
               LET g_master_idx = l_ac
               CALL apcq100_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail3 TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail4 TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail5 TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body5.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_5)
            
 
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail6 TO s_detail6.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 6
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body6.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_6)
            
 
            #add-point:page6自定義行為 name="ui_dialog.body6.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL apcq100_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #LET g_pcar001 = cl_get_para(g_enterprise,g_site,'S-CIR-0003')
            #LET g_pcar001 = g_pcar001 - 1
            DISPLAY g_site TO pcarsite
            LET g_pcar001 = cl_get_para(g_enterprise,g_site,'S-CIR-0003')
            LET g_pcar001 = g_pcar001 - 1
            DISPLAY g_pcar001 TO pcar001
            #end add-point
            NEXT FIELD pcarsite
 
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
            
            #end add-point
 
            CALL apcq100_cs()
 
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
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_detail3)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_detail4)
               LET g_export_id[4]   = "s_detail4"
 
               LET g_export_node[5] = base.typeInfo.create(g_detail5)
               LET g_export_id[5]   = "s_detail5"
 
               LET g_export_node[6] = base.typeInfo.create(g_detail6)
               LET g_export_id[6]   = "s_detail6"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL apcq100_fetch('F')
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
            CALL apcq100_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL apcq100_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL apcq100_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL apcq100_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL apcq100_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL apcq100_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL apcq100_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL apcq100_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL apcq100_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL apcq100_b_fill()
 
         
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
               #重新查询
               LET g_amt_f = NULL
               LET g_sum_f = NULL
               LET g_amt_b = NULL
               LET g_sum_b = NULL
               LET g_pcarstus = NULL
               DISPLAY g_amt_f,g_sum_f,g_amt_b,g_sum_b,g_pcarstus TO amt_f,sum_f,amt_b,sum_b,pcarstus
               CALL g_detail.clear()
               CALL g_detail2.clear()
               CALL g_detail3.clear()
               CALL g_detail4.clear()
               CALL g_detail5.clear()
               CALL g_detail6.clear()   #20151208 dongsz add
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
 
{<section id="apcq100.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION apcq100_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_sql      STRING
   DEFINE l_where         STRING      #161024-00025#7   2016/10/24 by 08742 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   
   LET l_where = s_aooi500_sql_where(g_prog,'pcarsite')           #161024-00025#7   2016/10/24 by 08742   add
   LET l_where = cl_replace_str(l_where,"pcarsite","ooef001")     #161024-00025#7   2016/10/24 by 08742   add   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      IF cl_null(g_wc1) THEN
         LET g_wc1 = " 1=1"
      END IF
      LET g_wc = cl_replace_str(g_wc,"pcarsite","ooef001")
      LET g_wc1 = cl_replace_str(g_wc1,"pcar001","ooga001")
      LET g_sql = " SELECT UNIQUE ooef001 FROM ooef_t ",
                  "  WHERE ooefent = ",g_enterprise," ",
                  "    AND ",g_wc,
                  "    AND ",l_where,     #161024-00025#7   2016/10/24 by 08742  add
                  "  ORDER BY ooef001 "
                  
      LET l_sql = " SELECT DISTINCT ooga001 FROM ooga_t ",
                  "  WHERE oogaent = ",g_enterprise," ",
                  "    AND ",g_wc1,
                  "    AND ooga001 < '",g_today,"' "
      PREPARE sel_ooga_pre FROM l_sql
      DECLARE sel_ooga_cs  SCROLL CURSOR WITH HOLD FOR sel_ooga_pre
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE apcq100_pre FROM g_sql
   DECLARE apcq100_curs SCROLL CURSOR WITH HOLD FOR apcq100_pre
   OPEN apcq100_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_flag = 'N'
   LET g_cnt_sql = " SELECT COUNT(*) FROM (",g_sql,")"
   #end add-point
   PREPARE apcq100_precount FROM g_cnt_sql
   EXECUTE apcq100_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL apcq100_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="apcq100.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION apcq100_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_sql      STRING
   DEFINE l_pcarsite LIKE pcar_t.pcarsite
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   IF NOT cl_null(p_flag) THEN
      LET g_browser_cnt = 1
      FOREACH apcq100_curs INTO g_browser[g_browser_cnt].pcarsite 
         LET l_pcarsite = g_browser[g_browser_cnt].pcarsite
         FOREACH sel_ooga_cs  INTO g_browser[g_browser_cnt].pcar001
            LET g_browser[g_browser_cnt].pcarsite = l_pcarsite
            LET g_browser_cnt = g_browser_cnt + 1
         END FOREACH
      END FOREACH
      CALL g_browser.deleteElement(g_browser.getLength())
      
      #总笔数
      LET g_browser_cnt = g_browser_cnt - 1
      LET g_row_count = g_browser_cnt
   END IF
   #g_browser[g_current_idx].b_prbfdocno
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_pcarsite
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
      CALL g_detail4.clear()
 
      CALL g_detail5.clear()
 
      CALL g_detail6.clear()
 
 
      #add-point:陣列清空 name="fetch.array_clear"
      
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
   LET g_pcarsite = g_browser[g_current_idx].pcarsite
   LET g_pcar001 = g_browser[g_current_idx].pcar001
   LET g_amt_f = 0
   LET g_sum_f = 0
   LET g_amt_b = 0
   LET g_sum_b = 0
   LET l_sql = " SELECT pcar002,pcar003 FROM pcar_t ",
               "  WHERE pcarent = ",g_enterprise," ",
               "    AND pcarsite = '",g_pcarsite,"' ",
               "    AND pcar001 = '",g_pcar001,"' "
   PREPARE sel_pcar_pre FROM l_sql
   #EXECUTE sel_pcar_pre INTO g_master.pcarsite,g_master.amt_f,g_master.sum_f
   EXECUTE sel_pcar_pre INTO g_amt_f,g_sum_f
   LET g_master.pcarsite = g_pcarsite
   
   LET l_sql = " SELECT COUNT(DISTINCT rtjadocno),SUM(rtja049) FROM rtja_t ",
               "  WHERE rtjaent = ",g_enterprise," ",
               "    AND rtjasite = '",g_pcarsite,"' ",
               "    AND rtjadocdt = '",g_pcar001,"' ",
               "    AND rtja032 = '2' "
               #"    AND to_char(rtjadocdt,'YYYYMMDD') = to_char(rtjacrtdt,'YYYYMMDD') "
   PREPARE sel_rtja_pre FROM l_sql
   EXECUTE sel_rtja_pre INTO g_amt_b,g_sum_b
   
   IF cl_null(p_flag) THEN
      LET g_pcarstus = NULL
      LET g_amt_f = NULL
      LET g_amt_b = NULL
   ELSE
      IF g_amt_f = g_amt_b AND g_sum_f = g_sum_b THEN
         LET g_flag = 'N'
      ELSE
         LET g_flag = 'Y'
      END IF
   END IF
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL apcq100_show()
 
END FUNCTION
 
{</section>}
 
{<section id="apcq100.show" >}
PRIVATE FUNCTION apcq100_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_pcarsite
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   DISPLAY g_pcarsite,g_pcar001,g_amt_f,g_sum_f,g_amt_b,g_sum_b TO pcarsite,pcar001,amt_f,sum_f,amt_b,sum_b
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL apcq100_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="apcq100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apcq100_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_sql1          STRING

   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   CALL g_detail4.clear()
   CALL g_detail5.clear()
   CALL g_detail6.clear()  #20151111--dongsz add
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   #正常上传统计
   LET l_sql = " SELECT '',(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) a, ",
               "        0,0,COALESCE(COUNT(DISTINCT rtjadocno),0),COALESCE(SUM(rtja049),0) ",
               "   FROM rtja_t ",
               "  WHERE rtjaent = ",g_enterprise," ",
               "    AND rtjasite = '",g_master.pcarsite,"' ",
               "    AND rtjadocdt = '",g_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY '',(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) ",
               " UNION ",
               " SELECT '',(CASE pcas002 WHEN '0' THEN '1' WHEN '2' THEN '1' WHEN '5' THEN '1' WHEN '6' THEN '2' WHEN '7' THEN '2' END), ",
               "        COALESCE(SUM(pcas003),0),COALESCE(SUM(pcas004),0),0,0 ",
               "   FROM pcas_t ",
               "  WHERE pcasent = ",g_enterprise," ",
               "    AND pcassite = '",g_master.pcarsite,"' ",
               "    AND pcas001 = '",g_pcar001,"' ",
               "    AND (CASE pcas002 WHEN '0' THEN '1' WHEN '2' THEN '1' WHEN '5' THEN '1' WHEN '6' THEN '2' WHEN '7' THEN '2' END) NOT IN ( ",
               "         SELECT (CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) FROM rtja_t ",
               "          WHERE rtjaent = ",g_enterprise," AND rtjasite = '",g_master.pcarsite,"' AND rtjadocdt = '",g_pcar001,"' ",
               "            AND rtja032 = '2' AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD')) ",
               "  GROUP BY '',(CASE pcas002 WHEN '0' THEN '1' WHEN '2' THEN '1' WHEN '5' THEN '1' WHEN '6' THEN '2' WHEN '7' THEN '2' END) ",
               "  ORDER BY a "
   PREPARE sel_pcas_pre FROM l_sql
   DECLARE sel_pcas_cs  CURSOR FOR sel_pcas_pre
   FOREACH sel_pcas_cs  INTO g_detail[l_ac].sel,g_detail[l_ac].pcas002,g_detail[l_ac].pcas003,g_detail[l_ac].pcas004,
                             g_detail[l_ac].pcas0031,g_detail[l_ac].pcas0041
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF g_detail[l_ac].pcas003 = 0 AND g_detail[l_ac].pcas004 = 0 THEN
         #销售
         IF g_detail[l_ac].pcas002 = '1' THEN
            LET l_sql1 = " SELECT COALESCE(SUM(pcas003),0),COALESCE(SUM(pcas004),0) FROM pcas_t ",
                         "  WHERE pcasent = ",g_enterprise," AND pcassite = '",g_master.pcarsite,"' ",
                         "    AND pcas001 = '",g_pcar001,"' AND pcas002 IN ('0','2','5') "
            PREPARE sel_rtja_pre1 FROM l_sql1
            EXECUTE sel_rtja_pre1 INTO g_detail[l_ac].pcas003,g_detail[l_ac].pcas004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
         #充值
         IF g_detail[l_ac].pcas002 = '2' THEN
            LET l_sql1 = " SELECT COALESCE(SUM(pcas003),0),COALESCE(SUM(pcas004),0) FROM pcas_t ",
                         "  WHERE pcasent = ",g_enterprise," AND pcassite = '",g_master.pcarsite,"' ",
                         "    AND pcas001 = '",g_pcar001,"' AND pcas002 IN ('6','7') "
            PREPARE sel_rtja_pre2 FROM l_sql1
            EXECUTE sel_rtja_pre2 INTO g_detail[l_ac].pcas003,g_detail[l_ac].pcas004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
      END IF
      
      #IF g_detail[l_ac].pcas002 = '1' THEN
      #   LET l_sql1 = " SELECT COALESCE(COUNT(DISTINCT rtjadocno),0),COALESCE(SUM(rtja049),0) FROM rtja_t ",
      #                "  WHERE rtjaent = ",g_enterprise," ",
      #                "    AND rtjasite = '",g_master.pcarsite,"' ",
      #                "    AND rtjadocdt = '",g_pcar001,"' ",
      #                "    AND rtja032 = '2' ",
      #                "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
      #                "    AND rtja000 IN ('artt610','artt700') "
      #   PREPARE sel_rtja_pre1 FROM l_sql1
      #   EXECUTE sel_rtja_pre1 INTO g_detail[l_ac].pcas0031,g_detail[l_ac].pcas0041
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL 
      #      LET g_errparam.extend = "FOREACH:" 
      #      LET g_errparam.code   = SQLCA.sqlcode 
      #      LET g_errparam.popup  = TRUE 
      #      CALL cl_err()
      #      EXIT FOREACH
      #   END IF
      #END IF
      #IF g_detail[l_ac].pcas002 = '2' THEN
      #   LET l_sql1 = " SELECT COALESCE(COUNT(DISTINCT rtjadocno),0),COALESCE(SUM(rtja049),0) FROM rtja_t ",
      #                "  WHERE rtjaent = ",g_enterprise," ",
      #                "    AND rtjasite = '",g_master.pcarsite,"' ",
      #                "    AND rtjadocdt = '",g_pcar001,"' ",
      #                "    AND rtja032 = '2' ",
      #                "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
      #                "    AND rtja000 = 'ammt425' "
      #   PREPARE sel_rtja_pre2 FROM l_sql1
      #   EXECUTE sel_rtja_pre2 INTO g_detail[l_ac].pcas0031,g_detail[l_ac].pcas0041
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL 
      #      LET g_errparam.extend = "FOREACH:" 
      #      LET g_errparam.code   = SQLCA.sqlcode 
      #      LET g_errparam.popup  = TRUE 
      #      CALL cl_err()
      #      EXIT FOREACH
      #   END IF
      #END IF
      
      #狀態
      IF g_detail[l_ac].pcas003 <> g_detail[l_ac].pcas0031 OR g_detail[l_ac].pcas004 <> g_detail[l_ac].pcas0041 THEN
         LET g_detail[l_ac].pcasstus = '1'
         LET g_flag = 'Y'
      ELSE
         LET g_detail[l_ac].pcasstus = '0'
      END IF
      
      CALL apcq100_detail_show("'1'")
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   #20151111--dongsz add--str
   IF g_flag = 'Y' THEN
      #异常机号明细页签
                  #后台销售金额
      LET l_sql = " SELECT rtja036,rtja037,pcab003,0,0,COALESCE(COUNT(DISTINCT rtjadocno),0),0 ",
                  "   FROM rtja_t LEFT JOIN pcab_t ON pcabent = rtjaent AND pcab001 = rtja037 ",
                  "  WHERE rtjaent = ",g_enterprise," ",
                  "    AND rtjasite = '",g_master.pcarsite,"' ",
                  "    AND rtjadocdt = '",g_pcar001,"' ",
                  "    AND rtja032 = '2' ",
                  "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "    AND rtja000 IN ('artt610','artt700') ",
                  "  GROUP BY rtja036,rtja037,pcab003 ",
                  " UNION ",
                  #后台充值金额
                  " SELECT rtja036,rtja037,pcab003,0,0,0,COALESCE(COUNT(DISTINCT rtjadocno),0) ",
                  "   FROM rtja_t LEFT JOIN pcab_t ON pcabent = rtjaent AND pcab001 = rtja037 ",
                  "  WHERE rtjaent = ",g_enterprise," ",
                  "    AND rtjasite = '",g_master.pcarsite,"' ",
                  "    AND rtjadocdt = '",g_pcar001,"' ",
                  "    AND rtja032 = '2' ",
                  "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "    AND rtja000 IN ('ammt425') ",
                  "    AND rtja036||rtja037 NOT IN (SELECT rtja036||rtja037 FROM rtja_t WHERE rtjaent = ",g_enterprise," ",
                  "                                    AND rtjasite = '",g_master.pcarsite,"' AND rtjadocdt = '",g_pcar001,"' ",
                  "                                    AND rtja032 = '2' AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "                                    AND rtja000 IN ('artt610','artt700')) ",
                  "  GROUP BY rtja036,rtja037,pcab003 ",
                  " UNION ",
                  #前台销售金额
                  " SELECT pcaw002,pcaw005,pcab003,pcaw008,pcaw012,0,0 ",
                  "   FROM (SELECT pcaw002,pcaw005,pcab003,pcaw008,pcaw012,row_number() over (partition by pcaw002,pcaw005 order by pcaw003 desc) num ",
                  "           FROM pcaw_t LEFT JOIN pcab_t ON pcabent = pcawent AND pcab001 = pcaw005 ",
                  "          WHERE pcawent = ",g_enterprise," AND pcawsite = '",g_master.pcarsite,"' ",
                  "            AND pcaw001 = '",g_pcar001,"' AND pcaw004 = '0') ",
                  "  WHERE num = 1 ",
                  "    AND pcaw002||pcaw005 NOT IN (SELECT rtja036||rtja037 FROM rtja_t WHERE rtjaent = ",g_enterprise," ",
                  "                                    AND rtjasite = '",g_master.pcarsite,"' AND rtjadocdt = '",g_pcar001,"' ",
                  "                                    AND rtja032 = '2' AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                  "                                    AND rtja000 IN ('artt610','artt700','ammt425')) ",
                  "  ORDER BY rtja036 "
      PREPARE sel_pcaw_pre FROM l_sql
      DECLARE sel_pcaw_cs  CURSOR FOR sel_pcaw_pre
      LET l_ac = 1
      FOREACH sel_pcaw_cs  INTO g_detail6[l_ac].pcaw002,g_detail6[l_ac].pcaw005,g_detail6[l_ac].pcaw005_desc,g_detail6[l_ac].pcaw008, 
                                g_detail6[l_ac].pcaw012,g_detail6[l_ac].pcaw0081,g_detail6[l_ac].pcaw0121
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #后台充值数量
         IF g_detail6[l_ac].pcaw0121 = 0 THEN
            LET l_sql1 = " SELECT COALESCE(COUNT(DISTINCT rtjadocno),0) FROM rtja_t ",
                         "  WHERE rtjaent = ",g_enterprise," ",
                         "    AND rtjasite = '",g_master.pcarsite,"' ",
                         "    AND rtjadocdt = '",g_pcar001,"' ",
                         "    AND rtja032 = '2' ",
                         "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
                         "    AND rtja000 IN ('ammt425') ",
                         "    AND rtja036 = '",g_detail6[l_ac].pcaw002,"' ",
                         "    AND rtja037 = '",g_detail6[l_ac].pcaw005,"' "
            PREPARE sel_rtja_pre4 FROM l_sql1
            EXECUTE sel_rtja_pre4 INTO g_detail6[l_ac].pcaw0121
            IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
       
         #前台数量
         IF g_detail6[l_ac].pcaw008 = 0 AND g_detail6[l_ac].pcaw012 = 0 THEN
            LET l_sql1 = " SELECT pcaw008,pcaw012 FROM pcaw_t ",
                         "  WHERE pcawent = ",g_enterprise," AND pcawsite = '",g_master.pcarsite,"' ",
                         "    AND pcaw001 = '",g_pcar001,"' AND pcaw004 = '0' ",
                         "    AND pcaw002 = '",g_detail6[l_ac].pcaw002,"' ",
                         "    AND pcaw005 = '",g_detail6[l_ac].pcaw005,"' ",
                         "    AND pcaw003 = (SELECT MAX(pcaw003) FROM pcaw_t WHERE pcawent = ",g_enterprise," ",
                         "                      AND pcawsite = '",g_master.pcarsite,"' ",
                         "                      AND pcaw001 = '",g_pcar001,"' AND pcaw004 = '0' ",
                         "                      AND pcaw002 = '",g_detail6[l_ac].pcaw002,"' ",
                         "                      AND pcaw005 = '",g_detail6[l_ac].pcaw005,"') "
            PREPARE sel_rtja_pre5 FROM l_sql1
            EXECUTE sel_rtja_pre5 INTO g_detail6[l_ac].pcaw008,g_detail6[l_ac].pcaw012
            IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
         
         LET g_detail6[l_ac].pcaw008 = g_detail6[l_ac].pcaw008 USING '#########&'
         LET g_detail6[l_ac].pcaw0081 = g_detail6[l_ac].pcaw0081 USING '#########&'
         LET g_detail6[l_ac].pcaw012 = g_detail6[l_ac].pcaw012 USING '#########&'
         LET g_detail6[l_ac].pcaw0121 = g_detail6[l_ac].pcaw0121 USING '#########&'
         
         IF g_detail6[l_ac].pcaw008 = g_detail6[l_ac].pcaw0081 AND g_detail6[l_ac].pcaw012 = g_detail6[l_ac].pcaw0121 THEN
            LET g_detail6[l_ac].pcaw002 = NULL
            LET g_detail6[l_ac].pcaw005 = NULL
            LET g_detail6[l_ac].pcaw005_desc = NULL
            LET g_detail6[l_ac].pcaw008 = NULL
            LET g_detail6[l_ac].pcaw012 = NULL
            LET g_detail6[l_ac].pcaw0081 = NULL
            LET g_detail6[l_ac].pcaw0121 = NULL
            CONTINUE FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
   END IF
   #20151111--dongsz add--end
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #延误上传统计
   LET l_sql = " SELECT rtjacrtdt,(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) a, ",
               "        COALESCE(COUNT(DISTINCT rtjadocno),0),COALESCE(SUM(rtja049),0) FROM rtja_t ",
               "  WHERE rtjaent = ",g_enterprise," ",
               "    AND rtjasite = '",g_master.pcarsite,"' ",
               "    AND rtjadocdt = '",g_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')>to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY rtjacrtdt,(CASE rtja000 WHEN 'artt610' THEN '1' WHEN 'artt700' THEN '1' WHEN 'ammt425' THEN '2' END) ",
               "  ORDER BY rtjacrtdt,a "
   PREPARE sel_rtja_pre3 FROM l_sql
   DECLARE sel_rtja_cs3  CURSOR FOR sel_rtja_pre3
   LET l_ac = 1
   FOREACH sel_rtja_cs3  INTO g_detail2[l_ac].pcas001,g_detail2[l_ac].pcas002,g_detail2[l_ac].pcas003,g_detail2[l_ac].pcas004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CALL apcq100_detail_show("'2'")
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   #正常上传款别统计
   LET l_sql = " SELECT rtjf030,rtjf002,0,COALESCE(SUM(rtjf031),0),0,0 FROM rtjf_t,rtja_t ",
               "  WHERE rtjfent = ",g_enterprise," ",
               "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
               "    AND rtjfsite = '",g_master.pcarsite,"' ",
               "    AND rtjadocdt = '",g_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY rtjf030,rtjf002 ",
               #"    AND rtjf030 = '",g_detail3[l_ac].pcat002,"' ",
               #"    AND rtjf002 = '",g_detail3[l_ac].pcat003,"' "
               " UNION ",
               " SELECT pcat002,pcat004,COALESCE(SUM(pcat005),0),0,0,0 FROM pcat_t ",
               "  WHERE pcatent = ",g_enterprise," ",
               "    AND pcatsite = '",g_master.pcarsite,"' ",
               "    AND pcat001 = '",g_pcar001,"' ",
               "    AND pcat002||pcat004 NOT IN (SELECT DISTINCT rtjf030||rtjf002 FROM rtjf_t,rtja_t ",
               "                                  WHERE rtjfent = ",g_enterprise," ",
               "                                    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
               "                                    AND rtjfsite = '",g_master.pcarsite,"' ",
               "                                    AND rtjadocdt = '",g_pcar001,"' AND rtja032 = '2' ",
               "                                    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD')) ",
               "  GROUP BY pcat002,pcat004 ",
               "  ORDER BY rtjf030,rtjf002 "
   #LET l_sql = " SELECT pcat002,pcat003,COALESCE(SUM(pcat005),0),0,0,0 FROM pcat_t ",
   #            "  WHERE pcatent = ",g_enterprise," ",
   #            "    AND pcatsite = '",g_master.pcarsite,"' ",
   #            "    AND pcat001 = '",g_pcar001,"' ",
   #            "  GROUP BY pcat002,pcat003 "
   PREPARE sel_pcat_pre FROM l_sql
   DECLARE sel_pcat_cs  CURSOR FOR sel_pcat_pre
   LET l_ac = 1
   FOREACH sel_pcat_cs  INTO g_detail3[l_ac].pcat002,g_detail3[l_ac].pcat003,g_detail3[l_ac].pcat005,
                             g_detail3[l_ac].pcat0051,g_detail3[l_ac].pcat0052,g_detail3[l_ac].pcat0053
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #前台金额
      IF g_detail3[l_ac].pcat005 = 0 THEN
         LET l_sql1 = " SELECT COALESCE(SUM(pcat005),0) FROM pcat_t ",
                      "  WHERE pcatent = ",g_enterprise," ",
                      "    AND pcatsite = '",g_master.pcarsite,"' ",
                      "    AND pcat001 = '",g_pcar001,"' ",
                      "    AND pcat002 = '",g_detail3[l_ac].pcat002,"' ",
                      "    AND pcat004 = '",g_detail3[l_ac].pcat003,"' "
         PREPARE sel_rtjf_pre FROM l_sql1
         EXECUTE sel_rtjf_pre INTO g_detail3[l_ac].pcat005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      END IF
      ##后台金额
      #LET l_sql1 = " SELECT COALESCE(SUM(rtjf031),0) FROM rtjf_t,rtja_t ",
      #             "  WHERE rtjfent = ",g_enterprise," ",
      #             "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
      #             "    AND rtjfsite = '",g_master.pcarsite,"' ",
      #             "    AND rtjadocdt = '",g_pcar001,"' ",
      #             "    AND rtja032 = '2' ",
      #             "    AND to_char(rtjadocdt,'YYYYMMDD')=to_char(rtjacrtdt,'YYYYMMDD') ",
      #             "    AND rtjf030 = '",g_detail3[l_ac].pcat002,"' ",
      #             "    AND rtjf002 = '",g_detail3[l_ac].pcat003,"' "
      #PREPARE sel_rtjf_pre FROM l_sql1
      #EXECUTE sel_rtjf_pre INTO g_detail3[l_ac].pcat0051
      #IF SQLCA.sqlcode THEN
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "FOREACH:" 
      #   LET g_errparam.code   = SQLCA.sqlcode 
      #   LET g_errparam.popup  = TRUE 
      #   CALL cl_err()
      #   EXIT FOREACH
      #END IF
      
      #日结金额、对账金额
      LET l_sql1 = " SELECT COALESCE(SUM(deaf007),0),COALESCE(SUM(deaf006),0) FROM deaf_t ",
                   "  WHERE deafent = ",g_enterprise," ",
                   "    AND deafsite = '",g_master.pcarsite,"' ",
                   "    AND deafdocdt = '",g_pcar001,"' ",
                   "    AND deaf004 = '",g_detail3[l_ac].pcat002,"' ",
                   "    AND deaf005 = '",g_detail3[l_ac].pcat003,"' "
      PREPARE sel_deaf_pre FROM l_sql1
      EXECUTE sel_deaf_pre INTO g_detail3[l_ac].pcat0052,g_detail3[l_ac].pcat0053
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #状态
      IF g_detail3[l_ac].pcat005 <> g_detail3[l_ac].pcat0051 THEN
         LET g_detail3[l_ac].pcatstus = '1'
         LET g_flag = 'Y'
      ELSE
         LET g_detail3[l_ac].pcatstus = '0'
      END IF
      
      CALL apcq100_detail_show("'3'")
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   #延误上传款别统计
   LET l_sql = " SELECT rtjacrtdt,rtjf030,rtjf002,COALESCE(SUM(rtjf031),0) ",
               "   FROM rtjf_t,rtja_t ",
               "  WHERE rtjfent = ",g_enterprise," ",
               "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
               "    AND rtjfsite = '",g_master.pcarsite,"' ",
               "    AND rtjadocdt = '",g_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')>to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY rtjacrtdt,rtjf030,rtjf002 ",
               "  ORDER BY rtjacrtdt,rtjf030,rtjf002 "
   PREPARE sel_rtjf_pre1 FROM l_sql
   DECLARE sel_rtjf_cs1  CURSOR FOR sel_rtjf_pre1
   LET l_ac = 1
   FOREACH sel_rtjf_cs1  INTO g_detail4[l_ac].pcat001,g_detail4[l_ac].pcat002,g_detail4[l_ac].pcat004,g_detail4[l_ac].pcat005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CALL apcq100_detail_show("'4'")
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   #延误上传款别明细
   LET l_sql = " SELECT rtjadocdt,rtjacrtdt,rtjf030,rtjf002,COALESCE(SUM(rtjf031),0),rtja033,rtja034,rtja035,rtjapstdt,rtjf036 ",
               "   FROM rtjf_t,rtja_t ",
               "  WHERE rtjfent = ",g_enterprise," ",
               "    AND rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
               "    AND rtjfsite = '",g_master.pcarsite,"' ",
               "    AND rtjadocdt = '",g_pcar001,"' ",
               "    AND rtja032 = '2' ",
               "    AND to_char(rtjadocdt,'YYYYMMDD')>to_char(rtjacrtdt,'YYYYMMDD') ",
               "  GROUP BY rtjadocdt,rtjacrtdt,rtjf030,rtjf002,rtja033,rtja034,rtja035,rtjapstdt,rtjf036 ",
               "  ORDER BY rtjadocdt,rtjacrtdt,rtjf030,rtjf002 "
   PREPARE sel_rtjf_pre2 FROM l_sql
   DECLARE sel_rtjf_cs2  CURSOR FOR sel_rtjf_pre2
   LET l_ac = 1
   FOREACH sel_rtjf_cs2  INTO g_detail5[l_ac].rtjadocdt,g_detail5[l_ac].pcat001,g_detail5[l_ac].pcat002,
                              g_detail5[l_ac].pcat003,g_detail5[l_ac].pcat005,g_detail5[l_ac].rtja033,
                              g_detail5[l_ac].rtja034,g_detail5[l_ac].rtja035,g_detail5[l_ac].rtjapstdt,
                              g_detail5[l_ac].rtjf036
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CALL apcq100_detail_show("'5'")
      
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL g_detail2.deleteElement(g_detail2.getLength())
   CALL g_detail3.deleteElement(g_detail3.getLength())
   CALL g_detail4.deleteElement(g_detail4.getLength())
   CALL g_detail5.deleteElement(g_detail5.getLength())
   CALL g_detail6.deleteElement(g_detail5.getLength())   #20151111--dongsz add
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apcq100_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apcq100_detail_action_trans()
 
   CALL apcq100_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apcq100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apcq100_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   #單頭狀態
   IF g_flag = 'Y' THEN
      LET g_pcarstus = '1'
   ELSE
      LET g_pcarstus = '0'
   END IF
   DISPLAY g_pcarstus TO pcarstus
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apcq100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apcq100_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail3[l_ac].pcat003
            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail3[l_ac].pcat003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail3[l_ac].pcat003_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail4[l_ac].pcat004
            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail4[l_ac].pcat004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail4[l_ac].pcat004_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #帶出公用欄位reference值page5
      
 
      #add-point:show段單身reference name="detail_show.body5.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail5[l_ac].pcat003
            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail5[l_ac].pcat003_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail5[l_ac].pcat003_1_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'6'",1) > 0 THEN
      #帶出公用欄位reference值page6
      
 
      #add-point:show段單身reference name="detail_show.body6.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail6[l_ac].pcaw005
            LET ls_sql = "SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail6[l_ac].pcaw005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail6[l_ac].pcaw005_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apcq100.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION apcq100_maintain_prog()
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
 
{<section id="apcq100.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apcq100_detail_action_trans()
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
 
{<section id="apcq100.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apcq100_detail_index_setting()
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
 
{<section id="apcq100.mask_functions" >}
 &include "erp/apc/apcq100_mask.4gl"
 
{</section>}
 
{<section id="apcq100.other_function" readonly="Y" >}

 
{</section>}
 
