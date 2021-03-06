#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq804.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-05-19 14:10:03), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: axcq804
#+ Description: 在製LCM評價查詢作業
#+ Creator....: 06021(2015-04-01 17:41:57)
#+ Modifier...: 05795 -SD/PR- 00000
 
{</section>}
 
{<section id="axcq804.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160520-00003#11   2016/05/23  BY lixh      效能优化
#161013-00051#1    2016/10/18  By shiun     整批調整據點組織開窗
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
PRIVATE type type_g_xccc_m        RECORD
       xccccomp LIKE xccc_t.xccccomp, 
   xccccomp_desc LIKE type_t.chr80, 
   xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   xcccld LIKE xccc_t.xcccld, 
   xcccld_desc LIKE type_t.chr80, 
   xccc001 LIKE xccc_t.xccc001, 
   xccc001_desc LIKE type_t.chr80, 
   xccc003 LIKE xccc_t.xccc003, 
   xccc003_desc LIKE type_t.chr80, 
   b_date_str LIKE type_t.chr500, 
   b_date_end LIKE type_t.chr500, 
   xccc002 LIKE xccc_t.xccc002, 
   xccc002_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccc_d        RECORD
       imaa003 LIKE type_t.chr10, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc008 LIKE xccc_t.xccc008, 
   imaa104 LIKE type_t.chr10, 
   inaj011 LIKE type_t.num20_6, 
   xccc902 LIKE xccc_t.xccc902, 
   xccc280 LIKE xccc_t.xccc280, 
   rebcost LIKE type_t.chr500, 
   xcff005 LIKE type_t.num20_6, 
   upcost LIKE type_t.chr500, 
   downcost LIKE type_t.chr500, 
   xcff006 LIKE type_t.num20_6, 
   price LIKE type_t.chr500, 
   tot LIKE type_t.chr500, 
   inaj001 LIKE type_t.chr20, 
   inaj002 LIKE type_t.num10, 
   inaj022 LIKE type_t.dat, 
   lcm LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para_data           LIKE type_t.chr80     #采用特性否  
DEFINE g_para_data1           LIKE type_t.chr80     #采用成本域否 
DEFINE g_date_str             LIKE type_t.dat
DEFINE g_date_end             LIKE type_t.dat
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xccc_m          type_g_xccc_m
DEFINE g_xccc_m_t        type_g_xccc_m
DEFINE g_xccc_m_o        type_g_xccc_m
DEFINE g_xccc_m_mask_o   type_g_xccc_m #轉換遮罩前資料
DEFINE g_xccc_m_mask_n   type_g_xccc_m #轉換遮罩後資料
 
   DEFINE g_xccc004_t LIKE xccc_t.xccc004
DEFINE g_xccc005_t LIKE xccc_t.xccc005
DEFINE g_xcccld_t LIKE xccc_t.xcccld
DEFINE g_xccc001_t LIKE xccc_t.xccc001
DEFINE g_xccc003_t LIKE xccc_t.xccc003
DEFINE g_xccc002_t LIKE xccc_t.xccc002
 
 
DEFINE g_xccc_d          DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t        type_g_xccc_d
DEFINE g_xccc_d_o        type_g_xccc_d
DEFINE g_xccc_d_mask_o   DYNAMIC ARRAY OF type_g_xccc_d #轉換遮罩前資料
DEFINE g_xccc_d_mask_n   DYNAMIC ARRAY OF type_g_xccc_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcccld LIKE xccc_t.xcccld,
      b_xccc001 LIKE xccc_t.xccc001,
      b_xccc002 LIKE xccc_t.xccc002,
      b_xccc003 LIKE xccc_t.xccc003,
      b_xccc004 LIKE xccc_t.xccc004,
      b_xccc005 LIKE xccc_t.xccc005
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
 
{<section id="axcq804.main" >}
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
   LET g_forupd_sql = " SELECT xccccomp,'',xccc004,xccc005,xcccld,'',xccc001,'',xccc003,'','','',xccc002, 
       ''", 
                      " FROM xccc_t",
                      " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc002=? AND xccc003=? AND  
                          xccc004=? AND xccc005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq804_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccccomp,t0.xccc004,t0.xccc005,t0.xcccld,t0.xccc001,t0.xccc003,t0.xccc002, 
       t1.ooefl003 ,t2.glaal002 ,t3.ooail003 ,t4.xcatl003 ,t5.xcbfl003",
               " FROM xccc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccccomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xcccld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.xccc001 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent="||g_enterprise||" AND t4.xcatl001=t0.xccc003 AND t4.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t5 ON t5.xcbflent="||g_enterprise||" AND t5.xcbfl001=t0.xccc002 AND t5.xcbfl002='"||g_dlang||"' ",
 
               " WHERE t0.xcccent = " ||g_enterprise|| " AND t0.xcccld = ? AND t0.xccc001 = ? AND t0.xccc002 = ? AND t0.xccc003 = ? AND t0.xccc004 = ? AND t0.xccc005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq804_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq804 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq804_init()   
 
      #進入選單 Menu (="N")
      CALL axcq804_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq804
      
   END IF 
   
   CLOSE axcq804_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq804.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq804_init()
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
    CALL cl_set_combo_scc('xccc001','8914')
    CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc007',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xccc007',FALSE)                
   END IF 
   
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data1   #采用成本域否
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('lbl_xccc002,xccc002,xccc002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('lbl_xccc002,xccc002,xccc002_desc',FALSE)                
   END IF     
   #end add-point
   
   CALL axcq804_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq804.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq804_ui_dialog()
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
         INITIALIZE g_xccc_m.* TO NULL
         CALL g_xccc_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq804_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq804_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq804_ui_detailshow()
               
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
            CALL axcq804_browser_fill("")
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
               CALL axcq804_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq804_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq804_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq804_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq804_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq804_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq804_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq804_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq804_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq804_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq804_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq804_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xccc_d)
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
               NEXT FIELD xccc006
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
               CALL axcq804_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq804_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq804_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axcq804_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq804_query()
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
            CALL axcq804_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq804_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq804_set_pk_array()
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
 
{<section id="axcq804.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq804_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq804.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq804_browser_fill(ps_page_action)
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
   LET g_date_str = g_xccc_m.b_date_str
   LET g_date_end = g_xccc_m.b_date_end
   #end add-point    
 
   LET l_searchcol = "xcccld,xccc001,xccc002,xccc003,xccc004,xccc005"
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
      LET l_sub_sql = " SELECT DISTINCT xcccld ",
                      ", xccc001 ",
                      ", xccc002 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
 
                      " FROM xccc_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcccent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcccld ",
                      ", xccc001 ",
                      ", xccc002 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
 
                      " FROM xccc_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcccent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccc_t")
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
      INITIALIZE g_xccc_m.* TO NULL
      CALL g_xccc_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcccld,t0.xccc001,t0.xccc002,t0.xccc003,t0.xccc004,t0.xccc005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcccld,t0.xccc001,t0.xccc002,t0.xccc003,t0.xccc004,t0.xccc005",
                " FROM xccc_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcccent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccc_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccc_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcccld,g_browser[g_cnt].b_xccc001,g_browser[g_cnt].b_xccc002, 
          g_browser[g_cnt].b_xccc003,g_browser[g_cnt].b_xccc004,g_browser[g_cnt].b_xccc005 
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
   
   IF cl_null(g_browser[g_cnt].b_xcccld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xccc_m.* TO NULL
      CALL g_xccc_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq804_fetch('')
   
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
 
{<section id="axcq804.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq804_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xccc_m.xcccld = g_browser[g_current_idx].b_xcccld   
   LET g_xccc_m.xccc001 = g_browser[g_current_idx].b_xccc001   
   LET g_xccc_m.xccc002 = g_browser[g_current_idx].b_xccc002   
   LET g_xccc_m.xccc003 = g_browser[g_current_idx].b_xccc003   
   LET g_xccc_m.xccc004 = g_browser[g_current_idx].b_xccc004   
   LET g_xccc_m.xccc005 = g_browser[g_current_idx].b_xccc005   
 
   EXECUTE axcq804_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003, 
       g_xccc_m.xccc004,g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc002,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc, 
       g_xccc_m.xccc001_desc,g_xccc_m.xccc003_desc,g_xccc_m.xccc002_desc
   CALL axcq804_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq804_ui_detailshow()
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
 
{<section id="axcq804.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq804_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcccld = g_xccc_m.xcccld 
         AND g_browser[l_i].b_xccc001 = g_xccc_m.xccc001 
         AND g_browser[l_i].b_xccc002 = g_xccc_m.xccc002 
         AND g_browser[l_i].b_xccc003 = g_xccc_m.xccc003 
         AND g_browser[l_i].b_xccc004 = g_xccc_m.xccc004 
         AND g_browser[l_i].b_xccc005 = g_xccc_m.xccc005 
 
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
 
{<section id="axcq804.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq804_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_num       LIKE type_t.chr20
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xccc_m.* TO NULL
   CALL g_xccc_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   LET l_num = 'Y' #第一遍给默认值其他的时候不给默认值
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccccomp,xccc004,xccc005,xcccld,xccc001,xccc003,xccc002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            IF l_num ='Y' THEN
               CALL axcq804_default()
               LET l_num = 'N'
            END IF 
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccccomp
            #add-point:BEFORE FIELD xccccomp name="construct.b.xccccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp name="construct.a.xccccomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccccomp_desc
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="construct.c.xccccomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001()                           #呼叫開窗
            CALL q_ooef001_2()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO xccccomp  #顯示到畫面上
            LET g_xccc_m.xccccomp = g_qryparam.return1
            NEXT FIELD xccccomp                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="construct.b.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="construct.a.xccc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="construct.c.xccc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="construct.b.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="construct.a.xccc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="construct.c.xccc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld name="construct.b.xcccld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="construct.a.xcccld"
            CALL s_desc_get_ld_desc(g_xccc_m.xcccld) RETURNING g_xccc_m.xcccld_desc #帳別編號
            DISPLAY BY NAME g_xccc_m.xcccld_desc
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="construct.c.xcccld"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcccld  #顯示到畫面上
            LET g_xccc_m.xcccld = g_qryparam.return1
            NEXT FIELD xcccld                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001 name="construct.b.xccc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="construct.a.xccc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="construct.c.xccc001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003 name="construct.b.xccc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="construct.a.xccc003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccc003_desc
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="construct.c.xccc003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc003  #顯示到畫面上
            NEXT FIELD xccc003 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002 name="construct.b.xccc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="construct.a.xccc002"
             #成本域说明
             INITIALIZE g_ref_fields TO NULL
             LET g_ref_fields[1] = g_xccc_m.xccc002
             CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
             LET g_xccc_m.xccc002_desc = '', g_rtn_fields[1] , ''
             DISPLAY BY NAME g_xccc_m.xccc002_desc
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002 name="construct.c.xccc002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            LET g_xccc_m.xccc002 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO xccc002  #顯示到畫面上
            NEXT FIELD xccc002                     #返回原欄位
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccc006,xccc007,xccc008,xccc902,xccc280
           FROM s_detail1[1].xccc006,s_detail1[1].xccc007,s_detail1[1].xccc008,s_detail1[1].xccc902, 
               s_detail1[1].xccc280
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006 name="construct.b.page1.xccc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006 name="construct.a.page1.xccc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006 name="construct.c.page1.xccc006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc006  #顯示到畫面上
            NEXT FIELD xccc006  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007 name="construct.b.page1.xccc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007 name="construct.a.page1.xccc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007 name="construct.c.page1.xccc007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc007  #顯示到畫面上
            NEXT FIELD xccc007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008 name="construct.b.page1.xccc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008 name="construct.a.page1.xccc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008 name="construct.c.page1.xccc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc902
            #add-point:BEFORE FIELD xccc902 name="construct.b.page1.xccc902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc902
            
            #add-point:AFTER FIELD xccc902 name="construct.a.page1.xccc902"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc902
            #add-point:ON ACTION controlp INFIELD xccc902 name="construct.c.page1.xccc902"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280
            #add-point:BEFORE FIELD xccc280 name="construct.b.page1.xccc280"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280
            
            #add-point:AFTER FIELD xccc280 name="construct.a.page1.xccc280"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280
            #add-point:ON ACTION controlp INFIELD xccc280 name="construct.c.page1.xccc280"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT BY NAME g_xccc_m.b_date_str,g_xccc_m.b_date_end
       ATTRIBUTE(WITHOUT DEFAULTS)
        
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
 
{<section id="axcq804.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq804_query()
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
   CALL g_xccc_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq804_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq804_browser_fill(g_wc)
      CALL axcq804_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq804_browser_fill("F")
   
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
      CALL axcq804_fetch("F") 
   END IF
   
   CALL axcq804_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq804_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   LET g_xccc_m.b_date_str = g_date_str 
   LET g_xccc_m.b_date_end = g_date_end
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
   
   #CALL axcq804_browser_fill(p_flag)
   
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
   
   LET g_xccc_m.xcccld = g_browser[g_current_idx].b_xcccld
   LET g_xccc_m.xccc001 = g_browser[g_current_idx].b_xccc001
   LET g_xccc_m.xccc002 = g_browser[g_current_idx].b_xccc002
   LET g_xccc_m.xccc003 = g_browser[g_current_idx].b_xccc003
   LET g_xccc_m.xccc004 = g_browser[g_current_idx].b_xccc004
   LET g_xccc_m.xccc005 = g_browser[g_current_idx].b_xccc005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq804_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003, 
       g_xccc_m.xccc004,g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc002,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc, 
       g_xccc_m.xccc001_desc,g_xccc_m.xccc003_desc,g_xccc_m.xccc002_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xccc_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq804_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq804_set_act_visible()
   CALL axcq804_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xccc_m_t.* = g_xccc_m.*
   LET g_xccc_m_o.* = g_xccc_m.*
   
   #重新顯示   
   CALL axcq804_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq804.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq804_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccc_d.clear()
 
 
   INITIALIZE g_xccc_m.* TO NULL             #DEFAULT 設定
   LET g_xcccld_t = NULL
   LET g_xccc001_t = NULL
   LET g_xccc002_t = NULL
   LET g_xccc003_t = NULL
   LET g_xccc004_t = NULL
   LET g_xccc005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq804_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccc_m.* TO NULL
         INITIALIZE g_xccc_d TO NULL
 
         CALL axcq804_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq804_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xccc_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq804_set_act_visible()
   CALL axcq804_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc002_t = g_xccc_m.xccc002
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc002 = '", g_xccc_m.xccc002, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq804_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq804_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq804_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003, 
       g_xccc_m.xccc004,g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc002,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc, 
       g_xccc_m.xccc001_desc,g_xccc_m.xccc003_desc,g_xccc_m.xccc002_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq804_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xcccld_desc,g_xccc_m.xccc001,g_xccc_m.xccc001_desc,g_xccc_m.xccc003,g_xccc_m.xccc003_desc, 
       g_xccc_m.b_date_str,g_xccc_m.b_date_end,g_xccc_m.xccc002,g_xccc_m.xccc002_desc
   
   #功能已完成,通報訊息中心
   CALL axcq804_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq804_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xccc_m.xcccld IS NULL
   OR g_xccc_m.xccc001 IS NULL
   OR g_xccc_m.xccc002 IS NULL
   OR g_xccc_m.xccc003 IS NULL
   OR g_xccc_m.xccc004 IS NULL
   OR g_xccc_m.xccc005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc002_t = g_xccc_m.xccc002
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   CALL s_transaction_begin()
   
   OPEN axcq804_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq804_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq804_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq804_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003, 
       g_xccc_m.xccc004,g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc002,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc, 
       g_xccc_m.xccc001_desc,g_xccc_m.xccc003_desc,g_xccc_m.xccc002_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq804_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq804_show()
   WHILE TRUE
      LET g_xcccld_t = g_xccc_m.xcccld
      LET g_xccc001_t = g_xccc_m.xccc001
      LET g_xccc002_t = g_xccc_m.xccc002
      LET g_xccc003_t = g_xccc_m.xccc003
      LET g_xccc004_t = g_xccc_m.xccc004
      LET g_xccc005_t = g_xccc_m.xccc005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq804_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq804_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xccc_m.xcccld != g_xcccld_t 
      OR g_xccc_m.xccc001 != g_xccc001_t 
      OR g_xccc_m.xccc002 != g_xccc002_t 
      OR g_xccc_m.xccc003 != g_xccc003_t 
      OR g_xccc_m.xccc004 != g_xccc004_t 
      OR g_xccc_m.xccc005 != g_xccc005_t 
 
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
   CALL axcq804_set_act_visible()
   CALL axcq804_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc002 = '", g_xccc_m.xccc002, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005, "' "
 
   #填到對應位置
   CALL axcq804_browser_fill("")
 
   CALL axcq804_idx_chk()
 
   CLOSE axcq804_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq804_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq804.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq804_input(p_cmd)
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
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xcccld_desc,g_xccc_m.xccc001,g_xccc_m.xccc001_desc,g_xccc_m.xccc003,g_xccc_m.xccc003_desc, 
       g_xccc_m.b_date_str,g_xccc_m.b_date_end,g_xccc_m.xccc002,g_xccc_m.xccc002_desc
   
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
   LET g_forupd_sql = "SELECT xccc006,xccc007,xccc008,xccc902,xccc280 FROM xccc_t WHERE xcccent=? AND  
       xcccld=? AND xccc001=? AND xccc002=? AND xccc003=? AND xccc004=? AND xccc005=? AND xccc006=?  
       AND xccc007=? AND xccc008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq804_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq804_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq804_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003, 
       g_xccc_m.b_date_str,g_xccc_m.b_date_end
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq804.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003, 
          g_xccc_m.b_date_str,g_xccc_m.b_date_end 
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
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="input.b.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="input.a.xccc004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc002) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc002 != g_xccc002_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc002 = '"||g_xccc_m.xccc002 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc004
            #add-point:ON CHANGE xccc004 name="input.g.xccc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="input.b.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="input.a.xccc005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc002) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc002 != g_xccc002_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc002 = '"||g_xccc_m.xccc002 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005 name="input.g.xccc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="input.a.xcccld"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xcccld_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc002) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc002 != g_xccc002_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc002 = '"||g_xccc_m.xccc002 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld name="input.b.xcccld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcccld
            #add-point:ON CHANGE xcccld name="input.g.xcccld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="input.a.xccc001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccc001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccc001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccc001_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc002) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc002 != g_xccc002_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc002 = '"||g_xccc_m.xccc002 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001 name="input.b.xccc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc001
            #add-point:ON CHANGE xccc001 name="input.g.xccc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="input.a.xccc003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccc003_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc002) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc002 != g_xccc002_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc002 = '"||g_xccc_m.xccc002 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003 name="input.b.xccc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc003
            #add-point:ON CHANGE xccc003 name="input.g.xccc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_date_str
            #add-point:BEFORE FIELD b_date_str name="input.b.b_date_str"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_date_str
            
            #add-point:AFTER FIELD b_date_str name="input.a.b_date_str"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_date_str
            #add-point:ON CHANGE b_date_str name="input.g.b_date_str"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_date_end
            #add-point:BEFORE FIELD b_date_end name="input.b.b_date_end"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_date_end
            
            #add-point:AFTER FIELD b_date_end name="input.a.b_date_end"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_date_end
            #add-point:ON CHANGE b_date_end name="input.g.b_date_end"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="input.c.xccc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="input.c.xccc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcccld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="input.c.xcccld"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="input.c.xccc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="input.c.xccc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_date_str
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_date_str
            #add-point:ON ACTION controlp INFIELD b_date_str name="input.c.b_date_str"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_date_end
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_date_end
            #add-point:ON ACTION controlp INFIELD b_date_end name="input.c.b_date_end"
            
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
            DISPLAY BY NAME g_xccc_m.xcccld             
                            ,g_xccc_m.xccc001   
                            ,g_xccc_m.xccc002   
                            ,g_xccc_m.xccc003   
                            ,g_xccc_m.xccc004   
                            ,g_xccc_m.xccc005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq804_xccc_t_mask_restore('restore_mask_o')
            
               UPDATE xccc_t SET (xccccomp,xccc004,xccc005,xcccld,xccc001,xccc003,xccc002) = (g_xccc_m.xccccomp, 
                   g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003, 
                   g_xccc_m.xccc002)
                WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
                  AND xccc001 = g_xccc001_t
                  AND xccc002 = g_xccc002_t
                  AND xccc003 = g_xccc003_t
                  AND xccc004 = g_xccc004_t
                  AND xccc005 = g_xccc005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccc_m.xcccld
               LET gs_keys_bak[1] = g_xcccld_t
               LET gs_keys[2] = g_xccc_m.xccc001
               LET gs_keys_bak[2] = g_xccc001_t
               LET gs_keys[3] = g_xccc_m.xccc002
               LET gs_keys_bak[3] = g_xccc002_t
               LET gs_keys[4] = g_xccc_m.xccc003
               LET gs_keys_bak[4] = g_xccc003_t
               LET gs_keys[5] = g_xccc_m.xccc004
               LET gs_keys_bak[5] = g_xccc004_t
               LET gs_keys[6] = g_xccc_m.xccc005
               LET gs_keys_bak[6] = g_xccc005_t
               LET gs_keys[7] = g_xccc_d[g_detail_idx].xccc006
               LET gs_keys_bak[7] = g_xccc_d_t.xccc006
               LET gs_keys[8] = g_xccc_d[g_detail_idx].xccc007
               LET gs_keys_bak[8] = g_xccc_d_t.xccc007
               LET gs_keys[9] = g_xccc_d[g_detail_idx].xccc008
               LET gs_keys_bak[9] = g_xccc_d_t.xccc008
               CALL axcq804_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xccc_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xccc_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq804_xccc_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq804_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcccld_t = g_xccc_m.xcccld
           LET g_xccc001_t = g_xccc_m.xccc001
           LET g_xccc002_t = g_xccc_m.xccc002
           LET g_xccc003_t = g_xccc_m.xccc003
           LET g_xccc004_t = g_xccc_m.xccc004
           LET g_xccc005_t = g_xccc_m.xccc005
 
           
           IF g_xccc_d.getLength() = 0 THEN
              NEXT FIELD xccc006
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq804.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xccc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq804_b_fill(g_wc2) #test 
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
            CALL axcq804_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq804_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq804_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq804_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xccc_d[l_ac].xccc006 IS NOT NULL
               AND g_xccc_d[l_ac].xccc007 IS NOT NULL
               AND g_xccc_d[l_ac].xccc008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccc_d_t.* = g_xccc_d[l_ac].*  #BACKUP
               LET g_xccc_d_o.* = g_xccc_d[l_ac].*  #BACKUP
               CALL axcq804_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq804_set_no_entry_b(l_cmd)
               OPEN axcq804_bcl USING g_enterprise,g_xccc_m.xcccld,
                                                g_xccc_m.xccc001,
                                                g_xccc_m.xccc002,
                                                g_xccc_m.xccc003,
                                                g_xccc_m.xccc004,
                                                g_xccc_m.xccc005,
 
                                                g_xccc_d_t.xccc006
                                                ,g_xccc_d_t.xccc007
                                                ,g_xccc_d_t.xccc008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq804_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq804_bcl INTO g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008, 
                      g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc280
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccc_d_t.xccc006,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xccc_d_mask_o[l_ac].* =  g_xccc_d[l_ac].*
                  CALL axcq804_xccc_t_mask()
                  LET g_xccc_d_mask_n[l_ac].* =  g_xccc_d[l_ac].*
                  
                  CALL axcq804_ref_show()
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
            INITIALIZE g_xccc_d_t.* TO NULL
            INITIALIZE g_xccc_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccc_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccc_d[l_ac].inaj011 = "0"
      LET g_xccc_d[l_ac].xccc902 = "0"
      LET g_xccc_d[l_ac].xcff005 = "0"
      LET g_xccc_d[l_ac].xcff006 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xccc_d_t.* = g_xccc_d[l_ac].*     #新輸入資料
            LET g_xccc_d_o.* = g_xccc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq804_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq804_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
 
               LET g_xccc_d[g_xccc_d.getLength()].xccc006 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc007 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc008 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xccc_t 
             WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
               AND xccc001 = g_xccc_m.xccc001
               AND xccc002 = g_xccc_m.xccc002
               AND xccc003 = g_xccc_m.xccc003
               AND xccc004 = g_xccc_m.xccc004
               AND xccc005 = g_xccc_m.xccc005
 
               AND xccc006 = g_xccc_d[l_ac].xccc006
               AND xccc007 = g_xccc_d[l_ac].xccc007
               AND xccc008 = g_xccc_d[l_ac].xccc008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xccc_t
                           (xcccent,
                            xccccomp,xccc004,xccc005,xcccld,xccc001,xccc003,xccc002,
                            xccc006,xccc007,xccc008
                            ,xccc902,xccc280) 
                     VALUES(g_enterprise,
                            g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc002,
                            g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008
                            ,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc280)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xccc_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
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
               IF axcq804_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xccc_m.xcccld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc006
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc007
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc008
 
 
                  #刪除下層單身
                  IF NOT axcq804_key_delete_b(gs_keys,'xccc_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq804_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq804_bcl
               LET l_count = g_xccc_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="input.b.page1.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="input.a.page1.imaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa003
            #add-point:ON CHANGE imaa003 name="input.g.page1.imaa003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="input.c.page1.imaa003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccc_d[l_ac].imaa003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_imck001()                                #呼叫開窗

            LET g_xccc_d[l_ac].imaa003 = g_qryparam.return1              

            DISPLAY g_xccc_d[l_ac].imaa003 TO imaa003              #

            NEXT FIELD imaa003                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xccc_d[l_ac].* = g_xccc_d_t.*
               CLOSE axcq804_bcl
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
               LET g_errparam.extend = g_xccc_d[l_ac].xccc006 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccc_d[l_ac].* = g_xccc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq804_xccc_t_mask_restore('restore_mask_o')
         
               UPDATE xccc_t SET (xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008, 
                   xccc902,xccc280) = (g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003, 
                   g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008, 
                   g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc280)
                WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld 
                 AND xccc001 = g_xccc_m.xccc001 
                 AND xccc002 = g_xccc_m.xccc002 
                 AND xccc003 = g_xccc_m.xccc003 
                 AND xccc004 = g_xccc_m.xccc004 
                 AND xccc005 = g_xccc_m.xccc005 
 
                 AND xccc006 = g_xccc_d_t.xccc006 #項次   
                 AND xccc007 = g_xccc_d_t.xccc007  
                 AND xccc008 = g_xccc_d_t.xccc008  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccc_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccc_m.xcccld
               LET gs_keys_bak[1] = g_xcccld_t
               LET gs_keys[2] = g_xccc_m.xccc001
               LET gs_keys_bak[2] = g_xccc001_t
               LET gs_keys[3] = g_xccc_m.xccc002
               LET gs_keys_bak[3] = g_xccc002_t
               LET gs_keys[4] = g_xccc_m.xccc003
               LET gs_keys_bak[4] = g_xccc003_t
               LET gs_keys[5] = g_xccc_m.xccc004
               LET gs_keys_bak[5] = g_xccc004_t
               LET gs_keys[6] = g_xccc_m.xccc005
               LET gs_keys_bak[6] = g_xccc005_t
               LET gs_keys[7] = g_xccc_d[g_detail_idx].xccc006
               LET gs_keys_bak[7] = g_xccc_d_t.xccc006
               LET gs_keys[8] = g_xccc_d[g_detail_idx].xccc007
               LET gs_keys_bak[8] = g_xccc_d_t.xccc007
               LET gs_keys[9] = g_xccc_d[g_detail_idx].xccc008
               LET gs_keys_bak[9] = g_xccc_d_t.xccc008
               CALL axcq804_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq804_xccc_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccc_m.xcccld
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc001
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc002
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc003
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc004
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc006
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc007
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc008
 
               CALL axcq804_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq804_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccc_d[l_ac].* = g_xccc_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq804_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccc_d.getLength() = 0 THEN
               NEXT FIELD xccc006
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
 
               LET g_xccc_d[li_reproduce_target].xccc006 = NULL
               LET g_xccc_d[li_reproduce_target].xccc007 = NULL
               LET g_xccc_d[li_reproduce_target].xccc008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xccc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xccc_d.getLength()+1
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
            NEXT FIELD xcccld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imaa003
 
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
 
{<section id="axcq804.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq804_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
    #根據參數顯示隱藏 料件特性
   IF cl_null(g_xccc_m.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data   #采用特性否 
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data1   #采用成本域否      
   ELSE
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6013') RETURNING g_para_data   #采用特性否 
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data1   #采用成本域否      
   END IF 
 
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc007',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xccc007',FALSE)                
   END IF 
    IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('lbl_xccc002,xccc002,xccc002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('lbl_xccc002,xccc002,xccc002_desc',FALSE)                
   END IF     
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq804_b_fill(g_wc2) #第一階單身填充
      CALL axcq804_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq804_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   LET g_xccc_m.b_date_str = g_date_str
   LET g_xccc_m.b_date_end = g_date_end
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xcccld_desc,g_xccc_m.xccc001,g_xccc_m.xccc001_desc,g_xccc_m.xccc003,g_xccc_m.xccc003_desc, 
       g_xccc_m.b_date_str,g_xccc_m.b_date_end,g_xccc_m.xccc002,g_xccc_m.xccc002_desc
 
   CALL axcq804_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq804_ref_show()
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
   FOR l_ac = 1 TO g_xccc_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq804.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq804_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xccc_t.xcccld 
   DEFINE l_oldno     LIKE xccc_t.xcccld 
   DEFINE l_newno02     LIKE xccc_t.xccc001 
   DEFINE l_oldno02     LIKE xccc_t.xccc001 
   DEFINE l_newno03     LIKE xccc_t.xccc002 
   DEFINE l_oldno03     LIKE xccc_t.xccc002 
   DEFINE l_newno04     LIKE xccc_t.xccc003 
   DEFINE l_oldno04     LIKE xccc_t.xccc003 
   DEFINE l_newno05     LIKE xccc_t.xccc004 
   DEFINE l_oldno05     LIKE xccc_t.xccc004 
   DEFINE l_newno06     LIKE xccc_t.xccc005 
   DEFINE l_oldno06     LIKE xccc_t.xccc005 
 
   DEFINE l_master    RECORD LIKE xccc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xccc_t.* #此變數樣板目前無使用
 
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
 
   IF g_xccc_m.xcccld IS NULL
      OR g_xccc_m.xccc001 IS NULL
      OR g_xccc_m.xccc002 IS NULL
      OR g_xccc_m.xccc003 IS NULL
      OR g_xccc_m.xccc004 IS NULL
      OR g_xccc_m.xccc005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc002_t = g_xccc_m.xccc002
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   LET g_xccc_m.xcccld = ""
   LET g_xccc_m.xccc001 = ""
   LET g_xccc_m.xccc002 = ""
   LET g_xccc_m.xccc003 = ""
   LET g_xccc_m.xccc004 = ""
   LET g_xccc_m.xccc005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq804_set_entry('a')
   CALL axcq804_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xccc_m.xcccld_desc = ''
   DISPLAY BY NAME g_xccc_m.xcccld_desc
   LET g_xccc_m.xccc001_desc = ''
   DISPLAY BY NAME g_xccc_m.xccc001_desc
   LET g_xccc_m.xccc003_desc = ''
   DISPLAY BY NAME g_xccc_m.xccc003_desc
   LET g_xccc_m.xccc002_desc = ''
   DISPLAY BY NAME g_xccc_m.xccc002_desc
 
   
   CALL axcq804_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccc_m.* TO NULL
      INITIALIZE g_xccc_d TO NULL
 
      CALL axcq804_show()
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
   CALL axcq804_set_act_visible()
   CALL axcq804_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc002_t = g_xccc_m.xccc002
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc002 = '", g_xccc_m.xccc002, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq804_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq804_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq804_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq804_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xccc_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq804_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xccc_t
    WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
    AND xccc001 = g_xccc001_t
    AND xccc002 = g_xccc002_t
    AND xccc003 = g_xccc003_t
    AND xccc004 = g_xccc004_t
    AND xccc005 = g_xccc005_t
 
       INTO TEMP axcq804_detail
   
   #將key修正為調整後   
   UPDATE axcq804_detail 
      #更新key欄位
      SET xcccld = g_xccc_m.xcccld
          , xccc001 = g_xccc_m.xccc001
          , xccc002 = g_xccc_m.xccc002
          , xccc003 = g_xccc_m.xccc003
          , xccc004 = g_xccc_m.xccc004
          , xccc005 = g_xccc_m.xccc005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccc_t SELECT * FROM axcq804_detail
   
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
   DROP TABLE axcq804_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc002_t = g_xccc_m.xccc002
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   DROP TABLE axcq804_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq804_delete()
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
   
   IF g_xccc_m.xcccld IS NULL
   OR g_xccc_m.xccc001 IS NULL
   OR g_xccc_m.xccc002 IS NULL
   OR g_xccc_m.xccc003 IS NULL
   OR g_xccc_m.xccc004 IS NULL
   OR g_xccc_m.xccc005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq804_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq804_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq804_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq804_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003, 
       g_xccc_m.xccc004,g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc002,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc, 
       g_xccc_m.xccc001_desc,g_xccc_m.xccc003_desc,g_xccc_m.xccc002_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq804_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   CALL axcq804_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq804_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xccc_t WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
                                                               AND xccc001 = g_xccc_m.xccc001
                                                               AND xccc002 = g_xccc_m.xccc002
                                                               AND xccc003 = g_xccc_m.xccc003
                                                               AND xccc004 = g_xccc_m.xccc004
                                                               AND xccc005 = g_xccc_m.xccc005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
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
      #   CLOSE axcq804_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xccc_d.clear() 
 
     
      CALL axcq804_ui_browser_refresh()  
      #CALL axcq804_ui_headershow()  
      #CALL axcq804_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq804_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq804_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq804_cl
 
   #功能已完成,通報訊息中心
   CALL axcq804_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq804.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq804_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xccc901 LIKE xccc_t.xccc901
   DEFINE l_xcff003 LIKE xcff_t.xcff003
   DEFINE l_xcck282 LIKE xcck_t.xcck282
   DEFINE l_xcfg019 LIKE xcfg_t.xcfg019
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
  
   #end add-point
   
   #先清空單身變數內容
   CALL g_xccc_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #160520-00003#11
   CALL axcq804_b_fill_2(p_wc2)
   RETURN 
   #160520-00003#11
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccc006,xccc007,xccc008,xccc902,xccc280 FROM xccc_t",   
               "",
               
               
               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc002=? AND xccc003=? AND xccc004=? AND xccc005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq804_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq804_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq804_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003, 
          g_xccc_m.xccc004,g_xccc_m.xccc005 INTO g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008, 
          g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc280   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #获得xccc901
         SELECT  UNIQUE xccc901 INTO l_xccc901
           FROM xccc_t                  
          WHERE xcccent = g_enterprise 
            AND xcccld = g_xccc_m.xcccld 
            AND xccc001 = g_xccc_m.xccc001
            AND xccc002 = g_xccc_m.xccc002
            AND xccc003 = g_xccc_m.xccc003
            AND xccc004 = g_xccc_m.xccc004
            AND xccc005 = g_xccc_m.xccc005
     
         #主分群码,单位
         SELECT imaa003,imaa104 INTO g_xccc_d[l_ac].imaa003,g_xccc_d[l_ac].imaa104
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_xccc_d[l_ac].xccc006
         
         #销售毛利率,销售费用利率
         SELECT xcff003 INTO l_xcff003
         FROM xcff_t
         WHERE xcffent = g_enterprise
           AND xcffcomp = g_xccc_m.xccccomp
           AND xcff001 = g_xccc_m.xccc004 #年度
           AND xcff002 = g_xccc_m.xccc005  #期别
           AND xcff004 = g_xccc_d[l_ac].imaa003
         
         SELECT xcff005,xcff006 INTO g_xccc_d[l_ac].xcff005,g_xccc_d[l_ac].xcff006
           FROM xcff_t
          WHERE xcffent = g_enterprise
            AND xcffcomp = g_xccc_m.xccccomp
            AND xcff001 = g_xccc_m.xccc004
            AND xcff002 = g_xccc_m.xccc005
            AND xcff003 = l_xcff003
            AND xcff004 = g_xccc_d[l_ac].imaa003
#            
#         #重置成本
#         SELECT xcck202 INTO  g_xccc_d[l_ac].rebcost
#          FROM xcck_t
#          WHERE xcckent = g_enterprise
#            AND xcckld = g_xccc_m.xcccld
#            AND xcck001 = g_xccc_m.xccc001
#            AND xcck002 = g_xccc_m.xccc002
#            AND xcck003 = g_xccc_m.xccc003
#            AND xcck004 = g_xccc_m.xccc004
#            AND xcck005 = g_xccc_m.xccc005
#            AND xcck010 = g_xccc_d[l_ac].xccc006
#            AND xcckcomp = g_xccc_m.xccccomp
#            
#         IF g_xccc_d[l_ac].rebcost = 0 OR cl_null(g_xccc_d[l_ac].rebcost) THEN
#            LET g_xccc_d[l_ac].rebcost = g_xccc_d[l_ac].xccc280
#         END IF
#         
      SELECT xcfg019 INTO l_xcfg019
        FROM xcfg_t
       WHERE xcfgent = g_enterprise
         AND xcfgcomp = g_xccc_m.xccccomp
         AND xcfgld = g_xccc_m.xcccld
         AND xcfg001 = g_xccc_m.xccc001
         AND xcfg002 = g_xccc_m.xccc002
         AND xcfg003 = g_xccc_m.xccc003
         AND xcfg004 = g_xccc_m.xccc004
         AND xcfg005 = g_xccc_m.xccc005
         AND xcfg006 = g_xccc_d[l_ac].xccc006
         AND xcfg007 = g_xccc_d[l_ac].xccc007
         AND xcfg008 = g_xccc_d[l_ac].xccc008
         
         IF NOT cl_null(l_xcfg019) THEN
            LET g_xccc_d[l_ac].rebcost = l_xcfg019
         ELSE
             #重置成本
            SELECT xcck282 INTO l_xcck282
             FROM xcck_t
             WHERE xcckent = g_enterprise
               AND xcckld = g_xccc_m.xcccld
               AND xcck001 = g_xccc_m.xccc001
               AND xcck002 = g_xccc_m.xccc002
               AND xcck003 = g_xccc_m.xccc003
               AND xcck004 = g_xccc_m.xccc004
               AND xcck005 = g_xccc_m.xccc005
               AND xcck010 = g_xccc_d[l_ac].xccc006
               AND xcck011 = g_xccc_d[l_ac].xccc007
               AND xcck017 = g_xccc_d[l_ac].xccc008
               AND xcckcomp = g_xccc_m.xccccomp
               ORDER BY xcck006 DESC
            
            LET g_xccc_d[l_ac].rebcost = l_xcck282
         END IF
         
         #获得相关inaj_t里的数据
         CALL axcq804_get_date()
         
         #上限、下限
         LET g_xccc_d[l_ac].upcost   = g_xccc_d[l_ac].rebcost - (g_xccc_d[l_ac].rebcost * g_xccc_d[l_ac].xcff006/100)
         LET g_xccc_d[l_ac].downcost = g_xccc_d[l_ac].rebcost - g_xccc_d[l_ac].rebcost * (g_xccc_d[l_ac].xcff006/100 + g_xccc_d[l_ac].xcff005/100)
         
         #市价
         IF g_xccc_d[l_ac].rebcost >= g_xccc_d[l_ac].upcost THEN #市价取上限
            LET g_xccc_d[l_ac].price = g_xccc_d[l_ac].upcost
         ELSE
            IF g_xccc_d[l_ac].rebcost < g_xccc_d[l_ac].downcost THEN #市价取下限
               LET g_xccc_d[l_ac].price = g_xccc_d[l_ac].downcost
            ELSE
               LET g_xccc_d[l_ac].price = g_xccc_d[l_ac].rebcost     #市价取重置成本
            END IF
         END IF

         LET g_xccc_d[l_ac].tot = l_xccc901 * g_xccc_d[l_ac].price  #市价总成本

         LET g_xccc_d[l_ac].lcm = g_xccc_d[l_ac].tot - g_xccc_d[l_ac].xccc902

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
 
            CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccc_d.getLength()
      LET g_xccc_d_mask_o[l_ac].* =  g_xccc_d[l_ac].*
      CALL axcq804_xccc_t_mask()
      LET g_xccc_d_mask_n[l_ac].* =  g_xccc_d[l_ac].*
   END FOR
   
 
 
   FREE axcq804_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq804_idx_chk()
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
      IF g_detail_idx > g_xccc_d.getLength() THEN
         LET g_detail_idx = g_xccc_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xccc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccc_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq804_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xccc_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq804_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xccc_t
    WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld AND
                              xccc001 = g_xccc_m.xccc001 AND
                              xccc002 = g_xccc_m.xccc002 AND
                              xccc003 = g_xccc_m.xccc003 AND
                              xccc004 = g_xccc_m.xccc004 AND
                              xccc005 = g_xccc_m.xccc005 AND
 
          xccc006 = g_xccc_d_t.xccc006
      AND xccc007 = g_xccc_d_t.xccc007
      AND xccc008 = g_xccc_d_t.xccc008
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
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
 
{<section id="axcq804.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq804_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq804.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq804_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq804.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq804_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq804.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq804_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xccc_d[l_ac].xccc006 = g_xccc_d_t.xccc006 
      AND g_xccc_d[l_ac].xccc007 = g_xccc_d_t.xccc007 
      AND g_xccc_d[l_ac].xccc008 = g_xccc_d_t.xccc008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq804_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq804.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq804_lock_b(ps_table,ps_page)
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
   #CALL axcq804_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq804.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq804_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq804.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq804_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc002,xccc003,xccc004,xccc005",TRUE)
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
 
{<section id="axcq804.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq804_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc002,xccc003,xccc004,xccc005",FALSE)
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
 
{<section id="axcq804.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq804_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq804_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq804_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq804.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq804_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq804.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq804_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq804.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq804_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq804.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq804_default_search()
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
      LET ls_wc = ls_wc, " xcccld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccc001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccc002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccc003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xccc004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xccc005 = '", g_argv[06], "' AND "
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
 
{<section id="axcq804.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq804_fill_chk(ps_idx)
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
 
{<section id="axcq804.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq804_modify_detail_chk(ps_record)
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
         LET ls_return = "imaa003"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq804.mask_functions" >}
&include "erp/axc/axcq804_mask.4gl"
 
{</section>}
 
{<section id="axcq804.state_change" >}
    
 
{</section>}
 
{<section id="axcq804.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq804_set_pk_array()
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
   LET g_pk_array[1].values = g_xccc_m.xcccld
   LET g_pk_array[1].column = 'xcccld'
   LET g_pk_array[2].values = g_xccc_m.xccc001
   LET g_pk_array[2].column = 'xccc001'
   LET g_pk_array[3].values = g_xccc_m.xccc002
   LET g_pk_array[3].column = 'xccc002'
   LET g_pk_array[4].values = g_xccc_m.xccc003
   LET g_pk_array[4].column = 'xccc003'
   LET g_pk_array[5].values = g_xccc_m.xccc004
   LET g_pk_array[5].column = 'xccc004'
   LET g_pk_array[6].values = g_xccc_m.xccc005
   LET g_pk_array[6].column = 'xccc005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq804.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq804_msgcentre_notify(lc_state)
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
   CALL axcq804_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xccc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq804.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq804_default()
 DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
 DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
 DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三
 DEFINE l_xcbf003   LIKE type_t.chr80    #20150605 By wangxin add


   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.xccc003
   
   IF cl_null(g_xccc_m.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data   #采用特性否 
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data1   #采用成本域否      
   ELSE
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6013') RETURNING g_para_data   #采用特性否 
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data1   #采用成本域否      
   END IF 
 
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc007',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xccc007',FALSE)                
   END IF 
    IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('lbl_xccc002,xccc002,xccc002_desc',TRUE)
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6002') RETURNING l_xcbf003 #20150605 by wangxin add
      #成本域  
      SELECT  xcbf001,xcbfl003  into g_xccc_m.xccc002,g_xccc_m.xccc002_desc
          FROM xcbf_t
      LEFT OUTER JOIN xcbfl_t ON xcbfl001 = xcbf001  AND xcbfcomp = xcbflcomp AND xcbfent = xcbflent 
       WHERE xcbfent =  g_enterprise 
         AND xcbfcomp = g_xccc_m.xccccomp 
         AND xcbf003 = l_xcbf003 #xcbf_t表改动了  where加个条件保证数据唯一性 20150605 BY wangxin add 
      DISPLAY BY NAME g_xccc_m.xccc002,g_xccc_m.xccc002_desc      
   ELSE                        
      CALL cl_set_comp_visible('lbl_xccc002,xccc002,xccc002_desc',FALSE)                
   END IF     
   #说明栏位
   CALL s_desc_get_department_desc(g_xccc_m.xccccomp) RETURNING g_xccc_m.xccccomp_desc #法人組織
   CALL s_desc_get_ld_desc(g_xccc_m.xcccld) RETURNING g_xccc_m.xcccld_desc #帳別編號
   DISPLAY BY NAME g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   
   #成本計算類型
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccc003_desc
   
   
   
   #本位币说明
   LET g_xccc_m.xccc001 = '1'
   DISPLAY BY NAME g_xccc_m.xccc001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccc_m.xcccld
  
      
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccc001_desc  
  
   
    #起始截止日期
    LET g_xccc_m.b_date_str = s_date_get_first_date(g_today)
    LET g_xccc_m.b_date_end = s_date_get_last_date(g_today)
    DISPLAY BY NAME g_xccc_m.b_date_str,g_xccc_m.b_date_end
    
    #年度期别
    CALL s_fin_date_get_period_value("",g_xccc_m.xcccld,g_xccc_m.b_date_end)  #根据日期值取得所属的年/期
    RETURNING g_sub_success,g_xccc_m.xccc004,g_xccc_m.xccc005
    DISPLAY BY NAME g_xccc_m.xccc004,g_xccc_m.xccc005
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明:获得对应的数据
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者: 20150420 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq804_get_date()

   DEFINE l_pmdsdocno LIKE pmds_t.pmdsdocno
   DEFINE l_sfeadocno LIKE sfea_t.sfeadocno
   DEFINE l_inaj003   LIKE inaj_t.inaj003
   
#   SELECT inaj011,inaj001,inaj002,inaj022 INTO g_xccc_d[l_ac].inaj011,g_xccc_d[l_ac].inaj001,g_xccc_d[l_ac].inaj002,g_xccc_d[l_ac].inaj022
#     FROM inaj_t
#    WHERE inaj012 = g_xccc_d[l_ac].imaa104
#      AND inaj004 = 1  #入库
#      AND inaj005 = g_xccc_d[l_ac].xccc006
#      AND (inaj015 = 'apmt570' OR inaj015 = 'asft340')
#      and inaj022 >= g_xccc_m.b_date_str
#      AND inaj022 <= g_xccc_m.b_date_end
#    ORDER BY inaj022 desc,inaj002 desc,inaj003 DESC
    
    SELECT DISTINCT inaj011,inaj001,inaj002,inaj022,inaj003 INTO g_xccc_d[l_ac].inaj011,g_xccc_d[l_ac].inaj001,g_xccc_d[l_ac].inaj002,g_xccc_d[l_ac].inaj022,l_inaj003
    FROM inaj_t 
    LEFT OUTER JOIN 
                   ( SELECT sfaa_t.*,xcbb006 
                       FROM sfaa_t,xcbb_t 
                      WHERE sfaaent = xcbbent AND sfaa010 = xcbb003 AND sfaa011 = xcbb004 
                        AND xcbbcomp = g_xccc_m.xccccomp AND xcbb001 = g_xccc_m.xccc004
                        AND xcbb002 = g_xccc_m.xccc005
                   ) B 
    ON inajent = B.sfaaent AND inaj020 = B.sfaadocno 
    WHERE inajent = g_enterprise
      AND inaj209 = g_xccc_m.xccccomp
      AND inaj004 = 1  #货龄只抓入库的
      AND inaj005 = g_xccc_d[l_ac].xccc006
      AND inaj022 BETWEEN g_xccc_m.b_date_str AND g_xccc_m.b_date_end
      AND ( ((inaj036 = '110' OR inaj036 = '111' OR inaj036 = '112') AND B.sfaa042 = 'N') 
            OR (inaj036 = '102' OR inaj036 = '108')
          )  #采购入库与工单入库
    ORDER BY inaj022 DESC,inaj002 DESC,inaj003 DESC
 
END FUNCTION

################################################################################
# Descriptions...: 效能优化-替换b_fill()
# Memo...........:
# Usage..........: CALL axcq804_b_fill_2(p_wc2)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq804_b_fill_2(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xccc901 LIKE xccc_t.xccc901
   DEFINE l_xcff003 LIKE xcff_t.xcff003
   DEFINE l_xcck282 LIKE xcck_t.xcck282
   DEFINE l_xcfg019 LIKE xcfg_t.xcfg019
   DEFINE l_inaj003 LIKE inaj_t.inaj003
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"

   #end add-point
   
   #先清空單身變數內容
   CALL g_xccc_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   #end add-point
   
#效能优化部分-整合到一个SQL里面，效能会更差   
#   LET g_sql = " SELECT DISTINCT imaa003,xccc006,xccc007,xccc008,imaa104,xccc902,xccc280,xcfg019, ",                           
#               " (SELECT xcff005 FROM xcff_t WHERE xcffent = xcccent AND xcff001 = xccc004 AND xcff002 = xccc005 AND xcff004 = imaa003) xccf005,",
#               " (SELECT xcff006 FROM xcff_t WHERE xcffent = xcccent AND xcff001 = xccc004 AND xcff002 = xccc005 AND xcff004 = imaa003) xccf006,",
#               " t1.inaj011,t1.inaj001,t1.inaj002,t1.inaj022,t1.inaj003,xccc901,xcck282 ",
#               " FROM xccc_t ",       
#               
#               
#               " LEFT JOIN imaa_t ON imaaent = xcccent AND imaa001 = xccc006 ",
#               " LEFT JOIN xcfg_t ON xcfgent = xcccent AND xcfgcomp = xccccomp AND xcfgld = xcccld AND xcfg001 = xccc001 AND xcfg002 = xccc002 AND xcfg003 = xccc003  ",
#               "  AND xcfg004 = xccc004 AND xcfg005 = xccc005 AND xcfg006 = xccc006 AND xcfg007 = xccc007 AND xcfg008 = xccc008 ",
#               
#               " LEFT JOIN xcck_t ON xcckent = xcccent AND xcckcomp = xccccomp AND xcckld = xcccld AND xcck001 = xccc001 AND xcck002 = xccc002 ",
#               "  AND xcck003 = xccc003 AND xcck004 = xccc004 AND xcck005 = xccc005 AND xcck010 = xccc006 AND xcck011 = xccc007 AND xcck017 = xccc008 ",
#               "  AND xcck006 = (SELECT MAX(t2.xcck006) FROM xcck_t t2 LEFT JOIN xccc_t t3 ON t2.xcckent = t3.xcccent AND t2.xcckcomp = t3.xccccomp AND t2.xcckld = t3.xcccld AND t2.xcck001 = t3.xccc001 AND t2.xcck002 = t3.xccc002 ",
#               "  AND t2.xcck003 = t3.xccc003 AND t2.xcck004 = t3.xccc004 AND t2.xcck005 = t3.xccc005 AND t2.xcck010 = t3.xccc006 AND t2.xcck011 = t3.xccc007 AND t2.xcck017 = t3.xccc008) ",
#                  
#                  
#               " LEFT JOIN (SELECT DISTINCT inaj011,inaj001,inaj002,inaj022,inaj003,inajent,inaj209,inaj005,inaj020 FROM inaj_t  ",
#    
#               "  LEFT JOIN ",
#               "    ( SELECT sfaaent,sfaadocno,sfaa042,xcbb006 FROM sfaa_t,xcbb_t ",
#                        
#               "       WHERE sfaaent = xcbbent AND sfaa010 = xcbb003 AND sfaa011 = xcbb004 ",
#               "         AND xcbbcomp = '",g_xccc_m.xccccomp,"' AND xcbb001 = '",g_xccc_m.xccc004,"'",
#               "         AND xcbb002 = '",g_xccc_m.xccc005,"') ",
#                  
#               "  ON inajent = sfaaent AND inaj020 = sfaadocno  ",
#               " WHERE inajent = ",g_enterprise,
#               "   AND inaj209 = '",g_xccc_m.xccccomp,"'",
#               " AND inaj004 = 1 ",  
#               #" AND inaj005 = '",g_xccc_d[l_ac].xccc006,"'",
#               " AND inaj022 BETWEEN '",g_xccc_m.b_date_str,"' AND '",g_xccc_m.b_date_end,"'",
#               
#               #lixh-cs1  #已通过
#               " AND inaj022 = (", 
#                "    SELECT MAX(t7.inaj022) FROM (SELECT DISTINCT t4.inaj022,t4.inaj002,t4.inaj003 FROM inaj_t t4  ",
#    
#               "  LEFT JOIN ",
#               "    ( SELECT sfaaent,sfaadocno,sfaa042,xcbb006 FROM sfaa_t,xcbb_t ",
#                        
#               "       WHERE sfaaent = xcbbent AND sfaa010 = xcbb003 AND sfaa011 = xcbb004 ",
#               "         AND xcbbcomp = '",g_xccc_m.xccccomp,"' AND xcbb001 = '",g_xccc_m.xccc004,"'",
#               "         AND xcbb002 = '",g_xccc_m.xccc005,"') t5 ",
#                  
#               "  ON t4.inajent = t5.sfaaent AND t4.inaj020 = t5.sfaadocno  ",
#               " WHERE t4.inajent = ",g_enterprise,
#               "   AND t4.inaj209 = '",g_xccc_m.xccccomp,"'",
#               "   AND t4.inaj004 = 1 ",  
#               #" AND inaj005 = '",g_xccc_d[l_ac].xccc006,"'",
#               " AND t4.inaj022 BETWEEN '",g_xccc_m.b_date_str,"' AND '",g_xccc_m.b_date_end,"'",
#               " AND ( ((t4.inaj036 = '110' OR t4.inaj036 = '111' OR t4.inaj036 = '112') AND t5.sfaa042 = 'N') ",
#               "      OR (t4.inaj036 = '102' OR t4.inaj036 = '108'))  ",
#                
#                " ) t7 )",  
#                
#               #lixh-cs1
#               
##               # lixh-cs2
##               " AND inaj002||inaj003  = ( ",
##               
##               "     SELECT MAX(t8.inaj002||t8.inaj003) FROM (",
##               "    SELECT DISTINCT inaj011,inaj001,inaj002,inaj022,inaj003,inajent,inaj209,inaj005,inaj020 FROM inaj_t  ",
##    
##               "  LEFT JOIN ",
##               "    ( SELECT sfaaent,sfaadocno,sfaa042,xcbb006 FROM sfaa_t,xcbb_t ",
##                        
##               "       WHERE sfaaent = xcbbent AND sfaa010 = xcbb003 AND sfaa011 = xcbb004 ",
##               "         AND xcbbcomp = '",g_xccc_m.xccccomp,"' AND xcbb001 = '",g_xccc_m.xccc004,"'",
##               "         AND xcbb002 = '",g_xccc_m.xccc005,"') ",
##                  
##               "  ON inajent = sfaaent AND inaj020 = sfaadocno  ",
##               " WHERE inajent = ",g_enterprise,
##               "   AND inaj209 = '",g_xccc_m.xccccomp,"'",
##               " AND inaj004 = 1 ",  
##               " AND inaj022 BETWEEN '",g_xccc_m.b_date_str,"' AND '",g_xccc_m.b_date_end,"'",
##               
##               " AND inaj022 = (", 
##                "    SELECT MAX(t9.inaj022) FROM (SELECT DISTINCT t10.inaj022 FROM inaj_t t10  ",
##    
##               "  LEFT JOIN ",
##               "    ( SELECT sfaaent,sfaadocno,sfaa042,xcbb006 FROM sfaa_t,xcbb_t ",
##                        
##               "       WHERE sfaaent = xcbbent AND sfaa010 = xcbb003 AND sfaa011 = xcbb004 ",
##               "         AND xcbbcomp = '",g_xccc_m.xccccomp,"' AND xcbb001 = '",g_xccc_m.xccc004,"'",
##               "         AND xcbb002 = '",g_xccc_m.xccc005,"') t11 ",
##                  
##               "  ON t10.inajent = t11.sfaaent AND t10.inaj020 = t11.sfaadocno  ",
##               " WHERE t10.inajent = ",g_enterprise,
##               "   AND t10.inaj209 = '",g_xccc_m.xccccomp,"'",
##               "   AND t10.inaj004 = 1 ",  
##               " AND t10.inaj022 BETWEEN '",g_xccc_m.b_date_str,"' AND '",g_xccc_m.b_date_end,"'",
##               " AND ( ((t10.inaj036 = '110' OR t10.inaj036 = '111' OR t10.inaj036 = '112') AND t11.sfaa042 = 'N') ",
##               "      OR (t10.inaj036 = '102' OR t10.inaj036 = '108'))  ",
##                
##                " ) t9 )",                
##               
##               " ) t8 ",
##               
##               " )",
##               # lixh-cs2
#               
#               " AND ( ((inaj036 = '110' OR inaj036 = '111' OR inaj036 = '112') AND sfaa042 = 'N') ",
#               "      OR (inaj036 = '102' OR inaj036 = '108') ",                                
#               "    )  ) t1 ON t1.inajent = xcccent AND t1.inaj209 = xccccomp AND t1.inaj005 = xccc006  ",
#                
#               
#               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc002=? AND xccc003=? AND xccc004=? AND xccc005=?"  
#效能优化部分-整合到一个SQL里面，效能会更差

   LET g_sql = " SELECT DISTINCT imaa003,xccc006,xccc007,xccc008,imaa104,xccc902,xccc280,",
               " ( CASE WHEN xcfg019 <> 0 THEN xcfg019 WHEN xcfg019 IS NULL THEN xcck282 END) xcfg019 , ",                           
               " (SELECT xcff005 FROM xcff_t WHERE xcffent = xcccent AND xcff001 = xccc004 AND xcff002 = xccc005 AND xcff004 = imaa003) xccf005,",
               " (SELECT xcff006 FROM xcff_t WHERE xcffent = xcccent AND xcff001 = xccc004 AND xcff002 = xccc005 AND xcff004 = imaa003) xccf006,",
              # " xccc901,xcck282 ",
               " xccc901 ",
               " FROM xccc_t ",       
               
               
               " LEFT JOIN imaa_t ON imaaent = xcccent AND imaa001 = xccc006 ",
               " LEFT JOIN xcfg_t ON xcfgent = xcccent AND xcfgcomp = xccccomp AND xcfgld = xcccld AND xcfg001 = xccc001 AND xcfg002 = xccc002 AND xcfg003 = xccc003  ",
               "  AND xcfg004 = xccc004 AND xcfg005 = xccc005 AND xcfg006 = xccc006 AND xcfg007 = xccc007 AND xcfg008 = xccc008 ",
               
               " LEFT JOIN xcck_t ON xcckent = xcccent AND xcckcomp = xccccomp AND xcckld = xcccld AND xcck001 = xccc001 AND xcck002 = xccc002 ",
               "  AND xcck003 = xccc003 AND xcck004 = xccc004 AND xcck005 = xccc005 AND xcck010 = xccc006 AND xcck011 = xccc007 AND xcck017 = xccc008 ",
               "  AND xcck006 = (SELECT MAX(t2.xcck006) FROM xcck_t t2 LEFT JOIN xccc_t t3 ON t2.xcckent = t3.xcccent AND t2.xcckcomp = t3.xccccomp AND t2.xcckld = t3.xcccld AND t2.xcck001 = t3.xccc001 AND t2.xcck002 = t3.xccc002 ",
               "  AND t2.xcck003 = t3.xccc003 AND t2.xcck004 = t3.xccc004 AND t2.xcck005 = t3.xccc005 AND t2.xcck010 = t3.xccc006 AND t2.xcck011 = t3.xccc007 AND t2.xcck017 = t3.xccc008) ", 
               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc002=? AND xccc003=? AND xccc004=? AND xccc005=?"                 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq804_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY xccc006,xccc007,xccc008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"

         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq804_pb_2 FROM g_sql
         DECLARE b_fill_cs_2 CURSOR FOR axcq804_pb_2
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs_2 USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc002,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
                                               
#      FOREACH b_fill_cs_2 INTO g_xccc_d[l_ac].imaa003,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].imaa104,
#                             g_xccc_d[l_ac].xccc902, g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].rebcost,g_xccc_d[l_ac].xcff005,g_xccc_d[l_ac].xcff006,
#                             g_xccc_d[l_ac].inaj011,g_xccc_d[l_ac].inaj001,g_xccc_d[l_ac].inaj002,g_xccc_d[l_ac].inaj022,l_inaj003,l_xccc901,l_xcck282

      FOREACH b_fill_cs_2 INTO g_xccc_d[l_ac].imaa003,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].imaa104,
                               g_xccc_d[l_ac].xccc902, g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].rebcost,g_xccc_d[l_ac].xcff005,g_xccc_d[l_ac].xcff006,
                               l_xccc901,l_xcck282
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
#      SELECT xcfg019 INTO l_xcfg019
#        FROM xcfg_t
#       WHERE xcfgent = g_enterprise
#         AND xcfgcomp = g_xccc_m.xccccomp
#         AND xcfgld = g_xccc_m.xcccld
#         AND xcfg001 = g_xccc_m.xccc001
#         AND xcfg002 = g_xccc_m.xccc002
#         AND xcfg003 = g_xccc_m.xccc003
#         AND xcfg004 = g_xccc_m.xccc004
#         AND xcfg005 = g_xccc_m.xccc005
#         AND xcfg006 = g_xccc_d[l_ac].xccc006
#         AND xcfg007 = g_xccc_d[l_ac].xccc007
#         AND xcfg008 = g_xccc_d[l_ac].xccc008
         
#         IF NOT cl_null(l_xcfg019) THEN
#            LET g_xccc_d[l_ac].rebcost = l_xcfg019
#         ELSE
#             #重置成本
#            SELECT xcck282 INTO l_xcck282
#             FROM xcck_t
#             WHERE xcckent = g_enterprise
#               AND xcckld = g_xccc_m.xcccld
#               AND xcck001 = g_xccc_m.xccc001
#               AND xcck002 = g_xccc_m.xccc002
#               AND xcck003 = g_xccc_m.xccc003
#               AND xcck004 = g_xccc_m.xccc004
#               AND xcck005 = g_xccc_m.xccc005
#               AND xcck010 = g_xccc_d[l_ac].xccc006
#               AND xcck011 = g_xccc_d[l_ac].xccc007
#               AND xcck017 = g_xccc_d[l_ac].xccc008
#               AND xcckcomp = g_xccc_m.xccccomp
#               ORDER BY xcck006 DESC
#            
#            LET g_xccc_d[l_ac].rebcost = l_xcck282
#         END IF
         
         #获得相关inaj_t里的数据
         CALL axcq804_get_date()
         

                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         IF cl_null(g_xccc_d[l_ac].rebcost) THEN
            LET g_xccc_d[l_ac].rebcost = l_xcck282
         END IF
         
         #上限、下限
         LET g_xccc_d[l_ac].upcost   = g_xccc_d[l_ac].rebcost - (g_xccc_d[l_ac].rebcost * g_xccc_d[l_ac].xcff006/100)
         LET g_xccc_d[l_ac].downcost = g_xccc_d[l_ac].rebcost - g_xccc_d[l_ac].rebcost * (g_xccc_d[l_ac].xcff006/100 + g_xccc_d[l_ac].xcff005/100)
         
         #市价
         IF g_xccc_d[l_ac].rebcost >= g_xccc_d[l_ac].upcost THEN #市价取上限
            LET g_xccc_d[l_ac].price = g_xccc_d[l_ac].upcost
         ELSE
            IF g_xccc_d[l_ac].rebcost < g_xccc_d[l_ac].downcost THEN #市价取下限
               LET g_xccc_d[l_ac].price = g_xccc_d[l_ac].downcost
            ELSE
               LET g_xccc_d[l_ac].price = g_xccc_d[l_ac].rebcost     #市价取重置成本
            END IF
         END IF

         LET g_xccc_d[l_ac].tot = l_xccc901 * g_xccc_d[l_ac].price  #市价总成本

         LET g_xccc_d[l_ac].lcm = g_xccc_d[l_ac].tot - g_xccc_d[l_ac].xccc902

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
 
            CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccc_d.getLength()
      LET g_xccc_d_mask_o[l_ac].* =  g_xccc_d[l_ac].*
      CALL axcq804_xccc_t_mask()
      LET g_xccc_d_mask_n[l_ac].* =  g_xccc_d[l_ac].*
   END FOR
   
 
 
   FREE axcq804_pb 
END FUNCTION

 
{</section>}
 
