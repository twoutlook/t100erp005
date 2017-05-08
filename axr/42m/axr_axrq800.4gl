#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq800.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-06-12 09:58:13), PR版次:0003(2016-10-27 16:10:17)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: axrq800
#+ Description: 場租應收明細查詢
#+ Creator....: 05948(2016-06-12 09:58:13)
#+ Modifier...: 05948 -SD/PR- 08729
 
{</section>}
 
{<section id="axrq800.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160811-00009#2   2016/08/17  By 01531    账务中心/法人/账套权限控管
 #161021-00050#6  2016/10/26  By 08729    處理組織開窗
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
PRIVATE TYPE type_g_stjf_d RECORD
       
       num LIKE type_t.chr500, 
   stjesite LIKE stje_t.stjesite, 
   ooefl003 LIKE ooefl_t.ooefl003, 
   stje001 LIKE stje_t.stje001, 
   stjf004 LIKE stjf_t.stjf004, 
   stael003 LIKE stael_t.stael003, 
   stje020 LIKE stje_t.stje020, 
   stje019 LIKE stje_t.stje019, 
   stje008 LIKE stje_t.stje008, 
   stje025 LIKE stje_t.stje025, 
   stje011 LIKE stje_t.stje011, 
   stje012 LIKE stje_t.stje012, 
   l_chr20 LIKE type_t.chr20, 
   l_num20_6 LIKE type_t.num20_6, 
   l_chr200 LIKE type_t.chr200
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_xrca_m   RECORD
        xrcasite        LIKE xrca_t.xrcasite,
        xrcasite_desc   LIKE ooefl_t.ooefl003,
        xrcald          LIKE xrca_t.xrcald,
        xrcald_desc     LIKE glaal_t.glaal002
                     END RECORD
DEFINE g_master      type_g_xrca_m
#end add-point
 
#模組變數(Module Variables)
DEFINE g_stjf_d            DYNAMIC ARRAY OF type_g_stjf_d
DEFINE g_stjf_d_t          type_g_stjf_d
 
 
 
 
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
 
{<section id="axrq800.main" >}
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
   CALL cl_ap_init("axr","")
 
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
   DECLARE axrq800_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq800_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq800_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq800 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq800_init()   
 
      #進入選單 Menu (="N")
      CALL axrq800_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq800
      
   END IF 
   
   CLOSE axrq800_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq800.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrq800_init()
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
 
   CALL axrq800_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrq800.default_search" >}
PRIVATE FUNCTION axrq800_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stjfseq = '", g_argv[01], "' AND "
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
 
{<section id="axrq800.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq800_ui_dialog() 
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
   DEFINE l_success         LIKE type_t.chr1
   define l_xrcacomp        like xrca_t.xrcacomp
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
 
   
   CALL axrq800_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stjf_d.clear()
 
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
 
         CALL axrq800_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         CONSTRUCT BY NAME g_wc ON stjf004
            BEFORE CONSTRUCT
 

         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stjf004
            #add-point:ON ACTION controlp INFIELD stbc008 name="construct.c.stbc008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stjf004  #顯示到畫面上
            NEXT FIELD stjf004                  #返回原欄位
    

         END CONSTRUCT

         INPUT BY NAME g_master.xrcasite,g_master.xrcald
            ATTRIBUTE(WITHOUT DEFAULTS)
                             
            AFTER FIELD xrcasite
               IF NOT cl_null(g_master.xrcasite) THEN
                  #161021-00050#6-add(s)
                  CALL s_fin_account_center_with_ld_chk(g_master.xrcasite,g_master.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_master.xrcasite
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.xrcasite = ''
                        LET g_master.xrcald = ''
                        LET g_master.xrcasite_desc = ''
                        LET g_master.xrcald_desc = ''
                        DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
                        DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
                        NEXT FIELD CURRENT
                     END IF
                  #161021-00050#6-add(e)
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
                  DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
                  DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
                  IF NOT l_success THEN NEXT FIELD CURRENT END IF
                  #CALL s_axrt300_date_chk(g_master.xrcasite,g_master.xrcadocdt) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axr-00299"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_master.xrcasite_desc = ''
               END IF
#               SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
#                WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
#               SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc

            AFTER FIELD xrcald
               IF NOT cl_null(g_master.xrcald) THEN 
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
                  DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
                  DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
#                  IF NOT l_success THEN
#                     SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
#                      WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
#                     SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
#                     NEXT FIELD CURRENT
#                  END IF
               ELSE
                  LET g_master.xrcald_desc = ''
               END IF
#               SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
#               SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
#                WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc            
            
            ON ACTION controlp INFIELD xrcasite
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrcasite             #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#2 

               #給予arg

               #CALL q_ooef001()                                       #呼叫開窗  #161021-00050#6 mark
               CALL q_ooef001_46()                                               #161021-00050#6 add 
               LET g_master.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
               IF NOT cl_null(g_master.xrcasite) THEN
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'site')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
#                  SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
#                   WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               END IF
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc
               NEXT FIELD xrcasite

            ON ACTION controlp INFIELD xrcald
               CALL s_fin_create_account_center_tmp()   
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_master.xrcasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING ls_wc
               #將取回的字串轉換為SQL條件
               CALL axrq800_get_ooef001_wc(ls_wc) RETURNING ls_wc  
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrcald             #給予default值
#160811-00009#2 mark s---                
#               IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
#                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#               ELSE
#                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#               END IF
#160811-00009#2  mark e---
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""   #160811-00009#2 add
               CALL  q_authorised_ld()                                  #呼叫開窗
               LET g_master.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
               IF NOT cl_null(g_master.xrcald) THEN
                  CALL s_axrt300_site_geared_ld(g_master.xrcasite,g_master.xrcald,g_user,g_today,'ld')
                     RETURNING l_success,g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
#                  SELECT glaa024,glaa003,glaacomp INTO l_glaa024,l_glaa003,l_glaacomp FROM glaa_t
#                   WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
               END IF
               DISPLAY BY NAME g_master.xrcald,g_master.xrcald_desc
               NEXT FIELD xrcald                              #返回原欄位  

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
        
         #end add-point
     
         DISPLAY ARRAY g_stjf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq800_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq800_b_fill2()
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
            CALL axrq800_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF cl_null(g_master.xrcasite) OR cl_null(g_master.xrcald) THEN
               #帳務中心
               #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
               CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.xrcasite,g_errno
               #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
               CALL s_fin_orga_get_comp_ld(g_master.xrcasite) RETURNING l_success,g_errno,l_xrcacomp,g_master.xrcald   
               
               #若取不出資料,則不預設帳別
               IF NOT l_success THEN
                  LET g_master.xrcald   = ''
               END IF
               
               CALL s_axrt300_xrca_ref('xrcald',g_master.xrcald,'','') RETURNING l_success,g_master.xrcald_desc
               CALL s_axrt300_xrca_ref('xrcasite',g_master.xrcasite,'','') RETURNING l_success,g_master.xrcasite_desc
               DISPLAY BY NAME g_master.xrcasite,g_master.xrcasite_desc,g_master.xrcald,g_master.xrcald_desc
            END IF
            LET g_wc=" 1=1"
            #end add-point
            NEXT FIELD xrcasite
 
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
            CALL axrq800_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_stjf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axrq800_b_fill()
 
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
            CALL axrq800_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq800_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq800_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq800_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq800_filter()
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
 
{<section id="axrq800.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq800_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
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
 
   CALL g_stjf_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',stjf004,'','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY stjf_t.stjfseq) AS RANK FROM stjf_t", 
 
 
 
                     "",
                     " WHERE stjfent=? AND stjf001=? AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stjf_t"),
                     " ORDER BY stjf_t.stjfseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
    
  LET ls_sql_rank = "SELECT  UNIQUE '',stjesite,ooefl003,stje001,stjf004,stael003,stje020,stje019,stje008,stje025,stje011,stje012,'','','' ,DENSE_RANK() OVER( ORDER BY stjf_t.stjfseq) AS RANK ", 
            "   FROM stje_t,stjf_t,ooefl_t,stael_t ",
            "  WHERE stjesite IN (select ooef001 FROM ooef_t 
                                  WHERE ooefent='",g_enterprise,"' 
                                    AND ooef017=(select glaacomp FROM glaa_t
                                                  WHERE glaaenT='",g_enterprise,"'
                                                    AND glaald='",g_master.xrcald,"')) ",
            "    AND stjeent=stjfent ",
            "    AND stje001=stjf001 ",
            "    AND stjesite=ooefl001 ",
            "    AND ooeflent='",g_enterprise,"' ",
            "    AND ooefl002='",g_lang,"' ",
            "    AND stjf004=stael001 ",
            "    AND staelent='",g_enterprise,"' ",
            "    AND stael002='",g_lang,"' ",
            "    AND stjeent=? ",
            "    AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stjf_t"),
                     " ORDER BY stjesite,stje001,stjf004"                                             
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
 
   LET g_sql = "SELECT '','','','',stjf004,'','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT '',stjesite,ooefl003,stje001,stjf004,stael003,stje020,stje019,stje008,stje025,stje011,stje012,'','','' ",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq800_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq800_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_stjf_d[l_ac].num,g_stjf_d[l_ac].stjesite,g_stjf_d[l_ac].ooefl003,g_stjf_d[l_ac].stje001, 
       g_stjf_d[l_ac].stjf004,g_stjf_d[l_ac].stael003,g_stjf_d[l_ac].stje020,g_stjf_d[l_ac].stje019, 
       g_stjf_d[l_ac].stje008,g_stjf_d[l_ac].stje025,g_stjf_d[l_ac].stje011,g_stjf_d[l_ac].stje012,g_stjf_d[l_ac].l_chr20, 
       g_stjf_d[l_ac].l_num20_6,g_stjf_d[l_ac].l_chr200
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_stjf_d[l_ac].num=l_ac
      #end add-point
 
      CALL axrq800_detail_show("'1'")
 
      CALL axrq800_stjf_t_mask()
 
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
 
   CALL g_stjf_d.deleteElement(g_stjf_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_stjf_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axrq800_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq800_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq800_detail_action_trans()
 
   LET l_ac = 1
   IF g_stjf_d.getLength() > 0 THEN
      CALL axrq800_b_fill2()
   END IF
 
      CALL axrq800_filter_show('ooefl003','b_ooefl003')
   CALL axrq800_filter_show('stjf004','b_stjf004')
   CALL axrq800_filter_show('stael003','b_stael003')
   CALL axrq800_filter_show('stje020','b_stje020')
   CALL axrq800_filter_show('stje019','b_stje019')
   CALL axrq800_filter_show('stje008','b_stje008')
   CALL axrq800_filter_show('stje025','b_stje025')
   CALL axrq800_filter_show('stje011','b_stje011')
   CALL axrq800_filter_show('stje012','b_stje012')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq800.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq800_b_fill2()
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
 
{<section id="axrq800.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq800_detail_show(ps_page)
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
 
{<section id="axrq800.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrq800_filter()
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
      CONSTRUCT g_wc_filter ON ooefl003,stjf004,stael003,stje020,stje019,stje008,stje025,stje011,stje012 
 
                          FROM s_detail1[1].b_ooefl003,s_detail1[1].b_stjf004,s_detail1[1].b_stael003, 
                              s_detail1[1].b_stje020,s_detail1[1].b_stje019,s_detail1[1].b_stje008,s_detail1[1].b_stje025, 
                              s_detail1[1].b_stje011,s_detail1[1].b_stje012
 
         BEFORE CONSTRUCT
                     DISPLAY axrq800_filter_parser('ooefl003') TO s_detail1[1].b_ooefl003
            DISPLAY axrq800_filter_parser('stjf004') TO s_detail1[1].b_stjf004
            DISPLAY axrq800_filter_parser('stael003') TO s_detail1[1].b_stael003
            DISPLAY axrq800_filter_parser('stje020') TO s_detail1[1].b_stje020
            DISPLAY axrq800_filter_parser('stje019') TO s_detail1[1].b_stje019
            DISPLAY axrq800_filter_parser('stje008') TO s_detail1[1].b_stje008
            DISPLAY axrq800_filter_parser('stje025') TO s_detail1[1].b_stje025
            DISPLAY axrq800_filter_parser('stje011') TO s_detail1[1].b_stje011
            DISPLAY axrq800_filter_parser('stje012') TO s_detail1[1].b_stje012
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<num>>----
         #----<<b_stjesite>>----
         #----<<b_ooefl003>>----
         #Ctrlp:construct.c.filter.page1.b_ooefl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ooefl003
            #add-point:ON ACTION controlp INFIELD b_ooefl003 name="construct.c.filter.page1.b_ooefl003"
            
            #END add-point
 
 
         #----<<b_stje001>>----
         #----<<b_stjf004>>----
         #Ctrlp:construct.c.filter.page1.b_stjf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf004
            #add-point:ON ACTION controlp INFIELD b_stjf004 name="construct.c.filter.page1.b_stjf004"
            
            #END add-point
 
 
         #----<<b_stael003>>----
         #Ctrlp:construct.c.filter.page1.b_stael003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stael003
            #add-point:ON ACTION controlp INFIELD b_stael003 name="construct.c.filter.page1.b_stael003"
            
            #END add-point
 
 
         #----<<b_stje020>>----
         #Ctrlp:construct.c.filter.page1.b_stje020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje020
            #add-point:ON ACTION controlp INFIELD b_stje020 name="construct.c.filter.page1.b_stje020"
            
            #END add-point
 
 
         #----<<b_stje019>>----
         #Ctrlp:construct.c.filter.page1.b_stje019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje019
            #add-point:ON ACTION controlp INFIELD b_stje019 name="construct.c.filter.page1.b_stje019"
            
            #END add-point
 
 
         #----<<b_stje008>>----
         #Ctrlp:construct.c.filter.page1.b_stje008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje008
            #add-point:ON ACTION controlp INFIELD b_stje008 name="construct.c.filter.page1.b_stje008"
            
            #END add-point
 
 
         #----<<b_stje025>>----
         #Ctrlp:construct.c.filter.page1.b_stje025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje025
            #add-point:ON ACTION controlp INFIELD b_stje025 name="construct.c.filter.page1.b_stje025"
            
            #END add-point
 
 
         #----<<b_stje011>>----
         #Ctrlp:construct.c.filter.page1.b_stje011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje011
            #add-point:ON ACTION controlp INFIELD b_stje011 name="construct.c.filter.page1.b_stje011"
            
            #END add-point
 
 
         #----<<b_stje012>>----
         #Ctrlp:construct.c.filter.page1.b_stje012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje012
            #add-point:ON ACTION controlp INFIELD b_stje012 name="construct.c.filter.page1.b_stje012"
            
            #END add-point
 
 
         #----<<l_chr20>>----
         #----<<l_num20_6>>----
         #----<<l_chr200>>----
 
 
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
 
      CALL axrq800_filter_show('ooefl003','b_ooefl003')
   CALL axrq800_filter_show('stjf004','b_stjf004')
   CALL axrq800_filter_show('stael003','b_stael003')
   CALL axrq800_filter_show('stje020','b_stje020')
   CALL axrq800_filter_show('stje019','b_stje019')
   CALL axrq800_filter_show('stje008','b_stje008')
   CALL axrq800_filter_show('stje025','b_stje025')
   CALL axrq800_filter_show('stje011','b_stje011')
   CALL axrq800_filter_show('stje012','b_stje012')
 
 
   CALL axrq800_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq800.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrq800_filter_parser(ps_field)
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
 
{<section id="axrq800.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq800_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq800_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrq800.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq800_detail_action_trans()
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
 
{<section id="axrq800.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq800_detail_index_setting()
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
            IF g_stjf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stjf_d.getLength() AND g_stjf_d.getLength() > 0
            LET g_detail_idx = g_stjf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stjf_d.getLength() THEN
               LET g_detail_idx = g_stjf_d.getLength()
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
 
{<section id="axrq800.mask_functions" >}
 &include "erp/axr/axrq800_mask.4gl"
 
{</section>}
 
{<section id="axrq800.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axrq800_get_ooef001_wc(p_wc)
DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

 
{</section>}
 
