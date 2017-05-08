#該程式未解開Section, 採用最新樣板產出!
{<section id="aisi050.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-12-13 16:43:12), PR版次:0015(2017-01-11 16:41:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000536
#+ Filename...: aisi050
#+ Description: 發票簿維護作業
#+ Creator....: 02114(2013-10-11 17:23:58)
#+ Modifier...: 00222 -SD/PR- 06821
 
{</section>}
 
{<section id="aisi050.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160125-00005#1  2016/07/27 By Hans     aisi050/aisi055 若有效日期區期有重疊不可有相同的發票簿號
#160413-00032#1  2016/04/25 By Reanna   修正发票类型开窗不会显示24红字发票，但是手动输入提交ok的問題
#160318-00025#44 2016/04/19 by 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161006-00005#15 2016/10/17 By 08732    組織類型與職能開窗調整
#161026-00024#1  2016/10/26 By albireo  修改隱藏欄位isae016~isae018的數值
#161101-00038#1  2016/11/01 By Reanna   生效日期檢核調整
#161101-00068#1  2016/11/01 By Reanna   調整#161101-00038#1此單修改內容
#161005-00003#3  2016/11/02 By 08171    新舊值調整
#161127-00001#1  2016/12/01 By 08732    發票類型開窗檢核調整(相同於aist310的發票類型欄位)
#161212-00040#1  2016/12/13 By 00222    isae008 調整規格預設值為空白，原本為1
#170111-00027#1  2017/01/11 By 06821    發票已開張數不依前端回寫,直接由下次列印號碼-起始發票號碼
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
PRIVATE type type_g_isae_m        RECORD
       isaesite LIKE isae_t.isaesite, 
   isaesite_desc LIKE type_t.chr80, 
   isac001 LIKE type_t.chr10, 
   ooall004 LIKE type_t.chr80, 
   isaecomp LIKE isae_t.isaecomp, 
   isaecomp_desc LIKE type_t.chr80, 
   isae019 LIKE isae_t.isae019
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_isae_d        RECORD
       isae001 LIKE isae_t.isae001, 
   isae002 LIKE isae_t.isae002, 
   isae003 LIKE isae_t.isae003, 
   isae004 LIKE isae_t.isae004, 
   isae004_desc LIKE type_t.chr500, 
   isae005 LIKE isae_t.isae005, 
   isae006 LIKE isae_t.isae006, 
   isae008 LIKE isae_t.isae008, 
   isae009 LIKE isae_t.isae009, 
   isae010 LIKE isae_t.isae010, 
   isae011 LIKE isae_t.isae011, 
   isae020 LIKE isae_t.isae020, 
   isae012 LIKE isae_t.isae012, 
   isae013 LIKE isae_t.isae013, 
   isae014 LIKE isae_t.isae014, 
   isae015 LIKE isae_t.isae015, 
   isaestus LIKE isae_t.isaestus, 
   isae016 LIKE isae_t.isae016, 
   isae017 LIKE isae_t.isae017, 
   isae018 LIKE isae_t.isae018
       END RECORD
PRIVATE TYPE type_g_isae2_d RECORD
       isae004 LIKE isae_t.isae004, 
   isaemodid LIKE isae_t.isaemodid, 
   isaemodid_desc LIKE type_t.chr500, 
   isaemoddt DATETIME YEAR TO SECOND, 
   isaeownid LIKE isae_t.isaeownid, 
   isaeownid_desc LIKE type_t.chr500, 
   isaeowndp LIKE isae_t.isaeowndp, 
   isaeowndp_desc LIKE type_t.chr500, 
   isaecrtid LIKE isae_t.isaecrtid, 
   isaecrtid_desc LIKE type_t.chr500, 
   isaecrtdp LIKE isae_t.isaecrtdp, 
   isaecrtdp_desc LIKE type_t.chr500, 
   isaecrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_isai002             LIKE isai_t.isai002
DEFINE g_success1            BOOLEAN 
DEFINE g_wc_isaesite         STRING   #161006-00005#15   add
#161127-00001#1   add---s
DEFINE g_isac003            LIKE isac_t.isac003  #發票歸屬進銷項
DEFINE g_isai006            LIKE isai_t.isai006  #紅字發票與藍字發票共用否
#161127-00001#1   add---e
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_isae_m          type_g_isae_m
DEFINE g_isae_m_t        type_g_isae_m
DEFINE g_isae_m_o        type_g_isae_m
DEFINE g_isae_m_mask_o   type_g_isae_m #轉換遮罩前資料
DEFINE g_isae_m_mask_n   type_g_isae_m #轉換遮罩後資料
 
   DEFINE g_isaesite_t LIKE isae_t.isaesite
DEFINE g_isaecomp_t LIKE isae_t.isaecomp
 
 
DEFINE g_isae_d          DYNAMIC ARRAY OF type_g_isae_d
DEFINE g_isae_d_t        type_g_isae_d
DEFINE g_isae_d_o        type_g_isae_d
DEFINE g_isae_d_mask_o   DYNAMIC ARRAY OF type_g_isae_d #轉換遮罩前資料
DEFINE g_isae_d_mask_n   DYNAMIC ARRAY OF type_g_isae_d #轉換遮罩後資料
DEFINE g_isae2_d   DYNAMIC ARRAY OF type_g_isae2_d
DEFINE g_isae2_d_t type_g_isae2_d
DEFINE g_isae2_d_o type_g_isae2_d
DEFINE g_isae2_d_mask_o   DYNAMIC ARRAY OF type_g_isae2_d #轉換遮罩前資料
DEFINE g_isae2_d_mask_n   DYNAMIC ARRAY OF type_g_isae2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_isaecomp LIKE isae_t.isaecomp,
      b_isaesite LIKE isae_t.isaesite
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
 
{<section id="aisi050.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
   #161006-00005#15--add--s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(today)
   CALL s_fin_account_center_sons_str() RETURNING g_wc_isaesite  #組織查詢時開窗
   CALL s_fin_get_wc_str(g_wc_isaesite) RETURNING g_wc_isaesite  
   #161006-00005#15--add--e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT isaesite,'','','',isaecomp,'',isae019", 
                      " FROM isae_t",
                      " WHERE isaeent= ? AND isaecomp=? AND isaesite=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisi050_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.isaesite,t0.isaecomp,t0.isae019,t1.ooefl003 ,t2.ooefl003",
               " FROM isae_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.isaesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.isaecomp AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.isaeent = " ||g_enterprise|| " AND t0.isaecomp = ? AND t0.isaesite = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   LET g_sql = g_sql ," AND isae019 = '",g_prog,"' "
   #end add-point
   PREPARE aisi050_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisi050 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisi050_init()   
 
      #進入選單 Menu (="N")
      CALL aisi050_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisi050
      
   END IF 
   
   CLOSE aisi050_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisi050.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aisi050_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('isaestus','13','N,Y,X')
 
      CALL cl_set_combo_scc('isae006','9713') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL aisi050_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aisi050.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aisi050_ui_dialog()
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
         INITIALIZE g_isae_m.* TO NULL
         CALL g_isae_d.clear()
         CALL g_isae2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aisi050_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_isae_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aisi050_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aisi050_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_isae2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aisi050_idx_chk()
               CALL aisi050_ui_detailshow()
               
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
            CALL aisi050_browser_fill("")
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
               CALL aisi050_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aisi050_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aisi050_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aisi050_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aisi050_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aisi050_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aisi050_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aisi050_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aisi050_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aisi050_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aisi050_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aisi050_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_isae_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_isae2_d)
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
               NEXT FIELD isae001
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
               CALL aisi050_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aisi050_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aisi050_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aisi050_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aisi050_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aisi050_01
            LET g_action_choice="aisi050_01"
            IF cl_auth_chk_act("aisi050_01") THEN
               
               #add-point:ON ACTION aisi050_01 name="menu.aisi050_01"
               CALL aisi050_01(1)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aisi050_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aisi050_insert()
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
               CALL aisi050_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aisi050_02
            LET g_action_choice="aisi050_02"
            IF cl_auth_chk_act("aisi050_02") THEN
               
               #add-point:ON ACTION aisi050_02 name="menu.aisi050_02"
               CALL aisi050_02(1)
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aisi050_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aisi050_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aisi050_set_pk_array()
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
 
{<section id="aisi050.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aisi050_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aisi050.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aisi050_browser_fill(ps_page_action)
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
   LET g_wc = g_wc CLIPPED , " AND isae019 = '",g_prog,"' "
   #end add-point    
 
   LET l_searchcol = "isaecomp,isaesite"
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
      LET l_sub_sql = " SELECT DISTINCT isaecomp ",
                      ", isaesite ",
 
                      " FROM isae_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE isaeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("isae_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT isaecomp ",
                      ", isaesite ",
 
                      " FROM isae_t ",
                      " ",
                      " ", 
 
 
                      " WHERE isaeent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("isae_t")
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
      INITIALIZE g_isae_m.* TO NULL
      CALL g_isae_d.clear()        
      CALL g_isae2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.isaecomp,t0.isaesite Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.isaecomp,t0.isaesite",
                " FROM isae_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.isaeent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("isae_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"isae_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_isaecomp,g_browser[g_cnt].b_isaesite 
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
   
   IF cl_null(g_browser[g_cnt].b_isaecomp) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_isae_m.* TO NULL
      CALL g_isae_d.clear()
      CALL g_isae2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aisi050_fetch('')
   
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
 
{<section id="aisi050.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aisi050_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_isae_m.isaecomp = g_browser[g_current_idx].b_isaecomp   
   LET g_isae_m.isaesite = g_browser[g_current_idx].b_isaesite   
 
   EXECUTE aisi050_master_referesh USING g_isae_m.isaecomp,g_isae_m.isaesite INTO g_isae_m.isaesite, 
       g_isae_m.isaecomp,g_isae_m.isae019,g_isae_m.isaesite_desc,g_isae_m.isaecomp_desc
   CALL aisi050_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aisi050_ui_detailshow()
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
 
{<section id="aisi050.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aisi050_ui_browser_refresh()
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
      IF g_browser[l_i].b_isaecomp = g_isae_m.isaecomp 
         AND g_browser[l_i].b_isaesite = g_isae_m.isaesite 
 
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
 
{<section id="aisi050.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisi050_construct()
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
   INITIALIZE g_isae_m.* TO NULL
   CALL g_isae_d.clear()
   CALL g_isae2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON isaesite,isaecomp
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.isaesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaesite
            #add-point:ON ACTION controlp INFIELD isaesite name="construct.c.isaesite"
           CALL aisi050_user_chk() RETURNING g_isae_m.isaecomp       
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
		     LET g_qryparam.reqry = FALSE
		     LET g_qryparam.where = "  ooef201 =  'Y' AND ooef001 IN",g_wc_isaesite   #161006-00005#15 add	
		                            #" ooef017 = '",g_isae_m.isaecomp,"' "    #161006-00005#15   mark
           CALL q_ooef001()
           DISPLAY g_qryparam.return1 TO isaesite      #顯示到畫面上
           NEXT FIELD isaesite                         #返回原欄位



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaesite
            #add-point:BEFORE FIELD isaesite name="construct.b.isaesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaesite
            
            #add-point:AFTER FIELD isaesite name="construct.a.isaesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaecomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaecomp
            #add-point:ON ACTION controlp INFIELD isaecomp name="construct.c.isaecomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where ="isaecomp ='",g_isae_m.isaecomp,"' " 
            CALL q_isaecomp()                                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaecomp                      #顯示到畫面上
            NEXT FIELD isaecomp                                         #返回原欄位
                                                                       


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaecomp
            #add-point:BEFORE FIELD isaecomp name="construct.b.isaecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaecomp
            
            #add-point:AFTER FIELD isaecomp name="construct.a.isaecomp"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON isae001,isae002,isae003,isae004,isae004_desc,isae005,isae006,isae008, 
          isae009,isae010,isae011,isae020,isae012,isae013,isae014,isae015,isaestus,isae016,isae017,isae018, 
          isaemodid,isaemoddt,isaeownid,isaeowndp,isaecrtid,isaecrtdp,isaecrtdt
           FROM s_detail1[1].isae001,s_detail1[1].isae002,s_detail1[1].isae003,s_detail1[1].isae004, 
               s_detail1[1].isae004_desc,s_detail1[1].isae005,s_detail1[1].isae006,s_detail1[1].isae008, 
               s_detail1[1].isae009,s_detail1[1].isae010,s_detail1[1].isae011,s_detail1[1].isae020,s_detail1[1].isae012, 
               s_detail1[1].isae013,s_detail1[1].isae014,s_detail1[1].isae015,s_detail1[1].isaestus, 
               s_detail1[1].isae016,s_detail1[1].isae017,s_detail1[1].isae018,s_detail2[1].isaemodid, 
               s_detail2[1].isaemoddt,s_detail2[1].isaeownid,s_detail2[1].isaeowndp,s_detail2[1].isaecrtid, 
               s_detail2[1].isaecrtdp,s_detail2[1].isaecrtdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<isaecrtdt>>----
         AFTER FIELD isaecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<isaemoddt>>----
         AFTER FIELD isaemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isaecnfdt>>----
         
         #----<<isaepstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae001
            #add-point:BEFORE FIELD isae001 name="construct.b.page1.isae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae001
            
            #add-point:AFTER FIELD isae001 name="construct.a.page1.isae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae001
            #add-point:ON ACTION controlp INFIELD isae001 name="construct.c.page1.isae001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae002
            #add-point:BEFORE FIELD isae002 name="construct.b.page1.isae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae002
            
            #add-point:AFTER FIELD isae002 name="construct.a.page1.isae002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae002
            #add-point:ON ACTION controlp INFIELD isae002 name="construct.c.page1.isae002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae003
            #add-point:BEFORE FIELD isae003 name="construct.b.page1.isae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae003
            
            #add-point:AFTER FIELD isae003 name="construct.a.page1.isae003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae003
            #add-point:ON ACTION controlp INFIELD isae003 name="construct.c.page1.isae003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.isae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae004
            #add-point:ON ACTION controlp INFIELD isae004 name="construct.c.page1.isae004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isae004  #顯示到畫面上
            NEXT FIELD isae004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae004
            #add-point:BEFORE FIELD isae004 name="construct.b.page1.isae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae004
            
            #add-point:AFTER FIELD isae004 name="construct.a.page1.isae004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae004_desc
            #add-point:BEFORE FIELD isae004_desc name="construct.b.page1.isae004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae004_desc
            
            #add-point:AFTER FIELD isae004_desc name="construct.a.page1.isae004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae004_desc
            #add-point:ON ACTION controlp INFIELD isae004_desc name="construct.c.page1.isae004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae005
            #add-point:BEFORE FIELD isae005 name="construct.b.page1.isae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae005
            
            #add-point:AFTER FIELD isae005 name="construct.a.page1.isae005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae005
            #add-point:ON ACTION controlp INFIELD isae005 name="construct.c.page1.isae005"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae006
            #add-point:BEFORE FIELD isae006 name="construct.b.page1.isae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae006
            
            #add-point:AFTER FIELD isae006 name="construct.a.page1.isae006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae006
            #add-point:ON ACTION controlp INFIELD isae006 name="construct.c.page1.isae006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae008
            #add-point:BEFORE FIELD isae008 name="construct.b.page1.isae008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae008
            
            #add-point:AFTER FIELD isae008 name="construct.a.page1.isae008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae008
            #add-point:ON ACTION controlp INFIELD isae008 name="construct.c.page1.isae008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae009
            #add-point:BEFORE FIELD isae009 name="construct.b.page1.isae009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae009
            
            #add-point:AFTER FIELD isae009 name="construct.a.page1.isae009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae009
            #add-point:ON ACTION controlp INFIELD isae009 name="construct.c.page1.isae009"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae010
            #add-point:BEFORE FIELD isae010 name="construct.b.page1.isae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae010
            
            #add-point:AFTER FIELD isae010 name="construct.a.page1.isae010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae010
            #add-point:ON ACTION controlp INFIELD isae010 name="construct.c.page1.isae010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae011
            #add-point:BEFORE FIELD isae011 name="construct.b.page1.isae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae011
            
            #add-point:AFTER FIELD isae011 name="construct.a.page1.isae011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae011
            #add-point:ON ACTION controlp INFIELD isae011 name="construct.c.page1.isae011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae020
            #add-point:BEFORE FIELD isae020 name="construct.b.page1.isae020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae020
            
            #add-point:AFTER FIELD isae020 name="construct.a.page1.isae020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae020
            #add-point:ON ACTION controlp INFIELD isae020 name="construct.c.page1.isae020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae012
            #add-point:BEFORE FIELD isae012 name="construct.b.page1.isae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae012
            
            #add-point:AFTER FIELD isae012 name="construct.a.page1.isae012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae012
            #add-point:ON ACTION controlp INFIELD isae012 name="construct.c.page1.isae012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae013
            #add-point:BEFORE FIELD isae013 name="construct.b.page1.isae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae013
            
            #add-point:AFTER FIELD isae013 name="construct.a.page1.isae013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae013
            #add-point:ON ACTION controlp INFIELD isae013 name="construct.c.page1.isae013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae014
            #add-point:BEFORE FIELD isae014 name="construct.b.page1.isae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae014
            
            #add-point:AFTER FIELD isae014 name="construct.a.page1.isae014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae014
            #add-point:ON ACTION controlp INFIELD isae014 name="construct.c.page1.isae014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae015
            #add-point:BEFORE FIELD isae015 name="construct.b.page1.isae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae015
            
            #add-point:AFTER FIELD isae015 name="construct.a.page1.isae015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae015
            #add-point:ON ACTION controlp INFIELD isae015 name="construct.c.page1.isae015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaestus
            #add-point:BEFORE FIELD isaestus name="construct.b.page1.isaestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaestus
            
            #add-point:AFTER FIELD isaestus name="construct.a.page1.isaestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isaestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaestus
            #add-point:ON ACTION controlp INFIELD isaestus name="construct.c.page1.isaestus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae016
            #add-point:BEFORE FIELD isae016 name="construct.b.page1.isae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae016
            
            #add-point:AFTER FIELD isae016 name="construct.a.page1.isae016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae016
            #add-point:ON ACTION controlp INFIELD isae016 name="construct.c.page1.isae016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae017
            #add-point:BEFORE FIELD isae017 name="construct.b.page1.isae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae017
            
            #add-point:AFTER FIELD isae017 name="construct.a.page1.isae017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.isae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae017
            #add-point:ON ACTION controlp INFIELD isae017 name="construct.c.page1.isae017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.isae018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae018
            #add-point:ON ACTION controlp INFIELD isae018 name="construct.c.page1.isae018"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isae018  #顯示到畫面上

            NEXT FIELD isae018                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae018
            #add-point:BEFORE FIELD isae018 name="construct.b.page1.isae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae018
            
            #add-point:AFTER FIELD isae018 name="construct.a.page1.isae018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isaemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaemodid
            #add-point:ON ACTION controlp INFIELD isaemodid name="construct.c.page2.isaemodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaemodid  #顯示到畫面上

            NEXT FIELD isaemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaemodid
            #add-point:BEFORE FIELD isaemodid name="construct.b.page2.isaemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaemodid
            
            #add-point:AFTER FIELD isaemodid name="construct.a.page2.isaemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaemoddt
            #add-point:BEFORE FIELD isaemoddt name="construct.b.page2.isaemoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.isaeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaeownid
            #add-point:ON ACTION controlp INFIELD isaeownid name="construct.c.page2.isaeownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaeownid  #顯示到畫面上

            NEXT FIELD isaeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaeownid
            #add-point:BEFORE FIELD isaeownid name="construct.b.page2.isaeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaeownid
            
            #add-point:AFTER FIELD isaeownid name="construct.a.page2.isaeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isaeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaeowndp
            #add-point:ON ACTION controlp INFIELD isaeowndp name="construct.c.page2.isaeowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaeowndp  #顯示到畫面上

            NEXT FIELD isaeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaeowndp
            #add-point:BEFORE FIELD isaeowndp name="construct.b.page2.isaeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaeowndp
            
            #add-point:AFTER FIELD isaeowndp name="construct.a.page2.isaeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isaecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaecrtid
            #add-point:ON ACTION controlp INFIELD isaecrtid name="construct.c.page2.isaecrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaecrtid  #顯示到畫面上

            NEXT FIELD isaecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaecrtid
            #add-point:BEFORE FIELD isaecrtid name="construct.b.page2.isaecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaecrtid
            
            #add-point:AFTER FIELD isaecrtid name="construct.a.page2.isaecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isaecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaecrtdp
            #add-point:ON ACTION controlp INFIELD isaecrtdp name="construct.c.page2.isaecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaecrtdp  #顯示到畫面上

            NEXT FIELD isaecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaecrtdp
            #add-point:BEFORE FIELD isaecrtdp name="construct.b.page2.isaecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaecrtdp
            
            #add-point:AFTER FIELD isaecrtdp name="construct.a.page2.isaecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaecrtdt
            #add-point:BEFORE FIELD isaecrtdt name="construct.b.page2.isaecrtdt"
            
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
   LET g_wc = g_wc CLIPPED , " AND isae019 = '",g_prog,"' "
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
 
{<section id="aisi050.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aisi050_query()
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
   CALL g_isae_d.clear()
   CALL g_isae2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aisi050_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aisi050_browser_fill(g_wc)
      CALL aisi050_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aisi050_browser_fill("F")
   
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
      CALL aisi050_fetch("F") 
   END IF
   
   CALL aisi050_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aisi050_fetch(p_flag)
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
   
   #CALL aisi050_browser_fill(p_flag)
   
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
   
   LET g_isae_m.isaecomp = g_browser[g_current_idx].b_isaecomp
   LET g_isae_m.isaesite = g_browser[g_current_idx].b_isaesite
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aisi050_master_referesh USING g_isae_m.isaecomp,g_isae_m.isaesite INTO g_isae_m.isaesite, 
       g_isae_m.isaecomp,g_isae_m.isae019,g_isae_m.isaesite_desc,g_isae_m.isaecomp_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "isae_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_isae_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_isae_m_mask_o.* =  g_isae_m.*
   CALL aisi050_isae_t_mask()
   LET g_isae_m_mask_n.* =  g_isae_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aisi050_set_act_visible()
   CALL aisi050_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_isae_m_t.* = g_isae_m.*
   LET g_isae_m_o.* = g_isae_m.*
   
   #重新顯示   
   CALL aisi050_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aisi050.insert" >}
#+ 資料新增
PRIVATE FUNCTION aisi050_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_isae_d.clear()
   CALL g_isae2_d.clear()
 
 
   INITIALIZE g_isae_m.* TO NULL             #DEFAULT 設定
   LET g_isaecomp_t = NULL
   LET g_isaesite_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      #161026-00024 mark-----s
      #LET g_isae_m.isae016 = '2014'      
      #LET g_isae_m.isae017 = '11'
      #LET g_isae_m.isae018 = '12'
      #161026-00024 mark-----e
      LET g_isae_m_t.* = g_isae_m.*
      CALL aisi050_isai006_info()   #161127-00001#1   add
      #end add-point 
 
      CALL aisi050_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_isae_m.* TO NULL
         INITIALIZE g_isae_d TO NULL
         INITIALIZE g_isae2_d TO NULL
 
         CALL aisi050_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_isae_m.* = g_isae_m_t.*
         CALL aisi050_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_isae_d.clear()
      #CALL g_isae2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aisi050_set_act_visible()
   CALL aisi050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_isaecomp_t = g_isae_m.isaecomp
   LET g_isaesite_t = g_isae_m.isaesite
 
   
   #組合新增資料的條件
   LET g_add_browse = " isaeent = " ||g_enterprise|| " AND",
                      " isaecomp = '", g_isae_m.isaecomp, "' "
                      ," AND isaesite = '", g_isae_m.isaesite, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aisi050_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aisi050_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aisi050_master_referesh USING g_isae_m.isaecomp,g_isae_m.isaesite INTO g_isae_m.isaesite, 
       g_isae_m.isaecomp,g_isae_m.isae019,g_isae_m.isaesite_desc,g_isae_m.isaecomp_desc
   
   #遮罩相關處理
   LET g_isae_m_mask_o.* =  g_isae_m.*
   CALL aisi050_isae_t_mask()
   LET g_isae_m_mask_n.* =  g_isae_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_isae_m.isaesite,g_isae_m.isaesite_desc,g_isae_m.isac001,g_isae_m.ooall004,g_isae_m.isaecomp, 
       g_isae_m.isaecomp_desc,g_isae_m.isae019
   
   #功能已完成,通報訊息中心
   CALL aisi050_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.modify" >}
#+ 資料修改
PRIVATE FUNCTION aisi050_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_isae_m.isaecomp IS NULL
   OR g_isae_m.isaesite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_isaecomp_t = g_isae_m.isaecomp
   LET g_isaesite_t = g_isae_m.isaesite
 
   CALL s_transaction_begin()
   
   OPEN aisi050_cl USING g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aisi050_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aisi050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aisi050_master_referesh USING g_isae_m.isaecomp,g_isae_m.isaesite INTO g_isae_m.isaesite, 
       g_isae_m.isaecomp,g_isae_m.isae019,g_isae_m.isaesite_desc,g_isae_m.isaecomp_desc
   
   #遮罩相關處理
   LET g_isae_m_mask_o.* =  g_isae_m.*
   CALL aisi050_isae_t_mask()
   LET g_isae_m_mask_n.* =  g_isae_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aisi050_show()
   WHILE TRUE
      LET g_isaecomp_t = g_isae_m.isaecomp
      LET g_isaesite_t = g_isae_m.isaesite
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aisi050_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_isae_m.* = g_isae_m_t.*
         CALL aisi050_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_isae_m.isaecomp != g_isaecomp_t 
      OR g_isae_m.isaesite != g_isaesite_t 
 
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
   CALL aisi050_set_act_visible()
   CALL aisi050_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " isaeent = " ||g_enterprise|| " AND",
                      " isaecomp = '", g_isae_m.isaecomp, "' "
                      ," AND isaesite = '", g_isae_m.isaesite, "' "
 
   #填到對應位置
   CALL aisi050_browser_fill("")
 
   CALL aisi050_idx_chk()
 
   CLOSE aisi050_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aisi050_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aisi050.input" >}
#+ 資料輸入
PRIVATE FUNCTION aisi050_input(p_cmd)
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
   DEFINE l_isae009        STRING
   DEFINE l_isae010        STRING
   DEFINE l_isae010_str    STRING
   DEFINE l_isae011_str    STRING
   DEFINE l_isae009_num    LIKE type_t.num20
   DEFINE l_isae010_num    LIKE type_t.num20
   DEFINE l_isae011_1      LIKE type_t.num20   
   DEFINE l_err            LIKE type_t.num5       
   DEFINE l_err_code       STRING 
   DEFINE l_isad006        LIKE isad_t.isad006
   DEFINE l_isae013_num    LIKE type_t.num20   
   #161026-00024-----s
   DEFINE l_isae016_t      LIKE isae_t.isae016
   DEFINE l_isae017_t      LIKE isae_t.isae017
   DEFINE l_isae018_t      LIKE isae_t.isae018
   #161026-00024-----e
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
   DISPLAY BY NAME g_isae_m.isaesite,g_isae_m.isaesite_desc,g_isae_m.isac001,g_isae_m.ooall004,g_isae_m.isaecomp, 
       g_isae_m.isaecomp_desc,g_isae_m.isae019
   
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
   LET g_forupd_sql = "SELECT isae001,isae002,isae003,isae004,isae005,isae006,isae008,isae009,isae010, 
       isae011,isae020,isae012,isae013,isae014,isae015,isaestus,isae016,isae017,isae018,isae004,isaemodid, 
       isaemoddt,isaeownid,isaeowndp,isaecrtid,isaecrtdp,isaecrtdt FROM isae_t WHERE isaeent=? AND isaecomp=?  
       AND isaesite=? AND isae001=? AND isae002=? AND isae003=? AND isae004=? AND isae016=? AND isae017=?  
       AND isae018=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisi050_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aisi050_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aisi050_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_isae_m.isaesite,g_isae_m.isac001,g_isae_m.isae019
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   CALL cl_set_comp_visible('isae005,isae006',TRUE)
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aisi050.input.head" >}
   
      #單頭段
      INPUT BY NAME g_isae_m.isaesite,g_isae_m.isac001,g_isae_m.isae019 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            LET g_isae_m.isae019 = g_prog
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaesite
            
            #add-point:AFTER FIELD isaesite name="input.a.isaesite"
            
            LET g_isae_m.isaesite_desc = ' '
            DISPLAY BY NAME g_isae_m.isaesite_desc
            IF NOT cl_null(g_isae_m.isaesite) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isae_m.isaesite != g_isae_m_t.isaesite OR g_isae_m_t.isaesite IS NULL )) THEN #161005-00003#3 mark
               IF g_isae_m.isaesite != g_isae_m_o.isaesite OR cl_null(g_isae_m_o.isaesite) THEN #161005-00003#3 add
                  CALL s_fin_create_account_center_tmp()
                  CALL s_fin_azzi800_sons_query(today)
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_isae_m.isaesite
                  #160318-00025#44  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#44  2016/04/26  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooef001") THEN                  
                    #LET g_isae_m.isaesite = g_isae_m_t.isaesite #161005-00003#3 mark
                     LET g_isae_m.isaesite = g_isae_m_o.isaesite #161005-00003#3 add
                     CALL s_desc_get_department_desc(g_isae_m.isaesite) RETURNING g_isae_m.isaesite_desc
                     DISPLAY g_isae_m.isaesite_desc TO isaesite_desc                 
                     NEXT FIELD isaesite
                  END IF
                  
                  #161006-00005#15---add---s
                  #先取法人
                  CALL aisi050_isaecomp_ref()   #所屬法人
                  IF NOT cl_null(g_isae_m.isaecomp) THEN
                     LET l_count = NULL
                     SELECT count(1) INTO l_count 
                       FROM s_fin_tmp1
                      WHERE comp    = g_isae_m.isaecomp
                        AND ooef001 = g_isae_m.isaesite
                        
                     IF cl_null(l_count) THEN LET l_count = 0 END IF  
                        
                     IF l_count = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ais-00342'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_isae_m.isaesite = g_isae_m_o.isaesite
                        LET g_isae_m.isaesite_desc = g_isae_m_o.isaesite_desc
                        DISPLAY BY NAME g_isae_m.isaesite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF   
                  #161006-00005#15---add---e
               END IF
            END IF
            CALL s_desc_get_department_desc(g_isae_m.isaesite) RETURNING g_isae_m.isaesite_desc
            DISPLAY g_isae_m.isaesite_desc TO isaesite_desc

            #CALL aisi050_isaecomp_ref()  #所屬法人  #161006-00005#15   mark
            CALL aisi050_isac001_ref()   #所屬稅區 
            CALL s_desc_get_department_desc(g_isae_m.isaecomp) RETURNING g_isae_m.isaecomp_desc
            DISPLAY g_isae_m.isaecomp_desc TO isaecomp_desc
            LET g_isae_m_o.* = g_isae_m.*  #161005-00003#3 add
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaesite
            #add-point:BEFORE FIELD isaesite name="input.b.isaesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaesite
            #add-point:ON CHANGE isaesite name="input.g.isaesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isac001
            #add-point:BEFORE FIELD isac001 name="input.b.isac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isac001
            
            #add-point:AFTER FIELD isac001 name="input.a.isac001"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isac001
            #add-point:ON CHANGE isac001 name="input.g.isac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae019
            #add-point:BEFORE FIELD isae019 name="input.b.isae019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae019
            
            #add-point:AFTER FIELD isae019 name="input.a.isae019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae019
            #add-point:ON CHANGE isae019 name="input.g.isae019"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.isaesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaesite
            #add-point:ON ACTION controlp INFIELD isaesite name="input.c.isaesite"
            CALL aisi050_user_chk() RETURNING g_isae_m.isaecomp   
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isae_m.isaesite             #給予default值
            LET g_qryparam.where = "  ooef201 =  'Y' AND ooef001 IN",g_wc_isaesite   #161006-00005#15 add	
		                            #" ooef017 = '",g_isae_m.isaecomp,"' "    #161006-00005#15   mark
            CALL q_ooef001()                                      #呼叫開窗
            LET g_isae_m.isaesite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_isae_m.isaesite TO isaesite                   #顯示到畫面上
            CALL s_desc_get_department_desc(g_isae_m.isaesite) RETURNING g_isae_m.isaesite_desc
            DISPLAY BY NAME g_isae_m.isaesite_desc,g_isae_m.isaecomp_desc,g_isae_m.isaecomp
            NEXT FIELD isaesite

            #END add-point
 
 
         #Ctrlp:input.c.isac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isac001
            #add-point:ON ACTION controlp INFIELD isac001 name="input.c.isac001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_isae_m.isac001             #給予default值

            #給予arg

            CALL q_ooal002_11()                                #呼叫開窗

            LET g_isae_m.isac001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_isae_m.isac001 TO isac001              #顯示到畫面上

            NEXT FIELD isac001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.isae019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae019
            #add-point:ON ACTION controlp INFIELD isae019 name="input.c.isae019"
            
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
            DISPLAY BY NAME g_isae_m.isaecomp             
                            ,g_isae_m.isaesite   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aisi050_isae_t_mask_restore('restore_mask_o')
            
               UPDATE isae_t SET (isaesite,isaecomp,isae019) = (g_isae_m.isaesite,g_isae_m.isaecomp, 
                   g_isae_m.isae019)
                WHERE isaeent = g_enterprise AND isaecomp = g_isaecomp_t
                  AND isaesite = g_isaesite_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isae_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isae_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isae_m.isaecomp
               LET gs_keys_bak[1] = g_isaecomp_t
               LET gs_keys[2] = g_isae_m.isaesite
               LET gs_keys_bak[2] = g_isaesite_t
               LET gs_keys[3] = g_isae_d[g_detail_idx].isae001
               LET gs_keys_bak[3] = g_isae_d_t.isae001
               LET gs_keys[4] = g_isae_d[g_detail_idx].isae002
               LET gs_keys_bak[4] = g_isae_d_t.isae002
               LET gs_keys[5] = g_isae_d[g_detail_idx].isae003
               LET gs_keys_bak[5] = g_isae_d_t.isae003
               LET gs_keys[6] = g_isae_d[g_detail_idx].isae004
               LET gs_keys_bak[6] = g_isae_d_t.isae004
               LET gs_keys[7] = g_isae_d[g_detail_idx].isae016
               LET gs_keys_bak[7] = g_isae_d_t.isae016
               LET gs_keys[8] = g_isae_d[g_detail_idx].isae017
               LET gs_keys_bak[8] = g_isae_d_t.isae017
               LET gs_keys[9] = g_isae_d[g_detail_idx].isae018
               LET gs_keys_bak[9] = g_isae_d_t.isae018
               CALL aisi050_update_b('isae_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_isae_m_t)
                     #LET g_log2 = util.JSON.stringify(g_isae_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aisi050_isae_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aisi050_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_isaecomp_t = g_isae_m.isaecomp
           LET g_isaesite_t = g_isae_m.isaesite
 
           
           IF g_isae_d.getLength() = 0 THEN
              NEXT FIELD isae001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aisi050.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_isae_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_isae_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aisi050_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
           
            # LET g_isae_d[l_ac].isae019 = 'aisi050'
               
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
            CALL aisi050_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aisi050_cl USING g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aisi050_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aisi050_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_isae_d[l_ac].isae001 IS NOT NULL
               AND g_isae_d[l_ac].isae002 IS NOT NULL
               AND g_isae_d[l_ac].isae003 IS NOT NULL
               AND g_isae_d[l_ac].isae004 IS NOT NULL
               AND g_isae_d[l_ac].isae016 IS NOT NULL
               AND g_isae_d[l_ac].isae017 IS NOT NULL
               AND g_isae_d[l_ac].isae018 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_isae_d_t.* = g_isae_d[l_ac].*  #BACKUP
               LET g_isae_d_o.* = g_isae_d[l_ac].*  #BACKUP
               CALL aisi050_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aisi050_set_no_entry_b(l_cmd)
               OPEN aisi050_bcl USING g_enterprise,g_isae_m.isaecomp,
                                                g_isae_m.isaesite,
 
                                                g_isae_d_t.isae001
                                                ,g_isae_d_t.isae002
                                                ,g_isae_d_t.isae003
                                                ,g_isae_d_t.isae004
                                                ,g_isae_d_t.isae016
                                                ,g_isae_d_t.isae017
                                                ,g_isae_d_t.isae018
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aisi050_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aisi050_bcl INTO g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003, 
                      g_isae_d[l_ac].isae004,g_isae_d[l_ac].isae005,g_isae_d[l_ac].isae006,g_isae_d[l_ac].isae008, 
                      g_isae_d[l_ac].isae009,g_isae_d[l_ac].isae010,g_isae_d[l_ac].isae011,g_isae_d[l_ac].isae020, 
                      g_isae_d[l_ac].isae012,g_isae_d[l_ac].isae013,g_isae_d[l_ac].isae014,g_isae_d[l_ac].isae015, 
                      g_isae_d[l_ac].isaestus,g_isae_d[l_ac].isae016,g_isae_d[l_ac].isae017,g_isae_d[l_ac].isae018, 
                      g_isae2_d[l_ac].isae004,g_isae2_d[l_ac].isaemodid,g_isae2_d[l_ac].isaemoddt,g_isae2_d[l_ac].isaeownid, 
                      g_isae2_d[l_ac].isaeowndp,g_isae2_d[l_ac].isaecrtid,g_isae2_d[l_ac].isaecrtdp, 
                      g_isae2_d[l_ac].isaecrtdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_isae_d_t.isae001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_isae_d_mask_o[l_ac].* =  g_isae_d[l_ac].*
                  CALL aisi050_isae_t_mask()
                  LET g_isae_d_mask_n[l_ac].* =  g_isae_d[l_ac].*
                  
                  CALL aisi050_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL aisi050_isac001_ref()
            CALL aisi050_isae004_ref()
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_isae_d_t.* TO NULL
            INITIALIZE g_isae_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_isae_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_isae2_d[l_ac].isaeownid = g_user
      LET g_isae2_d[l_ac].isaeowndp = g_dept
      LET g_isae2_d[l_ac].isaecrtid = g_user
      LET g_isae2_d[l_ac].isaecrtdp = g_dept 
      LET g_isae2_d[l_ac].isaecrtdt = cl_get_current()
      LET g_isae2_d[l_ac].isaemodid = g_user
      LET g_isae2_d[l_ac].isaemoddt = cl_get_current()
      LET g_isae_d[l_ac].isaestus = ''
 
 
  
            #一般欄位預設值
                  LET g_isae_d[l_ac].isae005 = "N"
      LET g_isae_d[l_ac].isae006 = "1"
      LET g_isae_d[l_ac].isae013 = "0"
      LET g_isae_d[l_ac].isae014 = "N"
      LET g_isae_d[l_ac].isae015 = "N"
      LET g_isae_d[l_ac].isaestus = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_isae_d_t.* = g_isae_d[l_ac].*     #新輸入資料
            LET g_isae_d_o.* = g_isae_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aisi050_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aisi050_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_isae_d[li_reproduce_target].* = g_isae_d[li_reproduce].*
               LET g_isae2_d[li_reproduce_target].* = g_isae2_d[li_reproduce].*
 
               LET g_isae_d[g_isae_d.getLength()].isae001 = NULL
               LET g_isae_d[g_isae_d.getLength()].isae002 = NULL
               LET g_isae_d[g_isae_d.getLength()].isae003 = NULL
               LET g_isae_d[g_isae_d.getLength()].isae004 = NULL
               LET g_isae_d[g_isae_d.getLength()].isae016 = NULL
               LET g_isae_d[g_isae_d.getLength()].isae017 = NULL
               LET g_isae_d[g_isae_d.getLength()].isae018 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_ac>1 AND cl_null(g_isae_d[l_ac].isae002) THEN
               LET g_isae_d[l_ac].isae002 = g_isae_d[l_ac-1].isae002
            END IF
            
            IF l_ac>1 AND cl_null(g_isae_d[l_ac].isae003) THEN
               LET g_isae_d[l_ac].isae003 = g_isae_d[l_ac-1].isae003               
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
            SELECT COUNT(1) INTO l_count FROM isae_t 
             WHERE isaeent = g_enterprise AND isaecomp = g_isae_m.isaecomp
               AND isaesite = g_isae_m.isaesite
 
               AND isae001 = g_isae_d[l_ac].isae001
               AND isae002 = g_isae_d[l_ac].isae002
               AND isae003 = g_isae_d[l_ac].isae003
               AND isae004 = g_isae_d[l_ac].isae004
               AND isae016 = g_isae_d[l_ac].isae016
               AND isae017 = g_isae_d[l_ac].isae017
               AND isae018 = g_isae_d[l_ac].isae018
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               #161026-00024#1-----s
               LET g_isae_d[l_ac].isae016 = YEAR(g_isae_d[l_ac].isae002)
               LET g_isae_d[l_ac].isae017 = MONTH(g_isae_d[l_ac].isae002)
               LET g_isae_d[l_ac].isae018 = MONTH(g_isae_d[l_ac].isae003)
               #161026-00024#1-----e
               #end add-point
               INSERT INTO isae_t
                           (isaeent,
                            isaesite,isaecomp,isae019,
                            isae001,isae002,isae003,isae004,isae016,isae017,isae018
                            ,isae005,isae006,isae008,isae009,isae010,isae011,isae020,isae012,isae013,isae014,isae015,isaestus,isaemodid,isaemoddt,isaeownid,isaeowndp,isaecrtid,isaecrtdp,isaecrtdt) 
                     VALUES(g_enterprise,
                            g_isae_m.isaesite,g_isae_m.isaecomp,g_isae_m.isae019,
                            g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003,g_isae_d[l_ac].isae004, 
                                g_isae_d[l_ac].isae016,g_isae_d[l_ac].isae017,g_isae_d[l_ac].isae018 
 
                            ,g_isae_d[l_ac].isae005,g_isae_d[l_ac].isae006,g_isae_d[l_ac].isae008,g_isae_d[l_ac].isae009, 
                                g_isae_d[l_ac].isae010,g_isae_d[l_ac].isae011,g_isae_d[l_ac].isae020, 
                                g_isae_d[l_ac].isae012,g_isae_d[l_ac].isae013,g_isae_d[l_ac].isae014, 
                                g_isae_d[l_ac].isae015,g_isae_d[l_ac].isaestus,g_isae2_d[l_ac].isaemodid, 
                                g_isae2_d[l_ac].isaemoddt,g_isae2_d[l_ac].isaeownid,g_isae2_d[l_ac].isaeowndp, 
                                g_isae2_d[l_ac].isaecrtid,g_isae2_d[l_ac].isaecrtdp,g_isae2_d[l_ac].isaecrtdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_isae_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "isae_t:",SQLERRMESSAGE 
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
　　　　　　　　IF g_isae_d[l_ac].isae013 > 0 THEN
　　　　　　　　  INITIALIZE g_errparam TO NULL
  LET g_errparam.code = "ais-00135"
  LET g_errparam.extend = ''
  LET g_errparam.popup = FALSE
  CALL cl_err()

     　　　　　　 CANCEL DELETE
     　　　　　   NEXT FIELD CURRENT
    　　　　　  END IF 
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
               IF aisi050_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_isae_m.isaecomp
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_m.isaesite
 
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_d_t.isae001
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_d_t.isae002
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_d_t.isae003
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_d_t.isae004
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_d_t.isae016
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_d_t.isae017
                  LET gs_keys[gs_keys.getLength()+1] = g_isae_d_t.isae018
 
 
                  #刪除下層單身
                  IF NOT aisi050_key_delete_b(gs_keys,'isae_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aisi050_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aisi050_bcl
               LET l_count = g_isae_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_isae_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae001
            #add-point:BEFORE FIELD isae001 name="input.b.page1.isae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae001
            
            #add-point:AFTER FIELD isae001 name="input.a.page1.isae001"
            #161101-00068#1 mark ------
            ##重複性檢查
            #IF g_isae_m.isaesite IS NOT NULL AND g_isae_d[g_detail_idx].isae001 IS NOT NULL THEN 
            #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_isae_m.isaesite != g_isaesite_t OR g_isae_d[g_detail_idx].isae001 != g_isae_d_t.isae001 )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isae_t WHERE "||"isaeent = '" ||g_enterprise|| "'  AND "|| "isaesite = '"||g_isae_m.isaesite ||"' AND "|| "isae001 = '"||g_isae_d[g_detail_idx].isae001 ||"' ",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            #161101-00068#1 mark end---
            #160125-00005#1 ---s---
　　        IF NOT cl_null(g_isae_d[l_ac].isae001) THEN
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_isae_d[l_ac].isae001 != g_isae_d_t.isae001 OR g_isae_d_t.isae001 IS NULL )) THEN #161005-00003#3 mark
               IF g_isae_d[l_ac].isae001 != g_isae_d_o.isae001 OR cl_null(g_isae_d_o.isae001) THEN #161005-00003#3 add
                  #CALL aisi050_isae001_chk(g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003)  #161101-00068#1 mark
                  CALL aisi050_isae001_chk(g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003,g_isae_d_t.isae002,g_isae_d_t.isae003) #161101-00068#1
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_isae_d[l_ac].isae001 = g_isae_d_t.isae001 #161005-00003#3 mark
                    #LET g_isae_d[l_ac].isae002 = g_isae_d_t.isae002 #161005-00003#3 mark
                    #LET g_isae_d[l_ac].isae003 = g_isae_d_t.isae003 #161005-00003#3 mark
                     LET g_isae_d[l_ac].isae001 = g_isae_d_o.isae001 #161005-00003#3 add
                     LET g_isae_d[l_ac].isae002 = g_isae_d_o.isae002 #161005-00003#3 add
                     LET g_isae_d[l_ac].isae003 = g_isae_d_o.isae003 #161005-00003#3 add
                     NEXT FIELD CURRENT
                  END IF           
               END IF
            END IF
            #160125-00005#1 ---e---
            LET g_isae_d_o.* = g_isae_d[l_ac].* #161005-00003#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae001
            #add-point:ON CHANGE isae001 name="input.g.page1.isae001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae002
            #add-point:BEFORE FIELD isae002 name="input.b.page1.isae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae002
            
            #add-point:AFTER FIELD isae002 name="input.a.page1.isae002"
            #160125-00005#1 ---s---
            IF NOT cl_null(g_isae_d[l_ac].isae002) THEN
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_isae_d[l_ac].isae002 != g_isae_d_t.isae002 OR g_isae_d_t.isae002 IS NULL )) THEN #161005-00003#3 mark
               IF g_isae_d[l_ac].isae002 != g_isae_d_o.isae002 OR cl_null(g_isae_d_o.isae002) THEN #161005-00003#3 add
                  #CALL aisi050_isae001_chk(g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003)   #161101-00068#1 mark
                  CALL aisi050_isae001_chk(g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003,g_isae_d_t.isae002,g_isae_d_t.isae003) #161101-00068#1
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_isae_d[l_ac].isae001 = g_isae_d_t.isae001 #161005-00003#3 mark
                    #LET g_isae_d[l_ac].isae002 = g_isae_d_t.isae002 #161005-00003#3 mark
                    #LET g_isae_d[l_ac].isae003 = g_isae_d_t.isae003 #161005-00003#3 mark
                     LET g_isae_d[l_ac].isae001 = g_isae_d_o.isae001 #161005-00003#3 add
                     LET g_isae_d[l_ac].isae002 = g_isae_d_o.isae002 #161005-00003#3 add
                     LET g_isae_d[l_ac].isae003 = g_isae_d_o.isae003 #161005-00003#3 add
                     NEXT FIELD CURRENT
                  END IF    

                  IF g_isae_d[l_ac].isae002 > g_isae_d[l_ac].isae003 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00047"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_isae_d[l_ac].isae002 = '' 
                     LET g_isae_d[l_ac].isae003 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF              
            #160125-00005#1 ---e---            
            LET g_isae_d_o.* = g_isae_d[l_ac].*  #161005-00003#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae002
            #add-point:ON CHANGE isae002 name="input.g.page1.isae002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae003
            #add-point:BEFORE FIELD isae003 name="input.b.page1.isae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae003
            
            #add-point:AFTER FIELD isae003 name="input.a.page1.isae003"
            #160125-00005#1 ---s---
            IF NOT cl_null(g_isae_d[l_ac].isae003) THEN
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_isae_d[l_ac].isae003 != g_isae_d_t.isae003 OR g_isae_d_t.isae003 IS NULL )) THEN #161005-00003#3 mark
               IF g_isae_d[l_ac].isae003 != g_isae_d_o.isae003 OR cl_null(g_isae_d_o.isae003) THEN #161005-00003#3 add
                  #CALL aisi050_isae001_chk(g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003)   #161101-00068#1 mark
                  CALL aisi050_isae001_chk(g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003,g_isae_d_t.isae002,g_isae_d_t.isae003) #161101-00068#1
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_isae_d[l_ac].isae001 = g_isae_d_t.isae001 #161005-00003#3 mark
                    #LET g_isae_d[l_ac].isae002 = g_isae_d_t.isae002 #161005-00003#3 mark
                    #LET g_isae_d[l_ac].isae003 = g_isae_d_t.isae003 #161005-00003#3 mark
                     LET g_isae_d[l_ac].isae001 = g_isae_d_o.isae001 #161005-00003#3 add
                     LET g_isae_d[l_ac].isae002 = g_isae_d_o.isae002 #161005-00003#3 add
                     LET g_isae_d[l_ac].isae003 = g_isae_d_o.isae003 #161005-00003#3 add
                     NEXT FIELD CURRENT
                  END IF    

                  IF g_isae_d[l_ac].isae003 < g_isae_d[l_ac].isae002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00048"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_isae_d[l_ac].isae002 = '' 
                     LET g_isae_d[l_ac].isae003 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #160125-00005#1 ---s---
            LET g_isae_d_o.* = g_isae_d[l_ac].*  #161005-00003#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae003
            #add-point:ON CHANGE isae003 name="input.g.page1.isae003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae004
            
            #add-point:AFTER FIELD isae004 name="input.a.page1.isae004"
            LET g_isae_d[l_ac].isae004_desc = ''  #161127-00001#1   add
            CALL aisi050_isai006_info()     #161127-00001#1   add
            IF NOT cl_null(g_isae_d[l_ac].isae004) THEN
              IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isae_d[l_ac].isae004 != g_isae_d_t.isae004 OR g_isae_d_t.isae004 IS NULL )) THEN
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_isae_m.isac001
                 LET g_chkparam.arg2 = g_isae_d[l_ac].isae004
                 LET g_errshow = TRUE   #161127-00001#1   add
                 #161127-00001#1   mark---s
                 #LET g_chkparam.where = " isac003 = '2'"  #160413-00032#1
                 #IF NOT cl_chk_exist("v_isac002_2") THEN
                 #   LET g_isae_d[l_ac].isae004 = g_isae_d_t.isae004                
                 #   NEXT FIELD CURRENT
                 #161127-00001#1   mark---e
                 #161127-00001#1   add---s
                 LET g_isac003 = ''    
                 SELECT isac003 INTO g_isac003
                   FROM isac_t
                  WHERE isacent = g_enterprise
                    AND isac001 = g_isae_m.isac001
                    AND isac002 = g_isae_d[l_ac].isae004
                 LET g_chkparam.where = " isac003 = '",g_isac003,"'"  
                 IF cl_chk_exist("v_isac002_2") THEN
                    IF g_isai006 = 'N' THEN   #紅字發票與藍字發票不共用
                       IF g_isac003 <> '2' THEN  #銷項發票
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'ais-00057'
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET g_isae_d[l_ac].isae004 = g_isae_d_o.isae004                
                          LET g_isae_d[l_ac].isae004_desc = g_isae_d_o.isae004_desc
                          NEXT FIELD CURRENT
                       END IF
                    ELSE   #紅字發票與藍字發票共用
                       IF g_isac003 <> '2' AND g_isac003 <> '4'THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'ais-00250'
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET g_isae_d[l_ac].isae004 = g_isae_d_o.isae004  
                          LET g_isae_d[l_ac].isae004_desc = g_isae_d_o.isae004_desc                         
                          NEXT FIELD CURRENT
                       END IF
                    END IF
                 ELSE
                    LET g_isae_d[l_ac].isae004 = g_isae_d_o.isae004
                    LET g_isae_d[l_ac].isae004_desc = g_isae_d_o.isae004_desc                   
                    NEXT FIELD CURRENT
                 #161127-00001#1   add---e
                 END IF
                 
                 #161127-00001#1   add---s 
                 #檢查發票類型是否符合aisi090該據點設定可使用的
                 LET l_cnt = NULL 
                 SELECT (1) INTO l_cnt
                   FROM isaq_t
                  WHERE isaqent = g_enterprise
                    AND isaqsite = g_isae_m.isaesite
                    AND isaq001 = g_isae_d[l_ac].isae004
                    
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00338'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_d[l_ac].isae004 = g_isae_d_o.isae004   
                     LET g_isae_d[l_ac].isae004_desc = g_isae_d_o.isae004_desc
                     NEXT FIELD CURRENT
                  END IF
                 #161127-00001#1   add---e                 
              END IF
           END IF  
           CALL aisi050_isae004_ref()
           DISPLAY BY NAME g_isae_d[l_ac].isae004





            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae004
            #add-point:BEFORE FIELD isae004 name="input.b.page1.isae004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae004
            #add-point:ON CHANGE isae004 name="input.g.page1.isae004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae004_desc
            #add-point:BEFORE FIELD isae004_desc name="input.b.page1.isae004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae004_desc
            
            #add-point:AFTER FIELD isae004_desc name="input.a.page1.isae004_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae004_desc
            #add-point:ON CHANGE isae004_desc name="input.g.page1.isae004_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae005
            #add-point:BEFORE FIELD isae005 name="input.b.page1.isae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae005
            
            #add-point:AFTER FIELD isae005 name="input.a.page1.isae005"
       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae005
            #add-point:ON CHANGE isae005 name="input.g.page1.isae005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae006
            #add-point:BEFORE FIELD isae006 name="input.b.page1.isae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae006
            
            #add-point:AFTER FIELD isae006 name="input.a.page1.isae006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae006
            #add-point:ON CHANGE isae006 name="input.g.page1.isae006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae008
            #add-point:BEFORE FIELD isae008 name="input.b.page1.isae008"



            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae008
            
            #add-point:AFTER FIELD isae008 name="input.a.page1.isae008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae008
            #add-point:ON CHANGE isae008 name="input.g.page1.isae008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae009
            #add-point:BEFORE FIELD isae009 name="input.b.page1.isae009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae009
            
            #add-point:AFTER FIELD isae009 name="input.a.page1.isae009"
          ###################################################################################
          IF NOT cl_null(g_isae_d[g_detail_idx].isae009) AND cl_null(g_isae_d[g_detail_idx].isae010) THEN       
              LET g_isae_d[g_detail_idx].isae010 = g_isae_d[g_detail_idx].isae009
            END IF 
            
            IF NOT cl_null(g_isae_d[g_detail_idx].isae009) AND NOT cl_null(g_isae_d[g_detail_idx].isae010) THEN 
               #判斷起訖號碼長度是否相同
               IF length(g_isae_d[g_detail_idx].isae009) <> length(g_isae_d[g_detail_idx].isae010) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00012'
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_isae_d[g_detail_idx].isae009 = g_isae_d_t.isae009
                  NEXT FIELD isae009
               END IF 
                           
               #檢查起訖號碼是否存在或者是否存在于其他起訖號碼之間
               CALL aisi050_inv_repeat(g_isae_d[g_detail_idx].isae009) RETURNING l_err,l_err_code
               IF l_err THEN    # 表示有錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_err_code
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF l_cmd = 'a' THEN 
                     LET g_isae_d[g_detail_idx].isae009 = ''
                     LET g_isae_d[g_detail_idx].isae010 = ''
                     LET g_isae_d[g_detail_idx].isae011 = ''
                     LET g_isae_d[g_detail_idx].isae012 = ''
                  ELSE
                     LET g_isae_d[g_detail_idx].isae009 = g_isae_d_t.isae009
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae011 = g_isae_d_t.isae011
                     LET g_isae_d[g_detail_idx].isae012 = g_isae_d_t.isae012
                  END IF 
                  NEXT FIELD isae009
               END IF
               
               LET l_isae009 = g_isae_d[g_detail_idx].isae009
               LET l_isae010 = g_isae_d[g_detail_idx].isae010
               
               #起始號碼不能大於結束號碼
               IF  l_isae009 > l_isae010 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00009'
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  IF l_cmd = 'a' THEN 
                     LET g_isae_d[g_detail_idx].isae009 = ''
                     LET g_isae_d[g_detail_idx].isae010 = ''
                     LET g_isae_d[g_detail_idx].isae011 = ''
                     LET g_isae_d[g_detail_idx].isae012 = ''
                  ELSE
                     LET g_isae_d[g_detail_idx].isae009 = g_isae_d_t.isae009
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae011 = g_isae_d_t.isae011
                     LET g_isae_d[g_detail_idx].isae012 = g_isae_d_t.isae012
                  END IF 
                  NEXT FIELD isae009
               END IF 
               
               
               LET l_isae009_num = l_isae009
               LET l_isae010_num = l_isae010
               
               #一箱發票簿最多99999張
               IF l_isae010_num - l_isae009_num + 1 > 99999 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00050'
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF l_cmd = 'a' THEN 
                     LET g_isae_d[g_detail_idx].isae009 = ''
                     LET g_isae_d[g_detail_idx].isae010 = ''
                     LET g_isae_d[g_detail_idx].isae011 = ''
                     LET g_isae_d[g_detail_idx].isae012 = ''
                  ELSE
                     LET g_isae_d[g_detail_idx].isae009 = g_isae_d_t.isae009
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae011 = g_isae_d_t.isae011
                     LET g_isae_d[g_detail_idx].isae012 = g_isae_d_t.isae012
                  END IF 
                  NEXT FIELD isae009
               END IF 
               LET g_isae_d[g_detail_idx].isae011 = l_isae010_num - l_isae009_num + 1
               DISPLAY BY NAME g_isae_d[g_detail_idx].isae011
            END IF 
            
            LET g_isae_d[g_detail_idx].isae012 = g_isae_d[g_detail_idx].isae009
            DISPLAY g_isae_d[g_detail_idx].isae012 TO s_detail1[l_ac].isae012
            ###################################################################################
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae009
            #add-point:ON CHANGE isae009 name="input.g.page1.isae009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae010
            #add-point:BEFORE FIELD isae010 name="input.b.page1.isae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae010
            
            #add-point:AFTER FIELD isae010 name="input.a.page1.isae010"
            ########################################################
            IF NOT cl_null(g_isae_d[g_detail_idx].isae009) AND NOT cl_null(g_isae_d[g_detail_idx].isae010) THEN 
               #判斷起訖號碼長度是否相同
               IF length(g_isae_d[g_detail_idx].isae009) <> length(g_isae_d[g_detail_idx].isae010) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00012'
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                  NEXT FIELD isae010
               END IF 
                                        
               #檢查起訖號碼是否存在或者是否存在于其他起訖號碼之間
               CALL aisi050_inv_repeat(g_isae_d[g_detail_idx].isae010) RETURNING l_err,l_err_code
               IF l_err THEN    # 表示有錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_err_code
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF l_cmd = 'a' THEN 
                     LET g_isae_d[g_detail_idx].isae010 = ''
                     LET g_isae_d[g_detail_idx].isae011 = ''
                     LET g_isae_d[g_detail_idx].isae012 = ''
                  ELSE
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae011 = g_isae_d_t.isae011
                     LET g_isae_d[g_detail_idx].isae012 = g_isae_d_t.isae012
                  END IF 
                  NEXT FIELD isae010
               END IF
               
               LET l_isae009 = g_isae_d[g_detail_idx].isae009
               LET l_isae010 = g_isae_d[g_detail_idx].isae010
               
               #結束號碼不能小於起始號碼
               IF  l_isae010 < l_isae009 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00010'
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  IF l_cmd = 'a' THEN 
                     LET g_isae_d[g_detail_idx].isae010 = ''
                     LET g_isae_d[g_detail_idx].isae011 = ''
                     LET g_isae_d[g_detail_idx].isae012 = ''
                  ELSE
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae011 = g_isae_d_t.isae011
                     LET g_isae_d[g_detail_idx].isae012 = g_isae_d_t.isae012
                  END IF 
                  NEXT FIELD isae010
               END IF 

               LET l_isae009_num = l_isae009
               LET l_isae010_num = l_isae010
               
               #一箱發票簿最多99999張
               IF l_isae010_num - l_isae009_num + 1 > 99999 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00050'
                  LET g_errparam.extend = g_isae_d[g_detail_idx].isae010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF l_cmd = 'a' THEN 
                     LET g_isae_d[g_detail_idx].isae009 = ''
                     LET g_isae_d[g_detail_idx].isae010 = ''
                     LET g_isae_d[g_detail_idx].isae011 = ''
                     LET g_isae_d[g_detail_idx].isae012 = ''
                  ELSE
                     LET g_isae_d[g_detail_idx].isae009 = g_isae_d_t.isae009
                     LET g_isae_d[g_detail_idx].isae010 = g_isae_d_t.isae010
                     LET g_isae_d[g_detail_idx].isae011 = g_isae_d_t.isae011
                     LET g_isae_d[g_detail_idx].isae012 = g_isae_d_t.isae012
                  END IF 
                  NEXT FIELD isae010
               END IF 
               LET g_isae_d[g_detail_idx].isae011 = l_isae010_num - l_isae009_num + 1       
               DISPLAY BY NAME g_isae_d[g_detail_idx].isae011
            END IF 
            ########################################################
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae010
            #add-point:ON CHANGE isae010 name="input.g.page1.isae010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae011
            #add-point:BEFORE FIELD isae011 name="input.b.page1.isae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae011
            
            #add-point:AFTER FIELD isae011 name="input.a.page1.isae011"
          
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae011
            #add-point:ON CHANGE isae011 name="input.g.page1.isae011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae020
            #add-point:BEFORE FIELD isae020 name="input.b.page1.isae020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae020
            
            #add-point:AFTER FIELD isae020 name="input.a.page1.isae020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae020
            #add-point:ON CHANGE isae020 name="input.g.page1.isae020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_isae_d[l_ac].isae012,"0","0","","","azz-00079",1) THEN
               NEXT FIELD isae012
            END IF 
 
 
 
            #add-point:AFTER FIELD isae012 name="input.a.page1.isae012"
            IF g_isae_d[l_ac].isae012 < g_isae_d[l_ac].isae009  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ais-00013"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD isae012
            END IF  

            IF  g_isae_d[l_ac].isae012 > g_isae_d[l_ac].isae010 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ais-00013"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD isae012
            END IF        
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae012
            #add-point:BEFORE FIELD isae012 name="input.b.page1.isae012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae012
            #add-point:ON CHANGE isae012 name="input.g.page1.isae012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae014
            #add-point:BEFORE FIELD isae014 name="input.b.page1.isae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae014
            
            #add-point:AFTER FIELD isae014 name="input.a.page1.isae014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae014
            #add-point:ON CHANGE isae014 name="input.g.page1.isae014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae015
            #add-point:BEFORE FIELD isae015 name="input.b.page1.isae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae015
            
            #add-point:AFTER FIELD isae015 name="input.a.page1.isae015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae015
            #add-point:ON CHANGE isae015 name="input.g.page1.isae015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaestus
            #add-point:BEFORE FIELD isaestus name="input.b.page1.isaestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaestus
            
            #add-point:AFTER FIELD isaestus name="input.a.page1.isaestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaestus
            #add-point:ON CHANGE isaestus name="input.g.page1.isaestus"
            IF g_isae_d[g_detail_idx].isaestus = 'N' AND g_isae_d[g_detail_idx].isae013> 0  THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ais-00015'
               LET g_errparam.extend = g_isae_d[g_detail_idx].isaestus
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_isae_d[g_detail_idx].isaestus = 'Y'
               NEXT FIELD isaestus
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae016
            #add-point:BEFORE FIELD isae016 name="input.b.page1.isae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae016
            
            #add-point:AFTER FIELD isae016 name="input.a.page1.isae016"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_isae_m.isaecomp IS NOT NULL AND g_isae_m.isaesite IS NOT NULL AND g_isae_d[g_detail_idx].isae001 IS NOT NULL AND g_isae_d[g_detail_idx].isae002 IS NOT NULL AND g_isae_d[g_detail_idx].isae003 IS NOT NULL AND g_isae_d[g_detail_idx].isae004 IS NOT NULL AND g_isae_d[g_detail_idx].isae016 IS NOT NULL AND g_isae_d[g_detail_idx].isae017 IS NOT NULL AND g_isae_d[g_detail_idx].isae018 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_isae_m.isaecomp != g_isaecomp_t OR g_isae_m.isaesite != g_isaesite_t OR g_isae_d[g_detail_idx].isae001 != g_isae_d_t.isae001 OR g_isae_d[g_detail_idx].isae002 != g_isae_d_t.isae002 OR g_isae_d[g_detail_idx].isae003 != g_isae_d_t.isae003 OR g_isae_d[g_detail_idx].isae004 != g_isae_d_t.isae004 OR g_isae_d[g_detail_idx].isae016 != g_isae_d_t.isae016 OR g_isae_d[g_detail_idx].isae017 != g_isae_d_t.isae017 OR g_isae_d[g_detail_idx].isae018 != g_isae_d_t.isae018)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isae_t WHERE "||"isaeent = '" ||g_enterprise|| "' AND "||"isaecomp = '"||g_isae_m.isaecomp ||"' AND "|| "isaesite = '"||g_isae_m.isaesite ||"' AND "|| "isae001 = '"||g_isae_d[g_detail_idx].isae001 ||"' AND "|| "isae002 = '"||g_isae_d[g_detail_idx].isae002 ||"' AND "|| "isae003 = '"||g_isae_d[g_detail_idx].isae003 ||"' AND "|| "isae004 = '"||g_isae_d[g_detail_idx].isae004 ||"' AND "|| "isae016 = '"||g_isae_d[g_detail_idx].isae016 ||"' AND "|| "isae017 = '"||g_isae_d[g_detail_idx].isae017 ||"' AND "|| "isae018 = '"||g_isae_d[g_detail_idx].isae018 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae016
            #add-point:ON CHANGE isae016 name="input.g.page1.isae016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae017
            #add-point:BEFORE FIELD isae017 name="input.b.page1.isae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae017
            
            #add-point:AFTER FIELD isae017 name="input.a.page1.isae017"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_isae_m.isaecomp IS NOT NULL AND g_isae_m.isaesite IS NOT NULL AND g_isae_d[g_detail_idx].isae001 IS NOT NULL AND g_isae_d[g_detail_idx].isae002 IS NOT NULL AND g_isae_d[g_detail_idx].isae003 IS NOT NULL AND g_isae_d[g_detail_idx].isae004 IS NOT NULL AND g_isae_d[g_detail_idx].isae016 IS NOT NULL AND g_isae_d[g_detail_idx].isae017 IS NOT NULL AND g_isae_d[g_detail_idx].isae018 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_isae_m.isaecomp != g_isaecomp_t OR g_isae_m.isaesite != g_isaesite_t OR g_isae_d[g_detail_idx].isae001 != g_isae_d_t.isae001 OR g_isae_d[g_detail_idx].isae002 != g_isae_d_t.isae002 OR g_isae_d[g_detail_idx].isae003 != g_isae_d_t.isae003 OR g_isae_d[g_detail_idx].isae004 != g_isae_d_t.isae004 OR g_isae_d[g_detail_idx].isae016 != g_isae_d_t.isae016 OR g_isae_d[g_detail_idx].isae017 != g_isae_d_t.isae017 OR g_isae_d[g_detail_idx].isae018 != g_isae_d_t.isae018)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isae_t WHERE "||"isaeent = '" ||g_enterprise|| "' AND "||"isaecomp = '"||g_isae_m.isaecomp ||"' AND "|| "isaesite = '"||g_isae_m.isaesite ||"' AND "|| "isae001 = '"||g_isae_d[g_detail_idx].isae001 ||"' AND "|| "isae002 = '"||g_isae_d[g_detail_idx].isae002 ||"' AND "|| "isae003 = '"||g_isae_d[g_detail_idx].isae003 ||"' AND "|| "isae004 = '"||g_isae_d[g_detail_idx].isae004 ||"' AND "|| "isae016 = '"||g_isae_d[g_detail_idx].isae016 ||"' AND "|| "isae017 = '"||g_isae_d[g_detail_idx].isae017 ||"' AND "|| "isae018 = '"||g_isae_d[g_detail_idx].isae018 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae017
            #add-point:ON CHANGE isae017 name="input.g.page1.isae017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae018
            
            #add-point:AFTER FIELD isae018 name="input.a.page1.isae018"
            #此段落由子樣板a05產生
            #IF  g_isae_m.isaesite IS NOT NULL AND g_isae_m.isae001 IS NOT NULL AND g_isae_m.isae002 IS NOT NULL AND g_isae_m.isae003 IS NOT NULL AND g_isae_d[g_detail_idx].isae004 IS NOT NULL AND g_isae_d[g_detail_idx].isae018 IS NOT NULL THEN 
            #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_isae_m.isaesite != g_isaesite_t OR g_isae_m.isae001 != g_isae001_t OR g_isae_m.isae002 != g_isae002_t OR g_isae_m.isae003 != g_isae003_t OR g_isae_d[g_detail_idx].isae004 != g_isae_d_t.isae004 OR g_isae_d[g_detail_idx].isae018 != g_isae_d_t.isae018)) THEN 
            #      IF NOT ap_chk_notDup(g_isae_d[g_detail_idx].isae018,"SELECT COUNT(*) FROM isae_t WHERE "||"isaeent = '" ||g_enterprise|| "' AND "||"isaesite = '"||g_isae_m.isaesite ||"' AND "|| "isae001 = '"||g_isae_m.isae001 ||"' AND "|| "isae002 = '"||g_isae_m.isae002 ||"' AND "|| "isae003 = '"||g_isae_m.isae003 ||"' AND "|| "isae004 = '"||g_isae_d[g_detail_idx].isae004 ||"' AND "|| "isae018 = '"||g_isae_d[g_detail_idx].isae018 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            #161021-00031 mark----s
            #CALL aisi050_isae018_desc()
            #IF NOT cl_null(g_isae_d[l_ac].isae018) THEN    
            #   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            #   INITIALIZE g_chkparam.* TO NULL      
            #   
            #   #設定g_chkparam.*的參數
            #   LET g_chkparam.arg1 = g_isae_d[l_ac].isae018
            #
            #   #呼叫檢查存在並帶值的library
            #   IF cl_chk_exist("v_ooef001") THEN
            #      #檢查成功時後續處理
            #   ELSE
            #      #檢查失敗時後續處理
            #      LET g_isae_d[l_ac].isae018 = g_isae_d_t.isae018
            #      CALL aisi050_isae018_desc()
            #      NEXT FIELD CURRENT
            #   END IF
            #
            #END IF
            #161021-00031#mark-----e
        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae018
            #add-point:BEFORE FIELD isae018 name="input.b.page1.isae018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae018
            #add-point:ON CHANGE isae018 name="input.g.page1.isae018"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.isae001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae001
            #add-point:ON ACTION controlp INFIELD isae001 name="input.c.page1.isae001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae002
            #add-point:ON ACTION controlp INFIELD isae002 name="input.c.page1.isae002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae003
            #add-point:ON ACTION controlp INFIELD isae003 name="input.c.page1.isae003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae004
            #add-point:ON ACTION controlp INFIELD isae004 name="input.c.page1.isae004"
            #此段落由子樣板a07產生            
            #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isae_d[l_ac].isae004             #給予default值
            IF g_isai006 = 'N' THEN   #161127-00001#1   add   #紅字發票與藍字發票不共用
               LET g_qryparam.where = " isac001 = '",g_isae_m.isac001,"' AND isac003 = '2'"
            #161127-00001#1   add---s
            ELSE   #紅字發票與藍字發票共用
               LET g_qryparam.where = " isac001 = '",g_isae_m.isac001,"'",
                                      " AND (isac003 = '2' OR isac003 = '4')"
            END IF

            LET g_qryparam.where = g_qryparam.where CLIPPED,
                                   " AND isac002 IN (SELECT isaq001 FROM isaq_t ",
                                   "                  WHERE isaqent = ",g_enterprise,
                                   "                    AND isaqsite ='",g_isae_m.isaesite,"')"
            #161127-00001#1   add---e
            CALL q_isac002()                                             #呼叫開窗
            CALL aisi050_isai006_info()   #161127-00001#1   add
            LET g_isae_d[l_ac].isae004 = g_qryparam.return1              #將開窗取得的值回傳到變數                   
            NEXT FIELD isae004                                           #返回原欄位
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae004_desc
            #add-point:ON ACTION controlp INFIELD isae004_desc name="input.c.page1.isae004_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae005
            #add-point:ON ACTION controlp INFIELD isae005 name="input.c.page1.isae005"
         

            #END add-point
 
 
         #Ctrlp:input.c.page1.isae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae006
            #add-point:ON ACTION controlp INFIELD isae006 name="input.c.page1.isae006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae008
            #add-point:ON ACTION controlp INFIELD isae008 name="input.c.page1.isae008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae009
            #add-point:ON ACTION controlp INFIELD isae009 name="input.c.page1.isae009"



            #END add-point
 
 
         #Ctrlp:input.c.page1.isae010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae010
            #add-point:ON ACTION controlp INFIELD isae010 name="input.c.page1.isae010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae011
            #add-point:ON ACTION controlp INFIELD isae011 name="input.c.page1.isae011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae020
            #add-point:ON ACTION controlp INFIELD isae020 name="input.c.page1.isae020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae012
            #add-point:ON ACTION controlp INFIELD isae012 name="input.c.page1.isae012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae014
            #add-point:ON ACTION controlp INFIELD isae014 name="input.c.page1.isae014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae015
            #add-point:ON ACTION controlp INFIELD isae015 name="input.c.page1.isae015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isaestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaestus
            #add-point:ON ACTION controlp INFIELD isaestus name="input.c.page1.isaestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae016
            #add-point:ON ACTION controlp INFIELD isae016 name="input.c.page1.isae016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae017
            #add-point:ON ACTION controlp INFIELD isae017 name="input.c.page1.isae017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.isae018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae018
            #add-point:ON ACTION controlp INFIELD isae018 name="input.c.page1.isae018"
#此段落由子樣板a07產生            
            #開窗i段
            #161021-00031 mark-----s
			   # INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
			   # LET g_qryparam.reqry = FALSE
            #
            #LET g_qryparam.default1 = g_isae_d[l_ac].isae018             #給予default值
            #
            ##給予arg
            #
            #CALL q_ooef001()                                #呼叫開窗
            #
            #LET g_isae_d[l_ac].isae018 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #
            #DISPLAY g_isae_d[l_ac].isae018 TO isae018              #顯示到畫面上
            #CALL aisi050_isae018_desc()
            #NEXT FIELD isae018                          #返回原欄位
            #161021-00031 mark-----e

            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_isae_d[l_ac].* = g_isae_d_t.*
               CLOSE aisi050_bcl
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
               LET g_errparam.extend = g_isae_d[l_ac].isae001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_isae_d[l_ac].* = g_isae_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_isae2_d[l_ac].isaemodid = g_user 
LET g_isae2_d[l_ac].isaemoddt = cl_get_current()
LET g_isae2_d[l_ac].isaemodid_desc = cl_get_username(g_isae2_d[l_ac].isaemodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               #161026-00024#1-----s
               LET g_isae_d[l_ac].isae016 = YEAR(g_isae_d[l_ac].isae002)
               LET g_isae_d[l_ac].isae017 = MONTH(g_isae_d[l_ac].isae002)
               LET g_isae_d[l_ac].isae018 = MONTH(g_isae_d[l_ac].isae003)
               #161026-00024#1-----e
               #end add-point
         
               #將遮罩欄位還原
               CALL aisi050_isae_t_mask_restore('restore_mask_o')
         
               UPDATE isae_t SET (isaecomp,isaesite,isae001,isae002,isae003,isae004,isae005,isae006, 
                   isae008,isae009,isae010,isae011,isae020,isae012,isae013,isae014,isae015,isaestus, 
                   isae016,isae017,isae018,isaemodid,isaemoddt,isaeownid,isaeowndp,isaecrtid,isaecrtdp, 
                   isaecrtdt) = (g_isae_m.isaecomp,g_isae_m.isaesite,g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002, 
                   g_isae_d[l_ac].isae003,g_isae_d[l_ac].isae004,g_isae_d[l_ac].isae005,g_isae_d[l_ac].isae006, 
                   g_isae_d[l_ac].isae008,g_isae_d[l_ac].isae009,g_isae_d[l_ac].isae010,g_isae_d[l_ac].isae011, 
                   g_isae_d[l_ac].isae020,g_isae_d[l_ac].isae012,g_isae_d[l_ac].isae013,g_isae_d[l_ac].isae014, 
                   g_isae_d[l_ac].isae015,g_isae_d[l_ac].isaestus,g_isae_d[l_ac].isae016,g_isae_d[l_ac].isae017, 
                   g_isae_d[l_ac].isae018,g_isae2_d[l_ac].isaemodid,g_isae2_d[l_ac].isaemoddt,g_isae2_d[l_ac].isaeownid, 
                   g_isae2_d[l_ac].isaeowndp,g_isae2_d[l_ac].isaecrtid,g_isae2_d[l_ac].isaecrtdp,g_isae2_d[l_ac].isaecrtdt) 
 
                WHERE isaeent = g_enterprise AND isaecomp = g_isae_m.isaecomp 
                 AND isaesite = g_isae_m.isaesite 
 
                 AND isae001 = g_isae_d_t.isae001 #項次   
                 AND isae002 = g_isae_d_t.isae002  
                 AND isae003 = g_isae_d_t.isae003  
                 AND isae004 = g_isae_d_t.isae004  
                 AND isae016 = g_isae_d_t.isae016  
                 AND isae017 = g_isae_d_t.isae017  
                 AND isae018 = g_isae_d_t.isae018  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isae_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "isae_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isae_m.isaecomp
               LET gs_keys_bak[1] = g_isaecomp_t
               LET gs_keys[2] = g_isae_m.isaesite
               LET gs_keys_bak[2] = g_isaesite_t
               LET gs_keys[3] = g_isae_d[g_detail_idx].isae001
               LET gs_keys_bak[3] = g_isae_d_t.isae001
               LET gs_keys[4] = g_isae_d[g_detail_idx].isae002
               LET gs_keys_bak[4] = g_isae_d_t.isae002
               LET gs_keys[5] = g_isae_d[g_detail_idx].isae003
               LET gs_keys_bak[5] = g_isae_d_t.isae003
               LET gs_keys[6] = g_isae_d[g_detail_idx].isae004
               LET gs_keys_bak[6] = g_isae_d_t.isae004
               LET gs_keys[7] = g_isae_d[g_detail_idx].isae016
               LET gs_keys_bak[7] = g_isae_d_t.isae016
               LET gs_keys[8] = g_isae_d[g_detail_idx].isae017
               LET gs_keys_bak[8] = g_isae_d_t.isae017
               LET gs_keys[9] = g_isae_d[g_detail_idx].isae018
               LET gs_keys_bak[9] = g_isae_d_t.isae018
               CALL aisi050_update_b('isae_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_isae_m),util.JSON.stringify(g_isae_d_t)
                     LET g_log2 = util.JSON.stringify(g_isae_m),util.JSON.stringify(g_isae_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aisi050_isae_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_isae_m.isaecomp
               LET ls_keys[ls_keys.getLength()+1] = g_isae_m.isaesite
 
               LET ls_keys[ls_keys.getLength()+1] = g_isae_d_t.isae001
               LET ls_keys[ls_keys.getLength()+1] = g_isae_d_t.isae002
               LET ls_keys[ls_keys.getLength()+1] = g_isae_d_t.isae003
               LET ls_keys[ls_keys.getLength()+1] = g_isae_d_t.isae004
               LET ls_keys[ls_keys.getLength()+1] = g_isae_d_t.isae016
               LET ls_keys[ls_keys.getLength()+1] = g_isae_d_t.isae017
               LET ls_keys[ls_keys.getLength()+1] = g_isae_d_t.isae018
 
               CALL aisi050_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aisi050_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_isae_d[l_ac].* = g_isae_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aisi050_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_isae_d.getLength() = 0 THEN
               NEXT FIELD isae001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_isae_d[li_reproduce_target].* = g_isae_d[li_reproduce].*
               LET g_isae2_d[li_reproduce_target].* = g_isae2_d[li_reproduce].*
 
               LET g_isae_d[li_reproduce_target].isae001 = NULL
               LET g_isae_d[li_reproduce_target].isae002 = NULL
               LET g_isae_d[li_reproduce_target].isae003 = NULL
               LET g_isae_d[li_reproduce_target].isae004 = NULL
               LET g_isae_d[li_reproduce_target].isae016 = NULL
               LET g_isae_d[li_reproduce_target].isae017 = NULL
               LET g_isae_d[li_reproduce_target].isae018 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_isae_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_isae_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_isae2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL aisi050_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL aisi050_idx_chk()
            CALL aisi050_ui_detailshow()
        
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
            NEXT FIELD isaesite
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD isae001
               WHEN "s_detail2"
                  NEXT FIELD isae004_2
 
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD isaecomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD isae001
               WHEN "s_detail2"
                  NEXT FIELD isae004_2
 
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
 
{<section id="aisi050.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aisi050_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
 
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aisi050_b_fill(g_wc2) #第一階單身填充
      CALL aisi050_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aisi050_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
  
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_isae_m.isaesite,g_isae_m.isaesite_desc,g_isae_m.isac001,g_isae_m.ooall004,g_isae_m.isaecomp, 
       g_isae_m.isaecomp_desc,g_isae_m.isae019
 
   CALL aisi050_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aisi050_ref_show()
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
   FOR l_ac = 1 TO g_isae_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
     
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_isae2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_isae2_d[l_ac].isaemodid
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET g_isae2_d[l_ac].isaemodid_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_isae2_d[l_ac].isaemodid_desc

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_isae2_d[l_ac].isaeownid
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET g_isae2_d[l_ac].isaeownid_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_isae2_d[l_ac].isaeownid_desc

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_isae2_d[l_ac].isaeowndp
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_isae2_d[l_ac].isaeowndp_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_isae2_d[l_ac].isaeowndp_desc

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_isae2_d[l_ac].isaecrtid
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET g_isae2_d[l_ac].isaecrtid_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_isae2_d[l_ac].isaecrtid_desc

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_isae2_d[l_ac].isaecrtdp
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_isae2_d[l_ac].isaecrtdp_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_isae2_d[l_ac].isaecrtdp_desc
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aisi050.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aisi050_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE isae_t.isaecomp 
   DEFINE l_oldno     LIKE isae_t.isaecomp 
   DEFINE l_newno02     LIKE isae_t.isaesite 
   DEFINE l_oldno02     LIKE isae_t.isaesite 
 
   DEFINE l_master    RECORD LIKE isae_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE isae_t.* #此變數樣板目前無使用
 
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
 
   IF g_isae_m.isaecomp IS NULL
      OR g_isae_m.isaesite IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_isaecomp_t = g_isae_m.isaecomp
   LET g_isaesite_t = g_isae_m.isaesite
 
   
   LET g_isae_m.isaecomp = ""
   LET g_isae_m.isaesite = ""
 
   LET g_master_insert = FALSE
   CALL aisi050_set_entry('a')
   CALL aisi050_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_isae_m.isaesite_desc = ''
   DISPLAY BY NAME g_isae_m.isaesite_desc
   LET g_isae_m.isaecomp_desc = ''
   DISPLAY BY NAME g_isae_m.isaecomp_desc
 
   
   CALL aisi050_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_isae_m.* TO NULL
      INITIALIZE g_isae_d TO NULL
      INITIALIZE g_isae2_d TO NULL
 
      CALL aisi050_show()
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
   CALL aisi050_set_act_visible()
   CALL aisi050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_isaecomp_t = g_isae_m.isaecomp
   LET g_isaesite_t = g_isae_m.isaesite
 
   
   #組合新增資料的條件
   LET g_add_browse = " isaeent = " ||g_enterprise|| " AND",
                      " isaecomp = '", g_isae_m.isaecomp, "' "
                      ," AND isaesite = '", g_isae_m.isaesite, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aisi050_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aisi050_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aisi050_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aisi050_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE isae_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aisi050_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM isae_t
    WHERE isaeent = g_enterprise AND isaecomp = g_isaecomp_t
    AND isaesite = g_isaesite_t
 
       INTO TEMP aisi050_detail
   
   #將key修正為調整後   
   UPDATE aisi050_detail 
      #更新key欄位
      SET isaecomp = g_isae_m.isaecomp
          , isaesite = g_isae_m.isaesite
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , isaeownid = g_user 
       , isaeowndp = g_dept
       , isaecrtid = g_user
       , isaecrtdp = g_dept 
       , isaecrtdt = ld_date
       , isaemodid = g_user
       , isaemoddt = ld_date
      #, isaestus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO isae_t SELECT * FROM aisi050_detail
   
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
   DROP TABLE aisi050_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_isaecomp_t = g_isae_m.isaecomp
   LET g_isaesite_t = g_isae_m.isaesite
 
   
   DROP TABLE aisi050_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aisi050_delete()
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
   
   IF g_isae_m.isaecomp IS NULL
   OR g_isae_m.isaesite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aisi050_cl USING g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aisi050_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aisi050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aisi050_master_referesh USING g_isae_m.isaecomp,g_isae_m.isaesite INTO g_isae_m.isaesite, 
       g_isae_m.isaecomp,g_isae_m.isae019,g_isae_m.isaesite_desc,g_isae_m.isaecomp_desc
   
   #遮罩相關處理
   LET g_isae_m_mask_o.* =  g_isae_m.*
   CALL aisi050_isae_t_mask()
   LET g_isae_m_mask_n.* =  g_isae_m.*
   
   CALL aisi050_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aisi050_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM isae_t WHERE isaeent = g_enterprise AND isaecomp = g_isae_m.isaecomp
                                                               AND isaesite = g_isae_m.isaesite
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isae_t:",SQLERRMESSAGE 
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
      #   CLOSE aisi050_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_isae_d.clear() 
      CALL g_isae2_d.clear()       
 
     
      CALL aisi050_ui_browser_refresh()  
      #CALL aisi050_ui_headershow()  
      #CALL aisi050_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aisi050_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aisi050_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aisi050_cl
 
   #功能已完成,通報訊息中心
   CALL aisi050_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aisi050.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisi050_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_isae_d.clear()
   CALL g_isae2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT isae001,isae002,isae003,isae004,isae005,isae006,isae008,isae009,isae010, 
       isae011,isae020,isae012,isae013,isae014,isae015,isaestus,isae016,isae017,isae018,isae004,isaemodid, 
       isaemoddt,isaeownid,isaeowndp,isaecrtid,isaecrtdp,isaecrtdt,t1.ooag011 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 FROM isae_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=isaemodid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=isaeownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=isaeowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=isaecrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=isaecrtdp AND t5.ooefl002='"||g_dlang||"' ",
 
               " WHERE isaeent= ? AND isaecomp=? AND isaesite=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("isae_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
  
   #161026-00024#1-----s
   LET g_sql = g_sql CLIPPED," AND ",g_wc CLIPPED
   #161026-00024#1-----e
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aisi050_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY isae_t.isae001,isae_t.isae002,isae_t.isae003,isae_t.isae004,isae_t.isae016,isae_t.isae017,isae_t.isae018"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
 
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aisi050_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aisi050_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite INTO g_isae_d[l_ac].isae001, 
          g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003,g_isae_d[l_ac].isae004,g_isae_d[l_ac].isae005, 
          g_isae_d[l_ac].isae006,g_isae_d[l_ac].isae008,g_isae_d[l_ac].isae009,g_isae_d[l_ac].isae010, 
          g_isae_d[l_ac].isae011,g_isae_d[l_ac].isae020,g_isae_d[l_ac].isae012,g_isae_d[l_ac].isae013, 
          g_isae_d[l_ac].isae014,g_isae_d[l_ac].isae015,g_isae_d[l_ac].isaestus,g_isae_d[l_ac].isae016, 
          g_isae_d[l_ac].isae017,g_isae_d[l_ac].isae018,g_isae2_d[l_ac].isae004,g_isae2_d[l_ac].isaemodid, 
          g_isae2_d[l_ac].isaemoddt,g_isae2_d[l_ac].isaeownid,g_isae2_d[l_ac].isaeowndp,g_isae2_d[l_ac].isaecrtid, 
          g_isae2_d[l_ac].isaecrtdp,g_isae2_d[l_ac].isaecrtdt,g_isae2_d[l_ac].isaemodid_desc,g_isae2_d[l_ac].isaeownid_desc, 
          g_isae2_d[l_ac].isaeowndp_desc,g_isae2_d[l_ac].isaecrtid_desc,g_isae2_d[l_ac].isaecrtdp_desc  
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
         CALL aisi050_isac001_ref()  
         CALL aisi050_isae004_ref()
         LET g_isae_d[l_ac].isae013 = g_isae_d[l_ac].isae012 - g_isae_d[l_ac].isae009 #170111-00027#1 add 發票已開張數=下次列印號碼-起始發票號碼         
         
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
 
            CALL g_isae_d.deleteElement(g_isae_d.getLength())
      CALL g_isae2_d.deleteElement(g_isae2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
  
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_isae_d.getLength()
      LET g_isae_d_mask_o[l_ac].* =  g_isae_d[l_ac].*
      CALL aisi050_isae_t_mask()
      LET g_isae_d_mask_n[l_ac].* =  g_isae_d[l_ac].*
   END FOR
   
   LET g_isae2_d_mask_o.* =  g_isae2_d.*
   FOR l_ac = 1 TO g_isae2_d.getLength()
      LET g_isae2_d_mask_o[l_ac].* =  g_isae2_d[l_ac].*
      CALL aisi050_isae_t_mask()
      LET g_isae2_d_mask_n[l_ac].* =  g_isae2_d[l_ac].*
   END FOR
 
 
   FREE aisi050_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aisi050_idx_chk()
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
      IF g_detail_idx > g_isae_d.getLength() THEN
         LET g_detail_idx = g_isae_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_isae_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_isae_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_isae2_d.getLength() THEN
         LET g_detail_idx = g_isae2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_isae2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_isae2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisi050_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_isae_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aisi050_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM isae_t
    WHERE isaeent = g_enterprise AND isaecomp = g_isae_m.isaecomp AND
                              isaesite = g_isae_m.isaesite AND
 
          isae001 = g_isae_d_t.isae001
      AND isae002 = g_isae_d_t.isae002
      AND isae003 = g_isae_d_t.isae003
      AND isae004 = g_isae_d_t.isae004
      AND isae016 = g_isae_d_t.isae016
      AND isae017 = g_isae_d_t.isae017
      AND isae018 = g_isae_d_t.isae018
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "isae_t:",SQLERRMESSAGE 
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
 
{<section id="aisi050.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aisi050_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aisi050.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aisi050_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aisi050.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aisi050_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aisi050.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aisi050_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_isae_d[l_ac].isae001 = g_isae_d_t.isae001 
      AND g_isae_d[l_ac].isae002 = g_isae_d_t.isae002 
      AND g_isae_d[l_ac].isae003 = g_isae_d_t.isae003 
      AND g_isae_d[l_ac].isae004 = g_isae_d_t.isae004 
      AND g_isae_d[l_ac].isae016 = g_isae_d_t.isae016 
      AND g_isae_d[l_ac].isae017 = g_isae_d_t.isae017 
      AND g_isae_d[l_ac].isae018 = g_isae_d_t.isae018 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aisi050_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aisi050.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aisi050_lock_b(ps_table,ps_page)
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
   #CALL aisi050_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aisi050.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aisi050_unlock_b(ps_table,ps_page)
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
 
{<section id="aisi050.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aisi050_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("isaecomp,isaesite",TRUE)
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
 
{<section id="aisi050.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aisi050_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("isaecomp,isaesite",FALSE)
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
 
{<section id="aisi050.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aisi050_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aisi050_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aisi050_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisi050.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aisi050_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisi050.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aisi050_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisi050.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aisi050_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisi050.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aisi050_default_search()
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
      LET ls_wc = ls_wc, " isaecomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " isaesite = '", g_argv[02], "' AND "
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
   LET g_wc = g_wc CLIPPED, " AND isae019 = '",g_prog,"' "
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aisi050.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aisi050_fill_chk(ps_idx)
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
 
{<section id="aisi050.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aisi050_modify_detail_chk(ps_record)
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
         LET ls_return = "isae001"
      WHEN "s_detail2"
         LET ls_return = "isae004_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050.mask_functions" >}
&include "erp/ais/aisi050_mask.4gl"
 
{</section>}
 
{<section id="aisi050.state_change" >}
    
 
{</section>}
 
{<section id="aisi050.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aisi050_set_pk_array()
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
   LET g_pk_array[1].values = g_isae_m.isaecomp
   LET g_pk_array[1].column = 'isaecomp'
   LET g_pk_array[2].values = g_isae_m.isaesite
   LET g_pk_array[2].column = 'isaesite'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aisi050.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aisi050_msgcentre_notify(lc_state)
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
   CALL aisi050_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_isae_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aisi050.other_function" readonly="Y" >}
#+ 檢查起訖號碼是否存在或者是否存在于其他起訖號碼之間
PRIVATE FUNCTION aisi050_inv_repeat(p_inv_no)
   DEFINE p_inv_no          STRING
   DEFINE l_sql             STRING
   DEFINE l_isae009         LIKE isae_t.isae009
   DEFINE l_isae010         LIKE isae_t.isae010
   DEFINE l_sta             LIKE type_t.num10 
   DEFINE l_end             LIKE type_t.num10
   DEFINE l_num             LIKE type_t.num10
   DEFINE p_err             LIKE type_t.num5
   DEFINE p_err_code        STRING
   DEFINE p_ac              LIKE type_t.num10
   
   LET p_err = FALSE
   LET p_err_code = ""

   IF NOT p_err THEN   # 表示無錯誤
      LET l_num = p_inv_no         
      LET l_sql = " SELECT isae009,isae010 FROM isae_t",
                  "    WHERE isaesite = '",g_isae_m.isaesite,"'",
                  "      AND isae001 = '",g_isae_d[g_detail_idx].isae001,"'"
                  
      IF NOT cl_null(g_isae_d_t.isae009) THEN
         LET l_sql = l_sql," AND isae009 NOT IN ('",g_isae_d_t.isae009,"')"
      END IF
     
      PREPARE i050_repeat FROM l_sql      
      DECLARE i050_repeat_cs CURSOR FOR i050_repeat
      FOREACH i050_repeat_cs INTO l_isae009, l_isae010 
         LET l_sta = l_isae009
         LET l_end = l_isae010
         IF (l_num > l_sta AND l_num < l_end) OR l_num = l_sta OR l_num = l_end THEN         
            LET p_err = TRUE
            LET p_err_code = 'ais-00013'
         END IF
      END FOREACH
   END IF

   RETURN p_err,p_err_code
END FUNCTION

################################################################################
# Descriptions...: 營運據點所屬法人
# Memo...........:
# Usage..........: aisi050_isaecomp_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_isaecomp_ref()
   
   LET g_isae_m.isaecomp =''
   SELECT ooef017,ooef019 INTO g_isae_m.isaecomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_isae_m.isaesite
      
   IF cl_null(g_isae_m.isaecomp) THEN
      LET g_isae_m.isaecomp = ' '
   END IF   
   DISPLAY g_isae_m.isaecomp TO isaecomp
   
   
   

END FUNCTION

################################################################################
# Descriptions...: 所屬稅區
# Memo...........:
# Usage..........: CALL aisi050_isac001_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_isac001_ref()
   
   LET g_isae_m.isac001 =''
   LET g_isae_m.ooall004=''
   
   #稅區   
   SELECT ooef019 INTO g_isae_m.isac001
     FROM ooef_t
    WHERE ooef001 = g_isae_m.isaesite
      AND ooefent = g_enterprise
   DISPLAY g_isae_m.isac001 TO isac001
    
   #稅區說明 
   SELECT ooall004 INTO g_isae_m.ooall004
     FROM ooall_t
    WHERE ooall001 = '2'
      AND ooall002 = g_isae_m.isac001
      AND ooall003 = g_dlang   
      AND ooallent = g_enterprise
  DISPLAY  g_isae_m.ooall004 TO ooall004
          
END FUNCTION

################################################################################
# Descriptions...:  發票類型說明
# Memo...........:
# Usage..........: CALL aisi050_isae004_ref()

# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_isae004_ref()


   SELECT DISTINCT isacl004 INTO g_isae_d[l_ac].isae004_desc
     FROM isac_t 
     LEFT OUTER JOIN isacl_t 
       ON isacent = isaclent 
      AND isac001 = isacl001 
      AND isac002 = isacl002 
      AND isacl003 = g_dlang
    WHERE isacent = g_enterprise
      AND isac001 = g_isae_m.isac001
      AND isac002 = g_isae_d[l_ac].isae004
    ORDER BY isac002
                
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aisi050_user_chk()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION aisi050_user_chk()
 DEFINE l_success  BOOLEAN
   DEFINE l_lsaeld   LIKE glaa_t.glaald 
   DEFINE l_isaecomp LIKE isae_t.isaecomp
   DEFINE l_errno    LIKE type_t.num5
   CALL s_fin_ld_carry('',g_user) RETURNING l_success,l_lsaeld,l_isaecomp,l_errno
   
   RETURN l_isaecomp
END FUNCTION

################################################################################
# Descriptions...: 有效日期區間內不可有相同的簿號
# Memo...........:
# Usage..........: CALL aisi050_isae001_chk(p_isae001)
# Input parameter: p_isae001     發票簿號
#                : p_sdate       起始日期
#                : p_edate       結束日期                    
# Date & Author..: 2016/01/17 By Hans
# Modify.........: #160125-00005#1 
#                  #161101-00068#1 add p_isae002_t,p_isae003_t
################################################################################
PRIVATE FUNCTION aisi050_isae001_chk(p_isae001,p_sdate,p_edate,p_isae002_t,p_isae003_t)
DEFINE p_isae001     LIKE isae_t.isae001
DEFINE p_sdate       LIKE isae_t.isae002
DEFINE p_edate       LIKE isae_t.isae003
DEFINE r_success     LIKE type_t.num5
DEFINE r_errno       LIKE gzze_t.gzze001
DEFINE l_count       LIKE type_t.num5
#161101-00068#1 add ------
DEFINE p_isae002_t   LIKE isae_t.isae002
DEFINE p_isae003_t   LIKE isae_t.isae003
DEFINE l_sql         STRING
#161101-00068#1 add end---
   
   LET r_success = TRUE
   IF NOT cl_null(p_isae001) AND NOT cl_null(p_sdate) AND NOT cl_null(p_edate) THEN
      #161101-00068#1 mark ------
      #SELECT COUNT(*) INTO l_count
      #  FROM isae_t
      # WHERE isaeent = g_enterprise
      #   AND isae001 = p_isae001
      #   #AND (isae002 BETWEEN p_sdate AND p_edate OR isae003 BETWEEN p_sdate AND p_edate)  #161101-00038#1 mark
      #   AND isae002 <= p_sdate 　#161101-00038#1
      #   AND isae003 >= p_edate 　#161101-00038#1
      #161101-00068#1 mark end---
      #161101-00068#1 add ------
      LET l_sql = "SELECT COUNT(1)",
                  "  FROM isae_t",
                  " WHERE isaeent = ",g_enterprise,
                  "   AND isae001 = '",p_isae001,"'",
                  #在別本發票簿區間內/在別本發票簿區間外/在別本發票簿區間內+後外/在別本發票簿區間前外+
                  "   AND ((isae002 < '",p_sdate,"'  AND isae003 >= '",p_sdate,"' AND isae003 <= '",p_edate,"') OR",
                  "        (isae002 >= '",p_sdate,"' AND isae002 <= '",p_edate,"' AND isae003 >= '",p_edate,"') OR",
                  "        (isae002 <= '",p_sdate,"' AND isae003 >= '",p_edate,"') OR",
                  "        (isae002 >= '",p_sdate,"' AND isae003 <= '",p_edate,"')",
                  "   )"
      IF NOT cl_null(p_isae002_t) AND NOT cl_null(p_isae003_t) THEN
        LET l_sql = l_sql," AND isae002 <> '",p_isae002_t,"' AND isae003 <> '",p_isae003_t,"'"
      END IF
      PREPARE isae_pb1 FROM l_sql
      EXECUTE isae_pb1 INTO l_count
      #161101-00068#1 add end---
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count > 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00281'
      END IF
   END IF
   
   RETURN r_success,r_errno
   
END FUNCTION

################################################################################
# Descriptions...: 取紅字發票與藍字發票是否共用
# Memo...........: #161127-00001#1
# Usage..........: CALL aisi050_isai006_info()
# Date & Author..: 2016/12/1 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_isai006_info()

  LET g_isai006  = ''
  SELECT isai006 INTO g_isai006
   FROM isai_t 
  WHERE isaient = g_enterprise
    AND isai001 = g_isae_m.isac001

END FUNCTION

 
{</section>}
 