#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-03-22 15:51:55), PR版次:0003(2016-12-20 17:32:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: aglt500
#+ Description: 合併組織股本異動作業
#+ Creator....: 04152(2016-03-18 14:55:16)
#+ Modifier...: 04152 -SD/PR- 08171
 
{</section>}
 
{<section id="aglt500.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#160818-00017#12  2016/08/24 By 07900    删除修改未重新判断状态码
#160824-00007#259 2016/12/20 By 08171    新舊值調整
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
PRIVATE type type_g_gldd_m        RECORD
       glddld LIKE gldd_t.glddld, 
   glddld_desc LIKE type_t.chr80, 
   gldd001 LIKE gldd_t.gldd001, 
   gldd001_desc LIKE type_t.chr80, 
   gldddocno LIKE gldd_t.gldddocno, 
   gldddocno_desc LIKE type_t.chr80, 
   gldddocdt LIKE gldd_t.gldddocdt, 
   ooef001 LIKE ooef_t.ooef001, 
   ooef001_desc LIKE type_t.chr80, 
   gldd002 LIKE gldd_t.gldd002, 
   gldd002_desc LIKE type_t.chr80, 
   glddstus LIKE gldd_t.glddstus, 
   glddownid LIKE gldd_t.glddownid, 
   glddownid_desc LIKE type_t.chr80, 
   glddowndp LIKE gldd_t.glddowndp, 
   glddowndp_desc LIKE type_t.chr80, 
   glddcrtid LIKE gldd_t.glddcrtid, 
   glddcrtid_desc LIKE type_t.chr80, 
   glddcrtdp LIKE gldd_t.glddcrtdp, 
   glddcrtdp_desc LIKE type_t.chr80, 
   glddcrtdt LIKE gldd_t.glddcrtdt, 
   glddmodid LIKE gldd_t.glddmodid, 
   glddmodid_desc LIKE type_t.chr80, 
   glddmoddt LIKE gldd_t.glddmoddt, 
   glddcnfid LIKE gldd_t.glddcnfid, 
   glddcnfid_desc LIKE type_t.chr80, 
   glddcnfdt LIKE gldd_t.glddcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glde_d        RECORD
       gldeseq LIKE glde_t.gldeseq, 
   glde015 LIKE glde_t.glde015, 
   l_name LIKE type_t.chr500, 
   glde001 LIKE glde_t.glde001, 
   glde001_desc LIKE type_t.chr500, 
   glde003 LIKE glde_t.glde003, 
   glde003_desc LIKE type_t.chr500, 
   glde005 LIKE glde_t.glde005, 
   glde007 LIKE glde_t.glde007, 
   glde009 LIKE glde_t.glde009, 
   glde011 LIKE glde_t.glde011, 
   glde013 LIKE glde_t.glde013, 
   l_name2 LIKE type_t.chr500, 
   glde002 LIKE glde_t.glde002, 
   glde002_desc LIKE type_t.chr500, 
   glde004 LIKE glde_t.glde004, 
   glde004_desc LIKE type_t.chr500, 
   glde006 LIKE glde_t.glde006, 
   glde008 LIKE glde_t.glde008, 
   glde010 LIKE glde_t.glde010, 
   glde012 LIKE glde_t.glde012, 
   glde014 LIKE glde_t.glde014
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_glddld LIKE gldd_t.glddld,
      b_gldd001 LIKE gldd_t.gldd001,
      b_gldddocno LIKE gldd_t.gldddocno,
      b_gldddocdt LIKE gldd_t.gldddocdt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa                RECORD
                             glaacomp  LIKE glaa_t.glaacomp,
                             glaa024   LIKE glaa_t.glaa024
                         END RECORD
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gldd_m          type_g_gldd_m
DEFINE g_gldd_m_t        type_g_gldd_m
DEFINE g_gldd_m_o        type_g_gldd_m
DEFINE g_gldd_m_mask_o   type_g_gldd_m #轉換遮罩前資料
DEFINE g_gldd_m_mask_n   type_g_gldd_m #轉換遮罩後資料
 
   DEFINE g_gldddocno_t LIKE gldd_t.gldddocno
 
 
DEFINE g_glde_d          DYNAMIC ARRAY OF type_g_glde_d
DEFINE g_glde_d_t        type_g_glde_d
DEFINE g_glde_d_o        type_g_glde_d
DEFINE g_glde_d_mask_o   DYNAMIC ARRAY OF type_g_glde_d #轉換遮罩前資料
DEFINE g_glde_d_mask_n   DYNAMIC ARRAY OF type_g_glde_d #轉換遮罩後資料
 
 
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
 
{<section id="aglt500.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT glddld,'',gldd001,'',gldddocno,'',gldddocdt,'','',gldd002,'',glddstus, 
       glddownid,'',glddowndp,'',glddcrtid,'',glddcrtdp,'',glddcrtdt,glddmodid,'',glddmoddt,glddcnfid, 
       '',glddcnfdt", 
                      " FROM gldd_t",
                      " WHERE glddent= ? AND gldddocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glddld,t0.gldd001,t0.gldddocno,t0.gldddocdt,t0.gldd002,t0.glddstus, 
       t0.glddownid,t0.glddowndp,t0.glddcrtid,t0.glddcrtdp,t0.glddcrtdt,t0.glddmodid,t0.glddmoddt,t0.glddcnfid, 
       t0.glddcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011",
               " FROM gldd_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.glddownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.glddowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.glddcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.glddcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.glddmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.glddcnfid  ",
 
               " WHERE t0.glddent = " ||g_enterprise|| " AND t0.gldddocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglt500_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglt500 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglt500_init()   
 
      #進入選單 Menu (="N")
      CALL aglt500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglt500
      
   END IF 
   
   CLOSE aglt500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglt500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglt500_init()
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
      CALL cl_set_combo_scc_part('glddstus','13','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glde015','176')
   #end add-point
   
   #初始化搜尋條件
   CALL aglt500_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglt500.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglt500_ui_dialog()
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
            CALL aglt500_insert()
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
         INITIALIZE g_gldd_m.* TO NULL
         CALL g_glde_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglt500_init()
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
               
               CALL aglt500_fetch('') # reload data
               LET l_ac = 1
               CALL aglt500_ui_detailshow() #Setting the current row 
         
               CALL aglt500_idx_chk()
               #NEXT FIELD gldeseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_glde_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aglt500_idx_chk()
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
               CALL aglt500_idx_chk()
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
            CALL aglt500_browser_fill("")
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
               CALL aglt500_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglt500_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aglt500_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aglt500_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aglt500_set_act_visible()   
            CALL aglt500_set_act_no_visible()
            IF NOT (g_gldd_m.gldddocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " glddent = " ||g_enterprise|| " AND",
                                  " gldddocno = '", g_gldd_m.gldddocno, "' "
 
               #填到對應位置
               CALL aglt500_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "gldd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glde_t" 
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
               CALL aglt500_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "gldd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glde_t" 
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
                  CALL aglt500_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aglt500_fetch("F")
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
               CALL aglt500_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglt500_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt500_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglt500_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt500_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglt500_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt500_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglt500_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt500_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglt500_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt500_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_glde_d)
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
               NEXT FIELD gldeseq
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
               CALL aglt500_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aglt500_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aglt500_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglt500_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglt500_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aglt500_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglt500_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglt500_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_gldd_m.gldddocdt)
 
 
 
         
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
 
{<section id="aglt500.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglt500_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT gldddocno ",
                      " FROM gldd_t ",
                      " ",
                      " LEFT JOIN glde_t ON gldeent = glddent AND gldddocno = gldedocno ", "  ",
                      #add-point:browser_fill段sql(glde_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE glddent = " ||g_enterprise|| " AND gldeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gldd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gldddocno ",
                      " FROM gldd_t ", 
                      "  ",
                      "  ",
                      " WHERE glddent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gldd_t")
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
      INITIALIZE g_gldd_m.* TO NULL
      CALL g_glde_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glddld,t0.gldd001,t0.gldddocno,t0.gldddocdt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glddstus,t0.glddld,t0.gldd001,t0.gldddocno,t0.gldddocdt ",
                  " FROM gldd_t t0",
                  "  ",
                  "  LEFT JOIN glde_t ON gldeent = glddent AND gldddocno = gldedocno ", "  ", 
                  #add-point:browser_fill段sql(glde_t1) name="browser_fill.join.glde_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.glddent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("gldd_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glddstus,t0.glddld,t0.gldd001,t0.gldddocno,t0.gldddocdt ",
                  " FROM gldd_t t0",
                  "  ",
                  
                  " WHERE t0.glddent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("gldd_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY gldddocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gldd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_glddld,g_browser[g_cnt].b_gldd001, 
          g_browser[g_cnt].b_gldddocno,g_browser[g_cnt].b_gldddocdt
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
         CALL aglt500_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_gldddocno) THEN
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
 
{<section id="aglt500.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglt500_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gldd_m.gldddocno = g_browser[g_current_idx].b_gldddocno   
 
   EXECUTE aglt500_master_referesh USING g_gldd_m.gldddocno INTO g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid, 
       g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfdt,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddmodid_desc,g_gldd_m.glddcnfid_desc
   
   CALL aglt500_gldd_t_mask()
   CALL aglt500_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aglt500.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglt500_ui_detailshow()
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
 
{<section id="aglt500.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglt500_ui_browser_refresh()
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
      IF g_browser[l_i].b_gldddocno = g_gldd_m.gldddocno 
 
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
 
{<section id="aglt500.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglt500_construct()
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
   INITIALIZE g_gldd_m.* TO NULL
   CALL g_glde_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON glddld,gldd001,gldddocno,gldddocdt,glddstus,glddownid,glddowndp,glddcrtid, 
          glddcrtdp,glddcrtdt,glddmodid,glddmoddt,glddcnfid,glddcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glddcrtdt>>----
         AFTER FIELD glddcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glddmoddt>>----
         AFTER FIELD glddmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glddcnfdt>>----
         AFTER FIELD glddcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glddpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddld
            #add-point:BEFORE FIELD glddld name="construct.b.glddld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddld
            
            #add-point:AFTER FIELD glddld name="construct.a.glddld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glddld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddld
            #add-point:ON ACTION controlp INFIELD glddld name="construct.c.glddld"
            #合併帳別開窗
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO glddld
            NEXT FIELD glddld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldd001
            #add-point:BEFORE FIELD gldd001 name="construct.b.gldd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldd001
            
            #add-point:AFTER FIELD gldd001 name="construct.a.gldd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldd001
            #add-point:ON ACTION controlp INFIELD gldd001 name="construct.c.gldd001"
            #上層公司開窗
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldc001()
            DISPLAY g_qryparam.return1 TO gldd001
            NEXT FIELD gldd001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldddocno
            #add-point:BEFORE FIELD gldddocno name="construct.b.gldddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldddocno
            
            #add-point:AFTER FIELD gldddocno name="construct.a.gldddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldddocno
            #add-point:ON ACTION controlp INFIELD gldddocno name="construct.c.gldddocno"
            #單號開窗
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldddocno()
            DISPLAY g_qryparam.return1 TO gldddocno
            NEXT FIELD gldddocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldddocdt
            #add-point:BEFORE FIELD gldddocdt name="construct.b.gldddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldddocdt
            
            #add-point:AFTER FIELD gldddocdt name="construct.a.gldddocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldddocdt
            #add-point:ON ACTION controlp INFIELD gldddocdt name="construct.c.gldddocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddstus
            #add-point:BEFORE FIELD glddstus name="construct.b.glddstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddstus
            
            #add-point:AFTER FIELD glddstus name="construct.a.glddstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glddstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddstus
            #add-point:ON ACTION controlp INFIELD glddstus name="construct.c.glddstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glddownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddownid
            #add-point:ON ACTION controlp INFIELD glddownid name="construct.c.glddownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO glddownid
            NEXT FIELD glddownid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddownid
            #add-point:BEFORE FIELD glddownid name="construct.b.glddownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddownid
            
            #add-point:AFTER FIELD glddownid name="construct.a.glddownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glddowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddowndp
            #add-point:ON ACTION controlp INFIELD glddowndp name="construct.c.glddowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO glddowndp
            NEXT FIELD glddowndp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddowndp
            #add-point:BEFORE FIELD glddowndp name="construct.b.glddowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddowndp
            
            #add-point:AFTER FIELD glddowndp name="construct.a.glddowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glddcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddcrtid
            #add-point:ON ACTION controlp INFIELD glddcrtid name="construct.c.glddcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO glddcrtid
            NEXT FIELD glddcrtid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddcrtid
            #add-point:BEFORE FIELD glddcrtid name="construct.b.glddcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddcrtid
            
            #add-point:AFTER FIELD glddcrtid name="construct.a.glddcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glddcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddcrtdp
            #add-point:ON ACTION controlp INFIELD glddcrtdp name="construct.c.glddcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO glddcrtdp
            NEXT FIELD glddcrtdp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddcrtdp
            #add-point:BEFORE FIELD glddcrtdp name="construct.b.glddcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddcrtdp
            
            #add-point:AFTER FIELD glddcrtdp name="construct.a.glddcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddcrtdt
            #add-point:BEFORE FIELD glddcrtdt name="construct.b.glddcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glddmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddmodid
            #add-point:ON ACTION controlp INFIELD glddmodid name="construct.c.glddmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO glddmodid
            NEXT FIELD glddmodid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddmodid
            #add-point:BEFORE FIELD glddmodid name="construct.b.glddmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddmodid
            
            #add-point:AFTER FIELD glddmodid name="construct.a.glddmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddmoddt
            #add-point:BEFORE FIELD glddmoddt name="construct.b.glddmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glddcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddcnfid
            #add-point:ON ACTION controlp INFIELD glddcnfid name="construct.c.glddcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO glddcnfid
            NEXT FIELD glddcnfid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddcnfid
            #add-point:BEFORE FIELD glddcnfid name="construct.b.glddcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddcnfid
            
            #add-point:AFTER FIELD glddcnfid name="construct.a.glddcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddcnfdt
            #add-point:BEFORE FIELD glddcnfdt name="construct.b.glddcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gldeseq,glde015,glde001,glde003,glde005,glde007,glde009,glde011,glde013, 
          glde002,glde004,glde006,glde008,glde010,glde012,glde014
           FROM s_detail1[1].gldeseq,s_detail1[1].glde015,s_detail1[1].glde001,s_detail1[1].glde003, 
               s_detail1[1].glde005,s_detail1[1].glde007,s_detail1[1].glde009,s_detail1[1].glde011,s_detail1[1].glde013, 
               s_detail1[1].glde002,s_detail1[1].glde004,s_detail1[1].glde006,s_detail1[1].glde008,s_detail1[1].glde010, 
               s_detail1[1].glde012,s_detail1[1].glde014
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldeseq
            #add-point:BEFORE FIELD gldeseq name="construct.b.page1.gldeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldeseq
            
            #add-point:AFTER FIELD gldeseq name="construct.a.page1.gldeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldeseq
            #add-point:ON ACTION controlp INFIELD gldeseq name="construct.c.page1.gldeseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde015
            #add-point:BEFORE FIELD glde015 name="construct.b.page1.glde015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde015
            
            #add-point:AFTER FIELD glde015 name="construct.a.page1.glde015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde015
            #add-point:ON ACTION controlp INFIELD glde015 name="construct.c.page1.glde015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde001
            #add-point:BEFORE FIELD glde001 name="construct.b.page1.glde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde001
            
            #add-point:AFTER FIELD glde001 name="construct.a.page1.glde001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde001
            #add-point:ON ACTION controlp INFIELD glde001 name="construct.c.page1.glde001"
            #下層公司(異動前)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldc002()
            DISPLAY g_qryparam.return1 TO glde001
            NEXT FIELD glde001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde003
            #add-point:BEFORE FIELD glde003 name="construct.b.page1.glde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde003
            
            #add-point:AFTER FIELD glde003 name="construct.a.page1.glde003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde003
            #add-point:ON ACTION controlp INFIELD glde003 name="construct.c.page1.glde003"
            #帳套(異動前)
            #開窗c段
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO glde003
            NEXT FIELD glde003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde005
            #add-point:BEFORE FIELD glde005 name="construct.b.page1.glde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde005
            
            #add-point:AFTER FIELD glde005 name="construct.a.page1.glde005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde005
            #add-point:ON ACTION controlp INFIELD glde005 name="construct.c.page1.glde005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde007
            #add-point:BEFORE FIELD glde007 name="construct.b.page1.glde007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde007
            
            #add-point:AFTER FIELD glde007 name="construct.a.page1.glde007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde007
            #add-point:ON ACTION controlp INFIELD glde007 name="construct.c.page1.glde007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde009
            #add-point:BEFORE FIELD glde009 name="construct.b.page1.glde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde009
            
            #add-point:AFTER FIELD glde009 name="construct.a.page1.glde009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde009
            #add-point:ON ACTION controlp INFIELD glde009 name="construct.c.page1.glde009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde011
            #add-point:BEFORE FIELD glde011 name="construct.b.page1.glde011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde011
            
            #add-point:AFTER FIELD glde011 name="construct.a.page1.glde011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde011
            #add-point:ON ACTION controlp INFIELD glde011 name="construct.c.page1.glde011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde013
            #add-point:BEFORE FIELD glde013 name="construct.b.page1.glde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde013
            
            #add-point:AFTER FIELD glde013 name="construct.a.page1.glde013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde013
            #add-point:ON ACTION controlp INFIELD glde013 name="construct.c.page1.glde013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde002
            #add-point:BEFORE FIELD glde002 name="construct.b.page1.glde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde002
            
            #add-point:AFTER FIELD glde002 name="construct.a.page1.glde002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde002
            #add-point:ON ACTION controlp INFIELD glde002 name="construct.c.page1.glde002"
            #下層公司(異動後)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldc002()
            DISPLAY g_qryparam.return1 TO glde002
            NEXT FIELD glde002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde004
            #add-point:BEFORE FIELD glde004 name="construct.b.page1.glde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde004
            
            #add-point:AFTER FIELD glde004 name="construct.a.page1.glde004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde004
            #add-point:ON ACTION controlp INFIELD glde004 name="construct.c.page1.glde004"
            #帳套(異動後)
            #開窗c段
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO glde004
            NEXT FIELD glde004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde006
            #add-point:BEFORE FIELD glde006 name="construct.b.page1.glde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde006
            
            #add-point:AFTER FIELD glde006 name="construct.a.page1.glde006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde006
            #add-point:ON ACTION controlp INFIELD glde006 name="construct.c.page1.glde006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde008
            #add-point:BEFORE FIELD glde008 name="construct.b.page1.glde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde008
            
            #add-point:AFTER FIELD glde008 name="construct.a.page1.glde008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde008
            #add-point:ON ACTION controlp INFIELD glde008 name="construct.c.page1.glde008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde010
            #add-point:BEFORE FIELD glde010 name="construct.b.page1.glde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde010
            
            #add-point:AFTER FIELD glde010 name="construct.a.page1.glde010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde010
            #add-point:ON ACTION controlp INFIELD glde010 name="construct.c.page1.glde010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde012
            #add-point:BEFORE FIELD glde012 name="construct.b.page1.glde012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde012
            
            #add-point:AFTER FIELD glde012 name="construct.a.page1.glde012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde012
            #add-point:ON ACTION controlp INFIELD glde012 name="construct.c.page1.glde012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde014
            #add-point:BEFORE FIELD glde014 name="construct.b.page1.glde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde014
            
            #add-point:AFTER FIELD glde014 name="construct.a.page1.glde014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glde014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde014
            #add-point:ON ACTION controlp INFIELD glde014 name="construct.c.page1.glde014"
            
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
                  WHEN la_wc[li_idx].tableid = "gldd_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "glde_t" 
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
 
{<section id="aglt500.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aglt500_filter()
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
      CONSTRUCT g_wc_filter ON glddld,gldd001,gldddocno,gldddocdt
                          FROM s_browse[1].b_glddld,s_browse[1].b_gldd001,s_browse[1].b_gldddocno,s_browse[1].b_gldddocdt 
 
 
         BEFORE CONSTRUCT
               DISPLAY aglt500_filter_parser('glddld') TO s_browse[1].b_glddld
            DISPLAY aglt500_filter_parser('gldd001') TO s_browse[1].b_gldd001
            DISPLAY aglt500_filter_parser('gldddocno') TO s_browse[1].b_gldddocno
            DISPLAY aglt500_filter_parser('gldddocdt') TO s_browse[1].b_gldddocdt
      
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
 
      CALL aglt500_filter_show('glddld')
   CALL aglt500_filter_show('gldd001')
   CALL aglt500_filter_show('gldddocno')
   CALL aglt500_filter_show('gldddocdt')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aglt500_filter_parser(ps_field)
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
 
{<section id="aglt500.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aglt500_filter_show(ps_field)
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
   LET ls_condition = aglt500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglt500_query()
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
   CALL g_glde_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aglt500_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglt500_browser_fill("")
      CALL aglt500_fetch("")
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
      CALL aglt500_filter_show('glddld')
   CALL aglt500_filter_show('gldd001')
   CALL aglt500_filter_show('gldddocno')
   CALL aglt500_filter_show('gldddocdt')
   CALL aglt500_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aglt500_fetch("F") 
      #顯示單身筆數
      CALL aglt500_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglt500_fetch(p_flag)
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
   
   LET g_gldd_m.gldddocno = g_browser[g_current_idx].b_gldddocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglt500_master_referesh USING g_gldd_m.gldddocno INTO g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid, 
       g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfdt,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddmodid_desc,g_gldd_m.glddcnfid_desc
   
   #遮罩相關處理
   LET g_gldd_m_mask_o.* =  g_gldd_m.*
   CALL aglt500_gldd_t_mask()
   LET g_gldd_m_mask_n.* =  g_gldd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt500_set_act_visible()   
   CALL aglt500_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gldd_m_t.* = g_gldd_m.*
   LET g_gldd_m_o.* = g_gldd_m.*
   
   LET g_data_owner = g_gldd_m.glddownid      
   LET g_data_dept  = g_gldd_m.glddowndp
   
   #重新顯示   
   CALL aglt500_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglt500_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_glde_d.clear()   
 
 
   INITIALIZE g_gldd_m.* TO NULL             #DEFAULT 設定
   
   LET g_gldddocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gldd_m.glddownid = g_user
      LET g_gldd_m.glddowndp = g_dept
      LET g_gldd_m.glddcrtid = g_user
      LET g_gldd_m.glddcrtdp = g_dept 
      LET g_gldd_m.glddcrtdt = cl_get_current()
      LET g_gldd_m.glddmodid = g_user
      LET g_gldd_m.glddmoddt = cl_get_current()
      LET g_gldd_m.glddstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_gldd_m.gldddocdt = g_today       #單據日期
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gldd_m_t.* = g_gldd_m.*
      LET g_gldd_m_o.* = g_gldd_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gldd_m.glddstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aglt500_input("a")
      
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
         INITIALIZE g_gldd_m.* TO NULL
         INITIALIZE g_glde_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aglt500_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_glde_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt500_set_act_visible()   
   CALL aglt500_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gldddocno_t = g_gldd_m.gldddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " glddent = " ||g_enterprise|| " AND",
                      " gldddocno = '", g_gldd_m.gldddocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aglt500_cl
   
   CALL aglt500_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglt500_master_referesh USING g_gldd_m.gldddocno INTO g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid, 
       g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfdt,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddmodid_desc,g_gldd_m.glddcnfid_desc
   
   
   #遮罩相關處理
   LET g_gldd_m_mask_o.* =  g_gldd_m.*
   CALL aglt500_gldd_t_mask()
   LET g_gldd_m_mask_n.* =  g_gldd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc,g_gldd_m.gldd001,g_gldd_m.gldd001_desc,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocno_desc,g_gldd_m.gldddocdt,g_gldd_m.ooef001,g_gldd_m.ooef001_desc,g_gldd_m.gldd002, 
       g_gldd_m.gldd002_desc,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp, 
       g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmodid_desc,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfid_desc,g_gldd_m.glddcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gldd_m.glddownid      
   LET g_data_dept  = g_gldd_m.glddowndp
   
   #功能已完成,通報訊息中心
   CALL aglt500_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglt500_modify()
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
   LET g_gldd_m_t.* = g_gldd_m.*
   LET g_gldd_m_o.* = g_gldd_m.*
   
   IF g_gldd_m.gldddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gldddocno_t = g_gldd_m.gldddocno
 
   CALL s_transaction_begin()
   
   OPEN aglt500_cl USING g_enterprise,g_gldd_m.gldddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aglt500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt500_master_referesh USING g_gldd_m.gldddocno INTO g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid, 
       g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfdt,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddmodid_desc,g_gldd_m.glddcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aglt500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gldd_m_mask_o.* =  g_gldd_m.*
   CALL aglt500_gldd_t_mask()
   LET g_gldd_m_mask_n.* =  g_gldd_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aglt500_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_gldddocno_t = g_gldd_m.gldddocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gldd_m.glddmodid = g_user 
LET g_gldd_m.glddmoddt = cl_get_current()
LET g_gldd_m.glddmodid_desc = cl_get_username(g_gldd_m.glddmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_gldd_m.glddstus MATCHES "[DR]" THEN
         LET g_gldd_m.glddstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aglt500_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gldd_t SET (glddmodid,glddmoddt) = (g_gldd_m.glddmodid,g_gldd_m.glddmoddt)
          WHERE glddent = g_enterprise AND gldddocno = g_gldddocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gldd_m.* = g_gldd_m_t.*
            CALL aglt500_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gldd_m.gldddocno != g_gldd_m_t.gldddocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE glde_t SET gldedocno = g_gldd_m.gldddocno
 
          WHERE gldeent = g_enterprise AND gldedocno = g_gldd_m_t.gldddocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "glde_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glde_t:",SQLERRMESSAGE 
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
   CALL aglt500_set_act_visible()   
   CALL aglt500_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glddent = " ||g_enterprise|| " AND",
                      " gldddocno = '", g_gldd_m.gldddocno, "' "
 
   #填到對應位置
   CALL aglt500_browser_fill("")
 
   CLOSE aglt500_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt500_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aglt500.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglt500_input(p_cmd)
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
   DEFINE  l_flag                LIKE type_t.chr1
   DEFINE  l_glde_flag           LIKE type_t.chr1
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
   DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc,g_gldd_m.gldd001,g_gldd_m.gldd001_desc,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocno_desc,g_gldd_m.gldddocdt,g_gldd_m.ooef001,g_gldd_m.ooef001_desc,g_gldd_m.gldd002, 
       g_gldd_m.gldd002_desc,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp, 
       g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmodid_desc,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfid_desc,g_gldd_m.glddcnfdt
   
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
   LET g_forupd_sql = "SELECT gldeseq,glde015,glde001,glde003,glde005,glde007,glde009,glde011,glde013, 
       glde002,glde004,glde006,glde008,glde010,glde012,glde014 FROM glde_t WHERE gldeent=? AND gldedocno=?  
       AND gldeseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt500_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglt500_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aglt500_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno,g_gldd_m.gldddocdt,g_gldd_m.glddstus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_glde_flag = 'N'
   LET g_errshow = 1
   WHILE TRUE
      LET l_flag = 'N'
      IF l_glde_flag = 'Y' THEN
         CALL s_transaction_begin()
      END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglt500.input.head" >}
      #單頭段
      INPUT BY NAME g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno,g_gldd_m.gldddocdt,g_gldd_m.glddstus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aglt500_cl USING g_enterprise,g_gldd_m.gldddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aglt500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aglt500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aglt500_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            NEXT FIELD glddld
            #end add-point
            CALL aglt500_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddld
            
            #add-point:AFTER FIELD glddld name="input.a.glddld"
            #合併帳別
            IF NOT cl_null(g_gldd_m.glddld) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldd_m.glddld != g_gldd_m_t.glddld OR g_gldd_m_t.glddld IS NULL )) THEN #160824-00007#259 161220 By 08171 mark
               IF cl_null(g_gldd_m_o.glddld) OR g_gldd_m.glddld != g_gldd_m_o.glddld THEN #160824-00007#259 161220 By 08171 add
                  CALL s_merge_ld_with_comp_chk(g_gldd_m.glddld,g_gldd_m.gldd001,g_user,1)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldd_m.glddld = g_gldd_m_t.glddld #160824-00007#259 161220 By 08171 mark
                     LET g_gldd_m.glddld = g_gldd_m_o.glddld #160824-00007#259 161220 By 08171 add
                     CALL s_desc_get_ld_desc(g_gldd_m.glddld) RETURNING g_gldd_m.glddld_desc
                     DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_gldd_m.gldd001) THEN
                     CALL aglt500_before_chk(g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocdt) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00432'
                        LET g_errparam.replace[1] = g_gldd_m.gldddocdt
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldd_m.glddld = g_gldd_m_t.glddld #160824-00007#259 161220 By 08171 mark
                        LET g_gldd_m.glddld = g_gldd_m_o.glddld #160824-00007#259 161220 By 08171 add
                        LET g_gldd_m.gldd001_desc = s_desc_glda001_desc(g_gldd_m.gldd001)
                        DISPLAY BY NAME g_gldd_m.gldd001,g_gldd_m.gldd001_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #LET g_gldd_m_t.glddld = g_gldd_m.glddld #160824-00007#259 161220 By 08171 mark
                  CALL aglt500_set_ld_info(g_gldd_m.glddld)
               END IF
            END IF
            CALL s_desc_get_ld_desc(g_gldd_m.glddld) RETURNING g_gldd_m.glddld_desc
            DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc
            LET g_gldd_m_o.* = g_gldd_m.* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddld
            #add-point:BEFORE FIELD glddld name="input.b.glddld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glddld
            #add-point:ON CHANGE glddld name="input.g.glddld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldd001
            
            #add-point:AFTER FIELD gldd001 name="input.a.gldd001"
            #上層公司
            IF NOT cl_null(g_gldd_m.gldd001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldd_m.gldd001 != g_gldd_m_t.gldd001 OR g_gldd_m_t.gldd001 IS NULL )) THEN #160824-00007#259 161220 By 08171 mark
               IF cl_null(g_gldd_m_o.gldd001) OR g_gldd_m.gldd001 != g_gldd_m_o.gldd001 THEN #160824-00007#259 161220 By 08171 add
                  CALL s_merge_ld_with_comp_chk(g_gldd_m.glddld,g_gldd_m.gldd001,g_user,1) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldd_m.gldd001 = g_gldd_m_t.gldd001 #160824-00007#259 161220 By 08171 mark
                     LET g_gldd_m.gldd001 = g_gldd_m_o.gldd001 #160824-00007#259 161220 By 08171 add
                     LET g_gldd_m.gldd001_desc = s_desc_glda001_desc(g_gldd_m.gldd001)
                     DISPLAY BY NAME g_gldd_m.gldd001,g_gldd_m.gldd001_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL aglt500_before_chk(g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocdt) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00432'
                     LET g_errparam.replace[1] = g_gldd_m.gldddocdt
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldd_m.gldd001 = g_gldd_m_t.gldd001 #160824-00007#259 161220 By 08171 mark
                     LET g_gldd_m.gldd001 = g_gldd_m_o.gldd001 #160824-00007#259 161220 By 08171 add
                     LET g_gldd_m.gldd001_desc = s_desc_glda001_desc(g_gldd_m.gldd001)
                     DISPLAY BY NAME g_gldd_m.gldd001,g_gldd_m.gldd001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #LET g_gldd_m_t.gldd001 = g_gldd_m.gldd001 #160824-00007#259 161220 By 08171 mark
                  #抓取該上層公司的帳別
                  CALL s_merge_get_gl_ld(g_gldd_m.glddld,g_gldd_m.gldd001) RETURNING g_gldd_m.gldd002
                  CALL s_desc_get_ld_desc(g_gldd_m.gldd002) RETURNING g_gldd_m.gldd002_desc
                  DISPLAY BY NAME g_gldd_m.gldd002,g_gldd_m.gldd002_desc
               END IF
            END IF
            LET g_gldd_m.gldd001_desc = s_desc_glda001_desc(g_gldd_m.gldd001)
            DISPLAY BY NAME g_gldd_m.gldd001,g_gldd_m.gldd001_desc
            LET g_gldd_m_o.* = g_gldd_m.* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldd001
            #add-point:BEFORE FIELD gldd001 name="input.b.gldd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldd001
            #add-point:ON CHANGE gldd001 name="input.g.gldd001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldddocno
            
            #add-point:AFTER FIELD gldddocno name="input.a.gldddocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_gldd_m.gldddocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldd_m.gldddocno != g_gldddocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldd_t WHERE "||"glddent = '" ||g_enterprise|| "' AND "||"gldddocno = '"||g_gldd_m.gldddocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_gldd_m.gldddocno) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldd_m.gldddocno != g_gldddocno_t )) THEN
                  IF NOT s_aooi200_fin_chk_docno(g_gldd_m.glddld,'','',g_gldd_m.gldddocno,g_gldd_m.gldddocdt,g_prog) THEN
                     LET g_gldd_m.gldddocno = g_gldddocno_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_gldd_m.gldddocno) RETURNING g_gldd_m.gldddocno_desc
            DISPLAY BY NAME g_gldd_m.gldddocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldddocno
            #add-point:BEFORE FIELD gldddocno name="input.b.gldddocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldddocno
            #add-point:ON CHANGE gldddocno name="input.g.gldddocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldddocdt
            #add-point:BEFORE FIELD gldddocdt name="input.b.gldddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldddocdt
            
            #add-point:AFTER FIELD gldddocdt name="input.a.gldddocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldddocdt
            #add-point:ON CHANGE gldddocdt name="input.g.gldddocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glddstus
            #add-point:BEFORE FIELD glddstus name="input.b.glddstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glddstus
            
            #add-point:AFTER FIELD glddstus name="input.a.glddstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glddstus
            #add-point:ON CHANGE glddstus name="input.g.glddstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glddld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddld
            #add-point:ON ACTION controlp INFIELD glddld name="input.c.glddld"
            #合併帳別
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldd_m.glddld
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #為上層帳套
            LET g_qryparam.where = " glaald IN (SELECT gldbld FROM gldb_t ",
                                   "  WHERE gldbstus = 'Y' ",  
                                   "    AND gldbent = '",g_enterprise,"') "
            CALL q_authorised_ld()
            LET g_gldd_m.glddld = g_qryparam.return1
            LET g_gldd_m.glddld_desc = s_desc_get_ld_desc(g_gldd_m.glddld)
            DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc
            NEXT FIELD glddld
            #END add-point
 
 
         #Ctrlp:input.c.gldd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldd001
            #add-point:ON ACTION controlp INFIELD gldd001 name="input.c.gldd001"
            #上層公司
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldd_m.gldd001
            LET g_qryparam.where = "gldc009 = 'Y' AND gldbstus = 'Y' AND gldcld = '",g_gldd_m.glddld,"'"
            CALL q_gldc001()
            LET g_gldd_m.gldd001 = g_qryparam.return1
            LET g_gldd_m.gldd001_desc = s_desc_glda001_desc(g_gldd_m.gldd001)
            DISPLAY BY NAME g_gldd_m.gldd001,g_gldd_m.gldd001_desc
            NEXT FIELD gldd001
            #END add-point
 
 
         #Ctrlp:input.c.gldddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldddocno
            #add-point:ON ACTION controlp INFIELD gldddocno name="input.c.gldddocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldd_m.gldddocno
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()
            LET g_gldd_m.gldddocno = g_qryparam.return1
            IF NOT cl_null(g_gldd_m.gldddocno) THEN
               CALL s_aooi200_fin_get_slip_desc(g_gldd_m.gldddocno) RETURNING g_gldd_m.gldddocno_desc
               DISPLAY BY NAME g_gldd_m.gldddocno_desc
            END IF
            DISPLAY BY NAME g_gldd_m.gldddocno
            NEXT FIELD gldddocno
            #END add-point
 
 
         #Ctrlp:input.c.gldddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldddocdt
            #add-point:ON ACTION controlp INFIELD gldddocdt name="input.c.gldddocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.glddstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glddstus
            #add-point:ON ACTION controlp INFIELD glddstus name="input.c.glddstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gldd_m.gldddocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #新增前才取單號
               CALL s_aooi200_fin_gen_docno(g_gldd_m.glddld,'','',g_gldd_m.gldddocno,g_gldd_m.gldddocdt,g_prog)
                    RETURNING g_sub_success,g_gldd_m.gldddocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_gldd_m.gldddocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD gldddocno
               END IF
               DISPLAY BY NAME g_gldd_m.gldddocno
               #end add-point
               
               INSERT INTO gldd_t (glddent,glddld,gldd001,gldddocno,gldddocdt,gldd002,glddstus,glddownid, 
                   glddowndp,glddcrtid,glddcrtdp,glddcrtdt,glddmodid,glddmoddt,glddcnfid,glddcnfdt)
               VALUES (g_enterprise,g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno,g_gldd_m.gldddocdt, 
                   g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid, 
                   g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
                   g_gldd_m.glddcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gldd_m:",SQLERRMESSAGE 
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
                  CALL aglt500_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aglt500_b_fill()
                  CALL aglt500_b_fill2('0')
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
               CALL aglt500_gldd_t_mask_restore('restore_mask_o')
               
               UPDATE gldd_t SET (glddld,gldd001,gldddocno,gldddocdt,gldd002,glddstus,glddownid,glddowndp, 
                   glddcrtid,glddcrtdp,glddcrtdt,glddmodid,glddmoddt,glddcnfid,glddcnfdt) = (g_gldd_m.glddld, 
                   g_gldd_m.gldd001,g_gldd_m.gldddocno,g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus, 
                   g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid,g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt, 
                   g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid,g_gldd_m.glddcnfdt)
                WHERE glddent = g_enterprise AND gldddocno = g_gldddocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gldd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aglt500_gldd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gldd_m_t)
               LET g_log2 = util.JSON.stringify(g_gldd_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gldddocno_t = g_gldd_m.gldddocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aglt500.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_glde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglt500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_glde_d.getLength()
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
            OPEN aglt500_cl USING g_enterprise,g_gldd_m.gldddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aglt500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aglt500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_glde_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_glde_d[l_ac].gldeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glde_d_t.* = g_glde_d[l_ac].*  #BACKUP
               LET g_glde_d_o.* = g_glde_d[l_ac].*  #BACKUP
               CALL aglt500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aglt500_set_no_entry_b(l_cmd)
               IF NOT aglt500_lock_b("glde_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglt500_bcl INTO g_glde_d[l_ac].gldeseq,g_glde_d[l_ac].glde015,g_glde_d[l_ac].glde001, 
                      g_glde_d[l_ac].glde003,g_glde_d[l_ac].glde005,g_glde_d[l_ac].glde007,g_glde_d[l_ac].glde009, 
                      g_glde_d[l_ac].glde011,g_glde_d[l_ac].glde013,g_glde_d[l_ac].glde002,g_glde_d[l_ac].glde004, 
                      g_glde_d[l_ac].glde006,g_glde_d[l_ac].glde008,g_glde_d[l_ac].glde010,g_glde_d[l_ac].glde012, 
                      g_glde_d[l_ac].glde014
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glde_d_t.gldeseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glde_d_mask_o[l_ac].* =  g_glde_d[l_ac].*
                  CALL aglt500_glde_t_mask()
                  LET g_glde_d_mask_n[l_ac].* =  g_glde_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aglt500_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL aglt500_set_glde_entry(g_glde_d[l_ac].glde015)
            CALL s_fin_get_colname('aglt500',"l_name1") RETURNING g_glde_d[l_ac].l_name
            CALL s_fin_get_colname('aglt500',"l_name2") RETURNING g_glde_d[l_ac].l_name2
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
            INITIALIZE g_glde_d[l_ac].* TO NULL 
            INITIALIZE g_glde_d_t.* TO NULL 
            INITIALIZE g_glde_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_glde_d[l_ac].glde005 = "0"
      LET g_glde_d[l_ac].glde007 = "N"
      LET g_glde_d[l_ac].glde009 = "0"
      LET g_glde_d[l_ac].glde011 = "0"
      LET g_glde_d[l_ac].glde006 = "0"
      LET g_glde_d[l_ac].glde008 = "N"
      LET g_glde_d[l_ac].glde010 = "0"
      LET g_glde_d[l_ac].glde012 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #項次
            IF l_cmd = 'a' AND cl_null(g_glde_d[l_ac].gldeseq) THEN
               SELECT MAX(gldeseq)+1 INTO g_glde_d[l_ac].gldeseq
                 FROM glde_t
                WHERE gldeent = g_enterprise
                  AND gldedocno = g_gldd_m.gldddocno
               IF cl_null(g_glde_d[l_ac].gldeseq) THEN LET g_glde_d[l_ac].gldeseq = 1 END IF  
            END IF
            LET g_glde_d[l_ac].glde015 = "I"
            LET g_glde_d[l_ac].glde013 = g_today
            CALL aglt500_set_glde_entry(g_glde_d[l_ac].glde015)
            CALL s_fin_get_colname('aglt500',"l_name1") RETURNING g_glde_d[l_ac].l_name
            CALL s_fin_get_colname('aglt500',"l_name2") RETURNING g_glde_d[l_ac].l_name2
            #end add-point
            LET g_glde_d_t.* = g_glde_d[l_ac].*     #新輸入資料
            LET g_glde_d_o.* = g_glde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglt500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aglt500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glde_d[li_reproduce_target].* = g_glde_d[li_reproduce].*
 
               LET g_glde_d[li_reproduce_target].gldeseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM glde_t 
             WHERE gldeent = g_enterprise AND gldedocno = g_gldd_m.gldddocno
 
               AND gldeseq = g_glde_d[l_ac].gldeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               IF g_glde_d[l_ac].glde015 = "I" THEN
                  #異動後 = 異動前
                  LET g_glde_d[l_ac].glde002 = g_glde_d[l_ac].glde001   #下層公司
                  LET g_glde_d[l_ac].glde004 = g_glde_d[l_ac].glde003   #帳套
                  LET g_glde_d[l_ac].glde006 = g_glde_d[l_ac].glde005   #持股比率%
                  LET g_glde_d[l_ac].glde008 = g_glde_d[l_ac].glde007   #納入合併否
                  LET g_glde_d[l_ac].glde010 = g_glde_d[l_ac].glde009   #投資股數
                  LET g_glde_d[l_ac].glde012 = g_glde_d[l_ac].glde011   #股本
                  LET g_glde_d[l_ac].glde014 = g_glde_d[l_ac].glde013   #異動日期
               END IF
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldd_m.gldddocno
               LET gs_keys[2] = g_glde_d[g_detail_idx].gldeseq
               CALL aglt500_insert_b('glde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_glde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aglt500_b_fill()
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
               LET gs_keys[01] = g_gldd_m.gldddocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_glde_d_t.gldeseq
 
            
               #刪除同層單身
               IF NOT aglt500_delete_b('glde_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aglt500_key_delete_b(gs_keys,'glde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aglt500_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_glde_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_glde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldeseq
            #add-point:BEFORE FIELD gldeseq name="input.b.page1.gldeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldeseq
            
            #add-point:AFTER FIELD gldeseq name="input.a.page1.gldeseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_gldd_m.gldddocno IS NOT NULL AND g_glde_d[g_detail_idx].gldeseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldd_m.gldddocno != g_gldddocno_t OR g_glde_d[g_detail_idx].gldeseq != g_glde_d_t.gldeseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glde_t WHERE "||"gldeent = '" ||g_enterprise|| "' AND "||"gldedocno = '"||g_gldd_m.gldddocno ||"' AND "|| "gldeseq = '"||g_glde_d[g_detail_idx].gldeseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldeseq
            #add-point:ON CHANGE gldeseq name="input.g.page1.gldeseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde015
            #add-point:BEFORE FIELD glde015 name="input.b.page1.glde015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde015
            
            #add-point:AFTER FIELD glde015 name="input.a.page1.glde015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde015
            #add-point:ON CHANGE glde015 name="input.g.page1.glde015"
            #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glde_d[l_ac].glde015 != g_glde_d_t.glde015)) THEN #160824-00007#259 161220 By 08171
            IF cl_null(g_glde_d_o.glde015) OR g_glde_d[l_ac].glde015 != g_glde_d_o.glde015 THEN #160824-00007#259 161220 By 08171 add
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM glde_t
                WHERE gldeent = g_enterprise
                  AND gldedocno = g_gldd_m.gldddocno
                  AND gldeseq = g_glde_d[l_ac].gldeseq
               IF cl_null(l_n) THEN LET l_n = 0 END IF 
               IF l_n > 0 THEN
                  IF cl_ask_confirm('agl-00437') THEN
                     DELETE FROM glde_t
                      WHERE gldeent = g_enterprise
                        AND gldedocno = g_gldd_m.gldddocno
                        AND gldeseq = g_glde_d[l_ac].gldeseq
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ":",SQLERRMESSAGE
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = FALSE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                        LET l_glde_flag = 'Y'
                        LET l_flag = 'Y'
                        EXIT DIALOG
                     END IF
                  ELSE
                    #LET g_glde_d[l_ac].glde015 = g_glde_d_t.glde015 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde015 = g_glde_d_o.glde015 #160824-00007#259 161220 By 08171 add
                     DISPLAY BY NAME g_glde_d[l_ac].glde015
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_glde_d[l_ac].glde001 = ""
                  LET g_glde_d[l_ac].glde001_desc = ""
                  LET g_glde_d[l_ac].glde003 = ""
                  LET g_glde_d[l_ac].glde003_desc = ""
                  LET g_glde_d[l_ac].glde005 = "0"
                  LET g_glde_d[l_ac].glde007 = "N"
                  LET g_glde_d[l_ac].glde009 = "0"
                  LET g_glde_d[l_ac].glde011 = "0"
                  LET g_glde_d[l_ac].glde013 = g_today
                  LET g_glde_d[l_ac].glde002 = ""
                  LET g_glde_d[l_ac].glde002_desc = ""
                  LET g_glde_d[l_ac].glde004 = ""
                  LET g_glde_d[l_ac].glde004_desc = ""
                  LET g_glde_d[l_ac].glde006 = "0"
                  LET g_glde_d[l_ac].glde008 = "N"
                  LET g_glde_d[l_ac].glde010 = "0"
                  LET g_glde_d[l_ac].glde012 = "0"
                  LET g_glde_d[l_ac].glde014 = ""
                  #項次
                  SELECT MAX(gldeseq)+1 INTO g_glde_d[l_ac].gldeseq
                    FROM glde_t
                   WHERE gldeent = g_enterprise
                    AND gldedocno = g_gldd_m.gldddocno
                  IF cl_null(g_glde_d[l_ac].gldeseq) THEN LET g_glde_d[l_ac].gldeseq = 1 END IF                  
                  CALL s_fin_get_colname('aglt500',"l_name1") RETURNING g_glde_d[l_ac].l_name
                  CALL s_fin_get_colname('aglt500',"l_name2") RETURNING g_glde_d[l_ac].l_name2
               END IF
               #LET g_glde_d_t.glde015 = g_glde_d[l_ac].glde015 #160824-00007#259 161220 By 08171 mark
               CALL aglt500_set_glde_entry(g_glde_d[l_ac].glde015)
               IF g_glde_d[l_ac].glde015 = "U" OR g_glde_d[l_ac].glde015 = "D" THEN
                  LET g_glde_d[l_ac].glde014 = g_today
               END IF
            END IF
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde001
            
            #add-point:AFTER FIELD glde001 name="input.a.page1.glde001"
            IF NOT cl_null(g_glde_d[l_ac].glde001) AND NOT cl_null(g_gldd_m.glddld) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glde_d[l_ac].glde001 != g_glde_d_t.glde001)) THEN #160824-00007#259 161220 By 08171 mark
               IF cl_null(g_glde_d_o.glde001) OR g_glde_d[l_ac].glde001 != g_glde_d_o.glde001 THEN #160824-00007#259 161220 By 08171 add
                  #新增才會用
                  #檢核該下層公司是否存在
                  #CALL s_merge_gldc002_chk(g_gldd_m.glddld,g_glde_d[l_ac].glde001,'4') RETURNING g_sub_success,g_errno
                  CALL s_merge_glda001_chk(g_glde_d[l_ac].glde001) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glde_d[l_ac].glde001 = g_glde_d_t.glde001 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde001 = g_glde_d_o.glde001 #160824-00007#259 161220 By 08171 add
                     CALL s_desc_glda001_desc(g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde001_desc
                     DISPLAY BY NAME g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #檢核該下層公司是不能是上層公司
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM gldb_t,gldc_t
                   WHERE gldbent = gldcent AND gldb001 = gldc001 AND gldbld  = gldcld 
                     AND gldcent = g_enterprise
                     AND gldbld  = g_gldd_m.glddld
                     #AND gldc001 = g_gldd_m.gldd001
                     AND gldc001 = g_glde_d[l_ac].glde001
                     AND gldc002 = g_glde_d[l_ac].glde001
                     AND gldc009 = 'Y'
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00436'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glde_d[l_ac].glde001 = g_glde_d_t.glde001 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde001 = g_glde_d_o.glde001 #160824-00007#259 161220 By 08171 add
                     CALL s_desc_glda001_desc(g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde001_desc
                     DISPLAY BY NAME g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #檢核該下層公司是不能是上層公司下面的公司
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM gldb_t,gldc_t
                   WHERE gldbent = gldcent AND gldb001 = gldc001 AND gldbld  = gldcld
                     AND gldcent = g_enterprise
                     AND gldcld = g_gldd_m.glddld
                     AND gldc001 = g_gldd_m.gldd001
                     AND gldc002 = g_glde_d[l_ac].glde001
                     AND gldc009 = 'N'
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00433'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glde_d[l_ac].glde001 = g_glde_d_t.glde001 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde001 = g_glde_d_o.glde001 #160824-00007#259 161220 By 08171 add
                     CALL s_desc_glda001_desc(g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde001_desc
                     DISPLAY BY NAME g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #需檢核是否重複
                  CALL aglt500_glde001_repeat_chk(g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno,g_glde_d[l_ac].glde001)
                       RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00434'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glde_d[l_ac].glde001 = g_glde_d_t.glde001 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde001 = g_glde_d_o.glde001 #160824-00007#259 161220 By 08171 add
                     CALL s_desc_glda001_desc(g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde001_desc
                     DISPLAY BY NAME g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde001_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_glde_d[l_ac].glde003 = '' #160824-00007#259 161220 By 08171 add
                  CALL s_merge_get_gl_ld(g_gldd_m.glddld,g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde003
                  CALL s_desc_get_ld_desc(g_glde_d[l_ac].glde003) RETURNING g_glde_d[l_ac].glde003_desc
                  DISPLAY BY NAME g_glde_d[l_ac].glde003,g_glde_d[l_ac].glde003_desc
                  CALL s_desc_glda001_desc(g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde001_desc
                  DISPLAY BY NAME g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde001_desc
               END IF
            END IF
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde001
            #add-point:BEFORE FIELD glde001 name="input.b.page1.glde001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde001
            #add-point:ON CHANGE glde001 name="input.g.page1.glde001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde003
            
            #add-point:AFTER FIELD glde003 name="input.a.page1.glde003"
            IF NOT cl_null(g_glde_d[l_ac].glde003) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glde_d[l_ac].glde003 != g_glde_d_t.glde003)) THEN #160824-00007#259 161220 By 08171 mark
               IF cl_null(g_glde_d_o.glde003) OR g_glde_d[l_ac].glde003 != g_glde_d_o.glde003 THEN #160824-00007#259 161220 By 08171 add
                  CALL s_merge_ld_chk(g_glde_d[l_ac].glde003,g_user,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glde_d[l_ac].glde003 = g_glde_d_t.glde003 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde003 = g_glde_d_o.glde003 #160824-00007#259 161220 By 08171 add
                     LET g_glde_d[l_ac].glde003_desc = s_desc_get_ld_desc(g_glde_d[l_ac].glde003)
                     DISPLAY BY NAME g_glde_d[l_ac].glde003,g_glde_d[l_ac].glde003_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_glde_d[l_ac].glde003_desc = s_desc_get_ld_desc(g_glde_d[l_ac].glde003)
                  DISPLAY BY NAME g_glde_d[l_ac].glde003,g_glde_d[l_ac].glde003_desc
               END IF
            END IF
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde003
            #add-point:BEFORE FIELD glde003 name="input.b.page1.glde003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde003
            #add-point:ON CHANGE glde003 name="input.g.page1.glde003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glde_d[l_ac].glde005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glde005
            END IF 
 
 
 
            #add-point:AFTER FIELD glde005 name="input.a.page1.glde005"
            IF NOT cl_null(g_glde_d[l_ac].glde005) THEN 
            END IF 

            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde005
            #add-point:BEFORE FIELD glde005 name="input.b.page1.glde005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde005
            #add-point:ON CHANGE glde005 name="input.g.page1.glde005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde007
            #add-point:BEFORE FIELD glde007 name="input.b.page1.glde007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde007
            
            #add-point:AFTER FIELD glde007 name="input.a.page1.glde007"
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde007
            #add-point:ON CHANGE glde007 name="input.g.page1.glde007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glde_d[l_ac].glde009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glde009
            END IF 
 
 
 
            #add-point:AFTER FIELD glde009 name="input.a.page1.glde009"
            IF NOT cl_null(g_glde_d[l_ac].glde009) THEN 
            END IF 

            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde009
            #add-point:BEFORE FIELD glde009 name="input.b.page1.glde009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde009
            #add-point:ON CHANGE glde009 name="input.g.page1.glde009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glde_d[l_ac].glde011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glde011
            END IF 
 
 
 
            #add-point:AFTER FIELD glde011 name="input.a.page1.glde011"
            IF NOT cl_null(g_glde_d[l_ac].glde011) THEN 
            END IF 
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde011
            #add-point:BEFORE FIELD glde011 name="input.b.page1.glde011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde011
            #add-point:ON CHANGE glde011 name="input.g.page1.glde011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde013
            #add-point:BEFORE FIELD glde013 name="input.b.page1.glde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde013
            
            #add-point:AFTER FIELD glde013 name="input.a.page1.glde013"
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde013
            #add-point:ON CHANGE glde013 name="input.g.page1.glde013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde002
            
            #add-point:AFTER FIELD glde002 name="input.a.page1.glde002"
            IF NOT cl_null(g_glde_d[l_ac].glde002) AND NOT cl_null(g_gldd_m.glddld) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glde_d[l_ac].glde002 != g_glde_d_t.glde002)) THEN #160824-00007#259 161220 By 08171 mark
               IF cl_null(g_glde_d_o.glde002) OR g_glde_d[l_ac].glde002 != g_glde_d_o.glde002 THEN  #160824-00007#259 161220 By 08171 add
                  #修改才會用
                  #6>>檢核該下層公司是否是上層公司下面的公司
                  CALL s_merge_ld_with_comp_chk(g_gldd_m.glddld,g_glde_d[l_ac].glde002,g_user,'6') RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glde_d[l_ac].glde002 = g_glde_d_t.glde002 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde002 = g_glde_d_o.glde002 #160824-00007#259 161220 By 08171 add
                     CALL s_desc_glda001_desc(g_glde_d[l_ac].glde002) RETURNING g_glde_d[l_ac].glde002_desc
                     DISPLAY BY NAME g_glde_d[l_ac].glde002,g_glde_d[l_ac].glde002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #需檢核是否重複
                  CALL aglt500_glde001_repeat_chk(g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno,g_glde_d[l_ac].glde002)
                       RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00434'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glde_d[l_ac].glde002 = g_glde_d_t.glde002 #160824-00007#259 161220 By 08171 mark
                     LET g_glde_d[l_ac].glde002 = g_glde_d_o.glde002 #160824-00007#259 161220 By 08171 add
                     CALL s_desc_glda001_desc(g_glde_d[l_ac].glde002) RETURNING g_glde_d[l_ac].glde002_desc
                     DISPLAY BY NAME g_glde_d[l_ac].glde002,g_glde_d[l_ac].glde002_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_glde_d[l_ac].glde004 = '' #160824-00007#259 161220 By 08171 add
                  CALL s_merge_get_gl_ld(g_gldd_m.glddld,g_glde_d[l_ac].glde002) RETURNING g_glde_d[l_ac].glde004
                  CALL s_desc_get_ld_desc(g_glde_d[l_ac].glde004) RETURNING g_glde_d[l_ac].glde004_desc
                  DISPLAY BY NAME g_glde_d[l_ac].glde004,g_glde_d[l_ac].glde004_desc
                  CALL s_desc_glda001_desc(g_glde_d[l_ac].glde002) RETURNING g_glde_d[l_ac].glde002_desc
                  DISPLAY BY NAME g_glde_d[l_ac].glde002,g_glde_d[l_ac].glde002_desc
                  #變更前也要給值
                  #160824-00007#259 161220 By 08171 --s add
                  LET g_glde_d[l_ac].glde001 = ''
                  LET g_glde_d[l_ac].glde001_desc = ''
                  LET g_glde_d[l_ac].glde003 = ''
                  LET g_glde_d[l_ac].glde003_desc = ''
                  #160824-00007#259 161220 By 08171 --e add
                  LET g_glde_d[l_ac].glde001 = g_glde_d[l_ac].glde002
                  LET g_glde_d[l_ac].glde001_desc = g_glde_d[l_ac].glde002_desc
                  LET g_glde_d[l_ac].glde003 = g_glde_d[l_ac].glde004
                  LET g_glde_d[l_ac].glde003_desc = g_glde_d[l_ac].glde004_desc
                  DISPLAY BY NAME g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde001_desc,g_glde_d[l_ac].glde003,g_glde_d[l_ac].glde003_desc
                  #擷取agli510的資料for變更前
                  #160824-00007#259 161220 By 08171 --s add
                  LET g_glde_d[l_ac].glde005 = ''
                  LET g_glde_d[l_ac].glde007 = ''
                  LET g_glde_d[l_ac].glde009 = ''
                  LET g_glde_d[l_ac].glde011 = ''
                  LET g_glde_d[l_ac].glde013 = ''
                  LET g_glde_d[l_ac].glde006 = ''
                  LET g_glde_d[l_ac].glde008 = ''
                  LET g_glde_d[l_ac].glde010 = ''
                  LET g_glde_d[l_ac].glde012 = ''
                  #160824-00007#259 161220 By 08171 --e add
                  CALL aglt500_sel_gldc(g_gldd_m.glddld,g_gldd_m.gldd001,g_glde_d[l_ac].glde001)
                       RETURNING g_sub_success,g_glde_d[l_ac].glde005,g_glde_d[l_ac].glde007,g_glde_d[l_ac].glde009,
                                 g_glde_d[l_ac].glde011,g_glde_d[l_ac].glde013
                  #把變更前的資料也給變更後default用
                  LET g_glde_d[l_ac].glde006 = g_glde_d[l_ac].glde005
                  LET g_glde_d[l_ac].glde008 = g_glde_d[l_ac].glde007
                  LET g_glde_d[l_ac].glde010 = g_glde_d[l_ac].glde009
                  LET g_glde_d[l_ac].glde012 = g_glde_d[l_ac].glde011
                  DISPLAY BY NAME g_glde_d[l_ac].glde005,g_glde_d[l_ac].glde006,g_glde_d[l_ac].glde007,g_glde_d[l_ac].glde008,
                                  g_glde_d[l_ac].glde009,g_glde_d[l_ac].glde010,g_glde_d[l_ac].glde011,g_glde_d[l_ac].glde012,
                                  g_glde_d[l_ac].glde013
               END IF
            END IF
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde002
            #add-point:BEFORE FIELD glde002 name="input.b.page1.glde002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde002
            #add-point:ON CHANGE glde002 name="input.g.page1.glde002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glde_d[l_ac].glde006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glde006
            END IF 
 
 
 
            #add-point:AFTER FIELD glde006 name="input.a.page1.glde006"
            IF NOT cl_null(g_glde_d[l_ac].glde006) THEN 
            END IF 
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde006
            #add-point:BEFORE FIELD glde006 name="input.b.page1.glde006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde006
            #add-point:ON CHANGE glde006 name="input.g.page1.glde006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde008
            #add-point:BEFORE FIELD glde008 name="input.b.page1.glde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde008
            
            #add-point:AFTER FIELD glde008 name="input.a.page1.glde008"
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde008
            #add-point:ON CHANGE glde008 name="input.g.page1.glde008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glde_d[l_ac].glde010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glde010
            END IF 
 
 
 
            #add-point:AFTER FIELD glde010 name="input.a.page1.glde010"
            IF NOT cl_null(g_glde_d[l_ac].glde010) THEN 
            END IF 
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde010
            #add-point:BEFORE FIELD glde010 name="input.b.page1.glde010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde010
            #add-point:ON CHANGE glde010 name="input.g.page1.glde010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glde_d[l_ac].glde012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glde012
            END IF 
 
 
 
            #add-point:AFTER FIELD glde012 name="input.a.page1.glde012"
            IF NOT cl_null(g_glde_d[l_ac].glde012) THEN 
            END IF 
            LET g_glde_d_o.* = g_glde_d[l_ac].* #160824-00007#259 161220 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde012
            #add-point:BEFORE FIELD glde012 name="input.b.page1.glde012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde012
            #add-point:ON CHANGE glde012 name="input.g.page1.glde012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glde014
            #add-point:BEFORE FIELD glde014 name="input.b.page1.glde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glde014
            
            #add-point:AFTER FIELD glde014 name="input.a.page1.glde014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glde014
            #add-point:ON CHANGE glde014 name="input.g.page1.glde014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gldeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldeseq
            #add-point:ON ACTION controlp INFIELD gldeseq name="input.c.page1.gldeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde015
            #add-point:ON ACTION controlp INFIELD glde015 name="input.c.page1.glde015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde001
            #add-point:ON ACTION controlp INFIELD glde001 name="input.c.page1.glde001"
            #新增才會用
            #上層公司
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glde_d[l_ac].glde001
            LET g_qryparam.where = " gldastus = 'Y' ",
                                   " AND glda001 NOT IN (SELECT gldc002 FROM gldc_t",
                                   "                      WHERE gldcent = ",g_enterprise,
                                   "                        AND gldcld = '",g_gldd_m.glddld,"'",
                                   "                        AND gldc001='",g_gldd_m.gldd001,"')"
            CALL q_glda001()
            LET g_glde_d[l_ac].glde001 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde001_desc
            DISPLAY BY NAME g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde001_desc
            NEXT FIELD glde001
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde003
            #add-point:ON ACTION controlp INFIELD glde003 name="input.c.page1.glde003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glde_d[l_ac].glde003
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET  g_glde_d[l_ac].glde003 = g_qryparam.return1
            DISPLAY BY NAME g_glde_d[l_ac].glde003
            NEXT FIELD glde003
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde005
            #add-point:ON ACTION controlp INFIELD glde005 name="input.c.page1.glde005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde007
            #add-point:ON ACTION controlp INFIELD glde007 name="input.c.page1.glde007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde009
            #add-point:ON ACTION controlp INFIELD glde009 name="input.c.page1.glde009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde011
            #add-point:ON ACTION controlp INFIELD glde011 name="input.c.page1.glde011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde013
            #add-point:ON ACTION controlp INFIELD glde013 name="input.c.page1.glde013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde002
            #add-point:ON ACTION controlp INFIELD glde002 name="input.c.page1.glde002"
            #修改才會用
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glde_d[l_ac].glde002
            LET g_qryparam.where =" gldbstus = 'Y' AND gldc009 = 'N' ",
                                  " AND gldcld = '",g_gldd_m.glddld,"' ",
                                  " AND gldc001 = '",g_gldd_m.gldd001,"'"
            CALL q_gldc002()
            LET g_glde_d[l_ac].glde002 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_glde_d[l_ac].glde002) RETURNING g_glde_d[l_ac].glde002_desc
            DISPLAY BY NAME g_glde_d[l_ac].glde002,g_glde_d[l_ac].glde002_desc
            NEXT FIELD glde002
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde006
            #add-point:ON ACTION controlp INFIELD glde006 name="input.c.page1.glde006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde008
            #add-point:ON ACTION controlp INFIELD glde008 name="input.c.page1.glde008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde010
            #add-point:ON ACTION controlp INFIELD glde010 name="input.c.page1.glde010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde012
            #add-point:ON ACTION controlp INFIELD glde012 name="input.c.page1.glde012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glde014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glde014
            #add-point:ON ACTION controlp INFIELD glde014 name="input.c.page1.glde014"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glde_d[l_ac].* = g_glde_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aglt500_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_glde_d[l_ac].gldeseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_glde_d[l_ac].* = g_glde_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               CASE g_glde_d[l_ac].glde015
                  WHEN 'I'  #新增
                     LET g_glde_d[l_ac].glde002 = g_glde_d[l_ac].glde001
                     LET g_glde_d[l_ac].glde004 = g_glde_d[l_ac].glde003
                     LET g_glde_d[l_ac].glde006 = g_glde_d[l_ac].glde005
                     LET g_glde_d[l_ac].glde008 = g_glde_d[l_ac].glde007
                     LET g_glde_d[l_ac].glde010 = g_glde_d[l_ac].glde009
                     LET g_glde_d[l_ac].glde012 = g_glde_d[l_ac].glde011
                     LET g_glde_d[l_ac].glde014 = g_glde_d[l_ac].glde013
               END CASE
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aglt500_glde_t_mask_restore('restore_mask_o')
      
               UPDATE glde_t SET (gldedocno,gldeseq,glde015,glde001,glde003,glde005,glde007,glde009, 
                   glde011,glde013,glde002,glde004,glde006,glde008,glde010,glde012,glde014) = (g_gldd_m.gldddocno, 
                   g_glde_d[l_ac].gldeseq,g_glde_d[l_ac].glde015,g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde003, 
                   g_glde_d[l_ac].glde005,g_glde_d[l_ac].glde007,g_glde_d[l_ac].glde009,g_glde_d[l_ac].glde011, 
                   g_glde_d[l_ac].glde013,g_glde_d[l_ac].glde002,g_glde_d[l_ac].glde004,g_glde_d[l_ac].glde006, 
                   g_glde_d[l_ac].glde008,g_glde_d[l_ac].glde010,g_glde_d[l_ac].glde012,g_glde_d[l_ac].glde014) 
 
                WHERE gldeent = g_enterprise AND gldedocno = g_gldd_m.gldddocno 
 
                  AND gldeseq = g_glde_d_t.gldeseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_glde_d[l_ac].* = g_glde_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_glde_d[l_ac].* = g_glde_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldd_m.gldddocno
               LET gs_keys_bak[1] = g_gldddocno_t
               LET gs_keys[2] = g_glde_d[g_detail_idx].gldeseq
               LET gs_keys_bak[2] = g_glde_d_t.gldeseq
               CALL aglt500_update_b('glde_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aglt500_glde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_glde_d[g_detail_idx].gldeseq = g_glde_d_t.gldeseq 
 
                  ) THEN
                  LET gs_keys[01] = g_gldd_m.gldddocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glde_d_t.gldeseq
 
                  CALL aglt500_key_update_b(gs_keys,'glde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gldd_m),util.JSON.stringify(g_glde_d_t)
               LET g_log2 = util.JSON.stringify(g_gldd_m),util.JSON.stringify(g_glde_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aglt500_unlock_b("glde_t","'1'")
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
               LET g_glde_d[li_reproduce_target].* = g_glde_d[li_reproduce].*
 
               LET g_glde_d[li_reproduce_target].gldeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glde_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aglt500.input.other" >}
      
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
            NEXT FIELD gldddocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gldeseq
 
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
   IF l_flag = 'Y' THEN
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF
END WHILE
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglt500_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aglt500_b_fill() #單身填充
      CALL aglt500_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglt500_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL aglt500_set_ld_info(g_gldd_m.glddld)
   CALL s_desc_get_ld_desc(g_gldd_m.glddld) RETURNING g_gldd_m.glddld_desc
   CALL s_desc_glda001_desc(g_gldd_m.gldd001) RETURNING g_gldd_m.gldd001_desc
   CALL s_aooi200_fin_get_slip_desc(g_gldd_m.gldddocno) RETURNING g_gldd_m.gldddocno_desc
   CALL s_desc_get_ld_desc(g_gldd_m.gldd002) RETURNING g_gldd_m.gldd002_desc
   #end add-point
   
   #遮罩相關處理
   LET g_gldd_m_mask_o.* =  g_gldd_m.*
   CALL aglt500_gldd_t_mask()
   LET g_gldd_m_mask_n.* =  g_gldd_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc,g_gldd_m.gldd001,g_gldd_m.gldd001_desc,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocno_desc,g_gldd_m.gldddocdt,g_gldd_m.ooef001,g_gldd_m.ooef001_desc,g_gldd_m.gldd002, 
       g_gldd_m.gldd002_desc,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp, 
       g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmodid_desc,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfid_desc,g_gldd_m.glddcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gldd_m.glddstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glde_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL s_desc_glda001_desc(g_glde_d[l_ac].glde001) RETURNING g_glde_d[l_ac].glde001_desc
      CALL s_desc_glda001_desc(g_glde_d[l_ac].glde002) RETURNING g_glde_d[l_ac].glde002_desc
      CALL s_desc_get_ld_desc(g_glde_d[l_ac].glde003) RETURNING g_glde_d[l_ac].glde003_desc
      CALL s_desc_get_ld_desc(g_glde_d[l_ac].glde004) RETURNING g_glde_d[l_ac].glde004_desc
      CALL s_fin_get_colname('aglt500',"l_name1") RETURNING g_glde_d[l_ac].l_name
      CALL s_fin_get_colname('aglt500',"l_name2") RETURNING g_glde_d[l_ac].l_name2
      #DISPLAY BY NAME g_glde_d[l_ac].l_name,g_glde_d[l_ac].l_name2
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
 
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aglt500_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aglt500_detail_show()
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
 
{<section id="aglt500.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglt500_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gldd_t.gldddocno 
   DEFINE l_oldno     LIKE gldd_t.gldddocno 
 
   DEFINE l_master    RECORD LIKE gldd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glde_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_gldd_m.gldddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gldddocno_t = g_gldd_m.gldddocno
 
    
   LET g_gldd_m.gldddocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gldd_m.glddownid = g_user
      LET g_gldd_m.glddowndp = g_dept
      LET g_gldd_m.glddcrtid = g_user
      LET g_gldd_m.glddcrtdp = g_dept 
      LET g_gldd_m.glddcrtdt = cl_get_current()
      LET g_gldd_m.glddmodid = g_user
      LET g_gldd_m.glddmoddt = cl_get_current()
      LET g_gldd_m.glddstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gldd_m.glddstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_gldd_m.gldddocno_desc = ''
   DISPLAY BY NAME g_gldd_m.gldddocno_desc
 
   
   CALL aglt500_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gldd_m.* TO NULL
      INITIALIZE g_glde_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aglt500_show()
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
   CALL aglt500_set_act_visible()   
   CALL aglt500_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gldddocno_t = g_gldd_m.gldddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " glddent = " ||g_enterprise|| " AND",
                      " gldddocno = '", g_gldd_m.gldddocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aglt500_idx_chk()
   
   LET g_data_owner = g_gldd_m.glddownid      
   LET g_data_dept  = g_gldd_m.glddowndp
   
   #功能已完成,通報訊息中心
   CALL aglt500_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglt500_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glde_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglt500_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glde_t
    WHERE gldeent = g_enterprise AND gldedocno = g_gldddocno_t
 
    INTO TEMP aglt500_detail
 
   #將key修正為調整後   
   UPDATE aglt500_detail 
      #更新key欄位
      SET gldedocno = g_gldd_m.gldddocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO glde_t SELECT * FROM aglt500_detail
   
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
   DROP TABLE aglt500_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gldddocno_t = g_gldd_m.gldddocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglt500_delete()
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
   
   IF g_gldd_m.gldddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aglt500_cl USING g_enterprise,g_gldd_m.gldddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aglt500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt500_master_referesh USING g_gldd_m.gldddocno INTO g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid, 
       g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfdt,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddmodid_desc,g_gldd_m.glddcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aglt500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gldd_m_mask_o.* =  g_gldd_m.*
   CALL aglt500_gldd_t_mask()
   LET g_gldd_m_mask_n.* =  g_gldd_m.*
   
   CALL aglt500_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglt500_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gldddocno_t = g_gldd_m.gldddocno
 
 
      DELETE FROM gldd_t
       WHERE glddent = g_enterprise AND gldddocno = g_gldd_m.gldddocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gldd_m.gldddocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM glde_t
       WHERE gldeent = g_enterprise AND gldedocno = g_gldd_m.gldddocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gldd_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aglt500_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_glde_d.clear() 
 
     
      CALL aglt500_ui_browser_refresh()  
      #CALL aglt500_ui_headershow()  
      #CALL aglt500_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aglt500_browser_fill("")
         CALL aglt500_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aglt500_cl
 
   #功能已完成,通報訊息中心
   CALL aglt500_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglt500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglt500_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_glde_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aglt500_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gldeseq,glde015,glde001,glde003,glde005,glde007,glde009,glde011, 
             glde013,glde002,glde004,glde006,glde008,glde010,glde012,glde014  FROM glde_t",   
                     " INNER JOIN gldd_t ON glddent = " ||g_enterprise|| " AND gldddocno = gldedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE gldeent=? AND gldedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY glde_t.gldeseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglt500_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglt500_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gldd_m.gldddocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gldd_m.gldddocno INTO g_glde_d[l_ac].gldeseq,g_glde_d[l_ac].glde015, 
          g_glde_d[l_ac].glde001,g_glde_d[l_ac].glde003,g_glde_d[l_ac].glde005,g_glde_d[l_ac].glde007, 
          g_glde_d[l_ac].glde009,g_glde_d[l_ac].glde011,g_glde_d[l_ac].glde013,g_glde_d[l_ac].glde002, 
          g_glde_d[l_ac].glde004,g_glde_d[l_ac].glde006,g_glde_d[l_ac].glde008,g_glde_d[l_ac].glde010, 
          g_glde_d[l_ac].glde012,g_glde_d[l_ac].glde014   #(ver:78)
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
   
   CALL g_glde_d.deleteElement(g_glde_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aglt500_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_glde_d.getLength()
      LET g_glde_d_mask_o[l_ac].* =  g_glde_d[l_ac].*
      CALL aglt500_glde_t_mask()
      LET g_glde_d_mask_n[l_ac].* =  g_glde_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglt500_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM glde_t
       WHERE gldeent = g_enterprise AND
         gldedocno = ps_keys_bak[1] AND gldeseq = ps_keys_bak[2]
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
         CALL g_glde_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglt500_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO glde_t
                  (gldeent,
                   gldedocno,
                   gldeseq
                   ,glde015,glde001,glde003,glde005,glde007,glde009,glde011,glde013,glde002,glde004,glde006,glde008,glde010,glde012,glde014) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_glde_d[g_detail_idx].glde015,g_glde_d[g_detail_idx].glde001,g_glde_d[g_detail_idx].glde003, 
                       g_glde_d[g_detail_idx].glde005,g_glde_d[g_detail_idx].glde007,g_glde_d[g_detail_idx].glde009, 
                       g_glde_d[g_detail_idx].glde011,g_glde_d[g_detail_idx].glde013,g_glde_d[g_detail_idx].glde002, 
                       g_glde_d[g_detail_idx].glde004,g_glde_d[g_detail_idx].glde006,g_glde_d[g_detail_idx].glde008, 
                       g_glde_d[g_detail_idx].glde010,g_glde_d[g_detail_idx].glde012,g_glde_d[g_detail_idx].glde014) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_glde_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglt500_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "glde_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aglt500_glde_t_mask_restore('restore_mask_o')
               
      UPDATE glde_t 
         SET (gldedocno,
              gldeseq
              ,glde015,glde001,glde003,glde005,glde007,glde009,glde011,glde013,glde002,glde004,glde006,glde008,glde010,glde012,glde014) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_glde_d[g_detail_idx].glde015,g_glde_d[g_detail_idx].glde001,g_glde_d[g_detail_idx].glde003, 
                  g_glde_d[g_detail_idx].glde005,g_glde_d[g_detail_idx].glde007,g_glde_d[g_detail_idx].glde009, 
                  g_glde_d[g_detail_idx].glde011,g_glde_d[g_detail_idx].glde013,g_glde_d[g_detail_idx].glde002, 
                  g_glde_d[g_detail_idx].glde004,g_glde_d[g_detail_idx].glde006,g_glde_d[g_detail_idx].glde008, 
                  g_glde_d[g_detail_idx].glde010,g_glde_d[g_detail_idx].glde012,g_glde_d[g_detail_idx].glde014)  
 
         WHERE gldeent = g_enterprise AND gldedocno = ps_keys_bak[1] AND gldeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aglt500_glde_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aglt500.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aglt500_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aglt500.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglt500_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aglt500.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglt500_lock_b(ps_table,ps_page)
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
   #CALL aglt500_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "glde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aglt500_bcl USING g_enterprise,
                                       g_gldd_m.gldddocno,g_glde_d[g_detail_idx].gldeseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aglt500_bcl:",SQLERRMESSAGE 
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
 
{<section id="aglt500.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglt500_unlock_b(ps_table,ps_page)
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
      CLOSE aglt500_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglt500_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("gldddocno,glddld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gldddocno",TRUE)
      CALL cl_set_comp_entry("gldddocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("gldd001",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglt500_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gldddocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("gldd001",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("gldddocno,glddld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("gldddocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt500.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglt500_set_entry_b(p_cmd)
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
 
{<section id="aglt500.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglt500_set_no_entry_b(p_cmd)
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
 
{<section id="aglt500.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglt500_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglt500_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_gldd_m.glddstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglt500_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglt500_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglt500_default_search()
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
      LET ls_wc = ls_wc, " gldddocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "gldd_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "glde_t" 
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
 
{<section id="aglt500.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aglt500_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gldd_m.gldddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aglt500_cl USING g_enterprise,g_gldd_m.gldddocno
   IF STATUS THEN
      CLOSE aglt500_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt500_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aglt500_master_referesh USING g_gldd_m.gldddocno INTO g_gldd_m.glddld,g_gldd_m.gldd001,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddowndp,g_gldd_m.glddcrtid, 
       g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfdt,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddmodid_desc,g_gldd_m.glddcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aglt500_action_chk() THEN
      CLOSE aglt500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc,g_gldd_m.gldd001,g_gldd_m.gldd001_desc,g_gldd_m.gldddocno, 
       g_gldd_m.gldddocno_desc,g_gldd_m.gldddocdt,g_gldd_m.ooef001,g_gldd_m.ooef001_desc,g_gldd_m.gldd002, 
       g_gldd_m.gldd002_desc,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp, 
       g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdp_desc, 
       g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmodid_desc,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
       g_gldd_m.glddcnfid_desc,g_gldd_m.glddcnfdt
 
   CASE g_gldd_m.glddstus
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
         CASE g_gldd_m.glddstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
     
      CASE g_gldd_m.glddstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL s_transaction_end('N','0')      #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W" #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"  #只能顯示確認; 其餘應用功能皆隱藏
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
      g_gldd_m.glddstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aglt500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      IF g_gldd_m.glddstus = 'N' THEN
         CALL cl_err_collect_init()
         CALL s_aglt500_conf_chk(g_gldd_m.glddld,g_gldd_m.gldddocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_aglt500_conf_upd(g_gldd_m.glddld,g_gldd_m.gldddocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
         END IF
      END IF
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      CALL s_aglt500_unconf_chk(g_gldd_m.glddld,g_gldd_m.gldddocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_aglt500_unconf_upd(g_gldd_m.glddld,g_gldd_m.gldddocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_gldd_m.glddmodid = g_user
   LET g_gldd_m.glddmoddt = cl_get_current()
   LET g_gldd_m.glddstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gldd_t 
      SET (glddstus,glddmodid,glddmoddt) 
        = (g_gldd_m.glddstus,g_gldd_m.glddmodid,g_gldd_m.glddmoddt)     
    WHERE glddent = g_enterprise AND gldddocno = g_gldd_m.gldddocno
 
    
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
      EXECUTE aglt500_master_referesh USING g_gldd_m.gldddocno INTO g_gldd_m.glddld,g_gldd_m.gldd001, 
          g_gldd_m.gldddocno,g_gldd_m.gldddocdt,g_gldd_m.gldd002,g_gldd_m.glddstus,g_gldd_m.glddownid, 
          g_gldd_m.glddowndp,g_gldd_m.glddcrtid,g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdt,g_gldd_m.glddmodid, 
          g_gldd_m.glddmoddt,g_gldd_m.glddcnfid,g_gldd_m.glddcnfdt,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp_desc, 
          g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp_desc,g_gldd_m.glddmodid_desc,g_gldd_m.glddcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gldd_m.glddld,g_gldd_m.glddld_desc,g_gldd_m.gldd001,g_gldd_m.gldd001_desc,g_gldd_m.gldddocno, 
          g_gldd_m.gldddocno_desc,g_gldd_m.gldddocdt,g_gldd_m.ooef001,g_gldd_m.ooef001_desc,g_gldd_m.gldd002, 
          g_gldd_m.gldd002_desc,g_gldd_m.glddstus,g_gldd_m.glddownid,g_gldd_m.glddownid_desc,g_gldd_m.glddowndp, 
          g_gldd_m.glddowndp_desc,g_gldd_m.glddcrtid,g_gldd_m.glddcrtid_desc,g_gldd_m.glddcrtdp,g_gldd_m.glddcrtdp_desc, 
          g_gldd_m.glddcrtdt,g_gldd_m.glddmodid,g_gldd_m.glddmodid_desc,g_gldd_m.glddmoddt,g_gldd_m.glddcnfid, 
          g_gldd_m.glddcnfid_desc,g_gldd_m.glddcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aglt500_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt500_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt500.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglt500_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_glde_d.getLength() THEN
         LET g_detail_idx = g_glde_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glde_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glde_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglt500_b_fill2(pi_idx)
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
   
   CALL aglt500_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglt500_fill_chk(ps_idx)
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
 
{<section id="aglt500.status_show" >}
PRIVATE FUNCTION aglt500_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt500.mask_functions" >}
&include "erp/agl/aglt500_mask.4gl"
 
{</section>}
 
{<section id="aglt500.signature" >}
   
 
{</section>}
 
{<section id="aglt500.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglt500_set_pk_array()
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
   LET g_pk_array[1].values = g_gldd_m.gldddocno
   LET g_pk_array[1].column = 'gldddocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt500.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aglt500.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglt500_msgcentre_notify(lc_state)
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
   CALL aglt500_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gldd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt500.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aglt500_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#12  2016/08/24  By 07900  --add--s--
   SELECT glddstus INTO g_gldd_m.glddstus
     FROM gldd_t
    WHERE glddgent = g_enterprise
      AND glddgdocno = g_gldd_m.gldddocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_gldd_m.glddstus
       
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
        LET g_errparam.extend = g_gldd_m.gldddocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aglt500_set_act_visible()
        CALL aglt500_set_act_no_visible()
        CALL aglt500_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#12  2016/08/24  By 07900  --add--e--    
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt500.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得帳套的相關資料
# Memo...........:
# Usage..........: CALL aglt500_set_ld_info()
# Date & Author..: 2016/03/15 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt500_set_ld_info(p_ld)
DEFINE p_ld          LIKE gldd_t.glddld
   
   IF cl_null(p_ld) THEN 
       RETURN
   END IF
   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa024')
        RETURNING g_sub_success,g_glaa.*
   
   LET g_gldd_m.ooef001 = g_glaa.glaacomp
   CALL s_desc_get_department_desc(g_gldd_m.ooef001) RETURNING g_gldd_m.ooef001_desc
   
   DISPLAY BY NAME g_gldd_m.ooef001,g_gldd_m.ooef001_desc
END FUNCTION

################################################################################
# Descriptions...: 是否有以前的單據未確認
# Memo...........:
# Usage..........: CALL aglt500_before_chk()
# Date & Author..: 2016/03/17 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt500_before_chk(p_glddld,p_gldd001,p_gldddocdt)
DEFINE p_glddld         LIKE gldd_t.glddld
DEFINE p_gldd001        LIKE gldd_t.gldd001
DEFINE p_gldddocdt      LIKE gldd_t.gldddocdt
DEFINE l_cnt            LIKE type_t.num10
DEFINE r_success        LIKE type_t.num5

#輸入單頭時，相同合併帳別+上層公司+上層公司帳別,如有單據日期在前,且尚未確認的,則不可輸入下一張單據,應提示訊息報錯
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM gldd_t
    WHERE glddent = g_enterprise
      AND glddld = p_glddld
      AND gldd001 = p_gldd001
      AND glddstus = 'N'
      AND gldddocdt <= p_gldddocdt
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 下層公司是否重複輸入
# Memo...........:
# Usage..........: CALL aglt500_glde001_repeat_chk()
# Date & Author..: 2016/03/18 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt500_glde001_repeat_chk(p_glddld,p_gldd001,p_gldddocno,p_glde001)
DEFINE p_glddld         LIKE gldd_t.glddld
DEFINE p_gldd001        LIKE gldd_t.gldd001
DEFINE p_gldddocno      LIKE gldd_t.gldddocno
DEFINE p_glde001        LIKE glde_t.glde001
DEFINE l_cnt            LIKE type_t.num10
DEFINE r_success        LIKE type_t.num5

#相同合併帳別+上層公司+下層公司不可重複出現
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM gldd_t
     LEFT JOIN glde_t ON glddent = gldeent AND gldddocno = gldedocno
    WHERE glddent = g_enterprise
      AND glddld = p_glddld
      AND gldd001 = p_gldd001
      AND gldddocno = p_gldddocno
      AND glde001 = p_glde001
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根據異動狀態開啟or隱藏單身欄位
# Memo...........:
# Usage..........: CALL aglt500_set_glde_entry(p_glde015)
# Date & Author..: 2016/03/21 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt500_set_glde_entry(p_glde015)
DEFINE p_glde015        LIKE glde_t.glde015
   CALL cl_set_comp_entry("glde001,glde003,glde005,glde007,glde009,glde011,glde013",TRUE)
   CALL cl_set_comp_entry("glde002,glde006,glde008,glde010,glde012,glde014",TRUE)
   CASE p_glde015
      WHEN 'I' #新增
         CALL cl_set_comp_entry("glde002,glde006,glde008,glde010,glde012,glde014",FALSE)
      WHEN 'U' #修改
         CALL cl_set_comp_entry("glde001,glde003,glde005,glde007,glde009,glde011,glde013",FALSE)
      WHEN 'D' #刪除
         CALL cl_set_comp_entry("glde001,glde003,glde005,glde007,glde009,glde011,glde013",FALSE)
         CALL cl_set_comp_entry("glde006,glde008,glde010,glde012,glde014",FALSE)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 撈取agli510的資料(gldc_t)
# Memo...........:
# Usage..........: CALL aglt500_sel_gldc()
# Date & Author..: 2016/03/21 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt500_sel_gldc(p_glddld,p_gldd001,p_glde001)
DEFINE p_glddld         LIKE gldd_t.glddld   #合併帳套
DEFINE p_gldd001        LIKE gldd_t.gldd001  #上層公司
DEFINE p_glde001        LIKE glde_t.glde001  #下層公司
DEFINE l_sql            STRING
DEFINE r_gldc           RECORD
                           gldc004  LIKE gldc_t.gldc004,  #持股比率%
                           gldc005  LIKE gldc_t.gldc005,  #納入合併否
                           gldc006  LIKE gldc_t.gldc006,  #投資股數
                           gldc007  LIKE gldc_t.gldc007,  #股本
                           gldc008  LIKE gldc_t.gldc008   #異動日期
                        END RECORD
DEFINE r_success        LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   LET l_sql = "SELECT gldc004,gldc005,gldc006,gldc007,gldc008",
               "  FROM gldc_t ",
               " WHERE gldcent = ",g_enterprise,
               "   AND gldcld = '",p_glddld,"'",
               "   AND gldc001 = '",p_gldd001,"'",
               "   AND gldc002 = '",p_glde001,"'"
   PREPARE gldc_sel_pb FROM l_sql
   EXECUTE gldc_sel_pb INTO r_gldc.*
   
   RETURN r_success,r_gldc.*
   
END FUNCTION

 
{</section>}
 
