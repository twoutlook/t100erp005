#該程式未解開Section, 採用最新樣板產出!
{<section id="agli230.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-08-29 12:36:33), PR版次:0005(2016-10-13 15:24:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000189
#+ Filename...: agli230
#+ Description: 財報揭露事項維護作業
#+ Creator....: 02298(2014-01-14 09:50:36)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="agli230.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#15  2016/03/25 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160811-00039#6   2016/08/25 By 02599   查询及建立资料时（包括直接查询全部、开窗、输入值后的检核）及更改和删除，要考虑账套权限
#161013-00024#1   2016/10/13 By 02599   账套查询开窗修改传入参数为arg1=g_user arg2=g_dept
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
PRIVATE type type_g_glbg_m        RECORD
       glbgld LIKE glbg_t.glbgld, 
   glbgld_desc LIKE type_t.chr80, 
   glaacomp LIKE glaa_t.glaacomp, 
   glaacomp_desc LIKE type_t.chr80, 
   glbg002 LIKE glbg_t.glbg002, 
   glbg003 LIKE glbg_t.glbg003, 
   glbg001 LIKE glbg_t.glbg001, 
   glaa001 LIKE glaa_t.glaa001, 
   glaa016 LIKE type_t.chr10, 
   glaa020 LIKE glaa_t.glaa020
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glbg_d        RECORD
       glbgstus LIKE glbg_t.glbgstus, 
   glbg004 LIKE glbg_t.glbg004, 
   glbg005 LIKE glbg_t.glbg005, 
   glbg006 LIKE glbg_t.glbg006, 
   glbg007 LIKE glbg_t.glbg007, 
   glbg008 LIKE glbg_t.glbg008, 
   glbg009 LIKE glbg_t.glbg009, 
   glbg010 LIKE glbg_t.glbg010, 
   glbg011 LIKE glbg_t.glbg011
       END RECORD
PRIVATE TYPE type_g_glbg2_d RECORD
       glbg004 LIKE glbg_t.glbg004, 
   glbgmodid LIKE glbg_t.glbgmodid, 
   glbgmodid_desc LIKE type_t.chr500, 
   glbgmoddt DATETIME YEAR TO SECOND, 
   glbgownid LIKE glbg_t.glbgownid, 
   glbgownid_desc LIKE type_t.chr500, 
   glbgowndp LIKE glbg_t.glbgowndp, 
   glbgowndp_desc LIKE type_t.chr500, 
   glbgcrtid LIKE glbg_t.glbgcrtid, 
   glbgcrtid_desc LIKE type_t.chr500, 
   glbgcrtdp LIKE glbg_t.glbgcrtdp, 
   glbgcrtdp_desc LIKE type_t.chr500, 
   glbgcrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glbgld      LIKE glbg_t.glbgld
DEFINE g_glaacomp    LIKE glaa_t.glaacomp
DEFINE g_glaa001     LIKE glaa_t.glaa001
DEFINE g_glaa002     LIKE glaa_t.glaa002
DEFINE g_glaa004     LIKE glaa_t.glaa004
DEFINE g_glaa003     LIKE glaa_t.glaa003
DEFINE g_glaa015     LIKE glaa_t.glaa015
DEFINE g_glaa016     LIKE glaa_t.glaa016
DEFINE g_glaa017     LIKE glaa_t.glaa017
DEFINE g_glaa018     LIKE glaa_t.glaa018
DEFINE g_glaa019     LIKE glaa_t.glaa019
DEFINE g_glaa020     LIKE glaa_t.glaa020
DEFINE g_glaa021     LIKE glaa_t.glaa021
DEFINE g_glaa022     LIKE glaa_t.glaa022
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_glbg_m          type_g_glbg_m
DEFINE g_glbg_m_t        type_g_glbg_m
DEFINE g_glbg_m_o        type_g_glbg_m
DEFINE g_glbg_m_mask_o   type_g_glbg_m #轉換遮罩前資料
DEFINE g_glbg_m_mask_n   type_g_glbg_m #轉換遮罩後資料
 
   DEFINE g_glbgld_t LIKE glbg_t.glbgld
DEFINE g_glbg002_t LIKE glbg_t.glbg002
DEFINE g_glbg003_t LIKE glbg_t.glbg003
DEFINE g_glbg001_t LIKE glbg_t.glbg001
 
 
DEFINE g_glbg_d          DYNAMIC ARRAY OF type_g_glbg_d
DEFINE g_glbg_d_t        type_g_glbg_d
DEFINE g_glbg_d_o        type_g_glbg_d
DEFINE g_glbg_d_mask_o   DYNAMIC ARRAY OF type_g_glbg_d #轉換遮罩前資料
DEFINE g_glbg_d_mask_n   DYNAMIC ARRAY OF type_g_glbg_d #轉換遮罩後資料
DEFINE g_glbg2_d   DYNAMIC ARRAY OF type_g_glbg2_d
DEFINE g_glbg2_d_t type_g_glbg2_d
DEFINE g_glbg2_d_o type_g_glbg2_d
DEFINE g_glbg2_d_mask_o   DYNAMIC ARRAY OF type_g_glbg2_d #轉換遮罩前資料
DEFINE g_glbg2_d_mask_n   DYNAMIC ARRAY OF type_g_glbg2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_glbgld LIKE glbg_t.glbgld,
      b_glbg001 LIKE glbg_t.glbg001,
      b_glbg002 LIKE glbg_t.glbg002,
      b_glbg003 LIKE glbg_t.glbg003
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
 
{<section id="agli230.main" >}
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
   LET g_forupd_sql = " SELECT glbgld,'','','',glbg002,glbg003,glbg001,'','',''", 
                      " FROM glbg_t",
                      " WHERE glbgent= ? AND glbgld=? AND glbg001=? AND glbg002=? AND glbg003=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli230_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glbgld,t0.glbg002,t0.glbg003,t0.glbg001",
               " FROM glbg_t t0",
               
               " WHERE t0.glbgent = " ||g_enterprise|| " AND t0.glbgld = ? AND t0.glbg001 = ? AND t0.glbg002 = ? AND t0.glbg003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agli230_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agli230 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agli230_init()   
 
      #進入選單 Menu (="N")
      CALL agli230_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agli230
      
   END IF 
   
   CLOSE agli230_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agli230.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agli230_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('glbg001','8029') 
   CALL cl_set_combo_scc('glbg007','8030') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible("glaa016,glaa020,glbg008,glbg009,glbg010,glbg011",FALSE)
   #end add-point
   
   CALL agli230_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agli230.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agli230_ui_dialog()
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
         INITIALIZE g_glbg_m.* TO NULL
         CALL g_glbg_d.clear()
         CALL g_glbg2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agli230_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_glbg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL agli230_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL agli230_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_glbg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL agli230_idx_chk()
               CALL agli230_ui_detailshow()
               
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
            CALL agli230_browser_fill("")
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
               CALL agli230_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agli230_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agli230_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli230_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agli230_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli230_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agli230_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli230_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agli230_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli230_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agli230_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agli230_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_glbg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_glbg2_d)
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
               NEXT FIELD glbg004
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
               CALL agli230_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL agli230_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL agli230_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL agli230_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agli230_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agli230_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agli230_insert()
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
               CALL agli230_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agli230_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agli230_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agli230_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agli230_set_pk_array()
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
 
{<section id="agli230.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION agli230_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agli230.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agli230_browser_fill(ps_page_action)
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
   DEFINE l_ld_str          STRING   #160811-00039#6
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   #160811-00039#6--add--str--
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glbgld")
   IF cl_null(g_wc) THEN 
      LET g_wc = l_ld_str
   ELSE
      LET g_wc = g_wc," AND ",l_ld_str
   END IF
   #160811-00039#6--add--end
   #end add-point    
 
   LET l_searchcol = "glbgld,glbg001,glbg002,glbg003"
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
      LET l_sub_sql = " SELECT DISTINCT glbgld ",
                      ", glbg001 ",
                      ", glbg002 ",
                      ", glbg003 ",
 
                      " FROM glbg_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE glbgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glbg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glbgld ",
                      ", glbg001 ",
                      ", glbg002 ",
                      ", glbg003 ",
 
                      " FROM glbg_t ",
                      " ",
                      " ", 
 
 
                      " WHERE glbgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glbg_t")
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
      INITIALIZE g_glbg_m.* TO NULL
      CALL g_glbg_d.clear()        
      CALL g_glbg2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glbgld,t0.glbg001,t0.glbg002,t0.glbg003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.glbgld,t0.glbg001,t0.glbg002,t0.glbg003",
                " FROM glbg_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.glbgent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glbg_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glbg_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_glbgld,g_browser[g_cnt].b_glbg001,g_browser[g_cnt].b_glbg002, 
          g_browser[g_cnt].b_glbg003 
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
   
   IF cl_null(g_browser[g_cnt].b_glbgld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_glbg_m.* TO NULL
      CALL g_glbg_d.clear()
      CALL g_glbg2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL agli230_fetch('')
   
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
 
{<section id="agli230.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agli230_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glbg_m.glbgld = g_browser[g_current_idx].b_glbgld   
   LET g_glbg_m.glbg001 = g_browser[g_current_idx].b_glbg001   
   LET g_glbg_m.glbg002 = g_browser[g_current_idx].b_glbg002   
   LET g_glbg_m.glbg003 = g_browser[g_current_idx].b_glbg003   
 
   EXECUTE agli230_master_referesh USING g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003 INTO g_glbg_m.glbgld, 
       g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001
   CALL agli230_show()
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agli230_ui_detailshow()
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
 
{<section id="agli230.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agli230_ui_browser_refresh()
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
      IF g_browser[l_i].b_glbgld = g_glbg_m.glbgld 
         AND g_browser[l_i].b_glbg001 = g_glbg_m.glbg001 
         AND g_browser[l_i].b_glbg002 = g_glbg_m.glbg002 
         AND g_browser[l_i].b_glbg003 = g_glbg_m.glbg003 
 
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
 
{<section id="agli230.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agli230_construct()
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
   INITIALIZE g_glbg_m.* TO NULL
   CALL g_glbg_d.clear()
   CALL g_glbg2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glbgld,glbg002,glbg003,glbg001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.glbgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgld
            #add-point:ON ACTION controlp INFIELD glbgld name="construct.c.glbgld"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_user
#			LET g_qryparam.arg1 = g_dept #161013-00024#1 mark
         LET g_qryparam.arg2 = g_dept #161013-00024#1 add
         CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbgld  #顯示到畫面上

            NEXT FIELD glbgld                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgld
            #add-point:BEFORE FIELD glbgld name="construct.b.glbgld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgld
            
            #add-point:AFTER FIELD glbgld name="construct.a.glbgld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg002
            #add-point:BEFORE FIELD glbg002 name="construct.b.glbg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg002
            
            #add-point:AFTER FIELD glbg002 name="construct.a.glbg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg002
            #add-point:ON ACTION controlp INFIELD glbg002 name="construct.c.glbg002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg003
            #add-point:BEFORE FIELD glbg003 name="construct.b.glbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg003
            
            #add-point:AFTER FIELD glbg003 name="construct.a.glbg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg003
            #add-point:ON ACTION controlp INFIELD glbg003 name="construct.c.glbg003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg001
            #add-point:BEFORE FIELD glbg001 name="construct.b.glbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg001
            
            #add-point:AFTER FIELD glbg001 name="construct.a.glbg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg001
            #add-point:ON ACTION controlp INFIELD glbg001 name="construct.c.glbg001"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON glbgstus,glbg004,glbg005,glbg006,glbg007,glbg008,glbg009,glbg010,glbg011, 
          glbgmodid,glbgmoddt,glbgownid,glbgowndp,glbgcrtid,glbgcrtdp,glbgcrtdt
           FROM s_detail1[1].glbgstus,s_detail1[1].glbg004,s_detail1[1].glbg005,s_detail1[1].glbg006, 
               s_detail1[1].glbg007,s_detail1[1].glbg008,s_detail1[1].glbg009,s_detail1[1].glbg010,s_detail1[1].glbg011, 
               s_detail2[1].glbgmodid,s_detail2[1].glbgmoddt,s_detail2[1].glbgownid,s_detail2[1].glbgowndp, 
               s_detail2[1].glbgcrtid,s_detail2[1].glbgcrtdp,s_detail2[1].glbgcrtdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glbgcrtdt>>----
         AFTER FIELD glbgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glbgmoddt>>----
         AFTER FIELD glbgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glbgcnfdt>>----
         
         #----<<glbgpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgstus
            #add-point:BEFORE FIELD glbgstus name="construct.b.page1.glbgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgstus
            
            #add-point:AFTER FIELD glbgstus name="construct.a.page1.glbgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgstus
            #add-point:ON ACTION controlp INFIELD glbgstus name="construct.c.page1.glbgstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg004
            #add-point:BEFORE FIELD glbg004 name="construct.b.page1.glbg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg004
            
            #add-point:AFTER FIELD glbg004 name="construct.a.page1.glbg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg004
            #add-point:ON ACTION controlp INFIELD glbg004 name="construct.c.page1.glbg004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg005
            #add-point:BEFORE FIELD glbg005 name="construct.b.page1.glbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg005
            
            #add-point:AFTER FIELD glbg005 name="construct.a.page1.glbg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg005
            #add-point:ON ACTION controlp INFIELD glbg005 name="construct.c.page1.glbg005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg006
            #add-point:BEFORE FIELD glbg006 name="construct.b.page1.glbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg006
            
            #add-point:AFTER FIELD glbg006 name="construct.a.page1.glbg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg006
            #add-point:ON ACTION controlp INFIELD glbg006 name="construct.c.page1.glbg006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg007
            #add-point:BEFORE FIELD glbg007 name="construct.b.page1.glbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg007
            
            #add-point:AFTER FIELD glbg007 name="construct.a.page1.glbg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg007
            #add-point:ON ACTION controlp INFIELD glbg007 name="construct.c.page1.glbg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg008
            #add-point:BEFORE FIELD glbg008 name="construct.b.page1.glbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg008
            
            #add-point:AFTER FIELD glbg008 name="construct.a.page1.glbg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg008
            #add-point:ON ACTION controlp INFIELD glbg008 name="construct.c.page1.glbg008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg009
            #add-point:BEFORE FIELD glbg009 name="construct.b.page1.glbg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg009
            
            #add-point:AFTER FIELD glbg009 name="construct.a.page1.glbg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg009
            #add-point:ON ACTION controlp INFIELD glbg009 name="construct.c.page1.glbg009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg010
            #add-point:BEFORE FIELD glbg010 name="construct.b.page1.glbg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg010
            
            #add-point:AFTER FIELD glbg010 name="construct.a.page1.glbg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg010
            #add-point:ON ACTION controlp INFIELD glbg010 name="construct.c.page1.glbg010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg011
            #add-point:BEFORE FIELD glbg011 name="construct.b.page1.glbg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg011
            
            #add-point:AFTER FIELD glbg011 name="construct.a.page1.glbg011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg011
            #add-point:ON ACTION controlp INFIELD glbg011 name="construct.c.page1.glbg011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glbgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgmodid
            #add-point:ON ACTION controlp INFIELD glbgmodid name="construct.c.page2.glbgmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbgmodid  #顯示到畫面上
            NEXT FIELD glbgmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgmodid
            #add-point:BEFORE FIELD glbgmodid name="construct.b.page2.glbgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgmodid
            
            #add-point:AFTER FIELD glbgmodid name="construct.a.page2.glbgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgmoddt
            #add-point:BEFORE FIELD glbgmoddt name="construct.b.page2.glbgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glbgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgownid
            #add-point:ON ACTION controlp INFIELD glbgownid name="construct.c.page2.glbgownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbgownid  #顯示到畫面上
            NEXT FIELD glbgownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgownid
            #add-point:BEFORE FIELD glbgownid name="construct.b.page2.glbgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgownid
            
            #add-point:AFTER FIELD glbgownid name="construct.a.page2.glbgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glbgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgowndp
            #add-point:ON ACTION controlp INFIELD glbgowndp name="construct.c.page2.glbgowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbgowndp  #顯示到畫面上
            NEXT FIELD glbgowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgowndp
            #add-point:BEFORE FIELD glbgowndp name="construct.b.page2.glbgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgowndp
            
            #add-point:AFTER FIELD glbgowndp name="construct.a.page2.glbgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glbgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgcrtid
            #add-point:ON ACTION controlp INFIELD glbgcrtid name="construct.c.page2.glbgcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbgcrtid  #顯示到畫面上
            NEXT FIELD glbgcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgcrtid
            #add-point:BEFORE FIELD glbgcrtid name="construct.b.page2.glbgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgcrtid
            
            #add-point:AFTER FIELD glbgcrtid name="construct.a.page2.glbgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glbgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgcrtdp
            #add-point:ON ACTION controlp INFIELD glbgcrtdp name="construct.c.page2.glbgcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbgcrtdp  #顯示到畫面上
            NEXT FIELD glbgcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgcrtdp
            #add-point:BEFORE FIELD glbgcrtdp name="construct.b.page2.glbgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgcrtdp
            
            #add-point:AFTER FIELD glbgcrtdp name="construct.a.page2.glbgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgcrtdt
            #add-point:BEFORE FIELD glbgcrtdt name="construct.b.page2.glbgcrtdt"
            
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
 
{<section id="agli230.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agli230_query()
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
   CALL g_glbg_d.clear()
   CALL g_glbg2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL agli230_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agli230_browser_fill(g_wc)
      CALL agli230_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL agli230_browser_fill("F")
   
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
      CALL agli230_fetch("F") 
   END IF
   
   CALL agli230_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agli230_fetch(p_flag)
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
   
   #CALL agli230_browser_fill(p_flag)
   
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
   
   LET g_glbg_m.glbgld = g_browser[g_current_idx].b_glbgld
   LET g_glbg_m.glbg001 = g_browser[g_current_idx].b_glbg001
   LET g_glbg_m.glbg002 = g_browser[g_current_idx].b_glbg002
   LET g_glbg_m.glbg003 = g_browser[g_current_idx].b_glbg003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agli230_master_referesh USING g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003 INTO g_glbg_m.glbgld, 
       g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glbg_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_glbg_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_glbg_m_mask_o.* =  g_glbg_m.*
   CALL agli230_glbg_t_mask()
   LET g_glbg_m_mask_n.* =  g_glbg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL agli230_set_act_visible()
   CALL agli230_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_glbg_m_t.* = g_glbg_m.*
   LET g_glbg_m_o.* = g_glbg_m.*
   
   #重新顯示   
   CALL agli230_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="agli230.insert" >}
#+ 資料新增
PRIVATE FUNCTION agli230_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_glbg_d.clear()
   CALL g_glbg2_d.clear()
 
 
   INITIALIZE g_glbg_m.* TO NULL             #DEFAULT 設定
   LET g_glbgld_t = NULL
   LET g_glbg001_t = NULL
   LET g_glbg002_t = NULL
   LET g_glbg003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      #获取账别
      CALL s_ld_bookno()  RETURNING l_success,g_glbgld
      IF l_success = TRUE THEN
         CALL s_ld_chk_authorization(g_user,g_glbgld) RETURNING l_pass
         IF l_pass = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00164'
            LET g_errparam.extend = g_glbgld
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_glbgld = ''
            LET g_glbg_m.glbgld_desc = ''
            LET g_glbg_m.glaacomp_desc =''
            LET g_glbg_m.glaa001 = ''               
         END IF
      ELSE
         LET g_glbgld = '' 
         LET g_glbg_m.glbgld_desc = ''
         LET g_glbg_m.glaacomp_desc =''
         LET g_glbg_m.glaa001 = ''         
      END IF
      LET g_glbg_m.glbgld = g_glbgld
      CALL agli230_glbgld_desc(g_glbg_m.glbgld)
      DISPLAY BY NAME g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,
                      g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
      LET g_glbg_m.glbg002 = YEAR(g_today)
      LET g_glbg_m.glbg003 = MONTH(g_today)          {#ADP版次:1#}
      #end add-point 
 
      CALL agli230_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_glbg_m.* TO NULL
         INITIALIZE g_glbg_d TO NULL
         INITIALIZE g_glbg2_d TO NULL
 
         CALL agli230_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glbg_m.* = g_glbg_m_t.*
         CALL agli230_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_glbg_d.clear()
      #CALL g_glbg2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL agli230_set_act_visible()
   CALL agli230_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glbgld_t = g_glbg_m.glbgld
   LET g_glbg001_t = g_glbg_m.glbg001
   LET g_glbg002_t = g_glbg_m.glbg002
   LET g_glbg003_t = g_glbg_m.glbg003
 
   
   #組合新增資料的條件
   LET g_add_browse = " glbgent = " ||g_enterprise|| " AND",
                      " glbgld = '", g_glbg_m.glbgld, "' "
                      ," AND glbg001 = '", g_glbg_m.glbg001, "' "
                      ," AND glbg002 = '", g_glbg_m.glbg002, "' "
                      ," AND glbg003 = '", g_glbg_m.glbg003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli230_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL agli230_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agli230_master_referesh USING g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003 INTO g_glbg_m.glbgld, 
       g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001
   
   #遮罩相關處理
   LET g_glbg_m_mask_o.* =  g_glbg_m.*
   CALL agli230_glbg_t_mask()
   LET g_glbg_m_mask_n.* =  g_glbg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glbg_m.glbgld,g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,g_glbg_m.glbg002, 
       g_glbg_m.glbg003,g_glbg_m.glbg001,g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
   
   #功能已完成,通報訊息中心
   CALL agli230_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.modify" >}
#+ 資料修改
PRIVATE FUNCTION agli230_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_pass           LIKE type_t.num5 #160811-00039#6 add
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #160811-00039#6--add--str--
   IF g_glbg_m.glbgld IS NULL
   OR g_glbg_m.glbg001 IS NULL
   OR g_glbg_m.glbg002 IS NULL
   OR g_glbg_m.glbg003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_ld_chk_authorization(g_user,g_glbg_m.glbgld ) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glbg_m.glbgld
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN
   END IF
   #160811-00039#6--add--end
   #end add-point
   
   IF g_glbg_m.glbgld IS NULL
   OR g_glbg_m.glbg001 IS NULL
   OR g_glbg_m.glbg002 IS NULL
   OR g_glbg_m.glbg003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_glbgld_t = g_glbg_m.glbgld
   LET g_glbg001_t = g_glbg_m.glbg001
   LET g_glbg002_t = g_glbg_m.glbg002
   LET g_glbg003_t = g_glbg_m.glbg003
 
   CALL s_transaction_begin()
   
   OPEN agli230_cl USING g_enterprise,g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli230_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE agli230_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli230_master_referesh USING g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003 INTO g_glbg_m.glbgld, 
       g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001
   
   #遮罩相關處理
   LET g_glbg_m_mask_o.* =  g_glbg_m.*
   CALL agli230_glbg_t_mask()
   LET g_glbg_m_mask_n.* =  g_glbg_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL agli230_show()
   WHILE TRUE
      LET g_glbgld_t = g_glbg_m.glbgld
      LET g_glbg001_t = g_glbg_m.glbg001
      LET g_glbg002_t = g_glbg_m.glbg002
      LET g_glbg003_t = g_glbg_m.glbg003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL agli230_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glbg_m.* = g_glbg_m_t.*
         CALL agli230_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_glbg_m.glbgld != g_glbgld_t 
      OR g_glbg_m.glbg001 != g_glbg001_t 
      OR g_glbg_m.glbg002 != g_glbg002_t 
      OR g_glbg_m.glbg003 != g_glbg003_t 
 
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
   CALL agli230_set_act_visible()
   CALL agli230_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glbgent = " ||g_enterprise|| " AND",
                      " glbgld = '", g_glbg_m.glbgld, "' "
                      ," AND glbg001 = '", g_glbg_m.glbg001, "' "
                      ," AND glbg002 = '", g_glbg_m.glbg002, "' "
                      ," AND glbg003 = '", g_glbg_m.glbg003, "' "
 
   #填到對應位置
   CALL agli230_browser_fill("")
 
   CALL agli230_idx_chk()
 
   CLOSE agli230_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agli230_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="agli230.input" >}
#+ 資料輸入
PRIVATE FUNCTION agli230_input(p_cmd)
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
   DEFINE l_pass           LIKE type_t.num5 
   DEFINE l_glav003        LIKE glav_t.glav003
   DEFINE l_days           LIKE type_t.num5
   DEFINE l_date           LIKE glap_t.glapdocdt
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
   DISPLAY BY NAME g_glbg_m.glbgld,g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,g_glbg_m.glbg002, 
       g_glbg_m.glbg003,g_glbg_m.glbg001,g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
   
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
   LET g_forupd_sql = "SELECT glbgstus,glbg004,glbg005,glbg006,glbg007,glbg008,glbg009,glbg010,glbg011, 
       glbg004,glbgmodid,glbgmoddt,glbgownid,glbgowndp,glbgcrtid,glbgcrtdp,glbgcrtdt FROM glbg_t WHERE  
       glbgent=? AND glbgld=? AND glbg001=? AND glbg002=? AND glbg003=? AND glbg004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli230_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agli230_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL agli230_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_glbg_m.glbgld,g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agli230.input.head" >}
   
      #單頭段
      INPUT BY NAME g_glbg_m.glbgld,g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001 
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
         AFTER FIELD glbgld
            
            #add-point:AFTER FIELD glbgld name="input.a.glbgld"
            #此段落由子樣板a05產生
             IF NOT cl_null(g_glbg_m.glbgld) THEN
               CALL agli230_glbgld_chk(g_glbg_m.glbgld)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glbg_m.glbgld
                  #160318-00005#15  --add--str
                  LET g_errparam.replace[1] ='agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog    ='agli010'
                  #160318-00005#15  --add--end
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glbg_m.glbgld = g_glbgld_t
                  CALL agli230_glbgld_desc(g_glbg_m.glbgld)
                  DISPLAY BY NAME g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,
                                  g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
                  NEXT FIELD glbgld
               END IF
               #检查使用者权限
               CALL s_ld_chk_authorization(g_user,g_glbg_m.glbgld)  RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_glbg_m.glbgld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glbg_m.glbgld = g_glbgld_t
                  CALL agli230_glbgld_desc(g_glbg_m.glbgld)
                  DISPLAY BY NAME g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,
                                  g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
                  NEXT FIELD glbgld
               END IF
            END IF
            #重复性检查
            IF  NOT cl_null(g_glbg_m.glbgld) AND NOT cl_null(g_glbg_m.glbg001) AND NOT cl_null(g_glbg_m.glbg002) AND NOT cl_null(g_glbg_m.glbg003)  THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glbg_m.glbgld != g_glbgld_t  OR g_glbg_m.glbg001 != g_glbg001_t  OR g_glbg_m.glbg002 != g_glbg002_t  OR g_glbg_m.glbg003 != g_glbg003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glbg_t WHERE "||"glbgent = '" ||g_enterprise|| "' AND "||"glbgld = '"||g_glbg_m.glbgld ||"' AND "|| "glbg001 = '"||g_glbg_m.glbg001 ||"' AND "|| "glbg002 = '"||g_glbg_m.glbg002 ||"' AND "|| "glbg003 = '"||g_glbg_m.glbg003 ||"' ",'std-00004',0) THEN 
                     LET g_glbg_m.glbgld = g_glbgld_t
                     CALL agli230_glbgld_desc(g_glbg_m.glbgld)
                     DISPLAY BY NAME g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,
                                     g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
           CALL agli230_glbgld_desc(g_glbg_m.glbgld)
           DISPLAY BY NAME g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,
                           g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgld
            #add-point:BEFORE FIELD glbgld name="input.b.glbgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbgld
            #add-point:ON CHANGE glbgld name="input.g.glbgld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glbg_m.glbg002,"1000","1","9999","1","azz-00087",1) THEN
               NEXT FIELD glbg002
            END IF 
 
 
 
            #add-point:AFTER FIELD glbg002 name="input.a.glbg002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glbg_m.glbgld) AND NOT cl_null(g_glbg_m.glbg001) AND NOT cl_null(g_glbg_m.glbg002) AND NOT cl_null(g_glbg_m.glbg003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glbg_m.glbgld != g_glbgld_t  OR g_glbg_m.glbg001 != g_glbg001_t  OR g_glbg_m.glbg002 != g_glbg002_t  OR g_glbg_m.glbg003 != g_glbg003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glbg_t WHERE "||"glbgent = '" ||g_enterprise|| "' AND "||"glbgld = '"||g_glbg_m.glbgld ||"' AND "|| "glbg001 = '"||g_glbg_m.glbg001 ||"' AND "|| "glbg002 = '"||g_glbg_m.glbg002 ||"' AND "|| "glbg003 = '"||g_glbg_m.glbg003 ||"'",'std-00004',0) THEN 
                     LET g_glbg_m.glbg002 = g_glbg002_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg002
            #add-point:BEFORE FIELD glbg002 name="input.b.glbg002"
                 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg002
            #add-point:ON CHANGE glbg002 name="input.g.glbg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg003
            #add-point:BEFORE FIELD glbg003 name="input.b.glbg003"
            #录入期别前，年度不可为空
            IF cl_null(g_glbg_m.glbg002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00183'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD glbg002
            END IF  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg003
            
            #add-point:AFTER FIELD glbg003 name="input.a.glbg003"
            #资料检查,期别依据agli100对应年度设置不同，分12期和13期
            SELECT glav003 INTO l_glav003 FROM glav_t
             WHERE glavent = g_enterprise
               AND glav001 = g_glaa003
               AND glav002 = g_glbg_m.glbg001
            #1.月，2.周，3.445式   
            IF cl_null(l_glav003) OR l_glav003 = '1' OR l_glav003 = '3' THEN
               IF g_glbg_m.glbg003 <1 OR g_glbg_m.glbg003 >12 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_glbg_m.glbg002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glbg_m.glbg003 = g_glbg003_t
                  NEXT FIELD glbg003
               END IF 
            ELSE
               IF g_glbg_m.glbg003 <1 OR g_glbg_m.glbg003 >13 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00143'
                  LET g_errparam.extend = g_glbg_m.glbg002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glbg_m.glbg003 = g_glbg003_t
                  NEXT FIELD glbg003
               END IF  
            END IF            

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glbg_m.glbgld) AND NOT cl_null(g_glbg_m.glbg001) AND NOT cl_null(g_glbg_m.glbg002) AND NOT cl_null(g_glbg_m.glbg003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glbg_m.glbgld != g_glbgld_t  OR g_glbg_m.glbg001 != g_glbg001_t  OR g_glbg_m.glbg002 != g_glbg002_t  OR g_glbg_m.glbg003 != g_glbg003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glbg_t WHERE "||"glbgent = '" ||g_enterprise|| "' AND "||"glbgld = '"||g_glbg_m.glbgld ||"' AND "|| "glbg001 = '"||g_glbg_m.glbg001 ||"' AND "|| "glbg002 = '"||g_glbg_m.glbg002 ||"' AND "|| "glbg003 = '"||g_glbg_m.glbg003 ||"'",'std-00004',0) THEN 
                     LET g_glbg_m.glbg003 = g_glbg003_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg003
            #add-point:ON CHANGE glbg003 name="input.g.glbg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg001
            #add-point:BEFORE FIELD glbg001 name="input.b.glbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg001
            
            #add-point:AFTER FIELD glbg001 name="input.a.glbg001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glbg_m.glbgld) AND NOT cl_null(g_glbg_m.glbg001) AND NOT cl_null(g_glbg_m.glbg002) AND NOT cl_null(g_glbg_m.glbg003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glbg_m.glbgld != g_glbgld_t  OR g_glbg_m.glbg001 != g_glbg001_t  OR g_glbg_m.glbg002 != g_glbg002_t  OR g_glbg_m.glbg003 != g_glbg003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glbg_t WHERE "||"glbgent = '" ||g_enterprise|| "' AND "||"glbgld = '"||g_glbg_m.glbgld ||"' AND "|| "glbg001 = '"||g_glbg_m.glbg001 ||"' AND "|| "glbg002 = '"||g_glbg_m.glbg002 ||"' AND "|| "glbg003 = '"||g_glbg_m.glbg003 ||"'",'std-00004',0) THEN 
                     LET g_glbg_m.glbg001 = g_glbg001_t                   
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg001
            #add-point:ON CHANGE glbg001 name="input.g.glbg001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glbgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgld
            #add-point:ON ACTION controlp INFIELD glbgld name="input.c.glbgld"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glbg_m.glbgld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user 
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glbg_m.glbgld = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glbg_m.glbgld TO glbgld              #顯示到畫面上

            NEXT FIELD glbgld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg002
            #add-point:ON ACTION controlp INFIELD glbg002 name="input.c.glbg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg003
            #add-point:ON ACTION controlp INFIELD glbg003 name="input.c.glbg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg001
            #add-point:ON ACTION controlp INFIELD glbg001 name="input.c.glbg001"
            
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
            DISPLAY BY NAME g_glbg_m.glbgld             
                            ,g_glbg_m.glbg001   
                            ,g_glbg_m.glbg002   
                            ,g_glbg_m.glbg003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL agli230_glbg_t_mask_restore('restore_mask_o')
            
               UPDATE glbg_t SET (glbgld,glbg002,glbg003,glbg001) = (g_glbg_m.glbgld,g_glbg_m.glbg002, 
                   g_glbg_m.glbg003,g_glbg_m.glbg001)
                WHERE glbgent = g_enterprise AND glbgld = g_glbgld_t
                  AND glbg001 = g_glbg001_t
                  AND glbg002 = g_glbg002_t
                  AND glbg003 = g_glbg003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glbg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glbg_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glbg_m.glbgld
               LET gs_keys_bak[1] = g_glbgld_t
               LET gs_keys[2] = g_glbg_m.glbg001
               LET gs_keys_bak[2] = g_glbg001_t
               LET gs_keys[3] = g_glbg_m.glbg002
               LET gs_keys_bak[3] = g_glbg002_t
               LET gs_keys[4] = g_glbg_m.glbg003
               LET gs_keys_bak[4] = g_glbg003_t
               LET gs_keys[5] = g_glbg_d[g_detail_idx].glbg004
               LET gs_keys_bak[5] = g_glbg_d_t.glbg004
               CALL agli230_update_b('glbg_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_glbg_m_t)
                     #LET g_log2 = util.JSON.stringify(g_glbg_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL agli230_glbg_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL agli230_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_glbgld_t = g_glbg_m.glbgld
           LET g_glbg001_t = g_glbg_m.glbg001
           LET g_glbg002_t = g_glbg_m.glbg002
           LET g_glbg003_t = g_glbg_m.glbg003
 
           
           IF g_glbg_d.getLength() = 0 THEN
              NEXT FIELD glbg004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="agli230.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_glbg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glbg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agli230_b_fill(g_wc2) #test 
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
            CALL agli230_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN agli230_cl USING g_enterprise,g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE agli230_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN agli230_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_glbg_d[l_ac].glbg004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glbg_d_t.* = g_glbg_d[l_ac].*  #BACKUP
               LET g_glbg_d_o.* = g_glbg_d[l_ac].*  #BACKUP
               CALL agli230_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL agli230_set_no_entry_b(l_cmd)
               OPEN agli230_bcl USING g_enterprise,g_glbg_m.glbgld,
                                                g_glbg_m.glbg001,
                                                g_glbg_m.glbg002,
                                                g_glbg_m.glbg003,
 
                                                g_glbg_d_t.glbg004
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN agli230_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli230_bcl INTO g_glbg_d[l_ac].glbgstus,g_glbg_d[l_ac].glbg004,g_glbg_d[l_ac].glbg005, 
                      g_glbg_d[l_ac].glbg006,g_glbg_d[l_ac].glbg007,g_glbg_d[l_ac].glbg008,g_glbg_d[l_ac].glbg009, 
                      g_glbg_d[l_ac].glbg010,g_glbg_d[l_ac].glbg011,g_glbg2_d[l_ac].glbg004,g_glbg2_d[l_ac].glbgmodid, 
                      g_glbg2_d[l_ac].glbgmoddt,g_glbg2_d[l_ac].glbgownid,g_glbg2_d[l_ac].glbgowndp, 
                      g_glbg2_d[l_ac].glbgcrtid,g_glbg2_d[l_ac].glbgcrtdp,g_glbg2_d[l_ac].glbgcrtdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_glbg_d_t.glbg004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glbg_d_mask_o[l_ac].* =  g_glbg_d[l_ac].*
                  CALL agli230_glbg_t_mask()
                  LET g_glbg_d_mask_n[l_ac].* =  g_glbg_d[l_ac].*
                  
                  CALL agli230_ref_show()
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
            INITIALIZE g_glbg_d_t.* TO NULL
            INITIALIZE g_glbg_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glbg_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glbg2_d[l_ac].glbgownid = g_user
      LET g_glbg2_d[l_ac].glbgowndp = g_dept
      LET g_glbg2_d[l_ac].glbgcrtid = g_user
      LET g_glbg2_d[l_ac].glbgcrtdp = g_dept 
      LET g_glbg2_d[l_ac].glbgcrtdt = cl_get_current()
      LET g_glbg2_d[l_ac].glbgmodid = g_user
      LET g_glbg2_d[l_ac].glbgmoddt = cl_get_current()
      LET g_glbg_d[l_ac].glbgstus = ''
 
 
  
            #一般欄位預設值
                  LET g_glbg_d[l_ac].glbgstus = "Y"
      LET g_glbg_d[l_ac].glbg006 = "0"
      LET g_glbg_d[l_ac].glbg007 = "1"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_glbg_d_t.* = g_glbg_d[l_ac].*     #新輸入資料
            LET g_glbg_d_o.* = g_glbg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agli230_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL agli230_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glbg_d[li_reproduce_target].* = g_glbg_d[li_reproduce].*
               LET g_glbg2_d[li_reproduce_target].* = g_glbg2_d[li_reproduce].*
 
               LET g_glbg_d[g_glbg_d.getLength()].glbg004 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
             IF cl_null(g_glbg_d[l_ac].glbg004) THEN
                  SELECT MAX(glbg004)+1 INTO g_glbg_d[l_ac].glbg004
                    FROM glbg_t
                   WHERE glbgent = g_enterprise
                     AND glbgld =  g_glbg_m.glbgld
                     AND glbg001 = g_glbg_m.glbg001
                     AND glbg002 = g_glbg_m.glbg002
                     
                  
                  IF cl_null(g_glbg_d[l_ac].glbg004) THEN
                     LET g_glbg_d[l_ac].glbg004 = 1
                  END IF
               END IF          {#ADP版次:1#}
               
            #预设汇率  
            CALL s_date_get_max_day(g_glbg_m.glbg002,g_glbg_m.glbg003) RETURNING l_days              
            LET l_date = MDY(g_glbg_m.glbg003,l_days,g_glbg_m.glbg002)
            IF g_glaa015='Y' THEN
               CALL s_aooi160_get_exrate('2',g_glbg_m.glbgld,l_date,g_glaa001,g_glaa016,0,g_glaa018)
               RETURNING  g_glbg_d[l_ac].glbg008
            END IF
               
            IF g_glaa019='Y' THEN
               CALL s_aooi160_get_exrate('2',g_glbg_m.glbgld,l_date,g_glaa001,g_glaa020,0,g_glaa022) 
               RETURNING  g_glbg_d[l_ac].glbg010 
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
            SELECT COUNT(1) INTO l_count FROM glbg_t 
             WHERE glbgent = g_enterprise AND glbgld = g_glbg_m.glbgld
               AND glbg001 = g_glbg_m.glbg001
               AND glbg002 = g_glbg_m.glbg002
               AND glbg003 = g_glbg_m.glbg003
 
               AND glbg004 = g_glbg_d[l_ac].glbg004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_glbg_d[l_ac].glbg008) THEN LET g_glbg_d[l_ac].glbg008 = 1 END IF
               IF cl_null(g_glbg_d[l_ac].glbg009) THEN LET g_glbg_d[l_ac].glbg009 = 0 END IF
               IF cl_null(g_glbg_d[l_ac].glbg010) THEN LET g_glbg_d[l_ac].glbg010 = 1 END IF
               IF cl_null(g_glbg_d[l_ac].glbg011) THEN LET g_glbg_d[l_ac].glbg011 = 0 END IF
               #end add-point
               INSERT INTO glbg_t
                           (glbgent,
                            glbgld,glbg002,glbg003,glbg001,
                            glbg004
                            ,glbgstus,glbg005,glbg006,glbg007,glbg008,glbg009,glbg010,glbg011,glbgmodid,glbgmoddt,glbgownid,glbgowndp,glbgcrtid,glbgcrtdp,glbgcrtdt) 
                     VALUES(g_enterprise,
                            g_glbg_m.glbgld,g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001,
                            g_glbg_d[l_ac].glbg004
                            ,g_glbg_d[l_ac].glbgstus,g_glbg_d[l_ac].glbg005,g_glbg_d[l_ac].glbg006,g_glbg_d[l_ac].glbg007, 
                                g_glbg_d[l_ac].glbg008,g_glbg_d[l_ac].glbg009,g_glbg_d[l_ac].glbg010, 
                                g_glbg_d[l_ac].glbg011,g_glbg2_d[l_ac].glbgmodid,g_glbg2_d[l_ac].glbgmoddt, 
                                g_glbg2_d[l_ac].glbgownid,g_glbg2_d[l_ac].glbgowndp,g_glbg2_d[l_ac].glbgcrtid, 
                                g_glbg2_d[l_ac].glbgcrtdp,g_glbg2_d[l_ac].glbgcrtdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_glbg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "glbg_t:",SQLERRMESSAGE 
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
               IF agli230_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glbg_m.glbgld
                  LET gs_keys[gs_keys.getLength()+1] = g_glbg_m.glbg001
                  LET gs_keys[gs_keys.getLength()+1] = g_glbg_m.glbg002
                  LET gs_keys[gs_keys.getLength()+1] = g_glbg_m.glbg003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glbg_d_t.glbg004
 
 
                  #刪除下層單身
                  IF NOT agli230_key_delete_b(gs_keys,'glbg_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE agli230_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE agli230_bcl
               LET l_count = g_glbg_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_glbg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbgstus
            #add-point:BEFORE FIELD glbgstus name="input.b.page1.glbgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbgstus
            
            #add-point:AFTER FIELD glbgstus name="input.a.page1.glbgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbgstus
            #add-point:ON CHANGE glbgstus name="input.g.page1.glbgstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg004
            #add-point:BEFORE FIELD glbg004 name="input.b.page1.glbg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg004
            
            #add-point:AFTER FIELD glbg004 name="input.a.page1.glbg004"
            #此段落由子樣板a05產生
            IF  g_glbg_m.glbgld IS NOT NULL AND g_glbg_m.glbg001 IS NOT NULL AND g_glbg_m.glbg002 IS NOT NULL AND g_glbg_m.glbg003 IS NOT NULL AND g_glbg_d[g_detail_idx].glbg004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glbg_m.glbgld != g_glbgld_t OR g_glbg_m.glbg001 != g_glbg001_t OR g_glbg_m.glbg002 != g_glbg002_t OR g_glbg_m.glbg003 != g_glbg003_t OR g_glbg_d[g_detail_idx].glbg004 != g_glbg_d_t.glbg004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glbg_t WHERE "||"glbgent = '" ||g_enterprise|| "' AND "||"glbgld = '"||g_glbg_m.glbgld ||"' AND "|| "glbg001 = '"||g_glbg_m.glbg001 ||"' AND "|| "glbg002 = '"||g_glbg_m.glbg002 ||"' AND "|| "glbg003 = '"||g_glbg_m.glbg003 ||"' AND "|| "glbg004 = '"||g_glbg_d[g_detail_idx].glbg004 ||"'",'std-00004',0) THEN 
                     LET g_glbg_d[g_detail_idx].glbg004 = g_glbg_d_t.glbg004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg004
            #add-point:ON CHANGE glbg004 name="input.g.page1.glbg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg005
            #add-point:BEFORE FIELD glbg005 name="input.b.page1.glbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg005
            
            #add-point:AFTER FIELD glbg005 name="input.a.page1.glbg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg005
            #add-point:ON CHANGE glbg005 name="input.g.page1.glbg005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glbg_d[l_ac].glbg006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glbg006
            END IF 
 
 
 
            #add-point:AFTER FIELD glbg006 name="input.a.page1.glbg006"
            IF NOT cl_null(g_glbg_d[l_ac].glbg006) THEN 
               IF l_cmd = 'a' THEN
                  LET g_glbg_d[l_ac].glbg009 = g_glbg_d[l_ac].glbg006 * g_glbg_d[l_ac].glbg008
                  LET g_glbg_d[l_ac].glbg011 = g_glbg_d[l_ac].glbg006 * g_glbg_d[l_ac].glbg010
               END IF    
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg006
            #add-point:BEFORE FIELD glbg006 name="input.b.page1.glbg006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg006
            #add-point:ON CHANGE glbg006 name="input.g.page1.glbg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg007
            #add-point:BEFORE FIELD glbg007 name="input.b.page1.glbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg007
            
            #add-point:AFTER FIELD glbg007 name="input.a.page1.glbg007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg007
            #add-point:ON CHANGE glbg007 name="input.g.page1.glbg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg008
            #add-point:BEFORE FIELD glbg008 name="input.b.page1.glbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg008
            
            #add-point:AFTER FIELD glbg008 name="input.a.page1.glbg008"
            IF NOT cl_null(g_glbg_d[l_ac].glbg008) AND l_cmd = 'a' THEN
               LET g_glbg_d[l_ac].glbg009 = g_glbg_d[l_ac].glbg006 * g_glbg_d[l_ac].glbg008
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg008
            #add-point:ON CHANGE glbg008 name="input.g.page1.glbg008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glbg_d[l_ac].glbg009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glbg009
            END IF 
 
 
 
            #add-point:AFTER FIELD glbg009 name="input.a.page1.glbg009"
            IF NOT cl_null(g_glbg_d[l_ac].glbg009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg009
            #add-point:BEFORE FIELD glbg009 name="input.b.page1.glbg009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg009
            #add-point:ON CHANGE glbg009 name="input.g.page1.glbg009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg010
            #add-point:BEFORE FIELD glbg010 name="input.b.page1.glbg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg010
            
            #add-point:AFTER FIELD glbg010 name="input.a.page1.glbg010"
            IF NOT cl_null(g_glbg_d[l_ac].glbg010) AND l_cmd = 'a' THEN
               LET g_glbg_d[l_ac].glbg011 = g_glbg_d[l_ac].glbg006 * g_glbg_d[l_ac].glbg010
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg010
            #add-point:ON CHANGE glbg010 name="input.g.page1.glbg010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbg011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glbg_d[l_ac].glbg011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glbg011
            END IF 
 
 
 
            #add-point:AFTER FIELD glbg011 name="input.a.page1.glbg011"
            IF NOT cl_null(g_glbg_d[l_ac].glbg011) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbg011
            #add-point:BEFORE FIELD glbg011 name="input.b.page1.glbg011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbg011
            #add-point:ON CHANGE glbg011 name="input.g.page1.glbg011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbgstus
            #add-point:ON ACTION controlp INFIELD glbgstus name="input.c.page1.glbgstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg004
            #add-point:ON ACTION controlp INFIELD glbg004 name="input.c.page1.glbg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg005
            #add-point:ON ACTION controlp INFIELD glbg005 name="input.c.page1.glbg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg006
            #add-point:ON ACTION controlp INFIELD glbg006 name="input.c.page1.glbg006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg007
            #add-point:ON ACTION controlp INFIELD glbg007 name="input.c.page1.glbg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg008
            #add-point:ON ACTION controlp INFIELD glbg008 name="input.c.page1.glbg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg009
            #add-point:ON ACTION controlp INFIELD glbg009 name="input.c.page1.glbg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg010
            #add-point:ON ACTION controlp INFIELD glbg010 name="input.c.page1.glbg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbg011
            #add-point:ON ACTION controlp INFIELD glbg011 name="input.c.page1.glbg011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glbg_d[l_ac].* = g_glbg_d_t.*
               CLOSE agli230_bcl
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
               LET g_errparam.extend = g_glbg_d[l_ac].glbg004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glbg_d[l_ac].* = g_glbg_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_glbg2_d[l_ac].glbgmodid = g_user 
LET g_glbg2_d[l_ac].glbgmoddt = cl_get_current()
LET g_glbg2_d[l_ac].glbgmodid_desc = cl_get_username(g_glbg2_d[l_ac].glbgmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               CALL s_ld_chk_authorization(g_user,g_glbg_m.glbgld) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = g_glbg_m.glbgld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glbg_d[l_ac].* = g_glbg_d_t.*
                  CLOSE agli230_bcl
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG 
               END IF
               
               IF cl_null(g_glbg_d[l_ac].glbg008) THEN LET g_glbg_d[l_ac].glbg008 = 1 END IF
               IF cl_null(g_glbg_d[l_ac].glbg009) THEN LET g_glbg_d[l_ac].glbg009 = 0 END IF
               IF cl_null(g_glbg_d[l_ac].glbg010) THEN LET g_glbg_d[l_ac].glbg010 = 1 END IF
               IF cl_null(g_glbg_d[l_ac].glbg011) THEN LET g_glbg_d[l_ac].glbg011 = 0 END IF
               #end add-point
         
               #將遮罩欄位還原
               CALL agli230_glbg_t_mask_restore('restore_mask_o')
         
               UPDATE glbg_t SET (glbgld,glbg001,glbg002,glbg003,glbgstus,glbg004,glbg005,glbg006,glbg007, 
                   glbg008,glbg009,glbg010,glbg011,glbgmodid,glbgmoddt,glbgownid,glbgowndp,glbgcrtid, 
                   glbgcrtdp,glbgcrtdt) = (g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003, 
                   g_glbg_d[l_ac].glbgstus,g_glbg_d[l_ac].glbg004,g_glbg_d[l_ac].glbg005,g_glbg_d[l_ac].glbg006, 
                   g_glbg_d[l_ac].glbg007,g_glbg_d[l_ac].glbg008,g_glbg_d[l_ac].glbg009,g_glbg_d[l_ac].glbg010, 
                   g_glbg_d[l_ac].glbg011,g_glbg2_d[l_ac].glbgmodid,g_glbg2_d[l_ac].glbgmoddt,g_glbg2_d[l_ac].glbgownid, 
                   g_glbg2_d[l_ac].glbgowndp,g_glbg2_d[l_ac].glbgcrtid,g_glbg2_d[l_ac].glbgcrtdp,g_glbg2_d[l_ac].glbgcrtdt) 
 
                WHERE glbgent = g_enterprise AND glbgld = g_glbg_m.glbgld 
                 AND glbg001 = g_glbg_m.glbg001 
                 AND glbg002 = g_glbg_m.glbg002 
                 AND glbg003 = g_glbg_m.glbg003 
 
                 AND glbg004 = g_glbg_d_t.glbg004 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glbg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "glbg_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glbg_m.glbgld
               LET gs_keys_bak[1] = g_glbgld_t
               LET gs_keys[2] = g_glbg_m.glbg001
               LET gs_keys_bak[2] = g_glbg001_t
               LET gs_keys[3] = g_glbg_m.glbg002
               LET gs_keys_bak[3] = g_glbg002_t
               LET gs_keys[4] = g_glbg_m.glbg003
               LET gs_keys_bak[4] = g_glbg003_t
               LET gs_keys[5] = g_glbg_d[g_detail_idx].glbg004
               LET gs_keys_bak[5] = g_glbg_d_t.glbg004
               CALL agli230_update_b('glbg_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glbg_m),util.JSON.stringify(g_glbg_d_t)
                     LET g_log2 = util.JSON.stringify(g_glbg_m),util.JSON.stringify(g_glbg_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agli230_glbg_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_glbg_m.glbgld
               LET ls_keys[ls_keys.getLength()+1] = g_glbg_m.glbg001
               LET ls_keys[ls_keys.getLength()+1] = g_glbg_m.glbg002
               LET ls_keys[ls_keys.getLength()+1] = g_glbg_m.glbg003
 
               LET ls_keys[ls_keys.getLength()+1] = g_glbg_d_t.glbg004
 
               CALL agli230_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE agli230_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glbg_d[l_ac].* = g_glbg_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE agli230_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_glbg_d.getLength() = 0 THEN
               NEXT FIELD glbg004
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glbg_d[li_reproduce_target].* = g_glbg_d[li_reproduce].*
               LET g_glbg2_d[li_reproduce_target].* = g_glbg2_d[li_reproduce].*
 
               LET g_glbg_d[li_reproduce_target].glbg004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glbg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glbg_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_glbg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL agli230_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL agli230_idx_chk()
            CALL agli230_ui_detailshow()
        
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
            NEXT FIELD glbgld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glbgstus
               WHEN "s_detail2"
                  NEXT FIELD glbg004_2
 
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
 
{<section id="agli230.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agli230_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL agli230_b_fill(g_wc2) #第一階單身填充
      CALL agli230_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agli230_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_glbg_m.glbgld,g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,g_glbg_m.glbg002, 
       g_glbg_m.glbg003,g_glbg_m.glbg001,g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
 
   CALL agli230_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION agli230_ref_show()
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
   CALL agli230_glbgld_desc(g_glbg_m.glbgld)
   DISPLAY BY NAME g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,
                   g_glbg_m.glaa001,g_glbg_m.glaa016,g_glbg_m.glaa020
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glbg_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      LET g_glbg2_d[l_ac].glbg004 =  g_glbg_d[l_ac].glbg004
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_glbg2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glbg2_d[l_ac].glbgmodid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_glbg2_d[l_ac].glbgmodid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_glbg2_d[l_ac].glbgmodid_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glbg2_d[l_ac].glbgownid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_glbg2_d[l_ac].glbgownid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_glbg2_d[l_ac].glbgownid_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glbg2_d[l_ac].glbgowndp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glbg2_d[l_ac].glbgowndp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_glbg2_d[l_ac].glbgowndp_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glbg2_d[l_ac].glbgcrtid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_glbg2_d[l_ac].glbgcrtid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_glbg2_d[l_ac].glbgcrtid_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glbg2_d[l_ac].glbgcrtdp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glbg2_d[l_ac].glbgcrtdp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_glbg2_d[l_ac].glbgcrtdp_desc
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="agli230.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agli230_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE glbg_t.glbgld 
   DEFINE l_oldno     LIKE glbg_t.glbgld 
   DEFINE l_newno02     LIKE glbg_t.glbg001 
   DEFINE l_oldno02     LIKE glbg_t.glbg001 
   DEFINE l_newno03     LIKE glbg_t.glbg002 
   DEFINE l_oldno03     LIKE glbg_t.glbg002 
   DEFINE l_newno04     LIKE glbg_t.glbg003 
   DEFINE l_oldno04     LIKE glbg_t.glbg003 
 
   DEFINE l_master    RECORD LIKE glbg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glbg_t.* #此變數樣板目前無使用
 
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
 
   IF g_glbg_m.glbgld IS NULL
      OR g_glbg_m.glbg001 IS NULL
      OR g_glbg_m.glbg002 IS NULL
      OR g_glbg_m.glbg003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_glbgld_t = g_glbg_m.glbgld
   LET g_glbg001_t = g_glbg_m.glbg001
   LET g_glbg002_t = g_glbg_m.glbg002
   LET g_glbg003_t = g_glbg_m.glbg003
 
   
   LET g_glbg_m.glbgld = ""
   LET g_glbg_m.glbg001 = ""
   LET g_glbg_m.glbg002 = ""
   LET g_glbg_m.glbg003 = ""
 
   LET g_master_insert = FALSE
   CALL agli230_set_entry('a')
   CALL agli230_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_glbg_m.glbgld_desc = ''
   LET g_glbg_m.glaacomp = ''
   LET g_glbg_m.glaacomp_desc = ''
   LET g_glbg_m.glaa001 = ''
   DISPLAY BY NAME g_glbg_m.glbgld_desc,g_glbg_m.glaacomp,g_glbg_m.glaacomp_desc,g_glbg_m.glaa001
   #end add-point
   
   #清空key欄位的desc
      LET g_glbg_m.glbgld_desc = ''
   DISPLAY BY NAME g_glbg_m.glbgld_desc
 
   
   CALL agli230_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_glbg_m.* TO NULL
      INITIALIZE g_glbg_d TO NULL
      INITIALIZE g_glbg2_d TO NULL
 
      CALL agli230_show()
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
   CALL agli230_set_act_visible()
   CALL agli230_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glbgld_t = g_glbg_m.glbgld
   LET g_glbg001_t = g_glbg_m.glbg001
   LET g_glbg002_t = g_glbg_m.glbg002
   LET g_glbg003_t = g_glbg_m.glbg003
 
   
   #組合新增資料的條件
   LET g_add_browse = " glbgent = " ||g_enterprise|| " AND",
                      " glbgld = '", g_glbg_m.glbgld, "' "
                      ," AND glbg001 = '", g_glbg_m.glbg001, "' "
                      ," AND glbg002 = '", g_glbg_m.glbg002, "' "
                      ," AND glbg003 = '", g_glbg_m.glbg003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agli230_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL agli230_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL agli230_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agli230_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glbg_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agli230_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glbg_t
    WHERE glbgent = g_enterprise AND glbgld = g_glbgld_t
    AND glbg001 = g_glbg001_t
    AND glbg002 = g_glbg002_t
    AND glbg003 = g_glbg003_t
 
       INTO TEMP agli230_detail
   
   #將key修正為調整後   
   UPDATE agli230_detail 
      #更新key欄位
      SET glbgld = g_glbg_m.glbgld
          , glbg001 = g_glbg_m.glbg001
          , glbg002 = g_glbg_m.glbg002
          , glbg003 = g_glbg_m.glbg003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , glbgownid = g_user 
       , glbgowndp = g_dept
       , glbgcrtid = g_user
       , glbgcrtdp = g_dept 
       , glbgcrtdt = ld_date
       , glbgmodid = g_user
       , glbgmoddt = ld_date
      #, glbgstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO glbg_t SELECT * FROM agli230_detail
   
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
   DROP TABLE agli230_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glbgld_t = g_glbg_m.glbgld
   LET g_glbg001_t = g_glbg_m.glbg001
   LET g_glbg002_t = g_glbg_m.glbg002
   LET g_glbg003_t = g_glbg_m.glbg003
 
   
   DROP TABLE agli230_detail
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agli230_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_pass      LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   #160811-00039#6--add--str--
   IF g_glbg_m.glbgld IS NULL
   OR g_glbg_m.glbg001 IS NULL
   OR g_glbg_m.glbg002 IS NULL
   OR g_glbg_m.glbg003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_ld_chk_authorization(g_user,g_glbg_m.glbgld ) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glbg_m.glbgld
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN
   END IF
   #160811-00039#6--add--end
   #end add-point
   
   IF g_glbg_m.glbgld IS NULL
   OR g_glbg_m.glbg001 IS NULL
   OR g_glbg_m.glbg002 IS NULL
   OR g_glbg_m.glbg003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN agli230_cl USING g_enterprise,g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli230_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE agli230_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agli230_master_referesh USING g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003 INTO g_glbg_m.glbgld, 
       g_glbg_m.glbg002,g_glbg_m.glbg003,g_glbg_m.glbg001
   
   #遮罩相關處理
   LET g_glbg_m_mask_o.* =  g_glbg_m.*
   CALL agli230_glbg_t_mask()
   LET g_glbg_m_mask_n.* =  g_glbg_m.*
   
   CALL agli230_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agli230_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
#160811-00039#6--mark--str--
#      CALL s_ld_chk_authorization(g_user,g_glbg_m.glbgld) RETURNING l_pass
#      IF l_pass = FALSE THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'agl-00164'
#         LET g_errparam.extend = g_glbgld
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         RETURN               
#      END IF
#160811-00039#6--mark--end
      #end add-point
      
      DELETE FROM glbg_t WHERE glbgent = g_enterprise AND glbgld = g_glbg_m.glbgld
                                                               AND glbg001 = g_glbg_m.glbg001
                                                               AND glbg002 = g_glbg_m.glbg002
                                                               AND glbg003 = g_glbg_m.glbg003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glbg_t:",SQLERRMESSAGE 
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
      #   CLOSE agli230_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_glbg_d.clear() 
      CALL g_glbg2_d.clear()       
 
     
      CALL agli230_ui_browser_refresh()  
      #CALL agli230_ui_headershow()  
      #CALL agli230_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL agli230_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL agli230_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE agli230_cl
 
   #功能已完成,通報訊息中心
   CALL agli230_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agli230.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agli230_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_glbg_d.clear()
   CALL g_glbg2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT glbgstus,glbg004,glbg005,glbg006,glbg007,glbg008,glbg009,glbg010,glbg011, 
       glbg004,glbgmodid,glbgmoddt,glbgownid,glbgowndp,glbgcrtid,glbgcrtdp,glbgcrtdt,t1.ooag011 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 FROM glbg_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=glbgmodid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=glbgownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=glbgowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=glbgcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=glbgcrtdp AND t5.ooefl002='"||g_dlang||"' ",
 
               " WHERE glbgent= ? AND glbgld=? AND glbg001=? AND glbg002=? AND glbg003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("glbg_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF agli230_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY glbg_t.glbg004"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agli230_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agli230_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glbg_m.glbgld,g_glbg_m.glbg001,g_glbg_m.glbg002,g_glbg_m.glbg003 INTO g_glbg_d[l_ac].glbgstus, 
          g_glbg_d[l_ac].glbg004,g_glbg_d[l_ac].glbg005,g_glbg_d[l_ac].glbg006,g_glbg_d[l_ac].glbg007, 
          g_glbg_d[l_ac].glbg008,g_glbg_d[l_ac].glbg009,g_glbg_d[l_ac].glbg010,g_glbg_d[l_ac].glbg011, 
          g_glbg2_d[l_ac].glbg004,g_glbg2_d[l_ac].glbgmodid,g_glbg2_d[l_ac].glbgmoddt,g_glbg2_d[l_ac].glbgownid, 
          g_glbg2_d[l_ac].glbgowndp,g_glbg2_d[l_ac].glbgcrtid,g_glbg2_d[l_ac].glbgcrtdp,g_glbg2_d[l_ac].glbgcrtdt, 
          g_glbg2_d[l_ac].glbgmodid_desc,g_glbg2_d[l_ac].glbgownid_desc,g_glbg2_d[l_ac].glbgowndp_desc, 
          g_glbg2_d[l_ac].glbgcrtid_desc,g_glbg2_d[l_ac].glbgcrtdp_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_glbg2_d[l_ac].glbg004 =  g_glbg_d[l_ac].glbg004
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
 
            CALL g_glbg_d.deleteElement(g_glbg_d.getLength())
      CALL g_glbg2_d.deleteElement(g_glbg2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glbg_d.getLength()
      LET g_glbg_d_mask_o[l_ac].* =  g_glbg_d[l_ac].*
      CALL agli230_glbg_t_mask()
      LET g_glbg_d_mask_n[l_ac].* =  g_glbg_d[l_ac].*
   END FOR
   
   LET g_glbg2_d_mask_o.* =  g_glbg2_d.*
   FOR l_ac = 1 TO g_glbg2_d.getLength()
      LET g_glbg2_d_mask_o[l_ac].* =  g_glbg2_d[l_ac].*
      CALL agli230_glbg_t_mask()
      LET g_glbg2_d_mask_n[l_ac].* =  g_glbg2_d[l_ac].*
   END FOR
 
 
   FREE agli230_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agli230_idx_chk()
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
      IF g_detail_idx > g_glbg_d.getLength() THEN
         LET g_detail_idx = g_glbg_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_glbg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glbg_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_glbg2_d.getLength() THEN
         LET g_detail_idx = g_glbg2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glbg2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glbg2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agli230_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_glbg_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION agli230_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM glbg_t
    WHERE glbgent = g_enterprise AND glbgld = g_glbg_m.glbgld AND
                              glbg001 = g_glbg_m.glbg001 AND
                              glbg002 = g_glbg_m.glbg002 AND
                              glbg003 = g_glbg_m.glbg003 AND
 
          glbg004 = g_glbg_d_t.glbg004
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glbg_t:",SQLERRMESSAGE 
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
 
{<section id="agli230.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agli230_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="agli230.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agli230_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="agli230.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agli230_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="agli230.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION agli230_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_glbg_d[l_ac].glbg004 = g_glbg_d_t.glbg004 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agli230_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="agli230.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agli230_lock_b(ps_table,ps_page)
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
   #CALL agli230_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agli230.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agli230_unlock_b(ps_table,ps_page)
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
 
{<section id="agli230.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agli230_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glbgld,glbg001,glbg002,glbg003",TRUE)
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
 
{<section id="agli230.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agli230_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glbgld,glbg001,glbg002,glbg003",FALSE)
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
 
{<section id="agli230.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agli230_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agli230_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agli230_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli230.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agli230_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli230.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agli230_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli230.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agli230_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agli230.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agli230_default_search()
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
      LET ls_wc = ls_wc, " glbgld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glbg001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glbg002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " glbg003 = '", g_argv[04], "' AND "
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
 
{<section id="agli230.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agli230_fill_chk(ps_idx)
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
 
{<section id="agli230.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION agli230_modify_detail_chk(ps_record)
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
         LET ls_return = "glbgstus"
      WHEN "s_detail2"
         LET ls_return = "glbg004_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="agli230.mask_functions" >}
&include "erp/agl/agli230_mask.4gl"
 
{</section>}
 
{<section id="agli230.state_change" >}
    
 
{</section>}
 
{<section id="agli230.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agli230_set_pk_array()
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
   LET g_pk_array[1].values = g_glbg_m.glbgld
   LET g_pk_array[1].column = 'glbgld'
   LET g_pk_array[2].values = g_glbg_m.glbg001
   LET g_pk_array[2].column = 'glbg001'
   LET g_pk_array[3].values = g_glbg_m.glbg002
   LET g_pk_array[3].column = 'glbg002'
   LET g_pk_array[4].values = g_glbg_m.glbg003
   LET g_pk_array[4].column = 'glbg003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli230.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agli230_msgcentre_notify(lc_state)
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
   CALL agli230_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glbg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli230.other_function" readonly="Y" >}
#帐别检查
PRIVATE FUNCTION agli230_glbgld_chk(p_glbgld)
   DEFINE p_glbgld    LIKE glbg_t.glbgld 
   DEFINE l_glaastus  LIKE glaa_t.glaastus

   LET g_errno = ''
   SELECT glaastus INTO l_glaastus FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glbgld
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
      WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302' #'agl-00051' #160318-00005#15 mod 
   END CASE
END FUNCTION
#帐别说明
PRIVATE FUNCTION agli230_glbgld_desc(p_glbgld)
    DEFINE p_glbgld      LIKE glbg_t.glbgld
  
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glbgld
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glbg_m.glbgld_desc= g_rtn_fields[1]
    
    LET g_glbg_m.glaacomp = ''
    LET g_glbg_m.glaacomp_desc = ''
    LET g_glbg_m.glaa001 = ''   
    LET g_glbg_m.glaa016 = ''
    LET g_glbg_m.glaa020 = ''    
   #依据对应的主账套编码，抓取对应法人，币别,会计周期参照表号，会计科目参照编号,启用本位币二，启用本位币三
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa015,glaa016,
          glaa017,glaa018,glaa019,glaa020,glaa021,glaa022
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa015,g_glaa016,
          g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glbgld 
      
    LET g_glbg_m.glaacomp = g_glaacomp
    LET g_glbg_m.glaa001 = g_glaa001 
    LET g_glbg_m.glaa016 = g_glaa016
    LET g_glbg_m.glaa020 = g_glaa020
    
    IF g_glaa015 = 'Y' THEN
       CALL cl_set_comp_visible("glaa016,glbg008,glbg009",TRUE)
    ELSE
       CALL cl_set_comp_visible("glaa016,glbg008,glbg009",FALSE)
    END IF 
    
    IF g_glaa019 = 'Y' THEN
       CALL cl_set_comp_visible("glaa020,glbg010,glbg011",TRUE)
    ELSE
       CALL cl_set_comp_visible("glaa020,glbg010,glbg011",FALSE)
    END IF    
    #归属法人    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_glbg_m.glaacomp
    CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glbg_m.glaacomp_desc =  g_rtn_fields[1]
END FUNCTION

 
{</section>}
 
