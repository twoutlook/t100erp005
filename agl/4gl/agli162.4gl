#該程式未解開Section, 採用最新樣板產出!
{<section id="agli162.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-07-04 18:28:40), PR版次:0002(2016-08-26 11:37:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: agli162
#+ Description: 綜合損益科目期末結轉設定作業
#+ Creator....: 07900(2016-07-04 16:30:26)
#+ Modifier...: 07900 -SD/PR- 02599
 
{</section>}
 
{<section id="agli162.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
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
PRIVATE type type_g_glch_m        RECORD
       glchld LIKE glch_t.glchld, 
   glchld_desc LIKE type_t.chr80, 
   glaacomp LIKE glaa_t.glaacomp, 
   glaacomp_desc LIKE type_t.chr80, 
   glch001 LIKE glch_t.glch001
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glch_d        RECORD
       glchstus LIKE glch_t.glchstus, 
   glch002 LIKE glch_t.glch002, 
   glch002_desc LIKE type_t.chr500, 
   glch003 LIKE glch_t.glch003, 
   glch003_desc LIKE type_t.chr500, 
   glch004 LIKE glch_t.glch004, 
   glch004_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_glch2_d RECORD
       glch002 LIKE glch_t.glch002, 
   glchownid LIKE glch_t.glchownid, 
   glchownid_desc LIKE type_t.chr500, 
   glchowndp LIKE glch_t.glchowndp, 
   glchowndp_desc LIKE type_t.chr500, 
   glchcrtid LIKE glch_t.glchcrtid, 
   glchcrtid_desc LIKE type_t.chr500, 
   glchcrtdp LIKE glch_t.glchcrtdp, 
   glchcrtdp_desc LIKE type_t.chr500, 
   glchcrtdt DATETIME YEAR TO SECOND, 
   glchmodid LIKE glch_t.glchmodid, 
   glchmodid_desc LIKE type_t.chr500, 
   glchmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#帐别
DEFINE g_glchld      LIKE glch_t.glchld
DEFINE g_glaacomp    LIKE glaa_t.glaacomp
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_glch_m          type_g_glch_m
DEFINE g_glch_m_t        type_g_glch_m
DEFINE g_glch_m_o        type_g_glch_m
DEFINE g_glch_m_mask_o   type_g_glch_m #轉換遮罩前資料
DEFINE g_glch_m_mask_n   type_g_glch_m #轉換遮罩後資料
 
   DEFINE g_glchld_t LIKE glch_t.glchld
DEFINE g_glch001_t LIKE glch_t.glch001
 
 
DEFINE g_glch_d          DYNAMIC ARRAY OF type_g_glch_d
DEFINE g_glch_d_t        type_g_glch_d
DEFINE g_glch_d_o        type_g_glch_d
DEFINE g_glch_d_mask_o   DYNAMIC ARRAY OF type_g_glch_d #轉換遮罩前資料
DEFINE g_glch_d_mask_n   DYNAMIC ARRAY OF type_g_glch_d #轉換遮罩後資料
DEFINE g_glch2_d   DYNAMIC ARRAY OF type_g_glch2_d
DEFINE g_glch2_d_t type_g_glch2_d
DEFINE g_glch2_d_o type_g_glch2_d
DEFINE g_glch2_d_mask_o   DYNAMIC ARRAY OF type_g_glch2_d #轉換遮罩前資料
DEFINE g_glch2_d_mask_n   DYNAMIC ARRAY OF type_g_glch2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_glchld LIKE glch_t.glchld,
      b_glch001 LIKE glch_t.glch001
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
 
{<section id="agli162.main" >}
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
   LET g_forupd_sql = " SELECT glchld,'','','',glch001", 
                      " FROM glch_t",
                      " WHERE glchent= ? AND glchld=? AND glch001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli162_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glchld,t0.glch001,t1.glaal002",
               " FROM glch_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.glchld AND t1.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.glchent = " ||g_enterprise|| " AND t0.glchld = ? AND t0.glch001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agli162_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agli162 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agli162_init()   
 
      #進入選單 Menu (="N")
      CALL agli162_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agli162
      
   END IF 
   
   CLOSE agli162_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agli162.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agli162_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_pass        LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   #获取账别  
      CALL s_ld_bookno()  RETURNING l_success,g_glchld
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_glchld) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glchld
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF  
    #获取法人
     SELECT glaacomp INTO g_glaacomp
       FROM glaa_t
      WHERE glaaent = g_enterprise AND glaald = g_glchld   
      
   #end add-point
   
   CALL agli162_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agli162.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agli162_ui_dialog()
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
         INITIALIZE g_glch_m.* TO NULL
         CALL g_glch_d.clear()
         CALL g_glch2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agli162_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_glch_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL agli162_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL agli162_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_glch2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL agli162_idx_chk()
               CALL agli162_ui_detailshow()
               
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
            CALL agli162_browser_fill("")
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
               CALL agli162_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agli162_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agli162_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli162_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agli162_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli162_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agli162_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli162_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agli162_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli162_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agli162_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli162_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_glch_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_glch2_d)
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
               NEXT FIELD glch002
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
               CALL agli162_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL agli162_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL agli162_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL agli162_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agli162_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agli162_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agli162_insert()
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
               CALL agli162_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agli162_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agli162_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agli162_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agli162_set_pk_array()
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
 
{<section id="agli162.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION agli162_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agli162.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agli162_browser_fill(ps_page_action)
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
   DEFINE l_ld_str   STRING   #160811-00039#6
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   #160811-00039#6--add--str--
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glchld")
   IF cl_null(g_wc) THEN
      LET g_wc = l_ld_str
   ELSE
      LET g_wc = g_wc," AND ",l_ld_str
   END IF
   #160811-00039#6--add--end
   #end add-point    
 
   LET l_searchcol = "glchld,glch001"
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
      LET l_sub_sql = " SELECT DISTINCT glchld ",
                      ", glch001 ",
 
                      " FROM glch_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE glchent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glch_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glchld ",
                      ", glch001 ",
 
                      " FROM glch_t ",
                      " ",
                      " ", 
 
 
                      " WHERE glchent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glch_t")
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
      INITIALIZE g_glch_m.* TO NULL
      CALL g_glch_d.clear()        
      CALL g_glch2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glchld,t0.glch001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.glchld,t0.glch001",
                " FROM glch_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.glchent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glch_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glch_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_glchld,g_browser[g_cnt].b_glch001 
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
   
   IF cl_null(g_browser[g_cnt].b_glchld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_glch_m.* TO NULL
      CALL g_glch_d.clear()
      CALL g_glch2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL agli162_fetch('')
   
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
 
{<section id="agli162.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agli162_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glch_m.glchld = g_browser[g_current_idx].b_glchld   
   LET g_glch_m.glch001 = g_browser[g_current_idx].b_glch001   
 
   EXECUTE agli162_master_referesh USING g_glch_m.glchld,g_glch_m.glch001 INTO g_glch_m.glchld,g_glch_m.glch001, 
       g_glch_m.glchld_desc
   CALL agli162_show()
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agli162_ui_detailshow()
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
 
{<section id="agli162.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agli162_ui_browser_refresh()
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
      IF g_browser[l_i].b_glchld = g_glch_m.glchld 
         AND g_browser[l_i].b_glch001 = g_glch_m.glch001 
 
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
 
{<section id="agli162.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agli162_construct()
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
   INITIALIZE g_glch_m.* TO NULL
   CALL g_glch_d.clear()
   CALL g_glch2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glchld,glaacomp,glch001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_glchld TO glchld              #帐别
          #  DISPLAY g_glaacomp TO glaacomp          #法人 
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchld
            #add-point:BEFORE FIELD glchld name="construct.b.glchld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchld
            
            #add-point:AFTER FIELD glchld name="construct.a.glchld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glchld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchld
            #add-point:ON ACTION controlp INFIELD glchld name="construct.c.glchld"
              INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 =g_user
            LET g_qryparam.arg2 =g_dept
            CALL q_authorised_ld()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glchld  #顯示到畫面上
            NEXT FIELD glchld                    #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_2()                     #呼叫開窗
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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch001
            #add-point:BEFORE FIELD glch001 name="construct.b.glch001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch001
            
            #add-point:AFTER FIELD glch001 name="construct.a.glch001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glch001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch001
            #add-point:ON ACTION controlp INFIELD glch001 name="construct.c.glch001"
               INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glav001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glch001  #顯示到畫面上
            NEXT FIELD glch001                    #返回原欄位
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON glchstus,glch002,glch003,glch004,glchownid,glchowndp,glchcrtid,glchcrtdp, 
          glchcrtdt,glchmodid,glchmoddt
           FROM s_detail1[1].glchstus,s_detail1[1].glch002,s_detail1[1].glch003,s_detail1[1].glch004, 
               s_detail2[1].glchownid,s_detail2[1].glchowndp,s_detail2[1].glchcrtid,s_detail2[1].glchcrtdp, 
               s_detail2[1].glchcrtdt,s_detail2[1].glchmodid,s_detail2[1].glchmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glchcrtdt>>----
         AFTER FIELD glchcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glchmoddt>>----
         AFTER FIELD glchmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glchcnfdt>>----
         
         #----<<glchpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchstus
            #add-point:BEFORE FIELD glchstus name="construct.b.page1.glchstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchstus
            
            #add-point:AFTER FIELD glchstus name="construct.a.page1.glchstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glchstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchstus
            #add-point:ON ACTION controlp INFIELD glchstus name="construct.c.page1.glchstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch002
            #add-point:BEFORE FIELD glch002 name="construct.b.page1.glch002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch002
            
            #add-point:AFTER FIELD glch002 name="construct.a.page1.glch002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glch002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch002
            #add-point:ON ACTION controlp INFIELD glch002 name="construct.c.page1.glch002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            
            LET g_qryparam.where =  "glacent= ",g_enterprise,#" AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glch_m.glchld,"' )",
                                " AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac007 =3 AND glac006 = 1 "
            CALL q_glac002_3()                                #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO glch002  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glch002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch003
            #add-point:BEFORE FIELD glch003 name="construct.b.page1.glch003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch003
            
            #add-point:AFTER FIELD glch003 name="construct.a.page1.glch003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glch003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch003
            #add-point:ON ACTION controlp INFIELD glch003 name="construct.c.page1.glch003"
              INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            
            LET g_qryparam.where =  "glacent= ",g_enterprise,#" AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glch_m.glchld,"' )",
                                " AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac007 =4 AND glac006 = 1 "
            CALL q_glac002_3()                                #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO glch003  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glch003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch004
            #add-point:BEFORE FIELD glch004 name="construct.b.page1.glch004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch004
            
            #add-point:AFTER FIELD glch004 name="construct.a.page1.glch004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glch004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch004
            #add-point:ON ACTION controlp INFIELD glch004 name="construct.c.page1.glch004"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            
            LET g_qryparam.where =  "glacent= ",g_enterprise,#" AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glch_m.glchld,"' )",
                                " AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac006 = 2 "
            CALL q_glac002_3()                                #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO glch004  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glch004                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glchownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchownid
            #add-point:ON ACTION controlp INFIELD glchownid name="construct.c.page2.glchownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glchownid  #顯示到畫面上
            NEXT FIELD glchownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchownid
            #add-point:BEFORE FIELD glchownid name="construct.b.page2.glchownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchownid
            
            #add-point:AFTER FIELD glchownid name="construct.a.page2.glchownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glchowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchowndp
            #add-point:ON ACTION controlp INFIELD glchowndp name="construct.c.page2.glchowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glchowndp  #顯示到畫面上
            NEXT FIELD glchowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchowndp
            #add-point:BEFORE FIELD glchowndp name="construct.b.page2.glchowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchowndp
            
            #add-point:AFTER FIELD glchowndp name="construct.a.page2.glchowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glchcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchcrtid
            #add-point:ON ACTION controlp INFIELD glchcrtid name="construct.c.page2.glchcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glchcrtid  #顯示到畫面上
            NEXT FIELD glchcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchcrtid
            #add-point:BEFORE FIELD glchcrtid name="construct.b.page2.glchcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchcrtid
            
            #add-point:AFTER FIELD glchcrtid name="construct.a.page2.glchcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glchcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchcrtdp
            #add-point:ON ACTION controlp INFIELD glchcrtdp name="construct.c.page2.glchcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glchcrtdp  #顯示到畫面上
            NEXT FIELD glchcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchcrtdp
            #add-point:BEFORE FIELD glchcrtdp name="construct.b.page2.glchcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchcrtdp
            
            #add-point:AFTER FIELD glchcrtdp name="construct.a.page2.glchcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchcrtdt
            #add-point:BEFORE FIELD glchcrtdt name="construct.b.page2.glchcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glchmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchmodid
            #add-point:ON ACTION controlp INFIELD glchmodid name="construct.c.page2.glchmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glchmodid  #顯示到畫面上
            NEXT FIELD glchmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchmodid
            #add-point:BEFORE FIELD glchmodid name="construct.b.page2.glchmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchmodid
            
            #add-point:AFTER FIELD glchmodid name="construct.a.page2.glchmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchmoddt
            #add-point:BEFORE FIELD glchmoddt name="construct.b.page2.glchmoddt"
            
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
 
{<section id="agli162.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agli162_query()
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
   CALL g_glch_d.clear()
   CALL g_glch2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL agli162_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agli162_browser_fill(g_wc)
      CALL agli162_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL agli162_browser_fill("F")
   
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
      CALL agli162_fetch("F") 
   END IF
   
   CALL agli162_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agli162_fetch(p_flag)
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
   
   #CALL agli162_browser_fill(p_flag)
   
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
   
   LET g_glch_m.glchld = g_browser[g_current_idx].b_glchld
   LET g_glch_m.glch001 = g_browser[g_current_idx].b_glch001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agli162_master_referesh USING g_glch_m.glchld,g_glch_m.glch001 INTO g_glch_m.glchld,g_glch_m.glch001, 
       g_glch_m.glchld_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glch_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_glch_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_glch_m_mask_o.* =  g_glch_m.*
   CALL agli162_glch_t_mask()
   LET g_glch_m_mask_n.* =  g_glch_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL agli162_set_act_visible()
   CALL agli162_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_glch_m_t.* = g_glch_m.*
   LET g_glch_m_o.* = g_glch_m.*
   
   #重新顯示   
   CALL agli162_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="agli162.insert" >}
#+ 資料新增
PRIVATE FUNCTION agli162_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_pass        LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_glch_d.clear()
   CALL g_glch2_d.clear()
 
 
   INITIALIZE g_glch_m.* TO NULL             #DEFAULT 設定
   LET g_glchld_t = NULL
   LET g_glch001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
     
     #年度预设
     LET g_glch_m.glch001=YEAR(g_today)
      
     CALL s_ld_chk_authorization(g_user,g_glchld) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glchld
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN         
      END IF
      LET g_glch_m.glchld = g_glchld              #账别
      LET g_glch_m.glaacomp =g_glaacomp           #法人
      #账别说明
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glch_m.glchld 
      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glch_m.glchld_desc=g_rtn_fields[1]
      #法人说明
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glch_m.glaacomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glch_m.glaacomp_desc= g_rtn_fields[1]
      #end add-point 
 
      CALL agli162_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_glch_m.* TO NULL
         INITIALIZE g_glch_d TO NULL
         INITIALIZE g_glch2_d TO NULL
 
         CALL agli162_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glch_m.* = g_glch_m_t.*
         CALL agli162_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_glch_d.clear()
      #CALL g_glch2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL agli162_set_act_visible()
   CALL agli162_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glchld_t = g_glch_m.glchld
   LET g_glch001_t = g_glch_m.glch001
 
   
   #組合新增資料的條件
   LET g_add_browse = " glchent = " ||g_enterprise|| " AND",
                      " glchld = '", g_glch_m.glchld, "' "
                      ," AND glch001 = '", g_glch_m.glch001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli162_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL agli162_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agli162_master_referesh USING g_glch_m.glchld,g_glch_m.glch001 INTO g_glch_m.glchld,g_glch_m.glch001, 
       g_glch_m.glchld_desc
   
   #遮罩相關處理
   LET g_glch_m_mask_o.* =  g_glch_m.*
   CALL agli162_glch_t_mask()
   LET g_glch_m_mask_n.* =  g_glch_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glch_m.glchld,g_glch_m.glchld_desc,g_glch_m.glaacomp,g_glch_m.glaacomp_desc,g_glch_m.glch001 
 
   
   #功能已完成,通報訊息中心
   CALL agli162_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.modify" >}
#+ 資料修改
PRIVATE FUNCTION agli162_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_pass           LIKE type_t.num5  #160811-00039#6 add
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #160811-00039#6--add--str--
   IF g_glch_m.glchld IS NULL
   OR g_glch_m.glch001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   CALL s_ld_chk_authorization(g_user,g_glch_m.glchld) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glch_m.glchld
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN
   END IF
   #160811-00039#6--add--end
   #end add-point
   
   IF g_glch_m.glchld IS NULL
   OR g_glch_m.glch001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_glchld_t = g_glch_m.glchld
   LET g_glch001_t = g_glch_m.glch001
 
   CALL s_transaction_begin()
   
   OPEN agli162_cl USING g_enterprise,g_glch_m.glchld,g_glch_m.glch001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli162_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE agli162_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli162_master_referesh USING g_glch_m.glchld,g_glch_m.glch001 INTO g_glch_m.glchld,g_glch_m.glch001, 
       g_glch_m.glchld_desc
   
   #遮罩相關處理
   LET g_glch_m_mask_o.* =  g_glch_m.*
   CALL agli162_glch_t_mask()
   LET g_glch_m_mask_n.* =  g_glch_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL agli162_show()
   WHILE TRUE
      LET g_glchld_t = g_glch_m.glchld
      LET g_glch001_t = g_glch_m.glch001
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL agli162_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glch_m.* = g_glch_m_t.*
         CALL agli162_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_glch_m.glchld != g_glchld_t 
      OR g_glch_m.glch001 != g_glch001_t 
 
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
   CALL agli162_set_act_visible()
   CALL agli162_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glchent = " ||g_enterprise|| " AND",
                      " glchld = '", g_glch_m.glchld, "' "
                      ," AND glch001 = '", g_glch_m.glch001, "' "
 
   #填到對應位置
   CALL agli162_browser_fill("")
 
   CALL agli162_idx_chk()
 
   CLOSE agli162_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agli162_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="agli162.input" >}
#+ 資料輸入
PRIVATE FUNCTION agli162_input(p_cmd)
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
   DEFINE l_pass        LIKE type_t.num5
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
   DISPLAY BY NAME g_glch_m.glchld,g_glch_m.glchld_desc,g_glch_m.glaacomp,g_glch_m.glaacomp_desc,g_glch_m.glch001 
 
   
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
   LET g_forupd_sql = "SELECT glchstus,glch002,glch003,glch004,glch002,glchownid,glchowndp,glchcrtid, 
       glchcrtdp,glchcrtdt,glchmodid,glchmoddt FROM glch_t WHERE glchent=? AND glchld=? AND glch001=?  
       AND glch002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli162_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agli162_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL agli162_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_glch_m.glchld,g_glch_m.glch001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agli162.input.head" >}
   
      #單頭段
      INPUT BY NAME g_glch_m.glchld,g_glch_m.glch001 
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
         AFTER FIELD glchld
            
            #add-point:AFTER FIELD glchld name="input.a.glchld"
           
                                                     
            #應用 a05 樣板自動產生(Version:3)
            
           IF  NOT cl_null(g_glch_m.glchld) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glch_m.glchld != g_glchld_t  OR g_glch_m.glch001 != g_glch001_t )) THEN 
                  #账套检核
                  LET l_n=0
                  SELECT COUNT(*) INTO l_n
                    FROM glaa_t
                    WHERE glaaent =g_enterprise AND glaald=g_glch_m.glchld AND glaastus='Y'
                   
                   IF l_n=0 THEN
                      INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00470'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err() 
                               
                     NEXT FIELD CURRENT
                   END IF 
               END IF               
               
             CALL s_ld_chk_authorization(g_user,g_glch_m.glchld) RETURNING l_pass
             IF l_pass = FALSE THEN
                INITIALIZE g_errparam TO NULL
#                LET g_errparam.code = 'agl-00164' #160811-00039#6 mark
                LET g_errparam.code = 'agl-00165'  #160811-00039#6 add
                LET g_errparam.extend = g_glch_m.glchld
                LET g_errparam.popup = TRUE
                CALL cl_err()        
                NEXT FIELD CURRENT
             END IF  
             
             
             
             
            #確認資料無重複
            IF  NOT cl_null(g_glch_m.glchld) AND NOT cl_null(g_glch_m.glch001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glch_m.glchld != g_glchld_t  OR g_glch_m.glch001 != g_glch001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glch_t WHERE "||"glchent = '" ||g_enterprise|| "' AND "||"glchld = '"||g_glch_m.glchld ||"' AND "|| "glch001 = '"||g_glch_m.glch001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF   
               
              #获取法人
               SELECT glaacomp INTO g_glaacomp
                 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_glch_m.glchld
                
                LET g_glch_m.glaacomp =g_glaacomp           #法人  
                #法人说明
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = g_glch_m.glaacomp
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_glch_m.glaacomp_desc= g_rtn_fields[1]
                
                DISPLAY BY NAME g_glch_m.glaacomp,g_glch_m.glaacomp_desc
            

           END IF
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_glch_m.glchld
           CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_glch_m.glchld_desc = '', g_rtn_fields[1] , ''
           DISPLAY BY NAME g_glch_m.glchld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchld
            #add-point:BEFORE FIELD glchld name="input.b.glchld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glchld
            #add-point:ON CHANGE glchld name="input.g.glchld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch001
            #add-point:BEFORE FIELD glch001 name="input.b.glch001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch001
            
            #add-point:AFTER FIELD glch001 name="input.a.glch001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_glch_m.glchld) AND NOT cl_null(g_glch_m.glch001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glch_m.glchld != g_glchld_t  OR g_glch_m.glch001 != g_glch001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glch_t WHERE "||"glchent = '" ||g_enterprise|| "' AND "||"glchld = '"||g_glch_m.glchld ||"' AND "|| "glch001 = '"||g_glch_m.glch001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  LET l_n=0 
                  SELECT COUNT(*) INTO l_n
                    FROM glav_t
                   WHERE glavent=g_enterprise AND glav002= g_glch_m.glch001 AND glav001=(SELECT glaa003 FROM glaa_t WHERE glaaent =g_enterprise AND glaald= g_glch_m.glchld )
                   
                   IF l_n=0 OR cl_null(l_n) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = '!'
                      LET g_errparam.extend = '当前账套下无此年度！'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      NEXT FIELD CURRENT
                   END IF
                               
                  
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glch001
            #add-point:ON CHANGE glch001 name="input.g.glch001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glchld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchld
            #add-point:ON ACTION controlp INFIELD glchld name="input.c.glchld"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 =g_user
            LET g_qryparam.arg2 =g_dept
            CALL q_authorised_ld()
            LET g_glch_m.glchld = g_qryparam.return1
            NEXT FIELD glchld
            #END add-point
 
 
         #Ctrlp:input.c.glch001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch001
            #add-point:ON ACTION controlp INFIELD glch001 name="input.c.glch001"
             #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_glch_m.glchld
            CALL q_glav001_3()
            LET g_glch_m.glch001 = g_qryparam.return1
            NEXT FIELD glch001
            
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
            DISPLAY BY NAME g_glch_m.glchld             
                            ,g_glch_m.glch001   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL agli162_glch_t_mask_restore('restore_mask_o')
            
               UPDATE glch_t SET (glchld,glch001) = (g_glch_m.glchld,g_glch_m.glch001)
                WHERE glchent = g_enterprise AND glchld = g_glchld_t
                  AND glch001 = g_glch001_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glch_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glch_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glch_m.glchld
               LET gs_keys_bak[1] = g_glchld_t
               LET gs_keys[2] = g_glch_m.glch001
               LET gs_keys_bak[2] = g_glch001_t
               LET gs_keys[3] = g_glch_d[g_detail_idx].glch002
               LET gs_keys_bak[3] = g_glch_d_t.glch002
               CALL agli162_update_b('glch_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_glch_m_t)
                     #LET g_log2 = util.JSON.stringify(g_glch_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL agli162_glch_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL agli162_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_glchld_t = g_glch_m.glchld
           LET g_glch001_t = g_glch_m.glch001
 
           
           IF g_glch_d.getLength() = 0 THEN
              NEXT FIELD glch002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="agli162.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_glch_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glch_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agli162_b_fill(g_wc2) #test 
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
            CALL agli162_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN agli162_cl USING g_enterprise,g_glch_m.glchld,g_glch_m.glch001                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE agli162_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN agli162_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_glch_d[l_ac].glch002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glch_d_t.* = g_glch_d[l_ac].*  #BACKUP
               LET g_glch_d_o.* = g_glch_d[l_ac].*  #BACKUP
               CALL agli162_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL agli162_set_no_entry_b(l_cmd)
               OPEN agli162_bcl USING g_enterprise,g_glch_m.glchld,
                                                g_glch_m.glch001,
 
                                                g_glch_d_t.glch002
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN agli162_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli162_bcl INTO g_glch_d[l_ac].glchstus,g_glch_d[l_ac].glch002,g_glch_d[l_ac].glch003, 
                      g_glch_d[l_ac].glch004,g_glch2_d[l_ac].glch002,g_glch2_d[l_ac].glchownid,g_glch2_d[l_ac].glchowndp, 
                      g_glch2_d[l_ac].glchcrtid,g_glch2_d[l_ac].glchcrtdp,g_glch2_d[l_ac].glchcrtdt, 
                      g_glch2_d[l_ac].glchmodid,g_glch2_d[l_ac].glchmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_glch_d_t.glch002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glch_d_mask_o[l_ac].* =  g_glch_d[l_ac].*
                  CALL agli162_glch_t_mask()
                  LET g_glch_d_mask_n[l_ac].* =  g_glch_d[l_ac].*
                  
                  CALL agli162_ref_show()
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
            INITIALIZE g_glch_d_t.* TO NULL
            INITIALIZE g_glch_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glch_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glch2_d[l_ac].glchownid = g_user
      LET g_glch2_d[l_ac].glchowndp = g_dept
      LET g_glch2_d[l_ac].glchcrtid = g_user
      LET g_glch2_d[l_ac].glchcrtdp = g_dept 
      LET g_glch2_d[l_ac].glchcrtdt = cl_get_current()
      LET g_glch2_d[l_ac].glchmodid = g_user
      LET g_glch2_d[l_ac].glchmoddt = cl_get_current()
      LET g_glch_d[l_ac].glchstus = ''
 
 
  
            #一般欄位預設值
                  LET g_glch_d[l_ac].glchstus = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_glch_d_t.* = g_glch_d[l_ac].*     #新輸入資料
            LET g_glch_d_o.* = g_glch_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agli162_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL agli162_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glch_d[li_reproduce_target].* = g_glch_d[li_reproduce].*
               LET g_glch2_d[li_reproduce_target].* = g_glch2_d[li_reproduce].*
 
               LET g_glch_d[g_glch_d.getLength()].glch002 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM glch_t 
             WHERE glchent = g_enterprise AND glchld = g_glch_m.glchld
               AND glch001 = g_glch_m.glch001
 
               AND glch002 = g_glch_d[l_ac].glch002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO glch_t
                           (glchent,
                            glchld,glch001,
                            glch002
                            ,glchstus,glch003,glch004,glchownid,glchowndp,glchcrtid,glchcrtdp,glchcrtdt,glchmodid,glchmoddt) 
                     VALUES(g_enterprise,
                            g_glch_m.glchld,g_glch_m.glch001,
                            g_glch_d[l_ac].glch002
                            ,g_glch_d[l_ac].glchstus,g_glch_d[l_ac].glch003,g_glch_d[l_ac].glch004,g_glch2_d[l_ac].glchownid, 
                                g_glch2_d[l_ac].glchowndp,g_glch2_d[l_ac].glchcrtid,g_glch2_d[l_ac].glchcrtdp, 
                                g_glch2_d[l_ac].glchcrtdt,g_glch2_d[l_ac].glchmodid,g_glch2_d[l_ac].glchmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_glch_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "glch_t:",SQLERRMESSAGE 
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
               IF agli162_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glch_m.glchld
                  LET gs_keys[gs_keys.getLength()+1] = g_glch_m.glch001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glch_d_t.glch002
 
 
                  #刪除下層單身
                  IF NOT agli162_key_delete_b(gs_keys,'glch_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE agli162_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE agli162_bcl
               LET l_count = g_glch_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_glch_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glchstus
            #add-point:BEFORE FIELD glchstus name="input.b.page1.glchstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glchstus
            
            #add-point:AFTER FIELD glchstus name="input.a.page1.glchstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glchstus
            #add-point:ON CHANGE glchstus name="input.g.page1.glchstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch002
            
            #add-point:AFTER FIELD glch002 name="input.a.page1.glch002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_glch_m.glchld IS NOT NULL AND g_glch_m.glch001 IS NOT NULL AND g_glch_d[g_detail_idx].glch002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glch_m.glchld != g_glchld_t OR g_glch_m.glch001 != g_glch001_t OR g_glch_d[g_detail_idx].glch002 != g_glch_d_t.glch002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glch_t WHERE "||"glchent = '" ||g_enterprise|| "' AND "||"glchld = '"||g_glch_m.glchld ||"' AND "|| "glch001 = '"||g_glch_m.glch001 ||"' AND "|| "glch002 = '"||g_glch_d[g_detail_idx].glch002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
                  #栏位检核
#                  LET l_n=0 
#                  SELECT COUNT(*) INTO l_n
#                    FROM glac_t
#                   WHERE glacent=g_enterprise AND glac002= g_glch_d[l_ac].glch002 AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glch_m.glchld )
#                     AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac007 =3 AND glac006 =1 
#                     
#                   IF l_n =0 THEN 
#                      INITIALIZE g_errparam TO NULL 
#                      LET g_errparam.extend = "综合损益类科目有误,请重输"
#                      LET g_errparam.code   = '!'
#                      LET g_errparam.popup  = TRUE 
#                      CALL cl_err()
#                      LET g_glch_d[l_ac].glch002= g_glch_d_t.glch002
#                      NEXT FIELD CURRENT
#                   END IF    
                   CALL  agli162_glch002_chk(g_glch_m.glchld,g_glch_d[l_ac].glch002,'3','1')
                  
                 IF NOT cl_null(g_errno) THEN 
                   CASE g_errno
                       WHEN '3' 
                               INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = 'agl-00466'
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch002= g_glch_d_t.glch002
                               NEXT FIELD CURRENT
                      WHEN '1'
                                 INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = 'agl-00467'
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch002= g_glch_d_t.glch002
                               NEXT FIELD CURRENT
                               
                     OTHERWISE
                                INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = g_errno
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch002= g_glch_d_t.glch002
                               NEXT FIELD CURRENT                  
                   END CASE 
                 END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glch_d[l_ac].glch002
            LET g_ref_fields[2] = g_glch_m.glchld
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl002=? AND glacl001= (SELECT glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=?) AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glch_d[l_ac].glch002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glch_d[l_ac].glch002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch002
            #add-point:BEFORE FIELD glch002 name="input.b.page1.glch002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glch002
            #add-point:ON CHANGE glch002 name="input.g.page1.glch002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch003
            
            #add-point:AFTER FIELD glch003 name="input.a.page1.glch003"
            IF  g_glch_m.glchld IS NOT NULL AND g_glch_m.glch001 IS NOT NULL AND g_glch_d[g_detail_idx].glch003 IS NOT NULL THEN 
             #栏位检核
#                  LET l_n=0 
#                  SELECT COUNT(*) INTO l_n
#                    FROM glac_t
#                   WHERE glacent=g_enterprise AND glac002= g_glch_d[l_ac].glch003 AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glch_m.glchld )
#                     AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac007 =4 AND glac006 =1 
#                     
#                   IF l_n =0 THEN 
#                      INITIALIZE g_errparam TO NULL 
#                      LET g_errparam.extend = "权益类对应科目有误,请重输" 
#                      LET g_errparam.code   = '!' 
#                      LET g_errparam.popup  = TRUE 
#                      CALL cl_err()
#                      LET g_glch_d[l_ac].glch003= g_glch_d_t.glch003
#                      NEXT FIELD CURRENT
#                   END IF                
                   CALL  agli162_glch002_chk(g_glch_m.glchld,g_glch_d[l_ac].glch003,'4','1')
                IF NOT cl_null(g_errno) THEN 
                  CASE g_errno
                       WHEN '4' 
                               INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = 'agl-00469'
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch003= g_glch_d_t.glch003
                               NEXT FIELD CURRENT
                      WHEN '1'
                                 INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = 'agl-00467'
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch003= g_glch_d_t.glch003
                               NEXT FIELD CURRENT
                               
                     OTHERWISE
                                INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = g_errno
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch003= g_glch_d_t.glch003
                               NEXT FIELD CURRENT                  
                   END CASE 
                END IF   
            END IF
                      
            
             INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glch_d[l_ac].glch003
            LET g_ref_fields[2] = g_glch_m.glchld
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl002=? AND glacl001= (SELECT glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=?) AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glch_d[l_ac].glch003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glch_d[l_ac].glch003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch003
            #add-point:BEFORE FIELD glch003 name="input.b.page1.glch003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glch003
            #add-point:ON CHANGE glch003 name="input.g.page1.glch003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glch004
            
            #add-point:AFTER FIELD glch004 name="input.a.page1.glch004"
           IF  g_glch_m.glchld IS NOT NULL AND g_glch_m.glch001 IS NOT NULL AND g_glch_d[g_detail_idx].glch004 IS NOT NULL THEN  
               #栏位检核
#                LET l_n=0 
#                SELECT COUNT(*) INTO l_n
#                  FROM glac_t
#                 WHERE glacent=g_enterprise AND glac002= g_glch_d[l_ac].glch004 AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glch_m.glchld )
#                   AND glacstus='Y' AND (glac003=2 OR glac003=3) AND glac006 =2
#                   
#                 IF l_n =0 THEN 
#                    INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "结转损益类科目有误,请重输" 
#                    LET g_errparam.code   = '!'
#                    LET g_errparam.popup  = TRUE 
#                    CALL cl_err()
#                    LET g_glch_d[l_ac].glch004= g_glch_d_t.glch004
#                    NEXT FIELD CURRENT
#                 END IF                
                 CALL  agli162_glch002_chk(g_glch_m.glchld,g_glch_d[l_ac].glch004,'','2')
                  IF NOT cl_null(g_errno) THEN 
                   CASE g_errno
                      
                      WHEN '2'
                                INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = 'agl-00468'
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch004= g_glch_d_t.glch004
                               NEXT FIELD CURRENT                               
                     OTHERWISE
                                INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = ""
                               LET g_errparam.code   = g_errno
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               LET g_glch_d[l_ac].glch004= g_glch_d_t.glch004
                               NEXT FIELD CURRENT                  
                   END CASE 
                 END IF  
           END IF
            
            
             INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glch_d[l_ac].glch004
            LET g_ref_fields[2] = g_glch_m.glchld
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl002=? AND glacl001= (SELECT glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=?) AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glch_d[l_ac].glch004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glch_d[l_ac].glch004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glch004
            #add-point:BEFORE FIELD glch004 name="input.b.page1.glch004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glch004
            #add-point:ON CHANGE glch004 name="input.g.page1.glch004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glchstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glchstus
            #add-point:ON ACTION controlp INFIELD glchstus name="input.c.page1.glchstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glch002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch002
            #add-point:ON ACTION controlp INFIELD glch002 name="input.c.page1.glch002"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glch_d[l_ac].glch002           #給予default值
           #CALL q_glac()                           #呼叫開窗
            LET g_qryparam.where = "glacent= ",g_enterprise," AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glch_m.glchld,"' )",
                                " AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac007 =3 AND glac006 =1 AND EXISTS(SELECT 1 FROM glad_t WHERE gladent = glacent AND gladstus='Y' AND gladld = '",g_glch_m.glchld,"' AND glad001=glac002  )"
            CALL q_glac002_3()
            
            LET g_glch_d[l_ac].glch002 = g_qryparam.return1
            
            DISPLAY g_glch_d[l_ac].glch002 TO glch002  #顯示到畫面上
            
            NEXT FIELD glch002                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.glch003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch003
            #add-point:ON ACTION controlp INFIELD glch003 name="input.c.page1.glch003"
              INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glch_d[l_ac].glch003          #給予default值
           #CALL q_glac()                           #呼叫開窗
            LET g_qryparam.where = "glacent= ",g_enterprise," AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glch_m.glchld,"' )",
                                " AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac007 =4 AND glac006 =1 AND EXISTS(SELECT 1 FROM glad_t WHERE gladent = glacent AND gladstus='Y' AND gladld = '",g_glch_m.glchld,"' AND glad001=glac002  )"
            CALL q_glac002_3()
            
            LET g_glch_d[l_ac].glch003 = g_qryparam.return1
            
            DISPLAY g_glch_d[l_ac].glch003 TO glch003  #顯示到畫面上
            
            NEXT FIELD glch003                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.glch004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glch004
            #add-point:ON ACTION controlp INFIELD glch004 name="input.c.page1.glch004"
               INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glch_d[l_ac].glch004           #給予default值
           #CALL q_glac()                           #呼叫開窗
            LET g_qryparam.where = "glacent= ",g_enterprise," AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_glch_m.glchld,"' )",
                                " AND glacstus='Y' AND (glac003=2 OR glac003=3)  AND glac006 =2 AND EXISTS(SELECT 1 FROM glad_t WHERE gladent = glacent AND gladstus='Y' AND gladld = '",g_glch_m.glchld,"' AND glad001=glac002  )"
            CALL q_glac002_3()
            
            LET g_glch_d[l_ac].glch004 = g_qryparam.return1
            
            DISPLAY g_glch_d[l_ac].glch004 TO glch004  #顯示到畫面上
            
            NEXT FIELD glch004                     #返回原欄位
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glch_d[l_ac].* = g_glch_d_t.*
               CLOSE agli162_bcl
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
               LET g_errparam.extend = g_glch_d[l_ac].glch002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glch_d[l_ac].* = g_glch_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_glch2_d[l_ac].glchmodid = g_user 
LET g_glch2_d[l_ac].glchmoddt = cl_get_current()
LET g_glch2_d[l_ac].glchmodid_desc = cl_get_username(g_glch2_d[l_ac].glchmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL agli162_glch_t_mask_restore('restore_mask_o')
         
               UPDATE glch_t SET (glchld,glch001,glchstus,glch002,glch003,glch004,glchownid,glchowndp, 
                   glchcrtid,glchcrtdp,glchcrtdt,glchmodid,glchmoddt) = (g_glch_m.glchld,g_glch_m.glch001, 
                   g_glch_d[l_ac].glchstus,g_glch_d[l_ac].glch002,g_glch_d[l_ac].glch003,g_glch_d[l_ac].glch004, 
                   g_glch2_d[l_ac].glchownid,g_glch2_d[l_ac].glchowndp,g_glch2_d[l_ac].glchcrtid,g_glch2_d[l_ac].glchcrtdp, 
                   g_glch2_d[l_ac].glchcrtdt,g_glch2_d[l_ac].glchmodid,g_glch2_d[l_ac].glchmoddt)
                WHERE glchent = g_enterprise AND glchld = g_glch_m.glchld 
                 AND glch001 = g_glch_m.glch001 
 
                 AND glch002 = g_glch_d_t.glch002 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glch_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "glch_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glch_m.glchld
               LET gs_keys_bak[1] = g_glchld_t
               LET gs_keys[2] = g_glch_m.glch001
               LET gs_keys_bak[2] = g_glch001_t
               LET gs_keys[3] = g_glch_d[g_detail_idx].glch002
               LET gs_keys_bak[3] = g_glch_d_t.glch002
               CALL agli162_update_b('glch_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glch_m),util.JSON.stringify(g_glch_d_t)
                     LET g_log2 = util.JSON.stringify(g_glch_m),util.JSON.stringify(g_glch_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agli162_glch_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_glch_m.glchld
               LET ls_keys[ls_keys.getLength()+1] = g_glch_m.glch001
 
               LET ls_keys[ls_keys.getLength()+1] = g_glch_d_t.glch002
 
               CALL agli162_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE agli162_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glch_d[l_ac].* = g_glch_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE agli162_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_glch_d.getLength() = 0 THEN
               NEXT FIELD glch002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glch_d[li_reproduce_target].* = g_glch_d[li_reproduce].*
               LET g_glch2_d[li_reproduce_target].* = g_glch2_d[li_reproduce].*
 
               LET g_glch_d[li_reproduce_target].glch002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glch_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glch_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_glch2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL agli162_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL agli162_idx_chk()
            CALL agli162_ui_detailshow()
        
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
            NEXT FIELD glchld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glchstus
               WHEN "s_detail2"
                  NEXT FIELD glch002_2
 
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
 
{<section id="agli162.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agli162_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   SELECT glaacomp INTO g_glch_m.glaacomp
     FROM glaa_t
    WHERE glaaent =g_enterprise AND glaald = g_glch_m.glchld
          
     #法人说明
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glch_m.glaacomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glch_m.glaacomp_desc= g_rtn_fields[1]
      
      DISPLAY g_glch_m.glaacomp TO glaacomp
      DISPLAY g_glch_m.glaacomp_desc TO glaacomp_desc
      
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL agli162_b_fill(g_wc2) #第一階單身填充
      CALL agli162_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agli162_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_glch_m.glchld,g_glch_m.glchld_desc,g_glch_m.glaacomp,g_glch_m.glaacomp_desc,g_glch_m.glch001 
 
 
   CALL agli162_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION agli162_ref_show()
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
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glch_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_glch2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="agli162.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agli162_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE glch_t.glchld 
   DEFINE l_oldno     LIKE glch_t.glchld 
   DEFINE l_newno02     LIKE glch_t.glch001 
   DEFINE l_oldno02     LIKE glch_t.glch001 
 
   DEFINE l_master    RECORD LIKE glch_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glch_t.* #此變數樣板目前無使用
 
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
 
   IF g_glch_m.glchld IS NULL
      OR g_glch_m.glch001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_glchld_t = g_glch_m.glchld
   LET g_glch001_t = g_glch_m.glch001
 
   
   LET g_glch_m.glchld = ""
   LET g_glch_m.glch001 = ""
 
   LET g_master_insert = FALSE
   CALL agli162_set_entry('a')
   CALL agli162_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_glch_m.glchld_desc = ''
   DISPLAY BY NAME g_glch_m.glchld_desc
 
   
   CALL agli162_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_glch_m.* TO NULL
      INITIALIZE g_glch_d TO NULL
      INITIALIZE g_glch2_d TO NULL
 
      CALL agli162_show()
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
   CALL agli162_set_act_visible()
   CALL agli162_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glchld_t = g_glch_m.glchld
   LET g_glch001_t = g_glch_m.glch001
 
   
   #組合新增資料的條件
   LET g_add_browse = " glchent = " ||g_enterprise|| " AND",
                      " glchld = '", g_glch_m.glchld, "' "
                      ," AND glch001 = '", g_glch_m.glch001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli162_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL agli162_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL agli162_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agli162_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glch_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agli162_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glch_t
    WHERE glchent = g_enterprise AND glchld = g_glchld_t
    AND glch001 = g_glch001_t
 
       INTO TEMP agli162_detail
   
   #將key修正為調整後   
   UPDATE agli162_detail 
      #更新key欄位
      SET glchld = g_glch_m.glchld
          , glch001 = g_glch_m.glch001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , glchownid = g_user 
       , glchowndp = g_dept
       , glchcrtid = g_user
       , glchcrtdp = g_dept 
       , glchcrtdt = ld_date
       , glchmodid = g_user
       , glchmoddt = ld_date
      #, glchstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO glch_t SELECT * FROM agli162_detail
   
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
   DROP TABLE agli162_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glchld_t = g_glch_m.glchld
   LET g_glch001_t = g_glch_m.glch001
 
   
   DROP TABLE agli162_detail
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agli162_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_pass           LIKE type_t.num5  #160811-00039#6 add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   #160811-00039#6--add--str--
   IF g_glch_m.glchld IS NULL
   OR g_glch_m.glch001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   CALL s_ld_chk_authorization(g_user,g_glch_m.glchld) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glch_m.glchld
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN
   END IF
   #160811-00039#6--add--end
   #end add-point
   
   IF g_glch_m.glchld IS NULL
   OR g_glch_m.glch001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN agli162_cl USING g_enterprise,g_glch_m.glchld,g_glch_m.glch001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli162_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE agli162_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli162_master_referesh USING g_glch_m.glchld,g_glch_m.glch001 INTO g_glch_m.glchld,g_glch_m.glch001, 
       g_glch_m.glchld_desc
   
   #遮罩相關處理
   LET g_glch_m_mask_o.* =  g_glch_m.*
   CALL agli162_glch_t_mask()
   LET g_glch_m_mask_n.* =  g_glch_m.*
   
   CALL agli162_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agli162_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM glch_t WHERE glchent = g_enterprise AND glchld = g_glch_m.glchld
                                                               AND glch001 = g_glch_m.glch001
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glch_t:",SQLERRMESSAGE 
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
      #   CLOSE agli162_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_glch_d.clear() 
      CALL g_glch2_d.clear()       
 
     
      CALL agli162_ui_browser_refresh()  
      #CALL agli162_ui_headershow()  
      #CALL agli162_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL agli162_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL agli162_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE agli162_cl
 
   #功能已完成,通報訊息中心
   CALL agli162_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agli162.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agli162_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_glch_d.clear()
   CALL g_glch2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT glchstus,glch002,glch003,glch004,glch002,glchownid,glchowndp,glchcrtid, 
       glchcrtdp,glchcrtdt,glchmodid,glchmoddt,t1.glacl004 ,t2.glacl004 ,t3.glacl004 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 FROM glch_t",   
               "",
               
                              " LEFT JOIN glacl_t t1 ON t1.glaclent="||g_enterprise||" AND t1.glacl001=glch002 AND t1.glacl003='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t2 ON t2.glaclent="||g_enterprise||" AND t2.glacl001=glch003 AND t2.glacl003='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t3 ON t3.glaclent="||g_enterprise||" AND =glch004 AND t3.glacl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=glchownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=glchowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=glchcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=glchcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=glchmodid  ",
 
               " WHERE glchent= ? AND glchld=? AND glch001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("glch_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
     LET g_sql = "SELECT  DISTINCT glchstus,glch002,glch003,glch004,glch002,glchownid,glchowndp,glchcrtid, 
       glchcrtdp,glchcrtdt,glchmodid,glchmoddt,t1.glacl004 ,t2.glacl004 ,t3.glacl004 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 FROM glch_t",   
               "",
               
               " LEFT JOIN glacl_t t1 ON t1.glaclent='"||g_enterprise||"' AND t1.glacl001=(SELECT glaa004 FROM glaa_t WHERE glaaent =glchent AND glchld = glaald ) AND t1.glacl002=glch002 AND t1.glacl003='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t2 ON t2.glaclent='"||g_enterprise||"' AND t2.glacl001=(SELECT glaa004 FROM glaa_t WHERE glaaent =glchent AND glchld = glaald ) AND t2.glacl002=glch003 AND t2.glacl003='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t3 ON t3.glaclent='"||g_enterprise||"' AND t3.glacl001=(SELECT glaa004 FROM glaa_t WHERE glaaent =glchent AND glchld = glaald ) AND t3.glacl002=glch004 AND t3.glacl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=glchownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=glchowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=glchcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=glchcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=glchmodid  ",
 
               " WHERE glchent= ? AND glchld=? AND glch001=?"
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF agli162_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY glch_t.glch002"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agli162_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agli162_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glch_m.glchld,g_glch_m.glch001   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glch_m.glchld,g_glch_m.glch001 INTO g_glch_d[l_ac].glchstus, 
          g_glch_d[l_ac].glch002,g_glch_d[l_ac].glch003,g_glch_d[l_ac].glch004,g_glch2_d[l_ac].glch002, 
          g_glch2_d[l_ac].glchownid,g_glch2_d[l_ac].glchowndp,g_glch2_d[l_ac].glchcrtid,g_glch2_d[l_ac].glchcrtdp, 
          g_glch2_d[l_ac].glchcrtdt,g_glch2_d[l_ac].glchmodid,g_glch2_d[l_ac].glchmoddt,g_glch_d[l_ac].glch002_desc, 
          g_glch_d[l_ac].glch003_desc,g_glch_d[l_ac].glch004_desc,g_glch2_d[l_ac].glchownid_desc,g_glch2_d[l_ac].glchowndp_desc, 
          g_glch2_d[l_ac].glchcrtid_desc,g_glch2_d[l_ac].glchcrtdp_desc,g_glch2_d[l_ac].glchmodid_desc  
            #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
                    
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
 
            CALL g_glch_d.deleteElement(g_glch_d.getLength())
      CALL g_glch2_d.deleteElement(g_glch2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glch_d.getLength()
      LET g_glch_d_mask_o[l_ac].* =  g_glch_d[l_ac].*
      CALL agli162_glch_t_mask()
      LET g_glch_d_mask_n[l_ac].* =  g_glch_d[l_ac].*
   END FOR
   
   LET g_glch2_d_mask_o.* =  g_glch2_d.*
   FOR l_ac = 1 TO g_glch2_d.getLength()
      LET g_glch2_d_mask_o[l_ac].* =  g_glch2_d[l_ac].*
      CALL agli162_glch_t_mask()
      LET g_glch2_d_mask_n[l_ac].* =  g_glch2_d[l_ac].*
   END FOR
 
 
   FREE agli162_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agli162_idx_chk()
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
      IF g_detail_idx > g_glch_d.getLength() THEN
         LET g_detail_idx = g_glch_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_glch_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glch_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_glch2_d.getLength() THEN
         LET g_detail_idx = g_glch2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glch2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glch2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agli162_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_glch_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION agli162_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM glch_t
    WHERE glchent = g_enterprise AND glchld = g_glch_m.glchld AND
                              glch001 = g_glch_m.glch001 AND
 
          glch002 = g_glch_d_t.glch002
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glch_t:",SQLERRMESSAGE 
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
 
{<section id="agli162.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agli162_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="agli162.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agli162_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="agli162.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agli162_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="agli162.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION agli162_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_glch_d[l_ac].glch002 = g_glch_d_t.glch002 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agli162_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="agli162.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agli162_lock_b(ps_table,ps_page)
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
   #CALL agli162_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agli162.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agli162_unlock_b(ps_table,ps_page)
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
 
{<section id="agli162.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agli162_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glchld,glch001",TRUE)
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
 
{<section id="agli162.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agli162_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glchld,glch001",FALSE)
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
 
{<section id="agli162.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agli162_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agli162_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agli162_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli162.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agli162_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli162.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agli162_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli162.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agli162_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli162.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agli162_default_search()
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
      LET ls_wc = ls_wc, " glchld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glch001 = '", g_argv[02], "' AND "
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
 
{<section id="agli162.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agli162_fill_chk(ps_idx)
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
 
{<section id="agli162.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION agli162_modify_detail_chk(ps_record)
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
         LET ls_return = "glchstus"
      WHEN "s_detail2"
         LET ls_return = "glch002_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="agli162.mask_functions" >}
&include "erp/agl/agli162_mask.4gl"
 
{</section>}
 
{<section id="agli162.state_change" >}
    
 
{</section>}
 
{<section id="agli162.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agli162_set_pk_array()
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
   LET g_pk_array[1].values = g_glch_m.glchld
   LET g_pk_array[1].column = 'glchld'
   LET g_pk_array[2].values = g_glch_m.glch001
   LET g_pk_array[2].column = 'glch001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli162.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agli162_msgcentre_notify(lc_state)
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
   CALL agli162_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glch_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli162.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 校验科目
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
PRIVATE FUNCTION agli162_glch002_chk(p_glchld,p_glch002,p_glac007,p_glac006)
  DEFINE p_glchld     LIKE glch_t.glchld
  DEFINE p_glch002    LIKE glch_t.glch002
  DEFINE p_glac006    LIKE glac_t.glac006
  DEFINE l_glac003    LIKE glac_t.glac003
  DEFINE p_glac007    LIKE glac_t.glac007
  DEFINE l_glacstus   LIKE glac_t.glacstus
  DEFINE l_glac007    LIKE glac_t.glac007
  DEFINE l_glac006    LIKE glac_t.glac006  
  DEFINE l_gladstus   LIKE glad_t.gladstus
  DEFINE l_n          LIKE type_t.num5
  DEFINE l_n1         LIKE type_t.num5
  
   LET g_errno = ''
   LET l_glac003 = ''
   LET l_glac006 = ''
   LET l_glac007 =''
   LET l_glacstus = ''  
   
 #  栏位检核
   LET l_n=0 
   SELECT COUNT(*) INTO l_n
     FROM glac_t
    WHERE glacent=g_enterprise AND glac002= p_glch002  AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_glchld )
   
   
#   SELECT glacstus,glac003,glac006 INTO l_glacstus,l_glac003,l_glac006 FROM glac_t #151117-00009#1 mark
   SELECT glac003,glac006,glac007 INTO l_glac003,l_glac006,l_glac007 FROM glac_t 
    WHERE glacent = g_enterprise
      AND glac001 = (SELECT glaa004 FROM glaa_t WHERE glaaent = g_enterprise
                        AND glaald = p_glchld)   #会计科目参照表
      AND glac002 = p_glch002
       
      
    #检查科目是否存在于glad_t中，是否有效
     SELECT gladstus INTO l_gladstus
       FROM glad_t
      WHERE gladent = g_enterprise
        AND gladld = p_glchld       
        AND glad001 = p_glch002
      
   CASE

#      WHEN SQLCA.SQLCODE = 100                    LET g_errno = 'agl-00011'
      WHEN SQLCA.SQLCODE = 100                    LET g_errno = 'ais-00045'
      WHEN l_n =0                                 LET g_errno = 'agl-00011'     
      WHEN l_gladstus = 'N'                       LET g_errno = 'ais-00046'
      WHEN l_glac007 <>p_glac007                  LET g_errno=  p_glac007
      WHEN l_glac003 <>'2' AND l_glac003 <>'3'     LET g_errno = 'agl-00462'  
      WHEN l_glac006 <>p_glac006                   LET g_errno =  p_glac006 #'agl-00030'  
         
   END CASE   
END FUNCTION

 
{</section>}
 
