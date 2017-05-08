#該程式未解開Section, 採用最新樣板產出!
{<section id="amrt300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-07-20 14:44:27), PR版次:0009(2016-08-26 09:30:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: amrt300
#+ Description: 資源維修工單維護作業
#+ Creator....: 05384(2014-12-02 15:48:42)
#+ Modifier...: 03079 -SD/PR- 08734
 
{</section>}
 
{<section id="amrt300.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#25  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#24  2016/04/25 BY 07900   校验代码重复错误讯息的修改
#160524-00044#5   2016/07/20 By 03079   預設除役日期
#160812-00017#5 16/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#24 2016-08-24 By 08734 删除修改未重新判断状态码
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
PRIVATE type type_g_mrdh_m        RECORD
       mrdhdocno LIKE mrdh_t.mrdhdocno, 
   mrdhdocno_desc LIKE type_t.chr80, 
   mrdhdocdt LIKE mrdh_t.mrdhdocdt, 
   mrdh001 LIKE mrdh_t.mrdh001, 
   mrdh001_desc LIKE type_t.chr80, 
   mrdh002 LIKE mrdh_t.mrdh002, 
   mrdh002_desc LIKE type_t.chr80, 
   mrdhstus LIKE mrdh_t.mrdhstus, 
   mrdhsite LIKE mrdh_t.mrdhsite, 
   mrdh003 LIKE mrdh_t.mrdh003, 
   mrdh003_desc LIKE type_t.chr80, 
   mrdh004 LIKE mrdh_t.mrdh004, 
   mrdh005 LIKE mrdh_t.mrdh005, 
   mrdh006 LIKE mrdh_t.mrdh006, 
   mrdh007 LIKE mrdh_t.mrdh007, 
   mrdh008 LIKE mrdh_t.mrdh008, 
   mrdhownid LIKE mrdh_t.mrdhownid, 
   mrdhownid_desc LIKE type_t.chr80, 
   mrdhowndp LIKE mrdh_t.mrdhowndp, 
   mrdhowndp_desc LIKE type_t.chr80, 
   mrdhcrtid LIKE mrdh_t.mrdhcrtid, 
   mrdhcrtid_desc LIKE type_t.chr80, 
   mrdhcrtdp LIKE mrdh_t.mrdhcrtdp, 
   mrdhcrtdp_desc LIKE type_t.chr80, 
   mrdhcrtdt LIKE mrdh_t.mrdhcrtdt, 
   mrdhmodid LIKE mrdh_t.mrdhmodid, 
   mrdhmodid_desc LIKE type_t.chr80, 
   mrdhmoddt LIKE mrdh_t.mrdhmoddt, 
   mrdhcnfid LIKE mrdh_t.mrdhcnfid, 
   mrdhcnfid_desc LIKE type_t.chr80, 
   mrdhcnfdt LIKE mrdh_t.mrdhcnfdt, 
   mrdhpstid LIKE mrdh_t.mrdhpstid, 
   mrdhpstid_desc LIKE type_t.chr80, 
   mrdhpstdt LIKE mrdh_t.mrdhpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mrdi_d        RECORD
       mrdiseq LIKE mrdi_t.mrdiseq, 
   mrdi001 LIKE mrdi_t.mrdi001, 
   mrdi002 LIKE mrdi_t.mrdi002, 
   mrdi002_desc LIKE type_t.chr500, 
   mrdi003 LIKE mrdi_t.mrdi003, 
   mrdi004 LIKE mrdi_t.mrdi004, 
   mrdi005 LIKE mrdi_t.mrdi005, 
   mrdi006 LIKE mrdi_t.mrdi006, 
   mrdi007 LIKE mrdi_t.mrdi007, 
   mrdi007_desc LIKE type_t.chr500, 
   mrdi008 LIKE mrdi_t.mrdi008, 
   mrdi008_desc LIKE type_t.chr500, 
   mrdi009 LIKE mrdi_t.mrdi009, 
   mrdisite LIKE mrdi_t.mrdisite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mrdhsite LIKE mrdh_t.mrdhsite,
      b_mrdhdocno LIKE mrdh_t.mrdhdocno,
      b_mrdhdocdt LIKE mrdh_t.mrdhdocdt,
      b_mrdh001 LIKE mrdh_t.mrdh001,
      b_mrdh002 LIKE mrdh_t.mrdh002,
      b_mrdhcrtid LIKE mrdh_t.mrdhcrtid,
   b_mrdhcrtid_desc LIKE type_t.chr80,
      b_mrdhcrtdt LIKE mrdh_t.mrdhcrtdt,
      b_mrdhmodid LIKE mrdh_t.mrdhmodid,
   b_mrdhmodid_desc LIKE type_t.chr80,
      b_mrdhmoddt LIKE mrdh_t.mrdhmoddt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_mrdh_m          type_g_mrdh_m
DEFINE g_mrdh_m_t        type_g_mrdh_m
DEFINE g_mrdh_m_o        type_g_mrdh_m
DEFINE g_mrdh_m_mask_o   type_g_mrdh_m #轉換遮罩前資料
DEFINE g_mrdh_m_mask_n   type_g_mrdh_m #轉換遮罩後資料
 
   DEFINE g_mrdhdocno_t LIKE mrdh_t.mrdhdocno
 
 
DEFINE g_mrdi_d          DYNAMIC ARRAY OF type_g_mrdi_d
DEFINE g_mrdi_d_t        type_g_mrdi_d
DEFINE g_mrdi_d_o        type_g_mrdi_d
DEFINE g_mrdi_d_mask_o   DYNAMIC ARRAY OF type_g_mrdi_d #轉換遮罩前資料
DEFINE g_mrdi_d_mask_n   DYNAMIC ARRAY OF type_g_mrdi_d #轉換遮罩後資料
 
 
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
 
{<section id="amrt300.main" >}
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
   LET g_errshow = 1
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mrdhdocno,'',mrdhdocdt,mrdh001,'',mrdh002,'',mrdhstus,mrdhsite,mrdh003, 
       '',mrdh004,mrdh005,mrdh006,mrdh007,mrdh008,mrdhownid,'',mrdhowndp,'',mrdhcrtid,'',mrdhcrtdp,'', 
       mrdhcrtdt,mrdhmodid,'',mrdhmoddt,mrdhcnfid,'',mrdhcnfdt,mrdhpstid,'',mrdhpstdt", 
                      " FROM mrdh_t",
                      " WHERE mrdhent= ? AND mrdhdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrdhdocno,t0.mrdhdocdt,t0.mrdh001,t0.mrdh002,t0.mrdhstus,t0.mrdhsite, 
       t0.mrdh003,t0.mrdh004,t0.mrdh005,t0.mrdh006,t0.mrdh007,t0.mrdh008,t0.mrdhownid,t0.mrdhowndp,t0.mrdhcrtid, 
       t0.mrdhcrtdp,t0.mrdhcrtdt,t0.mrdhmodid,t0.mrdhmoddt,t0.mrdhcnfid,t0.mrdhcnfdt,t0.mrdhpstid,t0.mrdhpstdt, 
       t1.ooag011 ,t2.ooefl003 ,t3.mrba004 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 , 
       t9.ooag011 ,t10.ooag011",
               " FROM mrdh_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdh001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdh002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mrba_t t3 ON t3.mrbaent="||g_enterprise||" AND t3.mrbasite=t0.mrdhsite AND t3.mrba001=t0.mrdh003  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdhownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mrdhowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mrdhcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.mrdhcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mrdhmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mrdhcnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.mrdhpstid  ",
 
               " WHERE t0.mrdhent = " ||g_enterprise|| " AND t0.mrdhdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amrt300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrt300 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrt300_init()   
 
      #進入選單 Menu (="N")
      CALL amrt300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amrt300
      
   END IF 
   
   CLOSE amrt300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amrt300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amrt300_init()
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
      CALL cl_set_combo_scc_part('mrdhstus','13','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL amrt300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amrt300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amrt300_ui_dialog()
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
            CALL amrt300_insert()
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
         INITIALIZE g_mrdh_m.* TO NULL
         CALL g_mrdi_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrt300_init()
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
               
               CALL amrt300_fetch('') # reload data
               LET l_ac = 1
               CALL amrt300_ui_detailshow() #Setting the current row 
         
               CALL amrt300_idx_chk()
               #NEXT FIELD mrdiseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mrdi_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt300_idx_chk()
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
               CALL amrt300_idx_chk()
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
            CALL amrt300_browser_fill("")
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
               CALL amrt300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amrt300_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amrt300_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amrt300_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amrt300_set_act_visible()   
            CALL amrt300_set_act_no_visible()
            IF NOT (g_mrdh_m.mrdhdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mrdhent = " ||g_enterprise|| " AND",
                                  " mrdhdocno = '", g_mrdh_m.mrdhdocno, "' "
 
               #填到對應位置
               CALL amrt300_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mrdh_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdi_t" 
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
               CALL amrt300_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mrdh_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdi_t" 
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
                  CALL amrt300_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amrt300_fetch("F")
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
               CALL amrt300_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amrt300_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt300_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amrt300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt300_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amrt300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt300_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amrt300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt300_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amrt300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt300_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mrdi_d)
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
               NEXT FIELD mrdiseq
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
               CALL amrt300_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amrt300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amrt300_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amrt300_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amr/amrt300_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amr/amrt300_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amrt300_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amrt300_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amrt300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amrt300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amrt300_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mrdh_m.mrdhdocdt)
 
 
 
         
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
 
{<section id="amrt300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amrt300_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " mrdhsite = '",g_site,"' "
   ELSE
      LET g_wc = g_wc," AND mrdhsite = '",g_site,"' "
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
      LET l_sub_sql = " SELECT DISTINCT mrdhdocno ",
                      " FROM mrdh_t ",
                      " ",
                      " LEFT JOIN mrdi_t ON mrdient = mrdhent AND mrdhdocno = mrdidocno ", "  ",
                      #add-point:browser_fill段sql(mrdi_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE mrdhent = " ||g_enterprise|| " AND mrdient = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrdh_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrdhdocno ",
                      " FROM mrdh_t ", 
                      "  ",
                      "  ",
                      " WHERE mrdhent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mrdh_t")
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
      INITIALIZE g_mrdh_m.* TO NULL
      CALL g_mrdi_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrdhsite,t0.mrdhdocno,t0.mrdhdocdt,t0.mrdh001,t0.mrdh002,t0.mrdhcrtid,t0.mrdhcrtdt,t0.mrdhmodid,t0.mrdhmoddt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdhstus,t0.mrdhsite,t0.mrdhdocno,t0.mrdhdocdt,t0.mrdh001,t0.mrdh002, 
          t0.mrdhcrtid,t0.mrdhcrtdt,t0.mrdhmodid,t0.mrdhmoddt,t1.ooag011 ,t2.ooag011 ",
                  " FROM mrdh_t t0",
                  "  ",
                  "  LEFT JOIN mrdi_t ON mrdient = mrdhent AND mrdhdocno = mrdidocno ", "  ", 
                  #add-point:browser_fill段sql(mrdi_t1) name="browser_fill.join.mrdi_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdhcrtid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mrdhmodid  ",
 
                  " WHERE t0.mrdhent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mrdh_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdhstus,t0.mrdhsite,t0.mrdhdocno,t0.mrdhdocdt,t0.mrdh001,t0.mrdh002, 
          t0.mrdhcrtid,t0.mrdhcrtdt,t0.mrdhmodid,t0.mrdhmoddt,t1.ooag011 ,t2.ooag011 ",
                  " FROM mrdh_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdhcrtid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mrdhmodid  ",
 
                  " WHERE t0.mrdhent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mrdh_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mrdhdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrdh_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mrdhsite,g_browser[g_cnt].b_mrdhdocno, 
          g_browser[g_cnt].b_mrdhdocdt,g_browser[g_cnt].b_mrdh001,g_browser[g_cnt].b_mrdh002,g_browser[g_cnt].b_mrdhcrtid, 
          g_browser[g_cnt].b_mrdhcrtdt,g_browser[g_cnt].b_mrdhmodid,g_browser[g_cnt].b_mrdhmoddt,g_browser[g_cnt].b_mrdhcrtid_desc, 
          g_browser[g_cnt].b_mrdhmodid_desc
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
         CALL amrt300_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_mrdhdocno) THEN
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
 
{<section id="amrt300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amrt300_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrdh_m.mrdhdocno = g_browser[g_current_idx].b_mrdhdocno   
 
   EXECUTE amrt300_master_referesh USING g_mrdh_m.mrdhdocno INTO g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt, 
       g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004, 
       g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
       g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
       g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhpstid_desc 
 
   
   CALL amrt300_mrdh_t_mask()
   CALL amrt300_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amrt300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amrt300_ui_detailshow()
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
 
{<section id="amrt300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amrt300_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrdhdocno = g_mrdh_m.mrdhdocno 
 
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
 
{<section id="amrt300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrt300_construct()
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
   INITIALIZE g_mrdh_m.* TO NULL
   CALL g_mrdi_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mrdhdocno,mrdhdocdt,mrdh001,mrdh002,mrdhstus,mrdhsite,mrdh003,mrdh004, 
          mrdh005,mrdh006,mrdh007,mrdh008,mrdhownid,mrdhowndp,mrdhcrtid,mrdhcrtdp,mrdhcrtdt,mrdhmodid, 
          mrdhmoddt,mrdhcnfid,mrdhcnfdt,mrdhpstid,mrdhpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrdhcrtdt>>----
         AFTER FIELD mrdhcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrdhmoddt>>----
         AFTER FIELD mrdhmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdhcnfdt>>----
         AFTER FIELD mrdhcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdhpstdt>>----
         AFTER FIELD mrdhpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mrdhdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhdocno
            #add-point:ON ACTION controlp INFIELD mrdhdocno name="construct.c.mrdhdocno"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdhdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhdocno  #顯示到畫面上
            NEXT FIELD mrdhdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhdocno
            #add-point:BEFORE FIELD mrdhdocno name="construct.b.mrdhdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhdocno
            
            #add-point:AFTER FIELD mrdhdocno name="construct.a.mrdhdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhdocdt
            #add-point:BEFORE FIELD mrdhdocdt name="construct.b.mrdhdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhdocdt
            
            #add-point:AFTER FIELD mrdhdocdt name="construct.a.mrdhdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdhdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhdocdt
            #add-point:ON ACTION controlp INFIELD mrdhdocdt name="construct.c.mrdhdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh001
            #add-point:ON ACTION controlp INFIELD mrdh001 name="construct.c.mrdh001"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdh001  #顯示到畫面上
            NEXT FIELD mrdh001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh001
            #add-point:BEFORE FIELD mrdh001 name="construct.b.mrdh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh001
            
            #add-point:AFTER FIELD mrdh001 name="construct.a.mrdh001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh002
            #add-point:ON ACTION controlp INFIELD mrdh002 name="construct.c.mrdh002"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdh002  #顯示到畫面上
            NEXT FIELD mrdh002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh002
            #add-point:BEFORE FIELD mrdh002 name="construct.b.mrdh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh002
            
            #add-point:AFTER FIELD mrdh002 name="construct.a.mrdh002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhstus
            #add-point:BEFORE FIELD mrdhstus name="construct.b.mrdhstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhstus
            
            #add-point:AFTER FIELD mrdhstus name="construct.a.mrdhstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhstus
            #add-point:ON ACTION controlp INFIELD mrdhstus name="construct.c.mrdhstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhsite
            #add-point:BEFORE FIELD mrdhsite name="construct.b.mrdhsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhsite
            
            #add-point:AFTER FIELD mrdhsite name="construct.a.mrdhsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdhsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhsite
            #add-point:ON ACTION controlp INFIELD mrdhsite name="construct.c.mrdhsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh003
            #add-point:ON ACTION controlp INFIELD mrdh003 name="construct.c.mrdh003"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_11()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdh003  #顯示到畫面上
            NEXT FIELD mrdh003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh003
            #add-point:BEFORE FIELD mrdh003 name="construct.b.mrdh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh003
            
            #add-point:AFTER FIELD mrdh003 name="construct.a.mrdh003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh004
            #add-point:BEFORE FIELD mrdh004 name="construct.b.mrdh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh004
            
            #add-point:AFTER FIELD mrdh004 name="construct.a.mrdh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh004
            #add-point:ON ACTION controlp INFIELD mrdh004 name="construct.c.mrdh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh005
            #add-point:BEFORE FIELD mrdh005 name="construct.b.mrdh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh005
            
            #add-point:AFTER FIELD mrdh005 name="construct.a.mrdh005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh005
            #add-point:ON ACTION controlp INFIELD mrdh005 name="construct.c.mrdh005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh006
            #add-point:BEFORE FIELD mrdh006 name="construct.b.mrdh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh006
            
            #add-point:AFTER FIELD mrdh006 name="construct.a.mrdh006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh006
            #add-point:ON ACTION controlp INFIELD mrdh006 name="construct.c.mrdh006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh007
            #add-point:BEFORE FIELD mrdh007 name="construct.b.mrdh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh007
            
            #add-point:AFTER FIELD mrdh007 name="construct.a.mrdh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh007
            #add-point:ON ACTION controlp INFIELD mrdh007 name="construct.c.mrdh007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh008
            #add-point:BEFORE FIELD mrdh008 name="construct.b.mrdh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh008
            
            #add-point:AFTER FIELD mrdh008 name="construct.a.mrdh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh008
            #add-point:ON ACTION controlp INFIELD mrdh008 name="construct.c.mrdh008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdhownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhownid
            #add-point:ON ACTION controlp INFIELD mrdhownid name="construct.c.mrdhownid"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhownid  #顯示到畫面上
            NEXT FIELD mrdhownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhownid
            #add-point:BEFORE FIELD mrdhownid name="construct.b.mrdhownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhownid
            
            #add-point:AFTER FIELD mrdhownid name="construct.a.mrdhownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdhowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhowndp
            #add-point:ON ACTION controlp INFIELD mrdhowndp name="construct.c.mrdhowndp"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhowndp  #顯示到畫面上
            NEXT FIELD mrdhowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhowndp
            #add-point:BEFORE FIELD mrdhowndp name="construct.b.mrdhowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhowndp
            
            #add-point:AFTER FIELD mrdhowndp name="construct.a.mrdhowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdhcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhcrtid
            #add-point:ON ACTION controlp INFIELD mrdhcrtid name="construct.c.mrdhcrtid"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhcrtid  #顯示到畫面上
            NEXT FIELD mrdhcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhcrtid
            #add-point:BEFORE FIELD mrdhcrtid name="construct.b.mrdhcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhcrtid
            
            #add-point:AFTER FIELD mrdhcrtid name="construct.a.mrdhcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdhcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhcrtdp
            #add-point:ON ACTION controlp INFIELD mrdhcrtdp name="construct.c.mrdhcrtdp"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhcrtdp  #顯示到畫面上
            NEXT FIELD mrdhcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhcrtdp
            #add-point:BEFORE FIELD mrdhcrtdp name="construct.b.mrdhcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhcrtdp
            
            #add-point:AFTER FIELD mrdhcrtdp name="construct.a.mrdhcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhcrtdt
            #add-point:BEFORE FIELD mrdhcrtdt name="construct.b.mrdhcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdhmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhmodid
            #add-point:ON ACTION controlp INFIELD mrdhmodid name="construct.c.mrdhmodid"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhmodid  #顯示到畫面上
            NEXT FIELD mrdhmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhmodid
            #add-point:BEFORE FIELD mrdhmodid name="construct.b.mrdhmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhmodid
            
            #add-point:AFTER FIELD mrdhmodid name="construct.a.mrdhmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhmoddt
            #add-point:BEFORE FIELD mrdhmoddt name="construct.b.mrdhmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdhcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhcnfid
            #add-point:ON ACTION controlp INFIELD mrdhcnfid name="construct.c.mrdhcnfid"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhcnfid  #顯示到畫面上
            NEXT FIELD mrdhcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhcnfid
            #add-point:BEFORE FIELD mrdhcnfid name="construct.b.mrdhcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhcnfid
            
            #add-point:AFTER FIELD mrdhcnfid name="construct.a.mrdhcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhcnfdt
            #add-point:BEFORE FIELD mrdhcnfdt name="construct.b.mrdhcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdhpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhpstid
            #add-point:ON ACTION controlp INFIELD mrdhpstid name="construct.c.mrdhpstid"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdhpstid  #顯示到畫面上
            NEXT FIELD mrdhpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhpstid
            #add-point:BEFORE FIELD mrdhpstid name="construct.b.mrdhpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhpstid
            
            #add-point:AFTER FIELD mrdhpstid name="construct.a.mrdhpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhpstdt
            #add-point:BEFORE FIELD mrdhpstdt name="construct.b.mrdhpstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mrdiseq,mrdi001,mrdi002,mrdi003,mrdi004,mrdi005,mrdi006,mrdi007,mrdi008, 
          mrdi009,mrdisite
           FROM s_detail1[1].mrdiseq,s_detail1[1].mrdi001,s_detail1[1].mrdi002,s_detail1[1].mrdi003, 
               s_detail1[1].mrdi004,s_detail1[1].mrdi005,s_detail1[1].mrdi006,s_detail1[1].mrdi007,s_detail1[1].mrdi008, 
               s_detail1[1].mrdi009,s_detail1[1].mrdisite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdiseq
            #add-point:BEFORE FIELD mrdiseq name="construct.b.page1.mrdiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdiseq
            
            #add-point:AFTER FIELD mrdiseq name="construct.a.page1.mrdiseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdiseq
            #add-point:ON ACTION controlp INFIELD mrdiseq name="construct.c.page1.mrdiseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi001
            #add-point:BEFORE FIELD mrdi001 name="construct.b.page1.mrdi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi001
            
            #add-point:AFTER FIELD mrdi001 name="construct.a.page1.mrdi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi001
            #add-point:ON ACTION controlp INFIELD mrdi001 name="construct.c.page1.mrdi001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi002
            #add-point:ON ACTION controlp INFIELD mrdi002 name="construct.c.page1.mrdi002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_11()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdi002  #顯示到畫面上
            NEXT FIELD mrdi002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi002
            #add-point:BEFORE FIELD mrdi002 name="construct.b.page1.mrdi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi002
            
            #add-point:AFTER FIELD mrdi002 name="construct.a.page1.mrdi002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi003
            #add-point:BEFORE FIELD mrdi003 name="construct.b.page1.mrdi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi003
            
            #add-point:AFTER FIELD mrdi003 name="construct.a.page1.mrdi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi003
            #add-point:ON ACTION controlp INFIELD mrdi003 name="construct.c.page1.mrdi003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi004
            #add-point:BEFORE FIELD mrdi004 name="construct.b.page1.mrdi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi004
            
            #add-point:AFTER FIELD mrdi004 name="construct.a.page1.mrdi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi004
            #add-point:ON ACTION controlp INFIELD mrdi004 name="construct.c.page1.mrdi004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi005
            #add-point:BEFORE FIELD mrdi005 name="construct.b.page1.mrdi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi005
            
            #add-point:AFTER FIELD mrdi005 name="construct.a.page1.mrdi005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdi005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi005
            #add-point:ON ACTION controlp INFIELD mrdi005 name="construct.c.page1.mrdi005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi006
            #add-point:BEFORE FIELD mrdi006 name="construct.b.page1.mrdi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi006
            
            #add-point:AFTER FIELD mrdi006 name="construct.a.page1.mrdi006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdi006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi006
            #add-point:ON ACTION controlp INFIELD mrdi006 name="construct.c.page1.mrdi006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdi007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi007
            #add-point:ON ACTION controlp INFIELD mrdi007 name="construct.c.page1.mrdi007"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzza001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdi007  #顯示到畫面上
            NEXT FIELD mrdi007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi007
            #add-point:BEFORE FIELD mrdi007 name="construct.b.page1.mrdi007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi007
            
            #add-point:AFTER FIELD mrdi007 name="construct.a.page1.mrdi007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi008
            #add-point:ON ACTION controlp INFIELD mrdi008 name="construct.c.page1.mrdi008"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdi008  #顯示到畫面上
            NEXT FIELD mrdi008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi008
            #add-point:BEFORE FIELD mrdi008 name="construct.b.page1.mrdi008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi008
            
            #add-point:AFTER FIELD mrdi008 name="construct.a.page1.mrdi008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi009
            #add-point:BEFORE FIELD mrdi009 name="construct.b.page1.mrdi009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi009
            
            #add-point:AFTER FIELD mrdi009 name="construct.a.page1.mrdi009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi009
            #add-point:ON ACTION controlp INFIELD mrdi009 name="construct.c.page1.mrdi009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdisite
            #add-point:BEFORE FIELD mrdisite name="construct.b.page1.mrdisite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdisite
            
            #add-point:AFTER FIELD mrdisite name="construct.a.page1.mrdisite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdisite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdisite
            #add-point:ON ACTION controlp INFIELD mrdisite name="construct.c.page1.mrdisite"
            
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
                  WHEN la_wc[li_idx].tableid = "mrdh_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mrdi_t" 
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
 
{<section id="amrt300.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amrt300_filter()
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
      CONSTRUCT g_wc_filter ON mrdhsite,mrdhdocno,mrdhdocdt,mrdh001,mrdh002,mrdhcrtid,mrdhcrtdt,mrdhmodid, 
          mrdhmoddt
                          FROM s_browse[1].b_mrdhsite,s_browse[1].b_mrdhdocno,s_browse[1].b_mrdhdocdt, 
                              s_browse[1].b_mrdh001,s_browse[1].b_mrdh002,s_browse[1].b_mrdhcrtid,s_browse[1].b_mrdhcrtdt, 
                              s_browse[1].b_mrdhmodid,s_browse[1].b_mrdhmoddt
 
         BEFORE CONSTRUCT
               DISPLAY amrt300_filter_parser('mrdhsite') TO s_browse[1].b_mrdhsite
            DISPLAY amrt300_filter_parser('mrdhdocno') TO s_browse[1].b_mrdhdocno
            DISPLAY amrt300_filter_parser('mrdhdocdt') TO s_browse[1].b_mrdhdocdt
            DISPLAY amrt300_filter_parser('mrdh001') TO s_browse[1].b_mrdh001
            DISPLAY amrt300_filter_parser('mrdh002') TO s_browse[1].b_mrdh002
            DISPLAY amrt300_filter_parser('mrdhcrtid') TO s_browse[1].b_mrdhcrtid
            DISPLAY amrt300_filter_parser('mrdhcrtdt') TO s_browse[1].b_mrdhcrtdt
            DISPLAY amrt300_filter_parser('mrdhmodid') TO s_browse[1].b_mrdhmodid
            DISPLAY amrt300_filter_parser('mrdhmoddt') TO s_browse[1].b_mrdhmoddt
      
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
 
      CALL amrt300_filter_show('mrdhsite')
   CALL amrt300_filter_show('mrdhdocno')
   CALL amrt300_filter_show('mrdhdocdt')
   CALL amrt300_filter_show('mrdh001')
   CALL amrt300_filter_show('mrdh002')
   CALL amrt300_filter_show('mrdhcrtid')
   CALL amrt300_filter_show('mrdhcrtdt')
   CALL amrt300_filter_show('mrdhmodid')
   CALL amrt300_filter_show('mrdhmoddt')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amrt300_filter_parser(ps_field)
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
 
{<section id="amrt300.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amrt300_filter_show(ps_field)
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
   LET ls_condition = amrt300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amrt300_query()
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
   CALL g_mrdi_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amrt300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amrt300_browser_fill("")
      CALL amrt300_fetch("")
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
      CALL amrt300_filter_show('mrdhsite')
   CALL amrt300_filter_show('mrdhdocno')
   CALL amrt300_filter_show('mrdhdocdt')
   CALL amrt300_filter_show('mrdh001')
   CALL amrt300_filter_show('mrdh002')
   CALL amrt300_filter_show('mrdhcrtid')
   CALL amrt300_filter_show('mrdhcrtdt')
   CALL amrt300_filter_show('mrdhmodid')
   CALL amrt300_filter_show('mrdhmoddt')
   CALL amrt300_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amrt300_fetch("F") 
      #顯示單身筆數
      CALL amrt300_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amrt300_fetch(p_flag)
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
   
   LET g_mrdh_m.mrdhdocno = g_browser[g_current_idx].b_mrdhdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amrt300_master_referesh USING g_mrdh_m.mrdhdocno INTO g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt, 
       g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004, 
       g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
       g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
       g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhpstid_desc 
 
   
   #遮罩相關處理
   LET g_mrdh_m_mask_o.* =  g_mrdh_m.*
   CALL amrt300_mrdh_t_mask()
   LET g_mrdh_m_mask_n.* =  g_mrdh_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt300_set_act_visible()   
   CALL amrt300_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL amrt300_set_act_visible()
   CALL amrt300_set_act_no_visible()
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrdh_m_t.* = g_mrdh_m.*
   LET g_mrdh_m_o.* = g_mrdh_m.*
   
   LET g_data_owner = g_mrdh_m.mrdhownid      
   LET g_data_dept  = g_mrdh_m.mrdhowndp
   
   #重新顯示   
   CALL amrt300_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.insert" >}
#+ 資料新增
PRIVATE FUNCTION amrt300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mrdi_d.clear()   
 
 
   INITIALIZE g_mrdh_m.* TO NULL             #DEFAULT 設定
   
   LET g_mrdhdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdh_m.mrdhownid = g_user
      LET g_mrdh_m.mrdhowndp = g_dept
      LET g_mrdh_m.mrdhcrtid = g_user
      LET g_mrdh_m.mrdhcrtdp = g_dept 
      LET g_mrdh_m.mrdhcrtdt = cl_get_current()
      LET g_mrdh_m.mrdhmodid = g_user
      LET g_mrdh_m.mrdhmoddt = cl_get_current()
      LET g_mrdh_m.mrdhstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_mrdh_m.mrdhsite = g_site
      LET g_mrdh_m.mrdhdocdt = g_today
      LET g_mrdh_m.mrdh001 = g_user
      LET g_mrdh_m.mrdh002 = g_dept
      CALL s_desc_get_person_desc(g_mrdh_m.mrdh001) RETURNING g_mrdh_m.mrdh001_desc
      CALL s_desc_get_department_desc(g_mrdh_m.mrdh002) RETURNING g_mrdh_m.mrdh002_desc
      DISPLAY BY NAME g_mrdh_m.mrdh001_desc,g_mrdh_m.mrdh002_desc
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mrdh_m_t.* = g_mrdh_m.*
      LET g_mrdh_m_o.* = g_mrdh_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdh_m.mrdhstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL amrt300_input("a")
      
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
         INITIALIZE g_mrdh_m.* TO NULL
         INITIALIZE g_mrdi_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amrt300_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mrdi_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt300_set_act_visible()   
   CALL amrt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdhent = " ||g_enterprise|| " AND",
                      " mrdhdocno = '", g_mrdh_m.mrdhdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amrt300_cl
   
   CALL amrt300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amrt300_master_referesh USING g_mrdh_m.mrdhdocno INTO g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt, 
       g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004, 
       g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
       g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
       g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhpstid_desc 
 
   
   
   #遮罩相關處理
   LET g_mrdh_m_mask_o.* =  g_mrdh_m.*
   CALL amrt300_mrdh_t_mask()
   LET g_mrdh_m_mask_n.* =  g_mrdh_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh003_desc, 
       g_mrdh_m.mrdh004,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid, 
       g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmodid_desc, 
       g_mrdh_m.mrdhmoddt,g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid, 
       g_mrdh_m.mrdhpstid_desc,g_mrdh_m.mrdhpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mrdh_m.mrdhownid      
   LET g_data_dept  = g_mrdh_m.mrdhowndp
   
   #功能已完成,通報訊息中心
   CALL amrt300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.modify" >}
#+ 資料修改
PRIVATE FUNCTION amrt300_modify()
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
   LET g_mrdh_m_t.* = g_mrdh_m.*
   LET g_mrdh_m_o.* = g_mrdh_m.*
   
   IF g_mrdh_m.mrdhdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
   CALL s_transaction_begin()
   
   OPEN amrt300_cl USING g_enterprise,g_mrdh_m.mrdhdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt300_master_referesh USING g_mrdh_m.mrdhdocno INTO g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt, 
       g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004, 
       g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
       g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
       g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhpstid_desc 
 
   
   #檢查是否允許此動作
   IF NOT amrt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdh_m_mask_o.* =  g_mrdh_m.*
   CALL amrt300_mrdh_t_mask()
   LET g_mrdh_m_mask_n.* =  g_mrdh_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL amrt300_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mrdh_m.mrdhmodid = g_user 
LET g_mrdh_m.mrdhmoddt = cl_get_current()
LET g_mrdh_m.mrdhmodid_desc = cl_get_username(g_mrdh_m.mrdhmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amrt300_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mrdh_t SET (mrdhmodid,mrdhmoddt) = (g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt)
          WHERE mrdhent = g_enterprise AND mrdhdocno = g_mrdhdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mrdh_m.* = g_mrdh_m_t.*
            CALL amrt300_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mrdh_m.mrdhdocno != g_mrdh_m_t.mrdhdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mrdi_t SET mrdidocno = g_mrdh_m.mrdhdocno
 
          WHERE mrdient = g_enterprise AND mrdidocno = g_mrdh_m_t.mrdhdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrdi_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdi_t:",SQLERRMESSAGE 
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
   CALL amrt300_set_act_visible()   
   CALL amrt300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrdhent = " ||g_enterprise|| " AND",
                      " mrdhdocno = '", g_mrdh_m.mrdhdocno, "' "
 
   #填到對應位置
   CALL amrt300_browser_fill("")
 
   CLOSE amrt300_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt300_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amrt300.input" >}
#+ 資料輸入
PRIVATE FUNCTION amrt300_input(p_cmd)
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
   DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh003_desc, 
       g_mrdh_m.mrdh004,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid, 
       g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmodid_desc, 
       g_mrdh_m.mrdhmoddt,g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid, 
       g_mrdh_m.mrdhpstid_desc,g_mrdh_m.mrdhpstdt
   
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
   LET g_forupd_sql = "SELECT mrdiseq,mrdi001,mrdi002,mrdi003,mrdi004,mrdi005,mrdi006,mrdi007,mrdi008, 
       mrdi009,mrdisite FROM mrdi_t WHERE mrdient=? AND mrdidocno=? AND mrdiseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt300_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amrt300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amrt300_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus, 
       g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amrt300.input.head" >}
      #單頭段
      INPUT BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus, 
          g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amrt300_cl USING g_enterprise,g_mrdh_m.mrdhdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amrt300_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL amrt300_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhdocno
            
            #add-point:AFTER FIELD mrdhdocno name="input.a.mrdhdocno"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            CALL s_aooi200_get_slip_desc(g_mrdh_m.mrdhdocno) RETURNING g_mrdh_m.mrdhdocno_desc
            DISPLAY BY NAME g_mrdh_m.mrdhdocno_desc
            IF cl_null(g_mrdh_m.mrdhdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00324'   #單號欄位不可為空！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            ELSE
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrdh_m.mrdhdocno != g_mrdhdocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdh_t WHERE "||"mrdhent = '" ||g_enterprise|| "' AND "||"mrdhdocno = '"||g_mrdh_m.mrdhdocno ||"'",'std-00004',0) THEN 
                     LET g_mrdh_m.mrdhdocno = g_mrdhdocno_t
                     CALL s_aooi200_get_slip_desc(g_mrdh_m.mrdhdocno) RETURNING g_mrdh_m.mrdhdocno_desc
                     DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_mrdh_m.mrdhdocno,g_prog) THEN
                     LET g_mrdh_m.mrdhdocno = g_mrdhdocno_t
                     CALL s_aooi200_get_slip_desc(g_mrdh_m.mrdhdocno) RETURNING g_mrdh_m.mrdhdocno_desc
                     DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_get_slip_desc(g_mrdh_m.mrdhdocno) RETURNING g_mrdh_m.mrdhdocno_desc
                  DISPLAY BY NAME g_mrdh_m.mrdhdocno_desc
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhdocno
            #add-point:BEFORE FIELD mrdhdocno name="input.b.mrdhdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdhdocno
            #add-point:ON CHANGE mrdhdocno name="input.g.mrdhdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhdocdt
            #add-point:BEFORE FIELD mrdhdocdt name="input.b.mrdhdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhdocdt
            
            #add-point:AFTER FIELD mrdhdocdt name="input.a.mrdhdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdhdocdt
            #add-point:ON CHANGE mrdhdocdt name="input.g.mrdhdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh001
            
            #add-point:AFTER FIELD mrdh001 name="input.a.mrdh001"
            CALL s_desc_get_person_desc(g_mrdh_m.mrdh001) RETURNING g_mrdh_m.mrdh001_desc
            DISPLAY BY NAME g_mrdh_m.mrdh001_desc
            IF NOT cl_null(g_mrdh_m.mrdh001) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdh_m.mrdh001 != g_mrdh_m_o.mrdh001 OR
                                                   g_mrdh_m_o.mrdh001 IS NULL)) THEN
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdh_m.mrdh001
                  
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#24  by 07900 --add-end      
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                  #抓取業務人員對應的部門預設到xmdg002
                     SELECT ooag003 INTO g_mrdh_m.mrdh002 FROM ooag_t
                      WHERE ooagent = g_enterprise AND ooag001 = g_mrdh_m.mrdh001
                     CALL s_desc_get_department_desc(g_mrdh_m.mrdh002) RETURNING g_mrdh_m.mrdh002_desc
                     DISPLAY BY NAME g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc
                  ELSE
                     LET g_mrdh_m.mrdh001 = g_mrdh_m_o.mrdh001
                     CALL s_desc_get_person_desc(g_mrdh_m.mrdh001) RETURNING g_mrdh_m.mrdh001_desc
                     DISPLAY BY NAME g_mrdh_m.mrdh001,g_mrdh_m.mrdh001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 
            
            LET g_mrdh_m_o.mrdh001 = g_mrdh_m.mrdh001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh001
            #add-point:BEFORE FIELD mrdh001 name="input.b.mrdh001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdh001
            #add-point:ON CHANGE mrdh001 name="input.g.mrdh001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh002
            
            #add-point:AFTER FIELD mrdh002 name="input.a.mrdh002"
            IF NOT cl_null(g_mrdh_m.mrdh002) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdh_m.mrdh002 != g_mrdh_m_o.mrdh002 OR
                                                   g_mrdh_m_o.mrdh002 IS NULL)) THEN
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdh_m.mrdh002
                  LET g_chkparam.arg2 = g_mrdh_m.mrdhdocdt
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_mrdh_m.mrdh002 = g_mrdh_m_o.mrdh002 
                     CALL s_desc_get_department_desc(g_mrdh_m.mrdh002) RETURNING g_mrdh_m.mrdh002_desc
                     DISPLAY BY NAME g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdh_m.mrdh002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mrdh_m.mrdh002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdh_m.mrdh002_desc
            LET g_mrdh_m_o.mrdh002 = g_mrdh_m.mrdh002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh002
            #add-point:BEFORE FIELD mrdh002 name="input.b.mrdh002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdh002
            #add-point:ON CHANGE mrdh002 name="input.g.mrdh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhstus
            #add-point:BEFORE FIELD mrdhstus name="input.b.mrdhstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhstus
            
            #add-point:AFTER FIELD mrdhstus name="input.a.mrdhstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdhstus
            #add-point:ON CHANGE mrdhstus name="input.g.mrdhstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdhsite
            #add-point:BEFORE FIELD mrdhsite name="input.b.mrdhsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdhsite
            
            #add-point:AFTER FIELD mrdhsite name="input.a.mrdhsite"
#            #應用 a05 樣板自動產生(Version:1)
#            #確認資料無重複
#            IF  NOT cl_null(g_mrdh_m.mrdhsite) AND NOT cl_null(g_mrdh_m.mrdhdocno) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrdh_m.mrdhsite != g_mrdhsite_t  OR g_mrdh_m.mrdhdocno != g_mrdhdocno_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdh_t WHERE "||"mrdhent = '" ||g_enterprise|| "' AND "||"mrdhsite = '"||g_mrdh_m.mrdhsite ||"' AND "|| "mrdhdocno = '"||g_mrdh_m.mrdhdocno ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdhsite
            #add-point:ON CHANGE mrdhsite name="input.g.mrdhsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh003
            
            #add-point:AFTER FIELD mrdh003 name="input.a.mrdh003"
            LET g_mrdh_m.mrdh003_desc = ' '
            LET g_mrdh_m.mrdh004 = ' '
            DISPLAY BY NAME g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdh004
            IF NOT cl_null(g_mrdh_m.mrdh003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdh_m.mrdh003 != g_mrdh_m_o.mrdh003 OR g_mrdh_m_o.mrdh003 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdh_m.mrdh003
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#24  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_mrba001_14") THEN
                     LET g_mrdh_m.mrdh003 = g_mrdh_m_o.mrdh003
                     CALL amrt300_mrdh003_ref()
                     NEXT FIELD CURRENT
                  ELSE
                     CALL amrt300_get_mrdh005_default()
                     LET g_mrdh_m_o.mrdh005 = g_mrdh_m.mrdh005
                     
                     #160524-00044#5 20160720 -----(S) 
                     SELECT mrba034 INTO g_mrdh_m.mrdh006 
                       FROM mrba_t 
                      WHERE mrbaent  = g_enterprise 
                        AND mrbasite = g_mrdh_m.mrdhsite 
                        AND mrba001  = g_mrdh_m.mrdh003 
                     LET g_mrdh_m_o.mrdh006 = g_mrdh_m.mrdh006 
                     DISPLAY BY NAME g_mrdh_m.mrdh006 
                     #160524-00044#5 20160720 -----(E) 
                  END IF
               END IF 
               CALL amrt300_mrdh003_ref()
            END IF
            LET g_mrdh_m_o.mrdh003 = g_mrdh_m.mrdh003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh003
            #add-point:BEFORE FIELD mrdh003 name="input.b.mrdh003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdh003
            #add-point:ON CHANGE mrdh003 name="input.g.mrdh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh005
            #add-point:BEFORE FIELD mrdh005 name="input.b.mrdh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh005
            
            #add-point:AFTER FIELD mrdh005 name="input.a.mrdh005"
            IF NOT cl_null(g_mrdh_m.mrdh005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdh_m.mrdh005 != g_mrdh_m_o.mrdh005 OR g_mrdh_m_o.mrdh005 IS NULL )) THEN
                  IF NOT amrt300_mrdh005_chk() THEN
                     LET g_mrdh_m.mrdh005 = g_mrdh_m_o.mrdh005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mrdh_m_o.mrdh005 = g_mrdh_m.mrdh005
            DISPLAY BY NAME g_mrdh_m.mrdh005
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdh005
            #add-point:ON CHANGE mrdh005 name="input.g.mrdh005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh006
            #add-point:BEFORE FIELD mrdh006 name="input.b.mrdh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh006
            
            #add-point:AFTER FIELD mrdh006 name="input.a.mrdh006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdh006
            #add-point:ON CHANGE mrdh006 name="input.g.mrdh006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdh_m.mrdh007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrdh007
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdh007 name="input.a.mrdh007"
            IF NOT cl_null(g_mrdh_m.mrdh007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh007
            #add-point:BEFORE FIELD mrdh007 name="input.b.mrdh007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdh007
            #add-point:ON CHANGE mrdh007 name="input.g.mrdh007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdh008
            #add-point:BEFORE FIELD mrdh008 name="input.b.mrdh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdh008
            
            #add-point:AFTER FIELD mrdh008 name="input.a.mrdh008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdh008
            #add-point:ON CHANGE mrdh008 name="input.g.mrdh008"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrdhdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhdocno
            #add-point:ON ACTION controlp INFIELD mrdhdocno name="input.c.mrdhdocno"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               AND ooefstus = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdh_m.mrdhdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mrdh_m.mrdhdocno = g_qryparam.return1              
            CALL s_aooi200_get_slip_desc(g_mrdh_m.mrdhdocno) RETURNING g_mrdh_m.mrdhdocno_desc
            DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc
            DISPLAY g_mrdh_m.mrdhdocno TO mrdhdocno              #

            NEXT FIELD mrdhdocno  

            #END add-point
 
 
         #Ctrlp:input.c.mrdhdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhdocdt
            #add-point:ON ACTION controlp INFIELD mrdhdocdt name="input.c.mrdhdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh001
            #add-point:ON ACTION controlp INFIELD mrdh001 name="input.c.mrdh001"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdh_m.mrdh001             #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_mrdh_m.mrdh001 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_mrdh_m.mrdh001) RETURNING g_mrdh_m.mrdh001_desc
#            SELECT ooag002 INTO g_mrdh_m.mrdh002 FROM ooag_t
#             WHERE ooagent = g_enterprise AND ooag001 = g_mrdh_m.mrdh001
#            CALL s_desc_get_department_desc(g_mrdh_m.mrdh002) RETURNING g_mrdh_m.mrdh002_desc
            DISPLAY BY NAME g_mrdh_m.mrdh001_desc#,g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc
            DISPLAY g_mrdh_m.mrdh001 TO mrdh001              #
            NEXT FIELD mrdh001
            #END add-point
 
 
         #Ctrlp:input.c.mrdh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh002
            #add-point:ON ACTION controlp INFIELD mrdh002 name="input.c.mrdh002"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdh_m.mrdh002             #給予default值
            #給予arg            
            LET g_qryparam.arg1 = g_mrdh_m.mrdhdocdt
            CALL q_ooeg001()                                #呼叫開窗
            LET g_mrdh_m.mrdh002 = g_qryparam.return1
            CALL s_desc_get_department_desc(g_mrdh_m.mrdh002) RETURNING g_mrdh_m.mrdh002_desc
            DISPLAY BY NAME g_mrdh_m.mrdh002_desc
            DISPLAY g_mrdh_m.mrdh002 TO mrdh002
            NEXT FIELD mrdh002  
            #END add-point
 
 
         #Ctrlp:input.c.mrdhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhstus
            #add-point:ON ACTION controlp INFIELD mrdhstus name="input.c.mrdhstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdhsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdhsite
            #add-point:ON ACTION controlp INFIELD mrdhsite name="input.c.mrdhsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh003
            #add-point:ON ACTION controlp INFIELD mrdh003 name="input.c.mrdh003"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdh_m.mrdh003             #給予default值

            CALL q_mrba001_11()                                #呼叫開窗

            LET g_mrdh_m.mrdh003 = g_qryparam.return1              

            DISPLAY g_mrdh_m.mrdh003 TO mrdh003              #
            CALL amrt300_mrdh003_ref()
            CALL amrt300_get_mrdh005_default()
            LET g_mrdh_m_o.mrdh005 = g_mrdh_m.mrdh005
            NEXT FIELD mrdh003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrdh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh005
            #add-point:ON ACTION controlp INFIELD mrdh005 name="input.c.mrdh005"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh006
            #add-point:ON ACTION controlp INFIELD mrdh006 name="input.c.mrdh006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh007
            #add-point:ON ACTION controlp INFIELD mrdh007 name="input.c.mrdh007"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdh008
            #add-point:ON ACTION controlp INFIELD mrdh008 name="input.c.mrdh008"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mrdh_m.mrdhdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               IF NOT s_aooi200_chk_slip(g_site,'',g_mrdh_m.mrdhdocno,g_prog) THEN
                  LET g_mrdh_m.mrdhdocno = ''
                  NEXT FIELD mrdhdocno
               END IF

               CALL s_aooi200_gen_docno(g_site,g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt,g_prog) RETURNING l_flag,g_mrdh_m.mrdhdocno
               IF NOT l_flag THEN
                  NEXT FIELD mrdhdocno
               END IF
               #end add-point
               
               INSERT INTO mrdh_t (mrdhent,mrdhdocno,mrdhdocdt,mrdh001,mrdh002,mrdhstus,mrdhsite,mrdh003, 
                   mrdh004,mrdh005,mrdh006,mrdh007,mrdh008,mrdhownid,mrdhowndp,mrdhcrtid,mrdhcrtdp,mrdhcrtdt, 
                   mrdhmodid,mrdhmoddt,mrdhcnfid,mrdhcnfdt,mrdhpstid,mrdhpstdt)
               VALUES (g_enterprise,g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh002, 
                   g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004,g_mrdh_m.mrdh005, 
                   g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
                   g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
                   g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mrdh_m:",SQLERRMESSAGE 
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
                  CALL amrt300_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amrt300_b_fill()
                  CALL amrt300_b_fill2('0')
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
               CALL amrt300_mrdh_t_mask_restore('restore_mask_o')
               
               UPDATE mrdh_t SET (mrdhdocno,mrdhdocdt,mrdh001,mrdh002,mrdhstus,mrdhsite,mrdh003,mrdh004, 
                   mrdh005,mrdh006,mrdh007,mrdh008,mrdhownid,mrdhowndp,mrdhcrtid,mrdhcrtdp,mrdhcrtdt, 
                   mrdhmodid,mrdhmoddt,mrdhcnfid,mrdhcnfdt,mrdhpstid,mrdhpstdt) = (g_mrdh_m.mrdhdocno, 
                   g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite, 
                   g_mrdh_m.mrdh003,g_mrdh_m.mrdh004,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007, 
                   g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp,g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp, 
                   g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt,g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt, 
                   g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt)
                WHERE mrdhent = g_enterprise AND mrdhdocno = g_mrdhdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mrdh_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amrt300_mrdh_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mrdh_m_t)
               LET g_log2 = util.JSON.stringify(g_mrdh_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amrt300.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mrdi_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdi_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mrdi_d.getLength()
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
            OPEN amrt300_cl USING g_enterprise,g_mrdh_m.mrdhdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdi_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdi_d[l_ac].mrdiseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mrdi_d_t.* = g_mrdi_d[l_ac].*  #BACKUP
               LET g_mrdi_d_o.* = g_mrdi_d[l_ac].*  #BACKUP
               CALL amrt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amrt300_set_no_entry_b(l_cmd)
               IF NOT amrt300_lock_b("mrdi_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt300_bcl INTO g_mrdi_d[l_ac].mrdiseq,g_mrdi_d[l_ac].mrdi001,g_mrdi_d[l_ac].mrdi002, 
                      g_mrdi_d[l_ac].mrdi003,g_mrdi_d[l_ac].mrdi004,g_mrdi_d[l_ac].mrdi005,g_mrdi_d[l_ac].mrdi006, 
                      g_mrdi_d[l_ac].mrdi007,g_mrdi_d[l_ac].mrdi008,g_mrdi_d[l_ac].mrdi009,g_mrdi_d[l_ac].mrdisite 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mrdi_d_t.mrdiseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdi_d_mask_o[l_ac].* =  g_mrdi_d[l_ac].*
                  CALL amrt300_mrdi_t_mask()
                  LET g_mrdi_d_mask_n[l_ac].* =  g_mrdi_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt300_show()
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
            INITIALIZE g_mrdi_d[l_ac].* TO NULL 
            INITIALIZE g_mrdi_d_t.* TO NULL 
            INITIALIZE g_mrdi_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(mrdiseq) INTO g_mrdi_d[l_ac].mrdiseq
              FROM mrdi_t
             WHERE mrdient = g_enterprise
               AND mrdisite = g_site
               AND mrdidocno = g_mrdh_m.mrdhdocno
            IF cl_null(g_mrdi_d[l_ac].mrdiseq) THEN
               LET g_mrdi_d[l_ac].mrdiseq = 1
            ELSE
               LET g_mrdi_d[l_ac].mrdiseq = g_mrdi_d[l_ac].mrdiseq + 1
            END IF
            #end add-point
            LET g_mrdi_d_t.* = g_mrdi_d[l_ac].*     #新輸入資料
            LET g_mrdi_d_o.* = g_mrdi_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amrt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdi_d[li_reproduce_target].* = g_mrdi_d[li_reproduce].*
 
               LET g_mrdi_d[li_reproduce_target].mrdiseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_mrdi_d[g_mrdi_d.getLength()].mrdisite = g_site
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
            SELECT COUNT(1) INTO l_count FROM mrdi_t 
             WHERE mrdient = g_enterprise AND mrdidocno = g_mrdh_m.mrdhdocno
 
               AND mrdiseq = g_mrdi_d[l_ac].mrdiseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdh_m.mrdhdocno
               LET gs_keys[2] = g_mrdi_d[g_detail_idx].mrdiseq
               CALL amrt300_insert_b('mrdi_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mrdi_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt300_b_fill()
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
               LET gs_keys[01] = g_mrdh_m.mrdhdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mrdi_d_t.mrdiseq
 
            
               #刪除同層單身
               IF NOT amrt300_delete_b('mrdi_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrt300_key_delete_b(gs_keys,'mrdi_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt300_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mrdi_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdi_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdiseq
            #add-point:BEFORE FIELD mrdiseq name="input.b.page1.mrdiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdiseq
            
            #add-point:AFTER FIELD mrdiseq name="input.a.page1.mrdiseq"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_mrdh_m.mrdhdocno IS NOT NULL AND g_mrdi_d[g_detail_idx].mrdiseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdh_m.mrdhdocno != g_mrdhdocno_t OR g_mrdi_d[g_detail_idx].mrdiseq != g_mrdi_d_t.mrdiseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdi_t WHERE "||"mrdient = '" ||g_enterprise|| "' AND "|| "mrdidocno = '"||g_mrdh_m.mrdhdocno ||"' AND "|| "mrdiseq = '"||g_mrdi_d[g_detail_idx].mrdiseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdiseq
            #add-point:ON CHANGE mrdiseq name="input.g.page1.mrdiseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi001
            #add-point:BEFORE FIELD mrdi001 name="input.b.page1.mrdi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi001
            
            #add-point:AFTER FIELD mrdi001 name="input.a.page1.mrdi001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi001
            #add-point:ON CHANGE mrdi001 name="input.g.page1.mrdi001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi002
            
            #add-point:AFTER FIELD mrdi002 name="input.a.page1.mrdi002"
            IF NOT cl_null(g_mrdi_d[l_ac].mrdi002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrdi_d[l_ac].mrdi002 != g_mrdi_d_o.mrdi002 OR cl_null(g_mrdi_d_o.mrdi002))) THEN
                  IF NOT amrt300_mrdi002_chk(g_mrdi_d[l_ac].mrdi002) THEN
                     LET g_mrdi_d[l_ac].mrdi002 = g_mrdi_d_o.mrdi002
                     CALL amrt300_mrdi002_ref()
                     NEXT FIELD mrdi002
                  END IF
               END IF
            END IF
            LET g_mrdi_d_o.mrdi002 = g_mrdi_d[l_ac].mrdi002
            CALL amrt300_mrdi002_ref()          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi002
            #add-point:BEFORE FIELD mrdi002 name="input.b.page1.mrdi002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi002
            #add-point:ON CHANGE mrdi002 name="input.g.page1.mrdi002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdi_d[l_ac].mrdi003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdi003
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdi003 name="input.a.page1.mrdi003"
            IF NOT cl_null(g_mrdi_d[l_ac].mrdi003) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi003
            #add-point:BEFORE FIELD mrdi003 name="input.b.page1.mrdi003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi003
            #add-point:ON CHANGE mrdi003 name="input.g.page1.mrdi003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdi_d[l_ac].mrdi004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdi004
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdi004 name="input.a.page1.mrdi004"
            IF NOT cl_null(g_mrdi_d[l_ac].mrdi004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi004
            #add-point:BEFORE FIELD mrdi004 name="input.b.page1.mrdi004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi004
            #add-point:ON CHANGE mrdi004 name="input.g.page1.mrdi004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdi_d[l_ac].mrdi005,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdi005
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdi005 name="input.a.page1.mrdi005"
            IF NOT cl_null(g_mrdi_d[l_ac].mrdi005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi005
            #add-point:BEFORE FIELD mrdi005 name="input.b.page1.mrdi005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi005
            #add-point:ON CHANGE mrdi005 name="input.g.page1.mrdi005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi006
            #add-point:BEFORE FIELD mrdi006 name="input.b.page1.mrdi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi006
            
            #add-point:AFTER FIELD mrdi006 name="input.a.page1.mrdi006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi006
            #add-point:ON CHANGE mrdi006 name="input.g.page1.mrdi006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi007
            
            #add-point:AFTER FIELD mrdi007 name="input.a.page1.mrdi007"
            LET g_mrdi_d[l_ac].mrdi007_desc = ''
            DISPLAY BY NAME g_mrdi_d[l_ac].mrdi007_desc
            IF NOT cl_null(g_mrdi_d[l_ac].mrdi007) THEN
               IF g_mrdi_d[l_ac].mrdi007 <> g_mrdi_d_o.mrdi007 OR cl_null(g_mrdi_d_o.mrdi007) THEN
                  IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdi_d[l_ac].mrdi007 != g_mrdi_d_o.mrdi007 OR g_mrdi_d_o.mrdi007 IS NULL )) THEN
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdi_d[l_ac].mrdi007
                     IF NOT cl_chk_exist("v_gzza001_3") THEN
                        LET g_mrdi_d[l_ac].mrdi007 = g_mrdi_d_t.mrdi007
                        CALL amrt300_mrdi007_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL amrt300_mrdi007_ref()
            LET g_mrdi_d_o.mrdi007 = g_mrdi_d[l_ac].mrdi007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi007
            #add-point:BEFORE FIELD mrdi007 name="input.b.page1.mrdi007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi007
            #add-point:ON CHANGE mrdi007 name="input.g.page1.mrdi007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi008
            
            #add-point:AFTER FIELD mrdi008 name="input.a.page1.mrdi008"
            IF NOT cl_null(g_mrdi_d[l_ac].mrdi008) THEN 
               IF g_mrdi_d[l_ac].mrdi008 <> g_mrdi_d_o.mrdi008 OR cl_null(g_mrdi_d_o.mrdi008) THEN
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdi_d[l_ac].mrdi008
                  
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mrba001_7") THEN
                     INITIALIZE g_mrdi_d[l_ac].mrdi008,g_mrdi_d[l_ac].mrdi008_desc TO NULL
                     DISPLAY BY NAME g_mrdi_d[l_ac].mrdi008,g_mrdi_d[l_ac].mrdi008_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL amrt300_mrdi008_ref()
            LET g_mrdi_d_o.mrdi008 = g_mrdi_d[l_ac].mrdi008
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi008
            #add-point:BEFORE FIELD mrdi008 name="input.b.page1.mrdi008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi008
            #add-point:ON CHANGE mrdi008 name="input.g.page1.mrdi008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdi009
            #add-point:BEFORE FIELD mrdi009 name="input.b.page1.mrdi009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdi009
            
            #add-point:AFTER FIELD mrdi009 name="input.a.page1.mrdi009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdi009
            #add-point:ON CHANGE mrdi009 name="input.g.page1.mrdi009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdisite
            #add-point:BEFORE FIELD mrdisite name="input.b.page1.mrdisite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdisite
            
            #add-point:AFTER FIELD mrdisite name="input.a.page1.mrdisite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdisite
            #add-point:ON CHANGE mrdisite name="input.g.page1.mrdisite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrdiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdiseq
            #add-point:ON ACTION controlp INFIELD mrdiseq name="input.c.page1.mrdiseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi001
            #add-point:ON ACTION controlp INFIELD mrdi001 name="input.c.page1.mrdi001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi002
            #add-point:ON ACTION controlp INFIELD mrdi002 name="input.c.page1.mrdi002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdi_d[l_ac].mrdi002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooeg001_11()                                #呼叫開窗

            LET g_mrdi_d[l_ac].mrdi002 = g_qryparam.return1              
            CALL amrt300_mrdi002_ref()
            DISPLAY g_mrdi_d[l_ac].mrdi002 TO mrdi002              #

            NEXT FIELD mrdi002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi003
            #add-point:ON ACTION controlp INFIELD mrdi003 name="input.c.page1.mrdi003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi004
            #add-point:ON ACTION controlp INFIELD mrdi004 name="input.c.page1.mrdi004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi005
            #add-point:ON ACTION controlp INFIELD mrdi005 name="input.c.page1.mrdi005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi006
            #add-point:ON ACTION controlp INFIELD mrdi006 name="input.c.page1.mrdi006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi007
            #add-point:ON ACTION controlp INFIELD mrdi007 name="input.c.page1.mrdi007"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdi_d[l_ac].mrdi007             #給予default值
            LET g_qryparam.default2 = "" #g_mrdi_d[l_ac].oocq002 #應用分類碼
            #給予arg

            CALL q_gzza001_5()                                #呼叫開窗

            LET g_mrdi_d[l_ac].mrdi007 = g_qryparam.return1
            CALL amrt300_mrdi007_ref()
            DISPLAY g_mrdi_d[l_ac].mrdi007 TO mrdi007
            NEXT FIELD mrdi007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi008
            #add-point:ON ACTION controlp INFIELD mrdi008 name="input.c.page1.mrdi008"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdi_d[l_ac].mrdi008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_mrba001_6()                                #呼叫開窗

            LET g_mrdi_d[l_ac].mrdi008 = g_qryparam.return1              

            DISPLAY g_mrdi_d[l_ac].mrdi008 TO mrdi008              #

            NEXT FIELD mrdi008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdi009
            #add-point:ON ACTION controlp INFIELD mrdi009 name="input.c.page1.mrdi009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdisite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdisite
            #add-point:ON ACTION controlp INFIELD mrdisite name="input.c.page1.mrdisite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrdi_d[l_ac].* = g_mrdi_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt300_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mrdi_d[l_ac].mrdiseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrdi_d[l_ac].* = g_mrdi_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amrt300_mrdi_t_mask_restore('restore_mask_o')
      
               UPDATE mrdi_t SET (mrdidocno,mrdiseq,mrdi001,mrdi002,mrdi003,mrdi004,mrdi005,mrdi006, 
                   mrdi007,mrdi008,mrdi009,mrdisite) = (g_mrdh_m.mrdhdocno,g_mrdi_d[l_ac].mrdiseq,g_mrdi_d[l_ac].mrdi001, 
                   g_mrdi_d[l_ac].mrdi002,g_mrdi_d[l_ac].mrdi003,g_mrdi_d[l_ac].mrdi004,g_mrdi_d[l_ac].mrdi005, 
                   g_mrdi_d[l_ac].mrdi006,g_mrdi_d[l_ac].mrdi007,g_mrdi_d[l_ac].mrdi008,g_mrdi_d[l_ac].mrdi009, 
                   g_mrdi_d[l_ac].mrdisite)
                WHERE mrdient = g_enterprise AND mrdidocno = g_mrdh_m.mrdhdocno 
 
                  AND mrdiseq = g_mrdi_d_t.mrdiseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdi_d[l_ac].* = g_mrdi_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdi_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdi_d[l_ac].* = g_mrdi_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdi_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdh_m.mrdhdocno
               LET gs_keys_bak[1] = g_mrdhdocno_t
               LET gs_keys[2] = g_mrdi_d[g_detail_idx].mrdiseq
               LET gs_keys_bak[2] = g_mrdi_d_t.mrdiseq
               CALL amrt300_update_b('mrdi_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amrt300_mrdi_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mrdi_d[g_detail_idx].mrdiseq = g_mrdi_d_t.mrdiseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mrdh_m.mrdhdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mrdi_d_t.mrdiseq
 
                  CALL amrt300_key_update_b(gs_keys,'mrdi_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrdh_m),util.JSON.stringify(g_mrdi_d_t)
               LET g_log2 = util.JSON.stringify(g_mrdh_m),util.JSON.stringify(g_mrdi_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amrt300_unlock_b("mrdi_t","'1'")
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
               LET g_mrdi_d[li_reproduce_target].* = g_mrdi_d[li_reproduce].*
 
               LET g_mrdi_d[li_reproduce_target].mrdiseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdi_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdi_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="amrt300.input.other" >}
      
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
            NEXT FIELD mrdhdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrdiseq
 
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
 
{<section id="amrt300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amrt300_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amrt300_b_fill() #單身填充
      CALL amrt300_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amrt300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_aooi200_get_slip_desc(g_mrdh_m.mrdhdocno) RETURNING g_mrdh_m.mrdhdocno_desc
   CALL amrt300_mrdh003_ref()
   CALL amrt300_mrdi002_ref()
   CALL amrt300_mrdi007_ref()
   CALL amrt300_mrdi008_ref()
   #end add-point
   
   #遮罩相關處理
   LET g_mrdh_m_mask_o.* =  g_mrdh_m.*
   CALL amrt300_mrdh_t_mask()
   LET g_mrdh_m_mask_n.* =  g_mrdh_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh003_desc, 
       g_mrdh_m.mrdh004,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid, 
       g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmodid_desc, 
       g_mrdh_m.mrdhmoddt,g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid, 
       g_mrdh_m.mrdhpstid_desc,g_mrdh_m.mrdhpstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdh_m.mrdhstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mrdi_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL amrt300_mrdi002_ref()
      CALL amrt300_mrdi007_ref()
      CALL amrt300_mrdi008_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amrt300_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amrt300_detail_show()
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
 
{<section id="amrt300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amrt300_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mrdh_t.mrdhdocno 
   DEFINE l_oldno     LIKE mrdh_t.mrdhdocno 
 
   DEFINE l_master    RECORD LIKE mrdh_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mrdi_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_mrdh_m.mrdhdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
    
   LET g_mrdh_m.mrdhdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdh_m.mrdhownid = g_user
      LET g_mrdh_m.mrdhowndp = g_dept
      LET g_mrdh_m.mrdhcrtid = g_user
      LET g_mrdh_m.mrdhcrtdp = g_dept 
      LET g_mrdh_m.mrdhcrtdt = cl_get_current()
      LET g_mrdh_m.mrdhmodid = g_user
      LET g_mrdh_m.mrdhmoddt = cl_get_current()
      LET g_mrdh_m.mrdhstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mrdh_m.mrdhdocdt = g_today
   LET g_mrdh_m.mrdh001 = g_user
   LET g_mrdh_m.mrdh002 = g_dept
   LET g_mrdh_m.mrdhdocno_desc = ''
   CALL s_desc_get_department_desc(g_mrdh_m.mrdh002) RETURNING g_mrdh_m.mrdh002_desc
   CALL s_desc_get_person_desc(g_mrdh_m.mrdh001) RETURNING g_mrdh_m.mrdh001_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdh_m.mrdhstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_mrdh_m.mrdhdocno_desc = ''
   DISPLAY BY NAME g_mrdh_m.mrdhdocno_desc
 
   
   CALL amrt300_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mrdh_m.* TO NULL
      INITIALIZE g_mrdi_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amrt300_show()
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
   CALL amrt300_set_act_visible()   
   CALL amrt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdhent = " ||g_enterprise|| " AND",
                      " mrdhdocno = '", g_mrdh_m.mrdhdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   CALL s_aooi200_get_slip_desc(g_mrdh_m.mrdhdocno) RETURNING g_mrdh_m.mrdhdocno_desc
   DISPLAY BY NAME g_mrdh_m.mrdhdocno_desc
   #end add-point
   
   CALL amrt300_idx_chk()
   
   LET g_data_owner = g_mrdh_m.mrdhownid      
   LET g_data_dept  = g_mrdh_m.mrdhowndp
   
   #功能已完成,通報訊息中心
   CALL amrt300_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amrt300_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mrdi_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amrt300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrdi_t
    WHERE mrdient = g_enterprise AND mrdidocno = g_mrdhdocno_t
 
    INTO TEMP amrt300_detail
 
   #將key修正為調整後   
   UPDATE amrt300_detail 
      #更新key欄位
      SET mrdidocno = g_mrdh_m.mrdhdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mrdi_t SELECT * FROM amrt300_detail
   
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
   DROP TABLE amrt300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amrt300_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_mrdadocno     LIKE mrda_t.mrdadocno
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_mrdh_m.mrdhdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amrt300_cl USING g_enterprise,g_mrdh_m.mrdhdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt300_master_referesh USING g_mrdh_m.mrdhdocno INTO g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt, 
       g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004, 
       g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
       g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
       g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhpstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT amrt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdh_m_mask_o.* =  g_mrdh_m.*
   CALL amrt300_mrdh_t_mask()
   LET g_mrdh_m_mask_n.* =  g_mrdh_m.*
   
   CALL amrt300_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
 
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amrt300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mrdhdocno_t = g_mrdh_m.mrdhdocno
 
 
      DELETE FROM mrdh_t
       WHERE mrdhent = g_enterprise AND mrdhdocno = g_mrdh_m.mrdhdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mrdh_m.mrdhdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #到amrt100尋找單頭資源維修單號有沒有本次刪除的單號,若有,則將amrt100的mrda012清空
      LET l_mrdadocno = ''
      SELECT mrdadocno INTO l_mrdadocno FROM mrda_t
       WHERE mrdaent = g_enterprise
         AND mrda012 = g_mrdh_m.mrdhdocno
      IF NOT cl_null(l_mrdadocno) THEN
         UPDATE mrda_t SET mrda012 = ''
          WHERE mrdaent = g_enterprise
            AND mrdadocno = l_mrdadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_mrdh_m.mrdhdocno 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mrdi_t
       WHERE mrdient = g_enterprise AND mrdidocno = g_mrdh_m.mrdhdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
 
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mrdh_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amrt300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mrdi_d.clear() 
 
     
      CALL amrt300_ui_browser_refresh()  
      #CALL amrt300_ui_headershow()  
      #CALL amrt300_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amrt300_browser_fill("")
         CALL amrt300_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amrt300_cl
 
   #功能已完成,通報訊息中心
   CALL amrt300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amrt300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrt300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mrdi_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amrt300_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrdiseq,mrdi001,mrdi002,mrdi003,mrdi004,mrdi005,mrdi006,mrdi007, 
             mrdi008,mrdi009,mrdisite ,t1.oocql004 ,t2.mrba004 FROM mrdi_t",   
                     " INNER JOIN mrdh_t ON mrdhent = " ||g_enterprise|| " AND mrdhdocno = mrdidocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='221' AND t1.oocql002=mrdi007 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN mrba_t t2 ON t2.mrbaent="||g_enterprise||" AND t2.mrbasite=mrdisite AND t2.mrba001=mrdi008  ",
 
                     " WHERE mrdient=? AND mrdidocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrdi_t.mrdiseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amrt300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mrdh_m.mrdhdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mrdh_m.mrdhdocno INTO g_mrdi_d[l_ac].mrdiseq,g_mrdi_d[l_ac].mrdi001, 
          g_mrdi_d[l_ac].mrdi002,g_mrdi_d[l_ac].mrdi003,g_mrdi_d[l_ac].mrdi004,g_mrdi_d[l_ac].mrdi005, 
          g_mrdi_d[l_ac].mrdi006,g_mrdi_d[l_ac].mrdi007,g_mrdi_d[l_ac].mrdi008,g_mrdi_d[l_ac].mrdi009, 
          g_mrdi_d[l_ac].mrdisite,g_mrdi_d[l_ac].mrdi007_desc,g_mrdi_d[l_ac].mrdi008_desc   #(ver:78) 
 
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
   
   CALL g_mrdi_d.deleteElement(g_mrdi_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amrt300_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mrdi_d.getLength()
      LET g_mrdi_d_mask_o[l_ac].* =  g_mrdi_d[l_ac].*
      CALL amrt300_mrdi_t_mask()
      LET g_mrdi_d_mask_n[l_ac].* =  g_mrdi_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amrt300_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mrdi_t
       WHERE mrdient = g_enterprise AND
         mrdidocno = ps_keys_bak[1] AND mrdiseq = ps_keys_bak[2]
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
         CALL g_mrdi_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amrt300_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mrdi_t
                  (mrdient,
                   mrdidocno,
                   mrdiseq
                   ,mrdi001,mrdi002,mrdi003,mrdi004,mrdi005,mrdi006,mrdi007,mrdi008,mrdi009,mrdisite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mrdi_d[g_detail_idx].mrdi001,g_mrdi_d[g_detail_idx].mrdi002,g_mrdi_d[g_detail_idx].mrdi003, 
                       g_mrdi_d[g_detail_idx].mrdi004,g_mrdi_d[g_detail_idx].mrdi005,g_mrdi_d[g_detail_idx].mrdi006, 
                       g_mrdi_d[g_detail_idx].mrdi007,g_mrdi_d[g_detail_idx].mrdi008,g_mrdi_d[g_detail_idx].mrdi009, 
                       g_mrdi_d[g_detail_idx].mrdisite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mrdi_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amrt300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrdi_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amrt300_mrdi_t_mask_restore('restore_mask_o')
               
      UPDATE mrdi_t 
         SET (mrdidocno,
              mrdiseq
              ,mrdi001,mrdi002,mrdi003,mrdi004,mrdi005,mrdi006,mrdi007,mrdi008,mrdi009,mrdisite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrdi_d[g_detail_idx].mrdi001,g_mrdi_d[g_detail_idx].mrdi002,g_mrdi_d[g_detail_idx].mrdi003, 
                  g_mrdi_d[g_detail_idx].mrdi004,g_mrdi_d[g_detail_idx].mrdi005,g_mrdi_d[g_detail_idx].mrdi006, 
                  g_mrdi_d[g_detail_idx].mrdi007,g_mrdi_d[g_detail_idx].mrdi008,g_mrdi_d[g_detail_idx].mrdi009, 
                  g_mrdi_d[g_detail_idx].mrdisite) 
         WHERE mrdient = g_enterprise AND mrdidocno = ps_keys_bak[1] AND mrdiseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdi_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdi_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt300_mrdi_t_mask_restore('restore_mask_n')
               
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
 
{<section id="amrt300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amrt300_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amrt300_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amrt300_lock_b(ps_table,ps_page)
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
   #CALL amrt300_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mrdi_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amrt300_bcl USING g_enterprise,
                                       g_mrdh_m.mrdhdocno,g_mrdi_d[g_detail_idx].mrdiseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt300_bcl:",SQLERRMESSAGE 
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
 
{<section id="amrt300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amrt300_unlock_b(ps_table,ps_page)
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
      CLOSE amrt300_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amrt300_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mrdhdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrdhdocno",TRUE)
      CALL cl_set_comp_entry("mrdhdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mrdhdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amrt300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrdhdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mrdhdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mrdhdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mrdhdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amrt300_set_entry_b(p_cmd)
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
 
{<section id="amrt300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amrt300_set_no_entry_b(p_cmd)
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
 
{<section id="amrt300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amrt300_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amrt300_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_mrdh_m.mrdhstus NOT MATCHES '[NDR]' THEN  # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
       CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amrt300_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amrt300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amrt300_default_search()
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
      LET ls_wc = ls_wc, " mrdhdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mrdh_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mrdi_t" 
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
   IF NOT cl_null(g_argv[2]) THEN
      LET g_wc = g_wc," AND mrdhsite = '", g_argv[2], "' "
   ELSE
      LET g_wc = " 1=1"
   END IF
   #正常運行時，先顯示查詢方案
   IF NOT cl_null(g_argv[02]) THEN
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt300.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amrt300_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_mrdhcnfdt DATETIME YEAR TO SECOND
   DEFINE l_mrdhmoddt DATETIME YEAR TO SECOND
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_mrdh_m.mrdhstus MATCHES '[XCH]' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mrdh_m.mrdhdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amrt300_cl USING g_enterprise,g_mrdh_m.mrdhdocno
   IF STATUS THEN
      CLOSE amrt300_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt300_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amrt300_master_referesh USING g_mrdh_m.mrdhdocno INTO g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt, 
       g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004, 
       g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
       g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
       g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhpstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT amrt300_action_chk() THEN
      CLOSE amrt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001,g_mrdh_m.mrdh001_desc, 
       g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh003_desc, 
       g_mrdh_m.mrdh004,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid, 
       g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp,g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtid_desc, 
       g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmodid_desc, 
       g_mrdh_m.mrdhmoddt,g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid, 
       g_mrdh_m.mrdhpstid_desc,g_mrdh_m.mrdhpstdt
 
   CASE g_mrdh_m.mrdhstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mrdh_m.mrdhstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)      
      CASE g_mrdh_m.mrdhstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
            
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_mrdh_m.mrdhstus = lc_state OR cl_null(lc_state) THEN
      CLOSE amrt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN amrt300_cl USING g_enterprise,g_mrdh_m.mrdhdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN amrt300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE amrt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   CALL cl_err_collect_init() 
   
   #未確認改確認(N->Y)
   IF lc_state = 'Y' AND g_mrdh_m.mrdhstus = 'N' THEN
      CALL s_amrt300_conf_chk(g_mrdh_m.mrdhdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00108') THEN
            CALL s_amrt300_conf_upd(g_mrdh_m.mrdhdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
#                LET l_mrdhcnfdt = cl_get_current()
#                UPDATE mrdh_t SET mrdhstus = 'Y',
#                                  mrdhcnfdt = l_mrdhcnfdt,
#                                  mrdhcnfid = g_user
#                 WHERE mrdhent = g_enterprise
#                   AND mrdhdocno = g_mrdh_m.mrdhdocno
#                IF SQLCA.sqlcode THEN
#                   INITIALIZE g_errparam TO NULL 
#                   LET g_errparam.extend = g_mrdh_m.mrdhdocno
#                   LET g_errparam.code   = SQLCA.sqlcode
#                   LET g_errparam.popup  = TRUE
#                   CALL cl_err()
#                   CALL s_transaction_end('N','0')
#                ELSE
#                   CALL s_transaction_end('Y','0')
#                END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   #確認改未確認(Y->N)
   IF lc_state = 'N' AND g_mrdh_m.mrdhstus = 'Y' THEN
      CALL s_amrt300_unconf_chk(g_mrdh_m.mrdhdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00110') THEN
            CALL s_amrt300_unconf_upd(g_mrdh_m.mrdhdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
#               UPDATE mrdh_t SET mrdhstus = 'N',
#                                 mrdhcnfdt = '',
#                                 mrdhcnfid = ''
#                WHERE mrdhent = g_enterprise
#                  AND mrdhdocno = g_mrdh_m.mrdhdocno
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = g_mrdh_m.mrdhdocno
#                  LET g_errparam.code   = SQLCA.sqlcode
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()
#                  CALL s_transaction_end('N','0')
#                ELSE
#                   CALL s_transaction_end('Y','0')
#               END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   #未確認改作廢(N->X)
   IF lc_state = 'X' AND g_mrdh_m.mrdhstus = 'N' THEN
      CALL s_amrt300_invalid_chk(g_mrdh_m.mrdhdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00109') THEN
            CALL s_amrt300_invalid_upd(g_mrdh_m.mrdhdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
#               LET l_mrdhmoddt = cl_get_current()
#               UPDATE mrdh_t SET mrdhstus = 'X',
#                                 mrdhmodid = g_user,
#                                 mrdhmoddt = l_mrdhmoddt
#                WHERE mrdhent = g_enterprise
#                  AND mrdhdocno = g_mrdh_m.mrdhdocno
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = g_mrdh_m.mrdhdocno
#                  LET g_errparam.code   = SQLCA.sqlcode
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()
#                  CALL s_transaction_end('N','0')
#                ELSE
#                   CALL s_transaction_end('Y','0')
#               END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_mrdh_m.mrdhmodid = g_user
   LET g_mrdh_m.mrdhmoddt = cl_get_current()
   LET g_mrdh_m.mrdhstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mrdh_t 
      SET (mrdhstus,mrdhmodid,mrdhmoddt) 
        = (g_mrdh_m.mrdhstus,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt)     
    WHERE mrdhent = g_enterprise AND mrdhdocno = g_mrdh_m.mrdhdocno
 
    
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
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE amrt300_master_referesh USING g_mrdh_m.mrdhdocno INTO g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocdt, 
          g_mrdh_m.mrdh001,g_mrdh_m.mrdh002,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite,g_mrdh_m.mrdh003,g_mrdh_m.mrdh004, 
          g_mrdh_m.mrdh005,g_mrdh_m.mrdh006,g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhowndp, 
          g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmoddt, 
          g_mrdh_m.mrdhcnfid,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstdt,g_mrdh_m.mrdh001_desc, 
          g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp_desc, 
          g_mrdh_m.mrdhcrtid_desc,g_mrdh_m.mrdhcrtdp_desc,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhcnfid_desc, 
          g_mrdh_m.mrdhpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mrdh_m.mrdhdocno,g_mrdh_m.mrdhdocno_desc,g_mrdh_m.mrdhdocdt,g_mrdh_m.mrdh001, 
          g_mrdh_m.mrdh001_desc,g_mrdh_m.mrdh002,g_mrdh_m.mrdh002_desc,g_mrdh_m.mrdhstus,g_mrdh_m.mrdhsite, 
          g_mrdh_m.mrdh003,g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdh004,g_mrdh_m.mrdh005,g_mrdh_m.mrdh006, 
          g_mrdh_m.mrdh007,g_mrdh_m.mrdh008,g_mrdh_m.mrdhownid,g_mrdh_m.mrdhownid_desc,g_mrdh_m.mrdhowndp, 
          g_mrdh_m.mrdhowndp_desc,g_mrdh_m.mrdhcrtid,g_mrdh_m.mrdhcrtid_desc,g_mrdh_m.mrdhcrtdp,g_mrdh_m.mrdhcrtdp_desc, 
          g_mrdh_m.mrdhcrtdt,g_mrdh_m.mrdhmodid,g_mrdh_m.mrdhmodid_desc,g_mrdh_m.mrdhmoddt,g_mrdh_m.mrdhcnfid, 
          g_mrdh_m.mrdhcnfid_desc,g_mrdh_m.mrdhcnfdt,g_mrdh_m.mrdhpstid,g_mrdh_m.mrdhpstid_desc,g_mrdh_m.mrdhpstdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amrt300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt300_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amrt300_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mrdi_d.getLength() THEN
         LET g_detail_idx = g_mrdi_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrdi_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrdi_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrt300_b_fill2(pi_idx)
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
   
   CALL amrt300_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amrt300_fill_chk(ps_idx)
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
 
{<section id="amrt300.status_show" >}
PRIVATE FUNCTION amrt300_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amrt300.mask_functions" >}
&include "erp/amr/amrt300_mask.4gl"
 
{</section>}
 
{<section id="amrt300.signature" >}
   
 
{</section>}
 
{<section id="amrt300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amrt300_set_pk_array()
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
   LET g_pk_array[1].values = g_mrdh_m.mrdhdocno
   LET g_pk_array[1].column = 'mrdhdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt300.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amrt300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amrt300_msgcentre_notify(lc_state)
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
   CALL amrt300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrdh_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt300.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amrt300_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#24 add-S
   SELECT mrdhstus  INTO g_mrdh_m.mrdhstus
     FROM mrdh_t
    WHERE mrdhent = g_enterprise
      AND mrdhdocno = g_mrdh_m.mrdhdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mrdh_m.mrdhstus
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
        LET g_errparam.extend = g_mrdh_m.mrdhdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrt300_set_act_visible()
        CALL amrt300_set_act_no_visible()
        CALL amrt300_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#24 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt300.other_function" readonly="Y" >}

PRIVATE FUNCTION amrt300_mrdh003_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_mrdh_m.mrdhsite
   LET g_ref_fields[2] = g_mrdh_m.mrdh003
   CALL ap_ref_array2(g_ref_fields," SELECT mrba004,mrba008 FROM mrba_t WHERE mrbaent = '"||g_enterprise||"' AND mrbasite = ? AND mrba001 = ? ","") RETURNING g_rtn_fields 
   LET g_mrdh_m.mrdh003_desc = g_rtn_fields[1] 
   LET g_mrdh_m.mrdh004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_mrdh_m.mrdh003_desc,g_mrdh_m.mrdh004
END FUNCTION

PRIVATE FUNCTION amrt300_mrdi007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdi_d[l_ac].mrdi007
   CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001= ? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrdi_d[l_ac].mrdi007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdi_d[l_ac].mrdi007_desc 
END FUNCTION

PRIVATE FUNCTION amrt300_mrdi008_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdi_d[l_ac].mrdisite
   LET g_ref_fields[2] = g_mrdi_d[l_ac].mrdi008
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite=? AND mrba001=? ","") RETURNING g_rtn_fields
   LET g_mrdi_d[l_ac].mrdi008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdi_d[l_ac].mrdi008_desc
END FUNCTION

PRIVATE FUNCTION amrt300_mrdi002_chk(p_mrdi002)
DEFINE p_mrdi002      LIKE mrdi_t.mrdi002   
DEFINE l_n            LIKE type_t.num5
DEFINE l_errno        STRING
DEFINE l_errno1       STRING
DEFINE l_errno2       STRING
DEFINE l_pmaastus     LIKE pmaa_t.pmaastus
DEFINE l_ooeg006      LIKE ooeg_t.ooeg006
DEFINE l_ooeg007      LIKE ooeg_t.ooeg007
DEFINE r_success      LIKE type_t.num5

       LET l_n = 0
       LET l_errno = ''
       LET l_errno1 = ''
       LET l_errno2 = ''
       LET r_success = TRUE
       
       #1.輸入值須存在[T:部門資料檔].[C:部門編號] 且為有效資料
       #2.若值不存在，則繼續檢查須存在[T:交易對象主檔].[C:交易對象編號]且[C:交易對象類型]='1' or '3'的有效資料
       #SELECT COUNT(*) INTO l_n FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = p_mrdi002 AND ooegstus = 'Y' AND (ooeg006 <= g_today AND (ooeg007 IS NULL OR ooeg007 > g_today))
       #IF l_n = 0 THEN
       #   SELECT COUNT(*) INTO l_n FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = p_mrdi002 AND pmaastus = 'Y' AND (pmaa002 = '1' OR pmaa002 = '3')
       #   IF l_n = 0 THEN   
       #      LET r_success = FALSE
       #      CALL cl_err(p_mrdi002,'aim-00148',1)
       #      RETURN r_success
       #   END IF
       #END IF
       
       #先判斷是否存在部門資料檔中
       LET l_pmaastus = ''
       LET l_ooeg006 = ''
       LET l_ooeg007 = ''
       SELECT ooegstus,ooeg006,ooeg007 INTO l_pmaastus,l_ooeg006,l_ooeg007 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = p_mrdi002   #AND (ooeg006 <= g_today AND (ooeg007 IS NULL OR ooeg007 > g_today))
       CASE
           WHEN SQLCA.SQLCODE=100   LET l_errno1='aoo-00201'
           WHEN l_pmaastus !='Y'    LET l_errno1='abm-00007'
           WHEN l_ooeg006 > g_today LET l_errno1='aim-00191'
           WHEN l_ooeg007 <= g_today LET l_errno1='aim-00191'
       END CASE
       
       ##如果l_errno為空，說明已存在部門資料檔中，不繼續檢查是否存在供應商資料檔裏面
       IF NOT cl_null(l_errno1) THEN
          LET l_pmaastus = ''
          SELECT pmaastus INTO l_pmaastus FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = p_mrdi002 AND (pmaa002 = '1' OR pmaa002 = '3')
          CASE
              WHEN SQLCA.SQLCODE=100  LET l_errno2='apm-00024'
              WHEN l_pmaastus !='Y'   LET l_errno2='apm-00200'
          END CASE
          
          #輸入的資料既不存在於 部門資料檔 也不存在於交易對象資料檔 中！
          IF l_errno1='aoo-00201' AND l_errno2='apm-00024' THEN
             LET l_errno = 'aim-00148'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_mrdi002
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          #不存在部門資料中，存在供應商中但是不是已確認
          IF l_errno1='aoo-00201' AND l_errno2='apm-00200' THEN
             LET l_errno = 'apm-00200'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_mrdi002
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          #存在部門資料檔中，但是不在有效日期範圍內，不存在供應商中
          IF l_errno1='aim-00191' THEN  #AND l_errno2='apm-00024' THEN
             LET l_errno = 'aim-00191'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_mrdi002
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          #存在部門中的，但是無效，不存在供應商中
          IF l_errno1='abm-00007' THEN  #AND l_errno2='apm-00024' THEN
             LET l_errno = 'sub-01302'  #160318-00005#25 mod  'abm-00007'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_mrdi002
             #160318-00005#25  --add--str
             LET g_errparam.replace[1] ='aooi125'
             LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
             LET g_errparam.exeprog    ='aooi125'
             #160318-00005#25 --add--end
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          ##部門無效，供應商也無效
          #IF l_errno1='abm-00007' THEN  #AND l_errno2='apm-00200' THEN
          #   LET l_errno = 'abm-00007'
          #   LET r_success = FALSE
          #   INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = l_errno
#             LET g_errparam.extend = p_mrdi002
#             LET g_errparam.popup = TRUE
#             CALL cl_err()
          
          #   RETURN r_success
          #END IF
       END IF
              
       RETURN r_success
          
END FUNCTION

PRIVATE FUNCTION amrt300_mrdi002_ref()
DEFINE l_n            LIKE type_t.num5
DEFINE r_mrdi002_desc LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_mrdi_d[l_ac].mrdi002
       LET l_n = 0
       SELECT COUNT(*) INTO l_n FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_mrdi_d[l_ac].mrdi002 AND ooegstus = 'Y' AND (ooeg006 <= g_today AND (ooeg007 IS NULL OR ooeg007 > g_today))
       IF l_n = 0 THEN
          CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       ELSE
          CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       END IF
       
       LET g_mrdi_d[l_ac].mrdi002_desc = g_rtn_fields[1]
       DISPLAY BY NAME g_mrdi_d[l_ac].mrdi002_desc
END FUNCTION

PRIVATE FUNCTION amrt300_get_mrdh005_default()
   
   SELECT mrba006-mrba104 INTO g_mrdh_m.mrdh005
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrbasite = g_mrdh_m.mrdhsite
      AND mrba001 = g_mrdh_m.mrdh003
      
   DISPLAY BY NAME g_mrdh_m.mrdh005
   
END FUNCTION

PRIVATE FUNCTION amrt300_mrdh005_chk()
DEFINE l_max      LIKE mrba_t.mrba006
DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE
   SELECT mrba006-mrba104 INTO l_max
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrbasite = g_mrdh_m.mrdhsite
      AND mrba001 = g_mrdh_m.mrdh003
      
   IF g_mrdh_m.mrdh005 > l_max THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "amr-00100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
