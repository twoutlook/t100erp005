#該程式未解開Section, 採用最新樣板產出!
{<section id="axci115.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-04-25 15:30:57), PR版次:0013(2017-01-24 16:56:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000407
#+ Filename...: axci115
#+ Description: 成本要素分攤設定作業
#+ Creator....: 02291(2013-12-10 14:35:55)
#+ Modifier...: 00613 -SD/PR- 06948
 
{</section>}
 
{<section id="axci115.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150812-00010#2  2015/08/17  by 03538      整批生成子畫面不控卡單頭重複性,才能產生單筆單身
#150916-00015#1  2015/12/7   By Xiaozg     1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#151022-00008#3  2016/01/05  by dorislai   新增整批刪除功能
#160318-00005#46 2016/03/28  by pengxin    修正azzi920重复定义之错误讯息
#160425-00014#1  2016/04/25  By Dido       部門依據科目是否做部門管理開放,預設部門屬性為B.間接部門
#160318-00025#46 2016/04/28  By 07959      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160701-00012#1  2016/07/04  By Polly      單身部門可否輸入，應取agli031的科目設定，非取agli021
#161013-00051#1  2016/10/18  By shiun      整批調整據點組織開窗
#161109-00085#25 2016/11/16  By 08993      整批調整系統星號寫法
#161109-00085#63 2016/12/01  By 08171      整批調整系統星號寫法
#170120-00046#1  2017/01/20  By 02295      增加ENT
#170120-00055#1  2017/01/24  By 06948      1.[成本中心]參考[部門編號]寫法勾稽 ooeg009 勾稽帳套歸屬法人 & ALL，AFTER FIELD 也控卡不符合的資料
#                                          2.[科目編號] 依據 agli010和 agli021 設定 (glaa004 = glac001) 勾稽篩選資料
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
PRIVATE type type_g_xcba_m        RECORD
       xcba001 LIKE xcba_t.xcba001, 
   xcbald LIKE xcba_t.xcbald, 
   xcbald_desc LIKE type_t.chr80, 
   xcba002 LIKE xcba_t.xcba002, 
   xcba003 LIKE xcba_t.xcba003, 
   xcba004 LIKE xcba_t.xcba004, 
   xcba004_desc LIKE type_t.chr80, 
   xcba007 LIKE xcba_t.xcba007
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcba_d        RECORD
       xcbastus LIKE xcba_t.xcbastus, 
   xcba005 LIKE xcba_t.xcba005, 
   xcba005_desc LIKE type_t.chr500, 
   xcba006 LIKE xcba_t.xcba006, 
   xcba006_desc LIKE type_t.chr500, 
   xcba008 LIKE xcba_t.xcba008, 
   xcba009 LIKE xcba_t.xcba009
       END RECORD
PRIVATE TYPE type_g_xcba2_d RECORD
       xcba005 LIKE xcba_t.xcba005, 
   xcba005_2_desc LIKE type_t.chr500, 
   xcba006 LIKE xcba_t.xcba006, 
   xcba006_2_desc LIKE type_t.chr500, 
   xcbaownid LIKE xcba_t.xcbaownid, 
   xcbaownid_desc LIKE type_t.chr500, 
   xcbaowndp LIKE xcba_t.xcbaowndp, 
   xcbaowndp_desc LIKE type_t.chr500, 
   xcbacrtid LIKE xcba_t.xcbacrtid, 
   xcbacrtid_desc LIKE type_t.chr500, 
   xcbacrtdp LIKE xcba_t.xcbacrtdp, 
   xcbacrtdp_desc LIKE type_t.chr500, 
   xcbacrtdt DATETIME YEAR TO SECOND, 
   xcbamodid LIKE xcba_t.xcbamodid, 
   xcbamodid_desc LIKE type_t.chr500, 
   xcbamoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa004             LIKE glaa_t.glaa004
 type type_g_xcba_s        RECORD
       xcbald LIKE xcba_t.xcbald,
       xcbald_desc LIKE type_t.chr80,
       xcba002 LIKE xcba_t.xcba002,
       xcba003 LIKE xcba_t.xcba003,
       xcbald_1 LIKE type_t.chr80,
       xcbald_1_desc LIKE type_t.chr80,
       xcba002_1 LIKE type_t.num5,
       xcba003_1 LIKE type_t.num5
       END RECORD
DEFINE g_xcba_s        type_g_xcba_s          {#ADP版次:1#}
 type type_g_xcba2_s        RECORD
       xcba001 LIKE xcba_t.xcba001, 
       xcbald LIKE xcba_t.xcbald, 
       xcbald_desc LIKE type_t.chr80, 
       xcba002 LIKE xcba_t.xcba002, 
       xcba003 LIKE xcba_t.xcba003, 
       xcba004 LIKE xcba_t.xcba004, 
       xcba004_desc LIKE type_t.chr80, 
       xcba008 LIKE xcba_t.xcba008,
       xcba007 LIKE xcba_t.xcba007
       END RECORD
DEFINE g_xcba2_s        type_g_xcba2_s          {#ADP版次:1#}
#151022-00008#3-add-(S)
type type_g_xcba3_s RECORD
       xcba001_01 LIKE xcba_t.xcba001,
       xcbald_01  LIKE xcba_t.xcbald,
       xcbald_01_desc LIKE glaal_t.glaal002,
       xcba002_01 LIKE xcba_t.xcba002,
       xcba003_01 LIKE xcba_t.xcba003,
       xcba004_01 LIKE xcba_t.xcba004,
       xcba004_01_desc LIKE ooefl_t.ooefl003,
       xcba007_01 LIKE xcba_t.xcba007,
       xcba005_01 LIKE xcba_t.xcba005,
       xcba005_01_desc LIKE glacl_t.glacl004,
       xcba006_01 LIKE xcba_t.xcba006,
       xcba006_01_desc LIKE ooefl_t.ooefl003,
       xcba008_01 LIKE xcba_t.xcba008,
       xcba009_01 LIKE xcba_t.xcba009
  END RECORD
DEFINE g_xcba3_s       type_g_xcba3_s
#151022-00008#3-add-(E)
DEFINE g_glaacomp       LIKE glaa_t.glaacomp
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcba_m          type_g_xcba_m
DEFINE g_xcba_m_t        type_g_xcba_m
DEFINE g_xcba_m_o        type_g_xcba_m
DEFINE g_xcba_m_mask_o   type_g_xcba_m #轉換遮罩前資料
DEFINE g_xcba_m_mask_n   type_g_xcba_m #轉換遮罩後資料
 
   DEFINE g_xcba001_t LIKE xcba_t.xcba001
DEFINE g_xcbald_t LIKE xcba_t.xcbald
DEFINE g_xcba002_t LIKE xcba_t.xcba002
DEFINE g_xcba003_t LIKE xcba_t.xcba003
DEFINE g_xcba004_t LIKE xcba_t.xcba004
 
 
DEFINE g_xcba_d          DYNAMIC ARRAY OF type_g_xcba_d
DEFINE g_xcba_d_t        type_g_xcba_d
DEFINE g_xcba_d_o        type_g_xcba_d
DEFINE g_xcba_d_mask_o   DYNAMIC ARRAY OF type_g_xcba_d #轉換遮罩前資料
DEFINE g_xcba_d_mask_n   DYNAMIC ARRAY OF type_g_xcba_d #轉換遮罩後資料
DEFINE g_xcba2_d   DYNAMIC ARRAY OF type_g_xcba2_d
DEFINE g_xcba2_d_t type_g_xcba2_d
DEFINE g_xcba2_d_o type_g_xcba2_d
DEFINE g_xcba2_d_mask_o   DYNAMIC ARRAY OF type_g_xcba2_d #轉換遮罩前資料
DEFINE g_xcba2_d_mask_n   DYNAMIC ARRAY OF type_g_xcba2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcbald LIKE xcba_t.xcbald,
      b_xcba001 LIKE xcba_t.xcba001,
      b_xcba002 LIKE xcba_t.xcba002,
      b_xcba003 LIKE xcba_t.xcba003,
      b_xcba004 LIKE xcba_t.xcba004
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
 
{<section id="axci115.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcba001,xcbald,'',xcba002,xcba003,xcba004,'',xcba007", 
                      " FROM xcba_t",
                      " WHERE xcbaent= ? AND xcbald=? AND xcba001=? AND xcba002=? AND xcba003=? AND  
                          xcba004=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci115_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcba001,t0.xcbald,t0.xcba002,t0.xcba003,t0.xcba004,t0.xcba007,t1.glaal002 , 
       t2.ooefl003",
               " FROM xcba_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.xcbald AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xcba004 AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.xcbaent = " ||g_enterprise|| " AND t0.xcbald = ? AND t0.xcba001 = ? AND t0.xcba002 = ? AND t0.xcba003 = ? AND t0.xcba004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axci115_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axci115 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axci115_init()   
 
      #進入選單 Menu (="N")
      CALL axci115_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axci115
      
   END IF 
   
   CLOSE axci115_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axci115.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axci115_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xcba001','8908') 
   CALL cl_set_combo_scc('xcba007','8909') 
   CALL cl_set_combo_scc('xcba008','8910') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
 
   #end add-point
   
   CALL axci115_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axci115.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axci115_ui_dialog()
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
   SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_m.xcbald

   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcba_m.* TO NULL
         CALL g_xcba_d.clear()
         CALL g_xcba2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axci115_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcba_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axci115_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axci115_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_xcba2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axci115_idx_chk()
               CALL axci115_ui_detailshow()
               
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
            CALL axci115_browser_fill("")
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
               CALL axci115_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axci115_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axci115_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci115_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axci115_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci115_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axci115_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci115_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axci115_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci115_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axci115_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci115_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcba_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcba2_d)
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
               NEXT FIELD xcba005
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
               CALL axci115_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axci115_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axci115_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axci115_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axci115_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axci115_s03
            LET g_action_choice="open_axci115_s03"
            IF cl_auth_chk_act("open_axci115_s03") THEN
               
               #add-point:ON ACTION open_axci115_s03 name="menu.open_axci115_s03"
               CALL axci115_s03()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axci115_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axci115_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axci115_s01
            LET g_action_choice="open_axci115_s01"
            IF cl_auth_chk_act("open_axci115_s01") THEN
               
               #add-point:ON ACTION open_axci115_s01 name="menu.open_axci115_s01"
               CALL axci115_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axci115_s02
            LET g_action_choice="open_axci115_s02"
            IF cl_auth_chk_act("open_axci115_s02") THEN
               
               #add-point:ON ACTION open_axci115_s02 name="menu.open_axci115_s02"
               CALL axci115_s02()
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
               CALL axci115_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axci115_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axci115_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axci115_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axci115_set_pk_array()
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
 
{<section id="axci115.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axci115_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci115.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axci115_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "xcbald,xcba001,xcba002,xcba003,xcba004"
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
      LET l_sub_sql = " SELECT DISTINCT xcbald ",
                      ", xcba001 ",
                      ", xcba002 ",
                      ", xcba003 ",
                      ", xcba004 ",
 
                      " FROM xcba_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcbaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcbald ",
                      ", xcba001 ",
                      ", xcba002 ",
                      ", xcba003 ",
                      ", xcba004 ",
 
                      " FROM xcba_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcba_t")
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
      INITIALIZE g_xcba_m.* TO NULL
      CALL g_xcba_d.clear()        
      CALL g_xcba2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcbald,t0.xcba001,t0.xcba002,t0.xcba003,t0.xcba004 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcbald,t0.xcba001,t0.xcba002,t0.xcba003,t0.xcba004",
                " FROM xcba_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcbaent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcba_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcba_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcbald,g_browser[g_cnt].b_xcba001,g_browser[g_cnt].b_xcba002, 
          g_browser[g_cnt].b_xcba003,g_browser[g_cnt].b_xcba004 
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
   
   IF cl_null(g_browser[g_cnt].b_xcbald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcba_m.* TO NULL
      CALL g_xcba_d.clear()
      CALL g_xcba2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axci115_fetch('')
   
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
 
{<section id="axci115.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axci115_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   IF cl_null(g_browser[g_current_idx].b_xcbald) AND cl_null(g_browser[g_current_idx].b_xcba001)
      AND cl_null(g_browser[g_current_idx].b_xcba002) AND cl_null(g_browser[g_current_idx].b_xcba003)
      AND cl_null(g_browser[g_current_idx].b_xcba004) THEN
      LET g_xcba_m.xcba007 = ""
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcba_m.xcbald = g_browser[g_current_idx].b_xcbald   
   LET g_xcba_m.xcba001 = g_browser[g_current_idx].b_xcba001   
   LET g_xcba_m.xcba002 = g_browser[g_current_idx].b_xcba002   
   LET g_xcba_m.xcba003 = g_browser[g_current_idx].b_xcba003   
   LET g_xcba_m.xcba004 = g_browser[g_current_idx].b_xcba004   
 
   EXECUTE axci115_master_referesh USING g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004 INTO g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004, 
       g_xcba_m.xcba007,g_xcba_m.xcbald_desc,g_xcba_m.xcba004_desc
   CALL axci115_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axci115_ui_detailshow()
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
 
{<section id="axci115.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axci115_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcbald = g_xcba_m.xcbald 
         AND g_browser[l_i].b_xcba001 = g_xcba_m.xcba001 
         AND g_browser[l_i].b_xcba002 = g_xcba_m.xcba002 
         AND g_browser[l_i].b_xcba003 = g_xcba_m.xcba003 
         AND g_browser[l_i].b_xcba004 = g_xcba_m.xcba004 
 
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
 
{<section id="axci115.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axci115_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_date      LIKE xcba_t.xcbacrtdt
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcba_m.* TO NULL
   CALL g_xcba_d.clear()
   CALL g_xcba2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcba001,xcbald,xcba002,xcba003,xcba004,xcba007
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba001
            #add-point:BEFORE FIELD xcba001 name="construct.b.xcba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba001
            
            #add-point:AFTER FIELD xcba001 name="construct.a.xcba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba001
            #add-point:ON ACTION controlp INFIELD xcba001 name="construct.c.xcba001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcbald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbald
            #add-point:ON ACTION controlp INFIELD xcbald name="construct.c.xcbald"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbald  #顯示到畫面上

            NEXT FIELD xcbald                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbald
            #add-point:BEFORE FIELD xcbald name="construct.b.xcbald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbald
            
            #add-point:AFTER FIELD xcbald name="construct.a.xcbald"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba002
            #add-point:BEFORE FIELD xcba002 name="construct.b.xcba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba002
            
            #add-point:AFTER FIELD xcba002 name="construct.a.xcba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba002
            #add-point:ON ACTION controlp INFIELD xcba002 name="construct.c.xcba002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba003
            #add-point:BEFORE FIELD xcba003 name="construct.b.xcba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba003
            
            #add-point:AFTER FIELD xcba003 name="construct.a.xcba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba003
            #add-point:ON ACTION controlp INFIELD xcba003 name="construct.c.xcba003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba004
            #add-point:ON ACTION controlp INFIELD xcba004 name="construct.c.xcba004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_71()                           #呼叫開窗  #fengmy150413
            DISPLAY g_qryparam.return1 TO xcba004  #顯示到畫面上
            LET g_qryparam.where = ""

            NEXT FIELD xcba004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba004
            #add-point:BEFORE FIELD xcba004 name="construct.b.xcba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba004
            
            #add-point:AFTER FIELD xcba004 name="construct.a.xcba004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba007
            #add-point:BEFORE FIELD xcba007 name="construct.b.xcba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba007
            
            #add-point:AFTER FIELD xcba007 name="construct.a.xcba007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba007
            #add-point:ON ACTION controlp INFIELD xcba007 name="construct.c.xcba007"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcbastus,xcba005,xcba005_desc,xcba006,xcba008,xcba009,xcbaownid,xcbaowndp, 
          xcbacrtid,xcbacrtdp,xcbacrtdt,xcbamodid,xcbamoddt
           FROM s_detail1[1].xcbastus,s_detail1[1].xcba005,s_detail1[1].xcba005_desc,s_detail1[1].xcba006, 
               s_detail1[1].xcba008,s_detail1[1].xcba009,s_detail2[1].xcbaownid,s_detail2[1].xcbaowndp, 
               s_detail2[1].xcbacrtid,s_detail2[1].xcbacrtdp,s_detail2[1].xcbacrtdt,s_detail2[1].xcbamodid, 
               s_detail2[1].xcbamoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
          
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xcbacrtdt>>----
         AFTER FIELD xcbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xcbamoddt>>----
         AFTER FIELD xcbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcbacnfdt>>----
         
         #----<<xcbapstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbastus
            #add-point:BEFORE FIELD xcbastus name="construct.b.page1.xcbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbastus
            
            #add-point:AFTER FIELD xcbastus name="construct.a.page1.xcbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbastus
            #add-point:ON ACTION controlp INFIELD xcbastus name="construct.c.page1.xcbastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba005
            #add-point:BEFORE FIELD xcba005 name="construct.b.page1.xcba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba005
            
            #add-point:AFTER FIELD xcba005 name="construct.a.page1.xcba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba005
            #add-point:ON ACTION controlp INFIELD xcba005 name="construct.c.page1.xcba005"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 != '1' AND glac006 = '1' "

            #給予arg

           #CALL aglt310_04()
            CALL q_glac002_5()
            DISPLAY g_qryparam.return1 TO xcba005  #顯示到畫面上
            NEXT FIELD xcba005                          #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba005_desc
            #add-point:BEFORE FIELD xcba005_desc name="construct.b.page1.xcba005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba005_desc
            
            #add-point:AFTER FIELD xcba005_desc name="construct.a.page1.xcba005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcba005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba005_desc
            #add-point:ON ACTION controlp INFIELD xcba005_desc name="construct.c.page1.xcba005_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba006
            #add-point:ON ACTION controlp INFIELD xcba006 name="construct.c.page1.xcba006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_71()                           #呼叫開窗   #fengmy150413
            DISPLAY g_qryparam.return1 TO xcba006  #顯示到畫面上

            NEXT FIELD xcba006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba006
            #add-point:BEFORE FIELD xcba006 name="construct.b.page1.xcba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba006
            
            #add-point:AFTER FIELD xcba006 name="construct.a.page1.xcba006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba008
            #add-point:BEFORE FIELD xcba008 name="construct.b.page1.xcba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba008
            
            #add-point:AFTER FIELD xcba008 name="construct.a.page1.xcba008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba008
            #add-point:ON ACTION controlp INFIELD xcba008 name="construct.c.page1.xcba008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba009
            #add-point:BEFORE FIELD xcba009 name="construct.b.page1.xcba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba009
            
            #add-point:AFTER FIELD xcba009 name="construct.a.page1.xcba009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcba009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba009
            #add-point:ON ACTION controlp INFIELD xcba009 name="construct.c.page1.xcba009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbaownid
            #add-point:ON ACTION controlp INFIELD xcbaownid name="construct.c.page2.xcbaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbaownid  #顯示到畫面上

            NEXT FIELD xcbaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbaownid
            #add-point:BEFORE FIELD xcbaownid name="construct.b.page2.xcbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbaownid
            
            #add-point:AFTER FIELD xcbaownid name="construct.a.page2.xcbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbaowndp
            #add-point:ON ACTION controlp INFIELD xcbaowndp name="construct.c.page2.xcbaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbaowndp  #顯示到畫面上

            NEXT FIELD xcbaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbaowndp
            #add-point:BEFORE FIELD xcbaowndp name="construct.b.page2.xcbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbaowndp
            
            #add-point:AFTER FIELD xcbaowndp name="construct.a.page2.xcbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbacrtid
            #add-point:ON ACTION controlp INFIELD xcbacrtid name="construct.c.page2.xcbacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbacrtid  #顯示到畫面上

            NEXT FIELD xcbacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbacrtid
            #add-point:BEFORE FIELD xcbacrtid name="construct.b.page2.xcbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbacrtid
            
            #add-point:AFTER FIELD xcbacrtid name="construct.a.page2.xcbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbacrtdp
            #add-point:ON ACTION controlp INFIELD xcbacrtdp name="construct.c.page2.xcbacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbacrtdp  #顯示到畫面上

            NEXT FIELD xcbacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbacrtdp
            #add-point:BEFORE FIELD xcbacrtdp name="construct.b.page2.xcbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbacrtdp
            
            #add-point:AFTER FIELD xcbacrtdp name="construct.a.page2.xcbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbacrtdt
            #add-point:BEFORE FIELD xcbacrtdt name="construct.b.page2.xcbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbamodid
            #add-point:ON ACTION controlp INFIELD xcbamodid name="construct.c.page2.xcbamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbamodid  #顯示到畫面上

            NEXT FIELD xcbamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbamodid
            #add-point:BEFORE FIELD xcbamodid name="construct.b.page2.xcbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbamodid
            
            #add-point:AFTER FIELD xcbamodid name="construct.a.page2.xcbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbamoddt
            #add-point:BEFORE FIELD xcbamoddt name="construct.b.page2.xcbamoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         CALL axci115_head_default() #dorislai-20151023-add
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
 
{<section id="axci115.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axci115_query()
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
   CALL g_xcba_d.clear()
   CALL g_xcba2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axci115_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axci115_browser_fill(g_wc)
      CALL axci115_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axci115_browser_fill("F")
   
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
      CALL axci115_fetch("F") 
   END IF
   
   CALL axci115_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axci115_fetch(p_flag)
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
   
   #CALL axci115_browser_fill(p_flag)
   
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
   
   LET g_xcba_m.xcbald = g_browser[g_current_idx].b_xcbald
   LET g_xcba_m.xcba001 = g_browser[g_current_idx].b_xcba001
   LET g_xcba_m.xcba002 = g_browser[g_current_idx].b_xcba002
   LET g_xcba_m.xcba003 = g_browser[g_current_idx].b_xcba003
   LET g_xcba_m.xcba004 = g_browser[g_current_idx].b_xcba004
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axci115_master_referesh USING g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004 INTO g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004, 
       g_xcba_m.xcba007,g_xcba_m.xcbald_desc,g_xcba_m.xcba004_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcba_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcba_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcba_m_mask_o.* =  g_xcba_m.*
   CALL axci115_xcba_t_mask()
   LET g_xcba_m_mask_n.* =  g_xcba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axci115_set_act_visible()
   CALL axci115_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcba_m_t.* = g_xcba_m.*
   LET g_xcba_m_o.* = g_xcba_m.*
   
   #重新顯示   
   CALL axci115_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axci115.insert" >}
#+ 資料新增
PRIVATE FUNCTION axci115_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcba_d.clear()
   CALL g_xcba2_d.clear()
 
 
   INITIALIZE g_xcba_m.* TO NULL             #DEFAULT 設定
   LET g_xcbald_t = NULL
   LET g_xcba001_t = NULL
   LET g_xcba002_t = NULL
   LET g_xcba003_t = NULL
   LET g_xcba004_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_xcba_m.xcba001 = "1"
      LET g_xcba_m.xcba007 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axci115_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcba_m.* TO NULL
         INITIALIZE g_xcba_d TO NULL
         INITIALIZE g_xcba2_d TO NULL
 
         CALL axci115_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcba_m.* = g_xcba_m_t.*
         CALL axci115_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcba_d.clear()
      #CALL g_xcba2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axci115_set_act_visible()
   CALL axci115_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbald_t = g_xcba_m.xcbald
   LET g_xcba001_t = g_xcba_m.xcba001
   LET g_xcba002_t = g_xcba_m.xcba002
   LET g_xcba003_t = g_xcba_m.xcba003
   LET g_xcba004_t = g_xcba_m.xcba004
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbaent = " ||g_enterprise|| " AND",
                      " xcbald = '", g_xcba_m.xcbald, "' "
                      ," AND xcba001 = '", g_xcba_m.xcba001, "' "
                      ," AND xcba002 = '", g_xcba_m.xcba002, "' "
                      ," AND xcba003 = '", g_xcba_m.xcba003, "' "
                      ," AND xcba004 = '", g_xcba_m.xcba004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci115_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axci115_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axci115_master_referesh USING g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004 INTO g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004, 
       g_xcba_m.xcba007,g_xcba_m.xcbald_desc,g_xcba_m.xcba004_desc
   
   #遮罩相關處理
   LET g_xcba_m_mask_o.* =  g_xcba_m.*
   CALL axci115_xcba_t_mask()
   LET g_xcba_m_mask_n.* =  g_xcba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcbald_desc,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004,g_xcba_m.xcba004_desc,g_xcba_m.xcba007
   
   #功能已完成,通報訊息中心
   CALL axci115_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.modify" >}
#+ 資料修改
PRIVATE FUNCTION axci115_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcba_m.xcbald IS NULL
   OR g_xcba_m.xcba001 IS NULL
   OR g_xcba_m.xcba002 IS NULL
   OR g_xcba_m.xcba003 IS NULL
   OR g_xcba_m.xcba004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcbald_t = g_xcba_m.xcbald
   LET g_xcba001_t = g_xcba_m.xcba001
   LET g_xcba002_t = g_xcba_m.xcba002
   LET g_xcba003_t = g_xcba_m.xcba003
   LET g_xcba004_t = g_xcba_m.xcba004
 
   CALL s_transaction_begin()
   
   OPEN axci115_cl USING g_enterprise,g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci115_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axci115_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci115_master_referesh USING g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004 INTO g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004, 
       g_xcba_m.xcba007,g_xcba_m.xcbald_desc,g_xcba_m.xcba004_desc
   
   #遮罩相關處理
   LET g_xcba_m_mask_o.* =  g_xcba_m.*
   CALL axci115_xcba_t_mask()
   LET g_xcba_m_mask_n.* =  g_xcba_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axci115_show()
   WHILE TRUE
      LET g_xcbald_t = g_xcba_m.xcbald
      LET g_xcba001_t = g_xcba_m.xcba001
      LET g_xcba002_t = g_xcba_m.xcba002
      LET g_xcba003_t = g_xcba_m.xcba003
      LET g_xcba004_t = g_xcba_m.xcba004
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axci115_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcba_m.* = g_xcba_m_t.*
         CALL axci115_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcba_m.xcbald != g_xcbald_t 
      OR g_xcba_m.xcba001 != g_xcba001_t 
      OR g_xcba_m.xcba002 != g_xcba002_t 
      OR g_xcba_m.xcba003 != g_xcba003_t 
      OR g_xcba_m.xcba004 != g_xcba004_t 
 
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
   CALL axci115_set_act_visible()
   CALL axci115_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcbaent = " ||g_enterprise|| " AND",
                      " xcbald = '", g_xcba_m.xcbald, "' "
                      ," AND xcba001 = '", g_xcba_m.xcba001, "' "
                      ," AND xcba002 = '", g_xcba_m.xcba002, "' "
                      ," AND xcba003 = '", g_xcba_m.xcba003, "' "
                      ," AND xcba004 = '", g_xcba_m.xcba004, "' "
 
   #填到對應位置
   CALL axci115_browser_fill("")
 
   CALL axci115_idx_chk()
 
   CLOSE axci115_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axci115_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axci115.input" >}
#+ 資料輸入
PRIVATE FUNCTION axci115_input(p_cmd)
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
   DEFINE  l_date          LIKE xcba_t.xcbacrtdt
   DEFINE  l_glaa004_t     LIKE glaa_t.glaa004
   DEFINE  l_glaa004       LIKE glaa_t.glaa004
   DEFINE  l_xcba009       LIKE xcba_t.xcba009
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   #ADD BY XZG20151203 e
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
   DISPLAY BY NAME g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcbald_desc,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004,g_xcba_m.xcba004_desc,g_xcba_m.xcba007
   
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
   LET g_forupd_sql = "SELECT xcbastus,xcba005,xcba006,xcba008,xcba009,xcba005,xcba006,xcbaownid,xcbaowndp, 
       xcbacrtid,xcbacrtdp,xcbacrtdt,xcbamodid,xcbamoddt FROM xcba_t WHERE xcbaent=? AND xcbald=? AND  
       xcba001=? AND xcba002=? AND xcba003=? AND xcba004=? AND xcba005=? AND xcba006=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci115_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axci115_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axci115_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004, 
       g_xcba_m.xcba007
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   IF NOT s_ld_chk_authorization(g_user,g_xcba_m.xcbald) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00022'
      LET g_errparam.extend = g_xcba_m.xcbald
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   IF p_cmd = 'a' AND l_cmd_t = 'r' THEN
      CALL cl_set_comp_entry("xcba007",FALSE)
   ELSE
      CALL cl_set_comp_entry("xcba007",TRUE)
   END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axci115.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004, 
          g_xcba_m.xcba007 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            IF p_cmd = 'a' AND (l_cmd_t = 'a' OR l_cmd_t = 'r') THEN
               #dorislai-20151023-moidfy----(S)
               #換用function call，方便以後修改
#               SELECT glaald INTO g_xcba_m.xcbald FROM glaa_t
#                WHERE glaaent = g_enterprise AND glaa014 = 'Y' 
#                  AND glaacomp = (SELECT unique ooef017 FROM ooef_t where ooefent = g_enterprise AND ooef001 = g_site)
#               LET g_xcba_m.xcba002 = YEAR(g_today)
#               LET g_xcba_m.xcba003 = MONTH(g_today)
               CALL axci115_head_default()
               #dorislai-20151023-moidfy----(E)
               LET g_xcba_m.xcbald_desc = ''
               LET g_xcba_m.xcba004_desc = ''
               IF p_cmd = 'a' AND l_cmd_t = 'a' THEN  #fengmy150413
                  LET g_xcba_m.xcba001 = 1
               END IF  #fengmy150413
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_xcba_m.xcbald
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_xcba_m.xcbald_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcbald_desc,g_xcba_m.xcba004_desc
            END IF
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_m.xcbald
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba001
            #add-point:BEFORE FIELD xcba001 name="input.b.xcba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba001
            
            #add-point:AFTER FIELD xcba001 name="input.a.xcba001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba_m.xcbald) AND NOT cl_null(g_xcba_m.xcba001) AND NOT cl_null(g_xcba_m.xcba002) AND NOT cl_null(g_xcba_m.xcba003) AND NOT cl_null(g_xcba_m.xcba004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcba_m.xcbald != g_xcbald_t  OR g_xcba_m.xcba001 != g_xcba001_t  OR g_xcba_m.xcba002 != g_xcba002_t  OR g_xcba_m.xcba003 != g_xcba003_t  OR g_xcba_m.xcba004 != g_xcba004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba_m.xcbald ||"' AND "|| "xcba001 = '"||g_xcba_m.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba_m.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba_m.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba_m.xcba004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba001
            #add-point:ON CHANGE xcba001 name="input.g.xcba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbald
            
            #add-point:AFTER FIELD xcbald name="input.a.xcbald"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba_m.xcbald) AND NOT cl_null(g_xcba_m.xcba001) AND NOT cl_null(g_xcba_m.xcba002) AND NOT cl_null(g_xcba_m.xcba003) AND NOT cl_null(g_xcba_m.xcba004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcba_m.xcbald != g_xcbald_t  OR g_xcba_m.xcba001 != g_xcba001_t  OR g_xcba_m.xcba002 != g_xcba002_t  OR g_xcba_m.xcba003 != g_xcba003_t  OR g_xcba_m.xcba004 != g_xcba004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba_m.xcbald ||"' AND "|| "xcba001 = '"||g_xcba_m.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba_m.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba_m.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba_m.xcba004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_xcba_m.xcbald) THEN
               IF l_cmd_t = 'r' THEN
                  SELECT glaa004 INTO l_glaa004_t FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_xcba_m_t.xcbald
                  SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_xcba_m.xcbald
                  IF l_glaa004_t != l_glaa004 THEN
                     LET g_xcba_m.xcbald = ''
                     LET g_xcba_m.xcbald_desc = ''
                     DISPLAY BY NAME g_xcba_m.xcbald_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00138'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD xcbald
                  END IF
               END IF
               IF NOT ap_chk_isExist(g_xcba_m.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  IF p_cmd = 'a' THEN
                     LET g_xcba_m.xcbald = ''
                     LET g_xcba_m.xcbald_desc = ''
                  ELSE
                     LET g_xcba_m.xcbald = g_xcba_m_t.xcbald
                     LET g_xcba_m.xcbald_desc = g_xcba_m_t.xcbald_desc
                  END IF
                  DISPLAY BY NAME g_xcba_m.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_xcba_m.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',0) THEN     #160318-00005#46  mark
               IF NOT ap_chk_isExist(g_xcba_m.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN     #160318-00005#46  add     
                  IF p_cmd = 'a' THEN
                     LET g_xcba_m.xcbald = ''
                     LET g_xcba_m.xcbald_desc = ''
                  ELSE
                     LET g_xcba_m.xcbald = g_xcba_m_t.xcbald
                     LET g_xcba_m.xcbald_desc = g_xcba_m_t.xcbald_desc
                  END IF
                  DISPLAY BY NAME g_xcba_m.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_xcba_m.xcbald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_xcba_m.xcbald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF p_cmd = 'a' THEN
                     LET g_xcba_m.xcbald = ''
                     LET g_xcba_m.xcbald_desc = ''
                  ELSE
                     LET g_xcba_m.xcbald = g_xcba_m_t.xcbald
                     LET g_xcba_m.xcbald_desc = g_xcba_m_t.xcbald_desc
                  END IF
                  DISPLAY BY NAME g_xcba_m.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
               SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_m.xcbald
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_m.xcbald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_m.xcbald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_m.xcbald_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbald
            #add-point:BEFORE FIELD xcbald name="input.b.xcbald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbald
            #add-point:ON CHANGE xcbald name="input.g.xcbald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba002
            #add-point:BEFORE FIELD xcba002 name="input.b.xcba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba002
            
            #add-point:AFTER FIELD xcba002 name="input.a.xcba002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba_m.xcbald) AND NOT cl_null(g_xcba_m.xcba001) AND NOT cl_null(g_xcba_m.xcba002) AND NOT cl_null(g_xcba_m.xcba003) AND NOT cl_null(g_xcba_m.xcba004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcba_m.xcbald != g_xcbald_t  OR g_xcba_m.xcba001 != g_xcba001_t  OR g_xcba_m.xcba002 != g_xcba002_t  OR g_xcba_m.xcba003 != g_xcba003_t  OR g_xcba_m.xcba004 != g_xcba004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba_m.xcbald ||"' AND "|| "xcba001 = '"||g_xcba_m.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba_m.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba_m.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba_m.xcba004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_xcba_m.xcba002) THEN
               IF g_xcba_m.xcba002 <1000 OR g_xcba_m.xcba002 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_xcba_m.xcba002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba_m.xcba002 =''
                  NEXT FIELD xcba002
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba002
            #add-point:ON CHANGE xcba002 name="input.g.xcba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba003
            #add-point:BEFORE FIELD xcba003 name="input.b.xcba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba003
            
            #add-point:AFTER FIELD xcba003 name="input.a.xcba003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba_m.xcbald) AND NOT cl_null(g_xcba_m.xcba001) AND NOT cl_null(g_xcba_m.xcba002) AND NOT cl_null(g_xcba_m.xcba003) AND NOT cl_null(g_xcba_m.xcba004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcba_m.xcbald != g_xcbald_t  OR g_xcba_m.xcba001 != g_xcba001_t  OR g_xcba_m.xcba002 != g_xcba002_t  OR g_xcba_m.xcba003 != g_xcba003_t  OR g_xcba_m.xcba004 != g_xcba004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba_m.xcbald ||"' AND "|| "xcba001 = '"||g_xcba_m.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba_m.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba_m.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba_m.xcba004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcba_m.xcba003) THEN
               IF (g_xcba_m.xcba003 < 1) OR (g_xcba_m.xcba003 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_xcba_m.xcba003
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba_m.xcba003 = ''
                  NEXT FIELD xcba003
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba003
            #add-point:ON CHANGE xcba003 name="input.g.xcba003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba004
            
            #add-point:AFTER FIELD xcba004 name="input.a.xcba004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba_m.xcbald) AND NOT cl_null(g_xcba_m.xcba001) AND NOT cl_null(g_xcba_m.xcba002) AND NOT cl_null(g_xcba_m.xcba003) AND NOT cl_null(g_xcba_m.xcba004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcba_m.xcbald != g_xcbald_t  OR g_xcba_m.xcba001 != g_xcba001_t  OR g_xcba_m.xcba002 != g_xcba002_t  OR g_xcba_m.xcba003 != g_xcba003_t  OR g_xcba_m.xcba004 != g_xcba004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba_m.xcbald ||"' AND "|| "xcba001 = '"||g_xcba_m.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba_m.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba_m.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba_m.xcba004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcba_m.xcba004) THEN
               IF NOT ap_chk_isExist(g_xcba_m.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",1) THEN
                   LET g_xcba_m.xcba004 = ''
                   LET g_xcba_m.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba_m.xcba004_desc
                   NEXT FIELD xcba004
                END IF
                #成本中心為利潤中心或者成本中心
                IF NOT ap_chk_isExist(g_xcba_m.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND (ooeg003 = '2' OR ooeg003 = '3')","axc-00090",1) THEN
                   LET g_xcba_m.xcba004 = ''
                   LET g_xcba_m.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba_m.xcba004_desc
                   NEXT FIELD xcba004
                END IF
#                IF NOT ap_chk_isExist(g_xcba_m.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","abm-00007",1 ) THEN   #160318-00005#46  mark
                IF NOT ap_chk_isExist(g_xcba_m.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","sub-01302",'aooi125') THEN    #160318-00005#46  add
                   LET g_xcba_m.xcba004 = ''
                   LET g_xcba_m.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba_m.xcba004_desc
                   NEXT FIELD xcba004
                END IF
#                LET l_date = g_today
#                IF NOT ap_chk_isExist(g_xcba_m.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' AND (ooeg006 <= '" ||g_today||"' AND (ooeg007 IS NULL OR ooeg007 > '" ||g_today||"' )) ","aoo-00201",1 ) THEN
#                   LET g_xcba_m.xcba004 = ''
#                   LET g_xcba_m.xcba004_desc = ''
#                   DISPLAY BY NAME g_xcba_m.xcba004_desc
#                   NEXT FIELD xcba004
#               END IF
#               IF NOT ap_chk_isExist(g_xcba_m.xcba004,"SELECT COUNT(*) FROM ooeg_t,ooef_t WHERE ooegent = ooefent AND ooeg001 = ooef001 AND ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooef017 = '"||g_glaacomp||"' AND ooegstus = 'Y' ","axc-00092",1 ) THEN  #fengmy150413
               IF NOT ap_chk_isExist(g_xcba_m.xcba004,"SELECT COUNT(*) FROM ooeg_t,ooef_t WHERE ooegent = ooefent AND ooeg001 = ooef001 AND ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND (ooef017 = '"||g_glaacomp||"' OR ooef017 = 'ALL') AND ooegstus = 'Y' ","axc-00092",1 ) THEN  #fengmy150413
                   LET g_xcba_m.xcba004 = ''
                   LET g_xcba_m.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba_m.xcba004_desc
                   NEXT FIELD xcba004
               END IF
            END IF
            IF cl_null(g_xcba_m.xcba004) THEN LET g_xcba_m.xcba004 = ' ' END IF  #fengmy150108 add
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_m.xcba004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_m.xcba004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_m.xcba004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba004
            #add-point:BEFORE FIELD xcba004 name="input.b.xcba004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba004
            #add-point:ON CHANGE xcba004 name="input.g.xcba004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba007
            #add-point:BEFORE FIELD xcba007 name="input.b.xcba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba007
            
            #add-point:AFTER FIELD xcba007 name="input.a.xcba007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba007
            #add-point:ON CHANGE xcba007 name="input.g.xcba007"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba001
            #add-point:ON ACTION controlp INFIELD xcba001 name="input.c.xcba001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbald
            #add-point:ON ACTION controlp INFIELD xcbald name="input.c.xcbald"
#此段落由子樣板a07產生            
            #開窗i段
            SELECT glaa004 INTO l_glaa004_t FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_xcba_m_t.xcbald
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba_m.xcbald             #給予default值
            IF l_cmd_t = 'r' THEN
               LET g_qryparam.where = " glaa004 = '",l_glaa004_t,"'"
            ELSE
               LET g_qryparam.where = NULL
            END IF

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcba_m.xcbald = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_m.xcbald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_m.xcbald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_m.xcbald_desc

            DISPLAY g_xcba_m.xcbald TO xcbald              #顯示到畫面上

            NEXT FIELD xcbald                          #返回原欄位
            LET g_qryparam.where = NULL


            #END add-point
 
 
         #Ctrlp:input.c.xcba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba002
            #add-point:ON ACTION controlp INFIELD xcba002 name="input.c.xcba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba003
            #add-point:ON ACTION controlp INFIELD xcba003 name="input.c.xcba003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba004
            #add-point:ON ACTION controlp INFIELD xcba004 name="input.c.xcba004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba_m.xcba004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaacomp
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"

            CALL q_ooeg001_71()                                #呼叫開窗  #fengmy150413

            LET g_xcba_m.xcba004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_m.xcba004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_m.xcba004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_m.xcba004_desc

            DISPLAY g_xcba_m.xcba004 TO xcba004              #顯示到畫面上
            LET g_qryparam.where = ""

            NEXT FIELD xcba004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba007
            #add-point:ON ACTION controlp INFIELD xcba007 name="input.c.xcba007"
            
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
            DISPLAY BY NAME g_xcba_m.xcbald             
                            ,g_xcba_m.xcba001   
                            ,g_xcba_m.xcba002   
                            ,g_xcba_m.xcba003   
                            ,g_xcba_m.xcba004   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axci115_xcba_t_mask_restore('restore_mask_o')
            
               UPDATE xcba_t SET (xcba001,xcbald,xcba002,xcba003,xcba004,xcba007) = (g_xcba_m.xcba001, 
                   g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004,g_xcba_m.xcba007) 
 
                WHERE xcbaent = g_enterprise AND xcbald = g_xcbald_t
                  AND xcba001 = g_xcba001_t
                  AND xcba002 = g_xcba002_t
                  AND xcba003 = g_xcba003_t
                  AND xcba004 = g_xcba004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcba_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcba_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcba_m.xcbald
               LET gs_keys_bak[1] = g_xcbald_t
               LET gs_keys[2] = g_xcba_m.xcba001
               LET gs_keys_bak[2] = g_xcba001_t
               LET gs_keys[3] = g_xcba_m.xcba002
               LET gs_keys_bak[3] = g_xcba002_t
               LET gs_keys[4] = g_xcba_m.xcba003
               LET gs_keys_bak[4] = g_xcba003_t
               LET gs_keys[5] = g_xcba_m.xcba004
               LET gs_keys_bak[5] = g_xcba004_t
               LET gs_keys[6] = g_xcba_d[g_detail_idx].xcba005
               LET gs_keys_bak[6] = g_xcba_d_t.xcba005
               LET gs_keys[7] = g_xcba_d[g_detail_idx].xcba006
               LET gs_keys_bak[7] = g_xcba_d_t.xcba006
               CALL axci115_update_b('xcba_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcba_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcba_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axci115_xcba_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axci115_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcbald_t = g_xcba_m.xcbald
           LET g_xcba001_t = g_xcba_m.xcba001
           LET g_xcba002_t = g_xcba_m.xcba002
           LET g_xcba003_t = g_xcba_m.xcba003
           LET g_xcba004_t = g_xcba_m.xcba004
 
           
           IF g_xcba_d.getLength() = 0 THEN
              NEXT FIELD xcba005
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axci115.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcba_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcba_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axci115_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_m.xcbald
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
            CALL axci115_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axci115_cl USING g_enterprise,g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axci115_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci115_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcba_d[l_ac].xcba005 IS NOT NULL
               AND g_xcba_d[l_ac].xcba006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcba_d_t.* = g_xcba_d[l_ac].*  #BACKUP
               LET g_xcba_d_o.* = g_xcba_d[l_ac].*  #BACKUP
               CALL axci115_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axci115_set_no_entry_b(l_cmd)
               OPEN axci115_bcl USING g_enterprise,g_xcba_m.xcbald,
                                                g_xcba_m.xcba001,
                                                g_xcba_m.xcba002,
                                                g_xcba_m.xcba003,
                                                g_xcba_m.xcba004,
 
                                                g_xcba_d_t.xcba005
                                                ,g_xcba_d_t.xcba006
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci115_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci115_bcl INTO g_xcba_d[l_ac].xcbastus,g_xcba_d[l_ac].xcba005,g_xcba_d[l_ac].xcba006, 
                      g_xcba_d[l_ac].xcba008,g_xcba_d[l_ac].xcba009,g_xcba2_d[l_ac].xcba005,g_xcba2_d[l_ac].xcba006, 
                      g_xcba2_d[l_ac].xcbaownid,g_xcba2_d[l_ac].xcbaowndp,g_xcba2_d[l_ac].xcbacrtid, 
                      g_xcba2_d[l_ac].xcbacrtdp,g_xcba2_d[l_ac].xcbacrtdt,g_xcba2_d[l_ac].xcbamodid, 
                      g_xcba2_d[l_ac].xcbamoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcba_d_t.xcba005,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcba_d_mask_o[l_ac].* =  g_xcba_d[l_ac].*
                  CALL axci115_xcba_t_mask()
                  LET g_xcba_d_mask_n[l_ac].* =  g_xcba_d[l_ac].*
                  
                  CALL axci115_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL axci115_glacl004(g_xcba_d[l_ac].xcba005) RETURNING g_xcba_d[l_ac].xcba005_desc
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xcba_d_t.* TO NULL
            INITIALIZE g_xcba_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcba_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcba2_d[l_ac].xcbaownid = g_user
      LET g_xcba2_d[l_ac].xcbaowndp = g_dept
      LET g_xcba2_d[l_ac].xcbacrtid = g_user
      LET g_xcba2_d[l_ac].xcbacrtdp = g_dept 
      LET g_xcba2_d[l_ac].xcbacrtdt = cl_get_current()
      LET g_xcba2_d[l_ac].xcbamodid = g_user
      LET g_xcba2_d[l_ac].xcbamoddt = cl_get_current()
      LET g_xcba_d[l_ac].xcbastus = ''
 
 
  
            #一般欄位預設值
                  LET g_xcba_d[l_ac].xcbastus = "Y"
      LET g_xcba_d[l_ac].xcba009 = "100"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcba_d_t.* = g_xcba_d[l_ac].*     #新輸入資料
            LET g_xcba_d_o.* = g_xcba_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axci115_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axci115_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcba_d[li_reproduce_target].* = g_xcba_d[li_reproduce].*
               LET g_xcba2_d[li_reproduce_target].* = g_xcba2_d[li_reproduce].*
 
               LET g_xcba_d[g_xcba_d.getLength()].xcba005 = NULL
               LET g_xcba_d[g_xcba_d.getLength()].xcba006 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM xcba_t 
             WHERE xcbaent = g_enterprise AND xcbald = g_xcba_m.xcbald
               AND xcba001 = g_xcba_m.xcba001
               AND xcba002 = g_xcba_m.xcba002
               AND xcba003 = g_xcba_m.xcba003
               AND xcba004 = g_xcba_m.xcba004
 
               AND xcba005 = g_xcba_d[l_ac].xcba005
               AND xcba006 = g_xcba_d[l_ac].xcba006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_xcba_m.xcba004) THEN LET g_xcba_m.xcba004 = ' ' END IF  #fengmy150108 add
               #end add-point
               INSERT INTO xcba_t
                           (xcbaent,
                            xcba001,xcbald,xcba002,xcba003,xcba004,xcba007,
                            xcba005,xcba006
                            ,xcbastus,xcba008,xcba009,xcbaownid,xcbaowndp,xcbacrtid,xcbacrtdp,xcbacrtdt,xcbamodid,xcbamoddt) 
                     VALUES(g_enterprise,
                            g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004,g_xcba_m.xcba007,
                            g_xcba_d[l_ac].xcba005,g_xcba_d[l_ac].xcba006
                            ,g_xcba_d[l_ac].xcbastus,g_xcba_d[l_ac].xcba008,g_xcba_d[l_ac].xcba009,g_xcba2_d[l_ac].xcbaownid, 
                                g_xcba2_d[l_ac].xcbaowndp,g_xcba2_d[l_ac].xcbacrtid,g_xcba2_d[l_ac].xcbacrtdp, 
                                g_xcba2_d[l_ac].xcbacrtdt,g_xcba2_d[l_ac].xcbamodid,g_xcba2_d[l_ac].xcbamoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcba_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcba_t:",SQLERRMESSAGE 
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
               IF axci115_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcba_m.xcbald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcba_m.xcba001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcba_m.xcba002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcba_m.xcba003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcba_m.xcba004
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcba_d_t.xcba005
                  LET gs_keys[gs_keys.getLength()+1] = g_xcba_d_t.xcba006
 
 
                  #刪除下層單身
                  IF NOT axci115_key_delete_b(gs_keys,'xcba_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axci115_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axci115_bcl
               LET l_count = g_xcba_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcba_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbastus
            #add-point:BEFORE FIELD xcbastus name="input.b.page1.xcbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbastus
            
            #add-point:AFTER FIELD xcbastus name="input.a.page1.xcbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbastus
            #add-point:ON CHANGE xcbastus name="input.g.page1.xcbastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba005
            
            #add-point:AFTER FIELD xcba005 name="input.a.page1.xcba005"
            #此段落由子樣板a05產生
            IF  g_xcba_m.xcbald IS NOT NULL AND g_xcba_m.xcba001 IS NOT NULL AND g_xcba_m.xcba002 IS NOT NULL AND g_xcba_m.xcba003 IS NOT NULL AND g_xcba_m.xcba004 IS NOT NULL AND g_xcba_d[g_detail_idx].xcba005 IS NOT NULL AND g_xcba_d[g_detail_idx].xcba006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcba_m.xcbald != g_xcbald_t OR g_xcba_m.xcba001 != g_xcba001_t OR g_xcba_m.xcba002 != g_xcba002_t OR g_xcba_m.xcba003 != g_xcba003_t OR g_xcba_m.xcba004 != g_xcba004_t OR g_xcba_d[g_detail_idx].xcba005 != g_xcba_d_t.xcba005 OR g_xcba_d[g_detail_idx].xcba006 != g_xcba_d_t.xcba006)) THEN 
               
                 IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba_m.xcbald ||"' AND "|| "xcba001 = '"||g_xcba_m.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba_m.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba_m.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba_m.xcba004 ||"' AND "|| "xcba005 = '"||g_xcba_d[g_detail_idx].xcba005 ||"' AND "|| "xcba006 = '"||g_xcba_d[g_detail_idx].xcba006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
            END IF
            
            IF NOT cl_null(g_xcba_d[g_detail_idx].xcba005) THEN
                 #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
              LET l_sql = " AND glac007 = '5'"
              IF  s_aglt310_getlike_lc_subject(g_xcba_m.xcbald,g_xcba_d[g_detail_idx].xcba005,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_xcba_m.xcbald
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_xcba_d[g_detail_idx].xcba005
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_xcba_d[g_detail_idx].xcba005
                LET g_qryparam.arg3 = g_xcba_m.xcbald
                LET g_qryparam.arg4 = "1 "
                LET g_qryparam.where = "  glac007 = '5'"
                CALL q_glac002_6()
                LET g_xcba_d[l_ac].xcba005 = g_qryparam.return1              #將開窗取得的值回傳到變數
                CALL axci115_glacl004(g_xcba_d[l_ac].xcba005) RETURNING g_xcba_d[l_ac].xcba005_desc
                DISPLAY g_xcba_d[l_ac].xcba005 TO xcba005             #顯示到畫面上
                DISPLAY BY NAME g_xcba_d[l_ac].xcba005_desc
              END IF
               IF  NOT s_aglt310_lc_subject(g_xcba_m.xcbald,g_xcba_d[g_detail_idx].xcba005,'N') THEN
                  LET g_xcba_d[g_detail_idx].xcba005 = g_xcba_d_t.xcba005
                     LET g_xcba_d[g_detail_idx].xcba005_desc = g_xcba_d_t.xcba005_desc
                  DISPLAY BY NAME g_xcba_d[g_detail_idx].xcba005_desc
                  NEXT FIELD xcba005
               END IF
 #  150916-00015#1 END
#               IF NOT axci115_xcba005_chk(g_xcba_d[g_detail_idx].xcba005) THEN   #fengmy 150109 mark
               IF NOT axci115_xcba005_chk(g_xcba_m.xcbald,g_xcba_d[g_detail_idx].xcba005) THEN   #fengmy 150109
                  IF p_cmd = 'a' THEN
                     LET g_xcba_d[g_detail_idx].xcba005 = ''
                     LET g_xcba_d[g_detail_idx].xcba005_desc =''
                  ELSE
                     LET g_xcba_d[g_detail_idx].xcba005 = g_xcba_d_t.xcba005
                     LET g_xcba_d[g_detail_idx].xcba005_desc = g_xcba_d_t.xcba005_desc
                  END IF
                  DISPLAY BY NAME g_xcba_d[g_detail_idx].xcba005_desc
                  NEXT FIELD xcba005
               END IF
            END IF
            CALL axci115_glacl004(g_xcba_d[g_detail_idx].xcba005) RETURNING g_xcba_d[g_detail_idx].xcba005_desc
            DISPLAY BY NAME g_xcba_d[g_detail_idx].xcba005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba005
            #add-point:BEFORE FIELD xcba005 name="input.b.page1.xcba005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba005
            #add-point:ON CHANGE xcba005 name="input.g.page1.xcba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba005_desc
            #add-point:BEFORE FIELD xcba005_desc name="input.b.page1.xcba005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba005_desc
            
            #add-point:AFTER FIELD xcba005_desc name="input.a.page1.xcba005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba005_desc
            #add-point:ON CHANGE xcba005_desc name="input.g.page1.xcba005_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba006
            
            #add-point:AFTER FIELD xcba006 name="input.a.page1.xcba006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_d[l_ac].xcba006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_d[l_ac].xcba006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc

            #此段落由子樣板a05產生
            IF  g_xcba_m.xcbald IS NOT NULL AND g_xcba_m.xcba001 IS NOT NULL AND g_xcba_m.xcba002 IS NOT NULL AND g_xcba_m.xcba003 IS NOT NULL AND g_xcba_m.xcba004 IS NOT NULL AND g_xcba_d[g_detail_idx].xcba005 IS NOT NULL AND g_xcba_d[g_detail_idx].xcba006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcba_m.xcbald != g_xcbald_t OR g_xcba_m.xcba001 != g_xcba001_t OR g_xcba_m.xcba002 != g_xcba002_t OR g_xcba_m.xcba003 != g_xcba003_t OR g_xcba_m.xcba004 != g_xcba004_t OR g_xcba_d[g_detail_idx].xcba005 != g_xcba_d_t.xcba005 OR g_xcba_d[g_detail_idx].xcba006 != g_xcba_d_t.xcba006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba_m.xcbald ||"' AND "|| "xcba001 = '"||g_xcba_m.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba_m.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba_m.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba_m.xcba004 ||"' AND "|| "xcba005 = '"||g_xcba_d[g_detail_idx].xcba005 ||"' AND "|| "xcba006 = '"||g_xcba_d[g_detail_idx].xcba006 ||"'",'std-00004',0) THEN 
                     LET g_xcba_d[l_ac].xcba006 = g_xcba_d_t.xcba006
                     LET g_xcba_d[l_ac].xcba006_desc = g_xcba_d_t.xcba006_desc
                     DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcba_d[l_ac].xcba006) THEN
#               IF NOT ap_chk_isExist(g_xcba_d[l_ac].xcba006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",0) THEN
#                   LET g_xcba_d[l_ac].xcba006 = g_xcba_d_t.xcba006
#                   LET g_xcba_d[l_ac].xcba006_desc = g_xcba_d_t.xcba006_desc
#                   DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc
#                   NEXT FIELD xcba006
#                END IF
#                IF NOT ap_chk_isExist(g_xcba_d[l_ac].xcba006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","abm-00007",0 ) THEN
#                   LET g_xcba_d[l_ac].xcba006 = g_xcba_d_t.xcba006
#                   LET g_xcba_d[l_ac].xcba006_desc = g_xcba_d_t.xcba006_desc
#                   DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc
#                   NEXT FIELD xcba006
#               END IF
#               IF NOT ap_chk_isExist(g_xcba_d[l_ac].xcba006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' AND (ooeg006 <= '" ||g_today||"' AND (ooeg007 IS NULL OR ooeg007 > '" ||g_today||"' )) ","aoo-00201",1 ) THEN
#                   LET g_xcba_d[l_ac].xcba006 = g_xcba_d_t.xcba006
#                   LET g_xcba_d[l_ac].xcba006_desc = g_xcba_d_t.xcba006_desc
#                   DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc
#                   NEXT FIELD xcba006
#               END IF
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_xcba_d[l_ac].xcba006
               #160318-00025#46  2016/04/28  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#46  2016/04/28  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_14") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcba_d[l_ac].xcba006 = g_xcba_d_t.xcba006
                  LET g_xcba_d[l_ac].xcba006_desc = g_xcba_d_t.xcba006_desc
                  DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_xcba_d[l_ac].xcba006,"SELECT COUNT(*) FROM ooeg_t,ooef_t WHERE ooegent = ooefent AND ooeg001 = ooef001 AND ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooef017 = '"||g_glaacomp||"' AND ooegstus = 'Y' ","axc-00092",1 ) THEN
               IF NOT ap_chk_isExist(g_xcba_d[l_ac].xcba006,"SELECT COUNT(*) FROM ooeg_t,ooef_t WHERE ooegent = ooefent AND ooeg001 = ooef001 AND ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND (ooef017 = '"||g_glaacomp||"' OR ooef017 = 'ALL') AND ooegstus = 'Y' ","axc-00092",1 ) THEN  #fengmy150313
                   LET g_xcba_d[l_ac].xcba006 = ''
                   LET g_xcba_d[l_ac].xcba006_desc = ''
                   DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc
                   NEXT FIELD xcba006
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_d[l_ac].xcba006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_d[l_ac].xcba006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba006
            #add-point:BEFORE FIELD xcba006 name="input.b.page1.xcba006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba006
            #add-point:ON CHANGE xcba006 name="input.g.page1.xcba006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba008
            #add-point:BEFORE FIELD xcba008 name="input.b.page1.xcba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba008
            
            #add-point:AFTER FIELD xcba008 name="input.a.page1.xcba008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba008
            #add-point:ON CHANGE xcba008 name="input.g.page1.xcba008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcba009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcba_d[l_ac].xcba009,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD xcba009
            END IF 
 
 
 
            #add-point:AFTER FIELD xcba009 name="input.a.page1.xcba009"
            IF NOT cl_null(g_xcba_d[l_ac].xcba009) THEN 
#               SELECT SUM(xcba009) INTO l_xcba009 FROM xcba_t
#                WHERE xcbaent = g_enterprise AND xcbald = = g_xcba_m.xcbald
#                  AND xcba001 = g_xcba_m.xcba001 AND xcba002 = g_xcba_m.xcba002
#                  AND xcba003 = g_xcba_m.xcba003 AND xcba004 = g_xcba_m.xcba004
               
               #按照帳別+年度+期別+科目編號+部門編號，分攤權數不能超過100%
               SELECT SUM(xcba009) INTO l_xcba009 FROM xcba_t
                WHERE xcbaent = g_enterprise AND xcbald = = g_xcba_m.xcbald
                  AND xcba002 = g_xcba_m.xcba002 AND xcba003 = g_xcba_m.xcba003
                  AND xcba005 = g_xcba_d[l_ac].xcba005 AND xcba006 = g_xcba_d[l_ac].xcba006 
               
               
               
               IF l_cmd = 'a' THEN
                  IF l_xcba009 + g_xcba_d[l_ac].xcba009 > 100 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD xcba009
                  END IF
               ELSE
                  IF g_xcba_d[l_ac].xcba005 != g_xcba_d_t.xcba005 OR g_xcba_d[l_ac].xcba006 != g_xcba_d_t.xcba006 THEN
                     SELECT SUM(xcba009) INTO l_xcba009 FROM xcba_t
                      WHERE xcbaent = g_enterprise AND xcbald = = g_xcba_m.xcbald
                        AND xcba002 = g_xcba_m.xcba002 AND xcba003 = g_xcba_m.xcba003
                        AND xcba005 = g_xcba_d[l_ac].xcba005 AND xcba006 = g_xcba_d[l_ac].xcba006 
                        
                     IF l_xcba009 + g_xcba_d[l_ac].xcba009 > 100 THEN
                        INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                        NEXT FIELD xcba009
                     END IF
                  ELSE
                     IF l_xcba009 - g_xcba_d_t.xcba009 + g_xcba_d[l_ac].xcba009 > 100 THEN
                        INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                        NEXT FIELD xcba009
                     END IF
                  END IF
               END IF               
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcba009
            #add-point:BEFORE FIELD xcba009 name="input.b.page1.xcba009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcba009
            #add-point:ON CHANGE xcba009 name="input.g.page1.xcba009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbastus
            #add-point:ON ACTION controlp INFIELD xcbastus name="input.c.page1.xcbastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba005
            #add-point:ON ACTION controlp INFIELD xcba005 name="input.c.page1.xcba005"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba_d[l_ac].xcba005             #給予default值
            SELECT unique glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_m.xcbald
            LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 != '1' AND glac006 = '1' AND glac007 = '5'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_xcba_m.xcbald,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

           #CALL aglt310_04()
            CALL q_glac002_5()
            LET g_xcba_d[l_ac].xcba005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL axci115_glacl004(g_xcba_d[l_ac].xcba005) RETURNING g_xcba_d[l_ac].xcba005_desc


            DISPLAY g_xcba_d[l_ac].xcba005 TO xcba005             #顯示到畫面上
            DISPLAY BY NAME g_xcba_d[l_ac].xcba005_desc
            LET g_qryparam.where = ""
            NEXT FIELD xcba005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcba005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba005_desc
            #add-point:ON ACTION controlp INFIELD xcba005_desc name="input.c.page1.xcba005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba006
            #add-point:ON ACTION controlp INFIELD xcba006 name="input.c.page1.xcba006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba_d[l_ac].xcba006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaacomp

            CALL q_ooeg001_71()                                #呼叫開窗  #fengmy150413

            LET g_xcba_d[l_ac].xcba006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_d[l_ac].xcba006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_d[l_ac].xcba006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc

            DISPLAY g_xcba_d[l_ac].xcba006 TO xcba006              #顯示到畫面上

            NEXT FIELD xcba006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba008
            #add-point:ON ACTION controlp INFIELD xcba008 name="input.c.page1.xcba008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcba009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcba009
            #add-point:ON ACTION controlp INFIELD xcba009 name="input.c.page1.xcba009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcba_d[l_ac].* = g_xcba_d_t.*
               CLOSE axci115_bcl
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
               LET g_errparam.extend = g_xcba_d[l_ac].xcba005 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcba_d[l_ac].* = g_xcba_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcba2_d[l_ac].xcbamodid = g_user 
LET g_xcba2_d[l_ac].xcbamoddt = cl_get_current()
LET g_xcba2_d[l_ac].xcbamodid_desc = cl_get_username(g_xcba2_d[l_ac].xcbamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axci115_xcba_t_mask_restore('restore_mask_o')
         
               UPDATE xcba_t SET (xcbald,xcba001,xcba002,xcba003,xcba004,xcbastus,xcba005,xcba006,xcba008, 
                   xcba009,xcbaownid,xcbaowndp,xcbacrtid,xcbacrtdp,xcbacrtdt,xcbamodid,xcbamoddt) = (g_xcba_m.xcbald, 
                   g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004,g_xcba_d[l_ac].xcbastus, 
                   g_xcba_d[l_ac].xcba005,g_xcba_d[l_ac].xcba006,g_xcba_d[l_ac].xcba008,g_xcba_d[l_ac].xcba009, 
                   g_xcba2_d[l_ac].xcbaownid,g_xcba2_d[l_ac].xcbaowndp,g_xcba2_d[l_ac].xcbacrtid,g_xcba2_d[l_ac].xcbacrtdp, 
                   g_xcba2_d[l_ac].xcbacrtdt,g_xcba2_d[l_ac].xcbamodid,g_xcba2_d[l_ac].xcbamoddt)
                WHERE xcbaent = g_enterprise AND xcbald = g_xcba_m.xcbald 
                 AND xcba001 = g_xcba_m.xcba001 
                 AND xcba002 = g_xcba_m.xcba002 
                 AND xcba003 = g_xcba_m.xcba003 
                 AND xcba004 = g_xcba_m.xcba004 
 
                 AND xcba005 = g_xcba_d_t.xcba005 #項次   
                 AND xcba006 = g_xcba_d_t.xcba006  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcba_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcba_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcba_m.xcbald
               LET gs_keys_bak[1] = g_xcbald_t
               LET gs_keys[2] = g_xcba_m.xcba001
               LET gs_keys_bak[2] = g_xcba001_t
               LET gs_keys[3] = g_xcba_m.xcba002
               LET gs_keys_bak[3] = g_xcba002_t
               LET gs_keys[4] = g_xcba_m.xcba003
               LET gs_keys_bak[4] = g_xcba003_t
               LET gs_keys[5] = g_xcba_m.xcba004
               LET gs_keys_bak[5] = g_xcba004_t
               LET gs_keys[6] = g_xcba_d[g_detail_idx].xcba005
               LET gs_keys_bak[6] = g_xcba_d_t.xcba005
               LET gs_keys[7] = g_xcba_d[g_detail_idx].xcba006
               LET gs_keys_bak[7] = g_xcba_d_t.xcba006
               CALL axci115_update_b('xcba_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcba_m),util.JSON.stringify(g_xcba_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcba_m),util.JSON.stringify(g_xcba_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axci115_xcba_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcba_m.xcbald
               LET ls_keys[ls_keys.getLength()+1] = g_xcba_m.xcba001
               LET ls_keys[ls_keys.getLength()+1] = g_xcba_m.xcba002
               LET ls_keys[ls_keys.getLength()+1] = g_xcba_m.xcba003
               LET ls_keys[ls_keys.getLength()+1] = g_xcba_m.xcba004
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcba_d_t.xcba005
               LET ls_keys[ls_keys.getLength()+1] = g_xcba_d_t.xcba006
 
               CALL axci115_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axci115_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcba_d[l_ac].* = g_xcba_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axci115_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcba_d.getLength() = 0 THEN
               NEXT FIELD xcba005
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcba_d[li_reproduce_target].* = g_xcba_d[li_reproduce].*
               LET g_xcba2_d[li_reproduce_target].* = g_xcba2_d[li_reproduce].*
 
               LET g_xcba_d[li_reproduce_target].xcba005 = NULL
               LET g_xcba_d[li_reproduce_target].xcba006 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcba_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcba_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcba2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axci115_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axci115_idx_chk()
            CALL axci115_ui_detailshow()
        
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
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcbald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcbastus
               WHEN "s_detail2"
                  NEXT FIELD xcba005_2
 
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
 
{<section id="axci115.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axci115_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axci115_b_fill(g_wc2) #第一階單身填充
      CALL axci115_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axci115_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcbald_desc,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004,g_xcba_m.xcba004_desc,g_xcba_m.xcba007
 
   CALL axci115_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axci115_ref_show()
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
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba_m.xcbald
#            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcba_m.xcbald_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba_m.xcbald_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba_m.xcba004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcba_m.xcba004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba_m.xcba004_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcba_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba_d[l_ac].xcba006
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcba_d[l_ac].xcba006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba_d[l_ac].xcba006_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcba2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba2_d[l_ac].xcbaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xcba2_d[l_ac].xcbaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba2_d[l_ac].xcbaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba2_d[l_ac].xcbaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcba2_d[l_ac].xcbaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba2_d[l_ac].xcbaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba2_d[l_ac].xcbacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xcba2_d[l_ac].xcbacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba2_d[l_ac].xcbacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba2_d[l_ac].xcbacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcba2_d[l_ac].xcbacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba2_d[l_ac].xcbacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcba2_d[l_ac].xcbamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xcba2_d[l_ac].xcbamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcba2_d[l_ac].xcbamodid_desc

      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axci115.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axci115_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcba_t.xcbald 
   DEFINE l_oldno     LIKE xcba_t.xcbald 
   DEFINE l_newno02     LIKE xcba_t.xcba001 
   DEFINE l_oldno02     LIKE xcba_t.xcba001 
   DEFINE l_newno03     LIKE xcba_t.xcba002 
   DEFINE l_oldno03     LIKE xcba_t.xcba002 
   DEFINE l_newno04     LIKE xcba_t.xcba003 
   DEFINE l_oldno04     LIKE xcba_t.xcba003 
   DEFINE l_newno05     LIKE xcba_t.xcba004 
   DEFINE l_oldno05     LIKE xcba_t.xcba004 
 
   DEFINE l_master    RECORD LIKE xcba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcba_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcba_m.xcbald IS NULL
      OR g_xcba_m.xcba001 IS NULL
      OR g_xcba_m.xcba002 IS NULL
      OR g_xcba_m.xcba003 IS NULL
      OR g_xcba_m.xcba004 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcbald_t = g_xcba_m.xcbald
   LET g_xcba001_t = g_xcba_m.xcba001
   LET g_xcba002_t = g_xcba_m.xcba002
   LET g_xcba003_t = g_xcba_m.xcba003
   LET g_xcba004_t = g_xcba_m.xcba004
 
   
   LET g_xcba_m.xcbald = ""
   LET g_xcba_m.xcba001 = ""
   LET g_xcba_m.xcba002 = ""
   LET g_xcba_m.xcba003 = ""
   LET g_xcba_m.xcba004 = ""
 
   LET g_master_insert = FALSE
   CALL axci115_set_entry('a')
   CALL axci115_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_xcba_m.xcba001 = g_xcba001_t  #fengmy150413  
   #end add-point
   
   #清空key欄位的desc
      LET g_xcba_m.xcbald_desc = ''
   DISPLAY BY NAME g_xcba_m.xcbald_desc
   LET g_xcba_m.xcba004_desc = ''
   DISPLAY BY NAME g_xcba_m.xcba004_desc
 
   
   CALL axci115_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcba_m.* TO NULL
      INITIALIZE g_xcba_d TO NULL
      INITIALIZE g_xcba2_d TO NULL
 
      CALL axci115_show()
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
   CALL axci115_set_act_visible()
   CALL axci115_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbald_t = g_xcba_m.xcbald
   LET g_xcba001_t = g_xcba_m.xcba001
   LET g_xcba002_t = g_xcba_m.xcba002
   LET g_xcba003_t = g_xcba_m.xcba003
   LET g_xcba004_t = g_xcba_m.xcba004
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbaent = " ||g_enterprise|| " AND",
                      " xcbald = '", g_xcba_m.xcbald, "' "
                      ," AND xcba001 = '", g_xcba_m.xcba001, "' "
                      ," AND xcba002 = '", g_xcba_m.xcba002, "' "
                      ," AND xcba003 = '", g_xcba_m.xcba003, "' "
                      ," AND xcba004 = '", g_xcba_m.xcba004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci115_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axci115_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axci115_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axci115_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcba_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axci115_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcba_t
    WHERE xcbaent = g_enterprise AND xcbald = g_xcbald_t
    AND xcba001 = g_xcba001_t
    AND xcba002 = g_xcba002_t
    AND xcba003 = g_xcba003_t
    AND xcba004 = g_xcba004_t
 
       INTO TEMP axci115_detail
   
   #將key修正為調整後   
   UPDATE axci115_detail 
      #更新key欄位
      SET xcbald = g_xcba_m.xcbald
          , xcba001 = g_xcba_m.xcba001
          , xcba002 = g_xcba_m.xcba002
          , xcba003 = g_xcba_m.xcba003
          , xcba004 = g_xcba_m.xcba004
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xcbaownid = g_user 
       , xcbaowndp = g_dept
       , xcbacrtid = g_user
       , xcbacrtdp = g_dept 
       , xcbacrtdt = ld_date
       , xcbamodid = g_user
       , xcbamoddt = ld_date
      #, xcbastus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xcba_t SELECT * FROM axci115_detail
   
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
   DROP TABLE axci115_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcbald_t = g_xcba_m.xcbald
   LET g_xcba001_t = g_xcba_m.xcba001
   LET g_xcba002_t = g_xcba_m.xcba002
   LET g_xcba003_t = g_xcba_m.xcba003
   LET g_xcba004_t = g_xcba_m.xcba004
 
   
   DROP TABLE axci115_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axci115_delete()
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
   
   IF g_xcba_m.xcbald IS NULL
   OR g_xcba_m.xcba001 IS NULL
   OR g_xcba_m.xcba002 IS NULL
   OR g_xcba_m.xcba003 IS NULL
   OR g_xcba_m.xcba004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axci115_cl USING g_enterprise,g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci115_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axci115_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci115_master_referesh USING g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003, 
       g_xcba_m.xcba004 INTO g_xcba_m.xcba001,g_xcba_m.xcbald,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004, 
       g_xcba_m.xcba007,g_xcba_m.xcbald_desc,g_xcba_m.xcba004_desc
   
   #遮罩相關處理
   LET g_xcba_m_mask_o.* =  g_xcba_m.*
   CALL axci115_xcba_t_mask()
   LET g_xcba_m_mask_n.* =  g_xcba_m.*
   
   CALL axci115_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axci115_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcba_t WHERE xcbaent = g_enterprise AND xcbald = g_xcba_m.xcbald
                                                               AND xcba001 = g_xcba_m.xcba001
                                                               AND xcba002 = g_xcba_m.xcba002
                                                               AND xcba003 = g_xcba_m.xcba003
                                                               AND xcba004 = g_xcba_m.xcba004
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcba_t:",SQLERRMESSAGE 
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
      #   CLOSE axci115_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcba_d.clear() 
      CALL g_xcba2_d.clear()       
 
     
      CALL axci115_ui_browser_refresh()  
      #CALL axci115_ui_headershow()  
      #CALL axci115_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axci115_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axci115_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axci115_cl
 
   #功能已完成,通報訊息中心
   CALL axci115_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axci115.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axci115_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcba_d.clear()
   CALL g_xcba2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcbastus,xcba005,xcba006,xcba008,xcba009,xcba005,xcba006,xcbaownid, 
       xcbaowndp,xcbacrtid,xcbacrtdp,xcbacrtdt,xcbamodid,xcbamoddt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM xcba_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=xcba006 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=xcbaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=xcbaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=xcbacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=xcbacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=xcbamodid  ",
 
               " WHERE xcbaent= ? AND xcbald=? AND xcba001=? AND xcba002=? AND xcba003=? AND xcba004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcba_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axci115_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcba_t.xcba005,xcba_t.xcba006"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axci115_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axci115_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003,g_xcba_m.xcba004   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcba_m.xcbald,g_xcba_m.xcba001,g_xcba_m.xcba002,g_xcba_m.xcba003, 
          g_xcba_m.xcba004 INTO g_xcba_d[l_ac].xcbastus,g_xcba_d[l_ac].xcba005,g_xcba_d[l_ac].xcba006, 
          g_xcba_d[l_ac].xcba008,g_xcba_d[l_ac].xcba009,g_xcba2_d[l_ac].xcba005,g_xcba2_d[l_ac].xcba006, 
          g_xcba2_d[l_ac].xcbaownid,g_xcba2_d[l_ac].xcbaowndp,g_xcba2_d[l_ac].xcbacrtid,g_xcba2_d[l_ac].xcbacrtdp, 
          g_xcba2_d[l_ac].xcbacrtdt,g_xcba2_d[l_ac].xcbamodid,g_xcba2_d[l_ac].xcbamoddt,g_xcba_d[l_ac].xcba006_desc, 
          g_xcba2_d[l_ac].xcbaownid_desc,g_xcba2_d[l_ac].xcbaowndp_desc,g_xcba2_d[l_ac].xcbacrtid_desc, 
          g_xcba2_d[l_ac].xcbacrtdp_desc,g_xcba2_d[l_ac].xcbamodid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
#         LET g_xcba2_d[l_ac].xcba005 = g_xcba_d[l_ac].xcba005
#         LET g_xcba2_d[l_ac].xcba006 = g_xcba_d[l_ac].xcba006
#         SELECT ooefl003 INTO g_xcba2_d[l_ac].xcba006_2_desc FROM ooefl_t WHERE ooeflent=g_enterprise AND ooefl001=g_xcba2_d[l_ac].xcba006 AND ooefl002=g_dlang
         CALL axci115_glacl004(g_xcba_d[l_ac].xcba005) RETURNING g_xcba_d[l_ac].xcba005_desc
#         CALL axci115_glacl004(g_xcba2_d[l_ac].xcba005) RETURNING g_xcba2_d[l_ac].xcba005_2_desc
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
 
            CALL g_xcba_d.deleteElement(g_xcba_d.getLength())
      CALL g_xcba2_d.deleteElement(g_xcba2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcba_d.getLength()
      LET g_xcba_d_mask_o[l_ac].* =  g_xcba_d[l_ac].*
      CALL axci115_xcba_t_mask()
      LET g_xcba_d_mask_n[l_ac].* =  g_xcba_d[l_ac].*
   END FOR
   
   LET g_xcba2_d_mask_o.* =  g_xcba2_d.*
   FOR l_ac = 1 TO g_xcba2_d.getLength()
      LET g_xcba2_d_mask_o[l_ac].* =  g_xcba2_d[l_ac].*
      CALL axci115_xcba_t_mask()
      LET g_xcba2_d_mask_n[l_ac].* =  g_xcba2_d[l_ac].*
   END FOR
 
 
   FREE axci115_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axci115_idx_chk()
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
      IF g_detail_idx > g_xcba_d.getLength() THEN
         LET g_detail_idx = g_xcba_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcba_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcba_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcba2_d.getLength() THEN
         LET g_detail_idx = g_xcba2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcba2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcba2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axci115_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcba_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axci115_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcba_t
    WHERE xcbaent = g_enterprise AND xcbald = g_xcba_m.xcbald AND
                              xcba001 = g_xcba_m.xcba001 AND
                              xcba002 = g_xcba_m.xcba002 AND
                              xcba003 = g_xcba_m.xcba003 AND
                              xcba004 = g_xcba_m.xcba004 AND
 
          xcba005 = g_xcba_d_t.xcba005
      AND xcba006 = g_xcba_d_t.xcba006
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcba_t:",SQLERRMESSAGE 
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
 
{<section id="axci115.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axci115_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axci115.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axci115_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axci115.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axci115_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axci115.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axci115_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcba_d[l_ac].xcba005 = g_xcba_d_t.xcba005 
      AND g_xcba_d[l_ac].xcba006 = g_xcba_d_t.xcba006 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axci115_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axci115.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axci115_lock_b(ps_table,ps_page)
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
   #CALL axci115_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci115.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axci115_unlock_b(ps_table,ps_page)
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
 
{<section id="axci115.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axci115_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcbald,xcba001,xcba002,xcba003,xcba004",TRUE)
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
 
{<section id="axci115.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axci115_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcbald,xcba001,xcba002,xcba003,xcba004",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_required('xcba004',FALSE)  #fengmy 150109
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axci115.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axci115_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry('xcba006',TRUE)     #160701-00012#1 add
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axci115_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_glad007   LIKE glad_t.glad007           #160701-00012#1 add
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   #160701-00012#1-s-add
   LET l_glad007 = ''
   SELECT glad007 INTO l_glad007
     FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld = g_xcba_m.xcbald
      AND glad001 = g_xcba_d[l_ac].xcba005
   IF l_glad007 = 'N' OR cl_null(l_glad007) THEN
      CALL cl_set_comp_entry('xcba006',FALSE)
      LET g_xcba_d[l_ac].xcba006 = ' '
      LET g_xcba_d[l_ac].xcba008 = 'B'
      DISPLAY g_xcba_d[l_ac].xcba006,g_xcba_d[l_ac].xcba008     
   END IF
   #160701-00012#1-e-add
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axci115_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci115.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axci115_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci115.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axci115_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci115.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axci115_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci115.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axci115_default_search()
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
      LET ls_wc = ls_wc, " xcbald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcba001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcba002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcba003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcba004 = '", g_argv[05], "' AND "
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
 
{<section id="axci115.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axci115_fill_chk(ps_idx)
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
 
{<section id="axci115.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axci115_modify_detail_chk(ps_record)
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
         LET ls_return = "xcbastus"
      WHEN "s_detail2"
         LET ls_return = "xcba005_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axci115.mask_functions" >}
&include "erp/axc/axci115_mask.4gl"
 
{</section>}
 
{<section id="axci115.state_change" >}
    
 
{</section>}
 
{<section id="axci115.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axci115_set_pk_array()
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
   LET g_pk_array[1].values = g_xcba_m.xcbald
   LET g_pk_array[1].column = 'xcbald'
   LET g_pk_array[2].values = g_xcba_m.xcba001
   LET g_pk_array[2].column = 'xcba001'
   LET g_pk_array[3].values = g_xcba_m.xcba002
   LET g_pk_array[3].column = 'xcba002'
   LET g_pk_array[4].values = g_xcba_m.xcba003
   LET g_pk_array[4].column = 'xcba003'
   LET g_pk_array[5].values = g_xcba_m.xcba004
   LET g_pk_array[5].column = 'xcba004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci115.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axci115_msgcentre_notify(lc_state)
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
   CALL axci115_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci115.other_function" readonly="Y" >}
#科目編號欄位帶值
PRIVATE FUNCTION axci115_glacl004(p_xcba005)
DEFINE l_glaa004    LIKE glaa_t.glaa004
DEFINE r_glacl004   LIKE glacl_t.glacl004
DEFINE p_xcba005    LIKE xcba_t.xcba005
DEFINE l_glac017    LIKE glac_t.glac017    #160425-00014

   SELECT unique glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_m.xcbald 
   SELECT glacl004 INTO r_glacl004 FROM glacl_t
    WHERE glaclent = g_enterprise AND glacl001 = l_glaa004
      AND glacl002 = p_xcba005 AND glacl003 = g_dlang
  #160701-00012#1-s-mark    
  ##-160425-00014-add- 
  #SELECT glac017 INTO l_glac017 
  #  FROM glac_t
  # WHERE glacent = g_enterprise 
  #   AND glac001 = l_glaa004
  #   AND glac002 = p_xcba005
  #IF l_glac017 = 'Y' THEN
  #   CALL cl_set_comp_entry('xcba006',TRUE)
  #ELSE
  #   CALL cl_set_comp_entry('xcba006',FALSE)
  #   LET g_xcba_d[l_ac].xcba006 = ' '
  #   LET g_xcba_d[l_ac].xcba008 = 'B'
  #   DISPLAY g_xcba_d[l_ac].xcba006
  #   DISPLAY g_xcba_d[l_ac].xcba008
  #END IF
  ##-160425-00014-end- 
  #160701-00012#1-e-mark
   RETURN r_glacl004
END FUNCTION
#檢查會計科目是否存在及非統計類科目及非賬戶性質
#增加傳入參數 賬套p_ld，以便在主程式和子畫面都能使用 fengmy150109
PRIVATE FUNCTION axci115_xcba005_chk(p_ld,p_xcba005)
   DEFINE p_xcba005    LIKE xcba_t.xcba005
   DEFINE l_glaa004    LIKE glaa_t.glaa004
   DEFINE r_success    LIKE type_t.num5
   DEFINE p_ld         LIKE xcba_t.xcbald    #fengmy 150109
   LET r_success = TRUE
#   SELECT unique glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_m.xcbald #fengmy 150109 mark
   SELECT unique glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld #fengmy 150109 
   IF NOT cl_null(p_xcba005) THEN
      #檢查是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_xcba005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? ","agl-00141",0 ) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否是統制科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_xcba005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac003 != '1' ","agl-00142",0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否是賬戶性質科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_xcba005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac006 = '1' ","axc-00057",0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否為成本類科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_xcba005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glaa004||"' AND glac002 = ? AND glac007 = '5' ","axc-00091",0) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION
#整批複製
PRIVATE FUNCTION axci115_s01()
   DEFINE l_xradl003     LIKE type_t.chr80
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_date         LIKE xcba_t.xcbacrtdt
   DEFINE l_glaa004     LIKE glaa_t.glaa004
   DEFINE l_glaa004_1   LIKE glaa_t.glaa004
   #dorislai-20151027-add----(S)
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003
   #dorislai-20151027-add----(E)
   OPEN WINDOW w_axci115_s01 WITH FORM cl_ap_formpath("axc","axci115_s01")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_xcba_s.xcbald,g_xcba_s.xcba002,g_xcba_s.xcba003,g_xcba_s.xcbald_1,g_xcba_s.xcba002_1,g_xcba_s.xcba003_1
         BEFORE INPUT

           LET g_xcba_s.xcbald = g_xcba_m.xcbald

           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_xcba_s.xcbald
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_xcba_s.xcbald_desc = '', g_rtn_fields[1] , ''
           DISPLAY BY NAME g_xcba_s.xcbald_desc
           DISPLAY BY NAME g_xcba_s.xcbald
           LET g_xcba_s.xcba002_1 = YEAR(g_today)
           LET g_xcba_s.xcba003_1 = MONTH(g_today)
           SELECT glaald INTO g_xcba_s.xcbald_1 FROM glaa_t
             WHERE glaaent = g_enterprise AND glaa014 = 'Y' 
               AND glaacomp = (SELECT unique ooef017 FROM ooef_t where ooefent = g_enterprise AND ooef001 = g_site)
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_xcba_s.xcbald_1
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_xcba_s.xcbald_1_desc = '', g_rtn_fields[1] , ''    
           DISPLAY BY NAME g_xcba_s.xcbald_1,g_xcba_s.xcbald_1_desc,g_xcba_s.xcba002_1,g_xcba_s.xcba003_1
           
         AFTER FIELD xcbald
            IF NOT cl_null(g_xcba_s.xcbald) THEN
               IF NOT ap_chk_isExist(g_xcba_s.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  LET g_xcba_s.xcbald = ''
                  LET g_xcba_s.xcbald_desc = ''
                  DISPLAY BY NAME g_xcba_s.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_xcba_s.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',0) THEN  #160318-00005#46  mark
               IF NOT ap_chk_isExist(g_xcba_s.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN  #160318-00005#46  add
                  LET g_xcba_s.xcbald = ''
                  LET g_xcba_s.xcbald_desc = ''
                  DISPLAY BY NAME g_xcba_s.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_xcba_s.xcbald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_xcba_m.xcbald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcba_s.xcbald = ''
                  LET g_xcba_s.xcbald_desc = ''
                  DISPLAY BY NAME g_xcba_s.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT axci115_xcbald_xcba002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
#            IF NOT cl_null(g_xcba_s.xcbald) AND NOT cl_null(g_xcba_s.xcbald_1) THEN
#               SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald
#               SELECT glaacomp INTO l_glaacomp_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald_1
#               IF l_glaacomp != l_glaacomp_1 THEN
#                  CALL cl_err('','axc-00093',1)
#                  NEXT FIELD CURRENT
#               END IF
#            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_s.xcbald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_s.xcbald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_s.xcbald_desc

         AFTER FIELD xcba002
            IF NOT cl_null(g_xcba_s.xcba002) THEN
               IF g_xcba_s.xcba002 <1000 OR g_xcba_s.xcba002 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_xcba_s.xcba002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba_s.xcba002 =''
                  NEXT FIELD xcba002
               END IF
               IF NOT axci115_xcbald_xcba002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD xcba003
            IF NOT cl_null(g_xcba_s.xcba003) THEN
               IF (g_xcba_s.xcba003 < 1) OR (g_xcba_s.xcba003 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_xcba_s.xcba003
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba_s.xcba003 = ''
                  NEXT FIELD xcba003
               END IF
               IF NOT axci115_xcbald_xcba002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD xcbald_1
            IF NOT cl_null(g_xcba_s.xcbald_1) THEN
               IF NOT ap_chk_isExist(g_xcba_s.xcbald_1,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  LET g_xcba_s.xcbald_1 = ''
                  LET g_xcba_s.xcbald_1_desc = ''
                  DISPLAY BY NAME g_xcba_s.xcbald_1_desc
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_xcba_s.xcbald_1,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',0) THEN   #160318-00005#46  mark
               IF NOT ap_chk_isExist(g_xcba_s.xcbald_1,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN   #160318-00005#46  add
                  LET g_xcba_s.xcbald_1 = ''
                  LET g_xcba_s.xcbald_1_desc = ''
                  DISPLAY BY NAME g_xcba_s.xcbald_1_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_xcba_s.xcbald_1) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_xcba_m.xcbald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcba_s.xcbald_1 = ''
                  LET g_xcba_s.xcbald_1_desc = ''
                  DISPLAY BY NAME g_xcba_s.xcbald_1_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT axci115_xcbald_xcba002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald_1
#            IF NOT cl_null(g_xcba_s.xcbald) AND NOT cl_null(g_xcba_s.xcbald_1) THEN
#               SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald
#               SELECT glaacomp INTO l_glaacomp_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald_1
#               IF l_glaacomp != l_glaacomp_1 THEN
#                  CALL cl_err('','axc-00093',1)
#                  NEXT FIELD CURRENT
#               END IF
#            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_s.xcbald_1
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_s.xcbald_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_s.xcbald_1_desc

         AFTER FIELD xcba002_1
            IF NOT cl_null(g_xcba_s.xcba002_1) THEN
               IF g_xcba_s.xcba002_1 <1000 OR g_xcba_s.xcba002_1 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_xcba_s.xcba002_1
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba_s.xcba002_1 =''
                  NEXT FIELD xcba002_1
               END IF
               IF NOT axci115_xcbald_xcba002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD xcba003_1
            IF NOT cl_null(g_xcba_s.xcba003_1) THEN
               IF (g_xcba_s.xcba003_1 < 1) OR (g_xcba_s.xcba003_1 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_xcba_s.xcba003_1
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba_s.xcba003_1 = ''
                  NEXT FIELD xcba003_1
               END IF
               IF NOT axci115_xcbald_xcba002_chk() THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
 
        ON ACTION controlp INFIELD xcbald
            #add-point:ON ACTION controlp INFIELD xcbald
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba_s.xcbald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcba_s.xcbald = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_s.xcbald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_s.xcbald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_m.xcbald_desc

            DISPLAY g_xcba_s.xcbald TO xcbald              #顯示到畫面上

            NEXT FIELD xcbald 
            
         ON ACTION controlp INFIELD xcbald_1
            #add-point:ON ACTION controlp INFIELD xcbald_1
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba_s.xcbald_1             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcba_s.xcbald_1 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba_s.xcbald_1
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba_s.xcbald_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba_s.xcbald_1_desc

            DISPLAY g_xcba_s.xcbald_1 TO xcbald_1              #顯示到畫面上

            NEXT FIELD xcbald_1 

         AFTER INPUT
            IF NOT cl_null(g_xcba_s.xcbald) AND NOT cl_null(g_xcba_s.xcbald_1) THEN
               SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald
               SELECT glaa004 INTO l_glaa004_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald_1
               IF l_glaa004 != l_glaa004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00110'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xcbald
               END IF
            END IF
            CALL axci115_ins_xcba_s01(g_xcba_s.xcbald,g_xcba_s.xcba002,g_xcba_s.xcba003,g_xcba_s.xcbald_1,g_xcba_s.xcba002_1,g_xcba_s.xcba003_1)

      END INPUT

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION produce
         ACCEPT DIALOG

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG
   
   #畫面關閉
   CLOSE WINDOW w_axci115_s01
END FUNCTION
#整批生成
PRIVATE FUNCTION axci115_s02()
   DEFINE p_xrad001      LIKE xrad_t.xrad001
   DEFINE l_xradl003     LIKE type_t.chr80
   DEFINE l_wc           STRING
   DEFINE l_wc1          STRING
   DEFINE l_date         LIKE xcba_t.xcbacrtdt
   DEFINE  l_glaa004     LIKE glaa_t.glaa004    #170120-00055#1 add
   
   OPEN WINDOW w_axci115_s02 WITH FORM cl_ap_formpath("axc","axci115_s02")
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME  g_xcba2_s.xcba001,g_xcba2_s.xcbald,g_xcba2_s.xcba002,g_xcba2_s.xcba003,g_xcba2_s.xcba004,g_xcba2_s.xcba008,g_xcba2_s.xcba007
         BEFORE INPUT
           CALL cl_set_comp_required('xcba004',FALSE)  #fengmy 150109
           CALL cl_set_combo_scc('xcba001','8908') 
           CALL cl_set_combo_scc('xcba007','8909') 
           CALL cl_set_combo_scc('xcba008','8910') 
           LET g_xcba2_s.xcba002 = YEAR(g_today)
           LET g_xcba2_s.xcba003 = MONTH(g_today)
           SELECT glaald INTO g_xcba2_s.xcbald FROM glaa_t
             WHERE glaaent = g_enterprise AND glaa014 = 'Y' 
               AND glaacomp = (SELECT unique ooef017 FROM ooef_t where ooefent = g_enterprise AND ooef001 = g_site)
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_xcba2_s.xcbald
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_xcba2_s.xcbald_desc = '', g_rtn_fields[1] , '' 
           DISPLAY BY NAME g_xcba2_s.xcbald,g_xcba2_s.xcbald_desc,g_xcba2_s.xcba002,g_xcba2_s.xcba003
           IF g_xcba2_s.xcbald IS NOT NULL THEN
              SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba2_s.xcbald
           END IF           
           
          AFTER FIELD xcba001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba2_s.xcbald) AND NOT cl_null(g_xcba2_s.xcba001) AND NOT cl_null(g_xcba2_s.xcba002) AND NOT cl_null(g_xcba2_s.xcba003) AND NOT cl_null(g_xcba2_s.xcba004) THEN 
                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba2_s.xcbald ||"' AND "|| "xcba001 = '"||g_xcba2_s.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba2_s.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba2_s.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba2_s.xcba004 ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
                END IF
            END IF

         #----<<xcbald>>----
         #此段落由子樣板a02產生
         AFTER FIELD xcbald
            
            #add-point:AFTER FIELD xcbald
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba2_s.xcbald) AND NOT cl_null(g_xcba2_s.xcba001) AND NOT cl_null(g_xcba2_s.xcba002) AND NOT cl_null(g_xcba2_s.xcba003) AND NOT cl_null(g_xcba2_s.xcba004) THEN 
                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba2_s.xcbald ||"' AND "|| "xcba001 = '"||g_xcba2_s.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba2_s.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba2_s.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba2_s.xcba004 ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
                END IF
            END IF
            IF NOT cl_null(g_xcba2_s.xcbald) THEN
               IF NOT ap_chk_isExist(g_xcba2_s.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00055',0) THEN
                  LET g_xcba2_s.xcbald = ''
                  LET g_xcba2_s.xcbald_desc = ''
                  DISPLAY BY NAME g_xcba2_s.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_xcba2_s.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',0) THEN    #160318-00005#46  mark
               IF NOT ap_chk_isExist(g_xcba2_s.xcbald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN    #160318-00005#46  add
                  LET g_xcba2_s.xcbald = ''
                  LET g_xcba2_s.xcbald_desc = ''
                  DISPLAY BY NAME g_xcba2_s.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,g_xcba2_s.xcbald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_xcba2_s.xcbald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcba2_s.xcbald = ''
                  LET g_xcba2_s.xcbald_desc = ''
                  DISPLAY BY NAME g_xcba2_s.xcbald_desc
                  NEXT FIELD CURRENT
               END IF
            END IF

            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba2_s.xcbald

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba2_s.xcbald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba2_s.xcbald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba2_s.xcbald_desc

            #END add-point


         #此段落由子樣板a02產生
         AFTER FIELD xcba002
            
            #add-point:AFTER FIELD xcba002
            #此段落由子樣板a05產生
            #150812-00010#2 by 03538 mark--s
            #IF  NOT cl_null(g_xcba2_s.xcbald) AND NOT cl_null(g_xcba2_s.xcba001) AND NOT cl_null(g_xcba2_s.xcba002) AND NOT cl_null(g_xcba2_s.xcba003) AND NOT cl_null(g_xcba2_s.xcba004) THEN 
            #    IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba2_s.xcbald ||"' AND "|| "xcba001 = '"||g_xcba2_s.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba2_s.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba2_s.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba2_s.xcba004 ||"'",'std-00004',0) THEN 
            #       NEXT FIELD CURRENT
            #    END IF
            #END IF
            #150812-00010#2 by 03538 mark--e
            IF NOT cl_null(g_xcba2_s.xcba002) THEN
               IF g_xcba2_s.xcba002 <1000 OR g_xcba2_s.xcba002 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_xcba2_s.xcba002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba2_s.xcba002 =''
                  NEXT FIELD xcba002
               END IF
            END IF



            #END add-point

            #add-point:AFTER FIELD xcba003
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba2_s.xcbald) AND NOT cl_null(g_xcba2_s.xcba001) AND NOT cl_null(g_xcba2_s.xcba002) AND NOT cl_null(g_xcba2_s.xcba003) AND NOT cl_null(g_xcba2_s.xcba004) THEN 
                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba2_s.xcbald ||"' AND "|| "xcba001 = '"||g_xcba2_s.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba2_s.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba2_s.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba2_s.xcba004 ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
                END IF
            END IF

            IF NOT cl_null(g_xcba2_s.xcba003) THEN
               IF (g_xcba2_s.xcba003 < 1) OR (g_xcba2_s.xcba003 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_xcba2_s.xcba003
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_xcba2_s.xcba003 = ''
                  NEXT FIELD xcba003
               END IF
            END IF

            #END add-point

         #----<<xcba004>>----
         #此段落由子樣板a02產生
         AFTER FIELD xcba004
            
            #add-point:AFTER FIELD xcba004
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcba2_s.xcbald) AND NOT cl_null(g_xcba2_s.xcba001) AND NOT cl_null(g_xcba2_s.xcba002) AND NOT cl_null(g_xcba2_s.xcba003) AND NOT cl_null(g_xcba2_s.xcba004) THEN 
              #150914-Start-Mark
              # IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcba_t WHERE "||"xcbaent = '" ||g_enterprise|| "' AND "||"xcbald = '"||g_xcba2_s.xcbald ||"' AND "|| "xcba001 = '"||g_xcba2_s.xcba001 ||"' AND "|| "xcba002 = '"||g_xcba2_s.xcba002 ||"' AND "|| "xcba003 = '"||g_xcba2_s.xcba003 ||"' AND "|| "xcba004 = '"||g_xcba2_s.xcba004 ||"'",'std-00004',0) THEN 
              #    NEXT FIELD CURRENT
              # END IF
              #150914-End-Mark  
            END IF

            IF NOT cl_null(g_xcba2_s.xcba004) THEN
               IF NOT ap_chk_isExist(g_xcba2_s.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",1) THEN
                   LET g_xcba2_s.xcba004 = ''
                   LET g_xcba2_s.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba2_s.xcba004_desc
                   NEXT FIELD xcba004
                END IF
                #成本中心為利潤中心或者成本中心
                IF NOT ap_chk_isExist(g_xcba2_s.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND (ooeg003 = '2' OR ooeg003 = '3')","axc-00090",1) THEN
                   LET g_xcba2_s.xcba004 = ''
                   LET g_xcba2_s.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba2_s.xcba004_desc
                   NEXT FIELD xcba004
                END IF
#                IF NOT ap_chk_isExist(g_xcba2_s.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","abm-00007",1 ) THEN   #160318-00005#46  mark
                IF NOT ap_chk_isExist(g_xcba2_s.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","sub-01302",'aooi125' ) THEN   #160318-00005#46  add
                   LET g_xcba2_s.xcba004 = ''
                   LET g_xcba2_s.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba2_s.xcba004_desc
                   NEXT FIELD xcba004
                END IF
                #170120-00055#1 --- add (S) ---
                IF NOT ap_chk_isExist(g_xcba2_s.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooeg003 = '3' AND ooegstus = 'Y' AND (ooeg009 = '"||g_glaacomp||"' OR ooeg009 = 'ALL') ","axc-00824",1) THEN 
                   LET g_xcba2_s.xcba004 = ''
                   LET g_xcba2_s.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba2_s.xcba004_desc
                   NEXT FIELD xcba004
                END IF
                #170120-00055#1 --- add (E) ---
#                LET l_date = g_today
#                IF NOT ap_chk_isExist(g_xcba2_s.xcba004,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' AND (ooeg006 <= '" ||g_today||"' AND (ooeg007 IS NULL OR ooeg007 > '" ||g_today||"' )) ","aoo-00201",1 ) THEN
#                   LET g_xcba2_s.xcba004 = ''
#                   LET g_xcba2_s.xcba004_desc = ''
#                   DISPLAY BY NAME g_xcba2_s.xcba004_desc
#                   NEXT FIELD xcba004
#               END IF
               IF NOT ap_chk_isExist(g_xcba2_s.xcba004,"SELECT COUNT(*) FROM ooeg_t,ooef_t WHERE ooegent = ooefent AND ooeg001 = ooef001 AND ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND (ooef017 = '"||g_glaacomp||"' OR ooef017='ALL') AND ooegstus = 'Y' ","aoo-00201",1 ) THEN  #mod 150214 add ALL
                   LET g_xcba2_s.xcba004 = ''
                   LET g_xcba2_s.xcba004_desc = ''
                   DISPLAY BY NAME g_xcba2_s.xcba004_desc
                   NEXT FIELD xcba004
               END IF
            END IF
            IF cl_null(g_xcba2_s.xcba004) THEN LET g_xcba2_s.xcba004 = ' ' END IF  #fengmy150108 add
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba2_s.xcba004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba2_s.xcba004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba2_s.xcba004_desc

            #END add-point
            
         #----<<xcbald>>----
         #Ctrlp:input.c.xcbald
         ON ACTION controlp INFIELD xcbald
            #add-point:ON ACTION controlp INFIELD xcbald
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba2_s.xcbald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcba2_s.xcbald = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba2_s.xcbald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba2_s.xcbald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba2_s.xcbald_desc

            DISPLAY g_xcba2_s.xcbald TO xcbald              #顯示到畫面上

            NEXT FIELD xcbald                          #返回原欄位


            #END add-point

         #Ctrlp:input.c.xcba004
         ON ACTION controlp INFIELD xcba004
            #add-point:ON ACTION controlp INFIELD xcba004
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcba2_s.xcba004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = cl_get_today()    
            LET g_qryparam.where = " (ooeg009 = '",g_glaacomp,"' OR ooeg009 = 'ALL') "   #170120-00055#1 add

            CALL q_ooeg001_8()                                 #呼叫開窗

            LET g_xcba2_s.xcba004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcba2_s.xcba004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcba2_s.xcba004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcba2_s.xcba004_desc

            DISPLAY g_xcba2_s.xcba004 TO xcba004              #顯示到畫面上

            NEXT FIELD xcba004                          #返回原欄位


            #END add-point


         AFTER INPUT
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba2_s.xcbald   #fengmy 150109 add

      END INPUT
      
      CONSTRUCT BY NAME l_wc ON xcba006
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            
         #----<<xcba006>>----
         #Ctrlp:construct.c.page1.xcba006
         ON ACTION controlp INFIELD xcba006
            #add-point:ON ACTION controlp INFIELD xcba006
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			  LET g_qryparam.where = " (ooef017 = '",g_glaacomp,"' OR ooef017 = 'ALL') "  #fengmy150413			
            CALL q_ooeg001_71()                           #呼叫開窗  #fengmy150413
            DISPLAY g_qryparam.return1 TO xcba006  #顯示到畫面上

            NEXT FIELD xcba006                     #返回原欄位
            
      END CONSTRUCT
      
      CONSTRUCT BY NAME l_wc1 ON xcba005
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            
         ON ACTION controlp INFIELD xcba005
            #add-point:ON ACTION controlp INFIELD xcba005
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 != '1' AND glac006 = '1' "

            #給予arg
            #170120-00055#1 --- add (S) ---
            SELECT glaa004 INTO l_glaa004 FROM glaa_t 
             WHERE glaaent = g_enterprise AND glaald = g_xcba2_s.xcbald AND glaastus = 'Y'
            LET g_qryparam.where = g_qryparam.where, " AND glac001 = '",l_glaa004,"' AND glacstus = 'Y'"
            #170120-00055#1 --- add (E) ---
           #CALL aglt310_04()
            CALL q_glac002_5()
            DISPLAY g_qryparam.return1 TO xcba005  #顯示到畫面上
            NEXT FIELD xcba005 
      END CONSTRUCT  

      AFTER DIALOG
         CALL axci115_ins_xcba_s02(l_wc,l_wc1)

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION produce
         ACCEPT DIALOG

      ON ACTION off
         LET INT_FLAG = TRUE
         EXIT DIALOG


   END DIALOG
 
   


   #畫面關閉
   CLOSE WINDOW w_axci115_s02
END FUNCTION
#整批複製插入xcba_t
PRIVATE FUNCTION axci115_ins_xcba_s01(p_xcbald,p_xcba002,p_xcba003,p_xcbald_1,p_xcba002_1,p_xcba003_1)
DEFINE p_xcbald       LIKE xcba_t.xcbald
DEFINE p_xcba002      LIKE xcba_t.xcba002
DEFINE p_xcba003      LIKE xcba_t.xcba003
DEFINE p_xcbald_1     LIKE xcba_t.xcbald
DEFINE p_xcba002_1    LIKE xcba_t.xcba002
DEFINE p_xcba003_1    LIKE xcba_t.xcba003
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.chr1
#161109-00085#25-s mod
#DEFINE l_xcba         RECORD LIKE xcba_t.*   #161109-00085#25-s mark
DEFINE l_xcba         RECORD  #成本要素分攤設定檔
       xcbaent LIKE xcba_t.xcbaent, #企業編號
       xcbaownid LIKE xcba_t.xcbaownid, #資料所有者
       xcbaowndp LIKE xcba_t.xcbaowndp, #資料所屬部門
       xcbacrtid LIKE xcba_t.xcbacrtid, #資料建立者
       xcbacrtdp LIKE xcba_t.xcbacrtdp, #資料建立部門
       xcbacrtdt LIKE xcba_t.xcbacrtdt, #資料創建日
       xcbamodid LIKE xcba_t.xcbamodid, #資料修改者
       xcbamoddt LIKE xcba_t.xcbamoddt, #最近修改日
       xcbastus LIKE xcba_t.xcbastus, #狀態碼
       xcbald LIKE xcba_t.xcbald, #帳套
       xcba001 LIKE xcba_t.xcba001, #分攤類型
       xcba002 LIKE xcba_t.xcba002, #年度
       xcba003 LIKE xcba_t.xcba003, #期別
       xcba004 LIKE xcba_t.xcba004, #成本中心
       xcba005 LIKE xcba_t.xcba005, #科目編號
       xcba006 LIKE xcba_t.xcba006, #部門編號
       xcba007 LIKE xcba_t.xcba007, #分攤公式
       xcba008 LIKE xcba_t.xcba008, #部門屬性
      #xcba009 LIKE xcba_t.xcba009  #分攤權數 #161109-00085#63 mark
       #161109-00085#63 --s add
       xcba009 LIKE xcba_t.xcba009, #分攤權數
       xcbaud001 LIKE xcba_t.xcbaud001, #自定義欄位(文字)001
       xcbaud002 LIKE xcba_t.xcbaud002, #自定義欄位(文字)002
       xcbaud003 LIKE xcba_t.xcbaud003, #自定義欄位(文字)003
       xcbaud004 LIKE xcba_t.xcbaud004, #自定義欄位(文字)004
       xcbaud005 LIKE xcba_t.xcbaud005, #自定義欄位(文字)005
       xcbaud006 LIKE xcba_t.xcbaud006, #自定義欄位(文字)006
       xcbaud007 LIKE xcba_t.xcbaud007, #自定義欄位(文字)007
       xcbaud008 LIKE xcba_t.xcbaud008, #自定義欄位(文字)008
       xcbaud009 LIKE xcba_t.xcbaud009, #自定義欄位(文字)009
       xcbaud010 LIKE xcba_t.xcbaud010, #自定義欄位(文字)010
       xcbaud011 LIKE xcba_t.xcbaud011, #自定義欄位(數字)011
       xcbaud012 LIKE xcba_t.xcbaud012, #自定義欄位(數字)012
       xcbaud013 LIKE xcba_t.xcbaud013, #自定義欄位(數字)013
       xcbaud014 LIKE xcba_t.xcbaud014, #自定義欄位(數字)014
       xcbaud015 LIKE xcba_t.xcbaud015, #自定義欄位(數字)015
       xcbaud016 LIKE xcba_t.xcbaud016, #自定義欄位(數字)016
       xcbaud017 LIKE xcba_t.xcbaud017, #自定義欄位(數字)017
       xcbaud018 LIKE xcba_t.xcbaud018, #自定義欄位(數字)018
       xcbaud019 LIKE xcba_t.xcbaud019, #自定義欄位(數字)019
       xcbaud020 LIKE xcba_t.xcbaud020, #自定義欄位(數字)020
       xcbaud021 LIKE xcba_t.xcbaud021, #自定義欄位(日期時間)021
       xcbaud022 LIKE xcba_t.xcbaud022, #自定義欄位(日期時間)022
       xcbaud023 LIKE xcba_t.xcbaud023, #自定義欄位(日期時間)023
       xcbaud024 LIKE xcba_t.xcbaud024, #自定義欄位(日期時間)024
       xcbaud025 LIKE xcba_t.xcbaud025, #自定義欄位(日期時間)025
       xcbaud026 LIKE xcba_t.xcbaud026, #自定義欄位(日期時間)026
       xcbaud027 LIKE xcba_t.xcbaud027, #自定義欄位(日期時間)027
       xcbaud028 LIKE xcba_t.xcbaud028, #自定義欄位(日期時間)028
       xcbaud029 LIKE xcba_t.xcbaud029, #自定義欄位(日期時間)029
       xcbaud030 LIKE xcba_t.xcbaud030  #自定義欄位(日期時間)030
       #161109-00085#63 --e add
          END RECORD
#161109-00085#25-e mod

DEFINE l_n            LIKE type_t.num10 
DEFINE l_glaacomp     LIKE glaa_t.glaacomp
DEFINE l_glaacomp_1   LIKE glaa_t.glaacomp
DEFINE l_glaa004_1    LIKE glaa_t.glaa004
DEFINE l_glaa004      LIKE glaa_t.glaa004
DEFINE l_n1           LIKE type_t.num10 
DEFINE l_sum          LIKE type_t.num5      #計算分攤權數
DEFINE l_xcba005_t    LIKE xcba_t.xcba005   #科目編號舊值 
DEFINE l_xcba006_t    LIKE xcba_t.xcba006   #部門編號舊值 
DEFINE l_xcba009_t    LIKE xcba_t.xcba009   #分攤權數舊值 
DEFINE l_xcba004      LIKE xcba_t.xcba004   #成本中心
DEFINE l_xcba006      LIKE xcba_t.xcba005   #部門編號
DEFINE l_str          STRING

   #初始化
   LET l_success = 'Y'
   INITIALIZE l_xcba.* TO NULL

   #為空，則RETURN
   IF cl_null(p_xcbald) OR cl_null(p_xcba002) OR cl_null(p_xcba003) OR cl_null(p_xcbald_1) OR cl_null(p_xcba002_1) OR cl_null(p_xcba003_1) THEN
      RETURN
   END IF
    
   
   #检查来源账套与目的账套是否用的同一套科目表
   IF NOT cl_null(g_xcba_s.xcbald) AND NOT cl_null(g_xcba_s.xcbald_1) THEN
      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald
      SELECT glaa004 INTO l_glaa004_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald_1
      IF l_glaa004 != l_glaa004_1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00110'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF

#啟用事務
   CALL s_transaction_begin()
   
   CALL cl_showmsg_init()
   LET l_xcba.xcbaownid = g_user
   LET l_xcba.xcbaowndp = g_dept
   LET l_xcba.xcbacrtid = g_user
   LET l_xcba.xcbacrtdp = g_dept 
   LET l_xcba.xcbacrtdt = cl_get_current()
   LET l_n1 = 0

   #開始插入操作
   LET l_sql = " SELECT xcba001,xcba004,xcba005,xcba006,xcba007,xcba008,xcba009 FROM xcba_t ",
               " WHERE xcbaent = '",g_enterprise,"' AND xcbald = '",p_xcbald,"'",
               "   AND xcba002 = '",p_xcba002,"' AND xcba003 = '",p_xcba003,"'",
               "   ORDER BY xcba005,xcba006 "
   PREPARE xcba_s01_prep FROM l_sql
   DECLARE xcba_s01_curs CURSOR FOR xcba_s01_prep
   
   FOREACH xcba_s01_curs INTO l_xcba.xcba001,l_xcba.xcba004,l_xcba.xcba005,l_xcba.xcba006,
                              l_xcba.xcba007,l_xcba.xcba008,l_xcba.xcba009
       
       #前后兩筆部門編號或者會計科目不同
       IF l_xcba.xcba005 != l_xcba005_t OR l_xcba.xcba006 != l_xcba006_t THEN
          LET l_sum = 0
          #求目的帳套年期會計科目部門編號下的分攤權數
#          LET l_sql = " SELECT SUM(xcba009) FROM xcba_t ",
#                      "  WHERE xcbaent = ",g_enterprise," AND xcbald = '",p_xcbald_1,"'",
#                      "    AND xcba002 = ",p_xcba002_1," AND xcba003 = ",p_xcba003_1,   
#                      "　　AND xcba005 = '",l_xcba.xcba005,"' AND xcba006 = '",l_xcba.xcba006,"'"      
#          PREPARE xcba009_prep FROM l_sql
#          EXECUTE xcba009_prep INTO l_sum 
#          FREE xcba009_prep 
          SELECT SUM(xcba009) INTO l_sum FROM xcba_t 
            WHERE xcbaent = g_enterprise AND xcbald = p_xcbald_1
              AND xcba002 = p_xcba002_1 AND xcba003 = p_xcba003_1  
          　　AND xcba005 = l_xcba.xcba005 AND xcba006 = l_xcba.xcba006 
          IF cl_null(l_sum) THEN LET l_sum = 0 END IF 
       END IF 
    
       LET l_xcba005_t = l_xcba.xcba005 
       LET l_xcba006_t = l_xcba.xcba006        
       
       #若已經存在，则删除资料在进行新增       
       LET l_n = 0           
       SELECT COUNT(*) INTO l_n FROM xcba_t 
        WHERE xcbaent = g_enterprise   AND xcbald = p_xcbald_1
          AND xcba001 = l_xcba.xcba001 AND xcba002 = p_xcba002_1
          AND xcba003 = p_xcba003_1    AND xcba004 = l_xcba.xcba004
          AND xcba005 = l_xcba.xcba005 AND xcba006 = l_xcba.xcba006   

       IF l_n > 0 THEN
          #取分攤權數xcba009舊值
          SELECT xcba009 INTO l_xcba009_t FROM xcba_t 
           WHERE xcbaent = g_enterprise   AND xcbald = p_xcbald_1 
             AND xcba002 = p_xcba002_1
             AND xcba003 = p_xcba003_1   
             AND xcba005 = l_xcba.xcba005 AND xcba006 = l_xcba.xcba006
          
          #刪除已存在資料          
          DELETE FROM xcba_t 
           WHERE xcbaent = g_enterprise   AND xcbald = p_xcbald_1
             AND xcba001 = l_xcba.xcba001 AND xcba002 = p_xcba002_1
             AND xcba003 = p_xcba003_1    AND xcba004 = l_xcba.xcba004  
             AND xcba005 = l_xcba.xcba005 AND xcba006 = l_xcba.xcba006 
             
          LET l_sum = l_sum - l_xcba009_t   #若資料已存在，減去已存在的分攤權數
       END IF
       
       LET l_sum = l_sum + l_xcba.xcba009  #累計分攤權數
       IF cl_null(l_xcba.xcba004) THEN LET l_xcba.xcba004 = ' ' END IF  #fengmy150108 add
       LET l_n1 = 1
       #插入數據庫操作
       INSERT INTO xcba_t
                (xcbaent,
                 xcba001,xcbald,xcba002,xcba003,xcba004,xcba005,xcba006,xcba007,
                 xcbastus,xcba008,xcba009,xcbaownid,xcbaowndp,xcbacrtid,xcbacrtdp,xcbacrtdt) 
          VALUES(g_enterprise,
                 l_xcba.xcba001,p_xcbald_1,p_xcba002_1,p_xcba003_1,l_xcba.xcba004,l_xcba.xcba005,
                 l_xcba.xcba006,l_xcba.xcba007,'Y',l_xcba.xcba008,l_xcba.xcba009,
                 l_xcba.xcbaownid,l_xcba.xcbaowndp,l_xcba.xcbacrtid,l_xcba.xcbacrtdp,l_xcba.xcbacrtdt)
       IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
          LET l_success = 'N'
          EXIT FOREACH 
       END IF
       
       IF l_sum > 100 THEN
          LET l_str = p_xcbald_1,"/",p_xcba002_1,"/",p_xcba003_1,"/",l_xcba.xcba005,"/",l_xcba.xcba006
          CALL cl_errmsg('xcbald,xcba002,xcba003,xcba005,xcba006',l_str,'','axc-00077',1)
          LET l_success = 'N'
       END IF
         
   END FOREACH
   
   IF l_success = 'Y' THEN
      #检查来源账套与目的账套是否用的同一套科目表
      IF NOT cl_null(g_xcba_s.xcbald) AND NOT cl_null(g_xcba_s.xcbald_1) THEN
         SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald
         SELECT glaacomp INTO l_glaacomp_1 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba_s.xcbald_1
         IF l_glaacomp != l_glaacomp_1 THEN
            LET l_sql = " SELECT UNIQUE xcba004 FROM xcba_t,ooef_t ",
                        "  WHERE xcbaent = ooefent AND xcba004 = ooef001 ",
                        "    AND (ooef017 != '",l_glaacomp_1,"' OR ooef017 is null) ",
                        "    AND xcbaent = '",g_enterprise,"' AND xcbald ='",p_xcbald_1,"'",
                        "    AND xcba002 = ",p_xcba002_1," AND xcba003 = ",p_xcba003_1
            PREPARE xcba004_prep FROM l_sql
            DECLARE xcba004_curs CURSOR FOR xcba004_prep
            FOREACH xcba004_curs INTO l_xcba004
               LET l_str = p_xcbald_1,"/",l_xcba.xcba004
               CALL cl_errmsg('xcbald,xcba004',l_str,'','axc-00092',1)
            END FOREACH
            
            LET l_sql = " SELECT UNIQUE xcba006 FROM xcba_t,ooef_t ",
                        "  WHERE xcbaent = ooefent AND xcba006 = ooef001 ",
                        "    AND (ooef017 != '",l_glaacomp_1,"' OR ooef017 is null) ",
                        "    AND xcbaent = '",g_enterprise,"' AND xcbald ='",p_xcbald_1,"'",
                        "    AND xcba002 = ",p_xcba002_1," AND xcba003 = ",p_xcba003_1
            PREPARE xcba006_prep FROM l_sql
            DECLARE xcba006_curs CURSOR FOR xcba006_prep
            FOREACH xcba006_curs INTO l_xcba006
               LET l_str = p_xcbald_1,"/",l_xcba.xcba006
               CALL cl_errmsg('xcbald,xcba006',l_str,'','axc-00092',1)
            END FOREACH
            
         END IF
      END IF
   END IF 
   
   CALL cl_err_showmsg()
   
#結束事務
   CALL s_transaction_end(l_success,1)

END FUNCTION
#檢查目的帳套年度期別與來源帳套年度期別不能相等
PRIVATE FUNCTION axci115_xcbald_xcba002_chk()
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   
   IF NOT cl_null(g_xcba_s.xcbald) AND NOT cl_null(g_xcba_s.xcba002) AND NOT cl_null(g_xcba_s.xcba003) 
      AND NOT cl_null(g_xcba_s.xcbald_1) AND NOT cl_null(g_xcba_s.xcba002_1) AND NOT cl_null(g_xcba_s.xcba003_1) THEN
      IF g_xcba_s.xcbald = g_xcba_s.xcbald_1 AND g_xcba_s.xcba002 = g_xcba_s.xcba002_1 
         AND g_xcba_s.xcba003 = g_xcba_s.xcba003_1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00060'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
      END IF
      
   END IF
   RETURN r_success
END FUNCTION
#整批生成插入xcba_t
PRIVATE FUNCTION axci115_ins_xcba_s02(p_wc,p_wc1)
DEFINE p_wc           STRING
DEFINE p_wc1          STRING
DEFINE l_sql1          STRING
DEFINE l_success      LIKE type_t.chr1
#161109-00085#25-s mod
#DEFINE l_xcba         RECORD LIKE xcba_t.*   #161109-00085#25-s mark
DEFINE l_xcba         RECORD  #成本要素分攤設定檔
       xcbaent LIKE xcba_t.xcbaent, #企業編號
       xcbaownid LIKE xcba_t.xcbaownid, #資料所有者
       xcbaowndp LIKE xcba_t.xcbaowndp, #資料所屬部門
       xcbacrtid LIKE xcba_t.xcbacrtid, #資料建立者
       xcbacrtdp LIKE xcba_t.xcbacrtdp, #資料建立部門
       xcbacrtdt LIKE xcba_t.xcbacrtdt, #資料創建日
       xcbamodid LIKE xcba_t.xcbamodid, #資料修改者
       xcbamoddt LIKE xcba_t.xcbamoddt, #最近修改日
       xcbastus LIKE xcba_t.xcbastus, #狀態碼
       xcbald LIKE xcba_t.xcbald, #帳套
       xcba001 LIKE xcba_t.xcba001, #分攤類型
       xcba002 LIKE xcba_t.xcba002, #年度
       xcba003 LIKE xcba_t.xcba003, #期別
       xcba004 LIKE xcba_t.xcba004, #成本中心
       xcba005 LIKE xcba_t.xcba005, #科目編號
       xcba006 LIKE xcba_t.xcba006, #部門編號
       xcba007 LIKE xcba_t.xcba007, #分攤公式
       xcba008 LIKE xcba_t.xcba008, #部門屬性
      #xcba009 LIKE xcba_t.xcba009  #分攤權數 #161109-00085#63 mark
       #161109-00085#63 --s add
       xcba009 LIKE xcba_t.xcba009, #分攤權數
       xcbaud001 LIKE xcba_t.xcbaud001, #自定義欄位(文字)001
       xcbaud002 LIKE xcba_t.xcbaud002, #自定義欄位(文字)002
       xcbaud003 LIKE xcba_t.xcbaud003, #自定義欄位(文字)003
       xcbaud004 LIKE xcba_t.xcbaud004, #自定義欄位(文字)004
       xcbaud005 LIKE xcba_t.xcbaud005, #自定義欄位(文字)005
       xcbaud006 LIKE xcba_t.xcbaud006, #自定義欄位(文字)006
       xcbaud007 LIKE xcba_t.xcbaud007, #自定義欄位(文字)007
       xcbaud008 LIKE xcba_t.xcbaud008, #自定義欄位(文字)008
       xcbaud009 LIKE xcba_t.xcbaud009, #自定義欄位(文字)009
       xcbaud010 LIKE xcba_t.xcbaud010, #自定義欄位(文字)010
       xcbaud011 LIKE xcba_t.xcbaud011, #自定義欄位(數字)011
       xcbaud012 LIKE xcba_t.xcbaud012, #自定義欄位(數字)012
       xcbaud013 LIKE xcba_t.xcbaud013, #自定義欄位(數字)013
       xcbaud014 LIKE xcba_t.xcbaud014, #自定義欄位(數字)014
       xcbaud015 LIKE xcba_t.xcbaud015, #自定義欄位(數字)015
       xcbaud016 LIKE xcba_t.xcbaud016, #自定義欄位(數字)016
       xcbaud017 LIKE xcba_t.xcbaud017, #自定義欄位(數字)017
       xcbaud018 LIKE xcba_t.xcbaud018, #自定義欄位(數字)018
       xcbaud019 LIKE xcba_t.xcbaud019, #自定義欄位(數字)019
       xcbaud020 LIKE xcba_t.xcbaud020, #自定義欄位(數字)020
       xcbaud021 LIKE xcba_t.xcbaud021, #自定義欄位(日期時間)021
       xcbaud022 LIKE xcba_t.xcbaud022, #自定義欄位(日期時間)022
       xcbaud023 LIKE xcba_t.xcbaud023, #自定義欄位(日期時間)023
       xcbaud024 LIKE xcba_t.xcbaud024, #自定義欄位(日期時間)024
       xcbaud025 LIKE xcba_t.xcbaud025, #自定義欄位(日期時間)025
       xcbaud026 LIKE xcba_t.xcbaud026, #自定義欄位(日期時間)026
       xcbaud027 LIKE xcba_t.xcbaud027, #自定義欄位(日期時間)027
       xcbaud028 LIKE xcba_t.xcbaud028, #自定義欄位(日期時間)028
       xcbaud029 LIKE xcba_t.xcbaud029, #自定義欄位(日期時間)029
       xcbaud030 LIKE xcba_t.xcbaud030  #自定義欄位(日期時間)030
       #161109-00085#63 --e add
          END RECORD
#161109-00085#25-e mod
DEFINE l_n            LIKE type_t.num10  
DEFINE l_glaa004      LIKE glaa_t.glaa004
DEFINE l_n1           LIKE type_t.num10 

#初始化
   LET l_success = 'N'
   INITIALIZE l_xcba.* TO NULL

#啟用事務
   CALL s_transaction_begin()
   
   LET l_xcba.xcbaownid = g_user
   LET l_xcba.xcbaowndp = g_dept
   LET l_xcba.xcbacrtid = g_user
   LET l_xcba.xcbacrtdp = g_dept 
   LET l_xcba.xcbacrtdt = cl_get_current()
   LET l_xcba.xcba009 = 100  #mod 150214 0->100
   
   SELECT unique glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xcba2_s.xcbald

   #開始插入操作
#   LET l_sql = " SELECT unique xcba005,xcba006,xcba009 FROM xcba_t ",
#               " WHERE xcbaent = '",g_enterprise,"' AND ",p_wc
#   PREPARE xcba_s02_prep FROM l_sql
#   DECLARE xcba_s02_curs CURSOR FOR xcba_s02_prep
   LET p_wc = cl_replace_str(p_wc,"xcba006","ooeg001")
   LET p_wc1 = cl_replace_str(p_wc1,"xcba005","glac002")
   LET l_sql1 = " SELECT unique ooeg001 FROM ooeg_t,ooef_t ",
               " WHERE ooefent = ooegent AND ooef001 = ooeg001 ",
               "   AND ooegent = '",g_enterprise,"' AND ooegstus = 'Y'",
#               "   AND (ooeg006 <= '" ,g_today,"' AND (ooeg007 IS NULL OR ooeg007 > '",g_today,"'))",    #fengmy 150109 mark
               "   AND ((ooeg006 <= '" ,g_today,"' OR ooeg006 IS NULL) AND (ooeg007 IS NULL OR ooeg007 > '",g_today,"'))",    #fengmy 150109
               "   AND (ooef017 = '",g_glaacomp,"' OR ooef017 = 'ALL')",   #wujie 150226 add ALL
               "   AND ",p_wc
   PREPARE ooeg_s02_prep FROM l_sql1
   DECLARE ooeg_s02_curs CURSOR FOR ooeg_s02_prep
  
  LET l_sql1 = " SELECT unique glac002 FROM glac_t ",
               " WHERE glacent = '",g_enterprise,"' AND glacstus = 'Y'",
               "   AND glac001 = '",l_glaa004,"' AND glac003 != '1' ",
               "   AND glac006 = '1' AND glac007 = '5' AND ",p_wc1

   PREPARE glac_s02_prep FROM l_sql1
   DECLARE glac_s02_curs CURSOR FOR glac_s02_prep
   
#  FOREACH xcba_s02_curs INTO l_xcba.xcba005,l_xcba.xcba006,l_xcba.xcba009
   
   FOREACH ooeg_s02_curs INTO l_xcba.xcba006
   
      FOREACH glac_s02_curs INTO l_xcba.xcba005
   
       IF NOT cl_null(l_xcba.xcba005) THEN
#          IF NOT axci115_xcba005_chk(l_xcba.xcba005) THEN  #fengmy 150109 mark
          IF NOT axci115_xcba005_chk(g_xcba2_s.xcbald,l_xcba.xcba005) THEN  #fengmy 150109
             LET l_success = 'N'
             EXIT FOREACH
          END IF
       END IF
           
       IF NOT cl_null(l_xcba.xcba006) THEN
          IF NOT ap_chk_isExist(l_xcba.xcba006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",0) THEN
              LET l_success = 'N'
             EXIT FOREACH
           END IF
#           IF NOT ap_chk_isExist(l_xcba.xcba006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","abm-00007",0 ) THEN  #160318-00005#16  mark
           IF NOT ap_chk_isExist(l_xcba.xcba006,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","sub-01302",'aooi125' ) THEN  #160318-00005#46  add
              LET l_success = 'N'
             EXIT FOREACH
          END IF
       END IF    
       
       #先檢查是否已經有存在資料,若有則跳過
       LET l_n = 0           
       SELECT COUNT(*) INTO l_n FROM xcba_t 
        WHERE xcbaent = g_enterprise      AND xcbald = g_xcba2_s.xcbald
          AND xcba001 = g_xcba2_s.xcba001 AND xcba002 = g_xcba2_s.xcba002
          AND xcba003 = g_xcba2_s.xcba003 AND xcba004 = g_xcba2_s.xcba004
          AND xcba005 = l_xcba.xcba005    AND xcba006 = l_xcba.xcba006   

       IF l_n > 0 THEN
          CONTINUE FOREACH
       END IF
       IF cl_null(g_xcba2_s.xcba004) THEN LET g_xcba2_s.xcba004 = ' ' END IF  #fengmy150108 add 
       #插入數據庫操作
       LET l_success = 'Y' 
       INSERT INTO xcba_t
                (xcbaent,
                 xcba001,xcbald,xcba002,xcba003,xcba004,xcba005,xcba006,xcba007,
                 xcbastus,xcba008,xcba009,xcbaownid,xcbaowndp,xcbacrtid,xcbacrtdp,xcbacrtdt) 
          VALUES(g_enterprise,
                 g_xcba2_s.xcba001,g_xcba2_s.xcbald,g_xcba2_s.xcba002,g_xcba2_s.xcba003,g_xcba2_s.xcba004,
                 l_xcba.xcba005,l_xcba.xcba006,g_xcba2_s.xcba007,'Y',g_xcba2_s.xcba008,l_xcba.xcba009,
                 l_xcba.xcbaownid,l_xcba.xcbaowndp,l_xcba.xcbacrtid,l_xcba.xcbacrtdp,l_xcba.xcbacrtdt)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            LET l_success = 'N'
            EXIT FOREACH 
         END IF
      END FOREACH
      IF l_success = 'N' THEN
         EXIT FOREACH
      END IF
  END FOREACH

#結束事務
   CALL s_transaction_end(l_success,1)
END FUNCTION

################################################################################
# Descriptions...: 新增/查詢時，預帶單頭欄位
# Memo...........:
# Usage..........: CALL axci115_head_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151023 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axci115_head_default()
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003


   CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
   IF cl_null(g_xcba_m.xcbald) THEN
      LET g_xcba_m.xcbald = l_ld
      DISPLAY BY NAME g_xcba_m.xcbald
   END IF
   IF cl_null(g_xcba_m.xcba002) THEN
      LET g_xcba_m.xcba002 = l_year
      DISPLAY BY NAME g_xcba_m.xcba002
   END IF
   IF cl_null(g_xcba_m.xcba003) THEN
      LET g_xcba_m.xcba003 = l_period
      DISPLAY BY NAME g_xcba_m.xcba003
   END IF
#151116 Sarah mark -----(S)
#秋玲說成本中心不要帶預設值
#   IF cl_null(g_xcba_m.xcba004) THEN
#      LET g_xcba_m.xcba004 = l_calc_type
#      DISPLAY BY NAME g_xcba_m.xcba004
#   END IF
#151116 Sarah mark -----(E)
END FUNCTION

################################################################################
# Descriptions...: 整批刪除
# Memo...........:
# Usage..........: CALL axci115_s03()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/01/04 By Dorislai(151022-00008#3)
# Modify.........:
################################################################################
PRIVATE FUNCTION axci115_s03()
   DEFINE l_wc  STRING
   
   OPEN WINDOW w_axci115_s03 WITH FORM cl_ap_formpath("axc","axci115_s03")   
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT  l_wc ON xcba001,xcbald,xcba004,xcba007,xcba005,xcba006,xcba008,xcba009
           FROM xcba001_01,xcbald_01,xcba004_01,xcba007_01,xcba005_01,xcba006_01,xcba008_01,xcba009_01
                                
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            CALL cl_set_combo_scc('xcba001_01','8908') 
            CALL cl_set_combo_scc('xcba007_01','8909') 
            CALL cl_set_combo_scc('xcba008_01','8910')  
            LET g_xcba3_s.xcba002_01 = g_xcba_m.xcba002
            LET g_xcba3_s.xcba003_01 = g_xcba_m.xcba003
            DISPLAY BY NAME g_xcba3_s.xcba002_01,g_xcba3_s.xcba003_01  
         
         AFTER FIELD xcbald_01
            LET g_xcba3_s.xcbald_01 = GET_FLDBUF(xcbald_01)
            CALL axci115_s03_desc('xcbald_01',g_xcba3_s.xcbald_01) RETURNING g_xcba3_s.xcbald_01_desc
            DISPLAY BY NAME g_xcba3_s.xcbald_01_desc
         AFTER FIELD xcba004_01
            LET g_xcba3_s.xcba004_01 = GET_FLDBUF(xcba004_01)
            CALL axci115_s03_desc('xcba004_01',g_xcba3_s.xcba004_01) RETURNING g_xcba3_s.xcba004_01_desc
            DISPLAY BY NAME g_xcba3_s.xcba004_01_desc
         AFTER FIELD xcba005_01
            LET g_xcba3_s.xcba005_01 = GET_FLDBUF(xcba005_01)
            CALL axci115_s03_desc('xcba005_01',g_xcba3_s.xcba005_01) RETURNING g_xcba3_s.xcba005_01_desc
            DISPLAY BY NAME g_xcba3_s.xcba005_01_desc
         AFTER FIELD xcba006_01
            LET g_xcba3_s.xcba006_01 = GET_FLDBUF(xcba006_01)
            CALL axci115_s03_desc('xcba006_01',g_xcba3_s.xcba006_01) RETURNING g_xcba3_s.xcba006_01_desc
            DISPLAY BY NAME g_xcba3_s.xcba006_01_desc

         ON ACTION controlp INFIELD xcbald_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                   #呼叫開窗 
            LET g_xcba3_s.xcbald_01 = g_qryparam.return1
            CALL axci115_s03_desc('xcbald_01',g_xcba3_s.xcbald_01) RETURNING g_xcba3_s.xcbald_01_desc
            DISPLAY BY NAME g_xcba3_s.xcbald_01,g_xcba3_s.xcbald_01_desc
            NEXT FIELD xcbald_01                     #返回原欄位
            
         ON ACTION controlp INFIELD xcba004_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_3()                        #呼叫開窗 
            LET g_xcba3_s.xcba004_01 = g_qryparam.return1
            CALL axci115_s03_desc('xcba004_01',g_xcba3_s.xcba004_01) RETURNING g_xcba3_s.xcba004_01_desc
            DISPLAY BY NAME g_xcba3_s.xcba004_01,g_xcba3_s.xcba004_01_desc
            NEXT FIELD xcba004_01                     #返回原欄位
            
         ON ACTION controlp INFIELD xcba005_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_glac002_5()                        #呼叫開窗 
            LET g_xcba3_s.xcba005_01 = g_qryparam.return1
            CALL axci115_s03_desc('xcba005_01',g_xcba3_s.xcba005_01) RETURNING g_xcba3_s.xcba005_01_desc
            DISPLAY BY NAME g_xcba3_s.xcba005_01,g_xcba3_s.xcba005_01_desc
            NEXT FIELD xcba005_01                     #返回原欄位
            
         ON ACTION controlp INFIELD xcba006_01
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_9()                           #呼叫開窗
            CALL q_ooef001_2()
            #mod--161013-00051#1 By shiun--(E)
            LET g_xcba3_s.xcba006_01 = g_qryparam.return1
            CALL axci115_s03_desc('xcba006_01',g_xcba3_s.xcba006_01) RETURNING g_xcba3_s.xcba006_01_desc
            DISPLAY BY NAME g_xcba3_s.xcba006_01,g_xcba3_s.xcba006_01_desc
            NEXT FIELD xcba006_01                     #返回原欄位
            
         
      END CONSTRUCT
      
      BEFORE DIALOG
         
      AFTER DIALOG
         
      
      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
      ON ACTION confirm
         IF cl_ask_confirm('axc-00751') THEN  
            CALL axci115_del_xcba_s03(l_wc)
            ACCEPT DIALOG
         ELSE
            LET INT_FLAG = TRUE
            EXIT DIALOG
         END IF

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG
   END DIALOG
   #畫面關閉
   CLOSE WINDOW w_axci115_s03
#   LET g_error_show = 1
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "xcba_t" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
   CALL axci115_browser_fill("")
END FUNCTION

################################################################################
# Descriptions...: 整批刪除xcba_t
# Memo...........:
# Usage..........: CALL axci115_del_xcba_s03()
# Input parameter: p_wc  SQL條件
# Return code....: 
# Date & Author..: 2015/01/05 By Dorislai(151022-00008#3)
# Modify.........:
################################################################################
PRIVATE FUNCTION axci115_del_xcba_s03(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   #啟用事務
   CALL s_transaction_begin()
   
   IF cl_null(p_wc) THEN
      LET p_wc = '1=1'
   END IF
   IF NOT cl_null(g_xcba3_s.xcba002_01) THEN
      LET p_wc = p_wc CLIPPED," AND xcba002 = ",g_xcba3_s.xcba002_01
   END IF
   IF NOT cl_null(g_xcba3_s.xcba003_01) THEN
      LET p_wc = p_wc CLIPPED," AND xcba003 = ",g_xcba3_s.xcba003_01
   END IF
   
   #LET l_sql = " SELECT COUNT(1) FROM xcba_t WHERE ",p_wc  #170120-00046#1 mark
   LET l_sql = " SELECT COUNT(1) FROM xcba_t WHERE xcbaent =",g_enterprise," AND ",p_wc  #170120-00046#1 
   
   LET l_cnt = 0
   PREPARE cnt_s03_pre FROM l_sql
   EXECUTE cnt_s03_pre INTO l_cnt
   FREE cnt_s03_pre
   LET l_success = TRUE
   #若xcba_t裡面有值，則進行刪除
   IF l_cnt > 0 THEN
      #LET l_sql = "DELETE FROM xcba_t WHERE ",p_wc  #170120-00046#1 mark
      LET l_sql = "DELETE FROM xcba_t WHERE xcbaent =",g_enterprise," AND ",p_wc  #170120-00046#1
      PREPARE del_s03_pre FROM l_sql
      EXECUTE del_s03_pre
      #刪除失敗      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcba_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
      FREE del_s03_pre
   ELSE
      LET l_success = FALSE   
   END IF
   
   IF l_success THEN
      CALL cl_ask_pressanykey("adz-00217") #執行成功
      CALL s_transaction_end('Y','0')
   ELSE
      CALL cl_ask_pressanykey("adz-00218") #執行失敗
      CALL s_transaction_end('N','0')
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 給說明值
# Memo...........:
# Usage..........: CALL axci115_s03_desc(p_field,p_value)
#                  RETURNING r_desc
# Input parameter: p_field   欄位名稱
#                : p_value   欄位值
# Return code....: r_desc    說明值
# Date & Author..: 2016/01/05 By Dorislai(151022-00008#3)
# Modify.........:
################################################################################
PRIVATE FUNCTION axci115_s03_desc(p_field,p_value)
   DEFINE p_field STRING
   DEFINE p_value LIKE type_t.chr1000
   DEFINE r_desc  LIKE type_t.chr1000
   
   CASE
      WHEN p_field = 'xcbald_01'
         SELECT glaal002 INTO r_desc
           FROM glaal_t
          WHERE glaalent = g_enterprise
            AND glaalld = g_xcba3_s.xcbald_01
            AND glaal001 = g_dlang
      WHEN p_field = 'xcba004_01'
         SELECT ooefl003 INTO r_desc 
           FROM ooefl_t
          WHERE ooeflent = g_enterprise
            AND ooefl001 = g_xcba3_s.xcba004_01
            AND ooefl002 = g_dlang
      WHEN p_field = 'xcba005_01'
         SELECT glacl004 INTO r_desc
           FROM glacl_t
          WHERE glaclent = g_enterprise
            AND glacl002 = g_xcba3_s.xcba005_01
            AND glacl003 = g_dlang
      WHEN p_field = 'xcba006_01'
         SELECT ooefl003 INTO r_desc
           FROM ooefl_t
          WHERE ooeflent = g_enterprise
            AND ooefl001 = g_xcba3_s.xcba006_01
            AND ooefl002 = g_dlang
   END CASE
   RETURN r_desc
END FUNCTION

 
{</section>}
 
