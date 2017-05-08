#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq542.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-09-12 16:46:04), PR版次:0002(2016-10-21 15:50:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000009
#+ Filename...: axcq542
#+ Description: 在製轉出成本與工單入庫標準成本差異查詢作業
#+ Creator....: 02295(2016-09-12 16:46:04)
#+ Modifier...: 02295 -SD/PR- 02294
 
{</section>}
 
{<section id="axcq542.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#161019-00017#5  2016/10/21 By lixiang  调整组织栏位的开窗
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
PRIVATE type type_g_xccn_m        RECORD
       xccncomp LIKE xccn_t.xccncomp, 
   xccncomp_desc LIKE type_t.chr80, 
   xccnld LIKE xccn_t.xccnld, 
   xccnld_desc LIKE type_t.chr80, 
   xccn004 LIKE xccn_t.xccn004, 
   xccn005 LIKE xccn_t.xccn005, 
   xccn004_1 LIKE type_t.num5, 
   xccn005_1 LIKE type_t.num5, 
   xccn003 LIKE xccn_t.xccn003, 
   xccn003_desc LIKE type_t.chr80, 
   xccn001 LIKE xccn_t.xccn001, 
   xccn001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccn_d        RECORD
       xccn002 LIKE xccn_t.xccn002, 
   xccn002_desc LIKE type_t.chr500, 
   xccn006 LIKE xccn_t.xccn006, 
   imag011 LIKE imag_t.imag011, 
   imag011_desc LIKE type_t.chr500, 
   xccd007 LIKE xccd_t.xccd007, 
   xccd007_desc LIKE type_t.chr500, 
   xccd007_desc_1 LIKE type_t.chr500, 
   xccn102 LIKE xccn_t.xccn102, 
   xccn102a LIKE xccn_t.xccn102a, 
   xccn102b LIKE xccn_t.xccn102b, 
   xccn102c LIKE xccn_t.xccn102c, 
   xccn102d LIKE xccn_t.xccn102d, 
   xccn102e LIKE xccn_t.xccn102e, 
   xccn102f LIKE xccn_t.xccn102f, 
   xccn102g LIKE xccn_t.xccn102g, 
   xccn102h LIKE xccn_t.xccn102h, 
   xccn202 LIKE xccn_t.xccn202, 
   xccn202a LIKE xccn_t.xccn202a, 
   xccn202b LIKE xccn_t.xccn202b, 
   xccn202c LIKE xccn_t.xccn202c, 
   xccn202d LIKE xccn_t.xccn202d, 
   xccn202e LIKE xccn_t.xccn202e, 
   xccn202f LIKE xccn_t.xccn202f, 
   xccn202g LIKE xccn_t.xccn202g, 
   xccn202h LIKE xccn_t.xccn202h, 
   xccn302 LIKE xccn_t.xccn302, 
   xccn302a LIKE xccn_t.xccn302a, 
   xccn302b LIKE xccn_t.xccn302b, 
   xccn302c LIKE xccn_t.xccn302c, 
   xccn302d LIKE xccn_t.xccn302d, 
   xccn302e LIKE xccn_t.xccn302e, 
   xccn302f LIKE xccn_t.xccn302f, 
   xccn302g LIKE xccn_t.xccn302g, 
   xccn302h LIKE xccn_t.xccn302h
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_detail_multi_table_t    RECORD
      imag001 LIKE imag_t.imag001,
      imag011 LIKE imag_t.imag011,
      xccdld LIKE xccd_t.xccdld,
      xccd001 LIKE xccd_t.xccd001,
      xccd002 LIKE xccd_t.xccd002,
      xccd003 LIKE xccd_t.xccd003,
      xccd004 LIKE xccd_t.xccd004,
      xccd005 LIKE xccd_t.xccd005,
      xccd006 LIKE xccd_t.xccd006,
      xccd007 LIKE xccd_t.xccd007
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_xccn_m          type_g_xccn_m
DEFINE g_xccn_m_t        type_g_xccn_m
DEFINE g_xccn_m_o        type_g_xccn_m
DEFINE g_xccn_m_mask_o   type_g_xccn_m #轉換遮罩前資料
DEFINE g_xccn_m_mask_n   type_g_xccn_m #轉換遮罩後資料
 
   DEFINE g_xccnld_t LIKE xccn_t.xccnld
DEFINE g_xccn004_t LIKE xccn_t.xccn004
DEFINE g_xccn005_t LIKE xccn_t.xccn005
DEFINE g_xccn003_t LIKE xccn_t.xccn003
DEFINE g_xccn001_t LIKE xccn_t.xccn001
 
 
DEFINE g_xccn_d          DYNAMIC ARRAY OF type_g_xccn_d
DEFINE g_xccn_d_t        type_g_xccn_d
DEFINE g_xccn_d_o        type_g_xccn_d
DEFINE g_xccn_d_mask_o   DYNAMIC ARRAY OF type_g_xccn_d #轉換遮罩前資料
DEFINE g_xccn_d_mask_n   DYNAMIC ARRAY OF type_g_xccn_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccnld LIKE xccn_t.xccnld,
      b_xccn001 LIKE xccn_t.xccn001,
      b_xccn003 LIKE xccn_t.xccn003,
      b_xccn004 LIKE xccn_t.xccn004,
      b_xccn005 LIKE xccn_t.xccn005
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
DEFINE g_yy1          LIKE type_t.num5
DEFINE g_mm1          LIKE type_t.num5
DEFINE g_yy2          LIKE type_t.num5
DEFINE g_mm2          LIKE type_t.num5
DEFINE g_para_data    LIKE type_t.chr80     #采用成本域否
DEFINE g_wc_cs_ld     STRING               
DEFINE g_wc_cs_comp   STRING  
#end add-point
 
{</section>}
 
{<section id="axcq542.main" >}
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
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xccncomp,'',xccnld,'',xccn004,xccn005,'','',xccn003,'',xccn001,''", 
                      " FROM xccn_t",
                      " WHERE xccnent= ? AND xccnld=? AND xccn001=? AND xccn003=? AND xccn004=? AND  
                          xccn005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq542_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccncomp,t0.xccnld,t0.xccn004,t0.xccn005,t0.xccn003,t0.xccn001,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003 ,t4.ooail003",
               " FROM xccn_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccncomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xccnld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xccn003 AND t3.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.xccn001 AND t4.ooail002='"||g_dlang||"' ",
 
               " WHERE t0.xccnent = " ||g_enterprise|| " AND t0.xccnld = ? AND t0.xccn001 = ? AND t0.xccn003 = ? AND t0.xccn004 = ? AND t0.xccn005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq542_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      LET g_xccn_m.xccncomp = g_argv[1]   #法人
      LET g_xccn_m.xccnld   = g_argv[2]   #账套
      LET g_xccn_m.xccn004  = g_argv[3]   #年度
      LET g_xccn_m.xccn005  = g_argv[4]   #期别
      LET g_xccn_m.xccn001  = g_argv[5]   #本位币顺序
      LET g_xccn_m.xccn003  = g_argv[6]   #成本计算类型
      CALL axcq542_b_fill(' 1=1')
      #CALL axcq542_ins_xccn()
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq542 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq542_init()   
 
      #進入選單 Menu (="N")
      CALL axcq542_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq542
      
   END IF 
   
   CLOSE axcq542_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq542.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq542_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
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
   CALL cl_set_combo_scc('xccn001','8914')
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
       
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccn002,xccn002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccn002,xccn002_desc',FALSE)                
   END IF   
   #end add-point
   
   CALL axcq542_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq542.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq542_ui_dialog()
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
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      CALL axcq542_query()
   END IF
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xccn_m.* TO NULL
         CALL g_xccn_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq542_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq542_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq542_ui_detailshow()
               
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
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq542_browser_fill("")
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
               CALL axcq542_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq542_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq542_filter()
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq542_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq542_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq542_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq542_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq542_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq542_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq542_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq542_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq542_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq542_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xccn_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
               NEXT FIELD xccn002
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
               CALL axcq542_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq542_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq542_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
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
               CALL axcq542_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axcq542_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq542_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq542_set_pk_array()
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
 
{<section id="axcq542.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq542_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq542.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq542_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " (xccn004*12+xccn005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  
   ELSE     
      LET g_wc = g_wc," AND (xccn004*12+xccn005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  
   END IF
   #end add-point    
 
   LET l_searchcol = "xccnld,xccn001,xccn003,xccn004,xccn005"
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
      LET l_sub_sql = " SELECT DISTINCT xccnld ",
                      ", xccn001 ",
                      ", xccn003 ",
                      ", xccn004 ",
                      ", xccn005 ",
 
                      " FROM xccn_t ",
                      " ",
                      " LEFT JOIN imag_t ON imagent = "||g_enterprise||" AND imagsite = '"||g_site||"' AND xccnld = imag001 LEFT JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn003 = xccd002 AND xccn004 = xccd003 AND xccn005 = xccd004 AND xccn002 = xccd005 AND xccn006 = xccd006 ", 
 
 
 
                      " WHERE xccnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccn_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xccnld ",
                      ", xccn001 ",
                      ", xccn003 ",
                      ", xccn004 ",
                      ", xccn005 ",
 
                      " FROM xccn_t ",
                      " ",
                      " LEFT JOIN imag_t ON imagent = "||g_enterprise||" AND imagsite = '"||g_site||"' AND xccnld = imag001 LEFT JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn003 = xccd002 AND xccn004 = xccd003 AND xccn005 = xccd004 AND xccn002 = xccd005 AND xccn006 = xccd006 ", 
 
 
                      " WHERE xccnent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccn_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xccnld ",
                      ", xccn001 ",
                      ", xccn003 ",
                      " FROM xccn_t ",
                      " INNER JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn002 = xccd002 AND xccn003 = xccd003 AND xccn004 = xccd004 AND xccn005 = xccd005 AND xccn006 = xccd006 ", 
                      " LEFT JOIN imag_t ON imagent =xccdent AND imagsite=xccdcomp AND imag001=xccd007 ",
                      " WHERE xccnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccn_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xccnld ",
                      ", xccn001 ",
                      ", xccn003 ",
                      " FROM xccn_t ",
                      " INNER JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn002 = xccd002 AND xccn003 = xccd003 AND xccn004 = xccd004 AND xccn005 = xccd005 AND xccn006 = xccd006 ", 
                      " LEFT JOIN imag_t ON imagent =xccdent AND imagsite=xccdcomp AND imag001=xccd007 ",
                      " WHERE xccnent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccn_t")
   END IF    
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xccnld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccncomp IN ",g_wc_cs_comp
   END IF
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
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
      INITIALIZE g_xccn_m.* TO NULL
      CALL g_xccn_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xccnld,t0.xccn001,t0.xccn003,t0.xccn004,t0.xccn005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xccnld,t0.xccn001,t0.xccn003,t0.xccn004,t0.xccn005",
                " FROM xccn_t t0",
                #" ",
                " LEFT JOIN imag_t ON imagent = "||g_enterprise||" AND imagsite = '"||g_site||"' AND xccnld = imag001 LEFT JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn003 = xccd002 AND xccn004 = xccd003 AND xccn005 = xccd004 AND xccn002 = xccd005 AND xccn006 = xccd006 ",
 
 
 
                
                " WHERE t0.xccnent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccn_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   LET g_sql  = "SELECT DISTINCT t0.xccnld,t0.xccn001,t0.xccn003",
                " FROM xccn_t t0",
                " INNER JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn002 = xccd002 AND xccn003 = xccd003 AND xccn004 = xccd004 AND xccn005 = xccd005 AND xccn006 = xccd006 ", 
                " LEFT JOIN imag_t ON imagent =xccdent AND imagsite=xccdcomp AND imag001=xccd007 ",
                " WHERE t0.xccnent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccn_t")   
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xccnld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccncomp IN ",g_wc_cs_comp
   END IF
   LET l_searchcol = "xccnld,xccn001,xccn003"
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccn_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xccnld,g_browser[g_cnt].b_xccn001,g_browser[g_cnt].b_xccn003, 
          g_browser[g_cnt].b_xccn004,g_browser[g_cnt].b_xccn005 
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
   
   IF cl_null(g_browser[g_cnt].b_xccnld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xccn_m.* TO NULL
      CALL g_xccn_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq542_fetch('')
   
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
 
{<section id="axcq542.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq542_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xccn_m.xccnld = g_browser[g_current_idx].b_xccnld   
   LET g_xccn_m.xccn001 = g_browser[g_current_idx].b_xccn001   
   LET g_xccn_m.xccn003 = g_browser[g_current_idx].b_xccn003   
   LET g_xccn_m.xccn004 = g_browser[g_current_idx].b_xccn004   
   LET g_xccn_m.xccn005 = g_browser[g_current_idx].b_xccn005   
 
   EXECUTE axcq542_master_referesh USING g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004, 
       g_xccn_m.xccn005 INTO g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn003, 
       g_xccn_m.xccn001,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld_desc,g_xccn_m.xccn003_desc,g_xccn_m.xccn001_desc 
 
   CALL axcq542_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq542_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq542_ui_browser_refresh()
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
      IF g_browser[l_i].b_xccnld = g_xccn_m.xccnld 
         AND g_browser[l_i].b_xccn001 = g_xccn_m.xccn001 
         AND g_browser[l_i].b_xccn003 = g_xccn_m.xccn003 
         AND g_browser[l_i].b_xccn004 = g_xccn_m.xccn004 
         AND g_browser[l_i].b_xccn005 = g_xccn_m.xccn005 
 
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
 
{<section id="axcq542.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq542_construct()
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
   INITIALIZE g_xccn_m.* TO NULL
   CALL g_xccn_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccncomp,xccnld,xccn003,xccn001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq542_default()
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccncomp
            #add-point:BEFORE FIELD xccncomp name="construct.b.xccncomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccncomp
            
            #add-point:AFTER FIELD xccncomp name="construct.a.xccncomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccncomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccncomp
            #add-point:ON ACTION controlp INFIELD xccncomp name="construct.c.xccncomp"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #CALL q_ooef001()                           #呼叫開窗   #161019-00017#5
            CALL q_ooef001_2()   #161019-00017#5
            DISPLAY g_qryparam.return1 TO xccncomp  #顯示到畫面上
            NEXT FIELD xccncomp                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccnld
            #add-point:BEFORE FIELD xccnld name="construct.b.xccnld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccnld
            
            #add-point:AFTER FIELD xccnld name="construct.a.xccnld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccnld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccnld
            #add-point:ON ACTION controlp INFIELD xccnld name="construct.c.xccnld"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccnld  #顯示到畫面上
            NEXT FIELD xccnld                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn003
            #add-point:BEFORE FIELD xccn003 name="construct.b.xccn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn003
            
            #add-point:AFTER FIELD xccn003 name="construct.a.xccn003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn003
            #add-point:ON ACTION controlp INFIELD xccn003 name="construct.c.xccn003"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccn003  #顯示到畫面上
            NEXT FIELD xccn003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn001
            #add-point:BEFORE FIELD xccn001 name="construct.b.xccn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn001
            
            #add-point:AFTER FIELD xccn001 name="construct.a.xccn001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn001
            #add-point:ON ACTION controlp INFIELD xccn001 name="construct.c.xccn001"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccn002,xccn006,imag011,xccd007,xccn102,xccn102a,xccn102b,xccn102c,xccn102d, 
          xccn102e,xccn102f,xccn102g,xccn102h,xccn202,xccn202a,xccn202b,xccn202c,xccn202d,xccn202e,xccn202f, 
          xccn202g,xccn202h,xccn302,xccn302a,xccn302b,xccn302c,xccn302d,xccn302e,xccn302f,xccn302g,xccn302h 
 
           FROM s_detail1[1].xccn002,s_detail1[1].xccn006,s_detail1[1].imag011,s_detail1[1].xccd007, 
               s_detail1[1].xccn102,s_detail1[1].xccn102a,s_detail1[1].xccn102b,s_detail1[1].xccn102c, 
               s_detail1[1].xccn102d,s_detail1[1].xccn102e,s_detail1[1].xccn102f,s_detail1[1].xccn102g, 
               s_detail1[1].xccn102h,s_detail1[1].xccn202,s_detail1[1].xccn202a,s_detail1[1].xccn202b, 
               s_detail1[1].xccn202c,s_detail1[1].xccn202d,s_detail1[1].xccn202e,s_detail1[1].xccn202f, 
               s_detail1[1].xccn202g,s_detail1[1].xccn202h,s_detail1[1].xccn302,s_detail1[1].xccn302a, 
               s_detail1[1].xccn302b,s_detail1[1].xccn302c,s_detail1[1].xccn302d,s_detail1[1].xccn302e, 
               s_detail1[1].xccn302f,s_detail1[1].xccn302g,s_detail1[1].xccn302h
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn002
            #add-point:BEFORE FIELD xccn002 name="construct.b.page1.xccn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn002
            
            #add-point:AFTER FIELD xccn002 name="construct.a.page1.xccn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn002
            #add-point:ON ACTION controlp INFIELD xccn002 name="construct.c.page1.xccn002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccn002  #顯示到畫面上            
            NEXT FIELD xccn002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn006
            #add-point:BEFORE FIELD xccn006 name="construct.b.page1.xccn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn006
            
            #add-point:AFTER FIELD xccn006 name="construct.a.page1.xccn006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn006
            #add-point:ON ACTION controlp INFIELD xccn006 name="construct.c.page1.xccn006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.page1.imag011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imag011  #顯示到畫面上
            NEXT FIELD imag011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="construct.b.page1.imag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="construct.a.page1.imag011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd007
            #add-point:BEFORE FIELD xccd007 name="construct.b.page1.xccd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd007
            
            #add-point:AFTER FIELD xccd007 name="construct.a.page1.xccd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd007
            #add-point:ON ACTION controlp INFIELD xccd007 name="construct.c.page1.xccd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102
            #add-point:BEFORE FIELD xccn102 name="construct.b.page1.xccn102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102
            
            #add-point:AFTER FIELD xccn102 name="construct.a.page1.xccn102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102
            #add-point:ON ACTION controlp INFIELD xccn102 name="construct.c.page1.xccn102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102a
            #add-point:BEFORE FIELD xccn102a name="construct.b.page1.xccn102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102a
            
            #add-point:AFTER FIELD xccn102a name="construct.a.page1.xccn102a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102a
            #add-point:ON ACTION controlp INFIELD xccn102a name="construct.c.page1.xccn102a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102b
            #add-point:BEFORE FIELD xccn102b name="construct.b.page1.xccn102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102b
            
            #add-point:AFTER FIELD xccn102b name="construct.a.page1.xccn102b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102b
            #add-point:ON ACTION controlp INFIELD xccn102b name="construct.c.page1.xccn102b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102c
            #add-point:BEFORE FIELD xccn102c name="construct.b.page1.xccn102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102c
            
            #add-point:AFTER FIELD xccn102c name="construct.a.page1.xccn102c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102c
            #add-point:ON ACTION controlp INFIELD xccn102c name="construct.c.page1.xccn102c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102d
            #add-point:BEFORE FIELD xccn102d name="construct.b.page1.xccn102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102d
            
            #add-point:AFTER FIELD xccn102d name="construct.a.page1.xccn102d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102d
            #add-point:ON ACTION controlp INFIELD xccn102d name="construct.c.page1.xccn102d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102e
            #add-point:BEFORE FIELD xccn102e name="construct.b.page1.xccn102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102e
            
            #add-point:AFTER FIELD xccn102e name="construct.a.page1.xccn102e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102e
            #add-point:ON ACTION controlp INFIELD xccn102e name="construct.c.page1.xccn102e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102f
            #add-point:BEFORE FIELD xccn102f name="construct.b.page1.xccn102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102f
            
            #add-point:AFTER FIELD xccn102f name="construct.a.page1.xccn102f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102f
            #add-point:ON ACTION controlp INFIELD xccn102f name="construct.c.page1.xccn102f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102g
            #add-point:BEFORE FIELD xccn102g name="construct.b.page1.xccn102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102g
            
            #add-point:AFTER FIELD xccn102g name="construct.a.page1.xccn102g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102g
            #add-point:ON ACTION controlp INFIELD xccn102g name="construct.c.page1.xccn102g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102h
            #add-point:BEFORE FIELD xccn102h name="construct.b.page1.xccn102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102h
            
            #add-point:AFTER FIELD xccn102h name="construct.a.page1.xccn102h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102h
            #add-point:ON ACTION controlp INFIELD xccn102h name="construct.c.page1.xccn102h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202
            #add-point:BEFORE FIELD xccn202 name="construct.b.page1.xccn202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202
            
            #add-point:AFTER FIELD xccn202 name="construct.a.page1.xccn202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202
            #add-point:ON ACTION controlp INFIELD xccn202 name="construct.c.page1.xccn202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202a
            #add-point:BEFORE FIELD xccn202a name="construct.b.page1.xccn202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202a
            
            #add-point:AFTER FIELD xccn202a name="construct.a.page1.xccn202a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202a
            #add-point:ON ACTION controlp INFIELD xccn202a name="construct.c.page1.xccn202a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202b
            #add-point:BEFORE FIELD xccn202b name="construct.b.page1.xccn202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202b
            
            #add-point:AFTER FIELD xccn202b name="construct.a.page1.xccn202b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202b
            #add-point:ON ACTION controlp INFIELD xccn202b name="construct.c.page1.xccn202b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202c
            #add-point:BEFORE FIELD xccn202c name="construct.b.page1.xccn202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202c
            
            #add-point:AFTER FIELD xccn202c name="construct.a.page1.xccn202c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202c
            #add-point:ON ACTION controlp INFIELD xccn202c name="construct.c.page1.xccn202c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202d
            #add-point:BEFORE FIELD xccn202d name="construct.b.page1.xccn202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202d
            
            #add-point:AFTER FIELD xccn202d name="construct.a.page1.xccn202d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202d
            #add-point:ON ACTION controlp INFIELD xccn202d name="construct.c.page1.xccn202d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202e
            #add-point:BEFORE FIELD xccn202e name="construct.b.page1.xccn202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202e
            
            #add-point:AFTER FIELD xccn202e name="construct.a.page1.xccn202e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202e
            #add-point:ON ACTION controlp INFIELD xccn202e name="construct.c.page1.xccn202e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202f
            #add-point:BEFORE FIELD xccn202f name="construct.b.page1.xccn202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202f
            
            #add-point:AFTER FIELD xccn202f name="construct.a.page1.xccn202f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202f
            #add-point:ON ACTION controlp INFIELD xccn202f name="construct.c.page1.xccn202f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202g
            #add-point:BEFORE FIELD xccn202g name="construct.b.page1.xccn202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202g
            
            #add-point:AFTER FIELD xccn202g name="construct.a.page1.xccn202g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202g
            #add-point:ON ACTION controlp INFIELD xccn202g name="construct.c.page1.xccn202g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202h
            #add-point:BEFORE FIELD xccn202h name="construct.b.page1.xccn202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202h
            
            #add-point:AFTER FIELD xccn202h name="construct.a.page1.xccn202h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202h
            #add-point:ON ACTION controlp INFIELD xccn202h name="construct.c.page1.xccn202h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302
            #add-point:BEFORE FIELD xccn302 name="construct.b.page1.xccn302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302
            
            #add-point:AFTER FIELD xccn302 name="construct.a.page1.xccn302"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302
            #add-point:ON ACTION controlp INFIELD xccn302 name="construct.c.page1.xccn302"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302a
            #add-point:BEFORE FIELD xccn302a name="construct.b.page1.xccn302a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302a
            
            #add-point:AFTER FIELD xccn302a name="construct.a.page1.xccn302a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302a
            #add-point:ON ACTION controlp INFIELD xccn302a name="construct.c.page1.xccn302a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302b
            #add-point:BEFORE FIELD xccn302b name="construct.b.page1.xccn302b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302b
            
            #add-point:AFTER FIELD xccn302b name="construct.a.page1.xccn302b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302b
            #add-point:ON ACTION controlp INFIELD xccn302b name="construct.c.page1.xccn302b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302c
            #add-point:BEFORE FIELD xccn302c name="construct.b.page1.xccn302c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302c
            
            #add-point:AFTER FIELD xccn302c name="construct.a.page1.xccn302c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302c
            #add-point:ON ACTION controlp INFIELD xccn302c name="construct.c.page1.xccn302c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302d
            #add-point:BEFORE FIELD xccn302d name="construct.b.page1.xccn302d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302d
            
            #add-point:AFTER FIELD xccn302d name="construct.a.page1.xccn302d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302d
            #add-point:ON ACTION controlp INFIELD xccn302d name="construct.c.page1.xccn302d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302e
            #add-point:BEFORE FIELD xccn302e name="construct.b.page1.xccn302e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302e
            
            #add-point:AFTER FIELD xccn302e name="construct.a.page1.xccn302e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302e
            #add-point:ON ACTION controlp INFIELD xccn302e name="construct.c.page1.xccn302e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302f
            #add-point:BEFORE FIELD xccn302f name="construct.b.page1.xccn302f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302f
            
            #add-point:AFTER FIELD xccn302f name="construct.a.page1.xccn302f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302f
            #add-point:ON ACTION controlp INFIELD xccn302f name="construct.c.page1.xccn302f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302g
            #add-point:BEFORE FIELD xccn302g name="construct.b.page1.xccn302g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302g
            
            #add-point:AFTER FIELD xccn302g name="construct.a.page1.xccn302g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302g
            #add-point:ON ACTION controlp INFIELD xccn302g name="construct.c.page1.xccn302g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302h
            #add-point:BEFORE FIELD xccn302h name="construct.b.page1.xccn302h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302h
            
            #add-point:AFTER FIELD xccn302h name="construct.a.page1.xccn302h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccn302h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302h
            #add-point:ON ACTION controlp INFIELD xccn302h name="construct.c.page1.xccn302h"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT g_yy1,g_mm1,g_yy2,g_mm2 FROM xccn004,xccn005,xccn004_1,xccn005_1
         AFTER FIELD xccn004 
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccn004
                END IF
             END IF
         AFTER FIELD xccn005
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND
                  g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xccn005
               END IF
            END IF
         AFTER FIELD xccn004_1
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccn004_1
                END IF
             END IF
         AFTER FIELD xccn005_1   
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND
                  g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xccn005_1
               END IF
            END IF               
      END INPUT
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
 
{<section id="axcq542.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq542_query()
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
   CALL g_xccn_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq542_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq542_browser_fill(g_wc)
      CALL axcq542_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq542_browser_fill("F")
   
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
      CALL axcq542_fetch("F") 
   END IF
   
   CALL axcq542_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq542_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
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
   
   #CALL axcq542_browser_fill(p_flag)
   
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
   
   LET g_xccn_m.xccnld = g_browser[g_current_idx].b_xccnld
   LET g_xccn_m.xccn001 = g_browser[g_current_idx].b_xccn001
   LET g_xccn_m.xccn003 = g_browser[g_current_idx].b_xccn003
   LET g_xccn_m.xccn004 = g_browser[g_current_idx].b_xccn004
   LET g_xccn_m.xccn005 = g_browser[g_current_idx].b_xccn005
 
   LET g_sql = " SELECT DISTINCT t0.xccncomp,t0.xccnld,t0.xccn003,t0.xccn001,t1.ooefl003 ,t2.glaal002 ,t3.xcatl003 ,t4.ooail003",
               " FROM xccn_t t0",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccncomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xccnld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xccn003 AND t3.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.xccn001 AND t4.ooail002='"||g_dlang||"' ",
               " WHERE t0.xccnent = " ||g_enterprise|| " AND t0.xccnld = ? AND t0.xccn001 = ? AND t0.xccn003 = ? " 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq542_master_referesh1 FROM g_sql               
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq542_master_referesh1 USING g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003
      INTO g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn003, 
           g_xccn_m.xccn001,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld_desc,g_xccn_m.xccn003_desc,g_xccn_m.xccn001_desc 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccn_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xccn_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xccn_m_mask_o.* =  g_xccn_m.*
   CALL axcq542_xccn_t_mask()
   LET g_xccn_m_mask_n.* =  g_xccn_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq542_set_act_visible()
   CALL axcq542_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xccn_m_t.* = g_xccn_m.*
   LET g_xccn_m_o.* = g_xccn_m.*
   
   #重新顯示   
   CALL axcq542_show()
   RETURN
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
   
   #CALL axcq542_browser_fill(p_flag)
   
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
   
   LET g_xccn_m.xccnld = g_browser[g_current_idx].b_xccnld
   LET g_xccn_m.xccn001 = g_browser[g_current_idx].b_xccn001
   LET g_xccn_m.xccn003 = g_browser[g_current_idx].b_xccn003
   LET g_xccn_m.xccn004 = g_browser[g_current_idx].b_xccn004
   LET g_xccn_m.xccn005 = g_browser[g_current_idx].b_xccn005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq542_master_referesh USING g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004, 
       g_xccn_m.xccn005 INTO g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn003, 
       g_xccn_m.xccn001,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld_desc,g_xccn_m.xccn003_desc,g_xccn_m.xccn001_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccn_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xccn_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xccn_m_mask_o.* =  g_xccn_m.*
   CALL axcq542_xccn_t_mask()
   LET g_xccn_m_mask_n.* =  g_xccn_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq542_set_act_visible()
   CALL axcq542_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xccn_m_t.* = g_xccn_m.*
   LET g_xccn_m_o.* = g_xccn_m.*
   
   #重新顯示   
   CALL axcq542_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq542.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq542_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccn_d.clear()
 
 
   INITIALIZE g_xccn_m.* TO NULL             #DEFAULT 設定
   LET g_xccnld_t = NULL
   LET g_xccn001_t = NULL
   LET g_xccn003_t = NULL
   LET g_xccn004_t = NULL
   LET g_xccn005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq542_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccn_m.* TO NULL
         INITIALIZE g_xccn_d TO NULL
 
         CALL axcq542_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccn_m.* = g_xccn_m_t.*
         CALL axcq542_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xccn_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq542_set_act_visible()
   CALL axcq542_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccnld_t = g_xccn_m.xccnld
   LET g_xccn001_t = g_xccn_m.xccn001
   LET g_xccn003_t = g_xccn_m.xccn003
   LET g_xccn004_t = g_xccn_m.xccn004
   LET g_xccn005_t = g_xccn_m.xccn005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccnent = " ||g_enterprise|| " AND",
                      " xccnld = '", g_xccn_m.xccnld, "' "
                      ," AND xccn001 = '", g_xccn_m.xccn001, "' "
                      ," AND xccn003 = '", g_xccn_m.xccn003, "' "
                      ," AND xccn004 = '", g_xccn_m.xccn004, "' "
                      ," AND xccn005 = '", g_xccn_m.xccn005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq542_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq542_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq542_master_referesh USING g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004, 
       g_xccn_m.xccn005 INTO g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn003, 
       g_xccn_m.xccn001,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld_desc,g_xccn_m.xccn003_desc,g_xccn_m.xccn001_desc 
 
   
   #遮罩相關處理
   LET g_xccn_m_mask_o.* =  g_xccn_m.*
   CALL axcq542_xccn_t_mask()
   LET g_xccn_m_mask_n.* =  g_xccn_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccn_m.xccncomp,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld,g_xccn_m.xccnld_desc,g_xccn_m.xccn004, 
       g_xccn_m.xccn005,g_xccn_m.xccn004_1,g_xccn_m.xccn005_1,g_xccn_m.xccn003,g_xccn_m.xccn003_desc, 
       g_xccn_m.xccn001,g_xccn_m.xccn001_desc
   
   #功能已完成,通報訊息中心
   CALL axcq542_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq542_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xccn_m.xccnld IS NULL
   OR g_xccn_m.xccn001 IS NULL
   OR g_xccn_m.xccn003 IS NULL
   OR g_xccn_m.xccn004 IS NULL
   OR g_xccn_m.xccn005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xccnld_t = g_xccn_m.xccnld
   LET g_xccn001_t = g_xccn_m.xccn001
   LET g_xccn003_t = g_xccn_m.xccn003
   LET g_xccn004_t = g_xccn_m.xccn004
   LET g_xccn005_t = g_xccn_m.xccn005
 
   CALL s_transaction_begin()
   
   OPEN axcq542_cl USING g_enterprise,g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004,g_xccn_m.xccn005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq542_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq542_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq542_master_referesh USING g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004, 
       g_xccn_m.xccn005 INTO g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn003, 
       g_xccn_m.xccn001,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld_desc,g_xccn_m.xccn003_desc,g_xccn_m.xccn001_desc 
 
   
   #遮罩相關處理
   LET g_xccn_m_mask_o.* =  g_xccn_m.*
   CALL axcq542_xccn_t_mask()
   LET g_xccn_m_mask_n.* =  g_xccn_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq542_show()
   WHILE TRUE
      LET g_xccnld_t = g_xccn_m.xccnld
      LET g_xccn001_t = g_xccn_m.xccn001
      LET g_xccn003_t = g_xccn_m.xccn003
      LET g_xccn004_t = g_xccn_m.xccn004
      LET g_xccn005_t = g_xccn_m.xccn005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq542_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccn_m.* = g_xccn_m_t.*
         CALL axcq542_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xccn_m.xccnld != g_xccnld_t 
      OR g_xccn_m.xccn001 != g_xccn001_t 
      OR g_xccn_m.xccn003 != g_xccn003_t 
      OR g_xccn_m.xccn004 != g_xccn004_t 
      OR g_xccn_m.xccn005 != g_xccn005_t 
 
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
   CALL axcq542_set_act_visible()
   CALL axcq542_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccnent = " ||g_enterprise|| " AND",
                      " xccnld = '", g_xccn_m.xccnld, "' "
                      ," AND xccn001 = '", g_xccn_m.xccn001, "' "
                      ," AND xccn003 = '", g_xccn_m.xccn003, "' "
                      ," AND xccn004 = '", g_xccn_m.xccn004, "' "
                      ," AND xccn005 = '", g_xccn_m.xccn005, "' "
 
   #填到對應位置
   CALL axcq542_browser_fill("")
 
   CALL axcq542_idx_chk()
 
   CLOSE axcq542_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq542_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq542.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq542_input(p_cmd)
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
   DISPLAY BY NAME g_xccn_m.xccncomp,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld,g_xccn_m.xccnld_desc,g_xccn_m.xccn004, 
       g_xccn_m.xccn005,g_xccn_m.xccn004_1,g_xccn_m.xccn005_1,g_xccn_m.xccn003,g_xccn_m.xccn003_desc, 
       g_xccn_m.xccn001,g_xccn_m.xccn001_desc
   
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
   LET g_forupd_sql = "SELECT xccn002,xccn006,xccn102,xccn102a,xccn102b,xccn102c,xccn102d,xccn102e,xccn102f, 
       xccn102g,xccn102h,xccn202,xccn202a,xccn202b,xccn202c,xccn202d,xccn202e,xccn202f,xccn202g,xccn202h, 
       xccn302,xccn302a,xccn302b,xccn302c,xccn302d,xccn302e,xccn302f,xccn302g,xccn302h FROM xccn_t WHERE  
       xccnent=? AND xccnld=? AND xccn001=? AND xccn003=? AND xccn004=? AND xccn005=? AND xccn002=?  
       AND xccn006=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq542_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq542_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq542_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn004_1, 
       g_xccn_m.xccn005_1,g_xccn_m.xccn003,g_xccn_m.xccn001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq542.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn004_1, 
          g_xccn_m.xccn005_1,g_xccn_m.xccn003,g_xccn_m.xccn001 
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
         AFTER FIELD xccncomp
            
            #add-point:AFTER FIELD xccncomp name="input.a.xccncomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccn_m.xccncomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccn_m.xccncomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccn_m.xccncomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccncomp
            #add-point:BEFORE FIELD xccncomp name="input.b.xccncomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccncomp
            #add-point:ON CHANGE xccncomp name="input.g.xccncomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccnld
            
            #add-point:AFTER FIELD xccnld name="input.a.xccnld"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccn_m.xccnld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent="||g_enterprise||" AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccn_m.xccnld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccn_m.xccnld_desc

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xccn_m.xccnld) AND NOT cl_null(g_xccn_m.xccn001) AND NOT cl_null(g_xccn_m.xccn003) AND NOT cl_null(g_xccn_m.xccn004) AND NOT cl_null(g_xccn_m.xccn005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccn_m.xccnld != g_xccnld_t  OR g_xccn_m.xccn001 != g_xccn001_t  OR g_xccn_m.xccn003 != g_xccn003_t  OR g_xccn_m.xccn004 != g_xccn004_t  OR g_xccn_m.xccn005 != g_xccn005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccn_t WHERE "||"xccnent = " ||g_enterprise|| " AND "||"xccnld = '"||g_xccn_m.xccnld ||"' AND "|| "xccn001 = '"||g_xccn_m.xccn001 ||"' AND "|| "xccn003 = '"||g_xccn_m.xccn003 ||"' AND "|| "xccn004 = '"||g_xccn_m.xccn004 ||"' AND "|| "xccn005 = '"||g_xccn_m.xccn005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccnld
            #add-point:BEFORE FIELD xccnld name="input.b.xccnld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccnld
            #add-point:ON CHANGE xccnld name="input.g.xccnld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn004
            #add-point:BEFORE FIELD xccn004 name="input.b.xccn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn004
            
            #add-point:AFTER FIELD xccn004 name="input.a.xccn004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xccn_m.xccnld) AND NOT cl_null(g_xccn_m.xccn001) AND NOT cl_null(g_xccn_m.xccn003) AND NOT cl_null(g_xccn_m.xccn004) AND NOT cl_null(g_xccn_m.xccn005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccn_m.xccnld != g_xccnld_t  OR g_xccn_m.xccn001 != g_xccn001_t  OR g_xccn_m.xccn003 != g_xccn003_t  OR g_xccn_m.xccn004 != g_xccn004_t  OR g_xccn_m.xccn005 != g_xccn005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccn_t WHERE "||"xccnent = " ||g_enterprise|| " AND "||"xccnld = '"||g_xccn_m.xccnld ||"' AND "|| "xccn001 = '"||g_xccn_m.xccn001 ||"' AND "|| "xccn003 = '"||g_xccn_m.xccn003 ||"' AND "|| "xccn004 = '"||g_xccn_m.xccn004 ||"' AND "|| "xccn005 = '"||g_xccn_m.xccn005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn004
            #add-point:ON CHANGE xccn004 name="input.g.xccn004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn005
            #add-point:BEFORE FIELD xccn005 name="input.b.xccn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn005
            
            #add-point:AFTER FIELD xccn005 name="input.a.xccn005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xccn_m.xccnld) AND NOT cl_null(g_xccn_m.xccn001) AND NOT cl_null(g_xccn_m.xccn003) AND NOT cl_null(g_xccn_m.xccn004) AND NOT cl_null(g_xccn_m.xccn005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccn_m.xccnld != g_xccnld_t  OR g_xccn_m.xccn001 != g_xccn001_t  OR g_xccn_m.xccn003 != g_xccn003_t  OR g_xccn_m.xccn004 != g_xccn004_t  OR g_xccn_m.xccn005 != g_xccn005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccn_t WHERE "||"xccnent = " ||g_enterprise|| " AND "||"xccnld = '"||g_xccn_m.xccnld ||"' AND "|| "xccn001 = '"||g_xccn_m.xccn001 ||"' AND "|| "xccn003 = '"||g_xccn_m.xccn003 ||"' AND "|| "xccn004 = '"||g_xccn_m.xccn004 ||"' AND "|| "xccn005 = '"||g_xccn_m.xccn005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn005
            #add-point:ON CHANGE xccn005 name="input.g.xccn005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn004_1
            #add-point:BEFORE FIELD xccn004_1 name="input.b.xccn004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn004_1
            
            #add-point:AFTER FIELD xccn004_1 name="input.a.xccn004_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn004_1
            #add-point:ON CHANGE xccn004_1 name="input.g.xccn004_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn005_1
            #add-point:BEFORE FIELD xccn005_1 name="input.b.xccn005_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn005_1
            
            #add-point:AFTER FIELD xccn005_1 name="input.a.xccn005_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn005_1
            #add-point:ON CHANGE xccn005_1 name="input.g.xccn005_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn003
            
            #add-point:AFTER FIELD xccn003 name="input.a.xccn003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xccn_m.xccnld) AND NOT cl_null(g_xccn_m.xccn001) AND NOT cl_null(g_xccn_m.xccn003) AND NOT cl_null(g_xccn_m.xccn004) AND NOT cl_null(g_xccn_m.xccn005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccn_m.xccnld != g_xccnld_t  OR g_xccn_m.xccn001 != g_xccn001_t  OR g_xccn_m.xccn003 != g_xccn003_t  OR g_xccn_m.xccn004 != g_xccn004_t  OR g_xccn_m.xccn005 != g_xccn005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccn_t WHERE "||"xccnent = " ||g_enterprise|| " AND "||"xccnld = '"||g_xccn_m.xccnld ||"' AND "|| "xccn001 = '"||g_xccn_m.xccn001 ||"' AND "|| "xccn003 = '"||g_xccn_m.xccn003 ||"' AND "|| "xccn004 = '"||g_xccn_m.xccn004 ||"' AND "|| "xccn005 = '"||g_xccn_m.xccn005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn003
            #add-point:BEFORE FIELD xccn003 name="input.b.xccn003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn003
            #add-point:ON CHANGE xccn003 name="input.g.xccn003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn001
            
            #add-point:AFTER FIELD xccn001 name="input.a.xccn001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xccn_m.xccnld) AND NOT cl_null(g_xccn_m.xccn001) AND NOT cl_null(g_xccn_m.xccn003) AND NOT cl_null(g_xccn_m.xccn004) AND NOT cl_null(g_xccn_m.xccn005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccn_m.xccnld != g_xccnld_t  OR g_xccn_m.xccn001 != g_xccn001_t  OR g_xccn_m.xccn003 != g_xccn003_t  OR g_xccn_m.xccn004 != g_xccn004_t  OR g_xccn_m.xccn005 != g_xccn005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccn_t WHERE "||"xccnent = " ||g_enterprise|| " AND "||"xccnld = '"||g_xccn_m.xccnld ||"' AND "|| "xccn001 = '"||g_xccn_m.xccn001 ||"' AND "|| "xccn003 = '"||g_xccn_m.xccn003 ||"' AND "|| "xccn004 = '"||g_xccn_m.xccn004 ||"' AND "|| "xccn005 = '"||g_xccn_m.xccn005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn001
            #add-point:BEFORE FIELD xccn001 name="input.b.xccn001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn001
            #add-point:ON CHANGE xccn001 name="input.g.xccn001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccncomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccncomp
            #add-point:ON ACTION controlp INFIELD xccncomp name="input.c.xccncomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccnld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccnld
            #add-point:ON ACTION controlp INFIELD xccnld name="input.c.xccnld"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn004
            #add-point:ON ACTION controlp INFIELD xccn004 name="input.c.xccn004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn005
            #add-point:ON ACTION controlp INFIELD xccn005 name="input.c.xccn005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccn004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn004_1
            #add-point:ON ACTION controlp INFIELD xccn004_1 name="input.c.xccn004_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccn005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn005_1
            #add-point:ON ACTION controlp INFIELD xccn005_1 name="input.c.xccn005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn003
            #add-point:ON ACTION controlp INFIELD xccn003 name="input.c.xccn003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn001
            #add-point:ON ACTION controlp INFIELD xccn001 name="input.c.xccn001"
            
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
            DISPLAY BY NAME g_xccn_m.xccnld             
                            ,g_xccn_m.xccn001   
                            ,g_xccn_m.xccn003   
                            ,g_xccn_m.xccn004   
                            ,g_xccn_m.xccn005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq542_xccn_t_mask_restore('restore_mask_o')
            
               UPDATE xccn_t SET (xccncomp,xccnld,xccn004,xccn005,xccn003,xccn001) = (g_xccn_m.xccncomp, 
                   g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn003,g_xccn_m.xccn001) 
 
                WHERE xccnent = g_enterprise AND xccnld = g_xccnld_t
                  AND xccn001 = g_xccn001_t
                  AND xccn003 = g_xccn003_t
                  AND xccn004 = g_xccn004_t
                  AND xccn005 = g_xccn005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccn_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccn_m.xccnld
               LET gs_keys_bak[1] = g_xccnld_t
               LET gs_keys[2] = g_xccn_m.xccn001
               LET gs_keys_bak[2] = g_xccn001_t
               LET gs_keys[3] = g_xccn_m.xccn003
               LET gs_keys_bak[3] = g_xccn003_t
               LET gs_keys[4] = g_xccn_m.xccn004
               LET gs_keys_bak[4] = g_xccn004_t
               LET gs_keys[5] = g_xccn_m.xccn005
               LET gs_keys_bak[5] = g_xccn005_t
               LET gs_keys[6] = g_xccn_d[g_detail_idx].xccn002
               LET gs_keys_bak[6] = g_xccn_d_t.xccn002
               LET gs_keys[7] = g_xccn_d[g_detail_idx].xccn006
               LET gs_keys_bak[7] = g_xccn_d_t.xccn006
               CALL axcq542_update_b('xccn_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xccn_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xccn_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq542_xccn_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq542_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xccnld_t = g_xccn_m.xccnld
           LET g_xccn001_t = g_xccn_m.xccn001
           LET g_xccn003_t = g_xccn_m.xccn003
           LET g_xccn004_t = g_xccn_m.xccn004
           LET g_xccn005_t = g_xccn_m.xccn005
 
           
           IF g_xccn_d.getLength() = 0 THEN
              NEXT FIELD xccn002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq542.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xccn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq542_b_fill(g_wc2) #test 
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
            CALL axcq542_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq542_cl USING g_enterprise,g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004,g_xccn_m.xccn005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq542_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq542_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xccn_d[l_ac].xccn002 IS NOT NULL
               AND g_xccn_d[l_ac].xccn006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccn_d_t.* = g_xccn_d[l_ac].*  #BACKUP
               LET g_xccn_d_o.* = g_xccn_d[l_ac].*  #BACKUP
               CALL axcq542_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq542_set_no_entry_b(l_cmd)
               OPEN axcq542_bcl USING g_enterprise,g_xccn_m.xccnld,
                                                g_xccn_m.xccn001,
                                                g_xccn_m.xccn003,
                                                g_xccn_m.xccn004,
                                                g_xccn_m.xccn005,
 
                                                g_xccn_d_t.xccn002
                                                ,g_xccn_d_t.xccn006
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq542_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq542_bcl INTO g_xccn_d[l_ac].xccn002,g_xccn_d[l_ac].xccn006,g_xccn_d[l_ac].xccn102, 
                      g_xccn_d[l_ac].xccn102a,g_xccn_d[l_ac].xccn102b,g_xccn_d[l_ac].xccn102c,g_xccn_d[l_ac].xccn102d, 
                      g_xccn_d[l_ac].xccn102e,g_xccn_d[l_ac].xccn102f,g_xccn_d[l_ac].xccn102g,g_xccn_d[l_ac].xccn102h, 
                      g_xccn_d[l_ac].xccn202,g_xccn_d[l_ac].xccn202a,g_xccn_d[l_ac].xccn202b,g_xccn_d[l_ac].xccn202c, 
                      g_xccn_d[l_ac].xccn202d,g_xccn_d[l_ac].xccn202e,g_xccn_d[l_ac].xccn202f,g_xccn_d[l_ac].xccn202g, 
                      g_xccn_d[l_ac].xccn202h,g_xccn_d[l_ac].xccn302,g_xccn_d[l_ac].xccn302a,g_xccn_d[l_ac].xccn302b, 
                      g_xccn_d[l_ac].xccn302c,g_xccn_d[l_ac].xccn302d,g_xccn_d[l_ac].xccn302e,g_xccn_d[l_ac].xccn302f, 
                      g_xccn_d[l_ac].xccn302g,g_xccn_d[l_ac].xccn302h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccn_d_t.xccn002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xccn_d_mask_o[l_ac].* =  g_xccn_d[l_ac].*
                  CALL axcq542_xccn_t_mask()
                  LET g_xccn_d_mask_n[l_ac].* =  g_xccn_d[l_ac].*
                  
                  CALL axcq542_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            
LET g_detail_multi_table_t.xccdld = g_xccn_m.xccnld
LET g_detail_multi_table_t.xccd001 = g_xccn_m.xccn001
LET g_detail_multi_table_t.xccd002 = g_xccn_m.xccn003
LET g_detail_multi_table_t.xccd003 = g_xccn_m.xccn004
LET g_detail_multi_table_t.xccd004 = g_xccn_m.xccn005
LET g_detail_multi_table_t.xccd005 = g_xccn_d[l_ac].xccn002
LET g_detail_multi_table_t.xccd006 = g_xccn_d[l_ac].xccn006
LET g_detail_multi_table_t.xccd007 = g_xccn_d[l_ac].xccd007
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xccn_d_t.* TO NULL
            INITIALIZE g_xccn_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccn_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccn_d[l_ac].xccn102 = "0"
      LET g_xccn_d[l_ac].xccn102a = "0"
      LET g_xccn_d[l_ac].xccn102b = "0"
      LET g_xccn_d[l_ac].xccn102c = "0"
      LET g_xccn_d[l_ac].xccn102d = "0"
      LET g_xccn_d[l_ac].xccn102e = "0"
      LET g_xccn_d[l_ac].xccn102f = "0"
      LET g_xccn_d[l_ac].xccn102g = "0"
      LET g_xccn_d[l_ac].xccn102h = "0"
      LET g_xccn_d[l_ac].xccn202 = "0"
      LET g_xccn_d[l_ac].xccn202a = "0"
      LET g_xccn_d[l_ac].xccn202b = "0"
      LET g_xccn_d[l_ac].xccn202c = "0"
      LET g_xccn_d[l_ac].xccn202d = "0"
      LET g_xccn_d[l_ac].xccn202e = "0"
      LET g_xccn_d[l_ac].xccn202f = "0"
      LET g_xccn_d[l_ac].xccn202g = "0"
      LET g_xccn_d[l_ac].xccn202h = "0"
      LET g_xccn_d[l_ac].xccn302 = "0"
      LET g_xccn_d[l_ac].xccn302a = "0"
      LET g_xccn_d[l_ac].xccn302b = "0"
      LET g_xccn_d[l_ac].xccn302c = "0"
      LET g_xccn_d[l_ac].xccn302d = "0"
      LET g_xccn_d[l_ac].xccn302e = "0"
      LET g_xccn_d[l_ac].xccn302f = "0"
      LET g_xccn_d[l_ac].xccn302g = "0"
      LET g_xccn_d[l_ac].xccn302h = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xccn_d_t.* = g_xccn_d[l_ac].*     #新輸入資料
            LET g_xccn_d_o.* = g_xccn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq542_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq542_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccn_d[li_reproduce_target].* = g_xccn_d[li_reproduce].*
 
               LET g_xccn_d[g_xccn_d.getLength()].xccn002 = NULL
               LET g_xccn_d[g_xccn_d.getLength()].xccn006 = NULL
 
            END IF
            
LET g_detail_multi_table_t.xccdld = g_xccn_m.xccnld
LET g_detail_multi_table_t.xccd001 = g_xccn_m.xccn001
LET g_detail_multi_table_t.xccd002 = g_xccn_m.xccn003
LET g_detail_multi_table_t.xccd003 = g_xccn_m.xccn004
LET g_detail_multi_table_t.xccd004 = g_xccn_m.xccn005
LET g_detail_multi_table_t.xccd005 = g_xccn_d[l_ac].xccn002
LET g_detail_multi_table_t.xccd006 = g_xccn_d[l_ac].xccn006
LET g_detail_multi_table_t.xccd007 = g_xccn_d[l_ac].xccd007
 
            #add-point:modify段before insert name="input.body.before_insert"
{
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
            SELECT COUNT(1) INTO l_count FROM xccn_t 
             WHERE xccnent = g_enterprise AND xccnld = g_xccn_m.xccnld
               AND xccn001 = g_xccn_m.xccn001
               AND xccn003 = g_xccn_m.xccn003
               AND xccn004 = g_xccn_m.xccn004
               AND xccn005 = g_xccn_m.xccn005
 
               AND xccn002 = g_xccn_d[l_ac].xccn002
               AND xccn006 = g_xccn_d[l_ac].xccn006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xccn_t
                           (xccnent,
                            xccncomp,xccnld,xccn004,xccn005,xccn003,xccn001,
                            xccn002,xccn006
                            ,xccn102,xccn102a,xccn102b,xccn102c,xccn102d,xccn102e,xccn102f,xccn102g,xccn102h,xccn202,xccn202a,xccn202b,xccn202c,xccn202d,xccn202e,xccn202f,xccn202g,xccn202h,xccn302,xccn302a,xccn302b,xccn302c,xccn302d,xccn302e,xccn302f,xccn302g,xccn302h) 
                     VALUES(g_enterprise,
                            g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn003,g_xccn_m.xccn001,
                            g_xccn_d[l_ac].xccn002,g_xccn_d[l_ac].xccn006
                            ,g_xccn_d[l_ac].xccn102,g_xccn_d[l_ac].xccn102a,g_xccn_d[l_ac].xccn102b, 
                                g_xccn_d[l_ac].xccn102c,g_xccn_d[l_ac].xccn102d,g_xccn_d[l_ac].xccn102e, 
                                g_xccn_d[l_ac].xccn102f,g_xccn_d[l_ac].xccn102g,g_xccn_d[l_ac].xccn102h, 
                                g_xccn_d[l_ac].xccn202,g_xccn_d[l_ac].xccn202a,g_xccn_d[l_ac].xccn202b, 
                                g_xccn_d[l_ac].xccn202c,g_xccn_d[l_ac].xccn202d,g_xccn_d[l_ac].xccn202e, 
                                g_xccn_d[l_ac].xccn202f,g_xccn_d[l_ac].xccn202g,g_xccn_d[l_ac].xccn202h, 
                                g_xccn_d[l_ac].xccn302,g_xccn_d[l_ac].xccn302a,g_xccn_d[l_ac].xccn302b, 
                                g_xccn_d[l_ac].xccn302c,g_xccn_d[l_ac].xccn302d,g_xccn_d[l_ac].xccn302e, 
                                g_xccn_d[l_ac].xccn302f,g_xccn_d[l_ac].xccn302g,g_xccn_d[l_ac].xccn302h) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xccn_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xccn_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xccn_m.xccnld = g_detail_multi_table_t.imag001 AND
         g_xccn_m.xccn001 = g_detail_multi_table_t.imag011 AND
         g_xccn_m.xccn003 =  AND
         g_xccn_m.xccn004 =  AND
         g_xccn_m.xccn005 =  AND
         g_xccn_d[l_ac].xccn002 =  AND
         g_xccn_d[l_ac].xccn006 =  AND
         g_xccn_d[l_ac].imag011 =  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imagent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_site
            LET l_field_keys[02] = 'imagsite'
            LET l_var_keys_bak[02] = g_site
            LET l_var_keys[03] = g_xccn_m.xccnld
            LET l_field_keys[03] = 'imag001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.imag001
            LET l_vars[01] = g_xccn_d[l_ac].imag011
            LET l_fields[01] = 'imag011'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imag_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xccn_m.xccnld = g_detail_multi_table_t.xccdld AND
         g_xccn_m.xccn001 = g_detail_multi_table_t.xccd001 AND
         g_xccn_m.xccn003 = g_detail_multi_table_t.xccd002 AND
         g_xccn_m.xccn004 = g_detail_multi_table_t.xccd003 AND
         g_xccn_m.xccn005 = g_detail_multi_table_t.xccd004 AND
         g_xccn_d[l_ac].xccn002 = g_detail_multi_table_t.xccd005 AND
         g_xccn_d[l_ac].xccn006 = g_detail_multi_table_t.xccd006 AND
         g_xccn_d[l_ac].xccd007 = g_detail_multi_table_t.xccd007 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xccdent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xccn_m.xccnld
            LET l_field_keys[02] = 'xccdld'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xccdld
            LET l_var_keys[03] = g_xccn_m.xccn001
            LET l_field_keys[03] = 'xccd001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.xccd001
            LET l_var_keys[04] = g_xccn_m.xccn003
            LET l_field_keys[04] = 'xccd002'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.xccd002
            LET l_var_keys[05] = g_xccn_m.xccn004
            LET l_field_keys[05] = 'xccd003'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.xccd003
            LET l_var_keys[06] = g_xccn_m.xccn005
            LET l_field_keys[06] = 'xccd004'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.xccd004
            LET l_var_keys[07] = g_xccn_d[l_ac].xccn002
            LET l_field_keys[07] = 'xccd005'
            LET l_var_keys_bak[07] = g_detail_multi_table_t.xccd005
            LET l_var_keys[08] = g_xccn_d[l_ac].xccn006
            LET l_field_keys[08] = 'xccd006'
            LET l_var_keys_bak[08] = g_detail_multi_table_t.xccd006
            LET l_vars[01] = g_xccn_d[l_ac].xccd007
            LET l_fields[01] = 'xccd007'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xccd_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
}
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
               IF axcq542_before_delete() THEN 
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'xccdent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'xccdld'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xccdld
                  LET l_field_keys[03] = 'xccd001'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.xccd001
                  LET l_field_keys[04] = 'xccd002'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.xccd002
                  LET l_field_keys[05] = 'xccd003'
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.xccd003
                  LET l_field_keys[06] = 'xccd004'
                  LET l_var_keys_bak[06] = g_detail_multi_table_t.xccd004
                  LET l_field_keys[07] = 'xccd005'
                  LET l_var_keys_bak[07] = g_detail_multi_table_t.xccd005
                  LET l_field_keys[08] = 'xccd006'
                  LET l_var_keys_bak[08] = g_detail_multi_table_t.xccd006
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xccd_t')
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xccn_m.xccnld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccn_m.xccn001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccn_m.xccn003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccn_m.xccn004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccn_m.xccn005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xccn_d_t.xccn002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccn_d_t.xccn006
 
 
                  #刪除下層單身
                  IF NOT axcq542_key_delete_b(gs_keys,'xccn_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq542_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq542_bcl
               LET l_count = g_xccn_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn002
            
            #add-point:AFTER FIELD xccn002 name="input.a.page1.xccn002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xccn_m.xccnld IS NOT NULL AND g_xccn_m.xccn001 IS NOT NULL AND g_xccn_m.xccn003 IS NOT NULL AND g_xccn_m.xccn004 IS NOT NULL AND g_xccn_m.xccn005 IS NOT NULL AND g_xccn_d[g_detail_idx].xccn002 IS NOT NULL AND g_xccn_d[g_detail_idx].xccn006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccn_m.xccnld != g_xccnld_t OR g_xccn_m.xccn001 != g_xccn001_t OR g_xccn_m.xccn003 != g_xccn003_t OR g_xccn_m.xccn004 != g_xccn004_t OR g_xccn_m.xccn005 != g_xccn005_t OR g_xccn_d[g_detail_idx].xccn002 != g_xccn_d_t.xccn002 OR g_xccn_d[g_detail_idx].xccn006 != g_xccn_d_t.xccn006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccn_t WHERE "||"xccnent = " ||g_enterprise|| " AND "||"xccnld = '"||g_xccn_m.xccnld ||"' AND "|| "xccn001 = '"||g_xccn_m.xccn001 ||"' AND "|| "xccn003 = '"||g_xccn_m.xccn003 ||"' AND "|| "xccn004 = '"||g_xccn_m.xccn004 ||"' AND "|| "xccn005 = '"||g_xccn_m.xccn005 ||"' AND "|| "xccn002 = '"||g_xccn_d[g_detail_idx].xccn002 ||"' AND "|| "xccn006 = '"||g_xccn_d[g_detail_idx].xccn006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccn_m.xccncomp
            LET g_ref_fields[2] = g_xccn_d[l_ac].xccn002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent="||g_enterprise||" AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccn_d[l_ac].xccn002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccn_d[l_ac].xccn002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn002
            #add-point:BEFORE FIELD xccn002 name="input.b.page1.xccn002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn002
            #add-point:ON CHANGE xccn002 name="input.g.page1.xccn002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn006
            #add-point:BEFORE FIELD xccn006 name="input.b.page1.xccn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn006
            
            #add-point:AFTER FIELD xccn006 name="input.a.page1.xccn006"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xccn_m.xccnld IS NOT NULL AND g_xccn_m.xccn001 IS NOT NULL AND g_xccn_m.xccn003 IS NOT NULL AND g_xccn_m.xccn004 IS NOT NULL AND g_xccn_m.xccn005 IS NOT NULL AND g_xccn_d[g_detail_idx].xccn002 IS NOT NULL AND g_xccn_d[g_detail_idx].xccn006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccn_m.xccnld != g_xccnld_t OR g_xccn_m.xccn001 != g_xccn001_t OR g_xccn_m.xccn003 != g_xccn003_t OR g_xccn_m.xccn004 != g_xccn004_t OR g_xccn_m.xccn005 != g_xccn005_t OR g_xccn_d[g_detail_idx].xccn002 != g_xccn_d_t.xccn002 OR g_xccn_d[g_detail_idx].xccn006 != g_xccn_d_t.xccn006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccn_t WHERE "||"xccnent = " ||g_enterprise|| " AND "||"xccnld = '"||g_xccn_m.xccnld ||"' AND "|| "xccn001 = '"||g_xccn_m.xccn001 ||"' AND "|| "xccn003 = '"||g_xccn_m.xccn003 ||"' AND "|| "xccn004 = '"||g_xccn_m.xccn004 ||"' AND "|| "xccn005 = '"||g_xccn_m.xccn005 ||"' AND "|| "xccn002 = '"||g_xccn_d[g_detail_idx].xccn002 ||"' AND "|| "xccn006 = '"||g_xccn_d[g_detail_idx].xccn006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn006
            #add-point:ON CHANGE xccn006 name="input.g.page1.xccn006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="input.a.page1.imag011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccn_d[l_ac].imag011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccn_d[l_ac].imag011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccn_d[l_ac].imag011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="input.b.page1.imag011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imag011
            #add-point:ON CHANGE imag011 name="input.g.page1.imag011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd007
            
            #add-point:AFTER FIELD xccd007 name="input.a.page1.xccd007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccn_d[l_ac].xccd007
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent="||g_enterprise||" AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccn_d[l_ac].xccd007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccn_d[l_ac].xccd007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd007
            #add-point:BEFORE FIELD xccd007 name="input.b.page1.xccd007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd007
            #add-point:ON CHANGE xccd007 name="input.g.page1.xccd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102
            #add-point:BEFORE FIELD xccn102 name="input.b.page1.xccn102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102
            
            #add-point:AFTER FIELD xccn102 name="input.a.page1.xccn102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102
            #add-point:ON CHANGE xccn102 name="input.g.page1.xccn102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102a
            #add-point:BEFORE FIELD xccn102a name="input.b.page1.xccn102a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102a
            
            #add-point:AFTER FIELD xccn102a name="input.a.page1.xccn102a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102a
            #add-point:ON CHANGE xccn102a name="input.g.page1.xccn102a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102b
            #add-point:BEFORE FIELD xccn102b name="input.b.page1.xccn102b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102b
            
            #add-point:AFTER FIELD xccn102b name="input.a.page1.xccn102b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102b
            #add-point:ON CHANGE xccn102b name="input.g.page1.xccn102b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102c
            #add-point:BEFORE FIELD xccn102c name="input.b.page1.xccn102c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102c
            
            #add-point:AFTER FIELD xccn102c name="input.a.page1.xccn102c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102c
            #add-point:ON CHANGE xccn102c name="input.g.page1.xccn102c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102d
            #add-point:BEFORE FIELD xccn102d name="input.b.page1.xccn102d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102d
            
            #add-point:AFTER FIELD xccn102d name="input.a.page1.xccn102d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102d
            #add-point:ON CHANGE xccn102d name="input.g.page1.xccn102d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102e
            #add-point:BEFORE FIELD xccn102e name="input.b.page1.xccn102e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102e
            
            #add-point:AFTER FIELD xccn102e name="input.a.page1.xccn102e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102e
            #add-point:ON CHANGE xccn102e name="input.g.page1.xccn102e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102f
            #add-point:BEFORE FIELD xccn102f name="input.b.page1.xccn102f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102f
            
            #add-point:AFTER FIELD xccn102f name="input.a.page1.xccn102f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102f
            #add-point:ON CHANGE xccn102f name="input.g.page1.xccn102f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102g
            #add-point:BEFORE FIELD xccn102g name="input.b.page1.xccn102g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102g
            
            #add-point:AFTER FIELD xccn102g name="input.a.page1.xccn102g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102g
            #add-point:ON CHANGE xccn102g name="input.g.page1.xccn102g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn102h
            #add-point:BEFORE FIELD xccn102h name="input.b.page1.xccn102h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn102h
            
            #add-point:AFTER FIELD xccn102h name="input.a.page1.xccn102h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn102h
            #add-point:ON CHANGE xccn102h name="input.g.page1.xccn102h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202
            #add-point:BEFORE FIELD xccn202 name="input.b.page1.xccn202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202
            
            #add-point:AFTER FIELD xccn202 name="input.a.page1.xccn202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202
            #add-point:ON CHANGE xccn202 name="input.g.page1.xccn202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202a
            #add-point:BEFORE FIELD xccn202a name="input.b.page1.xccn202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202a
            
            #add-point:AFTER FIELD xccn202a name="input.a.page1.xccn202a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202a
            #add-point:ON CHANGE xccn202a name="input.g.page1.xccn202a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202b
            #add-point:BEFORE FIELD xccn202b name="input.b.page1.xccn202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202b
            
            #add-point:AFTER FIELD xccn202b name="input.a.page1.xccn202b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202b
            #add-point:ON CHANGE xccn202b name="input.g.page1.xccn202b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202c
            #add-point:BEFORE FIELD xccn202c name="input.b.page1.xccn202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202c
            
            #add-point:AFTER FIELD xccn202c name="input.a.page1.xccn202c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202c
            #add-point:ON CHANGE xccn202c name="input.g.page1.xccn202c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202d
            #add-point:BEFORE FIELD xccn202d name="input.b.page1.xccn202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202d
            
            #add-point:AFTER FIELD xccn202d name="input.a.page1.xccn202d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202d
            #add-point:ON CHANGE xccn202d name="input.g.page1.xccn202d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202e
            #add-point:BEFORE FIELD xccn202e name="input.b.page1.xccn202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202e
            
            #add-point:AFTER FIELD xccn202e name="input.a.page1.xccn202e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202e
            #add-point:ON CHANGE xccn202e name="input.g.page1.xccn202e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202f
            #add-point:BEFORE FIELD xccn202f name="input.b.page1.xccn202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202f
            
            #add-point:AFTER FIELD xccn202f name="input.a.page1.xccn202f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202f
            #add-point:ON CHANGE xccn202f name="input.g.page1.xccn202f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202g
            #add-point:BEFORE FIELD xccn202g name="input.b.page1.xccn202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202g
            
            #add-point:AFTER FIELD xccn202g name="input.a.page1.xccn202g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202g
            #add-point:ON CHANGE xccn202g name="input.g.page1.xccn202g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn202h
            #add-point:BEFORE FIELD xccn202h name="input.b.page1.xccn202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn202h
            
            #add-point:AFTER FIELD xccn202h name="input.a.page1.xccn202h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn202h
            #add-point:ON CHANGE xccn202h name="input.g.page1.xccn202h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302
            #add-point:BEFORE FIELD xccn302 name="input.b.page1.xccn302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302
            
            #add-point:AFTER FIELD xccn302 name="input.a.page1.xccn302"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302
            #add-point:ON CHANGE xccn302 name="input.g.page1.xccn302"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302a
            #add-point:BEFORE FIELD xccn302a name="input.b.page1.xccn302a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302a
            
            #add-point:AFTER FIELD xccn302a name="input.a.page1.xccn302a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302a
            #add-point:ON CHANGE xccn302a name="input.g.page1.xccn302a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302b
            #add-point:BEFORE FIELD xccn302b name="input.b.page1.xccn302b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302b
            
            #add-point:AFTER FIELD xccn302b name="input.a.page1.xccn302b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302b
            #add-point:ON CHANGE xccn302b name="input.g.page1.xccn302b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302c
            #add-point:BEFORE FIELD xccn302c name="input.b.page1.xccn302c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302c
            
            #add-point:AFTER FIELD xccn302c name="input.a.page1.xccn302c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302c
            #add-point:ON CHANGE xccn302c name="input.g.page1.xccn302c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302d
            #add-point:BEFORE FIELD xccn302d name="input.b.page1.xccn302d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302d
            
            #add-point:AFTER FIELD xccn302d name="input.a.page1.xccn302d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302d
            #add-point:ON CHANGE xccn302d name="input.g.page1.xccn302d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302e
            #add-point:BEFORE FIELD xccn302e name="input.b.page1.xccn302e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302e
            
            #add-point:AFTER FIELD xccn302e name="input.a.page1.xccn302e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302e
            #add-point:ON CHANGE xccn302e name="input.g.page1.xccn302e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302f
            #add-point:BEFORE FIELD xccn302f name="input.b.page1.xccn302f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302f
            
            #add-point:AFTER FIELD xccn302f name="input.a.page1.xccn302f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302f
            #add-point:ON CHANGE xccn302f name="input.g.page1.xccn302f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302g
            #add-point:BEFORE FIELD xccn302g name="input.b.page1.xccn302g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302g
            
            #add-point:AFTER FIELD xccn302g name="input.a.page1.xccn302g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302g
            #add-point:ON CHANGE xccn302g name="input.g.page1.xccn302g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccn302h
            #add-point:BEFORE FIELD xccn302h name="input.b.page1.xccn302h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccn302h
            
            #add-point:AFTER FIELD xccn302h name="input.a.page1.xccn302h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccn302h
            #add-point:ON CHANGE xccn302h name="input.g.page1.xccn302h"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xccn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn002
            #add-point:ON ACTION controlp INFIELD xccn002 name="input.c.page1.xccn002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn006
            #add-point:ON ACTION controlp INFIELD xccn006 name="input.c.page1.xccn006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="input.c.page1.imag011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xccn_d[l_ac].imag011             #給予default值
            LET g_qryparam.default2 = "" #g_xccn_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_xccn_d[l_ac].imag011 = g_qryparam.return1              
            #LET g_xccn_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_xccn_d[l_ac].imag011 TO imag011              #
            #DISPLAY g_xccn_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD imag011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.xccd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd007
            #add-point:ON ACTION controlp INFIELD xccd007 name="input.c.page1.xccd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102
            #add-point:ON ACTION controlp INFIELD xccn102 name="input.c.page1.xccn102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102a
            #add-point:ON ACTION controlp INFIELD xccn102a name="input.c.page1.xccn102a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102b
            #add-point:ON ACTION controlp INFIELD xccn102b name="input.c.page1.xccn102b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102c
            #add-point:ON ACTION controlp INFIELD xccn102c name="input.c.page1.xccn102c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102d
            #add-point:ON ACTION controlp INFIELD xccn102d name="input.c.page1.xccn102d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102e
            #add-point:ON ACTION controlp INFIELD xccn102e name="input.c.page1.xccn102e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102f
            #add-point:ON ACTION controlp INFIELD xccn102f name="input.c.page1.xccn102f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102g
            #add-point:ON ACTION controlp INFIELD xccn102g name="input.c.page1.xccn102g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn102h
            #add-point:ON ACTION controlp INFIELD xccn102h name="input.c.page1.xccn102h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202
            #add-point:ON ACTION controlp INFIELD xccn202 name="input.c.page1.xccn202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202a
            #add-point:ON ACTION controlp INFIELD xccn202a name="input.c.page1.xccn202a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202b
            #add-point:ON ACTION controlp INFIELD xccn202b name="input.c.page1.xccn202b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202c
            #add-point:ON ACTION controlp INFIELD xccn202c name="input.c.page1.xccn202c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202d
            #add-point:ON ACTION controlp INFIELD xccn202d name="input.c.page1.xccn202d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202e
            #add-point:ON ACTION controlp INFIELD xccn202e name="input.c.page1.xccn202e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202f
            #add-point:ON ACTION controlp INFIELD xccn202f name="input.c.page1.xccn202f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202g
            #add-point:ON ACTION controlp INFIELD xccn202g name="input.c.page1.xccn202g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn202h
            #add-point:ON ACTION controlp INFIELD xccn202h name="input.c.page1.xccn202h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302
            #add-point:ON ACTION controlp INFIELD xccn302 name="input.c.page1.xccn302"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302a
            #add-point:ON ACTION controlp INFIELD xccn302a name="input.c.page1.xccn302a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302b
            #add-point:ON ACTION controlp INFIELD xccn302b name="input.c.page1.xccn302b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302c
            #add-point:ON ACTION controlp INFIELD xccn302c name="input.c.page1.xccn302c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302d
            #add-point:ON ACTION controlp INFIELD xccn302d name="input.c.page1.xccn302d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302e
            #add-point:ON ACTION controlp INFIELD xccn302e name="input.c.page1.xccn302e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302f
            #add-point:ON ACTION controlp INFIELD xccn302f name="input.c.page1.xccn302f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302g
            #add-point:ON ACTION controlp INFIELD xccn302g name="input.c.page1.xccn302g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccn302h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccn302h
            #add-point:ON ACTION controlp INFIELD xccn302h name="input.c.page1.xccn302h"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xccn_d[l_ac].* = g_xccn_d_t.*
               CLOSE axcq542_bcl
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
               LET g_errparam.extend = g_xccn_d[l_ac].xccn002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccn_d[l_ac].* = g_xccn_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq542_xccn_t_mask_restore('restore_mask_o')
         
               UPDATE xccn_t SET (xccnld,xccn001,xccn003,xccn004,xccn005,xccn002,xccn006,xccn102,xccn102a, 
                   xccn102b,xccn102c,xccn102d,xccn102e,xccn102f,xccn102g,xccn102h,xccn202,xccn202a,xccn202b, 
                   xccn202c,xccn202d,xccn202e,xccn202f,xccn202g,xccn202h,xccn302,xccn302a,xccn302b,xccn302c, 
                   xccn302d,xccn302e,xccn302f,xccn302g,xccn302h) = (g_xccn_m.xccnld,g_xccn_m.xccn001, 
                   g_xccn_m.xccn003,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_d[l_ac].xccn002,g_xccn_d[l_ac].xccn006, 
                   g_xccn_d[l_ac].xccn102,g_xccn_d[l_ac].xccn102a,g_xccn_d[l_ac].xccn102b,g_xccn_d[l_ac].xccn102c, 
                   g_xccn_d[l_ac].xccn102d,g_xccn_d[l_ac].xccn102e,g_xccn_d[l_ac].xccn102f,g_xccn_d[l_ac].xccn102g, 
                   g_xccn_d[l_ac].xccn102h,g_xccn_d[l_ac].xccn202,g_xccn_d[l_ac].xccn202a,g_xccn_d[l_ac].xccn202b, 
                   g_xccn_d[l_ac].xccn202c,g_xccn_d[l_ac].xccn202d,g_xccn_d[l_ac].xccn202e,g_xccn_d[l_ac].xccn202f, 
                   g_xccn_d[l_ac].xccn202g,g_xccn_d[l_ac].xccn202h,g_xccn_d[l_ac].xccn302,g_xccn_d[l_ac].xccn302a, 
                   g_xccn_d[l_ac].xccn302b,g_xccn_d[l_ac].xccn302c,g_xccn_d[l_ac].xccn302d,g_xccn_d[l_ac].xccn302e, 
                   g_xccn_d[l_ac].xccn302f,g_xccn_d[l_ac].xccn302g,g_xccn_d[l_ac].xccn302h)
                WHERE xccnent = g_enterprise AND xccnld = g_xccn_m.xccnld 
                 AND xccn001 = g_xccn_m.xccn001 
                 AND xccn003 = g_xccn_m.xccn003 
                 AND xccn004 = g_xccn_m.xccn004 
                 AND xccn005 = g_xccn_m.xccn005 
 
                 AND xccn002 = g_xccn_d_t.xccn002 #項次   
                 AND xccn006 = g_xccn_d_t.xccn006  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
{
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccn_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccn_m.xccnld
               LET gs_keys_bak[1] = g_xccnld_t
               LET gs_keys[2] = g_xccn_m.xccn001
               LET gs_keys_bak[2] = g_xccn001_t
               LET gs_keys[3] = g_xccn_m.xccn003
               LET gs_keys_bak[3] = g_xccn003_t
               LET gs_keys[4] = g_xccn_m.xccn004
               LET gs_keys_bak[4] = g_xccn004_t
               LET gs_keys[5] = g_xccn_m.xccn005
               LET gs_keys_bak[5] = g_xccn005_t
               LET gs_keys[6] = g_xccn_d[g_detail_idx].xccn002
               LET gs_keys_bak[6] = g_xccn_d_t.xccn002
               LET gs_keys[7] = g_xccn_d[g_detail_idx].xccn006
               LET gs_keys_bak[7] = g_xccn_d_t.xccn006
               CALL axcq542_update_b('xccn_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xccn_m.xccnld = g_detail_multi_table_t.imag001 AND
         g_xccn_m.xccn001 = g_detail_multi_table_t.imag011 AND
         g_xccn_m.xccn003 =  AND
         g_xccn_m.xccn004 =  AND
         g_xccn_m.xccn005 =  AND
         g_xccn_d[l_ac].xccn002 =  AND
         g_xccn_d[l_ac].xccn006 =  AND
         g_xccn_d[l_ac].imag011 =  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imagent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_site
            LET l_field_keys[02] = 'imagsite'
            LET l_var_keys_bak[02] = g_site
            LET l_var_keys[03] = g_xccn_m.xccnld
            LET l_field_keys[03] = 'imag001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.imag001
            LET l_vars[01] = g_xccn_d[l_ac].imag011
            LET l_fields[01] = 'imag011'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imag_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xccn_m.xccnld = g_detail_multi_table_t.xccdld AND
         g_xccn_m.xccn001 = g_detail_multi_table_t.xccd001 AND
         g_xccn_m.xccn003 = g_detail_multi_table_t.xccd002 AND
         g_xccn_m.xccn004 = g_detail_multi_table_t.xccd003 AND
         g_xccn_m.xccn005 = g_detail_multi_table_t.xccd004 AND
         g_xccn_d[l_ac].xccn002 = g_detail_multi_table_t.xccd005 AND
         g_xccn_d[l_ac].xccn006 = g_detail_multi_table_t.xccd006 AND
         g_xccn_d[l_ac].xccd007 = g_detail_multi_table_t.xccd007 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xccdent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xccn_m.xccnld
            LET l_field_keys[02] = 'xccdld'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xccdld
            LET l_var_keys[03] = g_xccn_m.xccn001
            LET l_field_keys[03] = 'xccd001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.xccd001
            LET l_var_keys[04] = g_xccn_m.xccn003
            LET l_field_keys[04] = 'xccd002'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.xccd002
            LET l_var_keys[05] = g_xccn_m.xccn004
            LET l_field_keys[05] = 'xccd003'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.xccd003
            LET l_var_keys[06] = g_xccn_m.xccn005
            LET l_field_keys[06] = 'xccd004'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.xccd004
            LET l_var_keys[07] = g_xccn_d[l_ac].xccn002
            LET l_field_keys[07] = 'xccd005'
            LET l_var_keys_bak[07] = g_detail_multi_table_t.xccd005
            LET l_var_keys[08] = g_xccn_d[l_ac].xccn006
            LET l_field_keys[08] = 'xccd006'
            LET l_var_keys_bak[08] = g_detail_multi_table_t.xccd006
            LET l_vars[01] = g_xccn_d[l_ac].xccd007
            LET l_fields[01] = 'xccd007'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xccd_t')
         END IF 
 
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xccn_m),util.JSON.stringify(g_xccn_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccn_m),util.JSON.stringify(g_xccn_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq542_xccn_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccn_m.xccnld
               LET ls_keys[ls_keys.getLength()+1] = g_xccn_m.xccn001
               LET ls_keys[ls_keys.getLength()+1] = g_xccn_m.xccn003
               LET ls_keys[ls_keys.getLength()+1] = g_xccn_m.xccn004
               LET ls_keys[ls_keys.getLength()+1] = g_xccn_m.xccn005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccn_d_t.xccn002
               LET ls_keys[ls_keys.getLength()+1] = g_xccn_d_t.xccn006
 
               CALL axcq542_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
}
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq542_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccn_d[l_ac].* = g_xccn_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq542_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccn_d.getLength() = 0 THEN
               NEXT FIELD xccn002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xccn_d[li_reproduce_target].* = g_xccn_d[li_reproduce].*
 
               LET g_xccn_d[li_reproduce_target].xccn002 = NULL
               LET g_xccn_d[li_reproduce_target].xccn006 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xccn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xccn_d.getLength()+1
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
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccnld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccn002
 
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
 
 
   
   #add-point:input段after_input name="input.after_input"
 
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq542_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xccn_m.xccncomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xccn_m.xccncomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否     
   END IF  
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccn002,xccn002_desc',TRUE)                    
   ELSE                                             
      CALL cl_set_comp_visible('xccn002,xccn002_desc',FALSE)                
   END IF   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq542_b_fill(g_wc2) #第一階單身填充
      CALL axcq542_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq542_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccn_m.xccnld
   CASE g_xccn_m.xccn001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccn_m.xccn001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccn_m.xccn001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccn_m.xccn001_desc = '', g_rtn_fields[1] , ''
   END CASE      
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xccn_m.xccncomp,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld,g_xccn_m.xccnld_desc,g_xccn_m.xccn004, 
       g_xccn_m.xccn005,g_xccn_m.xccn004_1,g_xccn_m.xccn005_1,g_xccn_m.xccn003,g_xccn_m.xccn003_desc, 
       g_xccn_m.xccn001,g_xccn_m.xccn001_desc
 
   CALL axcq542_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   DISPLAY g_yy1 TO xccn004
   DISPLAY g_mm1 TO xccn005
   DISPLAY g_yy2 TO xccn004_1
   DISPLAY g_mm2 TO xccn005_1
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq542_ref_show()
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
   FOR l_ac = 1 TO g_xccn_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq542.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq542_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xccn_t.xccnld 
   DEFINE l_oldno     LIKE xccn_t.xccnld 
   DEFINE l_newno02     LIKE xccn_t.xccn001 
   DEFINE l_oldno02     LIKE xccn_t.xccn001 
   DEFINE l_newno03     LIKE xccn_t.xccn003 
   DEFINE l_oldno03     LIKE xccn_t.xccn003 
   DEFINE l_newno04     LIKE xccn_t.xccn004 
   DEFINE l_oldno04     LIKE xccn_t.xccn004 
   DEFINE l_newno05     LIKE xccn_t.xccn005 
   DEFINE l_oldno05     LIKE xccn_t.xccn005 
 
   DEFINE l_master    RECORD LIKE xccn_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xccn_t.* #此變數樣板目前無使用
 
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
 
   IF g_xccn_m.xccnld IS NULL
      OR g_xccn_m.xccn001 IS NULL
      OR g_xccn_m.xccn003 IS NULL
      OR g_xccn_m.xccn004 IS NULL
      OR g_xccn_m.xccn005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xccnld_t = g_xccn_m.xccnld
   LET g_xccn001_t = g_xccn_m.xccn001
   LET g_xccn003_t = g_xccn_m.xccn003
   LET g_xccn004_t = g_xccn_m.xccn004
   LET g_xccn005_t = g_xccn_m.xccn005
 
   
   LET g_xccn_m.xccnld = ""
   LET g_xccn_m.xccn001 = ""
   LET g_xccn_m.xccn003 = ""
   LET g_xccn_m.xccn004 = ""
   LET g_xccn_m.xccn005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq542_set_entry('a')
   CALL axcq542_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xccn_m.xccnld_desc = ''
   DISPLAY BY NAME g_xccn_m.xccnld_desc
   LET g_xccn_m.xccn003_desc = ''
   DISPLAY BY NAME g_xccn_m.xccn003_desc
   LET g_xccn_m.xccn001_desc = ''
   DISPLAY BY NAME g_xccn_m.xccn001_desc
 
   
   CALL axcq542_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccn_m.* TO NULL
      INITIALIZE g_xccn_d TO NULL
 
      CALL axcq542_show()
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
   CALL axcq542_set_act_visible()
   CALL axcq542_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccnld_t = g_xccn_m.xccnld
   LET g_xccn001_t = g_xccn_m.xccn001
   LET g_xccn003_t = g_xccn_m.xccn003
   LET g_xccn004_t = g_xccn_m.xccn004
   LET g_xccn005_t = g_xccn_m.xccn005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccnent = " ||g_enterprise|| " AND",
                      " xccnld = '", g_xccn_m.xccnld, "' "
                      ," AND xccn001 = '", g_xccn_m.xccn001, "' "
                      ," AND xccn003 = '", g_xccn_m.xccn003, "' "
                      ," AND xccn004 = '", g_xccn_m.xccn004, "' "
                      ," AND xccn005 = '", g_xccn_m.xccn005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq542_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq542_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq542_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq542_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xccn_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq542_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xccn_t
    WHERE xccnent = g_enterprise AND xccnld = g_xccnld_t
    AND xccn001 = g_xccn001_t
    AND xccn003 = g_xccn003_t
    AND xccn004 = g_xccn004_t
    AND xccn005 = g_xccn005_t
 
       INTO TEMP axcq542_detail
   
   #將key修正為調整後   
   UPDATE axcq542_detail 
      #更新key欄位
      SET xccnld = g_xccn_m.xccnld
          , xccn001 = g_xccn_m.xccn001
          , xccn003 = g_xccn_m.xccn003
          , xccn004 = g_xccn_m.xccn004
          , xccn005 = g_xccn_m.xccn005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccn_t SELECT * FROM axcq542_detail
   
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
   DROP TABLE axcq542_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE axcq542_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
{
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM imag_t 
    WHERE imagent = g_enterprise AND imag001 = g_xccnld_t
      AND  = g_xccn001_t      AND  = g_xccn003_t      AND  = g_xccn004_t      AND  = g_xccn005_t
     INTO TEMP axcq542_detail_lang
 
   #將key修正為調整後   
   UPDATE axcq542_detail_lang 
      #更新key欄位
      SET imag001 = g_xccn_m.xccnld
          ,  = g_xccn_m.xccn001          ,  = g_xccn_m.xccn003          ,  = g_xccn_m.xccn004          ,  = g_xccn_m.xccn005
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
}
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO imag_t SELECT * FROM axcq542_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq542_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
   #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE axcq542_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM xccd_t 
    WHERE xccdent = g_enterprise AND xccdld = g_xccnld_t
      AND xccd001 = g_xccn001_t      AND xccd002 = g_xccn003_t      AND xccd003 = g_xccn004_t      AND xccd004 = g_xccn005_t
     INTO TEMP axcq542_detail_lang
 
   #將key修正為調整後   
   UPDATE axcq542_detail_lang 
      #更新key欄位
      SET xccdld = g_xccn_m.xccnld
          , xccd001 = g_xccn_m.xccn001          , xccd002 = g_xccn_m.xccn003          , xccd003 = g_xccn_m.xccn004          , xccd004 = g_xccn_m.xccn005
  
   #add-point:單身修改前 name="detail_reproduce.body.lang1.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO xccd_t SELECT * FROM axcq542_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang1.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq542_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang1.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccnld_t = g_xccn_m.xccnld
   LET g_xccn001_t = g_xccn_m.xccn001
   LET g_xccn003_t = g_xccn_m.xccn003
   LET g_xccn004_t = g_xccn_m.xccn004
   LET g_xccn005_t = g_xccn_m.xccn005
 
   
   DROP TABLE axcq542_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq542_delete()
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
   
   IF g_xccn_m.xccnld IS NULL
   OR g_xccn_m.xccn001 IS NULL
   OR g_xccn_m.xccn003 IS NULL
   OR g_xccn_m.xccn004 IS NULL
   OR g_xccn_m.xccn005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq542_cl USING g_enterprise,g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004,g_xccn_m.xccn005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq542_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq542_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq542_master_referesh USING g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004, 
       g_xccn_m.xccn005 INTO g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn004,g_xccn_m.xccn005,g_xccn_m.xccn003, 
       g_xccn_m.xccn001,g_xccn_m.xccncomp_desc,g_xccn_m.xccnld_desc,g_xccn_m.xccn003_desc,g_xccn_m.xccn001_desc 
 
   
   #遮罩相關處理
   LET g_xccn_m_mask_o.* =  g_xccn_m.*
   CALL axcq542_xccn_t_mask()
   LET g_xccn_m_mask_n.* =  g_xccn_m.*
   
   CALL axcq542_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq542_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xccn_t WHERE xccnent = g_enterprise AND xccnld = g_xccn_m.xccnld
                                                               AND xccn001 = g_xccn_m.xccn001
                                                               AND xccn003 = g_xccn_m.xccn003
                                                               AND xccn004 = g_xccn_m.xccn004
                                                               AND xccn005 = g_xccn_m.xccn005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccn_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'xccdent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'xccdld'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.xccdld
         LET l_field_keys[02] = 'xccd001'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd001
         LET l_field_keys[02] = 'xccd002'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd002
         LET l_field_keys[02] = 'xccd003'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd003
         LET l_field_keys[02] = 'xccd004'
         LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd004
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xccd_t')
 
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE axcq542_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xccn_d.clear() 
 
     
      CALL axcq542_ui_browser_refresh()  
      #CALL axcq542_ui_headershow()  
      #CALL axcq542_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq542_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq542_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq542_cl
 
   #功能已完成,通報訊息中心
   CALL axcq542_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq542.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq542_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   CALL axcq542_b_fill_1(p_wc2)
   RETURN

   #end add-point
   
   #先清空單身變數內容
   CALL g_xccn_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccn002,xccn006,xccn102,xccn102a,xccn102b,xccn102c,xccn102d,xccn102e, 
       xccn102f,xccn102g,xccn102h,xccn202,xccn202a,xccn202b,xccn202c,xccn202d,xccn202e,xccn202f,xccn202g, 
       xccn202h,xccn302,xccn302a,xccn302b,xccn302c,xccn302d,xccn302e,xccn302f,xccn302g,xccn302h,t1.xcbfl003 FROM xccn_t", 
          
               " LEFT JOIN imag_t ON imagent = "||g_enterprise||" AND imagsite = '"||g_site||"' AND xccnld = imag001xccn001 = xccn003 = xccn004 = xccn005 = xccn002 = xccn006 =  LEFT JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn003 = xccd002 AND xccn004 = xccd003 AND xccn005 = xccd004 AND xccn002 = xccd005 AND xccn006 = xccd006",
               
                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent="||g_enterprise||" AND t1.xcbflcomp=xccncomp AND t1.xcbfl001=xccn002 AND t1.xcbfl002='"||g_dlang||"' ",
 
               " WHERE xccnent= ? AND xccnld=? AND xccn001=? AND xccn003=? AND xccn004=? AND xccn005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccn_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq542_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xccn_t.xccn002,xccn_t.xccn006"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq542_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq542_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004,g_xccn_m.xccn005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003,g_xccn_m.xccn004, 
          g_xccn_m.xccn005 INTO g_xccn_d[l_ac].xccn002,g_xccn_d[l_ac].xccn006,g_xccn_d[l_ac].xccn102, 
          g_xccn_d[l_ac].xccn102a,g_xccn_d[l_ac].xccn102b,g_xccn_d[l_ac].xccn102c,g_xccn_d[l_ac].xccn102d, 
          g_xccn_d[l_ac].xccn102e,g_xccn_d[l_ac].xccn102f,g_xccn_d[l_ac].xccn102g,g_xccn_d[l_ac].xccn102h, 
          g_xccn_d[l_ac].xccn202,g_xccn_d[l_ac].xccn202a,g_xccn_d[l_ac].xccn202b,g_xccn_d[l_ac].xccn202c, 
          g_xccn_d[l_ac].xccn202d,g_xccn_d[l_ac].xccn202e,g_xccn_d[l_ac].xccn202f,g_xccn_d[l_ac].xccn202g, 
          g_xccn_d[l_ac].xccn202h,g_xccn_d[l_ac].xccn302,g_xccn_d[l_ac].xccn302a,g_xccn_d[l_ac].xccn302b, 
          g_xccn_d[l_ac].xccn302c,g_xccn_d[l_ac].xccn302d,g_xccn_d[l_ac].xccn302e,g_xccn_d[l_ac].xccn302f, 
          g_xccn_d[l_ac].xccn302g,g_xccn_d[l_ac].xccn302h,g_xccn_d[l_ac].xccn002_desc   #(ver:49)
                             
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
 
            CALL g_xccn_d.deleteElement(g_xccn_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
 
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccn_d.getLength()
      LET g_xccn_d_mask_o[l_ac].* =  g_xccn_d[l_ac].*
      CALL axcq542_xccn_t_mask()
      LET g_xccn_d_mask_n[l_ac].* =  g_xccn_d[l_ac].*
   END FOR
   
 
 
   FREE axcq542_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq542_idx_chk()
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
      IF g_detail_idx > g_xccn_d.getLength() THEN
         LET g_detail_idx = g_xccn_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xccn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccn_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq542_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xccn_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq542_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xccn_t
    WHERE xccnent = g_enterprise AND xccnld = g_xccn_m.xccnld AND
                              xccn001 = g_xccn_m.xccn001 AND
                              xccn003 = g_xccn_m.xccn003 AND
                              xccn004 = g_xccn_m.xccn004 AND
                              xccn005 = g_xccn_m.xccn005 AND
 
          xccn002 = g_xccn_d_t.xccn002
      AND xccn006 = g_xccn_d_t.xccn006
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccn_t:",SQLERRMESSAGE 
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
 
{<section id="axcq542.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq542_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq542.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq542_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq542.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq542_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq542.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq542_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xccn_d[l_ac].xccn002 = g_xccn_d_t.xccn002 
      AND g_xccn_d[l_ac].xccn006 = g_xccn_d_t.xccn006 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq542_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq542.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq542_lock_b(ps_table,ps_page)
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
   #CALL axcq542_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq542.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq542_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq542.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq542_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccnld,xccn001,xccn003,xccn004,xccn005",TRUE)
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
 
{<section id="axcq542.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq542_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccnld,xccn001,xccn003,xccn004,xccn005",FALSE)
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
 
{<section id="axcq542.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq542_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq542_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq542_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq542.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq542_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq542.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq542_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq542.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq542_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq542.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq542_default_search()
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
      LET ls_wc = ls_wc, " xccnld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccn001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccn003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccn004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xccn005 = '", g_argv[05], "' AND "
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
 
{<section id="axcq542.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq542_fill_chk(ps_idx)
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
 
{<section id="axcq542.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq542_modify_detail_chk(ps_record)
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
         LET ls_return = "xccn002"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq542.mask_functions" >}
&include "erp/axc/axcq542_mask.4gl"
 
{</section>}
 
{<section id="axcq542.state_change" >}
    
 
{</section>}
 
{<section id="axcq542.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq542_set_pk_array()
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
   LET g_pk_array[1].values = g_xccn_m.xccnld
   LET g_pk_array[1].column = 'xccnld'
   LET g_pk_array[2].values = g_xccn_m.xccn001
   LET g_pk_array[2].column = 'xccn001'
   LET g_pk_array[3].values = g_xccn_m.xccn003
   LET g_pk_array[3].column = 'xccn003'
   LET g_pk_array[4].values = g_xccn_m.xccn004
   LET g_pk_array[4].column = 'xccn004'
   LET g_pk_array[5].values = g_xccn_m.xccn005
   LET g_pk_array[5].column = 'xccn005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq542.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq542_msgcentre_notify(lc_state)
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
   CALL axcq542_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xccn_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq542.other_function" readonly="Y" >}

PRIVATE FUNCTION axcq542_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   IF cl_null(g_xccn_m.xccncomp) AND cl_null(g_xccn_m.xccnld) AND cl_null(g_yy1) AND cl_null(g_mm1) 
             AND cl_null(g_yy2) AND cl_null(g_mm2) AND cl_null(g_xccn_m.xccn003) AND cl_null(g_xccn_m.xccn001) THEN
      CALL s_axc_set_site_default() RETURNING g_xccn_m.xccncomp,g_xccn_m.xccnld,g_yy2,g_mm2,g_xccn_m.xccn003
      DISPLAY BY NAME g_xccn_m.xccncomp,g_xccn_m.xccnld,g_xccn_m.xccn003
      LET g_yy1 = g_yy2
      LET g_mm1 = g_mm2
      DISPLAY g_yy1 TO xccn004
      DISPLAY g_mm1 TO xccn005
      DISPLAY g_yy2 TO xccn004_1
      DISPLAY g_mm2 TO xccn005_1
   END IF
   
   CALL s_desc_get_department_desc(g_xccn_m.xccncomp) RETURNING g_xccn_m.xccncomp_desc
   DISPLAY BY NAME g_xccn_m.xccncomp_desc 
   
   CALL s_desc_get_ld_desc(g_xccn_m.xccnld) RETURNING g_xccn_m.xccnld_desc
   DISPLAY BY NAME g_xccn_m.xccnld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccn_m.xccn003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccn_m.xccn003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccn_m.xccn003_desc
      
   LET g_xccn_m.xccn001 = '1'
   DISPLAY BY NAME g_xccn_m.xccn001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccn_m.xccnld

   CALL s_desc_get_currency_desc(l_glaa001) RETURNING g_xccn_m.xccn001_desc
   DISPLAY BY NAME g_xccn_m.xccn001_desc
END FUNCTION

PRIVATE FUNCTION axcq542_filter()
   DEFINE  ls_result   STRING
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc2_table1 ON xccn002,xccn006,xccd007,xccn102,xccn102a,xccn102b,xccn102c,xccn102d, 
          xccn102e,xccn102f,xccn102g,xccn102h,xccn202,xccn202a,xccn202b,xccn202c,xccn202d,xccn202e,xccn202f, 
          xccn202g,xccn202h,xccn302,xccn302a,xccn302b,xccn302c,xccn302d,xccn302e,xccn302f,xccn302g,xccn302h 

           FROM s_detail1[1].xccn002,s_detail1[1].xccn006,s_detail1[1].xccd007,s_detail1[1].xccn102, 
                s_detail1[1].xccn102a,s_detail1[1].xccn102b,s_detail1[1].xccn102c,s_detail1[1].xccn102d, 
                s_detail1[1].xccn102e,s_detail1[1].xccn102f,s_detail1[1].xccn102g,s_detail1[1].xccn102h, 
                s_detail1[1].xccn202,s_detail1[1].xccn202a,s_detail1[1].xccn202b,s_detail1[1].xccn202c, 
                s_detail1[1].xccn202d,s_detail1[1].xccn202e,s_detail1[1].xccn202f,s_detail1[1].xccn202g, 
                s_detail1[1].xccn202h,s_detail1[1].xccn302,s_detail1[1].xccn302a,s_detail1[1].xccn302b, 
                s_detail1[1].xccn302c,s_detail1[1].xccn302d,s_detail1[1].xccn302e,s_detail1[1].xccn302f, 
                s_detail1[1].xccn302g,s_detail1[1].xccn302h
               
         BEFORE CONSTRUCT  
            DISPLAY axcq542_filter_parser('xccn002')  TO s_detail1[1].xccn002
            DISPLAY axcq542_filter_parser('xccn006')  TO s_detail1[1].xccn006
            DISPLAY axcq542_filter_parser('xccd007')  TO s_detail1[1].xccd007 
            DISPLAY axcq542_filter_parser('xccn102')  TO s_detail1[1].xccn102
            DISPLAY axcq542_filter_parser('xccn102a') TO s_detail1[1].xccn102a 
            DISPLAY axcq542_filter_parser('xccn102b') TO s_detail1[1].xccn102b 
            DISPLAY axcq542_filter_parser('xccn102c') TO s_detail1[1].xccn102c 
            DISPLAY axcq542_filter_parser('xccn102d') TO s_detail1[1].xccn102d 
            DISPLAY axcq542_filter_parser('xccn102e') TO s_detail1[1].xccn102e 
            DISPLAY axcq542_filter_parser('xccn102f') TO s_detail1[1].xccn102f 
            DISPLAY axcq542_filter_parser('xccn102g') TO s_detail1[1].xccn102g 
            DISPLAY axcq542_filter_parser('xccn102h') TO s_detail1[1].xccn102h 
            DISPLAY axcq542_filter_parser('xccn202')  TO s_detail1[1].xccn202
            DISPLAY axcq542_filter_parser('xccn202a') TO s_detail1[1].xccn202a 
            DISPLAY axcq542_filter_parser('xccn202b') TO s_detail1[1].xccn202b 
            DISPLAY axcq542_filter_parser('xccn202c') TO s_detail1[1].xccn202c 
            DISPLAY axcq542_filter_parser('xccn202d') TO s_detail1[1].xccn202d 
            DISPLAY axcq542_filter_parser('xccn202e') TO s_detail1[1].xccn202e 
            DISPLAY axcq542_filter_parser('xccn202f') TO s_detail1[1].xccn202f 
            DISPLAY axcq542_filter_parser('xccn202g') TO s_detail1[1].xccn202g 
            DISPLAY axcq542_filter_parser('xccn202h') TO s_detail1[1].xccn202h 
            DISPLAY axcq542_filter_parser('xccn302')  TO s_detail1[1].xccn302
            DISPLAY axcq542_filter_parser('xccn302a') TO s_detail1[1].xccn302a 
            DISPLAY axcq542_filter_parser('xccn302b') TO s_detail1[1].xccn302b 
            DISPLAY axcq542_filter_parser('xccn302c') TO s_detail1[1].xccn302c 
            DISPLAY axcq542_filter_parser('xccn302d') TO s_detail1[1].xccn302d 
            DISPLAY axcq542_filter_parser('xccn302e') TO s_detail1[1].xccn302e 
            DISPLAY axcq542_filter_parser('xccn302f') TO s_detail1[1].xccn302f 
            DISPLAY axcq542_filter_parser('xccn302g') TO s_detail1[1].xccn302g 
            DISPLAY axcq542_filter_parser('xccn302h') TO s_detail1[1].xccn302h   

         ON ACTION controlp INFIELD xccn002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccn002  #顯示到畫面上            
            NEXT FIELD xccn002                     #返回原欄位

         ON ACTION controlp INFIELD xccn006
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccn006  #顯示到畫面上
            NEXT FIELD xccn006                     #返回原欄位
        
         ON ACTION controlp INFIELD xccd007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007  #顯示到畫面上
            NEXT FIELD xccd007                     #返回原欄位

      END CONSTRUCT

      BEFORE DIALOG

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
  
   CALL axcq542_browser_fill("")
   CALL axcq542_b_fill(g_wc) 
   LET g_wc = g_wc_t
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

PRIVATE FUNCTION axcq542_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   
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

PRIVATE FUNCTION axcq542_b_fill_1(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #小计定义
   DEFINE l_xccn102_sum LIKE xccn_t.xccn102, 
          l_xccn102a_sum LIKE xccn_t.xccn102a, 
          l_xccn102b_sum LIKE xccn_t.xccn102b, 
          l_xccn102c_sum LIKE xccn_t.xccn102c, 
          l_xccn102d_sum LIKE xccn_t.xccn102d, 
          l_xccn102e_sum LIKE xccn_t.xccn102e, 
          l_xccn102f_sum LIKE xccn_t.xccn102f, 
          l_xccn102g_sum LIKE xccn_t.xccn102g, 
          l_xccn102h_sum LIKE xccn_t.xccn102h, 
          l_xccn202_sum LIKE xccn_t.xccn202, 
          l_xccn202a_sum LIKE xccn_t.xccn202a, 
          l_xccn202b_sum LIKE xccn_t.xccn202b, 
          l_xccn202c_sum LIKE xccn_t.xccn202c, 
          l_xccn202d_sum LIKE xccn_t.xccn202d, 
          l_xccn202e_sum LIKE xccn_t.xccn202e, 
          l_xccn202f_sum LIKE xccn_t.xccn202f, 
          l_xccn202g_sum LIKE xccn_t.xccn202g, 
          l_xccn202h_sum LIKE xccn_t.xccn202h, 
          l_xccn302_sum LIKE xccn_t.xccn302, 
          l_xccn302a_sum LIKE xccn_t.xccn302a, 
          l_xccn302b_sum LIKE xccn_t.xccn302b, 
          l_xccn302c_sum LIKE xccn_t.xccn302c, 
          l_xccn302d_sum LIKE xccn_t.xccn302d, 
          l_xccn302e_sum LIKE xccn_t.xccn302e, 
          l_xccn302f_sum LIKE xccn_t.xccn302f, 
          l_xccn302g_sum LIKE xccn_t.xccn302g, 
          l_xccn302h_sum LIKE xccn_t.xccn302h
   #合计定义
   DEFINE l_xccn102_total LIKE xccn_t.xccn102, 
          l_xccn102a_total LIKE xccn_t.xccn102a, 
          l_xccn102b_total LIKE xccn_t.xccn102b, 
          l_xccn102c_total LIKE xccn_t.xccn102c, 
          l_xccn102d_total LIKE xccn_t.xccn102d, 
          l_xccn102e_total LIKE xccn_t.xccn102e, 
          l_xccn102f_total LIKE xccn_t.xccn102f, 
          l_xccn102g_total LIKE xccn_t.xccn102g, 
          l_xccn102h_total LIKE xccn_t.xccn102h, 
          l_xccn202_total LIKE xccn_t.xccn202, 
          l_xccn202a_total LIKE xccn_t.xccn202a, 
          l_xccn202b_total LIKE xccn_t.xccn202b, 
          l_xccn202c_total LIKE xccn_t.xccn202c, 
          l_xccn202d_total LIKE xccn_t.xccn202d, 
          l_xccn202e_total LIKE xccn_t.xccn202e, 
          l_xccn202f_total LIKE xccn_t.xccn202f, 
          l_xccn202g_total LIKE xccn_t.xccn202g, 
          l_xccn202h_total LIKE xccn_t.xccn202h, 
          l_xccn302_total LIKE xccn_t.xccn302, 
          l_xccn302a_total LIKE xccn_t.xccn302a, 
          l_xccn302b_total LIKE xccn_t.xccn302b, 
          l_xccn302c_total LIKE xccn_t.xccn302c, 
          l_xccn302d_total LIKE xccn_t.xccn302d, 
          l_xccn302e_total LIKE xccn_t.xccn302e, 
          l_xccn302f_total LIKE xccn_t.xccn302f, 
          l_xccn302g_total LIKE xccn_t.xccn302g, 
          l_xccn302h_total LIKE xccn_t.xccn302h
   DEFINE l_msgstr          STRING 
   DEFINE l_wc2_table1_t    STRING   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   LET l_wc2_table1_t = g_wc2_table1
   IF NOT cl_null(g_wc_filter) THEN
      IF cl_null(g_wc2_table1) THEN
         LET g_wc2_table1 = g_wc_filter
      ELSE
         LET g_wc2_table1 = g_wc2_table1," AND ",g_wc_filter
      END IF
      LET p_wc2 = p_wc2," AND ",g_wc_filter
   END IF
   #end add-point
   
   #先清空單身變數內容
   CALL g_xccn_d.clear()
 

   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  DISTINCT xccn002,xccn006,imag011,oocql004,xccd007,imaal003,imaal004,xccn102,xccn102a,xccn102b,xccn102c,xccn102d,xccn102e, ",
               "        xccn102f,xccn102g,xccn102h,xccn202,xccn202a,xccn202b,xccn202c,xccn202d,xccn202e,xccn202f,xccn202g,", 
               "        xccn202h,xccn302,xccn302a,xccn302b,xccn302c,xccn302d,xccn302e,xccn302f,xccn302g,xccn302h,t1.xcbfl003 ",
               "  FROM xccn_t ", 
               "  INNER JOIN xccd_t ON xccdent = "||g_enterprise||" AND xccnld = xccdld AND xccn001 = xccd001 AND xccn002 = xccd002 AND xccn003 = xccd003 AND xccn004 = xccd004 AND xccn005 = xccd005 AND xccn006 = xccd006",               
               "  LEFT JOIN xcbfl_t t1 ON t1.xcbflent="||g_enterprise||" AND t1.xcbflcomp=xccncomp AND t1.xcbfl001=xccn002 AND t1.xcbfl002='"||g_dlang||"' ",
               "  LEFT JOIN imag_t ON imagent =xccdent AND imagsite=xccdcomp AND imag001=xccd007 ",
               "  LEFT JOIN oocql_t ON oocqlent = imagent AND oocql001='206' AND oocql002 = imag011 AND oocql003 ='",g_dlang,"'",
               "  LEFT JOIN imaal_t ON imaalent=xccdent AND imaal001=xccd007 AND imaal002 ='",g_dlang,"'",
               " WHERE xccnent= ? AND xccnld=? AND xccn001=? AND xccn003=? ",
               " AND (xccn004*12+xccn005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,") "               
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccn_t")
   END IF
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq542_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY imag011,xccd007"
         #add-point:b_fill段fill_before name="b_fill.fill_before"

         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq542_pb1 FROM g_sql
         DECLARE b_fill_cs1 CURSOR FOR axcq542_pb1
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      LET l_msgstr = cl_getmsg("axc-00205",g_lang)
      #小计
      LET l_xccn102_sum  = 0
      LET l_xccn102a_sum = 0
      LET l_xccn102b_sum = 0
      LET l_xccn102c_sum = 0
      LET l_xccn102d_sum = 0
      LET l_xccn102e_sum = 0
      LET l_xccn102f_sum = 0
      LET l_xccn102g_sum = 0
      LET l_xccn102h_sum = 0
      LET l_xccn202_sum  = 0
      LET l_xccn202a_sum = 0
      LET l_xccn202b_sum = 0
      LET l_xccn202c_sum = 0
      LET l_xccn202d_sum = 0
      LET l_xccn202e_sum = 0
      LET l_xccn202f_sum = 0
      LET l_xccn202g_sum = 0
      LET l_xccn202h_sum = 0
      LET l_xccn302_sum  = 0
      LET l_xccn302a_sum = 0
      LET l_xccn302b_sum = 0
      LET l_xccn302c_sum = 0
      LET l_xccn302d_sum = 0
      LET l_xccn302e_sum = 0
      LET l_xccn302f_sum = 0
      LET l_xccn302g_sum = 0
      LET l_xccn302h_sum = 0       
      #合计
      LET l_xccn102_total  = 0
      LET l_xccn102a_total = 0
      LET l_xccn102b_total = 0
      LET l_xccn102c_total = 0
      LET l_xccn102d_total = 0
      LET l_xccn102e_total = 0
      LET l_xccn102f_total = 0
      LET l_xccn102g_total = 0
      LET l_xccn102h_total = 0
      LET l_xccn202_total  = 0
      LET l_xccn202a_total = 0
      LET l_xccn202b_total = 0
      LET l_xccn202c_total = 0
      LET l_xccn202d_total = 0
      LET l_xccn202e_total = 0
      LET l_xccn202f_total = 0
      LET l_xccn202g_total = 0
      LET l_xccn202h_total = 0
      LET l_xccn302_total  = 0
      LET l_xccn302a_total = 0
      LET l_xccn302b_total = 0
      LET l_xccn302c_total = 0
      LET l_xccn302d_total = 0
      LET l_xccn302e_total = 0
      LET l_xccn302f_total = 0
      LET l_xccn302g_total = 0
      LET l_xccn302h_total = 0
         
      OPEN b_fill_cs1 USING g_enterprise,g_xccn_m.xccnld,g_xccn_m.xccn001,g_xccn_m.xccn003
                                               
      FOREACH b_fill_cs1 INTO g_xccn_d[l_ac].xccn002,g_xccn_d[l_ac].xccn006,
          g_xccn_d[l_ac].imag011,g_xccn_d[l_ac].imag011_desc,
          g_xccn_d[l_ac].xccd007,g_xccn_d[l_ac].xccd007_desc,g_xccn_d[l_ac].xccd007_desc_1,
          g_xccn_d[l_ac].xccn102,g_xccn_d[l_ac].xccn102a, 
          g_xccn_d[l_ac].xccn102b,g_xccn_d[l_ac].xccn102c,g_xccn_d[l_ac].xccn102d,g_xccn_d[l_ac].xccn102e, 
          g_xccn_d[l_ac].xccn102f,g_xccn_d[l_ac].xccn102g,g_xccn_d[l_ac].xccn102h,g_xccn_d[l_ac].xccn202, 
          g_xccn_d[l_ac].xccn202a,g_xccn_d[l_ac].xccn202b,g_xccn_d[l_ac].xccn202c,g_xccn_d[l_ac].xccn202d, 
          g_xccn_d[l_ac].xccn202e,g_xccn_d[l_ac].xccn202f,g_xccn_d[l_ac].xccn202g,g_xccn_d[l_ac].xccn202h, 
          g_xccn_d[l_ac].xccn302,g_xccn_d[l_ac].xccn302a,g_xccn_d[l_ac].xccn302b,g_xccn_d[l_ac].xccn302c, 
          g_xccn_d[l_ac].xccn302d,g_xccn_d[l_ac].xccn302e,g_xccn_d[l_ac].xccn302f,g_xccn_d[l_ac].xccn302g, 
          g_xccn_d[l_ac].xccn302h,g_xccn_d[l_ac].xccn002_desc
                             
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
         
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         #小计
         LET l_xccn102_sum  = l_xccn102_sum  + g_xccn_d[l_ac].xccn102
         LET l_xccn102a_sum = l_xccn102a_sum + g_xccn_d[l_ac].xccn102a
         LET l_xccn102b_sum = l_xccn102b_sum + g_xccn_d[l_ac].xccn102b
         LET l_xccn102c_sum = l_xccn102c_sum + g_xccn_d[l_ac].xccn102c
         LET l_xccn102d_sum = l_xccn102d_sum + g_xccn_d[l_ac].xccn102d
         LET l_xccn102e_sum = l_xccn102e_sum + g_xccn_d[l_ac].xccn102e
         LET l_xccn102f_sum = l_xccn102f_sum + g_xccn_d[l_ac].xccn102f
         LET l_xccn102g_sum = l_xccn102g_sum + g_xccn_d[l_ac].xccn102g
         LET l_xccn102h_sum = l_xccn102h_sum + g_xccn_d[l_ac].xccn102h
         LET l_xccn202_sum  = l_xccn202_sum  + g_xccn_d[l_ac].xccn202
         LET l_xccn202a_sum = l_xccn202a_sum + g_xccn_d[l_ac].xccn202a
         LET l_xccn202b_sum = l_xccn202b_sum + g_xccn_d[l_ac].xccn202b
         LET l_xccn202c_sum = l_xccn202c_sum + g_xccn_d[l_ac].xccn202c
         LET l_xccn202d_sum = l_xccn202d_sum + g_xccn_d[l_ac].xccn202d
         LET l_xccn202e_sum = l_xccn202e_sum + g_xccn_d[l_ac].xccn202e
         LET l_xccn202f_sum = l_xccn202f_sum + g_xccn_d[l_ac].xccn202f
         LET l_xccn202g_sum = l_xccn202g_sum + g_xccn_d[l_ac].xccn202g
         LET l_xccn202h_sum = l_xccn202h_sum + g_xccn_d[l_ac].xccn202h
         LET l_xccn302_sum  = l_xccn302_sum  + g_xccn_d[l_ac].xccn302
         LET l_xccn302a_sum = l_xccn302a_sum + g_xccn_d[l_ac].xccn302a
         LET l_xccn302b_sum = l_xccn302b_sum + g_xccn_d[l_ac].xccn302b
         LET l_xccn302c_sum = l_xccn302c_sum + g_xccn_d[l_ac].xccn302c
         LET l_xccn302d_sum = l_xccn302d_sum + g_xccn_d[l_ac].xccn302d
         LET l_xccn302e_sum = l_xccn302e_sum + g_xccn_d[l_ac].xccn302e
         LET l_xccn302f_sum = l_xccn302f_sum + g_xccn_d[l_ac].xccn302f
         LET l_xccn302g_sum = l_xccn302g_sum + g_xccn_d[l_ac].xccn302g
         LET l_xccn302h_sum = l_xccn302h_sum + g_xccn_d[l_ac].xccn302h       
         #合计
         LET l_xccn102_total  = l_xccn102_total  + g_xccn_d[l_ac].xccn102
         LET l_xccn102a_total = l_xccn102a_total + g_xccn_d[l_ac].xccn102a
         LET l_xccn102b_total = l_xccn102b_total + g_xccn_d[l_ac].xccn102b
         LET l_xccn102c_total = l_xccn102c_total + g_xccn_d[l_ac].xccn102c
         LET l_xccn102d_total = l_xccn102d_total + g_xccn_d[l_ac].xccn102d
         LET l_xccn102e_total = l_xccn102e_total + g_xccn_d[l_ac].xccn102e
         LET l_xccn102f_total = l_xccn102f_total + g_xccn_d[l_ac].xccn102f
         LET l_xccn102g_total = l_xccn102g_total + g_xccn_d[l_ac].xccn102g
         LET l_xccn102h_total = l_xccn102h_total + g_xccn_d[l_ac].xccn102h
         LET l_xccn202_total  = l_xccn202_total  + g_xccn_d[l_ac].xccn202
         LET l_xccn202a_total = l_xccn202a_total + g_xccn_d[l_ac].xccn202a
         LET l_xccn202b_total = l_xccn202b_total + g_xccn_d[l_ac].xccn202b
         LET l_xccn202c_total = l_xccn202c_total + g_xccn_d[l_ac].xccn202c
         LET l_xccn202d_total = l_xccn202d_total + g_xccn_d[l_ac].xccn202d
         LET l_xccn202e_total = l_xccn202e_total + g_xccn_d[l_ac].xccn202e
         LET l_xccn202f_total = l_xccn202f_total + g_xccn_d[l_ac].xccn202f
         LET l_xccn202g_total = l_xccn202g_total + g_xccn_d[l_ac].xccn202g
         LET l_xccn202h_total = l_xccn202h_total + g_xccn_d[l_ac].xccn202h
         LET l_xccn302_total  = l_xccn302_total  + g_xccn_d[l_ac].xccn302
         LET l_xccn302a_total = l_xccn302a_total + g_xccn_d[l_ac].xccn302a
         LET l_xccn302b_total = l_xccn302b_total + g_xccn_d[l_ac].xccn302b
         LET l_xccn302c_total = l_xccn302c_total + g_xccn_d[l_ac].xccn302c
         LET l_xccn302d_total = l_xccn302d_total + g_xccn_d[l_ac].xccn302d
         LET l_xccn302e_total = l_xccn302e_total + g_xccn_d[l_ac].xccn302e
         LET l_xccn302f_total = l_xccn302f_total + g_xccn_d[l_ac].xccn302f
         LET l_xccn302g_total = l_xccn302g_total + g_xccn_d[l_ac].xccn302g
         LET l_xccn302h_total = l_xccn302h_total + g_xccn_d[l_ac].xccn302h 
         
         IF l_ac > 1 THEN
            IF g_xccn_d[l_ac].imag011 != g_xccn_d[l_ac - 1].imag011 OR g_xccn_d[l_ac].xccd007 != g_xccn_d[l_ac - 1].xccd007 THEN   
               #把当前行下移，并在当前行显示小计
               LET g_xccn_d[l_ac + 1].* = g_xccn_d[l_ac].*  
               INITIALIZE  g_xccn_d[l_ac].* TO NULL              
               LET g_xccn_d[l_ac].xccd007_desc = g_xccn_d[l_ac-1].xccd007,"-",l_msgstr     

               LET g_xccn_d[l_ac].xccn102  = l_xccn102_sum  - g_xccn_d[l_ac+1].xccn102
               LET g_xccn_d[l_ac].xccn102a = l_xccn102a_sum - g_xccn_d[l_ac+1].xccn102a
               LET g_xccn_d[l_ac].xccn102b = l_xccn102b_sum - g_xccn_d[l_ac+1].xccn102b
               LET g_xccn_d[l_ac].xccn102c = l_xccn102c_sum - g_xccn_d[l_ac+1].xccn102c
               LET g_xccn_d[l_ac].xccn102d = l_xccn102d_sum - g_xccn_d[l_ac+1].xccn102d
               LET g_xccn_d[l_ac].xccn102e = l_xccn102e_sum - g_xccn_d[l_ac+1].xccn102e
               LET g_xccn_d[l_ac].xccn102f = l_xccn102f_sum - g_xccn_d[l_ac+1].xccn102f
               LET g_xccn_d[l_ac].xccn102g = l_xccn102g_sum - g_xccn_d[l_ac+1].xccn102g
               LET g_xccn_d[l_ac].xccn102h = l_xccn102h_sum - g_xccn_d[l_ac+1].xccn102h
               LET g_xccn_d[l_ac].xccn202  = l_xccn202_sum  - g_xccn_d[l_ac+1].xccn202
               LET g_xccn_d[l_ac].xccn202a = l_xccn202a_sum - g_xccn_d[l_ac+1].xccn202a
               LET g_xccn_d[l_ac].xccn202b = l_xccn202b_sum - g_xccn_d[l_ac+1].xccn202b
               LET g_xccn_d[l_ac].xccn202c = l_xccn202c_sum - g_xccn_d[l_ac+1].xccn202c
               LET g_xccn_d[l_ac].xccn202d = l_xccn202d_sum - g_xccn_d[l_ac+1].xccn202d
               LET g_xccn_d[l_ac].xccn202e = l_xccn202e_sum - g_xccn_d[l_ac+1].xccn202e
               LET g_xccn_d[l_ac].xccn202f = l_xccn202f_sum - g_xccn_d[l_ac+1].xccn202f
               LET g_xccn_d[l_ac].xccn202g = l_xccn202g_sum - g_xccn_d[l_ac+1].xccn202g
               LET g_xccn_d[l_ac].xccn202h = l_xccn202h_sum - g_xccn_d[l_ac+1].xccn202h
               LET g_xccn_d[l_ac].xccn302  = l_xccn302_sum  - g_xccn_d[l_ac+1].xccn302
               LET g_xccn_d[l_ac].xccn302a = l_xccn302a_sum - g_xccn_d[l_ac+1].xccn302a
               LET g_xccn_d[l_ac].xccn302b = l_xccn302b_sum - g_xccn_d[l_ac+1].xccn302b
               LET g_xccn_d[l_ac].xccn302c = l_xccn302c_sum - g_xccn_d[l_ac+1].xccn302c
               LET g_xccn_d[l_ac].xccn302d = l_xccn302d_sum - g_xccn_d[l_ac+1].xccn302d
               LET g_xccn_d[l_ac].xccn302e = l_xccn302e_sum - g_xccn_d[l_ac+1].xccn302e
               LET g_xccn_d[l_ac].xccn302f = l_xccn302f_sum - g_xccn_d[l_ac+1].xccn302f
               LET g_xccn_d[l_ac].xccn302g = l_xccn302g_sum - g_xccn_d[l_ac+1].xccn302g
               LET g_xccn_d[l_ac].xccn302h = l_xccn302h_sum - g_xccn_d[l_ac+1].xccn302h               
               LET l_ac = l_ac + 1
               LET l_xccn102_sum  = g_xccn_d[l_ac].xccn102
               LET l_xccn102a_sum = g_xccn_d[l_ac].xccn102a
               LET l_xccn102b_sum = g_xccn_d[l_ac].xccn102b
               LET l_xccn102c_sum = g_xccn_d[l_ac].xccn102c
               LET l_xccn102d_sum = g_xccn_d[l_ac].xccn102d
               LET l_xccn102e_sum = g_xccn_d[l_ac].xccn102e
               LET l_xccn102f_sum = g_xccn_d[l_ac].xccn102f
               LET l_xccn102g_sum = g_xccn_d[l_ac].xccn102g
               LET l_xccn102h_sum = g_xccn_d[l_ac].xccn102h
               LET l_xccn202_sum  = g_xccn_d[l_ac].xccn202
               LET l_xccn202a_sum = g_xccn_d[l_ac].xccn202a
               LET l_xccn202b_sum = g_xccn_d[l_ac].xccn202b
               LET l_xccn202c_sum = g_xccn_d[l_ac].xccn202c
               LET l_xccn202d_sum = g_xccn_d[l_ac].xccn202d
               LET l_xccn202e_sum = g_xccn_d[l_ac].xccn202e
               LET l_xccn202f_sum = g_xccn_d[l_ac].xccn202f
               LET l_xccn202g_sum = g_xccn_d[l_ac].xccn202g
               LET l_xccn202h_sum = g_xccn_d[l_ac].xccn202h
               LET l_xccn302_sum  = g_xccn_d[l_ac].xccn302
               LET l_xccn302a_sum = g_xccn_d[l_ac].xccn302a
               LET l_xccn302b_sum = g_xccn_d[l_ac].xccn302b
               LET l_xccn302c_sum = g_xccn_d[l_ac].xccn302c
               LET l_xccn302d_sum = g_xccn_d[l_ac].xccn302d
               LET l_xccn302e_sum = g_xccn_d[l_ac].xccn302e
               LET l_xccn302f_sum = g_xccn_d[l_ac].xccn302f
               LET l_xccn302g_sum = g_xccn_d[l_ac].xccn302g
               LET l_xccn302h_sum = g_xccn_d[l_ac].xccn302h               
            END IF
         END IF
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
 
            CALL g_xccn_d.deleteElement(g_xccn_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   IF l_ac > 1 THEN
      #最后一组小计
      LET g_xccn_d[l_ac].xccd007_desc = g_xccn_d[l_ac-1].xccd007,"-",cl_getmsg("axc-00205",g_lang)              
      LET g_xccn_d[l_ac].xccn102  = l_xccn102_sum  
      LET g_xccn_d[l_ac].xccn102a = l_xccn102a_sum 
      LET g_xccn_d[l_ac].xccn102b = l_xccn102b_sum 
      LET g_xccn_d[l_ac].xccn102c = l_xccn102c_sum 
      LET g_xccn_d[l_ac].xccn102d = l_xccn102d_sum 
      LET g_xccn_d[l_ac].xccn102e = l_xccn102e_sum 
      LET g_xccn_d[l_ac].xccn102f = l_xccn102f_sum 
      LET g_xccn_d[l_ac].xccn102g = l_xccn102g_sum 
      LET g_xccn_d[l_ac].xccn102h = l_xccn102h_sum 
      LET g_xccn_d[l_ac].xccn202  = l_xccn202_sum  
      LET g_xccn_d[l_ac].xccn202a = l_xccn202a_sum 
      LET g_xccn_d[l_ac].xccn202b = l_xccn202b_sum 
      LET g_xccn_d[l_ac].xccn202c = l_xccn202c_sum 
      LET g_xccn_d[l_ac].xccn202d = l_xccn202d_sum 
      LET g_xccn_d[l_ac].xccn202e = l_xccn202e_sum 
      LET g_xccn_d[l_ac].xccn202f = l_xccn202f_sum 
      LET g_xccn_d[l_ac].xccn202g = l_xccn202g_sum 
      LET g_xccn_d[l_ac].xccn202h = l_xccn202h_sum 
      LET g_xccn_d[l_ac].xccn302  = l_xccn302_sum  
      LET g_xccn_d[l_ac].xccn302a = l_xccn302a_sum 
      LET g_xccn_d[l_ac].xccn302b = l_xccn302b_sum 
      LET g_xccn_d[l_ac].xccn302c = l_xccn302c_sum 
      LET g_xccn_d[l_ac].xccn302d = l_xccn302d_sum 
      LET g_xccn_d[l_ac].xccn302e = l_xccn302e_sum 
      LET g_xccn_d[l_ac].xccn302f = l_xccn302f_sum 
      LET g_xccn_d[l_ac].xccn302g = l_xccn302g_sum 
      LET g_xccn_d[l_ac].xccn302h = l_xccn302h_sum 
               
      #最后的合计
      LET l_ac = l_ac + 1      
      LET g_xccn_d[l_ac].xccd007_desc = cl_getmsg("axc-00204",g_lang)             
      LET g_xccn_d[l_ac].xccn102  = l_xccn102_total  
      LET g_xccn_d[l_ac].xccn102a = l_xccn102a_total 
      LET g_xccn_d[l_ac].xccn102b = l_xccn102b_total 
      LET g_xccn_d[l_ac].xccn102c = l_xccn102c_total 
      LET g_xccn_d[l_ac].xccn102d = l_xccn102d_total 
      LET g_xccn_d[l_ac].xccn102e = l_xccn102e_total 
      LET g_xccn_d[l_ac].xccn102f = l_xccn102f_total 
      LET g_xccn_d[l_ac].xccn102g = l_xccn102g_total 
      LET g_xccn_d[l_ac].xccn102h = l_xccn102h_total 
      LET g_xccn_d[l_ac].xccn202 = l_xccn202_total  
      LET g_xccn_d[l_ac].xccn202a = l_xccn202a_total 
      LET g_xccn_d[l_ac].xccn202b = l_xccn202b_total 
      LET g_xccn_d[l_ac].xccn202c = l_xccn202c_total 
      LET g_xccn_d[l_ac].xccn202d = l_xccn202d_total 
      LET g_xccn_d[l_ac].xccn202e = l_xccn202e_total 
      LET g_xccn_d[l_ac].xccn202f = l_xccn202f_total 
      LET g_xccn_d[l_ac].xccn202g = l_xccn202g_total 
      LET g_xccn_d[l_ac].xccn202h = l_xccn202h_total 
      LET g_xccn_d[l_ac].xccn302 = l_xccn302_total  
      LET g_xccn_d[l_ac].xccn302a = l_xccn302a_total 
      LET g_xccn_d[l_ac].xccn302b = l_xccn302b_total 
      LET g_xccn_d[l_ac].xccn302c = l_xccn302c_total 
      LET g_xccn_d[l_ac].xccn302d = l_xccn302d_total 
      LET g_xccn_d[l_ac].xccn302e = l_xccn302e_total 
      LET g_xccn_d[l_ac].xccn302f = l_xccn302f_total 
      LET g_xccn_d[l_ac].xccn302g = l_xccn302g_total 
      LET g_xccn_d[l_ac].xccn302h = l_xccn302h_total
      LET l_ac = l_ac + 1
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccn_d.getLength()
      LET g_xccn_d_mask_o[l_ac].* =  g_xccn_d[l_ac].*
      CALL axcq542_xccn_t_mask()
      LET g_xccn_d_mask_n[l_ac].* =  g_xccn_d[l_ac].*
   END FOR
   
 
 
   FREE axcq542_pb1
END FUNCTION

 
{</section>}
 
