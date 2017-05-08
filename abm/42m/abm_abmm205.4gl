#該程式未解開Section, 採用最新樣板產出!
{<section id="abmm205.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2017-02-15 08:53:51), PR版次:0019(2017-02-15 15:42:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000364
#+ Filename...: abmm205
#+ Description: 集團群組替代料維護作業
#+ Creator....: 02587(2013-09-10 10:47:54)
#+ Modifier...: 07804 -SD/PR- 07804
 
{</section>}
 
{<section id="abmm205.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#5  160321 By Jessy 修正azzi920重複定義之錯誤訊息
#160324-00007#1  2016/04/01 By xianghui 同步据点资料时参考研发中心的值需为1.参考研发中的才可同步
#160318-00025#39 2016/04/22 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160509-00009#6  2016/05/17 By xianghui 增加bmgc012主要栏位的checkbox
#160614-00033#1  2016/05/17 By xianghui 增加bmgc013保稅否栏位的checkbox
#160705-00024#1  2016/07/07 By xianghui 据点级作业不可新增
#160705-00042#11 2016/07/14 By sakura   程式中寫死g_prog部分改寫MATCHES方式
#161026-00034#1  2016/11/01 By 02295    程式优化
#161026-00055#1  2016/11/01 By 02295    替代页签最后一行删除时光标没有跳到上一行资料
#161102-00005#1  2016/11/03 By 02295    show中添加料件编号的品名规格的抓取
#161227-00058#1  2016/12/30 By 02295    多语言表资料复制时sql错误
#161216-00029#6  2017/01/22 By xujing   若当前BOM为失效状态，修改、删除、整单操作、明细操作中各项action不可执行
#170124-00032#1  2017/02/10 By Ann_Huang 1.調整規格,將列印功能失效
#                                        2.補join ent 條件
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
PRIVATE type type_g_bmga_m        RECORD
       bmga001 LIKE bmga_t.bmga001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   bmga002 LIKE bmga_t.bmga002, 
   bmga003 LIKE bmga_t.bmga003, 
   bmga004 LIKE bmga_t.bmga004, 
   bmga005 LIKE bmga_t.bmga005, 
   bmgal005 LIKE bmgal_t.bmgal005, 
   bmgaownid LIKE bmga_t.bmgaownid, 
   bmgaownid_desc LIKE type_t.chr80, 
   bmgaowndp LIKE bmga_t.bmgaowndp, 
   bmgaowndp_desc LIKE type_t.chr80, 
   bmgacrtid LIKE bmga_t.bmgacrtid, 
   bmgacrtid_desc LIKE type_t.chr80, 
   bmgacrtdp LIKE bmga_t.bmgacrtdp, 
   bmgacrtdp_desc LIKE type_t.chr80, 
   bmgacrtdt LIKE bmga_t.bmgacrtdt, 
   bmgamodid LIKE bmga_t.bmgamodid, 
   bmgamodid_desc LIKE type_t.chr80, 
   bmgamoddt LIKE bmga_t.bmgamoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bmgb_d        RECORD
       bmgb004 LIKE bmgb_t.bmgb004, 
   bmgb004_desc LIKE type_t.chr500, 
   bmgb004_desc_desc LIKE type_t.chr500, 
   bmgb005 LIKE bmgb_t.bmgb005, 
   bmgb005_desc LIKE type_t.chr500, 
   bmgb005_desc_desc LIKE type_t.chr500, 
   bmgb006 LIKE bmgb_t.bmgb006, 
   bmgb006_desc LIKE type_t.chr500, 
   bmgb007 LIKE bmgb_t.bmgb007, 
   bmgb007_desc LIKE type_t.chr500, 
   bmgb008 LIKE bmgb_t.bmgb008, 
   bmgb009 LIKE bmgb_t.bmgb009
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bmga001 LIKE bmga_t.bmga001,
   b_bmga001_desc LIKE type_t.chr80,
   b_bmga001_desc_desc LIKE type_t.chr80,
      b_bmga002 LIKE bmga_t.bmga002,
      b_bmga003 LIKE bmga_t.bmga003,
      b_bmga004 LIKE bmga_t.bmga004,
      b_bmga005 LIKE bmga_t.bmga005
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_bmgb2_d        RECORD
   bmgc012 LIKE bmgc_t.bmgc012,    #160509-00009#6
   bmgc004 LIKE bmgc_t.bmgc004, 
   bmgc004_desc LIKE type_t.chr80, 
   bmgc004_desc_desc LIKE type_t.chr80, 
   bmgc005 LIKE bmgc_t.bmgc005, 
   bmgc005_desc LIKE type_t.chr80, 
   bmgc005_desc_desc LIKE type_t.chr80, 
   bmgc006 LIKE bmgc_t.bmgc006, 
   bmgc006_desc LIKE type_t.chr80, 
   bmgc007 LIKE bmgc_t.bmgc007, 
   bmgc007_desc LIKE type_t.chr80, 
   bmgc008 LIKE bmgc_t.bmgc008, 
   bmgc009 LIKE bmgc_t.bmgc009,
   bmgc010 LIKE bmgc_t.bmgc010,
   bmgc011 LIKE bmgc_t.bmgc011,
   bmgc013 LIKE bmgc_t.bmgc013   #160614-00033#1
       END RECORD
DEFINE g_bmgb2_d          DYNAMIC ARRAY OF type_g_bmgb2_d
DEFINE g_bmgb2_d_t        type_g_bmgb2_d  
DEFINE g_wc_table2          STRING
DEFINE g_wc3                 STRING

#end add-point
       
#模組變數(Module Variables)
DEFINE g_bmga_m          type_g_bmga_m
DEFINE g_bmga_m_t        type_g_bmga_m
DEFINE g_bmga_m_o        type_g_bmga_m
DEFINE g_bmga_m_mask_o   type_g_bmga_m #轉換遮罩前資料
DEFINE g_bmga_m_mask_n   type_g_bmga_m #轉換遮罩後資料
 
   DEFINE g_bmga001_t LIKE bmga_t.bmga001
DEFINE g_bmga002_t LIKE bmga_t.bmga002
DEFINE g_bmga003_t LIKE bmga_t.bmga003
 
 
DEFINE g_bmgb_d          DYNAMIC ARRAY OF type_g_bmgb_d
DEFINE g_bmgb_d_t        type_g_bmgb_d
DEFINE g_bmgb_d_o        type_g_bmgb_d
DEFINE g_bmgb_d_mask_o   DYNAMIC ARRAY OF type_g_bmgb_d #轉換遮罩前資料
DEFINE g_bmgb_d_mask_n   DYNAMIC ARRAY OF type_g_bmgb_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      bmgal001 LIKE bmgal_t.bmgal001,
      bmgal002 LIKE bmgal_t.bmgal002,
      bmgal003 LIKE bmgal_t.bmgal003,
      bmgal005 LIKE bmgal_t.bmgal005
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
 
{<section id="abmm205.main" >}
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
   CALL cl_ap_init("abm","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bmga001,'','',bmga002,bmga003,bmga004,bmga005,'',bmgaownid,'',bmgaowndp, 
       '',bmgacrtid,'',bmgacrtdp,'',bmgacrtdt,bmgamodid,'',bmgamoddt", 
                      " FROM bmga_t",
                      " WHERE bmgaent= ? AND bmgasite= ? AND bmga001=? AND bmga002=? AND bmga003=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmm205_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bmga001,t0.bmga002,t0.bmga003,t0.bmga004,t0.bmga005,t0.bmgaownid, 
       t0.bmgaowndp,t0.bmgacrtid,t0.bmgacrtdp,t0.bmgacrtdt,t0.bmgamodid,t0.bmgamoddt,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011",
               " FROM bmga_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bmgaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bmgaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.bmgacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bmgacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.bmgamodid  ",
 
               " WHERE t0.bmgaent = " ||g_enterprise|| " AND t0.bmgasite = ? AND t0.bmga001 = ? AND t0.bmga002 = ? AND t0.bmga003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abmm205_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmm205 WITH FORM cl_ap_formpath("abm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abmm205_init()   
 
      #進入選單 Menu (="N")
      CALL abmm205_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abmm205
      
   END IF 
   
   CLOSE abmm205_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abmm205.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abmm205_init()
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
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL abmm205_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abmm205.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abmm205_ui_dialog()
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
            CALL abmm205_insert()
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
         INITIALIZE g_bmga_m.* TO NULL
         CALL g_bmgb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abmm205_init()
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
               
               CALL abmm205_fetch('') # reload data
               LET l_ac = 1
               CALL abmm205_ui_detailshow() #Setting the current row 
         
               CALL abmm205_idx_chk()
               #NEXT FIELD bmgb004
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_bmgb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abmm205_idx_chk()
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
               CALL abmm205_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_bmgb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL abmm205_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               CALL abmm205_idx_chk()
               LET g_current_page = 2
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL abmm205_browser_fill("")
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
               CALL abmm205_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abmm205_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abmm205_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #若執行集團級程式，則不開放切換營運中心的功能
            #IF g_prog = 'abmm205' THEN        #160705-00042#11 160714 by sakura mark      
            IF g_prog MATCHES 'abmm205' THEN   #160705-00042#11 160714 by sakura add
               CALL cl_set_act_visible("logistics", FALSE)
            ELSE
               CALL cl_set_act_visible("logistics", TRUE)
            END IF
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
                     WHEN la_wc[li_idx].tableid = "bmga_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmgb_t" 
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
               CALL abmm205_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "bmga_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bmgb_t" 
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
                  CALL abmm205_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abmm205_fetch("F")
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
               CALL abmm205_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abmm205_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm205_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abmm205_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm205_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abmm205_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm205_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abmm205_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm205_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abmm205_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abmm205_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bmgb_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[1] = base.typeInfo.create(g_bmgb2_d)
                  LET g_export_id[1]   = "s_detail2"
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
               NEXT FIELD bmgb004
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
               CALL abmm205_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abmm205_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abmm205_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abmm205_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abmm205_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abmm205_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abmm205_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abmm205_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abmm205_set_pk_array()
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
 
{<section id="abmm205.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abmm205_browser_fill(ps_page_action)
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
   #CALL g_bmgb2_d.clear()
   LET l_wc3 = g_wc3.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT bmga001,bmga002,bmga003 ",
                      " FROM bmga_t ",
                      " ",
                      " LEFT JOIN bmgb_t ON bmgbent = bmgaent AND bmgbsite = bmgasite AND bmga001 = bmgb001 AND bmga002 = bmgb002 AND bmga003 = bmgb003 ", "  ",
                      #add-point:browser_fill段sql(bmgb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN bmgal_t ON bmgalent = "||g_enterprise||" AND bmgalsite = '"||g_site||"' AND bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE bmgaent = " ||g_enterprise|| " AND bmgasite = '" ||g_site|| "' AND bmgbent = " ||g_enterprise|| " AND bmgbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bmga_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bmga001,bmga002,bmga003 ",
                      " FROM bmga_t ", 
                      "  ",
                      "  LEFT JOIN bmgal_t ON bmgalent = "||g_enterprise||" AND bmgalsite = '"||g_site||"' AND bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_dlang,"' ",
                      " WHERE bmgaent = " ||g_enterprise|| " AND bmgasite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("bmga_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc3 <> " 1=1" THEN
      LET l_sub_sql = " SELECT UNIQUE bmga001 ",
                                    ",bmga002 ",
         
                                    ",bmga003 ",
         
         
                        " FROM bmga_t ",
                              " ",
                              " LEFT JOIN bmgb_t ON bmgbent = bmgaent AND bmgbsite = bmgasite AND bmga001 = bmgb001 AND bmga002 = bmgb002 AND bmga003 = bmgb003 ",
                              " LEFT JOIN bmgc_t ON bmgcent = bmgaent AND bmgcsite = bmgasite AND bmga001 = bmgc001 AND bmga002 = bmgc002 AND bmga003 = bmgc003 ",
                              
                             #" LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"' ", #170124-00032#1 mark
                              " LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"' AND bmgalent = bmgaent ", #170124-00032#1 add 
                              " ",
                       " WHERE bmgaent = '" ||g_enterprise|| "' AND bmgasite = '" ||g_site|| "' AND bmgbent = '" ||g_enterprise|| "' AND bmgbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, " AND ", l_wc3
   ELSE          
      IF g_wc2 <> " 1=1" THEN
         #單身有輸入搜尋條件                      
         LET l_sub_sql = " SELECT UNIQUE bmga001 ",
                                       ",bmga002 ",
   
                                       ",bmga003 ",
   
   
                           " FROM bmga_t ",
                                 " ",
                                 " LEFT JOIN bmgb_t ON bmgbent = bmgaent AND bmgbsite = bmgasite AND bmga001 = bmgb001 AND bmga002 = bmgb002 AND bmga003 = bmgb003 ",
   
   
                                #" LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"' ",  #170124-00032#1 mark
                                 " LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"'  AND bmgalent = bmgaent ", #170124-00032#1 add 
                                 " ",
                          " WHERE bmgaent = '" ||g_enterprise|| "' AND bmgasite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2
    
      ELSE
         #單身未輸入搜尋條件
         LET l_sub_sql = " SELECT UNIQUE bmga001 ",
                                       ",bmga002 ",
   
                                       ",bmga003 ",
   
   
                           " FROM bmga_t ", 
                                 " ",
                                #" LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"' ",  #170124-00032#1 mark
                                 " LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"'  AND bmgalent = bmgaent ", #170124-00032#1 add
                           "WHERE bmgaent = '" ||g_enterprise|| "' AND bmgasite = '" ||g_site|| "' AND ",l_wc CLIPPED
    
      END IF
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
      INITIALIZE g_bmga_m.* TO NULL
      CALL g_bmgb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bmga001,t0.bmga002,t0.bmga003,t0.bmga004,t0.bmga005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bmgastus,t0.bmga001,t0.bmga002,t0.bmga003,t0.bmga004,t0.bmga005, 
          t1.imaal003 ,t2.imaal004 ",
                  " FROM bmga_t t0",
                  "  ",
                  "  LEFT JOIN bmgb_t ON bmgbent = bmgaent AND bmgbsite = bmgasite AND bmga001 = bmgb001 AND bmga002 = bmgb002 AND bmga003 = bmgb003 ", "  ", 
                  #add-point:browser_fill段sql(bmgb_t1) name="browser_fill.join.bmgb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.bmga001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.bmga001 AND t2.imaal002='"||g_dlang||"' ",
 
               " LEFT JOIN bmgal_t ON bmgalent = "||g_enterprise||" AND bmgalsite = '"||g_site||"' AND bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_dlang,"' ",
                  " WHERE t0.bmgaent = " ||g_enterprise|| " AND t0.bmgasite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bmga_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bmgastus,t0.bmga001,t0.bmga002,t0.bmga003,t0.bmga004,t0.bmga005, 
          t1.imaal003 ,t2.imaal004 ",
                  " FROM bmga_t t0",
                  "  ",
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.bmga001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.bmga001 AND t2.imaal002='"||g_dlang||"' ",
 
               " LEFT JOIN bmgal_t ON bmgalent = "||g_enterprise||" AND bmgalsite = '"||g_site||"' AND bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_dlang,"' ",
                  " WHERE t0.bmgaent = " ||g_enterprise|| " AND t0.bmgasite = '" ||g_site|| "' AND ",l_wc, cl_sql_add_filter("bmga_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bmga001,bmga002,bmga003 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN 
      #依照bmga001,'',bmga002,bmga003,bmga004,bmga005 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT bmgastus,bmga001,imaal003,imaal004,bmga002,bmga003,bmga004,bmga005,DENSE_RANK() OVER(ORDER BY bmga001,bmga002,bmga003 ",g_order,") AS RANK ",
                        " FROM bmga_t ",
                              " ",
                              " LEFT JOIN bmgb_t ON bmgbent = bmgaent AND bmgbsite = bmgasite AND bmga001 = bmgb001 AND bmga002 = bmgb002 AND bmga003 = bmgb003 ",
                              " LEFT JOIN bmgc_t ON bmgcent = bmgaent AND bmgcsite = bmgasite AND bmga001 = bmgc001 AND bmga002 = bmgc002 AND bmga003 = bmgc003 ",

                             #" LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"' ",  #170124-00032#1 mark
                              " LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"'  AND bmgalent = bmgaent ", #170124-00032#1 add
                              " LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=bmga001 AND imaal002='"||g_lang||"' ",
                       " ",
                       " WHERE bmgaent = '" ||g_enterprise|| "' AND bmgasite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2," AND ",l_wc3
   ELSE
      #單身有輸入查詢條件且非null
      IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
         #依照bmga001,'',bmga002,bmga003,bmga004,bmga005 Browser欄位定義(取代原本bs_sql功能)
         LET l_sql_rank = "SELECT DISTINCT bmgastus,bmga001,imaal003,imaal004,bmga002,bmga003,bmga004,bmga005,DENSE_RANK() OVER(ORDER BY bmga001,bmga002,bmga003 ",g_order,") AS RANK ",
                           " FROM bmga_t ",
                                 " ",
                                 " LEFT JOIN bmgb_t ON bmgbent = bmgaent AND bmgbsite = bmgasite AND bmga001 = bmgb001 AND bmga002 = bmgb002 AND bmga003 = bmgb003 ",
   
   
                                #" LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"' ",  #170124-00032#1 mark
                                 " LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"'  AND bmgalent = bmgaent ", #170124-00032#1 add
                                 " LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=bmga001 AND imaal002='"||g_lang||"'  ",
                          " ",
                          " WHERE bmgaent = '" ||g_enterprise|| "' AND bmgasite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2
      ELSE
         #單身無輸入資料
         LET l_sql_rank = "SELECT DISTINCT bmgastus,bmga001,imaal003,imaal004,bmga002,bmga003,bmga004,bmga005,DENSE_RANK() OVER(ORDER BY bmga001,bmga002,bmga003 ",g_order,") AS RANK ",
                          " FROM bmga_t ",
                               "  LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=bmga001 AND imaal002='"||g_lang||"'  ",
                              #"  LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"' ",  #170124-00032#1 mark
                               "  LEFT JOIN bmgal_t ON bmga001 = bmgal001 AND bmga002 = bmgal002 AND bmga003 = bmgal003 AND bmgal004 = '",g_lang,"'  AND bmgalent = bmgaent ", #170124-00032#1 add
                          " WHERE bmgaent = '" ||g_enterprise|| "' AND bmgasite = '" ||g_site|| "' AND ", l_wc
      END IF
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT bmgastus,bmga001,bmga002,bmga003,bmga004,bmga005,imaal003,imaal004 FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY bmga001,bmga002,bmga003 ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bmga_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bmga001,g_browser[g_cnt].b_bmga002, 
          g_browser[g_cnt].b_bmga003,g_browser[g_cnt].b_bmga004,g_browser[g_cnt].b_bmga005,g_browser[g_cnt].b_bmga001_desc, 
          g_browser[g_cnt].b_bmga001_desc_desc
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
         CALL abmm205_browser_mask()
      
         
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
   
   IF cl_null(g_browser[g_cnt].b_bmga001) THEN
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
   #若無資料則關閉相關功能
   #160705-00024#1---add---s  
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("INSERT",TRUE)
      #IF g_prog = 'abmm215' THEN        #160705-00042#11 160714 by sakura mark 
      IF g_prog MATCHES 'abmm215' THEN   #160705-00042#11 160714 by sakura add
         CALL cl_set_act_visible("INSERT",FALSE)
      END IF
   END IF
   #160705-00024#1---add---e  
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abmm205_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bmga_m.bmga001 = g_browser[g_current_idx].b_bmga001   
   LET g_bmga_m.bmga002 = g_browser[g_current_idx].b_bmga002   
   LET g_bmga_m.bmga003 = g_browser[g_current_idx].b_bmga003   
 
   EXECUTE abmm205_master_referesh USING g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003 INTO g_bmga_m.bmga001, 
       g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp, 
       g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt, 
       g_bmga_m.bmgaownid_desc,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp_desc, 
       g_bmga_m.bmgamodid_desc
   
   CALL abmm205_bmga_t_mask()
   CALL abmm205_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abmm205.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abmm205_ui_detailshow()
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
 
{<section id="abmm205.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abmm205_ui_browser_refresh()
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
      IF g_browser[l_i].b_bmga001 = g_bmga_m.bmga001 
         AND g_browser[l_i].b_bmga002 = g_bmga_m.bmga002 
         AND g_browser[l_i].b_bmga003 = g_bmga_m.bmga003 
 
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
 
{<section id="abmm205.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abmm205_construct()
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
   INITIALIZE g_bmga_m.* TO NULL
   CALL g_bmgb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON bmga001,imaal003,imaal004,bmga002,bmga003,bmga004,bmga005,bmgal005,bmgaownid, 
          bmgaowndp,bmgacrtid,bmgacrtdp,bmgacrtdt,bmgamodid,bmgamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bmgacrtdt>>----
         AFTER FIELD bmgacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bmgamoddt>>----
         AFTER FIELD bmgamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bmgacnfdt>>----
         
         #----<<bmgapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.bmga001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga001
            #add-point:ON ACTION controlp INFIELD bmga001 name="construct.c.bmga001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmga001  #顯示到畫面上
            DISPLAY g_qryparam.return2 TO bmga002 #目前版本 

            NEXT FIELD bmga001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga001
            #add-point:BEFORE FIELD bmga001 name="construct.b.bmga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga001
            
            #add-point:AFTER FIELD bmga001 name="construct.a.bmga001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="construct.b.imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="construct.a.imaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="construct.c.imaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="construct.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="construct.a.imaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="construct.c.imaal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga002
            #add-point:BEFORE FIELD bmga002 name="construct.b.bmga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga002
            
            #add-point:AFTER FIELD bmga002 name="construct.a.bmga002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga002
            #add-point:ON ACTION controlp INFIELD bmga002 name="construct.c.bmga002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga003
            #add-point:BEFORE FIELD bmga003 name="construct.b.bmga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga003
            
            #add-point:AFTER FIELD bmga003 name="construct.a.bmga003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga003
            #add-point:ON ACTION controlp INFIELD bmga003 name="construct.c.bmga003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga004
            #add-point:BEFORE FIELD bmga004 name="construct.b.bmga004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga004
            
            #add-point:AFTER FIELD bmga004 name="construct.a.bmga004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmga004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga004
            #add-point:ON ACTION controlp INFIELD bmga004 name="construct.c.bmga004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga005
            #add-point:BEFORE FIELD bmga005 name="construct.b.bmga005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga005
            
            #add-point:AFTER FIELD bmga005 name="construct.a.bmga005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmga005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga005
            #add-point:ON ACTION controlp INFIELD bmga005 name="construct.c.bmga005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgal005
            #add-point:BEFORE FIELD bmgal005 name="construct.b.bmgal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgal005
            
            #add-point:AFTER FIELD bmgal005 name="construct.a.bmgal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmgal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgal005
            #add-point:ON ACTION controlp INFIELD bmgal005 name="construct.c.bmgal005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bmgaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgaownid
            #add-point:ON ACTION controlp INFIELD bmgaownid name="construct.c.bmgaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgaownid  #顯示到畫面上

            NEXT FIELD bmgaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgaownid
            #add-point:BEFORE FIELD bmgaownid name="construct.b.bmgaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgaownid
            
            #add-point:AFTER FIELD bmgaownid name="construct.a.bmgaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmgaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgaowndp
            #add-point:ON ACTION controlp INFIELD bmgaowndp name="construct.c.bmgaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgaowndp  #顯示到畫面上

            NEXT FIELD bmgaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgaowndp
            #add-point:BEFORE FIELD bmgaowndp name="construct.b.bmgaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgaowndp
            
            #add-point:AFTER FIELD bmgaowndp name="construct.a.bmgaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmgacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgacrtid
            #add-point:ON ACTION controlp INFIELD bmgacrtid name="construct.c.bmgacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgacrtid  #顯示到畫面上

            NEXT FIELD bmgacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgacrtid
            #add-point:BEFORE FIELD bmgacrtid name="construct.b.bmgacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgacrtid
            
            #add-point:AFTER FIELD bmgacrtid name="construct.a.bmgacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmgacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgacrtdp
            #add-point:ON ACTION controlp INFIELD bmgacrtdp name="construct.c.bmgacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgacrtdp  #顯示到畫面上

            NEXT FIELD bmgacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgacrtdp
            #add-point:BEFORE FIELD bmgacrtdp name="construct.b.bmgacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgacrtdp
            
            #add-point:AFTER FIELD bmgacrtdp name="construct.a.bmgacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgacrtdt
            #add-point:BEFORE FIELD bmgacrtdt name="construct.b.bmgacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bmgamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgamodid
            #add-point:ON ACTION controlp INFIELD bmgamodid name="construct.c.bmgamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgamodid  #顯示到畫面上

            NEXT FIELD bmgamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgamodid
            #add-point:BEFORE FIELD bmgamodid name="construct.b.bmgamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgamodid
            
            #add-point:AFTER FIELD bmgamodid name="construct.a.bmgamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgamoddt
            #add-point:BEFORE FIELD bmgamoddt name="construct.b.bmgamoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bmgb004,bmgb005,bmgb006,bmgb007,bmgb008,bmgb009
           FROM s_detail1[1].bmgb004,s_detail1[1].bmgb005,s_detail1[1].bmgb006,s_detail1[1].bmgb007, 
               s_detail1[1].bmgb008,s_detail1[1].bmgb009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.bmgb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb004
            #add-point:ON ACTION controlp INFIELD bmgb004 name="construct.c.page1.bmgb004"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_bmga_m.bmga001
            LET g_qryparam.arg2 = g_bmga_m.bmga002
            CALL q_bmba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgb004  #顯示到畫面上
#            LET g_bmgb_d[l_ac].bmgb004 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            LET g_bmgb_d[l_ac].bmgb005 = g_qryparam.return2 #元件料號
#            LET g_bmgb_d[l_ac].bmgb006 = g_qryparam.return3 #部位編號
#            LET g_bmgb_d[l_ac].bmgb007 = g_qryparam.return4 #作業編號
#            LET g_bmgb_d[l_ac].bmgb008 = g_qryparam.return5 #製程段號
#            CALL abmm205_bmgb_desc()
#            DISPLAY BY NAME g_bmgb_d[l_ac].*             
            NEXT FIELD bmgb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb004
            #add-point:BEFORE FIELD bmgb004 name="construct.b.page1.bmgb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb004
            
            #add-point:AFTER FIELD bmgb004 name="construct.a.page1.bmgb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmgb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb005
            #add-point:ON ACTION controlp INFIELD bmgb005 name="construct.c.page1.bmgb005"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_bmba003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgb005  #顯示到畫面上

            NEXT FIELD bmgb005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb005
            #add-point:BEFORE FIELD bmgb005 name="construct.b.page1.bmgb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb005
            
            #add-point:AFTER FIELD bmgb005 name="construct.a.page1.bmgb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmgb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb006
            #add-point:ON ACTION controlp INFIELD bmgb006 name="construct.c.page1.bmgb006"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "215"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgb006  #顯示到畫面上

            NEXT FIELD bmgb006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb006
            #add-point:BEFORE FIELD bmgb006 name="construct.b.page1.bmgb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb006
            
            #add-point:AFTER FIELD bmgb006 name="construct.a.page1.bmgb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmgb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb007
            #add-point:ON ACTION controlp INFIELD bmgb007 name="construct.c.page1.bmgb007"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgb007  #顯示到畫面上

            NEXT FIELD bmgb007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb007
            #add-point:BEFORE FIELD bmgb007 name="construct.b.page1.bmgb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb007
            
            #add-point:AFTER FIELD bmgb007 name="construct.a.page1.bmgb007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb008
            #add-point:BEFORE FIELD bmgb008 name="construct.b.page1.bmgb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb008
            
            #add-point:AFTER FIELD bmgb008 name="construct.a.page1.bmgb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmgb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb008
            #add-point:ON ACTION controlp INFIELD bmgb008 name="construct.c.page1.bmgb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb009
            #add-point:BEFORE FIELD bmgb009 name="construct.b.page1.bmgb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb009
            
            #add-point:AFTER FIELD bmgb009 name="construct.a.page1.bmgb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmgb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb009
            #add-point:ON ACTION controlp INFIELD bmgb009 name="construct.c.page1.bmgb009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      CONSTRUCT g_wc_table2 ON bmgc012,bmgc004,bmgc005,bmgc006,bmgc007,bmgc008,bmgc009,bmgc010,bmgc011,bmgc013
           FROM s_detail2[1].bmgc012,s_detail2[1].bmgc004,s_detail2[1].bmgc005,s_detail2[1].bmgc006,s_detail2[1].bmgc007,s_detail2[1].bmgc008,s_detail2[1].bmgc009,s_detail2[1].bmgc010,s_detail2[1].bmgc011,    #160509-00009#6
                s_detail2[1].bmgc013  #160614-00033#1      
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_display_condition(lc_qbe_sn)


         ON ACTION controlp INFIELD bmgc004
	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_bmga_m.bmga001
            LET g_qryparam.arg2 = g_bmga_m.bmga002
            CALL q_bmba001()                           #呼叫開窗
#            LET g_bmgb2_d[l_ac].bmgc004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_qryparam.return1 TO bmgc004             
            NEXT FIELD bmgc004                     #返回原欄位
         
         ON ACTION controlp INFIELD bmgc005
	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgc005  #顯示到畫面上

            NEXT FIELD bmgc005                     #返回原欄位

         ON ACTION controlp INFIELD bmgc006
	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "215"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgc006  #顯示到畫面上

            NEXT FIELD bmgc006                     #返回原欄位
            
         ON ACTION controlp INFIELD bmgc007
	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgc007  #顯示到畫面上

            NEXT FIELD bmgc007                     #返回原欄位


         ON ACTION controlp INFIELD bmgc011
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                               #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmgc011            
            NEXT FIELD bmgc011
       
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
                  WHEN la_wc[li_idx].tableid = "bmga_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bmgb_t" 
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
   LET g_wc3 = g_wc_table2
   IF g_wc_table2 <> " 1=1" THEN
      LET g_wc3 = g_wc3 ," AND ", g_wc_table2
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abmm205_filter()
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
      CONSTRUCT g_wc_filter ON bmga001,bmga002,bmga003,bmga004,bmga005
                          FROM s_browse[1].b_bmga001,s_browse[1].b_bmga002,s_browse[1].b_bmga003,s_browse[1].b_bmga004, 
                              s_browse[1].b_bmga005
 
         BEFORE CONSTRUCT
               DISPLAY abmm205_filter_parser('bmga001') TO s_browse[1].b_bmga001
            DISPLAY abmm205_filter_parser('bmga002') TO s_browse[1].b_bmga002
            DISPLAY abmm205_filter_parser('bmga003') TO s_browse[1].b_bmga003
            DISPLAY abmm205_filter_parser('bmga004') TO s_browse[1].b_bmga004
            DISPLAY abmm205_filter_parser('bmga005') TO s_browse[1].b_bmga005
      
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
 
      CALL abmm205_filter_show('bmga001')
   CALL abmm205_filter_show('bmga002')
   CALL abmm205_filter_show('bmga003')
   CALL abmm205_filter_show('bmga004')
   CALL abmm205_filter_show('bmga005')
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abmm205_filter_parser(ps_field)
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
 
{<section id="abmm205.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abmm205_filter_show(ps_field)
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
   LET ls_condition = abmm205_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abmm205_query()
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
   CALL g_bmgb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abmm205_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abmm205_browser_fill("")
      CALL abmm205_fetch("")
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
      CALL abmm205_filter_show('bmga001')
   CALL abmm205_filter_show('bmga002')
   CALL abmm205_filter_show('bmga003')
   CALL abmm205_filter_show('bmga004')
   CALL abmm205_filter_show('bmga005')
   CALL abmm205_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abmm205_fetch("F") 
      #顯示單身筆數
      CALL abmm205_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abmm205_fetch(p_flag)
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
   
   LET g_bmga_m.bmga001 = g_browser[g_current_idx].b_bmga001
   LET g_bmga_m.bmga002 = g_browser[g_current_idx].b_bmga002
   LET g_bmga_m.bmga003 = g_browser[g_current_idx].b_bmga003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abmm205_master_referesh USING g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003 INTO g_bmga_m.bmga001, 
       g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp, 
       g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt, 
       g_bmga_m.bmgaownid_desc,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp_desc, 
       g_bmga_m.bmgamodid_desc
   
   #遮罩相關處理
   LET g_bmga_m_mask_o.* =  g_bmga_m.*
   CALL abmm205_bmga_t_mask()
   LET g_bmga_m_mask_n.* =  g_bmga_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmm205_set_act_visible()   
   CALL abmm205_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bmga_m_t.* = g_bmga_m.*
   LET g_bmga_m_o.* = g_bmga_m.*
   
   LET g_data_owner = g_bmga_m.bmgaownid      
   LET g_data_dept  = g_bmga_m.bmgaowndp
   
   #重新顯示   
   CALL abmm205_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.insert" >}
#+ 資料新增
PRIVATE FUNCTION abmm205_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
  CALL g_bmgb2_d.clear() 
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bmgb_d.clear()   
 
 
   INITIALIZE g_bmga_m.* TO NULL             #DEFAULT 設定
   
   LET g_bmga001_t = NULL
   LET g_bmga002_t = NULL
   LET g_bmga003_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bmga_m.bmgaownid = g_user
      LET g_bmga_m.bmgaowndp = g_dept
      LET g_bmga_m.bmgacrtid = g_user
      LET g_bmga_m.bmgacrtdp = g_dept 
      LET g_bmga_m.bmgacrtdt = cl_get_current()
      LET g_bmga_m.bmgamodid = g_user
      LET g_bmga_m.bmgamoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_bmga_m.bmga004 = cl_get_current()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bmga_m_t.* = g_bmga_m.*
      LET g_bmga_m_o.* = g_bmga_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL abmm205_input("a")
      
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
         INITIALIZE g_bmga_m.* TO NULL
         INITIALIZE g_bmgb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abmm205_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bmgb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abmm205_set_act_visible()   
   CALL abmm205_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bmga001_t = g_bmga_m.bmga001
   LET g_bmga002_t = g_bmga_m.bmga002
   LET g_bmga003_t = g_bmga_m.bmga003
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmgaent = " ||g_enterprise|| " AND bmgasite = '" ||g_site|| "' AND",
                      " bmga001 = '", g_bmga_m.bmga001, "' "
                      ," AND bmga002 = '", g_bmga_m.bmga002, "' "
                      ," AND bmga003 = '", g_bmga_m.bmga003, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmm205_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abmm205_cl
   
   CALL abmm205_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abmm205_master_referesh USING g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003 INTO g_bmga_m.bmga001, 
       g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp, 
       g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt, 
       g_bmga_m.bmgaownid_desc,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp_desc, 
       g_bmga_m.bmgamodid_desc
   
   
   #遮罩相關處理
   LET g_bmga_m_mask_o.* =  g_bmga_m.*
   CALL abmm205_bmga_t_mask()
   LET g_bmga_m_mask_n.* =  g_bmga_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bmga_m.bmga001,g_bmga_m.imaal003,g_bmga_m.imaal004,g_bmga_m.bmga002,g_bmga_m.bmga003, 
       g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgal005,g_bmga_m.bmgaownid,g_bmga_m.bmgaownid_desc, 
       g_bmga_m.bmgaowndp,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp, 
       g_bmga_m.bmgacrtdp_desc,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamodid_desc,g_bmga_m.bmgamoddt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_bmga_m.bmgaownid      
   LET g_data_dept  = g_bmga_m.bmgaowndp
   
   #功能已完成,通報訊息中心
   CALL abmm205_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.modify" >}
#+ 資料修改
PRIVATE FUNCTION abmm205_modify()
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
   LET g_bmga_m_t.* = g_bmga_m.*
   LET g_bmga_m_o.* = g_bmga_m.*
   
   IF g_bmga_m.bmga001 IS NULL
   OR g_bmga_m.bmga002 IS NULL
   OR g_bmga_m.bmga003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bmga001_t = g_bmga_m.bmga001
   LET g_bmga002_t = g_bmga_m.bmga002
   LET g_bmga003_t = g_bmga_m.bmga003
 
   CALL s_transaction_begin()
   
   OPEN abmm205_cl USING g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmm205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abmm205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmm205_master_referesh USING g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003 INTO g_bmga_m.bmga001, 
       g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp, 
       g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt, 
       g_bmga_m.bmgaownid_desc,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp_desc, 
       g_bmga_m.bmgamodid_desc
   
   #檢查是否允許此動作
   IF NOT abmm205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bmga_m_mask_o.* =  g_bmga_m.*
   CALL abmm205_bmga_t_mask()
   LET g_bmga_m_mask_n.* =  g_bmga_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL abmm205_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_bmga001_t = g_bmga_m.bmga001
      LET g_bmga002_t = g_bmga_m.bmga002
      LET g_bmga003_t = g_bmga_m.bmga003
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_bmga_m.bmgamodid = g_user 
LET g_bmga_m.bmgamoddt = cl_get_current()
LET g_bmga_m.bmgamodid_desc = cl_get_username(g_bmga_m.bmgamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abmm205_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE bmga_t SET (bmgamodid,bmgamoddt) = (g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt)
          WHERE bmgaent = g_enterprise AND bmgasite = g_site AND bmga001 = g_bmga001_t
            AND bmga002 = g_bmga002_t
            AND bmga003 = g_bmga003_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bmga_m.* = g_bmga_m_t.*
            CALL abmm205_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bmga_m.bmga001 != g_bmga_m_t.bmga001
      OR g_bmga_m.bmga002 != g_bmga_m_t.bmga002
      OR g_bmga_m.bmga003 != g_bmga_m_t.bmga003
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bmgb_t SET bmgb001 = g_bmga_m.bmga001
                                       ,bmgb002 = g_bmga_m.bmga002
                                       ,bmgb003 = g_bmga_m.bmga003
 
          WHERE bmgbent = g_enterprise AND bmgbsite = g_site AND bmgb001 = g_bmga_m_t.bmga001
            AND bmgb002 = g_bmga_m_t.bmga002
            AND bmgb003 = g_bmga_m_t.bmga003
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bmgb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmgb_t:",SQLERRMESSAGE 
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
   CALL abmm205_set_act_visible()   
   CALL abmm205_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bmgaent = " ||g_enterprise|| " AND bmgasite = '" ||g_site|| "' AND",
                      " bmga001 = '", g_bmga_m.bmga001, "' "
                      ," AND bmga002 = '", g_bmga_m.bmga002, "' "
                      ," AND bmga003 = '", g_bmga_m.bmga003, "' "
 
   #填到對應位置
   CALL abmm205_browser_fill("")
 
   CLOSE abmm205_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abmm205_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abmm205.input" >}
#+ 資料輸入
PRIVATE FUNCTION abmm205_input(p_cmd)
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
   DEFINE r_errno    LIKE type_t.chr10
   DEFINE l_m        LIKE type_t.num5
   DEFINE l_sql      STRING 
   DEFINE l_imaa006  LIKE imaa_t.imaa006
   DEFINE l_rate     LIKE type_t.num26_10
   DEFINE l_success  LIKE type_t.num5  
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
   DISPLAY BY NAME g_bmga_m.bmga001,g_bmga_m.imaal003,g_bmga_m.imaal004,g_bmga_m.bmga002,g_bmga_m.bmga003, 
       g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgal005,g_bmga_m.bmgaownid,g_bmga_m.bmgaownid_desc, 
       g_bmga_m.bmgaowndp,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp, 
       g_bmga_m.bmgacrtdp_desc,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamodid_desc,g_bmga_m.bmgamoddt 
 
   
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
   LET g_forupd_sql = "SELECT bmgc012,bmgc004,'','',bmgc005,'','',bmgc006,'',bmgc007,'',bmgc008,bmgc009,bmgc010,bmgc011,bmgc013 FROM bmgc_t WHERE bmgcent=? AND bmgcsite=? AND bmgc001=? AND bmgc002=? AND bmgc003=? AND bmgc004=? AND bmgc005=? AND bmgc006=? AND bmgc007=? AND bmgc008=? FOR UPDATE"   #160509-00009#6 #160614-00033#1 add bmgc013

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE abmm205_bcl1 CURSOR FROM g_forupd_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT bmgb004,bmgb005,bmgb006,bmgb007,bmgb008,bmgb009 FROM bmgb_t WHERE bmgbent=?  
       AND bmgbsite=? AND bmgb001=? AND bmgb002=? AND bmgb003=? AND bmgb004=? AND bmgb005=? AND bmgb006=?  
       AND bmgb007=? AND bmgb008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmm205_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abmm205_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abmm205_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bmga_m.bmga001,g_bmga_m.imaal003,g_bmga_m.imaal004,g_bmga_m.bmga002,g_bmga_m.bmga003, 
       g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgal005
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abmm205.input.head" >}
      #單頭段
      INPUT BY NAME g_bmga_m.bmga001,g_bmga_m.imaal003,g_bmga_m.imaal004,g_bmga_m.bmga002,g_bmga_m.bmga003, 
          g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgal005 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_site) THEN
                  CALL n_bmgal(g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_site
                  LET g_ref_fields[2] = g_bmga_m.bmga001
                  IF g_bmga_m.bmga002 IS NULL THEN
                     LET g_bmga_m.bmga002 = ' '
                  END IF   
                  LET g_ref_fields[3] = g_bmga_m.bmga002
                  LET g_ref_fields[4] = g_bmga_m.bmga003
                  
                  CALL ap_ref_array2(g_ref_fields," SELECT bmgal005 FROM bmgal_t WHERE bmgalent = '"||g_enterprise||"' AND bmgalsite=? AND bmgal001 = ? 
                                     AND bmgal002 = ? AND bmgal003 = ? AND bmgal004 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_bmga_m.bmgal005 = g_rtn_fields[1]
                  DISPLAY BY NAME g_bmga_m.bmgal005   
               END IF                  
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abmm205_cl USING g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmm205_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abmm205_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.bmgal001 = g_bmga_m.bmga001
LET g_master_multi_table_t.bmgal002 = g_bmga_m.bmga002
LET g_master_multi_table_t.bmgal003 = g_bmga_m.bmga003
LET g_master_multi_table_t.bmgal005 = g_bmga_m.bmgal005
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.bmgal001 = ''
LET g_master_multi_table_t.bmgal002 = ''
LET g_master_multi_table_t.bmgal003 = ''
LET g_master_multi_table_t.bmgal005 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abmm205_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
             
            #end add-point
            CALL abmm205_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga001
            #add-point:BEFORE FIELD bmga001 name="input.b.bmga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga001
            
            #add-point:AFTER FIELD bmga001 name="input.a.bmga001"
            #此段落由子樣板a05產生
            LET r_errno = ''
            CALL abmm205_bmga_desc()
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t  OR g_bmga_m.bmga002 != g_bmga002_t  OR g_bmga_m.bmga003 != g_bmga003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmga_t WHERE "||"bmgaent = '" ||g_enterprise|| "' AND "||"bmgasite = '"||g_site || "' AND "||"bmga001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmga002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmga003 = '"||g_bmga_m.bmga003 ||"'",'std-00004',1) THEN 
                     LET g_bmga_m.bmga001 = g_bmga001_t
                     CALL abmm205_bmga_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bmga_m.bmga001) THEN
               CALL abmm205_bmga_chk() RETURNING r_errno     
               IF NOT cl_null(r_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmga_m.bmga001
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'abmm200'
                  LET g_errparam.replace[2] = cl_get_progname('abmm200',g_lang,"2")
                  LET g_errparam.exeprog = 'abmm200'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmga_m.bmga001 = g_bmga001_t
                  CALL abmm205_bmga_desc()
                  NEXT FIELD bmga001
               END IF 
            END IF 
            IF cl_null(g_bmga_m.bmga002) THEN 
               LET g_bmga_m.bmga002 = ' '
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmga001
            #add-point:ON CHANGE bmga001 name="input.g.bmga001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="input.b.imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="input.a.imaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal003
            #add-point:ON CHANGE imaal003 name="input.g.imaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="input.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="input.a.imaal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal004
            #add-point:ON CHANGE imaal004 name="input.g.imaal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga002
            #add-point:BEFORE FIELD bmga002 name="input.b.bmga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga002
            
            #add-point:AFTER FIELD bmga002 name="input.a.bmga002"
            #此段落由子樣板a05產生
#            IF cl_null(g_bmga_m.bmga002) THEN 
#               LET g_bmga_m.bmga002 = ' '
#            END IF   
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t  OR g_bmga_m.bmga002 != g_bmga002_t  OR g_bmga_m.bmga003 != g_bmga003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmga_t WHERE "||"bmgaent = '" ||g_enterprise|| "' AND "||"bmgasite = '"||g_site || "' AND "||"bmga001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmga002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmga003 = '"||g_bmga_m.bmga003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_bmga_m.bmga002 IS NOT NULL THEN 
               CALL abmm205_bmga_chk() RETURNING r_errno     
               IF NOT cl_null(r_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmga_m.bmga002
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'abmm200'
                  LET g_errparam.replace[2] = cl_get_progname('abmm200',g_lang,"2")
                  LET g_errparam.exeprog = 'abmm200'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
             
                  LET g_bmga_m.bmga002 = g_bmga002_t
                  NEXT FIELD bmga002
               END IF
           END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmga002
            #add-point:ON CHANGE bmga002 name="input.g.bmga002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga003
            #add-point:BEFORE FIELD bmga003 name="input.b.bmga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga003
            
            #add-point:AFTER FIELD bmga003 name="input.a.bmga003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t  OR g_bmga_m.bmga002 != g_bmga002_t  OR g_bmga_m.bmga003 != g_bmga003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmga_t WHERE "||"bmgaent = '" ||g_enterprise|| "' AND "||"bmgasite = '"||g_site || "' AND "||"bmga001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmga002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmga003 = '"||g_bmga_m.bmga003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmga003
            #add-point:ON CHANGE bmga003 name="input.g.bmga003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga004
            #add-point:BEFORE FIELD bmga004 name="input.b.bmga004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga004
            
            #add-point:AFTER FIELD bmga004 name="input.a.bmga004"
            IF NOT cl_null(g_bmga_m.bmga004) AND NOT cl_null(g_bmga_m.bmga005) THEN
               IF g_bmga_m.bmga004 > g_bmga_m.bmga005 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00047'
                  LET g_errparam.extend = g_bmga_m.bmga005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmga_m.bmga004 = g_bmga_m_t.bmga004
                  NEXT FIELD bmga004
               END IF
            END IF  
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmga004
            #add-point:ON CHANGE bmga004 name="input.g.bmga004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmga005
            #add-point:BEFORE FIELD bmga005 name="input.b.bmga005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmga005
            
            #add-point:AFTER FIELD bmga005 name="input.a.bmga005"
            IF NOT cl_null(g_bmga_m.bmga004) AND NOT cl_null(g_bmga_m.bmga005) THEN
               IF g_bmga_m.bmga004 > g_bmga_m.bmga005 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00048'
                  LET g_errparam.extend = g_bmga_m.bmga004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmga_m.bmga005 = g_bmga_m_t.bmga005
                  NEXT FIELD bmga005
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmga005
            #add-point:ON CHANGE bmga005 name="input.g.bmga005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgal005
            #add-point:BEFORE FIELD bmgal005 name="input.b.bmgal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgal005
            
            #add-point:AFTER FIELD bmgal005 name="input.a.bmgal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmgal005
            #add-point:ON CHANGE bmgal005 name="input.g.bmgal005"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bmga001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga001
            #add-point:ON ACTION controlp INFIELD bmga001 name="input.c.bmga001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmga_m.bmga001             #給予default值
            #LET g_qryparam.default2 = " " #g_bmga_m.imaa002 #目前版本
            LET g_qryparam.default2 = g_bmga_m.bmga002 #目前版本
            #給予arg

            CALL q_bmaa001_1()                                #呼叫開窗

            LET g_bmga_m.bmga001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bmga_m.bmga002 = g_qryparam.return2 #目前版本
            
            DISPLAY g_bmga_m.bmga001 TO bmga001              #顯示到畫面上
            DISPLAY g_bmga_m.bmga002 TO bmga002 #目前版本

            NEXT FIELD bmga001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="input.c.imaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="input.c.imaal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga002
            #add-point:ON ACTION controlp INFIELD bmga002 name="input.c.bmga002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga003
            #add-point:ON ACTION controlp INFIELD bmga003 name="input.c.bmga003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmga004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga004
            #add-point:ON ACTION controlp INFIELD bmga004 name="input.c.bmga004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmga005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmga005
            #add-point:ON ACTION controlp INFIELD bmga005 name="input.c.bmga005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmgal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgal005
            #add-point:ON ACTION controlp INFIELD bmgal005 name="input.c.bmgal005"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  IF cl_null(g_bmga_m.bmga002) THEN
                      LET g_bmga_m.bmga002 = ' '
                  END IF 
                  CALL abmm205_bmga_chk() RETURNING r_errno     
                  IF NOT cl_null(r_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = r_errno
                     LET g_errparam.extend = g_bmga_m.bmga001
                     #160318-00005#5 --s add
                     LET g_errparam.replace[1] = 'abmm200'
                     LET g_errparam.replace[2] = cl_get_progname('abmm200',g_lang,"2")
                     LET g_errparam.exeprog = 'abmm200'
                     #160318-00005#5 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD bmga002
                  END IF                  
               #end add-point
               
               INSERT INTO bmga_t (bmgaent, bmgasite,bmga001,bmga002,bmga003,bmga004,bmga005,bmgaownid, 
                   bmgaowndp,bmgacrtid,bmgacrtdp,bmgacrtdt,bmgamodid,bmgamoddt)
               VALUES (g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmga_m.bmga004, 
                   g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp,g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtdp, 
                   g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bmga_m:",SQLERRMESSAGE 
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
         IF g_bmga_m.bmga001 = g_master_multi_table_t.bmgal001 AND
         g_bmga_m.bmga002 = g_master_multi_table_t.bmgal002 AND
         g_bmga_m.bmga003 = g_master_multi_table_t.bmgal003 AND
         g_bmga_m.bmgal005 = g_master_multi_table_t.bmgal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'bmgalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_site
            LET l_field_keys[02] = 'bmgalsite'
            LET l_var_keys_bak[02] = g_site
            LET l_var_keys[03] = g_bmga_m.bmga001
            LET l_field_keys[03] = 'bmgal001'
            LET l_var_keys_bak[03] = g_master_multi_table_t.bmgal001
            LET l_var_keys[04] = g_bmga_m.bmga002
            LET l_field_keys[04] = 'bmgal002'
            LET l_var_keys_bak[04] = g_master_multi_table_t.bmgal002
            LET l_var_keys[05] = g_bmga_m.bmga003
            LET l_field_keys[05] = 'bmgal003'
            LET l_var_keys_bak[05] = g_master_multi_table_t.bmgal003
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'bmgal004'
            LET l_var_keys_bak[06] = g_dlang
            LET l_vars[01] = g_bmga_m.bmgal005
            LET l_fields[01] = 'bmgal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bmgal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #IF g_prog = 'abmm205' THEN    #160324-00007#1        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'abmm205' THEN    #160324-00007#1   #160705-00042#11 160714 by sakura add
                  CALL abmm205_allsite('1')
               END IF     #160324-00007#1
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abmm205_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abmm205_b_fill()
                  CALL abmm205_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
                  IF cl_null(g_bmga_m.bmga002) THEN
                      LET g_bmga_m.bmga002 = ' '
                  END IF 
                  CALL abmm205_bmga_chk() RETURNING r_errno     
                  IF NOT cl_null(r_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = r_errno
                     LET g_errparam.extend = g_bmga_m.bmga001
                     #160318-00005#5 --s add
                     LET g_errparam.replace[1] = 'abmm200'
                     LET g_errparam.replace[2] = cl_get_progname('abmm200',g_lang,"2")
                     LET g_errparam.exeprog = 'abmm200'
                     #160318-00005#5 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD bmga002
                  END IF 
               #end add-point
               
               #將遮罩欄位還原
               CALL abmm205_bmga_t_mask_restore('restore_mask_o')
               
               UPDATE bmga_t SET (bmga001,bmga002,bmga003,bmga004,bmga005,bmgaownid,bmgaowndp,bmgacrtid, 
                   bmgacrtdp,bmgacrtdt,bmgamodid,bmgamoddt) = (g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003, 
                   g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp,g_bmga_m.bmgacrtid, 
                   g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt)
                WHERE bmgaent = g_enterprise AND bmgasite = g_site AND bmga001 = g_bmga001_t
                  AND bmga002 = g_bmga002_t
                  AND bmga003 = g_bmga003_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bmga_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #IF g_prog = 'abmm205' THEN   #160324-00007#1        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'abmm205' THEN   #160324-00007#1   #160705-00042#11 160714 by sakura add
                  UPDATE bmga_t SET (bmga001,bmga002,bmga003,bmga004,bmga005,bmgaownid,bmgaowndp,bmgacrtid, 
                      bmgacrtdp,bmgacrtdt,bmgamodid,bmgamoddt) = (g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003, 
                      g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp,g_bmga_m.bmgacrtid, 
                      g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt)
                   WHERE bmgaent = g_enterprise AND bmgasite <> g_site AND bmga001 = g_bmga001_t
                     AND bmga002 = g_bmga002_t
                     AND bmga003 = g_bmga003_t
                     
                  UPDATE bmgal_t
                     SET bmgal005 = g_bmga_m.bmgal005
                   WHERE bmgaent = g_enterprise 
                     AND bmgasite <> g_site 
                     AND bmga001 = g_bmga001_t
                     AND bmga002 = g_bmga002_t
                     AND bmga003 = g_bmga003_t
                     AND bmga004 = g_dlang                     
               END IF   #160324-00007#1
                              
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_bmga_m.bmga001 = g_master_multi_table_t.bmgal001 AND
         g_bmga_m.bmga002 = g_master_multi_table_t.bmgal002 AND
         g_bmga_m.bmga003 = g_master_multi_table_t.bmgal003 AND
         g_bmga_m.bmgal005 = g_master_multi_table_t.bmgal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'bmgalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_site
            LET l_field_keys[02] = 'bmgalsite'
            LET l_var_keys_bak[02] = g_site
            LET l_var_keys[03] = g_bmga_m.bmga001
            LET l_field_keys[03] = 'bmgal001'
            LET l_var_keys_bak[03] = g_master_multi_table_t.bmgal001
            LET l_var_keys[04] = g_bmga_m.bmga002
            LET l_field_keys[04] = 'bmgal002'
            LET l_var_keys_bak[04] = g_master_multi_table_t.bmgal002
            LET l_var_keys[05] = g_bmga_m.bmga003
            LET l_field_keys[05] = 'bmgal003'
            LET l_var_keys_bak[05] = g_master_multi_table_t.bmgal003
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'bmgal004'
            LET l_var_keys_bak[06] = g_dlang
            LET l_vars[01] = g_bmga_m.bmgal005
            LET l_fields[01] = 'bmgal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bmgal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL abmm205_bmga_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bmga_m_t)
               LET g_log2 = util.JSON.stringify(g_bmga_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bmga001_t = g_bmga_m.bmga001
            LET g_bmga002_t = g_bmga_m.bmga002
            LET g_bmga003_t = g_bmga_m.bmga003
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abmm205.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bmgb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmgb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmm205_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bmgb_d.getLength()
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
            OPEN abmm205_cl USING g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmm205_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abmm205_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bmgb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmgb_d[l_ac].bmgb004 IS NOT NULL
               AND g_bmgb_d[l_ac].bmgb005 IS NOT NULL
               AND g_bmgb_d[l_ac].bmgb006 IS NOT NULL
               AND g_bmgb_d[l_ac].bmgb007 IS NOT NULL
               AND g_bmgb_d[l_ac].bmgb008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bmgb_d_t.* = g_bmgb_d[l_ac].*  #BACKUP
               LET g_bmgb_d_o.* = g_bmgb_d[l_ac].*  #BACKUP
               CALL abmm205_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL abmm205_set_no_entry_b(l_cmd)
               IF NOT abmm205_lock_b("bmgb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmm205_bcl INTO g_bmgb_d[l_ac].bmgb004,g_bmgb_d[l_ac].bmgb005,g_bmgb_d[l_ac].bmgb006, 
                      g_bmgb_d[l_ac].bmgb007,g_bmgb_d[l_ac].bmgb008,g_bmgb_d[l_ac].bmgb009
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bmgb_d_t.bmgb004,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bmgb_d_mask_o[l_ac].* =  g_bmgb_d[l_ac].*
                  CALL abmm205_bmgb_t_mask()
                  LET g_bmgb_d_mask_n[l_ac].* =  g_bmgb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abmm205_show()
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
            INITIALIZE g_bmgb_d[l_ac].* TO NULL 
            INITIALIZE g_bmgb_d_t.* TO NULL 
            INITIALIZE g_bmgb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_bmgb_d[l_ac].bmgb009 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_bmgb_d_t.* = g_bmgb_d[l_ac].*     #新輸入資料
            LET g_bmgb_d_o.* = g_bmgb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmm205_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL abmm205_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmgb_d[li_reproduce_target].* = g_bmgb_d[li_reproduce].*
 
               LET g_bmgb_d[li_reproduce_target].bmgb004 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb005 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb006 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb007 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb008 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_bmgb_d[l_ac].bmgb004 = g_bmga_m.bmga001
            LET g_bmgb_d_t.* = g_bmgb_d[l_ac].*     #新輸入資料
            LET g_bmgb_d_o.* = g_bmgb_d[l_ac].*     #新輸入資料            
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
            IF cl_null(g_bmgb_d[g_detail_idx].bmgb006) THEN
               LET g_bmgb_d[g_detail_idx].bmgb006 = ' '
            END IF 
            IF cl_null(g_bmgb_d[g_detail_idx].bmgb007) THEN
               LET g_bmgb_d[g_detail_idx].bmgb007 = ' '
            END IF
            IF cl_null(g_bmgb_d[g_detail_idx].bmgb008) THEN
               LET g_bmgb_d[g_detail_idx].bmgb008 = ' '
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bmgb_t 
             WHERE bmgbent = g_enterprise AND bmgbsite = g_site AND bmgb001 = g_bmga_m.bmga001
               AND bmgb002 = g_bmga_m.bmga002
               AND bmgb003 = g_bmga_m.bmga003
 
               AND bmgb004 = g_bmgb_d[l_ac].bmgb004
               AND bmgb005 = g_bmgb_d[l_ac].bmgb005
               AND bmgb006 = g_bmgb_d[l_ac].bmgb006
               AND bmgb007 = g_bmgb_d[l_ac].bmgb007
               AND bmgb008 = g_bmgb_d[l_ac].bmgb008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmga_m.bmga001
               LET gs_keys[2] = g_bmga_m.bmga002
               LET gs_keys[3] = g_bmga_m.bmga003
               LET gs_keys[4] = g_bmgb_d[g_detail_idx].bmgb004
               LET gs_keys[5] = g_bmgb_d[g_detail_idx].bmgb005
               LET gs_keys[6] = g_bmgb_d[g_detail_idx].bmgb006
               LET gs_keys[7] = g_bmgb_d[g_detail_idx].bmgb007
               LET gs_keys[8] = g_bmgb_d[g_detail_idx].bmgb008
               CALL abmm205_insert_b('bmgb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bmgb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmgb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abmm205_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #IF g_prog = 'abmm205' THEN      #160324-00007#1        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'abmm205' THEN      #160324-00007#1   #160705-00042#11 160714 by sakura add
                  CALL abmm205_allsite('2')
               END IF                          #160324-00007#1
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
               LET gs_keys[01] = g_bmga_m.bmga001
               LET gs_keys[gs_keys.getLength()+1] = g_bmga_m.bmga002
               LET gs_keys[gs_keys.getLength()+1] = g_bmga_m.bmga003
 
               LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb004
               LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb005
               LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb006
               LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb007
               LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb008
 
            
               #刪除同層單身
               IF NOT abmm205_delete_b('bmgb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abmm205_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abmm205_key_delete_b(gs_keys,'bmgb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abmm205_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abmm205_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_bmgb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bmgb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb004
            
            #add-point:AFTER FIELD bmgb004 name="input.a.page1.bmgb004"
            #此段落由子樣板a05產生
            CALL abmm205_bmgb_desc()
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb_d[l_ac].bmgb004) AND NOT cl_null(g_bmgb_d[l_ac].bmgb005) AND g_bmgb_d[l_ac].bmgb006 IS NOT NULL AND g_bmgb_d[l_ac].bmgb007 IS NOT NULL AND g_bmgb_d[l_ac].bmgb008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb_d[l_ac].bmgb004 != g_bmgb_d_t.bmgb004 OR g_bmgb_d[l_ac].bmgb005 != g_bmgb_d_t.bmgb005 OR g_bmgb_d[l_ac].bmgb006 != g_bmgb_d_t.bmgb006 OR g_bmgb_d[l_ac].bmgb007 != g_bmgb_d_t.bmgb007 OR g_bmgb_d[l_ac].bmgb008 != g_bmgb_d_t.bmgb008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgb_t WHERE "||"bmgbent = '" ||g_enterprise|| "' AND "||"bmgbsite = '"||g_site || "' AND "||"bmgb001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgb002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgb003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgb004 = '"||g_bmgb_d[l_ac].bmgb004 ||"' AND "|| "bmgb005 = '"||g_bmgb_d[l_ac].bmgb005 ||"' AND "|| "bmgb006 = '"||g_bmgb_d[l_ac].bmgb006 ||"' AND "|| "bmgb007 = '"||g_bmgb_d[l_ac].bmgb007 ||"' AND "|| "bmgb008 = '"||g_bmgb_d[l_ac].bmgb008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb_d[l_ac].bmgb004 = g_bmgb_d_t.bmgb004
                     CALL abmm205_bmgb_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bmgb_d[l_ac].bmgb004) THEN
               IF cl_null(g_bmgb_d[l_ac].bmgb006) THEN
                  LET g_bmgb_d[l_ac].bmgb006 = ' '
               END IF
               IF cl_null(g_bmgb_d[l_ac].bmgb007) THEN
                  LET g_bmgb_d[l_ac].bmgb007 = ' '
               END IF
               IF cl_null(g_bmgb_d[l_ac].bmgb008) THEN
                  LET g_bmgb_d[l_ac].bmgb008 = ' '
               END IF            
               CALL abmm205_bmgb_chk() RETURNING r_errno
               IF NOT cl_null(r_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmgb_d[l_ac].bmgb004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb_d[l_ac].bmgb004 = g_bmgb_d_t.bmgb004
                  CALL abmm205_bmgb_desc()
                  NEXT FIELD CURRENT
               END IF   
            END IF               
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb004
            #add-point:BEFORE FIELD bmgb004 name="input.b.page1.bmgb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmgb004
            #add-point:ON CHANGE bmgb004 name="input.g.page1.bmgb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb005
            
            #add-point:AFTER FIELD bmgb005 name="input.a.page1.bmgb005"
            #此段落由子樣板a05產生
            CALL abmm205_bmgb_desc()
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb_d[l_ac].bmgb004) AND NOT cl_null(g_bmgb_d[l_ac].bmgb005) AND g_bmgb_d[l_ac].bmgb006 IS NOT NULL AND g_bmgb_d[l_ac].bmgb007 IS NOT NULL AND NOT g_bmgb_d[l_ac].bmgb008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb_d[l_ac].bmgb004 != g_bmgb_d_t.bmgb004 OR g_bmgb_d[l_ac].bmgb005 != g_bmgb_d_t.bmgb005 OR g_bmgb_d[l_ac].bmgb006 != g_bmgb_d_t.bmgb006 OR g_bmgb_d[l_ac].bmgb007 != g_bmgb_d_t.bmgb007 OR g_bmgb_d[l_ac].bmgb008 != g_bmgb_d_t.bmgb008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgb_t WHERE "||"bmgbent = '" ||g_enterprise|| "' AND "||"bmgbsite = '"||g_site || "' AND "||"bmgb001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgb002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgb003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgb004 = '"||g_bmgb_d[l_ac].bmgb004 ||"' AND "|| "bmgb005 = '"||g_bmgb_d[l_ac].bmgb005 ||"' AND "|| "bmgb006 = '"||g_bmgb_d[l_ac].bmgb006 ||"' AND "|| "bmgb007 = '"||g_bmgb_d[l_ac].bmgb007 ||"' AND "|| "bmgb008 = '"||g_bmgb_d[l_ac].bmgb008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb_d[l_ac].bmgb005 = g_bmgb_d_t.bmgb005
                     CALL abmm205_bmgb_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_bmgb_d[l_ac].bmgb005) THEN
               IF cl_null(g_bmgb_d[l_ac].bmgb006) THEN
                  LET g_bmgb_d[l_ac].bmgb006 = ' '
               END IF
               IF cl_null(g_bmgb_d[l_ac].bmgb007) THEN
                  LET g_bmgb_d[l_ac].bmgb007 = ' '
               END IF
               IF cl_null(g_bmgb_d[l_ac].bmgb008) THEN
                  LET g_bmgb_d[l_ac].bmgb008 = ' '
               END IF            
               CALL abmm205_bmgb_chk() RETURNING r_errno
               IF NOT cl_null(r_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmgb_d[l_ac].bmgb005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb_d[l_ac].bmgb005 = g_bmgb_d_t.bmgb005
                  CALL abmm205_bmgb_desc()
                  NEXT FIELD CURRENT
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb005
            #add-point:BEFORE FIELD bmgb005 name="input.b.page1.bmgb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmgb005
            #add-point:ON CHANGE bmgb005 name="input.g.page1.bmgb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb006
            
            #add-point:AFTER FIELD bmgb006 name="input.a.page1.bmgb006"
            #此段落由子樣板a05產生
            CALL abmm205_bmgb_desc()
            IF cl_null(g_bmgb_d[l_ac].bmgb006) THEN
               LET g_bmgb_d[l_ac].bmgb006 = ' '
            END IF             
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb_d[l_ac].bmgb004) AND NOT cl_null(g_bmgb_d[l_ac].bmgb005) AND g_bmgb_d[l_ac].bmgb006 IS NOT NULL AND g_bmgb_d[l_ac].bmgb007 IS NOT NULL AND g_bmgb_d[l_ac].bmgb008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb_d[l_ac].bmgb004 != g_bmgb_d_t.bmgb004 OR g_bmgb_d[l_ac].bmgb005 != g_bmgb_d_t.bmgb005 OR g_bmgb_d[l_ac].bmgb006 != g_bmgb_d_t.bmgb006 OR g_bmgb_d[l_ac].bmgb007 != g_bmgb_d_t.bmgb007 OR g_bmgb_d[l_ac].bmgb008 != g_bmgb_d_t.bmgb008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgb_t WHERE "||"bmgbent = '" ||g_enterprise|| "' AND "||"bmgbsite = '"||g_site || "' AND "||"bmgb001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgb002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgb003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgb004 = '"||g_bmgb_d[l_ac].bmgb004 ||"' AND "|| "bmgb005 = '"||g_bmgb_d[l_ac].bmgb005 ||"' AND "|| "bmgb006 = '"||g_bmgb_d[l_ac].bmgb006 ||"' AND "|| "bmgb007 = '"||g_bmgb_d[l_ac].bmgb007 ||"' AND "|| "bmgb008 = '"||g_bmgb_d[l_ac].bmgb008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb_d[l_ac].bmgb006 = g_bmgb_d_t.bmgb006
                     CALL abmm205_bmgb_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_bmgb_d[l_ac].bmgb006 IS NOT NULL THEN
               CALL abmm205_bmgb_chk() RETURNING r_errno
               IF NOT cl_null(r_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmgb_d[l_ac].bmgb006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb_d[l_ac].bmgb006 = g_bmgb_d_t.bmgb006
                  CALL abmm205_bmgb_desc()
                  NEXT FIELD CURRENT
               END IF            
               CALL abmm205_acc_chk('215',g_bmgb_d[l_ac].bmgb006) RETURNING r_errno
               IF NOT cl_null(r_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmgb_d[l_ac].bmgb006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb_d[l_ac].bmgb006 = g_bmgb_d_t.bmgb006
                  CALL abmm205_bmgb_desc()
                  NEXT FIELD CURRENT
               END IF 
            END IF  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb006
            #add-point:BEFORE FIELD bmgb006 name="input.b.page1.bmgb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmgb006
            #add-point:ON CHANGE bmgb006 name="input.g.page1.bmgb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb007
            
            #add-point:AFTER FIELD bmgb007 name="input.a.page1.bmgb007"
            #此段落由子樣板a05產生
            CALL abmm205_bmgb_desc()
            IF cl_null(g_bmgb_d[l_ac].bmgb007) THEN
               LET g_bmgb_d[l_ac].bmgb007 = ' '
            END IF
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb_d[l_ac].bmgb004) AND NOT cl_null(g_bmgb_d[l_ac].bmgb005) AND g_bmgb_d[l_ac].bmgb006 IS NOT NULL AND g_bmgb_d[l_ac].bmgb007 IS NOT NULL AND g_bmgb_d[l_ac].bmgb008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb_d[l_ac].bmgb004 != g_bmgb_d_t.bmgb004 OR g_bmgb_d[l_ac].bmgb005 != g_bmgb_d_t.bmgb005 OR g_bmgb_d[l_ac].bmgb006 != g_bmgb_d_t.bmgb006 OR g_bmgb_d[l_ac].bmgb007 != g_bmgb_d_t.bmgb007 OR g_bmgb_d[l_ac].bmgb008 != g_bmgb_d_t.bmgb008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgb_t WHERE "||"bmgbent = '" ||g_enterprise|| "' AND "||"bmgbsite = '"||g_site || "' AND "||"bmgb001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgb002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgb003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgb004 = '"||g_bmgb_d[l_ac].bmgb004 ||"' AND "|| "bmgb005 = '"||g_bmgb_d[l_ac].bmgb005 ||"' AND "|| "bmgb006 = '"||g_bmgb_d[l_ac].bmgb006 ||"' AND "|| "bmgb007 = '"||g_bmgb_d[l_ac].bmgb007 ||"' AND "|| "bmgb008 = '"||g_bmgb_d[l_ac].bmgb008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb_d[l_ac].bmgb007 = g_bmgb_d_t.bmgb007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_bmgb_d[l_ac].bmgb007 IS NOT NULL THEN
               CALL abmm205_bmgb_chk() RETURNING r_errno
               IF NOT cl_null(r_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmgb_d[l_ac].bmgb007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb_d[l_ac].bmgb007 = g_bmgb_d_t.bmgb007
                  CALL abmm205_bmgb_desc()
                  NEXT FIELD CURRENT
               END IF            
               CALL abmm205_acc_chk('221',g_bmgb_d[l_ac].bmgb007) RETURNING r_errno
               IF NOT cl_null(r_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmgb_d[l_ac].bmgb007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb_d[l_ac].bmgb007 = g_bmgb_d_t.bmgb007
                  CALL abmm205_bmgb_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF     
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb007
            #add-point:BEFORE FIELD bmgb007 name="input.b.page1.bmgb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmgb007
            #add-point:ON CHANGE bmgb007 name="input.g.page1.bmgb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb008
            #add-point:BEFORE FIELD bmgb008 name="input.b.page1.bmgb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb008
            
            #add-point:AFTER FIELD bmgb008 name="input.a.page1.bmgb008"
            #此段落由子樣板a05產生
            IF cl_null(g_bmgb_d[l_ac].bmgb008) THEN
               LET g_bmgb_d[l_ac].bmgb008 = ' '
            END IF             
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb_d[l_ac].bmgb004) AND NOT cl_null(g_bmgb_d[l_ac].bmgb005) AND g_bmgb_d[l_ac].bmgb006 IS NOT NULL AND g_bmgb_d[l_ac].bmgb007 IS NOT NULL AND g_bmgb_d[l_ac].bmgb008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb_d[l_ac].bmgb004 != g_bmgb_d_t.bmgb004 OR g_bmgb_d[l_ac].bmgb005 != g_bmgb_d_t.bmgb005 OR g_bmgb_d[l_ac].bmgb006 != g_bmgb_d_t.bmgb006 OR g_bmgb_d[l_ac].bmgb007 != g_bmgb_d_t.bmgb007 OR g_bmgb_d[l_ac].bmgb008 != g_bmgb_d_t.bmgb008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgb_t WHERE "||"bmgbent = '" ||g_enterprise|| "' AND "||"bmgbsite = '"||g_site || "' AND "||"bmgb001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgb002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgb003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgb004 = '"||g_bmgb_d[l_ac].bmgb004 ||"' AND "|| "bmgb005 = '"||g_bmgb_d[l_ac].bmgb005 ||"' AND "|| "bmgb006 = '"||g_bmgb_d[l_ac].bmgb006 ||"' AND "|| "bmgb007 = '"||g_bmgb_d[l_ac].bmgb007 ||"' AND "|| "bmgb008 = '"||g_bmgb_d[l_ac].bmgb008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb_d[l_ac].bmgb008 = g_bmgb_d_t.bmgb008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_bmgb_d[l_ac].bmgb008 IS NOT NULL THEN
               CALL abmm205_bmgb_chk() RETURNING r_errno
               IF NOT cl_null(r_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_bmgb_d[l_ac].bmgb008
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb_d[l_ac].bmgb008 = g_bmgb_d_t.bmgb008
                  NEXT FIELD CURRENT
               END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmgb008
            #add-point:ON CHANGE bmgb008 name="input.g.page1.bmgb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmgb009
            #add-point:BEFORE FIELD bmgb009 name="input.b.page1.bmgb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmgb009
            
            #add-point:AFTER FIELD bmgb009 name="input.a.page1.bmgb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmgb009
            #add-point:ON CHANGE bmgb009 name="input.g.page1.bmgb009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bmgb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb004
            #add-point:ON ACTION controlp INFIELD bmgb004 name="input.c.page1.bmgb004"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb_d[l_ac].bmgb004             #給予default值
            LET g_qryparam.default2 = g_bmgb_d[l_ac].bmgb005 #元件料號
            LET g_qryparam.default3 = g_bmgb_d[l_ac].bmgb006 #部位編號
            LET g_qryparam.default4 = g_bmgb_d[l_ac].bmgb007 #作業編號
            LET g_qryparam.default5 = g_bmgb_d[l_ac].bmgb008 #製程段號
            

            #給予arg
            LET g_qryparam.arg1 = g_bmga_m.bmga001
            LET g_qryparam.arg2 = g_bmga_m.bmga002
            LET g_qryparam.arg3 = g_bmga_m.bmga004
            CALL q_bmba001_2()                                #呼叫開窗

            LET g_bmgb_d[l_ac].bmgb004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bmgb_d[l_ac].bmgb005 = g_qryparam.return2 #元件料號
            LET g_bmgb_d[l_ac].bmgb006 = g_qryparam.return3 #部位編號
            LET g_bmgb_d[l_ac].bmgb007 = g_qryparam.return4 #作業編號
            LET g_bmgb_d[l_ac].bmgb008 = g_qryparam.return5 #製程段號
            CALL abmm205_bmgb_desc()
            DISPLAY BY NAME g_bmgb_d[l_ac].*             
            NEXT FIELD bmgb004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmgb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb005
            #add-point:ON ACTION controlp INFIELD bmgb005 name="input.c.page1.bmgb005"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb_d[l_ac].bmgb004             #給予default值
            LET g_qryparam.default2 = g_bmgb_d[l_ac].bmgb005 #元件料號
            LET g_qryparam.default3 = g_bmgb_d[l_ac].bmgb006 #部位編號
            LET g_qryparam.default4 = g_bmgb_d[l_ac].bmgb007 #作業編號
            LET g_qryparam.default5 = g_bmgb_d[l_ac].bmgb008 #製程段號
            

            #給予arg
            LET g_qryparam.arg1 = g_bmga_m.bmga001
            LET g_qryparam.arg2 = g_bmga_m.bmga002
            LET g_qryparam.arg3 = g_bmga_m.bmga004
            CALL q_bmba001_2()                                #呼叫開窗

            LET g_bmgb_d[l_ac].bmgb004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bmgb_d[l_ac].bmgb005 = g_qryparam.return2 #元件料號
            LET g_bmgb_d[l_ac].bmgb006 = g_qryparam.return3 #部位編號
            LET g_bmgb_d[l_ac].bmgb007 = g_qryparam.return4 #作業編號
            LET g_bmgb_d[l_ac].bmgb008 = g_qryparam.return5 #製程段號
            CALL abmm205_bmgb_desc()
            DISPLAY BY NAME g_bmgb_d[l_ac].*             
            NEXT FIELD bmgb004 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmgb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb006
            #add-point:ON ACTION controlp INFIELD bmgb006 name="input.c.page1.bmgb006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb_d[l_ac].bmgb004             #給予default值
            LET g_qryparam.default2 = g_bmgb_d[l_ac].bmgb005 #元件料號
            LET g_qryparam.default3 = g_bmgb_d[l_ac].bmgb006 #部位編號
            LET g_qryparam.default4 = g_bmgb_d[l_ac].bmgb007 #作業編號
            LET g_qryparam.default5 = g_bmgb_d[l_ac].bmgb008 #製程段號
            

            #給予arg
            LET g_qryparam.arg1 = g_bmga_m.bmga001
            LET g_qryparam.arg2 = g_bmga_m.bmga002
            LET g_qryparam.arg3 = g_bmga_m.bmga004    
            CALL q_bmba001_2()  #呼叫開窗

            LET g_bmgb_d[l_ac].bmgb004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bmgb_d[l_ac].bmgb005 = g_qryparam.return2 #元件料號
            LET g_bmgb_d[l_ac].bmgb006 = g_qryparam.return3 #部位編號
            LET g_bmgb_d[l_ac].bmgb007 = g_qryparam.return4 #作業編號
            LET g_bmgb_d[l_ac].bmgb008 = g_qryparam.return5 #製程段號
            CALL abmm205_bmgb_desc()
            DISPLAY BY NAME g_bmgb_d[l_ac].*             
            NEXT FIELD bmgb004 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmgb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb007
            #add-point:ON ACTION controlp INFIELD bmgb007 name="input.c.page1.bmgb007"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb_d[l_ac].bmgb004             #給予default值
            LET g_qryparam.default2 = g_bmgb_d[l_ac].bmgb005 #元件料號
            LET g_qryparam.default3 = g_bmgb_d[l_ac].bmgb006 #部位編號
            LET g_qryparam.default4 = g_bmgb_d[l_ac].bmgb007 #作業編號
            LET g_qryparam.default5 = g_bmgb_d[l_ac].bmgb008 #製程段號
            

            #給予arg
            LET g_qryparam.arg1 = g_bmga_m.bmga001
            LET g_qryparam.arg2 = g_bmga_m.bmga002
            LET g_qryparam.arg3 = g_bmga_m.bmga004
            CALL q_bmba001_2()                                #呼叫開窗

            LET g_bmgb_d[l_ac].bmgb004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bmgb_d[l_ac].bmgb005 = g_qryparam.return2 #元件料號
            LET g_bmgb_d[l_ac].bmgb006 = g_qryparam.return3 #部位編號
            LET g_bmgb_d[l_ac].bmgb007 = g_qryparam.return4 #作業編號
            LET g_bmgb_d[l_ac].bmgb008 = g_qryparam.return5 #製程段號
            CALL abmm205_bmgb_desc()
            DISPLAY BY NAME g_bmgb_d[l_ac].*             
            NEXT FIELD bmgb004 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmgb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb008
            #add-point:ON ACTION controlp INFIELD bmgb008 name="input.c.page1.bmgb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmgb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmgb009
            #add-point:ON ACTION controlp INFIELD bmgb009 name="input.c.page1.bmgb009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bmgb_d[l_ac].* = g_bmgb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abmm205_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bmgb_d[l_ac].bmgb004 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bmgb_d[l_ac].* = g_bmgb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_bmgb_d[l_ac].bmgb006) THEN 
                  LET g_bmgb_d[l_ac].bmgb006 = ' '
               END IF
               IF cl_null(g_bmgb_d[l_ac].bmgb007) THEN 
                  LET g_bmgb_d[l_ac].bmgb007 = ' '
               END IF
               IF cl_null(g_bmgb_d[l_ac].bmgb008) THEN 
                  LET g_bmgb_d[l_ac].bmgb008 = ' '
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abmm205_bmgb_t_mask_restore('restore_mask_o')
      
               UPDATE bmgb_t SET (bmgb001,bmgb002,bmgb003,bmgb004,bmgb005,bmgb006,bmgb007,bmgb008,bmgb009) = (g_bmga_m.bmga001, 
                   g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmgb_d[l_ac].bmgb004,g_bmgb_d[l_ac].bmgb005,g_bmgb_d[l_ac].bmgb006, 
                   g_bmgb_d[l_ac].bmgb007,g_bmgb_d[l_ac].bmgb008,g_bmgb_d[l_ac].bmgb009)
                WHERE bmgbent = g_enterprise AND bmgbsite = g_site AND bmgb001 = g_bmga_m.bmga001 
                  AND bmgb002 = g_bmga_m.bmga002 
                  AND bmgb003 = g_bmga_m.bmga003 
 
                  AND bmgb004 = g_bmgb_d_t.bmgb004 #項次   
                  AND bmgb005 = g_bmgb_d_t.bmgb005  
                  AND bmgb006 = g_bmgb_d_t.bmgb006  
                  AND bmgb007 = g_bmgb_d_t.bmgb007  
                  AND bmgb008 = g_bmgb_d_t.bmgb008  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
 
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bmgb_d[l_ac].* = g_bmgb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmgb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bmgb_d[l_ac].* = g_bmgb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmgb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmga_m.bmga001
               LET gs_keys_bak[1] = g_bmga001_t
               LET gs_keys[2] = g_bmga_m.bmga002
               LET gs_keys_bak[2] = g_bmga002_t
               LET gs_keys[3] = g_bmga_m.bmga003
               LET gs_keys_bak[3] = g_bmga003_t
               LET gs_keys[4] = g_bmgb_d[g_detail_idx].bmgb004
               LET gs_keys_bak[4] = g_bmgb_d_t.bmgb004
               LET gs_keys[5] = g_bmgb_d[g_detail_idx].bmgb005
               LET gs_keys_bak[5] = g_bmgb_d_t.bmgb005
               LET gs_keys[6] = g_bmgb_d[g_detail_idx].bmgb006
               LET gs_keys_bak[6] = g_bmgb_d_t.bmgb006
               LET gs_keys[7] = g_bmgb_d[g_detail_idx].bmgb007
               LET gs_keys_bak[7] = g_bmgb_d_t.bmgb007
               LET gs_keys[8] = g_bmgb_d[g_detail_idx].bmgb008
               LET gs_keys_bak[8] = g_bmgb_d_t.bmgb008
               CALL abmm205_update_b('bmgb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abmm205_bmgb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bmgb_d[g_detail_idx].bmgb004 = g_bmgb_d_t.bmgb004 
                  AND g_bmgb_d[g_detail_idx].bmgb005 = g_bmgb_d_t.bmgb005 
                  AND g_bmgb_d[g_detail_idx].bmgb006 = g_bmgb_d_t.bmgb006 
                  AND g_bmgb_d[g_detail_idx].bmgb007 = g_bmgb_d_t.bmgb007 
                  AND g_bmgb_d[g_detail_idx].bmgb008 = g_bmgb_d_t.bmgb008 
 
                  ) THEN
                  LET gs_keys[01] = g_bmga_m.bmga001
                  LET gs_keys[gs_keys.getLength()+1] = g_bmga_m.bmga002
                  LET gs_keys[gs_keys.getLength()+1] = g_bmga_m.bmga003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb004
                  LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb005
                  LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb006
                  LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb007
                  LET gs_keys[gs_keys.getLength()+1] = g_bmgb_d_t.bmgb008
 
                  CALL abmm205_key_update_b(gs_keys,'bmgb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bmga_m),util.JSON.stringify(g_bmgb_d_t)
               LET g_log2 = util.JSON.stringify(g_bmga_m),util.JSON.stringify(g_bmgb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #IF g_prog = 'abmm205' THEN   #160324-00007#1        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'abmm205' THEN   #160324-00007#1   #160705-00042#11 160714 by sakura add
                  UPDATE bmgb_t SET (bmgb001,bmgb002,bmgb003,bmgb004,bmgb005,bmgb006,bmgb007,bmgb008,bmgb009) = (g_bmga_m.bmga001, 
                      g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmgb_d[l_ac].bmgb004,g_bmgb_d[l_ac].bmgb005,g_bmgb_d[l_ac].bmgb006, 
                      g_bmgb_d[l_ac].bmgb007,g_bmgb_d[l_ac].bmgb008,g_bmgb_d[l_ac].bmgb009)
                   WHERE bmgbent = g_enterprise AND bmgbsite <> g_site AND bmgb001 = g_bmga_m.bmga001 
                     AND bmgb002 = g_bmga_m.bmga002 
                     AND bmgb003 = g_bmga_m.bmga003 
                     AND bmgb004 = g_bmgb_d_t.bmgb004 #項次   
                     AND bmgb005 = g_bmgb_d_t.bmgb005  
                     AND bmgb006 = g_bmgb_d_t.bmgb006  
                     AND bmgb007 = g_bmgb_d_t.bmgb007  
                     AND bmgb008 = g_bmgb_d_t.bmgb008 
                     ##160324-00007#1---add---begin
                     AND EXISTS(SELECT 1 FROM bmba_t 
                                 WHERE bmbaent = bmgbent
                                   AND bmbasite = bmgbsite
                                   AND bmba001 = bmgb001
                                   AND bmba002 = bmgb002
                                   AND bmba003 = bmgb005
                                   AND bmba004 = bmgb006
                                   AND bmba007 = bmgb007
                                   AND bmba008 = bmgb008
                                   AND bmba019 = '1' )
               END IF             
               #160324-00007#1---add---end                  
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abmm205_unlock_b("bmgb_t","'1'")
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
               LET g_bmgb_d[li_reproduce_target].* = g_bmgb_d[li_reproduce].*
 
               LET g_bmgb_d[li_reproduce_target].bmgb004 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb005 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb006 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb007 = NULL
               LET g_bmgb_d[li_reproduce_target].bmgb008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bmgb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bmgb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="abmm205.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_bmgb2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmgb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 

            CALL abmm205_b_fill_1()
            LET g_rec_b = g_bmgb2_d.getLength()

        
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN abmm205_cl USING g_enterprise, g_site,g_bmga_m.bmga001
                                                                ,g_bmga_m.bmga002

                                                                ,g_bmga_m.bmga003


            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN abmm205_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE abmm205_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
                   
            
            LET g_rec_b = g_bmgb2_d.getLength()
            
            IF g_rec_b >= l_ac
               AND g_bmgb2_d[l_ac].bmgc004 IS NOT NULL
               AND g_bmgb2_d[l_ac].bmgc005 IS NOT NULL

               AND g_bmgb2_d[l_ac].bmgc006 IS NOT NULL

               AND g_bmgb2_d[l_ac].bmgc007 IS NOT NULL

               AND g_bmgb2_d[l_ac].bmgc008 IS NOT NULL


            THEN
               LET l_cmd='u'
               LET g_bmgb2_d_t.* = g_bmgb2_d[l_ac].*  #BACKUP
               CALL abmm205_set_entry_b(l_cmd)
               CALL abmm205_set_no_entry_b(l_cmd)
               
               OPEN abmm205_bcl1 USING g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmgb2_d[l_ac].bmgc004,
                                       g_bmgb2_d[l_ac].bmgc005,g_bmgb2_d[l_ac].bmgc006,g_bmgb2_d[l_ac].bmgc007,g_bmgb2_d[l_ac].bmgc008
                                                                         
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "abmm205_bcl1"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE

                  FETCH abmm205_bcl1 INTO g_bmgb2_d[l_ac].bmgc012,g_bmgb2_d[l_ac].bmgc004,g_bmgb2_d[l_ac].bmgc004_desc,g_bmgb2_d[l_ac].bmgc004_desc_desc,
                  g_bmgb2_d[l_ac].bmgc005,g_bmgb2_d[l_ac].bmgc005_desc,g_bmgb2_d[l_ac].bmgc005_desc_desc,g_bmgb2_d[l_ac].bmgc006,g_bmgb2_d[l_ac].bmgc006_desc,
                  g_bmgb2_d[l_ac].bmgc007,g_bmgb2_d[l_ac].bmgc007_desc,g_bmgb2_d[l_ac].bmgc008,g_bmgb2_d[l_ac].bmgc009,g_bmgb2_d[l_ac].bmgc010,g_bmgb2_d[l_ac].bmgc011,  #160509-00009#6
                  g_bmgb2_d[l_ac].bmgc013    #160614-00033#1
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_bmgb2_d_t.bmgc004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL abmm205_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmgb2_d[l_ac].* TO NULL 
            LET g_bmgb2_d[l_ac].bmgc009 = 1
            LET g_bmgb2_d[l_ac].bmgc010 = 1
            LET g_bmgb2_d[l_ac].bmgc004 = g_bmga_m.bmga001
            LET g_bmgb2_d[l_ac].bmgc012 = 'N'   #160509-00009#6
            LET g_bmgb2_d[l_ac].bmgc013 = 'N'   #160614-00033#1
            LET g_bmgb2_d_t.* = g_bmgb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmm205_set_entry_b(l_cmd)
            CALL abmm205_set_no_entry_b(l_cmd)
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

            LET l_rate = ''
            LET l_imaa006 = ''  
            IF NOT cl_null(g_bmgb2_d[l_ac].bmgc005) THEN
               SELECT imaa006 INTO l_imaa006
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_bmgb2_d[l_ac].bmgc005
               IF NOT cl_null(g_bmgb2_d[l_ac].bmgc011) AND NOT cl_null(l_imaa006) THEN
                  CALL s_aimi190_get_convert(g_bmgb2_d[l_ac].bmgc005,g_bmgb2_d[l_ac].bmgc011,l_imaa006) RETURNING l_success,l_rate
                  IF l_success = FALSE THEN                                                                                                                  
                     NEXT FIELD bmgc011
                  END IF 
               END IF
               IF cl_null(l_imaa006) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00021'
                  LET g_errparam.extend = l_imaa006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                                                                                                                  
                  NEXT FIELD bmgc011 
               END IF                     
            END IF 
            
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM bmgc_t 
             WHERE bmgcent = g_enterprise AND bmgcsite = g_site AND bmgc001 = g_bmga_m.bmga001
               AND bmgc002 = g_bmga_m.bmga002

               AND bmgc003 = g_bmga_m.bmga003


               AND bmgc004 = g_bmgb2_d[l_ac].bmgc004
               AND bmgc005 = g_bmgb2_d[l_ac].bmgc005

               AND bmgc006 = g_bmgb2_d[l_ac].bmgc006

               AND bmgc007 = g_bmgb2_d[l_ac].bmgc007

               AND bmgc008 = g_bmgb2_d[l_ac].bmgc008


                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               IF cl_null(g_bmgb2_d[l_ac].bmgc006) THEN 
                  LET g_bmgb2_d[l_ac].bmgc006 = ' '
               END IF
               IF cl_null(g_bmgb2_d[l_ac].bmgc007) THEN 
                  LET g_bmgb2_d[l_ac].bmgc007 = ' '
               END IF
               IF cl_null(g_bmgb2_d[l_ac].bmgc008) THEN 
                  LET g_bmgb2_d[l_ac].bmgc008 = ' '
               END IF               
               INSERT INTO bmgc_t (bmgcent,bmgcsite,bmgc001,bmgc002,bmgc003,bmgc004,bmgc005,bmgc006,bmgc007,bmgc008,bmgc009,bmgc010,bmgc011,bmgc012,bmgc013)   #160614-00033#1 add bmgc013
               VALUES(g_enterprise,g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmgb2_d[l_ac].bmgc004,g_bmgb2_d[l_ac].bmgc005,
                      g_bmgb2_d[l_ac].bmgc006,g_bmgb2_d[l_ac].bmgc007,g_bmgb2_d[l_ac].bmgc008,g_bmgb2_d[l_ac].bmgc009,g_bmgb2_d[l_ac].bmgc010,
                      g_bmgb2_d[l_ac].bmgc011,g_bmgb2_d[l_ac].bmgc012,g_bmgb2_d[l_ac].bmgc013)   #160614-00033#1 add bmgc013
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmgc_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_bmgb2_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "bmgc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #IF g_prog = 'abmm205' THEN    #160324-00007#1        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'abmm205' THEN    #160324-00007#1   #160705-00042#11 160714 by sakura add
                  CALL abmm205_allsite('3')
               END IF                        #160324-00007#1
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_bmgb2_d.deleteElement(l_ac)
               NEXT FIELD bmgc004
            END IF
         
            IF g_bmgb2_d[l_ac].bmgc004 IS NOT NULL
               AND g_bmgb2_d_t.bmgc005 IS NOT NULL

               AND g_bmgb2_d_t.bmgc006 IS NOT NULL

               AND g_bmgb2_d_t.bmgc007 IS NOT NULL 

               AND g_bmgb2_d_t.bmgc008 IS NOT NULL


               THEN 
               
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
               
               
               DELETE FROM bmgc_t
                WHERE bmgcent = g_enterprise AND bmgcsite = g_site AND bmgc001 = g_bmga_m.bmga001 AND
                      bmgc002 = g_bmga_m.bmga002 AND
                      bmgc003 = g_bmga_m.bmga003 AND
                      bmgc004 = g_bmgb2_d_t.bmgc004
                  AND bmgc005 = g_bmgb2_d_t.bmgc005
                  AND bmgc006 = g_bmgb2_d_t.bmgc006
                  AND bmgc007 = g_bmgb2_d_t.bmgc007
                  AND bmgc008 = g_bmgb2_d_t.bmgc008                
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmgc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  #IF g_prog = 'abmm205' THEN #160324-00007#1        #160705-00042#11 160714 by sakura mark
                  IF g_prog MATCHES 'abmm205' THEN #160324-00007#1   #160705-00042#11 160714 by sakura add
                     DELETE FROM bmgc_t
                      WHERE bmgcent = g_enterprise AND bmgcsite <> g_site AND bmgc001 = g_bmga_m.bmga001 AND
                            bmgc002 = g_bmga_m.bmga002 AND
                            bmgc003 = g_bmga_m.bmga003 AND
                            bmgc004 = g_bmgb2_d_t.bmgc004
                        AND bmgc005 = g_bmgb2_d_t.bmgc005
                        AND bmgc006 = g_bmgb2_d_t.bmgc006
                        AND bmgc007 = g_bmgb2_d_t.bmgc007
                        AND bmgc008 = g_bmgb2_d_t.bmgc008  
                  END IF        #160324-00007#1               
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE abmm205_bcl1
               LET l_count = g_bmgb2_d.getLength()
            END IF 
            
         AFTER DELETE
            #161026-00055#1---add---s
            #如果是最後一筆
            IF l_ac = (g_bmgb2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #161026-00055#1---add---e

         BEFORE FIELD bmgc012   #160509-00009#6
         
         AFTER FIELD bmgc012   #160509-00009#6
         
         ON CHANGE bmgc012    #160509-00009#6
         
         AFTER FIELD bmgc004
            CALL abmm205_bmgc_desc() 
            IF NOT cl_null(g_bmgb2_d[l_ac].bmgc004) THEN
               LET l_sql = "SELECT COUNT(*) FROM bmba_t", 
                          "  WHERE bmbaent = '",g_enterprise ,"' AND bmbasite = '",g_site,"'",
                          "    AND bmba001 = '",g_bmgb2_d[l_ac].bmgc004,"'",
                          "    AND bmba002 = '",g_bmga_m.bmga002,"'",
                          " AND (to_char(bmba005,'yyyy-mm-dd') <= '",g_bmga_m.bmga004,"' OR bmba005 IS NULL)",
                          " AND (to_char(bmba006,'yyyy-mm-dd') > '",g_bmga_m.bmga004,"' OR bmba006 IS NULL)",
                          "  START WITH bmba001 = '", g_bmga_m.bmga001,"'",
                          "    AND bmba002 = '" ,g_bmga_m.bmga002,"'",
                         " CONNECT BY bmba001 = PRIOR bmba003",
                         "     AND bmba002 = '", g_bmga_m.bmga002,"'",
                         "     AND (to_char(bmba005,'yyyy-mm-dd') <= '",g_bmga_m.bmga004,"' OR bmba005 IS NULL)",
                         "     AND (to_char(bmba006,'yyyy-mm-dd') > '",g_bmga_m.bmga004,"' OR bmba006 IS NULL)"
             
               PREPARE abmm205_bmgc004_pre FROM l_sql
               EXECUTE abmm205_bmgc004_pre INTO l_m
               IF cl_null(l_m) OR l_m <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'abm-00086'
                  LET g_errparam.extend = g_bmgb2_d[l_ac].bmgc004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb2_d[l_ac].bmgc004 = g_bmgb2_d_t.bmgc004
                  CALL abmm205_bmgc_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF          
 
         AFTER FIELD bmgc005
            CALL abmm205_bmgc_desc()
            CALL abmm205_bmgc005_desc()
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc004) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc005) AND g_bmgb2_d[l_ac].bmgc006 IS NOT NULL AND g_bmgb2_d[l_ac].bmgc007 IS NOT NULL AND g_bmgb2_d[l_ac].bmgc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb2_d[l_ac].bmgc004 != g_bmgb2_d_t.bmgc004 OR g_bmgb2_d[l_ac].bmgc005 != g_bmgb2_d_t.bmgc005 OR g_bmgb2_d[l_ac].bmgc006 != g_bmgb2_d_t.bmgc006 OR g_bmgb2_d[l_ac].bmgc007 != g_bmgb2_d_t.bmgc007 OR g_bmgb2_d[l_ac].bmgc008 != g_bmgb2_d_t.bmgc008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgc_t WHERE "||"bmgcent = '" ||g_enterprise|| "' AND "||"bmgcsite = '"||g_site || "' AND "||"bmgc001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgc002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgc003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgc004 = '"||g_bmgb2_d[l_ac].bmgc004 ||"' AND "|| "bmgc005 = '"||g_bmgb2_d[l_ac].bmgc005 ||"' AND "|| "bmgc006 = '"||g_bmgb2_d[l_ac].bmgc006 ||"' AND "|| "bmgc007 = '"||g_bmgb2_d[l_ac].bmgc007 ||"' AND "|| "bmgc008 = '"||g_bmgb2_d[l_ac].bmgc008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb2_d[l_ac].bmgc005 = g_bmgb2_d_t.bmgc005
                     CALL abmm205_bmgc_desc()
                     CALL abmm205_bmgc005_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
         IF NOT cl_null(g_bmgb2_d[l_ac].bmgc005) THEN
            IF NOT abmm205_bmgc005_chk() THEN
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bmgb2_d[l_ac].bmgc005
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'aimm200'
                  LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                  LET g_errparam.exeprog = 'aimm200'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmgb2_d[l_ac].bmgc005 = g_bmgb2_d_t.bmgc005
                  CALL abmm205_bmgc_desc()
                  CALL abmm205_bmgc005_desc()
                  NEXT FIELD CURRENT 
               END IF
            END IF             
         END IF            
         
         AFTER FIELD bmgc006
            CALL abmm205_bmgc_desc()
            IF cl_null(g_bmgb2_d[l_ac].bmgc006) THEN 
               LET g_bmgb2_d[l_ac].bmgc006 = ' '
            END IF            
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc004) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc005) AND g_bmgb2_d[l_ac].bmgc006 IS NOT NULL AND NOT cl_null(g_bmgb2_d[l_ac].bmgc007) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc008) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb2_d[l_ac].bmgc004 != g_bmgb2_d_t.bmgc004 OR g_bmgb2_d[l_ac].bmgc005 != g_bmgb2_d_t.bmgc005 OR g_bmgb2_d[l_ac].bmgc006 != g_bmgb2_d_t.bmgc006 OR g_bmgb2_d[l_ac].bmgc007 != g_bmgb2_d_t.bmgc007 OR g_bmgb2_d[l_ac].bmgc008 != g_bmgb2_d_t.bmgc008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgc_t WHERE "||"bmgcent = '" ||g_enterprise|| "' AND "||"bmgcsite = '"||g_site || "' AND "||"bmgc001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgc002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgc003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgc004 = '"||g_bmgb2_d[l_ac].bmgc004 ||"' AND "|| "bmgc005 = '"||g_bmgb2_d[l_ac].bmgc005 ||"' AND "|| "bmgc006 = '"||g_bmgb2_d[l_ac].bmgc006 ||"' AND "|| "bmgc007 = '"||g_bmgb2_d[l_ac].bmgc007 ||"' AND "|| "bmgc008 = '"||g_bmgb2_d[l_ac].bmgc008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb2_d[l_ac].bmgc006 = g_bmgb2_d_t.bmgc006
                     CALL abmm205_bmgc_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF            
            CALL abmm205_acc_chk('215',g_bmgb2_d[l_ac].bmgc006) RETURNING r_errno
            IF NOT cl_null(r_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = r_errno
               LET g_errparam.extend = g_bmgb2_d[l_ac].bmgc006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bmgb2_d[l_ac].bmgc006 = g_bmgb2_d_t.bmgc006
               CALL abmm205_bmgc_desc()
               NEXT FIELD CURRENT
            END IF        
         
         AFTER FIELD bmgc007
            CALL abmm205_bmgc_desc()
            IF cl_null(g_bmgb2_d[l_ac].bmgc007) THEN 
               LET g_bmgb2_d[l_ac].bmgc007 = ' '
            END IF
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc004) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc005) AND g_bmgb2_d[l_ac].bmgc006 IS NOT NULL AND g_bmgb2_d[l_ac].bmgc007 IS NOT NULL AND g_bmgb2_d[l_ac].bmgc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb2_d[l_ac].bmgc004 != g_bmgb2_d_t.bmgc004 OR g_bmgb2_d[l_ac].bmgc005 != g_bmgb2_d_t.bmgc005 OR g_bmgb2_d[l_ac].bmgc006 != g_bmgb2_d_t.bmgc006 OR g_bmgb2_d[l_ac].bmgc007 != g_bmgb2_d_t.bmgc007 OR g_bmgb2_d[l_ac].bmgc008 != g_bmgb2_d_t.bmgc008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgc_t WHERE "||"bmgcent = '" ||g_enterprise|| "' AND "||"bmgcsite = '"||g_site || "' AND "||"bmgc001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgc002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgc003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgc004 = '"||g_bmgb2_d[l_ac].bmgc004 ||"' AND "|| "bmgc005 = '"||g_bmgb2_d[l_ac].bmgc005 ||"' AND "|| "bmgc006 = '"||g_bmgb2_d[l_ac].bmgc006 ||"' AND "|| "bmgc007 = '"||g_bmgb2_d[l_ac].bmgc007 ||"' AND "|| "bmgc008 = '"||g_bmgb2_d[l_ac].bmgc008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb2_d[l_ac].bmgc007 = g_bmgb2_d_t.bmgc007
                     CALL abmm205_bmgc_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF            
            CALL abmm205_acc_chk('221',g_bmgb2_d[l_ac].bmgc007) RETURNING r_errno
            IF NOT cl_null(r_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = r_errno
               LET g_errparam.extend = g_bmgb2_d[l_ac].bmgc007
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bmgb2_d[l_ac].bmgc007 = g_bmgb2_d_t.bmgc007
               CALL abmm205_bmgc_desc()
               NEXT FIELD CURRENT
            END IF         

         AFTER FIELD bmgc008
            IF cl_null(g_bmgb2_d[l_ac].bmgc006) THEN 
               LET g_bmgb2_d[l_ac].bmgc006 = ' '
            END IF
            IF  NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL AND NOT cl_null(g_bmga_m.bmga003) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc004) AND NOT cl_null(g_bmgb2_d[l_ac].bmgc005) AND g_bmgb2_d[l_ac].bmgc006 IS NOT NULL AND g_bmgb2_d[l_ac].bmgc007 IS NOT NULL AND g_bmgb2_d[l_ac].bmgc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmga_m.bmga001 != g_bmga001_t OR g_bmga_m.bmga002 != g_bmga002_t OR g_bmga_m.bmga003 != g_bmga003_t OR g_bmgb2_d[l_ac].bmgc004 != g_bmgb2_d_t.bmgc004 OR g_bmgb2_d[l_ac].bmgc005 != g_bmgb2_d_t.bmgc005 OR g_bmgb2_d[l_ac].bmgc006 != g_bmgb2_d_t.bmgc006 OR g_bmgb2_d[l_ac].bmgc007 != g_bmgb2_d_t.bmgc007 OR g_bmgb2_d[l_ac].bmgc008 != g_bmgb2_d_t.bmgc008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmgc_t WHERE "||"bmgcent = '" ||g_enterprise|| "' AND "||"bmgcsite = '"||g_site || "' AND "||"bmgc001 = '"||g_bmga_m.bmga001 ||"' AND "|| "bmgc002 = '"||g_bmga_m.bmga002 ||"' AND "|| "bmgc003 = '"||g_bmga_m.bmga003 ||"' AND "|| "bmgc004 = '"||g_bmgb2_d[l_ac].bmgc004 ||"' AND "|| "bmgc005 = '"||g_bmgb2_d[l_ac].bmgc005 ||"' AND "|| "bmgc006 = '"||g_bmgb2_d[l_ac].bmgc006 ||"' AND "|| "bmgc007 = '"||g_bmgb2_d[l_ac].bmgc007 ||"' AND "|| "bmgc008 = '"||g_bmgb2_d[l_ac].bmgc008 ||"'",'std-00004',0) THEN 
                     LET g_bmgb2_d[l_ac].bmgc008 = g_bmgb2_d_t.bmgc008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD bmgc009
            IF NOT cl_null(g_bmgb2_d[l_ac].bmgc009) THEN
               IF NOT cl_ap_chk_Range(g_bmgb2_d[l_ac].bmgc009,"0.000","1","","","azz-00079",1) THEN
                  NEXT FIELD bmgc009
               END IF
            END IF
            
         AFTER FIELD bmgc010
            IF NOT cl_null(g_bmgb2_d[l_ac].bmgc010) THEN
               IF NOT cl_ap_chk_Range(g_bmgb2_d[l_ac].bmgc010,"0.000","1","","","azz-00079",1) THEN
                  NEXT FIELD bmgc010
               END IF
            END IF
            
         AFTER FIELD bmgc011
            IF NOT cl_null(g_bmgb2_d[l_ac].bmgc011) THEN
               IF NOT abmm205_bmgc011_chk(g_bmgb2_d[l_ac].bmgc011) THEN
                  LET g_bmgb2_d[l_ac].bmgc011 = g_bmgb2_d_t.bmgc011
                  NEXT FIELD bmgc011
               END IF
               LET l_rate = ''
               LET l_imaa006 = ''  
               IF NOT cl_null(g_bmgb2_d[l_ac].bmgc005) THEN
                  SELECT imaa006 INTO l_imaa006
                    FROM imaa_t
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_bmgb2_d[l_ac].bmgc005
                  IF NOT cl_null(g_bmgb2_d[l_ac].bmgc011) AND NOT cl_null(l_imaa006) THEN
                     CALL s_aimi190_get_convert(g_bmgb2_d[l_ac].bmgc005,g_bmgb2_d[l_ac].bmgc011,l_imaa006) RETURNING l_success,l_rate
                     IF l_success = FALSE THEN
                        LET g_bmgb2_d[l_ac].bmgc011 = g_bmgb2_d_t.bmgc011                                                                                                                   
                        NEXT FIELD bmgc011
                     END IF 
                  END IF
                  IF cl_null(l_imaa006) THEN 
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00021'
                  LET g_errparam.extend = l_imaa006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     LET g_bmgb2_d[l_ac].bmgc011 = g_bmgb2_d_t.bmgc011                                                                                                                   
                     NEXT FIELD bmgc011 
                  END IF                     
               END IF              
            END IF   
            
         BEFORE FIELD bmgc013   #160614-00033#1                   
         AFTER FIELD bmgc013   #160614-00033#1                   
         ON CHANGE bmgc013   #160614-00033#1  
         
         ON ACTION controlp INFIELD bmgc004            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb2_d[l_ac].bmgc004             #給予default值          

            #給予arg
            LET g_qryparam.arg1 = g_bmga_m.bmga001
            LET g_qryparam.arg2 = g_bmga_m.bmga002
            CALL q_bmba001()                                #呼叫開窗

            LET g_bmgb2_d[l_ac].bmgc004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_bmgb2_d[l_ac].bmgc004 TO bmgc004            
            NEXT FIELD bmgc004        
 
         ON ACTION controlp INFIELD bmgc005
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb2_d[l_ac].bmgc005             #給予default值

            #給予arg

            CALL q_imaa001_2()                                #呼叫開窗

            LET g_bmgb2_d[l_ac].bmgc005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmgb2_d[l_ac].bmgc005 TO bmgc005              #顯示到畫面上

            NEXT FIELD bmgc005                          #返回原欄位

         ON ACTION controlp INFIELD bmgc006            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb2_d[l_ac].bmgc006             #給予default值          

            #給予arg
            LET g_qryparam.arg1 = "215" #應用分類
            CALL q_oocq002()                               #呼叫開窗

            LET g_bmgb2_d[l_ac].bmgc006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_bmgb2_d[l_ac].bmgc006 TO bmgc006            
            NEXT FIELD bmgc006  
 

         ON ACTION controlp INFIELD bmgc007            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb2_d[l_ac].bmgc007             #給予default值          

            #給予arg
            LET g_qryparam.arg1 = "221" #應用分類
            CALL q_oocq002()                               #呼叫開窗

            LET g_bmgb2_d[l_ac].bmgc007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_bmgb2_d[l_ac].bmgc007 TO bmgc007            
            NEXT FIELD bmgc007 

         ON ACTION controlp INFIELD bmgc011           
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmgb2_d[l_ac].bmgc011             #給予default值          

            #給予arg

            CALL q_ooca001_1()                               #呼叫開窗

            LET g_bmgb2_d[l_ac].bmgc011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_bmgb2_d[l_ac].bmgc011 TO bmgc011            
            NEXT FIELD bmgc011
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_bmgb2_d[l_ac].* = g_bmgb2_d_t.*
               CLOSE abmm205_bcl1
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            LET l_rate = ''
            LET l_imaa006 = ''  
            IF NOT cl_null(g_bmgb2_d[l_ac].bmgc005) THEN
               SELECT imaa006 INTO l_imaa006
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_bmgb2_d[l_ac].bmgc005
               IF NOT cl_null(g_bmgb2_d[l_ac].bmgc011) AND NOT cl_null(l_imaa006) THEN
                  CALL s_aimi190_get_convert(g_bmgb2_d[l_ac].bmgc005,g_bmgb2_d[l_ac].bmgc011,l_imaa006) RETURNING l_success,l_rate
                  IF l_success = FALSE THEN                                                                                                                  
                     NEXT FIELD bmgc011
                  END IF 
               END IF
               IF cl_null(l_imaa006) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00021'
                  LET g_errparam.extend = l_imaa006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                                                                                                                  
                  NEXT FIELD bmgc011 
               END IF                     
            END IF              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_bmgb2_d[l_ac].bmgc004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bmgb2_d[l_ac].* = g_bmgb2_d_t.*
            ELSE
            
               IF cl_null(g_bmgb2_d[l_ac].bmgc006) THEN 
                  LET g_bmgb2_d[l_ac].bmgc006 = ' '
               END IF  
               IF cl_null(g_bmgb2_d[l_ac].bmgc007) THEN 
                  LET g_bmgb2_d[l_ac].bmgc007 = ' '
               END IF 
               IF cl_null(g_bmgb2_d[l_ac].bmgc008) THEN 
                  LET g_bmgb2_d[l_ac].bmgc008 = ' '
               END IF 
               
               UPDATE bmgc_t SET (bmgc001,bmgc002,bmgc003,bmgc004,bmgc005,bmgc006,bmgc007,bmgc008,bmgc009,bmgc010,bmgc011,bmgc012,bmgc013) =             #160614-00033#1 add bmgc013
                                 (g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmgb2_d[l_ac].bmgc004,g_bmgb2_d[l_ac].bmgc005,
                                  g_bmgb2_d[l_ac].bmgc006,g_bmgb2_d[l_ac].bmgc007,g_bmgb2_d[l_ac].bmgc008,g_bmgb2_d[l_ac].bmgc009,
                                  g_bmgb2_d[l_ac].bmgc010,g_bmgb2_d[l_ac].bmgc011,g_bmgb2_d[l_ac].bmgc012,g_bmgb2_d[l_ac].bmgc013)    #160509-00009#6  #160614-00033#1 add bmgc013
                WHERE bmgcent = g_enterprise AND bmgcsite = g_site AND bmgc001 = g_bmga_m.bmga001 
                  AND bmgc002 = g_bmga_m.bmga002 
                  AND bmgc003 = g_bmga_m.bmga003 
                  AND bmgc004 = g_bmgb2_d_t.bmgc004 #項次   
                  AND bmgc005 = g_bmgb2_d_t.bmgc005  
                  AND bmgc006 = g_bmgb2_d_t.bmgc006  
                  AND bmgc007 = g_bmgb2_d_t.bmgc007  
                  AND bmgc008 = g_bmgb2_d_t.bmgc008                    

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "bmgb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_bmgb2_d[l_ac].* = g_bmgb2_d_t.*
               END IF
               #IF g_prog = 'abmm205' THEN #160324-00007#1        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'abmm205' THEN #160324-00007#1   #160705-00042#11 160714 by sakura add
                  UPDATE bmgc_t SET (bmgc001,bmgc002,bmgc003,bmgc004,bmgc005,bmgc006,bmgc007,bmgc008,bmgc009,bmgc010,bmgc011,bmgc012,bmgc013) =              #160614-00033#1 add bmgc013
                                   (g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmgb2_d[l_ac].bmgc004,g_bmgb2_d[l_ac].bmgc005,
                                    g_bmgb2_d[l_ac].bmgc006,g_bmgb2_d[l_ac].bmgc007,g_bmgb2_d[l_ac].bmgc008,g_bmgb2_d[l_ac].bmgc009,
                                    g_bmgb2_d[l_ac].bmgc010,g_bmgb2_d[l_ac].bmgc011,g_bmgb2_d[l_ac].bmgc012,g_bmgb2_d[l_ac].bmgc013)   #160509-00009#6   #160614-00033#1 add bmgc013
                   WHERE bmgcent = g_enterprise AND bmgcsite <> g_site AND bmgc001 = g_bmga_m.bmga001 
                     AND bmgc002 = g_bmga_m.bmga002 
                     AND bmgc003 = g_bmga_m.bmga003 
                     AND bmgc004 = g_bmgb2_d_t.bmgc004 #項次   
                     AND bmgc005 = g_bmgb2_d_t.bmgc005  
                     AND bmgc006 = g_bmgb2_d_t.bmgc006  
                     AND bmgc007 = g_bmgb2_d_t.bmgc007  
                     AND bmgc008 = g_bmgb2_d_t.bmgc008 
               END IF  #160324-00007#1                  
            END IF
            
         AFTER ROW
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bmgb2_d[l_ac].* = g_bmgb2_d_t.*
               END IF
               CLOSE abmm205_bcl1
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            CLOSE abmm205_bcl1
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
              
      END INPUT

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
            NEXT FIELD bmga001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bmgb004
 
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
 
{<section id="abmm205.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abmm205_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abmm205_b_fill() #單身填充
      CALL abmm205_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abmm205_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmga_m.bmgaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bmga_m.bmgaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmga_m.bmgaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmga_m.bmgaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmga_m.bmgaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmga_m.bmgaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmga_m.bmgacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bmga_m.bmgacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmga_m.bmgacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmga_m.bmgacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmga_m.bmgacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmga_m.bmgacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmga_m.bmgamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_bmga_m.bmgamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmga_m.bmgamodid_desc

            CALL abmm205_bmga_desc()
   #end add-point
   
   #遮罩相關處理
   LET g_bmga_m_mask_o.* =  g_bmga_m.*
   CALL abmm205_bmga_t_mask()
   LET g_bmga_m_mask_n.* =  g_bmga_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bmga_m.bmga001,g_bmga_m.imaal003,g_bmga_m.imaal004,g_bmga_m.bmga002,g_bmga_m.bmga003, 
       g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgal005,g_bmga_m.bmgaownid,g_bmga_m.bmgaownid_desc, 
       g_bmga_m.bmgaowndp,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp, 
       g_bmga_m.bmgacrtdp_desc,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamodid_desc,g_bmga_m.bmgamoddt 
 
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bmgb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmgb_d[l_ac].bmgb004
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmgb_d[l_ac].bmgb004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmgb_d[l_ac].bmgb004_desc
            CALL abmm205_bmgb_desc()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   #161102-00005#1---add---s
   FOR l_ac = 1 TO g_bmgb2_d.getLength()
       CALL abmm205_bmgc_desc()
   END FOR
   #161102-00005#1---add---e   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abmm205_detail_show()
 
   #add-point:show段之後 name="show.after"
   #161026-00055#1---mark---s
   #LET l_ac_t = l_ac
   #CALL abmm205_b_fill_1()
   #LET l_ac = l_ac_t
   #161026-00055#1---mark---e
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abmm205_detail_show()
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
 
{<section id="abmm205.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abmm205_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bmga_t.bmga001 
   DEFINE l_oldno     LIKE bmga_t.bmga001 
   DEFINE l_newno02     LIKE bmga_t.bmga002 
   DEFINE l_oldno02     LIKE bmga_t.bmga002 
   DEFINE l_newno03     LIKE bmga_t.bmga003 
   DEFINE l_oldno03     LIKE bmga_t.bmga003 
 
   DEFINE l_master    RECORD LIKE bmga_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bmgb_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_bmga_m.bmga001 IS NULL
   OR g_bmga_m.bmga002 IS NULL
   OR g_bmga_m.bmga003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bmga001_t = g_bmga_m.bmga001
   LET g_bmga002_t = g_bmga_m.bmga002
   LET g_bmga003_t = g_bmga_m.bmga003
 
    
   LET g_bmga_m.bmga001 = ""
   LET g_bmga_m.bmga002 = ""
   LET g_bmga_m.bmga003 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bmga_m.bmgaownid = g_user
      LET g_bmga_m.bmgaowndp = g_dept
      LET g_bmga_m.bmgacrtid = g_user
      LET g_bmga_m.bmgacrtdp = g_dept 
      LET g_bmga_m.bmgacrtdt = cl_get_current()
      LET g_bmga_m.bmgamodid = g_user
      LET g_bmga_m.bmgamoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   CALL abmm205_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bmga_m.* TO NULL
      INITIALIZE g_bmgb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abmm205_show()
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
   CALL abmm205_set_act_visible()   
   CALL abmm205_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bmga001_t = g_bmga_m.bmga001
   LET g_bmga002_t = g_bmga_m.bmga002
   LET g_bmga003_t = g_bmga_m.bmga003
 
   
   #組合新增資料的條件
   LET g_add_browse = " bmgaent = " ||g_enterprise|| " AND bmgasite = '" ||g_site|| "' AND",
                      " bmga001 = '", g_bmga_m.bmga001, "' "
                      ," AND bmga002 = '", g_bmga_m.bmga002, "' "
                      ," AND bmga003 = '", g_bmga_m.bmga003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abmm205_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abmm205_idx_chk()
   
   LET g_data_owner = g_bmga_m.bmgaownid      
   LET g_data_dept  = g_bmga_m.bmgaowndp
   
   #功能已完成,通報訊息中心
   CALL abmm205_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abmm205_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bmgb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
 
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abmm205_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bmgb_t
    WHERE bmgbent = g_enterprise AND bmgbsite = g_site AND bmgb001 = g_bmga001_t
     AND bmgb002 = g_bmga002_t
     AND bmgb003 = g_bmga003_t
 
    INTO TEMP abmm205_detail
 
   #將key修正為調整後   
   UPDATE abmm205_detail 
      #更新key欄位
      SET bmgb001 = g_bmga_m.bmga001
          , bmgb002 = g_bmga_m.bmga002
          , bmgb003 = g_bmga_m.bmga003
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bmgb_t SELECT * FROM abmm205_detail
   
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
   DROP TABLE abmm205_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   DROP TABLE abmm205_detail1
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE abmm205_detail1 AS ",
                "SELECT * FROM bmgb_t "
   PREPARE repro_tbl1 FROM ls_sql
   EXECUTE repro_tbl1
   FREE repro_tbl1
                
   INSERT INTO abmm205_detail1 SELECT * FROM bmgb_t 
                                         WHERE bmgbent = g_enterprise 
                                         AND bmgbsite <> g_site 
                                         AND bmgb001 = g_bmga001_t
                                         AND bmgb002 = g_bmga002_t
                                         AND bmgb003 = g_bmga003_t
 
   
   #將key修正為調整後   
   UPDATE abmm205_detail1 
      #更新key欄位
      SET bmgb001 = g_bmga_m.bmga001
          , bmgb002 = g_bmga_m.bmga002
          , bmgb003 = g_bmga_m.bmga003
    
   INSERT INTO bmgb_t SELECT * FROM abmm205_detail1
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   DROP TABLE abmm205_detail1   
   
   DROP TABLE abmm205_detail2
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE abmm205_detail2 AS ",
                "SELECT * FROM bmgc_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
                
   INSERT INTO abmm205_detail2 SELECT * FROM bmgc_t 
                                         WHERE bmgcent = g_enterprise 
                                         #AND bmgbsite = g_site 
                                         AND bmgc001 = g_bmga001_t
                                         AND bmgc002 = g_bmga002_t
                                         AND bmgc003 = g_bmga003_t
 
   
   #將key修正為調整後   
   UPDATE abmm205_detail2 
      #更新key欄位
      SET bmgc001 = g_bmga_m.bmga001
        , bmgc002 = g_bmga_m.bmga002
        , bmgc003 = g_bmga_m.bmga003
    
   INSERT INTO bmgc_t SELECT * FROM abmm205_detail2
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   DROP TABLE abmm205_detail2
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bmga001_t = g_bmga_m.bmga001
   LET g_bmga002_t = g_bmga_m.bmga002
   LET g_bmga003_t = g_bmga_m.bmga003
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abmm205_delete()
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
   
   IF g_bmga_m.bmga001 IS NULL
   OR g_bmga_m.bmga002 IS NULL
   OR g_bmga_m.bmga003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.bmgal001 = g_bmga_m.bmga001
LET g_master_multi_table_t.bmgal002 = g_bmga_m.bmga002
LET g_master_multi_table_t.bmgal003 = g_bmga_m.bmga003
LET g_master_multi_table_t.bmgal005 = g_bmga_m.bmgal005
 
   
   CALL s_transaction_begin()
 
   OPEN abmm205_cl USING g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmm205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abmm205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abmm205_master_referesh USING g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003 INTO g_bmga_m.bmga001, 
       g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp, 
       g_bmga_m.bmgacrtid,g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt, 
       g_bmga_m.bmgaownid_desc,g_bmga_m.bmgaowndp_desc,g_bmga_m.bmgacrtid_desc,g_bmga_m.bmgacrtdp_desc, 
       g_bmga_m.bmgamodid_desc
   
   
   #檢查是否允許此動作
   IF NOT abmm205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bmga_m_mask_o.* =  g_bmga_m.*
   CALL abmm205_bmga_t_mask()
   LET g_bmga_m_mask_n.* =  g_bmga_m.*
   
   CALL abmm205_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abmm205_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bmga001_t = g_bmga_m.bmga001
      LET g_bmga002_t = g_bmga_m.bmga002
      LET g_bmga003_t = g_bmga_m.bmga003
 
 
      DELETE FROM bmga_t
       WHERE bmgaent = g_enterprise AND bmgasite = g_site AND bmga001 = g_bmga_m.bmga001
         AND bmga002 = g_bmga_m.bmga002
         AND bmga003 = g_bmga_m.bmga003
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bmga_m.bmga001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      DELETE FROM bmga_t
       WHERE bmgaent = g_enterprise AND bmgasite <> g_site AND bmga001 = g_bmga_m.bmga001
         AND bmga002 = g_bmga_m.bmga002
         AND bmga003 = g_bmga_m.bmga003
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bmgb_t
       WHERE bmgbent = g_enterprise AND bmgbsite = g_site AND bmgb001 = g_bmga_m.bmga001
         AND bmgb002 = g_bmga_m.bmga002
         AND bmgb003 = g_bmga_m.bmga003
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      DELETE FROM bmgb_t
       WHERE bmgbent = g_enterprise AND bmgbsite <> g_site AND bmgb001 = g_bmga_m.bmga001
         AND bmgb002 = g_bmga_m.bmga002
         AND bmgb003 = g_bmga_m.bmga003
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmgb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM bmgc_t
       WHERE bmgcent = g_enterprise AND bmgcsite = g_site AND bmgc001 = g_bmga_m.bmga001
         AND bmgc002 = g_bmga_m.bmga002
         AND bmgc003 = g_bmga_m.bmga003       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "bmgb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
       DELETE FROM bmgc_t
       WHERE bmgcent = g_enterprise AND bmgcsite <> g_site AND bmgc001 = g_bmga_m.bmga001
         AND bmgc002 = g_bmga_m.bmga002
         AND bmgc003 = g_bmga_m.bmga003
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bmga_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abmm205_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bmgb_d.clear() 
 
     
      CALL abmm205_ui_browser_refresh()  
      #CALL abmm205_ui_headershow()  
      #CALL abmm205_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'bmgalent'
   LET l_var_keys_bak[02] = g_site
   LET l_field_keys[02] = 'bmgalsite'
   LET l_var_keys_bak[03] = g_master_multi_table_t.bmgal001
   LET l_field_keys[03] = 'bmgal001'
   LET l_var_keys_bak[04] = g_master_multi_table_t.bmgal002
   LET l_field_keys[04] = 'bmgal002'
   LET l_var_keys_bak[05] = g_master_multi_table_t.bmgal003
   LET l_field_keys[05] = 'bmgal003'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bmgal_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abmm205_browser_fill("")
         CALL abmm205_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abmm205_cl
 
   #功能已完成,通報訊息中心
   CALL abmm205_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abmm205.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abmm205_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bmgb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF abmm205_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bmgb004,bmgb005,bmgb006,bmgb007,bmgb008,bmgb009 ,t1.imaal003 , 
             t2.imaal004 ,t3.imaal003 ,t4.imaal004 ,t5.oocql004 ,t6.oocql004 FROM bmgb_t",   
                     " INNER JOIN bmga_t ON bmgaent = " ||g_enterprise|| " AND bmgasite = '" ||g_site|| "' AND bmga001 = bmgb001 ",
                     " AND bmga002 = bmgb002 ",
                     " AND bmga003 = bmgb003 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=bmgb004 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=bmgb004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=bmgb005 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=bmgb005 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='215' AND t5.oocql002=bmgb006 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='221' AND t6.oocql002=bmgb007 AND t6.oocql003='"||g_dlang||"' ",
 
                     " WHERE bmgbent=? AND bmgbsite=? AND bmgb001=? AND bmgb002=? AND bmgb003=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bmgb_t.bmgb004,bmgb_t.bmgb005,bmgb_t.bmgb006,bmgb_t.bmgb007,bmgb_t.bmgb008"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abmm205_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abmm205_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise, g_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003 INTO g_bmgb_d[l_ac].bmgb004, 
          g_bmgb_d[l_ac].bmgb005,g_bmgb_d[l_ac].bmgb006,g_bmgb_d[l_ac].bmgb007,g_bmgb_d[l_ac].bmgb008, 
          g_bmgb_d[l_ac].bmgb009,g_bmgb_d[l_ac].bmgb004_desc,g_bmgb_d[l_ac].bmgb004_desc_desc,g_bmgb_d[l_ac].bmgb005_desc, 
          g_bmgb_d[l_ac].bmgb005_desc_desc,g_bmgb_d[l_ac].bmgb006_desc,g_bmgb_d[l_ac].bmgb007_desc   
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
   
   CALL g_bmgb_d.deleteElement(g_bmgb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abmm205_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bmgb_d.getLength()
      LET g_bmgb_d_mask_o[l_ac].* =  g_bmgb_d[l_ac].*
      CALL abmm205_bmgb_t_mask()
      LET g_bmgb_d_mask_n[l_ac].* =  g_bmgb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abmm205_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM bmgb_t
       WHERE bmgbent = g_enterprise AND bmgbsite = g_site AND
         bmgb001 = ps_keys_bak[1] AND bmgb002 = ps_keys_bak[2] AND bmgb003 = ps_keys_bak[3] AND bmgb004 = ps_keys_bak[4] AND bmgb005 = ps_keys_bak[5] AND bmgb006 = ps_keys_bak[6] AND bmgb007 = ps_keys_bak[7] AND bmgb008 = ps_keys_bak[8]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      #IF g_prog = 'abmm205' THEN #160324-00007#1        #160705-00042#11 160714 by sakura mark
      IF g_prog MATCHES 'abmm205' THEN #160324-00007#1   #160705-00042#11 160714 by sakura add
         DELETE FROM bmgb_t
          WHERE bmgbent = g_enterprise AND bmgbsite <> g_site AND
            bmgb001 = ps_keys_bak[1] AND bmgb002 = ps_keys_bak[2] AND bmgb003 = ps_keys_bak[3] AND bmgb004 = ps_keys_bak[4] AND bmgb005 = ps_keys_bak[5] AND bmgb006 = ps_keys_bak[6] AND bmgb007 = ps_keys_bak[7] AND bmgb008 = ps_keys_bak[8]   
            ##160324-00007#1---add---begin
            AND EXISTS(SELECT 1 FROM bmba_t 
                        WHERE bmbaent = bmgbent
                         AND bmbasite = bmgbsite
                         AND bmba001 = bmgb001
                         AND bmba002 = bmgb002
                         AND bmba003 = bmgb005
                         AND bmba004 = bmgb006
                         AND bmba007 = bmgb007
                         AND bmba008 = bmgb008
                         AND bmba019 = '1' )
           #160324-00007#1---add---end                       
      END IF #160324-00007#1                
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
         CALL g_bmgb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abmm205_insert_b(ps_table,ps_keys,ps_page)
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
      IF cl_null(ps_keys[6]) THEN
         LET ps_keys[6] = ' '
      END IF
      IF cl_null(ps_keys[7]) THEN
         LET ps_keys[7] = ' '
      END IF
      IF cl_null(ps_keys[8]) THEN
         LET ps_keys[8] = ' '
      END IF
      #end add-point 
      INSERT INTO bmgb_t
                  (bmgbent, bmgbsite,
                   bmgb001,bmgb002,bmgb003,
                   bmgb004,bmgb005,bmgb006,bmgb007,bmgb008
                   ,bmgb009) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
                   ,g_bmgb_d[g_detail_idx].bmgb009)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmgb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bmgb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abmm205_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bmgb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL abmm205_bmgb_t_mask_restore('restore_mask_o')
               
      UPDATE bmgb_t 
         SET (bmgb001,bmgb002,bmgb003,
              bmgb004,bmgb005,bmgb006,bmgb007,bmgb008
              ,bmgb009) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
              ,g_bmgb_d[g_detail_idx].bmgb009) 
         WHERE bmgbent = g_enterprise AND bmgbsite = g_site AND bmgb001 = ps_keys_bak[1] AND bmgb002 = ps_keys_bak[2] AND bmgb003 = ps_keys_bak[3] AND bmgb004 = ps_keys_bak[4] AND bmgb005 = ps_keys_bak[5] AND bmgb006 = ps_keys_bak[6] AND bmgb007 = ps_keys_bak[7] AND bmgb008 = ps_keys_bak[8]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmgb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmgb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abmm205_bmgb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="abmm205.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abmm205_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="abmm205.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abmm205_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abmm205.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abmm205_lock_b(ps_table,ps_page)
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
   #CALL abmm205_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bmgb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abmm205_bcl USING g_enterprise, g_site,
                                       g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,g_bmgb_d[g_detail_idx].bmgb004, 
                                           g_bmgb_d[g_detail_idx].bmgb005,g_bmgb_d[g_detail_idx].bmgb006, 
                                           g_bmgb_d[g_detail_idx].bmgb007,g_bmgb_d[g_detail_idx].bmgb008  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abmm205_bcl:",SQLERRMESSAGE 
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
 
{<section id="abmm205.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abmm205_unlock_b(ps_table,ps_page)
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
      CLOSE abmm205_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abmm205_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bmga001,bmga002,bmga003",TRUE)
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
 
{<section id="abmm205.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abmm205_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bmga001,bmga002,bmga003",FALSE)
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
 
{<section id="abmm205.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abmm205_set_entry_b(p_cmd)
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
 
{<section id="abmm205.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abmm205_set_no_entry_b(p_cmd)
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
 
{<section id="abmm205.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abmm205_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL cl_set_act_visible("insert", TRUE)   #160705-00024#1
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abmm205_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_bmaastus  LIKE bmaa_t.bmaastus    #161216-00029#6 add
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #IF g_prog = 'abmm215' THEN        #160705-00042#11 160714 by sakura mark 
   IF g_prog MATCHES 'abmm215' THEN   #160705-00042#11 160714 by sakura add
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", FALSE)
      CALL cl_set_act_visible("insert",FALSE)   #160705-00024#1   
   END IF   
   #161216-00029#6 add(s)
   SELECT bmaastus INTO l_bmaastus FROM bmaa_t 
    WHERE bmaaent = g_enterprise
      AND bmaasite = g_site
      AND bmaa001 = g_bmga_m.bmga001
      AND bmaa002 = g_bmga_m.bmga002
   IF l_bmaastus = 'VO' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
   END IF
   #161216-00029#6 add(e)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abmm205_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abmm205_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abmm205_default_search()
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
   DEFINE l_wc   STRING
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " bmga001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bmga002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bmga003 = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bmga001 = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bmga002 = '", g_argv[03], "' AND "
   END IF

   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bmga003 = '", g_argv[04], "' AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "bmga_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bmgb_t" 
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
   IF NOT cl_null(g_argv[1]) THEN
      LET l_wc = l_wc, " bmgasite = '", g_argv[1], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm205.state_change" >}
   
 
{</section>}
 
{<section id="abmm205.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abmm205_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bmgb_d.getLength() THEN
         LET g_detail_idx = g_bmgb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmgb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmgb_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bmgb_d.getLength() THEN
         LET g_detail_idx = g_bmgb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmgb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmgb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abmm205_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   CALL abmm205_b_fill_1()      #161026-00055#1
   RETURN                       #161026-00055#1
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL abmm205_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abmm205_fill_chk(ps_idx)
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
 
{<section id="abmm205.status_show" >}
PRIVATE FUNCTION abmm205_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmm205.mask_functions" >}
&include "erp/abm/abmm205_mask.4gl"
 
{</section>}
 
{<section id="abmm205.signature" >}
   
 
{</section>}
 
{<section id="abmm205.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abmm205_set_pk_array()
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
   LET g_pk_array[1].values = g_bmga_m.bmga001
   LET g_pk_array[1].column = 'bmga001'
   LET g_pk_array[2].values = g_bmga_m.bmga002
   LET g_pk_array[2].column = 'bmga002'
   LET g_pk_array[3].values = g_bmga_m.bmga003
   LET g_pk_array[3].column = 'bmga003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmm205.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abmm205.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abmm205_msgcentre_notify(lc_state)
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
   CALL abmm205_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bmga_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmm205.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abmm205_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmm205.other_function" readonly="Y" >}
#替代料單身填充
PRIVATE FUNCTION abmm205_b_fill_1()
   CALL g_bmgb2_d.clear()   
   LET g_sql = "SELECT  UNIQUE bmgc012,bmgc004,'','',bmgc005,'','',bmgc006,'',bmgc007,'',bmgc008,bmgc009,bmgc010,bmgc011,bmgc013 FROM bmgc_t",    #160509-00009#6 #160614-00033#1 add bmgc013 
              #" INNER JOIN bmga_t ON bmga001 = bmgc001 ",   #170124-00032#1 mark
               " INNER JOIN bmga_t ON bmga001 = bmgc001 AND bmgaent = bmgcent ",   #170124-00032#1 add 
               " AND bmga002 = bmgc002 ",
               " AND bmga003 = bmgc003 ",               
               " WHERE bmgcent=? AND bmgcsite=? AND bmgc001=? AND bmgc002=? AND bmgc003=?"
   
   IF NOT cl_null(g_wc_table2) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table2 CLIPPED
   END IF
   
   #子單身的WC
   
   
   LET g_sql = g_sql, " ORDER BY bmgc_t.bmgc004,bmgc_t.bmgc005,bmgc_t.bmgc006,bmgc_t.bmgc007,bmgc_t.bmgc008"

   
   PREPARE abmm205_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR abmm205_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs1 USING g_enterprise, g_site,g_bmga_m.bmga001
                                            ,g_bmga_m.bmga002

                                            ,g_bmga_m.bmga003
                                            
   FOREACH b_fill_cs1 INTO g_bmgb2_d[l_ac].bmgc012,g_bmgb2_d[l_ac].bmgc004,g_bmgb2_d[l_ac].bmgc004_desc,g_bmgb2_d[l_ac].bmgc004_desc_desc,g_bmgb2_d[l_ac].bmgc005,g_bmgb2_d[l_ac].bmgc005_desc,g_bmgb2_d[l_ac].bmgc005_desc_desc,g_bmgb2_d[l_ac].bmgc006,g_bmgb2_d[l_ac].bmgc006_desc,g_bmgb2_d[l_ac].bmgc007,g_bmgb2_d[l_ac].bmgc007_desc,g_bmgb2_d[l_ac].bmgc008,g_bmgb2_d[l_ac].bmgc009,g_bmgb2_d[l_ac].bmgc010,g_bmgb2_d[l_ac].bmgc011,g_bmgb2_d[l_ac].bmgc013  #160614-00033#1 add bmgc013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      #add-point:b_fill段資料填充
      CALL abmm205_bmgc_desc()
      #end add-point
   
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF         
   END FOREACH
   LET g_error_show = 0   

      
   CALL g_bmgb2_d.deleteElement(g_bmgb2_d.getLength())
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abmm205_pb1
END FUNCTION
################################################################################
# Descriptions...: 參考欄位帶值

################################################################################
PRIVATE FUNCTION abmm205_bmga_desc()
   SELECT imaal003,imaal004 INTO g_bmga_m.imaal003,g_bmga_m.imaal004 FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmga_m.bmga001
      AND imaal002 = g_dlang
    SELECT bmgal005 INTO g_bmga_m.bmgal005 FROM bmgal_t
     WHERE bmgalent = g_enterprise
       AND bmgalsite = g_site
       AND bmgal001 = g_bmga_m.bmga001
       AND bmgal002 = g_bmga_m.bmga002
       AND bmgal003 = g_bmga_m.bmga003
       AND bmgal004 = g_dlang      
END FUNCTION
################################################################################
# Descriptions...: 單頭相關欄位檢查
# Modify.........:
################################################################################
PRIVATE FUNCTION abmm205_bmga_chk()
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_bmaastus LIKE bmaa_t.bmaastus
   DEFINE l_errno    LIKE type_t.chr10
   
   IF cl_null(g_bmga_m.bmga001) OR g_bmga_m.bmga002 IS NULL THEN
      LET l_errno = ''
      RETURN l_errno
   END IF 
   LET l_errno = ''     
   IF NOT cl_null(g_bmga_m.bmga001) AND g_bmga_m.bmga002 IS NOT NULL THEN
      LET l_bmaastus = ''
      SELECT bmaastus INTO l_bmaastus FROM bmaa_t
       WHERE bmaaent = g_enterprise
        AND bmaasite = g_site
        AND bmaa001 = g_bmga_m.bmga001
        AND bmaa002 = g_bmga_m.bmga002
       CASE
          WHEN SQLCA.sqlcode = 100   LET l_errno = 'abm-00085'
          #WHEN l_bmaastus <> 'Y'     LET l_errno = 'aim-00127' #160318-00005#5 mark
          WHEN l_bmaastus <> 'Y'     LET l_errno = 'sub-01302'  #160318-00005#5 add
       END CASE 
    END IF
    RETURN l_errno    
END FUNCTION
################################################################################
# Descriptions...: 单身多语言显示
# Memo...........:
# Usage..........: CALL abmm205_bmgb_desc()
# Date & Author..: 13/11/19 BY chengjing
# Modify.........:
################################################################################
PRIVATE FUNCTION abmm205_bmgb_desc()
   LET g_bmgb_d[l_ac].bmgb004_desc = ''
   LET g_bmgb_d[l_ac].bmgb004_desc_desc = ''
   LET g_bmgb_d[l_ac].bmgb005_desc = ''
   LET g_bmgb_d[l_ac].bmgb005_desc_desc = ''
   LET g_bmgb_d[l_ac].bmgb006_desc  = ''
   LET g_bmgb_d[l_ac].bmgb007_desc = ''
   SELECT imaal003,imaal004 INTO g_bmgb_d[l_ac].bmgb004_desc,g_bmgb_d[l_ac].bmgb004_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmgb_d[l_ac].bmgb004
      AND imaal002 = g_lang
   SELECT imaal003,imaal004 INTO g_bmgb_d[l_ac].bmgb005_desc,g_bmgb_d[l_ac].bmgb005_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmgb_d[l_ac].bmgb005
      AND imaal002 = g_lang
   SELECT oocql004 INTO g_bmgb_d[l_ac].bmgb006_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '215'
      AND oocql002 = g_bmgb_d[l_ac].bmgb006
      AND oocql003 = g_lang
   SELECT oocql004 INTO g_bmgb_d[l_ac].bmgb007_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '221'
      AND oocql002 = g_bmgb_d[l_ac].bmgb007
      AND oocql003 = g_lang      
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL abmm205_bmgc_desc()
# Modify.........:
################################################################################
PRIVATE FUNCTION abmm205_bmgc_desc()
   LET g_bmgb2_d[l_ac].bmgc004_desc = ''
   LET g_bmgb2_d[l_ac].bmgc004_desc_desc = ''
   LET g_bmgb2_d[l_ac].bmgc005_desc = ''
   LET g_bmgb2_d[l_ac].bmgc005_desc_desc = ''
   LET g_bmgb2_d[l_ac].bmgc006_desc = ''
   LET g_bmgb2_d[l_ac].bmgc007_desc = ''
   SELECT imaal003,imaal004 INTO g_bmgb2_d[l_ac].bmgc004_desc,g_bmgb2_d[l_ac].bmgc004_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmgb2_d[l_ac].bmgc004
      AND imaal002 = g_lang
   SELECT imaal003,imaal004 INTO g_bmgb2_d[l_ac].bmgc005_desc,g_bmgb2_d[l_ac].bmgc005_desc_desc FROM imaal_t 
    WHERE imaalent = g_enterprise
      AND imaal001 = g_bmgb2_d[l_ac].bmgc005
      AND imaal002 = g_lang       
   SELECT oocql004 INTO g_bmgb2_d[l_ac].bmgc006_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '215'
      AND oocql002 = g_bmgb2_d[l_ac].bmgc006
      AND oocql003 = g_lang
   SELECT oocql004 INTO g_bmgb2_d[l_ac].bmgc007_desc FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = '221'
      AND oocql002 = g_bmgb2_d[l_ac].bmgc007
      AND oocql003 = g_lang  
END FUNCTION
################################################################################
# Descriptions...: 單身欄位檢查
# Date & Author..: 2013/11/19 By chenjing
# Modify.........:
################################################################################
PRIVATE FUNCTION abmm205_bmgb_chk()
   DEFINE l_sql      STRING
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_errno    LIKE type_t.chr10
 
   LET l_cnt = 0
   LET l_sql = "SELECT COUNT(*) FROM bmba_t", 
              "  WHERE bmbaent = '",g_enterprise ,"' AND bmbasite = '",g_site,"'",
              "    AND bmba001 = '",g_bmgb_d[l_ac].bmgb004,"'",
              "    AND bmba002 = '",g_bmga_m.bmga002,"'",
              " AND (to_char(bmba005,'yyyy-mm-dd') <= '",g_bmga_m.bmga004,"' OR bmba005 IS NULL)",
              " AND (to_char(bmba006,'yyyy-mm-dd') > '",g_bmga_m.bmga004,"' OR bmba006 IS NULL)",
              "  START WITH bmba001 = '", g_bmga_m.bmga001,"'",
              "    AND bmba002 = '" ,g_bmga_m.bmga002,"'",
              " CONNECT BY bmba001 = PRIOR bmba003",
              "     AND bmba002 = '", g_bmga_m.bmga002,"'",
              "     AND (to_char(bmba005,'yyyy-mm-dd') <= '",g_bmga_m.bmga004,"' OR bmba005 IS NULL)",
              "     AND (to_char(bmba006,'yyyy-mm-dd') > '",g_bmga_m.bmga004,"' OR bmba006 IS NULL)"
  
   PREPARE abmm205_bmgb004_pre1 FROM l_sql
   EXECUTE abmm205_bmgb004_pre1 INTO l_cnt
   IF cl_null(l_cnt) OR l_cnt <= 0 THEN
      LET l_errno =  'abm-00086'
      RETURN l_errno
   END IF

   IF cl_null(g_bmgb_d[l_ac].bmgb004) OR
      cl_null(g_bmgb_d[l_ac].bmgb005) OR
      g_bmgb_d[l_ac].bmgb006 IS NULL OR
      g_bmgb_d[l_ac].bmgb007 IS NULL OR
      g_bmgb_d[l_ac].bmgb008 IS NULL THEN
      RETURN l_errno
   END IF
     
   
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) FROM ",
              " (SELECT bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,bmba008,bmba019 ",
              "    FROM bmba_t ",
              "  WHERE bmbaent = '",g_enterprise ,"' AND bmbasite = '",g_site,"'",
              "  START WITH bmba001 = '", g_bmga_m.bmga001,"'",
              "     AND bmba002 = '" ,g_bmga_m.bmga002,"'",
              " CONNECT BY bmba001 = PRIOR bmba003",
              "     AND bmba002 = '", g_bmga_m.bmga002,"')",
              "  WHERE bmba001 = '",g_bmgb_d[l_ac].bmgb004,"'",
              " AND bmba002 = '",g_bmga_m.bmga002,"'",
              " AND bmba003 = '",g_bmgb_d[l_ac].bmgb005,"'",
              " AND bmba004 = '",g_bmgb_d[l_ac].bmgb006,"'",
              " AND (to_char(bmba005,'yyyy-mm-dd') <= '",g_bmga_m.bmga004,"' OR bmba005 IS NULL)",
              " AND (to_char(bmba006,'yyyy-mm-dd') > '",g_bmga_m.bmga004,"' OR bmba006 IS NULL)",
#              " AND (bmba005 <= '",g_bmga_m.bmga004,"' OR bmba005 IS NULL)",
#              " AND (bmba006 > '",g_bmga_m.bmga004,"' OR bmba006 IS NULL)",
              " AND bmba007 = '",g_bmgb_d[l_ac].bmgb007,"'",
              " AND bmba008 = '",g_bmgb_d[l_ac].bmgb008,"'",
              " AND bmba019 <> '2' "
    PREPARE abmm205_bmgb004_pre FROM l_sql
    EXECUTE abmm205_bmgb004_pre INTO l_cnt
    IF cl_null(l_cnt) OR l_cnt <= 0 THEN
       LET l_errno = 'abm-00087'
    END IF
 
   RETURN l_errno
END FUNCTION
################################################################################
# Descriptions...: ACC碼檢查
# Modify.........:
################################################################################
PRIVATE FUNCTION abmm205_acc_chk(p_oocq001,p_oocq002)
DEFINE p_oocq001        LIKE oocq_t.oocq001
DEFINE p_oocq002        LIKE oocq_t.oocq002
DEFINE l_n              LIKE type_t.num5
DEFINE l_errno          LIKE type_t.chr10

   LET l_errno = ""
   IF NOT cl_null(p_oocq002) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = p_oocq001
         AND oocq002 = p_oocq002
      IF l_n = 0 THEN
         LET l_errno = "amm-00013"
      ELSE
         SELECT COUNT(*) INTO l_n
           FROM oocq_t
          WHERE oocqent = g_enterpris3e
            AND oocq001 = p_oocq001
            AND oocq002 = p_oocq002
            AND oocqstus = 'Y'
         IF l_n = 0 THEN
            LET l_errno = "amm-00014"
         END IF
      END IF
   END IF
   RETURN l_errno
END FUNCTION
################################################################################
# Descriptions...: 單位欄位檢查
################################################################################
PRIVATE FUNCTION abmm205_bmgc011_chk(p_bmgc011)
DEFINE p_bmgc011      LIKE bmgc_t.bmgc011
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE

       IF NOT cl_null(p_bmgc011) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL

          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_bmgc011
          #160318-00025#39  2016/04/22  by pengxin  add(S)
          LET g_errshow = TRUE #是否開窗 
          LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
          #160318-00025#39  2016/04/22  by pengxin  add(E)
          #呼叫檢查存在並帶值的library
          IF cl_chk_exist("v_ooca001") THEN
             #檢查成功時後續處理

          ELSE
             #檢查失敗時後續處理
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 取替代料號檢查
################################################################################
PRIVATE FUNCTION abmm205_bmgc005_chk()
   DEFINE l_imaa010     LIKE imaa_t.imaa010
   DEFINE l_oocq004     LIKE oocq_t.oocq004
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_imaa001     LIKE imaa_t.imaa001
   DEFINE l_imaastus    LIKE imaa_t.imaastus
   LET g_errno = ""
   IF g_bmgb2_d[l_ac].bmgc005 = g_bmga_m.bmga001 OR g_bmgb2_d[l_ac].bmgc005 = g_bmgb_d[l_ac].bmgb004 THEN 
      LET g_errno = 'abm-00050'
      RETURN FALSE
   END IF
#   IF g_bmgb2_d[l_ac].bmgc005 = g_bmgb_d[l_ac].bmgb005 THEN 
#      LET g_errno = 'abm-00051'
#      RETURN FALSE
#   END IF  
   SELECT imaa010 INTO l_imaa010 FROM imaa_t 
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmgb2_d[l_ac].bmgc005
   IF NOT cl_null(l_imaa010) THEN 
      SELECT oocq004 INTO l_oocq004
        FROM oocq_t
       WHERE oocq001 = '210'
         AND oocq002 = l_imaa010
         AND oocqent = g_enterprise
         AND oocqstus = 'Y'
   END IF
   IF l_oocq004 = 'N' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM imaa_t
       WHERE imaa001 = g_bmgb2_d[l_ac].bmgc005
         AND imaaent = g_enterprise
         AND imaastus = 'Y'
         AND imaa038 = 'Y'
      IF l_n > 0 THEN
         LET g_errno = 'abm-00010'
         RETURN FALSE
      END IF
   END IF 
   IF NOT cl_null(g_bmgb2_d[l_ac].bmgc005) THEN 
      SELECT imaa001,imaastus INTO l_imaa001,l_imaastus FROM imaa_t
        WHERE imaaent = g_enterprise
          AND imaa001 = g_bmgb2_d[l_ac].bmgc005
       IF l_imaastus = 'N' THEN
          #LET g_errno = 'aim-00121'  #160318-00005#5 mark
          LET g_errno = 'sub-01302'   #160318-00005#5 add
          RETURN FALSE
       END IF
       IF l_imaastus = 'X' THEN              
          #LET g_errno = 'aim-00002'  #160318-00005#5 mark
          LET g_errno = 'sub-01302'   #160318-00005#5 add
          RETURN FALSE
       END IF
       IF cl_null(l_imaa001) THEN 
          LET g_errno = 'aim-00001' 
          RETURN FALSE
       END IF
   IF cl_null(g_bmgb2_d[l_ac].bmgc006) THEN
      LET g_bmgb2_d[l_ac].bmgc006 = ' '
   END IF
   IF cl_null(g_bmgb2_d[l_ac].bmgc007) THEN
      LET g_bmgb2_d[l_ac].bmgc007 = ' '
   END IF
   IF cl_null(g_bmgb2_d[l_ac].bmgc008) THEN
      LET g_bmgb2_d[l_ac].bmgc008 = ' '
   END IF   
    END IF
    RETURN TRUE    
END FUNCTION
################################################################################
# Descriptions...: 单位带值
################################################################################
PRIVATE FUNCTION abmm205_bmgc005_desc()
#   LET g_bmgb2_d[l_ac].bmgc011  = ''
   IF NOT cl_null(g_bmgb2_d[l_ac].bmgc005) AND ( g_bmgb2_d_t.bmgc005 IS NULL OR g_bmgb2_d[l_ac].bmgc005 != g_bmgb2_d_t.bmgc005) THEN
      SELECT imae081 INTO g_bmgb2_d[l_ac].bmgc011 FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite = g_site
         AND imae001 = g_bmgb2_d[l_ac].bmgc005 
      DISPLAY BY NAME g_bmgb2_d[l_ac].bmgc011     
   END IF
END FUNCTION

################################################################################
# Descriptions...: 集團級資料拋磚據點級
# Memo...........:
# Usage..........: CALL abmm205_allsite(p_type)
#                  RETURNING r_success
# Input parameter: p_type      類型
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 2015/09/10 By  xianghui
# Modify.........:
################################################################################
PRIVATE FUNCTION abmm205_allsite(p_type)
DEFINE p_type    LIKE type_t.chr1
DEFINE l_sql     STRING
DEFINE l_site    LIKE bmea_t.bmeasite
DEFINE l_var_keys            DYNAMIC ARRAY OF STRING
DEFINE l_field_keys          DYNAMIC ARRAY OF STRING
DEFINE l_vars                DYNAMIC ARRAY OF STRING
DEFINE l_fields              DYNAMIC ARRAY OF STRING
DEFINE l_var_keys_bak        DYNAMIC ARRAY OF STRING


   CASE 
      WHEN p_type = '1'
         #161026-00034#1---add---s
         LET l_sql = "INSERT INTO bmga_t (bmgaent,bmgasite,bmga001,bmga002,bmga003,",
                     "                    bmga004,bmga005,bmgaownid,bmgaowndp,bmgacrtid,",
                     "                    bmgacrtdp,bmgacrtdt,bmgamodid,bmgamoddt) ",
                     " SELECT DISTINCT bmgaent,bmaasite,bmga001,bmga002,bmga003,",
                     "           bmga004,bmga005,bmgaownid,bmgaowndp,bmgacrtid,",
                     "           bmgacrtdp,bmgacrtdt,bmgamodid,bmgamoddt",
                     "  FROM bmaa_t ",
                     "  LEFT JOIN bmga_t ON bmgaent = bmaaent AND bmga001=bmaa001 AND bmga002=bmaa002 AND bmga003='",g_bmga_m.bmga003,"'",
                     " WHERE bmaaent = '",g_enterprise,"'",
                     "   AND bmaasite <> '",g_site,"'",
                     "   AND bmaa001 = '",g_bmga_m.bmga001,"'",
                     "   AND bmaa002 = '",g_bmga_m.bmga002,"'"                     
         PREPARE all_site_p FROM l_sql
         EXECUTE all_site_p
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "bmgb_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF    
         LET l_sql = "INSERT INTO bmgal_t (bmgalent,bmgalsite,bmgal001,bmgal002,bmgal003,",
                     "                    bmgal004,bmgal005) ",
                     " SELECT DISTINCT bmgaent,bmgasite,bmga001,bmga002,bmga003,",
                     "           bmgal004,bmgal005 ",
                     "  FROM bmga_t ",
                     #"  LEFT JOIN bmgal_t ON bmgalent = bmgaent AND bmgal001=bmaa001 AND bmgal002=bmaa002 AND bmgal003=bmga003 AND bmgalsite='",g_site,"'",   ##161227-00058#1 mark
                     "  LEFT JOIN bmgal_t ON bmgalent = bmgaent AND bmgal001=bmga001 AND bmgal002=bmga002 AND bmgal003=bmga003 AND bmgalsite='",g_site,"'",   ##161227-00058#1
                     " WHERE bmgaent = '",g_enterprise,"'",
                     "   AND bmgasite <> '",g_site,"'",
                     "   AND bmga001 = '",g_bmga_m.bmga001,"'",
                     "   AND bmga002 = '",g_bmga_m.bmga002,"'",
                     "   AND bmga003 = '",g_bmga_m.bmga003,"'"                     
         PREPARE all_site_p4 FROM l_sql
         EXECUTE all_site_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "bmgbl_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF         
         #LET l_sql = "SELECT DISTINCT bmaasite FROM bmaa_t ",
         #            " WHERE bmaaent = '",g_enterprise,"'",
         #            "   AND bmaasite <> '",g_site,"'",
         #            "   AND bmaa001 = '",g_bmga_m.bmga001,"'",
         #            "   AND bmaa002 = '",g_bmga_m.bmga002,"'"
         #PREPARE all_site_p FROM l_sql
         #DECLARE all_site_c CURSOR FOR all_site_p      
         #FOREACH all_site_c INTO l_site  
         #   IF SQLCA.sqlcode THEN
         #      INITIALIZE g_errparam TO NULL
         #      LET g_errparam.code = SQLCA.sqlcode
         #      LET g_errparam.extend = "FOREACH:"
         #      LET g_errparam.popup = TRUE
         #      CALL cl_err()
         #
         #      EXIT FOREACH
         #   END IF      
         #
         #   INSERT INTO bmga_t (bmgaent,bmgasite,bmga001,bmga002,bmga003,
         #                       bmga004,bmga005,bmgaownid,bmgaowndp,bmgacrtid,
         #                       bmgacrtdp,bmgacrtdt,bmgamodid,bmgamoddt)
         #      VALUES (g_enterprise,l_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,
         #              g_bmga_m.bmga004,g_bmga_m.bmga005,g_bmga_m.bmgaownid,g_bmga_m.bmgaowndp,g_bmga_m.bmgacrtid,
         #              g_bmga_m.bmgacrtdp,g_bmga_m.bmgacrtdt,g_bmga_m.bmgamodid,g_bmga_m.bmgamoddt) 
         #   IF SQLCA.sqlcode THEN
         #      INITIALIZE g_errparam TO NULL
         #      LET g_errparam.code = SQLCA.sqlcode
         #      LET g_errparam.extend = "bmgb_t"
         #      LET g_errparam.popup = FALSE
         #      CALL cl_err()
         #      EXIT FOREACH
         #   END IF  
         #   INITIALIZE l_var_keys TO NULL 
         #   INITIALIZE l_field_keys TO NULL 
         #   INITIALIZE l_vars TO NULL 
         #   INITIALIZE l_fields TO NULL 
         #   IF g_bmga_m.bmga001 = g_master_multi_table_t.bmgal001 AND
         #      g_bmga_m.bmga002 = g_master_multi_table_t.bmgal002 AND
         #      g_bmga_m.bmga003 = g_master_multi_table_t.bmgal003 AND
         #      g_bmga_m.bmgal005 = g_master_multi_table_t.bmgal005  THEN
         #   ELSE 
         #      LET l_var_keys[01] = g_enterprise
         #      LET l_field_keys[01] = 'bmgalent'
         #      LET l_var_keys_bak[01] = g_enterprise
         #      LET l_var_keys[02] = l_site
         #      LET l_field_keys[02] = 'bmgalsite'
         #      LET l_var_keys_bak[02] = l_site
         #      LET l_var_keys[03] = g_bmga_m.bmga001
         #      LET l_field_keys[03] = 'bmgal001'
         #      LET l_var_keys_bak[03] = g_master_multi_table_t.bmgal001
         #      LET l_var_keys[04] = g_bmga_m.bmga002
         #      LET l_field_keys[04] = 'bmgal002'
         #      LET l_var_keys_bak[04] = g_master_multi_table_t.bmgal002
         #      LET l_var_keys[05] = g_bmga_m.bmga003
         #      LET l_field_keys[05] = 'bmgal003'
         #      LET l_var_keys_bak[05] = g_master_multi_table_t.bmgal003
         #      LET l_var_keys[06] = g_dlang
         #      LET l_field_keys[06] = 'bmgal004'
         #      LET l_var_keys_bak[06] = g_dlang
         #      LET l_vars[01] = g_bmga_m.bmgal005
         #      LET l_fields[01] = 'bmgal005'
         #      CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bmgal_t')
         #   END IF                     
         #END FOREACH 
         #161026-00034#1---add---e
      WHEN p_type = '2'          
         LET l_sql = "SELECT DISTINCT bmbasite FROM bmba_t ",
                     " WHERE bmbaent = '",g_enterprise,"'",
                     "   AND bmbasite <> '",g_site,"'",
                     "   AND bmba001 = '",g_bmga_m.bmga001,"'",
                     "   AND bmba002 = '",g_bmga_m.bmga002,"'",
                     "   AND bmba003 = '",g_bmgb_d[l_ac].bmgb005,"'",
                     "   AND bmba004 = '",g_bmgb_d[l_ac].bmgb006,"'",
                     "   AND bmba007 = '",g_bmgb_d[l_ac].bmgb007,"'",
                     "   AND bmba008 = '",g_bmgb_d[l_ac].bmgb008,"'",
                     "   AND bmba019 = '1' "
         PREPARE all_site_p2 FROM l_sql
         DECLARE all_site_c2 CURSOR FOR all_site_p2      
         FOREACH all_site_c2 INTO l_site
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               EXIT FOREACH
            END IF    
            INSERT INTO bmgb_t
                        (bmgbent,bmgbsite,bmgb001,bmgb002,bmgb003,
                         bmgb004,bmgb005,bmgb006,bmgb007,bmgb008,
                         bmgb009) 
                  VALUES(g_enterprise,l_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,
                         g_bmgb_d[l_ac].bmgb004,g_bmgb_d[l_ac].bmgb005,g_bmgb_d[l_ac].bmgb006,g_bmgb_d[l_ac].bmgb007,g_bmgb_d[l_ac].bmgb008,
                         g_bmgb_d[l_ac].bmgb009)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "bmgb_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()
               EXIT FOREACH
            END IF 
            
         END FOREACH 
      WHEN p_type = '3'
         LET l_sql = "SELECT DISTINCT bmaasite FROM bmaa_t ",
                     " WHERE bmaaent = '",g_enterprise,"'",
                     "   AND bmaasite <> '",g_site,"'",
                     "   AND bmaa001 = '",g_bmga_m.bmga001,"'",
                     "   AND bmaa002 = '",g_bmga_m.bmga002,"'"
         PREPARE all_site_p3 FROM l_sql
         DECLARE all_site_c3 CURSOR FOR all_site_p3      
         FOREACH all_site_c3 INTO l_site
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               EXIT FOREACH
            END IF       
      
            INSERT INTO bmgc_t 
                      (bmgcent,bmgcsite,bmgc001,bmgc002,bmgc003,
                       bmgc004,bmgc005,bmgc006,bmgc007,bmgc008,
                       bmgc009,bmgc010,bmgc011,bmgc012,bmgc013)   #160509-00009#6  #160614-00033#1 add bmgc013
                VALUES(g_enterprise,l_site,g_bmga_m.bmga001,g_bmga_m.bmga002,g_bmga_m.bmga003,
                       g_bmgb2_d[l_ac].bmgc004,g_bmgb2_d[l_ac].bmgc005,g_bmgb2_d[l_ac].bmgc006,g_bmgb2_d[l_ac].bmgc007,g_bmgb2_d[l_ac].bmgc008,
                       g_bmgb2_d[l_ac].bmgc009,g_bmgb2_d[l_ac].bmgc010,g_bmgb2_d[l_ac].bmgc011,g_bmgb2_d[l_ac].bmgc012,g_bmgb2_d[l_ac].bmgc013)       #160509-00009#6  #160614-00033#1 add bmgc013
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "bmgc_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()
               EXIT FOREACH
            END IF   
         END FOREACH                   
   END CASE      
END FUNCTION

 
{</section>}
 
