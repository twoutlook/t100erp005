#該程式未解開Section, 採用最新樣板產出!
{<section id="afat520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-12-09 09:48:18), PR版次:0006(2016-12-12 18:13:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: afat520
#+ Description: 盤點資料清單式維護作業
#+ Creator....: 02114(2015-07-01 17:03:55)
#+ Modifier...: 01531 -SD/PR- 07900
 
{</section>}
 
{<section id="afat520.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#28  2016/04/06 BY 07959    修正azzi920重複定義之錯誤訊息
#160426-00014#33  2016/08/17 BY 02114    修改权限的问题
#160426-00014#23  2016/09/12 By 07900    固定资产的t作业的单身都增加名称与规格二个栏位，取值来源为afai100的faah012,faah013,各单身表栏位直接按现有表依序增加
#161024-00008#5   2016/10/27 By Hans     AFA組織類型與職能開窗清單調整。
#160923-00015#11  2016/12/07 By 01531    单身一增加‘原因码’和‘说明’栏位
#161209-00010#1   2016/12/12 By 07900    盘点单审核产生盘盈亏单后，没关闭单据，然后还可以继续无限次产生盘盈亏单
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
PRIVATE type type_g_fabr_m        RECORD
       fabr001 LIKE fabr_t.fabr001, 
   fabr001_desc LIKE type_t.chr80, 
   fabr002 LIKE fabr_t.fabr002, 
   fabr002_desc LIKE type_t.chr80, 
   fabrcomp LIKE fabr_t.fabrcomp, 
   fabrcomp_desc LIKE type_t.chr80, 
   fabr003 LIKE fabr_t.fabr003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fabr_d        RECORD
       fabr004 LIKE fabr_t.fabr004, 
   fabr007 LIKE fabr_t.fabr007, 
   fabr005 LIKE fabr_t.fabr005, 
   fabr006 LIKE fabr_t.fabr006, 
   l_fabr045 LIKE type_t.chr500, 
   l_fabr046 LIKE type_t.chr500, 
   fabr008 LIKE fabr_t.fabr008, 
   fabr011 LIKE fabr_t.fabr011, 
   fabr012 LIKE fabr_t.fabr012, 
   fabr023 LIKE fabr_t.fabr023, 
   fabr047 LIKE fabr_t.fabr047, 
   fabr047_desc LIKE type_t.chr500, 
   fabr031 LIKE fabr_t.fabr031, 
   fabr032 LIKE fabr_t.fabr032, 
   fabr032_desc LIKE type_t.chr500, 
   l_fabr023 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_fabr2_d RECORD
       fabr004 LIKE fabr_t.fabr004, 
   fabrownid LIKE fabr_t.fabrownid, 
   fabrownid_desc LIKE type_t.chr500, 
   fabrowndp LIKE fabr_t.fabrowndp, 
   fabrowndp_desc LIKE type_t.chr500, 
   fabrcrtid LIKE fabr_t.fabrcrtid, 
   fabrcrtid_desc LIKE type_t.chr500, 
   fabrcrtdp LIKE fabr_t.fabrcrtdp, 
   fabrcrtdp_desc LIKE type_t.chr500, 
   fabrcrtdt DATETIME YEAR TO SECOND, 
   fabrmodid LIKE fabr_t.fabrmodid, 
   fabrmodid_desc LIKE type_t.chr500, 
   fabrmoddt DATETIME YEAR TO SECOND, 
   fabrcnfid LIKE fabr_t.fabrcnfid, 
   fabrcnfid_desc LIKE type_t.chr500, 
   fabrcnfdt DATETIME YEAR TO SECOND, 
   fabrpstid LIKE fabr_t.fabrpstid, 
   fabrpstid_desc LIKE type_t.chr500, 
   fabrpstdt LIKE fabr_t.fabrpstdt
       END RECORD
PRIVATE TYPE type_g_fabr3_d RECORD
       fabt004 LIKE fabt_t.fabt004, 
   fabt005 LIKE fabt_t.fabt005, 
   fabt006 LIKE fabt_t.fabt006, 
   faah012 LIKE type_t.chr500, 
   faah013 LIKE type_t.chr500, 
   fabt008 LIKE fabt_t.fabt008, 
   fabt021 LIKE fabt_t.fabt021, 
   l_count LIKE type_t.num20_6, 
   fabt029 LIKE fabt_t.fabt029, 
   fabt030 LIKE fabt_t.fabt030, 
   fabt030_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_str            STRING                  #160426-00014#33 add lujh
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_fabr_m          type_g_fabr_m
DEFINE g_fabr_m_t        type_g_fabr_m
DEFINE g_fabr_m_o        type_g_fabr_m
DEFINE g_fabr_m_mask_o   type_g_fabr_m #轉換遮罩前資料
DEFINE g_fabr_m_mask_n   type_g_fabr_m #轉換遮罩後資料
 
   DEFINE g_fabr003_t LIKE fabr_t.fabr003
 
 
DEFINE g_fabr_d          DYNAMIC ARRAY OF type_g_fabr_d
DEFINE g_fabr_d_t        type_g_fabr_d
DEFINE g_fabr_d_o        type_g_fabr_d
DEFINE g_fabr_d_mask_o   DYNAMIC ARRAY OF type_g_fabr_d #轉換遮罩前資料
DEFINE g_fabr_d_mask_n   DYNAMIC ARRAY OF type_g_fabr_d #轉換遮罩後資料
DEFINE g_fabr2_d   DYNAMIC ARRAY OF type_g_fabr2_d
DEFINE g_fabr2_d_t type_g_fabr2_d
DEFINE g_fabr2_d_o type_g_fabr2_d
DEFINE g_fabr2_d_mask_o   DYNAMIC ARRAY OF type_g_fabr2_d #轉換遮罩前資料
DEFINE g_fabr2_d_mask_n   DYNAMIC ARRAY OF type_g_fabr2_d #轉換遮罩後資料
DEFINE g_fabr3_d   DYNAMIC ARRAY OF type_g_fabr3_d
DEFINE g_fabr3_d_t type_g_fabr3_d
DEFINE g_fabr3_d_o type_g_fabr3_d
DEFINE g_fabr3_d_mask_o   DYNAMIC ARRAY OF type_g_fabr3_d #轉換遮罩前資料
DEFINE g_fabr3_d_mask_n   DYNAMIC ARRAY OF type_g_fabr3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_fabr003 LIKE fabr_t.fabr003
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
DEFINE g_wc2_table2   STRING
 
 
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
 
{<section id="afat520.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fabr001,'',fabr002,'',fabrcomp,'',fabr003", 
                      " FROM fabr_t",
                      " WHERE fabrent= ? AND fabr003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fabr001,t0.fabr002,t0.fabrcomp,t0.fabr003,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003",
               " FROM fabr_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fabr001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fabr002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.fabrcomp AND t3.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.fabrent = " ||g_enterprise|| " AND t0.fabr003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afat520_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat520 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat520_init()   
 
      #進入選單 Menu (="N")
      CALL afat520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat520
      
   END IF 
   
   CLOSE afat520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat520_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('fabr008','9903') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL afat520_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afat520.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afat520_ui_dialog()
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
   DEFINE l_n       LIKE type_t.num5
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
         INITIALIZE g_fabr_m.* TO NULL
         CALL g_fabr_d.clear()
         CALL g_fabr2_d.clear()
         CALL g_fabr3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afat520_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_fabr_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL afat520_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL afat520_ui_detailshow()
               CALL afat520_b_fill2('2')
 
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
        
         DISPLAY ARRAY g_fabr2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL afat520_idx_chk()
               CALL afat520_ui_detailshow()
               CALL afat520_b_fill2('2')
 
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
 
         
         DISPLAY ARRAY g_fabr3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               CALL afat520_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"
               
               #end add-point
    
            BEFORE DISPLAY 
               #如果一直都在單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd' 
               LET g_current_page = 3               
            
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL afat520_browser_fill("")
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
               CALL afat520_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afat520_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afat520_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat520_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afat520_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat520_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afat520_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat520_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afat520_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat520_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afat520_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat520_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_fabr_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fabr2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_fabr3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD fabr004
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
               CALL afat520_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL afat520_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL afat520_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION confirm
            LET g_action_choice="confirm"
            IF cl_auth_chk_act("confirm") THEN
               
               #add-point:ON ACTION confirm name="menu.confirm"
               #161209-00010#1--add--s--
               #已审核的资料不可再审核
               LET l_n =0
               SELECT COUNT(1) INTO l_n
                 FROM fabr_t
                WHERE fabrent = g_enterprise 
                  AND fabr003 = g_fabr_m.fabr003    
                  AND fabrstus = 'Y'
               IF l_n > 0 THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = g_fabr_m.fabr003
                 LET g_errparam.code   = 'axc-00095'
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err() 
                 EXIT DIALOG
               END IF
               LET l_n = 0
               #161209-00010#1--add--e--
               SELECT COUNT(*) INTO l_n
                 FROM fabr_t
                WHERE fabrent = g_enterprise
                  AND fabr003 = g_fabr_m.fabr003
                  AND fabr023 - fabr012 <> 0
                  
               IF l_n > 0 THEN 
                  IF cl_ask_confirm('afa-01029') THEN
                     CALL afat520_confirm()
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat520_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat520_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afa/afat520_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/afa/afat520_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat520_query()
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
            CALL afat520_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat520_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat520_set_pk_array()
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
 
{<section id="afat520.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION afat520_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat520.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afat520_browser_fill(ps_page_action)
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
   DEFINE l_comp_str        STRING    #160426-00014#33 add lujh
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   #160426-00014#33--add--str--lujh
   CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabr001")
   IF cl_null(g_wc) THEN 
      LET g_wc = l_comp_str
   ELSE
      LET g_wc = g_wc," AND ",l_comp_str
   END IF
   #160426-00014#33--add--end--lujh
   #end add-point    
 
   LET l_searchcol = "fabr003"
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
      LET l_sub_sql = " SELECT DISTINCT fabr003 ",
 
                      " FROM fabr_t ",
                      " ",
                      " ", 
 
                      " ",
 
 
                      " LEFT JOIN fabt_t ON fabtent = fabrent AND fabr003 = fabt002 AND fabr004 = fabt003",
 
 
                      " WHERE fabrent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fabr_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fabr003 ",
 
                      " FROM fabr_t ",
                      " ",
                      " ", 
 
                      " ",
 
 
                      " WHERE fabrent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fabr_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   LET g_sql = g_sql CLIPPED," AND fabrstus = 'N' "
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
      INITIALIZE g_fabr_m.* TO NULL
      CALL g_fabr_d.clear()        
      CALL g_fabr2_d.clear() 
      CALL g_fabr3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fabr003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.fabr003",
                " FROM fabr_t t0",
                #" ",
                " ",
 
                " ",
 
 
                " LEFT JOIN fabt_t ON fabtent = fabrent AND fabr003 = fabt002 AND fabr004 = fabt003",
 
 
                
                " WHERE t0.fabrent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("fabr_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   LET g_sql = g_sql CLIPPED," AND fabrstus = 'N' "
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabr_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_fabr003 
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
   
   IF cl_null(g_browser[g_cnt].b_fabr003) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_fabr_m.* TO NULL
      CALL g_fabr_d.clear()
      CALL g_fabr2_d.clear()
      CALL g_fabr3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL afat520_fetch('')
   
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
 
{<section id="afat520.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afat520_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fabr_m.fabr003 = g_browser[g_current_idx].b_fabr003   
 
   EXECUTE afat520_master_referesh USING g_fabr_m.fabr003 INTO g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp, 
       g_fabr_m.fabr003,g_fabr_m.fabr001_desc,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp_desc
   CALL afat520_show()
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afat520_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat520_ui_browser_refresh()
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
      IF g_browser[l_i].b_fabr003 = g_fabr_m.fabr003 
 
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
 
{<section id="afat520.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat520_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_comp_str     STRING    #160426-00014#33 add lujh
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_fabr_m.* TO NULL
   CALL g_fabr_d.clear()
   CALL g_fabr2_d.clear()
   CALL g_fabr3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   LET g_site_str = NULL      #160426-00014#33 add lujh
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fabr001,fabr002,fabrcomp,fabr003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.fabr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr001
            #add-point:ON ACTION controlp INFIELD fabr001 name="construct.c.fabr001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =" ooef207='Y'"    #160426-00014#33 add lujh
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#5 
            CALL q_ooef001_47()                                   #161024-00008#5 
            DISPLAY g_qryparam.return1 TO fabr001  #顯示到畫面上
            NEXT FIELD fabr001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr001
            #add-point:BEFORE FIELD fabr001 name="construct.b.fabr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr001
            
            #add-point:AFTER FIELD fabr001 name="construct.a.fabr001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr002
            #add-point:ON ACTION controlp INFIELD fabr002 name="construct.c.fabr002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabr002  #顯示到畫面上
            NEXT FIELD fabr002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr002
            #add-point:BEFORE FIELD fabr002 name="construct.b.fabr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr002
            
            #add-point:AFTER FIELD fabr002 name="construct.a.fabr002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabrcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrcomp
            #add-point:ON ACTION controlp INFIELD fabrcomp name="construct.c.fabrcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str      #160426-00014#33 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' AND ",l_comp_str   #160426-00014#33 add lujh
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#5 
            CALL q_ooef001_2()                                   #161024-00008#5 
            DISPLAY g_qryparam.return1 TO fabrcomp  #顯示到畫面上
            NEXT FIELD fabrcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrcomp
            #add-point:BEFORE FIELD fabrcomp name="construct.b.fabrcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrcomp
            
            #add-point:AFTER FIELD fabrcomp name="construct.a.fabrcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr003
            #add-point:BEFORE FIELD fabr003 name="construct.b.fabr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr003
            
            #add-point:AFTER FIELD fabr003 name="construct.a.fabr003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr003
            #add-point:ON ACTION controlp INFIELD fabr003 name="construct.c.fabr003"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON fabr004,fabr007,fabr005,fabr006,l_fabr045,l_fabr046,fabr008,fabr011, 
          fabr012,fabr023,fabr047,fabr031,fabr032,l_fabr023,fabrownid,fabrowndp,fabrcrtid,fabrcrtdp, 
          fabrcrtdt,fabrmodid,fabrmoddt,fabrcnfid,fabrcnfdt,fabrpstid,fabrpstdt
           FROM s_detail1[1].fabr004,s_detail1[1].fabr007,s_detail1[1].fabr005,s_detail1[1].fabr006, 
               s_detail1[1].l_fabr045,s_detail1[1].l_fabr046,s_detail1[1].fabr008,s_detail1[1].fabr011, 
               s_detail1[1].fabr012,s_detail1[1].fabr023,s_detail1[1].fabr047,s_detail1[1].fabr031,s_detail1[1].fabr032, 
               s_detail1[1].l_fabr023,s_detail2[1].fabrownid,s_detail2[1].fabrowndp,s_detail2[1].fabrcrtid, 
               s_detail2[1].fabrcrtdp,s_detail2[1].fabrcrtdt,s_detail2[1].fabrmodid,s_detail2[1].fabrmoddt, 
               s_detail2[1].fabrcnfid,s_detail2[1].fabrcnfdt,s_detail2[1].fabrpstid,s_detail2[1].fabrpstdt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fabrcrtdt>>----
         AFTER FIELD fabrcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fabrmoddt>>----
         AFTER FIELD fabrmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabrcnfdt>>----
         AFTER FIELD fabrcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabrpstdt>>----
         AFTER FIELD fabrpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr004
            #add-point:BEFORE FIELD fabr004 name="construct.b.page1.fabr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr004
            
            #add-point:AFTER FIELD fabr004 name="construct.a.page1.fabr004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr004
            #add-point:ON ACTION controlp INFIELD fabr004 name="construct.c.page1.fabr004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr007
            #add-point:BEFORE FIELD fabr007 name="construct.b.page1.fabr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr007
            
            #add-point:AFTER FIELD fabr007 name="construct.a.page1.fabr007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr007
            #add-point:ON ACTION controlp INFIELD fabr007 name="construct.c.page1.fabr007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr005
            #add-point:BEFORE FIELD fabr005 name="construct.b.page1.fabr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr005
            
            #add-point:AFTER FIELD fabr005 name="construct.a.page1.fabr005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr005
            #add-point:ON ACTION controlp INFIELD fabr005 name="construct.c.page1.fabr005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr006
            #add-point:BEFORE FIELD fabr006 name="construct.b.page1.fabr006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr006
            
            #add-point:AFTER FIELD fabr006 name="construct.a.page1.fabr006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr006
            #add-point:ON ACTION controlp INFIELD fabr006 name="construct.c.page1.fabr006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fabr045
            #add-point:BEFORE FIELD l_fabr045 name="construct.b.page1.l_fabr045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fabr045
            
            #add-point:AFTER FIELD l_fabr045 name="construct.a.page1.l_fabr045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fabr045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fabr045
            #add-point:ON ACTION controlp INFIELD l_fabr045 name="construct.c.page1.l_fabr045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fabr046
            #add-point:BEFORE FIELD l_fabr046 name="construct.b.page1.l_fabr046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fabr046
            
            #add-point:AFTER FIELD l_fabr046 name="construct.a.page1.l_fabr046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fabr046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fabr046
            #add-point:ON ACTION controlp INFIELD l_fabr046 name="construct.c.page1.l_fabr046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr008
            #add-point:BEFORE FIELD fabr008 name="construct.b.page1.fabr008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr008
            
            #add-point:AFTER FIELD fabr008 name="construct.a.page1.fabr008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr008
            #add-point:ON ACTION controlp INFIELD fabr008 name="construct.c.page1.fabr008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr011
            #add-point:BEFORE FIELD fabr011 name="construct.b.page1.fabr011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr011
            
            #add-point:AFTER FIELD fabr011 name="construct.a.page1.fabr011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr011
            #add-point:ON ACTION controlp INFIELD fabr011 name="construct.c.page1.fabr011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr012
            #add-point:BEFORE FIELD fabr012 name="construct.b.page1.fabr012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr012
            
            #add-point:AFTER FIELD fabr012 name="construct.a.page1.fabr012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr012
            #add-point:ON ACTION controlp INFIELD fabr012 name="construct.c.page1.fabr012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr023
            #add-point:BEFORE FIELD fabr023 name="construct.b.page1.fabr023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr023
            
            #add-point:AFTER FIELD fabr023 name="construct.a.page1.fabr023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr023
            #add-point:ON ACTION controlp INFIELD fabr023 name="construct.c.page1.fabr023"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabr047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr047
            #add-point:ON ACTION controlp INFIELD fabr047 name="construct.c.page1.fabr047"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (oocq019 = '24' OR oocq019 = '23')"  #160923-00015#11 add
            CALL q_oocq002_28()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabr047  #顯示到畫面上
            NEXT FIELD fabr047                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr047
            #add-point:BEFORE FIELD fabr047 name="construct.b.page1.fabr047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr047
            
            #add-point:AFTER FIELD fabr047 name="construct.a.page1.fabr047"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr031
            #add-point:BEFORE FIELD fabr031 name="construct.b.page1.fabr031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr031
            
            #add-point:AFTER FIELD fabr031 name="construct.a.page1.fabr031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabr031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr031
            #add-point:ON ACTION controlp INFIELD fabr031 name="construct.c.page1.fabr031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabr032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr032
            #add-point:ON ACTION controlp INFIELD fabr032 name="construct.c.page1.fabr032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabr032  #顯示到畫面上
            NEXT FIELD fabr032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr032
            #add-point:BEFORE FIELD fabr032 name="construct.b.page1.fabr032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr032
            
            #add-point:AFTER FIELD fabr032 name="construct.a.page1.fabr032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fabr023
            #add-point:BEFORE FIELD l_fabr023 name="construct.b.page1.l_fabr023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fabr023
            
            #add-point:AFTER FIELD l_fabr023 name="construct.a.page1.l_fabr023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fabr023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fabr023
            #add-point:ON ACTION controlp INFIELD l_fabr023 name="construct.c.page1.l_fabr023"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabrownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrownid
            #add-point:ON ACTION controlp INFIELD fabrownid name="construct.c.page2.fabrownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabrownid  #顯示到畫面上
            NEXT FIELD fabrownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrownid
            #add-point:BEFORE FIELD fabrownid name="construct.b.page2.fabrownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrownid
            
            #add-point:AFTER FIELD fabrownid name="construct.a.page2.fabrownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabrowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrowndp
            #add-point:ON ACTION controlp INFIELD fabrowndp name="construct.c.page2.fabrowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabrowndp  #顯示到畫面上
            NEXT FIELD fabrowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrowndp
            #add-point:BEFORE FIELD fabrowndp name="construct.b.page2.fabrowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrowndp
            
            #add-point:AFTER FIELD fabrowndp name="construct.a.page2.fabrowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabrcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrcrtid
            #add-point:ON ACTION controlp INFIELD fabrcrtid name="construct.c.page2.fabrcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabrcrtid  #顯示到畫面上
            NEXT FIELD fabrcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrcrtid
            #add-point:BEFORE FIELD fabrcrtid name="construct.b.page2.fabrcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrcrtid
            
            #add-point:AFTER FIELD fabrcrtid name="construct.a.page2.fabrcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabrcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrcrtdp
            #add-point:ON ACTION controlp INFIELD fabrcrtdp name="construct.c.page2.fabrcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabrcrtdp  #顯示到畫面上
            NEXT FIELD fabrcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrcrtdp
            #add-point:BEFORE FIELD fabrcrtdp name="construct.b.page2.fabrcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrcrtdp
            
            #add-point:AFTER FIELD fabrcrtdp name="construct.a.page2.fabrcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrcrtdt
            #add-point:BEFORE FIELD fabrcrtdt name="construct.b.page2.fabrcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabrmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrmodid
            #add-point:ON ACTION controlp INFIELD fabrmodid name="construct.c.page2.fabrmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabrmodid  #顯示到畫面上
            NEXT FIELD fabrmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrmodid
            #add-point:BEFORE FIELD fabrmodid name="construct.b.page2.fabrmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrmodid
            
            #add-point:AFTER FIELD fabrmodid name="construct.a.page2.fabrmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrmoddt
            #add-point:BEFORE FIELD fabrmoddt name="construct.b.page2.fabrmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabrcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrcnfid
            #add-point:ON ACTION controlp INFIELD fabrcnfid name="construct.c.page2.fabrcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabrcnfid  #顯示到畫面上
            NEXT FIELD fabrcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrcnfid
            #add-point:BEFORE FIELD fabrcnfid name="construct.b.page2.fabrcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrcnfid
            
            #add-point:AFTER FIELD fabrcnfid name="construct.a.page2.fabrcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrcnfdt
            #add-point:BEFORE FIELD fabrcnfdt name="construct.b.page2.fabrcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabrpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrpstid
            #add-point:ON ACTION controlp INFIELD fabrpstid name="construct.c.page2.fabrpstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabrpstid  #顯示到畫面上
            NEXT FIELD fabrpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrpstid
            #add-point:BEFORE FIELD fabrpstid name="construct.b.page2.fabrpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrpstid
            
            #add-point:AFTER FIELD fabrpstid name="construct.a.page2.fabrpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrpstdt
            #add-point:BEFORE FIELD fabrpstdt name="construct.b.page2.fabrpstdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
      CONSTRUCT g_wc2_table2 ON fabt004,fabt005,fabt006,faah012,faah013,fabt008,fabt021,l_count,fabt029, 
          fabt030
           FROM s_detail3[1].fabt004,s_detail3[1].fabt005,s_detail3[1].fabt006,s_detail3[1].faah012, 
               s_detail3[1].faah013,s_detail3[1].fabt008,s_detail3[1].fabt021,s_detail3[1].l_count,s_detail3[1].fabt029, 
               s_detail3[1].fabt030
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt004
            #add-point:BEFORE FIELD fabt004 name="construct.b.page3.fabt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt004
            
            #add-point:AFTER FIELD fabt004 name="construct.a.page3.fabt004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt004
            #add-point:ON ACTION controlp INFIELD fabt004 name="construct.c.page3.fabt004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt005
            #add-point:BEFORE FIELD fabt005 name="construct.b.page3.fabt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt005
            
            #add-point:AFTER FIELD fabt005 name="construct.a.page3.fabt005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt005
            #add-point:ON ACTION controlp INFIELD fabt005 name="construct.c.page3.fabt005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt006
            #add-point:BEFORE FIELD fabt006 name="construct.b.page3.fabt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt006
            
            #add-point:AFTER FIELD fabt006 name="construct.a.page3.fabt006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt006
            #add-point:ON ACTION controlp INFIELD fabt006 name="construct.c.page3.fabt006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="construct.b.page3.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="construct.a.page3.faah012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="construct.c.page3.faah012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="construct.b.page3.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="construct.a.page3.faah013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="construct.c.page3.faah013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt008
            #add-point:BEFORE FIELD fabt008 name="construct.b.page3.fabt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt008
            
            #add-point:AFTER FIELD fabt008 name="construct.a.page3.fabt008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt008
            #add-point:ON ACTION controlp INFIELD fabt008 name="construct.c.page3.fabt008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt021
            #add-point:BEFORE FIELD fabt021 name="construct.b.page3.fabt021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt021
            
            #add-point:AFTER FIELD fabt021 name="construct.a.page3.fabt021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabt021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt021
            #add-point:ON ACTION controlp INFIELD fabt021 name="construct.c.page3.fabt021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_count
            #add-point:BEFORE FIELD l_count name="construct.b.page3.l_count"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_count
            
            #add-point:AFTER FIELD l_count name="construct.a.page3.l_count"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.l_count
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_count
            #add-point:ON ACTION controlp INFIELD l_count name="construct.c.page3.l_count"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt029
            #add-point:BEFORE FIELD fabt029 name="construct.b.page3.fabt029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt029
            
            #add-point:AFTER FIELD fabt029 name="construct.a.page3.fabt029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabt029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt029
            #add-point:ON ACTION controlp INFIELD fabt029 name="construct.c.page3.fabt029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fabt030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt030
            #add-point:ON ACTION controlp INFIELD fabt030 name="construct.c.page3.fabt030"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabt030  #顯示到畫面上
            NEXT FIELD fabt030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt030
            #add-point:BEFORE FIELD fabt030 name="construct.b.page3.fabt030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt030
            
            #add-point:AFTER FIELD fabt030 name="construct.a.page3.fabt030"
            
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
 
 
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="afat520.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat520_query()
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
   CALL g_fabr_d.clear()
   CALL g_fabr2_d.clear()
   CALL g_fabr3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL afat520_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat520_browser_fill(g_wc)
      CALL afat520_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL afat520_browser_fill("F")
   
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
      CALL afat520_fetch("F") 
   END IF
   
   CALL afat520_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat520_fetch(p_flag)
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
   
   #CALL afat520_browser_fill(p_flag)
   
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
   
   LET g_fabr_m.fabr003 = g_browser[g_current_idx].b_fabr003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afat520_master_referesh USING g_fabr_m.fabr003 INTO g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp, 
       g_fabr_m.fabr003,g_fabr_m.fabr001_desc,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fabr_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_fabr_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fabr_m_mask_o.* =  g_fabr_m.*
   CALL afat520_fabr_t_mask()
   LET g_fabr_m_mask_n.* =  g_fabr_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL afat520_set_act_visible()
   CALL afat520_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_fabr_m_t.* = g_fabr_m.*
   LET g_fabr_m_o.* = g_fabr_m.*
   
   #重新顯示   
   CALL afat520_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="afat520.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat520_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_fabr_d.clear()
   CALL g_fabr2_d.clear()
   CALL g_fabr3_d.clear()
 
 
   INITIALIZE g_fabr_m.* TO NULL             #DEFAULT 設定
   LET g_fabr003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL afat520_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_fabr_m.* TO NULL
         INITIALIZE g_fabr_d TO NULL
         INITIALIZE g_fabr2_d TO NULL
         INITIALIZE g_fabr3_d TO NULL
 
         CALL afat520_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fabr_m.* = g_fabr_m_t.*
         CALL afat520_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_fabr_d.clear()
      #CALL g_fabr2_d.clear()
      #CALL g_fabr3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL afat520_set_act_visible()
   CALL afat520_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fabr003_t = g_fabr_m.fabr003
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabrent = " ||g_enterprise|| " AND",
                      " fabr003 = '", g_fabr_m.fabr003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat520_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL afat520_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat520_master_referesh USING g_fabr_m.fabr003 INTO g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp, 
       g_fabr_m.fabr003,g_fabr_m.fabr001_desc,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp_desc
   
   #遮罩相關處理
   LET g_fabr_m_mask_o.* =  g_fabr_m.*
   CALL afat520_fabr_t_mask()
   LET g_fabr_m_mask_n.* =  g_fabr_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabr_m.fabr001,g_fabr_m.fabr001_desc,g_fabr_m.fabr002,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp, 
       g_fabr_m.fabrcomp_desc,g_fabr_m.fabr003
   
   #功能已完成,通報訊息中心
   CALL afat520_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat520_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_fabr_m.fabr003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_fabr003_t = g_fabr_m.fabr003
 
   CALL s_transaction_begin()
   
   OPEN afat520_cl USING g_enterprise,g_fabr_m.fabr003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat520_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE afat520_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat520_master_referesh USING g_fabr_m.fabr003 INTO g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp, 
       g_fabr_m.fabr003,g_fabr_m.fabr001_desc,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp_desc
   
   #遮罩相關處理
   LET g_fabr_m_mask_o.* =  g_fabr_m.*
   CALL afat520_fabr_t_mask()
   LET g_fabr_m_mask_n.* =  g_fabr_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL afat520_show()
   WHILE TRUE
      LET g_fabr003_t = g_fabr_m.fabr003
 
 
      #add-point:modify段修改前 name="modify.before_input"
 
      #end add-point
      
      CALL afat520_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fabr_m.* = g_fabr_m_t.*
         CALL afat520_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_fabr_m.fabr003 != g_fabr003_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         UPDATE fabt_t
            SET fabt002 = g_fabr_m.fabr003
 
          WHERE fabtent = g_enterprise AND
                fabt002 = g_fabr003_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabt_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL afat520_set_act_visible()
   CALL afat520_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fabrent = " ||g_enterprise|| " AND",
                      " fabr003 = '", g_fabr_m.fabr003, "' "
 
   #填到對應位置
   CALL afat520_browser_fill("")
 
   CALL afat520_idx_chk()
 
   CLOSE afat520_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat520_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="afat520.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat520_input(p_cmd)
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
   DEFINE  l_oocq019             LIKE oocq_t.oocq019  #160923-00015#11
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
   DISPLAY BY NAME g_fabr_m.fabr001,g_fabr_m.fabr001_desc,g_fabr_m.fabr002,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp, 
       g_fabr_m.fabrcomp_desc,g_fabr_m.fabr003
   
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
   LET g_forupd_sql = "SELECT fabr004,fabr007,fabr005,fabr006,fabr008,fabr011,fabr012,fabr023,fabr047, 
       fabr031,fabr032,fabr004,fabrownid,fabrowndp,fabrcrtid,fabrcrtdp,fabrcrtdt,fabrmodid,fabrmoddt, 
       fabrcnfid,fabrcnfdt,fabrpstid,fabrpstdt FROM fabr_t WHERE fabrent=? AND fabr003=? AND fabr004=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat520_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fabt004,fabt005,fabt006,fabt008,fabt021,fabt029,fabt030 FROM fabt_t WHERE  
       fabtent=? AND fabt002=? AND fabt003=? AND fabt004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat520_bcl2 CURSOR FROM g_forupd_sql
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afat520_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat520_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp,g_fabr_m.fabr003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afat520.input.head" >}
   
      #單頭段
      INPUT BY NAME g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp,g_fabr_m.fabr003 
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
         AFTER FIELD fabr001
            
            #add-point:AFTER FIELD fabr001 name="input.a.fabr001"
            IF NOT cl_null(g_fabr_m.fabr001) THEN
               CALL s_fin_account_center_chk(g_fabr_m.fabr001,'','5',g_today) RETURNING g_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabr_m.fabr001 = g_fabr_m_t.fabr001
                  CALL afat520_ref_show()
                  NEXT FIELD fabr001
               END IF
               #获取法人
               SELECT ooef017 INTO  g_fabr_m.fabrcomp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_fabr_m.fabr001
               CALL afat520_ref_show()
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr001
            #add-point:BEFORE FIELD fabr001 name="input.b.fabr001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr001
            #add-point:ON CHANGE fabr001 name="input.g.fabr001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr002
            
            #add-point:AFTER FIELD fabr002 name="input.a.fabr002"
            IF NOT cl_null(g_fabr_m.fabr002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabr_m.fabr002
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#28  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabr_m.fabr002 = g_fabr_m_t.fabr002
                  CALL afat520_ref_show()
                  NEXT FIELD CURRENT
               END IF
               CALL afat520_ref_show()
            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr002
            #add-point:BEFORE FIELD fabr002 name="input.b.fabr002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr002
            #add-point:ON CHANGE fabr002 name="input.g.fabr002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabrcomp
            
            #add-point:AFTER FIELD fabrcomp name="input.a.fabrcomp"
            IF NOT cl_null(g_fabr_m.fabrcomp) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabr_m.fabrcomp
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補 #160318-00025#28  add
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN #161024-00008#5 
               IF cl_chk_exist("v_ooef001_1") THEN #161024-00008#5 
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabrcomp
            #add-point:BEFORE FIELD fabrcomp name="input.b.fabrcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabrcomp
            #add-point:ON CHANGE fabrcomp name="input.g.fabrcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr003
            #add-point:BEFORE FIELD fabr003 name="input.b.fabr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr003
            
            #add-point:AFTER FIELD fabr003 name="input.a.fabr003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_fabr_m.fabr003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabr_m.fabr003 != g_fabr003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabr_t WHERE "||"fabrent = '" ||g_enterprise|| "' AND "||"fabr003 = '"||g_fabr_m.fabr003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr003
            #add-point:ON CHANGE fabr003 name="input.g.fabr003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr001
            #add-point:ON ACTION controlp INFIELD fabr001 name="input.c.fabr001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabr_m.fabr001             #給予default值
            LET g_qryparam.default2 = "" #g_fabr_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where =" ooef207='Y'"    #160426-00014#33 add lujh
            #CALL q_ooef001()                                #呼叫開窗
            CALL q_ooef001_47()                              #161024-00008#5 

            LET g_fabr_m.fabr001 = g_qryparam.return1              

            DISPLAY g_fabr_m.fabr001 TO fabr001              #
            CALL afat520_ref_show()
            NEXT FIELD fabr001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr002
            #add-point:ON ACTION controlp INFIELD fabr002 name="input.c.fabr002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabr_m.fabr002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooag001()                                #呼叫開窗

            LET g_fabr_m.fabr002 = g_qryparam.return1              

            DISPLAY g_fabr_m.fabr002 TO fabr002              #
            CALL afat520_ref_show()
            NEXT FIELD fabr002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabrcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabrcomp
            #add-point:ON ACTION controlp INFIELD fabrcomp name="input.c.fabrcomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabr_m.fabrcomp             #給予default值
            LET g_qryparam.default2 = "" #g_fabr_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()                                #呼叫開窗 #161024-00008#5
            CALL q_ooef001_2()                                   #161024-00008#5 

            LET g_fabr_m.fabrcomp = g_qryparam.return1              
            #LET g_fabr_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_fabr_m.fabrcomp TO fabrcomp              #
            #DISPLAY g_fabr_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD fabrcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr003
            #add-point:ON ACTION controlp INFIELD fabr003 name="input.c.fabr003"
            
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
            DISPLAY BY NAME g_fabr_m.fabr003             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL afat520_fabr_t_mask_restore('restore_mask_o')
            
               UPDATE fabr_t SET (fabr001,fabr002,fabrcomp,fabr003) = (g_fabr_m.fabr001,g_fabr_m.fabr002, 
                   g_fabr_m.fabrcomp,g_fabr_m.fabr003)
                WHERE fabrent = g_enterprise AND fabr003 = g_fabr003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabr_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabr_m.fabr003
               LET gs_keys_bak[1] = g_fabr003_t
               LET gs_keys[2] = g_fabr_d[g_detail_idx].fabr004
               LET gs_keys_bak[2] = g_fabr_d_t.fabr004
               CALL afat520_update_b('fabr_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_fabr_m_t)
                     #LET g_log2 = util.JSON.stringify(g_fabr_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL afat520_fabr_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL afat520_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_fabr003_t = g_fabr_m.fabr003
 
           
           IF g_fabr_d.getLength() = 0 THEN
              NEXT FIELD fabr004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="afat520.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_fabr_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabr_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat520_b_fill(g_wc2) #test 
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
            CALL afat520_idx_chk()
            CALL afat520_b_fill2('2')
 
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN afat520_cl USING g_enterprise,g_fabr_m.fabr003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE afat520_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN afat520_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_fabr_d[l_ac].fabr004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabr_d_t.* = g_fabr_d[l_ac].*  #BACKUP
               LET g_fabr_d_o.* = g_fabr_d[l_ac].*  #BACKUP
               CALL afat520_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL afat520_set_no_entry_b(l_cmd)
               OPEN afat520_bcl USING g_enterprise,g_fabr_m.fabr003,
 
                                                g_fabr_d_t.fabr004
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN afat520_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat520_bcl INTO g_fabr_d[l_ac].fabr004,g_fabr_d[l_ac].fabr007,g_fabr_d[l_ac].fabr005, 
                      g_fabr_d[l_ac].fabr006,g_fabr_d[l_ac].fabr008,g_fabr_d[l_ac].fabr011,g_fabr_d[l_ac].fabr012, 
                      g_fabr_d[l_ac].fabr023,g_fabr_d[l_ac].fabr047,g_fabr_d[l_ac].fabr031,g_fabr_d[l_ac].fabr032, 
                      g_fabr2_d[l_ac].fabr004,g_fabr2_d[l_ac].fabrownid,g_fabr2_d[l_ac].fabrowndp,g_fabr2_d[l_ac].fabrcrtid, 
                      g_fabr2_d[l_ac].fabrcrtdp,g_fabr2_d[l_ac].fabrcrtdt,g_fabr2_d[l_ac].fabrmodid, 
                      g_fabr2_d[l_ac].fabrmoddt,g_fabr2_d[l_ac].fabrcnfid,g_fabr2_d[l_ac].fabrcnfdt, 
                      g_fabr2_d[l_ac].fabrpstid,g_fabr2_d[l_ac].fabrpstdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_fabr_d_t.fabr004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabr_d_mask_o[l_ac].* =  g_fabr_d[l_ac].*
                  CALL afat520_fabr_t_mask()
                  LET g_fabr_d_mask_n[l_ac].* =  g_fabr_d[l_ac].*
                  
                  CALL afat520_ref_show()
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
            INITIALIZE g_fabr_d_t.* TO NULL
            INITIALIZE g_fabr_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabr_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fabr2_d[l_ac].fabrownid = g_user
      LET g_fabr2_d[l_ac].fabrowndp = g_dept
      LET g_fabr2_d[l_ac].fabrcrtid = g_user
      LET g_fabr2_d[l_ac].fabrcrtdp = g_dept 
      LET g_fabr2_d[l_ac].fabrcrtdt = cl_get_current()
      LET g_fabr2_d[l_ac].fabrmodid = g_user
      LET g_fabr2_d[l_ac].fabrmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_fabr_d_t.* = g_fabr_d[l_ac].*     #新輸入資料
            LET g_fabr_d_o.* = g_fabr_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat520_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL afat520_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabr_d[li_reproduce_target].* = g_fabr_d[li_reproduce].*
               LET g_fabr2_d[li_reproduce_target].* = g_fabr2_d[li_reproduce].*
 
               LET g_fabr_d[g_fabr_d.getLength()].fabr004 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM fabr_t 
             WHERE fabrent = g_enterprise AND fabr003 = g_fabr_m.fabr003
 
               AND fabr004 = g_fabr_d[l_ac].fabr004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO fabr_t
                           (fabrent,
                            fabr001,fabr002,fabrcomp,fabr003,
                            fabr004
                            ,fabr007,fabr005,fabr006,fabr008,fabr011,fabr012,fabr023,fabr047,fabr031,fabr032,fabrownid,fabrowndp,fabrcrtid,fabrcrtdp,fabrcrtdt,fabrmodid,fabrmoddt,fabrcnfid,fabrcnfdt,fabrpstid,fabrpstdt) 
                     VALUES(g_enterprise,
                            g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp,g_fabr_m.fabr003,
                            g_fabr_d[l_ac].fabr004
                            ,g_fabr_d[l_ac].fabr007,g_fabr_d[l_ac].fabr005,g_fabr_d[l_ac].fabr006,g_fabr_d[l_ac].fabr008, 
                                g_fabr_d[l_ac].fabr011,g_fabr_d[l_ac].fabr012,g_fabr_d[l_ac].fabr023, 
                                g_fabr_d[l_ac].fabr047,g_fabr_d[l_ac].fabr031,g_fabr_d[l_ac].fabr032, 
                                g_fabr2_d[l_ac].fabrownid,g_fabr2_d[l_ac].fabrowndp,g_fabr2_d[l_ac].fabrcrtid, 
                                g_fabr2_d[l_ac].fabrcrtdp,g_fabr2_d[l_ac].fabrcrtdt,g_fabr2_d[l_ac].fabrmodid, 
                                g_fabr2_d[l_ac].fabrmoddt,g_fabr2_d[l_ac].fabrcnfid,g_fabr2_d[l_ac].fabrcnfdt, 
                                g_fabr2_d[l_ac].fabrpstid,g_fabr2_d[l_ac].fabrpstdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_fabr_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fabr_t:",SQLERRMESSAGE 
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
               IF afat520_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_fabr_m.fabr003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fabr_d_t.fabr004
 
 
                  #刪除下層單身
                  IF NOT afat520_key_delete_b(gs_keys,'fabr_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE afat520_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE afat520_bcl
               LET l_count = g_fabr_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabr_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr004
            #add-point:BEFORE FIELD fabr004 name="input.b.page1.fabr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr004
            
            #add-point:AFTER FIELD fabr004 name="input.a.page1.fabr004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fabr_m.fabr003 IS NOT NULL AND g_fabr_d[g_detail_idx].fabr004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabr_m.fabr003 != g_fabr003_t OR g_fabr_d[g_detail_idx].fabr004 != g_fabr_d_t.fabr004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabr_t WHERE "||"fabrent = '" ||g_enterprise|| "' AND "||"fabr003 = '"||g_fabr_m.fabr003 ||"' AND "|| "fabr004 = '"||g_fabr_d[g_detail_idx].fabr004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr004
            #add-point:ON CHANGE fabr004 name="input.g.page1.fabr004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr007
            #add-point:BEFORE FIELD fabr007 name="input.b.page1.fabr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr007
            
            #add-point:AFTER FIELD fabr007 name="input.a.page1.fabr007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr007
            #add-point:ON CHANGE fabr007 name="input.g.page1.fabr007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr005
            #add-point:BEFORE FIELD fabr005 name="input.b.page1.fabr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr005
            
            #add-point:AFTER FIELD fabr005 name="input.a.page1.fabr005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr005
            #add-point:ON CHANGE fabr005 name="input.g.page1.fabr005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr006
            #add-point:BEFORE FIELD fabr006 name="input.b.page1.fabr006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr006
            
            #add-point:AFTER FIELD fabr006 name="input.a.page1.fabr006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr006
            #add-point:ON CHANGE fabr006 name="input.g.page1.fabr006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fabr045
            #add-point:BEFORE FIELD l_fabr045 name="input.b.page1.l_fabr045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fabr045
            
            #add-point:AFTER FIELD l_fabr045 name="input.a.page1.l_fabr045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fabr045
            #add-point:ON CHANGE l_fabr045 name="input.g.page1.l_fabr045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fabr046
            #add-point:BEFORE FIELD l_fabr046 name="input.b.page1.l_fabr046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fabr046
            
            #add-point:AFTER FIELD l_fabr046 name="input.a.page1.l_fabr046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fabr046
            #add-point:ON CHANGE l_fabr046 name="input.g.page1.l_fabr046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr008
            #add-point:BEFORE FIELD fabr008 name="input.b.page1.fabr008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr008
            
            #add-point:AFTER FIELD fabr008 name="input.a.page1.fabr008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr008
            #add-point:ON CHANGE fabr008 name="input.g.page1.fabr008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr011
            #add-point:BEFORE FIELD fabr011 name="input.b.page1.fabr011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr011
            
            #add-point:AFTER FIELD fabr011 name="input.a.page1.fabr011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr011
            #add-point:ON CHANGE fabr011 name="input.g.page1.fabr011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr012
            #add-point:BEFORE FIELD fabr012 name="input.b.page1.fabr012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr012
            
            #add-point:AFTER FIELD fabr012 name="input.a.page1.fabr012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr012
            #add-point:ON CHANGE fabr012 name="input.g.page1.fabr012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr023
            #add-point:BEFORE FIELD fabr023 name="input.b.page1.fabr023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr023
            
            #add-point:AFTER FIELD fabr023 name="input.a.page1.fabr023"
            IF NOT cl_null(g_fabr_d[l_ac].fabr023) THEN 
               LET g_fabr_d[l_ac].l_fabr023 = g_fabr_d[l_ac].fabr023 - g_fabr_d[l_ac].fabr012
               #160923-00015#11 add s---
               IF g_fabr_d[l_ac].fabr023 = g_fabr_d[l_ac].fabr012 THEN 
                  CALL cl_set_comp_entry("fabr047",FALSE)
               ELSE
                  CALL cl_set_comp_entry("fabr047",TRUE)
               END IF
               #160923-00015#11 add e---
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr023
            #add-point:ON CHANGE fabr023 name="input.g.page1.fabr023"
            #160923-00015#11 add s---
            IF g_fabr_d[l_ac].fabr023 = g_fabr_d[l_ac].fabr012 THEN 
               CALL cl_set_comp_entry("fabr047",FALSE)
            ELSE
               CALL cl_set_comp_entry("fabr047",TRUE)
            END IF
            #160923-00015#11 add e---
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr047
            
            #add-point:AFTER FIELD fabr047 name="input.a.page1.fabr047"
             #160923-00015#11 add s---
            IF NOT cl_null(g_fabr_d[l_ac].fabr047) THEN
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabr_d[l_ac].fabr047
 
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
 
               IF NOT cl_null(g_fabr_d[l_ac].fabr012) AND NOT cl_null(g_fabr_d[l_ac].fabr023) THEN
                  IF g_fabr_d[l_ac].fabr012 < g_fabr_d[l_ac].fabr023 THEN                 
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_oocq002_3904_2") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
                        CALL afat520_ref_show()
                     ELSE
                        #檢查失敗時後續處理
                        LET g_fabr_d[l_ac].fabr047 = g_fabr_d_t.fabr047
                        CALL afat520_ref_show()
                        NEXT FIELD CURRENT
                     END IF    
                  END IF    
                  IF g_fabr_d[l_ac].fabr012 > g_fabr_d[l_ac].fabr023 THEN                 
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_oocq002_3904_3") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
                        CALL afat520_ref_show()
                     ELSE
                        #檢查失敗時後續處理
                        LET g_fabr_d[l_ac].fabr047 = g_fabr_d_t.fabr047
                        CALL afat520_ref_show()
                        NEXT FIELD CURRENT
                     END IF    
                  END IF 
               ELSE
                  IF cl_chk_exist("v_oocq002_3902") THEN
                     SELECT oocq019 INTO l_oocq019 FROM oocq_t
                      WHERE oocqent = g_enterprise
                        AND oocq001 = '3902'
                        AND oocq002 = g_fabr_d[l_ac].fabr047 
                     IF l_oocq019 <> '23' AND l_oocq019 <> '24' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = "afa-01137"
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()   
                        LET g_fabr_d[l_ac].fabr047 = g_fabr_d_t.fabr047                        
                        CALL afat520_ref_show()
                        NEXT FIELD CURRENT
                     END IF   
                  ELSE   
                     #檢查失敗時後續處理
                     LET g_fabr_d[l_ac].fabr047 = g_fabr_d_t.fabr047
                     CALL afat520_ref_show()
                     NEXT FIELD CURRENT                     
                  END IF                  
               END IF                    
            END IF
            #160923-00015#11 add e---            
            



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr047
            #add-point:BEFORE FIELD fabr047 name="input.b.page1.fabr047"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr047
            #add-point:ON CHANGE fabr047 name="input.g.page1.fabr047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr031
            #add-point:BEFORE FIELD fabr031 name="input.b.page1.fabr031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr031
            
            #add-point:AFTER FIELD fabr031 name="input.a.page1.fabr031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr031
            #add-point:ON CHANGE fabr031 name="input.g.page1.fabr031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabr032
            
            #add-point:AFTER FIELD fabr032 name="input.a.page1.fabr032"
            IF NOT cl_null(g_fabr_d[l_ac].fabr032) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabr_d[l_ac].fabr032
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#28  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabr_d[l_ac].fabr032 = g_fabr_d_t.fabr032
                  CALL afat520_ref_show()
                  NEXT FIELD CURRENT
               END IF
               CALL afat520_ref_show()

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabr032
            #add-point:BEFORE FIELD fabr032 name="input.b.page1.fabr032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabr032
            #add-point:ON CHANGE fabr032 name="input.g.page1.fabr032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fabr023
            #add-point:BEFORE FIELD l_fabr023 name="input.b.page1.l_fabr023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fabr023
            
            #add-point:AFTER FIELD l_fabr023 name="input.a.page1.l_fabr023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fabr023
            #add-point:ON CHANGE l_fabr023 name="input.g.page1.l_fabr023"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fabr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr004
            #add-point:ON ACTION controlp INFIELD fabr004 name="input.c.page1.fabr004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr007
            #add-point:ON ACTION controlp INFIELD fabr007 name="input.c.page1.fabr007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr005
            #add-point:ON ACTION controlp INFIELD fabr005 name="input.c.page1.fabr005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr006
            #add-point:ON ACTION controlp INFIELD fabr006 name="input.c.page1.fabr006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_fabr045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fabr045
            #add-point:ON ACTION controlp INFIELD l_fabr045 name="input.c.page1.l_fabr045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_fabr046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fabr046
            #add-point:ON ACTION controlp INFIELD l_fabr046 name="input.c.page1.l_fabr046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr008
            #add-point:ON ACTION controlp INFIELD fabr008 name="input.c.page1.fabr008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr011
            #add-point:ON ACTION controlp INFIELD fabr011 name="input.c.page1.fabr011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr012
            #add-point:ON ACTION controlp INFIELD fabr012 name="input.c.page1.fabr012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr023
            #add-point:ON ACTION controlp INFIELD fabr023 name="input.c.page1.fabr023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr047
            #add-point:ON ACTION controlp INFIELD fabr047 name="input.c.page1.fabr047"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabr_d[l_ac].fabr047             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #160923-00015#11 add s---
            IF NOT cl_null(g_fabr_d[l_ac].fabr012) AND g_fabr_d[l_ac].fabr023 THEN 
               IF g_fabr_d[l_ac].fabr012 < g_fabr_d[l_ac].fabr023 THEN 
                  LET g_qryparam.where = " oocq019 = '23'"
               ELSE
                  LET g_qryparam.where = " oocq019 = '24'"
               END IF
            ELSE
               LET g_qryparam.where = " (oocq019 = '24' OR oocq019 = '23')" 
            END IF            
            #160923-00015#11 add e---
            CALL q_oocq002_28()                                #呼叫開窗
            CALL afat520_ref_show() #160923-00015#11 add
            LET g_fabr_d[l_ac].fabr047 = g_qryparam.return1              

            DISPLAY g_fabr_d[l_ac].fabr047 TO fabr047              #

            NEXT FIELD fabr047                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr031
            #add-point:ON ACTION controlp INFIELD fabr031 name="input.c.page1.fabr031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabr032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabr032
            #add-point:ON ACTION controlp INFIELD fabr032 name="input.c.page1.fabr032"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabr_d[l_ac].fabr032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooag001()                                #呼叫開窗

            LET g_fabr_d[l_ac].fabr032 = g_qryparam.return1              

            DISPLAY g_fabr_d[l_ac].fabr032 TO fabr032              #
            CALL afat520_ref_show()
            NEXT FIELD fabr032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.l_fabr023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fabr023
            #add-point:ON ACTION controlp INFIELD l_fabr023 name="input.c.page1.l_fabr023"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fabr_d[l_ac].* = g_fabr_d_t.*
               CLOSE afat520_bcl
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
               LET g_errparam.extend = g_fabr_d[l_ac].fabr004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabr_d[l_ac].* = g_fabr_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_fabr2_d[l_ac].fabrmodid = g_user 
LET g_fabr2_d[l_ac].fabrmoddt = cl_get_current()
LET g_fabr2_d[l_ac].fabrmodid_desc = cl_get_username(g_fabr2_d[l_ac].fabrmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL afat520_fabr_t_mask_restore('restore_mask_o')
         
               UPDATE fabr_t SET (fabr003,fabr004,fabr007,fabr005,fabr006,fabr008,fabr011,fabr012,fabr023, 
                   fabr047,fabr031,fabr032,fabrownid,fabrowndp,fabrcrtid,fabrcrtdp,fabrcrtdt,fabrmodid, 
                   fabrmoddt,fabrcnfid,fabrcnfdt,fabrpstid,fabrpstdt) = (g_fabr_m.fabr003,g_fabr_d[l_ac].fabr004, 
                   g_fabr_d[l_ac].fabr007,g_fabr_d[l_ac].fabr005,g_fabr_d[l_ac].fabr006,g_fabr_d[l_ac].fabr008, 
                   g_fabr_d[l_ac].fabr011,g_fabr_d[l_ac].fabr012,g_fabr_d[l_ac].fabr023,g_fabr_d[l_ac].fabr047, 
                   g_fabr_d[l_ac].fabr031,g_fabr_d[l_ac].fabr032,g_fabr2_d[l_ac].fabrownid,g_fabr2_d[l_ac].fabrowndp, 
                   g_fabr2_d[l_ac].fabrcrtid,g_fabr2_d[l_ac].fabrcrtdp,g_fabr2_d[l_ac].fabrcrtdt,g_fabr2_d[l_ac].fabrmodid, 
                   g_fabr2_d[l_ac].fabrmoddt,g_fabr2_d[l_ac].fabrcnfid,g_fabr2_d[l_ac].fabrcnfdt,g_fabr2_d[l_ac].fabrpstid, 
                   g_fabr2_d[l_ac].fabrpstdt)
                WHERE fabrent = g_enterprise AND fabr003 = g_fabr_m.fabr003 
 
                 AND fabr004 = g_fabr_d_t.fabr004 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "fabr_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabr_m.fabr003
               LET gs_keys_bak[1] = g_fabr003_t
               LET gs_keys[2] = g_fabr_d[g_detail_idx].fabr004
               LET gs_keys_bak[2] = g_fabr_d_t.fabr004
               CALL afat520_update_b('fabr_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_fabr_m),util.JSON.stringify(g_fabr_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabr_m),util.JSON.stringify(g_fabr_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat520_fabr_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_fabr_m.fabr003
 
               LET ls_keys[ls_keys.getLength()+1] = g_fabr_d_t.fabr004
 
               CALL afat520_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE afat520_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabr_d[l_ac].* = g_fabr_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE afat520_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_fabr_d.getLength() = 0 THEN
               NEXT FIELD fabr004
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabr_d[li_reproduce_target].* = g_fabr_d[li_reproduce].*
               LET g_fabr2_d[li_reproduce_target].* = g_fabr2_d[li_reproduce].*
 
               LET g_fabr_d[li_reproduce_target].fabr004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabr_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabr_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_fabr2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL afat520_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL afat520_idx_chk()
            CALL afat520_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
      INPUT ARRAY g_fabr3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_fabr_d[g_detail_idx].fabr004) THEN
               NEXT FIELD fabr004
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabr3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_rec_b = g_fabr3_d.getLength()
            #如果一直都在單身則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
            END IF
            LET g_loc = 'd' 
            LET g_current_page = 3
            #add-point:資料輸入前 name="input2.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabr3_d[l_ac].* TO NULL
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_fabr3_d_t.* = g_fabr3_d[l_ac].*     #新輸入資料
            LET g_fabr3_d_o.* = g_fabr3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat520_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL afat520_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabr3_d[li_reproduce_target].* = g_fabr3_d[li_reproduce].*
 
               LET g_fabr3_d[li_reproduce_target].fabt004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input2.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW
            #add-point:before row name="input2.body3.before_row2"
            
            #end add-point
            LET l_insert = FALSE
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
         
            CALL s_transaction_begin()
            OPEN afat520_cl USING g_enterprise,g_fabr_m.fabr003
            #(ver:49) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat520_cl:" 
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE 
               CLOSE afat520_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:49) --- end ---
            OPEN afat520_bcl USING g_enterprise,g_fabr_m.fabr003,g_fabr_d[g_detail_idx].fabr004
            IF SQLCA.SQLCODE THEN   #(ver:49)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat520_bcl:"    #(ver:49)
               LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
               LET g_errparam.popup  = TRUE 
               CLOSE afat520_cl
               CLOSE afat520_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
    
            LET g_rec_b = g_fabr3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabr3_d[l_ac].fabt004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabr3_d_t.* = g_fabr3_d[l_ac].*  #BACKUP
               LET g_fabr3_d_o.* = g_fabr3_d[l_ac].*  #BACKUP
               CALL afat520_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL afat520_set_no_entry_b(l_cmd)
               IF NOT afat520_lock_b("fabt_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat520_bcl2 INTO g_fabr3_d[l_ac].fabt004,g_fabr3_d[l_ac].fabt005,g_fabr3_d[l_ac].fabt006, 
                      g_fabr3_d[l_ac].fabt008,g_fabr3_d[l_ac].fabt021,g_fabr3_d[l_ac].fabt029,g_fabr3_d[l_ac].fabt030 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_fabr3_d_mask_o[l_ac].* =  g_fabr3_d[l_ac].*
                  CALL afat520_fabr_t_mask()
                  LET g_fabr3_d_mask_n[l_ac].* =  g_fabr3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  #CALL afat520_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input2.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
               
               #add-point:單身3刪除前 name="input2.body3.b_delete"
               
               #end add-point    
               
               DELETE FROM fabt_t
                WHERE fabtent = g_enterprise AND fabt002 = g_fabr_m.fabr003 AND fabt003 = g_fabr_d[g_detail_idx].fabr004  
                    AND fabt004 = g_fabr3_d[g_detail_idx2].fabt004
                  
               #add-point:單身3刪除中 name="input2.body3.m_delete"
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabr_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
 
                  #add-point:單身3刪除後 name="input2.body3.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat520_bcl
               LET l_count = g_fabr_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabr_m.fabr003
               LET gs_keys[2] = g_fabr_d[g_detail_idx].fabr004
               LET gs_keys[3] = g_fabr3_d_t.fabt004
 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input2.body3.after_delete"
               
               #end add-point
                              CALL afat520_delete_b('fabt_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabr3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
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
               
            #add-point:單身3新增前 name="input2.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fabt_t 
             WHERE fabtent = g_enterprise AND fabt002 = g_fabr_m.fabr003 AND fabt003 = g_fabr_d[g_detail_idx].fabr004  
                 AND fabt004 = g_fabr3_d[g_detail_idx2].fabt004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input2.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabr_m.fabr003
               LET gs_keys[2] = g_fabr_d[g_detail_idx].fabr004
               LET gs_keys[3] = g_fabr3_d[g_detail_idx2].fabt004
               CALL afat520_insert_b('fabt_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input2.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabr_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat520_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input2.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fabr3_d[l_ac].* = g_fabr3_d_t.*
               CLOSE afat520_bcl2
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
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabr3_d[l_ac].* = g_fabr3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input2.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL afat520_fabt_t_mask_restore('restore_mask_o')
               
               UPDATE fabt_t SET (fabt002,fabt003,fabt004,fabt005,fabt006,fabt008,fabt021,fabt029,fabt030) = (g_fabr_m.fabr003, 
                   g_fabr_d[g_detail_idx].fabr004,g_fabr3_d[l_ac].fabt004,g_fabr3_d[l_ac].fabt005,g_fabr3_d[l_ac].fabt006, 
                   g_fabr3_d[l_ac].fabt008,g_fabr3_d[l_ac].fabt021,g_fabr3_d[l_ac].fabt029,g_fabr3_d[l_ac].fabt030)  
                   #自訂欄位頁簽
                WHERE fabtent = g_enterprise AND fabt002 = g_fabr003_t AND fabt003 = g_fabr_d[g_detail_idx].fabr004  
                    AND fabt004 = g_fabr3_d_t.fabt004
                  
               #add-point:單身page3修改中 name="input2.body3.m_update"
               
               
               #CALL afat520_fabt_t_mask_restore('restore_mask_o')
               #
               #UPDATE fabt_t SET (fabt002,fabt003,fabt004,fabt005,fabt006,fabt008,fabt021,fabt029,fabt030) = (g_fabr3_d[l_ac].fabt002,g_fabr3_d[l_ac].fabt003,g_fabr3_d[l_ac].fabt004, 
               #    g_fabr3_d[l_ac].fabt005,g_fabr3_d[l_ac].fabt006,g_fabr3_d[l_ac].fabt008,g_fabr3_d[l_ac].fabt021, 
               #    g_fabr3_d[l_ac].fabt029,g_fabr3_d[l_ac].fabt030) #自訂欄位頁簽
               # WHERE fabtent = g_enterprise AND fabt002 = g_fabr003_t AND fabt003 = g_fabr_d[g_detail_idx].fabr004  
               #     AND fabt004 = g_fabr3_d_t.fabt004
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_fabr3_d[l_ac].* = g_fabr3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabt_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_fabr3_d[l_ac].* = g_fabr3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabr_m.fabr003
               LET gs_keys_bak[1] = g_fabr003_t
               LET gs_keys[2] = g_fabr_d[g_detail_idx].fabr004
               LET gs_keys_bak[2] = g_fabr_d[g_detail_idx].fabr004
               LET gs_keys[3] = g_fabr3_d[g_detail_idx2].fabt004
               LET gs_keys_bak[3] = g_fabr3_d_t.fabt004
               CALL afat520_update_b('fabt_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_fabr_m),util.JSON.stringify(g_fabr3_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabr_m),util.JSON.stringify(g_fabr3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat520_fabt_t_mask_restore('restore_mask_n')
               
               #add-point:單身page3修改後 name="input2.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt004
            #add-point:BEFORE FIELD fabt004 name="input.b.page3.fabt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt004
            
            #add-point:AFTER FIELD fabt004 name="input.a.page3.fabt004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fabr_m.fabr003 IS NOT NULL AND g_fabr_d[g_detail_idx].fabr004 IS NOT NULL AND g_fabr3_d[g_detail_idx2].fabt004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabr_m.fabr003 != g_fabr003_t OR g_fabr_d[g_detail_idx].fabr004 != g_fabr_d[g_detail_idx].fabr004 OR g_fabr3_d[g_detail_idx2].fabt004 != g_fabr3_d_t.fabt004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabt_t WHERE "||"fabtent = '" ||g_enterprise|| "' AND "||"fabt002 = '"||g_fabr_m.fabr003 ||"' AND "|| "fabt003 = '"||g_fabr_d[g_detail_idx].fabr004 ||"' AND "|| "fabt004 = '"||g_fabr3_d[g_detail_idx2].fabt004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabt004
            #add-point:ON CHANGE fabt004 name="input.g.page3.fabt004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt005
            #add-point:BEFORE FIELD fabt005 name="input.b.page3.fabt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt005
            
            #add-point:AFTER FIELD fabt005 name="input.a.page3.fabt005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabt005
            #add-point:ON CHANGE fabt005 name="input.g.page3.fabt005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt006
            #add-point:BEFORE FIELD fabt006 name="input.b.page3.fabt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt006
            
            #add-point:AFTER FIELD fabt006 name="input.a.page3.fabt006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabt006
            #add-point:ON CHANGE fabt006 name="input.g.page3.fabt006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="input.b.page3.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="input.a.page3.faah012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah012
            #add-point:ON CHANGE faah012 name="input.g.page3.faah012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="input.b.page3.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="input.a.page3.faah013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah013
            #add-point:ON CHANGE faah013 name="input.g.page3.faah013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt008
            #add-point:BEFORE FIELD fabt008 name="input.b.page3.fabt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt008
            
            #add-point:AFTER FIELD fabt008 name="input.a.page3.fabt008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabt008
            #add-point:ON CHANGE fabt008 name="input.g.page3.fabt008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt021
            #add-point:BEFORE FIELD fabt021 name="input.b.page3.fabt021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt021
            
            #add-point:AFTER FIELD fabt021 name="input.a.page3.fabt021"
            IF NOT cl_null(g_fabr3_d[l_ac].fabt021) THEN 
               LET g_fabr3_d[l_ac].l_count = g_fabr3_d[l_ac].fabt021 - g_fabr3_d[l_ac].fabt008
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabt021
            #add-point:ON CHANGE fabt021 name="input.g.page3.fabt021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_count
            #add-point:BEFORE FIELD l_count name="input.b.page3.l_count"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_count
            
            #add-point:AFTER FIELD l_count name="input.a.page3.l_count"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_count
            #add-point:ON CHANGE l_count name="input.g.page3.l_count"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt029
            #add-point:BEFORE FIELD fabt029 name="input.b.page3.fabt029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt029
            
            #add-point:AFTER FIELD fabt029 name="input.a.page3.fabt029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabt029
            #add-point:ON CHANGE fabt029 name="input.g.page3.fabt029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabt030
            
            #add-point:AFTER FIELD fabt030 name="input.a.page3.fabt030"
            IF NOT cl_null(g_fabr3_d[l_ac].fabt030) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabr3_d[l_ac].fabt030
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#28  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabr3_d[l_ac].fabt030 = g_fabr3_d_t.fabt030
                  CALL afat520_ref_show()
                  NEXT FIELD CURRENT 
               END IF
               CALL afat520_ref_show()

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabt030
            #add-point:BEFORE FIELD fabt030 name="input.b.page3.fabt030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabt030
            #add-point:ON CHANGE fabt030 name="input.g.page3.fabt030"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.fabt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt004
            #add-point:ON ACTION controlp INFIELD fabt004 name="input.c.page3.fabt004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt005
            #add-point:ON ACTION controlp INFIELD fabt005 name="input.c.page3.fabt005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt006
            #add-point:ON ACTION controlp INFIELD fabt006 name="input.c.page3.fabt006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="input.c.page3.faah012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="input.c.page3.faah013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt008
            #add-point:ON ACTION controlp INFIELD fabt008 name="input.c.page3.fabt008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabt021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt021
            #add-point:ON ACTION controlp INFIELD fabt021 name="input.c.page3.fabt021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_count
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_count
            #add-point:ON ACTION controlp INFIELD l_count name="input.c.page3.l_count"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabt029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt029
            #add-point:ON ACTION controlp INFIELD fabt029 name="input.c.page3.fabt029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabt030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabt030
            #add-point:ON ACTION controlp INFIELD fabt030 name="input.c.page3.fabt030"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabr3_d[l_ac].fabt030             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooag001()                                #呼叫開窗

            LET g_fabr3_d[l_ac].fabt030 = g_qryparam.return1              

            DISPLAY g_fabr3_d[l_ac].fabt030 TO fabt030              #
            CALL afat520_ref_show()
            NEXT FIELD fabt030                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3_after_row name="input2.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabr3_d[l_ac].* = g_fabr3_d_t.*
               END IF
               CLOSE afat520_bcl2
               CLOSE afat520_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afat520_unlock_b("fabt_t","'3'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input2.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabr3_d[li_reproduce_target].* = g_fabr3_d[li_reproduce].*
 
               LET g_fabr3_d[li_reproduce_target].fabt004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabr3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabr3_d.getLength()+1
            END IF
      END INPUT
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx2)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD fabr003
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fabr004
               WHEN "s_detail2"
                  NEXT FIELD fabr004_2
               WHEN "s_detail3"
                  NEXT FIELD fabt004
 
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
 
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afat520_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL afat520_b_fill(g_wc2) #第一階單身填充
      CALL afat520_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat520_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_fabr_m.fabr001,g_fabr_m.fabr001_desc,g_fabr_m.fabr002,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp, 
       g_fabr_m.fabrcomp_desc,g_fabr_m.fabr003
 
   CALL afat520_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION afat520_ref_show()
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
   LET g_ref_fields[1] = g_fabr_m.fabr001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabr_m.fabr001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabr_m.fabr001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabr_m.fabr002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabr_m.fabr002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabr_m.fabr002_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabr_m.fabrcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabr_m.fabrcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabr_m.fabrcomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabr_d[l_ac].fabr032
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabr_d[l_ac].fabr032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabr_d[l_ac].fabr032_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabr3_d[l_ac].fabt030
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabr3_d[l_ac].fabt030_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabr3_d[l_ac].fabt030_desc
   
   #160923-00015#11 add s---
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabr_d[l_ac].fabr047
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='3902' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabr_d[l_ac].fabr047_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabr_d[l_ac].fabr047_desc
   #160923-00015#11 add e---          
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_fabr_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fabr2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fabr3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="afat520.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat520_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fabr_t.fabr003 
   DEFINE l_oldno     LIKE fabr_t.fabr003 
 
   DEFINE l_master    RECORD LIKE fabr_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fabr_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE fabt_t.* #此變數樣板目前無使用
 
 
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
 
   IF g_fabr_m.fabr003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_fabr003_t = g_fabr_m.fabr003
 
   
   LET g_fabr_m.fabr003 = ""
 
   LET g_master_insert = FALSE
   CALL afat520_set_entry('a')
   CALL afat520_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
   
   
   CALL afat520_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_fabr_m.* TO NULL
      INITIALIZE g_fabr_d TO NULL
      INITIALIZE g_fabr2_d TO NULL
      INITIALIZE g_fabr3_d TO NULL
 
      CALL afat520_show()
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
   CALL afat520_set_act_visible()
   CALL afat520_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fabr003_t = g_fabr_m.fabr003
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabrent = " ||g_enterprise|| " AND",
                      " fabr003 = '", g_fabr_m.fabr003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat520_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL afat520_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL afat520_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afat520_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fabr_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE fabt_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afat520_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fabr_t
    WHERE fabrent = g_enterprise AND fabr003 = g_fabr003_t
 
       INTO TEMP afat520_detail
   
   #將key修正為調整後   
   UPDATE afat520_detail 
      #更新key欄位
      SET fabr003 = g_fabr_m.fabr003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , fabrownid = g_user 
       , fabrowndp = g_dept
       , fabrcrtid = g_user
       , fabrcrtdp = g_dept 
       , fabrcrtdt = ld_date
       , fabrmodid = g_user
       , fabrmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO fabr_t SELECT * FROM afat520_detail
   
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
   DROP TABLE afat520_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fabt_t
    WHERE fabtent = g_enterprise AND fabt002 = g_fabr003_t
 
   INTO TEMP afat520_detail
   
   #將key修正為調整後   
   UPDATE afat520_detail SET fabt002 = g_fabr_m.fabr003
 
  
   #將資料塞回原table   
   INSERT INTO fabt_t SELECT * FROM afat520_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afat520_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fabr003_t = g_fabr_m.fabr003
 
   
   DROP TABLE afat520_detail
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat520_delete()
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
   
   IF g_fabr_m.fabr003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN afat520_cl USING g_enterprise,g_fabr_m.fabr003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat520_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE afat520_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat520_master_referesh USING g_fabr_m.fabr003 INTO g_fabr_m.fabr001,g_fabr_m.fabr002,g_fabr_m.fabrcomp, 
       g_fabr_m.fabr003,g_fabr_m.fabr001_desc,g_fabr_m.fabr002_desc,g_fabr_m.fabrcomp_desc
   
   #遮罩相關處理
   LET g_fabr_m_mask_o.* =  g_fabr_m.*
   CALL afat520_fabr_t_mask()
   LET g_fabr_m_mask_n.* =  g_fabr_m.*
   
   CALL afat520_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat520_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fabr_t WHERE fabrent = g_enterprise AND fabr003 = g_fabr_m.fabr003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabr_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM fabt_t
       WHERE fabtent = g_enterprise AND
             fabt002 = g_fabr_m.fabr003
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabr_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE afat520_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_fabr_d.clear() 
      CALL g_fabr2_d.clear()       
      CALL g_fabr3_d.clear()       
 
     
      CALL afat520_ui_browser_refresh()  
      #CALL afat520_ui_headershow()  
      #CALL afat520_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL afat520_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL afat520_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE afat520_cl
 
   #功能已完成,通報訊息中心
   CALL afat520_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afat520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat520_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_fabr_d.clear()
   CALL g_fabr2_d.clear()
   CALL g_fabr3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT fabr004,fabr007,fabr005,fabr006,fabr008,fabr011,fabr012,fabr023,fabr047, 
       fabr031,fabr032,fabr004,fabrownid,fabrowndp,fabrcrtid,fabrcrtdp,fabrcrtdt,fabrmodid,fabrmoddt, 
       fabrcnfid,fabrcnfdt,fabrpstid,fabrpstdt,t1.oocql004 ,t2.ooag011 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooefl003 ,t7.ooag011 ,t8.ooag011 ,t9.ooag011 FROM fabr_t",   
               "",
               " LEFT JOIN fabt_t ON fabrent = fabtent AND fabr003 = fabt002 AND fabr004 = fabt003 ",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='3902' AND t1.oocql002=fabr047 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag011=fabr032  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=fabrownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=fabrowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=fabrcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=fabrcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=fabrmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=fabrcnfid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=fabrpstid  ",
 
               " WHERE fabrent= ? AND fabr003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("fabr_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
      IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
 
   
   #判斷是否填充
   IF afat520_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY fabr_t.fabr004"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat520_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afat520_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fabr_m.fabr003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fabr_m.fabr003 INTO g_fabr_d[l_ac].fabr004,g_fabr_d[l_ac].fabr007, 
          g_fabr_d[l_ac].fabr005,g_fabr_d[l_ac].fabr006,g_fabr_d[l_ac].fabr008,g_fabr_d[l_ac].fabr011, 
          g_fabr_d[l_ac].fabr012,g_fabr_d[l_ac].fabr023,g_fabr_d[l_ac].fabr047,g_fabr_d[l_ac].fabr031, 
          g_fabr_d[l_ac].fabr032,g_fabr2_d[l_ac].fabr004,g_fabr2_d[l_ac].fabrownid,g_fabr2_d[l_ac].fabrowndp, 
          g_fabr2_d[l_ac].fabrcrtid,g_fabr2_d[l_ac].fabrcrtdp,g_fabr2_d[l_ac].fabrcrtdt,g_fabr2_d[l_ac].fabrmodid, 
          g_fabr2_d[l_ac].fabrmoddt,g_fabr2_d[l_ac].fabrcnfid,g_fabr2_d[l_ac].fabrcnfdt,g_fabr2_d[l_ac].fabrpstid, 
          g_fabr2_d[l_ac].fabrpstdt,g_fabr_d[l_ac].fabr047_desc,g_fabr_d[l_ac].fabr032_desc,g_fabr2_d[l_ac].fabrownid_desc, 
          g_fabr2_d[l_ac].fabrowndp_desc,g_fabr2_d[l_ac].fabrcrtid_desc,g_fabr2_d[l_ac].fabrcrtdp_desc, 
          g_fabr2_d[l_ac].fabrmodid_desc,g_fabr2_d[l_ac].fabrcnfid_desc,g_fabr2_d[l_ac].fabrpstid_desc  
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
         #160426-00014#23 --mark--s---
#         SELECT faah012,faah013 INTO g_fabr_d[l_ac].l_faah012,g_fabr_d[l_ac].l_faah013  
#           FROM faah_t
#          WHERE faahent = g_enterprise
#            AND faah001 = g_fabr_d[l_ac].fabr007
#            AND faah003 = g_fabr_d[l_ac].fabr005
#            AND faah004 = g_fabr_d[l_ac].fabr006
         #160426-00014#23 ---mark--e--   
         #160426-00014#23 ---add--s--  
         SELECT fabr045,fabr046 INTO g_fabr_d[l_ac].l_fabr045,g_fabr_d[l_ac].l_fabr046
           FROM fabr_t
          WHERE fabrent = g_enterprise
            AND fabr003 = g_fabr_m.fabr003
            AND fabr004 = g_fabr_d[l_ac].fabr004
         #160426-00014#23 ---add--s--         
         
         LET g_fabr_d[l_ac].l_fabr023 = g_fabr_d[l_ac].fabr023 - g_fabr_d[l_ac].fabr012
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
 
            CALL g_fabr_d.deleteElement(g_fabr_d.getLength())
      CALL g_fabr2_d.deleteElement(g_fabr2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_fabr_d.getLength()
      LET g_fabr_d_mask_o[l_ac].* =  g_fabr_d[l_ac].*
      CALL afat520_fabr_t_mask()
      LET g_fabr_d_mask_n[l_ac].* =  g_fabr_d[l_ac].*
   END FOR
   
   LET g_fabr2_d_mask_o.* =  g_fabr2_d.*
   FOR l_ac = 1 TO g_fabr2_d.getLength()
      LET g_fabr2_d_mask_o[l_ac].* =  g_fabr2_d[l_ac].*
      CALL afat520_fabr_t_mask()
      LET g_fabr2_d_mask_n[l_ac].* =  g_fabr2_d[l_ac].*
   END FOR
   LET g_fabr3_d_mask_o.* =  g_fabr3_d.*
   FOR l_ac = 1 TO g_fabr3_d.getLength()
      LET g_fabr3_d_mask_o[l_ac].* =  g_fabr3_d[l_ac].*
      CALL afat520_fabt_t_mask()
      LET g_fabr3_d_mask_n[l_ac].* =  g_fabr3_d[l_ac].*
   END FOR
 
 
   FREE afat520_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afat520_idx_chk()
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
      IF g_detail_idx > g_fabr_d.getLength() THEN
         LET g_detail_idx = g_fabr_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_fabr_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabr_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fabr2_d.getLength() THEN
         LET g_detail_idx = g_fabr2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabr2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabr2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_fabr3_d.getLength() THEN
         LET g_detail_idx2 = g_fabr3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_fabr3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_fabr3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afat520_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_fabr_d.getLength() <= 0 THEN
      RETURN
   END IF
   
   IF afat520_fill_chk(2) THEN
      IF pi_idx = 2 OR pi_idx = 0 THEN
         IF (g_action_choice = "query" OR cl_null(g_action_choice))
            #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
            
            #end add-point
         THEN
                  CALL g_fabr3_d.clear()
 
            LET g_sql = "SELECT  DISTINCT fabt004,fabt005,fabt006,fabt008,fabt021,fabt029,fabt030,t10.ooag011 FROM fabt_t", 
                    
                        "",
                                       " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag011=fabt030  ",
 
                        " WHERE fabtent=? AND fabt002=? AND fabt003=?"
            
            IF NOT cl_null(g_wc2_table2) THEN
               LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED, cl_sql_add_filter("fabt_t")
            END IF
            
            LET g_sql = g_sql, " ORDER BY  fabt_t.fabt004" 
                               
            #add-point:單身填充前 name="b_fill2.before_fill2"
            
            #end add-point
            LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
            PREPARE afat520_pb2 FROM g_sql
            DECLARE b_fill_curs2 CURSOR FOR afat520_pb2
         END IF
         
      #  OPEN b_fill_curs2 USING g_enterprise,   #(ver:49)
      #                                 g_fabr_m.fabr003,g_fabr_d[g_detail_idx].fabr004   #(ver:49)
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_fabr_m.fabr003,g_fabr_d[g_detail_idx].fabr004 INTO g_fabr3_d[l_ac].fabt004, 
             g_fabr3_d[l_ac].fabt005,g_fabr3_d[l_ac].fabt006,g_fabr3_d[l_ac].fabt008,g_fabr3_d[l_ac].fabt021, 
             g_fabr3_d[l_ac].fabt029,g_fabr3_d[l_ac].fabt030,g_fabr3_d[l_ac].fabt030_desc   #(ver:49) 
 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            LET g_fabr3_d[l_ac].faah012 = g_fabr_d[g_detail_idx].l_fabr045   #160426-00014#23 mod g_fabr_d[g_detail_idx].l_faah012 ->g_fabr_d[g_detail_idx].l_fabr045
            LET g_fabr3_d[l_ac].faah013 = g_fabr_d[g_detail_idx].l_fabr046   #160426-00014#23 mod g_fabr_d[g_detail_idx].l_faah013 ->g_fabr_d[g_detail_idx].l_fabr046
            
            LET g_fabr3_d[l_ac].l_count = g_fabr3_d[l_ac].fabt021 - g_fabr3_d[l_ac].fabt008
            #end add-point
           
            LET l_ac = l_ac + 1
            IF l_ac > g_max_rec THEN
               EXIT FOREACH
            END IF
            
         END FOREACH
         
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF      
         
               CALL g_fabr3_d.deleteElement(g_fabr3_d.getLength())
 
 
      END IF
   END IF
 
 
      
   LET g_fabr3_d_mask_o.* =  g_fabr3_d.*
   FOR l_ac = 1 TO g_fabr3_d.getLength()
      LET g_fabr3_d_mask_o[l_ac].* =  g_fabr3_d[l_ac].*
      CALL afat520_fabt_t_mask()
      LET g_fabr3_d_mask_n[l_ac].* =  g_fabr3_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION afat520_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM fabr_t
    WHERE fabrent = g_enterprise AND fabr003 = g_fabr_m.fabr003 AND
 
          fabr004 = g_fabr_d_t.fabr004
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fabr_t:",SQLERRMESSAGE 
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
 
{<section id="afat520.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat520_delete_b(ps_table,ps_keys_bak,ps_page)
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
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM fabt_t
       WHERE fabtent = g_enterprise AND fabt002 = ps_keys_bak[1] AND fabt003 = ps_keys_bak[2] AND fabt004 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat520_insert_b(ps_table,ps_keys,ps_page)
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
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO fabt_t
                  (fabtent,
                   fabt002,fabt003,
                   fabt004
                   ,fabt005,fabt006,fabt008,fabt021,fabt029,fabt030) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fabr3_d[g_detail_idx2].fabt005,g_fabr3_d[g_detail_idx2].fabt006,g_fabr3_d[g_detail_idx2].fabt008, 
                       g_fabr3_d[g_detail_idx2].fabt021,g_fabr3_d[g_detail_idx2].fabt029,g_fabr3_d[g_detail_idx2].fabt030) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat520_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabr_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
 
      #將遮罩欄位還原
      CALL afat520_fabt_t_mask_restore('restore_mask_o')
               
      UPDATE fabt_t 
         SET (fabt002,fabt003,
              fabt004
              ,fabt005,fabt006,fabt008,fabt021,fabt029,fabt030) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabr3_d[g_detail_idx2].fabt005,g_fabr3_d[g_detail_idx2].fabt006,g_fabr3_d[g_detail_idx2].fabt008, 
                  g_fabr3_d[g_detail_idx2].fabt021,g_fabr3_d[g_detail_idx2].fabt029,g_fabr3_d[g_detail_idx2].fabt030)  
 
         WHERE fabtent = g_enterprise AND fabt002 = ps_keys_bak[1] AND fabt003 = ps_keys_bak[2] AND fabt004 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #INITIALIZE g_errparam TO NULL 
            #LET g_errparam.extend = "fabt_t" 
            #LET g_errparam.code   = "std-00009" 
            #LET g_errparam.popup  = TRUE 
            #CALL cl_err()
            #CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat520_fabt_t_mask_restore('restore_mask_n')
      
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION afat520_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_fabr_d[l_ac].fabr004 = g_fabr_d_t.fabr004 
 
      THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE fabt_t 
      SET (fabt002,fabt003) 
           = 
          (g_fabr_m.fabr003,g_fabr_d[g_detail_idx].fabr004) 
      WHERE fabtent = g_enterprise AND
            fabt002 = ps_keys_bak[1] AND fabt003 = ps_keys_bak[2]
 
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後 name="key_update_b.after_update2"
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afat520_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
   #如果是上層單身則進行delete
   IF ps_table = 'fabr_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM fabt_t 
            WHERE fabtent = g_enterprise AND
                  fabt002 = ps_keys_bak[1] AND fabt003 = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabt_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
      
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat520_lock_b(ps_table,ps_page)
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
   #CALL afat520_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "fabt_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat520_bcl2 USING g_enterprise,
                                             g_fabr_m.fabr003,g_fabr_d[g_detail_idx].fabr004,
                                             g_fabr3_d[g_detail_idx2].fabt004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat520_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat520.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat520_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat520_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat520.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat520_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fabr003",TRUE)
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
 
{<section id="afat520.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat520_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fabr003",FALSE)
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
 
{<section id="afat520.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat520_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   #160923-00015#11 add s---
   IF g_fabr_d[l_ac].fabr023 <> g_fabr_d[l_ac].fabr012 THEN 
      CALL cl_set_comp_entry("fabr047",TRUE)
   END IF
   #160923-00015#11 add e---
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat520_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   #160923-00015#11 add s---
   IF g_fabr_d[l_ac].fabr023 = g_fabr_d[l_ac].fabr012 THEN 
      CALL cl_set_comp_entry("fabr047",FALSE)
   END IF
   #160923-00015#11 add e---
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat520_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat520.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat520_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat520.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afat520_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat520.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afat520_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat520.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat520_default_search()
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
      LET ls_wc = ls_wc, " fabr003 = '", g_argv[01], "' AND "
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
 
{<section id="afat520.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afat520_fill_chk(ps_idx)
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
 
{<section id="afat520.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION afat520_modify_detail_chk(ps_record)
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
         LET ls_return = "fabr004"
      WHEN "s_detail2"
         LET ls_return = "fabr004_2"
      WHEN "s_detail3"
         LET ls_return = "fabt004"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="afat520.mask_functions" >}
&include "erp/afa/afat520_mask.4gl"
 
{</section>}
 
{<section id="afat520.state_change" >}
    
 
{</section>}
 
{<section id="afat520.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat520_set_pk_array()
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
   LET g_pk_array[1].values = g_fabr_m.fabr003
   LET g_pk_array[1].column = 'fabr003'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat520.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat520_msgcentre_notify(lc_state)
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
   CALL afat520_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fabr_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat520.other_function" readonly="Y" >}
# 審核
PRIVATE FUNCTION afat520_confirm()
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_ld          LIKE glaa_t.glaald
   DEFINE l_docno1      LIKE fabg_t.fabgdocno
   DEFINE l_docno2      LIKE fabg_t.fabgdocno
   DEFINE l_docdt       LIKE fabg_t.fabgdocdt
   DEFINE r_docno1      LIKE fabg_t.fabgdocno
   DEFINE r_docno2      LIKE fabg_t.fabgdocno
   DEFINE r_success1    LIKE type_t.num5
   DEFINE r_success2    LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   
   LET r_success1 = TRUE
   LET r_success2 = TRUE
   LET l_success = TRUE
   LET r_docno1 = ''
   LET r_docno2 = ''
   
      
   CALL afat520_01(g_fabr_m.fabr003,g_fabr_m.fabrcomp) RETURNING l_ld,l_docno1,l_docno2,l_docdt
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()  
   
   #是否有盘盈
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM fabr_t
    WHERE fabrent = g_enterprise
      AND fabr003 = g_fabr_m.fabr003
      AND fabr023 - fabr012 > 0
      
   IF l_n > 0 THEN 
      CALL s_afat520_ins_a(g_fabr_m.fabr001,g_fabr_m.fabrcomp,g_fabr_m.fabr003,'',l_ld,l_docno1,l_docno2,l_docdt,'afat513')
      RETURNING r_success1,r_docno1
      
      IF r_success1 = FALSE THEN 
         LET l_success = FALSE
      END IF
   END IF
   
   #是否有盘盈
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM fabr_t
    WHERE fabrent = g_enterprise
      AND fabr003 = g_fabr_m.fabr003
      AND fabr023 - fabr012 < 0
      
   IF l_n > 0 THEN 
      CALL s_afat520_ins_a(g_fabr_m.fabr001,g_fabr_m.fabrcomp,g_fabr_m.fabr003,'',l_ld,l_docno1,l_docno2,l_docdt,'afat514')
      RETURNING r_success2,r_docno2
      
      IF r_success2 = FALSE THEN 
         LET l_success = FALSE
      END IF
   END IF
   
   UPDATE fabr_t SET fabrstus = 'Y'
    WHERE fabrent = g_enterprise
      AND fabr003 = g_fabr_m.fabr003
     
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd fabr_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_success = FALSE
   END IF
   
   IF l_success = FALSE  THEN
      CALL cl_err_collect_show() 
      CALL s_transaction_end('N','0') 
      RETURN    
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00322'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      IF NOT cl_null(r_docno1) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-01031'
         LET g_errparam.replace[1] = r_docno1
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      IF NOT cl_null(r_docno2) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-01032'
         LET g_errparam.replace[1] = r_docno2
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      CALL cl_err_collect_show()    
      CALL s_transaction_end('Y','0')    
   END IF 
   
END FUNCTION

 
{</section>}
 
