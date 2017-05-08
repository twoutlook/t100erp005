{<section id="adzi100.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000001
#+ 
#+ Filename...: adzi100
#+ Description: 
#+ Creator....: 00845(2014-11-18 11:45:49)
#+ Modifier...: 00845(2014-11-18 11:45:49) -SD/PR- 00000()
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="adzi100.global" >}

        
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
PRIVATE type type_g_dzdy_m        RECORD
       dzdy001 LIKE dzdy_t.dzdy001, 
   dzdy002 LIKE dzdy_t.dzdy002, 
   dzdy003 LIKE dzdy_t.dzdy003, 
   dzdy004 LIKE dzdy_t.dzdy004,
   dzdy005 LIKE dzdy_t.dzdy005,
   statepic LIKE type_t.chr50, 
   dzdyownid LIKE dzdy_t.dzdyownid, 
   dzdyownid_desc LIKE type_t.chr80, 
   dzdyowndp LIKE dzdy_t.dzdyowndp, 
   dzdyowndp_desc LIKE type_t.chr80, 
   dzdycrtid LIKE dzdy_t.dzdycrtid, 
   dzdycrtid_desc LIKE type_t.chr80, 
   dzdycrtdp LIKE dzdy_t.dzdycrtdp, 
   dzdycrtdp_desc LIKE type_t.chr80, 
   dzdycrtdt LIKE dzdy_t.dzdycrtdt, 
   dzdymodid LIKE dzdy_t.dzdymodid, 
   dzdymodid_desc LIKE type_t.chr80, 
   dzdymoddt LIKE dzdy_t.dzdymoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dzdz_d        RECORD
       dzdz002 LIKE dzdz_t.dzdz002, 
   dzdz004 LIKE dzdz_t.dzdz004, 
   dzdz005 LIKE dzdz_t.dzdz005, 
   dzdz006 LIKE dzdz_t.dzdz006,
   dzdz009 LIKE dzdz_t.dzdz009, 
   dzdz007 LIKE dzdz_t.dzdz007, 
   dzdz008 LIKE dzdz_t.dzdz008,
   dzdz003 LIKE dzdz_t.dzdz003,
   image LIKE type_t.chr500
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_dzdy_m          type_g_dzdy_m
DEFINE g_dzdy_m_t        type_g_dzdy_m
DEFINE g_dzdy_m_o        type_g_dzdy_m
 
   DEFINE g_dzdy001_t LIKE dzdy_t.dzdy001
 
 
DEFINE g_dzdz_d          DYNAMIC ARRAY OF type_g_dzdz_d
DEFINE g_dzdz_d_t        type_g_dzdz_d
DEFINE g_dzdz_d_o        type_g_dzdz_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
         b_b_state LIKE type_t.chr50,
         b_dzdy001 LIKE dzdy_t.dzdy001,
         b_dzdy002 LIKE dzdy_t.dzdy002,
         b_dzdy003 LIKE dzdy_t.dzdy003,
         b_dzdy004 LIKE dzdy_t.dzdy004
      END RECORD 
      
DEFINE g_browser_f  RECORD #資料瀏覽之欄位 
       b_statepic     LIKE type_t.chr50,
          b_dzdy001 LIKE dzdy_t.dzdy001,
      b_dzdy002 LIKE dzdy_t.dzdy002,
      b_dzdy003 LIKE dzdy_t.dzdy003
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
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
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
DEFINE g_mdl_chk             BOOLEAN

#單身 type 宣告
PRIVATE TYPE type_g_diff_d  RECORD
   line_no   STRING, #行號 
   left_col  STRING, #左邊差異收集
   right_col STRING  #右邊差異收集  
       END RECORD

DEFINE g_diff_d DYNAMIC ARRAY OF type_g_diff_d 

DEFINE g_chk_ver  LIKE type_t.num5   
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="adzi100.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")
 
   #add-point:作業初始化
   LET g_t100debug = FGL_GETENV("T100DEBUG")
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT dzdy001,dzdy002,dzdy003,dzdy004,dzdy005,dzdyownid,'',dzdyowndp,'',dzdycrtid,'', 
       dzdycrtdp,'',dzdycrtdt,dzdymodid,'',dzdymoddt", 
                      " FROM dzdy_t",
                      " WHERE dzdy001=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adzi100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.dzdy001,t0.dzdy002,t0.dzdy003,t0.dzdy004,t0.dzdy005,t0.dzdyownid,t0.dzdyowndp, 
       t0.dzdycrtid,t0.dzdycrtdp,t0.dzdycrtdt,t0.dzdymodid,t0.dzdymoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011",
               " FROM dzdy_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.dzdyownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.dzdyowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.dzdycrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.dzdycrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.dzdymodid  ",
 
               " WHERE  t0.dzdy001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE adzi100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi100 WITH FORM cl_ap_formpath("adz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adzi100_init()   
 
      #進入選單 Menu (="N")
      CALL adzi100_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adzi100
      
   END IF 
   
   CLOSE adzi100_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="adzi100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi100_init()
   #add-point:init段define
   
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   
   #end add-point
   
   CALL adzi100_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adzi100.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adzi100_ui_dialog()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   DEFINE ls_loc    STRING
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
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
   #+ 此段落由子樣板a42產生
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL adzi100_insert()
            #add-point:ON ACTION insert
            
            #END add-point
         END IF
 
      #add-point:action default自訂
      
      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
   
   WHILE TRUE 
   
      #先填充browser資料
      CALL adzi100_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
 
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
 
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL adzi100_fetch('') # reload data
               LET l_ac = 1
               CALL adzi100_ui_detailshow() #Setting the current row 
      
               CALL adzi100_idx_chk()
               #NEXT FIELD dzdz002
         
         END DISPLAY
        
         DISPLAY ARRAY g_dzdz_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adzi100_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL adzi100_idx_chk()
               #add-point:page1自定義行為
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY

         #add-point:ui_dialog段自定義display array
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
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
               CALL adzi100_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adzi100_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adzi100_idx_chk()
            
            #add-point:ui_dialog段before_dialog2
            #只有t10dev可以修改
            LET ls_loc = FGL_GETENV("ORACLE_SID")
            IF ls_loc <> 't10dev' THEN
               CALL cl_set_act_visible("modify,modify_detail", FALSE)
            END IF
            #end add-point

         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL adzi100_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL adzi100_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL adzi100_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #+ 此段落由子樣板a49產生
         #過濾瀏覽頁資料
         ON ACTION filter
            #add-point:filter action
            
            #end add-point
            CALL adzi100_filter()
            EXIT DIALOG
         
         #匯出樣板
         ON ACTION export_template
            LET g_action_choice="export_template"
            IF cl_auth_chk_act("export_template") THEN
               CALL adzi100_export_template(g_dzdy_m.dzdy001,g_dzdy_m.dzdy004)
            END IF
		 
         ON ACTION first
            CALL adzi100_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi100_idx_chk()
            
         ON ACTION previous
            CALL adzi100_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi100_idx_chk()
            
         ON ACTION jump
            CALL adzi100_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi100_idx_chk()
            
         ON ACTION next
            CALL adzi100_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi100_idx_chk()
            
         ON ACTION last
            CALL adzi100_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi100_idx_chk()
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_dzdz_d)
 
                  #add-point:ON ACTION exporttoexcel
                  
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
            END IF
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
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
               NEXT FIELD dzdz002
            END IF
       
         #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
    
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adzi100_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adzi100_modify()
               #add-point:ON ACTION modify_detail
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adzi100_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adzi100_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL adzi100_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adzi100_query()
               #add-point:ON ACTION query
               #只有t10dev可以修改
               LET ls_loc = FGL_GETENV("ORACLE_SID")
               IF ls_loc <> 't10dev' THEN
                  CALL cl_set_act_visible("modify,modify_detail", FALSE)
               END IF
               #END add-point
               #此段落由子樣板a59產生  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)

            END IF

         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL adzi100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adzi100_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adzi100_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
            
      END DIALOG
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="adzi100.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi100_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   DEFINE ls_file           STRING
   DEFINE li_no             LIKE type_t.num5
   DEFINE pc_dzdz004        LIKE dzdz_t.dzdz004
   DEFINE ls_temp           STRING
   DEFINE gt_start,gt_temp_start,gt_end  DATETIME HOUR TO SECOND
   #end add-point   
   
   #add-point:browser_fill段動作開始前
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE dzdy001 ",
                      " FROM dzdy_t ",
                      " ",
                      " LEFT JOIN dzdz_t ON dzdy001 = dzdz001 ",
 
 
                      " ", 
                      " ", 
                      " WHERE   ",l_wc, " AND ", l_wc2, cl_sql_add_filter("dzdy_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE dzdy001 ",
                      " FROM dzdy_t ", 
                      "  ",
                      "  ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("dzdy_t")
   END IF
   
   #add-point:browser_fill,cnt wc
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
   
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   IF g_browser_cnt > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_rec
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_dzdy_m.* TO NULL
      CALL g_dzdz_d.clear()        
      #add-point:browser_fill g_add_browse段額外處理
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.dzdy001,t0.dzdy002,t0.dzdy003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql = " SELECT DISTINCT t0.dzdystus,t0.dzdy001,t0.dzdy002,t0.dzdy003,t0.dzdy004 ",
               " FROM dzdy_t t0",
               "  ",
               "  LEFT JOIN dzdz_t ON dzdy001 = dzdz001 ",
 
 
               "  ",
               
               " WHERE  ",l_wc," AND ",l_wc2, cl_sql_add_filter("dzdy_t")
   #add-point:browser_fill,sql wc
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY dzdy001 ",g_order
 
   #add-point:browser_fill,before_prepare
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"dzdy_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor
   
   #end add-point
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_dzdy001,g_browser[g_cnt].b_dzdy002, 
       g_browser[g_cnt].b_dzdy003,g_browser[g_cnt].b_dzdy004
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:browser_fill段reference
      #定義檔案讀取路徑
      CALL adzi100_get_template(g_browser[g_cnt].b_dzdy001,g_browser[g_cnt].b_dzdy004) RETURNING ls_file 

      IF os.Path.exists(ls_file) THEN 
         
         #計算 MD5 註:有些樣板會花 1 秒
         CALL sadzi100_counting_md5(ls_file) RETURNING ls_temp
        
         SELECT dzdz004 INTO pc_dzdz004 FROM dzdz_t
          WHERE dzdz002 = (SELECT MAX(dzdz002) FROM dzdz_t 
                            WHERE dzdz001 = g_browser[g_cnt].b_dzdy001)
            AND dzdz001 = g_browser[g_cnt].b_dzdy001  
         
         IF ls_temp = pc_dzdz004 THEN 
            LET g_browser[g_cnt].b_b_state = "16/lights_green.png" 
         ELSE 
            LET g_browser[g_cnt].b_b_state = "16/lights_red.png"
         END IF 
      END IF
      
      #end add-point
  
      
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
   
   IF cl_null(g_browser[g_cnt].b_dzdy001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   DISPLAY g_current_idx TO FORMONLY.b_index   #當下筆數的顯示
   DISPLAY g_current_idx TO FORMONLY.h_index   #當下筆數的顯示
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", FALSE)
   END IF
   
   #add-point:browser_fill段結束前
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adzi100_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_dzdy_m.dzdy001 = g_browser[g_current_idx].b_dzdy001   
 
   EXECUTE adzi100_master_referesh USING g_dzdy_m.dzdy001 INTO g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003, 
       g_dzdy_m.dzdy004,g_dzdy_m.dzdy005,g_dzdy_m.dzdyownid,g_dzdy_m.dzdyowndp,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtdp, 
       g_dzdy_m.dzdycrtdt,g_dzdy_m.dzdymodid,g_dzdy_m.dzdymoddt,g_dzdy_m.dzdyownid_desc,g_dzdy_m.dzdyowndp_desc, 
       g_dzdy_m.dzdycrtid_desc,g_dzdy_m.dzdycrtdp_desc,g_dzdy_m.dzdymodid_desc
   CALL adzi100_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adzi100.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adzi100_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi100_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzdy001 = g_dzdy_m.dzdy001 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser.getLength()
 
   #add-point:ui_browser_refresh段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adzi100_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzdy_m.* TO NULL
   CALL g_dzdz_d.clear()        
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dzdy001,dzdy002,dzdy003,dzdy004,dzdy005,dzdyownid,dzdyowndp,dzdycrtid,dzdycrtdp, 
          dzdycrtdt,dzdymodid,dzdymoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<dzdycrtdt>>----
         AFTER FIELD dzdycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdymoddt>>----
         AFTER FIELD dzdymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdycnfdt>>----
         
         #----<<dzdypstdt>>----
 
 
            
         #一般欄位開窗相關處理    
                  #此段落由子樣板a01產生
         BEFORE FIELD dzdy001
            #add-point:BEFORE FIELD dzdy001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy001
            
            #add-point:AFTER FIELD dzdy001
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdy001
#         ON ACTION controlp INFIELD dzdy001
            #add-point:ON ACTION controlp INFIELD dzdy001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdy002
            #add-point:BEFORE FIELD dzdy002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy002
            
            #add-point:AFTER FIELD dzdy002
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdy002
#         ON ACTION controlp INFIELD dzdy002
            #add-point:ON ACTION controlp INFIELD dzdy002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdy003
            #add-point:BEFORE FIELD dzdy003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy003
            
            #add-point:AFTER FIELD dzdy003
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdy003
#         ON ACTION controlp INFIELD dzdy003
            #add-point:ON ACTION controlp INFIELD dzdy003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdy004
            #add-point:BEFORE FIELD dzdy004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy004
            
            #add-point:AFTER FIELD dzdy004
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdy004
#         ON ACTION controlp INFIELD dzdy004
            #add-point:ON ACTION controlp INFIELD dzdy004
            
            #END add-point

        #此段落由子樣板a01產生
         BEFORE FIELD dzdy005
            #add-point:BEFORE FIELD dzdy004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy005
            
            #add-point:AFTER FIELD dzdy005
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdy005
#         ON ACTION controlp INFIELD dzdy005
            #add-point:ON ACTION controlp INFIELD dzdy005
            
            #END add-point    
 
         #Ctrlp:construct.c.dzdyownid
         ON ACTION controlp INFIELD dzdyownid
            #add-point:ON ACTION controlp INFIELD dzdyownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdyownid  #顯示到畫面上
            NEXT FIELD dzdyownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdyownid
            #add-point:BEFORE FIELD dzdyownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdyownid
            
            #add-point:AFTER FIELD dzdyownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdyowndp
         ON ACTION controlp INFIELD dzdyowndp
            #add-point:ON ACTION controlp INFIELD dzdyowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdyowndp  #顯示到畫面上
            NEXT FIELD dzdyowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdyowndp
            #add-point:BEFORE FIELD dzdyowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdyowndp
            
            #add-point:AFTER FIELD dzdyowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdycrtid
         ON ACTION controlp INFIELD dzdycrtid
            #add-point:ON ACTION controlp INFIELD dzdycrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdycrtid  #顯示到畫面上
            NEXT FIELD dzdycrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdycrtid
            #add-point:BEFORE FIELD dzdycrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdycrtid
            
            #add-point:AFTER FIELD dzdycrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzdycrtdp
         ON ACTION controlp INFIELD dzdycrtdp
            #add-point:ON ACTION controlp INFIELD dzdycrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdycrtdp  #顯示到畫面上
            NEXT FIELD dzdycrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdycrtdp
            #add-point:BEFORE FIELD dzdycrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdycrtdp
            
            #add-point:AFTER FIELD dzdycrtdp
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdycrtdt
            #add-point:BEFORE FIELD dzdycrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.dzdymodid
         ON ACTION controlp INFIELD dzdymodid
            #add-point:ON ACTION controlp INFIELD dzdymodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdymodid  #顯示到畫面上
            NEXT FIELD dzdymodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdymodid
            #add-point:BEFORE FIELD dzdymodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdymodid
            
            #add-point:AFTER FIELD dzdymodid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdymoddt
            #add-point:BEFORE FIELD dzdymoddt
            
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON dzdz002,dzdz004,dzdz005,dzdz006,dzdz009,dzdz007,dzdz008
           FROM s_detail1[1].dzdz002,s_detail1[1].dzdz004,s_detail1[1].dzdz005,s_detail1[1].dzdz006,s_detail1[1].dzdz009, 
               s_detail1[1].dzdz007,s_detail1[1].dzdz008
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #此段落由子樣板a01產生
         BEFORE FIELD dzdz002
            #add-point:BEFORE FIELD dzdz002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz002
            
            #add-point:AFTER FIELD dzdz002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdz002
#         ON ACTION controlp INFIELD dzdz002
            #add-point:ON ACTION controlp INFIELD dzdz002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz004
            #add-point:BEFORE FIELD dzdz004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz004
            
            #add-point:AFTER FIELD dzdz004
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdz004
#         ON ACTION controlp INFIELD dzdz004
            #add-point:ON ACTION controlp INFIELD dzdz004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz005
            #add-point:BEFORE FIELD dzdz005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz005
            
            #add-point:AFTER FIELD dzdz005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdz005
#         ON ACTION controlp INFIELD dzdz005
            #add-point:ON ACTION controlp INFIELD dzdz005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz006
            #add-point:BEFORE FIELD dzdz006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz006
            
            #add-point:AFTER FIELD dzdz006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdz006
#         ON ACTION controlp INFIELD dzdz006
            #add-point:ON ACTION controlp INFIELD dzdz006
            
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD dzdz009
            #add-point:BEFORE FIELD dzdz009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz009
            
            #add-point:AFTER FIELD dzdz009
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdz009
#         ON ACTION controlp INFIELD dzdz009
            #add-point:ON ACTION controlp INFIELD dzdz009
            
            #END add-point
           
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz007
            #add-point:BEFORE FIELD dzdz007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz007
            
            #add-point:AFTER FIELD dzdz007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdz007
#         ON ACTION controlp INFIELD dzdz007
            #add-point:ON ACTION controlp INFIELD dzdz007
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz008
            #add-point:BEFORE FIELD dzdz008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz008
            
            #add-point:AFTER FIELD dzdz008
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdz008
#         ON ACTION controlp INFIELD dzdz008
            #add-point:ON ACTION controlp INFIELD dzdz008
            
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.filter" >}
#+ 此段落由子樣板a50產生
#+ filter過濾功能
PRIVATE FUNCTION adzi100_filter()
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
      CONSTRUCT g_wc_filter ON dzdy001,dzdy002,dzdy003
                          FROM s_browse[1].b_dzdy001,s_browse[1].b_dzdy002,s_browse[1].b_dzdy003
 
         BEFORE CONSTRUCT
               DISPLAY adzi100_filter_parser('dzdy001') TO s_browse[1].b_dzdy001
            DISPLAY adzi100_filter_parser('dzdy002') TO s_browse[1].b_dzdy002
            DISPLAY adzi100_filter_parser('dzdy003') TO s_browse[1].b_dzdy003
      
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
 
      CALL adzi100_filter_show('dzdy001')
   CALL adzi100_filter_show('dzdy002')
   CALL adzi100_filter_show('dzdy003')
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adzi100_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="adzi100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adzi100_filter_show(ps_field)
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
   LET ls_condition = adzi100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi100_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
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
   CALL g_dzdz_d.clear()
   CALL gfrm_curr.setElementImage("state", "")
   
   #add-point:query段other
   
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL adzi100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adzi100_browser_fill("")
      CALL adzi100_fetch("")
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
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL adzi100_filter_show('dzdy001')
   CALL adzi100_filter_show('dzdy002')
   CALL adzi100_filter_show('dzdy003')
   CALL adzi100_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL adzi100_fetch("F") 
      #顯示單身筆數
      CALL adzi100_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi100_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
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
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_dzdy_m.dzdy001 = g_browser[g_current_idx].b_dzdy001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adzi100_master_referesh USING g_dzdy_m.dzdy001 INTO g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003, 
       g_dzdy_m.dzdy004,g_dzdy_m.dzdy005,g_dzdy_m.dzdyownid,g_dzdy_m.dzdyowndp,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtdp, 
       g_dzdy_m.dzdycrtdt,g_dzdy_m.dzdymodid,g_dzdy_m.dzdymoddt,g_dzdy_m.dzdyownid_desc,g_dzdy_m.dzdyowndp_desc, 
       g_dzdy_m.dzdycrtid_desc,g_dzdy_m.dzdycrtdp_desc,g_dzdy_m.dzdymodid_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dzdy_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_dzdy_m.* TO NULL
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adzi100_set_act_visible()   
   CALL adzi100_set_act_no_visible()
   
   #add-point:fetch段action控制
   
   #end add-point  
   
   
   
   #add-point:fetch結束前
   
   #end add-point
   
   #保存單頭舊值
   LET g_dzdy_m_t.* = g_dzdy_m.*
   LET g_dzdy_m_o.* = g_dzdy_m.*
   
   LET g_data_owner = g_dzdy_m.dzdyownid      
   LET g_data_dept  = g_dzdy_m.dzdyowndp
   
   #重新顯示   
   CALL adzi100_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.insert" >}
#+ 資料新增
PRIVATE FUNCTION adzi100_insert()
   #add-point:insert段define
   
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_dzdz_d.clear()   
   CALL gfrm_curr.setElementImage("state", "")
 
   INITIALIZE g_dzdy_m.* LIKE dzdy_t.*             #DEFAULT 設定
   
   LET g_dzdy001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_dzdy_m.dzdyownid = g_user
      LET g_dzdy_m.dzdyowndp = g_dept
      LET g_dzdy_m.dzdycrtid = g_user
      LET g_dzdy_m.dzdycrtdp = g_dept 
      LET g_dzdy_m.dzdycrtdt = cl_get_current()
      LET g_dzdy_m.dzdymodid = ""
      LET g_dzdy_m.dzdymoddt = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值
      
      #end add-point 
      
      #顯示狀態(stus)圖片
      
    
      CALL adzi100_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_dzdy_m.* TO NULL
         INITIALIZE g_dzdz_d TO NULL
 
         #add-point:取消新增後
         
         #end add-point 
         CALL adzi100_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_dzdz_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adzi100_set_act_visible()   
   CALL adzi100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_dzdy001_t = g_dzdy_m.dzdy001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzdy001 = '", g_dzdy_m.dzdy001, "' "
 
                      
   #add-point:組合新增資料的條件後
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adzi100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adzi100_cl
   
   CALL adzi100_idx_chk()
   
   #add-point:新增結束後
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.modify" >}
#+ 資料修改
PRIVATE FUNCTION adzi100_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define
   
   #end add-point    
   
   #保存單頭舊值
   LET g_dzdy_m_t.* = g_dzdy_m.*
   LET g_dzdy_m_o.* = g_dzdy_m.*
   
   IF g_dzdy_m.dzdy001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   ERROR ""
  
   LET g_dzdy001_t = g_dzdy_m.dzdy001
 
   CALL s_transaction_begin()
   
   OPEN adzi100_cl USING g_dzdy_m.dzdy001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adzi100_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE adzi100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adzi100_master_referesh USING g_dzdy_m.dzdy001 INTO g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003, 
       g_dzdy_m.dzdy004,g_dzdy_m.dzdy005,g_dzdy_m.dzdyownid,g_dzdy_m.dzdyowndp,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtdp, 
       g_dzdy_m.dzdycrtdt,g_dzdy_m.dzdymodid,g_dzdy_m.dzdymoddt,g_dzdy_m.dzdyownid_desc,g_dzdy_m.dzdyowndp_desc, 
       g_dzdy_m.dzdycrtid_desc,g_dzdy_m.dzdycrtdp_desc,g_dzdy_m.dzdymodid_desc
   
   
   
   #add-point:modify段show之前
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL adzi100_show()
   #add-point:modify段show之後
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_dzdy001_t = g_dzdy_m.dzdy001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_dzdy_m.dzdymodid = g_user 
      LET g_dzdy_m.dzdymoddt = cl_get_current()
      LET g_dzdy_m.dzdymodid_desc = cl_get_username(g_dzdy_m.dzdymodid)
      
      #add-point:modify段修改前
      
      #end add-point
      
      #欄位更改
      CALL adzi100_input("u")
 
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzdy_m.* = g_dzdy_m_t.*
         CALL adzi100_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      #若有modid跟moddt則進行update
      UPDATE dzdy_t SET (dzdymodid,dzdymoddt) = (g_dzdy_m.dzdymodid,g_dzdy_m.dzdymoddt)
       WHERE  dzdy001 = g_dzdy001_t
 
                  
      #若單頭key欄位有變更
      IF g_dzdy_m.dzdy001 != g_dzdy001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
         
         #end add-point
         
         #更新單身key值
         UPDATE dzdz_t SET dzdz001 = g_dzdy_m.dzdy001
 
          WHERE  dzdz001 = g_dzdy001_t
 
            
         #add-point:單身fk修改中
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dzdz_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dzdz_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adzi100_set_act_visible()   
   CALL adzi100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzdy001 = '", g_dzdy_m.dzdy001, "' "
 
   #填到對應位置
   CALL adzi100_browser_fill("")
 
   CLOSE adzi100_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_dzdy_m.dzdy001,'U')

   #15/06/01 #顯示最新資料
   CALL adzi100_show()
   #15/06/01   
END FUNCTION   
 
{</section>}
 
{<section id="adzi100.input" >}
#+ 資料輸入
PRIVATE FUNCTION adzi100_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define
   
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003,g_dzdy_m.dzdy004,g_dzdy_m.dzdy005,g_dzdy_m.dzdyownid, 
       g_dzdy_m.dzdyownid_desc,g_dzdy_m.dzdyowndp,g_dzdy_m.dzdyowndp_desc,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtid_desc, 
       g_dzdy_m.dzdycrtdp,g_dzdy_m.dzdycrtdp_desc,g_dzdy_m.dzdycrtdt,g_dzdy_m.dzdymodid,g_dzdy_m.dzdymodid_desc, 
       g_dzdy_m.dzdymoddt
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT dzdz002,dzdz004,dzdz005,dzdz006,dzdz009,dzdz007,dzdz008 FROM dzdz_t WHERE dzdz001=?  
       AND dzdz002=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adzi100_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adzi100_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL adzi100_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003,g_dzdy_m.dzdy004,g_dzdy_m.dzdy005
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adzi100.input.head" >}
      #單頭段
      INPUT BY NAME g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003,g_dzdy_m.dzdy004,g_dzdy_m.dzdy005 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adzi100_cl USING g_dzdy_m.dzdy001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adzi100_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE adzi100_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前
            
            #end add-point
 
                  #此段落由子樣板a01產生
         BEFORE FIELD dzdy001
            #add-point:BEFORE FIELD dzdy001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy001
            
            #add-point:AFTER FIELD dzdy001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_dzdy_m.dzdy001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dzdy_m.dzdy001 != g_dzdy001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdy_t WHERE "||"dzdy001 = '"||g_dzdy_m.dzdy001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdy001
            #add-point:ON CHANGE dzdy001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdy002
            #add-point:BEFORE FIELD dzdy002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy002
            
            #add-point:AFTER FIELD dzdy002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdy002
            #add-point:ON CHANGE dzdy002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdy003
            #add-point:BEFORE FIELD dzdy003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy003
            
            #add-point:AFTER FIELD dzdy003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdy003
            #add-point:ON CHANGE dzdy003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdy004
            #add-point:BEFORE FIELD dzdy004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy004
            
            #add-point:AFTER FIELD dzdy004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdy004
            #add-point:ON CHANGE dzdy004
            
            #END add-point

        #此段落由子樣板a01產生
         BEFORE FIELD dzdy005
            #add-point:BEFORE FIELD dzdy005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdy005
            
            #add-point:AFTER FIELD dzdy005
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdy005
            #add-point:ON CHANGE dzdy005
            
            #END add-point    
 
 #欄位檢查
                  #Ctrlp:input.c.dzdy001
#         ON ACTION controlp INFIELD dzdy001
            #add-point:ON ACTION controlp INFIELD dzdy001
            
            #END add-point
 
         #Ctrlp:input.c.dzdy002
#         ON ACTION controlp INFIELD dzdy002
            #add-point:ON ACTION controlp INFIELD dzdy002
            
            #END add-point
 
         #Ctrlp:input.c.dzdy003
#         ON ACTION controlp INFIELD dzdy003
            #add-point:ON ACTION controlp INFIELD dzdy003
            
            #END add-point
 
         #Ctrlp:input.c.dzdy004
#         ON ACTION controlp INFIELD dzdy004
            #add-point:ON ACTION controlp INFIELD dzdy004
            
            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_dzdy_m.dzdy001
                        
            #add-point:單頭INPUT後

            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
               
               #end add-point
               
               INSERT INTO dzdy_t (dzdy001,dzdy002,dzdy003,dzdy004,dzdy005,dzdyownid,dzdyowndp,dzdycrtid,dzdycrtdp, 
                   dzdycrtdt)
               VALUES (g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003,g_dzdy_m.dzdy004,g_dzdy_m.dzdy005,g_dzdy_m.dzdyownid, 
                   g_dzdy_m.dzdyowndp,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtdp,g_dzdy_m.dzdycrtdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_dzdy_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL adzi100_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adzi100_b_fill()
               END IF
               
               #add-point:單頭新增後
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
               
               #end add-point
               
               UPDATE dzdy_t SET (dzdy001,dzdy002,dzdy003,dzdy004,dzdy005,dzdyownid,dzdyowndp,dzdycrtid,dzdycrtdp, 
                   dzdycrtdt) = (g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003,g_dzdy_m.dzdy004,g_dzdy_m.dzdy005, 
                   g_dzdy_m.dzdyownid,g_dzdy_m.dzdyowndp,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtdp,g_dzdy_m.dzdycrtdt) 
 
                WHERE  dzdy001 = g_dzdy001_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dzdy_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中
               
               #end add-point
               
               
               
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_dzdy_m_t)
               LET g_log2 = util.JSON.stringify(g_dzdy_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後
               
               #end add-point
            END IF
            
            LET g_dzdy001_t = g_dzdy_m.dzdy001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adzi100.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzdz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = FALSE,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dzdz_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adzi100_b_fill()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_rec_b = g_dzdz_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN adzi100_cl USING g_dzdy_m.dzdy001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adzi100_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE adzi100_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_dzdz_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_dzdz_d[l_ac].dzdz002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dzdz_d_t.* = g_dzdz_d[l_ac].*  #BACKUP
               LET g_dzdz_d_o.* = g_dzdz_d[l_ac].*  #BACKUP
               CALL adzi100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL adzi100_set_no_entry_b(l_cmd)
               IF NOT adzi100_lock_b("dzdz_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi100_bcl INTO g_dzdz_d[l_ac].dzdz002,g_dzdz_d[l_ac].dzdz004,g_dzdz_d[l_ac].dzdz005, 
                      g_dzdz_d[l_ac].dzdz006,g_dzdz_d[l_ac].dzdz009,g_dzdz_d[l_ac].dzdz007,g_dzdz_d[l_ac].dzdz008
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dzdz_d_t.dzdz002 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL adzi100_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzdz_d[l_ac].* TO NULL 
            INITIALIZE g_dzdz_d_t.* TO NULL 
            INITIALIZE g_dzdz_d_o.* TO NULL 
            #公用欄位給值(單身)
            LET g_chk_ver =  FALSE 
            CALL adzi100_get_ver_sn()
            
            #自定義預設值
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_dzdz_d_t.* = g_dzdz_d[l_ac].*     #新輸入資料
            LET g_dzdz_d_o.* = g_dzdz_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzi100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL adzi100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dzdz_d[li_reproduce_target].* = g_dzdz_d[li_reproduce].*
 
               LET g_dzdz_d[li_reproduce_target].dzdz002 = NULL
 
            END IF
            
            #add-point:modify段before insert
            
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
            #md5計算前檢核及計算md5
            IF NOT g_chk_ver THEN 
               IF NOT adzi100_chk_dzdz004() THEN 
                  CANCEL INSERT
               END IF 
               LET g_chk_ver =  FALSE   
            END IF   
    
            #add-point:單身新增
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dzdz_t 
             WHERE  dzdz001 = g_dzdy_m.dzdy001
 
               AND dzdz002 = g_dzdz_d[l_ac].dzdz002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdy_m.dzdy001
               LET gs_keys[2] = g_dzdz_d[g_detail_idx].dzdz002
               CALL adzi100_insert_b('dzdz_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_dzdz_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dzdz_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adzi100_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
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
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
               
               #end add-point 
               
               DELETE FROM dzdz_t
                WHERE  dzdz001 = g_dzdy_m.dzdy001 AND
 
                      dzdz002 = g_dzdz_d_t.dzdz002
 
                  
               #add-point:單身刪除中
               
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dzdz_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adzi100_bcl
               LET l_count = g_dzdz_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdy_m.dzdy001
               LET gs_keys[2] = g_dzdz_d[g_detail_idx].dzdz002
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2
               
               #end add-point
                              CALL adzi100_delete_b('dzdz_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_dzdz_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #此段落由子樣板a01產生
         BEFORE FIELD dzdz002
            #add-point:BEFORE FIELD dzdz002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz002
            
            #add-point:AFTER FIELD dzdz002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_dzdy_m.dzdy001 IS NOT NULL AND g_dzdz_d[g_detail_idx].dzdz002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dzdy_m.dzdy001 != g_dzdy001_t OR g_dzdz_d[g_detail_idx].dzdz002 != g_dzdz_d_t.dzdz002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdz_t WHERE "||"dzdz001 = '"||g_dzdy_m.dzdy001 ||"' AND "|| "dzdz002 = '"||g_dzdz_d[g_detail_idx].dzdz002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdz002
            #add-point:ON CHANGE dzdz002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz004
            #add-point:BEFORE FIELD dzdz004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz004
            
            #add-point:AFTER FIELD dzdz004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdz004
            #add-point:ON CHANGE dzdz004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz005
            #add-point:BEFORE FIELD dzdz005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz005
            
            #add-point:AFTER FIELD dzdz005
            IF g_dzdz_d[g_detail_idx].dzdz005 IS NOT NULL THEN 
               IF l_cmd = 'a' THEN 
                  IF NOT adzi100_chk_dzdz004() THEN
                     LET g_chk_ver =  TRUE 
                     NEXT FIELD dzdz005
                  END IF 
               END IF
            END IF 
             
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdz005
            #add-point:ON CHANGE dzdz005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz006
            #add-point:BEFORE FIELD dzdz006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz006
            
            #add-point:AFTER FIELD dzdz006
            IF g_dzdz_d[g_detail_idx].dzdz006 IS NOT NULL THEN 
               IF l_cmd = 'a' THEN 
                  IF NOT adzi100_chk_dzdz004() THEN
                     LET g_chk_ver =  TRUE 
                     NEXT FIELD dzdz006
                  END IF 
               END IF
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdz006
            #add-point:ON CHANGE dzdz006
            
            #END add-point
          #此段落由子樣板a01產生
         BEFORE FIELD dzdz009
            #add-point:BEFORE FIELD dzdz009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz009
            
            #add-point:AFTER FIELD dzdz009
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdz009
            #add-point:ON CHANGE dzdz009
            
            #END add-point   
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz007
            #add-point:BEFORE FIELD dzdz007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz007
            
            #add-point:AFTER FIELD dzdz007
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdz007
            #add-point:ON CHANGE dzdz007
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdz008
            #add-point:BEFORE FIELD dzdz008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdz008
            
            #add-point:AFTER FIELD dzdz008
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdz008
            #add-point:ON CHANGE dzdz008
            
            #END add-point
 
 
                  #Ctrlp:input.c.page1.dzdz002
#         ON ACTION controlp INFIELD dzdz002
            #add-point:ON ACTION controlp INFIELD dzdz002
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdz004
#         ON ACTION controlp INFIELD dzdz004
            #add-point:ON ACTION controlp INFIELD dzdz004
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdz005
#         ON ACTION controlp INFIELD dzdz005
            #add-point:ON ACTION controlp INFIELD dzdz005
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdz006
#         ON ACTION controlp INFIELD dzdz006
            #add-point:ON ACTION controlp INFIELD dzdz006
            
            #END add-point
         #Ctrlp:input.c.page1.dzdz009
         ON ACTION controlp INFIELD dzdz009
            #add-point:ON ACTION controlp INFIELD dzdz009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_dzdu001()                                #呼叫開窗
            LET g_dzdz_d[g_detail_idx].dzdz009  = g_qryparam.return1              
            #DISPLAY g_dzdz_d[g_detail_idx].dzdz009 TO dzdz009              #
            NEXT FIELD dzdz009                          #返回原欄位
            #END add-point   
 
         #Ctrlp:input.c.page1.dzdz007
#         ON ACTION controlp INFIELD dzdz007
            #add-point:ON ACTION controlp INFIELD dzdz007
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdz008
#         ON ACTION controlp INFIELD dzdz008
            #add-point:ON ACTION controlp INFIELD dzdz008
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_dzdz_d[l_ac].* = g_dzdz_d_t.*
               CLOSE adzi100_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_dzdz_d[l_ac].dzdz002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_dzdz_d[l_ac].* = g_dzdz_d_t.*
            ELSE
            
               #add-point:單身修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE dzdz_t SET (dzdz001,dzdz002,dzdz004,dzdz005,dzdz006,dzdz009,dzdz007,dzdz008) = (g_dzdy_m.dzdy001, 
                   g_dzdz_d[l_ac].dzdz002,g_dzdz_d[l_ac].dzdz004,g_dzdz_d[l_ac].dzdz005,g_dzdz_d[l_ac].dzdz006,g_dzdz_d[l_ac].dzdz009, 
                   g_dzdz_d[l_ac].dzdz007,g_dzdz_d[l_ac].dzdz008)
                WHERE  dzdz001 = g_dzdy_m.dzdy001 
 
                  AND dzdz002 = g_dzdz_d_t.dzdz002 #項次   
 
                  
               #add-point:單身修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzdz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_dzdz_d[l_ac].* = g_dzdz_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzdz_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_dzdz_d[l_ac].* = g_dzdz_d_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdy_m.dzdy001
               LET gs_keys_bak[1] = g_dzdy001_t
               LET gs_keys[2] = g_dzdz_d[g_detail_idx].dzdz002
               LET gs_keys_bak[2] = g_dzdz_d_t.dzdz002
               CALL adzi100_update_b('dzdz_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_dzdy_m),util.JSON.stringify(g_dzdz_d_t)
               LET g_log2 = util.JSON.stringify(g_dzdy_m),util.JSON.stringify(g_dzdz_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
            
            #end add-point
            CALL adzi100_unlock_b("dzdz_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_dzdz_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_dzdz_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="adzi100.input.other" >}
      
      #add-point:自定義input
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD dzdy001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dzdz002
 
               #add-point:input段modify_detail 
               
               #end add-point  
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
         #add-point:input段accept 
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
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
    
   #add-point:input段after input 
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzi100_show()
   DEFINE l_ac_t    LIKE type_t.num5
   #add-point:show段define
   DEFINE ls_file    STRING 
   DEFINE ls_temp    STRING 
   DEFINE pc_dzdz004 LIKE dzdz_t.dzdz004
   #end add-point  
 
   #add-point:show段之前
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adzi100_b_fill() #單身填充
      CALL adzi100_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
 
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL adzi100_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
   
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003,g_dzdy_m.dzdy004,g_dzdy_m.dzdy005,g_dzdy_m.dzdyownid, 
       g_dzdy_m.dzdyownid_desc,g_dzdy_m.dzdyowndp,g_dzdy_m.dzdyowndp_desc,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtid_desc, 
       g_dzdy_m.dzdycrtdp,g_dzdy_m.dzdycrtdp_desc,g_dzdy_m.dzdycrtdt,g_dzdy_m.dzdymodid,g_dzdy_m.dzdymodid_desc, 
       g_dzdy_m.dzdymoddt
   
   #顯示狀態(stus)圖片

   #定義檔案讀取路徑
   CALL adzi100_get_template(g_dzdy_m.dzdy001,g_dzdy_m.dzdy004) RETURNING ls_file 

      IF os.Path.exists(ls_file) THEN 
         
         #計算 MD5 註:有些樣板會花 1 秒
         CALL sadzi100_counting_md5(ls_file) RETURNING ls_temp
        
         SELECT dzdz004 INTO pc_dzdz004 FROM dzdz_t
          WHERE dzdz002 = (SELECT MAX(dzdz002) FROM dzdz_t 
                            WHERE dzdz001 = g_dzdy_m.dzdy001)
            AND dzdz001 = g_dzdy_m.dzdy001 
         
         IF ls_temp = pc_dzdz004 THEN 
            CALL gfrm_curr.setElementImage("state", "16/gl.png") #綠燈
			LET g_mdl_chk = TRUE
         ELSE 
            CALL gfrm_curr.setElementImage("state", "16/rl.png") #紅燈
			LET g_mdl_chk = FALSE
         END IF 
      END IF
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dzdz_d.getLength()
      #add-point:show段單身reference
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adzi100_detail_show()
   
   #add-point:show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adzi100_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adzi100_reproduce()
   DEFINE l_newno     LIKE dzdy_t.dzdy001 
   DEFINE l_oldno     LIKE dzdy_t.dzdy001 
 
   DEFINE l_master    RECORD LIKE dzdy_t.*
   DEFINE l_detail    RECORD LIKE dzdz_t.*
 
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_dzdy_m.dzdy001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_dzdy001_t = g_dzdy_m.dzdy001
 
    
   LET g_dzdy_m.dzdy001 = ""
 
    
   CALL adzi100_set_entry('a')
   CALL adzi100_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_dzdy_m.dzdyownid = g_user
      LET g_dzdy_m.dzdyowndp = g_dept
      LET g_dzdy_m.dzdycrtid = g_user
      LET g_dzdy_m.dzdycrtdp = g_dept 
      LET g_dzdy_m.dzdycrtdt = cl_get_current()
      LET g_dzdy_m.dzdymodid = ""
      LET g_dzdy_m.dzdymoddt = ""
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   CALL adzi100_input("r")
   
   
   
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_dzdy_m.* TO NULL
      INITIALIZE g_dzdz_d TO NULL
 
      #add-point:複製取消後
      
      #end add-point
      CALL adzi100_show()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adzi100_set_act_visible()   
   CALL adzi100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_dzdy001_t = g_dzdy_m.dzdy001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzdy001 = '", g_dzdy_m.dzdy001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adzi100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
   
   CALL adzi100_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adzi100_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE dzdz_t.*
 
 
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adzi100_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE adzi100_detail AS ",
                "SELECT * FROM dzdz_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO adzi100_detail SELECT * FROM dzdz_t 
                                         WHERE  dzdz001 = g_dzdy001_t
 
   
   #將key修正為調整後   
   UPDATE adzi100_detail 
      #更新key欄位
      SET dzdz001 = g_dzdy_m.dzdy001
 
      #更新共用欄位
      
 
   #add-point:單身修改前
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO dzdz_t SELECT * FROM adzi100_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE adzi100_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_dzdy001_t = g_dzdy_m.dzdy001
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adzi100_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point     
   
   IF g_dzdy_m.dzdy001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
 
   CALL adzi100_show()
   
   CALL s_transaction_begin()
 
   OPEN adzi100_cl USING g_dzdy_m.dzdy001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adzi100_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE adzi100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adzi100_master_referesh USING g_dzdy_m.dzdy001 INTO g_dzdy_m.dzdy001,g_dzdy_m.dzdy002,g_dzdy_m.dzdy003, 
       g_dzdy_m.dzdy004,g_dzdy_m.dzdy005,g_dzdy_m.dzdyownid,g_dzdy_m.dzdyowndp,g_dzdy_m.dzdycrtid,g_dzdy_m.dzdycrtdp, 
       g_dzdy_m.dzdycrtdt,g_dzdy_m.dzdymodid,g_dzdy_m.dzdymoddt,g_dzdy_m.dzdyownid_desc,g_dzdy_m.dzdyowndp_desc, 
       g_dzdy_m.dzdycrtid_desc,g_dzdy_m.dzdycrtdp_desc,g_dzdy_m.dzdymodid_desc
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_dzdy_m.dzdy001 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前
      
      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL adzi100_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_dzdy001_t = g_dzdy_m.dzdy001
 
 
      DELETE FROM dzdy_t
       WHERE  dzdy001 = g_dzdy_m.dzdy001
 
       
      #add-point:單頭刪除中
      
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_dzdy_m.dzdy001 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後
      
      #end add-point
  
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM dzdz_t
       WHERE  dzdz001 = g_dzdy_m.dzdy001
 
 
      #add-point:單身刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dzdz_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
      
      #end add-point
      
            
                                                               
 
 
 
                                                               
      CLEAR FORM
      CALL g_dzdz_d.clear() 
      CALL gfrm_curr.setElementImage("state", "")
     
      CALL adzi100_ui_browser_refresh()  
      #CALL adzi100_ui_headershow()  
      #CALL adzi100_ui_detailshow()
      
      IF g_browser_cnt > 0 THEN 
         #CALL adzi100_browser_fill("")
         CALL adzi100_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
 
      #add-point:多語言刪除
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除
      
      #end add-point
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE adzi100_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_dzdy_m.dzdy001,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="adzi100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adzi100_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   
   #end add-point     
 
   CALL g_dzdz_d.clear()    #g_dzdz_d 單頭及單身 
 
 
   #add-point:b_fill段sql_before
   
   #end add-point
   
   #判斷是否填充
   IF adzi100_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE dzdz002,dzdz004,dzdz005,dzdz006,dzdz009,dzdz007,dzdz008  FROM dzdz_t",   
                  " INNER JOIN dzdy_t ON dzdy001 = dzdz001 ",
 
                  #"",
                  
                  "",
                  
                  " WHERE dzdz001=?"
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY dzdz_t.dzdz002"
      
      #add-point:單身填充控制
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE adzi100_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR adzi100_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_dzdy_m.dzdy001
                                               
      FOREACH b_fill_cs INTO g_dzdz_d[l_ac].dzdz002,g_dzdz_d[l_ac].dzdz004,g_dzdz_d[l_ac].dzdz005,g_dzdz_d[l_ac].dzdz006, g_dzdz_d[l_ac].dzdz009,
          g_dzdz_d[l_ac].dzdz007,g_dzdz_d[l_ac].dzdz008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         
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
      LET g_error_show = 0
   
   END IF
   
 
   
   #add-point:browser_fill段其他table處理
   
   #end add-point
   
   CALL g_dzdz_d.deleteElement(g_dzdz_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adzi100_pb
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adzi100_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num5
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM dzdz_t
       WHERE 
         dzdz001 = ps_keys_bak[1] AND dzdz002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_dzdz_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後
      
      #end add-point   
   END IF
   
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adzi100_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num5
   #add-point:insert_b段define
   #DEFINE ls_dzdz010  LIKE dzdz_t.dzdz010
   DEFINE ls_dzdz010  INTEGER
   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      LET ls_dzdz010 = adzi100_get_dzdz010()
      #end add-point 
      INSERT INTO dzdz_t
                  (
                   dzdz001,
                   dzdz002
                   ,dzdz004,dzdz005,dzdz006,dzdz009,dzdz007,dzdz008,dzdz003,dzdz010) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_dzdz_d[g_detail_idx].dzdz004,g_dzdz_d[g_detail_idx].dzdz005,g_dzdz_d[g_detail_idx].dzdz006,g_dzdz_d[g_detail_idx].dzdz009, 
                       g_dzdz_d[g_detail_idx].dzdz007,g_dzdz_d[g_detail_idx].dzdz008,g_dzdz_d[g_detail_idx].dzdz003,ls_dzdz010)
      #add-point:insert_b段資料新增中
      
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dzdz_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_dzdz_d.insertElement(li_idx) 
      END IF 
      FREE g_dzdz_d[g_detail_idx].dzdz003
      #add-point:insert_b段資料新增後
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adzi100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
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
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "dzdz_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE dzdz_t 
         SET (dzdz001,
              dzdz002
              ,dzdz004,dzdz005,dzdz006,dzdz009,dzdz007,dzdz008) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_dzdz_d[g_detail_idx].dzdz004,g_dzdz_d[g_detail_idx].dzdz005,g_dzdz_d[g_detail_idx].dzdz006,g_dzdz_d[g_detail_idx].dzdz009, 
                  g_dzdz_d[g_detail_idx].dzdz007,g_dzdz_d[g_detail_idx].dzdz008) 
         WHERE  dzdz001 = ps_keys_bak[1] AND dzdz002 = ps_keys_bak[2]
      #add-point:update_b段修改中
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dzdz_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dzdz_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
   
 
   
 
   
   #add-point:update_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adzi100_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL adzi100_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "dzdz_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adzi100_bcl USING 
                                       g_dzdy_m.dzdy001,g_dzdz_d[g_detail_idx].dzdz002     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adzi100_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adzi100_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE adzi100_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi100_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("dzdy001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi100_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("dzdy001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzi100_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adzi100_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adzi100_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point   
   #add-point:set_act_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adzi100_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point   
   #add-point:set_act_no_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adzi100_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point   
   #add-point:set_act_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adzi100_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point   
   #add-point:set_act_no_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adzi100_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " dzdy001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
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
 
{<section id="adzi100.state_change" >}
   
 
{</section>}
 
{<section id="adzi100.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adzi100_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_dzdz_d.getLength() THEN
         LET g_detail_idx = g_dzdz_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dzdz_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dzdz_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adzi100_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL adzi100_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="adzi100.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adzi100_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
      #end add-point
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
 
 
   
   #add-point:fill_chk段after_chk
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="adzi100.signature" >}
   
 
{</section>}
 
{<section id="adzi100.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION adzi100_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_dzdy_m.dzdy001
   LET g_pk_array[1].column = 'dzdy001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
#+ 版本序號
PRIVATE FUNCTION adzi100_get_ver_sn()
   DEFINE li_no LIKE type_t.num5
   
   #SELECT NVL(MAX(dzdz002),0) + 1 INTO li_no #15/06/01 改用 genero NVL()
   SELECT MAX(dzdz002) +1 INTO li_no 
    FROM dzdz_t
    WHERE dzdz001 = g_dzdy_m.dzdy001

   LET g_dzdz_d[l_ac].dzdz002 = NVL(li_no,1) 
END FUNCTION 

#+ md5計算前檢核及計算md5
PRIVATE FUNCTION adzi100_chk_dzdz004()
   DEFINE lc_dzdy001  LIKE dzdy_t.dzdy001   #樣板編號
   DEFINE lc_dzdy004  LIKE dzdy_t.dzdy004   #存放路徑
   DEFINE lc_dzdz004  LIKE dzdz_t.dzdz004   #MD5
   DEFINE ls_file     STRING
   DEFINE ls_file_old STRING
   DEFINE ls_cmd      STRING
   DEFINE ls_temp     STRING
   DEFINE lch_channel base.Channel 
   DEFINE l_ch        base.Channel
   DEFINE l_buf       STRING
   DEFINE li_ver      LIKE type_t.num5
   DEFINE ls_tmp      STRING
   DEFINE li_index    LIKE type_t.num5
   DEFINE li_chk      LIKE type_t.num5


   LOCATE g_dzdz_d[l_ac].dzdz003 IN FILE

   #定義檔案讀取路徑
   CALL adzi100_get_template(g_dzdy_m.dzdy001,g_dzdy_m.dzdy004) RETURNING ls_file 

   #檢查檔案是否在正確的路徑上
   IF NOT os.Path.exists(ls_file) THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ls_file 
      LET g_errparam.code   = "adz-00456"  #樣板不存在
      LET g_errparam.popup  = TRUE  
      CALL cl_err() 
      RETURN FALSE
   END IF 
   #read
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   CALL l_ch.openFile(ls_file,"r")

   WHILE TRUE
      CALL l_ch.readLine() RETURNING l_buf  #讀一行資料
      IF l_ch.isEof() THEN EXIT WHILE END IF

      LET ls_tmp = l_buf
      LET ls_tmp = ls_tmp.trim()
      LET ls_tmp = DOWNSHIFT(ls_tmp)
      LET ls_tmp = ls_tmp.trim()
      LET li_index = ls_tmp.getIndexOf("(version:",1)
      IF li_index > 0 THEN 
         LET li_ver = ls_tmp.subString(li_index + 9,ls_tmp.getIndexOf(")",li_index) - 1)
         EXIT WHILE  
      END IF 
      LET li_index = 0

   END WHILE    
   CALL l_ch.close()
   #比對樣板版本
   IF li_ver <> g_dzdz_d[l_ac].dzdz002 THEN #樣板版本要等於要寫入DB的版本序號
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "adz-00455"  #樣板版本錯誤 
      LET g_errparam.popup  = TRUE  
      CALL cl_err() 
      RETURN FALSE
   END IF 

   #第一版 不比對
   IF li_ver - 1 <> 0 THEN 

      #解開前一版本
      CALL sadzi100_extract(g_dzdy_m.dzdy001,li_ver-1,"2") 
      #$TEMPDIR/code_i01.ver_NN
      LET ls_file_old = g_dzdy_m.dzdy001,".ver_",(li_ver-1) USING "<<<<" 
      LET ls_file_old = os.Path.join(FGL_GETENV("TEMPDIR"),ls_file_old)

      #檢查檔案是否在正確的路徑上
      IF NOT os.Path.exists(ls_file_old) THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ls_file_old 
         LET g_errparam.code   = "adz-00456"  #樣板不存在
         LET g_errparam.popup  = TRUE  
         CALL cl_err() 
         RETURN FALSE
      END IF
   
      #確認新版及前一版是否有差異 
      CALL sadzi100_load_diff(ls_file,ls_file_old)RETURNING g_diff_d

      IF g_diff_d.getLength() < 2 THEN 
         LET li_chk = TRUE 
         #假如有差異 看看是不是差異性是否在 version: 
         IF g_diff_d.getLength() = 1 THEN 
            LET ls_temp = DOWNSHIFT(g_diff_d[g_diff_d.getLength()].left_col)
            LET ls_tmp = DOWNSHIFT(g_diff_d[g_diff_d.getLength()].right_col)

            #比對 version 左邊差異VS右邊差異
            IF ls_temp.getIndexOf("version:",1) THEN 
               LET li_index = ls_tmp.getIndexOf("(version:",1)
               LET li_index = ls_temp.getIndexOf(")",li_index+1) 
               LET ls_temp = ls_temp.subString(li_index+1,ls_temp.getLength())
               LET ls_temp = ls_temp.trim() 
               
               LET li_index = ls_tmp.getIndexOf("(version:",li_index)
               LET li_index = ls_tmp.getIndexOf(")",li_index+1)
               LET ls_tmp = ls_tmp.subString(li_index+1,ls_tmp.getLength())
               LET ls_tmp = ls_tmp.trim()

               #左邊差異 > 右邊差異
               IF ls_temp.getLength() > ls_tmp.getLength() THEN 
                  #表示有差異
                  LET li_chk = FALSE 
               END IF 
            END IF 
         END IF

         IF li_chk THEN 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "adz-00460"  #最新樣板跟前一版內容沒差異
            LET g_errparam.popup  = TRUE  
            CALL cl_err() 
            RETURN FALSE            
         END IF 
      END IF 

   END IF
   #讀取檔案
   CALL  g_dzdz_d[l_ac].dzdz003.readFile(ls_file)
   display 'info: read file:',ls_file,' length:',g_dzdz_d[l_ac].dzdz003.getLength()
   #計算 MD5
   CALL sadzi100_counting_md5(ls_file) RETURNING ls_temp
   LET g_dzdz_d[l_ac].dzdz004 = ls_temp #ls_temp.subString(1,32)

   CALL lch_channel.close()

   LET g_dzdz_d[l_ac].dzdz007 = cl_get_current()
   LET g_dzdz_d[l_ac].dzdz008 = g_account 
   RETURN TRUE 
END FUNCTION 

#+檢核樣板
PRIVATE FUNCTION adzi100_get_template(pc_dzdy001,pc_dzdy004)
   DEFINE pc_dzdy001  LIKE dzdy_t.dzdy001   #樣板編號
   DEFINE pc_dzdy004  LIKE dzdy_t.dzdy001   #樣板編號
   DEFINE ls_file     STRING
   DEFINE ls_cmd      STRING
   DEFINE ls_temp     STRING

   LET ls_temp = pc_dzdy004 CLIPPED
   #定義檔案讀取路徑
   IF ls_temp.getIndexOf("com",1) THEN 
      #qry樣板、lng樣板
      LET ls_file = pc_dzdy001,".4gl"
   ELSE 
      LET ls_file = pc_dzdy001,".template"
   END IF 
   
   #LET ls_file = pc_dzdy001,".template"
   IF pc_dzdy004[1,1] = "$" THEN
      #LET ls_temp = pc_dzdy004 
      LET ls_cmd = ls_temp.subString(2,ls_temp.getIndexOf("/",1)-1)
      LET ls_file = os.Path.join(os.Path.join(FGL_GETENV(ls_cmd),ls_temp.subString(ls_temp.getIndexOf("/",1)+1,
                                                                 ls_temp.getLength())),ls_file)
   ELSE
      LET ls_file = os.Path.join(pc_dzdy004, ls_file)
   END IF
   RETURN ls_file
END FUNCTION 

#+匯出樣板
PRIVATE FUNCTION adzi100_export_template(ps_template,ps_path)
   DEFINE ps_template     LIKE dzdy_t.dzdy001
   DEFINE ps_path         LIKE dzdy_t.dzdy004
   DEFINE ls_path         STRING
   DEFINE ls_msg          STRING
   DEFINE ls_title        STRING
   DEFINE ls_template     STRING
   DEFINE ls_template_bck STRING
   DEFINE ls_dzdz002      LIKE dzdz_t.dzdz002
   DEFINE ls_env          STRING
    
   #先確認有挑選樣板
   IF cl_null(ps_template) THEN
      ERROR '請先挑選樣板!'
      RETURN
   END IF
   
   #檢查是否有需要匯出
   IF g_mdl_chk THEN
      ERROR '樣板與資料庫紀錄一致，不進行匯出!'
      RETURN
   END IF
    
   #先詢問是否確認匯出
   LET ls_msg = cl_getmsg("adz-00717",g_lang)
   LET ls_title = cl_getmsg("adz-00718",g_lang)

   #執行開窗詢問
   IF NOT cl_ask_type1(ls_msg,ls_title) THEN
      #取消匯出
      RETURN
   END IF
   
   #複製備份檔
   LET ls_template_bck = ps_template,'.bck'
   #IF ps_template[1,3] = "qry" OR ps_template[1,3] = "lng" THEN 
   IF ps_template[1,3] = "qry" OR ps_template[1,3] = "lng" OR ps_template[1,4] = "ntab" THEN  #17/01/03
      LET ls_template = ps_template,".4gl"
   ELSE 
      LET ls_template = ps_template,".template"
   END IF 
      
   LET ls_path = ps_path
   #取得路徑
   LET ls_env = ls_path.subString(2,ls_path.getIndexOf("/",1)-1)
   
   #組合原檔路徑&名稱
   LET ls_template = os.Path.join(os.Path.join(FGL_GETENV(ls_env),
                     ls_path.subString(ls_path.getIndexOf("/",1)+1,
                     ls_path.getLength())),ls_template)
   
   #組合備份檔路徑&名稱
   LET ls_template_bck = os.Path.join(os.Path.join(FGL_GETENV(ls_env),
                         ls_path.subString(ls_path.getIndexOf("/",1)+1,
                         ls_path.getLength())),ls_template_bck)
   
   #複製原檔為備份檔(.bck)
   IF os.Path.copy(ls_template,ls_template_bck) THEN
      DISPLAY "複製原樣板檔案為:",ls_template_bck
   ELSE
      DISPLAY "ERROR:樣板備份失敗,中止匯出樣板!"
      RETURN
   END IF

   #寫入到對應路徑下
   SELECT MAX(dzdz002) INTO ls_dzdz002 FROM dzdz_t 
    WHERE dzdz001 = ps_template
   IF ls_dzdz002 IS NULL OR ls_dzdz002 = 0 THEN
      DISPLAY "ERROR:樣板最大版本為(",ls_dzdz002,"),匯出失敗!"
      RETURN
   END IF
   
   #開始匯出樣板
   CALL sadzi100_extract(ps_template,ls_dzdz002,'1')
   
   #提示完成
   ERROR "匯出完成!"

END FUNCTION

#+抓取產生器版本
PRIVATE FUNCTION adzi100_get_dzdz010()
   DEFINE ls_ver      STRING
   DEFINE ls_cmd      STRING 
   DEFINE ls_read     STRING 
   DEFINE lch_read    base.Channel
   DEFINE ls_code_gen STRING
   DEFINE ls_template STRING
   
   LET lch_read  = base.Channel.create()
   CALL lch_read.setDelimiter("")
   
   #先判定該樣板是由何者處理
   LET ls_template = g_dzdy_m.dzdy001
   CASE
      WHEN ls_template = 'g01' OR ls_template = 'x01'
	     LET ls_code_gen = 'adzp151' 
	  WHEN ls_template.subString(6,6) = 'q'
	     LET ls_code_gen = 'adzp152' 
	  OTHERWISE
	     LET ls_code_gen = 'adzp150'
   END CASE
   
   LET ls_cmd = "grep 'CONSTANT cs_prog_ver' $ERP/adz/4gl/",ls_code_gen,".4gl"

   CALL lch_read.openPipe(ls_cmd, "r")
   LET ls_read = lch_read.readLine()
   LET ls_ver = ls_read.subString(ls_read.getIndexOf('CONSTANT cs_prog_ver = ',1)+23,ls_read.getLength())
   CALL lch_read.close()
   
   RETURN ls_ver
   
END FUNCTION 
