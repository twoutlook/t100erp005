#該程式未解開Section, 採用最新樣板產出!
{<section id="adet416.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-07-24 16:55:13), PR版次:0004(2016-10-05 14:41:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000207
#+ Filename...: adet416
#+ Description: 收銀差錯處理維護作業
#+ Creator....: 02748(2014-04-09 17:14:31)
#+ Modifier...: 06137 -SD/PR- 06814
 
{</section>}
 
{<section id="adet416.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160819-00054#4 20160912 By 06814     #異動券狀態時,需更新對應單號
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
PRIVATE type type_g_deah_m        RECORD
       deagsite LIKE deag_t.deagsite, 
   deagsite_desc LIKE type_t.chr80, 
   deagdocdt LIKE deag_t.deagdocdt, 
   deahdocno LIKE deah_t.deahdocno, 
   deahseq LIKE deah_t.deahseq, 
   deag001 LIKE deag_t.deag001, 
   deag002 LIKE deag_t.deag002, 
   deag002_desc LIKE type_t.chr80, 
   deag003 LIKE deag_t.deag003, 
   deag003_desc LIKE type_t.chr80, 
   deag004 LIKE deag_t.deag004, 
   deag004_desc LIKE type_t.chr80, 
   deah000 LIKE deah_t.deah000, 
   deah001 LIKE deah_t.deah001, 
   deah001_desc LIKE type_t.chr80, 
   deah015 LIKE deah_t.deah015, 
   deas002_sum LIKE type_t.chr500, 
   deah014 LIKE deah_t.deah014
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_deas_d        RECORD
       deasseq1 LIKE deas_t.deasseq1, 
   deas001 LIKE deas_t.deas001, 
   deas002 LIKE deas_t.deas002, 
   deas006 LIKE deas_t.deas006, 
   deas003 LIKE deas_t.deas003, 
   deas004 LIKE deas_t.deas004, 
   deas005 LIKE deas_t.deas005
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
         b_deagsite LIKE deag_t.deagsite,
   b_deagsite_desc LIKE type_t.chr80,
   b_deagdocdt LIKE deag_t.deagdocdt,
      b_deahdocno LIKE deah_t.deahdocno,
   b_deag001 LIKE deag_t.deag001,
   b_deag002 LIKE deag_t.deag002,
   b_deag002_desc LIKE type_t.chr80,
   b_deag003 LIKE deag_t.deag003,
   b_deag003_desc LIKE type_t.chr80,
   b_deag004 LIKE deag_t.deag004,
   b_deag004_desc LIKE type_t.chr80,
      b_deah000 LIKE deah_t.deah000,
      b_deah001 LIKE deah_t.deah001,
   b_deah001_desc LIKE type_t.chr80,
      b_deah014 LIKE deah_t.deah014,
      b_deahseq LIKE deah_t.deahseq
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_deahdocno           LIKE deah_t.deahdocno
DEFINE g_deahseq             LIKE deah_t.deahseq
#end add-point
       
#模組變數(Module Variables)
DEFINE g_deah_m          type_g_deah_m
DEFINE g_deah_m_t        type_g_deah_m
DEFINE g_deah_m_o        type_g_deah_m
DEFINE g_deah_m_mask_o   type_g_deah_m #轉換遮罩前資料
DEFINE g_deah_m_mask_n   type_g_deah_m #轉換遮罩後資料
 
   DEFINE g_deahdocno_t LIKE deah_t.deahdocno
DEFINE g_deahseq_t LIKE deah_t.deahseq
 
 
DEFINE g_deas_d          DYNAMIC ARRAY OF type_g_deas_d
DEFINE g_deas_d_t        type_g_deas_d
DEFINE g_deas_d_o        type_g_deas_d
DEFINE g_deas_d_mask_o   DYNAMIC ARRAY OF type_g_deas_d #轉換遮罩前資料
DEFINE g_deas_d_mask_n   DYNAMIC ARRAY OF type_g_deas_d #轉換遮罩後資料
 
 
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
 
{<section id="adet416.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:作業初始化 name="main.init"
   LET g_deahdocno = g_argv[1]
   LET g_deahseq = g_argv[2]
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT '','','',deahdocno,deahseq,'','','','','','','',deah000,deah001,'',deah015, 
       '',deah014", 
                      " FROM deah_t",
                      " WHERE deahent= ? AND deahdocno=? AND deahseq=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   LET g_forupd_sql = "SELECT deagsite,'',deagdocdt,deahdocno,deahseq,deag001,deag002,'',deag003,'',deag004,'',deah000,deah001,'',deah015, 
       '',deah014 FROM deah_t,deag_t WHERE deahent = deagent AND deahdocno = deagdocno AND deahent= ? AND deahdocno=? AND deahseq=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet416_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.deahdocno,t0.deahseq,t0.deah000,t0.deah001,t0.deah015,t0.deah014", 
 
               " FROM deah_t t0",
               
               " WHERE t0.deahent = " ||g_enterprise|| " AND t0.deahdocno = ? AND t0.deahseq = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adet416_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adet416 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adet416_init()   
 
      #進入選單 Menu (="N")
      CALL adet416_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adet416
      
   END IF 
   
   CLOSE adet416_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adet416.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adet416_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
    CALL cl_set_combo_scc("deah000","8310")
    CALL cl_set_combo_scc("deas001","6047")
    CALL cl_set_combo_scc("deas003","6048")
    CALL cl_set_combo_scc("deas005","6049")
    CALL cl_set_combo_scc("b_deah000","8310")
    CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
   
   #初始化搜尋條件
   CALL adet416_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adet416.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adet416_ui_dialog()
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
   DEFINE l_success    LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_deah_m.* TO NULL
         CALL g_deas_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adet416_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
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
               
               CALL adet416_fetch('') # reload data
               LET l_ac = 1
               CALL adet416_ui_detailshow() #Setting the current row 
         
               CALL adet416_idx_chk()
               #NEXT FIELD deasseq1
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_deas_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adet416_idx_chk()
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
               CALL adet416_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL adet416_browser_fill("")
            CALL cl_notice()
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
               CALL adet416_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adet416_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adet416_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL adet416_act_visible()
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
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
                     WHEN la_wc[li_idx].tableid = "deah_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deas_t" 
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
               CALL adet416_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "deah_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deas_t" 
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
                  CALL adet416_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adet416_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL adet416_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adet416_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet416_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adet416_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet416_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adet416_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet416_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adet416_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet416_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adet416_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet416_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_deas_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
               NEXT FIELD deasseq1
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
         ON ACTION confirm
            LET g_action_choice="confirm"
            IF cl_auth_chk_act("confirm") THEN
               
               #add-point:ON ACTION confirm name="menu.confirm"
               IF cl_null(g_deah_m.deah014) THEN
                  CALL s_adet416_conf_chk(g_deah_m.deahdocno,g_deah_m.deahseq) RETURNING l_success,g_errno
                  IF l_success THEN
                     IF cl_ask_confirm('aim-00108') THEN
                        CALL s_transaction_begin()
                        CALL s_adet416_conf_upd(g_deah_m.deahdocno,g_deah_m.deahseq) RETURNING l_success
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_deah_m.deahdocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                 
                           CALL s_transaction_end('N','0')
                        ELSE
                           CALL adet416_update_gcao('conf',g_deah_m.deahdocno,g_deah_m.deahseq)
                           CALL s_transaction_end('Y','1')
                        END IF           
                     END IF
                  ELSE
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_deah_m.deahdocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                     END IF            
                  END IF  
               END IF               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adet416_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adet416_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ade/adet416_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ade/adet416_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unconfirm
            LET g_action_choice="unconfirm"
            IF cl_auth_chk_act("unconfirm") THEN
               
               #add-point:ON ACTION unconfirm name="menu.unconfirm"
               IF NOT cl_null(g_deah_m.deah014) THEN
                  CALL s_adet416_unconf_chk(g_deah_m.deahdocno,g_deah_m.deahseq) RETURNING l_success,g_errno
                  IF l_success THEN
                     IF cl_ask_confirm('aim-00110') THEN
                        CALL s_transaction_begin()
                        CALL s_adet416_unconf_upd(g_deah_m.deahdocno,g_deah_m.deahseq) RETURNING l_success
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_deah_m.deahdocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                 
                           CALL s_transaction_end('N','0')
                        ELSE
                           CALL adet416_update_gcao('unconf',g_deah_m.deahdocno,g_deah_m.deahseq)
                           CALL s_transaction_end('Y','1')
                        END IF
                     END IF
                  ELSE
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_deah_m.deahdocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                     END IF           
                  END IF  
               END IF   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adet416_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_adet402
            LET g_action_choice="prog_adet402"
            IF cl_auth_chk_act("prog_adet402") THEN
               
               #add-point:ON ACTION prog_adet402 name="menu.prog_adet402"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'adet402'
               LET la_param.param[1] = g_deah_m.deahdocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aooi130
            LET g_action_choice="prog_aooi130"
            IF cl_auth_chk_act("prog_aooi130") THEN
               
               #add-point:ON ACTION prog_aooi130 name="menu.prog_aooi130"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_deah_m.deag004)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adet416_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adet416_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adet416_set_pk_array()
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
 
{<section id="adet416.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adet416_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   LET l_where = s_aooi500_sql_where(g_prog,'deagsite')
   IF cl_null(g_wc) THEN
      LET g_wc = l_where
   ELSE 
      LET g_wc = g_wc CLIPPED," AND ",l_where
   END IF
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT deahdocno,deahseq ",
                      " FROM deah_t ",
                      " ",
                      " LEFT JOIN deas_t ON deasent = deahent AND deahdocno = deasdocno AND deahseq = deasseq ", "  ",
                      #add-point:browser_fill段sql(deas_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE deahent = " ||g_enterprise|| " AND deasent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deah_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deahdocno,deahseq ",
                      " FROM deah_t ", 
                      "  ",
                      "  ",
                      " WHERE deahent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("deah_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE deahdocno ",
                                    ",deahseq ",
                       " FROM deag_t,deah_t ",
                       " LEFT JOIN deas_t ON deasent = deahent AND deahdocno = deasdocno AND deahseq = deasseq ",
                       " WHERE deagent = deahent AND deagdocno = deahdocno AND deahent = '" ||g_enterprise|| "' AND deasent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE deahdocno ",
                                    ",deahseq ",
                        " FROM deag_t,deah_t ", 
                        " WHERE deagent = deahent AND deagdocno = deahdocno AND deahent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
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
      INITIALIZE g_deah_m.* TO NULL
      CALL g_deas_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.deahdocno,t0.deah000,t0.deah001,t0.deah014,t0.deahseq Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.deahdocno,t0.deah000,t0.deah001,t0.deah014,t0.deahseq,t1.ooial003 ", 
 
                  " FROM deah_t t0",
                  "  ",
                  "  LEFT JOIN deas_t ON deasent = deahent AND deahdocno = deasdocno AND deahseq = deasseq ", "  ", 
                  #add-point:browser_fill段sql(deas_t1) name="browser_fill.join.deas_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=t0.deah001 AND t1.ooial002='"||g_dlang||"' ",
 
                  " WHERE t0.deahent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deah_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.deahdocno,t0.deah000,t0.deah001,t0.deah014,t0.deahseq,t1.ooial003 ", 
 
                  " FROM deah_t t0",
                  "  ",
                                 " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=t0.deah001 AND t1.ooial002='"||g_dlang||"' ",
 
                  " WHERE t0.deahent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("deah_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY deahdocno,deahseq ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照deahdocno,deah000,deah001,'',deah014,deahseq Browser欄位定義(取代原本bs_sql功能)
      #LET g_sql = "SELECT DISTINCT deagstus,deagsite,'',deagdocdt,deahdocno,deag001,deag002,'',deag003,'',deag004,'',deah000,deah001,'',deah014,deahseq,t1.ooial003 ",
       LET g_sql = "SELECT DISTINCT '',deahdocno,deah000,deah001,deah014,deahseq,ooial003",                 
                   " FROM deag_t,deah_t ",
                   " LEFT JOIN deas_t ON deasent = deahent AND deahdocno = deasdocno AND deahseq = deasseq ",
                   " LEFT JOIN ooial_t t1 ON t1.ooialent='"||g_enterprise||"' AND t1.ooial001=deah001 AND t1.ooial002='"||g_lang||"' ",
                   " WHERE deagent = deahent AND deagdocno = deahdocno AND deahent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deah_t"),
                   " ORDER BY deahdocno,deahseq ",g_order
   ELSE
      #單身無輸入資料
      #LET g_sql = "SELECT DISTINCT deagstus,deagsite,'',deagdocdt,deahdocno,deag001,deag002,'',deag003,'',deag004,'',deah000,deah001,'',deah014,deahseq,t1.ooial003 ",
      LET g_sql = "SELECT DISTINCT '',deahdocno,deah000,deah001,deah014,deahseq,ooial003",
                  " FROM deag_t,deah_t ",
                  " LEFT JOIN ooial_t t1 ON t1.ooialent='"||g_enterprise||"' AND t1.ooial001=deah001 AND t1.ooial002='"||g_lang||"' ",
                  " WHERE deagent = deahent AND deagdocno = deahdocno AND deahent = '" ||g_enterprise|| "' AND ", l_wc, cl_sql_add_filter("deah_t"),
                  " ORDER BY deahdocno,deahseq ",g_order
   END IF

   #定義翻頁CURSOR
   #LET g_sql= "SELECT deagstus,deagsite,'',deagdocdt,deahdocno,deag001,deag002,'',deag003,'',deag004,'',deah000,deah001,'',deah014,deahseq FROM (",l_sql_rank,") WHERE ", 
   #           " RANK >= ",1," AND RANK<",1+g_max_browse,
   #           " ORDER BY ",l_searchcol," ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"deah_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_deahdocno,g_browser[g_cnt].b_deah000, 
          g_browser[g_cnt].b_deah001,g_browser[g_cnt].b_deah014,g_browser[g_cnt].b_deahseq,g_browser[g_cnt].b_deah001_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      SELECT deagsite,deagdocdt,deag001,deag002,deag003,deag004
        INTO g_browser[g_cnt].b_deagsite,g_browser[g_cnt].b_deagdocdt,g_browser[g_cnt].b_deag001,g_browser[g_cnt].b_deag002,g_browser[g_cnt].b_deag003,g_browser[g_cnt].b_deag004
        FROM deag_t
       WHERE deagent = g_enterprise
         AND deagdocno = g_browser[g_cnt].b_deahdocno
      
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_deagsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_deagsite_desc = '', g_rtn_fields[1] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_deagsite
      LET g_ref_fields[2] = g_browser[g_cnt].b_deag002
      CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogdsite=? AND oogd001=? ","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_deag002_desc = '', g_rtn_fields[1] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_deag003
      CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_deag003_desc = '', g_rtn_fields[1] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_deag004
      CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_deag004_desc = '', g_rtn_fields[1] , ''
         #end add-point
      
         #遮罩相關處理
         CALL adet416_browser_mask()
      
         
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
   
   IF cl_null(g_browser[g_cnt].b_deahdocno) THEN
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
 
{<section id="adet416.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adet416_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_deah_m.deahdocno = g_browser[g_current_idx].b_deahdocno   
   LET g_deah_m.deahseq = g_browser[g_current_idx].b_deahseq   
 
   EXECUTE adet416_master_referesh USING g_deah_m.deahdocno,g_deah_m.deahseq INTO g_deah_m.deahdocno, 
       g_deah_m.deahseq,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah015,g_deah_m.deah014
   
   CALL adet416_deah_t_mask()
   CALL adet416_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adet416.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adet416_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adet416_ui_browser_refresh()
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
      IF g_browser[l_i].b_deahdocno = g_deah_m.deahdocno 
         AND g_browser[l_i].b_deahseq = g_deah_m.deahseq 
 
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
 
{<section id="adet416.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adet416_construct()
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
   INITIALIZE g_deah_m.* TO NULL
   CALL g_deas_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON deagsite,deagsite_desc,deagdocdt,deahdocno,deahseq,deag001,deag002,deag002_desc, 
          deag003,deag003_desc,deag004,deag004_desc,deah000,deah001,deah015,deas002_sum,deah014
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deagsite
            #add-point:BEFORE FIELD deagsite name="construct.b.deagsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deagsite
            
            #add-point:AFTER FIELD deagsite name="construct.a.deagsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deagsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deagsite
            #add-point:ON ACTION controlp INFIELD deagsite name="construct.c.deagsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deagsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO deagsite  #顯示到畫面上
            NEXT FIELD deagsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deagsite_desc
            #add-point:BEFORE FIELD deagsite_desc name="construct.b.deagsite_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deagsite_desc
            
            #add-point:AFTER FIELD deagsite_desc name="construct.a.deagsite_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deagsite_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deagsite_desc
            #add-point:ON ACTION controlp INFIELD deagsite_desc name="construct.c.deagsite_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deagdocdt
            #add-point:BEFORE FIELD deagdocdt name="construct.b.deagdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deagdocdt
            
            #add-point:AFTER FIELD deagdocdt name="construct.a.deagdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deagdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deagdocdt
            #add-point:ON ACTION controlp INFIELD deagdocdt name="construct.c.deagdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deahdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deahdocno
            #add-point:ON ACTION controlp INFIELD deahdocno name="construct.c.deahdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_deagdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deahdocno  #顯示到畫面上
            NEXT FIELD deahdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deahdocno
            #add-point:BEFORE FIELD deahdocno name="construct.b.deahdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deahdocno
            
            #add-point:AFTER FIELD deahdocno name="construct.a.deahdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deahseq
            #add-point:BEFORE FIELD deahseq name="construct.b.deahseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deahseq
            
            #add-point:AFTER FIELD deahseq name="construct.a.deahseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deahseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deahseq
            #add-point:ON ACTION controlp INFIELD deahseq name="construct.c.deahseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deag001
            #add-point:BEFORE FIELD deag001 name="construct.b.deag001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deag001
            
            #add-point:AFTER FIELD deag001 name="construct.a.deag001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deag001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deag001
            #add-point:ON ACTION controlp INFIELD deag001 name="construct.c.deag001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deag002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deag002
            #add-point:ON ACTION controlp INFIELD deag002 name="construct.c.deag002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oogd001_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deag002  #顯示到畫面上
            NEXT FIELD deag002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deag002
            #add-point:BEFORE FIELD deag002 name="construct.b.deag002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deag002
            
            #add-point:AFTER FIELD deag002 name="construct.a.deag002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deag002_desc
            #add-point:BEFORE FIELD deag002_desc name="construct.b.deag002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deag002_desc
            
            #add-point:AFTER FIELD deag002_desc name="construct.a.deag002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deag002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deag002_desc
            #add-point:ON ACTION controlp INFIELD deag002_desc name="construct.c.deag002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deag003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deag003
            #add-point:ON ACTION controlp INFIELD deag003 name="construct.c.deag003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pcaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deag003  #顯示到畫面上
            NEXT FIELD deag003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deag003
            #add-point:BEFORE FIELD deag003 name="construct.b.deag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deag003
            
            #add-point:AFTER FIELD deag003 name="construct.a.deag003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deag003_desc
            #add-point:BEFORE FIELD deag003_desc name="construct.b.deag003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deag003_desc
            
            #add-point:AFTER FIELD deag003_desc name="construct.a.deag003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deag003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deag003_desc
            #add-point:ON ACTION controlp INFIELD deag003_desc name="construct.c.deag003_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deag004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deag004
            #add-point:ON ACTION controlp INFIELD deag004 name="construct.c.deag004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deag004  #顯示到畫面上
            NEXT FIELD deag004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deag004
            #add-point:BEFORE FIELD deag004 name="construct.b.deag004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deag004
            
            #add-point:AFTER FIELD deag004 name="construct.a.deag004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deag004_desc
            #add-point:BEFORE FIELD deag004_desc name="construct.b.deag004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deag004_desc
            
            #add-point:AFTER FIELD deag004_desc name="construct.a.deag004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deag004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deag004_desc
            #add-point:ON ACTION controlp INFIELD deag004_desc name="construct.c.deag004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deah000
            #add-point:BEFORE FIELD deah000 name="construct.b.deah000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deah000
            
            #add-point:AFTER FIELD deah000 name="construct.a.deah000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deah000
            #add-point:ON ACTION controlp INFIELD deah000 name="construct.c.deah000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deah001
            #add-point:ON ACTION controlp INFIELD deah001 name="construct.c.deah001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001_03()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deah001  #顯示到畫面上
            NEXT FIELD deah001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deah001
            #add-point:BEFORE FIELD deah001 name="construct.b.deah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deah001
            
            #add-point:AFTER FIELD deah001 name="construct.a.deah001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deah015
            #add-point:BEFORE FIELD deah015 name="construct.b.deah015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deah015
            
            #add-point:AFTER FIELD deah015 name="construct.a.deah015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deah015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deah015
            #add-point:ON ACTION controlp INFIELD deah015 name="construct.c.deah015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas002_sum
            #add-point:BEFORE FIELD deas002_sum name="construct.b.deas002_sum"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas002_sum
            
            #add-point:AFTER FIELD deas002_sum name="construct.a.deas002_sum"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deas002_sum
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas002_sum
            #add-point:ON ACTION controlp INFIELD deas002_sum name="construct.c.deas002_sum"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deah014
            #add-point:BEFORE FIELD deah014 name="construct.b.deah014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deah014
            
            #add-point:AFTER FIELD deah014 name="construct.a.deah014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deah014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deah014
            #add-point:ON ACTION controlp INFIELD deah014 name="construct.c.deah014"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON deasseq1,deas001,deas002,deas006,deas003,deas004,deas005
           FROM s_detail1[1].deasseq1,s_detail1[1].deas001,s_detail1[1].deas002,s_detail1[1].deas006, 
               s_detail1[1].deas003,s_detail1[1].deas004,s_detail1[1].deas005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deasseq1
            #add-point:BEFORE FIELD deasseq1 name="construct.b.page1.deasseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deasseq1
            
            #add-point:AFTER FIELD deasseq1 name="construct.a.page1.deasseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deasseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deasseq1
            #add-point:ON ACTION controlp INFIELD deasseq1 name="construct.c.page1.deasseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas001
            #add-point:BEFORE FIELD deas001 name="construct.b.page1.deas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas001
            
            #add-point:AFTER FIELD deas001 name="construct.a.page1.deas001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deas001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas001
            #add-point:ON ACTION controlp INFIELD deas001 name="construct.c.page1.deas001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas002
            #add-point:BEFORE FIELD deas002 name="construct.b.page1.deas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas002
            
            #add-point:AFTER FIELD deas002 name="construct.a.page1.deas002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deas002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas002
            #add-point:ON ACTION controlp INFIELD deas002 name="construct.c.page1.deas002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas006
            #add-point:BEFORE FIELD deas006 name="construct.b.page1.deas006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas006
            
            #add-point:AFTER FIELD deas006 name="construct.a.page1.deas006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deas006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas006
            #add-point:ON ACTION controlp INFIELD deas006 name="construct.c.page1.deas006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas003
            #add-point:BEFORE FIELD deas003 name="construct.b.page1.deas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas003
            
            #add-point:AFTER FIELD deas003 name="construct.a.page1.deas003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deas003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas003
            #add-point:ON ACTION controlp INFIELD deas003 name="construct.c.page1.deas003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas004
            #add-point:BEFORE FIELD deas004 name="construct.b.page1.deas004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas004
            
            #add-point:AFTER FIELD deas004 name="construct.a.page1.deas004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deas004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas004
            #add-point:ON ACTION controlp INFIELD deas004 name="construct.c.page1.deas004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas005
            #add-point:BEFORE FIELD deas005 name="construct.b.page1.deas005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas005
            
            #add-point:AFTER FIELD deas005 name="construct.a.page1.deas005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas005
            #add-point:ON ACTION controlp INFIELD deas005 name="construct.c.page1.deas005"
            
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
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "deah_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "deas_t" 
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION adet416_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
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
      CONSTRUCT g_wc_filter ON deahdocno,deah000,deah001,deah014,deahseq
                          FROM s_browse[1].b_deahdocno,s_browse[1].b_deah000,s_browse[1].b_deah001,s_browse[1].b_deah014, 
                              s_browse[1].b_deahseq
 
         BEFORE CONSTRUCT
               DISPLAY adet416_filter_parser('deahdocno') TO s_browse[1].b_deahdocno
            DISPLAY adet416_filter_parser('deah000') TO s_browse[1].b_deah000
            DISPLAY adet416_filter_parser('deah001') TO s_browse[1].b_deah001
            DISPLAY adet416_filter_parser('deah014') TO s_browse[1].b_deah014
            DISPLAY adet416_filter_parser('deahseq') TO s_browse[1].b_deahseq
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
 
      CALL adet416_filter_show('deahdocno')
   CALL adet416_filter_show('deah000')
   CALL adet416_filter_show('deah001')
   CALL adet416_filter_show('deah014')
   CALL adet416_filter_show('deahseq')
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adet416_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="adet416.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adet416_filter_show(ps_field)
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
   LET ls_condition = adet416_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adet416_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
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
   CALL g_deas_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adet416_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adet416_browser_fill("")
      CALL adet416_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL adet416_filter_show('deahdocno')
   CALL adet416_filter_show('deah000')
   CALL adet416_filter_show('deah001')
   CALL adet416_filter_show('deah014')
   CALL adet416_filter_show('deahseq')
   CALL adet416_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adet416_fetch("F") 
      #顯示單身筆數
      CALL adet416_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adet416_fetch(p_flag)
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_deah_m.deahdocno = g_browser[g_current_idx].b_deahdocno
   LET g_deah_m.deahseq = g_browser[g_current_idx].b_deahseq
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adet416_master_referesh USING g_deah_m.deahdocno,g_deah_m.deahseq INTO g_deah_m.deahdocno, 
       g_deah_m.deahseq,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah015,g_deah_m.deah014
   
   #遮罩相關處理
   LET g_deah_m_mask_o.* =  g_deah_m.*
   CALL adet416_deah_t_mask()
   LET g_deah_m_mask_n.* =  g_deah_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet416_set_act_visible()   
   CALL adet416_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   SELECT UNIQUE deagsite,deagdocdt,deag001,deag002,deag003,deag004
     INTO g_deah_m.deagsite,g_deah_m.deagdocdt,g_deah_m.deag001,g_deah_m.deag002,g_deah_m.deag003,g_deah_m.deag004 
     FROM deag_t
    WHERE deagent = g_enterprise AND deagdocno = g_deah_m.deahdocno 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "deag_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_deah_m.* TO NULL
      RETURN
   END IF
   CALL adet416_deas002_sum()
   CALL adet416_act_visible()
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   IF cl_null(g_deah_m.deah014) THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF 
   #end add-point
   
   #保存單頭舊值
   LET g_deah_m_t.* = g_deah_m.*
   LET g_deah_m_o.* = g_deah_m.*
   
   
   #重新顯示   
   CALL adet416_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.insert" >}
#+ 資料新增
PRIVATE FUNCTION adet416_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_deas_d.clear()   
 
 
   INITIALIZE g_deah_m.* TO NULL             #DEFAULT 設定
   
   LET g_deahdocno_t = NULL
   LET g_deahseq_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_deah_m.deagsite = g_site
      LET g_deah_m.deagdocdt = g_today
      LET g_deah_m.deah000 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_deah_m_t.* = g_deah_m.*
      LET g_deah_m_o.* = g_deah_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL adet416_input("a")
      
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
         INITIALIZE g_deah_m.* TO NULL
         INITIALIZE g_deas_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adet416_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_deas_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet416_set_act_visible()   
   CALL adet416_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deahdocno_t = g_deah_m.deahdocno
   LET g_deahseq_t = g_deah_m.deahseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " deahent = " ||g_enterprise|| " AND",
                      " deahdocno = '", g_deah_m.deahdocno, "' "
                      ," AND deahseq = '", g_deah_m.deahseq, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet416_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adet416_cl
   
   CALL adet416_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adet416_master_referesh USING g_deah_m.deahdocno,g_deah_m.deahseq INTO g_deah_m.deahdocno, 
       g_deah_m.deahseq,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah015,g_deah_m.deah014
   
   
   #遮罩相關處理
   LET g_deah_m_mask_o.* =  g_deah_m.*
   CALL adet416_deah_t_mask()
   LET g_deah_m_mask_n.* =  g_deah_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deah_m.deagsite,g_deah_m.deagsite_desc,g_deah_m.deagdocdt,g_deah_m.deahdocno,g_deah_m.deahseq, 
       g_deah_m.deag001,g_deah_m.deag002,g_deah_m.deag002_desc,g_deah_m.deag003,g_deah_m.deag003_desc, 
       g_deah_m.deag004,g_deah_m.deag004_desc,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah001_desc, 
       g_deah_m.deah015,g_deah_m.deas002_sum,g_deah_m.deah014
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL adet416_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.modify" >}
#+ 資料修改
PRIVATE FUNCTION adet416_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
 
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_deah_m_t.* = g_deah_m.*
   LET g_deah_m_o.* = g_deah_m.*
   
   IF g_deah_m.deahdocno IS NULL
   OR g_deah_m.deahseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_deahdocno_t = g_deah_m.deahdocno
   LET g_deahseq_t = g_deah_m.deahseq
 
   CALL s_transaction_begin()
   
   OPEN adet416_cl USING g_enterprise,g_deah_m.deahdocno,g_deah_m.deahseq
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet416_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet416_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet416_master_referesh USING g_deah_m.deahdocno,g_deah_m.deahseq INTO g_deah_m.deahdocno, 
       g_deah_m.deahseq,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah015,g_deah_m.deah014
   
   #檢查是否允許此動作
   IF NOT adet416_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deah_m_mask_o.* =  g_deah_m.*
   CALL adet416_deah_t_mask()
   LET g_deah_m_mask_n.* =  g_deah_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   CALL adet416_deas002_sum()
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL adet416_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_deahdocno_t = g_deah_m.deahdocno
      LET g_deahseq_t = g_deah_m.deahseq
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adet416_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_deah_m.* = g_deah_m_t.*
            CALL adet416_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_deah_m.deahdocno != g_deah_m_t.deahdocno
      OR g_deah_m.deahseq != g_deah_m_t.deahseq
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE deas_t SET deasdocno = g_deah_m.deahdocno
                                       ,deasseq = g_deah_m.deahseq
 
          WHERE deasent = g_enterprise AND deasdocno = g_deah_m_t.deahdocno
            AND deasseq = g_deah_m_t.deahseq
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "deas_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deas_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet416_set_act_visible()   
   CALL adet416_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " deahent = " ||g_enterprise|| " AND",
                      " deahdocno = '", g_deah_m.deahdocno, "' "
                      ," AND deahseq = '", g_deah_m.deahseq, "' "
 
   #填到對應位置
   CALL adet416_browser_fill("")
 
   CLOSE adet416_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet416_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adet416.input" >}
#+ 資料輸入
PRIVATE FUNCTION adet416_input(p_cmd)
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
   DISPLAY BY NAME g_deah_m.deagsite,g_deah_m.deagsite_desc,g_deah_m.deagdocdt,g_deah_m.deahdocno,g_deah_m.deahseq, 
       g_deah_m.deag001,g_deah_m.deag002,g_deah_m.deag002_desc,g_deah_m.deag003,g_deah_m.deag003_desc, 
       g_deah_m.deag004,g_deah_m.deag004_desc,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah001_desc, 
       g_deah_m.deah015,g_deah_m.deas002_sum,g_deah_m.deah014
   
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
   LET g_forupd_sql = "SELECT deasseq1,deas001,deas002,deas006,deas003,deas004,deas005 FROM deas_t WHERE  
       deasent=? AND deasdocno=? AND deasseq=? AND deasseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet416_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adet416_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adet416_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_deah_m.deahseq
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adet416.input.head" >}
      #單頭段
      INPUT BY NAME g_deah_m.deahseq 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adet416_cl USING g_enterprise,g_deah_m.deahdocno,g_deah_m.deahseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet416_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet416_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adet416_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL adet416_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deahseq
            #add-point:BEFORE FIELD deahseq name="input.b.deahseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deahseq
            
            #add-point:AFTER FIELD deahseq name="input.a.deahseq"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_deah_m.deahdocno) AND NOT cl_null(g_deah_m.deahseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_deah_m.deahdocno != g_deahdocno_t  OR g_deah_m.deahseq != g_deahseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deah_t WHERE "||"deahent = '" ||g_enterprise|| "' AND "||"deahdocno = '"||g_deah_m.deahdocno ||"' AND "|| "deahseq = '"||g_deah_m.deahseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deahseq
            #add-point:ON CHANGE deahseq name="input.g.deahseq"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deahseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deahseq
            #add-point:ON ACTION controlp INFIELD deahseq name="input.c.deahseq"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_deah_m.deahdocno,g_deah_m.deahseq
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO deah_t (deahent,deahdocno,deahseq,deah000,deah001,deah015,deah014)
               VALUES (g_enterprise,g_deah_m.deahdocno,g_deah_m.deahseq,g_deah_m.deah000,g_deah_m.deah001, 
                   g_deah_m.deah015,g_deah_m.deah014) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_deah_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL adet416_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adet416_b_fill()
                  CALL adet416_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL adet416_deah_t_mask_restore('restore_mask_o')
               
               UPDATE deah_t SET (deahdocno,deahseq,deah000,deah001,deah015,deah014) = (g_deah_m.deahdocno, 
                   g_deah_m.deahseq,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah015,g_deah_m.deah014) 
 
                WHERE deahent = g_enterprise AND deahdocno = g_deahdocno_t
                  AND deahseq = g_deahseq_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "deah_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adet416_deah_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_deah_m_t)
               LET g_log2 = util.JSON.stringify(g_deah_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_deahdocno_t = g_deah_m.deahdocno
            LET g_deahseq_t = g_deah_m.deahseq
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adet416.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_deas_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_deas_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adet416_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_deas_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #是否有審帳資料
            SELECT COUNT(*)
              INTO l_cnt
              FROM gcbj_t
             WHERE gcbjent = g_enterprise
               AND gcbjdocno = g_deah_m.deahdocno
               AND gcbjseq = g_deah_m.deahseq
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ade-00031"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN
            ELSE
               #是否有未審帳資料
               SELECT COUNT(*)
                 INTO l_cnt
                 FROM gcbj_t
                WHERE gcbjent = g_enterprise
                  AND gcbjdocno = g_deah_m.deahdocno
                  AND gcbjseq = g_deah_m.deahseq
                  AND gcbj008 = "1"
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ade-00032"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN
               END IF
            END IF
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
            OPEN adet416_cl USING g_enterprise,g_deah_m.deahdocno,g_deah_m.deahseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet416_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet416_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_deas_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_deas_d[l_ac].deasseq1 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_deas_d_t.* = g_deas_d[l_ac].*  #BACKUP
               LET g_deas_d_o.* = g_deas_d[l_ac].*  #BACKUP
               CALL adet416_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL adet416_set_no_entry_b(l_cmd)
               IF NOT adet416_lock_b("deas_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adet416_bcl INTO g_deas_d[l_ac].deasseq1,g_deas_d[l_ac].deas001,g_deas_d[l_ac].deas002, 
                      g_deas_d[l_ac].deas006,g_deas_d[l_ac].deas003,g_deas_d[l_ac].deas004,g_deas_d[l_ac].deas005 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deas_d_t.deasseq1,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_deas_d_mask_o[l_ac].* =  g_deas_d[l_ac].*
                  CALL adet416_deas_t_mask()
                  LET g_deas_d_mask_n[l_ac].* =  g_deas_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adet416_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
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
            INITIALIZE g_deas_d[l_ac].* TO NULL 
            INITIALIZE g_deas_d_t.* TO NULL 
            INITIALIZE g_deas_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_deas_d_t.* = g_deas_d[l_ac].*     #新輸入資料
            LET g_deas_d_o.* = g_deas_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adet416_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL adet416_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_deas_d[li_reproduce_target].* = g_deas_d[li_reproduce].*
 
               LET g_deas_d[li_reproduce_target].deasseq1 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(deasseq1)+1 INTO g_deas_d[l_ac].deasseq1 FROM deas_t 
             WHERE deasent = g_enterprise 
               AND deasdocno = g_deah_m.deahdocno
               AND deasseq = g_deah_m.deahseq
            IF cl_null(g_deas_d[l_ac].deasseq1) THEN
               LET g_deas_d[l_ac].deasseq1 = 1
            END IF
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
            SELECT COUNT(1) INTO l_count FROM deas_t 
             WHERE deasent = g_enterprise AND deasdocno = g_deah_m.deahdocno
               AND deasseq = g_deah_m.deahseq
 
               AND deasseq1 = g_deas_d[l_ac].deasseq1
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deah_m.deahdocno
               LET gs_keys[2] = g_deah_m.deahseq
               LET gs_keys[3] = g_deas_d[g_detail_idx].deasseq1
               CALL adet416_insert_b('deas_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_deas_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deas_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adet416_b_fill()
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
               LET gs_keys[01] = g_deah_m.deahdocno
               LET gs_keys[gs_keys.getLength()+1] = g_deah_m.deahseq
 
               LET gs_keys[gs_keys.getLength()+1] = g_deas_d_t.deasseq1
 
            
               #刪除同層單身
               IF NOT adet416_delete_b('deas_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet416_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adet416_key_delete_b(gs_keys,'deas_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet416_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adet416_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_deas_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_deas_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deasseq1
            #add-point:BEFORE FIELD deasseq1 name="input.b.page1.deasseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deasseq1
            
            #add-point:AFTER FIELD deasseq1 name="input.a.page1.deasseq1"
            #此段落由子樣板a05產生
            IF  g_deah_m.deahdocno IS NOT NULL AND g_deah_m.deahseq IS NOT NULL AND g_deas_d[g_detail_idx].deasseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_deah_m.deahdocno != g_deahdocno_t OR g_deah_m.deahseq != g_deahseq_t OR g_deas_d[g_detail_idx].deasseq1 != g_deas_d_t.deasseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deas_t WHERE "||"deasent = '" ||g_enterprise|| "' AND "||"deasdocno = '"||g_deah_m.deahdocno ||"' AND "|| "deasseq = '"||g_deah_m.deahseq ||"' AND "|| "deasseq1 = '"||g_deas_d[g_detail_idx].deasseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deasseq1
            #add-point:ON CHANGE deasseq1 name="input.g.page1.deasseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas001
            #add-point:BEFORE FIELD deas001 name="input.b.page1.deas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas001
            
            #add-point:AFTER FIELD deas001 name="input.a.page1.deas001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deas001
            #add-point:ON CHANGE deas001 name="input.g.page1.deas001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas002
            #add-point:BEFORE FIELD deas002 name="input.b.page1.deas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas002
            
            #add-point:AFTER FIELD deas002 name="input.a.page1.deas002"
            IF NOT cl_null(g_deas_d[l_ac].deas002) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deas002
            #add-point:ON CHANGE deas002 name="input.g.page1.deas002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas006
            #add-point:BEFORE FIELD deas006 name="input.b.page1.deas006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas006
            
            #add-point:AFTER FIELD deas006 name="input.a.page1.deas006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deas006
            #add-point:ON CHANGE deas006 name="input.g.page1.deas006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas003
            #add-point:BEFORE FIELD deas003 name="input.b.page1.deas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas003
            
            #add-point:AFTER FIELD deas003 name="input.a.page1.deas003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deas003
            #add-point:ON CHANGE deas003 name="input.g.page1.deas003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas004
            #add-point:BEFORE FIELD deas004 name="input.b.page1.deas004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas004
            
            #add-point:AFTER FIELD deas004 name="input.a.page1.deas004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deas004
            #add-point:ON CHANGE deas004 name="input.g.page1.deas004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deas005
            #add-point:BEFORE FIELD deas005 name="input.b.page1.deas005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deas005
            
            #add-point:AFTER FIELD deas005 name="input.a.page1.deas005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deas005
            #add-point:ON CHANGE deas005 name="input.g.page1.deas005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.deasseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deasseq1
            #add-point:ON ACTION controlp INFIELD deasseq1 name="input.c.page1.deasseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deas001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas001
            #add-point:ON ACTION controlp INFIELD deas001 name="input.c.page1.deas001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deas002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas002
            #add-point:ON ACTION controlp INFIELD deas002 name="input.c.page1.deas002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deas006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas006
            #add-point:ON ACTION controlp INFIELD deas006 name="input.c.page1.deas006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deas003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas003
            #add-point:ON ACTION controlp INFIELD deas003 name="input.c.page1.deas003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deas004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas004
            #add-point:ON ACTION controlp INFIELD deas004 name="input.c.page1.deas004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deas005
            #add-point:ON ACTION controlp INFIELD deas005 name="input.c.page1.deas005"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_deas_d[l_ac].* = g_deas_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adet416_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_deas_d[l_ac].deasseq1 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_deas_d[l_ac].* = g_deas_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adet416_deas_t_mask_restore('restore_mask_o')
      
               UPDATE deas_t SET (deasdocno,deasseq,deasseq1,deas001,deas002,deas006,deas003,deas004, 
                   deas005) = (g_deah_m.deahdocno,g_deah_m.deahseq,g_deas_d[l_ac].deasseq1,g_deas_d[l_ac].deas001, 
                   g_deas_d[l_ac].deas002,g_deas_d[l_ac].deas006,g_deas_d[l_ac].deas003,g_deas_d[l_ac].deas004, 
                   g_deas_d[l_ac].deas005)
                WHERE deasent = g_enterprise AND deasdocno = g_deah_m.deahdocno 
                  AND deasseq = g_deah_m.deahseq 
 
                  AND deasseq1 = g_deas_d_t.deasseq1 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_deas_d[l_ac].* = g_deas_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deas_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_deas_d[l_ac].* = g_deas_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deas_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deah_m.deahdocno
               LET gs_keys_bak[1] = g_deahdocno_t
               LET gs_keys[2] = g_deah_m.deahseq
               LET gs_keys_bak[2] = g_deahseq_t
               LET gs_keys[3] = g_deas_d[g_detail_idx].deasseq1
               LET gs_keys_bak[3] = g_deas_d_t.deasseq1
               CALL adet416_update_b('deas_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adet416_deas_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_deas_d[g_detail_idx].deasseq1 = g_deas_d_t.deasseq1 
 
                  ) THEN
                  LET gs_keys[01] = g_deah_m.deahdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_deah_m.deahseq
 
                  LET gs_keys[gs_keys.getLength()+1] = g_deas_d_t.deasseq1
 
                  CALL adet416_key_update_b(gs_keys,'deas_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_deah_m),util.JSON.stringify(g_deas_d_t)
               LET g_log2 = util.JSON.stringify(g_deah_m),util.JSON.stringify(g_deas_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            CALL adet416_deas002_sum()
            DISPLAY BY NAME g_deah_m.deas002_sum
            #end add-point
            CALL adet416_unlock_b("deas_t","'1'")
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
               LET g_deas_d[li_reproduce_target].* = g_deas_d[li_reproduce].*
 
               LET g_deas_d[li_reproduce_target].deasseq1 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_deas_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_deas_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="adet416.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         CALL adet416_act_visible()
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD deahdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD deasseq1
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adet416_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adet416_b_fill() #單身填充
      CALL adet416_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adet416_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

   CALL adet416_deah001_ref()
   CALL adet416_deagsite_ref()
   CALL adet416_deag002_ref()
   CALL adet416_deag003_ref()
   CALL adet416_deag004_ref()
   #end add-point
   
   #遮罩相關處理
   LET g_deah_m_mask_o.* =  g_deah_m.*
   CALL adet416_deah_t_mask()
   LET g_deah_m_mask_n.* =  g_deah_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_deah_m.deagsite,g_deah_m.deagsite_desc,g_deah_m.deagdocdt,g_deah_m.deahdocno,g_deah_m.deahseq, 
       g_deah_m.deag001,g_deah_m.deag002,g_deah_m.deag002_desc,g_deah_m.deag003,g_deah_m.deag003_desc, 
       g_deah_m.deag004,g_deah_m.deag004_desc,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah001_desc, 
       g_deah_m.deah015,g_deah_m.deas002_sum,g_deah_m.deah014
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_deas_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adet416_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adet416_detail_show()
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
 
{<section id="adet416.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adet416_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE deah_t.deahdocno 
   DEFINE l_oldno     LIKE deah_t.deahdocno 
   DEFINE l_newno02     LIKE deah_t.deahseq 
   DEFINE l_oldno02     LIKE deah_t.deahseq 
 
   DEFINE l_master    RECORD LIKE deah_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE deas_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_deah_m.deahdocno IS NULL
   OR g_deah_m.deahseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_deahdocno_t = g_deah_m.deahdocno
   LET g_deahseq_t = g_deah_m.deahseq
 
    
   LET g_deah_m.deahdocno = ""
   LET g_deah_m.deahseq = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   CALL adet416_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_deah_m.* TO NULL
      INITIALIZE g_deas_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adet416_show()
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
   CALL adet416_set_act_visible()   
   CALL adet416_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deahdocno_t = g_deah_m.deahdocno
   LET g_deahseq_t = g_deah_m.deahseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " deahent = " ||g_enterprise|| " AND",
                      " deahdocno = '", g_deah_m.deahdocno, "' "
                      ," AND deahseq = '", g_deah_m.deahseq, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet416_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adet416_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL adet416_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adet416_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE deas_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adet416_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM deas_t
    WHERE deasent = g_enterprise AND deasdocno = g_deahdocno_t
     AND deasseq = g_deahseq_t
 
    INTO TEMP adet416_detail
 
   #將key修正為調整後   
   UPDATE adet416_detail 
      #更新key欄位
      SET deasdocno = g_deah_m.deahdocno
          , deasseq = g_deah_m.deahseq
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO deas_t SELECT * FROM adet416_detail
   
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
   DROP TABLE adet416_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_deahdocno_t = g_deah_m.deahdocno
   LET g_deahseq_t = g_deah_m.deahseq
 
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adet416_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_deah_m.deahdocno IS NULL
   OR g_deah_m.deahseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adet416_cl USING g_enterprise,g_deah_m.deahdocno,g_deah_m.deahseq
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet416_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet416_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet416_master_referesh USING g_deah_m.deahdocno,g_deah_m.deahseq INTO g_deah_m.deahdocno, 
       g_deah_m.deahseq,g_deah_m.deah000,g_deah_m.deah001,g_deah_m.deah015,g_deah_m.deah014
   
   
   #檢查是否允許此動作
   IF NOT adet416_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deah_m_mask_o.* =  g_deah_m.*
   CALL adet416_deah_t_mask()
   LET g_deah_m_mask_n.* =  g_deah_m.*
   
   CALL adet416_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adet416_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_deahdocno_t = g_deah_m.deahdocno
      LET g_deahseq_t = g_deah_m.deahseq
 
 
      DELETE FROM deah_t
       WHERE deahent = g_enterprise AND deahdocno = g_deah_m.deahdocno
         AND deahseq = g_deah_m.deahseq
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_deah_m.deahdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM deas_t
       WHERE deasent = g_enterprise AND deasdocno = g_deah_m.deahdocno
         AND deasseq = g_deah_m.deahseq
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deas_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_deah_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adet416_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_deas_d.clear() 
 
     
      CALL adet416_ui_browser_refresh()  
      #CALL adet416_ui_headershow()  
      #CALL adet416_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adet416_browser_fill("")
         CALL adet416_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adet416_cl
 
   #功能已完成,通報訊息中心
   CALL adet416_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adet416.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adet416_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_deas_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF adet416_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT deasseq1,deas001,deas002,deas006,deas003,deas004,deas005  FROM deas_t", 
                
                     " INNER JOIN deah_t ON deahent = " ||g_enterprise|| " AND deahdocno = deasdocno ",
                     " AND deahseq = deasseq ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE deasent=? AND deasdocno=? AND deasseq=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY deas_t.deasseq1"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adet416_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adet416_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_deah_m.deahdocno,g_deah_m.deahseq   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_deah_m.deahdocno,g_deah_m.deahseq INTO g_deas_d[l_ac].deasseq1, 
          g_deas_d[l_ac].deas001,g_deas_d[l_ac].deas002,g_deas_d[l_ac].deas006,g_deas_d[l_ac].deas003, 
          g_deas_d[l_ac].deas004,g_deas_d[l_ac].deas005   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_deas_d.deleteElement(g_deas_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adet416_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_deas_d.getLength()
      LET g_deas_d_mask_o[l_ac].* =  g_deas_d[l_ac].*
      CALL adet416_deas_t_mask()
      LET g_deas_d_mask_n[l_ac].* =  g_deas_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adet416_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM deas_t
       WHERE deasent = g_enterprise AND
         deasdocno = ps_keys_bak[1] AND deasseq = ps_keys_bak[2] AND deasseq1 = ps_keys_bak[3]
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
         CALL g_deas_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adet416_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO deas_t
                  (deasent,
                   deasdocno,deasseq,
                   deasseq1
                   ,deas001,deas002,deas006,deas003,deas004,deas005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_deas_d[g_detail_idx].deas001,g_deas_d[g_detail_idx].deas002,g_deas_d[g_detail_idx].deas006, 
                       g_deas_d[g_detail_idx].deas003,g_deas_d[g_detail_idx].deas004,g_deas_d[g_detail_idx].deas005) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deas_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_deas_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adet416_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "deas_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adet416_deas_t_mask_restore('restore_mask_o')
               
      UPDATE deas_t 
         SET (deasdocno,deasseq,
              deasseq1
              ,deas001,deas002,deas006,deas003,deas004,deas005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_deas_d[g_detail_idx].deas001,g_deas_d[g_detail_idx].deas002,g_deas_d[g_detail_idx].deas006, 
                  g_deas_d[g_detail_idx].deas003,g_deas_d[g_detail_idx].deas004,g_deas_d[g_detail_idx].deas005)  
 
         WHERE deasent = g_enterprise AND deasdocno = ps_keys_bak[1] AND deasseq = ps_keys_bak[2] AND deasseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deas_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deas_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adet416_deas_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adet416_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="adet416.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adet416_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adet416.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adet416_lock_b(ps_table,ps_page)
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
   #CALL adet416_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "deas_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adet416_bcl USING g_enterprise,
                                       g_deah_m.deahdocno,g_deah_m.deahseq,g_deas_d[g_detail_idx].deasseq1  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adet416_bcl:",SQLERRMESSAGE 
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
 
{<section id="adet416.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adet416_unlock_b(ps_table,ps_page)
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
      CLOSE adet416_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adet416_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("deahdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("deahdocno,deahseq",TRUE)
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
 
{<section id="adet416.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adet416_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("deahdocno,deahseq",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("deahdocno",FALSE)
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
 
{<section id="adet416.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adet416_set_entry_b(p_cmd)
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
 
{<section id="adet416.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adet416_set_no_entry_b(p_cmd)
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
 
{<section id="adet416.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adet416_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet416.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adet416_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet416.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adet416_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet416.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adet416_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet416.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adet416_default_search()
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
      LET ls_wc = ls_wc, " deahdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " deahseq = '", g_argv[02], "' AND "
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "deah_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "deas_t" 
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
   
   #add-point:default_search段結束前 name="default_search.after"
 
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.state_change" >}
   
 
{</section>}
 
{<section id="adet416.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adet416_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_deas_d.getLength() THEN
         LET g_detail_idx = g_deas_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_deas_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_deas_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adet416_b_fill2(pi_idx)
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
   
   CALL adet416_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adet416_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adet416.status_show" >}
PRIVATE FUNCTION adet416_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adet416.mask_functions" >}
&include "erp/ade/adet416_mask.4gl"
 
{</section>}
 
{<section id="adet416.signature" >}
   
 
{</section>}
 
{<section id="adet416.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adet416_set_pk_array()
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
   LET g_pk_array[1].values = g_deah_m.deahdocno
   LET g_pk_array[1].column = 'deahdocno'
   LET g_pk_array[2].values = g_deah_m.deahseq
   LET g_pk_array[2].column = 'deahseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet416.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adet416.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adet416_msgcentre_notify(lc_state)
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
   CALL adet416_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_deah_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet416.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adet416_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet416.other_function" readonly="Y" >}

PRIVATE FUNCTION adet416_deah001_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_deah_m.deah001
      CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_deah_m.deah001_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_deah_m.deah001_desc
END FUNCTION

PRIVATE FUNCTION adet416_deagsite_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_deah_m.deagsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_deah_m.deagsite_desc = '', g_rtn_fields[1] , ''
END FUNCTION

PRIVATE FUNCTION adet416_deag003_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_deah_m.deag003
      CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_deah_m.deag003_desc = '', g_rtn_fields[1] , ''
END FUNCTION

PRIVATE FUNCTION adet416_deag002_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_deah_m.deagsite
      LET g_ref_fields[2] = g_deah_m.deag002
      CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogdsite=? AND oogd001=? ","") RETURNING g_rtn_fields
      LET g_deah_m.deag002_desc = '', g_rtn_fields[1] , ''
END FUNCTION

PRIVATE FUNCTION adet416_deas002_sum()
   SELECT SUM(deas002)
     INTO g_deah_m.deas002_sum
     FROM deas_t
    WHERE deasent = g_enterprise
      AND deasdocno = g_deah_m.deahdocno 
      AND deasseq = g_deah_m.deahseq
   IF cl_null(g_deah_m.deas002_sum) THEN
      LET g_deah_m.deas002_sum = 0
   END IF
END FUNCTION

PRIVATE FUNCTION adet416_act_visible()
   CALL cl_set_act_visible("confirm,unconfirm", FALSE)
   IF cl_null(g_deah_m.deah014) THEN
      CALL cl_set_act_visible("confirm", TRUE)
   ELSE
      CALL cl_set_act_visible("unconfirm", TRUE)
   END IF
END FUNCTION

PRIVATE FUNCTION adet416_deag004_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_deah_m.deag004
      CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
      LET g_deah_m.deag004_desc = '', g_rtn_fields[1] , ''
END FUNCTION

PRIVATE FUNCTION adet416_update_gcao(p_act,p_deahdocno,p_deahseq)
   DEFINE p_act       LIKE type_t.chr20
   DEFINE p_deahdocno LIKE deah_t.deahdocno
   DEFINE p_deahseq   LIKE deah_t.deahseq
   DEFINE l_deahsite  LIKE deah_t.deahsite   #160819-00054#4 20161005 add by beckxie
   DEFINE l_i         LIKE type_t.num5 
   DEFINE l_gcao005   LIKE gcao_t.gcao005
   DEFINE l_gcbj      RECORD
             gcbj001  LIKE gcbj_t.gcbj001,
             gcbj003  LIKE gcbj_t.gcbj003,
             gcbj008  LIKE gcbj_t.gcbj008,
             gcbj009  LIKE gcbj_t.gcbj009,   #160819-00054#4 20161005 add by beckxie
             gcbj010  LIKE gcbj_t.gcbj010    #160819-00054#4 20161005 add by beckxie
             END RECORD
   
   DECLARE adeq415_cl1 CURSOR FOR 
   SELECT gcbj001,gcbj003,gcbj008,
          gcbj009,gcbj010   #160819-00054#4 20161005 add(gcbj009,gcbj010) by beckxie
     FROM gcbj_t
    WHERE gcbjent = g_enterprise
      AND gcbjdocno = p_deahdocno
      AND gcbjseq = p_deahseq
   
   #160819-00054#4 20161005 add by beckxie---S
   SELECT deahsite INTO l_deahsite 
     FROM deah_t
    WHERE deahent = g_enterprise 
      AND deahdocno = p_deahdocno
      AND deahseq = p_deahseq
   #160819-00054#4 20161005 add by beckxie---E
   
   FOREACH adeq415_cl1 INTO l_gcbj.gcbj001,l_gcbj.gcbj003,l_gcbj.gcbj008,
                            l_gcbj.gcbj009,l_gcbj.gcbj010   #160819-00054#4 20161005 add(gcbj009,gcbj010) by beckxie
      IF p_act = 'conf' THEN
            LET l_gcao005 = '7'
      ELSE
         LET l_gcao005 = l_gcbj.gcbj003
      END IF
      
      #160819-00054#4 20160912 add by beckxie---S
      IF p_act = 'conf' AND l_gcao005 = '7' THEN
         UPDATE gcao_t
            SET gcao005 = l_gcao005,
                gcao023 = l_gcbj.gcbj009,      #紀錄核銷營運組織　　　 
                gcao024 = l_gcbj.gcbj010,      #紀錄核銷日期　　　　　
                gcao025 = l_deahsite,          #紀錄核銷異動營運組織　
                gcao043 = p_deahdocno          #紀錄核銷紀錄的異動單據
          WHERE gcaoent = g_enterprise
            AND gcao001 = l_gcbj.gcbj001
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd gcao_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      ELSE
      #160819-00054#4 20160912 add by beckxie---E
         UPDATE gcao_t
            SET gcao005 = l_gcao005,
                gcao023 = '',  #清空   #160819-00054#4 20161005 add by beckxie
                gcao024 = '',  #清空   #160819-00054#4 20161005 add by beckxie
                gcao025 = '',  #清空   #160819-00054#4 20161005 add by beckxie
                gcao043 = ''   #清空   #160819-00054#4 20161005 add by beckxie
          WHERE gcaoent = g_enterprise
            AND gcao001 = l_gcbj.gcbj001
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd gcao_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END IF   #160819-00054#4 20160912 add by beckxie
      
   END FOREACH
END FUNCTION

 
{</section>}
 