#該程式未解開Section, 採用最新樣板產出!
{<section id="adet400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-05-12 17:57:08), PR版次:0011(2016-08-26 10:34:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000245
#+ Filename...: adet400
#+ Description: 門店備用金領用作業
#+ Creator....: 02748(2014-03-27 11:28:07)
#+ Modifier...: 02159 -SD/PR- 08172
 
{</section>}
 
{<section id="adet400.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#42  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160816-00068#4   2016/08/16  By earl     調整transaction
#160818-00017#7   2016/08/24    by 08172  修改删除时重新检查状态
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
PRIVATE type type_g_deaq_m        RECORD
       deaqsite LIKE deaq_t.deaqsite, 
   deaqsite_desc LIKE type_t.chr80, 
   deaqdocdt LIKE deaq_t.deaqdocdt, 
   deaqdocno LIKE deaq_t.deaqdocno, 
   deaq001 LIKE deaq_t.deaq001, 
   deaq001_desc LIKE type_t.chr80, 
   deaqunit LIKE deaq_t.deaqunit, 
   deaqstus LIKE deaq_t.deaqstus, 
   deaqownid LIKE deaq_t.deaqownid, 
   deaqownid_desc LIKE type_t.chr80, 
   deaqowndp LIKE deaq_t.deaqowndp, 
   deaqowndp_desc LIKE type_t.chr80, 
   deaqcrtid LIKE deaq_t.deaqcrtid, 
   deaqcrtid_desc LIKE type_t.chr80, 
   deaqcrtdp LIKE deaq_t.deaqcrtdp, 
   deaqcrtdp_desc LIKE type_t.chr80, 
   deaqcrtdt LIKE deaq_t.deaqcrtdt, 
   deaqmodid LIKE deaq_t.deaqmodid, 
   deaqmodid_desc LIKE type_t.chr80, 
   deaqmoddt LIKE deaq_t.deaqmoddt, 
   deaqcnfid LIKE deaq_t.deaqcnfid, 
   deaqcnfid_desc LIKE type_t.chr80, 
   deaqcnfdt LIKE deaq_t.deaqcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dear_d        RECORD
       dearseq LIKE dear_t.dearseq, 
   dear000 LIKE dear_t.dear000, 
   dear001 LIKE dear_t.dear001, 
   dear001_desc LIKE type_t.chr500, 
   dear002 LIKE dear_t.dear002, 
   dear003 LIKE dear_t.dear003, 
   dear003_desc LIKE type_t.chr500, 
   dear006 LIKE dear_t.dear006, 
   dear006_desc LIKE type_t.chr500, 
   dear004 LIKE dear_t.dear004, 
   dear004_desc LIKE type_t.chr500, 
   dear005 LIKE dear_t.dear005, 
   dear007 LIKE dear_t.dear007, 
   dear009 LIKE dear_t.dear009, 
   dear008 LIKE dear_t.dear008, 
   dearsite LIKE dear_t.dearsite, 
   dearunit LIKE dear_t.dearunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_deaqsite LIKE deaq_t.deaqsite,
   b_deaqsite_desc LIKE type_t.chr80,
      b_deaqdocno LIKE deaq_t.deaqdocno,
      b_deaqdocdt LIKE deaq_t.deaqdocdt,
      b_deaq001 LIKE deaq_t.deaq001,
   b_deaq001_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_type           LIKE type_t.chr1
DEFINE g_total_amount        LIKE dear_t.dear008
DEFINE g_flag                LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_deaq_m          type_g_deaq_m
DEFINE g_deaq_m_t        type_g_deaq_m
DEFINE g_deaq_m_o        type_g_deaq_m
DEFINE g_deaq_m_mask_o   type_g_deaq_m #轉換遮罩前資料
DEFINE g_deaq_m_mask_n   type_g_deaq_m #轉換遮罩後資料
 
   DEFINE g_deaqdocno_t LIKE deaq_t.deaqdocno
 
 
DEFINE g_dear_d          DYNAMIC ARRAY OF type_g_dear_d
DEFINE g_dear_d_t        type_g_dear_d
DEFINE g_dear_d_o        type_g_dear_d
DEFINE g_dear_d_mask_o   DYNAMIC ARRAY OF type_g_dear_d #轉換遮罩前資料
DEFINE g_dear_d_mask_n   DYNAMIC ARRAY OF type_g_dear_d #轉換遮罩後資料
 
 
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
   #argv[1] type_t.chr1 #組織類型
#end add-point
 
{</section>}
 
{<section id="adet400.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:作業初始化 name="main.init"
   LET g_site_type = g_argv[1]
   IF cl_null(g_site_type) THEN
      LET g_site_type = '2'
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT deaqsite,'',deaqdocdt,deaqdocno,deaq001,'',deaqunit,deaqstus,deaqownid, 
       '',deaqowndp,'',deaqcrtid,'',deaqcrtdp,'',deaqcrtdt,deaqmodid,'',deaqmoddt,deaqcnfid,'',deaqcnfdt", 
        
                      " FROM deaq_t",
                      " WHERE deaqent= ? AND deaqdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.deaqsite,t0.deaqdocdt,t0.deaqdocno,t0.deaq001,t0.deaqunit,t0.deaqstus, 
       t0.deaqownid,t0.deaqowndp,t0.deaqcrtid,t0.deaqcrtdp,t0.deaqcrtdt,t0.deaqmodid,t0.deaqmoddt,t0.deaqcnfid, 
       t0.deaqcnfdt,t1.ooefl003 ,t2.oogd002 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooag011",
               " FROM deaq_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deaqsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oogd_t t2 ON t2.oogdent="||g_enterprise||" AND t2.oogdsite=t0.deaqsite AND t2.oogd001=t0.deaq001  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.deaqownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.deaqowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.deaqcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.deaqcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.deaqmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.deaqcnfid  ",
 
               " WHERE t0.deaqent = " ||g_enterprise|| " AND t0.deaqdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adet400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adet400 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adet400_init()   
 
      #進入選單 Menu (="N")
      CALL adet400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adet400
      
   END IF 
   
   CLOSE adet400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adet400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adet400_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
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
      CALL cl_set_combo_scc_part('deaqstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('dear002','8310','10')
   LET g_errshow = '1'
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
   
   #初始化搜尋條件
   CALL adet400_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adet400.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adet400_ui_dialog()
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
            CALL adet400_insert()
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
         INITIALIZE g_deaq_m.* TO NULL
         CALL g_dear_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adet400_init()
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
               
               CALL adet400_fetch('') # reload data
               LET l_ac = 1
               CALL adet400_ui_detailshow() #Setting the current row 
         
               CALL adet400_idx_chk()
               #NEXT FIELD dearseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_dear_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adet400_idx_chk()
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
               CALL adet400_idx_chk()
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
            CALL adet400_browser_fill("")
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
               CALL adet400_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adet400_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adet400_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL adet400_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL adet400_set_act_visible()   
            CALL adet400_set_act_no_visible()
            IF NOT (g_deaq_m.deaqdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " deaqent = " ||g_enterprise|| " AND",
                                  " deaqdocno = '", g_deaq_m.deaqdocno, "' "
 
               #填到對應位置
               CALL adet400_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "deaq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dear_t" 
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
               CALL adet400_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "deaq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dear_t" 
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
                  CALL adet400_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adet400_fetch("F")
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
               CALL adet400_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adet400_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet400_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adet400_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet400_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adet400_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet400_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adet400_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet400_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adet400_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet400_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_dear_d)
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
               NEXT FIELD dearseq
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
               CALL adet400_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#7 -s by 08172
               CALL adet400_set_act_visible()   
               CALL adet400_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adet400_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#7 -s by 08172
               CALL adet400_set_act_visible()   
               CALL adet400_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adet400_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#7 -s by 08172
               CALL adet400_set_act_visible()   
               CALL adet400_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adet400_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ade/adet400_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ade/adet400_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL adet400_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adet400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adet400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adet400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adet400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_deaq_m.deaqdocdt)
 
 
 
         
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
 
{<section id="adet400.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adet400_browser_fill(ps_page_action)
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
   LET l_where = s_aooi500_sql_where(g_prog,'deaqsite')
   
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
      LET l_sub_sql = " SELECT DISTINCT deaqdocno ",
                      " FROM deaq_t ",
                      " ",
                      " LEFT JOIN dear_t ON dearent = deaqent AND deaqdocno = deardocno ", "  ",
                      #add-point:browser_fill段sql(dear_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE deaqent = " ||g_enterprise|| " AND dearent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deaq_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deaqdocno ",
                      " FROM deaq_t ", 
                      "  ",
                      "  ",
                      " WHERE deaqent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("deaq_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql CLIPPED," AND ",l_where
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
      INITIALIZE g_deaq_m.* TO NULL
      CALL g_dear_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.deaqsite,t0.deaqdocno,t0.deaqdocdt,t0.deaq001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deaqstus,t0.deaqsite,t0.deaqdocno,t0.deaqdocdt,t0.deaq001,t1.ooefl003 , 
          t2.oogd002 ",
                  " FROM deaq_t t0",
                  "  ",
                  "  LEFT JOIN dear_t ON dearent = deaqent AND deaqdocno = deardocno ", "  ", 
                  #add-point:browser_fill段sql(dear_t1) name="browser_fill.join.dear_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deaqsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oogd_t t2 ON t2.oogdent="||g_enterprise||" AND t2.oogdsite=t0.deaqsite AND t2.oogd001=t0.deaq001  ",
 
                  " WHERE t0.deaqent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deaq_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deaqstus,t0.deaqsite,t0.deaqdocno,t0.deaqdocdt,t0.deaq001,t1.ooefl003 , 
          t2.oogd002 ",
                  " FROM deaq_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deaqsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oogd_t t2 ON t2.oogdent="||g_enterprise||" AND t2.oogdsite=t0.deaqsite AND t2.oogd001=t0.deaq001  ",
 
                  " WHERE t0.deaqent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("deaq_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql CLIPPED," AND ",l_where
   #end add-point
   LET g_sql = g_sql, " ORDER BY deaqdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"deaq_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_deaqsite,g_browser[g_cnt].b_deaqdocno, 
          g_browser[g_cnt].b_deaqdocdt,g_browser[g_cnt].b_deaq001,g_browser[g_cnt].b_deaqsite_desc,g_browser[g_cnt].b_deaq001_desc 
 
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
         CALL adet400_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_deaqdocno) THEN
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
 
{<section id="adet400.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adet400_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_deaq_m.deaqdocno = g_browser[g_current_idx].b_deaqdocno   
 
   EXECUTE adet400_master_referesh USING g_deaq_m.deaqdocno INTO g_deaq_m.deaqsite,g_deaq_m.deaqdocdt, 
       g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqowndp, 
       g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt,g_deaq_m.deaqsite_desc,g_deaq_m.deaq001_desc,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqmodid_desc, 
       g_deaq_m.deaqcnfid_desc
   
   CALL adet400_deaq_t_mask()
   CALL adet400_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adet400.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adet400_ui_detailshow()
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
 
{<section id="adet400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adet400_ui_browser_refresh()
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
      IF g_browser[l_i].b_deaqdocno = g_deaq_m.deaqdocno 
 
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
 
{<section id="adet400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adet400_construct()
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
   INITIALIZE g_deaq_m.* TO NULL
   CALL g_dear_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON deaqsite,deaqdocdt,deaqdocno,deaq001,deaqunit,deaqstus,deaqownid,deaqowndp, 
          deaqcrtid,deaqcrtdp,deaqcrtdt,deaqmodid,deaqmoddt,deaqcnfid,deaqcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<deaqcrtdt>>----
         AFTER FIELD deaqcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<deaqmoddt>>----
         AFTER FIELD deaqmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deaqcnfdt>>----
         AFTER FIELD deaqcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deaqpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqsite
            #add-point:BEFORE FIELD deaqsite name="construct.b.deaqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqsite
            
            #add-point:AFTER FIELD deaqsite name="construct.a.deaqsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqsite
            #add-point:ON ACTION controlp INFIELD deaqsite name="construct.c.deaqsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deaqsite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO deaqsite  #顯示到畫面上
            NEXT FIELD deaqsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqdocdt
            #add-point:BEFORE FIELD deaqdocdt name="construct.b.deaqdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqdocdt
            
            #add-point:AFTER FIELD deaqdocdt name="construct.a.deaqdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaqdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqdocdt
            #add-point:ON ACTION controlp INFIELD deaqdocdt name="construct.c.deaqdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaqdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqdocno
            #add-point:ON ACTION controlp INFIELD deaqdocno name="construct.c.deaqdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_deaqdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaqdocno  #顯示到畫面上

            NEXT FIELD deaqdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqdocno
            #add-point:BEFORE FIELD deaqdocno name="construct.b.deaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqdocno
            
            #add-point:AFTER FIELD deaqdocno name="construct.a.deaqdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaq001
            #add-point:ON ACTION controlp INFIELD deaq001 name="construct.c.deaq001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_deaq_m.deaqsite
            CALL q_oogd001_02()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaq001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oogd002 #班別說明 

            NEXT FIELD deaq001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaq001
            #add-point:BEFORE FIELD deaq001 name="construct.b.deaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaq001
            
            #add-point:AFTER FIELD deaq001 name="construct.a.deaq001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqunit
            #add-point:BEFORE FIELD deaqunit name="construct.b.deaqunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqunit
            
            #add-point:AFTER FIELD deaqunit name="construct.a.deaqunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaqunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqunit
            #add-point:ON ACTION controlp INFIELD deaqunit name="construct.c.deaqunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqstus
            #add-point:BEFORE FIELD deaqstus name="construct.b.deaqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqstus
            
            #add-point:AFTER FIELD deaqstus name="construct.a.deaqstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqstus
            #add-point:ON ACTION controlp INFIELD deaqstus name="construct.c.deaqstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaqownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqownid
            #add-point:ON ACTION controlp INFIELD deaqownid name="construct.c.deaqownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaqownid  #顯示到畫面上

            NEXT FIELD deaqownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqownid
            #add-point:BEFORE FIELD deaqownid name="construct.b.deaqownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqownid
            
            #add-point:AFTER FIELD deaqownid name="construct.a.deaqownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaqowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqowndp
            #add-point:ON ACTION controlp INFIELD deaqowndp name="construct.c.deaqowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaqowndp  #顯示到畫面上

            NEXT FIELD deaqowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqowndp
            #add-point:BEFORE FIELD deaqowndp name="construct.b.deaqowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqowndp
            
            #add-point:AFTER FIELD deaqowndp name="construct.a.deaqowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaqcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqcrtid
            #add-point:ON ACTION controlp INFIELD deaqcrtid name="construct.c.deaqcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaqcrtid  #顯示到畫面上

            NEXT FIELD deaqcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqcrtid
            #add-point:BEFORE FIELD deaqcrtid name="construct.b.deaqcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqcrtid
            
            #add-point:AFTER FIELD deaqcrtid name="construct.a.deaqcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaqcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqcrtdp
            #add-point:ON ACTION controlp INFIELD deaqcrtdp name="construct.c.deaqcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaqcrtdp  #顯示到畫面上

            NEXT FIELD deaqcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqcrtdp
            #add-point:BEFORE FIELD deaqcrtdp name="construct.b.deaqcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqcrtdp
            
            #add-point:AFTER FIELD deaqcrtdp name="construct.a.deaqcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqcrtdt
            #add-point:BEFORE FIELD deaqcrtdt name="construct.b.deaqcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaqmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqmodid
            #add-point:ON ACTION controlp INFIELD deaqmodid name="construct.c.deaqmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaqmodid  #顯示到畫面上

            NEXT FIELD deaqmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqmodid
            #add-point:BEFORE FIELD deaqmodid name="construct.b.deaqmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqmodid
            
            #add-point:AFTER FIELD deaqmodid name="construct.a.deaqmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqmoddt
            #add-point:BEFORE FIELD deaqmoddt name="construct.b.deaqmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaqcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqcnfid
            #add-point:ON ACTION controlp INFIELD deaqcnfid name="construct.c.deaqcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaqcnfid  #顯示到畫面上
            NEXT FIELD deaqcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqcnfid
            #add-point:BEFORE FIELD deaqcnfid name="construct.b.deaqcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqcnfid
            
            #add-point:AFTER FIELD deaqcnfid name="construct.a.deaqcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqcnfdt
            #add-point:BEFORE FIELD deaqcnfdt name="construct.b.deaqcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON dearseq,dear000,dear001,dear002,dear003,dear006,dear004,dear005,dear007, 
          dear009,dear008,dearsite,dearunit
           FROM s_detail1[1].dearseq,s_detail1[1].dear000,s_detail1[1].dear001,s_detail1[1].dear002, 
               s_detail1[1].dear003,s_detail1[1].dear006,s_detail1[1].dear004,s_detail1[1].dear005,s_detail1[1].dear007, 
               s_detail1[1].dear009,s_detail1[1].dear008,s_detail1[1].dearsite,s_detail1[1].dearunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dearseq
            #add-point:BEFORE FIELD dearseq name="construct.b.page1.dearseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dearseq
            
            #add-point:AFTER FIELD dearseq name="construct.a.page1.dearseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dearseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dearseq
            #add-point:ON ACTION controlp INFIELD dearseq name="construct.c.page1.dearseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dear000
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear000
            #add-point:ON ACTION controlp INFIELD dear000 name="construct.c.page1.dear000"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dear000  #顯示到畫面上
            NEXT FIELD dear000                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear000
            #add-point:BEFORE FIELD dear000 name="construct.b.page1.dear000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear000
            
            #add-point:AFTER FIELD dear000 name="construct.a.page1.dear000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear001
            #add-point:ON ACTION controlp INFIELD dear001 name="construct.c.page1.dear001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_deaq_m.deaqsite
            CALL q_pcab001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dear001  #顯示到畫面上

            NEXT FIELD dear001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear001
            #add-point:BEFORE FIELD dear001 name="construct.b.page1.dear001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear001
            
            #add-point:AFTER FIELD dear001 name="construct.a.page1.dear001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear002
            #add-point:BEFORE FIELD dear002 name="construct.b.page1.dear002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear002
            
            #add-point:AFTER FIELD dear002 name="construct.a.page1.dear002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear002
            #add-point:ON ACTION controlp INFIELD dear002 name="construct.c.page1.dear002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dear003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear003
            #add-point:ON ACTION controlp INFIELD dear003 name="construct.c.page1.dear003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#			LET g_qryparam.arg1 = '10'
#			LET g_qryparam.arg2 = g_deaq_m.deaqsite
#            CALL q_ooie001_4()                      #呼叫開窗
#add by yangxf ---
            LET g_qryparam.where = " ooia002 = '10' "                  
            CALL q_ooia001_03()
#add by yangxf ---            
            DISPLAY g_qryparam.return1 TO dear003  #顯示到畫面上

            NEXT FIELD dear003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear003
            #add-point:BEFORE FIELD dear003 name="construct.b.page1.dear003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear003
            
            #add-point:AFTER FIELD dear003 name="construct.a.page1.dear003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear006
            #add-point:ON ACTION controlp INFIELD dear006 name="construct.c.page1.dear006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dear006  #顯示到畫面上

            NEXT FIELD dear006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear006
            #add-point:BEFORE FIELD dear006 name="construct.b.page1.dear006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear006
            
            #add-point:AFTER FIELD dear006 name="construct.a.page1.dear006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear004
            #add-point:ON ACTION controlp INFIELD dear004 name="construct.c.page1.dear004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2071" 
            LET g_qryparam.arg2 = "10"
            LET g_qryparam.arg3 = g_dear_d[l_ac].dear006
            
            CALL q_oocq002_17()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dear004  #顯示到畫面上

            NEXT FIELD dear004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear004
            #add-point:BEFORE FIELD dear004 name="construct.b.page1.dear004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear004
            
            #add-point:AFTER FIELD dear004 name="construct.a.page1.dear004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear005
            #add-point:BEFORE FIELD dear005 name="construct.b.page1.dear005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear005
            
            #add-point:AFTER FIELD dear005 name="construct.a.page1.dear005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear005
            #add-point:ON ACTION controlp INFIELD dear005 name="construct.c.page1.dear005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear007
            #add-point:BEFORE FIELD dear007 name="construct.b.page1.dear007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear007
            
            #add-point:AFTER FIELD dear007 name="construct.a.page1.dear007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear007
            #add-point:ON ACTION controlp INFIELD dear007 name="construct.c.page1.dear007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear009
            #add-point:BEFORE FIELD dear009 name="construct.b.page1.dear009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear009
            
            #add-point:AFTER FIELD dear009 name="construct.a.page1.dear009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear009
            #add-point:ON ACTION controlp INFIELD dear009 name="construct.c.page1.dear009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear008
            #add-point:BEFORE FIELD dear008 name="construct.b.page1.dear008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear008
            
            #add-point:AFTER FIELD dear008 name="construct.a.page1.dear008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dear008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear008
            #add-point:ON ACTION controlp INFIELD dear008 name="construct.c.page1.dear008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dearsite
            #add-point:BEFORE FIELD dearsite name="construct.b.page1.dearsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dearsite
            
            #add-point:AFTER FIELD dearsite name="construct.a.page1.dearsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dearsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dearsite
            #add-point:ON ACTION controlp INFIELD dearsite name="construct.c.page1.dearsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dearunit
            #add-point:BEFORE FIELD dearunit name="construct.b.page1.dearunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dearunit
            
            #add-point:AFTER FIELD dearunit name="construct.a.page1.dearunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dearunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dearunit
            #add-point:ON ACTION controlp INFIELD dearunit name="construct.c.page1.dearunit"
            
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
                  WHEN la_wc[li_idx].tableid = "deaq_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "dear_t" 
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
 
{<section id="adet400.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION adet400_filter()
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
      CONSTRUCT g_wc_filter ON deaqsite,deaqdocno,deaqdocdt,deaq001
                          FROM s_browse[1].b_deaqsite,s_browse[1].b_deaqdocno,s_browse[1].b_deaqdocdt, 
                              s_browse[1].b_deaq001
 
         BEFORE CONSTRUCT
               DISPLAY adet400_filter_parser('deaqsite') TO s_browse[1].b_deaqsite
            DISPLAY adet400_filter_parser('deaqdocno') TO s_browse[1].b_deaqdocno
            DISPLAY adet400_filter_parser('deaqdocdt') TO s_browse[1].b_deaqdocdt
            DISPLAY adet400_filter_parser('deaq001') TO s_browse[1].b_deaq001
      
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
 
      CALL adet400_filter_show('deaqsite')
   CALL adet400_filter_show('deaqdocno')
   CALL adet400_filter_show('deaqdocdt')
   CALL adet400_filter_show('deaq001')
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adet400_filter_parser(ps_field)
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
 
{<section id="adet400.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adet400_filter_show(ps_field)
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
   LET ls_condition = adet400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adet400_query()
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
   CALL g_dear_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adet400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adet400_browser_fill("")
      CALL adet400_fetch("")
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
      CALL adet400_filter_show('deaqsite')
   CALL adet400_filter_show('deaqdocno')
   CALL adet400_filter_show('deaqdocdt')
   CALL adet400_filter_show('deaq001')
   CALL adet400_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adet400_fetch("F") 
      #顯示單身筆數
      CALL adet400_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adet400_fetch(p_flag)
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
   
   LET g_deaq_m.deaqdocno = g_browser[g_current_idx].b_deaqdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adet400_master_referesh USING g_deaq_m.deaqdocno INTO g_deaq_m.deaqsite,g_deaq_m.deaqdocdt, 
       g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqowndp, 
       g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt,g_deaq_m.deaqsite_desc,g_deaq_m.deaq001_desc,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqmodid_desc, 
       g_deaq_m.deaqcnfid_desc
   
   #遮罩相關處理
   LET g_deaq_m_mask_o.* =  g_deaq_m.*
   CALL adet400_deaq_t_mask()
   LET g_deaq_m_mask_n.* =  g_deaq_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet400_set_act_visible()   
   CALL adet400_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #IF g_deaq_m.deaqstus = 'N' THEN
   IF g_deaq_m.deaqstus MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_deaq_m_t.* = g_deaq_m.*
   LET g_deaq_m_o.* = g_deaq_m.*
   
   LET g_data_owner = g_deaq_m.deaqownid      
   LET g_data_dept  = g_deaq_m.deaqowndp
   
   #重新顯示   
   CALL adet400_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.insert" >}
#+ 資料新增
PRIVATE FUNCTION adet400_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004 
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_dear_d.clear()   
 
 
   INITIALIZE g_deaq_m.* TO NULL             #DEFAULT 設定
   
   LET g_deaqdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deaq_m.deaqownid = g_user
      LET g_deaq_m.deaqowndp = g_dept
      LET g_deaq_m.deaqcrtid = g_user
      LET g_deaq_m.deaqcrtdp = g_dept 
      LET g_deaq_m.deaqcrtdt = cl_get_current()
      LET g_deaq_m.deaqmodid = g_user
      LET g_deaq_m.deaqmoddt = cl_get_current()
      LET g_deaq_m.deaqstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_deaq_m.deaqsite = g_site
      LET g_deaq_m.deaqdocdt = g_today
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog,'deaqsite',g_site)
       RETURNING l_insert,g_deaq_m.deaqsite
      IF NOT l_insert THEN
        RETURN
      END IF
      CALL adet400_deaqsite_ref()

      LET g_deaq_m.deaqdocdt = g_today
      LET g_deaq_m.deaqstus = "N"
           
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_deaq_m.deaqsite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_deaq_m.deaqdocno = l_doctype
      
      LET g_deaq_m_t.* = g_deaq_m.* 
      LET g_deaq_m_o.* = g_deaq_m.* 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_deaq_m_t.* = g_deaq_m.*
      LET g_deaq_m_o.* = g_deaq_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deaq_m.deaqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL adet400_input("a")
      
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
         INITIALIZE g_deaq_m.* TO NULL
         INITIALIZE g_dear_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adet400_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_dear_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet400_set_act_visible()   
   CALL adet400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deaqent = " ||g_enterprise|| " AND",
                      " deaqdocno = '", g_deaq_m.deaqdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adet400_cl
   
   CALL adet400_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adet400_master_referesh USING g_deaq_m.deaqdocno INTO g_deaq_m.deaqsite,g_deaq_m.deaqdocdt, 
       g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqowndp, 
       g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt,g_deaq_m.deaqsite_desc,g_deaq_m.deaq001_desc,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqmodid_desc, 
       g_deaq_m.deaqcnfid_desc
   
   
   #遮罩相關處理
   LET g_deaq_m_mask_o.* =  g_deaq_m.*
   CALL adet400_deaq_t_mask()
   LET g_deaq_m_mask_n.* =  g_deaq_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deaq_m.deaqsite,g_deaq_m.deaqsite_desc,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001, 
       g_deaq_m.deaq001_desc,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp,g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp, 
       g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmodid_desc,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfid_desc,g_deaq_m.deaqcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_deaq_m.deaqownid      
   LET g_data_dept  = g_deaq_m.deaqowndp
   
   #功能已完成,通報訊息中心
   CALL adet400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.modify" >}
#+ 資料修改
PRIVATE FUNCTION adet400_modify()
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
   LET g_deaq_m_t.* = g_deaq_m.*
   LET g_deaq_m_o.* = g_deaq_m.*
   
   IF g_deaq_m.deaqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
   CALL s_transaction_begin()
   
   OPEN adet400_cl USING g_enterprise,g_deaq_m.deaqdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet400_master_referesh USING g_deaq_m.deaqdocno INTO g_deaq_m.deaqsite,g_deaq_m.deaqdocdt, 
       g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqowndp, 
       g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt,g_deaq_m.deaqsite_desc,g_deaq_m.deaq001_desc,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqmodid_desc, 
       g_deaq_m.deaqcnfid_desc
   
   #檢查是否允許此動作
   IF NOT adet400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deaq_m_mask_o.* =  g_deaq_m.*
   CALL adet400_deaq_t_mask()
   LET g_deaq_m_mask_n.* =  g_deaq_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL adet400_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_deaq_m.deaqmodid = g_user 
LET g_deaq_m.deaqmoddt = cl_get_current()
LET g_deaq_m.deaqmodid_desc = cl_get_username(g_deaq_m.deaqmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_deaq_m.deaqstus MATCHES "[DR]" THEN 
         LET g_deaq_m.deaqstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adet400_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE deaq_t SET (deaqmodid,deaqmoddt) = (g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt)
          WHERE deaqent = g_enterprise AND deaqdocno = g_deaqdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_deaq_m.* = g_deaq_m_t.*
            CALL adet400_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_deaq_m.deaqdocno != g_deaq_m_t.deaqdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE dear_t SET deardocno = g_deaq_m.deaqdocno
 
          WHERE dearent = g_enterprise AND deardocno = g_deaq_m_t.deaqdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "dear_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dear_t:",SQLERRMESSAGE 
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
   CALL adet400_set_act_visible()   
   CALL adet400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " deaqent = " ||g_enterprise|| " AND",
                      " deaqdocno = '", g_deaq_m.deaqdocno, "' "
 
   #填到對應位置
   CALL adet400_browser_fill("")
 
   CLOSE adet400_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet400_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adet400.input" >}
#+ 資料輸入
PRIVATE FUNCTION adet400_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooef004             LIKE ooef_t.ooef004 
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_no                  LIKE type_t.chr10
   DEFINE  l_ooia002             LIKE ooia_t.ooia002   
   DEFINE  l_str                 STRING 
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
   DISPLAY BY NAME g_deaq_m.deaqsite,g_deaq_m.deaqsite_desc,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001, 
       g_deaq_m.deaq001_desc,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp,g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp, 
       g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmodid_desc,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfid_desc,g_deaq_m.deaqcnfdt
   
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
   LET g_forupd_sql = "SELECT dearseq,dear000,dear001,dear002,dear003,dear006,dear004,dear005,dear007, 
       dear009,dear008,dearsite,dearunit FROM dear_t WHERE dearent=? AND deardocno=? AND dearseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet400_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   LET g_flag = FALSE
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adet400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adet400_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_deaq_m.deaqsite,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit, 
       g_deaq_m.deaqstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adet400.input.head" >}
      #單頭段
      INPUT BY NAME g_deaq_m.deaqsite,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit, 
          g_deaq_m.deaqstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adet400_cl USING g_enterprise,g_deaq_m.deaqdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adet400_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL adet400_set_entry(p_cmd)
            CALL adet400_set_no_entry(p_cmd)
            #end add-point
            CALL adet400_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqsite
            
            #add-point:AFTER FIELD deaqsite name="input.a.deaqsite"
            IF NOT cl_null(g_deaq_m.deaqsite) THEN 
              IF (g_deaq_m.deaqsite != g_deaq_m_t.deaqsite OR cl_null(g_deaq_m_t.deaqsite)) THEN
                 CALL s_aooi500_chk(g_prog,'deaqsite',g_deaq_m.deaqsite,g_deaq_m.deaqsite) RETURNING l_success,l_errno
                 IF NOT l_success THEN
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = '' 
                    LET g_errparam.code   = l_errno 
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    
                    LET g_deaq_m.deaqsite = g_deaq_m_t.deaqsite
                    DISPLAY BY NAME g_deaq_m.deaqsite
                    NEXT FIELD CURRENT
                 END IF
              END IF
              IF NOT cl_null(g_deaq_m.deaqdocdt) AND NOT cl_null(g_deaq_m.deaqsite) THEN
                 IF NOT s_settledate_chk(g_deaq_m.deaqsite,g_deaq_m.deaqdocdt) THEN
                    LET g_deaq_m.deaqsite = g_deaq_m_t.deaqsite
                    DISPLAY BY NAME g_deaq_m.deaqsite
                    NEXT FIELD CURRENT
                 END IF
              END IF
            ELSE
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'axc-00120' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()               
               LET g_deaq_m.deaqsite = g_deaq_m_t.deaqsite
               DISPLAY BY NAME g_deaq_m.deaqsite
               NEXT FIELD CURRENT
            END IF
            CALL adet400_deaqsite_ref()
            LET g_flag = TRUE
            CALL adet400_set_entry(p_cmd)
            CALL adet400_set_no_entry(p_cmd)  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqsite
            #add-point:BEFORE FIELD deaqsite name="input.b.deaqsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaqsite
            #add-point:ON CHANGE deaqsite name="input.g.deaqsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqdocdt
            #add-point:BEFORE FIELD deaqdocdt name="input.b.deaqdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqdocdt
            
            #add-point:AFTER FIELD deaqdocdt name="input.a.deaqdocdt"
            IF NOT cl_null(g_deaq_m.deaqdocdt) AND NOT cl_null(g_deaq_m.deaqsite) THEN
               IF NOT s_settledate_chk(g_deaq_m.deaqsite,g_deaq_m.deaqdocdt) THEN
                   LET g_deaq_m.deaqdocdt = g_deaq_m_t.deaqdocdt
                   DISPLAY BY NAME g_deaq_m.deaqdocdt
                   NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaqdocdt
            #add-point:ON CHANGE deaqdocdt name="input.g.deaqdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqdocno
            #add-point:BEFORE FIELD deaqdocno name="input.b.deaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqdocno
            
            #add-point:AFTER FIELD deaqdocno name="input.a.deaqdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_deaq_m.deaqdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_deaq_m.deaqdocno != g_deaqdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deaq_t WHERE "||"deaqent = '" ||g_enterprise|| "' AND "||"deaqdocno = '"||g_deaq_m.deaqdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT s_aooi200_chk_slip(g_deaq_m.deaqsite,'',g_deaq_m.deaqdocno,g_prog) THEN
               LET g_deaq_m.deaqdocno = ''
               NEXT FIELD CURRENT 
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaqdocno
            #add-point:ON CHANGE deaqdocno name="input.g.deaqdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaq001
            
            #add-point:AFTER FIELD deaq001 name="input.a.deaq001"

            IF NOT cl_null(g_deaq_m.deaq001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_deaq_m.deaqsite
               LET g_chkparam.arg2 = g_deaq_m.deaq001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oogd001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  LET g_deaq_m.deaq001 = g_deaq_m_t.deaq001
                  DISPLAY BY NAME g_deaq_m.deaq001
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL adet400_deaq001_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaq001
            #add-point:BEFORE FIELD deaq001 name="input.b.deaq001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaq001
            #add-point:ON CHANGE deaq001 name="input.g.deaq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqunit
            #add-point:BEFORE FIELD deaqunit name="input.b.deaqunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqunit
            
            #add-point:AFTER FIELD deaqunit name="input.a.deaqunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaqunit
            #add-point:ON CHANGE deaqunit name="input.g.deaqunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaqstus
            #add-point:BEFORE FIELD deaqstus name="input.b.deaqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaqstus
            
            #add-point:AFTER FIELD deaqstus name="input.a.deaqstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaqstus
            #add-point:ON CHANGE deaqstus name="input.g.deaqstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deaqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqsite
            #add-point:ON ACTION controlp INFIELD deaqsite name="input.c.deaqsite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deaq_m.deaqsite             #給予default值
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deaqsite',g_site,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()
            LET g_deaq_m.deaqsite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_deaq_m.deaqsite TO deaqsite              #顯示到畫面上
            CALL adet400_deaqsite_ref()
            NEXT FIELD deaqsite                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.deaqdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqdocdt
            #add-point:ON ACTION controlp INFIELD deaqdocdt name="input.c.deaqdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.deaqdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqdocno
            #add-point:ON ACTION controlp INFIELD deaqdocno name="input.c.deaqdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deaq_m.deaqdocno             #給予default值

            #給予arg
            CALL s_aooi100_sel_ooef004(g_deaq_m.deaqsite)
                 RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004 
            #LET g_qryparam.arg2 = "adet400"     #160705-00042#1 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#1 160711 by sakura add            

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_deaq_m.deaqdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deaq_m.deaqdocno TO deaqdocno              #顯示到畫面上
            
            NEXT FIELD deaqdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaq001
            #add-point:ON ACTION controlp INFIELD deaq001 name="input.c.deaq001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deaq_m.deaq001             #給予default值
            LET g_qryparam.default2 = "" #g_deaq_m.oogd002 #班別說明

            #給予arg
            LET g_qryparam.arg1 = g_deaq_m.deaqsite
            CALL q_oogd001_02()                                #呼叫開窗

            LET g_deaq_m.deaq001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_deaq_m.oogd002 = g_qryparam.return2 #班別說明

            DISPLAY g_deaq_m.deaq001 TO deaq001              #顯示到畫面上
            #DISPLAY g_deaq_m.oogd002 TO oogd002 #班別說明
            CALL adet400_deaq001_ref()
            NEXT FIELD deaq001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deaqunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqunit
            #add-point:ON ACTION controlp INFIELD deaqunit name="input.c.deaqunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.deaqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaqstus
            #add-point:ON ACTION controlp INFIELD deaqstus name="input.c.deaqstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_deaq_m.deaqdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               IF NOT s_aooi200_chk_slip(g_deaq_m.deaqsite,'',g_deaq_m.deaqdocno,g_prog) THEN
                  LET g_deaq_m.deaqdocno = ''
                  NEXT FIELD deaqdocno 
               END IF
               
               CALL s_aooi200_gen_docno(g_deaq_m.deaqsite,g_deaq_m.deaqdocno,g_deaq_m.deaqdocdt,g_prog) RETURNING l_flag,g_deaq_m.deaqdocno
               IF NOT l_flag THEN
                  NEXT FIELD deaqdocno
               END IF  
               LET g_deaq_m.deaqunit = g_deaq_m.deaqsite
               #end add-point
               
               INSERT INTO deaq_t (deaqent,deaqsite,deaqdocdt,deaqdocno,deaq001,deaqunit,deaqstus,deaqownid, 
                   deaqowndp,deaqcrtid,deaqcrtdp,deaqcrtdt,deaqmodid,deaqmoddt,deaqcnfid,deaqcnfdt)
               VALUES (g_enterprise,g_deaq_m.deaqsite,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001, 
                   g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqowndp,g_deaq_m.deaqcrtid, 
                   g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt,g_deaq_m.deaqcnfid, 
                   g_deaq_m.deaqcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_deaq_m:",SQLERRMESSAGE 
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
                  CALL adet400_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adet400_b_fill()
                  CALL adet400_b_fill2('0')
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
               CALL adet400_deaq_t_mask_restore('restore_mask_o')
               
               UPDATE deaq_t SET (deaqsite,deaqdocdt,deaqdocno,deaq001,deaqunit,deaqstus,deaqownid,deaqowndp, 
                   deaqcrtid,deaqcrtdp,deaqcrtdt,deaqmodid,deaqmoddt,deaqcnfid,deaqcnfdt) = (g_deaq_m.deaqsite, 
                   g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus, 
                   g_deaq_m.deaqownid,g_deaq_m.deaqowndp,g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt, 
                   g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt,g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt)
                WHERE deaqent = g_enterprise AND deaqdocno = g_deaqdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "deaq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adet400_deaq_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_deaq_m_t)
               LET g_log2 = util.JSON.stringify(g_deaq_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adet400.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_dear_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dear_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adet400_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_dear_d.getLength()
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
            OPEN adet400_cl USING g_enterprise,g_deaq_m.deaqdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_dear_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_dear_d[l_ac].dearseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dear_d_t.* = g_dear_d[l_ac].*  #BACKUP
               LET g_dear_d_o.* = g_dear_d[l_ac].*  #BACKUP
               CALL adet400_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL adet400_set_no_entry_b(l_cmd)
               IF NOT adet400_lock_b("dear_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adet400_bcl INTO g_dear_d[l_ac].dearseq,g_dear_d[l_ac].dear000,g_dear_d[l_ac].dear001, 
                      g_dear_d[l_ac].dear002,g_dear_d[l_ac].dear003,g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear004, 
                      g_dear_d[l_ac].dear005,g_dear_d[l_ac].dear007,g_dear_d[l_ac].dear009,g_dear_d[l_ac].dear008, 
                      g_dear_d[l_ac].dearsite,g_dear_d[l_ac].dearunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dear_d_t.dearseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dear_d_mask_o[l_ac].* =  g_dear_d[l_ac].*
                  CALL adet400_dear_t_mask()
                  LET g_dear_d_mask_n[l_ac].* =  g_dear_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adet400_show()
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
            INITIALIZE g_dear_d[l_ac].* TO NULL 
            INITIALIZE g_dear_d_t.* TO NULL 
            INITIALIZE g_dear_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_dear_d[l_ac].dear002 = "10"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_dear_d_t.* = g_dear_d[l_ac].*     #新輸入資料
            LET g_dear_d_o.* = g_dear_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adet400_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL adet400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dear_d[li_reproduce_target].* = g_dear_d[li_reproduce].*
 
               LET g_dear_d[li_reproduce_target].dearseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #IF l_cmd = 'a' THEN
               SELECT MAX(dearseq)+1 INTO g_dear_d[l_ac].dearseq FROM dear_t 
                WHERE dearent = g_enterprise AND deardocno = g_deaq_m.deaqdocno
               IF cl_null(g_dear_d[l_ac].dearseq) THEN
                  LET g_dear_d[l_ac].dearseq = 1
               END IF
            #END IF 
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
            LET g_dear_d[l_ac].dearsite = g_deaq_m.deaqsite
            LET g_dear_d[l_ac].dearunit = g_deaq_m.deaqsite
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM dear_t 
             WHERE dearent = g_enterprise AND deardocno = g_deaq_m.deaqdocno
 
               AND dearseq = g_dear_d[l_ac].dearseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deaq_m.deaqdocno
               LET gs_keys[2] = g_dear_d[g_detail_idx].dearseq
               CALL adet400_insert_b('dear_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_dear_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dear_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adet400_b_fill()
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
               LET gs_keys[01] = g_deaq_m.deaqdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_dear_d_t.dearseq
 
            
               #刪除同層單身
               IF NOT adet400_delete_b('dear_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet400_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adet400_key_delete_b(gs_keys,'dear_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet400_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adet400_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_dear_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_dear_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dearseq
            #add-point:BEFORE FIELD dearseq name="input.b.page1.dearseq"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dearseq
            
            #add-point:AFTER FIELD dearseq name="input.a.page1.dearseq"
            #此段落由子樣板a05產生
            IF  g_deaq_m.deaqdocno IS NOT NULL AND g_dear_d[g_detail_idx].dearseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_deaq_m.deaqdocno != g_deaqdocno_t OR g_dear_d[g_detail_idx].dearseq != g_dear_d_t.dearseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dear_t WHERE "||"dearent = '" ||g_enterprise|| "' AND "||"deardocno = '"||g_deaq_m.deaqdocno ||"' AND "|| "dearseq = '"||g_dear_d[g_detail_idx].dearseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dearseq
            #add-point:ON CHANGE dearseq name="input.g.page1.dearseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear000
            
            #add-point:AFTER FIELD dear000 name="input.a.page1.dear000"
            #160511-00031#1 160512 by sakura add(S)
            IF NOT cl_null(g_dear_d[l_ac].dear000) THEN           
               IF g_dear_d[l_ac].dear000 != g_dear_d_o.dear000 OR cl_null(g_dear_d_o.dear000) THEN
                  INITIALIZE g_chkparam.* TO NULL
				      LET g_chkparam.arg1 = g_deaq_m.deaqsite
                  LET g_chkparam.arg2 = g_dear_d[l_ac].dear000
                  IF NOT cl_chk_exist("v_mhae001_1") THEN
                     LET g_dear_d[l_ac].dear000 = g_dear_d_o.dear000
                     NEXT FIELD dear000
                  END IF
			      END IF
			   END IF
            LET g_dear_d_o.dear000 = g_dear_d[l_ac].dear000
            #160511-00031#1 160512 by sakura add(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear000
            #add-point:BEFORE FIELD dear000 name="input.b.page1.dear000"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear000
            #add-point:ON CHANGE dear000 name="input.g.page1.dear000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear001
            
            #add-point:AFTER FIELD dear001 name="input.a.page1.dear001"
            IF NOT cl_null(g_dear_d[l_ac].dear001) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_dear_d[l_ac].dear001
               LET g_chkparam.arg2 = g_deaq_m.deaqsite

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pcab001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  LET g_dear_d[l_ac].dear001 = g_dear_d_t.dear001
                  LET g_dear_d[l_ac].dear001_desc = ""
                  DISPLAY BY NAME g_dear_d[l_ac].dear001,g_dear_d[l_ac].dear001_desc                    #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL adet400_dear001_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear001
            #add-point:BEFORE FIELD dear001 name="input.b.page1.dear001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear001
            #add-point:ON CHANGE dear001 name="input.g.page1.dear001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear002
            #add-point:BEFORE FIELD dear002 name="input.b.page1.dear002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear002
            
            #add-point:AFTER FIELD dear002 name="input.a.page1.dear002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear002
            #add-point:ON CHANGE dear002 name="input.g.page1.dear002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear003
            
            #add-point:AFTER FIELD dear003 name="input.a.page1.dear003"

            IF NOT cl_null(g_dear_d[l_ac].dear003) THEN 
##此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_dear_d[l_ac].dear003
#               LET g_chkparam.arg2 = g_dear_d[l_ac].dear002
#               LET g_chkparam.arg3 = g_deaq_m.deaqsite
#               LET g_chkparam.err_str[1] = "sub-00354|",g_dear_d[l_ac].dear002 
#               LET g_chkparam.err_str[2] = "sub-00355|",g_dear_d[l_ac].dear002 
#               
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooie001_4") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#
#               ELSE
#                  LET g_dear_d[l_ac].dear003 = g_dear_d_t.dear003
#                  LET g_dear_d[l_ac].dear003_desc = ""
#                  DISPLAY BY NAME g_dear_d[l_ac].dear003,g_dear_d[l_ac].dear003_desc  
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_money_chk('1',g_deaq_m.deaqsite,g_dear_d[l_ac].dear003) RETURNING l_success,g_errno,l_no,l_ooia002
               IF NOT l_success THEN
                  #檢查失敗時後續處理
                  LET g_dear_d[l_ac].dear003 = g_dear_d_t.dear003
                  LET g_dear_d[l_ac].dear003_desc = NULL 
                  LET g_dear_d[l_ac].dear006 = g_dear_d_t.dear006
                  LET g_dear_d[l_ac].dear006_desc  = g_dear_d_t.dear006_desc
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                  
                  DISPLAY BY NAME g_dear_d[l_ac].dear003,g_dear_d[l_ac].dear003_desc,g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear006_desc
                  NEXT FIELD CURRENT
               END IF 
               IF NOT cl_null(g_dear_d[l_ac].dear002) THEN
                  IF g_dear_d[l_ac].dear002 <> l_ooia002 THEN
                     LET g_dear_d[l_ac].dear003 = g_dear_d_t.dear003
                     LET g_dear_d[l_ac].dear003_desc = NULL 
                     LET g_dear_d[l_ac].dear006 = g_dear_d_t.dear006
                     LET g_dear_d[l_ac].dear006_desc  = g_dear_d_t.dear006_desc
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'ade-00068'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                  
                     DISPLAY BY NAME g_dear_d[l_ac].dear003,g_dear_d[l_ac].dear003_desc,g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_money_ooie_get(l_no,'ooie002',g_deaq_m.deaqsite,g_dear_d[l_ac].dear003) RETURNING g_dear_d[l_ac].dear006
               SELECT ooail003 INTO g_dear_d[l_ac].dear006_desc 
                 FROM ooail_t
                WHERE ooailent = g_enterprise 
                  AND ooail003 = g_dear_d[l_ac].dear006
                  AND ooail002 = g_dlang
               DISPLAY BY NAME g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear006_desc  
            ELSE
               LET g_dear_d[l_ac].dear006 = ''
               LET g_dear_d[l_ac].dear006_desc  = ''
               DISPLAY BY NAME g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear006_desc
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dear_d[l_ac].dear003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial003=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dear_d[l_ac].dear003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dear_d[l_ac].dear003_desc   
            CALL adet400_dear003_ref()


#            SELECT ooie002,ooail003 INTO g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear006_desc 
#              FROM ooie_t LEFT JOIN ooail_t ON ooieent = ooailent AND ooie002 = ooail001 AND ooail002 = g_dlang
#             WHERE ooieent = g_enterprise AND ooiesite = g_deaq_m.deaqsite AND ooie001 = g_dear_d[l_ac].dear003
#            DISPLAY BY NAME g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear006_desc 
            
            #匯率
            CALL adet400_dear009(g_dear_d[l_ac].dear006,g_deaq_m.deaqsite,g_deaq_m.deaqdocdt) RETURNING g_dear_d[l_ac].dear009
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear003
            #add-point:BEFORE FIELD dear003 name="input.b.page1.dear003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear003
            #add-point:ON CHANGE dear003 name="input.g.page1.dear003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear006
            
            #add-point:AFTER FIELD dear006 name="input.a.page1.dear006"
            CALL adet400_dear006_ref()

            
            #匯率
            CALL adet400_dear009(g_dear_d[l_ac].dear006,g_deaq_m.deaqsite,g_deaq_m.deaqdocdt) RETURNING g_dear_d[l_ac].dear009
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear006
            #add-point:BEFORE FIELD dear006 name="input.b.page1.dear006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear006
            #add-point:ON CHANGE dear006 name="input.g.page1.dear006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear004
            
            #add-point:AFTER FIELD dear004 name="input.a.page1.dear004"
            IF NOT cl_null(g_dear_d[l_ac].dear004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2071'
               LET g_chkparam.arg2 = g_dear_d[l_ac].dear004
               LET g_chkparam.arg3 = g_dear_d[l_ac].dear002
               LET g_chkparam.arg4 = g_dear_d[l_ac].dear006
               LET g_chkparam.err_str[1] = "aoo-00099:sub-00294|",s_azzi650_chk_exit_get_program('2071')   #150612-00018#1 15/06/23 s983961--add 替換錯誤訊息   
               #160318-00025#42  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#42  2016/04/25  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               
               ELSE
                  LET g_dear_d[l_ac].dear004 = g_dear_d_t.dear004
                  LET g_dear_d[l_ac].dear004_desc = ""
                  CALL adet400_dear004_ref()   #150612-00018#1 15/06/23 s983961--add
                  DISPLAY BY NAME g_dear_d[l_ac].dear004,g_dear_d[l_ac].dear004_desc  
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
              
              
               #單位金額
               SELECT oocq009 INTO g_dear_d[l_ac].dear005
                 FROM oocq_t 
                WHERE oocqent = g_enterprise 
                  AND oocq001 = '2071' 
                  AND oocq002 = g_dear_d[l_ac].dear004
               DISPLAY BY NAME g_dear_d[l_ac].dear005
               #金額
               IF NOT cl_null(g_dear_d[l_ac].dear005) AND NOT cl_null(g_dear_d[l_ac].dear007) THEN
                  LET g_dear_d[l_ac].dear008 = g_dear_d[l_ac].dear005*g_dear_d[l_ac].dear007
                  DISPLAY BY NAME g_dear_d[l_ac].dear008
               END IF
            ELSE
               LET g_dear_d[l_ac].dear005 = NULL
               LET g_dear_d[l_ac].dear008 = NULL
            END IF 

            CALL adet400_dear004_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear004
            #add-point:BEFORE FIELD dear004 name="input.b.page1.dear004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear004
            #add-point:ON CHANGE dear004 name="input.g.page1.dear004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_dear_d[l_ac].dear005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD dear005
            END IF 
 
 
 
            #add-point:AFTER FIELD dear005 name="input.a.page1.dear005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear005
            #add-point:BEFORE FIELD dear005 name="input.b.page1.dear005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear005
            #add-point:ON CHANGE dear005 name="input.g.page1.dear005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_dear_d[l_ac].dear007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD dear007
            END IF 
 
 
 
            #add-point:AFTER FIELD dear007 name="input.a.page1.dear007"
            IF NOT cl_ap_chk_Range(g_dear_d[l_ac].dear007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD dear007
            END IF
            IF NOT cl_null(g_dear_d[l_ac].dear005) AND NOT cl_null(g_dear_d[l_ac].dear007) THEN
               LET g_dear_d[l_ac].dear008 = g_dear_d[l_ac].dear005*g_dear_d[l_ac].dear007
               DISPLAY BY NAME g_dear_d[l_ac].dear008
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear007
            #add-point:BEFORE FIELD dear007 name="input.b.page1.dear007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear007
            #add-point:ON CHANGE dear007 name="input.g.page1.dear007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear009
            #add-point:BEFORE FIELD dear009 name="input.b.page1.dear009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear009
            
            #add-point:AFTER FIELD dear009 name="input.a.page1.dear009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear009
            #add-point:ON CHANGE dear009 name="input.g.page1.dear009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dear008
            #add-point:BEFORE FIELD dear008 name="input.b.page1.dear008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dear008
            
            #add-point:AFTER FIELD dear008 name="input.a.page1.dear008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dear008
            #add-point:ON CHANGE dear008 name="input.g.page1.dear008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dearsite
            #add-point:BEFORE FIELD dearsite name="input.b.page1.dearsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dearsite
            
            #add-point:AFTER FIELD dearsite name="input.a.page1.dearsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dearsite
            #add-point:ON CHANGE dearsite name="input.g.page1.dearsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dearunit
            #add-point:BEFORE FIELD dearunit name="input.b.page1.dearunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dearunit
            
            #add-point:AFTER FIELD dearunit name="input.a.page1.dearunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dearunit
            #add-point:ON CHANGE dearunit name="input.g.page1.dearunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dearseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dearseq
            #add-point:ON ACTION controlp INFIELD dearseq name="input.c.page1.dearseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dear000
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear000
            #add-point:ON ACTION controlp INFIELD dear000 name="input.c.page1.dear000"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_dear_d[l_ac].dear000             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " mhaestus = 'Y' AND mhaesite ='",g_deaq_m.deaqsite,"'"   #160511-00031#1 160512 by sakura add
            CALL q_mhae001_1()                                #呼叫開窗
 
            LET g_dear_d[l_ac].dear000 = g_qryparam.return1              

            DISPLAY g_dear_d[l_ac].dear000 TO dear000              #

            NEXT FIELD dear000                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.dear001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear001
            #add-point:ON ACTION controlp INFIELD dear001 name="input.c.page1.dear001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dear_d[l_ac].dear001             #給予default值
            LET g_qryparam.default2 = "" #g_dear_d[l_ac].pcab003 #收銀人員姓名

            #給予arg
            LET g_qryparam.arg1 = g_deaq_m.deaqsite
            CALL q_pcab001_2()                                #呼叫開窗

            LET g_dear_d[l_ac].dear001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_dear_d[l_ac].pcab003 = g_qryparam.return2 #收銀人員姓名

            DISPLAY g_dear_d[l_ac].dear001 TO dear001              #顯示到畫面上
            #DISPLAY g_dear_d[l_ac].pcab003 TO pcab003 #收銀人員姓名
            CALL adet400_dear001_ref()
            NEXT FIELD dear001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dear002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear002
            #add-point:ON ACTION controlp INFIELD dear002 name="input.c.page1.dear002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dear003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear003
            #add-point:ON ACTION controlp INFIELD dear003 name="input.c.page1.dear003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dear_d[l_ac].dear003             #給予default值

            #給予arg
#			LET g_qryparam.arg1 = '10'
#			LET g_qryparam.arg2 = g_deaq_m.deaqsite
#            CALL q_ooie001_4()                                #呼叫開窗
#add by yangxf ---
            CALL s_money_where(g_deaq_m.deaqsite) RETURNING l_str
            LET g_qryparam.where = l_str," AND ooia002 = '10' "                  
            CALL q_ooia001_03()                                #呼叫開窗
#add by yangxf ---
            LET g_dear_d[l_ac].dear003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_dear_d[l_ac].dear003 TO dear003              #顯示到畫面上
            CALL adet400_dear003_ref()
            NEXT FIELD dear003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dear006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear006
            #add-point:ON ACTION controlp INFIELD dear006 name="input.c.page1.dear006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dear_d[l_ac].dear006             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_dear_d[l_ac].dear006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_dear_d[l_ac].dear006 TO dear006              #顯示到畫面上
            CALL adet400_dear006_ref()
            NEXT FIELD dear006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dear004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear004
            #add-point:ON ACTION controlp INFIELD dear004 name="input.c.page1.dear004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dear_d[l_ac].dear004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2071" 
            LET g_qryparam.arg2 = g_dear_d[l_ac].dear002
            LET g_qryparam.arg3 = g_dear_d[l_ac].dear006

            CALL q_oocq002_17()                                #呼叫開窗

            LET g_dear_d[l_ac].dear004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_dear_d[l_ac].dear004 TO dear004              #顯示到畫面上
            CALL adet400_dear004_ref()
            NEXT FIELD dear004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dear005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear005
            #add-point:ON ACTION controlp INFIELD dear005 name="input.c.page1.dear005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dear007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear007
            #add-point:ON ACTION controlp INFIELD dear007 name="input.c.page1.dear007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dear009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear009
            #add-point:ON ACTION controlp INFIELD dear009 name="input.c.page1.dear009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dear008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dear008
            #add-point:ON ACTION controlp INFIELD dear008 name="input.c.page1.dear008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dearsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dearsite
            #add-point:ON ACTION controlp INFIELD dearsite name="input.c.page1.dearsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dearunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dearunit
            #add-point:ON ACTION controlp INFIELD dearunit name="input.c.page1.dearunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_dear_d[l_ac].* = g_dear_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adet400_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_dear_d[l_ac].dearseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_dear_d[l_ac].* = g_dear_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adet400_dear_t_mask_restore('restore_mask_o')
      
               UPDATE dear_t SET (deardocno,dearseq,dear000,dear001,dear002,dear003,dear006,dear004, 
                   dear005,dear007,dear009,dear008,dearsite,dearunit) = (g_deaq_m.deaqdocno,g_dear_d[l_ac].dearseq, 
                   g_dear_d[l_ac].dear000,g_dear_d[l_ac].dear001,g_dear_d[l_ac].dear002,g_dear_d[l_ac].dear003, 
                   g_dear_d[l_ac].dear006,g_dear_d[l_ac].dear004,g_dear_d[l_ac].dear005,g_dear_d[l_ac].dear007, 
                   g_dear_d[l_ac].dear009,g_dear_d[l_ac].dear008,g_dear_d[l_ac].dearsite,g_dear_d[l_ac].dearunit) 
 
                WHERE dearent = g_enterprise AND deardocno = g_deaq_m.deaqdocno 
 
                  AND dearseq = g_dear_d_t.dearseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_dear_d[l_ac].* = g_dear_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dear_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_dear_d[l_ac].* = g_dear_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dear_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deaq_m.deaqdocno
               LET gs_keys_bak[1] = g_deaqdocno_t
               LET gs_keys[2] = g_dear_d[g_detail_idx].dearseq
               LET gs_keys_bak[2] = g_dear_d_t.dearseq
               CALL adet400_update_b('dear_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adet400_dear_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_dear_d[g_detail_idx].dearseq = g_dear_d_t.dearseq 
 
                  ) THEN
                  LET gs_keys[01] = g_deaq_m.deaqdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_dear_d_t.dearseq
 
                  CALL adet400_key_update_b(gs_keys,'dear_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_deaq_m),util.JSON.stringify(g_dear_d_t)
               LET g_log2 = util.JSON.stringify(g_deaq_m),util.JSON.stringify(g_dear_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
             SELECT SUM(dear008*dear009) INTO g_total_amount
               FROM dear_t
              WHERE dearent = g_enterprise
                AND deardocno = g_deaq_m.deaqdocno
             IF cl_null(g_total_amount) THEN
                LET g_total_amount = 0
             END IF
             DISPLAY g_total_amount TO total_amount  
            #end add-point
            CALL adet400_unlock_b("dear_t","'1'")
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
               LET g_dear_d[li_reproduce_target].* = g_dear_d[li_reproduce].*
 
               LET g_dear_d[li_reproduce_target].dearseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dear_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dear_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="adet400.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD deaqsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dearseq
 
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD deaqdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dearseq
 
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
 
{<section id="adet400.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adet400_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adet400_b_fill() #單身填充
      CALL adet400_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adet400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            CALL adet400_deaqsite_ref()

            CALL adet400_deaq001_ref()

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaq_m.deaqownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deaq_m.deaqownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaq_m.deaqownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaq_m.deaqowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_deaq_m.deaqowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaq_m.deaqowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaq_m.deaqcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deaq_m.deaqcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaq_m.deaqcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaq_m.deaqcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_deaq_m.deaqcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaq_m.deaqcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaq_m.deaqmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deaq_m.deaqmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaq_m.deaqmodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_deaq_m_mask_o.* =  g_deaq_m.*
   CALL adet400_deaq_t_mask()
   LET g_deaq_m_mask_n.* =  g_deaq_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_deaq_m.deaqsite,g_deaq_m.deaqsite_desc,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001, 
       g_deaq_m.deaq001_desc,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp,g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp, 
       g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmodid_desc,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfid_desc,g_deaq_m.deaqcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deaq_m.deaqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dear_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

            CALL adet400_dear001_ref()
            CALL adet400_dear003_ref()
            CALL adet400_dear004_ref()
            CALL adet400_dear006_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adet400_detail_show()
 
   #add-point:show段之後 name="show.after"
   #總金額
   SELECT SUM(dear008*dear009) INTO g_total_amount
     FROM dear_t
    WHERE dearent = g_enterprise
      AND deardocno = g_deaq_m.deaqdocno
   IF cl_null(g_total_amount) THEN
      LET g_total_amount = 0
   END IF
   DISPLAY g_total_amount TO total_amount  
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adet400_detail_show()
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
 
{<section id="adet400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adet400_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE deaq_t.deaqdocno 
   DEFINE l_oldno     LIKE deaq_t.deaqdocno 
 
   DEFINE l_master    RECORD LIKE deaq_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE dear_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert    LIKE type_t.num5
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004 
   #ken---add---e
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
   
   IF g_deaq_m.deaqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
    
   LET g_deaq_m.deaqdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deaq_m.deaqownid = g_user
      LET g_deaq_m.deaqowndp = g_dept
      LET g_deaq_m.deaqcrtid = g_user
      LET g_deaq_m.deaqcrtdp = g_dept 
      LET g_deaq_m.deaqcrtdt = cl_get_current()
      LET g_deaq_m.deaqmodid = g_user
      LET g_deaq_m.deaqmoddt = cl_get_current()
      LET g_deaq_m.deaqstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   CALL s_aooi500_default(g_prog,'deaqsite',g_site)
    RETURNING l_insert,g_deaq_m.deaqsite
   IF NOT l_insert THEN
     RETURN
   END IF
       
   CALL adet400_deaqsite_ref()   
   LET g_deaq_m.deaqstus = "N"
   LET g_deaq_m.deaqcnfid = ""
   LET g_deaq_m.deaqcnfdt = ""
   #ken---add---s 需求單號：141125-00002 項次：4
   #預設單據的單別 
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_deaq_m.deaqsite,g_prog,'1')
        RETURNING l_success, l_doctype
   LET g_deaq_m.deaqdocno = l_doctype
   #ken---add---e
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deaq_m.deaqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL adet400_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_deaq_m.* TO NULL
      INITIALIZE g_dear_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adet400_show()
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
   CALL adet400_set_act_visible()   
   CALL adet400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deaqent = " ||g_enterprise|| " AND",
                      " deaqdocno = '", g_deaq_m.deaqdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adet400_idx_chk()
   
   LET g_data_owner = g_deaq_m.deaqownid      
   LET g_data_dept  = g_deaq_m.deaqowndp
   
   #功能已完成,通報訊息中心
   CALL adet400_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adet400_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE dear_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adet400_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM dear_t
    WHERE dearent = g_enterprise AND deardocno = g_deaqdocno_t
 
    INTO TEMP adet400_detail
 
   #將key修正為調整後   
   UPDATE adet400_detail 
      #更新key欄位
      SET deardocno = g_deaq_m.deaqdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO dear_t SELECT * FROM adet400_detail
   
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
   DROP TABLE adet400_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adet400_delete()
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
   
   IF g_deaq_m.deaqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adet400_cl USING g_enterprise,g_deaq_m.deaqdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet400_master_referesh USING g_deaq_m.deaqdocno INTO g_deaq_m.deaqsite,g_deaq_m.deaqdocdt, 
       g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqowndp, 
       g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt,g_deaq_m.deaqsite_desc,g_deaq_m.deaq001_desc,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqmodid_desc, 
       g_deaq_m.deaqcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT adet400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deaq_m_mask_o.* =  g_deaq_m.*
   CALL adet400_deaq_t_mask()
   LET g_deaq_m_mask_n.* =  g_deaq_m.*
   
   CALL adet400_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adet400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_deaqdocno_t = g_deaq_m.deaqdocno
 
 
      DELETE FROM deaq_t
       WHERE deaqent = g_enterprise AND deaqdocno = g_deaq_m.deaqdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_deaq_m.deaqdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM dear_t
       WHERE dearent = g_enterprise AND deardocno = g_deaq_m.deaqdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dear_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_deaq_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adet400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_dear_d.clear() 
 
     
      CALL adet400_ui_browser_refresh()  
      #CALL adet400_ui_headershow()  
      #CALL adet400_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adet400_browser_fill("")
         CALL adet400_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adet400_cl
 
   #功能已完成,通報訊息中心
   CALL adet400_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adet400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adet400_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_dear_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF adet400_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT dearseq,dear000,dear001,dear002,dear003,dear006,dear004,dear005, 
             dear007,dear009,dear008,dearsite,dearunit ,t1.pcab003 ,t2.ooial003 ,t3.ooail003 ,t4.oocql004 FROM dear_t", 
                
                     " INNER JOIN deaq_t ON deaqent = " ||g_enterprise|| " AND deaqdocno = deardocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN pcab_t t1 ON t1.pcabent="||g_enterprise||" AND t1.pcab001=dear001  ",
               " LEFT JOIN ooial_t t2 ON t2.ooialent="||g_enterprise||" AND t2.ooial001=dear003 AND t2.ooial002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=dear006 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2071' AND t4.oocql002=dear004 AND t4.oocql003='"||g_dlang||"' ",
 
                     " WHERE dearent=? AND deardocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY dear_t.dearseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adet400_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adet400_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_deaq_m.deaqdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_deaq_m.deaqdocno INTO g_dear_d[l_ac].dearseq,g_dear_d[l_ac].dear000, 
          g_dear_d[l_ac].dear001,g_dear_d[l_ac].dear002,g_dear_d[l_ac].dear003,g_dear_d[l_ac].dear006, 
          g_dear_d[l_ac].dear004,g_dear_d[l_ac].dear005,g_dear_d[l_ac].dear007,g_dear_d[l_ac].dear009, 
          g_dear_d[l_ac].dear008,g_dear_d[l_ac].dearsite,g_dear_d[l_ac].dearunit,g_dear_d[l_ac].dear001_desc, 
          g_dear_d[l_ac].dear003_desc,g_dear_d[l_ac].dear006_desc,g_dear_d[l_ac].dear004_desc   #(ver:78) 
 
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
   
   CALL g_dear_d.deleteElement(g_dear_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adet400_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_dear_d.getLength()
      LET g_dear_d_mask_o[l_ac].* =  g_dear_d[l_ac].*
      CALL adet400_dear_t_mask()
      LET g_dear_d_mask_n[l_ac].* =  g_dear_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adet400_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM dear_t
       WHERE dearent = g_enterprise AND
         deardocno = ps_keys_bak[1] AND dearseq = ps_keys_bak[2]
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
         CALL g_dear_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adet400_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO dear_t
                  (dearent,
                   deardocno,
                   dearseq
                   ,dear000,dear001,dear002,dear003,dear006,dear004,dear005,dear007,dear009,dear008,dearsite,dearunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_dear_d[g_detail_idx].dear000,g_dear_d[g_detail_idx].dear001,g_dear_d[g_detail_idx].dear002, 
                       g_dear_d[g_detail_idx].dear003,g_dear_d[g_detail_idx].dear006,g_dear_d[g_detail_idx].dear004, 
                       g_dear_d[g_detail_idx].dear005,g_dear_d[g_detail_idx].dear007,g_dear_d[g_detail_idx].dear009, 
                       g_dear_d[g_detail_idx].dear008,g_dear_d[g_detail_idx].dearsite,g_dear_d[g_detail_idx].dearunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dear_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_dear_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adet400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "dear_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adet400_dear_t_mask_restore('restore_mask_o')
               
      UPDATE dear_t 
         SET (deardocno,
              dearseq
              ,dear000,dear001,dear002,dear003,dear006,dear004,dear005,dear007,dear009,dear008,dearsite,dearunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_dear_d[g_detail_idx].dear000,g_dear_d[g_detail_idx].dear001,g_dear_d[g_detail_idx].dear002, 
                  g_dear_d[g_detail_idx].dear003,g_dear_d[g_detail_idx].dear006,g_dear_d[g_detail_idx].dear004, 
                  g_dear_d[g_detail_idx].dear005,g_dear_d[g_detail_idx].dear007,g_dear_d[g_detail_idx].dear009, 
                  g_dear_d[g_detail_idx].dear008,g_dear_d[g_detail_idx].dearsite,g_dear_d[g_detail_idx].dearunit)  
 
         WHERE dearent = g_enterprise AND deardocno = ps_keys_bak[1] AND dearseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dear_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dear_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adet400_dear_t_mask_restore('restore_mask_n')
               
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
 
{<section id="adet400.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adet400_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="adet400.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adet400_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adet400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adet400_lock_b(ps_table,ps_page)
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
   #CALL adet400_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "dear_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adet400_bcl USING g_enterprise,
                                       g_deaq_m.deaqdocno,g_dear_d[g_detail_idx].dearseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adet400_bcl:",SQLERRMESSAGE 
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
 
{<section id="adet400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adet400_unlock_b(ps_table,ps_page)
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
      CLOSE adet400_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adet400_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("deaqdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("deaqdocno",TRUE)
      CALL cl_set_comp_entry("deaqdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("deaqdocdt",TRUE)
      CALL cl_set_comp_entry("deaqsite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adet400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("deaqdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("deaqdocdt",FALSE)
      CALL cl_set_comp_entry("deaqsite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("deaqdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("deaqdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'deaqsite') OR g_flag THEN
      CALL cl_set_comp_entry("deaqsite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adet400_set_entry_b(p_cmd)
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
 
{<section id="adet400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adet400_set_no_entry_b(p_cmd)
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
 
{<section id="adet400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adet400_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adet400_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_deaq_m.deaqstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet400.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adet400_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet400.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adet400_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adet400_default_search()
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
      LET ls_wc = ls_wc, " deaqdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "deaq_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "dear_t" 
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
 
{<section id="adet400.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION adet400_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5  
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_deaq_m.deaqstus = "X" THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_deaq_m.deaqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN adet400_cl USING g_enterprise,g_deaq_m.deaqdocno
   IF STATUS THEN
      CLOSE adet400_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet400_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE adet400_master_referesh USING g_deaq_m.deaqdocno INTO g_deaq_m.deaqsite,g_deaq_m.deaqdocdt, 
       g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqowndp, 
       g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt,g_deaq_m.deaqsite_desc,g_deaq_m.deaq001_desc,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqmodid_desc, 
       g_deaq_m.deaqcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT adet400_action_chk() THEN
      CLOSE adet400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deaq_m.deaqsite,g_deaq_m.deaqsite_desc,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno,g_deaq_m.deaq001, 
       g_deaq_m.deaq001_desc,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid,g_deaq_m.deaqownid_desc, 
       g_deaq_m.deaqowndp,g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp, 
       g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmodid_desc,g_deaq_m.deaqmoddt, 
       g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfid_desc,g_deaq_m.deaqcnfdt
 
   CASE g_deaq_m.deaqstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_deaq_m.deaqstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
         #提交和抽單一開始先無條件關
         CALL cl_set_act_visible("signing,withdraw",FALSE)
         
         CASE g_deaq_m.deaqstus
            WHEN "Y"
               HIDE OPTION "void"
               HIDE OPTION "invalid"
               
            WHEN "N"
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                  CALL cl_set_act_visible("signing",TRUE)
                  CALL cl_set_act_visible("confirmed",FALSE)
               END IF
            #已核准只能顯示確認;其餘應用功能皆隱藏
            WHEN "A"     
               CALL cl_set_act_visible("confirmed ",TRUE)  
               CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
            #保留修改的功能(如作廢)，隱藏其他應用功能
            WHEN "R"   
               CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
            WHEN "D"  
               CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
            #送簽中只能顯示抽單;其餘應用功能皆隱藏
            WHEN "W"   
               CALL cl_set_act_visible("withdraw",TRUE)  
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         END CASE  
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT adet400_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet400_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT adet400_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet400_cl
            RETURN
         END IF
 
 
 
	  
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
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_deaq_m.deaqstus = lc_state OR cl_null(lc_state) THEN
      CLOSE adet400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE          
   CASE 
      WHEN lc_state = 'Y' AND g_deaq_m.deaqstus = 'N'  
         CALL s_adet400_conf_chk(g_deaq_m.deaqdocno,g_deaq_m.deaqstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_adet400_conf_upd(g_deaq_m.deaqdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_deaq_m.deaqdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                 
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')  #160816-00068#4 add
               RETURN            
            END IF
         ELSE
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_deaq_m.deaqdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            END IF
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN            
         END IF         
      WHEN lc_state = 'X' AND g_deaq_m.deaqstus = 'N'  
         CALL s_adet400_void_chk(g_deaq_m.deaqdocno,g_deaq_m.deaqstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00109') THEN
               CALL s_transaction_begin()
               CALL s_adet400_void_upd(g_deaq_m.deaqdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_deaq_m.deaqdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')  #160816-00068#4 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_deaq_m.deaqdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN    
         END IF
      WHEN lc_state = 'N' AND g_deaq_m.deaqstus = 'Y'  
         CALL s_adet400_unconf_chk(g_deaq_m.deaqdocno,g_deaq_m.deaqstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_adet400_unconf_upd(g_deaq_m.deaqdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_deaq_m.deaqdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')  #160816-00068#4 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_deaq_m.deaqdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN    
         END IF

      OTHERWISE
         CALL s_transaction_end('N','0')  #160816-00068#4 add
         RETURN
   END CASE   
   #end add-point
   
   LET g_deaq_m.deaqmodid = g_user
   LET g_deaq_m.deaqmoddt = cl_get_current()
   LET g_deaq_m.deaqstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE deaq_t 
      SET (deaqstus,deaqmodid,deaqmoddt) 
        = (g_deaq_m.deaqstus,g_deaq_m.deaqmodid,g_deaq_m.deaqmoddt)     
    WHERE deaqent = g_enterprise AND deaqdocno = g_deaq_m.deaqdocno
 
    
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
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE adet400_master_referesh USING g_deaq_m.deaqdocno INTO g_deaq_m.deaqsite,g_deaq_m.deaqdocdt, 
          g_deaq_m.deaqdocno,g_deaq_m.deaq001,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid, 
          g_deaq_m.deaqowndp,g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid, 
          g_deaq_m.deaqmoddt,g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfdt,g_deaq_m.deaqsite_desc,g_deaq_m.deaq001_desc, 
          g_deaq_m.deaqownid_desc,g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid_desc,g_deaq_m.deaqcrtdp_desc, 
          g_deaq_m.deaqmodid_desc,g_deaq_m.deaqcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_deaq_m.deaqsite,g_deaq_m.deaqsite_desc,g_deaq_m.deaqdocdt,g_deaq_m.deaqdocno, 
          g_deaq_m.deaq001,g_deaq_m.deaq001_desc,g_deaq_m.deaqunit,g_deaq_m.deaqstus,g_deaq_m.deaqownid, 
          g_deaq_m.deaqownid_desc,g_deaq_m.deaqowndp,g_deaq_m.deaqowndp_desc,g_deaq_m.deaqcrtid,g_deaq_m.deaqcrtid_desc, 
          g_deaq_m.deaqcrtdp,g_deaq_m.deaqcrtdp_desc,g_deaq_m.deaqcrtdt,g_deaq_m.deaqmodid,g_deaq_m.deaqmodid_desc, 
          g_deaq_m.deaqmoddt,g_deaq_m.deaqcnfid,g_deaq_m.deaqcnfid_desc,g_deaq_m.deaqcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE adet400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet400_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet400.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adet400_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_dear_d.getLength() THEN
         LET g_detail_idx = g_dear_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dear_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dear_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adet400_b_fill2(pi_idx)
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
   
   CALL adet400_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adet400_fill_chk(ps_idx)
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
 
{<section id="adet400.status_show" >}
PRIVATE FUNCTION adet400_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adet400.mask_functions" >}
&include "erp/ade/adet400_mask.4gl"
 
{</section>}
 
{<section id="adet400.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION adet400_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL adet400_show()
   CALL adet400_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   LET l_success = TRUE
   #確認前檢核段
   CALL s_adet400_conf_chk(g_deaq_m.deaqdocno,g_deaq_m.deaqstus) RETURNING l_success,g_errno
   IF NOT l_success THEN
      CLOSE adet400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_deaq_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_dear_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL adet400_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL adet400_ui_headershow()
   CALL adet400_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION adet400_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL adet400_ui_headershow()  
   CALL adet400_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="adet400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adet400_set_pk_array()
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
   LET g_pk_array[1].values = g_deaq_m.deaqdocno
   LET g_pk_array[1].column = 'deaqdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet400.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adet400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adet400_msgcentre_notify(lc_state)
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
   CALL adet400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_deaq_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet400.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adet400_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#7 -s by 08172
   SELECT deaqstus  INTO g_deaq_m.deaqstus
     FROM deaq_t
    WHERE deaqent = g_enterprise
      AND deaqdocno = g_deaq_m.deaqdocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_deaq_m.deaqstus
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
        LET g_errparam.extend = g_deaq_m.deaqdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adet400_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#7 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet400.other_function" readonly="Y" >}

PRIVATE FUNCTION adet400_dear009(p_dear006,p_site,p_date)
DEFINE p_dear006      LIKE dear_t.dear006
DEFINE p_site         LIKE deaq_t.deaqsite
DEFINE p_date         LIKE deaq_t.deaqdocdt
DEFINE l_ooef015      LIKE ooef_t.ooef015
DEFINE l_ooef016      LIKE ooef_t.ooef016
DEFINE l_ooef017      LIKE ooef_t.ooef017
DEFINE l_ooam005      LIKE ooam_t.ooam005
DEFINE l_gzsz008      LIKE gzsz_t.gzsz008
DEFINE l_rate         LIKE ooan_t.ooan005

   LET l_rate = NULL
   #取匯率參照表號、主幣別
   SELECT ooef015,ooef016,ooef017 INTO l_ooef015,l_ooef016,l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_deaq_m.deaqsite

   #取交易貨幣批量
   SELECT ooam005 INTO l_ooam005 FROM ooam_t
    WHERE ooament = g_enterprise AND ooam001 = l_ooef015
      AND ooam003 = p_dear006 AND ooam004 = g_deaq_m.deaqdocdt
      
   #取匯率類型   
   #SELECT gzsz008 INTO l_gzsz008 FROM gzsz_t 
   # WHERE gzsz001 = 'ooab_t' AND gzsz002 = 'S-BAS-0010'   
   CALL cl_get_para(g_enterprise,l_ooef017,'S-BAS-0012') RETURNING l_gzsz008

   CALL s_aooi160_get_exrate('1',p_site,p_date,p_dear006,l_ooef016,l_ooam005,l_gzsz008)
      RETURNING l_rate
      
   RETURN l_rate
END FUNCTION

PUBLIC FUNCTION adet400_deaqsite_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_deaq_m.deaqsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_deaq_m.deaqsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_deaq_m.deaqsite_desc
END FUNCTION

PUBLIC FUNCTION adet400_deaq001_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_deaq_m.deaqsite
      LET g_ref_fields[2] = g_deaq_m.deaq001
      CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogdsite=? AND oogd001=? ","") RETURNING g_rtn_fields
      LET g_deaq_m.deaq001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_deaq_m.deaq001_desc
END FUNCTION

PUBLIC FUNCTION adet400_dear001_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dear_d[l_ac].dear001
      CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
      LET g_dear_d[l_ac].dear001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dear_d[l_ac].dear001_desc
END FUNCTION

PUBLIC FUNCTION adet400_dear003_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dear_d[l_ac].dear003
      CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_dear_d[l_ac].dear003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dear_d[l_ac].dear003_desc
END FUNCTION

PUBLIC FUNCTION adet400_dear006_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dear_d[l_ac].dear006
      CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_dear_d[l_ac].dear006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dear_d[l_ac].dear006_desc
END FUNCTION

PUBLIC FUNCTION adet400_dear004_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dear_d[l_ac].dear004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2071' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_dear_d[l_ac].dear004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dear_d[l_ac].dear004_desc
END FUNCTION

 
{</section>}
 
