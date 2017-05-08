#該程式未解開Section, 採用最新樣板產出!
{<section id="agct401.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2016-09-01 16:05:41), PR版次:0021(2016-11-11 11:06:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000377
#+ Filename...: agct401
#+ Description: 券發行維護作業
#+ Creator....: 02296(2013-11-04 16:32:58)
#+ Modifier...: 05948 -SD/PR- 02481
 
{</section>}
 
{<section id="agct401.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#12  2016/03/25 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160604-00009#50  2016/07/22 by 08172    库区预设值
#160816-00068#11  2016/08/19 By 08209    調整transaction
#160818-00017#14  2016/08/25 by 08172    修改删除时重新检查状态
#160905-00007#3   2016/09/02 By zhujing  调整系统中无ENT的SQL条件增加ent
#160824-00007#101 2016/10/24 By 06814    新舊值相關調整
#161024-00025#7   2016/10/25 by 08742    组织开窗调整
#161111-00028#1   2016/11/11 BY 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_gcak_m        RECORD
       gcaksite LIKE gcak_t.gcaksite, 
   gcaksite_desc LIKE type_t.chr80, 
   gcakdocdt LIKE gcak_t.gcakdocdt, 
   gcakdocno LIKE gcak_t.gcakdocno, 
   gcak001 LIKE gcak_t.gcak001, 
   gcakunit LIKE gcak_t.gcakunit, 
   gcakstus LIKE gcak_t.gcakstus, 
   gcakownid LIKE gcak_t.gcakownid, 
   gcakownid_desc LIKE type_t.chr80, 
   gcakowndp LIKE gcak_t.gcakowndp, 
   gcakowndp_desc LIKE type_t.chr80, 
   gcakcrtid LIKE gcak_t.gcakcrtid, 
   gcakcrtid_desc LIKE type_t.chr80, 
   gcakcrtdp LIKE gcak_t.gcakcrtdp, 
   gcakcrtdp_desc LIKE type_t.chr80, 
   gcakcrtdt LIKE gcak_t.gcakcrtdt, 
   gcakmodid LIKE gcak_t.gcakmodid, 
   gcakmodid_desc LIKE type_t.chr80, 
   gcakmoddt LIKE gcak_t.gcakmoddt, 
   gcakcnfid LIKE gcak_t.gcakcnfid, 
   gcakcnfid_desc LIKE type_t.chr80, 
   gcakcnfdt LIKE gcak_t.gcakcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gcal_d        RECORD
       gcalseq LIKE gcal_t.gcalseq, 
   gcalsite LIKE gcal_t.gcalsite, 
   gcalsite_desc LIKE type_t.chr500, 
   gcal001 LIKE gcal_t.gcal001, 
   gcal001_desc LIKE type_t.chr10, 
   gcal013 LIKE gcal_t.gcal013, 
   gcal013_desc LIKE type_t.chr500, 
   gcal014 LIKE gcal_t.gcal014, 
   gcal002 LIKE gcal_t.gcal002, 
   gcal003 LIKE gcal_t.gcal003, 
   gcal004 LIKE gcal_t.gcal004, 
   gcal005 LIKE gcal_t.gcal005, 
   gcal006 LIKE gcal_t.gcal006, 
   gcal007 LIKE gcal_t.gcal007, 
   gcal008 LIKE gcal_t.gcal008, 
   gcal008_desc LIKE type_t.chr500, 
   gcal009 LIKE gcal_t.gcal009, 
   gcal010 LIKE gcal_t.gcal010, 
   gcal011 LIKE gcal_t.gcal011, 
   gcal011_desc LIKE type_t.chr500, 
   gcal012 LIKE gcal_t.gcal012, 
   gcal012_desc LIKE type_t.chr500, 
   gcalunit LIKE gcal_t.gcalunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gcaksite LIKE gcak_t.gcaksite,
   b_gcaksite_desc LIKE type_t.chr80,
      b_gcakdocdt LIKE gcak_t.gcakdocdt,
      b_gcakdocno LIKE gcak_t.gcakdocno,
      b_gcak001 LIKE gcak_t.gcak001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_ins_site_flag       LIKE type_t.chr1
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gcak_m          type_g_gcak_m
DEFINE g_gcak_m_t        type_g_gcak_m
DEFINE g_gcak_m_o        type_g_gcak_m
DEFINE g_gcak_m_mask_o   type_g_gcak_m #轉換遮罩前資料
DEFINE g_gcak_m_mask_n   type_g_gcak_m #轉換遮罩後資料
 
   DEFINE g_gcakdocno_t LIKE gcak_t.gcakdocno
 
 
DEFINE g_gcal_d          DYNAMIC ARRAY OF type_g_gcal_d
DEFINE g_gcal_d_t        type_g_gcal_d
DEFINE g_gcal_d_o        type_g_gcal_d
DEFINE g_gcal_d_mask_o   DYNAMIC ARRAY OF type_g_gcal_d #轉換遮罩前資料
DEFINE g_gcal_d_mask_n   DYNAMIC ARRAY OF type_g_gcal_d #轉換遮罩後資料
 
 
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
 
{<section id="agct401.main" >}
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
   CALL cl_ap_init("agc","")
 
   #add-point:作業初始化 name="main.init"
      SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent=g_enterprise
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gcaksite,'',gcakdocdt,gcakdocno,gcak001,gcakunit,gcakstus,gcakownid,'', 
       gcakowndp,'',gcakcrtid,'',gcakcrtdp,'',gcakcrtdt,gcakmodid,'',gcakmoddt,gcakcnfid,'',gcakcnfdt", 
        
                      " FROM gcak_t",
                      " WHERE gcakent= ? AND gcakdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct401_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gcaksite,t0.gcakdocdt,t0.gcakdocno,t0.gcak001,t0.gcakunit,t0.gcakstus, 
       t0.gcakownid,t0.gcakowndp,t0.gcakcrtid,t0.gcakcrtdp,t0.gcakcrtdt,t0.gcakmodid,t0.gcakmoddt,t0.gcakcnfid, 
       t0.gcakcnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011", 
 
               " FROM gcak_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.gcaksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.gcakownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.gcakowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.gcakcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.gcakcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.gcakmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.gcakcnfid  ",
 
               " WHERE t0.gcakent = " ||g_enterprise|| " AND t0.gcakdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agct401_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agct401 WITH FORM cl_ap_formpath("agc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agct401_init()   
 
      #進入選單 Menu (="N")
      CALL agct401_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agct401
      
   END IF 
   
   CLOSE agct401_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   ##150427-00001#9 150604s By pomelo add(S)
   CALL s_lot_auto_drop_tmp('aint911')
   CALL s_aooi390_drop_tmp_table()
   ##150427-00001#9 150604 By pomelo add(E)
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agct401.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agct401_init()
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
      CALL cl_set_combo_scc_part('gcakstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible("gcakunit,gcalunit",false)
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309      
   #150427-00001#9 150604 By pomelo add(S)
   LET l_success = ''
   CALL s_lot_auto_create_tmp('aint911') RETURNING l_success
   
   LET l_success = ''
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   #150427-00001#9 150604 By pomelo add(E)
   #end add-point
   
   #初始化搜尋條件
   CALL agct401_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agct401.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agct401_ui_dialog()
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
            CALL agct401_insert()
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
         INITIALIZE g_gcak_m.* TO NULL
         CALL g_gcal_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agct401_init()
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
               
               CALL agct401_fetch('') # reload data
               LET l_ac = 1
               CALL agct401_ui_detailshow() #Setting the current row 
         
               CALL agct401_idx_chk()
               #NEXT FIELD gcalseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_gcal_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agct401_idx_chk()
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
               CALL agct401_idx_chk()
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
            CALL agct401_browser_fill("")
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
               CALL agct401_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agct401_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL agct401_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL agct401_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL agct401_set_act_visible()   
            CALL agct401_set_act_no_visible()
            IF NOT (g_gcak_m.gcakdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " gcakent = " ||g_enterprise|| " AND",
                                  " gcakdocno = '", g_gcak_m.gcakdocno, "' "
 
               #填到對應位置
               CALL agct401_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "gcak_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcal_t" 
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
               CALL agct401_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "gcak_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcal_t" 
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
                  CALL agct401_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL agct401_fetch("F")
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
               CALL agct401_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agct401_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct401_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agct401_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct401_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agct401_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct401_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agct401_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct401_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agct401_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct401_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gcal_d)
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
               NEXT FIELD gcalseq
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
         ON ACTION demo2
            LET g_action_choice="demo2"
            IF cl_auth_chk_act("demo2") THEN
               
               #add-point:ON ACTION demo2 name="menu.demo2"
               IF cl_null(l_ac) OR l_ac=0 THEN
                  LET l_ac=1
               END IF
               IF NOT cl_null(g_gcal_d[l_ac].gcalseq) THEN
                  CALL aooi360_02('7','agct401',g_gcak_m.gcakdocno,g_gcal_d[l_ac].gcalseq,'','','','','','','','')
               ELSE
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL agct401_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#14 -s by 08172
               CALL agct401_set_act_visible()   
               CALL agct401_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agct401_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#14 -s by 08172
               CALL agct401_set_act_visible()   
               CALL agct401_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION demo
            LET g_action_choice="demo"
            IF cl_auth_chk_act("demo") THEN
               
               #add-point:ON ACTION demo name="menu.demo"
               CALL aooi360_02('6','agct401',g_gcak_m.gcakdocno,'','','','','','','','','') 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION downloadtemplet
            LET g_action_choice="downloadtemplet"
            IF cl_auth_chk_act("downloadtemplet") THEN
               
               #add-point:ON ACTION downloadtemplet name="menu.downloadtemplet"
                  CALL s_excel_templet_download()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agct401_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#14 -s by 08172
               CALL agct401_set_act_visible()   
               CALL agct401_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agct401_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/agc/agct401_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/agc/agct401_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL agct401_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agct401_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION uploadtemplet
            LET g_action_choice="uploadtemplet"
            IF cl_auth_chk_act("uploadtemplet") THEN
               
               #add-point:ON ACTION uploadtemplet name="menu.uploadtemplet"
               CALL s_excel_templet_upload()  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
               IF NOT cl_null(g_gcak_m.gcakdocno) AND g_gcak_m.gcakstus='N' THEN 
                  CALL agct401_excel()
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aint911
            LET g_action_choice="prog_aint911"
            IF cl_auth_chk_act("prog_aint911") THEN
               
               #add-point:ON ACTION prog_aint911 name="menu.prog_aint911"
               #160303-00009#2 20160307 add by beckxie---S
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint911'
               LET la_param.param[1] = g_gcak_m.gcak001

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #160303-00009#2 20160307 add by beckxie---E
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agct401_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agct401_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agct401_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_gcak_m.gcakdocdt)
 
 
 
         
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
 
{<section id="agct401.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agct401_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'gcaksite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT gcakdocno ",
                      " FROM gcak_t ",
                      " ",
                      " LEFT JOIN gcal_t ON gcalent = gcakent AND gcakdocno = gcaldocno ", "  ",
                      #add-point:browser_fill段sql(gcal_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE gcakent = " ||g_enterprise|| " AND gcalent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gcak_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gcakdocno ",
                      " FROM gcak_t ", 
                      "  ",
                      "  ",
                      " WHERE gcakent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gcak_t")
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
      INITIALIZE g_gcak_m.* TO NULL
      CALL g_gcal_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gcaksite,t0.gcakdocdt,t0.gcakdocno,t0.gcak001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gcakstus,t0.gcaksite,t0.gcakdocdt,t0.gcakdocno,t0.gcak001,t1.ooefl003 ", 
 
                  " FROM gcak_t t0",
                  "  ",
                  "  LEFT JOIN gcal_t ON gcalent = gcakent AND gcakdocno = gcaldocno ", "  ", 
                  #add-point:browser_fill段sql(gcal_t1) name="browser_fill.join.gcal_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.gcaksite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.gcakent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("gcak_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gcakstus,t0.gcaksite,t0.gcakdocdt,t0.gcakdocno,t0.gcak001,t1.ooefl003 ", 
 
                  " FROM gcak_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.gcaksite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.gcakent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("gcak_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY gcakdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gcak_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
   
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gcaksite,g_browser[g_cnt].b_gcakdocdt, 
          g_browser[g_cnt].b_gcakdocno,g_browser[g_cnt].b_gcak001,g_browser[g_cnt].b_gcaksite_desc
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
         CALL agct401_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_gcakdocno) THEN
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
 
{<section id="agct401.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agct401_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gcak_m.gcakdocno = g_browser[g_current_idx].b_gcakdocno   
 
   EXECUTE agct401_master_referesh USING g_gcak_m.gcakdocno INTO g_gcak_m.gcaksite,g_gcak_m.gcakdocdt, 
       g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt, 
       g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt,g_gcak_m.gcaksite_desc,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp_desc, 
       g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakcnfid_desc 
 
   
   CALL agct401_gcak_t_mask()
   CALL agct401_show()
      
END FUNCTION
 
{</section>}
 
{<section id="agct401.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agct401_ui_detailshow()
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
 
{<section id="agct401.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agct401_ui_browser_refresh()
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
      IF g_browser[l_i].b_gcakdocno = g_gcak_m.gcakdocno 
 
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
 
{<section id="agct401.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agct401_construct()
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
   INITIALIZE g_gcak_m.* TO NULL
   CALL g_gcal_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON gcaksite,gcakdocdt,gcakdocno,gcak001,gcakunit,gcakstus,gcakownid,gcakowndp, 
          gcakcrtid,gcakcrtdp,gcakcrtdt,gcakmodid,gcakmoddt,gcakcnfid,gcakcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcakcrtdt>>----
         AFTER FIELD gcakcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gcakmoddt>>----
         AFTER FIELD gcakmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gcakcnfdt>>----
         AFTER FIELD gcakcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gcakpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.gcaksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaksite
            #add-point:ON ACTION controlp INFIELD gcaksite name="construct.c.gcaksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcaksite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO gcaksite  #顯示到畫面上

            NEXT FIELD gcaksite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaksite
            #add-point:BEFORE FIELD gcaksite name="construct.b.gcaksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaksite
            
            #add-point:AFTER FIELD gcaksite name="construct.a.gcaksite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakdocdt
            #add-point:BEFORE FIELD gcakdocdt name="construct.b.gcakdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakdocdt
            
            #add-point:AFTER FIELD gcakdocdt name="construct.a.gcakdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcakdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakdocdt
            #add-point:ON ACTION controlp INFIELD gcakdocdt name="construct.c.gcakdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcakdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakdocno
            #add-point:ON ACTION controlp INFIELD gcakdocno name="construct.c.gcakdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_gcakdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcakdocno  #顯示到畫面上

            NEXT FIELD gcakdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakdocno
            #add-point:BEFORE FIELD gcakdocno name="construct.b.gcakdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakdocno
            
            #add-point:AFTER FIELD gcakdocno name="construct.a.gcakdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcak001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcak001
            #add-point:ON ACTION controlp INFIELD gcak001 name="construct.c.gcak001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "inba005='6' "
            CALL q_inbadocno()             #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcak001  #顯示到畫面上

            NEXT FIELD gcak001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcak001
            #add-point:BEFORE FIELD gcak001 name="construct.b.gcak001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcak001
            
            #add-point:AFTER FIELD gcak001 name="construct.a.gcak001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakunit
            #add-point:BEFORE FIELD gcakunit name="construct.b.gcakunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakunit
            
            #add-point:AFTER FIELD gcakunit name="construct.a.gcakunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcakunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakunit
            #add-point:ON ACTION controlp INFIELD gcakunit name="construct.c.gcakunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakstus
            #add-point:BEFORE FIELD gcakstus name="construct.b.gcakstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakstus
            
            #add-point:AFTER FIELD gcakstus name="construct.a.gcakstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakstus
            #add-point:ON ACTION controlp INFIELD gcakstus name="construct.c.gcakstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcakownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakownid
            #add-point:ON ACTION controlp INFIELD gcakownid name="construct.c.gcakownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcakownid  #顯示到畫面上

            NEXT FIELD gcakownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakownid
            #add-point:BEFORE FIELD gcakownid name="construct.b.gcakownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakownid
            
            #add-point:AFTER FIELD gcakownid name="construct.a.gcakownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcakowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakowndp
            #add-point:ON ACTION controlp INFIELD gcakowndp name="construct.c.gcakowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcakowndp  #顯示到畫面上

            NEXT FIELD gcakowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakowndp
            #add-point:BEFORE FIELD gcakowndp name="construct.b.gcakowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakowndp
            
            #add-point:AFTER FIELD gcakowndp name="construct.a.gcakowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcakcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakcrtid
            #add-point:ON ACTION controlp INFIELD gcakcrtid name="construct.c.gcakcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcakcrtid  #顯示到畫面上

            NEXT FIELD gcakcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakcrtid
            #add-point:BEFORE FIELD gcakcrtid name="construct.b.gcakcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakcrtid
            
            #add-point:AFTER FIELD gcakcrtid name="construct.a.gcakcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcakcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakcrtdp
            #add-point:ON ACTION controlp INFIELD gcakcrtdp name="construct.c.gcakcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcakcrtdp  #顯示到畫面上

            NEXT FIELD gcakcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakcrtdp
            #add-point:BEFORE FIELD gcakcrtdp name="construct.b.gcakcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakcrtdp
            
            #add-point:AFTER FIELD gcakcrtdp name="construct.a.gcakcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakcrtdt
            #add-point:BEFORE FIELD gcakcrtdt name="construct.b.gcakcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcakmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakmodid
            #add-point:ON ACTION controlp INFIELD gcakmodid name="construct.c.gcakmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcakmodid  #顯示到畫面上

            NEXT FIELD gcakmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakmodid
            #add-point:BEFORE FIELD gcakmodid name="construct.b.gcakmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakmodid
            
            #add-point:AFTER FIELD gcakmodid name="construct.a.gcakmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakmoddt
            #add-point:BEFORE FIELD gcakmoddt name="construct.b.gcakmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcakcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakcnfid
            #add-point:ON ACTION controlp INFIELD gcakcnfid name="construct.c.gcakcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcakcnfid  #顯示到畫面上

            NEXT FIELD gcakcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakcnfid
            #add-point:BEFORE FIELD gcakcnfid name="construct.b.gcakcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakcnfid
            
            #add-point:AFTER FIELD gcakcnfid name="construct.a.gcakcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakcnfdt
            #add-point:BEFORE FIELD gcakcnfdt name="construct.b.gcakcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gcalseq,gcalsite,gcal001,gcal013,gcal002,gcal003,gcal004,gcal005,gcal006, 
          gcal007,gcal008,gcal009,gcal010,gcal011,gcal012,gcalunit
           FROM s_detail1[1].gcalseq,s_detail1[1].gcalsite,s_detail1[1].gcal001,s_detail1[1].gcal013, 
               s_detail1[1].gcal002,s_detail1[1].gcal003,s_detail1[1].gcal004,s_detail1[1].gcal005,s_detail1[1].gcal006, 
               s_detail1[1].gcal007,s_detail1[1].gcal008,s_detail1[1].gcal009,s_detail1[1].gcal010,s_detail1[1].gcal011, 
               s_detail1[1].gcal012,s_detail1[1].gcalunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcalseq
            #add-point:BEFORE FIELD gcalseq name="construct.b.page1.gcalseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcalseq
            
            #add-point:AFTER FIELD gcalseq name="construct.a.page1.gcalseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcalseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcalseq
            #add-point:ON ACTION controlp INFIELD gcalseq name="construct.c.page1.gcalseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcalsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcalsite
            #add-point:ON ACTION controlp INFIELD gcalsite name="construct.c.page1.gcalsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcalsite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO gcalsite  #顯示到畫面上

            NEXT FIELD gcalsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcalsite
            #add-point:BEFORE FIELD gcalsite name="construct.b.page1.gcalsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcalsite
            
            #add-point:AFTER FIELD gcalsite name="construct.a.page1.gcalsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal001
            #add-point:ON ACTION controlp INFIELD gcal001 name="construct.c.page1.gcal001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_gcaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcal001  #顯示到畫面上

            NEXT FIELD gcal001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal001
            #add-point:BEFORE FIELD gcal001 name="construct.b.page1.gcal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal001
            
            #add-point:AFTER FIELD gcal001 name="construct.a.page1.gcal001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal013
            #add-point:ON ACTION controlp INFIELD gcal013 name="construct.c.page1.gcal013"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2071'
            CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = null
            DISPLAY g_qryparam.return1 TO gcal013  #顯示到畫面上

            NEXT FIELD gcal013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal013
            #add-point:BEFORE FIELD gcal013 name="construct.b.page1.gcal013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal013
            
            #add-point:AFTER FIELD gcal013 name="construct.a.page1.gcal013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal002
            #add-point:BEFORE FIELD gcal002 name="construct.b.page1.gcal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal002
            
            #add-point:AFTER FIELD gcal002 name="construct.a.page1.gcal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal002
            #add-point:ON ACTION controlp INFIELD gcal002 name="construct.c.page1.gcal002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal003
            #add-point:BEFORE FIELD gcal003 name="construct.b.page1.gcal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal003
            
            #add-point:AFTER FIELD gcal003 name="construct.a.page1.gcal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal003
            #add-point:ON ACTION controlp INFIELD gcal003 name="construct.c.page1.gcal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal004
            #add-point:BEFORE FIELD gcal004 name="construct.b.page1.gcal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal004
            
            #add-point:AFTER FIELD gcal004 name="construct.a.page1.gcal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal004
            #add-point:ON ACTION controlp INFIELD gcal004 name="construct.c.page1.gcal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal005
            #add-point:BEFORE FIELD gcal005 name="construct.b.page1.gcal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal005
            
            #add-point:AFTER FIELD gcal005 name="construct.a.page1.gcal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal005
            #add-point:ON ACTION controlp INFIELD gcal005 name="construct.c.page1.gcal005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal006
            #add-point:BEFORE FIELD gcal006 name="construct.b.page1.gcal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal006
            
            #add-point:AFTER FIELD gcal006 name="construct.a.page1.gcal006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal006
            #add-point:ON ACTION controlp INFIELD gcal006 name="construct.c.page1.gcal006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal007
            #add-point:BEFORE FIELD gcal007 name="construct.b.page1.gcal007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal007
            
            #add-point:AFTER FIELD gcal007 name="construct.a.page1.gcal007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal007
            #add-point:ON ACTION controlp INFIELD gcal007 name="construct.c.page1.gcal007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcal008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal008
            #add-point:ON ACTION controlp INFIELD gcal008 name="construct.c.page1.gcal008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_rtdx001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcal008  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO rtdx001 #商品編號 

            NEXT FIELD gcal008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal008
            #add-point:BEFORE FIELD gcal008 name="construct.b.page1.gcal008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal008
            
            #add-point:AFTER FIELD gcal008 name="construct.a.page1.gcal008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal009
            #add-point:BEFORE FIELD gcal009 name="construct.b.page1.gcal009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal009
            
            #add-point:AFTER FIELD gcal009 name="construct.a.page1.gcal009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal009
            #add-point:ON ACTION controlp INFIELD gcal009 name="construct.c.page1.gcal009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal010
            #add-point:BEFORE FIELD gcal010 name="construct.b.page1.gcal010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal010
            
            #add-point:AFTER FIELD gcal010 name="construct.a.page1.gcal010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal010
            #add-point:ON ACTION controlp INFIELD gcal010 name="construct.c.page1.gcal010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcal011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal011
            #add-point:ON ACTION controlp INFIELD gcal011 name="construct.c.page1.gcal011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcal011  #顯示到畫面上

            NEXT FIELD gcal011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal011
            #add-point:BEFORE FIELD gcal011 name="construct.b.page1.gcal011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal011
            
            #add-point:AFTER FIELD gcal011 name="construct.a.page1.gcal011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcal012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal012
            #add-point:ON ACTION controlp INFIELD gcal012 name="construct.c.page1.gcal012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcal012  #顯示到畫面上

            NEXT FIELD gcal012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal012
            #add-point:BEFORE FIELD gcal012 name="construct.b.page1.gcal012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal012
            
            #add-point:AFTER FIELD gcal012 name="construct.a.page1.gcal012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcalunit
            #add-point:BEFORE FIELD gcalunit name="construct.b.page1.gcalunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcalunit
            
            #add-point:AFTER FIELD gcalunit name="construct.a.page1.gcalunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcalunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcalunit
            #add-point:ON ACTION controlp INFIELD gcalunit name="construct.c.page1.gcalunit"
            
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
                  WHEN la_wc[li_idx].tableid = "gcak_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gcal_t" 
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
 
{<section id="agct401.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION agct401_filter()
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
      CONSTRUCT g_wc_filter ON gcaksite,gcakdocdt,gcakdocno,gcak001
                          FROM s_browse[1].b_gcaksite,s_browse[1].b_gcakdocdt,s_browse[1].b_gcakdocno, 
                              s_browse[1].b_gcak001
 
         BEFORE CONSTRUCT
               DISPLAY agct401_filter_parser('gcaksite') TO s_browse[1].b_gcaksite
            DISPLAY agct401_filter_parser('gcakdocdt') TO s_browse[1].b_gcakdocdt
            DISPLAY agct401_filter_parser('gcakdocno') TO s_browse[1].b_gcakdocno
            DISPLAY agct401_filter_parser('gcak001') TO s_browse[1].b_gcak001
      
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
 
      CALL agct401_filter_show('gcaksite')
   CALL agct401_filter_show('gcakdocdt')
   CALL agct401_filter_show('gcakdocno')
   CALL agct401_filter_show('gcak001')
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION agct401_filter_parser(ps_field)
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
 
{<section id="agct401.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION agct401_filter_show(ps_field)
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
   LET ls_condition = agct401_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agct401_query()
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
   CALL g_gcal_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL agct401_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agct401_browser_fill("")
      CALL agct401_fetch("")
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
      CALL agct401_filter_show('gcaksite')
   CALL agct401_filter_show('gcakdocdt')
   CALL agct401_filter_show('gcakdocno')
   CALL agct401_filter_show('gcak001')
   CALL agct401_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL agct401_fetch("F") 
      #顯示單身筆數
      CALL agct401_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agct401_fetch(p_flag)
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
   
   LET g_gcak_m.gcakdocno = g_browser[g_current_idx].b_gcakdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agct401_master_referesh USING g_gcak_m.gcakdocno INTO g_gcak_m.gcaksite,g_gcak_m.gcakdocdt, 
       g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt, 
       g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt,g_gcak_m.gcaksite_desc,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp_desc, 
       g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakcnfid_desc 
 
   
   #遮罩相關處理
   LET g_gcak_m_mask_o.* =  g_gcak_m.*
   CALL agct401_gcak_t_mask()
   LET g_gcak_m_mask_n.* =  g_gcak_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agct401_set_act_visible()   
   CALL agct401_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#      IF g_gcak_m.gcakstus <> 'N' THEN
#      CALL cl_set_act_visible("modify,delete", FALSE)
#   else
#      CALL cl_set_act_visible("modify,delete", TRUE)   
#   END IF
   IF g_gcak_m.gcakstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gcak_m_t.* = g_gcak_m.*
   LET g_gcak_m_o.* = g_gcak_m.*
   
   LET g_data_owner = g_gcak_m.gcakownid      
   LET g_data_dept  = g_gcak_m.gcakowndp
   
   #重新顯示   
   CALL agct401_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.insert" >}
#+ 資料新增
PRIVATE FUNCTION agct401_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert    LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004  
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gcal_d.clear()   
 
 
   INITIALIZE g_gcak_m.* TO NULL             #DEFAULT 設定
   
   LET g_gcakdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcak_m.gcakownid = g_user
      LET g_gcak_m.gcakowndp = g_dept
      LET g_gcak_m.gcakcrtid = g_user
      LET g_gcak_m.gcakcrtdp = g_dept 
      LET g_gcak_m.gcakcrtdt = cl_get_current()
      LET g_gcak_m.gcakmodid = g_user
      LET g_gcak_m.gcakmoddt = cl_get_current()
      LET g_gcak_m.gcakstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gcak_m.gcakstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
            LET g_gcak_m.gcakstus = "N"
#      LET g_gcak_m.gcaksite = g_site
      LET g_ins_site_flag = FALSE   #161024-00025#7  2016/10/25  by 08742  add
      CALL s_aooi500_default(g_prog,'gcaksite',g_gcak_m.gcaksite)
         RETURNING l_insert,g_gcak_m.gcaksite
      IF NOT l_insert THEN
         RETURN
      END IF
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_gcak_m.gcaksite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_gcak_m.gcaksite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_gcak_m.gcaksite_desc
      LET g_gcak_m.gcakunit = g_gcak_m.gcaksite
      LET g_gcak_m.gcakdocdt = g_today
      let g_gcak_m_t.* = g_gcak_m.*
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_gcak_m.gcaksite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_gcak_m.gcakdocno = l_doctype
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gcak_m_t.* = g_gcak_m.*
      LET g_gcak_m_o.* = g_gcak_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcak_m.gcakstus 
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
 
 
 
    
      CALL agct401_input("a")
      
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
         INITIALIZE g_gcak_m.* TO NULL
         INITIALIZE g_gcal_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL agct401_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gcal_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agct401_set_act_visible()   
   CALL agct401_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " gcakent = " ||g_enterprise|| " AND",
                      " gcakdocno = '", g_gcak_m.gcakdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agct401_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE agct401_cl
   
   CALL agct401_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agct401_master_referesh USING g_gcak_m.gcakdocno INTO g_gcak_m.gcaksite,g_gcak_m.gcakdocdt, 
       g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt, 
       g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt,g_gcak_m.gcaksite_desc,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp_desc, 
       g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_gcak_m_mask_o.* =  g_gcak_m.*
   CALL agct401_gcak_t_mask()
   LET g_gcak_m_mask_n.* =  g_gcak_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gcak_m.gcaksite,g_gcak_m.gcaksite_desc,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001, 
       g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakowndp_desc,g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdp_desc, 
       g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakmoddt,g_gcak_m.gcakcnfid, 
       g_gcak_m.gcakcnfid_desc,g_gcak_m.gcakcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gcak_m.gcakownid      
   LET g_data_dept  = g_gcak_m.gcakowndp
   
   #功能已完成,通報訊息中心
   CALL agct401_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.modify" >}
#+ 資料修改
PRIVATE FUNCTION agct401_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_gcak_m.gcakstus MATCHES "[DR]" THEN 
      LET g_gcak_m.gcakstus = "N"
   END IF
   IF g_gcak_m.gcakstus <> "N" THEN
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gcak_m_t.* = g_gcak_m.*
   LET g_gcak_m_o.* = g_gcak_m.*
   
   IF g_gcak_m.gcakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
   CALL s_transaction_begin()
   
   OPEN agct401_cl USING g_enterprise,g_gcak_m.gcakdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct401_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agct401_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agct401_master_referesh USING g_gcak_m.gcakdocno INTO g_gcak_m.gcaksite,g_gcak_m.gcakdocdt, 
       g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt, 
       g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt,g_gcak_m.gcaksite_desc,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp_desc, 
       g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT agct401_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gcak_m_mask_o.* =  g_gcak_m.*
   CALL agct401_gcak_t_mask()
   LET g_gcak_m_mask_n.* =  g_gcak_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL agct401_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gcak_m.gcakmodid = g_user 
LET g_gcak_m.gcakmoddt = cl_get_current()
LET g_gcak_m.gcakmodid_desc = cl_get_username(g_gcak_m.gcakmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_gcak_m.gcakstus MATCHES "[DR]" THEN 
         LET g_gcak_m.gcakstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL agct401_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gcak_t SET (gcakmodid,gcakmoddt) = (g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt)
          WHERE gcakent = g_enterprise AND gcakdocno = g_gcakdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gcak_m.* = g_gcak_m_t.*
            CALL agct401_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gcak_m.gcakdocno != g_gcak_m_t.gcakdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE gcal_t SET gcaldocno = g_gcak_m.gcakdocno
 
          WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m_t.gcakdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gcal_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcal_t:",SQLERRMESSAGE 
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
   CALL agct401_set_act_visible()   
   CALL agct401_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gcakent = " ||g_enterprise|| " AND",
                      " gcakdocno = '", g_gcak_m.gcakdocno, "' "
 
   #填到對應位置
   CALL agct401_browser_fill("")
 
   CLOSE agct401_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agct401_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="agct401.input" >}
#+ 資料輸入
PRIVATE FUNCTION agct401_input(p_cmd)
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
   DEFINE  l_errno               LIKE type_t.chr10
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
   DISPLAY BY NAME g_gcak_m.gcaksite,g_gcak_m.gcaksite_desc,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001, 
       g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakowndp_desc,g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdp_desc, 
       g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakmoddt,g_gcak_m.gcakcnfid, 
       g_gcak_m.gcakcnfid_desc,g_gcak_m.gcakcnfdt
   
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
   LET g_forupd_sql = "SELECT gcalseq,gcalsite,gcal001,gcal013,gcal014,gcal002,gcal003,gcal004,gcal005, 
       gcal006,gcal007,gcal008,gcal009,gcal010,gcal011,gcal012,gcalunit FROM gcal_t WHERE gcalent=?  
       AND gcaldocno=? AND gcalseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct401_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agct401_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL agct401_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gcak_m.gcaksite,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit, 
       g_gcak_m.gcakstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
      SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent=g_enterprise
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agct401.input.head" >}
      #單頭段
      INPUT BY NAME g_gcak_m.gcaksite,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit, 
          g_gcak_m.gcakstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN agct401_cl USING g_enterprise,g_gcak_m.gcakdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct401_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct401_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL agct401_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
                        CALL agct401_set_entry(p_cmd)
            CALL agct401_set_no_entry(p_cmd)
            LET g_gcakdocno_t = g_gcak_m.gcakdocno
            #end add-point
            CALL agct401_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaksite
            
            #add-point:AFTER FIELD gcaksite name="input.a.gcaksite"
            #161024-00025#7  2016/10/25 by 08742 -S
            LET g_gcak_m.gcaksite_desc = NULL
            DISPLAY BY NAME g_gcak_m.gcaksite_desc
            IF  NOT cl_null(g_gcak_m.gcaksite) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gcak_m.gcaksite != g_gcak_m_t.gcaksite or g_gcak_m_t.gcaksite is null )) THEN 
#                  CALL agct401_chk_gcaksite(g_gcak_m.gcaksite)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_gcak_m.gcaksite
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_gcak_m.gcaksite = g_gcak_m_t.gcaksite
#                     CALL agct401_display_gcaksite()
#                     NEXT FIELD gcaksite
#                  END IF
#                  CALL s_aooi500_chk(g_prog,'gcaksite',g_gcak_m.gcaksite,g_gcak_m.gcaksite) RETURNING l_success,l_errno
#                  IF NOT l_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = g_gcak_m.gcaksite
#                     LET g_errparam.code   = l_errno
#                     LET g_errparam.popup  = TRUE
#                     CALL cl_err()
#                  
#                     LET g_gcak_m.gcaksite = g_gcak_m_t.gcaksite
#                     CALL agct401_display_gcaksite()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            CALL agct401_display_gcaksite()
             CALL s_aooi500_chk(g_prog,'gcaksite',g_gcak_m.gcaksite,g_gcak_m.gcaksite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_gcak_m.gcaksite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_gcak_m.gcaksite = g_gcak_m_t.gcaksite
                     CALL agct401_display_gcaksite()
                     NEXT FIELD CURRENT
                  ELSE 
                     LET g_ins_site_flag = TRUE      
                  END IF
               END IF
            END IF
                        
            CALL agct401_display_gcaksite()
            CALL agct401_set_entry(p_cmd)   #單身時記得須改用l_cmd
            CALL agct401_set_no_entry(p_cmd)   #單身時記得須改用l_cmd
            #161024-00025#7  2016/10/25 by 08742 -E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaksite
            #add-point:BEFORE FIELD gcaksite name="input.b.gcaksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaksite
            #add-point:ON CHANGE gcaksite name="input.g.gcaksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakdocdt
            #add-point:BEFORE FIELD gcakdocdt name="input.b.gcakdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakdocdt
            
            #add-point:AFTER FIELD gcakdocdt name="input.a.gcakdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcakdocdt
            #add-point:ON CHANGE gcakdocdt name="input.g.gcakdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakdocno
            #add-point:BEFORE FIELD gcakdocno name="input.b.gcakdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakdocno
            
            #add-point:AFTER FIELD gcakdocno name="input.a.gcakdocno"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcak_m.gcakdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gcak_m.gcakdocno != g_gcakdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gcak_t WHERE "||"gcakent = '" ||g_enterprise|| "' AND "||"gcakdocno = '"||g_gcak_m.gcakdocno ||"'",'std-00004',0) THEN 
                     LET g_gcak_m.gcakdocno = g_gcak_m_t.gcakdocno
                     NEXT FIELD CURRENT
                  END IF
#                  CALL agct401_chk_gcakdocno(g_gcak_m.gcakdocno)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_gcak_m.gcakdocno,g_errno,1)
#                     LET g_gcak_m.gcakdocno = g_gcak_m_t.gcakdocno
#                     NEXT FIELD gcakdocno
#                  END IF
                  CALL s_aooi200_chk_slip(g_site,g_ooef004,g_gcak_m.gcakdocno,g_prog) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_gcak_m.gcakdocno = g_gcak_m_t.gcakdocno
                     NEXT FIELD gcakdocno
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcakdocno
            #add-point:ON CHANGE gcakdocno name="input.g.gcakdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcak001
            #add-point:BEFORE FIELD gcak001 name="input.b.gcak001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcak001
            
            #add-point:AFTER FIELD gcak001 name="input.a.gcak001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcak001
            #add-point:ON CHANGE gcak001 name="input.g.gcak001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakunit
            #add-point:BEFORE FIELD gcakunit name="input.b.gcakunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakunit
            
            #add-point:AFTER FIELD gcakunit name="input.a.gcakunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcakunit
            #add-point:ON CHANGE gcakunit name="input.g.gcakunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcakstus
            #add-point:BEFORE FIELD gcakstus name="input.b.gcakstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcakstus
            
            #add-point:AFTER FIELD gcakstus name="input.a.gcakstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcakstus
            #add-point:ON CHANGE gcakstus name="input.g.gcakstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gcaksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaksite
            #add-point:ON ACTION controlp INFIELD gcaksite name="input.c.gcaksite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcak_m.gcaksite             #給予default值
#            LET g_qryparam.arg1 = g_site
#            #給予arg
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcaksite',g_gcak_m.gcaksite,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()

            LET g_gcak_m.gcaksite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcak_m.gcaksite TO gcaksite              #顯示到畫面上
            CALL agct401_display_gcaksite()
            NEXT FIELD gcaksite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcakdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakdocdt
            #add-point:ON ACTION controlp INFIELD gcakdocdt name="input.c.gcakdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcakdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakdocno
            #add-point:ON ACTION controlp INFIELD gcakdocno name="input.c.gcakdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcak_m.gcakdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = "agct401" #   #160705-00042#2 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#2 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_gcak_m.gcakdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcak_m.gcakdocno TO gcakdocno              #顯示到畫面上

            NEXT FIELD gcakdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcak001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcak001
            #add-point:ON ACTION controlp INFIELD gcak001 name="input.c.gcak001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcakunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakunit
            #add-point:ON ACTION controlp INFIELD gcakunit name="input.c.gcakunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcakstus
            #add-point:ON ACTION controlp INFIELD gcakstus name="input.c.gcakstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gcak_m.gcakdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                                 CALL s_aooi200_gen_docno(g_gcak_m.gcaksite,g_gcak_m.gcakdocno,g_gcak_m.gcakdocdt,g_prog)
                  RETURNING g_success,g_gcak_m.gcakdocno
                  IF g_success<>'1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apm-00003"
                     LET g_errparam.extend = g_gcak_m.gcakdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcak_m.gcakdocno = g_gcak_m_t.gcakdocno
                     NEXT FIELD gcakdocno
                  END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gcak_t WHERE "||"gcakent = '" ||g_enterprise|| "' AND "||"gcakdocno = '"||g_gcak_m.gcakdocno ||"'",'std-00004',0) THEN 
                     LET g_gcak_m.gcakdocno = g_gcak_m_t.gcakdocno
                     NEXT FIELD gcakdocno
                  END IF
                  LET g_gcak_m_t.gcakdocno = g_gcak_m.gcakdocno
               #end add-point
               
               INSERT INTO gcak_t (gcakent,gcaksite,gcakdocdt,gcakdocno,gcak001,gcakunit,gcakstus,gcakownid, 
                   gcakowndp,gcakcrtid,gcakcrtdp,gcakcrtdt,gcakmodid,gcakmoddt,gcakcnfid,gcakcnfdt)
               VALUES (g_enterprise,g_gcak_m.gcaksite,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001, 
                   g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakowndp,g_gcak_m.gcakcrtid, 
                   g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt,g_gcak_m.gcakcnfid, 
                   g_gcak_m.gcakcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gcak_m:",SQLERRMESSAGE 
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
                  CALL agct401_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL agct401_b_fill()
                  CALL agct401_b_fill2('0')
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
               CALL agct401_gcak_t_mask_restore('restore_mask_o')
               
               UPDATE gcak_t SET (gcaksite,gcakdocdt,gcakdocno,gcak001,gcakunit,gcakstus,gcakownid,gcakowndp, 
                   gcakcrtid,gcakcrtdp,gcakcrtdt,gcakmodid,gcakmoddt,gcakcnfid,gcakcnfdt) = (g_gcak_m.gcaksite, 
                   g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus, 
                   g_gcak_m.gcakownid,g_gcak_m.gcakowndp,g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt, 
                   g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt,g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt)
                WHERE gcakent = g_enterprise AND gcakdocno = g_gcakdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gcak_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL agct401_gcak_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gcak_m_t)
               LET g_log2 = util.JSON.stringify(g_gcak_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="agct401.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gcal_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION irregular_papercoupon
            LET g_action_choice="irregular_papercoupon"
            IF cl_auth_chk_act("irregular_papercoupon") THEN
               
               #add-point:ON ACTION irregular_papercoupon name="input.detail_input.page1.irregular_papercoupon"
               CALL agct401_01(g_gcak_m.gcaksite,g_gcak_m.gcakdocno)
               CALL agct401_b_fill()
               EXIT DIALOG               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcal_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agct401_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gcal_d.getLength()
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
            OPEN agct401_cl USING g_enterprise,g_gcak_m.gcakdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct401_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct401_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gcal_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gcal_d[l_ac].gcalseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gcal_d_t.* = g_gcal_d[l_ac].*  #BACKUP
               LET g_gcal_d_o.* = g_gcal_d[l_ac].*  #BACKUP
               CALL agct401_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL agct401_set_no_entry_b(l_cmd)
               IF NOT agct401_lock_b("gcal_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agct401_bcl INTO g_gcal_d[l_ac].gcalseq,g_gcal_d[l_ac].gcalsite,g_gcal_d[l_ac].gcal001, 
                      g_gcal_d[l_ac].gcal013,g_gcal_d[l_ac].gcal014,g_gcal_d[l_ac].gcal002,g_gcal_d[l_ac].gcal003, 
                      g_gcal_d[l_ac].gcal004,g_gcal_d[l_ac].gcal005,g_gcal_d[l_ac].gcal006,g_gcal_d[l_ac].gcal007, 
                      g_gcal_d[l_ac].gcal008,g_gcal_d[l_ac].gcal009,g_gcal_d[l_ac].gcal010,g_gcal_d[l_ac].gcal011, 
                      g_gcal_d[l_ac].gcal012,g_gcal_d[l_ac].gcalunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gcal_d_t.gcalseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcal_d_mask_o[l_ac].* =  g_gcal_d[l_ac].*
                  CALL agct401_gcal_t_mask()
                  LET g_gcal_d_mask_n[l_ac].* =  g_gcal_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agct401_show()
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
            INITIALIZE g_gcal_d[l_ac].* TO NULL 
            INITIALIZE g_gcal_d_t.* TO NULL 
            INITIALIZE g_gcal_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_gcak_m.gcaksite,'5')  RETURNING  l_success,g_gcal_d[l_ac].gcal011
            CALL agct401_display_gcal011()
            CALL s_artt220_default(g_gcak_m.gcaksite,'6')  RETURNING  l_success,g_gcal_d[l_ac].gcal012
            CALL agct401_display_gcal012()
            #160604-00009#50 -e by 08172
            #end add-point
            LET g_gcal_d_t.* = g_gcal_d[l_ac].*     #新輸入資料
            LET g_gcal_d_o.* = g_gcal_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agct401_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL agct401_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcal_d[li_reproduce_target].* = g_gcal_d[li_reproduce].*
 
               LET g_gcal_d[li_reproduce_target].gcalseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
                        let g_gcal_d[l_ac].gcalsite = g_gcak_m.gcaksite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gcal_d[l_ac].gcalsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gcal_d[l_ac].gcalsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gcal_d[l_ac].gcalsite_desc
            let g_gcal_d[l_ac].gcalunit = g_gcak_m.gcakunit
            call agct401_create_gcalseq()
            LET g_gcal_d_o.* = g_gcal_d[l_ac].*   #160824-00007#101 20161024 add by beckxie
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
            SELECT COUNT(1) INTO l_count FROM gcal_t 
             WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
 
               AND gcalseq = g_gcal_d[l_ac].gcalseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcak_m.gcakdocno
               LET gs_keys[2] = g_gcal_d[g_detail_idx].gcalseq
               CALL agct401_insert_b('gcal_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gcal_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcal_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agct401_b_fill()
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
               LET gs_keys[01] = g_gcak_m.gcakdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_gcal_d_t.gcalseq
 
            
               #刪除同層單身
               IF NOT agct401_delete_b('gcal_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct401_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agct401_key_delete_b(gs_keys,'gcal_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct401_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE agct401_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  
               #end add-point
               LET l_count = g_gcal_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
            
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gcal_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcalseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcal_d[l_ac].gcalseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcalseq
            END IF 
 
 
 
            #add-point:AFTER FIELD gcalseq name="input.a.page1.gcalseq"
                        IF NOT cl_null(g_gcal_d[l_ac].gcalseq) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcak_m.gcakdocno) AND NOT cl_null(g_gcal_d[g_detail_idx].gcalseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcak_m.gcakdocno != g_gcakdocno_t OR g_gcal_d[g_detail_idx].gcalseq != g_gcal_d_t.gcalseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gcal_t WHERE "||"gcalent = '" ||g_enterprise|| "' AND "||"gcaldocno = '"||g_gcak_m.gcakdocno ||"' AND "|| "gcalseq = '"||g_gcal_d[g_detail_idx].gcalseq ||"'",'std-00004',0) THEN 
                     LET g_gcal_d[l_ac].gcalseq = g_gcal_d_t.gcalseq
                     NEXT FIELD gcalseq
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcalseq
            #add-point:BEFORE FIELD gcalseq name="input.b.page1.gcalseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcalseq
            #add-point:ON CHANGE gcalseq name="input.g.page1.gcalseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcalsite
            
            #add-point:AFTER FIELD gcalsite name="input.a.page1.gcalsite"
            LET g_gcal_d[l_ac].gcalsite_desc = NULL
            DISPLAY  g_gcal_d[l_ac].gcalsite_desc TO s_detail1[l_ac].gcalsite_desc
            IF NOT cl_null(g_gcal_d[l_ac].gcalsite) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcalsite != g_gcal_d_t.gcalsite or g_gcal_d_t.gcalsite is null)) THEN    #160824-00007#101 20161024 mark by beckxie
               IF g_gcal_d[l_ac].gcalsite != g_gcal_d_o.gcalsite or cl_null(g_gcal_d_o.gcalsite) THEN    #160824-00007#101 20161024 add by beckxie
#                  CALL agct401_chk_gcaksite(g_gcal_d[l_ac].gcalsite)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_gcal_d[l_ac].gcalsite
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_gcal_d[l_ac].gcalsite = g_gcal_d_t.gcalsite
#                     CALL agct401_display_gcalsite()
#                     NEXT FIELD gcalsite
#                  END IF
                  CALL s_aooi500_chk(g_prog,'gcalsite',g_gcal_d[l_ac].gcalsite,g_gcak_m.gcaksite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_gcal_d[l_ac].gcalsite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     #LET g_gcal_d[l_ac].gcalsite = g_gcal_d_t.gcalsite   #160824-00007#101 20161024 mark by beckxie
                     #160824-00007#101 20161024 add by beckxie---S
                     LET g_gcal_d[l_ac].gcalsite = g_gcal_d_o.gcalsite
                     LET g_gcal_d[l_ac].gcal012  = g_gcal_d_o.gcal012     
                     CALL agct401_display_gcal012()
                     #160824-00007#101 20161024 add by beckxie---E
                     CALL agct401_display_gcalsite()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agct401_display_gcalsite()
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_gcal_d[l_ac].gcalsite,'6')  RETURNING  l_success,g_gcal_d[l_ac].gcal012
            CALL agct401_display_gcal012()
            #160604-00009#50 -e by 08172
            LET g_gcal_d_o.* = g_gcal_d[l_ac].*   #160824-00007#101 20161024 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcalsite
            #add-point:BEFORE FIELD gcalsite name="input.b.page1.gcalsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcalsite
            #add-point:ON CHANGE gcalsite name="input.g.page1.gcalsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal001
            
            #add-point:AFTER FIELD gcal001 name="input.a.page1.gcal001"
                        call agct401_null_gcal001()
            IF NOT cl_null(g_gcal_d[l_ac].gcal001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal001 != g_gcal_d_t.gcal001 OR g_gcal_d_t.gcal001 IS NULL)) THEN 
                  CALL agct401_chk_gcal001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal001 = g_gcal_d_t.gcal001
                     CALL agct401_display_gcal001()
                     NEXT FIELD gcal001
                  END IF
                  IF NOT cl_null(g_gcal_d[l_ac].gcal013) THEN
                     CALL agct401_chk_gcal013()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_gcal_d[l_ac].gcal013
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_gcal_d[l_ac].gcal001 = g_gcal_d_t.gcal001
                        CALL agct401_display_gcal001()
                        NEXT FIELD gcal001
                     END IF
                  END IF
                  IF NOT cl_null(g_gcal_d[l_ac].gcal013) AND NOT cl_null(g_gcal_d[l_ac].gcal008) THEN
                     CALL agct401_chk_gcal008()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_gcal_d[l_ac].gcal008
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_gcal_d[l_ac].gcal001 = g_gcal_d_t.gcal001
                        CALL agct401_display_gcal001()
                        NEXT FIELD gcal001
                     END IF
                  END IF
                  LET g_gcal_d[l_ac].gcal007=null
                  LET g_gcal_d[l_ac].gcal009=null
                  LET g_gcal_d[l_ac].gcal010=null                  
               END IF
            END IF
            CALL agct401_display_gcal001()
            call agct401_set_entry_b(l_cmd)
            call agct401_set_no_entry_b(l_cmd)
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal001
            #add-point:BEFORE FIELD gcal001 name="input.b.page1.gcal001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal001
            #add-point:ON CHANGE gcal001 name="input.g.page1.gcal001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal013
            
            #add-point:AFTER FIELD gcal013 name="input.a.page1.gcal013"
                        
            LET g_gcal_d[l_ac].gcal013_desc = NULL
            LET g_gcal_d[l_ac].gcal014 = NULL
            DISPLAY  g_gcal_d[l_ac].gcal013_desc,g_gcal_d[l_ac].gcal014 
                 TO s_detail1[l_ac].gcal013_desc,s_detail1[l_ac].gcal014
            IF NOT cl_null(g_gcal_d[l_ac].gcal013) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal013 != g_gcal_d_t.gcal013 OR g_gcal_d_t.gcal013 is null)) THEN 
                  CALL agct401_chk_gcal013()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal013 = g_gcal_d_t.gcal013
                     CALL agct401_display_gcal013()
                     NEXT FIELD gcal013
                  END IF
                  IF NOT cl_null(g_gcal_d[l_ac].gcal008) THEN
                     CALL agct401_chk_gcal008()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_gcal_d[l_ac].gcal008
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_gcal_d[l_ac].gcal013 = g_gcal_d_t.gcal013
                        CALL agct401_display_gcal013()
                        NEXT FIELD gcal013
                     END IF
                  END IF
               END IF
            END IF
            CALL agct401_display_gcal013()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal013
            #add-point:BEFORE FIELD gcal013 name="input.b.page1.gcal013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal013
            #add-point:ON CHANGE gcal013 name="input.g.page1.gcal013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal002
            #add-point:BEFORE FIELD gcal002 name="input.b.page1.gcal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal002
            
            #add-point:AFTER FIELD gcal002 name="input.a.page1.gcal002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal002
            #add-point:ON CHANGE gcal002 name="input.g.page1.gcal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal003
            #add-point:BEFORE FIELD gcal003 name="input.b.page1.gcal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal003
            
            #add-point:AFTER FIELD gcal003 name="input.a.page1.gcal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal003
            #add-point:ON CHANGE gcal003 name="input.g.page1.gcal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal004
            #add-point:BEFORE FIELD gcal004 name="input.b.page1.gcal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal004
            
            #add-point:AFTER FIELD gcal004 name="input.a.page1.gcal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal004
            #add-point:ON CHANGE gcal004 name="input.g.page1.gcal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal005
            #add-point:BEFORE FIELD gcal005 name="input.b.page1.gcal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal005
            
            #add-point:AFTER FIELD gcal005 name="input.a.page1.gcal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal005
            #add-point:ON CHANGE gcal005 name="input.g.page1.gcal005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal006
            #add-point:BEFORE FIELD gcal006 name="input.b.page1.gcal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal006
            
            #add-point:AFTER FIELD gcal006 name="input.a.page1.gcal006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal006
            #add-point:ON CHANGE gcal006 name="input.g.page1.gcal006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcal_d[l_ac].gcal007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcal007
            END IF 
 
 
 
            #add-point:AFTER FIELD gcal007 name="input.a.page1.gcal007"
                        IF NOT cl_null(g_gcal_d[l_ac].gcal007) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal007 != g_gcal_d_t.gcal007 or g_gcal_d_t.gcal007 IS NULL)) THEN 
                  CALL agct401_display_gcal007()
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal007
            #add-point:BEFORE FIELD gcal007 name="input.b.page1.gcal007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal007
            #add-point:ON CHANGE gcal007 name="input.g.page1.gcal007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal008
            
            #add-point:AFTER FIELD gcal008 name="input.a.page1.gcal008"
                        
            LET g_gcal_d[l_ac].gcal008_desc = null
            DISPLAY  g_gcal_d[l_ac].gcal008_desc to s_detail1[l_ac].gcal008_desc
            IF NOT cl_null(g_gcal_d[l_ac].gcal008) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal008 != g_gcal_d_t.gcal008 or g_gcal_d_t.gcal008 is null)) THEN 
                  CALL agct401_chk_gcal008()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal008 = g_gcal_d_t.gcal008
                     CALL agct401_display_gcal008()
                     NEXT FIELD gcal008
                  END IF
               END IF
            END IF
            CALL agct401_display_gcal008()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal008
            #add-point:BEFORE FIELD gcal008 name="input.b.page1.gcal008"
                        call agct401_set_entry_b(l_cmd)
            call agct401_set_no_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal008
            #add-point:ON CHANGE gcal008 name="input.g.page1.gcal008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal009
            #add-point:BEFORE FIELD gcal009 name="input.b.page1.gcal009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal009
            
            #add-point:AFTER FIELD gcal009 name="input.a.page1.gcal009"
                        IF NOT cl_null(g_gcal_d[l_ac].gcal009) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal009 != g_gcal_d_t.gcal009 or g_gcal_d_t.gcal009 is null)) THEN 
                  CALL agct401_chk_gcal009(g_gcal_d[l_ac].gcal009)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal009 = g_gcal_d_t.gcal009
                     NEXT FIELD gcal009
                  END IF
                  CALL agct401_gcal009_after(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal009 = g_gcal_d_t.gcal009
                     NEXT FIELD gcal009
                  ELSE
                  
                     IF cl_null(g_gcal_d[l_ac].gcal010) THEN
                        LET g_gcal_d[l_ac].gcal010 = g_gcal_d[l_ac].gcal009
                        DISPLAY  g_gcal_d[l_ac].gcal010 to s_detail1[l_ac].gcal010
                     END IF                       
                  END IF
                  CALL agct401_create_gcal009()
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal009
            #add-point:ON CHANGE gcal009 name="input.g.page1.gcal009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal010
            #add-point:BEFORE FIELD gcal010 name="input.b.page1.gcal010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal010
            
            #add-point:AFTER FIELD gcal010 name="input.a.page1.gcal010"
                        IF NOT cl_null(g_gcal_d[l_ac].gcal010) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal010 != g_gcal_d_t.gcal010 or g_gcal_d_t.gcal010 is null)) THEN 
                  CALL agct401_chk_gcal009(g_gcal_d[l_ac].gcal010)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal010 = g_gcal_d_t.gcal010
                     NEXT FIELD gcal010
                  END IF
                  CALL agct401_gcal009_after(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal010 = g_gcal_d_t.gcal010
                     NEXT FIELD gcal010
                  END IF
                  IF cl_null(g_gcal_d[l_ac].gcal009) THEN
                     LET g_gcal_d[l_ac].gcal009 = g_gcal_d[l_ac].gcal010
                     DISPLAY  g_gcal_d[l_ac].gcal009 to s_detail1[l_ac].gcal009
                  END IF                  
                  CALL agct401_create_gcal009()
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal010
            #add-point:ON CHANGE gcal010 name="input.g.page1.gcal010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal011
            
            #add-point:AFTER FIELD gcal011 name="input.a.page1.gcal011"
                        LET g_gcal_d[l_ac].gcal011_desc = null
            DISPLAY  g_gcal_d[l_ac].gcal011_desc to s_detail1[l_ac].gcal011_desc
            IF NOT cl_null(g_gcal_d[l_ac].gcal011) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal011 != g_gcal_d_t.gcal011 or g_gcal_d_t.gcal011 is null)) THEN 
                  CALL agct401_chk_gcal011(g_gcal_d[l_ac].gcal011)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal011
                     #160318-00005#12   --add--str
                     LET g_errparam.replace[1] ='aini001'
                     LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                     LET g_errparam.exeprog    ='aini001'
                     #160318-00005#12  --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal011 = g_gcal_d_t.gcal011
                     CALL agct401_display_gcal011()
                     NEXT FIELD gcal011
                  END IF
               END IF
            END IF
            CALL agct401_display_gcal011()
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal011
            #add-point:BEFORE FIELD gcal011 name="input.b.page1.gcal011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal011
            #add-point:ON CHANGE gcal011 name="input.g.page1.gcal011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcal012
            
            #add-point:AFTER FIELD gcal012 name="input.a.page1.gcal012"
                        
            LET g_gcal_d[l_ac].gcal012_desc = null
            DISPLAY  g_gcal_d[l_ac].gcal012_desc to s_detail1[l_ac].gcal012_desc
            IF NOT cl_null(g_gcal_d[l_ac].gcal012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gcal_d[l_ac].gcal012 != g_gcal_d_t.gcal012 or g_gcal_d_t.gcal012 is null)) THEN 
                  CALL agct401_chk_gcal011(g_gcal_d[l_ac].gcal012)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcal_d[l_ac].gcal012
                     #160318-00005#12   --add--str
                     LET g_errparam.replace[1] ='aini001'
                     LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                     LET g_errparam.exeprog    ='aini001'
                     #160318-00005#12  --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcal_d[l_ac].gcal012 = g_gcal_d_t.gcal012
                     CALL agct401_display_gcal012()
                     NEXT FIELD gcal012
                  END IF
               END IF
            END IF
            CALL agct401_display_gcal012()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcal012
            #add-point:BEFORE FIELD gcal012 name="input.b.page1.gcal012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcal012
            #add-point:ON CHANGE gcal012 name="input.g.page1.gcal012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcalunit
            #add-point:BEFORE FIELD gcalunit name="input.b.page1.gcalunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcalunit
            
            #add-point:AFTER FIELD gcalunit name="input.a.page1.gcalunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcalunit
            #add-point:ON CHANGE gcalunit name="input.g.page1.gcalunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gcalseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcalseq
            #add-point:ON ACTION controlp INFIELD gcalseq name="input.c.page1.gcalseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcalsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcalsite
            #add-point:ON ACTION controlp INFIELD gcalsite name="input.c.page1.gcalsite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcal_d[l_ac].gcalsite             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_gcak_m.gcaksite #
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcalsite',g_gcak_m.gcaksite,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()

            LET g_gcal_d[l_ac].gcalsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcal_d[l_ac].gcalsite TO gcalsite              #顯示到畫面上
            CALL agct401_display_gcalsite()
            NEXT FIELD gcalsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal001
            #add-point:ON ACTION controlp INFIELD gcal001 name="input.c.page1.gcal001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcal_d[l_ac].gcal001             #給予default值

            #給予arg

            CALL q_gcaf001()                                #呼叫開窗

            LET g_gcal_d[l_ac].gcal001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcal_d[l_ac].gcal001 TO gcal001              #顯示到畫面上
            CALL agct401_display_gcal001()
            NEXT FIELD gcal001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal013
            #add-point:ON ACTION controlp INFIELD gcal013 name="input.c.page1.gcal013"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcal_d[l_ac].gcal013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2071" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_gcal_d[l_ac].gcal013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcal_d[l_ac].gcal013 TO gcal013              #顯示到畫面上
            CALL agct401_display_gcal013()
            NEXT FIELD gcal013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal002
            #add-point:ON ACTION controlp INFIELD gcal002 name="input.c.page1.gcal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal003
            #add-point:ON ACTION controlp INFIELD gcal003 name="input.c.page1.gcal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal004
            #add-point:ON ACTION controlp INFIELD gcal004 name="input.c.page1.gcal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal005
            #add-point:ON ACTION controlp INFIELD gcal005 name="input.c.page1.gcal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal006
            #add-point:ON ACTION controlp INFIELD gcal006 name="input.c.page1.gcal006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal007
            #add-point:ON ACTION controlp INFIELD gcal007 name="input.c.page1.gcal007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal008
            #add-point:ON ACTION controlp INFIELD gcal008 name="input.c.page1.gcal008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcal_d[l_ac].gcal008             #給予default值
            LET g_qryparam.default2 = "" #g_gcal_d[l_ac].rtdx001 #商品編號

            #給予arg
            LET g_qryparam.arg1 = g_gcal_d[l_ac].gcal001
            LET g_qryparam.arg2 = g_gcal_d[l_ac].gcal013
            CALL q_gcas003_1()                                #呼叫開窗

            LET g_gcal_d[l_ac].gcal008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_gcal_d[l_ac].rtdx001 = g_qryparam.return2 #商品編號

            DISPLAY g_gcal_d[l_ac].gcal008 TO gcal008              #顯示到畫面上
            #DISPLAY g_gcal_d[l_ac].rtdx001 TO rtdx001 #商品編號
            call agct401_display_gcal008()
            NEXT FIELD gcal008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal009
            #add-point:ON ACTION controlp INFIELD gcal009 name="input.c.page1.gcal009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal010
            #add-point:ON ACTION controlp INFIELD gcal010 name="input.c.page1.gcal010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal011
            #add-point:ON ACTION controlp INFIELD gcal011 name="input.c.page1.gcal011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcal_d[l_ac].gcal011             #給予default值

            #給予arg
            LET g_qryparam.where = "inaasite='",g_gcal_d[l_ac].gcalsite,"' "
            CALL q_inaa001_5()                                #呼叫開窗
            LET g_qryparam.where = null
            LET g_gcal_d[l_ac].gcal011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcal_d[l_ac].gcal011 TO gcal011              #顯示到畫面上
            call agct401_display_gcal011()
            NEXT FIELD gcal011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcal012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcal012
            #add-point:ON ACTION controlp INFIELD gcal012 name="input.c.page1.gcal012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcal_d[l_ac].gcal012             #給予default值

            #給予arg
            
            LET g_qryparam.where = "inaasite='",g_gcal_d[l_ac].gcalsite,"' "
            CALL q_inaa001_5()                                #呼叫開窗
            LET g_qryparam.where = null
            LET g_gcal_d[l_ac].gcal012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcal_d[l_ac].gcal012 TO gcal012              #顯示到畫面上
            CALL agct401_display_gcal012()
            NEXT FIELD gcal012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcalunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcalunit
            #add-point:ON ACTION controlp INFIELD gcalunit name="input.c.page1.gcalunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gcal_d[l_ac].* = g_gcal_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct401_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gcal_d[l_ac].gcalseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gcal_d[l_ac].* = g_gcal_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL agct401_gcal_t_mask_restore('restore_mask_o')
      
               UPDATE gcal_t SET (gcaldocno,gcalseq,gcalsite,gcal001,gcal013,gcal014,gcal002,gcal003, 
                   gcal004,gcal005,gcal006,gcal007,gcal008,gcal009,gcal010,gcal011,gcal012,gcalunit) = (g_gcak_m.gcakdocno, 
                   g_gcal_d[l_ac].gcalseq,g_gcal_d[l_ac].gcalsite,g_gcal_d[l_ac].gcal001,g_gcal_d[l_ac].gcal013, 
                   g_gcal_d[l_ac].gcal014,g_gcal_d[l_ac].gcal002,g_gcal_d[l_ac].gcal003,g_gcal_d[l_ac].gcal004, 
                   g_gcal_d[l_ac].gcal005,g_gcal_d[l_ac].gcal006,g_gcal_d[l_ac].gcal007,g_gcal_d[l_ac].gcal008, 
                   g_gcal_d[l_ac].gcal009,g_gcal_d[l_ac].gcal010,g_gcal_d[l_ac].gcal011,g_gcal_d[l_ac].gcal012, 
                   g_gcal_d[l_ac].gcalunit)
                WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno 
 
                  AND gcalseq = g_gcal_d_t.gcalseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gcal_d[l_ac].* = g_gcal_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcal_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gcal_d[l_ac].* = g_gcal_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcal_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcak_m.gcakdocno
               LET gs_keys_bak[1] = g_gcakdocno_t
               LET gs_keys[2] = g_gcal_d[g_detail_idx].gcalseq
               LET gs_keys_bak[2] = g_gcal_d_t.gcalseq
               CALL agct401_update_b('gcal_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL agct401_gcal_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gcal_d[g_detail_idx].gcalseq = g_gcal_d_t.gcalseq 
 
                  ) THEN
                  LET gs_keys[01] = g_gcak_m.gcakdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gcal_d_t.gcalseq
 
                  CALL agct401_key_update_b(gs_keys,'gcal_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gcak_m),util.JSON.stringify(g_gcal_d_t)
               LET g_log2 = util.JSON.stringify(g_gcak_m),util.JSON.stringify(g_gcal_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL agct401_unlock_b("gcal_t","'1'")
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
               LET g_gcal_d[li_reproduce_target].* = g_gcal_d[li_reproduce].*
 
               LET g_gcal_d[li_reproduce_target].gcalseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcal_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcal_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="agct401.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD gcaksite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gcalseq
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD gcakdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gcalseq
 
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
 
{<section id="agct401.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agct401_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL agct401_b_fill() #單身填充
      CALL agct401_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agct401_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
               INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gcak_m.gcaksite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gcak_m.gcaksite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gcak_m.gcaksite_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcak_m.gcakownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcak_m.gcakownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcak_m.gcakownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcak_m.gcakowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcak_m.gcakowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcak_m.gcakowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcak_m.gcakcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcak_m.gcakcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcak_m.gcakcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcak_m.gcakcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcak_m.gcakcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcak_m.gcakcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcak_m.gcakmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcak_m.gcakmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcak_m.gcakmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcak_m.gcakcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_gcak_m.gcakcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcak_m.gcakcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_gcak_m_mask_o.* =  g_gcak_m.*
   CALL agct401_gcak_t_mask()
   LET g_gcak_m_mask_n.* =  g_gcak_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gcak_m.gcaksite,g_gcak_m.gcaksite_desc,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001, 
       g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakowndp_desc,g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdp_desc, 
       g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakmoddt,g_gcak_m.gcakcnfid, 
       g_gcak_m.gcakcnfid_desc,g_gcak_m.gcakcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcak_m.gcakstus 
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
   FOR l_ac = 1 TO g_gcal_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
                  
            CALL agct401_display_gcalsite()
            CALL agct401_display_gcal001()
            
            
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcal_d[l_ac].gcal001
#            CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcal_d[l_ac].gcal001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcal_d[l_ac].gcal001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcal_d[l_ac].gcal008
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcal_d[l_ac].gcal008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcal_d[l_ac].gcal008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcal_d[l_ac].gcal011
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_gcal_d[l_ac].gcal011_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcal_d[l_ac].gcal011_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcal_d[l_ac].gcal012
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_gcal_d[l_ac].gcal012_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcal_d[l_ac].gcal012_desc
            
            call agct401_display_gcal013()

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL agct401_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION agct401_detail_show()
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
 
{<section id="agct401.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agct401_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gcak_t.gcakdocno 
   DEFINE l_oldno     LIKE gcak_t.gcakdocno 
 
   DEFINE l_master    RECORD LIKE gcak_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gcal_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert    LIKE type_t.num5
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
   
   IF g_gcak_m.gcakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
    
   LET g_gcak_m.gcakdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcak_m.gcakownid = g_user
      LET g_gcak_m.gcakowndp = g_dept
      LET g_gcak_m.gcakcrtid = g_user
      LET g_gcak_m.gcakcrtdp = g_dept 
      LET g_gcak_m.gcakcrtdt = cl_get_current()
      LET g_gcak_m.gcakmodid = g_user
      LET g_gcak_m.gcakmoddt = cl_get_current()
      LET g_gcak_m.gcakstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_gcak_m.gcakstus = "N"
   LET g_gcak_m.gcak001 = null
#   LET g_gcak_m.gcaksite = g_site
   LET g_ins_site_flag = FALSE  #161024-00025#7  2016/10/25  by 08742 add
   CALL s_aooi500_default(g_prog,'gcaksite',g_gcak_m.gcaksite)
      RETURNING l_insert,g_gcak_m.gcaksite
   IF NOT l_insert THEN
      RETURN
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcak_m.gcaksite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcak_m.gcaksite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcak_m.gcaksite_desc
   LET g_gcak_m.gcakunit = g_gcak_m.gcaksite
   LET g_gcak_m.gcakdocdt = g_today
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcak_m.gcakstus 
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
   
   
   CALL agct401_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gcak_m.* TO NULL
      INITIALIZE g_gcal_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL agct401_show()
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
   CALL agct401_set_act_visible()   
   CALL agct401_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " gcakent = " ||g_enterprise|| " AND",
                      " gcakdocno = '", g_gcak_m.gcakdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agct401_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL agct401_idx_chk()
   
   LET g_data_owner = g_gcak_m.gcakownid      
   LET g_data_dept  = g_gcak_m.gcakowndp
   
   #功能已完成,通報訊息中心
   CALL agct401_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agct401_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gcal_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agct401_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gcal_t
    WHERE gcalent = g_enterprise AND gcaldocno = g_gcakdocno_t
 
    INTO TEMP agct401_detail
 
   #將key修正為調整後   
   UPDATE agct401_detail 
      #更新key欄位
      SET gcaldocno = g_gcak_m.gcakdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gcal_t SELECT * FROM agct401_detail
   
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
   DROP TABLE agct401_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agct401_delete()
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
   
   IF g_gcak_m.gcakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN agct401_cl USING g_enterprise,g_gcak_m.gcakdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct401_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agct401_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agct401_master_referesh USING g_gcak_m.gcakdocno INTO g_gcak_m.gcaksite,g_gcak_m.gcakdocdt, 
       g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt, 
       g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt,g_gcak_m.gcaksite_desc,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp_desc, 
       g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT agct401_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gcak_m_mask_o.* =  g_gcak_m.*
   CALL agct401_gcak_t_mask()
   LET g_gcak_m_mask_n.* =  g_gcak_m.*
   
   CALL agct401_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agct401_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gcakdocno_t = g_gcak_m.gcakdocno
 
 
      DELETE FROM gcak_t
       WHERE gcakent = g_enterprise AND gcakdocno = g_gcak_m.gcakdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gcak_m.gcakdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM gcal_t
       WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcal_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gcak_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE agct401_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gcal_d.clear() 
 
     
      CALL agct401_ui_browser_refresh()  
      #CALL agct401_ui_headershow()  
      #CALL agct401_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL agct401_browser_fill("")
         CALL agct401_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE agct401_cl
 
   #功能已完成,通報訊息中心
   CALL agct401_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agct401.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agct401_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_gcal_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF agct401_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gcalseq,gcalsite,gcal001,gcal013,gcal014,gcal002,gcal003,gcal004, 
             gcal005,gcal006,gcal007,gcal008,gcal009,gcal010,gcal011,gcal012,gcalunit ,t1.ooefl003 , 
             t2.gcaf003 ,t3.oocql004 ,t4.imaal003 ,t5.inayl003 ,t6.inayl003 FROM gcal_t",   
                     " INNER JOIN gcak_t ON gcakent = " ||g_enterprise|| " AND gcakdocno = gcaldocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=gcalsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN gcaf_t t2 ON t2.gcafent="||g_enterprise||" AND t2.gcaf001=gcal001  ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2071' AND t3.oocql002=gcal013 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=gcal008 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=gcal011 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent="||g_enterprise||" AND t6.inayl001=gcal012 AND t6.inayl002='"||g_dlang||"' ",
 
                     " WHERE gcalent=? AND gcaldocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gcal_t.gcalseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agct401_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agct401_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gcak_m.gcakdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gcak_m.gcakdocno INTO g_gcal_d[l_ac].gcalseq,g_gcal_d[l_ac].gcalsite, 
          g_gcal_d[l_ac].gcal001,g_gcal_d[l_ac].gcal013,g_gcal_d[l_ac].gcal014,g_gcal_d[l_ac].gcal002, 
          g_gcal_d[l_ac].gcal003,g_gcal_d[l_ac].gcal004,g_gcal_d[l_ac].gcal005,g_gcal_d[l_ac].gcal006, 
          g_gcal_d[l_ac].gcal007,g_gcal_d[l_ac].gcal008,g_gcal_d[l_ac].gcal009,g_gcal_d[l_ac].gcal010, 
          g_gcal_d[l_ac].gcal011,g_gcal_d[l_ac].gcal012,g_gcal_d[l_ac].gcalunit,g_gcal_d[l_ac].gcalsite_desc, 
          g_gcal_d[l_ac].gcal001_desc,g_gcal_d[l_ac].gcal013_desc,g_gcal_d[l_ac].gcal008_desc,g_gcal_d[l_ac].gcal011_desc, 
          g_gcal_d[l_ac].gcal012_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL agct401_display_gcal011()
         CALL agct401_display_gcal012()
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
   
   CALL g_gcal_d.deleteElement(g_gcal_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE agct401_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gcal_d.getLength()
      LET g_gcal_d_mask_o[l_ac].* =  g_gcal_d[l_ac].*
      CALL agct401_gcal_t_mask()
      LET g_gcal_d_mask_n[l_ac].* =  g_gcal_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agct401_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gcal_t
       WHERE gcalent = g_enterprise AND
         gcaldocno = ps_keys_bak[1] AND gcalseq = ps_keys_bak[2]
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
         CALL g_gcal_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agct401_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO gcal_t
                  (gcalent,
                   gcaldocno,
                   gcalseq
                   ,gcalsite,gcal001,gcal013,gcal014,gcal002,gcal003,gcal004,gcal005,gcal006,gcal007,gcal008,gcal009,gcal010,gcal011,gcal012,gcalunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_gcal_d[g_detail_idx].gcalsite,g_gcal_d[g_detail_idx].gcal001,g_gcal_d[g_detail_idx].gcal013, 
                       g_gcal_d[g_detail_idx].gcal014,g_gcal_d[g_detail_idx].gcal002,g_gcal_d[g_detail_idx].gcal003, 
                       g_gcal_d[g_detail_idx].gcal004,g_gcal_d[g_detail_idx].gcal005,g_gcal_d[g_detail_idx].gcal006, 
                       g_gcal_d[g_detail_idx].gcal007,g_gcal_d[g_detail_idx].gcal008,g_gcal_d[g_detail_idx].gcal009, 
                       g_gcal_d[g_detail_idx].gcal010,g_gcal_d[g_detail_idx].gcal011,g_gcal_d[g_detail_idx].gcal012, 
                       g_gcal_d[g_detail_idx].gcalunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcal_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gcal_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agct401_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gcal_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL agct401_gcal_t_mask_restore('restore_mask_o')
               
      UPDATE gcal_t 
         SET (gcaldocno,
              gcalseq
              ,gcalsite,gcal001,gcal013,gcal014,gcal002,gcal003,gcal004,gcal005,gcal006,gcal007,gcal008,gcal009,gcal010,gcal011,gcal012,gcalunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gcal_d[g_detail_idx].gcalsite,g_gcal_d[g_detail_idx].gcal001,g_gcal_d[g_detail_idx].gcal013, 
                  g_gcal_d[g_detail_idx].gcal014,g_gcal_d[g_detail_idx].gcal002,g_gcal_d[g_detail_idx].gcal003, 
                  g_gcal_d[g_detail_idx].gcal004,g_gcal_d[g_detail_idx].gcal005,g_gcal_d[g_detail_idx].gcal006, 
                  g_gcal_d[g_detail_idx].gcal007,g_gcal_d[g_detail_idx].gcal008,g_gcal_d[g_detail_idx].gcal009, 
                  g_gcal_d[g_detail_idx].gcal010,g_gcal_d[g_detail_idx].gcal011,g_gcal_d[g_detail_idx].gcal012, 
                  g_gcal_d[g_detail_idx].gcalunit) 
         WHERE gcalent = g_enterprise AND gcaldocno = ps_keys_bak[1] AND gcalseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcal_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcal_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agct401_gcal_t_mask_restore('restore_mask_n')
               
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
 
{<section id="agct401.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION agct401_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="agct401.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agct401_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="agct401.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agct401_lock_b(ps_table,ps_page)
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
   #CALL agct401_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gcal_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN agct401_bcl USING g_enterprise,
                                       g_gcak_m.gcakdocno,g_gcal_d[g_detail_idx].gcalseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agct401_bcl:",SQLERRMESSAGE 
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
 
{<section id="agct401.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agct401_unlock_b(ps_table,ps_page)
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
      CLOSE agct401_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agct401_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("gcakdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gcakdocno",TRUE)
      CALL cl_set_comp_entry("gcakdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
            CALL cl_set_comp_entry("gcaksite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agct401_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gcakdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
            CALL cl_set_comp_entry("gcaksite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("gcakdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("gcakdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #161024-00025#7  2016/10/25 by 08742 -S
#   IF NOT s_aooi500_comp_entry(g_prog,'gcaksite') THEN
#      CALL cl_set_comp_entry("gcaksite",FALSE)
#   END IF
   CALL cl_set_comp_entry("gcaksite",TRUE)
   IF NOT s_aooi500_comp_entry(g_prog,'gcaksite') OR g_ins_site_flag THEN
      CALL cl_set_comp_entry("gcaksite",FALSE)
   END IF
   #161024-00025#7  2016/10/25 by 08742 -E
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agct401_set_entry_b(p_cmd)
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
      call cl_set_comp_entry("gcal008",true)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agct401_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
      DEFINE l_gcaf003 like gcaf_t.gcaf003
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
      SELECT gcaf003 INTO l_gcaf003 FROM gcaf_t WHERE gcaf001 = g_gcal_d[l_ac].gcal001
      AND gcafent = g_enterprise
   IF l_gcaf003<>'3' THEN
      CALL cl_set_comp_entry("gcal008",FALSE)
   END IF   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agct401_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agct401_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_gcak_m.gcakstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agct401_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct401.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agct401_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct401.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agct401_default_search()
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
      LET ls_wc = ls_wc, " gcakdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "gcak_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gcal_t" 
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
 
{<section id="agct401.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION agct401_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
      DEFINE l_success  LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_gcak_m.gcakstus = 'X' THEN
      RETURN
   END IF
   IF g_gcak_m.gcakstus = 'C' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gcak_m.gcakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN agct401_cl USING g_enterprise,g_gcak_m.gcakdocno
   IF STATUS THEN
      CLOSE agct401_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct401_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE agct401_master_referesh USING g_gcak_m.gcakdocno INTO g_gcak_m.gcaksite,g_gcak_m.gcakdocdt, 
       g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt, 
       g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt,g_gcak_m.gcaksite_desc,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp_desc, 
       g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT agct401_action_chk() THEN
      CLOSE agct401_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gcak_m.gcaksite,g_gcak_m.gcaksite_desc,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno,g_gcak_m.gcak001, 
       g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakownid_desc,g_gcak_m.gcakowndp, 
       g_gcak_m.gcakowndp_desc,g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdp_desc, 
       g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakmoddt,g_gcak_m.gcakcnfid, 
       g_gcak_m.gcakcnfid_desc,g_gcak_m.gcakcnfdt
 
   CASE g_gcak_m.gcakstus
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
         CASE g_gcak_m.gcakstus
            
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
#      CALL cl_set_act_visible("invalid,unconfirmed,confirmed", true)
#      IF g_gcak_m.gcakstus <> 'N' THEN
#         CALL cl_set_act_visible("invalid", FALSE)
#      ELSE
#         CALL cl_set_act_visible("invalid", TRUE)
#         CALL cl_set_act_visible("unconfirmed", FALSE)      
#      END IF
#      IF g_gcak_m.gcakstus = 'Y' THEN
#         CALL cl_set_act_visible("unconfirmed", TRUE)
#         CALL cl_set_act_visible("confirmed", FALSE)      
#      END IF
#      IF g_gcak_m.gcakstus = 'X' THEN
#         CALL cl_set_act_visible("invalid,unconfirmed,confirmed", false)      
#      END IF
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_gcak_m.gcakstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

      END CASE
#      IF g_gcak_m.gcakstus = 'X' THEN
#         CALL cl_set_act_visible("invalid,unconfirmed,confirmed", false)      
#      END IF
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT agct401_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE agct401_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT agct401_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE agct401_cl
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
      g_gcak_m.gcakstus = lc_state OR cl_null(lc_state) THEN
      CLOSE agct401_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
      LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y' 
         SELECT gcakstus INTO  g_gcak_m.gcakstus FROM gcak_t WHERE gcakdocno = g_gcak_m.gcakdocno
            AND gcakent = g_enterprise        
         CALL s_agct401_conf_chk(g_gcak_m.gcakdocno,g_gcak_m.gcakstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_agct401_conf_upd(g_gcak_m.gcakdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcak_m.gcakdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
            RETURN            
         END IF         
      WHEN 'X'
         SELECT gcakstus INTO  g_gcak_m.gcakstus FROM gcak_t WHERE gcakdocno = g_gcak_m.gcakdocno
            AND gcakent = g_enterprise
         CALL s_agct401_void_chk(g_gcak_m.gcakdocno,g_gcak_m.gcakstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_agct401_void_upd(g_gcak_m.gcakdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcak_m.gcakdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
            RETURN    
         END IF
      WHEN 'N'
         CALL s_agct401_unconf_chk(g_gcak_m.gcakdocno,g_gcak_m.gcakstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-015') THEN
               CALL s_transaction_begin()
               CALL s_agct401_unconf_upd(g_gcak_m.gcakdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcak_m.gcakdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
            RETURN    
         END IF
   END CASE
   #end add-point
   
   LET g_gcak_m.gcakmodid = g_user
   LET g_gcak_m.gcakmoddt = cl_get_current()
   LET g_gcak_m.gcakstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gcak_t 
      SET (gcakstus,gcakmodid,gcakmoddt) 
        = (g_gcak_m.gcakstus,g_gcak_m.gcakmodid,g_gcak_m.gcakmoddt)     
    WHERE gcakent = g_enterprise AND gcakdocno = g_gcak_m.gcakdocno
 
    
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
      EXECUTE agct401_master_referesh USING g_gcak_m.gcakdocno INTO g_gcak_m.gcaksite,g_gcak_m.gcakdocdt, 
          g_gcak_m.gcakdocno,g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid, 
          g_gcak_m.gcakowndp,g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtdp,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid, 
          g_gcak_m.gcakmoddt,g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt,g_gcak_m.gcaksite_desc,g_gcak_m.gcakownid_desc, 
          g_gcak_m.gcakowndp_desc,g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakmodid_desc, 
          g_gcak_m.gcakcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gcak_m.gcaksite,g_gcak_m.gcaksite_desc,g_gcak_m.gcakdocdt,g_gcak_m.gcakdocno, 
          g_gcak_m.gcak001,g_gcak_m.gcakunit,g_gcak_m.gcakstus,g_gcak_m.gcakownid,g_gcak_m.gcakownid_desc, 
          g_gcak_m.gcakowndp,g_gcak_m.gcakowndp_desc,g_gcak_m.gcakcrtid,g_gcak_m.gcakcrtid_desc,g_gcak_m.gcakcrtdp, 
          g_gcak_m.gcakcrtdp_desc,g_gcak_m.gcakcrtdt,g_gcak_m.gcakmodid,g_gcak_m.gcakmodid_desc,g_gcak_m.gcakmoddt, 
          g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfid_desc,g_gcak_m.gcakcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
      SELECT gcakstus,gcakcnfid,gcakcnfdt INTO g_gcak_m.gcakstus,g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt
     FROM gcak_t
    WHERE gcakent = g_enterprise AND gcakdocno = g_gcak_m.gcakdocno
   DISPLAY BY NAME g_gcak_m.gcakstus,g_gcak_m.gcakcnfid,g_gcak_m.gcakcnfdt    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcak_m.gcakcnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_gcak_m.gcakcnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcak_m.gcakcnfid_desc
   
#   IF g_gcak_m.gcakstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕
#      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
#   ELSE
#      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
#   END IF
#   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
#       CALL cl_set_act_visible("bpm_status",FALSE)
#   END IF
   IF g_gcak_m.gcakstus NOT MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE agct401_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agct401_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct401.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agct401_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gcal_d.getLength() THEN
         LET g_detail_idx = g_gcal_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gcal_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gcal_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agct401_b_fill2(pi_idx)
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
   
   CALL agct401_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agct401_fill_chk(ps_idx)
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
 
{<section id="agct401.status_show" >}
PRIVATE FUNCTION agct401_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agct401.mask_functions" >}
&include "erp/agc/agct401_mask.4gl"
 
{</section>}
 
{<section id="agct401.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION agct401_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE  l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL agct401_show()
   CALL agct401_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_agct401_conf_chk(g_gcak_m.gcakdocno,g_gcak_m.gcakstus) RETURNING l_success,g_errno
   IF l_success THEN
            
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_gcak_m.gcakdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE agct401_cl
      CALL s_transaction_end('N','0')
      RETURN  FALSE          
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_gcak_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_gcal_d))
 
 
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
   #CALL agct401_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL agct401_ui_headershow()
   CALL agct401_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION agct401_draw_out()
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
   CALL agct401_ui_headershow()  
   CALL agct401_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="agct401.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agct401_set_pk_array()
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
   LET g_pk_array[1].values = g_gcak_m.gcakdocno
   LET g_pk_array[1].column = 'gcakdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct401.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="agct401.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agct401_msgcentre_notify(lc_state)
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
   CALL agct401_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gcak_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct401.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION agct401_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#14 -s by 08172
   SELECT gcakstus  INTO g_gcak_m.gcakstus
     FROM gcak_t
    WHERE gcakent = g_enterprise
      AND gcakdocno = g_gcak_m.gcakdocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_gcak_m.gcakstus
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
        LET g_errparam.extend = g_gcak_m.gcakdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL agct401_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#14 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agct401.other_function" readonly="Y" >}
#chk gcaksite
PRIVATE FUNCTION agct401_chk_gcaksite(p_gcaksite)
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_cnt1    LIKE type_t.num5 
   DEFINE p_gcaksite LIKE gcak_t.gcaksite
   DEFINE l_sql     STRING
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   LET l_sql="SELECT COUNT(*)  FROM ooed_t WHERE ooed004 ='",p_gcaksite,"' AND ooed001='8'",
             "   AND ooedent = ",g_enterprise,     #160905-00007#3 add
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",TODAY,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",TODAY,"' or ooed007 is null) AND ooed004 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_site,"' CONNECT BY NOCYCLE PRIOR ooed004=ooed005 ",
             " AND ooed001='8' AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",TODAY,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",TODAY,"' or ooed007 is null))",
             "          UNION ",
#             "         (SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"'))"                                 #160905-00007#3 marked
             "         (SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"' AND ooedent = ",g_enterprise,"))"   #160905-00007#3 add
   PREPARE l_sql_ooef_pre1 FROM l_sql
   EXECUTE l_sql_ooef_pre1 INTO l_cnt   
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00163"
   ELSE
      LET l_sql="SELECT COUNT(*)  FROM ooed_t,ooef_t WHERE ooef001=ooed004 AND ooed004 ='",p_gcaksite,"' AND ooed001='8' AND ooefstus='Y' ",
             "   AND ooedent = ",g_enterprise," AND ooefent = ooedent ",     #160905-00007#3 add
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
             "   AND ooef001 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_site,"' CONNECT BY NOCYCLE PRIOR ooed004=ooed005 AND ooed001='8' ",
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null))",
             "          UNION ",
#             "         (SELECT ooef001 FROM ooef_t WHERE ooef001='",g_site,"'))"    #160905-00007#3 marked
             "         (SELECT ooef001 FROM ooef_t WHERE ooef001='",g_site,"' AND ooefent = ",g_enterprise,"))"    #160905-00007#3 add
      PREPARE l_sql_ooef_pre2 FROM l_sql
      EXECUTE l_sql_ooef_pre2 INTO l_cnt1       
      IF l_cnt1 <= 0 THEN
         LET g_errno ='sub-01302' #"amm-00007" #160318-00005#12 mod 
      END IF         
   END IF   
END FUNCTION
#display gcaksite
PRIVATE FUNCTION agct401_display_gcaksite()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcak_m.gcaksite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcak_m.gcaksite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcak_m.gcaksite_desc
END FUNCTION
#chk gcakdocno
PRIVATE FUNCTION agct401_chk_gcakdocno(p_gcakdocno)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 
   define   p_gcakdocno like gcak_t.gcakdocno
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent=g_enterprise
   LET g_errno = null
#   SELECT COUNT(*) INTO l_cnt  FROM oobl_t WHERE oobl001 = g_ooef004 AND oobl002=p_gcakdocno #160905-00007#3 marked
   SELECT COUNT(*) INTO l_cnt  FROM oobl_t WHERE oobl001 = g_ooef004 AND oobl002=p_gcakdocno AND ooblent = g_enterprise #160905-00007#3 mod
      AND oobl003 = 'agct401'
   IF l_cnt <= 0 THEN
      LET g_errno = "aim-00056"
   ELSE
      SELECT COUNT(*) INTO l_cnt  FROM ooba_t,oobl_t
       WHERE ooba001=oobl001 AND ooba002 = oobl002 AND ooba001 = g_ooef004 AND ooba002=p_gcakdocno
         AND oobaent = g_enterprise AND ooblent = oobaent         #160905-00007#3 add
         AND oobl003 = 'agct401' AND oobastus='Y'
      IF l_cnt <= 0 THEN
         LET g_errno = "aoo-00102"
      END IF         
   END IF 
END FUNCTION
#create gcalseq
PRIVATE FUNCTION agct401_create_gcalseq()
   IF (cl_null(g_gcal_d[l_ac].gcalseq) OR g_gcal_d[l_ac].gcalseq=0) THEN
      SELECT MAX(gcalseq)+1 INTO g_gcal_d[l_ac].gcalseq FROM gcal_t
       WHERE gcaldocno = g_gcak_m.gcakdocno AND gcalent = g_enterprise
   END IF
   IF (cl_null(g_gcal_d[l_ac].gcalseq) OR g_gcal_d[l_ac].gcalseq=0) THEN
      LET g_gcal_d[l_ac].gcalseq = 1
   END IF
END FUNCTION
#display gcalsite
PRIVATE FUNCTION agct401_display_gcalsite()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcal_d[l_ac].gcalsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcal_d[l_ac].gcalsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_gcal_d[l_ac].gcalsite_desc TO s_detail1[l_ac].gcalsite_desc
END FUNCTION
#display gcal001
PRIVATE FUNCTION agct401_chk_gcal001()
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   DEFINE l_gcaf015  LIKE gcaf_t.gcaf015
   
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM gcaf_t WHERE gcaf001 = g_gcal_d[l_ac].gcal001
      AND gcafent = g_enterprise
   IF l_cnt<=0 THEN
      LET g_errno = "agc-00001"
      RETURN 
   ELSE
      SELECT count(*) INTO l_cnt1 FROM gcaf_t WHERE gcaf001 = g_gcal_d[l_ac].gcal001
         AND gcafent = g_enterprise AND gcafstus = 'Y'
      IF l_cnt1<=0 THEN
         LET g_errno = "agc-00042"
         RETURN
      END IF      
   END IF   
   
   ##########################150519-00023#1
   #勾选不产生券明细，不做发行
   SELECT gcaf015 INTO l_gcaf015 FROM gcaf_t WHERE gcafent = g_enterprise AND gcaf001 = g_gcal_d[l_ac].gcal001
   IF l_gcaf015 = 'N' THEN
      LET g_errno = "agc-00107"
      RETURN   
   END IF
   ##########################150519-00023#1
END FUNCTION
#display gcal001
PRIVATE FUNCTION agct401_display_gcal001()
   DEFINE l_cnt  LIKE type_t.num5
   
   LET l_cnt = 0
   SELECT gcafl003 INTO g_gcal_d[l_ac].gcal001_desc FROM gcafl_t
    WHERE gcaflent = g_enterprise AND gcafl001 = g_gcal_d[l_ac].gcal001
      AND gcafl002 = g_dlang 
   SELECT gcaf006,gcaf007,gcaf008,gcaf009,gcaf015
     INTO g_gcal_d[l_ac].gcal002,g_gcal_d[l_ac].gcal003
          ,g_gcal_d[l_ac].gcal004,g_gcal_d[l_ac].gcal005,g_gcal_d[l_ac].gcal006
     FROM gcaf_t
    WHERE gcaf001 = g_gcal_d[l_ac].gcal001 AND gcafent = g_enterprise
   DISPLAY g_gcal_d[l_ac].gcal001_desc,g_gcal_d[l_ac].gcal002,g_gcal_d[l_ac].gcal003
          ,g_gcal_d[l_ac].gcal004,g_gcal_d[l_ac].gcal005,g_gcal_d[l_ac].gcal006
        TO s_detail1[l_ac].gcal001_desc,s_detail1[l_ac].gcal002,s_detail1[l_ac].gcal003,
           s_detail1[l_ac].gcal004,s_detail1[l_ac].gcal005,g_detail1[l_ac].gcal006
   SELECT count(*) INTO l_cnt FROM gcar_t WHERE gcar001 = g_gcal_d[l_ac].gcal001
      AND gcarent = g_enterprise
   IF l_cnt = 1 THEN
      IF cl_null(g_gcal_d[l_ac].gcal013) THEN
         SELECT gcar002 INTO g_gcal_d[l_ac].gcal013 FROM gcar_t
          WHERE gcarent = g_enterprise AND gcar001 = g_gcal_d[l_ac].gcal001
         DISPLAY g_gcal_d[l_ac].gcal013 TO s_detail1[l_ac].gcal013
         call agct401_display_gcal013()
      END IF         
   END IF
   
END FUNCTION
#null gcal001
PRIVATE FUNCTION agct401_null_gcal001()
   LET g_gcal_d[l_ac].gcal001_desc=NULL
   LET g_gcal_d[l_ac].gcal002 = NULL 
   LET g_gcal_d[l_ac].gcal003 = NULL
   LET g_gcal_d[l_ac].gcal004 = NULL 
   LET g_gcal_d[l_ac].gcal005 = NULL
   LET g_gcal_d[l_ac].gcal006 = NULL
   DISPLAY g_gcal_d[l_ac].gcal001_desc,g_gcal_d[l_ac].gcal002,g_gcal_d[l_ac].gcal003
          ,g_gcal_d[l_ac].gcal004,g_gcal_d[l_ac].gcal005,g_gcal_d[l_ac].gcal006
        TO s_detail1[l_ac].gcal001_desc,s_detail1[l_ac].gcal002,s_detail1[l_ac].gcal003,
           s_detail1[l_ac].gcal004,s_detail1[l_ac].gcal005,g_detail1[l_ac].gcal006
END FUNCTION
#display gcal009,gcal010
PRIVATE FUNCTION agct401_display_gcal007()
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_order  like type_t.chr20
   DEFINE l_gcal009 LIKE gcal_t.gcal009
   DEFINE l_order1 string
   LET l_cnt = 0
   IF NOT cl_null(g_gcal_d[l_ac].gcal001) THEN
      SELECT COUNT(*) INTO l_cnt 
        FROM gcao_t 
       WHERE gcao002 = g_gcal_d[l_ac].gcal001 AND gcaoent = g_enterprise
      IF l_cnt > 0 THEN 
         
         SELECT MAX(gcao001)  INTO g_gcal_d[l_ac].gcal009 
           FROM gcao_t 
          WHERE gcao002 = g_gcal_d[l_ac].gcal001 AND gcaoent = g_enterprise
                   
         SELECT to_char(to_number(substr(g_gcal_d[l_ac].gcal009,LENGTH(g_gcal_d[l_ac].gcal004)+1,g_gcal_d[l_ac].gcal005))+1)
           INTO l_order
           FROM dual
         let l_order1 = l_order 
         LET  g_gcal_d[l_ac].gcal009 =  g_gcal_d[l_ac].gcal009[1,g_gcal_d[l_ac].gcal002-l_order1.getlength()],l_order  
      ELSE
         LET l_cnt = 1
         LET g_gcal_d[l_ac].gcal009 = g_gcal_d[l_ac].gcal004
         WHILE TRUE
            IF l_cnt>g_gcal_d[l_ac].gcal005 THEN
               EXIT WHILE
            END IF  
            IF l_cnt<g_gcal_d[l_ac].gcal005 THEN
               #160615-00028#4 160623 by sakura add(S)
               IF cl_null(g_gcal_d[l_ac].gcal009) THEN
                  LET g_gcal_d[l_ac].gcal009 = "0"   
               ELSE
               #160615-00028#4 160623 by sakura add(E)
               LET g_gcal_d[l_ac].gcal009 = g_gcal_d[l_ac].gcal009,"0"
               END IF   #160615-00028#4 160623 by sakura add
            END IF
            IF l_cnt=g_gcal_d[l_ac].gcal005 THEN
               LET g_gcal_d[l_ac].gcal009 = g_gcal_d[l_ac].gcal009,"1"
            END IF
            LET l_cnt = l_cnt+1
         END WHILE
      END IF
      IF NOT cl_null( g_gcal_d_t.gcalseq) THEN
         SELECT MAX(gcal010)  INTO l_gcal009 
           FROM gcal_t 
          WHERE gcal001 = g_gcal_d[l_ac].gcal001 AND gcalent = g_enterprise
            AND gcaldocno = g_gcak_m.gcakdocno AND gcalseq != g_gcal_d_t.gcalseq
      ELSE
         SELECT MAX(gcal010)  INTO l_gcal009 
           FROM gcal_t 
          WHERE gcal001 = g_gcal_d[l_ac].gcal001 AND gcalent = g_enterprise
            AND gcaldocno = g_gcak_m.gcakdocno
      END IF
      SELECT to_char(to_number(substr(l_gcal009,LENGTH(g_gcal_d[l_ac].gcal004)+1,g_gcal_d[l_ac].gcal005))+1)
        INTO l_order
        FROM dual
      LET l_order1 = l_order 
      LET  l_gcal009 =  l_gcal009[1,g_gcal_d[l_ac].gcal002-l_order1.getlength()],l_order  
         
      IF NOT cl_null(l_gcal009) THEN
         IF l_gcal009>g_gcal_d[l_ac].gcal009 THEN
            LET g_gcal_d[l_ac].gcal009=l_gcal009
         END IF
      END IF
      SELECT to_char(to_number(substr(g_gcal_d[l_ac].gcal009,LENGTH(g_gcal_d[l_ac].gcal004)+1,g_gcal_d[l_ac].gcal005))+g_gcal_d[l_ac].gcal007-1)
        INTO l_order
        FROM dual
      IF g_gcal_d[l_ac].gcal006='Y' THEN
         let l_order1 = l_order 
         LET  g_gcal_d[l_ac].gcal010 =  g_gcal_d[l_ac].gcal009[1,g_gcal_d[l_ac].gcal002-l_order1.getlength()],l_order
      END IF
      IF g_gcal_d[l_ac].gcal006='N' THEN
         LET  g_gcal_d[l_ac].gcal010 =  g_gcal_d[l_ac].gcal009        
      END IF
      DISPLAY BY NAME g_gcal_d[l_ac].gcal009,g_gcal_d[l_ac].gcal010
   END IF    
END FUNCTION
##chk gcal011
PRIVATE FUNCTION agct401_chk_gcal011(p_gcal011)
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   DEFINE p_gcal011 LIKE gcal_t.gcal011
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM inaa_t WHERE inaa001 = p_gcal011
      AND inaaent = g_enterprise AND inaasite = g_gcal_d[l_ac].gcalsite
   IF l_cnt<=0 THEN
      #LET g_errno = "aim-00064"   #160329-00015#1  mark by yangxf 20160330 
      LET g_errno = 'agc-00128'    #160329-00015#1  add by yangxf 20160330
   ELSE
      SELECT count(*) INTO l_cnt1 FROM inaa_t WHERE inaa001 = p_gcal011
         AND inaaent = g_enterprise AND inaasite = g_gcal_d[l_ac].gcalsite
         AND inaastus = 'Y'
      IF l_cnt1<=0 THEN
         LET g_errno = 'sub-01302'  #"amm-00018" #160318-00005#12 mod  
      END IF   
   END IF   
END FUNCTION
##display gcal011
PRIVATE FUNCTION agct401_display_gcal011()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_gcal_d[l_ac].gcal011
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_gcal_d[l_ac].gcal011_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_gcal_d[l_ac].gcal011_desc
   CALL s_desc_get_stock_desc(g_gcal_d[l_ac].gcalsite,g_gcal_d[l_ac].gcal011) RETURNING g_gcal_d[l_ac].gcal011_desc
   DISPLAY BY NAME g_gcal_d[l_ac].gcal011_desc
END FUNCTION
##display gcal012
PRIVATE FUNCTION agct401_display_gcal012()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_gcal_d[l_ac].gcal012
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_gcal_d[l_ac].gcal012_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_gcal_d[l_ac].gcal012_desc
   CALL s_desc_get_stock_desc(g_gcal_d[l_ac].gcalsite,g_gcal_d[l_ac].gcal012) RETURNING g_gcal_d[l_ac].gcal012_desc
   DISPLAY BY NAME g_gcal_d[l_ac].gcal012_desc
END FUNCTION
#chk gcal009,gcal010
PRIVATE FUNCTION agct401_chk_gcal009(p_gcal009)
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   DEFINE p_gcal009 LIKE gcal_t.gcal009
   DEFINE l_gcal009 STRING
   DEFINE l_n    LIKE type_t.num5
   
   let l_gcal009 = p_gcal009
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcao001 = p_gcal009
      AND gcaoent = g_enterprise
   IF l_cnt>0 THEN
      LET g_errno = "agc-00002"
   END IF
   IF cl_null(g_errno) THEN
      IF p_gcal009[1,g_gcal_d[l_ac].gcal003]<>g_gcal_d[l_ac].gcal004 THEN
         LET g_errno = "amm-00141"
      ELSE
         IF l_gcal009.getLength()<>g_gcal_d[l_ac].gcal002 THEN
            LET g_errno = "amm-00140"
         END IF
      END IF
      IF cl_null(g_errno) THEN
         FOR l_n=g_gcal_d[l_ac].gcal003 TO g_gcal_d[l_ac].gcal002-1
            IF p_gcal009[l_n+1,l_n+1] NOT MATCHES '[0123456789]' THEN
               LET g_errno = "amm-00142"
               RETURN
             END IF         
         END FOR
      END IF   
   END IF
   #add by yangxf ---start----20151228
   IF cl_null(g_errno) AND NOT cl_null(g_gcal_d[l_ac].gcal001) THEN 
      LET l_n = 0
      #检查券号是否存在券种范围内
      SELECT COUNT(*) INTO l_n
        FROM gcaf_t
       WHERE gcafent = g_enterprise
         AND gcaf001 = g_gcal_d[l_ac].gcal001
         AND p_gcal009 BETWEEN gcaf010 AND gcaf011
      IF l_n = 0 THEN 
         LET g_errno = "agc-00123"
         RETURN
      END IF 
   END IF 
   #add by yangxf ----end-----20151228
   IF cl_null(g_errno) THEN
      IF NOT cl_null(g_gcal_d[l_ac].gcal009) AND NOT cl_null(g_gcal_d[l_ac].gcal010) THEN
#         SELECT count(*) INTO l_cnt1 FROM gcao_t WHERE gcao001 >= g_gcal_d[l_ac].gcal009
#            AND gcao001 <= g_gcal_d[l_ac].gcal010
#            AND gcaoent = g_enterprise
#         IF l_cnt1>0 THEN
#            LET g_errno = "agc-00002"
#         END IF
         call agct401_chk_gcao001()
         IF cl_null(g_errno) THEN
            IF g_gcal_d[l_ac].gcal009>g_gcal_d[l_ac].gcal010 THEN
               LET g_errno = "agc-00039"
            END IF
         END IF         
      END IF
   END IF   
END FUNCTION
#create gcal007
PRIVATE FUNCTION agct401_create_gcal009()
   DEFINE l_cnt  LIKE gcal_t.gcal007
   LET l_cnt = 0
   IF NOT cl_null(g_gcal_d[l_ac].gcal009) AND NOT cl_null(g_gcal_d[l_ac].gcal010) THEN
      IF g_gcal_d[l_ac].gcal006 ='Y' THEN
         #160615-00028#4 160623 by sakura add(S)
         IF cl_null(g_gcal_d[l_ac].gcal004) THEN
            SELECT to_number(substr(g_gcal_d[l_ac].gcal010,1,g_gcal_d[l_ac].gcal005))-to_number(substr(g_gcal_d[l_ac].gcal009,1,g_gcal_d[l_ac].gcal005))+1
              INTO l_cnt
              FROM dual            
         ELSE
         #160615-00028#4 160623 by sakura add(E)
            SELECT to_number(substr(g_gcal_d[l_ac].gcal010,LENGTH(g_gcal_d[l_ac].gcal004)+1,g_gcal_d[l_ac].gcal005))-to_number(substr(g_gcal_d[l_ac].gcal009,LENGTH(g_gcal_d[l_ac].gcal004)+1,g_gcal_d[l_ac].gcal005))+1
              INTO l_cnt
              FROM dual
         END IF   #160615-00028#4 160623 by sakura add
         LET g_gcal_d[l_ac].gcal007 = l_cnt
         DISPLAY g_gcal_d[l_ac].gcal007 TO s_detail1[l_ac].gcal007 
      END IF         
   END IF   
END FUNCTION
#chk gcal008
PRIVATE FUNCTION agct401_chk_gcal008()
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM gcas_t WHERE gcas001 = g_gcal_d[l_ac].gcal001
      AND gcasent = g_enterprise    #160905-00007#3 add
      AND gcas002 = g_gcal_d[l_ac].gcal013
      AND gcas003 = g_gcal_d[l_ac].gcal008 AND gcas006='1'
   IF l_cnt <=0 THEN
      LET g_errno = "agc-00003"
   ELSE
      SELECT count(*) INTO l_cnt1 FROM gcas_t WHERE gcas001 = g_gcal_d[l_ac].gcal001
         AND gcasent = g_enterprise    #160905-00007#3 add
         AND gcas002 = g_gcal_d[l_ac].gcal013
         AND gcas003 = g_gcal_d[l_ac].gcal008 AND gcas006='1' AND gcasstus='Y' 
      IF l_cnt1<=0 THEN
         LET g_errno="agc-00004"
      END IF      
   END IF   
END FUNCTION
#display gcal008
PRIVATE FUNCTION agct401_display_gcal008()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcal_d[l_ac].gcal008
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent= "||g_enterprise||" AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcal_d[l_ac].gcal008_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_gcal_d[l_ac].gcal008_desc TO s_detail1[l_ac].gcal008_desc
END FUNCTION
#display gcal013
PRIVATE FUNCTION agct401_display_gcal013()
   DEFINE l_cnt LIKE type_t.num5
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcal_d[l_ac].gcal013
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent= "||g_enterprise||" AND oocql001='2071' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcal_d[l_ac].gcal013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcal_d[l_ac].gcal013_desc
   
   SELECT gcar005 INTO g_gcal_d[l_ac].gcal014 FROM gcar_t
    WHERE gcarent = g_enterprise AND gcar001 = g_gcal_d[l_ac].gcal001
      AND gcar002 = g_gcal_d[l_ac].gcal013
   DISPLAY BY NAME g_gcal_d[l_ac].gcal014 
   
   let l_cnt = 0
   SELECT count(*) INTO l_cnt FROM gcas_t,gcaf_t WHERE gcas001=gcaf001 AND gcasent=gcalent AND gcas001 = g_gcal_d[l_ac].gcal001
      and gcas002 = g_gcal_d[l_ac].gcal013 AND gcaf003='3'
      AND gcasent = g_enterprise
   IF l_cnt = 1 THEN
         SELECT gcas003 INTO g_gcal_d[l_ac].gcal008 FROM gcas_t
          WHERE gcasent = g_enterprise AND gcas001 = g_gcal_d[l_ac].gcal001
            and gcas002 = g_gcal_d[l_ac].gcal013
         DISPLAY g_gcal_d[l_ac].gcal008 TO s_detail1[l_ac].gcal008
         call agct401_display_gcal008()         
   END IF
END FUNCTION

#chk gcal009
PRIVATE FUNCTION agct401_gcal009_after(p_cmd)
   DEFINE l_count  LIKE type_t.num5
   DEFINE p_cmd    LIKE type_t.chr1
   LET l_count = 0
   LET g_errno = NULL
   IF NOT cl_null( g_gcal_d[l_ac].gcal009)  AND NOT cl_null( g_gcal_d[l_ac].gcal010) THEN 
      IF p_cmd = 'u' THEN   
         SELECT count(*) INTO l_count FROM gcal_t WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
            AND gcal001 = g_gcal_d[l_ac].gcal001 AND ((gcal009 BETWEEN g_gcal_d[l_ac].gcal009 AND g_gcal_d[l_ac].gcal010)
             OR (gcal010 BETWEEN g_gcal_d[l_ac].gcal009 AND g_gcal_d[l_ac].gcal010)) AND ((gcal009 != g_gcal_d_t.gcal009)
             OR gcal010 != g_gcal_d_t.gcal010) AND gcalseq != g_gcal_d_t.gcalseq
      ELSE
         SELECT count(*) INTO l_count FROM gcal_t WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
         AND gcal001 = g_gcal_d[l_ac].gcal001 AND ((gcal009 BETWEEN g_gcal_d[l_ac].gcal009 AND g_gcal_d[l_ac].gcal010)
          OR (gcal010 BETWEEN g_gcal_d[l_ac].gcal009 AND g_gcal_d[l_ac].gcal010)) 
      END IF      
   END IF
   IF l_count >0 THEN
      LET g_errno = "amm-00072"
   ELSE   
      IF NOT cl_null( g_gcal_d[l_ac].gcal009) THEN 
         IF p_cmd = 'u' THEN   
            SELECT count(*) INTO l_count FROM gcal_t WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
               AND gcal001 = g_gcal_d[l_ac].gcal001 AND ((g_gcal_d[l_ac].gcal009 BETWEEN gcal009 AND gcal010)) 
               AND ((gcal009 != g_gcal_d_t.gcal009) OR gcal010 != g_gcal_d_t.gcal010)
               AND gcalseq != g_gcal_d_t.gcalseq
         ELSE
            SELECT count(*) INTO l_count FROM gcal_t WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
               AND gcal001 = g_gcal_d[l_ac].gcal001 AND (g_gcal_d[l_ac].gcal009 BETWEEN gcal009 AND gcal010)
         END IF      
      END IF
      IF l_count >0 THEN
         LET g_errno = "amm-00072"
      ELSE
         
         IF NOT cl_null( g_gcal_d[l_ac].gcal010) THEN 
            IF p_cmd = 'u' THEN   
               SELECT count(*) INTO l_count FROM gcal_t WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
                  AND gcal001 = g_gcal_d[l_ac].gcal001 AND ((g_gcal_d[l_ac].gcal010 BETWEEN gcal009 AND gcal010)) 
                  AND ((gcal009 != g_gcal_d_t.gcal009) OR gcal010 != g_gcal_d_t.gcal010)
                  AND gcalseq != g_gcal_d_t.gcalseq
            ELSE
               SELECT count(*) INTO l_count FROM gcal_t WHERE gcalent = g_enterprise AND gcaldocno = g_gcak_m.gcakdocno
                  AND gcal001 = g_gcal_d[l_ac].gcal001 AND (g_gcal_d[l_ac].gcal010 BETWEEN gcal009 AND gcal010) 
            END IF      
         END IF
         IF l_count >0 THEN
            LET g_errno = "amm-00072"
         END IF   
      END IF      
   END IF
END FUNCTION

#chk gcao001
PRIVATE FUNCTION agct401_chk_gcao001()
DEFINE    l_gcaf007       LIKE gcaf_t.gcaf007    #固定位數
DEFINE    l_gcaf008       LIKE gcaf_t.gcaf008    #固定編碼
DEFINE    l_start_no        LIKE type_t.num20
DEFINE    l_end_no          LIKE type_t.num20
DEFINE    l_start_no1       LIKE type_t.num20
DEFINE    l_length          LIKE type_t.num5
DEFINE    l_length1         LIKE type_t.num5
DEFINE    l_nums            LIKE type_t.num20
DEFINE    l_sql2            STRING
DEFINE    l_sql             STRING
DEFINE    l_cnt           LIKE type_t.num5
DEFINE    l_gcao001       LIKE gcao_t.gcao001
   
   LET g_errno = NULL
   LET l_cnt = 0
   CREATE TEMP TABLE agct401_tmp
   (
      gcao001 varchar(30)
   );
   DELETE from agct401_tmp
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF
   LET l_gcaf007=NULL
   LET l_gcaf008=NULL
   
      SELECT gcaf007,gcaf008 INTO l_gcaf007,l_gcaf008
        FROM gcaf_t WHERE gcaf001=g_gcal_d[l_ac].gcal001 AND gcafent = g_enterprise
      
      LET l_length  = LENGTH(g_gcal_d[l_ac].gcal009)
      LET l_length1 = LENGTH(g_gcal_d[l_ac].gcal009)-l_gcaf007
      LET l_start_no = g_gcal_d[l_ac].gcal009[l_gcaf007+1,l_length]
      LET l_end_no = g_gcal_d[l_ac].gcal010[l_gcaf007+1,l_length]
      LET l_nums = l_end_no - l_start_no + 1
      IF cl_null(l_nums) THEN LET l_nums = 0 END IF
      LET l_start_no1 = l_start_no - 1
      LET l_sql2 = " INSERT INTO agct401_tmp(gcao001) ",   
                   " SELECT ('",l_gcaf008 CLIPPED,"' || ",
                   " substr(power(10,",l_length1,"-length(id+",l_start_no1,")) || (id+",l_start_no1,"),2))",
                   " AS lrt021",
                   "  FROM (SELECT level AS id FROM dual ",
                   "         CONNECT BY level <=",l_nums,")"  
      PREPARE l_sql2_pre FROM l_sql2  
      EXECUTE l_sql2_pre      
#      DECLARE l_sql2_cs CURSOR FOR l_sql2_pre
#      FOREACH l_sql2_cs INTO l_gcao001      
#         IF SQLCA.sqlcode THEN
#            LET g_errno=SQLCA.sqlcode
#            RETURN
#         END IF
#         INSERT INTO agct401_tmp VALUES (l_gcao001) 
#         IF SQLCA.sqlcode THEN
#            LET g_errno=SQLCA.sqlcode
#            RETURN
#         END IF
#      END FOREACH      
      SELECT count(*) INTO l_cnt FROM gcao_t WHERE gcaoent = g_enterprise
         AND gcao001 IN (SELECT gcao001 FROM agct401_tmp)
      IF l_cnt>0 THEN
         LET g_errno="agc-00002"
         RETURN
      END IF    
   
END FUNCTION
#chk gcal013
PRIVATE FUNCTION agct401_chk_gcal013()
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   
   SELECT count(*) INTO l_cnt FROM  gcar_t WHERE gcarent = g_enterprise
      AND gcar001 = g_gcal_d[l_ac].gcal001 AND gcar002 =g_gcal_d[l_ac].gcal013 
   IF l_cnt <=0  THEN
      LET g_errno = "agc-00005"
   ELSE 
      SELECT count(*) INTO l_cnt1 FROM  gcar_t WHERE gcarent = g_enterprise
         AND gcar001 = g_gcal_d[l_ac].gcal001 AND gcar002 =g_gcal_d[l_ac].gcal013
         AND gcarstus='Y' 
      IF l_cnt1<=0 THEN
         LET g_errno = "agc-00006" 
      END IF      
   END IF   
END FUNCTION

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
PRIVATE FUNCTION agct401_excel_chk(p_gcal,p_msg)
DEFINE  p_rtdudocno LIKE rtdu_t.rtdudocno
   DEFINE  p_msg      STRING 
  #DEFINE  p_gcal  RECORD LIKE gcal_t.*  #161111-00028#1--mark
  #161111-00028#1---add----begin--------------
   DEFINE  p_gcal RECORD  #券發行單身檔
       gcalent LIKE gcal_t.gcalent, #企業編號
       gcalsite LIKE gcal_t.gcalsite, #營運據點
       gcalunit LIKE gcal_t.gcalunit, #應用組織
       gcaldocno LIKE gcal_t.gcaldocno, #單據編號
       gcalseq LIKE gcal_t.gcalseq, #項次
       gcal001 LIKE gcal_t.gcal001, #券種編號
       gcal002 LIKE gcal_t.gcal002, #券號總碼長
       gcal003 LIKE gcal_t.gcal003, #券號固定編號長度
       gcal004 LIKE gcal_t.gcal004, #券號固定編號
       gcal005 LIKE gcal_t.gcal005, #券號流水碼長度
       gcal006 LIKE gcal_t.gcal006, #產生券號明細
       gcal007 LIKE gcal_t.gcal007, #發行張數
       gcal008 LIKE gcal_t.gcal008, #提貨券商品編號
       gcal009 LIKE gcal_t.gcal009, #開始券號
       gcal010 LIKE gcal_t.gcal010, #結束券號
       gcal011 LIKE gcal_t.gcal011, #空白券庫區
       gcal012 LIKE gcal_t.gcal012, #發行券庫區
       gcal013 LIKE gcal_t.gcal013, #券面額編號
       gcal014 LIKE gcal_t.gcal014  #券單位金額
   END RECORD
   #161111-00028#1---add---end----------------------------

   
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_errno      STRING   
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   DEFINE l_gcaf015  LIKE gcaf_t.gcaf015
   DEFINE l_m        int 
   
   CASE
      WHEN (cl_null(p_gcal.gcal001)) 
         CALL cl_errmsg('gcal001','券种不可为空',p_msg,'!',1)
         RETURN FALSE 
      WHEN (cl_null(p_gcal.gcal013)) 
         CALL cl_errmsg('gcal013','券面额不能为空',p_msg,'!',1)
         RETURN FALSE 
      WHEN (cl_null(p_gcal.gcal009))
         CALL cl_errmsg('gcal009','券号不能为空',p_msg,'!',1)
         RETURN FALSE 
      WHEN (cl_null(p_gcal.gcal011))
         CALL cl_errmsg('gcal011','空白券库区不能为空',p_msg,'!',1)
         RETURN FALSE
      WHEN (cl_null(p_gcal.gcal012))
         CALL cl_errmsg('gcal012','发行券库区不能为空',p_msg,'!',1)
         RETURN FALSE 
   END CASE      
   IF NOT cl_null (p_gcal.gcal001) THEN 
   	  LET l_cnt = 0
      LET l_cnt1 = 0
      LET g_errno = NULL
      SELECT count(*) INTO l_cnt FROM gcaf_t WHERE gcaf001 = p_gcal.gcal001
      AND gcafent = g_enterprise
      IF l_cnt<=0 THEN
      	 INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = p_msg,p_gcal.gcal001
         LET g_errparam.code   = 'agc-00001'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      ELSE
         SELECT count(*) INTO l_cnt1 FROM gcaf_t WHERE gcaf001 = p_gcal.gcal001
         AND gcafent = g_enterprise AND gcafstus = 'Y'
         IF l_cnt1<=0 THEN
         	  INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = p_msg,p_gcal.gcal001
            LET g_errparam.code   = 'agc-00042'
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF      
      END IF   
      SELECT gcaf015 INTO l_gcaf015 FROM gcaf_t WHERE gcafent = g_enterprise AND gcaf001 = p_gcal.gcal001
      IF l_gcaf015 = 'N' THEN
      	 INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = p_msg,p_gcal.gcal001
         LET g_errparam.code   = 'agc-00107'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN  FALSE  
      END IF
   END IF
   IF NOT cl_null (p_gcal.gcal009) THEN
      let l_m = 0    
      SELECT COUNT(*) INTO l_m FROM gcao_t
      WHERE gcaoent=g_enterprise AND gcao001= p_gcal.gcal009
      IF l_m > 0 THEN 
      	 INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = p_msg,p_gcal.gcal009
         LET g_errparam.code   = 'agc-00076'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN  FALSE
      END IF 
   END IF 
   IF NOT cl_null (p_gcal.gcal013) THEN 
      LET l_cnt = 0
      LET l_cnt1 = 0
      SELECT COUNT(*) INTO l_cnt FROM gcar_t
      WHERE gcarent=g_enterprise AND gcar001= p_gcal.gcal001 AND gcar002=p_gcal.gcal013
      IF l_cnt <= 0  THEN 
      	 INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = p_msg
         LET g_errparam.code   = 'agc-00005'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN  FALSE
      END IF
      SELECT COUNT(*) INTO l_cnt1 FROM gcar_t
      WHERE gcarent=g_enterprise AND gcar001= p_gcal.gcal001 AND gcar002=p_gcal.gcal013
        AND gcarstus = 'Y' 
      IF l_cnt1 <= 0  THEN 
      	 INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = p_msg
         LET g_errparam.code   = 'agc-00006'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN  FALSE
      END IF
   END IF
   IF NOT cl_null (p_gcal.gcal011) THEN 
      LET l_cnt = 0
      LET l_cnt1 = 0
      SELECT count(*) INTO l_cnt FROM inaa_t WHERE inaa001 = p_gcal.gcal011
      AND inaaent = g_enterprise AND inaasite = g_gcak_m.gcaksite
      IF l_cnt<=0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = p_msg
         LET g_errparam.code   = 'agc-00128'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN  FALSE
      ELSE
         SELECT count(*) INTO l_cnt1 FROM inaa_t WHERE inaa001 = p_gcal.gcal011
            AND inaaent = g_enterprise AND inaasite = g_gcak_m.gcaksite
            AND inaastus = 'Y'
         IF l_cnt1 < = 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = p_msg
            LET g_errparam.code   = 'sub-01302'
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN  FALSE 
         END IF
      END IF
   END IF 
   IF NOT cl_null (p_gcal.gcal012) THEN 
      LET l_cnt = 0
      LET l_cnt1 = 0
      SELECT count(*) INTO l_cnt FROM inaa_t WHERE inaa001 = p_gcal.gcal012
      AND inaaent = g_enterprise AND inaasite = g_gcak_m.gcaksite
      IF l_cnt<=0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = p_msg
         LET g_errparam.code   = 'agc-00128'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN  FALSE
      ELSE
         SELECT count(*) INTO l_cnt1 FROM inaa_t WHERE inaa001 = p_gcal.gcal012
            AND inaaent = g_enterprise AND inaasite = g_gcak_m.gcaksite
            AND inaastus = 'Y'
         IF l_cnt1 < = 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = p_msg
            LET g_errparam.code   = 'sub-01302'
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN  FALSE 
         END IF
      END IF
   END IF           
   RETURN TRUE
END FUNCTION

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
PRIVATE FUNCTION agct401_excel()

   DEFINE ls_str                  STRING,
          ls_file                 STRING,
          ls_location             STRING
   DEFINE l_success               LIKE type_t.chr1
   DEFINE l_sys                   LIKE type_t.chr1
   DEFINE l_suc                   LIKE type_t.chr1
   DEFINE l_path                  STRING
   DEFINE xlapp,iRes,iRow,i,j     INTEGER
   DEFINE sValue                  STRING
   DEFINE gs_location             STRING
   DEFINE g_fileloc               STRING
   DEFINE p_row,p_col,l_n         SMALLINT
   DEFINE l_msg                   STRING
   DEFINE l_msg1                  STRING
   DEFINE l_cnt                   LIKE type_t.num10
   DEFINE l_cnt1                  LIKE type_t.num10
   DEFINE l_count                 LIKE rtdv_t.rtdv019 
   DEFINE l_str                   STRING 
   DEFINE l_sql                   STRING 
   DEFINE l_cnm                   LIKE type_t.num10
   DEFINE l_oofg_return           DYNAMIC ARRAY OF RECORD
          oofg019                 LIKE oofg_t.oofg019,
          oofg020                 LIKE oofg_t.oofg020 
          END RECORD
  #DEFINE l_gcal                  RECORD LIKE gcal_t.*  #161111-00028#1--mark
  #161111-00028#1---add----begin------------
   DEFINE l_gcal RECORD  #券發行單身檔
       gcalent LIKE gcal_t.gcalent, #企業編號
       gcalsite LIKE gcal_t.gcalsite, #營運據點
       gcalunit LIKE gcal_t.gcalunit, #應用組織
       gcaldocno LIKE gcal_t.gcaldocno, #單據編號
       gcalseq LIKE gcal_t.gcalseq, #項次
       gcal001 LIKE gcal_t.gcal001, #券種編號
       gcal002 LIKE gcal_t.gcal002, #券號總碼長
       gcal003 LIKE gcal_t.gcal003, #券號固定編號長度
       gcal004 LIKE gcal_t.gcal004, #券號固定編號
       gcal005 LIKE gcal_t.gcal005, #券號流水碼長度
       gcal006 LIKE gcal_t.gcal006, #產生券號明細
       gcal007 LIKE gcal_t.gcal007, #發行張數
       gcal008 LIKE gcal_t.gcal008, #提貨券商品編號
       gcal009 LIKE gcal_t.gcal009, #開始券號
       gcal010 LIKE gcal_t.gcal010, #結束券號
       gcal011 LIKE gcal_t.gcal011, #空白券庫區
       gcal012 LIKE gcal_t.gcal012, #發行券庫區
       gcal013 LIKE gcal_t.gcal013, #券面額編號
       gcal014 LIKE gcal_t.gcal014  #券單位金額
       END RECORD
   #161111-00028#1---add----end-----------
   DEFINE l_stae010               LIKE stae_t.stae010
   DEFINE l_stbb018               LIKE stbb_t.stbb018
   DEFINE l_m                     INT
   DEFINE r_success               LIKE type_t.num5
   DEFINE r_doctype               LIKE rtai_t.rtai004
   DEFINE r_insert                LIKE type_t.num5
   DEFINE r_stau004               LIKE stau_t.stau004
   DEFINE r_period                LIKE type_t.num5
   DEFINE r_period2               LIKE type_t.num5
   DEFINE g_sql1                  STRING 
   DEFINE p_msg                   STRING  
   DEFINE l_t                     int
   DEFINE l_gcaf010               LIKE gcaf_t.gcaf010
   DEFINE l_gcaf011               LIKE gcaf_t.gcaf011
   DEFINE l_gcal009               LIKE gcal_t.gcal009
   DEFINE l_gcal010               LIKE gcal_t.gcal010
      

   WHENEVER ERROR CALL cl_err_msg_log      
   LET l_success = 'Y'

   #获取EXCEL文档所在位置
   CALL ui.Interface.frontCall("standard","openfile",["C:", "All Files", "*.*", "File Browser"],[gs_location])
   
   LET g_fileloc=gs_location
   
   IF cl_null(g_fileloc) THEN 
      RETURN
   END IF
   
   IF l_success='Y' THEN
   #创建EXCEL实例进程
      #MS OFFICE EXCEL
      CALL ui.interface.frontCall('WinCOM','CreateInstance',['Excel.Application'],[xlApp])
      IF xlApp = -1 THEN
         #KS WPS 9.0 KET
         CALL ui.interface.frontCall('WinCOM','CreateInstance',['Ket.Application'],[xlApp])
      END IF
      IF xlApp = -1 THEN
         #KS WPS 8.0及以下 ET
         CALL ui.interface.frontCall('WinCOM','CreateInstance',['ET.Application'],[xlApp])
      END IF
      IF xlApp <> -1 THEN
         #打开EXCEL文件
         CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Workbooks.Open',g_fileloc],[iRes])
         IF iRes <> -1 THEN
            #获取EXCEL中的行数
            CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
            
            IF iRow > 1 THEN
               LET l_n = 0
               CALL cl_showmsg_init()
               #显示进度条，EXCEL中有多少行不算正式数据就减多少
               CALL cl_progress_bar(iRow-2)              
               #BEGIN WORK
               CALL s_transaction_begin() 
               CALL cl_err_collect_init()              
               FOR i = 3 TO iRow             
                  LET l_n = l_n +1                   
                  IF iRow > = l_n THEN
                     CALL cl_progress_ing('正在导入第'||i||'行数据')
                  END IF 
                  
                  INITIALIZE l_gcal.* TO NULL

                  CALL ui.interface.frontcall('WinCOM','GetProperty',
                                              [xlApp,'ActiveSheet.Range("A'||i||':E'||i||'").value'],                                                                                      
                                              [l_gcal.gcal012,l_gcal.gcal011,l_gcal.gcal009,l_gcal.gcal013,l_gcal.gcal001])
                                                                  
                  LET l_msg = "导入excel中第",i,"行数据失败"
                  LET l_msg1 = "导入excel中第",i,"行"
                  CALL agct401_excel_chk(l_gcal.*,l_msg1) RETURNING l_suc
                  IF NOT l_suc THEN
                     LET l_success='N'                  
                     CONTINUE FOR
                  END IF                   
                  LET l_gcal.gcalsite=g_gcak_m.gcaksite
                  LET l_gcal.gcalunit=g_gcak_m.gcakunit
                  LET l_gcal.gcaldocno=g_gcak_m.gcakdocno
                  LET l_gcal.gcal007=1
                  LET l_gcal.gcal010=l_gcal.gcal009
                  SELECT max(gcalseq) INTO l_gcal.gcalseq
                  FROM gcal_t
                  WHERE gcalent=g_enterprise AND gcaldocno=g_gcak_m.gcakdocno 
                  IF cl_null(l_gcal.gcalseq) THEN 
                     LET l_gcal.gcalseq =1
                  ELSE 
                     LET l_gcal.gcalseq=l_gcal.gcalseq+1
                  END IF
                  LET l_sys ='N' 
                  #检查券号在单身是否已经存在
                  let l_sql =" select gcal009,gcal010 from gcal_t ",
                             " where gcalent= ",g_enterprise,
                             "   and gcal001 = '",l_gcal.gcal001,"' ",
                             "  and gcaldocno = '",g_gcak_m.gcakdocno,"' ",
                             " order by gcalseq "
                  PREPARE agct401_pb_1 FROM l_sql
                  DECLARE agct401_cur_1 CURSOR FOR agct401_pb_1                              
                  FOREACH agct401_cur_1 into l_gcal009,l_gcal010
                     IF l_gcal.gcal009 >=l_gcal009 AND l_gcal.gcal009 <=l_gcal010 THEN
                        LET l_sys='Y'                     
                         EXIT FOREACH
                     END IF
                  END FOREACH
                  IF l_sys = 'Y' THEN 
                     CONTINUE FOR 
                  END IF                      
                  SELECT gcaf006,gcaf007,gcaf008,gcaf009,gcaf015,gcaf010,gcaf011
                  INTO l_gcal.gcal002,l_gcal.gcal003,l_gcal.gcal004,l_gcal.gcal005,l_gcal.gcal006,l_gcaf010,l_gcaf011
                  FROM gcaf_t
                  WHERE gcaf001 = l_gcal.gcal001 AND gcafent = g_enterprise
                  #检查券号是否符合券发行规则
                   IF NOT cl_null(l_gcal.gcal002) AND NOT cl_null(l_gcal.gcal003) AND 
                      NOT cl_null(l_gcal.gcal004) AND NOT cl_null(l_gcal.gcal005) THEN
                      LET l_str = l_gcal.gcal009
                      IF l_gcal.gcal002 != l_str.getLength() THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = l_gcal.gcal009
                         LET g_errparam.code   = 'agc-00009'
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                         LET l_success='N'
                         CONTINUE FOR 
                      END IF
                      IF l_gcal.gcal004 != l_str.subString(1,l_gcal.gcal003) THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = l_gcal.gcal009
                         LET g_errparam.code   = 'agc-00009'
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                         LET l_success='N'
                         CONTINUE FOR 
                      END IF
                      IF l_gcal.gcal005 > 0 THEN
                         IF NOT s_chr_alphanumeric(l_str.subString(l_gcal.gcal003+1,l_str.getLength()),1) THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = l_gcal.gcal009
                            LET g_errparam.code   = 'agc-00009'
                            LET g_errparam.popup  = FALSE 
                            CALL cl_err()
                            LET l_success='N'
                            CONTINUE FOR 
                         END IF
                      END IF
                   END IF
                   IF NOT cl_null(l_gcaf010) AND NOT cl_null(l_gcaf011) THEN
                      IF l_gcal.gcal009< l_gcaf010 OR l_gcal.gcal009> l_gcaf011 THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = l_gcal.gcal009
                         LET g_errparam.code   = 'amm-00283'
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                         LET l_success='N'
                         CONTINUE FOR 
                      END IF
                   END IF
                   SELECT gcar005 INTO l_gcal.gcal014 FROM gcar_t
                   WHERE gcarent = g_enterprise AND gcar001 = l_gcal.gcal001
                     AND gcar002 = l_gcal.gcal013
                   LET l_cnt = 0
                   SELECT count(*) INTO l_cnt FROM gcas_t,gcaf_t 
                   WHERE gcas001=gcaf001 AND gcasent=gcalent AND gcas001 = l_gcal.gcal001
                   AND gcas002 = l_gcal.gcal013 AND gcaf003='3' AND gcasent = g_enterprise
                   IF l_cnt = 1 THEN
                      SELECT gcas003 INTO l_gcal.gcal008 FROM gcas_t
                       WHERE gcasent = g_enterprise AND gcas001 = l_gcal.gcal001
                         AND gcas002 = l_gcal.gcal013
                   END IF 
                 LET g_sql=" INSERT INTO gcal_t (gcalent,gcalunit,gcalsite,gcaldocno,gcalseq,",
                          "gcal001,gcal002,gcal003,gcal004,gcal005,",
                          "gcal006,gcal007,gcal008,gcal009,gcal010,",
                          "gcal011,gcal012,gcal013,gcal014)",

                        "VALUES (?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?)"
                  PREPARE ins_gcal FROM g_sql
                  EXECUTE ins_gcal  USING g_enterprise,l_gcal.gcalunit,l_gcal.gcalsite,l_gcal.gcaldocno,l_gcal.gcalseq, 
                         l_gcal.gcal001,l_gcal.gcal002,l_gcal.gcal003,l_gcal.gcal004,l_gcal.gcal005,
                         l_gcal.gcal006,l_gcal.gcal007,l_gcal.gcal008,l_gcal.gcal009,l_gcal.gcal010,
                         l_gcal.gcal011,l_gcal.gcal012,l_gcal.gcal013,l_gcal.gcal014
                         
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcal_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success='N'
                     CONTINUE FOR
                  END IF
               END FOR
               
               #如果意外停职循环则关闭进度条
               IF i<> iRow  THEN  
                  CALL cl_progress_counter_increase()  
               END IF               
               IF l_success='Y' THEN
                  CALL s_transaction_end('Y','0')
                   
                  #call cl_ask_end()
                 # LET p_msg="导入已完成，按任意键继续"
                  CALL agct401_dr()
                  CALL agct401_b_fill()
               ELSE
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
               END IF
            END IF
         ELSE 
            DISPLAY 'NO FILE'
         END IF
      ELSE
   	     DISPLAY 'NO EXCEL'
      END IF 
   
      CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
      CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])
      
      CALL cl_showmsg()
   END IF
END FUNCTION

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
PRIVATE FUNCTION agct401_dr()
   DEFINE ls_msg     STRING
   DEFINE ls_title   STRING

   WHENEVER ERROR CALL cl_err_msg_log

   LET ls_msg = cl_getmsg("ast-00782",g_lang)
   LET ls_title = cl_getmsg("lib-041",g_lang)

   #若為背景進入(Y)時,不詢問直接離開 (0729)
   IF g_bgjob = "Y" THEN
   ELSE
      MENU ls_title ATTRIBUTE (STYLE="dialog", COMMENT=ls_msg CLIPPED, IMAGE="information")
         ON ACTION ok
            EXIT MENU
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE MENU
      END MENU

      IF INT_FLAG THEN
         LET INT_FLAG = 0
      END IF
   END IF
END FUNCTION

 
{</section>}
 
