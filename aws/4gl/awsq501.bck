#該程式已解開Section, 不再透過樣板產出!
{<section id="awsq501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-24 10:07:33), PR版次:0004(2016-12-22 10:21:11)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: awsq501
#+ Description: PLM料件,BOM拋轉營運據點查詢作業
#+ Creator....: 07556(2016-11-24 10:07:33)
#+ Modifier...: 07556 -SD/PR- 07556
 
{</section>}
 
{<section id="awsq501.global" >}
#應用 q01 樣板自動產生(Version:33)
#add-point:填寫註解說明 name="global.memo"
#161209-00042#2  2016/12/14 By Jessica  增加顯示欄位
#161222-00004#1  2016/12/22 By Jessica  增加顯示欄位:料件據點
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
PRIVATE TYPE type_g_imaa_d RECORD 
   l_checkerr       LIKE type_t.chr1,     
   l_logmpk         LIKE type_t.typeud021, 
   l_entid          LIKE type_t.chr10, 
   l_trantime       LIKE type_t.typeud021, 
   l_seqkey         LIKE type_t.chr20, 
   l_seqkeytotcnt   LIKE type_t.num10, 
   l_reqxmltime     LIKE type_t.typeud021, 
   l_formid         LIKE type_t.chr50, 
   l_datastatus     LIKE type_t.chr1, 
   l_efseqkey       LIKE type_t.chr20, 
   l_starttime      LIKE type_t.typeud021, 
   l_endtime        LIKE type_t.typeud021, 
   l_processingtime INTERVAL DAY TO FRACTION(3)
       END RECORD
PRIVATE TYPE type_g_imaa2_d RECORD    
   l_acttype_imaa   LIKE type_t.chr1,     #161209-00042#2   
   l_imaaent        LIKE type_t.num5, 
   l_imaasites      LIKE type_t.chr1000,  #161222-00004#1
   l_imaa001        LIKE type_t.chr500, 
   l_imaa003        LIKE type_t.chr10, 
   l_imaa004        LIKE type_t.chr10, 
   l_imaa006        LIKE type_t.chr10, 
   l_imaa009        LIKE type_t.chr10, 
   l_imaa010        LIKE type_t.chr10
       END RECORD
PRIVATE TYPE type_g_imaa3_d RECORD
   l_acttype_bmaa   LIKE type_t.chr1,     #161209-00042#2
   l_bmaaent        LIKE type_t.num5, 
   l_bmaa001        LIKE type_t.chr500, 
   l_bmaa002        LIKE type_t.chr30, 
   l_bmaa003        LIKE type_t.num20_6, 
   l_bmaa004        LIKE type_t.chr10
       END RECORD
 
PRIVATE TYPE type_g_imaa4_d RECORD
   l_ooef001        LIKE type_t.chr10, 
   l_ooef001_desc   LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_imaa5_d RECORD
   l_acttype_err    LIKE type_t.chr1, 
   l_imaa001_err    LIKE type_t.chr500, 
   l_msg_err        LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_plm_db      STRING
DEFINE g_imaatype    STRING
DEFINE g_imaaent     STRING
DEFINE g_imaa001     STRING
DEFINE g_seqkey      STRING
DEFINE g_logm        STRING
DEFINE g_change_page LIKE type_t.num5
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imaa_d      DYNAMIC ARRAY OF type_g_imaa_d
DEFINE g_imaa_d_t    type_g_imaa_d
DEFINE g_imaa2_d     DYNAMIC ARRAY OF type_g_imaa2_d
DEFINE g_imaa2_d_t   type_g_imaa2_d
DEFINE g_imaa3_d     DYNAMIC ARRAY OF type_g_imaa3_d
DEFINE g_imaa3_d_t   type_g_imaa3_d
 
DEFINE g_imaa4_d     DYNAMIC ARRAY OF type_g_imaa4_d
DEFINE g_imaa4_d_t   type_g_imaa4_d
 
DEFINE g_imaa5_d     DYNAMIC ARRAY OF type_g_imaa5_d
DEFINE g_imaa5_d_t   type_g_imaa5_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_wc_filter2          STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE l_ac2                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE l_ac3                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE l_ac4                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE l_ac5                 LIKE type_t.num10             #目前處理的ARRAY CNT 
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
DEFINE g_detail_idx3         LIKE type_t.num10
DEFINE g_detail_idx4         LIKE type_t.num10
DEFINE g_detail_idx5         LIKE type_t.num10
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
 
{<section id="awsq501.main" >}
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
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化 name="main.init"
   LET g_plm_db = ''
   CALL cl_eai_get_middb(g_dbs) RETURNING g_plm_db
   LET g_change_page = TRUE
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
   DECLARE awsq501_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE awsq501_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE awsq501_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsq501 WITH FORM cl_ap_formpath("aws",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL awsq501_init()   
 
      #進入選單 Menu (="N")
      CALL awsq501_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_awsq501
      
   END IF 
   
   CLOSE awsq501_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="awsq501.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION awsq501_init()
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
   LET g_detail_idx3 = 1
   LET g_detail_idx4 = 1
   LET g_detail_idx5 = 1
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("imaatype","16021")
   #end add-point
 
   CALL awsq501_default_search()
END FUNCTION
 
{</section>}
 
{<section id="awsq501.default_search" >}
PRIVATE FUNCTION awsq501_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " imaa001 = '", g_argv[01], "' AND "
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
 
{<section id="awsq501.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsq501_ui_dialog() 
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
   DEFINE l_imaatype LIKE type_t.num5
   DEFINE l_seqkey   LIKE type_t.chr20
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
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx3 = 1
   LET g_detail_idx4 = 1
   LET g_detail_idx5 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"

   #end add-point
 
   
   CALL awsq501_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_imaa_d.clear()
         CALL g_imaa2_d.clear()
         CALL g_imaa3_d.clear() 
         CALL g_imaa4_d.clear() 
         CALL g_imaa5_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         LET g_detail_idx3 = 1
         LET g_detail_idx4 = 1
         LET g_detail_idx5 = 1
 
         CALL awsq501_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
       
         CONSTRUCT BY NAME g_imaatype ON imaatype
            BEFORE CONSTRUCT   
               IF cl_null(g_argv[01]) THEN
                  LET l_imaatype = '1'
               ELSE
                  LET l_imaatype = g_argv[01] 
               END IF 
               DISPLAY l_imaatype TO imaatype      #顯示到畫面上
               NEXT FIELD imaatype    
         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_imaaent ON imaaent
         
         END CONSTRUCT      
         
         CONSTRUCT BY NAME g_imaa001 ON imaa001

            BEFORE CONSTRUCT   
               LET g_imaa001 = NULL
               NEXT FIELD imaa001   
                           
            ON ACTION controlp INFIELD imaa001
            
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa001      #顯示到畫面上
            
               NEXT FIELD imaa001              
               
         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_seqkey ON seqkey  
               
         END CONSTRUCT 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"

         #end add-point
       
         DISPLAY ARRAY g_imaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL awsq501_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL awsq501_b_fill2()     
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
 
            #end add-point
 
         END DISPLAY
         
         DISPLAY ARRAY g_imaa2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx2
               LET g_detail_idx2 = l_ac2
               DISPLAY g_detail_idx2 TO FORMONLY.idx    #單身當下筆數                
               CALL awsq501_b_fill3('1')
 
               #add-point:input段before row name="input.body.before_row"
               LET g_change_page = TRUE
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point
 
         DISPLAY ARRAY g_imaa3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac3 = g_detail_idx3
               LET g_detail_idx3 = l_ac3
               DISPLAY g_detail_idx3 TO FORMONLY.idx    #單身當下筆數
 
               #add-point:input段before row name="input.body3.before_row"
               CALL awsq501_b_fill3('2')
               LET g_change_page = FALSE
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body3.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_imaa4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac4 = g_detail_idx4
               LET g_detail_idx4 = l_ac4
               DISPLAY g_detail_idx4 TO FORMONLY.idx    #單身當下筆數
 
               #add-point:input段before row name="input.body4.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body4.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_imaa5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx5 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac5 = g_detail_idx5
               LET g_detail_idx5 = l_ac5
               DISPLAY g_detail_idx5 TO FORMONLY.idx    #單身當下筆數
 
               #add-point:input段before row name="input.body5.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body5.action"

            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL awsq501_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"

            #end add-point
            NEXT FIELD imaatype
 
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
 
            LET g_detail_idx  = 1
            LET g_detail_idx2 = 1
            LET g_detail_idx3 = 1
            LET g_detail_idx4 = 1
            LET g_detail_idx5 = 1
            CALL awsq501_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_imaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_imaa2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_imaa3_d)
               LET g_export_id[3]   = "s_detail3" 
               LET g_export_node[4] = base.typeInfo.create(g_imaa4_d)
               LET g_export_id[4]   = "s_detail4" 
               LET g_export_node[5] = base.typeInfo.create(g_imaa5_d)
               LET g_export_id[5]   = "s_detail5"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL awsq501_b_fill()
 
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
            CALL awsq501_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL awsq501_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL awsq501_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL awsq501_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL awsq501_filter()
            #add-point:ON ACTION filter name="menu.filter"

            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"

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
 
{<section id="awsq501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION awsq501_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"

   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_imaaent_ws    STRING
   DEFINE l_imaa001_ws    STRING
   DEFINE l_seqkey_ws     STRING
   DEFINE l_checkerr      STRING
   DEFINE l_cnt           LIKE type_t.num10 
   DEFINE l_acttype       LIKE type_t.num5
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
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
 
   CALL g_imaa_d.clear()
   
   #add-point:陣列清空 name="b_fill.array_clear"
   #161209-00042#2-S
   CALL g_imaa2_d.clear()
   CALL g_imaa3_d.clear() 
   CALL g_imaa4_d.clear() 
   CALL g_imaa5_d.clear()
   #161209-00042#2-E
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac  = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET l_imaaent_ws = " 1=1 " 
   LET l_imaa001_ws = " 1=1 "
   LET l_seqkey_ws  = " 1=1 "
   IF NOT cl_null(g_argv[01]) AND NOT cl_null(g_argv[02]) THEN
      LET g_imaatype = "imaatype='",g_argv[01],"'"
      LET g_seqkey   = "seqkey='",g_argv[02],"'"
   END IF
   
   IF g_imaaent <> " 1=1" THEN
      LET l_imaaent_ws = "b.",g_imaaent
   END IF
   IF g_seqkey <> " 1=1" THEN
      LET l_seqkey_ws = "a.",g_seqkey
   END IF
   IF g_imaa001 <> " 1=1" THEN
      LET l_imaa001_ws = "b.",g_imaa001
   END IF
   IF g_wc_filter <> " 1=1" THEN  
      IF g_wc_filter2 = "checkerr='Y' " THEN
         LET ls_sql_rank = "SELECT UNIQUE a.logm_pk,a.entid,a.tran_time,a.seqkey,a.seqkey_totcnt,a.reqxml_time,a.formid,a.datastatus,a.ef_seqkey,a.start_time,a.end_time ",
                           " FROM ",g_plm_db CLIPPED,".plm_logm_t a ",
                           " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_imaa_t b ON a.seqkey = b.seqkey ",
                           " INNER JOIN ",g_plm_db CLIPPED,".plm_logd_t d ON a.seqkey = d.seqkey ",
                           " WHERE ", g_wc_filter ,
                           " AND EXISTS (SELECT * FROM ",g_plm_db CLIPPED,".plm_logd_t d WHERE a.seqkey = d.seqkey) "
      END IF   
      IF g_wc_filter2 = "checkerr='N' " THEN
         LET ls_sql_rank = "SELECT UNIQUE a.logm_pk,a.entid,a.tran_time,a.seqkey,a.seqkey_totcnt,a.reqxml_time,a.formid,a.datastatus,a.ef_seqkey,a.start_time,a.end_time ",
                           " FROM ",g_plm_db CLIPPED,".plm_logm_t a ",
                           " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_imaa_t b ON a.seqkey = b.seqkey ",
                           " WHERE ", g_wc_filter ,
                           " AND NOT EXISTS (SELECT * FROM ",g_plm_db CLIPPED,".plm_logd_t d WHERE a.seqkey = d.seqkey) "
      END IF   
      IF g_wc_filter2 <> "checkerr='Y' " AND g_wc_filter2 <> "checkerr='N' " THEN      
         LET ls_sql_rank = "SELECT UNIQUE a.logm_pk,a.entid,a.tran_time,a.seqkey,a.seqkey_totcnt,a.reqxml_time,a.formid,a.datastatus,a.ef_seqkey,a.start_time,a.end_time ",
                           " FROM ",g_plm_db CLIPPED,".plm_logm_t a ",
                           " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_imaa_t b ON a.seqkey = b.seqkey ",
                           " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_logd_t d ON a.seqkey = d.seqkey ",
                           " WHERE ", g_wc_filter
      END IF
   ELSE
      IF g_imaatype IS NOT NULL THEN
         IF g_imaatype = "imaatype='1'" THEN
            LET ls_sql_rank = "SELECT UNIQUE a.logm_pk,a.entid,a.tran_time,a.seqkey,a.seqkey_totcnt,a.reqxml_time,a.formid,a.datastatus,a.ef_seqkey,a.start_time,a.end_time ",
                              " FROM ",g_plm_db CLIPPED,".plm_logm_t a ",
                              " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_imaa_t b ON a.seqkey = b.seqkey ",
                              " INNER JOIN ",g_plm_db CLIPPED,".plm_logd_t d ON a.seqkey = d.seqkey ",
                              " WHERE ",l_seqkey_ws," AND ",l_imaaent_ws," AND ",l_imaa001_ws ,
                              " AND EXISTS (SELECT * FROM ",g_plm_db CLIPPED,".plm_logd_t d WHERE a.seqkey = d.seqkey) "
         END IF
         IF g_imaatype = "imaatype='2'" THEN
            LET ls_sql_rank = "SELECT UNIQUE a.logm_pk,a.entid,a.tran_time,a.seqkey,a.seqkey_totcnt,a.reqxml_time,a.formid,a.datastatus,a.ef_seqkey,a.start_time,a.end_time ",
                              " FROM ",g_plm_db CLIPPED,".plm_logm_t a ",
                              " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_imaa_t b ON a.seqkey = b.seqkey ",
                              " WHERE ",l_seqkey_ws," AND ",l_imaaent_ws," AND ",l_imaa001_ws ,
                              " AND NOT EXISTS (SELECT * FROM ",g_plm_db CLIPPED,".plm_logd_t d WHERE a.seqkey = d.seqkey) "
         END IF  
         IF g_imaatype <> "imaatype='1'" AND g_imaatype <> "imaatype='2'" THEN                         
            LET ls_sql_rank = "SELECT UNIQUE a.logm_pk,a.entid,a.tran_time,a.seqkey,a.seqkey_totcnt,a.reqxml_time,a.formid,a.datastatus,a.ef_seqkey,a.start_time,a.end_time ",
                              " FROM ",g_plm_db CLIPPED,".plm_logm_t a ",
                              " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_imaa_t b ON a.seqkey = b.seqkey ",
                              " LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_logd_t d ON a.seqkey = d.seqkey ",
                              " WHERE ",l_seqkey_ws," AND ",l_imaaent_ws," AND ",l_imaa001_ws 
         END IF  
      END IF
   END IF
   
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("",g_plm_db CLIPPED,".plm_logm_t"),
   #                  " ORDER BY a.logm_pk,a.entid,a.seqkey"
   LET ls_sql_rank = ls_sql_rank, " ORDER BY a.logm_pk,a.entid,a.seqkey "
                     
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"

   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre INTO g_tot_cnt
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
 
   LET g_sql = "SELECT logm_pk,entid,tran_time,seqkey,seqkey_totcnt,reqxml_time,formid,datastatus,ef_seqkey,start_time,end_time,end_time-start_time ",
               " FROM (",ls_sql_rank,")"#,
               #" WHERE RANK >= ",g_pagestart,
               #" AND RANK < ",g_pagestart + g_num_in_page
                
   #add-point:b_fill段sql_after name="b_fill.sql_after"
 
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE awsq501_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR awsq501_pb
 
   OPEN b_fill_curs
 
 
 
   FOREACH b_fill_curs INTO g_imaa_d[l_ac].l_logmpk,    g_imaa_d[l_ac].l_entid, g_imaa_d[l_ac].l_trantime,  g_imaa_d[l_ac].l_seqkey,  g_imaa_d[l_ac].l_seqkeytotcnt,
                            g_imaa_d[l_ac].l_reqxmltime,g_imaa_d[l_ac].l_formid,g_imaa_d[l_ac].l_datastatus,g_imaa_d[l_ac].l_efseqkey,g_imaa_d[l_ac].l_starttime,
                            g_imaa_d[l_ac].l_endtime   ,g_imaa_d[l_ac].l_processingtime
                                 
      IF g_imaatype = "imaatype='2'" THEN
         LET g_imaa_d[l_ac].l_checkerr = 'N'
      ELSE
         LET g_sql = " SELECT COUNT(1) FROM ",g_plm_db CLIPPED,".plm_logm_t a LEFT OUTER JOIN ",g_plm_db CLIPPED,".plm_logd_t b ON a.seqkey = b.seqkey ",
                     " WHERE a.seqkey = '",g_imaa_d[l_ac].l_seqkey,"' AND a.entid = '",g_imaa_d[l_ac].l_entid,"'",
                     "  AND EXISTS (SELECT * FROM ",g_plm_db CLIPPED,".plm_logd_t b WHERE a.seqkey = b.seqkey) "
                     
         PREPARE awsq501_cnt FROM g_sql
         EXECUTE awsq501_cnt INTO l_cnt
         IF l_cnt = 0 THEN
            LET g_imaa_d[l_ac].l_checkerr = 'N'
         ELSE
            LET g_imaa_d[l_ac].l_checkerr = 'Y'
         END IF         
      END IF
      
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
 
      CALL awsq501_detail_show("'1'")
 
      CALL awsq501_imaa_t_mask()
 
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
 
   #應用 qs05 樣板自動產生(Version:3)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"

   #end add-point
 
   CALL g_imaa_d.deleteElement(g_imaa_d.getLength()) 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"

   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_imaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE awsq501_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL awsq501_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL awsq501_detail_action_trans()
 
   LET l_ac = 1
   IF g_imaa_d.getLength() > 0 THEN
      CALL awsq501_b_fill2()
   END IF
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="awsq501.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION awsq501_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"

   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_acttype       LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"

   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:6)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   LET l_ac2 = 1   
   LET l_ac3 = 1   
   LET l_ac5 = 1
   CALL g_imaa2_d.clear()
   CALL g_imaa3_d.clear()
   CALL g_imaa5_d.clear()
   IF l_ac = 0 OR cl_null(g_imaa_d[l_ac].l_seqkey) THEN
      RETURN
   END IF   
   
   #161209-00042#2-S
   #LET l_sql = " SELECT imaaent,imaa001,imaa003,imaa004,imaa006,imaa009,imaa010 FROM ",g_plm_db CLIPPED,".plm_imaa_t ",
   #161222-00004#1-S
   #LET l_sql = " SELECT acttype,imaaent,imaa001,imaa003,imaa004,imaa006,imaa009,imaa010 FROM ",g_plm_db CLIPPED,".plm_imaa_t ",
   LET l_sql = " SELECT acttype,imaaent,imaasites,imaa001,imaa003,imaa004,imaa006,imaa009,imaa010 FROM ",g_plm_db CLIPPED,".plm_imaa_t ",
   #161222-00004#1-E 
   #161209-00042#2-E
               "  WHERE seqkey = '",g_imaa_d[l_ac].l_seqkey,"' AND entid = '",g_imaa_d[l_ac].l_entid,"'"
               
   PREPARE awsq501_pb_02 FROM l_sql
   DECLARE b_fill_curs_02 CURSOR FOR awsq501_pb_02    
   #161209-00042#2-S
   #FOREACH b_fill_curs_02 INTO g_imaa2_d[l_ac2].l_imaaent,g_imaa2_d[l_ac2].l_imaa001,g_imaa2_d[l_ac2].l_imaa003,
   #161222-00004#1-S
   #FOREACH b_fill_curs_02 INTO g_imaa2_d[l_ac2].l_acttype_imaa,g_imaa2_d[l_ac2].l_imaaent,g_imaa2_d[l_ac2].l_imaa001,g_imaa2_d[l_ac2].l_imaa003,
   FOREACH b_fill_curs_02 INTO g_imaa2_d[l_ac2].l_acttype_imaa,g_imaa2_d[l_ac2].l_imaaent,g_imaa2_d[l_ac2].l_imaasites,g_imaa2_d[l_ac2].l_imaa001,g_imaa2_d[l_ac2].l_imaa003,
   #161222-00004#1-E 
   #161209-00042#2-E 
                               g_imaa2_d[l_ac2].l_imaa004,g_imaa2_d[l_ac2].l_imaa006,g_imaa2_d[l_ac2].l_imaa009,g_imaa2_d[l_ac2].l_imaa010
   #161209-00042#2-S
      CALL cl_set_combo_scc("l_acttype_imaa","16024")      
      LET l_acttype = g_imaa2_d[l_ac2].l_acttype_imaa
      DISPLAY l_acttype TO l_acttype_imaa      #顯示到畫面上 
   #161209-00042#2-E 
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF     
  
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
          END IF
         EXIT FOREACH
      END IF                    
   END FOREACH    
   
   #161209-00042#2-S
   #LET l_sql = " SELECT bmaaent,bmaa001,bmaa002,bmaa003,bmaa004 FROM ",g_plm_db CLIPPED,".plm_bmaa_t ",
   LET l_sql = " SELECT acttype,bmaaent,bmaa001,bmaa002,bmaa003,bmaa004 FROM ",g_plm_db CLIPPED,".plm_bmaa_t ",
   #161209-00042#2-E
               "  WHERE seqkey = '",g_imaa_d[l_ac].l_seqkey,"' AND entid = '",g_imaa_d[l_ac].l_entid,"'"
               
   PREPARE awsq501_pb_03 FROM l_sql
   DECLARE b_fill_curs_03 CURSOR FOR awsq501_pb_03   
   #161209-00042#2-S
   #FOREACH b_fill_curs_03 INTO g_imaa3_d[l_ac3].l_bmaaent,g_imaa3_d[l_ac3].l_bmaa001, 
   FOREACH b_fill_curs_03 INTO g_imaa3_d[l_ac3].l_acttype_bmaa,g_imaa3_d[l_ac3].l_bmaaent,g_imaa3_d[l_ac3].l_bmaa001, 
   #161209-00042#2-E
                               g_imaa3_d[l_ac3].l_bmaa002,g_imaa3_d[l_ac3].l_bmaa003,g_imaa3_d[l_ac3].l_bmaa004
   #161209-00042#2-S
      CALL cl_set_combo_scc("l_acttype_bmaa","16024")      
      LET l_acttype = g_imaa3_d[l_ac3].l_acttype_bmaa
      DISPLAY l_acttype TO l_acttype_bmaa      #顯示到畫面上   
   #161209-00042#2-E
                              
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF     
 
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
          END IF
         EXIT FOREACH
      END IF                    
   END FOREACH    

   LET l_sql = " SELECT acttype,imaa001,msg_txt FROM ",g_plm_db CLIPPED,".plm_logd_t ",
               "  WHERE seqkey = '",g_imaa_d[l_ac].l_seqkey,"' AND entid = '",g_imaa_d[l_ac].l_entid,"'"
               
   PREPARE awsq501_pb_05 FROM l_sql
   DECLARE b_fill_curs_05 CURSOR FOR awsq501_pb_05   
   FOREACH b_fill_curs_05 INTO g_imaa5_d[l_ac5].l_acttype_err,g_imaa5_d[l_ac5].l_imaa001_err,g_imaa5_d[l_ac5].l_msg_err  
      CALL cl_set_combo_scc("l_acttype_err","16023")      
      LET l_acttype = g_imaa5_d[l_ac5].l_acttype_err
      
      DISPLAY l_acttype TO l_acttype_err      #顯示到畫面上   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF     
  
      LET l_ac5 = l_ac5 + 1
      IF l_ac5 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9055 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
          END IF
         EXIT FOREACH
      END IF                    
   END FOREACH 
   #end add-point
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   CALL g_imaa2_d.deleteElement(g_imaa2_d.getLength())
   CALL g_imaa3_d.deleteElement(g_imaa3_d.getLength())  
   CALL g_imaa5_d.deleteElement(g_imaa5_d.getLength())  
   #end add-point
 
 
   #DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx    #單身當下筆數
   LET g_detail_idx3 = 1
   DISPLAY g_detail_idx3 TO FORMONLY.idx    #單身當下筆數
   LET g_detail_idx5 = 1
   DISPLAY g_detail_idx5 TO FORMONLY.idx    #單身當下筆數
 
   #add-point:單身填充後 name="b_fill2.after_fill"

   #end add-point
 
   LET l_ac = li_ac
   
   IF g_change_page THEN 
      LET l_ac2 = 1        
      IF g_imaa2_d.getLength() > 0 THEN
         CALL awsq501_b_fill3('1')
      END IF
   ELSE           
      LET l_ac3 = 1  
      IF g_imaa3_d.getLength() > 0 THEN
         CALL awsq501_b_fill3('2')
      END IF
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="awsq501.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION awsq501_detail_show(ps_page)
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
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body5.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="awsq501.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION awsq501_filter()
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
   LET g_detail_idx3 = 1
   LET g_detail_idx4 = 1
   LET g_detail_idx5 = 1
 
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
      CONSTRUCT g_wc_filter ON a.logm_pk,a.entid,a.tran_time,a.seqkey,a.seqkey_totcnt,
                               a.reqxml_time,a.formid,a.datastatus,a.ef_seqkey,
                               a.start_time,a.end_time
                          FROM s_detail1[1].l_logmpk        ,s_detail1[1].l_entid       ,s_detail1[1].l_trantime,
                               s_detail1[1].l_seqkey        ,s_detail1[1].l_seqkeytotcnt,
                               s_detail1[1].l_reqxmltime    ,s_detail1[1].l_formid      ,s_detail1[1].l_datastatus,
                               s_detail1[1].l_efseqkey      ,s_detail1[1].l_starttime   ,s_detail1[1].l_endtime                           
         BEFORE CONSTRUCT
            DISPLAY '0' TO imaatype      #顯示到畫面上
            
            DISPLAY awsq501_filter_parser('l_logmpk')        TO s_detail1[1].l_logmpk
            DISPLAY awsq501_filter_parser('l_entid')         TO s_detail1[1].l_entid
            DISPLAY awsq501_filter_parser('l_trantime')      TO s_detail1[1].l_trantime
            DISPLAY awsq501_filter_parser('l_seqkey')        TO s_detail1[1].l_seqkey
            DISPLAY awsq501_filter_parser('l_seqkeytotcnt')  TO s_detail1[1].l_seqkeytotcnt
            DISPLAY awsq501_filter_parser('l_reqxmltime')    TO s_detail1[1].l_reqxmltime
            DISPLAY awsq501_filter_parser('l_formid')        TO s_detail1[1].l_formid
            DISPLAY awsq501_filter_parser('l_datastatus')    TO s_detail1[1].l_datastatus
            DISPLAY awsq501_filter_parser('l_efseqkey')      TO s_detail1[1].l_efseqkey
            DISPLAY awsq501_filter_parser('l_starttime')     TO s_detail1[1].l_starttime
            DISPLAY awsq501_filter_parser('l_endtime')       TO s_detail1[1].l_endtime         
 
         #單身公用欄位開窗相關處理
 
         #單身一般欄位開窗相關處理
 
 
      END CONSTRUCT
 
      CONSTRUCT g_wc_filter2 ON checkerr FROM s_detail1[1].l_checkerr
         BEFORE CONSTRUCT
            DISPLAY '0' TO imaatype      #顯示到畫面上
            DISPLAY awsq501_filter_parser('l_checkerr')       TO s_detail1[1].l_checkerr 
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
 
   CALL awsq501_filter_show('l_checkerr','l_checkerr')
   CALL awsq501_filter_show('l_logmpk','l_logmpk')
   CALL awsq501_filter_show('l_entid','l_entid')
   CALL awsq501_filter_show('l_trantime','l_trantime')
   CALL awsq501_filter_show('l_seqkey','l_seqkey')
   CALL awsq501_filter_show('l_seqkeytotcnt','l_seqkeytotcnt')
   CALL awsq501_filter_show('l_reqxmltime','l_reqxmltime')
   CALL awsq501_filter_show('l_formid','l_formid')
   CALL awsq501_filter_show('l_datastatus','l_datastatus')
   CALL awsq501_filter_show('l_efseqkey','l_efseqkey')
   CALL awsq501_filter_show('l_starttime','l_starttime')
   CALL awsq501_filter_show('l_endtime','l_endtime') 
 
   CALL awsq501_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="awsq501.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION awsq501_filter_parser(ps_field)
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
 
{<section id="awsq501.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION awsq501_filter_show(ps_field,ps_object)
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
   LET ls_condition = awsq501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="awsq501.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION awsq501_detail_action_trans()
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
 
{<section id="awsq501.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION awsq501_detail_index_setting()
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
            IF g_imaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_imaa_d.getLength() AND g_imaa_d.getLength() > 0
            LET g_detail_idx = g_imaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_imaa_d.getLength() THEN
               LET g_detail_idx = g_imaa_d.getLength()
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
 
{<section id="awsq501.mask_functions" >}
 &include "erp/aws/awsq501_mask.4gl"
 
{</section>}
 
{<section id="awsq501.other_function" readonly="Y" >}

#+ 單身陣列填充3
PRIVATE FUNCTION awsq501_b_fill3(p_type)
   DEFINE p_type          LIKE type_t.num10  #1:plm_imaa_t 2:plm_bmaa_t
   DEFINE li_ac           LIKE type_t.num10
   DEFINE l_sql           STRING
   DEFINE l_ooeflent      LIKE ooefl_t.ooeflent 

   LET li_ac = l_ac
 
   CALL g_imaa4_d.clear()
   IF l_ac = 0 OR cl_null(g_imaa_d[l_ac].l_seqkey) THEN
      RETURN
   END IF   

   IF p_type = '1' THEN
      IF cl_null(g_imaa2_d[l_ac2].l_imaa001) THEN
         RETURN
      ELSE   
         LET l_sql = " SELECT imafsite,ooefl003 FROM imaf_t ",
                     " LEFT OUTER JOIN ooefl_t ON ooeflent = imafent AND ooefl001 = imafsite AND ooefl002 = '"||g_lang||"' ",
                     " WHERE imafent = ",g_imaa2_d[l_ac2].l_imaaent," AND imaf001 = '",g_imaa2_d[l_ac2].l_imaa001,"'",
                     "  AND imafsite <> 'ALL' ORDER BY imafsite "
      END IF   
   END IF   
   
   IF p_type = '2' THEN
      IF cl_null(g_imaa3_d[l_ac3].l_bmaa001) THEN
         RETURN
      ELSE  
         LET l_sql = " SELECT bmaasite,ooefl003 FROM bmaa_t ",
                     " LEFT OUTER JOIN ooefl_t ON ooeflent = bmaaent AND ooefl001 = bmaasite AND ooefl002 = '"||g_lang||"' ",
                     " WHERE bmaaent = ",g_imaa3_d[l_ac3].l_bmaaent," AND bmaa001 = '",g_imaa3_d[l_ac3].l_bmaa001,"'",
                     " AND bmaa002 = '",g_imaa3_d[l_ac3].l_bmaa002,"' AND bmaasite <> 'ALL' ORDER BY bmaasite " 
      END IF   
   END IF   
  
                            
   PREPARE awsq501_pb_04 FROM l_sql
   DECLARE b_fill_curs_04 CURSOR FOR awsq501_pb_04      
   LET l_ac4 = 1
   FOREACH b_fill_curs_04 INTO g_imaa4_d[l_ac4].l_ooef001,g_imaa4_d[l_ac4].l_ooef001_desc   
                             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF     
  
      LET l_ac4 = l_ac4 + 1
      IF l_ac4 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9045 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
          END IF
         EXIT FOREACH
      END IF                    
   END FOREACH 

   CALL g_imaa4_d.deleteElement(g_imaa4_d.getLength())
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx4 = 1
   DISPLAY g_detail_idx4 TO FORMONLY.idx
 
   LET l_ac = li_ac
END FUNCTION

 
{</section>}
 
