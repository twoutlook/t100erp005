#該程式未解開Section, 採用最新樣板產出!
{<section id="agli171.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-05-13 13:51:42), PR版次:0010(2016-08-26 14:54:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000353
#+ Filename...: agli171
#+ Description: 重評價依帳套設定作業
#+ Creator....: 01727(2013-10-30 13:59:14)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="agli171.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150924 帳套檢合增加單頭條件
#151117-00009#1    2015/11/18 By 02599    当有账套时，科目检查改为检查是否存在于glad_t中
#160321-00016#28   2016/03/25 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00005#14   2016/03/25 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160513-00008#1    2016/05/13 By 02599    SCC_8318增加項 8318_13 "外幣銀存重評價存提碼別"和8318_14 "外幣票據重評價存提碼別"
#160811-00039#6    2016/08/25 By 02599   查询及建立资料时（包括直接查询全部、开窗、输入值后的检核）及更改和删除，要考虑账套权限。
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
PRIVATE type type_g_glaa_m        RECORD
       glaald LIKE glaa_t.glaald, 
   glaald_desc LIKE type_t.chr80, 
   glaa001 LIKE glaa_t.glaa001, 
   glaa001_desc LIKE type_t.chr80, 
   glaa014 LIKE glaa_t.glaa014, 
   glaa008 LIKE glaa_t.glaa008, 
   glaacomp LIKE glaa_t.glaacomp, 
   glaacomp_desc LIKE type_t.chr80, 
   glaa004 LIKE glaa_t.glaa004, 
   glaa004_desc LIKE type_t.chr80, 
   glaastus LIKE glaa_t.glaastus
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glca_d        RECORD
       glca001 LIKE glca_t.glca001, 
   glca001_desc LIKE type_t.chr500, 
   glca002 LIKE glca_t.glca002, 
   glca003 LIKE glca_t.glca003, 
   glca004 LIKE glca_t.glca004, 
   glca005 LIKE glca_t.glca005, 
   lbl_ym LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_glca2_d RECORD
       glab001 LIKE glab_t.glab001, 
   glab002 LIKE glab_t.glab002, 
   glab003 LIKE glab_t.glab003, 
   glab003_desc LIKE type_t.chr500, 
   glab005 LIKE glab_t.glab005, 
   glab005_desc LIKE type_t.chr500, 
   glab011 LIKE glab_t.glab011
       END RECORD
PRIVATE TYPE type_g_glca3_d RECORD
       glcd001 LIKE glcd_t.glcd001, 
   glcd001_desc LIKE type_t.chr500, 
   glcdacti LIKE glcd_t.glcdacti
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_glaald LIKE glaa_t.glaald
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_glaa_m          type_g_glaa_m
DEFINE g_glaa_m_t        type_g_glaa_m
DEFINE g_glaa_m_o        type_g_glaa_m
DEFINE g_glaa_m_mask_o   type_g_glaa_m #轉換遮罩前資料
DEFINE g_glaa_m_mask_n   type_g_glaa_m #轉換遮罩後資料
 
   DEFINE g_glaald_t LIKE glaa_t.glaald
 
 
DEFINE g_glca_d          DYNAMIC ARRAY OF type_g_glca_d
DEFINE g_glca_d_t        type_g_glca_d
DEFINE g_glca_d_o        type_g_glca_d
DEFINE g_glca_d_mask_o   DYNAMIC ARRAY OF type_g_glca_d #轉換遮罩前資料
DEFINE g_glca_d_mask_n   DYNAMIC ARRAY OF type_g_glca_d #轉換遮罩後資料
DEFINE g_glca2_d          DYNAMIC ARRAY OF type_g_glca2_d
DEFINE g_glca2_d_t        type_g_glca2_d
DEFINE g_glca2_d_o        type_g_glca2_d
DEFINE g_glca2_d_mask_o   DYNAMIC ARRAY OF type_g_glca2_d #轉換遮罩前資料
DEFINE g_glca2_d_mask_n   DYNAMIC ARRAY OF type_g_glca2_d #轉換遮罩後資料
DEFINE g_glca3_d          DYNAMIC ARRAY OF type_g_glca3_d
DEFINE g_glca3_d_t        type_g_glca3_d
DEFINE g_glca3_d_o        type_g_glca3_d
DEFINE g_glca3_d_mask_o   DYNAMIC ARRAY OF type_g_glca3_d #轉換遮罩前資料
DEFINE g_glca3_d_mask_n   DYNAMIC ARRAY OF type_g_glca3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc2_extend          STRING
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
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="agli171.main" >}
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
   LET g_forupd_sql = " SELECT glaald,'',glaa001,'',glaa014,glaa008,glaacomp,'',glaa004,'',glaastus", 
        
                      " FROM glaa_t",
                      " WHERE glaaent= ? AND glaald=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli171_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glaald,t0.glaa001,t0.glaa014,t0.glaa008,t0.glaacomp,t0.glaa004,t0.glaastus, 
       t1.glaal002 ,t2.ooail003 ,t3.ooefl003 ,t4.ooall004",
               " FROM glaa_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.glaald AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=t0.glaa001 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.glaacomp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t4 ON t4.ooallent="||g_enterprise||" AND t4.ooall001='0' AND t4.ooall002=t0.glaa004 AND t4.ooall003='"||g_dlang||"' ",
 
               " WHERE t0.glaaent = " ||g_enterprise|| " AND t0.glaald = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agli171_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agli171 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agli171_init()   
 
      #進入選單 Menu (="N")
      CALL agli171_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agli171
      
   END IF 
   
   CLOSE agli171_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agli171.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agli171_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('glaastus','17','N,Y')
 
      CALL cl_set_combo_scc('glca001','8303') 
   CALL cl_set_combo_scc('glca002','8317') 
   CALL cl_set_combo_scc('glca003','40') 
   CALL cl_set_combo_scc('glab011','8315') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glca003','8724') 
   #end add-point
   
   #初始化搜尋條件
   CALL agli171_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agli171.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agli171_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL agli171_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_glaa_m.* TO NULL
         CALL g_glca_d.clear()
         CALL g_glca2_d.clear()
         CALL g_glca3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agli171_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_glca_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agli171_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL agli171_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_glca2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agli171_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL agli171_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_glca3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agli171_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL agli171_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL agli171_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL agli171_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agli171_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL agli171_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL agli171_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL agli171_set_act_visible()   
            CALL agli171_set_act_no_visible()
            IF NOT (g_glaa_m.glaald IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " glaaent = " ||g_enterprise|| " AND",
                                  " glaald = '", g_glaa_m.glaald, "' "
 
               #填到對應位置
               CALL agli171_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "glaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glca_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glab_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "glcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL agli171_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "glaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glca_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glab_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "glcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL agli171_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL agli171_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agli171_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli171_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agli171_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli171_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agli171_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli171_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agli171_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli171_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agli171_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli171_idx_chk()
          
         #excel匯出功能          
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
                  LET g_export_node[1] = base.typeInfo.create(g_glca_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_glca2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_glca3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL agli171_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agli171_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agli171_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agli171_insert()
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL agli171_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agli171_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agli171_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agli171_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agli171_set_pk_array()
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
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="agli171.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agli171_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_searchcol       STRING
   DEFINE l_ld_str          STRING   #160811-00039#6
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   LET l_searchcol = 'glaald'
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   LET l_wc = l_wc," AND glaald IN (SELECT DISTINCT glcald FROM glca_t WHERE glcaent = '",g_enterprise,"' AND glca001 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8303' AND gzcb003 = '8317'))"
   LET l_wc = l_wc," AND glaald IN (SELECT DISTINCT glabld FROM glab_t WHERE glabent = '",g_enterprise,"' AND glab001 = '25' AND glab002 = '8318')"
   #160811-00039#6--add--str--
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
   LET l_wc = l_wc," AND ",l_ld_str
   #160811-00039#6--add--end
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT glaald ",
                      " FROM glaa_t ",
                      " ",
                      " LEFT JOIN glca_t ON glcaent = glaaent AND glaald = glcald ", "  ",
                      #add-point:browser_fill段sql(glca_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN glab_t ON glabent = glaaent AND glaald = glabld", "  ",
                      #add-point:browser_fill段sql(glab_t1) name="browser_fill.cnt.join.glab_t1"
                      
                      #end add-point
 
                      " LEFT JOIN glcd_t ON glcdent = glaaent AND glaald = glcdld", "  ",
                      #add-point:browser_fill段sql(glcd_t1) name="browser_fill.cnt.join.glcd_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE glaaent = " ||g_enterprise|| " AND glcaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glaald ",
                      " FROM glaa_t ", 
                      "  ",
                      "  ",
                      " WHERE glaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glaa_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE glaald ",
                        " FROM glaa_t ",
                              " LEFT JOIN glca_t ON glcaent = glaaent AND glaald = glcald ",
                              " LEFT JOIN glab_t ON glabent = glaaent AND glaald = glabld ",
                              " LEFT JOIN glcd_t ON glcdent = glaaent AND glaald = glcdld", 
                       " WHERE glaald = glcald",
                       "   AND glaaent = '" ||g_enterprise|| "' AND glcaent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE glaald ",
                      "   FROM glaa_t,glca_t ", 
                      "  WHERE glaald = glcald",
                      "    AND glaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_glaa_m.* TO NULL
      CALL g_glca_d.clear()        
      CALL g_glca2_d.clear() 
      CALL g_glca3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glaald Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glaastus,t0.glaald ",
                  " FROM glaa_t t0",
                  "  ",
                  "  LEFT JOIN glca_t ON glcaent = glaaent AND glaald = glcald ", "  ", 
                  #add-point:browser_fill段sql(glca_t1) name="browser_fill.join.glca_t1"
                  
                  #end add-point
                  "  LEFT JOIN glab_t ON glabent = glaaent AND glaald = glabld", "  ", 
                  #add-point:browser_fill段sql(glab_t1) name="browser_fill.join.glab_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN glcd_t ON glcdent = glaaent AND glaald = glcdld", "  ", 
                  #add-point:browser_fill段sql(glcd_t1) name="browser_fill.join.glcd_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.glaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("glaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glaastus,t0.glaald ",
                  " FROM glaa_t t0",
                  "  ",
                  
                  " WHERE t0.glaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("glaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY glaald ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照glaald Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT glaastus,glaald,DENSE_RANK() OVER(ORDER BY glaald ",g_order,") AS RANK ",
                        " FROM glaa_t ",
                              " LEFT JOIN glca_t ON glcaent = glaaent AND glaald = glcald ",
                              " LEFT JOIN glab_t ON glabent = glaaent AND glaald = glabld ",
                              " LEFT JOIN glcd_t ON glcdent = glaaent AND glaald = glcdld",
                       " WHERE glaald = glcald",
                       "   AND glaaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT glaastus,glaald,DENSE_RANK() OVER(ORDER BY glaald ",g_order,") AS RANK ",
                       "  FROM glaa_t,glca_t ",
                       " WHERE glaald = glcald ",
                       "   AND glaaent = '" ||g_enterprise|| "' AND ", l_wc
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT glaastus,glaald FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"glaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_glaald
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
 
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
   
   IF cl_null(g_browser[g_cnt].b_glaald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
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
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agli171_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glaa_m.glaald = g_browser[g_current_idx].b_glaald   
 
   EXECUTE agli171_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus,g_glaa_m.glaald_desc,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaacomp_desc,g_glaa_m.glaa004_desc
   
   CALL agli171_glaa_t_mask()
   CALL agli171_show()
      
END FUNCTION
 
{</section>}
 
{<section id="agli171.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agli171_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agli171_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_glaald = g_glaa_m.glaald 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
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
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agli171_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_glaa_m.* TO NULL
   CALL g_glca_d.clear()        
   CALL g_glca2_d.clear() 
   CALL g_glca3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glaald,glaa001,glaa014,glaa008,glaacomp,glaa004,glaastus
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glaacrtdt>>----
 
         #----<<glaamoddt>>----
         
         #----<<glaacnfdt>>----
         
         #----<<glaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="construct.c.glaald"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO glaald  #顯示到畫面上
            NEXT FIELD glaald                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="construct.b.glaald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="construct.a.glaald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="construct.c.glaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa001  #顯示到畫面上
            NEXT FIELD glaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="construct.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="construct.a.glaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa014
            #add-point:BEFORE FIELD glaa014 name="construct.b.glaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa014
            
            #add-point:AFTER FIELD glaa014 name="construct.a.glaa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa014
            #add-point:ON ACTION controlp INFIELD glaa014 name="construct.c.glaa014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa008
            #add-point:BEFORE FIELD glaa008 name="construct.b.glaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa008
            
            #add-point:AFTER FIELD glaa008 name="construct.a.glaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa008
            #add-point:ON ACTION controlp INFIELD glaa008 name="construct.c.glaa008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003= 'Y' "
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaacomp  #顯示到畫面上
            NEXT FIELD glaacomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.glaacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004
            #add-point:ON ACTION controlp INFIELD glaa004 name="construct.c.glaa004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooal002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa004  #顯示到畫面上
            NEXT FIELD glaa004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004
            #add-point:BEFORE FIELD glaa004 name="construct.b.glaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004
            
            #add-point:AFTER FIELD glaa004 name="construct.a.glaa004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaastus
            #add-point:BEFORE FIELD glaastus name="construct.b.glaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaastus
            
            #add-point:AFTER FIELD glaastus name="construct.a.glaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaastus
            #add-point:ON ACTION controlp INFIELD glaastus name="construct.c.glaastus"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON glca001,glca002,glca003,glca004,glca005,lbl_ym
           FROM s_detail1[1].glca001,s_detail1[1].glca002,s_detail1[1].glca003,s_detail1[1].glca004, 
               s_detail1[1].glca005,s_detail1[1].lbl_ym
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca001
            #add-point:BEFORE FIELD glca001 name="construct.b.page1.glca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca001
            
            #add-point:AFTER FIELD glca001 name="construct.a.page1.glca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca001
            #add-point:ON ACTION controlp INFIELD glca001 name="construct.c.page1.glca001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca002
            #add-point:BEFORE FIELD glca002 name="construct.b.page1.glca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca002
            
            #add-point:AFTER FIELD glca002 name="construct.a.page1.glca002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glca002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca002
            #add-point:ON ACTION controlp INFIELD glca002 name="construct.c.page1.glca002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca003
            #add-point:BEFORE FIELD glca003 name="construct.b.page1.glca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca003
            
            #add-point:AFTER FIELD glca003 name="construct.a.page1.glca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca003
            #add-point:ON ACTION controlp INFIELD glca003 name="construct.c.page1.glca003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca004
            #add-point:BEFORE FIELD glca004 name="construct.b.page1.glca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca004
            
            #add-point:AFTER FIELD glca004 name="construct.a.page1.glca004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca004
            #add-point:ON ACTION controlp INFIELD glca004 name="construct.c.page1.glca004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca005
            #add-point:BEFORE FIELD glca005 name="construct.b.page1.glca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca005
            
            #add-point:AFTER FIELD glca005 name="construct.a.page1.glca005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca005
            #add-point:ON ACTION controlp INFIELD glca005 name="construct.c.page1.glca005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_ym
            #add-point:BEFORE FIELD lbl_ym name="construct.b.page1.lbl_ym"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_ym
            
            #add-point:AFTER FIELD lbl_ym name="construct.a.page1.lbl_ym"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.lbl_ym
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_ym
            #add-point:ON ACTION controlp INFIELD lbl_ym name="construct.c.page1.lbl_ym"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON glab001,glab002,glab003,glab005,glab005_desc,glab011
           FROM s_detail2[1].glab001,s_detail2[1].glab002,s_detail2[1].glab003,s_detail2[1].glab005, 
               s_detail2[1].glab005_desc,s_detail2[1].glab011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001 name="construct.b.page2.glab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab001
            
            #add-point:AFTER FIELD glab001 name="construct.a.page2.glab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001 name="construct.c.page2.glab001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab002
            #add-point:BEFORE FIELD glab002 name="construct.b.page2.glab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab002
            
            #add-point:AFTER FIELD glab002 name="construct.a.page2.glab002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab002
            #add-point:ON ACTION controlp INFIELD glab002 name="construct.c.page2.glab002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003 name="construct.b.page2.glab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003
            
            #add-point:AFTER FIELD glab003 name="construct.a.page2.glab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003 name="construct.c.page2.glab003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="construct.b.page2.glab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="construct.a.page2.glab005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="construct.c.page2.glab005"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' ",
                                   #151117-00009#1--add--str--
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise,
                                   "                    AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glab005  #顯示到畫面上

            NEXT FIELD glab005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005_desc
            #add-point:BEFORE FIELD glab005_desc name="construct.b.page2.glab005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005_desc
            
            #add-point:AFTER FIELD glab005_desc name="construct.a.page2.glab005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glab005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005_desc
            #add-point:ON ACTION controlp INFIELD glab005_desc name="construct.c.page2.glab005_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011 name="construct.b.page2.glab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab011
            
            #add-point:AFTER FIELD glab011 name="construct.a.page2.glab011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011 name="construct.c.page2.glab011"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON glcd001,glcd001_desc,glcdacti
           FROM s_detail3[1].glcd001,s_detail3[1].glcd001_desc,s_detail3[1].glcdacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.glcd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glcd001
            #add-point:ON ACTION controlp INFIELD glcd001 name="construct.c.page3.glcd001"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' ",
                                   #151117-00009#1--add--str--
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise,
                                   "                    AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glcd001  #顯示到畫面上
            NEXT FIELD glcd001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glcd001
            #add-point:BEFORE FIELD glcd001 name="construct.b.page3.glcd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glcd001
            
            #add-point:AFTER FIELD glcd001 name="construct.a.page3.glcd001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glcd001_desc
            #add-point:BEFORE FIELD glcd001_desc name="construct.b.page3.glcd001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glcd001_desc
            
            #add-point:AFTER FIELD glcd001_desc name="construct.a.page3.glcd001_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.glcd001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glcd001_desc
            #add-point:ON ACTION controlp INFIELD glcd001_desc name="construct.c.page3.glcd001_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glcdacti
            #add-point:BEFORE FIELD glcdacti name="construct.b.page3.glcdacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glcdacti
            
            #add-point:AFTER FIELD glcdacti name="construct.a.page3.glcdacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.glcdacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glcdacti
            #add-point:ON ACTION controlp INFIELD glcdacti name="construct.c.page3.glcdacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "glaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "glca_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "glab_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "glcd_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agli171_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_glca_d.clear()
   CALL g_glca2_d.clear()
   CALL g_glca3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL agli171_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agli171_browser_fill("")
      CALL agli171_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL agli171_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL agli171_fetch("F") 
      #顯示單身筆數
      CALL agli171_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agli171_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
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
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
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
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_glaa_m.glaald = g_browser[g_current_idx].b_glaald
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agli171_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus,g_glaa_m.glaald_desc,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaacomp_desc,g_glaa_m.glaa004_desc
   
   #遮罩相關處理
   LET g_glaa_m_mask_o.* =  g_glaa_m.*
   CALL agli171_glaa_t_mask()
   LET g_glaa_m_mask_n.* =  g_glaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agli171_set_act_visible()   
   CALL agli171_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   SELECT UNIQUE glcald,glaa001,glaa014,glaa008,glaacomp,glaa004,glaastus
     INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus
     FROM glaa_t,glca_t
    WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
      AND glcald = glaald
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glaa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_glaa_m.* TO NULL
      RETURN
   END IF
   
#   #若無資料則關閉相關功能
#   IF g_browser_cnt = 0 THEN
#      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", FALSE)
#   ELSE
#      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
#   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_glaa_m_t.* = g_glaa_m.*
   LET g_glaa_m_o.* = g_glaa_m.*
   
   
   #重新顯示   
   CALL agli171_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.insert" >}
#+ 資料新增
PRIVATE FUNCTION agli171_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_glca_d.clear()   
   CALL g_glca2_d.clear()  
   CALL g_glca3_d.clear()  
 
 
   INITIALIZE g_glaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_glaald_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glaa_m.glaastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_glaa_m.glaa014 = "N"
      LET g_glaa_m.glaa008 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_glaa_m.glaastus = "Y"
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_glaa_m_t.* = g_glaa_m.*
      LET g_glaa_m_o.* = g_glaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glaa_m.glaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL agli171_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_glaa_m.* TO NULL
         INITIALIZE g_glca_d TO NULL
         INITIALIZE g_glca2_d TO NULL
         INITIALIZE g_glca3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL agli171_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_glca_d.clear()
      #CALL g_glca2_d.clear()
      #CALL g_glca3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agli171_set_act_visible()   
   CALL agli171_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_glaald_t = g_glaa_m.glaald
 
   
   #組合新增資料的條件
   LET g_add_browse = " glaaent = " ||g_enterprise|| " AND",
                      " glaald = '", g_glaa_m.glaald, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   IF NOT cl_null(g_add_browse) AND g_wc=" 1=2" THEN
      LET g_wc = " 1=1"
   END IF
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli171_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE agli171_cl
   
   CALL agli171_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agli171_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus,g_glaa_m.glaald_desc,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaacomp_desc,g_glaa_m.glaa004_desc
   
   
   #遮罩相關處理
   LET g_glaa_m_mask_o.* =  g_glaa_m.*
   CALL agli171_glaa_t_mask()
   LET g_glaa_m_mask_n.* =  g_glaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaald_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa004,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaastus
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL agli171_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.modify" >}
#+ 資料修改
PRIVATE FUNCTION agli171_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_pass           LIKE type_t.num5  #160811-00039#6 add
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_glaa_m_t.* = g_glaa_m.*
   LET g_glaa_m_o.* = g_glaa_m.*
   
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_glaald_t = g_glaa_m.glaald
 
   CALL s_transaction_begin()
   
   OPEN agli171_cl USING g_enterprise,g_glaa_m.glaald
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli171_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli171_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus,g_glaa_m.glaald_desc,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaacomp_desc,g_glaa_m.glaa004_desc
   
   #檢查是否允許此動作
   IF NOT agli171_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_glaa_m_mask_o.* =  g_glaa_m.*
   CALL agli171_glaa_t_mask()
   LET g_glaa_m_mask_n.* =  g_glaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   #160811-00039#6--add--str--
   CALL s_ld_chk_authorization(g_user,g_glaa_m.glaald) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glaa_m.glaald
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160811-00039#6--add--end
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL agli171_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_glaald_t = g_glaa_m.glaald
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      #add-point:modify段修改前 name="modify.before_input"
      CALL s_transaction_end('N','0')
      CALL s_transaction_begin()
      
      IF NOT s_ld_chk_authorization(g_user,g_glaa_m.glaald) THEN
	     INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "axr-00022"
        LET g_errparam.extend = g_glaa_m.glaald
        LET g_errparam.popup = TRUE
        CALL cl_err()

	     CALL s_transaction_end('N','0')
	     RETURN
	  END IF
      IF g_glaa_m.glaa014 = 'N' AND g_glaa_m.glaa008 = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00128'
         LET g_errparam.extend = g_glaa_m.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      IF g_glaa_m.glaastus <> 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00136'
         LET g_errparam.extend = g_glaa_m.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      CALL agli171_ref_details()
      IF g_success = 'Y' THEN
         CALL s_transaction_begin()
      ELSE
         RETURN
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL agli171_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_glaa_m.* = g_glaa_m_t.*
            CALL agli171_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_glaa_m.glaald != g_glaa_m_t.glaald
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE glca_t SET glcald = g_glaa_m.glaald
 
          WHERE glcaent = g_enterprise AND glcald = g_glaa_m_t.glaald
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "glca_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glca_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE glab_t
            SET glabld = g_glaa_m.glaald
 
          WHERE glabent = g_enterprise AND
                glabld = g_glaald_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "glab_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE glcd_t
            SET glcdld = g_glaa_m.glaald
 
          WHERE glcdent = g_enterprise AND
                glcdld = g_glaald_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "glcd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agli171_set_act_visible()   
   CALL agli171_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glaaent = " ||g_enterprise|| " AND",
                      " glaald = '", g_glaa_m.glaald, "' "
 
   #填到對應位置
   CALL agli171_browser_fill("")
 
   CLOSE agli171_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agli171_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="agli171.input" >}
#+ 資料輸入
PRIVATE FUNCTION agli171_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
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
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_glaald         LIKE glaa_t.glaald
   DEFINE l_glacstus       LIKE glac_t.glacstus
   DEFINE l_glab005        LIKE glab_t.glab005
   DEFINE l_xradstus       LIKE xrad_t.xradstus
   DEFINE l_glab003        LIKE glab_t.glab003
   DEFINE l_glab006        LIKE glab_t.glab006
   DEFINE l_glac003        LIKE glac_t.glac003
   DEFINE l_glca007       LIKE glca_t.glca007
   DEFINE l_glca006       LIKE glca_t.glca006
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
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaald_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa004,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaastus
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT glca001,glca002,glca003,glca004,glca005 FROM glca_t WHERE glcaent=? AND  
       glcald=? AND glca001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli171_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT glab001,glab002,glab003,glab005,glab011 FROM glab_t WHERE glabent=? AND  
       glabld=? AND glab001=? AND glab002=? AND glab003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli171_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT glcd001,glcdacti FROM glcd_t WHERE glcdent=? AND glcdld=? AND glcd001=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli171_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agli171_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
#   LET l_allow_insert = FALSE
#   LET l_allow_delete = FALSE
   #end add-point
   CALL agli171_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaacomp, 
       g_glaa_m.glaa004,g_glaa_m.glaastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agli171.input.head" >}
      #單頭段
      INPUT BY NAME g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaacomp, 
          g_glaa_m.glaa004,g_glaa_m.glaastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN agli171_cl USING g_enterprise,g_glaa_m.glaald
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agli171_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agli171_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL agli171_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL agli171_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="input.a.glaald"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_glaa_m.glaald) THEN 
               CALL agli171_chk_glaald(g_glaa_m.glaald)
               IF NOT cl_null(g_errno) THEN
                  LET l_glaald = g_glaa_m.glaald
                  LET g_glaa_m.glaald  = ""
                  LET g_glaa_m.glaa014 = 'N'
                  LET g_glaa_m.glaa008 = 'N'
                  LET g_glaa_m.glaacomp= ""
                  LET g_glaa_m.glaa001 = ""
                  LET g_glaa_m.glaa004 = ""
                  LET g_glaa_m.glaastus= ""
                  CLEAR FORM
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = l_glaald
                  #160318-00005#14  --add--str
                  LET g_errparam.replace[1] ='agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog    ='agli010'
                  #160318-00005#14  --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD glaald
               ELSE
#                  LET p_cmd = 'u'
               END IF
            SELECT glaa001,glaa014,glaa008,
                   glaacomp,glaa004,glaastus
              INTO g_glaa_m.glaa001,g_glaa_m.glaa014,g_glaa_m.glaa008,
                   g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus
              FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
             
            SELECT ooail003 INTO g_glaa_m.glaa001_desc FROM ooail_t
             WHERE ooailent= g_enterprise AND ooail001= g_glaa_m.glaa001 AND ooail002=g_dlang

            SELECT ooall004 INTO g_glaa_m.glaa004_desc FROM ooall_t
             WHERE ooallent= g_enterprise AND ooall001='0' AND ooall002= g_glaa_m.glaa004 AND ooall003= g_dlang

            SELECT ooefl003 INTO g_glaa_m.glaacomp_desc FROM ooefl_t 
             WHERE ooeflent= g_enterprise AND ooefl001= g_glaa_m.glaacomp AND ooefl002= g_dlang

            SELECT glaal002 INTO g_glaa_m.glaald_desc FROM glaal_t 
             WHERE glaalent= g_enterprise AND glaalld = g_glaa_m.glaald AND glaal001=g_dlang 
            
            DISPLAY BY NAME g_glaa_m.*
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="input.b.glaald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaald
            #add-point:ON CHANGE glaald name="input.g.glaald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="input.a.glaa001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaa001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaa001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="input.b.glaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa001
            #add-point:ON CHANGE glaa001 name="input.g.glaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa014
            #add-point:BEFORE FIELD glaa014 name="input.b.glaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa014
            
            #add-point:AFTER FIELD glaa014 name="input.a.glaa014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa014
            #add-point:ON CHANGE glaa014 name="input.g.glaa014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa008
            #add-point:BEFORE FIELD glaa008 name="input.b.glaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa008
            
            #add-point:AFTER FIELD glaa008 name="input.a.glaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa008
            #add-point:ON CHANGE glaa008 name="input.g.glaa008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.glaacomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaacomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.glaacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.glaacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004
            
            #add-point:AFTER FIELD glaa004 name="input.a.glaa004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='0' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaa004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaa004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004
            #add-point:BEFORE FIELD glaa004 name="input.b.glaa004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa004
            #add-point:ON CHANGE glaa004 name="input.g.glaa004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaastus
            #add-point:BEFORE FIELD glaastus name="input.b.glaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaastus
            
            #add-point:AFTER FIELD glaastus name="input.a.glaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaastus
            #add-point:ON CHANGE glaastus name="input.g.glaastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="input.c.glaald"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaa_m.glaald             #給予default值
            LET g_qryparam.where    = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaastus = 'Y'"
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                         #呼叫開窗
            LET g_glaa_m.glaald = g_qryparam.return1              #將開窗取得的值回傳到變數
            SELECT glaa001,glaa014,glaa008,
                   glaacomp,glaa004,glaastus
              INTO g_glaa_m.glaa001,g_glaa_m.glaa014,g_glaa_m.glaa008,
                   g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus
              FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
             
            SELECT ooail003 INTO g_glaa_m.glaa001_desc FROM ooail_t
             WHERE ooailent= g_enterprise AND ooail001= g_glaa_m.glaa001 AND ooail002=g_dlang

            SELECT ooall004 INTO g_glaa_m.glaa004_desc FROM ooall_t
             WHERE ooallent= g_enterprise AND ooall001='0' AND ooall002= g_glaa_m.glaa004 AND ooall003= g_dlang

            SELECT ooefl003 INTO g_glaa_m.glaacomp_desc FROM ooefl_t 
             WHERE ooeflent= g_enterprise AND ooefl001= g_glaa_m.glaacomp AND ooefl002= g_dlang

            SELECT glaal002 INTO g_glaa_m.glaald_desc FROM glaal_t 
             WHERE glaalent= g_enterprise AND glaalld = g_glaa_m.glaald AND glaal001=g_dlang 
            
            DISPLAY BY NAME g_glaa_m.*
            
            DISPLAY g_glaa_m.glaald TO glaald                     #顯示到畫面上
            NEXT FIELD glaald   
            #END add-point
 
 
         #Ctrlp:input.c.glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="input.c.glaa001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooai001()                                #呼叫開窗

            LET g_glaa_m.glaa001 = g_qryparam.return1              

            DISPLAY g_glaa_m.glaa001 TO glaa001              #

            NEXT FIELD glaa001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa014
            #add-point:ON ACTION controlp INFIELD glaa014 name="input.c.glaa014"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa008
            #add-point:ON ACTION controlp INFIELD glaa008 name="input.c.glaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.glaacomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaacomp             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef003= 'Y' "
            
            CALL q_ooef001()                                #呼叫開窗

            LET g_glaa_m.glaacomp = g_qryparam.return1              

            DISPLAY g_glaa_m.glaacomp TO glaacomp              #

            NEXT FIELD glaacomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004
            #add-point:ON ACTION controlp INFIELD glaa004 name="input.c.glaa004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooal002()                                #呼叫開窗

            LET g_glaa_m.glaa004 = g_qryparam.return1              

            DISPLAY g_glaa_m.glaa004 TO glaa004              #

            NEXT FIELD glaa004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaastus
            #add-point:ON ACTION controlp INFIELD glaastus name="input.c.glaastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_glaa_m.glaald
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #為了可以用畫面設計器產生畫面，因此使用了glaa_t表做單頭。
               #所以單頭的所有新增、修改、刪除操作，都不對glaa_t做處理做處理
               IF 1=0 THEN
               #end add-point
               
               INSERT INTO glaa_t (glaaent,glaald,glaa001,glaa014,glaa008,glaacomp,glaa004,glaastus)
               VALUES (g_enterprise,g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014,g_glaa_m.glaa008, 
                   g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_glaa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               END IF
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL agli171_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL agli171_b_fill()
                  CALL agli171_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               CALL s_transaction_end('Y','0')
               CALL agli171_insert_details()
               IF g_success = 'Y' THEN
                  CALL agli171_b_fill()
               ELSE
                  NEXT FIELD glaald
               END IF
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #為了可以用畫面設計器產生畫面，因此使用了glaa_t表做單頭。
               #所以單頭的所有新增、修改、刪除操作，都不對glaa_t做處理做處理
               IF 1=0 THEN
               #end add-point
               
               #將遮罩欄位還原
               CALL agli171_glaa_t_mask_restore('restore_mask_o')
               
               UPDATE glaa_t SET (glaald,glaa001,glaa014,glaa008,glaacomp,glaa004,glaastus) = (g_glaa_m.glaald, 
                   g_glaa_m.glaa001,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004, 
                   g_glaa_m.glaastus)
                WHERE glaaent = g_enterprise AND glaald = g_glaald_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "glaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL agli171_glaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_glaa_m_t)
               LET g_log2 = util.JSON.stringify(g_glaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               CALL s_transaction_end('Y','0')
               CALL agli171_insert_details()
               IF g_success = 'Y' THEN
                  CALL agli171_b_fill()
               ELSE
                  NEXT FIELD glaald
               END IF
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_glaald_t = g_glaa_m.glaald
 
            
      END INPUT
   
 
{</section>}
 
{<section id="agli171.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_glca_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glca_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agli171_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_glca_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN agli171_cl USING g_enterprise,g_glaa_m.glaald
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agli171_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agli171_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_glca_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_glca_d[l_ac].glca001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glca_d_t.* = g_glca_d[l_ac].*  #BACKUP
               LET g_glca_d_o.* = g_glca_d[l_ac].*  #BACKUP
               CALL agli171_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL agli171_set_no_entry_b(l_cmd)
               IF NOT agli171_lock_b("glca_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli171_bcl INTO g_glca_d[l_ac].glca001,g_glca_d[l_ac].glca002,g_glca_d[l_ac].glca003, 
                      g_glca_d[l_ac].glca004,g_glca_d[l_ac].glca005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glca_d_t.glca001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glca_d_mask_o[l_ac].* =  g_glca_d[l_ac].*
                  CALL agli171_glca_t_mask()
                  LET g_glca_d_mask_n[l_ac].* =  g_glca_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agli171_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
             SELECT glca006,glca007 INTO l_glca006,l_glca007 FROM glca_t
              WHERE glcaent = g_enterprise
                AND glcald  = g_glaa_m.glaald
                AND glca001 = g_glca_d[l_ac].glca001
             IF NOT cl_null(l_glca006) THEN
                IF l_glca007 > 9 THEN
                   LET g_glca_d[l_ac].lbl_ym = l_glca006 USING '<<<<',"/",l_glca007 USING '<<<<'   
                ELSE
                   LET g_glca_d[l_ac].lbl_ym = l_glca006 USING '<<<<',"/0",l_glca007 USING '<<<<'  
                END IF 
             END IF
#            SELECT gzcbl004 INTO g_glca_d[l_ac].glab001_desc FROM gzcbl_t
#             WHERE gzcbl001 = '8303'
#               AND gzcbl002 = g_glca_d[l_ac].glab001
#               AND gzcbl003 = g_lang
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glca_d[l_ac].* TO NULL 
            INITIALIZE g_glca_d_t.* TO NULL 
            INITIALIZE g_glca_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_glca_d[l_ac].glca004 = "N"
      LET g_glca_d[l_ac].glca005 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_glca_d_t.* = g_glca_d[l_ac].*     #新輸入資料
            LET g_glca_d_o.* = g_glca_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agli171_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL agli171_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glca_d[li_reproduce_target].* = g_glca_d[li_reproduce].*
 
               LET g_glca_d[li_reproduce_target].glca001 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM glca_t 
             WHERE glcaent = g_enterprise AND glcald = g_glaa_m.glaald
 
               AND glca001 = g_glca_d[l_ac].glca001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaa_m.glaald
               LET gs_keys[2] = g_glca_d[g_detail_idx].glca001
               CALL agli171_insert_b('glca_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_glca_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glca_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agli171_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_glaa_m.glaald
 
               LET gs_keys[gs_keys.getLength()+1] = g_glca_d_t.glca001
 
            
               #刪除同層單身
               IF NOT agli171_delete_b('glca_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli171_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agli171_key_delete_b(gs_keys,'glca_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli171_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE agli171_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_glca_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_glca_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca001
            
            #add-point:AFTER FIELD glca001 name="input.a.page1.glca001"
            #此段落由子樣板a05產生
            IF  g_glaa_m.glaald IS NOT NULL AND g_glca_d[g_detail_idx].glca001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glaa_m.glaald != g_glaald_t OR g_glca_d[g_detail_idx].glca001 != g_glca_d_t.glca001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glca_t WHERE "||"glcaent = '" ||g_enterprise|| "' AND "||"glcald = '"||g_glaa_m.glaald ||"' AND "|| "glca001 = '"||g_glca_d[g_detail_idx].glca001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glca_d[l_ac].glca001
            CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='8303' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_glca_d[l_ac].glca001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glca_d[l_ac].glca001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca001
            #add-point:BEFORE FIELD glca001 name="input.b.page1.glca001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glca001
            #add-point:ON CHANGE glca001 name="input.g.page1.glca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca002
            #add-point:BEFORE FIELD glca002 name="input.b.page1.glca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca002
            
            #add-point:AFTER FIELD glca002 name="input.a.page1.glca002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glca002
            #add-point:ON CHANGE glca002 name="input.g.page1.glca002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca003
            #add-point:BEFORE FIELD glca003 name="input.b.page1.glca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca003
            
            #add-point:AFTER FIELD glca003 name="input.a.page1.glca003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glca003
            #add-point:ON CHANGE glca003 name="input.g.page1.glca003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca004
            #add-point:BEFORE FIELD glca004 name="input.b.page1.glca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca004
            
            #add-point:AFTER FIELD glca004 name="input.a.page1.glca004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glca004
            #add-point:ON CHANGE glca004 name="input.g.page1.glca004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glca005
            #add-point:BEFORE FIELD glca005 name="input.b.page1.glca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glca005
            
            #add-point:AFTER FIELD glca005 name="input.a.page1.glca005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glca005
            #add-point:ON CHANGE glca005 name="input.g.page1.glca005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_ym
            #add-point:BEFORE FIELD lbl_ym name="input.b.page1.lbl_ym"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_ym
            
            #add-point:AFTER FIELD lbl_ym name="input.a.page1.lbl_ym"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_ym
            #add-point:ON CHANGE lbl_ym name="input.g.page1.lbl_ym"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca001
            #add-point:ON ACTION controlp INFIELD glca001 name="input.c.page1.glca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glca002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca002
            #add-point:ON ACTION controlp INFIELD glca002 name="input.c.page1.glca002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca003
            #add-point:ON ACTION controlp INFIELD glca003 name="input.c.page1.glca003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca004
            #add-point:ON ACTION controlp INFIELD glca004 name="input.c.page1.glca004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glca005
            #add-point:ON ACTION controlp INFIELD glca005 name="input.c.page1.glca005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.lbl_ym
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_ym
            #add-point:ON ACTION controlp INFIELD lbl_ym name="input.c.page1.lbl_ym"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glca_d[l_ac].* = g_glca_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agli171_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_glca_d[l_ac].glca001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_glca_d[l_ac].* = g_glca_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL agli171_glca_t_mask_restore('restore_mask_o')
      
               UPDATE glca_t SET (glcald,glca001,glca002,glca003,glca004,glca005) = (g_glaa_m.glaald, 
                   g_glca_d[l_ac].glca001,g_glca_d[l_ac].glca002,g_glca_d[l_ac].glca003,g_glca_d[l_ac].glca004, 
                   g_glca_d[l_ac].glca005)
                WHERE glcaent = g_enterprise AND glcald = g_glaa_m.glaald 
 
                  AND glca001 = g_glca_d_t.glca001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_glca_d[l_ac].* = g_glca_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glca_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_glca_d[l_ac].* = g_glca_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaa_m.glaald
               LET gs_keys_bak[1] = g_glaald_t
               LET gs_keys[2] = g_glca_d[g_detail_idx].glca001
               LET gs_keys_bak[2] = g_glca_d_t.glca001
               CALL agli171_update_b('glca_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL agli171_glca_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_glca_d[g_detail_idx].glca001 = g_glca_d_t.glca001 
 
                  ) THEN
                  LET gs_keys[01] = g_glaa_m.glaald
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glca_d_t.glca001
 
                  CALL agli171_key_update_b(gs_keys,'glca_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_glaa_m),util.JSON.stringify(g_glca_d_t)
               LET g_log2 = util.JSON.stringify(g_glaa_m),util.JSON.stringify(g_glca_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL agli171_unlock_b("glca_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glca_d[li_reproduce_target].* = g_glca_d[li_reproduce].*
 
               LET g_glca_d[li_reproduce_target].glca001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glca_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glca_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_glca2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glca2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agli171_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_glca2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glca2_d[l_ac].* TO NULL 
            INITIALIZE g_glca2_d_t.* TO NULL 
            INITIALIZE g_glca2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_glca2_d[l_ac].glab001 = "90"
      LET g_glca2_d[l_ac].glab002 = "30"
      LET g_glca2_d[l_ac].glab011 = "1"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_glca2_d_t.* = g_glca2_d[l_ac].*     #新輸入資料
            LET g_glca2_d_o.* = g_glca2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agli171_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL agli171_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glca2_d[li_reproduce_target].* = g_glca2_d[li_reproduce].*
 
               LET g_glca2_d[li_reproduce_target].glab001 = NULL
               LET g_glca2_d[li_reproduce_target].glab002 = NULL
               LET g_glca2_d[li_reproduce_target].glab003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN agli171_cl USING g_enterprise,g_glaa_m.glaald
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agli171_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agli171_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_glca2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_glca2_d[l_ac].glab001 IS NOT NULL
               AND g_glca2_d[l_ac].glab002 IS NOT NULL
               AND g_glca2_d[l_ac].glab003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_glca2_d_t.* = g_glca2_d[l_ac].*  #BACKUP
               LET g_glca2_d_o.* = g_glca2_d[l_ac].*  #BACKUP
               CALL agli171_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL agli171_set_no_entry_b(l_cmd)
               IF NOT agli171_lock_b("glab_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli171_bcl2 INTO g_glca2_d[l_ac].glab001,g_glca2_d[l_ac].glab002,g_glca2_d[l_ac].glab003, 
                      g_glca2_d[l_ac].glab005,g_glca2_d[l_ac].glab011
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glca2_d_mask_o[l_ac].* =  g_glca2_d[l_ac].*
                  CALL agli171_glab_t_mask()
                  LET g_glca2_d_mask_n[l_ac].* =  g_glca2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agli171_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_glaa_m.glaald
               LET gs_keys[gs_keys.getLength()+1] = g_glca2_d_t.glab001
               LET gs_keys[gs_keys.getLength()+1] = g_glca2_d_t.glab002
               LET gs_keys[gs_keys.getLength()+1] = g_glca2_d_t.glab003
            
               #刪除同層單身
               IF NOT agli171_delete_b('glab_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli171_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agli171_key_delete_b(gs_keys,'glab_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli171_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agli171_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_glca_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_glca2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM glab_t 
             WHERE glabent = g_enterprise AND glabld = g_glaa_m.glaald
               AND glab001 = g_glca2_d[l_ac].glab001
               AND glab002 = g_glca2_d[l_ac].glab002
               AND glab003 = g_glca2_d[l_ac].glab003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaa_m.glaald
               LET gs_keys[2] = g_glca2_d[g_detail_idx].glab001
               LET gs_keys[3] = g_glca2_d[g_detail_idx].glab002
               LET gs_keys[4] = g_glca2_d[g_detail_idx].glab003
               CALL agli171_insert_b('glab_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_glca_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agli171_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glca2_d[l_ac].* = g_glca2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agli171_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_glca2_d[l_ac].* = g_glca2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL agli171_glab_t_mask_restore('restore_mask_o')
                              
               UPDATE glab_t SET (glabld,glab001,glab002,glab003,glab005,glab011) = (g_glaa_m.glaald, 
                   g_glca2_d[l_ac].glab001,g_glca2_d[l_ac].glab002,g_glca2_d[l_ac].glab003,g_glca2_d[l_ac].glab005, 
                   g_glca2_d[l_ac].glab011) #自訂欄位頁簽
                WHERE glabent = g_enterprise AND glabld = g_glaa_m.glaald
                  AND glab001 = g_glca2_d_t.glab001 #項次 
                  AND glab002 = g_glca2_d_t.glab002
                  AND glab003 = g_glca2_d_t.glab003
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_glca2_d[l_ac].* = g_glca2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_glca2_d[l_ac].* = g_glca2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaa_m.glaald
               LET gs_keys_bak[1] = g_glaald_t
               LET gs_keys[2] = g_glca2_d[g_detail_idx].glab001
               LET gs_keys_bak[2] = g_glca2_d_t.glab001
               LET gs_keys[3] = g_glca2_d[g_detail_idx].glab002
               LET gs_keys_bak[3] = g_glca2_d_t.glab002
               LET gs_keys[4] = g_glca2_d[g_detail_idx].glab003
               LET gs_keys_bak[4] = g_glca2_d_t.glab003
               CALL agli171_update_b('glab_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agli171_glab_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_glca2_d[g_detail_idx].glab001 = g_glca2_d_t.glab001 
                  AND g_glca2_d[g_detail_idx].glab002 = g_glca2_d_t.glab002 
                  AND g_glca2_d[g_detail_idx].glab003 = g_glca2_d_t.glab003 
                  ) THEN
                  LET gs_keys[01] = g_glaa_m.glaald
                  LET gs_keys[gs_keys.getLength()+1] = g_glca2_d_t.glab001
                  LET gs_keys[gs_keys.getLength()+1] = g_glca2_d_t.glab002
                  LET gs_keys[gs_keys.getLength()+1] = g_glca2_d_t.glab003
                  CALL agli171_key_update_b(gs_keys,'glab_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_glaa_m),util.JSON.stringify(g_glca2_d_t)
               LET g_log2 = util.JSON.stringify(g_glaa_m),util.JSON.stringify(g_glca2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001 name="input.b.page2.glab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab001
            
            #add-point:AFTER FIELD glab001 name="input.a.page2.glab001"
            #此段落由子樣板a05產生
            IF  g_glaa_m.glaald IS NOT NULL AND g_glca2_d[g_detail_idx].glab001 IS NOT NULL AND g_glca2_d[g_detail_idx].glab002 IS NOT NULL AND g_glca2_d[g_detail_idx].glab003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glaa_m.glaald != g_glaald_t OR g_glca2_d[g_detail_idx].glab001 != g_glca2_d_t.glab001 OR g_glca2_d[g_detail_idx].glab002 != g_glca2_d_t.glab002 OR g_glca2_d[g_detail_idx].glab003 != g_glca2_d_t.glab003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glaa_m.glaald ||"' AND "|| "glab001 = '"||g_glca2_d[g_detail_idx].glab001 ||"' AND "|| "glab002 = '"||g_glca2_d[g_detail_idx].glab002 ||"' AND "|| "glab003 = '"||g_glca2_d[g_detail_idx].glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab001
            #add-point:ON CHANGE glab001 name="input.g.page2.glab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab002
            #add-point:BEFORE FIELD glab002 name="input.b.page2.glab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab002
            
            #add-point:AFTER FIELD glab002 name="input.a.page2.glab002"
            #此段落由子樣板a05產生
            IF  g_glaa_m.glaald IS NOT NULL AND g_glca2_d[g_detail_idx].glab001 IS NOT NULL AND g_glca2_d[g_detail_idx].glab002 IS NOT NULL AND g_glca2_d[g_detail_idx].glab003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glaa_m.glaald != g_glaald_t OR g_glca2_d[g_detail_idx].glab001 != g_glca2_d_t.glab001 OR g_glca2_d[g_detail_idx].glab002 != g_glca2_d_t.glab002 OR g_glca2_d[g_detail_idx].glab003 != g_glca2_d_t.glab003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glaa_m.glaald ||"' AND "|| "glab001 = '"||g_glca2_d[g_detail_idx].glab001 ||"' AND "|| "glab002 = '"||g_glca2_d[g_detail_idx].glab002 ||"' AND "|| "glab003 = '"||g_glca2_d[g_detail_idx].glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab002
            #add-point:ON CHANGE glab002 name="input.g.page2.glab002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003
            
            #add-point:AFTER FIELD glab003 name="input.a.page2.glab003"
            #此段落由子樣板a05產生
            IF  g_glaa_m.glaald IS NOT NULL AND g_glca2_d[g_detail_idx].glab001 IS NOT NULL AND g_glca2_d[g_detail_idx].glab002 IS NOT NULL AND g_glca2_d[g_detail_idx].glab003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glaa_m.glaald != g_glaald_t OR g_glca2_d[g_detail_idx].glab001 != g_glca2_d_t.glab001 OR g_glca2_d[g_detail_idx].glab002 != g_glca2_d_t.glab002 OR g_glca2_d[g_detail_idx].glab003 != g_glca2_d_t.glab003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glaa_m.glaald ||"' AND "|| "glab001 = '"||g_glca2_d[g_detail_idx].glab001 ||"' AND "|| "glab002 = '"||g_glca2_d[g_detail_idx].glab002 ||"' AND "|| "glab003 = '"||g_glca2_d[g_detail_idx].glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glca2_d[l_ac].glab003
            CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='8318' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_glca2_d[l_ac].glab003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glca2_d[l_ac].glab003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003 name="input.b.page2.glab003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab003
            #add-point:ON CHANGE glab003 name="input.g.page2.glab003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="input.a.page2.glab005"
            
            #160513-00008#1--add--str--
            #8318_13 "外幣銀存重評價存提碼別"和8318_14 "外幣票據重評價存提碼別"
            IF g_glca2_d[l_ac].glab003='8318_13' OR g_glca2_d[l_ac].glab003='8318_14' THEN
               IF NOT cl_null(g_glca2_d[l_ac].glab005) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_glca2_d[l_ac].glab005
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmaj001") THEN
                     #檢查失敗時後續處理
                     LET g_glca2_d[l_ac].glab005 = g_glca2_d_t.glab005 
                     CALL s_desc_get_nmajl003_desc(g_glca2_d[l_ac].glab005) RETURNING g_glca2_d[l_ac].glab005_desc
                     DISPLAY BY NAME g_glca2_d[l_ac].glab005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_nmajl003_desc(g_glca2_d[l_ac].glab005) RETURNING g_glca2_d[l_ac].glab005_desc
               DISPLAY BY NAME g_glca2_d[l_ac].glab005_desc
            ELSE
            #160513-00008#1--add--end
               #科目
               IF NOT cl_null(g_glca2_d[l_ac].glab005) THEN
                  # 开窗模糊查询 150916-00015#1 --add                      
                  IF s_aglt310_getlike_lc_subject(g_glaa_m.glaald,g_glca2_d[l_ac].glab005,"")  THEN            
                                      
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = 'FALSE'
                     LET g_qryparam.default1 = g_glca2_d[l_ac].glab005
                                   
                     LET g_qryparam.arg1 = g_glaa_m.glaa004
                     LET g_qryparam.arg2 = g_glca2_d[l_ac].glab005
                     LET g_qryparam.arg3 = g_glaa_m.glaald
                     LET g_qryparam.arg4 = " 1"
                     CALL q_glac002_6()
                     LET  g_glca2_d[l_ac].glab005 = g_qryparam.return1 
                     SELECT glacl004 INTO g_glca2_d[l_ac].glab005_desc FROM glacl_t
                      WHERE glaclent = g_enterprise AND glacl001 = g_glaa_m.glaa004
                        AND glacl002 = g_glca2_d[l_ac].glab005
                        AND glacl003 = g_lang
                   
                     DISPLAY g_glca2_d[l_ac].glab005 TO glab005              #顯示到畫面上               
                  END IF
                  # 150916-00015#1 --end
                  #151117-00009#1--mod--str--
                  #科目存在性，有效性，非统治科目，账户科目属性检查
                  CALL s_voucher_glaq002_chk(g_glaa_m.glaald,g_glca2_d[l_ac].glab005)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glca2_d[l_ac].glab005
                     #160321-00016#28 --s add
                     LET g_errparam.replace[1] = 'agli030'
                     LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                     LET g_errparam.exeprog = 'agli030'
                     #160321-00016#28 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_glca2_d[l_ac].glab005 = g_glca2_d_t.glab005
                     CALL s_desc_get_account_desc(g_glaa_m.glaald,g_glca2_d[l_ac].glab005) RETURNING g_glca2_d[l_ac].glab005_desc
                     DISPLAY BY NAME g_glca2_d[l_ac].glab005_desc
                     NEXT FIELD CURRENT                  
                  END IF
#               SELECT glacstus,glac003 INTO l_glacstus,l_glac003 FROM glac_t
#                WHERE glacent = g_enterprise
#                  AND glac001 = g_glaa_m.glaa004
#                  AND glac002 = g_glca2_d[l_ac].glab005
#               CASE
#                  WHEN SQLCA.SQLCODE
#                     LET l_glab005 = g_glca2_d[l_ac].glab005
#                     LET g_glca2_d[l_ac].glab005 = g_glca2_d_t.glab005
#                     LET g_glca2_d[l_ac].glab005_desc = Null
#                     SELECT glacl004 INTO g_glca2_d[l_ac].glab005_desc FROM glacl_t
#                      WHERE glaclent = g_enterprise AND glacl001 = g_glaa_m.glaa004
#                        AND glacl002 = g_glca2_d[l_ac].glab005 AND glacl003 = g_dlang
#                     DISPLAY g_glca2_d[l_ac].glab005,g_glca2_d[l_ac].glab005_desc TO s_detail2[l_ac].glab005,s_detail2[l_ac].glab005_desc
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'agl-00011'
#                     LET g_errparam.extend = l_glab005
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     NEXT FIELD glab005
#                  WHEN l_glacstus = 'N'
#                     LET l_glab005 = g_glca2_d[l_ac].glab005
#                     LET g_glca2_d[l_ac].glab005 = g_glca2_d_t.glab005
#                     LET g_glca2_d[l_ac].glab005_desc = Null
#                     SELECT glacl004 INTO g_glca2_d[l_ac].glab005_desc FROM glacl_t
#                      WHERE glaclent = g_enterprise AND glacl001 = g_glaa_m.glaa004
#                        AND glacl002 = g_glca2_d[l_ac].glab005 AND glacl003 = g_dlang
#                     DISPLAY g_glca2_d[l_ac].glab005,g_glca2_d[l_ac].glab005_desc TO s_detail2[l_ac].glab005,s_detail2[l_ac].glab005_desc
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'sub-01302'  #'agl-00012'
#                     LET g_errparam.extend = l_glab005
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     NEXT FIELD glab005
#                  WHEN l_glac003 = '1'
#                     LET l_glab005 = g_glca2_d[l_ac].glab005
#                     LET g_glca2_d[l_ac].glab005 = g_glca2_d_t.glab005
#                     LET g_glca2_d[l_ac].glab005_desc = Null
#                     SELECT glacl004 INTO g_glca2_d[l_ac].glab005_desc FROM glacl_t
#                      WHERE glaclent = g_enterprise AND glacl001 = g_glaa_m.glaa004
#                        AND glacl002 = g_glca2_d[l_ac].glab005 AND glacl003 = g_lang
#                     DISPLAY g_glca2_d[l_ac].glab005,g_glca2_d[l_ac].glab005_desc TO s_detail2[l_ac].glab005,s_detail2[l_ac].glab005_desc
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'agl-00013'
#                     LET g_errparam.extend = l_glab005
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     NEXT FIELD glab005
#               END CASE
               #151117-00009#1--mod--end
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa004
            LET g_ref_fields[2] = g_glca2_d[l_ac].glab005
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glca2_d[l_ac].glab005_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_glca2_d[l_ac].glab005_desc TO s_detail2[l_ac].glab005_desc
         END IF  #160513-00008#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="input.b.page2.glab005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005
            #add-point:ON CHANGE glab005 name="input.g.page2.glab005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005_desc
            #add-point:BEFORE FIELD glab005_desc name="input.b.page2.glab005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005_desc
            
            #add-point:AFTER FIELD glab005_desc name="input.a.page2.glab005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005_desc
            #add-point:ON CHANGE glab005_desc name="input.g.page2.glab005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011 name="input.b.page2.glab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab011
            
            #add-point:AFTER FIELD glab011 name="input.a.page2.glab011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab011
            #add-point:ON CHANGE glab011 name="input.g.page2.glab011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.glab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001 name="input.c.page2.glab001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab002
            #add-point:ON ACTION controlp INFIELD glab002 name="input.c.page2.glab002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003 name="input.c.page2.glab003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="input.c.page2.glab005"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glca2_d[l_ac].glab005             #給予default值
            #160513-00008#1--add--str--
            #8318_13 "外幣銀存重評價存提碼別"和8318_14 "外幣票據重評價存提碼別"
            IF g_glca2_d[l_ac].glab003='8318_13' OR g_glca2_d[l_ac].glab003='8318_14' THEN
               CALL q_nmaj001()
               LET g_glca2_d[l_ac].glab005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            ELSE
            #160513-00008#1--add--end
               #給予arg
               LET g_qryparam.where = "glac001 = '",g_glaa_m.glaa004,"' AND  glac003 <>'1'",
                                      #151117-00009#1--add--str--
                                      " AND glac006='1' ",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                      "                  WHERE gladent=",g_enterprise," AND gladld='",g_glaa_m.glaald,"'",
                                      "                    AND gladstus='Y' )"
                                      #151117-00009#1--add--end
               
               CALL aglt310_04()                                #呼叫開窗
               
               LET g_glca2_d[l_ac].glab005 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               SELECT glacl004 INTO g_glca2_d[l_ac].glab005_desc FROM glacl_t
                WHERE glaclent = g_enterprise AND glacl001 = g_glaa_m.glaa004
                  AND glacl002 = g_glca2_d[l_ac].glab005
                  AND glacl003 = g_lang
            END IF #160513-00008#1 add
            
            DISPLAY g_glca2_d[l_ac].glab005 TO glab005              #顯示到畫面上

            NEXT FIELD glab005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.glab005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005_desc
            #add-point:ON ACTION controlp INFIELD glab005_desc name="input.c.page2.glab005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011 name="input.c.page2.glab011"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glca2_d[l_ac].* = g_glca2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agli171_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agli171_unlock_b("glab_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glca2_d[li_reproduce_target].* = g_glca2_d[li_reproduce].*
 
               LET g_glca2_d[li_reproduce_target].glab001 = NULL
               LET g_glca2_d[li_reproduce_target].glab002 = NULL
               LET g_glca2_d[li_reproduce_target].glab003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_glca2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glca2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_glca3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glca3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agli171_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_glca3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glca3_d[l_ac].* TO NULL 
            INITIALIZE g_glca3_d_t.* TO NULL 
            INITIALIZE g_glca3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_glca3_d[l_ac].glcdacti = "Y"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_glca3_d_t.* = g_glca3_d[l_ac].*     #新輸入資料
            LET g_glca3_d_o.* = g_glca3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agli171_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL agli171_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glca3_d[li_reproduce_target].* = g_glca3_d[li_reproduce].*
 
               LET g_glca3_d[li_reproduce_target].glcd001 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN agli171_cl USING g_enterprise,g_glaa_m.glaald
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agli171_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agli171_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_glca3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_glca3_d[l_ac].glcd001 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_glca3_d_t.* = g_glca3_d[l_ac].*  #BACKUP
               LET g_glca3_d_o.* = g_glca3_d[l_ac].*  #BACKUP
               CALL agli171_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL agli171_set_no_entry_b(l_cmd)
               IF NOT agli171_lock_b("glcd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli171_bcl3 INTO g_glca3_d[l_ac].glcd001,g_glca3_d[l_ac].glcdacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glca3_d_mask_o[l_ac].* =  g_glca3_d[l_ac].*
                  CALL agli171_glcd_t_mask()
                  LET g_glca3_d_mask_n[l_ac].* =  g_glca3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agli171_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_glaa_m.glaald
               LET gs_keys[gs_keys.getLength()+1] = g_glca3_d_t.glcd001
            
               #刪除同層單身
               IF NOT agli171_delete_b('glcd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli171_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agli171_key_delete_b(gs_keys,'glcd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agli171_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agli171_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_glca_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_glca3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
         IF l_cmd = 'a' THEN
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM glcd_t 
             WHERE glcdent = g_enterprise AND glcdld = g_glaa_m.glaald
               AND glcd001 = g_glca3_d[l_ac].glcd001
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaa_m.glaald
               LET gs_keys[2] = g_glca3_d[g_detail_idx].glcd001
               CALL agli171_insert_b('glcd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_glca_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agli171_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               CALL s_transaction_end('Y','0')
               LET g_rec_b = g_rec_b + 1
            END IF 
         ELSE
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glca3_d[l_ac].* = g_glca3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agli171_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_glca3_d[l_ac].* = g_glca3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL agli171_glcd_t_mask_restore('restore_mask_o')
                              
               UPDATE glcd_t SET (glcdld,glcd001,glcdacti) = (g_glaa_m.glaald,g_glca3_d[l_ac].glcd001, 
                   g_glca3_d[l_ac].glcdacti) #自訂欄位頁簽
                WHERE glcdent = g_enterprise AND glcdld = g_glaa_m.glaald
                  AND glcd001 = g_glca3_d_t.glcd001 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_glca3_d[l_ac].* = g_glca3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glcd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_glca3_d[l_ac].* = g_glca3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glcd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaa_m.glaald
               LET gs_keys_bak[1] = g_glaald_t
               LET gs_keys[2] = g_glca3_d[g_detail_idx].glcd001
               LET gs_keys_bak[2] = g_glca3_d_t.glcd001
               CALL agli171_update_b('glcd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agli171_glcd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_glca3_d[g_detail_idx].glcd001 = g_glca3_d_t.glcd001 
                  ) THEN
                  LET gs_keys[01] = g_glaa_m.glaald
                  LET gs_keys[gs_keys.getLength()+1] = g_glca3_d_t.glcd001
                  CALL agli171_key_update_b(gs_keys,'glcd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_glaa_m),util.JSON.stringify(g_glca3_d_t)
               LET g_log2 = util.JSON.stringify(g_glaa_m),util.JSON.stringify(g_glca3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glcd001
            
            #add-point:AFTER FIELD glcd001 name="input.a.page3.glcd001"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_glaa_m.glaald IS NOT NULL AND g_glca3_d[g_detail_idx].glcd001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glaa_m.glaald != g_glaald_t OR g_glca3_d[g_detail_idx].glcd001 != g_glca3_d_t.glcd001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glcd_t WHERE "||"glcdent = '" ||g_enterprise|| "' AND "||"glcdld = '"||g_glaa_m.glaald ||"' AND "|| "glcd001 = '"||g_glca3_d[g_detail_idx].glcd001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glaa_m.glaald,g_glca3_d[g_detail_idx].glcd001,"")  THEN            

                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glca3_d[g_detail_idx].glcd001
                                
                  LET g_qryparam.arg1 = g_glaa_m.glaa004
                  LET g_qryparam.arg2 = g_glca3_d[g_detail_idx].glcd001
                  LET g_qryparam.arg3 = g_glaa_m.glaald
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_glca3_d[g_detail_idx].glcd001  = g_qryparam.return1
                 
               END IF
               # 150916-00015#1 --end
                  #151117-00009#1--add--str--
                  #科目存在性，有效性，非统治科目，账户科目属性检查
                  CALL s_voucher_glaq002_chk(g_glaa_m.glaald,g_glca3_d[g_detail_idx].glcd001)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glca3_d[g_detail_idx].glcd001
                     #160321-00016#28 --s add
                     LET g_errparam.replace[1] = 'agli030'
                     LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                     LET g_errparam.exeprog = 'agli030'
                     #160321-00016#28 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_glca3_d[g_detail_idx].glcd001 = g_glca3_d_t.glcd001
                     CALL s_desc_get_account_desc(g_glaa_m.glaald,g_glca3_d[g_detail_idx].glcd001) RETURNING g_glca3_d[g_detail_idx].glcd001_desc
                     DISPLAY BY NAME g_glca3_d[g_detail_idx].glcd001_desc
                     NEXT FIELD CURRENT                  
                  END IF
                  #151117-00009#1--add--end
                  CALL agli171_glcd001_chk(g_glca3_d[g_detail_idx].glcd001)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glca3_d[g_detail_idx].glcd001
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #151117-00009#1--add--str--
                     LET g_glca3_d[g_detail_idx].glcd001 = g_glca3_d_t.glcd001
                     CALL s_desc_get_account_desc(g_glaa_m.glaald,g_glca3_d[g_detail_idx].glcd001) RETURNING g_glca3_d[g_detail_idx].glcd001_desc
                     DISPLAY BY NAME g_glca3_d[g_detail_idx].glcd001_desc
                     #151117-00009#1--add--end
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa004
            LET g_ref_fields[2] = g_glca3_d[g_detail_idx].glcd001
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glca3_d[g_detail_idx].glcd001_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_glca3_d[g_detail_idx].glcd001_desc TO s_detail3[l_ac].glcd001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glcd001
            #add-point:BEFORE FIELD glcd001 name="input.b.page3.glcd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glcd001
            #add-point:ON CHANGE glcd001 name="input.g.page3.glcd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glcd001_desc
            #add-point:BEFORE FIELD glcd001_desc name="input.b.page3.glcd001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glcd001_desc
            
            #add-point:AFTER FIELD glcd001_desc name="input.a.page3.glcd001_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glcd001_desc
            #add-point:ON CHANGE glcd001_desc name="input.g.page3.glcd001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glcdacti
            #add-point:BEFORE FIELD glcdacti name="input.b.page3.glcdacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glcdacti
            
            #add-point:AFTER FIELD glcdacti name="input.a.page3.glcdacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glcdacti
            #add-point:ON CHANGE glcdacti name="input.g.page3.glcdacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.glcd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glcd001
            #add-point:ON ACTION controlp INFIELD glcd001 name="input.c.page3.glcd001"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glca3_d[l_ac].glcd001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = "glac001 = '",g_glaa_m.glaa004,"' AND  glac003 <>'1' ",
                                   #151117-00009#1--add--str--
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glaa_m.glaald,"'",
                                   "                    AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            
            CALL aglt310_04()                                #呼叫開窗
            #多選科目依次插入glcd_t
            CALL agli171_insert_glcd(g_qryparam.return1)
            CALL agli171_b_fill()
            IF g_glca3_d.getLength() >= l_ac 
               AND g_glca3_d[l_ac].glcd001 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_glca3_d_t.* = g_glca3_d[l_ac].*  #BACKUP
               LET g_glca3_d_o.* = g_glca3_d[l_ac].*  #BACKUP
            END IF
#            LET g_glca3_d[l_ac].glcd001 = g_qryparam.return1              
#
#            DISPLAY g_glca3_d[l_ac].glcd001 TO glcd001              #

            NEXT FIELD glcd001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.glcd001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glcd001_desc
            #add-point:ON ACTION controlp INFIELD glcd001_desc name="input.c.page3.glcd001_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.glcdacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glcdacti
            #add-point:ON ACTION controlp INFIELD glcdacti name="input.c.page3.glcdacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glca3_d[l_ac].* = g_glca3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agli171_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agli171_unlock_b("glcd_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glca3_d[li_reproduce_target].* = g_glca3_d[li_reproduce].*
 
               LET g_glca3_d[li_reproduce_target].glcd001 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_glca3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glca3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="agli171.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD glaald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glca001
               WHEN "s_detail2"
                  NEXT FIELD glab001
               WHEN "s_detail3"
                  NEXT FIELD glcd001
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
 
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   CALL agli171_b_fill()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agli171_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL agli171_b_fill() #單身填充
      CALL agli171_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agli171_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_glaa_m_mask_o.* =  g_glaa_m.*
   CALL agli171_glaa_t_mask()
   LET g_glaa_m_mask_n.* =  g_glaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaald_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa004,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaastus
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glaa_m.glaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glca_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_glca2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_glca3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL agli171_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION agli171_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agli171_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE glaa_t.glaald 
   DEFINE l_oldno     LIKE glaa_t.glaald 
 
   DEFINE l_master    RECORD LIKE glaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glca_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE glab_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE glcd_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_glaald_t = g_glaa_m.glaald
 
    
   LET g_glaa_m.glaald = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glaa_m.glaastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glaa_m.glaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_glaa_m.glaald_desc = ''
   DISPLAY BY NAME g_glaa_m.glaald_desc
 
   
   CALL agli171_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_glaa_m.* TO NULL
      INITIALIZE g_glca_d TO NULL
      INITIALIZE g_glca2_d TO NULL
      INITIALIZE g_glca3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL agli171_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agli171_set_act_visible()   
   CALL agli171_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_glaald_t = g_glaa_m.glaald
 
   
   #組合新增資料的條件
   LET g_add_browse = " glaaent = " ||g_enterprise|| " AND",
                      " glaald = '", g_glaa_m.glaald, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli171_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL agli171_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL agli171_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agli171_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glca_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE glab_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE glcd_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agli171_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glca_t
    WHERE glcaent = g_enterprise AND glcald = g_glaald_t
 
    INTO TEMP agli171_detail
 
   #將key修正為調整後   
   UPDATE agli171_detail 
      #更新key欄位
      SET glcald = g_glaa_m.glaald
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #2015/6/3--by--02599--add--str--
   #更新重评价年度=NULL，月份=NULL
   UPDATE agli171_detail 
      SET glca006 = NULL,glca007=NULL
   #2015/6/3--by--02599--add--end--
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO glca_t SELECT * FROM agli171_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agli171_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glab_t 
    WHERE glabent = g_enterprise AND glabld = g_glaald_t
 
    INTO TEMP agli171_detail
 
   #將key修正為調整後   
   UPDATE agli171_detail SET glabld = g_glaa_m.glaald
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO glab_t SELECT * FROM agli171_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agli171_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glcd_t 
    WHERE glcdent = g_enterprise AND glcdld = g_glaald_t
 
    INTO TEMP agli171_detail
 
   #將key修正為調整後   
   UPDATE agli171_detail SET glcdld = g_glaa_m.glaald
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO glcd_t SELECT * FROM agli171_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agli171_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   #2015/6/3--by--02599--add--str--
   #151117-00009#1--mod--str--
#   #删除不属于账套所属科目参照表中的科目
#   DELETE FROM glcd_t 
#    WHERE glcdent = g_enterprise AND glcdld = g_glaa_m.glaald
#      AND glcd001 NOT IN (SELECT glac002 FROM glac_t 
#                           WHERE glacent = g_enterprise
#                             AND glac001 = g_glaa_m.glaa004)
   #删除不属于账套管理科目设定档glad_t中的科目
   DELETE FROM glcd_t 
    WHERE glcdent = g_enterprise AND glcdld = g_glaa_m.glaald
      AND glcd001 NOT IN (SELECT glad001 FROM glad_t 
                           WHERE gladent = g_enterprise
                             AND gladld = g_glaa_m.glaald)
   #151117-00009#1--mod--end
   #2015/6/3--by--02599--add--end--
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glaald_t = g_glaa_m.glaald
 
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agli171_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_pass           LIKE type_t.num5  #160811-00039#6 add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN agli171_cl USING g_enterprise,g_glaa_m.glaald
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli171_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli171_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus,g_glaa_m.glaald_desc,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaacomp_desc,g_glaa_m.glaa004_desc
   
   
   #檢查是否允許此動作
   IF NOT agli171_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_glaa_m_mask_o.* =  g_glaa_m.*
   CALL agli171_glaa_t_mask()
   LET g_glaa_m_mask_n.* =  g_glaa_m.*
   
   CALL agli171_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #160811-00039#6--add--str--
   CALL s_ld_chk_authorization(g_user,g_glaa_m.glaald) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glaa_m.glaald
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160811-00039#6--add--end
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      CALL s_transaction_end('N','0')
      CALL s_transaction_begin()
      IF NOT s_ld_chk_authorization(g_user,g_glaa_m.glaald) THEN
	      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "axr-00022"
         LET g_errparam.extend = g_glaa_m.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

	      CALL s_transaction_end('N','0')
	      RETURN
	   END IF
      IF g_glaa_m.glaa014 = 'N' AND g_glaa_m.glaa008 = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00128'
         LET g_errparam.extend = g_glaa_m.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      IF g_glaa_m.glaastus <> 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00136'
         LET g_errparam.extend = g_glaa_m.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF 1 = 0 THEN
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agli171_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_glaald_t = g_glaa_m.glaald
 
 
      DELETE FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_glaa_m.glaald,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM glca_t
       WHERE glcaent = g_enterprise AND glcald = g_glaa_m.glaald
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glca_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
     #DELETE FROM glcb_t
     # WHERE glcbent = g_enterprise AND glcbld = g_glaa_m.glaald
     #   
     #IF SQLCA.sqlcode THEN
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.code = SQLCA.sqlcode
     #   LET g_errparam.extend = "glca_t"
     #   LET g_errparam.popup = FALSE
     #   CALL cl_err()
     #
     #   CALL s_transaction_end('N','0')
     #   RETURN
     #END IF  
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      IF 1=0 THEN
      #end add-point
      DELETE FROM glab_t
       WHERE glabent = g_enterprise AND
             glabld = g_glaa_m.glaald
      #add-point:單身刪除中 name="delete.body.m_delete2"
      ELSE
         DELETE FROM glab_t
          WHERE glabent = g_enterprise AND glabld = g_glaa_m.glaald
            AND glab001 = '25'
            AND glab002 = '8318'
      END IF
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM glcd_t
       WHERE glcdent = g_enterprise AND
             glcdld = g_glaa_m.glaald
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_glaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE agli171_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_glca_d.clear() 
      CALL g_glca2_d.clear()       
      CALL g_glca3_d.clear()       
 
     
      CALL agli171_ui_browser_refresh()  
      #CALL agli171_ui_headershow()  
      #CALL agli171_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL agli171_browser_fill("")
         CALL agli171_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE agli171_cl
 
   #功能已完成,通報訊息中心
   CALL agli171_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agli171.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agli171_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glca007       LIKE glca_t.glca007
   DEFINE l_glca006       LIKE glca_t.glca006
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_glca_d.clear()
   CALL g_glca2_d.clear()
   CALL g_glca3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF agli171_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT glca001,glca002,glca003,glca004,glca005 ,t1.gzcbl004 FROM glca_t", 
                
                     " INNER JOIN glaa_t ON glaaent = " ||g_enterprise|| " AND glaald = glcald ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN gzcbl_t t1 ON t1.gzcbl001='8303' AND t1.gzcbl002=glca001 AND t1.gzcbl003='"||g_lang||"' ",
 
                     " WHERE glcaent=? AND glcald=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
      LET g_sql = g_sql," AND glca001 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8303' AND gzcb003 = '8317')"
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY glca_t.glca001"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agli171_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agli171_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glaa_m.glaald   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glaa_m.glaald INTO g_glca_d[l_ac].glca001,g_glca_d[l_ac].glca002, 
          g_glca_d[l_ac].glca003,g_glca_d[l_ac].glca004,g_glca_d[l_ac].glca005,g_glca_d[l_ac].glca001_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT glca006,glca007 INTO l_glca006,l_glca007 FROM glca_t
          WHERE glcaent = g_enterprise
            AND glcald  = g_glaa_m.glaald
            AND glca001 = g_glca_d[l_ac].glca001
         IF NOT cl_null(l_glca006) THEN
            IF l_glca007 > 9 THEN
               LET g_glca_d[l_ac].lbl_ym = l_glca006 USING '<<<<',"/",l_glca007 USING '<<<<'   
            ELSE
               LET g_glca_d[l_ac].lbl_ym = l_glca006 USING '<<<<',"/0",l_glca007 USING '<<<<'  
            END IF
         END IF
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF agli171_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT glab001,glab002,glab003,glab005,glab011 ,t2.gzcbl004 FROM glab_t", 
                
                     " INNER JOIN  glaa_t ON glaaent = " ||g_enterprise|| " AND glaald = glabld ",
 
                     "",
                     
                                    " LEFT JOIN gzcbl_t t2 ON t2.gzcbl001='8318' AND t2.gzcbl002=glab003 AND t2.gzcbl003='"||g_lang||"' ",
 
                     " WHERE glabent=? AND glabld=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
      LET g_sql = g_sql,"  AND glab001 = '25' AND glab002 = '8318'"
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY glab_t.glab001,glab_t.glab002,glab_t.glab003"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agli171_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR agli171_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_glaa_m.glaald   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_glaa_m.glaald INTO g_glca2_d[l_ac].glab001,g_glca2_d[l_ac].glab002, 
          g_glca2_d[l_ac].glab003,g_glca2_d[l_ac].glab005,g_glca2_d[l_ac].glab011,g_glca2_d[l_ac].glab003_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         #160513-00008#1--add--str--
         #8318_13 "外幣銀存重評價存提碼別"和8318_14 "外幣票據重評價存提碼別"
         IF g_glca2_d[l_ac].glab003='8318_13' OR g_glca2_d[l_ac].glab003='8318_14' THEN
            CALL s_desc_get_nmajl003_desc(g_glca2_d[l_ac].glab005) RETURNING g_glca2_d[l_ac].glab005_desc 
         ELSE
         #160513-00008#1--add--end
         SELECT glacl004 INTO g_glca2_d[l_ac].glab005_desc FROM glacl_t
          WHERE glaclent = g_enterprise AND glacl001 = g_glaa_m.glaa004
            AND glacl002 = g_glca2_d[l_ac].glab005 AND glacl003 = g_lang
         END IF #160513-00008#1 add
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF agli171_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT glcd001,glcdacti  FROM glcd_t",   
                     " INNER JOIN  glaa_t ON glaaent = " ||g_enterprise|| " AND glaald = glcdld ",
 
                     "",
                     
                     
                     " WHERE glcdent=? AND glcdld=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY glcd_t.glcd001"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agli171_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR agli171_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_glaa_m.glaald   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_glaa_m.glaald INTO g_glca3_d[l_ac].glcd001,g_glca3_d[l_ac].glcdacti  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_glaa_m.glaa004
         LET g_ref_fields[2] = g_glca3_d[l_ac].glcd001
         CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_glca3_d[l_ac].glcd001_desc = '', g_rtn_fields[1] , ''
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
 
   #end add-point
   
   CALL g_glca_d.deleteElement(g_glca_d.getLength())
   CALL g_glca2_d.deleteElement(g_glca2_d.getLength())
   CALL g_glca3_d.deleteElement(g_glca3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE agli171_pb
   FREE agli171_pb2
 
   FREE agli171_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_glca_d.getLength()
      LET g_glca_d_mask_o[l_ac].* =  g_glca_d[l_ac].*
      CALL agli171_glca_t_mask()
      LET g_glca_d_mask_n[l_ac].* =  g_glca_d[l_ac].*
   END FOR
   
   LET g_glca2_d_mask_o.* =  g_glca2_d.*
   FOR l_ac = 1 TO g_glca2_d.getLength()
      LET g_glca2_d_mask_o[l_ac].* =  g_glca2_d[l_ac].*
      CALL agli171_glab_t_mask()
      LET g_glca2_d_mask_n[l_ac].* =  g_glca2_d[l_ac].*
   END FOR
   LET g_glca3_d_mask_o.* =  g_glca3_d.*
   FOR l_ac = 1 TO g_glca3_d.getLength()
      LET g_glca3_d_mask_o[l_ac].* =  g_glca3_d[l_ac].*
      CALL agli171_glcd_t_mask()
      LET g_glca3_d_mask_n[l_ac].* =  g_glca3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agli171_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM glca_t
       WHERE glcaent = g_enterprise AND
         glcald = ps_keys_bak[1] AND glca001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_glca_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM glab_t
       WHERE glabent = g_enterprise AND
             glabld = ps_keys_bak[1] AND glab001 = ps_keys_bak[2] AND glab002 = ps_keys_bak[3] AND glab003 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_glca2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM glcd_t
       WHERE glcdent = g_enterprise AND
             glcdld = ps_keys_bak[1] AND glcd001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_glca3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agli171_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO glca_t
                  (glcaent,
                   glcald,
                   glca001
                   ,glca002,glca003,glca004,glca005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_glca_d[g_detail_idx].glca002,g_glca_d[g_detail_idx].glca003,g_glca_d[g_detail_idx].glca004, 
                       g_glca_d[g_detail_idx].glca005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glca_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_glca_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO glab_t
                  (glabent,
                   glabld,
                   glab001,glab002,glab003
                   ,glab005,glab011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_glca2_d[g_detail_idx].glab005,g_glca2_d[g_detail_idx].glab011)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_glca2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO glcd_t
                  (glcdent,
                   glcdld,
                   glcd001
                   ,glcdacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_glca3_d[g_detail_idx].glcdacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_glca3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agli171_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
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
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
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
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "glca_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL agli171_glca_t_mask_restore('restore_mask_o')
               
      UPDATE glca_t 
         SET (glcald,
              glca001
              ,glca002,glca003,glca004,glca005) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_glca_d[g_detail_idx].glca002,g_glca_d[g_detail_idx].glca003,g_glca_d[g_detail_idx].glca004, 
                  g_glca_d[g_detail_idx].glca005) 
         WHERE glcaent = g_enterprise AND glcald = ps_keys_bak[1] AND glca001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glca_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glca_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agli171_glca_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "glab_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL agli171_glab_t_mask_restore('restore_mask_o')
               
      UPDATE glab_t 
         SET (glabld,
              glab001,glab002,glab003
              ,glab005,glab011) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_glca2_d[g_detail_idx].glab005,g_glca2_d[g_detail_idx].glab011) 
         WHERE glabent = g_enterprise AND glabld = ps_keys_bak[1] AND glab001 = ps_keys_bak[2] AND glab002 = ps_keys_bak[3] AND glab003 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glab_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agli171_glab_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "glcd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL agli171_glcd_t_mask_restore('restore_mask_o')
               
      UPDATE glcd_t 
         SET (glcdld,
              glcd001
              ,glcdacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_glca3_d[g_detail_idx].glcdacti) 
         WHERE glcdent = g_enterprise AND glcdld = ps_keys_bak[1] AND glcd001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glcd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glcd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agli171_glcd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION agli171_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agli171_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agli171_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL agli171_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "glca_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN agli171_bcl USING g_enterprise,
                                       g_glaa_m.glaald,g_glca_d[g_detail_idx].glca001     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agli171_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "glab_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agli171_bcl2 USING g_enterprise,
                                             g_glaa_m.glaald,g_glca2_d[g_detail_idx].glab001,g_glca2_d[g_detail_idx].glab002, 
                                                 g_glca2_d[g_detail_idx].glab003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agli171_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "glcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agli171_bcl3 USING g_enterprise,
                                             g_glaa_m.glaald,g_glca3_d[g_detail_idx].glcd001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agli171_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agli171_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agli171_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agli171_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agli171_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agli171_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("glaald",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glaald",TRUE)
      CALL cl_set_comp_entry("",TRUE)
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
 
{<section id="agli171.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agli171_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glaald",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("glaald",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agli171_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="agli171.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agli171_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="agli171.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agli171_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli171.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agli171_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli171.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agli171_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   IF g_glaa_m.glaastus <> 'Y' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   END IF 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli171.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agli171_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agli171.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agli171_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " glaald = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "glaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "glca_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "glab_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "glcd_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
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
 
{<section id="agli171.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION agli171_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_pass           LIKE type_t.num5  #160811-00039#6 add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN agli171_cl USING g_enterprise,g_glaa_m.glaald
   IF STATUS THEN
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli171_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE agli171_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus,g_glaa_m.glaald_desc,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaacomp_desc,g_glaa_m.glaa004_desc
   
 
   #檢查是否允許此動作
   IF NOT agli171_action_chk() THEN
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaald_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa004,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaastus
 
   CASE g_glaa_m.glaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   #160811-00039#6--add--str--
   CALL s_ld_chk_authorization(g_user,g_glaa_m.glaald) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glaa_m.glaald
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160811-00039#6--add--end
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_glaa_m.glaastus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_glaa_m.glaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE agli171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_glaa_m.glaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE glaa_t 
      SET (glaastus) 
        = (g_glaa_m.glaastus)     
    WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
 
    
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
      EXECUTE agli171_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaa001,g_glaa_m.glaa014, 
          g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaa004,g_glaa_m.glaastus,g_glaa_m.glaald_desc, 
          g_glaa_m.glaa001_desc,g_glaa_m.glaacomp_desc,g_glaa_m.glaa004_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaald_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa014, 
          g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa004,g_glaa_m.glaa004_desc, 
          g_glaa_m.glaastus
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE agli171_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agli171_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli171.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agli171_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_glca_d.getLength() THEN
         LET g_detail_idx = g_glca_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glca_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glca_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_glca2_d.getLength() THEN
         LET g_detail_idx = g_glca2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glca2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glca2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_glca3_d.getLength() THEN
         LET g_detail_idx = g_glca3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glca3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glca3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agli171_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL agli171_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agli171_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agli171.status_show" >}
PRIVATE FUNCTION agli171_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli171.mask_functions" >}
&include "erp/agl/agli171_mask.4gl"
 
{</section>}
 
{<section id="agli171.signature" >}
   
 
{</section>}
 
{<section id="agli171.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agli171_set_pk_array()
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
   LET g_pk_array[1].values = g_glaa_m.glaald
   LET g_pk_array[1].column = 'glaald'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli171.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="agli171.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agli171_msgcentre_notify(lc_state)
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
   CALL agli171_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli171.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION agli171_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agli171.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 檢查錄入帳別的存在性、有效性、重複性
# Memo...........:
# Usage..........: CALL agli172_chk_glaald()
#                 
# Input parameter: glaald   帳別編號
#                : 
# Return code....: 
#                : 
# Date & Author..: 2013/11/01 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION agli171_chk_glaald(p_glaald)
   DEFINE p_glaald      LIKE glaa_t.glaald
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_glaastus    LIKE glaa_t.glaastus
   DEFINE l_glaa014     LIKE glaa_t.glaa014
   DEFINE l_glaa008     LIKE glaa_t.glaa008
   
   LET g_errno = " "
   
   #判斷輸入帳別的存在性、有效性
   SELECT glaastus,glaa014,glaa008 INTO l_glaastus,l_glaa014,l_glaa008 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_glaald
   CASE
      WHEN SQLCA.SQLCODE
         LET g_errno = "agl-00125" RETURN
      WHEN l_glaastus != 'Y'
#         LET g_errno = "agl-00126" RETURN
          LET g_errno = "sub-01302" RETURN #160318-00005#14 mod
      WHEN l_glaa014 = 'N' AND l_glaa008 = 'N'
         LET g_errno = "agl-00128" RETURN
   END CASE
#160811-00039#6--mark--str--   
#   LET l_cnt = 0
#   SELECT COUNT(*) INTO l_cnt FROM glba_t WHERE glbaent = g_enterprise AND glbald = p_glaald AND glbastus = 'Y'
#   IF l_cnt = 0 THEN
#      LET l_cnt = 0
#      SELECT COUNT(*) INTO l_cnt FROM glbb_t WHERE glbbent = g_enterprise AND glbbld = p_glaald AND glbbstus = 'Y'
#      IF l_cnt > 0 THEN
#         LET l_cnt = 0
#         SELECT COUNT(*) INTO l_cnt
#         FROM glbb_t,ooag_t
#         WHERE glbbent = g_enterprise AND glbbld = p_glaald AND glbbstus = 'Y'
#           AND ooag003 = glbb001 AND ooagent = glbbent AND ooag001 = g_user
#         IF l_cnt = 0 THEN
#            LET g_errno = "axr-00023" RETURN
#            RETURN
#         END IF
#      END IF
#   ELSE
#      LET l_cnt = 0
#      SELECT COUNT(*) INTO l_cnt FROM glba_t WHERE glbaent = g_enterprise AND glbald = p_glaald AND glbastus = 'Y' AND glba001 = g_user
#      IF l_cnt = 0 THEN
#         LET g_errno = "axr-00022" RETURN
#         RETURN
#      END IF
#   END IF
#160811-00039#6--mark--end
#160811-00039#6--add--str--
   #账套权限检查
   IF NOT s_ld_chk_authorization(g_user,p_glaald) THEN 
      LET g_errno = 'agl-00165'
      RETURN        
   END IF               
#160811-00039#6--add--end
   #判斷輸入帳別的重複性
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM glca_t
    WHERE glcaent = g_enterprise
      AND glcald = p_glaald
      AND glcald IN (SELECT DISTINCT glabld FROM glab_t WHERE glabent = g_enterprise AND glab001 = '25' AND glab002 = '8318')  #albireo 150924 add
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      LET g_errno = "std-00004"
   END IF
END FUNCTION
################################################################################
# Descriptions...: 單頭錄入帳別後自動產生glca_t,glab_t表的資料
# Memo...........:
# Usage..........: CALL agli172_insert_details()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2013/10/31 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION agli171_insert_details()
   DEFINE l_sql      STRING
   DEFINE l_ac       LIKE type_t.num5
   DEFINE l_glca001  LIKE glca_t.glca001
   DEFINE l_glcb001  LIKE glcb_t.glcb001
   DEFINE l_glab001  LIKE glab_t.glab001
   DEFINE l_glab002  LIKE glab_t.glab002
   DEFINE l_glab003  LIKE glab_t.glab003

   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8303' AND gzcb003 = '8317'",
               " AND gzcb002 NOT IN (SELECT glca001 FROM glca_t WHERE glcaent=",g_enterprise,
               "                      AND glcald='",g_glaa_m.glaald,"')"
   PREPARE ins_glca_prep FROM l_sql
   DECLARE ins_glca_cur CURSOR FOR ins_glca_prep
   
  #LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8303' AND gzcb004 = '8316'"
  #PREPARE ins_glcb_prep FROM l_sql
  #DECLARE ins_glcb_cur CURSOR FOR ins_glcb_prep
   
   LET l_sql = "SELECT '25','8318',gzcb002 FROM gzcb_t WHERE gzcb001 = '8318' ",
               " AND gzcb002 NOT IN (SELECT glab003 FROM glab_t WHERE glabent=",g_enterprise,
               "                      AND glabld='",g_glaa_m.glaald,"'",
               "                      AND glab001='25' AND glab002='8318' )"   
   
   PREPARE ins_glab_prep FROM l_sql
   DECLARE ins_glab_cur CURSOR FOR ins_glab_prep
   
   CALL s_transaction_begin()
   
   LET g_success = 'Y'
   #批次新增glca_t資料
   #1)将不已存在于glca_t中的项目插入
   FOREACH ins_glca_cur INTO l_glca001
      INSERT INTO glca_t (glcaent,glcald,
                          glca001  ,glca002,glca003,glca004,glca005) 
         VALUES(g_enterprise,g_glaa_m.glaald,
                          l_glca001,'1'    ,''     ,'N'    ,'N')
      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
      END IF
      
   END FOREACH
   
   #2015/6/3--by--02599--add--str--
   #2)将不存在于scc=8303中的项目删除
   DELETE FROM glca_t 
    WHERE glcaent=g_enterprise AND glcald=g_glaa_m.glaald
      AND glca001 NOT IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8303' AND gzcb003 = '8317')
   IF SQLCA.SQLCODE THEN
      LET g_success = 'N'
   END IF
   #2015/6/3--by--02599--add--end
   
#  #批次新增glcb_t資料
#  FOREACH ins_glcb_cur INTO l_glcb001
#  
#     INSERT INTO glcb_t (glcbent  ,glcbld,
#                         glcb001  ,glcb002,glcb003,glcb004,glcb005,glcb006,glcb007,glcb008) 
#        VALUES(g_enterprise,g_glaa_m.glaald,
#                         l_glcb001,'1'    ,''     ,1      ,''     ,'','N','1')
#     IF SQLCA.SQLCODE THEN
#        LET g_success = 'N'
#     END IF
#  
#  END FOREACH
   
   #批次新增glab_t資料
   #1)将不已存在于glab_t中的项目插入
   FOREACH ins_glab_cur INTO l_glab001,l_glab002,l_glab003
   
      INSERT INTO glab_t (glabent,glabld,
                          glab001  ,glab002  ,glab003  ,glab004,glab005,glab006,
                          glab007  ,glab008  ,glab009  ,glab010,glab011) 
         VALUES(g_enterprise,g_glaa_m.glaald,
                          l_glab001,l_glab002,l_glab003,''     ,''     ,''     ,
                          ''       ,''       ,''       ,''     ,'1')
      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
      END IF
   
   END FOREACH
   
   #2015/6/3--by--02599--add--str--
   #2)将不存在于scc=8318中的项目删除
   DELETE FROM glab_t 
    WHERE glabent=g_enterprise AND glabld=g_glaa_m.glaald
      AND glab001='25' AND glab002='8318'
      AND glab003 NOT IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8318' )
   IF SQLCA.SQLCODE THEN
      LET g_success = 'N'
   END IF
   #2015/6/3--by--02599--add--end
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
END FUNCTION
################################################################################
# Descriptions...: glcb_t,glab_t資料與SCC碼對比,多出來的刪掉,少的新增
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
PRIVATE FUNCTION agli171_ref_details()
   DEFINE l_sql      STRING
   DEFINE l_glcb001  LIKE glcb_t.glcb001
   DEFINE l_glab003  LIKE glab_t.glab003
   DEFINE l_a        LIKE type_t.chr1  #資料存在於agli171中
   DEFINE l_b        LIKE type_t.chr1  #資料存在於azzi600中
   
   CALL s_transaction_begin()
   
   LET g_success = 'Y'
 # #查詢出glcb_t中存在、gzcb_t中存在的資料
 # #a = 1,b = 1時不處理
 # #a = 1,b =''時刪除
 # #a ='',b = 1時新增
 # LET l_sql = "  SELECT scc, AVG (a), AVG (b)                         ",
 #             "    FROM (SELECT glcb001 scc, '1' a, '' b              ",
 #             "            FROM glcb_t                                ",
 #             "           WHERE glcbent = '",g_enterprise,"' AND glcbld = '",g_glaa_m.glaald,"'",
 #             "          UNION                                        ",
 #             "          SELECT gzcb002 scc, '' a, '1' b              ",
 #             "            FROM gzcb_t                                ",
 #             "           WHERE gzcb001 = '8303' AND gzcb004 = '8316')",
 #             "GROUP BY scc"
 # PREPARE agli171_ref_prep FROM l_sql
 # DECLARE agli171_ref_glcb CURSOR FOR agli171_ref_prep
 # 
 # LET l_glcb001 = Null
 # LET l_a = Null
 # LET l_b = Null
 # FOREACH agli171_ref_glcb INTO l_glcb001,l_a,l_b
 #    IF l_a = '1' AND l_b = '1' THEN CONTINUE FOREACH END IF
 #    IF l_a = '1' THEN
 #       DELETE FROM glcb_t WHERE glcbent = g_enterprise
 #                            AND glcbld  = g_glaa_m.glaald
 #                            AND glcb001 = l_glcb001
 #       IF SQLCA.SQLCODE THEN
 #          LET g_success = 'N'
 #       END IF
 #    END IF
 #    IF l_b = '1' THEN
 #       INSERT INTO glcb_t (glcbent  ,glcbld,
 #                           glcb001  ,glcb002,glcb003,glcb004,glcb005,glcb006,glcb007,glcb008) 
 #          VALUES(g_enterprise,g_glaa_m.glaald,
 #                           l_glcb001,'1'    ,''     ,1      ,''     ,'','N','1')
 #       IF SQLCA.SQLCODE THEN
 #          LET g_success = 'N'
 #       END IF
 #    END IF
 # END FOREACH
   
   #查詢出glab_t中存在、gzcb_t中存在的資料
   #a = 1,b = 1時不處理
   #a = 1,b =''時刪除
   #a ='',b = 1時新增
   LET l_sql = "  SELECT scc, AVG (a), AVG (b)                         ",
               "    FROM (SELECT glab003 scc, '1' a, '' b              ",
               "            FROM glab_t                                ",
               "           WHERE glabent = '",g_enterprise,"' AND glabld = '",g_glaa_m.glaald,"'",
               "             AND glab001 = '25' AND glab002 = '8318'   ",
               "          UNION                                        ",
               "          SELECT gzcb002 scc, '' a, '1' b              ",
               "            FROM gzcb_t                                ",
               "           WHERE gzcb001 = '8318')",
               "GROUP BY scc"
   PREPARE agli171_ref_prep1 FROM l_sql
   DECLARE agli171_ref_glab CURSOR FOR agli171_ref_prep1
   
   LET l_glab003 = Null
   LET l_a = Null
   LET l_b = Null
   FOREACH agli171_ref_glab INTO l_glab003,l_a,l_b
      IF l_a = '1' AND l_b = '1' THEN CONTINUE FOREACH END IF
      IF l_a = '1' THEN
         DELETE FROM glab_t WHERE glabent = g_enterprise
                              AND glabld  = g_glaa_m.glaald
                              AND glab003 = l_glab003
                              AND glab001 = '25' AND glab002 = '8318'
         IF SQLCA.SQLCODE THEN
            LET g_success = 'N'
         END IF
      END IF
      IF l_b = '1' THEN
         INSERT INTO glab_t (glabent,glabld,
                             glab001  ,glab002  ,glab003  ,glab004,glab005,glab006,
                             glab007  ,glab008  ,glab009  ,glab010,glab011) 
            VALUES(g_enterprise,g_glaa_m.glaald,
                             '25','8318',l_glab003,''     ,''     ,''     ,
                             ''       ,''       ,''       ,''     ,'1')
         IF SQLCA.SQLCODE THEN
            LET g_success = 'N'
         END IF
      END IF
   END FOREACH
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF

END FUNCTION

################################################################################
# Descriptions...: 科目檢查
# Memo...........:
# Usage..........: CALL agli171_glcd001_chk(p_glac002)
#                  RETURNING 回传参数
# Input parameter: p_glac002        科目編號
# Return code....: 
# Date & Author..: 2014/12/1 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION agli171_glcd001_chk(p_glac002)
   DEFINE p_glac002    LIKE glac_t.glac002
   DEFINE l_glacstus   LIKE glac_t.glacstus
   DEFINE l_glac003    LIKE glac_t.glac003
   DEFINE l_cnt        LIKE type_t.num5
   
   LET g_errno = ''
#151117-00009#1--mark--str--
#   SELECT glacstus,glac003 INTO l_glacstus,l_glac003 FROM glac_t
#    WHERE glacent = g_enterprise
#      AND glac001 = g_glaa_m.glaa004  #会计科目参照表号
#      AND glac002 = p_glac002
#       
#   CASE
#      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00011'
#      WHEN l_glacstus = 'N'      LET g_errno = 'sub-01302'#'agl-00012'  
#      WHEN l_glac003 = '1'       LET g_errno = 'agl-00013'  #必须为非统治类科目
#   END CASE 
#   IF cl_null(g_errno) THEN
#151117-00009#1--mark--end
      LET l_cnt=0
      SELECT COUNT(*) INTO l_cnt FROM glcd_t 
      WHERE glcdent=g_enterprise AND glcdld=g_glaa_m.glaald AND glcd001=p_glac002
      IF l_cnt>0 THEN
         LET g_errno="std-00004"
      END IF
#   END IF #151117-00009#1 mark
END FUNCTION

################################################################################
# Descriptions...: 開窗可選多筆插入glcd_t表
# Memo...........:
# Usage..........: CALL agli171_insert_glcd(p_str)
#                  RETURNING 回传参数
# Input parameter: p_str          開窗返回的科目編號
# Return code....: 
# Date & Author..: 2014/12/1 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION agli171_insert_glcd(p_str)
   DEFINE p_str          STRING
   DEFINE l_str          STRING
   DEFINE l_glcd001      LIKE glcd_t.glcd001
   DEFINE l_success      LIKE type_t.num5
   DEFINE tok            base.StringTokenizer
   
   LET l_success = TRUE
   CALL cl_err_collect_init()
   
   LET tok = base.StringTokenizer.create(p_str,"|")
   WHILE tok.hasMoreTokens()
      LET l_glcd001 = tok.nextToken()
      #151117-00009#1--add--str--
      #科目存在性，有效性，非统治科目，账户科目属性检查
      CALL s_voucher_glaq002_chk(g_glaa_m.glaald,l_glcd001)
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = l_glcd001
         #160321-00016#28 --s add
         LET g_errparam.replace[1] = 'agli030'
         LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
         LET g_errparam.exeprog = 'agli030'
         #160321-00016#28 --e add
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE WHILE    
      END IF
      #151117-00009#1--add--end
      CALL agli171_glcd001_chk(l_glcd001)
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_glcd001
         LET g_errparam.code   = g_errno
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE WHILE
      END IF
      INSERT INTO glcd_t(glcdent,glcdld,glcd001,glcdacti) 
                  VALUES(g_enterprise,g_glaa_m.glaald,l_glcd001,'Y')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_glcd001
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
   END WHILE 
   
   CALL cl_err_collect_show()

END FUNCTION

 
{</section>}
 
