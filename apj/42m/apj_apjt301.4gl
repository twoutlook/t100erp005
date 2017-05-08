#該程式未解開Section, 採用最新樣板產出!
{<section id="apjt301.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-10-08 14:13:51), PR版次:0006(2017-01-16 14:26:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: apjt301
#+ Description: 專案人工製費收集維護作業
#+ Creator....: 02294(2015-10-08 10:30:30)
#+ Modifier...: 02294 -SD/PR- 02749
 
{</section>}
 
{<section id="apjt301.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#8   2016/04/20 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160905-00007#3   2016/09/05 By zhujing     调整系统中无ENT的SQL条件增加ent
#160913-00055#3   2016/09/18 By lixiang     客户栏位开窗调整为q_pmaa001_13
#161019-00017#1   2016/10/20 By lixh        组织类型调整 q_ooef001 => q_ooef001_13
#160824-00007#331 2017/01/16 By lori        舊植備份處理調整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pjbz_m        RECORD
       pjbzcomp LIKE pjbz_t.pjbzcomp, 
   pjbzcomp_desc LIKE type_t.chr80, 
   pjbzld LIKE pjbz_t.pjbzld, 
   pjbzld_desc LIKE type_t.chr80, 
   pjbz002 LIKE pjbz_t.pjbz002, 
   pjbz003 LIKE pjbz_t.pjbz003, 
   pjbz004 LIKE pjbz_t.pjbz004, 
   pjbz004_desc LIKE type_t.chr80, 
   pjbz001 LIKE pjbz_t.pjbz001
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pjbz_d        RECORD
       pjbzseq LIKE pjbz_t.pjbzseq, 
   pjbz010 LIKE pjbz_t.pjbz010, 
   pjbz010_desc LIKE type_t.chr500, 
   pjbz011 LIKE pjbz_t.pjbz011, 
   pjbz011_desc LIKE type_t.chr500, 
   pjbz012 LIKE pjbz_t.pjbz012, 
   pjbz012_desc LIKE type_t.chr500, 
   pjbz013 LIKE pjbz_t.pjbz013, 
   pjbz013_desc LIKE type_t.chr500, 
   pjbz014 LIKE pjbz_t.pjbz014, 
   pjbz014_desc LIKE type_t.chr500, 
   pjbz015 LIKE pjbz_t.pjbz015, 
   pjbz015_desc LIKE type_t.chr500, 
   pjbz016 LIKE pjbz_t.pjbz016, 
   pjbz016_desc LIKE type_t.chr500, 
   pjbz017 LIKE pjbz_t.pjbz017, 
   pjbz018 LIKE pjbz_t.pjbz018, 
   pjbz018_desc LIKE type_t.chr500, 
   pjbz019 LIKE pjbz_t.pjbz019, 
   pjbz019_desc LIKE type_t.chr500, 
   pjbz020 LIKE pjbz_t.pjbz020, 
   pjbz020_desc LIKE type_t.chr500, 
   pjbz021 LIKE pjbz_t.pjbz021, 
   pjbz021_desc LIKE type_t.chr500, 
   pjbz022 LIKE pjbz_t.pjbz022, 
   pjbz022_desc LIKE type_t.chr500, 
   pjbz100 LIKE pjbz_t.pjbz100
       END RECORD
PRIVATE TYPE type_g_pjbz2_d RECORD
       pjbzseq LIKE pjbz_t.pjbzseq, 
   pjbzownid LIKE pjbz_t.pjbzownid, 
   pjbzownid_desc LIKE type_t.chr500, 
   pjbzowndp LIKE pjbz_t.pjbzowndp, 
   pjbzowndp_desc LIKE type_t.chr500, 
   pjbzcrtid LIKE pjbz_t.pjbzcrtid, 
   pjbzcrtid_desc LIKE type_t.chr500, 
   pjbzcrtdp LIKE pjbz_t.pjbzcrtdp, 
   pjbzcrtdp_desc LIKE type_t.chr500, 
   pjbzcrtdt DATETIME YEAR TO SECOND, 
   pjbzmodid LIKE pjbz_t.pjbzmodid, 
   pjbzmodid_desc LIKE type_t.chr500, 
   pjbzmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa005             LIKE glaa_t.glaa005
DEFINE g_glaa003             LIKE glaa_t.glaa003
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_glaa008             LIKE glaa_t.glaa008
DEFINE g_glaa014             LIKE glaa_t.glaa014
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa024             LIKE glaa_t.glaa024
DEFINE g_para_data           LIKE type_t.chr80    #啟用次要素否 #fengmy
DEFINE g_xcau003             LIKE xcau_t.xcau003  #140928 fengmy
DEFINE g_type                LIKE xcdk_t.xcdk003  #141231 fengmy
DEFINE g_bdate               LIKE type_t.dat       #当期所属的起始日期
DEFINE g_edate               LIKE type_t.dat       #当期所属的截止日期
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_pjbz_m          type_g_pjbz_m
DEFINE g_pjbz_m_t        type_g_pjbz_m
DEFINE g_pjbz_m_o        type_g_pjbz_m
DEFINE g_pjbz_m_mask_o   type_g_pjbz_m #轉換遮罩前資料
DEFINE g_pjbz_m_mask_n   type_g_pjbz_m #轉換遮罩後資料
 
   DEFINE g_pjbzld_t LIKE pjbz_t.pjbzld
DEFINE g_pjbz002_t LIKE pjbz_t.pjbz002
DEFINE g_pjbz003_t LIKE pjbz_t.pjbz003
DEFINE g_pjbz004_t LIKE pjbz_t.pjbz004
DEFINE g_pjbz001_t LIKE pjbz_t.pjbz001
 
 
DEFINE g_pjbz_d          DYNAMIC ARRAY OF type_g_pjbz_d
DEFINE g_pjbz_d_t        type_g_pjbz_d
DEFINE g_pjbz_d_o        type_g_pjbz_d
DEFINE g_pjbz_d_mask_o   DYNAMIC ARRAY OF type_g_pjbz_d #轉換遮罩前資料
DEFINE g_pjbz_d_mask_n   DYNAMIC ARRAY OF type_g_pjbz_d #轉換遮罩後資料
DEFINE g_pjbz2_d   DYNAMIC ARRAY OF type_g_pjbz2_d
DEFINE g_pjbz2_d_t type_g_pjbz2_d
DEFINE g_pjbz2_d_o type_g_pjbz2_d
DEFINE g_pjbz2_d_mask_o   DYNAMIC ARRAY OF type_g_pjbz2_d #轉換遮罩前資料
DEFINE g_pjbz2_d_mask_n   DYNAMIC ARRAY OF type_g_pjbz2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_pjbzld LIKE pjbz_t.pjbzld,
      b_pjbz001 LIKE pjbz_t.pjbz001,
      b_pjbz002 LIKE pjbz_t.pjbz002,
      b_pjbz003 LIKE pjbz_t.pjbz003,
      b_pjbz004 LIKE pjbz_t.pjbz004
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apjt301.main" >}
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
   CALL cl_ap_init("apj","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pjbzcomp,'',pjbzld,'',pjbz002,pjbz003,pjbz004,'',pjbz001", 
                      " FROM pjbz_t",
                      " WHERE pjbzent= ? AND pjbzld=? AND pjbz001=? AND pjbz002=? AND pjbz003=? AND  
                          pjbz004=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apjt301_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pjbzcomp,t0.pjbzld,t0.pjbz002,t0.pjbz003,t0.pjbz004,t0.pjbz001,t1.ooefl003 , 
       t2.glaal002 ,t3.pjbal003",
               " FROM pjbz_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pjbzcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.pjbzld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t3 ON t3.pjbalent="||g_enterprise||" AND t3.pjbal001=t0.pjbz004 AND t3.pjbal002='"||g_dlang||"' ",
 
               " WHERE t0.pjbzent = " ||g_enterprise|| " AND t0.pjbzld = ? AND t0.pjbz001 = ? AND t0.pjbz002 = ? AND t0.pjbz003 = ? AND t0.pjbz004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apjt301_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjt301 WITH FORM cl_ap_formpath("apj",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apjt301_init()   
 
      #進入選單 Menu (="N")
      CALL apjt301_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apjt301
      
   END IF 
   
   CLOSE apjt301_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apjt301.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apjt301_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('pjbz001','8908') 
   CALL cl_set_combo_scc('pjbz017','6013') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
 
   #end add-point
   
   CALL apjt301_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apjt301.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apjt301_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pjbz_m.* TO NULL
         CALL g_pjbz_d.clear()
         CALL g_pjbz2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apjt301_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_pjbz_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL apjt301_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apjt301_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_pjbz2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL apjt301_idx_chk()
               CALL apjt301_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL apjt301_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL apjt301_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apjt301_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apjt301_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjt301_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apjt301_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjt301_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apjt301_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjt301_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apjt301_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjt301_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apjt301_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjt301_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_pjbz_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pjbz2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
            
         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
                CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD pjbzseq
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL apjt301_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apjt301_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL apjt301_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apjt301_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apj/apjt301_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apjt301_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apjt301_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apjt301_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apjt301_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apjt301_01
            LET g_action_choice="open_apjt301_01"
            IF cl_auth_chk_act("open_apjt301_01") THEN
               
               #add-point:ON ACTION open_apjt301_01 name="menu.open_apjt301_01"
               CALL apjt301_01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apjt301_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apjt301_02
            LET g_action_choice="open_apjt301_02"
            IF cl_auth_chk_act("open_apjt301_02") THEN
               
               #add-point:ON ACTION open_apjt301_02 name="menu.open_apjt301_02"
               CALL apjt301_02()
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apjt301_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apjt301_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apjt301_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
         CONTINUE DIALOG
            
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION apjt301_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apjt301_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   
   #end add-point    
 
   LET l_searchcol = "pjbzld,pjbz001,pjbz002,pjbz003,pjbz004"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pjbzld ",
                      ", pjbz001 ",
                      ", pjbz002 ",
                      ", pjbz003 ",
                      ", pjbz004 ",
 
                      " FROM pjbz_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE pjbzent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pjbz_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pjbzld ",
                      ", pjbz001 ",
                      ", pjbz002 ",
                      ", pjbz003 ",
                      ", pjbz004 ",
 
                      " FROM pjbz_t ",
                      " ",
                      " ", 
 
 
                      " WHERE pjbzent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pjbz_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_pjbz_m.* TO NULL
      CALL g_pjbz_d.clear()        
      CALL g_pjbz2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pjbzld,t0.pjbz001,t0.pjbz002,t0.pjbz003,t0.pjbz004 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.pjbzld,t0.pjbz001,t0.pjbz002,t0.pjbz003,t0.pjbz004",
                " FROM pjbz_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.pjbzent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("pjbz_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"pjbz_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_pjbzld,g_browser[g_cnt].b_pjbz001,g_browser[g_cnt].b_pjbz002, 
          g_browser[g_cnt].b_pjbz003,g_browser[g_cnt].b_pjbz004 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point  
      
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
      END FOREACH
      FREE browse_pre
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_pjbzld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_pjbz_m.* TO NULL
      CALL g_pjbz_d.clear()
      CALL g_pjbz2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL apjt301_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apjt301_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pjbz_m.pjbzld = g_browser[g_current_idx].b_pjbzld   
   LET g_pjbz_m.pjbz001 = g_browser[g_current_idx].b_pjbz001   
   LET g_pjbz_m.pjbz002 = g_browser[g_current_idx].b_pjbz002   
   LET g_pjbz_m.pjbz003 = g_browser[g_current_idx].b_pjbz003   
   LET g_pjbz_m.pjbz004 = g_browser[g_current_idx].b_pjbz004   
 
   EXECUTE apjt301_master_referesh USING g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003, 
       g_pjbz_m.pjbz004 INTO g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004, 
       g_pjbz_m.pjbz001,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz004_desc
   CALL apjt301_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apjt301_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apjt301_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_pjbzld = g_pjbz_m.pjbzld 
         AND g_browser[l_i].b_pjbz001 = g_pjbz_m.pjbz001 
         AND g_browser[l_i].b_pjbz002 = g_pjbz_m.pjbz002 
         AND g_browser[l_i].b_pjbz003 = g_pjbz_m.pjbz003 
         AND g_browser[l_i].b_pjbz004 = g_pjbz_m.pjbz004 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apjt301_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_pjbz_m.* TO NULL
   CALL g_pjbz_d.clear()
   CALL g_pjbz2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pjbzcomp,pjbzld,pjbz002,pjbz003,pjbz004,pjbz001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.pjbzcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzcomp
            #add-point:ON ACTION controlp INFIELD pjbzcomp name="construct.c.pjbzcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbzcomp  #顯示到畫面上
            NEXT FIELD pjbzcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzcomp
            #add-point:BEFORE FIELD pjbzcomp name="construct.b.pjbzcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzcomp
            
            #add-point:AFTER FIELD pjbzcomp name="construct.a.pjbzcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbzld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzld
            #add-point:ON ACTION controlp INFIELD pjbzld name="construct.c.pjbzld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 


            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbzld  #顯示到畫面上
            NEXT FIELD pjbzld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzld
            #add-point:BEFORE FIELD pjbzld name="construct.b.pjbzld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzld
            
            #add-point:AFTER FIELD pjbzld name="construct.a.pjbzld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz002
            #add-point:BEFORE FIELD pjbz002 name="construct.b.pjbz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz002
            
            #add-point:AFTER FIELD pjbz002 name="construct.a.pjbz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz002
            #add-point:ON ACTION controlp INFIELD pjbz002 name="construct.c.pjbz002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz003
            #add-point:BEFORE FIELD pjbz003 name="construct.b.pjbz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz003
            
            #add-point:AFTER FIELD pjbz003 name="construct.a.pjbz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz003
            #add-point:ON ACTION controlp INFIELD pjbz003 name="construct.c.pjbz003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pjbz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz004
            #add-point:ON ACTION controlp INFIELD pjbz004 name="construct.c.pjbz004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz004  #顯示到畫面上
            NEXT FIELD pjbz004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz004
            #add-point:BEFORE FIELD pjbz004 name="construct.b.pjbz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz004
            
            #add-point:AFTER FIELD pjbz004 name="construct.a.pjbz004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz001
            #add-point:BEFORE FIELD pjbz001 name="construct.b.pjbz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz001
            
            #add-point:AFTER FIELD pjbz001 name="construct.a.pjbz001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjbz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz001
            #add-point:ON ACTION controlp INFIELD pjbz001 name="construct.c.pjbz001"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON pjbzseq,pjbz010,pjbz011,pjbz012,pjbz013,pjbz014,pjbz015,pjbz016,pjbz017, 
          pjbz018,pjbz019,pjbz020,pjbz021,pjbz022,pjbz100,pjbzownid,pjbzowndp,pjbzcrtid,pjbzcrtdp,pjbzcrtdt, 
          pjbzmodid,pjbzmoddt
           FROM s_detail1[1].pjbzseq,s_detail1[1].pjbz010,s_detail1[1].pjbz011,s_detail1[1].pjbz012, 
               s_detail1[1].pjbz013,s_detail1[1].pjbz014,s_detail1[1].pjbz015,s_detail1[1].pjbz016,s_detail1[1].pjbz017, 
               s_detail1[1].pjbz018,s_detail1[1].pjbz019,s_detail1[1].pjbz020,s_detail1[1].pjbz021,s_detail1[1].pjbz022, 
               s_detail1[1].pjbz100,s_detail2[1].pjbzownid,s_detail2[1].pjbzowndp,s_detail2[1].pjbzcrtid, 
               s_detail2[1].pjbzcrtdp,s_detail2[1].pjbzcrtdt,s_detail2[1].pjbzmodid,s_detail2[1].pjbzmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pjbzcrtdt>>----
         AFTER FIELD pjbzcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pjbzmoddt>>----
         AFTER FIELD pjbzmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pjbzcnfdt>>----
         
         #----<<pjbzpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzseq
            #add-point:BEFORE FIELD pjbzseq name="construct.b.page1.pjbzseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzseq
            
            #add-point:AFTER FIELD pjbzseq name="construct.a.page1.pjbzseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbzseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzseq
            #add-point:ON ACTION controlp INFIELD pjbzseq name="construct.c.page1.pjbzseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjbz010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz010
            #add-point:ON ACTION controlp INFIELD pjbz010 name="construct.c.page1.pjbz010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 != '1' "
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz010  #顯示到畫面上
            NEXT FIELD pjbz010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz010
            #add-point:BEFORE FIELD pjbz010 name="construct.b.page1.pjbz010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz010
            
            #add-point:AFTER FIELD pjbz010 name="construct.a.page1.pjbz010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz011
            #add-point:ON ACTION controlp INFIELD pjbz011 name="construct.c.page1.pjbz011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161019-00017#1
            CALL q_ooef001_13()   #161019-00017#1
            DISPLAY g_qryparam.return1 TO pjbz011  #顯示到畫面上
            NEXT FIELD pjbz011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz011
            #add-point:BEFORE FIELD pjbz011 name="construct.b.page1.pjbz011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz011
            
            #add-point:AFTER FIELD pjbz011 name="construct.a.page1.pjbz011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz012
            #add-point:ON ACTION controlp INFIELD pjbz012 name="construct.c.page1.pjbz012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz012  #顯示到畫面上
            NEXT FIELD pjbz012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz012
            #add-point:BEFORE FIELD pjbz012 name="construct.b.page1.pjbz012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz012
            
            #add-point:AFTER FIELD pjbz012 name="construct.a.page1.pjbz012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz013
            #add-point:ON ACTION controlp INFIELD pjbz013 name="construct.c.page1.pjbz013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001_4()                           #呼叫開窗  #160913-00055#3 
            CALL q_pmaa001_13()        #160913-00055#3
            DISPLAY g_qryparam.return1 TO pjbz013  #顯示到畫面上
            NEXT FIELD pjbz013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz013
            #add-point:BEFORE FIELD pjbz013 name="construct.b.page1.pjbz013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz013
            
            #add-point:AFTER FIELD pjbz013 name="construct.a.page1.pjbz013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz014
            #add-point:ON ACTION controlp INFIELD pjbz014 name="construct.c.page1.pjbz014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz014  #顯示到畫面上
            NEXT FIELD pjbz014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz014
            #add-point:BEFORE FIELD pjbz014 name="construct.b.page1.pjbz014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz014
            
            #add-point:AFTER FIELD pjbz014 name="construct.a.page1.pjbz014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz015
            #add-point:ON ACTION controlp INFIELD pjbz015 name="construct.c.page1.pjbz015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz015  #顯示到畫面上
            NEXT FIELD pjbz015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz015
            #add-point:BEFORE FIELD pjbz015 name="construct.b.page1.pjbz015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz015
            
            #add-point:AFTER FIELD pjbz015 name="construct.a.page1.pjbz015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz016
            #add-point:ON ACTION controlp INFIELD pjbz016 name="construct.c.page1.pjbz016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz016  #顯示到畫面上
            NEXT FIELD pjbz016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz016
            #add-point:BEFORE FIELD pjbz016 name="construct.b.page1.pjbz016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz016
            
            #add-point:AFTER FIELD pjbz016 name="construct.a.page1.pjbz016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz017
            #add-point:BEFORE FIELD pjbz017 name="construct.b.page1.pjbz017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz017
            
            #add-point:AFTER FIELD pjbz017 name="construct.a.page1.pjbz017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz017
            #add-point:ON ACTION controlp INFIELD pjbz017 name="construct.c.page1.pjbz017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '6013'
            CALL q_gzcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz017  #顯示到畫面上
            NEXT FIELD pjbz017                     #返回原欄位
    


            #END add-point
 
 
         #Ctrlp:construct.c.page1.pjbz018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz018
            #add-point:ON ACTION controlp INFIELD pjbz018 name="construct.c.page1.pjbz018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2035'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz018  #顯示到畫面上
            NEXT FIELD pjbz018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz018
            #add-point:BEFORE FIELD pjbz018 name="construct.b.page1.pjbz018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz018
            
            #add-point:AFTER FIELD pjbz018 name="construct.a.page1.pjbz018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz019
            #add-point:ON ACTION controlp INFIELD pjbz019 name="construct.c.page1.pjbz019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz019  #顯示到畫面上
            NEXT FIELD pjbz019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz019
            #add-point:BEFORE FIELD pjbz019 name="construct.b.page1.pjbz019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz019
            
            #add-point:AFTER FIELD pjbz019 name="construct.a.page1.pjbz019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz020
            #add-point:ON ACTION controlp INFIELD pjbz020 name="construct.c.page1.pjbz020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz020  #顯示到畫面上
            NEXT FIELD pjbz020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz020
            #add-point:BEFORE FIELD pjbz020 name="construct.b.page1.pjbz020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz020
            
            #add-point:AFTER FIELD pjbz020 name="construct.a.page1.pjbz020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz021
            #add-point:ON ACTION controlp INFIELD pjbz021 name="construct.c.page1.pjbz021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz021  #顯示到畫面上
            NEXT FIELD pjbz021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz021
            #add-point:BEFORE FIELD pjbz021 name="construct.b.page1.pjbz021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz021
            
            #add-point:AFTER FIELD pjbz021 name="construct.a.page1.pjbz021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz022
            #add-point:ON ACTION controlp INFIELD pjbz022 name="construct.c.page1.pjbz022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbz022  #顯示到畫面上
            NEXT FIELD pjbz022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz022
            #add-point:BEFORE FIELD pjbz022 name="construct.b.page1.pjbz022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz022
            
            #add-point:AFTER FIELD pjbz022 name="construct.a.page1.pjbz022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz100
            #add-point:BEFORE FIELD pjbz100 name="construct.b.page1.pjbz100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz100
            
            #add-point:AFTER FIELD pjbz100 name="construct.a.page1.pjbz100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pjbz100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz100
            #add-point:ON ACTION controlp INFIELD pjbz100 name="construct.c.page1.pjbz100"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pjbzownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzownid
            #add-point:ON ACTION controlp INFIELD pjbzownid name="construct.c.page2.pjbzownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbzownid  #顯示到畫面上
            NEXT FIELD pjbzownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzownid
            #add-point:BEFORE FIELD pjbzownid name="construct.b.page2.pjbzownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzownid
            
            #add-point:AFTER FIELD pjbzownid name="construct.a.page2.pjbzownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjbzowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzowndp
            #add-point:ON ACTION controlp INFIELD pjbzowndp name="construct.c.page2.pjbzowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbzowndp  #顯示到畫面上
            NEXT FIELD pjbzowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzowndp
            #add-point:BEFORE FIELD pjbzowndp name="construct.b.page2.pjbzowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzowndp
            
            #add-point:AFTER FIELD pjbzowndp name="construct.a.page2.pjbzowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjbzcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzcrtid
            #add-point:ON ACTION controlp INFIELD pjbzcrtid name="construct.c.page2.pjbzcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbzcrtid  #顯示到畫面上
            NEXT FIELD pjbzcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzcrtid
            #add-point:BEFORE FIELD pjbzcrtid name="construct.b.page2.pjbzcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzcrtid
            
            #add-point:AFTER FIELD pjbzcrtid name="construct.a.page2.pjbzcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pjbzcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzcrtdp
            #add-point:ON ACTION controlp INFIELD pjbzcrtdp name="construct.c.page2.pjbzcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbzcrtdp  #顯示到畫面上
            NEXT FIELD pjbzcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzcrtdp
            #add-point:BEFORE FIELD pjbzcrtdp name="construct.b.page2.pjbzcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzcrtdp
            
            #add-point:AFTER FIELD pjbzcrtdp name="construct.a.page2.pjbzcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzcrtdt
            #add-point:BEFORE FIELD pjbzcrtdt name="construct.b.page2.pjbzcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pjbzmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzmodid
            #add-point:ON ACTION controlp INFIELD pjbzmodid name="construct.c.page2.pjbzmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbzmodid  #顯示到畫面上
            NEXT FIELD pjbzmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzmodid
            #add-point:BEFORE FIELD pjbzmodid name="construct.b.page2.pjbzmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzmodid
            
            #add-point:AFTER FIELD pjbzmodid name="construct.a.page2.pjbzmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzmoddt
            #add-point:BEFORE FIELD pjbzmoddt name="construct.b.page2.pjbzmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         
         #end add-point
      
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
   
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apjt301_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
   #end add-point 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
   
   LET ls_wc = g_wc
 
   LET INT_FLAG = 0    
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_pjbz_d.clear()
   CALL g_pjbz2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apjt301_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apjt301_browser_fill(g_wc)
      CALL apjt301_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL apjt301_browser_fill("F")
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL apjt301_fetch("F") 
   END IF
   
   CALL apjt301_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apjt301_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL apjt301_browser_fill(p_flag)
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_pjbz_m.pjbzld = g_browser[g_current_idx].b_pjbzld
   LET g_pjbz_m.pjbz001 = g_browser[g_current_idx].b_pjbz001
   LET g_pjbz_m.pjbz002 = g_browser[g_current_idx].b_pjbz002
   LET g_pjbz_m.pjbz003 = g_browser[g_current_idx].b_pjbz003
   LET g_pjbz_m.pjbz004 = g_browser[g_current_idx].b_pjbz004
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apjt301_master_referesh USING g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003, 
       g_pjbz_m.pjbz004 INTO g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004, 
       g_pjbz_m.pjbz001,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz004_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjbz_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_pjbz_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_pjbz_m_mask_o.* =  g_pjbz_m.*
   CALL apjt301_pjbz_t_mask()
   LET g_pjbz_m_mask_n.* =  g_pjbz_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apjt301_set_act_visible()
   CALL apjt301_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_pjbz_m_t.* = g_pjbz_m.*
   LET g_pjbz_m_o.* = g_pjbz_m.*
   
   #重新顯示   
   CALL apjt301_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.insert" >}
#+ 資料新增
PRIVATE FUNCTION apjt301_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_pjbz_d.clear()
   CALL g_pjbz2_d.clear()
 
 
   INITIALIZE g_pjbz_m.* TO NULL             #DEFAULT 設定
   LET g_pjbzld_t = NULL
   LET g_pjbz001_t = NULL
   LET g_pjbz002_t = NULL
   LET g_pjbz003_t = NULL
   LET g_pjbz004_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_pjbz_m.pjbz001 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"

      #预设当前site的法人，主账套，年度期别，成本计算类型
      CALL s_axc_set_site_default() RETURNING g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_type
      DISPLAY BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003
      CALL apjt301_show_ref()
      #end add-point 
 
      CALL apjt301_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_pjbz_m.* TO NULL
         INITIALIZE g_pjbz_d TO NULL
         INITIALIZE g_pjbz2_d TO NULL
 
         CALL apjt301_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjbz_m.* = g_pjbz_m_t.*
         CALL apjt301_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_pjbz_d.clear()
      #CALL g_pjbz2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apjt301_set_act_visible()
   CALL apjt301_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjbzld_t = g_pjbz_m.pjbzld
   LET g_pjbz001_t = g_pjbz_m.pjbz001
   LET g_pjbz002_t = g_pjbz_m.pjbz002
   LET g_pjbz003_t = g_pjbz_m.pjbz003
   LET g_pjbz004_t = g_pjbz_m.pjbz004
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjbzent = " ||g_enterprise|| " AND",
                      " pjbzld = '", g_pjbz_m.pjbzld, "' "
                      ," AND pjbz001 = '", g_pjbz_m.pjbz001, "' "
                      ," AND pjbz002 = '", g_pjbz_m.pjbz002, "' "
                      ," AND pjbz003 = '", g_pjbz_m.pjbz003, "' "
                      ," AND pjbz004 = '", g_pjbz_m.pjbz004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apjt301_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL apjt301_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apjt301_master_referesh USING g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003, 
       g_pjbz_m.pjbz004 INTO g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004, 
       g_pjbz_m.pjbz001,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz004_desc
   
   #遮罩相關處理
   LET g_pjbz_m_mask_o.* =  g_pjbz_m.*
   CALL apjt301_pjbz_t_mask()
   LET g_pjbz_m_mask_n.* =  g_pjbz_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz002, 
       g_pjbz_m.pjbz003,g_pjbz_m.pjbz004,g_pjbz_m.pjbz004_desc,g_pjbz_m.pjbz001
   
   #功能已完成,通報訊息中心
   CALL apjt301_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.modify" >}
#+ 資料修改
PRIVATE FUNCTION apjt301_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_pjbz_m.pjbzld IS NULL
   OR g_pjbz_m.pjbz001 IS NULL
   OR g_pjbz_m.pjbz002 IS NULL
   OR g_pjbz_m.pjbz003 IS NULL
   OR g_pjbz_m.pjbz004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_pjbzld_t = g_pjbz_m.pjbzld
   LET g_pjbz001_t = g_pjbz_m.pjbz001
   LET g_pjbz002_t = g_pjbz_m.pjbz002
   LET g_pjbz003_t = g_pjbz_m.pjbz003
   LET g_pjbz004_t = g_pjbz_m.pjbz004
 
   CALL s_transaction_begin()
   
   OPEN apjt301_cl USING g_enterprise,g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apjt301_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apjt301_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apjt301_master_referesh USING g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003, 
       g_pjbz_m.pjbz004 INTO g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004, 
       g_pjbz_m.pjbz001,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz004_desc
   
   #遮罩相關處理
   LET g_pjbz_m_mask_o.* =  g_pjbz_m.*
   CALL apjt301_pjbz_t_mask()
   LET g_pjbz_m_mask_n.* =  g_pjbz_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL apjt301_show()
   WHILE TRUE
      LET g_pjbzld_t = g_pjbz_m.pjbzld
      LET g_pjbz001_t = g_pjbz_m.pjbz001
      LET g_pjbz002_t = g_pjbz_m.pjbz002
      LET g_pjbz003_t = g_pjbz_m.pjbz003
      LET g_pjbz004_t = g_pjbz_m.pjbz004
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL apjt301_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_pjbz_m.* = g_pjbz_m_t.*
         CALL apjt301_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_pjbz_m.pjbzld != g_pjbzld_t 
      OR g_pjbz_m.pjbz001 != g_pjbz001_t 
      OR g_pjbz_m.pjbz002 != g_pjbz002_t 
      OR g_pjbz_m.pjbz003 != g_pjbz003_t 
      OR g_pjbz_m.pjbz004 != g_pjbz004_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apjt301_set_act_visible()
   CALL apjt301_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pjbzent = " ||g_enterprise|| " AND",
                      " pjbzld = '", g_pjbz_m.pjbzld, "' "
                      ," AND pjbz001 = '", g_pjbz_m.pjbz001, "' "
                      ," AND pjbz002 = '", g_pjbz_m.pjbz002, "' "
                      ," AND pjbz003 = '", g_pjbz_m.pjbz003, "' "
                      ," AND pjbz004 = '", g_pjbz_m.pjbz004, "' "
 
   #填到對應位置
   CALL apjt301_browser_fill("")
 
   CALL apjt301_idx_chk()
 
   CLOSE apjt301_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apjt301_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="apjt301.input" >}
#+ 資料輸入
PRIVATE FUNCTION apjt301_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_success             LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz002, 
       g_pjbz_m.pjbz003,g_pjbz_m.pjbz004,g_pjbz_m.pjbz004_desc,g_pjbz_m.pjbz001
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT pjbzseq,pjbz010,pjbz011,pjbz012,pjbz013,pjbz014,pjbz015,pjbz016,pjbz017, 
       pjbz018,pjbz019,pjbz020,pjbz021,pjbz022,pjbz100,pjbzseq,pjbzownid,pjbzowndp,pjbzcrtid,pjbzcrtdp, 
       pjbzcrtdt,pjbzmodid,pjbzmoddt FROM pjbz_t WHERE pjbzent=? AND pjbzld=? AND pjbz001=? AND pjbz002=?  
       AND pjbz003=? AND pjbz004=? AND pjbzseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apjt301_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apjt301_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apjt301_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004, 
       g_pjbz_m.pjbz001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   
   CALL apjt301_get_date()
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apjt301.input.head" >}
   
      #單頭段
      INPUT BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004, 
          g_pjbz_m.pjbz001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzcomp
            
            #add-point:AFTER FIELD pjbzcomp name="input.a.pjbzcomp"
            CALL s_desc_get_department_desc(g_pjbz_m.pjbzcomp) RETURNING g_pjbz_m.pjbzcomp_desc
            DISPLAY BY NAME g_pjbz_m.pjbzcomp_desc
            
            IF NOT cl_null(g_pjbz_m.pjbzcomp) THEN 
               #160824-00007#331 170116 by lori mod---(S)
               ##此段落由子樣板a19產生
               ##設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               #IF NOT cl_null(g_pjbz_m.pjbzcomp) THEN
               #   IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pjbz_m_t.pjbzcomp IS NULL OR g_pjbz_m.pjbzcomp != g_pjbz_m_t.pjbzcomp)) THEN
               #      IF NOT s_axc_chk_ld_comp(g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld) THEN
               #         LET g_pjbz_m.pjbzcomp = g_pjbz_m_t.pjbzcomp
               #         CALL s_desc_get_department_desc(g_pjbz_m.pjbzcomp) RETURNING g_pjbz_m.pjbzcomp_desc
               #         DISPLAY BY NAME g_pjbz_m.pjbzcomp_desc
               #         NEXT FIELD CURRENT
               #      END IF
               #   END IF               
               #END IF
               #
               #INITIALIZE g_chkparam.* TO NULL
               #
               ##設定g_chkparam.*的參數
               #LET g_chkparam.arg1 = g_pjbz_m.pjbzcomp
               #   
               ##呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001_1") THEN
               #   #檢查成功時後續處理
               #
               #    SELECT glaald INTO g_pjbz_m.pjbzld FROM glaa_t
               #     WHERE glaacomp = g_pjbz_m.pjbzcomp
               #       AND glaaent = g_enterprise    #fengmy150327
               #       AND glaa014 = 'Y'
               #    DISPLAY g_pjbz_m.pjbzld TO pjbzld
               #    CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
               #    DISPLAY BY NAME g_pjbz_m.pjbzld_desc
               #ELSE
               #   #檢查失敗時後續處理
               #   LET g_pjbz_m.pjbzcomp = g_pjbz_m_t.pjbzcomp
               #   CALL s_desc_get_department_desc(g_pjbz_m.pjbzcomp) RETURNING g_pjbz_m.pjbzcomp_desc
               #   DISPLAY BY NAME g_pjbz_m.pjbzcomp_desc
               #   LET g_pjbz_m.pjbzld = g_pjbz_m_t.pjbzld
               #   CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
               #   DISPLAY BY NAME g_pjbz_m.pjbzld_desc
               #   NEXT FIELD CURRENT
               #END IF
            
               IF cl_null(g_pjbz_m_o.pjbzcomp) OR g_pjbz_m.pjbzcomp != g_pjbz_m_o.pjbzcomp THEN      
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pjbz_m.pjbzcomp
                  IF cl_chk_exist("v_ooef001_1") THEN
                      SELECT glaald INTO g_pjbz_m.pjbzld FROM glaa_t
                       WHERE glaacomp = g_pjbz_m.pjbzcomp
                         AND glaaent = g_enterprise    #fengmy150327
                         AND glaa014 = 'Y'
                         
                      DISPLAY g_pjbz_m.pjbzld TO pjbzld
                      CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
                      DISPLAY BY NAME g_pjbz_m.pjbzld_desc
                      
                      IF NOT s_axc_chk_ld_comp(g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld) THEN
                         LET g_pjbz_m.pjbzcomp = g_pjbz_m_o.pjbzcomp
                         CALL s_desc_get_department_desc(g_pjbz_m.pjbzcomp) RETURNING g_pjbz_m.pjbzcomp_desc
                         DISPLAY BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzcomp_desc
                         
                         LET g_pjbz_m.pjbzld = g_pjbz_m_o.pjbzld
                         CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
                         DISPLAY BY NAME g_pjbz_m.pjbzld,g_pjbz_m.pjbzld_desc
                         
                         NEXT FIELD CURRENT
                      END IF                       
                  ELSE
                     LET g_pjbz_m.pjbzcomp = g_pjbz_m_o.pjbzcomp
                     CALL s_desc_get_department_desc(g_pjbz_m.pjbzcomp) RETURNING g_pjbz_m.pjbzcomp_desc
                     DISPLAY BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzcomp_desc
                     
                     LET g_pjbz_m.pjbzld = g_pjbz_m_o.pjbzld
                     CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
                     DISPLAY BY NAME g_pjbz_m.pjbzld,g_pjbz_m.pjbzld_desc
                     
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_desc_get_department_desc(g_pjbz_m.pjbzcomp) RETURNING g_pjbz_m.pjbzcomp_desc
                  DISPLAY BY NAME g_pjbz_m.pjbzcomp_desc 
               END IF                   
               #160824-00007#331 170116 by lori mod---(E)
            END IF 
           
            #160824-00007#331 170116 by lori mark---(S)
            #IF NOT cl_null(g_pjbz_m.pjbzcomp) THEN
            #   IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pjbz_m_t.pjbzcomp IS NULL OR g_pjbz_m.pjbzcomp != g_pjbz_m_t.pjbzcomp)) THEN
            #      IF NOT s_axc_chk_ld_comp(g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld) THEN
            #         LET g_pjbz_m.pjbzcomp = g_pjbz_m_t.pjbzcomp
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #   
            #END IF
            #160824-00007#331 170116 by lori mark---(E)
            
            #160824-00007#331 170116 by lori add---(S)
            LET g_pjbz_m_o.pjbzcomp = g_pjbz_m.pjbzcomp
            LET g_pjbz_m_o.pjbzld = g_pjbz_m.pjbzld
            #160824-00007#331 170116 by lori add---(E)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzcomp
            #add-point:BEFORE FIELD pjbzcomp name="input.b.pjbzcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbzcomp
            #add-point:ON CHANGE pjbzcomp name="input.g.pjbzcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzld
            
            #add-point:AFTER FIELD pjbzld name="input.a.pjbzld"
            #此段落由子樣板a05產生
            CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
            DISPLAY BY NAME g_pjbz_m.pjbzld_desc
   
            IF NOT cl_null(g_pjbz_m.pjbzld) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pjbz_m_t.pjbzld IS NULL OR g_pjbz_m.pjbzld != g_pjbz_m_t.pjbzld)) THEN   #160824-00007#331 170116 by lori mark
               IF cl_null(g_pjbz_m_o.pjbzld) OR g_pjbz_m.pjbzld != g_pjbz_m_o.pjbzld THEN                                     #160824-00007#331 170116 by lori add
                  IF NOT s_axc_chk_ld_comp(g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld) THEN
                    #LET g_pjbz_m.pjbzld = g_pjbz_m_t.pjbzld   #160824-00007#331 170116 by lori mark
                     LET g_pjbz_m.pjbzld = g_pjbz_m_o.pjbzld   #160824-00007#331 170116 by lori add
                     DISPLAY BY NAME g_pjbz_m.pjbzld           #160824-00007#331 170116 by lori add
                     
                     CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
                     DISPLAY BY NAME g_pjbz_m.pjbzld_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF  
            
            IF  NOT cl_null(g_pjbz_m.pjbzld) AND NOT cl_null(g_pjbz_m.pjbz001) AND NOT cl_null(g_pjbz_m.pjbz002) AND NOT cl_null(g_pjbz_m.pjbz003) AND NOT cl_null(g_pjbz_m.pjbz004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbz_m.pjbzld != g_pjbzld_t  OR g_pjbz_m.pjbz001 != g_pjbz001_t  OR g_pjbz_m.pjbz002 != g_pjbz002_t  OR g_pjbz_m.pjbz003 != g_pjbz003_t  OR g_pjbz_m.pjbz004 != g_pjbz004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbz_t WHERE "||"pjbzent = '" ||g_enterprise|| "' AND "||"pjbzld = '"||g_pjbz_m.pjbzld ||"' AND "|| "pjbz001 = '"||g_pjbz_m.pjbz001 ||"' AND "|| "pjbz002 = '"||g_pjbz_m.pjbz002 ||"' AND "|| "pjbz003 = '"||g_pjbz_m.pjbz003 ||"' AND "|| "pjbz004 = '"||g_pjbz_m.pjbz004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_pjbz_m.pjbzld) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_m.pjbzld
               LET g_chkparam.arg2 = g_pjbz_m.pjbzcomp 
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald_5") THEN
                  #檢查成功時後續處理
                  CALL s_ld_chk_authorization(g_user,g_pjbz_m.pjbzld) RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_pjbz_m.pjbzld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                    #LET g_pjbz_m.pjbzld = ''                 #160824-00007#331 170116 by lori mark
                     LET g_pjbz_m.pjbzld = g_pjbz_m_o.pjbzld  #160824-00007#331 170116 by lori add
                     DISPLAY BY NAME g_pjbz_m.pjbzld          #160824-00007#331 170116 by lori add
                     
                     CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
                     DISPLAY BY NAME g_pjbz_m.pjbzld_desc
                     NEXT FIELD CURRENT
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                 #LET g_pjbz_m.pjbzld = g_pjbz_m_t.pjbzld   #160824-00007#331 170116 by lori mark
                  LET g_pjbz_m.pjbzld = g_pjbz_m_o.pjbzld   #160824-00007#331 170116 by lori add
                  DISPLAY BY NAME g_pjbz_m.pjbzld           #160824-00007#331 170116 by lori add
                  
                  CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
                  DISPLAY BY NAME g_pjbz_m.pjbzld_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL apjt301_get_date()
            
            LET g_pjbz_m_o.pjbzld = g_pjbz_m.pjbzld   #160824-00007#331 170116 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzld
            #add-point:BEFORE FIELD pjbzld name="input.b.pjbzld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbzld
            #add-point:ON CHANGE pjbzld name="input.g.pjbzld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz002
            #add-point:BEFORE FIELD pjbz002 name="input.b.pjbz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz002
            
            #add-point:AFTER FIELD pjbz002 name="input.a.pjbz002"
            #此段落由子樣板a05產生
            #chk年期
            IF NOT cl_null(g_pjbz_m.pjbz002) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_pjbz_m_t.pjbz002 IS NULL OR g_pjbz_m.pjbz002 != g_pjbz_m_t.pjbz002)) THEN
                  IF NOT apjt301_chk_year_period() THEN
                     LET g_pjbz_m.pjbz002 = g_pjbz_m_t.pjbz002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            IF  NOT cl_null(g_pjbz_m.pjbzld) AND NOT cl_null(g_pjbz_m.pjbz001) AND NOT cl_null(g_pjbz_m.pjbz002) AND NOT cl_null(g_pjbz_m.pjbz003) AND NOT cl_null(g_pjbz_m.pjbz004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbz_m.pjbzld != g_pjbzld_t  OR g_pjbz_m.pjbz001 != g_pjbz001_t  OR g_pjbz_m.pjbz002 != g_pjbz002_t  OR g_pjbz_m.pjbz003 != g_pjbz003_t  OR g_pjbz_m.pjbz004 != g_pjbz004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbz_t WHERE "||"pjbzent = '" ||g_enterprise|| "' AND "||"pjbzld = '"||g_pjbz_m.pjbzld ||"' AND "|| "pjbz001 = '"||g_pjbz_m.pjbz001 ||"' AND "|| "pjbz002 = '"||g_pjbz_m.pjbz002 ||"' AND "|| "pjbz003 = '"||g_pjbz_m.pjbz003 ||"' AND "|| "pjbz004 = '"||g_pjbz_m.pjbz004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF g_pjbz_m.pjbz002 <1000 OR g_pjbz_m.pjbz002 >9999 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00113'
               LET g_errparam.extend = g_pjbz_m.pjbz002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbz_m.pjbz002 = ''
               NEXT FIELD CURRENT
            END IF
            CALL apjt301_get_date()

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz002
            #add-point:ON CHANGE pjbz002 name="input.g.pjbz002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz003
            #add-point:BEFORE FIELD pjbz003 name="input.b.pjbz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz003
            
            #add-point:AFTER FIELD pjbz003 name="input.a.pjbz003"
            #此段落由子樣板a05產生
                     
            #chk年期
            IF NOT cl_null(g_pjbz_m.pjbz003) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_pjbz_m_t.pjbz003 IS NULL OR g_pjbz_m.pjbz003 != g_pjbz_m_t.pjbz003)) THEN
                  IF NOT apjt301_chk_year_period() THEN
                     LET g_pjbz_m.pjbz003 = g_pjbz_m_t.pjbz003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
           
            IF  NOT cl_null(g_pjbz_m.pjbzld) AND NOT cl_null(g_pjbz_m.pjbz001) AND NOT cl_null(g_pjbz_m.pjbz002) AND NOT cl_null(g_pjbz_m.pjbz003) AND NOT cl_null(g_pjbz_m.pjbz004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbz_m.pjbzld != g_pjbzld_t  OR g_pjbz_m.pjbz001 != g_pjbz001_t  OR g_pjbz_m.pjbz002 != g_pjbz002_t  OR g_pjbz_m.pjbz003 != g_pjbz003_t  OR g_pjbz_m.pjbz004 != g_pjbz004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbz_t WHERE "||"pjbzent = '" ||g_enterprise|| "' AND "||"pjbzld = '"||g_pjbz_m.pjbzld ||"' AND "|| "pjbz001 = '"||g_pjbz_m.pjbz001 ||"' AND "|| "pjbz002 = '"||g_pjbz_m.pjbz002 ||"' AND "|| "pjbz003 = '"||g_pjbz_m.pjbz003 ||"' AND "|| "pjbz004 = '"||g_pjbz_m.pjbz004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_pjbz_m.pjbz003) THEN
               IF (g_pjbz_m.pjbz003 < 1) OR (g_pjbz_m.pjbz003 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_pjbz_m.pjbz003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbz_m.pjbz003 = ''
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            CALL apjt301_get_date()

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz003
            #add-point:ON CHANGE pjbz003 name="input.g.pjbz003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz004
            
            #add-point:AFTER FIELD pjbz004 name="input.a.pjbz004"
            #此段落由子樣板a05產生
            CALL s_desc_get_project_desc(g_pjbz_m.pjbz004) RETURNING g_pjbz_m.pjbz004_desc
            DISPLAY BY NAME g_pjbz_m.pjbz004_desc

            IF  NOT cl_null(g_pjbz_m.pjbzld) AND NOT cl_null(g_pjbz_m.pjbz001) AND NOT cl_null(g_pjbz_m.pjbz002) AND NOT cl_null(g_pjbz_m.pjbz003) AND NOT cl_null(g_pjbz_m.pjbz004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbz_m.pjbzld != g_pjbzld_t  OR g_pjbz_m.pjbz001 != g_pjbz001_t  OR g_pjbz_m.pjbz002 != g_pjbz002_t  OR g_pjbz_m.pjbz003 != g_pjbz003_t  OR g_pjbz_m.pjbz004 != g_pjbz004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbz_t WHERE "||"pjbzent = '" ||g_enterprise|| "' AND "||"pjbzld = '"||g_pjbz_m.pjbzld ||"' AND "|| "pjbz001 = '"||g_pjbz_m.pjbz001 ||"' AND "|| "pjbz002 = '"||g_pjbz_m.pjbz002 ||"' AND "|| "pjbz003 = '"||g_pjbz_m.pjbz003 ||"' AND "|| "pjbz004 = '"||g_pjbz_m.pjbz004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_pjbz_m.pjbz004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_m.pjbz004
               LET g_chkparam.arg2 = g_bdate
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001_4") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_m.pjbz004 = g_pjbz_m_t.pjbz004
                  CALL s_desc_get_project_desc(g_pjbz_m.pjbz004) RETURNING g_pjbz_m.pjbz004_desc
                  DISPLAY BY NAME g_pjbz_m.pjbz004_desc
                  NEXT FIELD CURRENT
               END IF
            
            END IF 

            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz004
            #add-point:BEFORE FIELD pjbz004 name="input.b.pjbz004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz004
            #add-point:ON CHANGE pjbz004 name="input.g.pjbz004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz001
            #add-point:BEFORE FIELD pjbz001 name="input.b.pjbz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz001
            
            #add-point:AFTER FIELD pjbz001 name="input.a.pjbz001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pjbz_m.pjbzld) AND NOT cl_null(g_pjbz_m.pjbz001) AND NOT cl_null(g_pjbz_m.pjbz002) AND NOT cl_null(g_pjbz_m.pjbz003) AND NOT cl_null(g_pjbz_m.pjbz004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbz_m.pjbzld != g_pjbzld_t  OR g_pjbz_m.pjbz001 != g_pjbz001_t  OR g_pjbz_m.pjbz002 != g_pjbz002_t  OR g_pjbz_m.pjbz003 != g_pjbz003_t  OR g_pjbz_m.pjbz004 != g_pjbz004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbz_t WHERE "||"pjbzent = '" ||g_enterprise|| "' AND "||"pjbzld = '"||g_pjbz_m.pjbzld ||"' AND "|| "pjbz001 = '"||g_pjbz_m.pjbz001 ||"' AND "|| "pjbz002 = '"||g_pjbz_m.pjbz002 ||"' AND "|| "pjbz003 = '"||g_pjbz_m.pjbz003 ||"' AND "|| "pjbz004 = '"||g_pjbz_m.pjbz004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz001
            #add-point:ON CHANGE pjbz001 name="input.g.pjbz001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pjbzcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzcomp
            #add-point:ON ACTION controlp INFIELD pjbzcomp name="input.c.pjbzcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_m.pjbzcomp             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_pjbz_m.pjbzcomp = g_qryparam.return1              
           
            DISPLAY g_pjbz_m.pjbzcomp TO pjbzcomp              #

            NEXT FIELD pjbzcomp                          #返回原欄位

            SELECT glaald INTO g_pjbz_m.pjbzld FROM glaa_t
             WHERE glaacomp = g_pjbz_m.pjbzcomp
               AND glaa014 = 'Y'
               AND glaaent = g_enterprise    #160905-00007#3 add
            DISPLAY g_pjbz_m.pjbzld TO pjbzld
            CALL apjt301_show_ref()
            #END add-point
 
 
         #Ctrlp:input.c.pjbzld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzld
            #add-point:ON ACTION controlp INFIELD pjbzld name="input.c.pjbzld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_m.pjbzld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
             IF g_pjbz_m.pjbzcomp IS NOT NULL THEN
               LET g_qryparam.where = " glaacomp = '",g_pjbz_m.pjbzcomp,"'"
            END IF           
            CALL q_authorised_ld()                                #呼叫開窗
   
            LET g_pjbz_m.pjbzld = g_qryparam.return1              
            CALL apjt301_show_ref()
            DISPLAY g_pjbz_m.pjbzld TO pjbzld              #

            NEXT FIELD pjbzld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pjbz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz002
            #add-point:ON ACTION controlp INFIELD pjbz002 name="input.c.pjbz002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz003
            #add-point:ON ACTION controlp INFIELD pjbz003 name="input.c.pjbz003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz004
            #add-point:ON ACTION controlp INFIELD pjbz004 name="input.c.pjbz004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_m.pjbz004             #給予default值
           
            #給予arg
            LET g_qryparam.arg1 = ""
  
            LET g_qryparam.where = " (pjba013 IS NULL OR pjba013 >= to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')) "

            CALL q_pjba001_4()
            #CALL q_pjba001()                                #呼叫開窗

            LET g_pjbz_m.pjbz004 = g_qryparam.return1              
            CALL apjt301_show_ref()
            DISPLAY g_pjbz_m.pjbz004 TO pjbz004              #

            NEXT FIELD pjbz004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pjbz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz001
            #add-point:ON ACTION controlp INFIELD pjbz001 name="input.c.pjbz001"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pjbz_m.pjbzld             
                            ,g_pjbz_m.pjbz001   
                            ,g_pjbz_m.pjbz002   
                            ,g_pjbz_m.pjbz003   
                            ,g_pjbz_m.pjbz004   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL apjt301_pjbz_t_mask_restore('restore_mask_o')
            
               UPDATE pjbz_t SET (pjbzcomp,pjbzld,pjbz002,pjbz003,pjbz004,pjbz001) = (g_pjbz_m.pjbzcomp, 
                   g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004,g_pjbz_m.pjbz001) 
 
                WHERE pjbzent = g_enterprise AND pjbzld = g_pjbzld_t
                  AND pjbz001 = g_pjbz001_t
                  AND pjbz002 = g_pjbz002_t
                  AND pjbz003 = g_pjbz003_t
                  AND pjbz004 = g_pjbz004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbz_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjbz_m.pjbzld
               LET gs_keys_bak[1] = g_pjbzld_t
               LET gs_keys[2] = g_pjbz_m.pjbz001
               LET gs_keys_bak[2] = g_pjbz001_t
               LET gs_keys[3] = g_pjbz_m.pjbz002
               LET gs_keys_bak[3] = g_pjbz002_t
               LET gs_keys[4] = g_pjbz_m.pjbz003
               LET gs_keys_bak[4] = g_pjbz003_t
               LET gs_keys[5] = g_pjbz_m.pjbz004
               LET gs_keys_bak[5] = g_pjbz004_t
               LET gs_keys[6] = g_pjbz_d[g_detail_idx].pjbzseq
               LET gs_keys_bak[6] = g_pjbz_d_t.pjbzseq
               CALL apjt301_update_b('pjbz_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_pjbz_m_t)
                     #LET g_log2 = util.JSON.stringify(g_pjbz_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL apjt301_pjbz_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apjt301_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_pjbzld_t = g_pjbz_m.pjbzld
           LET g_pjbz001_t = g_pjbz_m.pjbz001
           LET g_pjbz002_t = g_pjbz_m.pjbz002
           LET g_pjbz003_t = g_pjbz_m.pjbz003
           LET g_pjbz004_t = g_pjbz_m.pjbz004
 
           
           IF g_pjbz_d.getLength() = 0 THEN
              NEXT FIELD pjbzseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="apjt301.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_pjbz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pjbz_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apjt301_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjt301_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN apjt301_cl USING g_enterprise,g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE apjt301_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apjt301_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_pjbz_d[l_ac].pjbzseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pjbz_d_t.* = g_pjbz_d[l_ac].*  #BACKUP
               LET g_pjbz_d_o.* = g_pjbz_d[l_ac].*  #BACKUP
               CALL apjt301_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL apjt301_set_no_entry_b(l_cmd)
               OPEN apjt301_bcl USING g_enterprise,g_pjbz_m.pjbzld,
                                                g_pjbz_m.pjbz001,
                                                g_pjbz_m.pjbz002,
                                                g_pjbz_m.pjbz003,
                                                g_pjbz_m.pjbz004,
 
                                                g_pjbz_d_t.pjbzseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN apjt301_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjt301_bcl INTO g_pjbz_d[l_ac].pjbzseq,g_pjbz_d[l_ac].pjbz010,g_pjbz_d[l_ac].pjbz011, 
                      g_pjbz_d[l_ac].pjbz012,g_pjbz_d[l_ac].pjbz013,g_pjbz_d[l_ac].pjbz014,g_pjbz_d[l_ac].pjbz015, 
                      g_pjbz_d[l_ac].pjbz016,g_pjbz_d[l_ac].pjbz017,g_pjbz_d[l_ac].pjbz018,g_pjbz_d[l_ac].pjbz019, 
                      g_pjbz_d[l_ac].pjbz020,g_pjbz_d[l_ac].pjbz021,g_pjbz_d[l_ac].pjbz022,g_pjbz_d[l_ac].pjbz100, 
                      g_pjbz2_d[l_ac].pjbzseq,g_pjbz2_d[l_ac].pjbzownid,g_pjbz2_d[l_ac].pjbzowndp,g_pjbz2_d[l_ac].pjbzcrtid, 
                      g_pjbz2_d[l_ac].pjbzcrtdp,g_pjbz2_d[l_ac].pjbzcrtdt,g_pjbz2_d[l_ac].pjbzmodid, 
                      g_pjbz2_d[l_ac].pjbzmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_pjbz_d_t.pjbzseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pjbz_d_mask_o[l_ac].* =  g_pjbz_d[l_ac].*
                  CALL apjt301_pjbz_t_mask()
                  LET g_pjbz_d_mask_n[l_ac].* =  g_pjbz_d[l_ac].*
                  
                  CALL apjt301_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_pjbz_d_t.* TO NULL
            INITIALIZE g_pjbz_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbz_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pjbz2_d[l_ac].pjbzownid = g_user
      LET g_pjbz2_d[l_ac].pjbzowndp = g_dept
      LET g_pjbz2_d[l_ac].pjbzcrtid = g_user
      LET g_pjbz2_d[l_ac].pjbzcrtdp = g_dept 
      LET g_pjbz2_d[l_ac].pjbzcrtdt = cl_get_current()
      LET g_pjbz2_d[l_ac].pjbzmodid = g_user
      LET g_pjbz2_d[l_ac].pjbzmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_pjbz_d[l_ac].pjbz017 = "1"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_pjbz_d_t.* = g_pjbz_d[l_ac].*     #新輸入資料
            LET g_pjbz_d_o.* = g_pjbz_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apjt301_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL apjt301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pjbz_d[li_reproduce_target].* = g_pjbz_d[li_reproduce].*
               LET g_pjbz2_d[li_reproduce_target].* = g_pjbz2_d[li_reproduce].*
 
               LET g_pjbz_d[g_pjbz_d.getLength()].pjbzseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_cmd = 'a' THEN 
               IF cl_null(g_pjbz_d[g_detail_idx].pjbzseq) THEN 
                  SELECT MAX(pjbzseq) INTO g_pjbz_d[g_detail_idx].pjbzseq
                    FROM pjbz_t
                   WHERE pjbzent = g_enterprise
                     AND pjbzld = g_pjbz_m.pjbzld
                     AND pjbz001 = g_pjbz_m.pjbz001
                     AND pjbz002 = g_pjbz_m.pjbz002
                     AND pjbz003 = g_pjbz_m.pjbz003
                     AND pjbz004 = g_pjbz_m.pjbz004
                    
                  IF cl_null(g_pjbz_d[g_detail_idx].pjbzseq) THEN 
                     LET g_pjbz_d[g_detail_idx].pjbzseq = 1
                  ELSE
                     LET g_pjbz_d[g_detail_idx].pjbzseq = g_pjbz_d[g_detail_idx].pjbzseq + 1
                  END IF
               END IF
            END IF
            #end add-point  
 
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
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pjbz_t 
             WHERE pjbzent = g_enterprise AND pjbzld = g_pjbz_m.pjbzld
               AND pjbz001 = g_pjbz_m.pjbz001
               AND pjbz002 = g_pjbz_m.pjbz002
               AND pjbz003 = g_pjbz_m.pjbz003
               AND pjbz004 = g_pjbz_m.pjbz004
 
               AND pjbzseq = g_pjbz_d[l_ac].pjbzseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               ##晓峰说成本中心应可以不用维护,但是为key值，所以给空格           
               IF cl_null(g_pjbz_m.pjbz004) THEN LET g_pjbz_m.pjbz004 = ' ' END IF  
               #end add-point
               INSERT INTO pjbz_t
                           (pjbzent,
                            pjbzcomp,pjbzld,pjbz002,pjbz003,pjbz004,pjbz001,
                            pjbzseq
                            ,pjbz010,pjbz011,pjbz012,pjbz013,pjbz014,pjbz015,pjbz016,pjbz017,pjbz018,pjbz019,pjbz020,pjbz021,pjbz022,pjbz100,pjbzownid,pjbzowndp,pjbzcrtid,pjbzcrtdp,pjbzcrtdt,pjbzmodid,pjbzmoddt) 
                     VALUES(g_enterprise,
                            g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004,g_pjbz_m.pjbz001,
                            g_pjbz_d[l_ac].pjbzseq
                            ,g_pjbz_d[l_ac].pjbz010,g_pjbz_d[l_ac].pjbz011,g_pjbz_d[l_ac].pjbz012,g_pjbz_d[l_ac].pjbz013, 
                                g_pjbz_d[l_ac].pjbz014,g_pjbz_d[l_ac].pjbz015,g_pjbz_d[l_ac].pjbz016, 
                                g_pjbz_d[l_ac].pjbz017,g_pjbz_d[l_ac].pjbz018,g_pjbz_d[l_ac].pjbz019, 
                                g_pjbz_d[l_ac].pjbz020,g_pjbz_d[l_ac].pjbz021,g_pjbz_d[l_ac].pjbz022, 
                                g_pjbz_d[l_ac].pjbz100,g_pjbz2_d[l_ac].pjbzownid,g_pjbz2_d[l_ac].pjbzowndp, 
                                g_pjbz2_d[l_ac].pjbzcrtid,g_pjbz2_d[l_ac].pjbzcrtdp,g_pjbz2_d[l_ac].pjbzcrtdt, 
                                g_pjbz2_d[l_ac].pjbzmodid,g_pjbz2_d[l_ac].pjbzmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_pjbz_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pjbz_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF apjt301_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_pjbz_m.pjbzld
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbz_m.pjbz001
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbz_m.pjbz002
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbz_m.pjbz003
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbz_m.pjbz004
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pjbz_d_t.pjbzseq
 
 
                  #刪除下層單身
                  IF NOT apjt301_key_delete_b(gs_keys,'pjbz_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE apjt301_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE apjt301_bcl
               LET l_count = g_pjbz_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_pjbz_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzseq
            #add-point:BEFORE FIELD pjbzseq name="input.b.page1.pjbzseq"
            IF cl_null(g_pjbz_d[g_detail_idx].pjbzseq) THEN 
               SELECT MAX(pjbzseq) INTO g_pjbz_d[g_detail_idx].pjbzseq
                 FROM pjbz_t
                WHERE pjbzent = g_enterprise
                  AND pjbzld = g_pjbz_m.pjbzld
                  AND pjbz001 = g_pjbz_m.pjbz001
                  AND pjbz002 = g_pjbz_m.pjbz002
                  AND pjbz003 = g_pjbz_m.pjbz003
                  AND pjbz004 = g_pjbz_m.pjbz004
                 
               IF cl_null(g_pjbz_d[g_detail_idx].pjbzseq) THEN 
                  LET g_pjbz_d[g_detail_idx].pjbzseq = 1
               ELSE
                  LET g_pjbz_d[g_detail_idx].pjbzseq = g_pjbz_d[g_detail_idx].pjbzseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzseq
            
            #add-point:AFTER FIELD pjbzseq name="input.a.page1.pjbzseq"
            #此段落由子樣板a05產生
            IF  g_pjbz_m.pjbzld IS NOT NULL AND g_pjbz_m.pjbz001 IS NOT NULL AND g_pjbz_m.pjbz002 IS NOT NULL AND g_pjbz_m.pjbz003 IS NOT NULL AND g_pjbz_m.pjbz004 IS NOT NULL AND g_pjbz_d[g_detail_idx].pjbzseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbz_m.pjbzld != g_pjbzld_t OR g_pjbz_m.pjbz001 != g_pjbz001_t OR g_pjbz_m.pjbz002 != g_pjbz002_t OR g_pjbz_m.pjbz003 != g_pjbz003_t OR g_pjbz_m.pjbz004 != g_pjbz004_t OR g_pjbz_d[g_detail_idx].pjbzseq != g_pjbz_d_t.pjbzseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbz_t WHERE "||"pjbzent = '" ||g_enterprise|| "' AND "||"pjbzld = '"||g_pjbz_m.pjbzld ||"' AND "|| "pjbz001 = '"||g_pjbz_m.pjbz001 ||"' AND "|| "pjbz002 = '"||g_pjbz_m.pjbz002 ||"' AND "|| "pjbz003 = '"||g_pjbz_m.pjbz003 ||"' AND "|| "pjbz004 = '"||g_pjbz_m.pjbz004 ||"' AND "|| "pjbzseq = '"||g_pjbz_d[g_detail_idx].pjbzseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbzseq
            #add-point:ON CHANGE pjbzseq name="input.g.page1.pjbzseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz010
            
            #add-point:AFTER FIELD pjbz010 name="input.a.page1.pjbz010"
            CALL apjt301_pjbz010_ref()
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_pjbz_d[l_ac].pjbz010
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#8--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
            
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz010 = g_pjbz_d_t.pjbz010
                  CALL apjt301_pjbz010_ref()
                  NEXT FIELD CURRENT
               END IF
               
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz010
            #add-point:BEFORE FIELD pjbz010 name="input.b.page1.pjbz010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz010
            #add-point:ON CHANGE pjbz010 name="input.g.page1.pjbz010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz011
            
            #add-point:AFTER FIELD pjbz011 name="input.a.page1.pjbz011"
            CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz011) RETURNING g_pjbz_d[l_ac].pjbz011_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz011_desc    
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_d[l_ac].pjbz011
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#8--add--end    
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN   #161019-00017#1
               IF cl_chk_exist("v_ooef001_14") THEN #161019-00017#1 
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz011 = g_pjbz_d_t.pjbz011
                  CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz011) RETURNING g_pjbz_d[l_ac].pjbz011_desc
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz011_desc  
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz011
            #add-point:BEFORE FIELD pjbz011 name="input.b.page1.pjbz011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz011
            #add-point:ON CHANGE pjbz011 name="input.g.page1.pjbz011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz012
            
            #add-point:AFTER FIELD pjbz012 name="input.a.page1.pjbz012"
            CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz012) RETURNING g_pjbz_d[l_ac].pjbz012_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz012_desc  
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz012) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_d[l_ac].pjbz012
               LET g_chkparam.arg2 = g_today
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#8--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz012 = g_pjbz_d_t.pjbz012
                  CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz012) RETURNING g_pjbz_d[l_ac].pjbz012_desc
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz012_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz012
            #add-point:BEFORE FIELD pjbz012 name="input.b.page1.pjbz012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz012
            #add-point:ON CHANGE pjbz012 name="input.g.page1.pjbz012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz013
            
            #add-point:AFTER FIELD pjbz013 name="input.a.page1.pjbz013"
            CALL s_desc_get_trading_partner_abbr_desc(g_pjbz_d[l_ac].pjbz013) RETURNING g_pjbz_d[l_ac].pjbz013_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz013_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz013) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_d[l_ac].pjbz013
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00029:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#8--add--end   
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_pmaa001_6") THEN  #160913-00055#3 
               IF cl_chk_exist("v_pmaa001_5") THEN   #160913-00055#3 
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz013 = g_pjbz_d_t.pjbz013
                  CALL s_desc_get_trading_partner_abbr_desc(g_pjbz_d[l_ac].pjbz013) RETURNING g_pjbz_d[l_ac].pjbz013_desc
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz013_desc
                  NEXT FIELD CURRENT
               END IF
          
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz013
            #add-point:BEFORE FIELD pjbz013 name="input.b.page1.pjbz013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz013
            #add-point:ON CHANGE pjbz013 name="input.g.page1.pjbz013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz014
            
            #add-point:AFTER FIELD pjbz014 name="input.a.page1.pjbz014"
            CALL s_desc_get_acc_desc('281',g_pjbz_d[l_ac].pjbz014) RETURNING g_pjbz_d[l_ac].pjbz014_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz014_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz014) THEN 
               IF NOT s_azzi650_chk_exist('281',g_pjbz_d[l_ac].pjbz014) THEN
                  LET g_pjbz_d[l_ac].pjbz014 = g_pjbz_d_t.pjbz014
                  CALL s_desc_get_acc_desc('281',g_pjbz_d[l_ac].pjbz014) RETURNING g_pjbz_d[l_ac].pjbz014_desc  
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz014_desc
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz014
            #add-point:BEFORE FIELD pjbz014 name="input.b.page1.pjbz014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz014
            #add-point:ON CHANGE pjbz014 name="input.g.page1.pjbz014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz015
            
            #add-point:AFTER FIELD pjbz015 name="input.a.page1.pjbz015"
            CALL s_desc_get_acc_desc('287',g_pjbz_d[l_ac].pjbz015) RETURNING g_pjbz_d[l_ac].pjbz015_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz015_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz015) THEN 
               IF NOT s_azzi650_chk_exist('287',g_pjbz_d[l_ac].pjbz015) THEN
                  LET g_pjbz_d[l_ac].pjbz015 = g_pjbz_d_t.pjbz015
                  CALL s_desc_get_acc_desc('287',g_pjbz_d[l_ac].pjbz015) RETURNING g_pjbz_d[l_ac].pjbz015_desc  
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz015_desc
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
                 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz015
            #add-point:BEFORE FIELD pjbz015 name="input.b.page1.pjbz015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz015
            #add-point:ON CHANGE pjbz015 name="input.g.page1.pjbz015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz016
            
            #add-point:AFTER FIELD pjbz016 name="input.a.page1.pjbz016"
            CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz016) RETURNING g_pjbz_d[l_ac].pjbz016_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz016_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz016) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_d[l_ac].pjbz016
               LET g_chkparam.arg2 = g_today
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#8--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_4") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz016 = g_pjbz_d_t.pjbz016
                  CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz016) RETURNING g_pjbz_d[l_ac].pjbz016_desc
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz016_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz016
            #add-point:BEFORE FIELD pjbz016 name="input.b.page1.pjbz016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz016
            #add-point:ON CHANGE pjbz016 name="input.g.page1.pjbz016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz017
            #add-point:BEFORE FIELD pjbz017 name="input.b.page1.pjbz017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz017
            
            #add-point:AFTER FIELD pjbz017 name="input.a.page1.pjbz017"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz017
            #add-point:ON CHANGE pjbz017 name="input.g.page1.pjbz017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz018
            
            #add-point:AFTER FIELD pjbz018 name="input.a.page1.pjbz018"
            CALL s_desc_get_acc_desc('2035',g_pjbz_d[l_ac].pjbz018) RETURNING g_pjbz_d[l_ac].pjbz018_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz018_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz018) THEN 
               IF NOT s_azzi650_chk_exist('2035',g_pjbz_d[l_ac].pjbz018) THEN
                  LET g_pjbz_d[l_ac].pjbz018 = g_pjbz_d_t.pjbz018
                  CALL s_desc_get_acc_desc('2035',g_pjbz_d[l_ac].pjbz018) RETURNING g_pjbz_d[l_ac].pjbz018_desc  
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz018_desc
                  NEXT FIELD CURRENT
               END IF
            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz018
            #add-point:BEFORE FIELD pjbz018 name="input.b.page1.pjbz018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz018
            #add-point:ON CHANGE pjbz018 name="input.g.page1.pjbz018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz019
            
            #add-point:AFTER FIELD pjbz019 name="input.a.page1.pjbz019"
            CALL s_desc_get_rtaxl003_desc(g_pjbz_d[l_ac].pjbz019) RETURNING g_pjbz_d[l_ac].pjbz019_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz019_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz019) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_d[l_ac].pjbz019
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#8--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz019 = g_pjbz_d_t.pjbz019
                  CALL s_desc_get_rtaxl003_desc(g_pjbz_d[l_ac].pjbz019) RETURNING g_pjbz_d[l_ac].pjbz019_desc
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz019_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz019
            #add-point:BEFORE FIELD pjbz019 name="input.b.page1.pjbz019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz019
            #add-point:ON CHANGE pjbz019 name="input.g.page1.pjbz019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz020
            
            #add-point:AFTER FIELD pjbz020 name="input.a.page1.pjbz020"
            CALL s_desc_get_acc_desc('2002',g_pjbz_d[l_ac].pjbz020) RETURNING g_pjbz_d[l_ac].pjbz020_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz020_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz020) THEN 
               IF NOT s_azzi650_chk_exist('2002',g_pjbz_d[l_ac].pjbz020) THEN
                  LET g_pjbz_d[l_ac].pjbz020 = g_pjbz_d_t.pjbz020
                  CALL s_desc_get_acc_desc('2002',g_pjbz_d[l_ac].pjbz020) RETURNING g_pjbz_d[l_ac].pjbz020_desc  
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz020_desc
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz020
            #add-point:BEFORE FIELD pjbz020 name="input.b.page1.pjbz020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz020
            #add-point:ON CHANGE pjbz020 name="input.g.page1.pjbz020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz021
            
            #add-point:AFTER FIELD pjbz021 name="input.a.page1.pjbz021"
            CALL s_desc_get_project_desc(g_pjbz_d[l_ac].pjbz021) RETURNING g_pjbz_d[l_ac].pjbz021_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz021_desc  
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz021) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_d[l_ac].pjbz021
               LET g_chkparam.arg2 = g_bdate
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001_4") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz021 = g_pjbz_d_t.pjbz021
                  CALL s_desc_get_project_desc(g_pjbz_d[l_ac].pjbz021) RETURNING g_pjbz_d[l_ac].pjbz021_desc
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz021_desc 
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz021
            #add-point:BEFORE FIELD pjbz021 name="input.b.page1.pjbz021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz021
            #add-point:ON CHANGE pjbz021 name="input.g.page1.pjbz021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz022
            
            #add-point:AFTER FIELD pjbz022 name="input.a.page1.pjbz022"
            CALL s_desc_get_wbs_desc(g_pjbz_d[l_ac].pjbz021,g_pjbz_d[l_ac].pjbz022) RETURNING g_pjbz_d[l_ac].pjbz022_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz022_desc
            
            IF NOT cl_null(g_pjbz_d[l_ac].pjbz022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_d[l_ac].pjbz021
               LET g_chkparam.arg2 = g_pjbz_d[l_ac].pjbz022
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_d[l_ac].pjbz022 = g_pjbz_d_t.pjbz022
                  CALL s_desc_get_wbs_desc(g_pjbz_d[l_ac].pjbz021,g_pjbz_d[l_ac].pjbz022) RETURNING g_pjbz_d[l_ac].pjbz022_desc
                  DISPLAY BY NAME g_pjbz_d[l_ac].pjbz022_desc
                  NEXT FIELD CURRENT
               END IF
           
            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz022
            #add-point:BEFORE FIELD pjbz022 name="input.b.page1.pjbz022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz022
            #add-point:ON CHANGE pjbz022 name="input.g.page1.pjbz022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz100
            #add-point:BEFORE FIELD pjbz100 name="input.b.page1.pjbz100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz100
            
            #add-point:AFTER FIELD pjbz100 name="input.a.page1.pjbz100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz100
            #add-point:ON CHANGE pjbz100 name="input.g.page1.pjbz100"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pjbzseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzseq
            #add-point:ON ACTION controlp INFIELD pjbzseq name="input.c.page1.pjbzseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz010
            #add-point:ON ACTION controlp INFIELD pjbz010 name="input.c.page1.pjbz010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz010             #給予default值
            SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbz_m.pjbzld
   
            LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 <> '1'"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz010 = g_qryparam.return1              
            
            DISPLAY g_pjbz_d[l_ac].pjbz010 TO pjbz010              #
            
            CALL apjt301_pjbz010_ref()

            NEXT FIELD pjbz010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz011
            #add-point:ON ACTION controlp INFIELD pjbz011 name="input.c.page1.pjbz011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz011             #給予default值
            LET g_qryparam.default2 = "" #g_pjbz_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooef001()     #161019-00017#1
            CALL q_ooef001_13()   #161019-00017#1
            LET g_pjbz_d[l_ac].pjbz011 = g_qryparam.return1              
            #LET g_pjbz_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_pjbz_d[l_ac].pjbz011 TO pjbz011              #
            #DISPLAY g_pjbz_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz011) RETURNING g_pjbz_d[l_ac].pjbz011_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz011_desc
            NEXT FIELD pjbz011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz012
            #add-point:ON ACTION controlp INFIELD pjbz012 name="input.c.page1.pjbz012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz012 = g_qryparam.return1              

            DISPLAY g_pjbz_d[l_ac].pjbz012 TO pjbz012              #
            CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz012) RETURNING g_pjbz_d[l_ac].pjbz012_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz012_desc

            NEXT FIELD pjbz012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz013
            #add-point:ON ACTION controlp INFIELD pjbz013 name="input.c.page1.pjbz013"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_pmaa001()                                #呼叫開窗  #160913-00055#3 
            CALL q_pmaa001_13()        #160913-00055#3

            LET g_pjbz_d[l_ac].pjbz013 = g_qryparam.return1              

            DISPLAY g_pjbz_d[l_ac].pjbz013 TO pjbz013              #
            
            CALL s_desc_get_trading_partner_abbr_desc(g_pjbz_d[l_ac].pjbz013) RETURNING g_pjbz_d[l_ac].pjbz013_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz013_desc

            NEXT FIELD pjbz013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz014
            #add-point:ON ACTION controlp INFIELD pjbz014 name="input.c.page1.pjbz014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz014             #給予default值
            LET g_qryparam.default2 = "" #g_pjbz_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '281'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz014 = g_qryparam.return1              
            #LET g_pjbz_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_pjbz_d[l_ac].pjbz014 TO pjbz014              #
            #DISPLAY g_pjbz_d[l_ac].oocq002 TO oocq002 #應用分類碼
            
            CALL s_desc_get_acc_desc('281',g_pjbz_d[l_ac].pjbz014) RETURNING g_pjbz_d[l_ac].pjbz014_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz014_desc

            NEXT FIELD pjbz014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz015
            #add-point:ON ACTION controlp INFIELD pjbz015 name="input.c.page1.pjbz015"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz015             #給予default值
            LET g_qryparam.default2 = "" #g_pjbz_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '287'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz015 = g_qryparam.return1              
            #LET g_pjbz_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_pjbz_d[l_ac].pjbz015 TO pjbz015              #
            #DISPLAY g_pjbz_d[l_ac].oocq002 TO oocq002 #應用分類碼
            
            CALL s_desc_get_acc_desc('287',g_pjbz_d[l_ac].pjbz015) RETURNING g_pjbz_d[l_ac].pjbz015_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz015_desc
            
            NEXT FIELD pjbz015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz016
            #add-point:ON ACTION controlp INFIELD pjbz016 name="input.c.page1.pjbz016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz016             #給予default值
            LET g_qryparam.where = " ooeg003 = '3'"
            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz016 = g_qryparam.return1              

            DISPLAY g_pjbz_d[l_ac].pjbz016 TO pjbz016              #
            
            CALL s_desc_get_department_desc(g_pjbz_d[l_ac].pjbz016) RETURNING g_pjbz_d[l_ac].pjbz016_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz016_desc

            NEXT FIELD pjbz016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz017
            #add-point:ON ACTION controlp INFIELD pjbz017 name="input.c.page1.pjbz017"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz018
            #add-point:ON ACTION controlp INFIELD pjbz018 name="input.c.page1.pjbz018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz018             #給予default值
            LET g_qryparam.default2 = "" #g_pjbz_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '2035'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz018 = g_qryparam.return1              
            #LET g_pjbz_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_pjbz_d[l_ac].pjbz018 TO pjbz018              #
            #DISPLAY g_pjbz_d[l_ac].oocq002 TO oocq002 #應用分類碼
            
            CALL s_desc_get_acc_desc('2035',g_pjbz_d[l_ac].pjbz018) RETURNING g_pjbz_d[l_ac].pjbz018_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz018_desc
            
            NEXT FIELD pjbz018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz019
            #add-point:ON ACTION controlp INFIELD pjbz019 name="input.c.page1.pjbz019"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_rtax001_1()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz019 = g_qryparam.return1              

            DISPLAY g_pjbz_d[l_ac].pjbz019 TO pjbz019              #
            CALL s_desc_get_rtaxl003_desc(g_pjbz_d[l_ac].pjbz019) RETURNING g_pjbz_d[l_ac].pjbz019_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz019_desc

            NEXT FIELD pjbz019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz020
            #add-point:ON ACTION controlp INFIELD pjbz020 name="input.c.page1.pjbz020"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz020             #給予default值
            LET g_qryparam.default2 = "" #g_pjbz_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '2002'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz020 = g_qryparam.return1              
            #LET g_pjbz_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_pjbz_d[l_ac].pjbz020 TO pjbz020              #
            #DISPLAY g_pjbz_d[l_ac].oocq002 TO oocq002 #應用分類碼
            
            CALL s_desc_get_acc_desc('2002',g_pjbz_d[l_ac].pjbz020) RETURNING g_pjbz_d[l_ac].pjbz020_desc  
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz020_desc
            
            NEXT FIELD pjbz020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz021
            #add-point:ON ACTION controlp INFIELD pjbz021 name="input.c.page1.pjbz021"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " (pjba013 IS NULL OR pjba013 >= to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')) "

            CALL q_pjba001_4()
            #CALL q_pjba001()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz021 = g_qryparam.return1              

            DISPLAY g_pjbz_d[l_ac].pjbz021 TO pjbz021              #
            
            CALL s_desc_get_project_desc(g_pjbz_d[l_ac].pjbz021) RETURNING g_pjbz_d[l_ac].pjbz021_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz021_desc 

            NEXT FIELD pjbz021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz022
            #add-point:ON ACTION controlp INFIELD pjbz022 name="input.c.page1.pjbz022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_d[l_ac].pjbz022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjbz_d[l_ac].pjbz021

            
            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_pjbz_d[l_ac].pjbz022 = g_qryparam.return1              

            DISPLAY g_pjbz_d[l_ac].pjbz022 TO pjbz022              #
            
            CALL s_desc_get_wbs_desc(g_pjbz_d[l_ac].pjbz021,g_pjbz_d[l_ac].pjbz022) RETURNING g_pjbz_d[l_ac].pjbz022_desc
            DISPLAY BY NAME g_pjbz_d[l_ac].pjbz022_desc

            NEXT FIELD pjbz022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pjbz100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz100
            #add-point:ON ACTION controlp INFIELD pjbz100 name="input.c.page1.pjbz100"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pjbz_d[l_ac].* = g_pjbz_d_t.*
               CLOSE apjt301_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pjbz_d[l_ac].pjbzseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pjbz_d[l_ac].* = g_pjbz_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_pjbz2_d[l_ac].pjbzmodid = g_user 
LET g_pjbz2_d[l_ac].pjbzmoddt = cl_get_current()
LET g_pjbz2_d[l_ac].pjbzmodid_desc = cl_get_username(g_pjbz2_d[l_ac].pjbzmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL apjt301_pjbz_t_mask_restore('restore_mask_o')
         
               UPDATE pjbz_t SET (pjbzld,pjbz001,pjbz002,pjbz003,pjbz004,pjbzseq,pjbz010,pjbz011,pjbz012, 
                   pjbz013,pjbz014,pjbz015,pjbz016,pjbz017,pjbz018,pjbz019,pjbz020,pjbz021,pjbz022,pjbz100, 
                   pjbzownid,pjbzowndp,pjbzcrtid,pjbzcrtdp,pjbzcrtdt,pjbzmodid,pjbzmoddt) = (g_pjbz_m.pjbzld, 
                   g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004,g_pjbz_d[l_ac].pjbzseq, 
                   g_pjbz_d[l_ac].pjbz010,g_pjbz_d[l_ac].pjbz011,g_pjbz_d[l_ac].pjbz012,g_pjbz_d[l_ac].pjbz013, 
                   g_pjbz_d[l_ac].pjbz014,g_pjbz_d[l_ac].pjbz015,g_pjbz_d[l_ac].pjbz016,g_pjbz_d[l_ac].pjbz017, 
                   g_pjbz_d[l_ac].pjbz018,g_pjbz_d[l_ac].pjbz019,g_pjbz_d[l_ac].pjbz020,g_pjbz_d[l_ac].pjbz021, 
                   g_pjbz_d[l_ac].pjbz022,g_pjbz_d[l_ac].pjbz100,g_pjbz2_d[l_ac].pjbzownid,g_pjbz2_d[l_ac].pjbzowndp, 
                   g_pjbz2_d[l_ac].pjbzcrtid,g_pjbz2_d[l_ac].pjbzcrtdp,g_pjbz2_d[l_ac].pjbzcrtdt,g_pjbz2_d[l_ac].pjbzmodid, 
                   g_pjbz2_d[l_ac].pjbzmoddt)
                WHERE pjbzent = g_enterprise AND pjbzld = g_pjbz_m.pjbzld 
                 AND pjbz001 = g_pjbz_m.pjbz001 
                 AND pjbz002 = g_pjbz_m.pjbz002 
                 AND pjbz003 = g_pjbz_m.pjbz003 
                 AND pjbz004 = g_pjbz_m.pjbz004 
 
                 AND pjbzseq = g_pjbz_d_t.pjbzseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pjbz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "pjbz_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pjbz_m.pjbzld
               LET gs_keys_bak[1] = g_pjbzld_t
               LET gs_keys[2] = g_pjbz_m.pjbz001
               LET gs_keys_bak[2] = g_pjbz001_t
               LET gs_keys[3] = g_pjbz_m.pjbz002
               LET gs_keys_bak[3] = g_pjbz002_t
               LET gs_keys[4] = g_pjbz_m.pjbz003
               LET gs_keys_bak[4] = g_pjbz003_t
               LET gs_keys[5] = g_pjbz_m.pjbz004
               LET gs_keys_bak[5] = g_pjbz004_t
               LET gs_keys[6] = g_pjbz_d[g_detail_idx].pjbzseq
               LET gs_keys_bak[6] = g_pjbz_d_t.pjbzseq
               CALL apjt301_update_b('pjbz_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_pjbz_m),util.JSON.stringify(g_pjbz_d_t)
                     LET g_log2 = util.JSON.stringify(g_pjbz_m),util.JSON.stringify(g_pjbz_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apjt301_pjbz_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_pjbz_m.pjbzld
               LET ls_keys[ls_keys.getLength()+1] = g_pjbz_m.pjbz001
               LET ls_keys[ls_keys.getLength()+1] = g_pjbz_m.pjbz002
               LET ls_keys[ls_keys.getLength()+1] = g_pjbz_m.pjbz003
               LET ls_keys[ls_keys.getLength()+1] = g_pjbz_m.pjbz004
 
               LET ls_keys[ls_keys.getLength()+1] = g_pjbz_d_t.pjbzseq
 
               CALL apjt301_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE apjt301_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjbz_d[l_ac].* = g_pjbz_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE apjt301_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_pjbz_d.getLength() = 0 THEN
               NEXT FIELD pjbzseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pjbz_d[li_reproduce_target].* = g_pjbz_d[li_reproduce].*
               LET g_pjbz2_d[li_reproduce_target].* = g_pjbz2_d[li_reproduce].*
 
               LET g_pjbz_d[li_reproduce_target].pjbzseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pjbz_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pjbz_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_pjbz2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL apjt301_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL apjt301_idx_chk()
            CALL apjt301_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD pjbzcomp
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pjbzseq
               WHEN "s_detail2"
                  NEXT FIELD pjbzseq_2
 
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD pjbzld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pjbzseq
               WHEN "s_detail2"
                  NEXT FIELD pjbzseq_2
 
            END CASE
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apjt301_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
  
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL apjt301_b_fill(g_wc2) #第一階單身填充
      CALL apjt301_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apjt301_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz002, 
       g_pjbz_m.pjbz003,g_pjbz_m.pjbz004,g_pjbz_m.pjbz004_desc,g_pjbz_m.pjbz001
 
   CALL apjt301_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION apjt301_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbz_m.pjbzld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_glaa004 = '', g_rtn_fields[1] , ''
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pjbz_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pjbz2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaa004
      LET g_ref_fields[2] = g_pjbz_d[l_ac].pjbz010
      CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pjbz_d[l_ac].pjbz010_desc = '', g_rtn_fields[1] , ''
      DISPLAY g_pjbz_d[l_ac].pjbz010_desc TO s_detail1[l_ac].pjbz010_desc



      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apjt301_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE pjbz_t.pjbzld 
   DEFINE l_oldno     LIKE pjbz_t.pjbzld 
   DEFINE l_newno02     LIKE pjbz_t.pjbz001 
   DEFINE l_oldno02     LIKE pjbz_t.pjbz001 
   DEFINE l_newno03     LIKE pjbz_t.pjbz002 
   DEFINE l_oldno03     LIKE pjbz_t.pjbz002 
   DEFINE l_newno04     LIKE pjbz_t.pjbz003 
   DEFINE l_oldno04     LIKE pjbz_t.pjbz003 
   DEFINE l_newno05     LIKE pjbz_t.pjbz004 
   DEFINE l_oldno05     LIKE pjbz_t.pjbz004 
 
   DEFINE l_master    RECORD LIKE pjbz_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pjbz_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_pjbz_m.pjbzld IS NULL
      OR g_pjbz_m.pjbz001 IS NULL
      OR g_pjbz_m.pjbz002 IS NULL
      OR g_pjbz_m.pjbz003 IS NULL
      OR g_pjbz_m.pjbz004 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_pjbzld_t = g_pjbz_m.pjbzld
   LET g_pjbz001_t = g_pjbz_m.pjbz001
   LET g_pjbz002_t = g_pjbz_m.pjbz002
   LET g_pjbz003_t = g_pjbz_m.pjbz003
   LET g_pjbz004_t = g_pjbz_m.pjbz004
 
   
   LET g_pjbz_m.pjbzld = ""
   LET g_pjbz_m.pjbz001 = ""
   LET g_pjbz_m.pjbz002 = ""
   LET g_pjbz_m.pjbz003 = ""
   LET g_pjbz_m.pjbz004 = ""
 
   LET g_master_insert = FALSE
   CALL apjt301_set_entry('a')
   CALL apjt301_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_pjbz_m.pjbzld_desc = ''
   DISPLAY BY NAME g_pjbz_m.pjbzld_desc
   LET g_pjbz_m.pjbz004_desc = ''
   DISPLAY BY NAME g_pjbz_m.pjbz004_desc
 
   
   CALL apjt301_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_pjbz_m.* TO NULL
      INITIALIZE g_pjbz_d TO NULL
      INITIALIZE g_pjbz2_d TO NULL
 
      CALL apjt301_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL apjt301_set_act_visible()
   CALL apjt301_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_pjbzld_t = g_pjbz_m.pjbzld
   LET g_pjbz001_t = g_pjbz_m.pjbz001
   LET g_pjbz002_t = g_pjbz_m.pjbz002
   LET g_pjbz003_t = g_pjbz_m.pjbz003
   LET g_pjbz004_t = g_pjbz_m.pjbz004
 
   
   #組合新增資料的條件
   LET g_add_browse = " pjbzent = " ||g_enterprise|| " AND",
                      " pjbzld = '", g_pjbz_m.pjbzld, "' "
                      ," AND pjbz001 = '", g_pjbz_m.pjbz001, "' "
                      ," AND pjbz002 = '", g_pjbz_m.pjbz002, "' "
                      ," AND pjbz003 = '", g_pjbz_m.pjbz003, "' "
                      ," AND pjbz004 = '", g_pjbz_m.pjbz004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apjt301_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL apjt301_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL apjt301_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apjt301_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pjbz_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apjt301_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pjbz_t
    WHERE pjbzent = g_enterprise AND pjbzld = g_pjbzld_t
    AND pjbz001 = g_pjbz001_t
    AND pjbz002 = g_pjbz002_t
    AND pjbz003 = g_pjbz003_t
    AND pjbz004 = g_pjbz004_t
 
       INTO TEMP apjt301_detail
   
   #將key修正為調整後   
   UPDATE apjt301_detail 
      #更新key欄位
      SET pjbzld = g_pjbz_m.pjbzld
          , pjbz001 = g_pjbz_m.pjbz001
          , pjbz002 = g_pjbz_m.pjbz002
          , pjbz003 = g_pjbz_m.pjbz003
          , pjbz004 = g_pjbz_m.pjbz004
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , pjbzownid = g_user 
       , pjbzowndp = g_dept
       , pjbzcrtid = g_user
       , pjbzcrtdp = g_dept 
       , pjbzcrtdt = ld_date
       , pjbzmodid = g_user
       , pjbzmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO pjbz_t SELECT * FROM apjt301_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apjt301_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pjbzld_t = g_pjbz_m.pjbzld
   LET g_pjbz001_t = g_pjbz_m.pjbz001
   LET g_pjbz002_t = g_pjbz_m.pjbz002
   LET g_pjbz003_t = g_pjbz_m.pjbz003
   LET g_pjbz004_t = g_pjbz_m.pjbz004
 
   
   DROP TABLE apjt301_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apjt301_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_pjbz_m.pjbzld IS NULL
   OR g_pjbz_m.pjbz001 IS NULL
   OR g_pjbz_m.pjbz002 IS NULL
   OR g_pjbz_m.pjbz003 IS NULL
   OR g_pjbz_m.pjbz004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN apjt301_cl USING g_enterprise,g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apjt301_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE apjt301_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apjt301_master_referesh USING g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003, 
       g_pjbz_m.pjbz004 INTO g_pjbz_m.pjbzcomp,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004, 
       g_pjbz_m.pjbz001,g_pjbz_m.pjbzcomp_desc,g_pjbz_m.pjbzld_desc,g_pjbz_m.pjbz004_desc
   
   #遮罩相關處理
   LET g_pjbz_m_mask_o.* =  g_pjbz_m.*
   CALL apjt301_pjbz_t_mask()
   LET g_pjbz_m_mask_n.* =  g_pjbz_m.*
   
   CALL apjt301_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apjt301_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM pjbz_t WHERE pjbzent = g_enterprise AND pjbzld = g_pjbz_m.pjbzld
                                                               AND pjbz001 = g_pjbz_m.pjbz001
                                                               AND pjbz002 = g_pjbz_m.pjbz002
                                                               AND pjbz003 = g_pjbz_m.pjbz003
                                                               AND pjbz004 = g_pjbz_m.pjbz004
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pjbz_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE apjt301_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_pjbz_d.clear() 
      CALL g_pjbz2_d.clear()       
 
     
      CALL apjt301_ui_browser_refresh()  
      #CALL apjt301_ui_headershow()  
      #CALL apjt301_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apjt301_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL apjt301_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE apjt301_cl
 
   #功能已完成,通報訊息中心
   CALL apjt301_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apjt301.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apjt301_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_pjbz_d.clear()
   CALL g_pjbz2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT pjbzseq,pjbz010,pjbz011,pjbz012,pjbz013,pjbz014,pjbz015,pjbz016,pjbz017, 
       pjbz018,pjbz019,pjbz020,pjbz021,pjbz022,pjbz100,pjbzseq,pjbzownid,pjbzowndp,pjbzcrtid,pjbzcrtdp, 
       pjbzcrtdt,pjbzmodid,pjbzmoddt,t1.ooefl003 ,t2.ooefl003 ,t3.pmaal004 ,t4.oocql004 ,t5.oocql004 , 
       t6.ooefl003 ,t7.oocql004 ,t8.rtaxl003 ,t9.oocql004 ,t10.pjbal003 ,t11.pjbbl004 ,t12.ooag011 , 
       t13.ooefl003 ,t14.ooag011 ,t15.ooefl003 ,t16.ooag011 FROM pjbz_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pjbz011 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=pjbz012 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=pjbz013 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='281' AND t4.oocql002=pjbz014 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='287' AND t5.oocql002=pjbz015 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=pjbz016 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2035' AND t7.oocql002=pjbz018 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t8 ON t8.rtaxlent="||g_enterprise||" AND t8.rtaxl001=pjbz019 AND t8.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='2002' AND t9.oocql002=pjbz020 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t10 ON t10.pjbalent="||g_enterprise||" AND t10.pjbal001=pjbz021 AND t10.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t11 ON t11.pjbblent="||g_enterprise||" AND t11.pjbbl001=pjbz021 AND t11.pjbbl002=pjbz022 AND t11.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=pjbzownid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=pjbzowndp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=pjbzcrtid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=pjbzcrtdp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=pjbzmodid  ",
 
               " WHERE pjbzent= ? AND pjbzld=? AND pjbz001=? AND pjbz002=? AND pjbz003=? AND pjbz004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("pjbz_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF apjt301_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY pjbz_t.pjbzseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apjt301_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apjt301_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pjbz_m.pjbzld,g_pjbz_m.pjbz001,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003, 
          g_pjbz_m.pjbz004 INTO g_pjbz_d[l_ac].pjbzseq,g_pjbz_d[l_ac].pjbz010,g_pjbz_d[l_ac].pjbz011, 
          g_pjbz_d[l_ac].pjbz012,g_pjbz_d[l_ac].pjbz013,g_pjbz_d[l_ac].pjbz014,g_pjbz_d[l_ac].pjbz015, 
          g_pjbz_d[l_ac].pjbz016,g_pjbz_d[l_ac].pjbz017,g_pjbz_d[l_ac].pjbz018,g_pjbz_d[l_ac].pjbz019, 
          g_pjbz_d[l_ac].pjbz020,g_pjbz_d[l_ac].pjbz021,g_pjbz_d[l_ac].pjbz022,g_pjbz_d[l_ac].pjbz100, 
          g_pjbz2_d[l_ac].pjbzseq,g_pjbz2_d[l_ac].pjbzownid,g_pjbz2_d[l_ac].pjbzowndp,g_pjbz2_d[l_ac].pjbzcrtid, 
          g_pjbz2_d[l_ac].pjbzcrtdp,g_pjbz2_d[l_ac].pjbzcrtdt,g_pjbz2_d[l_ac].pjbzmodid,g_pjbz2_d[l_ac].pjbzmoddt, 
          g_pjbz_d[l_ac].pjbz011_desc,g_pjbz_d[l_ac].pjbz012_desc,g_pjbz_d[l_ac].pjbz013_desc,g_pjbz_d[l_ac].pjbz014_desc, 
          g_pjbz_d[l_ac].pjbz015_desc,g_pjbz_d[l_ac].pjbz016_desc,g_pjbz_d[l_ac].pjbz018_desc,g_pjbz_d[l_ac].pjbz019_desc, 
          g_pjbz_d[l_ac].pjbz020_desc,g_pjbz_d[l_ac].pjbz021_desc,g_pjbz_d[l_ac].pjbz022_desc,g_pjbz2_d[l_ac].pjbzownid_desc, 
          g_pjbz2_d[l_ac].pjbzowndp_desc,g_pjbz2_d[l_ac].pjbzcrtid_desc,g_pjbz2_d[l_ac].pjbzcrtdp_desc, 
          g_pjbz2_d[l_ac].pjbzmodid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL apjt301_pjbz010_ref()
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF 
            EXIT FOREACH
         END IF
      
         LET l_ac = l_ac + 1
         
      END FOREACH
 
            CALL g_pjbz_d.deleteElement(g_pjbz_d.getLength())
      CALL g_pjbz2_d.deleteElement(g_pjbz2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_pjbz_d.getLength()
      LET g_pjbz_d_mask_o[l_ac].* =  g_pjbz_d[l_ac].*
      CALL apjt301_pjbz_t_mask()
      LET g_pjbz_d_mask_n[l_ac].* =  g_pjbz_d[l_ac].*
   END FOR
   
   LET g_pjbz2_d_mask_o.* =  g_pjbz2_d.*
   FOR l_ac = 1 TO g_pjbz2_d.getLength()
      LET g_pjbz2_d_mask_o[l_ac].* =  g_pjbz2_d[l_ac].*
      CALL apjt301_pjbz_t_mask()
      LET g_pjbz2_d_mask_n[l_ac].* =  g_pjbz2_d[l_ac].*
   END FOR
 
 
   FREE apjt301_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apjt301_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_pjbz_d.getLength() THEN
         LET g_detail_idx = g_pjbz_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_pjbz_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjbz_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_pjbz2_d.getLength() THEN
         LET g_detail_idx = g_pjbz2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbz2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pjbz2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apjt301_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_pjbz_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION apjt301_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM pjbz_t
    WHERE pjbzent = g_enterprise AND pjbzld = g_pjbz_m.pjbzld AND
                              pjbz001 = g_pjbz_m.pjbz001 AND
                              pjbz002 = g_pjbz_m.pjbz002 AND
                              pjbz003 = g_pjbz_m.pjbz003 AND
                              pjbz004 = g_pjbz_m.pjbz004 AND
 
          pjbzseq = g_pjbz_d_t.pjbzseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "pjbz_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="apjt301.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apjt301_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apjt301_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apjt301_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
   #end add-point 
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION apjt301_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_pjbz_d[l_ac].pjbzseq = g_pjbz_d_t.pjbzseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apjt301_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apjt301_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL apjt301_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apjt301_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apjt301_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pjbzld,pjbz001,pjbz002,pjbz003,pjbz004",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apjt301_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pjbzld,pjbz001,pjbz002,pjbz003,pjbz004",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apjt301_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
    
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apjt301_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apjt301_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apjt301_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apjt301_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjt301.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apjt301_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjt301.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apjt301_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " pjbzld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pjbz001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " pjbz002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " pjbz003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " pjbz004 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apjt301_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apjt301.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION apjt301_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "pjbzseq"
      WHEN "s_detail2"
         LET ls_return = "pjbzseq_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301.mask_functions" >}
&include "erp/apj/apjt301_mask.4gl"
 
{</section>}
 
{<section id="apjt301.state_change" >}
    
 
{</section>}
 
{<section id="apjt301.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apjt301_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_pjbz_m.pjbzld
   LET g_pk_array[1].column = 'pjbzld'
   LET g_pk_array[2].values = g_pjbz_m.pjbz001
   LET g_pk_array[2].column = 'pjbz001'
   LET g_pk_array[3].values = g_pjbz_m.pjbz002
   LET g_pk_array[3].column = 'pjbz002'
   LET g_pk_array[4].values = g_pjbz_m.pjbz003
   LET g_pk_array[4].column = 'pjbz003'
   LET g_pk_array[5].values = g_pjbz_m.pjbz004
   LET g_pk_array[5].column = 'pjbz004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apjt301.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apjt301_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL apjt301_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pjbz_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apjt301.other_function" readonly="Y" >}
# 參考欄位帶值
PRIVATE FUNCTION apjt301_show_ref()
   CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
   DISPLAY BY NAME g_pjbz_m.pjbzld_desc

   CALL s_desc_get_department_desc(g_pjbz_m.pjbzcomp) RETURNING g_pjbz_m.pjbzcomp_desc
   DISPLAY BY NAME g_pjbz_m.pjbzcomp_desc

   CALL s_desc_get_project_desc(g_pjbz_m.pjbz004) RETURNING g_pjbz_m.pjbz004_desc
   DISPLAY BY NAME g_pjbz_m.pjbz004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbz_m.pjbzld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_glaa004 = '', g_rtn_fields[1] , ''
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjt301_chk_year_period (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 141231 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION apjt301_chk_year_period()
DEFINE r_success        LIKE type_t.num5
   DEFINE l_bdate          LIKE type_t.dat    #起始年度+期別對應的起始截止日期
   DEFINE l_edate          LIKE type_t.dat
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_date  DATE
   DEFINE l_cnt            LIKE type_t.num5
   LET r_success = TRUE 
   #抓出会计周期参考表号  glaa003
   SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_pjbz_m.pjbzcomp
         AND glaa014  = 'Y'   
   IF g_pjbz_m.pjbz002 IS NOT NULL  THEN
      IF NOT s_fin_date_chk_year(g_pjbz_m.pjbz002) THEN  
         LET r_success = FALSE
         RETURN r_success      
      END IF
      SELECT COUNT(*) INTO l_cnt FROM glav_t
      WHERE glavent = g_enterprise
        AND glav001 = l_glaa003
        AND glav002 = g_pjbz_m.pjbz002
        AND glavstus = 'Y' 
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00581'
         LET g_errparam.extend = g_pjbz_m.pjbz002
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET r_success = FALSE
         RETURN r_success 
      END IF
   END IF
   

   IF g_pjbz_m.pjbz002 IS NOT NULL AND g_pjbz_m.pjbz003 IS NOT NULL THEN
      IF NOT s_fin_date_chk_period(l_glaa003,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003) THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
      CALL s_fin_date_get_period_range(l_glaa003,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003) RETURNING l_bdate,l_edate
      
      IF NOT s_date_chk_close(l_edate,'2') THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
   END IF
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION apjt301_pjbz010_ref()

   SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_pjbz_m.pjbzld
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = g_pjbz_d[l_ac].pjbz010
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbz_d[l_ac].pjbz010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbz_d[l_ac].pjbz010_desc
   
END FUNCTION

#獲取日期欄位資訊
PRIVATE FUNCTION apjt301_get_date()
   #取"會計週期參照表號"
   SELECT glaa003 INTO g_glaa003 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_pjbz_m.pjbzld

   #取当期的起始及截止日期
   CALL s_fin_date_get_period_range(g_glaa003,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003)
        RETURNING g_bdate,g_edate
END FUNCTION

 
{</section>}
 
