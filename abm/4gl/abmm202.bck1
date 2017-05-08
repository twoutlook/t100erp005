#該程式已解開Section, 不再透過樣板產出!
{<section id="abmm202.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:8,PR版次:8) Build-000386
#+ 
#+ Filename...: abmm202
#+ Description: 集團產品結構插件位置維護作業
#+ Creator....: 02587(2013-09-10 09:47:46)
#+ Modifier...: 02295(2015-06-17 16:23:19) -SD/PR- 01996
 
{</section>}
 
{<section id="abmm202.global" >}
#應用 t01 樣板自動產生(Version:36)
# 140928 修改调用接口，供abmm200调用:增加引号
#160324-00007#1  2016/04/01 By xianghui 据点级资料同步时需要判断据点级是否存在相应的BOM且需要参考研发中心
#160705-00042#8  2016/07/12 By sakura   程式中寫死g_prog部分改寫MATCHES方式
#161216-00029#3  2017/01/22 By xujing   若当前BOM为失效状态，修改、删除、整单操作、明细操作中各项action不可执行
        
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
PRIVATE type type_g_bmba_m        RECORD
       bmba001 LIKE bmba_t.bmba001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   bmaa004 LIKE bmaa_t.bmaa004, 
   bmba002 LIKE bmba_t.bmba002, 
   bmba003 LIKE bmba_t.bmba003, 
   l_imaal003 LIKE type_t.chr500, 
   l_imaal004 LIKE type_t.chr500, 
   bmba011 LIKE bmba_t.bmba011, 
   bmba012 LIKE bmba_t.bmba012, 
   bmba010 LIKE bmba_t.bmba010, 
   bmba004 LIKE bmba_t.bmba004, 
   bmba004_desc LIKE type_t.chr80, 
   bmba007 LIKE bmba_t.bmba007, 
   bmba007_desc LIKE type_t.chr80, 
   bmba008 LIKE bmba_t.bmba008, 
   bmba005 LIKE bmba_t.bmba005
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bmbc_d        RECORD
       bmbc009 LIKE bmbc_t.bmbc009, 
   bmbc010 LIKE bmbc_t.bmbc010, 
   bmbc011 LIKE bmbc_t.bmbc011
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bmba001 LIKE bmba_t.bmba001,
      b_bmba002 LIKE bmba_t.bmba002,
      b_bmba003 LIKE bmba_t.bmba003,
      b_bmba004 LIKE bmba_t.bmba004,
      b_bmba005 LIKE bmba_t.bmba005,
      b_bmba007 LIKE bmba_t.bmba007,
      b_bmba008 LIKE bmba_t.bmba008
       END RECORD
       
#模組變數(Module Variables)
DEFINE g_bmba_m          type_g_bmba_m
DEFINE g_bmba_m_t        type_g_bmba_m
DEFINE g_bmba_m_o        type_g_bmba_m
DEFINE g_bmba_m_mask_o   type_g_bmba_m #轉換遮罩前資料
DEFINE g_bmba_m_mask_n   type_g_bmba_m #轉換遮罩後資料
 
   DEFINE g_bmba001_t LIKE bmba_t.bmba001
DEFINE g_bmba002_t LIKE bmba_t.bmba002
DEFINE g_bmba003_t LIKE bmba_t.bmba003
DEFINE g_bmba004_t LIKE bmba_t.bmba004
DEFINE g_bmba007_t LIKE bmba_t.bmba007
DEFINE g_bmba008_t LIKE bmba_t.bmba008
 
 
DEFINE g_bmbc_d          DYNAMIC ARRAY OF type_g_bmbc_d
DEFINE g_bmbc_d_t        type_g_bmbc_d
DEFINE g_bmbc_d_o        type_g_bmbc_d
DEFINE g_bmbc_d_mask_o   DYNAMIC ARRAY OF type_g_bmbc_d #轉換遮罩前資料
DEFINE g_bmbc_d_mask_n   DYNAMIC ARRAY OF type_g_bmbc_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
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
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數
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
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_bmba005_t LIKE bmba_t.bmba005
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)
     #argv[1] bmba_t.bmbasite 
     #argv[2] bmba_t.bmba001 
     #argv[3] bmba_t.bmba002 
     #argv[4] bmba_t.bmba003 
     #argv[5] bmba_t.bmba004 
     #argv[6] bmba_t.bmba005
     #argv[7] bmba_t.bmba007 
     #argv[8] bmba_t.bmba008  
    
#end add-point
 
{</section>}
 
{<section id="abmm202.main" >}
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
   CALL cl_ap_init("abm","")
 
   #add-point:作業初始化
   #IF g_prog = 'abmm202' THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'abmm202' THEN   #160705-00042#8 160712 by sakura add
      LET g_site = 'ALL'
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
         
   #end add-point
   LET g_forupd_sql = " SELECT bmba001,'','','',bmba002,bmba003,'','',bmba011,bmba012,bmba010,bmba004, 
       '',bmba007,'',bmba008,''", 
                      " FROM bmba_t",
                      " WHERE bmbaent= ? AND bmbasite= ? AND bmba001=? AND bmba002=? AND bmba003=? AND  
                          bmba004=? AND bmba005=? AND bmba007=? AND bmba008=? FOR UPDATE"
   #add-point:SQL_define
         
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmm202_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.bmba001,t0.bmba002,t0.bmba003,t0.bmba011,t0.bmba012,t0.bmba010,t0.bmba004, 
       t0.bmba007,t0.bmba008,t0.bmba005,t1.oocql004 ,t2.oocql004",
               " FROM bmba_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='215' AND t1.oocql002=t0.bmba004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='221' AND t2.oocql002=t0.bmba007 AND t2.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.bmbaent = '" ||g_enterprise|| "' AND t0.bmbasite = ? AND t0.bmba001 = ? AND t0.bmba002 = ? AND t0.bmba003 = ? AND t0.bmba004 = ? AND t0.bmba005 = ? AND t0.bmba007 = ? AND t0.bmba008 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
 
   #end add-point
   PREPARE abmm202_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
                  
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmm202 WITH FORM cl_ap_formpath("abm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abmm202_init()   
 
      #進入選單 Menu (="N")
      CALL abmm202_ui_dialog() 
      
      #add-point:畫面關閉前
                  
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abmm202
      
   END IF 
   
   CLOSE abmm202_cl
   
   
 
   #add-point:作業離開前
         
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="abmm202.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abmm202_init()
   #add-point:init段define
         
   #end add-point    
   #add-point:init段define(客製用)
   
   #end add-point    
 
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
         
   #end add-point
   
   #初始化搜尋條件
   CALL abmm202_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abmm202.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abmm202_ui_dialog()
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
   #add-point:ui_dialog段define
         
   #end add-point
   #add-point:ui_dialog段define(客製用)
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 
         
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bmba_m.* TO NULL
         CALL g_bmbc_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abmm202_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_bmbc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abmm202_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作
                                             
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL abmm202_idx_chk()
               #add-point:page1自定義行為
                                             
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為
                                    
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array
                           
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL abmm202_browser_fill("")
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
               CALL abmm202_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abmm202_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abmm202_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2
            #若執行集團級程式，則不開放切換營運中心的功能
            #IF g_prog = 'abmm202' THEN        #160705-00042#8 160712 by sakura mark
            IF g_prog MATCHES 'abmm202' THEN   #160705-00042#8 160712 by sakura add
               CALL cl_set_act_visible("logistics", FALSE)
            ELSE
               CALL cl_set_act_visible("logistics", TRUE)
            END IF          
            #end add-point
 
 
 
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "bmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmbc_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL abmm202_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "bmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmbc_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL abmm202_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abmm202_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abmm202_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm202_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abmm202_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm202_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abmm202_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm202_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abmm202_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm202_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abmm202_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm202_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bmbc_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
    
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abmm202_modify()
               #add-point:ON ACTION modify
                                             
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abmm202_modify()
               #add-point:ON ACTION modify_detail
                                             
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abmm202_query()
               #add-point:ON ACTION query
                                             
               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
            END IF
 
 
 
         
         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL abmm202_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abmm202_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abmm202_set_pk_array()
            #add-point:ON ACTION followup
            
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
         #add-point:ui_dialog段離開dialog前
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="abmm202.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abmm202_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
         
   #end add-point   
   #add-point:browser_fill段define(客製用)
   
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
      LET l_sub_sql = " SELECT UNIQUE bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 ",
                      " FROM bmba_t ",
                      " ",
                      " LEFT JOIN bmbc_t ON bmbcent = bmbaent AND bmbcsite = bmbasite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008 ", "  ",
                      #add-point:browser_fill段sql(bmbc_t1)
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
                      " WHERE bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND bmbcent = '" ||g_enterprise|| "' AND bmbcsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bmba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 ",
                      " FROM bmba_t ", 
                      "  ",
                      "  ",
                      " WHERE bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("bmba_t")
   END IF
   
   #add-point:browser_fill,cnt wc
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
            IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE bmba001 ",
                                    ",bmba002 ",

                                    ",bmba003 ",

                                    ",bmba004 ",

                                    ",bmba005 ",

                                    ",bmba007 ",

                                    ",bmba008 ",


                        " FROM bmba_t ",
                              " ",
                              " LEFT JOIN bmaa_t ON bmaaent = bmbaent AND bmaasite = bmbasite AND bmaa001 = bmba001 AND bmaa002 = bmba002",
                              " LEFT JOIN bmbc_t ON bmbcent = bmbaent AND bmbcsite = bmbasite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008 ",
                              
                              " ",
                              " ",
                       " WHERE bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND bmbcent = '" ||g_enterprise|| "' AND bmbcsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE bmba001 ",
                                    ",bmba002 ",

                                    ",bmba003 ",

                                    ",bmba004 ",

                                    ",bmba005 ",

                                    ",bmba007 ",

                                    ",bmba008 ",


                        " FROM bmba_t ", 
                        " LEFT JOIN bmaa_t ON bmaaent = bmbaent AND bmaasite = bmbasite AND bmaa001 = bmba001 AND bmaa002 = bmba002",
                              " ",
                              " ",
                        "WHERE bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND ",l_wc CLIPPED
 
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
    
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
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_bmba_m.* TO NULL
      CALL g_bmbc_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bmba001,t0.bmba002,t0.bmba003,t0.bmba004,t0.bmba005,t0.bmba007,t0.bmba008 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   LET g_sql = " SELECT DISTINCT '',t0.bmba001,t0.bmba002,t0.bmba003,t0.bmba004,t0.bmba005,t0.bmba007, 
       t0.bmba008 ",
               " FROM bmba_t t0",
               "  ",
               "  LEFT JOIN bmbc_t ON bmbcent = bmbaent AND bmbcsite = bmbasite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008 ", "  ", 
               #add-point:browser_fill段sql(bmbc_t1)
               
               #end add-point
 
 
               "  ",
               
               " WHERE t0.bmbaent = '" ||g_enterprise|| "' AND t0.bmbasite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bmba_t")
   #add-point:browser_fill,sql wc
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 ",g_order
 
   #add-point:browser_fill,before_prepare
            #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT '',bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008,DENSE_RANK() OVER(ORDER BY bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 ",g_order,") AS RANK ",
                        " FROM bmba_t ",
                              " ",
                              " LEFT JOIN bmaa_t ON bmaaent = bmbaent AND bmaasite = bmbasite AND bmaa001 = bmba001 AND bmaa002 = bmba002",
                              " LEFT JOIN bmbc_t ON bmbcent = bmbaent AND bmbcsite = bmbasite AND bmba001 = bmbc001 AND bmba002 = bmbc002 AND bmba003 = bmbc003 AND bmba004 = bmbc004 AND bmba005 = bmbc005 AND bmba007 = bmbc007 AND bmba008 = bmbc008",

                              " ",
                              " ",
                       " ",
                       " WHERE bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND ",g_wc," AND ",g_wc2
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT '',bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008,DENSE_RANK() OVER(ORDER BY bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 ",g_order,") AS RANK ",
                       " FROM bmba_t ",
                        " LEFT JOIN bmaa_t ON bmaaent = bmbaent AND bmaasite = bmbasite AND bmaa001 = bmba001 AND bmaa002 = bmba002",
                            "  ",
                            "  ",
                       " WHERE bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND ", g_wc
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT '',bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bmba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor
         
   #end add-point
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bmba001,g_browser[g_cnt].b_bmba002, 
       g_browser[g_cnt].b_bmba003,g_browser[g_cnt].b_bmba004,g_browser[g_cnt].b_bmba005,g_browser[g_cnt].b_bmba007, 
       g_browser[g_cnt].b_bmba008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:browser_fill段reference
                  
      #end add-point
  
  
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_bmba001) THEN
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
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前
         
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abmm202_ui_headershow()
   #add-point:ui_headershow段define
         
   #end add-point    
   #add-point:ui_headershow段define(客製用)
   
   #end add-point    
   
   LET g_bmba_m.bmba001 = g_browser[g_current_idx].b_bmba001   
   LET g_bmba_m.bmba002 = g_browser[g_current_idx].b_bmba002   
   LET g_bmba_m.bmba003 = g_browser[g_current_idx].b_bmba003   
   LET g_bmba_m.bmba004 = g_browser[g_current_idx].b_bmba004   
   LET g_bmba_m.bmba005 = g_browser[g_current_idx].b_bmba005   
   LET g_bmba_m.bmba007 = g_browser[g_current_idx].b_bmba007   
   LET g_bmba_m.bmba008 = g_browser[g_current_idx].b_bmba008   
 
   EXECUTE abmm202_master_referesh USING g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004, 
       g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008 INTO g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003, 
       g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008, 
       g_bmba_m.bmba005,g_bmba_m.bmba004_desc,g_bmba_m.bmba007_desc
   CALL abmm202_bmba_t_mask()
   CALL abmm202_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abmm202.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abmm202_ui_detailshow()
   #add-point:ui_detailshow段define
         
   #end add-point    
   #add-point:ui_detailshow段define(客製用)
   
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
 
{<section id="abmm202.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abmm202_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
         
   #end add-point    
   #add-point:ui_browser_refresh段define(客製用)
   
   #end add-point    
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_bmba001 = g_bmba_m.bmba001 
         AND g_browser[l_i].b_bmba002 = g_bmba_m.bmba002 
         AND g_browser[l_i].b_bmba003 = g_bmba_m.bmba003 
         AND g_browser[l_i].b_bmba004 = g_bmba_m.bmba004 
         AND g_browser[l_i].b_bmba005 = g_bmba_m.bmba005 
         AND g_browser[l_i].b_bmba007 = g_bmba_m.bmba007 
         AND g_browser[l_i].b_bmba008 = g_bmba_m.bmba008 
 
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
   
   #add-point:ui_browser_refresh段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abmm202_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define
            DEFINE l_wc1       STRING
   #end add-point    
   #add-point:cs段define(客製用)
   
   #end add-point    
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_bmba_m.* TO NULL
   CALL g_bmbc_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON bmba001,bmaa004,bmba002,bmba003,bmba011,bmba012,bmba010,bmba004,bmba007, 
          bmba008,bmba005
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
                                    
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.bmba001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba001
            #add-point:ON ACTION controlp INFIELD bmba001
                                                #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba001  #顯示到畫面上

            NEXT FIELD bmba001                     #返回原欄位


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba001
            #add-point:BEFORE FIELD bmba001
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba001
            
            #add-point:AFTER FIELD bmba001
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.bmaa004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmaa004
            #add-point:ON ACTION controlp INFIELD bmaa004
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmaa004  #顯示到畫面上

            NEXT FIELD bmaa004                     #返回原欄位


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmaa004
            #add-point:BEFORE FIELD bmaa004
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmaa004
            
            #add-point:AFTER FIELD bmaa004
                                    
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba002
            #add-point:BEFORE FIELD bmba002
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba002
            
            #add-point:AFTER FIELD bmba002
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.bmba002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba002
            #add-point:ON ACTION controlp INFIELD bmba002
                                    
            #END add-point
 
         #Ctrlp:construct.c.bmba003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba003
            #add-point:ON ACTION controlp INFIELD bmba003
                                                #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba003  #顯示到畫面上

            NEXT FIELD bmba003                     #返回原欄位


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba003
            #add-point:BEFORE FIELD bmba003
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba003
            
            #add-point:AFTER FIELD bmba003
                                    
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba011
            #add-point:BEFORE FIELD bmba011
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba011
            
            #add-point:AFTER FIELD bmba011
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.bmba011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba011
            #add-point:ON ACTION controlp INFIELD bmba011
                                    
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba012
            #add-point:BEFORE FIELD bmba012
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba012
            
            #add-point:AFTER FIELD bmba012
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.bmba012
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba012
            #add-point:ON ACTION controlp INFIELD bmba012
                                    
            #END add-point
 
         #Ctrlp:construct.c.bmba010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba010
            #add-point:ON ACTION controlp INFIELD bmba010
                                                #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba010  #顯示到畫面上

            NEXT FIELD bmba010                     #返回原欄位


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba010
            #add-point:BEFORE FIELD bmba010
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba010
            
            #add-point:AFTER FIELD bmba010
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.bmba004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba004
            #add-point:ON ACTION controlp INFIELD bmba004
                                                #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "215" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba004  #顯示到畫面上

            NEXT FIELD bmba004                     #返回原欄位


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba004
            #add-point:BEFORE FIELD bmba004
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba004
            
            #add-point:AFTER FIELD bmba004
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.bmba007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba007
            #add-point:ON ACTION controlp INFIELD bmba007
                                                #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba007  #顯示到畫面上

            NEXT FIELD bmba007                     #返回原欄位


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba007
            #add-point:BEFORE FIELD bmba007
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba007
            
            #add-point:AFTER FIELD bmba007
                                    
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba008
            #add-point:BEFORE FIELD bmba008
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba008
            
            #add-point:AFTER FIELD bmba008
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.bmba008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba008
            #add-point:ON ACTION controlp INFIELD bmba008
                                    
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba005
            #add-point:BEFORE FIELD bmba005
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba005
            
            #add-point:AFTER FIELD bmba005
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
         #Ctrlp:construct.c.bmba005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba005
            #add-point:ON ACTION controlp INFIELD bmba005
                                    
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bmbc009,bmbc010,bmbc011
           FROM s_detail1[1].bmbc009,s_detail1[1].bmbc010,s_detail1[1].bmbc011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc009
            #add-point:BEFORE FIELD bmbc009
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc009
            
            #add-point:AFTER FIELD bmbc009
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmbc009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc009
            #add-point:ON ACTION controlp INFIELD bmbc009
                                    
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc010
            #add-point:BEFORE FIELD bmbc010
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc010
            
            #add-point:AFTER FIELD bmbc010
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmbc010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc010
            #add-point:ON ACTION controlp INFIELD bmbc010
                                    
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc011
            #add-point:BEFORE FIELD bmbc011
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc011
            
            #add-point:AFTER FIELD bmbc011
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmbc011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc011
            #add-point:ON ACTION controlp INFIELD bmbc011
                                    
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
                        CONSTRUCT BY NAME l_wc1 ON bmaa004
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()        
         #一般欄位開窗相關處理    

         ON ACTION controlp INFIELD bmaa004
 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmaa004  #顯示到畫面上

            NEXT FIELD bmaa004                    #返回原欄位
       END CONSTRUCT

      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
                           
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "bmba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bmbc_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
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
 
 
 
   
   #add-point:cs段結束前
   LET g_wc = cl_replace_str(g_wc,'bmba005',"to_char(bmba005,'yy/mm/dd')")
   IF NOT cl_null(l_wc1) THEN 
      LET g_wc = g_wc ," AND ",l_wc1
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abmm202_query()
   DEFINE ls_wc STRING
   #add-point:query段define
         
   #end add-point   
   #add-point:query段define(客製用)
   
   #end add-point   
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_bmbc_d.clear()
 
   
   #add-point:query段other
         
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abmm202_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL abmm202_browser_fill("")
      CALL abmm202_fetch("")
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
   CALL abmm202_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL abmm202_fetch("F") 
      #顯示單身筆數
      CALL abmm202_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abmm202_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
            DEFINE l_bmaastus   LIKE bmaa_t.bmaastus
   #end add-point    
   #add-point:fetch段define(客製用)
   
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
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
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_bmba_m.bmba001 = g_browser[g_current_idx].b_bmba001
   LET g_bmba_m.bmba002 = g_browser[g_current_idx].b_bmba002
   LET g_bmba_m.bmba003 = g_browser[g_current_idx].b_bmba003
   LET g_bmba_m.bmba004 = g_browser[g_current_idx].b_bmba004
   LET g_bmba_m.bmba005 = g_browser[g_current_idx].b_bmba005
   LET g_bmba_m.bmba007 = g_browser[g_current_idx].b_bmba007
   LET g_bmba_m.bmba008 = g_browser[g_current_idx].b_bmba008
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abmm202_master_referesh USING g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004, 
       g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008 INTO g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003, 
       g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008, 
       g_bmba_m.bmba005,g_bmba_m.bmba004_desc,g_bmba_m.bmba007_desc
   
   #遮罩相關處理
   LET g_bmba_m_mask_o.* =  g_bmba_m.*
   CALL abmm202_bmba_t_mask()
   LET g_bmba_m_mask_n.* =  g_bmba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmm202_set_act_visible()   
   CALL abmm202_set_act_no_visible()
   
   #add-point:fetch段action控制
   SELECT bmaastus INTO l_bmaastus FROM bmaa_t 
    WHERE bmaaent = g_enterprise
      AND bmaasite = g_site
      AND bmaa001 = g_bmba_m.bmba001
      AND bmaa002 = g_bmba_m.bmba002
   CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)    #161216-00029#3 add 
   IF g_site != 'ALL' THEN
      CALL cl_set_act_visible("modify",FALSE)
   ELSE
      IF l_bmaastus = 'Y' AND abmm202_act_oocq007() THEN 
         CALL cl_set_act_visible("modify",FALSE)
      ELSE   
         CALL cl_set_act_visible("modify",TRUE)
      END IF
   END IF
   #161216-00029#3 add(s)
   IF l_bmaastus = 'VO' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
   END IF
   #161216-00029#3 add(e)
   #end add-point  
   
   
   
   #add-point:fetch結束前
         
   #end add-point
   
   #保存單頭舊值
   LET g_bmba_m_t.* = g_bmba_m.*
   LET g_bmba_m_o.* = g_bmba_m.*
   
   
   #重新顯示   
   CALL abmm202_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.insert" >}
#+ 資料新增
PRIVATE FUNCTION abmm202_insert()
   #add-point:insert段define
         
   #end add-point    
   #add-point:insert段define(客製用)
   
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bmbc_d.clear()   
 
 
   INITIALIZE g_bmba_m.* LIKE bmba_t.*             #DEFAULT 設定
   
   LET g_bmba001_t = NULL
   LET g_bmba002_t = NULL
   LET g_bmba003_t = NULL
   LET g_bmba004_t = NULL
   LET g_bmba005_t = NULL
   LET g_bmba007_t = NULL
   LET g_bmba008_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值
                  
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bmba_m_t.* = g_bmba_m.*
      LET g_bmba_m_o.* = g_bmba_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL abmm202_input("a")
      
      #add-point:單頭輸入後
                  
      #end add-point
      
      IF INT_FLAG THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bmba_m.* TO NULL
         INITIALIZE g_bmbc_d TO NULL
 
         #add-point:取消新增後
         
         #end add-point 
         CALL abmm202_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bmbc_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmm202_set_act_visible()   
   CALL abmm202_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bmba001_t = g_bmba_m.bmba001
   LET g_bmba002_t = g_bmba_m.bmba002
   LET g_bmba003_t = g_bmba_m.bmba003
   LET g_bmba004_t = g_bmba_m.bmba004
   LET g_bmba005_t = g_bmba_m.bmba005
   LET g_bmba007_t = g_bmba_m.bmba007
   LET g_bmba008_t = g_bmba_m.bmba008
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND",
                      " bmba001 = '", g_bmba_m.bmba001, "' "
                      ," AND bmba002 = '", g_bmba_m.bmba002, "' "
                      ," AND bmba003 = '", g_bmba_m.bmba003, "' "
                      ," AND bmba004 = '", g_bmba_m.bmba004, "' "
                      ," AND bmba005 = '", g_bmba_m.bmba005, "' "
                      ," AND bmba007 = '", g_bmba_m.bmba007, "' "
                      ," AND bmba008 = '", g_bmba_m.bmba008, "' "
 
                      
   #add-point:組合新增資料的條件後
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmm202_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abmm202_cl
   
   CALL abmm202_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abmm202_master_referesh USING g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004, 
       g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008 INTO g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003, 
       g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008, 
       g_bmba_m.bmba005,g_bmba_m.bmba004_desc,g_bmba_m.bmba007_desc
   
   #遮罩相關處理
   LET g_bmba_m_mask_o.* =  g_bmba_m.*
   CALL abmm202_bmba_t_mask()
   LET g_bmba_m_mask_n.* =  g_bmba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bmba_m.bmba001,g_bmba_m.imaal003,g_bmba_m.imaal004,g_bmba_m.bmaa004,g_bmba_m.bmba002, 
       g_bmba_m.bmba003,g_bmba_m.l_imaal003,g_bmba_m.l_imaal004,g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010, 
       g_bmba_m.bmba004,g_bmba_m.bmba004_desc,g_bmba_m.bmba007,g_bmba_m.bmba007_desc,g_bmba_m.bmba008, 
       g_bmba_m.bmba005
   
   #add-point:新增結束後
   
   #end add-point 
   
   #功能已完成,通報訊息中心
   CALL abmm202_msgcentre_notify('')
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.modify" >}
#+ 資料修改
PRIVATE FUNCTION abmm202_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define
   CALL abmm202_input("u")
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET g_bmba_m.* = g_bmba_m_t.*
      CALL abmm202_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF    
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmm202_set_act_visible()   
   CALL abmm202_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND",
                      " bmba001 = '", g_bmba_m.bmba001, "' "
                      ," AND bmba002 = '", g_bmba_m.bmba002, "' "
                      ," AND bmba003 = '", g_bmba_m.bmba003, "' "
                      ," AND bmba004 = '", g_bmba_m.bmba004, "' "
                      ," AND bmba005 = '", g_bmba_m.bmba005, "' "
                      ," AND bmba007 = '", g_bmba_m.bmba007, "' "
                      ," AND bmba008 = '", g_bmba_m.bmba008, "' "
 
   #填到對應位置
   CALL abmm202_browser_fill("")
  
   CALL s_transaction_end('Y','0')
   #功能已完成,通報訊息中心
   CALL abmm202_msgcentre_notify('') 
   RETURN   
   #end add-point    
   #add-point:modify段define(客製用)
   
   #end add-point    
   
   #保存單頭舊值
   LET g_bmba_m_t.* = g_bmba_m.*
   LET g_bmba_m_o.* = g_bmba_m.*
   
   IF g_bmba_m.bmba001 IS NULL
   OR g_bmba_m.bmba002 IS NULL
   OR g_bmba_m.bmba003 IS NULL
   OR g_bmba_m.bmba004 IS NULL
   OR g_bmba_m.bmba005 IS NULL
   OR g_bmba_m.bmba007 IS NULL
   OR g_bmba_m.bmba008 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bmba001_t = g_bmba_m.bmba001
   LET g_bmba002_t = g_bmba_m.bmba002
   LET g_bmba003_t = g_bmba_m.bmba003
   LET g_bmba004_t = g_bmba_m.bmba004
   LET g_bmba005_t = g_bmba_m.bmba005
   LET g_bmba007_t = g_bmba_m.bmba007
   LET g_bmba008_t = g_bmba_m.bmba008
 
   CALL s_transaction_begin()
   
   OPEN abmm202_cl USING g_enterprise, g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmm202_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE abmm202_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmm202_master_referesh USING g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004, 
       g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008 INTO g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003, 
       g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008, 
       g_bmba_m.bmba005,g_bmba_m.bmba004_desc,g_bmba_m.bmba007_desc
   
   #檢查是否允許此動作
   IF NOT abmm202_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bmba_m_mask_o.* =  g_bmba_m.*
   CALL abmm202_bmba_t_mask()
   LET g_bmba_m_mask_n.* =  g_bmba_m.*
   
   
   
   #add-point:modify段show之前
 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL abmm202_show()
   #add-point:modify段show之後
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_bmba001_t = g_bmba_m.bmba001
      LET g_bmba002_t = g_bmba_m.bmba002
      LET g_bmba003_t = g_bmba_m.bmba003
      LET g_bmba004_t = g_bmba_m.bmba004
      LET g_bmba005_t = g_bmba_m.bmba005
      LET g_bmba007_t = g_bmba_m.bmba007
      LET g_bmba008_t = g_bmba_m.bmba008
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      
      #add-point:modify段修改前
                  
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      CALL abmm202_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後
                  
      #end add-point
      
 
    
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_bmba_m.* = g_bmba_m_t.*
         CALL abmm202_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bmba_m.bmba001 != g_bmba001_t 
      OR g_bmba_m.bmba002 != g_bmba002_t 
      OR g_bmba_m.bmba003 != g_bmba003_t 
      OR g_bmba_m.bmba004 != g_bmba004_t 
      OR g_bmba_m.bmba005 != g_bmba005_t 
      OR g_bmba_m.bmba007 != g_bmba007_t 
      OR g_bmba_m.bmba008 != g_bmba008_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
                           
         #end add-point
         
         #更新單身key值
         UPDATE bmbc_t SET bmbc001 = g_bmba_m.bmba001
                                       ,bmbc002 = g_bmba_m.bmba002
                                       ,bmbc003 = g_bmba_m.bmba003
                                       ,bmbc004 = g_bmba_m.bmba004
                                       ,bmbc005 = g_bmba_m.bmba005
                                       ,bmbc007 = g_bmba_m.bmba007
                                       ,bmbc008 = g_bmba_m.bmba008
 
          WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = g_bmba001_t
            AND bmbc002 = g_bmba002_t
            AND bmbc003 = g_bmba003_t
            AND bmbc004 = g_bmba004_t
            AND bmbc005 = g_bmba005_t
            AND bmbc007 = g_bmba007_t
            AND bmbc008 = g_bmba008_t
 
            
         #add-point:單身fk修改中
                           
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmbc_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmbc_t" 
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
   CALL abmm202_set_act_visible()   
   CALL abmm202_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND",
                      " bmba001 = '", g_bmba_m.bmba001, "' "
                      ," AND bmba002 = '", g_bmba_m.bmba002, "' "
                      ," AND bmba003 = '", g_bmba_m.bmba003, "' "
                      ," AND bmba004 = '", g_bmba_m.bmba004, "' "
                      ," AND bmba005 = '", g_bmba_m.bmba005, "' "
                      ," AND bmba007 = '", g_bmba_m.bmba007, "' "
                      ," AND bmba008 = '", g_bmba_m.bmba008, "' "
 
   #填到對應位置
   CALL abmm202_browser_fill("")
 
   CLOSE abmm202_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abmm202_msgcentre_notify('')
 
END FUNCTION   
 
{</section>}
 
{<section id="abmm202.input" >}
#+ 資料輸入
PRIVATE FUNCTION abmm202_input(p_cmd)
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
   #add-point:input段define
   DEFINE  l_bmaastus      LIKE  bmaa_t.bmaastus
   DEFINE  l_imaa037       LIKE  imaa_t.imaa037
   DEFINE  l_sum           LIKE  type_t.num5
   DEFINE  l_m             LIKE  type_t.num5
   
   LET g_forupd_sql = "SELECT bmbc009,bmbc010,bmbc011 FROM bmbc_t WHERE bmbcent=? AND bmbcsite=? AND  
       bmbc001=? AND bmbc002=? AND bmbc003=? AND bmbc004=? AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss') =? AND bmbc007=? AND bmbc008=?  
       AND bmbc009=? FOR UPDATE"
   #add-point:input段define_sql
         
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmm202_bcl2 CURSOR FROM g_forupd_sql
   
   CALL abmm202_input2(p_cmd)
   RETURN
   #end add-point  
   #add-point:input段define(客製用)
   
   #end add-point  
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bmba_m.bmba001,g_bmba_m.imaal003,g_bmba_m.imaal004,g_bmba_m.bmaa004,g_bmba_m.bmba002, 
       g_bmba_m.bmba003,g_bmba_m.l_imaal003,g_bmba_m.l_imaal004,g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010, 
       g_bmba_m.bmba004,g_bmba_m.bmba004_desc,g_bmba_m.bmba007,g_bmba_m.bmba007_desc,g_bmba_m.bmba008, 
       g_bmba_m.bmba005
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
         
   #end add-point 
   LET g_forupd_sql = "SELECT bmbc009,bmbc010,bmbc011 FROM bmbc_t WHERE bmbcent=? AND bmbcsite=? AND  
       bmbc001=? AND bmbc002=? AND bmbc003=? AND bmbc004=? AND bmbc005=? AND bmbc007=? AND bmbc008=?  
       AND bmbc009=? FOR UPDATE"
   #add-point:input段define_sql
         
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmm202_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql
         
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abmm202_set_entry(p_cmd)
   #add-point:set_entry後
         
   #end add-point
   CALL abmm202_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bmba_m.bmba001,g_bmba_m.bmaa004,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba011, 
       g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008,g_bmba_m.bmba005 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前
#              IF g_site != 'ALL' THEN 
#        CALL cl_err("bmbc_t",'abm-00030',1)
#        RETURN
#     END IF  
#     
#    SELECT bmaastus INTO l_bmaastus FROM bmaa_t
#     WHERE bmaaent = g_enterprise
#       AND bmaasite = g_site 
#       AND bmaa001 = g_bmba_m.bmba001
#       AND bmaa002 = g_bmba_m.bmba002
#     IF l_bmaastus = 'Y' THEN 
#        CALL cl_err("bmbc_t",'abm-00029',1)
#        RETURN       
#     END IF   
   WHILE TRUE      
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abmm202.input.head" >}
      #單頭段
      INPUT BY NAME g_bmba_m.bmba001,g_bmba_m.bmaa004,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba011, 
          g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008,g_bmba_m.bmba005  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abmm202_cl USING g_enterprise, g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmm202_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE abmm202_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abmm202_set_entry(p_cmd)
            #add-point:資料輸入前
                                    
            #end add-point
            CALL abmm202_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba001
            #add-point:BEFORE FIELD bmba001
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba001
            
            #add-point:AFTER FIELD bmba001
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND NOT cl_null(g_bmba_m.bmba002) AND NOT cl_null(g_bmba_m.bmba003) AND NOT cl_null(g_bmba_m.bmba004) AND NOT cl_null(g_bmba_m.bmba005) AND NOT cl_null(g_bmba_m.bmba007) AND NOT cl_null(g_bmba_m.bmba008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t  OR g_bmba_m.bmba002 != g_bmba002_t  OR g_bmba_m.bmba003 != g_bmba003_t  OR g_bmba_m.bmba004 != g_bmba004_t  OR g_bmba_m.bmba005 != g_bmba005_t  OR g_bmba_m.bmba007 != g_bmba007_t  OR g_bmba_m.bmba008 != g_bmba008_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND "||"bmba001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmba002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmba003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_m.bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_m.bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba001
            #add-point:ON CHANGE bmba001
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmaa004
            #add-point:BEFORE FIELD bmaa004
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmaa004
            
            #add-point:AFTER FIELD bmaa004
                                    
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmaa004
            #add-point:ON CHANGE bmaa004
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba002
            #add-point:BEFORE FIELD bmba002
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba002
            
            #add-point:AFTER FIELD bmba002
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND NOT cl_null(g_bmba_m.bmba002) AND NOT cl_null(g_bmba_m.bmba003) AND NOT cl_null(g_bmba_m.bmba004) AND NOT cl_null(g_bmba_m.bmba005) AND NOT cl_null(g_bmba_m.bmba007) AND NOT cl_null(g_bmba_m.bmba008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t  OR g_bmba_m.bmba002 != g_bmba002_t  OR g_bmba_m.bmba003 != g_bmba003_t  OR g_bmba_m.bmba004 != g_bmba004_t  OR g_bmba_m.bmba005 != g_bmba005_t  OR g_bmba_m.bmba007 != g_bmba007_t  OR g_bmba_m.bmba008 != g_bmba008_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND "||"bmba001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmba002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmba003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_m.bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_m.bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba002
            #add-point:ON CHANGE bmba002
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba003
            #add-point:BEFORE FIELD bmba003
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba003
            
            #add-point:AFTER FIELD bmba003
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND NOT cl_null(g_bmba_m.bmba002) AND NOT cl_null(g_bmba_m.bmba003) AND NOT cl_null(g_bmba_m.bmba004) AND NOT cl_null(g_bmba_m.bmba005) AND NOT cl_null(g_bmba_m.bmba007) AND NOT cl_null(g_bmba_m.bmba008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t  OR g_bmba_m.bmba002 != g_bmba002_t  OR g_bmba_m.bmba003 != g_bmba003_t  OR g_bmba_m.bmba004 != g_bmba004_t  OR g_bmba_m.bmba005 != g_bmba005_t  OR g_bmba_m.bmba007 != g_bmba007_t  OR g_bmba_m.bmba008 != g_bmba008_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND "||"bmba001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmba002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmba003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_m.bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_m.bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF            

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba003
            #add-point:ON CHANGE bmba003
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba011
            #add-point:BEFORE FIELD bmba011
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba011
            
            #add-point:AFTER FIELD bmba011
                                    
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba011
            #add-point:ON CHANGE bmba011
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba012
            #add-point:BEFORE FIELD bmba012
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba012
            
            #add-point:AFTER FIELD bmba012
                                    
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba012
            #add-point:ON CHANGE bmba012
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba010
            #add-point:BEFORE FIELD bmba010
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba010
            
            #add-point:AFTER FIELD bmba010
                                    
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba010
            #add-point:ON CHANGE bmba010
                                    
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba004
            
            #add-point:AFTER FIELD bmba004
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND NOT cl_null(g_bmba_m.bmba002) AND NOT cl_null(g_bmba_m.bmba003) AND NOT cl_null(g_bmba_m.bmba004) AND NOT cl_null(g_bmba_m.bmba005) AND NOT cl_null(g_bmba_m.bmba007) AND NOT cl_null(g_bmba_m.bmba008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t  OR g_bmba_m.bmba002 != g_bmba002_t  OR g_bmba_m.bmba003 != g_bmba003_t  OR g_bmba_m.bmba004 != g_bmba004_t  OR g_bmba_m.bmba005 != g_bmba005_t  OR g_bmba_m.bmba007 != g_bmba007_t  OR g_bmba_m.bmba008 != g_bmba008_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND "||"bmba001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmba002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmba003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_m.bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_m.bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmba_m.bmba004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='215' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmba_m.bmba004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmba_m.bmba004_desc

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba004
            #add-point:BEFORE FIELD bmba004
                                    
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba004
            #add-point:ON CHANGE bmba004
                                    
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba007
            
            #add-point:AFTER FIELD bmba007
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND NOT cl_null(g_bmba_m.bmba002) AND NOT cl_null(g_bmba_m.bmba003) AND NOT cl_null(g_bmba_m.bmba004) AND NOT cl_null(g_bmba_m.bmba005) AND NOT cl_null(g_bmba_m.bmba007) AND NOT cl_null(g_bmba_m.bmba008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t  OR g_bmba_m.bmba002 != g_bmba002_t  OR g_bmba_m.bmba003 != g_bmba003_t  OR g_bmba_m.bmba004 != g_bmba004_t  OR g_bmba_m.bmba005 != g_bmba005_t  OR g_bmba_m.bmba007 != g_bmba007_t  OR g_bmba_m.bmba008 != g_bmba008_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND "||"bmba001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmba002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmba003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_m.bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_m.bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmba_m.bmba007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmba_m.bmba007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmba_m.bmba007_desc

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba007
            #add-point:BEFORE FIELD bmba007
                                    
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba007
            #add-point:ON CHANGE bmba007
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba008
            #add-point:BEFORE FIELD bmba008
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba008
            
            #add-point:AFTER FIELD bmba008
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND NOT cl_null(g_bmba_m.bmba002) AND NOT cl_null(g_bmba_m.bmba003) AND NOT cl_null(g_bmba_m.bmba004) AND NOT cl_null(g_bmba_m.bmba005) AND NOT cl_null(g_bmba_m.bmba007) AND NOT cl_null(g_bmba_m.bmba008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t  OR g_bmba_m.bmba002 != g_bmba002_t  OR g_bmba_m.bmba003 != g_bmba003_t  OR g_bmba_m.bmba004 != g_bmba004_t  OR g_bmba_m.bmba005 != g_bmba005_t  OR g_bmba_m.bmba007 != g_bmba007_t  OR g_bmba_m.bmba008 != g_bmba008_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND "||"bmba001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmba002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmba003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_m.bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_m.bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba008
            #add-point:ON CHANGE bmba008
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba005
            #add-point:BEFORE FIELD bmba005
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba005
            
            #add-point:AFTER FIELD bmba005
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND NOT cl_null(g_bmba_m.bmba002) AND NOT cl_null(g_bmba_m.bmba003) AND NOT cl_null(g_bmba_m.bmba004) AND NOT cl_null(g_bmba_m.bmba005) AND NOT cl_null(g_bmba_m.bmba007) AND NOT cl_null(g_bmba_m.bmba008) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t  OR g_bmba_m.bmba002 != g_bmba002_t  OR g_bmba_m.bmba003 != g_bmba003_t  OR g_bmba_m.bmba004 != g_bmba004_t  OR g_bmba_m.bmba005 != g_bmba005_t  OR g_bmba_m.bmba007 != g_bmba007_t  OR g_bmba_m.bmba008 != g_bmba008_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND "||"bmba001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmba002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmba003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_m.bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_m.bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmba005
            #add-point:ON CHANGE bmba005
                                    
            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.bmba001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba001
            #add-point:ON ACTION controlp INFIELD bmba001
                                    
            #END add-point
 
         #Ctrlp:input.c.bmaa004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmaa004
            #add-point:ON ACTION controlp INFIELD bmaa004
                                    
            #END add-point
 
         #Ctrlp:input.c.bmba002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba002
            #add-point:ON ACTION controlp INFIELD bmba002
                                    
            #END add-point
 
         #Ctrlp:input.c.bmba003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba003
            #add-point:ON ACTION controlp INFIELD bmba003
                                    #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_m.bmba003             #給予default值

            #給予arg

            CALL q_imaa001()                                #呼叫開窗

            LET g_bmba_m.bmba003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_m.bmba003 TO bmba003              #顯示到畫面上

            NEXT FIELD bmba003                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.bmba011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba011
            #add-point:ON ACTION controlp INFIELD bmba011
                                    
            #END add-point
 
         #Ctrlp:input.c.bmba012
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba012
            #add-point:ON ACTION controlp INFIELD bmba012
                                    
            #END add-point
 
         #Ctrlp:input.c.bmba010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba010
            #add-point:ON ACTION controlp INFIELD bmba010
                                    #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_m.bmba010             #給予default值

            #給予arg

            CALL q_ooca001()                                #呼叫開窗

            LET g_bmba_m.bmba010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_m.bmba010 TO bmba010              #顯示到畫面上

            NEXT FIELD bmba010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.bmba004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba004
            #add-point:ON ACTION controlp INFIELD bmba004
                                    #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_m.bmba004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "215" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_bmba_m.bmba004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_m.bmba004 TO bmba004              #顯示到畫面上

            NEXT FIELD bmba004                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.bmba007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba007
            #add-point:ON ACTION controlp INFIELD bmba007
                                    #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_m.bmba007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "221" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_bmba_m.bmba007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_m.bmba007 TO bmba007              #顯示到畫面上

            NEXT FIELD bmba007                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.bmba008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba008
            #add-point:ON ACTION controlp INFIELD bmba008
                                    
            #END add-point
 
         #Ctrlp:input.c.bmba005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba005
            #add-point:ON ACTION controlp INFIELD bmba005
                                    
            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005, 
                g_bmba_m.bmba007,g_bmba_m.bmba008
                        
            #add-point:單頭INPUT後
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
                                             
               #end add-point
               
               INSERT INTO bmba_t (bmbaent, bmbasite,bmba001,bmba002,bmba003,bmba011,bmba012,bmba010, 
                   bmba004,bmba007,bmba008,bmba005)
               VALUES (g_enterprise, g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba011, 
                   g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008, 
                   g_bmba_m.bmba005) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bmba_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中
                                             
               #end add-point
               
               
               
               
               #add-point:單頭新增後
                                             
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abmm202_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abmm202_b_fill()
               END IF
               
               #add-point:單頭新增後
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
                                             
               #end add-point
               
               #將遮罩欄位還原
               CALL abmm202_bmba_t_mask_restore('restore_mask_o')
               
               UPDATE bmba_t SET (bmba001,bmba002,bmba003,bmba011,bmba012,bmba010,bmba004,bmba007,bmba008, 
                   bmba005) = (g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba011,g_bmba_m.bmba012, 
                   g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008,g_bmba_m.bmba005) 
 
                WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = g_bmba001_t
                  AND bmba002 = g_bmba002_t
                  AND bmba003 = g_bmba003_t
                  AND bmba004 = g_bmba004_t
                  AND bmba005 = g_bmba005_t
                  AND bmba007 = g_bmba007_t
                  AND bmba008 = g_bmba008_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bmba_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中
                                             
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL abmm202_bmba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bmba_m_t)
               LET g_log2 = util.JSON.stringify(g_bmba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後
                                             
               #end add-point
            END IF
            
            LET g_bmba001_t = g_bmba_m.bmba001
            LET g_bmba002_t = g_bmba_m.bmba002
            LET g_bmba003_t = g_bmba_m.bmba003
            LET g_bmba004_t = g_bmba_m.bmba004
            LET g_bmba005_t = g_bmba_m.bmba005
            LET g_bmba007_t = g_bmba_m.bmba007
            LET g_bmba008_t = g_bmba_m.bmba008
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abmm202.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bmbc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmbc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmm202_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bmbc_d.getLength()
            #add-point:資料輸入前
                                    
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN abmm202_cl USING g_enterprise, g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmm202_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE abmm202_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_bmbc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmbc_d[l_ac].bmbc009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bmbc_d_t.* = g_bmbc_d[l_ac].*  #BACKUP
               LET g_bmbc_d_o.* = g_bmbc_d[l_ac].*  #BACKUP
               CALL abmm202_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               CLOSE abmm202_cl 
               CALL s_transaction_end('N','0')
               CALL s_transaction_begin()               
               #end add-point  
               CALL abmm202_set_no_entry_b(l_cmd)
               IF NOT abmm202_lock_b("bmbc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmm202_bcl INTO g_bmbc_d[l_ac].bmbc009,g_bmbc_d[l_ac].bmbc010,g_bmbc_d[l_ac].bmbc011 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bmbc_d_t.bmbc009 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bmbc_d_mask_o[l_ac].* =  g_bmbc_d[l_ac].*
                  CALL abmm202_bmbc_t_mask()
                  LET g_bmbc_d_mask_n[l_ac].* =  g_bmbc_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abmm202_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
                                                NEXT FIELD bmbc009   
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmbc_d[l_ac].* TO NULL 
            INITIALIZE g_bmbc_d_t.* TO NULL 
            INITIALIZE g_bmbc_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_bmbc_d_t.* = g_bmbc_d[l_ac].*     #新輸入資料
            LET g_bmbc_d_o.* = g_bmbc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmm202_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
                                    
            #end add-point
            CALL abmm202_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmbc_d[li_reproduce_target].* = g_bmbc_d[li_reproduce].*
 
               LET g_bmbc_d[li_reproduce_target].bmbc009 = NULL
 
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
               
            #add-point:單身新增
                                    
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM bmbc_t 
             WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = g_bmba_m.bmba001
               AND bmbc002 = g_bmba_m.bmba002
               AND bmbc003 = g_bmba_m.bmba003
               AND bmbc004 = g_bmba_m.bmba004
               AND bmbc005 = g_bmba_m.bmba005
               AND bmbc007 = g_bmba_m.bmba007
               AND bmbc008 = g_bmba_m.bmba008
 
               AND bmbc009 = g_bmbc_d[l_ac].bmbc009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               IF NOT abmm202_chk_bmba011(g_bmbc_d[l_ac].bmbc011) THEN
                  CALL g_bmbc_d.deleteElement(l_ac)
                  NEXT FIELD bmbc011
               END IF 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmba_m.bmba001
               LET gs_keys[2] = g_bmba_m.bmba002
               LET gs_keys[3] = g_bmba_m.bmba003
               LET gs_keys[4] = g_bmba_m.bmba004
               LET gs_keys[5] = g_bmba_m.bmba005
               LET gs_keys[6] = g_bmba_m.bmba007
               LET gs_keys[7] = g_bmba_m.bmba008
               LET gs_keys[8] = g_bmbc_d[g_detail_idx].bmbc009
               CALL abmm202_insert_b('bmbc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
                                             
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_bmbc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmbc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abmm202_b_fill()
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
               #add-point:單身刪除後(=d)
               
               #end add-point
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
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_bmba_m.bmba001
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba002
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba003
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba004
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba005
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba007
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba008
 
               LET gs_keys[gs_keys.getLength()+1] = g_bmbc_d_t.bmbc009
 
            
               #刪除同層單身
               IF NOT abmm202_delete_b('bmbc_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abmm202_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abmm202_key_delete_b(gs_keys,'bmbc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abmm202_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
               
               #add-point:單身刪除中
                                             
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abmm202_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後
                                                        
               #end add-point
               LET l_count = g_bmbc_d.getLength()
               
               #add-point:單身刪除後(<>d)
                                    
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bmbc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc009
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bmbc_d[l_ac].bmbc009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD bmbc009
            END IF 
 
 
            #add-point:AFTER FIELD bmbc009
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND g_bmba_m.bmba002 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba003) AND g_bmba_m.bmba004 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba005) AND g_bmba_m.bmba007 IS NOT NULL AND g_bmba_m.bmba008 IS NOT NULL AND NOT cl_null(g_bmbc_d[l_ac].bmbc009) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t OR g_bmba_m.bmba002 != g_bmba002_t OR g_bmba_m.bmba003 != g_bmba003_t OR g_bmba_m.bmba004 != g_bmba004_t OR g_bmba_m.bmba005 != g_bmba005_t OR g_bmba_m.bmba007 != g_bmba007_t OR g_bmba_m.bmba008 != g_bmba008_t OR g_bmbc_d[l_ac].bmbc009 != g_bmbc_d_t.bmbc009))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmbc_t WHERE "||"bmbcent = '" ||g_enterprise|| "' AND bmbcsite = '" ||g_site|| "' AND "||"bmbc001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmbc002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmbc003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmbc004 = '"||g_bmba_m.bmba004 ||"' AND "|| " bmbc005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmbc007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmbc008 = '"||g_bmba_m.bmba008 ||"' AND "|| "bmbc009 = '"||g_bmbc_d[l_ac].bmbc009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc009
            #add-point:BEFORE FIELD bmbc009
                                                IF l_cmd = 'a' THEN 
               SELECT max(bmbc009) +1 INTO g_bmbc_d[l_ac].bmbc009
                FROM bmbc_t
               WHERE bmbcent = g_enterprise
                 AND bmbcsite = g_site
                 AND bmbc001 = g_bmba_m.bmba001
                 AND bmbc002 = g_bmba_m.bmba002
                 AND bmbc003 = g_bmba_m.bmba003
                 AND bmbc004 = g_bmba_m.bmba004
                 AND bmbc005 = g_bmba_m.bmba005
                 AND bmbc007 = g_bmba_m.bmba007
                 AND bmbc008 = g_bmba_m.bmba008
               IF cl_null(g_bmbc_d[l_ac].bmbc009) THEN
                  LET g_bmbc_d[l_ac].bmbc009 = 1
               END IF
            END IF               
                     
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmbc009
            #add-point:ON CHANGE bmbc009
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc010
            #add-point:BEFORE FIELD bmbc010
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc010
            
            #add-point:AFTER FIELD bmbc010
            IF  NOT cl_null(g_bmba_m.bmba001) AND g_bmba_m.bmba002 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba003) AND g_bmba_m.bmba004 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba005) AND g_bmba_m.bmba007 IS NOT NULL AND g_bmba_m.bmba008 IS NOT NULL AND NOT cl_null(g_bmbc_d[l_ac].bmbc010) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t OR g_bmba_m.bmba002 != g_bmba002_t OR g_bmba_m.bmba003 != g_bmba003_t OR g_bmba_m.bmba004 != g_bmba004_t OR g_bmba_m.bmba005 != g_bmba005_t OR g_bmba_m.bmba007 != g_bmba007_t OR g_bmba_m.bmba008 != g_bmba008_t OR g_bmbc_d[l_ac].bmbc010 != g_bmbc_d_t.bmbc010))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmbc_t WHERE "||"bmbcent = '" ||g_enterprise|| "' AND bmbcsite = '" ||g_site|| "' AND "||"bmbc001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmbc002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmbc003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmbc004 = '"||g_bmba_m.bmba004 ||"' AND "|| " bmbc005 = '"||g_bmba_m.bmba005 ||"' AND "|| "bmbc007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmbc008 = '"||g_bmba_m.bmba008 ||"' AND "|| "bmbc010 = '"||g_bmbc_d[l_ac].bmbc010 ||"'",'std-00004',0) THEN 
                     LET g_bmbc_d[l_ac].bmbc010 = g_bmbc_d_t.bmbc010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF                                                 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmbc010
            #add-point:ON CHANGE bmbc010
                                    
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc011
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bmbc_d[l_ac].bmbc011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD bmbc011
            END IF 
 
 
            #add-point:AFTER FIELD bmbc011


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc011
            #add-point:BEFORE FIELD bmbc011
                                    
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmbc011
            #add-point:ON CHANGE bmbc011
                                    
            #END add-point 
 
 
                  #Ctrlp:input.c.page1.bmbc009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc009
            #add-point:ON ACTION controlp INFIELD bmbc009
                                    
            #END add-point
 
         #Ctrlp:input.c.page1.bmbc010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc010
            #add-point:ON ACTION controlp INFIELD bmbc010
                                    
            #END add-point
 
         #Ctrlp:input.c.page1.bmbc011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc011
            #add-point:ON ACTION controlp INFIELD bmbc011
                                    
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*
               CLOSE abmm202_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bmbc_d[l_ac].bmbc009 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*
            ELSE
            
               #add-point:單身修改前
                                                            IF NOT abmm202_chk_bmba011(g_bmbc_d[l_ac].bmbc011 - g_bmbc_d_t.bmbc011) THEN
                  NEXT FIELD bmbc011
               END IF 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abmm202_bmbc_t_mask_restore('restore_mask_o')
      
               UPDATE bmbc_t SET (bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,bmbc009,bmbc010, 
                   bmbc011) = (g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005, 
                   g_bmba_m.bmba007,g_bmba_m.bmba008,g_bmbc_d[l_ac].bmbc009,g_bmbc_d[l_ac].bmbc010,g_bmbc_d[l_ac].bmbc011) 
 
                WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = g_bmba_m.bmba001 
                  AND bmbc002 = g_bmba_m.bmba002 
                  AND bmbc003 = g_bmba_m.bmba003 
                  AND bmbc004 = g_bmba_m.bmba004 
                  AND bmbc005 = g_bmba_m.bmba005 
                  AND bmbc007 = g_bmba_m.bmba007 
                  AND bmbc008 = g_bmba_m.bmba008 
 
                  AND bmbc009 = g_bmbc_d_t.bmbc009 #項次   
 
                  
               #add-point:單身修改中
                                             
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmbc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmbc_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmba_m.bmba001
               LET gs_keys_bak[1] = g_bmba001_t
               LET gs_keys[2] = g_bmba_m.bmba002
               LET gs_keys_bak[2] = g_bmba002_t
               LET gs_keys[3] = g_bmba_m.bmba003
               LET gs_keys_bak[3] = g_bmba003_t
               LET gs_keys[4] = g_bmba_m.bmba004
               LET gs_keys_bak[4] = g_bmba004_t
               LET gs_keys[5] = g_bmba_m.bmba005
               LET gs_keys_bak[5] = g_bmba005_t
               LET gs_keys[6] = g_bmba_m.bmba007
               LET gs_keys_bak[6] = g_bmba007_t
               LET gs_keys[7] = g_bmba_m.bmba008
               LET gs_keys_bak[7] = g_bmba008_t
               LET gs_keys[8] = g_bmbc_d[g_detail_idx].bmbc009
               LET gs_keys_bak[8] = g_bmbc_d_t.bmbc009
               CALL abmm202_update_b('bmbc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abmm202_bmbc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bmbc_d[g_detail_idx].bmbc009 = g_bmbc_d_t.bmbc009 
 
                  ) THEN
                  LET gs_keys[01] = g_bmba_m.bmba001
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba002
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba003
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba004
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba005
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba007
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba008
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bmbc_d_t.bmbc009
 
                  CALL abmm202_key_update_b(gs_keys,'bmbc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bmba_m),util.JSON.stringify(g_bmbc_d_t)
               LET g_log2 = util.JSON.stringify(g_bmba_m),util.JSON.stringify(g_bmbc_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後
                                                               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
                                     
            
            #end add-point
            CALL abmm202_unlock_b("bmbc_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 
            
            IF cl_null(g_argv[2]) THEN    #add by xujing 20150929    该逻辑从其他程序串入时不能会走
               IF cl_null(g_bmbc_d[1].bmbc009) THEN                      
                  UPDATE bmba_t SET bmba018 = 'N'
                   WHERE bmbaent = g_enterprise  AND bmbasite = g_site AND bmba001 = g_bmba_m.bmba001
                     AND bmba002 = g_bmba_m.bmba002
               
                     AND bmba003 = g_bmba_m.bmba003
               
                     AND bmba004 = g_bmba_m.bmba004
               
                     AND bmba005 = g_bmba_m.bmba005
               
                     AND bmba007 = g_bmba_m.bmba007
               
                     AND bmba008 = g_bmba_m.bmba008 
               ELSE 
                  UPDATE bmba_t SET bmba018 = 'Y'
                   WHERE bmbaent = g_enterprise  AND bmbasite = g_site AND bmba001 = g_bmba_m.bmba001
                     AND bmba002 = g_bmba_m.bmba002
               
                     AND bmba003 = g_bmba_m.bmba003
               
                     AND bmba004 = g_bmba_m.bmba004
               
                     AND bmba005 = g_bmba_m.bmba005
               
                     AND bmba007 = g_bmba_m.bmba007
               
                     AND bmba008 = g_bmba_m.bmba008 
               END IF                     
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = g_bmba_m.bmba001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF       
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_bmbc_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_bmbc_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="abmm202.input.other" >}
      
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
            #add-point:input段next_field
            
            #end add-point  
            NEXT FIELD bmba001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bmbc009
 
               #add-point:input段modify_detail 
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog
         
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
         #add-point:input段accept 
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit
         
         #end add-point
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input 
   IF NOT abmm202_chk_bmba011('') THEN
      LET INT_FLAG = FALSE	
      CONTINUE WHILE
   END IF 
   
      EXIT WHILE
   
   END WHILE
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abmm202_show()
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define
         
   #end add-point  
   #add-point:show段define(客製用)
   
   #end add-point  
   
   #add-point:show段之前
         
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abmm202_b_fill() #單身填充
      CALL abmm202_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL abmm202_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
            SELECT bmaa004 INTO g_bmba_m.bmaa004 FROM bmaa_t
    WHERE bmaaent = g_enterprise
      AND bmaasite = g_site
      AND bmaa001 = g_bmba_m.bmba001
      AND bmaa002 = g_bmba_m.bmba002 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmba_m.bmba001
   CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_bmba_m.imaal003 = g_rtn_fields[1] 
   LET g_bmba_m.imaal004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_bmba_m.imaal003,g_bmba_m.imaal004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmba_m.bmba003
   CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_bmba_m.l_imaal003 = g_rtn_fields[1] 
   LET g_bmba_m.l_imaal004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_bmba_m.l_imaal003,g_bmba_m.l_imaal004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmba_m.bmba004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='215' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmba_m.bmba004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bmba_m.bmba004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmba_m.bmba007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmba_m.bmba007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmba_m.bmba007_desc
   #end add-point
   
   #遮罩相關處理
   LET g_bmba_m_mask_o.* =  g_bmba_m.*
   CALL abmm202_bmba_t_mask()
   LET g_bmba_m_mask_n.* =  g_bmba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bmba_m.bmba001,g_bmba_m.imaal003,g_bmba_m.imaal004,g_bmba_m.bmaa004,g_bmba_m.bmba002, 
       g_bmba_m.bmba003,g_bmba_m.l_imaal003,g_bmba_m.l_imaal004,g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010, 
       g_bmba_m.bmba004,g_bmba_m.bmba004_desc,g_bmba_m.bmba007,g_bmba_m.bmba007_desc,g_bmba_m.bmba008, 
       g_bmba_m.bmba005
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bmbc_d.getLength()
      #add-point:show段單身reference
                  
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other
         
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abmm202_detail_show()
 
   #add-point:show段之後
          #  CALL abmm202_bmba_show()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abmm202_detail_show()
   #add-point:detail_show段define
         
   #end add-point  
   #add-point:detail_show段define(客製用)
   
   #end add-point  
   
   #add-point:detail_show段之前
         
   #end add-point
   
   #add-point:detail_show段之後
         
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abmm202_reproduce()
   DEFINE l_newno     LIKE bmba_t.bmba001 
   DEFINE l_oldno     LIKE bmba_t.bmba001 
   DEFINE l_newno02     LIKE bmba_t.bmba002 
   DEFINE l_oldno02     LIKE bmba_t.bmba002 
   DEFINE l_newno03     LIKE bmba_t.bmba003 
   DEFINE l_oldno03     LIKE bmba_t.bmba003 
   DEFINE l_newno04     LIKE bmba_t.bmba004 
   DEFINE l_oldno04     LIKE bmba_t.bmba004 
   DEFINE l_newno05     LIKE bmba_t.bmba005 
   DEFINE l_oldno05     LIKE bmba_t.bmba005 
   DEFINE l_newno06     LIKE bmba_t.bmba007 
   DEFINE l_oldno06     LIKE bmba_t.bmba007 
   DEFINE l_newno07     LIKE bmba_t.bmba008 
   DEFINE l_oldno07     LIKE bmba_t.bmba008 
 
   DEFINE l_master    RECORD LIKE bmba_t.*
   DEFINE l_detail    RECORD LIKE bmbc_t.*
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define
         
   #end add-point   
   #add-point:reproduce段define(客製用)
   
   #end add-point   
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_bmba_m.bmba001 IS NULL
   OR g_bmba_m.bmba002 IS NULL
   OR g_bmba_m.bmba003 IS NULL
   OR g_bmba_m.bmba004 IS NULL
   OR g_bmba_m.bmba005 IS NULL
   OR g_bmba_m.bmba007 IS NULL
   OR g_bmba_m.bmba008 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bmba001_t = g_bmba_m.bmba001
   LET g_bmba002_t = g_bmba_m.bmba002
   LET g_bmba003_t = g_bmba_m.bmba003
   LET g_bmba004_t = g_bmba_m.bmba004
   LET g_bmba005_t = g_bmba_m.bmba005
   LET g_bmba007_t = g_bmba_m.bmba007
   LET g_bmba008_t = g_bmba_m.bmba008
 
    
   LET g_bmba_m.bmba001 = ""
   LET g_bmba_m.bmba002 = ""
   LET g_bmba_m.bmba003 = ""
   LET g_bmba_m.bmba004 = ""
   LET g_bmba_m.bmba005 = ""
   LET g_bmba_m.bmba007 = ""
   LET g_bmba_m.bmba008 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
         
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_bmba_m.bmba004_desc = ''
   DISPLAY BY NAME g_bmba_m.bmba004_desc
   LET g_bmba_m.bmba007_desc = ''
   DISPLAY BY NAME g_bmba_m.bmba007_desc
 
   
   CALL abmm202_input("r")
   
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
      INITIALIZE g_bmba_m.* TO NULL
      INITIALIZE g_bmbc_d TO NULL
 
      #add-point:複製取消後
      
      #end add-point
      CALL abmm202_show()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmm202_set_act_visible()   
   CALL abmm202_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bmba001_t = g_bmba_m.bmba001
   LET g_bmba002_t = g_bmba_m.bmba002
   LET g_bmba003_t = g_bmba_m.bmba003
   LET g_bmba004_t = g_bmba_m.bmba004
   LET g_bmba005_t = g_bmba_m.bmba005
   LET g_bmba007_t = g_bmba_m.bmba007
   LET g_bmba008_t = g_bmba_m.bmba008
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmbaent = '" ||g_enterprise|| "' AND bmbasite = '" ||g_site|| "' AND",
                      " bmba001 = '", g_bmba_m.bmba001, "' "
                      ," AND bmba002 = '", g_bmba_m.bmba002, "' "
                      ," AND bmba003 = '", g_bmba_m.bmba003, "' "
                      ," AND bmba004 = '", g_bmba_m.bmba004, "' "
                      ," AND bmba005 = '", g_bmba_m.bmba005, "' "
                      ," AND bmba007 = '", g_bmba_m.bmba007, "' "
                      ," AND bmba008 = '", g_bmba_m.bmba008, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmm202_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
         
   #end add-point
   
   CALL abmm202_idx_chk()
   
   #功能已完成,通報訊息中心
   CALL abmm202_msgcentre_notify('')
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abmm202_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bmbc_t.*
 
 
   #add-point:delete段define
         
   #end add-point    
   #add-point:delete段define(客製用)
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abmm202_detail
   
   #add-point:單身複製前1
         
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE abmm202_detail AS ",
                "SELECT * FROM bmbc_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO abmm202_detail SELECT * FROM bmbc_t 
                                         WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = g_bmba001_t
                                         AND bmbc002 = g_bmba002_t
                                         AND bmbc003 = g_bmba003_t
                                         AND bmbc004 = g_bmba004_t
                                         AND bmbc005 = g_bmba005_t
                                         AND bmbc007 = g_bmba007_t
                                         AND bmbc008 = g_bmba008_t
 
   
   #將key修正為調整後   
   UPDATE abmm202_detail 
      #更新key欄位
      SET bmbc001 = g_bmba_m.bmba001
          , bmbc002 = g_bmba_m.bmba002
          , bmbc003 = g_bmba_m.bmba003
          , bmbc004 = g_bmba_m.bmba004
          , bmbc005 = g_bmba_m.bmba005
          , bmbc007 = g_bmba_m.bmba007
          , bmbc008 = g_bmba_m.bmba008
 
      #更新共用欄位
      
 
   #add-point:單身修改前
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bmbc_t SELECT * FROM abmm202_detail
   
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
   DROP TABLE abmm202_detail
   
   #add-point:單身複製後1
         
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bmba001_t = g_bmba_m.bmba001
   LET g_bmba002_t = g_bmba_m.bmba002
   LET g_bmba003_t = g_bmba_m.bmba003
   LET g_bmba004_t = g_bmba_m.bmba004
   LET g_bmba005_t = g_bmba_m.bmba005
   LET g_bmba007_t = g_bmba_m.bmba007
   LET g_bmba008_t = g_bmba_m.bmba008
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abmm202_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
         
   #end add-point     
   #add-point:delete段define(客製用)
   
   #end add-point     
   
   IF g_bmba_m.bmba001 IS NULL
   OR g_bmba_m.bmba002 IS NULL
   OR g_bmba_m.bmba003 IS NULL
   OR g_bmba_m.bmba004 IS NULL
   OR g_bmba_m.bmba005 IS NULL
   OR g_bmba_m.bmba007 IS NULL
   OR g_bmba_m.bmba008 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN abmm202_cl USING g_enterprise, g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmm202_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE abmm202_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmm202_master_referesh USING g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004, 
       g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008 INTO g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003, 
       g_bmba_m.bmba011,g_bmba_m.bmba012,g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008, 
       g_bmba_m.bmba005,g_bmba_m.bmba004_desc,g_bmba_m.bmba007_desc
   
   #檢查是否允許此動作
   IF NOT abmm202_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bmba_m_mask_o.* =  g_bmba_m.*
   CALL abmm202_bmba_t_mask()
   LET g_bmba_m_mask_n.* =  g_bmba_m.*
   
   CALL abmm202_show()
   
   #add-point:delete段before ask
   CLOSE abmm202_cl
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前
                  
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL abmm202_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
  
  
      #資料備份
      LET g_bmba001_t = g_bmba_m.bmba001
      LET g_bmba002_t = g_bmba_m.bmba002
      LET g_bmba003_t = g_bmba_m.bmba003
      LET g_bmba004_t = g_bmba_m.bmba004
      LET g_bmba005_t = g_bmba_m.bmba005
      LET g_bmba007_t = g_bmba_m.bmba007
      LET g_bmba008_t = g_bmba_m.bmba008
 
 
      DELETE FROM bmba_t
       WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = g_bmba_m.bmba001
         AND bmba002 = g_bmba_m.bmba002
         AND bmba003 = g_bmba_m.bmba003
         AND bmba004 = g_bmba_m.bmba004
         AND bmba005 = g_bmba_m.bmba005
         AND bmba007 = g_bmba_m.bmba007
         AND bmba008 = g_bmba_m.bmba008
 
       
      #add-point:單頭刪除中
                  
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bmba_m.bmba001 
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
      
      DELETE FROM bmbc_t
       WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = g_bmba_m.bmba001
         AND bmbc002 = g_bmba_m.bmba002
         AND bmbc003 = g_bmba_m.bmba003
         AND bmbc004 = g_bmba_m.bmba004
         AND bmbc005 = g_bmba_m.bmba005
         AND bmbc007 = g_bmba_m.bmba007
         AND bmbc008 = g_bmba_m.bmba008
 
 
      #add-point:單身刪除中
                  
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmbc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
                         
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE abmm202_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bmbc_d.clear() 
 
     
      CALL abmm202_ui_browser_refresh()  
      #CALL abmm202_ui_headershow()  
      #CALL abmm202_ui_detailshow()
      
      IF g_browser_cnt > 0 THEN 
         #CALL abmm202_browser_fill("")
         CALL abmm202_fetch('P')
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
   CLOSE abmm202_cl
 
   #功能已完成,通報訊息中心
   CALL abmm202_msgcentre_notify('')
    
END FUNCTION
 
{</section>}
 
{<section id="abmm202.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abmm202_b_fill()
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define
         
   #end add-point     
   #add-point:b_fill段define(客製用)
   
   #end add-point     
 
   CALL g_bmbc_d.clear()    #g_bmbc_d 單頭及單身 
 
 
   #add-point:b_fill段sql_before
         
   #end add-point
   
   #判斷是否填充
   IF abmm202_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  UNIQUE bmbc009,bmbc010,bmbc011  FROM bmbc_t",   
                     " INNER JOIN bmba_t ON bmba001 = bmbc001 ",
                     " AND bmba002 = bmbc002 ",
                     " AND bmba003 = bmbc003 ",
                     " AND bmba004 = bmbc004 ",
                     " AND bmba005 = bmbc005 ",
                     " AND bmba007 = bmbc007 ",
                     " AND bmba008 = bmbc008 ",
 
                     #"",
                     
                     "",
                     
                     " WHERE bmbcent=? AND bmbcsite=? AND bmbc001=? AND bmbc002=? AND bmbc003=? AND bmbc004=? AND bmbc005=? AND bmbc007=? AND bmbc008=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before
#         LET g_sql = "SELECT  UNIQUE bmbc009,bmbc010,bmbc011  FROM bmbc_t",   
#                     " INNER JOIN bmba_t ON bmba001 = bmbc001 ",
#                     " AND bmba002 = bmbc002 ",
#                     " AND bmba003 = bmbc003 ",
#                     " AND bmba004 = bmbc004 ",
#                     " AND bmba005 = bmbc005 ",
#                     " AND bmba007 = bmbc007 ",
#                     " AND bmba008 = bmbc008 ",
#                     " WHERE bmbcent=? AND bmbcsite=? AND bmbc001=? AND bmbc002=? ",
#                     "   AND bmbc003=? AND bmbc004=? AND to_char(bmbc005,'yyyy-mm-dd hh24:mi:ss')=? AND bmbc007=? AND bmbc008=?"
#         LET g_sql = cl_sql_add_mask(g_sql)                     
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bmbc_t.bmbc009"
         
         #add-point:單身填充控制
                  
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abmm202_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abmm202_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise, g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008
                                               
      FOREACH b_fill_cs INTO g_bmbc_d[l_ac].bmbc009,g_bmbc_d[l_ac].bmbc010,g_bmbc_d[l_ac].bmbc011
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
   
   CALL g_bmbc_d.deleteElement(g_bmbc_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abmm202_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bmbc_d.getLength()
      LET g_bmbc_d_mask_o[l_ac].* =  g_bmbc_d[l_ac].*
      CALL abmm202_bmbc_t_mask()
      LET g_bmbc_d_mask_n[l_ac].* =  g_bmbc_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abmm202_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define
            DEFINE l_sql       STRING
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_sql = " DELETE FROM bmbc_t ",
          " WHERE bmbcent = '",g_enterprise,"' AND bmbcsite = '",g_site,"' AND bmbc001 = '",ps_keys_bak[1] ,"' AND bmbc002 = '",ps_keys_bak[2],"'",
          " AND bmbc003 = '",ps_keys_bak[3],"' AND bmbc004 = '",ps_keys_bak[4],"' AND bmbc005 = to_date('",ps_keys_bak[5] ,"','YYYY-MM-DD hh24:mi:ss')",
          " AND bmbc007 = '",ps_keys_bak[6] ,"' AND bmbc008 = '",ps_keys_bak[7],"' AND bmbc009 = '",ps_keys_bak[8],"'"
      PREPARE del_bmbc_pre FROM l_sql
      EXECUTE del_bmbc_pre 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
         RETURN FALSE
      END IF
      CALL abmm202_all_site('d') #160324-00007#1
   END IF
   RETURN TRUE
   #end add-point     
   #add-point:delete_b段define(客製用)
   
   #end add-point     
 
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
                  
      #end add-point    
      DELETE FROM bmbc_t
       WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND
         bmbc001 = ps_keys_bak[1] AND bmbc002 = ps_keys_bak[2] AND bmbc003 = ps_keys_bak[3] AND bmbc004 = ps_keys_bak[4] AND bmbc005 = ps_keys_bak[5] AND bmbc007 = ps_keys_bak[6] AND bmbc008 = ps_keys_bak[7] AND bmbc009 = ps_keys_bak[8]
      #add-point:delete_b段刪除中
                  
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bmbc_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other
         
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abmm202_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define
   DEFINE l_sql       STRING
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN 
#      LET l_sql="INSERT INTO bmbc_t(bmbcent, bmbcsite,bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,bmbc009,bmbc010,bmbc011)",
#          " VALUES('",g_enterprise,"','",g_site,"','",ps_keys[1],"','",ps_keys[2],"','",ps_keys[3],"','",ps_keys[4],"',",
#          " to_date('",ps_keys[5],"','YYYY-MM-DD hh24:mi:ss'),'",ps_keys[6],"','",ps_keys[7],"',",ps_keys[8],",",
#          "'",g_bmbc_d[g_detail_idx].bmbc010,"','",g_bmbc_d[g_detail_idx].bmbc011,"')"
#      PREPARE ins_bmbc_pre FROM l_sql
#      EXECUTE ins_bmbc_pre
      
      INSERT INTO bmbc_t
                  (bmbcent, bmbcsite,
                   bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,
                   bmbc009
                   ,bmbc010,bmbc011) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],to_date(ps_keys[5],'YYYY-MM-DD hh24:mi:ss'),ps_keys[6],ps_keys[7],ps_keys[8]
                   ,g_bmbc_d[g_detail_idx].bmbc010,g_bmbc_d[g_detail_idx].bmbc011)
                   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "bmbc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      CALL abmm202_all_site('a') #160324-00007#1
   END IF 
   RETURN     
   #end add-point     
   #add-point:insert_b段define(客製用)
   
   #end add-point     
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
                  
      #end add-point 
      INSERT INTO bmbc_t
                  (bmbcent, bmbcsite,
                   bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,
                   bmbc009
                   ,bmbc010,bmbc011) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
                   ,g_bmbc_d[g_detail_idx].bmbc010,g_bmbc_d[g_detail_idx].bmbc011)
      #add-point:insert_b段資料新增中
                  
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmbc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bmbc_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後
                  
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other
         
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abmm202_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   #add-point:update_b段define
            DEFINE l_sql           STRING   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bmbc_t" THEN
      LET l_sql = " UPDATE bmbc_t ", 
          " SET (bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,bmbc009,bmbc010,bmbc011)",
          "    = ",
          "   ('",ps_keys[1],"','",ps_keys[2],"','",ps_keys[3],"','",ps_keys[4],"',",
          " to_date('",ps_keys[5],"','YYYY-MM-DD hh24:mi:ss'),'",ps_keys[6],"','",ps_keys[7],"','",ps_keys[8],"',",
          "'",g_bmbc_d[g_detail_idx].bmbc010,"','",g_bmbc_d[g_detail_idx].bmbc011,"')",
          " WHERE bmbcent = '",g_enterprise,"' AND bmbcsite = '",g_site,"' AND bmbc001 = '",ps_keys_bak[1] ,"' AND bmbc002 = '",ps_keys_bak[2],"'",
          " AND bmbc003 = '",ps_keys_bak[3],"' AND bmbc004 = '",ps_keys_bak[4],"' AND bmbc005 = to_date('",ps_keys_bak[5] ,"','YYYY-MM-DD hh24:mi:ss')",
          " AND bmbc007 = '",ps_keys_bak[6] ,"' AND bmbc008 = '",ps_keys_bak[7],"' AND bmbc009 = '",ps_keys_bak[8],"'"
     PREPARE upd_bmbc_pre FROM l_sql
     EXECUTE upd_bmbc_pre  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "bmbc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "bmbc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
  END IF   
   #end add-point   
   #add-point:update_b段define(客製用)
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bmbc_t" THEN
      #add-point:update_b段修改前
                  
      #end add-point 
      
      #將遮罩欄位還原
      CALL abmm202_bmbc_t_mask_restore('restore_mask_o')
               
      UPDATE bmbc_t 
         SET (bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,
              bmbc009
              ,bmbc010,bmbc011) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
              ,g_bmbc_d[g_detail_idx].bmbc010,g_bmbc_d[g_detail_idx].bmbc011) 
         WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = ps_keys_bak[1] AND bmbc002 = ps_keys_bak[2] AND bmbc003 = ps_keys_bak[3] AND bmbc004 = ps_keys_bak[4] AND bmbc005 = ps_keys_bak[5] AND bmbc007 = ps_keys_bak[6] AND bmbc008 = ps_keys_bak[7] AND bmbc009 = ps_keys_bak[8]
      #add-point:update_b段修改中
                  
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmbc_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmbc_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abmm202_bmbc_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後
                  
      #end add-point  
   END IF
   
 
   
 
   
   #add-point:update_b段other
         
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abmm202_key_update_b(ps_keys_bak,ps_table)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:update_b段define
   
   #end add-point
   #add-point:update_b段define(客製用)
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abmm202_key_delete_b(ps_keys_bak,ps_table)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define
   
   #end add-point
   #add-point:delete_b段define(客製用)
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abmm202_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   DEFINE l_bmba005    LIKE ooff_t.ooff007   #日期值字符串处理   
   
   LET ls_group = "bmbc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   LET l_bmba005 = YEAR(g_bmba_m.bmba005) USING "####",'-',MONTH(g_bmba_m.bmba005) USING "&&",'-',DAY(g_bmba_m.bmba005) USING "&&",' ',TIME(g_bmba_m.bmba005)
      OPEN abmm202_bcl2 USING g_enterprise, g_site,
                                       g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004, 
                                           l_bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008,g_bmbc_d[g_detail_idx].bmbc009  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abmm202_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF   
   RETURN TRUE  
   #end add-point   
   #add-point:lock_b段define(客製用)
   
   #end add-point   
    
   #先刷新資料
   #CALL abmm202_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bmbc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abmm202_bcl USING g_enterprise, g_site,
                                       g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004, 
                                           g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008,g_bmbc_d[g_detail_idx].bmbc009  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abmm202_bcl" 
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
 
{<section id="abmm202.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abmm202_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE abmm202_bcl2
   END IF 
   RETURN
   #end add-point  
   #add-point:unlock_b段define(客製用)
   
   #end add-point  
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE abmm202_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other
        
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abmm202_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
         
   #end add-point       
   #add-point:set_entry段define(客製用)
   
   #end add-point       
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008",TRUE)
      #add-point:set_entry段欄位控制
                  
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
         
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abmm202_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
         
   #end add-point     
   #add-point:set_no_entry段define(客製用)
   
   #end add-point     
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008",FALSE)
      #add-point:set_no_entry段欄位控制
                  
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("",FALSE)
   END IF 
   
   #add-point:set_no_entry段欄位控制後
         
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abmm202_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
         
   #end add-point     
   #add-point:set_entry_b段define(客製用)
   
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
 
{<section id="abmm202.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abmm202_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
         
   #end add-point    
   #add-point:set_no_entry_b段define(客製用)
   
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
 
{<section id="abmm202.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abmm202_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point   
   #add-point:set_act_visible段define(客製用)
   
   #end add-point   
   #add-point:set_act_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abmm202_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point   
   #add-point:set_act_no_visible段define(客製用)
   
   #end add-point   
   #add-point:set_act_no_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abmm202_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point   
   #add-point:set_act_visible_b段define(客製用)
   
   #end add-point   
   #add-point:set_act_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abmm202_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point   
   #add-point:set_act_no_visible_b段define(客製用)
   
   #end add-point   
   #add-point:set_act_no_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abmm202_default_search()
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define
            DEFINE l_wc    STRING
   #end add-point  
   #add-point:default_search段define(客製用)
   
   #end add-point  
   
   #add-point:default_search段開始前
         
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " bmba001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bmba002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bmba003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bmba004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bmba005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " bmba007 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " bmba008 = '", g_argv[07], "' AND "
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
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "bmba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bmbc_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
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
   
   #add-point:default_search段結束前
   LET ls_wc = ''  #140928 add
   IF NOT cl_null(g_argv[1]) THEN
      LET l_wc = l_wc," bmbasite = '",g_argv[1],"' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET l_wc = l_wc, " bmba001 = '", g_argv[02], "' AND "
   END IF
   
   #IF NOT cl_null(g_argv[03]) THEN
   IF g_argv[03] IS NOT NULL THEN #140928 mod
      LET l_wc = l_wc, " bmba002 = '", g_argv[03], "' AND " #140928 add'
   END IF

   IF NOT cl_null(g_argv[04]) THEN
      LET l_wc = l_wc, " bmba003 = '", g_argv[04], "' AND " #140928 add'
   END IF

   #IF NOT cl_null(g_argv[05]) THEN
   IF g_argv[05] IS NOT NULL THEN #140928 mod
      LET l_wc = l_wc, " bmba004 = '", g_argv[05], "' AND " #140928 add'
   END IF

   IF NOT cl_null(g_argv[06]) THEN
      #LET l_wc = l_wc, " bmba005 = '", g_argv[06], "' AND "
      LET l_wc = l_wc, " to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') = '", g_argv[06], "' AND " #140928 mod
      
   END IF

   #IF NOT cl_null(g_argv[07]) THEN
   IF g_argv[07] IS NOT NULL THEN #140928 mod
      LET l_wc = l_wc, " bmba007 = '", g_argv[07], "' AND " #140928 add'
   END IF

   #IF NOT cl_null(g_argv[08]) THEN
   IF g_argv[08] IS NOT NULL THEN #140928 mod
      LET l_wc = l_wc, " bmba008 = '", g_argv[08], "' AND " #140928 add'
   END IF


   
   IF NOT cl_null(l_wc) THEN
      LET g_wc = l_wc.subString(1,l_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF   
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.state_change" >}
   
 
{</section>}
 
{<section id="abmm202.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abmm202_idx_chk()
   #add-point:idx_chk段define
         
   #end add-point  
   #add-point:idx_chk段define(客製用)
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bmbc_d.getLength() THEN
         LET g_detail_idx = g_bmbc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmbc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmbc_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other
         
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abmm202_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
         
   #end add-point
   #add-point:b_fill2段define(客製用)
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後
         
   #end add-point
    
   LET l_ac = li_ac
   
   CALL abmm202_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abmm202_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
         
   #end add-point
   #add-point:fill_chk段define(客製用)
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
                  
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abmm202.status_show" >}
PRIVATE FUNCTION abmm202_status_show()
   #add-point:status_show段define
   
   #end add-point
   #add-point:status_show段define(客製用)
   
   #end add-point
   
   #add-point:status_show段status_show
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmm202.mask_functions" >}
&include "erp/abm/abmm202_mask.4gl"
 
{</section>}
 
{<section id="abmm202.signature" >}
   
 
{</section>}
 
{<section id="abmm202.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION abmm202_set_pk_array()
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
   LET g_pk_array[1].values = g_bmba_m.bmba001
   LET g_pk_array[1].column = 'bmba001'
   LET g_pk_array[2].values = g_bmba_m.bmba002
   LET g_pk_array[2].column = 'bmba002'
   LET g_pk_array[3].values = g_bmba_m.bmba003
   LET g_pk_array[3].column = 'bmba003'
   LET g_pk_array[4].values = g_bmba_m.bmba004
   LET g_pk_array[4].column = 'bmba004'
   LET g_pk_array[5].values = g_bmba_m.bmba005
   LET g_pk_array[5].column = 'bmba005'
   LET g_pk_array[6].values = g_bmba_m.bmba007
   LET g_pk_array[6].column = 'bmba007'
   LET g_pk_array[7].values = g_bmba_m.bmba008
   LET g_pk_array[7].column = 'bmba008'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="abmm202.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abmm202.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:2)
PRIVATE FUNCTION abmm202_msgcentre_notify(lc_state)
   DEFINE lc_state LIKE type_t.chr5
   #add-point:msgcentre_notify段define
   
   #end add-point
   #add-point:msgcentre_notify段define
   
   #end add-point   
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   IF g_action_choice = "statechange" THEN
      LET g_msgparam.state = g_action_choice,":",lc_state
   ELSE
      LET g_msgparam.state = g_action_choice
   END IF
 
   #PK資料填寫
   CALL abmm202_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bmba_m)
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="abmm202.action_chk" >}
PRIVATE FUNCTION abmm202_action_chk()
   #add-point:action_chk段define
   
   #end add-point
   #add-point:action_chk段define(客製用)
   
   #end add-point
   
   #add-point:action_chk段action_chk
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmm202.other_function" readonly="Y" >}
#chk bmba011
PRIVATE FUNCTION abmm202_chk_bmba011(p_bmbc011)
   DEFINE p_bmbc011       LIKE bmbc_t.bmbc011
   DEFINE l_imaa037       LIKE imaa_t.imaa037
   DEFINE l_sum           LIKE bmbc_t.bmbc011
          
     SELECT imaa037 INTO l_imaa037 FROM imaa_t 
      WHERE imaaent = g_enterprise
        AND imaa001 = g_bmba_m.bmba003
     SELECT SUM(bmbc011) INTO l_sum FROM bmbc_t 
      WHERE bmbcent = g_enterprise
        AND bmbcsite = g_site 
        AND bmbc001 = g_bmba_m.bmba001
        AND bmbc002 = g_bmba_m.bmba002
        AND bmbc003 = g_bmba_m.bmba003
        AND bmbc004 = g_bmba_m.bmba004
        AND bmbc005 = g_bmba_m.bmba005
        AND bmbc007 = g_bmba_m.bmba007
        AND bmbc008 = g_bmba_m.bmba008              
     IF l_imaa037 = 'Y' THEN 
        IF cl_null(l_sum) THEN
           LET l_sum = 0 
        END IF
        IF cl_null(p_bmbc011) THEN        
           IF l_sum != g_bmba_m.bmba011 THEN 
#              INITIALIZE g_errparam TO NULL
#              LET g_errparam.code = 'abm-00076'
#              LET g_errparam.extend = g_bmba_m.bmba011
#              LET g_errparam.popup = TRUE
#              CALL cl_err()
#              RETURN FALSE  
#           END IF 
              IF NOT cl_ask_confirm('abm-00258') THEN
                 RETURN FALSE
              ELSE
                 UPDATE bmba_t SET bmba011 = l_sum
                  WHERE bmbaent = g_enterprise  
                    AND bmbasite = g_site 
                    AND bmba001 = g_bmba_m.bmba001
                    AND bmba002 = g_bmba_m.bmba002
                    AND bmba003 = g_bmba_m.bmba003
                    AND bmba004 = g_bmba_m.bmba004
                    AND bmba005 = g_bmba_m.bmba005
                    AND bmba007 = g_bmba_m.bmba007
                    AND bmba008 = g_bmba_m.bmba008                                  
              END IF
           END IF           
        ELSE
           IF l_sum + p_bmbc011 > g_bmba_m.bmba011 THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'abm-00080'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()

              RETURN FALSE  
           END IF       
        END IF
     END IF
     RETURN TRUE
END FUNCTION

PRIVATE FUNCTION abmm202_act_oocq007()
DEFINE l_oocq007  LIKE oocq_t.oocq007
DEFINE r_success  LIKE type_t.num5

   SELECT oocq007 INTO l_oocq007
     FROM oocq_t,imaa_t
    WHERE oocqent = imaaent
      AND oocq002 = imaa010
      AND oocq001 = '210'
      AND oocqent = g_enterprise
      AND imaa001 = g_bmba_m.bmba001
   IF l_oocq007 = 'Y' THEN 
      LET r_success = TRUE
   ELSE
      LET r_success = FALSE
   END IF
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION abmm202_input2(p_cmd)
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
   DEFINE  l_bmaastus      LIKE  bmaa_t.bmaastus
   DEFINE  l_imaa037       LIKE  imaa_t.imaa037
   DEFINE  l_sum           LIKE  type_t.num5
   DEFINE  l_m             LIKE  type_t.num5

   #end add-point  
   #add-point:input段define(客製用)

   #end add-point  
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bmba_m.bmba001,g_bmba_m.imaal003,g_bmba_m.imaal004,g_bmba_m.bmaa004,g_bmba_m.bmba002, 
       g_bmba_m.bmba003,g_bmba_m.l_imaal003,g_bmba_m.l_imaal004,g_bmba_m.bmba011,g_bmba_m.bmba010,g_bmba_m.bmba004, 
       g_bmba_m.bmba004_desc,g_bmba_m.bmba007,g_bmba_m.bmba007_desc,g_bmba_m.bmba008,g_bmba_m.bmba005 

   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
         
   #end add-point 

   #add-point:input段define_sql
         
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abmm202_set_entry(p_cmd)
   #add-point:set_entry後
         
   #end add-point
   CALL abmm202_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bmba_m.bmba001,g_bmba_m.bmaa004,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba011, 
       g_bmba_m.bmba010,g_bmba_m.bmba004,g_bmba_m.bmba007,g_bmba_m.bmba008,g_bmba_m.bmba005
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前
#              IF g_site != 'ALL' THEN 
#        CALL cl_err("bmbc_t",'abm-00030',1)
#        RETURN
#     END IF  
#     
#    SELECT bmaastus INTO l_bmaastus FROM bmaa_t
#     WHERE bmaaent = g_enterprise
#       AND bmaasite = g_site 
#       AND bmaa001 = g_bmba_m.bmba001
#       AND bmaa002 = g_bmba_m.bmba002
#     IF l_bmaastus = 'Y' THEN 
#        CALL cl_err("bmbc_t",'abm-00029',1)
#        RETURN       
#     END IF   
   WHILE TRUE      
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #Page1 預設值產生於此處
      INPUT ARRAY g_bmbc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前

            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmbc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmm202_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bmbc_d.getLength()
            #add-point:資料輸入前
                                    
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
#            OPEN abmm202_cl USING g_enterprise, g_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,g_bmba_m.bmba004,g_bmba_m.bmba005,g_bmba_m.bmba007,g_bmba_m.bmba008
#            IF STATUS THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "OPEN abmm202_cl:" 
#               LET g_errparam.code   = STATUS 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CLOSE abmm202_cl
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
            
            LET g_rec_b = g_bmbc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmbc_d[l_ac].bmbc009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bmbc_d_t.* = g_bmbc_d[l_ac].*  #BACKUP
               LET g_bmbc_d_o.* = g_bmbc_d[l_ac].*  #BACKUP
               CALL abmm202_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
            
               #end add-point  
               CALL abmm202_set_no_entry_b(l_cmd)
               IF NOT abmm202_lock_b("bmbc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmm202_bcl2 INTO g_bmbc_d[l_ac].bmbc009,g_bmbc_d[l_ac].bmbc010,g_bmbc_d[l_ac].bmbc011 

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bmbc_d_t.bmbc009 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bmbc_d_mask_o[l_ac].* =  g_bmbc_d[l_ac].*
                  CALL abmm202_bmbc_t_mask()
                  LET g_bmbc_d_mask_n[l_ac].* =  g_bmbc_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abmm202_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
                                                NEXT FIELD bmbc009   
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmbc_d[l_ac].* TO NULL 
            INITIALIZE g_bmbc_d_t.* TO NULL 
            INITIALIZE g_bmbc_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份

            #end add-point
            LET g_bmbc_d_t.* = g_bmbc_d[l_ac].*     #新輸入資料
            LET g_bmbc_d_o.* = g_bmbc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmm202_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
                                    
            #end add-point
            CALL abmm202_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmbc_d[li_reproduce_target].* = g_bmbc_d[li_reproduce].*
 
               LET g_bmbc_d[li_reproduce_target].bmbc009 = NULL
 
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
               
            #add-point:單身新增
                                    
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM bmbc_t 
             WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = g_bmba_m.bmba001
               AND bmbc002 = g_bmba_m.bmba002
               AND bmbc003 = g_bmba_m.bmba003
               AND bmbc004 = g_bmba_m.bmba004
               AND bmbc005 = g_bmba_m.bmba005
               AND bmbc007 = g_bmba_m.bmba007
               AND bmbc008 = g_bmba_m.bmba008
 
               AND bmbc009 = g_bmbc_d[l_ac].bmbc009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               IF NOT abmm202_chk_bmba011(g_bmbc_d[l_ac].bmbc011) THEN
                  CALL g_bmbc_d.deleteElement(l_ac)
                  NEXT FIELD bmbc011
               END IF 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmba_m.bmba001
               LET gs_keys[2] = g_bmba_m.bmba002
               LET gs_keys[3] = g_bmba_m.bmba003
               LET gs_keys[4] = g_bmba_m.bmba004
               LET gs_keys[5] = g_bmba_m.bmba005
               LET gs_keys[6] = g_bmba_m.bmba007
               LET gs_keys[7] = g_bmba_m.bmba008
               LET gs_keys[8] = g_bmbc_d[g_detail_idx].bmbc009
               CALL abmm202_insert_b('bmbc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
                                             
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_bmbc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmbc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abmm202_b_fill()
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
               #add-point:單身刪除後(=d)

               #end add-point
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
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_bmba_m.bmba001
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba002
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba003
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba004
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba005
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba007
               LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba008
 
               LET gs_keys[gs_keys.getLength()+1] = g_bmbc_d_t.bmbc009
 
            
               #刪除同層單身
               IF NOT abmm202_delete_b('bmbc_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abmm202_bcl2
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abmm202_key_delete_b(gs_keys,'bmbc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abmm202_bcl2
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
               
               #add-point:單身刪除中
                                             
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abmm202_bcl2
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後
                                                        
               #end add-point
               LET l_count = g_bmbc_d.getLength()
               
               #add-point:單身刪除後(<>d)
                                    
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bmbc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc009
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bmbc_d[l_ac].bmbc009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD bmbc009
            END IF 
 
 
            #add-point:AFTER FIELD bmbc009
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmba_m.bmba001) AND g_bmba_m.bmba002 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba003) AND g_bmba_m.bmba004 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba005) AND g_bmba_m.bmba007 IS NOT NULL AND g_bmba_m.bmba008 IS NOT NULL AND NOT cl_null(g_bmbc_d[l_ac].bmbc009) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t OR g_bmba_m.bmba002 != g_bmba002_t OR g_bmba_m.bmba003 != g_bmba003_t OR g_bmba_m.bmba004 != g_bmba004_t OR g_bmba_m.bmba005 != g_bmba005_t OR g_bmba_m.bmba007 != g_bmba007_t OR g_bmba_m.bmba008 != g_bmba008_t OR g_bmbc_d[l_ac].bmbc009 != g_bmbc_d_t.bmbc009))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmbc_t WHERE "||"bmbcent = '" ||g_enterprise|| "' AND bmbcsite = '" ||g_site|| "' AND "||"bmbc001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmbc002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmbc003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmbc004 = '"||g_bmba_m.bmba004 ||"' AND "|| " to_char(bmbc005,'YYYY-MM-DD hh24:mi:ss') = '"||g_bmba_m.bmba005 ||"' AND "|| "bmbc007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmbc008 = '"||g_bmba_m.bmba008 ||"' AND "|| "bmbc009 = '"||g_bmbc_d[l_ac].bmbc009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc009
            #add-point:BEFORE FIELD bmbc009
            IF l_cmd = 'a' THEN 
               SELECT max(bmbc009) +1 INTO g_bmbc_d[l_ac].bmbc009
                FROM bmbc_t
               WHERE bmbcent = g_enterprise
                 AND bmbcsite = g_site
                 AND bmbc001 = g_bmba_m.bmba001
                 AND bmbc002 = g_bmba_m.bmba002
                 AND bmbc003 = g_bmba_m.bmba003
                 AND bmbc004 = g_bmba_m.bmba004
                 AND bmbc005 = g_bmba_m.bmba005
                 AND bmbc007 = g_bmba_m.bmba007
                 AND bmbc008 = g_bmba_m.bmba008
               IF cl_null(g_bmbc_d[l_ac].bmbc009) THEN
                  LET g_bmbc_d[l_ac].bmbc009 = 1
               END IF
            END IF               
                     
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmbc009
            #add-point:ON CHANGE bmbc009
                                    
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc010
            #add-point:BEFORE FIELD bmbc010
                                    
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc010
            
            #add-point:AFTER FIELD bmbc010
            IF  NOT cl_null(g_bmba_m.bmba001) AND g_bmba_m.bmba002 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba003) AND g_bmba_m.bmba004 IS NOT NULL AND NOT cl_null(g_bmba_m.bmba005) AND g_bmba_m.bmba007 IS NOT NULL AND g_bmba_m.bmba008 IS NOT NULL AND NOT cl_null(g_bmbc_d[l_ac].bmbc010) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmba_m.bmba001 != g_bmba001_t OR g_bmba_m.bmba002 != g_bmba002_t OR g_bmba_m.bmba003 != g_bmba003_t OR g_bmba_m.bmba004 != g_bmba004_t OR g_bmba_m.bmba005 != g_bmba005_t OR g_bmba_m.bmba007 != g_bmba007_t OR g_bmba_m.bmba008 != g_bmba008_t OR g_bmbc_d[l_ac].bmbc010 != g_bmbc_d_t.bmbc010))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmbc_t WHERE "||"bmbcent = '" ||g_enterprise|| "' AND bmbcsite = '" ||g_site|| "' AND "||"bmbc001 = '"||g_bmba_m.bmba001 ||"' AND "|| "bmbc002 = '"||g_bmba_m.bmba002 ||"' AND "|| "bmbc003 = '"||g_bmba_m.bmba003 ||"' AND "|| "bmbc004 = '"||g_bmba_m.bmba004 ||"' AND "|| " to_char(bmbc005,'YYYY-MM-DD hh24:mi:ss') = '"||g_bmba_m.bmba005 ||"' AND "|| "bmbc007 = '"||g_bmba_m.bmba007 ||"' AND "|| "bmbc008 = '"||g_bmba_m.bmba008 ||"' AND "|| "bmbc010 = '"||g_bmbc_d[l_ac].bmbc010 ||"'",'std-00004',0) THEN 
                     LET g_bmbc_d[l_ac].bmbc010 = g_bmbc_d_t.bmbc010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF                                    
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmbc010
            #add-point:ON CHANGE bmbc010
                                    
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbc011
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bmbc_d[l_ac].bmbc011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD bmbc011
            END IF 
 
 
            #add-point:AFTER FIELD bmbc011
            IF NOT cl_null(g_bmbc_d[l_ac].bmbc011) THEN 
          
            END IF 

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbc011
            #add-point:BEFORE FIELD bmbc011
                                    
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE bmbc011
            #add-point:ON CHANGE bmbc011
                                    
            #END add-point 
 
 
                  #Ctrlp:input.c.page1.bmbc009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc009
            #add-point:ON ACTION controlp INFIELD bmbc009
                                    
            #END add-point
 
         #Ctrlp:input.c.page1.bmbc010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc010
            #add-point:ON ACTION controlp INFIELD bmbc010
                                    
            #END add-point
 
         #Ctrlp:input.c.page1.bmbc011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbc011
            #add-point:ON ACTION controlp INFIELD bmbc011
                                    
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*
               CLOSE abmm202_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bmbc_d[l_ac].bmbc009 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*
            ELSE
            
               #add-point:單身修改前
               IF NOT abmm202_chk_bmba011(g_bmbc_d[l_ac].bmbc011 - g_bmbc_d_t.bmbc011) THEN
                  LET g_bmbc_d[l_ac].bmbc011 = g_bmbc_d_t.bmbc011
                  NEXT FIELD bmbc011
               END IF 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abmm202_bmbc_t_mask_restore('restore_mask_o')
      
               UPDATE bmbc_t SET (bmbc009,bmbc010,bmbc011) = (g_bmbc_d[l_ac].bmbc009,g_bmbc_d[l_ac].bmbc010,g_bmbc_d[l_ac].bmbc011) 

                WHERE bmbcent = g_enterprise AND bmbcsite = g_site AND bmbc001 = g_bmba_m.bmba001 
                  AND bmbc002 = g_bmba_m.bmba002 
                  AND bmbc003 = g_bmba_m.bmba003 
                  AND bmbc004 = g_bmba_m.bmba004 
                  AND bmbc005 = g_bmba_m.bmba005 
                  AND bmbc007 = g_bmba_m.bmba007 
                  AND bmbc008 = g_bmba_m.bmba008 
 
                  AND bmbc009 = g_bmbc_d_t.bmbc009 #項次   
 
                  
               #add-point:單身修改中
                                             
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmbc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmbc_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_bmbc_d[l_ac].* = g_bmbc_d_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmba_m.bmba001
               LET gs_keys_bak[1] = g_bmba001_t
               LET gs_keys[2] = g_bmba_m.bmba002
               LET gs_keys_bak[2] = g_bmba002_t
               LET gs_keys[3] = g_bmba_m.bmba003
               LET gs_keys_bak[3] = g_bmba003_t
               LET gs_keys[4] = g_bmba_m.bmba004
               LET gs_keys_bak[4] = g_bmba004_t
               LET gs_keys[5] = g_bmba_m.bmba005
               LET gs_keys_bak[5] = g_bmba005_t
               LET gs_keys[6] = g_bmba_m.bmba007
               LET gs_keys_bak[6] = g_bmba007_t
               LET gs_keys[7] = g_bmba_m.bmba008
               LET gs_keys_bak[7] = g_bmba008_t
               LET gs_keys[8] = g_bmbc_d[g_detail_idx].bmbc009
               LET gs_keys_bak[8] = g_bmbc_d_t.bmbc009
               CALL abmm202_update_b('bmbc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abmm202_bmbc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bmbc_d[g_detail_idx].bmbc009 = g_bmbc_d_t.bmbc009 
 
                  ) THEN
                  LET gs_keys[01] = g_bmba_m.bmba001
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba002
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba003
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba004
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba005
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba007
                  LET gs_keys[gs_keys.getLength()+1] = g_bmba_m.bmba008
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bmbc_d_t.bmbc009
 
                  CALL abmm202_key_update_b(gs_keys,'bmbc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bmba_m),util.JSON.stringify(g_bmbc_d_t)
               LET g_log2 = util.JSON.stringify(g_bmba_m),util.JSON.stringify(g_bmbc_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後
               CALL abmm202_all_site('u') #160324-00007#1                                                
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
                                     
            
            #end add-point
            CALL abmm202_unlock_b("bmbc_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2

            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 
            IF cl_null(g_argv[2]) THEN    #add by xujing 20150929    该逻辑从其他程序串入时不能走
               IF cl_null(g_bmbc_d[1].bmbc009) THEN                      
                  UPDATE bmba_t SET bmba018 = 'N'
                   WHERE bmbaent = g_enterprise  AND bmbasite = g_site AND bmba001 = g_bmba_m.bmba001
                     AND bmba002 = g_bmba_m.bmba002
               
                     AND bmba003 = g_bmba_m.bmba003
               
                     AND bmba004 = g_bmba_m.bmba004
               
                     AND bmba005 = g_bmba_m.bmba005
               
                     AND bmba007 = g_bmba_m.bmba007
               
                     AND bmba008 = g_bmba_m.bmba008 
               ELSE 
                  UPDATE bmba_t SET bmba018 = 'Y'
                   WHERE bmbaent = g_enterprise  AND bmbasite = g_site AND bmba001 = g_bmba_m.bmba001
                     AND bmba002 = g_bmba_m.bmba002
               
                     AND bmba003 = g_bmba_m.bmba003
               
                     AND bmba004 = g_bmba_m.bmba004
               
                     AND bmba005 = g_bmba_m.bmba005
               
                     AND bmba007 = g_bmba_m.bmba007
               
                     AND bmba008 = g_bmba_m.bmba008 
               END IF                     
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = g_bmba_m.bmba001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF 
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_bmbc_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_bmbc_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT   
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
            #add-point:input段next_field

            #end add-point  
            NEXT FIELD bmba001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bmbc009
 
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
   IF NOT abmm202_chk_bmba011('') THEN
      LET INT_FLAG = FALSE	
      CONTINUE WHILE
   END IF 
   
      EXIT WHILE
   
   END WHILE      
      
END FUNCTION

################################################################################
# Descriptions...: 抛转据点
# Date & Author..: 2016/04/01 By xianghui
# Modify.........: 160324-00007#1
################################################################################
PRIVATE FUNCTION abmm202_all_site(p_type)
DEFINE p_type     LIKE type_t.chr1
DEFINE l_sql      STRING
DEFINE l_site     LIKE bmea_t.bmeasite
DEFINE l_bmba019  LIKE bmba_t.bmba019 

   #IF g_prog = 'abmm202' THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'abmm202' THEN   #160705-00042#8 160712 by sakura add
      LET l_sql = "SELECT DISTINCT bmbasite,bmba019 FROM bmba_t ",
                  " WHERE bmbaent = '",g_enterprise,"'",
                  "   AND bmbasite <> '",g_site,"'",
                  "   AND bmba001 = '",g_bmba_m.bmba001,"'",
                  "   AND bmba002 = '",g_bmba_m.bmba002,"'",
                  "   AND bmba003 = '",g_bmba_m.bmba003,"'",
                  "   AND bmba004 = '",g_bmba_m.bmba004,"'",
                  "   AND bmba005 = to_date('",g_bmba_m.bmba005,"','yyyy-mm-dd hh24:mi:ss')",
                  "   AND bmba007 = '",g_bmba_m.bmba007,"'",
                  "   AND bmba008 = '",g_bmba_m.bmba008,"'"
      PREPARE all_site_p FROM l_sql
      DECLARE all_site_c CURSOR FOR all_site_p      
      FOREACH all_site_c INTO l_site,l_bmba019  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
    
            EXIT FOREACH
         END IF 
         IF l_bmba019 = '1' THEN
            IF p_type = 'a' THEN      
               INSERT INTO bmbc_t
                           (bmbcent,bmbcsite,bmbc001,bmbc002,bmbc003,
                            bmbc004,bmbc005,bmbc007,bmbc008,bmbc009,
                            bmbc010,bmbc011) 
                     VALUES(g_enterprise,l_site,g_bmba_m.bmba001,g_bmba_m.bmba002,g_bmba_m.bmba003,
                            g_bmba_m.bmba004,g_bmba_m.bmba005,g_bmba_m.bmba007,
                            g_bmba_m.bmba008,g_bmbc_d[g_detail_idx].bmbc009,
                            g_bmbc_d[g_detail_idx].bmbc010,g_bmbc_d[g_detail_idx].bmbc011)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmbc_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  EXIT FOREACH
               END IF
            END IF
            IF p_type = 'u' THEN
               UPDATE bmbc_t SET (bmbc009,bmbc010,bmbc011) = (g_bmbc_d[l_ac].bmbc009,g_bmbc_d[l_ac].bmbc010,g_bmbc_d[l_ac].bmbc011) 
                WHERE bmbcent = g_enterprise 
                  AND bmbcsite = l_site 
                  AND bmbc001 = g_bmba_m.bmba001 
                  AND bmbc002 = g_bmba_m.bmba002 
                  AND bmbc003 = g_bmba_m.bmba003 
                  AND bmbc004 = g_bmba_m.bmba004 
                  AND bmbc005 = g_bmba_m.bmba005 
                  AND bmbc007 = g_bmba_m.bmba007 
                  AND bmbc008 = g_bmba_m.bmba008 
                  AND bmbc009 = g_bmbc_d_t.bmbc009
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmbc_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  EXIT FOREACH
               END IF               
            END IF
            IF p_type = 'd' THEN
                DELETE FROM bmbc_t 
                 WHERE bmbcent = g_enterprise 
                   AND bmbcsite = l_site 
                   AND bmbc001 = g_bmba_m.bmba001 
                   AND bmbc002 = g_bmba_m.bmba002 
                   AND bmbc003 = g_bmba_m.bmba003 
                   AND bmbc004 = g_bmba_m.bmba004 
                   AND bmbc005 = g_bmba_m.bmba005 
                   AND bmbc007 = g_bmba_m.bmba007 
                   AND bmbc008 = g_bmba_m.bmba008 
                   AND bmbc009 = g_bmbc_d_t.bmbc009
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  RETURN FALSE
               END IF         
            END IF
         END IF
      END FOREACH
   END IF      
END FUNCTION

 
{</section>}
 
