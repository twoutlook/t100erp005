#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq430.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-11-30 09:38:14), PR版次:0007(2016-11-30 14:50:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: anmq430
#+ Description: 應付票據異動查詢
#+ Creator....: 06816(2015-10-22 14:19:25)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="anmq430.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160122-00001#26 2016/2/17 07673  添加交易账户编号用户权限控管
#160318-00005#27 2016/03/23 By 07900   重复错误信息修改
#160321-00016#39 2016/03/30 By Jessy   將重複內容的錯誤訊息置換為公用錯誤訊息
#160526-00037#1  2016/06/16 By 02599   功能调整
#160526-00037#3  2016/07/07 By 01531   新增作业anmq431
#160816-00012#4  2016/09/08 By 07900   ANM增加资金中心，帐套，法人三个栏位权限
#161021-00038#1  2016/10/26 By 06821   組織類型與職能開窗調整
#161125-00036#3  161129     By albireo 第一單身增加nmck012欄位顯示
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
PRIVATE TYPE type_g_nmck_d RECORD
       
       sel LIKE type_t.chr1, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmck005 LIKE nmck_t.nmck005, 
   nmck005_desc LIKE type_t.chr500, 
   nmck004 LIKE nmck_t.nmck004, 
   l_nmck004_desc LIKE type_t.chr500, 
   nmck024 LIKE nmck_t.nmck024, 
   nmck025 LIKE nmck_t.nmck025, 
   nmck002 LIKE nmck_t.nmck002, 
   nmck002_desc LIKE type_t.chr500, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck011 LIKE nmck_t.nmck011, 
   nmck012 LIKE nmck_t.nmck012, 
   nmck100 LIKE nmck_t.nmck100, 
   nmck103 LIKE nmck_t.nmck103, 
   nmck101 LIKE nmck_t.nmck101, 
   nmck113 LIKE nmck_t.nmck113, 
   nmck030 LIKE nmck_t.nmck030, 
   nmck031 LIKE nmck_t.nmck031, 
   nmck026 LIKE nmck_t.nmck026, 
   nmckcomp LIKE nmck_t.nmckcomp
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_nmch_d RECORD
   nmchdocdt LIKE nmch_t.nmchdocdt,
   nmch001   LIKE nmch_t.nmch001, 
   nmchdocno LIKE nmch_t.nmchdocno, 
   nmci103   LIKE nmci_t.nmci103,   #160526-00037#1 add
   nmci113   LIKE nmci_t.nmci113,   #160526-00037#1 add
   nmchstus  LIKE nmch_t.nmchstus
         END RECORD

TYPE type_g_nmck2_d RECORD
   nmck100    LIKE nmck_t.nmck100,
   l_total    LIKE type_t.num20_6, 
   nmck113_s  LIKE nmck_t.nmck113, #160526-00037#1 add
   l_numdocno LIKE type_t.num10
          END RECORD
DEFINE g_master   RECORD
   nmcksite       LIKE nmck_t.nmcksite,
   nmcksite_desc  LIKE type_t.chr500,
   nmckcomp       LIKE nmck_t.nmckcomp,
   nmckcomp_desc  LIKE type_t.chr500
              END RECORD

DEFINE g_glaald     LIKE glaa_t.glaald
DEFINE g_nmckcomp_str  STRING   #組織範圍
DEFINE g_nmch_d       DYNAMIC ARRAY OF type_g_nmch_d
DEFINE g_nmck2_d       DYNAMIC ARRAY OF type_g_nmck2_d
DEFINE l_ac2          LIKE type_t.num10
DEFINE l_ac3          LIKE type_t.num10
DEFINE g_sql_bank     STRING                 #160122-00001#26
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmck_d            DYNAMIC ARRAY OF type_g_nmck_d
DEFINE g_nmck_d_t          type_g_nmck_d
 
 
 
 
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
 
{<section id="anmq430.main" >}
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
   #160526-00037#3 add s---
   IF g_argv[01] = '1' THEN
      LET g_prog = 'anmq431'
   END IF
   #160526-00037#3 add e---
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
   DECLARE anmq430_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq430_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq430_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq430 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq430_init()   
 
      #進入選單 Menu (="N")
      CALL anmq430_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq430
      
   END IF 
   
   CLOSE anmq430_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq430.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq430_init()
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
   
      CALL cl_set_combo_scc('b_nmck026','8711') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_nmck030','8715')
#   CALL cl_set_combo_scc('b_nmch001','8714') #160526-00037#1 mark
   CALL cl_set_combo_scc('b_nmch001','8711')  #160526-00037#1 add
   CALL cl_set_combo_scc_part('b_nmchstus','13','N,Y,A,D,R,W,X')
   CALL anmq430_x01_tmp()
   CALL s_fin_create_account_center_tmp()
   
   #160122-00001#26 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#26 --add--end
   
   #160526-00037#3 add s---
   IF g_prog = 'anmq431' THEN
      CALL cl_set_comp_visible("b_nmck024,b_nmck025,b_nmck002,b_nmck002_desc,b_nmck030,b_nmck031",FALSE)   
      CALL cl_set_comp_att_text("b_nmck103",cl_getmsg("anm-03008",g_dlang))      
   END IF
   #160526-00037#3 add e---
   #end add-point
 
   CALL anmq430_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq430.default_search" >}
PRIVATE FUNCTION anmq430_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   #160526-00037#3 add s---
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmckcomp = '", g_argv[02], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " nmckdocno = '", g_argv[03], "' AND "
   END IF

   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
   RETURN
   #160526-00037#3 add e---
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmckcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmckdocno = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
#   IF g_wc = " 1=2" THEN
#      LET g_wc = " 1= 1"
#   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq430.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq430_ui_dialog() 
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
   DEFINE l_ld      LIKE glaa_t.glaald
   DEFINE l_comp    LIKE ooef_t.ooef001
   DEFINE l_errno   LIKE gzze_t.gzze001
   DEFINE l_success LIKE type_t.num10
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_date_chr   LIKE type_t.chr100 #160526-00037#1 add
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_wc       STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5  #160816-00012#4 Add
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
 
   
   CALL anmq430_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmck_d.clear()
 
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
 
         CALL anmq430_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,g_master.nmckcomp_desc
            ATTRIBUTE(WITHOUT DEFAULTS)
                        
            ON ACTION controlp INFIELD nmcksite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmcksite
               LET g_qryparam.default2 = g_master.nmcksite_desc  #g_master.nmcksite_desc #說明(簡稱) #160816-00012#4 add g_master.nmcksite_desc           
               LET g_qryparam.where = " ooef206 = 'Y' "
               #CALL q_ooef001()   #161021-00038#1 mark
               CALL q_ooef001_33() #161021-00038#1 add
               LET g_master.nmcksite = g_qryparam.return1
               LET g_master.nmcksite_desc = g_qryparam.return2
               DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc
               NEXT FIELD nmcksite
               
            AFTER FIELD nmcksite
               LET g_master.nmcksite_desc = ''
               DISPLAY BY NAME g_master.nmcksite_desc
               IF NOT cl_null(g_master.nmcksite) THEN 
                  CALL anmq430_nmcksite_chk(g_master.nmcksite)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.nmcksite
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_orga_get_comp_ld(g_master.nmcksite) RETURNING g_sub_success,g_errno,g_master.nmckcomp,g_glaald
                 #160816-00012#4 Add  ---(S)---
                 #检查用户是否有资金中心对应法人的权限
                 CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                 LET l_count = 0
                 LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                             "   AND ooef001 = '",g_master.nmckcomp,"'",
                             "   AND ooef003 = 'Y'",
                             "   AND ",l_wc CLIPPED
                 PREPARE anmp410_count_prep_1 FROM l_sql
                 EXECUTE anmp410_count_prep_1 INTO l_count
                 IF cl_null(l_count) THEN LET l_count = 0 END IF
                 IF l_count = 0 THEN
                    LET g_master.nmckcomp = ''           
                    DISPLAY BY NAME g_master.nmckcomp
                 END IF
                 #160816-00012#4 Add  ---(E)--- 
                 CALL s_fin_account_center_sons_query('6',g_master.nmcksite,g_today,'')
                  CALL s_fin_account_center_comp_str()  RETURNING g_nmckcomp_str
                  CALL s_fin_get_wc_str(g_nmckcomp_str) RETURNING g_nmckcomp_str
               END IF
               LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
               DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc
               LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc
               
            ON ACTION controlp INFIELD nmckcomp
               #160816-00012#4 Add  ---(S)---
               CALL s_fin_account_center_sons_query('6',g_master.nmcksite,g_today,'')
               CALL s_fin_account_center_comp_str()  RETURNING g_nmckcomp_str
               CALL s_fin_get_wc_str(g_nmckcomp_str) RETURNING g_nmckcomp_str
               #160816-00012#4 Add  ---(E)---
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmckcomp
               LET g_qryparam.default2 = g_master.nmckcomp_desc #g_master.nmckcomp_desc #說明(簡稱)
               #160816-00012#4 MARK---(S)---
#               IF cl_null(g_nmckcomp_str) THEN                  
#                  LET g_qryparam.where = " ooef001 IN(SELECT ooef017 FROM ooef_t WHERE ooef001 = '",g_master.nmcksite,"' )"                
#               ELSE                        
#                  LET g_qryparam.where = " ooef001 IN ",g_nmckcomp_str CLIPPED
#               END IF
               #160816-00012#4 MARK---(S)---
               #160816-00012#4 Add  ---(S)---
               LET g_qryparam.where = " ooef001 IN ",g_nmckcomp_str CLIPPED               
               #160816-00012#4 Add  ---(E)---
               #CALL q_ooef001()   #161021-00038#1 mark
               CALL q_ooef001_2()  #161021-00038#1 add
               LET g_master.nmckcomp = g_qryparam.return1
               LET g_master.nmckcomp_desc = g_qryparam.return2
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc
               NEXT FIELD nmckcomp
               
            AFTER FIELD nmckcomp
               LET g_master.nmckcomp_desc = ''
               DISPLAY BY NAME g_master.nmckcomp_desc
               IF NOT cl_null(g_master.nmckcomp) THEN
                  CALL s_fin_comp_chk(g_master.nmckcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#39 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#39 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.nmcksite) THEN  #160816-00012#4 Add  
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt
                       FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef017 = g_master.nmckcomp 
                        AND ooef001 = g_master.nmcksite
                     IF s_chr_get_index_of(g_nmckcomp_str,g_master.nmckcomp,1) = 0 AND l_cnt = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-02928'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.nmckcomp = ''
                        NEXT FIELD CURRENT
                     END IF
                  END IF      #160816-00012#4 Add  
                  #160816-00012#4 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_master.nmckcomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep2 FROM l_sql
                  EXECUTE anmp410_count_prep2 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''                     
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#4 Add  ---(E)---
               END IF

                  

               LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc

         END INPUT 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc ON nmckdocno,nmck004,nmck011,nmck100
                      FROM nmckdocno,nmck004,nmck011,nmck100
               
            ON ACTION controlp INFIELD nmckdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " nmckcomp = '",g_master.nmckcomp,"' AND nmcksite = '",g_master.nmcksite,"' "
               CALL q_nmckdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmckdocno  #顯示到畫面上
               NEXT FIELD nmckdocno                     #返回原欄位
            
            ON ACTION controlp INFIELD nmck004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160122-00001#26 - add -str
			      LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"   
               #160122-00001#26 -add end
               CALL q_nmas_01()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmck004  #顯示到畫面上
               LET g_qryparam.where = " " #160122-00001#26 - add
               NEXT FIELD nmck004                     #返回原欄位
                           
            ON ACTION controlp INFIELD nmck100
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_aooi001_1()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmck100  #顯示到畫面上
               NEXT FIELD nmck100                     #返回原欄位
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_nmck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmq430_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq430_b_fill2()
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
         DISPLAY ARRAY g_nmch_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)  
            BEFORE DISPLAY 
               LET g_current_page = 2            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_nmch_d.getLength() TO FORMONLY.cnt
               LET g_master_idx = l_ac
            
            ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                     
               ON ACTION prog_anmt440
                  LET g_action_choice="prog_anmt440"
                  IF cl_auth_chk_act("prog_anmt440") THEN
                     INITIALIZE la_param.* TO NULL
                     IF g_nmch_d[g_detail_idx2].nmch001 = '1' THEN
                        LET la_param.prog  = 'anmt440'
                     ELSE                  
                        LET la_param.prog  = 'anmt450'
                     END IF
                     LET la_param.param[1] = g_nmck_d[g_master_idx].nmckcomp
                     LET la_param.param[2] = g_nmch_d[g_detail_idx2].nmchdocno
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  END IF
               END MENU
         END DISPLAY
         
         DISPLAY ARRAY g_nmck2_d TO s_detail3.*   ATTRIBUTES(COUNT=g_detail_cnt)  
         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL anmq430_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL anmq430_qbe_clear()
#            LET g_wc = "1 =1" #160526-00037#1 mark
            #160526-00037#1--add--str--
            LET l_date_chr = ">=",g_today
            DISPLAY l_date_chr TO nmck011
            LET g_wc = " nmck011 >='",g_today,"'"
            #160526-00037#1--add--end
            #end add-point
            NEXT FIELD nmcksite
 
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
            CALL anmq430_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_nmck_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_nmch_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_nmck2_d)
               LET g_export_id[3]   = "s_detail3"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmq430_b_fill()
 
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
            CALL anmq430_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq430_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq430_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq430_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmck_d.getLength()
               LET g_nmck_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmck_d.getLength()
               LET g_nmck_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmck_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmck_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq430_filter()
            #add-point:ON ACTION filter name="menu.filter"
            NEXT FIELD nmcksite   #160526-00037#1 add
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL anmq430_ins_tmp()
               #160526-00037#3 add s---
               IF g_prog = 'anmq431' THEN 
                  CALL anmq430_x02(" 1 = 1","anmq430_x01_tmp")
               ELSE  
               #160526-00037#3 add e---               
                  CALL anmq430_x01(" 1 = 1","anmq430_x01_tmp")
               END IF #160526-00037#3   
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL anmq430_ins_tmp()
               #160526-00037#3 add s---
               IF g_prog = 'anmq431' THEN 
                  CALL anmq430_x02(" 1 = 1","anmq430_x01_tmp")
               ELSE  
               #160526-00037#3 add e---               
                  CALL anmq430_x01(" 1 = 1","anmq430_x01_tmp")
               END IF #160526-00037#3   
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL anmq430_qbe_clear()
               LET g_wc = "1 =1"
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
 
{<section id="anmq430.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq430_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_nmck005_desc  LIKE type_t.chr500
   DEFINE l_nmck005_desc_sql STRING #160526-00037#1 add
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
 
   CALL g_nmck_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',nmckdocno,nmck005,'',nmck004,'',nmck024,nmck025,nmck002,'',nmckdocdt, 
       nmck011,nmck012,nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck026,nmckcomp  ,DENSE_RANK() OVER( ORDER BY nmck_t.nmckcomp, 
       nmck_t.nmckdocno) AS RANK FROM nmck_t",
 
 
                     "",
                     " WHERE AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmck_t"),
                     " ORDER BY nmck_t.nmckcomp,nmck_t.nmckdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET l_nmck005_desc_sql= "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = nmck005 AND pmaal002 = '",g_dlang,"')" #160526-00037#1 add
#   LET ls_sql_rank = " SELECT UNIQUE 'N',nmckdocno,nmck004,'',nmck024,nmck025,nmck002,'',nmckdocdt,",     #160526-00037#1 mark
#                     "        nmck011,nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck005,nmckcomp ", #160526-00037#1 mark
   #160526-00037#3 add s---
   IF g_prog = 'anmq431' THEN
      LET ls_sql_rank = " SELECT UNIQUE 'N',nmckdocno,nmck005,",l_nmck005_desc_sql,",nmck004,'',nmck024,nmck025,nmck002,'',nmckdocdt,", #160526-00037#1 add
                        "        nmck011,nmck012,nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck026,nmckcomp ", #160526-00037#1 add   #161125-00036#3 add nmck012
                        "   FROM nmck_t ", 
                        "  WHERE nmckent= ? AND nmck023 = '20' AND ", ls_wc,
                        " AND (nmck004 IN (",g_sql_bank,")",    #160122-00001#26 - add
                        " OR TRIM(nmck004) IS NULL )"  ,  #160122-00001#26 - add
                        "    AND nmcksite = '",g_master.nmcksite,"' AND nmckcomp = '",g_master.nmckcomp,"' " 
   ELSE  
   #160526-00037#3 add e---   
      LET ls_sql_rank = " SELECT UNIQUE 'N',nmckdocno,nmck005,",l_nmck005_desc_sql,",nmck004,'',nmck024,nmck025,nmck002,'',nmckdocdt,", #160526-00037#1 add
                        "        nmck011,nmck012,nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck026,nmckcomp ", #160526-00037#1 add   #161125-00036#3 add nmck012
                        "   FROM nmck_t ", 
                        "  WHERE nmckent= ? AND nmck023 = '30' AND ", ls_wc,
                        " AND (nmck004 IN (",g_sql_bank,")",    #160122-00001#26 - add
                        " OR TRIM(nmck004) IS NULL )"  ,  #160122-00001#26 - add
                        "    AND nmcksite = '",g_master.nmcksite,"' AND nmckcomp = '",g_master.nmckcomp,"' "
   END IF  #160526-00037#3 add                     
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
 
   LET g_sql = "SELECT '',nmckdocno,nmck005,'',nmck004,'',nmck024,nmck025,nmck002,'',nmckdocdt,nmck011, 
       nmck012,nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck026,nmckcomp",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

  #160526-00037#1--mod--str--
#  LET g_sql = " SELECT UNIQUE 'N',nmckdocno,nmck004,'',nmck024,nmck025,nmck002,'',nmckdocdt,",
#               "        nmck011,nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck005,nmckcomp ",
  LET g_sql = " SELECT UNIQUE 'N',nmckdocno,nmck005,",l_nmck005_desc_sql,",nmck004,'',nmck024,nmck025,nmck002,'',nmckdocdt,",
               "        nmck011,nmck012,nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck026,nmckcomp ",   #161125-00036#3 add nmck012
  #160526-00037#1--mod--end
               "   FROM (",ls_sql_rank,")",
               "  ORDER BY nmck100,nmckdocno "
               

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq430_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq430_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_nmck_d[l_ac].sel,g_nmck_d[l_ac].nmckdocno,g_nmck_d[l_ac].nmck005,g_nmck_d[l_ac].nmck005_desc, 
       g_nmck_d[l_ac].nmck004,g_nmck_d[l_ac].l_nmck004_desc,g_nmck_d[l_ac].nmck024,g_nmck_d[l_ac].nmck025, 
       g_nmck_d[l_ac].nmck002,g_nmck_d[l_ac].nmck002_desc,g_nmck_d[l_ac].nmckdocdt,g_nmck_d[l_ac].nmck011, 
       g_nmck_d[l_ac].nmck012,g_nmck_d[l_ac].nmck100,g_nmck_d[l_ac].nmck103,g_nmck_d[l_ac].nmck101,g_nmck_d[l_ac].nmck113, 
       g_nmck_d[l_ac].nmck030,g_nmck_d[l_ac].nmck031,g_nmck_d[l_ac].nmck026,g_nmck_d[l_ac].nmckcomp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
#160526-00037#1--mark--str--
#      CALL s_desc_get_trading_partner_full_desc(g_nmck_d[l_ac].l_nmck005_desc) RETURNING l_nmck005_desc
#      LET g_nmck_d[l_ac].l_nmck005_desc = l_nmck005_desc
#160526-00037#1--mark--end
      LET g_nmck_d[l_ac].l_nmck004_desc = s_desc_get_nmas002_desc(g_nmck_d[l_ac].nmck004)
      LET g_nmck_d[l_ac].nmck002_desc = s_desc_get_ooial_desc(g_nmck_d[l_ac].nmck002)
      #end add-point
 
      CALL anmq430_detail_show("'1'")
 
      CALL anmq430_nmck_t_mask()
 
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
   CALL anmq430_b_fill3(ls_wc)
   #end add-point
 
   CALL g_nmck_d.deleteElement(g_nmck_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_nmck_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE anmq430_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq430_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq430_detail_action_trans()
 
   LET l_ac = 1
   IF g_nmck_d.getLength() > 0 THEN
      CALL anmq430_b_fill2()
   END IF
 
      CALL anmq430_filter_show('nmckdocno','b_nmckdocno')
   CALL anmq430_filter_show('nmck005','b_nmck005')
   CALL anmq430_filter_show('nmck004','b_nmck004')
   CALL anmq430_filter_show('nmck024','b_nmck024')
   CALL anmq430_filter_show('nmck025','b_nmck025')
   CALL anmq430_filter_show('nmck002','b_nmck002')
   CALL anmq430_filter_show('nmckdocdt','b_nmckdocdt')
   CALL anmq430_filter_show('nmck011','b_nmck011')
   CALL anmq430_filter_show('nmck012','b_nmck012')
   CALL anmq430_filter_show('nmck100','b_nmck100')
   CALL anmq430_filter_show('nmck103','b_nmck103')
   CALL anmq430_filter_show('nmck101','b_nmck101')
   CALL anmq430_filter_show('nmck113','b_nmck113')
   CALL anmq430_filter_show('nmck030','b_nmck030')
   CALL anmq430_filter_show('nmck031','b_nmck031')
   CALL anmq430_filter_show('nmck026','b_nmck026')
   CALL anmq430_filter_show('nmckcomp','b_nmckcomp')
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmq430.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq430_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_nmch_d.clear()   
  
   LET g_cnt = l_ac2
   LET l_ac2 = 1
   #第一筆：開票單
   SELECT nmckdocdt,'1',nmckdocno,nmckstus
         ,nmck103,nmck113 #160526-00037#1 add
     INTO g_nmch_d[l_ac2].nmchdocdt,g_nmch_d[l_ac2].nmch001,g_nmch_d[l_ac2].nmchdocno,g_nmch_d[l_ac2].nmchstus
         ,g_nmch_d[l_ac2].nmci103,g_nmch_d[l_ac2].nmci113 #160526-00037#1 add
     FROM nmck_t
    WHERE nmckent = g_enterprise AND nmckdocno = g_nmck_d[g_detail_idx].nmckdocno
      AND nmckcomp = g_nmck_d[g_detail_idx].nmckcomp
   LET l_ac2 = l_ac2 + 1 
   
   LET l_sql = " SELECT nmchdocdt,nmch001,nmchdocno,nmchstus,nmci103,nmci113", #160526-00037#1 add nmci103,nmci113
               "   FROM nmch_t,nmci_t ",
               "  WHERE nmchent = nmcient AND nmchdocno = nmcidocno AND nmchcomp = nmcicomp",
               "    AND nmchent = ",g_enterprise," AND nmci003 = '",g_nmck_d[g_detail_idx].nmckdocno,"' ",
               "    AND nmchcomp = '",g_nmck_d[g_detail_idx].nmckcomp,"'",
               "  ORDER BY nmchdocdt,nmch001 "
   PREPARE anmq430_pb2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR anmq430_pb2   
   FOREACH b_fill_curs2 INTO g_nmch_d[l_ac2].nmchdocdt,g_nmch_d[l_ac2].nmch001,
                             g_nmch_d[l_ac2].nmchdocno,g_nmch_d[l_ac2].nmchstus
                            ,g_nmch_d[l_ac2].nmci103,g_nmch_d[l_ac2].nmci113 #160526-00037#1 add
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
   CALL g_nmch_d.deleteElement(g_nmch_d.getLength())
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   LET li_ac = g_nmch_d.getLength()
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="anmq430.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq430_detail_show(ps_page)
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
   #160526-00037#3 add s---
   IF g_prog = 'anmq431' THEN
      CALL cl_set_comp_visible("b_nmck024,b_nmck025,b_nmck002,b_nmck002_desc,b_nmck030,b_nmck031",FALSE)   
      CALL cl_set_comp_att_text("b_nmck103",cl_getmsg("anm-03008",g_dlang))      
   END IF
   #160526-00037#3 add e---
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq430.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION anmq430_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE  l_wc        STRING 
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
      CONSTRUCT g_wc_filter ON nmckdocno,nmck005,nmck004,nmck024,nmck025,nmck002,nmckdocdt,nmck011,nmck012, 
          nmck100,nmck103,nmck101,nmck113,nmck030,nmck031,nmck026,nmckcomp
                          FROM s_detail1[1].b_nmckdocno,s_detail1[1].b_nmck005,s_detail1[1].b_nmck004, 
                              s_detail1[1].b_nmck024,s_detail1[1].b_nmck025,s_detail1[1].b_nmck002,s_detail1[1].b_nmckdocdt, 
                              s_detail1[1].b_nmck011,s_detail1[1].b_nmck012,s_detail1[1].b_nmck100,s_detail1[1].b_nmck103, 
                              s_detail1[1].b_nmck101,s_detail1[1].b_nmck113,s_detail1[1].b_nmck030,s_detail1[1].b_nmck031, 
                              s_detail1[1].b_nmck026,s_detail1[1].b_nmckcomp
 
         BEFORE CONSTRUCT
                     DISPLAY anmq430_filter_parser('nmckdocno') TO s_detail1[1].b_nmckdocno
            DISPLAY anmq430_filter_parser('nmck005') TO s_detail1[1].b_nmck005
            DISPLAY anmq430_filter_parser('nmck004') TO s_detail1[1].b_nmck004
            DISPLAY anmq430_filter_parser('nmck024') TO s_detail1[1].b_nmck024
            DISPLAY anmq430_filter_parser('nmck025') TO s_detail1[1].b_nmck025
            DISPLAY anmq430_filter_parser('nmck002') TO s_detail1[1].b_nmck002
            DISPLAY anmq430_filter_parser('nmckdocdt') TO s_detail1[1].b_nmckdocdt
            DISPLAY anmq430_filter_parser('nmck011') TO s_detail1[1].b_nmck011
            DISPLAY anmq430_filter_parser('nmck012') TO s_detail1[1].b_nmck012
            DISPLAY anmq430_filter_parser('nmck100') TO s_detail1[1].b_nmck100
            DISPLAY anmq430_filter_parser('nmck103') TO s_detail1[1].b_nmck103
            DISPLAY anmq430_filter_parser('nmck101') TO s_detail1[1].b_nmck101
            DISPLAY anmq430_filter_parser('nmck113') TO s_detail1[1].b_nmck113
            DISPLAY anmq430_filter_parser('nmck030') TO s_detail1[1].b_nmck030
            DISPLAY anmq430_filter_parser('nmck031') TO s_detail1[1].b_nmck031
            DISPLAY anmq430_filter_parser('nmck026') TO s_detail1[1].b_nmck026
            DISPLAY anmq430_filter_parser('nmckcomp') TO s_detail1[1].b_nmckcomp
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmckdocno>>----
         #Ctrlp:construct.c.page1.b_nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocno
            #add-point:ON ACTION controlp INFIELD b_nmckdocno name="construct.c.filter.page1.b_nmckdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmckdocno  #顯示到畫面上
            NEXT FIELD b_nmckdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck005>>----
         #Ctrlp:construct.c.page1.b_nmck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck005
            #add-point:ON ACTION controlp INFIELD b_nmck005 name="construct.c.filter.page1.b_nmck005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck005  #顯示到畫面上
            NEXT FIELD b_nmck005                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_nmck005_desc>>----
         #----<<b_nmck004>>----
         #Ctrlp:construct.c.page1.b_nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck004
            #add-point:ON ACTION controlp INFIELD b_nmck004 name="construct.c.filter.page1.b_nmck004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160122-00001#26 - add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  
            #160122-00001#26 -add -end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck004  #顯示到畫面上
            LET g_qryparam.where = " "        #160122-00001#26 - add
            NEXT FIELD b_nmck004                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_nmck004_desc>>----
         #----<<b_nmck024>>----
         #Ctrlp:construct.c.page1.b_nmck024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck024
            #add-point:ON ACTION controlp INFIELD b_nmck024 name="construct.c.filter.page1.b_nmck024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmaf004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck024  #顯示到畫面上
            NEXT FIELD b_nmck024                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck025>>----
         #Ctrlp:construct.c.filter.page1.b_nmck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck025
            #add-point:ON ACTION controlp INFIELD b_nmck025 name="construct.c.filter.page1.b_nmck025"
            
            #END add-point
 
 
         #----<<b_nmck002>>----
         #Ctrlp:construct.c.filter.page1.b_nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck002
            #add-point:ON ACTION controlp INFIELD b_nmck002 name="construct.c.filter.page1.b_nmck002"
            
            #END add-point
 
 
         #----<<b_nmck002_desc>>----
         #----<<b_nmckdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocdt
            #add-point:ON ACTION controlp INFIELD b_nmckdocdt name="construct.c.filter.page1.b_nmckdocdt"
            
            #END add-point
 
 
         #----<<b_nmck011>>----
         #Ctrlp:construct.c.filter.page1.b_nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck011
            #add-point:ON ACTION controlp INFIELD b_nmck011 name="construct.c.filter.page1.b_nmck011"
            
            #END add-point
 
 
         #----<<b_nmck012>>----
         #Ctrlp:construct.c.filter.page1.b_nmck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck012
            #add-point:ON ACTION controlp INFIELD b_nmck012 name="construct.c.filter.page1.b_nmck012"
            
            #END add-point
 
 
         #----<<b_nmck100>>----
         #Ctrlp:construct.c.page1.b_nmck100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck100
            #add-point:ON ACTION controlp INFIELD b_nmck100 name="construct.c.filter.page1.b_nmck100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck100  #顯示到畫面上
            NEXT FIELD b_nmck100                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck103>>----
         #Ctrlp:construct.c.filter.page1.b_nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck103
            #add-point:ON ACTION controlp INFIELD b_nmck103 name="construct.c.filter.page1.b_nmck103"
            
            #END add-point
 
 
         #----<<b_nmck101>>----
         #Ctrlp:construct.c.filter.page1.b_nmck101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck101
            #add-point:ON ACTION controlp INFIELD b_nmck101 name="construct.c.filter.page1.b_nmck101"
            
            #END add-point
 
 
         #----<<b_nmck113>>----
         #Ctrlp:construct.c.filter.page1.b_nmck113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck113
            #add-point:ON ACTION controlp INFIELD b_nmck113 name="construct.c.filter.page1.b_nmck113"
            
            #END add-point
 
 
         #----<<b_nmck030>>----
         #Ctrlp:construct.c.filter.page1.b_nmck030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck030
            #add-point:ON ACTION controlp INFIELD b_nmck030 name="construct.c.filter.page1.b_nmck030"
            
            #END add-point
 
 
         #----<<b_nmck031>>----
         #Ctrlp:construct.c.filter.page1.b_nmck031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck031
            #add-point:ON ACTION controlp INFIELD b_nmck031 name="construct.c.filter.page1.b_nmck031"
            
            #END add-point
 
 
         #----<<b_nmck026>>----
         #Ctrlp:construct.c.filter.page1.b_nmck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck026
            #add-point:ON ACTION controlp INFIELD b_nmck026 name="construct.c.filter.page1.b_nmck026"
            
            #END add-point
 
 
         #----<<b_nmckcomp>>----
         #Ctrlp:construct.c.page1.b_nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckcomp
            #add-point:ON ACTION controlp INFIELD b_nmckcomp name="construct.c.filter.page1.b_nmckcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160816-00012#4 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = l_wc CLIPPED
            #160816-00012#4 Add  ---(E)---
            #CALL q_ooef001()   #161021-00038#1 mark
            CALL q_ooef001_2()  #161021-00038#1 add                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmckcomp  #顯示到畫面上
            NEXT FIELD b_nmckcomp                     #返回原欄位
    


            #END add-point
 
 
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         CALL gfrm_curr.setFieldHidden("formonly.sel",FALSE)
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
 
      CALL anmq430_filter_show('nmckdocno','b_nmckdocno')
   CALL anmq430_filter_show('nmck005','b_nmck005')
   CALL anmq430_filter_show('nmck004','b_nmck004')
   CALL anmq430_filter_show('nmck024','b_nmck024')
   CALL anmq430_filter_show('nmck025','b_nmck025')
   CALL anmq430_filter_show('nmck002','b_nmck002')
   CALL anmq430_filter_show('nmckdocdt','b_nmckdocdt')
   CALL anmq430_filter_show('nmck011','b_nmck011')
   CALL anmq430_filter_show('nmck012','b_nmck012')
   CALL anmq430_filter_show('nmck100','b_nmck100')
   CALL anmq430_filter_show('nmck103','b_nmck103')
   CALL anmq430_filter_show('nmck101','b_nmck101')
   CALL anmq430_filter_show('nmck113','b_nmck113')
   CALL anmq430_filter_show('nmck030','b_nmck030')
   CALL anmq430_filter_show('nmck031','b_nmck031')
   CALL anmq430_filter_show('nmck026','b_nmck026')
   CALL anmq430_filter_show('nmckcomp','b_nmckcomp')
 
 
   CALL anmq430_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq430.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION anmq430_filter_parser(ps_field)
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
 
{<section id="anmq430.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq430_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq430_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="anmq430.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq430_detail_action_trans()
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
 
{<section id="anmq430.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq430_detail_index_setting()
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
            IF g_nmck_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmck_d.getLength() AND g_nmck_d.getLength() > 0
            LET g_detail_idx = g_nmck_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmck_d.getLength() THEN
               LET g_detail_idx = g_nmck_d.getLength()
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
 
{<section id="anmq430.mask_functions" >}
 &include "erp/anm/anmq430_mask.4gl"
 
{</section>}
 
{<section id="anmq430.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 填充第三單身
# Memo...........:
# Usage..........: CALL anmq430_b_fill3(ls_wc)
#                : ls_wc   QBE條件
# Date & Author..: 151021 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq430_b_fill3(ls_wc)
DEFINE ls_wc            STRING
DEFINE l_sql            STRING
   CALL g_nmck2_d.clear()   
  
   LET l_ac3 = 1
   #160526-00037#3 add s---
   IF g_prog = 'anmq431' THEN
      LET l_sql = "SELECT nmck100,SUM(nmck103),SUM(nmck113),COUNT(1) ", #160526-00037#1 add SUM(nmck113)
                  "  FROM nmck_t ", 
                  " WHERE nmckent= ",g_enterprise," AND nmck023 = '20' AND ",ls_wc,
                  "   AND nmcksite = '",g_master.nmcksite,"' AND nmckcomp = '",g_master.nmckcomp,"' ",
                  " AND (nmck004 IN (",g_sql_bank,")",    #160122-00001#26 - add
                        " OR TRIM(nmck004) IS NULL )"  ,  #160122-00001#26 - add
                  " GROUP BY nmck100 "
   ELSE    
   #160526-00037#3 add e---   
      LET l_sql = "SELECT nmck100,SUM(nmck103),SUM(nmck113),COUNT(1) ", #160526-00037#1 add SUM(nmck113)
                  "  FROM nmck_t ", 
                  " WHERE nmckent= ",g_enterprise," AND nmck023 = '30' AND ",ls_wc,
                  "   AND nmcksite = '",g_master.nmcksite,"' AND nmckcomp = '",g_master.nmckcomp,"' ",
                  " AND (nmck004 IN (",g_sql_bank,")",    #160122-00001#26 - add
                        " OR TRIM(nmck004) IS NULL )"  ,  #160122-00001#26 - add
                  " GROUP BY nmck100 "   
   END IF #160526-00037#3 add                 
   
   PREPARE anmq430_pb3 FROM l_sql
   DECLARE b_fill_curs3 CURSOR FOR anmq430_pb3
   FOREACH b_fill_curs3 INTO g_nmck2_d[l_ac3].nmck100,g_nmck2_d[l_ac3].l_total,g_nmck2_d[l_ac3].nmck113_s,g_nmck2_d[l_ac3].l_numdocno #160526-00037#1 add nmck113 
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
   
   LET l_ac3 = l_ac3 - 1
END FUNCTION
################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: 
#
# Date & Author..: 15/10/21 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq430_x01_tmp()
DROP TABLE anmq430_x01_tmp;
CREATE TEMP TABLE anmq430_x01_tmp(
   seq           INTEGER,
   nmckdocno     VARCHAR(20),     #160526-00037#1 add
   nmck005       VARCHAR(10),       #160526-00037#1 add
   nmck005_desc  VARCHAR(500),        #160526-00037#1 add
#160526-00037#1--mark--str--
#   nmck005      LIKE type_t.chr500,  
#   nmck025      LIKE nmck_t.nmck025,
#   nmck002      LIKE nmck_t.nmck002,
#   nmck002_desc LIKE type_t.chr500,  
#160526-00037#1--mark--end
   nmck004       VARCHAR(10), 
   nmck004_desc  VARCHAR(500), 
   #160526-00037#1--add--str--
   nmck024       VARCHAR(10), 
   nmck025       VARCHAR(20), 
   nmck002       VARCHAR(10), 
   nmck002_desc  VARCHAR(500), 
   nmckdocdt     DATE, 
   nmck011       DATE,
   #160526-00037#1--add--end
   nmck012     DATE,        #161125-00036#3 add
   nmck100       VARCHAR(10), 
   nmck103       DECIMAL(20,6), 
   nmck101       DECIMAL(20,10),      #160526-00037#1 add
   nmck113       DECIMAL(20,6),      #160526-00037#1 add
   nmck030       VARCHAR(500),
   nmck031       DECIMAL(10,6), 
#   nmck113      LIKE nmck_t.nmck113,#160526-00037#1 mark
#   nmchdocdt    LIKE nmch_t.nmchdocdt,#160526-00037#1 mark
#   nmch001_desc LIKE type_t.chr500  #160526-00037#1 mark
   nmck026_desc   VARCHAR(500),      #160526-00037#1 add
   nmckcomp       VARCHAR(10),      #160526-00037#1 add
   l_keys         VARCHAR(1000)     #160526-00037#1 add
   )
END FUNCTION
################################################################################
# Descriptions...: ins TEMP TABLE
# Memo...........: 
#
# Date & Author..: 15/10/21 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq430_ins_tmp()
DEFINE l_nmck030_desc  LIKE type_t.chr500    #取得SCC的說明文字
DEFINE l_nmch001_desc  LIKE type_t.chr500
DEFINE l_sum_nmck103   LIKE type_t.num20_6
DEFINE l_sum_nmck113   LIKE type_t.num20_6
DEFINE l_i             LIKE type_t.num10
DEFINE l_j             LIKE type_t.num10
DEFINE l_n             LIKE type_t.num10   
DEFINE l_x01_tmp   RECORD
   seq             LIKE type_t.num10,
   nmck005         LIKE type_t.chr500, 
   nmck025         LIKE nmck_t.nmck025, 
   nmck002         LIKE nmck_t.nmck002, 
   nmck002_desc    LIKE type_t.chr500, 
   nmck004         LIKE nmck_t.nmck004, 
   nmck004_desc    LIKE type_t.chr500, 
   nmck100         LIKE nmck_t.nmck100, 
   nmck103         LIKE nmck_t.nmck103, 
   nmck030         LIKE type_t.chr500, 
   nmck031         LIKE nmck_t.nmck031, 
   nmck113         LIKE nmck_t.nmck113,
   nmchdocdt       LIKE nmch_t.nmchdocdt,
   nmch001_desc    LIKE type_t.chr500 
                   END RECORD
#160526-00037#1--add--str--
DEFINE l_nmck026_desc LIKE type_t.chr500
DEFINE l_keys         LIKE type_t.chr1000
#160526-00037#1--add--end

   DELETE FROM anmq430_x01_tmp
   #160526-00037#1--add--str--
   #XG報表採用明細+子報表模式
   LET l_n = g_nmck_d.getLength()
   
   FOR l_i = 1 TO l_n
      #利率方式
      CALL s_desc_gzcbl004_desc('8715',g_nmck_d[l_i].nmck030)  RETURNING l_nmck030_desc
      IF NOT cl_null(l_nmck030_desc) THEN
         LET l_nmck030_desc = g_nmck_d[l_i].nmck030,":",l_nmck030_desc
      ELSE
         LET l_nmck030_desc = g_nmck_d[l_i].nmck030
      END IF
      #票况
      CALL s_desc_gzcbl004_desc('8711',g_nmck_d[l_i].nmck026)  RETURNING l_nmck026_desc
      IF NOT cl_null(l_nmck026_desc) THEN
         LET l_nmck026_desc = g_nmck_d[l_i].nmck026,":",l_nmck026_desc
      ELSE
         LET l_nmck026_desc = g_nmck_d[l_i].nmck026
      END IF
      #與子報表關聯主鍵組合
      LET l_keys=g_nmck_d[l_i].nmckdocno||'-'||g_nmck_d[l_i].nmckcomp
      INSERT INTO anmq430_x01_tmp (seq,nmckdocno,nmck005,nmck005_desc,nmck004,
                                   nmck004_desc,nmck024,nmck025,nmck002,
                                   nmck002_desc,nmckdocdt,nmck011,nmck100,
                                   nmck103,nmck101,nmck113,nmck030,
                                   nmck012,    #161125-00036#3
                                   nmck031,nmck026_desc,nmckcomp,l_keys)
      VALUES(l_i,g_nmck_d[l_i].nmckdocno,g_nmck_d[l_i].nmck005,g_nmck_d[l_i].nmck005_desc,g_nmck_d[l_i].nmck004,
             g_nmck_d[l_i].l_nmck004_desc,g_nmck_d[l_i].nmck024,g_nmck_d[l_i].nmck025,g_nmck_d[l_i].nmck002,
             g_nmck_d[l_i].nmck002_desc,g_nmck_d[l_i].nmckdocdt,g_nmck_d[l_i].nmck011,g_nmck_d[l_i].nmck100,
             g_nmck_d[l_i].nmck103,g_nmck_d[l_i].nmck101,g_nmck_d[l_i].nmck113,l_nmck030_desc,
             g_nmck_d[l_i].nmck012,    #161125-00036#3
             g_nmck_d[l_i].nmck031,l_nmck026_desc,g_nmck_d[l_i].nmckcomp,l_keys)
   END FOR
   #160526-00037#1--add--end

#160526-00037#1--mark--str--
#   LET l_n = 0
#   LET l_sum_nmck103 = 0
#   LET l_sum_nmck113 = 0
#   FOR l_i = 1 TO g_nmck_d.getLength()
#      LET g_detail_idx = l_i
#      CALL anmq430_b_fill2()
#      IF l_i > 1 THEN
#         IF g_nmck_d[l_i].nmck100 <> g_nmck_d[l_i - 1].nmck100 THEN
#            LET l_n = l_n + 1
#            INITIALIZE l_x01_tmp.* TO NULL
#            LET l_x01_tmp.seq          = l_n
#            LET l_x01_tmp.nmck005      = ''
#            LET l_x01_tmp.nmck025      = ''
#            LET l_x01_tmp.nmck002      = ''
#            LET l_x01_tmp.nmck002_desc = ''
#            LET l_x01_tmp.nmck004      = ''
#            LET l_x01_tmp.nmck004_desc = ''
#            LET l_x01_tmp.nmck100      = g_nmck_d[l_i - 1 ].nmck100,cl_getmsg("aap-00287",g_lang)
#            LET l_x01_tmp.nmck103      = l_sum_nmck103
#            LET l_x01_tmp.nmck030      = ''
#            LET l_x01_tmp.nmck031      = l_sum_nmck113
#            LET l_x01_tmp.nmck113      = ''
#            LET l_x01_tmp.nmchdocdt    = '' 
#            LET l_x01_tmp.nmch001_desc = ''
#            INSERT INTO anmq430_x01_tmp VALUES(l_x01_tmp.*)
#            LET l_sum_nmck103 = 0
#            LET l_sum_nmck113 = 0
#         END IF
#      END IF
#      FOR l_j = 1 TO g_nmch_d.getLength()
#         LET l_n = l_n + 1
#         LET l_nmck030_desc  = '' 
#         LET l_nmch001_desc  = ''   
#         CALL s_desc_gzcbl004_desc('8715',g_nmck_d[l_i].nmck030)  RETURNING l_nmck030_desc
#         CALL s_desc_gzcbl004_desc('8714',g_nmch_d[l_j].nmch001)  RETURNING l_nmch001_desc
#         INITIALIZE l_x01_tmp.* TO NULL
#         IF l_j = 1 THEN
#            LET l_x01_tmp.seq          = l_n
##            LET l_x01_tmp.nmck005      = g_nmck_d[l_i].l_nmck005_desc #160526-00037#1 mark
#            LET l_x01_tmp.nmck005      = g_nmck_d[l_i].nmck005_desc #160526-00037#1 add
#            LET l_x01_tmp.nmck025      = g_nmck_d[l_i].nmck025
#            LET l_x01_tmp.nmck002      = g_nmck_d[l_i].nmck002
#            LET l_x01_tmp.nmck002_desc = g_nmck_d[l_i].nmck002_desc
#            LET l_x01_tmp.nmck004      = g_nmck_d[l_i].nmck004 
#            LET l_x01_tmp.nmck004_desc = g_nmck_d[l_i].l_nmck004_desc
#            LET l_x01_tmp.nmck100      = g_nmck_d[l_i].nmck100
#            LET l_x01_tmp.nmck103      = g_nmck_d[l_i].nmck103 
#            LET l_x01_tmp.nmck030      = g_nmck_d[l_i].nmck030,":",l_nmck030_desc 
#            LET l_x01_tmp.nmck031      = g_nmck_d[l_i].nmck031 / 100 
#            LET l_x01_tmp.nmck113      = g_nmck_d[l_i].nmck113
#            LET l_x01_tmp.nmchdocdt    = g_nmch_d[l_j].nmchdocdt
#            LET l_x01_tmp.nmch001_desc = g_nmch_d[l_j].nmch001,":",l_nmch001_desc
#            LET l_sum_nmck103 = l_sum_nmck103 + g_nmck_d[l_i].nmck103
#            LET l_sum_nmck113 = l_sum_nmck113 + g_nmck_d[l_i].nmck113
#         ELSE
#            LET l_x01_tmp.seq          = l_n
#            LET l_x01_tmp.nmck005      = ''
#            LET l_x01_tmp.nmck025      = ''
#            LET l_x01_tmp.nmck002      = ''
#            LET l_x01_tmp.nmck002_desc = ''
#            LET l_x01_tmp.nmck004      = ''
#            LET l_x01_tmp.nmck004_desc = ''
#            LET l_x01_tmp.nmck100      = ''
#            LET l_x01_tmp.nmck103      = ''
#            LET l_x01_tmp.nmck030      = '' 
#            LET l_x01_tmp.nmck031      = '' 
#            LET l_x01_tmp.nmck113      = ''
#            LET l_x01_tmp.nmchdocdt    = g_nmch_d[l_j].nmchdocdt
#            LET l_x01_tmp.nmch001_desc = g_nmch_d[l_j].nmch001,":",l_nmch001_desc
#         END IF
#         INSERT INTO anmq430_x01_tmp VALUES(l_x01_tmp.*)
#      END FOR
#      IF l_i = g_nmck_d.getLength() THEN
#         LET l_n = l_n + 1
#         INITIALIZE l_x01_tmp.* TO NULL
#         LET l_x01_tmp.seq          = l_n
#            LET l_x01_tmp.nmck005      = ''
#            LET l_x01_tmp.nmck025      = ''
#            LET l_x01_tmp.nmck002      = ''
#            LET l_x01_tmp.nmck002_desc = ''
#            LET l_x01_tmp.nmck004      = ''
#            LET l_x01_tmp.nmck004_desc = ''
#            LET l_x01_tmp.nmck100      = g_nmck_d[l_i].nmck100,cl_getmsg("aap-00287",g_lang)
#            LET l_x01_tmp.nmck103      = l_sum_nmck103
#            LET l_x01_tmp.nmck030      = ''
#            LET l_x01_tmp.nmck031      = l_sum_nmck113
#            LET l_x01_tmp.nmck113      = ''
#            LET l_x01_tmp.nmchdocdt    = '' 
#            LET l_x01_tmp.nmch001_desc = ''
#         INSERT INTO anmq430_x01_tmp VALUES(l_x01_tmp.*)
#      END IF   
#   END FOR
#160526-00037#1--mark--end    
END FUNCTION
################################################################################
# Descriptions...: 資金中心檢查
# Memo...........:
# Usage..........: CALL anmq430_nmcksite_chk(p_nmcksite)
# Date & Author..: 2015/10/29 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq430_nmcksite_chk(p_nmcksite)
   DEFINE l_ooef206  LIKE ooef_t.ooef206
   DEFINE l_ooefstus LIKE ooef_t.ooefstus
   DEFINE p_nmcksite LIKE nmck_t.nmcksite

   LET g_errno = ''
   SELECT ooef206,ooefstus INTO l_ooef206,l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_nmcksite  
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aoo-00094'
      WHEN l_ooefstus = 'N'    LET g_errno = 'sub-01302' #aoo-00095  #160318-00005#27  By 07900 --mod
      WHEN l_ooef206 <> 'Y'    LET g_errno = 'anm-00272'
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL anmq430_qbe_clear()
# Date & Author..: 2015/10/29 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq430_qbe_clear()
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_wc       STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5  #160816-00012#4 Add
   
  CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_nmck_d.clear()
   CALL g_nmch_d.clear()
   CALL g_nmck2_d.clear()
   
   
   CALL s_fin_account_center_sons_query('6',g_site,g_today,'')
   CALL s_fin_account_center_comp_str()  RETURNING g_nmckcomp_str
   CALL s_fin_get_wc_str(g_nmckcomp_str) RETURNING g_nmckcomp_str
   CALL s_fin_account_center_with_ld_chk(g_site,'',g_user,'6','N','',g_today) RETURNING g_sub_success,g_errno
   IF g_sub_success THEN
      CALL anmq430_nmcksite_chk(g_site)
      IF NOT cl_null(g_errno) THEN
         # g_site <> 資金中心,則空白
         LET g_master.nmcksite = ''
         LET g_master.nmckcomp = ''
      ELSE
         LET g_master.nmcksite = g_site
         CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master.nmckcomp,g_glaald 
         #160816-00012#4 Add  ---(S)---
         #检查用户是否有资金中心对应法人的权限
         CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
         LET l_count = 0
         LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                     "   AND ooef001 = '",g_master.nmckcomp,"'",
                     "   AND ooef003 = 'Y'",
                     "   AND ",l_wc CLIPPED
         PREPARE anmp410_count_prep FROM l_sql
         EXECUTE anmp410_count_prep INTO l_count
         IF cl_null(l_count) THEN LET l_count = 0 END IF
         IF l_count = 0 THEN
            LET g_master.nmckcomp = ''           
            DISPLAY BY NAME g_master.nmckcomp
         END IF
         #160816-00012#4 Add  ---(E)---         
      END IF
   ELSE
      LET g_master.nmcksite = ''
      LET g_master.nmckcomp = ''
   END IF
   
   LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
   LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
   DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,g_master.nmckcomp_desc
END FUNCTION

 
{</section>}
 
