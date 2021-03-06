#該程式未解開Section, 採用最新樣板產出!
{<section id="asti251.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-04-11 10:04:28), PR版次:0007(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: asti251
#+ Description: 費用編號根據不同維度設定參數
#+ Creator....: 02295(2016-03-17 13:24:09)
#+ Modifier...: 08172 -SD/PR- 00000
 
{</section>}
 
{<section id="asti251.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...: 02003(2016-03-25) -SD/PR- #160324-00008#3  新增计算类型,放在周期数值的后面&bug调整
#+ Modifier...: 08172(2016-04-11) -SD/PR- #160407-00047#2  品类改成管理品类
#+ Modifier...: 07959(2016-04-25) -SD/PR- #160318-00025#41 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#+ Modifier...: 06189(2016-07-11) -SD/PR- #160604-00009#138 计算方式加一个6.交款金额，计算类型=2.变动的时候可以选5和6；
#  161024-00025#12  2016/10/26  By 02481  aooi500规范调整
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
PRIVATE type type_g_sthc_m        RECORD
       sthcsite LIKE sthc_t.sthcsite, 
   sthcsite_desc LIKE type_t.chr80, 
   sthc001 LIKE sthc_t.sthc001, 
   sthc001_desc LIKE type_t.chr80, 
   sthc002 LIKE sthc_t.sthc002, 
   sthc003 LIKE sthc_t.sthc003, 
   sthc004 LIKE sthc_t.sthc004, 
   sthc005 LIKE sthc_t.sthc005, 
   sthc006 LIKE sthc_t.sthc006, 
   sthcstus LIKE sthc_t.sthcstus, 
   sthcownid LIKE sthc_t.sthcownid, 
   sthcownid_desc LIKE type_t.chr80, 
   sthcowndp LIKE sthc_t.sthcowndp, 
   sthcowndp_desc LIKE type_t.chr80, 
   sthccrtid LIKE sthc_t.sthccrtid, 
   sthccrtid_desc LIKE type_t.chr80, 
   sthccrtdp LIKE sthc_t.sthccrtdp, 
   sthccrtdp_desc LIKE type_t.chr80, 
   sthccrtdt LIKE sthc_t.sthccrtdt, 
   sthcmodid LIKE sthc_t.sthcmodid, 
   sthcmodid_desc LIKE type_t.chr80, 
   sthcmoddt LIKE sthc_t.sthcmoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_sthd_d        RECORD
       sthd002 LIKE sthd_t.sthd002, 
   sthd003 LIKE sthd_t.sthd003, 
   sthd003_desc LIKE type_t.chr500, 
   sthd004 LIKE sthd_t.sthd004, 
   sthd004_desc LIKE type_t.chr500, 
   sthd005 LIKE sthd_t.sthd005, 
   sthd005_desc LIKE type_t.chr500, 
   sthd006 LIKE sthd_t.sthd006, 
   sthd006_desc LIKE type_t.chr500, 
   sthd007 LIKE sthd_t.sthd007, 
   sthd007_desc LIKE type_t.chr500, 
   sthd008 LIKE sthd_t.sthd008, 
   sthd009 LIKE sthd_t.sthd009, 
   sthd011 LIKE type_t.chr10, 
   sthd010 LIKE sthd_t.sthd010
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_sthcsite LIKE sthc_t.sthcsite,
      b_sthc001 LIKE sthc_t.sthc001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag   LIKE type_t.num5  #161024-00025#12--ADD
#end add-point
       
#模組變數(Module Variables)
DEFINE g_sthc_m          type_g_sthc_m
DEFINE g_sthc_m_t        type_g_sthc_m
DEFINE g_sthc_m_o        type_g_sthc_m
DEFINE g_sthc_m_mask_o   type_g_sthc_m #轉換遮罩前資料
DEFINE g_sthc_m_mask_n   type_g_sthc_m #轉換遮罩後資料
 
   DEFINE g_sthcsite_t LIKE sthc_t.sthcsite
DEFINE g_sthc001_t LIKE sthc_t.sthc001
 
 
DEFINE g_sthd_d          DYNAMIC ARRAY OF type_g_sthd_d
DEFINE g_sthd_d_t        type_g_sthd_d
DEFINE g_sthd_d_o        type_g_sthd_d
DEFINE g_sthd_d_mask_o   DYNAMIC ARRAY OF type_g_sthd_d #轉換遮罩前資料
DEFINE g_sthd_d_mask_n   DYNAMIC ARRAY OF type_g_sthd_d #轉換遮罩後資料
 
 
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
 
{<section id="asti251.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5  #161024-00025#12--add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT sthcsite,'',sthc001,'',sthc002,sthc003,sthc004,sthc005,sthc006,sthcstus, 
       sthcownid,'',sthcowndp,'',sthccrtid,'',sthccrtdp,'',sthccrtdt,sthcmodid,'',sthcmoddt", 
                      " FROM sthc_t",
                      " WHERE sthcent= ? AND sthc001=? AND sthcsite=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asti251_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.sthcsite,t0.sthc001,t0.sthc002,t0.sthc003,t0.sthc004,t0.sthc005, 
       t0.sthc006,t0.sthcstus,t0.sthcownid,t0.sthcowndp,t0.sthccrtid,t0.sthccrtdp,t0.sthccrtdt,t0.sthcmodid, 
       t0.sthcmoddt,t1.ooefl003 ,t2.stael003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011", 
 
               " FROM sthc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.sthcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t2 ON t2.staelent="||g_enterprise||" AND t2.stael001=t0.sthc001 AND t2.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.sthcownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.sthcowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.sthccrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.sthccrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.sthcmodid  ",
 
               " WHERE t0.sthcent = " ||g_enterprise|| " AND t0.sthc001 = ? AND t0.sthcsite = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asti251_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asti251 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asti251_init()   
 
      #進入選單 Menu (="N")
      CALL asti251_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asti251
      
   END IF 
   
   CLOSE asti251_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''                                #161024-00025#12--add
   CALL s_aooi500_drop_temp() RETURNING l_success    #161024-00025#12--add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asti251.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asti251_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('sthcstus','17','N,Y')
 
      CALL cl_set_combo_scc('sthd008','6920') 
   CALL cl_set_combo_scc('sthd010','6904') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('sthd011','6910') 
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
   #初始化搜尋條件
   CALL asti251_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="asti251.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION asti251_ui_dialog()
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
            CALL asti251_insert()
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
         INITIALIZE g_sthc_m.* TO NULL
         CALL g_sthd_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asti251_init()
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
               
               CALL asti251_fetch('') # reload data
               LET l_ac = 1
               CALL asti251_ui_detailshow() #Setting the current row 
         
               CALL asti251_idx_chk()
               #NEXT FIELD sthd002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_sthd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asti251_idx_chk()
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
               CALL asti251_idx_chk()
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
            CALL asti251_browser_fill("")
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
               CALL asti251_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asti251_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL asti251_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL asti251_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL asti251_set_act_visible()   
            CALL asti251_set_act_no_visible()
            IF NOT (g_sthc_m.sthc001 IS NULL
              OR g_sthc_m.sthcsite IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " sthcent = " ||g_enterprise|| " AND",
                                  " sthc001 = '", g_sthc_m.sthc001, "' "
                                  ," AND sthcsite = '", g_sthc_m.sthcsite, "' "
 
               #填到對應位置
               CALL asti251_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "sthc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sthd_t" 
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
               CALL asti251_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "sthc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sthd_t" 
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
                  CALL asti251_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL asti251_fetch("F")
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
               CALL asti251_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL asti251_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asti251_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL asti251_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asti251_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL asti251_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asti251_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL asti251_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asti251_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL asti251_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asti251_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_sthd_d)
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
               NEXT FIELD sthd002
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
               CALL asti251_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL asti251_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL asti251_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asti251_insert()
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
               CALL asti251_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asti251_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL asti251_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asti251_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asti251_set_pk_array()
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
 
{<section id="asti251.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION asti251_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'sthcsite') RETURNING l_where
   LET g_wc=g_wc," AND ",l_where
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT sthc001,sthcsite ",
                      " FROM sthc_t ",
                      " ",
                      " LEFT JOIN sthd_t ON sthdent = sthcent AND sthc001 = sthd001 AND sthcsite = sthdsite ", "  ",
                      #add-point:browser_fill段sql(sthd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE sthcent = " ||g_enterprise|| " AND sthdent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("sthc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT sthc001,sthcsite ",
                      " FROM sthc_t ", 
                      "  ",
                      "  ",
                      " WHERE sthcent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("sthc_t")
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
      INITIALIZE g_sthc_m.* TO NULL
      CALL g_sthd_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.sthcsite,t0.sthc001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.sthcstus,t0.sthcsite,t0.sthc001 ",
                  " FROM sthc_t t0",
                  "  ",
                  "  LEFT JOIN sthd_t ON sthdent = sthcent AND sthc001 = sthd001 AND sthcsite = sthdsite ", "  ", 
                  #add-point:browser_fill段sql(sthd_t1) name="browser_fill.join.sthd_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.sthcent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("sthc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.sthcstus,t0.sthcsite,t0.sthc001 ",
                  " FROM sthc_t t0",
                  "  ",
                  
                  " WHERE t0.sthcent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("sthc_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   let g_sql=g_sql," AND ",l_where 
   #end add-point
   LET g_sql = g_sql, " ORDER BY sthc001,sthcsite ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"sthc_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_sthcsite,g_browser[g_cnt].b_sthc001 
 
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
         CALL asti251_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_sthc001) THEN
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
 
{<section id="asti251.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION asti251_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_sthc_m.sthc001 = g_browser[g_current_idx].b_sthc001   
   LET g_sthc_m.sthcsite = g_browser[g_current_idx].b_sthcsite   
 
   EXECUTE asti251_master_referesh USING g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthc_m.sthcsite,g_sthc_m.sthc001, 
       g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus, 
       g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt, 
       g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001_desc,g_sthc_m.sthcownid_desc, 
       g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthcmodid_desc 
 
   
   CALL asti251_sthc_t_mask()
   CALL asti251_show()
      
END FUNCTION
 
{</section>}
 
{<section id="asti251.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION asti251_ui_detailshow()
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
 
{<section id="asti251.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION asti251_ui_browser_refresh()
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
      IF g_browser[l_i].b_sthc001 = g_sthc_m.sthc001 
         AND g_browser[l_i].b_sthcsite = g_sthc_m.sthcsite 
 
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
 
{<section id="asti251.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION asti251_construct()
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
   INITIALIZE g_sthc_m.* TO NULL
   CALL g_sthd_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON sthcsite,sthc001,sthc002,sthc003,sthc004,sthc005,sthc006,sthcstus,sthcownid, 
          sthcowndp,sthccrtid,sthccrtdp,sthccrtdt,sthcmodid,sthcmoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<sthccrtdt>>----
         AFTER FIELD sthccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<sthcmoddt>>----
         AFTER FIELD sthcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<sthccnfdt>>----
         
         #----<<sthcpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.sthcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthcsite
            #add-point:ON ACTION controlp INFIELD sthcsite name="construct.c.sthcsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'sthcsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthcsite  #顯示到畫面上
            CALL asti251_sthcsite_ref() RETURNING g_sthc_m.sthcsite_desc
            DISPLAY BY NAME g_sthc_m.sthcsite_desc
            NEXT FIELD sthcsite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcsite
            #add-point:BEFORE FIELD sthcsite name="construct.b.sthcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthcsite
            
            #add-point:AFTER FIELD sthcsite name="construct.a.sthcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc001
            #add-point:ON ACTION controlp INFIELD sthc001 name="construct.c.sthc001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthc001  #顯示到畫面上
            CALL asti251_sthc001_ref() RETURNING g_sthc_m.sthc001_desc
            DISPLAY BY NAME g_sthc_m.sthc001_desc
            NEXT FIELD sthc001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc001
            #add-point:BEFORE FIELD sthc001 name="construct.b.sthc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc001
            
            #add-point:AFTER FIELD sthc001 name="construct.a.sthc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc002
            #add-point:BEFORE FIELD sthc002 name="construct.b.sthc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc002
            
            #add-point:AFTER FIELD sthc002 name="construct.a.sthc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc002
            #add-point:ON ACTION controlp INFIELD sthc002 name="construct.c.sthc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc003
            #add-point:BEFORE FIELD sthc003 name="construct.b.sthc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc003
            
            #add-point:AFTER FIELD sthc003 name="construct.a.sthc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc003
            #add-point:ON ACTION controlp INFIELD sthc003 name="construct.c.sthc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc004
            #add-point:BEFORE FIELD sthc004 name="construct.b.sthc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc004
            
            #add-point:AFTER FIELD sthc004 name="construct.a.sthc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc004
            #add-point:ON ACTION controlp INFIELD sthc004 name="construct.c.sthc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc005
            #add-point:BEFORE FIELD sthc005 name="construct.b.sthc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc005
            
            #add-point:AFTER FIELD sthc005 name="construct.a.sthc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc005
            #add-point:ON ACTION controlp INFIELD sthc005 name="construct.c.sthc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc006
            #add-point:BEFORE FIELD sthc006 name="construct.b.sthc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc006
            
            #add-point:AFTER FIELD sthc006 name="construct.a.sthc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc006
            #add-point:ON ACTION controlp INFIELD sthc006 name="construct.c.sthc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcstus
            #add-point:BEFORE FIELD sthcstus name="construct.b.sthcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthcstus
            
            #add-point:AFTER FIELD sthcstus name="construct.a.sthcstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthcstus
            #add-point:ON ACTION controlp INFIELD sthcstus name="construct.c.sthcstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.sthcownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthcownid
            #add-point:ON ACTION controlp INFIELD sthcownid name="construct.c.sthcownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthcownid  #顯示到畫面上
            NEXT FIELD sthcownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcownid
            #add-point:BEFORE FIELD sthcownid name="construct.b.sthcownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthcownid
            
            #add-point:AFTER FIELD sthcownid name="construct.a.sthcownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthcowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthcowndp
            #add-point:ON ACTION controlp INFIELD sthcowndp name="construct.c.sthcowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthcowndp  #顯示到畫面上
            NEXT FIELD sthcowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcowndp
            #add-point:BEFORE FIELD sthcowndp name="construct.b.sthcowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthcowndp
            
            #add-point:AFTER FIELD sthcowndp name="construct.a.sthcowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthccrtid
            #add-point:ON ACTION controlp INFIELD sthccrtid name="construct.c.sthccrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthccrtid  #顯示到畫面上
            NEXT FIELD sthccrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthccrtid
            #add-point:BEFORE FIELD sthccrtid name="construct.b.sthccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthccrtid
            
            #add-point:AFTER FIELD sthccrtid name="construct.a.sthccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sthccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthccrtdp
            #add-point:ON ACTION controlp INFIELD sthccrtdp name="construct.c.sthccrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthccrtdp  #顯示到畫面上
            NEXT FIELD sthccrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthccrtdp
            #add-point:BEFORE FIELD sthccrtdp name="construct.b.sthccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthccrtdp
            
            #add-point:AFTER FIELD sthccrtdp name="construct.a.sthccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthccrtdt
            #add-point:BEFORE FIELD sthccrtdt name="construct.b.sthccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.sthcmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthcmodid
            #add-point:ON ACTION controlp INFIELD sthcmodid name="construct.c.sthcmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthcmodid  #顯示到畫面上
            NEXT FIELD sthcmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcmodid
            #add-point:BEFORE FIELD sthcmodid name="construct.b.sthcmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthcmodid
            
            #add-point:AFTER FIELD sthcmodid name="construct.a.sthcmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcmoddt
            #add-point:BEFORE FIELD sthcmoddt name="construct.b.sthcmoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON sthd002,sthd003,sthd004,sthd005,sthd006,sthd007,sthd008,sthd009,sthd011, 
          sthd010
           FROM s_detail1[1].sthd002,s_detail1[1].sthd003,s_detail1[1].sthd004,s_detail1[1].sthd005, 
               s_detail1[1].sthd006,s_detail1[1].sthd007,s_detail1[1].sthd008,s_detail1[1].sthd009,s_detail1[1].sthd011, 
               s_detail1[1].sthd010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd002
            #add-point:BEFORE FIELD sthd002 name="construct.b.page1.sthd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd002
            
            #add-point:AFTER FIELD sthd002 name="construct.a.page1.sthd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd002
            #add-point:ON ACTION controlp INFIELD sthd002 name="construct.c.page1.sthd002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.sthd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd003
            #add-point:ON ACTION controlp INFIELD sthd003 name="construct.c.page1.sthd003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthd003  #顯示到畫面上
           #CALL asti251_sthd003_ref() RETURNING g_sthd_d[l_ac].sthd003_desc   #160324-00008#3 mark by yangxf 20160325
           #DISPLAY BY NAME g_sthd_d[l_ac].sthd003_desc                        #160324-00008#3 mark by yangxf 20160325
            NEXT FIELD sthd003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd003
            #add-point:BEFORE FIELD sthd003 name="construct.b.page1.sthd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd003
            
            #add-point:AFTER FIELD sthd003 name="construct.a.page1.sthd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd004
            #add-point:ON ACTION controlp INFIELD sthd004 name="construct.c.page1.sthd004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthd004  #顯示到畫面上
           #CALL asti251_sthd004_ref() RETURNING g_sthd_d[l_ac].sthd004_desc   #160324-00008#3 mark by yangxf 20160325
           #DISPLAY BY NAME g_sthd_d[l_ac].sthd004_desc                        #160324-00008#3 mark by yangxf 20160325
            NEXT FIELD sthd004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd004
            #add-point:BEFORE FIELD sthd004 name="construct.b.page1.sthd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd004
            
            #add-point:AFTER FIELD sthd004 name="construct.a.page1.sthd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd005
            #add-point:ON ACTION controlp INFIELD sthd005 name="construct.c.page1.sthd005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthd005  #顯示到畫面上
           #CALL asti251_sthd005_ref() RETURNING g_sthd_d[l_ac].sthd005_desc   #160324-00008#3 mark by yangxf 20160325
           #DISPLAY BY NAME g_sthd_d[l_ac].sthd005_desc                        #160324-00008#3 mark by yangxf 20160325
            NEXT FIELD sthd005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd005
            #add-point:BEFORE FIELD sthd005 name="construct.b.page1.sthd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd005
            
            #add-point:AFTER FIELD sthd005 name="construct.a.page1.sthd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd006
            #add-point:ON ACTION controlp INFIELD sthd006 name="construct.c.page1.sthd006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1=cl_get_para(g_enterprise,g_site,'E-CIR-0001')       #160324-00008#3 add by yangxf 20160325
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthd006  #顯示到畫面上
           #CALL asti251_sthd006_ref() RETURNING g_sthd_d[l_ac].sthd006_desc    #160324-00008#3 mark by yangxf 20160325
           #DISPLAY BY NAME g_sthd_d[l_ac].sthd006_desc                         #160324-00008#3 mark by yangxf 20160325
            NEXT FIELD sthd006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd006
            #add-point:BEFORE FIELD sthd006 name="construct.b.page1.sthd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd006
            
            #add-point:AFTER FIELD sthd006 name="construct.a.page1.sthd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd007
            #add-point:ON ACTION controlp INFIELD sthd007 name="construct.c.page1.sthd007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2144" #s
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sthd007  #顯示到畫面上
           #CALL asti251_sthd007_ref() RETURNING g_sthd_d[l_ac].sthd007_desc   #160324-00008#3 mark by yangxf 20160325
           #DISPLAY BY NAME g_sthd_d[l_ac].sthd007_desc                        #160324-00008#3 mark by yangxf 20160325
            NEXT FIELD sthd007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd007
            #add-point:BEFORE FIELD sthd007 name="construct.b.page1.sthd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd007
            
            #add-point:AFTER FIELD sthd007 name="construct.a.page1.sthd007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd008
            #add-point:BEFORE FIELD sthd008 name="construct.b.page1.sthd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd008
            
            #add-point:AFTER FIELD sthd008 name="construct.a.page1.sthd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd008
            #add-point:ON ACTION controlp INFIELD sthd008 name="construct.c.page1.sthd008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd009
            #add-point:BEFORE FIELD sthd009 name="construct.b.page1.sthd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd009
            
            #add-point:AFTER FIELD sthd009 name="construct.a.page1.sthd009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd009
            #add-point:ON ACTION controlp INFIELD sthd009 name="construct.c.page1.sthd009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd011
            #add-point:BEFORE FIELD sthd011 name="construct.b.page1.sthd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd011
            
            #add-point:AFTER FIELD sthd011 name="construct.a.page1.sthd011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd011
            #add-point:ON ACTION controlp INFIELD sthd011 name="construct.c.page1.sthd011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd010
            #add-point:BEFORE FIELD sthd010 name="construct.b.page1.sthd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd010
            
            #add-point:AFTER FIELD sthd010 name="construct.a.page1.sthd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sthd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd010
            #add-point:ON ACTION controlp INFIELD sthd010 name="construct.c.page1.sthd010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         #160324-00008#3 add by yangxf 20160325 (S)
         CALL cl_set_comp_visible("sthd003,sthd003_desc,sthd004,sthd004_desc,sthd005,sthd005_desc,
                                   sthd006,sthd006_desc,sthd007,sthd007_desc",TRUE)
         #160324-00008#3 add by yangxf 20160325 (E)
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
                  WHEN la_wc[li_idx].tableid = "sthc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "sthd_t" 
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
 
{<section id="asti251.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION asti251_filter()
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
      CONSTRUCT g_wc_filter ON sthcsite,sthc001
                          FROM s_browse[1].b_sthcsite,s_browse[1].b_sthc001
 
         BEFORE CONSTRUCT
               DISPLAY asti251_filter_parser('sthcsite') TO s_browse[1].b_sthcsite
            DISPLAY asti251_filter_parser('sthc001') TO s_browse[1].b_sthc001
      
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
 
      CALL asti251_filter_show('sthcsite')
   CALL asti251_filter_show('sthc001')
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION asti251_filter_parser(ps_field)
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
 
{<section id="asti251.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION asti251_filter_show(ps_field)
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
   LET ls_condition = asti251_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION asti251_query()
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
   CALL g_sthd_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL asti251_set_act_no_visible_b()
   CALL asti251_set_act_visible_b()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL asti251_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL asti251_browser_fill("")
      CALL asti251_fetch("")
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
      CALL asti251_filter_show('sthcsite')
   CALL asti251_filter_show('sthc001')
   CALL asti251_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL asti251_fetch("F") 
      #顯示單身筆數
      CALL asti251_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION asti251_fetch(p_flag)
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
   
   LET g_sthc_m.sthc001 = g_browser[g_current_idx].b_sthc001
   LET g_sthc_m.sthcsite = g_browser[g_current_idx].b_sthcsite
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE asti251_master_referesh USING g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthc_m.sthcsite,g_sthc_m.sthc001, 
       g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus, 
       g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt, 
       g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001_desc,g_sthc_m.sthcownid_desc, 
       g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthcmodid_desc 
 
   
   #遮罩相關處理
   LET g_sthc_m_mask_o.* =  g_sthc_m.*
   CALL asti251_sthc_t_mask()
   LET g_sthc_m_mask_n.* =  g_sthc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asti251_set_act_visible()   
   CALL asti251_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_sthc_m_t.* = g_sthc_m.*
   LET g_sthc_m_o.* = g_sthc_m.*
   
   LET g_data_owner = g_sthc_m.sthcownid      
   LET g_data_dept  = g_sthc_m.sthcowndp
   
   #重新顯示   
   CALL asti251_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.insert" >}
#+ 資料新增
PRIVATE FUNCTION asti251_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_sthd_d.clear()   
 
 
   INITIALIZE g_sthc_m.* TO NULL             #DEFAULT 設定
   
   LET g_sthc001_t = NULL
   LET g_sthcsite_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_sthc_m.sthcownid = g_user
      LET g_sthc_m.sthcowndp = g_dept
      LET g_sthc_m.sthccrtid = g_user
      LET g_sthc_m.sthccrtdp = g_dept 
      LET g_sthc_m.sthccrtdt = cl_get_current()
      LET g_sthc_m.sthcmodid = g_user
      LET g_sthc_m.sthcmoddt = cl_get_current()
      LET g_sthc_m.sthcstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_sthc_m.sthc002 = "N"
      LET g_sthc_m.sthc003 = "N"
      LET g_sthc_m.sthc004 = "N"
      LET g_sthc_m.sthc005 = "N"
      LET g_sthc_m.sthc006 = "N"
      LET g_sthc_m.sthcstus = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
     #LET g_sthc_m.sthcsite=g_site      #161024-00025#12--mark
      LET g_site_flag = FALSE           #161024-00025#12--add 
      CALL s_aooi500_default(g_prog,'sthcsite',g_site)
         RETURNING l_insert,g_sthc_m.sthcsite
      IF NOT l_insert THEN
         RETURN
      END IF
      
      CALL asti251_sthcsite_ref() RETURNING g_sthc_m.sthcsite_desc
      DISPLAY BY NAME g_sthc_m.sthcsite_desc
 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_sthc_m_t.* = g_sthc_m.*
      LET g_sthc_m_o.* = g_sthc_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sthc_m.sthcstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL asti251_input("a")
      
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
         INITIALIZE g_sthc_m.* TO NULL
         INITIALIZE g_sthd_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL asti251_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_sthd_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asti251_set_act_visible()   
   CALL asti251_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_sthc001_t = g_sthc_m.sthc001
   LET g_sthcsite_t = g_sthc_m.sthcsite
 
   
   #組合新增資料的條件
   LET g_add_browse = " sthcent = " ||g_enterprise|| " AND",
                      " sthc001 = '", g_sthc_m.sthc001, "' "
                      ," AND sthcsite = '", g_sthc_m.sthcsite, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asti251_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE asti251_cl
   
   CALL asti251_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE asti251_master_referesh USING g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthc_m.sthcsite,g_sthc_m.sthc001, 
       g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus, 
       g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt, 
       g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001_desc,g_sthc_m.sthcownid_desc, 
       g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthcmodid_desc 
 
   
   
   #遮罩相關處理
   LET g_sthc_m_mask_o.* =  g_sthc_m.*
   CALL asti251_sthc_t_mask()
   LET g_sthc_m_mask_n.* =  g_sthc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_sthc_m.sthcsite,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001,g_sthc_m.sthc001_desc,g_sthc_m.sthc002, 
       g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus,g_sthc_m.sthcownid, 
       g_sthc_m.sthcownid_desc,g_sthc_m.sthcowndp,g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid,g_sthc_m.sthccrtid_desc, 
       g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid,g_sthc_m.sthcmodid_desc, 
       g_sthc_m.sthcmoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_sthc_m.sthcownid      
   LET g_data_dept  = g_sthc_m.sthcowndp
   
   #功能已完成,通報訊息中心
   CALL asti251_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.modify" >}
#+ 資料修改
PRIVATE FUNCTION asti251_modify()
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
   LET g_sthc_m_t.* = g_sthc_m.*
   LET g_sthc_m_o.* = g_sthc_m.*
   
   IF g_sthc_m.sthc001 IS NULL
   OR g_sthc_m.sthcsite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_sthc001_t = g_sthc_m.sthc001
   LET g_sthcsite_t = g_sthc_m.sthcsite
 
   CALL s_transaction_begin()
   
   OPEN asti251_cl USING g_enterprise,g_sthc_m.sthc001,g_sthc_m.sthcsite
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asti251_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asti251_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asti251_master_referesh USING g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthc_m.sthcsite,g_sthc_m.sthc001, 
       g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus, 
       g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt, 
       g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001_desc,g_sthc_m.sthcownid_desc, 
       g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthcmodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT asti251_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_sthc_m_mask_o.* =  g_sthc_m.*
   CALL asti251_sthc_t_mask()
   LET g_sthc_m_mask_n.* =  g_sthc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL asti251_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_sthc001_t = g_sthc_m.sthc001
      LET g_sthcsite_t = g_sthc_m.sthcsite
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_sthc_m.sthcmodid = g_user 
LET g_sthc_m.sthcmoddt = cl_get_current()
LET g_sthc_m.sthcmodid_desc = cl_get_username(g_sthc_m.sthcmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
 
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL asti251_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE sthc_t SET (sthcmodid,sthcmoddt) = (g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt)
          WHERE sthcent = g_enterprise AND sthc001 = g_sthc001_t
            AND sthcsite = g_sthcsite_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_sthc_m.* = g_sthc_m_t.*
            CALL asti251_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_sthc_m.sthc001 != g_sthc_m_t.sthc001
      OR g_sthc_m.sthcsite != g_sthc_m_t.sthcsite
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE sthd_t SET sthd001 = g_sthc_m.sthc001
                                       ,sthdsite = g_sthc_m.sthcsite
 
          WHERE sthdent = g_enterprise AND sthd001 = g_sthc_m_t.sthc001
            AND sthdsite = g_sthc_m_t.sthcsite
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "sthd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sthd_t:",SQLERRMESSAGE 
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
   CALL asti251_set_act_visible()   
   CALL asti251_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " sthcent = " ||g_enterprise|| " AND",
                      " sthc001 = '", g_sthc_m.sthc001, "' "
                      ," AND sthcsite = '", g_sthc_m.sthcsite, "' "
 
   #填到對應位置
   CALL asti251_browser_fill("")
 
   CLOSE asti251_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asti251_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="asti251.input" >}
#+ 資料輸入
PRIVATE FUNCTION asti251_input(p_cmd)
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
   DEFINE l_success  STRING
   DEFINE l_errNo    STRING
   DEFINE l_num      LIKE type_t.num10
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
   DISPLAY BY NAME g_sthc_m.sthcsite,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001,g_sthc_m.sthc001_desc,g_sthc_m.sthc002, 
       g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus,g_sthc_m.sthcownid, 
       g_sthc_m.sthcownid_desc,g_sthc_m.sthcowndp,g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid,g_sthc_m.sthccrtid_desc, 
       g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid,g_sthc_m.sthcmodid_desc, 
       g_sthc_m.sthcmoddt
   
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
   LET g_forupd_sql = "SELECT sthd002,sthd003,sthd004,sthd005,sthd006,sthd007,sthd008,sthd009,sthd011, 
       sthd010 FROM sthd_t WHERE sthdent=? AND sthdsite=? AND sthd001=? AND sthd002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql = "SELECT sthd002,sthd003,sthd004,sthd005,sthd006,sthd007,sthd008,sthd009,sthd011,sthd010  
       FROM sthd_t WHERE sthdent=? AND sthd001=? AND sthdsite=?  AND sthd002=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asti251_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asti251_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL asti251_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_sthc_m.sthcsite,g_sthc_m.sthc001,g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004, 
       g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="asti251.input.head" >}
      #單頭段
      INPUT BY NAME g_sthc_m.sthcsite,g_sthc_m.sthc001,g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004, 
          g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN asti251_cl USING g_enterprise,g_sthc_m.sthc001,g_sthc_m.sthcsite
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asti251_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asti251_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL asti251_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL asti251_set_act_no_visible_b()
            #end add-point
            CALL asti251_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthcsite
            
            #add-point:AFTER FIELD sthcsite name="input.a.sthcsite"
            CALL asti251_sthcsite_ref() RETURNING g_sthc_m.sthcsite_desc
            DISPLAY BY NAME g_sthc_m.sthcsite_desc
            IF NOT cl_null(g_sthc_m.sthcsite) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               IF g_sthc_m.sthcsite!=g_sthc_m_t.sthcsite OR cl_null(g_sthc_m_t.sthcsite) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sthc_m.sthcsite    
                  #160318-00025#41  2016/04/25  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#41  2016/04/25  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001") THEN
                     CALL s_aooi500_chk(g_prog,'sthcsite',g_sthc_m.sthcsite,g_sthc_m.sthcsite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_sthc_m.sthcsite
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        NEXT FIELD sthcsite      #add by yangxf 20160330 #160324-00008#3
                     END IF
                  ELSE
                     LET g_sthc_m.sthcsite=g_sthc_m_t.sthcsite
                     CALL asti251_sthcsite_ref() RETURNING g_sthc_m.sthcsite_desc
                     DISPLAY BY NAME g_sthc_m.sthcsite_desc
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
                  END IF
               END IF
              #CALL cl_set_comp_entry('sthcsite',FALSE) #160324-00008#3 add by yangxf 20160330  #161024-00025#12--mark
            END IF 

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_sthc_m.sthc001) AND NOT cl_null(g_sthc_m.sthcsite) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_sthc_m.sthc001 != g_sthc001_t  OR g_sthc_m.sthcsite != g_sthcsite_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sthc_t WHERE "||"sthcent = '" ||g_enterprise|| "' AND "||"sthc001 = '"||g_sthc_m.sthc001 ||"' AND "|| "sthcsite = '"||g_sthc_m.sthcsite ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           LET g_site_flag = TRUE          #161024-00025#12--add
           CALL asti251_set_entry(p_cmd)  #161024-00025#12--add
           CALL asti251_set_no_entry(p_cmd)  #161024-00025#12--add


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcsite
            #add-point:BEFORE FIELD sthcsite name="input.b.sthcsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthcsite
            #add-point:ON CHANGE sthcsite name="input.g.sthcsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc001
            
            #add-point:AFTER FIELD sthc001 name="input.a.sthc001"
            CALL asti251_sthc001_ref() RETURNING g_sthc_m.sthc001_desc
            DISPLAY BY NAME g_sthc_m.sthc001_desc
            IF NOT cl_null(g_sthc_m.sthc001) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               IF g_sthc_m.sthc001!=g_sthc_m_t.sthc001 OR cl_null(g_sthc_m_t.sthc001) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sthc_m.sthc001   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_stae001") THEN
                     #檢查失敗時後續處理
                     LET g_sthc_m.sthc001=g_sthc_m_t.sthc001
                     CALL asti251_sthc001_ref() RETURNING g_sthc_m.sthc001_desc
                     DISPLAY BY NAME g_sthc_m.sthc001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_sthc_m.sthc001) AND NOT cl_null(g_sthc_m.sthcsite) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_sthc_m.sthc001 != g_sthc001_t  OR g_sthc_m.sthcsite != g_sthcsite_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sthc_t WHERE "||"sthcent = '" ||g_enterprise|| "' AND "||"sthc001 = '"||g_sthc_m.sthc001 ||"' AND "|| "sthcsite = '"||g_sthc_m.sthcsite ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc001
            #add-point:BEFORE FIELD sthc001 name="input.b.sthc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthc001
            #add-point:ON CHANGE sthc001 name="input.g.sthc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc002
            #add-point:BEFORE FIELD sthc002 name="input.b.sthc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc002
            
            #add-point:AFTER FIELD sthc002 name="input.a.sthc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthc002
            #add-point:ON CHANGE sthc002 name="input.g.sthc002"
            IF g_sthc_m.sthc002 = 'N' THEN 
               IF g_sthc_m.sthc003 = 'Y' THEN
                  LET g_sthc_m.sthc002 = 'Y'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ast-00592'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  DISPLAY BY NAME g_sthc_m.sthc002
                  NEXT FIELD sthc002                  
               END IF      
            END IF 
            CALL asti251_set_act_no_visible_b()
            CALL asti251_set_act_visible_b()

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc003
            #add-point:BEFORE FIELD sthc003 name="input.b.sthc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc003
            
            #add-point:AFTER FIELD sthc003 name="input.a.sthc003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthc003
            #add-point:ON CHANGE sthc003 name="input.g.sthc003"
            IF g_sthc_m.sthc003 = 'N' THEN 
               IF g_sthc_m.sthc004 = 'Y' THEN
                  LET g_sthc_m.sthc003 = 'Y'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ast-00593'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  DISPLAY BY NAME g_sthc_m.sthc003
                  NEXT FIELD sthc003                  
               END IF      
            ELSE
               LET g_sthc_m.sthc002 = 'Y'
               DISPLAY BY NAME g_sthc_m.sthc002
            END IF 
            CALL asti251_set_act_no_visible_b()
            CALL asti251_set_act_visible_b()
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc004
            #add-point:BEFORE FIELD sthc004 name="input.b.sthc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc004
            
            #add-point:AFTER FIELD sthc004 name="input.a.sthc004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthc004
            #add-point:ON CHANGE sthc004 name="input.g.sthc004"
            IF g_sthc_m.sthc004  ='Y' THEN 
               LET g_sthc_m.sthc002 = 'Y'
               LET g_sthc_m.sthc003 = 'Y'
               DISPLAY BY NAME g_sthc_m.sthc002,g_sthc_m.sthc003
            END IF 
            CALL asti251_set_act_no_visible_b()
            CALL asti251_set_act_visible_b()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc005
            #add-point:BEFORE FIELD sthc005 name="input.b.sthc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc005
            
            #add-point:AFTER FIELD sthc005 name="input.a.sthc005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthc005
            #add-point:ON CHANGE sthc005 name="input.g.sthc005"
            CALL asti251_set_act_no_visible_b()
            CALL asti251_set_act_visible_b()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthc006
            #add-point:BEFORE FIELD sthc006 name="input.b.sthc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthc006
            
            #add-point:AFTER FIELD sthc006 name="input.a.sthc006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthc006
            #add-point:ON CHANGE sthc006 name="input.g.sthc006"
            CALL asti251_set_act_no_visible_b()
            CALL asti251_set_act_visible_b()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthcstus
            #add-point:BEFORE FIELD sthcstus name="input.b.sthcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthcstus
            
            #add-point:AFTER FIELD sthcstus name="input.a.sthcstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthcstus
            #add-point:ON CHANGE sthcstus name="input.g.sthcstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.sthcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthcsite
            #add-point:ON ACTION controlp INFIELD sthcsite name="input.c.sthcsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_sthc_m.sthcsite             #給予default值
#            LET g_qryparam.default2 = "" #g_sthc_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = g_sthc_m.sthcsite #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'sthcsite',g_sthc_m.sthcsite,'i')
            CALL q_ooef001_24()                                #呼叫開窗
 
            LET g_sthc_m.sthcsite = g_qryparam.return1              
            #LET g_sthc_m.ooef001 = g_qryparam.return2 
            DISPLAY g_sthc_m.sthcsite TO sthcsite              #
            #DISPLAY g_sthc_m.ooef001 TO ooef001 #组织编号
            CALL asti251_sthcsite_ref() RETURNING g_sthc_m.sthcsite_desc
            DISPLAY BY NAME g_sthc_m.sthcsite_desc
            NEXT FIELD sthcsite                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.sthc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc001
            #add-point:ON ACTION controlp INFIELD sthc001 name="input.c.sthc001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_sthc_m.sthc001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_stae001_4()                                #呼叫開窗
 
            LET g_sthc_m.sthc001 = g_qryparam.return1              

            DISPLAY g_sthc_m.sthc001 TO sthc001              #
            CALL asti251_sthc001_ref() RETURNING g_sthc_m.sthc001_desc
            DISPLAY BY NAME g_sthc_m.sthc001_desc
            NEXT FIELD sthc001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.sthc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc002
            #add-point:ON ACTION controlp INFIELD sthc002 name="input.c.sthc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.sthc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc003
            #add-point:ON ACTION controlp INFIELD sthc003 name="input.c.sthc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.sthc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc004
            #add-point:ON ACTION controlp INFIELD sthc004 name="input.c.sthc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.sthc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc005
            #add-point:ON ACTION controlp INFIELD sthc005 name="input.c.sthc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.sthc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthc006
            #add-point:ON ACTION controlp INFIELD sthc006 name="input.c.sthc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.sthcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthcstus
            #add-point:ON ACTION controlp INFIELD sthcstus name="input.c.sthcstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_sthc_m.sthc001,g_sthc_m.sthcsite
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            IF g_sthc_m.sthc002='N' AND g_sthc_m.sthc003='N' AND g_sthc_m.sthc004='N' AND g_sthc_m.sthc005='N' AND g_sthc_m.sthc006='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
              #LET g_errparam.code   = "楼栋，楼层，区域，品类，铺位至少选中一个"   #160324-00008#3 mark by yangxf 2016/03/25 
               LET g_errparam.code   = 'ast-00570'                              #160324-00008#3 add by yangxf 2016/03/25 
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT     #160324-00008#3 add by yangxf 2016/03/25 
            END IF
            CALL asti251_set_act_no_visible_b()
            CALL asti251_set_act_visible_b()
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO sthc_t (sthcent,sthcsite,sthc001,sthc002,sthc003,sthc004,sthc005,sthc006, 
                   sthcstus,sthcownid,sthcowndp,sthccrtid,sthccrtdp,sthccrtdt,sthcmodid,sthcmoddt)
               VALUES (g_enterprise,g_sthc_m.sthcsite,g_sthc_m.sthc001,g_sthc_m.sthc002,g_sthc_m.sthc003, 
                   g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus,g_sthc_m.sthcownid, 
                   g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid, 
                   g_sthc_m.sthcmoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_sthc_m:",SQLERRMESSAGE 
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
                  CALL asti251_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL asti251_b_fill()
                  CALL asti251_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               CALL asti251_set_act_no_visible_b()
               CALL asti251_set_act_visible_b()
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL asti251_sthc_t_mask_restore('restore_mask_o')
               
               UPDATE sthc_t SET (sthcsite,sthc001,sthc002,sthc003,sthc004,sthc005,sthc006,sthcstus, 
                   sthcownid,sthcowndp,sthccrtid,sthccrtdp,sthccrtdt,sthcmodid,sthcmoddt) = (g_sthc_m.sthcsite, 
                   g_sthc_m.sthc001,g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005, 
                   g_sthc_m.sthc006,g_sthc_m.sthcstus,g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid, 
                   g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt)
                WHERE sthcent = g_enterprise AND sthc001 = g_sthc001_t
                  AND sthcsite = g_sthcsite_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "sthc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL asti251_sthc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_sthc_m_t)
               LET g_log2 = util.JSON.stringify(g_sthc_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               CALL asti251_set_act_no_visible_b()
               CALL asti251_set_act_visible_b()
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_sthc001_t = g_sthc_m.sthc001
            LET g_sthcsite_t = g_sthc_m.sthcsite
 
            
      END INPUT
   
 
{</section>}
 
{<section id="asti251.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_sthd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sthd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asti251_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_sthd_d.getLength()
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
            OPEN asti251_cl USING g_enterprise,g_sthc_m.sthc001,g_sthc_m.sthcsite
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asti251_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asti251_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_sthd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_sthd_d[l_ac].sthd002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sthd_d_t.* = g_sthd_d[l_ac].*  #BACKUP
               LET g_sthd_d_o.* = g_sthd_d[l_ac].*  #BACKUP
               CALL asti251_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL asti251_set_no_entry_b(l_cmd)
               IF NOT asti251_lock_b("sthd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asti251_bcl INTO g_sthd_d[l_ac].sthd002,g_sthd_d[l_ac].sthd003,g_sthd_d[l_ac].sthd004, 
                      g_sthd_d[l_ac].sthd005,g_sthd_d[l_ac].sthd006,g_sthd_d[l_ac].sthd007,g_sthd_d[l_ac].sthd008, 
                      g_sthd_d[l_ac].sthd009,g_sthd_d[l_ac].sthd011,g_sthd_d[l_ac].sthd010
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sthd_d_t.sthd002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_sthd_d_mask_o[l_ac].* =  g_sthd_d[l_ac].*
                  CALL asti251_sthd_t_mask()
                  LET g_sthd_d_mask_n[l_ac].* =  g_sthd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asti251_show()
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
            INITIALIZE g_sthd_d[l_ac].* TO NULL 
            INITIALIZE g_sthd_d_t.* TO NULL 
            INITIALIZE g_sthd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_sthd_d[l_ac].sthd002 = "0"
      LET g_sthd_d[l_ac].sthd009 = "1"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"

            SELECT MAX(sthd002)+1 INTO  g_sthd_d[l_ac].sthd002 FROM sthd_t
            WHERE sthdent = g_enterprise AND sthdsite = g_site AND sthd001=g_sthc_m.sthc001
            IF cl_null( g_sthd_d[l_ac].sthd002 ) THEN             
               LET g_sthd_d[l_ac].sthd002 = 1
            END IF
            CALL asti251_set_act_no_visible_b()
            CALL asti251_set_act_visible_b()
            #end add-point
            LET g_sthd_d_t.* = g_sthd_d[l_ac].*     #新輸入資料
            LET g_sthd_d_o.* = g_sthd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asti251_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL asti251_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sthd_d[li_reproduce_target].* = g_sthd_d[li_reproduce].*
 
               LET g_sthd_d[li_reproduce_target].sthd002 = NULL
 
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
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM sthd_t 
             WHERE sthdent = g_enterprise AND sthd001 = g_sthc_m.sthc001
               AND sthdsite = g_sthc_m.sthcsite
 
               AND sthd002 = g_sthd_d[l_ac].sthd002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sthc_m.sthc001
               LET gs_keys[2] = g_sthc_m.sthcsite
               LET gs_keys[3] = g_sthd_d[g_detail_idx].sthd002
               CALL asti251_insert_b('sthd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_sthd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sthd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asti251_b_fill()
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
               LET gs_keys[01] = g_sthc_m.sthc001
               LET gs_keys[gs_keys.getLength()+1] = g_sthc_m.sthcsite
 
               LET gs_keys[gs_keys.getLength()+1] = g_sthd_d_t.sthd002
 
            
               #刪除同層單身
               IF NOT asti251_delete_b('sthd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asti251_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asti251_key_delete_b(gs_keys,'sthd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asti251_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE asti251_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_sthd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sthd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd002
            #add-point:BEFORE FIELD sthd002 name="input.b.page1.sthd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd002
            
            #add-point:AFTER FIELD sthd002 name="input.a.page1.sthd002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_sthc_m.sthc001 IS NOT NULL AND g_sthc_m.sthcsite IS NOT NULL AND g_sthd_d[g_detail_idx].sthd002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sthc_m.sthc001 != g_sthc001_t OR g_sthc_m.sthcsite != g_sthcsite_t OR g_sthd_d[g_detail_idx].sthd002 != g_sthd_d_t.sthd002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sthd_t WHERE "||"sthdent = '" ||g_enterprise|| "' AND "||"sthd001 = '"||g_sthc_m.sthc001 ||"' AND "|| "sthdsite = '"||g_sthc_m.sthcsite ||"' AND "|| "sthd002 = '"||g_sthd_d[g_detail_idx].sthd002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd002
            #add-point:ON CHANGE sthd002 name="input.g.page1.sthd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd003
            
            #add-point:AFTER FIELD sthd003 name="input.a.page1.sthd003"
            CALL asti251_sthd003_ref() RETURNING g_sthd_d[l_ac].sthd003_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd003_desc
            IF NOT cl_null(g_sthd_d[l_ac].sthd003) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               IF g_sthd_d[l_ac].sthd003!=g_sthd_d_t.sthd003 OR cl_null(g_sthd_d_t.sthd003) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sthd_d[l_ac].sthd003
                  LET g_chkparam.arg2 = g_sthc_m.sthcsite             #160512-00003#1 by 08172
                 #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mhaa001_2") THEN
                     #檢查失敗時後續處理
                     LET g_sthd_d[l_ac].sthd003=g_sthd_d_t.sthd003
                     CALL asti251_sthd003_ref() RETURNING g_sthd_d[l_ac].sthd003_desc
                     DISPLAY BY NAME g_sthd_d[l_ac].sthd003_desc
                     NEXT FIELD CURRENT
                  END IF

#                  IF NOT cl_null(g_sthd_d[l_ac].sthd004) THEN
#                     SELECT COUNT(*) INTO l_num FROM mhab_t WHERE mhab002 = g_sthd_d_t.sthd004 AND mhabent = g_enterprise AND mhab001=g_sthd_d_t.sthd003
#                     IF l_num=0 THEN
#                        LET g_sthd_d[l_ac].sthd003=g_sthd_d_t.sthd003
#                        CALL asti251_sthd003_ref() RETURNING g_sthd_d[l_ac].sthd003_desc
#                        DISPLAY BY NAME g_sthd_d[l_ac].sthd003_desc
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
                  CALL asti251_chk_double() RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'std-00004' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            END IF
            IF g_sthd_d[l_ac].sthd003!=g_sthd_d_o.sthd003 OR cl_null(g_sthd_d[l_ac].sthd003) THEN 
              LET g_sthd_d[l_ac].sthd004=""
              LET g_sthd_d[l_ac].sthd005=""
              #160324-00008#3 add by yangxf 20160330(S)
              LET g_sthd_d[l_ac].sthd004_desc=""
              LET g_sthd_d[l_ac].sthd005_desc=""
            END IF 
            LET g_sthd_d_o.sthd003 = g_sthd_d[l_ac].sthd003
            #160324-00008#3 add by yangxf 20160330(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd003
            #add-point:BEFORE FIELD sthd003 name="input.b.page1.sthd003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd003
            #add-point:ON CHANGE sthd003 name="input.g.page1.sthd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd004
            
            #add-point:AFTER FIELD sthd004 name="input.a.page1.sthd004"
            CALL asti251_sthd004_ref() RETURNING g_sthd_d[l_ac].sthd004_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd004_desc
            IF NOT cl_null(g_sthd_d[l_ac].sthd004) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               IF g_sthd_d[l_ac].sthd004!=g_sthd_d_t.sthd004 OR cl_null(g_sthd_d_t.sthd004) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL                 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sthd_d[l_ac].sthd004
                  LET g_chkparam.arg2 = g_sthd_d[l_ac].sthd003 
                  LET g_chkparam.arg3 = g_sthc_m.sthcsite           #160512-00003#1 by 08172     
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mhab002_2") THEN
                     #檢查失敗時後續處理
                     LET g_sthd_d[l_ac].sthd004=g_sthd_d_t.sthd004
                     CALL asti251_sthd004_ref() RETURNING g_sthd_d[l_ac].sthd004_desc
                     DISPLAY BY NAME g_sthd_d[l_ac].sthd004_desc               
                     NEXT FIELD CURRENT
                  END IF

#                  IF NOT cl_null(g_sthd_d[l_ac].sthd005) THEN
#                     SELECT COUNT(*) INTO l_num FROM mhac_t 
#                     WHERE mhac003 =g_sthd_d[l_ac].sthd005 AND mhac001 = g_sthd_d[l_ac].sthd003 AND mhac002=g_sthd_d[l_ac].sthd004 AND mhacent=g_enterprise
#                     IF l_num=0 THEN
#                        LET g_sthd_d[l_ac].sthd004=g_sthd_d_t.sthd004
#                        CALL asti251_sthd004_ref() RETURNING g_sthd_d[l_ac].sthd004_desc
#                        DISPLAY BY NAME g_sthd_d[l_ac].sthd004_desc               
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
                  CALL asti251_chk_double() RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'std-00004' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
                              
            END IF 
            IF g_sthd_d[l_ac].sthd004 != g_sthd_d_o.sthd004 OR cl_null(g_sthd_d[l_ac].sthd004) THEN               #160324-00008#3 add by yangxf 20160330 
               LET g_sthd_d[l_ac].sthd005=""
               #160324-00008#3 add by yangxf 20160330(S)
               LET g_sthd_d[l_ac].sthd005_desc=""
            END IF 
            LET g_sthd_d_o.sthd004 = g_sthd_d[l_ac].sthd004   #160324-00008#3 add by yangxf 20160330  
            #160324-00008#3 add by yangxf 20160330(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd004
            #add-point:BEFORE FIELD sthd004 name="input.b.page1.sthd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd004
            #add-point:ON CHANGE sthd004 name="input.g.page1.sthd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd005
            
            #add-point:AFTER FIELD sthd005 name="input.a.page1.sthd005"
            CALL asti251_sthd005_ref() RETURNING g_sthd_d[l_ac].sthd005_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd005_desc
            IF NOT cl_null(g_sthd_d[l_ac].sthd005) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               IF g_sthd_d[l_ac].sthd005!=g_sthd_d_t.sthd005 OR cl_null(g_sthd_d_t.sthd005) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL                 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sthd_d[l_ac].sthd005
                  LET g_chkparam.arg2 = g_sthd_d[l_ac].sthd003
                  LET g_chkparam.arg3 = g_sthd_d[l_ac].sthd004
                  LET g_chkparam.arg4 = g_sthc_m.sthcsite              #160512-00003#1 by 08172    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mhac003_2") THEN
                     #檢查失敗時後續處理
                     LET g_sthd_d[l_ac].sthd005=g_sthd_d_t.sthd005
                     CALL asti251_sthd005_ref() RETURNING g_sthd_d[l_ac].sthd005_desc
                     DISPLAY BY NAME g_sthd_d[l_ac].sthd005_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL asti251_chk_double() RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'std-00004' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
              
            END IF
                         
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd005
            #add-point:BEFORE FIELD sthd005 name="input.b.page1.sthd005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd005
            #add-point:ON CHANGE sthd005 name="input.g.page1.sthd005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd006
            
            #add-point:AFTER FIELD sthd006 name="input.a.page1.sthd006"
            CALL asti251_sthd006_ref() RETURNING g_sthd_d[l_ac].sthd006_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd006_desc
            IF NOT cl_null(g_sthd_d[l_ac].sthd006) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               IF g_sthd_d[l_ac].sthd006!=g_sthd_d_t.sthd006 OR cl_null(g_sthd_d_t.sthd006) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sthd_d[l_ac].sthd006 
                  LET g_chkparam.arg2 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
                                    
                  #呼叫檢查存在並帶值的library
                 #IF NOT cl_chk_exist("v_rtax001") THEN       #160324-00008#3 mark by yangxf 20160325
                  IF NOT cl_chk_exist("v_rtax001_6") THEN     #160324-00008#3 add by yangxf 20160325
                     #檢查失敗時後續處理
                     LET g_sthd_d[l_ac].sthd006=g_sthd_d_t.sthd006
                     CALL asti251_sthd006_ref() RETURNING g_sthd_d[l_ac].sthd006_desc
                     DISPLAY BY NAME g_sthd_d[l_ac].sthd006_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL asti251_chk_double() RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'std-00004' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd006
            #add-point:BEFORE FIELD sthd006 name="input.b.page1.sthd006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd006
            #add-point:ON CHANGE sthd006 name="input.g.page1.sthd006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd007
            
            #add-point:AFTER FIELD sthd007 name="input.a.page1.sthd007"
            CALL asti251_sthd007_ref() RETURNING g_sthd_d[l_ac].sthd007_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd007_desc
            IF NOT cl_null(g_sthd_d[l_ac].sthd007) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               IF g_sthd_d[l_ac].sthd007!=g_sthd_d_t.sthd007 OR cl_null(g_sthd_d_t.sthd007) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = '2144'
                  LET g_chkparam.arg2 = g_sthd_d[l_ac].sthd007                    
                  #160318-00025#41  2016/04/25  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#41  2016/04/25  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_oocq002_01") THEN
                     #檢查失敗時後續處理
                     LET g_sthd_d[l_ac].sthd007=g_sthd_d_t.sthd007
                     CALL asti251_sthd007_ref() RETURNING g_sthd_d[l_ac].sthd007_desc
                     DISPLAY BY NAME g_sthd_d[l_ac].sthd007_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL asti251_chk_double() RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'std-00004' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            END IF
                 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd007
            #add-point:BEFORE FIELD sthd007 name="input.b.page1.sthd007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd007
            #add-point:ON CHANGE sthd007 name="input.g.page1.sthd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd008
            #add-point:BEFORE FIELD sthd008 name="input.b.page1.sthd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd008
            
            #add-point:AFTER FIELD sthd008 name="input.a.page1.sthd008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd008
            #add-point:ON CHANGE sthd008 name="input.g.page1.sthd008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sthd_d[l_ac].sthd009,"0","0","","","azz-00079",1) THEN
               NEXT FIELD sthd009
            END IF 
 
 
 
            #add-point:AFTER FIELD sthd009 name="input.a.page1.sthd009"
            IF NOT cl_null(g_sthd_d[l_ac].sthd009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd009
            #add-point:BEFORE FIELD sthd009 name="input.b.page1.sthd009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd009
            #add-point:ON CHANGE sthd009 name="input.g.page1.sthd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd011
            #add-point:BEFORE FIELD sthd011 name="input.b.page1.sthd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd011
            
            #add-point:AFTER FIELD sthd011 name="input.a.page1.sthd011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd011
            #add-point:ON CHANGE sthd011 name="input.g.page1.sthd011"
            LET g_sthd_d[l_ac].sthd010 = ''    #160324-00008#3 add by yangxf 20160325
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sthd010
            #add-point:BEFORE FIELD sthd010 name="input.b.page1.sthd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sthd010
            
            #add-point:AFTER FIELD sthd010 name="input.a.page1.sthd010"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sthd010
            #add-point:ON CHANGE sthd010 name="input.g.page1.sthd010"
            #160324-00008#3 add by yangxf 20160325 (S)
            IF NOT cl_null(g_sthd_d[l_ac].sthd011) AND NOT cl_null(g_sthd_d[l_ac].sthd010) THEN 
               CASE g_sthd_d[l_ac].sthd011
                  WHEN '1'
                     #IF g_sthd_d[l_ac].sthd010 = '5'   THEN #mark by geza 20160711 #160604-00009#138
                     IF g_sthd_d[l_ac].sthd010 = '5' OR g_sthd_d[l_ac].sthd010 = '6'  THEN #add by geza 20160711 #160604-00009#138
                        #LET g_sthd_d[l_ac].sthd010 = g_sthd_d_t.sthd010 #mark by geza 20160711 #160604-00009#138
                        LET g_sthd_d[l_ac].sthd010 = '' #add by geza 20160711 #160604-00009#138
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = 'ast-00571' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD sthd010
                     END IF 
                  WHEN '2'
                     #IF g_sthd_d[l_ac].sthd010 != '5' THEN  #mark by geza 20160711 #160604-00009#138
                     IF g_sthd_d[l_ac].sthd010 != '5' AND  g_sthd_d[l_ac].sthd010 != '6' THEN  #add by geza 20160711 #160604-00009#138
                        #LET g_sthd_d[l_ac].sthd010 = g_sthd_d_t.sthd010 #mark by geza 20160711 #160604-00009#138
                        LET g_sthd_d[l_ac].sthd010 = '' #add by geza 20160711 #160604-00009#138
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = 'ast-00572' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD sthd010
                     END IF 
                  WHEN '3'
                     #IF g_sthd_d[l_ac].sthd010 = '4' OR g_sthd_d[l_ac].sthd010 = '5' THEN #mark by geza 20160711 #160604-00009#138
                     IF g_sthd_d[l_ac].sthd010 = '4' OR g_sthd_d[l_ac].sthd010 = '5' OR g_sthd_d[l_ac].sthd010 = '6' THEN #add by geza 20160711 #160604-00009#138
                        #LET g_sthd_d[l_ac].sthd010 = g_sthd_d_t.sthd010 #mark by geza 20160711 #160604-00009#138
                        LET g_sthd_d[l_ac].sthd010 = '' #add by geza 20160711 #160604-00009#138
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = 'ast-00573' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD sthd010
                     END IF 
               END CASE 
            END IF 
            #160324-00008#3 add by yangxf 20160325 (E)
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sthd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd002
            #add-point:ON ACTION controlp INFIELD sthd002 name="input.c.page1.sthd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd003
            #add-point:ON ACTION controlp INFIELD sthd003 name="input.c.page1.sthd003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_sthd_d[l_ac].sthd003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where="mhaasite='",g_sthc_m.sthcsite,"'"          #160512-00003#1 by 08172
 
            CALL q_mhaa001()                                #呼叫開窗
 
            LET g_sthd_d[l_ac].sthd003 = g_qryparam.return1              

            DISPLAY g_sthd_d[l_ac].sthd003 TO sthd003              #
            CALL asti251_sthd003_ref() RETURNING g_sthd_d[l_ac].sthd003_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd003_desc
            NEXT FIELD sthd003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd004
            #add-point:ON ACTION controlp INFIELD sthd004 name="input.c.page1.sthd004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sthd_d[l_ac].sthd004             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "mhab001='",g_sthd_d[l_ac].sthd003,"' AND mhabsite='",g_sthc_m.sthcsite,"'"    #160512-00003#1 by 08172
            CALL q_mhab002()                                #呼叫開窗
 
            LET g_sthd_d[l_ac].sthd004 = g_qryparam.return1              

            DISPLAY g_sthd_d[l_ac].sthd004 TO sthd004              #
            CALL asti251_sthd004_ref() RETURNING g_sthd_d[l_ac].sthd004_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd004_desc
            NEXT FIELD sthd004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd005
            #add-point:ON ACTION controlp INFIELD sthd005 name="input.c.page1.sthd005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_sthd_d[l_ac].sthd005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where=" mhac001='",g_sthd_d[l_ac].sthd003,"' AND mhac002='",g_sthd_d[l_ac].sthd004,"' AND mhacsite='",g_sthc_m.sthcsite,"'"  #160512-00003#1 by 08172 
 
            CALL q_mhac003()                                #呼叫開窗
 
            LET g_sthd_d[l_ac].sthd005 = g_qryparam.return1              

            DISPLAY g_sthd_d[l_ac].sthd005 TO sthd005              #
            CALL asti251_sthd005_ref() RETURNING g_sthd_d[l_ac].sthd005_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd005_desc
            NEXT FIELD sthd005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd006
            #add-point:ON ACTION controlp INFIELD sthd006 name="input.c.page1.sthd006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_sthd_d[l_ac].sthd006             #給予default值
           #LET g_qryparam.where=" AND rtax005=0"    #160324-00008#3 MARK by yangxf 20160325
#            LET g_qryparam.where=" rtax005=0 "       #160324-00008#3 add by yangxf 20160325
            #給予arg
            LET g_qryparam.arg1=cl_get_para(g_enterprise,g_site,'E-CIR-0001') #

 
            CALL q_rtax001_3()                                #呼叫開窗
 
            LET g_sthd_d[l_ac].sthd006 = g_qryparam.return1              

            DISPLAY g_sthd_d[l_ac].sthd006 TO sthd006              #
            CALL asti251_sthd006_ref() RETURNING g_sthd_d[l_ac].sthd006_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd006_desc
            NEXT FIELD sthd006                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd007
            #add-point:ON ACTION controlp INFIELD sthd007 name="input.c.page1.sthd007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = "2144"             #給予default值
            LET g_qryparam.default2 =g_sthd_d[l_ac].sthd007  #g_sthd_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2144" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_sthd_d[l_ac].sthd007 = g_qryparam.return1              
            #LET g_sthd_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_sthd_d[l_ac].sthd007 TO sthd007              #
            #DISPLAY g_sthd_d[l_ac].oocq002 TO oocq002 #應用分類碼
            CALL asti251_sthd007_ref() RETURNING g_sthd_d[l_ac].sthd007_desc
            DISPLAY BY NAME g_sthd_d[l_ac].sthd007_desc
            NEXT FIELD sthd007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd008
            #add-point:ON ACTION controlp INFIELD sthd008 name="input.c.page1.sthd008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd009
            #add-point:ON ACTION controlp INFIELD sthd009 name="input.c.page1.sthd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd011
            #add-point:ON ACTION controlp INFIELD sthd011 name="input.c.page1.sthd011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sthd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sthd010
            #add-point:ON ACTION controlp INFIELD sthd010 name="input.c.page1.sthd010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_sthd_d[l_ac].* = g_sthd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asti251_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_sthd_d[l_ac].sthd002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_sthd_d[l_ac].* = g_sthd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL asti251_sthd_t_mask_restore('restore_mask_o')
      
               UPDATE sthd_t SET (sthd001,sthdsite,sthd002,sthd003,sthd004,sthd005,sthd006,sthd007,sthd008, 
                   sthd009,sthd011,sthd010) = (g_sthc_m.sthc001,g_sthc_m.sthcsite,g_sthd_d[l_ac].sthd002, 
                   g_sthd_d[l_ac].sthd003,g_sthd_d[l_ac].sthd004,g_sthd_d[l_ac].sthd005,g_sthd_d[l_ac].sthd006, 
                   g_sthd_d[l_ac].sthd007,g_sthd_d[l_ac].sthd008,g_sthd_d[l_ac].sthd009,g_sthd_d[l_ac].sthd011, 
                   g_sthd_d[l_ac].sthd010)
                WHERE sthdent = g_enterprise AND sthd001 = g_sthc_m.sthc001 
                  AND sthdsite = g_sthc_m.sthcsite 
 
                  AND sthd002 = g_sthd_d_t.sthd002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_sthd_d[l_ac].* = g_sthd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sthd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_sthd_d[l_ac].* = g_sthd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sthd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sthc_m.sthc001
               LET gs_keys_bak[1] = g_sthc001_t
               LET gs_keys[2] = g_sthc_m.sthcsite
               LET gs_keys_bak[2] = g_sthcsite_t
               LET gs_keys[3] = g_sthd_d[g_detail_idx].sthd002
               LET gs_keys_bak[3] = g_sthd_d_t.sthd002
               CALL asti251_update_b('sthd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL asti251_sthd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_sthd_d[g_detail_idx].sthd002 = g_sthd_d_t.sthd002 
 
                  ) THEN
                  LET gs_keys[01] = g_sthc_m.sthc001
                  LET gs_keys[gs_keys.getLength()+1] = g_sthc_m.sthcsite
 
                  LET gs_keys[gs_keys.getLength()+1] = g_sthd_d_t.sthd002
 
                  CALL asti251_key_update_b(gs_keys,'sthd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_sthc_m),util.JSON.stringify(g_sthd_d_t)
               LET g_log2 = util.JSON.stringify(g_sthc_m),util.JSON.stringify(g_sthd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL asti251_unlock_b("sthd_t","'1'")
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
               LET g_sthd_d[li_reproduce_target].* = g_sthd_d[li_reproduce].*
 
               LET g_sthd_d[li_reproduce_target].sthd002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_sthd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_sthd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="asti251.input.other" >}
      
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
            NEXT FIELD sthcsite
            #end add-point  
            NEXT FIELD sthc001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sthd002
 
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
 
{<section id="asti251.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION asti251_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL asti251_b_fill() #單身填充
      CALL asti251_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL asti251_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_sthc_m_mask_o.* =  g_sthc_m.*
   CALL asti251_sthc_t_mask()
   LET g_sthc_m_mask_n.* =  g_sthc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_sthc_m.sthcsite,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001,g_sthc_m.sthc001_desc,g_sthc_m.sthc002, 
       g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus,g_sthc_m.sthcownid, 
       g_sthc_m.sthcownid_desc,g_sthc_m.sthcowndp,g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid,g_sthc_m.sthccrtid_desc, 
       g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid,g_sthc_m.sthcmodid_desc, 
       g_sthc_m.sthcmoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sthc_m.sthcstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_sthd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   CALL asti251_set_act_no_visible_b()
   CALL asti251_set_act_visible_b()
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL asti251_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION asti251_detail_show()
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
 
{<section id="asti251.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION asti251_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE sthc_t.sthc001 
   DEFINE l_oldno     LIKE sthc_t.sthc001 
   DEFINE l_newno02     LIKE sthc_t.sthcsite 
   DEFINE l_oldno02     LIKE sthc_t.sthcsite 
 
   DEFINE l_master    RECORD LIKE sthc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE sthd_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert      LIKE type_t.num5  #161024-00025#12--add
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
   
   IF g_sthc_m.sthc001 IS NULL
   OR g_sthc_m.sthcsite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_sthc001_t = g_sthc_m.sthc001
   LET g_sthcsite_t = g_sthc_m.sthcsite
 
    
   LET g_sthc_m.sthc001 = ""
   LET g_sthc_m.sthcsite = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_sthc_m.sthcownid = g_user
      LET g_sthc_m.sthcowndp = g_dept
      LET g_sthc_m.sthccrtid = g_user
      LET g_sthc_m.sthccrtdp = g_dept 
      LET g_sthc_m.sthccrtdt = cl_get_current()
      LET g_sthc_m.sthcmodid = g_user
      LET g_sthc_m.sthcmoddt = cl_get_current()
      LET g_sthc_m.sthcstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #161024-00025#12----ADD---BEGIN-------------  
  CALL s_aooi500_default(g_prog,'sthcsite',g_sthc_m.sthcsite)
         RETURNING l_insert,g_sthc_m.sthcsite
   IF NOT l_insert THEN
      RETURN
   END IF 
  #161024-00025#12----ADD---END-------------  
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sthc_m.sthcstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_sthc_m.sthcsite_desc = ''
   DISPLAY BY NAME g_sthc_m.sthcsite_desc
   LET g_sthc_m.sthc001_desc = ''
   DISPLAY BY NAME g_sthc_m.sthc001_desc
 
   
   CALL asti251_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_sthc_m.* TO NULL
      INITIALIZE g_sthd_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL asti251_show()
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
   CALL asti251_set_act_visible()   
   CALL asti251_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_sthc001_t = g_sthc_m.sthc001
   LET g_sthcsite_t = g_sthc_m.sthcsite
 
   
   #組合新增資料的條件
   LET g_add_browse = " sthcent = " ||g_enterprise|| " AND",
                      " sthc001 = '", g_sthc_m.sthc001, "' "
                      ," AND sthcsite = '", g_sthc_m.sthcsite, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asti251_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL asti251_idx_chk()
   
   LET g_data_owner = g_sthc_m.sthcownid      
   LET g_data_dept  = g_sthc_m.sthcowndp
   
   #功能已完成,通報訊息中心
   CALL asti251_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION asti251_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE sthd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE asti251_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM sthd_t
    WHERE sthdent = g_enterprise AND sthd001 = g_sthc001_t
     AND sthdsite = g_sthcsite_t
 
    INTO TEMP asti251_detail
 
   #將key修正為調整後   
   UPDATE asti251_detail 
      #更新key欄位
      SET sthd001 = g_sthc_m.sthc001
          , sthdsite = g_sthc_m.sthcsite
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO sthd_t SELECT * FROM asti251_detail
   
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
   DROP TABLE asti251_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_sthc001_t = g_sthc_m.sthc001
   LET g_sthcsite_t = g_sthc_m.sthcsite
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asti251_delete()
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
   
   IF g_sthc_m.sthc001 IS NULL
   OR g_sthc_m.sthcsite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN asti251_cl USING g_enterprise,g_sthc_m.sthc001,g_sthc_m.sthcsite
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asti251_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asti251_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asti251_master_referesh USING g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthc_m.sthcsite,g_sthc_m.sthc001, 
       g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus, 
       g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt, 
       g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001_desc,g_sthc_m.sthcownid_desc, 
       g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthcmodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT asti251_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_sthc_m_mask_o.* =  g_sthc_m.*
   CALL asti251_sthc_t_mask()
   LET g_sthc_m_mask_n.* =  g_sthc_m.*
   
   CALL asti251_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti251_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_sthc001_t = g_sthc_m.sthc001
      LET g_sthcsite_t = g_sthc_m.sthcsite
 
 
      DELETE FROM sthc_t
       WHERE sthcent = g_enterprise AND sthc001 = g_sthc_m.sthc001
         AND sthcsite = g_sthc_m.sthcsite
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_sthc_m.sthc001,":",SQLERRMESSAGE  
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
      
      DELETE FROM sthd_t
       WHERE sthdent = g_enterprise AND sthd001 = g_sthc_m.sthc001
         AND sthdsite = g_sthc_m.sthcsite
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sthd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_sthc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE asti251_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_sthd_d.clear() 
 
     
      CALL asti251_ui_browser_refresh()  
      #CALL asti251_ui_headershow()  
      #CALL asti251_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL asti251_browser_fill("")
         CALL asti251_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE asti251_cl
 
   #功能已完成,通報訊息中心
   CALL asti251_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="asti251.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asti251_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_sthd_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF asti251_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT sthd002,sthd003,sthd004,sthd005,sthd006,sthd007,sthd008,sthd009, 
             sthd011,sthd010 ,t1.mhaal003 ,t2.mhabl004 ,t3.mhacl005 ,t4.rtaxl003 ,t5.oocql004 FROM sthd_t", 
                
                     " INNER JOIN sthc_t ON sthcent = " ||g_enterprise|| " AND sthc001 = sthd001 ",
                     " AND sthcsite = sthdsite ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN mhaal_t t1 ON t1.mhaalent="||g_enterprise||" AND t1.mhaal001=sthd003 AND t1.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t2 ON t2.mhablent="||g_enterprise||" AND t2.mhabl001=sthd003 AND t2.mhabl002=sthd004 AND t2.mhabl003='"||g_dlang||"' ",
               " LEFT JOIN mhacl_t t3 ON t3.mhaclent="||g_enterprise||" AND t3.mhacl001=sthd003 AND t3.mhacl002=sthd004 AND t3.mhacl003=sthd005 AND t3.mhacl004='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=sthd006 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='2144' AND t5.oocql002=sthd007 AND t5.oocql003='"||g_dlang||"' ",
 
                     " WHERE sthdent=? AND sthd001=? AND sthdsite=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY sthd_t.sthd002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asti251_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR asti251_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_sthc_m.sthc001,g_sthc_m.sthcsite   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthd_d[l_ac].sthd002, 
          g_sthd_d[l_ac].sthd003,g_sthd_d[l_ac].sthd004,g_sthd_d[l_ac].sthd005,g_sthd_d[l_ac].sthd006, 
          g_sthd_d[l_ac].sthd007,g_sthd_d[l_ac].sthd008,g_sthd_d[l_ac].sthd009,g_sthd_d[l_ac].sthd011, 
          g_sthd_d[l_ac].sthd010,g_sthd_d[l_ac].sthd003_desc,g_sthd_d[l_ac].sthd004_desc,g_sthd_d[l_ac].sthd005_desc, 
          g_sthd_d[l_ac].sthd006_desc,g_sthd_d[l_ac].sthd007_desc   #(ver:78)
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
   
   CALL g_sthd_d.deleteElement(g_sthd_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE asti251_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_sthd_d.getLength()
      LET g_sthd_d_mask_o[l_ac].* =  g_sthd_d[l_ac].*
      CALL asti251_sthd_t_mask()
      LET g_sthd_d_mask_n[l_ac].* =  g_sthd_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asti251_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM sthd_t
       WHERE sthdent = g_enterprise AND
         sthd001 = ps_keys_bak[1] AND sthdsite = ps_keys_bak[2] AND sthd002 = ps_keys_bak[3]
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
         CALL g_sthd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asti251_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO sthd_t
                  (sthdent,
                   sthd001,sthdsite,
                   sthd002
                   ,sthd003,sthd004,sthd005,sthd006,sthd007,sthd008,sthd009,sthd011,sthd010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_sthd_d[g_detail_idx].sthd003,g_sthd_d[g_detail_idx].sthd004,g_sthd_d[g_detail_idx].sthd005, 
                       g_sthd_d[g_detail_idx].sthd006,g_sthd_d[g_detail_idx].sthd007,g_sthd_d[g_detail_idx].sthd008, 
                       g_sthd_d[g_detail_idx].sthd009,g_sthd_d[g_detail_idx].sthd011,g_sthd_d[g_detail_idx].sthd010) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sthd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_sthd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asti251_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sthd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL asti251_sthd_t_mask_restore('restore_mask_o')
               
      UPDATE sthd_t 
         SET (sthd001,sthdsite,
              sthd002
              ,sthd003,sthd004,sthd005,sthd006,sthd007,sthd008,sthd009,sthd011,sthd010) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_sthd_d[g_detail_idx].sthd003,g_sthd_d[g_detail_idx].sthd004,g_sthd_d[g_detail_idx].sthd005, 
                  g_sthd_d[g_detail_idx].sthd006,g_sthd_d[g_detail_idx].sthd007,g_sthd_d[g_detail_idx].sthd008, 
                  g_sthd_d[g_detail_idx].sthd009,g_sthd_d[g_detail_idx].sthd011,g_sthd_d[g_detail_idx].sthd010)  
 
         WHERE sthdent = g_enterprise AND sthd001 = ps_keys_bak[1] AND sthdsite = ps_keys_bak[2] AND sthd002 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sthd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sthd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asti251_sthd_t_mask_restore('restore_mask_n')
               
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
 
{<section id="asti251.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION asti251_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="asti251.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION asti251_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="asti251.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asti251_lock_b(ps_table,ps_page)
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
   #CALL asti251_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "sthd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN asti251_bcl USING g_enterprise,
                                       g_sthc_m.sthc001,g_sthc_m.sthcsite,g_sthd_d[g_detail_idx].sthd002  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asti251_bcl:",SQLERRMESSAGE 
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
 
{<section id="asti251.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asti251_unlock_b(ps_table,ps_page)
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
      CLOSE asti251_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION asti251_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("sthc001,sthcsite",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
  #CALL cl_set_comp_entry("sthcsite,sthc001,sthc002,sthc003,sthc004,sthc005,sthc006",TRUE) #161024-00025#12--mark
   CALL cl_set_comp_entry("sthc001,sthc002,sthc003,sthc004,sthc005,sthc006",TRUE) #161024-00025#12--add
   
   IF g_sthc_m.sthc002='Y' THEN
      CALL cl_set_comp_visible("sthd003",TRUE)
      CALL cl_set_comp_visible("sthd003_desc",TRUE)
   END IF
   IF g_sthc_m.sthc003='Y' THEN
      CALL cl_set_comp_visible("sthd004",TRUE)
      CALL cl_set_comp_visible("sthd004_desc",TRUE)
   END IF
   IF g_sthc_m.sthc004='Y' THEN
      CALL cl_set_comp_visible("sthd005",TRUE)
      CALL cl_set_comp_visible("sthd005_desc",TRUE)
   END IF
   IF g_sthc_m.sthc005='Y' THEN
      CALL cl_set_comp_visible("sthd006",TRUE)
      CALL cl_set_comp_visible("sthd006_desc",TRUE)
   END IF
   IF g_sthc_m.sthc006='Y' THEN
      CALL cl_set_comp_visible("sthd007",TRUE)
      CALL cl_set_comp_visible("sthd007_desc",TRUE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION asti251_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_num   LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("sthc001,sthcsite",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'u' THEN
      SELECT COUNT(*) INTO l_num 
        FROM sthd_t 
       WHERE sthdent=g_enterprise
         AND sthdsite=g_sthc_m.sthcsite
         AND sthd001=g_sthc_m.sthc001
       # AND sthd002=g_sthd_d[g_detail_idx].sthd002     #160324-00008#3 mark by yangxf 20160325
      IF l_num!=0 THEN
        #CALL cl_set_comp_entry("sthcsite,sthc001,sthc002,sthc003,sthc004,sthc005,sthc006",FALSE) #161024-00025#12--mark
         CALL cl_set_comp_entry("sthc001,sthc002,sthc003,sthc004,sthc005,sthc006",FALSE)   #161024-00025#12--add
      END IF
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'sthcsite') OR g_site_flag   THEN
      CALL cl_set_comp_entry("sthcsite",FALSE)
   END IF
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asti251.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asti251_set_entry_b(p_cmd)
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
 
{<section id="asti251.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asti251_set_no_entry_b(p_cmd)
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
 
{<section id="asti251.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION asti251_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asti251.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION asti251_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asti251.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION asti251_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   IF g_sthc_m.sthc002!='N' THEN
      CALL cl_set_comp_visible("sthd003",TRUE)
      CALL cl_set_comp_visible("sthd003_desc",TRUE)
   END IF
   IF g_sthc_m.sthc003!='N' THEN
      CALL cl_set_comp_visible("sthd004",TRUE)
      CALL cl_set_comp_visible("sthd004_desc",TRUE)
   END IF
   IF g_sthc_m.sthc004!='N' THEN
      CALL cl_set_comp_visible("sthd005",TRUE)
      CALL cl_set_comp_visible("sthd005_desc",TRUE)
   END IF
   IF g_sthc_m.sthc005!='N' THEN
      CALL cl_set_comp_visible("sthd006",TRUE)
      CALL cl_set_comp_visible("sthd006_desc",TRUE)
   END IF
   IF g_sthc_m.sthc006!='N' THEN
      CALL cl_set_comp_visible("sthd007",TRUE)
      CALL cl_set_comp_visible("sthd007_desc",TRUE)
   END IF
  
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asti251.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION asti251_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   IF g_sthc_m.sthc002='N' THEN
      CALL cl_set_comp_visible("sthd003",FALSE)
      CALL cl_set_comp_visible("sthd003_desc",FALSE)
   END IF
   IF g_sthc_m.sthc003='N' THEN
      CALL cl_set_comp_visible("sthd004",FALSE)
      CALL cl_set_comp_visible("sthd004_desc",FALSE)
   END IF
   IF g_sthc_m.sthc004='N' THEN
      CALL cl_set_comp_visible("sthd005",FALSE)
      CALL cl_set_comp_visible("sthd005_desc",FALSE)
   END IF
   IF g_sthc_m.sthc005='N' THEN
      CALL cl_set_comp_visible("sthd006",FALSE)
      CALL cl_set_comp_visible("sthd006_desc",FALSE)
   END IF
   IF g_sthc_m.sthc006='N' THEN
      CALL cl_set_comp_visible("sthd007",FALSE)
      CALL cl_set_comp_visible("sthd007_desc",FALSE)
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asti251.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asti251_default_search()
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
      LET ls_wc = ls_wc, " sthc001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " sthcsite = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "sthc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "sthd_t" 
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
 
{<section id="asti251.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION asti251_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_sthc_m.sthc001 IS NULL
      OR g_sthc_m.sthcsite IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN asti251_cl USING g_enterprise,g_sthc_m.sthc001,g_sthc_m.sthcsite
   IF STATUS THEN
      CLOSE asti251_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asti251_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE asti251_master_referesh USING g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthc_m.sthcsite,g_sthc_m.sthc001, 
       g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus, 
       g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdt, 
       g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001_desc,g_sthc_m.sthcownid_desc, 
       g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthcmodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT asti251_action_chk() THEN
      CLOSE asti251_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_sthc_m.sthcsite,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001,g_sthc_m.sthc001_desc,g_sthc_m.sthc002, 
       g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus,g_sthc_m.sthcownid, 
       g_sthc_m.sthcownid_desc,g_sthc_m.sthcowndp,g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid,g_sthc_m.sthccrtid_desc, 
       g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid,g_sthc_m.sthcmodid_desc, 
       g_sthc_m.sthcmoddt
 
   CASE g_sthc_m.sthcstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_sthc_m.sthcstus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_sthc_m.sthcstus = lc_state OR cl_null(lc_state) THEN
      CLOSE asti251_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_sthc_m.sthcmodid = g_user
   LET g_sthc_m.sthcmoddt = cl_get_current()
   LET g_sthc_m.sthcstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE sthc_t 
      SET (sthcstus,sthcmodid,sthcmoddt) 
        = (g_sthc_m.sthcstus,g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt)     
    WHERE sthcent = g_enterprise AND sthc001 = g_sthc_m.sthc001
      AND sthcsite = g_sthc_m.sthcsite
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE asti251_master_referesh USING g_sthc_m.sthc001,g_sthc_m.sthcsite INTO g_sthc_m.sthcsite, 
          g_sthc_m.sthc001,g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006, 
          g_sthc_m.sthcstus,g_sthc_m.sthcownid,g_sthc_m.sthcowndp,g_sthc_m.sthccrtid,g_sthc_m.sthccrtdp, 
          g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid,g_sthc_m.sthcmoddt,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001_desc, 
          g_sthc_m.sthcownid_desc,g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp_desc, 
          g_sthc_m.sthcmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_sthc_m.sthcsite,g_sthc_m.sthcsite_desc,g_sthc_m.sthc001,g_sthc_m.sthc001_desc, 
          g_sthc_m.sthc002,g_sthc_m.sthc003,g_sthc_m.sthc004,g_sthc_m.sthc005,g_sthc_m.sthc006,g_sthc_m.sthcstus, 
          g_sthc_m.sthcownid,g_sthc_m.sthcownid_desc,g_sthc_m.sthcowndp,g_sthc_m.sthcowndp_desc,g_sthc_m.sthccrtid, 
          g_sthc_m.sthccrtid_desc,g_sthc_m.sthccrtdp,g_sthc_m.sthccrtdp_desc,g_sthc_m.sthccrtdt,g_sthc_m.sthcmodid, 
          g_sthc_m.sthcmodid_desc,g_sthc_m.sthcmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE asti251_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asti251_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asti251.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION asti251_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_sthd_d.getLength() THEN
         LET g_detail_idx = g_sthd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sthd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sthd_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asti251_b_fill2(pi_idx)
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
   
   CALL asti251_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION asti251_fill_chk(ps_idx)
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
 
{<section id="asti251.status_show" >}
PRIVATE FUNCTION asti251_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asti251.mask_functions" >}
&include "erp/ast/asti251_mask.4gl"
 
{</section>}
 
{<section id="asti251.signature" >}
   
 
{</section>}
 
{<section id="asti251.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asti251_set_pk_array()
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
   LET g_pk_array[1].values = g_sthc_m.sthc001
   LET g_pk_array[1].column = 'sthc001'
   LET g_pk_array[2].values = g_sthc_m.sthcsite
   LET g_pk_array[2].column = 'sthcsite'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asti251.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="asti251.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION asti251_msgcentre_notify(lc_state)
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
   CALL asti251_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_sthc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asti251.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION asti251_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asti251.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 门店编号参考带值
################################################################################
PRIVATE FUNCTION asti251_sthcsite_ref()
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sthc_m.sthcsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = '', g_rtn_fields[1] , ''
   RETURN r_ooefl003
END FUNCTION

################################################################################
# Descriptions...: 费用编号参考带值
################################################################################
PRIVATE FUNCTION asti251_sthc001_ref()
   DEFINE r_stael003 LIKE stael_t.stael003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sthc_m.sthc001
   CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_stael003 = '', g_rtn_fields[1] , ''
   RETURN r_stael003
END FUNCTION

################################################################################
# Descriptions...: 楼栋参考带值
################################################################################
PRIVATE FUNCTION asti251_sthd003_ref()
   DEFINE r_mhaal003 LIKE mhaal_t.mhaal003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sthd_d[l_ac].sthd003
   CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_mhaal003 = '', g_rtn_fields[1] , ''
   RETURN r_mhaal003
END FUNCTION

################################################################################
# Descriptions...: 楼层参考带值
################################################################################
PRIVATE FUNCTION asti251_sthd004_ref()
   DEFINE r_mhabl004 LIKE mhabl_t.mhabl004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sthd_d[l_ac].sthd003
   LET g_ref_fields[2] = g_sthd_d[l_ac].sthd004
   CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_mhabl004 = '', g_rtn_fields[1] , ''
   RETURN r_mhabl004
END FUNCTION

################################################################################
# Descriptions...: 区域参考带值
################################################################################
PRIVATE FUNCTION asti251_sthd005_ref()
   DEFINE r_mhacl005 LIKE mhacl_t.mhacl005
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sthd_d[l_ac].sthd003
   LET g_ref_fields[2] = g_sthd_d[l_ac].sthd004
   LET g_ref_fields[3] = g_sthd_d[l_ac].sthd005
   CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_mhacl005 = '', g_rtn_fields[1] , ''
   RETURN r_mhacl005
END FUNCTION

################################################################################
# Descriptions...: 品类参考带值
################################################################################
PRIVATE FUNCTION asti251_sthd006_ref()
   DEFINE r_rtaxl003 LIKE rtaxl_t.rtaxl003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sthd_d[l_ac].sthd006
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_rtaxl003 = '', g_rtn_fields[1] , ''
   RETURN r_rtaxl003
END FUNCTION

################################################################################
# Descriptions...:铺位参考带值
################################################################################
PRIVATE FUNCTION asti251_sthd007_ref()
   DEFINE r_oocql004 LIKE oocql_t.oocql004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sthd_d[l_ac].sthd007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2144' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = '', g_rtn_fields[1] , ''
   RETURN r_oocql004
END FUNCTION

################################################################################
# Descriptions...:检查单身重复资料
################################################################################
PRIVATE FUNCTION asti251_chk_double()
DEFINE l_sql STRING
DEFINE l_num LIKE type_t.num10
DEFINE r_success LIKE type_t.num10
LET l_sql=" SELECT COUNT(*) FROM sthd_t WHERE sthdent='",g_enterprise,"' AND sthdsite='",g_sthc_m.sthcsite,"' AND sthd001='",g_sthc_m.sthc001,"'"
IF g_sthc_m.sthc002='Y' THEN
   LET l_sql=l_sql," AND sthd003='",g_sthd_d[l_ac].sthd003,"'"
END IF
IF g_sthc_m.sthc003='Y' THEN
   LET l_sql=l_sql," AND sthd004='",g_sthd_d[l_ac].sthd004,"'"
END IF
IF g_sthc_m.sthc004='Y' THEN
   LET l_sql=l_sql," AND sthd005='",g_sthd_d[l_ac].sthd005,"'"
END IF
IF g_sthc_m.sthc005='Y' THEN
   LET l_sql=l_sql," AND sthd006='",g_sthd_d[l_ac].sthd006,"'"
END IF
IF g_sthc_m.sthc006='Y' THEN
   LET l_sql=l_sql," AND sthd007='",g_sthd_d[l_ac].sthd007,"'"
END IF
PREPARE body_cnt_pre FROM l_sql
EXECUTE body_cnt_pre INTO l_num 
IF  l_num=0 THEN
   LET r_success=TRUE
ELSE
   LET r_success=FALSE
END IF
RETURN r_success
END FUNCTION

 
{</section>}
 
