#該程式未解開Section, 採用最新樣板產出!
{<section id="axmi410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-05-12 08:55:21), PR版次:0007(2016-08-16 17:53:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000190
#+ Filename...: axmi410
#+ Description: 銷售報價範本維護作業
#+ Creator....: 05293(2014-06-16 14:07:15)
#+ Modifier...: 07024 -SD/PR- 06137
 
{</section>}
 
{<section id="axmi410.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151224-00025#2 15/12/25 By catmoon 手動輸入特徵碼同步新增inam_t[料件產品特徵明細檔]
#150522-00003#1 16/05/12 By dorislai 拿掉xmfb003的預設值('1')
#150810-00021#1 16/05/26 By shiun    aoos020中参数设置不使用产品特征时，请隐藏“已转订单状况”页签中的产品特征相关栏位
#160812-00017#5 16/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
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
PRIVATE type type_g_xmfa_m        RECORD
       xmfasite LIKE xmfa_t.xmfasite, 
   xmfadocno LIKE xmfa_t.xmfadocno, 
   xmfal003 LIKE xmfal_t.xmfal003, 
   xmfal004 LIKE xmfal_t.xmfal004, 
   xmfa001 LIKE xmfa_t.xmfa001, 
   xmfastus LIKE xmfa_t.xmfastus, 
   xmfaownid LIKE xmfa_t.xmfaownid, 
   xmfaownid_desc LIKE type_t.chr80, 
   xmfaowndp LIKE xmfa_t.xmfaowndp, 
   xmfaowndp_desc LIKE type_t.chr80, 
   xmfacrtid LIKE xmfa_t.xmfacrtid, 
   xmfacrtid_desc LIKE type_t.chr80, 
   xmfacrtdp LIKE xmfa_t.xmfacrtdp, 
   xmfacrtdp_desc LIKE type_t.chr80, 
   xmfacrtdt LIKE xmfa_t.xmfacrtdt, 
   xmfamodid LIKE xmfa_t.xmfamodid, 
   xmfamodid_desc LIKE type_t.chr80, 
   xmfamoddt LIKE xmfa_t.xmfamoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmfb_d        RECORD
       xmfbsite LIKE xmfb_t.xmfbsite, 
   xmfb002 LIKE xmfb_t.xmfb002, 
   xmfb003 LIKE xmfb_t.xmfb003, 
   xmfb003_desc LIKE type_t.chr500, 
   xmfb004 LIKE xmfb_t.xmfb004, 
   xmfb005 LIKE xmfb_t.xmfb005, 
   xmfb006 LIKE xmfb_t.xmfb006
       END RECORD
PRIVATE TYPE type_g_xmfb2_d RECORD
       xmfcsite LIKE xmfc_t.xmfcsite, 
   xmfc003 LIKE xmfc_t.xmfc003, 
   xmfc004 LIKE xmfc_t.xmfc004, 
   xmfc004_desc LIKE type_t.chr500, 
   xmfc004_desc_desc LIKE type_t.chr500, 
   xmfc005 LIKE xmfc_t.xmfc005, 
   xmfc005_desc LIKE type_t.chr500, 
   xmfc006 LIKE xmfc_t.xmfc006, 
   xmfc007 LIKE xmfc_t.xmfc007, 
   xmfc007_desc LIKE type_t.chr500, 
   xmfc008 LIKE xmfc_t.xmfc008
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xmfadocno LIKE xmfa_t.xmfadocno,
   b_xmfadocno_desc LIKE type_t.chr80,
      b_xmfa001 LIKE xmfa_t.xmfa001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_inam                DYNAMIC ARRAY OF RECORD   #記錄產品特徵
         inam001             LIKE inam_t.inam001,
         inam002             LIKE inam_t.inam002,
         inam004             LIKE inam_t.inam004
                             END RECORD
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xmfa_m          type_g_xmfa_m
DEFINE g_xmfa_m_t        type_g_xmfa_m
DEFINE g_xmfa_m_o        type_g_xmfa_m
DEFINE g_xmfa_m_mask_o   type_g_xmfa_m #轉換遮罩前資料
DEFINE g_xmfa_m_mask_n   type_g_xmfa_m #轉換遮罩後資料
 
   DEFINE g_xmfadocno_t LIKE xmfa_t.xmfadocno
DEFINE g_xmfa001_t LIKE xmfa_t.xmfa001
 
 
DEFINE g_xmfb_d          DYNAMIC ARRAY OF type_g_xmfb_d
DEFINE g_xmfb_d_t        type_g_xmfb_d
DEFINE g_xmfb_d_o        type_g_xmfb_d
DEFINE g_xmfb_d_mask_o   DYNAMIC ARRAY OF type_g_xmfb_d #轉換遮罩前資料
DEFINE g_xmfb_d_mask_n   DYNAMIC ARRAY OF type_g_xmfb_d #轉換遮罩後資料
DEFINE g_xmfb2_d          DYNAMIC ARRAY OF type_g_xmfb2_d
DEFINE g_xmfb2_d_t        type_g_xmfb2_d
DEFINE g_xmfb2_d_o        type_g_xmfb2_d
DEFINE g_xmfb2_d_mask_o   DYNAMIC ARRAY OF type_g_xmfb2_d #轉換遮罩前資料
DEFINE g_xmfb2_d_mask_n   DYNAMIC ARRAY OF type_g_xmfb2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      xmfaldocno LIKE xmfal_t.xmfaldocno,
      xmfal003 LIKE xmfal_t.xmfal003,
      xmfal004 LIKE xmfal_t.xmfal004
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
DEFINE g_wc2_table2   STRING
 
 
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
 
{<section id="axmi410.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xmfasite,xmfadocno,'','',xmfa001,xmfastus,xmfaownid,'',xmfaowndp,'',xmfacrtid, 
       '',xmfacrtdp,'',xmfacrtdt,xmfamodid,'',xmfamoddt", 
                      " FROM xmfa_t",
                      " WHERE xmfaent= ? AND xmfadocno=? AND xmfa001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmi410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmfasite,t0.xmfadocno,t0.xmfa001,t0.xmfastus,t0.xmfaownid,t0.xmfaowndp, 
       t0.xmfacrtid,t0.xmfacrtdp,t0.xmfacrtdt,t0.xmfamodid,t0.xmfamoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011",
               " FROM xmfa_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmfaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmfaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.xmfacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.xmfacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xmfamodid  ",
 
               " WHERE t0.xmfaent = " ||g_enterprise|| " AND t0.xmfadocno = ? AND t0.xmfa001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmi410_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmi410 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmi410_init()   
 
      #進入選單 Menu (="N")
      CALL axmi410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmi410
      
   END IF 
   
   CLOSE axmi410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmi410.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmi410_init()
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xmfastus','17','N,Y')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #add--150810-00021#1 By shiun--(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = "N" THEN
      CALL cl_set_comp_visible("xmfc005,xmfc005_desc",FALSE)
   END IF
   #add--150810-00021#1 By shiun--(E)
   #end add-point
   
   #初始化搜尋條件
   CALL axmi410_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axmi410.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axmi410_ui_dialog()
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
            CALL axmi410_insert()
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
         INITIALIZE g_xmfa_m.* TO NULL
         CALL g_xmfb_d.clear()
         CALL g_xmfb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmi410_init()
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
               
               CALL axmi410_fetch('') # reload data
               LET l_ac = 1
               CALL axmi410_ui_detailshow() #Setting the current row 
         
               CALL axmi410_idx_chk()
               #NEXT FIELD xmfb002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xmfb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmi410_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL axmi410_b_fill2('2')
 
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
               CALL axmi410_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_xmfb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmi410_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axmi410_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axmi410_browser_fill("")
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
               CALL axmi410_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axmi410_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axmi410_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axmi410_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axmi410_set_act_visible()   
            CALL axmi410_set_act_no_visible()
            IF NOT (g_xmfa_m.xmfadocno IS NULL
              OR g_xmfa_m.xmfa001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xmfaent = " ||g_enterprise|| " AND",
                                  " xmfadocno = '", g_xmfa_m.xmfadocno, "' "
                                  ," AND xmfa001 = '", g_xmfa_m.xmfa001, "' "
 
               #填到對應位置
               CALL axmi410_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xmfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmfb_t" 
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
               CALL axmi410_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xmfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmfb_t" 
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
                  CALL axmi410_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axmi410_fetch("F")
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
               CALL axmi410_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axmi410_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi410_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axmi410_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi410_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axmi410_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi410_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axmi410_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi410_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axmi410_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi410_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xmfb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xmfb2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               NEXT FIELD xmfb002
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
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmi410_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmi410_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmi410_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
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
               CALL axmi410_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axmi410_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axmi410_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmi410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmi410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmi410_set_pk_array()
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
 
{<section id="axmi410.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axmi410_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT xmfadocno,xmfa001 ",
                      " FROM xmfa_t ",
                      " ",
                      " LEFT JOIN xmfb_t ON xmfbent = xmfaent AND xmfadocno = xmfbdocno AND xmfa001 = xmfb001 ", "  ",
                      #add-point:browser_fill段sql(xmfb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN xmfc_t ON xmfcent = xmfaent AND xmfbdocno = xmfcdocno AND xmfb001 = xmfc001 AND xmfb002 = xmfc002", "  ",
                      #add-point:browser_fill段sql(xmfc_t1) name="browser_fill.cnt.join.xmfc_t1"
                      
                      #end add-point
 
 
                      " LEFT JOIN xmfal_t ON xmfalent = "||g_enterprise||" AND xmfadocno = xmfaldocno AND xmfal002 = '",g_dlang,"' ", 
                      " ", 
 
                      " ",
 
 
                      " WHERE xmfaent = " ||g_enterprise|| " AND xmfbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xmfa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xmfadocno,xmfa001 ",
                      " FROM xmfa_t ", 
                      "  ",
                      "  LEFT JOIN xmfal_t ON xmfalent = "||g_enterprise||" AND xmfadocno = xmfaldocno AND xmfal002 = '",g_dlang,"' ",
                      " WHERE xmfaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xmfa_t")
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
      INITIALIZE g_xmfa_m.* TO NULL
      CALL g_xmfb_d.clear()        
      CALL g_xmfb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xmfadocno,t0.xmfa001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmfastus,t0.xmfadocno,t0.xmfa001,t1.xmfal003 ",
                  " FROM xmfa_t t0",
                  "  ",
                  "  LEFT JOIN xmfb_t ON xmfbent = xmfaent AND xmfadocno = xmfbdocno AND xmfa001 = xmfb001 ", "  ", 
                  #add-point:browser_fill段sql(xmfb_t1) name="browser_fill.join.xmfb_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmfc_t ON xmfcent = xmfaent AND xmfbdocno = xmfcdocno AND xmfb001 = xmfc001 AND xmfb002 = xmfc002", "  ", 
                  #add-point:browser_fill段sql(xmfc_t1) name="browser_fill.join.xmfc_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                                 " LEFT JOIN xmfal_t t1 ON t1.xmfalent="||g_enterprise||" AND t1.xmfaldocno=t0.xmfadocno AND t1.xmfal002='"||g_dlang||"' ",
 
                  " WHERE t0.xmfaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xmfa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmfastus,t0.xmfadocno,t0.xmfa001,t1.xmfal003 ",
                  " FROM xmfa_t t0",
                  "  ",
                                 " LEFT JOIN xmfal_t t1 ON t1.xmfalent="||g_enterprise||" AND t1.xmfaldocno=t0.xmfadocno AND t1.xmfal002='"||g_dlang||"' ",
 
                  " WHERE t0.xmfaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xmfa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY xmfadocno,xmfa001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmfa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xmfadocno,g_browser[g_cnt].b_xmfa001, 
          g_browser[g_cnt].b_xmfadocno_desc
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
         CALL axmi410_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_xmfadocno) THEN
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
 
{<section id="axmi410.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axmi410_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xmfa_m.xmfadocno = g_browser[g_current_idx].b_xmfadocno   
   LET g_xmfa_m.xmfa001 = g_browser[g_current_idx].b_xmfa001   
 
   EXECUTE axmi410_master_referesh USING g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfa_m.xmfasite, 
       g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid, 
       g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt,g_xmfa_m.xmfaownid_desc, 
       g_xmfa_m.xmfaowndp_desc,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfamodid_desc 
 
   
   CALL axmi410_xmfa_t_mask()
   CALL axmi410_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axmi410.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axmi410_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmi410_ui_browser_refresh()
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
      IF g_browser[l_i].b_xmfadocno = g_xmfa_m.xmfadocno 
         AND g_browser[l_i].b_xmfa001 = g_xmfa_m.xmfa001 
 
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
 
{<section id="axmi410.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmi410_construct()
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
   INITIALIZE g_xmfa_m.* TO NULL
   CALL g_xmfb_d.clear()        
   CALL g_xmfb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON xmfasite,xmfadocno,xmfal003,xmfal004,xmfa001,xmfastus,xmfaownid,xmfaowndp, 
          xmfacrtid,xmfacrtdp,xmfacrtdt,xmfamodid,xmfamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmfacrtdt>>----
         AFTER FIELD xmfacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmfamoddt>>----
         AFTER FIELD xmfamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmfacnfdt>>----
         
         #----<<xmfapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfasite
            #add-point:BEFORE FIELD xmfasite name="construct.b.xmfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfasite
            
            #add-point:AFTER FIELD xmfasite name="construct.a.xmfasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfasite
            #add-point:ON ACTION controlp INFIELD xmfasite name="construct.c.xmfasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfadocno
            #add-point:ON ACTION controlp INFIELD xmfadocno name="construct.c.xmfadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmfadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfadocno  #顯示到畫面上
            NEXT FIELD xmfadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfadocno
            #add-point:BEFORE FIELD xmfadocno name="construct.b.xmfadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfadocno
            
            #add-point:AFTER FIELD xmfadocno name="construct.a.xmfadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfal003
            #add-point:BEFORE FIELD xmfal003 name="construct.b.xmfal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfal003
            
            #add-point:AFTER FIELD xmfal003 name="construct.a.xmfal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfal003
            #add-point:ON ACTION controlp INFIELD xmfal003 name="construct.c.xmfal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfal004
            #add-point:BEFORE FIELD xmfal004 name="construct.b.xmfal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfal004
            
            #add-point:AFTER FIELD xmfal004 name="construct.a.xmfal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfal004
            #add-point:ON ACTION controlp INFIELD xmfal004 name="construct.c.xmfal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfa001
            #add-point:BEFORE FIELD xmfa001 name="construct.b.xmfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfa001
            
            #add-point:AFTER FIELD xmfa001 name="construct.a.xmfa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfa001
            #add-point:ON ACTION controlp INFIELD xmfa001 name="construct.c.xmfa001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfastus
            #add-point:BEFORE FIELD xmfastus name="construct.b.xmfastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfastus
            
            #add-point:AFTER FIELD xmfastus name="construct.a.xmfastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfastus
            #add-point:ON ACTION controlp INFIELD xmfastus name="construct.c.xmfastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfaownid
            #add-point:ON ACTION controlp INFIELD xmfaownid name="construct.c.xmfaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfaownid  #顯示到畫面上
            NEXT FIELD xmfaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfaownid
            #add-point:BEFORE FIELD xmfaownid name="construct.b.xmfaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfaownid
            
            #add-point:AFTER FIELD xmfaownid name="construct.a.xmfaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfaowndp
            #add-point:ON ACTION controlp INFIELD xmfaowndp name="construct.c.xmfaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfaowndp  #顯示到畫面上
            NEXT FIELD xmfaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfaowndp
            #add-point:BEFORE FIELD xmfaowndp name="construct.b.xmfaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfaowndp
            
            #add-point:AFTER FIELD xmfaowndp name="construct.a.xmfaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfacrtid
            #add-point:ON ACTION controlp INFIELD xmfacrtid name="construct.c.xmfacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfacrtid  #顯示到畫面上
            NEXT FIELD xmfacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfacrtid
            #add-point:BEFORE FIELD xmfacrtid name="construct.b.xmfacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfacrtid
            
            #add-point:AFTER FIELD xmfacrtid name="construct.a.xmfacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfacrtdp
            #add-point:ON ACTION controlp INFIELD xmfacrtdp name="construct.c.xmfacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfacrtdp  #顯示到畫面上
            NEXT FIELD xmfacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfacrtdp
            #add-point:BEFORE FIELD xmfacrtdp name="construct.b.xmfacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfacrtdp
            
            #add-point:AFTER FIELD xmfacrtdp name="construct.a.xmfacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfacrtdt
            #add-point:BEFORE FIELD xmfacrtdt name="construct.b.xmfacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfamodid
            #add-point:ON ACTION controlp INFIELD xmfamodid name="construct.c.xmfamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfamodid  #顯示到畫面上
            NEXT FIELD xmfamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfamodid
            #add-point:BEFORE FIELD xmfamodid name="construct.b.xmfamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfamodid
            
            #add-point:AFTER FIELD xmfamodid name="construct.a.xmfamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfamoddt
            #add-point:BEFORE FIELD xmfamoddt name="construct.b.xmfamoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xmfbsite,xmfb002,xmfb003,xmfb004,xmfb005,xmfb006
           FROM s_detail1[1].xmfbsite,s_detail1[1].xmfb002,s_detail1[1].xmfb003,s_detail1[1].xmfb004, 
               s_detail1[1].xmfb005,s_detail1[1].xmfb006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfbsite
            #add-point:BEFORE FIELD xmfbsite name="construct.b.page1.xmfbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfbsite
            
            #add-point:AFTER FIELD xmfbsite name="construct.a.page1.xmfbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfbsite
            #add-point:ON ACTION controlp INFIELD xmfbsite name="construct.c.page1.xmfbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb002
            #add-point:BEFORE FIELD xmfb002 name="construct.b.page1.xmfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb002
            
            #add-point:AFTER FIELD xmfb002 name="construct.a.page1.xmfb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb002
            #add-point:ON ACTION controlp INFIELD xmfb002 name="construct.c.page1.xmfb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmfb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb003
            #add-point:ON ACTION controlp INFIELD xmfb003 name="construct.c.page1.xmfb003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #給予arg
            LET g_qryparam.arg1 = '803'
            CALL q_oocq002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfb003  #顯示到畫面上
            NEXT FIELD xmfb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb003
            #add-point:BEFORE FIELD xmfb003 name="construct.b.page1.xmfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb003
            
            #add-point:AFTER FIELD xmfb003 name="construct.a.page1.xmfb003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb004
            #add-point:BEFORE FIELD xmfb004 name="construct.b.page1.xmfb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb004
            
            #add-point:AFTER FIELD xmfb004 name="construct.a.page1.xmfb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb004
            #add-point:ON ACTION controlp INFIELD xmfb004 name="construct.c.page1.xmfb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb005
            #add-point:BEFORE FIELD xmfb005 name="construct.b.page1.xmfb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb005
            
            #add-point:AFTER FIELD xmfb005 name="construct.a.page1.xmfb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb005
            #add-point:ON ACTION controlp INFIELD xmfb005 name="construct.c.page1.xmfb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb006
            #add-point:BEFORE FIELD xmfb006 name="construct.b.page1.xmfb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb006
            
            #add-point:AFTER FIELD xmfb006 name="construct.a.page1.xmfb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb006
            #add-point:ON ACTION controlp INFIELD xmfb006 name="construct.c.page1.xmfb006"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON xmfcsite,xmfc003,xmfc004,xmfc005,xmfc006,xmfc007,xmfc008
           FROM s_detail2[1].xmfcsite,s_detail2[1].xmfc003,s_detail2[1].xmfc004,s_detail2[1].xmfc005, 
               s_detail2[1].xmfc006,s_detail2[1].xmfc007,s_detail2[1].xmfc008
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfcsite
            #add-point:BEFORE FIELD xmfcsite name="construct.b.page2.xmfcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfcsite
            
            #add-point:AFTER FIELD xmfcsite name="construct.a.page2.xmfcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfcsite
            #add-point:ON ACTION controlp INFIELD xmfcsite name="construct.c.page2.xmfcsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc003
            #add-point:BEFORE FIELD xmfc003 name="construct.b.page2.xmfc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc003
            
            #add-point:AFTER FIELD xmfc003 name="construct.a.page2.xmfc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc003
            #add-point:ON ACTION controlp INFIELD xmfc003 name="construct.c.page2.xmfc003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmfc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc004
            #add-point:ON ACTION controlp INFIELD xmfc004 name="construct.c.page2.xmfc004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfc004  #顯示到畫面上
            NEXT FIELD xmfc004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc004
            #add-point:BEFORE FIELD xmfc004 name="construct.b.page2.xmfc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc004
            
            #add-point:AFTER FIELD xmfc004 name="construct.a.page2.xmfc004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc005
            #add-point:BEFORE FIELD xmfc005 name="construct.b.page2.xmfc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc005
            
            #add-point:AFTER FIELD xmfc005 name="construct.a.page2.xmfc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc005
            #add-point:ON ACTION controlp INFIELD xmfc005 name="construct.c.page2.xmfc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc006
            #add-point:BEFORE FIELD xmfc006 name="construct.b.page2.xmfc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc006
            
            #add-point:AFTER FIELD xmfc006 name="construct.a.page2.xmfc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc006
            #add-point:ON ACTION controlp INFIELD xmfc006 name="construct.c.page2.xmfc006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmfc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc007
            #add-point:ON ACTION controlp INFIELD xmfc007 name="construct.c.page2.xmfc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc007
            #add-point:BEFORE FIELD xmfc007 name="construct.b.page2.xmfc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc007
            
            #add-point:AFTER FIELD xmfc007 name="construct.a.page2.xmfc007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc008
            #add-point:BEFORE FIELD xmfc008 name="construct.b.page2.xmfc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc008
            
            #add-point:AFTER FIELD xmfc008 name="construct.a.page2.xmfc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc008
            #add-point:ON ACTION controlp INFIELD xmfc008 name="construct.c.page2.xmfc008"
 
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
                  WHEN la_wc[li_idx].tableid = "xmfa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmfb_t" 
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
 
 
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmi410_filter()
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
      CONSTRUCT g_wc_filter ON xmfadocno,xmfa001
                          FROM s_browse[1].b_xmfadocno,s_browse[1].b_xmfa001
 
         BEFORE CONSTRUCT
               DISPLAY axmi410_filter_parser('xmfadocno') TO s_browse[1].b_xmfadocno
            DISPLAY axmi410_filter_parser('xmfa001') TO s_browse[1].b_xmfa001
      
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
 
      CALL axmi410_filter_show('xmfadocno')
   CALL axmi410_filter_show('xmfa001')
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmi410_filter_parser(ps_field)
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
 
{<section id="axmi410.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmi410_filter_show(ps_field)
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
   LET ls_condition = axmi410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmi410_query()
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
   CALL g_xmfb_d.clear()
   CALL g_xmfb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axmi410_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmi410_browser_fill("")
      CALL axmi410_fetch("")
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL axmi410_filter_show('xmfadocno')
   CALL axmi410_filter_show('xmfa001')
   CALL axmi410_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axmi410_fetch("F") 
      #顯示單身筆數
      CALL axmi410_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmi410_fetch(p_flag)
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
   CALL g_xmfb2_d.clear()
 
   
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
   
   LET g_xmfa_m.xmfadocno = g_browser[g_current_idx].b_xmfadocno
   LET g_xmfa_m.xmfa001 = g_browser[g_current_idx].b_xmfa001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axmi410_master_referesh USING g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfa_m.xmfasite, 
       g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid, 
       g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt,g_xmfa_m.xmfaownid_desc, 
       g_xmfa_m.xmfaowndp_desc,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfamodid_desc 
 
   
   #遮罩相關處理
   LET g_xmfa_m_mask_o.* =  g_xmfa_m.*
   CALL axmi410_xmfa_t_mask()
   LET g_xmfa_m_mask_n.* =  g_xmfa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmi410_set_act_visible()   
   CALL axmi410_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmfa_m_t.* = g_xmfa_m.*
   LET g_xmfa_m_o.* = g_xmfa_m.*
   
   LET g_data_owner = g_xmfa_m.xmfaownid      
   LET g_data_dept  = g_xmfa_m.xmfaowndp
   
   #重新顯示   
   CALL axmi410_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmi410_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xmfb_d.clear()   
   CALL g_xmfb2_d.clear()  
 
 
   INITIALIZE g_xmfa_m.* TO NULL             #DEFAULT 設定
   
   LET g_xmfadocno_t = NULL
   LET g_xmfa001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmfa_m.xmfaownid = g_user
      LET g_xmfa_m.xmfaowndp = g_dept
      LET g_xmfa_m.xmfacrtid = g_user
      LET g_xmfa_m.xmfacrtdp = g_dept 
      LET g_xmfa_m.xmfacrtdt = cl_get_current()
      LET g_xmfa_m.xmfamodid = g_user
      LET g_xmfa_m.xmfamoddt = cl_get_current()
      LET g_xmfa_m.xmfastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xmfa_m.xmfa001 = "0"
      LET g_xmfa_m.xmfastus = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xmfa_m_t.* = g_xmfa_m.*
      LET g_xmfa_m_o.* = g_xmfa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmfa_m.xmfastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL axmi410_input("a")
      
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
         INITIALIZE g_xmfa_m.* TO NULL
         INITIALIZE g_xmfb_d TO NULL
         INITIALIZE g_xmfb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axmi410_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xmfb_d.clear()
      #CALL g_xmfb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmi410_set_act_visible()   
   CALL axmi410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmfadocno_t = g_xmfa_m.xmfadocno
   LET g_xmfa001_t = g_xmfa_m.xmfa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmfaent = " ||g_enterprise|| " AND",
                      " xmfadocno = '", g_xmfa_m.xmfadocno, "' "
                      ," AND xmfa001 = '", g_xmfa_m.xmfa001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmi410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axmi410_cl
   
   CALL axmi410_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmi410_master_referesh USING g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfa_m.xmfasite, 
       g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid, 
       g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt,g_xmfa_m.xmfaownid_desc, 
       g_xmfa_m.xmfaowndp_desc,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfamodid_desc 
 
   
   
   #遮罩相關處理
   LET g_xmfa_m_mask_o.* =  g_xmfa_m.*
   CALL axmi410_xmfa_t_mask()
   LET g_xmfa_m_mask_n.* =  g_xmfa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfal003,g_xmfa_m.xmfal004,g_xmfa_m.xmfa001, 
       g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaownid_desc,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfaowndp_desc, 
       g_xmfa_m.xmfacrtid,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfacrtdt, 
       g_xmfa_m.xmfamodid,g_xmfa_m.xmfamodid_desc,g_xmfa_m.xmfamoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xmfa_m.xmfaownid      
   LET g_data_dept  = g_xmfa_m.xmfaowndp
   
   #功能已完成,通報訊息中心
   CALL axmi410_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmi410_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmfa_m_t.* = g_xmfa_m.*
   LET g_xmfa_m_o.* = g_xmfa_m.*
   
   IF g_xmfa_m.xmfadocno IS NULL
   OR g_xmfa_m.xmfa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xmfadocno_t = g_xmfa_m.xmfadocno
   LET g_xmfa001_t = g_xmfa_m.xmfa001
 
   CALL s_transaction_begin()
   
   OPEN axmi410_cl USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmi410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmi410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmi410_master_referesh USING g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfa_m.xmfasite, 
       g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid, 
       g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt,g_xmfa_m.xmfaownid_desc, 
       g_xmfa_m.xmfaowndp_desc,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfamodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT axmi410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmfa_m_mask_o.* =  g_xmfa_m.*
   CALL axmi410_xmfa_t_mask()
   LET g_xmfa_m_mask_n.* =  g_xmfa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL axmi410_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_xmfadocno_t = g_xmfa_m.xmfadocno
      LET g_xmfa001_t = g_xmfa_m.xmfa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xmfa_m.xmfamodid = g_user 
LET g_xmfa_m.xmfamoddt = cl_get_current()
LET g_xmfa_m.xmfamodid_desc = cl_get_username(g_xmfa_m.xmfamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axmi410_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xmfa_t SET (xmfamodid,xmfamoddt) = (g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt)
          WHERE xmfaent = g_enterprise AND xmfadocno = g_xmfadocno_t
            AND xmfa001 = g_xmfa001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xmfa_m.* = g_xmfa_m_t.*
            CALL axmi410_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xmfa_m.xmfadocno != g_xmfa_m_t.xmfadocno
      OR g_xmfa_m.xmfa001 != g_xmfa_m_t.xmfa001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xmfb_t SET xmfbdocno = g_xmfa_m.xmfadocno
                                       ,xmfb001 = g_xmfa_m.xmfa001
 
          WHERE xmfbent = g_enterprise AND xmfbdocno = g_xmfa_m_t.xmfadocno
            AND xmfb001 = g_xmfa_m_t.xmfa001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmfb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         UPDATE xmfc_t
            SET xmfcdocno = g_xmfa_m.xmfadocno
               ,xmfc001 = g_xmfa_m.xmfa001
 
          WHERE xmfcent = g_enterprise AND
                xmfcdocno = g_xmfadocno_t
            AND xmfc001 = g_xmfa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfc_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmi410_set_act_visible()   
   CALL axmi410_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmfaent = " ||g_enterprise|| " AND",
                      " xmfadocno = '", g_xmfa_m.xmfadocno, "' "
                      ," AND xmfa001 = '", g_xmfa_m.xmfa001, "' "
 
   #填到對應位置
   CALL axmi410_browser_fill("")
 
   CLOSE axmi410_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmi410_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axmi410.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmi410_input(p_cmd)
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
   DEFINE  l_success1            LIKE type_t.num5
   DEFINE ls_replace_arg         STRING
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
   DISPLAY BY NAME g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfal003,g_xmfa_m.xmfal004,g_xmfa_m.xmfa001, 
       g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaownid_desc,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfaowndp_desc, 
       g_xmfa_m.xmfacrtid,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfacrtdt, 
       g_xmfa_m.xmfamodid,g_xmfa_m.xmfamodid_desc,g_xmfa_m.xmfamoddt
   
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
   LET g_forupd_sql = "SELECT xmfbsite,xmfb002,xmfb003,xmfb004,xmfb005,xmfb006 FROM xmfb_t WHERE xmfbent=?  
       AND xmfbdocno=? AND xmfb001=? AND xmfb002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmi410_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xmfcsite,xmfc003,xmfc004,xmfc005,xmfc006,xmfc007,xmfc008 FROM xmfc_t WHERE  
       xmfcent=? AND xmfcdocno=? AND xmfc001=? AND xmfc002=? AND xmfc003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmi410_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axmi410_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axmi410_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfal003,g_xmfa_m.xmfal004,g_xmfa_m.xmfa001, 
       g_xmfa_m.xmfastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_success1 = FALSE
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axmi410.input.head" >}
      #單頭段
      INPUT BY NAME g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfal003,g_xmfa_m.xmfal004,g_xmfa_m.xmfa001, 
          g_xmfa_m.xmfastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_xmfa_m.xmfadocno) THEN
                  CALL n_xmfal(g_xmfa_m.xmfadocno)
                  CALL axmi410_xmfadocno_ref()
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axmi410_cl USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmi410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmi410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.xmfaldocno = g_xmfa_m.xmfadocno
LET g_master_multi_table_t.xmfal003 = g_xmfa_m.xmfal003
LET g_master_multi_table_t.xmfal004 = g_xmfa_m.xmfal004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.xmfaldocno = ''
LET g_master_multi_table_t.xmfal003 = ''
LET g_master_multi_table_t.xmfal004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axmi410_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_xmfa_m.xmfasite = g_site
            #end add-point
            CALL axmi410_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfasite
            #add-point:BEFORE FIELD xmfasite name="input.b.xmfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfasite
            
            #add-point:AFTER FIELD xmfasite name="input.a.xmfasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfasite
            #add-point:ON CHANGE xmfasite name="input.g.xmfasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfadocno
            #add-point:BEFORE FIELD xmfadocno name="input.b.xmfadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfadocno
            
            #add-point:AFTER FIELD xmfadocno name="input.a.xmfadocno"
            #校驗
            LET g_xmfa_m.xmfal003 = ''
            LET g_xmfa_m.xmfal004 = ''
            DISPLAY BY NAME g_xmfa_m.xmfal003
            DISPLAY BY NAME g_xmfa_m.xmfal004
            IF NOT cl_null(g_xmfa_m.xmfadocno) AND NOT cl_null(g_xmfa_m.xmfa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfa_m.xmfadocno != g_xmfadocno_t  OR g_xmfa_m.xmfa001 != g_xmfa001_t )) THEN 
                  IF NOT axmi410_xmfa001_chk() THEN
                     LET g_xmfa_m.xmfa001 = g_xmfa_m_t.xmfa001
                     DISPLAY BY NAME g_xmfa_m.xmfa001
                     CALL axmi410_xmfadocno_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmi410_xmfadocno_ref()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfadocno
            #add-point:ON CHANGE xmfadocno name="input.g.xmfadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfal003
            #add-point:BEFORE FIELD xmfal003 name="input.b.xmfal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfal003
            
            #add-point:AFTER FIELD xmfal003 name="input.a.xmfal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfal003
            #add-point:ON CHANGE xmfal003 name="input.g.xmfal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfal004
            #add-point:BEFORE FIELD xmfal004 name="input.b.xmfal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfal004
            
            #add-point:AFTER FIELD xmfal004 name="input.a.xmfal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfal004
            #add-point:ON CHANGE xmfal004 name="input.g.xmfal004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfa001
            
            #add-point:AFTER FIELD xmfa001 name="input.a.xmfa001"
            IF NOT cl_null(g_xmfa_m.xmfadocno) AND NOT cl_null(g_xmfa_m.xmfa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfa_m.xmfadocno != g_xmfadocno_t  OR g_xmfa_m.xmfa001 != g_xmfa001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfa_t WHERE "||"xmfaent = '" ||g_enterprise|| "' AND "||"xmfadocno = '"||g_xmfa_m.xmfadocno ||"' AND "|| "xmfa001 = '"||g_xmfa_m.xmfa001 ||"'",'std-00004',0) THEN 
                     LET g_xmfa_m.xmfa001 = g_xmfa_m_t.xmfa001
                     DISPLAY BY NAME g_xmfa_m.xmfa001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #校驗
            IF NOT cl_null(g_xmfa_m.xmfadocno) AND NOT cl_null(g_xmfa_m.xmfa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfa_m.xmfadocno != g_xmfadocno_t  OR g_xmfa_m.xmfa001 != g_xmfa001_t )) THEN 
                  IF NOT axmi410_xmfa001_chk() THEN
                     LET g_xmfa_m.xmfa001 = g_xmfa_m_t.xmfa001
                     DISPLAY BY NAME g_xmfa_m.xmfa001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfa001
            #add-point:BEFORE FIELD xmfa001 name="input.b.xmfa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfa001
            #add-point:ON CHANGE xmfa001 name="input.g.xmfa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfastus
            #add-point:BEFORE FIELD xmfastus name="input.b.xmfastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfastus
            
            #add-point:AFTER FIELD xmfastus name="input.a.xmfastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfastus
            #add-point:ON CHANGE xmfastus name="input.g.xmfastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmfasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfasite
            #add-point:ON ACTION controlp INFIELD xmfasite name="input.c.xmfasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfadocno
            #add-point:ON ACTION controlp INFIELD xmfadocno name="input.c.xmfadocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfal003
            #add-point:ON ACTION controlp INFIELD xmfal003 name="input.c.xmfal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfal004
            #add-point:ON ACTION controlp INFIELD xmfal004 name="input.c.xmfal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfa001
            #add-point:ON ACTION controlp INFIELD xmfa001 name="input.c.xmfa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfastus
            #add-point:ON ACTION controlp INFIELD xmfastus name="input.c.xmfastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xmfa_t (xmfaent,xmfasite,xmfadocno,xmfa001,xmfastus,xmfaownid,xmfaowndp,xmfacrtid, 
                   xmfacrtdp,xmfacrtdt,xmfamodid,xmfamoddt)
               VALUES (g_enterprise,g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus, 
                   g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid,g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt, 
                   g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xmfa_m:",SQLERRMESSAGE 
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
         IF g_xmfa_m.xmfadocno = g_master_multi_table_t.xmfaldocno AND
         g_xmfa_m.xmfal003 = g_master_multi_table_t.xmfal003 AND 
         g_xmfa_m.xmfal004 = g_master_multi_table_t.xmfal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xmfalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xmfa_m.xmfadocno
            LET l_field_keys[02] = 'xmfaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.xmfaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'xmfal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_xmfa_m.xmfal003
            LET l_fields[01] = 'xmfal003'
            LET l_vars[02] = g_xmfa_m.xmfal004
            LET l_fields[02] = 'xmfal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xmfal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axmi410_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axmi410_b_fill()
                  CALL axmi410_b_fill2('0')
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
               CALL axmi410_xmfa_t_mask_restore('restore_mask_o')
               
               UPDATE xmfa_t SET (xmfasite,xmfadocno,xmfa001,xmfastus,xmfaownid,xmfaowndp,xmfacrtid, 
                   xmfacrtdp,xmfacrtdt,xmfamodid,xmfamoddt) = (g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno, 
                   g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid, 
                   g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt)
                WHERE xmfaent = g_enterprise AND xmfadocno = g_xmfadocno_t
                  AND xmfa001 = g_xmfa001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xmfa_t:",SQLERRMESSAGE 
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
         IF g_xmfa_m.xmfadocno = g_master_multi_table_t.xmfaldocno AND
         g_xmfa_m.xmfal003 = g_master_multi_table_t.xmfal003 AND 
         g_xmfa_m.xmfal004 = g_master_multi_table_t.xmfal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xmfalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xmfa_m.xmfadocno
            LET l_field_keys[02] = 'xmfaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.xmfaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'xmfal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_xmfa_m.xmfal003
            LET l_fields[01] = 'xmfal003'
            LET l_vars[02] = g_xmfa_m.xmfal004
            LET l_fields[02] = 'xmfal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xmfal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL axmi410_xmfa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xmfa_m_t)
               LET g_log2 = util.JSON.stringify(g_xmfa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xmfadocno_t = g_xmfa_m.xmfadocno
            LET g_xmfa001_t = g_xmfa_m.xmfa001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axmi410.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xmfb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmi410_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xmfb_d.getLength()
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
            CALL axmi410_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axmi410_cl USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmi410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmi410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfb_d[l_ac].xmfb002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmfb_d_t.* = g_xmfb_d[l_ac].*  #BACKUP
               LET g_xmfb_d_o.* = g_xmfb_d[l_ac].*  #BACKUP
               CALL axmi410_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axmi410_set_no_entry_b(l_cmd)
               IF NOT axmi410_lock_b("xmfb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmi410_bcl INTO g_xmfb_d[l_ac].xmfbsite,g_xmfb_d[l_ac].xmfb002,g_xmfb_d[l_ac].xmfb003, 
                      g_xmfb_d[l_ac].xmfb004,g_xmfb_d[l_ac].xmfb005,g_xmfb_d[l_ac].xmfb006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmfb_d_t.xmfb002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfb_d_mask_o[l_ac].* =  g_xmfb_d[l_ac].*
                  CALL axmi410_xmfb_t_mask()
                  LET g_xmfb_d_mask_n[l_ac].* =  g_xmfb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmi410_show()
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
            INITIALIZE g_xmfb_d[l_ac].* TO NULL 
            INITIALIZE g_xmfb_d_t.* TO NULL 
            INITIALIZE g_xmfb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xmfb_d[l_ac].xmfb004 = "Y"
      LET g_xmfb_d[l_ac].xmfb005 = "0"
      LET g_xmfb_d[l_ac].xmfb006 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xmfb_d_t.* = g_xmfb_d[l_ac].*     #新輸入資料
            LET g_xmfb_d_o.* = g_xmfb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmi410_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axmi410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfb_d[li_reproduce_target].* = g_xmfb_d[li_reproduce].*
 
               LET g_xmfb_d[li_reproduce_target].xmfb002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #序號=最大值+1
            SELECT MAX(xmfb002)+1 INTO g_xmfb_d[l_ac].xmfb002 
              FROM xmfb_t
             WHERE xmfbent = g_enterprise
               AND xmfbdocno = g_xmfa_m.xmfadocno
               AND xmfb001 = g_xmfa_m.xmfa001 
            IF cl_null(g_xmfb_d[l_ac].xmfb002) THEN 
               LET g_xmfb_d[l_ac].xmfb002 = 1
            END IF
            DISPLAY BY NAME g_xmfb_d[l_ac].xmfb002
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
            SELECT COUNT(1) INTO l_count FROM xmfb_t 
             WHERE xmfbent = g_enterprise AND xmfbdocno = g_xmfa_m.xmfadocno
               AND xmfb001 = g_xmfa_m.xmfa001
 
               AND xmfb002 = g_xmfb_d[l_ac].xmfb002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfa_m.xmfadocno
               LET gs_keys[2] = g_xmfa_m.xmfa001
               LET gs_keys[3] = g_xmfb_d[g_detail_idx].xmfb002
               CALL axmi410_insert_b('xmfb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xmfb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmi410_b_fill()
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
               LET gs_keys[01] = g_xmfa_m.xmfadocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfa_m.xmfa001
 
               LET gs_keys[gs_keys.getLength()+1] = g_xmfb_d_t.xmfb002
 
            
               #刪除同層單身
               IF NOT axmi410_delete_b('xmfb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmi410_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmi410_key_delete_b(gs_keys,'xmfb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmi410_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axmi410_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xmfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfbsite
            #add-point:BEFORE FIELD xmfbsite name="input.b.page1.xmfbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfbsite
            
            #add-point:AFTER FIELD xmfbsite name="input.a.page1.xmfbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfbsite
            #add-point:ON CHANGE xmfbsite name="input.g.page1.xmfbsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfb_d[l_ac].xmfb002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmfb002
            END IF 
 
 
 
            #add-point:AFTER FIELD xmfb002 name="input.a.page1.xmfb002"
            #此段落由子樣板a05產生
            IF  g_xmfa_m.xmfadocno IS NOT NULL AND g_xmfa_m.xmfa001 IS NOT NULL AND g_xmfb_d[g_detail_idx].xmfb002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfa_m.xmfadocno != g_xmfadocno_t OR g_xmfa_m.xmfa001 != g_xmfa001_t OR g_xmfb_d[g_detail_idx].xmfb002 != g_xmfb_d_t.xmfb002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfb_t WHERE "||"xmfbent = '" ||g_enterprise|| "' AND "||"xmfbdocno = '"||g_xmfa_m.xmfadocno ||"' AND "|| "xmfb001 = '"||g_xmfa_m.xmfa001 ||"' AND "|| "xmfb002 = '"||g_xmfb_d[g_detail_idx].xmfb002 ||"'",'std-00004',0) THEN 
                     LET g_xmfb_d[g_detail_idx].xmfb002 = g_xmfb_d_t.xmfb002
                     DISPLAY BY NAME g_xmfb_d[g_detail_idx].xmfb002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb002
            #add-point:BEFORE FIELD xmfb002 name="input.b.page1.xmfb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfb002
            #add-point:ON CHANGE xmfb002 name="input.g.page1.xmfb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb003
            
            #add-point:AFTER FIELD xmfb003 name="input.a.page1.xmfb003"
            LET g_xmfb_d[l_ac].xmfb003_desc = ' '
            DISPLAY BY NAME g_xmfb_d[l_ac].xmfb003_desc
            IF NOT cl_null(g_xmfb_d[l_ac].xmfb003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfb_d[l_ac].xmfb003 != g_xmfb_d_t.xmfb003 OR g_xmfb_d_t.xmfb003 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  IF NOT s_azzi650_chk_exist('803',g_xmfb_d[l_ac].xmfb003) THEN
                     LET g_xmfb_d[l_ac].xmfb003 = g_xmfb_d_t.xmfb003
                     DISPLAY BY NAME g_xmfb_d[l_ac].xmfb003
                     CALL axmi410_xmfb003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmi410_xmfb003_ref()
          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb003
            #add-point:BEFORE FIELD xmfb003 name="input.b.page1.xmfb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfb003
            #add-point:ON CHANGE xmfb003 name="input.g.page1.xmfb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb004
            #add-point:BEFORE FIELD xmfb004 name="input.b.page1.xmfb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb004
            
            #add-point:AFTER FIELD xmfb004 name="input.a.page1.xmfb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfb004
            #add-point:ON CHANGE xmfb004 name="input.g.page1.xmfb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfb_d[l_ac].xmfb005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmfb005
            END IF 
 
 
 
            #add-point:AFTER FIELD xmfb005 name="input.a.page1.xmfb005"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb005
            #add-point:BEFORE FIELD xmfb005 name="input.b.page1.xmfb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfb005
            #add-point:ON CHANGE xmfb005 name="input.g.page1.xmfb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfb_d[l_ac].xmfb006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmfb006
            END IF 
 
 
 
            #add-point:AFTER FIELD xmfb006 name="input.a.page1.xmfb006"
            IF NOT cl_null(g_xmfb_d[l_ac].xmfb006) THEN 
               IF g_xmfb_d[l_ac].xmfb006 <= g_xmfb_d[l_ac].xmfb005 THEN
                  LET ls_replace_arg =  '>','|', g_xmfb_d[l_ac].xmfb006
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axm-00319"
                  LET g_errparam.extend = g_xmfb_d[l_ac].xmfb006
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = ls_replace_arg
                  CALL cl_err()

                  LET g_xmfb_d[l_ac].xmfb006 = g_xmfb_d_t.xmfb006
                  DISPLAY BY NAME g_xmfb_d[l_ac].xmfb006
                  NEXT FIELD CURRENT
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfb006
            #add-point:BEFORE FIELD xmfb006 name="input.b.page1.xmfb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfb006
            #add-point:ON CHANGE xmfb006 name="input.g.page1.xmfb006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmfbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfbsite
            #add-point:ON ACTION controlp INFIELD xmfbsite name="input.c.page1.xmfbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb002
            #add-point:ON ACTION controlp INFIELD xmfb002 name="input.c.page1.xmfb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb003
            #add-point:ON ACTION controlp INFIELD xmfb003 name="input.c.page1.xmfb003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmfb_d[l_ac].xmfb003             #給予default值

             #給予arg
            LET g_qryparam.arg1 = '803'

            
            CALL q_oocq002_5()                                #呼叫開窗

            LET g_xmfb_d[l_ac].xmfb003 = g_qryparam.return1              

            DISPLAY g_xmfb_d[l_ac].xmfb003 TO xmfb003              
            CALL axmi410_xmfb003_ref()
            NEXT FIELD xmfb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb004
            #add-point:ON ACTION controlp INFIELD xmfb004 name="input.c.page1.xmfb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb005
            #add-point:ON ACTION controlp INFIELD xmfb005 name="input.c.page1.xmfb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfb006
            #add-point:ON ACTION controlp INFIELD xmfb006 name="input.c.page1.xmfb006"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmfb_d[l_ac].* = g_xmfb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmi410_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xmfb_d[l_ac].xmfb002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xmfb_d[l_ac].* = g_xmfb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axmi410_xmfb_t_mask_restore('restore_mask_o')
      
               UPDATE xmfb_t SET (xmfbdocno,xmfb001,xmfbsite,xmfb002,xmfb003,xmfb004,xmfb005,xmfb006) = (g_xmfa_m.xmfadocno, 
                   g_xmfa_m.xmfa001,g_xmfb_d[l_ac].xmfbsite,g_xmfb_d[l_ac].xmfb002,g_xmfb_d[l_ac].xmfb003, 
                   g_xmfb_d[l_ac].xmfb004,g_xmfb_d[l_ac].xmfb005,g_xmfb_d[l_ac].xmfb006)
                WHERE xmfbent = g_enterprise AND xmfbdocno = g_xmfa_m.xmfadocno 
                  AND xmfb001 = g_xmfa_m.xmfa001 
 
                  AND xmfb002 = g_xmfb_d_t.xmfb002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfb_d[l_ac].* = g_xmfb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfb_d[l_ac].* = g_xmfb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfa_m.xmfadocno
               LET gs_keys_bak[1] = g_xmfadocno_t
               LET gs_keys[2] = g_xmfa_m.xmfa001
               LET gs_keys_bak[2] = g_xmfa001_t
               LET gs_keys[3] = g_xmfb_d[g_detail_idx].xmfb002
               LET gs_keys_bak[3] = g_xmfb_d_t.xmfb002
               CALL axmi410_update_b('xmfb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axmi410_xmfb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xmfb_d[g_detail_idx].xmfb002 = g_xmfb_d_t.xmfb002 
 
                  ) THEN
                  LET gs_keys[01] = g_xmfa_m.xmfadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfa_m.xmfa001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfb_d_t.xmfb002
 
                  CALL axmi410_key_update_b(gs_keys,'xmfb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfa_m),util.JSON.stringify(g_xmfb_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfa_m),util.JSON.stringify(g_xmfb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axmi410_unlock_b("xmfb_t","'1'")
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
               LET g_xmfb_d[li_reproduce_target].* = g_xmfb_d[li_reproduce].*
 
               LET g_xmfb_d[li_reproduce_target].xmfb002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_xmfb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_xmfb_d.getLength() = 0 THEN
               NEXT FIELD xmfb002
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_xmfb_d[g_detail_idx].xmfb002) THEN
               NEXT FIELD xmfb002
            END IF
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfb2_d[l_ac].* TO NULL 
            INITIALIZE g_xmfb2_d_t.* TO NULL 
            INITIALIZE g_xmfb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_xmfb2_d[l_ac].xmfc006 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            #項次=最大值+1
            IF cl_null(g_xmfb2_d[l_ac].xmfc003) THEN 
               SELECT MAX(xmfc003) INTO g_xmfb2_d[l_ac].xmfc003
                 FROM xmfc_t
                WHERE xmfcent = g_enterprise 
                  AND xmfcdocno = g_xmfa_m.xmfadocno 
                  AND xmfc001 = g_xmfa_m.xmfa001  
                  AND xmfc002 = g_xmfb_d[g_detail_idx].xmfb002  
               IF cl_null(g_xmfb2_d[l_ac].xmfc003) THEN 
                  LET g_xmfb2_d[l_ac].xmfc003 = 1
               ELSE      
                  LET g_xmfb2_d[l_ac].xmfc003 = g_xmfb2_d[l_ac].xmfc003 + 1
               END IF           
            END IF 
            #end add-point
            LET g_xmfb2_d_t.* = g_xmfb2_d[l_ac].*     #新輸入資料
            LET g_xmfb2_d_o.* = g_xmfb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmi410_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axmi410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfb2_d[li_reproduce_target].* = g_xmfb2_d[li_reproduce].*
 
               LET g_xmfb2_d[li_reproduce_target].xmfc003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
 
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[2] = l_ac
            LET g_current_page = 2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axmi410_cl USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmi410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE axmi410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN axmi410_bcl USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfb_d[g_detail_idx].xmfb002 
 
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmi410_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmi410_cl
               CLOSE axmi410_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfb2_d[l_ac].xmfc003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfb2_d_t.* = g_xmfb2_d[l_ac].*  #BACKUP
               LET g_xmfb2_d_o.* = g_xmfb2_d[l_ac].*  #BACKUP
               CALL axmi410_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL axmi410_set_no_entry_b(l_cmd)
               IF NOT axmi410_lock_b("xmfc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmi410_bcl2 INTO g_xmfb2_d[l_ac].xmfcsite,g_xmfb2_d[l_ac].xmfc003,g_xmfb2_d[l_ac].xmfc004, 
                      g_xmfb2_d[l_ac].xmfc005,g_xmfb2_d[l_ac].xmfc006,g_xmfb2_d[l_ac].xmfc007,g_xmfb2_d[l_ac].xmfc008 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfb2_d_mask_o[l_ac].* =  g_xmfb2_d[l_ac].*
                  CALL axmi410_xmfc_t_mask()
                  LET g_xmfb2_d_mask_n[l_ac].* =  g_xmfb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmi410_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfa_m.xmfadocno
               LET gs_keys[2] = g_xmfa_m.xmfa001
               LET gs_keys[3] = g_xmfb_d[g_detail_idx].xmfb002
               LET gs_keys[4] = g_xmfb2_d_t.xmfc003
 
 
               #刪除同層單身
               IF NOT axmi410_delete_b('xmfc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmi410_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE axmi410_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
 
               LET l_count = g_xmfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfb2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xmfc_t 
             WHERE xmfcent = g_enterprise AND xmfcdocno = g_xmfa_m.xmfadocno AND xmfc001 = g_xmfa_m.xmfa001  
                 AND xmfc002 = g_xmfb_d[g_detail_idx].xmfb002 AND xmfc003 = g_xmfb2_d[g_detail_idx2].xmfc003 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfa_m.xmfadocno
               LET gs_keys[2] = g_xmfa_m.xmfa001
               LET gs_keys[3] = g_xmfb_d[g_detail_idx].xmfb002
               LET gs_keys[4] = g_xmfb2_d[g_detail_idx2].xmfc003
               CALL axmi410_insert_b('xmfc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmfb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmi410_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               #產品特徵開窗後CALL axmi410_feature() 
               CALL s_transaction_end('Y','0')
               CALL s_transaction_begin()
               IF l_success1 AND g_inam.getLength() > 1 THEN
                  CALL axmi410_feature() RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL axmi410_b_fill2('2')
                  LET g_rec_b = g_inam.getLength() - 1
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
            #還原g_detail_idx
            LET g_detail_idx = g_detail_idx_tmp
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmfb2_d[l_ac].* = g_xmfb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmi410_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xmfb2_d[l_ac].* = g_xmfb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axmi410_xmfc_t_mask_restore('restore_mask_o')
               
               UPDATE xmfc_t SET (xmfcdocno,xmfc001,xmfc002,xmfcsite,xmfc003,xmfc004,xmfc005,xmfc006, 
                   xmfc007,xmfc008) = (g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfb_d[g_detail_idx].xmfb002, 
                   g_xmfb2_d[l_ac].xmfcsite,g_xmfb2_d[l_ac].xmfc003,g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005, 
                   g_xmfb2_d[l_ac].xmfc006,g_xmfb2_d[l_ac].xmfc007,g_xmfb2_d[l_ac].xmfc008) #自訂欄位頁簽 
 
                WHERE xmfcent = g_enterprise AND xmfcdocno = g_xmfadocno_t AND xmfc001 = g_xmfa001_t  
                    AND xmfc002 = g_xmfb_d[g_detail_idx].xmfb002 AND xmfc003 = g_xmfb2_d_t.xmfc003
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfb2_d[l_ac].* = g_xmfb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfb2_d[l_ac].* = g_xmfb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfa_m.xmfadocno
               LET gs_keys_bak[1] = g_xmfadocno_t
               LET gs_keys[2] = g_xmfa_m.xmfa001
               LET gs_keys_bak[2] = g_xmfa001_t
               LET gs_keys[3] = g_xmfb_d[g_detail_idx].xmfb002
               LET gs_keys_bak[3] = g_xmfb_d[g_detail_idx].xmfb002
               LET gs_keys[4] = g_xmfb2_d[g_detail_idx2].xmfc003
               LET gs_keys_bak[4] = g_xmfb2_d_t.xmfc003
               CALL axmi410_update_b('xmfc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmi410_xmfc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfa_m),util.JSON.stringify(g_xmfb2_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfa_m),util.JSON.stringify(g_xmfb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfcsite
            #add-point:BEFORE FIELD xmfcsite name="input.b.page2.xmfcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfcsite
            
            #add-point:AFTER FIELD xmfcsite name="input.a.page2.xmfcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfcsite
            #add-point:ON CHANGE xmfcsite name="input.g.page2.xmfcsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfb2_d[l_ac].xmfc003,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmfc003
            END IF 
 
 
 
            #add-point:AFTER FIELD xmfc003 name="input.a.page2.xmfc003"
            #此段落由子樣板a05產生
            IF  g_xmfa_m.xmfadocno IS NOT NULL AND g_xmfa_m.xmfa001 IS NOT NULL AND g_xmfb_d[g_detail_idx].xmfb002 IS NOT NULL AND g_xmfb2_d[g_detail_idx2].xmfc003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfa_m.xmfadocno != g_xmfadocno_t OR g_xmfa_m.xmfa001 != g_xmfa001_t OR g_xmfb_d[g_detail_idx].xmfb002 != g_xmfb_d[g_detail_idx].xmfb002 OR g_xmfb2_d[g_detail_idx2].xmfc003 != g_xmfb2_d_t.xmfc003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfc_t WHERE "||"xmfcent = '" ||g_enterprise|| "' AND "||"xmfcdocno = '"||g_xmfa_m.xmfadocno ||"' AND "|| "xmfc001 = '"||g_xmfa_m.xmfa001 ||"' AND "|| "xmfc002 = '"||g_xmfb_d[g_detail_idx].xmfb002 ||"' AND "|| "xmfc003 = '"||g_xmfb2_d[g_detail_idx2].xmfc003 ||"'",'std-00004',0) THEN 
                     LET g_xmfb2_d[g_detail_idx2].xmfc003 = g_xmfb2_d_t.xmfc003
                     DISPLAY BY NAME g_xmfb2_d[g_detail_idx2].xmfc003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc003
            #add-point:BEFORE FIELD xmfc003 name="input.b.page2.xmfc003"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfc003
            #add-point:ON CHANGE xmfc003 name="input.g.page2.xmfc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc004
            
            #add-point:AFTER FIELD xmfc004 name="input.a.page2.xmfc004"
            LET g_xmfb2_d[l_ac].xmfc004_desc = ''
            LET g_xmfb2_d[l_ac].xmfc004_desc_desc = ''
            DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc004_desc
            DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc004_desc_desc
            IF NOT cl_null(g_xmfb2_d[l_ac].xmfc004) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfb2_d[l_ac].xmfc004 != g_xmfb2_d_t.xmfc004 OR g_xmfb2_d_t.xmfc004 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmfb2_d[l_ac].xmfc004
                  IF NOT cl_chk_exist("v_imaf001_14") THEN
                     LET g_xmfb2_d[l_ac].xmfc004 = g_xmfb2_d_t.xmfc004
                     DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc004
                     CALL axmi410_xmfc004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmi410_xmfc004_ref()

            #預設[T:料件據點進銷存檔]設置的銷售單位
            #先判斷單位是否有值，沒值才給預設
            IF cl_null(g_xmfb2_d[l_ac].xmfc007) THEN
               SELECT imaf112 INTO g_xmfb2_d[l_ac].xmfc007
                 FROM imaf_t
                WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_xmfb2_d[l_ac].xmfc004
            END IF
            #當料件有使用產品特徵功能時此欄位才可輸入
            CALL axmi410_set_entry_b(l_cmd)
            CALL axmi410_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc004
            #add-point:BEFORE FIELD xmfc004 name="input.b.page2.xmfc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfc004
            #add-point:ON CHANGE xmfc004 name="input.g.page2.xmfc004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc005
            
            #add-point:AFTER FIELD xmfc005 name="input.a.page2.xmfc005"
            LET g_xmfb2_d[l_ac].xmfc005_desc = ''
            IF NOT cl_null(g_xmfb2_d[l_ac].xmfc005) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfb2_d[l_ac].xmfc005 != g_xmfb2_d_t.xmfc005 OR g_xmfb2_d_t.xmfc005 IS NULL )) THEN
                  IF NOT s_feature_check(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005) THEN
                     LET g_xmfb2_d[l_ac].xmfc005 = g_xmfb2_d_t.xmfc005
                     CALL s_feature_description(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005) RETURNING l_success,g_xmfb2_d[l_ac].xmfc005_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#2--add--start--
                  IF NOT s_feature_direct_input(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005,g_xmfb2_d_t.xmfc005,g_xmfa_m.xmfadocno,g_xmfa_m.xmfasite) THEN
                     NEXT FIELD CURRENT
                  END IF 
                  #151224-00025#2--add--end----
               END IF
            END IF
            CALL s_feature_description(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005) RETURNING l_success,g_xmfb2_d[l_ac].xmfc005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc005
            #add-point:BEFORE FIELD xmfc005 name="input.b.page2.xmfc005"
            IF l_cmd = 'a' AND NOT cl_null(g_xmfb2_d[l_ac].xmfc004) THEN
               CALL s_feature('a',g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005,g_xmfb2_d[l_ac].xmfc006,
                              g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno)
                    RETURNING l_success1,g_inam
               LET g_xmfb2_d[l_ac].xmfc005 = g_inam[1].inam002
               LET g_xmfb2_d[l_ac].xmfc006 = g_inam[1].inam004
               DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc005,g_xmfb2_d[l_ac].xmfc006
               CALL s_feature_description(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005) RETURNING l_success,g_xmfb2_d[l_ac].xmfc005_desc
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfc005
            #add-point:ON CHANGE xmfc005 name="input.g.page2.xmfc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfb2_d[l_ac].xmfc006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmfc006
            END IF 
 
 
 
            #add-point:AFTER FIELD xmfc006 name="input.a.page2.xmfc006"
            IF NOT cl_null(g_xmfb2_d[l_ac].xmfc006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc006
            #add-point:BEFORE FIELD xmfc006 name="input.b.page2.xmfc006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfc006
            #add-point:ON CHANGE xmfc006 name="input.g.page2.xmfc006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc007
            
            #add-point:AFTER FIELD xmfc007 name="input.a.page2.xmfc007"
            LET g_xmfb2_d[l_ac].xmfc007_desc = ''
            DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc007_desc
            IF NOT cl_null(g_xmfb2_d[l_ac].xmfc007) THEN
               IF p_cmd = 'a' OR p_cmd = 'u' THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmfb2_d[l_ac].xmfc004
                  LET g_chkparam.arg2 = g_xmfb2_d[l_ac].xmfc007
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_xmfb2_d[l_ac].xmfc007 = g_xmfb2_d_t.xmfc007
                     DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc007
                     CALL axmi410_xmfc007_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmi410_xmfc007_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc007
            #add-point:BEFORE FIELD xmfc007 name="input.b.page2.xmfc007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfc007
            #add-point:ON CHANGE xmfc007 name="input.g.page2.xmfc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfc008
            #add-point:BEFORE FIELD xmfc008 name="input.b.page2.xmfc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfc008
            
            #add-point:AFTER FIELD xmfc008 name="input.a.page2.xmfc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfc008
            #add-point:ON CHANGE xmfc008 name="input.g.page2.xmfc008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xmfcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfcsite
            #add-point:ON ACTION controlp INFIELD xmfcsite name="input.c.page2.xmfcsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc003
            #add-point:ON ACTION controlp INFIELD xmfc003 name="input.c.page2.xmfc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc004
            #add-point:ON ACTION controlp INFIELD xmfc004 name="input.c.page2.xmfc004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmfb2_d[l_ac].xmfc004             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001_15()                                #呼叫開窗

            LET g_xmfb2_d[l_ac].xmfc004 = g_qryparam.return1    
            DISPLAY g_xmfb2_d[l_ac].xmfc004 TO xmfc004   
            CALL axmi410_xmfc004_ref()            
            NEXT FIELD xmfc004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc005
            #add-point:ON ACTION controlp INFIELD xmfc005 name="input.c.page2.xmfc005"
            IF l_cmd = 'u' THEN
               CALL s_feature_single(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005,g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno)
                  RETURNING l_success1,g_xmfb2_d[l_ac].xmfc005
               IF NOT l_success1 THEN
                  LET g_xmfb2_d[l_ac].xmfc005 = g_xmfb2_d_t.xmfc005
                  DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc005
               END IF
               CALL s_feature_description(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005) RETURNING l_success,g_xmfb2_d[l_ac].xmfc005_desc
            END IF
            NEXT FIELD xmfc005
            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc006
            #add-point:ON ACTION controlp INFIELD xmfc006 name="input.c.page2.xmfc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc007
            #add-point:ON ACTION controlp INFIELD xmfc007 name="input.c.page2.xmfc007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfb2_d[l_ac].xmfc007             #給予default值
             #給予arg
            LET g_qryparam.arg1 = g_xmfb2_d[l_ac].xmfc004 
            CALL q_imao002()                                #呼叫開窗
            LET g_xmfb2_d[l_ac].xmfc007 = g_qryparam.return1              
            DISPLAY g_xmfb2_d[l_ac].xmfc007 TO xmfc007              #
            CALL axmi410_xmfc007_ref()
            NEXT FIELD xmfc007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfc008
            #add-point:ON ACTION controlp INFIELD xmfc008 name="input.c.page2.xmfc008"
            #此段落由子樣板a07產生            
            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = g_xmfb2_d[l_ac].xmfc008             #給予default值
#            #給予arg
#            LET g_qryparam.arg1 = g_xmfa_m.xmfadocno
#            LET g_qryparam.arg2 = g_xmfa_m.xmfa001
#            CALL q_xmfb003()                             #呼叫開窗
#            #抓取單身一的分類資料，可多選，使用「,」區隔
#            LET g_qryparam.return1 = cl_replace_str(g_qryparam.return1,'|',',')
#            LET g_xmfb2_d[l_ac].xmfc008 = g_qryparam.return1              
#            DISPLAY g_xmfb2_d[l_ac].xmfc008 TO xmfc008              #
#            NEXT FIELD xmfc008                          #返回原欄位
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfb2_d[l_ac].* = g_xmfb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmi410_bcl2
               CLOSE axmi410_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmi410_unlock_b("xmfc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2_after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfb2_d[li_reproduce_target].* = g_xmfb2_d[li_reproduce].*
 
               LET g_xmfb2_d[li_reproduce_target].xmfc003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfb2_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="axmi410.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xmfadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xmfbsite
               WHEN "s_detail2"
                  NEXT FIELD xmfcsite
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axmi410_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axmi410_b_fill() #單身填充
      CALL axmi410_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmi410_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

   CALL axmi410_xmfadocno_ref()

   #end add-point
   
   #遮罩相關處理
   LET g_xmfa_m_mask_o.* =  g_xmfa_m.*
   CALL axmi410_xmfa_t_mask()
   LET g_xmfa_m_mask_n.* =  g_xmfa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfal003,g_xmfa_m.xmfal004,g_xmfa_m.xmfa001, 
       g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaownid_desc,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfaowndp_desc, 
       g_xmfa_m.xmfacrtid,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfacrtdt, 
       g_xmfa_m.xmfamodid,g_xmfa_m.xmfamodid_desc,g_xmfa_m.xmfamoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmfa_m.xmfastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xmfb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xmfb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      CALL s_feature_description(g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005) RETURNING l_success,g_xmfb2_d[l_ac].xmfc005_desc
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axmi410_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axmi410_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_ac_t    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   LET l_ac_t = l_ac
   
   FOR l_ac = 1 TO g_xmfb2_d.getLength()
     
     CALL axmi410_xmfc004_ref()

   END FOR
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   LET l_ac = l_ac_t
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmi410_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xmfa_t.xmfadocno 
   DEFINE l_oldno     LIKE xmfa_t.xmfadocno 
   DEFINE l_newno02     LIKE xmfa_t.xmfa001 
   DEFINE l_oldno02     LIKE xmfa_t.xmfa001 
 
   DEFINE l_master    RECORD LIKE xmfa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xmfb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE xmfc_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_xmfa_m.xmfadocno IS NULL
   OR g_xmfa_m.xmfa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xmfadocno_t = g_xmfa_m.xmfadocno
   LET g_xmfa001_t = g_xmfa_m.xmfa001
 
    
   LET g_xmfa_m.xmfadocno = ""
   LET g_xmfa_m.xmfa001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmfa_m.xmfaownid = g_user
      LET g_xmfa_m.xmfaowndp = g_dept
      LET g_xmfa_m.xmfacrtid = g_user
      LET g_xmfa_m.xmfacrtdp = g_dept 
      LET g_xmfa_m.xmfacrtdt = cl_get_current()
      LET g_xmfa_m.xmfamodid = g_user
      LET g_xmfa_m.xmfamoddt = cl_get_current()
      LET g_xmfa_m.xmfastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_xmfa_m.xmfastus = 'Y'
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmfa_m.xmfastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL axmi410_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xmfa_m.* TO NULL
      INITIALIZE g_xmfb_d TO NULL
      INITIALIZE g_xmfb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axmi410_show()
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
   CALL axmi410_set_act_visible()   
   CALL axmi410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmfadocno_t = g_xmfa_m.xmfadocno
   LET g_xmfa001_t = g_xmfa_m.xmfa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmfaent = " ||g_enterprise|| " AND",
                      " xmfadocno = '", g_xmfa_m.xmfadocno, "' "
                      ," AND xmfa001 = '", g_xmfa_m.xmfa001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmi410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axmi410_idx_chk()
   
   LET g_data_owner = g_xmfa_m.xmfaownid      
   LET g_data_dept  = g_xmfa_m.xmfaowndp
   
   #功能已完成,通報訊息中心
   CALL axmi410_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axmi410_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xmfb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE xmfc_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axmi410_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfb_t
    WHERE xmfbent = g_enterprise AND xmfbdocno = g_xmfadocno_t
     AND xmfb001 = g_xmfa001_t
 
    INTO TEMP axmi410_detail
 
   #將key修正為調整後   
   UPDATE axmi410_detail 
      #更新key欄位
      SET xmfbdocno = g_xmfa_m.xmfadocno
          , xmfb001 = g_xmfa_m.xmfa001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xmfb_t SELECT * FROM axmi410_detail
   
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
   DROP TABLE axmi410_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfc_t 
    WHERE xmfcent = g_enterprise AND xmfcdocno = g_xmfadocno_t
    AND xmfc001 = g_xmfa001_t   
 
    INTO TEMP axmi410_detail
 
   #將key修正為調整後   
   UPDATE axmi410_detail SET xmfcdocno = g_xmfa_m.xmfadocno
                                       , xmfc001 = g_xmfa_m.xmfa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO xmfc_t SELECT * FROM axmi410_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmi410_detail
   
   LET g_data_owner = g_xmfa_m.xmfaownid      
   LET g_data_dept  = g_xmfa_m.xmfaowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xmfadocno_t = g_xmfa_m.xmfadocno
   LET g_xmfa001_t = g_xmfa_m.xmfa001
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmi410_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_multi_cnt     LIKE type_t.num5 
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xmfa_m.xmfadocno IS NULL
   OR g_xmfa_m.xmfa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.xmfaldocno = g_xmfa_m.xmfadocno
LET g_master_multi_table_t.xmfal003 = g_xmfa_m.xmfal003
LET g_master_multi_table_t.xmfal004 = g_xmfa_m.xmfal004
 
   
   CALL s_transaction_begin()
 
   OPEN axmi410_cl USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmi410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmi410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmi410_master_referesh USING g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfa_m.xmfasite, 
       g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid, 
       g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt,g_xmfa_m.xmfaownid_desc, 
       g_xmfa_m.xmfaowndp_desc,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfamodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT axmi410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmfa_m_mask_o.* =  g_xmfa_m.*
   CALL axmi410_xmfa_t_mask()
   LET g_xmfa_m_mask_n.* =  g_xmfa_m.*
   
   CALL axmi410_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmi410_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xmfadocno_t = g_xmfa_m.xmfadocno
      LET g_xmfa001_t = g_xmfa_m.xmfa001
 
 
      DELETE FROM xmfa_t
       WHERE xmfaent = g_enterprise AND xmfadocno = g_xmfa_m.xmfadocno
         AND xmfa001 = g_xmfa_m.xmfa001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmfa_m.xmfadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM xmfb_t
       WHERE xmfbent = g_enterprise AND xmfbdocno = g_xmfa_m.xmfadocno
         AND xmfb001 = g_xmfa_m.xmfa001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM xmfc_t
       WHERE xmfcent = g_enterprise AND
             xmfcdocno = g_xmfa_m.xmfadocno AND xmfc001 = g_xmfa_m.xmfa001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xmfa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axmi410_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xmfb_d.clear() 
      CALL g_xmfb2_d.clear()       
 
     
      CALL axmi410_ui_browser_refresh()  
      #CALL axmi410_ui_headershow()  
      #CALL axmi410_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      SELECT COUNT(xmfadocno) INTO l_multi_cnt
        FROM xmfa_t
       WHERE xmfaent = g_enterprise
         AND xmfadocno = g_master_multi_table_t.xmfaldocno

      IF (l_multi_cnt + 1) > 1 THEN
         CALL s_transaction_end('Y','0')   
         CLOSE axmi410_cl
         RETURN
      END IF
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'xmfalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.xmfaldocno
   LET l_field_keys[02] = 'xmfaldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xmfal_t')
 
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axmi410_browser_fill("")
         CALL axmi410_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axmi410_cl
 
   #功能已完成,通報訊息中心
   CALL axmi410_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axmi410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmi410_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xmfb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axmi410_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmfbsite,xmfb002,xmfb003,xmfb004,xmfb005,xmfb006 ,t1.oocql004 FROM xmfb_t", 
                
                     " INNER JOIN xmfa_t ON xmfaent = " ||g_enterprise|| " AND xmfadocno = xmfbdocno ",
                     " AND xmfa001 = xmfb001 ",
 
                     #"",
                     " LEFT JOIN xmfc_t ON xmfbent = xmfcent AND xmfbdocno = xmfcdocno AND xmfb001 = xmfc001 AND xmfb002 = xmfc002 ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='803' AND t1.oocql002=xmfb003 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE xmfbent=? AND xmfbdocno=? AND xmfb001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY xmfb_t.xmfb002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmi410_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axmi410_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfb_d[l_ac].xmfbsite, 
          g_xmfb_d[l_ac].xmfb002,g_xmfb_d[l_ac].xmfb003,g_xmfb_d[l_ac].xmfb004,g_xmfb_d[l_ac].xmfb005, 
          g_xmfb_d[l_ac].xmfb006,g_xmfb_d[l_ac].xmfb003_desc   #(ver:78)
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
   
   CALL g_xmfb_d.deleteElement(g_xmfb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axmi410_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmfb_d.getLength()
      LET g_xmfb_d_mask_o[l_ac].* =  g_xmfb_d[l_ac].*
      CALL axmi410_xmfb_t_mask()
      LET g_xmfb_d_mask_n[l_ac].* =  g_xmfb_d[l_ac].*
   END FOR
   
   LET g_xmfb2_d_mask_o.* =  g_xmfb2_d.*
   FOR l_ac = 1 TO g_xmfb2_d.getLength()
      LET g_xmfb2_d_mask_o[l_ac].* =  g_xmfb2_d[l_ac].*
      CALL axmi410_xmfc_t_mask()
      LET g_xmfb2_d_mask_n[l_ac].* =  g_xmfb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmi410_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xmfb_t
       WHERE xmfbent = g_enterprise AND
         xmfbdocno = ps_keys_bak[1] AND xmfb001 = ps_keys_bak[2] AND xmfb002 = ps_keys_bak[3]
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
         CALL g_xmfb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xmfc_t
       WHERE xmfcent = g_enterprise AND
             xmfcdocno = ps_keys_bak[1] AND xmfc001 = ps_keys_bak[2] AND xmfc002 = ps_keys_bak[3] AND xmfc003 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_xmfb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmi410_insert_b(ps_table,ps_keys,ps_page)
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
      LET g_xmfb_d[g_detail_idx].xmfbsite = g_site
      #end add-point 
      INSERT INTO xmfb_t
                  (xmfbent,
                   xmfbdocno,xmfb001,
                   xmfb002
                   ,xmfbsite,xmfb003,xmfb004,xmfb005,xmfb006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xmfb_d[g_detail_idx].xmfbsite,g_xmfb_d[g_detail_idx].xmfb003,g_xmfb_d[g_detail_idx].xmfb004, 
                       g_xmfb_d[g_detail_idx].xmfb005,g_xmfb_d[g_detail_idx].xmfb006)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xmfb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      LET g_xmfb2_d[g_detail_idx2].xmfcsite = g_site
      #end add-point 
      INSERT INTO xmfc_t
                  (xmfcent,
                   xmfcdocno,xmfc001,xmfc002,
                   xmfc003
                   ,xmfcsite,xmfc004,xmfc005,xmfc006,xmfc007,xmfc008) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_xmfb2_d[g_detail_idx2].xmfcsite,g_xmfb2_d[g_detail_idx2].xmfc004,g_xmfb2_d[g_detail_idx2].xmfc005, 
                       g_xmfb2_d[g_detail_idx2].xmfc006,g_xmfb2_d[g_detail_idx2].xmfc007,g_xmfb2_d[g_detail_idx2].xmfc008) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_xmfb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmi410_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axmi410_xmfb_t_mask_restore('restore_mask_o')
               
      UPDATE xmfb_t 
         SET (xmfbdocno,xmfb001,
              xmfb002
              ,xmfbsite,xmfb003,xmfb004,xmfb005,xmfb006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xmfb_d[g_detail_idx].xmfbsite,g_xmfb_d[g_detail_idx].xmfb003,g_xmfb_d[g_detail_idx].xmfb004, 
                  g_xmfb_d[g_detail_idx].xmfb005,g_xmfb_d[g_detail_idx].xmfb006) 
         WHERE xmfbent = g_enterprise AND xmfbdocno = ps_keys_bak[1] AND xmfb001 = ps_keys_bak[2] AND xmfb002 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmi410_xmfb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL axmi410_xmfc_t_mask_restore('restore_mask_o')
               
      UPDATE xmfc_t 
         SET (xmfcdocno,xmfc001,xmfc002,
              xmfc003
              ,xmfcsite,xmfc004,xmfc005,xmfc006,xmfc007,xmfc008) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_xmfb2_d[g_detail_idx2].xmfcsite,g_xmfb2_d[g_detail_idx2].xmfc004,g_xmfb2_d[g_detail_idx2].xmfc005, 
                  g_xmfb2_d[g_detail_idx2].xmfc006,g_xmfb2_d[g_detail_idx2].xmfc007,g_xmfb2_d[g_detail_idx2].xmfc008)  
 
         WHERE xmfcent = g_enterprise AND xmfcdocno = ps_keys_bak[1] AND xmfc001 = ps_keys_bak[2] AND xmfc002 = ps_keys_bak[3] AND xmfc003 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmi410_xmfc_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axmi410_key_update_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行update
   IF ps_table = 'xmfb_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE xmfc_t 
         SET (xmfcdocno,xmfc001,xmfc002) 
              = 
             (g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfb_d[g_detail_idx].xmfb002) 
         WHERE xmfcent = g_enterprise AND
               xmfcdocno = ps_keys_bak[1] AND xmfc001 = ps_keys_bak[2] AND xmfc002 = ps_keys_bak[3]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axmi410_key_delete_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行delete
   IF ps_table = 'xmfb_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM xmfc_t 
            WHERE xmfcent = g_enterprise AND
                  xmfcdocno = ps_keys_bak[1] AND xmfc001 = ps_keys_bak[2] AND xmfc002 = ps_keys_bak[3]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmi410_lock_b(ps_table,ps_page)
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
   #CALL axmi410_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xmfb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axmi410_bcl USING g_enterprise,
                                       g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfb_d[g_detail_idx].xmfb002  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmi410_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xmfc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmi410_bcl2 USING g_enterprise,
                                             g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfb_d[g_detail_idx].xmfb002, 
 
                                             g_xmfb2_d[g_detail_idx2].xmfc003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmi410_bcl2:",SQLERRMESSAGE 
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
 
{<section id="axmi410.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmi410_unlock_b(ps_table,ps_page)
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
      CLOSE axmi410_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmi410_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmi410_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xmfadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xmfadocno,xmfa001",TRUE)
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
 
{<section id="axmi410.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmi410_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmfadocno,xmfa001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xmfadocno",FALSE)
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
 
{<section id="axmi410.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmi410_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("xmfc005",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axmi410.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmi410_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_xmfc005  LIKE xmfc_t.xmfc005
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF NOT cl_null(g_detail_idx2) AND g_xmfb2_d.getLength() > 0 THEN
      LET l_xmfc005 = ''
      SELECT imaa005 INTO l_xmfc005
        FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 = g_xmfb2_d[g_detail_idx2].xmfc004
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = "N" THEN
         LET g_xmfb2_d[l_ac].xmfc005 = ''
         CALL cl_set_comp_entry("xmfc005",FALSE)
      ELSE
         IF cl_null(l_xmfc005) THEN
            LET g_xmfb2_d[l_ac].xmfc005 = ''
            CALL cl_set_comp_entry("xmfc005",FALSE)
         END IF
      END IF
   END IF
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axmi410.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmi410_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmi410_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axmi410_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axmi410_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmi410_default_search()
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
      LET ls_wc = ls_wc, " xmfadocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmfa001 = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xmfa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmfb_t" 
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
 
{<section id="axmi410.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axmi410_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xmfa_m.xmfadocno IS NULL
      OR g_xmfa_m.xmfa001 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axmi410_cl USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001
   IF STATUS THEN
      CLOSE axmi410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmi410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axmi410_master_referesh USING g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfa_m.xmfasite, 
       g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfacrtid, 
       g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt,g_xmfa_m.xmfaownid_desc, 
       g_xmfa_m.xmfaowndp_desc,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfamodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT axmi410_action_chk() THEN
      CLOSE axmi410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfal003,g_xmfa_m.xmfal004,g_xmfa_m.xmfa001, 
       g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaownid_desc,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfaowndp_desc, 
       g_xmfa_m.xmfacrtid,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfacrtdt, 
       g_xmfa_m.xmfamodid,g_xmfa_m.xmfamodid_desc,g_xmfa_m.xmfamoddt
 
   CASE g_xmfa_m.xmfastus
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
         CASE g_xmfa_m.xmfastus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #校驗:範本料號+版本只能存在一筆有效資料
      IF NOT cl_null(g_xmfa_m.xmfadocno) AND NOT cl_null(g_xmfa_m.xmfa001) THEN 
         IF g_xmfa_m.xmfastus = "N" THEN 
            IF NOT axmi410_xmfa001_chk() THEN
               #檢查失敗時後續處理
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN
            END IF
         END IF
      END IF
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
      g_xmfa_m.xmfastus = lc_state OR cl_null(lc_state) THEN
      CLOSE axmi410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_xmfa_m.xmfamodid = g_user
   LET g_xmfa_m.xmfamoddt = cl_get_current()
   LET g_xmfa_m.xmfastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xmfa_t 
      SET (xmfastus,xmfamodid,xmfamoddt) 
        = (g_xmfa_m.xmfastus,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt)     
    WHERE xmfaent = g_enterprise AND xmfadocno = g_xmfa_m.xmfadocno
      AND xmfa001 = g_xmfa_m.xmfa001
    
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
      EXECUTE axmi410_master_referesh USING g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001 INTO g_xmfa_m.xmfasite, 
          g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaowndp, 
          g_xmfa_m.xmfacrtid,g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdt,g_xmfa_m.xmfamodid,g_xmfa_m.xmfamoddt, 
          g_xmfa_m.xmfaownid_desc,g_xmfa_m.xmfaowndp_desc,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp_desc, 
          g_xmfa_m.xmfamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xmfa_m.xmfasite,g_xmfa_m.xmfadocno,g_xmfa_m.xmfal003,g_xmfa_m.xmfal004,g_xmfa_m.xmfa001, 
          g_xmfa_m.xmfastus,g_xmfa_m.xmfaownid,g_xmfa_m.xmfaownid_desc,g_xmfa_m.xmfaowndp,g_xmfa_m.xmfaowndp_desc, 
          g_xmfa_m.xmfacrtid,g_xmfa_m.xmfacrtid_desc,g_xmfa_m.xmfacrtdp,g_xmfa_m.xmfacrtdp_desc,g_xmfa_m.xmfacrtdt, 
          g_xmfa_m.xmfamodid,g_xmfa_m.xmfamodid_desc,g_xmfa_m.xmfamoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axmi410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmi410_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi410.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axmi410_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xmfb_d.getLength() THEN
         LET g_detail_idx = g_xmfb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_xmfb2_d.getLength() THEN
         LET g_detail_idx2 = g_xmfb2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_xmfb2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_xmfb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmi410_b_fill2(pi_idx)
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
   
   IF axmi410_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_xmfb_d.getLength() > 0 THEN
               CALL g_xmfb2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT xmfcsite,xmfc003,xmfc004,xmfc005,xmfc006,xmfc007,xmfc008 ,t2.imaal003 , 
             t3.imaal004 ,t4.oocal003 FROM xmfc_t",    
                     "",
                                    " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmfc004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xmfc004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=xmfc007 AND t4.oocal002='"||g_dlang||"' ",
 
                     " WHERE xmfcent=? AND xmfcdocno=? AND xmfc001=? AND xmfc002=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  xmfc_t.xmfc003" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
     
         #end add-point
         
         #先清空資料
               CALL g_xmfb2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmi410_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR axmi410_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfb_d[g_detail_idx].xmfb002  
      #      #(ver:78)
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,g_xmfb_d[g_detail_idx].xmfb002 INTO g_xmfb2_d[l_ac].xmfcsite, 
             g_xmfb2_d[l_ac].xmfc003,g_xmfb2_d[l_ac].xmfc004,g_xmfb2_d[l_ac].xmfc005,g_xmfb2_d[l_ac].xmfc006, 
             g_xmfb2_d[l_ac].xmfc007,g_xmfb2_d[l_ac].xmfc008,g_xmfb2_d[l_ac].xmfc004_desc,g_xmfb2_d[l_ac].xmfc004_desc_desc, 
             g_xmfb2_d[l_ac].xmfc007_desc   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_xmfb2_d.deleteElement(g_xmfb2_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_xmfb2_d_mask_o.* =  g_xmfb2_d.*
   FOR l_ac = 1 TO g_xmfb2_d.getLength()
      LET g_xmfb2_d_mask_o[l_ac].* =  g_xmfb2_d[l_ac].*
      CALL axmi410_xmfc_t_mask()
      LET g_xmfb2_d_mask_n[l_ac].* =  g_xmfb2_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL axmi410_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axmi410_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmi410.status_show" >}
PRIVATE FUNCTION axmi410_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmi410.mask_functions" >}
&include "erp/axm/axmi410_mask.4gl"
 
{</section>}
 
{<section id="axmi410.signature" >}
   
 
{</section>}
 
{<section id="axmi410.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmi410_set_pk_array()
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
   LET g_pk_array[1].values = g_xmfa_m.xmfadocno
   LET g_pk_array[1].column = 'xmfadocno'
   LET g_pk_array[2].values = g_xmfa_m.xmfa001
   LET g_pk_array[2].column = 'xmfa001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi410.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axmi410.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmi410_msgcentre_notify(lc_state)
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
   CALL axmi410_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmfa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi410.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axmi410_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmi410.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 新增時，依據產品特徵開窗後的值新增到資料庫
# Memo...........:
# Usage..........: CALL axmi410_feature()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 14/06/16 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi410_feature()
DEFINE l_i               LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5
DEFINE l_xmfc003         LIKE xmfc_t.xmfc003 
DEFINE l_xmfc005         LIKE xmfc_t.xmfc005
DEFINE l_xmfc006         LIKE xmfc_t.xmfc006 

   LET r_success = TRUE
   
   LET l_xmfc003 = ''
   SELECT MAX(xmfc003) INTO l_xmfc003 
     FROM xmfc_t
    WHERE xmfcent = g_enterprise
      AND xmfcsite = g_site
      AND xmfcdocno = g_xmfa_m.xmfadocno
      AND xmfc001 = g_xmfa_m.xmfa001
      AND xmfc002 = g_xmfb_d[g_detail_idx].xmfb002
   IF cl_null(l_xmfc003) THEN LET l_xmfc003 = 0 END IF
   
   FOR l_i = 2 TO g_inam.getLength()
   
      LET l_xmfc003 = l_xmfc003 + 1
      LET l_xmfc005 = g_inam[l_i].inam002
      LET l_xmfc006 = g_inam[l_i].inam004
      
      INSERT INTO xmfc_t(xmfcent,xmfcsite,xmfcdocno,xmfc001,xmfc002,xmfc003,
                         xmfc004,xmfc005,xmfc006,xmfc007,xmfc008) 
                 VALUES (g_enterprise,g_site,g_xmfa_m.xmfadocno,g_xmfa_m.xmfa001,
                         g_xmfb_d[g_detail_idx].xmfb002,l_xmfc003,
                         g_xmfb2_d[l_ac].xmfc004,l_xmfc005,l_xmfc006,
                         g_xmfb2_d[l_ac].xmfc007,g_xmfb2_d[l_ac].xmfc008) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'xmfc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOR
      END IF     
      
   END FOR
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 抓取分類說明
# Memo...........:
# Usage..........: axmi410_xmfb003_ref()
#
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/06/18 By Emma
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi410_xmfb003_ref()
   LET g_xmfb_d[l_ac].xmfb003_desc = ''
   DISPLAY BY NAME g_xmfb_d[l_ac].xmfb003_desc
   
   IF cl_null(g_xmfb_d[l_ac].xmfb003) THEN
      RETURN
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmfb_d[l_ac].xmfb003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='803' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmfb_d[l_ac].xmfb003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmfb_d[l_ac].xmfb003_desc
   
END FUNCTION

################################################################################
# Descriptions...: 抓取料號的品名、規格
# Memo...........:
# Usage..........: CALL axmi410_xmfc004_ref()
#                  
# Input parameter: 
#                :
# Return code....: 
#                : 
# Date & Author..: 14/06/18 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi410_xmfc004_ref()
   LET g_xmfb2_d[l_ac].xmfc004_desc = ''
   LET g_xmfb2_d[l_ac].xmfc004_desc_desc = ''
   DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc004_desc
   DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc004_desc_desc
   
   IF cl_null(g_xmfb2_d[l_ac].xmfc004) THEN
      RETURN
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmfb2_d[l_ac].xmfc004
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmfb2_d[l_ac].xmfc004_desc = '', g_rtn_fields[1] , ''
   LET g_xmfb2_d[l_ac].xmfc004_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc004_desc
   DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc004_desc_desc
END FUNCTION

################################################################################
# Descriptions...: 抓取範本編號的範本說明、助記碼
# Memo...........:
# Usage..........: CALL axmi410_xmfadocno_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/06/18 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi410_xmfadocno_ref()
   LET g_xmfa_m.xmfal003 = ''
   LET g_xmfa_m.xmfal004 = ''
   DISPLAY BY NAME g_xmfa_m.xmfal003
   DISPLAY BY NAME g_xmfa_m.xmfal004
   
   IF cl_null(g_xmfa_m.xmfadocno) THEN
      RETURN
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmfa_m.xmfadocno
   CALL ap_ref_array2(g_ref_fields," SELECT xmfal003,xmfal004 FROM xmfal_t WHERE xmfalent = '"
       ||g_enterprise||"' AND xmfaldocno = ? AND xmfal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmfa_m.xmfal003 = '', g_rtn_fields[1] , ''
   LET g_xmfa_m.xmfal004 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_xmfa_m.xmfal003
   DISPLAY BY NAME g_xmfa_m.xmfal004
END FUNCTION

################################################################################
# Descriptions...: 版本狀態碼檢查
# Memo...........:
# Usage..........: CALL axmi410_xmfa001_chk()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 14/06/19 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi410_xmfa001_chk()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(g_xmfa_m.xmfadocno) AND cl_null(g_xmfa_m.xmfa001) THEN
      RETURN r_success
   END IF
   
   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   INITIALIZE g_chkparam.* TO NULL
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_xmfa_m.xmfadocno
   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_xmfa001") THEN
      #檢查失敗時後續處理
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 抓取單位說明
# Memo...........:
# Usage..........: CALL axmi410_xmfc007_ref()
#                  
# Input parameter: 
#                :
# Return code....: 
#                : 
# Date & Author..: 14/07/10 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi410_xmfc007_ref()
   LET g_xmfb2_d[l_ac].xmfc007_desc = ''
   DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc007_desc

   IF cl_null(g_xmfb2_d[l_ac].xmfc007) THEN
      RETURN
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmfb2_d[l_ac].xmfc007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmfb2_d[l_ac].xmfc007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmfb2_d[l_ac].xmfc007_desc
END FUNCTION

 
{</section>}
 
