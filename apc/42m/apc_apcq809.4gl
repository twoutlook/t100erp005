#該程式未解開Section, 採用最新樣板產出!
{<section id="apcq809.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-10-11 11:42:02), PR版次:0001(2015-10-13 19:19:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: apcq809
#+ Description: 收銀員效率月考核查詢作業
#+ Creator....: 06189(2015-09-28 14:20:01)
#+ Modifier...: 06189 -SD/PR- 06189
 
{</section>}
 
{<section id="apcq809.global" >}
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
PRIVATE TYPE type_g_rtja_d RECORD
       
       sel LIKE type_t.chr1, 
   rtjadocno LIKE rtja_t.rtjadocno, 
   rtjasite LIKE rtja_t.rtjasite, 
   rtjasite_desc LIKE type_t.chr500, 
   rtjadocdt LIKE rtja_t.rtjadocdt, 
   rtja037 LIKE rtja_t.rtja037, 
   rtja037_desc LIKE type_t.chr500, 
   rtja036 LIKE rtja_t.rtja036, 
   rtja033 LIKE rtja_t.rtja033, 
   rtja035 LIKE rtja_t.rtja035, 
   endtime LIKE type_t.chr500, 
   scantime LIKE type_t.num10, 
   count LIKE type_t.num20_6, 
   speed LIKE type_t.num20_6, 
   number LIKE type_t.num20_6, 
   amount LIKE type_t.num20_6, 
   rtja041 LIKE rtja_t.rtja041
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_rtja2_d RECORD
       
       sel_1 LIKE type_t.chr1, 
   rtjasite_1 LIKE rtja_t.rtjasite, 
   rtjasite_1_desc LIKE type_t.chr500, 
   rtjadocdt_1 LIKE rtja_t.rtjadocdt, 
   rtja037_1 LIKE rtja_t.rtja037, 
   rtja037_1_desc LIKE type_t.chr500,  
   rtja035_1 LIKE rtja_t.rtja035, 
   endtime_1 LIKE type_t.chr500, 
   scantime_1 LIKE type_t.num20_6, 
   count_1 LIKE type_t.num20_6, 
   speed_1 LIKE type_t.num20_6, 
   number_1 LIKE type_t.num20_6, 
   amount_1 LIKE type_t.num20_6, 
   rtja041_1 LIKE rtja_t.rtja041
       END RECORD
       
 TYPE type_g_rtja3_d RECORD
       
       sel_2 LIKE type_t.chr1, 
   rtjasite_2 LIKE rtja_t.rtjasite, 
   rtjasite_2_desc LIKE type_t.chr500, 
   yearmonth  LIKE type_t.chr500,  
   rtja037_2 LIKE rtja_t.rtja037, 
   rtja037_2_desc LIKE type_t.chr500,  
   scantime_2 LIKE type_t.num20, 
   count_2 LIKE type_t.num20_6, 
   speed_2 LIKE type_t.num20_6, 
   number_2 LIKE type_t.num20_6, 
   amount_2 LIKE type_t.num20_6, 
   rtja041_2 LIKE rtja_t.rtja041
       END RECORD      
DEFINE g_wc_sdate          LIKE rtja_t.rtjadocdt          
DEFINE g_wc_edate          LIKE rtja_t.rtjadocdt      
DEFINE g_edate             LIKE rtja_t.rtjadocdt
DEFINE g_sdate             LIKE rtja_t.rtjadocdt
DEFINE g_edate1            LIKE rtja_t.rtjadocdt
DEFINE g_sdate1            LIKE rtja_t.rtjadocdt
DEFINE g_rtjasite          LIKE rtja_t.rtjasite
DEFINE g_rtja2_d            DYNAMIC ARRAY OF type_g_rtja2_d
DEFINE g_rtja2_d_t          type_g_rtja2_d
DEFINE g_rtja3_d            DYNAMIC ARRAY OF type_g_rtja3_d
DEFINE g_rtja3_d_t          type_g_rtja3_d
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtja_d            DYNAMIC ARRAY OF type_g_rtja_d
DEFINE g_rtja_d_t          type_g_rtja_d
 
 
 
 
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
 
{<section id="apcq809.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
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
   DECLARE apcq809_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apcq809_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apcq809_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apcq809 WITH FORM cl_ap_formpath("apc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apcq809_init()   
 
      #進入選單 Menu (="N")
      CALL apcq809_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apcq809
      
   END IF 
   
   CLOSE apcq809_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL apcq809_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apcq809.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apcq809_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   LET l_success = ''
   CALL apcq809_create_tmp() RETURNING l_success
   #end add-point
 
   CALL apcq809_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apcq809.default_search" >}
PRIVATE FUNCTION apcq809_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjadocno = '", g_argv[01], "' AND "
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
 
{<section id="apcq809.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apcq809_ui_dialog() 
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
 
   
   CALL apcq809_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtja_d.clear()
 
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
 
         CALL apcq809_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON rtjasite,rtja037      
            BEFORE CONSTRUCT
               LET g_rtjasite = GET_FLDBUF(rtjasite)
               IF g_rtjasite IS NULL THEN            
                  DISPlAY g_site TO rtjasite
               END IF  
               LET g_sdate = GET_FLDBUF(sdate)
               IF g_sdate IS NULL THEN            
                  DISPlAY g_today TO sdate
               END IF 
               LET g_edate = GET_FLDBUF(edate)
               IF g_edate IS NULL THEN            
                  DISPlAY g_today TO edate
               END IF    
            #门店编号            
            ON ACTION controlp INFIELD rtjasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO rtjasite  #顯示到畫面上
               NEXT FIELD rtjasite                     #返回原欄位
               
            ON ACTION controlp INFIELD rtja037            
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
			     LET g_qryparam.reqry = FALSE
              CALL q_pcab001_1()                            #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtja037  #顯示到畫面上
            
              NEXT FIELD rtja037    
   
         END CONSTRUCT
         
         CONSTRUCT g_wc_sdate ON sdate FROM sdate
            BEFORE CONSTRUCT
               #获取当前日期
               LET g_sdate = GET_FLDBUF(sdate)
               IF g_sdate IS NULL THEN            
                  DISPlAY g_today TO sdate
               END IF               
    
         END CONSTRUCT
         CONSTRUCT g_wc_edate ON edate FROM edate
            BEFORE CONSTRUCT
               #获取当前日期
               LET g_edate = GET_FLDBUF(edate)
               IF g_edate IS NULL THEN            
                  DISPlAY g_today TO edate
               END IF               
    
         END CONSTRUCT         
         #end add-point
     
         DISPLAY ARRAY g_rtja_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apcq809_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apcq809_b_fill2()
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
         DISPLAY ARRAY g_rtja2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
               IF g_detail_idx > g_rtja2_d.getLength() THEN
                  LET g_detail_idx = g_rtja2_d.getLength()
               END IF
               IF g_detail_idx = 0 AND g_rtja2_d.getLength() <> 0 THEN
                  LET g_detail_idx = 1
               END IF
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_rtja2_d.getLength() TO FORMONLY.h_count
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
 
         END DISPLAY
         DISPLAY ARRAY g_rtja3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW    
               LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
               IF g_detail_idx > g_rtja3_d.getLength() THEN
                  LET g_detail_idx = g_rtja3_d.getLength()
               END IF
               IF g_detail_idx = 0 AND g_rtja3_d.getLength() <> 0 THEN
                  LET g_detail_idx = 1
               END IF
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_rtja3_d.getLength() TO FORMONLY.h_count  
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
 
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apcq809_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
 
            #end add-point
            NEXT FIELD rtjasite
 
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
            LET g_sdate1 = GET_FLDBUF(sdate)
            LET g_edate1 = GET_FLDBUF(edate)
            IF g_sdate1 IS NULL  THEN            
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'ast-00468' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CONTINUE DIALOG
            END IF
            IF g_edate1 IS NULL THEN            
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'ast-00469' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CONTINUE DIALOG
            END IF             
            IF g_sdate1 >  g_edate1  THEN            
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'acr-00068' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CONTINUE DIALOG
            END IF 
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL apcq809_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_rtja_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apcq809_b_fill()
 
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
            CALL apcq809_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apcq809_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apcq809_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apcq809_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apcq809_filter()
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
 
{<section id="apcq809.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apcq809_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING 
   DEFINE l_sql           STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where
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
 
   CALL g_rtja_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
   
   
   #新增temp table
   LET l_sql = "INSERT INTO apcq809_tmp(rtjadocno, ",     
               "                        rtjasite,     rtjadocdt,   rtja037,      rtja036,",
               "                        rtja033,      rtja035,     endtime,      scantime,",
               "                        count,        speed,       number_1,       amount,",
               "                        rtja041 )",
               "  VALUES(?, ",
               "         ?,?,?,?,",
               "         ?,?,?,?,",
               "         ?,?,?,?,",
               "         ?)"
   PREPARE apcq809_in_tmp FROM l_sql
   
   DELETE FROM apcq809_tmp
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',rtjadocno,rtjasite,'',rtjadocdt,rtja037,'',rtja036,rtja033,rtja035, 
       '','','','','','',rtja041  ,DENSE_RANK() OVER( ORDER BY rtja_t.rtjadocno) AS RANK FROM rtja_t", 
 
 
 
                     "",
                     " WHERE rtjaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtja_t"),
                     " ORDER BY rtja_t.rtjadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT  UNIQUE 'N',rtjadocno,rtjasite,'',rtjadocdt,rtja037,'',rtja036,rtja033,rtja035, 
       '','','','','1','',rtja041  ,DENSE_RANK() OVER( ORDER BY rtja_t.rtjadocno) AS RANK FROM rtja_t", 

 
 
                     "",
                     " WHERE rtjaent= ? AND 1=1 AND ", ls_wc," AND rtjadocdt >=  to_date('",g_wc_sdate,"','yyyy/mm/dd') AND  rtjadocdt <= to_date('",g_wc_edate,"','yyyy/mm/dd') "
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtja_t"),
                     " ORDER BY rtja_t.rtjadocno"
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
 
   LET g_sql = "SELECT '',rtjadocno,rtjasite,'',rtjadocdt,rtja037,'',rtja036,rtja033,rtja035,'','','', 
       '','','',rtja041",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT 'N',rtjadocno,rtjasite,'',rtjadocdt,rtja037,'',rtja036,rtja033,rtja035,'','','', 
       '','1','',rtja041",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apcq809_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apcq809_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtja_d[l_ac].sel,g_rtja_d[l_ac].rtjadocno,g_rtja_d[l_ac].rtjasite,g_rtja_d[l_ac].rtjasite_desc, 
       g_rtja_d[l_ac].rtjadocdt,g_rtja_d[l_ac].rtja037,g_rtja_d[l_ac].rtja037_desc,g_rtja_d[l_ac].rtja036, 
       g_rtja_d[l_ac].rtja033,g_rtja_d[l_ac].rtja035,g_rtja_d[l_ac].endtime,g_rtja_d[l_ac].scantime, 
       g_rtja_d[l_ac].count,g_rtja_d[l_ac].speed,g_rtja_d[l_ac].number,g_rtja_d[l_ac].amount,g_rtja_d[l_ac].rtja041 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #结束时间: 
      SELECT MAX(rtjf026) INTO g_rtja_d[l_ac].endtime 
        FROM rtjf_t 
       WHERE rtjfdocno = g_rtja_d[l_ac].rtjadocno 
         AND rtjfent = g_enterprise
         AND rownum =1  
      #扫描时间=结束时间-开始时间
      IF g_rtja_d[l_ac].rtja035 IS NOT NULL AND g_rtja_d[l_ac].endtime IS NOT NULL THEN
         LET l_sql = " SELECT (TO_DATE('",g_rtja_d[l_ac].endtime,"','hh24-mi-ss') - TO_DATE('",g_rtja_d[l_ac].rtja035,"','hh24-mi-ss')) * 24 * 60 * 60 FROM DUAL"
         PREPARE scantime_pre FROM l_sql
         EXECUTE scantime_pre INTO g_rtja_d[l_ac].scantime   
         SELECT ROUND(g_rtja_d[l_ac].scantime,0) INTO g_rtja_d[l_ac].scantime FROM DUAL  
      ELSE
         LET g_rtja_d[l_ac].scantime = 0
         SELECT ROUND(g_rtja_d[l_ac].scantime,0) INTO g_rtja_d[l_ac].scantime FROM DUAL        
      END IF         
      #扫描/手输商品件数：
       SELECT COUNT(*) INTO g_rtja_d[l_ac].count
         FROM rtjb_t 
        WHERE rtjbdocno = g_rtja_d[l_ac].rtjadocno 
          AND rtjbent = g_enterprise   
      #件数/分钟=商品件数/扫描时间×60
      LET g_rtja_d[l_ac].speed = g_rtja_d[l_ac].count/g_rtja_d[l_ac].scantime*60
      SELECT ROUND(g_rtja_d[l_ac].speed,2) INTO g_rtja_d[l_ac].speed FROM DUAL 
      #单数/小时=收款单数/扫描时间*60*60
      LET g_rtja_d[l_ac].amount = g_rtja_d[l_ac].number/g_rtja_d[l_ac].scantime*60*60 
      SELECT ROUND(g_rtja_d[l_ac].amount,2) INTO g_rtja_d[l_ac].amount FROM DUAL      
      
      #新增 temp table
      EXECUTE apcq809_in_tmp USING g_rtja_d[l_ac].rtjadocno,   g_rtja_d[l_ac].rtjasite,   g_rtja_d[l_ac].rtjadocdt,
                                   g_rtja_d[l_ac].rtja037,     g_rtja_d[l_ac].rtja036,    g_rtja_d[l_ac].rtja033,
                                   g_rtja_d[l_ac].rtja035,     g_rtja_d[l_ac].endtime,    g_rtja_d[l_ac].scantime,
                                   g_rtja_d[l_ac].count,       g_rtja_d[l_ac].speed,      g_rtja_d[l_ac].number,
                                   g_rtja_d[l_ac].amount,      g_rtja_d[l_ac].rtja041 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins apcq809_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #end add-point
 
      CALL apcq809_detail_show("'1'")
 
      CALL apcq809_rtja_t_mask()
 
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
   CALL apcq809_b2_fill()
   CALL apcq809_b3_fill()
   #end add-point
 
   CALL g_rtja_d.deleteElement(g_rtja_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtja_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apcq809_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apcq809_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apcq809_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtja_d.getLength() > 0 THEN
      CALL apcq809_b_fill2()
   END IF
 
      CALL apcq809_filter_show('rtjadocno','b_rtjadocno')
   CALL apcq809_filter_show('rtjasite','b_rtjasite')
   CALL apcq809_filter_show('rtjadocdt','b_rtjadocdt')
   CALL apcq809_filter_show('rtja037','b_rtja037')
   CALL apcq809_filter_show('rtja036','b_rtja036')
   CALL apcq809_filter_show('rtja033','b_rtja033')
   CALL apcq809_filter_show('rtja035','b_rtja035')
   CALL apcq809_filter_show('rtja041','b_rtja041')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apcq809.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apcq809_b_fill2()
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
 
{<section id="apcq809.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apcq809_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_rtja_d[l_ac].rtjasite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtja_d[l_ac].rtjasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtja_d[l_ac].rtjasite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtja_d[l_ac].rtja037
            LET ls_sql = "SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtja_d[l_ac].rtja037_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtja_d[l_ac].rtja037_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apcq809.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apcq809_filter()
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
      CONSTRUCT g_wc_filter ON rtjadocno,rtjasite,rtjadocdt,rtja037,rtja036,rtja033,rtja035,rtja041
                          FROM s_detail1[1].b_rtjadocno,s_detail1[1].b_rtjasite,s_detail1[1].b_rtjadocdt, 
                              s_detail1[1].b_rtja037,s_detail1[1].b_rtja036,s_detail1[1].b_rtja033,s_detail1[1].b_rtja035, 
                              s_detail1[1].b_rtja041
 
         BEFORE CONSTRUCT
                     DISPLAY apcq809_filter_parser('rtjadocno') TO s_detail1[1].b_rtjadocno
            DISPLAY apcq809_filter_parser('rtjasite') TO s_detail1[1].b_rtjasite
            DISPLAY apcq809_filter_parser('rtjadocdt') TO s_detail1[1].b_rtjadocdt
            DISPLAY apcq809_filter_parser('rtja037') TO s_detail1[1].b_rtja037
            DISPLAY apcq809_filter_parser('rtja036') TO s_detail1[1].b_rtja036
            DISPLAY apcq809_filter_parser('rtja033') TO s_detail1[1].b_rtja033
            DISPLAY apcq809_filter_parser('rtja035') TO s_detail1[1].b_rtja035
            DISPLAY apcq809_filter_parser('rtja041') TO s_detail1[1].b_rtja041
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_rtjadocno>>----
         #Ctrlp:construct.c.page1.b_rtjadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocno
            #add-point:ON ACTION controlp INFIELD b_rtjadocno name="construct.c.filter.page1.b_rtjadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtjadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjadocno  #顯示到畫面上
            NEXT FIELD b_rtjadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtjasite>>----
         #Ctrlp:construct.c.page1.b_rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjasite
            #add-point:ON ACTION controlp INFIELD b_rtjasite name="construct.c.filter.page1.b_rtjasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjasite  #顯示到畫面上
            NEXT FIELD b_rtjasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtjasite_desc>>----
         #----<<b_rtjadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocdt
            #add-point:ON ACTION controlp INFIELD b_rtjadocdt name="construct.c.filter.page1.b_rtjadocdt"
            
            #END add-point
 
 
         #----<<b_rtja037>>----
         #Ctrlp:construct.c.filter.page1.b_rtja037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja037
            #add-point:ON ACTION controlp INFIELD b_rtja037 name="construct.c.filter.page1.b_rtja037"
            
            #END add-point
 
 
         #----<<b_rtja037_desc>>----
         #----<<b_rtja036>>----
         #Ctrlp:construct.c.filter.page1.b_rtja036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja036
            #add-point:ON ACTION controlp INFIELD b_rtja036 name="construct.c.filter.page1.b_rtja036"
            
            #END add-point
 
 
         #----<<b_rtja033>>----
         #Ctrlp:construct.c.filter.page1.b_rtja033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja033
            #add-point:ON ACTION controlp INFIELD b_rtja033 name="construct.c.filter.page1.b_rtja033"
            
            #END add-point
 
 
         #----<<b_rtja035>>----
         #Ctrlp:construct.c.filter.page1.b_rtja035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja035
            #add-point:ON ACTION controlp INFIELD b_rtja035 name="construct.c.filter.page1.b_rtja035"
            
            #END add-point
 
 
         #----<<b_endtime>>----
         #----<<scantime>>----
         #----<<count>>----
         #----<<speed>>----
         #----<<number>>----
         #----<<amount>>----
         #----<<b_rtja041>>----
         #Ctrlp:construct.c.filter.page1.b_rtja041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja041
            #add-point:ON ACTION controlp INFIELD b_rtja041 name="construct.c.filter.page1.b_rtja041"
            
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
 
      CALL apcq809_filter_show('rtjadocno','b_rtjadocno')
   CALL apcq809_filter_show('rtjasite','b_rtjasite')
   CALL apcq809_filter_show('rtjadocdt','b_rtjadocdt')
   CALL apcq809_filter_show('rtja037','b_rtja037')
   CALL apcq809_filter_show('rtja036','b_rtja036')
   CALL apcq809_filter_show('rtja033','b_rtja033')
   CALL apcq809_filter_show('rtja035','b_rtja035')
   CALL apcq809_filter_show('rtja041','b_rtja041')
 
 
   CALL apcq809_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apcq809.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apcq809_filter_parser(ps_field)
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
 
{<section id="apcq809.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apcq809_filter_show(ps_field,ps_object)
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
   LET ls_condition = apcq809_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apcq809.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apcq809_detail_action_trans()
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
 
{<section id="apcq809.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apcq809_detail_index_setting()
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
            IF g_rtja_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtja_d.getLength() AND g_rtja_d.getLength() > 0
            LET g_detail_idx = g_rtja_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtja_d.getLength() THEN
               LET g_detail_idx = g_rtja_d.getLength()
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
 
{<section id="apcq809.mask_functions" >}
 &include "erp/apc/apcq809_mask.4gl"
 
{</section>}
 
{<section id="apcq809.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 日匯總
# Memo...........:
# Date & Author..: 20151009 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apcq809_b2_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING 
   DEFINE l_sql           STRING
   DEFINE ls_sql     STRING
   
   CALL g_rtja2_d.clear()
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1

   LET g_sql = "SELECT  UNIQUE 'N',rtjasite,'',rtjadocdt,rtja037,'',MIN(rtja035), 
                      '',SUM(scantime),SUM(count),'',SUM(number_1),'','' FROM apcq809_tmp", 
                     " GROUP BY rtjasite,rtjadocdt,rtja037",
                     " ORDER BY rtjasite,rtjadocdt"
 
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apcq809_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR apcq809_pb1
 
   OPEN b_fill_curs1 
 
   FOREACH b_fill_curs1 INTO g_rtja2_d[l_ac].sel_1,      g_rtja2_d[l_ac].rtjasite_1,      g_rtja2_d[l_ac].rtjasite_1_desc, 
                             g_rtja2_d[l_ac].rtjadocdt_1,g_rtja2_d[l_ac].rtja037_1,       g_rtja2_d[l_ac].rtja037_1_desc,
                             g_rtja2_d[l_ac].rtja035_1,  g_rtja2_d[l_ac].endtime_1,       g_rtja2_d[l_ac].scantime_1, 
                             g_rtja2_d[l_ac].count_1,    g_rtja2_d[l_ac].speed_1,         g_rtja2_d[l_ac].number_1,
                             g_rtja2_d[l_ac].amount_1,   g_rtja2_d[l_ac].rtja041_1 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充
      #查询结束时间点
      SELECT  MAX(rtjf026) INTO g_rtja2_d[l_ac].endtime_1
        FROM rtjf_t,rtja_t 
       WHERE rtjfent = rtjaent 
         AND rtjfdocno = rtjadocno 
         AND rtjadocdt = g_rtja2_d[l_ac].rtjadocdt_1
         AND rtjasite = g_rtja2_d[l_ac].rtjasite_1
         AND rtja037 = g_rtja2_d[l_ac].rtja037_1
     
      #件数/分钟=商品件数/扫描时间×60
      LET g_rtja2_d[l_ac].speed_1 = g_rtja2_d[l_ac].count_1/g_rtja2_d[l_ac].scantime_1*60
      SELECT ROUND(g_rtja2_d[l_ac].speed_1,2) INTO g_rtja2_d[l_ac].speed_1 FROM DUAL 
      #单数/小时=收款单数/扫描时间*60*60
      LET g_rtja2_d[l_ac].amount_1 = g_rtja2_d[l_ac].number_1/g_rtja2_d[l_ac].scantime_1*60*60 
      SELECT ROUND(g_rtja2_d[l_ac].amount_1,2) INTO g_rtja2_d[l_ac].amount_1 FROM DUAL     
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtja2_d[l_ac].rtjasite_1
      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_rtja2_d[l_ac].rtjasite_1_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtja2_d[l_ac].rtjasite_1_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtja2_d[l_ac].rtja037_1
      LET ls_sql = "SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? "
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_rtja2_d[l_ac].rtja037_1_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtja2_d[l_ac].rtja037_1_desc  
      #end add-point
 
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

   CALL g_rtja2_d.deleteElement(g_rtja2_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtja2_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:2)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs1
   FREE apcq809_pb1
 
 
   LET l_ac = 1

END FUNCTION

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL apcq809_create_tmp()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/10/10 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apcq809_create_tmp()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   CALL apcq809_drop_tmp() 
   CREATE TEMP TABLE apcq809_tmp(
      rtjadocno   VARCHAR(20), 
      rtjasite    VARCHAR(10), 
      rtjadocdt   DATE, 
      rtja037     VARCHAR(20), 
      rtja036     VARCHAR(10), 
      rtja033     VARCHAR(20), 
      rtja035     VARCHAR(8), 
      endtime     VARCHAR(500), 
      scantime    DECIMAL(20,6), 
      count       DECIMAL(20,6), 
      speed       DECIMAL(20,6), 
      number_1    DECIMAL(20,6), 
      amount      DECIMAL(20,6), 
      rtja041     VARCHAR(255))     

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create apcq809_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table
# Memo...........:
# Usage..........: CALL apcq809_drop_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/10/10 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apcq809_drop_tmp()
   DROP TABLE apcq809_tmp
END FUNCTION

################################################################################
# Descriptions...: 月匯總
# Memo...........:
# Date & Author..: 20151010 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apcq809_b3_fill()
DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING 
   DEFINE l_sql           STRING
   DEFINE ls_sql     STRING
   
   CALL g_rtja3_d.clear()
   
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1

   LET g_sql = "SELECT  UNIQUE 'N',rtjasite,'',substr(to_date(rtjadocdt,'yyyy/mm/dd'),1,7),rtja037,'',
                     SUM(scantime),SUM(count),'',SUM(number_1),'','' FROM apcq809_tmp", 
                     " GROUP BY rtjasite,substr(to_date(rtjadocdt,'yyyy/mm/dd'),1,7),rtja037",
                     " ORDER BY rtjasite,substr(to_date(rtjadocdt,'yyyy/mm/dd'),1,7),rtja037"
 
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apcq809_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apcq809_pb2
   OPEN b_fill_curs2 
   
   FOREACH b_fill_curs2 INTO g_rtja3_d[l_ac].sel_2,      g_rtja3_d[l_ac].rtjasite_2,      g_rtja3_d[l_ac].rtjasite_2_desc, 
                             g_rtja3_d[l_ac].yearmonth,  g_rtja3_d[l_ac].rtja037_2,       g_rtja3_d[l_ac].rtja037_2_desc,
                             g_rtja3_d[l_ac].scantime_2, g_rtja3_d[l_ac].count_2,         g_rtja3_d[l_ac].speed_2,        
                             g_rtja3_d[l_ac].number_2,   g_rtja3_d[l_ac].amount_2,        g_rtja3_d[l_ac].rtja041_2

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充
      #件数/分钟=商品件数/扫描时间×60
      LET g_rtja3_d[l_ac].speed_2 = g_rtja3_d[l_ac].count_2/g_rtja3_d[l_ac].scantime_2*60
      SELECT ROUND(g_rtja3_d[l_ac].speed_2,2) INTO g_rtja3_d[l_ac].speed_2 FROM DUAL 
      #单数/小时=收款单数/扫描时间*60*60
      LET g_rtja3_d[l_ac].amount_2 = g_rtja3_d[l_ac].number_2/g_rtja3_d[l_ac].scantime_2*60*60 
      SELECT ROUND(g_rtja3_d[l_ac].amount_2,2) INTO g_rtja3_d[l_ac].amount_2 FROM DUAL    
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtja3_d[l_ac].rtjasite_2
      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_rtja3_d[l_ac].rtjasite_2_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtja3_d[l_ac].rtjasite_2_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtja3_d[l_ac].rtja037_2
      LET ls_sql = "SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? "
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_rtja3_d[l_ac].rtja037_2_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtja3_d[l_ac].rtja037_2_desc  
      #end add-point
 
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

   CALL g_rtja3_d.deleteElement(g_rtja3_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtja3_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:2)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs2
   FREE apcq809_pb2
 
 
   LET l_ac = 1

END FUNCTION

 
{</section>}
 
