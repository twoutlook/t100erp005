#該程式未解開Section, 採用最新樣板產出!
{<section id="afmp040.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-02-18 15:38:53), PR版次:0002(2016-10-24 09:53:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: afmp040
#+ Description: 融資系統重評價作業
#+ Creator....: 01727(2016-02-17 17:30:52)
#+ Modifier...: 01727 -SD/PR- 06814
 
{</section>}
 
{<section id="afmp040.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161006-00005#24  2016/10/24 By 06814    帳務中心開窗改用q_ooef001_46() 
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
PRIVATE TYPE type_g_fmdf_d RECORD
       
       sel LIKE type_t.chr1, 
   fmdfdocno LIKE fmdf_t.fmdfdocno, 
   glaald LIKE type_t.chr5, 
   glaald_desc LIKE type_t.chr500, 
   glaacomp LIKE type_t.chr10, 
   glaacomp_desc LIKE type_t.chr500, 
   glaa001 LIKE glaa_t.glaa001, 
   glca002 LIKE type_t.chr500, 
   glca003 LIKE type_t.chr500, 
   fmdf003 LIKE type_t.chr20
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單头 type 宣告
 TYPE type_g_master RECORD
       b_site           LIKE xrcb_t.xrcbsite, 
       b_site_desc      LIKE ooefl_t.ooefl003,
       fmdf001          LIKE fmdf_t.fmdf001,
       fmdf002          LIKE fmdf_t.fmdf002
       END RECORD

#模組變數(Module Variables)
DEFINE g_master         type_g_master
DEFINE g_master_t       type_g_master
DEFINE g_success        LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmdf_d            DYNAMIC ARRAY OF type_g_fmdf_d
DEFINE g_fmdf_d_t          type_g_fmdf_d
 
 
 
 
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
 
{<section id="afmp040.main" >}
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
   CALL cl_ap_init("afm","")
 
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
   DECLARE afmp040_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmp040_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmp040_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmp040 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmp040_init()   
 
      #進入選單 Menu (="N")
      CALL afmp040_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmp040
      
   END IF 
   
   CLOSE afmp040_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmp040.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmp040_init()
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
   
      CALL cl_set_combo_scc('b_glca002','8317') 
   CALL cl_set_combo_scc('b_glca003','40') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_set_comp_scc('fmdf001','43')   #1102 add
   CALL s_fin_set_comp_scc('fmdf002','111') #1208 add     
   CALL cl_set_combo_scc('b_glca002','8317') 
   CALL cl_set_combo_scc('b_glca003','8724') 
   CALL s_fin_create_account_center_tmp()
   #end add-point
 
   CALL afmp040_default_search()
END FUNCTION
 
{</section>}
 
{<section id="afmp040.default_search" >}
PRIVATE FUNCTION afmp040_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " fmdfld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " fmdfdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " fmdf001 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " fmdf002 = '", g_argv[04], "' AND "
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
 
{<section id="afmp040.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmp040_ui_dialog() 
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
   DEFINE l_fmdf001         LIKE fmdf_t.fmdf001
   DEFINE l_fmdf002         LIKE fmdf_t.fmdf002
   DEFINE l_glaa024         LIKE glaa_t.glaald
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_errno           LIKE type_t.chr10
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
 
   
   CALL afmp040_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_fmdf_d.clear()
 
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
 
         CALL afmp040_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.b_site,g_master.fmdf001,g_master.fmdf002

            BEFORE INPUT
               IF cl_null(g_master_t.b_site) THEN
                  CALL afmp040_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.b_site,g_master.b_site_desc,g_master.fmdf001,g_master.fmdf002
                    TO b_site,site_desc,fmdf001,fmdf002

            AFTER FIELD b_site
               LET g_master.b_site_desc = ' '
               DISPLAY BY NAME g_master.b_site_desc
               IF NOT cl_null(g_master.b_site) THEN
                  #資料存在性、有效性檢查
                  LET g_errno = ' '
                  CALL s_fin_account_center_chk(g_master.b_site,'',3,g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.b_site
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL afmp040_site_desc()

            BEFORE FIELD fmdf001
               LET l_fmdf001 = g_master.fmdf001

            ON CHANGE fmdf001
               IF NOT cl_null(g_master.fmdf001) THEN
                  IF NOT cl_null(g_master.fmdf001) THEN
                     CALL afmp040_b_fill()
                  END IF
               END IF

            BEFORE FIELD fmdf002
               LET l_fmdf002 = g_master.fmdf002

            ON CHANGE fmdf002
               IF NOT cl_null(g_master.fmdf002) THEN
                  IF NOT cl_null(g_master.fmdf002) THEN
                     CALL afmp040_b_fill()
                  END IF
               END IF

            ON ACTION controlp INFIELD b_site
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.b_site       #給予default值
               #161006-00005#24 20161024 add by beckxie---S
               #LET g_qryparam.where = " ooef201 = 'Y' "
               #CALL q_ooef001()                                #呼叫開窗
               #161006-00005#24 20161024 add by beckxie---E
               CALL q_ooef001_46()                             #161006-00005#24 20161024 add by beckxie
               LET g_master.b_site = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.b_site TO b_site               #顯示到畫面上
               CALL afmp040_site_desc()
               NEXT FIELD b_site                               #返回原欄位

         END INPUT  
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #使用INPUT邏輯直接點擊單身選擇按鈕選擇資料
         {
         #end add-point
     
         DISPLAY ARRAY g_fmdf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL afmp040_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afmp040_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         }
         INPUT ARRAY g_fmdf_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)

            BEFORE ROW
               LET l_ac = ARR_CURR()
               IF NOT cl_null(g_fmdf_d[l_ac].sel) AND g_fmdf_d[l_ac].sel = 'Y' THEN
                  CALL cl_set_comp_entry('b_fmdfdocno',TRUE)
               ELSE
                  CALL cl_set_comp_entry('b_fmdfdocno',FALSE)
               END IF

            ON CHANGE sel
               IF g_fmdf_d[l_ac].sel = 'Y' THEN
                  CALL afmp040_clik_chk(l_ac) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fmdf_d[l_ac].sel = 'N'
                     DISPLAY g_fmdf_d[l_ac].sel TO sel
                     NEXT FIELD sel
                  ELSE
                     IF NOT cl_null(l_errno) THEN
                        IF NOT cl_ask_confirm(l_errno) THEN
                           LET g_fmdf_d[l_ac].sel = 'N'
                           DISPLAY g_fmdf_d[l_ac].sel TO sel
                           NEXT FIELD sel
                        END IF
                     END IF
                  END IF
               END IF
               IF NOT cl_null(g_fmdf_d[l_ac].sel) AND g_fmdf_d[l_ac].sel = 'Y' THEN
                  CALL cl_set_comp_entry('b_fmdfdocno',TRUE)
                  CALL afmp040_get_def_slip(g_fmdf_d[l_ac].glaald) RETURNING g_fmdf_d[l_ac].fmdfdocno
               ELSE
                  CALL cl_set_comp_entry('b_fmdfdocno',FALSE)
                  LET g_fmdf_d[l_ac].fmdfdocno = ''
               END IF
               DISPLAY g_fmdf_d[l_ac].fmdfdocno TO b_fmdfdocno

            AFTER FIELD b_fmdfdocno
               IF NOT cl_null(g_fmdf_d[l_ac].fmdfdocno) THEN
                  SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise
                     AND glaald = g_fmdf_d[l_ac].glaald
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_glaa024
                  LET g_chkparam.arg2 = g_fmdf_d[l_ac].fmdfdocno
                  IF NOT cl_chk_exist("v_oobx001_1") THEN
                     LET g_fmdf_d[l_ac].fmdfdocno = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF

            ON ACTION controlp INFIELD b_fmdfdocno        
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fmdf_d[l_ac].fmdfdocno             #給予default值

               #給予arg
               SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaald = g_fmdf_d[l_ac].glaald
               LET g_qryparam.arg1 = l_glaa024
               LET g_qryparam.arg2 = "afmt190"

               CALL q_ooba002_1()                                             #呼叫開窗

               LET g_fmdf_d[l_ac].fmdfdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

               DISPLAY g_fmdf_d[l_ac].fmdfdocno TO b_fmdfdocno                #顯示到畫面上

               NEXT FIELD b_fmdfdocno                                         #返回原欄位

            AFTER INPUT
               CALL cl_set_comp_entry('b_fmdfdocno',FALSE)

         END INPUT
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afmp040_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD b_site
            #end add-point
            NEXT FIELD site
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            LET g_master_t.* =  g_master.*
            CALL afmp040_b_fill()
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
            #重新查詢時默認都不選擇,所以單別欄位設置關閉
            CALL cl_set_comp_entry('b_fmdfdocno',FALSE)
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL afmp040_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_fmdf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL afmp040_b_fill()
 
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
            CALL afmp040_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afmp040_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afmp040_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afmp040_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               LET g_fmdf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               CALL afmp040_clik_chk(li_idx)  RETURNING l_success,l_errno
               IF NOT cl_null(l_errno) THEN
                  LET g_fmdf_d[li_idx].sel = 'N'
                  DISPLAY g_fmdf_d[li_idx].sel TO sel
                  LET g_fmdf_d[li_idx].fmdfdocno = ''
               ELSE
                  CALL afmp040_get_def_slip(g_fmdf_d[li_idx].glaald) RETURNING g_fmdf_d[li_idx].fmdfdocno
               END IF
               DISPLAY g_fmdf_d[li_idx].fmdfdocno TO b_fmdfdocno
            END FOR
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               LET g_fmdf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               LET g_fmdf_d[li_idx].fmdfdocno = ''
               DISPLAY g_fmdf_d[li_idx].fmdfdocno TO b_fmdfdocno
            END FOR
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_fmdf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  CALL afmp040_clik_chk(li_idx) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fmdf_d[li_idx].sel = 'N'
                     DISPLAY g_fmdf_d[li_idx].sel TO sel
                     LET g_fmdf_d[li_idx].fmdfdocno = ''
                  ELSE
                     IF NOT cl_ask_confirm(l_errno) THEN
                        LET g_fmdf_d[li_idx].sel = 'N'
                        LET g_fmdf_d[li_idx].fmdfdocno = ''
                        DISPLAY g_fmdf_d[li_idx].sel TO sel
                     ELSE
                        CALL afmp040_get_def_slip(g_fmdf_d[li_idx].glaald) RETURNING g_fmdf_d[li_idx].fmdfdocno
                     END IF
                  END IF
                  DISPLAY g_fmdf_d[li_idx].fmdfdocno TO b_fmdfdocno
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_fmdf_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_fmdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_fmdf_d[li_idx].fmdfdocno = ''
                  DISPLAY g_fmdf_d[li_idx].fmdfdocno TO b_fmdfdocno
               END IF
            END FOR
         
         ON ACTION batch_execute
            CALL afmp040_cycle_ld()

            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afmp040_filter()
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
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
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
            INITIALIZE g_master.* TO NULL
            CALL afmp040_def()
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
 
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="afmp040.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmp040_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_ooef017       LIKE ooef_t.ooef017
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_count         LIKE type_t.num5
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
 
   CALL g_fmdf_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',fmdfdocno,'','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY fmdf_t.fmdfld, 
       fmdf_t.fmdfdocno,fmdf_t.fmdf001,fmdf_t.fmdf002) AS RANK FROM fmdf_t",
 
 
                     "",
                     " WHERE fmdfent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("fmdf_t"),
                     " ORDER BY fmdf_t.fmdfld,fmdf_t.fmdfdocno,fmdf_t.fmdf001,fmdf_t.fmdf002"
 
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
 
   LET g_sql = "SELECT '',fmdfdocno,'','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.b_site,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_ld_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL afmp040_get_xreald_wc(ls_wc) RETURNING ls_wc
   
   LET g_sql =" SELECT 'N','',glaald,'',glaacomp,'',glaa001,glca002,glca003,'' FROM glaa_t,glca_t ",
              "  WHERE glaaent = ? ",
              "    AND glaaent = glcaent ",
              "    AND glaald = glcald ",
              "    AND glca001 = 'FM' ",
              "    AND glca002 <> '1' ",    #無重評不撈出
              "    AND glaald IN ",ls_wc,    
              "  ORDER BY glaald,glaacomp "


   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmp040_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmp040_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_fmdf_d[l_ac].sel,g_fmdf_d[l_ac].fmdfdocno,g_fmdf_d[l_ac].glaald,g_fmdf_d[l_ac].glaald_desc, 
       g_fmdf_d[l_ac].glaacomp,g_fmdf_d[l_ac].glaacomp_desc,g_fmdf_d[l_ac].glaa001,g_fmdf_d[l_ac].glca002, 
       g_fmdf_d[l_ac].glca003,g_fmdf_d[l_ac].fmdf003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL s_axrt300_xrca_ref('xrcald',g_fmdf_d[l_ac].glaald,'','')
         RETURNING l_success,g_fmdf_d[l_ac].glaald_desc
      LET g_fmdf_d[l_ac].glaald_desc = g_fmdf_d[l_ac].glaald,"(",g_fmdf_d[l_ac].glaald_desc,")"

      CALL s_axrt300_xrca_ref('xrcasite',g_fmdf_d[l_ac].glaacomp,'','')
         RETURNING l_success,g_fmdf_d[l_ac].glaacomp_desc
      LET g_fmdf_d[l_ac].glaacomp_desc = g_fmdf_d[l_ac].glaacomp,"(",g_fmdf_d[l_ac].glaacomp_desc,")"

      #已做重評價處理後,默認不勾選
      LET l_count = 0
      SELECT COUNT(*) INTO l_count FROM xreb_t WHERE xrebent = g_enterprise AND glaald = g_fmdf_d[l_ac].glaald
         AND xreb001 = g_master.fmdf001 AND xreb002 = g_master.fmdf002 AND xreb003 = 'AR'
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count > 0 THEN LET g_fmdf_d[l_ac].sel = 'N' END IF

      SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise
         AND glaald = g_fmdf_d[l_ac].glaald
      #end add-point
 
      CALL afmp040_detail_show("'1'")
 
      CALL afmp040_fmdf_t_mask()
 
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
 
   CALL g_fmdf_d.deleteElement(g_fmdf_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_fmdf_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE afmp040_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afmp040_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afmp040_detail_action_trans()
 
   LET l_ac = 1
   IF g_fmdf_d.getLength() > 0 THEN
      CALL afmp040_b_fill2()
   END IF
 
      CALL afmp040_filter_show('fmdfdocno','b_fmdfdocno')
   CALL afmp040_filter_show('glaa001','b_glaa001')
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmp040.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmp040_b_fill2()
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
 
{<section id="afmp040.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmp040_detail_show(ps_page)
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
 
{<section id="afmp040.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION afmp040_filter()
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
      CONSTRUCT g_wc_filter ON fmdfdocno,glaa001
                          FROM s_detail1[1].b_fmdfdocno,s_detail1[1].b_glaa001
 
         BEFORE CONSTRUCT
                     DISPLAY afmp040_filter_parser('fmdfdocno') TO s_detail1[1].b_fmdfdocno
            DISPLAY afmp040_filter_parser('glaa001') TO s_detail1[1].b_glaa001
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_fmdfdocno>>----
         #Ctrlp:construct.c.filter.page1.b_fmdfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmdfdocno
            #add-point:ON ACTION controlp INFIELD b_fmdfdocno name="construct.c.filter.page1.b_fmdfdocno"
            
            #END add-point
 
 
         #----<<b_glaald>>----
         #----<<b_glaald_desc>>----
         #----<<b_glaacomp>>----
         #----<<b_glaacomp_desc>>----
         #----<<b_glaa001>>----
         #Ctrlp:construct.c.page1.b_glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaa001
            #add-point:ON ACTION controlp INFIELD b_glaa001 name="construct.c.filter.page1.b_glaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaa001  #顯示到畫面上
            NEXT FIELD b_glaa001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glca002>>----
         #----<<b_glca003>>----
         #----<<fmdf003>>----
 
 
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
 
      CALL afmp040_filter_show('fmdfdocno','b_fmdfdocno')
   CALL afmp040_filter_show('glaa001','b_glaa001')
 
 
   CALL afmp040_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afmp040.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION afmp040_filter_parser(ps_field)
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
 
{<section id="afmp040.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION afmp040_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmp040_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="afmp040.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afmp040_detail_action_trans()
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
 
{<section id="afmp040.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afmp040_detail_index_setting()
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
            IF g_fmdf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_fmdf_d.getLength() AND g_fmdf_d.getLength() > 0
            LET g_detail_idx = g_fmdf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_fmdf_d.getLength() THEN
               LET g_detail_idx = g_fmdf_d.getLength()
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
 
{<section id="afmp040.mask_functions" >}
 &include "erp/afm/afmp040_mask.4gl"
 
{</section>}
 
{<section id="afmp040.other_function" readonly="Y" >}

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
PRIVATE FUNCTION afmp040_site_desc()
   DEFINE l_success      LIKE type_t.chr1

   CALL s_axrt300_xrca_ref('xrcasite',g_master.b_site,'','') RETURNING l_success,g_master.b_site_desc
   DISPLAY g_master.b_site_desc TO site_desc
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
PRIVATE FUNCTION afmp040_def()
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_flag            LIKE type_t.dat
   DEFINE l_ooef017         LIKE ooef_t.ooef017

   IF NOT cl_null(g_master.b_site) THEN RETURN END IF

   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.b_site,g_errno
   CALL afmp040_site_desc()

   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET g_master.fmdf001 = YEAR(l_flag)
   LET g_master.fmdf002 = MONTH(l_flag)
   #畫面刷新時單身無資料,所以單別欄位設置關閉
   CALL cl_set_comp_entry('b_fmdfdocno',FALSE)

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
PRIVATE FUNCTION afmp040_get_xreald_wc(p_wc)
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
PRIVATE FUNCTION afmp040_cycle_ld()
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_title     LIKE gzzd_t.gzzd005
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_fmdfdocno LIKE fmdf_t.fmdfdocno
   DEFINE l_docno     STRING

   SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd001 = 'axrt300' AND gzzd002 = g_lang AND gzzd003 = 'lbl_xrcadocno'

   LET l_flag = FALSE
   FOR l_i = 1 TO g_fmdf_d.getLength()
      IF NOT cl_null(g_fmdf_d[l_i].sel) AND g_fmdf_d[l_i].sel = "Y" AND NOT cl_null(g_fmdf_d[l_i].fmdfdocno) THEN
         LET l_flag = TRUE
      END IF
   END FOR
   IF NOT l_flag THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afm-00255'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = "N"
      RETURN
   END IF

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET g_coll_title[1] = l_title
   LET g_success = 'Y'
   LET l_docno = ""

   FOR l_i = 1 TO g_fmdf_d.getLength()
      IF g_fmdf_d[l_i].sel = "Y" THEN
         CALL s_afmp040_get_fmdf(g_master.b_site,g_fmdf_d[l_i].glaald,g_fmdf_d[l_i].fmdfdocno,g_master.fmdf001,g_master.fmdf002)
            RETURNING g_success,l_fmdfdocno
         IF cl_null(l_docno) THEN
            LET l_docno = l_fmdfdocno
         ELSE
            LET l_docno = l_docno,",",l_fmdfdocno
         END IF
      END IF
   END FOR

   IF g_success = 'N' THEN
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_init()

      IF NOT cl_null(l_docno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axm-00088'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    

         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afm-00236'
         LET g_errparam.replace[1] = l_docno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'ast-00401'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
      END IF
      CALL cl_err_collect_show()
   END IF

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afmp040_clik_chk(p_ac)
# Input parameter: 
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp040_clik_chk(p_ac)
   DEFINE p_ac        LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE type_t.chr10
   DEFINE l_count     LIKE type_t.num5
   
   LET r_errno = NULL
   LET r_success = TRUE
   IF cl_null(p_ac) OR p_ac <= 0 THEN
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF

   #STEP1.檢查當前期資料是否拋轉傳票,如果拋轉傳票則報錯并告知用戶先做憑證還原
   #STEP3.檢查是否存在當前期資料,如果存在則詢問是否刪除重新產生
   #STEP4.檢查是否存在前一期資料,如果沒有則詢問是否繼續

  #STEP1 ---(S)---
  #已有傳票代號或不做重评价处理,不可選擇!
   IF NOT cl_null(g_fmdf_d[p_ac].fmdf003) OR g_fmdf_d[p_ac].glca002 = '1' THEN
      LET r_errno = 'axr-00169'
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF
  #STEP1 ---(E)---

  #STEP2 ---(S)---
  #當前年期已有已審核的重評价資料
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM fmdf_t WHERE fmdfent = g_enterprise
      AND fmdfld = g_fmdf_d[p_ac].glaald
      AND fmdf001 = g_master.fmdf001
      AND fmdf002 = g_master.fmdf002
      AND fmdfstus = 'Y'
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 1 THEN
      LET r_errno = 'afm-00249'
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF
  #STEP2 ---(E)---

  #STEP3 ---(S)---
  #檢查是否存在當前期資料,如果存在則詢問是否刪除重新產生
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM fmdf_t WHERE fmdfent = g_enterprise
      AND fmdfld = g_fmdf_d[p_ac].glaald
      AND fmdf001 = g_master.fmdf001
      AND fmdf002 = g_master.fmdf002
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 1 THEN
      LET r_errno = 'afm-00235'
      RETURN r_success,r_errno
   END IF
  #STEP3 ---(E)---

  #STEP4 ---(S)---
  #檢查是否存在前一期資料,如果沒有則詢問是否繼續
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM fmdf_t WHERE fmdfent = g_enterprise
      AND fmdfld = g_fmdf_d[p_ac].glaald
      AND fmdf001 * 12 + fmdf002 + 1 = g_master.fmdf001 * 12 + g_master.fmdf002
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET r_errno = 'afm-00234'
      RETURN r_success,r_errno
   END IF
  #STEP4 ---(E)---

   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 根據帳套取得默認單別
# Memo...........:
# Usage..........: CALL afmp040_get_def_slip(p_glaald)
#                  RETURNING r_fmdfdocno
# Input parameter: p_glaald       帳套
# Return code....: r_fmdfdocno    單別
# Date & Author..: 2016/02/18 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp040_get_def_slip(p_glaald)
   DEFINE p_glaald         LIKE glaa_t.glaald
   DEFINE r_fmdfdocno      LIKE fmdf_t.fmdfdocno
   DEFINE l_glaa024        LIKE glaa_t.glaa024

   SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = p_glaald

   DECLARE afmp040_slip CURSOR FOR
      SELECT ooba002 FROM ooba_t WHERE oobaent = g_enterprise
         AND ooba001 = l_glaa024
         AND ooba002  IN (SELECT oobl001 FROM oobl_t WHERE  ooblent = g_enterprise
                             AND oobl002 = 'afmt190' )
         AND oobastus = 'Y'

   FOREACH afmp040_slip INTO r_fmdfdocno
      EXIT FOREACH
   END FOREACH

   RETURN r_fmdfdocno

END FUNCTION

 
{</section>}
 
