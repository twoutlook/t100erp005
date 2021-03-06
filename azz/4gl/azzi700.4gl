#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi700.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:5,PR版次:5) Build-000113
#+ 
#+ Filename...: azzi700
#+ Description: 整合服務基本資料維護作業
#+ Creator....: 01375(2014-04-09 16:24:29)
#+ Modifier...: 00544(2014-10-03 09:56:06) -SD/PR- 04182
 
{</section>}
 
{<section id="azzi700.global" >}
#應用 i01 樣板自動產生(Version:25)

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_gzja_m RECORD
       gzja001 LIKE gzja_t.gzja001, 
   gzjal003 LIKE gzjal_t.gzjal003,
   gzjal004 LIKE gzjal_t.gzjal004,   
   gzja002 LIKE gzja_t.gzja002, 
   gzja002_desc LIKE type_t.chr80, 
   gzja005 LIKE gzja_t.gzja005, 
   gzja006 LIKE gzja_t.gzja006, 
   gzja006_desc LIKE type_t.chr80, 
   gzja004 LIKE gzja_t.gzja004, 
   gzja003 LIKE gzja_t.gzja003,
   gzja007 LIKE gzja_t.gzja007, 
   gzja008 LIKE gzja_t.gzja008,
   gzja009 LIKE gzja_t.gzja009,   
   gzja011 LIKE gzja_t.gzja011,
   gzja012 LIKE gzja_t.gzja012,   
   gzjastus LIKE gzja_t.gzjastus, 
   gzjaownid LIKE gzja_t.gzjaownid, 
   gzjaownid_desc LIKE type_t.chr80, 
   gzjaowndp LIKE gzja_t.gzjaowndp, 
   gzjaowndp_desc LIKE type_t.chr80, 
   gzjacrtid LIKE gzja_t.gzjacrtid, 
   gzjacrtid_desc LIKE type_t.chr80, 
   gzjacrtdp LIKE gzja_t.gzjacrtdp, 
   gzjacrtdp_desc LIKE type_t.chr80, 
   gzjacrtdt LIKE gzja_t.gzjacrtdt, 
   gzjamodid LIKE gzja_t.gzjamodid, 
   gzjamodid_desc LIKE type_t.chr80, 
   gzjamoddt LIKE gzja_t.gzjamoddt
       END RECORD
       
 
#模組變數(Module Variables)
DEFINE g_gzja_m        type_g_gzja_m  #單頭變數宣告
DEFINE g_gzja_m_t      type_g_gzja_m  #單頭舊值宣告(系統還原用)
DEFINE g_gzja_m_o      type_g_gzja_m  #單頭舊值宣告(其他用途)
DEFINE g_gzja_m_mask_o type_g_gzja_m  #轉換遮罩前資料
DEFINE g_gzja_m_mask_n type_g_gzja_m  #轉換遮罩後資料
 
   DEFINE g_gzja001_t LIKE gzja_t.gzja001
 
#161013-00018
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_gzja001 LIKE gzja_t.gzja001,
   b_gzja001_desc LIKE type_t.chr80,
      b_gzja002 LIKE gzja_t.gzja002,
   b_gzja002_desc LIKE type_t.chr80,
   b_gzja004 LIKE gzja_t.gzja004,
   b_gzja007 LIKE gzja_t.gzja007,
   b_gzja008 LIKE gzja_t.gzja008,
   b_gzja009 LIKE gzja_t.gzja009,
   b_gzja011 LIKE gzja_t.gzja011,
   b_gzja012 LIKE gzja_t.gzja012   
      END RECORD 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      gzjal001 LIKE gzjal_t.gzjal001,
      gzjal003 LIKE gzjal_t.gzjal003,
      gzjal004 LIKE gzjal_t.gzjal004
      END RECORD
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義模組變數(Module Variable)
DEFINE ms_dgenv        LIKE type_t.chr1         #環境變數DGENV使用標示(s:標準/ c:客製)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="azzi700.main" >}
#應用 a26 樣板自動產生(Version:4)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define

   #end add-point   
   #add-point:main段define(客製用)

   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = " SELECT gzja001,'',gzja002,'',gzja005,gzja006,'',gzja004,gzja007,gzja008,gzja009,gzja011,gzja003,gzja012,gzjastus,gzjaownid, 
       '',gzjaowndp,'',gzjacrtid,'',gzjacrtdp,'',gzjacrtdt,gzjamodid,'',gzjamoddt", 
                      " FROM gzja_t",
                      " WHERE gzja001=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi700_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.gzja001,t0.gzja002,t0.gzja005,t0.gzja006,t0.gzja004,t0.gzja007,t0.gzja008,t0.gzja009,t0.gzja011,t0.gzja003,t0.gzja012,t0.gzjastus, 
       t0.gzjaownid,t0.gzjaowndp,t0.gzjacrtid,t0.gzjacrtdp,t0.gzjacrtdt,t0.gzjamodid,t0.gzjamoddt,t1.gzzol003 , 
       t2.gzoi002 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011",
               " FROM gzja_t t0",
                              " LEFT JOIN gzzol_t t1 ON t1.gzzol001=t0.gzja002 AND t1.gzzol002='"||g_lang||"' ",
               " LEFT JOIN gzoi_t t2 ON t2.gzoi001=t0.gzja006  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.gzjaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.gzjaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.gzjacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.gzjacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t0.gzjamodid  ",
 
               " WHERE  t0.gzja001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define

   #end add-point
   PREPARE azzi700_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi700 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi700_init()   
 
      #進入選單 Menu (="N")
      CALL azzi700_ui_dialog() 
      
      #add-point:畫面關閉前
 
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi700
      
   END IF 
   
   CLOSE azzi700_cl
   
   
 
   #add-point:作業離開前
 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="azzi700.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi700_init()
   #add-point:init段define
   CALL cl_set_combo_module("gzja002",1)
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED
   #end add-point
   #add-point:init段define(客製用)
   
   #end add-point
   #定義combobox狀態
      CALL cl_set_combo_scc_part('gzjastus','17','N,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('gzja007','225')
   CALL cl_set_combo_scc('gzja008','226')
   CALL cl_set_combo_scc('gzja009','234')
   CALL cl_set_combo_scc('b_gzja007','225')
   CALL cl_set_combo_scc('b_gzja008','226')
   CALL cl_set_combo_scc('gzja011','242')
   CALL cl_set_combo_scc('b_gzja009','234')
   CALL cl_set_combo_scc('b_gzja011','242')
   CALL cl_set_combo_scc('b_gzja012','251')  
   CALL cl_set_combo_scc('gzja012','251')   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL azzi700_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzi700_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_return  BOOLEAN
   #add-point:ui_dialog段define

   #end add-point
   #add-point:ui_dialog段define(客製用)

   #end add-point
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:2)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL azzi700_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
   END CASE
 
 
   
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gzja_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL azzi700_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL azzi700_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL azzi700_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu

               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL azzi700_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL azzi700_set_act_visible()
               CALL azzi700_set_act_no_visible()
               IF NOT (g_gzja_m.gzja001 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " ",
                                     " gzja001 = '", g_gzja_m.gzja001, "' "
 
                  #填到對應位置
                  CALL azzi700_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL azzi700_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL azzi700_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL azzi700_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL azzi700_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL azzi700_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               EXIT MENU
               
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
               EXIT MENU
            
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL azzi700_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi700_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi700_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi700_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi700_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi700_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi700_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi700_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL azzi700_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi700_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi700_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
         ON ACTION reregsrv
            CALL awsp200_01_eai_regSrv() RETURNING l_return
            INITIALIZE g_errparam TO NULL
            IF l_return = TRUE THEN
               
               LET g_errparam.code =  "adz-00217"
            ELSE
               LET g_errparam.code =  "adz-00218"
             
            END IF  
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()            
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL azzi700_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array

            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL azzi700_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL azzi700_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before

               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog

               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL azzi700_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL azzi700_set_act_visible()
               CALL azzi700_set_act_no_visible()
               IF NOT (g_gzja_m.gzja001 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " ",
                                     " gzja001 = '", g_gzja_m.gzja001, "' "
 
                  #填到對應位置
                  CALL azzi700_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:2)
            #過濾瀏覽頁資料
            ON ACTION filter
               #add-point:filter action

               #end add-point
               CALL azzi700_filter()
               EXIT DIALOG
 
 
            
            #第一筆資料
            ON ACTION first
               CALL azzi700_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL azzi700_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL azzi700_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL azzi700_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL azzi700_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               #EXIT DIALOG
               
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
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               END IF
         
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL azzi700_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi700_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi700_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi700_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi700_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi700_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi700_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi700_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL azzi700_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi700_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi700_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
         ON ACTION reregsrv
            CALL awsp200_01_eai_regSrv() RETURNING l_return 
            INITIALIZE g_errparam TO NULL
            IF l_return = TRUE THEN
               
               LET g_errparam.code =  "adz-00217"
            ELSE
               LET g_errparam.code =  "adz-00218"
             
            END IF  
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()              
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog

      #end add-point
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.browser_fill" >}
#應用 a29 樣板自動產生(Version:7)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION azzi700_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define

   #end add-point
   #add-point:browser_fill段define

   #end add-point
   
   LET l_searchcol = "gzja001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制

   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM gzja_t ",
               "  ",
               "  LEFT JOIN gzjal_t ON gzja001 = gzjal001 AND gzjal002 = '",g_dlang,"' ",
               " WHERE  ", 
               p_wc CLIPPED, cl_sql_add_filter("gzja_t")
                
   #add-point:browser_fill段cnt_sql

   #end add-point
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_gzja_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   #161013-00018
   LET g_sql = " SELECT t0.gzjastus,t0.gzja001,t0.gzja002,t1.gzjal003 ,t2.gzzol003, t0.gzja004, t0.gzja007, t0.gzja008, t0.gzja009, t0.gzja011, t0.gzja012",
               " FROM gzja_t t0 ",
               " LEFT JOIN gzjal_t t1 ON t1.gzjal001=t0.gzja001 AND t1.gzjal002='"||g_lang||"' ",
               " LEFT JOIN gzzol_t t2 ON t2.gzzol001=t0.gzja002 AND t2.gzzol002='"||g_lang||"' ",
               " WHERE  ", ls_wc, cl_sql_add_filter("gzja_t")
   #add-point:browser_fill段fill_wc

   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre

   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzja_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   #CALL g_browser.clear()
   #LET g_cnt = 1
   #161013-00018
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzja001,g_browser[g_cnt].b_gzja002, 
       g_browser[g_cnt].b_gzja001_desc,g_browser[g_cnt].b_gzja002_desc,g_browser[g_cnt].b_gzja004,g_browser[g_cnt].b_gzja007,g_browser[g_cnt].b_gzja008,g_browser[g_cnt].b_gzja009,g_browser[g_cnt].b_gzja011,g_browser[g_cnt].b_gzja012
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference

      #end add-point
      
      #遮罩相關處理
      CALL azzi700_browser_mask()
      
            #應用 a24 樣板自動產生(Version:2)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_gzja001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #CALL azzi700_fetch("") 
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前

   #end add-point   
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi700.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi700_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define
   
   #end add-point
   #add-point:cs段define(客製用)

   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_gzja_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON gzja001,gzjal003,gzja002,gzja005,gzja006,gzja004,gzja007,gzja008,gzja009,gzja011,gzja003,gzja012,gzjastus,gzjaownid, 
          gzjaowndp,gzjacrtid,gzjacrtdp,gzjacrtdt,gzjamodid,gzjamoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct

            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:2)
         #共用欄位查詢處理  
         ##----<<gzjacrtdt>>----
         AFTER FIELD gzjacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzjamoddt>>----
         AFTER FIELD gzjamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzjacnfdt>>----
         
         #----<<gzjapstdt>>----
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja001
            #add-point:BEFORE FIELD gzja001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja001
            
            #add-point:AFTER FIELD gzja001

            #END add-point
            
 
         #Ctrlp:construct.c.gzja001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja001
            #add-point:ON ACTION controlp INFIELD gzja001

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjal003
            #add-point:BEFORE FIELD gzjal003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjal003
            
            #add-point:AFTER FIELD gzjal003

            #END add-point
            
 
         #Ctrlp:construct.c.gzjal003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjal003
            #add-point:ON ACTION controlp INFIELD gzjal003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja002
            #add-point:BEFORE FIELD gzja002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja002
            
            #add-point:AFTER FIELD gzja002

            #END add-point
            
 
         #Ctrlp:construct.c.gzja002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja002
            #add-point:ON ACTION controlp INFIELD gzja002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja005
            #add-point:BEFORE FIELD gzja005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja005
            
            #add-point:AFTER FIELD gzja005

            #END add-point
            
 
         #Ctrlp:construct.c.gzja005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja005
            #add-point:ON ACTION controlp INFIELD gzja005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja006
            #add-point:BEFORE FIELD gzja006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja006
            
            #add-point:AFTER FIELD gzja006

            #END add-point
            
 
         #Ctrlp:construct.c.gzja006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja006
            #add-point:ON ACTION controlp INFIELD gzja006

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja004
            #add-point:BEFORE FIELD gzja004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja004
            
            #add-point:AFTER FIELD gzja004
            
            #END add-point
            
 
         #Ctrlp:construct.c.gzja004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja004
            #add-point:ON ACTION controlp INFIELD gzja004

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja003
            #add-point:BEFORE FIELD gzja003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja003
            
            #add-point:AFTER FIELD gzja003

            #END add-point
            
 
         #Ctrlp:construct.c.gzja003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja003
            #add-point:ON ACTION controlp INFIELD gzja003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjastus
            #add-point:BEFORE FIELD gzjastus

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjastus
            
            #add-point:AFTER FIELD gzjastus

            #END add-point
            
 
         #Ctrlp:construct.c.gzjastus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjastus
            #add-point:ON ACTION controlp INFIELD gzjastus

            #END add-point
 
         #Ctrlp:construct.c.gzjaownid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjaownid
            #add-point:ON ACTION controlp INFIELD gzjaownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzjaownid  #顯示到畫面上
            NEXT FIELD gzjaownid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjaownid
            #add-point:BEFORE FIELD gzjaownid

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjaownid
            
            #add-point:AFTER FIELD gzjaownid

            #END add-point
            
 
         #Ctrlp:construct.c.gzjaowndp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjaowndp
            #add-point:ON ACTION controlp INFIELD gzjaowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzjaowndp  #顯示到畫面上
            NEXT FIELD gzjaowndp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjaowndp
            #add-point:BEFORE FIELD gzjaowndp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjaowndp
            
            #add-point:AFTER FIELD gzjaowndp

            #END add-point
            
 
         #Ctrlp:construct.c.gzjacrtid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjacrtid
            #add-point:ON ACTION controlp INFIELD gzjacrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzjacrtid  #顯示到畫面上
            NEXT FIELD gzjacrtid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjacrtid
            #add-point:BEFORE FIELD gzjacrtid

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjacrtid
            
            #add-point:AFTER FIELD gzjacrtid

            #END add-point
            
 
         #Ctrlp:construct.c.gzjacrtdp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjacrtdp
            #add-point:ON ACTION controlp INFIELD gzjacrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzjacrtdp  #顯示到畫面上
            NEXT FIELD gzjacrtdp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjacrtdp
            #add-point:BEFORE FIELD gzjacrtdp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjacrtdp
            
            #add-point:AFTER FIELD gzjacrtdp

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjacrtdt
            #add-point:BEFORE FIELD gzjacrtdt

            #END add-point
 
         #Ctrlp:construct.c.gzjamodid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjamodid
            #add-point:ON ACTION controlp INFIELD gzjamodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzjamodid  #顯示到畫面上
            NEXT FIELD gzjamodid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjamodid
            #add-point:BEFORE FIELD gzjamodid

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjamodid
            
            #add-point:AFTER FIELD gzjamodid

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjamoddt
            #add-point:BEFORE FIELD gzjamoddt

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjac009
            #add-point:BEFORE FIELD gzja009
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja009
            
            #add-point:AFTER FIELD gzja009
 
            #END add-point
          
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjac011
            #add-point:BEFORE FIELD gzja011
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja011
            
            #add-point:AFTER FIELD gzja011
 
            #END add-point          
      END CONSTRUCT
      
      #add-point:cs段more_construct

      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct

   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="azzi700.filter" >}
#應用 a50 樣板自動產生(Version:5)
#+ filter過濾功能
PRIVATE FUNCTION azzi700_filter()
   #add-point:filter段define
   
   #end add-point   
   #add-point:filter段define
   
   #end add-point   
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON gzja001,gzja002
                          FROM s_browse[1].b_gzja001,s_browse[1].b_gzja002
 
         BEFORE CONSTRUCT
               DISPLAY azzi700_filter_parser('gzja001') TO s_browse[1].b_gzja001
            DISPLAY azzi700_filter_parser('gzja002') TO s_browse[1].b_gzja002
      
         #add-point:filter段cs_ctrl
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog
         
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
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL azzi700_filter_show('gzja001')
   CALL azzi700_filter_show('gzja002')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi700_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define
   
   #end add-point    
   #add-point:filter段define
   
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
 
{<section id="azzi700.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION azzi700_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = azzi700_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi700_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   #add-point:query段define(客製用)
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_gzja_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL azzi700_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi700_browser_fill(g_wc,"F")
      CALL azzi700_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL azzi700_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL azzi700_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="azzi700.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi700_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define

   #end add-point  
   #add-point:fetch段define(客製用)

   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_gzja_m.gzja001 = g_browser[g_current_idx].b_gzja001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE azzi700_master_referesh USING g_gzja_m.gzja001 INTO g_gzja_m.gzja001,g_gzja_m.gzja002,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid,g_gzja_m.gzjaowndp, 
       g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt, 
       g_gzja_m.gzja002_desc,g_gzja_m.gzja006_desc,g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjamodid_desc
   
   #遮罩相關處理
   LET g_gzja_m_mask_o.* =  g_gzja_m.*
   CALL azzi700_gzja_t_mask()
   LET g_gzja_m_mask_n.* =  g_gzja_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi700_set_act_visible()
   CALL azzi700_set_act_no_visible()
 
   #add-point:fetch段action控制

   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_gzja_m_t.* = g_gzja_m.*
   LET g_gzja_m_o.* = g_gzja_m.*
   
   LET g_data_owner = g_gzja_m.gzjaownid      
   LET g_data_dept  = g_gzja_m.gzjaowndp
   
   #重新顯示
   CALL azzi700_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi700_insert()
   #add-point:insert段define

   #end add-point    
   #add-point:insert段define(客製用)

   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_gzja_m.* LIKE gzja_t.*             #DEFAULT 設定
   LET g_gzja001_t = NULL
 
   
   #add-point:insert段before
   #設計器說topstd不可以新增                                                                                
   IF g_account = "topstd" THEN
      #給錯誤訊息
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = "azz-00303"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
      LET g_gzja_m.gzjaownid = g_user
      LET g_gzja_m.gzjaowndp = g_dept
      LET g_gzja_m.gzjacrtid = g_user
      LET g_gzja_m.gzjacrtdp = g_dept 
      LET g_gzja_m.gzjacrtdt = cl_get_current()
      LET g_gzja_m.gzjamodid = g_user
      LET g_gzja_m.gzjamoddt = cl_get_current()
      LET g_gzja_m.gzjastus = 'Y'
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gzja_m.gzja005 = "N"
      LET g_gzja_m.gzja003 = "Y"
 
 
      #add-point:單頭預設值
      LET g_gzja_m.gzjastus = "Y"
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzja_m.gzjastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
     
      #資料輸入
      CALL azzi700_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_gzja_m.* TO NULL
         CALL azzi700_show()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi700_set_act_visible()
   CALL azzi700_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzja001_t = g_gzja_m.gzja001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzja001 = '", g_gzja_m.gzja001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi700_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi700_master_referesh USING g_gzja_m.gzja001 INTO g_gzja_m.gzja001,g_gzja_m.gzja002,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid,g_gzja_m.gzjaowndp, 
       g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt, 
       g_gzja_m.gzja002_desc,g_gzja_m.gzja006_desc,g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjamodid_desc
   
   #遮罩相關處理
   LET g_gzja_m_mask_o.* =  g_gzja_m.*
   CALL azzi700_gzja_t_mask()
   LET g_gzja_m_mask_n.* =  g_gzja_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzja_m.gzja001,g_gzja_m.gzjal003,g_gzja_m.gzja002,g_gzja_m.gzja002_desc,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja006_desc,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid, 
       g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamodid_desc, 
       g_gzja_m.gzjamoddt
 
   #add-point:新增結束後

   #end add-point 
 
   #功能已完成,通報訊息中心
   CALL azzi700_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi700.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi700_modify()
   #add-point:modify段define
   
   #end add-point
   #add-point:modify段define(客製用)

   #end add-point
   
   #先確定key值無遺漏
   IF g_gzja_m.gzja001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_gzja001_t = g_gzja_m.gzja001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN azzi700_cl USING g_gzja_m.gzja001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi700_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi700_master_referesh USING g_gzja_m.gzja001 INTO g_gzja_m.gzja001,g_gzja_m.gzja002,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid,g_gzja_m.gzjaowndp, 
       g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt, 
       g_gzja_m.gzja002_desc,g_gzja_m.gzja006_desc,g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjamodid_desc
 
   #檢查是否允許此動作
   IF NOT azzi700_action_chk() THEN
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gzja_m_mask_o.* =  g_gzja_m.*
   CALL azzi700_gzja_t_mask()
   LET g_gzja_m_mask_n.* =  g_gzja_m.*
   
   
 
   #顯示資料
   CALL azzi700_show()
   
   WHILE TRUE
      LET g_gzja_m.gzja001 = g_gzja001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_gzja_m.gzjamodid = g_user 
LET g_gzja_m.gzjamoddt = cl_get_current()
LET g_gzja_m.gzjamodid_desc = cl_get_username(g_gzja_m.gzjamodid)
      
      #add-point:modify段修改前

      #end add-point
 
      #資料輸入
      CALL azzi700_input("u")     
 
      #add-point:modify段修改後
      
         
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzja_m.* = g_gzja_m_t.*
         CALL azzi700_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE gzja_t SET (gzjamodid,gzjamoddt) = (g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt)
       WHERE  gzja001 = g_gzja001_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi700_set_act_visible()
   CALL azzi700_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzja001 = '", g_gzja_m.gzja001, "' "
 
   #填到對應位置
   CALL azzi700_browser_fill(g_wc,"")
 
   CLOSE azzi700_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi700_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="azzi700.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi700_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define
   DEFINE l_err           BOOLEAN
   DEFINE ls_prog         STRING 
   DEFINE ls_first_code   STRING
   DEFINE ls_serial_num   STRING
   DEFINE l_pos           LIKE type_t.num5
   
   DEFINE ls_file,ls_template    STRING
   DEFINE l_match         LIKE gzja_t.gzja001
   DEFINE lb_ret          BOOLEAN  # 161130-00029#1
   #end add-point
   #add-point:input段define(客製用)

   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzja_m.gzja001,g_gzja_m.gzjal003,g_gzja_m.gzja002,g_gzja_m.gzja002_desc,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja006_desc,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid, 
       g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamodid_desc, 
       g_gzja_m.gzjamoddt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL azzi700_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL azzi700_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前
   IF p_cmd = 'a' THEN
      LET g_gzja_m.gzja002 = "WSS"
      LET g_gzja_m.gzja005 = "s"
      LET g_gzja_m.gzja006 = "sd"
      LET g_gzja_m.gzja012 = "1"
   END IF   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_gzja_m.gzja001,g_gzja_m.gzjal003,g_gzja_m.gzja002,g_gzja_m.gzja005,g_gzja_m.gzja006, 
          g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               IF  NOT cl_null(g_gzja_m.gzja001) THEN
                  CALL n_gzjal(g_gzja_m.gzja001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gzja_m.gzja001
                  CALL ap_ref_array2(g_ref_fields," SELECT gzjal003,gzjal004 FROM gzjal_t WHERE gzjal001 = ? AND gzjal002 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_gzja_m.gzjal003 = g_rtn_fields[1]
                  LET g_gzja_m.gzjal004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_gzja_m.gzjal003
                  DISPLAY BY NAME g_gzja_m.gzjal004
               END IF
               #END add-point
            END IF
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.gzjal001 = g_gzja_m.gzja001
LET g_master_multi_table_t.gzjal003 = g_gzja_m.gzjal003
 
 
            #add-point:input開始前

            #end add-point
   
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja001
            #add-point:BEFORE FIELD gzja001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja001
            
            #add-point:AFTER FIELD gzja001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzja_m.gzja001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzja_m.gzja001 != g_gzja001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzja_t WHERE "||"gzja001 = '"||g_gzja_m.gzja001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF p_cmd <> "u" THEN
               SELECT COUNT(*) INTO l_cnt FROM gzja_t
                WHERE gzja001 = g_gzja_m.gzja001               
                
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "aws-00009"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF
            
            # 161130-00029#1 Start
            CALL azzi700_chk_naming_rule(g_gzja_m.gzja001) RETURNING lb_ret, g_gzja_m.gzja005, g_gzja_m.gzja006
            IF NOT lb_ret THEN # 發生錯誤
              NEXT FIELD CURRENT
            END IF
            { # 161130-00029#1 mark start, 用 azzi700_chk_naming_rule function 取代,
            #參考 azzi900 的命名規格 azzi900_chk_naming_rule()            
            LET ls_prog = g_gzja_m.gzja001
            LET ls_first_code = ls_prog.subString(1,1)
            LET l_err = TRUE
            
            IF ms_dgenv = "s" THEN
               #標準開發環境下，不可以建置客製程式
               IF (ls_first_code = 'c') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00180"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = FALSE
                  LET g_errparam.replace[1] = ls_prog
                  CALL cl_err()
  
                  NEXT FIELD CURRENT
               END IF
               
               IF g_gzja_m.gzja001[1,4] = "wssp" OR g_gzja_m.gzja001[1,5] = "bwssp" THEN                  
                  #通過命名規則
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00001"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = FALSE
                  CALL cl_err() # 不符合命名規則

                  NEXT FIELD CURRENT
               END IF
               
               
            ELSE
               #客製開發環境下
               IF g_gzja_m.gzja001[1,5] = "cwssp" THEN                  
                  LET l_err = FALSE         
               END IF 
               
               IF l_err THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00176"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = ls_prog
                  CALL cl_err()

                  NEXT FIELD CURRENT
               ELSE
                  LET g_gzja_m.gzja005 = "c"
                  LET g_gzja_m.gzja002 = "CWSS"
                  DISPLAY BY NAME g_gzja_m.gzja005
               END IF
            END IF            
            
            LET g_gzja_m.gzja006 = "sd"
            
            CASE 
               WHEN ls_prog.getLength() < 7 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00001"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = FALSE
                  CALL cl_err() #作業名稱不符合命名規則
                  NEXT FIELD CURRENT
                  
               WHEN ls_prog.getLength() >= 7         
                  IF (ls_first_code = 'w' AND ls_prog.getLength() >7) OR
                     (ls_first_code = 'c' AND ls_prog.getLength() >8) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "azz-00001"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err() #作業名稱不符合命名規則
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  IF ls_prog.getLength()=7 THEN
                    #5-7碼要數字 ex wssp999
                    LET ls_serial_num = ls_prog.subString(6,7)
                    IF NOT ls_serial_num MATCHES '[01-9][01-9][01-9]' THEN  
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = "aws-00015"
                       LET g_errparam.extend = ""
                      LET g_errparam.popup = FALSE
                       CALL cl_err()
                      NEXT FIELD CURRENT
                    END IF
                  ELSE
                    #6-8碼要數字 ex bwssp001
                    LET ls_serial_num = ls_prog.subString(6,8)                        
                    IF NOT ls_serial_num MATCHES '[01-9][01-9][01-9]' THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = "aws-00016"
                      LET g_errparam.extend = ""
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      
                      NEXT FIELD CURRENT
                    END IF
                  END IF
                  
                  # 161130-00029#1 end
                  
                  #判定是否是行業程式                                    
                  LET l_pos = ls_prog.getIndexOf("_" ,1)                 
                  
                  IF l_pos = 8 OR l_pos = 9 THEN                    
                     #程式碼開頭為c，不需加上_行業別
                     IF ls_first_code = 'c' THEN
                        #客製程式 %1 歸屬於自訂模組，不需要使用行業編號規則，建議修改為 %2
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "aws-00014"
                        LET g_errparam.extend = NULL
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = ls_prog
                        LET g_errparam.replace[2] = ls_prog.subString(1,7)                  
                        #LET g_errparam.sqlerr = SQLCA.SQLERRD[2] 或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
                        CALL cl_err() 
                        LET g_gzja_m.gzja006 = NULL
                    
                        NEXT FIELD CURRENT
                     END IF
                     
                     #取出行業別                
                     LET g_gzja_m.gzja006 = ls_prog.subString(l_pos+1,ls_prog.getLength())
                     IF s_azzi900_chk_industry(g_gzja_m.gzja006) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "azz-00172"
                        LET g_errparam.extend = NULL
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = ls_prog
                        CALL cl_err() #行業代碼 (%1)
                        
                        NEXT FIELD CURRENT                     
                     END IF
                  ELSE
                     IF ls_first_code = 'b' THEN
                        #程式%1 行業程式，需要使用行業編號規則，建議修改為 %2
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "azz-00175"
                        LET g_errparam.extend = NULL
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = ls_prog
                        LET g_errparam.replace[2] = ls_prog,"_",cl_getmsg("azz-00287",g_dlang)
                        CALL cl_err()
                        
                        NEXT FIELD CURRENT
                     END IF                          
                  END IF
            END CASE
            
            IF ls_first_code = 'c' THEN
               LET g_gzja_m.gzja005 = 'c'
            ELSE
               LET g_gzja_m.gzja005 = 's'            
            END IF
            # # 161130-00029#1 mark end }
            # 161130-00029#1  End
            DISPLAY BY NAME g_gzja_m.gzja005
            
            LET g_ref_fields[1] = g_gzja_m.gzja006
            CALL ap_ref_array2(g_ref_fields,"SELECT gzoi002 FROM gzoi_t WHERE gzoi001=? ","") RETURNING g_rtn_fields
            LET g_gzja_m.gzja006_desc = g_rtn_fields[1]
                        
            DISPLAY BY NAME g_gzja_m.gzja006,g_gzja_m.gzja006_desc
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzja001
            #add-point:ON CHANGE gzja001

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjal003
            #add-point:BEFORE FIELD gzjal003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjal003
            
            #add-point:AFTER FIELD gzjal003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzjal003
            #add-point:ON CHANGE gzjal003

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja002
            
            #add-point:AFTER FIELD gzja002
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzja002
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzja_m.gzja002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzja002_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja002
            #add-point:BEFORE FIELD gzja002

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzja002
            #add-point:ON CHANGE gzja002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja005
            #add-point:BEFORE FIELD gzja005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja005
            
            #add-point:AFTER FIELD gzja005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzja005
            #add-point:ON CHANGE gzja005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja006
            
            #add-point:AFTER FIELD gzja006
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzja006
            CALL ap_ref_array2(g_ref_fields,"SELECT gzoi002 FROM gzoi_t WHERE gzoi001=? ","") RETURNING g_rtn_fields
            LET g_gzja_m.gzja006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzja006_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja006
            #add-point:BEFORE FIELD gzja006

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzja006
            #add-point:ON CHANGE gzja006

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja004
            #add-point:BEFORE FIELD gzja004
           
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja004
            
            #add-point:AFTER FIELD gzja004
            IF cl_null(g_gzja_m.gzja004) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "aws-00013"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD gzja004
            END IF
            
            LET g_sql = "SELECT gzja001 FROM gzja_t WHERE gzja004 = ? "
            DECLARE redun_chk CURSOR FROM g_sql
            EXECUTE redun_chk INTO l_match USING g_gzja_m.gzja004
            #服務名稱不能重複
            IF NOT cl_null(l_match) THEN
               IF l_match != g_gzja_m.gzja001 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "aws-00055" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               
                  NEXT FIELD gzja004
               END IF
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzja004
            #add-point:ON CHANGE gzja004
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzja003
            #add-point:BEFORE FIELD gzja003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzja003
            
            #add-point:AFTER FIELD gzja003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzja003
            #add-point:ON CHANGE gzja003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzjastus
            #add-point:BEFORE FIELD gzjastus

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzjastus
            
            #add-point:AFTER FIELD gzjastus

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzjastus
            #add-point:ON CHANGE gzjastus

            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.gzja001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja001
            #add-point:ON ACTION controlp INFIELD gzja001

            #END add-point
 
         #Ctrlp:input.c.gzjal003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjal003
            #add-point:ON ACTION controlp INFIELD gzjal003

            #END add-point
 
         #Ctrlp:input.c.gzja002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja002
            #add-point:ON ACTION controlp INFIELD gzja002

            #END add-point
 
         #Ctrlp:input.c.gzja005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja005
            #add-point:ON ACTION controlp INFIELD gzja005

            #END add-point
 
         #Ctrlp:input.c.gzja006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja006
            #add-point:ON ACTION controlp INFIELD gzja006

            #END add-point
 
         #Ctrlp:input.c.gzja004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja004
            #add-point:ON ACTION controlp INFIELD gzja004

            #END add-point
 
         #Ctrlp:input.c.gzja003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzja003
            #add-point:ON ACTION controlp INFIELD gzja003

            #END add-point
 
         #Ctrlp:input.c.gzjastus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzjastus
            #add-point:ON ACTION controlp INFIELD gzjastus

            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(*) INTO l_count FROM gzja_t
                WHERE  gzja001 = g_gzja_m.gzja001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前

                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO gzja_t (gzja001,gzja002,gzja005,gzja006,gzja004,gzja007,gzja008,gzja009,gzja011,gzja003,gzja012,gzjastus,gzjaownid, 
                      gzjaowndp,gzjacrtid,gzjacrtdp,gzjacrtdt,gzjamodid,gzjamoddt)
                  VALUES (g_gzja_m.gzja001,g_gzja_m.gzja002,g_gzja_m.gzja005,g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007, 
                      g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid,g_gzja_m.gzjaowndp,g_gzja_m.gzjacrtid, 
                      g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt) 
                  
                  #add-point:單頭新增中

                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzja_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gzja_m.gzja001 = g_master_multi_table_t.gzjal001 AND
         g_gzja_m.gzjal003 = g_master_multi_table_t.gzjal003  THEN
         ELSE 
            LET l_var_keys[01] = g_gzja_m.gzja001
            LET l_field_keys[01] = 'gzjal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzjal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzjal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzja_m.gzjal003
            LET l_fields[01] = 'gzjal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzjal_t')
         END IF 
 
                  
                  #add-point:單頭新增後
                  CALL cl_log_service_register(g_gzja_m.gzja001,g_gzja_m.gzja004)
                  LET ls_file = g_gzja_m.gzja001 CLIPPED,".4gl"
                  LET ls_file = os.path.join(os.path.join(FGL_GETENV(UPSHIFT(g_gzja_m.gzja002)),"4gl"),ls_file)
                  IF NOT os.Path.exists(ls_file) THEN
                     LET ls_template = os.Path.join(os.path.join(FGL_GETENV("ERP"),"mdl"),"code_empty_m.template")
                     IF os.Path.copy(ls_template,ls_file) THEN
                     DISPLAY "Done"
                     END IF
                  END IF
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =  "g_gzja_m.gzja001" 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               #add-point:單頭修改前

               #end add-point
               
               #將遮罩欄位還原
               CALL azzi700_gzja_t_mask_restore('restore_mask_o')
               
               UPDATE gzja_t SET (gzja001,gzja002,gzja005,gzja006,gzja004,gzja007,gzja008,gzja009,gzja011,gzja003,gzja012,gzjastus,gzjaownid, 
                   gzjaowndp,gzjacrtid,gzjacrtdp,gzjacrtdt,gzjamodid,gzjamoddt) = (g_gzja_m.gzja001, 
                   g_gzja_m.gzja002,g_gzja_m.gzja005,g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,
                   g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid,g_gzja_m.gzjaowndp,g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtdp, 
                   g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt)
                WHERE  gzja001 = g_gzja001_t #
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzja_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzja_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gzja_m.gzja001 = g_master_multi_table_t.gzjal001 AND
         g_gzja_m.gzjal003 = g_master_multi_table_t.gzjal003  THEN
         ELSE 
            LET l_var_keys[01] = g_gzja_m.gzja001
            LET l_field_keys[01] = 'gzjal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzjal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzjal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzja_m.gzjal003
            LET l_fields[01] = 'gzjal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzjal_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL azzi700_gzja_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後
                     CALL cl_log_service_modify(g_gzja_m.gzja001,g_gzja_m.gzja004)
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_gzja_m_t)
                     LET g_log2 = util.JSON.stringify(g_gzja_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      #add-point:input段more input 

      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog 

         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input 

   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi700_reproduce()
   DEFINE l_newno     LIKE gzja_t.gzja001 
   DEFINE l_oldno     LIKE gzja_t.gzja001 
 
   DEFINE l_master    RECORD LIKE gzja_t.*
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define
   
   #end add-point   
   #add-point:reproduce段define(客製用)
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_gzja_m.gzja001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_gzja001_t = g_gzja_m.gzja001
 
   
   #清空key值
   LET g_gzja_m.gzja001 = ""
 
    
   CALL azzi700_set_entry("a")
   CALL azzi700_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
      LET g_gzja_m.gzjaownid = g_user
      LET g_gzja_m.gzjaowndp = g_dept
      LET g_gzja_m.gzjacrtid = g_user
      LET g_gzja_m.gzjacrtdp = g_dept 
      LET g_gzja_m.gzjacrtdt = cl_get_current()
      LET g_gzja_m.gzjamodid = g_user
      LET g_gzja_m.gzjamoddt = cl_get_current()
      LET g_gzja_m.gzjastus = 'Y'
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   LET g_gzja_m.gzjamoddt = "Y"
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzja_m.gzjastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL azzi700_input("r")
   
   IF INT_FLAG THEN
      #取消
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      INITIALIZE g_gzja_m.* TO NULL
      CALL azzi700_show()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前
   
   #end add-point
   
   #add-point:單頭複製中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzja_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi700_set_act_visible()
   CALL azzi700_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzja001_t = g_gzja_m.gzja001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzja001 = '", g_gzja_m.gzja001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi700_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
                 
   #功能已完成,通報訊息中心
   CALL azzi700_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.show" >}
#+ 資料顯示 
PRIVATE FUNCTION azzi700_show()
   #add-point:show段define

   #end add-point  
   #add-point:show段define(客製用)

   #end add-point
   
   #add-point:show段之前

   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:3)
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL azzi700_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzjaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzja_m.gzjaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzjaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzjaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzja_m.gzjaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzjaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzjacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzja_m.gzjacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzjacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzjacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzja_m.gzjacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzjacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzjamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzja_m.gzjamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzjamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzja_m.gzja001
            CALL ap_ref_array2(g_ref_fields,"SELECT gzjal003 FROM gzjal_t WHERE gzjal001=? AND gzjal002='"||g_lang||"'", "") RETURNING g_rtn_fields
            LET g_gzja_m.gzjal003 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzja_m.gzjal003
      
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzja_m.gzja001,g_gzja_m.gzjal003,g_gzja_m.gzja002,g_gzja_m.gzja002_desc,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja006_desc,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid, 
       g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamodid_desc, 
       g_gzja_m.gzjamoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL azzi700_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:2)
	  #根據當下狀態碼顯示圖片
      CASE g_gzja_m.gzjastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION azzi700_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   DEFINE l_gzdh           RECORD       #處理資料刪除後記錄程式編號到gzdh_t(標準環境下) #161130-00029#1 
          gzdhownid        LIKE gzdh_t.gzdhownid,
          gzdhowndp        LIKE gzdh_t.gzdhowndp,
          gzdhcrtid        LIKE gzdh_t.gzdhcrtid,
          gzdhcrtdp        LIKE gzdh_t.gzdhcrtdp,
          gzdhcrtdt        LIKE gzdh_t.gzdhcrtdt,
          gzdhmodid        LIKE gzdh_t.gzdhmodid,
          gzdhmoddt        LIKE gzdh_t.gzdhmoddt,
          gzdhstus         LIKE gzdh_t.gzdhstus,
          gzdh001          LIKE gzdh_t.gzdh001,
          gzdh002          LIKE gzdh_t.gzdh002
                           END RECORD
   #end add-point  
   #add-point:delete段define(客製用)

   #end add-point
   
   #先確定key值無遺漏
   IF g_gzja_m.gzja001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_gzja001_t = g_gzja_m.gzja001
 
   
   LET g_master_multi_table_t.gzjal001 = g_gzja_m.gzja001
LET g_master_multi_table_t.gzjal003 = g_gzja_m.gzjal003
 
 
   OPEN azzi700_cl USING g_gzja_m.gzja001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi700_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi700_master_referesh USING g_gzja_m.gzja001 INTO g_gzja_m.gzja001,g_gzja_m.gzja002,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid,g_gzja_m.gzjaowndp, 
       g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt, 
       g_gzja_m.gzja002_desc,g_gzja_m.gzja006_desc,g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjamodid_desc
   
   #檢查是否允許此動作
   IF NOT azzi700_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzja_m_mask_o.* =  g_gzja_m.*
   CALL azzi700_gzja_t_mask()
   LET g_gzja_m_mask_n.* =  g_gzja_m.*
   
   #將最新資料顯示到畫面上
   CALL azzi700_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL azzi700_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
      DELETE FROM gzja_t 
       WHERE  gzja001 = g_gzja_m.gzja001 
 
 
      #add-point:單頭刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzja_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.gzjal001
   LET l_field_keys[01] = 'gzjal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzjal_t')
 
      
      #add-point:單頭刪除後
      CALL cl_log_service_remove(g_gzja_m.gzja001,g_gzja_m.gzja004)
      # 161130-00029#1 start  
      # 控管標準環境下資料刪除後紀錄此程式代號已被用過，不可再拿來使用
      #因為若日後有人再拿此程式代號來使用，但客戶家該程式已改為客製，
      #這樣可能會造成客戶家上patch時程式合併的問題  #reference from azzi900 #161117-00018
      IF (ms_dgenv <> "c") THEN
         LET l_gzdh.gzdhownid = g_user
         LET l_gzdh.gzdhowndp = g_dept
         LET l_gzdh.gzdhcrtid = g_user
         LET l_gzdh.gzdhcrtdp = g_dept
         LET l_gzdh.gzdhcrtdt = cl_get_current()
         LET l_gzdh.gzdhmodid = g_user
         LET l_gzdh.gzdhmoddt = cl_get_current()
         LET l_gzdh.gzdhstus = "Y"
         LET l_gzdh.gzdh001 = "azzi700"
         LET l_gzdh.gzdh002 = g_gzja_m.gzja001
         
         DELETE FROM gzdh_t WHERE gzdh001=l_gzdh.gzdh001 AND gzdh002=l_gzdh.gzdh002
         INSERT INTO gzdh_t (gzdhownid,gzdhowndp,gzdhcrtid,gzdhcrtdp,gzdhcrtdt,
                             gzdhmodid,gzdhmoddt,gzdhstus,gzdh001,gzdh002)
                     VALUES (l_gzdh.gzdhownid,l_gzdh.gzdhowndp,l_gzdh.gzdhcrtid,l_gzdh.gzdhcrtdp,l_gzdh.gzdhcrtdt,
                             l_gzdh.gzdhmodid,l_gzdh.gzdhmoddt,l_gzdh.gzdhstus,l_gzdh.gzdh001,l_gzdh.gzdh002)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "g_gzdh"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF 
      # 161130-00029#1 end
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE azzi700_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL azzi700_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL azzi700_browser_fill(g_wc,"")
         CALL azzi700_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE azzi700_cl
 
   #功能已完成,通報訊息中心
   CALL azzi700_msgcentre_notify('delete')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi700_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   #add-point:ui_browser_refresh段define(客製用)
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzja001 = g_gzja_m.gzja001
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="azzi700.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi700_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define
   
   #end add-point     
   #add-point:set_entry段define(客製用)
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("gzja001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi700_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define
   CALL cl_set_comp_entry("gzja002",FALSE)
   #end add-point     
   #add-point:set_no_entry段define(客製用)
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzja001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi700_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段define(客製用)
   
   #end add-point  
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi700.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi700_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段define(客製用)
   
   #end add-point
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi700.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi700_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   #add-point:default_search段define(客製用)
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " gzja001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi700.mask_functions" >}
&include "erp/azz/azzi700_mask.4gl"
 
{</section>}
 
{<section id="azzi700.state_change" >}
   #應用 a09 樣板自動產生(Version:12)
#+ 確認碼變更 
PRIVATE FUNCTION azzi700_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define

   #end add-point  
   #add-point:statechange段define(客製用)

   #end add-point  
   
   #add-point:statechange段開始前

   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzja_m.gzja001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN azzi700_cl USING g_gzja_m.gzja001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi700_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE azzi700_master_referesh USING g_gzja_m.gzja001 INTO g_gzja_m.gzja001,g_gzja_m.gzja002,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid,g_gzja_m.gzjaowndp, 
       g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt, 
       g_gzja_m.gzja002_desc,g_gzja_m.gzja006_desc,g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjamodid_desc
 
   #檢查是否允許此動作
   IF NOT azzi700_action_chk() THEN
      CLOSE azzi700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzja_m.gzja001,g_gzja_m.gzjal003,g_gzja_m.gzja002,g_gzja_m.gzja002_desc,g_gzja_m.gzja005, 
       g_gzja_m.gzja006,g_gzja_m.gzja006_desc,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid, 
       g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtid_desc, 
       g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid,g_gzja_m.gzjamodid_desc, 
       g_gzja_m.gzjamoddt
 
   CASE g_gzja_m.gzjastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後

   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gzja_m.gzjastus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前

      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制

      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_gzja_m.gzjastus = lc_state OR cl_null(lc_state) THEN
      CLOSE azzi700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前

   #end add-point
   
   LET g_gzja_m.gzjamodid = g_user
   LET g_gzja_m.gzjamoddt = cl_get_current()
   LET g_gzja_m.gzjastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gzja_t 
      SET (gzjastus,gzjamodid,gzjamoddt) 
        = (g_gzja_m.gzjastus,g_gzja_m.gzjamodid,g_gzja_m.gzjamoddt)     
    WHERE  gzja001 = g_gzja_m.gzja001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE azzi700_master_referesh USING g_gzja_m.gzja001 INTO g_gzja_m.gzja001,g_gzja_m.gzja002, 
          g_gzja_m.gzja005,g_gzja_m.gzja006,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus,g_gzja_m.gzjaownid, 
          g_gzja_m.gzjaowndp,g_gzja_m.gzjacrtid,g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid, 
          g_gzja_m.gzjamoddt,g_gzja_m.gzja002_desc,g_gzja_m.gzja006_desc,g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp_desc, 
          g_gzja_m.gzjacrtid_desc,g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gzja_m.gzja001,g_gzja_m.gzjal003,g_gzja_m.gzja002,g_gzja_m.gzja002_desc,g_gzja_m.gzja005, 
          g_gzja_m.gzja006,g_gzja_m.gzja006_desc,g_gzja_m.gzja004,g_gzja_m.gzja007,g_gzja_m.gzja008,g_gzja_m.gzja009,g_gzja_m.gzja011,g_gzja_m.gzja003,g_gzja_m.gzja012,g_gzja_m.gzjastus, 
          g_gzja_m.gzjaownid,g_gzja_m.gzjaownid_desc,g_gzja_m.gzjaowndp,g_gzja_m.gzjaowndp_desc,g_gzja_m.gzjacrtid, 
          g_gzja_m.gzjacrtid_desc,g_gzja_m.gzjacrtdp,g_gzja_m.gzjacrtdp_desc,g_gzja_m.gzjacrtdt,g_gzja_m.gzjamodid, 
          g_gzja_m.gzjamodid_desc,g_gzja_m.gzjamoddt
   END IF
 
   #add-point:stus修改後

   #end add-point
 
   #add-point:statechange段結束前

   #end add-point  
 
   CLOSE azzi700_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi700_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi700.signature" >}
   
 
{</section>}
 
{<section id="azzi700.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi700_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_gzja_m.gzja001
   LET g_pk_array[1].column = 'gzja001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi700.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="azzi700.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:3)
PRIVATE FUNCTION azzi700_msgcentre_notify(lc_state)
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define
   
   #end add-point
   #add-point:msgcentre_notify段define
   
   #end add-point   
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL azzi700_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzja_m)
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi700.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION azzi700_action_chk()
   #add-point:action_chk段define
   DEFINE l_sqlct         LIKE type_t.num5  # 暫存變數,sql 計算的 count value # 161130-00029#1
   #end add-point
   #add-point:action_chk段define(客製用)
   
   #end add-point
   
   #add-point:action_chk段action_chk
   # 161130-00029#1 start
   # 如果刪除時，設計資料還在，那就不可以刪除 #參考 azzi900 #160721-00020 #1
   IF (g_action_choice=="delete") THEN
      SELECT COUNT(*) INTO l_sqlct FROM gzja_t WHERE gzja001 = g_gzja_m.gzja001
      IF (l_sqlct == 1) THEN 
         IF s_azzi900_cnt_dzax(g_gzja_m.gzja001) THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "azz-00333"
            LET g_errparam.popup  = TRUE
            LET g_errparam.replace[1] = g_gzja_m.gzja001
            CALL cl_err()
            RETURN FALSE # 取消刪除行為
         END IF
      END IF 
   END IF 
   # 161130-00029#1 end
   
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi700.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查命名是否符合規則
# Memo...........: 參考 azzi900 的命名規格 azzi900_chk_naming_rule()
# Usage..........: CALL azzi700_chk_naming_rule(p_name)
#                  RETURNING lb_ret, l_stdcust, l_industry
# Input parameter: p_name, String  要檢查的名稱
#                : 
# Return code....: lb_ret, Boolean 是否符合命名規則
#                : l_stdcust       標準 or 客製
#                : l_industry      行業編號
# Date & Author..: 2016-12-01 by 07558 circle # 161130-00029#1
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi700_chk_naming_rule(p_name)
  DEFINE p_name          LIKE gzja_t.gzja001
  DEFINE lb_ret          BOOLEAN  #檢查名稱正確否 true : 正確 false: 錯誤
  DEFINE l_stdcust       LIKE gzja_t.gzja005  #標準 or 客製
  DEFINE l_industry      LIKE gzja_t.gzja006  #行業編號
  DEFINE lbs_name        base.StringBuffer 
  DEFINE lc_first_code   LIKE type_t.chr1 
  DEFINE ls_str          STRING
  DEFINE li_idx1         LIKE type_t.num5
  DEFINE li_idx2         LIKE type_t.num5
  DEFINE l_sqlct         LIKE type_t.num5  # 暫存變數,sql 計算的 count value
  DEFINE ls_serial_num   STRING
  
  DEFINE lbs_tmpbuf      base.StringBuffer #字串處理暫存變數
  
  LET lb_ret     = FALSE #預設回傳
  LET l_stdcust  = NULL  #預設回傳
  LET l_industry = NULL  #預設回傳
  LET lbs_name   = base.StringBuffer.create()
  LET lbs_tmpbuf = base.StringBuffer.create()
  
  CALL lbs_name.append(p_name)
  #先檢查程式名稱長度
  IF lbs_name.getLength() < 7 THEN # Error
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = "azz-00001" #作業名稱不符合命名規則
     LET g_errparam.extend = ""
     LET g_errparam.popup = FALSE
     CALL cl_err()
     RETURN lb_ret, l_stdcust, l_industry
  END IF
  
  LET lc_first_code = lbs_name.getCharAt(1)
  
  IF ms_dgenv = "s" THEN
     LET l_stdcust = "s"
     LET l_industry = "sd"
     
     #標準開發環境下，若是曾經刪除過的程式代號，不可再拿來使用
     LET l_sqlct = 0
     SELECT COUNT(1) INTO l_sqlct FROM gzdh_t WHERE gzdh001 = 'azzi700' and gzdh002 = p_name
     IF l_sqlct > 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = p_name
        LET g_errparam.code   = "azz-00364"
        LET g_errparam.popup  = TRUE
        CALL cl_err()
        RETURN lb_ret, l_stdcust, l_industry
     END IF
     
     #標準開發環境下 開頭只能輸入 b,w
     IF (NOT lc_first_code MATCHES "[bw]")  THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "azz-00180"
        LET g_errparam.extend = ""
        LET g_errparam.popup = FALSE
        LET g_errparam.replace[1] = lbs_name.toString()
        CALL cl_err()
        RETURN lb_ret, l_stdcust, l_industry
     END IF
  ELSE
    LET l_stdcust = "c"
    # 客製環境下 新增時檢查首碼只能輸入 c/d/e/n 
    IF NOT lc_first_code MATCHES "[cden]" THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "azz-00176"
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = lbs_name.toString()
       CALL cl_err()
       RETURN lb_ret, l_stdcust, l_industry
    END IF
  END IF
  
  # 檢查名稱命名規則"wssp"
  IF (lc_first_code == "w") THEN
     LET ls_str =  lbs_name.subString(1,4)
  ELSE
     LET ls_str =  lbs_name.subString(2,5)
  END IF
  IF NOT ls_str = "wssp" THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = "azz-00001"
     LET g_errparam.extend = ""
     LET g_errparam.popup = FALSE
     CALL cl_err() # 不符合命名規則
     RETURN lb_ret, l_stdcust, l_industry
  END IF
  
  # 檢查名稱 5-7 or 6-8 碼 
  IF (lc_first_code = "w") THEN 
     LET li_idx1 = 5
     LET li_idx2 = 7
  ELSE 
     LET li_idx1 = 6
     LET li_idx2 = 8
  END IF
  LET ls_serial_num =  lbs_name.subString(li_idx1, li_idx2)
  IF ms_dgenv = "s" THEN #標準環境下
     IF NOT ls_serial_num MATCHES '[01-9][01-9][01-9]' THEN  
        INITIALIZE g_errparam TO NULL
        IF (lc_first_code = "w") THEN  # wssp999
           LET g_errparam.code = "aws-00015"
        ELSE # bwssp999
           LET g_errparam.code = "aws-00016"
        END IF
        LET g_errparam.extend = ""
        LET g_errparam.popup = FALSE
        CALL cl_err()
        RETURN lb_ret,  l_stdcust, l_industry
     END IF
  ELSE # 客製環境下
     LET ls_str = lbs_name.subString(li_idx1, li_idx1)
     IF (NOT ls_str MATCHES "[01-9]" AND NOT ls_str MATCHES "[a-z]") THEN  # Error
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "aws-00095" # 第%1碼僅能輸入數字或英文%2  
        LET g_errparam.replace[1] = li_idx1
        CALL lbs_tmpbuf.clear()
        CALL lbs_tmpbuf.append(g_errparam.replace[1]) 
        CALL lbs_tmpbuf.replace(" ", "", 0)
        LET g_errparam.replace[1] = lbs_tmpbuf.toString()
        LET g_errparam.replace[2] = "cwsspa01"
        LET g_errparam.extend = ""
        LET g_errparam.popup = FALSE
        CALL cl_err()
        RETURN lb_ret,  l_stdcust, l_industry
     END IF 
     
     LET li_idx1 = li_idx1 + 1
     LET ls_serial_num =  lbs_name.subString(li_idx1, li_idx2) # 第6-7碼 or 第7-8碼為數字
     IF NOT ls_serial_num MATCHES '[01-9][01-9]' THEN 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "aws-00094" # 第?碼要數字 ex cwsspa99
        LET g_errparam.replace[1] = li_idx1, "-", li_idx2  # 第6-7碼 or 第7-8碼
        CALL lbs_tmpbuf.clear()
        CALL lbs_tmpbuf.append(g_errparam.replace[1]) 
        CALL lbs_tmpbuf.replace(" ", "", 0)
        LET g_errparam.replace[1] = lbs_tmpbuf.toString()
        LET g_errparam.replace[2] = "cwsspa01"
        LET g_errparam.extend = ""
        LET g_errparam.popup = FALSE
        CALL cl_err()
        RETURN lb_ret,  l_stdcust, l_industry
     END IF
  END IF
  
  #行業判定 
  LET li_idx1 = lbs_name.getIndexOf("_" ,1)  # value >= 8
  LET li_idx2 = lbs_name.getLength()
  
  IF li_idx1 > 0 THEN  # ?wssp999_
     IF (li_idx1 < 7 OR li_idx1 >= li_idx2) THEN #存在 under-line 但位置不對
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "azz-00001"
       LET g_errparam.extend = ""
       LET g_errparam.popup = FALSE
       CALL cl_err()
       RETURN lb_ret, l_stdcust, l_industry
     END IF 
     
     CASE 
       WHEN lc_first_code = "c" 
          #客製程式 %1 歸屬於自訂模組，不需要使用行業編號規則，建議修改為 %2
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = "aws-00014"
          LET g_errparam.extend = NULL
          LET g_errparam.popup = TRUE
          LET g_errparam.replace[1] = lbs_name.toString()
          LET g_errparam.replace[2] = lbs_name.subString(1, li_idx1-1)
          #LET g_errparam.sqlerr = SQLCA.SQLERRD[2] 或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
          CALL cl_err() 
          LET l_industry = NULL
          RETURN lb_ret, l_stdcust, l_industry
          
       WHEN lc_first_code = "e" 
          #程式碼開頭為e (客製程式字串模組)=> 顯示錯誤訊息 (因為客戶家的客製不歸類為行業包)
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = "azz-00174" #客製程式 %1 歸屬於自訂模組，不需要使用行業編號規則，建議修改為 %2
          LET g_errparam.extend = NULL
          LET g_errparam.popup = TRUE
          LET g_errparam.replace[1] = lbs_name.toString()
          LET g_errparam.replace[2] = lbs_name.subString(1, li_idx1-1) 
          CALL cl_err() 
          LET l_industry = NULL
          RETURN lb_ret, l_stdcust, l_industry
     END CASE
     
     #檢查行業代碼是否存在
     LET li_idx1 = li_idx1 + 1
     LET l_industry = lbs_name.subString(li_idx1, li_idx2) #取得行業別
     IF s_azzi900_chk_industry(l_industry) THEN 
        INITIALIZE g_errparam TO NULL  
        LET g_errparam.code = "azz-00172" #行業代碼 (%1) 不存在，請先檢視行業別設定
        LET g_errparam.extend = NULL
        LET g_errparam.popup = TRUE
        LET g_errparam.replace[1] = lbs_name.toString()
        CALL cl_err() 
        RETURN lb_ret,  l_stdcust, l_industry
     END IF
     
     #檢查行業代碼不可以為sd
     IF l_industry = "sd" THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "azz-00179"
        LET g_errparam.extend = ""
        LET g_errparam.popup = FALSE
        CALL cl_err()
        RETURN lb_ret,  l_stdcust, l_industry
     END IF
  ELSE
     #不存在 under-line, 但是長度超過 8 碼, 肯定輸入錯誤
     IF lbs_name.getLength() > 8 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "azz-00001"
        LET g_errparam.extend = ""
        LET g_errparam.popup = FALSE
        CALL cl_err()
        RETURN lb_ret,  l_stdcust, l_industry
     END IF
     
     #開頭為b/d,一定為行業程式,增加額外管制
     IF lc_first_code MATCHES "[bd]" THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "azz-00175" #程式%1 行業程式，需要使用行業編號規則，建議修改為 %2
        LET g_errparam.extend = ""
        LET g_errparam.popup = TRUE
        LET g_errparam.replace[1] = lbs_name.toString()
        LET g_errparam.replace[2] = lbs_name.toString(), "_", cl_getmsg("azz-00287",g_dlang)
        CALL cl_err()
        RETURN lb_ret,  l_stdcust, l_industry
     END IF
  END IF
  
  LET lb_ret = TRUE
  RETURN lb_ret, l_stdcust, l_industry
END FUNCTION

 
{</section>}
 
