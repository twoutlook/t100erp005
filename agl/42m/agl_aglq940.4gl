#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq940.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-05-24 14:41:26), PR版次:0001(2016-05-31 18:06:07)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000023
#+ Filename...: aglq940
#+ Description: 合併現金流量表直接法內部交易查詢作業
#+ Creator....: 03538(2016-05-24 14:41:26)
#+ Modifier...: 03538 -SD/PR- 03538
 
{</section>}
 
{<section id="aglq940.global" >}
#應用 q04 樣板自動產生(Version:32)
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
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       glefld LIKE glef_t.glefld
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       glef006 LIKE glef_t.glef006, 
   glef006_desc LIKE type_t.chr500, 
   glef011 LIKE glef_t.glef011, 
   glef014 LIKE glef_t.glef014, 
   glef017 LIKE glef_t.glef017
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       glef002 LIKE glef_t.glef002, 
   glef002_2_desc LIKE type_t.chr500, 
   glef003 LIKE glef_t.glef003, 
   glef008 LIKE glef_t.glef008, 
   glef006 LIKE glef_t.glef006, 
   glef006_2_desc LIKE type_t.chr500, 
   glef011 LIKE glef_t.glef011, 
   glef014 LIKE glef_t.glef014, 
   glef017 LIKE glef_t.glef017
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_qmaster           RECORD
                           glefld       LIKE glef_t.glefld,
                           glefld_desc  LIKE type_t.chr80,
                           glef001      LIKE glef_t.glef001,
                           glef001_desc LIKE type_t.chr80,
                           glef004      LIKE glef_t.glef004,
                           glef005      LIKE glef_t.glef005,
                           glef002      LIKE glef_t.glef002,
                           glef002_desc LIKE type_t.chr80,
                           l_glef003    LIKE glef_t.glef003,
                           glef008      LIKE glef_t.glef008,
                           glef008_desc LIKE type_t.chr80
                           END RECORD
DEFINE g_glaa003           LIKE glaa_t.glaa003     #會計週期參照表
DEFINE g_glaa135           LIKE glaa_t.glaa135     #現流表間接法群組參照表號
DEFINE g_glaa004           LIKE glaa_t.glaa004     #會計科目參照表號           
DEFINE g_glaa005           LIKE glaa_t.glaa005     #現金流量表參照表  
DEFINE g_glaa015           LIKE glaa_t.glaa015
DEFINE g_glaa019           LIKE glaa_t.glaa019
DEFINE g_sql_pre           STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
 
 
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
 
{<section id="aglq940.main" >}
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
   CALL cl_ap_init("agl","")
 
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
   DECLARE aglq940_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq940_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq940_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq940 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq940_init()   
 
      #進入選單 Menu (="N")
      CALL aglq940_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq940
      
   END IF 
   
   CLOSE aglq940_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq940.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq940_init()
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
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
 
   CALL aglq940_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq940.default_search" >}
PRIVATE FUNCTION aglq940_default_search()
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
 
{<section id="aglq940.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq940_ui_dialog() 
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
   DEFINE l_pdate_s   LIKE glav_t.glav004   
   DEFINE l_pdate_e   LIKE glav_t.glav004   
   DEFINE l_flag      LIKE type_t.chr1
   DEFINE l_errno     LIKE type_t.chr100
   DEFINE l_glav002   LIKE glav_t.glav002  
   DEFINE l_glav005   LIKE glav_t.glav005  
   DEFINE l_sdate_s   LIKE glav_t.glav004
   DEFINE l_sdate_e   LIKE glav_t.glav004
   DEFINE l_glav006   LIKE glav_t.glav006
   DEFINE l_glav007   LIKE glav_t.glav007
   DEFINE l_wdate_s   LIKE glav_t.glav004
   DEFINE l_wdate_e   LIKE glav_t.glav004 
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
      CALL aglq940_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
 
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
 
         CALL aglq940_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_qmaster.glefld,g_qmaster.glef001,g_qmaster.glef004,g_qmaster.glef005,g_qmaster.glef002,
                       g_qmaster.glef008
                       
            ON ACTION controlp INFIELD glefld
               
               #合併帳套
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_qmaster.glefld             #給予default值
               LET g_qryparam.arg1 = g_user                          #人員權限         
               LET g_qryparam.arg2 = g_dept                          #部門權限 
               LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",              
                                      "             WHERE gldbstus = 'Y' ",                                    
                                      "               AND gldbent = '",g_enterprise,"') "  
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_qmaster.glefld = g_qryparam.return1              
               CALL s_desc_get_ld_desc(g_qmaster.glefld) RETURNING g_qmaster.glefld_desc            
               DISPLAY BY NAME g_qmaster.glefld,g_qmaster.glefld_desc      
               NEXT FIELD glefld                                     #返回原欄位   
               
            ON ACTION controlp INFIELD glef001
   
               #上層公司
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_qmaster.glef001      #給予default值
               LET g_qryparam.where = " gldc009 = 'Y' AND gldbstus = 'Y' ",
                                      " AND gldcld = '",g_qmaster.glefld,"' "  
               CALL q_gldc001()                                #呼叫開窗
               LET g_qmaster.glef001 = g_qryparam.return1              
               CALL s_desc_glda001_desc(g_qmaster.glef001) RETURNING g_qmaster.glef001_desc
               DISPLAY BY NAME g_qmaster.glef001,g_qmaster.glef001_desc
               NEXT FIELD glef001                              #返回原欄位

            ON ACTION controlp INFIELD glef002
   
               #個體公司
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_qmaster.glef002
               CALL q_gldc002_1()
               LET g_qmaster.glef002 = g_qryparam.return1
               LET g_qmaster.glef002_desc =  s_desc_glda001_desc(g_qmaster.glef002)
               DISPLAY BY NAME g_qmaster.glef002,g_qmaster.glef002_desc
               NEXT FIELD glef002
               
            ON ACTION controlp INFIELD glef008
   
               #關係人
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_qmaster.glef008
               CALL q_glda004()
               LET g_qmaster.glef008 = g_qryparam.return1
               CALL s_desc_get_trading_partner_abbr_desc(g_qmaster.glef008) RETURNING g_qmaster.glef008_desc
               DISPLAY BY NAME g_qmaster.glef008,g_qmaster.glef008_desc
               NEXT FIELD glef008               

            AFTER FIELD glefld
               
               #合併帳套
               LET g_qmaster.glefld_desc = ' '
               DISPLAY BY NAME g_qmaster.glefld_desc
               IF NOT cl_null(g_qmaster.glefld) THEN
                  CALL s_merge_ld_with_comp_chk(g_qmaster.glefld,g_qmaster.glef001,g_user,1)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_qmaster.glefld = ''
                     LET g_qmaster.glefld_desc = ''
                     DISPLAY BY NAME g_qmaster.glefld,g_qmaster.glefld_desc    
                     NEXT FIELD CURRENT
                  END IF             
               END IF
               CALL s_desc_get_ld_desc(g_qmaster.glefld) RETURNING g_qmaster.glefld_desc
               DISPLAY BY NAME g_qmaster.glefld,g_qmaster.glefld_desc   
               
               #帳套相關資訊取得
               SELECT glaa003,glaa135,glaa004,glaa005,glaa015,glaa019
                 INTO g_glaa003,g_glaa135,g_glaa004,g_glaa005,g_glaa015,g_glaa019 
                FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_qmaster.glefld
                
               CALL aglq940_set_ld()                
               
               #依年度+期別取得會計週期起迄日
               CALL s_get_accdate(g_glaa003,g_today,'','')
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
                         
               LET g_qmaster.glef004 = l_glav002   #會計年度
               LET g_qmaster.glef005 = l_glav006   #會計期別
               DISPLAY BY NAME g_qmaster.glef004,g_qmaster.glef005

            AFTER FIELD glef001
               
               #上層公司
               LET g_qmaster.glef001_desc = ' '
               DISPLAY BY NAME g_qmaster.glef001_desc
               IF NOT cl_null(g_qmaster.glef001) THEN
                  CALL s_merge_ld_with_comp_chk(g_qmaster.glefld,g_qmaster.glef001,g_user,1)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_qmaster.glef001 = ''
                     LET g_qmaster.glef001_desc = ''
                     DISPLAY BY NAME g_qmaster.glef001,g_qmaster.glef001_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_qmaster.glef001_desc = s_desc_glda001_desc(g_qmaster.glef001)
               DISPLAY BY NAME g_qmaster.glef001,g_qmaster.glef001_desc
               
            AFTER FIELD glef002
   
               #個體公司
               LET g_qmaster.glef002_desc = ' '
               LET g_qmaster.l_glef003 = ''
               DISPLAY BY NAME g_qmaster.glef002_desc,g_qmaster.l_glef003
               IF NOT cl_null(g_qmaster.glef002) THEN
                  CALL s_merge_glda001_chk(g_qmaster.glef002)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_qmaster.glef002 = ''
                     LET g_qmaster.glef002_desc =  ''
                     DISPLAY BY NAME g_qmaster.glef002,g_qmaster.glef002_desc
                     NEXT FIELD CURRENT
                  END IF   
               END IF
               LET g_qmaster.glef002_desc =  s_desc_glda001_desc(g_qmaster.glef002)
               LET g_qmaster.l_glef003 = s_merge_get_gl_ld(g_qmaster.glefld,g_qmaster.glef002)
               DISPLAY BY NAME g_qmaster.glef002,g_qmaster.glef002_desc,g_qmaster.l_glef003 

            AFTER FIELD glef008
   
               #關係人
               LET g_qmaster.glef008_desc = ' '
               DISPLAY BY NAME g_qmaster.glef008_desc
               IF NOT cl_null(g_qmaster.glef008) THEN
                  CALL aglq940_glef008_chk(g_qmaster.glef008)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_qmaster.glef008 = ''
                     LET g_qmaster.glef008_desc =  ''
                     DISPLAY BY NAME g_qmaster.glef008,g_qmaster.glef008_desc
                     NEXT FIELD CURRENT
                  END IF   
               END IF
               LET g_qmaster.glef008_desc =  s_desc_get_trading_partner_abbr_desc(g_qmaster.glef008)
               DISPLAY BY NAME g_qmaster.glef008,g_qmaster.glef008_desc  

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq940_detail_action_trans()
               LET g_master_idx = l_ac
               CALL aglq940_b_fill2()
 
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
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL aglq940_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL aglq940_qbe_clear()
            #end add-point
            NEXT FIELD glefld
 
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
            IF cl_null(g_qmaster.glefld) OR cl_null(g_qmaster.glef001) OR cl_null(g_qmaster.glef004) OR 
               cl_null(g_qmaster.glef005)OR cl_null(g_qmaster.glef002) OR cl_null(g_qmaster.glef008) THEN 
               CONTINUE DIALOG
            END IF
            #end add-point
 
            CALL aglq940_cs()
 
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
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq940_fetch('F')
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
            CALL aglq940_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq940_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq940_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq940_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq940_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq940_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL aglq940_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL aglq940_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL aglq940_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL aglq940_b_fill()
 
         
         
         
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
            CALL aglq940_qbe_clear()
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point 
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq940.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION aglq940_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE aglq940_pre FROM g_sql
   DECLARE aglq940_curs SCROLL CURSOR WITH HOLD FOR aglq940_pre
   OPEN aglq940_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_sql_pre = "SELECT glef006,(SELECT nmail004 FROM nmail_t WHERE nmailent = glefent AND nmail001='",g_glaa005,"' AND nmail002=glef006 AND nmail003 ='",g_dlang,"'), ",
                   "       SUM(glef011),SUM(glef014),SUM(glef017) ",
                   "  FROM glef_t ",
                   " WHERE glefent = '",g_enterprise,"'",
                   "   AND glefld = '",g_qmaster.glefld,"'",
                   "   AND glef001 = '",g_qmaster.glef001,"'",
                   "   AND glef004 = '",g_qmaster.glef004,"'",
                   "   AND glef005 = '",g_qmaster.glef005,"'",
                   "   AND glef002 = '",g_qmaster.glef002,"'",
                   "   AND glef008 = '",g_qmaster.glef008,"'",
                   " GROUP BY glef006,glefent ",
                   " ORDER BY glef006 "
   LET g_cnt_sql = "SELECT COUNT(1) FROM (",g_sql_pre,")"
   #end add-point
   PREPARE aglq940_precount FROM g_cnt_sql
   EXECUTE aglq940_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL aglq940_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aglq940.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION aglq940_fetch(p_flag)
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
   
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_glefld
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
 
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
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL aglq940_show()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq940.show" >}
PRIVATE FUNCTION aglq940_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_glefld
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL aglq940_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq940.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq940_b_fill()
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
   LET g_sql = g_sql_pre
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq940_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq940_pb
 
 
   FOREACH b_fill_curs INTO g_detail[l_ac].glef006,g_detail[l_ac].glef006_desc,g_detail[l_ac].glef011,g_detail[l_ac].glef014,g_detail[l_ac].glef017
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
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
   CALL aglq940_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq940_detail_action_trans()
 
   CALL aglq940_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq940.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq940_b_fill2()
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
   LET g_sql = "SELECT glef002,(SELECT gldal003 FROM gldal_t WHERE gldalent = glefent AND gldal001 = glef002 AND gldal002 = '",g_dlang,"'),",
               "       glef003,glef008,glef006,(SELECT nmail004 FROM nmail_t WHERE nmailent = glefent AND nmail001='",g_glaa005,"' AND nmail002=glef006 AND nmail003 ='",g_dlang,"'), ",
               "       SUM(glef011),SUM(glef014),SUM(glef017) ",
               "  FROM glef_t ",
               " WHERE glefent = '",g_enterprise,"'",
               "   AND glefld = '",g_qmaster.glefld,"'",
               "   AND glef001 = '",g_qmaster.glef001,"'",
               "   AND glef004 = '",g_qmaster.glef004,"'",
               "   AND glef005 = '",g_qmaster.glef005,"'",
               "   AND glef002 = '",g_qmaster.glef002,"'",
               "   AND glef008 = '",g_qmaster.glef008,"'",
               " GROUP BY glef006,glefent,glef002,glef003,glef008 ",
               " ORDER BY glef006 "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq940_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aglq940_pb2        
   
   FOREACH b_fill_curs2 INTO g_detail2[li_ac].glef002,g_detail2[li_ac].glef002_2_desc,g_detail2[li_ac].glef003,
                             g_detail2[li_ac].glef008,g_detail2[li_ac].glef006,g_detail2[li_ac].glef006_2_desc,
                             g_detail2[li_ac].glef011,g_detail2[li_ac].glef014,g_detail2[li_ac].glef017
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET li_ac = li_ac + 1
 
   END FOREACH         
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq940.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq940_detail_show(ps_page)
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
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq940.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION aglq940_maintain_prog()
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
 
{<section id="aglq940.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq940_detail_action_trans()
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
 
{<section id="aglq940.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq940_detail_index_setting()
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
 
{<section id="aglq940.mask_functions" >}
 &include "erp/agl/aglq940_mask.4gl"
 
{</section>}
 
{<section id="aglq940.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aglq940_qbe_clear()
# Date & Author..: 160524 By 03538
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq940_qbe_clear()
DEFINE l_glaacomp  LIKE glaa_t.glaacomp   #法人
DEFINE l_glaald    LIKE glaa_t.glaald     #帳套
DEFINE l_pdate_s   LIKE glav_t.glav004   
DEFINE l_pdate_e   LIKE glav_t.glav004   
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_errno     LIKE type_t.chr100
DEFINE l_glav002   LIKE glav_t.glav002  
DEFINE l_glav005   LIKE glav_t.glav005  
DEFINE l_sdate_s   LIKE glav_t.glav004
DEFINE l_sdate_e   LIKE glav_t.glav004
DEFINE l_glav006   LIKE glav_t.glav006
DEFINE l_glav007   LIKE glav_t.glav007
DEFINE l_wdate_s   LIKE glav_t.glav004
DEFINE l_wdate_e   LIKE glav_t.glav004 

   CLEAR FORM
   INITIALIZE g_qmaster.* TO NULL
   CALL g_detail.clear()
   CALL g_detail2.clear()
   
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
   LET g_glaa015 = 'Y'
   LET g_glaa019 = 'Y'
   CALL aglq940_set_ld()
   SELECT glaa003,glaa135,glaa004 INTO g_glaa003,g_glaa135,g_glaa004
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_glaald
   
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
             
   LET g_qmaster.glef004 = l_glav002   #會計年度
   LET g_qmaster.glef005 = l_glav006   #會計期別
   DISPLAY BY NAME g_qmaster.glef004,g_qmaster.glef005
END FUNCTION

################################################################################
# Descriptions...: 檢查關係人是否存在agli500
# Memo...........:
# Usage..........: CALL aglq940_glef008_chk(p_glda004)
#                  RETURNING g_sub_success
# Input parameter: p_glda004      關係人
# Return code....: r_success,r_errno
# Date & Author..: 160524 By 03538
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq940_glef008_chk(p_glda004)
DEFINE p_glda004  LIKE glda_t.glda004
DEFINE r_success  LIKE type_t.num5
DEFINE r_errno    LIKE gzze_t.gzze001
DEFINE l_cnt      LIKE type_t.num5

   LET r_success = TRUE
   LET r_errno = ''
   
   LET l_cnt = 0
   SELECT COUNT(glda004) INTO l_cnt
     FROM glda_t
    WHERE gldaent = g_enterprise
      AND glda004 = p_glda004
      AND gldastus = 'Y'
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      LET r_errno = 'agl-00311'
      LET r_success = FALSE
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 根據帳套初始化
# Memo...........:
# Usage..........: CALL aglq940_set_ld()
# Date & Author..: 2016/05/31 By 03538
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq940_set_ld()
IF g_glaa015 = 'Y' THEN
   CALL cl_set_comp_visible("b_glef014,glef014_2", TRUE)
ELSE
   CALL cl_set_comp_visible("b_glef014,glef014_2", FALSE)
END IF
IF g_glaa019 = 'Y' THEN
   CALL cl_set_comp_visible("b_glef017,glef017_2", TRUE)
ELSE
   CALL cl_set_comp_visible("b_glef017,glef017_2", FALSE)
END IF
END FUNCTION

 
{</section>}
 