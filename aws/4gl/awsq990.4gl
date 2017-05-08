#該程式未解開Section, 採用最新樣板產出!
{<section id="awsq990.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-08-10 15:35:28), PR版次:0001(2016-12-05 10:04:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: awsq990
#+ Description: 整合檢測工具
#+ Creator....: 08163(2016-08-10 15:35:28)
#+ Modifier...: 08163 -SD/PR- 08163
 
{</section>}
 
{<section id="awsq990.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160810-00029  by Hank Wu
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT com
IMPORT XML
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單頭 type 宣告
PRIVATE type type_g_wsfa_m        RECORD
       l_location LIKE type_t.chr500,
       l_originator LIKE type_t.chr500,
       wsfa003 LIKE wsfa_t.wsfa003,
       wsfa004 LIKE wsfa_t.wsfa004,
       l_datakey LIKE type_t.chr500,
       wsfa002 LIKE wsfa_t.wsfa002,
       wsfa001 LIKE wsfa_t.wsfa001,
       l_result LIKE type_t.chr500       
       END RECORD
PRIVATE type type_g_wsfa2_m        RECORD
       wsfc001 LIKE wsfc_t.wsfc001,
       l_way LIKE type_t.chr500,
       l_request STRING,
       l_response STRING
       END RECORD       
PRIVATE type type_g_wsfa3_m        RECORD
       l_cmdContent STRING
       END RECORD         
#單身 type 宣告
PRIVATE TYPE type_g_wsfa_d RECORD
       
   wsfa004 LIKE wsfa_t.wsfa004, 
   originator LIKE type_t.chr500, 
   wsfa001 LIKE wsfa_t.wsfa001, 
   result LIKE wsfa_t.wsfa006, 
   wsfa005 LIKE wsfa_t.wsfa005, 
   wsfa002 LIKE wsfa_t.wsfa002, 
   wsfa003 LIKE wsfa_t.wsfa003
       END RECORD
PRIVATE TYPE type_g_wsfa2_d RECORD
       exetime LIKE type_t.chr500, 
   wsfa001 LIKE wsfa_t.wsfa001, 
   httpcode LIKE type_t.chr500, 
   resultt LIKE type_t.chr500, 
   wsfa005 LIKE wsfa_t.wsfa005
       END RECORD

PRIVATE TYPE type_g_wsfa3_d RECORD
       wsfc002 LIKE wsfc_t.wsfc002, 
   wsfcl004 LIKE wsfcl_t.wsfcl004
       END RECORD
       
DEFINE g_wsfa_m            type_g_wsfa_m
DEFINE g_wsfa_m_o          type_g_wsfa_m
DEFINE g_wsfa2_m           type_g_wsfa2_m
DEFINE g_wsfa2_m_o         type_g_wsfa2_m
DEFINE g_wsfa3_m           type_g_wsfa3_m
DEFINE g_wsfa3_m_o         type_g_wsfa3_m
DEFINE g_wsfa_d            DYNAMIC ARRAY OF type_g_wsfa_d
DEFINE g_wsfa_d_t          type_g_wsfa_d
DEFINE g_wsfa2_d     DYNAMIC ARRAY OF type_g_wsfa2_d
DEFINE g_wsfa2_d_t   type_g_wsfa2_d
 
DEFINE g_wsfa3_d     DYNAMIC ARRAY OF type_g_wsfa3_d
DEFINE g_wsfa3_d_t   type_g_wsfa3_d   

DEFINE g_wc3                 STRING
DEFINE g_wc4                 STRING
DEFINE g_wc5                 STRING
DEFINE g_wc6                 STRING
DEFINE g_wc7                 STRING
DEFINE g_wc8                 STRING
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
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="awsq990.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = " ",
                      " FROM ",
                      " "
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE awsq990_bcl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)     
   PREPARE awsq990_master_referesh FROM g_sql 
   LET g_forupd_sql = ""
   
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE awsq990_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsq990 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsq990_init()
 
      #進入選單 Menu (='N')
      CALL awsq990_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_awsq990
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CLOSE awsq990_cl
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="awsq990.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION awsq990_init()
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
   CALL cl_set_combo_scc('l_result','239') 
   CALL cl_set_combo_scc('l_location','243')
   CALL cl_set_combo_scc('wsfc001','240')
   #end add-point

   CALL awsq990_default_search()
END FUNCTION

PRIVATE FUNCTION awsq990_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"

   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"

   #end add-point


   #add-point:default_search段開始前 name="default_search.before"

   #end add-point

   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " wsfa001 = '", g_argv[01], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " wsfa002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " wsfa003 = '", g_argv[03], "' AND "
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

PRIVATE FUNCTION awsq990_ui_dialog()
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
   DEFINE l_wsfa003 STRING
   DEFINE l_wsfa004 LIKE wsfa_t.wsfa004
   DEFINE l_service LIKE wsfa_t.wsfa001
   DEFINE l_time    LIKE wsfa_t.wsfa005
   DEFINE l_tmp     STRING
   DEFINE l_wseb001 LIKE wseb_t.wseb001
   DEFINE l_wseb002 LIKE wseb_t.wseb002
   DEFINE l_wseb003 LIKE wseb_t.wseb003
   DEFINE p_soap_req STRING
   DEFINE l_res     LIKE wsfa_t.wsfa006
   DEFINE l_startt  LIKE wsfa_t.wsfa003
   DEFINE l_endt    LIKE wsfa_t.wsfa004
   DEFINE l_sql     STRING
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


   CALL awsq990_b_fill()

   WHILE li_exit = FALSE

      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_wsfa_d.clear()
         CALL g_wsfa2_d.clear()

         CALL g_wsfa3_d.clear()


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

         CALL awsq990_init()
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point

         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON l_location,l_originator,wsfa003,wsfa004,l_datakey,wsfa001,l_result  
             
            BEFORE CONSTRUCT
               LET l_ac = 0
               LET g_wsfa_m.wsfa003 = cl_get_timestamp()
               LET g_wsfa_m.wsfa004 = cl_get_timestamp()
               DISPLAY BY NAME g_wsfa_m.wsfa003,g_wsfa_m.wsfa004

               
            ON ACTION controlp INFIELD wsfa001
            #add-point:ON ACTION controlp INFIELD wsef005 name="input.c.page1.wsef005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzja004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO wsfa001  #顯示到畫面上
            NEXT FIELD wsfa001                     #返回原欄位
            #END add-point

         END CONSTRUCT
         
        
         CONSTRUCT BY NAME g_wc3 ON wsfc001,l_way,l_request,l_response

            BEFORE CONSTRUCT
               LET g_wsfa2_m.l_way = "http://10.40.40.18/wt10dev/ws/r/awsp900"
               DISPLAY BY NAME g_wsfa2_m.l_way
         END CONSTRUCT
         
         
         CONSTRUCT BY NAME g_wc4 ON l_awsLog,l_runLog,l_gasLog,l_ipSetting
            
            BEFORE CONSTRUCT
            
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc5 ON l_webService,l_javaApi,l_restful
            
            BEFORE CONSTRUCT
            LET g_wc = ""
            LET g_wc2 = ""  
         END CONSTRUCT
        
        
        
         CONSTRUCT g_wc2 ON wsfc002,wsfcl004
            FROM s_detail1[1].wsfc002,s_detail1[1].wsfcl004 
            BEFORE CONSTRUCT
            
            
            
            
         END CONSTRUCT
#         CONSTRUCT BY NAME g_wc ON l_location,l_originator,wsfa003,wsfa004,l_datakey,wsfa001,l_wsfa003
#         
#         
#         
#         END CONSTRUCT
         #end add-point
         
         DISPLAY ARRAY g_wsfa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL awsq990_detail_action_trans()

               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL awsq990_b_fill2()
               LET g_action_choice = lc_action_choice_old

               #add-point:input段before row name="input.body.before_row"
               
               #end add-point



            #自訂ACTION(detail_show,page_1)


            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point

         END DISPLAY

         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point

         DISPLAY ARRAY g_wsfa2_d TO s_detail2.*
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

         DISPLAY ARRAY g_wsfa3_d TO s_detail3.*
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



         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point

         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL awsq990_detail_action_trans()
            
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL awsq990_detail_show("'1'")
            #end add-point
            --NEXT FIELD l_location

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

            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL awsq990_b_fill()

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
               LET g_export_node[1] = base.typeInfo.create(g_wsfa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_wsfa2_d)
               LET g_export_id[2]   = "s_detail2"

               LET g_export_node[3] = base.typeInfo.create(g_wsfa3_d)
               LET g_export_id[3]   = "s_detail3"


               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION datarefresh   # 重新整理
            CALL awsq990_b_fill()

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
            CALL awsq990_b_fill()

         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL awsq990_b_fill()

         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL awsq990_b_fill()

         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL awsq990_b_fill()


         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL awsq990_filter()
            #add-point:ON ACTION filter name="menu.filter"

            #END add-point
            EXIT DIALOG





         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_exeAll
            LET g_action_choice="btn_exeAll"
            IF cl_auth_chk_act("btn_exeAll") THEN

               #add-point:ON ACTION btn_exeAll name="menu.btn_exeAll"
#               CALL awsq990_tail_log() RETURNING g_wsfa3_m.l_cmdContent
#               DISPLAY BY NAME g_wsfa3_m.l_cmdContent
               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_msgcontent
            LET g_action_choice="btn_msgcontent"
            IF cl_auth_chk_act("btn_msgcontent") THEN

               #add-point:ON ACTION btn_msgcontent name="menu.btn_msgcontent"
               CALL awsq990_01(g_wsfa_m.wsfa001,g_wsfa_m.wsfa003,g_wsfa_m.wsfa004)
               DISPLAY "awsq990_01(g_wsfa_m.wsfa001)"
               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_test_03
            LET g_action_choice="btn_test_03"
            IF cl_auth_chk_act("btn_test_03") THEN

               #add-point:ON ACTION btn_test_03 name="menu.btn_test_03"

               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_createRequestKey
            LET g_action_choice="btn_createRequestKey"
            IF cl_auth_chk_act("btn_createRequestKey") THEN

               #add-point:ON ACTION btn_createRequestKey name="menu.btn_createRequestKey"

               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_test
            
            LET g_action_choice="btn_test"
            IF cl_auth_chk_act("btn_test") THEN

               #add-point:ON ACTION btn_test name="menu.btn_test"
               
               LET g_wsfa2_m_o.l_request = cl_replace_str(g_wsfa2_m_o.l_request,"<","&lt;")
               LET g_wsfa2_m_o.l_request = cl_replace_str(g_wsfa2_m_o.l_request,">","&gt;")
               LET p_soap_req = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"  xmlns:tip=\"http://www.digiwin.com.cn/tiptop/TIPTOPServiceGateWay\">",ASCII 10,"
     <soapenv:Header/>",ASCII 10,"
     <soapenv:Body>",ASCII 10,"
        <tip:invokeSrv>",ASCII 10,"
           <request>",ASCII 10,
              g_wsfa2_m_o.l_request,ASCII 10,"
           </request>",ASCII 10,"
        </tip:invokeSrv>",ASCII 10,"
     </soapenv:Body>",ASCII 10,"
  </soapenv:Envelope>" 
               CALL awsq990_req_test(g_wsfa2_m.l_way,p_soap_req) RETURNING g_wsfa2_m.l_response
               DISPLAY "--btn_test--(g_wsfa2_m.l_response): ",g_wsfa2_m.l_response
               
               
               DISPLAY BY NAME g_wsfa2_m.l_response
               --LET l_ac = l_ac + 1
               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN

               #add-point:ON ACTION insert name="menu.insert"

               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_exportResult
            LET g_action_choice="btn_exportResult"
            IF cl_auth_chk_act("btn_exportResult") THEN

               #add-point:ON ACTION btn_exportResult name="menu.btn_exportResult"

               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_save
            LET g_action_choice="btn_save"
            IF cl_auth_chk_act("btn_save") THEN

               #add-point:ON ACTION btn_save name="menu.btn_save"

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
         ON ACTION btn_defaultTemp
            LET g_action_choice="btn_defaultTemp"
            IF cl_auth_chk_act("btn_defaultTemp") THEN

               #add-point:ON ACTION btn_defaultTemp name="menu.btn_defaultTemp"
               
               
               DISPLAY "---- btn_defaultTemp ----"
               CALL awsq990_afterField(2)
               CALL awsq990_generate_req(g_wsfa2_m_o.wsfc001) RETURNING g_wsfa2_m.l_request
               LET g_wsfa2_m_o.l_request = g_wsfa2_m.l_request
               DISPLAY BY NAME g_wsfa2_m.l_request
               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_exe
            LET g_action_choice="btn_exe"
            IF cl_auth_chk_act("btn_exe") THEN

               #add-point:ON ACTION btn_exe name="menu.btn_exe"

               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN

               #add-point:ON ACTION query name="menu.query"
               --CALL awsq990_construct()
               
               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_test_02
            LET g_action_choice="btn_test_02"
            IF cl_auth_chk_act("btn_test_02") THEN

               #add-point:ON ACTION btn_test_02 name="menu.btn_test_02"

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
         ON ACTION btn_bgResult
            LET g_action_choice="btn_bgResult"
            IF cl_auth_chk_act("btn_bgResult") THEN

               #add-point:ON ACTION btn_bgResult name="menu.btn_bgResult"

               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_test_01
            LET g_action_choice="btn_test_01"
            IF cl_auth_chk_act("btn_test_01") THEN

               #add-point:ON ACTION btn_test_01 name="menu.btn_test_01"

               #END add-point


            END IF




         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_query
            LET g_action_choice="btn_query"
            IF cl_auth_chk_act("btn_query") THEN

               #add-point:ON ACTION btn_query name="menu.btn_query"
                  LET l_ac = 1
                  CALL　awsq990_afterField(1)
                  DISPLAY "g_wsfa_m.wsfa003 = ",g_wsfa_m.wsfa003
                  DISPLAY "g_wsfa_m.wsfa004 = ",g_wsfa_m.wsfa004
                  DISPLAY "g_wsfa_m.l_originator = ",g_wsfa_m.l_originator
                  LET l_sql ="SELECT wsfa001,wsfa005,wsfa006 FROM wsfa_t
                              WHERE (wsfa001 = ?) OR (wsfa003 >= ?) AND (wsfa004 <= ?) OR (wsfa006 = ?)"
                  PREPARE awsq990_pre_01 FROM l_sql
                  DECLARE awsq990_cur CURSOR FOR awsq990_pre_01
                  
                  SELECT wsfa001,wsfa005,wsfa006,wsfa004
                  INTO l_service,l_time,l_res,l_wsfa004
                  FROM wsfa_t
                  WHERE wsfa001 = g_wsfa_m.wsfa001 OR wsfa003 >= g_wsfa_m.wsfa003 AND wsfa004 <= g_wsfa_m.wsfa004 OR wsfa006 = g_wsfa_m.l_result 
                  IF cl_null(l_service) THEN 
                     INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = -100
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()       
                           NEXT FIELD CURRENT 
                  ELSE        
                     FOREACH awsq990_cur USING g_wsfa_m.wsfa001,g_wsfa_m.wsfa003,g_wsfa_m.wsfa004,g_wsfa_m.l_result INTO g_wsfa_d[l_ac].wsfa001,g_wsfa_d[l_ac].wsfa005,g_wsfa_d[l_ac].result,g_wsfa_d[l_ac].wsfa004
                        DISPLAY "g_wsfa_d[l_ac].wsfa004",g_wsfa_d[l_ac].wsfa004
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           EXIT FOREACH
                        END IF
#                        LET l_service = g_wsfa_d[l_ac].wsfa001
#                        IF cl_null(l_service) THEN                   
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.extend = ""
#                           LET g_errparam.code   = -100
#                           LET g_errparam.popup  = TRUE
#                           CALL cl_err()       
#                           NEXT FIELD CURRENT                     
#                        ELSE                    
                           LET g_wsfa_d[l_ac].originator = g_wsfa_m.l_originator
                           
                           DISPLAY BY NAME g_wsfa_d[l_ac].originator  
                           LET l_wsfa004 = ""                           
                           LET l_service = ""
                           LET l_time = ""
                           LET l_res = ""

                        LET l_ac = l_ac +1
                     END FOREACH  
                  END IF   
                  CALL g_wsfa_d.deleteElement(g_wsfa_d.getLength())
#                  SELECT wsfa001,wsfa005,wsfa006
#                     INTO l_service,l_time,l_res
#                  FROM wsfa_t
#                  WHERE (wsfa001 = g_wsfa_m.wsfa001) OR (wsfa003 >= g_wsfa_m.wsfa003) AND (wsfa004 <= g_wsfa_m.wsfa004) OR (wsfa006 = g_wsfa_m.l_result)
                  
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

PRIVATE FUNCTION awsq990_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"

   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"

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

   CALL g_wsfa_d.clear()
   CALL g_wsfa2_d.clear()

   CALL g_wsfa3_d.clear()


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
   LET ls_sql_rank = "SELECT  UNIQUE '','',wsfa001,'',wsfa005,wsfa002,wsfa003,'','','','','','',''  ,
       DENSE_RANK() OVER( ORDER BY wsfa_t.wsfa001,wsfa_t.wsfa002,wsfa_t.wsfa003) AS RANK FROM wsfa_t",



                     " LEFT JOIN wsfc_t ON wsfa001 = wsfc001 AND wsfa002 = wsfc002wsfa003 =  LEFT JOIN wsfcl_t ON wsfa001 = wsfcl001 AND wsfa002 = wsfcl002 AND wsfa003 = wsfcl003",
                     " WHERE 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("wsfa_t"),
                     " ORDER BY wsfa_t.wsfa001,wsfa_t.wsfa002,wsfa_t.wsfa003"

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

   LET g_sql = "SELECT '','',wsfa001,'',wsfa005,wsfa002,wsfa003,'','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page

   #add-point:b_fill段sql_after name="b_fill.sql_after"

   #end add-point

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE awsq990_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR awsq990_pb

   OPEN b_fill_curs

   FOREACH b_fill_curs INTO g_wsfa_d[l_ac].wsfa004,g_wsfa_d[l_ac].originator,g_wsfa_d[l_ac].wsfa001,
       g_wsfa_d[l_ac].result,g_wsfa_d[l_ac].wsfa005,g_wsfa_d[l_ac].wsfa002,g_wsfa_d[l_ac].wsfa003,g_wsfa2_d[l_ac].exetime,
       g_wsfa2_d[l_ac].wsfa001,g_wsfa2_d[l_ac].httpcode,g_wsfa2_d[l_ac].resultt,g_wsfa2_d[l_ac].wsfa005,
       g_wsfa3_d[l_ac].wsfc002,g_wsfa3_d[l_ac].wsfcl004
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

      CALL awsq990_detail_show("'1'")
      --CALL awsq990_wsfa_t_mask()

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

   CALL g_wsfa_d.deleteElement(g_wsfa_d.getLength())
   CALL g_wsfa2_d.deleteElement(g_wsfa2_d.getLength())

   CALL g_wsfa3_d.deleteElement(g_wsfa3_d.getLength())


   #add-point:陣列長度調整 name="b_fill.array_deleteElement"

   #end add-point

   LET g_error_show = 0

   LET g_detail_cnt = g_wsfa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0

   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE awsq990_pb






   #調整單身index指標，避免翻頁後指到空白筆數
   CALL awsq990_detail_index_setting()

   #重新計算單身筆數並呈現
   CALL awsq990_detail_action_trans()

   LET l_ac = 1
   IF g_wsfa_d.getLength() > 0 THEN
      CALL awsq990_b_fill2()
   END IF

      CALL awsq990_filter_show('wsfa001','b_wsfa001')
   CALL awsq990_filter_show('wsfa005','b_wsfa005')
   CALL awsq990_filter_show('wsfa002','b_wsfa002')
   CALL awsq990_filter_show('wsfa003','b_wsfa003')
   CALL awsq990_filter_show('wsfc002','b_wsfc002')
   CALL awsq990_filter_show('wsfcl004','b_wsfcl004')


END FUNCTION

PRIVATE FUNCTION awsq990_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"

   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"

   #end add-point

   #add-point:FUNCTION前置處理 name="b_fill2.before_function"

   #end add-point

   LET li_ac = l_ac

   #單身組成
   #應用 qs07 樣板自動產生(Version:6)
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

PRIVATE FUNCTION awsq990_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"

   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
#   wsfc002 LIKE wsfc_t.wsfc002, 
#   wsfcl004 LIKE wsfcl_t.wsfcl004
   DEFINE ls_max_cnt LIKE type_t.num10
   DEFINE l_ac       LIKE type_t.num10
   DEFINE l_wsfc002  LIKE wsfc_t.wsfc002
   DEFINE l_wsfc001  LIKE wsfc_t.wsfc001
   #end add-point

   #add-point:detail_show段之前 name="detail_show.before"
   LET l_ac = 1
   LET ls_sql = "SELECT COUNT(1)",
                "FROM wsfc_t"
   PREPARE awsq990_pre FROM ls_sql
   EXECUTE awsq990_pre INTO ls_max_cnt
     
   
   LET ls_sql = "select wsfc002 from wsfc_t"
   PREPARE awsq990_1 FROM ls_sql
   DECLARE awsq990_2 CURSOR FOR awsq990_1   
   
   
   FOREACH awsq990_2 INTO g_wsfa3_d[l_ac].wsfc002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.extend = 'FOREACH:awsq990_2'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    
      IF (l_ac >ls_max_cnt) THEN
         CALL g_wsfa3_d.deleteElement(l_ac)
         EXIT FOREACH
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_wsfa3_d[l_ac].wsfc002
      CALL ap_ref_array2(g_ref_fields," SELECT wsfcl004 FROM wsfcl_t WHERE wsfcl002 = ? AND wsfcl003 = '"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_wsfa3_d[l_ac].wsfcl004 = g_rtn_fields[1]
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   
   
   DISPLAY BY NAME g_wsfa3_d[l_ac].wsfc002,g_wsfa3_d[l_ac].wsfcl004
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

#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_wsfa_d[l_ac].wsfa001
#   LET g_ref_fields[2] = g_wsfa_d[l_ac].wsfa002
#   LET g_ref_fields[3] = g_wsfa_d[l_ac].wsfa003
#   LET ls_sql = " SELECT wsfc002 FROM wsfc_t WHERE wsfc001 = ? AND wsfc002 = ? "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#   LET g_wsfa3_d[l_ac].wsfc002 = g_rtn_fields[1]
#   DISPLAY BY NAME g_wsfa3_d[l_ac].wsfc002
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_wsfa_d[l_ac].wsfa001
#   LET g_ref_fields[2] = g_wsfa_d[l_ac].wsfa002
#   LET g_ref_fields[3] = g_wsfa_d[l_ac].wsfa003
#   LET ls_sql = " SELECT wsfc002,wsfcl004 FROM wsfcl_t WHERE wsfcl001 = ? AND wsfcl002 = ? AND wsfcl003 = ? "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#   LET g_wsfa3_d[l_ac].wsfc002 = g_rtn_fields[1]
#   LET g_wsfa3_d[l_ac].wsfcl004 = g_rtn_fields[2]
#   DISPLAY BY NAME g_wsfa3_d[l_ac].wsfc002,g_wsfa3_d[l_ac].wsfcl004
      #end add-point
   END IF



   #add-point:detail_show段之後 name="detail_show.after"

   #end add-point

END FUNCTION

PRIVATE FUNCTION awsq990_filter()
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
      CONSTRUCT g_wc_filter ON wsfa001,wsfa005,wsfa002,wsfa003,wsfc002,wsfcl004
                          FROM s_detail1[1].b_wsfa001,s_detail1[1].b_wsfa005,s_detail1[1].b_wsfa002,
                              s_detail1[1].b_wsfa003,s_detail3[1].b_wsfc002,s_detail3[1].b_wsfcl004

         BEFORE CONSTRUCT
                     DISPLAY awsq990_filter_parser('wsfa001') TO s_detail1[1].b_wsfa001
            DISPLAY awsq990_filter_parser('wsfa005') TO s_detail1[1].b_wsfa005
            DISPLAY awsq990_filter_parser('wsfa002') TO s_detail1[1].b_wsfa002
            DISPLAY awsq990_filter_parser('wsfa003') TO s_detail1[1].b_wsfa003
            DISPLAY awsq990_filter_parser('wsfc002') TO s_detail3[1].b_wsfc002
            DISPLAY awsq990_filter_parser('wsfcl004') TO s_detail3[1].b_wsfcl004


         #單身公用欄位開窗相關處理


         #單身一般欄位開窗相關處理
                  #----<<b_msgexetime>>----
         #----<<b_originator>>----
         #----<<b_wsfa001>>----
         #Ctrlp:construct.c.filter.page1.b_wsfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsfa001
            #add-point:ON ACTION controlp INFIELD b_wsfa001 name="construct.c.filter.page1.b_wsfa001"

            #END add-point


         #----<<b_result>>----
         #----<<b_wsfa005>>----
         #Ctrlp:construct.c.filter.page1.b_wsfa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsfa005
            #add-point:ON ACTION controlp INFIELD b_wsfa005 name="construct.c.filter.page1.b_wsfa005"

            #END add-point


         #----<<b_wsfa002>>----
         #Ctrlp:construct.c.filter.page1.b_wsfa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsfa002
            #add-point:ON ACTION controlp INFIELD b_wsfa002 name="construct.c.filter.page1.b_wsfa002"

            #END add-point


         #----<<b_wsfa003>>----
         #Ctrlp:construct.c.filter.page1.b_wsfa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsfa003
            #add-point:ON ACTION controlp INFIELD b_wsfa003 name="construct.c.filter.page1.b_wsfa003"

            #END add-point


         #----<<b_exetime>>----
         #----<<b_wsfa001_01>>----
         #----<<b_httpcode>>----
         #----<<b_resultt>>----
         #----<<b_wsfa005_01>>----
         #----<<b_wsfc002>>----
         #Ctrlp:construct.c.filter.page3.b_wsfc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsfc002
            #add-point:ON ACTION controlp INFIELD b_wsfc002 name="construct.c.filter.page3.b_wsfc002"

            #END add-point


         #----<<b_wsfcl004>>----
         #Ctrlp:construct.c.filter.page3.b_wsfcl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsfcl004
            #add-point:ON ACTION controlp INFIELD b_wsfcl004 name="construct.c.filter.page3.b_wsfcl004"

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

      CALL awsq990_filter_show('wsfa001','b_wsfa001')
   CALL awsq990_filter_show('wsfa005','b_wsfa005')
   CALL awsq990_filter_show('wsfa002','b_wsfa002')
   CALL awsq990_filter_show('wsfa003','b_wsfa003')
   CALL awsq990_filter_show('wsfc002','b_wsfc002')
   CALL awsq990_filter_show('wsfcl004','b_wsfcl004')


   CALL awsq990_b_fill()

   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)

END FUNCTION

PRIVATE FUNCTION awsq990_filter_parser(ps_field)
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

PRIVATE FUNCTION awsq990_filter_show(ps_field,ps_object)
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
   LET ls_condition = awsq990_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION

PRIVATE FUNCTION awsq990_detail_action_trans()
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

PRIVATE FUNCTION awsq990_detail_index_setting()
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
            IF g_wsfa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_wsfa_d.getLength() AND g_wsfa_d.getLength() > 0
            LET g_detail_idx = g_wsfa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_wsfa_d.getLength() THEN
               LET g_detail_idx = g_wsfa_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF

   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_construct()
   DEFINE ls_wc STRING 
   
   
   CLEAR FORM                 
   INITIALIZE g_wsfa_m.* TO NULL
   CALL g_wsfa_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   
   
    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         --CONSTRUCT BY NAME g_wc ON l_location,l_originator,wsfa003,wsfa004,l_datakey,wsfa001,l_wsfa003
         
         CONSTRUCT BY NAME g_wc ON wsfa003,wsfa004,wsfa001
         
         END CONSTRUCT
         BEFORE DIALOG
            CALL cl_qbe_init()
            
          #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
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
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsq990_generate_req(l_method)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/09/12 By Hank Wu
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_generate_req(l_method)
  DEFINE l_req           STRING              #存放request字串
  DEFINE l_req_01        STRING
  DEFINE l_xml_str       STRING              #產生requestKey用字串
  DEFINE l_key           STRING              #用來存放requestKey回傳值
  DEFINE l_timestamp     LIKE type_t.chr80   #存放時間戳記
  DEFINE l_method        LIKE wsfc_t.wsfc001
  DEFINE p_req           STRING
#  select TO_CHAR(SYSDATE,'YYYYMMDDHH24MISSSSS')
#         INTO l_timestamp
#      from dual
  
#  LET l_xml_str = '<host prod="MCLOUD" ver="" ip="10.20.86.69" id="" lang="zh_TW" timezone="+8" timestamp="',l_timestamp,'" acct="tiptop"/>',
#    '<service prod="T100" name="ToDoListGet" srvver="1.0" ip="10.40.40.18" id="topprd"/>'
#
#  Let l_key = cl_trust_crosskey(l_xml_str)
  
    CASE l_method
       WHEN 1
          --<?xml version=\"1.0\" encoding=\"UTF-8\"?>",ASCII 10,"
          LET l_req="
             <request type=\"sync\" key=\"d41d8cd98f00b204e9800998ecf8427e\">",ASCII 10,"
                <host prod=\"BPM\" ver=\"1.0\" ip=\"10.20.86.223\" id=\"\" lang=\"zh_TW\" timezone=\"+8\" timestamp=\"20150715155232023\" acct=\"tiptop\"/>",ASCII 10,"
                <service prod=\"TIPTOP\" name=\"RefTableListGet\" srvver=\"1.0\" ip=\"10.40.40.18\" id=\"topprod\"/>",ASCII 10,"
                   <datakey type=\"FOM\">",ASCII 10,"
                      <key name=\"CompanyId\">DSCTC</key>",ASCII 10,"
                      <key name=\"EntId\">99</key>",ASCII 10,"
                   </datakey>",ASCII 10,"
                   <payload/>",ASCII 10,"
             </request>"
        WHEN 2
           LET l_req="123456"
        WHEN 3
           LET l_req="
           { \"key\": \"f5458f5c0f9022db743a7c0710145903\", \"type\": \"sync\", \"host\": {   \"prod\": \"APP\",   \"ip\": \"10.40.71.91\",   \"lang\": \"zh_TW\",   \"acct\": \"tiptop\",   \"timestamp\": \"20151211123204361\" }, \"service\": {   \"prod\": \"T100\",   \"name\": \"employee.name.get_955\",   \"ip\": \"10.40.40.18\",   \"id\": \"topprd\" }, \"datakey\": {   \"EntId\": \"99\",   \"CompanyId\": \"DSCTC\" }, \"payload\": {                                                     \"std_data\": {        \"parameter\": {            \"employee_no\": \"07375\"        }     } }}
           "
    END CASE        
  RETURN l_req
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_process_resp(l_rp)
   DEFINE l_rp    STRING
   DEFINE l_buf     base.StringBuffer
   DEFINE l_start        INTEGER
   DEFINE l_end          INTEGER
   
   LET l_buf = base.StringBuffer.create()
   CALL l_buf.append(l_rp)
   DISPLAY "l_buf",l_buf
   CALL l_buf.replace("&lt;","<",0)
   CALL l_buf.replace("&gt;",">",0)
   CALL l_buf.replace("&amp;","&",0)
   CALL l_buf.replace("&quot;","「",0)
   CALL l_buf.replace("&apos;","'",0)

   LET l_start =  l_buf.getIndexOf("<Response>",1)
   LET l_end   =   l_buf.getIndexOf("</Response>",1)+10
   LET l_rp =  l_buf.subString(l_start,l_end)
   
   RETURN l_rp
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_req_test(l_way,l_request)
   DEFINE l_req          com.HTTPRequest  --p_soap_url,p_service_method,p_soap_req
   DEFINE l_resp         com.HTTPResponse
   DEFINE p_service_method   STRING
   
   DEFINE l_way          STRING     --p_soap_url
   DEFINE l_request      STRING     --p_soap_req
   
   DEFINE l_soap_resp    STRING
   DEFINE l_status       INTEGER
   DEFINE writer         xml.DomDocument
   DEFINE l_xml_resp     xml.DomDocument
   DEFINE l_start        INTEGER
   DEFINE l_end          INTEGER

   DEFINE l_i            INTEGER
   DEFINE time1          DATETIME SECOND TO FRACTION(3)
   DEFINE time2          DATETIME SECOND TO FRACTION(3)
   
  
   LET l_way = DOWNSHIFT(l_way)

   IF l_way MATCHES "http://*?wsdl" THEN
      LET l_way = cl_replace_str(l_way,"?wsdl","")
   END IF
   DISPLAY "l_way = ",l_way
   
   DISPLAY "l_request = ",l_request

   TRY
      LET time1 = cl_get_timestamp()
     #  LET l_req = com.HTTPRequest.
      LET l_req = com.HTTPRequest.Create(l_way) 
      CALL l_req.setMethod("POST")
      CALL l_req.setCharset("UTF-8")
      CALL l_req.setHeader("SOAPAction","\"\"")
      #CALL l_req.setHeader("Server","GWS Server (Build 112734)")
      CALL l_req.setHeader("User-Agent","Jakarta Commons-HttpClient/3.0.1");
      #CALL l_req.setHeader("Connection","close")

     # CALL l_req.set
   
      # Send SOAP envelope
      LET  writer = xml.DomDocument.Create()
      CALL writer.loadFromString(l_request)
      CALL l_req.doXmlRequest(writer)

      LET l_resp = l_req.getResponse()

      LET time2 = cl_get_timestamp()

      IF l_resp.getStatusCode() != 200 THEN
         DISPLAY   "Error"
         DISPLAY   "HTTPS Error ("||l_resp.getStatusCode()||") "||l_resp.getStatusDescription()
         LET l_soap_resp = "HTTPS Error ("||l_resp.getStatusCode()||") "||l_resp.getStatusDescription()
         DISPLAY l_soap_resp
         #RETURN l_soap_resp
         #Bad Request
      ELSE
         LET l_soap_resp = l_resp.getTextResponse()
         DISPLAY   "HTTPS ("||l_resp.getStatusCode()||") ",l_resp.getStatusDescription()
         #LET l_soap_resp = "HTTPS ("||l_resp.getStatusCode()||") ",l_resp.getStatusDescription()
         DISPLAY   "### FINISH ###"
      END IF

   CATCH
      DISPLAY "ERROR :"||STATUS||" ("||SQLCA.SQLERRM||")" 
      #ERROR :-15553 (asynchronous connection failed) -> 關掉GAS wsdl不通 
      #TIME OUT ->超過設定的time out時間
      LET l_soap_resp = "ERROR :"||STATUS||" ("||SQLCA.SQLERRM||")"
      DISPLAY l_soap_resp
      #RETURN l_soap_resp
   END TRY
   DISPLAY "test1-l_soap_resp",l_soap_resp
   LET l_soap_resp = awsq990_process_resp(l_soap_resp)
   DISPLAY "test2-l_soap_resp",l_soap_resp
   DISPLAY "g_wsfa2_d.getLength()=",g_wsfa2_d.getLength()
   IF g_wsfa2_d.getLength() > 0 THEN
      FOR l_i = g_wsfa2_d.getLength() TO 1 STEP -1
         LET g_wsfa2_d[l_i+1].httpcode  = g_wsfa2_d[l_i].httpcode 
         LET g_wsfa2_d[l_i+1].resultt  = g_wsfa2_d[l_i].resultt 
         LET g_wsfa2_d[l_i+1].wsfa005  = g_wsfa2_d[l_i].wsfa005 
         LET g_wsfa2_d[l_i+1].exetime  = g_wsfa2_d[l_i].exetime
      END FOR

   END IF

   LET g_wsfa2_d[1].httpcode  = l_resp.getStatusCode()
   DISPLAY "g_wsfa2_d[1].httpcode: ",g_wsfa2_d[1].httpcode
   LET g_wsfa2_d[1].resultt = l_resp.getStatusDescription()
   DISPLAY "g_wsfa2_d[1].resultt: ",g_wsfa2_d[1].resultt
   LET g_wsfa2_d[1].wsfa005  = (time2 - time1)
   DISPLAY "g_wsfa2_d[1].wsfa005: ",g_wsfa2_d[1].wsfa005
   --LET g_wsfa2_m.l_response = l_soap_resp
   --DISPLAY "g_wsfa2_m.l_response: ",g_wsfa2_m.l_response
   DISPLAY BY NAME g_wsfa2_d[1].httpcode,g_wsfa2_d[1].resultt,g_wsfa2_d[1].wsfa005,g_wsfa2_d[1].exetime
   LET g_wsfa2_d[1].exetime = cl_get_timestamp()
   RETURN l_soap_resp
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_afterField(l_num)
   DEFINE l_tmp     STRING
   DEFINE l_num     INTEGER
   DEFINE l_originator  STRING
   DISPLAY "(afterField)g_wc",g_wc
   CASE l_num
      WHEN 1
         #l_location
         LET l_tmp = ""     
         LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_location='",1),g_wc.getLength())
         DISPLAY "___test___l_location: ",l_tmp
         IF cl_null(l_tmp) THEN
            LET g_wsfa_m.l_location = ""
         ELSE
            LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_location='",1)+12,g_wc.getLength())
            DISPLAY "l_tmp= ",l_tmp 
            LET g_wsfa_m.l_location = l_tmp.subString(1,l_tmp.getIndexOf("'",1)-1)
         END IF
         DISPLAY "(afterField)g_wsfa_m.l_location= " ,g_wsfa_m.l_location
         
         #l_originator
         LET l_tmp = ""
         LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_originator='",1),g_wc.getLength())
         DISPLAY "___test___l_originator: ",l_tmp
         IF cl_null(l_tmp) THEN
            LET g_wsfa_m.l_originator = ""
         ELSE
            LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_originator='",1)+14,g_wc.getLength())
            DISPLAY "l_tmp= ",l_tmp 
            LET g_wsfa_m.l_originator = l_tmp.subString(1,l_tmp.getIndexOf("'",1)-1)
         END IF
         DISPLAY "(afterField)g_wsfa_m.l_originator= " ,g_wsfa_m.l_originator
         
         #wsfa003
         LET l_tmp = ""
         LET l_tmp = g_wc.subString(g_wc.getIndexOf("wsfa003 between '",1),g_wc.getLength())
         DISPLAY "___test___wsfa003: ",l_tmp
         IF cl_null(l_tmp) THEN
            LET g_wsfa_m.wsfa003 = cl_get_timestamp()
            DISPLAY BY NAME g_wsfa_m.wsfa003
         ELSE
            LET l_tmp = g_wc.subString(g_wc.getIndexOf("wsfa003 between '",1)+17,g_wc.getLength())
            DISPLAY "l_tmp= ",l_tmp 
            LET g_wsfa_m.wsfa003 = l_tmp.subString(1,l_tmp.getIndexOf("'",31)-1)
            LET g_wsfa_m.wsfa003 = cl_replace_str(g_wsfa_m.wsfa003,"' and '",":")
         END IF   
         DISPLAY "(afterField)g_wsfa_m.wsfa003= " ,g_wsfa_m.wsfa003
         
         #wsfa004
         LET l_tmp = ""
         LET l_tmp = g_wc.subString(g_wc.getIndexOf("wsfa004 between '",1),g_wc.getLength())
         DISPLAY "___test___wsfa004: ",l_tmp
         IF cl_null(l_tmp) THEN
            LET g_wsfa_m.wsfa004 = cl_get_timestamp()
            DISPLAY BY NAME g_wsfa_m.wsfa004
         ELSE
            LET l_tmp = g_wc.subString(g_wc.getIndexOf("wsfa004 between '",1)+17,g_wc.getLength())
            LET g_wsfa_m.wsfa004 = l_tmp.subString(1,l_tmp.getIndexOf("'",31)-1)
            LET g_wsfa_m.wsfa004 = cl_replace_str(g_wsfa_m.wsfa004,"' and '",":")
         END IF   
         DISPLAY "(afterField)g_wsfa_m.wsfa004= " ,g_wsfa_m.wsfa004
         
         #l_datakey
         LET l_tmp = ""
         LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_datakey='",1),g_wc.getLength())
         DISPLAY "___test___l_datakey: ",l_tmp
         IF cl_null(l_tmp) THEN
            LET g_wsfa_m.l_datakey = ""
         ELSE
            LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_datakey='",1)+11,g_wc.getLength())
            LET g_wsfa_m.l_datakey = l_tmp.subString(1,l_tmp.getIndexOf("'",1)-1)
         END IF
         DISPLAY "(afterField)g_wsfa_m.l_datakey= " ,g_wsfa_m.l_datakey
         
         #wsfa001
         LET l_tmp = ""
         LET l_tmp = g_wc.subString(g_wc.getIndexOf("wsfa001='",1),g_wc.getLength())
         DISPLAY "___test___wsfa001: ",l_tmp
         IF cl_null(l_tmp) THEN
            LET g_wsfa_m.wsfa001 = ""
         ELSE
            LET l_tmp = g_wc.subString(g_wc.getIndexOf("wsfa001='",1)+9,g_wc.getLength())
            LET g_wsfa_m.wsfa001 = l_tmp.subString(1,l_tmp.getIndexOf("'",1)-1) 
         END IF   
         DISPLAY "(afterField)g_wsfa_m.wsfa001= " ,g_wsfa_m.wsfa001
         
         #l_result
         LET l_tmp = ""
         LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_result='",1),g_wc.getLength())
         DISPLAY "___test___l_result: ",l_tmp
         IF cl_null(l_tmp) THEN
            LET g_wsfa_m.l_result = ""
         ELSE
            LET l_tmp = g_wc.subString(g_wc.getIndexOf("l_result='",1)+10,g_wc.getLength())
            LET g_wsfa_m.l_result = l_tmp.subString(1,l_tmp.getIndexOf("'",1)-1)  
         END IF   
         DISPLAY "(afterField)g_wsfa_m.l_result= " ,g_wsfa_m.l_result
         
      WHEN 2
         #wsfc001
         LET l_tmp = ""
         DISPLAY "g_wc3 = ",g_wc3
         LET l_tmp = g_wc3.subString(g_wc3.getIndexOf("wsfc001='",1)+9,g_wc3.getLength())
         LET g_wsfa2_m.wsfc001 = l_tmp.subString(1,l_tmp.getIndexOf("'",1)-1)
         LET g_wsfa2_m_o.wsfc001 = g_wsfa2_m.wsfc001
         DISPLAY "(afterField)wsfc001 = ",g_wsfa2_m_o.wsfc001
         
         CASE g_wsfa2_m_o.wsfc001
            WHEN 1
               LET g_wsfa2_m.l_way = "http://10.40.40.18/wt10dev/ws/r/awsp900"
               DISPLAY BY NAME g_wsfa2_m.l_way
            WHEN 2
               LET g_wsfa2_m.l_way = "http://10.40.40.18/wt10dev/ws/r/awsp900"
               DISPLAY BY NAME g_wsfa2_m.l_way
            WHEN 3
               LET g_wsfa2_m.l_way = "http://10.40.40.18/wt10dev/ws/r/awsp920"
               DISPLAY BY NAME g_wsfa2_m.l_way
         END CASE
   END CASE      
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq990_tail_log()
#   DEFINE l_i         INTEGER
#   DEFINE l_tail_line STRING
#
#   FOR l_i = 1 TO g_wsfa3_d_t.getLength()
#      LET l_tail_line = g_wsfa3_d_t[l_i].wsfc002
#      LET l_tail_line = l_tail_line.trim()
#      
#
#   END FOR
#   RETURN l_tail_line
END FUNCTION

#end add-point
 
{</section>}
 
