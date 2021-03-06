#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2015-08-14 09:45:33), PR版次:0006(2016-09-09 14:14:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: anmq320
#+ Description: 資金日報表
#+ Creator....: 06816(2015-08-05 17:00:40)
#+ Modifier...: 06816 -SD/PR- 07900
 
{</section>}
 
{<section id="anmq320.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150824-00011#1 15/10/21 yangtt 1.金額按幣別小計；2.新增列印功能；3.添加控件【顯示無發生額資料】先抓取所有帳戶，再按帳戶顯示金額;
#                               4.增加會計科目(glab005)及會計科目說明(glab005_desc)
#160122-00001#26  2016/2/17   07673       添加交易账户编号用户权限控管
#160321-00016#38  2016/03/30  Jessy       將重複內容的錯誤訊息置換為公用錯誤訊息
#160727-00019#4  2016/07/27 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以将系统中定义的临时表长度超过15码的全部改掉
#160905-00007#8  2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
#160816-00012#4  2016/09/02  By 07900    ANM增加资金中心，帐套，法人三个栏位权限
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
PRIVATE TYPE type_g_nmbc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       nmbc002 LIKE nmbc_t.nmbc002, 
   nmbc002_desc LIKE type_t.chr500, 
   nmbc100 LIKE nmbc_t.nmbc100, 
   l_amtbefore LIKE type_t.num20_6, 
   l_nmbc103d LIKE type_t.num20_6, 
   l_nmbc103c LIKE type_t.num20_6, 
   l_amt LIKE type_t.num20_6, 
   l_amt1before LIKE type_t.num20_6, 
   l_nmbc113d LIKE type_t.num20_6, 
   l_nmbc113c LIKE type_t.num20_6, 
   l_amt1 LIKE type_t.num20_6, 
   glab005 LIKE type_t.chr500, 
   glab005_desc LIKE type_t.chr500, 
   nmbccomp LIKE nmbc_t.nmbccomp, 
   nmbcdocno LIKE nmbc_t.nmbcdocno, 
   nmbcseq LIKE nmbc_t.nmbcseq 
       END RECORD
PRIVATE TYPE type_g_nmbc2_d RECORD
       nmbc002 LIKE nmbc_t.nmbc002, 
   nmbc002_2_desc LIKE type_t.chr500, 
   nmbc100 LIKE nmbc_t.nmbc100, 
   l_amt2before LIKE type_t.num20_6, 
   l_nmbc123d LIKE type_t.num20_6, 
   l_nmbc123c LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   nmbcseq LIKE nmbc_t.nmbcseq, 
   nmbcdocno LIKE nmbc_t.nmbcdocno, 
   nmbccomp LIKE nmbc_t.nmbccomp
       END RECORD
 
PRIVATE TYPE type_g_nmbc3_d RECORD
       nmbc002 LIKE nmbc_t.nmbc002, 
   nmbc002_3_desc LIKE type_t.chr500, 
   nmbc100 LIKE nmbc_t.nmbc100, 
   l_amt3before LIKE type_t.num20_6, 
   l_nmbc133d LIKE type_t.num20_6, 
   l_nmbc133c LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   nmbccomp LIKE nmbc_t.nmbccomp, 
   nmbcseq LIKE nmbc_t.nmbcseq, 
   nmbcdocno LIKE nmbc_t.nmbcdocno
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input        RECORD 
       nmbccomp       LIKE nmbc_t.nmbccomp,
       nmbccomp_desc  LIKE ooefl_t.ooefl003,
       sdate          LIKE nmbc_t.nmbc005,
       edate          LIKE nmbc_t.nmbc005,
       l_showother    LIKE type_t.chr1,
       a              LIKE type_t.chr1  #150824-00011#1
                      END RECORD
DEFINE g_wc_site      STRING
DEFINE g_wc_nmbc002   STRING
DEFINE g_sql_bank     STRING                 #160122-00001#26
                      
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_nmbc_d
DEFINE g_master_t                   type_g_nmbc_d
DEFINE g_nmbc_d          DYNAMIC ARRAY OF type_g_nmbc_d
DEFINE g_nmbc_d_t        type_g_nmbc_d
DEFINE g_nmbc2_d   DYNAMIC ARRAY OF type_g_nmbc2_d
DEFINE g_nmbc2_d_t type_g_nmbc2_d
 
DEFINE g_nmbc3_d   DYNAMIC ARRAY OF type_g_nmbc3_d
DEFINE g_nmbc3_d_t type_g_nmbc3_d
 
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_nmbc_d_s        type_g_nmbc_d
DEFINE g_nmbc2_d_s       type_g_nmbc2_d
DEFINE g_nmbc3_d_s       type_g_nmbc3_d
#end add-point
 
{</section>}
 
{<section id="anmq320.main" >}
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
   DECLARE anmq320_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq320_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq320_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq320 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq320_init()   
 
      #進入選單 Menu (="N")
      CALL anmq320_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq320
      
   END IF 
   
   CLOSE anmq320_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq320.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq320_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL anmq320_create_tmp()  #150824-00011#1 add
   #160122-00001#26 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#26 --add--end
   #end add-point
 
   CALL anmq320_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq320.default_search" >}
PRIVATE FUNCTION anmq320_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmbccomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmbcdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " nmbcseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " nmbc002 = '", g_argv[04], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq320_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_glaa015   LIKE type_t.chr1
   DEFINE l_glaa019   LIKE type_t.chr1
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
 
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL anmq320_b_fill()
   ELSE
      CALL anmq320_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmbc_d.clear()
         CALL g_nmbc2_d.clear()
 
         CALL g_nmbc3_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL anmq320_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmbc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq320_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq320_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_nmbc2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_nmbc2_d.getLength() TO FORMONLY.h_count
               CALL anmq320_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_nmbc3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_nmbc3_d.getLength() TO FORMONLY.h_count
               CALL anmq320_fetch()
               LET g_master_idx = l_ac
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
            CALL anmq320_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmq320_query()
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
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq320_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL anmq320_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmbc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_nmbc2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_nmbc3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL anmq320_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq320_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq320_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq320_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               #add-point:ON ACTION output
               #150824-00011#1---add---str
               SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
                FROM glaa_t
               WHERE glaacomp = g_input.nmbccomp
                 AND glaa014 = 'Y'
                 AND glaaent = g_enterprise  #160905-00007#8 add
               IF l_glaa015 = 'N' AND l_glaa019 = 'N' THEN
                  CALL anmq320_x01(' 1=1','anmq320_tmp01',g_input.l_showother)    #160727-00019#4 Mod  anmq320_print1_tmp--> anmq320_tmp01
               ELSE
                  CALL anmq320_open_s01()
               END IF
               #150824-00011#1---add---end 
               #END add-point


            END IF
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq320_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_glaa015  LIKE type_t.chr1
   DEFINE l_glaa019  LIKE type_t.chr1
   DEFINE l_sql      STRING
   DEFINE l_ooef001  LIKE ooef_t.ooef001
   DEFINE l_wc          STRING             #160816-00012#3 Add
   DEFINE l_count       LIKE type_t.num5   #160816-00012#3 Add
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmbc_d.clear()
   CALL g_nmbc2_d.clear()
 
   CALL g_nmbc3_d.clear()
 
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON nmbc002,nmbc100,nmbccomp,nmbcdocno,nmbcseq
           FROM s_detail1[1].b_nmbc002,s_detail1[1].b_nmbc100,s_detail1[1].b_nmbccomp,s_detail1[1].b_nmbcdocno, 
               s_detail1[1].b_nmbcseq
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_nmbc002>>----
         #Ctrlp:construct.c.page1.b_nmbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbc002
            #add-point:ON ACTION controlp INFIELD b_nmbc002 name="construct.c.page1.b_nmbc002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " nmaa002 IN ",g_wc_site  #160122-00001#26mark
            
            #160122-00001#26 - add -str
            LET g_qryparam.where = " nmaa002 IN ",g_wc_site ,
                                   " AND nmas002 IN (",g_sql_bank,")"
            #160122-00001#26 -add -end
           
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbc002  #顯示到畫面上
            LET g_qryparam.where = " "  #160122-00001#26 - add
            NEXT FIELD b_nmbc002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbc002
            #add-point:BEFORE FIELD b_nmbc002 name="construct.b.page1.b_nmbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbc002
            
            #add-point:AFTER FIELD b_nmbc002 name="construct.a.page1.b_nmbc002"
            
            #END add-point
            
 
 
         #----<<b_nmbc002_desc>>----
         #----<<b_nmbc100>>----
         #Ctrlp:construct.c.page1.b_nmbc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbc100
            #add-point:ON ACTION controlp INFIELD b_nmbc100 name="construct.c.page1.b_nmbc100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbc100  #顯示到畫面上
            NEXT FIELD b_nmbc100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbc100
            #add-point:BEFORE FIELD b_nmbc100 name="construct.b.page1.b_nmbc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbc100
            
            #add-point:AFTER FIELD b_nmbc100 name="construct.a.page1.b_nmbc100"
            
            #END add-point
            
 
 
         #----<<l_amtbefore>>----
         #----<<l_nmbc103d>>----
         #----<<l_nmbc103c>>----
         #----<<l_amt>>----
         #----<<l_amt1before>>----
         #----<<l_nmbc113d>>----
         #----<<l_nmbc113c>>----
         #----<<l_amt1>>----
         #----<<glab005>>----
         #----<<glab005_desc>>----
         #----<<b_nmbccomp>>----
         #Ctrlp:construct.c.page1.b_nmbccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbccomp
            #add-point:ON ACTION controlp INFIELD b_nmbccomp name="construct.c.page1.b_nmbccomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbccomp  #顯示到畫面上
            NEXT FIELD b_nmbccomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbccomp
            #add-point:BEFORE FIELD b_nmbccomp name="construct.b.page1.b_nmbccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbccomp
            
            #add-point:AFTER FIELD b_nmbccomp name="construct.a.page1.b_nmbccomp"
            
            #END add-point
            
 
 
         #----<<b_nmbcdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbcdocno
            #add-point:BEFORE FIELD b_nmbcdocno name="construct.b.page1.b_nmbcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbcdocno
            
            #add-point:AFTER FIELD b_nmbcdocno name="construct.a.page1.b_nmbcdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbcdocno
            #add-point:ON ACTION controlp INFIELD b_nmbcdocno name="construct.c.page1.b_nmbcdocno"
            
            #END add-point
 
 
         #----<<b_nmbcseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbcseq
            #add-point:BEFORE FIELD b_nmbcseq name="construct.b.page1.b_nmbcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbcseq
            
            #add-point:AFTER FIELD b_nmbcseq name="construct.a.page1.b_nmbcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbcseq
            #add-point:ON ACTION controlp INFIELD b_nmbcseq name="construct.c.page1.b_nmbcseq"
            
            #END add-point
 
 
         #----<<nmbc002_2_desc>>----
         #----<<l_amt2before>>----
         #----<<l_nmbc123d>>----
         #----<<l_nmbc123c>>----
         #----<<l_amt2>>----
         #----<<nmbc002_3_desc>>----
         #----<<l_amt3before>>----
         #----<<l_nmbc133d>>----
         #----<<l_nmbc133c>>----
         #----<<l_amt3>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.nmbccomp,g_input.sdate,g_input.edate,g_input.l_showother,g_input.a  #150824-00011#1 add g_input.a
  
         BEFORE INPUT
         
         ON CHANGE l_showother
            IF NOT cl_null(g_input.nmbccomp) THEN
               IF g_input.l_showother ='Y' THEN
                  SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
                    FROM glaa_t
                   WHERE glaacomp = g_input.nmbccomp
                     AND glaa014 = 'Y'
                     AND glaaent = g_enterprise  #160905-00007#8 add
                  IF l_glaa015 = 'Y' THEN
                     CALL cl_set_comp_visible('page_2',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('page_2',FALSE)
                  END IF
                  IF l_glaa019 = 'Y' THEN
                     CALL cl_set_comp_visible('page_3',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('page_3',FALSE)
                  END IF
                  CALL cl_set_comp_visible('l_amt1before,l_nmbc113d,l_nmbc113c,l_amt1',TRUE)
               ELSE
                  CALL cl_set_comp_visible('l_amt1before,l_nmbc113d,l_nmbc113c,l_amt1',FALSE)
                  CALL cl_set_comp_visible('page_2',FALSE)
                  CALL cl_set_comp_visible('page_3',FALSE)
               END IF
            END IF
         #法人欄位檢核
         AFTER FIELD nmbccomp
            #檢查是否存在
            IF NOT cl_null(g_input.nmbccomp) THEN
               CALL s_fin_comp_chk(g_input.nmbccomp) RETURNING g_sub_success,g_errno #檢查是否為法人
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#38 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#38 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.nmbccomp = ''
                  LET g_input.nmbccomp_desc = ''
                  DISPLAY BY NAME g_input.nmbccomp,g_input.nmbccomp_desc
                  NEXT FIELD CURRENT
               END IF
               #160816-00012#4 Add  ---(S)---
               #检查用户是否有资金中心对应法人的权限
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
               LET l_count = 0
               LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                           "   AND ooef001 = '",g_input.nmbccomp,"'",
                           "   AND ooef003 = 'Y'",
                           "   AND ",l_wc CLIPPED
               PREPARE anmp410_count_prep1 FROM l_sql
               EXECUTE anmp410_count_prep1 INTO l_count
               IF cl_null(l_count) THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ais-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.nmbccomp = ''
                  LET g_input.nmbccomp_desc = ''
                  DISPLAY BY NAME g_input.nmbccomp,g_input.nmbccomp_desc
                  NEXT FIELD CURRENT
               END IF
               #160816-00012#4 Add  ---(E)---
               LET g_input.nmbccomp_desc = s_desc_get_department_desc(g_input.nmbccomp)
               DISPLAY BY NAME g_input.nmbccomp,g_input.nmbccomp_desc
               LET l_sql = "SELECT ooef001 FROM ooef_t WHERE ooef017 = '",g_input.nmbccomp,"'",
                           "   AND ooefent = '",g_enterprise,"'"
               PREPARE anmq320_nmbcsite_strp FROM l_sql
               DECLARE anmq320_nmbcsite_strc CURSOR FOR anmq320_nmbcsite_strp
               LET g_wc_site = NULL
               FOREACH anmq320_nmbcsite_strc INTO l_ooef001
                  IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
                  IF cl_null(g_wc_site)THEN
                     LET g_wc_site = l_ooef001 CLIPPED
                  ELSE
                     LET g_wc_site = g_wc_site CLIPPED,",",l_ooef001 CLIPPED
                  END IF         
               END FOREACH
               CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
               IF g_input.l_showother ='Y' THEN
                  SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
                    FROM glaa_t
                   WHERE glaacomp = g_input.nmbccomp
                     AND glaa014 = 'Y'
                     AND glaaent = g_enterprise  #160905-00007#8 add
                  IF l_glaa015 = 'Y' THEN
                     CALL cl_set_comp_visible('page_2',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('page_2',FALSE)
                  END IF
                  IF l_glaa019 = 'Y' THEN
                     CALL cl_set_comp_visible('page_3',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('page_3',FALSE)
                  END IF
                  CALL cl_set_comp_visible('l_amt1before,l_nmbc113d,l_nmbc113c,l_amt1',TRUE)
               ELSE
                  CALL cl_set_comp_visible('l_amt1before,l_nmbc113d,l_nmbc113c,l_amt1',FALSE)
                  CALL cl_set_comp_visible('page_2',FALSE)
                  CALL cl_set_comp_visible('page_3',FALSE)
               END IF
            END IF
             
         AFTER FIELD sdate
            IF NOT cl_null(g_input.sdate) AND NOT cl_null(g_input.edate) THEN
               IF g_input.sdate > g_input.edate THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_input.sdate 
                  LET g_errparam.code   = 'amm-00080' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD sdate  
               END IF                  
            END IF
         
         AFTER FIELD edate
            IF NOT cl_null(g_input.sdate) AND NOT cl_null(g_input.edate) THEN
               IF g_input.edate < g_input.sdate THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_input.edate 
                  LET g_errparam.code   = 'amm-00081' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD edate  
               END IF                  
            END IF
          
         #法人開窗
         ON ACTION controlp INFIELD nmbccomp
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.nmbccomp    #給予default值   
            #160816-00012#4 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = l_wc CLIPPED
            #160816-00012#4 Add  ---(E)---
            CALL q_ooef001_2()                            #呼叫開窗
            LET g_input.nmbccomp = g_qryparam.return1  
            LET g_input.nmbccomp_desc = s_desc_get_department_desc(g_input.nmbccomp)
            DISPLAY BY NAME g_input.nmbccomp,g_input.nmbccomp_desc            
            NEXT FIELD nmbccomp                          #返回原欄位      
      END INPUT
      
      BEFORE DIALOG
         CALL anmq320_qbe_clear()         
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         CALL anmq320_qbe_clear()
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL anmq320_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="anmq320.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq320_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql      STRING
   DEFINE l_ooef001  LIKE ooef_t.ooef001
   DEFINE l_nmbc002  LIKE nmbc_t.nmbc002
   DEFINE l_total_1b LIKE type_t.num20_6    #期初總額
   DEFINE l_total_1d LIKE type_t.num20_6    #借方總額
   DEFINE l_total_1c LIKE type_t.num20_6    #貸方總額
   DEFINE l_total_1  LIKE type_t.num20_6    #期末總額
   #本位幣二
   DEFINE l_total_2b LIKE type_t.num20_6    
   DEFINE l_total_2d LIKE type_t.num20_6
   DEFINE l_total_2c LIKE type_t.num20_6
   DEFINE l_total_2  LIKE type_t.num20_6
   #本位幣三
   DEFINE l_total_3b LIKE type_t.num20_6    
   DEFINE l_total_3d LIKE type_t.num20_6
   DEFINE l_total_3c LIKE type_t.num20_6
   DEFINE l_total_3  LIKE type_t.num20_6
   #150824-00011#1----add---str--
   DEFINE l_nmbc100_t LIKE nmbc_t.nmbc100
   DEFINE l_total_b_sum  LIKE type_t.num20_6    #期初小計
   DEFINE l_total_d_sum  LIKE type_t.num20_6    #借方小計
   DEFINE l_total_c_sum  LIKE type_t.num20_6    #貸方小計
   DEFINE l_total_sum    LIKE type_t.num20_6    #期末小計
   
   DEFINE l_total_1b_sum LIKE type_t.num20_6    #期初小計
   DEFINE l_total_1d_sum LIKE type_t.num20_6    #借方小計
   DEFINE l_total_1c_sum LIKE type_t.num20_6    #貸方小計
   DEFINE l_total_1_sum  LIKE type_t.num20_6    #期末小計
   #本位幣二
   DEFINE l_total_2b_sum LIKE type_t.num20_6    
   DEFINE l_total_2d_sum LIKE type_t.num20_6
   DEFINE l_total_2c_sum LIKE type_t.num20_6
   DEFINE l_total_2_sum  LIKE type_t.num20_6
   #本位幣三
   DEFINE l_total_3b_sum LIKE type_t.num20_6    
   DEFINE l_total_3d_sum LIKE type_t.num20_6
   DEFINE l_total_3c_sum LIKE type_t.num20_6
   DEFINE l_total_3_sum  LIKE type_t.num20_6
   DEFINE l_nmbccomp_desc LIKE type_t.chr500
   DEFINE l_date_desc    LIKE type_t.chr500
   DEFINE l_glaald       LIKE glaa_t.glaald
   DEFINE l_glaa004      LIKE glaa_t.glaa004
   #150824-00011#1----add---end--
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #150824-00011#1----add---str--
   DELETE FROM anmq320_tmp01;   #160727-00019#4 Mod  anmq320_print1_tmp--> anmq320_tmp01
   DELETE FROM anmq320_tmp02;    #160727-00019#4 Mod  anmq320_print2_tmp--> anmq320_tmp02
   DELETE FROM anmq320_tmp03;    #160727-00019#4 Mod  anmq320_print3_tmp--> anmq320_tmp03
   
   LET l_nmbccomp_desc = g_input.nmbccomp," ",g_input.nmbccomp_desc
   LET l_date_desc = g_input.sdate," ~ ",g_input.edate
   #150824-00011#1----add---end--
   
   LET l_sql =  "SELECT nmas002 FROM nmaa_t,nmas_t ",
                " WHERE nmaa001 = nmas001 AND nmaaent = nmasent ",
                "   AND nmaa002 IN ",g_wc_site CLIPPED
   PREPARE anmq320_nmbc002_strp FROM l_sql
   DECLARE anmq320_nmbc002_strc CURSOR FOR anmq320_nmbc002_strp
   LET g_wc_nmbc002 = NULL
   FOREACH anmq320_nmbc002_strc INTO l_nmbc002
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      IF cl_null(g_wc_nmbc002)THEN
         LET g_wc_nmbc002 = l_nmbc002 CLIPPED
      ELSE
         LET g_wc_nmbc002 = g_wc_nmbc002 CLIPPED,",",l_nmbc002 CLIPPED
      END IF         
   END FOREACH
   CALL s_fin_get_wc_str(g_wc_nmbc002) RETURNING g_wc_nmbc002
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE nmbc002,'',nmbc100,'','','','','','','','','','',nmbccomp,nmbcdocno, 
       nmbcseq,'','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY nmbc_t.nmbccomp, 
       nmbc_t.nmbcdocno,nmbc_t.nmbcseq,nmbc_t.nmbc002) AS RANK FROM nmbc_t",
 
 
                     "",
                     " WHERE nmbcent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmbc_t"),
                     " ORDER BY nmbc_t.nmbccomp,nmbc_t.nmbcdocno,nmbc_t.nmbcseq,nmbc_t.nmbc002"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   IF g_input.a = 'N' THEN #150824-00011#1 add
      LET ls_sql_rank = "SELECT  UNIQUE nmbc002,nmbc100 ,'','','','','','','','','','','',", 
                        "    '','','','','','','','','',",
                        "    '','','','','','','','','','','','','','' ",  #150824-00011#1 add 2 ''
                        ",DENSE_RANK() OVER( ORDER BY nmbc_t.nmbc002) AS RANK ",
                        "  FROM nmbc_t,nmas_t,nmaa_t",
                        " WHERE nmbcent = nmaaent AND nmbc002 = nmas002 AND nmaaent = nmasent AND nmaa001 = nmas001",
                        "   AND nmbccomp='",g_input.nmbccomp,"' ",
                        "   AND nmbc005 BETWEEN '",g_input.sdate,"' AND '",g_input.edate,"' ",
                        " AND nmbcent= ? AND 1=1 AND nmbc002 IN ",g_wc_nmbc002," AND ", ls_wc,
                        " AND (nmas002 IN (",g_sql_bank,") OR TRIM(nmas002) IS NULL )"    #160122-00001#26 - add
       
      LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmbc_t"),
                       #" ORDER BY nmbc_t.nmbc002" #150824-00011#1 mark
                        " ORDER BY nmbc100,nmbc002"  #150824-00011#1 add
   ELSE#150824-00011#1 add
   #150824-00011#1----add---str--                  
      LET ls_sql_rank = "SELECT  UNIQUE nmas002 nmbc002,nmas003 nmbc100 ,'','','','','','','','','','','',", 
                        "    '','','','','','','','','',",
                        "    '','','','','','','','','','','','''','' ",  #150824-00011#1 add 2 ''
                        ",DENSE_RANK() OVER( ORDER BY nmbc_t.nmbc002) AS RANK ",
                        "  FROM nmaa_t,nmas_t LEFT OUTER JOIN nmbc_t ON nmasent = nmbcent AND nmas002 = nmbc002 ", 
                        "   AND nmbccomp='",g_input.nmbccomp,"' ",
                        "   AND nmbc005 BETWEEN '",g_input.sdate,"' AND '",g_input.edate,"' ",
                        " WHERE nmaaent = nmasent AND nmaa001 = nmas001",
                        "   AND nmaaent= ? AND 1=1 "," AND ", ls_wc," AND nmaa002 IN ",g_wc_site CLIPPED,
                        " AND (nmas002 IN (",g_sql_bank,") OR TRIM(nmas002) IS NULL )"    #160122-00001#26 - add
      LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmbc_t"),
                     " ORDER BY nmbc100,nmbc002"  #150824-00011#1 add
   END IF
   #150824-00011#1----add---end--
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
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
 
   LET g_sql = "SELECT nmbc002,'',nmbc100,'','','','','','','','','','',nmbccomp,nmbcdocno,nmbcseq,'', 
       '','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT nmbc002,'',nmbc100,'','','','','','','','','','','','','',",  #150824-00011#1 add 2 ''
               "  nmbc002,'','','','','','','','','', ",
               "  nmbc002,'','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq320_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq320_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmbc_d.clear()
   CALL g_nmbc2_d.clear()   
 
   CALL g_nmbc3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_total_1b = 0
   LET l_total_1d = 0
   LET l_total_1c = 0
   LET l_total_1  = 0
   LET l_total_2b = 0
   LET l_total_2d = 0
   LET l_total_2c = 0
   LET l_total_2  = 0
   LET l_total_3b = 0
   LET l_total_3d = 0
   LET l_total_3c = 0
   LET l_total_3  = 0
   #150824-00011#1---add---str--
   LET l_nmbc100_t = '' 
   LET l_total_b_sum = 0
   LET l_total_d_sum = 0
   LET l_total_c_sum = 0
   LET l_total_sum   = 0
   
   LET l_total_1b_sum = 0
   LET l_total_1d_sum = 0
   LET l_total_1c_sum = 0
   LET l_total_1_sum  = 0
   #本位幣二
   LET l_total_2b_sum = 0   
   LET l_total_2d_sum = 0
   LET l_total_2c_sum = 0
   LET l_total_2_sum  = 0
   #本位幣三             
   LET l_total_3b_sum = 0   
   LET l_total_3d_sum = 0
   LET l_total_3c_sum = 0
   LET l_total_3_sum  = 0
   #150824-00011#1---add---end--
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_nmbc_d[l_ac].nmbc002,g_nmbc_d[l_ac].nmbc002_desc,g_nmbc_d[l_ac].nmbc100, 
       g_nmbc_d[l_ac].l_amtbefore,g_nmbc_d[l_ac].l_nmbc103d,g_nmbc_d[l_ac].l_nmbc103c,g_nmbc_d[l_ac].l_amt, 
       g_nmbc_d[l_ac].l_amt1before,g_nmbc_d[l_ac].l_nmbc113d,g_nmbc_d[l_ac].l_nmbc113c,g_nmbc_d[l_ac].l_amt1, 
       g_nmbc_d[l_ac].glab005,g_nmbc_d[l_ac].glab005_desc,g_nmbc_d[l_ac].nmbccomp,g_nmbc_d[l_ac].nmbcdocno, 
       g_nmbc_d[l_ac].nmbcseq,g_nmbc2_d[l_ac].nmbc002,g_nmbc2_d[l_ac].nmbc002_2_desc,g_nmbc2_d[l_ac].nmbc100, 
       g_nmbc2_d[l_ac].l_amt2before,g_nmbc2_d[l_ac].l_nmbc123d,g_nmbc2_d[l_ac].l_nmbc123c,g_nmbc2_d[l_ac].l_amt2, 
       g_nmbc2_d[l_ac].nmbcseq,g_nmbc2_d[l_ac].nmbcdocno,g_nmbc2_d[l_ac].nmbccomp,g_nmbc3_d[l_ac].nmbc002, 
       g_nmbc3_d[l_ac].nmbc002_3_desc,g_nmbc3_d[l_ac].nmbc100,g_nmbc3_d[l_ac].l_amt3before,g_nmbc3_d[l_ac].l_nmbc133d, 
       g_nmbc3_d[l_ac].l_nmbc133c,g_nmbc3_d[l_ac].l_amt3,g_nmbc3_d[l_ac].nmbccomp,g_nmbc3_d[l_ac].nmbcseq, 
       g_nmbc3_d[l_ac].nmbcdocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_nmbc_d[l_ac].statepic = cl_get_actipic(g_nmbc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT nmaal003 INTO g_nmbc_d[l_ac].nmbc002_desc FROM nmaal_t,nmas_t
       WHERE nmaal001 = nmas001 AND nmaalent = nmasent
         AND nmaalent = g_enterprise AND nmas002= g_nmbc_d[l_ac].nmbc002
         AND nmaal002 = g_dlang
      LET g_nmbc2_d[l_ac].nmbc002_2_desc = g_nmbc_d[l_ac].nmbc002_desc
      LET g_nmbc3_d[l_ac].nmbc002_3_desc = g_nmbc_d[l_ac].nmbc002_desc
        
      SELECT glaa016,glaa020,glaald,glaa004   #150824-00011#1 add glaald,glaa004
        INTO g_nmbc2_d[l_ac].nmbc100,g_nmbc3_d[l_ac].nmbc100,l_glaald,l_glaa004  #150824-00011#1 add glaald,glaa004
        FROM glaa_t
       WHERE glaaent = g_enterprise AND glaa014 ='Y' AND glaacomp = g_input.nmbccomp
      
      SELECT SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc103 ELSE 0 END,0)),
             SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc103 ELSE 0 END,0)),
             SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc113 ELSE 0 END,0)),
             SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc113 ELSE 0 END,0)),
             SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc123 ELSE 0 END,0)),
             SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc123 ELSE 0 END,0)),
             SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc133 ELSE 0 END,0)),
             SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc133 ELSE 0 END,0))
        INTO g_nmbc_d[l_ac].l_nmbc103d,g_nmbc_d[l_ac].l_nmbc103c,
             g_nmbc_d[l_ac].l_nmbc113d,g_nmbc_d[l_ac].l_nmbc113c,
             g_nmbc2_d[l_ac].l_nmbc123d,g_nmbc2_d[l_ac].l_nmbc123c,
             g_nmbc3_d[l_ac].l_nmbc133d,g_nmbc3_d[l_ac].l_nmbc133c             
        FROM nmbc_t
       WHERE nmbcent  = g_enterprise AND nmbccomp = g_input.nmbccomp 
         AND nmbc002  = g_nmbc_d[l_ac].nmbc002
         AND nmbc100  = g_nmbc_d[l_ac].nmbc100
         AND nmbc005  BETWEEN g_input.sdate AND g_input.edate
         
      IF cl_null(g_nmbc_d[l_ac].l_nmbc103d)  THEN LET g_nmbc_d[l_ac].l_nmbc103d  = 0 END IF
      IF cl_null(g_nmbc_d[l_ac].l_nmbc103c)  THEN LET g_nmbc_d[l_ac].l_nmbc103c  = 0 END IF
      IF cl_null(g_nmbc_d[l_ac].l_nmbc113d)  THEN LET g_nmbc_d[l_ac].l_nmbc113d  = 0 END IF
      IF cl_null(g_nmbc_d[l_ac].l_nmbc113c)  THEN LET g_nmbc_d[l_ac].l_nmbc113c  = 0 END IF
      IF cl_null(g_nmbc2_d[l_ac].l_nmbc123d) THEN LET g_nmbc2_d[l_ac].l_nmbc123d = 0 END IF
      IF cl_null(g_nmbc2_d[l_ac].l_nmbc123c) THEN LET g_nmbc2_d[l_ac].l_nmbc123c = 0 END IF
      IF cl_null(g_nmbc3_d[l_ac].l_nmbc133d) THEN LET g_nmbc3_d[l_ac].l_nmbc133d = 0 END IF
      IF cl_null(g_nmbc3_d[l_ac].l_nmbc133c) THEN LET g_nmbc3_d[l_ac].l_nmbc133c = 0 END IF
      
      CALL anmq320_amt(g_nmbc_d[l_ac].nmbc002,g_nmbc_d[l_ac].nmbc100)
         RETURNING g_nmbc_d[l_ac].l_amtbefore,g_nmbc_d[l_ac].l_amt1before,g_nmbc2_d[l_ac].l_amt2before,g_nmbc3_d[l_ac].l_amt3before
      
      LET g_nmbc_d[l_ac].l_amt   = g_nmbc_d[l_ac].l_amtbefore   + g_nmbc_d[l_ac].l_nmbc103d  - g_nmbc_d[l_ac].l_nmbc103c
      LET g_nmbc_d[l_ac].l_amt1  = g_nmbc_d[l_ac].l_amt1before  + g_nmbc_d[l_ac].l_nmbc113d  - g_nmbc_d[l_ac].l_nmbc113c
      LET g_nmbc2_d[l_ac].l_amt2 = g_nmbc2_d[l_ac].l_amt2before + g_nmbc2_d[l_ac].l_nmbc123d - g_nmbc2_d[l_ac].l_nmbc123c
      LET g_nmbc3_d[l_ac].l_amt3 = g_nmbc3_d[l_ac].l_amt3before + g_nmbc3_d[l_ac].l_nmbc133d - g_nmbc3_d[l_ac].l_nmbc133c
      LET l_total_1b = l_total_1b + g_nmbc_d[l_ac].l_amt1before
      LET l_total_1d = l_total_1d + g_nmbc_d[l_ac].l_nmbc113d
      LET l_total_1c = l_total_1c + g_nmbc_d[l_ac].l_nmbc113c
      LET l_total_1  = l_total_1  + g_nmbc_d[l_ac].l_amt1
      LET l_total_2b = l_total_2b + g_nmbc2_d[l_ac].l_amt2before
      LET l_total_2d = l_total_2d + g_nmbc2_d[l_ac].l_nmbc123d
      LET l_total_2c = l_total_2c + g_nmbc2_d[l_ac].l_nmbc123c
      LET l_total_2  = l_total_2  + g_nmbc2_d[l_ac].l_amt2
      LET l_total_3b = l_total_3b + g_nmbc3_d[l_ac].l_amt3before
      LET l_total_3d = l_total_3d + g_nmbc3_d[l_ac].l_nmbc133d
      LET l_total_3c = l_total_3c + g_nmbc3_d[l_ac].l_nmbc133c
      LET l_total_3  = l_total_3  + g_nmbc3_d[l_ac].l_amt3 

      #150824-00011#1---add---str--
      #根據法人的主帳套的到anmi121中抓取科目
      SELECT glab005 INTO g_nmbc_d[l_ac].glab005 FROM glab_t
       WHERE glabent = g_enterprise AND glabld = l_glaald
         AND glab001 = '40' AND glab002 = '40'
         AND glab003 = g_nmbc_d[l_ac].nmbc002
      
      SELECT glacl004 INTO g_nmbc_d[l_ac].glab005_desc FROM glacl_t 
       WHERE glaclent = g_enterprise AND glacl001 = l_glaa004 
         AND glacl002 = g_nmbc_d[l_ac].glab005 AND glacl003 = g_dlang
         
      #臨時表報表列印用
      #帳戶餘額
      INSERT INTO anmq320_tmp01 VALUES(l_nmbccomp_desc,l_date_desc,g_nmbc_d[l_ac].nmbc002,g_nmbc_d[l_ac].nmbc002_desc,g_nmbc_d[l_ac].nmbc100,g_nmbc_d[l_ac].l_amtbefore,   #160727-00019#4 Mod  anmq320_print1_tmp--> anmq320_tmp01
       g_nmbc_d[l_ac].l_nmbc103d,g_nmbc_d[l_ac].l_nmbc103c,g_nmbc_d[l_ac].l_amt,g_nmbc_d[l_ac].l_amt1before, 
       g_nmbc_d[l_ac].l_nmbc113d,g_nmbc_d[l_ac].l_nmbc113c,g_nmbc_d[l_ac].l_amt1,g_nmbc_d[l_ac].glab005,g_nmbc_d[l_ac].glab005_desc)
      
      #本位幣二
      INSERT INTO anmq320_tmp02 VALUES(l_nmbccomp_desc,l_date_desc,g_nmbc2_d[l_ac].nmbc002,g_nmbc2_d[l_ac].nmbc002_2_desc,g_nmbc2_d[l_ac].nmbc100, #160727-00019#4 Mod  anmq320_print2_tmp--> anmq320_tmp02   
       g_nmbc2_d[l_ac].l_amt2before,g_nmbc2_d[l_ac].l_nmbc123d,g_nmbc2_d[l_ac].l_nmbc123c,g_nmbc2_d[l_ac].l_amt2,g_nmbc_d[l_ac].nmbc100)
      
      #本位幣三
      INSERT INTO anmq320_tmp03 VALUES(l_nmbccomp_desc,l_date_desc,g_nmbc3_d[l_ac].nmbc002, g_nmbc3_d[l_ac].nmbc002_3_desc,  #160727-00019#4 Mod  anmq320_print3_tmp--> anmq320_tmp03
       g_nmbc3_d[l_ac].nmbc100,g_nmbc3_d[l_ac].l_amt3before,g_nmbc3_d[l_ac].l_nmbc133d,g_nmbc3_d[l_ac].l_nmbc133c, 
       g_nmbc3_d[l_ac].l_amt3,g_nmbc_d[l_ac].nmbc100)
      
      IF l_ac <> 1 AND l_nmbc100_t <> g_nmbc_d[l_ac].nmbc100 OR (NOT cl_null(l_nmbc100_t) AND cl_null(g_nmbc_d[l_ac].nmbc100)) THEN
         LET g_nmbc_d_s.* = g_nmbc_d[l_ac].*
         LET g_nmbc2_d_s.* = g_nmbc2_d[l_ac].*
         LET g_nmbc3_d_s.* = g_nmbc3_d[l_ac].*
         
         LET g_nmbc_d[l_ac].nmbc002 = ''
         LET g_nmbc2_d[l_ac].nmbc002 = ''
         LET g_nmbc3_d[l_ac].nmbc002 = ''
         LET g_nmbc_d[l_ac].nmbc002_desc = ''
         LET g_nmbc2_d[l_ac].nmbc002_2_desc = ''
         LET g_nmbc3_d[l_ac].nmbc002_3_desc = ''
         LET g_nmbc_d[l_ac].glab005 = ''
         LET g_nmbc_d[l_ac].glab005_desc = ''
         LET g_nmbc_d[l_ac].nmbc100 = l_nmbc100_t," ",cl_getmsg('aap-00287',g_dlang)
         LET g_nmbc2_d[l_ac].nmbc100 = l_nmbc100_t," ",cl_getmsg('aap-00287',g_dlang)
         LET g_nmbc3_d[l_ac].nmbc100 = l_nmbc100_t," ",cl_getmsg('aap-00287',g_dlang)
         
         LET g_nmbc_d[l_ac].l_amtbefore = l_total_b_sum  
         LET g_nmbc_d[l_ac].l_nmbc103d = l_total_d_sum 
         LET g_nmbc_d[l_ac].l_nmbc103c = l_total_c_sum
         LET g_nmbc_d[l_ac].l_amt = l_total_sum  
         
         LET g_nmbc_d[l_ac].l_amt1before = l_total_1b_sum 
         LET g_nmbc_d[l_ac].l_nmbc113d = l_total_1d_sum 
         LET g_nmbc_d[l_ac].l_nmbc113c = l_total_1c_sum  
         LET g_nmbc_d[l_ac].l_amt1 = l_total_1_sum 
         #本位幣二
         LET g_nmbc2_d[l_ac].l_amt2before = l_total_2b_sum
         LET g_nmbc2_d[l_ac].l_nmbc123d = l_total_2d_sum 
         LET g_nmbc2_d[l_ac].l_nmbc123c = l_total_2c_sum
         LET g_nmbc2_d[l_ac].l_amt2 = l_total_2_sum
         #本位幣三           
         LET g_nmbc3_d[l_ac].l_amt3before = l_total_3b_sum 
         LET g_nmbc3_d[l_ac].l_nmbc133d = l_total_3d_sum 
         LET g_nmbc3_d[l_ac].l_nmbc133c = l_total_3c_sum  
         LET g_nmbc3_d[l_ac].l_amt3  = l_total_3_sum
         
         LET l_total_b_sum = 0
         LET l_total_d_sum = 0
         LET l_total_c_sum = 0
         LET l_total_sum   = 0
         
         LET l_total_1b_sum = 0
         LET l_total_1d_sum = 0
         LET l_total_1c_sum = 0
         LET l_total_1_sum  = 0
         #本位幣二
         LET l_total_2b_sum = 0   
         LET l_total_2d_sum = 0
         LET l_total_2c_sum = 0
         LET l_total_2_sum  = 0
         #本位幣三             
         LET l_total_3b_sum = 0   
         LET l_total_3d_sum = 0
         LET l_total_3c_sum = 0
         LET l_total_3_sum  = 0
         
         LET l_ac = l_ac +1
         
         LET g_nmbc_d[l_ac].* = g_nmbc_d_s.* 
         LET g_nmbc2_d[l_ac].* = g_nmbc2_d_s.*
         LET g_nmbc3_d[l_ac].* = g_nmbc3_d_s.*
         
         LET l_total_b_sum = l_total_b_sum + g_nmbc_d[l_ac].l_amtbefore
         LET l_total_d_sum = l_total_d_sum + g_nmbc_d[l_ac].l_nmbc103d
         LET l_total_c_sum = l_total_c_sum + g_nmbc_d[l_ac].l_nmbc103c
         LET l_total_sum   = l_total_sum + g_nmbc_d[l_ac].l_amt
         
         LET l_total_1b_sum = l_total_1b_sum + g_nmbc_d[l_ac].l_amt1before
         LET l_total_1d_sum = l_total_1d_sum + g_nmbc_d[l_ac].l_nmbc113d
         LET l_total_1c_sum = l_total_1c_sum + g_nmbc_d[l_ac].l_nmbc113c
         LET l_total_1_sum  = l_total_1_sum + g_nmbc_d[l_ac].l_amt1
         #本位幣二
         LET l_total_2b_sum = l_total_2b_sum + g_nmbc2_d[l_ac].l_amt2before
         LET l_total_2d_sum = l_total_2d_sum + g_nmbc2_d[l_ac].l_nmbc123d
         LET l_total_2c_sum = l_total_2c_sum + g_nmbc2_d[l_ac].l_nmbc123c
         LET l_total_2_sum  = l_total_2_sum + g_nmbc2_d[l_ac].l_amt2
         #本位幣三           
         LET l_total_3b_sum = l_total_3b_sum + g_nmbc3_d[l_ac].l_amt3before
         LET l_total_3d_sum = l_total_3d_sum + g_nmbc3_d[l_ac].l_nmbc133d
         LET l_total_3c_sum = l_total_3c_sum + g_nmbc3_d[l_ac].l_nmbc133c
         LET l_total_3_sum  = l_total_3_sum + g_nmbc3_d[l_ac].l_amt3
         
         LET l_nmbc100_t = g_nmbc_d[l_ac].nmbc100
           
      ELSE 
         LET l_total_b_sum = l_total_b_sum + g_nmbc_d[l_ac].l_amtbefore
         LET l_total_d_sum = l_total_d_sum + g_nmbc_d[l_ac].l_nmbc103d
         LET l_total_c_sum = l_total_c_sum + g_nmbc_d[l_ac].l_nmbc103c
         LET l_total_sum   = l_total_sum + g_nmbc_d[l_ac].l_amt
         
         LET l_total_1b_sum = l_total_1b_sum + g_nmbc_d[l_ac].l_amt1before
         LET l_total_1d_sum = l_total_1d_sum + g_nmbc_d[l_ac].l_nmbc113d
         LET l_total_1c_sum = l_total_1c_sum + g_nmbc_d[l_ac].l_nmbc113c
         LET l_total_1_sum  = l_total_1_sum + g_nmbc_d[l_ac].l_amt1
         #本位幣二
         LET l_total_2b_sum = l_total_2b_sum + g_nmbc2_d[l_ac].l_amt2before
         LET l_total_2d_sum = l_total_2d_sum + g_nmbc2_d[l_ac].l_nmbc123d
         LET l_total_2c_sum = l_total_2c_sum + g_nmbc2_d[l_ac].l_nmbc123c
         LET l_total_2_sum  = l_total_2_sum + g_nmbc2_d[l_ac].l_amt2
         #本位幣三           
         LET l_total_3b_sum = l_total_3b_sum + g_nmbc3_d[l_ac].l_amt3before
         LET l_total_3d_sum = l_total_3d_sum + g_nmbc3_d[l_ac].l_nmbc133d
         LET l_total_3c_sum = l_total_3c_sum + g_nmbc3_d[l_ac].l_nmbc133c
         LET l_total_3_sum  = l_total_3_sum + g_nmbc3_d[l_ac].l_amt3
         
         LET l_nmbc100_t = g_nmbc_d[l_ac].nmbc100
      END IF
      #150824-00011#1---add---str--

      #end add-point
 
      CALL anmq320_detail_show("'1'")      
 
      CALL anmq320_nmbc_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_nmbc_d.deleteElement(g_nmbc_d.getLength())   
   CALL g_nmbc2_d.deleteElement(g_nmbc2_d.getLength())
 
   CALL g_nmbc3_d.deleteElement(g_nmbc3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   

   IF l_ac > 1 THEN
      #150824-00011#1---add---str--
      LET g_nmbc_d[l_ac].nmbc002 = ''
      LET g_nmbc2_d[l_ac].nmbc002 = ''
      LET g_nmbc3_d[l_ac].nmbc002 = ''
      LET g_nmbc_d[l_ac].nmbc002_desc = ''
      LET g_nmbc2_d[l_ac].nmbc002_2_desc = ''
      LET g_nmbc3_d[l_ac].nmbc002_3_desc = ''
      LET g_nmbc_d[l_ac].glab005 = ''
      LET g_nmbc_d[l_ac].glab005_desc = ''
      LET g_nmbc_d[l_ac].nmbc100 = l_nmbc100_t," ",cl_getmsg('aap-00287',g_dlang)
      LET g_nmbc2_d[l_ac].nmbc100 = l_nmbc100_t," ",cl_getmsg('aap-00287',g_dlang)
      LET g_nmbc3_d[l_ac].nmbc100 = l_nmbc100_t," ",cl_getmsg('aap-00287',g_dlang)
      
      LET g_nmbc_d[l_ac].l_amtbefore = l_total_b_sum  
      LET g_nmbc_d[l_ac].l_nmbc103d = l_total_d_sum 
      LET g_nmbc_d[l_ac].l_nmbc103c = l_total_c_sum
      LET g_nmbc_d[l_ac].l_amt = l_total_sum  
      
      LET g_nmbc_d[l_ac].l_amt1before = l_total_1b_sum 
      LET g_nmbc_d[l_ac].l_nmbc113d = l_total_1d_sum 
      LET g_nmbc_d[l_ac].l_nmbc113c = l_total_1c_sum  
      LET g_nmbc_d[l_ac].l_amt1 = l_total_1_sum 
      #本位幣二
      LET g_nmbc2_d[l_ac].l_amt2before = l_total_2b_sum
      LET g_nmbc2_d[l_ac].l_nmbc123d = l_total_2d_sum 
      LET g_nmbc2_d[l_ac].l_nmbc123c = l_total_2c_sum
      LET g_nmbc2_d[l_ac].l_amt2 = l_total_2_sum
      #本位幣三           
      LET g_nmbc3_d[l_ac].l_amt3before = l_total_3b_sum 
      LET g_nmbc3_d[l_ac].l_nmbc133d = l_total_3d_sum 
      LET g_nmbc3_d[l_ac].l_nmbc133c = l_total_3c_sum  
      LET g_nmbc3_d[l_ac].l_amt3  = l_total_3_sum
      LET l_ac = l_ac + 1
      #150824-00011#1---add---end--
      IF g_input.l_showother = 'Y' THEN
         LET g_nmbc_d[l_ac].nmbc100       = cl_getmsg("aps-00134",g_lang)
         LET g_nmbc_d[l_ac].l_amt1before  = l_total_1b
         LET g_nmbc_d[l_ac].l_nmbc113d    = l_total_1d 
         LET g_nmbc_d[l_ac].l_nmbc113c    = l_total_1c 
         LET g_nmbc_d[l_ac].l_amt1        = l_total_1    
         LET g_nmbc2_d[l_ac].nmbc100      = cl_getmsg("aps-00134",g_lang)
         LET g_nmbc2_d[l_ac].l_amt2before = l_total_2b
         LET g_nmbc2_d[l_ac].l_nmbc123d   = l_total_2d 
         LET g_nmbc2_d[l_ac].l_nmbc123c   = l_total_2c 
         LET g_nmbc2_d[l_ac].l_amt2       = l_total_2
         LET g_nmbc3_d[l_ac].nmbc100      = cl_getmsg("aps-00134",g_lang)
         LET g_nmbc3_d[l_ac].l_amt3before = l_total_3b
         LET g_nmbc3_d[l_ac].l_nmbc133d   = l_total_3d 
         LET g_nmbc3_d[l_ac].l_nmbc133c   = l_total_3c 
         LET g_nmbc3_d[l_ac].l_amt3       = l_total_3   
      END IF
   END IF
   LET g_tot_cnt = g_nmbc_d.getLength()
   #end add-point
 
   LET g_detail_cnt = g_nmbc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq320_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq320_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq320_detail_action_trans()
 
   IF g_nmbc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq320_fetch()
   END IF
   
      CALL anmq320_filter_show('nmbc002','b_nmbc002')
   CALL anmq320_filter_show('nmbc100','b_nmbc100')
   CALL anmq320_filter_show('nmbccomp','b_nmbccomp')
   CALL anmq320_filter_show('nmbcdocno','b_nmbcdocno')
   CALL anmq320_filter_show('nmbcseq','b_nmbcseq')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq320_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="anmq320.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq320_detail_show(ps_page)
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
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq320_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON nmbc002,nmbc100,nmbccomp,nmbcdocno,nmbcseq
                          FROM s_detail1[1].b_nmbc002,s_detail1[1].b_nmbc100,s_detail1[1].b_nmbccomp, 
                              s_detail1[1].b_nmbcdocno,s_detail1[1].b_nmbcseq
 
         BEFORE CONSTRUCT
                     DISPLAY anmq320_filter_parser('nmbc002') TO s_detail1[1].b_nmbc002
            DISPLAY anmq320_filter_parser('nmbc100') TO s_detail1[1].b_nmbc100
            DISPLAY anmq320_filter_parser('nmbccomp') TO s_detail1[1].b_nmbccomp
            DISPLAY anmq320_filter_parser('nmbcdocno') TO s_detail1[1].b_nmbcdocno
            DISPLAY anmq320_filter_parser('nmbcseq') TO s_detail1[1].b_nmbcseq
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_nmbc002>>----
         #Ctrlp:construct.c.page1.b_nmbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbc002
            #add-point:ON ACTION controlp INFIELD b_nmbc002 name="construct.c.filter.page1.b_nmbc002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
              #160122-00001#26 - add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#26 -add -end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbc002  #顯示到畫面上
            NEXT FIELD b_nmbc002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbc002_desc>>----
         #----<<b_nmbc100>>----
         #Ctrlp:construct.c.page1.b_nmbc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbc100
            #add-point:ON ACTION controlp INFIELD b_nmbc100 name="construct.c.filter.page1.b_nmbc100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbc100  #顯示到畫面上
            NEXT FIELD b_nmbc100                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_amtbefore>>----
         #----<<l_nmbc103d>>----
         #----<<l_nmbc103c>>----
         #----<<l_amt>>----
         #----<<l_amt1before>>----
         #----<<l_nmbc113d>>----
         #----<<l_nmbc113c>>----
         #----<<l_amt1>>----
         #----<<glab005>>----
         #----<<glab005_desc>>----
         #----<<b_nmbccomp>>----
         #Ctrlp:construct.c.page1.b_nmbccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbccomp
            #add-point:ON ACTION controlp INFIELD b_nmbccomp name="construct.c.filter.page1.b_nmbccomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbccomp  #顯示到畫面上
            NEXT FIELD b_nmbccomp                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbcdocno>>----
         #Ctrlp:construct.c.filter.page1.b_nmbcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbcdocno
            #add-point:ON ACTION controlp INFIELD b_nmbcdocno name="construct.c.filter.page1.b_nmbcdocno"
            
            #END add-point
 
 
         #----<<b_nmbcseq>>----
         #Ctrlp:construct.c.filter.page1.b_nmbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbcseq
            #add-point:ON ACTION controlp INFIELD b_nmbcseq name="construct.c.filter.page1.b_nmbcseq"
            
            #END add-point
 
 
         #----<<nmbc002_2_desc>>----
         #----<<l_amt2before>>----
         #----<<l_nmbc123d>>----
         #----<<l_nmbc123c>>----
         #----<<l_amt2>>----
         #----<<nmbc002_3_desc>>----
         #----<<l_amt3before>>----
         #----<<l_nmbc133d>>----
         #----<<l_nmbc133c>>----
         #----<<l_amt3>>----
   
 
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL anmq320_filter_show('nmbc002','b_nmbc002')
   CALL anmq320_filter_show('nmbc100','b_nmbc100')
   CALL anmq320_filter_show('nmbccomp','b_nmbccomp')
   CALL anmq320_filter_show('nmbcdocno','b_nmbcdocno')
   CALL anmq320_filter_show('nmbcseq','b_nmbcseq')
 
    
   CALL anmq320_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq320_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="anmq320.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq320_filter_show(ps_field,ps_object)
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
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = anmq320_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.insert" >}
#+ insert
PRIVATE FUNCTION anmq320_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq320.modify" >}
#+ modify
PRIVATE FUNCTION anmq320_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq320_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.delete" >}
#+ delete
PRIVATE FUNCTION anmq320_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq320.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq320_detail_action_trans()
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
 
{<section id="anmq320.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq320_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
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
            IF g_nmbc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmbc_d.getLength() AND g_nmbc_d.getLength() > 0
            LET g_detail_idx = g_nmbc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmbc_d.getLength() THEN
               LET g_detail_idx = g_nmbc_d.getLength()
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
 
{<section id="anmq320.mask_functions" >}
 &include "erp/anm/anmq320_mask.4gl"
 
{</section>}
 
{<section id="anmq320.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 計算帳戶期初餘額
# Memo...........:
# Usage..........: CALL anmq320_amt(p_nmbc002,p_nmbc100)
# Input parameter: p_nmbc002     交易帳戶
#                  p_nmbc100     交易幣別
#                  r_amtbefore   期初餘額
#                  r_amt1before  本幣期初餘額
#                  r_amt2before  本位幣二期初餘額
#                  r_amt3before  本位幣三期初餘額
# Date & Author..: 15/08/07 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq320_amt(p_nmbc002,p_nmbc100)
DEFINE l_nmbc103d       LIKE nmbc_t.nmbc103
DEFINE l_nmbc103c       LIKE nmbc_t.nmbc103
DEFINE l_nmbc113d       LIKE nmbc_t.nmbc113
DEFINE l_nmbc113c       LIKE nmbc_t.nmbc113
DEFINE l_nmbc123d       LIKE nmbc_t.nmbc123
DEFINE l_nmbc123c       LIKE nmbc_t.nmbc123
DEFINE l_nmbc133d       LIKE nmbc_t.nmbc133
DEFINE l_nmbc133c       LIKE nmbc_t.nmbc133
DEFINE r_amtbefore      LIKE nmbc_t.nmbc103
DEFINE r_amt1before     LIKE nmbc_t.nmbc113
DEFINE r_amt2before     LIKE nmbc_t.nmbc123
DEFINE r_amt3before     LIKE nmbc_t.nmbc133
DEFINE l_sum103         LIKE nmbc_t.nmbc133
DEFINE l_sum104         LIKE nmbc_t.nmbc133
DEFINE l_sum113         LIKE nmbc_t.nmbc133
DEFINE l_sum114         LIKE nmbc_t.nmbc133
DEFINE l_sum123         LIKE nmbc_t.nmbc133
DEFINE l_sum124         LIKE nmbc_t.nmbc133
DEFINE l_sum133         LIKE nmbc_t.nmbc133
DEFINE l_sum134         LIKE nmbc_t.nmbc133
DEFINE l_day            LIKE glap_t.glapdocdt
DEFINE p_nmbc002        LIKE nmbc_t.nmbc002
DEFINE p_nmbc100        LIKE nmbc_t.nmbc100
DEFINE l_year           LIKE nmbx_t.nmbx001
   
   LET l_year = YEAR(g_input.sdate) 
   #年初借貸金額
   SELECT SUM(COALESCE(nmbx103,0)),SUM(COALESCE(nmbx104,0)),  #原幣
          SUM(COALESCE(nmbx113,0)),SUM(COALESCE(nmbx114,0)),  
          SUM(COALESCE(nmbx123,0)),SUM(COALESCE(nmbx124,0)),
          SUM(COALESCE(nmbx133,0)),SUM(COALESCE(nmbx134,0))
     INTO l_sum103,l_sum104,l_sum113,l_sum114,l_sum123,l_sum124,l_sum133,l_sum134
     FROM nmbx_t 
    WHERE nmbxent = g_enterprise AND nmbxcomp = g_input.nmbccomp
      AND nmbx100 = p_nmbc100
      AND nmbx001 = l_year  AND nmbx002 = 0
      AND nmbx003 = p_nmbc002 

   #期初
   LET l_day = MDY(1,1,YEAR(g_input.sdate))
   SELECT SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc103 ELSE 0 END,0)), #借
          SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc103 ELSE 0 END,0)), #貸
          SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc113 ELSE 0 END,0)), #借
          SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc113 ELSE 0 END,0)), #貸
          SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc123 ELSE 0 END,0)),
          SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc123 ELSE 0 END,0)),
          SUM(COALESCE(CASE WHEN nmbc006='1' THEN nmbc133 ELSE 0 END,0)),
          SUM(COALESCE(CASE WHEN nmbc006='2' THEN nmbc133 ELSE 0 END,0))
      INTO l_nmbc103d,l_nmbc103c,l_nmbc113d,l_nmbc113c,l_nmbc123d,l_nmbc123c,l_nmbc133d,l_nmbc133c
      FROM nmbc_t 
     WHERE nmbcent  = g_enterprise     AND nmbc100 = p_nmbc100
       AND nmbccomp = g_input.nmbccomp AND nmbc002 = p_nmbc002
       AND nmbc005 < g_input.sdate     AND nmbc005 >= l_day
       
   IF cl_null(l_sum103) THEN LET l_sum103 = 0 END IF
   IF cl_null(l_sum104) THEN LET l_sum104 = 0 END IF
   IF cl_null(l_sum113) THEN LET l_sum113 = 0 END IF
   IF cl_null(l_sum114) THEN LET l_sum114 = 0 END IF
   IF cl_null(l_sum123) THEN LET l_sum123 = 0 END IF
   IF cl_null(l_sum124) THEN LET l_sum124 = 0 END IF
   IF cl_null(l_sum133) THEN LET l_sum133 = 0 END IF
   IF cl_null(l_sum134) THEN LET l_sum134 = 0 END IF
   IF cl_null(l_nmbc103d) THEN LET l_nmbc103d = 0 END IF
   IF cl_null(l_nmbc103c) THEN LET l_nmbc103c = 0 END IF
   IF cl_null(l_nmbc113d) THEN LET l_nmbc113d = 0 END IF
   IF cl_null(l_nmbc113c) THEN LET l_nmbc113c = 0 END IF
   IF cl_null(l_nmbc123d) THEN LET l_nmbc123d = 0 END IF
   IF cl_null(l_nmbc123c) THEN LET l_nmbc123c = 0 END IF
   IF cl_null(l_nmbc133d) THEN LET l_nmbc133d = 0 END IF
   IF cl_null(l_nmbc133c) THEN LET l_nmbc133c = 0 END IF
   LET r_amtbefore  = 0
   LET r_amt1before = 0
   LET r_amt2before = 0
   LET r_amt3before = 0
   
   LET r_amtbefore  = l_sum103 + l_nmbc103d - l_sum104 - l_nmbc103c
   LET r_amt1before = l_sum113 + l_nmbc113d - l_sum114 - l_nmbc113c
   LET r_amt2before = l_sum123 + l_nmbc123d - l_sum124 - l_nmbc123c
   LET r_amt3before = l_sum133 + l_nmbc133d - l_sum134 - l_nmbc133c
   RETURN r_amtbefore,r_amt1before,r_amt2before,r_amt3before
END FUNCTION
################################################################################
# Descriptions...: 清空還原預設
# Memo...........: 
# Usage..........: CALL anmq320_qbe_clear()
# Date & Author..: 150806 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq320_qbe_clear()
DEFINE l_glaa015  LIKE type_t.chr1
DEFINE l_glaa019  LIKE type_t.chr1
DEFINE l_sql      STRING
DEFINE l_ooef001  LIKE ooef_t.ooef001
DEFINE l_wc       STRING             #160816-00012#4 Add
DEFINE l_count    LIKE type_t.num5   #160816-00012#4 Add
 
   CLEAR FORM
   INITIALIZE g_input.* TO NULL
   CALL g_nmbc_d.clear()
   CALL g_nmbc2_d.clear()
   CALL g_nmbc3_d.clear()
   SELECT ooef017 INTO g_input.nmbccomp
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_site
    #160816-00012#4 Add  ---(S)---
    #检查用户是否有资金中心对应法人的权限
    CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
    LET l_count = 0
    LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                "   AND ooef001 = '",g_input.nmbccomp,"'",
                "   AND ooef003 = 'Y'",
                "   AND ",l_wc CLIPPED
    PREPARE anmt310_count1_prep FROM l_sql
    EXECUTE anmt310_count1_prep INTO l_count
    IF cl_null(l_count) THEN LET l_count = 0 END IF
    IF l_count = 0 THEN
       LET g_input.nmbccomp = ''            
    END IF
    #160816-00012#4 Add  ---(E)---
   LET g_input.nmbccomp_desc = s_desc_get_department_desc(g_input.nmbccomp)
   LET g_input.l_showother ='N'   #150824-00011#1 mark
   LET g_input.l_showother ='Y'   #150824-00011#1 add
   LET g_input.a = 'Y'  #150824-00011#1 add g_input.a
   DISPLAY BY NAME g_input.a #150824-00011#1 add 
   CALL cl_set_comp_visible('page_2,page_3',FALSE)
   CALL cl_set_comp_visible('l_amt1before,l_nmbc113d,l_nmbc113c,l_amt1',FALSE)
   LET g_input.sdate = g_today
   LET g_input.edate = g_today
   DISPLAY BY NAME g_input.nmbccomp,g_input.nmbccomp_desc,g_input.sdate,g_input.edate
END FUNCTION

################################################################################
# Descriptions...: 新建临时表--150824-00011#1
# Date & Author..: 2015/10/20 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq320_create_tmp()
   DROP TABLE anmq320_tmp01;            #160727-00019#4 Mod  anmq320_print1_tmp--> anmq320_tmp01
   CREATE TEMP TABLE anmq320_tmp01(     #160727-00019#4 Mod  anmq320_print1_tmp--> anmq320_tmp01
   l_nmbccomp_desc  VARCHAR(500),
   l_date  VARCHAR(500),
   nmbc002  VARCHAR(10), 
   l_nmbc002_desc  VARCHAR(500),
   nmbc100  VARCHAR(10), 
   l_amtbefore  DECIMAL(20,6), 
   l_nmbc103d  DECIMAL(20,6), 
   l_nmbc103c  DECIMAL(20,6), 
   l_amt  DECIMAL(20,6), 
   l_amt1before  DECIMAL(20,6), 
   l_nmbc113d  DECIMAL(20,6), 
   l_nmbc113c  DECIMAL(20,6), 
   l_amt1  DECIMAL(20,6),
   glab005  VARCHAR(500), 
   glab005_desc  VARCHAR(500)
   )
   DROP TABLE anmq320_tmp02;          #160727-00019#4 Mod  anmq320_print2_tmp--> anmq320_tmp02
   CREATE TEMP TABLE anmq320_tmp02(   #160727-00019#4 Mod  anmq320_print2_tmp--> anmq320_tmp02
   l_nmbccomp_desc  VARCHAR(500),
   l_date  VARCHAR(500),
   nmbc002  VARCHAR(10), 
   l_nmbc002_desc  VARCHAR(500),
   nmbc100  VARCHAR(10), 
   l_amt2before  DECIMAL(20,6), 
   l_nmbc123d  DECIMAL(20,6), 
   l_nmbc123c  DECIMAL(20,6), 
   l_amt2  DECIMAL(20,6),
   nmbc100_1  VARCHAR(10)
   )
 
   DROP TABLE anmq320_tmp03;           #160727-00019#4 Mod  anmq320_print3_tmp--> anmq320_tmp03
   CREATE TEMP TABLE anmq320_tmp03(    #160727-00019#4 Mod  anmq320_print3_tmp--> anmq320_tmp03
   l_nmbccomp_desc  VARCHAR(500),
   l_date  VARCHAR(500),
   nmbc002  VARCHAR(10), 
   l_nmbc002_desc  VARCHAR(500),
   nmbc100  VARCHAR(10), 
   l_amt3before  DECIMAL(20,6), 
   l_nmbc133d  DECIMAL(20,6), 
   l_nmbc133c  DECIMAL(20,6), 
   l_amt3  DECIMAL(20,6),
   nmbc100_1  VARCHAR(10)
   )
END FUNCTION

################################################################################
# Descriptions...: 選擇列印頁簽
# Memo...........:
# Usage..........: CALL anmq320_open_s01()
# Date & Author..: 2015/10/21 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq320_open_s01()
   DEFINE b_chk1      LIKE type_t.chr1
   DEFINE b_chk2      LIKE type_t.chr1
   DEFINE b_chk3      LIKE type_t.chr1
   DEFINE l_glaa015   LIKE type_t.chr1
   DEFINE l_glaa019   LIKE type_t.chr1
   
   OPEN WINDOW w_anmq320_s01 WITH FORM cl_ap_formpath("anm","anmq320_s01")
   CALL cl_set_comp_required('b_chk1',TRUE)
   CALL cl_set_comp_required('b_chk2',TRUE)
   CALL cl_set_comp_required('b_chk3',TRUE)
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaacomp = g_input.nmbccomp
      AND glaa014 = 'Y'
      AND glaaent = g_enterprise  #160905-00007#8 add
   IF l_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('b_chk2',TRUE)
   ELSE
      CALL cl_set_comp_visible('b_chk2',FALSE)
   END IF
   IF l_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('b_chk3',TRUE)
   ELSE
      CALL cl_set_comp_visible('b_chk3',FALSE)
   END IF
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME b_chk1,b_chk2,b_chk3 ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT
            LET b_chk1 = 'Y'
            LET b_chk2 = 'N'
            LET b_chk3 = 'N'

      END INPUT

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

   END DIALOG

   #畫面關閉
   CLOSE WINDOW w_anmq320_s01
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
   ELSE
      IF b_chk1 = 'Y' THEN
         CALL anmq320_x01(' 1=1','anmq320_tmp01',g_input.l_showother)   #160727-00019#4 Mod  anmq320_print1_tmp--> anmq320_tmp01
      END IF
      IF b_chk2 = 'Y' THEN
         CALL anmq320_x02(' 1=1','anmq320_tmp02')                  #160727-00019#4 Mod  anmq320_print2_tmp--> anmq320_tmp02
      END IF
      IF b_chk3 = 'Y' THEN
         CALL anmq320_x03(' 1=1','anmq320_tmp03')             #160727-00019#4 Mod  anmq320_print3_tmp--> anmq320_tmp03
      END IF
   END IF
END FUNCTION

 
{</section>}
 
