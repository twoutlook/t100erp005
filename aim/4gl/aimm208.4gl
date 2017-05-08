#該程式未解開Section, 採用最新樣板產出!
{<section id="aimm208.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-18 10:49:22), PR版次:0001(2016-06-02 16:04:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: aimm208
#+ Description: 集團預設料件據點分銷商品資料維護作業
#+ Creator....: 05384(2016-05-17 15:03:00)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="aimm208.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
 
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
PRIVATE type type_g_imaa_m        RECORD
       imaa001 LIKE imaa_t.imaa001, 
   imaa002 LIKE imaa_t.imaa002, 
   imaal003 LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   imaal005 LIKE type_t.chr10, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr80, 
   imaa003 LIKE imaa_t.imaa003, 
   imaa003_desc LIKE type_t.chr80, 
   imaa004 LIKE imaa_t.imaa004, 
   imaa005 LIKE imaa_t.imaa005, 
   imaa005_desc LIKE type_t.chr80, 
   imaa006 LIKE imaa_t.imaa006, 
   imaa006_desc LIKE type_t.chr80, 
   imaa010 LIKE imaa_t.imaa010, 
   imaa010_desc LIKE type_t.chr80, 
   l_s1 LIKE type_t.chr500, 
   imaa108 LIKE imaa_t.imaa108, 
   imaa100 LIKE imaa_t.imaa100, 
   imaa109 LIKE imaa_t.imaa109, 
   imaa114 LIKE imaa_t.imaa114, 
   imaa114_desc LIKE type_t.chr80, 
   imaa143 LIKE imaa_t.imaa143, 
   imaa143_desc LIKE type_t.chr80, 
   imaaownid LIKE imaa_t.imaaownid, 
   imaaownid_desc LIKE type_t.chr80, 
   imaaowndp LIKE imaa_t.imaaowndp, 
   imaaowndp_desc LIKE type_t.chr80, 
   imaacrtid LIKE imaa_t.imaacrtid, 
   imaacrtid_desc LIKE type_t.chr80, 
   imaacrtdp LIKE imaa_t.imaacrtdp, 
   imaacrtdp_desc LIKE type_t.chr80, 
   imaacrtdt LIKE imaa_t.imaacrtdt, 
   imaamodid LIKE imaa_t.imaamodid, 
   imaamodid_desc LIKE type_t.chr80, 
   imaamoddt LIKE imaa_t.imaamoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_imay_d        RECORD
       imaystus LIKE imay_t.imaystus, 
   imay002 LIKE imay_t.imay002, 
   imay003 LIKE imay_t.imay003, 
   imay004 LIKE imay_t.imay004, 
   imay004_desc LIKE type_t.chr500, 
   imay005 LIKE imay_t.imay005, 
   imay006 LIKE imay_t.imay006, 
   imay018 LIKE imay_t.imay018, 
   imay007 LIKE imay_t.imay007, 
   imay008 LIKE imay_t.imay008, 
   imay009 LIKE imay_t.imay009, 
   imay015 LIKE imay_t.imay015, 
   imay015_desc LIKE type_t.chr500, 
   imay010 LIKE imay_t.imay010, 
   imay016 LIKE imay_t.imay016, 
   imay016_desc LIKE type_t.chr500, 
   imay011 LIKE imay_t.imay011, 
   imay017 LIKE imay_t.imay017, 
   imay017_desc LIKE type_t.chr500, 
   imay012 LIKE imay_t.imay012, 
   imay013 LIKE imay_t.imay013, 
   imay014 LIKE imay_t.imay014
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_imaa001 LIKE imaa_t.imaa001,
   b_imaa001_desc LIKE type_t.chr80,
   b_imaa001_desc_desc LIKE type_t.chr80,
      b_imaa009 LIKE imaa_t.imaa009,
   b_imaa009_desc LIKE type_t.chr80,
      b_imaa003 LIKE imaa_t.imaa003,
   b_imaa003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_imaa_m          type_g_imaa_m
DEFINE g_imaa_m_t        type_g_imaa_m
DEFINE g_imaa_m_o        type_g_imaa_m
DEFINE g_imaa_m_mask_o   type_g_imaa_m #轉換遮罩前資料
DEFINE g_imaa_m_mask_n   type_g_imaa_m #轉換遮罩後資料
 
   DEFINE g_imaa001_t LIKE imaa_t.imaa001
 
 
DEFINE g_imay_d          DYNAMIC ARRAY OF type_g_imay_d
DEFINE g_imay_d_t        type_g_imay_d
DEFINE g_imay_d_o        type_g_imay_d
DEFINE g_imay_d_mask_o   DYNAMIC ARRAY OF type_g_imay_d #轉換遮罩前資料
DEFINE g_imay_d_mask_n   DYNAMIC ARRAY OF type_g_imay_d #轉換遮罩後資料
 
 
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
 
{<section id="aimm208.main" >}
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
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_imaa_m.imaa001 = g_argv[02]
   END IF   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imaa001,imaa002,'','','',imaa009,'',imaa003,'',imaa004,imaa005,'',imaa006, 
       '',imaa010,'','',imaa108,imaa100,imaa109,imaa114,'',imaa143,'',imaaownid,'',imaaowndp,'',imaacrtid, 
       '',imaacrtdp,'',imaacrtdt,imaamodid,'',imaamoddt", 
                      " FROM imaa_t",
                      " WHERE imaaent= ? AND imaa001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimm208_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imaa001,t0.imaa002,t0.imaa009,t0.imaa003,t0.imaa004,t0.imaa005,t0.imaa006, 
       t0.imaa010,t0.imaa108,t0.imaa100,t0.imaa109,t0.imaa114,t0.imaa143,t0.imaaownid,t0.imaaowndp,t0.imaacrtid, 
       t0.imaacrtdp,t0.imaacrtdt,t0.imaamodid,t0.imaamoddt,t1.rtaxl003 ,t2.oocql004 ,t3.imeal003 ,t4.oocal003 , 
       t5.oocql004 ,t6.ooail003 ,t7.dbbal003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011", 
 
               " FROM imaa_t t0",
                              " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=t0.imaa001 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='200' AND t2.oocql002=t0.imaa003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t3 ON t3.imealent="||g_enterprise||" AND t3.imeal001=t0.imaa005 AND t3.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.imaa006 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='210' AND t5.oocql002=t0.imaa010 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t6 ON t6.ooailent="||g_enterprise||" AND t6.ooail001=t0.imaa114 AND t6.ooail002='"||g_dlang||"' ",
               " LEFT JOIN dbbal_t t7 ON t7.dbbalent="||g_enterprise||" AND t7.dbbal001=t0.imaa143 AND t7.dbbal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.imaaownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.imaaowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.imaacrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.imaacrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.imaamodid  ",
 
               " WHERE t0.imaaent = " ||g_enterprise|| " AND t0.imaa001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimm208_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimm208 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimm208_init()   
 
      #進入選單 Menu (="N")
      CALL aimm208_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimm208
      
   END IF 
   
   CLOSE aimm208_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimm208.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimm208_init()
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
   
      CALL cl_set_combo_scc('imaa004','1001') 
   CALL cl_set_combo_scc('imaa108','2002') 
   CALL cl_set_combo_scc('imaa100','2003') 
   CALL cl_set_combo_scc('imaa109','2004') 
   CALL cl_set_combo_scc('imay002','2003') 
   CALL cl_set_combo_scc('imay018','6749') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('l_s1','50','N,X,Y')
   CALL cl_set_combo_scc_part('imaa109','6553','1,4,5')
   #end add-point
   
   #初始化搜尋條件
   CALL aimm208_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aimm208.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aimm208_ui_dialog()
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_imaa_m.* TO NULL
         CALL g_imay_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aimm208_init()
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
               
               CALL aimm208_fetch('') # reload data
               LET l_ac = 1
               CALL aimm208_ui_detailshow() #Setting the current row 
         
               CALL aimm208_idx_chk()
               #NEXT FIELD imay003
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_imay_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimm208_idx_chk()
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
               CALL aimm208_idx_chk()
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
            CALL aimm208_browser_fill("")
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
               CALL aimm208_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aimm208_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aimm208_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
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
                     WHEN la_wc[li_idx].tableid = "imaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imay_t" 
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
               CALL aimm208_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "imaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imay_t" 
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
                  CALL aimm208_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimm208_fetch("F")
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
               CALL aimm208_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aimm208_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimm208_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aimm208_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimm208_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aimm208_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimm208_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aimm208_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimm208_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aimm208_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimm208_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_imay_d)
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
               NEXT FIELD imay003
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
               CALL aimm208_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aimm208_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm202
            LET g_action_choice="open_aimm202"
            IF cl_auth_chk_act("open_aimm202") THEN
               
               #add-point:ON ACTION open_aimm202 name="menu.open_aimm202"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   IF g_site = 'ALL' THEN
                      CALL cl_cmdrun(" aimm202 '"||g_imaa_m.imaa001||"'")
                   ELSE
                      CALL cl_cmdrun(" aimm212 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm207
            LET g_action_choice="open_aimm207"
            IF cl_auth_chk_act("open_aimm207") THEN
               
               #add-point:ON ACTION open_aimm207 name="menu.open_aimm207"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   CALL cl_cmdrun(" aimm207 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm200
            LET g_action_choice="open_aimm200"
            IF cl_auth_chk_act("open_aimm200") THEN
               
               #add-point:ON ACTION open_aimm200 name="menu.open_aimm200"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   CALL cl_cmdrun(" aimm200 '"||g_imaa_m.imaa001||"'")
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm206
            LET g_action_choice="open_aimm206"
            IF cl_auth_chk_act("open_aimm206") THEN
               
               #add-point:ON ACTION open_aimm206 name="menu.open_aimm206"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   IF g_site = 'ALL' THEN
                      CALL cl_cmdrun(" aimm206 '"||g_imaa_m.imaa001||"'")
                   ELSE
                      CALL cl_cmdrun(" aimm216 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm204
            LET g_action_choice="open_aimm204"
            IF cl_auth_chk_act("open_aimm204") THEN
               
               #add-point:ON ACTION open_aimm204 name="menu.open_aimm204"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   IF g_site = 'ALL' THEN
                      CALL cl_cmdrun(" aimm204 '"||g_imaa_m.imaa001||"'")
                   ELSE
                      CALL cl_cmdrun(" aimm214 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm210
            LET g_action_choice="open_aimm210"
            IF cl_auth_chk_act("open_aimm210") THEN
               
               #add-point:ON ACTION open_aimm210 name="menu.open_aimm210"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   IF g_site = 'ALL' THEN
                      CALL cl_cmdrun(" aimm210 '"||g_imaa_m.imaa001||"'")
                   ELSE
                      CALL cl_cmdrun(" aimm220 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                   END IF
                END IF
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimm208_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm201
            LET g_action_choice="open_aimm201"
            IF cl_auth_chk_act("open_aimm201") THEN
               
               #add-point:ON ACTION open_aimm201 name="menu.open_aimm201"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   IF g_site = 'ALL' THEN
                      CALL cl_cmdrun(" aimm201 '"||g_imaa_m.imaa001||"'")
                   ELSE
                      CALL cl_cmdrun(" aimm211 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm203
            LET g_action_choice="open_aimm203"
            IF cl_auth_chk_act("open_aimm203") THEN
               
               #add-point:ON ACTION open_aimm203 name="menu.open_aimm203"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   IF g_site = 'ALL' THEN
                      CALL cl_cmdrun(" aimm203 '"||g_imaa_m.imaa001||"'")
                   ELSE
                      CALL cl_cmdrun(" aimm213 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm205
            LET g_action_choice="open_aimm205"
            IF cl_auth_chk_act("open_aimm205") THEN
               
               #add-point:ON ACTION open_aimm205 name="menu.open_aimm205"
                IF NOT cl_null(g_imaa_m.imaa001) THEN
                   IF g_site = 'ALL' THEN
                      CALL cl_cmdrun(" aimm205 '"||g_imaa_m.imaa001||"'")
                   ELSE
                      CALL cl_cmdrun(" aimm215 '"||g_site||"' '"||g_imaa_m.imaa001||"'")
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa009
            LET g_action_choice="prog_imaa009"
            IF cl_auth_chk_act("prog_imaa009") THEN
               
               #add-point:ON ACTION prog_imaa009 name="menu.prog_imaa009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imaa_m.imaa009)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa003
            LET g_action_choice="prog_imaa003"
            IF cl_auth_chk_act("prog_imaa003") THEN
               
               #add-point:ON ACTION prog_imaa003 name="menu.prog_imaa003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imaa_m.imaa003)


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimm208_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimm208_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimm208_set_pk_array()
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
 
{<section id="aimm208.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aimm208_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT imaa001 ",
                      " FROM imaa_t ",
                      " ",
                      " LEFT JOIN imay_t ON imayent = imaaent AND imaa001 = imay001 ", "  ",
                      #add-point:browser_fill段sql(imay_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE imaaent = " ||g_enterprise|| " AND imayent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("imaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT imaa001 ",
                      " FROM imaa_t ", 
                      "  ",
                      "  ",
                      " WHERE imaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("imaa_t")
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
      INITIALIZE g_imaa_m.* TO NULL
      CALL g_imay_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.imaa001,t0.imaa009,t0.imaa003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imaastus,t0.imaa001,t0.imaa009,t0.imaa003,t1.imaal003 ,t2.imaal004 , 
          t3.rtaxl003 ,t4.oocql004 ",
                  " FROM imaa_t t0",
                  "  ",
                  "  LEFT JOIN imay_t ON imayent = imaaent AND imaa001 = imay001 ", "  ", 
                  #add-point:browser_fill段sql(imay_t1) name="browser_fill.join.imay_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.imaa001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.imaa001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.imaa009 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='200' AND t4.oocql002=t0.imaa003 AND t4.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.imaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imaastus,t0.imaa001,t0.imaa009,t0.imaa003,t1.imaal003 ,t2.imaal004 , 
          t3.rtaxl003 ,t4.oocql004 ",
                  " FROM imaa_t t0",
                  "  ",
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.imaa001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.imaa001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.imaa009 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='200' AND t4.oocql002=t0.imaa003 AND t4.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.imaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("imaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY imaa001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"imaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imaa001,g_browser[g_cnt].b_imaa009, 
          g_browser[g_cnt].b_imaa003,g_browser[g_cnt].b_imaa001_desc,g_browser[g_cnt].b_imaa001_desc_desc, 
          g_browser[g_cnt].b_imaa009_desc,g_browser[g_cnt].b_imaa003_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      SELECT imaa009,imaa003
        INTO g_browser[g_cnt].b_imaa009,g_browser[g_cnt].b_imaa003
        FROM imaa_t
       WHERE imaa001 = g_browser[g_cnt].b_imaa001
         AND imaaent = g_enterprise
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_imaa009
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_imaa009_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_imaa009_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_imaa003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_imaa003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_imaa003_desc        
         #end add-point
      
         #遮罩相關處理
         CALL aimm208_browser_mask()
      
         
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
   
   IF cl_null(g_browser[g_cnt].b_imaa001) THEN
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
 
{<section id="aimm208.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aimm208_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_imaa_m.imaa001 = g_browser[g_current_idx].b_imaa001   
 
   EXECUTE aimm208_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc
   
   CALL aimm208_imaa_t_mask()
   CALL aimm208_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aimm208.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aimm208_ui_detailshow()
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
 
{<section id="aimm208.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimm208_ui_browser_refresh()
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
      IF g_browser[l_i].b_imaa001 = g_imaa_m.imaa001 
 
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
 
{<section id="aimm208.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimm208_construct()
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
   INITIALIZE g_imaa_m.* TO NULL
   CALL g_imay_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON imaa001,imaa002,imaal003,imaal004,imaal005,imaa009,imaa003,imaa004,imaa005, 
          imaa006,imaa010,imaa108,imaa100,imaa109,imaa114,imaa143,imaaownid,imaaowndp,imaacrtid,imaacrtdp, 
          imaacrtdt,imaamodid,imaamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imaacrtdt>>----
         AFTER FIELD imaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imaamoddt>>----
         AFTER FIELD imaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imaacnfdt>>----
         
         #----<<imaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上

            NEXT FIELD imaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa002
            #add-point:BEFORE FIELD imaa002 name="construct.b.imaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa002
            
            #add-point:AFTER FIELD imaa002 name="construct.a.imaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa002
            #add-point:ON ACTION controlp INFIELD imaa002 name="construct.c.imaa002"
            
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
         BEFORE FIELD imaal005
            #add-point:BEFORE FIELD imaal005 name="construct.b.imaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal005
            
            #add-point:AFTER FIELD imaal005 name="construct.a.imaal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal005
            #add-point:ON ACTION controlp INFIELD imaal005 name="construct.c.imaal005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上

            NEXT FIELD imaa003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="construct.b.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="construct.a.imaa003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa004
            #add-point:BEFORE FIELD imaa004 name="construct.b.imaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa004
            
            #add-point:AFTER FIELD imaa004 name="construct.a.imaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa004
            #add-point:ON ACTION controlp INFIELD imaa004 name="construct.c.imaa004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa005
            #add-point:ON ACTION controlp INFIELD imaa005 name="construct.c.imaa005"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa005  #顯示到畫面上

            NEXT FIELD imaa005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa005
            #add-point:BEFORE FIELD imaa005 name="construct.b.imaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa005
            
            #add-point:AFTER FIELD imaa005 name="construct.a.imaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="construct.c.imaa006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa006  #顯示到畫面上

            NEXT FIELD imaa006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="construct.b.imaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="construct.a.imaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="construct.c.imaa010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa010  #顯示到畫面上

            NEXT FIELD imaa010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="construct.b.imaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="construct.a.imaa010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa108
            #add-point:BEFORE FIELD imaa108 name="construct.b.imaa108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa108
            
            #add-point:AFTER FIELD imaa108 name="construct.a.imaa108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa108
            #add-point:ON ACTION controlp INFIELD imaa108 name="construct.c.imaa108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa100
            #add-point:BEFORE FIELD imaa100 name="construct.b.imaa100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa100
            
            #add-point:AFTER FIELD imaa100 name="construct.a.imaa100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa100
            #add-point:ON ACTION controlp INFIELD imaa100 name="construct.c.imaa100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa109
            #add-point:BEFORE FIELD imaa109 name="construct.b.imaa109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa109
            
            #add-point:AFTER FIELD imaa109 name="construct.a.imaa109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa109
            #add-point:ON ACTION controlp INFIELD imaa109 name="construct.c.imaa109"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa114
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa114
            #add-point:ON ACTION controlp INFIELD imaa114 name="construct.c.imaa114"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa114  #顯示到畫面上
            NEXT FIELD imaa114                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa114
            #add-point:BEFORE FIELD imaa114 name="construct.b.imaa114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa114
            
            #add-point:AFTER FIELD imaa114 name="construct.a.imaa114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa143
            #add-point:ON ACTION controlp INFIELD imaa143 name="construct.c.imaa143"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_dbba001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa143  #顯示到畫面上
            NEXT FIELD imaa143                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa143
            #add-point:BEFORE FIELD imaa143 name="construct.b.imaa143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa143
            
            #add-point:AFTER FIELD imaa143 name="construct.a.imaa143"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaaownid
            #add-point:ON ACTION controlp INFIELD imaaownid name="construct.c.imaaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaaownid  #顯示到畫面上

            NEXT FIELD imaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaaownid
            #add-point:BEFORE FIELD imaaownid name="construct.b.imaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaaownid
            
            #add-point:AFTER FIELD imaaownid name="construct.a.imaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaaowndp
            #add-point:ON ACTION controlp INFIELD imaaowndp name="construct.c.imaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaaowndp  #顯示到畫面上

            NEXT FIELD imaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaaowndp
            #add-point:BEFORE FIELD imaaowndp name="construct.b.imaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaaowndp
            
            #add-point:AFTER FIELD imaaowndp name="construct.a.imaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaacrtid
            #add-point:ON ACTION controlp INFIELD imaacrtid name="construct.c.imaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaacrtid  #顯示到畫面上

            NEXT FIELD imaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacrtid
            #add-point:BEFORE FIELD imaacrtid name="construct.b.imaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaacrtid
            
            #add-point:AFTER FIELD imaacrtid name="construct.a.imaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaacrtdp
            #add-point:ON ACTION controlp INFIELD imaacrtdp name="construct.c.imaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaacrtdp  #顯示到畫面上

            NEXT FIELD imaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacrtdp
            #add-point:BEFORE FIELD imaacrtdp name="construct.b.imaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaacrtdp
            
            #add-point:AFTER FIELD imaacrtdp name="construct.a.imaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacrtdt
            #add-point:BEFORE FIELD imaacrtdt name="construct.b.imaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaamodid
            #add-point:ON ACTION controlp INFIELD imaamodid name="construct.c.imaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaamodid  #顯示到畫面上

            NEXT FIELD imaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaamodid
            #add-point:BEFORE FIELD imaamodid name="construct.b.imaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaamodid
            
            #add-point:AFTER FIELD imaamodid name="construct.a.imaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaamoddt
            #add-point:BEFORE FIELD imaamoddt name="construct.b.imaamoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON imaystus,imay002,imay003,imay004,imay005,imay006,imay018,imay007,imay008, 
          imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014
           FROM s_detail1[1].imaystus,s_detail1[1].imay002,s_detail1[1].imay003,s_detail1[1].imay004, 
               s_detail1[1].imay005,s_detail1[1].imay006,s_detail1[1].imay018,s_detail1[1].imay007,s_detail1[1].imay008, 
               s_detail1[1].imay009,s_detail1[1].imay015,s_detail1[1].imay010,s_detail1[1].imay016,s_detail1[1].imay011, 
               s_detail1[1].imay017,s_detail1[1].imay012,s_detail1[1].imay013,s_detail1[1].imay014
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imaycrtdt>>----
 
         #----<<imaymoddt>>----
         
         #----<<imaycnfdt>>----
         
         #----<<imaypstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaystus
            #add-point:BEFORE FIELD imaystus name="construct.b.page1.imaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaystus
            
            #add-point:AFTER FIELD imaystus name="construct.a.page1.imaystus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaystus
            #add-point:ON ACTION controlp INFIELD imaystus name="construct.c.page1.imaystus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay002
            #add-point:BEFORE FIELD imay002 name="construct.b.page1.imay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay002
            
            #add-point:AFTER FIELD imay002 name="construct.a.page1.imay002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay002
            #add-point:ON ACTION controlp INFIELD imay002 name="construct.c.page1.imay002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay003
            #add-point:ON ACTION controlp INFIELD imay003 name="construct.c.page1.imay003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay003  #顯示到畫面上
            NEXT FIELD imay003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay003
            #add-point:BEFORE FIELD imay003 name="construct.b.page1.imay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay003
            
            #add-point:AFTER FIELD imay003 name="construct.a.page1.imay003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay004
            #add-point:ON ACTION controlp INFIELD imay004 name="construct.c.page1.imay004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay004  #顯示到畫面上
            NEXT FIELD imay004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay004
            #add-point:BEFORE FIELD imay004 name="construct.b.page1.imay004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay004
            
            #add-point:AFTER FIELD imay004 name="construct.a.page1.imay004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay005
            #add-point:BEFORE FIELD imay005 name="construct.b.page1.imay005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay005
            
            #add-point:AFTER FIELD imay005 name="construct.a.page1.imay005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay005
            #add-point:ON ACTION controlp INFIELD imay005 name="construct.c.page1.imay005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay006
            #add-point:BEFORE FIELD imay006 name="construct.b.page1.imay006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay006
            
            #add-point:AFTER FIELD imay006 name="construct.a.page1.imay006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay006
            #add-point:ON ACTION controlp INFIELD imay006 name="construct.c.page1.imay006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay018
            #add-point:BEFORE FIELD imay018 name="construct.b.page1.imay018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay018
            
            #add-point:AFTER FIELD imay018 name="construct.a.page1.imay018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay018
            #add-point:ON ACTION controlp INFIELD imay018 name="construct.c.page1.imay018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay007
            #add-point:BEFORE FIELD imay007 name="construct.b.page1.imay007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay007
            
            #add-point:AFTER FIELD imay007 name="construct.a.page1.imay007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay007
            #add-point:ON ACTION controlp INFIELD imay007 name="construct.c.page1.imay007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay008
            #add-point:BEFORE FIELD imay008 name="construct.b.page1.imay008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay008
            
            #add-point:AFTER FIELD imay008 name="construct.a.page1.imay008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay008
            #add-point:ON ACTION controlp INFIELD imay008 name="construct.c.page1.imay008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay009
            #add-point:BEFORE FIELD imay009 name="construct.b.page1.imay009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay009
            
            #add-point:AFTER FIELD imay009 name="construct.a.page1.imay009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay009
            #add-point:ON ACTION controlp INFIELD imay009 name="construct.c.page1.imay009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay015
            #add-point:ON ACTION controlp INFIELD imay015 name="construct.c.page1.imay015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay015  #顯示到畫面上
            NEXT FIELD imay015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay015
            #add-point:BEFORE FIELD imay015 name="construct.b.page1.imay015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay015
            
            #add-point:AFTER FIELD imay015 name="construct.a.page1.imay015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay010
            #add-point:BEFORE FIELD imay010 name="construct.b.page1.imay010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay010
            
            #add-point:AFTER FIELD imay010 name="construct.a.page1.imay010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay010
            #add-point:ON ACTION controlp INFIELD imay010 name="construct.c.page1.imay010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay016
            #add-point:ON ACTION controlp INFIELD imay016 name="construct.c.page1.imay016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay016  #顯示到畫面上
            NEXT FIELD imay016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay016
            #add-point:BEFORE FIELD imay016 name="construct.b.page1.imay016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay016
            
            #add-point:AFTER FIELD imay016 name="construct.a.page1.imay016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay011
            #add-point:BEFORE FIELD imay011 name="construct.b.page1.imay011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay011
            
            #add-point:AFTER FIELD imay011 name="construct.a.page1.imay011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay011
            #add-point:ON ACTION controlp INFIELD imay011 name="construct.c.page1.imay011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imay017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay017
            #add-point:ON ACTION controlp INFIELD imay017 name="construct.c.page1.imay017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay017  #顯示到畫面上
            NEXT FIELD imay017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay017
            #add-point:BEFORE FIELD imay017 name="construct.b.page1.imay017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay017
            
            #add-point:AFTER FIELD imay017 name="construct.a.page1.imay017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay012
            #add-point:BEFORE FIELD imay012 name="construct.b.page1.imay012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay012
            
            #add-point:AFTER FIELD imay012 name="construct.a.page1.imay012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay012
            #add-point:ON ACTION controlp INFIELD imay012 name="construct.c.page1.imay012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay013
            #add-point:BEFORE FIELD imay013 name="construct.b.page1.imay013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay013
            
            #add-point:AFTER FIELD imay013 name="construct.a.page1.imay013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay013
            #add-point:ON ACTION controlp INFIELD imay013 name="construct.c.page1.imay013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay014
            #add-point:BEFORE FIELD imay014 name="construct.b.page1.imay014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay014
            
            #add-point:AFTER FIELD imay014 name="construct.a.page1.imay014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imay014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay014
            #add-point:ON ACTION controlp INFIELD imay014 name="construct.c.page1.imay014"
            
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
                  WHEN la_wc[li_idx].tableid = "imaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imay_t" 
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
 
{<section id="aimm208.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimm208_filter()
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
      CONSTRUCT g_wc_filter ON imaa001,imaa009,imaa003
                          FROM s_browse[1].b_imaa001,s_browse[1].b_imaa009,s_browse[1].b_imaa003
 
         BEFORE CONSTRUCT
               DISPLAY aimm208_filter_parser('imaa001') TO s_browse[1].b_imaa001
            DISPLAY aimm208_filter_parser('imaa009') TO s_browse[1].b_imaa009
            DISPLAY aimm208_filter_parser('imaa003') TO s_browse[1].b_imaa003
      
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
 
      CALL aimm208_filter_show('imaa001')
   CALL aimm208_filter_show('imaa009')
   CALL aimm208_filter_show('imaa003')
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimm208_filter_parser(ps_field)
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
 
{<section id="aimm208.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimm208_filter_show(ps_field)
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
   LET ls_condition = aimm208_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimm208_query()
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
   CALL g_imay_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aimm208_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimm208_browser_fill("")
      CALL aimm208_fetch("")
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
      CALL aimm208_filter_show('imaa001')
   CALL aimm208_filter_show('imaa009')
   CALL aimm208_filter_show('imaa003')
   CALL aimm208_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aimm208_fetch("F") 
      #顯示單身筆數
      CALL aimm208_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimm208_fetch(p_flag)
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
   
   LET g_imaa_m.imaa001 = g_browser[g_current_idx].b_imaa001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aimm208_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aimm208_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimm208_set_act_visible()   
   CALL aimm208_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   SELECT imaastus INTO g_imaa_m.l_s1 FROM imaa_t
#    WHERE imaaent = g_enterprise  AND imaa001 = g_imaa_m.imaa001
# 
#   IF g_imaa_m.l_s1 = 'X' THEN
#      CALL cl_set_act_visible("modify", FALSE)
#   ELSE
#      CALL cl_set_act_visible("modify",  TRUE)
#   END IF
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("query", FALSE)
   END IF  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imaa_m_t.* = g_imaa_m.*
   LET g_imaa_m_o.* = g_imaa_m.*
   
   LET g_data_owner = g_imaa_m.imaaownid      
   LET g_data_dept  = g_imaa_m.imaaowndp
   
   #重新顯示   
   CALL aimm208_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimm208_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_imay_d.clear()   
 
 
   INITIALIZE g_imaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_imaa001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaa_m.imaaownid = g_user
      LET g_imaa_m.imaaowndp = g_dept
      LET g_imaa_m.imaacrtid = g_user
      LET g_imaa_m.imaacrtdp = g_dept 
      LET g_imaa_m.imaacrtdt = cl_get_current()
      LET g_imaa_m.imaamodid = g_user
      LET g_imaa_m.imaamoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_imaa_m_t.* = g_imaa_m.*
      LET g_imaa_m_o.* = g_imaa_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL aimm208_input("a")
      
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
         INITIALIZE g_imaa_m.* TO NULL
         INITIALIZE g_imay_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aimm208_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_imay_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimm208_set_act_visible()   
   CALL aimm208_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimm208_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aimm208_cl
   
   CALL aimm208_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimm208_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc
   
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aimm208_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
       g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
       g_imaa_m.imaa010_desc,g_imaa_m.l_s1,g_imaa_m.imaa108,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
       g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_imaa_m.imaaownid      
   LET g_data_dept  = g_imaa_m.imaaowndp
   
   #功能已完成,通報訊息中心
   CALL aimm208_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimm208_modify()
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
   LET g_imaa_m_t.* = g_imaa_m.*
   LET g_imaa_m_o.* = g_imaa_m.*
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_imaa001_t = g_imaa_m.imaa001
 
   CALL s_transaction_begin()
   
   OPEN aimm208_cl USING g_enterprise,g_imaa_m.imaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimm208_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimm208_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimm208_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc
   
   #檢查是否允許此動作
   IF NOT aimm208_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aimm208_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aimm208_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_imaa001_t = g_imaa_m.imaa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_imaa_m.imaamodid = g_user 
LET g_imaa_m.imaamoddt = cl_get_current()
LET g_imaa_m.imaamodid_desc = cl_get_username(g_imaa_m.imaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aimm208_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE imaa_t SET (imaamodid,imaamoddt) = (g_imaa_m.imaamodid,g_imaa_m.imaamoddt)
          WHERE imaaent = g_enterprise AND imaa001 = g_imaa001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_imaa_m.* = g_imaa_m_t.*
            CALL aimm208_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_imaa_m.imaa001 != g_imaa_m_t.imaa001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE imay_t SET imay001 = g_imaa_m.imaa001
 
          WHERE imayent = g_enterprise AND imay001 = g_imaa_m_t.imaa001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imay_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
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
   CALL aimm208_set_act_visible()   
   CALL aimm208_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
   #填到對應位置
   CALL aimm208_browser_fill("")
 
   CLOSE aimm208_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimm208_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aimm208.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimm208_input(p_cmd)
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
   DEFINE l_imai068     LIKE imai_t.imai068
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_type        LIKE rtaj_t.rtaj001
   DEFINE l_imay005     LIKE imay_t.imay005
   DEFINE l_imaa104     LIKE imaa_t.imaa104
   DEFINE l_imaa106     LIKE imaa_t.imaa106
   DEFINE l_upd_imaa014 LIKE type_t.chr1
   DEFINE l_msg         STRING
   DEFINE l_imaymoddt   LIKE imay_t.imaymoddt
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
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
       g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
       g_imaa_m.imaa010_desc,g_imaa_m.l_s1,g_imaa_m.imaa108,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
       g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt 
 
   
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
   LET g_forupd_sql = "SELECT imaystus,imay002,imay003,imay004,imay005,imay006,imay018,imay007,imay008, 
       imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014 FROM imay_t WHERE imayent=?  
       AND imay001=? AND imay003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimm208_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aimm208_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimm208_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aimm208.input.head" >}
      #單頭段
      INPUT BY NAME g_imaa_m.imaa001,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005,g_imaa_m.imaa009, 
          g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
          g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aimm208_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimm208_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimm208_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aimm208_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aimm208_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="input.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="input.a.imaa001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_imaa_m.imaa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imaa_t WHERE "||"imaaent = '" ||g_enterprise|| "' AND "||"imaa001 = '"||g_imaa_m.imaa001 ||"'",'std-00004',1) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa001
            #add-point:ON CHANGE imaa001 name="input.g.imaa001"
            
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
         BEFORE FIELD imaal005
            #add-point:BEFORE FIELD imaal005 name="input.b.imaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal005
            
            #add-point:AFTER FIELD imaal005 name="input.a.imaal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal005
            #add-point:ON CHANGE imaal005 name="input.g.imaal005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="input.a.imaa009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa009_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="input.b.imaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa009
            #add-point:ON CHANGE imaa009 name="input.g.imaa009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="input.a.imaa003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa003_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="input.b.imaa003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa003
            #add-point:ON CHANGE imaa003 name="input.g.imaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa004
            #add-point:BEFORE FIELD imaa004 name="input.b.imaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa004
            
            #add-point:AFTER FIELD imaa004 name="input.a.imaa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa004
            #add-point:ON CHANGE imaa004 name="input.g.imaa004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa005
            
            #add-point:AFTER FIELD imaa005 name="input.a.imaa005"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa005
            CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaa_m.imaa005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa005
            #add-point:BEFORE FIELD imaa005 name="input.b.imaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa005
            #add-point:ON CHANGE imaa005 name="input.g.imaa005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="input.a.imaa006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa006_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa006_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="input.b.imaa006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa006
            #add-point:ON CHANGE imaa006 name="input.g.imaa006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="input.a.imaa010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa010_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="input.b.imaa010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa010
            #add-point:ON CHANGE imaa010 name="input.g.imaa010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa108
            #add-point:BEFORE FIELD imaa108 name="input.b.imaa108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa108
            
            #add-point:AFTER FIELD imaa108 name="input.a.imaa108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa108
            #add-point:ON CHANGE imaa108 name="input.g.imaa108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa100
            #add-point:BEFORE FIELD imaa100 name="input.b.imaa100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa100
            
            #add-point:AFTER FIELD imaa100 name="input.a.imaa100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa100
            #add-point:ON CHANGE imaa100 name="input.g.imaa100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa109
            #add-point:BEFORE FIELD imaa109 name="input.b.imaa109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa109
            
            #add-point:AFTER FIELD imaa109 name="input.a.imaa109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa109
            #add-point:ON CHANGE imaa109 name="input.g.imaa109"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa114
            
            #add-point:AFTER FIELD imaa114 name="input.a.imaa114"
            LET g_imaa_m.imaa114_desc = ''
            DISPLAY BY NAME g_imaa_m.imaa114_desc
            IF NOT cl_null(g_imaa_m.imaa114) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaa_m.imaa114

                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooai001") THEN
                  LET g_imaa_m.imaa114 = g_imaa_m_o.imaa114                  
                  CALL s_desc_get_currency_desc(g_imaa_m.imaa114) RETURNING g_imaa_m.imaa114_desc
                  DISPLAY BY NAME g_imaa_m.imaa114_desc                  
                  NEXT FIELD CURRENT
               END IF
 
               CALL s_desc_get_currency_desc(g_imaa_m.imaa114) RETURNING g_imaa_m.imaa114_desc
               DISPLAY BY NAME g_imaa_m.imaa114_desc  

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa114
            #add-point:BEFORE FIELD imaa114 name="input.b.imaa114"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa114
            #add-point:ON CHANGE imaa114 name="input.g.imaa114"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa143
            
            #add-point:AFTER FIELD imaa143 name="input.a.imaa143"
            LET g_imaa_m.imaa143_desc = ''
            DISPLAY BY NAME g_imaa_m.imaa143_desc  
            IF NOT cl_null(g_imaa_m.imaa143) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaa_m.imaa143

                  
               #呼叫檢查存在並帶值的library               
               IF NOT cl_chk_exist("v_dbba001") THEN
                  LET g_imaa_m.imaa143 = g_imaa_m_o.imaa143                  
                  CALL s_desc_get_prod_group_desc(g_imaa_m.imaa143) RETURNING g_imaa_m.imaa143_desc
                  DISPLAY BY NAME g_imaa_m.imaa143_desc                  
                  NEXT FIELD CURRENT
               END IF
 
               CALL s_desc_get_prod_group_desc(g_imaa_m.imaa143) RETURNING g_imaa_m.imaa143_desc
               DISPLAY BY NAME g_imaa_m.imaa143_desc  
 


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa143
            #add-point:BEFORE FIELD imaa143 name="input.b.imaa143"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa143
            #add-point:ON CHANGE imaa143 name="input.g.imaa143"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="input.c.imaa001"
            
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
 
 
         #Ctrlp:input.c.imaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal005
            #add-point:ON ACTION controlp INFIELD imaal005 name="input.c.imaal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="input.c.imaa009"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa009             #給予default值

            #給予arg

            CALL q_rtax001()                                #呼叫開窗

            LET g_imaa_m.imaa009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa009 TO imaa009              #顯示到畫面上

            NEXT FIELD imaa009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="input.c.imaa003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa003 TO imaa003              #顯示到畫面上

            NEXT FIELD imaa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa004
            #add-point:ON ACTION controlp INFIELD imaa004 name="input.c.imaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa005
            #add-point:ON ACTION controlp INFIELD imaa005 name="input.c.imaa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="input.c.imaa006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa006 TO imaa006              #顯示到畫面上

            NEXT FIELD imaa006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="input.c.imaa010"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa010 TO imaa010              #顯示到畫面上

            NEXT FIELD imaa010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa108
            #add-point:ON ACTION controlp INFIELD imaa108 name="input.c.imaa108"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa100
            #add-point:ON ACTION controlp INFIELD imaa100 name="input.c.imaa100"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa109
            #add-point:ON ACTION controlp INFIELD imaa109 name="input.c.imaa109"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa114
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa114
            #add-point:ON ACTION controlp INFIELD imaa114 name="input.c.imaa114"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imaa_m.imaa114             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_imaa_m.imaa114 = g_qryparam.return1              

            DISPLAY g_imaa_m.imaa114 TO imaa114              #
            CALL s_desc_get_currency_desc(g_imaa_m.imaa114) RETURNING g_imaa_m.imaa114_desc
            DISPLAY BY NAME g_imaa_m.imaa114_desc 
            NEXT FIELD imaa114                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.imaa143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa143
            #add-point:ON ACTION controlp INFIELD imaa143 name="input.c.imaa143"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imaa_m.imaa143             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_dbba001_1()                                #呼叫開窗
 
            LET g_imaa_m.imaa143 = g_qryparam.return1              

            DISPLAY g_imaa_m.imaa143 TO imaa143              #
            CALL s_desc_get_prod_group_desc(g_imaa_m.imaa143) RETURNING g_imaa_m.imaa143_desc
            DISPLAY BY NAME g_imaa_m.imaa143_desc

            NEXT FIELD imaa143                          #返回原欄位



            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_imaa_m.imaa001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO imaa_t (imaaent,imaa001,imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010, 
                   imaa108,imaa100,imaa109,imaa114,imaa143,imaaownid,imaaowndp,imaacrtid,imaacrtdp,imaacrtdt, 
                   imaamodid,imaamoddt)
               VALUES (g_enterprise,g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009,g_imaa_m.imaa003, 
                   g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
                   g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143,g_imaa_m.imaaownid, 
                   g_imaa_m.imaaowndp,g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid, 
                   g_imaa_m.imaamoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_imaa_m:",SQLERRMESSAGE 
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
                  CALL aimm208_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aimm208_b_fill()
                  CALL aimm208_b_fill2('0')
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
               CALL aimm208_imaa_t_mask_restore('restore_mask_o')
               
               UPDATE imaa_t SET (imaa001,imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010,imaa108, 
                   imaa100,imaa109,imaa114,imaa143,imaaownid,imaaowndp,imaacrtid,imaacrtdp,imaacrtdt, 
                   imaamodid,imaamoddt) = (g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009,g_imaa_m.imaa003, 
                   g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
                   g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143,g_imaa_m.imaaownid, 
                   g_imaa_m.imaaowndp,g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid, 
                   g_imaa_m.imaamoddt)
                WHERE imaaent = g_enterprise AND imaa001 = g_imaa001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aimm208_imaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
#                  #若g_site='ALL'，則呼叫s_aooi090_upd_fields，將有設定為集團一致的欄位資料一併更新
#                  IF g_site = 'ALL' THEN
#                     IF NOT s_aooi090_upd_fields('2',g_imaa001_t) THEN #'2' 據點製造資料
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "imaa_t"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CALL s_transaction_end('N','0')
#                     END IF
#                  END IF                  
                  LET l_imai068 = cl_get_current()
                  UPDATE imai_t SET (imai066,imai067,imai068) = ('1',g_user,l_imai068)
                   WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = g_imaa001_t
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "imai_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  END IF
                  IF NOT s_aimm200_upd_item_site_stus(g_imaa_m.imaa001,g_site) THEN
                     CALL s_transaction_end('N','0')
                  END IF  
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_imaa001_t = g_imaa_m.imaa001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aimm208.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_imay_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imay_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimm208_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_imay_d.getLength()
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
            OPEN aimm208_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimm208_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimm208_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imay_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imay_d[l_ac].imay003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imay_d_t.* = g_imay_d[l_ac].*  #BACKUP
               LET g_imay_d_o.* = g_imay_d[l_ac].*  #BACKUP
               CALL aimm208_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aimm208_set_no_entry_b(l_cmd)
               IF NOT aimm208_lock_b("imay_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimm208_bcl INTO g_imay_d[l_ac].imaystus,g_imay_d[l_ac].imay002,g_imay_d[l_ac].imay003, 
                      g_imay_d[l_ac].imay004,g_imay_d[l_ac].imay005,g_imay_d[l_ac].imay006,g_imay_d[l_ac].imay018, 
                      g_imay_d[l_ac].imay007,g_imay_d[l_ac].imay008,g_imay_d[l_ac].imay009,g_imay_d[l_ac].imay015, 
                      g_imay_d[l_ac].imay010,g_imay_d[l_ac].imay016,g_imay_d[l_ac].imay011,g_imay_d[l_ac].imay017, 
                      g_imay_d[l_ac].imay012,g_imay_d[l_ac].imay013,g_imay_d[l_ac].imay014
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imay_d_t.imay003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imay_d_mask_o[l_ac].* =  g_imay_d[l_ac].*
                  CALL aimm208_imay_t_mask()
                  LET g_imay_d_mask_n[l_ac].* =  g_imay_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimm208_show()
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
            INITIALIZE g_imay_d[l_ac].* TO NULL 
            INITIALIZE g_imay_d_t.* TO NULL 
            INITIALIZE g_imay_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imay_d[l_ac].imaystus = ''
 
 
 
            #自定義預設值
                  LET g_imay_d[l_ac].imay005 = "0"
      LET g_imay_d[l_ac].imay007 = "0"
      LET g_imay_d[l_ac].imay008 = "0"
      LET g_imay_d[l_ac].imay009 = "0"
      LET g_imay_d[l_ac].imay010 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_imay_d[l_ac].imaystus = "Y"
            LET g_imay_d[l_ac].imay006 = "N"
            LET g_imay_d[l_ac].imay018 = "1"
 
            LET g_imay_d[l_ac].imay002=g_imaa_m.imaa100
            SELECT imaa019,imaa020,imaa021,imaa022,imaa025,
                   imaa026,imaa016,imaa018
              INTO g_imay_d[l_ac].imay007,   #深
                   g_imay_d[l_ac].imay008,   #寬
                   g_imay_d[l_ac].imay009,   #高
                   g_imay_d[l_ac].imay015,   #長度單位
                   g_imay_d[l_ac].imay010,   #體積
                   g_imay_d[l_ac].imay016,   #體積單位
                   g_imay_d[l_ac].imay011,   #毛重
                   g_imay_d[l_ac].imay017    #重量單位
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_imaa_m.imaa001
            
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay015) RETURNING g_imay_d[l_ac].imay015_desc
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay016) RETURNING g_imay_d[l_ac].imay016_desc
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay017) RETURNING g_imay_d[l_ac].imay017_desc
            #end add-point
            LET g_imay_d_t.* = g_imay_d[l_ac].*     #新輸入資料
            LET g_imay_d_o.* = g_imay_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimm208_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aimm208_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imay_d[li_reproduce_target].* = g_imay_d[li_reproduce].*
 
               LET g_imay_d[li_reproduce_target].imay003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT imaa104,imaa106 INTO l_imaa104,l_imaa106
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_imaa_m.imaa001
            LET g_imay_d[l_ac].imay012 = l_imaa106
            LET g_imay_d[l_ac].imay014 = l_imaa104
            LET l_upd_imaa014 = 'N'
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
            SELECT COUNT(1) INTO l_count FROM imay_t 
             WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
 
               AND imay003 = g_imay_d[l_ac].imay003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
#160511-00040#1-s
               IF g_imay_d[l_ac].imay002 = '2' THEN
                  IF g_imaa_m.imaa109 = '1' THEN
                     IF g_imay_d[l_ac].imay005 = 1 THEN
                        CALL s_auto_barcode('1') RETURNING g_imay_d[l_ac].imay003,l_success
                     END IF
                     IF g_imay_d[l_ac].imay005 > 1 THEN
                        CALL s_auto_barcode('2') RETURNING g_imay_d[l_ac].imay003,l_success
                     END IF
                  END IF
                  IF g_imaa_m.imaa109 = '4'  THEN
                     CALL s_auto_barcode('4') RETURNING g_imay_d[l_ac].imay003,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imay_d[l_ac].imay003,l_success
                  END IF
                  IF NOT l_success THEN
                     LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  END IF
               END IF
#160511-00040#1-e
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys[2] = g_imay_d[g_detail_idx].imay003
               CALL aimm208_insert_b('imay_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_imay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimm208_b_fill()
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
               LET gs_keys[01] = g_imaa_m.imaa001
 
               LET gs_keys[gs_keys.getLength()+1] = g_imay_d_t.imay003
 
            
               #刪除同層單身
               IF NOT aimm208_delete_b('imay_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimm208_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimm208_key_delete_b(gs_keys,'imay_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimm208_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aimm208_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_imay_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imay_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaystus
            #add-point:BEFORE FIELD imaystus name="input.b.page1.imaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaystus
            
            #add-point:AFTER FIELD imaystus name="input.a.page1.imaystus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaystus
            #add-point:ON CHANGE imaystus name="input.g.page1.imaystus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay002
            #add-point:BEFORE FIELD imay002 name="input.b.page1.imay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay002
            
            #add-point:AFTER FIELD imay002 name="input.a.page1.imay002"
            IF NOT cl_null(g_imay_d[l_ac].imay002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imay_d[l_ac].imay002 != g_imay_d_t.imay002 OR g_imay_d_t.imay002 IS NULL )) THEN
                  IF p_cmd = 'a' THEN        
                     IF g_imay_d[l_ac].imay002 = '1' AND NOT cl_null(g_imay_d[l_ac].imay003) THEN
                        CALL s_chk_barcode(g_imay_d[l_ac].imay003) RETURNING g_success
                        IF g_success = 'N' THEN
                           LET g_imay_d[l_ac].imay003 = g_imay_d[l_ac].imay003
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     IF g_imay_d[l_ac].imay002 = '1' THEN
                        IF NOT cl_null(g_imay_d[l_ac].imay003) THEN
                           CALL s_chk_barcode(g_imay_d[l_ac].imay003) RETURNING g_success
                           IF g_success = 'N' THEN
                              LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF     
                     IF g_imay_d[l_ac].imay003 = '1' AND g_imay_d_t.imay002 = '2' THEN
                        LET g_imay_d[l_ac].imay003 = ""
                     END IF
                  END IF
               END IF
            END IF
            CALL aimm208_set_entry_b(l_cmd)
            CALL aimm208_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay002
            #add-point:ON CHANGE imay002 name="input.g.page1.imay002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay003
            #add-point:BEFORE FIELD imay003 name="input.b.page1.imay003"
#            LET  l_type = NULL
#            IF g_imay_d[l_ac].imay002 = '2' AND cl_null(g_imay_d[l_ac].imay003) THEN
#               CASE g_imaa_m.imaa109
#                  WHEN '1' 
#                     LET l_type = '1'
#                  WHEN '4' 
#                     LET l_type = '4'
#                  WHEN '5' 
#                     LET l_type = '5'
#               END CASE
#               CALL s_auto_barcode(l_type) RETURNING g_imay_d[l_ac].imay003,l_success
#               IF NOT l_success THEN
#                  LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
#                  NEXT FIELD CURRENT
#               END IF
#            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay003
            
            #add-point:AFTER FIELD imay003 name="input.a.page1.imay003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_imaa_m.imaa001 IS NOT NULL AND g_imay_d[g_detail_idx].imay003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imay_d[g_detail_idx].imay003 != g_imay_d_t.imay003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imay_t WHERE "||"imayent = '" ||g_enterprise|| "' AND "||"imay001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imay003 = '"||g_imay_d[g_detail_idx].imay003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL aimm208_chk_barcode(g_imay_d[l_ac].imay003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imay_d[l_ac].imay003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_imay_d[l_ac].imay002 = '1' THEN
                     CALL s_chk_barcode(g_imay_d[l_ac].imay003) RETURNING g_success
                     IF g_success = 'N' THEN
                        LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  IF NOT s_artt300_chk_imba014(g_imay_d[l_ac].imay003) THEN
                     IF NOT cl_null(g_imay_d[l_ac].imay003) THEN
                        LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     END IF
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay003
            #add-point:ON CHANGE imay003 name="input.g.page1.imay003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay004
            
            #add-point:AFTER FIELD imay004 name="input.a.page1.imay004"
            LET g_imay_d[l_ac].imay004_desc  = ' '
            DISPLAY BY NAME g_imay_d[l_ac].imay004_desc 
            IF NOT cl_null(g_imay_d[l_ac].imay004) THEN
               IF (g_imay_d[l_ac].imay004 != g_imay_d_o.imay004 OR g_imay_d_o.imay004 IS NULL ) THEN               
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay004
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay004 = g_imay_d_o.imay004
                     CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay004) RETURNING g_imay_d[l_ac].imay004_desc
                     DISPLAY BY NAME g_imay_d[l_ac].imay004_desc 
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_imay_d[l_ac].imay005 IS NULL OR g_imay_d[l_ac].imay005 = '0' THEN
                     LET g_imay_d[l_ac].imay005 = 1                
                  END IF 

                  CALL aimm208_imay005_chk() RETURNING l_success,l_imay005
                  IF l_success THEN  #商品的多條碼包裝單位已存在時，預帶申請單中的同包裝單位件裝數
                     LET g_imay_d[l_ac].imay005 = l_imay005
                  ELSE               #商品多條碼包裝單位不存在時，預帶轉換率中的包裝單位件裝數 
                     CALL aimm208_imay005_default()
                  END IF
                                       
                  IF NOT aimm208_imay005_chk_1() THEN
                    INITIALIZE g_errparam TO NULL
                    CALL cl_getmsg('aim-00254',g_lang) RETURNING l_msg
                    LET g_errparam.code = 'art-00591'
                    LET g_errparam.extend = l_msg CLIPPED,g_imay_d[l_ac].imay005
                    LET g_errparam.popup = TRUE
                    LET g_errparam.replace[1] = g_imaa_m.imaa001
                    LET g_errparam.replace[2] = g_imay_d[l_ac].imay004
                    LET g_errparam.replace[3] = g_imay_d_o.imay005                
                    CALL cl_err()
                    
                    LET g_imay_d[l_ac].imay004 = g_imay_d_o.imay004
                    CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay004) RETURNING g_imay_d[l_ac].imay004_desc
                    DISPLAY BY NAME g_imay_d[l_ac].imay004_desc 
                    NEXT FIELD CURRENT            
                  END IF                                    
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay004) RETURNING g_imay_d[l_ac].imay004_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay004_desc 
            LET g_imay_d_o.imay004 = g_imay_d[l_ac].imay004
            LET g_imay_d_o.imay005 = g_imay_d[l_ac].imay005
            CALL aimm208_set_entry_b(l_cmd)
            CALL aimm208_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay004
            #add-point:BEFORE FIELD imay004 name="input.b.page1.imay004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay004
            #add-point:ON CHANGE imay004 name="input.g.page1.imay004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay005
            END IF 
 
 
 
            #add-point:AFTER FIELD imay005 name="input.a.page1.imay005"
            IF NOT cl_null(g_imay_d[l_ac].imay005) THEN
               IF NOT aimm208_imay005_chk_1() THEN
                 INITIALIZE g_errparam TO NULL
                 CALL cl_getmsg('aim-00254',g_lang) RETURNING l_msg
                 LET g_errparam.code = 'art-00591'
                 LET g_errparam.extend = l_msg CLIPPED,g_imay_d[l_ac].imay005
                 LET g_errparam.popup = TRUE
                 LET g_errparam.replace[1] = g_imaa_m.imaa001
                 LET g_errparam.replace[2] = g_imay_d[l_ac].imay004
                 LET g_errparam.replace[3] = g_imay_d_o.imay005                
                 CALL cl_err()
                 
                 LET g_imay_d[l_ac].imay005 = g_imay_d_o.imay005
                 NEXT FIELD CURRENT            
               END IF        
            END IF 
            LET g_imay_d_o.imay005 = g_imay_d[l_ac].imay005

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay005
            #add-point:BEFORE FIELD imay005 name="input.b.page1.imay005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay005
            #add-point:ON CHANGE imay005 name="input.g.page1.imay005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay006
            #add-point:BEFORE FIELD imay006 name="input.b.page1.imay006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay006
            
            #add-point:AFTER FIELD imay006 name="input.a.page1.imay006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay006
            #add-point:ON CHANGE imay006 name="input.g.page1.imay006"
            IF NOT cl_null(g_imay_d[l_ac].imay006)
               AND (g_imay_d[l_ac].imay006 != g_imay_d_t.imay006 OR g_imay_d_t.imay006 IS NULL) THEN
               
               CALL aimm208_imay006_chk() RETURNING l_success,l_upd_imaa014
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay018
            #add-point:BEFORE FIELD imay018 name="input.b.page1.imay018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay018
            
            #add-point:AFTER FIELD imay018 name="input.a.page1.imay018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay018
            #add-point:ON CHANGE imay018 name="input.g.page1.imay018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay007
            END IF 
 
 
 
            #add-point:AFTER FIELD imay007 name="input.a.page1.imay007"
            IF NOT cl_null(g_imay_d[l_ac].imay007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay007
            #add-point:BEFORE FIELD imay007 name="input.b.page1.imay007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay007
            #add-point:ON CHANGE imay007 name="input.g.page1.imay007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay008
            END IF 
 
 
 
            #add-point:AFTER FIELD imay008 name="input.a.page1.imay008"
            IF NOT cl_null(g_imay_d[l_ac].imay008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay008
            #add-point:BEFORE FIELD imay008 name="input.b.page1.imay008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay008
            #add-point:ON CHANGE imay008 name="input.g.page1.imay008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay009
            END IF 
 
 
 
            #add-point:AFTER FIELD imay009 name="input.a.page1.imay009"
            IF NOT cl_null(g_imay_d[l_ac].imay009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay009
            #add-point:BEFORE FIELD imay009 name="input.b.page1.imay009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay009
            #add-point:ON CHANGE imay009 name="input.g.page1.imay009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay015
            
            #add-point:AFTER FIELD imay015 name="input.a.page1.imay015"
            LET g_imay_d[l_ac].imay015_desc = ''
            IF NOT cl_null(g_imay_d[l_ac].imay015) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imay_d[l_ac].imay015 != g_imay_d_t.imay015 OR g_imay_d_t.imay015 IS NULL ) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay015
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay015 = g_imay_d_t.imay015
                     CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay015) RETURNING g_imay_d[l_ac].imay015_desc
                     DISPLAY BY NAME g_imay_d[l_ac].imay015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay015) RETURNING g_imay_d[l_ac].imay015_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay015_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay015
            #add-point:BEFORE FIELD imay015 name="input.b.page1.imay015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay015
            #add-point:ON CHANGE imay015 name="input.g.page1.imay015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay010
            END IF 
 
 
 
            #add-point:AFTER FIELD imay010 name="input.a.page1.imay010"
            IF NOT cl_null(g_imay_d[l_ac].imay010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay010
            #add-point:BEFORE FIELD imay010 name="input.b.page1.imay010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay010
            #add-point:ON CHANGE imay010 name="input.g.page1.imay010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay016
            
            #add-point:AFTER FIELD imay016 name="input.a.page1.imay016"
            LET g_imay_d[l_ac].imay016_desc = ''
            IF NOT cl_null(g_imay_d[l_ac].imay016) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imay_d[l_ac].imay016 != g_imay_d_t.imay016 OR g_imay_d_t.imay016 IS NULL ) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay016
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay016 = g_imay_d_t.imay016
                     CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay016) RETURNING g_imay_d[l_ac].imay016_desc
                     DISPLAY BY NAME g_imay_d[l_ac].imay016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay016) RETURNING g_imay_d[l_ac].imay016_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay016_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay016
            #add-point:BEFORE FIELD imay016 name="input.b.page1.imay016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay016
            #add-point:ON CHANGE imay016 name="input.g.page1.imay016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imay_d[l_ac].imay011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay011
            END IF 
 
 
 
            #add-point:AFTER FIELD imay011 name="input.a.page1.imay011"
            IF NOT cl_null(g_imay_d[l_ac].imay011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay011
            #add-point:BEFORE FIELD imay011 name="input.b.page1.imay011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay011
            #add-point:ON CHANGE imay011 name="input.g.page1.imay011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay017
            
            #add-point:AFTER FIELD imay017 name="input.a.page1.imay017"
            LET g_imay_d[l_ac].imay017_desc = ''
            IF NOT cl_null(g_imay_d[l_ac].imay017) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imay_d[l_ac].imay017 != g_imay_d_t.imay017 OR g_imay_d_t.imay017 IS NULL ) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imay_d[l_ac].imay017
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_imay_d[l_ac].imay017 = g_imay_d_t.imay017
                     CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay017) RETURNING g_imay_d[l_ac].imay017_desc
                     DISPLAY BY NAME g_imay_d[l_ac].imay017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay017) RETURNING g_imay_d[l_ac].imay017_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay017_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay017
            #add-point:BEFORE FIELD imay017 name="input.b.page1.imay017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay017
            #add-point:ON CHANGE imay017 name="input.g.page1.imay017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay012
            #add-point:BEFORE FIELD imay012 name="input.b.page1.imay012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay012
            
            #add-point:AFTER FIELD imay012 name="input.a.page1.imay012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay012
            #add-point:ON CHANGE imay012 name="input.g.page1.imay012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay013
            #add-point:BEFORE FIELD imay013 name="input.b.page1.imay013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay013
            
            #add-point:AFTER FIELD imay013 name="input.a.page1.imay013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay013
            #add-point:ON CHANGE imay013 name="input.g.page1.imay013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay014
            #add-point:BEFORE FIELD imay014 name="input.b.page1.imay014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay014
            
            #add-point:AFTER FIELD imay014 name="input.a.page1.imay014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay014
            #add-point:ON CHANGE imay014 name="input.g.page1.imay014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaystus
            #add-point:ON ACTION controlp INFIELD imaystus name="input.c.page1.imaystus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay002
            #add-point:ON ACTION controlp INFIELD imay002 name="input.c.page1.imay002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay003
            #add-point:ON ACTION controlp INFIELD imay003 name="input.c.page1.imay003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay004
            #add-point:ON ACTION controlp INFIELD imay004 name="input.c.page1.imay004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imay_d[l_ac].imay004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imay_d[l_ac].imay004 = g_qryparam.return1              

            DISPLAY g_imay_d[l_ac].imay004 TO imay004              #
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay004) RETURNING g_imay_d[l_ac].imay004_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay004_desc
            NEXT FIELD imay004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.imay005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay005
            #add-point:ON ACTION controlp INFIELD imay005 name="input.c.page1.imay005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay006
            #add-point:ON ACTION controlp INFIELD imay006 name="input.c.page1.imay006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay018
            #add-point:ON ACTION controlp INFIELD imay018 name="input.c.page1.imay018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay007
            #add-point:ON ACTION controlp INFIELD imay007 name="input.c.page1.imay007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay008
            #add-point:ON ACTION controlp INFIELD imay008 name="input.c.page1.imay008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay009
            #add-point:ON ACTION controlp INFIELD imay009 name="input.c.page1.imay009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay015
            #add-point:ON ACTION controlp INFIELD imay015 name="input.c.page1.imay015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imay_d[l_ac].imay015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imay_d[l_ac].imay015 = g_qryparam.return1              

            DISPLAY g_imay_d[l_ac].imay015 TO imay015              #
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay015) RETURNING g_imay_d[l_ac].imay015_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay015_desc            
            NEXT FIELD imay015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.imay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay010
            #add-point:ON ACTION controlp INFIELD imay010 name="input.c.page1.imay010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay016
            #add-point:ON ACTION controlp INFIELD imay016 name="input.c.page1.imay016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imay_d[l_ac].imay016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imay_d[l_ac].imay016 = g_qryparam.return1              

            DISPLAY g_imay_d[l_ac].imay016 TO imay016              #
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay016) RETURNING g_imay_d[l_ac].imay016_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay016_desc
            NEXT FIELD imay016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.imay011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay011
            #add-point:ON ACTION controlp INFIELD imay011 name="input.c.page1.imay011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay017
            #add-point:ON ACTION controlp INFIELD imay017 name="input.c.page1.imay017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imay_d[l_ac].imay017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imay_d[l_ac].imay017 = g_qryparam.return1              

            DISPLAY g_imay_d[l_ac].imay017 TO imay017              #
            CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay017) RETURNING g_imay_d[l_ac].imay017_desc
            DISPLAY BY NAME g_imay_d[l_ac].imay017_desc
            NEXT FIELD imay017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.imay012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay012
            #add-point:ON ACTION controlp INFIELD imay012 name="input.c.page1.imay012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay013
            #add-point:ON ACTION controlp INFIELD imay013 name="input.c.page1.imay013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imay014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay014
            #add-point:ON ACTION controlp INFIELD imay014 name="input.c.page1.imay014"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imay_d[l_ac].* = g_imay_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimm208_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_imay_d[l_ac].imay003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imay_d[l_ac].* = g_imay_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
#160511-00040#1-s
               LET  l_type = NULL
               IF g_imay_d[l_ac].imay002 = '2' AND g_imay_d_t.imay002 = '1' THEN
                  IF g_imaa_m.imaa109 = '1' THEN
                     IF g_imay_d[l_ac].imay005 = 1 THEN
                        CALL s_auto_barcode('1') RETURNING g_imay_d[l_ac].imay003,l_success
                     END IF
                     IF g_imay_d[l_ac].imay005 > 1 THEN
                        CALL s_auto_barcode('2') RETURNING g_imay_d[l_ac].imay003,l_success
                     END IF
                  END IF
                  IF g_imaa_m.imaa109 = '4'  THEN
                     CALL s_auto_barcode('4') RETURNING g_imay_d[l_ac].imay003,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imay_d[l_ac].imay003,l_success
                  END IF
                  IF NOT l_success THEN
                     LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
#160511-00040#1-e
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL aimm208_imay_t_mask_restore('restore_mask_o')
      
               UPDATE imay_t SET (imay001,imaystus,imay002,imay003,imay004,imay005,imay006,imay018,imay007, 
                   imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014) = (g_imaa_m.imaa001, 
                   g_imay_d[l_ac].imaystus,g_imay_d[l_ac].imay002,g_imay_d[l_ac].imay003,g_imay_d[l_ac].imay004, 
                   g_imay_d[l_ac].imay005,g_imay_d[l_ac].imay006,g_imay_d[l_ac].imay018,g_imay_d[l_ac].imay007, 
                   g_imay_d[l_ac].imay008,g_imay_d[l_ac].imay009,g_imay_d[l_ac].imay015,g_imay_d[l_ac].imay010, 
                   g_imay_d[l_ac].imay016,g_imay_d[l_ac].imay011,g_imay_d[l_ac].imay017,g_imay_d[l_ac].imay012, 
                   g_imay_d[l_ac].imay013,g_imay_d[l_ac].imay014)
                WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001 
 
                  AND imay003 = g_imay_d_t.imay003 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imay_d[l_ac].* = g_imay_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imay_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imay_d[l_ac].* = g_imay_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys_bak[1] = g_imaa001_t
               LET gs_keys[2] = g_imay_d[g_detail_idx].imay003
               LET gs_keys_bak[2] = g_imay_d_t.imay003
               CALL aimm208_update_b('imay_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aimm208_imay_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_imay_d[g_detail_idx].imay003 = g_imay_d_t.imay003 
 
                  ) THEN
                  LET gs_keys[01] = g_imaa_m.imaa001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_imay_d_t.imay003
 
                  CALL aimm208_key_update_b(gs_keys,'imay_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imay_d_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imay_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
#            IF NOT cl_null(g_imay_d[l_ac].imay004) THEN
#               SELECT imaa104 INTO l_imaa104
#                 FROM imaa_t
#                WHERE imaaent = g_enterprise
#                  AND imaa001 = g_imaa_m.imaa001
#                  
#               LET l_imaymoddt = cl_get_current()
#               LET l_cnt = 0
#               SELECT COUNT(*) INTO l_cnt FROM imad_t
#                WHERE imadent = g_enterprise
#                  AND imad001 = g_imaa_m.imaa001
#                  AND imad002 = l_imaa104
#                  AND imad004 = g_imay_d[l_ac].imay004
##                  AND imad004 =l_imay004
#               IF l_cnt = 0 THEN
#                  INSERT INTO imad_t(imadent,imad001,imad002,imad003,
#                                     imad004,imad005,imadstus,imadownid,
#                                     imadowndp,imadcrtid,imadcrtdt,imadcrtdp)
#                       VALUES(g_enterprise,g_imaa_m.imaa001,l_imaa104,g_imay_d[l_ac].imay005,
#                              g_imay_d[l_ac].imay004,1,'Y',g_user,                              
##                              l_imay004,1,'Y',g_imay2_d[l_ac].imayownid,
#                              g_dept,g_user,l_imaymoddt,g_dept) 
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = 'Ins imad_t'
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                  END IF  
#               ELSE
#                  UPDATE imad_t SET  imad003   = g_imay_d[l_ac].imay005,
#                                     imad005   = 1 ,
#                                     imadstus  = 'Y',
#                                     imadmodid = g_user,
#                                     imadmoddt = l_imaymoddt
#                   WHERE imadent = g_enterprise
#                     AND imad001 = g_imaa_m.imaa001
#                     AND imad002 = l_imaa104
#                     AND imad004 = g_imay_d[l_ac].imay004
##                     AND imad004 =l_imay004
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = 'Upd imad_t'
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                  END IF  
#               END IF
#               #
#               LET l_cnt = 0
#               SELECT COUNT(*) INTO l_cnt FROM imad_t
#                WHERE imadent = g_enterprise
#                  AND imad001 = g_imaa_m.imaa001
#                  AND imad002 = g_imay_d[l_ac].imay004
##                  AND imad002 = l_imay004
#                  AND imad004 = l_imaa104
#               IF l_cnt = 0 THEN
#                  INSERT INTO imad_t(imadent,imad001,imad002,imad003,
#                                     imad004,imad005,imadstus,imadownid,
#                                     imadowndp,imadcrtid,imadcrtdt,imadcrtdp)
#                       VALUES(g_enterprise,g_imaa_m.imaa001,g_imay_d[l_ac].imay004,1,
##                       VALUES(g_enterprise,g_imaa_m.imaa001,l_imay004,1,
#                              l_imaa104,g_imay_d[l_ac].imay005,'Y',g_user,
#                              g_dept,g_user,l_imaymoddt,g_dept) 
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = 'Ins imad_t'
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                  END IF  
#               ELSE
#                  UPDATE imad_t SET  imad003   = 1,
#                                     imad005   = g_imay_d[l_ac].imay005,
#                                     imadstus  = 'Y',
#                                     imadmodid = g_user,
#                                     imadmoddt = l_imaymoddt
#                   WHERE imadent = g_enterprise
#                     AND imad001 = g_imaa_m.imaa001
#                     AND imad002 = g_imay_d[l_ac].imay004
##                     AND imad002 =l_imay004
#                     AND imad004 = l_imaa104
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = 'Upd imad_t'
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                  END IF  
#               END IF
#               CALL aimm208_imay013_default() RETURNING l_success       #依包裝單位和銷售計價單位取換算率
#            END IF
            #end add-point
            CALL aimm208_unlock_b("imay_t","'1'")
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
               LET g_imay_d[li_reproduce_target].* = g_imay_d[li_reproduce].*
 
               LET g_imay_d[li_reproduce_target].imay003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imay_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imay_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aimm208.input.other" >}
      
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
            NEXT FIELD imaa001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imaystus
 
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
 
{<section id="aimm208.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aimm208_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aimm208_b_fill() #單身填充
      CALL aimm208_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimm208_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaa111
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='205' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaa111_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_imaa_m.imaa111_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaa112
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaa112_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaa112_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaa113
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaa113_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_imaa_m.imaa113_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaaownid_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaaowndp_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaacrtid_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaacrtdp_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaamodid_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_imaa_m.imaamodid_desc


   #end add-point
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aimm208_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
       g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
       g_imaa_m.imaa010_desc,g_imaa_m.l_s1,g_imaa_m.imaa108,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
       g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt 
 
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_imay_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aimm208_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL aimm208_imaa_desc()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aimm208_detail_show()
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
 
{<section id="aimm208.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimm208_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE imaa_t.imaa001 
   DEFINE l_oldno     LIKE imaa_t.imaa001 
 
   DEFINE l_master    RECORD LIKE imaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE imay_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_imaa001_t = g_imaa_m.imaa001
 
    
   LET g_imaa_m.imaa001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaa_m.imaaownid = g_user
      LET g_imaa_m.imaaowndp = g_dept
      LET g_imaa_m.imaacrtid = g_user
      LET g_imaa_m.imaacrtdp = g_dept 
      LET g_imaa_m.imaacrtdt = cl_get_current()
      LET g_imaa_m.imaamodid = g_user
      LET g_imaa_m.imaamoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   CALL aimm208_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_imaa_m.* TO NULL
      INITIALIZE g_imay_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aimm208_show()
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
   CALL aimm208_set_act_visible()   
   CALL aimm208_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimm208_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aimm208_idx_chk()
   
   LET g_data_owner = g_imaa_m.imaaownid      
   LET g_data_dept  = g_imaa_m.imaaowndp
   
   #功能已完成,通報訊息中心
   CALL aimm208_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aimm208_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE imay_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aimm208_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imay_t
    WHERE imayent = g_enterprise AND imay001 = g_imaa001_t
 
    INTO TEMP aimm208_detail
 
   #將key修正為調整後   
   UPDATE aimm208_detail 
      #更新key欄位
      SET imay001 = g_imaa_m.imaa001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, imaystus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO imay_t SELECT * FROM aimm208_detail
   
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
   DROP TABLE aimm208_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aimm208_delete()
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
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aimm208_cl USING g_enterprise,g_imaa_m.imaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimm208_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimm208_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimm208_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaa108, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa114,g_imaa_m.imaa143,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc, 
       g_imaa_m.imaa114_desc,g_imaa_m.imaa143_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aimm208_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aimm208_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   CALL aimm208_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimm208_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_imaa001_t = g_imaa_m.imaa001
 
 
      DELETE FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 = g_imaa_m.imaa001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_imaa_m.imaa001,":",SQLERRMESSAGE  
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
      
      DELETE FROM imay_t
       WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aimm208_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_imay_d.clear() 
 
     
      CALL aimm208_ui_browser_refresh()  
      #CALL aimm208_ui_headershow()  
      #CALL aimm208_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aimm208_browser_fill("")
         CALL aimm208_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimm208_cl
 
   #功能已完成,通報訊息中心
   CALL aimm208_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aimm208.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aimm208_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_imay_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aimm208_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imaystus,imay002,imay003,imay004,imay005,imay006,imay018,imay007, 
             imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014 ,t1.oocal003 , 
             t2.oocal003 ,t3.oocal003 FROM imay_t",   
                     " INNER JOIN imaa_t ON imaaent = " ||g_enterprise|| " AND imaa001 = imay001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=imay004 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=imay015 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=imay016 AND t3.oocal002='"||g_dlang||"' ",
 
                     " WHERE imayent=? AND imay001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imay_t.imay003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimm208_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aimm208_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_imaa_m.imaa001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_imaa_m.imaa001 INTO g_imay_d[l_ac].imaystus,g_imay_d[l_ac].imay002, 
          g_imay_d[l_ac].imay003,g_imay_d[l_ac].imay004,g_imay_d[l_ac].imay005,g_imay_d[l_ac].imay006, 
          g_imay_d[l_ac].imay018,g_imay_d[l_ac].imay007,g_imay_d[l_ac].imay008,g_imay_d[l_ac].imay009, 
          g_imay_d[l_ac].imay015,g_imay_d[l_ac].imay010,g_imay_d[l_ac].imay016,g_imay_d[l_ac].imay011, 
          g_imay_d[l_ac].imay017,g_imay_d[l_ac].imay012,g_imay_d[l_ac].imay013,g_imay_d[l_ac].imay014, 
          g_imay_d[l_ac].imay004_desc,g_imay_d[l_ac].imay015_desc,g_imay_d[l_ac].imay016_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL s_desc_get_unit_desc(g_imay_d[l_ac].imay017) RETURNING g_imay_d[l_ac].imay017_desc
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
   
   CALL g_imay_d.deleteElement(g_imay_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aimm208_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_imay_d.getLength()
      LET g_imay_d_mask_o[l_ac].* =  g_imay_d[l_ac].*
      CALL aimm208_imay_t_mask()
      LET g_imay_d_mask_n[l_ac].* =  g_imay_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aimm208_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM imay_t
       WHERE imayent = g_enterprise AND
         imay001 = ps_keys_bak[1] AND imay003 = ps_keys_bak[2]
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
         CALL g_imay_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aimm208_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO imay_t
                  (imayent,
                   imay001,
                   imay003
                   ,imaystus,imay002,imay004,imay005,imay006,imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imay_d[g_detail_idx].imaystus,g_imay_d[g_detail_idx].imay002,g_imay_d[g_detail_idx].imay004, 
                       g_imay_d[g_detail_idx].imay005,g_imay_d[g_detail_idx].imay006,g_imay_d[g_detail_idx].imay018, 
                       g_imay_d[g_detail_idx].imay007,g_imay_d[g_detail_idx].imay008,g_imay_d[g_detail_idx].imay009, 
                       g_imay_d[g_detail_idx].imay015,g_imay_d[g_detail_idx].imay010,g_imay_d[g_detail_idx].imay016, 
                       g_imay_d[g_detail_idx].imay011,g_imay_d[g_detail_idx].imay017,g_imay_d[g_detail_idx].imay012, 
                       g_imay_d[g_detail_idx].imay013,g_imay_d[g_detail_idx].imay014)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imay_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aimm208_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imay_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aimm208_imay_t_mask_restore('restore_mask_o')
               
      UPDATE imay_t 
         SET (imay001,
              imay003
              ,imaystus,imay002,imay004,imay005,imay006,imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imay_d[g_detail_idx].imaystus,g_imay_d[g_detail_idx].imay002,g_imay_d[g_detail_idx].imay004, 
                  g_imay_d[g_detail_idx].imay005,g_imay_d[g_detail_idx].imay006,g_imay_d[g_detail_idx].imay018, 
                  g_imay_d[g_detail_idx].imay007,g_imay_d[g_detail_idx].imay008,g_imay_d[g_detail_idx].imay009, 
                  g_imay_d[g_detail_idx].imay015,g_imay_d[g_detail_idx].imay010,g_imay_d[g_detail_idx].imay016, 
                  g_imay_d[g_detail_idx].imay011,g_imay_d[g_detail_idx].imay017,g_imay_d[g_detail_idx].imay012, 
                  g_imay_d[g_detail_idx].imay013,g_imay_d[g_detail_idx].imay014) 
         WHERE imayent = g_enterprise AND imay001 = ps_keys_bak[1] AND imay003 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imay_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimm208_imay_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aimm208.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aimm208_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aimm208.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aimm208_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aimm208.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aimm208_lock_b(ps_table,ps_page)
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
   #CALL aimm208_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "imay_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aimm208_bcl USING g_enterprise,
                                       g_imaa_m.imaa001,g_imay_d[g_detail_idx].imay003     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimm208_bcl:",SQLERRMESSAGE 
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
 
{<section id="aimm208.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aimm208_unlock_b(ps_table,ps_page)
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
      CLOSE aimm208_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimm208_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("imaa001",TRUE)
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
 
{<section id="aimm208.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimm208_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imaa001",FALSE)
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
   IF g_site <> 'ALL' THEN
      CALL s_aooi090_set_no_entry('2')
   END IF   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aimm208_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("imay003,imay005",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aimm208.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aimm208_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa104  LIKE imaa_t.imaa104
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF p_cmd = 'u' THEN
      IF g_imay_d[l_ac].imay002 = '2' AND NOT cl_null(g_imay_d[l_ac].imay003) THEN
         CALL cl_set_comp_entry("imay005",FALSE)
      END IF
   END IF
   IF g_imay_d[l_ac].imay002 = '2' THEN
      CALL cl_set_comp_entry("imay003",FALSE)
   END IF
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("imay003",FALSE)
   END IF
   
   SELECT imaa104 INTO l_imaa104
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_imaa_m.imaa001
      
   IF g_imay_d[l_ac].imay004 = l_imaa104 THEN
      CALL cl_set_comp_entry("imay005",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aimm208.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimm208_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible('modify,modify_detail',TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimm208_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_imaastus LIKE imaa_t.imaastus
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   LET l_imaastus = ''
   SELECT imaastus INTO l_imaastus
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_imaa_m.imaa001
   IF l_imaastus NOT MATCHES "[N]" THEN
      CALL cl_set_act_visible('modify,modify_detail',FALSE)    
   END IF   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aimm208_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aimm208_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimm208_default_search()
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
   DEFINE l_wc1  STRING
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " imaa001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " imaa001 = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "imaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imay_t" 
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
#   IF NOT cl_null(g_argv[01]) THEN
#      LET g_wc = g_wc , " AND imaesite = '", g_argv[01], "' "
#   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimm208.state_change" >}
   
 
{</section>}
 
{<section id="aimm208.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aimm208_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imay_d.getLength() THEN
         LET g_detail_idx = g_imay_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imay_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imay_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aimm208_b_fill2(pi_idx)
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
   
   CALL aimm208_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aimm208_fill_chk(ps_idx)
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
 
{<section id="aimm208.status_show" >}
PRIVATE FUNCTION aimm208_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimm208.mask_functions" >}
&include "erp/aim/aimm208_mask.4gl"
 
{</section>}
 
{<section id="aimm208.signature" >}
   
 
{</section>}
 
{<section id="aimm208.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimm208_set_pk_array()
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
   LET g_pk_array[1].values = g_imaa_m.imaa001
   LET g_pk_array[1].column = 'imaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimm208.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aimm208.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimm208_msgcentre_notify(lc_state)
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
   CALL aimm208_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimm208.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimm208_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimm208.other_function" readonly="Y" >}
#+ display only 欄位抓取資料
PRIVATE FUNCTION aimm208_imaa_desc()
   IF cl_null(g_imaa_m.imaa001) THEN
      LET g_imaa_m.imaa002 = ""
      LET g_imaa_m.imaa003 = ""
      LET g_imaa_m.imaa004 = ""
      LET g_imaa_m.imaa005 = ""
      LET g_imaa_m.imaa006 = ""
      LET g_imaa_m.imaa009 = ""
      LET g_imaa_m.imaa010 = ""
      LET g_imaa_m.imaa003_desc = ""
      LET g_imaa_m.imaa005_desc = ""
      LET g_imaa_m.imaa006_desc = ""
      LET g_imaa_m.imaa009_desc = ""
      LET g_imaa_m.imaa010_desc = ""
      LET g_imaa_m.l_s1 = ""
      LET g_imaa_m.imaal003 = ""
      LET g_imaa_m.imaal004 = ""
      LET g_imaa_m.imaal005 = ""
               
   ELSE
      SELECT imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010
        INTO g_imaa_m.imaa002,g_imaa_m.imaa009,g_imaa_m.imaa003,
             g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,
             g_imaa_m.imaa010
        FROM imaa_t
        WHERE imaa001 = g_imaa_m.imaa001
          AND imaaent = g_enterprise

       SELECT imaastus INTO g_imaa_m.l_s1 FROM imaa_t
        WHERE imaaent = g_enterprise  AND imaa001 = g_imaa_m.imaa001
      END IF    
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaa_m.imaa001
      CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004,imaal005 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_imaa_m.imaal003 = g_rtn_fields[1] 
      LET g_imaa_m.imaal004 = g_rtn_fields[2] 
      LET g_imaa_m.imaal005 = g_rtn_fields[3] 
      DISPLAY BY NAME g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaa_m.imaa009
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaa_m.imaa009_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_imaa_m.imaa009_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaa_m.imaa003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaa_m.imaa003_desc =  g_rtn_fields[1]
      DISPLAY BY NAME g_imaa_m.imaa003_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaa_m.imaa006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaa_m.imaa006_desc = g_rtn_fields[1] 
      DISPLAY BY NAME g_imaa_m.imaa006_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaa_m.imaa010
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaa_m.imaa010_desc = g_rtn_fields[1] 
      DISPLAY BY NAME g_imaa_m.imaa010_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaa_m.imaa005
      CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaa_m.imaa005_desc =  g_rtn_fields[1] 
      DISPLAY BY NAME g_imaa_m.imaa005_desc 
     
      DISPLAY BY NAME g_imaa_m.imaa002,g_imaa_m.imaa009,g_imaa_m.imaa003,g_imaa_m.imaa004,
                      g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.l_s1
      DISPLAY BY NAME g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005,
                      g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc
END FUNCTION
################################################################################
# Descriptions...: 檢查aooi090是否設置對應欄位
# Date & Author..: 2016/05/18 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm208_chk_ooeh(p_ooeh002)
  DEFINE p_ooeh002        LIKE ooeh_t.ooeh002
  DEFINE l_n              LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooeh_t
    WHERE ooehent = g_enterprise
      AND ooeh001 = '1'
      AND ooeh002 = p_ooeh002
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 檢查是否有多條碼的包裝單位已相同
# Memo...........:
# Usage..........: CALL aimm208_imay005_chk()
#                  RETURNING r_success,l_imay005
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
#                  l_imay005       件裝數
# Date & Author..: 2016/05/18 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm208_imay005_chk()
   DEFINE l_cnt        LIKE type_t.num5 
   DEFINE l_imay005    LIKE imay_t.imay005
   DEFINE r_success    LIKE type_t.num5

   LET l_imay005 = 0
   LET l_cnt = 0
   LET r_success = FALSE
   SELECT COUNT(*) INTO l_cnt 
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 = g_imaa_m.imaa001
      AND imay004 = g_imay_d[l_ac].imay004      
      
   IF l_cnt != 0 THEN
      SELECT DISTINCT imay005 INTO l_imay005
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_imaa_m.imaa001
         AND imay004 = g_imay_d[l_ac].imay004       
      LET r_success = TRUE
   END IF
   
   RETURN r_success,l_imay005 
END FUNCTION
################################################################################
# Descriptions...: 依包裝單位帶值
# Usage..........: CALL aimm208_imay005_default()
# Date & Author..: 2016/05/18 By shiun
################################################################################
PRIVATE FUNCTION aimm208_imay005_default()
   DEFINE l_unit_o   LIKE imay_t.imay003
   DEFINE l_num_o    LIKE imay_t.imay004
   DEFINE l_unit_t   LIKE imay_t.imay003
   DEFINE l_num_t    LIKE imay_t.imay004
   DEFINE l_imaa104  LIKE imaa_t.imaa104
   DEFINE l_imaa105  LIKE imaa_t.imaa105
   
   SELECT imaa104,imaa105 INTO l_imaa104,l_imaa105
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_imaa_m.imaa001   
   
   IF g_imay_d[l_ac].imay004 = l_imaa105 THEN
      LET g_imay_d[l_ac].imay005 = 1
      RETURN
   END IF 
   
   LET g_imay_d[l_ac].imay014 = l_imaa104

   LET l_unit_o = ''   LET l_num_o = ''
   LET l_unit_t = ''   LET l_num_t = ''
   
   SELECT imad002,imad003,imad004,imad005
     INTO l_unit_o,l_num_o,l_unit_t,l_num_t
     FROM imad_t
    WHERE imadent = g_enterprise
      AND imad001 = g_imaa_m.imaa001
      AND imad002 = l_imaa104
      AND imad004 = g_imay_d[l_ac].imay004
      AND imadstus = 'Y'
   IF SQLCA.sqlcode = 100 THEN
      LET l_unit_o = ''   LET l_num_o = ''
      LET l_unit_t = ''   LET l_num_t = ''
      SELECT imad002,imad003,imad004,imad005
        INTO l_unit_t,l_num_t,l_unit_o,l_num_o
        FROM imad_t
       WHERE imadent = g_enterprise
         AND imad001 = g_imaa_m.imaa001
         AND imad002 = g_imay_d[l_ac].imay004
         AND imad004 = l_imaa104
         AND imadstus = 'Y'
   END IF
   
   IF NOT cl_null(l_unit_o) AND NOT cl_null(l_num_o) AND
      NOT cl_null(l_unit_t) AND NOT cl_null(l_num_t) THEN
      LET l_num_o = l_num_o / l_num_t
      LET g_imay_d[l_ac].imay005 = l_num_o
   END IF   
END FUNCTION
################################################################################
# Descriptions...: 檢查多條碼中的包裝單位是否已存在，且輸入的件裝數不等於已存在的件裝數
# Memo...........:
# Usage..........: CALL aimm208_imay005_chk_1()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/05/18 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm208_imay005_chk_1()
   DEFINE l_cnt        LIKE type_t.num5 
   DEFINE r_success    LIKE type_t.num5

   LET l_cnt = 0
   LET r_success = TRUE
   SELECT COUNT(*) INTO l_cnt 
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 = g_imaa_m.imaa001
      AND imay004 = g_imay_d[l_ac].imay004 
      AND imay005!= g_imay_d[l_ac].imay005      
      AND COALESCE(imay003,'-1') != COALESCE(g_imay_d[l_ac].imay003,'-1')   ##150703 pomelo add      
   IF l_cnt != 0 THEN     
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 主要條碼校驗
# Memo...........:
# Usage..........: CALL aimm208_imay006_chk()
#                  RETURNING r_success,r_upd_imaa014
# Return code....: r_success      校驗結果
#                  r_upd_imaa014  是否更新料件主檔的產品條碼  
# Date & Author..: 2016/05/18 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm208_imay006_chk()
DEFINE r_success      LIKE type_t.num5
   DEFINE r_upd_imaa014  LIKE type_t.chr1
   DEFINE l_m_barcode    LIKE imay_t.imay003
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_imaa104  LIKE imaa_t.imaa104
   
   LET r_success = TRUE
   LET r_upd_imaa014 = 'N'
   LET l_m_barcode = NULL
   
   SELECT imaa104 INTO l_imaa104
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_imaa_m.imaa001 
   
   IF g_imay_d[l_ac].imay006 = 'Y' THEN
       IF g_imay_d[l_ac].imaystus = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00033'
         LET g_errparam.extend = g_imay_d[l_ac].imay006
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_imay_d[l_ac].imay006 = 'N'
         LET r_success = FALSE
         RETURN r_success,r_upd_imaa014 
      END IF

      IF g_imay_d[l_ac].imay004 <> l_imaa104 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.columns[1] = "lbl_imay004"
         LET g_errparam.values[1] = g_imay_d[l_ac].imay004
         LET g_errparam.columns[2] = "lbl_imaa104"
         LET g_errparam.values[2] = l_imaa104
         LET g_errparam.code   = "art-00401" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET g_imay_d[l_ac].imay006 = 'N'
         LET r_success = FALSE
         RETURN r_success,r_upd_imaa014          
      END IF

      SELECT imay003 INTO l_m_barcode
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_imaa_m.imaa001
         AND imay006 = 'Y'
         AND imaystus = 'Y'
      
      IF cl_null(l_m_barcode) 
         OR (NOT cl_null(l_m_barcode) AND g_imay_d[l_ac].imay003 <> l_m_barcode) THEN
         IF cl_ask_confirm('art-00026') THEN
            UPDATE imay_t SET imay006 = 'N'
             WHERE imay001 = g_imaa_m.imaa001
               AND imay003 != g_imay_d[l_ac].imay003
               AND imay006 = 'Y'
               AND imayent = g_enterprise
            FOR l_i = 1 TO g_imay_d.getLength()
               IF l_i != l_ac THEN
                  LET g_imay_d[l_i].imay006 = 'N'
               END IF
            END FOR
                     
            LET r_upd_imaa014 = 'Y'
         ELSE
            LET g_imay_d[l_ac].imay006 = 'N'
         END IF         
      END IF
   END IF
   
   RETURN r_success,r_upd_imaa014 
END FUNCTION
################################################################################
# Descriptions...: 條碼重複檢查
# Memo...........:
# Usage..........: CALL aimm208_chk_barcode(p_barcode)
# Input parameter: p_barcode   條碼
# Date & Author..: 2016/05/18 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm208_chk_barcode(p_barcode)
   DEFINE p_barcode  LIKE imaa_t.imaa014
   DEFINE l_cnt      LIKE type_t.num5

   LET g_errno = ''
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 != g_imaa_m.imaa001
      AND imay003 = p_barcode
   
   IF l_cnt > 0 THEN
      LET g_errno = 'art-00032'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 依包裝單位和銷售計價單位取換算率
# Memo...........:
# Usage..........: CALL aimm208_imay013_default()
#                     RETURNING r_success
# Return Code....: r_success
# Date & Author..: 2016/05/18 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm208_imay013_default()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_rate        LIKE inaj_t.inaj014
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_imaa106     LIKE imaa_t.imaa106
   
   LET r_success = TRUE
   LET l_rate = ''

   LET l_success = TRUE
   
   SELECT imaa106 INTO l_imaa106
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_imaa_m.imaa001
   
   IF g_imay_d[l_ac].imay004 = l_imaa106 THEN
      LET g_imay_d[l_ac].imay013 = 1
      RETURN r_success
   END IF

   CALL s_aimi190_get_convert(g_imaa_m.imaa001,g_imay_d[l_ac].imay004,l_imaa106)
      RETURNING l_success,l_rate

   IF l_success THEN
      LET g_imay_d[l_ac].imay013 = l_rate
   ELSE
      LET r_success = FALSE
      LET g_imay_d[l_ac].imay013 = g_imay_d_t.imay013
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 