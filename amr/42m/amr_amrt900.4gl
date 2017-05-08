#該程式未解開Section, 採用最新樣板產出!
{<section id="amrt900.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2017-01-23 11:33:05), PR版次:0006(2016-12-01 15:53:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: amrt900
#+ Description: 資源盤點作業
#+ Creator....: 02574(2015-06-25 14:40:10)
#+ Modifier...: 08992 -SD/PR- 08171
 
{</section>}
 
{<section id="amrt900.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#23   16/04/22 BY 07900   校验代码重复错误讯息的修改
#160818-00017#24 2016-08-22 By 08734 删除修改未重新判断状态码
#160902-00048#1    16/09/05 By dorislai 修正SQL少ent的問題
#161109-00085#2  2016/11/10 By 08993 整批調整系統星號寫法
#161109-00085#61 2016/11/25 By 08171 整批調整系統星號寫法
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
PRIVATE type type_g_mrea_m        RECORD
       mreadocno LIKE mrea_t.mreadocno, 
   mreadocno_desc LIKE type_t.chr80, 
   mrea003 LIKE mrea_t.mrea003, 
   mreadocdt LIKE mrea_t.mreadocdt, 
   mrea001 LIKE mrea_t.mrea001, 
   mrea001_desc LIKE type_t.chr80, 
   mrea002 LIKE mrea_t.mrea002, 
   mrea002_desc LIKE type_t.chr80, 
   mreastus LIKE mrea_t.mreastus
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mreb_d        RECORD
       mrebseq LIKE mreb_t.mrebseq, 
   mreb001 LIKE mreb_t.mreb001, 
   mreb001_desc LIKE type_t.chr500, 
   mreb001_desc_desc LIKE type_t.chr20, 
   mreb002 LIKE mreb_t.mreb002, 
   mreb003 LIKE mreb_t.mreb003, 
   mreb003_desc LIKE type_t.chr500, 
   mreb004 LIKE mreb_t.mreb004, 
   mreb004_desc LIKE type_t.chr500, 
   mreb005 LIKE mreb_t.mreb005, 
   mreb006 LIKE mreb_t.mreb006, 
   mreb007 LIKE mreb_t.mreb007, 
   mreb008 LIKE mreb_t.mreb008, 
   mreb009 LIKE mreb_t.mreb009, 
   mreb010 LIKE mreb_t.mreb010, 
   mreb010_desc LIKE type_t.chr500, 
   mreb011 LIKE mreb_t.mreb011, 
   mreb011_desc LIKE type_t.chr500, 
   mreb012 LIKE mreb_t.mreb012, 
   mreb013 LIKE mreb_t.mreb013, 
   mreb014 LIKE mreb_t.mreb014, 
   mreb015 LIKE mreb_t.mreb015
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mreadocno LIKE mrea_t.mreadocno,
      b_mreadocdt LIKE mrea_t.mreadocdt,
      b_mrea001 LIKE mrea_t.mrea001,
   b_mrea001_desc LIKE type_t.chr80,
      b_mrea002 LIKE mrea_t.mrea002,
   b_mrea002_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_mrea_m          type_g_mrea_m
DEFINE g_mrea_m_t        type_g_mrea_m
DEFINE g_mrea_m_o        type_g_mrea_m
DEFINE g_mrea_m_mask_o   type_g_mrea_m #轉換遮罩前資料
DEFINE g_mrea_m_mask_n   type_g_mrea_m #轉換遮罩後資料
 
   DEFINE g_mreadocno_t LIKE mrea_t.mreadocno
 
 
DEFINE g_mreb_d          DYNAMIC ARRAY OF type_g_mreb_d
DEFINE g_mreb_d_t        type_g_mreb_d
DEFINE g_mreb_d_o        type_g_mreb_d
DEFINE g_mreb_d_mask_o   DYNAMIC ARRAY OF type_g_mreb_d #轉換遮罩前資料
DEFINE g_mreb_d_mask_n   DYNAMIC ARRAY OF type_g_mreb_d #轉換遮罩後資料
 
 
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
 
{<section id="amrt900.main" >}
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
   CALL cl_ap_init("amr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mreadocno,'',mrea003,mreadocdt,mrea001,'',mrea002,'',mreastus", 
                      " FROM mrea_t",
                      " WHERE mreaent= ? AND mreadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt900_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mreadocno,t0.mrea003,t0.mreadocdt,t0.mrea001,t0.mrea002,t0.mreastus, 
       t1.ooag011 ,t2.ooefl003",
               " FROM mrea_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrea001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrea002 AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.mreaent = " ||g_enterprise|| " AND t0.mreadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amrt900_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrt900 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrt900_init()   
 
      #進入選單 Menu (="N")
      CALL amrt900_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amrt900
      
   END IF 
   
   CLOSE amrt900_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amrt900.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amrt900_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
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
      CALL cl_set_combo_scc_part('mreastus','13','N,Y,X,S')
 
      CALL cl_set_combo_scc('mreb007','3088') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible("mrebseq", FALSE)
   #end add-point
   
   #初始化搜尋條件
   CALL amrt900_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amrt900.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amrt900_ui_dialog()
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
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL amrt900_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_mrea_m.* TO NULL
         CALL g_mreb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrt900_init()
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
               
               CALL amrt900_fetch('') # reload data
               LET l_ac = 1
               CALL amrt900_ui_detailshow() #Setting the current row 
         
               CALL amrt900_idx_chk()
               #NEXT FIELD mrebseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mreb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt900_idx_chk()
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
               CALL amrt900_idx_chk()
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
            CALL amrt900_browser_fill("")
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
               CALL amrt900_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amrt900_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amrt900_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amrt900_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amrt900_set_act_visible()   
            CALL amrt900_set_act_no_visible()
            IF NOT (g_mrea_m.mreadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mreaent = " ||g_enterprise|| " AND",
                                  " mreadocno = '", g_mrea_m.mreadocno, "' "
 
               #填到對應位置
               CALL amrt900_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mrea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mreb_t" 
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
               CALL amrt900_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mrea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mreb_t" 
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
                  CALL amrt900_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amrt900_fetch("F")
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
               CALL amrt900_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amrt900_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt900_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amrt900_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt900_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amrt900_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt900_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amrt900_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt900_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amrt900_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt900_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mreb_d)
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
               NEXT FIELD mrebseq
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL amrt900_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amrt900_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amrt900_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amrt900_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amr/amrt900_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amr/amrt900_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amrt900_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amrt900_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amrt900_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amrt900_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amrt900_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mrea_m.mreadocdt)
 
 
 
         
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
 
{<section id="amrt900.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amrt900_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
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
      LET l_sub_sql = " SELECT DISTINCT mreadocno ",
                      " FROM mrea_t ",
                      " ",
                      " LEFT JOIN mreb_t ON mrebent = mreaent AND mreadocno = mrebdocno ", "  ",
                      #add-point:browser_fill段sql(mreb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE mreaent = " ||g_enterprise|| " AND mrebent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mreadocno ",
                      " FROM mrea_t ", 
                      "  ",
                      "  ",
                      " WHERE mreaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mrea_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
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
      INITIALIZE g_mrea_m.* TO NULL
      CALL g_mreb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mreadocno,t0.mreadocdt,t0.mrea001,t0.mrea002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mreastus,t0.mreadocno,t0.mreadocdt,t0.mrea001,t0.mrea002,t1.ooag011 , 
          t2.ooefl003 ",
                  " FROM mrea_t t0",
                  "  ",
                  "  LEFT JOIN mreb_t ON mrebent = mreaent AND mreadocno = mrebdocno ", "  ", 
                  #add-point:browser_fill段sql(mreb_t1) name="browser_fill.join.mreb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrea001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrea002 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mreaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mrea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mreastus,t0.mreadocno,t0.mreadocdt,t0.mrea001,t0.mrea002,t1.ooag011 , 
          t2.ooefl003 ",
                  " FROM mrea_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrea001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrea002 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mreaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mrea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mreadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mreadocno,g_browser[g_cnt].b_mreadocdt, 
          g_browser[g_cnt].b_mrea001,g_browser[g_cnt].b_mrea002,g_browser[g_cnt].b_mrea001_desc,g_browser[g_cnt].b_mrea002_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL amrt900_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         
      END CASE
 
 
 
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
   
   IF cl_null(g_browser[g_cnt].b_mreadocno) THEN
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
 
{<section id="amrt900.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amrt900_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrea_m.mreadocno = g_browser[g_current_idx].b_mreadocno   
 
   EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
       g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
       g_mrea_m.mrea002_desc
   
   CALL amrt900_mrea_t_mask()
   CALL amrt900_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amrt900.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amrt900_ui_detailshow()
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
 
{<section id="amrt900.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amrt900_ui_browser_refresh()
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
      IF g_browser[l_i].b_mreadocno = g_mrea_m.mreadocno 
 
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
 
{<section id="amrt900.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrt900_construct()
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
   INITIALIZE g_mrea_m.* TO NULL
   CALL g_mreb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mreadocno,mrea003,mreadocdt,mrea001,mrea002,mreastus
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mreacrtdt>>----
 
         #----<<mreamoddt>>----
         
         #----<<mreacnfdt>>----
         
         #----<<mreapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mreadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreadocno
            #add-point:ON ACTION controlp INFIELD mreadocno name="construct.c.mreadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mreadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mreadocno  #顯示到畫面上
            NEXT FIELD mreadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreadocno
            #add-point:BEFORE FIELD mreadocno name="construct.b.mreadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreadocno
            
            #add-point:AFTER FIELD mreadocno name="construct.a.mreadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrea003
            #add-point:BEFORE FIELD mrea003 name="construct.b.mrea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrea003
            
            #add-point:AFTER FIELD mrea003 name="construct.a.mrea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrea003
            #add-point:ON ACTION controlp INFIELD mrea003 name="construct.c.mrea003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreadocdt
            #add-point:BEFORE FIELD mreadocdt name="construct.b.mreadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreadocdt
            
            #add-point:AFTER FIELD mreadocdt name="construct.a.mreadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mreadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreadocdt
            #add-point:ON ACTION controlp INFIELD mreadocdt name="construct.c.mreadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrea001
            #add-point:ON ACTION controlp INFIELD mrea001 name="construct.c.mrea001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrea001  #顯示到畫面上
            NEXT FIELD mrea001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrea001
            #add-point:BEFORE FIELD mrea001 name="construct.b.mrea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrea001
            
            #add-point:AFTER FIELD mrea001 name="construct.a.mrea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrea002
            #add-point:ON ACTION controlp INFIELD mrea002 name="construct.c.mrea002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrea002  #顯示到畫面上
            NEXT FIELD mrea002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrea002
            #add-point:BEFORE FIELD mrea002 name="construct.b.mrea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrea002
            
            #add-point:AFTER FIELD mrea002 name="construct.a.mrea002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreastus
            #add-point:BEFORE FIELD mreastus name="construct.b.mreastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreastus
            
            #add-point:AFTER FIELD mreastus name="construct.a.mreastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mreastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreastus
            #add-point:ON ACTION controlp INFIELD mreastus name="construct.c.mreastus"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mrebseq,mreb001,mreb002,mreb003,mreb004,mreb005,mreb006,mreb007,mreb008, 
          mreb009,mreb010,mreb011,mreb012,mreb013,mreb014,mreb015
           FROM s_detail1[1].mrebseq,s_detail1[1].mreb001,s_detail1[1].mreb002,s_detail1[1].mreb003, 
               s_detail1[1].mreb004,s_detail1[1].mreb005,s_detail1[1].mreb006,s_detail1[1].mreb007,s_detail1[1].mreb008, 
               s_detail1[1].mreb009,s_detail1[1].mreb010,s_detail1[1].mreb011,s_detail1[1].mreb012,s_detail1[1].mreb013, 
               s_detail1[1].mreb014,s_detail1[1].mreb015
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrebseq
            #add-point:BEFORE FIELD mrebseq name="construct.b.page1.mrebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrebseq
            
            #add-point:AFTER FIELD mrebseq name="construct.a.page1.mrebseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrebseq
            #add-point:ON ACTION controlp INFIELD mrebseq name="construct.c.page1.mrebseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mreb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb001
            #add-point:ON ACTION controlp INFIELD mreb001 name="construct.c.page1.mreb001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mreb001  #顯示到畫面上
            NEXT FIELD mreb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb001
            #add-point:BEFORE FIELD mreb001 name="construct.b.page1.mreb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb001
            
            #add-point:AFTER FIELD mreb001 name="construct.a.page1.mreb001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb002
            #add-point:BEFORE FIELD mreb002 name="construct.b.page1.mreb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb002
            
            #add-point:AFTER FIELD mreb002 name="construct.a.page1.mreb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb002
            #add-point:ON ACTION controlp INFIELD mreb002 name="construct.c.page1.mreb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mreb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb003
            #add-point:ON ACTION controlp INFIELD mreb003 name="construct.c.page1.mreb003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mreb003  #顯示到畫面上
            NEXT FIELD mreb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb003
            #add-point:BEFORE FIELD mreb003 name="construct.b.page1.mreb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb003
            
            #add-point:AFTER FIELD mreb003 name="construct.a.page1.mreb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb004
            #add-point:ON ACTION controlp INFIELD mreb004 name="construct.c.page1.mreb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mreb004  #顯示到畫面上
            NEXT FIELD mreb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb004
            #add-point:BEFORE FIELD mreb004 name="construct.b.page1.mreb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb004
            
            #add-point:AFTER FIELD mreb004 name="construct.a.page1.mreb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb005
            #add-point:BEFORE FIELD mreb005 name="construct.b.page1.mreb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb005
            
            #add-point:AFTER FIELD mreb005 name="construct.a.page1.mreb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb005
            #add-point:ON ACTION controlp INFIELD mreb005 name="construct.c.page1.mreb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb006
            #add-point:BEFORE FIELD mreb006 name="construct.b.page1.mreb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb006
            
            #add-point:AFTER FIELD mreb006 name="construct.a.page1.mreb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb006
            #add-point:ON ACTION controlp INFIELD mreb006 name="construct.c.page1.mreb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb007
            #add-point:BEFORE FIELD mreb007 name="construct.b.page1.mreb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb007
            
            #add-point:AFTER FIELD mreb007 name="construct.a.page1.mreb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb007
            #add-point:ON ACTION controlp INFIELD mreb007 name="construct.c.page1.mreb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb008
            #add-point:BEFORE FIELD mreb008 name="construct.b.page1.mreb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb008
            
            #add-point:AFTER FIELD mreb008 name="construct.a.page1.mreb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb008
            #add-point:ON ACTION controlp INFIELD mreb008 name="construct.c.page1.mreb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb009
            #add-point:BEFORE FIELD mreb009 name="construct.b.page1.mreb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb009
            
            #add-point:AFTER FIELD mreb009 name="construct.a.page1.mreb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb009
            #add-point:ON ACTION controlp INFIELD mreb009 name="construct.c.page1.mreb009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mreb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb010
            #add-point:ON ACTION controlp INFIELD mreb010 name="construct.c.page1.mreb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mreb010  #顯示到畫面上
            NEXT FIELD mreb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb010
            #add-point:BEFORE FIELD mreb010 name="construct.b.page1.mreb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb010
            
            #add-point:AFTER FIELD mreb010 name="construct.a.page1.mreb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb011
            #add-point:ON ACTION controlp INFIELD mreb011 name="construct.c.page1.mreb011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mreb011  #顯示到畫面上
            NEXT FIELD mreb011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb011
            #add-point:BEFORE FIELD mreb011 name="construct.b.page1.mreb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb011
            
            #add-point:AFTER FIELD mreb011 name="construct.a.page1.mreb011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb012
            #add-point:BEFORE FIELD mreb012 name="construct.b.page1.mreb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb012
            
            #add-point:AFTER FIELD mreb012 name="construct.a.page1.mreb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb012
            #add-point:ON ACTION controlp INFIELD mreb012 name="construct.c.page1.mreb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb013
            #add-point:BEFORE FIELD mreb013 name="construct.b.page1.mreb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb013
            
            #add-point:AFTER FIELD mreb013 name="construct.a.page1.mreb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb013
            #add-point:ON ACTION controlp INFIELD mreb013 name="construct.c.page1.mreb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb014
            #add-point:BEFORE FIELD mreb014 name="construct.b.page1.mreb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb014
            
            #add-point:AFTER FIELD mreb014 name="construct.a.page1.mreb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb014
            #add-point:ON ACTION controlp INFIELD mreb014 name="construct.c.page1.mreb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb015
            #add-point:BEFORE FIELD mreb015 name="construct.b.page1.mreb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb015
            
            #add-point:AFTER FIELD mreb015 name="construct.a.page1.mreb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mreb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb015
            #add-point:ON ACTION controlp INFIELD mreb015 name="construct.c.page1.mreb015"
            
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
                  WHEN la_wc[li_idx].tableid = "mrea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mreb_t" 
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
 
{<section id="amrt900.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amrt900_filter()
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
      CONSTRUCT g_wc_filter ON mreadocno,mreadocdt,mrea001,mrea002
                          FROM s_browse[1].b_mreadocno,s_browse[1].b_mreadocdt,s_browse[1].b_mrea001, 
                              s_browse[1].b_mrea002
 
         BEFORE CONSTRUCT
               DISPLAY amrt900_filter_parser('mreadocno') TO s_browse[1].b_mreadocno
            DISPLAY amrt900_filter_parser('mreadocdt') TO s_browse[1].b_mreadocdt
            DISPLAY amrt900_filter_parser('mrea001') TO s_browse[1].b_mrea001
            DISPLAY amrt900_filter_parser('mrea002') TO s_browse[1].b_mrea002
      
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
 
      CALL amrt900_filter_show('mreadocno')
   CALL amrt900_filter_show('mreadocdt')
   CALL amrt900_filter_show('mrea001')
   CALL amrt900_filter_show('mrea002')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amrt900_filter_parser(ps_field)
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
 
{<section id="amrt900.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amrt900_filter_show(ps_field)
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
   LET ls_condition = amrt900_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amrt900_query()
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
   CALL g_mreb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amrt900_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amrt900_browser_fill("")
      CALL amrt900_fetch("")
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
      CALL amrt900_filter_show('mreadocno')
   CALL amrt900_filter_show('mreadocdt')
   CALL amrt900_filter_show('mrea001')
   CALL amrt900_filter_show('mrea002')
   CALL amrt900_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amrt900_fetch("F") 
      #顯示單身筆數
      CALL amrt900_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amrt900_fetch(p_flag)
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
   
   LET g_mrea_m.mreadocno = g_browser[g_current_idx].b_mreadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
       g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
       g_mrea_m.mrea002_desc
   
   #遮罩相關處理
   LET g_mrea_m_mask_o.* =  g_mrea_m.*
   CALL amrt900_mrea_t_mask()
   LET g_mrea_m_mask_n.* =  g_mrea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt900_set_act_visible()   
   CALL amrt900_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrea_m_t.* = g_mrea_m.*
   LET g_mrea_m_o.* = g_mrea_m.*
   
   
   #重新顯示   
   CALL amrt900_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.insert" >}
#+ 資料新增
PRIVATE FUNCTION amrt900_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mreb_d.clear()   
 
 
   INITIALIZE g_mrea_m.* TO NULL             #DEFAULT 設定
   
   LET g_mreadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrea_m.mreastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_mrea_m.mrea001 = g_user
      CALL s_desc_get_person_desc(g_mrea_m.mrea001) RETURNING g_mrea_m.mrea001_desc
      DISPLAY BY NAME g_mrea_m.mrea001_desc
      LET g_mrea_m.mrea002 = g_dept
      CALL s_desc_get_department_desc(g_mrea_m.mrea002) RETURNING g_mrea_m.mrea002_desc
      DISPLAY BY NAME g_mrea_m.mrea002_desc
      LET g_mrea_m.mrea003 = g_today
      LET g_mrea_m.mreadocdt  = g_today
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mrea_m_t.* = g_mrea_m.*
      LET g_mrea_m_o.* = g_mrea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrea_m.mreastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         
      END CASE
 
 
 
    
      CALL amrt900_input("a")
      
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
         INITIALIZE g_mrea_m.* TO NULL
         INITIALIZE g_mreb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amrt900_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mreb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt900_set_act_visible()   
   CALL amrt900_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mreadocno_t = g_mrea_m.mreadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mreaent = " ||g_enterprise|| " AND",
                      " mreadocno = '", g_mrea_m.mreadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt900_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amrt900_cl
   
   CALL amrt900_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
       g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
       g_mrea_m.mrea002_desc
   
   
   #遮罩相關處理
   LET g_mrea_m_mask_o.* =  g_mrea_m.*
   CALL amrt900_mrea_t_mask()
   LET g_mrea_m_mask_n.* =  g_mrea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrea_m.mreadocno,g_mrea_m.mreadocno_desc,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001, 
       g_mrea_m.mrea001_desc,g_mrea_m.mrea002,g_mrea_m.mrea002_desc,g_mrea_m.mreastus
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL amrt900_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.modify" >}
#+ 資料修改
PRIVATE FUNCTION amrt900_modify()
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
   LET g_mrea_m_t.* = g_mrea_m.*
   LET g_mrea_m_o.* = g_mrea_m.*
   
   IF g_mrea_m.mreadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mreadocno_t = g_mrea_m.mreadocno
 
   CALL s_transaction_begin()
   
   OPEN amrt900_cl USING g_enterprise,g_mrea_m.mreadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt900_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt900_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
       g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
       g_mrea_m.mrea002_desc
   
   #檢查是否允許此動作
   IF NOT amrt900_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrea_m_mask_o.* =  g_mrea_m.*
   CALL amrt900_mrea_t_mask()
   LET g_mrea_m_mask_n.* =  g_mrea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL amrt900_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mreadocno_t = g_mrea_m.mreadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amrt900_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mrea_m.* = g_mrea_m_t.*
            CALL amrt900_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mrea_m.mreadocno != g_mrea_m_t.mreadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mreb_t SET mrebdocno = g_mrea_m.mreadocno
 
          WHERE mrebent = g_enterprise AND mrebdocno = g_mrea_m_t.mreadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mreb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mreb_t:",SQLERRMESSAGE 
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
   CALL amrt900_set_act_visible()   
   CALL amrt900_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mreaent = " ||g_enterprise|| " AND",
                      " mreadocno = '", g_mrea_m.mreadocno, "' "
 
   #填到對應位置
   CALL amrt900_browser_fill("")
 
   CLOSE amrt900_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt900_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amrt900.input" >}
#+ 資料輸入
PRIVATE FUNCTION amrt900_input(p_cmd)
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
   DEFINE l_ooef004              LIKE ooef_t.ooef004  
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_str                  STRING
   DEFINE l_flag                 LIKE type_t.num5
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
   DISPLAY BY NAME g_mrea_m.mreadocno,g_mrea_m.mreadocno_desc,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001, 
       g_mrea_m.mrea001_desc,g_mrea_m.mrea002,g_mrea_m.mrea002_desc,g_mrea_m.mreastus
   
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
   LET g_forupd_sql = "SELECT mrebseq,mreb001,mreb002,mreb003,mreb004,mreb005,mreb006,mreb007,mreb008, 
       mreb009,mreb010,mreb011,mreb012,mreb013,mreb014,mreb015 FROM mreb_t WHERE mrebent=? AND mrebdocno=?  
       AND mrebseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt900_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amrt900_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amrt900_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mrea_m.mreadocno,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002, 
       g_mrea_m.mreastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = TRUE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amrt900.input.head" >}
      #單頭段
      INPUT BY NAME g_mrea_m.mreadocno,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002, 
          g_mrea_m.mreastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amrt900_cl USING g_enterprise,g_mrea_m.mreadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt900_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt900_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amrt900_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL amrt900_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreadocno
            
            #add-point:AFTER FIELD mreadocno name="input.a.mreadocno"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_mrea_m.mreadocno) THEN 
                CALL s_aooi200_get_slip_desc(g_mrea_m.mreadocno) RETURNING g_mrea_m.mreadocno_desc
                DISPLAY BY NAME g_mrea_m.mreadocno_desc
   
               IF cl_null(g_mrea_m.mreadocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00324'   #單號欄位不可為空！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrea_m.mreadocno != g_mreadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrea_t WHERE "||"mreaent = '" ||g_enterprise|| "' AND "||"mreadocno = '"||g_mrea_m.mreadocno ||"'",'std-00004',0) THEN 
                     LET g_mrea_m.mreadocno = g_mreadocno_t
                     CALL s_aooi200_get_slip_desc(g_mrea_m.mreadocno) RETURNING g_mrea_m.mreadocno_desc
                     DISPLAY BY NAME g_mrea_m.mreadocno_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF g_mrea_m.mreadocno <> g_mrea_m_o.mreadocno OR cl_null(g_mrea_m_o.mreadocno) THEN
                  #檢查單別
                  IF NOT s_aooi200_chk_slip(g_site,'',g_mrea_m.mreadocno,g_prog) THEN
                     LET g_mrea_m.mreadocno = g_mrea_m_o.mreadocno

                     CALL s_aooi200_get_slip_desc(g_mrea_m.mreadocno) RETURNING g_mrea_m.mreadocno_desc
                     DISPLAY BY NAME g_mrea_m.mreadocno_desc

                     NEXT FIELD CURRENT
                  END IF
            
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用,'5' 為庫存控制組類型
                  CALL s_control_chk_doc('1',g_mrea_m.mreadocno,'5',g_user,g_dept,'','') RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_mrea_m.mreadocno = g_mrea_m_o.mreadocno
                     CALL s_aooi200_get_slip_desc(g_mrea_m.mreadocno) RETURNING g_mrea_m.mreadocno_desc
                     DISPLAY BY NAME g_mrea_m.mreadocno_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_mrea_m.mreadocno_desc = NULL
               DISPLAY BY NAME g_mrea_m.mreadocno_desc 
            END IF
            LET g_mrea_m_o.mreadocno = g_mrea_m.mreadocno


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreadocno
            #add-point:BEFORE FIELD mreadocno name="input.b.mreadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreadocno
            #add-point:ON CHANGE mreadocno name="input.g.mreadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrea003
            #add-point:BEFORE FIELD mrea003 name="input.b.mrea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrea003
            
            #add-point:AFTER FIELD mrea003 name="input.a.mrea003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrea003
            #add-point:ON CHANGE mrea003 name="input.g.mrea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreadocdt
            #add-point:BEFORE FIELD mreadocdt name="input.b.mreadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreadocdt
            
            #add-point:AFTER FIELD mreadocdt name="input.a.mreadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreadocdt
            #add-point:ON CHANGE mreadocdt name="input.g.mreadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrea001
            
            #add-point:AFTER FIELD mrea001 name="input.a.mrea001"
            IF NOT cl_null(g_mrea_m.mrea001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mrea_m.mrea001

                #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#23  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_mrea_m.mrea001 = g_mrea_m_t.mrea001
                  LET g_mrea_m.mrea001_desc = g_mrea_m_t.mrea001_desc
                  DISPLAY BY NAME g_mrea_m.mrea001_desc,g_mrea_m.mrea001
                  NEXT FIELD CURRENT
               END IF
               
               #帶出歸屬部門ooag003
                  SELECT ooag003 INTO g_mrea_m.mrea002
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_mrea_m.mrea001
               
                  DISPLAY BY NAME g_mrea_m.mrea002

                  CALL s_desc_get_department_desc(g_mrea_m.mrea002) RETURNING g_mrea_m.mrea002_desc
                  DISPLAY BY NAME g_mrea_m.mrea002_desc
            ELSE
               LET g_mrea_m.mrea001_desc = NULL
               DISPLAY BY NAME g_mrea_m.mrea001_desc
            END IF 
            CALL s_desc_get_person_desc(g_mrea_m.mrea001) RETURNING g_mrea_m.mrea001_desc
            
            DISPLAY BY NAME g_mrea_m.mrea001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrea001
            #add-point:BEFORE FIELD mrea001 name="input.b.mrea001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrea001
            #add-point:ON CHANGE mrea001 name="input.g.mrea001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrea002
            
            #add-point:AFTER FIELD mrea002 name="input.a.mrea002"
            IF NOT cl_null(g_mrea_m.mrea002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mrea_m.mrea002
               LET g_chkparam.arg2 = g_mrea_m.mreadocdt
               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#23  by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_mrea_m.mrea002 = g_mrea_m_t.mrea002
                  LET g_mrea_m.mrea002_desc = g_mrea_m_t.mrea002_desc
                  DISPLAY BY NAME g_mrea_m.mrea002_desc,g_mrea_m.mrea002
                  NEXT FIELD CURRENT
               END IF


            END IF 
            CALL s_desc_get_department_desc(g_mrea_m.mrea002) RETURNING g_mrea_m.mrea002_desc
            DISPLAY BY NAME g_mrea_m.mrea002_desc



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrea002
            #add-point:BEFORE FIELD mrea002 name="input.b.mrea002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrea002
            #add-point:ON CHANGE mrea002 name="input.g.mrea002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreastus
            #add-point:BEFORE FIELD mreastus name="input.b.mreastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreastus
            
            #add-point:AFTER FIELD mreastus name="input.a.mreastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreastus
            #add-point:ON CHANGE mreastus name="input.g.mreastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mreadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreadocno
            #add-point:ON ACTION controlp INFIELD mreadocno name="input.c.mreadocno"
           #add-point:ON ACTION controlp INFIELD mreadocno
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrea_m.mreadocno             #給予default值

            #給予arg
            LET l_ooef004 = ''
            SELECT ooef004 
              INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise 
               AND ooef001 = g_site 
               AND ooefstus = 'Y'
            LET g_qryparam.arg1 = l_ooef004 #s
            LET g_qryparam.arg2 = g_prog    #s

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mrea_m.mreadocno = g_qryparam.return1              

            DISPLAY g_mrea_m.mreadocno TO mreadocno              #
            CALL s_aooi200_get_slip_desc(g_mrea_m.mreadocno) RETURNING g_mrea_m.mreadocno_desc
            DISPLAY BY NAME g_mrea_m.mreadocno_desc
            NEXT FIELD mreadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrea003
            #add-point:ON ACTION controlp INFIELD mrea003 name="input.c.mrea003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mreadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreadocdt
            #add-point:ON ACTION controlp INFIELD mreadocdt name="input.c.mreadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrea001
            #add-point:ON ACTION controlp INFIELD mrea001 name="input.c.mrea001"
            #add-point:ON ACTION controlp INFIELD mrea001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrea_m.mrea001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_mrea_m.mrea001 = g_qryparam.return1              

            DISPLAY g_mrea_m.mrea001 TO mrea001              #
            CALL s_desc_get_person_desc(g_mrea_m.mrea001) RETURNING g_mrea_m.mrea001_desc
            DISPLAY BY NAME g_mrea_m.mrea001_desc
            NEXT FIELD mrea001                          #返回原欄位
                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrea002
            #add-point:ON ACTION controlp INFIELD mrea002 name="input.c.mrea002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrea_m.mrea002             #給予default值
            LET g_qryparam.default2 = "" #g_mrea_m.ooeg001 #部門編號
            #給予arg
            
            IF NOT cl_null(g_mrea_m.mreadocdt) THEN
               LET g_qryparam.arg1 = g_mrea_m.mreadocdt
            ELSE
               LET g_qryparam.arg1 = g_today
            END IF

            CALL q_ooeg001()                                #呼叫開窗

            LET g_mrea_m.mrea002 = g_qryparam.return1              
            #LET g_mrea_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_mrea_m.mrea002 TO mrea002              #
            #DISPLAY g_mrea_m.ooeg001 TO ooeg001 #部門編號
            CALL s_desc_get_department_desc(g_mrea_m.mrea002) RETURNING g_mrea_m.mrea002_desc
            DISPLAY BY NAME g_mrea_m.mrea002_desc
            NEXT FIELD mrea002                          #返回原欄位
                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mreastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreastus
            #add-point:ON ACTION controlp INFIELD mreastus name="input.c.mreastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mrea_m.mreadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_mrea_m.mreadocno,g_mrea_m.mreadocdt,g_prog)
               RETURNING l_success,g_mrea_m.mreadocno
               IF l_success = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_mrea_m.mreadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD mreadocno
               END IF
               DISPLAY BY NAME g_mrea_m.mreadocno
#               #end add-point
#               
#               INSERT INTO mrea_t (mreaent,mreadocno,mrea003,mreadocdt,mrea001,mrea002,mreastus)
#               VALUES (g_enterprise,g_mrea_m.mreadocno,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001, 
#                   g_mrea_m.mrea002,g_mrea_m.mreastus) 
#               IF SQLCA.SQLCODE THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "g_mrea_m:",SQLERRMESSAGE 
#                  LET g_errparam.code = SQLCA.SQLCODE 
#                  LET g_errparam.popup = TRUE 
#                  CALL s_transaction_end('N','0')
#                  CALL cl_err()
#                  NEXT FIELD CURRENT
#               END IF
#               
#               #add-point:單頭新增中 name="input.head.m_insert"
               INSERT INTO mrea_t (mreaent,mreasite,mreadocno,mrea003,mreadocdt,mrea001,mrea002,mreastus)
               VALUES (g_enterprise,g_site,g_mrea_m.mreadocno,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001, 
                   g_mrea_m.mrea002,g_mrea_m.mreastus) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mrea_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amrt900_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amrt900_b_fill()
                  CALL amrt900_b_fill2('0')
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
               CALL amrt900_mrea_t_mask_restore('restore_mask_o')
               
               UPDATE mrea_t SET (mreadocno,mrea003,mreadocdt,mrea001,mrea002,mreastus) = (g_mrea_m.mreadocno, 
                   g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus) 
 
                WHERE mreaent = g_enterprise AND mreadocno = g_mreadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mrea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amrt900_mrea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mrea_m_t)
               LET g_log2 = util.JSON.stringify(g_mrea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mreadocno_t = g_mrea_m.mreadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amrt900.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mreb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #無單身資料時，QBE開窗自動產生單身。
            CALL amrt900_auto_insert_detail_form()
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mreb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrt900_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mreb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
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
            OPEN amrt900_cl USING g_enterprise,g_mrea_m.mreadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt900_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt900_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mreb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mreb_d[l_ac].mrebseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mreb_d_t.* = g_mreb_d[l_ac].*  #BACKUP
               LET g_mreb_d_o.* = g_mreb_d[l_ac].*  #BACKUP
               CALL amrt900_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amrt900_set_no_entry_b(l_cmd)
               IF NOT amrt900_lock_b("mreb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt900_bcl INTO g_mreb_d[l_ac].mrebseq,g_mreb_d[l_ac].mreb001,g_mreb_d[l_ac].mreb002, 
                      g_mreb_d[l_ac].mreb003,g_mreb_d[l_ac].mreb004,g_mreb_d[l_ac].mreb005,g_mreb_d[l_ac].mreb006, 
                      g_mreb_d[l_ac].mreb007,g_mreb_d[l_ac].mreb008,g_mreb_d[l_ac].mreb009,g_mreb_d[l_ac].mreb010, 
                      g_mreb_d[l_ac].mreb011,g_mreb_d[l_ac].mreb012,g_mreb_d[l_ac].mreb013,g_mreb_d[l_ac].mreb014, 
                      g_mreb_d[l_ac].mreb015
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mreb_d_t.mrebseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mreb_d_mask_o[l_ac].* =  g_mreb_d[l_ac].*
                  CALL amrt900_mreb_t_mask()
                  LET g_mreb_d_mask_n[l_ac].* =  g_mreb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt900_show()
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
            INITIALIZE g_mreb_d[l_ac].* TO NULL 
            INITIALIZE g_mreb_d_t.* TO NULL 
            INITIALIZE g_mreb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mreb_d[l_ac].mreb002 = "0"
      LET g_mreb_d[l_ac].mreb007 = "0"
      LET g_mreb_d[l_ac].mreb008 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            IF cl_null(g_mreb_d[l_ac].mrebseq) THEN
               SELECT MAX(mrebseq)+1
                 INTO g_mreb_d[l_ac].mrebseq
                 FROM mreb_t
                WHERE mrebent = g_enterprise
                  AND mrebdocno = g_mrea_m.mreadocno 

               IF cl_null(g_mreb_d[l_ac].mrebseq) THEN
                 LET g_mreb_d[l_ac].mrebseq = 1
               END IF
            END IF
            #end add-point
            LET g_mreb_d_t.* = g_mreb_d[l_ac].*     #新輸入資料
            LET g_mreb_d_o.* = g_mreb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt900_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
   
            #end add-point
            CALL amrt900_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mreb_d[li_reproduce_target].* = g_mreb_d[li_reproduce].*
 
               LET g_mreb_d[li_reproduce_target].mrebseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            IF g_mreb_d[l_ac].mreb007 = '2' AND (cl_null(g_mreb_d[l_ac].mreb010) AND 
               cl_null(g_mreb_d[l_ac].mreb011) AND 
               cl_null(g_mreb_d[l_ac].mreb012) AND 
               cl_null(g_mreb_d[l_ac].mreb013)) THEN
               INITIALIZE g_mreb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')               
               CANCEL INSERT
            END IF 
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mreb_t 
             WHERE mrebent = g_enterprise AND mrebdocno = g_mrea_m.mreadocno
 
               AND mrebseq = g_mreb_d[l_ac].mrebseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrea_m.mreadocno
               LET gs_keys[2] = g_mreb_d[g_detail_idx].mrebseq
               CALL amrt900_insert_b('mreb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mreb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mreb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt900_b_fill()
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
               LET gs_keys[01] = g_mrea_m.mreadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mreb_d_t.mrebseq
 
            
               #刪除同層單身
               IF NOT amrt900_delete_b('mreb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt900_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrt900_key_delete_b(gs_keys,'mreb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt900_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt900_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mreb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mreb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrebseq
            #add-point:BEFORE FIELD mrebseq name="input.b.page1.mrebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrebseq
            
            #add-point:AFTER FIELD mrebseq name="input.a.page1.mrebseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mrea_m.mreadocno IS NOT NULL AND g_mreb_d[g_detail_idx].mrebseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrea_m.mreadocno != g_mreadocno_t OR g_mreb_d[g_detail_idx].mrebseq != g_mreb_d_t.mrebseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mreb_t WHERE "||"mrebent = '" ||g_enterprise|| "' AND "||"mrebdocno = '"||g_mrea_m.mreadocno ||"' AND "|| "mrebseq = '"||g_mreb_d[g_detail_idx].mrebseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrebseq
            #add-point:ON CHANGE mrebseq name="input.g.page1.mrebseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb001
            
            #add-point:AFTER FIELD mreb001 name="input.a.page1.mreb001"
            IF NOT cl_null(g_mreb_d[l_ac].mreb001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mreb_d[l_ac].mreb001

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
               #160318-00025#23  by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mrba001_4") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_mreb_d[l_ac].mreb001 = g_mreb_d_t.mreb001
                  LET g_mreb_d[l_ac].mreb001_desc = g_mreb_d_t.mreb001_desc
                  LET g_mreb_d[l_ac].mreb001_desc_desc = g_mreb_d_t.mreb001_desc_desc
                  LET g_mreb_d[l_ac].mreb002 = g_mreb_d_t.mreb002 
                  LET g_mreb_d[l_ac].mreb003 = g_mreb_d_t.mreb003
                  LET g_mreb_d[l_ac].mreb004 = g_mreb_d_t.mreb004
                  LET g_mreb_d[l_ac].mreb003_desc = g_mreb_d_t.mreb003_desc
                  LET g_mreb_d[l_ac].mreb004_desc = g_mreb_d_t.mreb004_desc
                  LET g_mreb_d[l_ac].mreb005 = g_mreb_d_t.mreb005
                  LET g_mreb_d[l_ac].mreb006 = g_mreb_d_t.mreb006
                  LET g_mreb_d[l_ac].mreb007 = g_mreb_d_t.mreb007
                  DISPLAY BY NAME g_mreb_d[l_ac].mreb001,g_mreb_d[l_ac].mreb001_desc,
                                  g_mreb_d[l_ac].mreb001_desc_desc,g_mreb_d[l_ac].mreb002,
                                  g_mreb_d[l_ac].mreb003,g_mreb_d[l_ac].mreb004,
                                  g_mreb_d[l_ac].mreb003_desc,g_mreb_d[l_ac].mreb004_desc,
                                  g_mreb_d[l_ac].mreb005,g_mreb_d[l_ac].mreb006,
                                  g_mreb_d[l_ac].mreb007
                  NEXT FIELD CURRENT
               END IF
               #同一資源編號，不可同時存在兩張未過帳的盤點單!  
               IF cl_null(g_mreb_d_t.mreb001) OR g_mreb_d[l_ac].mreb001<> g_mreb_d_t.mreb001 THEN             
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM mrea_t,mreb_t
                   WHERE mreaent = mreaent
                     AND mreadocno = mrebdocno
                     AND mreastus <> 'S'
                     AND mreastus <> 'X'
                     AND mreaent=g_enterprise
                     #AND mreasite = g_site
                     AND((mrebseq <> g_mreb_d[l_ac].mrebseq
                     AND mrebdocno = g_mrea_m.mreadocno)
                     OR  mrebdocno <> g_mrea_m.mreadocno)
                     AND mreb001 = g_mreb_d[l_ac].mreb001
                  IF l_cnt > 0 THEN
         
                     INITIALIZE g_errparam TO NULL
                     #同一資源編號，不可同時存在兩張未過帳的盤點單! 
                     LET g_errparam.code = 'amr-00102'
                     LET g_errparam.extend = g_mreb_d[l_ac].mreb001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_mreb_d[l_ac].mreb001 = g_mreb_d_t.mreb001
                     LET g_mreb_d[l_ac].mreb001_desc = g_mreb_d_t.mreb001_desc
                     LET g_mreb_d[l_ac].mreb001_desc_desc = g_mreb_d_t.mreb001_desc_desc
                     LET g_mreb_d[l_ac].mreb002 = g_mreb_d_t.mreb002 
                     LET g_mreb_d[l_ac].mreb003 = g_mreb_d_t.mreb003
                     LET g_mreb_d[l_ac].mreb004 = g_mreb_d_t.mreb004
                     LET g_mreb_d[l_ac].mreb003_desc = g_mreb_d_t.mreb003_desc
                     LET g_mreb_d[l_ac].mreb004_desc = g_mreb_d_t.mreb004_desc
                     LET g_mreb_d[l_ac].mreb005 = g_mreb_d_t.mreb005
                     LET g_mreb_d[l_ac].mreb006 = g_mreb_d_t.mreb006
                     LET g_mreb_d[l_ac].mreb007 = g_mreb_d_t.mreb007
                     DISPLAY BY NAME g_mreb_d[l_ac].mreb001,g_mreb_d[l_ac].mreb001_desc,
                                     g_mreb_d[l_ac].mreb001_desc_desc,g_mreb_d[l_ac].mreb002,
                                     g_mreb_d[l_ac].mreb003,g_mreb_d[l_ac].mreb004,
                                     g_mreb_d[l_ac].mreb003_desc,g_mreb_d[l_ac].mreb004_desc,
                                     g_mreb_d[l_ac].mreb005,g_mreb_d[l_ac].mreb006,
                                     g_mreb_d[l_ac].mreb007
                     NEXT FIELD CURRENT
                  END IF
               END IF
                         
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_mreb_d[l_ac].mreb001
               CALL ap_ref_array2(g_ref_fields,"SELECT mrba004,mrba008,mrba006,mrba016,mrba017,mrba018,mrba102 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrba001=? ","") RETURNING g_rtn_fields
               LET g_mreb_d[l_ac].mreb001_desc = '', g_rtn_fields[1] , ''
               LET g_mreb_d[l_ac].mreb001_desc_desc = '', g_rtn_fields[2] , ''
               LET l_str = '', g_rtn_fields[3] , ''
               LET l_str = l_str.trim()
               LET g_mreb_d[l_ac].mreb002 = l_str 
               LET g_mreb_d[l_ac].mreb003 = '', g_rtn_fields[4] , ''
               LET g_mreb_d[l_ac].mreb004 = '', g_rtn_fields[5] , ''
               LET g_mreb_d[l_ac].mreb005 = '', g_rtn_fields[6] , ''
               LET g_mreb_d[l_ac].mreb006 = '', g_rtn_fields[7] , ''
               
               CALL s_desc_get_person_desc(g_mreb_d[l_ac].mreb003) RETURNING g_mreb_d[l_ac].mreb003_desc
               CALL s_desc_get_department_desc(g_mreb_d[l_ac].mreb004) RETURNING g_mreb_d[l_ac].mreb004_desc
               DISPLAY BY NAME g_mreb_d[l_ac].mreb001_desc,g_mreb_d[l_ac].mreb001_desc_desc,
                               g_mreb_d[l_ac].mreb002,
                               g_mreb_d[l_ac].mreb003,g_mreb_d[l_ac].mreb004,
                               g_mreb_d[l_ac].mreb003_desc,g_mreb_d[l_ac].mreb004_desc,
                               g_mreb_d[l_ac].mreb005,g_mreb_d[l_ac].mreb006,
                               g_mreb_d[l_ac].mreb007
            ELSE
               LET g_mreb_d[l_ac].mreb001_desc = NULL
               LET g_mreb_d[l_ac].mreb001_desc_desc = NULL
               LET g_mreb_d[l_ac].mreb002 = NULL
               LET g_mreb_d[l_ac].mreb003 = NULL
               LET g_mreb_d[l_ac].mreb004 = NULL
               LET g_mreb_d[l_ac].mreb003_desc = NULL
               LET g_mreb_d[l_ac].mreb004_desc = NULL
               LET g_mreb_d[l_ac].mreb005 = NULL
               LET g_mreb_d[l_ac].mreb006 = NULL
               LET g_mreb_d[l_ac].mreb007 = '0'
               DISPLAY BY NAME g_mreb_d[l_ac].mreb001,g_mreb_d[l_ac].mreb001_desc,
                               g_mreb_d[l_ac].mreb001_desc_desc,g_mreb_d[l_ac].mreb002,
                               g_mreb_d[l_ac].mreb003,g_mreb_d[l_ac].mreb004,
                               g_mreb_d[l_ac].mreb003_desc,g_mreb_d[l_ac].mreb004_desc,
                               g_mreb_d[l_ac].mreb005,g_mreb_d[l_ac].mreb006,
                               g_mreb_d[l_ac].mreb007
            END IF 
            CALL amrt900_set_entry_b(l_cmd)
            CALL amrt900_set_no_entry_b(l_cmd)


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb001
            #add-point:BEFORE FIELD mreb001 name="input.b.page1.mreb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb001
            #add-point:ON CHANGE mreb001 name="input.g.page1.mreb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb007
            #add-point:BEFORE FIELD mreb007 name="input.b.page1.mreb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb007
            
            #add-point:AFTER FIELD mreb007 name="input.a.page1.mreb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb007
            #add-point:ON CHANGE mreb007 name="input.g.page1.mreb007"
            CASE g_mreb_d[l_ac].mreb007
               WHEN '0'
                  LET g_mreb_d[l_ac].mreb008 = NULL
                  LET g_mreb_d[l_ac].mreb009 = NULL
                  LET g_mreb_d[l_ac].mreb010 = NULL
                  LET g_mreb_d[l_ac].mreb011 = NULL
                  LET g_mreb_d[l_ac].mreb012 = NULL
                  LET g_mreb_d[l_ac].mreb013 = NULL
                  LET g_mreb_d[l_ac].mreb014 = NULL
                  LET g_mreb_d[l_ac].mreb015 = NULL
               WHEN '1'
                  LET g_mreb_d[l_ac].mreb008 = NULL
                  LET g_mreb_d[l_ac].mreb009 = NULL
                  LET g_mreb_d[l_ac].mreb010 = NULL
                  LET g_mreb_d[l_ac].mreb011 = NULL
                  LET g_mreb_d[l_ac].mreb012 = NULL
                  LET g_mreb_d[l_ac].mreb013 = NULL
                  LET g_mreb_d[l_ac].mreb014 = g_today
                  LET g_mreb_d[l_ac].mreb015 = TIME
               WHEN '2'
                  LET g_mreb_d[l_ac].mreb014 = g_today
                  LET g_mreb_d[l_ac].mreb015 = TIME
               WHEN '3'
                  LET g_mreb_d[l_ac].mreb008 = NULL
                  LET g_mreb_d[l_ac].mreb009 = NULL
                  LET g_mreb_d[l_ac].mreb010 = NULL
                  LET g_mreb_d[l_ac].mreb011 = NULL
                  LET g_mreb_d[l_ac].mreb012 = NULL
                  LET g_mreb_d[l_ac].mreb013 = NULL
                  LET g_mreb_d[l_ac].mreb014 = g_today
                  LET g_mreb_d[l_ac].mreb015 = TIME
               OTHERWISE
            END CASE
            DISPLAY BY NAME g_mreb_d[l_ac].mreb008,g_mreb_d[l_ac].mreb009,g_mreb_d[l_ac].mreb010,
                            g_mreb_d[l_ac].mreb011,g_mreb_d[l_ac].mreb012,g_mreb_d[l_ac].mreb013,
                            g_mreb_d[l_ac].mreb014,g_mreb_d[l_ac].mreb015
            CALL amrt900_set_entry_b(l_cmd)
            CALL amrt900_set_no_entry_b(l_cmd)   
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mreb_d[l_ac].mreb008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mreb008
            END IF 
 
 
 
            #add-point:AFTER FIELD mreb008 name="input.a.page1.mreb008"
            IF NOT cl_null(g_mreb_d[l_ac].mreb008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb008
            #add-point:BEFORE FIELD mreb008 name="input.b.page1.mreb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb008
            #add-point:ON CHANGE mreb008 name="input.g.page1.mreb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb009
            #add-point:BEFORE FIELD mreb009 name="input.b.page1.mreb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb009
            
            #add-point:AFTER FIELD mreb009 name="input.a.page1.mreb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb009
            #add-point:ON CHANGE mreb009 name="input.g.page1.mreb009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb010
            
            #add-point:AFTER FIELD mreb010 name="input.a.page1.mreb010"
            IF NOT cl_null(g_mreb_d[l_ac].mreb010) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mreb_d[l_ac].mreb010

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#23  by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_mreb_d[l_ac].mreb010 = g_mreb_d_t.mreb010
                  LET g_mreb_d[l_ac].mreb010_desc = g_mreb_d_t.mreb010_desc
                  DISPLAY BY NAME g_mreb_d[l_ac].mreb010_desc,g_mreb_d[l_ac].mreb010
                  NEXT FIELD CURRENT
               END IF
               IF g_mreb_d[l_ac].mreb010 <> g_mreb_d[l_ac].mreb003 THEN
                  LET g_mreb_d[l_ac].mreb007 = '2'
                  DISPLAY BY NAME g_mreb_d[l_ac].mreb007
               END IF

               CALL s_desc_get_person_desc(g_mreb_d[l_ac].mreb010) RETURNING g_mreb_d[l_ac].mreb010_desc
            ELSE
               LET g_mreb_d[l_ac].mreb010_desc = NULL
               DISPLAY BY NAME g_mreb_d[l_ac].mreb010_desc             
            END IF 
            

            CALL amrt900_set_entry_b(l_cmd)
            CALL amrt900_set_no_entry_b(l_cmd) 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb010
            #add-point:BEFORE FIELD mreb010 name="input.b.page1.mreb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb010
            #add-point:ON CHANGE mreb010 name="input.g.page1.mreb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb011
            
            #add-point:AFTER FIELD mreb011 name="input.a.page1.mreb011"
            IF NOT cl_null(g_mreb_d[l_ac].mreb011) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mreb_d[l_ac].mreb011
               LET g_chkparam.arg2 = g_mrea_m.mreadocdt
               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#23  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_mreb_d[l_ac].mreb011 = g_mreb_d_t.mreb011
                  LET g_mreb_d[l_ac].mreb011_desc = g_mreb_d_t.mreb011_desc
                  DISPLAY BY NAME g_mreb_d[l_ac].mreb011_desc,g_mreb_d[l_ac].mreb011
                  NEXT FIELD CURRENT
               END IF
               IF g_mreb_d[l_ac].mreb011 <> g_mreb_d[l_ac].mreb004 THEN
                  LET g_mreb_d[l_ac].mreb007 = '2'
                  DISPLAY BY NAME g_mreb_d[l_ac].mreb007
               END IF
               CALL s_desc_get_department_desc(g_mreb_d[l_ac].mreb011) RETURNING g_mreb_d[l_ac].mreb011_desc
               DISPLAY BY NAME g_mreb_d[l_ac].mreb011_desc,g_mreb_d[l_ac].mreb011
            ELSE
               LET g_mreb_d[l_ac].mreb011_desc =NULL
               DISPLAY BY NAME g_mreb_d[l_ac].mreb011_desc
            END IF 
            CALL amrt900_set_entry_b(l_cmd)
            CALL amrt900_set_no_entry_b(l_cmd) 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb011
            #add-point:BEFORE FIELD mreb011 name="input.b.page1.mreb011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb011
            #add-point:ON CHANGE mreb011 name="input.g.page1.mreb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb012
            #add-point:BEFORE FIELD mreb012 name="input.b.page1.mreb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb012
            
            #add-point:AFTER FIELD mreb012 name="input.a.page1.mreb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb012
            #add-point:ON CHANGE mreb012 name="input.g.page1.mreb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb013
            #add-point:BEFORE FIELD mreb013 name="input.b.page1.mreb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb013
            
            #add-point:AFTER FIELD mreb013 name="input.a.page1.mreb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb013
            #add-point:ON CHANGE mreb013 name="input.g.page1.mreb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb014
            #add-point:BEFORE FIELD mreb014 name="input.b.page1.mreb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb014
            
            #add-point:AFTER FIELD mreb014 name="input.a.page1.mreb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb014
            #add-point:ON CHANGE mreb014 name="input.g.page1.mreb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mreb015
            #add-point:BEFORE FIELD mreb015 name="input.b.page1.mreb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mreb015
            
            #add-point:AFTER FIELD mreb015 name="input.a.page1.mreb015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mreb015
            #add-point:ON CHANGE mreb015 name="input.g.page1.mreb015"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrebseq
            #add-point:ON ACTION controlp INFIELD mrebseq name="input.c.page1.mrebseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb001
            #add-point:ON ACTION controlp INFIELD mreb001 name="input.c.page1.mreb001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mreb_d[l_ac].mreb001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mrba001_1()                                #呼叫開窗

            LET g_mreb_d[l_ac].mreb001 = g_qryparam.return1              

            DISPLAY g_mreb_d[l_ac].mreb001 TO mreb001              #

            NEXT FIELD mreb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb007
            #add-point:ON ACTION controlp INFIELD mreb007 name="input.c.page1.mreb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb008
            #add-point:ON ACTION controlp INFIELD mreb008 name="input.c.page1.mreb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb009
            #add-point:ON ACTION controlp INFIELD mreb009 name="input.c.page1.mreb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb010
            #add-point:ON ACTION controlp INFIELD mreb010 name="input.c.page1.mreb010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mreb_d[l_ac].mreb010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_mreb_d[l_ac].mreb010 = g_qryparam.return1              

            DISPLAY g_mreb_d[l_ac].mreb010 TO mreb010              #

            NEXT FIELD mreb010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb011
            #add-point:ON ACTION controlp INFIELD mreb011 name="input.c.page1.mreb011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mreb_d[l_ac].mreb011             #給予default值
            LET g_qryparam.default2 = "" #g_mreb_d[l_ac].ooeg001 #部門編號
            #給予arg
            IF NOT cl_null(g_mrea_m.mreadocdt) THEN
               LET g_qryparam.arg1 = g_mrea_m.mreadocdt
            ELSE
               LET g_qryparam.arg1 = g_today
            END IF
            

            CALL q_ooeg001()                                #呼叫開窗

            LET g_mreb_d[l_ac].mreb011 = g_qryparam.return1              
            #LET g_mreb_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_mreb_d[l_ac].mreb011 TO mreb011              #
            #DISPLAY g_mreb_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD mreb011                   

            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb012
            #add-point:ON ACTION controlp INFIELD mreb012 name="input.c.page1.mreb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb013
            #add-point:ON ACTION controlp INFIELD mreb013 name="input.c.page1.mreb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb014
            #add-point:ON ACTION controlp INFIELD mreb014 name="input.c.page1.mreb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mreb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mreb015
            #add-point:ON ACTION controlp INFIELD mreb015 name="input.c.page1.mreb015"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mreb_d[l_ac].* = g_mreb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt900_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mreb_d[l_ac].mrebseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mreb_d[l_ac].* = g_mreb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF g_mreb_d[l_ac].mreb007 = '2' AND (cl_null(g_mreb_d[l_ac].mreb010) AND 
                  cl_null(g_mreb_d[l_ac].mreb011) AND  
                  cl_null(g_mreb_d[l_ac].mreb012) AND  
                  cl_null(g_mreb_d[l_ac].mreb013) )THEN 
                  NEXT FIELD mreb010
               END IF  
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amrt900_mreb_t_mask_restore('restore_mask_o')
      
               UPDATE mreb_t SET (mrebdocno,mrebseq,mreb001,mreb002,mreb003,mreb004,mreb005,mreb006, 
                   mreb007,mreb008,mreb009,mreb010,mreb011,mreb012,mreb013,mreb014,mreb015) = (g_mrea_m.mreadocno, 
                   g_mreb_d[l_ac].mrebseq,g_mreb_d[l_ac].mreb001,g_mreb_d[l_ac].mreb002,g_mreb_d[l_ac].mreb003, 
                   g_mreb_d[l_ac].mreb004,g_mreb_d[l_ac].mreb005,g_mreb_d[l_ac].mreb006,g_mreb_d[l_ac].mreb007, 
                   g_mreb_d[l_ac].mreb008,g_mreb_d[l_ac].mreb009,g_mreb_d[l_ac].mreb010,g_mreb_d[l_ac].mreb011, 
                   g_mreb_d[l_ac].mreb012,g_mreb_d[l_ac].mreb013,g_mreb_d[l_ac].mreb014,g_mreb_d[l_ac].mreb015) 
 
                WHERE mrebent = g_enterprise AND mrebdocno = g_mrea_m.mreadocno 
 
                  AND mrebseq = g_mreb_d_t.mrebseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mreb_d[l_ac].* = g_mreb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mreb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mreb_d[l_ac].* = g_mreb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mreb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrea_m.mreadocno
               LET gs_keys_bak[1] = g_mreadocno_t
               LET gs_keys[2] = g_mreb_d[g_detail_idx].mrebseq
               LET gs_keys_bak[2] = g_mreb_d_t.mrebseq
               CALL amrt900_update_b('mreb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amrt900_mreb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mreb_d[g_detail_idx].mrebseq = g_mreb_d_t.mrebseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mrea_m.mreadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mreb_d_t.mrebseq
 
                  CALL amrt900_key_update_b(gs_keys,'mreb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrea_m),util.JSON.stringify(g_mreb_d_t)
               LET g_log2 = util.JSON.stringify(g_mrea_m),util.JSON.stringify(g_mreb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amrt900_unlock_b("mreb_t","'1'")
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
               LET g_mreb_d[li_reproduce_target].* = g_mreb_d[li_reproduce].*
 
               LET g_mreb_d[li_reproduce_target].mrebseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mreb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mreb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="amrt900.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mreadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrebseq
 
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
 
{<section id="amrt900.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amrt900_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amrt900_b_fill() #單身填充
      CALL amrt900_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amrt900_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_mrea_m_mask_o.* =  g_mrea_m.*
   CALL amrt900_mrea_t_mask()
   LET g_mrea_m_mask_n.* =  g_mrea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mrea_m.mreadocno,g_mrea_m.mreadocno_desc,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001, 
       g_mrea_m.mrea001_desc,g_mrea_m.mrea002,g_mrea_m.mrea002_desc,g_mrea_m.mreastus
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrea_m.mreastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mreb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amrt900_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amrt900_detail_show()
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
 
{<section id="amrt900.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amrt900_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mrea_t.mreadocno 
   DEFINE l_oldno     LIKE mrea_t.mreadocno 
 
   DEFINE l_master    RECORD LIKE mrea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mreb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success   LIKE type_t.num10
   DEFINE l_mreb001   LIKE mreb_t.mreb001 
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
   
   IF g_mrea_m.mreadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mreadocno_t = g_mrea_m.mreadocno
 
    
   LET g_mrea_m.mreadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrea_m.mreastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   DECLARE amrt900_sel_mreb_cs02 CURSOR FOR
   SELECT mreb001 
     FROM mrea_t,mreb_t
    WHERE mreadocno = mrebdocno
      AND mreaent = mrebent
      AND mreastus <> 'S'
      AND mreastus <> 'X'
      AND mreadocno <> g_mreadocno_t
      AND mreb001 IN (SELECT mreb001 FROM mreb_t WHERE mrebdocno =g_mreadocno_t AND mreaent=g_enterprise )
      AND mreaent=g_enterprise
      AND mreasite = g_site
   LET l_mreb001 = NULL
   LET l_success = TRUE
   CALL cl_err_collect_init()  
   FOREACH amrt900_sel_mreb_cs02  INTO l_mreb001
      
      #單身資源編號已存在其他未過帳盤點單!
      LET g_errparam.code = 'amr-00103'
      LET g_errparam.extend = l_mreb001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END FOREACH
   CALL cl_err_collect_show()
   IF NOT l_success THEN
      LET g_mrea_m.mreadocno = g_mreadocno_t 
      EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
       g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
       g_mrea_m.mrea002_desc
      CALL amrt900_show()
      CALL  s_transaction_end("N","0")
      RETURN
   END IF   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrea_m.mreastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_mrea_m.mreadocno_desc = ''
   DISPLAY BY NAME g_mrea_m.mreadocno_desc
 
   
   CALL amrt900_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mrea_m.* TO NULL
      INITIALIZE g_mreb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amrt900_show()
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
   CALL amrt900_set_act_visible()   
   CALL amrt900_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mreadocno_t = g_mrea_m.mreadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mreaent = " ||g_enterprise|| " AND",
                      " mreadocno = '", g_mrea_m.mreadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt900_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amrt900_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL amrt900_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amrt900_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mreb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amrt900_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mreb_t
    WHERE mrebent = g_enterprise AND mrebdocno = g_mreadocno_t
 
    INTO TEMP amrt900_detail
 
   #將key修正為調整後   
   UPDATE amrt900_detail 
      #更新key欄位
      SET mrebdocno = g_mrea_m.mreadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mreb_t SELECT * FROM amrt900_detail
   
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
   DROP TABLE amrt900_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mreadocno_t = g_mrea_m.mreadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amrt900_delete()
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
   
   IF g_mrea_m.mreadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amrt900_cl USING g_enterprise,g_mrea_m.mreadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt900_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt900_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
       g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
       g_mrea_m.mrea002_desc
   
   
   #檢查是否允許此動作
   IF NOT amrt900_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrea_m_mask_o.* =  g_mrea_m.*
   CALL amrt900_mrea_t_mask()
   LET g_mrea_m_mask_n.* =  g_mrea_m.*
   
   CALL amrt900_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amrt900_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mreadocno_t = g_mrea_m.mreadocno
 
 
      DELETE FROM mrea_t
       WHERE mreaent = g_enterprise AND mreadocno = g_mrea_m.mreadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mrea_m.mreadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_mrea_m.mreadocno,g_mrea_m.mreadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mreb_t
       WHERE mrebent = g_enterprise AND mrebdocno = g_mrea_m.mreadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mreb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mrea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amrt900_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mreb_d.clear() 
 
     
      CALL amrt900_ui_browser_refresh()  
      #CALL amrt900_ui_headershow()  
      #CALL amrt900_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amrt900_browser_fill("")
         CALL amrt900_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amrt900_cl
 
   #功能已完成,通報訊息中心
   CALL amrt900_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amrt900.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrt900_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mreb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amrt900_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrebseq,mreb001,mreb002,mreb003,mreb004,mreb005,mreb006,mreb007, 
             mreb008,mreb009,mreb010,mreb011,mreb012,mreb013,mreb014,mreb015 ,t1.mrba004 ,t2.mrba008 , 
             t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 FROM mreb_t",   
                     " INNER JOIN mrea_t ON mreaent = " ||g_enterprise|| " AND mreadocno = mrebdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN mrba_t t1 ON t1.mrbaent="||g_enterprise||" AND t1.mrba001=mreb001  ",
               " LEFT JOIN mrba_t t2 ON t2.mrbaent="||g_enterprise||" AND t2.mrba001=mreb001  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=mreb003  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=mreb004 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=mreb010  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=mreb011 AND t6.ooefl002='"||g_dlang||"' ",
 
                     " WHERE mrebent=? AND mrebdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mreb_t.mrebseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt900_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amrt900_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mrea_m.mreadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mrea_m.mreadocno INTO g_mreb_d[l_ac].mrebseq,g_mreb_d[l_ac].mreb001, 
          g_mreb_d[l_ac].mreb002,g_mreb_d[l_ac].mreb003,g_mreb_d[l_ac].mreb004,g_mreb_d[l_ac].mreb005, 
          g_mreb_d[l_ac].mreb006,g_mreb_d[l_ac].mreb007,g_mreb_d[l_ac].mreb008,g_mreb_d[l_ac].mreb009, 
          g_mreb_d[l_ac].mreb010,g_mreb_d[l_ac].mreb011,g_mreb_d[l_ac].mreb012,g_mreb_d[l_ac].mreb013, 
          g_mreb_d[l_ac].mreb014,g_mreb_d[l_ac].mreb015,g_mreb_d[l_ac].mreb001_desc,g_mreb_d[l_ac].mreb001_desc_desc, 
          g_mreb_d[l_ac].mreb003_desc,g_mreb_d[l_ac].mreb004_desc,g_mreb_d[l_ac].mreb010_desc,g_mreb_d[l_ac].mreb011_desc  
            #(ver:78)
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
   
   CALL g_mreb_d.deleteElement(g_mreb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amrt900_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mreb_d.getLength()
      LET g_mreb_d_mask_o[l_ac].* =  g_mreb_d[l_ac].*
      CALL amrt900_mreb_t_mask()
      LET g_mreb_d_mask_n[l_ac].* =  g_mreb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amrt900_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mreb_t
       WHERE mrebent = g_enterprise AND
         mrebdocno = ps_keys_bak[1] AND mrebseq = ps_keys_bak[2]
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
         CALL g_mreb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amrt900_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mreb_t
                  (mrebent,
                   mrebdocno,
                   mrebseq
                   ,mreb001,mreb002,mreb003,mreb004,mreb005,mreb006,mreb007,mreb008,mreb009,mreb010,mreb011,mreb012,mreb013,mreb014,mreb015) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mreb_d[g_detail_idx].mreb001,g_mreb_d[g_detail_idx].mreb002,g_mreb_d[g_detail_idx].mreb003, 
                       g_mreb_d[g_detail_idx].mreb004,g_mreb_d[g_detail_idx].mreb005,g_mreb_d[g_detail_idx].mreb006, 
                       g_mreb_d[g_detail_idx].mreb007,g_mreb_d[g_detail_idx].mreb008,g_mreb_d[g_detail_idx].mreb009, 
                       g_mreb_d[g_detail_idx].mreb010,g_mreb_d[g_detail_idx].mreb011,g_mreb_d[g_detail_idx].mreb012, 
                       g_mreb_d[g_detail_idx].mreb013,g_mreb_d[g_detail_idx].mreb014,g_mreb_d[g_detail_idx].mreb015) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mreb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mreb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amrt900_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mreb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amrt900_mreb_t_mask_restore('restore_mask_o')
               
      UPDATE mreb_t 
         SET (mrebdocno,
              mrebseq
              ,mreb001,mreb002,mreb003,mreb004,mreb005,mreb006,mreb007,mreb008,mreb009,mreb010,mreb011,mreb012,mreb013,mreb014,mreb015) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mreb_d[g_detail_idx].mreb001,g_mreb_d[g_detail_idx].mreb002,g_mreb_d[g_detail_idx].mreb003, 
                  g_mreb_d[g_detail_idx].mreb004,g_mreb_d[g_detail_idx].mreb005,g_mreb_d[g_detail_idx].mreb006, 
                  g_mreb_d[g_detail_idx].mreb007,g_mreb_d[g_detail_idx].mreb008,g_mreb_d[g_detail_idx].mreb009, 
                  g_mreb_d[g_detail_idx].mreb010,g_mreb_d[g_detail_idx].mreb011,g_mreb_d[g_detail_idx].mreb012, 
                  g_mreb_d[g_detail_idx].mreb013,g_mreb_d[g_detail_idx].mreb014,g_mreb_d[g_detail_idx].mreb015)  
 
         WHERE mrebent = g_enterprise AND mrebdocno = ps_keys_bak[1] AND mrebseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mreb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mreb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt900_mreb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="amrt900.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amrt900_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt900.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amrt900_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt900.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amrt900_lock_b(ps_table,ps_page)
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
   #CALL amrt900_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mreb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amrt900_bcl USING g_enterprise,
                                       g_mrea_m.mreadocno,g_mreb_d[g_detail_idx].mrebseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt900_bcl:",SQLERRMESSAGE 
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
 
{<section id="amrt900.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amrt900_unlock_b(ps_table,ps_page)
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
      CLOSE amrt900_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amrt900_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mreadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mreadocno",TRUE)
      CALL cl_set_comp_entry("mreadocdt",TRUE)
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
 
{<section id="amrt900.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amrt900_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mreadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mreadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mreadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt900.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amrt900_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mreb008,mreb009,mreb010,mreb011,mreb012,mreb013,mreb015,mreb014",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="amrt900.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amrt900_set_no_entry_b(p_cmd)
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
   IF g_mreb_d[l_ac].mreb007 MATCHES '[0]' THEN
      CALL cl_set_comp_entry("mreb008,mreb009,mreb010,mreb011,mreb012,mreb013,mreb015,mreb014",FALSE)
   END IF
   IF g_mreb_d[l_ac].mreb007 MATCHES '[1]' THEN
      CALL cl_set_comp_entry("mreb008,mreb009,mreb010,mreb011,mreb012,mreb013",FALSE)
   END IF
   
   IF g_mreb_d[l_ac].mreb007 MATCHES '[3]' THEN
      CALL cl_set_comp_entry("mreb008,mreb010,mreb011,mreb012,mreb013",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="amrt900.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amrt900_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amrt900_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_mrea_m.mreastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   
   IF g_mrea_m.mreastus <> 'S' THEN
    CALL cl_set_act_visible("reproduce", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amrt900_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amrt900_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amrt900_default_search()
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
      LET ls_wc = ls_wc, " mreadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mrea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mreb_t" 
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
 
{<section id="amrt900.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amrt900_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_mrea_m.mreastus MATCHES '[XS]' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mrea_m.mreadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amrt900_cl USING g_enterprise,g_mrea_m.mreadocno
   IF STATUS THEN
      CLOSE amrt900_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt900_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
       g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
       g_mrea_m.mrea002_desc
   
 
   #檢查是否允許此動作
   IF NOT amrt900_action_chk() THEN
      CLOSE amrt900_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrea_m.mreadocno,g_mrea_m.mreadocno_desc,g_mrea_m.mrea003,g_mrea_m.mreadocdt,g_mrea_m.mrea001, 
       g_mrea_m.mrea001_desc,g_mrea_m.mrea002,g_mrea_m.mrea002_desc,g_mrea_m.mreastus
 
   CASE g_mrea_m.mreastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mrea_m.mreastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "S"
               HIDE OPTION "posted"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted",TRUE)
      CASE g_mrea_m.mreastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,posted",FALSE)
            
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid,posted",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)      
         
         WHEN "S"     
             CALL cl_set_act_visible("unconfirmed,confirmed,invalid,posted",FALSE)
      END CASE
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      AND lc_state <> "S"
      ) OR 
      g_mrea_m.mreastus = lc_state OR cl_null(lc_state) THEN
      CLOSE amrt900_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN amrt900_cl USING g_enterprise,g_mrea_m.mreadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt900_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE amrt900_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   CALL cl_err_collect_init() 
   
   #顯示最新的資料
   #未確認改確認(N->Y)
   IF lc_state = 'Y' AND g_mrea_m.mreastus = 'N' THEN
      CALL s_amrt900_conf_chk(g_mrea_m.mreadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00108') THEN
            CALL s_amrt900_conf_upd(g_mrea_m.mreadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   
   #確認改未確認(Y->N)
   IF lc_state = 'N' AND g_mrea_m.mreastus = 'Y' THEN
      CALL s_amrt900_unconf_chk(g_mrea_m.mreadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00110') THEN
            CALL s_amrt900_unconf_upd(g_mrea_m.mreadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   
   #未確認改作廢(N->X)
   IF lc_state = 'X' AND g_mrea_m.mreastus = 'N' THEN
      CALL s_amrt900_invalid_chk(g_mrea_m.mreadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00109') THEN
            CALL s_amrt900_invalid_upd(g_mrea_m.mreadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   
   #已確認改過帳(Y->S)
   IF lc_state = 'S' AND g_mrea_m.mreastus = 'Y' THEN
      CALL s_amrt900_post_chk(g_mrea_m.mreadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('sub-00360') THEN  #是否執行過帳？
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               IF NOT amrt900_post_input() THEN  #INPUT
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               END IF
               CALL s_amrt900_post_upd(g_mrea_m.mreadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF 
   END IF          
   #end add-point
   
   LET g_mrea_m.mreastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mrea_t 
      SET (mreastus) 
        = (g_mrea_m.mreastus)     
    WHERE mreaent = g_enterprise AND mreadocno = g_mrea_m.mreadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE amrt900_master_referesh USING g_mrea_m.mreadocno INTO g_mrea_m.mreadocno,g_mrea_m.mrea003, 
          g_mrea_m.mreadocdt,g_mrea_m.mrea001,g_mrea_m.mrea002,g_mrea_m.mreastus,g_mrea_m.mrea001_desc, 
          g_mrea_m.mrea002_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mrea_m.mreadocno,g_mrea_m.mreadocno_desc,g_mrea_m.mrea003,g_mrea_m.mreadocdt, 
          g_mrea_m.mrea001,g_mrea_m.mrea001_desc,g_mrea_m.mrea002,g_mrea_m.mrea002_desc,g_mrea_m.mreastus 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amrt900_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt900_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt900.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amrt900_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mreb_d.getLength() THEN
         LET g_detail_idx = g_mreb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mreb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mreb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrt900_b_fill2(pi_idx)
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
   
   CALL amrt900_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amrt900_fill_chk(ps_idx)
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
 
{<section id="amrt900.status_show" >}
PRIVATE FUNCTION amrt900_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amrt900.mask_functions" >}
&include "erp/amr/amrt900_mask.4gl"
 
{</section>}
 
{<section id="amrt900.signature" >}
   
 
{</section>}
 
{<section id="amrt900.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amrt900_set_pk_array()
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
   LET g_pk_array[1].values = g_mrea_m.mreadocno
   LET g_pk_array[1].column = 'mreadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt900.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amrt900.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amrt900_msgcentre_notify(lc_state)
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
   CALL amrt900_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt900.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amrt900_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#24 add-S
   SELECT mreastus  INTO g_mrea_m.mreastus
     FROM mrea_t
    WHERE mreaent = g_enterprise
      AND mreadocno = g_mrea_m.mreadocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mrea_m.mreastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_mrea_m.mreadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrt900_set_act_visible()
        CALL amrt900_set_act_no_visible()
        CALL amrt900_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#24 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt900.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 開窗下自動產生單身的QBE條件
# Memo...........:
# Usage..........: CALL amrt900_auto_insert_detail_form()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 15/06/03 By TSD.david
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt900_auto_insert_detail_form()
   DEFINE   l_wc               STRING
   DEFINE   l_n                LIKE type_t.num10
    
   LET l_n = 0   
   SELECT COUNT(*) INTO l_n
     FROM mreb_t
    WHERE mrebdocno = g_mrea_m.mreadocno
      AND mrebent = g_enterprise  #160902-00048#1-add
   IF l_n > 0 THEN
      RETURN
   END IF
   
   
   OPEN WINDOW w_amrt900_s01 WITH FORM cl_ap_formpath("amr",'amrt900_s01')
   
   #CALL cl_ui_init()
   CALL cl_ui_locale('amrt900_s01')
   CALL cl_set_comp_visible('history_page,scheduling_page,group_input',FALSE)
   CALL cl_set_combo_scc('mrba000','5202')
   CALL cl_set_combo_scc('mrba100','5203')
   CALL cl_set_combo_scc('mrba019','5201')
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         CONSTRUCT BY NAME l_wc ON mrba019,mrba020,mrba000,mrba001,mrba015,
                                   mrba016,mrba017,mrba018,mrba102,mrba100
                                
             ON ACTION controlp INFIELD mrba001
           
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mrba001_1()                          
               DISPLAY g_qryparam.return1 TO mrba001  
               NEXT FIELD mrba001                    

            ON ACTION controlp INFIELD mrba016
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO mrba016  #顯示到畫面上
               NEXT FIELD mrba016 

            ON ACTION controlp INFIELD mrba017
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO mrba017  #顯示到畫面上
               NEXT FIELD mrba017
            
            ON ACTION controlp INFIELD mrba020
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mrba020()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO mrba020  #顯示到畫面上
               NEXT FIELD mrba020   
         END CONSTRUCT
         
         
         BEFORE DIALOG
            CALL cl_qbe_init()       
 
        
         ON ACTION qbe_select
            LET l_wc = ""
            CALL cl_qbe_list("c") RETURNING l_wc
    
      
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION accept
            ACCEPT DIALOG
 
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG 
 
         ON ACTION accept_02
            ACCEPT DIALOG
 
         ON ACTION cancel_02
            LET INT_FLAG = 1
            EXIT DIALOG 
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG   
   
      IF INT_FLAG  THEN
         EXIT WHILE
      END IF
      IF l_wc = ' 1=1' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00379'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CONTINUE WHILE
      END IF
      EXIT WHILE
   END WHILE 
   IF INT_FLAG  THEN
      LET INT_FLAG = 0
      CLOSE WINDOW w_amrt900_s01
      RETURN
   END IF
     
   CALL amrt900_auto_insert_detail(l_wc) 
   CLOSE WINDOW w_amrt900_s01
END FUNCTION

################################################################################
# Descriptions...: 依QBE產生單身
# Memo...........:
# Usage..........: CALL amrt900_auto_insert_detail(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc           QBE條件
# Return code....:
#                : 
# Date & Author..: 15/05/30 By TSD.david
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt900_auto_insert_detail(p_wc)
   DEFINE p_wc         STRING
   DEFINE l_sql        STRING
   DEFINE ls_value     STRING
  #DEFINE l_mreb       RECORD LIKE mreb_t.*   
   #161109-00085#2-s
   DEFINE l_mreb RECORD  #資源設備盤點單單身檔
          mrebent LIKE mreb_t.mrebent, #企業編號
          mrebsite LIKE mreb_t.mrebsite, #營運據點
          mrebdocno LIKE mreb_t.mrebdocno, #單據單號
          mrebseq LIKE mreb_t.mrebseq, #項次
          mreb001 LIKE mreb_t.mreb001, #資源編號
          mreb002 LIKE mreb_t.mreb002, #數量
          mreb003 LIKE mreb_t.mreb003, #保管人員
          mreb004 LIKE mreb_t.mreb004, #保管部門
          mreb005 LIKE mreb_t.mreb005, #一級存放位置
          mreb006 LIKE mreb_t.mreb006, #二級存放位置
          mreb007 LIKE mreb_t.mreb007, #資源盤點狀態
          mreb008 LIKE mreb_t.mreb008, #盤點數量
          mreb009 LIKE mreb_t.mreb009, #備註
          mreb010 LIKE mreb_t.mreb010, #實際保管人員
          mreb011 LIKE mreb_t.mreb011, #實際保管部門
          mreb012 LIKE mreb_t.mreb012, #實際存放一級位置
          mreb013 LIKE mreb_t.mreb013, #實際存放二級位置
          mreb014 LIKE mreb_t.mreb014, #盤點日期
         #mreb015 LIKE mreb_t.mreb015  #盤點時間 #161109-00085#61 mark
          #161109-00085#61 --s add
          mreb015 LIKE mreb_t.mreb015, #盤點時間
          mrebud001 LIKE mreb_t.mrebud001, #自定義欄位(文字)001
          mrebud002 LIKE mreb_t.mrebud002, #自定義欄位(文字)002
          mrebud003 LIKE mreb_t.mrebud003, #自定義欄位(文字)003
          mrebud004 LIKE mreb_t.mrebud004, #自定義欄位(文字)004
          mrebud005 LIKE mreb_t.mrebud005, #自定義欄位(文字)005
          mrebud006 LIKE mreb_t.mrebud006, #自定義欄位(文字)006
          mrebud007 LIKE mreb_t.mrebud007, #自定義欄位(文字)007
          mrebud008 LIKE mreb_t.mrebud008, #自定義欄位(文字)008
          mrebud009 LIKE mreb_t.mrebud009, #自定義欄位(文字)009
          mrebud010 LIKE mreb_t.mrebud010, #自定義欄位(文字)010
          mrebud011 LIKE mreb_t.mrebud011, #自定義欄位(數字)011
          mrebud012 LIKE mreb_t.mrebud012, #自定義欄位(數字)012
          mrebud013 LIKE mreb_t.mrebud013, #自定義欄位(數字)013
          mrebud014 LIKE mreb_t.mrebud014, #自定義欄位(數字)014
          mrebud015 LIKE mreb_t.mrebud015, #自定義欄位(數字)015
          mrebud016 LIKE mreb_t.mrebud016, #自定義欄位(數字)016
          mrebud017 LIKE mreb_t.mrebud017, #自定義欄位(數字)017
          mrebud018 LIKE mreb_t.mrebud018, #自定義欄位(數字)018
          mrebud019 LIKE mreb_t.mrebud019, #自定義欄位(數字)019
          mrebud020 LIKE mreb_t.mrebud020, #自定義欄位(數字)020
          mrebud021 LIKE mreb_t.mrebud021, #自定義欄位(日期時間)021
          mrebud022 LIKE mreb_t.mrebud022, #自定義欄位(日期時間)022
          mrebud023 LIKE mreb_t.mrebud023, #自定義欄位(日期時間)023
          mrebud024 LIKE mreb_t.mrebud024, #自定義欄位(日期時間)024
          mrebud025 LIKE mreb_t.mrebud025, #自定義欄位(日期時間)025
          mrebud026 LIKE mreb_t.mrebud026, #自定義欄位(日期時間)026
          mrebud027 LIKE mreb_t.mrebud027, #自定義欄位(日期時間)027
          mrebud028 LIKE mreb_t.mrebud028, #自定義欄位(日期時間)028
          mrebud029 LIKE mreb_t.mrebud029, #自定義欄位(日期時間)029
          mrebud030 LIKE mreb_t.mrebud030  #自定義欄位(日期時間)030
          #161109-00085#61 --e add
   END RECORD
   
   #161109-00085#2-e
   
   DEFINE l_cnt        LIKE type_t.num10,
          li_count     LIKE type_t.num10,
          l_mrba001    LIKE mrba_t.mrba001,
          l_mrba004    LIKE mrba_t.mrba004,  
          l_mrba008    LIKE mrba_t.mrba008,  
          l_mrba006    LIKE mrba_t.mrba006,  
          l_mrba016    LIKE mrba_t.mrba016,            
          l_mrba017    LIKE mrba_t.mrba017, 
          l_mrba018    LIKE mrba_t.mrba018,  
          l_mrba102    LIKE mrba_t.mrba102 

   LET l_sql = " SELECT COUNT(*)",
               "   FROM mrba_t ",
               "  WHERE mrbaent='",g_enterprise,"'",
               "    AND mrbasite='",g_site,"'",
               "    AND mrbastus = 'Y' ",
               "    AND ",p_wc CLIPPED    
   PREPARE amrt900_count_mrba_pre FROM l_sql
   EXECUTE amrt900_count_mrba_pre INTO li_count
   CALL cl_progress_bar_no_window(li_count)
   
       
   CALL cl_err_collect_init()   
    
   
   LET l_sql = " SELECT mrba001,mrba004,mrba008,mrba006,mrba016,mrba017,mrba018,mrba102",
               "   FROM mrba_t ",
               "  WHERE mrbaent='",g_enterprise,"'",
               "    AND mrbasite='",g_site,"'",
               "    AND mrbastus = 'Y'",
               "    AND ",p_wc CLIPPED 
   PREPARE amrt900_sel_mrba_pre FROM l_sql
   DECLARE amrt900_sel_mrba_cs CURSOR WITH HOLD FOR amrt900_sel_mrba_pre
   FOREACH amrt900_sel_mrba_cs INTO l_mrba001,l_mrba004,l_mrba008,l_mrba006,
                                    l_mrba016,l_mrba017,l_mrba018,l_mrba102
      IF SQLCA.sqlcode THEN
         LET g_errparam.code = SQLCA.sqlcode 
         LET g_errparam.extend =  'FOREACH amrt900_sel_mrba_cs '
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      #讀取交易對像月結檔：
      LET ls_value = cl_getmsg('amr-00104',g_lang)," ",l_mrba001
      CALL cl_progress_no_window_ing(ls_value)
   
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM mrea_t,mreb_t
       WHERE mreaent = mrebent
         AND mreadocno = mrebdocno
         AND mreastus <> 'S'
         AND mreastus <> 'X'
         AND mreadocno <> g_mrea_m.mreadocno
         AND mreb001 = l_mrba001
         AND mreaent=g_enterprise
         AND mreasite = g_site
      IF l_cnt > 0 THEN
         LET g_errparam.code = 'amr-00103' 
         LET g_errparam.extend =  l_mrba001
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      INITIALIZE l_mreb.* TO NULL

      CALL s_transaction_begin()
      LET l_mreb.mrebent = g_enterprise
      LET l_mreb.mrebdocno = g_mrea_m.mreadocno
      SELECT MAX(mrebseq) INTO l_mreb.mrebseq
        FROM mreb_t 
       WHERE mrebent = g_enterprise
         AND mrebdocno = g_mrea_m.mreadocno  
      IF cl_null(l_mreb.mrebseq) THEN
         LET l_mreb.mrebseq = 0
      END IF 
      LET l_mreb.mrebseq = l_mreb.mrebseq+1
      LET l_mreb.mreb001 = l_mrba001
      LET l_mreb.mreb002 = l_mrba006 
      LET l_mreb.mreb003 = l_mrba016
      LET l_mreb.mreb004 = l_mrba017
      LET l_mreb.mreb005 = l_mrba018
      LET l_mreb.mreb006 = l_mrba102
      LET l_mreb.mreb007 = '0'
      LET l_mreb.mreb008 = 0
      #INSERT INTO mreb_t VALUES(l_mreb.*)
      #161109-00085#2-s
      #161109-00085#61 --s mark
      #INSERT INTO mreb_t (mrebent,mrebsite,mrebdocno,mrebseq,mreb001,
      #                    mreb002,mreb003,mreb004,mreb005,mreb006,
      #                    mreb007,mreb008,mreb009,mreb010,mreb011,
      #                    mreb012,mreb013,mreb014,mreb015) 
      #            VALUES(l_mreb.mrebent,l_mreb.mrebsite,l_mreb.mrebdocno,
      #                   l_mreb.mrebseq,l_mreb.mreb001,l_mreb.mreb002,
      #                   l_mreb.mreb003,l_mreb.mreb004,l_mreb.mreb005,
      #                   l_mreb.mreb006,l_mreb.mreb007,l_mreb.mreb008,
      #                   l_mreb.mreb009,l_mreb.mreb010,l_mreb.mreb011,
      #                   l_mreb.mreb012,l_mreb.mreb013,l_mreb.mreb014,l_mreb.mreb015)
      #161109-00085#61 --e mark
      #161109-00085#2-e
      #161109-00085#61 --s add
      INSERT INTO mreb_t(mrebent,mrebsite,mrebdocno,mrebseq,mreb001,
                         mreb002,mreb003,mreb004,mreb005,mreb006,
                         mreb007,mreb008,mreb009,mreb010,mreb011,
                         mreb012,mreb013,mreb014,mreb015,mrebud001,
                         mrebud002,mrebud003,mrebud004,mrebud005,mrebud006,
                         mrebud007,mrebud008,mrebud009,mrebud010,mrebud011,
                         mrebud012,mrebud013,mrebud014,mrebud015,mrebud016,
                         mrebud017,mrebud018,mrebud019,mrebud020,mrebud021,
                         mrebud022,mrebud023,mrebud024,mrebud025,mrebud026,
                         mrebud027,mrebud028,mrebud029,mrebud030)
      VALUES(l_mreb.mrebent,l_mreb.mrebsite,l_mreb.mrebdocno,l_mreb.mrebseq,l_mreb.mreb001,
             l_mreb.mreb002,l_mreb.mreb003,l_mreb.mreb004,l_mreb.mreb005,l_mreb.mreb006,
             l_mreb.mreb007,l_mreb.mreb008,l_mreb.mreb009,l_mreb.mreb010,l_mreb.mreb011,
             l_mreb.mreb012,l_mreb.mreb013,l_mreb.mreb014,l_mreb.mreb015,l_mreb.mrebud001,
             l_mreb.mrebud002,l_mreb.mrebud003,l_mreb.mrebud004,l_mreb.mrebud005,l_mreb.mrebud006,
             l_mreb.mrebud007,l_mreb.mrebud008,l_mreb.mrebud009,l_mreb.mrebud010,l_mreb.mrebud011,
             l_mreb.mrebud012,l_mreb.mrebud013,l_mreb.mrebud014,l_mreb.mrebud015,l_mreb.mrebud016,
             l_mreb.mrebud017,l_mreb.mrebud018,l_mreb.mrebud019,l_mreb.mrebud020,l_mreb.mrebud021,
             l_mreb.mrebud022,l_mreb.mrebud023,l_mreb.mrebud024,l_mreb.mrebud025,l_mreb.mrebud026,
             l_mreb.mrebud027,l_mreb.mrebud028,l_mreb.mrebud029,l_mreb.mrebud030)
      #161109-00085#61 --e add
      IF SQLCA.sqlcode THEN
         CALL s_transaction_end('N',0)
         LET g_errparam.code = SQLCA.sqlcode 
         LET g_errparam.extend =  l_mrba001,'  insert into mreb_t '
         CALL cl_err()
      ELSE         
         CALL s_transaction_end('Y',0)
      END IF
   
          
   END FOREACH  
   
   CALL cl_err_collect_show()   
   CALL amrt900_show()
END FUNCTION

################################################################################
# Descriptions...: 過帳Input
# Memo...........:
# Usage..........: CALL amrt900_post_input()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success   處理狀況
#                : 
# Date & Author..: 15/06/05 By TSD.david
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt900_post_input()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_para_data     LIKE type_t.chr80          #接參數用
   
   LET r_success = TRUE

   INPUT BY NAME g_mrea_m.mrea003 ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT
         IF cl_null(g_mrea_m.mrea003) THEN
            LET g_mrea_m.mrea003 = g_today
         END IF
         DISPLAY BY NAME g_mrea_m.mrea003

      AFTER FIELD mrea003
         IF NOT cl_null(g_mrea_m.mrea003) THEN
            #151120-00003#1 20151123 mark by beckxie---S
            #IF g_mrea_m.mrea003 < g_mrea_m.mreadocdt THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'axm-00267'   #扣帳日期不可小於單據日期！
            #   LET g_errparam.extend = g_mrea_m.mrea003
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #
            #   LET g_mrea_m.mrea003 = g_mrea_m_t.mrea003
            #   NEXT FIELD CURRENT
            #END IF
            #151120-00003#1 20151123 mark by beckxie---E     
         END IF
            
     AFTER INPUT
         IF INT_FLAG THEN
            EXIT INPUT
         END IF

         ON ACTION accept
            ACCEPT INPUT

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT INPUT

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT INPUT

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT INPUT

   END INPUT

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE      
      
      LET r_success = FALSE
      RETURN r_success
   END IF

   UPDATE mrea_t
      SET mrea003 = g_mrea_m.mrea003
    WHERE mreaent = g_enterprise
      AND mreadocno = g_mrea_m.mreadocno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 
