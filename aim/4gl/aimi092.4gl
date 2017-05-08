#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi092.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-06-21 15:18:23), PR版次:0015(2016-12-16 09:52:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000315
#+ Filename...: aimi092
#+ Description: 料件特徵維護作業
#+ Creator....: 02482(2013-11-06 16:41:25)
#+ Modifier...: 02294 -SD/PR- 07025
 
{</section>}
 
{<section id="aimi092.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160413-00011#5  2016/04/13 By xianghui 特征值说明修改之后产品特征说明需要跟着更新
#160426-00003#1  2016/04/29 By xianghui 产品特征值档增加有效/无效
#160512-00017#1  2016/06/20 By lixiang  當 賦值方式選2.預定表值，增加限定資料來源的欄位可以輸入
#160701-00019#1  2016/07/01 By lixiang  修正查询状态，限定数据源栏位开窗报错的问题
#160725-00014#1  2016/08/02 By lixiang  产品特征值开窗时，同步写入多语言表
#160811-00017#1  2016/08/11 By lixiang  特征群组内容项次修改后，同步更新特征值单身的项次
#161214-00047#1  2016/12/15 By catmoon 第一單身(特征群组内容)新增或修改換行時，需重跑第二單身(特征值賦予)
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
PRIVATE type type_g_imea_m        RECORD
       imea001 LIKE imea_t.imea001, 
   imeal003 LIKE type_t.chr500, 
   imea002 LIKE imea_t.imea002, 
   imea003 LIKE imea_t.imea003, 
   imea004 LIKE imea_t.imea004, 
   imeastus LIKE imea_t.imeastus, 
   imeaownid LIKE imea_t.imeaownid, 
   imeaownid_desc LIKE type_t.chr80, 
   imeacrtid LIKE imea_t.imeacrtid, 
   imeacrtid_desc LIKE type_t.chr80, 
   imeaowndp LIKE imea_t.imeaowndp, 
   imeaowndp_desc LIKE type_t.chr80, 
   imeacrtdp LIKE imea_t.imeacrtdp, 
   imeacrtdp_desc LIKE type_t.chr80, 
   imeacrtdt LIKE imea_t.imeacrtdt, 
   imeamodid LIKE imea_t.imeamodid, 
   imeamodid_desc LIKE type_t.chr80, 
   imeamoddt LIKE imea_t.imeamoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_imeb_d        RECORD
       imeb002 LIKE imeb_t.imeb002, 
   imeb003 LIKE imeb_t.imeb003, 
   imeb004 LIKE imeb_t.imeb004, 
   imeb004_desc LIKE type_t.chr500, 
   imeb005 LIKE imeb_t.imeb005, 
   imeb013 LIKE imeb_t.imeb013, 
   imeb013_desc LIKE type_t.chr500, 
   imeb006 LIKE imeb_t.imeb006, 
   imeb007 LIKE imeb_t.imeb007, 
   imeb008 LIKE imeb_t.imeb008, 
   imeb009 LIKE imeb_t.imeb009, 
   imeb010 LIKE imeb_t.imeb010, 
   imeb011 LIKE imeb_t.imeb011, 
   imeb012 LIKE imeb_t.imeb012
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_imea001 LIKE imea_t.imea001,
   b_imea001_desc LIKE type_t.chr80,
      b_imea002 LIKE imea_t.imea002
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success                   LIKE type_t.num5
#單身2
 TYPE type_g_imeb2_d        RECORD
             imecstus              LIKE imec_t.imecstus,     #160426-00003#1
             imec003               LIKE imec_t.imec003, 
             imecl005              LIKE imecl_t.imecl005,
             imecl006              LIKE imecl_t.imecl006
             END RECORD
DEFINE g_detail_multi_table_t    RECORD
             imecl001            LIKE imecl_t.imecl001,
             imecl002            LIKE imecl_t.imecl002,
             imecl003            LIKE imecl_t.imecl003,
             imecl004            LIKE imecl_t.imecl004,
             imecl005            LIKE imecl_t.imecl005,
             imecl006            LIKE imecl_t.imecl006
             END RECORD       
DEFINE g_imeb2_d                 DYNAMIC ARRAY OF type_g_imeb2_d
DEFINE g_imeb2_d_t               type_g_imeb2_d
DEFINE g_wc2_table2              STRING      
DEFINE g_wc3                     STRING   
DEFINE g_rec_b1                  LIKE type_t.num5
DEFINE l_ac1                     LIKE type_t.num5
DEFINE g_flag                    LIKE type_t.num5  #160512-00017#1
#end add-point
       
#模組變數(Module Variables)
DEFINE g_imea_m          type_g_imea_m
DEFINE g_imea_m_t        type_g_imea_m
DEFINE g_imea_m_o        type_g_imea_m
DEFINE g_imea_m_mask_o   type_g_imea_m #轉換遮罩前資料
DEFINE g_imea_m_mask_n   type_g_imea_m #轉換遮罩後資料
 
   DEFINE g_imea001_t LIKE imea_t.imea001
 
 
DEFINE g_imeb_d          DYNAMIC ARRAY OF type_g_imeb_d
DEFINE g_imeb_d_t        type_g_imeb_d
DEFINE g_imeb_d_o        type_g_imeb_d
DEFINE g_imeb_d_mask_o   DYNAMIC ARRAY OF type_g_imeb_d #轉換遮罩前資料
DEFINE g_imeb_d_mask_n   DYNAMIC ARRAY OF type_g_imeb_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      imeal001 LIKE imeal_t.imeal001,
      imeal003 LIKE imeal_t.imeal003
      END RECORD
 
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
 
{<section id="aimi092.main" >}
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
   CALL cl_ap_init("aim","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imea001,'',imea002,imea003,imea004,imeastus,imeaownid,'',imeacrtid,'', 
       imeaowndp,'',imeacrtdp,'',imeacrtdt,imeamodid,'',imeamoddt", 
                      " FROM imea_t",
                      " WHERE imeaent= ? AND imea001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi092_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imea001,t0.imea002,t0.imea003,t0.imea004,t0.imeastus,t0.imeaownid, 
       t0.imeacrtid,t0.imeaowndp,t0.imeacrtdp,t0.imeacrtdt,t0.imeamodid,t0.imeamoddt,t1.ooag011 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooefl003 ,t5.ooag011",
               " FROM imea_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.imeaownid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imeacrtid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.imeaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.imeacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.imeamodid  ",
 
               " WHERE t0.imeaent = " ||g_enterprise|| " AND t0.imea001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimi092_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimi092 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimi092_init()   
 
      #進入選單 Menu (="N")
      CALL aimi092_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimi092
      
   END IF 
   
   CLOSE aimi092_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimi092.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimi092_init()
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
      CALL cl_set_combo_scc_part('imeastus','17','N,Y')
 
      CALL cl_set_combo_scc('imeb003','4004') 
   CALL cl_set_combo_scc('imeb005','4005') 
   CALL cl_set_combo_scc('imeb006','4006') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL aimi092_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aimi092.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aimi092_ui_dialog()
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
            CALL aimi092_insert()
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
         INITIALIZE g_imea_m.* TO NULL
         CALL g_imeb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aimi092_init()
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
               
               CALL aimi092_fetch('') # reload data
               LET l_ac = 1
               CALL aimi092_ui_detailshow() #Setting the current row 
         
               CALL aimi092_idx_chk()
               #NEXT FIELD imeb002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_imeb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimi092_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL aimi092_b_fill_1()
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
               CALL aimi092_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_imeb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b1)  
    
            BEFORE ROW
               CALL aimi092_idx_chk()
               LET l_ac1 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac1
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac1 = DIALOG.getCurrentRow("s_detail2")
               CALL aimi092_idx_chk()
               LET g_current_page = 2

         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aimi092_browser_fill("")
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
               CALL aimi092_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aimi092_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aimi092_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aimi092_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aimi092_set_act_visible()   
            CALL aimi092_set_act_no_visible()
            IF NOT (g_imea_m.imea001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " imeaent = " ||g_enterprise|| " AND",
                                  " imea001 = '", g_imea_m.imea001, "' "
 
               #填到對應位置
               CALL aimi092_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "imea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imeb_t" 
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
               CALL aimi092_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "imea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imeb_t" 
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
                  CALL aimi092_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi092_fetch("F")
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
               CALL aimi092_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aimi092_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi092_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aimi092_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi092_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aimi092_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi092_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aimi092_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi092_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aimi092_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi092_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_imeb_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_imeb2_d)
                  LET g_export_id[2]   = "s_detail2"
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
               NEXT FIELD imeb002
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
               CALL aimi092_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aimi092_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi092_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi092_insert()
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
               CALL aimi092_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi092_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi092_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi092_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi092_set_pk_array()
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
 
{<section id="aimi092.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aimi092_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_wc3             STRING
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
   #CALL g_browser.clear()  #20150731 查询后修改单身后，点击确认后只有有修改的这笔资料，故需要mark
   LET l_wc3 = g_wc3.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT imea001 ",
                      " FROM imea_t ",
                      " ",
                      " LEFT JOIN imeb_t ON imebent = imeaent AND imea001 = imeb001 ", "  ",
                      #add-point:browser_fill段sql(imeb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN imeal_t ON imealent = "||g_enterprise||" AND imea001 = imeal001 AND imeal002 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE imeaent = " ||g_enterprise|| " AND imebent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("imea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT imea001 ",
                      " FROM imea_t ", 
                      "  ",
                      "  LEFT JOIN imeal_t ON imealent = "||g_enterprise||" AND imea001 = imeal001 AND imeal002 = '",g_dlang,"' ",
                      " WHERE imeaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("imea_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc3 <> " 1=1" THEN
      #單身2有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE imea001 ",
                      "   FROM imea_t ",
                      "   LEFT JOIN imeb_t ON imebent = imeaent AND imea001 = imeb001 ",
                      "   LEFT JOIN imec_t ON imecent = imeaent AND imeb001 = imec001 AND imeb002 = imec002",
                      "   LEFT JOIN imecl_t ON imec001 = imecl001 AND imec002 = imecl002 AND imec003 = imecl003 AND imecl004 = '",g_lang,"' ",
                      "  WHERE imeaent = '" ||g_enterprise|| "' AND imebent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, " AND ", l_wc3
 
   ELSE
      IF g_wc2 <> " 1=1" THEN
         #單身1有輸入搜尋條件                      
         LET l_sub_sql = " SELECT UNIQUE imea001 ",
                         "   FROM imea_t ",
                         "   LEFT JOIN imeb_t ON imebent = imeaent AND imea001 = imeb001 ",
                         "  WHERE imeaent = '" ||g_enterprise|| "' AND imebent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
 
      ELSE
         #單身未輸入搜尋條件
         LET l_sub_sql = " SELECT UNIQUE imea001 ",
                         "   FROM imea_t ",
                         "  WHERE imeaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
      END IF
   END IF
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
      INITIALIZE g_imea_m.* TO NULL
      CALL g_imeb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.imea001,t0.imea002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imeastus,t0.imea001,t0.imea002,t1.imeal003 ",
                  " FROM imea_t t0",
                  "  ",
                  "  LEFT JOIN imeb_t ON imebent = imeaent AND imea001 = imeb001 ", "  ", 
                  #add-point:browser_fill段sql(imeb_t1) name="browser_fill.join.imeb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN imeal_t t1 ON t1.imealent="||g_enterprise||" AND t1.imeal001=t0.imea001 AND t1.imeal002='"||g_dlang||"' ",
 
                  " WHERE t0.imeaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imeastus,t0.imea001,t0.imea002,t1.imeal003 ",
                  " FROM imea_t t0",
                  "  ",
                                 " LEFT JOIN imeal_t t1 ON t1.imealent="||g_enterprise||" AND t1.imeal001=t0.imea001 AND t1.imeal002='"||g_dlang||"' ",
 
                  " WHERE t0.imeaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("imea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY imea001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   #單身2有輸入查詢條件且非null
   IF l_wc3 <> " 1=1" AND NOT cl_null(l_wc3) THEN
      #依照imea001,'',imea002 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT imeastus,imea001,imea002,DENSE_RANK() OVER(ORDER BY imea001 ",g_order,") AS RANK ",
                       "  FROM imea_t ",
                       "   LEFT JOIN imeb_t ON imebent = imeaent AND imea001 = imeb001 ",
                       "   LEFT JOIN imec_t ON imecent = imeaent AND imeb001 = imec001 AND imeb002 = imec002",
                       "   LEFT JOIN imecl_t ON imec001 = imecl001 AND imec002 = imecl002 AND imec003 = imecl003 AND imecl004 = '",g_lang,"' ",
                       " WHERE imeaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2," AND ",l_wc3
   ELSE
      IF l_wc2 <> " 1=1" AND NOT cl_null(l_wc2) THEN 
         #單身1有輸入查詢條件且非null
         LET l_sql_rank = "SELECT DISTINCT imeastus,imea001,imea002,DENSE_RANK() OVER(ORDER BY imea001 ",g_order,") AS RANK ",
                          "  FROM imea_t ",
                          " LEFT JOIN imeb_t ON imebent = imeaent AND imea001 = imeb001 ",
                          " WHERE imeaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2
      ELSE
         #單身無輸入資料
         LET l_sql_rank = "SELECT DISTINCT imeastus,imea001,imea002,DENSE_RANK() OVER(ORDER BY imea001 ",g_order,") AS RANK ",
                          "  FROM imea_t ",
                          " WHERE imeaent = '" ||g_enterprise|| "' AND ", l_wc
      END IF
   END IF
   #定義翻頁CURSOR
   LET g_sql= "SELECT imeastus,imea001,imea002,'' FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              #stellar 141008 add ----------------------(S)
              #" ORDER BY ",l_searchcol," ",g_order
              #樣板目前拿掉l_searchcol變數
              " ORDER BY imea001 ",g_order
              #stellar 141008 add ----------------------(E)
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"imea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imea001,g_browser[g_cnt].b_imea002, 
          g_browser[g_cnt].b_imea001_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_imea001
      CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001 = ? AND imeal002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_imea001_desc = g_rtn_fields[1] 
      DISPLAY BY NAME g_browser[g_cnt].b_imea001_desc
         #end add-point
      
         #遮罩相關處理
         CALL aimi092_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_imea001) THEN
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
 
{<section id="aimi092.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aimi092_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_imea_m.imea001 = g_browser[g_current_idx].b_imea001   
 
   EXECUTE aimi092_master_referesh USING g_imea_m.imea001 INTO g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003, 
       g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp,g_imea_m.imeacrtdp, 
       g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp_desc,g_imea_m.imeamodid_desc
   
   CALL aimi092_imea_t_mask()
   CALL aimi092_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aimi092.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aimi092_ui_detailshow()
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
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)      
   END IF
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimi092_ui_browser_refresh()
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
      IF g_browser[l_i].b_imea001 = g_imea_m.imea001 
 
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
 
{<section id="aimi092.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi092_construct()
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
   INITIALIZE g_imea_m.* TO NULL
   CALL g_imeb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON imea001,imeal003,imea002,imea003,imea004,imeastus,imeaownid,imeacrtid, 
          imeaowndp,imeacrtdp,imeacrtdt,imeamodid,imeamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imeacrtdt>>----
         AFTER FIELD imeacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imeamoddt>>----
         AFTER FIELD imeamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imeacnfdt>>----
         
         #----<<imeapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.imea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea001
            #add-point:ON ACTION controlp INFIELD imea001 name="construct.c.imea001"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imea001  #顯示到畫面上

            NEXT FIELD imea001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea001
            #add-point:BEFORE FIELD imea001 name="construct.b.imea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea001
            
            #add-point:AFTER FIELD imea001 name="construct.a.imea001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeal003
            #add-point:BEFORE FIELD imeal003 name="construct.b.imeal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeal003
            
            #add-point:AFTER FIELD imeal003 name="construct.a.imeal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imeal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeal003
            #add-point:ON ACTION controlp INFIELD imeal003 name="construct.c.imeal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea002
            #add-point:BEFORE FIELD imea002 name="construct.b.imea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea002
            
            #add-point:AFTER FIELD imea002 name="construct.a.imea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea002
            #add-point:ON ACTION controlp INFIELD imea002 name="construct.c.imea002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea003
            #add-point:BEFORE FIELD imea003 name="construct.b.imea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea003
            
            #add-point:AFTER FIELD imea003 name="construct.a.imea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea003
            #add-point:ON ACTION controlp INFIELD imea003 name="construct.c.imea003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea004
            #add-point:BEFORE FIELD imea004 name="construct.b.imea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea004
            
            #add-point:AFTER FIELD imea004 name="construct.a.imea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea004
            #add-point:ON ACTION controlp INFIELD imea004 name="construct.c.imea004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeastus
            #add-point:BEFORE FIELD imeastus name="construct.b.imeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeastus
            
            #add-point:AFTER FIELD imeastus name="construct.a.imeastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeastus
            #add-point:ON ACTION controlp INFIELD imeastus name="construct.c.imeastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imeaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeaownid
            #add-point:ON ACTION controlp INFIELD imeaownid name="construct.c.imeaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imeaownid  #顯示到畫面上

            NEXT FIELD imeaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeaownid
            #add-point:BEFORE FIELD imeaownid name="construct.b.imeaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeaownid
            
            #add-point:AFTER FIELD imeaownid name="construct.a.imeaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imeacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeacrtid
            #add-point:ON ACTION controlp INFIELD imeacrtid name="construct.c.imeacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imeacrtid  #顯示到畫面上

            NEXT FIELD imeacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeacrtid
            #add-point:BEFORE FIELD imeacrtid name="construct.b.imeacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeacrtid
            
            #add-point:AFTER FIELD imeacrtid name="construct.a.imeacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imeaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeaowndp
            #add-point:ON ACTION controlp INFIELD imeaowndp name="construct.c.imeaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imeaowndp  #顯示到畫面上

            NEXT FIELD imeaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeaowndp
            #add-point:BEFORE FIELD imeaowndp name="construct.b.imeaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeaowndp
            
            #add-point:AFTER FIELD imeaowndp name="construct.a.imeaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imeacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeacrtdp
            #add-point:ON ACTION controlp INFIELD imeacrtdp name="construct.c.imeacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imeacrtdp  #顯示到畫面上

            NEXT FIELD imeacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeacrtdp
            #add-point:BEFORE FIELD imeacrtdp name="construct.b.imeacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeacrtdp
            
            #add-point:AFTER FIELD imeacrtdp name="construct.a.imeacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeacrtdt
            #add-point:BEFORE FIELD imeacrtdt name="construct.b.imeacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imeamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeamodid
            #add-point:ON ACTION controlp INFIELD imeamodid name="construct.c.imeamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imeamodid  #顯示到畫面上

            NEXT FIELD imeamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeamodid
            #add-point:BEFORE FIELD imeamodid name="construct.b.imeamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeamodid
            
            #add-point:AFTER FIELD imeamodid name="construct.a.imeamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeamoddt
            #add-point:BEFORE FIELD imeamoddt name="construct.b.imeamoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON imeb002,imeb003,imeb004,imeb005,imeb013,imeb006,imeb007,imeb008,imeb009, 
          imeb010,imeb011,imeb012
           FROM s_detail1[1].imeb002,s_detail1[1].imeb003,s_detail1[1].imeb004,s_detail1[1].imeb005, 
               s_detail1[1].imeb013,s_detail1[1].imeb006,s_detail1[1].imeb007,s_detail1[1].imeb008,s_detail1[1].imeb009, 
               s_detail1[1].imeb010,s_detail1[1].imeb011,s_detail1[1].imeb012
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb002
            #add-point:BEFORE FIELD imeb002 name="construct.b.page1.imeb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb002
            
            #add-point:AFTER FIELD imeb002 name="construct.a.page1.imeb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb002
            #add-point:ON ACTION controlp INFIELD imeb002 name="construct.c.page1.imeb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb003
            #add-point:BEFORE FIELD imeb003 name="construct.b.page1.imeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb003
            
            #add-point:AFTER FIELD imeb003 name="construct.a.page1.imeb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb003
            #add-point:ON ACTION controlp INFIELD imeb003 name="construct.c.page1.imeb003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb004
            #add-point:ON ACTION controlp INFIELD imeb004 name="construct.c.page1.imeb004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "273"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imeb004  #顯示到畫面上

            NEXT FIELD imeb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb004
            #add-point:BEFORE FIELD imeb004 name="construct.b.page1.imeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb004
            
            #add-point:AFTER FIELD imeb004 name="construct.a.page1.imeb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb005
            #add-point:BEFORE FIELD imeb005 name="construct.b.page1.imeb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb005
            
            #add-point:AFTER FIELD imeb005 name="construct.a.page1.imeb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb005
            #add-point:ON ACTION controlp INFIELD imeb005 name="construct.c.page1.imeb005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imeb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb013
            #add-point:ON ACTION controlp INFIELD imeb013 name="construct.c.page1.imeb013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " gzzz002 IN ( ",
                                   " SELECT DISTINCT dzag001 FROM dzag_t, ",
                                   #"   (SELECT dzeb001,count(dzeb002) a FROM dzeb_t WHERE dzeb004 ='Y' AND dzeb002 NOT LIKE '%ent' AND dzeb002 NOT LIKE '%site'b ",  #160701-00019#1
                                   "   (SELECT dzeb001,count(dzeb002) a FROM dzeb_t WHERE dzeb004 ='Y' AND dzeb002 NOT LIKE '%ent' AND dzeb002 NOT LIKE '%site' ",    #160701-00019#1
                                   "     GROUP BY dzeb001 ",
                                   "   ) b WHERE dzag002 = b.dzeb001 AND b.a = 1 ",
                                   " UNION ",
                                   " SELECT DISTINCT dzag001 FROM dzag_t,dzeb_t WHERE dzag002 = dzeb001 AND dzeb001 ='oocq_t' ) "
            CALL q_gzzz001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imeb013  #顯示到畫面上
            NEXT FIELD imeb013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb013
            #add-point:BEFORE FIELD imeb013 name="construct.b.page1.imeb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb013
            
            #add-point:AFTER FIELD imeb013 name="construct.a.page1.imeb013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb006
            #add-point:BEFORE FIELD imeb006 name="construct.b.page1.imeb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb006
            
            #add-point:AFTER FIELD imeb006 name="construct.a.page1.imeb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb006
            #add-point:ON ACTION controlp INFIELD imeb006 name="construct.c.page1.imeb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb007
            #add-point:BEFORE FIELD imeb007 name="construct.b.page1.imeb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb007
            
            #add-point:AFTER FIELD imeb007 name="construct.a.page1.imeb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb007
            #add-point:ON ACTION controlp INFIELD imeb007 name="construct.c.page1.imeb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb008
            #add-point:BEFORE FIELD imeb008 name="construct.b.page1.imeb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb008
            
            #add-point:AFTER FIELD imeb008 name="construct.a.page1.imeb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb008
            #add-point:ON ACTION controlp INFIELD imeb008 name="construct.c.page1.imeb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb009
            #add-point:BEFORE FIELD imeb009 name="construct.b.page1.imeb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb009
            
            #add-point:AFTER FIELD imeb009 name="construct.a.page1.imeb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb009
            #add-point:ON ACTION controlp INFIELD imeb009 name="construct.c.page1.imeb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb010
            #add-point:BEFORE FIELD imeb010 name="construct.b.page1.imeb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb010
            
            #add-point:AFTER FIELD imeb010 name="construct.a.page1.imeb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb010
            #add-point:ON ACTION controlp INFIELD imeb010 name="construct.c.page1.imeb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb011
            #add-point:BEFORE FIELD imeb011 name="construct.b.page1.imeb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb011
            
            #add-point:AFTER FIELD imeb011 name="construct.a.page1.imeb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb011
            #add-point:ON ACTION controlp INFIELD imeb011 name="construct.c.page1.imeb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb012
            #add-point:BEFORE FIELD imeb012 name="construct.b.page1.imeb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb012
            
            #add-point:AFTER FIELD imeb012 name="construct.a.page1.imeb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imeb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb012
            #add-point:ON ACTION controlp INFIELD imeb012 name="construct.c.page1.imeb012"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      #160426-00003#1 add imecstus
      CONSTRUCT g_wc2_table2 ON imecstus,imec003 FROM s_detail2[1].imecstus,s_detail2[1].imec003
                      
         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)
           
         BEFORE FIELD imec003
         
         AFTER FIELD imec003  
         
         #160512-00017#1---s--
         ON ACTION controlp INFIELD imec003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imec003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imec003  #顯示到畫面上
            NEXT FIELD imec003                     #返回原欄位
         #160512-00017#1----e--
         
      END CONSTRUCT
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
                  WHEN la_wc[li_idx].tableid = "imea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imeb_t" 
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
   LET g_wc3 = g_wc2_table2
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimi092_filter()
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
      CONSTRUCT g_wc_filter ON imea001,imea002
                          FROM s_browse[1].b_imea001,s_browse[1].b_imea002
 
         BEFORE CONSTRUCT
               DISPLAY aimi092_filter_parser('imea001') TO s_browse[1].b_imea001
            DISPLAY aimi092_filter_parser('imea002') TO s_browse[1].b_imea002
      
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
 
      CALL aimi092_filter_show('imea001')
   CALL aimi092_filter_show('imea002')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimi092_filter_parser(ps_field)
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
 
{<section id="aimi092.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimi092_filter_show(ps_field)
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
   LET ls_condition = aimi092_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimi092_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL g_imeb2_d.clear()
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
   CALL g_imeb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aimi092_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimi092_browser_fill("")
      CALL aimi092_fetch("")
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
      CALL aimi092_filter_show('imea001')
   CALL aimi092_filter_show('imea002')
   CALL aimi092_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aimi092_fetch("F") 
      #顯示單身筆數
      CALL aimi092_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimi092_fetch(p_flag)
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
   
   LET g_imea_m.imea001 = g_browser[g_current_idx].b_imea001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aimi092_master_referesh USING g_imea_m.imea001 INTO g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003, 
       g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp,g_imea_m.imeacrtdp, 
       g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp_desc,g_imea_m.imeamodid_desc
   
   #遮罩相關處理
   LET g_imea_m_mask_o.* =  g_imea_m.*
   CALL aimi092_imea_t_mask()
   LET g_imea_m_mask_n.* =  g_imea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimi092_set_act_visible()   
   CALL aimi092_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imea_m_t.* = g_imea_m.*
   LET g_imea_m_o.* = g_imea_m.*
   
   LET g_data_owner = g_imea_m.imeaownid      
   LET g_data_dept  = g_imea_m.imeaowndp
   
   #重新顯示   
   CALL aimi092_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimi092_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   CALL g_imeb2_d.clear()
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_imeb_d.clear()   
 
 
   INITIALIZE g_imea_m.* TO NULL             #DEFAULT 設定
   
   LET g_imea001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imea_m.imeaownid = g_user
      LET g_imea_m.imeaowndp = g_dept
      LET g_imea_m.imeacrtid = g_user
      LET g_imea_m.imeacrtdp = g_dept 
      LET g_imea_m.imeacrtdt = cl_get_current()
      LET g_imea_m.imeamodid = g_user
      LET g_imea_m.imeamoddt = cl_get_current()
      LET g_imea_m.imeastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imea_m.imea002 = "Y"
      LET g_imea_m.imea004 = "N"
      LET g_imea_m.imeastus = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_imea_m.imea003 = "N"
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_imea_m_t.* = g_imea_m.*
      LET g_imea_m_o.* = g_imea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imea_m.imeastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL aimi092_input("a")
      
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
         INITIALIZE g_imea_m.* TO NULL
         INITIALIZE g_imeb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aimi092_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_imeb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimi092_set_act_visible()   
   CALL aimi092_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imea001_t = g_imea_m.imea001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imeaent = " ||g_enterprise|| " AND",
                      " imea001 = '", g_imea_m.imea001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi092_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aimi092_cl
   
   CALL aimi092_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimi092_master_referesh USING g_imea_m.imea001 INTO g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003, 
       g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp,g_imea_m.imeacrtdp, 
       g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp_desc,g_imea_m.imeamodid_desc
   
   
   #遮罩相關處理
   LET g_imea_m_mask_o.* =  g_imea_m.*
   CALL aimi092_imea_t_mask()
   LET g_imea_m_mask_n.* =  g_imea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imea_m.imea001,g_imea_m.imeal003,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
       g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp,g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp,g_imea_m.imeacrtdp_desc,g_imea_m.imeacrtdt, 
       g_imea_m.imeamodid,g_imea_m.imeamodid_desc,g_imea_m.imeamoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_imea_m.imeaownid      
   LET g_data_dept  = g_imea_m.imeaowndp
   
   #功能已完成,通報訊息中心
   CALL aimi092_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimi092_modify()
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
   LET g_imea_m_t.* = g_imea_m.*
   LET g_imea_m_o.* = g_imea_m.*
   
   IF g_imea_m.imea001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_imea001_t = g_imea_m.imea001
 
   CALL s_transaction_begin()
   
   OPEN aimi092_cl USING g_enterprise,g_imea_m.imea001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi092_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimi092_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi092_master_referesh USING g_imea_m.imea001 INTO g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003, 
       g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp,g_imea_m.imeacrtdp, 
       g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp_desc,g_imea_m.imeamodid_desc
   
   #檢查是否允許此動作
   IF NOT aimi092_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imea_m_mask_o.* =  g_imea_m.*
   CALL aimi092_imea_t_mask()
   LET g_imea_m_mask_n.* =  g_imea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aimi092_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_imea001_t = g_imea_m.imea001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_imea_m.imeamodid = g_user 
LET g_imea_m.imeamoddt = cl_get_current()
LET g_imea_m.imeamodid_desc = cl_get_username(g_imea_m.imeamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      CALL aimi092_showerrmsg()
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aimi092_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE imea_t SET (imeamodid,imeamoddt) = (g_imea_m.imeamodid,g_imea_m.imeamoddt)
          WHERE imeaent = g_enterprise AND imea001 = g_imea001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_imea_m.* = g_imea_m_t.*
            CALL aimi092_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_imea_m.imea001 != g_imea_m_t.imea001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE imeb_t SET imeb001 = g_imea_m.imea001
 
          WHERE imebent = g_enterprise AND imeb001 = g_imea_m_t.imea001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imeb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imeb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         UPDATE imec_t
            SET imec001 = g_imea_m.imea001
          WHERE imecent = g_enterprise 
            AND imec001 = g_imea001_t
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
            CONTINUE WHILE
         END IF
         UPDATE imecl_t
            SET imecl001 = g_imea_m.imea001
          WHERE imeclent = g_enterprise 
            AND imecl001 = g_imea001_t
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
            CONTINUE WHILE
         END IF
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimi092_set_act_visible()   
   CALL aimi092_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imeaent = " ||g_enterprise|| " AND",
                      " imea001 = '", g_imea_m.imea001, "' "
 
   #填到對應位置
   CALL aimi092_browser_fill("")
 
   CLOSE aimi092_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi092_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aimi092.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimi092_input(p_cmd)
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
   DEFINE  l_ac1_t               LIKE type_t.num5
   DEFINE  l_n1                  LIKE type_t.num5    
   #160512-00017#1----s--
   DEFINE l_str1                 STRING
   DEFINE l_str2                 STRING
   DEFINE bst                    base.StringTokenizer
   DEFINE l_imec003              LIKE imec_t.imec003
   DEFINE l_imecl005             LIKE imecl_t.imecl005
   DEFINE l_gzzz004              LIKE gzzz_t.gzzz004
   DEFINE l_dzeb002_1            LIKE dzeb_t.dzeb002
   DEFINE l_sql                  STRING
   DEFINE l_dzag002              LIKE dzag_t.dzag002
   DEFINE l_dzeb002              LIKE dzeb_t.dzeb002
   DEFINE l_success              LIKE type_t.num5
   #160512-00017#1----e---
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
   DISPLAY BY NAME g_imea_m.imea001,g_imea_m.imeal003,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
       g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp,g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp,g_imea_m.imeacrtdp_desc,g_imea_m.imeacrtdt, 
       g_imea_m.imeamodid,g_imea_m.imeamodid_desc,g_imea_m.imeamoddt
   
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
   LET g_forupd_sql = "SELECT imeb002,imeb003,imeb004,imeb005,imeb013,imeb006,imeb007,imeb008,imeb009, 
       imeb010,imeb011,imeb012 FROM imeb_t WHERE imebent=? AND imeb001=? AND imeb002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi092_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aimi092_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimi092_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_imea_m.imea001,g_imea_m.imeal003,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
       g_imea_m.imeastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #160426-00003#1 add imecstus
   LET g_forupd_sql = "SELECT imecstus,imec003 FROM imec_t WHERE imecent=? AND imec001=? AND imec002=? AND imec003=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aimi092_bcl2 CURSOR FROM g_forupd_sql
   
   #161214-00047#1--add--start--
   LET g_sql = "SELECT UNIQUE imecstus,imec003,imecl005,imecl006 FROM imec_t", 
               "  LEFT JOIN imecl_t ON imecent = imeclent ",
               "   AND imec001 = imecl001 ",
               "   AND imec002 = imecl002 ",
               "   AND imec003 = imecl003 ",
               "   AND imecl004 = '",g_dlang,"'",
               " WHERE imecent=? AND imec001=? AND imec002=?",            
               " ORDER BY  imec_t.imec003" 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aimi092_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR aimi092_pb3   
   #161214-00047#1--add--end----
   
   LET g_errshow = 1   #160512-00017#1 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aimi092.input.head" >}
      #單頭段
      INPUT BY NAME g_imea_m.imea001,g_imea_m.imeal003,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
          g_imea_m.imeastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               CALL n_imeal(g_imea_m.imea001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_imea_m.imea001
               CALL ap_ref_array2(g_ref_fields," SELECT imeal003 FROM imeal_t WHERE imealent = '"||g_enterprise||"' AND imeal001 = ? AND imeal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_imea_m.imeal003 = g_rtn_fields[1]
               DISPLAY BY NAME g_imea_m.imeal003
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aimi092_cl USING g_enterprise,g_imea_m.imea001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi092_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi092_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.imeal001 = g_imea_m.imea001
LET g_master_multi_table_t.imeal003 = g_imea_m.imeal003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.imeal001 = ''
LET g_master_multi_table_t.imeal003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aimi092_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aimi092_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea001
            #add-point:BEFORE FIELD imea001 name="input.b.imea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea001
            
            #add-point:AFTER FIELD imea001 name="input.a.imea001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_imea_m.imea001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imea_m.imea001 != g_imea001_t )) THEN 
                  IF NOT ap_chk_notDup(g_imea_m.imea001,"SELECT COUNT(*) FROM imea_t WHERE "||"imeaent = '" ||g_enterprise|| "' AND "||"imea001 = '"||g_imea_m.imea001 ||"'",'std-00004',0) THEN 
                     LET g_imea_m.imea001 = g_imea001_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imea001
            #add-point:ON CHANGE imea001 name="input.g.imea001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeal003
            #add-point:BEFORE FIELD imeal003 name="input.b.imeal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeal003
            
            #add-point:AFTER FIELD imeal003 name="input.a.imeal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeal003
            #add-point:ON CHANGE imeal003 name="input.g.imeal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea002
            #add-point:BEFORE FIELD imea002 name="input.b.imea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea002
            
            #add-point:AFTER FIELD imea002 name="input.a.imea002"
            IF g_imea_m.imea002 = 'N' THEN
               CALL aimi092_chk_imea002()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imea_m.imea002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imea_m.imea002 = g_imea_m_t.imea002
                  NEXT FIELD imea002
               END IF 
            END IF
#            CALL aimi092_set_entry_b(l_cmd)
#            CALL aimi092_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imea002
            #add-point:ON CHANGE imea002 name="input.g.imea002"
#            CALL aimi092_set_entry_b(l_cmd)
#            CALL aimi092_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea003
            #add-point:BEFORE FIELD imea003 name="input.b.imea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea003
            
            #add-point:AFTER FIELD imea003 name="input.a.imea003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imea003
            #add-point:ON CHANGE imea003 name="input.g.imea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imea004
            #add-point:BEFORE FIELD imea004 name="input.b.imea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imea004
            
            #add-point:AFTER FIELD imea004 name="input.a.imea004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imea004
            #add-point:ON CHANGE imea004 name="input.g.imea004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeastus
            #add-point:BEFORE FIELD imeastus name="input.b.imeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeastus
            
            #add-point:AFTER FIELD imeastus name="input.a.imeastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeastus
            #add-point:ON CHANGE imeastus name="input.g.imeastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea001
            #add-point:ON ACTION controlp INFIELD imea001 name="input.c.imea001"
 
            #END add-point
 
 
         #Ctrlp:input.c.imeal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeal003
            #add-point:ON ACTION controlp INFIELD imeal003 name="input.c.imeal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.imea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea002
            #add-point:ON ACTION controlp INFIELD imea002 name="input.c.imea002"
            
            #END add-point
 
 
         #Ctrlp:input.c.imea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea003
            #add-point:ON ACTION controlp INFIELD imea003 name="input.c.imea003"
            
            #END add-point
 
 
         #Ctrlp:input.c.imea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imea004
            #add-point:ON ACTION controlp INFIELD imea004 name="input.c.imea004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeastus
            #add-point:ON ACTION controlp INFIELD imeastus name="input.c.imeastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_imea_m.imea001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO imea_t (imeaent,imea001,imea002,imea003,imea004,imeastus,imeaownid,imeacrtid, 
                   imeaowndp,imeacrtdp,imeacrtdt,imeamodid,imeamoddt)
               VALUES (g_enterprise,g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
                   g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp,g_imea_m.imeacrtdp, 
                   g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_imea_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imea_m.imea001 = g_master_multi_table_t.imeal001 AND
         g_imea_m.imeal003 = g_master_multi_table_t.imeal003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imealent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imea_m.imea001
            LET l_field_keys[02] = 'imeal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imeal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imeal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imea_m.imeal003
            LET l_fields[01] = 'imeal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imeal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aimi092_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aimi092_b_fill()
                  CALL aimi092_b_fill2('0')
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
               CALL aimi092_imea_t_mask_restore('restore_mask_o')
               
               UPDATE imea_t SET (imea001,imea002,imea003,imea004,imeastus,imeaownid,imeacrtid,imeaowndp, 
                   imeacrtdp,imeacrtdt,imeamodid,imeamoddt) = (g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003, 
                   g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp, 
                   g_imea_m.imeacrtdp,g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt)
                WHERE imeaent = g_enterprise AND imea001 = g_imea001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imea_m.imea001 = g_master_multi_table_t.imeal001 AND
         g_imea_m.imeal003 = g_master_multi_table_t.imeal003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imealent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imea_m.imea001
            LET l_field_keys[02] = 'imeal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imeal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imeal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imea_m.imeal003
            LET l_fields[01] = 'imeal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imeal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aimi092_imea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_imea_m_t)
               LET g_log2 = util.JSON.stringify(g_imea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_imea001_t = g_imea_m.imea001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aimi092.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_imeb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imeb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimi092_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_imeb_d.getLength()
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
            OPEN aimi092_cl USING g_enterprise,g_imea_m.imea001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi092_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi092_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imeb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imeb_d[l_ac].imeb002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imeb_d_t.* = g_imeb_d[l_ac].*  #BACKUP
               LET g_imeb_d_o.* = g_imeb_d[l_ac].*  #BACKUP
               CALL aimi092_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aimi092_set_no_entry_b(l_cmd)
               IF NOT aimi092_lock_b("imeb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi092_bcl INTO g_imeb_d[l_ac].imeb002,g_imeb_d[l_ac].imeb003,g_imeb_d[l_ac].imeb004, 
                      g_imeb_d[l_ac].imeb005,g_imeb_d[l_ac].imeb013,g_imeb_d[l_ac].imeb006,g_imeb_d[l_ac].imeb007, 
                      g_imeb_d[l_ac].imeb008,g_imeb_d[l_ac].imeb009,g_imeb_d[l_ac].imeb010,g_imeb_d[l_ac].imeb011, 
                      g_imeb_d[l_ac].imeb012
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imeb_d_t.imeb002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imeb_d_mask_o[l_ac].* =  g_imeb_d[l_ac].*
                  CALL aimi092_imeb_t_mask()
                  LET g_imeb_d_mask_n[l_ac].* =  g_imeb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimi092_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL aimi092_set_no_required_b()
            CALL aimi092_set_required_b()
            #161214-00047#1--add--start--
            IF g_imeb_d.getLength() > 0 THEN
               CALL g_imeb2_d.clear()
               OPEN b_fill_curs3 USING g_enterprise,g_imea_m.imea001,g_imeb_d[l_ac].imeb002
               LET l_ac1 = 1
               FOREACH b_fill_curs3 INTO g_imeb2_d[l_ac1].imecstus,g_imeb2_d[l_ac1].imec003,g_imeb2_d[l_ac1].imecl005,g_imeb2_d[l_ac1].imecl006 
                  IF l_ac1 > g_max_rec THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = l_ac1
                     LET g_errparam.code   = 9035 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     EXIT FOREACH
                  END IF
                  LET l_ac1 = l_ac1 + 1
               END FOREACH
               CALL g_imeb2_d.deleteElement(g_imeb2_d.getLength())
            END IF
            #161214-00047#1--add--end----
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
            INITIALIZE g_imeb_d[l_ac].* TO NULL 
            INITIALIZE g_imeb_d_t.* TO NULL 
            INITIALIZE g_imeb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_imeb_d[l_ac].imeb003 = "1"
      LET g_imeb_d[l_ac].imeb005 = "1"
      LET g_imeb_d[l_ac].imeb006 = "1"
      LET g_imeb_d[l_ac].imeb008 = "0"
      LET g_imeb_d[l_ac].imeb012 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_imeb_d_t.* = g_imeb_d[l_ac].*     #新輸入資料
            LET g_imeb_d_o.* = g_imeb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimi092_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aimi092_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imeb_d[li_reproduce_target].* = g_imeb_d[li_reproduce].*
 
               LET g_imeb_d[li_reproduce_target].imeb002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(imeb002)+1 INTO g_imeb_d[l_ac].imeb002
              FROM imeb_t
             WHERE imebent = g_enterprise
               AND imeb001 = g_imea_m.imea001
            IF cl_null(g_imeb_d[l_ac].imeb002) THEN
               LET g_imeb_d[l_ac].imeb002 = 1
            END IF
            CALL aimi092_set_no_required_b()
            CALL aimi092_set_required_b()
            CALL g_imeb2_d.clear()
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
            SELECT COUNT(1) INTO l_count FROM imeb_t 
             WHERE imebent = g_enterprise AND imeb001 = g_imea_m.imea001
 
               AND imeb002 = g_imeb_d[l_ac].imeb002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               IF g_imeb_d[l_ac].imeb005 = '3' THEN
                  IF cl_null(g_imeb_d[l_ac].imeb010) AND cl_null(g_imeb_d[l_ac].imeb011) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00210'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  END IF
               END IF
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imea_m.imea001
               LET gs_keys[2] = g_imeb_d[g_detail_idx].imeb002
               CALL aimi092_insert_b('imeb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_imeb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imeb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimi092_b_fill()
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
               LET gs_keys[01] = g_imea_m.imea001
 
               LET gs_keys[gs_keys.getLength()+1] = g_imeb_d_t.imeb002
 
            
               #刪除同層單身
               IF NOT aimi092_delete_b('imeb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi092_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimi092_key_delete_b(gs_keys,'imeb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi092_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aimi092_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM imec_t
                   WHERE imecent = g_enterprise
                     AND imec001 = g_imea_m.imea001 
                     AND imec002 = g_imeb_d_t.imeb002
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "imec_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE 
                  END IF
                  DELETE FROM imecl_t
                   WHERE imeclent = g_enterprise
                     AND imecl001 = g_imea_m.imea001 
                     AND imecl002 = g_imeb_d_t.imeb002
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "imecl_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE 
                  END IF
               #end add-point
               LET l_count = g_imeb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imeb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imeb_d[l_ac].imeb002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD imeb002
            END IF 
 
 
 
            #add-point:AFTER FIELD imeb002 name="input.a.page1.imeb002"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_imea_m.imea001) AND NOT cl_null(g_imeb_d[l_ac].imeb002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imea_m.imea001 != g_imea001_t OR g_imeb_d[l_ac].imeb002 != g_imeb_d_t.imeb002)) THEN 
                  IF NOT ap_chk_notDup(g_imeb_d[l_ac].imeb002,"SELECT COUNT(*) FROM imeb_t WHERE "||"imebent = '" ||g_enterprise|| "' AND "||"imeb001 = '"||g_imea_m.imea001 ||"' AND "|| "imeb002 = '"||g_imeb_d[l_ac].imeb002 ||"'",'std-00004',0) THEN 
                     LET g_imeb_d[l_ac].imeb002 = g_imeb_d_t.imeb002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb002
            #add-point:BEFORE FIELD imeb002 name="input.b.page1.imeb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb002
            #add-point:ON CHANGE imeb002 name="input.g.page1.imeb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb003
            #add-point:BEFORE FIELD imeb003 name="input.b.page1.imeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb003
            
            #add-point:AFTER FIELD imeb003 name="input.a.page1.imeb003"
            CALL aimi092_set_entry_b(l_cmd)
            CALL aimi092_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb003
            #add-point:ON CHANGE imeb003 name="input.g.page1.imeb003"
            CALL aimi092_set_entry_b(l_cmd)
            CALL aimi092_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb004
            
            #add-point:AFTER FIELD imeb004 name="input.a.page1.imeb004"
            CALL aimi092_imeb_desc()
            IF NOT cl_null(g_imeb_d[l_ac].imeb004) THEN
               CALL s_azzi650_chk_exist('273',g_imeb_d[l_ac].imeb004) RETURNING l_success
               IF NOT l_success THEN
                  LET g_imeb_d[l_ac].imeb004 = g_imeb_d_t.imeb004
                  CALL aimi092_imeb_desc()
                  NEXT FIELD imeb004
               END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_imeb_d[l_ac].imeb004 <> g_imeb_d_t.imeb004) THEN
                  CALL aimi092_chk_imeb004(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb004 = g_imeb_d_t.imeb004
                     CALL aimi092_imeb_desc()
                     NEXT FIELD imeb004
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb004
            #add-point:BEFORE FIELD imeb004 name="input.b.page1.imeb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb004
            #add-point:ON CHANGE imeb004 name="input.g.page1.imeb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb005
            #add-point:BEFORE FIELD imeb005 name="input.b.page1.imeb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb005
            
            #add-point:AFTER FIELD imeb005 name="input.a.page1.imeb005"
            IF NOT cl_null(g_imeb_d[l_ac].imeb005) AND NOT cl_null(g_imeb_d[l_ac].imeb006)THEN
               IF g_imeb_d[l_ac].imeb005 ='3' AND g_imeb_d[l_ac].imeb006 = '1' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00224'
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_imeb_d[l_ac].imeb006 = '2'
                  NEXT FIELD imeb006                  
               END IF
            END IF            
            IF g_imeb_d[l_ac].imeb005 <> '2' AND g_imeb_d_t.imeb005 = '2' THEN
               LET l_n1 = 0
               SELECT COUNT(*) INTO l_n1
                 FROM imec_t
                WHERE imecent = g_enterprise
                  AND imec001 = g_imea_m.imea001 
                  AND imec002 = g_imeb_d[l_ac].imeb002 
               IF l_n1 > 0 THEN
                  IF cl_ask_confirm('aim-00182') THEN
                     DELETE FROM imec_t
                      WHERE imecent = g_enterprise
                        AND imec001 = g_imea_m.imea001 
                        AND imec002 = g_imeb_d[l_ac].imeb002 
                     DELETE FROM imecl_t
                      WHERE imeclent = g_enterprise
                        AND imecl001 = g_imea_m.imea001 
                        AND imecl002 = g_imeb_d[l_ac].imeb002
                  END IF
               END IF
               CALL aimi092_b_fill_1()
            END IF
            CALL aimi092_set_entry_b(l_cmd)
            CALL aimi092_set_no_required_b()
            CALL aimi092_set_required_b()
            CALL aimi092_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb005
            #add-point:ON CHANGE imeb005 name="input.g.page1.imeb005"
            CALL aimi092_set_entry_b(l_cmd)
            CALL aimi092_set_no_required_b()
            CALL aimi092_set_required_b()
            CALL aimi092_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb013
            
            #add-point:AFTER FIELD imeb013 name="input.a.page1.imeb013"
            CALL s_desc_get_prog_desc(g_imeb_d[l_ac].imeb013) RETURNING g_imeb_d[l_ac].imeb013_desc
            DISPLAY BY NAME g_imeb_d[l_ac].imeb013_desc
            IF NOT cl_null(g_imeb_d[l_ac].imeb013) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imeb_d[l_ac].imeb013
               LET g_chkparam.where = " gzzz002 IN ( ",
                                      " SELECT DISTINCT dzag001 FROM dzag_t, ",
                                      "   (SELECT dzeb001,count(dzeb002) a FROM dzeb_t WHERE dzeb004 ='Y' AND dzeb002 NOT LIKE '%ent' AND dzeb002 NOT LIKE '%site' ",
                                      "     GROUP BY dzeb001 ",
                                      "   ) b WHERE dzag002 = b.dzeb001 AND b.a = 1 ",
                                      " UNION ",
                                      " SELECT DISTINCT dzag001 FROM dzag_t,dzeb_t WHERE dzag002 = dzeb001 AND dzeb001 ='oocq_t' )"
                 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_gzzz001_6") THEN
                  #檢查失敗時後續處理
                  LET g_imeb_d[l_ac].imeb013 = g_imeb_d_t.imeb013
                  CALL s_desc_get_prog_desc(g_imeb_d[l_ac].imeb013) RETURNING g_imeb_d[l_ac].imeb013_desc
                  DISPLAY BY NAME g_imeb_d[l_ac].imeb013_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 
            CALL aimi092_set_entry_b(l_cmd)
            CALL aimi092_set_no_required_b()
            CALL aimi092_set_required_b()
            CALL aimi092_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb013
            #add-point:BEFORE FIELD imeb013 name="input.b.page1.imeb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb013
            #add-point:ON CHANGE imeb013 name="input.g.page1.imeb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb006
            #add-point:BEFORE FIELD imeb006 name="input.b.page1.imeb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb006
            
            #add-point:AFTER FIELD imeb006 name="input.a.page1.imeb006"
            CALL aimi092_set_entry_b(l_cmd)
            CALL aimi092_set_no_entry_b(l_cmd)
            IF NOT cl_null(g_imeb_d[l_ac].imeb005) AND NOT cl_null(g_imeb_d[l_ac].imeb006)THEN
               IF g_imeb_d[l_ac].imeb005 ='3' AND g_imeb_d[l_ac].imeb006 = '1' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00224'
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_imeb_d[l_ac].imeb006 = g_imeb_d_t.imeb006
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            IF NOT cl_null(g_imeb_d[l_ac].imeb009) THEN
               IF g_imeb_d[l_ac].imeb006 = '1' THEN
                  CALL aimi092_chk_chr(g_imeb_d[l_ac].imeb009) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00209'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '2' THEN
                  CALL aimi092_digcut(g_imeb_d[l_ac].imeb009,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb009
                  CALL aimi092_chk_num(g_imeb_d[l_ac].imeb009) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00172'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '3' THEN
                  CALL aimi092_chk_znum(g_imeb_d[l_ac].imeb009) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00173'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb009,'2')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL aimi092_imeb006_change()
               END IF
            END IF
            IF NOT cl_null(g_imeb_d[l_ac].imeb010) THEN
               IF g_imeb_d[l_ac].imeb006 = '1' THEN
                  CALL aimi092_chk_chr(g_imeb_d[l_ac].imeb010) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00209'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '2' THEN
                  CALL aimi092_digcut(g_imeb_d[l_ac].imeb010,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb010
                  CALL aimi092_chk_num(g_imeb_d[l_ac].imeb010) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00172'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '3' THEN
                  CALL aimi092_chk_znum(g_imeb_d[l_ac].imeb010) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00173'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb010,'1')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL aimi092_imeb006_change()
               END IF
            END IF
            IF NOT cl_null(g_imeb_d[l_ac].imeb011) THEN
               IF g_imeb_d[l_ac].imeb006 = '1' THEN
                  CALL aimi092_chk_chr(g_imeb_d[l_ac].imeb011) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00209'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '2' THEN
                  CALL aimi092_digcut(g_imeb_d[l_ac].imeb011,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb011
                  CALL aimi092_chk_num(g_imeb_d[l_ac].imeb011) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00172'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '3' THEN
                  CALL aimi092_chk_znum(g_imeb_d[l_ac].imeb011) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00173'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi092_imeb006_change()
                  END IF
               END IF
               CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb011,'1')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL aimi092_imeb006_change()
               END IF
            END IF
            IF NOT cl_null(g_imeb_d[l_ac].imeb006) THEN
               IF l_cmd = 'u' AND g_imeb_d[l_ac].imeb006 <> g_imeb_d_t.imeb006 THEN
                  CALL aimi092_isdelete()
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb006
            #add-point:ON CHANGE imeb006 name="input.g.page1.imeb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imeb_d[l_ac].imeb007,"0.000","0","30.000","1","azz-00087",1) THEN 
 
               NEXT FIELD imeb007
            END IF 
 
 
 
            #add-point:AFTER FIELD imeb007 name="input.a.page1.imeb007"
            IF NOT cl_null(g_imeb_d[l_ac].imeb007) THEN 
               IF NOT cl_null(g_imeb_d[l_ac].imeb008) THEN
                  IF g_imeb_d[l_ac].imeb008 > = g_imeb_d[l_ac].imeb007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00168'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb007 = g_imeb_d_t.imeb007
                     NEXT FIELD imeb007
                  END IF
                  IF NOT cl_null(g_imeb_d[l_ac].imeb009) THEN
                     CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb009,'2')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_imeb_d[l_ac].imeb009 = ""
                        LET g_imeb_d[l_ac].imeb010 = ""
                        LET g_imeb_d[l_ac].imeb011 = ""
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb009
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb010
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb011
                     END IF
                  END IF
                  IF NOT cl_null(g_imeb_d[l_ac].imeb010) THEN
                     CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb010,'1')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_imeb_d[l_ac].imeb010 = ""
                        LET g_imeb_d[l_ac].imeb011 = ""
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb010
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb011
                     END IF
                  END IF
                  IF NOT cl_null(g_imeb_d[l_ac].imeb011) THEN
                     CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb011,'1')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_imeb_d[l_ac].imeb011 = ""
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb011
                     END IF
                  END IF
               END IF
               IF l_cmd = 'u' AND g_imeb_d[l_ac].imeb007 <> g_imeb_d_t.imeb007 THEN
                  CALL aimi092_isdelete()
               END IF
            END IF 
       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb007
            #add-point:BEFORE FIELD imeb007 name="input.b.page1.imeb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb007
            #add-point:ON CHANGE imeb007 name="input.g.page1.imeb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imeb_d[l_ac].imeb008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imeb008
            END IF 
 
 
 
            #add-point:AFTER FIELD imeb008 name="input.a.page1.imeb008"
            IF NOT cl_null(g_imeb_d[l_ac].imeb008) THEN 
               IF NOT cl_null(g_imeb_d[l_ac].imeb007) THEN
                  IF g_imeb_d[l_ac].imeb008 > = g_imeb_d[l_ac].imeb007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00168'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb008 = g_imeb_d_t.imeb008
                     NEXT FIELD imeb008
                  END IF
                  IF NOT cl_null(g_imeb_d[l_ac].imeb009) THEN
                     CALL aimi092_digcut(g_imeb_d[l_ac].imeb009,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb009
                     CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb009,'2')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_imeb_d[l_ac].imeb009 = ""
                        LET g_imeb_d[l_ac].imeb010 = ""
                        LET g_imeb_d[l_ac].imeb011 = ""
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb009
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb010
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb011
                     END IF
                  END IF
                  IF NOT cl_null(g_imeb_d[l_ac].imeb010) THEN
                     CALL aimi092_digcut(g_imeb_d[l_ac].imeb010,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb010
                     CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb010,'1')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_imeb_d[l_ac].imeb010 = ""
                        LET g_imeb_d[l_ac].imeb011 = ""
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb010
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb011
                     END IF
                  END IF
                  IF NOT cl_null(g_imeb_d[l_ac].imeb011) THEN
                     CALL aimi092_digcut(g_imeb_d[l_ac].imeb011,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb011
                     CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb011,'1')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_imeb_d[l_ac].imeb011 = ""
                        DISPLAY BY NAME g_imeb_d[l_ac].imeb011
                     END IF
                  END IF
               END IF
               IF l_cmd = 'u' AND g_imeb_d[l_ac].imeb008 <> g_imeb_d_t.imeb008 THEN
                  CALL aimi092_isdelete()
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb008
            #add-point:BEFORE FIELD imeb008 name="input.b.page1.imeb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb008
            #add-point:ON CHANGE imeb008 name="input.g.page1.imeb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb009
            #add-point:BEFORE FIELD imeb009 name="input.b.page1.imeb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb009
            
            #add-point:AFTER FIELD imeb009 name="input.a.page1.imeb009"
            IF NOT cl_null(g_imeb_d[l_ac].imeb009) THEN
               IF g_imeb_d[l_ac].imeb006 = '1' THEN
                  CALL aimi092_chk_chr(g_imeb_d[l_ac].imeb009) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00209'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb009 = g_imeb_d_t.imeb009
                     NEXT FIELD imeb009
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '2' THEN
                  CALL aimi092_digcut(g_imeb_d[l_ac].imeb009,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb009
                  CALL aimi092_chk_num(g_imeb_d[l_ac].imeb009) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00172'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb009 = g_imeb_d_t.imeb009
                     NEXT FIELD imeb009
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '3' THEN
                  CALL aimi092_chk_znum(g_imeb_d[l_ac].imeb009) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00173'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb009 = g_imeb_d_t.imeb009
                     NEXT FIELD imeb009
                  END IF
               END IF
               CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb009,'2')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imeb_d[l_ac].imeb009 = g_imeb_d_t.imeb009
                  NEXT FIELD imeb009
               END IF
               CALL aimi092_chk_define()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imeb_d[l_ac].imeb009 = g_imeb_d_t.imeb009
                  NEXT FIELD imeb009
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb009
            #add-point:ON CHANGE imeb009 name="input.g.page1.imeb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb010
            #add-point:BEFORE FIELD imeb010 name="input.b.page1.imeb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb010
            
            #add-point:AFTER FIELD imeb010 name="input.a.page1.imeb010"
            IF NOT cl_null(g_imeb_d[l_ac].imeb010) THEN
               IF g_imeb_d[l_ac].imeb006 = '1' THEN
                  CALL aimi092_chk_chr(g_imeb_d[l_ac].imeb010) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00209'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb010 = g_imeb_d_t.imeb010
                     NEXT FIELD imeb010
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '2' THEN
                  CALL aimi092_digcut(g_imeb_d[l_ac].imeb010,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb010
                  CALL aimi092_chk_num(g_imeb_d[l_ac].imeb010) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00172'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb010 = g_imeb_d_t.imeb010
                     NEXT FIELD imeb010
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '3' THEN
                  CALL aimi092_chk_znum(g_imeb_d[l_ac].imeb010) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00173'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb010 = g_imeb_d_t.imeb010
                     NEXT FIELD imeb010
                  END IF
               END IF
               CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb010,'1')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imeb_d[l_ac].imeb010 = g_imeb_d_t.imeb010
                  NEXT FIELD imeb010
               END IF
               CALL aimi092_chk_define()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imeb_d[l_ac].imeb010 = g_imeb_d_t.imeb010
                  NEXT FIELD imeb010
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb010
            #add-point:ON CHANGE imeb010 name="input.g.page1.imeb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb011
            #add-point:BEFORE FIELD imeb011 name="input.b.page1.imeb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb011
            
            #add-point:AFTER FIELD imeb011 name="input.a.page1.imeb011"
            IF NOT cl_null(g_imeb_d[l_ac].imeb011) THEN
               IF g_imeb_d[l_ac].imeb006 = '1' THEN
                  CALL aimi092_chk_chr(g_imeb_d[l_ac].imeb011) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00209'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb011 = g_imeb_d_t.imeb011
                     NEXT FIELD imeb011
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '2' THEN
                  CALL aimi092_digcut(g_imeb_d[l_ac].imeb011,g_imeb_d[l_ac].imeb008) RETURNING g_imeb_d[l_ac].imeb011
                  CALL aimi092_chk_num(g_imeb_d[l_ac].imeb011) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00172'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb011 = g_imeb_d_t.imeb011
                     NEXT FIELD imeb011
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '3' THEN
                  CALL aimi092_chk_znum(g_imeb_d[l_ac].imeb011) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00173'
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb011 = g_imeb_d_t.imeb011
                     NEXT FIELD imeb011
                  END IF
               END IF
               CALL aimi092_chk_imeb009(g_imeb_d[l_ac].imeb011,'1')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imeb_d[l_ac].imeb011 = g_imeb_d_t.imeb011
                  NEXT FIELD imeb011
               END IF
               CALL aimi092_chk_define()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb_d[l_ac].imeb011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imeb_d[l_ac].imeb011 = g_imeb_d_t.imeb011
                  NEXT FIELD imeb011
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb011
            #add-point:ON CHANGE imeb011 name="input.g.page1.imeb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imeb012
            #add-point:BEFORE FIELD imeb012 name="input.b.page1.imeb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imeb012
            
            #add-point:AFTER FIELD imeb012 name="input.a.page1.imeb012"
            IF g_imeb_d[l_ac].imeb012 = 'Y' THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_imeb_d[l_ac].imeb012 <> g_imeb_d_t.imeb012) THEN
                  CALL aimi092_chk_imeb012()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imeb_d[l_ac].imeb012
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb_d[l_ac].imeb012 = g_imeb_d_t.imeb012
                     NEXT FIELD imeb012
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imeb012
            #add-point:ON CHANGE imeb012 name="input.g.page1.imeb012"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb002
            #add-point:ON ACTION controlp INFIELD imeb002 name="input.c.page1.imeb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb003
            #add-point:ON ACTION controlp INFIELD imeb003 name="input.c.page1.imeb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb004
            #add-point:ON ACTION controlp INFIELD imeb004 name="input.c.page1.imeb004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imeb_d[l_ac].imeb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "273" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_imeb_d[l_ac].imeb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imeb_d[l_ac].imeb004 TO imeb004              #顯示到畫面上
            CALL aimi092_imeb_desc()
            NEXT FIELD imeb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb005
            #add-point:ON ACTION controlp INFIELD imeb005 name="input.c.page1.imeb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb013
            #add-point:ON ACTION controlp INFIELD imeb013 name="input.c.page1.imeb013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imeb_d[l_ac].imeb013             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " gzzz002 IN ( ",
                                   " SELECT DISTINCT dzag001 FROM dzag_t, ",
                                   "   (SELECT dzeb001,count(dzeb002) a FROM dzeb_t WHERE dzeb004 ='Y' AND dzeb002 NOT LIKE '%ent' AND dzeb002 NOT LIKE '%site' ",
                                   "     GROUP BY dzeb001 ",
                                   "   ) b WHERE dzag002 = b.dzeb001 AND b.a = 1 ",
                                   " UNION ",
                                   " SELECT DISTINCT dzag001 FROM dzag_t,dzeb_t WHERE dzag002 = dzeb001 AND dzeb001 ='oocq_t' ) "
 
            CALL q_gzzz001_9()                                #呼叫開窗
 
            LET g_imeb_d[l_ac].imeb013 = g_qryparam.return1     
            DISPLAY g_imeb_d[l_ac].imeb013 TO imeb013     
            CALL s_desc_get_prog_desc(g_imeb_d[l_ac].imeb013) RETURNING g_imeb_d[l_ac].imeb013_desc
            DISPLAY BY NAME g_imeb_d[l_ac].imeb013_desc            
            NEXT FIELD imeb013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb006
            #add-point:ON ACTION controlp INFIELD imeb006 name="input.c.page1.imeb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb007
            #add-point:ON ACTION controlp INFIELD imeb007 name="input.c.page1.imeb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb008
            #add-point:ON ACTION controlp INFIELD imeb008 name="input.c.page1.imeb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb009
            #add-point:ON ACTION controlp INFIELD imeb009 name="input.c.page1.imeb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb010
            #add-point:ON ACTION controlp INFIELD imeb010 name="input.c.page1.imeb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb011
            #add-point:ON ACTION controlp INFIELD imeb011 name="input.c.page1.imeb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imeb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imeb012
            #add-point:ON ACTION controlp INFIELD imeb012 name="input.c.page1.imeb012"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imeb_d[l_ac].* = g_imeb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi092_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_imeb_d[l_ac].imeb002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imeb_d[l_ac].* = g_imeb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF g_imeb_d[l_ac].imeb005 = '3' THEN
                  IF cl_null(g_imeb_d[l_ac].imeb010) AND cl_null(g_imeb_d[l_ac].imeb011) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00210'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     NEXT FIELD imeb010
                  END IF
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aimi092_imeb_t_mask_restore('restore_mask_o')
      
               UPDATE imeb_t SET (imeb001,imeb002,imeb003,imeb004,imeb005,imeb013,imeb006,imeb007,imeb008, 
                   imeb009,imeb010,imeb011,imeb012) = (g_imea_m.imea001,g_imeb_d[l_ac].imeb002,g_imeb_d[l_ac].imeb003, 
                   g_imeb_d[l_ac].imeb004,g_imeb_d[l_ac].imeb005,g_imeb_d[l_ac].imeb013,g_imeb_d[l_ac].imeb006, 
                   g_imeb_d[l_ac].imeb007,g_imeb_d[l_ac].imeb008,g_imeb_d[l_ac].imeb009,g_imeb_d[l_ac].imeb010, 
                   g_imeb_d[l_ac].imeb011,g_imeb_d[l_ac].imeb012)
                WHERE imebent = g_enterprise AND imeb001 = g_imea_m.imea001 
 
                  AND imeb002 = g_imeb_d_t.imeb002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imeb_d[l_ac].* = g_imeb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imeb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imeb_d[l_ac].* = g_imeb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imeb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imea_m.imea001
               LET gs_keys_bak[1] = g_imea001_t
               LET gs_keys[2] = g_imeb_d[g_detail_idx].imeb002
               LET gs_keys_bak[2] = g_imeb_d_t.imeb002
               CALL aimi092_update_b('imeb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aimi092_imeb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_imeb_d[g_detail_idx].imeb002 = g_imeb_d_t.imeb002 
 
                  ) THEN
                  LET gs_keys[01] = g_imea_m.imea001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_imeb_d_t.imeb002
 
                  CALL aimi092_key_update_b(gs_keys,'imeb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imea_m),util.JSON.stringify(g_imeb_d_t)
               LET g_log2 = util.JSON.stringify(g_imea_m),util.JSON.stringify(g_imeb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #160811-00017#1---s
               IF g_imeb_d[g_detail_idx].imeb002 <> g_imeb_d_t.imeb002 THEN
                  UPDATE imec_t SET imec002 = g_imeb_d[g_detail_idx].imeb002 
                      WHERE imecent = g_enterprise AND imec001 = g_imea_m.imea001 AND imec002 = g_imeb_d_t.imeb002
                  UPDATE imecl_t SET imecl002 = g_imeb_d[g_detail_idx].imeb002 
                      WHERE imeclent = g_enterprise AND imecl001 = g_imea_m.imea001 AND imecl002 = g_imeb_d_t.imeb002    
               END IF
               #160811-00017#1---e
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aimi092_unlock_b("imeb_t","'1'")
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
               LET g_imeb_d[li_reproduce_target].* = g_imeb_d[li_reproduce].*
 
               LET g_imeb_d[li_reproduce_target].imeb002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imeb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imeb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aimi092.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_imeb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
 
 
         ON ACTION update_item
 
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN 
               IF NOT cl_null(g_imeb_d[l_ac].imeb002) AND NOT cl_null(g_imeb2_d[l_ac1].imec003)  THEN
                  CALL n_imecl(g_imea_m.imea001,g_imeb_d[l_ac].imeb002,g_imeb2_d[l_ac1].imec003)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imea_m.imea001
                  LET g_ref_fields[2] = g_imeb_d[l_ac].imeb002
                  LET g_ref_fields[3] = g_imeb2_d[l_ac1].imec003
                  CALL ap_ref_array2(g_ref_fields," SELECT imecl005,imecl006 FROM imecl_t WHERE imeclent = '"
                      ||g_enterprise||"' AND imecl001 = ? AND imecl002 = ? AND imecl003 = ? AND imecl004 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imeb2_d[l_ac1].imecl005 = g_rtn_fields[1]
                  LET g_imeb2_d[l_ac1].imecl006 = g_rtn_fields[2]
                  DISPLAY BY NAME g_imeb2_d[l_ac1].imecl005
                  DISPLAY BY NAME g_imeb2_d[l_ac1].imecl006
               END IF
            END IF
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imeb2_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
 
            LET g_rec_b1 = g_imeb2_d.getLength()
            IF cl_null(g_imeb_d[l_ac].imeb002) THEN
               NEXT FIELD imeb002
            END IF
            IF g_imeb_d[l_ac].imeb005 <> '2' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00177'
               LET g_errparam.extend = g_imeb_d[l_ac].imeb005
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD imeb005
            END IF
                      
         BEFORE INSERT
                        LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imeb2_d[l_ac1].* TO NULL 
            LET g_imeb2_d[l_ac1].imecstus = 'Y'  #160426-00003#1
            LET g_imeb2_d_t.* = g_imeb2_d[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimi092_set_entry_b(l_cmd)
            CALL aimi092_set_no_entry_b(l_cmd)
            LET g_detail_multi_table_t.imecl001 = g_imea_m.imea001
            LET g_detail_multi_table_t.imecl002 = g_imeb_d[l_ac].imeb002
            LET g_detail_multi_table_t.imecl003 = g_imeb2_d[l_ac1].imec003
            LET g_detail_multi_table_t.imecl004 = g_dlang
            LET g_detail_multi_table_t.imecl005 = g_imeb2_d[l_ac1].imecl005
            LET g_detail_multi_table_t.imecl006 = g_imeb2_d[l_ac1].imecl006
            IF g_imeb_d[l_ac].imeb005 <> '2' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00177'
               LET g_errparam.extend = g_imeb_d[l_ac].imeb005
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD imeb005
            END IF

         BEFORE ROW
            LET l_insert = FALSE
            LET p_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET g_detail_idx2 = l_ac1
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac1 TO FORMONLY.idx
            CALL s_transaction_begin()
            OPEN aimi092_cl USING g_enterprise,g_imea_m.imea001
            OPEN aimi092_bcl USING g_enterprise,g_imea_m.imea001,g_imeb_d[l_ac].imeb002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aimi092_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aimi092_cl
               CLOSE aimi092_bcl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b1 = g_imeb2_d.getLength()
            
            IF g_rec_b1 >= l_ac1 
               AND NOT cl_null(g_imeb2_d[l_ac1].imec003) 
            THEN 
               LET l_cmd='u'
               LET g_imeb2_d_t.* = g_imeb2_d[l_ac1].*  #BACKUP
               CALL aimi092_set_entry_b(l_cmd)
               CALL aimi092_set_no_entry_b(l_cmd)
               OPEN aimi092_bcl2 USING g_enterprise,g_imea_m.imea001,g_imeb_d[l_ac].imeb002,g_imeb2_d[l_ac1].imec003
               IF SQLCA.sqlcode THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi092_bcl2 INTO g_imeb2_d[l_ac1].imecstus,g_imeb2_d[l_ac1].imec003   #160426-00003#1 add imecstus
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aimi092_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
           
            #其他table資料備份(確定是否更改用)
            LET g_detail_multi_table_t.imecl001 = g_imea_m.imea001
            LET g_detail_multi_table_t.imecl002 = g_imeb_d[l_ac].imeb002
            LET g_detail_multi_table_t.imecl003 = g_imeb2_d[l_ac1].imec003
            LET g_detail_multi_table_t.imecl004 = g_dlang
            LET g_detail_multi_table_t.imecl005 = g_imeb2_d[l_ac1].imecl005
            LET g_detail_multi_table_t.imecl006 = g_imeb2_d[l_ac1].imecl006
 
            #其他table進行lock
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'imecl001'
            LET l_var_keys[01] = g_imea_m.imea001
            LET l_field_keys[02] = 'imecl002'
            LET l_var_keys[02] = g_imeb_d[l_ac].imeb002
            LET l_field_keys[03] = 'imecl003'
            LET l_var_keys[03] = g_imeb2_d[l_ac1].imec003
            LET l_field_keys[04] = 'imecl004'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'imecl_t') THEN
               RETURN 
            END IF 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac1-1)
               CALL g_imeb2_d.deleteElement(l_ac1)
               NEXT FIELD imec003
            END IF
            IF NOT cl_null(g_imeb2_d[l_ac1].imec003) THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               
               DELETE FROM imec_t
                WHERE imecent = g_enterprise
                  AND imec001 = g_imea_m.imea001 
                  AND imec002 = g_imeb_d[l_ac].imeb002 
                  AND imec003 = g_imeb2_d[l_ac1].imec003
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "imec_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b1 = g_rec_b1-1
                  INITIALIZE l_var_keys_bak TO NULL
                  INITIALIZE l_field_keys TO NULL
                  LET l_field_keys[01] = 'imecl001'
                  LET l_field_keys[02] = 'imecl002'
                  LET l_field_keys[03] = 'imecl003'
#                  LET l_field_keys[03] = 'imecl004'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.imecl001
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.imecl002
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.imecl003
#                  LET l_var_keys_bak[03] = g_detail_multi_table_t.imecl004
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imecl_t')

                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aimi092_bcl
               LET l_count = g_imeb_d.getLength()
            END IF 
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imea_m.imea001
               LET gs_keys[2] = g_imeb_d[l_ac].imeb002
               LET gs_keys[3] = g_imeb2_d[l_ac1].imec003
 
            
         AFTER DELETE 
#            DELETE FROM imec_t
#             WHERE imecent = g_enterprise
#               AND imec001 = g_imea_m.imea001 
#               AND imec002 = g_imeb_d[l_ac].imeb002 
#               AND imec003 = g_imeb2_d[l_ac1].imec003
#            DELETE FROM imecl_t
#             WHERE imeclent = g_enterprise
#               AND imecl001 = g_imea_m.imea001 
#               AND imecl002 = g_imeb_d[l_ac].imeb002
#               AND imecl003 = g_imeb2_d[l_ac1].imec003               
          
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
          
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM imec_t 
             WHERE imecent = g_enterprise
               AND imec001 = g_imea_m.imea001 
               AND imec002 = g_imeb_d[l_ac].imeb002 
               AND imec003 = g_imeb2_d[l_ac1].imec003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO imec_t(imecent,imec001,imec002,imec003,imecstus)  #160426-00003#1 add imecstus
                           VALUES(g_enterprise,g_imea_m.imea001,g_imeb_d[l_ac].imeb002,g_imeb2_d[l_ac1].imec003,g_imeb2_d[l_ac1].imecstus)  #160426-00003#1 add imecstus           
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_imeb_d[l_ac1].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "imec_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_imea_m.imea001 = g_detail_multi_table_t.imecl001 AND
                  g_imeb_d[l_ac].imeb002 = g_detail_multi_table_t.imecl002 AND
                  g_imeb2_d[l_ac1].imec003 = g_detail_multi_table_t.imecl003 AND
                  g_imeb2_d[l_ac1].imecl005 = g_detail_multi_table_t.imecl005 AND 
                  g_imeb2_d[l_ac1].imecl006 = g_detail_multi_table_t.imecl006 THEN
               ELSE 
                  LET l_var_keys[01] = g_imea_m.imea001
                  LET l_field_keys[01] = 'imecl001'
                  LET l_var_keys[02] = g_imeb_d[l_ac].imeb002
                  LET l_field_keys[02] = 'imecl002'
                  LET l_var_keys[03] = g_imeb2_d[l_ac1].imec003
                  LET l_field_keys[03] = 'imecl003'
                  LET l_var_keys[04] = g_dlang
                  LET l_field_keys[04] = 'imecl004'
                  LET l_vars[01] = g_imeb2_d[l_ac1].imecl005
                  LET l_fields[01] = 'imecl005'
                  LET l_vars[02] = g_imeb2_d[l_ac1].imecl006 
                  LET l_fields[02] = 'imecl006'
                  LET l_vars[03] = g_enterprise 
                  LET l_fields[03] = 'imeclent'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.imecl001
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.imecl002
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.imecl003
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.imecl004
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imecl_t')
               END IF 
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b1 = g_rec_b1 + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_imeb2_d[l_ac1].* = g_imeb2_d_t.*
               CLOSE aimi092_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_imeb2_d[l_ac1].* = g_imeb2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身2)
               UPDATE imec_t SET (imec001,imec002,imec003,imecstus) = (g_imea_m.imea001,g_imeb_d[l_ac].imeb002,g_imeb2_d[l_ac1].imec003,g_imeb2_d[l_ac1].imecstus) #自訂欄位頁簽  #160426-00003#1 add imecstus
                WHERE imecent = g_enterprise 
                  AND imec001 = g_imea001_t
                  AND imec002 = g_imeb_d[l_ac].imeb002
                  AND imec003 = g_imeb2_d_t.imec003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_imeb2_d[l_ac1].* = g_imeb2_d_t.*
               ELSE
                  INITIALIZE gs_keys TO NULL 
                  LET gs_keys[1] = g_imea_m.imea001
                  LET gs_keys_bak[1] = g_imea001_t
                  LET gs_keys[2] = g_imeb_d[g_detail_idx].imeb002
                  LET gs_keys_bak[2] = g_imeb_d[g_detail_idx].imeb002
                  LET gs_keys[3] = g_imeb2_d[g_detail_idx2].imec003
                  LET gs_keys_bak[3] = g_imeb2_d_t.imec003
                  CALL aimi092_update_b('imec_t',gs_keys,gs_keys_bak,"'2'")
                  #資料多語言用-增/改
                  INITIALIZE l_var_keys TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  INITIALIZE l_vars TO NULL 
                  INITIALIZE l_fields TO NULL 
                  INITIALIZE l_var_keys_bak TO NULL 
                  IF g_imea_m.imea001 = g_detail_multi_table_t.imecl001 AND
                     g_imeb_d[l_ac].imeb002 = g_detail_multi_table_t.imecl002 AND
                     g_imeb2_d[l_ac1].imec003 = g_detail_multi_table_t.imecl003 AND
                     g_imeb2_d[l_ac1].imecl005 = g_detail_multi_table_t.imecl005 AND
                     g_imeb2_d[l_ac1].imecl006 = g_detail_multi_table_t.imecl006 THEN
                  ELSE 
                     LET l_var_keys[01] = g_imea_m.imea001
                     LET l_field_keys[01] = 'imecl001'
                     LET l_var_keys[02] = g_imeb_d[l_ac].imeb002
                     LET l_field_keys[02] = 'imecl002'
                     LET l_var_keys[03] = g_imeb2_d[l_ac1].imec003
                     LET l_field_keys[03] = 'imecl003'
                     LET l_var_keys[04] = g_dlang
                     LET l_field_keys[04] = 'imecl004'
                     LET l_vars[01] = g_imeb2_d[l_ac1].imecl005
                     LET l_fields[01] = 'imecl005'
                     LET l_vars[02] = g_imeb2_d[l_ac1].imecl006
                     LET l_fields[02] = 'imecl006'
                     LET l_vars[03] = g_enterprise 
                     LET l_fields[03] = 'imeclent'
                     LET l_var_keys_bak[01] = g_detail_multi_table_t.imecl001
                     LET l_var_keys_bak[02] = g_detail_multi_table_t.imecl002
                     LET l_var_keys_bak[03] = g_detail_multi_table_t.imecl003
                     LET l_var_keys_bak[04] = g_detail_multi_table_t.imecl004
                     CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imecl_t')
                     CALL aimi092_update_inaml()   #160413-00011#5
                  END IF 
 
               END IF
            END IF
       
         BEFORE FIELD imec003
            
         AFTER FIELD imec003
            IF NOT cl_null(g_imea_m.imea001) AND NOT cl_null(g_imeb_d[l_ac].imeb002) AND NOT cl_null(g_imeb2_d[l_ac1].imec003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND  g_imeb2_d[l_ac1].imec003 != g_imeb2_d_t.imec003) THEN 
                  IF NOT ap_chk_notDup(g_imeb2_d[l_ac1].imec003,"SELECT COUNT(*) FROM imec_t WHERE "||"imecent = '" ||g_enterprise|| "' AND "||"imec001 = '"||g_imea_m.imea001 ||"' AND "|| "imec002 = '"||g_imeb_d[l_ac].imeb002 ||"' AND "|| "imec003 = '"||g_imeb2_d[l_ac1].imec003 ||"'",'std-00004',0) THEN 
                     LET g_imeb2_d[l_ac1].imec003 = g_imeb2_d_t.imec003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_imeb2_d[l_ac1].imec003) THEN
               IF g_imeb_d[l_ac].imeb006 = '1' THEN
                  CALL aimi092_chk_chr(g_imeb2_d[l_ac1].imec003) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00209'
                     LET g_errparam.extend = g_imeb2_d[l_ac1].imec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb2_d[l_ac1].imec003 = g_imeb2_d_t.imec003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '2' THEN
                  CALL aimi092_digcut(g_imeb2_d[l_ac1].imec003,g_imeb_d[l_ac].imeb008) RETURNING g_imeb2_d[l_ac1].imec003
                  CALL aimi092_chk_num(g_imeb2_d[l_ac1].imec003) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00172'
                     LET g_errparam.extend = g_imeb2_d[l_ac1].imec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb2_d[l_ac1].imec003 = g_imeb2_d_t.imec003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF g_imeb_d[l_ac].imeb006 = '3' THEN
                  CALL aimi092_chk_znum(g_imeb2_d[l_ac1].imec003) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00173'
                     LET g_errparam.extend = g_imeb2_d[l_ac1].imec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imeb2_d[l_ac1].imec003 = g_imeb2_d_t.imec003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL aimi092_chk_imeb009(g_imeb2_d[l_ac1].imec003,'1')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imeb2_d[l_ac1].imec003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imeb2_d[l_ac1].imec003 = g_imeb2_d_t.imec003
                  NEXT FIELD CURRENT
               END IF
               
               #160512-00017#1---s---
               IF NOT cl_null(g_imeb_d[l_ac].imeb013) THEN
                  #根据传入的参数，作业编号找到对应程序编号,gzzz_t;
                  #再根据程序编号找到使用的对应主table,dzag_t
                  SELECT DISTINCT dzag002,gzzz004 INTO l_dzag002,l_gzzz004 FROM dzag_t,gzzz_t 
                    WHERE gzzz002 = dzag001 AND dzag005 = 'Y' AND gzzz001 = g_imeb_d[l_ac].imeb013
                  LET l_n = 0
                  IF l_dzag002 = "oocq_t" THEN
                     LET l_sql = " SELECT COUNT(*) FROM oocq_t WHERE oocqent = '",g_enterprise,"' AND oocq001 = ",l_gzzz004," AND oocq002 = '",g_imeb2_d[l_ac1].imec003,"' "  
                  ELSE
                     SELECT dzeb002 INTO l_dzeb002 FROM dzeb_t WHERE dzeb001 = l_dzag002 AND dzeb002 NOT LIKE '%ent' AND dzeb002 NOT LIKE '%site' AND dzeb004 = 'Y'
                     SELECT dzeb002 INTO l_dzeb002_1 FROM dzeb_t WHERE dzeb001 = l_dzag002 AND dzeb002 LIKE '%ent' AND dzeb004 = 'Y'
                     LET l_sql = " SELECT COUNT(*) FROM ", l_dzag002 ," WHERE ", l_dzeb002_1, " = '",g_enterprise,"' AND " ,l_dzeb002 , " = '",g_imeb2_d[l_ac1].imec003,"' "                
                  END IF
                  PREPARE aimi092_chk_count FROM l_sql
                  EXECUTE aimi092_chk_count INTO l_n  
                  IF l_n = 0 OR cl_null(l_n) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00257'
                     LET g_errparam.extend = g_imeb2_d[l_ac1].imec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_imeb2_d[l_ac1].imec003 = g_imeb2_d_t.imec003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #160512-00017#1---e---
            END IF


         ON CHANGE imec003
      
         BEFORE FIELD imecl005
           
         AFTER FIELD imecl005
        
         ON CHANGE imecl005
         
         BEFORE FIELD imecl006
           
         AFTER FIELD imecl006
        
         ON CHANGE imecl006
         
         #160512-00017#1---s---
         ON ACTION controlp INFIELD imec003         
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'            
            END IF
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imeb2_d[l_ac1].imec003            #給予default值
            
            LET g_qryparam.arg1 = g_imeb_d[l_ac].imeb013
            CALL q_imec003_3() 
            
            IF l_cmd = 'a' THEN  #160725-00014#1
               FOR l_i = 1 TO g_qryparam.str_array.getLength()
                   LET bst= base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
                   LET l_cnt = 0
                   WHILE bst.hasMoreTokens()
                      LET l_cnt = l_cnt + 1
                      CASE l_cnt
                         WHEN "1"
                            LET l_str1 = bst.nextToken()
                         WHEN "2"
                            LET l_str2 = bst.nextToken()
                         OTHERWISE
                            EXIT WHILE
                      END CASE
                   END WHILE
                   LET l_imec003 = l_str1
                   LET l_imecl005 = l_str2
                   LET l_count = 1  
                   SELECT COUNT(*) INTO l_count FROM imec_t 
                      WHERE imecent = g_enterprise
                        AND imec001 = g_imea_m.imea001 
                        AND imec002 = g_imeb_d[l_ac].imeb002 
                        AND imec003 = l_imec003
                   
                   #資料未重複, 插入新增資料
                   IF l_count = 0 THEN 
                      INSERT INTO imec_t(imecent,imec001,imec002,imec003,imecstus)  
                              VALUES(g_enterprise,g_imea_m.imea001,g_imeb_d[l_ac].imeb002,l_imec003,'Y') 
                      IF NOT cl_null(l_imecl005) THEN
                         INSERT INTO imecl_t(imeclent,imecl001,imecl002,imecl003,imecl004,imecl005)  
                              VALUES(g_enterprise,g_imea_m.imea001,g_imeb_d[l_ac].imeb002,l_imec003,g_dlang,l_imecl005) 
                      END IF
                   END IF
               END FOR
               INITIALIZE g_qryparam.str_array TO NULL
            
               CALL aimi092_b_fill_1()
               LET g_rec_b1 = g_imeb2_d.getLength()
               IF g_rec_b1 > 0 THEN
                  LET g_flag = TRUE
                  EXIT DIALOG
               ELSE
                  NEXT FIELD imec003
               END IF
               #160512-00017#1---e---
            #160725-00014#1---s
            ELSE
               LET g_imeb2_d[l_ac1].imec003 = g_qryparam.return1
               CALL s_desc_get_acc_desc('2148',g_imeb2_d[l_ac1].imec003) RETURNING g_imeb2_d[l_ac1].imecl005
               DISPLAY BY NAME g_imeb2_d[l_ac1].imec003,g_imeb2_d[l_ac1].imecl005
               NEXT FIELD imec003 
            END IF
            #160725-00014#1---e
            
         AFTER ROW
            LET l_ac1 = ARR_CURR()
            LET l_ac1_t = l_ac1
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imeb2_d[l_ac1].* = g_imeb2_d_t.*
               END IF
               CLOSE aimi092_bcl2
               CLOSE aimi092_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            CALL cl_multitable_unlock()
            CLOSE aimi092_bcl2
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
 
      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #160512-00017#1----s---
         IF g_flag THEN
            LET g_flag = FALSE
            NEXT FIELD imec003
         END IF
         #160512-00017#1----e---
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD imea001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imeb002
 
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
         #160512-00017#1--s--
         #二維輸入有勾選時，特徵值賦予的單身資料一定要輸入
         LET l_success = TRUE
         FOR l_n = 1 TO g_imeb_d.getLength()
             IF g_imeb_d[l_n].imeb012 = 'Y' THEN
                LET l_cnt = 0
                SELECT COUNT(imec003) INTO l_cnt FROM imec_t,imeb_t 
                   WHERE imecent = imebent AND imec001 = imeb001 AND imec002 = imeb002 
                     AND imebent = g_enterprise AND imeb001 = g_imea_m.imea001 AND imeb012 = 'Y'
                IF l_cnt = 0 OR cl_null(l_cnt) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aim-00256'
                   LET g_errparam.extend = g_imea_m.imea001
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET l_success = FALSE
                   EXIT FOR
                END IF
            END IF
         END FOR
         IF NOT l_success THEN
            CONTINUE DIALOG
         END IF
         #160512-00017#1---e
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
   #160512-00017#1----s---
   IF g_flag THEN
      CALL aimi092_input('u')
   END IF
   #160512-00017#1----e---
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aimi092_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF l_ac = 0 OR cl_null(l_ac) THEN
      LET l_ac =1
   END IF
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aimi092_b_fill() #單身填充
      CALL aimi092_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimi092_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   IF g_bfill = "Y" THEN  #160725-00014#1
      CALL aimi092_b_fill_1()
   END IF   #160725-00014#1
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imea_m.imea001
            CALL ap_ref_array2(g_ref_fields," SELECT imeal003 FROM imeal_t WHERE imealent = '"||g_enterprise||"' AND imeal001 = ? AND imeal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imea_m.imeal003 = g_rtn_fields[1]
            DISPLAY BY NAME g_imea_m.imeal003


#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imea_m.imeaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imea_m.imeaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imea_m.imeaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imea_m.imeaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imea_m.imeaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imea_m.imeaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imea_m.imeacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imea_m.imeacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imea_m.imeacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imea_m.imeacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imea_m.imeacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imea_m.imeacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imea_m.imeamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imea_m.imeamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imea_m.imeamodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_imea_m_mask_o.* =  g_imea_m.*
   CALL aimi092_imea_t_mask()
   LET g_imea_m_mask_n.* =  g_imea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imea_m.imea001,g_imea_m.imeal003,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
       g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp,g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp,g_imea_m.imeacrtdp_desc,g_imea_m.imeacrtdt, 
       g_imea_m.imeamodid,g_imea_m.imeamodid_desc,g_imea_m.imeamoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imea_m.imeastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_imeb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #CALL aimi092_imeb_desc()

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aimi092_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aimi092_detail_show()
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
 
{<section id="aimi092.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimi092_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE imea_t.imea001 
   DEFINE l_oldno     LIKE imea_t.imea001 
 
   DEFINE l_master    RECORD LIKE imea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE imeb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_detail2   RECORD LIKE imec_t.*
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
   
   IF g_imea_m.imea001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_imea001_t = g_imea_m.imea001
 
    
   LET g_imea_m.imea001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imea_m.imeaownid = g_user
      LET g_imea_m.imeaowndp = g_dept
      LET g_imea_m.imeacrtid = g_user
      LET g_imea_m.imeacrtdp = g_dept 
      LET g_imea_m.imeacrtdt = cl_get_current()
      LET g_imea_m.imeamodid = g_user
      LET g_imea_m.imeamoddt = cl_get_current()
      LET g_imea_m.imeastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imea_m.imeastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aimi092_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_imea_m.* TO NULL
      INITIALIZE g_imeb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aimi092_show()
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
   CALL aimi092_set_act_visible()   
   CALL aimi092_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imea001_t = g_imea_m.imea001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imeaent = " ||g_enterprise|| " AND",
                      " imea001 = '", g_imea_m.imea001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi092_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aimi092_idx_chk()
   
   LET g_data_owner = g_imea_m.imeaownid      
   LET g_data_dept  = g_imea_m.imeaowndp
   
   #功能已完成,通報訊息中心
   CALL aimi092_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aimi092_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE imeb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aimi092_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   DROP TABLE aimi092_detail1
   DROP TABLE aimi092_detail2
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imeb_t
    WHERE imebent = g_enterprise AND imeb001 = g_imea001_t
 
    INTO TEMP aimi092_detail
 
   #將key修正為調整後   
   UPDATE aimi092_detail 
      #更新key欄位
      SET imeb001 = g_imea_m.imea001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO imeb_t SELECT * FROM aimi092_detail
   
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
   DROP TABLE aimi092_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aimi092_detail1 AS ",
                "SELECT * FROM imec_t "
   PREPARE repro_tbl1 FROM ls_sql
   EXECUTE repro_tbl1
   FREE repro_tbl1
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aimi092_detail1 SELECT * FROM imec_t 
                                         WHERE imecent = g_enterprise AND imec001 = g_imea001_t

   
   #將key修正為調整後   
   UPDATE aimi092_detail1 
      #更新key欄位
      SET imec001 = g_imea_m.imea001

      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO imec_t SELECT * FROM aimi092_detail1
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   DROP TABLE aimi092_detail1
   
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aimi092_detail2 AS ",
                "SELECT * FROM imecl_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aimi092_detail2 SELECT * FROM imecl_t 
                                         WHERE imeclent = g_enterprise AND imecl001 = g_imea001_t

   
   #將key修正為調整後   
   UPDATE aimi092_detail2 
      #更新key欄位
      SET imecl001 = g_imea_m.imea001

      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO imecl_t SELECT * FROM aimi092_detail2
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   DROP TABLE aimi092_detail2
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_imea001_t = g_imea_m.imea001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aimi092_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_n              LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_imea_m.imea001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.imeal001 = g_imea_m.imea001
LET g_master_multi_table_t.imeal003 = g_imea_m.imeal003
 
   
   CALL s_transaction_begin()
 
   OPEN aimi092_cl USING g_enterprise,g_imea_m.imea001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi092_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimi092_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi092_master_referesh USING g_imea_m.imea001 INTO g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003, 
       g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp,g_imea_m.imeacrtdp, 
       g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp_desc,g_imea_m.imeamodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aimi092_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imea_m_mask_o.* =  g_imea_m.*
   CALL aimi092_imea_t_mask()
   LET g_imea_m_mask_n.* =  g_imea_m.*
   
   CALL aimi092_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM imaa_t
       WHERE imaa005 = g_imea_m.imea001
         AND imaaent  = g_enterprise
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aim-00181'
         LET g_errparam.extend = g_imea_m.imea001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimi092_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_imea001_t = g_imea_m.imea001
 
 
      DELETE FROM imea_t
       WHERE imeaent = g_enterprise AND imea001 = g_imea_m.imea001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_imea_m.imea001,":",SQLERRMESSAGE  
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
      
      DELETE FROM imeb_t
       WHERE imebent = g_enterprise AND imeb001 = g_imea_m.imea001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM imec_t
       WHERE imecent = g_enterprise
         AND imec001 = g_imea_m.imea001 
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imec_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN 
      END IF
      
      DELETE FROM imecl_t
       WHERE imeclent = g_enterprise
         AND imecl001 = g_imea_m.imea001 
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imecl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN 
      END IF
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aimi092_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_imeb_d.clear() 
 
     
      CALL aimi092_ui_browser_refresh()  
      #CALL aimi092_ui_headershow()  
      #CALL aimi092_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'imealent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.imeal001
   LET l_field_keys[02] = 'imeal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imeal_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aimi092_browser_fill("")
         CALL aimi092_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimi092_cl
 
   #功能已完成,通報訊息中心
   CALL aimi092_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aimi092.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aimi092_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_imeb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aimi092_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imeb002,imeb003,imeb004,imeb005,imeb013,imeb006,imeb007,imeb008, 
             imeb009,imeb010,imeb011,imeb012 ,t1.oocql004 ,t2.gzzal003 FROM imeb_t",   
                     " INNER JOIN imea_t ON imeaent = " ||g_enterprise|| " AND imea001 = imeb001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='273' AND t1.oocql002=imeb004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN gzzal_t t2 ON t2.gzzal001=imeb013 AND t2.gzzal002='"||g_lang||"' ",
 
                     " WHERE imebent=? AND imeb001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imeb_t.imeb002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimi092_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aimi092_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_imea_m.imea001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_imea_m.imea001 INTO g_imeb_d[l_ac].imeb002,g_imeb_d[l_ac].imeb003, 
          g_imeb_d[l_ac].imeb004,g_imeb_d[l_ac].imeb005,g_imeb_d[l_ac].imeb013,g_imeb_d[l_ac].imeb006, 
          g_imeb_d[l_ac].imeb007,g_imeb_d[l_ac].imeb008,g_imeb_d[l_ac].imeb009,g_imeb_d[l_ac].imeb010, 
          g_imeb_d[l_ac].imeb011,g_imeb_d[l_ac].imeb012,g_imeb_d[l_ac].imeb004_desc,g_imeb_d[l_ac].imeb013_desc  
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
   
   CALL g_imeb_d.deleteElement(g_imeb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aimi092_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_imeb_d.getLength()
      LET g_imeb_d_mask_o[l_ac].* =  g_imeb_d[l_ac].*
      CALL aimi092_imeb_t_mask()
      LET g_imeb_d_mask_n[l_ac].* =  g_imeb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aimi092_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM imeb_t
       WHERE imebent = g_enterprise AND
         imeb001 = ps_keys_bak[1] AND imeb002 = ps_keys_bak[2]
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
         CALL g_imeb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aimi092_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO imeb_t
                  (imebent,
                   imeb001,
                   imeb002
                   ,imeb003,imeb004,imeb005,imeb013,imeb006,imeb007,imeb008,imeb009,imeb010,imeb011,imeb012) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imeb_d[g_detail_idx].imeb003,g_imeb_d[g_detail_idx].imeb004,g_imeb_d[g_detail_idx].imeb005, 
                       g_imeb_d[g_detail_idx].imeb013,g_imeb_d[g_detail_idx].imeb006,g_imeb_d[g_detail_idx].imeb007, 
                       g_imeb_d[g_detail_idx].imeb008,g_imeb_d[g_detail_idx].imeb009,g_imeb_d[g_detail_idx].imeb010, 
                       g_imeb_d[g_detail_idx].imeb011,g_imeb_d[g_detail_idx].imeb012)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imeb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aimi092_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imeb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aimi092_imeb_t_mask_restore('restore_mask_o')
               
      UPDATE imeb_t 
         SET (imeb001,
              imeb002
              ,imeb003,imeb004,imeb005,imeb013,imeb006,imeb007,imeb008,imeb009,imeb010,imeb011,imeb012) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imeb_d[g_detail_idx].imeb003,g_imeb_d[g_detail_idx].imeb004,g_imeb_d[g_detail_idx].imeb005, 
                  g_imeb_d[g_detail_idx].imeb013,g_imeb_d[g_detail_idx].imeb006,g_imeb_d[g_detail_idx].imeb007, 
                  g_imeb_d[g_detail_idx].imeb008,g_imeb_d[g_detail_idx].imeb009,g_imeb_d[g_detail_idx].imeb010, 
                  g_imeb_d[g_detail_idx].imeb011,g_imeb_d[g_detail_idx].imeb012) 
         WHERE imebent = g_enterprise AND imeb001 = ps_keys_bak[1] AND imeb002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imeb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imeb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimi092_imeb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aimi092.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aimi092_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aimi092.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aimi092_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aimi092.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aimi092_lock_b(ps_table,ps_page)
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
   #CALL aimi092_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "imeb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aimi092_bcl USING g_enterprise,
                                       g_imea_m.imea001,g_imeb_d[g_detail_idx].imeb002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimi092_bcl:",SQLERRMESSAGE 
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
 
{<section id="aimi092.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aimi092_unlock_b(ps_table,ps_page)
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
      CLOSE aimi092_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimi092_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("imea001",TRUE)
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
 
{<section id="aimi092.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimi092_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imea001",FALSE)
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
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi092.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aimi092_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("imeb003",TRUE)
   CALL cl_set_comp_entry("imeb010,imeb011",TRUE)
   CALL cl_set_comp_entry("imeb007",TRUE)
   CALL cl_set_comp_entry("imeb008",TRUE)
   CALL cl_set_comp_entry("imeb012",TRUE)
   
   CALL cl_set_comp_entry("imeb013,imeb006",TRUE)  #160512-00017#1

   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aimi092.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aimi092_set_no_entry_b(p_cmd)
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
   IF g_imea_m.imea002 = 'N' THEN
      CALL cl_set_comp_entry("imeb003",FALSE)
      LET g_imeb_d[l_ac].imeb003 = '1'
   END IF
   IF g_imeb_d[l_ac].imeb005 <> '3' THEN
      CALL cl_set_comp_entry("imeb010,imeb011",FALSE)
      LET g_imeb_d[l_ac].imeb010 = ""
      LET g_imeb_d[l_ac].imeb011 = ""
   END IF 
   IF g_imeb_d[l_ac].imeb006 <> '2' THEN
      CALL cl_set_comp_entry("imeb008",FALSE)
      LET g_imeb_d[l_ac].imeb008 = 0
   END IF
   IF g_imeb_d[l_ac].imeb003 = '1' THEN
      CALL cl_set_comp_entry("imeb012",FALSE)
      LET g_imeb_d[l_ac].imeb012 = "N"
   END IF
   IF g_imeb_d[l_ac].imeb005 <> '1' THEN
      CALL cl_set_comp_entry("imeb007",FALSE)
      CALL cl_set_comp_entry("imeb008",FALSE)
      LET g_imeb_d[l_ac].imeb007 = ""
      LET g_imeb_d[l_ac].imeb008 = ""
   END IF
   
   #160512-00017#1---s--
   IF g_imeb_d[l_ac].imeb005 <> '2' THEN
      CALL cl_set_comp_entry("imeb013",FALSE)
      LET g_imeb_d[l_ac].imeb013 = ""
      LET g_imeb_d[l_ac].imeb013_desc = ""
   END IF 
   
   IF NOT cl_null(g_imeb_d[l_ac].imeb013) THEN
      CALL cl_set_comp_entry("imeb006",FALSE)
      LET g_imeb_d[l_ac].imeb006 = "1"
   END IF 
   #160512-00017#1---e--
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aimi092.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimi092_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimi092_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aimi092_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aimi092_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimi092_default_search()
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
      LET ls_wc = ls_wc, " imea001 = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "imea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imeb_t" 
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
 
{<section id="aimi092.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aimi092_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imea_m.imea001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aimi092_cl USING g_enterprise,g_imea_m.imea001
   IF STATUS THEN
      CLOSE aimi092_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi092_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aimi092_master_referesh USING g_imea_m.imea001 INTO g_imea_m.imea001,g_imea_m.imea002,g_imea_m.imea003, 
       g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid,g_imea_m.imeaowndp,g_imea_m.imeacrtdp, 
       g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp_desc,g_imea_m.imeamodid_desc
   
 
   #檢查是否允許此動作
   IF NOT aimi092_action_chk() THEN
      CLOSE aimi092_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imea_m.imea001,g_imea_m.imeal003,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
       g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid,g_imea_m.imeacrtid_desc, 
       g_imea_m.imeaowndp,g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp,g_imea_m.imeacrtdp_desc,g_imea_m.imeacrtdt, 
       g_imea_m.imeamodid,g_imea_m.imeamodid_desc,g_imea_m.imeamoddt
 
   CASE g_imea_m.imeastus
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
         CASE g_imea_m.imeastus
            
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
      g_imea_m.imeastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aimi092_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_imea_m.imeamodid = g_user
   LET g_imea_m.imeamoddt = cl_get_current()
   LET g_imea_m.imeastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imea_t 
      SET (imeastus,imeamodid,imeamoddt) 
        = (g_imea_m.imeastus,g_imea_m.imeamodid,g_imea_m.imeamoddt)     
    WHERE imeaent = g_enterprise AND imea001 = g_imea_m.imea001
 
    
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
      EXECUTE aimi092_master_referesh USING g_imea_m.imea001 INTO g_imea_m.imea001,g_imea_m.imea002, 
          g_imea_m.imea003,g_imea_m.imea004,g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeacrtid, 
          g_imea_m.imeaowndp,g_imea_m.imeacrtdp,g_imea_m.imeacrtdt,g_imea_m.imeamodid,g_imea_m.imeamoddt, 
          g_imea_m.imeaownid_desc,g_imea_m.imeacrtid_desc,g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp_desc, 
          g_imea_m.imeamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imea_m.imea001,g_imea_m.imeal003,g_imea_m.imea002,g_imea_m.imea003,g_imea_m.imea004, 
          g_imea_m.imeastus,g_imea_m.imeaownid,g_imea_m.imeaownid_desc,g_imea_m.imeacrtid,g_imea_m.imeacrtid_desc, 
          g_imea_m.imeaowndp,g_imea_m.imeaowndp_desc,g_imea_m.imeacrtdp,g_imea_m.imeacrtdp_desc,g_imea_m.imeacrtdt, 
          g_imea_m.imeamodid,g_imea_m.imeamodid_desc,g_imea_m.imeamoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aimi092_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi092_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi092.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aimi092_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_imeb2_d.getLength() THEN
         LET g_detail_idx2 = g_imeb2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_imeb2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_imeb2_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imeb_d.getLength() THEN
         LET g_detail_idx = g_imeb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imeb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imeb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aimi092_b_fill2(pi_idx)
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
   
   CALL aimi092_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aimi092_fill_chk(ps_idx)
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
 
{<section id="aimi092.status_show" >}
PRIVATE FUNCTION aimi092_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi092.mask_functions" >}
&include "erp/aim/aimi092_mask.4gl"
 
{</section>}
 
{<section id="aimi092.signature" >}
   
 
{</section>}
 
{<section id="aimi092.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimi092_set_pk_array()
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
   LET g_pk_array[1].values = g_imea_m.imea001
   LET g_pk_array[1].column = 'imea001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi092.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aimi092.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimi092_msgcentre_notify(lc_state)
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
   CALL aimi092_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi092.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimi092_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi092.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 同一特徵群組代碼不可有兩筆及以上相同的類型
# Memo...........:
# Usage..........: CALL aimi092_chk_imeb004(p_cmd)
# Input parameter: p_cmd 新增修改標識
# Return code....: 無
# Date & Author..: 2013/11/08 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_imeb004(p_cmd)
DEFINE l_n       LIKE type_t.num5
DEFINE p_cmd     LIKE type_t.chr1

   LET g_errno = ""
   LET l_n = 0
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n
        FROM imeb_t
       WHERE imebent = g_enterprise
         AND imeb001 = g_imea_m.imea001
         AND imeb004 = g_imeb_d[l_ac].imeb004 
   ELSE
      SELECT COUNT(*) INTO l_n
        FROM imeb_t
       WHERE imebent = g_enterprise
         AND imeb001 = g_imea_m.imea001
         AND imeb002 <> g_imeb_d[l_ac].imeb002
         AND imeb004 = g_imeb_d[l_ac].imeb004 
   END IF
   IF l_n > 0 THEN
      LET g_errno = 'aim-00167'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 檢查輸入的值長度是否與碼長一樣,如果是類型是數值檢查小數位是否大於設定的小數位數
# Memo...........:
# Usage..........: CALL aimi092_chk_imeb009(p_imeb009,p_is)
# Input parameter: p_imeb009     检查的值
#                : p_is          1：不需要检查与码长相同
#                :               2: 检查与码长是否相同
# Return code....: 無
# Date & Author..: 2013/11/08 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_imeb009(p_imeb009,p_is)
DEFINE p_imeb009       LIKE imeb_t.imeb009
DEFINE p_is            LIKE type_t.chr1
DEFINE l_length        LIKE type_t.num5
DEFINE l_length1       LIKE type_t.num5
DEFINE l_length2       LIKE type_t.num5
DEFINE p_type          STRING
DEFINE p_type1         STRING

   LET g_errno = ""
   IF cl_null(g_imeb_d[l_ac].imeb006) OR cl_null(g_imeb_d[l_ac].imeb007) OR cl_null(g_imeb_d[l_ac].imeb008) THEN
      RETURN
   END IF
   LET p_type = p_imeb009
   LET l_length = p_type.getLength()
   IF g_imeb_d[l_ac].imeb006 = '2' THEN
      LET l_length1 = p_type.getIndexOf('.',1)
      IF l_length1 = 0 THEN
         IF g_imeb_d[l_ac].imeb008 = 0 THEN
            LET l_length1 = l_length
         ELSE
            LET l_length1 = l_length + g_imeb_d[l_ac].imeb008 +1
         END IF
      ELSE
         LET p_type1 = p_type.subString(l_length1+1,l_length)
         LET l_length2 = p_type1.getLength()
         LET l_length1 = l_length1 + g_imeb_d[l_ac].imeb008
      END IF
      IF l_length2 > g_imeb_d[l_ac].imeb008 THEN
         LET g_errno = 'aim-00170'
         RETURN
      END IF
      IF p_is = '2' THEN
         IF l_length1 <> g_imeb_d[l_ac].imeb007 THEN
            LET g_errno = 'aim-00169'
            RETURN
         END IF
      END IF
   ELSE
      IF p_is = '2' THEN
         IF l_length <> g_imeb_d[l_ac].imeb007 THEN
            LET g_errno = 'aim-00169'
            RETURN
         END IF
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 單身參考欄位顯示
# Memo...........:
# Usage..........: CALL aimi092_imeb_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/08 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_imeb_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imeb_d[l_ac].imeb004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '273' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imeb_d[l_ac].imeb004_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imeb_d[l_ac].imeb004_desc
END FUNCTION
################################################################################
# Descriptions...: 單身欄位必輸設定
# Memo...........:
# Usage..........: CALL aimi092_set_required_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/08 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_set_required_b()
   IF g_imeb_d[l_ac].imeb005 = '4' THEN
      CALL cl_set_comp_required("imeb009",TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 單身欄位必輸關閉設定
# Memo...........:
# Usage..........: CALL aimi092_set_no_required_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/08 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_set_no_required_b()
    
    CALL cl_set_comp_required("imeb009",FALSE)
END FUNCTION
################################################################################
# Descriptions...: 同一個特徵群組代碼，只能有一筆資料勾選[是否橫向展開]
# Memo...........:
# Usage..........: CALL aimi092_chk_imeb012()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/11 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_imeb012()
DEFINE l_n     LIKE type_t.num5

   LET g_errno = ""
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM imeb_t
    WHERE imebent = g_enterprise
      AND imeb001 = g_imea_m.imea001
      AND imeb012 = 'Y'
   IF l_n > 0 THEN
      LET g_errno = 'aim-00171'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 檢查輸入的字符是否是數值(包含小數和負數)
# Memo...........:
# Usage..........: CALL aimi092_chk_num(p_num)
#                  RETURNING r_result
# Input parameter: p_num     要檢查的值
# Return code....: r_result TRUE 是数值格式 FALSE 非数值格式
# Date & Author..: 2013/11/11 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_num(p_num)
DEFINE p_num        LIKE ecab_t.ecab007
DEFINE r_result     LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_chr        LIKE type_t.chr1
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_pos        LIKE type_t.num5
DEFINE l_len        LIKE type_t.num5

   LET r_result = TRUE
   #数值开始的位置,含'.'
   LET l_pos = 0
   #小数点出现的次数
   LET l_cnt = 0
   LET l_len = LENGTH(p_num CLIPPED)
   #第一個字符可以是數字或負號
   IF p_num[1,1] NOT MATCHES '[-0123456789]' THEN
      LET r_result = FALSE
   END IF
   #第一個字符是'-'則第二個字符不可以是'.'
   IF p_num[1,1] = '-' AND p_num[2,2] = '.' THEN
      LET r_result = FALSE
   END IF
   #最後一個字符只能是數字
   IF p_num[l_len,l_len] NOT MATCHES '[0123456789]' THEN
      LET r_result = FALSE
   END IF
   FOR l_i = 3 TO l_len
       LET l_chr = p_num[l_i,l_i]
       IF l_chr MATCHES '[.0123456789]' THEN
          IF l_pos = 0 THEN
             LET l_pos = l_i
          END IF
          IF l_chr = '.' THEN
             LET l_cnt = l_cnt + 1
          END IF
       ELSE
          IF l_chr = ' ' AND l_pos = 0 THEN
          ELSE
             LET r_result = FALSE
          END IF
       END IF
   END FOR

   IF l_cnt > 1 THEN
      LET r_result = FALSE
   END IF

   RETURN r_result
END FUNCTION
################################################################################
# Descriptions...: 檢查輸入的字符是否是數值(包含小數和負數)
# Memo...........:
# Usage..........: CALL aimi092_chk_znum(p_num)
#                  RETURNING r_result
# Input parameter: p_num     要檢查的值
# Return code....: r_result TRUE 是数值格式 FALSE 非数值格式
# Date & Author..: 2013/11/11 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_znum(p_num)
DEFINE p_num        LIKE ecab_t.ecab007
DEFINE r_result     LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_chr        LIKE type_t.chr1
DEFINE l_len        LIKE type_t.num5

   LET r_result = TRUE
   LET l_len = LENGTH(p_num CLIPPED)
   #第一個字符可以是數字或負號
   IF p_num[1,1] NOT MATCHES '[-0123456789]' THEN
      LET r_result = FALSE
   END IF
   FOR l_i = 2 TO l_len
       LET l_chr = p_num[l_i,l_i]
       IF l_chr NOT MATCHES '[0123456789]' THEN
          LET r_result = FALSE 
       END IF
   END FOR

   RETURN r_result
END FUNCTION
################################################################################
# Descriptions...: 第二個單身填充顯示
# Memo...........:
# Usage..........: CALL aimi092_b_fill_1()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/11 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_b_fill_1()
   
   CALL g_imeb2_d.clear()
   IF l_ac = 0 OR cl_null(l_ac) THEN
      RETURN
   END IF
   IF cl_null(g_imeb_d[l_ac].imeb002) THEN
      CALL g_imeb_d.deleteElement(l_ac)
      RETURN
   END IF
   LET g_sql = "SELECT UNIQUE imecstus,imec003,imecl005,imecl006 FROM imec_t",    #160426-00003#1 add imecstus  
               "  LEFT JOIN imecl_t ON imecent = imeclent ",
               "   AND imec001 = imecl001 ",
               "   AND imec002 = imecl002 ",
               "   AND imec003 = imecl003 ",
               "   AND imecl004 = '",g_dlang,"'",
               " WHERE imecent=? AND imec001=? AND imec002=?"
         
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY  imec_t.imec003" 
                               
   PREPARE aimi092_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aimi092_pb2
   
   OPEN b_fill_curs2 USING g_enterprise,g_imea_m.imea001,g_imeb_d[l_ac].imeb002
   LET g_cnt = l_ac1
   LET l_ac1 = 1
   FOREACH b_fill_curs2 INTO g_imeb2_d[l_ac1].imecstus,g_imeb2_d[l_ac1].imec003,g_imeb2_d[l_ac1].imecl005,g_imeb2_d[l_ac1].imecl006  #160426-00003#1 add imecstus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_imeb2_d.deleteElement(g_imeb2_d.getLength())
   LET l_ac1 = g_cnt
   LET g_cnt = 0  

   FREE aimi092_pb2
END FUNCTION
################################################################################
# Descriptions...: 最大限制>=最小限制 預設值在其範圍內
# Memo...........:
# Usage..........: CALL aimi092_chk_define()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/26 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_define()
DEFINE l_imeb009     LIKE type_t.num26_10
DEFINE l_imeb010     LIKE type_t.num26_10
DEFINE l_imeb011     LIKE type_t.num26_10

   LET g_errno = ""
   IF g_imeb_d[l_ac].imeb006 = '1' THEN
      RETURN
   END IF
   LET l_imeb009 = g_imeb_d[l_ac].imeb009
   LET l_imeb010 = g_imeb_d[l_ac].imeb010
   LET l_imeb011 = g_imeb_d[l_ac].imeb011
   
   IF NOT cl_null(l_imeb010) AND NOT cl_null(l_imeb011) THEN
      IF l_imeb010 > l_imeb011 THEN
         LET g_errno = 'aim-00175'
         RETURN
      END IF
      IF NOT cl_null(l_imeb009) THEN
         IF (l_imeb009 > l_imeb011) OR (l_imeb009 < l_imeb010) THEN
            LET g_errno = 'aim-00176'
            RETURN
         END IF
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 補齊小數位數
# Memo...........:
# Usage..........: CALL aimi092_digcut(p_value,p_digit)
# Input parameter: p_value  需要設置的值
#                : p_digit  小數位數
# Return code....: r_value  補齊小數位數后的值
# Date & Author..: 2013/11/27 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_digcut(p_value,p_digit)
DEFINE p_value       LIKE type_t.chr80 
DEFINE p_digit       LIKE type_t.num5 
DEFINE r_value       LIKE type_t.chr80
DEFINE l_str         STRING
DEFINE l_num         LIKE type_t.num5 
DEFINE l_i          LIKE type_t.num5
DEFINE l_chr        LIKE type_t.chr1
DEFINE l_len        LIKE type_t.num5

#   CALL aimi092_chk_znum(p_value) RETURNING l_success
#   IF NOT l_success THEN
#      RETURN p_value
#   END IF
   LET l_len = LENGTH(p_value CLIPPED)
   #第一個字符可以是數字或負號
   IF p_value[1,1] NOT MATCHES '[-0123456789]' THEN
      RETURN p_value
   END IF
   FOR l_i = 2 TO l_len
       LET l_chr = p_value[l_i,l_i]
       IF l_chr NOT MATCHES '[0123456789.]' THEN
          RETURN p_value
       END IF
   END FOR
   IF p_digit IS NULL THEN LET p_digit=0 END IF 
   LET l_str = p_value
   LET l_num = l_str.getIndexOf('.',1)
   IF l_num > 0 THEN
      LET l_str = l_str.subString(l_num+1,l_str.getLength())
      IF l_str.getLength() > p_digit THEN
         LET r_value = p_value
         RETURN r_value
      END IF
   END IF
   CASE
        WHEN p_digit = 10 LET p_value = p_value USING '----------------&.----------'
        WHEN p_digit = 9 LET p_value = p_value USING '----------------&.---------'
        WHEN p_digit = 8 LET p_value = p_value USING '----------------&.--------'
        WHEN p_digit = 7 LET p_value = p_value USING '----------------&.-------'
        WHEN p_digit = 6 LET p_value = p_value USING '----------------&.------'
        WHEN p_digit = 5 LET p_value = p_value USING '----------------&.-----'
        WHEN p_digit = 4 LET p_value = p_value USING '----------------&.----'
        WHEN p_digit = 3 LET p_value = p_value USING '----------------&.---'
        WHEN p_digit = 2 LET p_value = p_value USING '----------------&.--'
        WHEN p_digit = 1 LET p_value = p_value USING '----------------&.-'
        WHEN p_digit = 0 LET p_value = p_value USING '----------------&'
   END CASE
   CALL s_chr_trim(p_value) RETURNING p_value
   LET r_value = p_value
   RETURN r_value
END FUNCTION
################################################################################
# Descriptions...: 單身的歸屬層級是否有'2.庫存'
# Memo...........:
# Usage..........: CALL aimi092_chk_imea002()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/12/02 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_imea002()
DEFINE l_n       LIKE type_t. num5

   LET g_errno = ""
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM imeb_t
    WHERE imebent = g_enterprise
      AND imeb001 = g_imea_m.imea001
      AND imeb003 = '2'
   IF l_n > 0 THEN
      LET g_errno = 'aim-00180'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 屬性類型修改后資料資料處理邏輯
# Memo...........:
# Usage..........: CALL aimi092_imeb006_change()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/12/02 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_imeb006_change()
   LET g_imeb_d[l_ac].imeb007 = ""
   LET g_imeb_d[l_ac].imeb008 = ""
   LET g_imeb_d[l_ac].imeb009 = ""
   LET g_imeb_d[l_ac].imeb010 = ""
   LET g_imeb_d[l_ac].imeb011 = ""
   DISPLAY BY NAME g_imeb_d[l_ac].imeb007
   DISPLAY BY NAME g_imeb_d[l_ac].imeb008
   DISPLAY BY NAME g_imeb_d[l_ac].imeb009
   DISPLAY BY NAME g_imeb_d[l_ac].imeb010
   DISPLAY BY NAME g_imeb_d[l_ac].imeb011
END FUNCTION
################################################################################
# Descriptions...: 是否删除特征值单身
# Memo...........:
# Usage..........: CALL aimi092_isdelete()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/12/02 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_isdelete()
DEFINE l_n       LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM imec_t
    WHERE imecent = g_enterprise
      AND imec001 = g_imea_m.imea001 
      AND imec002 = g_imeb_d[l_ac].imeb002 
   IF l_n > 0 THEN
      IF g_imeb_d[l_ac].imeb005 = '2' THEN
         IF cl_ask_confirm('aim-00182') THEN
            DELETE FROM imec_t
             WHERE imecent = g_enterprise
               AND imec001 = g_imea_m.imea001 
               AND imec002 = g_imeb_d[l_ac].imeb002 
            DELETE FROM imecl_t
             WHERE imeclent = g_enterprise
               AND imecl001 = g_imea_m.imea001 
               AND imecl002 = g_imeb_d[l_ac].imeb002
         END IF
      END IF
   END IF
   CALL aimi092_b_fill_1()
END FUNCTION
################################################################################
# Descriptions...: 用cl_showmsg的方式收集使用到這個特徵群組代號的資料
# Memo...........:
# Usage..........: CALL aimi092_showerrmsg()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/01/27 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_showerrmsg()
DEFINE l_imaa001       LIKE imaa_t.imaa001
DEFINE l_imca001       LIKE imca_t.imca001
DEFINE l_imba001       LIKE imba_t.imba001
DEFINE l_n             LIKE type_t.num5
DEFINE l_n1            LIKE type_t.num5
DEFINE l_n2            LIKE type_t.num5

   CALL cl_err_collect_init()

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM imaa_t
    WHERE imaa005 = g_imea_m.imea001
      AND imaaent = g_enterprise
      AND imaastus = 'Y'
   DECLARE aimi092_sel_imaa_cur CURSOR FOR
    SELECT imaa001 FROM imaa_t
     WHERE imaa005 = g_imea_m.imea001
       AND imaaent = g_enterprise
       AND imaastus = 'Y'
   FOREACH aimi092_sel_imaa_cur INTO l_imaa001
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.type ='2'
      LET g_errparam.code   = "aim-00206"  
      LET g_errparam.columns[1] = "lbl_imaa001"
      LET g_errparam.values[1] = l_imaa001 
      LET g_errparam.popup  = TRUE      
      CALL cl_err()   
      #CALL cl_errmsg("imaa001",l_imaa001,'','aim-00206',1)
   END FOREACH
   
   LET l_n1 = 0
   SELECT COUNT(*) INTO l_n1
     FROM imca_t
    WHERE imca005 = g_imea_m.imea001
      AND imcaent = g_enterprise
      AND imcastus = 'Y'
   DECLARE aimi092_sel_imca_cur CURSOR FOR
    SELECT imca001 FROM imca_t
     WHERE imca005 = g_imea_m.imea001
       AND imcaent = g_enterprise
       AND imcastus = 'Y'
   FOREACH aimi092_sel_imca_cur INTO l_imca001
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.type ='2'
      LET g_errparam.code   = "aim-00207"  
      LET g_errparam.columns[1] = "lbl_imca001"
      LET g_errparam.values[1] = l_imca001 
      LET g_errparam.popup  = TRUE      
      CALL cl_err()     
      #CALL cl_errmsg("imca001",l_imca001,'','aim-00207',1)
   END FOREACH
   
   LET l_n2 = 0
   SELECT COUNT(*) INTO l_n2
     FROM imba_t
    WHERE imba005 = g_imea_m.imea001
      AND imbaent = g_enterprise
      AND imbastus = 'Y'
   DECLARE aimi092_sel_imba_cur CURSOR FOR
    SELECT imba001 FROM imba_t
     WHERE imba005 = g_imea_m.imea001
       AND imbaent = g_enterprise
       AND imbastus = 'Y'
   FOREACH aimi092_sel_imba_cur INTO l_imba001
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.type ='2'
      LET g_errparam.code   = "aim-00208"  
      LET g_errparam.columns[1] = "lbl_imba001"
      LET g_errparam.values[1] = l_imba001 
      LET g_errparam.popup  = TRUE      
      CALL cl_err()   
     #CALL cl_errmsg("imba001",l_imba001,'','aim-00208',1)
   END FOREACH
   #160512-00017#1---s--
   #报错信息收集后一定要结束，否则会影响后面操作的报错弹窗
   #IF l_n > 0 OR l_n1 > 0 OR l_n2 > 0 THEN
   #   CALL cl_err_collect_show()
   #END IF
   CALL cl_err_collect_show()  
   #160512-00017#1---e----
END FUNCTION
################################################################################
# Descriptions...: 檢查輸入的字符是否包含'_'
# Memo...........:
# Usage..........: CALL aimi092_chk_chr(p_chr)
#                  RETURNING r_result
# Input parameter: p_chr     要檢查的值
# Return code....: r_result TRUE 是数值格式 FALSE 非数值格式
# Date & Author..: 2014/02/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi092_chk_chr(p_chr)
DEFINE p_chr        LIKE ecab_t.ecab007
DEFINE r_result     LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_chr        LIKE type_t.chr1
DEFINE l_len        LIKE type_t.num5

    LET r_result = TRUE
    LET l_len = LENGTH(p_chr CLIPPED)
    FOR l_i = 1 TO l_len
       LET l_chr = p_chr[l_i,l_i]
       IF l_chr = '_' THEN
          LET r_result = FALSE
       END IF
   END FOR
   RETURN r_result
END FUNCTION

################################################################################
# Descriptions...: 更新相应料件产品特征多语言档资料
# Memo...........:
# Usage..........: CALL aimi092_update_inaml()
# Date & Author..: 日期 By 作者
# Modify.........: #160413-00011#5
################################################################################
PRIVATE FUNCTION aimi092_update_inaml()
DEFINE l_inam001 LIKE inam_t.inam001
DEFINE l_inam002 LIKE inam_t.inam002
DEFINE l_inaml003 LIKE inaml_t.inaml003
DEFINE l_inaml004 LIKE inaml_t.inaml004
DEFINE l_success LIKE type_t.num5
DEFINE l_dlang_t   LIKE gzzy_t.gzzy001
DEFINE l_sql STRING

   LET l_sql = " SELECT inam001,inam002,inaml003 ",
               "   FROM inam_t ",
               "  INNER JOIN imaa_t ON imaaent = inament AND imaa001 = inam001 AND imaa005 ='",g_imea_m.imea001,"'",
               "  INNER JOIN inaml_t ON inament = inamlent AND inam001 = inaml001 AND inam002 = inaml002 ",
               "  WHERE inament = '",g_enterprise,"'"
   CASE g_imeb_d[l_ac].imeb002
      WHEN 1
         LET l_sql = l_sql," AND inam011 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam012 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 2
         LET l_sql = l_sql," AND inam013 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam014 = '",g_imeb2_d[l_ac1].imec003,"'"      
      WHEN 3
         LET l_sql = l_sql," AND inam015 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam016 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 4
         LET l_sql = l_sql," AND inam017 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam018 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 5
         LET l_sql = l_sql," AND inam019 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam020 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 6
         LET l_sql = l_sql," AND inam021 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam022 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 7
         LET l_sql = l_sql," AND inam023 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam024 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 8
         LET l_sql = l_sql," AND inam025 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam026 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 9
         LET l_sql = l_sql," AND inam027 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam028 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 10
         LET l_sql = l_sql," AND inam029 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam030 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 11
         LET l_sql = l_sql," AND inam031 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam032 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 12
         LET l_sql = l_sql," AND inam033 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam034 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 13
         LET l_sql = l_sql," AND inam035 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam036 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 14
         LET l_sql = l_sql," AND inam037 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam038 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 15
         LET l_sql = l_sql," AND inam039 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam040 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 16
         LET l_sql = l_sql," AND inam041 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam042 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 17
         LET l_sql = l_sql," AND inam043 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam044 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 18
         LET l_sql = l_sql," AND inam045 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam046 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 19
         LET l_sql = l_sql," AND inam047 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam048 = '",g_imeb2_d[l_ac1].imec003,"'"
      WHEN 20      
         LET l_sql = l_sql," AND inam049 = '",g_imeb_d[l_ac].imeb004,"'",
                           " AND inam050 = '",g_imeb2_d[l_ac1].imec003,"'"
   END CASE
   LET l_sql = l_sql," ORDER BY inam001,inam002,inaml003"
   LET l_dlang_t = g_dlang 
   PREPARE upd_inaml_pre FROM l_sql
   DECLARE upd_inaml_cur CURSOR FOR upd_inaml_pre
   FOREACH upd_inaml_cur INTO l_inam001,l_inam002,l_inaml003
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
      
      LET g_dlang = l_inaml003
      CALL s_feature_description(l_inam001,l_inam002) RETURNING l_success,l_inaml004
      UPDATE inaml_t
         SET inaml004 = l_inaml004
       WHERE inamlent = g_enterprise
         AND inaml001 = l_inam001
         AND inaml002 = l_inam002
         AND inaml003 = l_inaml003
   END FOREACH
   LET g_dlang = l_dlang_t
END FUNCTION

 
{</section>}
 
